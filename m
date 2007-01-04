Message-ID: <459D14C4.40300@domain.hid>
Date: Thu, 04 Jan 2007 15:52:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig25C649FBE12D7F5428A66FB6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] timerbench tests don't work with SVN
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25C649FBE12D7F5428A66FB6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

likely a regression of latest timer base patches: with periodic support
enabled (haven't tested the off case yet), latency -t1/2 no longer work.
I have no time to look at this, so I just dump my report here. :)

Jan


PS: Is there an official nucleus API to convert dates between timebases?
I'm asking because of the open question how to share RTDM drivers
between skins on different timer bases. Right now it looks to me like
RTDM is locked to one base (configured at compile or module load time)
and cannot be shared.


--------------enig25C649FBE12D7F5428A66FB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFnRTEniDOoMHTA+kRAgYLAJ0TTIrawNcOpQ6JDwUQakDusXjOyACfUq+a
hDEf4l5OD6+H8QKj1mPnGC4=
=KkxF
-----END PGP SIGNATURE-----

--------------enig25C649FBE12D7F5428A66FB6--

