From: Lange Norbert <norbert.lange@andritz.com>
Subject: Deadlock during debugging
Date: Mon, 18 Nov 2019 15:13:43 +0000
Message-ID: <VI1PR05MB5917D854245374A7BF4E34BFF64D0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

Here's one of my deadlocks, the output seems interleaved from 2 concurrent =
dumps,
I ran the crashlog through decode_stacktrace.sh.

I got to this, after enabling a breakpoint in gdb  (execution did stop ther=
e), setting another breakpoint and
hitting continue.

[  135.414273] CPU: 1 PID: 0 Comm: swapper/2 Tainted: G        W         4.=
19.84-xeno8-static #1
[  135.414275] I-pipe: Detected stalled head domain, probably caused by a b=
ug.
[  135.414275]         A critical section may have been left unterminated.
[  135.414287] CPU: 2 PID: 798 Comm: fup.fast Tainted: G        W         4=
.19.84-xeno8-static #1
[  135.422810] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.436373] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.444984] I-pipe domain: Linux
[  135.454290] I-pipe domain: Linux
[  135.463598] RIP: 0010:rcu_nmi_exit+0x140/0x150
[  135.466825] Call Trace:
[  135.470057] Code: 45 89 f0 4c 89 f9 4c 89 e2 4c 89 ee ff d0 48 8b 03 48 =
85 c0 75 e2 48 8b 45 08 4c 8d 78 fe e9 5b ff ff ff 0f 0b e9 ee fe ff ff <0f=
> 0b e9 f8
[  135.474513]  dump_stack+0x8c/0xc0
[  135.476950] RSP: 0018:ffffa3513bb03f18 EFLAGS: 00010046
[  135.495720]  ipipe_stall_root+0xc/0x30
[  135.504264]  __ipipe_trap_prologue+0x209/0x210
[  135.508011] RAX: 00000000000573f4 RBX: 0000000000019480 RCX: 00000000000=
0001f
[  135.512458]  invalid_op+0x26/0x51
[  135.519592] RDX: 0000000000000000 RSI: 0000000050523fbe RDI: 00000000000=
00001
[  135.522914] RIP: 0010:xnthread_suspend+0x3d5/0x4e0
[  135.530050] RBP: ffffa3513ba99480 R08: 0000000000000001 R09: 00000000000=
00000
[  135.534843] Code: 58 12 00 00 4c 89 e7 e8 f9 cf ff ff 41 83 8c 24 c4 11 =
00 00 01 e9 92 fd ff ff 0f 0b 48 83 bf 58 12 00 00 00 0f 84 63 fc ff ff <0f=
> 0b 0f 0b
[  135.541979] R10: ffffa35139832440 R11: 0000000000000424 R12: 00000000000=
00000
[  135.560746] RSP: 0018:ffffbddd0073fd60 EFLAGS: 00010082
[  135.567878] R13: 0000000000000022 R14: 0000000000000000 R15: 00000000000=
00000
[  135.580241] FS:  0000000000000000(0000) GS:ffffa3513ba80000(0000) knlGS:=
0000000000000000
[  135.580246] RAX: ffffbddd005fbe30 RBX: 0000000000025090 RCX: 00000000000=
00000
[  135.588336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.595477] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffbddd005=
fa240
[  135.601225] CR2: 00007f8899c36a10 CR3: 000000017b31c000 CR4: 00000000003=
406e0
[  135.608362] RBP: ffffbddd005fbe08 R08: ffffbddd005fbe08 R09: 00000000000=
00000
[  135.615500] Call Trace:
[  135.622637] R10: 0000000000000000 R11: 0000000000000000 R12: ffffbddd005=
fa240
[  135.625085] ---[ end trace adb8b44963759cc1 ]---
[  135.632220] R13: 0000000000000000 R14: 0000000000000000 R15: ffffbddd005=
fbe08
[  135.636851] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:941 rcu_nmi_ente=
r+0xe4/0xf0
[  135.643982]  xnsynch_sleep_on+0x102/0x260
[  135.651634] Modules linked in:
[  135.655649]  __cobalt_cond_wait_prologue+0x295/0x8c0
[  135.655653]  rt_igb
[  135.658713]  ? __cobalt_cond_wait_prologue+0x8c0/0x8c0
[  135.663677]  plusb
[  135.665781]  CoBaLt_cond_wait_prologue+0x23/0x30
[  135.670918]  usbnet
[  135.672936]  handle_head_syscall+0xe1/0x370
[  135.677555]  mii
[  135.679658]  ipipe_fastcall_hook+0x14/0x20
[  135.685687]  ipipe_handle_syscall+0x4a/0xa0
[  135.689784] CPU: 1 PID: 0 Comm: swapper/2 Tainted: G        W         4.=
19.84-xeno8-static #1
[  135.693971]  do_syscall_64+0x41/0x3d0
[  135.702495] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.706160]  ? __ipipe_handle_irq+0xb7/0x200
[  135.715464] I-pipe domain: Linux
[  135.719738]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  135.722972] RIP: 0010:rcu_nmi_enter+0xe4/0xf0
[  135.728025] RIP: 0033:0x7ffff7f9c134
[  135.732386] Code: 48 85 c0 75 d9 48 8b 6b 08 eb 9a e8 b6 a9 ff ff 48 8b =
6b 08 41 bd 01 00 00 00 4c 8b 35 5d cb 23 01 4c 8d 7d 01 e9 72 ff ff ff <0f=
> 0b e9 44
[  135.735966] Code: 8b 73 04 49 89 dc e8 fb ef ff ff 48 89 de 48 8b 5c 24 =
10 45 31 c0 b9 23 00 00 10 48 8d 54 24 44 45 31 d2 48 89 df 89 c8 0f 05 <8b=
> 7c 24 29
[  135.754730] RSP: 0018:ffffa3513bb03f38 EFLAGS: 00010082
[  135.773496] RSP: 002b:00007fffe82dab10 EFLAGS: 00000246
[  135.778728]  ORIG_RAX: 0000000010000023
[  135.783954] RAX: 0000000000019480 RBX: ffffa3513ba99480 RCX: ffffa3513ba=
9c008
[  135.787792] RAX: ffffffffffffffda RBX: 00007ffff4127c78 RCX: 00007ffff7f=
9c134
[  135.794927] RDX: ffffa3513ba9c000 RSI: 0000000000000001 RDI: 00000000000=
01140
[  135.802065] RDX: 00007fffe82dab54 RSI: 00007ffff4127c48 RDI: 00007ffff41=
27c78
[  135.809201] RBP: fffffffffffffffe R08: ffffa3513ba9c228 R09: 00000000000=
00045
[  135.816337] RBP: 00007fffe82dac30 R08: 0000000000000000 R09: 00000000000=
00000
[  135.823470] R10: ffffa35139832440 R11: 0000000000000424 R12: ffffffff9e7=
af080
[  135.830604] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffff41=
27c48
[  135.837738] R13: 0000000000045000 R14: 0000000000000090 R15: 00000000000=
00000
[  135.844875] R13: 0000000000000000 R14: 0000000000000001 R15: 00007fffe82=
dab60
[  135.852011] FS:  0000000000000000(0000) GS:ffffa3513ba80000(0000) knlGS:=
0000000000000000
[  135.859148] BUG: Unhandled exception over domain Xenomai at 0xffffffff9c=
f91665 - switching to ROOT
[  135.867237] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.876195] CPU: 2 PID: 798 Comm: fup.fast Tainted: G        W         4=
.19.84-xeno8-static #1
[  135.881944] CR2: 00007f8899c36a10 CR3: 000000017b31c000 CR4: 00000000003=
406e0
[  135.890553] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.897691] Call Trace:
[  135.906997] I-pipe domain: Linux
[  135.909445] ---[ end trace adb8b44963759cc2 ]---
[  135.912674] Call Trace:
[  135.917296] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:793 rcu_nmi_exit=
+0x139/0x150
[  135.919744]  dump_stack+0x8c/0xc0
[  135.927490] Modules linked in:
[  135.930810]  __ipipe_trap_prologue.cold+0x22/0x4e
[  135.930814]  rt_igb
[  135.933875]  invalid_op+0x26/0x51
[  135.938580]  plusb
[  135.940684] RIP: 0010:xnthread_suspend+0x3d5/0x4e0
[  135.943998]  usbnet
[  135.946016] Code: 58 12 00 00 4c 89 e7 e8 f9 cf ff ff 41 83 8c 24 c4 11 =
00 00 01 e9 92 fd ff ff 0f 0b 48 83 bf 58 12 00 00 00 0f 84 63 fc ff ff <0f=
> 0b 0f 0b
[  135.950809]  mii
[  135.952912] RSP: 0018:ffffbddd0073fd60 EFLAGS: 00010082
[  135.978750] CPU: 1 PID: 0 Comm: swapper/2 Not tainted 4.19.84-xeno8-stat=
ic #1
[  135.978756] RAX: ffffbddd005fbe30 RBX: 0000000000025090 RCX: 00000000000=
00000
[  135.985889] Hardware name: TQ-Group TQM


