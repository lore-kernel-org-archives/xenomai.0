Message-ID: <4E0A3E1C.70509@domain.hid>
Date: Tue, 28 Jun 2011 22:48:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE53E8193620416C6BAD0E3A0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] posix: only use rt_printf when in primary mode
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE53E8193620416C6BAD0E3A0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

dynamic printf backend selection is a suboptimal idea when you want
chronological output (not that uncommon during debugging). The native
printf may actually hit the screen (or the log file) before some earlier
queued rt_printf message because the dump thread is busy or has a lower
priority.

It's ok to do native printf for non-shadows. But once a thread was
mapped, printf needs to go through the rt queue, even in secondary mode.

Jan


--------------enigE53E8193620416C6BAD0E3A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4KPh8ACgkQitSsb3rl5xSAaACcDWtHtcT9rba3tYIcJPeK71tE
8eUAoIOwYOcTqPJ9iUc6RknuAE1MHPiX
=rz73
-----END PGP SIGNATURE-----

--------------enigE53E8193620416C6BAD0E3A0--

