// Provenance copy of a Claude Code workflow script used for this project.
// Local absolute paths were replaced by <repo-root>; set ROOT to your checkout to re-run.
export const meta = {
  name: 'ym-research-library',
  description: 'Build a verified research library on 4D quantum Yang-Mills existence/mass gap, OpenAI methods, and Lean infrastructure',
  phases: [
    { title: 'Research', detail: 'one deep-research agent per workstream, writes a note + downloads arXiv PDFs' },
    { title: 'Verify', detail: 'adversarial citation and claim checker per note' },
    { title: 'Index', detail: 'dedupe bibliography, build INDEX.md + references.bib' },
    { title: 'Critic', detail: 'completeness critic: what is missing' },
  ],
}

const ROOT = '<repo-root>'
const NOTES = ROOT + '/library/notes'
const PDFS = ROOT + '/library/pdfs'

const COMMON = `
CONTEXT (read carefully):
- Today is 2026-11-05. Your training data may end before mid-2026; events after that (OpenAI's claimed Navier-Stokes result of Sept 2026, its claimed Yang-Mills existence proof with a Lean formalization dated 16 Oct 2026, the shepherding committee chaired by David Gross with Douglas, Jaffe, Klebanov, Nekrasov, and the openai/ten-proofs and openai/math GitHub repos) MUST be researched from live sources, not memory.
- We are building a research library for a long-horizon attempt to prove existence (and ideally mass gap) of 4D quantum Yang-Mills theory for compact simple gauge group G, and to formalize the statement and eventually the proof in Lean 4 + Mathlib.
- Project root: ${ROOT}. Write ONLY inside ${NOTES} (your note) and ${PDFS} (downloaded PDFs). Do not touch anything else.
TOOLS: Use WebSearch and WebFetch (load them with ToolSearch "select:WebSearch,WebFetch" if they are deferred). For arXiv you may also use the alphaXiv MCP tools (search with ToolSearch "alphaxiv" or "discover_papers get_paper_content") for reading papers — but NEVER call any tool that modifies the user's alphaXiv library/folders/follows. Use Bash with curl for arXiv metadata checks: curl -s "http://export.arxiv.org/api/query?id_list=<ID>".
PDF LIBRARY: Download open-access arXiv PDFs of the 5-15 most important papers in your workstream: curl -sL -A "ym-research-library/0.1" "https://arxiv.org/pdf/<ID>" -o "${PDFS}/<ID with / replaced by _>.pdf" (sleep 3 seconds between downloads; skip if file already exists; only arxiv.org; never execute anything downloaded). Do not download paywalled publisher PDFs.
HONESTY RULES (critical):
- Never invent a reference. Every reference you list must be one you have confirmed exists (arXiv API, DOI/publisher page, or a reliable catalog). If you recall a paper but cannot confirm it, list it with verified=false and say so.
- Distinguish clearly: established theorem / claimed-but-unverified result / folklore or heuristic / known-false or disputed claim.
- Quote nothing longer than ~15 words from any source; summarize in your own words.
NOTE FORMAT: Write a thorough markdown note (aim 2,500-6,000 words, more if the material warrants) at ${NOTES}/<KEY>.md with sections: Summary; Key definitions/statements (precise math where relevant, LaTeX ok); Detailed findings; What is proven vs open (a table); Relevance to a 4D YM existence + mass-gap proof and to Lean formalization; Open questions / leads; References (numbered, with arXiv IDs/DOIs/URLs and a verified flag).
Your final structured output summarizes the note and lists every reference.
`