------ decoded stacktrace

[  135.414273] CPU: 1 PID: 0 Comm: swapper/2 Tainted: G        W         4.=
19.84-xeno8-static #1
[  135.414275] I-pipe: Detected stalled head domain, probably caused by a b=
ug.
[  135.414275]         A critical section may have been left unterminated.
[  135.414287] CPU: 2 PID: 798 Comm: fup.fast Tainted: G        W         4=
.19.84-xeno8-static #1
[  135.422810] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.436373] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.444984] I-pipe domain: Linux
[  135.454290] I-pipe domain: Linux
[  135.463598] RIP: 0010:rcu_nmi_exit (??:?)
[  135.466825] Call Trace:
[ 135.470057] Code: 45 89 f0 4c 89 f9 4c 89 e2 4c 89 ee ff d0 48 8b 03 48 8=
5 c0 75 e2 48 8b 45 08 4c 8d 78 fe e9 5b ff ff ff 0f 0b e9 ee fe ff ff <0f>=
 0b e9 f8
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:      45 89 f0                        mov    %r14d,%r8d
   3:      4c 89 f9                         mov    %r15,%rcx
   6:      4c 89 e2                        mov    %r12,%rdx
   9:      4c 89 ee                        mov    %r13,%rsi
   c:      ff d0                  callq  *%rax
   e:      48 8b 03                        mov    (%rbx),%rax
  11:      48 85 c0                        test   %rax,%rax
  14:      75 e2                jne    0xfffffffffffffff8
  16:      48 8b 45 08                   mov    0x8(%rbp),%rax
  1a:      4c 8d 78 fe                    lea    -0x2(%rax),%r15
  1e:      e9 5b ff ff ff        jmpq   0xffffffffffffff7e
  23:      0f 0b                  ud2
  25:      e9 ee fe ff ff                  jmpq   0xffffffffffffff18
  2a:*    0f 0b                  ud2                  <-- trapping instruct=
