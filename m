Message-ID: <43E08762.90306@domain.hid>
Date: Wed, 01 Feb 2006 11:03:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	
	<b647ffbd0601220010x3cc023an@domain.hid>	
	<fd6a47a90601220819n3f4cd382t@domain.hid>	
	<E1F16LA-0001ku-C4@domain.hid> <43D52BA3.6020005@domain.hid>	
	<43DE27E5.3010206@domain.hid> <43DE3243.8080603@domain.hid>	
	<fd6a47a90601311309i18d2ab31i@domain.hid>	
	<43DFDA6E.5000700@domain.hid>
	<fd6a47a90602010157w57051089p@domain.hid>
In-Reply-To: <fd6a47a90602010157w57051089p@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0424163FF99709C29E65B1D5"
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
--------------enig0424163FF99709C29E65B1D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
>>> I've installed both patches and the problem seems to have disappeared=
=2E
>>> I'll try it on another machine tomorrow, too. Meanwhile: thanks very
>>> much for the assistance !
>=20
>=20
> While testing more thoroughly, my triggers for zero mutex values after
> acquiring the lock are going off again. I was using the SVN xenomai
> development tree, but I've now switched to the (fixed) 2.1-rc2 in order=
 to
> apply the patches. Is Jan's bugfix included in that one ?

Revision 466 contains the mutex-info fix, but that is post -rc2. Why not
switching to SVN head?

Jan


--------------enig0424163FF99709C29E65B1D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4IdjniDOoMHTA+kRAkWcAJ9LfU+d8vGVf/imBSvAYMtEsG5lmwCZAeJp
0oIuaTbbvPJsWJedo/DVXzc=
=booy
-----END PGP SIGNATURE-----

--------------enig0424163FF99709C29E65B1D5--

