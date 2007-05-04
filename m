Message-ID: <463B5E27.7050408@domain.hid>
Date: Fri, 04 May 2007 18:24:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1178268043.5391.47.camel@domain.hid> <463B086B.6060402@domain.hid>
In-Reply-To: <463B086B.6060402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig350FEEBFF4889E98E872D651"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, CAMUS Benoit <benoit.camus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig350FEEBFF4889E98E872D651
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> CAMUS Benoit wrote:
>> Hi,
>>
>> I'm using Xenomai 2.3.1 with a 2.6.19.2 kernel (from ELDK) on a custom=

>> board based on Xscale PXA processor and with smc91c111 ethernet chip. =

>> I did modifications on Linux kernel to port it on board and then just
>> applied Adeos's patch following Xenomai's proceedings.
>> Http and telnet servers are running on and i notice that latencies get=

>> really worse while i access any of them (see traces below).
>>
>> I understood that Adeos might avoid that kind of behavior due to its
>> architecture. So i infer that the ethernet driver might access the
>> hardware by-passing Adeos ?
>=20
> Despite Adeos architecture, latency with Xenomai is known to depend on
> the non real-time workload, because there are some low-level ressources=

> such as busses and processor cache that the real-time and non real-time=

> processes need to share.

Such effects can often be analysed with... the latency tracer [1]!

When some hardware interaction shows up right before the delayed timer
(or whatever RT-)IRQ, Xenomai cannot help. But if there is something
else, more fishy going on, you will see long interrupts-off sections,
weird scheduling decisions, etc. Then our job starts again.

Jan

[1] http://www.xenomai.org/index.php/I-pipe:Tracer


--------------enig350FEEBFF4889E98E872D651
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGO14nniDOoMHTA+kRAk+YAJ0XuPs/ed3FMMpctluI8m1rE0McFgCghJ6v
LI8BMOC2psHG3Xb5eIYGq1c=
=sVja
-----END PGP SIGNATURE-----

--------------enig350FEEBFF4889E98E872D651--

