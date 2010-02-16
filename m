Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Feb 2010 14:21:02 -0600
Message-ID: <181804936ABC2349BE503168465576460DD4DE8B@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Supported I-pipe versions?
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

Is there a list of supported I-pipe versions, or is it assumed that any
version is compatible with the current versions of Xenomai?  I have a
PowerPC architecture kernel version 2.6.24.6, using the following adeos
patch:
http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6
.24.6-powerpc-DENX-2.4-03.patch.
=20
I believe this patch was included in the 2.4.10 installer, but I've had
to include this myself for the 2.5.1 installer.
=20
The only reason I ask is because with the Xenomai 2.5.1 I now get
exceptions of the type "BUG: scheduling while atomic" for programs that
previously worked in 2.4.10.  I am still trying to track down more
information.  I just wanted to first make sure I am not having problems
due to the version of kernel and adeos patch.  I am still trying to make
a minimal example that exhibits the issue.

This is the stack trace I get for one particular program:
=20
[  363.207532] BUG: scheduling while atomic: zc_test/1459/0x00000002
[  363.213683] Call Trace:
[  363.216110] [c7155da0] [c00094e8] show_stack+0x60/0x1a8 (unreliable)
[  363.222616] [c7155de0] [c000965c] dump_stack+0x2c/0x44
[  363.227829] [c7155df0] [c001cee8] __schedule_bug+0x7c/0x94
[  363.233307] [c7155e10] [c02cdfb8] schedule+0x4d4/0x4e0
[  363.238517] [c7155e70] [c0076c60] xnshadow_harden+0xf8/0x178
[  363.244168] [c7155e90] [c0076d90] losyscall_event+0xb0/0x380
[  363.249946] [c7155ee0] [c0061ab0] __ipipe_dispatch_event+0x1d4/0x2b8
[  363.256291] [c7155f30] [c000b2f8] __ipipe_syscall_root+0x54/0x144
[  363.262516] [c7155f40] [c0013d60] DoSyscall+0x20/0x5c
[  363.267640] --- Exception: c01 at 0xffd3c60
[  363.271824]     LR =3D 0xffd3c04
[  363.297702] BUG: scheduling while atomic: zc_test/1459/0x00000002
[  363.303821] Call Trace:
[  363.306546] [c7155da0] [c00094e8] show_stack+0x60/0x1a8 (unreliable)
[  363.313652] [c7155de0] [c000965c] dump_stack+0x2c/0x44
[  363.318883] [c7155df0] [c001cee8] __schedule_bug+0x7c/0x94
[  363.324359] [c7155e10] [c02cdfb8] schedule+0x4d4/0x4e0
[  363.329626] [c7155e70] [c0076c60] xnshadow_harden+0xf8/0x178
[  363.335275] [c7155e90] [c0076d90] losyscall_event+0xb0/0x380
[  363.341071] [c7155ee0] [c0061ab0] __ipipe_dispatch_event+0x1d4/0x2b8
[  363.347562] [c7155f30] [c000b2f8] __ipipe_syscall_root+0x54/0x144
[  363.353656] [c7155f40] [c0013d60] DoSyscall+0x20/0x5c
[  363.358789] --- Exception: c01 at 0xff38eac
[  363.362974]     LR =3D 0xff38e14


