import YangMills

open Filter Topology

namespace YangMills.VJL1

open YangMills

variable {ι : Type} [Fintype ι] [DecidableEq ι] (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)

/-- Proposed fix: exclude the zero vector. -/
def ClusterFixed : Prop :=
  ∀ (A B : Monomial ι), A.OrderedPositive → B.OrderedPositive →
    ∀ a : E4, a ≠ 0 → a 0 = 0 →
      Tendsto (fun lam : ℝ => S.S _ (reflectAppend ρ A (B.map (translate (lam • a)))))
        atTop (𝓝 (S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f))

/-- Trivial theory still satisfies the fixed cluster axiom (one extra binder). -/
theorem trivial_clusterFixed : ClusterFixed ρ (trivialTheory (ι := ι)) := by
  intro A B _ _ a _ _
  have hconst : ∀ lam : ℝ,
      trivialTheory.S _ (reflectAppend ρ A (B.map (translate (lam • a)))) =
        trivialTheory.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) *
          trivialTheory.S _ B.f := by
    intro lam
    simp only [trivialTheory]
    rw [trivialS_apply, trivialS_apply, trivialS_apply]
    simp only [Monomial.map, Nat.add_eq_zero_iff]
    by_cases hA : A.n = 0 <;> by_cases hB : B.n = 0 <;> simp [hA, hB]
  simp only [hconst]
  exact tendsto_const_nhds

/-- The fixed axiom implies the old one restricted to a ≠ 0, and the old one implies the new. -/
theorem old_implies_fixed (h : OS.Cluster ρ S) : ClusterFixed ρ S :=
  fun A B hA hB a _ ha0 => h A B hA hB a ha0

/-- A nonzero spatial vector exists (so the fixed axiom is not vacuous in `a`). -/
example : ∃ a : E4, a ≠ 0 ∧ a 0 = 0 := by
  refine ⟨EuclideanSpace.single 1 1, ?_, ?_⟩
  · intro h
    have := congrArg (fun v : E4 => v 1) h
    simp at this
  · simp

end YangMills.VJL1
