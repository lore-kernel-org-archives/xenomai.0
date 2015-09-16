Message-ID: <30CDC0E48A9B4ED496A94C7F5B511635@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Wed, 16 Sep 2015 19:45:54 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg: Linux OOps
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "SDG'08@dP_Jagat Bhusan" <jagat.bhusan@datapatterns.co.in>, sureshvsmca@gmail.com

Hi

ARCH=3DpowerPC
Processor: MPC8641
Linux Kernel : 3.10.32
Xenomai patch version: xenomai-2.6.3

We are getting the below oops randomly.kindly help us to isolate the =
problem with the stack trace given below.


Oops: Kernel access of bad area, sig: 11 [#1]
[12981.709964] VPX
[12981.711706] Modules linked in: dp_elpc_rt(O) xeno_16550A =
DPXMC5022_DRV(O) dpxmc1107xen(O) dpvpx5849xen(O) dp1553bxt(O) =
DPVPX0689_WDT_drv(O) DPVPX0689_Timer(O) DPVPX0689_NVSRAM_drv(O) =
DPVPX0689TS(O) [last unloaded: dp_elpc_rt]
[12981.731718] CPU: 0 PID: 3941 Comm: PROGRESS_THREAD Tainted: G         =
  O 3.10.32-dpvpx0689 #177
[12981.740494] task: cf497840 ti: cf052000 task.ti: cf052000
[12981.745882] NIP: 00000000 LR: a007477c CTR: 00000000
[12981.750836] REGS: cf053c40 TRAP: 0400   Tainted: G           O  =
(3.10.32-dpvpx0689)
[12981.758479] MSR: 40001032 <ME,IR,DR,RI>  CR: 24004422  XER: 00000000
[12981.764839]=20
GPR00: a007477c cf053cf0 cf497840 00000203 00000000 00000000 00010000 =
a0649728=20
GPR08: 00000000 00000000 00000000 40fd2a34 24004422 1001b5d8 00000000 =
00000000=20
GPR16: 3c033000 9fe21d58 9fe21d68 0ff52518 00000003 3c022018 00021000 =
0ffc81c4=20
GPR24: cf053f50 00000200 00000001 a0670000 a0649728 a06ceb80 a06d2c00 =
00000203=20
[12981.794546] NIP [00000000]   (null)
[12981.798033] LR [a007477c] __ipipe_do_sync_stage+0x13c/0x1ec
[12981.803593] Call Trace:
[12981.806032] [cf053cf0] [a007477c] __ipipe_do_sync_stage+0x13c/0x1ec =
(unreliable)
[12981.813427] [cf053d20] [a000e960] __ipipe_grab_irq+0x38/0x6c
[12981.819081] [cf053d30] [a00108f4] __ipipe_ret_from_except+0x0/0xc
[12981.825173] --- Exception: 501 at ipipe_unstall_head+0x44/0x8c
[12981.825173]     LR =3D xnpod_suspend_thread+0x248/0x2a4
[12981.836033] [cf053df0] [a007b298] __xnpod_schedule+0x320/0x5d0 =
(unreliable)
[12981.842989] [cf053e00] [a007b9e4] xnpod_suspend_thread+0x248/0x2a4
[12981.849164] [cf053e30] [a00850b4] xnshadow_relax+0x7c/0x160
[12981.854729] [cf053ed0] [a0085924] hisyscall_event+0x1cc/0x350
[12981.860466] [cf053f00] [a0074444] __ipipe_notify_syscall+0xa0/0x110
[12981.866726] [cf053f30] [a000ea78] __ipipe_syscall_root+0x44/0x134
[12981.872811] [cf053f40] [a000fea8] DoSyscall+0x20/0x5c
[12981.877854] --- Exception: c01 at 0xfe97870
[12981.877854]     LR =3D 0xfe97858
[12981.885066] Instruction dump:
[12981.888026] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX=20
[12981.895773] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX=20
[12981.979104] Unable to handle kernel paging request for instruction =
fetch
[12981.986105] Faulting instruction address: 0x00000000
[12982.009007] ---[ end trace 66dee98248d13381 ]---
[12982.013929]=20


Regards
suresh V.S

