# Plan v0.2: an independent proof of 4D Yang–Mills existence, and a capped attack on the mass gap

*2026-11-05. Supersedes v0.1. v0.1 was critiqued by five expert-lens reviews (AI agents; separately prompted instances of the same model),
saved as `plan/critique-*.md`: constructive QFT, mass gap, AI orchestration, Lean formalization,
and feasibility/skeptic. Inputs: `PROBLEM.md`, the Lean statement package `lean/YangMills`
(v0.2, adversarially reviewed, non-vacuity proved), and the research library `library/`
(11 AI-cross-checked notes, a completeness critique, 121 PDFs).*

---

## 0.0 Honest odds

Read this first.

The existence programme is a **long-shot option** on top of a portfolio of durable deliverables.
It is not a schedule.

At a sustained budget of about 10¹⁰ output tokens per year (one to three saturated workflows,
plus two or three part-time expert consultants), the modal outcome after 12 months is:

* a published, audited Lean statement of the problem;
* a Comparator-replayed audit of OpenAI's release;
* 10–30k lines of Mathlib-quality infrastructure (Haar bi-invariance, SU(N) facts,
  Osterwalder–Seiler reflection positivity of the Wilson action, the transfer matrix, polymer
  expansions);
* part of Dimock's φ⁴₃ formalized;
* audit contributions to the public AI-generated 3D manuscripts;
* a written analysis of Bałaban's coupling flow.

Subjective probabilities, re-estimated at every stop-rule checkpoint (§6). The full table is in
`critique-feasibility-skeptic.md` §1.2.

| Milestone | 12 months, sustained budget | 36 months, sustained budget |
|---|---|---|
| Statement published + audit kit + replays | ~95% | — |
| Clean-room `SUNExists` (M7c), Comparator-checked | **≤1%** | **3–8%** |
| `SUNExists` via **Bridge** (OpenAI theorem ⇒ ours, in Lean) | 60–80% *if* their statement implies ours up to bookkeeping; ≤10–15% otherwise | — |
| 4D mass gap (M9) | <0.1% | <0.5% |

Why clean-room existence is this low *even granting the premise*:

1. The closest Claude-based effort (Sussman–Alpöge, with domain experts) has not finished the
   natural-language proof of a *weaker* 4D target after about 8 weeks and about 61k raw pages.
2. Our `SUNExists` is *stronger* than that target and probably stronger than OpenAI's (§1).
3. The Lean layer is 10⁵–10⁶ lines that do not exist anywhere.
4. Base-model strength dominated the Navier–Stokes success (Brown: organisation <10% of the
   credit), and we are not running OpenAI's internal model.

## 0.1 What the premise gives us, and what it does not

**Premise (Peter, 2026-11-05):** OpenAI's claimed proof of 4D quantum Yang–Mills existence, and
its Lean formalization, are correct.

It **implies**:
* *OpenAI's* existence theorem is true and provable at roughly 1,147 natural-language pages.
  The scope is unknown; the page count may include QCD.
* A Bałaban-type multiscale RG on Wilson's lattice can be carried "all the way to infinite
  distances" without a mass gap.
* The pipeline is robust enough to handle fermions.

It does **not** imply:
* that *our* `SUNExists` is provable without new infrared mathematics (§1);
* anything about the mass gap, which OpenAI and the committee say remains open.

We also cannot match OpenAI's compute. Our own capacity is roughly 10⁸ output tokens per day
for one saturated workflow, versus about 1.3×10¹¹ for the Navier–Stokes stage.

## 1. Targets

### 1.1 Final targets (frozen candidates, `lean/YangMills`)

* `ClayYangMills`
* `ClayExistence`
* `SUNExists`
* `SUNExistsWithMassGap`

`SUNExists` bundles two genuinely **infrared** clauses that a Bałaban UV analysis plus compactness
does not deliver:

1. **Full O(4) covariance.**
2. **The cluster property**, which here is the same as uniqueness of the vacuum of the
   *periodic-torus* limit. `IsWilsonLimit` allows no boundary conditions, so a periodic limit is
   a translation-invariant *mixture*, and its ergodic components are not periodic limits.

