# Critique of PLAN.md v0.1: the Lean formalization lens

*Reviewer lens: Tracks A and B, and the Lean side of Track C. Written 2026-11-05.*

*Read for this review:* `plan/PLAN.md`, `PROBLEM.md`, `README.md`, every file in `lean/YangMills/YangMills/*.lean`, the lakefile, manifest and CI workflows, and the library notes. Notes 10, 04, 03 and 05 were read in depth; 99 was read for its Lean items, and 02 and 11 were consulted.

*How each claim is sourced:*
- **[local]**: checked in this repo against the pinned `v4.36.0-rc2` toolchain. All checks were read-only: `lake env lean`, `lake comparator --help`, `lake check --help`, and grep of the pinned Mathlib `9d581dff`.
- **[gh]**: checked today through the GitHub API.
- **[note N]**: taken from library note N.
- **[I]**: my own inference.

No project file other than this report was modified.

---

## Verdict in brief

1. **The plan's instincts are right; its Lean architecture does not exist yet.** It has the right instincts: a Mathlib-only frozen target, Comparator as the gate, Lean as the source of truth, and infrastructure from day one. But it has **no Lean architecture**: no module boundaries, no interface theorems, and no account of how the existence proof will produce the object the spec demands (a `Schwinger ι4` family of continuous multilinear maps on all of 𝓢 satisfying E0′).

2. **The highest-value change is a top-down, compiled skeleton.** Build it from `SUNExists` downwards in weeks 1–4. Every unproved step becomes a named `Prop`, and the reduction is proved with no `sorry` and no axioms. Merely writing it exposes **three spec/route mismatches** that the plan would otherwise carry into the v1.0 freeze:
   - `IsWilsonLimit` allows only periodic-torus Gibbs states, so it cannot be met by Track D's ergodic-decomposition route to the cluster axiom E4.
   - `SUNExists` requires two-loop asymptotic scaling (the `b1` term), while C3 is scoped to one loop.
   - The functional-analytic layer that turns lattice limits into a `Schwinger` family with E0′ is on the critical path and appears in no track.

3. **The rung ladder is a natural-language ladder, not a Lean one.**
   - M3 (2D YM) is off-path for Lean.
   - M4 (3D YM) in Lean is roughly as large as the 4D target.
   - The spec is hardwired to d = 4.
   - Freezing internal rungs spends human review where a machine-checked composition proof is the right control.

4. **The Phase-1 KPI is two orders of magnitude too low.** "≥500 Lean lines/week" compares with a job of roughly 3–5 million lines.

5. **"Heavy reuse" of external libraries is overstated.** OSforGFF, OSreconstruction, lgt, physlib and gaussian-field are all off the existence critical path, and all sit on older toolchains. Mine them; do not depend on them.

6. **Comparator and freeze mechanics need hardening.** The needed changes are export-based challenges, a spec/proof package split, a fix for the clash between `lake check` and `sorry`, Linux runners, and a Mathlib bump policy.

7. **Engineering is unplanned.** A build farm, caches, file-size caps and heartbeat caps are missing. At 10⁶ lines, engineering becomes the binding constraint.

---

## 1. What is excellent and must be kept

- **The trusted statement is small, Mathlib-only and definitions-only.** It is about 850 lines; every `sorry` sits in one file; there are no custom axioms. This matches the best OpenAI practice: short Mathlib-only challenges (ten-proofs) and the NS `Model.lean` style. It avoids the worst practice: the 262-file CM-Hodge challenge that was edited to match its solution [note 04 §3.3, §6.1].
- **`Sanity.lean` holds proved inhabitants, counter-inhabitants and regressions.** The trivial theory satisfies `OSAxioms` and `HasMassGap` and fails `NonTrivial`. The regression lemma `exists_spatial_ne_zero` guards the v0.1 cluster bug. `partitionFn_pos` guards the junk value of division by zero. I re-ran `Audit.lean`: the sanity theorems use exactly `propext`, `Classical.choice`, `Quot.sound`, and the open targets add `sorryAx` [local]. Keep this file and extend it (L10).
- **The lattice clause is finite-dimensional.** Every lattice object is a Haar integral over a finite product (`Measure.pi`), and the continuum limit is a limit of numbers, not of measures. This is the single design decision that makes the proof Lean-tractable. Exploit it further: no measures on 𝓢′ are needed anywhere on the existence path (L4, L8).
- **The mass gap is Euclidean,** via the truncated RP form. This avoids the unbounded spectral theorem, which Mathlib lacks [note 10 §2.7], and makes the operator-gap bridge optional.
- **The review culture, P1 and P6.** That means:
  - adversarial statement review, with every degenerate witness becoming a regression test;
  - Comparator with the three standard axioms;
  - "Lean is the source of truth";
  - a hypothesis-diff agent.

  Keep all of it, but implement P6 differently (L11).
- **Track B "from day one".** The principle is right; only the target list is wrong (L9).
- **C3 as the first small, decisive computation.** Keep it, but its Lean scope must grow (L3, L12).
- **The independence firewall with a statement-level audit (A4).** Keep it, and add the mechanics (§2, L16).

---

## 2. Criticisms, in priority order, each with a revision

### L1 — CRITICAL: there is no top-down Lean skeleton; the blueprint is built bottom-up from the corpus

**What is wrong.** The pieces of the plan do not meet in the middle:
- C1 transcribes Balaban and Dimock into leanblueprint.
- Track B builds infrastructure on its own.
- The §3.2 cycle starts from "open blueprint nodes".

Nothing connects the frozen M0 statement to the nodes derived from the corpus.

Navier–Stokes shows what happens next: the natural-language proof came first and the Lean was written afterwards. The Lean then proved *different* intermediate lemmas: (8.19) needs m+5 derivatives instead of m+4, and (10.19) was proved by another route [note 03 §6.3; note 04 §3.4; arXiv:2610.08144].

Balaban's material is further from our spec than the NS paper was from its Lean. The two set-ups differ on every axis:

| | Balaban's papers | Our spec |
|---|---|---|
| Lattice | the torus `(L^{-N}ℤ/L^Mℤ)^d` with odd block size L [note 05 §2.1] | `Site L = Fin 4 → ZMod (L+1)` |
| Observables | only the partition function [note 05 §5.2] | vacuum-subtracted, renormalized `tr F F` composites |
| Limits | | one joint sequence: a → 0 and aL → ∞ |
| Output | | multilinear Schwinger functions |

