Message-ID: <43E1E252.8090304@domain.hid>
Date: Thu, 02 Feb 2006 11:43:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Three questions about RTDM
References: <1138870064.8753.19.camel@domain.hid>	
	<43E1D0D6.2020003@domain.hid>
	<1138876539.8753.60.camel@domain.hid>
In-Reply-To: <1138876539.8753.60.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB43CEFA2173FA19D32073B33"
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
To: Alessio Igor Bogani <abogani@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB43CEFA2173FA19D32073B33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alessio Igor Bogani wrote:
> Hi Jan,
>=20
> Thank for your reply.
>=20
> [...]
>>> 1) Where may I find a more detailed documentation about RTDM?=20
>> More detailed than what? Have you already discovered the online docs o=
n
>> www.xenomai.org?
>=20
> Yes i have already discovered online docs.
> IMVHO API Reference is indispensable but not sufficient.
> I would be very happy to see for RTDM something similar to Xenomai's
> Native-API-Tour.

Would be nice - just takes /someone/ to write it... :-/

Maybe this paper can provide a few further hints meanwhile:

ftp://ftp.realtimelinuxfoundation.org/pub/events/rtlws-2005/JanKiszka.pdf=


>=20
>>> 2) Now I'm attempting to write a simple device driver with RTDM: Can
>>> someone show me a standard GNUMakefile/Makefile to compile it?
>> Take a look at the heartbeat example on
>>
>> www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon
>>
>> This works for 2.6 kernels and Xenomai 2.0.x. I still need to update i=
t
>> for Xenomai 2.1, where compilation melts down to simple out-of-tree
>> kernel module generation. Does anyone else here have a generic Makefil=
e
>> for all kernel and Xenomai versions at hand?
>=20
> Google is a great friend. ;-)
>=20
> I have already seen heartbeat example.
> Mysteriously heartbeat.ko module resulted is dependent from
> latency_rt.ko module (present in testsuite\klatency in Xenomai package)=

> for a reason that i don't understand. :-(
> How can resolve this problem?

Due to which symbol? Which Xenomai version precisely? Indeed very
strange. Something must be broken in your build.

>=20
> Thank you very much!
>=20
> Bye,
> Alessio
>=20

Jan


--------------enigB43CEFA2173FA19D32073B33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4eJVniDOoMHTA+kRAo7oAJ9baEkcfEmkTOqW1DKkqApLmYzwYACfWKss
gJS4GRQPuc23muOQRafgJt0=
=7Jod
-----END PGP SIGNATURE-----

--------------enigB43CEFA2173FA19D32073B33--

