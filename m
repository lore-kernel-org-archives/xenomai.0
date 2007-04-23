Message-ID: <462C6E5C.5030609@domain.hid>
Date: Mon, 23 Apr 2007 10:29:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>	<078801c77d27$5e7cc420$1b764c60$@com>	<461E6CFE.7000004@domain.hid>	<009301c77da1$124fba10$36ef2e30$@com>	<17960.30503.154972.409174@domain.hid>	<00e801c78328$d2569a90$7703cfb0$@com>
	<462882BD.6000203@domain.hid>
In-Reply-To: <462882BD.6000203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig145E705A684B29EBBE6E985E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, Jose Pascual <josepascual@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig145E705A684B29EBBE6E985E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jose Pascual wrote:
>> I'm having in ethernet driver some ROVR errors because dma became full=
 for
>> load in linux, do=20
>> you think adeos-ipipe can help me in it? shoud it be necessary to chan=
ge
>> ethernet irq (portng to adeos)?
>=20
> You could port it to RTnet, you will get low latency IP/UDP, but beware=
,
> RTnet is incompatible with plain ipv4, so, if you want to run a network=

> with RTnet, all machines on the network need to run RTnet.
>=20

RTnet's IPv4 _is_ compatible with standard implementations. Moreover, if
you can control the network traffic deterministically without the help
of RTnet on every node, you can also run mixed network segments without
loosing real-time guarantees on the RTnet nodes. But that mode is more
tricky and far more fragile than running a dedicated RTnet segment.

Further questions can also be directed to rtnet-users at
lists.sourceforge.net.

Jan


--------------enig145E705A684B29EBBE6E985E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLG5cniDOoMHTA+kRAg2YAJ9GkgQ85N/baigmhABBTMmbXPyf4gCdEFBW
AiLdhZ4oq6Uptn4YNxaHkWA=
=CA/R
-----END PGP SIGNATURE-----

--------------enig145E705A684B29EBBE6E985E--