The adapter between these two set-ups is substantial mathematics. Under the current plan it would be discovered at the very end.

**Revision.** Insert into §2, ahead of Track A:

> **A0. Top-down Lean skeleton (weeks 1–4, then continuous).**
> - **Interfaces.** Before any corpus node is opened, write `YMProof/Interfaces.lean`. Every unproved step from `SUNExists N` down to Balaban's RG inductive hypothesis is a named `def … : Prop`, with a docstring and a LeanArchitect `@[blueprint]` tag.
> - **Reduction.** Write `YMProof/Reduction.lean`, proving `theorem sunExists_of_interfaces : Interfaces N → SUNExists N` with **no `sorry` and no axioms**.
> - **Blueprints.** The project blueprint is *generated* from these Lean declarations. Corpus transcription (C1) produces a separate *source map*; project nodes cite source nodes but are never identified with them.
> - **Change control.** Any change to an interface `Prop` must keep `Reduction.lean` compiling. A node is "done" when its `Prop` is proved and the reduction still compiles.

**Why `Prop`s rather than `sorry` or `axiom`:**
- `lake check` rejects any non-standard axiom, including `sorryAx` [local help], so a `sorry` anywhere in the default targets turns CI permanently red.
- A project `axiom` is global, and pphi2 had at least four helper axioms that turned out false as stated [note 10 §2.10].
- Interfaces as hypotheses are the pattern used by `openai/math` (`Published…` structures) and by Douglas's Seiberg–Witten postulates [note 04 §3.3; note 10 §2.10].
- With `Prop` interfaces, `#print axioms` gives an exact, machine-checked meaning to "proved modulo the frontier".

**The one real risk, and its mitigation.** A *false* interface makes the reduction vacuous, because `False → anything` holds. So every interface `Prop` gets three checks before work starts on it:
- a refutation attempt by the red team;
- a model-instance satisfiability check where one makes sense (free field, small lattices);
- mechanical vacuity and numerical checks [Mei–Douglas, arXiv:2610.20573].

### L2 — CRITICAL: spec/route mismatch 1, `IsWilsonLimit` versus ergodic decomposition

**What is wrong.** The two halves do not fit:
- **The spec.** `IsWilsonLimit` requires S to be the limit of `latticeSchwinger P (L k) (a k) (β k) (Z k)`. These are **periodic-torus** Gibbs states with vacuum subtraction on the torus [local: `Lattice.lean`].
- **Track D, step 4.** It obtains E4 "by decomposing the translation-invariant RP state into clustering (ergodic) components."
- **The gap.** A component of a mixture is in general *not* a limit of periodic-torus states. Periodic boundary conditions produce the symmetric mixture. So the route yields an S with `OSAxioms ∧ NonTrivial ∧ …` but without `IsWilsonLimit`. **`SUNExists` is then unreachable by the planned route.**

Sussman–Alpöge's Target Theorem A has exactly this shape: "an ergodic component of a volume-first subsequential" limit [note 05 §3.9]. Our frozen statement would reject it, and possibly OpenAI's result too.

**Revision.** Add an item to Phase 0, "decide before freezing v1.0", with three options:

> **(a) Weak target.** Add `IsWilsonLimitComponent`: there are a Wilson limit W and a measurable decomposition W = ∫ S_ω dμ(ω) such that μ-almost every S_ω satisfies the clustering clauses, and S is such an S_ω. State the theorem in "∀ᵐ ω" form, so that no fake measure-zero component can be inserted.
> - Cost: a larger trusted base (Bochner integrals of multilinear-map-valued families).
> - Add a sanity theorem showing the fake-component attack fails.
>
> **(b) Strong target.** Keep the clause and re-scope Track D to prove clustering of the periodic limit itself. Say plainly that this is close to an IR uniqueness theorem.
>
> **(c) Both.** Keep `SUNExists` (strong) and add `SUNExistsComponent` (weak) as separate challenges.

**Lean consequences, whichever option is chosen:**
- **Avoidable machinery.** The spec needs only *numbers*: limits of torus Schwinger functions. Track D step 3 ("infinite-volume Gibbs states … DLR") should become *uniform-in-volume torus bounds plus diagonal extraction*. That avoids DLR, Gibbs specifications and `Measure.infinitePi`, all absent or thin in Mathlib [note 10 §2.8].
- **Unavoidable machinery for option (a).** Decomposition at the level of OS states needs Choquet theory or direct integrals, which Mathlib lacks. Decomposition of lattice measures needs an ergodic-decomposition theorem. Mathlib has `Measure.condKernel` but, as far as I can grep, no ergodic decomposition. Budget 10–50k lines [I], or pick option (b).

### L3 — CRITICAL: spec/route mismatch 2, `SUNExists` demands two-loop scaling, but C3 is one-loop

**What is wrong.** `AsymptoticScaling N a β` requires

  β/(2N) − 2b₀ log(1/a) − (b₁/b₀) log log(1/a) → c   [local: `Statement.lean`].

Take a = L^{-k}. The condition holds only if the per-step coupling recursion carries
- the exact one-loop coefficient 2b₀ log L,
- the exact two-loop coefficient 2b₁ log L,
- and an O(g⁴) remainder. The remainder is then summable, since g_k⁴ ~ k⁻².

C3 is scoped to "the one-loop term … recover b₀ … bound the remainders". An O(g²)-accurate remainder leaves the log log coefficient uncontrolled. **C3 as scoped cannot close the frozen `SUNExists`.** A kernel-certified two-loop computation in Balaban's block-spin scheme is plausibly the hardest *computational* node in the project [I].

By contrast, `ShortDistanceAF` needs only the one-loop running coupling, plus a certified leading-order composite correlator.

**Revision.** Before the freeze, either:

