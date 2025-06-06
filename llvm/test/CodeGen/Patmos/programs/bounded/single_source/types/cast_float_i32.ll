; RUN: EXEC_ARGS="1=4 2=5 3=6 100=103"; \
; RUN: %test_execution
; END.
;//////////////////////////////////////////////////////////////////////////////////////////////////
;
; Tests casting float to i32
;
; We provide a custom implementation of the casting functions, to ensure it is called when trying
; to cast.
; 
;//////////////////////////////////////////////////////////////////////////////////////////////////

@d = dso_local global float 1.000000e+00
@i = dso_local global i32 3

; This is the function that should be used instead of the 'fptoui' instruction.
define i32 @__fixunssfsi(float %d) {
  %1 = load volatile i32, i32* @i
  ret i32 %1
}

; This ensures the single-path code generator knows to also convert this function
; to single-path
@llvm.used = appending global [1 x i8*] [i8* bitcast (i32 (float)* @__fixunssfsi to i8*)], section "llvm.metadata"

define i32 @main(i32 %x) {
entry:
  %0 = load volatile float, float* @d
  %1 = fptoui float %0 to i32
  %2 = add nsw i32 %x, %1
  ret i32 %2
}

