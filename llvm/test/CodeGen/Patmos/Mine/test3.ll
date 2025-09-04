; ModuleID = '/home/devcontainers/t-crest/tacle-bench/bench/test/test3/test3.c'
source_filename = "/home/devcontainers/t-crest/tacle-bench/bench/test/test3/test3.c"
target datalayout = "E-S32-p:32:32:32-i8:8:8-i16:16:16-i32:32:32-i64:32:32-f64:32:32-a0:0:32-s0:32:32-v64:32:32-v128:32:32-n32"
target triple = "patmos-unknown-unknown-elf"

@test3_seed = dso_local global i32 0, align 4
@test3_array1 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_array2 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_array3 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_array4 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_array5 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_array6 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_array7 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_array8 = dso_local global [32 x [32 x i32]] zeroinitializer, align 4
@test3_result = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_initSeed() #0 {
entry:
  store volatile i32 0, i32* @test3_seed, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local i32 @test3_randomInteger() #0 {
entry:
  %0 = load volatile i32, i32* @test3_seed, align 4
  %mul = mul nsw i32 %0, 133
  %add = add nsw i32 %mul, 81
  %rem = srem i32 %add, 8095
  store volatile i32 %rem, i32* @test3_seed, align 4
  %1 = load volatile i32, i32* @test3_seed, align 4
  ret i32 %1
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_init() #0 {
entry:
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc5, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp, label %for.body, label %for.end7

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %call = call i32 @test3_randomInteger()
  %2 = load i32, i32* %i, align 4
  %arrayidx = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 %2
  %3 = load i32, i32* %j, align 4
  %arrayidx4 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx, i32 0, i32 %3
  store i32 %call, i32* %arrayidx4, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %4 = load i32, i32* %j, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1, !llvm.loop !2

for.end:                                          ; preds = %for.cond1
  br label %for.inc5

for.inc5:                                         ; preds = %for.end
  %5 = load i32, i32* %i, align 4
  %inc6 = add nsw i32 %5, 1
  store i32 %inc6, i32* %i, align 4
  br label %for.cond, !llvm.loop !4

for.end7:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc20, %for.end7
  %6 = load i32, i32* %i, align 4
  %cmp9 = icmp slt i32 %6, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp9, label %for.body10, label %for.end22

for.body10:                                       ; preds = %for.cond8
  store i32 0, i32* %j, align 4
  br label %for.cond11

for.cond11:                                       ; preds = %for.inc17, %for.body10
  %7 = load i32, i32* %j, align 4
  %cmp12 = icmp slt i32 %7, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp12, label %for.body13, label %for.end19

for.body13:                                       ; preds = %for.cond11
  %call14 = call i32 @test3_randomInteger()
  %8 = load i32, i32* %i, align 4
  %arrayidx15 = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 %8
  %9 = load i32, i32* %j, align 4
  %arrayidx16 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx15, i32 0, i32 %9
  store i32 %call14, i32* %arrayidx16, align 4
  br label %for.inc17

for.inc17:                                        ; preds = %for.body13
  %10 = load i32, i32* %j, align 4
  %inc18 = add nsw i32 %10, 1
  store i32 %inc18, i32* %j, align 4
  br label %for.cond11, !llvm.loop !5

for.end19:                                        ; preds = %for.cond11
  br label %for.inc20

for.inc20:                                        ; preds = %for.end19
  %11 = load i32, i32* %i, align 4
  %inc21 = add nsw i32 %11, 1
  store i32 %inc21, i32* %i, align 4
  br label %for.cond8, !llvm.loop !6

for.end22:                                        ; preds = %for.cond8
  store i32 0, i32* %i, align 4
  br label %for.cond23

for.cond23:                                       ; preds = %for.inc35, %for.end22
  %12 = load i32, i32* %i, align 4
  %cmp24 = icmp slt i32 %12, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp24, label %for.body25, label %for.end37

for.body25:                                       ; preds = %for.cond23
  store i32 0, i32* %j, align 4
  br label %for.cond26

for.cond26:                                       ; preds = %for.inc32, %for.body25
  %13 = load i32, i32* %j, align 4
  %cmp27 = icmp slt i32 %13, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp27, label %for.body28, label %for.end34

for.body28:                                       ; preds = %for.cond26
  %call29 = call i32 @test3_randomInteger()
  %14 = load i32, i32* %i, align 4
  %arrayidx30 = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 %14
  %15 = load i32, i32* %j, align 4
  %arrayidx31 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx30, i32 0, i32 %15
  store i32 %call29, i32* %arrayidx31, align 4
  br label %for.inc32

