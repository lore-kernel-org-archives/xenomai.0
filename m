Message-ID: <4E6C927F.3070901@domain.hid>
Date: Sun, 11 Sep 2011 12:50:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB6624B0A6D985550A462AB14"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Policy switching and XNOTHER maintenance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6624B0A6D985550A462AB14
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

just looked into the hrescnt issue again, specifically the corner case
of a shadow thread switching from real-time policy to SCHED_OTHER.

Looks like we don't support this at all ATM:

do_setsched_event ignores events that enabled SCHED_OTHER, and the
XNOTHER flag is only set on xnshadow_map, not updated anywhere else.
Fixing this is not straightforward as that flag resides in a state
variable that is owned by the thread (ie. updated non-atomically) while
do_setsched_event can also be called over different contexts.

Or am I missing something?

In the light of this, I would vote for reverting f9bfab3457 ("only
update rescnt for XNOTHER threads") as it only adds conditional branches
to the hot paths without solving the issue.

Jan


--------------enigB6624B0A6D985550A462AB14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5skoIACgkQitSsb3rl5xRxiQCgrLS+MMigcPqzi+shFTY5DZe7
lHMAoKuySIntVp+60JYcHraEPPYdI1uA
=hd6S
-----END PGP SIGNATURE-----

--------------enigB6624B0A6D985550A462AB14--

