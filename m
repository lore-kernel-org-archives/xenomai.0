Message-ID: <44646CB9.9070906@domain.hid>
Date: Fri, 12 May 2006 13:08:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [BUG] kernel oops on registry duplicate names
References: <44646131.9090600@domain.hid> <44646BEB.5030708@domain.hid>
In-Reply-To: <44646BEB.5030708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig66D8978CC5BD1C9FE6904286"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66D8978CC5BD1C9FE6904286
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Ignacio Garc=EDa P=E9rez wrote:
>> The subject pretty much explains it all.
>>
>> Just try to create a task named "foo" and a queue also named "foo".
>>
>> Tested in 2.1.1 and svn HEAD.
>>
>=20
> Ok, that's the other way around, you first create the queue, then the
> task, and the error path of the task creation routine seems to go wild
> afterwards when it detects the registry error.
>=20

That's obviously the same issue I reported a few days ago about creating
two tasks with identical names.

Jan


--------------enig66D8978CC5BD1C9FE6904286
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEZGy5niDOoMHTA+kRAtGBAJ49Lp7+1RUw7tu6C85UUPYpXktt4wCfYTRv
XI4CMw0lxBjj2+YNOXJ0bpo=
=bbSd
-----END PGP SIGNATURE-----

--------------enig66D8978CC5BD1C9FE6904286--