> **(i) Split the target.**
> - M7a: `SUNExists₁` with one-loop scaling, (β/(2N))/log(1/a) → 2b₀ (or β/(2N) − 2b₀ log(1/a) = O(log log(1/a))).
> - M7b: the current two-loop statement.
>
> **or (ii) Widen C3** to read: "one- and two-loop coefficients of the coupling recursion in Balaban's scheme, extracted analytically from the small-momentum behaviour and certified in the kernel (L12), with an O(g⁴) per-step remainder; plus the leading term of ⟨tr F² tr F²⟩ for `ShortDistanceAF`."

When OpenAI releases, record in A4 whether *their* statement contains two-loop scaling.

### L4 — CRITICAL: the continuum assembly layer is missing, and A3 is mis-filed and mis-sized

**What the spec forces on any proof** [local: `OS.lean`, `Lattice.lean`]:
- `Schwinger ι4` is a family of `ContinuousMultilinearMap`s on **all** of `𝓢(E4, ι4 → ℂ)ⁿ`.
- `OS.Growth` requires, for each n, a distribution Tₙ on configuration space `𝓢(Fin n → E4, (Fin n → ι) → ℂ)` with the E0′ bound, agreeing with Sₙ on disjointly supported products.
- Real, Covariant, Symmetric and RP are imposed on *arbitrary* disjointly supported Schwartz tuples, not only on compactly supported ones.
- `IsWilsonLimit` gives convergence **only on compactly supported, disjointly supported tuples.**

So the proof must contain a generic, Yang–Mills-independent theorem. Roughly:

> *Assembly.* Suppose limit values are given on compactly supported, disjoint tuples. Suppose they obey a kernel bound with at most polynomial singularities at coincident points and translation-invariant decay, uniformly like (n!)^β, together with the identities inherited from the lattice. Then there is an `S : Schwinger ι4` that satisfies the corresponding OS clauses and agrees with the limits.

Its parts are:
1. **Tensor products of Schwartz functions.** An n-fold product map, as a `ContinuousMultilinearMap` with an explicit seminorm bound. It is absent from the pinned Mathlib [local grep]. gaussian-field's `schwartzTensorEquiv` is a real-valued, two-factor Hermite isomorphism on `EuclideanSpace ℝ (Fin (m+1))` [gh], so it has the wrong shape. A direct Leibniz-rule proof is likely simpler [I].
2. **A Taylor-vanishing lemma.** It turns kernel bounds that are singular on the diagonals into a Schwartz-seminorm bound on 𝓢₀.
3. **Hahn–Banach extension.** It is available as `Module.Dual.exists_extension_of_le_seminorm` [local].
4. **Reduction to compact supports.** Use cutoffs together with the continuity of Sₙ, for the equational axioms and for RP.
5. **Cluster for non-compact tuples.** This needs *translation-invariant* bounds: the E0′ seminorm grows like λᵏ under translation by λa. This is a requirement on the analytic output of Tracks C and D, and the plan must write it down.

**A3 is a different thing.** With our E0′ formulation, Tₙ is *part of the axiom*. So A3(a) needs only a density lemma (the span of disjoint products is dense in 𝓢₀), **not** nuclearity or the Schwartz kernel theorem; this corrects note 10 §2.2.

A3(b) (the OSreconstruction bridge) and A3(d) (the operator gap) validate the statement. They are **not on the existence path**. Note 10 §4.2 sizes these bridges at 5–20k human lines, or 20–100k at AI density, which contradicts "Track A (small)".

**Revision.**

> **C0 (critical path, weeks 2–10). Continuum assembly layer,** `YMProof/Continuum/Assembly.lean`, with items 1–5 above. Acceptance: it is applied end to end to the free-field calibration M1′ (L6).
>
> Move **A3 to a new "Track V: statement validation"**, run in parallel at lower priority and budgeted at 20–100k lines:
> - (a) density of disjoint products in 𝓢₀;
> - (b) a scalar-channel bridge to OSreconstruction across toolchains (L8);
> - (d) Euclidean gap ⇒ operator gap (optional).

### L5 — HIGH: the freeze protocol and Comparator set-up are incomplete

Ten problems, each with its fix:

1. **A file hash does not freeze the statement's meaning.** Meaning depends on the toolchain, the Mathlib commit, the lakefile `leanOptions` (ours sets `maxSynthPendingDepth = 3` and `relaxedAutoImplicit = false`) and the import closure.
   - *Fix:* FREEZE.log records SHA-256 of (spec sources, `lean-toolchain`, `lake-manifest.json`, `lakefile.toml`) **and of the challenge export**, the NDJSON produced by `leanexport`.
2. **The solver's project is part of the trust base.** Comparator's documented assumptions trust the project's lakefile, manifest and dependencies [note 04 §2.1]. A proof repo that pinned a forked Mathlib would build both challenge and solution against the fork.
   - *Fix:* every acceptance run uses `lake comparator --challenge-from-export=<export built once, on a clean machine, from YMSpec at the frozen commit>` [local help confirms the option].
3. **The package layout is not Comparator-ready.** The theorem names must coincide, but the solution may never import the challenge. Today `OpenProblems.lean` mixes the four M0 targets, the three M1 obligations and two proved theorems, and `YangMills.lean` imports it.
   - *Fix:* split into two packages.
     - `YMSpec`: definitions plus `Sanity`, as default targets.
     - `YMSpec/Challenge/{Existence,MassGap,NonVacuity}.lean`: *not* default targets. Each has a `comparator.json` with `definition_names: []`, `permitted_axioms` set to the standard three, and `external_kernels: {"nanoda": …}`.
4. **`lake check` and `sorry` clash.** `lake check` replays the default targets and errors on non-standard axioms [local help], so it would reject the current package (`sorryAx` via `OpenProblems`). The proof repo must therefore be `sorry`-free in its default targets at all times, which L1's `Prop`-interface design achieves.
   - *Fix:* also add a CI job that runs `Audit.lean` and diffs its output against a committed golden file. Today the audit is not built by any CI job.
5. **The sandbox is Linux-only.** It uses `bwrap`; only `.lake` is writable, and only dependency resolution gets network access [local help]. macOS `--inadvisably-no-sandbox` is for smoke tests only. Two things need checking in week 1:
   - Ubuntu 24.04 runners may need unprivileged user namespaces enabled for `bwrap` [I, to verify].
   - Whether the sandboxed build fetches the Mathlib cache or rebuilds 2.35M lines on every clean run. This decides the cost of each acceptance run.
