Message-ID: <4DBBE8C5.9080508@domain.hid>
Date: Sat, 30 Apr 2011 12:47:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QFme6-0000lI-Pf@domain.hid> <4DBB05A6.10704@domain.hid>
In-Reply-To: <4DBB05A6.10704@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0908276FA8ED8BB8277A51FD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : x86: Fix return type
 of DO_SYSCALL_INNER macro
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0908276FA8ED8BB8277A51FD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-04-29 20:38, Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: 852c130d16410a597536c39d06b6abd1c9c6c822
>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D852=
c130d16410a597536c39d06b6abd1c9c6c822
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Fri Apr 29 14:12:13 2011 +0200
>>
>> x86: Fix return type of DO_SYSCALL_INNER macro
>>
>> gcc will complain about 'conversion to =E2=80=98int=E2=80=99 from =E2=80=
=98long int=E2=80=99 may alter
>> its value' with -Wconversion as DO_SYSCALL treats the return value of
>> DO_SYSCALL_INNER as int. Align DO_SYSCALL_INNER to its user.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>=20
> Should not it be aligned the other way around? Using longs everywhere?
> In case a syscall returns a pointer?

Maybe. But let's do this when we have a use case. Lots of arch macros,
inline functions, and core code would have to be touched.

Jan


--------------enig0908276FA8ED8BB8277A51FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk276MgACgkQitSsb3rl5xTGxgCgsA3bETZi5+/5/D977AdYooHE
xaEAoO8SrRnw+LePb6mpp/vJu55HJ6oE
=zf6w
-----END PGP SIGNATURE-----

--------------enig0908276FA8ED8BB8277A51FD--

