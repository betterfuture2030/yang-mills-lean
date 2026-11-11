// Provenance copy of a Claude Code workflow script used for this project.
// Local absolute paths were replaced by <repo-root>; set ROOT to your checkout to re-run.
export const meta = {
  name: 'ym-statement-review',
  description: 'Adversarial faithfulness review of the Lean Yang-Mills problem statement, with per-finding verification',
  phases: [
    { title: 'Review', detail: 'independent reviewers, each with a distinct lens' },
    { title: 'Verify', detail: 'skeptics try to refute each finding' },
  ],
}

const ROOT = '<repo-root>'
const LEAN = ROOT + '/lean/YangMills'
const SCRATCH = LEAN + '/scratch'

const COMMON = `
You are reviewing a Lean 4 + Mathlib FORMAL STATEMENT of the Clay Millennium problem "Yang-Mills existence and mass gap" (Jaffe-Witten), plus an existence-only SU(N) variant. The statement is in ${LEAN}/YangMills/{OS,Lattice,SU,Statement,OpenProblems,Sanity}.lean, with design notes in ${LEAN}/README.md. Read ALL of these files carefully first.
Context: an independent committee (Gross, Douglas, Jaffe, Klebanov, Nekrasov) is currently checking whether OpenAI's Lean formalization of Yang-Mills existence uses definitions and problem statements that "correspond with those that are standard in physics and mathematics". We want our statement to survive exactly that scrutiny.
RULES:
- READ-ONLY on ${LEAN}/YangMills/*.lean. You may create test files ONLY under ${SCRATCH}/ (mkdir -p it) and compile them with: cd ${LEAN} && export PATH="$HOME/.elan/bin:/opt/homebrew/opt/elan-init/bin:$PATH" && lake env lean scratch/<file>.lean  (they can 'import YangMills'). Use this to CONFIRM technical claims (e.g. evaluate definitions, test whether a degenerate witness typechecks, check a lemma about Mathlib conventions). Never run 'lake build' or modify lakefile/manifest.
- Each finding must be concrete: file:line, what is wrong, a concrete failure scenario (e.g. "this witness satisfies the statement but is not Yang-Mills", "this axiom as written is false for every genuine YM theory because...", "this definition evaluates to a junk value when ..."), severity (critical = statement vacuous/false/trivially-satisfiable or not the Clay problem; major = materially weaker/stronger than standard; minor = presentation/fidelity nit), and a proposed fix (Lean-level if possible).
- Do not report things already acknowledged as limitations in README.md unless you think the acknowledgement understates the severity; then say why.
- Prefer few, real, well-argued findings over many speculative ones. If you find nothing in your lens, return an empty list.
`

const FINDINGS = {
  type: 'object',
  properties: {
    lens: { type: 'string' },
    findings: { type: 'array', items: { type: 'object', properties: {
      id: { type: 'string' }, location: { type: 'string' }, severity: { type: 'string', enum: ['critical', 'major', 'minor'] },
      claim: { type: 'string' }, failure_scenario: { type: 'string' }, evidence: { type: 'string' }, proposed_fix: { type: 'string' },
    }, required: ['id', 'location', 'severity', 'claim', 'failure_scenario', 'proposed_fix'] } },
    overall_assessment: { type: 'string' },
  },
  required: ['lens', 'findings', 'overall_assessment'],
}
const VERDICT = {
  type: 'object',
  properties: {
    refuted: { type: 'boolean' },
    adjusted_severity: { type: 'string', enum: ['critical', 'major', 'minor', 'not-an-issue'] },
    reasoning: { type: 'string' },
    best_fix: { type: 'string' },
  },
  required: ['refuted', 'adjusted_severity', 'reasoning'],
}

