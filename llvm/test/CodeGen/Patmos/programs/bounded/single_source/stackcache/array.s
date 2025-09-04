	.text
	.file	"array.ll"
	.globl	main                            # -- Begin function main
	.p2align	4
	.type	main,@function
	.fstart	main, .PPGtmp0-main, 16
main:                                   # @main
# %bb.0:                                # %entry
.LBB0_0:
  	sres    	      	9
  	sws     	      	[8] = $r30      # 4-byte Folded Spill
  	mfs     	      	$r30 = $s0
  	sws     	      	[7] = $r30      # 4-byte Folded Spill
  	sws     	      	[1] = $r3
  	sws     	      	[0] = $r0
  	li      	      	$r1 = __const.main.a
  	lwc     	      	$r2 = [$r1 + 2]
  	sws     	      	[5] = $r0
  	sws     	      	[4] = $r2
  	mov     	      	$r30 = $r31
  	lwc     	      	$r2 = [$r1 + 1]
  	lwc     	      	$r1 = [$r1]
  	br      	      	.LBB0_1
  	sws     	      	[3] = $r2
  	sws     	      	[2] = $r1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
                                        # Loop bound: [1, 4]
  	lws     	      	$r1 = [5]
  	nop     	      	
  	li      	      	$r2 = 2
  	cmpult  	      	$p1 = $r2, $r1
  	brnd    	( $p1)	.LBB0_4
  	brnd    	      	.LBB0_2
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
  	lws     	      	$r1 = [5]
  	nop     	      	
  	mul     	      	$r1, $r1
  	nop     	      	
  	mfs     	      	$r1 = $s2
  	sws     	      	[6] = $r1
  	lws     	      	$r1 = [5]
  	add     	      	$r2 = $r0, 8
  	shadd2  	      	$r1 = $r1, $r2
  	lws     	      	$r1 = [$r1]
  	lws     	      	$r2 = [6]
  	nop     	      	
  	add     	      	$r1 = $r1, $r2
  	lws     	      	$r2 = [1]
  	br      	      	.LBB0_3
  	add     	      	$r1 = $r2, $r1
  	sws     	      	[1] = $r1
.LBB0_3:                                # %for.inc
                                        #   in Loop: Header=BB0_1 Depth=1
  	lws     	      	$r1 = [5]
  	br      	      	.LBB0_1
  	add     	      	$r1 = $r1, 1
  	sws     	      	[5] = $r1
.LBB0_4:                                # %for.end
  	lws     	      	$r1 = [1]
  	mov     	      	$r31 = $r30
  	lws     	      	$r30 = [7]
  	nop     	      	
  	mts     	      	$s0 = $r30
  	ret     	      	
  	lws     	      	$r30 = [8]
  	nop     	      	
  	sfree   	      	9
.PPGtmp0:
.PPGfunc_end0:
	.size	main, .PPGfunc_end0-main
                                        # -- End function
	.type	__const.main.a,@object          # @__const.main.a
	.section	.rodata,"a",@progbits
	.p2align	2
__const.main.a:
	.word	1                               # 0x1
	.word	2                               # 0x2
	.word	3                               # 0x3
	.size	__const.main.a, 12

	.section	".note.GNU-stack","",@progbits