for.inc32:                                        ; preds = %for.body28
  %16 = load i32, i32* %j, align 4
  %inc33 = add nsw i32 %16, 1
  store i32 %inc33, i32* %j, align 4
  br label %for.cond26, !llvm.loop !7

for.end34:                                        ; preds = %for.cond26
  br label %for.inc35

for.inc35:                                        ; preds = %for.end34
  %17 = load i32, i32* %i, align 4
  %inc36 = add nsw i32 %17, 1
  store i32 %inc36, i32* %i, align 4
  br label %for.cond23, !llvm.loop !8

for.end37:                                        ; preds = %for.cond23
  store i32 0, i32* %i, align 4
  br label %for.cond38

for.cond38:                                       ; preds = %for.inc50, %for.end37
  %18 = load i32, i32* %i, align 4
  %cmp39 = icmp slt i32 %18, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp39, label %for.body40, label %for.end52

for.body40:                                       ; preds = %for.cond38
  store i32 0, i32* %j, align 4
  br label %for.cond41

for.cond41:                                       ; preds = %for.inc47, %for.body40
  %19 = load i32, i32* %j, align 4
  %cmp42 = icmp slt i32 %19, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp42, label %for.body43, label %for.end49

for.body43:                                       ; preds = %for.cond41
  %call44 = call i32 @test3_randomInteger()
  %20 = load i32, i32* %i, align 4
  %arrayidx45 = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 %20
  %21 = load i32, i32* %j, align 4
  %arrayidx46 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx45, i32 0, i32 %21
  store i32 %call44, i32* %arrayidx46, align 4
  br label %for.inc47

for.inc47:                                        ; preds = %for.body43
  %22 = load i32, i32* %j, align 4
  %inc48 = add nsw i32 %22, 1
  store i32 %inc48, i32* %j, align 4
  br label %for.cond41, !llvm.loop !9

for.end49:                                        ; preds = %for.cond41
  br label %for.inc50

for.inc50:                                        ; preds = %for.end49
  %23 = load i32, i32* %i, align 4
  %inc51 = add nsw i32 %23, 1
  store i32 %inc51, i32* %i, align 4
  br label %for.cond38, !llvm.loop !10

for.end52:                                        ; preds = %for.cond38
  store i32 0, i32* %i, align 4
  br label %for.cond53

for.cond53:                                       ; preds = %for.inc65, %for.end52
  %24 = load i32, i32* %i, align 4
  %cmp54 = icmp slt i32 %24, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp54, label %for.body55, label %for.end67

for.body55:                                       ; preds = %for.cond53
  store i32 0, i32* %j, align 4
  br label %for.cond56

for.cond56:                                       ; preds = %for.inc62, %for.body55
  %25 = load i32, i32* %j, align 4
  %cmp57 = icmp slt i32 %25, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp57, label %for.body58, label %for.end64

for.body58:                                       ; preds = %for.cond56
  %call59 = call i32 @test3_randomInteger()
  %26 = load i32, i32* %i, align 4
  %arrayidx60 = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 %26
  %27 = load i32, i32* %j, align 4
  %arrayidx61 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx60, i32 0, i32 %27
  store i32 %call59, i32* %arrayidx61, align 4
  br label %for.inc62

for.inc62:                                        ; preds = %for.body58
  %28 = load i32, i32* %j, align 4
  %inc63 = add nsw i32 %28, 1
  store i32 %inc63, i32* %j, align 4
  br label %for.cond56, !llvm.loop !11

for.end64:                                        ; preds = %for.cond56
  br label %for.inc65

for.inc65:                                        ; preds = %for.end64
  %29 = load i32, i32* %i, align 4
  %inc66 = add nsw i32 %29, 1
  store i32 %inc66, i32* %i, align 4
  br label %for.cond53, !llvm.loop !12

for.end67:                                        ; preds = %for.cond53
  store i32 0, i32* %i, align 4
  br label %for.cond68

for.cond68:                                       ; preds = %for.inc80, %for.end67
  %30 = load i32, i32* %i, align 4
  %cmp69 = icmp slt i32 %30, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp69, label %for.body70, label %for.end82

for.body70:                                       ; preds = %for.cond68
  store i32 0, i32* %j, align 4
  br label %for.cond71

for.cond71:                                       ; preds = %for.inc77, %for.body70
  %31 = load i32, i32* %j, align 4
  %cmp72 = icmp slt i32 %31, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp72, label %for.body73, label %for.end79

for.body73:                                       ; preds = %for.cond71
  %call74 = call i32 @test3_randomInteger()
  %32 = load i32, i32* %i, align 4
  %arrayidx75 = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 %32
  %33 = load i32, i32* %j, align 4
  %arrayidx76 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx75, i32 0, i32 %33
  store i32 %call74, i32* %arrayidx76, align 4
  br label %for.inc77