ion
  2c:      e9                     .byte 0xe9
  2d:     f8                      clc

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:      0f 0b                  ud2
   2:      e9                     .byte 0xe9
   3:      f8                      clc
[  135.474513] dump_stack (/tmp/xeno/linux/lib/dump_stack.c:147)
[  135.476950] RSP: 0018:ffffa3513bb03f18 EFLAGS: 00010046
[  135.495720] ipipe_stall_root (/tmp/xeno/linux/arch/x86/include/asm/irqfl=
ags.h:33 /tmp/xeno/linux/arch/x86/include/asm/irqflags.h:260 /tmp/xeno/linu=
x/arch/x86/include/asm/irqflags.h:331 /tmp/xeno/linux/kernel/ipipe/core.c:3=
94)
[  135.504264] __ipipe_trap_prologue (/tmp/xeno/linux/arch/x86/include/asm/=
irqflags.h:113 /tmp/xeno/linux/arch/x86/kernel/ipipe.c:426)
[  135.508011] RAX: 00000000000573f4 RBX: 0000000000019480 RCX: 00000000000=
0001f
[  135.512458] invalid_op (/tmp/xeno/linux/arch/x86/entry/entry_64.S:1145)
[  135.519592] RDX: 0000000000000000 RSI: 0000000050523fbe RDI: 00000000000=
00001
[  135.522914] RIP: 0010:xnthread_suspend (??:?)
[  135.530050] RBP: ffffa3513ba99480 R08: 0000000000000001 R09: 00000000000=
00000
[ 135.534843] Code: 58 12 00 00 4c 89 e7 e8 f9 cf ff ff 41 83 8c 24 c4 11 0=
0 00 01 e9 92 fd ff ff 0f 0b 48 83 bf 58 12 00 00 00 0f 84 63 fc ff ff <0f>=
 0b 0f 0b
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:      58                     pop    %rax
   1:      12 00                adc    (%rax),%al
   3:      00 4c 89 e7                   add    %cl,-0x19(%rcx,%rcx,4)
   7:      e8 f9 cf ff ff       callq  0xffffffffffffd005
   c:      41 83 8c 24 c4 11 00     orl    $0x1,0x11c4(%r12)
  13:      00 01
  15:      e9 92 fd ff ff                  jmpq   0xfffffffffffffdac
  1a:      0f 0b                  ud2
  1c:      48 83 bf 58 12 00 00     cmpq   $0x0,0x1258(%rdi)
  23:      00
  24:      0f 84 63 fc ff ff              je     0xfffffffffffffc8d
  2a:*    0f 0b                  ud2                  <-- trapping instruct=
