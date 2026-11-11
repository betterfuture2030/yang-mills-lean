import YangMills

/-!
# The Lie algebra of `SU(N)` is `𝔰𝔲(N)`

`(suGauge N).lieAlgebra = {X | Xᴴ = -X ∧ tr X = 0}`.

Mathlib does not (yet) have `det (exp A) = exp (tr A)`; we prove it for skew-Hermitian `A`
via the spectral theorem applied to the Hermitian matrix `I • A`, which is all that is needed.
-/

noncomputable section

open Matrix

namespace YangMills

/-- `det (exp (U D U⋆)) = exp (tr (U D U⋆))` for `U` unitary and `D` diagonal. -/
lemma det_exp_unitary_conj_diagonal {N : ℕ} (U : Matrix (Fin N) (Fin N) ℂ)
    (hU : star U * U = 1) (v : Fin N → ℂ) :
    (NormedSpace.exp (U * diagonal v * star U)).det =
      Complex.exp (U * diagonal v * star U).trace := by
  have hinv : U⁻¹ = star U := Matrix.inv_eq_left_inv hU
  have hdet : IsUnit U.det := Matrix.isUnit_det_of_left_inverse hU
  have hUu : IsUnit U := (Matrix.isUnit_iff_isUnit_det U).mpr hdet
  rw [← hinv, Matrix.exp_conj U (diagonal v) hUu, Matrix.det_conj hUu, Matrix.exp_diagonal,
    Matrix.det_diagonal, Matrix.trace_mul_comm, ← Matrix.mul_assoc,
    Matrix.nonsing_inv_mul U hdet, Matrix.one_mul, Matrix.trace_diagonal, Complex.exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [Pi.coe_exp, Complex.exp_eq_exp_ℂ]

/-- Unitary diagonalisation of a Hermitian matrix, with the eigen-data existentially packaged. -/
lemma exists_unitary_diagonal_of_isHermitian {N : ℕ} {H : Matrix (Fin N) (Fin N) ℂ}
    (hH : H.IsHermitian) :
    ∃ U : Matrix (Fin N) (Fin N) ℂ, star U * U = 1 ∧
      ∃ v : Fin N → ℂ, H = U * diagonal v * star U := by
  refine ⟨(hH.eigenvectorUnitary : Matrix (Fin N) (Fin N) ℂ),
    Unitary.coe_star_mul_self _, RCLike.ofReal ∘ hH.eigenvalues, ?_⟩
  have h := hH.spectral_theorem
  rw [Unitary.conjStarAlgAut_apply] at h
  exact h

/-- Unitary diagonalisation of a skew-Hermitian matrix. -/
lemma exists_unitary_diagonal_of_skew {N : ℕ} {Y : Matrix (Fin N) (Fin N) ℂ}
    (hY : Y.conjTranspose = -Y) :
    ∃ U : Matrix (Fin N) (Fin N) ℂ, star U * U = 1 ∧
      ∃ v : Fin N → ℂ, Y = U * diagonal v * star U := by
  have hH : (Complex.I • Y).IsHermitian := by
    unfold Matrix.IsHermitian
    rw [Matrix.conjTranspose_smul, hY, Complex.star_def, Complex.conj_I, smul_neg, neg_smul,
      neg_neg]
  obtain ⟨U, hU, v, hv⟩ := exists_unitary_diagonal_of_isHermitian hH
  refine ⟨U, hU, (-Complex.I) • v, ?_⟩
  have hY' : Y = (-Complex.I) • (Complex.I • Y) := by
    rw [smul_smul, neg_mul, Complex.I_mul_I, neg_neg, one_smul]
  rw [hY', hv, Matrix.diagonal_smul, Matrix.mul_smul, Matrix.smul_mul]

/-- `det (exp Y) = exp (tr Y)` for skew-Hermitian `Y`. -/
lemma det_exp_of_skew {N : ℕ} {Y : Matrix (Fin N) (Fin N) ℂ} (hY : Y.conjTranspose = -Y) :
    (NormedSpace.exp Y).det = Complex.exp Y.trace := by
  obtain ⟨U, hU, v, rfl⟩ := exists_unitary_diagonal_of_skew hY
  exact det_exp_unitary_conj_diagonal U hU v

/-- Real multiples of a skew-Hermitian matrix are skew-Hermitian. -/
lemma skew_ofReal_smul {N : ℕ} {X : Matrix (Fin N) (Fin N) ℂ} (hX : X.conjTranspose = -X)
    (t : ℝ) : ((t : ℂ) • X).conjTranspose = -((t : ℂ) • X) := by
  rw [Matrix.conjTranspose_smul, hX, Complex.star_def, Complex.conj_ofReal, smul_neg]

lemma conjTranspose_ofReal_smul {N : ℕ} (X : Matrix (Fin N) (Fin N) ℂ) (t : ℝ) :
    ((t : ℂ) • X).conjTranspose = (t : ℂ) • X.conjTranspose := by
  rw [Matrix.conjTranspose_smul, Complex.star_def, Complex.conj_ofReal]

/-- `exp` of a skew-Hermitian matrix is unitary. -/
lemma star_exp_mul_exp_of_skew {N : ℕ} {Y : Matrix (Fin N) (Fin N) ℂ}
    (hY : Y.conjTranspose = -Y) :
    star (NormedSpace.exp Y) * NormedSpace.exp Y = 1 := by
  have hdet : IsUnit (NormedSpace.exp Y).det :=
    (Matrix.isUnit_iff_isUnit_det _).mp (Matrix.isUnit_exp Y)
  rw [Matrix.star_eq_conjTranspose, ← Matrix.exp_conjTranspose, hY, Matrix.exp_neg]
  exact Matrix.nonsing_inv_mul _ hdet

/-- Real-parameter one-parameter groups determine their generator:
if `exp (t A) = exp (t B)` for all real `t` then `A = B` (differentiate at `t = 0`). -/
lemma eq_of_exp_ofReal_smul_eq {N : ℕ} {A B : Matrix (Fin N) (Fin N) ℂ}
    (h : ∀ t : ℝ, NormedSpace.exp ((t : ℂ) • A) = NormedSpace.exp ((t : ℂ) • B)) : A = B := by
  open scoped Matrix.Norms.Operator in
  have key : ∀ C : Matrix (Fin N) (Fin N) ℂ,
      HasDerivAt (fun t : ℝ => NormedSpace.exp ((t : ℂ) • C)) C 0 := by
    intro C
    have h0 := hasDerivAt_exp_smul_const (𝕂 := ℝ) C (0 : ℝ)
    have e : (fun t : ℝ => NormedSpace.exp ((t : ℂ) • C)) =
        fun t : ℝ => NormedSpace.exp (t • C) := by
      funext t
      congr 1
    rw [e]
    simp only [zero_smul, NormedSpace.exp_zero, one_mul] at h0
    exact h0
  open scoped Matrix.Norms.Operator in
  have h1 := key A
  open scoped Matrix.Norms.Operator in
  have h1' : HasDerivAt (fun t : ℝ => NormedSpace.exp ((t : ℂ) • B)) A 0 := by
    convert h1 using 1
    funext t
    exact (h t).symm
  open scoped Matrix.Norms.Operator in
  exact h1'.unique (key B)

/-- **The Lie algebra of `SU(N)`** is the space of traceless skew-Hermitian matrices. -/
theorem suGauge_lieAlgebra (N : ℕ) :
    (suGauge N).lieAlgebra =
      {X : Matrix (Fin N) (Fin N) ℂ | X.conjTranspose = -X ∧ X.trace = 0} := by
  ext X
  simp only [GaugeGroup.lieAlgebra, Set.mem_ofPred_eq]
  constructor
  · intro h
    have hmem : ∀ t : ℝ,
        NormedSpace.exp ((t : ℂ) • X) ∈ Matrix.specialUnitaryGroup (Fin N) ℂ := by
      intro t
      obtain ⟨g, hg⟩ := h t
      rw [← hg]
      exact g.2
    -- unitarity for all `t` gives `exp (t Xᴴ) = exp (t (-X))`, differentiate at `0`
    have hfun : (fun t : ℝ => NormedSpace.exp ((t : ℂ) • X.conjTranspose)) =
        fun t : ℝ => NormedSpace.exp ((t : ℂ) • (-X)) := by
      funext t
      have hu : star (NormedSpace.exp ((t : ℂ) • X)) * NormedSpace.exp ((t : ℂ) • X) = 1 :=
        (Matrix.mem_unitaryGroup_iff').mp
          ((Matrix.mem_specialUnitaryGroup_iff.mp (hmem t)).1)
      rw [Matrix.star_eq_conjTranspose, ← Matrix.exp_conjTranspose,
        conjTranspose_ofReal_smul] at hu
      rw [smul_neg, Matrix.exp_neg, Matrix.inv_eq_left_inv hu]
    have hskew : X.conjTranspose = -X :=
      eq_of_exp_ofReal_smul_eq fun t => congrFun hfun t
    refine ⟨hskew, ?_⟩
    -- `exp (t tr X) = det exp (t X) = 1` for all real `t`, differentiate at `0`
    have hexp : (fun t : ℝ => Complex.exp ((t : ℂ) * X.trace)) = fun _ => 1 := by
      funext t
      have hd := (Matrix.mem_specialUnitaryGroup_iff.mp (hmem t)).2
      rw [det_exp_of_skew (skew_ofReal_smul hskew t), Matrix.trace_smul, smul_eq_mul] at hd
      exact hd
    have h1 : HasDerivAt (fun t : ℝ => Complex.exp ((t : ℂ) * X.trace)) X.trace 0 := by
      have h := (((hasDerivAt_id ((0 : ℝ) : ℂ)).mul_const X.trace).cexp).comp_ofReal
      simpa using h
    rw [hexp] at h1
    exact h1.unique (hasDerivAt_const (0 : ℝ) (1 : ℂ))
  · rintro ⟨hskew, htr⟩ t
    have hY := skew_ofReal_smul hskew t
    refine ⟨⟨NormedSpace.exp ((t : ℂ) • X), ?_⟩, rfl⟩
    rw [Matrix.mem_specialUnitaryGroup_iff, Matrix.mem_unitaryGroup_iff']
    refine ⟨star_exp_mul_exp_of_skew hY, ?_⟩
    rw [det_exp_of_skew hY, Matrix.trace_smul, htr, smul_zero, Complex.exp_zero]

end YangMills

#print axioms YangMills.suGauge_lieAlgebra