6. **`--json` is missing from our toolchain.** Note 04 rule 6 recommends `--json`, but our `v4.36.0-rc2` `lake comparator` has no such flag [local help].
   - *Fix:* archive the exit code and stdout until the toolchain is bumped.
7. **"Pinned" and "bump Mathlib" contradict each other.** P8 says pinned; the risk table says bump. Even our 850-line spec already uses a deprecated lemma, `ContinuousLinearMap.zero_apply` (`Sanity.lean:80`) [local], so it will break on a bump.
   - *Fix:* adopt this policy.
     - The spec stays at one (toolchain, Mathlib) pair for its lifetime.
     - The proof bumps only to stable releases, on a fixed cadence (every 8–12 weeks or at rung boundaries), through a bump agent.
     - Every bump re-exports the challenge and diffs the transitive declaration closure of the target statements. Any changed constant needs human review before the bumped challenge supersedes the frozen one.
     - Disable `.github/workflows/update.yml` (`mathlib-update-action`) in the spec repo.
8. **Elaboration settings.** Set `autoImplicit = false` in the spec lakefile; all six spec files elaborate cleanly with `-DautoImplicit=false` [local]. Remove the existing linter and deprecation warnings before freezing, so that `warningAsError` can be used, as in the NS repo [note 03 §4.6].
9. **Kernel choice and timing.** Run nanoda on every acceptance run, and `--paranoid` (five extra kernels) only at freeze points. Measure the times.
10. **Small hygiene.**
    - Delete `Basic.lean` (`def hello := "world"`).
    - Move the `IsProbabilityMeasure haarG` instance from `Sanity.lean` into `Lattice.lean`; every proof will need it.
    - Reconcile G-NL "3/3 sign-off" with the cycle's "majority".

**Revision (§1 and §7.2).** Replace "SHA-256 hash recorded in `plan/FREEZE.log`" with item 1 above. Replace "Set up Comparator plus CI" with items 2–6 and 9.

### L6 — HIGH: the rung ladder suits natural language, not Lean

**(a) Freeze only what will be claimed.** Freezing every rung (§1) spends adversarial review on internal statements that soundness does not depend on: if an internal rung is wrong, the cost is wasted effort, not a false theorem. The right control for an internal rung is the machine-checked reduction to M7 (L1).
- Freeze, review and run Comparator only on M0, M1, and any rung *claimed as a standalone result*: M4, M8, and M6½ below.

**(b) The spec is hardwired to d = 4.** `E4`, `Site L = Fin 4 → …`, `ι4` and `tensorRep` are all four-dimensional [local], so M3, M4 and M8 cannot be stated with these definitions. Choose one:
- refactor the spec to be dimension-generic **before v1.0**, with a lemma that the d = 4 instance is the current statement up to `rfl`; or
- accept that M3, M4 and M8 need new trusted statements, each with its own review.

**(c) Drop M3 from Lean.** 2D YM in Lean needs character expansions, the heat kernel on G and Peter–Weyl, all absent from Mathlib [note 10 §2.3]. It calibrates machinery that Balaban's route does not use.

**(d) M4 in Lean is not a warm-up.** The AI manuscripts run to 857 + 1,201 pp (Sussman–Alpöge) and about 1,479 pp (Aronow–Lopatto) [note 05 §3.9]. That is the same order as the target, and it contradicts P3's 1% warm-up budget. In Lean, only instantiate the dimension-generic RG modules at d = 3, as regression tests.

**(e) Split M2.**
- **M2a, on the existence path:**
  - gauge invariance, including invariance of the *measure*, which needs Haar bi-invariance;
  - Osterwalder–Seiler RP for the reflection the spec actually induces (L9);
  - lattice symmetries acting on `latticeSchwinger`.
- **M2b, Track E only:**
  - the transfer matrix as a compact positive operator on L²(G^{spatial links}), which needs Hilbert–Schmidt theory, absent from Mathlib [note 10 §2.7];
  - the finite-volume gap.

**(f) Add M6½: `SUNExists` conditional on Lean transcriptions of Balaban's published YM theorems.** State those theorems as interface `Prop`s, following the PrimeGaps186 and `Published…` patterns [note 04 §3.3, §3.5]. This milestone:
- comes early and is measurable;
- isolates exactly what lies beyond Balaban;
- is the object note 99 action 1 wants to compare against OpenAI's release.

Red-team the transcribed theorems: Balaban's own normalization contains a trivially true trap, since Z_N ≤ 1 for compact G [note 05 §5.4].

**(g) Replace the M3 calibration with two pilots:**
- **M1′, a free-field calibration through the real spec.** A massive vector (Proca-type) Gaussian field on the lattice, its Wick-square `tr F F` composites, and the continuum limit through C0, ending in `OSAxioms ∧ NonTrivial ∧ FullFieldContent`. This exercises every piece of the M7 pipeline except non-abelian RG, and it also closes `os_nonTrivial_fullField_consistent`.
- **C2′, one complete RG step of Dimock's φ⁴₃,** proved from a Lean-stated inductive hypothesis.

**Revision.** Rewrite the §1 table with (a)–(g): M2 becomes M2a/M2b, M3 becomes M1′, M4 is marked natural-language only in Lean terms, M6½ is inserted, and M7 becomes M7a/M7b (L3, L13).

### L7 — HIGH: the gates and KPIs are miscalibrated

**What is wrong.** The Phase-1 gate is "C2 pilot ≥500 Lean lines/week".
- The calibration points are:
  - Navier–Stokes: about 640k lines for 223 pages, roughly 2.9k lines per page, in about 17 hours [note 03 §4.6];
  - OSreconstruction: about 350k lines;
  - note 10's projection for this job: 1–4M lines.
- At 500 lines/week, 1M lines takes about 38 years.
- The plan's own date, M7 at week 60 for about 1,147 pages, implies about 20–25 pages a week formalized and connected. At observed densities that is 50–100k lines a week [I].

Lines are also the wrong unit, because bloat costs an agent nothing. "Skeptic pass rate ≥70%" measures the natural language, not the Lean.

