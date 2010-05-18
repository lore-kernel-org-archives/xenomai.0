Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 May 2010 19:23:24 -0500
Message-ID: <181804936ABC2349BE503168465576460EBD6788@domain.hid>
In-Reply-To: <4BF1D6F0.2030305@domain.hid>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF1794A.6050207@domain.hid>
	<181804936ABC2349BE503168465576460EBD6778@domain.hid>
	<4BF1D6F0.2030305@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai@xenomai.org

> The set of services which you can call from a real-time=20
> thread without loosing determinism are those found in the=20
> Xenomai posix skin documentation:
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/grou
> p__posix.html
>=20
> Other than that, any service emitting a syscall causes a=20
> switch to secondary mode. What remains are services not=20
> emitting syscalls, and for these ones, all bets are off.
>=20
> --=20
> 					    Gilles.
>=20

I guess that is my point though.  Not being all too familiar with the
inner workings of Linux or glibc, how am I supposed to know which
services are not emitting a syscall?  I accept that I will lose
determinism in calling these services, but I find it odd that it may
allow the system to deadlock.

If nothing else the syscall-less services should be listed and noted as
unsafe.  I am new to most of this, but I have went through most of the
documentation and, unless I have overlooked it, found nothing mentioning
this.

