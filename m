Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
Date: Fri, 19 May 2006 13:28:59 -0500
Message-ID: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F285@domain.hid>
From: "Rosenow, Jim" <Jim.Rosenow@domain.hid>
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

Sorry for the missing history.

I started with a vanilla 2.6.14-7 kernel from kernel.org, I patched it
with a Motorola patch to enable the features specific to the mvme5500.
I built under ELDK 4.0 and the kernel ran just fine.

Next I retrieved xenomai-2.1.1 and followed the install instructions.
The adeos version adeos-ipipe-2.6.14-1.2.03.patch.  This patch applied
and I rebuilt the kernel.  I ran into a problem with xmon not compiling
so I removed that switch from the kernel hacking menu and it built fine.

That brings us to now.

In reference to your recommendation, can I simply disable ipipe and
leave xenomai enabled and expect the kernel to run?  I thought there was
a pretty close coupling between the two.

Thanks for the help.

Jim

-----Original Message-----
From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Sent: May 19, 2006 1:05 PM
To: Rosenow, Jim
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Almost running - kernel BUG in
add_preempt_count at kernel/sched.c:2819!

Rosenow, Jim wrote:
> Hi,
>=20
> I've almost got my mvme5500 running.  I get the following error when
booting up.
>=20
> kernel BUG in add_preempt_count at kernel/sched.c:2819!
>=20
> Oops: kernel access of bad area, sig: 11 [#1]
>=20
> I'm a little new at this and don't know whether I'm looking at a
xenomai problem, an adeos problem, or something else.
>=20
> Any help and direction would be appreciated.
>=20

If unsure where the problem comes from, try to boot a clean kernel
(unpatched) first, then a patched one but with disabled ipipe, and then
one with disabled xenomai. If the bug seems to be ipipe/xeno-related,
please report the patch and the xenomai versions, and also any potential
board-specific patches.

Jan


