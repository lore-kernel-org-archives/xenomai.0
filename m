Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 May 2010 11:27:44 -0500
Message-ID: <181804936ABC2349BE503168465576460EBD6239@domain.hid>
In-Reply-To: <4BED2910.6020105@domain.hid>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>
	<4BED2910.6020105@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Andreas Glatz <AndreasGlatz@domain.hid>
Cc: xenomai@xenomai.org

> > Hi,
> >=20
> > We had a similar problem. We solved it by compiling the=20
> native skin as=20
> > a module and loading it _after_ the kernel has been=20
> syncronized with=20
> > the real-time clock chip.
>=20
> Yes, that works too. There is also an option in the kernel=20
> for the kernel to synchronize with the RTC clock directly,=20
> without requiring hwclock. I do not know if it is run before=20
> starting Xenomai though.

I have a similar requirement, except I want to keep the Xenomai clock
synchronized with Linux services that use adjtime/adjtimex, e.g. NTP.
It is not sufficient in this case to delay the startup of Xenomai.  I
suppose as a workaround I could create a low priority periodic thread
that reads the Linux clock with gettimeofday and sets the Xenomai one
with clock_settime.

Any other suggestions for providing timestamps to real time tasks in
this case?

Thanks.


