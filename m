Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2008 13:44:21 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B08@domain.hid>
In-Reply-To: <47B0B1E0.7030701@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
	<47B0ADE8.5060504@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B02@domain.hid>
	<47B0B1E0.7030701@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] irq0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

All right. I'll re-use Philippe's patch that disables TSC on geode and
compile the libs for use without TSC. However, this will not help my
overhead problems, correct? Won't it make them worse?

If xenomai is using tsc, then that's a good thing. The timing is all
correct it seems, and the jitter is low.

Steven

> -----Original Message-----
> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> Sent: Monday, February 11, 2008 1:37 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] irq0
>=20
> Steven Seeger wrote:
> > Jan, have patience my friend. I will be reporting bugs regarding LTT
> > tonight. ;) I have a day job that unfortunately requires my
expertise.
>=20
> You have many fires to fight, I understand. :)
>=20
> > I have local APIC disabled in the kernel because we don't seem to
have
> > one. I see context switches like these whether or not I use
idle=3Dpoll,
> > and thus the TSC.
> >
> > Here's my /proc/xenomai/timer:
> >
> >
status=3Don+watchdog:setup=3D3:clock=3D40035659193:timerdev=3Dpit:clockde=
v=3Dtsc
> >
> > It seems that idle=3Dpoll didn't prevent the tsc from being marked =
as
> > unstable despite what the mailing lists say.
>=20
> But Xenomai picks it independent of Linux' decision as its clockdev -
so
> their might be glitches between the time bases of pit and tsc. You
> should try to build your kernel with CONFIG_M586. That will make
Xenomai
> pick the PIT for time keeping too.
>=20
> If TSC is truly broken on your box, you cannot gain anything with
> keeping it for Xenomai.
>=20
> Jan


