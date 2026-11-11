import YangMills

open Filter Topology

namespace YangMills.ClayLens

variable {ι : Type} [Fintype ι] [DecidableEq ι] (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)

/-- With `a = 0` (allowed by `a 0 = 0`), `OS.Cluster` forces EXACT factorization. -/
theorem cluster_forces_factorization (hC : OS.Cluster ρ S) (A B : Monomial ι)
    (hA : A.OrderedPositive) (hB : B.OrderedPositive) :
    S.S _ (reflectAppend ρ A B) =
      S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f := by
  have h := hC A B hA hB 0 (by simp)
  have key : ∀ lam : ℝ, reflectAppend ρ A (B.map (translate (lam • (0 : E4)))) =
      reflectAppend ρ A B := by
    intro lam
    unfold reflectAppend Monomial.map
    congr 1
    funext k
    ext x i
    simp [translate]
  have hfun : (fun lam : ℝ => S.S _ (reflectAppend ρ A (B.map (translate (lam • (0 : E4)))))) =
      fun _ => S.S (A.n + B.n) (reflectAppend ρ A B) :=
    funext fun lam => congrArg (S.S (A.n + B.n)) (key lam)
  rw [hfun] at h
  exact tendsto_nhds_unique tendsto_const_nhds h

omit [DecidableEq ι] in
lemma empty_orderedPositive : (⟨0, Fin.elim0⟩ : Monomial ι).OrderedPositive := by
  refine ⟨fun _ => 0, rfl, ?_, fun k => k.elim0⟩
  intro i j hij
  exfalso
  have hi := i.isLt
  have hj := j.isLt
  rw [Fin.lt_def] at hij
  dsimp only at hi hj
  omega

/-- The truncated RP form vanishes: the OS Hilbert space of ANY `S` with `OSAxioms` is `ℂΩ`. -/
theorem rpFormT_eq_zero (hS : OSAxioms ρ S) (F G : Poly ι) (hF : F.OrderedPositive)
    (hG : G.OrderedPositive) : rpFormT ρ S F G = 0 := by
  have h0 := empty_orderedPositive (ι := ι)
  have hN : ∀ g : Fin 0 → TestFn ι, S.S 0 g = 1 := by
    intro g
    have : g = Fin.elim0 := Subsingleton.elim _ _
    rw [this]; exact hS.normalized
  have hF1 : rpForm ρ S F Poly.one =
      ∑ j, (starRingEnd ℂ) (F.c j) * S.S _ (fun k => osReflect ρ ((F.m j).f (Fin.rev k))) := by
    unfold rpForm Poly.one
    refine Finset.sum_congr rfl fun j _ => ?_
    simp only [Finset.univ_unique, Finset.sum_singleton, mul_one]
    rw [cluster_forces_factorization ρ S hS.cluster _ _ (hF j) h0, hN, mul_one]
  have h1G : rpForm ρ S Poly.one G = ∑ l, G.c l * S.S _ (G.m l).f := by
    unfold rpForm Poly.one
    simp only [Finset.univ_unique, Finset.sum_singleton, map_one, one_mul]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [cluster_forces_factorization ρ S hS.cluster _ _ h0 (hG l), hN, one_mul]
  unfold rpFormT
  rw [hF1, h1G]
  unfold rpForm
  rw [Finset.sum_mul_sum, sub_eq_zero]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
  rw [cluster_forces_factorization ρ S hS.cluster _ _ (hF j) (hG l)]
  ring

/-- Centred fields: two-point function vanishes on every time-separated pair. -/
theorem twoPoint_timeSeparated_zero (hS : OSAxioms ρ S)
    (hc : ∀ f : Fin 1 → TestFn ι, S.S 1 f = 0) (h g : TestFn ι)
    (hh : (⟨1, ![h]⟩ : Monomial ι).OrderedPositive)
    (hg : (⟨1, ![g]⟩ : Monomial ι).OrderedPositive) :
    S.S 2 ![osReflect ρ h, g] = 0 := by
  have := cluster_forces_factorization ρ S hS.cluster _ _ hh hg
  rw [hc, hc, mul_zero] at this
  have e : reflectAppend ρ ⟨1, ![h]⟩ ⟨1, ![g]⟩ = ![osReflect ρ h, g] := by
    funext k
    fin_cases k <;> rfl
  rw [← e]
  exact this



omit [DecidableEq ι] in
lemma orderedPositive_translate (A : Monomial ι) (hA : A.OrderedPositive) (s : ℝ) (hs : 0 ≤ s) :
    (A.map (translate (s • e0))).OrderedPositive := by
  obtain ⟨t, h0, hmono, hsupp⟩ := hA
  show ∃ t' : Fin (A.n + 1) → ℝ, t' 0 = 0 ∧ StrictMono t' ∧
    ∀ k : Fin A.n, ∀ x ∈ tsupport ((translate (s • e0) (A.f k) : TestFn ι) : E4 → ι → ℂ),
      t' k.castSucc < x 0 ∧ x 0 < t' k.succ
  refine ⟨fun k => if k = 0 then 0 else t k + s, by simp, ?_, ?_⟩
  · intro i j hij
    have hj : j ≠ 0 := by rintro rfl; exact absurd hij (Fin.not_lt_zero _)
    have htj : 0 < t j := by
      have := hmono (show (0 : Fin (A.n + 1)) < j from Fin.pos_iff_ne_zero.mpr hj)
      rwa [h0] at this
    by_cases hi : i = 0
    · simp only [hi, hj, ite_true, ite_false]; linarith
    · simp only [hi, hj, ite_false]; linarith [hmono hij]
  · intro k x hx
    have hx' : x - s • e0 ∈ tsupport (A.f k : E4 → ι → ℂ) := by
      have hsub := tsupport_comp_subset_preimage (A.f k : E4 → ι → ℂ)
        (f := fun y : E4 => y - s • e0) (by fun_prop)
      exact hsub hx
    have he : (x - s • e0) 0 = x 0 - s := by simp [e0]
    obtain ⟨h1, h2⟩ := hsupp k _ hx'
    rw [he] at h1 h2
    have hsucc : k.succ ≠ 0 := Fin.succ_ne_zero k
    simp only [hsucc, ite_false]
    refine ⟨?_, by linarith⟩
    by_cases hc : k.castSucc = 0
    · simp only [hc, ite_true]; rw [hc, h0] at h1; linarith
    · simp only [hc, ite_false]; linarith

/-- The mass-gap clause is implied by `OSAxioms` for every `m > 0`. -/
theorem hasMassGap_of_osAxioms (hS : OSAxioms ρ S) (m : ℝ) (hm : 0 < m) : HasMassGap ρ S m := by
  refine ⟨hm, fun F G hF hG t ht => ?_⟩
  have hG' : (G.map (translate (t • e0))).OrderedPositive :=
    fun j => orderedPositive_translate (G.m j) (hG j) t ht
  rw [rpFormT_eq_zero ρ S hS F _ hF hG', norm_zero]
  positivity

end YangMills.ClayLens

#print axioms YangMills.ClayLens.hasMassGap_of_osAxioms
#print axioms YangMills.ClayLens.twoPoint_timeSeparated_zero
