Message-ID: <43D7DB08.5050209@domain.hid>
Date: Wed, 25 Jan 2006 21:09:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] About scheduling routine and xnpod_announce_tick
References: <55227.213.103.216.34.1138138522.squirrel@domain.hid>
In-Reply-To: <55227.213.103.216.34.1138138522.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig09FF8A57EEA4EC6DFB115458"
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
To: Germain Olivier <germain.olivier@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09FF8A57EEA4EC6DFB115458
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Germain Olivier wrote:
> Hello
>=20
> My question is about the scheduling routine:
> I want to know if the function xnpod_announce_tick is called at every t=
ick
> of the timer (such I suppose because it is linked with the timer), so i=
t
> will be a good place to do some EDF scheduling stuff.

Yes, xnpod_announce_tick() is the default handler for the real-time
timer interrupt, thus gets called on every timer event. Round-robin is
already handled inside this function.

Maybe following the cross-reference might help you finding further
information:

http://www.rts.uni-hannover.de/xenomai/lxr/ident?v=3DSVN-trunk;i=3Dxnpod_=
announce_tick

Jan



--------------enig09FF8A57EEA4EC6DFB115458
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD19sIniDOoMHTA+kRAgcqAJ9CmFmG3TlbR+XewgnXfi4QaTxiJgCfT3Mh
zJcgtjKwnwZkWyq5+oVV36w=
=OIFT
-----END PGP SIGNATURE-----

--------------enig09FF8A57EEA4EC6DFB115458--

