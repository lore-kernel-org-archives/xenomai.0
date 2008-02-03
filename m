Message-ID: <47A63DA8.4020609@domain.hid>
Date: Sun, 03 Feb 2008 23:18:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18340.31233.591834.293535@domain.hid>	<18340.31323.677695.655702@domain.hid>
	<18340.31655.777349.789045@domain.hid>
In-Reply-To: <18340.31655.777349.789045@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig762DB7B40A0C8DC66249E6AE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 5/5] RTDM: check file descriptor owner.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig762DB7B40A0C8DC66249E6AE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> This patch makes RTDM service rtdm_context_get check the owner of a fil=
e
> descriptor. This will prevent a process to close an RTDM file descripto=
r
> belonging to another process.

I assume this is a safety belt against crazy applications, right? Hope
one day we can solve this via process-local FD name spaces.

I'm OK with this if you keep the API of rtdm_context_get as is and add
an internal checked service __rtdm_context_get(user_info, fd) instead.
rtdm_context_get would then call __rtdm_context_get(NULL, fd) because it
is supposed to operate on kernel file descriptors only.

Jan


--------------enig762DB7B40A0C8DC66249E6AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHpj2pniDOoMHTA+kRAlctAJ0SMhvR0oWefM2VE/aep0LthIjzhQCffErJ
aybU6Ozt29TP5hDnHBIAv48=
=TZf4
-----END PGP SIGNATURE-----

--------------enig762DB7B40A0C8DC66249E6AE--

