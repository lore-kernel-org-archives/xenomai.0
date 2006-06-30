Message-ID: <44A50553.9010200@domain.hid>
Date: Fri, 30 Jun 2006 13:04:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xeno task debigging
References: <44A519C4.3080900@domain.hid>
In-Reply-To: <44A519C4.3080900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig879B44F4100D1C9018046B41"
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
To: "s.a." <sancelot@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig879B44F4100D1C9018046B41
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

s.a. wrote:
> Hi,
> I have got the following kernel message in a process that crashes somet=
imes
> the action to obtain it is console switching with ctrl alt  Fx
> the two processes are xeno tasks
>=20
> any idea about the problem ?

Please tell us your Xenomai and I-ipipe patch version. Also your kernel
=2Econfig my be helpful. Do you use any "special" Linux drivers, e.g. som=
e
binary-only nvidia or ati stuff?

>=20
> how to debug this in xenomai ?
> is there a workaround ?

Can you derive a simple demo code from your application so that we can
give it a try as well? I have an emulator here (qemu) where I can easily
step into such issues (when they trigger on my box too...).

If you want to dig deeper on your own: there is a kgdb add-on patch
available for 2.6.16 (not 2.6.17 as falsely claimed by the readme) [1].

Jan


[1] http://download.gna.org/adeos/patches/v2.6/i386/kgdb/


--------------enig879B44F4100D1C9018046B41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEpQVTniDOoMHTA+kRAgZgAJ9v5MpbHdf/BQG7dZSBmMxXulGujwCdFPsn
vI0HG+PpZTvqc0Js+Su7jFw=
=WkB2
-----END PGP SIGNATURE-----

--------------enig879B44F4100D1C9018046B41--

