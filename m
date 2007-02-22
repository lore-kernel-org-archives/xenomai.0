Message-ID: <45DD7E00.8020505@domain.hid>
Date: Thu, 22 Feb 2007 12:26:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] hello xenomai world?
References: <bc4264770702220311m604b0dcdh2543e40405451147@domain.hid>
In-Reply-To: <bc4264770702220311m604b0dcdh2543e40405451147@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2AB619CC49827D8D868B5D37"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AB619CC49827D8D868B5D37
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> I must be making a big mistake. I am browsing through latency in
> testsuit trying to learn how to set up some tasks that will execute at
> regular intervals. I kind of had RTAI examples in mind which seemed
> rather simple to me. Looking at the code in latency is a horrible
> shock.
>=20
> Is it at all possible to explain in a couple of lines how a periodic
> task can be run, lets say a hello world example that puts out the line
> "hello xenomai world" exactly every 1ms?

See examples/native/trivial-periodic.c

Also read the comments. :)

To overcome the latency issue of printf, there is some patch in sight:

https://mail.gna.org/public/xenomai-core/2007-02/msg00087.html

specifically

https://mail.gna.org/public/xenomai-core/2007-02/msg00089.html

Jan


--------------enig2AB619CC49827D8D868B5D37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3X4AniDOoMHTA+kRAp3BAJ9OjDw9a3ObnGyq+GuRZ451uF/jogCeKX/O
57EixWltcORHpv+z2HB9U08=
=1LXE
-----END PGP SIGNATURE-----

--------------enig2AB619CC49827D8D868B5D37--

