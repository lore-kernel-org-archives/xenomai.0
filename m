Message-ID: <45462710.8040205@domain.hid>
Date: Mon, 30 Oct 2006 17:23:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
References: <1162219241.5188.21.camel@domain.hid>
	<1162208265.4955.17.camel@domain.hid>	<21364954.1162202747823.JavaMail.ngmail@domain.hid>	<16802252.1162217706570.JavaMail.ngmail@domain.hid>
	<15328399.1162222490427.JavaMail.ngmail@domain.hid>
In-Reply-To: <15328399.1162222490427.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB23606ADE17DEFFB24712177"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB23606ADE17DEFFB24712177
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I have repeated the test using a parallel stress test (dd if=3D/dev/sda=
 of=3D/dev/null, I have
> a SATA harddisk).
> The results are that my RTAI latency of 4=B5s is not valid, here the la=
tency is about 26=B5s.
> However, xenomai shows a higher latency of about 40=B5s.

How long did the tests run this time? To my experience anything below 30
min. is not meaningful. And the faster the machines get, the lower the
probability for certain constellations becomes. So each additional hour
runtime gives a little bit more confidence.

> The interesting thing is, that without load RTAI seems to run very long=
 in a very=20
> low latency region, at the same setup xenomai shows large latencies ear=
lier.
>=20
>=20
> Well, I have repeated these tests on a different PC that has a server m=
ainboard and=20
> a Pentium D 4 (real dual core) CPU.
> The results (measured under load) are much better here:
> RTAI shows a latency of about 6=B5s
> Xenomai shows a latency of about 10=B5s.
> Both values are acceptable, however I wonder where the difference comes=
 from?

RTAI contains a few shortcuts that may explain parts of this gap, but
not all.

One of these shortcuts is the immediate IRQ dispatching mode (the reason
why they have their own patch...). In that mode the registered timer IRQ
handler gets called without caring about any I-pipe abstraction.

Some others I recall are a missing clean timer subsystem abstraction
(tasked are timed, and then there are also some kind of timer tasklets)
and the immediate reschedule from IRQ context instead of doing this on
IRQ return. Some of those features should be controllable via magic
knobs, maybe it's worth a try what they actually buy you here.

In any case, to really understand the differences, it takes the tracer.
I will check if I can find my old RTAI hack to instrument their latency
tool - if you are still interested in digging deeper on your hardware.

Jan


--------------enigB23606ADE17DEFFB24712177
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFRicRniDOoMHTA+kRAtNSAJ9pyGZjrTksQjXJN0iuQjL/hlFD2gCdH2fG
CD48ttd1Lk2fPJMKlchz+gs=
=ggfp
-----END PGP SIGNATURE-----

--------------enigB23606ADE17DEFFB24712177--

