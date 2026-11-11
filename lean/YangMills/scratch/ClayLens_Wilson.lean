import YangMills

open Filter Topology MeasureTheory

namespace YangMills.ClayLens

variable {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [IsTopologicalGroup G]
  [CompactSpace G] [MeasurableSpace G] [BorelSpace G] [SecondCountableTopology G]

/-- With the renormalization matrices `Z_k = 0` (allowed: `Z` is unconstrained), every
lattice Schwinger function is `1` (n = 0) or `0` (n ≥ 1). -/
lemma latticeSchwinger_zeroZ (P : GaugeGroup d G) (L : ℕ) (a β : ℝ) (n : ℕ)
    (f : Fin n → TestFn ι4) :
    latticeSchwinger P L a β 0 n f = trivialS n f := by
  rw [trivialS_apply]
  cases n with
  | zero =>
    simp only [latticeSchwinger, Finset.univ_eq_empty, Finset.prod_empty, if_pos rfl]
    exact expect_const P L β 1
  | succ m =>
    simp only [Nat.succ_ne_zero, if_false]
    have hz : ∀ (g : TestFn ι4) (U : GaugeConfig G L), smearedField P L a β 0 g U = 0 := by
      intro g U; simp [smearedField]
    simp [latticeSchwinger, hz, expect]

/-- The trivial theory is a "Wilson limit" (for any admissible `a, β, L`), via `Z = 0`.
So the lattice clause alone does not constrain which fields survive renormalization. -/
theorem trivial_isWilsonLimit (P : GaugeGroup d G) (a β : ℕ → ℝ) (L : ℕ → ℕ)
    (ha : ∀ k, 0 < a k) (ha0 : Tendsto a atTop (𝓝 0))
    (hvol : Tendsto (fun k => a k * ((L k : ℝ) + 1)) atTop atTop)
    (hβ : Tendsto β atTop atTop) :
    IsWilsonLimit P (trivialTheory (ι := ι4)) a β := by
  refine ⟨L, fun _ => 0, ha, ha0, hvol, hβ, fun n f _ _ => ?_⟩
  simp only [latticeSchwinger_zeroZ]
  exact tendsto_const_nhds

end YangMills.ClayLens
