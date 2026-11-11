import YangMills

/-! Junk-value lens (scratch, not part of the library): the cluster axiom at `a = 0`. -/

open Filter Topology

namespace YangMills.JL

open YangMills

variable {ι : Type} [Fintype ι] [DecidableEq ι] (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)

omit [DecidableEq ι] in
lemma translate_zero : (translate (0 : E4) : TestFn ι →L[ℂ] TestFn ι) = ContinuousLinearMap.id _ _ := by
  unfold translate; exact SchwartzMap.compSubConstCLM_zero

/-- The cluster axiom at the spatial vector `a = 0` forces exact factorization. -/
theorem cluster_factorizes (h : OS.Cluster ρ S) (A B : Monomial ι)
    (hA : A.OrderedPositive) (hB : B.OrderedPositive) :
    S.S _ (reflectAppend ρ A B) =
      S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f := by
  have h0 := h A B hA hB 0 rfl
  have hB0 : ∀ lam : ℝ, B.map (translate (lam • (0 : E4))) = B := by
    intro lam
    rw [smul_zero, translate_zero]
    rfl
  have hc : ∀ lam : ℝ, S.S _ (reflectAppend ρ A (B.map (translate (lam • (0 : E4))))) =
      S.S _ (reflectAppend ρ A B) := by
    intro lam; rw [hB0 lam]
  exact tendsto_nhds_unique (tendsto_const_nhds.congr fun lam => (hc lam).symm) h0

omit [DecidableEq ι] in
lemma empty_orderedPositive : (⟨0, Fin.elim0⟩ : Monomial ι).OrderedPositive :=
  ⟨fun _ => 0, rfl,
    fun i j h => absurd h (by rw [Subsingleton.elim (α := Fin 1) i j]; exact lt_irrefl _),
    fun k => k.elim0⟩

omit [DecidableEq ι] in
lemma S0_eq_one (hN : OS.Normalized S) (g : Fin 0 → TestFn ι) : S.S 0 g = 1 := by
  have : g = Fin.elim0 := funext fun k => k.elim0
  rw [this]; exact hN

/-- Under the OS axioms as formalized, the truncated reflection-positivity form vanishes
identically on positive-time polynomials: the OS Hilbert space is spanned by the vacuum. -/
theorem rpFormT_eq_zero (hN : OS.Normalized S) (hC : OS.Cluster ρ S) (F G : Poly ι)
    (hF : F.OrderedPositive) (hG : G.OrderedPositive) : rpFormT ρ S F G = 0 := by
  set X : Fin F.N → ℂ := fun j => S.S _ (fun k => osReflect ρ ((F.m j).f (Fin.rev k)))
  set Y : Fin G.N → ℂ := fun l => S.S _ (G.m l).f
  have h1 : rpForm ρ S F G = ∑ j, ∑ l, (starRingEnd ℂ) (F.c j) * G.c l * (X j * Y l) := by
    unfold rpForm
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
    rw [cluster_factorizes ρ S hC (F.m j) (G.m l) (hF j) (hG l)]
  have h2 : rpForm ρ S F Poly.one = ∑ j, (starRingEnd ℂ) (F.c j) * X j := by
    unfold rpForm
    refine Finset.sum_congr rfl fun j _ => ?_
    have fac1 : S.S ((F.m j).n + 0) (reflectAppend ρ (F.m j) ⟨0, Fin.elim0⟩) =
        X j * S.S 0 Fin.elim0 :=
      cluster_factorizes ρ S hC (F.m j) ⟨0, Fin.elim0⟩ (hF j) empty_orderedPositive
    show ∑ l : Fin 1, (starRingEnd ℂ) (F.c j) * 1 *
      S.S ((F.m j).n + 0) (reflectAppend ρ (F.m j) ⟨0, Fin.elim0⟩) = _
    rw [Fin.sum_univ_one, fac1, S0_eq_one S hN]; ring
  have h3 : rpForm ρ S Poly.one G = ∑ l, G.c l * Y l := by
    unfold rpForm
    have fac2 : ∀ l, S.S (0 + (G.m l).n) (reflectAppend ρ ⟨0, Fin.elim0⟩ (G.m l)) =
        S.S 0 (fun k => osReflect ρ ((⟨0, Fin.elim0⟩ : Monomial ι).f (Fin.rev k))) * Y l :=
      fun l => cluster_factorizes ρ S hC ⟨0, Fin.elim0⟩ (G.m l) empty_orderedPositive (hG l)
    show ∑ j : Fin 1, ∑ l, (starRingEnd ℂ) 1 * G.c l *
      S.S (0 + (G.m l).n) (reflectAppend ρ ⟨0, Fin.elim0⟩ (G.m l)) = _
    rw [Fin.sum_univ_one]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [fac2 l, S0_eq_one S hN]; simp
  unfold rpFormT
  rw [h1, h2, h3, Finset.sum_mul_sum, sub_eq_zero]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
  ring

