Message-ID: <4C337FE2.7020906@domain.hid>
Date: Tue, 06 Jul 2010 21:11:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTikaVz0DcwnQHbAkRf5LzrBy3zXxHhhJzYEAIgYD@mail.gmail.com>
In-Reply-To: <AANLkTikaVz0DcwnQHbAkRf5LzrBy3zXxHhhJzYEAIgYD@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA30EDB7C583F744C74860FA2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] 2.5.2 + 2.6.32 patched kernel causes system reset
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA30EDB7C583F744C74860FA2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Peter Soetens wrote:
> Hi,
>=20
> We have a single-core Pentium M industrial PC equiped with Xenomai
> 2.5.2 patched vanilla Linux 2.6.32.7.
> We have two builds of the kernel: one that causes a reliable system
> reset when starting a 'heavy' Orocos application (lot of thread
> creation/deletions), the other is rock solid. We think it is related
> to thread creation in the native skin, since we could at least twice
> cause the reset by just creating a native thread (that was meant to
> block on a semaphore) but this was hard to reproduce. Stack size was
> set to 128k, but only trivial code was executed.We had the impression
> that enlarging the stack size to 256k caused less resets, but it was
> still very frequent. Setting the stack size too low caused segfaults
> in the app, not a kernel crash.
>=20
> The stable config and the diffs between both configs are in
> attachment. Read it as: apply this patch to make it unstable. Any
> clues what is the most likely suspect ? Could the xenomai watchdog
> cause the reset ?
>=20
> Thanks for any pointers, we're prepared to bisect this, if any one
> knows a tool to do a bisect on a set of config options, we'll be glad
> to use it.

You could first of all try to enable CONFIG_X86_UP_APIC. Recommended for
performance reasons anyway.

Then try to disable debugging features that were enabled between the two
versions.

Jan


--------------enigA30EDB7C583F744C74860FA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwzf+YACgkQitSsb3rl5xRVHQCgpTcgdJJKdjlc0gz29Qvs163g
gbsAoMz4zqYYJZgt9NEGcW7UhCae6u+3
=31fH
-----END PGP SIGNATURE-----

--------------enigA30EDB7C583F744C74860FA2--

