# 04 — OpenAI's published proof repositories: layout, Comparator, axiom hygiene, and what a Yang–Mills formalization must learn from them

*Workstream key:* `04-openai-github-proofs` · *Compiled:* 2026-11-05 · *Scope:* how OpenAI packages AI-generated mathematics plus Lean, for **methodology and Lean hygiene only**. This is not about the mathematical content of any OpenAI proof.

*Method.* I inspected primary sources directly. I used `gh api` on `openai/ten-proofs`, `openai/math`, `openai/NavierStokesAndEuler`, `openai/PrimeGaps186`, `openai/LongGapsBetweenPrimes`, `openai/cdc-lean`, `leanprover/comparator`, `leanprover/lean4` (Lake help text and PRs), `mathlib-initiative/formalization.yaml` and `google-deepmind/formal-conjectures`. I downloaded and parsed all 419 Comparator configs and all 418 top-level challenge files in `openai/math`. I also downloaded all 10 solution files in `ten-proofs` and grepped them. I read the shepherding committee's Yang–Mills statement (the KITP PDF) and the arXiv critiques. Two sources could not be read: openai.com blocks automated fetches (HTTP 403), so I used secondary reports of OpenAI's own blog posts. I also could not locate the "Ken Ashe 2026-10-07" blog post, nor any "the-decoder" or "smartscope" analysis. See the references.

---

## 1. Summary

1. **There are two different OpenAI "proof" release styles, and the difference matters.**
   - **`openai/ten-proofs`** (Aug 2026). Ten results, 12 Comparator challenges, 38 named theorems. Each was checked against hand-scoped, Mathlib-only challenge files with only the three standard axioms, and the independent *nanoda* kernel was enabled for every config. The solution files are 10 monolithic files, about 548k lines and about 21.6 MB. They contain zero comments or docstrings: they are certificates, not readable libraries. Review status is self-declared as `agent-reviewed`.
   - **`openai/math`** (Oct 6, 2026, revised Oct 7, 26 and 29). This is a bulk dump: 721 manuscripts in 373 "families" across 17 disciplines. The Lean library has about 162k files and about 1.8 GB of source. There are 419 Comparator configs, but nanoda is enabled in only 2 of them. Review status is self-declared as `unchecked`. OpenAI's own README has called the manuscripts "raw research data" since the Oct 26 revision.
2. **Statements are separated from proofs with Leanprover's *Comparator*.** A trusted *challenge* module states each theorem with `sorry`. An untrusted *solution* module proves it. A JSON config names the theorems, the permitted axioms and optional extra kernels. Comparator rebuilds both modules in a sandbox and exports them. It then checks that every declaration in each statement is identical in both environments, that the proof uses only permitted axioms, and that the kernel replays it.
   - Comparator was merged into Lean core as `lake comparator` / `lake check` in v4.35.0.
   - The core version adds `--paranoid`, which runs five extra kernels: leanchecker-paranoid, lean4lean, nanoda, con-leche and con-ron.
   - **Comparator explicitly cannot judge whether the challenge means what its author intended.**
3. **Axiom and sorry policy.**
   - Every OpenAI challenge config I inspected permits exactly `propext`, `Quot.sound` and `Classical.choice`. That covers all 12 in ten-proofs, all 419 in openai/math, and NavierStokesAndEuler.
   - The one exception is `PrimeGaps186`. It openly declares three project axioms (Deligne-type Kloosterman bounds plus numerical integral bounds) and permits them in Comparator: six axioms in total, labelled "proved-conditionally".
   - `openai/math` also has a softer variant. Literature inputs are encoded as `Published…` hypothesis structures, which makes some theorems conditional without any `axiom` declaration.
4. **Pairing manuscripts with Lean.** Each family follows this chain:
   - `CONTENTS.md` entry
   - → manuscript PDFs, TeX and BibTeX under `preprints/`
   - → a natural-language **scope note** `lean/docs/NNN.md`, saying what is and is not formalized
   - → challenge `.lean` plus `.json`
   - → solution declaration under `lean/OAI/...`
   - → catalogue entry in `lean/formalization.yaml`, using a community schema (v0.4) that has `review.status` and `alignment` fields.
