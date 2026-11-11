import YangMills

open YangMills Filter Topology
open scoped SchwartzMap

noncomputable section

namespace Scratch2

variable {ι : Type} [Fintype ι] [DecidableEq ι]

/-- Pull back Schwinger functions along a CLM on test functions:
`S'(f₁,…,fₙ) = S(T f₁,…,T fₙ)` (i.e. the fields `φ' = Tᵀ φ`). -/
def pull (T : TestFn ι →L[ℂ] TestFn ι) (S : Schwinger ι) : Schwinger ι :=
  ⟨fun n => (S.S n).compContinuousLinearMap (fun _ => T)⟩

lemma pull_apply (T : TestFn ι →L[ℂ] TestFn ι) (S : Schwinger ι) (n : ℕ)
    (f : Fin n → TestFn ι) : (pull T S).S n f = S.S n (fun k => T (f k)) := rfl

omit [Fintype ι] [DecidableEq ι] in
lemma append_map {X : Type} {m n : ℕ} (u : Fin m → X) (v : Fin n → X) (T : X → X) :
    Fin.append (fun k => T (u k)) (fun k => T (v k)) = fun k => T (Fin.append u v k) := by
  funext k
  refine Fin.addCases (fun i => ?_) (fun i => ?_) k <;> simp

lemma reflectAppend_map (ρ : O4 →* Matrix ι ι ℝ) (T : TestFn ι →L[ℂ] TestFn ι)
    (hT : ∀ f, osReflect ρ (T f) = T (osReflect ρ f)) (A B : Monomial ι) :
    reflectAppend ρ (A.map T) (B.map T) = fun k => T (reflectAppend ρ A B k) := by
  show Fin.append (fun k => osReflect ρ (T (A.f (Fin.rev k)))) (fun k => T (B.f k)) = _
  simp only [hT]
  exact append_map _ _ _

lemma rpForm_pull (ρ : O4 →* Matrix ι ι ℝ) (T : TestFn ι →L[ℂ] TestFn ι)
    (hT : ∀ f, osReflect ρ (T f) = T (osReflect ρ f)) (S : Schwinger ι) (F G : YangMills.Poly ι) :
    rpForm ρ (pull T S) F G = rpForm ρ S (F.map T) (G.map T) := by
  unfold rpForm
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => ?_
  show _ = _ * _ * S.S _ (reflectAppend ρ ((F.m j).map T) ((G.m l).map T))
  rw [reflectAppend_map ρ T hT]
  rfl

lemma one_map (T : TestFn ι → TestFn ι) : (Poly.one : YangMills.Poly ι).map T = Poly.one := by
  show (⟨1, fun _ => 1, fun _ => ⟨0, fun k => T (Fin.elim0 k)⟩⟩ : YangMills.Poly ι) =
    ⟨1, fun _ => 1, fun _ => ⟨0, Fin.elim0⟩⟩
  have : (fun k : Fin 0 => T (Fin.elim0 k)) = Fin.elim0 := funext fun k => k.elim0
  rw [this]

lemma rpFormT_pull (ρ : O4 →* Matrix ι ι ℝ) (T : TestFn ι →L[ℂ] TestFn ι)
    (hT : ∀ f, osReflect ρ (T f) = T (osReflect ρ f)) (S : Schwinger ι) (F G : YangMills.Poly ι) :
    rpFormT ρ (pull T S) F G = rpFormT ρ S (F.map T) (G.map T) := by
  unfold rpFormT
  rw [rpForm_pull ρ T hT, rpForm_pull ρ T hT, rpForm_pull ρ T hT, one_map]

lemma tsupport_map_subset (T : (ι → ℂ) →L[ℂ] (ι → ℂ)) (f : TestFn ι) :
    tsupport (SchwartzMap.postcompCLM T f : E4 → ι → ℂ) ⊆ tsupport (f : E4 → ι → ℂ) :=
  tsupport_comp_subset (map_zero T) f

/-- **The mass gap passes to any pointwise-projected theory.** If `M` commutes with the OS
reflection and with translations (true for any real matrix commuting with `ρ(θ)`), then a mass
gap for `S` gives the same mass gap for the theory whose fields are `Mᵀ φ`. -/
theorem hasMassGap_pull (ρ : O4 →* Matrix ι ι ℝ) (M : Matrix ι ι ℝ)
    (hT : ∀ f, osReflect ρ (SchwartzMap.postcompCLM (matCLM M) f) =
      SchwartzMap.postcompCLM (matCLM M) (osReflect ρ f))
    (S : Schwinger ι) (m : ℝ) (h : HasMassGap ρ S m) :
    HasMassGap ρ (pull (SchwartzMap.postcompCLM (matCLM M)) S) m := by
  set T := SchwartzMap.postcompCLM (E := E4) (𝕜 := ℂ) (matCLM M) with hTdef
  refine ⟨h.1, fun F G hF hG t ht => ?_⟩
  have hFT : (F.map T).OrderedPositive := fun j => by
    obtain ⟨τ, h0, hmono, hsupp⟩ := hF j
    exact ⟨τ, h0, hmono, fun k x hx => hsupp k x (tsupport_map_subset _ _ hx)⟩
  have hGT : (G.map T).OrderedPositive := fun j => by
    obtain ⟨τ, h0, hmono, hsupp⟩ := hG j
    exact ⟨τ, h0, hmono, fun k x hx => hsupp k x (tsupport_map_subset _ _ hx)⟩
  have hcomm : (G.map (YangMills.translate (t • e0))).map T =
      (G.map T).map (YangMills.translate (t • e0)) := by
    have hc : ∀ f : TestFn ι, T (YangMills.translate (t • e0) f) =
        YangMills.translate (t • e0) (T f) := fun f => by
      ext x i
      simp [hTdef, YangMills.translate]
    show (⟨G.N, G.c, fun j => ⟨(G.m j).n, fun k =>
        T (YangMills.translate (t • e0) ((G.m j).f k))⟩⟩ : YangMills.Poly ι) =
      ⟨G.N, G.c, fun j => ⟨(G.m j).n, fun k => YangMills.translate (t • e0) (T ((G.m j).f k))⟩⟩
    simp only [hc]
  rw [rpFormT_pull ρ T hT, rpFormT_pull ρ T hT, rpFormT_pull ρ T hT, hcomm]
  exact h.2 _ _ hFT hGT t ht

end Scratch2
