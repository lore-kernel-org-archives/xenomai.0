Date: Fri, 11 May 2007 15:25:58 +0200
From: "r k" <radokx@domain.hid>
Message-ID: <46446ee66e467@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="part46446ee670b88"
Subject: [Xenomai-help] realtime with mx27ads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.

--part46446ee670b88
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have purchased i.MX27ads board and I am using
imx27_ads_20070210-rel1b-ltib.iso

We have been trying to adapt real-time patch from Xenomai 2.3.1 for the
kernel 2.6.19.
The solution is based on trigger from General Purpose Timer, which lets
periodically check interrupts. Interrupts from processor are handled
without obstacles but interrupts from CPLD cause problems.
Our main modification is in file mx27ads.c (added code is in attachment)
The result was printed as low level debug info via console(also in
attachment). Our remark is that just after initialization of MMC card,
which is handled by CPLD, is invoked our function. Then our code tries
to handle interrupt no 15 port no 2 and from this moment we got
problems. Function tries to handle this interrupt twice and then fail.

Does anybody tried already to add real-time extension to i.MX27
processor (board)? Do you have somebody who could help us to modify
mx27ads.c?

**********************************************************************
*********************************************************************
Our modification in mx27ads.c file:
*****************************************************
#include <asm/arch/mx27.h>
#include <asm/arch/io.h>
//#define IO_ADDRESS(x) ((x) | MXC_GPIO_BASE)
# define __REG(x) (*((volatile u32 *)IO_ADDRESS(x)))
# define __REG2(x,y) \
( __builtin_constant_p(y) ? (__REG((x) + (y))) \
: (*(volatile u32 *)((u32)&__REG(x) + (y))) )
#define IMR(x) __REG2(GPIO_BASE_ADDR + 0x30, ((x) & 7) << 8)
#define ISR(x) __REG2(GPIO_BASE_ADDR + 0x34, ((x) & 7) << 8)
#define IRQ_GPIOA(x) (MXC_MAX_INT_LINES + x)
void __ipipe_mach_demux_irq(unsigned irq_unused, struct pt_regs *regs)
{
static int callCt =3D 0;
    struct irqdesc *desc, *desc_unused =3D irq_desc + irq_unused;
    unsigned int mask;
    unsigned int port;
    unsigned int irq_base;
    unsigned int irq =3D 0;



   // printk("we are in function __ipipe_mach_demux_irq\n");

    for (port =3D 0; port < 6; port++) {
        if (ISR(port) & IMR(port)) {
            break;
        }
    }

    mask =3D ISR(port);
    irq_base =3D IRQ_GPIOA(0) + (port * 32);

    desc =3D irq_desc + irq_base;
    while (mask) {
        if (mask & 1) {
            printk("handling irq %d (port %d) %u, %u, %p, \n", irq, port, c=
allCt++,
irq_unused, regs);
__ipipe_handle_irq(irq + irq_base, regs);
            __raw_writew((1 << irq),ISR(port));
//ISR(port) =3D (1 << irq);
        }
        irq++;
        desc++;
        mask >>=3D 1;
    }

    desc_unused->chip->unmask(irq_unused);
}

#endif /* CONFIG_IPIPE */
****************************************************




*********************************************************
Low level debug info from console:
<4>mmc0: host does not support reading read-only switch. assuming
write-enable.

mmc0: host does not support reading read-only switch. assuming
write-enable.

<6>mmcblk0: mmc0:cffc SD512 495488KiB

mmcblk0: mmc0:cffc SD512 495488KiB

<6> mmcblk0: mmcblk0: unknown partition table

 unknown partition table

handling irq 15 (port 2) 0, 8, c0543e04

handling irq 15 (port 2) 0, 8, c0543e04

irq 143, desc: c03443c0, depth: 0, count: 0, unhandled: 0

irq 143, desc: c03443c0, depth: 0, count: 0, unhandled: 0

->handle_irq(): c004564c, ->handle_irq(): c004564c,
mxc_expio_irq_handler+0x0/0x1a0

mxc_expio_irq_handler+0x0/0x1a0

->chip(): c034b754, ->chip(): c034b754, 0xc034b754

0xc034b754

->action(): 00000000

->action(): 00000000

   IRQ_NOPROBE set

   IRQ_NOPROBE set

 IRQ_NOREQUEST set

 IRQ_NOREQUEST set

<4>__ipipe_ack_bad_irq: unknown flow handler for IRQ 143

__ipipe_ack_bad_irq: unknown flow handler for IRQ 143

<1>Unable to handle kernel paging request at virtual address 00008000

Unable to handle kernel paging request at virtual address 00008000

<1>pgd =3D c0004000

pgd =3D c0004000

<1>[00008000] *pgd=3D00000000[00008000] *pgd=3D00000000


