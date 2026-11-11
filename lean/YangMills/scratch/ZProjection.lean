import YangMills
open YangMills MeasureTheory

variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [MeasurableSpace G] [BorelSpace G]

lemma postcomp_apply (M : Matrix ι4 ι4 ℝ) (f : TestFn ι4) (x : E4) (l : ι4) :
    (SchwartzMap.postcompCLM (matCLM M) f) x l = ∑ i, (M l i : ℂ) * f x i := by
  simp [SchwartzMap.postcompCLM_apply, matCLM, Matrix.mulVec, dotProduct]

lemma smearedField_mul (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (M Z : Matrix ι4 ι4 ℝ)
    (f : TestFn ι4) (U : GaugeConfig G L) :
    smearedField P L a β (M.transpose * Z) f U =
      smearedField P L a β Z (SchwartzMap.postcompCLM (matCLM M) f) U := by
  unfold smearedField
  apply congrArg (fun s => ((a ^ 4 : ℝ) : ℂ) * s)
  refine Finset.sum_congr rfl fun x _ => ?_
  simp only [postcomp_apply, Matrix.mul_apply, Matrix.transpose_apply, Complex.ofReal_sum,
    Complex.ofReal_mul, Finset.sum_mul, Finset.mul_sum]
  conv_lhs => enter [2, x1]; rw [Finset.sum_comm]
  rw [Finset.sum_comm]
  conv_rhs => enter [2, x1]; rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun r _ => Finset.sum_congr rfl fun p _ =>
    Finset.sum_congr rfl fun q _ => ?_
  ring

lemma latticeSchwinger_mul (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (M Z : Matrix ι4 ι4 ℝ)
    (n : ℕ) (f : Fin n → TestFn ι4) :
    latticeSchwinger P L a β (M.transpose * Z) n f =
      latticeSchwinger P L a β Z n (fun k => SchwartzMap.postcompCLM (matCLM M) (f k)) := by
  unfold latticeSchwinger
  simp only [smearedField_mul]
