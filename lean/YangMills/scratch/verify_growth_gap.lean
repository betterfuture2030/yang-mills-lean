import YangMills

open YangMills
open scoped SchwartzMap

noncomputable section

variable {ι : Type} [Fintype ι] [DecidableEq ι]

/-- Per-factor bound used in the counterexample: evaluating the p-th directional derivative
of a component at a point is bounded by `schwartzNorm p`. Hence the multilinear form
`∏ₖ (∂_v^{n s} f_k)_{i}(c_k)` satisfies `OS.Growth` with `α = 1, β = 0`. -/
lemma eval_deriv_le (p : ℕ) (f : TestFn ι) (c v : E4) (hv : ‖v‖ ≤ 1) (i : ι) :
    ‖(iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c (fun _ => v)) i‖ ≤ schwartzNorm p f := by
  have h1 : ‖(iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c (fun _ => v)) i‖ ≤
      ‖iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c (fun _ => v)‖ := norm_le_pi_norm _ i
  have h2 : ‖iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c (fun _ => v)‖ ≤
      ‖iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c‖ := by
    calc _ ≤ ‖iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c‖ * ∏ _ : Fin p, ‖v‖ :=
          ContinuousMultilinearMap.le_opNorm _ _
      _ ≤ ‖iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c‖ * 1 := by
          gcongr
          rw [Finset.prod_const, Finset.card_univ, Fintype.card_fin]; exact pow_le_one₀ (norm_nonneg _) hv
      _ = _ := mul_one _
  have h3 : ‖iteratedFDeriv ℝ p (f : E4 → ι → ℂ) c‖ ≤ SchwartzMap.seminorm ℂ 0 p f := by
    simpa using SchwartzMap.le_seminorm ℂ 0 p f c
  have h4 : SchwartzMap.seminorm ℂ 0 p f ≤ schwartzNorm p f := by
    unfold schwartzNorm
    have hk : (0 : ℕ) ∈ Finset.range (p + 1) := by simp
    have hm : p ∈ Finset.range (p + 1) := by simp
    calc SchwartzMap.seminorm ℂ 0 p f
        ≤ ∑ m ∈ Finset.range (p + 1), SchwartzMap.seminorm ℂ 0 m f :=
          Finset.single_le_sum (f := fun m => SchwartzMap.seminorm ℂ 0 m f)
            (fun _ _ => apply_nonneg _ _) hm
      _ ≤ _ := Finset.single_le_sum
            (f := fun k => ∑ m ∈ Finset.range (p + 1), SchwartzMap.seminorm ℂ k m f)
            (fun _ _ => Finset.sum_nonneg fun _ _ => apply_nonneg _ _) hk
  linarith

end