**Revision.** Replace the KPIs with these:
1. **Closure rate.** Page-weighted blueprint nodes closed per week, where closed means `sorry`-free, axiom-clean and connected to `Reduction.lean`.
2. **Frontier health.** Frontier size, plus the number of interface `Prop`s refuted, and how quickly.
3. **First-pass formalization fidelity.** The percentage of nodes whose Lean statement did *not* change during the proof. This measures NS-type drift directly.
4. **Build cost.** Build minutes per 1k lines, and the slowest module.
5. **Lines per page,** as a diagnostic only.

New Phase-1 exit gate: C0 complete and applied to M1′; one φ⁴₃ RG step closed; and measured throughput that projects M6½ within budget.

### L8 — HIGH: library reuse is overclaimed, and there is no strategy for version skew

| Library | Toolchain | What it offers | On the existence path? | Verdict |
|---|---|---|---|---|
| OSforGFF | v4.33.0-rc1 [gh] | Massive *scalar* GFF as a `ProbabilityMeasure (WeakDual ℝ 𝓢)`, with its own OS encoding | No. Our route needs no measure on 𝓢′, and M1 is better done through M1′ | Mine its RP proof patterns; do not depend on it |
| OSreconstruction | v4.35.0-rc4; about 350k lines [note 10] | Scalar OS ⇄ Wightman | No (statement validation only) | Bridge across toolchains: port the *small* side, i.e. our ~850-line spec back to v4.35.0-rc4, or its 497-line Mathlib-only `Definitions.lean` forward to ours. Then audit the definitional closure across versions. Never forward-port 350k lines |
| lgt | v4.30.0 [gh] | Strong coupling for U(n), via Dobrushin | No (pattern source for Track E). Its `TransferMatrix.lean` is single-site Doeblin weights, not an operator; its gauge-invariance results are for the action and the Boltzmann weight, not for Haar measure [gh] | Correct Track B's claim that "lgt has strong-coupling pieces we can reuse" |
| physlib | v4.35.0 [gh] | `SULieAlgebra`: Killing form = −2n·tr; the lightly reviewed `PhyslibAlpha` unbounded spectral theorem | Partly (su(N) facts) | Mine its su(N) lemmas; use PhyslibAlpha only for the optional A3(d) |
| gaussian-field | v4.33.0-rc1 [gh] | Nuclearity of 𝓢; Hermite tensor isomorphism; Schwartz kernel theorem | No (see L4) | Use only if A3(a)'s density lemma needs Hermite approximation |
| markov-semigroups, gaussian-hilbert | — | — | — | Do not vendor: they contain 8 axioms and a placeholder axiom respectively [note 10 §2.8] |
| Sussman–Alpöge repository | — | 464 files: svg, pdf, tex, md; **no Lean** [gh] | — | Treat as natural-language literature only |

**Rule:** on the critical path, *mine, don't depend*. Pin every source by commit and record licence and attribution. A further reason: the committee's conflict-of-interest rules may freeze maintenance of libraries Douglas maintains [note 99 (d)-7].

### L9 — HIGH: Track B targets the wrong infrastructure; make it demand-driven

**Off the path, defer:** characters, Weyl integration (Balaban does not use either), and transfer-matrix compactness.

**On the path but missing from Track B:**
- **Exponential coordinates on π(G)** with explicit radii, and the Haar density in those coordinates (the det(sinh(ad X/2)/(ad X/2)) Jacobian), for the small-field analysis.
  - Mathlib has no charts on any matrix subgroup [note 10 §2.4].
  - Even `det (exp A) = exp (tr A)` is missing from the pinned Mathlib, and so is Schur triangularization [local grep]. Both are needed already for `su_lieAlgebra_simple`.
- **Complexified field domains** and Cauchy estimates on many-variable polydiscs, for the analyticity of background fields and polymer activities [note 05 §2.2, item 3].
- **Disintegration along averaging maps,** for δ-function or Gaussian-approximate averaging constraints [note 05 §2.2, item 1].
- **Lattice geometry on `ZMod` tori:** blocks of side L, distances, paths and odd sides, with adapter lemmas to `Spec.Site`.
- **Riemann sums of Schwartz functions over a·ℤ⁴,** because `smearedField` evaluates test functions at `sitePos`.
- **Osterwalder–Seiler RP for exactly the reflection the spec induces on `ZMod (L+1)`.** Balaban's tori have side L^{M+N} with L odd [note 05 §2.1]. On an odd period, t ↦ −t is a site reflection at 0 and a link reflection at the antipode. The usual statements are for even periods [I — check against Osterwalder–Seiler 1978].
- **Haar bi-invariance on compact non-abelian groups.** It is missing as an instance [note 10 §2.3], and lgt does not prove invariance of the measure [gh].
- **Tensor products of Schwartz functions and E0′ assembly** (L4).

**Rules for Track B:**
- Build only what an open skeleton node requests.
- State lemmas without project-specific types; Douglas et al. found this reduced false conjectures [note 10 §4.3].
- Ship unit-test lemmas with every new definition.

### L10 — HIGH: M1 is under-scoped

**What is wrong.** A2 proposes "Wick-ordered `tr F F` of the free Maxwell field, reusing OSforGFF's Gaussian measure". Four problems:
- OSforGFF covers the *massive scalar* field, on another toolchain and in a different OS encoding.
- Maxwell is a *massless vector* field.
- E0′ for Wick composites requires extending kernels with |x|⁻⁸-type diagonal singularities to distributions on all of configuration space. That is the same Taylor-vanishing and Hahn–Banach machinery as C0.
- Every one of the 21 channels must be shown to be non-zero.

So M1 is not "statement extras, 3–10k lines" (note 10 §4.2). It is more like 20–60k AI-density lines [I], unless it is done through C0, in which case it doubles as the pipeline calibration M1′.

**Revision of A2.** Replace the third bullet with:

> **M1 via M1′.** A massive (Proca-type) Gaussian 2-form field; lattice Gaussian definitions with exact Wick formulas; the continuum limit through C0; then `OSAxioms ∧ NonTrivial ∧ FullFieldContent`.
>
> **Cheap sanity theorems** to add to `Sanity.lean`:
> 1. The trivial theory satisfies `IsWilsonLimit` with Z = 0, for any lattice sequence. So the lattice clause alone pins down nothing; record this.
> 2. A generalized free field in the scalar channel satisfies `OSAxioms ∧ ShortDistanceAF`. So the AF clause is not self-contradictory: no sign or power error.
> 3. The free composite fails `ShortDistanceAF`. This turns the docstring's claim into a theorem.

