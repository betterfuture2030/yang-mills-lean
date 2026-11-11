import Mathlib

/-!
# Euclidean quantum field theory on ℝ⁴: the Osterwalder–Schrader axioms and the mass gap

This file contains **definitions only** (no open problems, no `sorry`).

We use the *multilinear* formulation of Schwinger functions: for a finite family of real
(Hermitian) fields `φ_i`, `i ∈ ι`, transforming under `O(4)` by a real representation `ρ`,
the `n`-point Schwinger function is a continuous multilinear form

  `S n (f₁, …, fₙ) = ⟨φ(f₁) ⋯ φ(fₙ)⟩`,   `φ(f) = ∑ᵢ ∫ fᵢ(x) φᵢ(x) dx`,

on one-point test functions `f ∈ 𝓢(ℝ⁴, ℂ^ι)`.

## Relation with Osterwalder–Schrader (OS I 1973, OS II 1975)

OS define `Sₙ` as a distribution on `𝓢₀(ℝ⁴ⁿ)` (Schwartz functions vanishing with all
derivatives on all diagonals `xᵢ = xⱼ`). By Hahn–Banach every such distribution extends to
`𝓢(ℝ⁴ⁿ)`, and its restriction to product test functions is a continuous multilinear form. The
extension is not unique (contact terms of composite operators are scheme dependent), so all
axioms below except the growth bound are imposed **only on tuples of test functions with
pairwise disjoint supports**, mirroring `𝓢₀`. Reflection positivity is imposed on products of
test functions supported in *ordered positive-time slabs*, mirroring OS's `𝓢₊`. Products of
such functions span a dense subspace of the corresponding OS test-function spaces.

