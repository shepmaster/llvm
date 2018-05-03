; RUN: llc < %s -march=avr | FileCheck %s


%SipHashState = type { [0 x i8], i64, [0 x i8], i64, [0 x i8], i64, [0 x i8], i64, [0 x i8] }
%Formatter = type { [0 x i8], %"PhantomData<&()>", [0 x i8], i32, [0 x i8], i32, [0 x i8], i8, [0 x i8], %"Option<usize>", [0 x i8], %"Option<usize>", [0 x i8] }
%"PhantomData<&()>" = type {}
%"Option<usize>" = type { [0 x i8], i8, [2 x i8] }
%Hasher.Sip13Rounds = type { [0 x i8], %"PhantomData<Sip13Rounds>", [0 x i8], i64, [0 x i8], i64, [0 x i8], i16, [0 x i8], %SipHashState, [0 x i8], i64, [0 x i8], i16, [0 x i8] }
%"PhantomData<Sip13Rounds>" = type {}

declare zeroext i1 @State.Debug.1(%SipHashState* noalias readonly dereferenceable(32), %Formatter* dereferenceable(15)) unnamed_addr

declare void @slice_index_order_fail(i16, i16) unnamed_addr

declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture writeonly, i8* nocapture readonly, i16, i32, i1) #0

