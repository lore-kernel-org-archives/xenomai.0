Message-ID: <48D620DB.2070101@domain.hid>
Date: Sun, 21 Sep 2008 12:24:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid>
In-Reply-To: <48CE7BD7.6060504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DE3237E1C92524F1F75779E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DE3237E1C92524F1F75779E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Slowly moving on toward generic fast mutex support for Xenomai, this
> patch is a proposal to address the increasing divergence of
> owner-tracking vs. owner-less xnsynch objects.
>=20
> The services dealing with the former will likely include a new, lockles=
s
> prologues for the mutex fastpath. At the the same time, this additional=

> code should not disturb too much in those cases where we do not track
> ownership (condition variables, events, semaphores etc.). Moreover, I
> noticed that some of the existing code assumes XNSYNCH_NOPIP means no
> ownership, which is surely not true. The already visible effect is that=

> lock stealing is needlessly restricted to XNSYNCH_PIP.
>=20
> Going through the API, I dug out three diverging services and replaced
> them with two new ones:
>=20
> Owner-less xnsynch objects:
> - xnsynch_sleep_on
> - xnsynch_wakeup_one_sleeper
> - xnsynch_wakeup_this_sleeper
>=20
> Owner-tracking xnsynch objects:
> - xnsynch_acquire
> - xnsynch_release
>=20
> The latter type of objects are marked with the new flag XNSYNCH_OWNER,
> used only for debugging and code documentation purposes in the current
> implementation.

Any comments on this? I plan to resume the work on fast xnsynch once
this building block is clarified (or replaced by an alternative).

Jan


--------------enig2DE3237E1C92524F1F75779E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjWIN8ACgkQniDOoMHTA+lqAgCbBrFKlQyc0ASLc6sA4fM8chBe
mGcAni1i1t87moriUFtmrIWT+RYILxei
=iaR9
-----END PGP SIGNATURE-----

--------------enig2DE3237E1C92524F1F75779E--