ion
  2c:      0f 0b                  ud2

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:      0f 0b                  ud2
   2:      0f 0b                  ud2
[  135.541979] R10: ffffa35139832440 R11: 0000000000000424 R12: 00000000000=
00000
[  135.560746] RSP: 0018:ffffbddd0073fd60 EFLAGS: 00010082
[  135.567878] R13: 0000000000000022 R14: 0000000000000000 R15: 00000000000=
00000
[  135.580241] FS:  0000000000000000(0000) GS:ffffa3513ba80000(0000) knlGS:=
0000000000000000
[  135.580246] RAX: ffffbddd005fbe30 RBX: 0000000000025090 RCX: 00000000000=
00000
[  135.588336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.595477] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffbddd005=
fa240
[  135.601225] CR2: 00007f8899c36a10 CR3: 000000017b31c000 CR4: 00000000003=
406e0
[  135.608362] RBP: ffffbddd005fbe08 R08: ffffbddd005fbe08 R09: 00000000000=
00000
[  135.615500] Call Trace:
[  135.622637] R10: 0000000000000000 R11: 0000000000000000 R12: ffffbddd005=
fa240
[  135.625085] ---[ end trace adb8b44963759cc1 ]---
[  135.632220] R13: 0000000000000000 R14: 0000000000000000 R15: ffffbddd005=
fbe08
[  135.636851] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:941 rcu_nmi_ente=
r (/tmp/xeno/linux/kernel/rcu/tree.c:941 (discriminator 1))
[  135.643982] xnsynch_sleep_on (/tmp/xeno/linux/include/xenomai/cobalt/ker=
nel/lock.h:236 (discriminator 16) /tmp/xeno/linux/kernel/xenomai/synch.c:22=
9 (discriminator 16))
[  135.651634] Modules linked in:
[  135.655649] __cobalt_cond_wait_prologue (/tmp/xeno/linux/kernel/xenomai/=
posix/cond.c:189 /tmp/xeno/linux/kernel/xenomai/posix/cond.c:316)
[  135.655653]  rt_igb
[  135.658713] ? __cobalt_cond_wait_prologue (/tmp/xeno/linux/kernel/xenoma=
i/posix/cond.c:353)
[  135.663677]  plusb
[  135.665781] CoBaLt_cond_wait_prologue (/tmp/xeno/linux/kernel/xenomai/po=
six/cond.c:354)
[  135.670918]  usbnet
[  135.672936] handle_head_syscall (/tmp/xeno/linux/kernel/xenomai/posix/sy=
scall.c:592)
[  135.677555]  mii
[  135.679658] ipipe_fastcall_hook (/tmp/xeno/linux/kernel/xenomai/posix/sy=
scall.c:793)
[  135.685687] ipipe_handle_syscall (/tmp/xeno/linux/include/linux/compiler=
.h:193 /tmp/xeno/linux/kernel/ipipe/core.c:1057)
[  135.689784] CPU: 1 PID: 0 Comm: swapper/2 Tainted: G        W         4.=
19.84-xeno8-static #1
[  135.693971] do_syscall_64 (/tmp/xeno/linux/arch/x86/entry/common.c:317)
[  135.702495] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.706160] ? __ipipe_handle_irq (/tmp/xeno/linux/include/linux/ipipe_do=
main.h:308 /tmp/xeno/linux/arch/x86/kernel/ipipe.c:533)
[  135.715464] I-pipe domain: Linux
[  135.719738] entry_SYSCALL_64_after_hwframe (/tmp/xeno/linux/arch/x86/ent=
ry/entry_64.S:254)
[  135.722972] RIP: 0010:rcu_nmi_enter (??:?)
[  135.728025] RIP: 0033:0x7ffff7f9c134
[ 135.732386] Code: 48 85 c0 75 d9 48 8b 6b 08 eb 9a e8 b6 a9 ff ff 48 8b 6=
b 08 41 bd 01 00 00 00 4c 8b 35 5d cb 23 01 4c 8d 7d 01 e9 72 ff ff ff <0f>=
 0b e9 44
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:      48 85 c0                        test   %rax,%rax
   3:      75 d9                jne    0xffffffffffffffde
   5:      48 8b 6b 08                   mov    0x8(%rbx),%rbp
   9:      eb 9a                jmp    0xffffffffffffffa5
   b:      e8 b6 a9 ff ff                 callq  0xffffffffffffa9c6
  10:      48 8b 6b 08                   mov    0x8(%rbx),%rbp
  14:      41 bd 01 00 00 00         mov    $0x1,%r13d
  1a:      4c 8b 35 5d cb 23 01     mov    0x123cb5d(%rip),%r14        # 0x=
