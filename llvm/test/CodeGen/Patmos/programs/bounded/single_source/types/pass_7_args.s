	.text
	.file	"pass_7_args.ll"
	.globl	helper                          # -- Begin function helper
	.p2align	4
	.type	helper,@function
	.fstart	helper, .PPGtmp0-helper, 16
helper:                                 # @helper
# %bb.0:
.LBB0_0:
  	sres    	      	6
  	sws     	      	[0] = $r3
  	sws     	      	[1] = $r4
  	sws     	      	[2] = $r5
  	sws     	      	[3] = $r6
  	sws     	      	[4] = $r7
  	sws     	      	[5] = $r8
  	lwc     	      	$r1 = [$r31]
  	add     	      	$r2 = $r0, 0
  	shadd2  	      	$r1 = $r1, $r2
  	ret     	      	
  	lws     	      	$r1 = [$r1]
  	nop     	      	
  	sfree   	      	6
.PPGtmp0:
.PPGfunc_end0:
	.size	helper, .PPGfunc_end0-helper
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4
	.type	main,@function
	.fstart	main, .PPGtmp1-main, 16
main:                                   # @main
# %bb.0:
.LBB1_0:
  	sres    	      	2
  	mfs     	      	$r16 = $s7
  	sws     	      	[0] = $r16      # 4-byte Folded Spill
  	mfs     	      	$r17 = $s8
  	sws     	      	[1] = $r17      # 4-byte Folded Spill
  	sub     	      	$r31 = $r31, 4
  	swc     	      	[$r31] = $r3
  	li      	      	$r5 = 22
  	li      	      	$r6 = 23
  	li      	      	$r7 = 24
  	li      	      	$r8 = 25
  	call    	      	helper
  	li      	      	$r4 = 21
  	li      	      	$r3 = 20
  	nop     	      	
  	sens    	      	2
  	lws     	      	$r16 = [0]
  	nop     	      	
  	mts     	      	$s7 = $r16
  	lws     	      	$r17 = [1]
  	nop     	      	
  	mts     	      	$s8 = $r17
  	nop     	      	
  	ret     	      	
  	nop     	      	
  	add     	      	$r31 = $r31, 4
  	sfree   	      	2
.PPGtmp1:
.PPGfunc_end1:
	.size	main, .PPGfunc_end1-main
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
