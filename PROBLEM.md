# The problem: Yang–Mills existence and mass gap

*Version 0.2, 2026-11-05; revised 2026-11-10/11 (status notes, Rémondière credit, review-history and gap-wording corrections; statement files unchanged). Companion to `lean/YangMills/` (formal statement) and
`library/notes/01-problem-definition.md`, which has the long-form source analysis and
26 choice points with citations.*

## 1. The official problem

Jaffe and Witten wrote the official problem description for the Clay Mathematics Institute
(2000). It reads, in substance:

> For any compact simple gauge group G, prove that a non-trivial quantum Yang–Mills theory
> exists on ℝ⁴ and has a mass gap Δ > 0. Existence includes establishing axiomatic
> properties at least as strong as those of Streater–Wightman and Osterwalder–Schrader.

The surrounding text (§4 and its footnotes) adds requirements that standard axiom systems
do not contain:

1. **Field content.** The local quantum fields correspond to gauge-invariant local polynomials
   in the curvature F and its covariant derivatives, e.g. `tr F_{ij} F_{kl}(x)`. There is no
   canonical 1-1 correspondence. One expects classical polynomials of dimension ≤ d to
   correspond to quantum operators of dimension ≤ d.
2. **Short distances.** Correlation functions agree at short distances with asymptotic freedom
   and textbook renormalized perturbation theory, including a stress tensor and an operator
   product expansion.
3. **Mass gap.** The Hamiltonian satisfies `HΩ = 0` and has no spectrum in `(0, Δ)`; the mass
   `m = sup Δ` must be finite.
4. **No weak existence.** A footnote says existence by compactness alone (subsequential limits)
   is not a solution unless the properties of the limit, axioms and gap, are also proved.
5. **A Hilbert space.** "Establishing a quantum mechanical Hilbert space is part of the
   solution" (§6.5).

## 2. Status (5 November 2026)

