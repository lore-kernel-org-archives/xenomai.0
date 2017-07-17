From: Liam Donovan <liam@bela.io>
Message-Id: <7EBABB3E-8E3D-4AD0-9C08-5B1C464690BF@bela.io>
Date: Mon, 17 Jul 2017 18:20:35 +0200
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Porting Xenomai 3 cobalt to Raspberry Pi 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

I=E2=80=99m attempting to port the xenomai cobalt core to the pi3 =
(actually to a compute module 3, but as far as I can tell they use the =
same chip) with a 4.9 kernel, and am having some trouble. The ipipe =
patch applies successfully and the kernel compiles (with CONFIG_IPIPE =
set and CONFIG_XENOMAI not set) but it fails with the following oops =
during boot:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.32-1 (gcc version 6.3.0 (GCC) ) #1 SMP =
Mon Jul 17 17:38:32 CEST 2017
[    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), =
cr=3D10c5383d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing =
instruction cache
[    0.000000] OF: fdt:Machine model: Raspberry Pi Compute Module 3
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] cma: Reserved 16 MiB at 0x36000000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] percpu: Embedded 17 pages/cpu @b58c0000 s39564 r8192 =
d21876 u69632
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 223520
[    0.000000] Kernel command line: console=3DttyAMA0,115200 =
console=3Dtty1 earlyprintk boot_delay=3D100 root=3D/dev/mmcblk0p2 =
rootwait
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 =
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 =
bytes)
[    0.000000] Memory: 870404K/901120K available (3787K kernel code, =
233K rwdata, 1240K rodata, 264K init, 560K bss, 14332K reserved, 16384K =
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xb7800000 - 0xff800000   (1152 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xb7000000   ( 880 MB)
[    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
[    0.000000]       .text : 0x80008000 - 0x803bae90   (3788 kB)
[    0.000000]       .init : 0x804f2000 - 0x80534000   ( 264 kB)
[    0.000000]       .data : 0x80534000 - 0x8056e484   ( 234 kB)
[    0.000000]        .bss : 0x80570000 - 0x805fc0fc   ( 561 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, =
Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at =
19.20MHz (phys).
[    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 =
ms
[    0.000000] clocksource: ipipe_tsc: mask: 0xffffffffffffffff =
max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff =
max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.100010] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps =
every 4398046511078ns
[    0.208248] Switching to timer-based delay loop, resolution 52ns
[    0.315968] Interrupt pipeline (release #2)
[    0.420433] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    0.525751] Modules linked in:
[    0.728966] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.32-1 #1
[    0.835251] Hardware name: BCM2835
[    0.938799] I-pipe domain: Linux
[    1.042173] task: 80539500 task.stack: 80534000
[    1.146894] PC is at irq_work_run_list+0x1c/0xc0
[    1.251690] LR is at ipipe_test_root+0x64/0x78
[    1.356306] pc : [<800a8ee4>]    lr : [<80016a7c>]    psr: 60000153
[    1.356306] sp : 80535e20  ip : 80535e00  fp : 80535e3c
[    1.468159] r10: 00000000  r9 : 00000001  r8 : 805374b8
[    1.573562] r7 : 00000000  r6 : 00000000  r5 : 80539500  r4 : =
b58c6af0
[    1.680296] r3 : 00000000  r2 : 00000000  r1 : 35396000  r0 : =
00000000
[    1.787027] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  =
Segment user
[    1.894464] Control: 10c5383d  Table: 0000406a  DAC: 00000055
[    2.000394] Process swapper/0 (pid: 0, stack limit =3D 0x80534220)
[    2.106598] Stack: (0x80535e20 to 0x80536000)
[    2.211133] 5e20: 80534000 80539500 00000000 00000000 80535e4c =
80535e40 800a91d0 800a8ed4
[    2.319550] 5e40: 80535e6c 80535e50 8006dc08 800a91a0 00000000 =
00000000 00989680 00000000
[    2.427968] 5e60: 80535e84 80535e70 8006dc50 8006dbbc 80536d80 =
00000000 80535e9c 80535e88
[    2.536388] 5e80: 8007a8d8 8006dc28 b58cbe80 00000000 80535ecc =
80535ea0 8007a928 8007a834
[    2.644804] 5ea0: 00000000 00000000 b5034900 ffffe000 b5004d40 =
00000011 805374b8 00000001
[    2.753219] 5ec0: 80535edc 80535ed0 802f4e9c 8007a8fc 80535f04 =
80535ee0 80062444 802f4e3c
[    2.861633] 5ee0: 00000000 80530d68 805374b8 00000000 b5005100 =
00000001 80535f14 80535f08
[    2.970048] 5f00: 8005d884 80062368 80535f3c 80535f18 8005df00 =
8005d868 8008a0d0 60000053
[    3.078462] 5f20: ffffffff 80535f84 b5fffcc0 80534000 80535f4c =
80535f40 8000984c 8005de3c
[    3.186883] 5f40: 80535fb4 80535f50 800141b0 800097b4 80000000 =
b58c36f8 00000000 00000000
[    3.295303] 5f60: 8052d6f8 80570000 ffffffff 80537000 b5fffcc0 =
805218c0 00000000 80535fb4
[    3.403718] 5f80: 80535fa0 80535fa0 8008a0cc 8008a0d0 60000053 =
ffffffff 8008a0cc 00000000
[    3.512133] 5fa0: 00000000 80570000 80535ff4 80535fb8 804f2b8c =
8008a054 ffffffff ffffffff
[    3.620549] 5fc0: 00000000 804f26c8 00000000 805218c0 80570294 =
80537018 805218bc 8053a764
[    3.728964] 5fe0: 0000406a 410fd034 00000000 80535ff8 00008078 =
804f2964 00000000 00000000
[    3.837370] Backtrace:=20
[    4.039966] [<800a8ec8>] (irq_work_run_list) from [<800a91d0>] =
(irq_work_tick+0x3c/0x48)
[    4.148291]  r7:00000000 r6:00000000 r5:80539500 r4:80534000
[    4.254155] [<800a9194>] (irq_work_tick) from [<8006dc08>] =
(update_process_times+0x58/0x6c)
[    4.362751] [<8006dbb0>] (update_process_times) from [<8006dc50>] =
(update_root_process_times+0x34/0x5c)
[    4.472398]  r7:00000000 r6:00989680 r5:00000000 r4:00000000
[    4.578260] [<8006dc1c>] (update_root_process_times) from =
[<8007a8d8>] (tick_periodic+0xb0/0xc8)
[    4.687283]  r5:00000000 r4:80536d80
[    4.791022] [<8007a828>] (tick_periodic) from [<8007a928>] =
(tick_handle_periodic+0x38/0xac)
[    4.899610]  r5:00000000 r4:b58cbe80
[    5.003358] [<8007a8f0>] (tick_handle_periodic) from [<802f4e9c>] =
(arch_timer_handler_phys+0x6c/0x84)
[    5.112832]  r9:00000001 r8:805374b8 r7:00000011 r6:b5004d40 =
r5:ffffe000 r4:b5034900
[    5.220820] [<802f4e30>] (arch_timer_handler_phys) from [<80062444>] =
(handle_percpu_devid_irq+0xe8/0x24c)
[    5.330654] [<8006235c>] (handle_percpu_devid_irq) from [<8005d884>] =
(generic_handle_irq+0x28/0x38)
[    5.439950]  r9:00000001 r8:b5005100 r7:00000000 r6:805374b8 =
r5:80530d68 r4:00000000
[    5.547928] [<8005d85c>] (generic_handle_irq) from [<8005df00>] =
(__handle_domain_irq+0xd0/0xe8)
[    5.656877] [<8005de30>] (__handle_domain_irq) from [<8000984c>] =
(bcm2836_arm_irqchip_handle_irq+0xa4/0xac)
[    5.766881]  r9:80534000 r8:b5fffcc0 r7:80535f84 r6:ffffffff =
r5:60000053 r4:8008a0d0
[    5.874856] [<800097a8>] (bcm2836_arm_irqchip_handle_irq) from =
[<800141b0>] (__irq_svc+0x70/0x7c)
[    5.983967] Exception stack(0x80535f50 to 0x80535f98)
[    6.089200] 5f40:                                     80000000 =
b58c36f8 00000000 00000000
[    6.197618] 5f60: 8052d6f8 80570000 ffffffff 80537000 b5fffcc0 =
805218c0 00000000 80535fb4
[    6.306037] 5f80: 80535fa0 80535fa0 8008a0cc 8008a0d0 60000053 =
ffffffff
[    6.412878] [<8008a048>] (ipipe_unstall_root) from [<804f2b8c>] =
(start_kernel+0x234/0x2f8)
[    6.521374]  r5:80570000 r4:00000000
[    6.625115] [<804f2958>] (start_kernel) from [<00008078>] (0x8078)
[    6.731498]  r9:410fd034 r8:0000406a r7:8053a764 r6:805218bc =
r5:80537018 r4:80570294
[    6.839466] Code: e1a04000 ebfdb6ce e3100001 1a000000 (e7f001f2)=20
[    6.945773] ---[ end trace 0000000000000000 ]---
[    7.050570] Kernel panic - not syncing: Fatal exception in interrupt
[    7.157144] ---[ end Kernel panic - not syncing: Fatal exception in =
interrupt=20

The oops is being caused by the following line in irq_work_run_list:

BUG_ON(!irqs_disabled());

What seems to be happening as far as I can tell is the first time the =
timer interrupt is fired, either irqs are not being disabled correctly =
or they are being re-enabled erroneously, but I can=E2=80=99t work out =
where or why.

As suggested in the porting guide I have spent some time modifying the =
irq_chip struct, adding irq_hold and irq_release members to no effect =
(though I guess that=E2=80=99s to be expected as the interrupt is using =
the percpu_devid_irq flow handler). Forcibly calling irq_mask and =
irq_unmask also has no effect. I considered that the problem may be in =
the timer code, but the troubleshooting section of the porting guide =
(and my instinct) tells me the problem is likely in the interrupt =
controller.

I=E2=80=99m not really sure where to go from here, so if anyone could =
point me in the right direction it would be much appreciated!

Thanks,

Liam=
