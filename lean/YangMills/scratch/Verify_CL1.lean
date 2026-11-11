import YangMills

open Filter Topology

namespace YangMills.VerifyCL1

variable {ι : Type} [Fintype ι] [DecidableEq ι] (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)

/-- Proposed fixed cluster axiom. -/
def ClusterFixed : Prop :=
  ∀ (A B : Monomial ι), A.OrderedPositive → B.OrderedPositive →
    ∀ a : E4, a 0 = 0 → a ≠ 0 →
      Tendsto (fun lam : ℝ => S.S _ (reflectAppend ρ A (B.map (translate (lam • a)))))
        atTop (𝓝 (S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f))

/-- The original axiom implies the fixed one (so the fix only weakens). -/
example (h : OS.Cluster ρ S) : ClusterFixed ρ S :=
  fun A B hA hB a ha _ => h A B hA hB a ha

/-- The trivial theory still satisfies the fixed axiom. -/
example : ClusterFixed ρ (trivialTheory (ι := ι)) :=
  fun A B hA hB a ha _ => (trivial_osAxioms ρ).cluster A B hA hB a ha

/-- `a = 0` is indeed admitted by the original hypothesis `a 0 = 0`. -/
example : (0 : E4) 0 = 0 := rfl

end YangMills.VerifyCL1
