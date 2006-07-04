Message-ID: <44AA7134.6080905@domain.hid>
Date: Tue, 04 Jul 2006 15:46:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re:  [Xenomai-help] Modification of the PSOS skin.
References: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14C@kheops.clb.tcfr.thales>
In-Reply-To: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14C@kheops.clb.tcfr.thales>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6715F979A29B07AF21FD8683"
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
--------------enig6715F979A29B07AF21FD8683
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Antoine.BRUGEAS@fr.thalesgroup.com wrote:
> hello,
>=20
> Xenomai is under the GPL license, and I think that I have to
> redistribute the source code when I modify or add something on it.
> But, I don't know how to process to distribute the source code. Then,
> I give you modifications in this mailing list.
>=20

In general, publication of your patches is required when you give
binaries to some third party. In-house use doesn't require this by law.
Nevertheless, we can only encourage anyone to follow your good example
and send us improvements! You will gain feedback and make sure that
future versions will already contain your patches.

Just a hint on the preferred patch format: either generate a diff of
individual modified files by invoking "diff -up file file.orig >>
my.patch" or - even easier - check out the subversion repository (see
https://gna.org/svn/?group=3Dxenomai for details), change your files and
run "svn diff > my.patch". This makes it easier to review the
differences and integrate them in the tree.

Sorry, I cannot comment on code details, but I'm sure others will.

Thanks,
Jan


--------------enig6715F979A29B07AF21FD8683
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqnE0niDOoMHTA+kRAjqyAJ92uoYp0KsAli074jRFOaRNYU4u6gCfT/zk
oJOuEzkWibd8XUVqKiyTje8=
=ZDvY
-----END PGP SIGNATURE-----

--------------enig6715F979A29B07AF21FD8683--

