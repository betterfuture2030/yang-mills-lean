import YangMills

open Filter Topology

namespace YangMills
set_option linter.unusedSectionVars false
variable {ι : Type} [Fintype ι] [DecidableEq ι]

/-- Independent minimal check: `a = 0` is an admissible "spatial vector". -/
example : (0 : E4) 0 = 0 := rfl

/-- translate 0 is the identity on test functions. -/
example (f : TestFn ι) : translate (0 : E4) f = f := by
  ext x i; simp [translate]

/-- OS.Cluster at a = 0 gives exact factorization (independent re-proof). -/
example (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι) (h : OS.Cluster ρ S)
    (A B : Monomial ι) (hA : A.OrderedPositive) (hB : B.OrderedPositive) :
    S.S _ (reflectAppend ρ A B) =
      S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f := by
  have h0 := h A B hA hB 0 rfl
  have hB' : ∀ lam : ℝ, B.map (translate (lam • (0 : E4))) = B := by
    intro lam; cases B; simp only [Monomial.map, smul_zero]; congr 1; funext k; ext x i
    simp [translate]
  have hc : (fun lam : ℝ => S.S _ (reflectAppend ρ A (B.map (translate (lam • (0 : E4))))))
      = fun _ => S.S _ (reflectAppend ρ A B) := by
    funext lam; rw [hB' lam]
  rw [hc] at h0
  exact tendsto_nhds_unique tendsto_const_nhds h0

/-- Proposed fix. -/
def OS.Cluster' (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι) : Prop :=
  ∀ (A B : Monomial ι), A.OrderedPositive → B.OrderedPositive →
    ∀ a : E4, a 0 = 0 → a ≠ 0 →
      Tendsto (fun lam : ℝ => S.S _ (reflectAppend ρ A (B.map (translate (lam • a)))))
        atTop (𝓝 (S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f))

/-- The fix keeps the trivial-theory sanity check. -/
example (ρ : O4 →* Matrix ι ι ℝ) : OS.Cluster' ρ (trivialTheory (ι := ι)) := by
  intro A B hA hB a ha _
  exact (trivial_osAxioms (ι := ι) ρ).cluster A B hA hB a ha

/-- Spatial unit vector exists, so the fixed hypothesis is non-vacuous. -/
example : ∃ a : E4, a 0 = 0 ∧ a ≠ 0 := by
  refine ⟨EuclideanSpace.single 1 1, by simp, ?_⟩
  intro h
  have := congrArg (fun v : E4 => v 1) h
  simp at this

end YangMills