### L11 — MEDIUM–HIGH: the anti-drift machinery (P6) needs a different implementation

**What is wrong.**
- A hand-maintained `alignment.yaml` is a second source of truth, and it will drift.
- The §3.2 cycle is natural-language-first per node (attempt → verify → formalize). That is the NS order that produced the drift.

**Revision.**
- **Generate, don't maintain.** LeanArchitect targets `v4.36.0-rc2`, the same as us [gh]. Tag Lean declarations with `@[blueprint]` and generate both the leanblueprint and `formalization.yaml` (v0.4 alignment block) from Lean. Run `checkdecls` in CI.
- **Statement first, per node.** The order is: Lean statement → a natural-language proof of *that* statement → skeptic triage → Lean proof.
  - If a proof forces a statement change, the change goes through the consolidator, propagates up the reduction, and the natural-language text is regenerated.
- **A definition registry.** The RG-layer notions (small-field region, averaging operator, background field, activity norms) are defined once, reviewed and unit-tested. No parallel definitions are allowed.
- **Explicit constants.** Use a single parameter structure with explicit formulas, as the Carleson project did, instead of nested ∃C. That project fixed D := 2^{100a²} and κ := 2^{−10a}. Its §2 states every proposition and definition used across §§3–9, which are "mutually independent except for referring to the statements formulated in the present section" [arXiv:2405.06423 §2]. This removes the m+4-versus-m+5 class of drift at the source.
- **Point the hypothesis-diff agent at two seams:** Lean node against natural-language exposition, and project node against Balaban's source lemma. Use the statuses `proved` / `weaker` / `stronger` / `different-proof` [note 04 §6.2B].

### L12 — MEDIUM: certified numerics are not designed

**What is wrong.**
- P8 relies on Arb and python-flint.
- Comparator's whitelist excludes `Lean.ofReduceBool`, so `native_decide` is unavailable.
- PrimeGaps186 shows where this leads if unplanned: its numerical bounds were left as *axioms*, because the FLINT certificate "does not discharge any Lean axiom" [note 04 §3.5].

**Revision.** Design certificates for C3 (and E2) for the kernel from the start:
- certificates are Boolean checkers over ℕ, ℤ or ℚ data, each proved sound once;
- each certificate is discharged by kernel evaluation (`decide` or `rfl`; kernel arithmetic on `Nat` is GMP-accelerated);
- prefer *analytic* extraction of the log coefficients, which come from the small-momentum region, over brute-force numerics;
- run a spike in week 3 to measure the size limits on certificates.

### L13 — MEDIUM: general G and SU(N) are conflated

**What is wrong.** M7 is written as "= `SUNExists` / `ClayExistence`", but these are different targets.
- `ClayExistence` covers every compact connected G with a faithful representation and a simple matrix Lie algebra.
- `GaugeGroup.lieAlgebra` is a `Set`. Showing it is a Lie subalgebra with exponential charts requires the closed-subgroup theorem, which Mathlib lacks [note 10 §2.4].
- The one-loop constants depend on the Casimir and the Dynkin index of π.
- Balaban's coupling-flow Theorem 2 is stated for SU(2) [note 05 §2.1].

**Revision.**
- M7a is `SUNExists`, starting with N = 2; M7b is `ClayExistence`.
- Parameterize the RG layer over a `CompactGaugeData` structure: 𝔤 as a submodule, an Ad-invariant inner product, exp/log charts with explicit radii, and the Casimir.
- Instantiate it for SU(N) first, mining physlib's `SULieAlgebra`; do general G later.

### L14 — MEDIUM: the size estimates in note 10 are circular, low to middling, and leave out compute

1. **Circular.** The estimate is anchored on the 1,147 pages it claims to confirm [note 99 (b)-8].
2. **Low to middling.** Analysis-heavy formalizations run at about 2.9k (NS) to 3.5k (OSreconstruction) lines per page. That gives 3–4M lines before infrastructure, so plan for 3–5M in total [I]. Note 10 §6 itself concedes that the openai/math data point makes the upper end non-conservative.
3. **Missing rows:**
   - C0;
   - perturbative certificates (b₀, b₁, the AF leading term);
   - exponential coordinates and complexification;
   - the M1 composites;
   - the decomposition/IR layer;
   - Track V.
4. **No compute estimate.**
   - Our 850-line spec already carries a 6.7 GB Mathlib build directory per checkout [local].
   - 3–5M lines is 1.3–2× Mathlib (2.35M lines).
   - Peter's machine (10 cores, 24 GB [local]) can host neither the builds nor Comparator, which is Linux-only.
5. **Revision.** Re-estimate at week 8 from *measured* lines per page on C2′ and M1′, and budget the build infrastructure (L15).

### L15 — MEDIUM: there is no engineering plan for 10⁶+ lines (absent from §3.2)

- **Build hosts.**
  - A Linux build farm: many cores, large RAM, NVMe.
  - A shared, read-only olean cache for stable layers.
  - Agents work in leaf modules; merges go through a merge queue with CI.
  - Sixteen agents with independent `.lake` directories would need about 100 GB+ unless the caches are hardlinked [I].
- **Code shape.**
  - Follow the NS layout, not the ten-proofs one [note 03 §4.6; note 04 §3.2]:
    - NS: about 2,650 files of 2–15 kB, descriptive names, `autoImplicit = false`, `warningAsError`;
    - ten-proofs: monolithic files of up to 5.3 MB with no comments.
  - Enforce a file-size cap (for example ≤1,500 lines) and forbid `maxHeartbeats 0`.
  - Watch the `vm.max_map_count` issue at scale [note 10 §2.12].
- **Ban-list scan.** `sorry`, `admit`, `native_decide`, `implemented_by`, `extern`, `unsafe`, `opaque`, `axiom`, `debug.skipKernelTC` [note 04 §6.1, rule 7].
- **Agent tooling.** A Lean REPL or LSP; Loogle and LeanSearch (`LeanSearchClient` is already in the manifest); and `lean-index-qft` for finding constructive-QFT lemmas [note 10 §2.11].
- **CI cost.** Run doc-gen only for the spec and Foundations. Today the CI runs `docgen-action` on everything.