const REF_ITEM = {
  type: 'object',
  properties: {
    authors: { type: 'string' }, title: { type: 'string' }, year: { type: 'string' },
    venue: { type: 'string' }, arxiv: { type: 'string' }, doi: { type: 'string' }, url: { type: 'string' },
    relevance: { type: 'string' }, verified: { type: 'boolean' }, pdf_downloaded: { type: 'boolean' },
  },
  required: ['authors', 'title', 'year', 'relevance', 'verified'],
}
const NOTE_SCHEMA = {
  type: 'object',
  properties: {
    key: { type: 'string' },
    note_path: { type: 'string' },
    summary: { type: 'string' },
    key_findings: { type: 'array', items: { type: 'string' } },
    proven_vs_open: { type: 'array', items: { type: 'string' } },
    open_questions: { type: 'array', items: { type: 'string' } },
    references: { type: 'array', items: REF_ITEM },
  },
  required: ['key', 'note_path', 'summary', 'key_findings', 'references'],
}
const VERIFY_SCHEMA = {
  type: 'object',
  properties: {
    key: { type: 'string' },
    refs_checked: { type: 'number' },
    refs_confirmed: { type: 'number' },
    refs_corrected: { type: 'array', items: { type: 'string' } },
    refs_removed_or_flagged: { type: 'array', items: { type: 'string' } },
    claim_corrections: { type: 'array', items: { type: 'string' } },
    residual_concerns: { type: 'array', items: { type: 'string' } },
    references: { type: 'array', items: REF_ITEM },
  },
  required: ['key', 'refs_checked', 'refs_confirmed', 'references'],
}

