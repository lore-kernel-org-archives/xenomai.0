Message-ID: <44ABABE3.6070600@domain.hid>
Date: Wed, 05 Jul 2006 14:09:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Modification of the PSOS skin. [update]
References: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14D@kheops.clb.tcfr.thales>
In-Reply-To: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14D@kheops.clb.tcfr.thales>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig650DA1AED75EF32A564B2EAF"
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
To: Antoine.BRUGEAS@fr.thalesgroup.com
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig650DA1AED75EF32A564B2EAF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Antoine.BRUGEAS@fr.thalesgroup.com wrote:
> Result of the diff command :

[skipping and acknowledging what Romain already remarked]

Your patch is small, so manual fixing during merge is no big issue here.
But for larger patches a cleanup would be good, i.e. removing of dead
code etc.

And for crediting your work you may provide a patch for ChangeLog
(instead of the adding this as comment to the code). If not we would add
it on commit.

Jan


--------------enig650DA1AED75EF32A564B2EAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEq6vnniDOoMHTA+kRAlaKAJ4l53G4dQszn4ejyl5zkX5TMQ7ncACfZvP2
WMP0vkIHr/e3Ax/qRSZVTYI=
=FCUk
-----END PGP SIGNATURE-----

--------------enig650DA1AED75EF32A564B2EAF--

