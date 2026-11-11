import YangMills
open Filter Topology
namespace YangMills

-- time reflection really negates the time axis
example : timeReflection e0 = -e0 := by
  unfold timeReflection
  rw [Submodule.reflection_orthogonalComplement_singleton_eq_neg]

-- a = 0 is an admissible "spatial direction" in OS.Cluster
example : (0 : E4) 0 = 0 := by simp

-- AsymptoticScaling is trivially true for N = 0 (junk 0/0), harmless since hN : 2 ≤ N
example (a β : ℕ → ℝ) : AsymptoticScaling 0 a β := by
  refine ⟨0, ?_⟩
  simp [b0, b1]

end YangMills