const STREAMS = [
  { key: '01-problem-definition', brief: `THE PRECISE PROBLEM. Obtain and analyze the official Clay Millennium problem description by Jaffe and Witten ("Quantum Yang-Mills Theory", claymath.org) and Michael Douglas's 2004 Clay status report on the problem. Write out in full precise mathematical form: (i) the Wightman axioms (Streater-Wightman) and (ii) the Osterwalder-Schrader axioms (OS I 1973 and the corrected OS II 1975 including the linear growth condition E0'), (iii) the OS reconstruction theorem, (iv) what Jaffe-Witten require for the theory to count as "Yang-Mills" (gauge-invariant local fields, e.g. Tr F wedge F type operators; short-distance behaviour consistent with asymptotic freedom / perturbation theory; nontriviality), (v) the precise meaning of the mass gap (spectrum of the Hamiltonian / mass operator in (0, Delta) empty on the orthogonal complement of the vacuum; Euclidean equivalent: exponential clustering of truncated Schwinger functions of gauge-invariant observables), (vi) any ambiguities or choices in the statement (which fields; distributional vs bounded observables like smeared Wilson loops; whether Euclidean or Minkowski; finite vs infinite volume), (vii) known weaker/stronger variants (e.g. Glimm-Jaffe axioms, Haag-Kastler nets, Seiler's lattice formulation, Chatterjee's probabilistic formulation in "Yang-Mills for probabilists"). Include Glimm-Jaffe "Quantum Physics" and Streater-Wightman as references. This note is the backbone for a Lean formal statement, so be maximally precise and flag every place where a formalizer must make a choice.` },
  { key: '02-openai-ym-claim', brief: `OPENAI'S YANG-MILLS CLAIM AND THE SHEPHERDING COMMITTEE. Find and read every primary source: OpenAI blog post(s) announcing Yang-Mills existence (and the related QCD, ETH, Kakeya claims), the committee's 1st and 2nd statements (2nd dated Nov 3 2026), the committee's rules and procedures document (possibly https://www.kitp.ucsb.edu/sites/default/files/YM_working_group.pdf), and credible press (Quanta, Scientific American, Nature, Science, NYT). Extract: exactly what is claimed (existence only? mass gap? which gauge groups? which axioms? QCD claim details), timeline (natural-language proof 9 Sep 2026, QCD 18 Sep, Lean formalization 16 Oct per reports — verify), how the proof was produced (models, agents, compute), any technical hints about the method (e.g. Balaban-style renormalization group, stochastic quantization, lattice continuum limit, gauge fixing), statements by experts, the committee's verification process and release schedule. Clearly mark what is confirmed by primary sources vs. press speculation.` },
  { key: '03-openai-navier-stokes-method', brief: `OPENAI'S NAVIER-STOKES AGENT-SWARM METHODOLOGY (for guiding HOW to use AI, not the math). Read primary and high-quality sources: OpenAI's own blog/technical report on the Navier-Stokes result (Sept 2026), Scientific American "The inside story behind OpenAI's million-dollar math proof", Quanta "AI Has Solved One of Math's $1 Million Millennium Prize Problems", CNBC, CoinDesk, Tufts Daily, any arXiv/technical report, talks or tweets by the researchers involved, and the relation to the Buckmaster/Alpöge Euler blow-up work it reportedly built on. Extract in detail: number and roles of agents; group structure and communication topology; message volume and token budget; tools (cached internet, code execution, numerics, computer-assisted proof, interval arithmetic); how the search was seeded (starting from the Euler proof); how candidate arguments were verified internally; how the Lean formalization was done (separate model? 17 hours?); human involvement; failure modes and criticisms (scope dispute over forcing; priority dispute). End with a section "Transferable design principles for an AI swarm attacking 4D Yang-Mills", concrete and actionable.` },
  { key: '04-openai-github-proofs', brief: `OPENAI'S PUBLISHED PROOF REPOSITORIES (for guiding methodology and Lean hygiene). Inspect directly on GitHub (use WebFetch on github.com pages and raw.githubusercontent.com, or gh api via Bash if available: gh api repos/openai/<repo>/contents) the repos openai/ten-proofs and openai/math (verify exact names), plus OpenAI's post "Sharing AI progress in mathematics" and analyses (Ken Ashe blog 2026-10-07, developersdigest, the-decoder, smartscope). Extract: repo layout; Lean/Mathlib versions; how formal STATEMENTS are separated from PROOFS and reviewed; use of Comparator (what it is, how configured, what it checks); axiom audits (#print axioms), sorry policy; how natural-language manuscripts are paired with Lean; the 'families' structure (719 manuscripts / 372 families?); what fraction formalized; quality critiques (statement-faithfulness gaps, vacuous definitions, reliance on custom axioms). End with "Lessons for formalizing a 4D Yang-Mills statement and proof", including a checklist the committee would apply.` },
  { key: '05-balaban-program', brief: `BALABAN'S RENORMALIZATION-GROUP PROGRAM FOR 4D LATTICE YANG-MILLS AND RELATED CONSTRUCTIVE GAUGE THEORY. Cover Tadeusz Balaban's Commun. Math. Phys. series 1983-1989 (propagators and renormalization transformations for lattice gauge theories; averaging operations; spaces of regular gauge field configurations and gauge fixing; variational problem and background fields; renormalization group approach to lattice gauge field theories I and II; convergent renormalization expansions for lattice gauge theories; small-field and large-field analysis; ultraviolet stability results), Jonathan Dimock's expository arXiv series "The renormalization group according to Balaban" (I, II, III) and related Dimock papers (QED, scalar QED), Balaban-Imbrie-Jaffe on Higgs models, Magnen-Rivasseau-Seneor "Construction of YM4 with an infrared cutoff" (CMP 1993), Federbush's phase-cell papers on Yang-Mills, King, Gross-King? Precisely state what Balaban proved (UV stability: bounds on the effective actions/partition function uniform in lattice spacing in finite volume?), and exactly what remains to reach (a) continuum limit of gauge-invariant correlation functions in finite volume, (b) infinite volume limit, (c) OS axioms incl. rotation invariance restoration, (d) mass gap. Assess why the program stalled and what pieces could plausibly be completed with massive (AI) effort. Note page counts of Balaban's papers (relevant to ~1000-page proof-size estimates).` },
  { key: '06-stochastic-quantization-2d-3d', brief: `STOCHASTIC QUANTIZATION AND THE 2D/3D CONTINUUM YANG-MILLS FRONTIER. Cover: 2D Yang-Mills measure (Gross-King-Sengupta, Driver, Sengupta, Thierry Lévy, Chevyrev "Yang-Mills measure on the two-dimensional torus as a random distribution"); Chandra-Chevyrev-Hairer-Shen ("Langevin dynamic for the 2D Yang-Mills measure", "Stochastic quantisation of Yang-Mills-Higgs in 3D"); Chevyrev-Shen ("Invariant measure and universality of the 2D Yang-Mills Langevin dynamic", uniqueness of gauge covariant renormalisation); Cao-Chatterjee ("A state space for 3D Euclidean Yang-Mills theories", Yang-Mills heat flow with random initial data); Hairer's regularity structures and the critical/supercritical barrier in 4D; any 2023-2026 results constructing the 3D Yang-Mills measure or proving 3D existence; Bringmann, Cao, Shen, Zhu, Zhu-Zhu; Gubinelli et al. For each: what is proven, what technique, why it fails or what is needed in 4D (criticality, asymptotic freedom, log divergences, need for Balaban-type multiscale analysis). Identify the strongest current frontier result toward d=3 and d=4.` },
  { key: '07-lattice-rigorous-results', brief: `RIGOROUS LATTICE GAUGE THEORY RESULTS RELEVANT TO EXISTENCE AND MASS GAP. Cover: Wilson 1974; Osterwalder-Seiler 1978 (reflection positivity of Wilson action, strong-coupling confinement and mass gap); Seiler's Lecture Notes in Physics 159 (1982); Guth and Fröhlich-Spencer (Coulomb phase of 4D U(1)); Göpfert-Mack (3D U(1) confinement); Chatterjee (strongly coupled SO(N) lattice gauge theory at large N; Wilson loops in Ising LGT; "Yang-Mills for probabilists"; a scaling limit of SU(2) lattice YM-Higgs); Jafarov; Basu-Ganguly; Cao (Wilson loops with finite gauge groups); Adhikari-Cao (correlation decay / mass gap for finite gauge groups); Forsström-Lenells-Viklund; Shen-Zhu-Zhu (stochastic analysis / Bakry-Emery approach to lattice YM at strong coupling, mass gap); Adhikari-Suzuki-Zhou-Zhuang; Cao-Park-Sheffield random surfaces; Cao-Nissim-Sheffield (expanded regimes of area law); master loop equations (Chatterjee; Basu-Ganguly); Durhuus-Frohlich; disputed claims such as Tomboulis 2007 on SU(2) confinement. State precisely the coupling regimes in which mass gap / exponential decay / area law are proven, and the gap between strong-coupling results and the weak-coupling (beta -> infinity) regime required by the continuum limit.` },
  { key: '08-constructive-qft-and-renormalization-tools', brief: `CONSTRUCTIVE QFT TOOLKIT AND 4D NON-PERTURBATIVE RENORMALIZATION. Cover: Glimm-Jaffe construction of phi^4_2, phi^4_3 (Glimm-Jaffe 1973, Feldman-Osterwalder 1976, Magnen-Seneor), Gross-Neveu_2 (Gawedzki-Kupiainen 1985; Feldman-Magnen-Rivasseau-Seneor 1986) as the prototype of a constructed asymptotically free theory; Gawedzki-Kupiainen massless lattice phi^4_4 and block-spin RG; Brydges-Yau, Brydges-Fröhlich-Spencer, Bauerschmidt-Brydges-Slade RG book (LNM 2242, 2019) and finite-range decompositions; polymer/cluster expansions; Aizenman-Duminil-Copin marginal triviality of phi^4_4 (2021) and implications (nontriviality in 4D requires asymptotic freedom); Hairer and Gubinelli-Hofmanova phi^4_3; Lüscher's Yang-Mills gradient flow and Lüscher-Weisz all-orders renormalization of flowed observables (key for defining finite continuum observables); renormalization of Wilson loops (perimeter divergence, cusp anomalous dimension); OS reconstruction specifics for gauge theories (gauge-invariant observables, reflection positivity, Fröhlich-Morchio-Strocchi, Strocchi's books); Gribov/Singer obstructions to global gauge fixing. For each, state precisely what is proven and what lesson transfers to 4D YM.` },
  { key: '09-mass-gap-mechanisms', brief: `PHYSICAL AND HEURISTIC MECHANISMS FOR THE MASS GAP AND CONFINEMENT, ASSESSED AS PROOF STRATEGIES. Cover: asymptotic freedom (Gross-Wilczek, Politzer) and dimensional transmutation; lattice Monte Carlo evidence (Creutz; glueball spectrum, Morningstar-Peardon; SU(N) large-N lattice results, Teper; Lucini); 't Hooft large N; Feynman 1981 on 2+1 YM; Karabali-Kim-Nair Hamiltonian 2+1 approach; Polyakov monopole mechanism and Göpfert-Mack rigorous version; Seiberg-Witten confinement by monopole condensation in N=2; center vortices; dual superconductivity; Gribov-Zwanziger; Witten's remarks in the Clay description; Nekrasov/Douglas/Klebanov related work; holography (Witten 1998 thermal AdS, Klebanov-Strassler) as heuristics; resurgence/semiclassics on R^3 x S^1 (Unsal-Yaffe). For each mechanism, assess: is there any known rigorous partial result; what mathematical statement would a proof via this route require; how plausible is it as a route to a rigorous 4D mass gap. Distinguish clearly existence (UV problem) from mass gap (IR problem).` },
  { key: '10-lean-mathlib-infrastructure', brief: `LEAN 4 / MATHLIB INFRASTRUCTURE FOR STATING AND PROVING 4D YANG-MILLS EXISTENCE. Investigate current (late 2026) Mathlib and adjacent projects by reading the actual sources on GitHub (leanprover-community/mathlib4; use WebFetch on github and the Mathlib docs at leanprover-community.github.io/mathlib4_docs): SchwartzMap and tempered distributions (is there a TemperedDistribution type? Schwartz kernel? nuclear spaces?), Fourier transform, Haar measure and compact groups, Lie groups (LieGroup, ModelWithCorners), Lie algebras (LieAlgebra.IsSimple, Killing form), matrix groups SU(n) (Matrix.specialUnitaryGroup), Lorentz group, Minkowski space; Hilbert spaces, unbounded operators, self-adjointness, spectral theorem/functional calculus status, strongly continuous unitary groups / Stone's theorem; measures on infinite-dimensional spaces, Bochner-Minlos; Kolmogorov extension; PhysLean (formerly HepLean); Michael R. Douglas's Lean formalization of the Gaussian free field and Osterwalder-Schrader axioms (search e.g. "OSforGFF" or Douglas Lean QFT formalization 2025-2026); any Lean formalization of Wightman axioms or OS reconstruction; leanblueprint tooling; Comparator; the openai/ten-proofs build setup. For each needed concept give the exact Mathlib declaration names (verified by fetching docs/source) and gaps that must be built. Estimate the size of the missing infrastructure.` },
  { key: '11-recent-frontier-2023-2026', brief: `RECENT RESEARCH FRONTIER (2023-2026) ON RIGOROUS YANG-MILLS. Systematically sweep arXiv (math-ph, math.PR, hep-th, hep-lat) and Google Scholar for 2023-2026 papers on: construction of Yang-Mills in 3D or 4D, Yang-Mills measure, Wilson loop expectations, mass gap, area law, gauge theory stochastic quantization, Balaban program continuation, gradient-flow based definitions, lattice-to-continuum limits, and surveys (e.g. Chevyrev survey on stochastic quantization of YM; Shen survey; Chatterjee survey; Hairer ICM/abel lectures). Also catalogue recent CLAIMED solutions of the Millennium problem (e.g. arXiv 2506.00284 "A Constructive Proof of Existence and Mass Gap for Pure SU(3) Yang-Mills in Four-Dimensional Space-Time" and others) and assess their credibility honestly (most such claims are flawed; explain the typical failure). Also look for any expert technical commentary since Sept 2026 on what an OpenAI Yang-Mills proof would likely need to contain. Produce a chronological table.` },
]

