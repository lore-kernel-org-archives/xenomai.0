From: "Ren Yuan (DC-IA/EAN3)" <Yuan.Ren@boschrexroth.nl>
Date: Fri, 7 Nov 2014 16:28:57 +0000
Message-ID: <46e9aebbd25e45f8a3bb4732562bb97f@SI-MBX1019.de.bosch.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Perf makes kernel panic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I've encountered a problem to use perf to get the performance of our code o=
n Linux kernel(3.14) with Xenomai(2.6.4) on ARM based board.
When I use perf on Linux kernel with Xenomai, even a simple test without an=
y xenomai tasks running reports an error "Unable to handle kernel NULL poin=
ter dereference at virtual address 00000000".
But if use perf on Linux kernel without Xenomai, it works.
Could anyone give me some advices how to fix it? Any help would be apprecia=
ted.

The error message is:
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
pgd =3D ecf30000, hw pgd =3D ecf30000
[00000000] *pgd=3D00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 497 Comm: perf_test Tainted: G        W    3.14.0-xilinx #1
task: eee61f80 ti: ee01e000 task.ti: ee01e000
PC is at unwind_frame+0x384/0x44c
LR is at unwind_frame+0x360/0x44c
pc : [<c001371c>]    lr : [<c00136f8>]    psr: 00000013
sp : ee01fb18  ip : c03ef394  fp : 00000008
r10: eecdd000  r9 : c0424e08  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : ee01fb98  r4 : ee01fb1c
r3 : 00000000  r2 : 0000000c  r1 : 00000001  r0 : 00000008
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 18c5387d  Table: 2cf3004a  DAC: 00000015
Process perf_test (pid: 497, stack limit =3D 0xee01e248)
Stack: (0xee01fb18 to 0xee020000)
fb00:                                                       ffffffff ffffff=
ff
fb20: 74657209 7361665f 79735f74 6c616373 78302b6c 78302f30 2f003033 613178=
30
fb40: 00000030 00000008 00000000 c01ae044 00000000 00000000 00000000 c03ef3=
94
fb60: 00000001 00000000 ee01fb98 c0015154 eecdd800 ef1f9d38 00000800 c0424e=
08
fb80: eecdd000 c0010b84 ef1f9d38 eecdd800 eecdd800 c0015aa0 00000000 000000=
00
fba0: 00000000 c01e061c 00000000 ee01e038 00000001 c0078f84 ee004000 ee0040=
00
fbc0: 00000020 00000127 00000000 ee01fc28 ee01fc78 ee004000 ef1f9d38 ee0040=
00
fbe0: 00000000 c0075dfc ef1f9d38 0000109e 00000000 00e04948 00000000 ee01fc=
78
fc00: ef1f9d38 ee004000 00000000 c00761a4 000057ea 00000000 00000001 000000=
00
fc20: 00000001 00000000 00000009 00280001 00e0860f 00000000 ffffa816 ffffff=
ff
fc40: ee004000 00000001 eed49200 00000000 00000000 ee004000 80000000 eed492=
00
fc60: ef1f71c0 00000000 00000001 c00161c8 00000001 ef1f9d38 00000127 000000=
00
fc80: c01e061c 00000000 000001f1 000001f1 f6ba4816 00000009 00000000 000000=
00
fca0: ee01e000 000000ad 00000391 c004f7b0 00000400 c0453ae8 000057ea 000000=
00
fcc0: 00000000 00000000 00000080 00000000 00000000 00000000 00000000 000000=
00
fce0: 00000000 00000001 00000000 00000000 00000000 00000000 00000000 000000=
00
fd00: 00000000 ee7c2940 eec06cc0 00000026 00000000 00000000 c045ddc0 c04508=
98
fd20: c045d400 c0015204 c00151c0 c0051714 eec06cc0 ee7c2940 eec06cc0 eec06d=
1c
fd40: ee7c2940 ef1f79fc ef1f79f8 c045ddc0 00000001 c0051890 eec06cc0 eec06d=
1c
fd60: ef1f9d38 c0054620 c005457c 00000026 c04250d0 c0050fc0 00000026 c000e8=
c4
fd80: 00000026 c045d440 ef1f7a04 c006d9f0 ef1f79f8 ef1f79f4 2edd5000 000002=
02
fda0: ee01e008 00000000 ef1f79fc ef1f79f8 c045ddc0 00400000 c0451500 c006da=
f8
fdc0: 00000001 c0021d58 eec06cc0 eec06d1c 00000000 ef1f79fc 0000000a ffff9b=
85
fde0: 00000001 c045d400 00000000 ee01e010 c04250d0 00000000 ef1f79fc ef1f79=
f8
fe00: c045ddc0 00000001 c045d400 c0022154 00000026 c000e8c8 00000026 c045d4=
40
fe20: ef1f7a04 c006d9f0 ef1f79f8 ef1f79f4 2edd5000 ee0f3180 ee0f31b4 000000=
02
fe40: eee61f80 ee0f31b4 eee61f80 ee0f3188 00000000 c006daf8 ef1f9ddc c00764=
1c
fe60: 2edd5000 ee01e000 ef1fa140 0df5451b ffff9d74 00000009 eee62218 ee7acb=
c8
fe80: 00000001 eee62218 00000009 c01ab500 00000004 ee01e038 ee7acb00 ee01e0=
00
fea0: ee01e008 00000001 ee01e000 00122020 ee0f3540 c00fbc48 00000000 ee7f3c=
80
fec0: ee7acb00 c0131bf4 ee7acb00 00000080 00000000 00000000 00000001 ee01e0=
00
fee0: 00000000 ee7c2b00 00000001 00000017 ee7acb00 ee01e000 be858e8c ee7f2a=
00
ff00: 00000017 ee01ff14 00000000 ee01fec8 befff000 ef2f9620 ee7acb00 c7831e=
4e
ff20: 00000017 00000000 ef2f9620 ee7acb00 c0439418 fffffff8 00000001 c0438f=
e0
ff40: c0438fe0 00122020 00000001 c00fa8a8 00000000 eee61f80 ee01e000 ee7acb=
00
ff60: ee01e030 eec2c000 000001f1 c00fb9f0 ed651378 be858d68 00000000 eee621=
90
ff80: 0000000b be858e8c 00017e60 be858d68 0000000b c000e148 ee01e000 000000=
00
ffa0: be857804 c000df60 be858e8c 00017e60 be858e8c be858d68 00122020 b6ed47=
48
ffc0: be858e8c 00017e60 be858d68 0000000b 00000000 ffffd8ef 000cb0a8 be8578=
04
ffe0: b6ebe59c be8577d0 b6ebe5fc b6e7fa50 a0000010 be858e8c 00000000 000000=
00
[<c001371c>] (unwind_frame) from [<c0010b84>] (walk_stackframe+0x2c/0x38)
[<c0010b84>] (walk_stackframe) from [<c0015aa0>] (perf_callchain_kernel+0x5=
0/0x74)
[<c0015aa0>] (perf_callchain_kernel) from [<c0078f84>] (perf_callchain+0xfc=
/0x1c0)
[<c0078f84>] (perf_callchain) from [<c0075dfc>] (perf_prepare_sample+0x9c/0=
x294)
[<c0075dfc>] (perf_prepare_sample) from [<c00761a4>] (__perf_event_overflow=
+0x1b0/0x23c)
[<c00761a4>] (__perf_event_overflow) from [<c00161c8>] (armv7pmu_handle_irq=
+0xd4/0x104)
[<c00161c8>] (armv7pmu_handle_irq) from [<c0015204>] (armpmu_dispatch_irq+0=
x44/0x48)
[<c0015204>] (armpmu_dispatch_irq) from [<c0051714>] (handle_irq_event_perc=
pu+0x2c/0x16c)
[<c0051714>] (handle_irq_event_percpu) from [<c0051890>] (handle_irq_event+=
0x3c/0x5c)
[<c0051890>] (handle_irq_event) from [<c0054620>] (handle_fasteoi_irq+0xa4/=
0xe4)
[<c0054620>] (handle_fasteoi_irq) from [<c0050fc0>] (generic_handle_irq+0x2=
0/0x30)
[<c0050fc0>] (generic_handle_irq) from [<c000e8c4>] (handle_IRQ+0x68/0x90)
[<c000e8c4>] (handle_IRQ) from [<c006d9f0>] (__ipipe_do_sync_stage+0x214/0x=
24c)
[<c006d9f0>] (__ipipe_do_sync_stage) from [<c006daf8>] (ipipe_unstall_root+=
0x30/0x3c)
[<c006daf8>] (ipipe_unstall_root) from [<c0021d58>] (__do_softirq+0x84/0x22=
0)
[<c0021d58>] (__do_softirq) from [<c0022154>] (irq_exit+0x84/0xe0)
[<c0022154>] (irq_exit) from [<c000e8c8>] (handle_IRQ+0x6c/0x90)
[<c000e8c8>] (handle_IRQ) from [<c006d9f0>] (__ipipe_do_sync_stage+0x214/0x=
24c)
[<c006d9f0>] (__ipipe_do_sync_stage) from [<c006daf8>] (ipipe_unstall_root+=
0x30/0x3c)
[<c006daf8>] (ipipe_unstall_root) from [<c007641c>] (perf_event_comm+0xc0/0=
x160)
[<c007641c>] (perf_event_comm) from [<c00fbc48>] (setup_new_exec+0x8c/0x13c=
)
[<c00fbc48>] (setup_new_exec) from [<c0131bf4>] (load_elf_binary+0x354/0x11=
e8)
[<c0131bf4>] (load_elf_binary) from [<c00fa8a8>] (search_binary_handler+0x6=
8/0x1a0)
[<c00fa8a8>] (search_binary_handler) from [<c00fb9f0>] (do_execve+0x364/0x4=
d4)
[<c00fb9f0>] (do_execve) from [<c000df60>] (ret_fast_syscall+0x0/0x30)
Code: eaffffa8 e21120f0 1afffffa e3110001 (15930000)
---[ end trace 1723d44b22268661 ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU0: stopping
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W    3.14.0-xilinx #1
[<c00137e4>] (unwind_backtrace) from [<c0010eec>] (show_stack+0x10/0x14)
[<c0010eec>] (show_stack) from [<c02fe110>] (dump_stack+0x8c/0xd0)
[<c02fe110>] (dump_stack) from [<c0012898>] (handle_IPI+0xbc/0x13c)
[<c0012898>] (handle_IPI) from [<c006d9a8>] (__ipipe_do_sync_stage+0x1cc/0x=
24c)
[<c006d9a8>] (__ipipe_do_sync_stage) from [<c000836c>] (__ipipe_grab_ipi+0x=
54/0x6c)
[<c000836c>] (__ipipe_grab_ipi) from [<c00085a8>] (gic_handle_irq+0x58/0x60=
)
Exception stack(0xc0429f60 to 0xc0429fa8)
9f60: c006dafc 60000013 ffffffff c0011900 00000000 ef1ed9f4 2edcb000 000000=
00
9f80: c0428000 c0428000 ffffffff c041b170 ef7fcd40 413fc090 00000000 000000=
00
9fa0: 00000001 c0429fb8
[<c00085a8>] (gic_handle_irq) from [<c0011900>] (__irq_svc+0x40/0x6c)
Exception stack(0xc0429f70 to 0xc0429fb8)
9f60:                                     00000000 ef1ed9f4 2edcb000 000000=
00
9f80: c0428000 c0428000 ffffffff c041b170 ef7fcd40 413fc090 00000000 000000=
00
9fa0: 00000001 c0429fb8 c0050f2c c006dafc 60000013 ffffffff
[<c0011900>] (__irq_svc) from [<c006dafc>] (ipipe_unstall_root+0x34/0x3c)
[<c006dafc>] (ipipe_unstall_root) from [<c0050f2c>] (cpu_startup_entry+0xbc=
/0x120)
[<c0050f2c>] (cpu_startup_entry) from [<c03fda0c>] (start_kernel+0x308/0x36=
4)


Regards,
Yuan