const LENSES = [
  { key: 'os-fidelity', prompt: `LENS: FIDELITY TO OSTERWALDER-SCHRADER. Compare each axiom (OS.Normalized, OS.Growth, OS.Real, OS.Covariant, OS.Symmetric, OS.ReflectionPositive, OS.Cluster) with OS I (CMP 31, 1973) and OS II (CMP 42, 1975), Glimm-Jaffe "Quantum Physics" ch. 6 and 19, and Simon's P(phi)_2 book. Is the multilinear formulation (axioms on disjoint-support tuples, growth on all tuples, RP on ordered positive-time slab products) equivalent to, stronger than, or weaker than the standard ones? Is OS reconstruction (to Wightman fields incl. Lorentz covariance and spectral condition) actually available from these axioms? Are the conventions for the contragredient action, time reflection with the tensor representation, the order reversal in reflectAppend, the conjugation, and the cluster limit correct? Any axiom that would be FALSE for a genuine theory of composite fields with contact terms?` },
  { key: 'mass-gap', prompt: `LENS: THE MASS GAP AND NON-TRIVIALITY. Check HasMassGap: is |B_T(F,T_t G)| <= e^{-mt} B_T(F,F)^{1/2} B_T(G,G)^{1/2} on the OS pre-Hilbert space really equivalent to "spectrum of H in {0} ∪ [m,∞) with unique vacuum" after OS reconstruction? Is the truncation B(F,G) - B(F,1)B(1,G) correct (sign/conjugation conventions, the definition of Poly.one)? Is time translation in the right direction? Does restricting the field content to T_{μνκλ} = tr F_{μν}F_{κλ} make the mass gap materially weaker than the Clay mass gap (which concerns the whole Hilbert space)? Is NonTrivial adequate (it requires centred fields, nonzero 2-point at separated points, nonzero 4th cumulant)? Can a non-YM theory satisfy NonTrivial + OS + gap, and does the lattice clause exclude it?` },
  { key: 'ym-identification', prompt: `LENS: DOES THE LATTICE CLAUSE REALLY PIN DOWN YANG-MILLS? Attack IsWilsonLimit and AsymptoticScaling. Look for LOOPHOLES: choices of a_k, L_k, beta_k, Z_k (renormalization MATRICES, arbitrary) that make the lattice Schwinger functions converge to something that satisfies OS + NonTrivial (+ HasMassGap) but is NOT the Yang-Mills continuum theory (e.g. strong-coupling regime with beta_k -> infinity very slowly, ultralocal limits, free-gluon composite limits, finite-volume artifacts, using Z_k to amplify lattice artefacts or irrelevant operators, mixing to cancel physics). Conversely look for reasons the clause might be UNSATISFIABLE even if YM exists (e.g. the Riemann-sum smearing with sitePos/valMinAbs, periodic wrap-around, the requirement Tendsto beta atTop atTop, the a^4 normalization, the expectation subtraction, convergence required for ALL n simultaneously along ONE sequence, convergence for test functions whose supports are disjoint but touching at infinity, the plaquette-based field strength's O(a^2) lattice artefacts, hypercubic vs O(4) renormalization). Check the two-loop scaling formula and b0, b1 values/conventions (beta = 2N/g0^2 Wilson action) — derive them.` },
  { key: 'lean-technical', prompt: `LENS: LEAN/MATHLIB TECHNICAL CORRECTNESS AND JUNK VALUES. Hunt for definitions that silently evaluate to junk: division by zero (e.g. /d with d=0, expect when partitionFn = 0), integrals of non-integrable or non-measurable functions returning 0 (note: for a general compact G without SecondCountableTopology, are the Wilson weights measurable w.r.t. the product sigma-algebra on Link L -> G? If not, expect may be junk; is the general-G statement then vacuous or wrong?), NormedSpace.exp junk value conventions, haarMeasure ⊤ normalization, Real.rpow with negative base, Real.log of non-positive numbers in AsymptoticScaling (log(1/a) for a>1, log log), coercion issues ℝ->ℂ, the meaning of 'x 0' on EuclideanSpace, Fin.append/Fin.rev conventions, ZMod (L+1) and valMinAbs, the unitary group coercions, LinearIsometryEquiv group multiplication order vs o4Matrix_mul, tensorRep index ordering vs the field index ordering in latticeT, Matrix.kroneckerMap index type. Write small scratch Lean files that #eval/#check/prove things to confirm suspicions. Also check whether the hypotheses of ClayYangMills could be unsatisfiable (vacuity) or satisfiable by degenerate G (e.g. d=0, trivial group — is IsSimpleMatrixLieAlgebra then false?).` },
  { key: 'clay-comparison', prompt: `LENS: COMPARISON WITH THE OFFICIAL CLAY PROBLEM AND COMMUNITY STANDARDS. Fetch and read the official Jaffe-Witten problem description (claymath.org, "Quantum Yang-Mills Theory" PDF) and, if available, Michael R. Douglas's Lean formalization work on the Osterwalder-Schrader axioms / Gaussian free field (search GitHub, e.g. "OSforGFF") and any other public Lean/Isabelle formalization of QFT axioms (PhysLean). Also check OpenAI's public Lean repos (openai/ten-proofs, openai/math) for how they phrase physics/analysis statements. Then judge: does our ClayYangMills capture "for any compact simple gauge group G, a non-trivial quantum Yang-Mills theory exists on R^4 and has a mass gap Delta>0", with "axiomatic properties at least as strong as" Wightman/OS? Where is it weaker, where stronger, where merely different? What would a skeptical committee member (Jaffe, Douglas) object to first? Suggest the top changes that would most increase acceptance.` },
  { key: 'red-team-trivial-proof', prompt: `LENS: RED TEAM — TRY TO PROVE OR DISPROVE THE OPEN THEOREMS CHEAPLY. Act as an adversary (e.g. an AI system optimizing to close the sorry). Try hard to find a way to prove ClayYangMills, SUNExists or SUNExistsWithMassGap WITHOUT doing any real physics: exploit junk values, vacuous hypotheses, degenerate sequences, Lean definitional quirks, choosing Z_k = 0 for some components, choosing test-function classes for which nothing is tested, using that IsWilsonLimit only constrains compactly supported disjoint tuples while OS axioms constrain other tuples, or using the freedom of S on non-disjoint tuples. Similarly try to DISPROVE them cheaply (show the statement is false for a reason unrelated to Yang-Mills, e.g. an axiom inconsistent with the lattice clause, or Growth impossible because the lattice convergence forces some bound to fail). Use scratch Lean files to test any exploit. Report every exploit that works or nearly works.` },
]

