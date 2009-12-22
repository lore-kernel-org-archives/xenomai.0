Message-ID: <4B30AF29.4050303@domain.hid>
Date: Tue, 22 Dec 2009 12:36:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B309A29.6030405@domain.hid>
In-Reply-To: <4B309A29.6030405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig554215293FC1D99A69D4CA3D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig554215293FC1D99A69D4CA3D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> * rtcan: on blackfin we seem to have a conflict with rtcan.
> The warning is about CAN_ERR_MASK, sure blackfin is a bit strange to
> define this in core headers which are included everywhere. This said,
> not prefixing a Xenomai symbol with something like XN seems to be askin=
g
> for trouble. Wolfgang, do you think it would be possible to rename the
> symbols with such prefix? Or do you share some code with socket-can tha=
t
> you do not want to touch?

CAN_ERR_MASK is part of the Socket-CAN interface (include/linux/can.h),
it must not be called differently. Blackfin is obviously doing namespace
pollution which should be fixed upstream and meanwhile worked around in
Xenomai (e.g. via #undef CAN_ERR_MASK).

Jan


--------------enig554215293FC1D99A69D4CA3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkswrykACgkQitSsb3rl5xQ1twCdFiIx380NuBYOMQuOTS9W3M4P
D7sAoNqz6E236VB3e7ObYKL94/g9cjI3
=pZs1
-----END PGP SIGNATURE-----

--------------enig554215293FC1D99A69D4CA3D--

