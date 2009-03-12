Message-ID: <881791.69224.qm@domain.hid>
Date: Thu, 12 Mar 2009 14:17:13 -0700 (PDT)
From: Yigal Goldberger <yigal_gold@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] kernel BUG in preempt_schedule_irq at
	kernel/sched.c:3114!
Reply-To: yigal_gold@domain.hid
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


Hi,=20
I've also submitted this on the website under Xenomai-support, but I'm not =
sure which is the best way to go... so I'll try this channel as well.

My system is a PPC running kernel 2.6.14.7 patched with Xenomai.=20
My system communicates with the host PC through two RS-232 ports and each p=
ort has also a uart connection to a slave device.=20
The slave device sends interrupts to the CPU on the board , and are handled=
 by a lodable kernel module interrupt handler .=20
When the system works only through a singel port - (RS-232 between the PC a=
nd the board,and uart between the board and a slave device) it works fine, =
but when the 2 ports are stressed together I get the Oops below.I've tried =
working with the uart without interrupts and the Oops still occures .=20


I've looked it up in the System.map file and the addresses correspond to th=
e following :=20
c0004c7c - __ipipe_ret_from_except=20
c0004a40 - somewhere inside resume_kernel.=20


" kernel BUG in preempt_schedule_irq at kernel/sched.c:3114!=20
Oops: Exception in kernel mode, sig: 5 [#1]=20
PREEMPT=20
NIP: C02297A8 LR: C0004A40 SP: C0286170 REGS: c02860c0 TRAP: 0700 Tainted: =
P=20
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=20
TASK =3D c0265b00[0] 'swapper' THREAD: c0286000=20
Last syscall: 120=20
GPR00: 00000001 C0286170 C0265B00 00009032 00000000 00003032 00600084 C02B5=
594=20
GPR08: C0280000 C0286000 00000001 C026A200 512037AD 4377FFBF 0FFFD000 00000=
000=20
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 0FFF7E68 00000000 00000002 0FBC6=
2B0=20
GPR24: 00000000 00000000 40000000 007FFF7D 007FFF00 C02A0000 C0265B00 C02A2=
8F0=20
Call trace: [c0004a40] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7=
c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004=
c7c] [c0004c7c] [c0004c7c]=20
Kernel panic - not syncing: Attempted to kill the idle task!=20
<0>Rebooting in 1 seconds..=FE "=20


Does anyone have an idea why this is happening and what am I doing wrong ?=
=20


Thanks,=20
Yigal.=20

=0A=0A=0A      

