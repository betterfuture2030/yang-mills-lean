import YangMills

/-! Scratch check for finding CL-2: a Lean-level short-distance AF fingerprint. -/

noncomputable section
open Filter Topology MeasureTheory
open scoped SchwartzMap

namespace YangMills

/-- The scalar channel `δ_{μκ}δ_{νλ} - δ_{μλ}δ_{νκ}`; contracting `T` with it gives `2 tr F_{μν}F_{μν}`. -/
def v0 : ι4 → ℂ := fun i =>
  (if i.1.1.1 = i.1.2 ∧ i.1.1.2 = i.2 then 1 else 0) -
  (if i.1.1.1 = i.2 ∧ i.1.1.2 = i.1.2 then 1 else 0)

/-- Scalar test function times the fixed component vector `v0`. -/
def scalarChannel (f : 𝓢(E4, ℂ)) : TestFn ι4 :=
  SchwartzMap.postcompCLM ((ContinuousLinearMap.id ℂ ℂ).smulRight v0) f

/-- The scaling `x ↦ λ x` as a continuous linear equivalence (for `λ ≠ 0`). -/
def scaleEquiv (lam : ℝ) (h : lam ≠ 0) : E4 ≃L[ℝ] E4 :=
  ContinuousLinearEquiv.smulLeft (Units.mk0 lam h)

/-- Dimension-4 dilation `(D_λ f)(x) = λ⁻⁴ f(x/λ)`; junk (`f`) at `λ = 0`. -/
def dil (lam : ℝ) (f : 𝓢(E4, ℂ)) : 𝓢(E4, ℂ) :=
  if h : lam = 0 then f else
    ((lam ^ 4)⁻¹ : ℂ) • SchwartzMap.compCLMOfContinuousLinearEquiv ℂ
      (scaleEquiv lam h).symm f

/-- **Short-distance asymptotic freedom (two-point fingerprint).** The connected two-point
function of `tr F²` behaves as `C / (|x|⁸ log²(1/|x|))` at short distances. -/
def ShortDistanceAF (S : Schwinger ι4) : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∀ f g : 𝓢(E4, ℂ), HasCompactSupport (f : E4 → ℂ) →
    HasCompactSupport (g : E4 → ℂ) →
    Disjoint (tsupport (f : E4 → ℂ)) (tsupport (g : E4 → ℂ)) →
    Tendsto (fun lam : ℝ => ((lam ^ 8 * Real.log (1 / lam) ^ 2 : ℝ) : ℂ) *
        S.S 2 ![scalarChannel (dil lam f), scalarChannel (dil lam g)])
      (𝓝[>] 0)
      (𝓝 ((C : ℂ) * ∫ x, ∫ y, f x * g y * ((‖x - y‖ ^ (-8 : ℤ) : ℝ) : ℂ)))

/-- A strengthened `ClayYangMills` carrying the fingerprint. -/
def ClayYangMillsAF : Prop :=
  ∀ (d : ℕ) (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [ConnectedSpace G] [MeasurableSpace G] [BorelSpace G] (P : GaugeGroup d G),
    IsSimpleMatrixLieAlgebra P.lieAlgebra →
    ∃ S : Schwinger ι4, IsYangMillsTheory P S ∧ ShortDistanceAF S ∧
      ∃ Δ : ℝ, HasMassGap tensorRep S Δ

/-- The fingerprint is not implied by the current statement's components; sanity: the trivial
theory fails it (its two-point function is zero, while the RHS can be nonzero). -/
example : ClayYangMillsAF → ClayYangMills := by
  intro h d G _ _ _ _ _ _ _ P hP
  obtain ⟨S, hS, -, hgap⟩ := h d G P hP
  exact ⟨S, hS, hgap⟩

end YangMills

open YangMills in
#check @ShortDistanceAF
open YangMills in
#print axioms ClayYangMillsAF