phase('Research')
const results = await pipeline(
  STREAMS,
  (s) => agent(`${COMMON}\nYOUR WORKSTREAM KEY: ${s.key}\nNOTE PATH: ${NOTES}/${s.key}.md\n\nTASK: ${s.brief}\n\nBe exhaustive and precise. Spend real effort reading primary sources.`,
    { label: `research:${s.key}`, phase: 'Research', schema: NOTE_SCHEMA }),
  (r, s) => r ? agent(`${COMMON}\nYou are an ADVERSARIAL VERIFIER for the research note ${NOTES}/${s.key}.md (workstream: ${s.key}).
Your job: assume the author may have hallucinated references or overstated results. Read the note in full. Then:
1. For EVERY reference, confirm existence and metadata: arXiv IDs via curl -s "http://export.arxiv.org/api/query?id_list=<ID>" (check title+authors match), DOIs via curl -s "https://api.crossref.org/works/<DOI>", URLs via WebFetch. Fix wrong IDs/years/titles. If a reference cannot be confirmed, mark it [UNVERIFIED] in the note or remove it if clearly fabricated.
2. Check the 10 most important mathematical/factual claims in the note against sources (e.g. "Balaban proved X", "Adhikari-Cao proved mass gap for finite groups at weak coupling", "OpenAI claimed Y on date Z"). Correct overstatements, especially any that blur proven vs. claimed vs. heuristic.
3. Edit the note IN PLACE to apply corrections, and append a section "## Verification log" listing what you checked, corrected, and any residual concerns.
4. Do not download new PDFs except to replace a mis-ID'd one. If a PDF in ${PDFS} has the wrong content for its ID, delete only that file.
Return the full corrected reference list.
Author's structured summary for context: ${JSON.stringify({ summary: r.summary, n_refs: (r.references || []).length })}`,
    { label: `verify:${s.key}`, phase: 'Verify', schema: VERIFY_SCHEMA }).then(v => ({ research: r, verify: v, key: s.key })) : null,
)