### L16 — LOW–MEDIUM: the A4 audit has no Lean mechanics

**Revision.** Write a release-day kit in week 1:
1. Port whichever statement is smaller (theirs to our toolchain, or ours to theirs) to prove `theirs ⇒ ours` or `ours ⇒ theirs`. Only the challenge files are needed, never their proof.
2. Run `#print axioms`, and grep for `axiom`, `Published` and hypothesis structures [note 99, action 1].
3. Run `lake comparator --paranoid` on Linux, using the challenge from an export.
4. Check whether their challenge imports solution code [note 04 §3.3 precedent], and measure their trusted base.

The firewall rule: auditors read statements and Comparator logs, never proof modules.

**A policy decision for Peter:** after the audit, may *generic*, YM-free infrastructure modules from OpenAI's release (Haar, Schwartz tensors) be used in the way Mathlib is used?

---

## 3. The recommended Lean architecture for a ~1,000-page proof

### 3.1 Shape: an hourglass with three waists

```
            YMSpec (trusted, frozen, Mathlib-only, ~1k lines)          ← waist 1
              │   adapters only (rfl/simp equalities, d = 4)
  ┌───────────┴──────────────────────────────────────────────┐
  │ YMProof.Continuum: Assembly (C0), Restoration, AF, Scaling │   G-independent
  │      ▲ consumes                                            │   functional analysis
  │  Continuum interface: TorusKernelBounds / LimitData        │ ← waist 2
  │      ▲ produced by                                         │
  │ YMProof.IR (uniform-in-volume torus bounds, extraction,    │
  │            decomposition if L2(a) is chosen)               │
  │ YMProof.RG: Ind k → Ind (k+1); Flow (1- and 2-loop)        │
  │      ▲                                                     │
  │  RG inductive hypothesis `Ind k` (explicit constants)      │ ← waist 3
  │      ▲ per-step lemmas (parallel, lemma-level tasks)       │
  │ Averaging · GaugeFixing · Propagators · Background ·       │
  │ SmallLarge · Polymer/ℝ-operation · Sources                 │
  └───────────┬──────────────────────────────────────────────┘
              │
  YMProof.Lattice (d-generic LGT; OS–Seiler RP; symmetries; Spec adapter)
  YMProof.Foundations (project-type-free, Mathlib-style, upstreamable):
     HaarBiInv · MatrixLieCharts · SchwartzTensor · E0Assembly · TaylorDiag ·
     RiemannSums · PolydiscCauchy · Polymer(KP, BKAR) · NeumannRW ·
     FiniteGaussian · Certificates(ℚ-interval, kernel-checked)
```

### 3.2 Module tree

```
lean/YMSpec/                      trusted; frozen with the toolchain, manifest and export hash
  YMSpec/{OS,Lattice,SU,Statement,Sanity}.lean        (default targets, sorry-free)
  YMSpec/Challenge/{Existence,MassGap,NonVacuity}.lean (not default targets)
  comparator/{existence,massgap,nonvacuity}.json
lean/YMProof/                     untrusted; requires YMSpec at a fixed commit; never imports Challenge
  YMProof/Foundations/…   YMProof/Lattice/…  YMProof/Lattice/Adapter/Spec4.lean
  YMProof/RG/{Defs,Constants,Ind,Step/*,Flow}.lean
  YMProof/Continuum/{Kernels,Assembly,Restoration,AF}.lean  YMProof/IR/…
  YMProof/Interfaces.lean   YMProof/Reduction.lean   YMProof/Main.lean
lean/YMBridges/  (one per foreign toolchain: OSreconstruction, OpenAI statement)
```

### 3.3 Rules

- **R1. The spec is small, frozen and trusted.** Nothing in `YMProof` is trusted. Soundness rests only on `YMSpec`, the toolchain and the challenge export.
- **R2. No `sorry` and no `axiom` in default targets, ever.** The frontier is a set of named interface `Prop`s. `lake check` passes continuously.
- **R3. The reduction `Interfaces → SUNExists` always compiles.** Changing an interface means editing the reduction in the same commit.
- **R4. Every interface `Prop` faces three challenges:** a red-team refutation attempt, a model-instance satisfiability check where meaningful, and mechanical vacuity checks [arXiv:2610.20573].
- **R5. Definitions are registered and unit-tested;** only proofs are left to agents unsupervised.
- **R6. Constants are explicit formulas** in one `Constants` module (Carleson style), and are passed as parameters, not existentials.
- **R7. Canonical carriers are fixed in week 1.**
  - Lattice fields are `Λ → 𝔤`, with 𝔤 a bundled inner-product space.
  - Norms are fixed explicitly; avoid Mathlib's scoped `Matrix` norm instances in the main development.
  - Configuration space keeps the spec's sup norm.
- **R8. The lattice core is dimension-generic;** d = 4 enters only through `Adapter/Spec4.lean`.
- **R9. Files are capped at ≤1,500 lines and heartbeats are capped.** Module names equal blueprint node labels.
- **R10. The blueprint and `formalization.yaml` are generated from Lean** (LeanArchitect). The exposition paper is rendered from that blueprint and checked by the hypothesis-diff agent.

### 3.4 What the waist-2 interface must contain (sketch)

This is a sketch of a `structure`, not final Lean.

For a schedule (a, β, L, Z) satisfying the scheduling clauses of `IsWilsonLimit`:
- **Cauchy convergence.** For all n and all compactly supported, disjoint f, the sequence `latticeSchwinger` converges; prove this directly, so the UV limit needs no compactness argument.
- **Uniform bounds.** For all k, `|latticeSchwinger … n f| ≤ Cⁿ (n!)^β · Kₙ(f)`, where Kₙ is a fixed kernel functional with polynomial diagonal singularities and translation-invariant decay.
- **Inherited identities.** RP on positive-time slabs (exact for the reflection the lattice induces), and lattice translation and hypercubic covariance.
- **The UV statements, as separate interfaces:**
  - asymptotic rotation covariance;
  - the scalar-channel short-distance law;
  - the full-content non-degeneracy;
  - the non-Gaussian fourth cumulant.

