import YangMills.SU

/-!
# The Yang–Mills existence and mass gap problem: formal statements

Definitions only (no `sorry`). The open problems themselves are stated as theorems with
`sorry` in `YangMills/OpenProblems.lean`.

## Main definitions

* `YangMills.IsYangMillsTheoryAlong P S a β`: `S` is a quantum Yang–Mills theory on `ℝ⁴` with
  gauge group `P`. It satisfies the Osterwalder–Schrader axioms (with OS II linear growth, so
  OS reconstruction yields a Wightman theory). It is non-trivial. All 21 independent components
  of `tr F_{μν}F_{κλ}` are present (`FullFieldContent`). It has the short-distance behaviour
  predicted by asymptotic freedom (`ShortDistanceAF`). It is the continuum limit of Wilson's
  lattice gauge theory with gauge group `P` along spacings `a` and inverse couplings `β`.
* `YangMills.ClayYangMills`: for every compact connected matrix group `G` with simple Lie
  algebra, some such theory exists and has a mass gap `Δ > 0`. (Jaffe–Witten, Clay
  Mathematics Institute.)
* `YangMills.ClayExistence`: the same, without the mass gap.
* `YangMills.SUNExists N`: existence for `SU(N)` (fundamental Wilson action), with the
  continuum limit along the two-loop asymptotic-freedom trajectory of the bare coupling. This
  is the shape of the result OpenAI announced (existence of pure Yang–Mills theory).
* `YangMills.SUNExistsWithMassGap N`: existence and mass gap for `SU(N)` with the fundamental
  Wilson action.

## Why each clause is there

* **Lattice clause.** Without it the statement would be satisfied by non-Yang–Mills theories,
  e.g. Wick powers of a massive free field (OS, non-Gaussian, gapped).
* **`FullFieldContent`.** The renormalization matrices `Z_k` are existential. Without this
  clause a witness could project the fields onto a single channel (e.g. `tr F²` alone) and
  the mass gap would be tested only on that channel's cyclic subspace.
* **`ShortDistanceAF`** (Jaffe–Witten §4: short-distance agreement with asymptotic freedom).
  The connected two-point function of the RG-invariant scalar
  `Θ = (β(g)/2g) F^a_{μν} F^a_{μν}` behaves like `C / (|x|⁸ log²(1/|x|))`. This excludes the free
  massless (`g = 0`) limit even without a mass gap.
* **`AsymptoticScaling`** (only in `SUNExists`). The bare lattice coupling follows the
  two-loop renormalization-group trajectory.
-/

noncomputable section

open Filter Topology MeasureTheory
open scoped SchwartzMap

namespace YangMills

/-! ## Channels and the asymptotic-freedom fingerprint -/

/-- A test function in a fixed field direction `v ∈ ℝ^{ι4}`: `x ↦ h(x) v`. -/
def vecTest (v : ι4 → ℝ) (h : 𝓢(E4, ℂ)) : TestFn ι4 :=
  SchwartzMap.postcompCLM ((ContinuousLinearMap.id ℂ ℂ).smulRight fun i => (v i : ℂ)) h

/-- Every non-zero direction `v` in the 21-dimensional space of `tr F_{μν} F_{κλ}` tensors is a
non-zero field: some state `φ_v(h) Ω` with `h` supported at positive times has non-zero
(hence, by reflection positivity, positive) norm. -/
def FullFieldContent (S : Schwinger ι4) : Prop :=
  ∀ v ∈ TFFSpace, v ≠ 0 → ∃ h : 𝓢(E4, ℂ),
    (⟨1, ![vecTest v h]⟩ : Monomial ι4).OrderedPositive ∧
    S.S 2 ![osReflect tensorRep (vecTest v h), vecTest v h] ≠ 0

/-- The scalar channel `δ_{μκ}δ_{νλ} - δ_{μλ}δ_{νκ}`; contracting `T` with it gives
`2 tr F_{μν}F_{μν}`. It lies in `TFFSpace`. -/
def scalarDir : ι4 → ℝ := fun i =>
  (if i.1.1.1 = i.1.2 ∧ i.1.1.2 = i.2 then 1 else 0) -
  (if i.1.1.1 = i.2 ∧ i.1.1.2 = i.1.2 then 1 else 0)