omit [DecidableEq ι] in
lemma orderedPositive_translate (A : Monomial ι) (hA : A.OrderedPositive) (s : ℝ) (hs : 0 ≤ s) :
    (A.map (translate (s • e0))).OrderedPositive := by
  obtain ⟨t, h0, hmono, hsupp⟩ := hA
  refine ⟨fun k => if k = 0 then 0 else t k + s, by simp, ?_, ?_⟩
  · intro i j hij
    have hj : j ≠ 0 := by rintro rfl; exact absurd hij (Fin.not_lt_zero _)
    by_cases hi : i = 0
    · simp only [hi, hj, ite_true, ite_false]
      have := hmono (show (0 : Fin (A.n + 1)) < j from Fin.pos_iff_ne_zero.mpr hj)
      rw [h0] at this; linarith
    · simp only [hi, hj, ite_false]; linarith [hmono hij]
  · intro (k : Fin A.n) x hx
    have hx' : x - s • e0 ∈ tsupport (A.f k : E4 → ι → ℂ) := by
      have hsub := tsupport_comp_subset_preimage (A.f k : E4 → ι → ℂ)
        (f := fun y : E4 => y - s • e0) (by fun_prop)
      exact hsub hx
    have he : (x - s • e0) 0 = x 0 - s := by simp [e0]
    obtain ⟨h1, h2⟩ := hsupp k _ hx'
    rw [he] at h1 h2
    have hsucc : k.succ ≠ 0 := Fin.succ_ne_zero k
    show (if k.castSucc = 0 then (0:ℝ) else t k.castSucc + s) < x 0 ∧
      x 0 < (if k.succ = 0 then (0:ℝ) else t k.succ + s)
    rw [if_neg hsucc]
    refine ⟨?_, by linarith⟩
    by_cases hc : k.castSucc = 0
    · rw [if_pos hc]; rw [hc, h0] at h1; linarith
    · rw [if_neg hc]; linarith

/-- **The mass-gap clause is implied by the OS axioms as formalized**: every `S` satisfying
`OS.Normalized` and `OS.Cluster` has a "mass gap" of every size `m > 0`. -/
theorem massGap_of_osAxioms (h : OSAxioms ρ S) (m : ℝ) (hm : 0 < m) : HasMassGap ρ S m := by
  refine ⟨hm, fun F G hF hG t ht => ?_⟩
  have hG' : (G.map (translate (t • e0))).OrderedPositive :=
    fun j => orderedPositive_translate (G.m j) (hG j) t ht
  rw [rpFormT_eq_zero ρ S h.normalized h.cluster F _ hF hG', norm_zero]
  positivity

/-- Consequently `ExistsWithMassGap P ↔ ∃ S, IsYangMillsTheory P S`: the gap clause is idle. -/
theorem existsWithMassGap_iff {d : ℕ} {G : Type} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (P : GaugeGroup d G) : ExistsWithMassGap P ↔ ∃ S, IsYangMillsTheory P S := by
  constructor
  · rintro ⟨S, hS, -⟩; exact ⟨S, hS⟩
  · rintro ⟨S, hS⟩
    obtain ⟨a, β, hOS, -, -⟩ := id hS
    exact ⟨S, hS, 1, massGap_of_osAxioms tensorRep S hOS 1 one_pos⟩

/-- Positive-time single-field monomial. -/
def single (f : TestFn ι) : Monomial ι := ⟨1, ![f]⟩

/-- With centred fields (clause 1 of `NonTrivial`), the two-point function between any
negative-time reflected field and any positive-time field vanishes. -/
theorem twoPoint_reflected_zero (h : OSAxioms ρ S) (hcent : ∀ f : Fin 1 → TestFn ι, S.S 1 f = 0)
    (f g : TestFn ι) (hf : (single f).OrderedPositive) (hg : (single g).OrderedPositive) :
    S.S _ (reflectAppend ρ (single f) (single g)) = 0 := by
  rw [cluster_factorizes ρ S h.cluster _ _ hf hg]
  have : S.S 1 (single g).f = 0 := hcent _
  exact mul_eq_zero_of_right _ this

end YangMills.JL

#print axioms YangMills.JL.massGap_of_osAxioms
#print axioms YangMills.JL.existsWithMassGap_iff
#print axioms YangMills.JL.twoPoint_reflected_zero
