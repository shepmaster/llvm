; RUN: llc < %s -mtriple=i686-pc-win32 | FileCheck %s

%Foo = type { i32, i32 }

%frame = type { %Foo, i32, %Foo }

declare void @f(%frame* inalloca %a)

declare void @Foo_ctor(%Foo* %this)

define void @g() {
entry:
; CHECK: movl    %esp, %ebp
  %args = alloca inalloca %frame
  %c = getelementptr %frame, %frame* %args, i32 0, i32 2
; CHECK: movl    %esp, %[[tmp_sp1:.*]]
; CHECK: leal    -20(%[[tmp_sp1]]), %[[tmp_sp2:.*]]
; CHECK: movl    %[[tmp_sp2]], %esp
  call void @Foo_ctor(%Foo* %c)
; CHECK: leal -8(%[[tmp_sp1]]),
; CHECK-NEXT: pushl
; CHECK-NEXT: calll _Foo_ctor
; CHECK: addl $4, %esp
  %b = getelementptr %frame, %frame* %args, i32 0, i32 1
  store i32 42, i32* %b
; CHECK: movl $42,
  %a = getelementptr %frame, %frame* %args, i32 0, i32 0
  call void @Foo_ctor(%Foo* %a)
; CHECK-NEXT: pushl
; CHECK-NEXT: calll _Foo_ctor
; CHECK: addl $4, %esp
  call void @f(%frame* inalloca %args)
; CHECK: calll   _f
  ret void
}
