import YangMills
open YangMills
#check @SchwartzMap.integralCLM
-- osReflect is an involution (needed to transport the reflected-pair vanishing to all time-separated pairs)
example : timeReflection * timeReflection = (1 : O4) := by
  ext x; simp [timeReflection]
