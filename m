Message-ID: <4BF23BF7.2010206@domain.hid>
Date: Tue, 18 May 2010 09:04:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>	<4BF1794A.6050207@domain.hid>	<181804936ABC2349BE503168465576460EBD6778@domain.hid>	<4BF1D6F0.2030305@domain.hid>
	<181804936ABC2349BE503168465576460EBD6788@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460EBD6788@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6FBFB7C37FD57FC89E57D5C2"
Sender: jan.kiszka@domain.hid
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
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org, "Mauerer, Wolfgang" <wolfgang.mauerer@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FBFB7C37FD57FC89E57D5C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steve Deiters wrote:
>> The set of services which you can call from a real-time=20
>> thread without loosing determinism are those found in the=20
>> Xenomai posix skin documentation:
>> http://www.xenomai.org/documentation/xenomai-2.5/html/api/grou
>> p__posix.html
>>
>> Other than that, any service emitting a syscall causes a=20
>> switch to secondary mode. What remains are services not=20
>> emitting syscalls, and for these ones, all bets are off.
>>
>> --=20
>> 					    Gilles.
>>
>=20
> I guess that is my point though.  Not being all too familiar with the
> inner workings of Linux or glibc, how am I supposed to know which
> services are not emitting a syscall?  I accept that I will lose
> determinism in calling these services, but I find it odd that it may
> allow the system to deadlock.
>=20
> If nothing else the syscall-less services should be listed and noted as=

> unsafe.  I am new to most of this, but I have went through most of the
> documentation and, unless I have overlooked it, found nothing mentionin=
g
> this.

Key services that do not reliably trigger syscalls:

 - gettimeofday
 - clock_gettime (unless the POSIX skin is in use)
 - malloc
 - free

There are no guarantees either, but this list turned out to be fairly
complete while porting a large (x86) application from plain Linux to
Xenomai. Only gettimeofday (and, conditionally, clock_gettime) suffer
from the live-lock problem.

For runtime checks, enable T_WARNSW / PTHREAD_WARNSW for your RT
threads, additionally link against librtdk, --wrap the above services,
and assert_nrt() will trigger a SIGDEBUG when they are used from a RT
thread (just like normal syscalls will do).

There should be a few more services in the glibc that trigger malloc
internally without issuing a syscall. When you come across one (check
the man pages), additions to xenomai/src/rtdk/assert_context.c are welcom=
e.

Jan


--------------enig6FBFB7C37FD57FC89E57D5C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvyO/oACgkQitSsb3rl5xRSigCgtwkCqC7A31X7V9mMfwWsjqYt
FXcAoNsTAaeWjW4dUyyZTPZUKwK8jgjg
=gZ8V
-----END PGP SIGNATURE-----

--------------enig6FBFB7C37FD57FC89E57D5C2--

