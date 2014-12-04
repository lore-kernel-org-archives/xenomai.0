MIME-Version: 1.0
Sender: nunez.cedric@gmail.com
Date: Thu, 4 Dec 2014 16:41:12 +0100
Message-ID: <CAPM60ws2F-7PFASr0MkZOn5ZqxnG=GnKUx9vwWteTZEUhxP+VQ@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric?= <freecedric@free.fr>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I want also use the xeno_16550A with a Beaglebone,
I have the same kernel (  Debian 3.8.13-bone64) and the same xenomai 2.6.4.
Actually I have:
- disable CONFIG_SERIAL_OMAP in kernel configuration
- disable CONFIG_SERIAL_8250
- xeno_16550A as loadable module and patch with your patch


First :

setserial -g /dev/ttyS*
/dev/ttyS0, UART: unknown, Port: 0x0000, IRQ: 0
/dev/ttyS1, UART: unknown, Port: 0x0000, IRQ: 0
/dev/ttyS2, UART: unknown, Port: 0x0000, IRQ: 0
/dev/ttyS3, UART: unknown, Port: 0x0000, IRQ: 0

Second :
modprobe xeno_16550A mem=0x48024000 irq=74 baud_base=115200 tx_fifo=64
regshift=2 regwidth=2 start_index=1

result of dmesg:
[ 2706.679850] Unhandled fault: external abort on non-linefetch (0x1028) at
0xfa024008
[ 2706.680024] Internal error: : 1028 [#1] SMP THUMB2
[ 2706.680106] Modules linked in: xeno_16550A(+) 8250_core g_multi
libcomposite omap_rng omap_serial rtc_bq32k gpio_pca953x can_raw can_dev can
[ 2706.680382] CPU: 0    Not tainted  (3.8.13-bone67 #8)
[ 2706.680490] PC is at rt_16550_reg_in+0x25/0x54 [xeno_16550A]
[ 2706.680595] LR is at init_module+0xee/0x1a3 [xeno_16550A]
[ 2706.680687] pc : [<bf85f5ce>]    lr : [<bf8640ef>]    psr: 80000033
[ 2706.680687] sp : dd9dbe28  ip : dd9dbd38  fp : bf8614bc
[ 2706.680844] r10: 00000000  r9 : bf86149c  r8 : decd9b80
[ 2706.680920] r7 : 00000001  r6 : fa024000  r5 : 00000000  r4 : bf861438
[ 2706.681013] r3 : 00000002  r2 : 00000008  r1 : fa024008  r0 : 00000001
[ 2706.681104] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb
Segment user
[ 2706.681222] Control: 50c5387d  Table: 9ebac019  DAC: 00000015
[ 2706.681305] Process modprobe (pid: 643, stack limit = 0xdd9da240)
[ 2706.681392] Stack: (0xdd9dbe28 to 0xdd9dc000)
[ 2706.681460] be20:                   c08c0ce4 c08c0ce4 00000000 00400100
bf8612dc bf8612d0
[ 2706.681573] be40: dd9da000 bf861318 c09068c0 bf864001 00000000 c0008807
c08bf7b4 002a0029
[ 2706.681688] be60: 00000000 dd9da000 002a002a c05016f9 c08bf7b0 c00499f5
00000000 00000007
[ 2706.681800] be80: 00000000 00400100 bf8612dc bf8612d0 dd9da000 bf861318
deaab940 00000001
[ 2706.681915] bea0: 00000124 c006bd19 bf8612dc 00007fff c006901d dd9dbf04
00000124 bf8612dc
[ 2706.682030] bec0: dd9da000 b6fcb288 bf861424 c0886b0c bf8612d0 dd9dbef4
dd9dbf1c c07d4a54
[ 2706.682148] bee0: dd9da000 c0501975 e0d88000 b6dd7000 00000273 00000000
00000000 00000000
[ 2706.682272] bf00: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
[ 2706.682391] bf20: 00000000 00000000 00000000 00000000 20000033 000062f3
b6dd1000 b6fcb288
[ 2706.682505] bf40: 00000080 c000cb68 dd9da000 00000000 00000000 c006c15b
e0d82000 000062f3
[ 2706.682618] bf60: e0d857d8 e0d85685 e0d87b28 00002520 000031f0 00000000
00000000 00000000
[ 2706.682734] bf80: 00000022 00000023 00000017 0000001b 0000000f 00000000
00000000 b6fcb2f0
[ 2706.682847] bfa0: b6fcb228 c000c961 00000000 b6fcb2f0 b6dd1000 000062f3
b6fcb288 00000002
[ 2706.682960] bfc0: 00000000 b6fcb2f0 b6fcb228 00000080 00000000 b6fcb288
000062f3 00000000
[ 2706.683073] bfe0: 00040000 beb1d384 b6f82b07 b6f0dfd4 80000010 b6dd1000
9fefe821 9fefec21
[ 2706.683225] [<bf85f5ce>] (rt_16550_reg_in+0x25/0x54 [xeno_16550A]) from
[<bf8640ef>] (init_module+0xee/0x1a3 [xeno_16550A])
[ 2706.683397] [<bf8640ef>] (init_module+0xee/0x1a3 [xeno_16550A]) from
[<c0008807>] (do_one_initcall+0xc7/0x120)
[ 2706.683544] [<c0008807>] (do_one_initcall+0xc7/0x120) from [<c006bd19>]
(load_module+0x1251/0x1630)
[ 2706.683675] [<c006bd19>] (load_module+0x1251/0x1630) from [<c006c15b>]
(sys_init_module+0x63/0x90)
[ 2706.683806] [<c006c15b>] (sys_init_module+0x63/0x90) from [<c000c961>]
(ret_fast_syscall+0x1/0x46)
[ 2706.683932] Code: 4b0c 6c1b 409a 1851 (880b) f3bf
[ 2706.690140] ---[ end trace 781415ad731ff6a1 ]---


Do you have the same problem ?
