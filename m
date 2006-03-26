Message-ID: <442666D5.4080700@domain.hid>
Date: Sun, 26 Mar 2006 12:03:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Hard real-time and C++
References: <20060322203422.2866.qmail@domain.hid>
In-Reply-To: <20060322203422.2866.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5BC836BDE3B137C7E29DF34F"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5BC836BDE3B137C7E29DF34F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi,
>=20
> I'm willing to develop a framework for helping people to program mobile=
 robots for doing hard
> real-time tasks. Assuming most of them will have a limitated knowledge =
both to RTOS and
> programming, I would like to keep it simple to use.

Note that this is what our RACK (Robotic Application Construction Kit)
aims for. It comes with a simple modular concept for input, output, and
processing components, is written in C++ over Xenomai, contains a lot of
abstractions for typical component classes in mobile service robotics,
and supports both RT (=3D>RTnet) and non-RT (=3D>TCP/IP) distribution.

As my colleagues are currently porting a lot of old components from the
previous framework to RACK, there has been no time to finalise the
release of the core as open source. Well, we have no fixed schedule for
this release unfortunately, only schedules for two upcoming robotic
challenges within the next two months...

If you are interested in a sneak-preview, I could try to arrange
something next week.

Jan


--------------enig5BC836BDE3B137C7E29DF34F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJmbVniDOoMHTA+kRAtYDAJ0Q1jexkfLjIpXTLFxOuy9Hamz41ACbBwVE
GnCA8OijwBumM7wbqrACZnU=
=eWsa
-----END PGP SIGNATURE-----

--------------enig5BC836BDE3B137C7E29DF34F--

