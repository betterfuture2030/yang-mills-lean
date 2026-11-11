import YangMills
open MeasureTheory Filter Topology

namespace YangMills

variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [MeasurableSpace G] [BorelSpace G]

noncomputable def projT (M : Matrix ι4 ι4 ℝ) : TestFn ι4 →L[ℂ] TestFn ι4 :=
  SchwartzMap.postcompCLM (matCLM M)

noncomputable def Schwinger.pull (S : Schwinger ι4) (M : Matrix ι4 ι4 ℝ) : Schwinger ι4 :=
  ⟨fun n => (S.S n).compContinuousLinearMap (fun _ => projT M)⟩

lemma pull_apply (S : Schwinger ι4) (M : Matrix ι4 ι4 ℝ) (n : ℕ) (f : Fin n → TestFn ι4) :
    (S.pull M).S n f = S.S n (fun k => projT M (f k)) := rfl

lemma support_projT_subset (M : Matrix ι4 ι4 ℝ) (f : TestFn ι4) :
    Function.support (projT M f : E4 → ι4 → ℂ) ⊆ Function.support (f : E4 → ι4 → ℂ) := by
  intro x hx
  contrapose! hx
  simp only [Function.mem_support, not_not] at hx ⊢
  show (matCLM M) (f x) = 0
  rw [hx, map_zero]

lemma tsupport_projT_subset (M : Matrix ι4 ι4 ℝ) (f : TestFn ι4) :
    tsupport (projT M f : E4 → ι4 → ℂ) ⊆ tsupport (f : E4 → ι4 → ℂ) :=
  closure_mono (support_projT_subset M f)

lemma disjoint_pull {n : ℕ} (M : Matrix ι4 ι4 ℝ) (f : Fin n → TestFn ι4)
    (h : DisjointSupports f) : DisjointSupports (fun k => projT M (f k)) :=
  fun _ _ hij => (h hij).mono (tsupport_projT_subset M _) (tsupport_projT_subset M _)

lemma projT_apply (M : Matrix ι4 ι4 ℝ) (g : TestFn ι4) (x : E4) (l : ι4) :
    (projT M g) x l = ∑ i, (M l i : ℂ) * g x i := by
  simp [projT, SchwartzMap.postcompCLM_apply, matCLM, Matrix.mulVec, dotProduct]

lemma smearedField_mul' (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (M Z : Matrix ι4 ι4 ℝ)
    (f : TestFn ι4) (U : GaugeConfig G L) :
    smearedField P L a β (M.transpose * Z) f U = smearedField P L a β Z (projT M f) U := by
  unfold smearedField
  apply congrArg (fun s => ((a ^ 4 : ℝ) : ℂ) * s)
  refine Finset.sum_congr rfl fun x _ => ?_
  simp only [projT_apply, Matrix.mul_apply, Matrix.transpose_apply, Complex.ofReal_sum,
    Complex.ofReal_mul, Finset.sum_mul, Finset.mul_sum]
  conv_lhs => enter [2, x1]; rw [Finset.sum_comm]
  rw [Finset.sum_comm]
  conv_rhs => enter [2, x1]; rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun p _ =>
    Finset.sum_congr rfl fun q _ => ?_
  ring

/-- The renormalization `Z` absorbs any field-space matrix `M`. -/
theorem wilsonLimit_pull (P : GaugeGroup d G) (S : Schwinger ι4) (a β : ℕ → ℝ)
    (M : Matrix ι4 ι4 ℝ) (h : IsWilsonLimit P S a β) : IsWilsonLimit P (S.pull M) a β := by
  obtain ⟨L, Z, ha, ha0, haL, hβ, hlim⟩ := h
  refine ⟨L, fun k => M.transpose * Z k, ha, ha0, haL, hβ, fun n f hc hd => ?_⟩
  have hc' : ∀ k, HasCompactSupport (projT M (f k) : E4 → ι4 → ℂ) := fun k =>
    (hc k).mono (support_projT_subset M (f k))
  have := hlim n (fun k => projT M (f k)) hc' (disjoint_pull M f hd)
  rw [pull_apply]
  refine this.congr fun k => ?_
  unfold latticeSchwinger
  simp only [smearedField_mul']

/-- Covariance transfers whenever `M` commutes with every `ρ(R)ᵀ`. -/
theorem covariant_pull (S : Schwinger ι4) (M : Matrix ι4 ι4 ℝ)
    (hM : ∀ R : O4, M * (tensorRep R⁻¹).transpose = (tensorRep R⁻¹).transpose * M)
    (hS : OS.Covariant tensorRep S) : OS.Covariant tensorRep (S.pull M) := by
  intro R a n f hd
  rw [pull_apply, pull_apply]
  have hmat : ∀ (A B : Matrix ι4 ι4 ℝ) (v : ι4 → ℂ),
      matCLM A (matCLM B v) = matCLM (A * B) v := by
    intro A B v
    simp only [matCLM, LinearMap.coe_toContinuousLinearMap', Matrix.toLin'_apply,
      Matrix.mulVec_mulVec, Matrix.map_mul]
  have hcomm : ∀ g : TestFn ι4, projT M (euclid tensorRep R a g) =
      euclid tensorRep R a (projT M g) := by
    intro g
    ext x
    simp only [projT, euclid, ContinuousLinearMap.comp_apply, SchwartzMap.postcompCLM_apply,
      SchwartzMap.compSubConstCLM_apply, SchwartzMap.compCLMOfContinuousLinearEquiv_apply,
      Function.comp_apply, hmat, hM R]
  simp only [hcomm]
  exact hS R a n _ (disjoint_pull M f hd)

end YangMills