Internal error: Oops: 805 [#1]

Internal error: Oops: 805 [#1]

Modules linked in:Modules linked in:


CPU: 0

CPU: 0

PC is at __ipipe_mach_demux_irq+0xb4/0x10c

PC is at __ipipe_mach_demux_irq+0xb4/0x10c

LR is at __ipipe_handle_irq+0x1d8/0x1ec

LR is at __ipipe_handle_irq+0x1d8/0x1ec

pc : [<c0045a54>] lr : [<c003e174>] Not tainted

sp : c0543dac ip : c0543d74 fp : c0543de0

pc : [<c0045a54>] lr : [<c003e174>] Not tainted

sp : c0543dac ip : c0543d74 fp : c0543de0

r10: 00000002 r9 : c0543e04 r8 : d4015234

r10: 00000002 r9 : c0543e04 r8 : d4015234

r7 : 00000008 r6 : 0000000f r5 : 0000008f r4 : 00000000

r7 : 00000008 r6 : 0000000f r5 : 0000008f r4 : 00000000

r3 : 00008000 r2 : 00008000 r1 : 00000000 r0 : c034d1e0

r3 : 00008000 r2 : 00008000 r1 : 00000000 r0 : c034d1e0

Flags: nzcvFlags: nzcv IRQs off FIQs on Mode SVC_32 Segment kernel

  IRQs off FIQs on Mode SVC_32 Segment kernel

Control: 5317F

Control: 5317F

Table: A0004000 DAC: 00000017

Table: A0004000 DAC: 00000017

Process swapper (pid: 1, stack limit =3D 0xc0542250)

Process swapper (pid: 1, stack limit =3D 0xc0542250)

Stack: (0xc0543dac to 0xc0544000)

Stack: (0xc0543dac to 0xc0544000)

3da0: 3da0:
00000008 00000008 c0543e04 c0543e04 00000200 00000200 ffffffff ffffffff
0000ffff 0000ffff


3dc0: 3dc0: 00000008 00000008 c0543e04 c0543e04 00000000 00000000
c0542000 c0542000 c073c800 c073c800 c0543e00 c0543e00 c0543de4 c0543de4
c003e230 c003e230


3de0: 3de0: c00459b0 c00459b0 ffffffff ffffffff 0000ffff 0000ffff
00000001 00000001 c077fb40 c077fb40 c0543e5c c0543e5c c0543e04 c0543e04
c00389f0 c00389f0


3e00: 3e00: c003e198 c003e198 eb020000 eb020000 00000100 00000100
00000108 00000108 eb000000 eb000000 c0346200 c0346200 c0346200 c0346200
00000108 00000108


3e20: 3e20: c077fb40 c077fb40 00000000 00000000 c073c800 c073c800
c073c800 c073c800 c0543e5c c0543e5c c0543e4c c0543e4c c0543e4c c0543e4c
c007eb64 c007eb64


3e40: 3e40: c007eb64 c007eb64 80000013 80000013 ffffffff ffffffff
00000000 00000000 c0543e6c c0543e6c c0543e60 c0543e60 c007ebcc c007ebcc
c007eb54 c007eb54


3e60: 3e60: c0543e90 c0543e90 c0543e70 c0543e70 c007e030 c007e030
c007ebbc c007ebbc c077fb40 c077fb40 fffffff4 fffffff4 00000000 00000000
c01cabc0 c01cabc0


3e80: 3e80: 00000000 00000000 c0543ebc c0543ebc c0543e94 c0543e94
c007e1ec c007e1ec c007deec c007deec c073c800 c073c800 00001003 00001003
c073ca60 c073ca60


3ea0: 3ea0: 00001002 00001002 c0037b5c c0037b5c 00000000 00000000
00000000 00000000 c0543edc c0543edc c0543ec0 c0543ec0 c01cb320 c01cb320
c007e16c c007e16c


3ec0: 3ec0: c073c800 c073c800 c073c800 c073c800 00001003 00001003
00001002 00001002 c0543ef0 c0543ef0 c0543ee0 c0543ee0 c0268ec0 c0268ec0
c01cb26c c01cb26c


3ee0: 3ee0: c073c800 c073c800 c0543f10 c0543f10 c0543ef4 c0543ef4
c0266fa4 c0266fa4 c0268e74 c0268e74 c035bed4 c035bed4 c073c800 c073c800
00000001 00000001


3f00: 3f00: 00001002 00001002 c0543fac c0543fac c0543f14 c0543f14
c001ea70 c001ea70 c0266f58 c0266f58 00000000 00000000 00000000 00000000
00000000 00000000


3f20: 3f20: c0543f9c c0543f9c c0543f30 c0543f30 c0039ba4 c0039ba4
c0055794 c0055794 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000


3f40: 3f40: c0212590 c0212590 c005a674 c005a674 c0020dc4 c0020dc4
c0020908 c0020908 c0542000 c0542000 00000001 00000001 c0543f80 c0543f80
c0543f68 c0543f68


3f60: 3f60: c02a12e8 c02a12e8 c01740ec c01740ec c031d220 c031d220
c03504a0 c03504a0 c03504a0 c03504a0 c0543f9c c0543f9c c0543f84 c0543f84
c02a143c c02a143c


3f80: 3f80: c02e5d9c c02e5d9c c0020dc4 c0020dc4 c0020910 c0020910
c0542000 c0542000 00000001 00000001 00000000 00000000 00000000 00000000
00000000 00000000


3fa0: 3fa0: c0543ff4 c0543ff4 c0543fb0 c0543fb0 c00380cc c00380cc
c001e920 c001e920 00000000 00000000 00000000 00000000 c003802c c003802c
c005a674 c005a674


3fc0: 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000


3fe0: 3fe0: 00000000 00000000 00000000 00000000 00000000 00000000
c0543ff8 c0543ff8 c005a674 c005a674 c003803c c003803c c027d4d8 c027d4d8
c027d644 c027d644


Backtrace: Backtrace:


[<c00459a0>] [<c00459a0>] (__ipipe_mach_demux_irq+0x0/0x10c)
(__ipipe_mach_demux_irq+0x0/0x10c) from [<c003e230>] from [<c003e230>]
(__ipipe_grab_irq+0xa8/0xf8)

(__ipipe_grab_irq+0xa8/0xf8)

[<c003e188>] [<c003e188>] (__ipipe_grab_irq+0x0/0xf8)
(__ipipe_grab_irq+0x0/0xf8) from [<c00389f0>] from [<c00389f0>]
(__irq_svc+0x30/0x88)

(__irq_svc+0x30/0x88)

 r7 =3D C077FB40 r7 =3D C077FB40 r6 =3D 00000001 r6 =3D 00000001 r5 =3D
0000FFFF r5 =3D 0000FFFF r4 =3D FFFFFFFF

 r4 =3D FFFFFFFF

[<c007eb44>] [<c007eb44>] (default_enable+0x0/0x34)
(default_enable+0x0/0x34) from [<c007ebcc>] from [<c007ebcc>]
(default_startup+0x20/0x2c)

(default_startup+0x20/0x2c)

 r4 =3D 00000000 r4 =3D 00000000


[<c007ebac>] [<c007ebac>] (default_startup+0x0/0x2c)
(default_startup+0x0/0x2c) from [<c007e030>] from [<c007e030>]
(setup_irq+0x154/0x280)

(setup_irq+0x154/0x280)

[<c007dedc>] [<c007dedc>] (setup_irq+0x0/0x280) (setup_irq+0x0/0x280)
from [<c007e1ec>] from [<c007e1ec>] (request_irq+0x90/0xb8)

(request_irq+0x90/0xb8)

 r8 =3D 00000000 r8 =3D 00000000 r7 =3D C01CABC0 r7 =3D C01CABC0 r6 =3D
00000000 r6 =3D 00000000 r5 =3D FFFFFFF4

 r5 =3D FFFFFFF4

 r4 =3D C077FB40 r4 =3D C077FB40


[<c007e15c>] [<c007e15c>] (request_irq+0x0/0xb8) (request_irq+0x0/0xb8)
from [<c01cb320>] from [<c01cb320>] (net_open+0xc4/0x4e0)

(net_open+0xc4/0x4e0)

[<c01cb25c>] [<c01cb25c>] (net_open+0x0/0x4e0) (net_open+0x0/0x4e0) from
[<c0268ec0>] from [<c0268ec0>] (dev_open+0x5c/0xc0)

(dev_open+0x5c/0xc0)

 r6 =3D 00001002 r6 =3D 00001002 r5 =3D 00001003 r5 =3D 00001003 r4 =3D
C073C800 r4 =3D C073C800


[<c0268e64>] [<c0268e64>] (dev_open+0x0/0xc0) (dev_open+0x0/0xc0) from
[<c0266fa4>] from [<c0266fa4>] (dev_change_flags+0x5c/0x130)

(dev_change_flags+0x5c/0x130)

 r4 =3D C073C800 r4 =3D C073C800


[<c0266f48>] [<c0266f48>] (dev_change_flags+0x0/0x130)
(dev_change_flags+0x0/0x130) from [<c001ea70>] from [<c001ea70>]
(ip_auto_config+0x160/0xe78)

(ip_auto_config+0x160/0xe78)

 r7 =3D 00001002 r7 =3D 00001002 r6 =3D 00000001 r6 =3D 00000001 r5 =3D
C073C800 r5 =3D C073C800 r4 =3D C035BED4

 r4 =3D C035BED4

[<c001e910>] [<c001e910>] (ip_auto_config+0x0/0xe78)
(ip_auto_config+0x0/0xe78) from [<c00380cc>] from [<c00380cc>]
(init+0xa0/0x280)

(init+0xa0/0x280)

[<c003802c>] [<c003802c>] (init+0x0/0x280) (init+0x0/0x280) from
[<c005a674>] from [<c005a674>] (do_exit+0x0/0xb3c)

(do_exit+0x0/0xb3c)

 r7 =3D 00000000 r7 =3D 00000000 r6 =3D 00000000 r6 =3D 00000000 r5 =3D
00000000 r5 =3D 00000000 r4 =3D 00000000

 r4 =3D 00000000

Code: Code: e3a03801 e3a03801 e1a03613 e1a03613 e5982000 e5982000
e1a03823 e1a03823 (e1c230b0) (e1c230b0)


  handling irq 15 (port 2) 1, 8, c0543ba4

handling irq 15 (port 2) 1, 8, c0543ba4

irq 143, desc: c03443c0, depth: 0, count: 0, unhandled: 0

irq 143, desc: c03443c0, depth: 0, count: 0, unhandled: 0

->handle_irq(): c004564c, ->handle_irq(): c004564c,
mxc_expio_irq_handler+0x0/0x1a0

mxc_expio_irq_handler+0x0/0x1a0

->chip(): c034b754, ->chip(): c034b754, 0xc034b754

0xc034b754

->action(): 00000000

->action(): 00000000

   IRQ_NOPROBE set

   IRQ_NOPROBE set

 IRQ_NOREQUEST set

 IRQ_NOREQUEST set

<1>Unable to handle kernel paging request at virtual address 00008000

Unable to handle kernel paging request at virtual address 00008000

<1>pgd =3D c0004000

pgd =3D c0004000

<1>[00008000] *pgd=3D00000000[00008000] *pgd=3D00000000


Internal error: Oops: 805 [#2]

Internal error: Oops: 805 [#2]

Modules linked in:Modules linked in:


CPU: 0

CPU: 0

PC is at __ipipe_mach_demux_irq+0xb4/0x10c

PC is at __ipipe_mach_demux_irq+0xb4/0x10c

LR is at __ipipe_handle_irq+0x1d8/0x1ec

LR is at __ipipe_handle_irq+0x1d8/0x1ec

pc : [<c0045a54>] lr : [<c003e174>] Not tainted

sp : c0543b4c ip : c0543b14 fp : c0543b80

pc : [<c0045a54>] lr : [<c003e174>] Not tainted

sp : c0543b4c ip : c0543b14 fp : c0543b80

r10: 00000002 r9 : c0543ba4 r8 : d4015234

r10: 00000002 r9 : c0543ba4 r8 : d4015234

r7 : 00000008 r6 : 0000000f r5 : 0000008f r4 : 00000000

r7 : 00000008 r6 : 0000000f r5 : 0000008f r4 : 00000000

r3 : 00008000 r2 : 00008000 r1 : 00000000 r0 : c034d1e0

r3 : 00008000 r2 : 00008000 r1 : 00000000 r0 : c034d1e0

Flags: nzcvFlags: nzcv IRQs off FIQs on Mode SVC_32 Segment kernel

  IRQs off FIQs on Mode SVC_32 Segment kernel

Control: 5317F

Control: 5317F

Table: A0004000 DAC: 00000017

Table: A0004000 DAC: 00000017

Process swapper (pid: 1, stack limit =3D 0xc0542250)

Process swapper (pid: 1, stack limit =3D 0xc0542250)

Stack: (0xc0543b4c to 0xc0544000)

Stack: (0xc0543b4c to 0xc0544000)

3b40: 3b40:
00000008 00000008 c0543ba4 c0543ba4 00000200 00000200 ffffffff ffffffff
0000ffff 0000ffff


3b60: 3b60: 00000008 00000008 c0543ba4 c0543ba4 c034d1ec c034d1ec
c0542000 c0542000 ffffffff ffffffff c0543ba0 c0543ba0 c0543b84 c0543b84
c003e230 c003e230


3b80: 3b80: c00459b0 c00459b0 ffffffff ffffffff 0000ffff 0000ffff
00000001 00000001 c034d1f8 c034d1f8 c0543c14 c0543c14 c0543ba4 c0543ba4
c00389f0 c00389f0


3ba0: 3ba0: c003e198 c003e198 0000008f 0000008f 0000000f 0000000f
00000001 00000001 80000013 80000013 c034d1e8 c034d1e8 c034d1e0 c034d1e0
00000004 00000004


3bc0: 3bc0: c034d1f8 c034d1f8 c034d1ec c034d1ec ffffffef ffffffef
ffffffff ffffffff c0543c14 c0543c14 00000000 00000000 c0543bec c0543bec
c034d200 c034d200


3be0: 3be0: c008074c c008074c 80000013 80000013 ffffffff ffffffff
c034d1e0 c034d1e0 c03504a0 c03504a0 c0045a54 c0045a54 00000000 00000000
00000008 00000008


3c00: 3c00: 00000000 00000000 c0543d64 c0543d64 c0543c24 c0543c24
c0543c18 c0543c18 c0080e88 c0080e88 c00805dc c00805dc c0543c38 c0543c38
c0543c28 c0543c28


3c20: 3c20: c003d264 c003d264 c0080e58 c0080e58 00000000 00000000
c0543c58 c0543c58 c0543c3c c0543c3c c003f468 c003f468 c003cf58 c003cf58
ffffffff ffffffff


3c40: 3c40: 00008000 00008000 c0543d64 c0543d64 c0541be0 c0541be0
c0543c90 c0543c90 c0543c5c c0543c5c c003f6e0 c003f6e0 c003f40c c003f40c
00003073 00003073


3c60: 3c60: c034b878 c034b878 00000805 00000805 ffffffff ffffffff
00008000 00008000 c0543d64 c0543d64 00000805 00000805 c03487a8 c03487a8
00008000 00008000


3c80: 3c80: c0543d64 c0543d64 c0543cb0 c0543cb0 c0543c94 c0543c94
c003f7b8 c003f7b8 c003f488 c003f488 ffffffff ffffffff c0543d98 c0543d98
0000000f 0000000f


3ca0: 3ca0: 00000805 00000805 c0543d60 c0543d60 c0543cb4 c0543cb4
c003f8f4 c003f8f4 c003f7a4 c003f7a4 c0057b50 c0057b50 c00510d0 c00510d0
00002f59 00002f59


3cc0: 3cc0: c034b878 c034b878 00002f59 00002f59 c0543cec c0543cec
c0543cd8 c0543cd8 c0543cec c0543cec c03443c0 c03443c0 0000008f 0000008f
00000004 00000004


3ce0: 3ce0: c03d3b80 c03d3b80 00000000 00000000 c0543d18 c0543d18
c0543cf8 c0543cf8 c0057c6c c0057c6c 0000008f 0000008f c03d3afc c03d3afc
00000004 00000004


3d00: 3d00: c03d3b80 c03d3b80 00000000 00000000 c0543d38 c0543d38
c0543d18 c0543d18 c0057c6c c0057c6c c00577c4 c00577c4 c0543d40 c0543d40
0000008f 0000008f


3d20: 3d20: c03d3afc c03d3afc 00000004 00000004 c03d3b80 c03d3b80
c0543d60 c0543d60 c0543d4c c0543d4c c007ed84 c007ed84 ffffffff ffffffff
c0543d98 c0543d98


3d40: 3d40: 0000000f 0000000f 00000008 00000008 d4015234 d4015234
00000093 00000093 00000002 00000002 c0543de0 c0543de0 c0543d64 c0543d64
c00389a0 c00389a0


3d60: 3d60: c003f8c8 c003f8c8 c034d1e0 c034d1e0 00000000 00000000
00008000 00008000 00008000 00008000 00000000 00000000 0000008f 0000008f
0000000f 0000000f


3d80: 3d80: 00000008 00000008 d4015234 d4015234 c0543e04 c0543e04
00000002 00000002 c0543de0 c0543de0 c0543d74 c0543d74 c0543dac c0543dac
c003e174 c003e174


3da0: 3da0: c0045a54 c0045a54 00000093 00000093 ffffffff ffffffff
00000008 00000008 c0543e04 c0543e04 00000200 00000200 ffffffff ffffffff
0000ffff 0000ffff


3dc0: 3dc0: 00000008 00000008 c0543e04 c0543e04 00000000 00000000
c0542000 c0542000 c073c800 c073c800 c0543e00 c0543e00 c0543de4 c0543de4
c003e230 c003e230


3de0: 3de0: c00459b0 c00459b0 ffffffff ffffffff 0000ffff 0000ffff
00000001 00000001 c077fb40 c077fb40 c0543e5c c0543e5c c0543e04 c0543e04
c00389f0 c00389f0


3e00: 3e00: c003e198 c003e198 eb020000 eb020000 00000100 00000100
00000108 00000108 eb000000 eb000000 c0346200 c0346200 c0346200 c0346200
00000108 00000108


3e20: 3e20: c077fb40 c077fb40 00000000 00000000 c073c800 c073c800
c073c800 c073c800 c0543e5c c0543e5c c0543e4c c0543e4c c0543e4c c0543e4c
c007eb64 c007eb64


3e40: 3e40: c007eb64 c007eb64 80000013 80000013 ffffffff ffffffff
00000000 00000000 c0543e6c c0543e6c c0543e60 c0543e60 c007ebcc c007ebcc
c007eb54 c007eb54


3e60: 3e60: c0543e90 c0543e90 c0543e70 c0543e70 c007e030 c007e030
c007ebbc c007ebbc c077fb40 c077fb40 fffffff4 fffffff4 00000000 00000000
c01cabc0 c01cabc0


3e80: 3e80: 00000000 00000000 c0543ebc c0543ebc c0543e94 c0543e94
c007e1ec c007e1ec c007deec c007deec c073c800 c073c800 00001003 00001003
c073ca60 c073ca60


3ea0: 3ea0: 00001002 00001002 c0037b5c c0037b5c 00000000 00000000
00000000 00000000 c0543edc c0543edc c0543ec0 c0543ec0 c01cb320 c01cb320
c007e16c c007e16c


3ec0: 3ec0: c073c800 c073c800 c073c800 c073c800 00001003 00001003
00001002 00001002 c0543ef0 c0543ef0 c0543ee0 c0543ee0 c0268ec0 c0268ec0
c01cb26c c01cb26c


3ee0: 3ee0: c073c800 c073c800 c0543f10 c0543f10 c0543ef4 c0543ef4
c0266fa4 c0266fa4 c0268e74 c0268e74 c035bed4 c035bed4 c073c800 c073c800
00000001 00000001


3f00: 3f00: 00001002 00001002 c0543fac c0543fac c0543f14 c0543f14
c001ea70 c001ea70 c0266f58 c0266f58 00000000 00000000 00000000 00000000
00000000 00000000


3f20: 3f20: c0543f9c c0543f9c c0543f30 c0543f30 c0039ba4 c0039ba4
c0055794 c0055794 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000


3f40: 3f40: c0212590 c0212590 c005a674 c005a674 c0020dc4 c0020dc4
c0020908 c0020908 c0542000 c0542000 00000001 00000001 c0543f80 c0543f80
c0543f68 c0543f68


3f60: 3f60: c02a12e8 c02a12e8 c01740ec c01740ec c031d220 c031d220
c03504a0 c03504a0 c03504a0 c03504a0 c0543f9c c0543f9c c0543f84 c0543f84
c02a143c c02a143c


3f80: 3f80: c02e5d9c c02e5d9c c0020dc4 c0020dc4 c0020910 c0020910
c0542000 c0542000 00000001 00000001 00000000 00000000 00000000 00000000
00000000 00000000


3fa0: 3fa0: c0543ff4 c0543ff4 c0543fb0 c0543fb0 c00380cc c00380cc
c001e920 c001e920 00000000 00000000 00000000 00000000 c003802c c003802c
c005a674 c005a674


3fc0: 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000


3fe0: 3fe0: 00000000 00000000 00000000 00000000 00000000 00000000
c0543ff8 c0543ff8 c005a674 c005a674 c003803c c003803c c027d4d8 c027d4d8
c027d644 c027d644


Backtrace: Backtrace:


[<c00459a0>] [<c00459a0>] (__ipipe_mach_demux_irq+0x0/0x10c)
(__ipipe_mach_demux_irq+0x0/0x10c) from [<c003e230>] from [<c003e230>]
(__ipipe_grab_irq+0xa8/0xf8)

(__ipipe_grab_irq+0xa8/0xf8)

[<c003e188>] [<c003e188>] (__ipipe_grab_irq+0x0/0xf8)
(__ipipe_grab_irq+0x0/0xf8) from [<c00389f0>] from [<c00389f0>]
(__irq_svc+0x30/0x88)

(__irq_svc+0x30/0x88)

 r7 =3D C034D1F8 r7 =3D C034D1F8 r6 =3D 00000001 r6 =3D 00000001 r5 =3D
0000FFFF r5 =3D 0000FFFF r4 =3D FFFFFFFF

 r4 =3D FFFFFFFF

[<c00805cc>] [<c00805cc>] (__ipipe_sync_stage+0x0/0x240)
(__ipipe_sync_stage+0x0/0x240) from [<c0080e88>] from [<c0080e88>]
(__ipipe_unstall_root+0x40/0x58)

(__ipipe_unstall_root+0x40/0x58)

[<c0080e48>] [<c0080e48>] (__ipipe_unstall_root+0x0/0x58)
(__ipipe_unstall_root+0x0/0x58) from [<c003d264>] from [<c003d264>]
(die+0x31c/0x410)

(die+0x31c/0x410)

[<c003cf48>] [<c003cf48>] (die+0x0/0x410) (die+0x0/0x410) from
[<c003f468>] from [<c003f468>] (__do_kernel_fault+0x6c/0x7c)

(__do_kernel_fault+0x6c/0x7c)

[<c003f3fc>] [<c003f3fc>] (__do_kernel_fault+0x0/0x7c)
(__do_kernel_fault+0x0/0x7c) from [<c003f6e0>] from [<c003f6e0>]
(do_page_fault+0x268/0x2a0)

(do_page_fault+0x268/0x2a0)

 r7 =3D C0541BE0 r7 =3D C0541BE0 r6 =3D C0543D64 r6 =3D C0543D64 r5 =3D
00008000 r5 =3D 00008000 r4 =3D FFFFFFFF

 r4 =3D FFFFFFFF

[<c003f478>] [<c003f478>] (do_page_fault+0x0/0x2a0)
(do_page_fault+0x0/0x2a0) from [<c003f7b8>] from [<c003f7b8>]
(do_translation_fault+0x24/0x108)

(do_translation_fault+0x24/0x108)

[<c003f794>] [<c003f794>] (do_translation_fault+0x0/0x108)
(do_translation_fault+0x0/0x108) from [<c003f8f4>] from [<c003f8f4>]
(do_DataAbort+0x3c/0x11c)

(do_DataAbort+0x3c/0x11c)

 r7 =3D 00000805 r7 =3D 00000805 r6 =3D 0000000F r6 =3D 0000000F r5 =3D
C0543D98 r5 =3D C0543D98 r4 =3D FFFFFFFF

 r4 =3D FFFFFFFF

[<c003f8b8>] [<c003f8b8>] (do_DataAbort+0x0/0x11c)
(do_DataAbort+0x0/0x11c) from [<c00389a0>] from [<c00389a0>]
(__dabt_svc+0x40/0x60)

(__dabt_svc+0x40/0x60)

[<c00459a0>] [<c00459a0>] (__ipipe_mach_demux_irq+0x0/0x10c)
(__ipipe_mach_demux_irq+0x0/0x10c) from [<c003e230>] from [<c003e230>]
(__ipipe_grab_irq+0xa8/0xf8)

(__ipipe_grab_irq+0xa8/0xf8)

[<c003e188>] [<c003e188>] (__ipipe_grab_irq+0x0/0xf8)
(__ipipe_grab_irq+0x0/0xf8) from [<c00389f0>] from [<c00389f0>]
(__irq_svc+0x30/0x88)

(__irq_svc+0x30/0x88)

 r7 =3D C077FB40 r7 =3D C077FB40 r6 =3D 00000001 r6 =3D 00000001 r5 =3D
0000FFFF r5 =3D 0000FFFF r4 =3D FFFFFFFF

 r4 =3D FFFFFFFF

[<c007eb44>] [<c007eb44>] (default_enable+0x0/0x34)
(default_enable+0x0/0x34) from [<c007ebcc>] from [<c007ebcc>]
(default_startup+0x20/0x2c)

(default_startup+0x20/0x2c)

 r4 =3D 00000000 r4 =3D 00000000


[<c007ebac>] [<c007ebac>] (default_startup+0x0/0x2c)
(default_startup+0x0/0x2c) from [<c007e030>] from [<c007e030>]
(setup_irq+0x154/0x280)

(setup_irq+0x154/0x280)

[<c007dedc>] [<c007dedc>] (setup_irq+0x0/0x280) (setup_irq+0x0/0x280)
from [<c007e1ec>] from [<c007e1ec>] (request_irq+0x90/0xb8)

(request_irq+0x90/0xb8)

 r8 =3D 00000000 r8 =3D 00000000 r7 =3D C01CABC0 r7 =3D C01CABC0 r6 =3D
00000000 r6 =3D 00000000 r5 =3D FFFFFFF4

 r5 =3D FFFFFFF4

 r4 =3D C077FB40 r4 =3D C077FB40


[<c007e15c>] [<c007e15c>] (request_irq+0x0/0xb8) (request_irq+0x0/0xb8)
from [<c01cb320>] from [<c01cb320>] (net_open+0xc4/0x4e0)

(net_open+0xc4/0x4e0)

[<c01cb25c>] [<c01cb25c>] (net_open+0x0/0x4e0) (net_open+0x0/0x4e0) from
[<c0268ec0>] from [<c0268ec0>] (dev_open+0x5c/0xc0)

(dev_open+0x5c/0xc0)

 r6 =3D 00001002 r6 =3D 00001002 r5 =3D 00001003 r5 =3D 00001003 r4 =3D
C073C800 r4 =3D C073C800


[<c0268e64>] [<c0268e64>] (dev_open+0x0/0xc0) (dev_open+0x0/0xc0) from
[<c0266fa4>] from [<c0266fa4>] (dev_change_flags+0x5c/0x130)

(dev_change_flags+0x5c/0x130)

 r4 =3D C073C800 r4 =3D C073C800


[<c0266f48>] [<c0266f48>] (dev_change_flags+0x0/0x130)
(dev_change_flags+0x0/0x130) from [<c001ea70>] from [<c001ea70>]
(ip_auto_config+0x160/0xe78)

(ip_auto_config+0x160/0xe78)

 r7 =3D 00001002 r7 =3D 00001002 r6 =3D 00000001 r6 =3D 00000001 r5 =3D
C073C800 r5 =3D C073C800 r4 =3D C035BED4

 r4 =3D C035BED4

[<c001e910>] [<c001e910>] (ip_auto_config+0x0/0xe78)
(ip_auto_config+0x0/0xe78) from [<c00380cc>] from [<c00380cc>]
(init+0xa0/0x280)

(init+0xa0/0x280)

[<c003802c>] [<c003802c>] (init+0x0/0x280) (init+0x0/0x280) from
[<c005a674>] from [<c005a674>] (do_exit+0x0/0xb3c)

(do_exit+0x0/0xb3c)

 r7 =3D 00000000 r7 =3D 00000000 r6 =3D 00000000 r6 =3D 00000000 r5 =3D
00000000 r5 =3D 00000000 r4 =3D 00000000

 r4 =3D 00000000

Code: Code: e3a03801 e3a03801 e1a03613 e1a03613 e5982000 e5982000
e1a03823 e1a03823 (e1c230b0) (e1c230b0)


  handling irq 15 (port 2) 2, 8, c0543970

handling irq 15 (port 2) 2, 8, c0543970

handling irq 15 (port 2) 3, 8, c0543820

handling irq 15 (port 2) 3, 8, c0543820

handling irq 15 (port 2) 4, 8, c05436d0

handling irq 15 (port 2) 4, 8, c05436d0

handling irq 15 (port 2) 5, 8, c0543580

handling irq 15 (port 2) 5, 8, c0543580

handling irq 15 (port 2) 6, 8, c0543430

handling irq 15 (port 2) 6, 8, c0543430

handling irq 15 (port 2) 7, 8, c05432e0

handling irq 15 (port 2) 7, 8, c05432e0

handling irq 15 (port 2) 8, 8, c0543190

handling irq 15 (port 2) 8, 8, c0543190

handling irq 15 (port 2) 9, 8, c0543040

handling irq 15 (port 2) 9, 8, c0543040

handling irq 15 (port 2) 10, 8, c0542ef0

handling irq 15 (port 2) 10, 8, c0542ef0

handling irq 15 (port 2) 11, 8, c0542da0

handling irq 15 (port 2) 11, 8, c0542da0

handling irq 15 (port 2) 12, 8, c0542c50

handling irq 15 (port 2) 12, 8, c0542c50

handling irq 15 (port 2) 13, 8, c0542b00

handling irq 15 (port 2) 13, 8, c0542b00

handling irq 15 (port 2) 14, 8, c05429b0

handling irq 15 (port 2) 14, 8, c05429b0

handling irq 15 (port 2) 15, 8, c0542860

handling irq 15 (port 2) 15, 8, c0542860

handling irq 15 (port 2) 16, 8, c0542710

handling irq 15 (port 2) 16, 8, c0542710

handling irq 15 (port 2) 17, 8, c05425c0

handling irq 15 (port 2) 17, 8, c05425c0

handling irq 15 (port 2) 18, 8, c0542470

handling irq 15 (port 2) 18, 8, c0542470

handling irq 15 (port 2) 19, 8, c0542320

handling irq 15 (port 2) 19, 8, c0542320

handling irq 15 (port 2) 20, 8, c05421d0

handling irq 15 (port 2) 20, 8, c05421d0

----------------------------------------------------
INFERNAL: "From Paris to Berlin"=20
Pot=EA=BFna dawka hit=F3w! CD+DVD ju=BF w sklepach!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Finfernal.htm=
l&sid=3D1138

--part46446ee670b88
Content-Type: text/plain; name="CodeLogf.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="CodeLogf.txt"

T3VyIG1vZGlmaWNhdGlvbiBpbiBteDI3YWRzLmMgZmlsZToKKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKI2luY2x1ZGUgPGFzbS9hcmNoL214Mjcu
aD4KI2luY2x1ZGUgPGFzbS9hcmNoL2lvLmg+Ci8vI2RlZmluZSBJT19BRERSRVNTKHgpICgoeCkg
fCBNWENfR1BJT19CQVNFKQojIGRlZmluZSBfX1JFRyh4KSAgICAgICAgKCooKHZvbGF0aWxlIHUz
MiAqKUlPX0FERFJFU1MoeCkpKQojIGRlZmluZSBfX1JFRzIoeCx5KQlcCgkoIF9fYnVpbHRpbl9j
b25zdGFudF9wKHkpID8gKF9fUkVHKCh4KSArICh5KSkpIFwKCQkJICA6ICgqKHZvbGF0aWxlIHUz
MiAqKSgodTMyKSZfX1JFRyh4KSArICh5KSkpICkKI2RlZmluZSBJTVIoeCkgICAgIF9fUkVHMihH
UElPX0JBU0VfQUREUiAgKyAweDMwLCAoKHgpICYgNykgPDwgOCkKI2RlZmluZSBJU1IoeCkgICAg
IF9fUkVHMihHUElPX0JBU0VfQUREUiAgKyAweDM0LCAoKHgpICYgNykgPDwgOCkKI2RlZmluZSBJ
UlFfR1BJT0EoeCkgIChNWENfTUFYX0lOVF9MSU5FUyArIHgpCnZvaWQgX19pcGlwZV9tYWNoX2Rl
bXV4X2lycSh1bnNpZ25lZCBpcnFfdW51c2VkLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKewoJc3Rh
dGljIGludCBjYWxsQ3QgPSAwOwogICAgc3RydWN0IGlycWRlc2MgKmRlc2MsICpkZXNjX3VudXNl
ZCA9IGlycV9kZXNjICsgaXJxX3VudXNlZDsKICAgIHVuc2lnbmVkIGludCBtYXNrOwogICAgdW5z
aWduZWQgaW50IHBvcnQ7CiAgICB1bnNpZ25lZCBpbnQgaXJxX2Jhc2U7CiAgICB1bnNpZ25lZCBp
bnQgaXJxID0gMDsKCgoKICAgLy8gcHJpbnRrKCJ3ZSBhcmUgaW4gZnVuY3Rpb24gX19pcGlwZV9t
YWNoX2RlbXV4X2lycVxuIik7CgogICAgZm9yIChwb3J0ID0gMDsgcG9ydCA8IDY7IHBvcnQrKykg
ewogICAgICAgIGlmIChJU1IocG9ydCkgJiBJTVIocG9ydCkpIHsKICAgICAgICAgICAgYnJlYWs7
CiAgICAgICAgfQogICAgfQoKICAgIG1hc2sgPSBJU1IocG9ydCk7CiAgICBpcnFfYmFzZSA9IElS
UV9HUElPQSgwKSArIChwb3J0ICogMzIpOwoKICAgIGRlc2MgPSBpcnFfZGVzYyArIGlycV9iYXNl
OwogICAgd2hpbGUgKG1hc2spIHsKICAgICAgICBpZiAobWFzayAmIDEpIHsKICAgICAgICAgICAg
cHJpbnRrKCJoYW5kbGluZyBpcnEgJWQgKHBvcnQgJWQpICV1LCAldSwgJXAsIFxuIiwgaXJxLCBw
b3J0LCBjYWxsQ3QrKywgaXJxX3VudXNlZCwgcmVncyk7CgkgICAgX19pcGlwZV9oYW5kbGVfaXJx
KGlycSArIGlycV9iYXNlLCByZWdzKTsJICAgIAogICAgICAgICAgICBfX3Jhd193cml0ZXcoKDEg
PDwgaXJxKSxJU1IocG9ydCkpOwovL0lTUihwb3J0KSA9ICgxIDw8IGlycSk7CiAgICAgICAgfQog
ICAgICAgIGlycSsrOwogICAgICAgIGRlc2MrKzsKICAgICAgICBtYXNrID4+PSAxOwogICAgfQoK
ICAgIGRlc2NfdW51c2VkLT5jaGlwLT51bm1hc2soaXJxX3VudXNlZCk7Cn0KCiNlbmRpZiAvKiBD
T05GSUdfSVBJUEUgKi8KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKgoKCgoKKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqCkxvdyBsZXZlbCBkZWJ1ZyBpbmZvIGZyb20gY29uc29sZToKPDQ+bW1j
MDogaG9zdCBkb2VzIG5vdCBzdXBwb3J0IHJlYWRpbmcgcmVhZC1vbmx5IHN3aXRjaC4gYXNzdW1p
bmcgd3JpdGUtZW5hYmxlLgoKbW1jMDogaG9zdCBkb2VzIG5vdCBzdXBwb3J0IHJlYWRpbmcgcmVh
ZC1vbmx5IHN3aXRjaC4gYXNzdW1pbmcgd3JpdGUtZW5hYmxlLgoKPDY+bW1jYmxrMDogbW1jMDpj
ZmZjIFNENTEyIDQ5NTQ4OEtpQiAKCm1tY2JsazA6IG1tYzA6Y2ZmYyBTRDUxMiA0OTU0ODhLaUIg
Cgo8Nj4gbW1jYmxrMDogbW1jYmxrMDogdW5rbm93biBwYXJ0aXRpb24gdGFibGUKCiB1bmtub3du
IHBhcnRpdGlvbiB0YWJsZQoKaGFuZGxpbmcgaXJxIDE1IChwb3J0IDIpIDAsIDgsIGMwNTQzZTA0
CgpoYW5kbGluZyBpcnEgMTUgKHBvcnQgMikgMCwgOCwgYzA1NDNlMDQKCmlycSAxNDMsIGRlc2M6
IGMwMzQ0M2MwLCBkZXB0aDogMCwgY291bnQ6IDAsIHVuaGFuZGxlZDogMAoKaXJxIDE0MywgZGVz
YzogYzAzNDQzYzAsIGRlcHRoOiAwLCBjb3VudDogMCwgdW5oYW5kbGVkOiAwCgotPmhhbmRsZV9p
cnEoKTogIGMwMDQ1NjRjLCAtPmhhbmRsZV9pcnEoKTogIGMwMDQ1NjRjLCBteGNfZXhwaW9faXJx
X2hhbmRsZXIrMHgwLzB4MWEwCgpteGNfZXhwaW9faXJxX2hhbmRsZXIrMHgwLzB4MWEwCgotPmNo
aXAoKTogYzAzNGI3NTQsIC0+Y2hpcCgpOiBjMDM0Yjc1NCwgMHhjMDM0Yjc1NAoKMHhjMDM0Yjc1
NAoKLT5hY3Rpb24oKTogMDAwMDAwMDAKCi0+YWN0aW9uKCk6IDAwMDAwMDAwCgogICBJUlFfTk9Q
Uk9CRSBzZXQKCiAgIElSUV9OT1BST0JFIHNldAoKIElSUV9OT1JFUVVFU1Qgc2V0CgogSVJRX05P
UkVRVUVTVCBzZXQKCjw0Pl9faXBpcGVfYWNrX2JhZF9pcnE6IHVua25vd24gZmxvdyBoYW5kbGVy
IGZvciBJUlEgMTQzCgpfX2lwaXBlX2Fja19iYWRfaXJxOiB1bmtub3duIGZsb3cgaGFuZGxlciBm
b3IgSVJRIDE0MwoKPDE+VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQg
dmlydHVhbCBhZGRyZXNzIDAwMDA4MDAwCgpVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcg
cmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDgwMDAKCjwxPnBnZCA9IGMwMDA0MDAwCgpw
Z2QgPSBjMDAwNDAwMAoKPDE+WzAwMDA4MDAwXSAqcGdkPTAwMDAwMDAwWzAwMDA4MDAwXSAqcGdk
PTAwMDAwMDAwCgoKSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDgwNSBbIzFdCgpJbnRlcm5hbCBlcnJv
cjogT29wczogODA1IFsjMV0KCk1vZHVsZXMgbGlua2VkIGluOk1vZHVsZXMgbGlua2VkIGluOgoK
CkNQVTogMAoKQ1BVOiAwCgpQQyBpcyBhdCBfX2lwaXBlX21hY2hfZGVtdXhfaXJxKzB4YjQvMHgx
MGMKClBDIGlzIGF0IF9faXBpcGVfbWFjaF9kZW11eF9pcnErMHhiNC8weDEwYwoKTFIgaXMgYXQg
X19pcGlwZV9oYW5kbGVfaXJxKzB4MWQ4LzB4MWVjCgpMUiBpcyBhdCBfX2lwaXBlX2hhbmRsZV9p
cnErMHgxZDgvMHgxZWMKCnBjIDogWzxjMDA0NWE1ND5dICAgIGxyIDogWzxjMDAzZTE3ND5dICAg
IE5vdCB0YWludGVkCgpzcCA6IGMwNTQzZGFjICBpcCA6IGMwNTQzZDc0ICBmcCA6IGMwNTQzZGUw
CgpwYyA6IFs8YzAwNDVhNTQ+XSAgICBsciA6IFs8YzAwM2UxNzQ+XSAgICBOb3QgdGFpbnRlZAoK
c3AgOiBjMDU0M2RhYyAgaXAgOiBjMDU0M2Q3NCAgZnAgOiBjMDU0M2RlMAoKcjEwOiAwMDAwMDAw
MiAgcjkgOiBjMDU0M2UwNCAgcjggOiBkNDAxNTIzNAoKcjEwOiAwMDAwMDAwMiAgcjkgOiBjMDU0
M2UwNCAgcjggOiBkNDAxNTIzNAoKcjcgOiAwMDAwMDAwOCAgcjYgOiAwMDAwMDAwZiAgcjUgOiAw
MDAwMDA4ZiAgcjQgOiAwMDAwMDAwMAoKcjcgOiAwMDAwMDAwOCAgcjYgOiAwMDAwMDAwZiAgcjUg
OiAwMDAwMDA4ZiAgcjQgOiAwMDAwMDAwMAoKcjMgOiAwMDAwODAwMCAgcjIgOiAwMDAwODAwMCAg
cjEgOiAwMDAwMDAwMCAgcjAgOiBjMDM0ZDFlMAoKcjMgOiAwMDAwODAwMCAgcjIgOiAwMDAwODAw
MCAgcjEgOiAwMDAwMDAwMCAgcjAgOiBjMDM0ZDFlMAoKRmxhZ3M6IG56Y3ZGbGFnczogbnpjdiAg
SVJRcyBvZmYgIEZJUXMgb24gIE1vZGUgU1ZDXzMyICBTZWdtZW50IGtlcm5lbAoKICBJUlFzIG9m
ZiAgRklRcyBvbiAgTW9kZSBTVkNfMzIgIFNlZ21lbnQga2VybmVsCgpDb250cm9sOiA1MzE3RgoK
Q29udHJvbDogNTMxN0YKClRhYmxlOiBBMDAwNDAwMCAgREFDOiAwMDAwMDAxNwoKVGFibGU6IEEw
MDA0MDAwICBEQUM6IDAwMDAwMDE3CgpQcm9jZXNzIHN3YXBwZXIgKHBpZDogMSwgc3RhY2sgbGlt
aXQgPSAweGMwNTQyMjUwKQoKUHJvY2VzcyBzd2FwcGVyIChwaWQ6IDEsIHN0YWNrIGxpbWl0ID0g
MHhjMDU0MjI1MCkKClN0YWNrOiAoMHhjMDU0M2RhYyB0byAweGMwNTQ0MDAwKQoKU3RhY2s6ICgw
eGMwNTQzZGFjIHRvIDB4YzA1NDQwMDApCgozZGEwOiAzZGEwOiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwMDAwMDAwOCAwMDAwMDAwOCBjMDU0
M2UwNCBjMDU0M2UwNCAwMDAwMDIwMCAwMDAwMDIwMCBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwZmZm
ZiAwMDAwZmZmZiAKCgozZGMwOiAzZGMwOiAwMDAwMDAwOCAwMDAwMDAwOCBjMDU0M2UwNCBjMDU0
M2UwNCAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0MjAwMCBjMDU0MjAwMCBjMDczYzgwMCBjMDczYzgw
MCBjMDU0M2UwMCBjMDU0M2UwMCBjMDU0M2RlNCBjMDU0M2RlNCBjMDAzZTIzMCBjMDAzZTIzMCAK
CgozZGUwOiAzZGUwOiBjMDA0NTliMCBjMDA0NTliMCBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwZmZm
ZiAwMDAwZmZmZiAwMDAwMDAwMSAwMDAwMDAwMSBjMDc3ZmI0MCBjMDc3ZmI0MCBjMDU0M2U1YyBj
MDU0M2U1YyBjMDU0M2UwNCBjMDU0M2UwNCBjMDAzODlmMCBjMDAzODlmMCAKCgozZTAwOiAzZTAw
OiBjMDAzZTE5OCBjMDAzZTE5OCBlYjAyMDAwMCBlYjAyMDAwMCAwMDAwMDEwMCAwMDAwMDEwMCAw
MDAwMDEwOCAwMDAwMDEwOCBlYjAwMDAwMCBlYjAwMDAwMCBjMDM0NjIwMCBjMDM0NjIwMCBjMDM0
NjIwMCBjMDM0NjIwMCAwMDAwMDEwOCAwMDAwMDEwOCAKCgozZTIwOiAzZTIwOiBjMDc3ZmI0MCBj
MDc3ZmI0MCAwMDAwMDAwMCAwMDAwMDAwMCBjMDczYzgwMCBjMDczYzgwMCBjMDczYzgwMCBjMDcz
YzgwMCBjMDU0M2U1YyBjMDU0M2U1YyBjMDU0M2U0YyBjMDU0M2U0YyBjMDU0M2U0YyBjMDU0M2U0
YyBjMDA3ZWI2NCBjMDA3ZWI2NCAKCgozZTQwOiAzZTQwOiBjMDA3ZWI2NCBjMDA3ZWI2NCA4MDAw
MDAxMyA4MDAwMDAxMyBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2U2
YyBjMDU0M2U2YyBjMDU0M2U2MCBjMDU0M2U2MCBjMDA3ZWJjYyBjMDA3ZWJjYyBjMDA3ZWI1NCBj
MDA3ZWI1NCAKCgozZTYwOiAzZTYwOiBjMDU0M2U5MCBjMDU0M2U5MCBjMDU0M2U3MCBjMDU0M2U3
MCBjMDA3ZTAzMCBjMDA3ZTAzMCBjMDA3ZWJiYyBjMDA3ZWJiYyBjMDc3ZmI0MCBjMDc3ZmI0MCBm
ZmZmZmZmNCBmZmZmZmZmNCAwMDAwMDAwMCAwMDAwMDAwMCBjMDFjYWJjMCBjMDFjYWJjMCAKCgoz
ZTgwOiAzZTgwOiAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2ViYyBjMDU0M2ViYyBjMDU0M2U5NCBj
MDU0M2U5NCBjMDA3ZTFlYyBjMDA3ZTFlYyBjMDA3ZGVlYyBjMDA3ZGVlYyBjMDczYzgwMCBjMDcz
YzgwMCAwMDAwMTAwMyAwMDAwMTAwMyBjMDczY2E2MCBjMDczY2E2MCAKCgozZWEwOiAzZWEwOiAw
MDAwMTAwMiAwMDAwMTAwMiBjMDAzN2I1YyBjMDAzN2I1YyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMCBjMDU0M2VkYyBjMDU0M2VkYyBjMDU0M2VjMCBjMDU0M2VjMCBjMDFjYjMy
MCBjMDFjYjMyMCBjMDA3ZTE2YyBjMDA3ZTE2YyAKCgozZWMwOiAzZWMwOiBjMDczYzgwMCBjMDcz
YzgwMCBjMDczYzgwMCBjMDczYzgwMCAwMDAwMTAwMyAwMDAwMTAwMyAwMDAwMTAwMiAwMDAwMTAw
MiBjMDU0M2VmMCBjMDU0M2VmMCBjMDU0M2VlMCBjMDU0M2VlMCBjMDI2OGVjMCBjMDI2OGVjMCBj
MDFjYjI2YyBjMDFjYjI2YyAKCgozZWUwOiAzZWUwOiBjMDczYzgwMCBjMDczYzgwMCBjMDU0M2Yx
MCBjMDU0M2YxMCBjMDU0M2VmNCBjMDU0M2VmNCBjMDI2NmZhNCBjMDI2NmZhNCBjMDI2OGU3NCBj
MDI2OGU3NCBjMDM1YmVkNCBjMDM1YmVkNCBjMDczYzgwMCBjMDczYzgwMCAwMDAwMDAwMSAwMDAw
MDAwMSAKCgozZjAwOiAzZjAwOiAwMDAwMTAwMiAwMDAwMTAwMiBjMDU0M2ZhYyBjMDU0M2ZhYyBj
MDU0M2YxNCBjMDU0M2YxNCBjMDAxZWE3MCBjMDAxZWE3MCBjMDI2NmY1OCBjMDI2NmY1OCAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAKCgozZjIw
OiAzZjIwOiBjMDU0M2Y5YyBjMDU0M2Y5YyBjMDU0M2YzMCBjMDU0M2YzMCBjMDAzOWJhNCBjMDAz
OWJhNCBjMDA1NTc5NCBjMDA1NTc5NCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAKCgozZjQwOiAzZjQwOiBjMDIx
MjU5MCBjMDIxMjU5MCBjMDA1YTY3NCBjMDA1YTY3NCBjMDAyMGRjNCBjMDAyMGRjNCBjMDAyMDkw
OCBjMDAyMDkwOCBjMDU0MjAwMCBjMDU0MjAwMCAwMDAwMDAwMSAwMDAwMDAwMSBjMDU0M2Y4MCBj
MDU0M2Y4MCBjMDU0M2Y2OCBjMDU0M2Y2OCAKCgozZjYwOiAzZjYwOiBjMDJhMTJlOCBjMDJhMTJl
OCBjMDE3NDBlYyBjMDE3NDBlYyBjMDMxZDIyMCBjMDMxZDIyMCBjMDM1MDRhMCBjMDM1MDRhMCBj
MDM1MDRhMCBjMDM1MDRhMCBjMDU0M2Y5YyBjMDU0M2Y5YyBjMDU0M2Y4NCBjMDU0M2Y4NCBjMDJh
MTQzYyBjMDJhMTQzYyAKCgozZjgwOiAzZjgwOiBjMDJlNWQ5YyBjMDJlNWQ5YyBjMDAyMGRjNCBj
MDAyMGRjNCBjMDAyMDkxMCBjMDAyMDkxMCBjMDU0MjAwMCBjMDU0MjAwMCAwMDAwMDAwMSAwMDAw
MDAwMSAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAKCgozZmEwOiAzZmEwOiBjMDU0M2ZmNCBjMDU0M2ZmNCBjMDU0M2ZiMCBjMDU0M2ZiMCBjMDAz
ODBjYyBjMDAzODBjYyBjMDAxZTkyMCBjMDAxZTkyMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCBjMDAzODAyYyBjMDAzODAyYyBjMDA1YTY3NCBjMDA1YTY3NCAKCgozZmMwOiAz
ZmMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAKCgozZmUwOiAzZmUwOiAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2ZmOCBj
MDU0M2ZmOCBjMDA1YTY3NCBjMDA1YTY3NCBjMDAzODAzYyBjMDAzODAzYyBjMDI3ZDRkOCBjMDI3
ZDRkOCBjMDI3ZDY0NCBjMDI3ZDY0NCAKCgpCYWNrdHJhY2U6IEJhY2t0cmFjZTogCgoKWzxjMDA0
NTlhMD5dIFs8YzAwNDU5YTA+XSAoX19pcGlwZV9tYWNoX2RlbXV4X2lycSsweDAvMHgxMGMpIChf
X2lwaXBlX21hY2hfZGVtdXhfaXJxKzB4MC8weDEwYykgZnJvbSBbPGMwMDNlMjMwPl0gZnJvbSBb
PGMwMDNlMjMwPl0gKF9faXBpcGVfZ3JhYl9pcnErMHhhOC8weGY4KQoKKF9faXBpcGVfZ3JhYl9p
cnErMHhhOC8weGY4KQoKWzxjMDAzZTE4OD5dIFs8YzAwM2UxODg+XSAoX19pcGlwZV9ncmFiX2ly
cSsweDAvMHhmOCkgKF9faXBpcGVfZ3JhYl9pcnErMHgwLzB4ZjgpIGZyb20gWzxjMDAzODlmMD5d
IGZyb20gWzxjMDAzODlmMD5dIChfX2lycV9zdmMrMHgzMC8weDg4KQoKKF9faXJxX3N2YysweDMw
LzB4ODgpCgogcjcgPSBDMDc3RkI0MCAgcjcgPSBDMDc3RkI0MCAgcjYgPSAwMDAwMDAwMSAgcjYg
PSAwMDAwMDAwMSAgcjUgPSAwMDAwRkZGRiAgcjUgPSAwMDAwRkZGRiAgcjQgPSBGRkZGRkZGRgoK
IHI0ID0gRkZGRkZGRkYKCls8YzAwN2ViNDQ+XSBbPGMwMDdlYjQ0Pl0gKGRlZmF1bHRfZW5hYmxl
KzB4MC8weDM0KSAoZGVmYXVsdF9lbmFibGUrMHgwLzB4MzQpIGZyb20gWzxjMDA3ZWJjYz5dIGZy
b20gWzxjMDA3ZWJjYz5dIChkZWZhdWx0X3N0YXJ0dXArMHgyMC8weDJjKQoKKGRlZmF1bHRfc3Rh
cnR1cCsweDIwLzB4MmMpCgogcjQgPSAwMDAwMDAwMCAgcjQgPSAwMDAwMDAwMCAKCgpbPGMwMDdl
YmFjPl0gWzxjMDA3ZWJhYz5dIChkZWZhdWx0X3N0YXJ0dXArMHgwLzB4MmMpIChkZWZhdWx0X3N0
YXJ0dXArMHgwLzB4MmMpIGZyb20gWzxjMDA3ZTAzMD5dIGZyb20gWzxjMDA3ZTAzMD5dIChzZXR1
cF9pcnErMHgxNTQvMHgyODApCgooc2V0dXBfaXJxKzB4MTU0LzB4MjgwKQoKWzxjMDA3ZGVkYz5d
IFs8YzAwN2RlZGM+XSAoc2V0dXBfaXJxKzB4MC8weDI4MCkgKHNldHVwX2lycSsweDAvMHgyODAp
IGZyb20gWzxjMDA3ZTFlYz5dIGZyb20gWzxjMDA3ZTFlYz5dIChyZXF1ZXN0X2lycSsweDkwLzB4
YjgpCgoocmVxdWVzdF9pcnErMHg5MC8weGI4KQoKIHI4ID0gMDAwMDAwMDAgIHI4ID0gMDAwMDAw
MDAgIHI3ID0gQzAxQ0FCQzAgIHI3ID0gQzAxQ0FCQzAgIHI2ID0gMDAwMDAwMDAgIHI2ID0gMDAw
MDAwMDAgIHI1ID0gRkZGRkZGRjQKCiByNSA9IEZGRkZGRkY0CgogcjQgPSBDMDc3RkI0MCAgcjQg
PSBDMDc3RkI0MCAKCgpbPGMwMDdlMTVjPl0gWzxjMDA3ZTE1Yz5dIChyZXF1ZXN0X2lycSsweDAv
MHhiOCkgKHJlcXVlc3RfaXJxKzB4MC8weGI4KSBmcm9tIFs8YzAxY2IzMjA+XSBmcm9tIFs8YzAx
Y2IzMjA+XSAobmV0X29wZW4rMHhjNC8weDRlMCkKCihuZXRfb3BlbisweGM0LzB4NGUwKQoKWzxj
MDFjYjI1Yz5dIFs8YzAxY2IyNWM+XSAobmV0X29wZW4rMHgwLzB4NGUwKSAobmV0X29wZW4rMHgw
LzB4NGUwKSBmcm9tIFs8YzAyNjhlYzA+XSBmcm9tIFs8YzAyNjhlYzA+XSAoZGV2X29wZW4rMHg1
Yy8weGMwKQoKKGRldl9vcGVuKzB4NWMvMHhjMCkKCiByNiA9IDAwMDAxMDAyICByNiA9IDAwMDAx
MDAyICByNSA9IDAwMDAxMDAzICByNSA9IDAwMDAxMDAzICByNCA9IEMwNzNDODAwICByNCA9IEMw
NzNDODAwIAoKCls8YzAyNjhlNjQ+XSBbPGMwMjY4ZTY0Pl0gKGRldl9vcGVuKzB4MC8weGMwKSAo
ZGV2X29wZW4rMHgwLzB4YzApIGZyb20gWzxjMDI2NmZhND5dIGZyb20gWzxjMDI2NmZhND5dIChk
ZXZfY2hhbmdlX2ZsYWdzKzB4NWMvMHgxMzApCgooZGV2X2NoYW5nZV9mbGFncysweDVjLzB4MTMw
KQoKIHI0ID0gQzA3M0M4MDAgIHI0ID0gQzA3M0M4MDAgCgoKWzxjMDI2NmY0OD5dIFs8YzAyNjZm
NDg+XSAoZGV2X2NoYW5nZV9mbGFncysweDAvMHgxMzApIChkZXZfY2hhbmdlX2ZsYWdzKzB4MC8w
eDEzMCkgZnJvbSBbPGMwMDFlYTcwPl0gZnJvbSBbPGMwMDFlYTcwPl0gKGlwX2F1dG9fY29uZmln
KzB4MTYwLzB4ZTc4KQoKKGlwX2F1dG9fY29uZmlnKzB4MTYwLzB4ZTc4KQoKIHI3ID0gMDAwMDEw
MDIgIHI3ID0gMDAwMDEwMDIgIHI2ID0gMDAwMDAwMDEgIHI2ID0gMDAwMDAwMDEgIHI1ID0gQzA3
M0M4MDAgIHI1ID0gQzA3M0M4MDAgIHI0ID0gQzAzNUJFRDQKCiByNCA9IEMwMzVCRUQ0CgpbPGMw
MDFlOTEwPl0gWzxjMDAxZTkxMD5dIChpcF9hdXRvX2NvbmZpZysweDAvMHhlNzgpIChpcF9hdXRv
X2NvbmZpZysweDAvMHhlNzgpIGZyb20gWzxjMDAzODBjYz5dIGZyb20gWzxjMDAzODBjYz5dIChp
bml0KzB4YTAvMHgyODApCgooaW5pdCsweGEwLzB4MjgwKQoKWzxjMDAzODAyYz5dIFs8YzAwMzgw
MmM+XSAoaW5pdCsweDAvMHgyODApIChpbml0KzB4MC8weDI4MCkgZnJvbSBbPGMwMDVhNjc0Pl0g
ZnJvbSBbPGMwMDVhNjc0Pl0gKGRvX2V4aXQrMHgwLzB4YjNjKQoKKGRvX2V4aXQrMHgwLzB4YjNj
KQoKIHI3ID0gMDAwMDAwMDAgIHI3ID0gMDAwMDAwMDAgIHI2ID0gMDAwMDAwMDAgIHI2ID0gMDAw
MDAwMDAgIHI1ID0gMDAwMDAwMDAgIHI1ID0gMDAwMDAwMDAgIHI0ID0gMDAwMDAwMDAKCiByNCA9
IDAwMDAwMDAwCgpDb2RlOiBDb2RlOiBlM2EwMzgwMSBlM2EwMzgwMSBlMWEwMzYxMyBlMWEwMzYx
MyBlNTk4MjAwMCBlNTk4MjAwMCBlMWEwMzgyMyBlMWEwMzgyMyAoZTFjMjMwYjApIChlMWMyMzBi
MCkgCgoKICBoYW5kbGluZyBpcnEgMTUgKHBvcnQgMikgMSwgOCwgYzA1NDNiYTQKCmhhbmRsaW5n
IGlycSAxNSAocG9ydCAyKSAxLCA4LCBjMDU0M2JhNAoKaXJxIDE0MywgZGVzYzogYzAzNDQzYzAs
IGRlcHRoOiAwLCBjb3VudDogMCwgdW5oYW5kbGVkOiAwCgppcnEgMTQzLCBkZXNjOiBjMDM0NDNj
MCwgZGVwdGg6IDAsIGNvdW50OiAwLCB1bmhhbmRsZWQ6IDAKCi0+aGFuZGxlX2lycSgpOiAgYzAw
NDU2NGMsIC0+aGFuZGxlX2lycSgpOiAgYzAwNDU2NGMsIG14Y19leHBpb19pcnFfaGFuZGxlcisw
eDAvMHgxYTAKCm14Y19leHBpb19pcnFfaGFuZGxlcisweDAvMHgxYTAKCi0+Y2hpcCgpOiBjMDM0
Yjc1NCwgLT5jaGlwKCk6IGMwMzRiNzU0LCAweGMwMzRiNzU0CgoweGMwMzRiNzU0CgotPmFjdGlv
bigpOiAwMDAwMDAwMAoKLT5hY3Rpb24oKTogMDAwMDAwMDAKCiAgIElSUV9OT1BST0JFIHNldAoK
ICAgSVJRX05PUFJPQkUgc2V0CgogSVJRX05PUkVRVUVTVCBzZXQKCiBJUlFfTk9SRVFVRVNUIHNl
dAoKPDE+VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBh
ZGRyZXNzIDAwMDA4MDAwCgpVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBh
dCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDgwMDAKCjwxPnBnZCA9IGMwMDA0MDAwCgpwZ2QgPSBjMDAw
NDAwMAoKPDE+WzAwMDA4MDAwXSAqcGdkPTAwMDAwMDAwWzAwMDA4MDAwXSAqcGdkPTAwMDAwMDAw
CgoKSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDgwNSBbIzJdCgpJbnRlcm5hbCBlcnJvcjogT29wczog
ODA1IFsjMl0KCk1vZHVsZXMgbGlua2VkIGluOk1vZHVsZXMgbGlua2VkIGluOgoKCkNQVTogMAoK
Q1BVOiAwCgpQQyBpcyBhdCBfX2lwaXBlX21hY2hfZGVtdXhfaXJxKzB4YjQvMHgxMGMKClBDIGlz
IGF0IF9faXBpcGVfbWFjaF9kZW11eF9pcnErMHhiNC8weDEwYwoKTFIgaXMgYXQgX19pcGlwZV9o
YW5kbGVfaXJxKzB4MWQ4LzB4MWVjCgpMUiBpcyBhdCBfX2lwaXBlX2hhbmRsZV9pcnErMHgxZDgv
MHgxZWMKCnBjIDogWzxjMDA0NWE1ND5dICAgIGxyIDogWzxjMDAzZTE3ND5dICAgIE5vdCB0YWlu
dGVkCgpzcCA6IGMwNTQzYjRjICBpcCA6IGMwNTQzYjE0ICBmcCA6IGMwNTQzYjgwCgpwYyA6IFs8
YzAwNDVhNTQ+XSAgICBsciA6IFs8YzAwM2UxNzQ+XSAgICBOb3QgdGFpbnRlZAoKc3AgOiBjMDU0
M2I0YyAgaXAgOiBjMDU0M2IxNCAgZnAgOiBjMDU0M2I4MAoKcjEwOiAwMDAwMDAwMiAgcjkgOiBj
MDU0M2JhNCAgcjggOiBkNDAxNTIzNAoKcjEwOiAwMDAwMDAwMiAgcjkgOiBjMDU0M2JhNCAgcjgg
OiBkNDAxNTIzNAoKcjcgOiAwMDAwMDAwOCAgcjYgOiAwMDAwMDAwZiAgcjUgOiAwMDAwMDA4ZiAg
cjQgOiAwMDAwMDAwMAoKcjcgOiAwMDAwMDAwOCAgcjYgOiAwMDAwMDAwZiAgcjUgOiAwMDAwMDA4
ZiAgcjQgOiAwMDAwMDAwMAoKcjMgOiAwMDAwODAwMCAgcjIgOiAwMDAwODAwMCAgcjEgOiAwMDAw
MDAwMCAgcjAgOiBjMDM0ZDFlMAoKcjMgOiAwMDAwODAwMCAgcjIgOiAwMDAwODAwMCAgcjEgOiAw
MDAwMDAwMCAgcjAgOiBjMDM0ZDFlMAoKRmxhZ3M6IG56Y3ZGbGFnczogbnpjdiAgSVJRcyBvZmYg
IEZJUXMgb24gIE1vZGUgU1ZDXzMyICBTZWdtZW50IGtlcm5lbAoKICBJUlFzIG9mZiAgRklRcyBv
biAgTW9kZSBTVkNfMzIgIFNlZ21lbnQga2VybmVsCgpDb250cm9sOiA1MzE3RgoKQ29udHJvbDog
NTMxN0YKClRhYmxlOiBBMDAwNDAwMCAgREFDOiAwMDAwMDAxNwoKVGFibGU6IEEwMDA0MDAwICBE
QUM6IDAwMDAwMDE3CgpQcm9jZXNzIHN3YXBwZXIgKHBpZDogMSwgc3RhY2sgbGltaXQgPSAweGMw
NTQyMjUwKQoKUHJvY2VzcyBzd2FwcGVyIChwaWQ6IDEsIHN0YWNrIGxpbWl0ID0gMHhjMDU0MjI1
MCkKClN0YWNrOiAoMHhjMDU0M2I0YyB0byAweGMwNTQ0MDAwKQoKU3RhY2s6ICgweGMwNTQzYjRj
IHRvIDB4YzA1NDQwMDApCgozYjQwOiAzYjQwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAwMDAwMDAwOCAwMDAwMDAwOCBjMDU0M2JhNCBjMDU0
M2JhNCAwMDAwMDIwMCAwMDAwMDIwMCBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwZmZmZiAwMDAwZmZm
ZiAKCgozYjYwOiAzYjYwOiAwMDAwMDAwOCAwMDAwMDAwOCBjMDU0M2JhNCBjMDU0M2JhNCBjMDM0
ZDFlYyBjMDM0ZDFlYyBjMDU0MjAwMCBjMDU0MjAwMCBmZmZmZmZmZiBmZmZmZmZmZiBjMDU0M2Jh
MCBjMDU0M2JhMCBjMDU0M2I4NCBjMDU0M2I4NCBjMDAzZTIzMCBjMDAzZTIzMCAKCgozYjgwOiAz
YjgwOiBjMDA0NTliMCBjMDA0NTliMCBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwZmZmZiAwMDAwZmZm
ZiAwMDAwMDAwMSAwMDAwMDAwMSBjMDM0ZDFmOCBjMDM0ZDFmOCBjMDU0M2MxNCBjMDU0M2MxNCBj
MDU0M2JhNCBjMDU0M2JhNCBjMDAzODlmMCBjMDAzODlmMCAKCgozYmEwOiAzYmEwOiBjMDAzZTE5
OCBjMDAzZTE5OCAwMDAwMDA4ZiAwMDAwMDA4ZiAwMDAwMDAwZiAwMDAwMDAwZiAwMDAwMDAwMSAw
MDAwMDAwMSA4MDAwMDAxMyA4MDAwMDAxMyBjMDM0ZDFlOCBjMDM0ZDFlOCBjMDM0ZDFlMCBjMDM0
ZDFlMCAwMDAwMDAwNCAwMDAwMDAwNCAKCgozYmMwOiAzYmMwOiBjMDM0ZDFmOCBjMDM0ZDFmOCBj
MDM0ZDFlYyBjMDM0ZDFlYyBmZmZmZmZlZiBmZmZmZmZlZiBmZmZmZmZmZiBmZmZmZmZmZiBjMDU0
M2MxNCBjMDU0M2MxNCAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2JlYyBjMDU0M2JlYyBjMDM0ZDIw
MCBjMDM0ZDIwMCAKCgozYmUwOiAzYmUwOiBjMDA4MDc0YyBjMDA4MDc0YyA4MDAwMDAxMyA4MDAw
MDAxMyBmZmZmZmZmZiBmZmZmZmZmZiBjMDM0ZDFlMCBjMDM0ZDFlMCBjMDM1MDRhMCBjMDM1MDRh
MCBjMDA0NWE1NCBjMDA0NWE1NCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwOCAwMDAwMDAwOCAK
CgozYzAwOiAzYzAwOiAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2Q2NCBjMDU0M2Q2NCBjMDU0M2My
NCBjMDU0M2MyNCBjMDU0M2MxOCBjMDU0M2MxOCBjMDA4MGU4OCBjMDA4MGU4OCBjMDA4MDVkYyBj
MDA4MDVkYyBjMDU0M2MzOCBjMDU0M2MzOCBjMDU0M2MyOCBjMDU0M2MyOCAKCgozYzIwOiAzYzIw
OiBjMDAzZDI2NCBjMDAzZDI2NCBjMDA4MGU1OCBjMDA4MGU1OCAwMDAwMDAwMCAwMDAwMDAwMCBj
MDU0M2M1OCBjMDU0M2M1OCBjMDU0M2MzYyBjMDU0M2MzYyBjMDAzZjQ2OCBjMDAzZjQ2OCBjMDAz
Y2Y1OCBjMDAzY2Y1OCBmZmZmZmZmZiBmZmZmZmZmZiAKCgozYzQwOiAzYzQwOiAwMDAwODAwMCAw
MDAwODAwMCBjMDU0M2Q2NCBjMDU0M2Q2NCBjMDU0MWJlMCBjMDU0MWJlMCBjMDU0M2M5MCBjMDU0
M2M5MCBjMDU0M2M1YyBjMDU0M2M1YyBjMDAzZjZlMCBjMDAzZjZlMCBjMDAzZjQwYyBjMDAzZjQw
YyAwMDAwMzA3MyAwMDAwMzA3MyAKCgozYzYwOiAzYzYwOiBjMDM0Yjg3OCBjMDM0Yjg3OCAwMDAw
MDgwNSAwMDAwMDgwNSBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwODAwMCAwMDAwODAwMCBjMDU0M2Q2
NCBjMDU0M2Q2NCAwMDAwMDgwNSAwMDAwMDgwNSBjMDM0ODdhOCBjMDM0ODdhOCAwMDAwODAwMCAw
MDAwODAwMCAKCgozYzgwOiAzYzgwOiBjMDU0M2Q2NCBjMDU0M2Q2NCBjMDU0M2NiMCBjMDU0M2Ni
MCBjMDU0M2M5NCBjMDU0M2M5NCBjMDAzZjdiOCBjMDAzZjdiOCBjMDAzZjQ4OCBjMDAzZjQ4OCBm
ZmZmZmZmZiBmZmZmZmZmZiBjMDU0M2Q5OCBjMDU0M2Q5OCAwMDAwMDAwZiAwMDAwMDAwZiAKCgoz
Y2EwOiAzY2EwOiAwMDAwMDgwNSAwMDAwMDgwNSBjMDU0M2Q2MCBjMDU0M2Q2MCBjMDU0M2NiNCBj
MDU0M2NiNCBjMDAzZjhmNCBjMDAzZjhmNCBjMDAzZjdhNCBjMDAzZjdhNCBjMDA1N2I1MCBjMDA1
N2I1MCBjMDA1MTBkMCBjMDA1MTBkMCAwMDAwMmY1OSAwMDAwMmY1OSAKCgozY2MwOiAzY2MwOiBj
MDM0Yjg3OCBjMDM0Yjg3OCAwMDAwMmY1OSAwMDAwMmY1OSBjMDU0M2NlYyBjMDU0M2NlYyBjMDU0
M2NkOCBjMDU0M2NkOCBjMDU0M2NlYyBjMDU0M2NlYyBjMDM0NDNjMCBjMDM0NDNjMCAwMDAwMDA4
ZiAwMDAwMDA4ZiAwMDAwMDAwNCAwMDAwMDAwNCAKCgozY2UwOiAzY2UwOiBjMDNkM2I4MCBjMDNk
M2I4MCAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2QxOCBjMDU0M2QxOCBjMDU0M2NmOCBjMDU0M2Nm
OCBjMDA1N2M2YyBjMDA1N2M2YyAwMDAwMDA4ZiAwMDAwMDA4ZiBjMDNkM2FmYyBjMDNkM2FmYyAw
MDAwMDAwNCAwMDAwMDAwNCAKCgozZDAwOiAzZDAwOiBjMDNkM2I4MCBjMDNkM2I4MCAwMDAwMDAw
MCAwMDAwMDAwMCBjMDU0M2QzOCBjMDU0M2QzOCBjMDU0M2QxOCBjMDU0M2QxOCBjMDA1N2M2YyBj
MDA1N2M2YyBjMDA1NzdjNCBjMDA1NzdjNCBjMDU0M2Q0MCBjMDU0M2Q0MCAwMDAwMDA4ZiAwMDAw
MDA4ZiAKCgozZDIwOiAzZDIwOiBjMDNkM2FmYyBjMDNkM2FmYyAwMDAwMDAwNCAwMDAwMDAwNCBj
MDNkM2I4MCBjMDNkM2I4MCBjMDU0M2Q2MCBjMDU0M2Q2MCBjMDU0M2Q0YyBjMDU0M2Q0YyBjMDA3
ZWQ4NCBjMDA3ZWQ4NCBmZmZmZmZmZiBmZmZmZmZmZiBjMDU0M2Q5OCBjMDU0M2Q5OCAKCgozZDQw
OiAzZDQwOiAwMDAwMDAwZiAwMDAwMDAwZiAwMDAwMDAwOCAwMDAwMDAwOCBkNDAxNTIzNCBkNDAx
NTIzNCAwMDAwMDA5MyAwMDAwMDA5MyAwMDAwMDAwMiAwMDAwMDAwMiBjMDU0M2RlMCBjMDU0M2Rl
MCBjMDU0M2Q2NCBjMDU0M2Q2NCBjMDAzODlhMCBjMDAzODlhMCAKCgozZDYwOiAzZDYwOiBjMDAz
ZjhjOCBjMDAzZjhjOCBjMDM0ZDFlMCBjMDM0ZDFlMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwODAw
MCAwMDAwODAwMCAwMDAwODAwMCAwMDAwODAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDA4ZiAw
MDAwMDA4ZiAwMDAwMDAwZiAwMDAwMDAwZiAKCgozZDgwOiAzZDgwOiAwMDAwMDAwOCAwMDAwMDAw
OCBkNDAxNTIzNCBkNDAxNTIzNCBjMDU0M2UwNCBjMDU0M2UwNCAwMDAwMDAwMiAwMDAwMDAwMiBj
MDU0M2RlMCBjMDU0M2RlMCBjMDU0M2Q3NCBjMDU0M2Q3NCBjMDU0M2RhYyBjMDU0M2RhYyBjMDAz
ZTE3NCBjMDAzZTE3NCAKCgozZGEwOiAzZGEwOiBjMDA0NWE1NCBjMDA0NWE1NCAwMDAwMDA5MyAw
MDAwMDA5MyBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwMDAwOCAwMDAwMDAwOCBjMDU0M2UwNCBjMDU0
M2UwNCAwMDAwMDIwMCAwMDAwMDIwMCBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwZmZmZiAwMDAwZmZm
ZiAKCgozZGMwOiAzZGMwOiAwMDAwMDAwOCAwMDAwMDAwOCBjMDU0M2UwNCBjMDU0M2UwNCAwMDAw
MDAwMCAwMDAwMDAwMCBjMDU0MjAwMCBjMDU0MjAwMCBjMDczYzgwMCBjMDczYzgwMCBjMDU0M2Uw
MCBjMDU0M2UwMCBjMDU0M2RlNCBjMDU0M2RlNCBjMDAzZTIzMCBjMDAzZTIzMCAKCgozZGUwOiAz
ZGUwOiBjMDA0NTliMCBjMDA0NTliMCBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwZmZmZiAwMDAwZmZm
ZiAwMDAwMDAwMSAwMDAwMDAwMSBjMDc3ZmI0MCBjMDc3ZmI0MCBjMDU0M2U1YyBjMDU0M2U1YyBj
MDU0M2UwNCBjMDU0M2UwNCBjMDAzODlmMCBjMDAzODlmMCAKCgozZTAwOiAzZTAwOiBjMDAzZTE5
OCBjMDAzZTE5OCBlYjAyMDAwMCBlYjAyMDAwMCAwMDAwMDEwMCAwMDAwMDEwMCAwMDAwMDEwOCAw
MDAwMDEwOCBlYjAwMDAwMCBlYjAwMDAwMCBjMDM0NjIwMCBjMDM0NjIwMCBjMDM0NjIwMCBjMDM0
NjIwMCAwMDAwMDEwOCAwMDAwMDEwOCAKCgozZTIwOiAzZTIwOiBjMDc3ZmI0MCBjMDc3ZmI0MCAw
MDAwMDAwMCAwMDAwMDAwMCBjMDczYzgwMCBjMDczYzgwMCBjMDczYzgwMCBjMDczYzgwMCBjMDU0
M2U1YyBjMDU0M2U1YyBjMDU0M2U0YyBjMDU0M2U0YyBjMDU0M2U0YyBjMDU0M2U0YyBjMDA3ZWI2
NCBjMDA3ZWI2NCAKCgozZTQwOiAzZTQwOiBjMDA3ZWI2NCBjMDA3ZWI2NCA4MDAwMDAxMyA4MDAw
MDAxMyBmZmZmZmZmZiBmZmZmZmZmZiAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2U2YyBjMDU0M2U2
YyBjMDU0M2U2MCBjMDU0M2U2MCBjMDA3ZWJjYyBjMDA3ZWJjYyBjMDA3ZWI1NCBjMDA3ZWI1NCAK
CgozZTYwOiAzZTYwOiBjMDU0M2U5MCBjMDU0M2U5MCBjMDU0M2U3MCBjMDU0M2U3MCBjMDA3ZTAz
MCBjMDA3ZTAzMCBjMDA3ZWJiYyBjMDA3ZWJiYyBjMDc3ZmI0MCBjMDc3ZmI0MCBmZmZmZmZmNCBm
ZmZmZmZmNCAwMDAwMDAwMCAwMDAwMDAwMCBjMDFjYWJjMCBjMDFjYWJjMCAKCgozZTgwOiAzZTgw
OiAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2ViYyBjMDU0M2ViYyBjMDU0M2U5NCBjMDU0M2U5NCBj
MDA3ZTFlYyBjMDA3ZTFlYyBjMDA3ZGVlYyBjMDA3ZGVlYyBjMDczYzgwMCBjMDczYzgwMCAwMDAw
MTAwMyAwMDAwMTAwMyBjMDczY2E2MCBjMDczY2E2MCAKCgozZWEwOiAzZWEwOiAwMDAwMTAwMiAw
MDAwMTAwMiBjMDAzN2I1YyBjMDAzN2I1YyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMCBjMDU0M2VkYyBjMDU0M2VkYyBjMDU0M2VjMCBjMDU0M2VjMCBjMDFjYjMyMCBjMDFjYjMy
MCBjMDA3ZTE2YyBjMDA3ZTE2YyAKCgozZWMwOiAzZWMwOiBjMDczYzgwMCBjMDczYzgwMCBjMDcz
YzgwMCBjMDczYzgwMCAwMDAwMTAwMyAwMDAwMTAwMyAwMDAwMTAwMiAwMDAwMTAwMiBjMDU0M2Vm
MCBjMDU0M2VmMCBjMDU0M2VlMCBjMDU0M2VlMCBjMDI2OGVjMCBjMDI2OGVjMCBjMDFjYjI2YyBj
MDFjYjI2YyAKCgozZWUwOiAzZWUwOiBjMDczYzgwMCBjMDczYzgwMCBjMDU0M2YxMCBjMDU0M2Yx
MCBjMDU0M2VmNCBjMDU0M2VmNCBjMDI2NmZhNCBjMDI2NmZhNCBjMDI2OGU3NCBjMDI2OGU3NCBj
MDM1YmVkNCBjMDM1YmVkNCBjMDczYzgwMCBjMDczYzgwMCAwMDAwMDAwMSAwMDAwMDAwMSAKCgoz
ZjAwOiAzZjAwOiAwMDAwMTAwMiAwMDAwMTAwMiBjMDU0M2ZhYyBjMDU0M2ZhYyBjMDU0M2YxNCBj
MDU0M2YxNCBjMDAxZWE3MCBjMDAxZWE3MCBjMDI2NmY1OCBjMDI2NmY1OCAwMDAwMDAwMCAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAKCgozZjIwOiAzZjIwOiBj
MDU0M2Y5YyBjMDU0M2Y5YyBjMDU0M2YzMCBjMDU0M2YzMCBjMDAzOWJhNCBjMDAzOWJhNCBjMDA1
NTc5NCBjMDA1NTc5NCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAKCgozZjQwOiAzZjQwOiBjMDIxMjU5MCBjMDIx
MjU5MCBjMDA1YTY3NCBjMDA1YTY3NCBjMDAyMGRjNCBjMDAyMGRjNCBjMDAyMDkwOCBjMDAyMDkw
OCBjMDU0MjAwMCBjMDU0MjAwMCAwMDAwMDAwMSAwMDAwMDAwMSBjMDU0M2Y4MCBjMDU0M2Y4MCBj
MDU0M2Y2OCBjMDU0M2Y2OCAKCgozZjYwOiAzZjYwOiBjMDJhMTJlOCBjMDJhMTJlOCBjMDE3NDBl
YyBjMDE3NDBlYyBjMDMxZDIyMCBjMDMxZDIyMCBjMDM1MDRhMCBjMDM1MDRhMCBjMDM1MDRhMCBj
MDM1MDRhMCBjMDU0M2Y5YyBjMDU0M2Y5YyBjMDU0M2Y4NCBjMDU0M2Y4NCBjMDJhMTQzYyBjMDJh
MTQzYyAKCgozZjgwOiAzZjgwOiBjMDJlNWQ5YyBjMDJlNWQ5YyBjMDAyMGRjNCBjMDAyMGRjNCBj
MDAyMDkxMCBjMDAyMDkxMCBjMDU0MjAwMCBjMDU0MjAwMCAwMDAwMDAwMSAwMDAwMDAwMSAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAKCgozZmEw
OiAzZmEwOiBjMDU0M2ZmNCBjMDU0M2ZmNCBjMDU0M2ZiMCBjMDU0M2ZiMCBjMDAzODBjYyBjMDAz
ODBjYyBjMDAxZTkyMCBjMDAxZTkyMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCBjMDAzODAyYyBjMDAzODAyYyBjMDA1YTY3NCBjMDA1YTY3NCAKCgozZmMwOiAzZmMwOiAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAKCgozZmUwOiAzZmUwOiAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCBjMDU0M2ZmOCBjMDU0M2ZmOCBj
MDA1YTY3NCBjMDA1YTY3NCBjMDAzODAzYyBjMDAzODAzYyBjMDI3ZDRkOCBjMDI3ZDRkOCBjMDI3
ZDY0NCBjMDI3ZDY0NCAKCgpCYWNrdHJhY2U6IEJhY2t0cmFjZTogCgoKWzxjMDA0NTlhMD5dIFs8
YzAwNDU5YTA+XSAoX19pcGlwZV9tYWNoX2RlbXV4X2lycSsweDAvMHgxMGMpIChfX2lwaXBlX21h
Y2hfZGVtdXhfaXJxKzB4MC8weDEwYykgZnJvbSBbPGMwMDNlMjMwPl0gZnJvbSBbPGMwMDNlMjMw
Pl0gKF9faXBpcGVfZ3JhYl9pcnErMHhhOC8weGY4KQoKKF9faXBpcGVfZ3JhYl9pcnErMHhhOC8w
eGY4KQoKWzxjMDAzZTE4OD5dIFs8YzAwM2UxODg+XSAoX19pcGlwZV9ncmFiX2lycSsweDAvMHhm
OCkgKF9faXBpcGVfZ3JhYl9pcnErMHgwLzB4ZjgpIGZyb20gWzxjMDAzODlmMD5dIGZyb20gWzxj
MDAzODlmMD5dIChfX2lycV9zdmMrMHgzMC8weDg4KQoKKF9faXJxX3N2YysweDMwLzB4ODgpCgog
cjcgPSBDMDM0RDFGOCAgcjcgPSBDMDM0RDFGOCAgcjYgPSAwMDAwMDAwMSAgcjYgPSAwMDAwMDAw
MSAgcjUgPSAwMDAwRkZGRiAgcjUgPSAwMDAwRkZGRiAgcjQgPSBGRkZGRkZGRgoKIHI0ID0gRkZG
RkZGRkYKCls8YzAwODA1Y2M+XSBbPGMwMDgwNWNjPl0gKF9faXBpcGVfc3luY19zdGFnZSsweDAv
MHgyNDApIChfX2lwaXBlX3N5bmNfc3RhZ2UrMHgwLzB4MjQwKSBmcm9tIFs8YzAwODBlODg+XSBm
cm9tIFs8YzAwODBlODg+XSAoX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg0MC8weDU4KQoKKF9faXBp
cGVfdW5zdGFsbF9yb290KzB4NDAvMHg1OCkKCls8YzAwODBlNDg+XSBbPGMwMDgwZTQ4Pl0gKF9f
aXBpcGVfdW5zdGFsbF9yb290KzB4MC8weDU4KSAoX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgwLzB4
NTgpIGZyb20gWzxjMDAzZDI2ND5dIGZyb20gWzxjMDAzZDI2ND5dIChkaWUrMHgzMWMvMHg0MTAp
CgooZGllKzB4MzFjLzB4NDEwKQoKWzxjMDAzY2Y0OD5dIFs8YzAwM2NmNDg+XSAoZGllKzB4MC8w
eDQxMCkgKGRpZSsweDAvMHg0MTApIGZyb20gWzxjMDAzZjQ2OD5dIGZyb20gWzxjMDAzZjQ2OD5d
IChfX2RvX2tlcm5lbF9mYXVsdCsweDZjLzB4N2MpCgooX19kb19rZXJuZWxfZmF1bHQrMHg2Yy8w
eDdjKQoKWzxjMDAzZjNmYz5dIFs8YzAwM2YzZmM+XSAoX19kb19rZXJuZWxfZmF1bHQrMHgwLzB4
N2MpIChfX2RvX2tlcm5lbF9mYXVsdCsweDAvMHg3YykgZnJvbSBbPGMwMDNmNmUwPl0gZnJvbSBb
PGMwMDNmNmUwPl0gKGRvX3BhZ2VfZmF1bHQrMHgyNjgvMHgyYTApCgooZG9fcGFnZV9mYXVsdCsw
eDI2OC8weDJhMCkKCiByNyA9IEMwNTQxQkUwICByNyA9IEMwNTQxQkUwICByNiA9IEMwNTQzRDY0
ICByNiA9IEMwNTQzRDY0ICByNSA9IDAwMDA4MDAwICByNSA9IDAwMDA4MDAwICByNCA9IEZGRkZG
RkZGCgogcjQgPSBGRkZGRkZGRgoKWzxjMDAzZjQ3OD5dIFs8YzAwM2Y0Nzg+XSAoZG9fcGFnZV9m
YXVsdCsweDAvMHgyYTApIChkb19wYWdlX2ZhdWx0KzB4MC8weDJhMCkgZnJvbSBbPGMwMDNmN2I4
Pl0gZnJvbSBbPGMwMDNmN2I4Pl0gKGRvX3RyYW5zbGF0aW9uX2ZhdWx0KzB4MjQvMHgxMDgpCgoo
ZG9fdHJhbnNsYXRpb25fZmF1bHQrMHgyNC8weDEwOCkKCls8YzAwM2Y3OTQ+XSBbPGMwMDNmNzk0
Pl0gKGRvX3RyYW5zbGF0aW9uX2ZhdWx0KzB4MC8weDEwOCkgKGRvX3RyYW5zbGF0aW9uX2ZhdWx0
KzB4MC8weDEwOCkgZnJvbSBbPGMwMDNmOGY0Pl0gZnJvbSBbPGMwMDNmOGY0Pl0gKGRvX0RhdGFB
Ym9ydCsweDNjLzB4MTFjKQoKKGRvX0RhdGFBYm9ydCsweDNjLzB4MTFjKQoKIHI3ID0gMDAwMDA4
MDUgIHI3ID0gMDAwMDA4MDUgIHI2ID0gMDAwMDAwMEYgIHI2ID0gMDAwMDAwMEYgIHI1ID0gQzA1
NDNEOTggIHI1ID0gQzA1NDNEOTggIHI0ID0gRkZGRkZGRkYKCiByNCA9IEZGRkZGRkZGCgpbPGMw
MDNmOGI4Pl0gWzxjMDAzZjhiOD5dIChkb19EYXRhQWJvcnQrMHgwLzB4MTFjKSAoZG9fRGF0YUFi
b3J0KzB4MC8weDExYykgZnJvbSBbPGMwMDM4OWEwPl0gZnJvbSBbPGMwMDM4OWEwPl0gKF9fZGFi
dF9zdmMrMHg0MC8weDYwKQoKKF9fZGFidF9zdmMrMHg0MC8weDYwKQoKWzxjMDA0NTlhMD5dIFs8
YzAwNDU5YTA+XSAoX19pcGlwZV9tYWNoX2RlbXV4X2lycSsweDAvMHgxMGMpIChfX2lwaXBlX21h
Y2hfZGVtdXhfaXJxKzB4MC8weDEwYykgZnJvbSBbPGMwMDNlMjMwPl0gZnJvbSBbPGMwMDNlMjMw
Pl0gKF9faXBpcGVfZ3JhYl9pcnErMHhhOC8weGY4KQoKKF9faXBpcGVfZ3JhYl9pcnErMHhhOC8w
eGY4KQoKWzxjMDAzZTE4OD5dIFs8YzAwM2UxODg+XSAoX19pcGlwZV9ncmFiX2lycSsweDAvMHhm
OCkgKF9faXBpcGVfZ3JhYl9pcnErMHgwLzB4ZjgpIGZyb20gWzxjMDAzODlmMD5dIGZyb20gWzxj
MDAzODlmMD5dIChfX2lycV9zdmMrMHgzMC8weDg4KQoKKF9faXJxX3N2YysweDMwLzB4ODgpCgog
cjcgPSBDMDc3RkI0MCAgcjcgPSBDMDc3RkI0MCAgcjYgPSAwMDAwMDAwMSAgcjYgPSAwMDAwMDAw
MSAgcjUgPSAwMDAwRkZGRiAgcjUgPSAwMDAwRkZGRiAgcjQgPSBGRkZGRkZGRgoKIHI0ID0gRkZG
RkZGRkYKCls8YzAwN2ViNDQ+XSBbPGMwMDdlYjQ0Pl0gKGRlZmF1bHRfZW5hYmxlKzB4MC8weDM0
KSAoZGVmYXVsdF9lbmFibGUrMHgwLzB4MzQpIGZyb20gWzxjMDA3ZWJjYz5dIGZyb20gWzxjMDA3
ZWJjYz5dIChkZWZhdWx0X3N0YXJ0dXArMHgyMC8weDJjKQoKKGRlZmF1bHRfc3RhcnR1cCsweDIw
LzB4MmMpCgogcjQgPSAwMDAwMDAwMCAgcjQgPSAwMDAwMDAwMCAKCgpbPGMwMDdlYmFjPl0gWzxj
MDA3ZWJhYz5dIChkZWZhdWx0X3N0YXJ0dXArMHgwLzB4MmMpIChkZWZhdWx0X3N0YXJ0dXArMHgw
LzB4MmMpIGZyb20gWzxjMDA3ZTAzMD5dIGZyb20gWzxjMDA3ZTAzMD5dIChzZXR1cF9pcnErMHgx
NTQvMHgyODApCgooc2V0dXBfaXJxKzB4MTU0LzB4MjgwKQoKWzxjMDA3ZGVkYz5dIFs8YzAwN2Rl
ZGM+XSAoc2V0dXBfaXJxKzB4MC8weDI4MCkgKHNldHVwX2lycSsweDAvMHgyODApIGZyb20gWzxj
MDA3ZTFlYz5dIGZyb20gWzxjMDA3ZTFlYz5dIChyZXF1ZXN0X2lycSsweDkwLzB4YjgpCgoocmVx
dWVzdF9pcnErMHg5MC8weGI4KQoKIHI4ID0gMDAwMDAwMDAgIHI4ID0gMDAwMDAwMDAgIHI3ID0g
QzAxQ0FCQzAgIHI3ID0gQzAxQ0FCQzAgIHI2ID0gMDAwMDAwMDAgIHI2ID0gMDAwMDAwMDAgIHI1
ID0gRkZGRkZGRjQKCiByNSA9IEZGRkZGRkY0CgogcjQgPSBDMDc3RkI0MCAgcjQgPSBDMDc3RkI0
MCAKCgpbPGMwMDdlMTVjPl0gWzxjMDA3ZTE1Yz5dIChyZXF1ZXN0X2lycSsweDAvMHhiOCkgKHJl
cXVlc3RfaXJxKzB4MC8weGI4KSBmcm9tIFs8YzAxY2IzMjA+XSBmcm9tIFs8YzAxY2IzMjA+XSAo
bmV0X29wZW4rMHhjNC8weDRlMCkKCihuZXRfb3BlbisweGM0LzB4NGUwKQoKWzxjMDFjYjI1Yz5d
IFs8YzAxY2IyNWM+XSAobmV0X29wZW4rMHgwLzB4NGUwKSAobmV0X29wZW4rMHgwLzB4NGUwKSBm
cm9tIFs8YzAyNjhlYzA+XSBmcm9tIFs8YzAyNjhlYzA+XSAoZGV2X29wZW4rMHg1Yy8weGMwKQoK
KGRldl9vcGVuKzB4NWMvMHhjMCkKCiByNiA9IDAwMDAxMDAyICByNiA9IDAwMDAxMDAyICByNSA9
IDAwMDAxMDAzICByNSA9IDAwMDAxMDAzICByNCA9IEMwNzNDODAwICByNCA9IEMwNzNDODAwIAoK
Cls8YzAyNjhlNjQ+XSBbPGMwMjY4ZTY0Pl0gKGRldl9vcGVuKzB4MC8weGMwKSAoZGV2X29wZW4r
MHgwLzB4YzApIGZyb20gWzxjMDI2NmZhND5dIGZyb20gWzxjMDI2NmZhND5dIChkZXZfY2hhbmdl
X2ZsYWdzKzB4NWMvMHgxMzApCgooZGV2X2NoYW5nZV9mbGFncysweDVjLzB4MTMwKQoKIHI0ID0g
QzA3M0M4MDAgIHI0ID0gQzA3M0M4MDAgCgoKWzxjMDI2NmY0OD5dIFs8YzAyNjZmNDg+XSAoZGV2
X2NoYW5nZV9mbGFncysweDAvMHgxMzApIChkZXZfY2hhbmdlX2ZsYWdzKzB4MC8weDEzMCkgZnJv
bSBbPGMwMDFlYTcwPl0gZnJvbSBbPGMwMDFlYTcwPl0gKGlwX2F1dG9fY29uZmlnKzB4MTYwLzB4
ZTc4KQoKKGlwX2F1dG9fY29uZmlnKzB4MTYwLzB4ZTc4KQoKIHI3ID0gMDAwMDEwMDIgIHI3ID0g
MDAwMDEwMDIgIHI2ID0gMDAwMDAwMDEgIHI2ID0gMDAwMDAwMDEgIHI1ID0gQzA3M0M4MDAgIHI1
ID0gQzA3M0M4MDAgIHI0ID0gQzAzNUJFRDQKCiByNCA9IEMwMzVCRUQ0CgpbPGMwMDFlOTEwPl0g
WzxjMDAxZTkxMD5dIChpcF9hdXRvX2NvbmZpZysweDAvMHhlNzgpIChpcF9hdXRvX2NvbmZpZysw
eDAvMHhlNzgpIGZyb20gWzxjMDAzODBjYz5dIGZyb20gWzxjMDAzODBjYz5dIChpbml0KzB4YTAv
MHgyODApCgooaW5pdCsweGEwLzB4MjgwKQoKWzxjMDAzODAyYz5dIFs8YzAwMzgwMmM+XSAoaW5p
dCsweDAvMHgyODApIChpbml0KzB4MC8weDI4MCkgZnJvbSBbPGMwMDVhNjc0Pl0gZnJvbSBbPGMw
MDVhNjc0Pl0gKGRvX2V4aXQrMHgwLzB4YjNjKQoKKGRvX2V4aXQrMHgwLzB4YjNjKQoKIHI3ID0g
MDAwMDAwMDAgIHI3ID0gMDAwMDAwMDAgIHI2ID0gMDAwMDAwMDAgIHI2ID0gMDAwMDAwMDAgIHI1
ID0gMDAwMDAwMDAgIHI1ID0gMDAwMDAwMDAgIHI0ID0gMDAwMDAwMDAKCiByNCA9IDAwMDAwMDAw
CgpDb2RlOiBDb2RlOiBlM2EwMzgwMSBlM2EwMzgwMSBlMWEwMzYxMyBlMWEwMzYxMyBlNTk4MjAw
MCBlNTk4MjAwMCBlMWEwMzgyMyBlMWEwMzgyMyAoZTFjMjMwYjApIChlMWMyMzBiMCkgCgoKICBo
YW5kbGluZyBpcnEgMTUgKHBvcnQgMikgMiwgOCwgYzA1NDM5NzAKCmhhbmRsaW5nIGlycSAxNSAo
cG9ydCAyKSAyLCA4LCBjMDU0Mzk3MAoKaGFuZGxpbmcgaXJxIDE1IChwb3J0IDIpIDMsIDgsIGMw
NTQzODIwCgpoYW5kbGluZyBpcnEgMTUgKHBvcnQgMikgMywgOCwgYzA1NDM4MjAKCmhhbmRsaW5n
IGlycSAxNSAocG9ydCAyKSA0LCA4LCBjMDU0MzZkMAoKaGFuZGxpbmcgaXJxIDE1IChwb3J0IDIp
IDQsIDgsIGMwNTQzNmQwCgpoYW5kbGluZyBpcnEgMTUgKHBvcnQgMikgNSwgOCwgYzA1NDM1ODAK
CmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSA1LCA4LCBjMDU0MzU4MAoKaGFuZGxpbmcgaXJxIDE1
IChwb3J0IDIpIDYsIDgsIGMwNTQzNDMwCgpoYW5kbGluZyBpcnEgMTUgKHBvcnQgMikgNiwgOCwg
YzA1NDM0MzAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSA3LCA4LCBjMDU0MzJlMAoKaGFuZGxp
bmcgaXJxIDE1IChwb3J0IDIpIDcsIDgsIGMwNTQzMmUwCgpoYW5kbGluZyBpcnEgMTUgKHBvcnQg
MikgOCwgOCwgYzA1NDMxOTAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSA4LCA4LCBjMDU0MzE5
MAoKaGFuZGxpbmcgaXJxIDE1IChwb3J0IDIpIDksIDgsIGMwNTQzMDQwCgpoYW5kbGluZyBpcnEg
MTUgKHBvcnQgMikgOSwgOCwgYzA1NDMwNDAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxMCwg
OCwgYzA1NDJlZjAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxMCwgOCwgYzA1NDJlZjAKCmhh
bmRsaW5nIGlycSAxNSAocG9ydCAyKSAxMSwgOCwgYzA1NDJkYTAKCmhhbmRsaW5nIGlycSAxNSAo
cG9ydCAyKSAxMSwgOCwgYzA1NDJkYTAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxMiwgOCwg
YzA1NDJjNTAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxMiwgOCwgYzA1NDJjNTAKCmhhbmRs
aW5nIGlycSAxNSAocG9ydCAyKSAxMywgOCwgYzA1NDJiMDAKCmhhbmRsaW5nIGlycSAxNSAocG9y
dCAyKSAxMywgOCwgYzA1NDJiMDAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxNCwgOCwgYzA1
NDI5YjAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxNCwgOCwgYzA1NDI5YjAKCmhhbmRsaW5n
IGlycSAxNSAocG9ydCAyKSAxNSwgOCwgYzA1NDI4NjAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAy
KSAxNSwgOCwgYzA1NDI4NjAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxNiwgOCwgYzA1NDI3
MTAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxNiwgOCwgYzA1NDI3MTAKCmhhbmRsaW5nIGly
cSAxNSAocG9ydCAyKSAxNywgOCwgYzA1NDI1YzAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAx
NywgOCwgYzA1NDI1YzAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxOCwgOCwgYzA1NDI0NzAK
CmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxOCwgOCwgYzA1NDI0NzAKCmhhbmRsaW5nIGlycSAx
NSAocG9ydCAyKSAxOSwgOCwgYzA1NDIzMjAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAxOSwg
OCwgYzA1NDIzMjAKCmhhbmRsaW5nIGlycSAxNSAocG9ydCAyKSAyMCwgOCwgYzA1NDIxZDAKCmhh
bmRsaW5nIGlycSAxNSAocG9ydCAyKSAyMCwgOCwgYzA1NDIxZDAK

--part46446ee670b88--



