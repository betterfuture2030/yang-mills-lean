import YangMills

open YangMills
open scoped SchwartzMap

noncomputable section

variable {ι : Type} [Fintype ι] [DecidableEq ι]

/-- Schwartz norm of order `p` on configuration space `(ℝ⁴)ⁿ`. -/
def schwartzNormN {n : ℕ} (p : ℕ) (F : 𝓢(Fin n → E4, (Fin n → ι) → ℂ)) : ℝ :=
  ∑ k ∈ Finset.range (p + 1), ∑ m ∈ Finset.range (p + 1), SchwartzMap.seminorm ℂ k m F

/-- Fix A (literal OS II E0′, on 𝓢 rather than 𝓢₀, equivalent by Hahn–Banach):
the n-point function is the restriction to product test functions of a distribution on
`(ℝ⁴)ⁿ` whose order grows linearly in `n`. -/
def OS.LinearGrowth (S : Schwinger ι) : Prop :=
  ∃ (s : ℕ) (α β : ℝ), ∀ n : ℕ, ∃ T : 𝓢(Fin n → E4, (Fin n → ι) → ℂ) →L[ℂ] ℂ,
    (∀ F, ‖T F‖ ≤ α * (n.factorial : ℝ) ^ β * schwartzNormN (n * s) F) ∧
    ∀ (f : Fin n → TestFn ι) (F : 𝓢(Fin n → E4, (Fin n → ι) → ℂ)),
      (∀ x i, F x i = ∏ k, f k (x k) (i k)) → T F = S.S n f

/-- Fix B (OS II appendix / Summers product form): fixed Schwartz order per factor. -/
def OS.ProductGrowth (S : Schwinger ι) : Prop :=
  ∃ (s : ℕ) (α β : ℝ), ∀ (n : ℕ) (f : Fin n → TestFn ι),
    ‖S.S n f‖ ≤ α * (n.factorial : ℝ) ^ β * ∏ k, schwartzNorm s (f k)

-- Fix B implies the current OS.Growth (the current axiom is weaker), for α ≥ 0.
lemma schwartzNorm_mono (f : TestFn ι) {p q : ℕ} (h : p ≤ q) :
    schwartzNorm p f ≤ schwartzNorm q f := by
  unfold schwartzNorm
  have hsub : Finset.range (p + 1) ⊆ Finset.range (q + 1) := by
    intro x hx; simp at hx ⊢; omega
  calc ∑ k ∈ Finset.range (p + 1), ∑ m ∈ Finset.range (p + 1), SchwartzMap.seminorm ℂ k m f
      ≤ ∑ k ∈ Finset.range (p + 1), ∑ m ∈ Finset.range (q + 1), SchwartzMap.seminorm ℂ k m f :=
        Finset.sum_le_sum fun k _ => Finset.sum_le_sum_of_subset_of_nonneg hsub
          (fun _ _ _ => apply_nonneg _ _)
    _ ≤ _ := Finset.sum_le_sum_of_subset_of_nonneg hsub
          (fun _ _ _ => Finset.sum_nonneg fun _ _ => apply_nonneg _ _)

example (S : Schwinger ι) (h : OS.ProductGrowth S) : OS.Growth S := by
  obtain ⟨s, α, β, hb⟩ := h
  refine ⟨s, max α 0, β, fun n f => ?_⟩
  have hnn : ∀ p (g : TestFn ι), 0 ≤ schwartzNorm p g := fun p g =>
    Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => apply_nonneg _ _
  calc ‖S.S n f‖ ≤ α * (n.factorial : ℝ) ^ β * ∏ k, schwartzNorm s (f k) := hb n f
    _ ≤ max α 0 * (n.factorial : ℝ) ^ β * ∏ k, schwartzNorm s (f k) := by
        gcongr
        · exact Finset.prod_nonneg fun k _ => hnn _ _
        · exact le_max_left _ _
    _ ≤ max α 0 * (n.factorial : ℝ) ^ β * ∏ k, schwartzNorm (n * s) (f k) := by
        gcongr with k
        · exact fun i _ => hnn _ _
        · exact schwartzNorm_mono _ (Nat.le_mul_of_pos_left s (Fin.pos k))

end
