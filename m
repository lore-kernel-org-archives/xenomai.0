Message-ID: <4B8E24B4.9000806@domain.hid>
Date: Wed, 03 Mar 2010 09:58:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig06E4259D8E56E4F7F76DFE1B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Potential heap corruption on thread cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>, Gernot Hillier <gernot.hillier@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig06E4259D8E56E4F7F76DFE1B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

I'm pushing your findings to the list, also as my colleagues showed
strong interest - this thing may explain rare corruptions for us as well.=


I thought a bit about that likely u_mode-related crash in your test case
and have the following theory so far: If the xeno_current_mode storage
is allocated on the application heap (!HAVE_THREAD, that's also what we
are forced to use), it is automatically freed on thread termination in
the context of the dying thread. If the thread is already migrated to
secondary or if that happens while it is cleaned up (i.e. before calling
for exit into the kernel), there is no problem, Xenomai will not touch
the mode storage anymore. But if the thread happens to delete the
storage "silently", without any migration, the final exit will trigger
one further access. And that takes place against an invalid head area at
this point.

Does this make sense?

If that is true, all we need to do is to force a migration before
releasing the mode storage. Could you check this?

Jan


--------------enig06E4259D8E56E4F7F76DFE1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuOJLgACgkQitSsb3rl5xRYQQCfVwIN2ttHEiaESEbEmVndoyNQ
2/8An0yDgcFI5v3pOop3P4PkfAwkBgtY
=3On7
-----END PGP SIGNATURE-----

--------------enig06E4259D8E56E4F7F76DFE1B--