123cb7e
  21:      4c 8d 7d 01                   lea    0x1(%rbp),%r15
  25:      e9 72 ff ff ff       jmpq   0xffffffffffffff9c
  2a:*    0f 0b                  ud2                  <-- trapping instruct=
ion
  2c:      e9                     .byte 0xe9
  2d:     44                     rex.R

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:      0f 0b                  ud2
   2:      e9                     .byte 0xe9
   3:      44                     rex.R
[ 135.735966] Code: 8b 73 04 49 89 dc e8 fb ef ff ff 48 89 de 48 8b 5c 24 1=
0 45 31 c0 b9 23 00 00 10 48 8d 54 24 44 45 31 d2 48 89 df 89 c8 0f 05 <8b>=
 7c 24 29
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:      8b 73 04                        mov    0x4(%rbx),%esi
   3:      49 89 dc                        mov    %rbx,%r12
   6:      e8 fb ef ff ff       callq  0xfffffffffffff006
   b:      48 89 de                        mov    %rbx,%rsi
   e:      48 8b 5c 24 10              mov    0x10(%rsp),%rbx
  13:      45 31 c0                        xor    %r8d,%r8d
  16:      b9 23 00 00 10              mov    $0x10000023,%ecx
  1b:     48 8d 54 24 44              lea    0x44(%rsp),%rdx
  20:      45 31 d2                        xor    %r10d,%r10d
  23:      48 89 df                        mov    %rbx,%rdi
  26:      89 c8                mov    %ecx,%eax
  28:      0f 05                  syscall
  2a:*    8b 7c 24 29                   mov    0x29(%rsp),%edi             =
           <-- trapping instruction

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:      8b 7c 24 29                   mov    0x29(%rsp),%edi
[  135.754730] RSP: 0018:ffffa3513bb03f38 EFLAGS: 00010082
[  135.773496] RSP: 002b:00007fffe82dab10 EFLAGS: 00000246
[  135.778728]  ORIG_RAX: 0000000010000023
[  135.783954] RAX: 0000000000019480 RBX: ffffa3513ba99480 RCX: ffffa3513ba=
9c008
[  135.787792] RAX: ffffffffffffffda RBX: 00007ffff4127c78 RCX: 00007ffff7f=
9c134
[  135.794927] RDX: ffffa3513ba9c000 RSI: 0000000000000001 RDI: 00000000000=
01140
[  135.802065] RDX: 00007fffe82dab54 RSI: 00007ffff4127c48 RDI: 00007ffff41=
27c78
[  135.809201] RBP: fffffffffffffffe R08: ffffa3513ba9c228 R09: 00000000000=
00045
[  135.816337] RBP: 00007fffe82dac30 R08: 0000000000000000 R09: 00000000000=
00000
[  135.823470] R10: ffffa35139832440 R11: 0000000000000424 R12: ffffffff9e7=
af080
[  135.830604] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffff41=
27c48
[  135.837738] R13: 0000000000045000 R14: 0000000000000090 R15: 00000000000=
00000
[  135.844875] R13: 0000000000000000 R14: 0000000000000001 R15: 00007fffe82=
dab60
[  135.852011] FS:  0000000000000000(0000) GS:ffffa3513ba80000(0000) knlGS:=
0000000000000000
[  135.859148] BUG: Unhandled exception over domain Xenomai at 0xffffffff9c=
f91665 - switching to ROOT
[  135.867237] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.876195] CPU: 2 PID: 798 Comm: fup.fast Tainted: G        W         4=
.19.84-xeno8-static #1
[  135.881944] CR2: 00007f8899c36a10 CR3: 000000017b31c000 CR4: 00000000003=
406e0
[  135.890553] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[  135.897691] Call Trace:
[  135.906997] I-pipe domain: Linux
[  135.909445] ---[ end trace adb8b44963759cc2 ]---
[  135.912674] Call Trace:
[  135.917296] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:793 rcu_nmi_exit=
 (/tmp/xeno/linux/kernel/rcu/tree.c:793 (discriminator 1))