; CHECK-LABEL: Hasher.Debug.0
define internal fastcc zeroext i1 @Hasher.Debug.0(%Hasher.Sip13Rounds* noalias readonly dereferenceable(60) %self, %Formatter* dereferenceable(15) %__arg_0) unnamed_addr  {
bb3.i.i2:
  %buf.i.i.i.i = alloca [128 x i8], align 1
  %0 = getelementptr inbounds %Hasher.Sip13Rounds, %Hasher.Sip13Rounds* %self, i16 0, i32 5
  %1 = getelementptr inbounds %Hasher.Sip13Rounds, %Hasher.Sip13Rounds* %self, i16 0, i32 13
  %2 = bitcast %Formatter* %__arg_0 to i32*
  %3 = icmp eq i32 undef, 0
  br i1 undef, label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit6, label %bb32.i.i.i3

bb32.i.i.i3:                                      ; preds = %bb3.i.i2
  br i1 %3, label %bb3.i.i55, label %bb2.i.i

bb2.i.i:                                          ; preds = %bb32.i.i.i3
  %4 = load i64, i64* null, align 1
  br label %bb15.i.i7.i.i

bb15.i.i7.i.i:                                    ; preds = %bb15.i.i7.i.i, %bb2.i.i
  %curr.019.i.i2.i.i = phi i16 [ 128, %bb2.i.i ], [ %10, %bb15.i.i7.i.i ]
  %x.018.i.i3.i.i = phi i64 [ %4, %bb2.i.i ], [ %6, %bb15.i.i7.i.i ]
  %5 = getelementptr inbounds i8, i8* null, i16 -1
  %6 = lshr i64 %x.018.i.i3.i.i, 4
  %7 = trunc i64 %x.018.i.i3.i.i to i8
  %8 = and i8 %7, 15
  %9 = add nuw nsw i8 %8, 87
  %_0.0.i15.i.i5.i.i = select i1 undef, i8 undef, i8 %9
  store i8 %_0.0.i15.i.i5.i.i, i8* %5, align 1
  %10 = add nsw i16 %curr.019.i.i2.i.i, -1
  %11 = icmp eq i8* %5, null
  %or.cond.i.i6.i.i = or i1 undef, %11
  br i1 %or.cond.i.i6.i.i, label %bb40.i.i8.i.i, label %bb15.i.i7.i.i

bb40.i.i8.i.i:                                    ; preds = %bb15.i.i7.i.i
  call void @slice_index_order_fail(i16 %10, i16 128)
  unreachable

bb3.i.i55:                                        ; preds = %bb32.i.i.i3
  %12 = icmp eq i32 undef, 0
  %13 = load i64, i64* null, align 1
  br i1 %12, label %bb7.i.i, label %bb6.i.i

bb6.i.i:                                          ; preds = %bb3.i.i55
  unreachable

bb7.i.i:                                          ; preds = %bb3.i.i55
  br label %bb14.i.i.i

bb14.i.i.i:                                       ; preds = %bb14.i.i.i, %bb7.i.i
  %n.1.i.i.i = phi i64 [ %14, %bb14.i.i.i ], [ %13, %bb7.i.i ]
  %14 = udiv i64 %n.1.i.i.i, 10000
  %.old5.i.i.i = icmp ugt i64 %n.1.i.i.i, 99999999
  br label %bb14.i.i.i

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit6: ; preds = %bb3.i.i2
  br label %bb3.i.i67

bb3.i.i67:                                        ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit6
  br i1 undef, label %bb7.i.i78, label %bb6.i.i68

bb6.i.i68:                                        ; preds = %bb3.i.i67
  unreachable

bb7.i.i78:                                        ; preds = %bb3.i.i67
  br label %bb14.i.i.i82

bb14.i.i.i82:                                     ; preds = %bb14.i.i.i82, %bb7.i.i78
  %n.1.i.i.i80 = phi i64 [ %15, %bb14.i.i.i82 ], [ undef, %bb7.i.i78 ]
  %15 = udiv i64 %n.1.i.i.i80, 10000
  %.old5.i.i.i81 = icmp ugt i64 %n.1.i.i.i80, 99999999
  br i1 %.old5.i.i.i81, label %bb14.i.i.i82, label %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit83"

"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit83": ; preds = %bb14.i.i.i82
  br label %bb3.i.i8

bb3.i.i8:                                         ; preds = %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit83"
  %16 = and i32 undef, 16
  %17 = icmp eq i32 %16, 0
  br i1 undef, label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit12, label %bb32.i.i.i9

bb32.i.i.i9:                                      ; preds = %bb3.i.i8
  br i1 %17, label %bb3.i.i95, label %bb2.i.i85

bb2.i.i85:                                        ; preds = %bb32.i.i.i9
  br label %bb15.i.i7.i.i91

bb15.i.i7.i.i91:                                  ; preds = %bb15.i.i7.i.i91, %bb2.i.i85
  %curr.019.i.i2.i.i86 = phi i16 [ 128, %bb2.i.i85 ], [ %21, %bb15.i.i7.i.i91 ]
  %x.018.i.i3.i.i87 = phi i64 [ undef, %bb2.i.i85 ], [ %19, %bb15.i.i7.i.i91 ]
  %iter.sroa.4.017.i.i4.i.i88 = phi i8* [ undef, %bb2.i.i85 ], [ %18, %bb15.i.i7.i.i91 ]
  %18 = getelementptr inbounds i8, i8* %iter.sroa.4.017.i.i4.i.i88, i16 -1
  %19 = lshr i64 %x.018.i.i3.i.i87, 4
  %20 = trunc i64 %x.018.i.i3.i.i87 to i8
  %21 = add nsw i16 %curr.019.i.i2.i.i86, -1
  %22 = icmp eq i8* %18, null
  %or.cond.i.i6.i.i90 = or i1 undef, %22
  br i1 %or.cond.i.i6.i.i90, label %bb40.i.i8.i.i92, label %bb15.i.i7.i.i91

bb40.i.i8.i.i92:                                  ; preds = %bb15.i.i7.i.i91
  call void @slice_index_order_fail(i16 %21, i16 128)
  unreachable

bb3.i.i95:                                        ; preds = %bb32.i.i.i9
  %23 = load i64, i64* %0, align 1
  br i1 undef, label %bb7.i.i106, label %bb6.i.i96

bb6.i.i96:                                        ; preds = %bb3.i.i95
  unreachable

bb7.i.i106:                                       ; preds = %bb3.i.i95
  %24 = icmp ugt i64 %23, 9999
  br i1 %24, label %bb14.i.i.i110.preheader, label %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit111"

bb14.i.i.i110.preheader:                          ; preds = %bb7.i.i106
  br label %bb14.i.i.i110

bb14.i.i.i110:                                    ; preds = %bb14.i.i.i110, %bb14.i.i.i110.preheader
  %n.1.i.i.i108 = phi i64 [ %25, %bb14.i.i.i110 ], [ %23, %bb14.i.i.i110.preheader ]
  %25 = udiv i64 %n.1.i.i.i108, 10000
  %.old5.i.i.i109 = icmp ugt i64 %n.1.i.i.i108, 99999999
  br label %bb14.i.i.i110

"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit111": ; preds = %bb7.i.i106
  %26 = load i32, i32* %2, align 1
  %27 = icmp eq i32 undef, 0
  br label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit18

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit12: ; preds = %bb3.i.i8
  br i1 %17, label %bb3.i.i123, label %bb2.i.i113

bb2.i.i113:                                       ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit12
  br label %bb15.i.i7.i.i119

bb15.i.i7.i.i119:                                 ; preds = %bb15.i.i7.i.i119, %bb2.i.i113
  %x.018.i.i3.i.i115 = phi i64 [ undef, %bb2.i.i113 ], [ %28, %bb15.i.i7.i.i119 ]
  %28 = lshr i64 %x.018.i.i3.i.i115, 4
  %29 = trunc i64 %x.018.i.i3.i.i115 to i8
  %30 = and i8 %29, 15
  %31 = add nuw nsw i8 %30, 87
  %_0.0.i15.i.i5.i.i117 = select i1 undef, i8 undef, i8 %31
  store i8 %_0.0.i15.i.i5.i.i117, i8* undef, align 1
  %32 = icmp eq i8* undef, null
  %or.cond.i.i6.i.i118 = or i1 undef, %32
  br i1 %or.cond.i.i6.i.i118, label %bb40.i.i8.i.i120, label %bb15.i.i7.i.i119

bb40.i.i8.i.i120:                                 ; preds = %bb15.i.i7.i.i119
  unreachable

bb3.i.i123:                                       ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit12
  %33 = icmp eq i32 undef, 0
  %34 = load i64, i64* %0, align 1
  br i1 %33, label %bb7.i.i134, label %bb6.i.i124

bb6.i.i124:                                       ; preds = %bb3.i.i123
  br label %bb15.i.i.i.i130

bb15.i.i.i.i130:                                  ; preds = %bb15.i.i.i.i130, %bb6.i.i124
  %curr.019.i.i.i.i125 = phi i16 [ 128, %bb6.i.i124 ], [ %37, %bb15.i.i.i.i130 ]
  %x.018.i.i.i.i126 = phi i64 [ %34, %bb6.i.i124 ], [ %36, %bb15.i.i.i.i130 ]
  %35 = getelementptr inbounds i8, i8* null, i16 -1
  %36 = lshr i64 %x.018.i.i.i.i126, 4
  %37 = add nsw i16 %curr.019.i.i.i.i125, -1
  %38 = icmp eq i64 %36, 0
  %39 = icmp eq i8* %35, null
  %or.cond.i.i.i.i129 = or i1 %38, %39
  br i1 %or.cond.i.i.i.i129, label %bb40.i.i.i.i131, label %bb15.i.i.i.i130

bb40.i.i.i.i131:                                  ; preds = %bb15.i.i.i.i130
  call void @slice_index_order_fail(i16 %37, i16 128)
  unreachable

bb7.i.i134:                                       ; preds = %bb3.i.i123
  br label %bb14.i.i.i138

bb14.i.i.i138:                                    ; preds = %bb14.i.i.i138, %bb7.i.i134
  %n.1.i.i.i136 = phi i64 [ %40, %bb14.i.i.i138 ], [ %34, %bb7.i.i134 ]
  %40 = udiv i64 %n.1.i.i.i136, 10000
  %.old5.i.i.i137 = icmp ugt i64 %n.1.i.i.i136, 99999999
  br i1 %.old5.i.i.i137, label %bb14.i.i.i138, label %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit139"

"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit139": ; preds = %bb14.i.i.i138
  unreachable

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit18: ; preds = %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit111"
  br i1 %27, label %bb3.i150, label %bb2.i141

bb2.i141:                                         ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit18
  unreachable

bb3.i150:                                         ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit18
  %41 = and i32 %26, 32
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h69dab78df12e0ff2E.exit160", label %bb6.i151

bb6.i151:                                         ; preds = %bb3.i150
  br label %bb15.i.i.i156

bb15.i.i.i156:                                    ; preds = %bb15.i.i.i156, %bb6.i151
  br label %bb15.i.i.i156

"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h69dab78df12e0ff2E.exit160": ; preds = %bb3.i150
  br label %bb3.i.i20

bb3.i.i20:                                        ; preds = %"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h69dab78df12e0ff2E.exit160"
  br i1 undef, label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit24, label %bb32.i.i.i21

bb32.i.i.i21:                                     ; preds = %bb3.i.i20
  store i32 0, i32* undef, align 1
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* nonnull undef, i8* nonnull null, i16 3, i32 1, i1 false)
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* nonnull undef, i8* nonnull null, i16 3, i32 1, i1 false)
  br label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36.thread

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit24: ; preds = %bb3.i.i20
  %43 = call zeroext i1 @State.Debug.1(%SipHashState* noalias nonnull readonly dereferenceable(32) undef, %Formatter* nonnull dereferenceable(15) %__arg_0)
  br i1 %43, label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36.thread, label %bb3.i.i26

