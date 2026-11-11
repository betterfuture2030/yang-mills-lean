import YangMills
open YangMills
open scoped SchwartzMap
noncomputable section
namespace VerifyGap1

/-- The 21-dimensional space of components compatible with the symmetries of `tr F_{μν}F_{κλ}`. -/
def TPhys : Set (ι4 → ℝ) :=
  {v | ∀ μ ν κ l : Fin 4,
    v (((μ,ν),κ),l) = -v (((ν,μ),κ),l) ∧ v (((μ,ν),κ),l) = -v (((μ,ν),l),κ) ∧
    v (((μ,ν),κ),l) = v (((κ,l),μ),ν)}

def vecTest (v : ι4 → ℝ) (h : 𝓢(E4, ℂ)) : TestFn ι4 :=
  SchwartzMap.postcompCLM ((ContinuousLinearMap.id ℂ ℂ).smulRight (fun i => (v i : ℂ))) h

lemma vecTest_apply (v : ι4 → ℝ) (h : 𝓢(E4, ℂ)) (x : E4) (i : ι4) :
    vecTest v h x i = h x * (v i : ℂ) := by
  simp [vecTest]

def FullFieldContent (S : Schwinger ι4) : Prop :=
  ∀ v ∈ TPhys, v ≠ 0 → ∃ h₁ h₂ : 𝓢(E4, ℂ), Disjoint (tsupport h₁) (tsupport h₂) ∧
    S.S 2 ![vecTest v h₁, vecTest v h₂] ≠ 0

/-- The scalar direction e_{μνκλ} = δ_{μκ}δ_{νλ} - δ_{μλ}δ_{νκ}. -/
def eScalar : ι4 → ℝ := fun i =>
  (if i.1.1.1 = i.1.2 ∧ i.1.1.2 = i.2 then 1 else 0) -
  (if i.1.1.1 = i.2 ∧ i.1.1.2 = i.1.2 then 1 else 0)

lemma eScalar_mem : eScalar ∈ TPhys := by
  intro μ ν κ l
  refine ⟨?_, ?_, ?_⟩ <;> simp only [eScalar] <;>
    by_cases h1 : μ = κ <;> by_cases h2 : ν = l <;> by_cases h3 : μ = l <;>
    by_cases h4 : ν = κ <;> simp_all [eq_comm] <;> aesop

end VerifyGap1
