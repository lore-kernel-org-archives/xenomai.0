Message-ID: <4BD54515.9010101@domain.hid>
Date: Mon, 26 Apr 2010 09:47:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62B72F21E7560FF1CAA1147F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 00/23] [git pull] procfs overflow fixes
	and seq_file conversions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62B72F21E7560FF1CAA1147F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a5=
987d:
>   Gilles Chanteperdrix (1):
>         switchtest: increase stack sizes
>=20
> are available in the git repository at:
>=20
>   git://git.xenomai.org/xenomai-jki.git queues/proc
>=20
> This series fixes some of the potential (but when they happen fatal)
> overflows in our procfs outputs. Specifically, it fixes all issues in
> RTDM (one of them hit us in the field) and the recently reported
> overflow in /proc/xenomai/heap. Moreover, Wolfgang started the lengthy
> conversion of the registry by introducing a new seq_file-based interfac=
e
> and already moving the native skin over.
>=20
> The future belongs to seq_file, so some of the patches are strictly
> spoken not yet required. But we better start this effort before the las=
t
> legacy interface user was converted and the old interface is suddenly
> dropped from the kernel. This may not be that far away. A patch of mine=

> to improve error reporting of the old interface was rejected with
> "->read_proc is going to be removed, so there is no point."

Did you already have a chance to look into this series?

Jan


--------------enig62B72F21E7560FF1CAA1147F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvVRRkACgkQitSsb3rl5xTIPwCfaE9atVND5Te2R6+QBWvMGyjY
h1cAn2ulg3gUwOJR0zjg128JPQNti1Tg
=jIDX
-----END PGP SIGNATURE-----

--------------enig62B72F21E7560FF1CAA1147F--