bb3.i.i26:                                        ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit24
  %44 = load i32, i32* %2, align 1
  %45 = icmp eq i32 undef, 0
  br label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit30

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit30: ; preds = %bb3.i.i26
  br i1 %45, label %bb3.i.i200, label %bb2.i.i190

bb2.i.i190:                                       ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit30
  %46 = getelementptr inbounds [128 x i8], [128 x i8]* %buf.i.i.i.i, i16 0, i16 0
  br label %bb15.i.i7.i.i196

bb15.i.i7.i.i196:                                 ; preds = %bb15.i.i7.i.i196, %bb2.i.i190
  %x.018.i.i3.i.i192 = phi i64 [ 0, %bb2.i.i190 ], [ %47, %bb15.i.i7.i.i196 ]
  %47 = lshr i64 %x.018.i.i3.i.i192, 4
  %48 = trunc i64 %x.018.i.i3.i.i192 to i8
  %49 = and i8 %48, 15
  %50 = add nuw nsw i8 %49, 87
  %_0.0.i15.i.i5.i.i194 = select i1 false, i8 0, i8 %50
  store i8 %_0.0.i15.i.i5.i.i194, i8* null, align 1
  %51 = icmp eq i8* null, %46
  %or.cond.i.i6.i.i195 = or i1 undef, %51
  br i1 %or.cond.i.i6.i.i195, label %bb40.i.i8.i.i197, label %bb15.i.i7.i.i196

