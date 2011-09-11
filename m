Message-ID: <4E6CA04C.7050503@domain.hid>
Date: Sun, 11 Sep 2011 13:49:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E6C927F.3070901@domain.hid>
In-Reply-To: <4E6C927F.3070901@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAA54B888FE200F701DA8B3D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Policy switching and XNOTHER maintenance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDAA54B888FE200F701DA8B3D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 2011-09-11 12:50, Jan Kiszka wrote:
> Hi all,
>=20
> just looked into the hrescnt issue again, specifically the corner case
> of a shadow thread switching from real-time policy to SCHED_OTHER.
>=20
> Looks like we don't support this at all ATM:
>=20
> do_setsched_event ignores events that enabled SCHED_OTHER, and the
> XNOTHER flag is only set on xnshadow_map, not updated anywhere else.
> Fixing this is not straightforward as that flag resides in a state
> variable that is owned by the thread (ie. updated non-atomically) while=

> do_setsched_event can also be called over different contexts.

OK, it just takes nklock to update the thread state.

>=20
> Or am I missing something?

=46rom __xnpod_set_thread_schedparam:

"A non-real-time shadow may upgrade to real-time FIFO
scheduling, but the latter may never downgrade to
SCHED_NORMAL Xenomai-wise. In the valid case, we clear
XNOTHER to reflect the change."

What prevents us from setting XNOTHER if the priority drops to 0, i.e.
the Linux task re-enters SCHED_NORMAL (while Xenomai will still schedule
it via its RT class of course)? We cannot deny such a transition on the
Linux side anyway, can we?

Jan



--------------enigDAA54B888FE200F701DA8B3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5soEwACgkQitSsb3rl5xTGfwCfcRynrSL5eTsTLoRg4pH9h2rY
7MMAmgOkV9HSJDFm2pBVucT+HZyskxuV
=aErv
-----END PGP SIGNATURE-----

--------------enigDAA54B888FE200F701DA8B3D--

