Message-ID: <465ABDBD.5080703@domain.hid>
Date: Mon, 28 May 2007 13:32:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <464D4E84.8030506@domain.hid>
In-Reply-To: <464D4E84.8030506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB1094A1605DEB26718697E4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] LTTng for Xenomai: Supporters wanted
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
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai-help <xenomai@xenomai.org>, jean-olivier.villemure@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB1094A1605DEB26718697E4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> looks like we have some new vacancies in this project. On the other
> hand, there is now the chance to improve the tool situation of Xenomai
> significantly:
>=20
> I've managed to hack (almost) recent LTTng on top of 2.6.20-ipipe-1.8-0=
1
> and Xenomai trunk. Thanks to Jean-Olivier's work for his diploma thesis=

> [1], we already had a patch to LTTV, the LTTng viewer. But as LTTng is
> still in stormy waters (kernel markers etc...), the backend interface
> for Xenomai/I-pipe needed a new concept to meet the current, hopefully
> now stable design. You can find the result attached in form of a
> screenshot of LTTV visualising parts of a simple latency run.
>=20
> The patches I have here currently need some unwinding from my personal
> queue, therefore nothing to publish yet. I will look at this again soon=
,

Patches are now available at

	http://www.rts.uni-hannover.de/rtaddon/patches

Still only as a series, but maintaining multiple queues would be a bit
too much effort for this.

Jan


--------------enigEB1094A1605DEB26718697E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGWr29niDOoMHTA+kRAgmLAJ44lzkdcJDANsHMKx2yRbVqD9QPUACfSZuV
Ge+57PPva1jV/Aob3VkY2tU=
=d2x+
-----END PGP SIGNATURE-----

--------------enigEB1094A1605DEB26718697E4--

