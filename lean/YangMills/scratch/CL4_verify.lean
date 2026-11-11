import YangMills

namespace YangMills

/-- Proposed representation-independent variant: the prover may choose the faithful
representation used to build the Wilson action. -/
def ClayYangMillsSomeRep : Prop :=
  ∀ (d : ℕ) (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [ConnectedSpace G] [MeasurableSpace G] [BorelSpace G] (P : GaugeGroup d G),
    IsSimpleMatrixLieAlgebra P.lieAlgebra → ∃ (d' : ℕ) (P' : GaugeGroup d' G), ExistsWithMassGap P'

/-- The current statement implies the variant (so the current one is at least as strong). -/
theorem clay_implies_someRep : ClayYangMills → ClayYangMillsSomeRep := by
  intro h d G _ _ _ _ _ _ _ P hP
  exact ⟨d, P, h d G P hP⟩

-- `ExistsWithMassGap` genuinely depends on `P` (the Wilson action is built from `P.mat`):
example {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] (P : GaugeGroup d G) {L : ℕ}
    (β : ℝ) (U : GaugeConfig G L) :
    wilsonAction P β U = β * ∑ x : Site L, ∑ μ : Fin 4, ∑ ν : Fin 4,
      if μ < ν then 1 - (Matrix.trace (P.mat (plaquette U x μ ν))).re / d else 0 := rfl

end YangMills
