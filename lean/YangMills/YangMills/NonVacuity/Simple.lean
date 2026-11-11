import YangMills.SU

/-!
# Simplicity of `su(N)` (`N ≥ 2`) as a real Lie algebra
-/

open Matrix

namespace YangMills

namespace SUSimple

variable {N : ℕ}

/-- `su(N)` as a set of matrices. -/
def su (N : ℕ) : Set (Matrix (Fin N) (Fin N) ℂ) :=
  {X | X.conjTranspose = -X ∧ X.trace = 0}

/-- `Z a b w = w E_ab - conj(w) E_ba`. -/
def Z (a b : Fin N) (w : ℂ) : Matrix (Fin N) (Fin N) ℂ :=
  single a b w - single b a (star w)

/-- `D a b = i (E_aa - E_bb)`. -/
def D (a b : Fin N) : Matrix (Fin N) (Fin N) ℂ :=
  single a a Complex.I - single b b Complex.I

/-- The diagonal skew-Hermitian matrix `diag(i φ_j)`. -/
def Hd (φ : Fin N → ℝ) : Matrix (Fin N) (Fin N) ℂ :=
  diagonal (fun j => (φ j : ℂ) * Complex.I)

lemma Z_mem {a b : Fin N} (h : a ≠ b) (w : ℂ) : Z a b w ∈ su N := by
  refine ⟨?_, ?_⟩
  · simp [Z, conjTranspose_sub, conjTranspose_single]
  · simp [Z, trace_sub, h, Ne.symm h]

lemma Hd_skew (φ : Fin N → ℝ) : (Hd φ)ᴴ = -Hd φ := by
  ext i j
  simp only [Hd, conjTranspose_apply, diagonal_apply, Matrix.neg_apply]
  by_cases h : i = j
  · subst h; simp
  · simp [h, Ne.symm h]

lemma Hd_bracket_apply (φ : Fin N → ℝ) (Y : Matrix (Fin N) (Fin N) ℂ) (j k : Fin N) :
    (Hd φ * Y - Y * Hd φ) j k = ((φ j : ℂ) - (φ k : ℂ)) * Complex.I * Y j k := by
  simp only [Hd, Matrix.sub_apply, diagonal_mul, mul_diagonal]
  ring


section Ideal

variable (I : Submodule ℝ (Matrix (Fin N) (Fin N) ℂ))

