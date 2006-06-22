Message-ID: <449A7602.1020004@domain.hid>
Date: Thu, 22 Jun 2006 12:50:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] oops on skincall without nucleus being loaded
References: <449A7261.7040503@domain.hid>
In-Reply-To: <449A7261.7040503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6A04846737EBF85E95D05CB6"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A04846737EBF85E95D05CB6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> wondering why suddenly things crash on invoking the latency test, I
> realised that I turned the nucleus into a module which was not yet
> loaded. Here is the oops in this case:

Correction: the nucleus was still compiled in, the native skin was missin=
g.

Jan


--------------enig6A04846737EBF85E95D05CB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEmnYCniDOoMHTA+kRAhQsAJ99KWAtqrCbwVJVrcQbWj6fjCRZ5QCfXUv5
WW2HXWvn/ngAS4wXXk764h4=
=hHIk
-----END PGP SIGNATURE-----

--------------enig6A04846737EBF85E95D05CB6--