C0 maps this structure to `YMSpec.IsYangMillsTheoryAlong`, using only functional analysis.

---

## 4. The first four Lean weeks, concretely

### Week 1 (9–15 Nov): plumbing and the pre-freeze audit

1. **Split the repositories** as in §3.2.
   - Delete `Basic.lean`; set `autoImplicit = false`; clear the warnings (`Lattice.lean:156`, and `Sanity.lean:33/48/52/80/140`).
   - Write three `comparator.json` files.
   - Add a golden-file CI check for `Audit.lean`.
   - *Accept when:* `lake build` is green for `YMSpec` and the audit diff is empty.
2. **Stand up a Linux runner with `bwrap`.**
   - Run `lake comparator` end to end on a toy challenge, for example a non-vacuity theorem.
   - Add a *negative test*: a deliberately mismatched solution must exit 1.
   - Produce and hash the frozen challenge export, and record wall time and whether Mathlib was rebuilt inside the sandbox.
   - *Accept when:* both exit codes are as expected and the times are logged.
3. **Prove `su_connected`.** Take a path in U(n) using Mathlib's C*-unitary/CFC machinery (`Unitary/Connected.lean` exists [local]), then correct the determinant with diag(det γ(t)⁻¹, 1, …). Target ≤1k lines; Comparator-checked against `NonVacuity`.
4. **Ready the A4 release-day kit** (L16), for the release expected the week of 9 Nov.
5. **Write the pre-freeze memo to Peter and the expert** covering L2, L3, L4, L6(b) and L13, with a recommended option for each.

### Week 2: skeleton v0 and Foundations P0

1. **`Interfaces.lean` and `Reduction.lean` v0.**
   - The reduction runs `SUNExists ⇐ {Assembly (as a Prop for now), UVTorus, IR, Restoration, AFTwoPoint, CouplingFlow₂}`.
   - Write the `SUNExists₁` variant in parallel.
   - *Accept when:* it compiles, `#print axioms` shows the standard three, and the LeanArchitect blueprint renders.
2. **Red-team every interface** (R4) and log the results.
3. **Foundations P0:**
   - Haar bi-invariance on compact groups (via the triviality of the modular character), and gauge invariance of `linkMeasure`;
   - `Matrix.det_exp`;
   - the statement of the Schwartz n-fold tensor product as a continuous multilinear map with a seminorm bound.
4. **`su_lieAlgebra_simple`.** First characterize `(suGauge N).lieAlgebra` as the traceless skew-Hermitian matrices; then prove simplicity.

### Week 3: spikes, each with a written cost estimate

1. **C0 assembly:** Hahn–Banach via `Module.Dual.exists_extension_of_le_seminorm`, the Taylor-vanishing lemma, and the reduction to compact supports.
2. **The dimension-generic lattice core** plus `Adapter/Spec4.lean`, with `rfl`/`simp` equalities for `wilsonAction`, `plaquette`, `smearedField` and `latticeSchwinger`.
3. **Osterwalder–Seiler RP** on `ZMod n` for n even *and* odd, for the reflection that `sitePos` and `timeReflection` induce.
4. **A certificate spike:** a kernel-checked rational interval bound for a toy lattice one-loop integral, without `native_decide`. Measure its limits.
5. **A Lie-chart spike:** exp/log on SU(N) with explicit radii, and the statement of the Haar Jacobian.

### Week 4: skeleton v1 down to the RG waist; decisions; measurement

1. **State `Ind k` in Lean** for φ⁴₃ (following Dimock) and for YM (following Balaban), with the `Constants` module, and state `rgStep : Ind k → Ind (k+1)`. Insert the M6½ interface `Prop`s, i.e. Balaban's published theorems.
2. **Start M1′:** the lattice Proca-type Gaussian, with definitions and unit tests.
3. **Make the dashboard live:** frontier size, page-weighted closed nodes, first-pass fidelity, and build minutes.
4. **Phase-0 exit gate.** All six must hold:
   - (i) Comparator works end to end on Linux, with measured cost;
   - (ii) `su_connected` and `su_lieAlgebra_simple` are Comparator-accepted;
   - (iii) skeleton v1 compiles, sorry-free and axiom-clean;
   - (iv) all five spikes have cost estimates;
   - (v) Peter and at least one expert have decided L2, L3 and L6(b);
   - (vi) **only then** is spec v1.0 frozen.

   This moves the freeze from week 2 to week 4, deliberately: the skeleton is what tests the spec.

---

## 5. Revised Lean rows for the phase table

| Phase | Weeks | Lean deliverables | Go/no-go |
|---|---|---|---|
| 0 | 0–4 | Package split; Comparator on Linux; `su_connected` and `su_lieAlgebra_simple`; skeleton v1; five spikes; spec v1.0 frozen *after* the skeleton | The gate in §4, week 4 |
| 1 | 4–12 | C0 complete; M1′ end to end (which closes `os_nonTrivial_fullField_consistent`); M2a; one φ⁴₃ RG step (C2′); certified one-loop b₀ | Closure rate measured; fidelity ≥80%; projection to M6½ within budget |
| 2 | 12–30 | M6½: `SUNExists` conditional on Balaban's transcribed theorems; C3 two-loop (or the decision for M7a); the YM `Ind k` step lemmas start | M6½ accepted by Comparator under a separately labelled "conditional" configuration |
| 3+ | 30– | Discharge the Balaban interfaces (M5, M6 as internal rungs); then IR per L2; then M7a/M7b | Frontier shrinking at the planned page rate |

M3 and M4 are removed from the Lean critical path. Track V (statement validation) runs alongside at low priority.

---

## 6. Lean decisions needed from Peter

These should be added to §6 of the plan:

1. **The lattice clause** (L2): periodic only, a weak component target, or both.
2. **The scaling target** (L3): one-loop M7a first, or commit to a two-loop C3.
3. **A dimension-generic spec before freeze** (L6b): yes or no.
4. **Build infrastructure:** a Linux build farm with an olean cache. This needs a budget line of its own; it is not covered by "tokens/month".
5. **Toolchain policy:** the spec pinned for its lifetime, and proof bumps on a fixed cadence (L5.7).
6. **Post-audit use of generic infrastructure** from OpenAI's release (L16).