const ok = results.filter(Boolean)
log(`${ok.length}/${STREAMS.length} workstreams researched and verified`)

phase('Index')
const allRefs = ok.flatMap(x => ((x.verify && x.verify.references) || x.research.references || []).map(ref => ({ ...ref, stream: x.key })))
const index = await agent(`You are building the library index for ${ROOT}/library.
Inputs: the verified notes in ${NOTES}/*.md (read them all) and this merged reference list (JSON, possibly with duplicates across streams):
${JSON.stringify(allRefs).slice(0, 180000)}
TASKS:
1. Deduplicate references (same arXiv ID / DOI / title). Write ${ROOT}/library/references.bib (BibTeX; keys like Balaban1985a; include arxiv eprint, doi, url; add a note field "UNVERIFIED" where verified=false).
2. List the PDFs present in ${PDFS} (ls) and map them to bib keys.
3. Write ${ROOT}/library/INDEX.md: purpose of the library; a table of the notes with one-paragraph summaries; a thematic reading map (problem statement -> constructive QFT background -> Balaban -> lattice results -> stochastic quantization -> mass gap mechanisms -> Lean infrastructure -> AI methodology); the deduplicated bibliography grouped by theme with verified flag and local PDF link if present; a "most important 25 papers" list with why.
Return a short JSON-like text summary: counts of refs, verified refs, PDFs, and the top-25 list.`, { label: 'index', phase: 'Index' })

phase('Critic')
const critic = await agent(`You are a COMPLETENESS CRITIC for a research library on proving existence and mass gap of 4D quantum Yang-Mills (Clay problem), plus OpenAI's AI methodology and Lean infrastructure. Read ${ROOT}/library/INDEX.md and skim every note in ${NOTES}. Identify: (a) important published works or results missing (be specific: authors, title, year, why it matters) — check by searching, do not guess; (b) claims in notes that still look wrong or overstated; (c) workstreams that are thin; (d) open factual questions about OpenAI's YM claim that matter for planning. Write your report to ${ROOT}/library/notes/99-completeness-critique.md and return it as text (prioritized list).`, { label: 'critic', phase: 'Critic' })

return {
  streams: ok.map(x => ({ key: x.key, summary: x.research.summary, refs: (x.verify && x.verify.references || []).length, confirmed: x.verify && x.verify.refs_confirmed, corrections: x.verify && x.verify.claim_corrections, concerns: x.verify && x.verify.residual_concerns, open_questions: x.research.open_questions })),
  failed: STREAMS.filter(s => !ok.find(x => x.key === s.key)).map(s => s.key),
  index,
  critic,
}