phase('Review')
const reviewed = await pipeline(
  LENSES,
  (l) => agent(COMMON + '\n' + l.prompt, { label: `review:${l.key}`, phase: 'Review', schema: FINDINGS }),
  (r, l) => r ? parallel((r.findings || []).filter(f => f.severity !== 'minor' || (r.findings || []).length <= 6).map(f => () =>
    agent(`${COMMON}\nYou are a SKEPTICAL VERIFIER. A reviewer (lens: ${l.key}) reported the finding below about the Lean Yang-Mills statement. Try to REFUTE it: read the cited code, check the math/physics carefully, and if useful write a scratch Lean file to test. Default to refuted=true if the claim does not hold up or is already handled/acknowledged adequately. If it is real, give the best concrete fix (Lean-level).\nFINDING:\n${JSON.stringify(f, null, 2)}`,
      { label: `verify:${l.key}:${f.id}`, phase: 'Verify', schema: VERDICT }).then(v => ({ ...f, lens: l.key, verdict: v })))) .then(vs => ({ lens: l.key, overall: r.overall_assessment, results: vs.filter(Boolean), minor_unverified: (r.findings || []).filter(f => f.severity === 'minor' && (r.findings || []).length > 6) })) : null,
)

const all = reviewed.filter(Boolean)
const confirmed = all.flatMap(x => x.results.filter(f => f.verdict && !f.verdict.refuted))
const refuted = all.flatMap(x => x.results.filter(f => f.verdict && f.verdict.refuted))
log(`${confirmed.length} findings survived verification; ${refuted.length} refuted`)
return { overall: all.map(x => ({ lens: x.lens, overall: x.overall })), confirmed, refuted: refuted.map(f => ({ id: f.id, lens: f.lens, claim: f.claim, why: f.verdict.reasoning })), minor_unverified: all.flatMap(x => x.minor_unverified) }
