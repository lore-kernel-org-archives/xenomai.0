Message-ID: <4E0ACEF7.9080902@domain.hid>
Date: Wed, 29 Jun 2011 09:06:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QbfP2-0008Go-2L@xenomai.org> <4E0A47B6.2000008@domain.hid>
In-Reply-To: <4E0A47B6.2000008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig691B52DEC14F2E0718904360"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Allow
 drop_u_mode syscall from any context
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig691B52DEC14F2E0718904360
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-28 23:29, Gilles Chanteperdrix wrote:
> On 06/28/2011 11:01 PM, GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: 5597470d84584846875e8a35309e6302c768addf
>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D559=
7470d84584846875e8a35309e6302c768addf
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Tue Jun 28 22:10:07 2011 +0200
>>
>> nucleus: Allow drop_u_mode syscall from any context
>>
>> xnshadow_sys_drop_u_mode already checks if the caller is a shadow. It
>> does that without issuing a warning message if the check fails - in
>> contrast to do_hisyscall_event. As user space may call this cleanup
>> service even for non-shadow threads (e.g. after shadow creation failed=
),
>> we better silence this warning.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>=20
> Jan,
>=20
> I have a branch here, which allocates u_mode in the shared heap, so,
> this syscall is about to become unnecessary.
>=20
> See:
> http://git.xenomai.org/?p=3Dxenomai-gch.git;a=3Dshortlog;h=3Drefs/heads=
/u_mode

Even better. When do you plan to merge all this? I'd like to finally fix
the various MPS fastlock breakages, specifically as they overlap with
other issues there.

Jan


--------------enig691B52DEC14F2E0718904360
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4KzvkACgkQitSsb3rl5xTCNgCgjEW5O4cU/K5ylaZrDlAG7Rho
Eg0Ani60VIenNmgtqWnUGJuMABKA2blI
=ofTW
-----END PGP SIGNATURE-----

--------------enig691B52DEC14F2E0718904360--

