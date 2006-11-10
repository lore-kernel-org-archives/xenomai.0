Message-ID: <45547532.4030306@domain.hid>
Date: Fri, 10 Nov 2006 13:48:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with RTDM
References: <BAY101-F279509E7C5F4B57FC5232CE2F70@domain.hid>
In-Reply-To: <BAY101-F279509E7C5F4B57FC5232CE2F70@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3D6EE06B5951D00C61BA567C"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marco Rossi <cicciobombo123@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D6EE06B5951D00C61BA567C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Argh, please *reply-to-all* so that everyone learns what was the reason.

Marco Rossi wrote:
> I found the problem; in the same PC there is an installation of rtai an=
d
> to avoid problem with dynamic library I modified the file /etc/profile
> adding the line "export LD_LIBRARY_PATH=3D/usr/realtime-rtai/lib"
> Deleting this line all work ok. Thank you for support
>=20

Ok. Take care to not mix up even more with RTAI, specifically kernel
patches...

Jan


--------------enig3D6EE06B5951D00C61BA567C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVHUzniDOoMHTA+kRAkMgAJ9Y1gUGY+x0V4gGBfhTTDWeqy1ryACfWm2I
AiN+cMmeUDIpirHR2iq/Xoo=
=QDZk
-----END PGP SIGNATURE-----

--------------enig3D6EE06B5951D00C61BA567C--