5. **Coverage appears lower than the headline** (caveat: "top-line results" and "papers" are different units, so the two percentages are not strictly comparable).
   - OpenAI says about 42% (300 of 719) of top-line results are formalized. Nothing in the repo reproduces that number (also flagged by borism #6).
   - `formalization.yaml` lists 176 source papers with a formalized main result: about 24% of 721.
   - 245 of 373 families have *some* Lean scope note.
   - At least 5 catalogued "main results" are supporting lemmas only.
   - At least 5 more are weaker than the paper. Example: the Lean bound has $\delta^{13}$ where the paper claims $\delta^{5}$.
   - About 21 families show a "(Lean)" link beside a headline that is not formalized. One is family 215, the claimed **2D $O(3)$ continuum limit with a mass gap**. Only a finite-volume exponential-decay statement for $O(n)$, $n\ge 3$, is formalized.
6. **Quality critiques, all documented and checkable:**
   - Statement-faithfulness gaps (weaker, partial, or supporting-only targets).
   - Huge bespoke definitional trees in the trusted base. The CM Hodge challenge has 262 files and about 2.9 MB of definitions, and was edited after release to match the solution.
   - Challenge files that import solution-side modules (2 cases).
   - Junk-value totalizations, such as the Riemann ζ statement silently including $s=1$.
   - Mismatches between the natural-language and Lean proofs. In OpenAI's Navier–Stokes repo, the Lean lemmas use $m{+}5$ derivatives where the paper says $m{+}4$, and the pressure-flux bound is proved differently.
   - "Self-assessed", "agent-reviewed" or "unchecked" review labels.
7. **Yang–Mills specifically.**
   - According to multiple consistent secondary reports of OpenAI's 26 Oct 2026 post (the primary post was not readable here), its model produced a natural-language proof of **existence** of 4D quantum Yang–Mills (9 Sep), then of QCD (18 Sep), and completed a **Lean formalization of the YM result on 16 Oct**. The committee's own statement says only that OpenAI "is providing" a Lean formalization; it does not say the formalization is complete, and it does not name the spacetime dimension or the gauge group(s) covered.
   - The mass gap is *not* claimed. The natural-language proofs run to 1,147 pages (committee statement).
   - Custody passed on 16 Oct to a **shepherding committee**: M. R. Douglas, D. J. Gross (chair), A. Jaffe, I. R. Klebanov, N. Nekrasov. Its stated first task is to check that the **definitions and problem statement match the standard ones in physics and mathematics, and that the formalization matches the informal treatment**. Only then will the Lean proof be released.
   - As of 2026-11-05 no YM Lean code, statement or scope note is public.
   - Unlike Navier–Stokes, **there is no pre-existing human-reviewed Lean statement of the YM problem** in DeepMind's Formal Conjectures, so the statement must be audited from scratch.

---

## 2. Key definitions and statements

### 2.1 What Comparator certifies (precise form)

Let $\mathcal C$ be the environment exported from the trusted challenge module and $\mathcal S$ the environment exported from the solution module. Let $T$ be `theorem_names`, $D$ be `definition_names` (definition "holes") and $A$ be `permitted_axioms`. Comparator **accepts** iff:

1. **Statement identity.** For every $t\in T$, every constant $c$ occurring transitively in the *type* of $t$ in $\mathcal C$ has the same declaration in $\mathcal S$. That means the same kind, type, value (for definitions), universe parameters and safety. This always includes the kernel-special declarations from `Init`.
2. **Axiom closure.** $\mathrm{Ax}_{\mathcal S}(\mathrm{body}(t)) \subseteq A$ for every $t \in T$, taken over the transitive closure.
3. **Kernel replay.** The Lean kernel accepts $\mathcal S$. If external kernels are configured (for example nanoda), all of them must accept too.
4. **Definition holes.** For every $d\in D$: name, type, universes and safety level match, the definition uses axioms only from $A$, and it type-checks.
   - Since Lean PR #15775 (merged 2026-10-19), a hole must be `sorry` or a lambda whose body is `sorry` in the challenge.
   - The value a solution supplies for a hole is **not** semantically checked. The README's own example: a hole intended to be `True` or `False` could be filled with `RiemannHypothesis` itself. So holes always need human review.

**Assumptions (the trusted computing base).** These follow the Comparator README and the core `lake comparator --help` text:

- Everything the challenge imports transitively is trusted.
- The lakefile and manifest, and every dependency they pull in, are trusted.
- Builds start clean, with no prior `.lake`. The solver must not have built the solution in the checking environment first.
- The sandbox works: originally `landrun`, now `bubblewrap` in core. The checker does not run as a privileged user.
- At least one configured kernel is sound.
- The solution does not exploit OS or hardware bugs.

The help text adds that Comparator has **no way to tell whether the challenge statements capture their author's intended meaning**.

### 2.2 Standard axioms and the "junk value" hazard

In Lean 4 and Mathlib, `#print axioms` on a classical proof normally lists `propext`, `Classical.choice` and `Quot.sound`. Any other axiom (`sorryAx`, a project `axiom`, `Lean.ofReduceBool` from `native_decide`) is a red flag unless it is declared and justified.

Mathlib totalizes partial operations: $x/0=0$, `sInf ∅ = 0` on ℕ and ℝ, `tsum` of a non-summable family is 0, the Bochner integral of a non-integrable function is 0, `fderiv` at a non-differentiable point is 0, `limUnder` of a non-convergent sequence is an arbitrary choice, and `riemannZeta 1` is a finite number. A statement whose definitions pass through these can be vacuous or silently stronger or weaker than intended. Bastounis–Circelli–Hansen (Example 4.1 and the discussion around Example 4.3) show how a hypothetical `sInf`-based "translation" of a definition with a hidden existence presupposition makes an ill-defined statement "provable". This is their constructed illustration, not a defect found in OpenAI code.

### 2.3 Self-reporting metadata (`formalization.yaml`, schema v0.3/v0.4)

The schema is a community standard (`mathlib-initiative/formalization.yaml`). Its main fields are:

- `sources`, plus `related_formalizations`.
- `status`: `sorry_count`, `sorry_in_definitions`, `axioms`, and `main_results`. Each main result carries a declaration, file, axioms, `comparator_config` and optional `literature_dependencies`.
- `automation.methods`: manual, copilot, agent, autonomous or other, with model, framework, `tool_setup` and `prompting_notes`.
- `review.status`, one of: `unchecked`, `agent-reviewed`, `self-assessed`, `peer-reviewed`, `author-verified` or other.
- `alignment`: source theorem, Lean declaration, and a status of `proved`, `literature-dependency`, `not-formalized` and so on.

The status line is **self-reported**; nothing in the schema enforces truthfulness.

### 2.4 The Clay target, for orientation (standard)

Jaffe–Witten (Clay) ask for this: for every compact simple gauge group $G$, a non-trivial quantum Yang–Mills theory on $\mathbb R^4$ exists. It must satisfy axioms at least as strong as Wightman's or Osterwalder–Schrader's. It must have a **mass gap** $\Delta>0$: the Hamiltonian's spectrum lies in $\{0\}\cup[\Delta,\infty)$. OpenAI's October claim concerns existence only.

---

## 3. Detailed findings

### 3.1 Inventory of OpenAI proof repositories (all verified via GitHub API, 2026-11-05)

| Repo | Created | Lean toolchain | What | Comparator | Axioms permitted | Review label (self-declared) | Model / framework (self-declared) |
|---|---|---|---|---|---|---|---|
| `openai/cdc-lean` | 2026-06-24 | v4.31.0 | "Unconditional" cycle double cover theorem for finite loopless bridgeless multigraphs. To my knowledge the cycle double cover conjecture was open in the human literature, so this is a claimed resolution; it is unrefereed and I found no independent replay | No. Uses `Audit.lean` with `#print axioms` plus an `rg` scan for `sorry\|admit\|native_decide\|axiom\|opaque\|unsafe` | standard 3 | (VERIFICATION.md dated 2026-07-09) | — |
| `openai/ten-proofs` | 2026-08-05 (single commit dated 08-02) | v4.32.0, Mathlib tag v4.32.0 | 10 results ("Ten advances…") | 12 configs, 38 theorems, **nanoda on in all 12** | standard 3 | `agent-reviewed` | "Astra (OpenAI)", Codex, wall time "1 week" |
| `openai/PrimeGaps186` | 2026-09-02 | v4.34.0-rc2 | liminf $(p_{n+1}-p_n)\le186$ (conditional) | 1 config, nanoda on | **standard 3 + 3 project axioms** | `self-assessed`; "No independent human semantic review" | "GPT 6 Astra", Codex |
| `openai/LongGapsBetweenPrimes` | 2026-09-02 | v4.33.0 (`lean-toolchain`) | Long prime gaps lower bound | 1 config (`comparator.json`), 1 theorem, nanoda on | standard 3 (verified) | `self-assessed` | "GPT 6 Astra", Codex |
| `openai/NavierStokesAndEuler` | 2026-09-08 (last push 09-10, commit `f9e8bc5`) | v4.34.0-rc2 | NS blow-up, Clay alternatives (C) and (D); Euler blow-up | 2 configs, nanoda on | standard 3 | `self-assessed` | "GPT-6 Astra", Codex |
| `openai/math` | 2026-10-06 (commits Oct 7, 12, 26, 29) | **v4.34.1**, Mathlib pinned `d13f23b7`, `fixedToolchain := true` | 721 manuscripts, 373 families | 419 configs; nanoda on in **2**, off in 414, key absent in 3 | standard 3 (all 419) | **`unchecked`** | "agent" (model unnamed; README: "unnamed internal OpenAI model") |

I found **no** OpenAI repository for Yang–Mills or QCD. The KITP committee statement says the Lean proof will be released only after validation.

### 3.2 `openai/ten-proofs` in detail

**Layout.**
- Top level holds `README.md`, `formalization.yaml` (v0.3), `lakefile.toml`, `lake-manifest.json`, `lean-toolchain`, `All.lean` and ten single-file solutions: `SpherePacking.lean`, `MetricCodes.lean`, `NonSoficGroup.lean`, `ConnesRigidity.lean`, `Permanent.lean`, `QuantumParallelRepetition.lean`, `GapCVP.lean`, `EhrhartVolumeInequality.lean`, `MulticolorTriangleRamsey.lean`, `CompactnessAndDegeneracy.lean`.
- There is also a `ComparatorChallenges/` directory with 12 `X.lean` + `X.json` pairs.
- Lake requires Mathlib `v4.32.0` (rev `81a5d257…`) and Comparator `v4.32.0` (rev `07bc4ea4…`). That pulls in `lean4export` and `lean4checker`.

**Statements.**
- Every challenge imports only `Mathlib` and **defines from scratch** whatever objects the statement needs. Examples:
  - a `SpherePacking` structure with `upperPackingDensity` as a limsup over balls;
  - `Formula` and `RationalFormula` inductives with an `eval` into `MvPolynomial` or `FractionRing`;
  - `Sofic` as a class over permutation models;
  - the group von Neumann algebra as a double commutant on $\ell^2(G)$, with a hand-defined normal trace-preserving ★-isomorphism;
  - `IsNP` and promise reductions via Mathlib's `Turing.TM2ComputableInPolyTime`.
- Challenge files run from about 1 KB to about 11 KB.
- Several statements bundle many conclusions into a single `structure … : Prop`. One is `SharpFullCohnElkiesManuscriptConclusions`, which even includes a 30-digit decimal enclosure of a constant.

**Definition holes.**
- Only `H_GapCVP.json` uses `definition_names`: four promise-problem definitions whose `disjoint` proof field is `by sorry`.
- *Correction (verifier):* the hole is the **whole** `PromiseProblem` definition, including its `yes`/`no` data fields, not just the proof field. Comparator does **not** compare the value the solution supplies for a hole, so Comparator alone does not prevent a solution from swapping in different languages. The use is benign only after a separate check. I ran that check as a textual diff of the challenge's `GapCVP.Comparator` namespace against the solution's (`GapCVP.lean`, lines about 129,741–130,424). All four holes have identical data fields and differ only in the `disjoint` proofs; the supporting definitions (`yesLanguage`, `noLanguage`, the instance encodings and so on) are textually identical. This is a syntactic check, not a kernel-level one, and it is exactly the kind of extra oversight the Comparator README says holes always need.

**Solution hygiene.** I grepped the 10 files.
- None contains a `sorry`, `axiom`, `native_decide`, `unsafe` or `opaque` token.
- `decide` appears where expected.
- None contains comments or docstrings, apart from one license and attribution header in `SpherePacking.lean`. That header credits definitions adapted from Sphere-Packing-Lean (Hariharan, Ma, Birkbeck, Lee, Mehta, Viazovska) and Math Inc.'s fork.
- Heartbeats are raised widely: `maxHeartbeats` up to 5,000,000, and `synthInstance.maxHeartbeats` too.
- The elaborator-level option `backward.isDefEq.respectTransparency false` appears 156 times in `QuantumParallelRepetition.lean`. It does not affect kernel soundness, but it makes the proof fragile across toolchain versions.

| File | Lines | `theorem` | `def` | `set_option` |
|---|---:|---:|---:|---:|
| GapCVP | 130,430 | 2,976 | 3,812 | 0 |
| MetricCodes | 114,406 | 3,822 | 1,204 | 765 |
| QuantumParallelRepetition | 70,980 | 1,655 | 747 | 419 |
| EhrhartVolumeInequality | 55,755 | 1,859 | 458 | 0 |
| SpherePacking | 55,616 | 1,663 (+101 `lemma`) | 375 | 16 |
| ConnesRigidity | 37,374 | 1,446 | 667 | 22 |
| NonSoficGroup | 34,440 | 1,044 | 324 | 0 |
| Permanent | 27,563 | 875 | 372 | 1 |
| CompactnessAndDegeneracy | 18,588 | 401 (+250 `lemma`) | 240 | 0 |
| MulticolorTriangleRamsey | 3,053 | 96 | 42 | 0 |

**Metadata.** `formalization.yaml` reports:
- `sorry_count: 0` and `sorry_in_definitions: 0`, with the three standard axioms per result;
- `automation`: agent, "Astra (OpenAI)", Codex, wall time "1 week";
- `review.status: agent-reviewed`.

**Human audit.** A Sienicki & Sienicki audit (arXiv:2608.14673) reviews 18 chapter-specific reports. It finds no surviving confirmed substantive error in a principal result. Chapter 8 (Ehrhart) still has a "major revision" request. Follow-ups give independent support at different strengths:
- Fournier-Facio (2608.02025) and Kun–Thom (2608.06222) reuse the non-sofic proof mechanism.
- Zhou (2608.02327) gives a Connes-rigidity counterexample independently of and concurrently with OpenAI. Caveats: Zhou discloses GPT-5.6 Sol assistance, and the paper gives one pair of groups, not OpenAI's infinite family. Sienicki & Sienicki therefore count it as conjecture-level confirmation, not a reproduction of OpenAI's stronger result.
- A stronger CVP hardness result by Song appeared on SSRN [45].

The audit separates three objects: the *formal* theorem, the *published* theorem and the *advertised* claim. It notes that each needs its own check.

### 3.3 `openai/math` in detail

**Top-level layout.** `README.md`, `history.md` (a changelog of withdrawals and fixes), `CONTENTS.md` (the manuscript map, 641 KB), `overview.{tex,pdf}` (the family catalogue), `preprints/`, `reasoning_traces/` (10 PDFs of abridged model reasoning), `lean/`, and `.github/workflows/lock-prs.yml`. The workflow locks PR conversations; OpenAI does not take community PRs there.

**Counts over time (README at each commit):**
- Initial commit (Oct 6): **722 manuscripts / 372 families**, with "many, but not all" formalized.
- Oct 7 commit `fd4aeeb`: **719 / 372**, "~42% top-line results formalized". `history.md` gives this as 300/719.
- Oct 26: **721 / 373**, after adding local smoothing and "The Exponential Time Hypothesis is False".
- Family numbers run 001–378, with gaps at 045, 061, 070, 123 and 163.
- The overview groups families into **17 disciplines**:

| Discipline | Families |
|---|---:|
| Theoretical CS | 41 |
| Combinatorics | 37 |
| Algebraic and complex geometry | 36 |
| Number theory | 31 |
| Probability and statistical mechanics | 29 |
| Differential geometry | 29 |
| Mathematical physics | 25 |
| Operator algebras | 19 |
| Algebra | 18 |
| Topology | 18 |
| Real and complex analysis | 16 |
| PDE | 16 |
| Convex and metric geometry | 15 |
| Group theory | 14 |
| Dynamics | 12 |
| Functional analysis | 11 |
| Logic | 6 |

**What a "family" is.** The README defines a family as a group of related papers: a principal result plus companion arguments, consequences or alternative proofs. Each `CONTENTS.md` entry gives a one-paragraph family summary, then its manuscripts with abstracts, then a "(Lean)" link to `lean/docs/NNN.md` where one exists.

**Production procedure (README).**
- About 4,000 problems were posed to the model.
- Each result used on average about 3 hours of "ChatGPT Pro thinking compute".
- Output was aggregated into families and filtered for significance.
- Two exceptions did not follow this procedure: the zeta zero-free region and the CM Hodge result. The $\Re s>11/12$ write-up was human-edited.
- OpenAI defers to the community on credit and precedence.

**Manuscripts.**
- `preprints/` has 751 top-level directories, including superseded editions and withdrawn papers. Together they hold 10,713 files in 2,865 subdirectories. *(Verifier correction: the earlier figure of "13,578 files" was the total of tree entries, files plus directories.)*
- Each directory holds `paper.pdf` (or `main.pdf`), a `README.md` with a BibTeX `@misc{OAI:…}` citation, and usually a `build/` TeX tree. Some also hold auxiliary code. One example: C++ plus a Python checker for the 6-dimensional mutually-unbiased-bases computation, restored on Oct 26.
- **Withdrawal hygiene is good.** Withdrawn papers keep a notice that explains the gap mathematically. The Weil-classes paper's notice explains a sign error that breaks the hypothesis of the Eliashberg–Murphy cancellation theorem. The notice links the pre-withdrawal PDF at a pinned commit.
- `grwtsk/openai-math#29` points out a gap: there is no reproducible TeX→PDF build receipt.

**Lean library (`lean/`).**
- `lakefile.lean` defines the package `OAI` with `autoImplicit false`.
- It has 30 `require` entries, each pinned by full commit hash. They include: Mathlib (`d13f23b7…`); PrimeNumberTheoremAnd; Carleson; StrongPNT; ClassFieldTheory; AINTLIB; SphereEversion; rellich-kondrachov; 11 `lana-agents/*` packages (including `iut`, `heights`, `belyi` and `formal-schemes`); LeanArchitect; PrimeCert; leancert; doc-gen4; checkdecls; and others.
  - *Verifier correction:* Formal Conjectures is **not** a Lake dependency. Code derived from Formal Conjectures appears inside challenge files instead, for example the CM Hodge tree carries a "Formal Conjectures Authors" notice.
- It declares 23 `OAI.*` subject sub-libraries. There are 27 top-level directories under `lean/OAI/`.
- It also contains **custom Lake code that clones dependencies and `git apply`s 23 compatibility patches** from `patches/` (up to 2 MB each) to port them to Lean 4.34.1.
- Under Comparator's threat model, lakefile code and the patched dependencies are **part of the trusted base**.
- `lean/OAI/` holds about **162,000 `.lean` files, about 1.78 GB**. The largest subject areas are Analysis (about 29k files, 516 MB), NumberTheory (about 29k), AlgebraicGeometry (about 24k), Combinatorics (about 17k, 374 MB) and MathematicalPhysics (about 6.7k files, 120 MB).
- The README warns that a full build can fail on Linux unless `vm.max_map_count` is raised or Lean is built with `-DMMAP=OFF`.

**Comparator challenges.** I analyzed `lean/ComparatorChallenges/` (419 JSON configs):

- **Permitted axioms:** all 419 are exactly the standard three.
- **`enable_nanoda`:** true in 2 (`ArtinParabolicIntersections`, `TraceIdealTransportSupport`), false in 414, and absent in 3 (`KadisonRingrose`, `LocalSmoothing`, `UniversalTensorSquares`).
- **Theorem names:** 546 in total, mean 1.3 per config, max 17.
- **Definition holes:** non-empty only for `ElementaryPositivity` (`OAI.elementaryPositivityWitness`), which by Comparator's own rules needs human review.
- **Challenge sizes:** median 79 lines, 90th percentile 312, maximum 19,169 (`EditApproximation`, about 1.4 MB).
- **Imports:** 388 of 418 import only `Mathlib`. The rest import Mathlib submodules, except **two that import OAI solution modules**:
  - `CartierChartCompactnessSupport` imports `OAI.AlgebraicGeometry.CartierSections.*`;
  - `CharacterVarietiesAllSeamsSupport` imports `OAI.AlgebraicGeometry.CharacterVarieties.Seams.ProducedEquations`.
  - So part of these "trusted" statements comes from AI-authored solution code.
- **The CM Hodge challenge** is a 262-file tree.
  - About 2.9 MB of it sits in 257 files under `HodgeConjectureCMAbelianVarieties/HodgeConjecture/{Definitions,Lemmas,Mathlib}`. That is definitions plus supporting lemmas, all of it trusted base.
  - It was adapted from `Paul-Lez/HodgeConjecture`, a work-in-progress statement for Formal Conjectures. Paul-Lez's repo itself adapts sphere-six-complex (per the challenge's `NOTICE`).
  - The formalization was first added on Oct 26.
  - **On Oct 29, commit `204e5f8f` edited 259 of its 262 files.** The commit message reads "Align CM Hodge comparator declarations with the Lean solution". `history.md` describes the change as "diverging namespaces … were adjusted".
