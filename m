Message-ID: <4C8BD72E.1010906@domain.hid>
Date: Sat, 11 Sep 2010 21:23:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1284153875.7864.4.camel@domain.hid>
In-Reply-To: <1284153875.7864.4.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7039D5DD6EE138339CD699F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Fwd: [Fwd: Re: Adding rtnet-0.9.12 to
	xenomai-2.5.4]]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Edward Hoffman <quantalgo@domain.hid>
Cc: rtnet-users <rtnet-users@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7039D5DD6EE138339CD699F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ed,

I think this was a misunderstanding: I meant that RTnet-related
questions should be handled on the rtnet-users list. So I'm only BCC'ing
xenomai-help now.

Am 10.09.2010 23:24, Edward Hoffman wrote:
> Jan,
>=20
> Sorry, I am a newbie.  Is using rtnet required or can the same UDP
> interface be done using RTDM sockets in xenomai?

No, the RTDM socket interface is a pure interconnection between the
application and the protocol driver. For UDP, RTnet is such a driver.

[...]
>=20
> I am trying to integrate rtnet-0.9.12 to xenomai-2.5.4 for the purposes=

> of building UDP into kernel mode. After hand configuring the config fil=
e
> with my drivers, etc.  (I read your previous posts), the config fails
> with:
>=20
> checking for Xenomai version... configure: error: *** Unsupported
> Xenomai version 2.5.4 in /usr/xenomai. It also fails with 2.5.3.
>=20
> Is there a workaround or an updated version of rtnet?

I asked for some more details about what you did and if you really read
the thread on RTnet's ./configure. Please answer those questions.

Jan


--------------enigF7039D5DD6EE138339CD699F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkyL1zoACgkQitSsb3rl5xQoRACg1wO6LbSxX8xdAt3RczKymhPP
420AoMo7wZX5LHbX3SIRn+bf0eTEMXx8
=rrjW
-----END PGP SIGNATURE-----

--------------enigF7039D5DD6EE138339CD699F--

