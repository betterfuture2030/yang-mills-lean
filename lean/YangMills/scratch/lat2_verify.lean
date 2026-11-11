import YangMills

namespace YangMills

/-- Current statement unfolds to: every faithful matrix realization `P` of `G` must have its
own Wilson-action continuum limit. -/
example (h : ClayYangMills) (d : ℕ) (G : Type) [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [ConnectedSpace G] [MeasurableSpace G]
    [BorelSpace G] (P : GaugeGroup d G) (hs : IsSimpleMatrixLieAlgebra P.lieAlgebra) :
    ExistsWithMassGap P := h d G P hs

/-- Proposed representation-agnostic variant. -/
def ClayYangMills' : Prop :=
  ∀ (d₀ : ℕ) (G : Type) [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
    [ConnectedSpace G] [MeasurableSpace G] [BorelSpace G] (P₀ : GaugeGroup d₀ G),
    IsSimpleMatrixLieAlgebra P₀.lieAlgebra → ∃ (d : ℕ) (P : GaugeGroup d G), ExistsWithMassGap P

/-- The current statement implies the variant (it is a strengthening). -/
theorem clay_imp_clay' : ClayYangMills → ClayYangMills' := by
  intro h d₀ G _ _ _ _ _ _ _ P₀ hs
  exact ⟨d₀, P₀, h d₀ G P₀ hs⟩

/-- SU(N) corollary in the variant has to be representation-existential too. -/
def SUNExistsWithMassGap' (N : ℕ) : Prop :=
  ∃ (d : ℕ) (P : GaugeGroup d (SU N)), ExistsWithMassGap P

theorem su_mass_gap_of_clay' (h : ClayYangMills') (N : ℕ) (hN : 2 ≤ N) :
    SUNExistsWithMassGap' N := by
  haveI := su_connected N
  exact h N (SU N) (suGauge N) (su_lieAlgebra_simple N hN)

end YangMills