| Item | Status |
|---|---|
| 4D existence (gauge groups not stated publicly) | **Claimed by OpenAI** (26 Oct 2026) for pure Yang–Mills theory. Natural-language proof dated 9 Sep, Lean formalization 16 Oct; the committee mentions "the full 1147-page LLM proofs" without saying which results they cover. Held by the shepherding committee; nothing public as of 6 Nov. On 10 Nov the committee published OpenAI's Lean code (`yang-mills-group/OpenAI-YM-20261028`) and an assessment (`yang-mills-group/YM`) that the committee describes as a validation that the code proves pure YM existence; not examined here. |
| Scope of OpenAI's claim | Pure YM existence as a subproblem of "certain interacting QFTs" including QCD. Built on Wilson's lattice and Balaban's RG, "to infinite distances". Gauge groups, axioms and observables not public as of 6 Nov. |
| 4D mass gap | **Open by every account**, including OpenAI and the committee. |
| 3D YM continuum | No refereed construction. AI-generated claims exist (Sussman–Alpöge YM₃, Aronow–Lopatto SU(2) on T³), unverified. |
| 2D YM | Complete. |
| Lattice mass gap | Proved only at strong coupling (Osterwalder–Seiler; the 't Hooft regime of Chatterjee and others) or for finite groups. Never in the weak-coupling continuum regime. |

Sources: notes 02, 05 and 11.

## 3. The mathematical statement we adopt

Its main design elements also appear in the earlier candidate statement of K. Rémondière
([ClayYM, Zenodo 10.5281/zenodo.23650415](https://doi.org/10.5281/zenodo.23650415), 25 October
2026), which predates this work: the Wilson-lattice identification (C5), the 21 components of
`tr F_{μν}F_{κλ}` as field content, with the C-even limitation of the gap (C4), and a short-distance
asymptotic-freedom fingerprint (C8). Library note 01 reviews it.

### 3.1 Objects

* **Spacetime:** `ℝ⁴`, Euclidean. Coordinate 0 is time, θ is time reflection.
* **Fields:** the 256 index components of `T_{μνκλ}(x) = tr F_{μν}F_{κλ}(x)`. They span
  the 21-dimensional space `Sym²(Λ²ℝ⁴)`, which decomposes under SO(4) as
  `(0,0)⊕(0,0)⊕(1,1)⊕(2,0)⊕(0,2)`:
  * `tr F²`;
  * `tr F F̃`;
  * the traceless stress tensor;
  * the self-dual and anti-self-dual Weyl-like parts.

  O(4) acts by `R ⊗ R ⊗ R ⊗ R`.
* **Schwinger functions:** continuous multilinear forms
  `Sₙ(f₁,…,fₙ) = ⟨φ(f₁)⋯φ(fₙ)⟩` on test functions `f ∈ 𝓢(ℝ⁴, ℂ^{256})`.

### 3.2 Axioms (Osterwalder–Schrader, with OS II's linear growth)

Following OS, all axioms except growth are imposed on tuples of test functions with
**pairwise disjoint supports** (the analogue of `𝓢₀`). Contact terms of composite operators
are scheme dependent and are left free.

| Axiom | Formal content | Lean |
|---|---|---|
| Normalization | `S₀ = 1` | `OS.Normalized` |
| E0′ growth | `Sₙ` is, on disjoint products, the restriction of a distribution `Tₙ` on `(ℝ⁴)ⁿ` with `|Tₙ(F)| ≤ α (n!)^β |F|_{n s}` | `OS.Growth` |
| Reality | `Sₙ(f̄) = conj Sₙ(f)` | `OS.Real` |
| E1 covariance | invariant under `f ↦ ρ(R⁻¹)ᵀ f(R⁻¹(· − a))` for all `R ∈ O(4)` | `OS.Covariant` |
| E3 symmetry | permutation invariance | `OS.Symmetric` |
| E2 reflection positivity | `B(F,F) ≥ 0` for F supported in ordered positive-time slabs, `B(F,G) = Σ conj(c)d S(ΘF* · G)` | `OS.ReflectionPositive` |
| E4 cluster | `S(ΘA* · T_{λa}B) → S(ΘA*) S(B)` for **non-zero** spatial `a`, as `λ → ∞` | `OS.Cluster` |

By OS II, these axioms give a Wightman theory: a Hilbert space, a unitary Poincaré
representation, positive energy and locality.

### 3.3 Non-triviality and identification as Yang–Mills

| Clause | Content | Why |
|---|---|---|
| `NonTrivial` | Centred fields; `S₂ ≠ 0` and fourth cumulant `≠ 0` at separated points; some state orthogonal to Ω has positive norm | excludes the trivial, Gaussian and ultralocal theories |
| `FullFieldContent` | Every non-zero direction `v` in the 21-dimensional space gives a non-zero state `φ_v(h)Ω` | the existential renormalization matrices `Z_k` cannot project away channels |
| `ShortDistanceAF` | `λ⁸ log²(1/λ) S₂(D_λh₁, D_λh₂) → C ∫∫ h₁(x)h₂(y)|x−y|⁻⁸`, with `C > 0`, in the scalar channel | Jaffe–Witten's short-distance requirement. The `log²` comes from the running coupling, so it excludes free gluons |
| `IsWilsonLimit` | `S` is the limit (`a → 0`, `aL → ∞`, `β → ∞`, renormalization `Z_k` valued in the 21-dimensional space, vacuum subtraction) of Wilson lattice Schwinger functions, on compactly supported test functions with disjoint supports | pins the theory down as *the* Yang–Mills theory with gauge group G, rather than any theory with similar axiomatic properties |

### 3.4 Mass gap

`HasMassGap Δ`: `Δ > 0` and, for all F, G at ordered positive times and all `t ≥ 0`,

`|B_T(F, T_t G)| ≤ e^{−Δ t} B_T(F,F)^{1/2} B_T(G,G)^{1/2}`, with `B_T(F,G) = B(F,G) − B(F,1)B(1,G)`.

After OS reconstruction `T_t ↦ e^{−tH}`, so this is exactly `‖e^{−tH}(1−P_Ω)‖ ≤ e^{−Δt}`:
the spectrum of H on Ω⊥ lies in `[Δ, ∞)` and the vacuum is unique. With Lorentz covariance,
this is the Jaffe–Witten gap. `m < ∞` follows from `NonTrivial`, since there is a state
orthogonal to Ω.

### 3.5 The theorems

| Name | Statement |
|---|---|
| `ClayYangMills` | ∀ compact connected G with a faithful unitary representation whose matrix Lie algebra is simple: ∃ faithful representation P, ∃ S, `IsYangMillsTheory P S ∧ ∃ Δ, HasMassGap S Δ` |
| `ClayExistence` | the same without the gap |
| `SUNExists N` | `SU(N)`, fundamental Wilson action: ∃ S a β, `IsYangMillsTheoryAlong` ∧ two-loop `AsymptoticScaling` of `β(a)` (a candidate SU(N) existence target; OpenAI's gauge groups and exact statement were not public as of 6 Nov 2026) |
| `SUNExistsWithMassGap N` | `SU(N)`, fundamental Wilson action, with mass gap |

## 4. Formalization choices and their justification

| # | Choice | Alternatives | Justification and risk |
|---|---|---|---|
| C1 | Euclidean OS form | Wightman form | OS is closest to every constructive route. OS II gives Wightman. A Lean bridge exists externally (`xiyin137/OSreconstruction`, scalar fields). |
| C2 | Multilinear Schwinger functions | distributions on `(ℝ⁴)ⁿ` | Avoids tensor products of Schwartz functions. E0′ is stated on configuration space, so nothing is lost. |
| C3 | Axioms on disjoint supports | on all of `𝓢` | Faithful to OS's `𝓢₀`. Contact terms are scheme dependent. |
| C4 | Fields `tr F_{μν}F_{κλ}` (dimension 4) | add higher-dimension operators, flowed Wilson loops | Minimal faithful content per JW footnote 1. **Limitation:** the gap is required only on the cyclic space of these fields, a subspace of the C-even sector. A C-odd multiplet (`d_{abc} F F F`) is the next extension. |
| C5 | Lattice identification | perturbative matching; method-free characterization | Without it, Wick powers of a massive free field would satisfy the statement. **Limitation:** method dependent. A construction by another regulator also needs a universality theorem. |
| C6 | Subsequential limits | full convergence, uniqueness | Standard in constructive QFT. Uniqueness is not in JW's text. JW's no-weak-existence footnote is met because the *properties* (OS, gap) are required of the limit. |
| C7 | Existential representation in `ClayYangMills` | all faithful representations | JW ask that YM(G) exist, not that every Wilson action converge to it. The fundamental version stays as the separate, stronger `SUNExistsWithMassGap`. |
| C8 | AF fingerprint in the scalar channel only | full OPE, stress tensor normalization | A precise, checkable consequence of asymptotic freedom. A full OPE is beyond any existing formal statement. |
| C9 | Gauge group = compact matrix group with simple Lie algebra | Mathlib `LieGroup` | Elementary and transparent. Non-vacuity for SU(N) is a tracked obligation. |

### 4.1 Direction of each deviation from Clay (honest labelling)

The statement is a **candidate (v0.2)**: adversarially reviewed by AI agents, *not yet
audited by human experts*. It is not equivalent to the Clay text, which is informal in
places. Each deviation, with its direction:

| Aspect | Our statement vs Clay | Consequence |
|---|---|---|
| Mass gap on the cyclic space of `tr F F` only (a subspace of the C-even sector) | **weaker** | A full-Clay proof must add C-odd and higher-dimension fields |
| Wilson-lattice origin required | **stronger / different** (Douglas 2004: the lattice is "not essential") | Other regulators need a universality theorem |
| `ShortDistanceAF` is a scalar two-point fingerprint, not full agreement with renormalized perturbation theory and an OPE | **weaker** | Adding an OPE clause is future work (Hollands–Kopper) |
| Subsequential limits accepted | **choice point** | We read JW footnote 2 as excluding compactness *only if* the limit's axioms and gap are not proved. Our statement requires them, so a subsequential limit with proved properties counts. A stricter reading (full convergence, uniqueness) would be a separate, stronger target. |
| E0′ (OS II), not Glimm–Jaffe OS1 | equivalent to OS's own standard; GJ OS1 *fails* for `tr F²` in 4D (note 01 §2.6) | none |

## 5. Review history

**v0.1 → v0.2.** Twenty reviewer and verifier agents (separately prompted, context-isolated instances of the same model) reviewed the statement, the reviewers each through a distinct lens. 13 findings survived adversarial verification; 1 was refuted. All were addressed; two major findings were only partly fixed:

* **Critical (found separately by 3 reviewer agents): the cluster axiom admitted `a = 0`.** That forces exact factorization and collapses the OS Hilbert space to ℂΩ. The open theorems would then have been *false*, and the gap clause idle. Fixed by requiring `a ≠ 0`. The reviewers' Lean exploit files (in `lean/YangMills/scratch/`, outside the build) no longer compile.
* **Major: growth was weaker than OS II's E0′** (Schwartz order per factor `n·s`), so OS reconstruction did not apply. Replaced by the literal E0′ on configuration space.
* **Major: unconstrained `Z_k`** let a witness keep a single channel. Fixed with `FullFieldContent` and a range condition on `Z_k`.
* **Major: no short-distance asymptotic-freedom requirement** (JW §4). Added `ShortDistanceAF`, a scalar two-point fingerprint. The stress-tensor and OPE parts remain and are recorded as a deviation (§4.1).
* **Major: dependence on method and representation.** The representation is now existential. The Wilson-lattice requirement remains and is recorded as a deviation (§4.1, C5).
* **Minor: wording.** The documentation called `Z_k` a finite renormalization; it is divergent.

The non-vacuity evidence was also strengthened. The trivial theory satisfies the OS axioms
and fails `NonTrivial`. A regression lemma shows non-zero spatial vectors exist. Consistency of
OS with `NonTrivial` and `FullFieldContent` (via free Maxwell composites) is a labelled
obligation.

## 6. Open obligations in the statement layer

| Obligation | Kind | Difficulty |
|---|---|---|
| `su_connected`, `su_lieAlgebra_simple` | classical | **done** (proved in Lean, standard axioms only) |
| `os_nonTrivial_fullField_consistent` (free Maxwell composites) | classical | large: Gaussian measures on `𝓢′` and Wick products; reuse OSforGFF |
| Equivalence of E2 on slab products with OS's `𝓢₊` form; bridge to OSreconstruction | classical | large |
| `HasMassGap` ⇔ operator gap after reconstruction | classical | moderate to large |
| Comparison with OpenAI's statement (released 10 Nov 2026) | audit | days |
| Human expert sign-off (constructive QFT) | process | needs people |
