Message-ID: <259BFDBD42EA42CB9CCA8C1BAA3C3939@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Thu, 1 Sep 2016 20:06:25 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Machine Check Exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: sureshvsmca@gmail.com

Hi
ARCH=3DpowerPC
Processor: MPC8641
Linux Kernel : 3.10.32
Xenomai patch version: xenomai-2.6.3
ipipe : ipipe-core-3.10.32-powerpc-2.patch

We are getting the below assertion randomly.

kindly help us to isolate the problem, stack trace during assertion is give=
n below

[ 830.444860] Machine check in kernel mode.

[ 830.449136] Caused by (from SRR1=3D149030): Transfer error ack signal

[ 830.457936] Oops: Machine check, sig: 7 [#1]

[ 830.463554] VPX

[ 830.465295] Modules linked in: DPVPX0689_NVSRAM_drv(O) dpvpx5270(O) DP_SR=
IO_drv(O) [last unloaded: DPVPX0689_NVSRAM_drv]

[ 830.476171] CPU: 0 PID: 886 Comm: DP-RDR-8044-RSC Tainted: G O 3.10.32-dp=
vpx0689 #207

[ 830.484860] task: cf309f40 ti: ca908000 task.ti: ca908000

[ 830.490247] NIP: d20ca454 LR: d20c8fe4 CTR: d20ca4b4

[ 830.495202] REGS: ca909da0 TRAP: 0200 Tainted: G O (3.10.32-dpvpx0689)

[ 830.502845] MSR: 00149030 <EE,ME,IR,DR> CR: 42004448 XER: 00000000

[ 830.509205]=20

[ 830.509205] GPR00: d20c8fe4 ca909e50 cf309f40 cf2bec00 00000800 f4300850 =
3e9fecbc 000079d7=20

[ 830.509205] GPR08: 00000000 00000080 ffff66a0 28002422 a0015ddc 100414f8 =
00000000 00000000=20

[ 830.509205] GPR16: 00000000 00000000 00000000 100c78cc 100c78ec 00000000 =
00000000 00000000=20

[ 830.509205] GPR24: ca909f50 a06b0000 a06f14e0 cf2bec00 c00e6107 0000000e =
3e9fec8a ca8f3310=20

[ 830.538911] NIP [d20ca454] +0x64/0xcc [dpvpx5270]

[ 830.545257] LR [/0x1450 [dpvpx5270]

[ 830.551425] Call Trace:d20c8fe4] dpvpx5270_ioctl+0x82c

[ 830.553863] [ca909e50] [0000000e] 0xe (unreliable)

[ 830.558650] [ca909e60] [d20c8fe4] dpvpx5270_ioctl+0x82c/0x1450 [dpvpx5270]

[ 830.565521] [ca909e80] [a00b3000] __rt_dev_ioctl+0x84/0x1cc

[ 830.571091] [ca909ed0] [a0087664] losyscall_event+0xc4/0x25c

[ 830.576744] [ca909f00] [a007667c] __ipipe_notify_syscall+0xa0/0x110

[ 830.583007] [ca909f30] [a000ea78] __ipipe_syscall_root+0x44/0x134

[ 830.589095] [ca909f40] [a000fea8] DoSyscall+0x20/0x5c

[ 830.594138] --- Exception: c01 at 0xfd9f960

[ 830.594138] LR =3D 0xfd9f91c

[ 830.601349] Instruction dump:

[ 830.604308] 3860fc19 38210010 7c0803a6 4e800020 2b840009 409d0044 3880000=
0 812300e2=20

[ 830.612058] 7ca54a14 7ca52214 7c0004ac 7d202c2c <0c090000> 4c00012c 7d203=
52c 38600001=20

[ 830.619995] ---[ end trace 0d4254a0d4a1fad4 ]---

Reagrds
suresh V.S


**************** CAUTION - Disclaimer *****************This email may conta=
in confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribu=
tion or disclosure by others is strictly prohibited. If you are not the int=
ended recipient (or authorized to receive for the recipient), please contac=
t the sender by reply email and delete all copies of this message. Also, em=
ail is susceptible to data corruption, interception, tampering, unauthorize=
d amendment and viruses. We only send and receive emails on the basis that =
we are not liable for any such corruption, interception, tampering, amendme=
nt or viruses or any consequence thereof.=20
*********** End of Disclaimer ***********DataPatterns ITS Group**********