/-- The dilation `x ↦ λ x` (for `λ ≠ 0`). -/
def scaleEquiv (lam : ℝ) (h : lam ≠ 0) : E4 ≃L[ℝ] E4 :=
  ContinuousLinearEquiv.smulLeft (Units.mk0 lam h)

/-- Dimension-4 dilation of a test function, `(D_λ h)(x) = λ⁻⁴ h(x/λ)` (junk value `h` at
`λ = 0`, which is never used: limits are taken as `λ → 0⁺`). -/
def dilate (lam : ℝ) (h : 𝓢(E4, ℂ)) : 𝓢(E4, ℂ) :=
  if hl : lam = 0 then h else
    ((lam ^ 4)⁻¹ : ℂ) • SchwartzMap.compCLMOfContinuousLinearEquiv ℂ (scaleEquiv lam hl).symm h

/-- **Short-distance asymptotic freedom** (two-point fingerprint, Jaffe–Witten §4). The scalar
channel has kernel `C / (|x - y|⁸ log²(1/|x - y|))` at short distances, `C > 0`: for compactly
supported `h₁, h₂` with disjoint supports,
`λ⁸ log²(1/λ) S₂(D_λ h₁, D_λ h₂) → C ∫∫ h₁(x) h₂(y) |x - y|⁻⁸ dx dy` as `λ → 0⁺`. The
`log²` (absent in free field theory) is the signature of the running coupling
`g²(μ) ~ 1/(2 b₀ log(μ/Λ))`. -/
def ShortDistanceAF (S : Schwinger ι4) : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∀ h₁ h₂ : 𝓢(E4, ℂ), HasCompactSupport (h₁ : E4 → ℂ) →
    HasCompactSupport (h₂ : E4 → ℂ) →
    Disjoint (tsupport (h₁ : E4 → ℂ)) (tsupport (h₂ : E4 → ℂ)) →
    Tendsto (fun lam : ℝ => ((lam ^ 8 * Real.log (1 / lam) ^ 2 : ℝ) : ℂ) *
        S.S 2 ![vecTest scalarDir (dilate lam h₁), vecTest scalarDir (dilate lam h₂)])
      (𝓝[>] 0)
      (𝓝 ((C : ℂ) * ∫ x, ∫ y, h₁ x * h₂ y * ((‖x - y‖ ^ (-8 : ℤ) : ℝ) : ℂ)))

/-! ## Yang–Mills theories -/

variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [MeasurableSpace G] [BorelSpace G]

/-- `S` is a quantum Yang–Mills theory on `ℝ⁴` with gauge group `P`, obtained as the
continuum limit of Wilson lattice gauge theory along spacings `a` and inverse couplings `β`. -/
def IsYangMillsTheoryAlong (P : GaugeGroup d G) (S : Schwinger ι4) (a β : ℕ → ℝ) : Prop :=
  OSAxioms tensorRep S ∧ NonTrivial tensorRep S ∧ FullFieldContent S ∧ ShortDistanceAF S ∧
    IsWilsonLimit P S a β

/-- `S` is a quantum Yang–Mills theory on `ℝ⁴` with gauge group `P`. -/
def IsYangMillsTheory (P : GaugeGroup d G) (S : Schwinger ι4) : Prop :=
  ∃ a β : ℕ → ℝ, IsYangMillsTheoryAlong P S a β

/-- **Yang–Mills existence and mass gap** for the lattice regularization defined by `P`. -/
def ExistsWithMassGap (P : GaugeGroup d G) : Prop :=
  ∃ S : Schwinger ι4, IsYangMillsTheory P S ∧ ∃ Δ : ℝ, HasMassGap tensorRep S Δ

