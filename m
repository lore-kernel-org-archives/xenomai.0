Message-ID: <6ee4c8380604272202q3109a3b9n71e0327de76730b8@domain.hid>
Date: Fri, 28 Apr 2006 01:02:55 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] Buffer Overrun -> Kernel Explosion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I'm finally set up with netconsole to catch panics/crashes when they
happen so now I can report more information on the one I alluded to a
week or two ago in my "General Question.." thread.

What I did to cause it was write past the end of a buffer returned by
rt_queue_alloc. I'm not entirely sure if this message came at the
moment of the write (unlikely, IMHO) or later when more xnheap
activity took place. The crash popped up in several different ways
depending on what code paths I enabled/disabled.

What concerns me is that polluting an xnheap can bring the system to
its knees so harshly. I can see why it could be *very* hard to police
this sort of problem without destroying the performance of xnheap, so
it wouldn't surprise me if this is "normal". Still, though, it's sad
that user-space code can bring the system down after something as
innocent as a fencepost error in a string copy routine...

Thoughts? I've pasted the console dump below.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Unable to handle kernel paging request at virtual address 29343231
 printing eip:
c013b8dc
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: intel_agp agpgart
CPU:    0
EIP:    0060:[<c013b8dc>]    Not tainted VLI
EFLAGS: 00010002   (2.6.15-ipipe)
EIP is at xnheap_alloc+0x9c/0x170
eax: d0800d54   ebx: 00000020   ecx: d0800d54   edx: c03d5740
ds: 007b   es: 007b   ss: 0068
I-pipe domain Xenomai
Stack: cf913a50 00000001 00000092 00000001 00000005 d0800d20 00000001 c03d5=
740
       ce52bf0c c015fda6 d0800d54 00000015 d0800d20 ce52bfbc 00000000 ce52b=
f40
       c015ab10 d0800d20 00000005 00000010 00000000 00000003 d0800d54 b7f0c=
000
Call Trace:
 [<c010375f>] show_stack+0x7f/0xa0
 [<c01038fe>] show_registers+0x14e/0x1f0
 [<c0103b45>] die+0xf5/0x1c0
 [<c010ea8e>] do_page_fault+0x2ee/0x5bc
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c015fda6>] rt_queue_alloc+0x56/0xd0

 [<c0103c0d>] die+0x1bd/0x1c0
 [<c010ea8e>] do_page_fault+0x2ee/0x5bc
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c015fda6>] rt_queue_alloc+0x56/0xd0
 [<c015ab10>] __rt_queue_alloc+0xb0/0x130
 [<c014d0fa>] hisyscall_event+0x29a/0x3a0
 [<c0139cd3>] __ipipe_dispatch_event+0xe3/0x100
 [<c010d6e0>] __ipipe_syscall_root+0x30/0xe0
 [<c0103138>] system_call+0x20/0x41