[  135.919744] dump_stack (/tmp/xeno/linux/lib/dump_stack.c:147)
[  135.927490] Modules linked in:
[  135.930810] __ipipe_trap_prologue.cold (/tmp/xeno/linux/arch/x86/kernel/=
ipipe.c:436)
[  135.930814]  rt_igb
[  135.933875] invalid_op (/tmp/xeno/linux/arch/x86/entry/entry_64.S:1145)
[  135.938580]  plusb
[  135.940684] RIP: 0010:xnthread_suspend (??:?)
[  135.943998]  usbnet
[ 135.946016] Code: 58 12 00 00 4c 89 e7 e8 f9 cf ff ff 41 83 8c 24 c4 11 0=
0 00 01 e9 92 fd ff ff 0f 0b 48 83 bf 58 12 00 00 00 0f 84 63 fc ff ff <0f>=
 0b 0f 0b
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:      58                     pop    %rax
   1:      12 00                adc    (%rax),%al
   3:      00 4c 89 e7                   add    %cl,-0x19(%rcx,%rcx,4)
   7:      e8 f9 cf ff ff       callq  0xffffffffffffd005
   c:      41 83 8c 24 c4 11 00     orl    $0x1,0x11c4(%r12)
  13:      00 01
  15:      e9 92 fd ff ff                  jmpq   0xfffffffffffffdac
  1a:      0f 0b                  ud2
  1c:      48 83 bf 58 12 00 00     cmpq   $0x0,0x1258(%rdi)
  23:      00
  24:      0f 84 63 fc ff ff              je     0xfffffffffffffc8d
  2a:*    0f 0b                  ud2                  <-- trapping instruct=
ion
  2c:      0f 0b                  ud2

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:      0f 0b                  ud2
   2:      0f 0b                  ud2
[  135.950809]  mii
[  135.952912] RSP: 0018:ffffbddd0073fd60 EFLAGS: 00010082
[  135.978750] CPU: 1 PID: 0 Comm: swapper/2 Not tainted 4.19.84-xeno8-stat=
ic #1
[  135.978756] RAX: ffffbddd005fbe30 RBX: 0000000000025090 RCX: 00000000000=
00000
[  135.985889] Hardware name: TQ-Group TQM

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corporation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