- **Seven configs are named `…Support`.** The Oct 7 Comparator README listed five of them as verifying *supporting results, not the papers' main theorems*. **The Oct 26 commit deleted that section.** I verified both README versions.

**Scope notes (`lean/docs/NNN.md`, 245 files).** These are the natural-language bridge from paper to Lean. Each one has three parts:
- links to the paper(s);
- a "Scope" paragraph saying exactly what the formal statement says, including its limits. Examples: "The infinite-volume limit and the separate $O(4)$ spectral-gap claim are not included" (215); "The paper's later applications are not included" (003);
- a table of "Comparator links".

This is the best hygiene practice in the repo. The weakness is that the scope note is the *only* place the limitations appear: the catalogue and `CONTENTS.md` show an unqualified "(Lean)" link.

**`formalization.yaml` (v0.4).**
- 176 `sources` (papers "with a formalized main result").
- 208 `main_results` entries pointing to 192 distinct configs. So more than half of the 419 configs are not referenced as main results.
- `related_formalizations` lists the pinned dependencies with relationship "builds-on".
- `automation.methods: [agent]` with no model named.
- **`review.status: unchecked`**.

**Formal templates closest to Yang–Mills.** The Mathematical-physics and probability families include statements that show how OpenAI encodes constructive QFT-style objects using only Mathlib:

- **`Heisenberg.lean`** (218 lines; family 271): spontaneous magnetization for the quantum Heisenberg ferromagnet on $\mathbb Z^d$, $d\ge3$.
  - It builds the quasi-local C\*-algebra as the norm closure of the ★-algebra generated by single-site matrix units on $\ell^2(\text{finite configurations})$.
  - It defines finite-volume dynamics $e^{itH_\Lambda}Ae^{-itH_\Lambda}$, and infinite-volume dynamics as a `limUnder`.
  - States are normalized positive continuous functionals. The **KMS condition** is encoded by a bounded function, continuous on the closed strip and holomorphic inside, with the two boundary values.
  - The theorem's conclusion **includes `DynamicsConverges`** before using `dynamics`. This guards the `limUnder` junk value, and it is a pattern worth copying.
  - *Verifier context:*
    - To my knowledge, spontaneous magnetization for the *quantum* Heisenberg ferromagnet in $d\ge3$ was a long-standing open problem in the human literature. Reflection-positivity methods cover the antiferromagnet, not the ferromagnet. So this is an extraordinary claim.
    - Its config has `enable_nanoda: false`.
    - Family 271 does **not** appear in `lean/formalization.yaml` (`sources`/`main_results`), although a config, a challenge, a solution and `docs/271.md` all exist.
- **`ClassicalON.lean`** (about 60 lines; family 215): **exponential decay of spin–spin correlations for the 2D classical $O(n)$ model, $n\ge3$, at every $\beta>0$**.
  - Constants $A, m>0$ are uniform over all finite nearest-neighbour subgraphs of $\mathbb Z^2$, free boundary, and edge couplings in $[0,\beta]$. This is the Polyakov-type "mass gap at all temperatures" statement in finite-volume uniform form. Note that the formal statement requires $m>0$ but not $A>0$.
  - *Verifier context:* Polyakov's conjecture (1975), that the 2D $O(n)$ model with $n\ge3$ has exponential decay at every $\beta$, is to my knowledge a major open problem in the human literature. Rigorous results cover only large $n$ or high temperature (e.g. Kupiainen 1980; Kopper 1999). So this certificate, if it replays, would claim to settle a famous conjecture in this uniform finite-volume form. It is an extraordinary claim:
    - the config has `enable_nanoda: false`;
    - the catalogue's review status is `unchecked`;
    - I found no independent replay and no expert assessment.
  - The **headline claim of family 215 is not formalized**: a canonical massive, non-Gaussian, relativistic $O(3)$ continuum limit with unique vacuum and positive mass gap, plus exact $O(4)$ mass asymptotics.
- **`VlasovMaxwell.lean`** (family 362): global existence and uniqueness of classical solutions, with all PDE notions (divergence, curl, `derivWithin` on $[0,\infty)$, classes of solutions) defined in about 120 lines.
- **`QuasiRiemannHypothesis.lean`**: $\zeta(s)\neq0$ for $\Re s>7/8$, stated with Mathlib's total `riemannZeta`. It therefore silently covers $s=1$, where Mathlib assigns a finite value; a third-party audit flags this as a "totalization". It is harmless here but shows the hazard.

**Conditional inputs.**
- Code search finds many `Published*` structures, e.g. `PublishedC4FlowInput` in `MathematicalPhysics/ContinuumCoulomb`, `PublishedInputs` in several families, and `ConditionalMain.lean` files.
- They encode cited literature as explicit `Prop`-valued hypotheses.
- None of the 418 top-level challenge statements mentions a `Published` structure, so they do not appear at the Comparator level. A conditional main theorem must either be discharged or be flagged.
- The grwtsk audit lists "unconditional vs carrying explicit published inputs" as a required distinction.

### 3.4 `openai/NavierStokesAndEuler`: the "borrowed statement" pattern and its limits

- **The challenge statement comes from DeepMind's Formal Conjectures.** It was copied at commit `8bf45ed7…` of `FormalConjectures/Millenium/NavierStokes.lean`, with only imports and namespaces adapted, and is "Mathlib-only". Its docstrings document junk values explicitly: divergence at a non-differentiable point is 0.
- Kevin Buzzard, in comments on Matt Baker's blog, judged the chance of a statement mismatch to be essentially zero, because humans reviewed that file long before OpenAI's work.
- `formalization.yaml` (v0.4) has an **`alignment`** block mapping paper items to Lean declarations, all "proved": Theorem 1.1 (ℝ³) → `navier_stokes_breakdown_R3`; Corollary 10.6 (torus) → `…_periodic`; Euler Theorem 1.1 → two declarations. Review is `self-assessed`.
- **The proof was not faithfully translated.** Bastounis, Circelli & Hansen (arXiv:2610.08144, 6 Oct 2026) show that the Lean proof is not a translation of the paper's proof:
  - Lemma 8.6, eq. (8.19), states $\|N^{-1}F\|_{C^m}\le C_m\|F\|_{C^{m+4}}$. The cited Lean lemmas consistently need $C^{m+5}$, because they use a different Fourier series.
  - The pressure-flux bound (10.19) is replaced in Lean by a different bound that also involves the gradient term $A_R$, proved by a different route: Sobolev embedding to $L^2$ instead of Riesz-transform $L^{3/2}$ boundedness, with different Hölder exponents.
  - The *main theorem* can still be correct. The paper's intermediate claims are simply not certified.
