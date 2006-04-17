Message-ID: <4443AB94.50508@domain.hid>
Date: Mon, 17 Apr 2006 16:52:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai port to SH4
References: <009601c662f1$f164e700$1701a8c0@domain.hid>
In-Reply-To: <009601c662f1$f164e700$1701a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5DCE87912387438D03BBD06"
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
To: Kiichi Kameda <k-kameda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5DCE87912387438D03BBD06
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kiichi Kameda wrote:
> I have been porting Xenomai-2.0.2 to SH(SuperH) architecture.

Cool!

> Currently almost all functions work well. And, I am mesuring the perfor=
mance
> from user-space program using posix skin on a 240MHz SH7750R(SH4) machi=
ne,
> mainly 1 ms periodic dispatch latency. The measured data shows small
> latency(tens of micro seconds) when system has a light workload.
> In case of heavy workload such as frequent linux command input, the lat=
ency
> increases to some 200 micro seconds, though.

If you are looking for real heavy load: cache benchmarks tend to stress
your system most (e.g. http://www.cwi.nl/~manegold/Calibrator). Combine
them with heavy i/o load (flood ping etc.).

Anyway, 200 us for a 240 MHz system doesn't sound totally unrealistic.
But I do not know the sh4 architecture to give a reliable estimation.

What are your numbers when running latency in the other modes, i.e.
without the need to switch to user space (mode 1, "-t1") or even without
any context switch at all (mode 2, "-t2")?

>=20
> Following is the testsuit/latency/latency program(using native skin -
> slightly modified) output with comment.
> In case of posix skin, the data shows similar tendency.
>=20
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=

> worst
> ...(no workload)
> RTD|         333|        1400|        9733|       0|         333|
> 27066
> RTD|         333|        1466|       34533|       0|         333|
> 34533
> RTD|         266|        1400|       14533|       0|         266|
> 34533
> RTD|         400|        1400|       14466|       0|         266|
> 34533
> RTD|         333|        1333|        7533|       0|         266|
> 34533
> RTD|         266|        1400|       14333|       0|         266|
> 34533
> RTD|         333|        1400|       40866|       0|         266|
> 40866
> RTD|         333|        1466|       25533|       0|         266|
> 40866
> RTD|         266|        1400|       14400|       0|         266|
> 40866
> RTD|         400|        1400|       13600|       0|         266|
> 40866
> RTD|         266|        1400|        7466|       0|         266|
> 40866
> RTD|         333|        1466|       40800|       0|         266|
> 40866
> RTD|         333|        1400|       18466|       0|         266|
> 40866
> RTD|         333|        1400|       13533|       0|         266|
> 40866
> ...
> RTD|         333|        1333|        7133|       0|         266|
> 40866
> (telnet login)
> RTD|         266|        4400|      111000|       0|         266|
> 111000
> RTD|         333|        1400|       27266|       0|         266|
> 111000
> RTD|         333|        1466|       28000|       0|         266|
> 111000
>=20
> RTD|         333|        1466|       33133|       0|         266|
> 111000
> RTD|         333|        1466|       26800|       0|         266|
> 111000
> (single ps aux command)
> RTD|         333|       22800|      112533|       0|         266|
> 112533
> RTD|         333|        1400|       19400|       0|         266|
> 112533
> RTD|         266|        1466|       35000|       0|         266|
> 112533
> RTD|         333|        1400|        7533|       0|         266|
> 112533
> RTD|         333|        1400|       15733|       0|         266|
> 112533
> RTD|         266|        1866|       71333|       0|         266|
> 112533
> RTD|         333|        9866|      105866|       0|         266|
> 112533
> RTD|         266|        1400|       14400|       0|         266|
> 112533
>=20
> RTD|         266|        1400|       11266|       0|         266|
> 112533
> RTD|         400|        1466|       50133|       0|         266|
> 112533
> RTD|         333|        3066|      116866|       0|         266|
> 116866
> (successive ps aux command)
> RTD|        1266|       15933|      218866|       0|         266|
> 218866
> RTD|        1266|        2400|       76666|       0|         266|
> 218866
> RTD|         333|        1400|       15000|       0|         266|
> 218866
> RTD|         266|        1400|       27600|       0|         266|
> 218866
> RTD|         400|        1400|       15333|       0|         266|
> 218866
> RTD|         266|        1333|        6933|       0|         266|
> 218866
> RTD|         333|        1400|       16533|       0|         266|
> 218866
> RTD|         400|        1800|       75933|       0|         266|
> 218866
>=20
>=20
> It is enough possible I have misported the Xenomai to SH, but I also th=
ink
> Xenomai user-space program(primary mode) suffers such extra latency whe=
n
> Linux kernel runs Linux programs.
>=20
> I will appreciate any suggestion for latency improvement.

Very helpful for understanding what happens on your system is the ipipe
latency tracer. We have support for x86 and ppc so far, and there are
"templates" for porting it to other archs available from Ingo Molnar's
original patch. Unfortunately, even the latter does not yet include sh4
support, so porting it would be a real pioneer work. :)

But, basically, it can be as simple as writing an mcount stub in
assembly to call the actual tracing function. See x86 on this.

Jan


--------------enigC5DCE87912387438D03BBD06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQ6uUniDOoMHTA+kRAnD5AJwOFBqsdScJJPbe9yP3fFjhk0eiBgCfdz0N
5s4sel9ZQr+xsEW7zRdeUo4=
=XzGp
-----END PGP SIGNATURE-----

--------------enigC5DCE87912387438D03BBD06--