for.inc77:                                        ; preds = %for.body73
  %34 = load i32, i32* %j, align 4
  %inc78 = add nsw i32 %34, 1
  store i32 %inc78, i32* %j, align 4
  br label %for.cond71, !llvm.loop !13

for.end79:                                        ; preds = %for.cond71
  br label %for.inc80

for.inc80:                                        ; preds = %for.end79
  %35 = load i32, i32* %i, align 4
  %inc81 = add nsw i32 %35, 1
  store i32 %inc81, i32* %i, align 4
  br label %for.cond68, !llvm.loop !14

for.end82:                                        ; preds = %for.cond68
  store i32 0, i32* %i, align 4
  br label %for.cond83

for.cond83:                                       ; preds = %for.inc95, %for.end82
  %36 = load i32, i32* %i, align 4
  %cmp84 = icmp slt i32 %36, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp84, label %for.body85, label %for.end97

for.body85:                                       ; preds = %for.cond83
  store i32 0, i32* %j, align 4
  br label %for.cond86

for.cond86:                                       ; preds = %for.inc92, %for.body85
  %37 = load i32, i32* %j, align 4
  %cmp87 = icmp slt i32 %37, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp87, label %for.body88, label %for.end94

for.body88:                                       ; preds = %for.cond86
  %call89 = call i32 @test3_randomInteger()
  %38 = load i32, i32* %i, align 4
  %arrayidx90 = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 %38
  %39 = load i32, i32* %j, align 4
  %arrayidx91 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx90, i32 0, i32 %39
  store i32 %call89, i32* %arrayidx91, align 4
  br label %for.inc92

for.inc92:                                        ; preds = %for.body88
  %40 = load i32, i32* %j, align 4
  %inc93 = add nsw i32 %40, 1
  store i32 %inc93, i32* %j, align 4
  br label %for.cond86, !llvm.loop !15

for.end94:                                        ; preds = %for.cond86
  br label %for.inc95

for.inc95:                                        ; preds = %for.end94
  %41 = load i32, i32* %i, align 4
  %inc96 = add nsw i32 %41, 1
  store i32 %inc96, i32* %i, align 4
  br label %for.cond83, !llvm.loop !16

for.end97:                                        ; preds = %for.cond83
  store i32 0, i32* %i, align 4
  br label %for.cond98

for.cond98:                                       ; preds = %for.inc110, %for.end97
  %42 = load i32, i32* %i, align 4
  %cmp99 = icmp slt i32 %42, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp99, label %for.body100, label %for.end112

for.body100:                                      ; preds = %for.cond98
  store i32 0, i32* %j, align 4
  br label %for.cond101

for.cond101:                                      ; preds = %for.inc107, %for.body100
  %43 = load i32, i32* %j, align 4
  %cmp102 = icmp slt i32 %43, 32
  call void @llvm.loop.bound(i32 32, i32 0)
  br i1 %cmp102, label %for.body103, label %for.end109

for.body103:                                      ; preds = %for.cond101
  %call104 = call i32 @test3_randomInteger()
  %44 = load i32, i32* %i, align 4
  %arrayidx105 = getelementptr inbounds [32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 %44
  %45 = load i32, i32* %j, align 4
  %arrayidx106 = getelementptr inbounds [32 x i32], [32 x i32]* %arrayidx105, i32 0, i32 %45
  store i32 %call104, i32* %arrayidx106, align 4
  br label %for.inc107

for.inc107:                                       ; preds = %for.body103
  %46 = load i32, i32* %j, align 4
  %inc108 = add nsw i32 %46, 1
  store i32 %inc108, i32* %j, align 4
  br label %for.cond101, !llvm.loop !17

for.end109:                                       ; preds = %for.cond101
  br label %for.inc110

for.inc110:                                       ; preds = %for.end109
  %47 = load i32, i32* %i, align 4
  %inc111 = add nsw i32 %47, 1
  store i32 %inc111, i32* %i, align 4
  br label %for.cond98, !llvm.loop !18

for.end112:                                       ; preds = %for.cond98
  store i32 0, i32* @test3_result, align 4
  ret void
}

; Function Attrs: convergent noduplicate noinline nomerge norecurse optnone
declare void @llvm.loop.bound(i32, i32) #1

