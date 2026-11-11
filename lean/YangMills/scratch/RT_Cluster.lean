import YangMills

open Filter Topology

namespace YangMills

variable {ι : Type} [Fintype ι] [DecidableEq ι]
set_option linter.unusedSectionVars false

lemma translate_zero (f : TestFn ι) : translate (0 : E4) f = f := by
  ext x i
  simp [translate]

lemma Monomial.map_translate_zero (B : Monomial ι) (lam : ℝ) :
    B.map (translate (lam • (0 : E4))) = B := by
  cases B with
  | mk n f =>
    simp only [Monomial.map, smul_zero]
    congr 1
    funext k
    exact translate_zero _

/-- `OS.Cluster` instantiated at the spatial vector `a = 0` (allowed: `a 0 = 0`) forces EXACT
factorization `S(ΘA^* B) = S(ΘA^*) S(B)` for all ordered-positive monomials. -/
theorem cluster_forces_factorization (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)
    (h : OS.Cluster ρ S) (A B : Monomial ι) (hA : A.OrderedPositive)
    (hB : B.OrderedPositive) :
    S.S _ (reflectAppend ρ A B) =
      S.S _ (fun k => osReflect ρ (A.f (Fin.rev k))) * S.S _ B.f := by
  have h0 := h A B hA hB 0 (by simp)
  have hconst : (fun lam : ℝ => S.S _ (reflectAppend ρ A (B.map (translate (lam • (0 : E4))))))
      = fun _ => S.S _ (reflectAppend ρ A B) := by
    funext lam
    rw [Monomial.map_translate_zero]
  rw [hconst] at h0
  exact tendsto_nhds_unique tendsto_const_nhds h0

/-- Consequence: any centred theory satisfying the formal OS axioms has vanishing two-point
function between every reflected pair `(Θ f, g)` with `f, g` supported in a positive-time
slab. -/
theorem twoPoint_reflected_vanishes (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)
    (hOS : OSAxioms ρ S) (hc : ∀ f : Fin 1 → TestFn ι, S.S 1 f = 0)
    (f g : TestFn ι) (hf : (⟨1, ![f]⟩ : Monomial ι).OrderedPositive)
    (hg : (⟨1, ![g]⟩ : Monomial ι).OrderedPositive) :
    S.S 2 (reflectAppend ρ ⟨1, ![f]⟩ ⟨1, ![g]⟩) = 0 := by
  have := cluster_forces_factorization ρ S hOS.cluster _ _ hf hg
  refine this.trans ?_
  simp [hc]

/-- In particular `B(F,F) = 0` for `F = φ(f)`: the reflection-positivity form vanishes on all
one-field states, i.e. `φ(f)Ω = 0` in the OS Hilbert space, for every positive-time `f`. -/
theorem rp_one_field_null (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι)
    (hOS : OSAxioms ρ S) (hc : ∀ f : Fin 1 → TestFn ι, S.S 1 f = 0)
    (f : TestFn ι) (hf : (⟨1, ![f]⟩ : Monomial ι).OrderedPositive) :
    rpForm ρ S ⟨1, fun _ => 1, fun _ => ⟨1, ![f]⟩⟩ ⟨1, fun _ => 1, fun _ => ⟨1, ![f]⟩⟩ = 0 := by
  simp only [rpForm, Finset.univ_unique, Finset.sum_singleton, map_one, one_mul]
  exact twoPoint_reflected_vanishes ρ S hOS hc f f hf hf

