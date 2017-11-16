Message-ID: <F02BB7EFB632496685EA867D9DF7E500@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Thu, 16 Nov 2017 19:04:58 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg: Xenomai -3 FPU Exception
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

ARCH=3DPowerPc (MPC8641D)
vanilla kernel : linux-3.10.32
ipipe :  ipipe-core-3.10.32-powerpc-9.patch
Xenomai version : xenomai- 3.0.3=20

  We are using PowerPC processor with above mentioned kernel and xenomai ve=
rsion (with cobalt configuration)
=20
Our application running in userspace.When using floating point operation in=
 rt_task we are  getting below fpu exception.
Kindly help us to fix the issue.


Unrecoverable FP Unavailable Exception 801 at a0003870
Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
DPVPX0899
Modules linked in: DPVPX0899_FPGA_drv(O) DPVPX0899_NVSRAM_drv(O) DPVPX0899_=
SRIO_drv(O) [last unloaded: DPVPX0899_SRIO_drv]
CPU: 0 PID: 839 Comm: COMM_Task Tainted: G           O 3.10.32-dpvpx0899 #35
task: bbe4d200 ti: be570000 task.ti: be570000
NIP: a0003870 LR: a0006478 CTR: a008f68c
REGS: be571e40 TRAP: 0801   Tainted: G           O  (3.10.32-dpvpx0899)
MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 28044428  XER: 20000000

GPR00: a000646c be571ef0 bbe4d200 be571ef8 be571efc 00003032 00000000 00004=
000=20
GPR08: 0000d032 a0440000 00000000 00000000 28002422=20
NIP [a0003870] cvt_df+0x0/0xc
LR [a0006478] fix_alignment+0x1d0/0x8b8
Call Trace:
[be571ef0] [a000646c] fix_alignment+0x1c4/0x8b8 (unreliable)
[be571f30] [a000c2d8] alignment_exception+0xbc/0x100
[be571f40] [a00105d0] ret_from_except_full+0x0/0x4c
--- Exception: 600 at 0x1000a878
    LR =3D 0x10009e6c
Instruction dump:
3c80a044 90a41048 70c68000 4d820020 7ca000a6 60a58000 7ca00124 4c00012c=20
4e800020 c0030000 d8040000 4e800020 <c8030000> d0040000 4e800020 7ca000a6=20
---[ end trace 9dd2c340c5a65426 ]---

Regard
Suresh
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