Code: 74 33 8b 46 0c a8 08 75 22 83 c8 08 89 46 0c ff ff 21 e0 ff 40 14 eb
------------[ cut here ]------------
kernel BUG at kernel/exit.c:877!
invalid operand: 0000 [#5]
PREEMPT
Modules linked in: intel_agp agpgart
CPU:    0
EIP:    0060:[<c01183f2>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15-ipipe)
EIP is at do_exit+0x302/0x5f0
eax: 0080200c   ebx: 00000000   ecx: ce52b8c0   edx: ce52b8c0
ds: 007b   es: 007b   ss: 0068
I-pipe domain Xenomai
Stack: cf64d570 c03d5740 ffffffff ce52ba48 00000001 00000000 ffffffff 00000=
000
       ce52b93c c0103c0d 00000000 00000001 ce52b914 00000004 ce52ba48 c031b=
cd0
       00000000 000000ff 0000000b ce52ba48 ce52b93c
CPU:    0
EIP:    0060:[<c01183f2>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15-ipipe)
EIP is at do_exit+0x302/0x5f0
eax: 0080200c   ebx: 00000000   ecx: ce52b720   edx: ce52b720
esi: cf64d570   edi: 0000000b   ebp: ce52b75c   esp: ce52b73c
ds: 007b   es: 007b   ss: 0068
I-pipe domain Xenomai
Stack: cf64d570 c03d5740 ffffffff ce52b8a8 00000000 00000000 ffffffff 00000=
000
       ce52b79c c0103c0d 00000000 00000001 ce52b774 00000005 ce52b8a8 c031b=
cd0
       00000000 000000ff 0000000b ce52b8a8 ce52b79c c010f3a7 cf64d570 ce52b=
8a8
Call Trace:
 [<c010375f>] show_stack+0x7f/0xa0
 [<c01038fe>] show_registers+0x14e/0x1f0
 [<c0103b45>] die+0xf5/0x1c0
 [<c0103cc5>] do_trap+0xb5/0xc0
 [<c010400c>] do_invalid_op+0xbc/0xd0
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
<0f> 0b 6d 03 27 cf 31 c0 eb d4 b8 00 e0 ff ff 21 e0 ff 40 14 eb
------------[ cut here ]------------
kernel BUG at kernel/exit.c:877!
invalid operand: 0000 [#7]
PREEMPT
Modules linked in: intel_agp agpgart
CPU:    0
EIP:    0060:[<c01183f2>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15-ipipe)
EIP is at do_exit+0x302/0x5f0
eax: 0080200c   ebx: 00000000   ecx: ce52b580   edx: ce52b580
esi: cf64d570   edi: 0000000b   ebp: ce52b5bc   esp: ce52b59c
ds: 007b   es: 007b   ss: 0068
I-pipe domain Xenomai
Stack:  [<c010400c>] do_invalid_op+0xbc/0xd0
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c0103c0d>] die+0x1bd/0x1c0
 [<c010ea8e>] do_page_fault+0x2ee/0x5bc
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c015fda6>] rt_queue_alloc+0x56/0xd0
 [<c015ab10>] __rt_queue_alloc+0xb0/0x130
 [<c01033b0>] error_code+0x54/0x64
 [<c0103c0d>] die+0x1bd/0x1c0
 [<c0103cc5>] do_trap+0xb5/0xc0
 [<c010400c>] do_invalid_op+0xbc/0xd0
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c0103c0d>] die+0x1bd/0x1c0
 [<c0103cc5>] do_trap+0xb5/0xc0
 [<c010400c>] do_invalid_op+0xbc/0xd0c0 eb b8 00 e0 ff ff 21 e0 ff 40 14 eb
------------[ cut here ]------------
kernel BUG at kernel/exit.c:877!
invalid operand: 0000 [#13]
PREEMPT
Modules linked in: intel_agp agpgart
CPU:    0
EIP:    0060:[<c01183f2>]    Not tainted VLI
die+0x1bd/0x1c0
 [<c0103cc5>] do_trap+0xb5/0xc0
 [<c010400c>] do_invalid_op+0xbc/0xd0
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c0103c0d>] die+0x1bd/0x1c0
 [<c0103cc5>] do_trap+0xb5/0xc0
 [<c010400c>] do_invalid_op+0xbc/0xd0
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c0103c0d>] die+0x1bd/0x1c000 eb fe <0f> 0b 6d 03 27 cf 31 c0 eb d4
b8 00 e0 ff ff 21 e0 ff 40 14 eb
------------[ cut here ]-------- [<c010d7df>] __ipipe_handle_exception+0x3f=
/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c0103c0d>] die+0x1bd/0x1c0
 [<c0103cc5>] do_trap+0xb5/0xc0
 [<c010400c>] do_invalid_op+0xbc/0xd0
 [<c010d7df>] __ipipe_handle_exception+0x3f/0xc0
 [<c01033b0>] error_code+0x54/0x64
 [<c0103c0d>] die+0x1bd/0x1c0
 [<c0103cc5>] do_trap+0xb5/0xc0
 [<c010400c>]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
03 27 cf 31 c0 8d b6 00 00 00 00 8d bc 27 00 00 00 00 eb fe <0f> 0b 6d
03 27 cf 31 c0 eb

