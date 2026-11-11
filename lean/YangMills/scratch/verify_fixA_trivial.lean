import YangMills

open YangMills
open scoped SchwartzMap

noncomputable section

variable {ι : Type} [Fintype ι] [DecidableEq ι]

def schwartzNormN' {n : ℕ} (p : ℕ) (F : 𝓢(Fin n → E4, (Fin n → ι) → ℂ)) : ℝ :=
  ∑ k ∈ Finset.range (p + 1), ∑ m ∈ Finset.range (p + 1), SchwartzMap.seminorm ℂ k m F

def OS.LinearGrowth' (S : Schwinger ι) : Prop :=
  ∃ (s : ℕ) (α β : ℝ), ∀ n : ℕ, ∃ T : 𝓢(Fin n → E4, (Fin n → ι) → ℂ) →L[ℂ] ℂ,
    (∀ F, ‖T F‖ ≤ α * (n.factorial : ℝ) ^ β * schwartzNormN' (n * s) F) ∧
    ∀ (f : Fin n → TestFn ι) (F : 𝓢(Fin n → E4, (Fin n → ι) → ℂ)),
      (∀ x i, F x i = ∏ k, f k (x k) (i k)) → T F = S.S n f

/-- The trivial theory satisfies the literal E0′ (Fix A): `T₀` = evaluation, `Tₙ = 0`. -/
example : OS.LinearGrowth' (trivialTheory (ι := ι)) := by
  refine ⟨0, 1, 0, fun n => ?_⟩
  cases n with
  | zero =>
    let T : 𝓢(Fin 0 → E4, (Fin 0 → ι) → ℂ) →L[ℂ] ℂ :=
      (ContinuousLinearMap.proj (R := ℂ) (φ := fun _ : (Fin 0 → ι) => ℂ) Fin.elim0).comp
        ((BoundedContinuousFunction.evalCLM ℂ (Fin.elim0 : Fin 0 → E4)).comp
          (SchwartzMap.toBoundedContinuousFunctionCLM ℂ (Fin 0 → E4) ((Fin 0 → ι) → ℂ)))
    refine ⟨T, fun F => ?_, fun f F hF => ?_⟩
    · have h1 : ‖T F‖ ≤ ‖F (Fin.elim0 : Fin 0 → E4)‖ := by
        simpa [T, BoundedContinuousFunction.evalCLM_apply] using
          norm_le_pi_norm (F (Fin.elim0 : Fin 0 → E4)) Fin.elim0
      have h2 : ‖F (Fin.elim0 : Fin 0 → E4)‖ ≤ SchwartzMap.seminorm ℂ 0 0 F := by
        simpa using SchwartzMap.le_seminorm ℂ 0 0 F (Fin.elim0 : Fin 0 → E4)
      simp only [Nat.factorial_zero, Nat.cast_one, Real.rpow_zero, one_mul, zero_mul,
        schwartzNormN', zero_add, Finset.range_one, Finset.sum_singleton]
      linarith
    · simp [T, BoundedContinuousFunction.evalCLM_apply, hF, trivialTheory, trivialS_apply]
  | succ m =>
    refine ⟨0, fun F => ?_, fun f F _ => ?_⟩
    · simp only [zero_apply, norm_zero, Real.rpow_zero, one_mul]
      exact Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => apply_nonneg _ _
    · simp [trivialTheory, trivialS_apply]

end