; Function Attrs: noinline nounwind optnone
define dso_local i32 @test3_return() #0 {
entry:
  %0 = load i32, i32* @test3_result, align 4
  ret i32 %0
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 10, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !19

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 9, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !20

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 8, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !21

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 7, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !22

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 6, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !23

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 5, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !24

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 4, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !25

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 3, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !26

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 2, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !27

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 1, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !28

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_10() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 0, i32 10), i32** %p, align 4
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !29

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_10()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 10, i32 9), i32** %p, align 4
  call void @test3_func_10_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !30

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 9, i32 9), i32** %p, align 4
  call void @test3_func_9_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !31

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 8, i32 9), i32** %p, align 4
  call void @test3_func_8_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !32

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 7, i32 9), i32** %p, align 4
  call void @test3_func_7_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !33

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 6, i32 9), i32** %p, align 4
  call void @test3_func_6_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !34

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 5, i32 9), i32** %p, align 4
  call void @test3_func_5_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !35

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 4, i32 9), i32** %p, align 4
  call void @test3_func_4_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !36

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 3, i32 9), i32** %p, align 4
  call void @test3_func_3_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !37

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 2, i32 9), i32** %p, align 4
  call void @test3_func_2_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !38

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 1, i32 9), i32** %p, align 4
  call void @test3_func_1_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !39

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_9() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 0, i32 9), i32** %p, align 4
  call void @test3_func_0_10()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !40

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_9()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 10, i32 8), i32** %p, align 4
  call void @test3_func_10_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !41

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 9, i32 8), i32** %p, align 4
  call void @test3_func_9_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !42

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 8, i32 8), i32** %p, align 4
  call void @test3_func_8_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !43

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 7, i32 8), i32** %p, align 4
  call void @test3_func_7_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !44

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 6, i32 8), i32** %p, align 4
  call void @test3_func_6_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !45

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 5, i32 8), i32** %p, align 4
  call void @test3_func_5_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !46

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 4, i32 8), i32** %p, align 4
  call void @test3_func_4_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !47

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 3, i32 8), i32** %p, align 4
  call void @test3_func_3_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !48

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 2, i32 8), i32** %p, align 4
  call void @test3_func_2_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !49

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 1, i32 8), i32** %p, align 4
  call void @test3_func_1_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !50

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_8() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 0, i32 8), i32** %p, align 4
  call void @test3_func_0_9()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !51

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_8()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 10, i32 7), i32** %p, align 4
  call void @test3_func_10_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !52

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 9, i32 7), i32** %p, align 4
  call void @test3_func_9_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !53

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 8, i32 7), i32** %p, align 4
  call void @test3_func_8_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !54

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 7, i32 7), i32** %p, align 4
  call void @test3_func_7_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !55

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 6, i32 7), i32** %p, align 4
  call void @test3_func_6_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !56

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 5, i32 7), i32** %p, align 4
  call void @test3_func_5_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !57

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 4, i32 7), i32** %p, align 4
  call void @test3_func_4_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !58

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 3, i32 7), i32** %p, align 4
  call void @test3_func_3_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !59

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 2, i32 7), i32** %p, align 4
  call void @test3_func_2_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !60

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 1, i32 7), i32** %p, align 4
  call void @test3_func_1_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !61

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_7() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 0, i32 7), i32** %p, align 4
  call void @test3_func_0_8()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !62

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_7()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 10, i32 6), i32** %p, align 4
  call void @test3_func_10_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !63

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 9, i32 6), i32** %p, align 4
  call void @test3_func_9_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !64

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 8, i32 6), i32** %p, align 4
  call void @test3_func_8_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !65

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 7, i32 6), i32** %p, align 4
  call void @test3_func_7_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !66

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 6, i32 6), i32** %p, align 4
  call void @test3_func_6_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !67

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 5, i32 6), i32** %p, align 4
  call void @test3_func_5_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !68

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 4, i32 6), i32** %p, align 4
  call void @test3_func_4_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !69

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 3, i32 6), i32** %p, align 4
  call void @test3_func_3_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !70

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 2, i32 6), i32** %p, align 4
  call void @test3_func_2_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !71

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 1, i32 6), i32** %p, align 4
  call void @test3_func_1_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !72

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_6() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 0, i32 6), i32** %p, align 4
  call void @test3_func_0_7()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !73

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_6()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 10, i32 5), i32** %p, align 4
  call void @test3_func_10_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !74

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 9, i32 5), i32** %p, align 4
  call void @test3_func_9_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !75

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 8, i32 5), i32** %p, align 4
  call void @test3_func_8_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !76

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 7, i32 5), i32** %p, align 4
  call void @test3_func_7_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !77

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 6, i32 5), i32** %p, align 4
  call void @test3_func_6_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !78

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 5, i32 5), i32** %p, align 4
  call void @test3_func_5_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !79

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 4, i32 5), i32** %p, align 4
  call void @test3_func_4_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !80

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 3, i32 5), i32** %p, align 4
  call void @test3_func_3_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !81

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 2, i32 5), i32** %p, align 4
  call void @test3_func_2_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !82

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 1, i32 5), i32** %p, align 4
  call void @test3_func_1_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !83

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_5() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 0, i32 5), i32** %p, align 4
  call void @test3_func_0_6()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !84

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_5()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 10, i32 4), i32** %p, align 4
  call void @test3_func_10_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !85

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 9, i32 4), i32** %p, align 4
  call void @test3_func_9_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !86

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 8, i32 4), i32** %p, align 4
  call void @test3_func_8_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !87

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 7, i32 4), i32** %p, align 4
  call void @test3_func_7_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !88

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 6, i32 4), i32** %p, align 4
  call void @test3_func_6_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !89

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 5, i32 4), i32** %p, align 4
  call void @test3_func_5_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !90

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 4, i32 4), i32** %p, align 4
  call void @test3_func_4_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !91

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 3, i32 4), i32** %p, align 4
  call void @test3_func_3_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !92

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 2, i32 4), i32** %p, align 4
  call void @test3_func_2_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !93

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 1, i32 4), i32** %p, align 4
  call void @test3_func_1_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !94

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_4() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 0, i32 4), i32** %p, align 4
  call void @test3_func_0_5()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !95

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_4()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 10, i32 3), i32** %p, align 4
  call void @test3_func_10_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !96

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 9, i32 3), i32** %p, align 4
  call void @test3_func_9_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !97

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 8, i32 3), i32** %p, align 4
  call void @test3_func_8_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !98

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 7, i32 3), i32** %p, align 4
  call void @test3_func_7_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !99

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 6, i32 3), i32** %p, align 4
  call void @test3_func_6_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !100

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 5, i32 3), i32** %p, align 4
  call void @test3_func_5_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !101

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 4, i32 3), i32** %p, align 4
  call void @test3_func_4_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !102

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 3, i32 3), i32** %p, align 4
  call void @test3_func_3_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !103

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 2, i32 3), i32** %p, align 4
  call void @test3_func_2_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !104

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 1, i32 3), i32** %p, align 4
  call void @test3_func_1_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !105

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_3() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 0, i32 3), i32** %p, align 4
  call void @test3_func_0_4()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !106

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_3()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 10, i32 2), i32** %p, align 4
  call void @test3_func_10_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !107

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 9, i32 2), i32** %p, align 4
  call void @test3_func_9_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !108

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 8, i32 2), i32** %p, align 4
  call void @test3_func_8_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !109

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 7, i32 2), i32** %p, align 4
  call void @test3_func_7_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !110

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 6, i32 2), i32** %p, align 4
  call void @test3_func_6_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !111

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 5, i32 2), i32** %p, align 4
  call void @test3_func_5_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !112

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 4, i32 2), i32** %p, align 4
  call void @test3_func_4_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !113

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 3, i32 2), i32** %p, align 4
  call void @test3_func_3_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !114

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 2, i32 2), i32** %p, align 4
  call void @test3_func_2_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !115

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 1, i32 2), i32** %p, align 4
  call void @test3_func_1_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !116

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_2() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 0, i32 2), i32** %p, align 4
  call void @test3_func_0_3()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !117

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_2()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 10, i32 1), i32** %p, align 4
  call void @test3_func_10_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !118

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 9, i32 1), i32** %p, align 4
  call void @test3_func_9_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !119

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 8, i32 1), i32** %p, align 4
  call void @test3_func_8_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !120

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 7, i32 1), i32** %p, align 4
  call void @test3_func_7_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !121

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 6, i32 1), i32** %p, align 4
  call void @test3_func_6_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !122

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 5, i32 1), i32** %p, align 4
  call void @test3_func_5_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !123

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 4, i32 1), i32** %p, align 4
  call void @test3_func_4_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !124

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 3, i32 1), i32** %p, align 4
  call void @test3_func_3_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !125

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 2, i32 1), i32** %p, align 4
  call void @test3_func_2_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !126

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 1, i32 1), i32** %p, align 4
  call void @test3_func_1_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !127

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_1() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 0, i32 1), i32** %p, align 4
  call void @test3_func_0_2()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !128

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_1()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_10_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 10, i32 0), i32** %p, align 4
  call void @test3_func_10_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !129

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_9_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 9, i32 0), i32** %p, align 4
  call void @test3_func_9_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !130

