import YangMills

open YangMills MeasureTheory

-- (1) Two-loop conventions: 2 b0 = 11N/(24 pi^2) and b1/(2 b0^2) = 51/121 for SU(3)
example : 2 * b0 3 = 11 / (8 * Real.pi ^ 2) := by
  unfold b0; have := Real.pi_pos; field_simp; ring

example : b1 3 / (2 * b0 3 ^ 2) = 51 / 121 := by
  unfold b0 b1; have := Real.pi_pos.ne'; field_simp; ring

-- general N >= 1: b1/(2 b0^2) = 51/121 * ... = 102/242 independent of N
example (N : ℕ) (hN : 1 ≤ N) : b1 N / (2 * b0 N ^ 2) = 51 / 121 := by
  unfold b0 b1
  have hN' : (N : ℝ) ≠ 0 := by positivity
  have := Real.pi_pos.ne'
  field_simp; ring

-- (2) Z is unconstrained: Z = 0 collapses every n >= 1 lattice Schwinger function to 0
example (N L : ℕ) (a β : ℝ) (n : ℕ) (hn : 0 < n) (f : Fin n → TestFn ι4) :
    latticeSchwinger (suGauge N) L a β 0 n f = 0 := by
  unfold latticeSchwinger expect
  have h0 : ∀ U, ∏ k, smearedField (suGauge N) L a β 0 (f k) U = 0 := by
    intro U
    apply Finset.prod_eq_zero (i := ⟨0, hn⟩) (Finset.mem_univ _)
    simp [smearedField]
  simp [h0]
