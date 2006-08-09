Message-ID: <44DA6568.6050300@domain.hid>
Date: Thu, 10 Aug 2006 00:44:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] SMI update
References: <200608091837.55424.schwab@domain.hid>
In-Reply-To: <200608091837.55424.schwab@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E9C36BBA52BBADC774FBFB6"
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
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E9C36BBA52BBADC774FBFB6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ulrich Schwab wrote:
> I saw some bad latency behaviour on a new system, it is a
> P4 with ICH7 chipset. It showed  more than 300 us max. latency without =
any=20
> load.
> This chipset was not detected as SMI generating and SMI disable was not=
 done.
>=20
> Finally I figured out where to add this DEVICE_ID
> to the SMI detection in smi.c
> It is done in the attached patch.
>=20
> Now, the max. latency values on this new system are below 10 us.
> Although, not tested very long.

=2E..and not under load. ;)

Thanks for the patch, we just need some additional define of
PCI_DEVICE_ID_INTEL_ICH7_0 for kernel 2.4 compatibility. And if you
additionally provide a ChangeLog fragment, your patch would be perfect!
(I tend to forget the last part often too... :) )

Jan


--------------enig7E9C36BBA52BBADC774FBFB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE2mVoniDOoMHTA+kRAqYMAJ44yg9GTPs+y1DSti+58t264/hRGwCffsM2
rO9SRMFbRwscLf56OOcDEkA=
=Yice
-----END PGP SIGNATURE-----

--------------enig7E9C36BBA52BBADC774FBFB6--