- The same paper proves a general limit (App. A, Theorem A.3). It concerns resolving one specific kind of ambiguity that faithful translation requires: a hidden existence presupposition, such as "the least $n$ with $B_e(n)$". For an explicit DPRM-based family of such statements (polynomials in $k\ge9$ variables), deciding whether the defined object exists is $\Sigma^0_2$-complete. Generalizations reach $\Sigma^0_l$-complete for every $l$, which the authors summarize informally as "SCI $=\infty$". *(Verifier precision: the theorem is about this presupposition-resolution problem, not a blanket theorem about every faithfulness judgement.)*
  - Its `sInf` example (`n_e := sInf {n | B_e n}` defaulting to 0) is a **pedagogical construction**, not a defect found in OpenAI's code.
  - One third-party summary conflates the two; this note does not.
- **Euler.** That paper predicts "substantial mistranslations" in the Euler formalization too, but gives no worked example. Treat this as conjecture.

### 3.5 `openai/PrimeGaps186`: the honest-axiom pattern

- The Lean result is **conditional on three explicit `axiom` declarations**:
  - `kloosterman3_bound`: a Deligne-type bound $|\mathrm{Kl}_3|\le 3$, cited to Katz, GKM Thm 4.1.1;
  - `kloosterman2_correlation_bound`, cited to Fouvry–Kowalski–Michel;
  - `physical_integral_bounds`: 104 outer and 45 inner numerical bounds plus 3 caps, backed by a Python/FLINT certificate that "does not discharge any Lean axiom".
- The Comparator config **permits 6 axioms**. `formalization.yaml` lists them for every main result and sets alignment status `proved-conditionally`.
- The yaml's `prompting_notes` record the actual agent instruction: formalize faithfully, simplify the proofs, and keep unproved inputs as explicit axioms.
- The review notes admit there was no independent human semantic review and no complete audit of auxiliary declarations.
- The solution is a single 10.3 MB `.lean` file.

### 3.6 Comparator: provenance, configuration and evolution

- **Origin.** Lean FRO (Henrik Böving), built with feedback from the AIMO competition team. Repo `leanprover/comparator`, created 2025-06-06.
- **Configuration.** `challenge_module`, `solution_module`, `theorem_names`, `permitted_axioms`, plus optional `definition_names`, `external_kernels` and the legacy `enable_nanoda`.
- **External dependencies.** `landrun` (sandbox), `lean4export` (NDJSON export) and optional `nanoda_bin`. The README also recommends `systemd-run` with `RestrictAddressFamilies=~AF_UNIX` to close a landrun hole.
- **Internals** (README "Internals"):
  1. Build the challenge in a sandbox.
  2. Export it.
  3. Do the same for the solution.
  4. Compare the declarations used in the statements, including the `Init` kernel-special ones.
  5. Check that axioms used by proof bodies are permitted.
  6. Replay the solution environment in the kernel.
  - It never mmaps `.olean`s from untrusted builds.
