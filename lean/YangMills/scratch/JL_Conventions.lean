import YangMills

/-! Junk-value lens: conventions checks (scratch). -/

open YangMills

namespace YangMills.JLConv

/-- `timeReflection` negates coordinate 0. -/
example (x : E4) : (timeReflection x) 0 = - x 0 := by
  -- decompose x = (x 0) e0 + (x - (x 0) e0) with the second part ⟂ e0
  have hperp : x - (x 0) • e0 ∈ (ℝ ∙ e0)ᗮ := by
    rw [Submodule.mem_orthogonal_singleton_iff_inner_right]
    simp [e0, EuclideanSpace.inner_single_left, inner_sub_right, inner_smul_right]
  have hfix := Submodule.reflection_mem_subspace_eq_self hperp
  have hx : x = (x 0) • e0 + (x - (x 0) • e0) := by abel
  have : timeReflection x = -((x 0) • e0) + (x - (x 0) • e0) := by
    unfold timeReflection
    conv_lhs => rw [hx]
    rw [map_add, map_smul, Submodule.reflection_orthogonalComplement_singleton_eq_neg, hfix,
      smul_neg]
  rw [this]; simp [e0]

/-- `timeReflection` fixes the spatial coordinates. -/
example (x : E4) (i : Fin 4) (hi : i ≠ 0) : (timeReflection x) i = x i := by
  have hperp : x - (x 0) • e0 ∈ (ℝ ∙ e0)ᗮ := by
    rw [Submodule.mem_orthogonal_singleton_iff_inner_right]
    simp [e0, EuclideanSpace.inner_single_left, inner_sub_right, inner_smul_right]
  have hfix := Submodule.reflection_mem_subspace_eq_self hperp
  have hx : x = (x 0) • e0 + (x - (x 0) • e0) := by abel
  have : timeReflection x = -((x 0) • e0) + (x - (x 0) • e0) := by
    unfold timeReflection
    conv_lhs => rw [hx]
    rw [map_add, map_smul, Submodule.reflection_orthogonalComplement_singleton_eq_neg, hfix,
      smul_neg]
  rw [this]; simp [e0, PiLp.single_apply, hi]

/-- Any compact `G` with a `GaugeGroup` structure is second countable, so the Wilson weights
are measurable for the product σ-algebra and `partitionFn_pos` applies in the general-`G`
Clay statement (no junk `0/0`). -/
example {d : ℕ} {G : Type} [Group G] [TopologicalSpace G] [CompactSpace G]
    (P : GaugeGroup d G) : SecondCountableTopology G := by
  haveI : SecondCountableTopology (Matrix (Fin d) (Fin d) ℂ) :=
    inferInstanceAs (SecondCountableTopology (Fin d → Fin d → ℂ))
  have hc : Continuous P.mat := continuous_subtype_val.comp P.continuous
  have hi : Function.Injective P.mat := Subtype.val_injective.comp P.injective
  have hemb := (hc.isClosedEmbedding hi).isEmbedding
  exact hemb.secondCountableTopology

/-- `d = 0`: the Lie algebra is never simple (all `0 × 0` matrices commute). -/
example {G : Type} [Group G] [TopologicalSpace G] (P : GaugeGroup 0 G) :
    ¬ IsSimpleMatrixLieAlgebra P.lieAlgebra := by
  rintro ⟨⟨X, -, Y, -, h⟩, -⟩
  exact h (Subsingleton.elim _ _)

/-- `d = 1`: abelian, never simple. -/
example {G : Type} [Group G] [TopologicalSpace G] (P : GaugeGroup 1 G) :
    ¬ IsSimpleMatrixLieAlgebra P.lieAlgebra := by
  rintro ⟨⟨X, -, Y, -, h⟩, -⟩
  apply h
  ext i j
  fin_cases i; fin_cases j
  simp [Matrix.mul_apply, mul_comm]

end YangMills.JLConv