for.end:                                          ; preds = %for.cond
  call void @test3_func_10_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_8_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 8, i32 0), i32** %p, align 4
  call void @test3_func_8_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !131

for.end:                                          ; preds = %for.cond
  call void @test3_func_9_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_7_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array8, i32 0, i32 7, i32 0), i32** %p, align 4
  call void @test3_func_7_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !132

for.end:                                          ; preds = %for.cond
  call void @test3_func_8_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_6_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array7, i32 0, i32 6, i32 0), i32** %p, align 4
  call void @test3_func_6_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !133

for.end:                                          ; preds = %for.cond
  call void @test3_func_7_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_5_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array6, i32 0, i32 5, i32 0), i32** %p, align 4
  call void @test3_func_5_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !134

for.end:                                          ; preds = %for.cond
  call void @test3_func_6_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_4_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array5, i32 0, i32 4, i32 0), i32** %p, align 4
  call void @test3_func_4_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !135

for.end:                                          ; preds = %for.cond
  call void @test3_func_5_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_3_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array4, i32 0, i32 3, i32 0), i32** %p, align 4
  call void @test3_func_3_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !136

for.end:                                          ; preds = %for.cond
  call void @test3_func_4_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_2_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array3, i32 0, i32 2, i32 0), i32** %p, align 4
  call void @test3_func_2_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !137

