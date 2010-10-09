Message-ID: <4CB04CBA.1010308@domain.hid>
Date: Sat, 09 Oct 2010 13:06:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CB04954.7010109@domain.hid> <4CB04ACE.6050408@domain.hid>
In-Reply-To: <4CB04ACE.6050408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7BE2185AB84C28C3DBC17B4C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [git pull] cleanups and LTTng fix for head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7BE2185AB84C28C3DBC17B4C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 09.10.2010 12:58, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> The following changes since commit 36a0e05a86d0cd19311cd33ae9da8618cc4=
d0c55:
>>
>>   posix: fix regression in clock_gettime (HOST_RT introduction) (2010-=
10-08 17:41:03 +0200)
>>
>> are available in the git repository at:
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>
>> Jan Kiszka (3):
>>       Re-enable marker support for latest LTTng
>>       posix: Cleanup CLOCK_HOST_REALTIME
>=20
> Well, why not having CLOCK_HOST_REALTIME for machines without a tsc
> accessible in user-space ?!
>=20

They fall back to a syscall just like before. Philippe reordered the
code to fix a compiler warning, I just removed dead code.

Jan


--------------enig7BE2185AB84C28C3DBC17B4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkywTLoACgkQitSsb3rl5xSHvgCglOqytvRFcljbI3XyclYeoefT
NMQAoIWF0r2tVBgC1HuDscUP9iQOjnJV
=AbUE
-----END PGP SIGNATURE-----

--------------enig7BE2185AB84C28C3DBC17B4C--