We therefore split the existence target. The splits are already in the Lean package, with the
ordering `SUNExists → M7b → M7a` proved.

| Rung | Content | Lean |
|---|---|---|
| **M7a** | all of `IsYangMillsTheoryAlong` except cluster, with hypercubic covariance only | `SUNExistsM7a` |
| **M7b** | plus full O(4) | `SUNExistsM7b` |
| **M7c** | plus cluster | `SUNExists` |

M7a is the realistic UV-plus-compactness target. M7b and M7c are infrared research. **Only M7c
(or `ClayExistence`) counts as the existence part of Clay**, because Jaffe–Witten require a
unique vacuum. A component formulation (`IsWilsonComponent`: ergodic components of Wilson limits)
is a candidate alternative for M7c. It is **decided only after the A4 comparison with OpenAI's
statement.**

### 1.2 The ladder (Lean-first, not natural-language-first)

| Rung | Formal target | Role |
|---|---|---|
| M0 | final targets above | frozen *after* the skeleton exists (§4, week 4) |
| M1 | non-vacuity | **mostly done**: `su_connected`, `su_lieAlgebra_simple` and `su_mass_gap_of_clay` are proved. Open: `os_nonTrivial_fullField_consistent` (free Maxwell composites) |
| M2 | finite-lattice foundations: gauge invariance; Osterwalder–Seiler reflection positivity of the Wilson action on `ZMod n` (n even and odd); transfer matrix | infrastructure |
| M3½ | Gaussian U(1)₄ lattice → free-Maxwell composites (21 channels); `¬ShortDistanceAF` as a regression | calibrates the observable layer and `IsWilsonLimit`; shares algebra with M1 |
| M4★ | 4D **bounded-field** multiscale RG on T⁴, carrying the running coupling and a Θ-source; two-loop flow; ⟨ΘΘ⟩ fingerprint inside the model | the first rung that carries the 4D-specific risk (the marginal coupling) |
| M6½ | `SUNExists`/M7a **conditional on Bałaban's published theorems** as explicitly named `Published…` hypotheses (the OpenAI `openai/math` pattern) | conditional milestone; shows what remains |
| M5 | 4D generating functional of vacuum-subtracted composites, analytic in sources uniformly in ε and L; full large-field control (Bałaban's ℝ operation, or the chessboard/RP alternative) | core of existence |
| M6 | T⁴: subsequential continuum limit; `NonTrivial`, `FullFieldContent`, `ShortDistanceAF`; E0′; short-distance O(4) | existence in finite volume |
| M6.5 | `T³_ℓ × ℝ`, small ℓ: OS in time, unique vacuum, gap uniform in ε | the first genuine Hilbert space and gap |
| M7a / M7b / M7c | as in §1.1 | infinite volume |
| M8 | 3D lattice/continuum gap rungs | mass-gap research |
| M9 | 4D mass gap | Clay |

Removed from the Lean critical path: 2D YM (M3) and the full YM₃ continuum limit (M4). Each
survives only as an optional audit or contribution (§2.6).

## 2. Mathematical programme

### Track A: statement, bridges, release audit

* **A0. Pre-register now,** before OpenAI's release. *Not achieved:* the v0.2.0 statement was
  completed on 6 Nov, but its Zenodo deposit followed the committee's 10 Nov release of OpenAI's
  Lean code, so it is not a pre-registration. The statement-file hashes are listed in the paper;
  later versions are published with a diff and reasons.
  * Timestamped hash, labelled *candidate*, with every known deviation from Clay in both
    directions (`PROBLEM.md` §4.1).
  * Offer upstream to `google-deepmind/formal-conjectures`, which has no YM file. **Needs
    Peter's OK; it is outward-facing.**
* **A1. Expert sign-off.** One or two constructive-QFT referees review the statement. They get a
  20-page packet, not the repository.
* **A2. Close M1:** free-Maxwell composites, via a lattice Proca/Gaussian route that needs no
  measures on 𝓢′.
* **A3. Continuum assembly layer (C0).** This is new and on the critical path. It is the
  functional analysis that turns uniform lattice bounds plus convergence on disjoint compact
  tuples into a `Schwinger` family with E0′:
  * Hahn–Banach extension;
  * the Taylor-vanishing lemma;
  * reduction to compact supports.

  Bridges to OSreconstruction come later and off-path.
* **A4. Release-day audit kit,** scripted and rehearsed.
  * `#print axioms` and a sweep for every hypothesis structure. **First question: does OpenAI's
    proof re-prove Bałaban, or assume him?**
  * Linux `lake comparator --paranoid` replay.
  * Clause-by-clause diff against our statement.
  * Attempt `theirs ⇒ ours` and `ours ⇒ theirs` in Lean (`YMBridges/`).
* **A5. Replays.** Linux `--paranoid` replays of OSforGFF, OSreconstruction, `lgt` and
  `openai/math` family 215 (`ClassicalON`). These validate the base layer and rehearse A4.

### Track B: foundations, demand-driven by the skeleton

Infrastructure is built only when a skeleton node needs it:

* Haar bi-invariance on compact groups, and gauge invariance of `linkMeasure`;
* `Matrix.det_exp` in general (we proved it only for skew-Hermitian matrices);
* SU(N) exp/log charts with explicit radii;
* Osterwalder–Seiler reflection positivity;
* the transfer matrix;
* Schwartz n-fold tensor products with seminorm bounds;
* polymer expansions (Kotecký–Preiss, BKAR);
* random-walk/Neumann expansions;
* finite Gaussian integrals;
* kernel-checked rational-interval certificates (no `native_decide`, which Comparator's
  three-axiom gate rejects).

Upstream to Mathlib where possible.

### Track C: ultraviolet (Bałaban), the critical path to M7a

* **C1. Primary sources first.**
  * Download Bałaban CMP 89–122 (Project Euclid, open access).
  * Two independent transcriptions of key pages (gate **G-Lit**).
  * **Check the "unpublished Theorem 2" claim** (CMP 109, 122 p. 355) before anything rests on
    it (stop rule SR1).
  * Blueprint the *interfaces* of CMP 95–102 first.
* **C2. Pilot: Dimock φ⁴₃ part I** (52 pp) in Lean. This is the first formal verification of a
  Bałaban-method RG step, and it calibrates throughput (stop rule SR3).
* **C3. Coupling flow, two-loop** (`SUNExists` hard-codes `b₁`; the alternative is a decision
  to drop `b₁` from `AsymptoticScaling` before any M7 freeze).
  * C3a: `b₀`, `b₁` in Bałaban's scheme, as symbolic certificates.
  * C3b: remainder bounds.
  * C3c: fixed-point choice of `g₀(N)` with a marginal direction.
  * C3d: lower stability bound.
* **C5. Sources and composite operators** (under-scoped in v0.1).
  * C5a: Θ as an inhomogeneous coupling.
  * C5b: `T_μν` with Ward normalization.
  * C5c: the (2,0)⊕(0,2) flow.
  * C5d: the topological density.
  * C5e: the ℝ operation for source terms.
  * C5f: short-distance bounds with n insertions, for E0′.
* **C6. Bridge from effective densities to lattice Schwinger functions.**
  * Subsequential limits on T⁴.
  * `ShortDistanceAF`, `NonTrivial` and `FullFieldContent` from one-loop dominance plus D0 plus
    the P-track kernels.
  * Short-distance O(4), including tuning of the hypercubic sub-irrep `Z`s.
  * Cauchy-in-N moves to an optional M6⁺.
* **P-track (new, critical path): perturbation theory with certificates.**
  * `b₀`, `b₁` in our scheme.
  * One-loop anomalous dimensions of the four O(4) channels.
  * The leading 21×21 two-point kernel (block-diagonal by tree-level conformality, shared with
    M1).
  * The constant C in `ShortDistanceAF` and the trace-anomaly normalization.

### Track D: infinite volume without a gap

* **D0. Volume-uniform locality.** Generating-functional bounds for local observables, uniform in
  ε **and** in torus size. This is an unchecked property of Bałaban's estimates and the first
  thing to establish.
* **D1.** Infinite-volume limit points of the **fine** periodic Wilson measures at each ε.
  A diagonal subsequence then gives **M7a**. No claim that the limits commute, and no
  uniqueness.
* **D-RP.** Audit Sussman–Alpöge's "RP O(d) trick" (RPM1).
  * Check its preconditions (moment bounds, diagonal RP) against our limits.
  * Run the product-Gaussian and Φ⁴₃ tests.
* **D2 (M7b, O(4) at all distances).** Routes:
  1. UV universality plus uniqueness;
  2. the RP mechanism;
  3. stress-tensor Ward identities;
  4. whatever A4 reveals.

  Kill or continue monthly.
* **D3 (M7c, cluster).** Either vacuum uniqueness for the periodic limit, or the component
  formulation. Choose after A4.
* **D-RT.** Infrared obstruction red team, applying the Constantin–Ignatova–Vicol move to
  Track D.

### Track E: the mass gap, a capped research portfolio

**Budget:** ≤10% of tokens until a Tier-2 milestone lands. Full text in
`critique-mass-gap.md` §6.

* **Sanity filters (encoded as Lean negative tests where cheap).** An argument must not:
  * work for 4D U(1);
  * prove confinement for finite groups or SO(3);
  * violate the θ=π anomaly;
  * use only `b₀ > 0` (Banks–Zaks);
  * contradict the 3D inverted-U(1) behaviour;
  * contradict the all-volume cap O1.
* **Obstruction O1 (new).** Every finite-size criterion that is uniform over *all* volumes and
  boundary conditions is capped at O(1) bare coupling in 4D. A height-one slab of SU(2) links is
  exactly the 3D O(4) model, which orders. So finite-size certificates must be **cube-restricted**
  (Martinelli 1998).
* **The crossover is the real problem.** At the last RG-controlled scale the correlation length
  in block units is about `exp(1/(2b₀ḡ²))`, so no box certifies anything there. "RG then
  finite-size criterion" only relocates the problem.
* **Tier 0** (infrastructure; about 2%):
  * replays of `lgt`, `markov-semigroups` and `ClassicalON`;
  * frozen gap-ladder statements;
  * the bridge lemma `UniformRenormalizedClustering ⇒ HasMassGap`;
  * negative tests;
  * cheap formal wins: `lgt` → SU(N), Chatterjee 2021, the Durhuus–Fröhlich/CNS reduction,
    Chatterjee 2026.
* **Tier 1** (calibration; about 4%), each with a measurable kill criterion:
  * E1.A: family 215 statement audit and mechanism memo.
  * E1.B: computer-assisted calibration. Push Ebel–Kennedy–Rychkov past β=0.2 in 2D Ising.
    Certify all-volume SU(2) thresholds past the Shen–Zhu–Zhu and CNS values with kernel-checked
    certificates. Kill if <2× improvement or >10³ CPU-hours per certificate.
  * E1.C: a heuristic falsification lab (adversarial cube boundary conditions; Kogut–Susskind
    exact diagonalization in 2+1D).
* **Tier 2** (milestone theorems):
  * **E2.A, the lattice twisted-island theorem.** Weak-coupling clustering on `ℝ²×T²` with
    't Hooft flux, uniform in β and volume. The perturbative spectrum is completely gapped there,
    and Balaban–Brydges–Imbrie–Jaffe-type technology may suffice. This would be the first
    weak-coupling clustering theorem for a continuous non-abelian lattice gauge theory in 4D
    geometry. **Start in Phase 1.**
  * E2.B: twisted `T³×ℝ`.
  * E2.C: the continuum island.
  * E2.D: a 3D cube-certified gap.
* **Tier 3** (moonshots; ≤3% per quarter): the L2 crossover lemma (multiscale Bakry–Émery,
  rigorous tensor RG, step scaling, master-loop bounds); annealed Durhuus–Fröhlich; the
  center-stabilized `ℝ³×S¹`.
* **Never** label a lattice-only, island or finite-volume result a "mass gap" (the family-215
  anti-pattern).

## 3. AI operating model

### 3.1 Design axioms

These follow the AI-orchestration critique, and the evidence in notes 03 and 04.

1. **The compiled Lean skeleton is the coordination substrate.** Each rung theorem is proved in
   Lean from ≤30 module contracts (named `Prop`s). The reduction always compiles, with no `sorry`
   and no axioms. Prose is a view generated from it.
2. **Agents read contracts, never other nodes' proofs.** Context packs are ≤60k tokens, so
   bounded-context agents can work on a 1,000+ page proof.
3. **Mechanical checks first, LLM judgement second, the kernel last and decisive.** LLM skeptics
   are a **rejection filter, not an acceptance gate**:
   * verdicts must be specific and falsifiable;
   * skeptics are blind (they never see the prover's reasoning trace);
   * skeptics are cross-model where possible;
   * skeptics are calibrated by seeded canaries (target recall ≥80%).
4. **Agents are short-lived and task-scoped; state lives on disk** (git, `claims.db`). There are
   no long-lived coordinators.
5. **Swarms only where the decomposition is unknown.** Use 2–4 Explore groups of 4–8 agents on
   the genuinely creative bottlenecks: D2 (O(4)), D3 (cluster), C6 (convergence with a pinned
   marginal coupling), and Track E Tier 2.

### 3.2 Roles

* **Architect:** the only role that changes interfaces. Every change needs a decision record.
* **Decomposer:** splits a node after 2 failures.
* **NL prover:** writes ≤3 pages against the children's contracts.
* **Lean statement writer:** writes the statement plus unit tests and a vacuity `example`.
* **Lean prover:** proves the node; never edits contracts.
* **Blind skeptic.**
* **Falsifier / numerics:** Arb/python-flint, SymPy, small-lattice code.
* **Consistency sweeper:** checks one invariant per run.
* **Alignment / hypothesis-diff agent.**
* **Cheating auditor.**
* **Importer:** brings public AI manuscripts in as `cited-unverified` nodes.
* **Literature verifier:** two independent transcriptions per primary-source leaf.
* **Statement red team:** runs at every rung freeze.
* **Simplifier / expositor.**
* **Daily reporter:** replaces the consolidator for proof state.
* **Humans:** do rung sign-offs and make portfolio and budget calls. Never on the per-node path.

### 3.3 Artifacts

* `blueprint/` (leanblueprint, with LeanArchitect generating it from Lean).
* `defs/registry.yaml`: every definition has an ID, a Lean declaration and unit tests.
* `constants.yaml`: constants ranked by choice order, with acyclicity checked in CI.
* Per-node **lemma contracts**: statement, Lean L0 statement, required and provided constants,
  children, falsification tests, risk, size budget, status, provenance.
* `claims.db`, which generates `alignment.yaml` and `formalization.yaml` (with an honest review
  status).
* `refuted/`, `FREEZE.log`, per-rung scope notes, and a public correction log.

### 3.4 Gates, in order

| Gate | Pass condition |
|---|---|
| G-Skel | rung theorem proved in Lean from ≤30 module contracts |
| G-Def | registry change carries an equivalence proof, or re-runs G-Skel |
| G-Mech | numeric, scaling, vacuity and ledger checks pass |
| G-L0 | contract statement compiles against frozen definitions; unit tests pass |
| G-NL | ≥1 blind skeptic (≥2 with cross-model for high-risk nodes) gives no specific objection |
| G-L1 | Lean proof from children's L0 statements; axiom cone ⊆ the standard three plus declared children |
| G-L2 | module sorry-free; overview ≤20 pp |
| G-L3 | `lake comparator --paranoid --json` in a Linux bwrap sandbox against the frozen rung |
| G-Human | expert sign-off |
| G-Lit | two transcriptions agree with the primary page |

### 3.5 Metrics

These replace "Lean lines/week":

* critical-path burndown (sorry-cone of each rung, risk-weighted);
* skeptic recall on canaries;
* false-accept rate, i.e. G-NL passes later refuted (ground truth);
* cost per L0 and L1 node;
* rework rate;
* interface churn;
* NL→Lean statement drift;
* duplicate-work rate;
* literature-hypothesis burndown;
* human agreement with G-NL.

### 3.6 Budget allocation, first 20 weeks

| Line | Share |
|---|---|
| Lean statements, skeletons, Track B | 30% |
| L1 proofs (rising to about 35% later) | 15% |
| Verification (skeptics, G-Mech, sweeps, alignment, canaries) | 15% |
| Construction on critical-path nodes (C3, C5, C6, D) | 15% |
| Import and audit of public AI–Bałaban corpora (Sussman–Alpöge, Aronow–Lopatto) | 8% |
| Explore groups | 7% |
| Calibration and ablations | 4% |
| Statement red teams + exposition | 6% |
| Track E | ≤5–10% (cap) |

### 3.7 What we take from OpenAI's Navier–Stokes swarm and repos, and what we don't

**We take:**
* freeze an adversarially reviewed target first (Comparator);
* a portfolio of formulations, then concentrate on what works;
* a seeding ladder;
* distillation between groups;
* Lean as the source of truth, with an alignment map;
* `formalization.yaml`, scope notes, `Published…` conditional hypotheses, `--paranoid`
  replays, and correction logs;
* provenance by construction.

**We don't take:**
* 10⁴-agent scale. Organisation earned <10% of the credit. Our leverage comes from targeting,
  reusing others' compute, and kernel gates.
* Announcing a proof nobody on staff understands. Readability is a gate (G-L2).
* Letting the challenge drift to match the solution (the CM-Hodge pattern).

## 4. Phases

Stretch schedule; the honest odds are in §0.0.

| Phase | Weeks | Deliverables | Exit gate |
|---|---|---|---|
| 0 | 0–4 | Publish v0.3 with a diff against v0.2.0. A4 kit rehearsed on the A5 replays. Package split into `YMSpec` (trusted) and `YMProof`. Comparator on Linux with a negative test. Skeleton v1 (`Interfaces.lean` + `Reduction.lean` for M7a and M6½). Five spikes: C0 assembly, the d-generic lattice core, Osterwalder–Seiler RP, rational-interval certificates, Lie charts. Bałaban primary-source check. Calibration ablations. | Comparator works end to end; skeleton compiles axiom-clean; spikes have cost estimates; Peter plus ≥1 expert sign off on the open spec decisions (two-loop vs one-loop; component formulation); **then** freeze spec v1.0 |
| 1 | 4–12 | C0 complete; M1 closed; M2; one φ⁴₃ RG step in Lean; certified `b₀`; D0 formulation; D-RP audit; E0 and E2.A started; import of the Sussman–Alpöge QED₃/YM₃ overviews | Closure rate measured; projection to M6½ within budget (SR3) |
| 2 | 12–30 | M6½ (conditional `SUNExists`/M7a under a separately labelled "conditional" Comparator config); C3 two-loop; YM `Ind k` step lemmas | M6½ accepted |
| 3+ | 30– | Discharge the Bałaban interfaces (M5, M6); M7a; then D2/D3 for M7b/M7c | Frontier shrinking at the planned rate |
| ∞ | parallel | Track E within its cap | per-route kill criteria |

## 5. Independence policy

**Definitions:**
* **Clean-room:** no artefact in our proof tree derives from OpenAI's release. Attested by
  provenance logs and a published dependency-graph comparison.
* **Bridge:** our frozen statement, proved in Lean from OpenAI's released theorem plus our
  bridge lemmas. Labelled "conditional on OpenAI's certificate".
* **Consume:** study the release and produce a re-derived, simplified, human-readable proof and a
  Lean refactor. Labelled "independent re-derivation", never "independent discovery".

**Phase I (until release + 14 days):** clean-room by necessity, since nothing is public.

**At release + 14 days (SR0), Peter chooses the mix.** The recommended default:
* Bridge and Consume for existence;
* clean-room only where independence has specific value (Bałaban's coupling flow, the IR step),
  at a capped budget.

**Leakage controls for clean-room work:**
* separate repositories and sessions;
* no web access; corpus frozen and hashed before release;
* model IDs pinned and logged;
* Peter does not read solution modules (if he does, it is logged and the affected artefacts lose
  the clean-room label);
* audit findings cross the wall only as `theirs ⇒ ours` / `ours ⇒ theirs` / a clause-difference
  list.

Current models' training cutoff (June 2026) predates the 9 Sep proof.

## 6. Stop rules

| ID | Trigger | Rule |
|---|---|---|
| SR0 | Release + 14 days | Decide the Clean-room / Bridge / Consume mix. If `theirs ⇒ ours` is proved and their Lean is unconditional, stop clean-room existence work beyond a capped line, if wanted. |
| SR1 | Week 2 | If the primary text does not confirm the Theorem-2 gap, re-scope C3 before spending >5% of budget. |
| SR2 | Week 8 or 5×10⁸ tokens on C3 | No calibrated `b₀` derivation with remainder bounds → suspend 4D Track C; keep infrastructure and audits. |
| SR3 | Week 12 | Measure closed nodes per 10⁸ tokens on the φ⁴₃ pilot. If extrapolation to M5–M7 exceeds 36 months at the funded tier, descope Lean for M5–M7. |
| SR4 | Continuous | Canary recall <80–90%, or an expert finds an error in a gate-accepted node → freeze acceptances and re-audit the downstream closure. |
| SR5 | Monthly | Hard spend cap. 50% spent with nothing beyond M2 Comparator-closed → stop and report. |
| SR6 | Monthly | Track E over its cap, or a route that fails a sanity filter or goes 2 cycles without a frozen sub-lemma → kill it. |
| SR7 | Event | A complete public YM₄ manuscript (Sussman–Alpöge or other) → switch Tracks C/D to verification and contribution. |
| SR8 | Event | Firewall breach → affected artefacts are not clean-room. |

## 7. Ethics and community

* **Contact Sussman–Alpöge before any C/D production work.** Track D is essentially their YM₄
  "C/K" modules. Their README invites collaboration, and contributing audits (QED₃, RPM1 in Lean,
  YM₃_I definitions ledger) is high value and shared credit.
* **Respect the committee's process.** No outreach that pressures its members. Note its
  conflict-of-interest bars on participants' outside YM research.
* **Disclose AI use** (meeting AGMAI's disclosure expectations) in every artefact. Provenance logs
  are published with any result.
* **No press releases.** Results go through arXiv plus code, after Comparator *and* human review.
  Cite prior programmes generously (Bałaban, Dimock, Sussman–Alpöge, Aronow–Lopatto, Douglas et
  al.).

## 8. Decisions needed from Peter (one consolidated ask)

1. **Budget tier.** Shoestring (≤2×10⁹ tokens/yr), sustained (1–3×10¹⁰, the default
   assumption), or NS-scale (about 10¹¹).
2. **Human experts.** Whether to recruit one or two constructive-QFT referees (paid, part-time)
   and one Track E referee. This is the largest accelerator, and the committee's own standard.
3. **Independence mix at SR0.** Bridge/Consume by default, or clean-room.
4. **Outward-facing actions.** Submitting the statement upstream (formal-conjectures); contacting
   Sussman–Alpöge; any public posting. Each needs an explicit OK.
5. **Spec decisions before the v1.0 freeze:**
   * two-loop vs one-loop `AsymptoticScaling`;
   * whether a component formulation can stand for cluster;
   * whether to add a C-odd field multiplet.

## 9. Next actions

Executable now without outward-facing steps:

1. Package split (`YMSpec`/`YMProof`); clear lint warnings; a `comparator.json` for each target;
   Audit golden-file CI.
2. Skeleton v1: `Interfaces.lean` + `Reduction.lean` proving `SUNExistsM7a` from named interface
   `Prop`s (C0, UVTorus, D0/D1, AFTwoPoint, FullContent, CouplingFlow₂). Red-team every
   interface.
3. A5 replays (locally on macOS first; Linux bwrap when available).
4. Download Bałaban CMP papers and Dimock's φ⁴₃ trilogy into `library/pdfs/`; two-transcriber
   check of the Theorem-2 pages.
5. Spikes: C0 assembly (Hahn–Banach + Taylor vanishing), Osterwalder–Seiler RP for the Wilson
   action.
6. Prepare the A4 release-day kit (OpenAI's Lean release was then expected "hopefully" the week of 9 Nov; it came on 10 Nov).