/-- Yang–Mills existence and mass gap for the gauge group `G` (some faithful unitary
representation of `G` is used to define the lattice regularization). -/
def ExistsWithMassGapFor (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [MeasurableSpace G] [BorelSpace G] : Prop :=
  ∃ (d : ℕ) (P : GaugeGroup d G), ExistsWithMassGap P

/-- Yang–Mills existence (no mass-gap clause) for the gauge group `G`. -/
def ExistsFor (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
    [CompactSpace G] [MeasurableSpace G] [BorelSpace G] : Prop :=
  ∃ (d : ℕ) (P : GaugeGroup d G) (S : Schwinger ι4), IsYangMillsTheory P S

/-- **The Clay Millennium Problem** (Jaffe–Witten): for every compact simple gauge group `G`,
a non-trivial quantum Yang–Mills theory exists on `ℝ⁴` and has a mass gap `Δ > 0`. The
representation `P₀` only witnesses that `G` is a compact matrix group with simple Lie
algebra; the lattice regularization may use any faithful unitary representation. -/
def ClayYangMills : Prop :=
  ∀ (d₀ : ℕ) (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [ConnectedSpace G] [MeasurableSpace G] [BorelSpace G] (P₀ : GaugeGroup d₀ G),
    IsSimpleMatrixLieAlgebra P₀.lieAlgebra → ExistsWithMassGapFor G

/-- **Existence half of the Clay problem** (no mass gap): for every compact simple gauge
group `G`, a non-trivial quantum Yang–Mills theory exists on `ℝ⁴`. -/
def ClayExistence : Prop :=
  ∀ (d₀ : ℕ) (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [ConnectedSpace G] [MeasurableSpace G] [BorelSpace G] (P₀ : GaugeGroup d₀ G),
    IsSimpleMatrixLieAlgebra P₀.lieAlgebra → ExistsFor G

/-! ## `SU(N)` with the fundamental Wilson action -/

/-- One-loop coefficient of the `SU(N)` beta function, `b₀ = 11 N / (3 (4π)²)`. -/
def b0 (N : ℕ) : ℝ := 11 * N / (3 * (4 * Real.pi) ^ 2)

/-- Two-loop coefficient of the `SU(N)` beta function, `b₁ = 34 N² / (3 (4π)⁴)`. -/
def b1 (N : ℕ) : ℝ := 34 * (N : ℝ) ^ 2 / (3 * (4 * Real.pi) ^ 4)

/-- Two-loop asymptotic scaling of the Wilson coupling `β = 2N / g₀²`:
`1/g₀² = 2 b₀ log(1/a) + (b₁/b₀) log log(1/a) + const + o(1)` as `a → 0`
(the constant encodes the scale `Λ`). -/
def AsymptoticScaling (N : ℕ) (a β : ℕ → ℝ) : Prop :=
  ∃ c : ℝ, Tendsto
    (fun k => β k / (2 * N) - 2 * b0 N * Real.log (1 / a k)
      - b1 N / b0 N * Real.log (Real.log (1 / a k)))
    atTop (𝓝 c)

/-- **Existence of quantum `SU(N)` Yang–Mills theory** on `ℝ⁴` (no mass-gap clause), as the
continuum limit of the fundamental Wilson action along the asymptotic-freedom trajectory. -/
def SUNExists (N : ℕ) : Prop :=
  ∃ (S : Schwinger ι4) (a β : ℕ → ℝ),
    IsYangMillsTheoryAlong (suGauge N) S a β ∧ AsymptoticScaling N a β

/-- Existence with mass gap for `SU(N)` with the fundamental Wilson action. (Stronger than
`ExistsWithMassGapFor (SU N)`, which allows any faithful representation.) -/
def SUNExistsWithMassGap (N : ℕ) : Prop := ExistsWithMassGap (suGauge N)

end YangMills

/-! ## Milestone rungs below `SUNExists` (strictly weaker; NOT the Clay problem)

`SUNExists` bundles two genuinely infrared clauses: full `O(4)` covariance and the cluster
property (equivalently, uniqueness of the vacuum of the periodic-torus limit). A Balaban-type
ultraviolet analysis plus compactness is expected to deliver everything *except* these. The
rungs below separate them, so that progress is measurable and never mislabelled:

* `SUNExistsM7a`: hypercubic (not full `O(4)`) covariance, no cluster clause.
* `SUNExistsM7b`: full `O(4)` covariance, no cluster clause.
* `SUNExists` (= M7c): everything.

None of these is a solution of the existence part of the Clay problem except `SUNExists`
(and, for general `G`, `ClayExistence`); JW require a unique vacuum. -/

namespace YangMills

/-- Hypercubic elements of `O(4)`: signed permutation matrices. -/
def IsHypercubic (R : O4) : Prop := ∀ i j, o4Matrix R i j = -1 ∨ o4Matrix R i j = 0 ∨ o4Matrix R i j = 1

/-- Euclidean covariance restricted to rotations `R` in a set `H` (all translations). -/
def OS.CovariantUnder (H : Set O4) (S : Schwinger ι4) : Prop :=
  ∀ R ∈ H, ∀ (a : E4) (n : ℕ) (f : Fin n → TestFn ι4), DisjointSupports f →
    S.S n (fun k => euclid tensorRep R a (f k)) = S.S n f

/-- The OS axioms without the cluster property, with covariance under `H ⊆ O(4)`. -/
structure OSAxiomsWeak (H : Set O4) (S : Schwinger ι4) : Prop where
  normalized : OS.Normalized S
  growth : OS.Growth S
  real : OS.Real S
  covariant : OS.CovariantUnder H S
  symmetric : OS.Symmetric S
  reflectionPositive : OS.ReflectionPositive tensorRep S

/-- Milestone predicate: everything in `IsYangMillsTheoryAlong` except the cluster property,
with covariance only under `H`. -/
def IsYangMillsTheoryWeakAlong {d : ℕ} {G : Type} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (H : Set O4) (P : GaugeGroup d G) (S : Schwinger ι4) (a β : ℕ → ℝ) : Prop :=
  OSAxiomsWeak H S ∧ NonTrivial tensorRep S ∧ FullFieldContent S ∧ ShortDistanceAF S ∧
    IsWilsonLimit P S a β

/-- **Rung M7a** (`SU(N)`): hypercubic covariance, no cluster clause. -/
def SUNExistsM7a (N : ℕ) : Prop :=
  ∃ (S : Schwinger ι4) (a β : ℕ → ℝ),
    IsYangMillsTheoryWeakAlong {R | IsHypercubic R} (suGauge N) S a β ∧ AsymptoticScaling N a β

/-- **Rung M7b** (`SU(N)`): full `O(4)` covariance, no cluster clause. -/
def SUNExistsM7b (N : ℕ) : Prop :=
  ∃ (S : Schwinger ι4) (a β : ℕ → ℝ),
    IsYangMillsTheoryWeakAlong Set.univ (suGauge N) S a β ∧ AsymptoticScaling N a β

/-- The ladder is ordered: `SUNExists → M7b`. -/
theorem SUNExists.toM7b {N : ℕ} (h : SUNExists N) : SUNExistsM7b N := by
  obtain ⟨S, a, β, ⟨hOS, hNT, hFF, hAF, hW⟩, hAS⟩ := h
  exact ⟨S, a, β, ⟨⟨hOS.normalized, hOS.growth, hOS.real,
    fun R _ a n f hf => hOS.covariant R a n f hf, hOS.symmetric, hOS.reflectionPositive⟩,
    hNT, hFF, hAF, hW⟩, hAS⟩

/-- The ladder is ordered: `M7b → M7a`. -/
theorem SUNExistsM7b.toM7a {N : ℕ} (h : SUNExistsM7b N) : SUNExistsM7a N := by
  obtain ⟨S, a, β, ⟨hOS, hNT, hFF, hAF, hW⟩, hAS⟩ := h
  exact ⟨S, a, β, ⟨⟨hOS.normalized, hOS.growth, hOS.real,
    fun R _ a n f hf => hOS.covariant R (Set.mem_univ R) a n f hf, hOS.symmetric,
    hOS.reflectionPositive⟩, hNT, hFF, hAF, hW⟩, hAS⟩

end YangMills
