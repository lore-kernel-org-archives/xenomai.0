Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 May 2010 12:05:48 -0500
Message-ID: <181804936ABC2349BE503168465576460EBD62C8@domain.hid>
In-Reply-To: <4BF17464.5090100@domain.hid>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>

> Periodically setting the time is risky if timed jobs depend=20
> on Xenomai's real-time clock - it may jump in all directions...
>=20
> >=20
> > Any other suggestions for providing timestamps to real time=20
> tasks in=20
> > this case?
>=20
> Do you just need precise timestamps from with real-time=20
> tasks, or do you have to synchronize timer events of the=20
> Xenomai core on an external clock?
>=20
> For the former case (precisely our scenario), we laid the=20
> ground to extend Xenomai 2.5 with RT-safe syscalls to obtain=20
> Linux's view on gettimeofday. It "just" needs some polishing=20
> to post this for upstream.
> Wolfgang (CC'ed) is working on this.

I'm just looking to get timestamps in the real time task.  At least in
my case being able to call gettimeofday from the real time thread would
be exactly what I need.

By the way, calling gettimeofday currently within a real time thread
seems to occasionally freeze up my whole system.  I was going to make
another post for this after I got a chance to verify some details.  Has
anyone noticed anything similar to this?