The growth condition is OS II's linear growth condition `E0'` stated literally: on
disjointly supported product test functions, `Sₙ` is the restriction of a distribution `Tₙ` on
configuration space `(ℝ⁴)ⁿ` with `|Tₙ(F)| ≤ α (n!)^β |F|_{n s}`. The Schwartz order grows
linearly in `n`. (`Tₙ` lives on `𝓢((ℝ⁴)ⁿ)` rather than `𝓢₀`; this is equivalent by
Hahn–Banach, and sup- vs Euclidean-norm constants `n^{O(ns)}` are absorbed by `(n!)^β`.)
Hence OS II reconstruction applies: the axioms below yield a Wightman theory.

The mass gap is formulated directly on the OS (reflection-positivity) pre-Hilbert space:
with `B(F,G)` the reflection-positive form and `B_T` its truncation by the vacuum,
`|B_T(F, T_t G)| ≤ e^{-m t} B_T(F,F)^{1/2} B_T(G,G)^{1/2}` for all `t ≥ 0`. After OS
reconstruction `T_t ↦ e^{-tH}`, so this is exactly `‖e^{-tH}(1 - P_Ω)‖ ≤ e^{-mt}`, i.e. the
spectrum of the Hamiltonian on the orthogonal complement of the vacuum lies in `[m, ∞)` and
the vacuum is unique. With Lorentz invariance this is the Jaffe–Witten mass gap.
-/

noncomputable section

open scoped SchwartzMap
open Filter Topology

namespace YangMills

/-! ## Spacetime -/

/-- Euclidean spacetime `ℝ⁴`. Coordinate `0` is Euclidean time. -/
abbrev E4 : Type := EuclideanSpace ℝ (Fin 4)

/-- The orthogonal group `O(4)`. -/
abbrev O4 : Type := E4 ≃ₗᵢ[ℝ] E4

/-- Unit vector in the time direction. -/
def e0 : E4 := EuclideanSpace.single 0 1

/-- Time reflection `θ(x⁰, x⃗) = (-x⁰, x⃗)`: reflection in the hyperplane orthogonal to `e0`. -/
def timeReflection : O4 := (ℝ ∙ e0)ᗮ.reflection

/-! ## Test functions and field components -/

variable (ι : Type) [Fintype ι] [DecidableEq ι]

/-- One-point test functions: Schwartz functions `ℝ⁴ → ℂ^ι`
(one component for each field `φ_i`). -/
abbrev TestFn : Type := 𝓢(E4, ι → ℂ)

/-- A family of Schwinger functions for the fields `φ_i`, `i ∈ ι`:
`S n (f₁,…,fₙ) = ⟨φ(f₁)⋯φ(fₙ)⟩`. -/
structure Schwinger where
  /-- The `n`-point Schwinger function as a continuous multilinear form. -/
  S : (n : ℕ) → ContinuousMultilinearMap ℂ (fun _ : Fin n => TestFn ι) ℂ

variable {ι}

/-- A real matrix acting on field components, as a continuous `ℂ`-linear map. -/
def matCLM (M : Matrix ι ι ℝ) : (ι → ℂ) →L[ℂ] (ι → ℂ) :=
  LinearMap.toContinuousLinearMap (Matrix.toLin' (M.map (algebraMap ℝ ℂ)))

/-- Componentwise complex conjugation on `ℂ^ι` (an `ℝ`-linear map). -/
def conjCLM : (ι → ℂ) →L[ℝ] (ι → ℂ) :=
  ContinuousLinearMap.pi fun i =>
    Complex.conjCLE.toContinuousLinearMap.comp (ContinuousLinearMap.proj i)

/-- The Euclidean motion `x ↦ R x + a` acting on one-point test functions of fields that
transform under the real representation `ρ` of `O(4)`:
`(g·f)(x) = ρ(R⁻¹)ᵀ f(R⁻¹(x - a))` (the contragredient action, so that
`⟨φ(g·f)…⟩ = ⟨φ(f)…⟩` expresses covariance `φ(Rx + a) = ρ(R) φ(x)`). -/
def euclid (ρ : O4 →* Matrix ι ι ℝ) (R : O4) (a : E4) : TestFn ι →L[ℂ] TestFn ι :=
  (SchwartzMap.postcompCLM (matCLM (ρ R⁻¹).transpose)).comp
    ((SchwartzMap.compSubConstCLM ℂ a).comp
      (SchwartzMap.compCLMOfContinuousLinearEquiv ℂ R.symm.toContinuousLinearEquiv))

/-- Translation of a test function by `a`: `f ↦ f(· - a)`. -/
def translate (a : E4) : TestFn ι →L[ℂ] TestFn ι := SchwartzMap.compSubConstCLM ℂ a

/-- Complex conjugation of a test function (antilinear, hence an `ℝ`-linear map). -/
def conjTest : TestFn ι →L[ℝ] TestFn ι := SchwartzMap.postcompCLM conjCLM

/-- The OS reflection `Θ f = conj (θ · f)` (time reflection composed with conjugation). -/
def osReflect (ρ : O4 →* Matrix ι ι ℝ) (f : TestFn ι) : TestFn ι :=
  conjTest (euclid ρ timeReflection 0 f)

/-! ## Support conditions -/

/-- Pairwise disjoint (closed) supports: the multilinear analogue of `𝓢₀`. -/
def DisjointSupports {n : ℕ} (f : Fin n → TestFn ι) : Prop :=
  Pairwise fun i j => Disjoint (tsupport (f i : E4 → ι → ℂ)) (tsupport (f j : E4 → ι → ℂ))

/-- A monomial `φ(f₁)⋯φ(fₙ)` in the smeared fields. -/
structure Monomial (ι : Type) [Fintype ι] where
  /-- Degree. -/
  n : ℕ
  /-- Test functions. -/
  f : Fin n → TestFn ι

/-- The test functions of a monomial are supported in ordered positive-time slabs
`0 = t₀ < t₁ < ⋯ < tₙ`, `supp fₖ ⊆ {t_{k} < x⁰ < t_{k+1}}`: the multilinear analogue of OS's
`𝓢₊ = {supp ⊆ {0 < x₁⁰ < ⋯ < xₙ⁰}}`. -/
def Monomial.OrderedPositive (A : Monomial ι) : Prop :=
  ∃ t : Fin (A.n + 1) → ℝ, t 0 = 0 ∧ StrictMono t ∧
    ∀ k : Fin A.n, ∀ x ∈ tsupport (A.f k : E4 → ι → ℂ),
      t k.castSucc < x 0 ∧ x 0 < t k.succ

/-- Apply a map to every test function of a monomial. -/
def Monomial.map (A : Monomial ι) (T : TestFn ι → TestFn ι) : Monomial ι :=
  ⟨A.n, fun k => T (A.f k)⟩

/-- `Θ(A)^* · B`: reflect-and-conjugate the factors of `A` in reverse order, then append `B`.
These are the arguments of `S_{n+m}(Θ f_n^* ⊗ g_m)` in OS reflection positivity. -/
def reflectAppend (ρ : O4 →* Matrix ι ι ℝ) (A B : Monomial ι) : Fin (A.n + B.n) → TestFn ι :=
  Fin.append (fun k => osReflect ρ (A.f (Fin.rev k))) B.f

/-- A finite linear combination of monomials (an element of the Borchers algebra).
Coefficient `c j` multiplies monomial `m j`. -/
structure Poly (ι : Type) [Fintype ι] where
  /-- Number of terms. -/
  N : ℕ
  /-- Coefficients. -/
  c : Fin N → ℂ
  /-- Monomials. -/
  m : Fin N → Monomial ι

/-- All monomials are supported in ordered positive-time slabs. -/
def Poly.OrderedPositive (F : Poly ι) : Prop := ∀ j, (F.m j).OrderedPositive

/-- Apply a map to every test function of every monomial. -/
def Poly.map (F : Poly ι) (T : TestFn ι → TestFn ι) : Poly ι :=
  ⟨F.N, F.c, fun j => (F.m j).map T⟩

/-- The constant polynomial `1` (the vacuum). -/
def Poly.one : Poly ι := ⟨1, fun _ => 1, fun _ => ⟨0, Fin.elim0⟩⟩

variable (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)

/-- The reflection-positivity form `B(F, G) = ∑ⱼ ∑ₗ conj(cⱼ) dₗ S(Θ mⱼ^* · mₗ)`. -/
def rpForm (F G : Poly ι) : ℂ :=
  ∑ j : Fin F.N, ∑ l : Fin G.N,
    (starRingEnd ℂ) (F.c j) * G.c l * S.S _ (reflectAppend ρ (F.m j) (G.m l))

/-- The truncated (connected) form `B_T(F,G) = B(F,G) - B(F,1) B(1,G)`: the inner product
of the components orthogonal to the vacuum. -/
def rpFormT (F G : Poly ι) : ℂ :=
  rpForm ρ S F G - rpForm ρ S F Poly.one * rpForm ρ S Poly.one G

/-! ## The axioms -/

/-- A Schwartz norm of order `p`: `‖f‖_p = ∑_{k,m ≤ p} sup_x ‖x‖^k ‖Dᵐ f(x)‖`. -/
def schwartzNorm (p : ℕ) (f : TestFn ι) : ℝ :=
  ∑ k ∈ Finset.range (p + 1), ∑ m ∈ Finset.range (p + 1), SchwartzMap.seminorm ℂ k m f

/-- **OS0** normalization: `S₀ = 1`. -/
def OS.Normalized : Prop := S.S 0 Fin.elim0 = 1

/-- A Schwartz norm of order `p` on configuration space `(ℝ⁴)ⁿ`. -/
def schwartzNormN {n : ℕ} (p : ℕ) (F : 𝓢(Fin n → E4, (Fin n → ι) → ℂ)) : ℝ :=
  ∑ k ∈ Finset.range (p + 1), ∑ m ∈ Finset.range (p + 1), SchwartzMap.seminorm ℂ k m F

/-- **E0'** (OS II linear growth): there are `s, α, β` such that for each `n`, `Sₙ` is, on
disjointly supported product test functions, the restriction of a distribution `Tₙ` on
`(ℝ⁴)ⁿ` with `|Tₙ(F)| ≤ α (n!)^β |F|_{n s}`. -/
def OS.Growth : Prop :=
  ∃ (s : ℕ) (α β : ℝ), ∀ n : ℕ, ∃ T : 𝓢(Fin n → E4, (Fin n → ι) → ℂ) →L[ℂ] ℂ,
    (∀ F, ‖T F‖ ≤ α * (n.factorial : ℝ) ^ β * schwartzNormN (n * s) F) ∧
    ∀ (f : Fin n → TestFn ι) (F : 𝓢(Fin n → E4, (Fin n → ι) → ℂ)),
      DisjointSupports f → (∀ x i, F x i = ∏ k, f k (x k) (i k)) → T F = S.S n f

/-- **Reality** (Hermitian fields): `Sₙ(f̄₁,…,f̄ₙ) = conj Sₙ(f₁,…,fₙ)` (disjoint supports). -/
def OS.Real : Prop :=
  ∀ (n : ℕ) (f : Fin n → TestFn ι), DisjointSupports f →
    S.S n (fun k => conjTest (f k)) = (starRingEnd ℂ) (S.S n f)

/-- **E1** Euclidean covariance under `x ↦ R x + a`, `R ∈ O(4)` (disjoint supports). -/
def OS.Covariant : Prop :=
  ∀ (R : O4) (a : E4) (n : ℕ) (f : Fin n → TestFn ι), DisjointSupports f →
    S.S n (fun k => euclid ρ R a (f k)) = S.S n f

/-- **E3** Symmetry (bosonic fields) under permutations (disjoint supports). -/
def OS.Symmetric : Prop :=
  ∀ (n : ℕ) (f : Fin n → TestFn ι) (σ : Equiv.Perm (Fin n)), DisjointSupports f →
    S.S n (f ∘ σ) = S.S n f

/-- **E2** Reflection positivity: `B(F, F) ≥ 0` for `F` supported at ordered positive times. -/
def OS.ReflectionPositive : Prop :=
  ∀ F : Poly ι, F.OrderedPositive →
    (rpForm ρ S F F).im = 0 ∧ 0 ≤ (rpForm ρ S F F).re

/-- **E4** Cluster property (OS form): for monomials `A, B` at ordered positive times and a
**non-zero** spatial vector `a`, `S(Θ A^* · T_{λ a} B) → S(Θ A^*) S(B)` as `λ → ∞`.
(`a ≠ 0` is essential: at `a = 0` the condition would force exact factorization and collapse
the OS Hilbert space to `ℂΩ`.) -/
def OS.Cluster : Prop :=
  ∀ (A B : Monomial ι), A.OrderedPositive → B.OrderedPositive →
    ∀ a : E4, a ≠ 0 → a 0 = 0 →
      Tendsto (fun lam : ℝ => S.S _ (reflectAppend ρ A (B.map (translate (lam • a)))))
        atTop (𝓝 (S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f))

/-- The Osterwalder–Schrader axioms for the Schwinger functions `S` of fields transforming
under `ρ`. -/
structure OSAxioms : Prop where
  normalized : OS.Normalized S
  growth : OS.Growth S
  real : OS.Real S
  covariant : OS.Covariant ρ S
  symmetric : OS.Symmetric S
  reflectionPositive : OS.ReflectionPositive ρ S
  cluster : OS.Cluster ρ S

/-- **Mass gap** `m > 0`: on the OS pre-Hilbert space,
`|B_T(F, T_t G)| ≤ e^{-m t} B_T(F,F)^{1/2} B_T(G,G)^{1/2}` for all `t ≥ 0`, where `T_t` is
Euclidean time translation by `t`. Equivalently (after OS reconstruction) the Hamiltonian has
spectrum in `{0} ∪ [m, ∞)` with a unique vacuum. -/
def HasMassGap (m : ℝ) : Prop :=
  0 < m ∧ ∀ (F G : Poly ι), F.OrderedPositive → G.OrderedPositive → ∀ t : ℝ, 0 ≤ t →
    ‖rpFormT ρ S F (G.map (translate (t • e0)))‖ ≤
      Real.exp (-m * t) * Real.sqrt (rpFormT ρ S F F).re * Real.sqrt (rpFormT ρ S G G).re

/-! ## Non-triviality -/

/-- The fourth cumulant (truncated four-point function) of centred fields. -/
def cumulant4 (f : Fin 4 → TestFn ι) : ℂ :=
  S.S 4 f
    - S.S 2 ![f 0, f 1] * S.S 2 ![f 2, f 3]
    - S.S 2 ![f 0, f 2] * S.S 2 ![f 1, f 3]
    - S.S 2 ![f 0, f 3] * S.S 2 ![f 1, f 2]

/-- Non-triviality: the fields are centred, have a non-vanishing two-point function at
separated points, are non-Gaussian (non-vanishing fourth cumulant at separated points), and the
OS Hilbert space is larger than `ℂΩ` (some state orthogonal to the vacuum has positive norm). -/
def NonTrivial : Prop :=
  (∀ f : Fin 1 → TestFn ι, S.S 1 f = 0) ∧
  (∃ f : Fin 2 → TestFn ι, DisjointSupports f ∧ S.S 2 f ≠ 0) ∧
  (∃ f : Fin 4 → TestFn ι, DisjointSupports f ∧ cumulant4 S f ≠ 0) ∧
  (∃ F : Poly ι, F.OrderedPositive ∧ 0 < (rpFormT ρ S F F).re)

end YangMills