bb40.i.i8.i.i197:                                 ; preds = %bb15.i.i7.i.i196
  call void @slice_index_order_fail(i16 0, i16 128)
  unreachable

bb3.i.i200:                                       ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit30
  %52 = and i32 %44, 32
  %53 = icmp eq i32 %52, 0
  br i1 %53, label %bb7.i.i211, label %bb6.i.i201

bb6.i.i201:                                       ; preds = %bb3.i.i200
  br label %bb15.i.i.i.i207

bb15.i.i.i.i207:                                  ; preds = %bb15.i.i.i.i207, %bb6.i.i201
  %x.018.i.i.i.i203 = phi i64 [ 0, %bb6.i.i201 ], [ %54, %bb15.i.i.i.i207 ]
  %54 = lshr i64 %x.018.i.i.i.i203, 4
  %55 = add nsw i16 0, -1
  %56 = icmp eq i64 %54, 0
  %or.cond.i.i.i.i206 = or i1 %56, undef
  br i1 %or.cond.i.i.i.i206, label %bb40.i.i.i.i208, label %bb15.i.i.i.i207

bb40.i.i.i.i208:                                  ; preds = %bb15.i.i.i.i207
  call void @slice_index_order_fail(i16 %55, i16 128)
  unreachable

bb7.i.i211:                                       ; preds = %bb3.i.i200
  br i1 undef, label %bb14.i.i.i215.preheader, label %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit216"

bb14.i.i.i215.preheader:                          ; preds = %bb7.i.i211
  br label %bb14.i.i.i215

bb14.i.i.i215:                                    ; preds = %bb14.i.i.i215, %bb14.i.i.i215.preheader
  %n.1.i.i.i213 = phi i64 [ %57, %bb14.i.i.i215 ], [ 0, %bb14.i.i.i215.preheader ]
  %57 = udiv i64 %n.1.i.i.i213, 10000
  %.old5.i.i.i214 = icmp ugt i64 %n.1.i.i.i213, 99999999
  br i1 %.old5.i.i.i214, label %bb14.i.i.i215, label %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit216"

"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit216": ; preds = %bb14.i.i.i215, %bb7.i.i211
  br label %bb3.i.i32

bb3.i.i32:                                        ; preds = %"_ZN53_$LT$$RF$$u27$a$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha71a65aaa694f66fE.exit216"
  store i16* %1, i16** undef, align 1
  %58 = load i32, i32* %2, align 1
  %59 = icmp eq i32 undef, 0
  %60 = and i32 %58, 16
  %61 = icmp eq i32 %60, 0
  br i1 %59, label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36, label %bb32.i.i.i33

bb32.i.i.i33:                                     ; preds = %bb3.i.i32
  unreachable

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36.thread: ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit24, %bb32.i.i.i21
  br label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36: ; preds = %bb3.i.i32
  br i1 %61, label %bb3.i248, label %bb2.i239

bb2.i239:                                         ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36
  br label %bb40.i.i7.i245

bb40.i.i7.i245:                                   ; preds = %bb2.i239
  br i1 undef, label %bb1.i.i.i.i.i8.i246, label %"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6945cc6c151e4f14E.exit.i247"

bb1.i.i.i.i.i8.i246:                              ; preds = %bb40.i.i7.i245
  unreachable

"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6945cc6c151e4f14E.exit.i247": ; preds = %bb40.i.i7.i245
  br label %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit

bb3.i248:                                         ; preds = %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36
  unreachable

_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit: ; preds = %"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h6945cc6c151e4f14E.exit.i247", %_ZN4core3fmt8builders11DebugStruct5field17h7e88e3767fdd3d6bE.exit36.thread
  store %Hasher.Sip13Rounds* %self, %Hasher.Sip13Rounds** undef, align 1
  ret i1 undef
}

attributes #0 = { argmemonly nounwind }