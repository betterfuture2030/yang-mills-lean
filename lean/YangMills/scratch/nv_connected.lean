import YangMills
import Mathlib.Analysis.CStarAlgebra.Unitary.Connected

noncomputable section

open Complex

namespace YangMills

/-- There is a unit complex number `c ≠ -1` such that `-c` avoids a given finite set. -/
lemma exists_unit_avoid (S : Set ℂ) (hS : S.Finite) :
    ∃ c : ℂ, ‖c‖ = 1 ∧ c ≠ -1 ∧ -c ∉ S := by
  set T : Set ℂ := insert (-1) (Neg.neg ⁻¹' S) with hTdef
  have hT : T.Finite := (hS.preimage neg_injective.injOn).insert _
  have hinj : Set.InjOn (fun t : ℝ => ((Circle.exp t : Circle) : ℂ)) (Set.Icc 0 1) :=
    Circle.coe_injective.comp_injOn (Circle.exp_injOn_Icc (by linarith [Real.pi_gt_three]))
  have hinf : ((fun t : ℝ => ((Circle.exp t : Circle) : ℂ)) '' Set.Icc 0 1).Infinite :=
    (Set.Icc_infinite zero_lt_one).image hinj
  obtain ⟨c, ⟨t, -, rfl⟩, hc⟩ := (hinf.sdiff hT).nonempty
  refine ⟨_, by simp, fun h => hc (Or.inl h), fun h => hc (Or.inr h)⟩

lemma mem_unitary_of_norm_eq_one {c : ℂ} (hc : ‖c‖ = 1) : c ∈ unitary ℂ := by
  rw [Unitary.mem_iff]
  constructor
  · change (starRingEnd ℂ) c * c = 1
    rw [Complex.conj_mul', hc]; simp
  · change c * (starRingEnd ℂ) c = 1
    rw [Complex.mul_conj', hc]; simp

/-- Every unitary matrix is joined to `1` by a path in the unitary group. -/
lemma joined_one_unitary {n : ℕ} (u : unitary (Matrix (Fin n) (Fin n) ℂ)) : Joined 1 u := by
  open scoped Matrix.Norms.L2Operator in
  obtain ⟨c, hc1, hcm1, hcS⟩ :=
    exists_unit_avoid (spectrum ℂ (u : Matrix (Fin n) (Fin n) ℂ)) (Matrix.finite_spectrum _)
  have hcu : c ∈ unitary ℂ := mem_unitary_of_norm_eq_one hc1
  let s : unitary (Matrix (Fin n) (Fin n) ℂ) :=
    ⟨c • 1, Unitary.smul_mem_of_mem hcu (one_mem _)⟩
  let v : unitary (Matrix (Fin n) (Fin n) ℂ) :=
    ⟨star c • (u : Matrix (Fin n) (Fin n) ℂ), Unitary.smul_mem_of_mem (Unitary.star_mem hcu) u.2⟩
  have hsv : s * v = u := by
    apply Subtype.ext
    change (c • (1 : Matrix (Fin n) (Fin n) ℂ)) * (star c • (u : Matrix (Fin n) (Fin n) ℂ)) = u
    rw [smul_mul_smul, one_mul, Unitary.mul_star_self_of_mem hcu, one_smul]
  have h1 : Joined 1 s := by
    apply Unitary.joined
    change ‖c • (1 : Matrix (Fin n) (Fin n) ℂ) - 1‖ < 2
    rw [Unitary.norm_sub_one_lt_two_iff s.2]
    change -1 ∉ spectrum ℂ (c • (1 : Matrix (Fin n) (Fin n) ℂ))
    rcases subsingleton_or_nontrivial (Matrix (Fin n) (Fin n) ℂ) with h | h
    · simp [spectrum.of_subsingleton]
    · rw [← Algebra.algebraMap_eq_smul_one, spectrum.scalar_eq]
      simpa using hcm1.symm
  have h2 : Joined 1 v := by
    apply Unitary.joined
    change ‖star c • (u : Matrix (Fin n) (Fin n) ℂ) - 1‖ < 2
    rw [Unitary.norm_sub_one_lt_two_iff v.2]
    change -1 ∉ spectrum ℂ (star c • (u : Matrix (Fin n) (Fin n) ℂ))
    have hc0 : star c ≠ 0 := by
      intro h
      rw [star_eq_zero] at h
      simp [h] at hc1
    have : star c • (u : Matrix (Fin n) (Fin n) ℂ) =
        (Units.mk0 (star c) hc0) • (u : Matrix (Fin n) (Fin n) ℂ) := rfl
    rw [this, spectrum.unit_smul_eq_smul]
    rintro ⟨z, hz, hz'⟩
    have hz'' : star c * z = -1 := hz'
    have : z = -c := by
      calc z = (c * star c) * z := by rw [Unitary.mul_star_self_of_mem hcu, one_mul]
        _ = c * (star c * z) := by ring
        _ = -c := by rw [hz'']; ring
    exact hcS (this ▸ hz)
  simpa [hsv] using h1.mul h2

/-- The unitary group `U(n)` is path connected. -/
theorem pathConnectedSpace_unitary (n : ℕ) :
    PathConnectedSpace (unitary (Matrix (Fin n) (Fin n) ℂ)) where
  nonempty := ⟨1⟩
  joined x y := (joined_one_unitary x).symm.trans (joined_one_unitary y)

lemma mulSingle_star_det_mem_unitary {n : ℕ} {d : ℂ} (hd : d ∈ unitary ℂ) :
    (Pi.mulSingle 0 (star d) : Fin (n + 1) → ℂ) ∈ unitary (Fin (n + 1) → ℂ) := by
  rw [Unitary.mem_iff]
  constructor
  · funext i
    by_cases hi : i = 0
    · subst hi; simpa using Unitary.mul_star_self_of_mem hd
    · simp [hi]
  · funext i
    by_cases hi : i = 0
    · subst hi; simpa using Unitary.star_mul_self_of_mem hd
    · simp [hi]

/-- The retraction `U(n+1) → SU(n+1)`, `U ↦ U · diag(conj (det U), 1, …, 1)`. -/
def retractSU (n : ℕ) (U : unitary (Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ)) : SU (n + 1) :=
  ⟨(U : Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ) *
      Matrix.diagonal (Pi.mulSingle 0 (star (U : Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ).det)), by
    have hdet : (U : Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ).det ∈ unitary ℂ :=
      Matrix.det_of_mem_unitary U.2
    rw [Matrix.mem_specialUnitaryGroup_iff]
    constructor
    · refine mul_mem U.2 ?_
      rw [Matrix.diagonal_mem_unitary]
      exact mulSingle_star_det_mem_unitary hdet
    · rw [Matrix.det_mul, Matrix.det_diagonal, Fintype.prod_pi_mulSingle']
      exact Unitary.mul_star_self_of_mem hdet⟩

lemma continuous_retractSU (n : ℕ) : Continuous (retractSU n) := by
  apply Continuous.subtype_mk
  refine continuous_subtype_val.mul ?_
  refine Continuous.matrix_diagonal ?_
  exact (continuous_mulSingle 0).comp (continuous_subtype_val.matrix_det.star)

lemma surjective_retractSU (n : ℕ) : Function.Surjective (retractSU n) := by
  intro U
  refine ⟨⟨(U : Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ),
    (Matrix.mem_specialUnitaryGroup_iff.mp U.2).1⟩, ?_⟩
  apply Subtype.ext
  have h1 : (U : Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ).det = 1 :=
    (Matrix.mem_specialUnitaryGroup_iff.mp U.2).2
  simp [retractSU, h1]

/-- `SU(N)` is path connected. -/
theorem su_pathConnectedSpace (N : ℕ) : PathConnectedSpace (SU N) := by
  cases N with
  | zero =>
    have hsub : ∀ x y : SU 0, x = y := fun x y =>
      Subtype.ext (Matrix.ext fun i => Fin.elim0 i)
    exact ⟨⟨1⟩, fun x y => hsub x y ▸ Joined.refl x⟩
  | succ n =>
    have := pathConnectedSpace_unitary (n + 1)
    exact (surjective_retractSU n).pathConnectedSpace (continuous_retractSU n)

/-- **`SU(N)` is connected.** -/
theorem su_connected_proof (N : ℕ) : ConnectedSpace (SU N) := by
  have := su_pathConnectedSpace N
  infer_instance

/-- Compatibility check: the statement matches `OpenProblems.su_connected` verbatim, with the
subspace topology on `↥(Matrix.specialUnitaryGroup (Fin N) ℂ)`. -/
example (N : ℕ) : @ConnectedSpace ↥(Matrix.specialUnitaryGroup (Fin N) ℂ)
    instTopologicalSpaceSubtype := su_connected_proof N

end YangMills

#print axioms YangMills.su_connected_proof
