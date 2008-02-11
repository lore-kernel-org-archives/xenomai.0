Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2008 13:25:45 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B02@domain.hid>
In-Reply-To: <47B0ADE8.5060504@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
	<47B0ADE8.5060504@domain.hid>
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

Jan, have patience my friend. I will be reporting bugs regarding LTT
tonight. ;) I have a day job that unfortunately requires my expertise.=20

I have local APIC disabled in the kernel because we don't seem to have
one. I see context switches like these whether or not I use idle=3Dpoll,
and thus the TSC.

Here's my /proc/xenomai/timer:

status=3Don+watchdog:setup=3D3:clock=3D40035659193:timerdev=3Dpit:clockde=
v=3Dtsc

It seems that idle=3Dpoll didn't prevent the tsc from being marked as
unstable despite what the mailing lists say.

Steven

> -----Original Message-----
> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> Sent: Monday, February 11, 2008 1:20 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] irq0
>=20
> Steven Seeger wrote:
> > I used the idle=3Dpoll option so I'm running the tsc now, and irq0
handler
> > still has a lot of overhead.
> >
> >
> >
> > CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
> >
> >   0  0      0          2          0     00500080   94.2  ROOT
> >
> >   0  0      0          1          0     00100082    0.0  sound task
> >
> >   0  0      0          1          0     00100082    0.0  tone task
> >
> > 0  0      0          775585     0     00000000    5.6  IRQ0: [timer]
> >
> >
> >
> > I'm seeing about 17,000 context switches a second for IRQ0. Sound
task
> > and tone task are doing nothing. They're just blocked.
> >
>=20
> Ah! That could mean the timer gets misprogrammed, fires too early and
> thus too often. I had this effect on an standard PC when we used a
> slightly wrong APIC frequency. Do you use the APIC? ->
/proc/xenomai/timer
>=20
> Also this effect can nicely be confirmed via LTTng traces.
>=20
> Jan


