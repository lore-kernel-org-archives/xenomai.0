Message-ID: <43E0AAE1.6070600@domain.hid>
Date: Wed, 01 Feb 2006 13:34:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	
	<fd6a47a90601220819n3f4cd382t@domain.hid>	
	<E1F16LA-0001ku-C4@domain.hid> <43D52BA3.6020005@domain.hid>	
	<43DE27E5.3010206@domain.hid> <43DE3243.8080603@domain.hid>	
	<fd6a47a90601311309i18d2ab31i@domain.hid>	
	<43DFDA6E.5000700@domain.hid>	
	<fd6a47a90602010157w57051089p@domain.hid>
	<43E08762.90306@domain.hid>
	<fd6a47a90602010423k707ac91bm@domain.hid>
In-Reply-To: <fd6a47a90602010423k707ac91bm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F10AB7578B8D0F27D72817A"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F10AB7578B8D0F27D72817A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
>> Revision 466 contains the mutex-info fix, but that is post -rc2. Why n=
ot
>> switching to SVN head?
>=20
>=20
> Philippe asked to apply the patch against Xenomai 2.1-rc2. Can I safely=

> patch it against the SVN tree ? After that, what will 'svn up' do to th=
e
> patched tree ?

The CONFIG_PREEMPT fix is already contained in the latest SVN revision,
no need to patch anymore.

When unsure if a patch will cleanly apply, try "patch --dry-run" first.
(Virtually) rejected hunks can then be used to asses if the patch fits -
without messing up the code base immediately.

>=20
> Remember I'm quite new to Linux. Actually, I spent half an hour finding=
 out
> how that patch stuff (especially the -p option) works.
>=20

:) (it's no problem to ask even these kind of "stupid" questions to the
list or us directly - no one will bite you!)

Jan


--------------enig8F10AB7578B8D0F27D72817A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4KrhniDOoMHTA+kRAlFKAJ9k4ys2JsP3KKDUiEmwbOszMmm6rACdEZEs
tiis/VE4D5UjREis7Jcay7k=
=yGHT
-----END PGP SIGNATURE-----

--------------enig8F10AB7578B8D0F27D72817A--