/-- The same for the actual Yang–Mills statements. -/
theorem ym_twoPoint_reflected_vanishes {d : ℕ} {G : Type} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [CompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (P : GaugeGroup d G) (S : Schwinger ι4) (h : IsYangMillsTheory P S)
    (f g : TestFn ι4) (hf : (⟨1, ![f]⟩ : Monomial ι4).OrderedPositive)
    (hg : (⟨1, ![g]⟩ : Monomial ι4).OrderedPositive) :
    S.S 2 (reflectAppend tensorRep ⟨1, ![f]⟩ ⟨1, ![g]⟩) = 0 := by
  obtain ⟨a, β, hOS, hNT, -⟩ := h
  exact twoPoint_reflected_vanishes tensorRep S hOS hNT.1 f g hf hg

#print axioms ym_twoPoint_reflected_vanishes

end YangMills

namespace YangMills

variable {ι : Type} [Fintype ι] [DecidableEq ι]
set_option linter.unusedSectionVars false

lemma Monomial.orderedPositive_zero (f : Fin 0 → TestFn ι) :
    (⟨0, f⟩ : Monomial ι).OrderedPositive :=
  ⟨fun _ => 0, rfl, (show StrictMono (fun _ : Fin 1 => (0 : ℝ)) from Subsingleton.strictMono _),
    fun k => k.elim0⟩

/-- Under the formal OS axioms the truncated reflection form vanishes identically: the OS
Hilbert space is spanned by the vacuum. -/
theorem rpFormT_eq_zero (ρ : O4 →* Matrix ι ι ℝ) (S : Schwinger ι) (hOS : OSAxioms ρ S)
    (F G : Poly ι) (hF : F.OrderedPositive) (hG : G.OrderedPositive) :
    rpFormT ρ S F G = 0 := by
  have hfac := cluster_forces_factorization ρ S hOS.cluster
  have h0 : ∀ g : Fin 0 → TestFn ι, S.S 0 g = 1 := by
    intro g
    rw [Subsingleton.elim g Fin.elim0]
    exact hOS.normalized
  set X : Fin F.N → ℂ := fun j => S.S _ (fun k => osReflect ρ ((F.m j).f (Fin.rev k)))
  set Y : Fin G.N → ℂ := fun l => S.S _ (G.m l).f
  have hFG : rpForm ρ S F G =
      ∑ j, ∑ l, (starRingEnd ℂ) (F.c j) * G.c l * (X j * Y l) := by
    unfold rpForm
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
    rw [hfac _ _ (hF j) (hG l)]
  have hF1 : rpForm ρ S F Poly.one = ∑ j, (starRingEnd ℂ) (F.c j) * X j := by
    unfold rpForm
    refine Finset.sum_congr rfl fun j _ => ?_
    have := hfac (F.m j) ⟨0, Fin.elim0⟩ (hF j) (Monomial.orderedPositive_zero _)
    have h' : S.S ((F.m j).n + 0) (reflectAppend ρ (F.m j) ⟨0, Fin.elim0⟩) = X j := by
      refine this.trans ?_
      rw [h0, mul_one]
    show ∑ l : Fin 1, (starRingEnd ℂ) (F.c j) * 1 * S.S ((F.m j).n + 0)
      (reflectAppend ρ (F.m j) ⟨0, Fin.elim0⟩) = _
    rw [Fin.sum_univ_one, h', mul_one]
  have h1G : rpForm ρ S Poly.one G = ∑ l, G.c l * Y l := by
    unfold rpForm
    have h' : ∀ l, S.S (0 + (G.m l).n) (reflectAppend ρ ⟨0, Fin.elim0⟩ (G.m l)) = Y l := by
      intro l
      refine (hfac ⟨0, Fin.elim0⟩ (G.m l) (Monomial.orderedPositive_zero _) (hG l)).trans ?_
      rw [h0, one_mul]
    show ∑ _j : Fin 1, ∑ l, (starRingEnd ℂ) 1 * G.c l * S.S (0 + (G.m l).n)
      (reflectAppend ρ ⟨0, Fin.elim0⟩ (G.m l)) = _
    rw [Fin.sum_univ_one]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [h', map_one, one_mul]
  unfold rpFormT
  rw [hFG, hF1, h1G, Finset.sum_mul_sum, sub_eq_zero]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
  ring

#print axioms rpFormT_eq_zero

end YangMills
