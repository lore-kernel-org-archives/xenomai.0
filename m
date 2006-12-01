Message-ID: <457002EB.8080106@domain.hid>
Date: Fri, 01 Dec 2006 11:24:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DD7EB9A7BFC3CA4A1FB2B4E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [ANNOUNCE] Xenomai Example Repository
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DD7EB9A7BFC3CA4A1FB2B4E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

the new Xenomai example repository has been created. I don't want to
repeat here what is explained already on the related wiki page, please
have a look at

	http://www.xenomai.org/index.php/Examples

Instead, let me sketch what could be done next:

 o Port existing examples, snippets, demos from ksrc/skins/* over, make
   them compilable and runnable if required.

 o Identify what kind of examples are lacking. You, the user, is needed
   here. What do *you* think is missing, what would be helpful to show?

 o Check what is needed to compile kernel-based examples over PPC 2.4.
   Philippe indicated that some switches are likely missing (x86 is fine
   already, other archs are 2.6-only).

 o Regarding RTDM: driver patterns would be nice. Someone (who I don't
   recall ATM, sorry) once posted a template for a PCI driver. Feel
   invited to repost an updated version. Any further suggestion or ready
   code is welcome as well.

Jan


--------------enig5DD7EB9A7BFC3CA4A1FB2B4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFcALrniDOoMHTA+kRAoqlAJ0Q6NU4ugvXcT3Cc57nEvU5/Q66BwCeJJWr
s8lphWVm8OYINmXBY0NBDk8=
=bnm3
-----END PGP SIGNATURE-----

--------------enig5DD7EB9A7BFC3CA4A1FB2B4E--

