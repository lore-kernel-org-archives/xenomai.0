Message-ID: <46040E1D.50709@domain.hid>
Date: Fri, 23 Mar 2007 18:27:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
References: <032320071721.22696.46040CB10009C87B000058A82216557996070E0301020A98@domain.hid>
In-Reply-To: <032320071721.22696.46040CB10009C87B000058A82216557996070E0301020A98@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCC9CF0D9E22A1A24EC9198CC"
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
To: xenomai@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC9CF0D9E22A1A24EC9198CC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

xenomai@domain.hid wrote:
> RE Previous message : hanging daemons
>=20
>=20
> I just started removing modules.  First timerbench, then native, then r=
tdm.... That did it.  When I remove rtdm the daemon drops to normal cpu u=
sage.

That sounds a bit like we have some issue with the host timer of Linux
once Xenomai takes over.

A lot changed during your last tests. To make sure we are discussing the
same setup, could you re-post your current .config and the used versions
of Xenomai, kernel, and ipipe patch to the list?

TiA,
Jan


--------------enigCC9CF0D9E22A1A24EC9198CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGBA4dniDOoMHTA+kRAjQpAJ9wN+G5g9lalhltx9ytZTaaVYx+WQCfbM/O
uZjn49X0uFqhZqWamSt1lYk=
=VNBX
-----END PGP SIGNATURE-----

--------------enigCC9CF0D9E22A1A24EC9198CC--

