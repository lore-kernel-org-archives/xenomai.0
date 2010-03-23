Message-ID: <4BA8752E.8090407@domain.hid>
Date: Tue, 23 Mar 2010 09:00:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BA39C3D.1040802@domain.hid> <4BA4EF75.7010202@domain.hid>
	<4BA74820.2090401@domain.hid>
In-Reply-To: <4BA74820.2090401@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E118EADF4D2CC5B706D0E00"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] crash after termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E118EADF4D2CC5B706D0E00
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stefan Kisdaroczi wrote:
> Am 20.03.2010 16:53, schrieb Jan Kiszka:
>> Stefan Kisdaroczi wrote:
>>> hi all,
>>>
>>> after termination of my xenomai applications, my box crashed often (3=
 of 4 times) with xenomai 2.5.1.
>>> Today I updated to current git-2.5, rebuilt xenomai and the kernel. S=
till crashes.
>>> I have captured two traces over a serial connection. I have attached =
the kernel config, the two
>>> traces and the cpuinfo (UP x86 Pentium III). Help is welcome. Thank y=
ou.
>> Both crashes seem to be caused by corrupted skbs. There are (at least)=

>> two uncommon network component in your kernel: ARCNET and ISDN. Do you=

>> make use of them or are they just passively loaded? If the former: Can=

>=20
> Just passively loaded.
>=20
>> you retry without them? >(The Kernel's ISDN stuff is of, well, mixed
>> quality, and ARCNET is so old and uncommon that the code /may/ have
>> bit-rotted -
>=20
> I disable them.
>=20
>> just an attempt to detract the attention from Xenomai. :) )
>=20
> I think the problem is in my apps, but I had some hope that
> some changes for 2.5.2 (about thread cleanup,fork) would help.

Is your application partially or fully kernel homed? Because no user
space application is allowed to crash your host, anything else is a bug
in the kernel as well.

>=20
>> What other network components are actively involved in your scenario?
>=20
> Only TCP/IP (non-realtime). Currently a dozen xenomai native tasks are
> doing standard socket calls. If everything works, there will be about
> 60 tasks using socket calls, but its still a long way.
>=20
> I focus now first on another problem I have in my apps with a shared he=
ap,
> so one question about that: There was no H_NONCACHED flag at the time I=

> did write some library code. I use a rt_heap as shared memory between 8=

> processes on x86. According to the documentation H_NONCACHED is only
> relevant for ARM, is that true?

AFAIK, yes.

Jan


--------------enig6E118EADF4D2CC5B706D0E00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEUEARECAAYFAkuodTIACgkQitSsb3rl5xRybgCWKezDFDDxbPNLyJI86AyKL6cx
SACfRqAELy1N+W+5AhrYxu0UqUJQmGk=
=VxJO
-----END PGP SIGNATURE-----

--------------enig6E118EADF4D2CC5B706D0E00--