/-- An ideal of `su(N)` is also stable under bracket with any skew-Hermitian matrix
(the scalar part commutes). -/
lemma bracket_mem_of_skew (hN : N ≠ 0)
    (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I)
    {H : Matrix (Fin N) (Fin N) ℂ} (hH : Hᴴ = -H) {Y : Matrix (Fin N) (Fin N) ℂ}
    (hY : Y ∈ I) : H * Y - Y * H ∈ I := by
  set c : ℂ := H.trace / (N : ℂ) with hc_def
  have hNc : (N : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hN
  have htr : star H.trace = -H.trace := by
    rw [← trace_conjTranspose, hH, trace_neg]
  have hc : star c = -c := by
    rw [hc_def, star_div₀, htr, star_natCast, neg_div]
  have hmem : H - c • (1 : Matrix (Fin N) (Fin N) ℂ) ∈ su N := by
    refine ⟨?_, ?_⟩
    · rw [conjTranspose_sub, conjTranspose_smul, conjTranspose_one, hH, hc, neg_smul]
      abel
    · rw [trace_sub, trace_smul, trace_one, Fintype.card_fin, hc_def, smul_eq_mul]
      field_simp
      ring
  have h := hI _ hmem Y hY
  have e : (H - c • (1 : Matrix (Fin N) (Fin N) ℂ)) * Y - Y * (H - c • 1) = H * Y - Y * H := by
    rw [sub_mul, mul_sub, smul_mul_assoc, one_mul, mul_smul_comm, mul_one]
    abel
  rwa [e] at h

lemma Z_add (a b : Fin N) (u v : ℂ) : Z a b (u + v) = Z a b u + Z a b v := by
  ext j k
  simp only [Z, Matrix.add_apply, Matrix.sub_apply, single_apply, star_add]
  split_ifs <;> ring

lemma Z_real_mul (a b : Fin N) (r : ℝ) (u : ℂ) : Z a b ((r : ℂ) * u) = r • Z a b u := by
  ext j k
  simp only [Z, Matrix.smul_apply, Matrix.sub_apply, single_apply, star_mul',
    Complex.star_def, Complex.conj_ofReal, Complex.real_smul]
  split_ifs <;> ring

lemma Z_swap (a b : Fin N) (w : ℂ) : Z b a w = Z a b (-star w) := by
  ext j k
  simp only [Z, Matrix.sub_apply, single_apply, star_neg, star_star]
  split_ifs <;> ring

lemma Z_bracket (a b c : Fin N) (hab : a ≠ b) (hca : c ≠ a) (hcb : c ≠ b) (w : ℂ) :
    Z b c 1 * Z a b w - Z a b w * Z b c 1 = -Z a c w := by
  simp only [Z, mul_sub, sub_mul, single_mul_single_same, single_mul_single_of_ne, ne_eq,
    hca, hcb, hab, Ne.symm hab, Ne.symm hca, Ne.symm hcb, not_false_eq_true,
    one_mul, mul_one, star_one]
  abel

lemma Z_bracket_diag (a b : Fin N) (hab : a ≠ b) :
    Z a b 1 * Z a b Complex.I - Z a b Complex.I * Z a b 1 = (2 : ℝ) • D a b := by
  simp only [Z, D, mul_sub, sub_mul, single_mul_single_same, single_mul_single_of_ne, ne_eq,
    hab, Ne.symm hab, not_false_eq_true, one_mul, mul_one, star_one]
  ext j k
  simp only [Matrix.sub_apply, Matrix.smul_apply,
    single_apply, Complex.star_def, Complex.conj_I, Matrix.zero_apply, Complex.real_smul]
  split_ifs <;> push_cast <;> ring

/-- Step A: extracting an off-diagonal entry of an element of the ideal. -/
lemma extract (hN : N ≠ 0) (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I)
    {Y : Matrix (Fin N) (Fin N) ℂ} (hY : Y ∈ I) (hYsu : Y ∈ su N) {a b : Fin N}
    (hab : a ≠ b) : Z a b (Y a b) ∈ I := by
  have hba : star (Y a b) = -Y b a := by
    have := congrFun (congrFun hYsu.1 b) a
    simpa [conjTranspose_apply] using this
  let φ : Fin N → ℝ := fun j => if j = a then 1 else 0
  let ψ : Fin N → ℝ := fun j => if j = b then 1 else 0
  have h1 := bracket_mem_of_skew I hN hI (Hd_skew φ) hY
  have h2 := bracket_mem_of_skew I hN hI (Hd_skew ψ) h1
  convert h2 using 1
  ext j k
  rw [Hd_bracket_apply, Hd_bracket_apply]
  simp only [Z, Matrix.sub_apply, single_apply, hba, φ, ψ]
  have hba' := Ne.symm hab
  simp only [@eq_comm _ a j, @eq_comm _ b k, @eq_comm _ b j, @eq_comm _ a k]
  by_cases hja : j = a <;> by_cases hjb : j = b <;> by_cases hka : k = a <;>
    by_cases hkb : k = b
  all_goals first
    | (exact absurd (hja.symm.trans hjb) hab)
    | (exact absurd (hka.symm.trans hkb) hab)
    | (simp [hja, hjb, hka, hkb, hab, hba']; done)
    | (simp [hja, hjb, hka, hkb, hab, hba']; ring_nf; simp [Complex.I_sq])

/-- Step C: multiplying the coefficient by `i`. -/
lemma rotate (hN : N ≠ 0) (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I)
    {a b : Fin N} (hab : a ≠ b) {z : ℂ} (hz : Z a b z ∈ I) :
    Z a b (Complex.I * z) ∈ I := by
  let φ : Fin N → ℝ := fun j => if j = a then 1 else 0
  have h1 := bracket_mem_of_skew I hN hI (Hd_skew φ) hz
  convert h1 using 1
  ext j k
  rw [Hd_bracket_apply]
  simp only [Z, Matrix.sub_apply, single_apply, φ, star_mul', Complex.star_def, Complex.conj_I]
  have hba' := Ne.symm hab
  simp only [@eq_comm _ a j, @eq_comm _ b k, @eq_comm _ b j, @eq_comm _ a k]
  by_cases hja : j = a <;> by_cases hjb : j = b <;> by_cases hka : k = a <;>
    by_cases hkb : k = b
  all_goals first
    | (exact absurd (hja.symm.trans hjb) hab)
    | (exact absurd (hka.symm.trans hkb) hab)
    | simp [hja, hjb, hka, hkb, hab, hba']

lemma all_w (hN : N ≠ 0) (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I)
    {a b : Fin N} (hab : a ≠ b) {z : ℂ} (hz0 : z ≠ 0) (hz : Z a b z ∈ I) (w : ℂ) :
    Z a b w ∈ I := by
  have hIz := rotate I hN hI hab hz
  set q := w / z with hq
  have hw : w = ((q.re : ℂ) * z) + ((q.im : ℂ) * (Complex.I * z)) := by
    have h1 : w = q * z := by rw [hq, div_mul_cancel₀ w hz0]
    calc w = q * z := h1
      _ = ((q.re : ℂ) + q.im * Complex.I) * z := by rw [Complex.re_add_im]
      _ = _ := by ring
  rw [hw, Z_add, Z_real_mul, Z_real_mul]
  exact I.add_mem (I.smul_mem _ hz) (I.smul_mem _ hIz)

lemma prop_swap {a b : Fin N} (hR : ∀ w, Z a b w ∈ I) : ∀ w, Z b a w ∈ I := fun w => by
  rw [Z_swap]; exact hR _

lemma prop_third (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I)
    {a b c : Fin N} (hab : a ≠ b) (hca : c ≠ a) (hcb : c ≠ b)
    (hR : ∀ w, Z a b w ∈ I) : ∀ w, Z a c w ∈ I := by
  intro w
  have h := hI _ (Z_mem (Ne.symm hcb) 1) _ (hR w)
  rw [Z_bracket a b c hab hca hcb w] at h
  simpa using I.neg_mem h

lemma prop_row (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I)
    {a b : Fin N} (hab : a ≠ b) (hR : ∀ w, Z a b w ∈ I) :
    ∀ x, x ≠ a → ∀ w, Z a x w ∈ I := by
  intro x hxa
  by_cases hxb : x = b
  · subst hxb; exact hR
  · exact prop_third I hI hab hxa hxb hR

lemma prop_all (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I)
    {a b : Fin N} (hab : a ≠ b) (hR : ∀ w, Z a b w ∈ I) :
    ∀ c d : Fin N, c ≠ d → ∀ w, Z c d w ∈ I := by
  intro c d hcd
  by_cases hca : c = a
  · subst hca; exact prop_row I hI hab hR d (Ne.symm hcd)
  · have h1 := prop_row I hI hab hR c hca
    have h2 := prop_swap I h1
    exact prop_row I hI hca h2 d (Ne.symm hcd)

/-- Step B: a nonzero ideal contains an element with a nonzero off-diagonal entry. -/
lemma exists_offdiag (hIsub : (I : Set (Matrix (Fin N) (Fin N) ℂ)) ⊆ su N)
    (hI : ∀ X ∈ su N, ∀ Y ∈ I, X * Y - Y * X ∈ I) (hN : N ≠ 0) (hne : I ≠ ⊥) :
    ∃ Y ∈ I, ∃ a b : Fin N, a ≠ b ∧ Y a b ≠ 0 := by
  by_contra hcon
  simp only [not_exists, not_and, not_not] at hcon
  obtain ⟨Y, hY, hY0⟩ := (Submodule.ne_bot_iff I).mp hne
  apply hY0
  have hdiag : ∀ a b : Fin N, Y a a = Y b b := by
    intro a b
    by_cases hab : a = b
    · rw [hab]
    · have h1 := hI _ (Z_mem hab 1) Y hY
      have h2 := hcon _ h1 a b hab
      have e : (Z a b 1 * Y - Y * Z a b 1) a b = Y b b - Y a a := by
        simp [Z, sub_mul, mul_sub, Ne.symm hab, hab]
      rw [e] at h2
      exact (sub_eq_zero.mp h2).symm
  obtain ⟨o⟩ : Nonempty (Fin N) := ⟨⟨0, Nat.pos_of_ne_zero hN⟩⟩
  have htr : Y.trace = 0 := (hIsub hY).2
  have hoo : Y o o = 0 := by
    have : Y.trace = (N : ℂ) * Y o o := by
      simp only [Matrix.trace, diag_apply]
      rw [Finset.sum_congr rfl (fun i _ => hdiag i o)]
      simp
    rw [this] at htr
    exact (mul_eq_zero.mp htr).resolve_left (Nat.cast_ne_zero.mpr hN)
  ext j k
  by_cases hjk : j = k
  · subst hjk; rw [hdiag j o, hoo]; rfl
  · exact hcon Y hY j k hjk

/-- Spanning: an ℝ-subspace containing every `Z c d w` (`c ≠ d`) and every `D c d` (`c ≠ d`)
contains `su(N)`. -/
lemma span_mem (o : Fin N) (hZ : ∀ c d : Fin N, c ≠ d → ∀ w, Z c d w ∈ I)
    (hD : ∀ c d : Fin N, c ≠ d → D c d ∈ I) {X : Matrix (Fin N) (Fin N) ℂ} (hX : X ∈ su N) :
    X ∈ I := by
  have hstar : ∀ i j, star (X i j) = -X j i := by
    intro i j
    have := congrFun (congrFun hX.1 j) i
    simpa [conjTranspose_apply] using this
  -- Step 1: `X = ∑ᵢⱼ ½ Z i j (X i j)`.
  have e1 : X = ∑ i, ∑ j, (1/2 : ℝ) • Z i j (X i j) := by
    have eH : Xᴴ = ∑ i, ∑ j, single j i (star (X i j)) := by
      conv_lhs => rw [matrix_eq_sum_single X]
      simp only [conjTranspose_sum, conjTranspose_single]
    have e0 : X = (1/2 : ℝ) • (X - Xᴴ) := by
      rw [hX.1, sub_neg_eq_add, ← two_smul ℝ X, smul_smul]; norm_num
    calc X = (1/2 : ℝ) • (X - Xᴴ) := e0
      _ = (1/2 : ℝ) • ((∑ i, ∑ j, single i j (X i j)) -
            ∑ i, ∑ j, single j i (star (X i j))) := by
          rw [← matrix_eq_sum_single X, eH]
      _ = ∑ i, ∑ j, (1/2 : ℝ) • Z i j (X i j) := by
          simp only [Z, ← Finset.sum_sub_distrib, Finset.smul_sum]
  set f : Fin N → Fin N → Matrix (Fin N) (Fin N) ℂ :=
    fun i j => (1/2 : ℝ) • Z i j (X i j) with hf
  -- Step 2: split off the diagonal terms.
  have e2 : ∑ i, ∑ j, f i j = (∑ i, ∑ j, if i = j then 0 else f i j) + ∑ i, f i i := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl (fun i _ => ?_)
    have : ∀ j, f i j = (if i = j then 0 else f i j) + (if i = j then f i j else 0) := by
      intro j; split_ifs <;> simp
    rw [Finset.sum_congr rfl (fun j _ => this j), Finset.sum_add_distrib, Finset.sum_ite_eq]
    simp
  -- Step 3: the diagonal part.
  have hre : ∀ i, (X i i).re = 0 := by
    intro i
    have := congrArg Complex.re (hstar i i)
    simp at this
    linarith
  have hx : ∀ i, X i i = ((X i i).im : ℂ) * Complex.I := by
    intro i
    apply Complex.ext <;> simp [hre i]
  have hdiag_pt : ∀ i, f i i = (X i i).im • D i o + (X i i).im • single o o Complex.I := by
    intro i
    ext p q
    simp only [hf, Z, D, Matrix.smul_apply, Matrix.add_apply, Matrix.sub_apply, single_apply,
      hstar, Complex.real_smul]
    push_cast
    split_ifs <;> first | ring1 | linear_combination (hx i)
  have hsum_im : ∑ i, (X i i).im = 0 := by
    have := congrArg Complex.im hX.2
    simpa [Matrix.trace, Complex.im_sum] using this
  have e3 : ∑ i, f i i = ∑ i, (X i i).im • D i o := by
    rw [Finset.sum_congr rfl (fun i _ => hdiag_pt i), Finset.sum_add_distrib, ← Finset.sum_smul,
      hsum_im, zero_smul, add_zero]
  rw [e1, e2, e3]
  refine I.add_mem (I.sum_mem fun i _ => I.sum_mem fun j _ => ?_) (I.sum_mem fun i _ => ?_)
  · split_ifs with hij
    · exact I.zero_mem
    · exact I.smul_mem _ (hZ i j hij _)
  · by_cases hio : i = o
    · subst hio; simp [D]
    · exact I.smul_mem _ (hD i o hio)

end Ideal

theorem su_isSimple' (N : ℕ) (hN : 2 ≤ N) : IsSimpleMatrixLieAlgebra (su N) := by
  have hN0 : N ≠ 0 := by omega
  let o : Fin N := ⟨0, by omega⟩
  let o' : Fin N := ⟨1, by omega⟩
  have hoo' : o ≠ o' := by simp [o, o', Fin.ext_iff]
  refine ⟨⟨Z o o' 1, Z_mem hoo' 1, Z o o' Complex.I, Z_mem hoo' _, ?_⟩, ?_⟩
  · rw [Z_bracket_diag o o' hoo']
    intro h
    have := congrFun (congrFun h o) o
    simp [D, Matrix.smul_apply, Ne.symm hoo'] at this
  · intro I hIsub hI
    by_cases hbot : I = ⊥
    · exact Or.inl hbot
    · right
      apply Set.Subset.antisymm hIsub
      intro X hX
      obtain ⟨Y, hY, a, b, hab, hYab⟩ := exists_offdiag I hIsub hI hN0 hbot
      have h1 := extract I hN0 hI hY (hIsub hY) hab
      have hR := all_w I hN0 hI hab hYab h1
      have hZ := prop_all I hI hab hR
      have hD : ∀ c d : Fin N, c ≠ d → D c d ∈ I := by
        intro c d hcd
        have h := hI _ (Z_mem hcd 1) _ (hZ c d hcd Complex.I)
        rw [Z_bracket_diag c d hcd] at h
        have := I.smul_mem (1/2 : ℝ) h
        rwa [smul_smul, show (1/2 : ℝ) * 2 = 1 by norm_num, one_smul] at this
      exact span_mem I o hZ hD hX

end SUSimple

/-- **`su(N)` is a simple real Lie algebra for `N ≥ 2`.** -/
theorem su_isSimple (N : ℕ) (hN : 2 ≤ N) :
    IsSimpleMatrixLieAlgebra
      {X : Matrix (Fin N) (Fin N) ℂ | X.conjTranspose = -X ∧ X.trace = 0} :=
  SUSimple.su_isSimple' N hN

end YangMills