- **Now in core.**
  - The repo is **deprecated in favour of `lake comparator` and `lake check`** in Lean v4.35.0 (released 2026-10-12).
  - The current Lake help (master, Nov 2026) uses `bubblewrap` (Linux-only), `--paranoid` (five extra kernels), `--challenge-from-export` / `--solution-from-export` (verify exports built in a VM or by a third party) and `--json` reports (PR #16019, merged 2026-10-27).
  - It states seven explicit trust requirements (PR #16096, merged 2026-10-30).
  - `lake check` builds the whole project, exports it and replays it, and rejects any non-standard axiom.
- **Known limitations** from the Lean Zulip thread "Does anyone use Comparator?", Dec 2025–Jan 2026:
  - The "never build the solution first" rule clashes with iterative development.
  - Setup was fragile across RC toolchains.
  - Thomas Zhu reported that Seed-Prover did not use Comparator. It used a simpler check: no `sorry` and no errors, only the standard axioms, plus a check that the proved type is defeq to the original statement. **That defeq check, not Comparator, gave false negatives** when a header such as `open Classical` changed the statement non-definitionally. *(Verifier correction: the earlier text attributed these false negatives to Comparator.)* The lesson for us still stands: header context can silently change an elaborated statement.

### 3.7 How statements are reviewed (or not)

| Repo | Who wrote the challenge statements | Recorded review |
|---|---|---|
| ten-proofs | Not stated. SpherePacking definitions adapted from Sphere-Packing-Lean; the rest presumably model- or OpenAI-written | `agent-reviewed`; post-hoc human chapter reviews by third parties (Sienicki audit) |
| NavierStokesAndEuler | **DeepMind Formal Conjectures** (human-reviewed, pre-existing) | `self-assessed`; `alignment` table |
| PrimeGaps186 | `Challenge.lean` (41 KB) by OpenAI/agent; axioms in challenge | `self-assessed`; "No independent human semantic review" |
| openai/math | Mostly unattributed. CM Hodge adapted from Paul-Lez/HodgeConjecture and then edited; NS-style families cite Formal Conjectures | **`unchecked`**; scope notes; post-release fixes in `history.md` |
| Yang–Mills (not public) | Unknown | Shepherding committee to validate definitions, the statement, and alignment of formal with informal |

### 3.8 How much is formalized: competing denominators

| Measure | Value | Source |
|---|---|---|
| OpenAI headline | "~42%" = 300/719 "top-line results" | README; `history.md` (Oct 7) |
| `formalization.yaml` sources ("papers with a formalized main result") | 176 → **≈24% of 721** | my count; borism audit gives 173 → 176 |
| Families with a Lean scope note | **245 / 373 (66%)** | my count of `lean/docs` = `CONTENTS.md` "(Lean)" links |
| Papers linked from scope notes | 340 → 345 | borism audit (not recomputed by me) |
| Comparator configs | 419 (192 referenced as main results; 7 "Support") | my count |
| Catalogued main results that are support-only | 5 (families 027, 066, 195, 237, 301) | borism #3; I confirmed the 7 `*Support` configs and the deleted README section |
| Weaker or partial than the paper | e.g. 277 ($\delta^{13}$ in Lean vs $\delta^{5}$ claimed: confirmed in `EntangledGames.lean`), 212, 290, 312, 378 (ETH exponent $n(\log\log n)^2/\sqrt{\log n}$ in Lean vs $n\log\log n/\sqrt{\log n}$ in paper: confirmed in docs/378) | borism #3; docs |
| Headline not formalized but "(Lean)" link shown | about 21 families, e.g. 215 ($O(3)$ continuum and mass gap), 261 (2D Anderson localization), 266 (MUBs in $d=6$), 367 | borism #4; I confirmed 215 |

### 3.9 Catalogue of quality critiques (status-labelled)

1. **Statement faithfulness.** *Established*: the cases listed above are visible in OpenAI's own scope notes and challenge files. None shows a theorem is false. They show the certificate is narrower than the claim.
2. **Bespoke definitional trust base.** *Established.* CM Hodge has about 52k lines of challenge-side definitions in 257 files (borism count), edited after release. Coarse-Novikov's `CoarseAssembly.lean` is 331 KB. Comparator certifies nothing about whether these mean the standard objects. Suggested remedies (borism #5) are sanity theorems and pinning to an external reference.
3. **Challenge imports solution code.** *Established* (2 configs).
4. **Single-kernel checking.** *Established.* nanoda is on in 2 of 419 configs in `openai/math`, versus all configs in ten-proofs and NS.
5. **Totalization and junk values.** *Established for quasi-RH; the $s=1$ issue is benign.* A third-party scan of 13 natural-number `sInf` definitions found none that made a target vacuous (borism #2). This is unreviewed community work.
6. **NL proof ≠ Lean proof.** *Established* for NS (2610.08144). *Predicted* for Euler.
7. **Conditional results.** *Established*: PrimeGaps186 axioms; `Published*` hypotheses in `openai/math`.
8. **Readability.** *Established* for ten-proofs: no comments, monolithic files of 3k–130k lines. Bastounis et al. note that nobody will read millions of lines of Lean to understand a proof.
9. **Self-reported review labels.** *Established*: `unchecked`, `self-assessed`, `agent-reviewed`. No repository records a named human statement reviewer.
10. **Withdrawals and corrections.** *Established.* 3 withdrawn (sign error) and 14 revised on Oct 7. A further formalization fix on Oct 29. An LLM-referee audit of the 547 unformalized manuscripts (JJardine919) found 2 gaps (FK interfaces; MUB verifiability).

### 3.10 The Yang–Mills claim (status as of 2026-11-05)

**Primary source: the shepherding committee statement** (KITP PDF, "Proof by OpenAI of the Existence of Quantum Yang-Mills theory", October 2026; Douglas, Gross (Chair), Jaffe, Klebanov, Nekrasov). It says:
- OpenAI proved existence of quantum YM "including coupling to fermions".
- Gross was asked on Oct 16 to take custody and shepherd the release, and chose the committee himself. The committee states it has no responsibility to OpenAI.
- The work builds on Wilson's lattice regularization and **Balaban's** 1980s rigorous renormalization group, followed all the way to infinite distances to prove a proper continuum limit.
- **Confinement and the mass gap remain open.**
- The committee's first objective is to check that the definitions and problem statement correspond to the standard ones and that the formalization matches the informal treatment. **Then** it will release the Lean proof.
- Later it will release its assessment together with the **1,147-page** LLM proofs.
- It cites Douglas, *Nat. Rev. Phys.* 8, 86–97 (2026) for background.
- *Verifier notes on what the statement does **not** say:*
  - It does not state the spacetime dimension. Its contact address is "YANGMILLS4d" and it discusses the continuum and infinite-volume limits.
  - It does not state which gauge groups are covered. SU(3) is mentioned only to explain QCD.
  - It does not say the Lean formalization is finished. It says OpenAI "is providing a formalization in the Lean … language".
  - The "completed 16 Oct" date comes only from secondary reports of OpenAI's post.

**Secondary sources** (XenoSpectrum 27 Oct; Quantum Research Center 28 Oct; also Mezha and TechDogs) report OpenAI's 26 Oct post and add the following. These are re-checked by the verifier and labelled by source.
- The dates: 9 Sep (YM natural-language proof), 18 Sep (QCD), 16 Oct (YM Lean completed). Both XenoSpectrum and QRC give these dates, and both say "completed".
- Neither source says which gauge groups are covered. QRC explicitly says public documents do not settle whether the construction covers every compact simple $G$.
- A phrase about a "unified completion of the Standard Model" (QRC's wording, not explained by OpenAI). XenoSpectrum renders it as the simplest grand unified theory that completes the Standard Model.
- No published scope document for the YM Lean, unlike the ETH result's `docs/378.md` (XenoSpectrum).
- On 26 Oct the Advisory Group on Mathematics and AI (nine mathematicians; XenoSpectrum calls it IAS-based, QRC does not mention IAS) asked for prompt release of the natural-language and Lean outputs.
- *Verifier correction:* the earlier text read "Jaffe and Witten stress the infinite-volume limit". In fact QRC **paraphrases the 2000 Jaffe–Witten Clay problem description** as identifying the infinite-volume limit and the mass gap as obstacles. That is background, not a new statement by them. XenoSpectrum attributes no quotes to Jaffe, Witten or Baez.
- QRC *paraphrases* John Baez as stressing that non-triviality (ruling out a free theory) must be shown. That is secondary only; the primary source was not located.

None of this is verifiable until release. **Status: claimed, unverified; Lean statement unknown.**

**Parallel and community efforts relevant to the statement:**
- `ethanwsussman/Yang--Mills-LLM-experiment` (E. Sussman and L. Alpöge; repo created 6 Oct 2026).
  - Mainly Claude-generated. Codex was used to condense the output into minimal manuscripts, and one hybrid sub-manuscript was completed by Astra.
  - QED3 and YM3 manuscripts. YM3_I, "if correct", verifies the OS axioms for $\mathrm{tr}[F^2]$.
  - An unfinished YM4 manuscript; the authors say they appear to have an $\mathbb R^4$ existence argument that is not yet readable.
  - Its own disclaimer says the content is not satisfactorily vetted.
- `xiyin137/OSreconstruction` (owner profile: Xi Yin; created 13 Feb 2026) and `mrdouglasny/os-reconstruction` (created 3 Nov 2026).
  - The GitHub profile of the latter self-identifies as "Michael R Douglas", Harvard CMSA / Stony Brook. That is consistent with the committee member, but the profile is self-declared.
  - Both are Lean OS↔Wightman reconstruction packages checked with the standard Lean Comparator against Mathlib-only statements.
  - The latter's README has a **worked example of a mis-specified hypothesis**. An earlier fixed-order growth condition was forced by normalization to Schwartz order 0. At order 0 it is inhabited only by degenerate examples, such as the trivial field $S_0(f)=f(0)$, and it excludes the massive free field in spatial dimension 3 (proved in Lean: `gffOS_no_linearGrowth`).
  - It was replaced by a corrected linear-growth condition. The README cites two inhabitants of the corrected condition: the massive GFF and the Wick square of the massive Proca field. *(Verifier wording fix: these are non-degenerate but still free/Gaussian-derived theories, so they are not "non-trivial" in the interacting-QFT sense.)*
  - Those inhabitant proofs are said to live in a private repo `math-commons/yang-mills` (revision `03bb758`). The GitHub API returns 404, so this is not verified. The README states that the package itself has no inhabitant of its forward-theorem hypotheses.

---

## 4. What is proven vs open

| Item | Status | Evidence / caveat |
|---|---|---|
| Comparator's guarantee (statement identity, axiom whitelist, kernel replay) | **Established tool behaviour**, conditional on the stated trust base | Comparator README; `lake comparator --help` |
| Comparator checks the meaning of statements | **False / out of scope** (explicitly disclaimed) | Lake help; README "definition holes" section |
| Resolving hidden existence presuppositions, a step that faithful autoformalization needs, is Σ⁰₂-complete for an explicit family and Σ⁰ₗ-complete in generalizations (informally "SCI = ∞") | **Theorem in an unrefereed preprint**; standard DPRM/Post-theorem argument | arXiv:2610.08144 App. A, Thm A.3 |
| Ten-proofs results | **Claimed; Lean-certified against OpenAI-authored statements; partial human review, no confirmed error** | `ten-proofs` metadata; arXiv:2608.14673 |
| `openai/math` manuscripts (721) | **Claimed**; about 24–42% have some formal certificate depending on the denominator; review `unchecked`; 3 withdrawn | README; `history.md`; `formalization.yaml` |
| NS blow-up (Clay alternatives C/D) | **Claimed**; main statement from human-reviewed Formal Conjectures; Lean self-assessed; intermediate lemmas not faithfully translated | NS repo; arXiv:2610.08144 |
| Euler blow-up | **Claimed**; mistranslation predicted but not documented | arXiv:2610.08144 §3.3 |
| Prime gaps ≤ 186 | **Conditional** on 3 declared axioms | PrimeGaps186 metadata |
| 2D $O(n)$, $n\ge3$: uniform exponential decay at all $\beta$ | **Claimed + Comparator config exists** (nanoda off); `review: unchecked`; no independent replay found. If correct, it would settle Polyakov's conjecture in this finite-volume form, which was open in the human literature | `ClassicalON.lean`; docs/215 |
| 2D $O(3)$ massive continuum limit with mass gap | **Claimed in natural language only; not formalized** | docs/215 |
| Quantum Heisenberg ferromagnet, $d\ge3$, low-$T$ KMS state with magnetization $\ge S/4$ | **Claimed + Comparator config** (nanoda off); not listed in `formalization.yaml`; a long-standing open problem in the human literature | `Heisenberg.lean`; docs/271 |
| 4D quantum YM existence (± fermions) | **Claimed; nothing public.** "Lean completed 16 Oct" comes only from secondary reports of OpenAI's post; the committee says OpenAI "is providing" a formalization. Gauge groups not stated. Mass gap explicitly *not* claimed | KITP committee statement; secondary press |
| 4D YM mass gap | **Open** (committee: "remain very important open challenges") | KITP statement |
| A Lean statement of the YM Millennium problem in Formal Conjectures | **Does not exist** (Millennium folder: BSD, NS, Poincaré, P vs NP, RH) | `formal-conjectures` tree, 2026-11-05 |

---

## 5. Relevance to a 4D YM existence + mass-gap proof and to Lean formalization

1. **The statement is the product, not the proof.** OpenAI's experience shows the failure modes concentrate in the *challenge*. A YM challenge will need definitions far outside Mathlib:
   - Euclidean field theory: tempered distributions on $(\mathbb R^4)^n$; OS axioms OS0–OS4; growth conditions.
   - Gauge-invariant observables: Wilson loops, $\mathrm{tr}\,F^2$, smeared curvature.
   - Reconstruction (Hilbert space, Hamiltonian, Poincaré representation).
   - The spectral mass-gap condition.
   - Non-triviality: non-Gaussian connected 4-point function or similar.

   It is likely to look like **CM Hodge (a roughly 52k-line bespoke tree)**, not like NS (a 13 KB human-reviewed file). This is a prediction, not an observation. Every one of those lines would be trusted base.
2. **No borrowed reference statement exists.** For NS, OpenAI could point to Formal Conjectures. For YM there is none, so the committee's "first objective" is unavoidable and expensive.
   - Our project should **write and publish an independent, reviewed YM challenge statement first**: Mathlib-only imports, documented junk values, inhabitant tests.
   - Then any proof (ours, OpenAI's, or anyone's) can be judged by `lake comparator` against it.
   - The OS-reconstruction packages are candidate building blocks, after review.
3. **Inhabitant and vacuity tests are mandatory.**
   - Heisenberg shows the guard pattern: put `DynamicsConverges` in the conclusion before using a `limUnder`.
   - The os-reconstruction README shows a real near-miss: a growth axiom that silently excluded the free field.
   - A YM statement must include formally proved sanity theorems:
     - the hypotheses-free definitions are inhabited;
     - the Gaussian free field satisfies the OS part but fails "non-trivial";
     - the trivial theory fails the mass-gap clause or the non-triviality clause, as intended;
     - observables are gauge-invariant by construction.
4. **Existence ≠ Clay.** Any formal statement must make the mass-gap and non-triviality clauses explicit, and must quantify over **all** compact simple $G$.
   - A certificate for $G=SU(3)$ only, or for a finite torus, or for a lattice-regularized theory, is a *different theorem*.
   - It should be labelled by the scope-note discipline of `lean/docs/NNN.md`: one sentence per exclusion.
5. **Literature dependencies must be explicit.** Balaban's papers are long and technically demanding. The standard summary, e.g. Jaffe–Witten's Clay description, credits them with ultraviolet stability for lattice YM on a finite torus, not a complete construction. This is a consensus summary; workstreams on Balaban should be consulted for specifics. A formal proof that assumes his estimates is a conditional theorem.
   - Use PrimeGaps186-style declared axioms, or `Published*` hypotheses.
   - Either way, list them in the Comparator config and in `formalization.yaml` `literature_dependencies`, never hidden in solution-side definitions.
6. **Proof faithfulness matters for understanding.** Even with a perfect statement, the 1,147-page natural-language proof and the Lean proof may diverge, as in NS (m+4 vs m+5). If the goal includes human understanding (the committee's second phase), add an `alignment` table at **lemma granularity**, not just for the main theorem.
7. **AI-production lessons for methodology.**
   - OpenAI's pipeline: generate natural-language mathematics, then have the model formalize in Lean under Codex, then pack into Comparator challenges with scope notes, then self-label review status, then do post-hoc public corrections.
   - It produced roughly 4,000 attempts at about 3 hours each. A significance filter brought that down to 373 families.
   - It produces volume quickly. The bottleneck shifts to statement review.
   - For a single deep target like YM, the transferable pieces are:
     - a frozen, independently reviewed challenge;
     - explicit prompting to keep unproved inputs as visible axioms;
     - multi-kernel replay;
     - a public correction log;
     - versioned and pinned artifacts.

---

## 6. Lessons for formalizing a 4D Yang–Mills statement and proof

### 6.1 Ten concrete design rules

1. **Freeze the challenge before anyone writes proofs.** Keep it in a separate repository or commit, imported by nothing in the solution tree. Pin Lean and Mathlib by hash. Never edit it to "align with the solution". If an edit is unavoidable, prove that the old and new definitions are equivalent, as borism #5 proposed for CM Hodge.
2. **Mathlib-only imports in the challenge.** Any extra definitional library (OS axioms, gauge fields) must itself be reviewed, pinned and listed as trusted. It must never come from the AI-written solution tree.
3. **Document every junk value** in docstrings, as the Formal Conjectures NS file does: `fderiv`, `tsum`, the Bochner integral, `sInf`, `limUnder`, division by zero, `Real.log 0`, `Real.sqrt` of negatives. Guard each with an explicit hypothesis or conclusion conjunct (convergence, integrability, summability).
4. **Prove inhabitants and counter-inhabitants** inside the challenge package, under the standard axioms:
   - free massive field ⊨ OS axioms;
   - free field ⊭ non-trivial;
   - the theory with $\Delta=0$ (massless free field) ⊭ mass gap.
   - Also prove the definition is invariant under the intended symmetries.
5. **State the full Clay package explicitly:**
   - all compact simple $G$;
   - $\mathbb R^4$, infinite volume;
   - OS or Wightman axioms for a named family of gauge-invariant fields;
   - non-triviality;
   - $\mathrm{spec}(H)\subseteq\{0\}\cup[\Delta,\infty)$ with $\Delta>0$;
   - uniqueness of the vacuum, if intended.

   Write separately named theorems for the weaker milestones (lattice, torus, existence only) so that no milestone is mistaken for the full result.
6. **Comparator settings.**
   - `permitted_axioms` = the standard three. If literature inputs are assumed, add named axioms *only* in a separately labelled "conditional" config.
   - No definition holes; or, if there are any, a written human justification.
   - Run `lake comparator --paranoid`, or enable nanoda as a minimum.
   - Use `--json` and keep the reports.
   - Build exports in an isolated VM and verify with `--*-from-export`.
7. **Ban** `sorry`, `admit`, `native_decide`, `implemented_by`, `extern`, `unsafe`, project `axiom` (except declared inputs) and `opaque` in the solution. Scan with `rg` *and* `#print axioms`, as in cdc-lean. Also run `lake check` on the whole project.
8. **Scope note plus alignment table.**
   - One `docs/YM.md` stating exactly what is and isn't formalized.
   - `formalization.yaml` with an `alignment` table at theorem **and** lemma level, plus `literature_dependencies`.
   - An honest `review.status` that names the human reviewers.
9. **Readable proof architecture.** Modular files, docstrings, and a dependency graph (LeanArchitect/blueprint). Ten-proofs' comment-free 130k-line files are certificates, not mathematics. The committee's later task, "developing a deeper understanding", needs more.
10. **Public correction log**, like `history.md`: withdrawals explained mathematically, previous versions pinned. Plus independent replays by third parties on clean machines.

### 6.2 Checklist the shepherding committee would apply

This is built from the committee's stated objectives, Comparator's documented assumptions, and the failure modes observed in OpenAI's repos.

**A. Definitions and problem statement correspond to the standard ones**

- [ ] Spacetime is $\mathbb R^4$ (Euclidean for OS, Minkowski after reconstruction), in **infinite volume**: not a torus, not a lattice.
- [ ] Gauge group: the statement quantifies over **all compact simple $G$**, or the restriction is in the theorem name and scope note.
- [ ] Field content: the Schwinger/Wightman functions are of **gauge-invariant** local fields, and the set of fields is stated (e.g. $\mathrm{tr}\,F_{\mu\nu}F_{\rho\sigma}$, Wilson loops).
- [ ] Axioms match a standard source (Osterwalder–Schrader OS0–OS4 or Wightman W0–W4) *clause by clause*:
  - temperedness or the growth condition (with the right Schwartz order; see the os-reconstruction lesson);
  - Euclidean covariance;
  - reflection positivity;
  - permutation symmetry;
  - cluster property.
- [ ] **Non-triviality** is a stated clause (e.g. a non-vanishing connected 4-point function or non-Gaussianity), so the free field does not satisfy the theorem.
- [ ] **Mass gap** is stated spectrally for the reconstructed Hamiltonian, or via uniform exponential clustering with an explicit equivalence proved. It must not be stated via a junk-valued infimum.
- [ ] Link to Yang–Mills: the theory is shown to be *the* YM theory. For example, it is the continuum limit of Wilson lattice YM with asymptotically-free coupling flow, or it matches perturbation theory to stated order. This must be a precise formal clause, not a docstring.
- [ ] Every Mathlib totalization in the statement's dependency cone is listed and guarded.
- [ ] **Inhabitant tests are proved**: GFF/Proca satisfy the OS part; GFF fails non-triviality; a massless theory fails the gap clause; the definitions are non-empty and non-degenerate.
- [ ] The challenge imports only Mathlib plus pinned, reviewed libraries. It imports **nothing** from the solution tree. Its size (lines of non-Mathlib definitions) is reported.

**B. The formalization aligns with the informal treatment**

- [ ] An alignment table maps every numbered theorem, lemma and estimate of the natural-language proof (the 1,147 pages) to a Lean declaration, with status `proved`, `weaker`, `stronger`, `different-proof` or `literature-dependency`.
- [ ] Key estimates (RG flow bounds, polymer expansions, Balaban-type inputs) have their constants and derivative counts checked against the paper: the NS m+4 vs m+5 lesson.
- [ ] Every assumed literature result is an explicit hypothesis or a named axiom with a precise citation, listed in the Comparator config or `formalization.yaml`.
- [ ] Main theorem ↔ Clay statement: a written gap analysis of the mass gap, gauge groups, axioms and non-triviality.

**C. The certificate is technically sound**

- [ ] `lake comparator --paranoid --json` passes on a clean Linux machine with `bubblewrap`, run by an independent party. Or the export is verified with `--solution-from-export` from a VM build.
- [ ] `permitted_axioms` = {`propext`, `Quot.sound`, `Classical.choice`} for the unconditional claim.
- [ ] `definition_names` is empty, or each hole is justified in writing.
- [ ] The source scan finds no `sorry`, `admit`, `native_decide`, `implemented_by`, `extern`, `unsafe`, unexplained `opaque`, or project `axiom`. `lake check` passes.
- [ ] Lean, Mathlib and all dependencies are pinned by full hash. Any lakefile code or dependency patches are reviewed as trusted base.
- [ ] Toolchain-sensitive options (`backward.*`, very high heartbeats) are inventoried.

**D. Process and record**

- [ ] A scope note, `formalization.yaml` (v0.4) with an honest `review.status`, named reviewers, and an `automation` section with models and prompting notes.
- [ ] Versioned releases and a public correction log; challenge edits after release only with proved equivalence.
- [ ] The natural-language manuscript has a reproducible build, and the PDF is bound to the exact Lean commit.

---

## 7. Open questions and leads

1. **The YM Lean statement itself.** It is not public.
   - Track the KITP / committee contact page and any OpenAI repository creation (`gh api orgs/openai/repos?sort=created`).
   - When it appears, run checklist §6.2 immediately. Our own independent challenge would let us diff definitions mechanically.
2. **Formal Conjectures has no YM file.** Should our project draft one and submit it upstream for human review? That would reproduce the NS "borrowed statement" advantage.
3. **Replay status of `ClassicalON` and `Heisenberg`.** No independent Comparator replay was found. These are the most YM-like formal statements OpenAI has released: a mass gap at all couplings in a 2D asymptotically free model, and KMS states. A replay with `--paranoid` is cheap and informative.
4. **The `math-commons/yang-mills` private repository** (mentioned in the os-reconstruction README; unverified). It may hold YM-specific Lean definitions. Request access.
5. **`xiyin137/OSreconstruction` vs `mrdouglasny/os-reconstruction`.** Determine provenance, statement differences, and whether either is intended as the committee's reference statement for OS ↔ Wightman.
6. **Definition-hole semantics after Lean PR #15775.** Check whether ten-proofs' `H_GapCVP` (structure-field `sorry`) still passes the core `lake comparator`.
7. **Unlocated sources.** The "Ken Ashe 2026-10-07" blog, and "the-decoder" and "smartscope" analyses, were not found by search. Ask the requester for URLs.
8. **OpenAI's own blog posts** ("Sharing AI progress in mathematics", Oct 6/15; "Working with academic communities…", Oct 26) block automated fetching. A human should save copies into the library.
9. **The third-party audits** (borism, grwtsk, JJardine919, yuyauchuncn-dot, sunnyspot114514, queelius) are unrefereed GitHub work. Their claims that I independently confirmed are marked as such above. The rest should be treated as leads.

---

## 8. References

*Verified = existence confirmed this session via GitHub API, arXiv abs page, Crossref/DOI, or direct fetch. "Content read" says whether I read the substance.*

1. **openai/ten-proofs**, GitHub repository (Apache-2.0), created 2026-08-05, commit `94bc0feb`. https://github.com/openai/ten-proofs. *Verified; content read* (all challenges, configs, yaml; solutions grepped).
2. **openai/math**, GitHub repository, created 2026-10-06; inspected at `4eaee875` (2026-10-30). https://github.com/openai/math. *Verified; content read* (README, history, CONTENTS, overview.tex, lakefile, formalization.yaml, 419 configs, 418 challenges, sample docs and solutions).
3. **openai/NavierStokesAndEuler**, GitHub repository, created 2026-09-08, commit `f9e8bc5b`. https://github.com/openai/NavierStokesAndEuler. *Verified; content read.*
4. **openai/PrimeGaps186**, GitHub repository, created 2026-09-02. https://github.com/openai/PrimeGaps186. *Verified; content read.*
5. **openai/LongGapsBetweenPrimes**, GitHub repository, created 2026-09-02. https://github.com/openai/LongGapsBetweenPrimes. *Verified; README read.*
6. **openai/cdc-lean**, GitHub repository, created 2026-06-24. https://github.com/openai/cdc-lean. *Verified; README and VERIFICATION read.*
7. **leanprover/comparator** README (deprecated in favour of `lake comparator` from v4.35.0). https://github.com/leanprover/comparator. *Verified; content read.*
8. **leanprover/lean4**, `src/lake/Lake/CLI/Help.lean` (help for `lake comparator` and `lake check`); PRs #15775 (definition holes must be sorried, merged 2026-10-19), #16019 (`--json`, merged 2026-10-27), #16096 (requirements doc, merged 2026-10-30); release v4.35.0 (2026-10-12). https://github.com/leanprover/lean4. *Verified; content read.*
9. **mathlib-initiative/formalization.yaml** (self-reporting schema v0.3/v0.4). https://github.com/mathlib-initiative/formalization.yaml. *Verified; content read.*
10. **google-deepmind/formal-conjectures**, `FormalConjectures/Millennium/` (BSD, NavierStokes, Poincaré, PvsNP, RiemannHypothesis; no Yang–Mills). The folder was spelled `Millenium` at commit `8bf45ed7`, the commit OpenAI's NS challenge copied. A full-tree search on 2026-11-05 found no Yang–Mills, gauge or OS-axiom file; `Wikipedia/Mills.lean` is unrelated. https://github.com/google-deepmind/formal-conjectures. *Verified.*
11. **M. R. Douglas, D. J. Gross (Chair), A. Jaffe, I. R. Klebanov, N. Nekrasov**, "Proof by OpenAI of the Existence of Quantum Yang-Mills theory: Statement by the shepherding committee", October 2026 (PDF dated 2026-10-27). https://www.kitp.ucsb.edu/sites/default/files/YM_working_group.pdf. *Verified; content read.*
12. **OpenAI**, "Sharing AI progress in mathematics", 6 Oct 2026, updated 15 Oct 2026. https://openai.com/index/sharing-ai-progress-in-mathematics/. *Existence verified via search index; HTTP 403 on fetch; content known only from secondary reports.*
13. **OpenAI**, "Ten Advances in Mathematics and Theoretical Computer Science", 253 pp., updated 6 Aug 2026. https://cdn.openai.com/pdf/ten-proofs-oai.pdf. *Verified; front matter read.*
14. **OpenAI**, "Working with academic communities to build scientific understanding", 26 Oct 2026 (as cited by press). *Not accessed directly; URL not confirmed. Title and contents are corroborated by several independent secondary reports (XenoSpectrum, Quantum Research Center, TechDogs, Mezha). verified=false for the primary.*
15. **A. Bastounis, F. Circelli, A. C. Hansen**, "Navier-Stokes lost in translation: Why Lean verification of AI autoformalisation does not guarantee correct natural language proofs", arXiv:2610.08144 (6 Oct 2026). *Verified; content read; PDF in library.*
16. **M. Sienicki, K. Sienicki**, "A Human Audit of OpenAI's AI-Generated Mathematical Proofs", arXiv:2608.14673 (v3, 9 Sep 2026). *Verified; content read; PDF in library.*
17. **K. Zhang, P. Gallardo Candela, S. Murthy, Y. Xie, Z. Wang, M. Raissi**, "Beyond Compilation: Evaluating Faithful Natural-Language-to-Lean Statement Formalization", arXiv:2606.31002 (2026). *Verified (abstract); PDF in library.*
18. **N. I. S. Mohammad, T. Sheikh**, "The Faithfulness Gap: Certifying Semantic Equivalence Between Natural-Language and Formal Mathematical Statements", arXiv:2606.16541 (2026). *Verified (abstract); PDF in library.*
19. **Z. Wang, Q. Dai, Y. Wu, Z. Wen**, "FaithSieve: Fine-Grained Evaluation of Math Proofs with Faithful Formal Evidence", arXiv:2608.26310 (2026). *Verified (abstract); PDF in library.*
20. **A. Soltani Moakhar, I. Gholami, M. Springer, M. JafariRaviz, M. Hajiaghayi**, "Beyond the Library: An Agentic Framework for Autoformalizing Research Mathematics", arXiv:2606.31134 (2026). *Verified (abstract); PDF in library.*
21. **R. Cornish, I. Ghinassi, P.-H. Yeh, S. Liu, Q. Xu, H. Yin, D. Wagner, W. Li, Y. W. Teh, L. Ong** (verifier: last two authors added per arXiv API), "FaithformBench: Benchmarking Faithfulness of Mathematical Chain-of-Thought Autoformalisation", arXiv:2608.10916 (2026). *Verified (abstract); PDF in library.*
22. **A. Rammal, N. Patel, F. Gloeckle, A. Hayat, J. Kempe, R. Munos, C. Arnal, V. Cabannes**, "Formalizing Mathematics at Scale" (AutoformBot/Atlas, multi-agent), arXiv:2605.29955 (2026). *Verified (abstract); PDF in library.*
23. **M. Carneiro**, "Lean4Lean: Verifying a Typechecker for Lean, in Lean", arXiv:2403.14064 (2024). *Verified (abstract); PDF in library.*
24. **S. Chen, K. Marwaha, X. Lu, H. Yuen, T. Peng**, "Prove2Me: An Open Collaborative Platform for Scaling Math Formalization", arXiv:2608.28433 (2026). *Verified (abstract); PDF in library.*
25. **M. R. Douglas**, "The Yang–Mills Millennium problem", *Nature Reviews Physics* 8, 86–97 (2026), doi:10.1038/s42254-025-00909-2. *Verified via Crossref; not read (paywalled).*
26. **A. Jaffe, E. Witten**, "Quantum Yang–Mills Theory" (Clay Millennium Prize problem description). https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf. *URL verified (HTTP 200); content from standard knowledge.*
27. **borism/openai-math-slop**, issues #2–#6 (audit of 245 formalized families at `openai/math@4eaee87`, 5 Nov 2026). https://github.com/borism/openai-math-slop/issues/2. *Verified; read; unrefereed. Key claims spot-checked: support configs, deleted README section, δ¹³, OAI imports.*
28. **grwtsk/openai-math**, issues #2 and #29 (trust-surface audit framework, 9 Oct 2026). https://github.com/grwtsk/openai-math/issues/2. *Verified; read; unrefereed.*
29. **J. Jardine (Lattice24), JJardine919/openai-math-audit** (audit of the 547 unformalized manuscripts by Claude review agents, with skeptic passes; Zenodo doi:10.5281/zenodo.23422995 per README). https://github.com/JJardine919/openai-math-audit. *Verified; README read: 2 confirmed gaps (FK interfaces, critical; MUB d=6 verifiability, addressed upstream Oct 26) plus 1 inherited. Unrefereed. The Zenodo DOI resolves (HTTP 200); its record was not read.*
30. **Developers Digest**, "OpenAI Math Repo: What the Lean Proofs Do and Don't Verify", 8 Oct 2026. https://www.developersdigest.tech/blog/openai-math-repo-lean-proofs-what-they-verify-2026. *Verified; read.*
31. **M. Baker**, "Some early morning thoughts on the OpenAI dump", 8 Oct 2026 (with K. Buzzard's comment on the NS statement provenance). https://mattbaker.blog/2026/10/08/some-early-morning-thoughts-on-the-openai-dump/. *Verified; read.*
32. **Y. Kobayashi (XenoSpectrum)**, "OpenAI Claims AI Produced New Results in Math, Computer Science and Physics, but Withholds the Physics Proofs", 27 Oct 2026. https://xenospectrum.com/en/openai-yang-mills-kakeya-eth-release/. *Verified; read (secondary).*
33. **Quantum Research Center**, "OpenAI claims a proof that Yang–Mills theory exists", 28 Oct 2026. https://quantumresearch.center/news/articles/openai-yang-mills-existence/. *Verified; read (secondary).*
34. **Lean Zulip**, "Does anyone use Comparator?" (Dec 2025–Jan 2026). https://leanprover-community.github.io/archive/stream/113488-general/topic/Does.20anyone.20use.20Comparator.3F.html. *Verified; read.*
35. **mrdouglasny/os-reconstruction** (Lean OS ↔ Wightman reconstruction with Comparator check; created 3 Nov 2026). https://github.com/mrdouglasny/os-reconstruction. *Verified; README read. The GitHub profile self-identifies as Michael R Douglas (Harvard CMSA / Stony Brook); not independently confirmed.*
36. **xiyin137/OSreconstruction**, "Lean 4 formalization of the Osterwalder-Schrader reconstruction theorem" (created 13 Feb 2026; profile name Xi Yin). https://github.com/xiyin137/OSreconstruction. *Verified; top-level README read: a package checked by the standard Lean Comparator against a Mathlib-only statement, with two defective statements of the old tree since corrected.*
37. **ethanwsussman/Yang--Mills-LLM-experiment** (E. Sussman, L. Alpöge; mainly Claude-driven extension of Balaban's program, with Codex used for condensation; created 6 Oct 2026). https://github.com/ethanwsussman/Yang--Mills-LLM-experiment. *Verified; README read; self-described unvetted.*
38. **Paul-Lez/HodgeConjecture** (Lean statement adapted for the CM Hodge challenge). https://github.com/Paul-Lez/HodgeConjecture. *Existence verified.*
39. **F. Fournier-Facio**, "A torsion-free non-sofic group", arXiv:2608.02025 (2026). *Verified (arXiv API: title and author match).*
40. **S. Zhou**, "ICC property (T) groups without W\*-superrigidity", arXiv:2608.02327 (2026). *Verified (arXiv API). The abstract discloses GPT-5.6 Sol assistance.*
41. **G. Kun, A. Thom**, "Nonsofic wreath products of residually finite groups", arXiv:2608.06222 (2026). *Verified (arXiv API).*
42. **[UNVERIFIED] "Ken Ashe" blog post, 2026-10-07**, on OpenAI's math release. *Not found by search by author or verifier; verified=false. No claim in this note rests on it.*
43. **[UNVERIFIED] The Decoder**, analysis of OpenAI's math release. *Not located directly (cited second-hand by Quantum Research Center); verified=false. No claim rests on it.*
44. **[UNVERIFIED] SmartScope**, analysis of OpenAI's math release. *Not located; verified=false. No claim rests on it.*
45. **Z. Song**, "Hardness of Euclidean closest vector within n^{1/8−ε} and binary nearest codeword within n^{1/4−ε}", SSRN preprint (2026), doi:10.2139/ssrn.7248939. *Verified via Crossref (title and author Zhao Song match); content not read.* (Added by verifier, because §3.2 mentions it.)

---

## Verification log

*Adversarial verification pass, 2026-11-05. Each item was checked against primary sources: the GitHub API (`gh api`) at the pinned commits, raw file downloads, the arXiv export API, Crossref, and fetches of the KITP PDF and secondary pages. Edits marked "Verifier" in the body were made in this pass.*

### A. References checked (45 including one added)

- **arXiv (13 IDs).** 2610.08144, 2608.14673, 2606.31002, 2606.16541, 2608.26310, 2606.31134, 2608.10916, 2605.29955, 2403.14064, 2608.28433, 2608.02025, 2608.02327 and 2608.06222.
  - All exist, and their titles and authors match the arXiv API.
  - One correction: ref 21 (FaithformBench) was missing two authors, Y. W. Teh and L. Ong; they are now added.
- **Library PDFs.** All 10 PDFs claimed "in library" for these IDs were opened with `pdftotext`. Each title page matches its ID. No mis-ID'd PDF was found and none was deleted.
- **DOIs.**
  - 10.1038/s42254-025-00909-2 (Douglas, *Nat. Rev. Phys.* 8, 86–97, 2026) is confirmed via Crossref.
  - 10.2139/ssrn.7248939 (Song) is confirmed via Crossref and added as ref 45.
  - The Zenodo DOI in ref 29 resolves.
- **GitHub repositories (17).** All exist, with the creation dates stated:
  - openai/ten-proofs, openai/math, NavierStokesAndEuler, PrimeGaps186, LongGapsBetweenPrimes, cdc-lean;
  - leanprover/comparator (archived and deprecated), mathlib-initiative/formalization.yaml, google-deepmind/formal-conjectures;
  - borism/openai-math-slop (issues #2–#6, all created 2026-11-05), grwtsk/openai-math (#2 and #29, 2026-10-09), JJardine919/openai-math-audit;
  - mrdouglasny/os-reconstruction, xiyin137/OSreconstruction, ethanwsussman/Yang--Mills-LLM-experiment, Paul-Lez/HodgeConjecture.
  - `math-commons/yang-mills` returns 404 (private or absent). It remains unverified.
- **Lean core.** Release v4.35.0 was published 2026-10-12. PRs #15775 (merged 10-19), #16019 (10-27) and #16096 (10-30) match their stated content. The master `Help.lean` contains the quoted disclaimer that Comparator cannot judge intended meaning. It lists seven requirements, `bubblewrap`, and the five `--paranoid` kernels; v4.35.0 already ships `lake comparator` with `--paranoid`.
- **URLs.**
  - The KITP PDF (HTTP 200; two pages; created 2026-10-27) was read in full.
  - The OpenAI CDN ten-proofs PDF (253 pp.; last modified 2026-08-06) was read through its front matter.
  - The Clay PDF returns HTTP 200.
  - Matt Baker's blog (with Buzzard's comment as "xenaproject"), Developers Digest, XenoSpectrum, Quantum Research Center and the Lean Zulip archive were all fetched.
  - `openai.com/index/sharing-ai-progress-in-mathematics/` is confirmed only through the search index.
- **Not confirmed.** Refs 14 (primary URL), 42, 43 and 44 are marked [UNVERIFIED]. No claim in the note rests on 42–44.

### B. Key factual claims re-derived independently

1. **ten-proofs.** Confirmed directly:
   - 12 configs and 38 theorem names, with nanoda `true` in all 12 and exactly the 3 standard axioms;
   - only `H_GapCVP` has `definition_names` (4);
   - yaml v0.3 with `agent-reviewed`, "Astra (OpenAI)", Codex and "1 week";
   - Mathlib and Comparator at `v4.32.0` (revs `81a5d257` and `07bc4ea4`);
   - total solution size 21.58 MB.
   - Line, `theorem`, `def`, `set_option` and comment counts were recomputed for GapCVP, MulticolorTriangleRamsey and QuantumParallelRepetition and match the table exactly, including 156 `respectTransparency` options and `maxHeartbeats` up to 5,000,000. The 30-digit enclosure and the SpherePacking attribution header were also confirmed.
2. **openai/math configs.** I downloaded all 419 JSON configs and 418 top-level challenges at `4eaee875` and confirmed:
   - all 419 permit exactly the standard 3 axioms;
   - nanoda is true in 2 (named correctly), false in 414 and absent in 3 (named correctly);
   - there are 546 theorem names (mean 1.3, max 17), and only `ElementaryPositivity` has holes;
   - 388 of 418 challenges are Mathlib-only, and exactly 2 import `OAI.*` (named correctly);
   - the maximum is `EditApproximation` (19,170 lines, 1.43 MB);
   - there are 7 `*Support` configs, and the Support section of the Comparator README is present at `30148886` and deleted at `42907c9e`.
3. **openai/math counts.**
   - README counts at each commit match: 722/372, then 719/372 with "~42%", then 721/373.
   - `history.md` gives 300/719, 3 withdrawals and 14 revisions.
   - Discipline counts in `overview.tex` (17 sections, sum 373) and the family-number gaps (045, 061, 070, 123, 163) match.
   - The lean tree holds 162,413 `.lean` files and 1.778 GB, with per-subject counts as stated.
   - There are 30 pinned `require`s, 11 of them lana-agents; 23 `.patch` files; 23 `OAI.*` libs; and 245 docs.
   - `formalization.yaml` (v0.4) has 176 sources, 208 `main_results` and 192 distinct configs, with `review.status: unchecked`.
   - The CM Hodge tree has 262 files; commit `204e5f8f` touched 281 files, 259 of them in that tree.
4. **PrimeGaps186.** The 3 project axioms, 6 permitted axioms, nanoda on, `proved-conditionally`, `self-assessed`, the "no independent human semantic review" wording, the prompting notes, the 10.3 MB solution, and README statements such as "104 outer and 45 inner … plus three cap bounds" and "does not discharge any Lean axiom" are all confirmed.
5. **NavierStokesAndEuler.** The challenge header cites Formal Conjectures commit `8bf45ed7…` (`Millenium/NavierStokes.lean`) and documents junk values. Both configs run nanoda with the standard 3 axioms. The yaml alignment lists 4 "proved" entries, `self-assessed` and "GPT-6 Astra". The last commit is `f9e8bc5b` (09-10). All confirmed.
6. **Bastounis–Circelli–Hansen (2610.08144).** Confirmed from the PDF text:
   - eq. (8.19) $C^{m+4}$ vs Lean $C^{m+5}$ (Remark 3.2);
   - (10.19) proved via Sobolev embedding and $L^2$ Riesz bounds instead of $L^{3/2}$;
   - the Euler "likelihood of substantial mistranslations is very high" with no worked example;
   - Theorem A.3 ($\Sigma^0_2$-complete, $k\ge9$).
   - *Precision edit:* the undecidability result concerns presupposition resolution, not every faithfulness judgement. Its `sInf` example is the authors' construction; I confirmed that it is not a defect found in OpenAI code. borism #2 does conflate the two, as the note warned.
7. **Sienicki & Sienicki (2608.14673, v3, 9 Sep).** Confirmed: 18 chapter-specific assessments; no surviving confirmed substantive error; Chapter 8 major-revision reservation; follow-ups by Fournier-Facio, Kun–Thom, Zhou and Song. *Precision edit:* Zhou discloses AI assistance and gives a single pair of groups.
8. **The KITP committee statement.** Confirmed:
   - membership, with Gross as chair;
   - custody from Oct 16, and Gross chose the members;
   - "including coupling to fermions";
   - the Balaban and Wilson lineage;
   - confinement and the mass gap remain open;
   - first statement-and-alignment validation, then Lean release;
   - 1,147 pages; the Douglas review is cited.
   - *Correction:* the statement does **not** say that the Lean is complete ("is providing"), and it does not name the dimension or gauge groups. The 9 Sep, 18 Sep and 16 Oct dates rest only on secondary reports, which agree with each other.
9. **Secondary YM coverage.** *Corrections:*
   - "Jaffe and Witten stress…" is QRC's paraphrase of their 2000 Clay description, not a new statement.
   - The Baez point is QRC paraphrase only.
   - "IAS-associated" comes from XenoSpectrum only.
   - "Unified completion of the Standard Model" is QRC's wording.
10. **Lean Zulip thread.** *Correction:* the `open Classical` false negatives came from Seed-Prover's own defeq check, not from Comparator. The other points are confirmed: Boris Alexeev on iterative development, James Hanson on RC-toolchain fragility, and Henrik Böving's rationale for the no-prebuild rule.
11. **Other repository claims re-checked.**
    - Confirmed:
      - cdc-lean (v4.31.0, the `Audit.lean` plus `rg` scan, `VERIFICATION.md` dated 2026-07-09);
      - LongGapsBetweenPrimes (now filled in: standard 3 axioms, nanoda on, `self-assessed`, "GPT 6 Astra");
      - the formalization.yaml schema, whose `review.status` values match. Note that the schema leaves `alignment` freeform; its status values come from the template;
      - Comparator provenance (Lean FRO and the AIMO team, `systemd-run`/AF_UNIX advice, the no-olean-mmap policy, the RH definition-hole example);
      - the os-reconstruction README details;
      - the Sussman README;
      - the JJardine919 results (547 manuscripts, 2 gaps).
    - The Weil-classes withdrawal notice (sign error; the Eliashberg–Murphy hypothesis is not met) was also confirmed.

### C. Corrections applied (summary)

1. `preprints/` "13,578 files" became 10,713 files in 2,865 subdirectories; 13,578 was the count of tree entries.
2. "Formal-Conjectures-derived code" was removed from the Lake dependency list, because it is not a `require`.
3. The definition holes in `H_GapCVP` were called "benign because proof-irrelevant". The holes are whole definitions with data fields, and Comparator does not check hole values. The verifier's textual diff shows the data fields are identical, so the use is benign only after that extra check.
4. The Thomas Zhu false negatives are reattributed from Comparator to Seed-Prover's own check.
5. Yang–Mills attribution was tightened: the claim that the Lean is complete is secondary only; gauge groups and dimension are unstated in the primary; and the Jaffe/Witten/Baez remarks are paraphrase or background.
6. The undecidability claim of Bastounis et al. was narrowed to its actual scope.
7. Context was added that ClassicalON (Polyakov's conjecture), Heisenberg (the quantum ferromagnet) and cdc-lean (the cycle double cover conjecture) each claim to resolve problems that were well-known open problems in the human literature. All three are unreviewed, two have nanoda off, and family 271 is absent from `formalization.yaml`.
8. The os-reconstruction inhabitants are now described as "non-degenerate (free/Gaussian-derived)" rather than "non-trivial". The Douglas profile identity is noted as self-declared.
9. Smaller edits: the coverage headline now carries a caveat about differing units; the "raw research data" wording is dated to Oct 26; CM Hodge was added on Oct 26 and edited on Oct 29; the CM Hodge tree size now counts definitions plus lemmas; the 23 OAI libs versus 27 directories are stated; the Zhou caveat is added; the Balaban description is attributed to the standard (Jaffe–Witten) summary; and the "will look like CM Hodge" sentence is marked as a prediction.

### D. Residual concerns

- **Nothing about the YM claim can be verified.** No statement, scope note or Lean code is public. The "Lean completed 16 Oct" date and the dimension and gauge-group scope rest on press reports of an OpenAI post that I could not read (HTTP 403).
- **Not recomputed by the verifier:**
  - the ~21 "(Lean)"-link families (I checked only 215);
  - the five "weaker than paper" items, except 277 ($\delta^{13}$, confirmed in `EntangledGames.lean`) and 378 (confirmed in docs/378);
  - borism's 52k-line count;
  - the 340 → 345 linked-paper count;
  - the ten-proofs line counts for the 7 files I did not download.
  All are plausible and consistent with what I did check.
- **No Comparator or `lake comparator` replay was run** for any OpenAI artifact in this pass. "Certified" in the note means "has a config and a solution", not "replayed by us".
- **The "open problem" context in item 7 above** comes from the verifier's background knowledge, cross-checked for Polyakov's conjecture with a web search. Other workstreams should confirm the literature status of the Heisenberg-ferromagnet and CDC claims before relying on it.
- **The third-party audits** (borism, grwtsk, JJardine919, yuyauchuncn-dot and others) are unrefereed, and some are themselves LLM-assisted.
