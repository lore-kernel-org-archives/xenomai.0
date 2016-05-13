From: TALBI Ahmed -EXT <ahmed.talbi-ext@alstom.com>
Date: Fri, 13 May 2016 13:25:31 +0000
Message-ID: <f5af5dc73c2046f789592c7f15246c24@AM3PR48MB0177.041d.mgd.msft.net>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] system freeze on IMX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,


I'm new to this mailing list so please feel free to correct me if i'm not u=
sing it as it should.

We are facing a freeze on our platform based on a IMX6 soc (see backtrace d=
ump bellow). Please, can anybody take a look to it and give us a feedback  =
or an idea on the root cause of this issue ?


thanks in advance


we use kernel 3.0.35 and xenomai 2.6.4.


cat /proc/cpuinfo:


Processor       : ARMv7 Processor rev 10 (v7l)
processor       : 0
BogoMIPS        : 1574.50
processor       : 1
BogoMIPS        : 1581.05
Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc09
CPU revision    : 10

Hardware        : Phytec i.MX 6Quad phyFLEX Board
Revision        : ffffffea
Serial          : dbc7879c270f81d4


********* backtrace *****************

[ 8164.291368] xnheap: destroying shared heap 'private sem heap [4349]' wit=
h 8 bytes still in use.
[ 8164.465692] xnheap: destroying shared heap 'private sem heap [4352]' wit=
h 8 bytes still in use.
[ 8164.526577] Unable to handle kernel paging request at virtual address 78=
303d63
[ 8164.526766] Xenomai: stuck on nucleus lock 809c4d10
[ 8164.526772]    waiter =3D kernel/xenomai/nucleus/intr.c:114 (xnintr_cloc=
k_handler(), CPU #1)
[ 8164.526779]    owner  =3D kernel/xenomai/nucleus/shadow.c:2580 (do_taske=
xit_event(), CPU #0)
[ 8164.526792] Backtrace:
[ 8164.526827] [<8035981c>] (dump_backtrace+0x0/0x10c) from [<80359c40>] (s=
how_stack+0x18/0x1c)
[ 8164.526840]  r6:00000000 r5:00000001 r4:809c4d10 r3:8004d4e8
[ 8164.526888] [<80359c28>] (show_stack+0x0/0x1c) from [<803f20e4>] (__xnlo=
ck_spin+0x12c/0x180)
[ 8164.526911] [<803f1fb8>] (__xnlock_spin+0x0/0x180) from [<803f159c>] (xn=
intr_clock_handler+0x430/0x498)
[ 8164.526938] [<803f116c>] (xnintr_clock_handler+0x0/0x498) from [<803d70f=
8>] (__ipipe_dispatch_wired_nochec)
[ 8164.526959] [<803d7024>] (__ipipe_dispatch_wired_nocheck+0x0/0x23c) from=
 [<803d72bc>] (__ipipe_dispatch_wi)
[ 8164.526984] [<803d7260>] (__ipipe_dispatch_wired+0x0/0xa0) from [<803608=
a0>] (__ipipe_handle_irq+0xf0/0x29)
[ 8164.526997]  r7:fffffd9d r6:00000000 r5:809fa3a4 r4:0000001d
[ 8164.527032] [<803607b0>] (__ipipe_handle_irq+0x0/0x294) from [<80360b70>=
] (__ipipe_grab_irq+0x68/0x84)
[ 8164.527057] [<80360b08>] (__ipipe_grab_irq+0x0/0x84) from [<8035cb30>] (=
__ipipe_grab_localtimer+0x18/0x1c)
[ 8164.527069]  r6:0000001d r5:f2a00100 r4:ffffffff r3:80000013
[ 8164.527117] [<8035cb18>] (__ipipe_grab_localtimer+0x0/0x1c) from [<80355=
440>] (__irq_svc+0x40/0xd4)
[ 8164.527147] [<80367570>] (arch_idle+0x0/0x80) from [<80356718>] (__ipipe=
_halt_root+0x54/0x9c)
[ 8164.527165] [<803566c4>] (__ipipe_halt_root+0x0/0x9c) from [<80356788>] =
(default_idle+0x28/0x30)
[ 8164.527177]  r5:9ffaa000 r4:9ffaa000
[ 8164.527201] [<80356760>] (default_idle+0x0/0x30) from [<8035698c>] (cpu_=
idle+0x98/0x118)
[ 8164.527228] [<803568f4>] (cpu_idle+0x0/0x118) from [<8084a700>] (seconda=
ry_start_kernel+0x13c/0x160)
[ 8164.527241]  r8:1000406a r7:809e2f40 r6:10c03c7d r5:00000001 r4:809c6440
[ 8164.527270] r3:00000000
[ 8164.527292] [<8084a5c4>] (secondary_start_kernel+0x0/0x160) from [<1084a=
054>] (0x1084a054)
[ 8164.527303]  r5:00000015 r4:2ffac06a
[ 8164.719404] pgd =3D 80004000
[ 8164.722125] [78303d63] *pgd=3D00000000
[ 8164.725738] Internal error: Oops: 5 [#1] PREEMPT SMP
[ 8164.730716] Modules linked in: ksz8462_h rtpacket nomac rtmac rtnet xeno=
_can_flexcan xeno_can spartan
[ 8164.740153] CPU: 0    Not tainted  (3.0.43-tpcom_run2-PD13.2.4 #1)
[ 8164.746358] PC is at strnlen+0x18/0x60
[ 8164.750124] LR is at string.isra.2+0x34/0xd4
[ 8164.754409] pc : [<806b4384>]    lr : [<806b620c>]    psr: a0000093
[ 8164.754415] sp : 8f617b3c  ip : 8f617b50  fp : 8f617b4c
[ 8164.765917] r10: 8f617cdc  r9 : 8087d9a4  r8 : 00000000
[ 8164.771154] r7 : ffffffff  r6 : 78303d63  r5 : 809e48c0  r4 : 809e4545
[ 8164.777696] r3 : 00000000  r2 : 78303d63  r1 : ffffffff  r0 : 78303d63
[ 8164.784240] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t user
[ 8164.791479] Control: 10c53c7d  Table: 1f37404a  DAC: 00000015
[ 8164.797238] Process sh (pid: 4352, stack limit =3D 0x8f6162f0)
[ 8164.802912] Stack: (0x8f617b3c to 0x8f618000)
[ 8164.807283] 7b20:                                                       =
         809e4545
[ 8164.815479] 7b40: 8f617b74 8f617b50 806b620c 806b4378 00000000 80932267 =
80932269 00000002
[ 8164.823674] 7b60: 809e48c0 809e4545 8f617bcc 8f617b78 806b71f4 806b61e4 =
ffffffff ffffffff
[ 8164.831870] 7b80: ffffffff ffffffff 8f617bcc 00000000 00000400 809e44c0 =
ff0a0004 ffffffff
[ 8164.840065] 7ba0: 8f617be4 00000400 809c217c 809e44c0 00000400 00000000 =
8f617cc4 80932214
[ 8164.848260] 7bc0: 8f617be4 8f617bd0 806b74cc 806b7030 8f617cc4 00000000 =
8f617c84 8f617be8
[ 8164.856455] 7be0: 8038d124 806b74c4 8b9f4f00 8bf0cfc8 8f617c14 8f617c00 =
803d7594 00000080
[ 8164.864649] 7c00: 8034d92c 8f616000 00000000 809e4408 809f4d20 8004a800 =
8f617c5c 8f617c28
[ 8164.872845] 7c20: 803d49e8 803d4054 00200200 00100100 00000000 00000000 =
809b5d68 809f4d20
[ 8164.881040] 7c40: 809f4d20 8004a800 8f617c8c 8f617c58 00000004 803d4054 =
803d7594 00000000
[ 8164.889235] 7c60: 60000093 00000000 00000001 80932214 80868810 00000034 =
8f617cbc 8f617c88
[ 8164.897429] 7c80: 8084d9fc 8038d030 00000000 8f617cc4 9603ccf0 9603ccf0 =
00000000 00000000
[ 8164.905625] 7ca0: 8004a800 80933fc8 80868810 00000034 8f617d24 8f617cd0 =
803f20d8 8084d824
[ 8164.913820] 7cc0: 80932214 9603ccf0 80933fc8 00000034 80868810 00000000 =
78303d63 37343232
[ 8164.922015] 7ce0: 66646164 3965362e 809c4d10 809b5d68 66646164 37343232 =
804d7bd8 9603cce0
[ 8164.930210] 7d00: ffff0f40 a0882600 00000000 809b5d68 809b5d68 00000001 =
8f617d7c 8f617d28
[ 8164.938405] 7d20: 804b153c 803f1fc4 8004a808 a0883170 0001fffe a0882f38 =
8004a800 8004a808
[ 8164.946600] 7d40: 809b5d68 80a0a8f8 bc3cfec0 000002f0 804d3654 809c4d10 =
00000000 a0882608
[ 8164.954795] 7d60: a0882600 00000003 809b5d68 80a0a8f8 8f617dc4 8f617d80 =
804b1884 804b0e70
[ 8164.962990] 7d80: 8050e5d0 803d7620 00000000 00000000 9fff2600 ffffffff =
00000000 80a0d068
[ 8164.971185] 7da0: a0875a20 a0882608 00000008 80a0a8f0 00000001 80a0a8f8 =
8f617dec 8f617dc8
[ 8164.979380] 7dc0: 803f959c 804b16d4 a0875a30 8bc06808 a0882608 00000001 =
80a0a8e0 000000f5
[ 8164.987575] 7de0: 8f617e54 8f617df0 803ffd04 803f9554 80432bf4 804315fc =
9fff2600 9fff88c0
[ 8164.995770] 7e00: 80a0a8f0 00000003 80851c78 9a7029c0 bc3cd840 000002f0 =
bc3cd95f 000002f0
[ 8165.003965] 7e20: 00000001 809b5d68 8f617e6c a0882608 80a0a8f8 809c4d10 =
80a0a8f0 80a0d770
[ 8165.012160] 7e40: 00000000 809b5d68 8f617ee4 8f617e58 80436fb0 803fed18 =
0000006f 8bc06808
[ 8165.020355] 7e60: 00000b30 809f4d20 8bc06808 00000b30 809f4d20 50534531 =
8f617ef4 8f617e88
[ 8165.028550] 7e80: 803d6524 803d4054 8004a800 95a19360 bc3ccc51 000002f0 =
8004a800 9a703860
[ 8165.036745] 7ea0: 00000000 00000011 00008000 00000000 8004a800 0000000f =
8004a808 8bc06808
[ 8165.044940] 7ec0: 00000b30 809f4d20 809b5d68 80436de4 8bc06808 809c4680 =
8f617f54 8f617ee8
[ 8165.053135] 7ee0: 803d6610 80436df0 8004a800 8004a800 ffffbfff ffffffff =
8004a800 95a19360
[ 8165.061330] 7f00: 809f4d20 00000010 00004000 00000000 8004a800 0000000e =
8004a808 20000013
[ 8165.069525] 7f20: 00000000 809f4d20 8038ec58 95a19360 8f616000 00000001 =
00000000 9a703860
[ 8165.077720] 7f40: 0000006f 9ac3d540 8f617f74 8f617f58 803903d4 803d643c =
8f616000 00000001
[ 8165.085915] 7f60: 8f617fb0 000000f8 8f617f94 8f617f78 803907f8 80390294 =
00000000 00084017
[ 8165.094110] 7f80: 00084008 000000f8 8f617fa4 8f617f98 80390884 803907b4 =
00000000 8f617fa8
[ 8165.102304] 7fa0: 80355ac0 80390878 00000000 00084017 00000000 2ab2c4c0 =
00000000 00000000
[ 8165.110500] 7fc0: 00000000 00084017 00084008 000000f8 ffffffff 00000000 =
2aae7000 00000000
[ 8165.118695] 7fe0: 00091dfc 7eb208d8 00091e10 2acfc340 60000010 00000000 =
00000000 00000000
[ 8165.126885] Backtrace:
[ 8165.129371] [<806b436c>] (strnlen+0x0/0x60) from [<806b620c>] (string.is=
ra.2+0x34/0xd4)
[ 8165.137389]  r4:809e4545
[ 8165.139963] [<806b61d8>] (string.isra.2+0x0/0xd4) from [<806b71f4>] (vsn=
printf+0x1d0/0x410)
[ 8165.148327]  r8:809e4545 r7:809e48c0 r6:00000002 r5:80932269 r4:80932267
[ 8165.154953] r3:00000000
[ 8165.157627] [<806b7024>] (vsnprintf+0x0/0x410) from [<806b74cc>] (vscnpr=
intf+0x14/0x2c)
[ 8165.165657] [<806b74b8>] (vscnprintf+0x0/0x2c) from [<8038d124>] (vprint=
k+0x100/0x524)
[ 8165.173587]  r4:00000000 r3:8f617cc4
[ 8165.177228] [<8038d024>] (vprintk+0x0/0x524) from [<8084d9fc>] (printk+0=
x1e8/0x2a8)
[ 8165.184907] [<8084d814>] (printk+0x0/0x2a8) from [<803f20d8>] (__xnlock_=
spin+0x120/0x180)
[ 8165.193097]  r3:00000034 r2:80933fc8 r1:9603ccf0 r0:80932214
[ 8165.198864] [<803f1fb8>] (__xnlock_spin+0x0/0x180) from [<804b153c>] (th=
read_destroy+0x6d8/0x864)
[ 8165.207757] [<804b0e64>] (thread_destroy+0x0/0x864) from [<804b1884>] (t=
hread_delete_hook+0x1bc/0x3cc)
[ 8165.217087] [<804b16c8>] (thread_delete_hook+0x0/0x3cc) from [<803f959c>=
] (xnpod_fire_callouts+0x54/0x98)
[ 8165.226678] [<803f9548>] (xnpod_fire_callouts+0x0/0x98) from [<803ffd04>=
] (xnpod_delete_thread+0xff8/0x1af)
[ 8165.236519]  r8:000000f5 r7:80a0a8e0 r6:00000001 r5:a0882608 r4:8bc06808
[ 8165.243145] r3:a0875a30
[ 8165.245825] [<803fed0c>] (xnpod_delete_thread+0x0/0x1afc) from [<80436fb=
0>] (taskexit_event+0x1cc/0x14c0)
[ 8165.255415] [<80436de4>] (taskexit_event+0x0/0x14c0) from [<803d6610>] (=
__ipipe_dispatch_event+0x1e0/0x484)
[ 8165.265183] [<803d6430>] (__ipipe_dispatch_event+0x0/0x484) from [<80390=
3d4>] (do_exit+0x14c/0x3c8)
[ 8165.274251] [<80390288>] (do_exit+0x0/0x3c8) from [<803907f8>] (do_group=
_exit+0x50/0xc4)
[ 8165.282354]  r7:000000f8
[ 8165.284929] [<803907a8>] (do_group_exit+0x0/0xc4) from [<80390884>] (__w=
ake_up_parent+0x0/0x28)
[ 8165.293640]  r7:000000f8 r6:00084008 r5:00084017 r4:00000000
[ 8165.299404] [<8039086c>] (sys_exit_group+0x0/0x18) from [<80355ac0>] (re=
t_fast_syscall+0x0/0x30)
[ 8165.308209] Code: e24cb004 e3510000 01a00001 089da810 (e5d0c000)
[ 8165.314345] ---[ end trace 1003734c85188a37 ]---
[ 8165.319144] Fixing recursive fault but reboot is needed!
[ 8165.324476] BUG: scheduling while atomic: sh/4352/0x00000003
[ 8165.330146] Modules linked in: ksz8462_h rtpacket nomac rtmac rtnet xeno=
_can_flexcan xeno_can spartan
[ 8165.339571] Backtrace:
[ 8165.342064] [<8035981c>] (dump_backtrace+0x0/0x10c) from [<8084d098>] (d=
ump_stack+0x18/0x1c)
[ 8165.350518]  r6:8f616000 r5:95a19360 r4:00000000 r3:8004d4e8
[ 8165.356285] [<8084d080>] (dump_stack+0x0/0x1c) from [<8084d230>] (__sche=
dule_bug+0x64/0x74)
[ 8165.364663] [<8084d1cc>] (__schedule_bug+0x0/0x74) from [<8085bce4>] (__=
schedule+0x574/0x6ec)
[ 8165.373202]  r4:8bf09ce0 r3:00000000
[ 8165.376839] [<8085b770>] (__schedule+0x0/0x6ec) from [<8085bfc0>] (sched=
ule+0x50/0x68)
[ 8165.384779] [<8085bf70>] (schedule+0x0/0x68) from [<803905f0>] (do_exit+=
0x368/0x3c8)
[ 8165.392543] [<80390288>] (do_exit+0x0/0x3c8) from [<80359cfc>] (die+0xb8=
/0xdc)
[ 8165.399777]  r7:00000005
[ 8165.402350] [<80359c44>] (die+0x0/0xdc) from [<8084d0f8>] (__do_kernel_f=
ault.part.2+0x5c/0x7c)
[ 8165.410975]  r7:8f617af0 r6:00000005 r5:78303d63 r4:00000000
[ 8165.416745] [<8084d09c>] (__do_kernel_fault.part.2+0x0/0x7c) from [<8036=
278c>] (do_page_fault+0x268/0x3a8)
[ 8165.426412]  r7:78303d63 r3:8f617af0
[ 8165.430049] [<80362524>] (do_page_fault+0x0/0x3a8) from [<80362b9c>] (do=
_translation_fault+0x20/0x24)
[ 8165.439292] [<80362b7c>] (do_translation_fault+0x0/0x24) from [<8034f4b8=
>] (do_DataAbort+0x3c/0x248)
[ 8165.448451] [<8034f47c>] (do_DataAbort+0x0/0x248) from [<803553d0>] (__d=
abt_svc+0x70/0xa0)
[ 8165.456948] Exception stack(0x8f617af0 to 0x8f617b38)
[ 8165.462099] 7ae0:                                     78303d63 ffffffff =
78303d63 00000000
[ 8165.470297] 7b00: 809e4545 809e48c0 78303d63 ffffffff 00000000 8087d9a4 =
8f617cdc 8f617b4c
[ 8165.478493] 7b20: 8f617b50 8f617b3c 806b620c 806b4384 a0000093 ffffffff
[ 8165.485133] [<806b436c>] (strnlen+0x0/0x60) from [<806b620c>] (string.is=
ra.2+0x34/0xd4)
[ 8165.493151]  r4:809e4545
[ 8165.495724] [<806b61d8>] (string.isra.2+0x0/0xd4) from [<806b71f4>] (vsn=
printf+0x1d0/0x410)
[ 8165.504088]  r8:809e4545 r7:809e48c0 r6:00000002 r5:80932269 r4:80932267
[ 8165.510716] r3:00000000
[ 8165.513388] [<806b7024>] (vsnprintf+0x0/0x410) from [<806b74cc>] (vscnpr=
intf+0x14/0x2c)
[ 8165.521416] [<806b74b8>] (vscnprintf+0x0/0x2c) from [<8038d124>] (vprint=
k+0x100/0x524)
[ 8165.529345]  r4:00000000 r3:8f617cc4
[ 8165.532985] [<8038d024>] (vprintk+0x0/0x524) from [<8084d9fc>] (printk+0=
x1e8/0x2a8)
[ 8165.540666] [<8084d814>] (printk+0x0/0x2a8) from [<803f20d8>] (__xnlock_=
spin+0x120/0x180)
[ 8165.548856]  r3:00000034 r2:80933fc8 r1:9603ccf0 r0:80932214
[ 8165.554709] [<803f1fb8>] (__xnlock_spin+0x0/0x180) from [<804b153c>] (th=
read_destroy+0x6d8/0x864)
[ 8165.563603] [<804b0e64>] (thread_destroy+0x0/0x864) from [<804b1884>] (t=
hread_delete_hook+0x1bc/0x3cc)
[ 8165.572933] [<804b16c8>] (thread_delete_hook+0x0/0x3cc) from [<803f959c>=
] (xnpod_fire_callouts+0x54/0x98)
[ 8165.582605] [<803f9548>] (xnpod_fire_callouts+0x0/0x98) from [<803ffd04>=
] (xnpod_delete_thread+0xff8/0x1af)
[ 8165.592449]  r8:000000f5 r7:80a0a8e0 r6:00000001 r5:a0882608 r4:8bc06808
[ 8165.599077] r3:a0875a30
[ 8165.601754] [<803fed0c>] (xnpod_delete_thread+0x0/0x1afc) from [<80436fb=
0>] (taskexit_event+0x1cc/0x14c0)
[ 8165.611344] [<80436de4>] (taskexit_event+0x0/0x14c0) from [<803d6610>] (=
__ipipe_dispatch_event+0x1e0/0x484)
[ 8165.621109] [<803d6430>] (__ipipe_dispatch_event+0x0/0x484) from [<80390=
3d4>] (do_exit+0x14c/0x3c8)
[ 8165.630176] [<80390288>] (do_exit+0x0/0x3c8) from [<803907f8>] (do_group=
_exit+0x50/0xc4)
[ 8165.638281]  r7:000000f8
[ 8165.640853] [<803907a8>] (do_group_exit+0x0/0xc4) from [<80390884>] (__w=
ake_up_parent+0x0/0x28)
[ 8165.649565]  r7:000000f8 r6:00084008 r5:00084017 r4:00000000
[ 8165.655330] [<8039086c>] (sys_exit_group+0x0/0x18) from [<80355ac0>] (re=
t_fast_syscall+0x0/0x30)
[ 8178.084852] Xenomai: stuck on nucleus lock 809c4d10
[ 8178.084857]    waiter =3D kernel/xenomai/nucleus/intr.c:114 (xnintr_cloc=
k_handler(), CPU #1)
[ 8178.084865]    owner  =3D kernel/xenomai/nucleus/shadow.c:2580 (do_taske=
xit_event(), CPU #0)



________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.
