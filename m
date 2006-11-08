Message-ID: <455233B6.5040200@domain.hid>
Date: Wed, 08 Nov 2006 20:44:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel 2.6.18
References: <1163013593.3701.36.camel@domain.hid>
In-Reply-To: <1163013593.3701.36.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0AB9EA8B39EE42E3595CD2DF"
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
To: jean-olivier.villemure@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AB9EA8B39EE42E3595CD2DF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jean-Olivier Villemure wrote:
> Hi,
>=20
> I'm looking for a patch for kernel 2.6.18 for the latest Xenomai 2.2.5
> version. On the i386 subdir the latest patch is for 2.6.17.
>=20
> Is there a way to get the patch for the 2.6.18 kernel?

We decided to skip 2.6.18 because a critical subsystem, the interrupt
management layer, is currently undergoing a huge restructuring. In
2.6.18 only half of this process is completed for i386, so it would have
been a wasted development to adopt to this intermediate step. Other
archs are widely unaffected so far - that's why we have PPC support for
2.6.18.

Instead, Philippe is working on i386-support for upcoming 2.6.19 now.
Stay tuned.

Jan


--------------enig0AB9EA8B39EE42E3595CD2DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUjO2niDOoMHTA+kRAlNGAJsGK/iD0Mf+hg04XT/R5woVK2D+yACfSJeY
vW+rAdZDgbV3ooZKtg9mqOw=
=RMq+
-----END PGP SIGNATURE-----

--------------enig0AB9EA8B39EE42E3595CD2DF--

