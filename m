Message-ID: <45DEFD29.2030301@domain.hid>
Date: Fri, 23 Feb 2007 15:41:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
	<45DEE913.9080809@domain.hid>	<45DEF122.2060406@domain.hid>
	<45DEF605.2060402@domain.hid> <45DEF6AA.5030609@domain.hid>
	<45DEFBEA.7010407@domain.hid> <45DEFC86.8090809@domain.hid>
In-Reply-To: <45DEFC86.8090809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA291FC024FBD27BEA94AF14D"
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA291FC024FBD27BEA94AF14D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steven Scholz wrote:
> Jan,
>=20
>> BTW, do you have the nucleus option "disable priority coupling" set or=

>> not in your config (the latter is default, ie. it's on)? The other bug=

>> is triggered when prio coupling is on, and doesn't appear while it's
>> off. Just to collect more patterns...
>=20
> CONFIG_XENO_OPT_PRIOCPL=3Dy

[Ah, using trunk already]

Mind given a try what happens when it's off?

Jan


--------------enigA291FC024FBD27BEA94AF14D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3v0pniDOoMHTA+kRAsWQAJ9zdC6svW3whtoc7hOzNn6sqPyF5gCaA33C
CFfGoH1cm30f4j4dmISCivU=
=VriJ
-----END PGP SIGNATURE-----

--------------enigA291FC024FBD27BEA94AF14D--