for.end:                                          ; preds = %for.cond
  call void @test3_func_3_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_1_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array2, i32 0, i32 1, i32 0), i32** %p, align 4
  call void @test3_func_1_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !138

for.end:                                          ; preds = %for.cond
  call void @test3_func_2_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_func_0_0() #0 {
entry:
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %p = alloca i32*, align 4
  store i32* getelementptr inbounds ([32 x [32 x i32]], [32 x [32 x i32]]* @test3_array1, i32 0, i32 0, i32 0), i32** %p, align 4
  call void @test3_func_0_1()
  store i32 0, i32* %i, align 4
  store i32 8, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 4
  call void @llvm.loop.bound(i32 4, i32 0)
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %p, align 4
  %2 = load i32, i32* %1, align 4
  %3 = load i32, i32* @test3_result, align 4
  %add = add nsw i32 %3, %2
  store i32 %add, i32* @test3_result, align 4
  %4 = load i32, i32* %x, align 4
  %5 = load i32*, i32** %p, align 4
  %add.ptr = getelementptr inbounds i32, i32* %5, i32 %4
  store i32* %add.ptr, i32** %p, align 4
  %6 = load i32*, i32** %p, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load i32, i32* @test3_result, align 4
  %add1 = add nsw i32 %8, %7
  store i32 %add1, i32* @test3_result, align 4
  %9 = load i32, i32* %x, align 4
  %10 = load i32*, i32** %p, align 4
  %add.ptr2 = getelementptr inbounds i32, i32* %10, i32 %9
  store i32* %add.ptr2, i32** %p, align 4
  %11 = load i32*, i32** %p, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32, i32* @test3_result, align 4
  %add3 = add nsw i32 %13, %12
  store i32 %add3, i32* @test3_result, align 4
  %14 = load i32, i32* %x, align 4
  %15 = load i32*, i32** %p, align 4
  %add.ptr4 = getelementptr inbounds i32, i32* %15, i32 %14
  store i32* %add.ptr4, i32** %p, align 4
  %16 = load i32*, i32** %p, align 4
  %17 = load i32, i32* %16, align 4
  %18 = load i32, i32* @test3_result, align 4
  %add5 = add nsw i32 %18, %17
  store i32 %add5, i32* @test3_result, align 4
  %19 = load i32, i32* %x, align 4
  %20 = load i32*, i32** %p, align 4
  %add.ptr6 = getelementptr inbounds i32, i32* %20, i32 %19
  store i32* %add.ptr6, i32** %p, align 4
  %21 = load i32*, i32** %p, align 4
  %22 = load i32, i32* %21, align 4
  %23 = load i32, i32* @test3_result, align 4
  %add7 = add nsw i32 %23, %22
  store i32 %add7, i32* @test3_result, align 4
  %24 = load i32, i32* %x, align 4
  %25 = load i32*, i32** %p, align 4
  %add.ptr8 = getelementptr inbounds i32, i32* %25, i32 %24
  store i32* %add.ptr8, i32** %p, align 4
  %26 = load i32*, i32** %p, align 4
  %27 = load i32, i32* %26, align 4
  %28 = load i32, i32* @test3_result, align 4
  %add9 = add nsw i32 %28, %27
  store i32 %add9, i32* @test3_result, align 4
  %29 = load i32, i32* %x, align 4
  %30 = load i32*, i32** %p, align 4
  %add.ptr10 = getelementptr inbounds i32, i32* %30, i32 %29
  store i32* %add.ptr10, i32** %p, align 4
  %31 = load i32*, i32** %p, align 4
  %32 = load i32, i32* %31, align 4
  %33 = load i32, i32* @test3_result, align 4
  %add11 = add nsw i32 %33, %32
  store i32 %add11, i32* @test3_result, align 4
  %34 = load i32, i32* %x, align 4
  %35 = load i32*, i32** %p, align 4
  %add.ptr12 = getelementptr inbounds i32, i32* %35, i32 %34
  store i32* %add.ptr12, i32** %p, align 4
  %36 = load i32*, i32** %p, align 4
  %37 = load i32, i32* %36, align 4
  %38 = load i32, i32* @test3_result, align 4
  %add13 = add nsw i32 %38, %37
  store i32 %add13, i32* @test3_result, align 4
  %39 = load i32, i32* %x, align 4
  %40 = load i32*, i32** %p, align 4
  %add.ptr14 = getelementptr inbounds i32, i32* %40, i32 %39
  store i32* %add.ptr14, i32** %p, align 4
  %41 = load i32*, i32** %p, align 4
  %42 = load i32, i32* %41, align 4
  %43 = load i32, i32* @test3_result, align 4
  %add15 = add nsw i32 %43, %42
  store i32 %add15, i32* @test3_result, align 4
  %44 = load i32, i32* %x, align 4
  %45 = load i32*, i32** %p, align 4
  %add.ptr16 = getelementptr inbounds i32, i32* %45, i32 %44
  store i32* %add.ptr16, i32** %p, align 4
  %46 = load i32*, i32** %p, align 4
  %47 = load i32, i32* %46, align 4
  %48 = load i32, i32* @test3_result, align 4
  %add17 = add nsw i32 %48, %47
  store i32 %add17, i32* @test3_result, align 4
  %49 = load i32, i32* %x, align 4
  %50 = load i32*, i32** %p, align 4
  %add.ptr18 = getelementptr inbounds i32, i32* %50, i32 %49
  store i32* %add.ptr18, i32** %p, align 4
  %51 = load i32*, i32** %p, align 4
  %52 = load i32, i32* %51, align 4
  %53 = load i32, i32* @test3_result, align 4
  %add19 = add nsw i32 %53, %52
  store i32 %add19, i32* @test3_result, align 4
  %54 = load i32, i32* %x, align 4
  %55 = load i32*, i32** %p, align 4
  %add.ptr20 = getelementptr inbounds i32, i32* %55, i32 %54
  store i32* %add.ptr20, i32** %p, align 4
  %56 = load i32*, i32** %p, align 4
  %57 = load i32, i32* %56, align 4
  %58 = load i32, i32* @test3_result, align 4
  %add21 = add nsw i32 %58, %57
  store i32 %add21, i32* @test3_result, align 4
  %59 = load i32, i32* %x, align 4
  %60 = load i32*, i32** %p, align 4
  %add.ptr22 = getelementptr inbounds i32, i32* %60, i32 %59
  store i32* %add.ptr22, i32** %p, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %61 = load i32, i32* %i, align 4
  %inc = add nsw i32 %61, 1
  store i32 %inc, i32* %i, align 4
  %62 = load i32, i32* %x, align 4
  %shr = ashr i32 %62, 1
  store i32 %shr, i32* %x, align 4
  br label %for.cond, !llvm.loop !139

