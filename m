Message-ID: <459C190E.3080601@domain.hid>
Date: Wed, 03 Jan 2007 21:58:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] parallelport module for
	measuring	external	interrupt latency
References: <459B6DAD.4030406@domain.hid>	<459B7C6C.9030401@domain.hid>	<459B8382.7060508@domain.hid>	<459B8A19.2060809@domain.hid>
	<459C13C5.9010007@domain.hid>
In-Reply-To: <459C13C5.9010007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig32488AA84F42E3053CAF4041"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32488AA84F42E3053CAF4041
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Jan Kiszka wrote:
>> Even if the notification is not time-critical, you first have to get o=
ut
>> of the Xenomai context in a sane manner. rtdm_nrtsig may help if you
>> don't want to use the RT scheduler for user task wakeup.
>=20
> OK. Thank you for the hint with rtdm_nrtsig_*. The kernel-module works =
now.
>=20
> But I have still a problem when generating interrupts with a high
> frequency, let's say 100us. Then I get large latencies in the range of
> 1,5 seconds. Can you see any reason for this. An intervall of 1ms works=

> without any problems and the latencies reach maybe 13us in worst case.

Unless you have a very slow hardware that already overruns at 10 KHz
(rather unlikely) or some SMI-related latencies bite you (see
TROUBLESHOOTING) - I have no clue right now. Do standard Xenomai tests
show similar abnormal latencies?

If no, you may want to try the ipipe latency tracer: enable it in the
kernel hacking section and put a xntrace_user_freeze() in your
application right after when it detected some extreme latency. See the
wiki for more details on the tracer.

Jan


--------------enig32488AA84F42E3053CAF4041
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFnBkSniDOoMHTA+kRAjV+AJ0f5XQQ20RjJ0Wy1Ck3ZXZ8PGkJBwCghLkX
mi/fIuWUjEkKy5X3H4QfnNA=
=bHVF
-----END PGP SIGNATURE-----

--------------enig32488AA84F42E3053CAF4041--