for.end:                                          ; preds = %for.cond
  call void @test3_func_1_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @test3_main() #0 {
entry:
  call void @test3_func_0_0()
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @test3_init()
  call void @test3_main()
  %call = call i32 @test3_return()
  %sub = sub nsw i32 %call, 1377313800
  %cmp = icmp ne i32 %sub, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

attributes #0 = { noinline nounwind optnone "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent noduplicate noinline nomerge norecurse optnone }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.1"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
!5 = distinct !{!5, !3}
!6 = distinct !{!6, !3}
!7 = distinct !{!7, !3}
!8 = distinct !{!8, !3}
!9 = distinct !{!9, !3}
!10 = distinct !{!10, !3}
!11 = distinct !{!11, !3}
!12 = distinct !{!12, !3}
!13 = distinct !{!13, !3}
!14 = distinct !{!14, !3}
!15 = distinct !{!15, !3}
!16 = distinct !{!16, !3}
!17 = distinct !{!17, !3}
!18 = distinct !{!18, !3}
!19 = distinct !{!19, !3}
!20 = distinct !{!20, !3}
!21 = distinct !{!21, !3}
!22 = distinct !{!22, !3}
!23 = distinct !{!23, !3}
!24 = distinct !{!24, !3}
!25 = distinct !{!25, !3}
!26 = distinct !{!26, !3}
!27 = distinct !{!27, !3}
!28 = distinct !{!28, !3}
!29 = distinct !{!29, !3}
!30 = distinct !{!30, !3}
!31 = distinct !{!31, !3}
!32 = distinct !{!32, !3}
!33 = distinct !{!33, !3}
!34 = distinct !{!34, !3}
!35 = distinct !{!35, !3}
!36 = distinct !{!36, !3}
!37 = distinct !{!37, !3}
!38 = distinct !{!38, !3}
!39 = distinct !{!39, !3}
!40 = distinct !{!40, !3}
!41 = distinct !{!41, !3}
!42 = distinct !{!42, !3}
!43 = distinct !{!43, !3}
!44 = distinct !{!44, !3}
!45 = distinct !{!45, !3}
!46 = distinct !{!46, !3}
!47 = distinct !{!47, !3}
!48 = distinct !{!48, !3}
!49 = distinct !{!49, !3}
!50 = distinct !{!50, !3}
!51 = distinct !{!51, !3}
!52 = distinct !{!52, !3}
!53 = distinct !{!53, !3}
!54 = distinct !{!54, !3}
!55 = distinct !{!55, !3}
!56 = distinct !{!56, !3}
!57 = distinct !{!57, !3}
!58 = distinct !{!58, !3}
!59 = distinct !{!59, !3}
!60 = distinct !{!60, !3}
!61 = distinct !{!61, !3}
!62 = distinct !{!62, !3}
!63 = distinct !{!63, !3}
!64 = distinct !{!64, !3}
!65 = distinct !{!65, !3}
!66 = distinct !{!66, !3}
!67 = distinct !{!67, !3}
!68 = distinct !{!68, !3}
!69 = distinct !{!69, !3}
!70 = distinct !{!70, !3}
!71 = distinct !{!71, !3}
!72 = distinct !{!72, !3}
!73 = distinct !{!73, !3}
!74 = distinct !{!74, !3}
!75 = distinct !{!75, !3}
!76 = distinct !{!76, !3}
!77 = distinct !{!77, !3}
!78 = distinct !{!78, !3}
!79 = distinct !{!79, !3}
!80 = distinct !{!80, !3}
!81 = distinct !{!81, !3}
!82 = distinct !{!82, !3}
!83 = distinct !{!83, !3}
!84 = distinct !{!84, !3}
!85 = distinct !{!85, !3}
!86 = distinct !{!86, !3}
!87 = distinct !{!87, !3}
!88 = distinct !{!88, !3}
!89 = distinct !{!89, !3}
!90 = distinct !{!90, !3}
!91 = distinct !{!91, !3}
!92 = distinct !{!92, !3}
!93 = distinct !{!93, !3}
!94 = distinct !{!94, !3}
!95 = distinct !{!95, !3}
!96 = distinct !{!96, !3}
!97 = distinct !{!97, !3}
!98 = distinct !{!98, !3}
!99 = distinct !{!99, !3}
!100 = distinct !{!100, !3}
!101 = distinct !{!101, !3}
!102 = distinct !{!102, !3}
!103 = distinct !{!103, !3}
!104 = distinct !{!104, !3}
!105 = distinct !{!105, !3}
!106 = distinct !{!106, !3}
!107 = distinct !{!107, !3}
!108 = distinct !{!108, !3}
!109 = distinct !{!109, !3}
!110 = distinct !{!110, !3}
!111 = distinct !{!111, !3}
!112 = distinct !{!112, !3}
!113 = distinct !{!113, !3}
!114 = distinct !{!114, !3}
!115 = distinct !{!115, !3}
!116 = distinct !{!116, !3}
!117 = distinct !{!117, !3}
!118 = distinct !{!118, !3}
!119 = distinct !{!119, !3}
!120 = distinct !{!120, !3}
!121 = distinct !{!121, !3}
!122 = distinct !{!122, !3}
!123 = distinct !{!123, !3}
!124 = distinct !{!124, !3}
!125 = distinct !{!125, !3}
!126 = distinct !{!126, !3}
!127 = distinct !{!127, !3}
!128 = distinct !{!128, !3}
!129 = distinct !{!129, !3}
!130 = distinct !{!130, !3}
!131 = distinct !{!131, !3}
!132 = distinct !{!132, !3}
!133 = distinct !{!133, !3}
!134 = distinct !{!134, !3}
!135 = distinct !{!135, !3}
!136 = distinct !{!136, !3}
!137 = distinct !{!137, !3}
!138 = distinct !{!138, !3}
!139 = distinct !{!139, !3}
