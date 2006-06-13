Message-ID: <448EDECA.7030302@domain.hid>
Date: Tue, 13 Jun 2006 17:50:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strange periodic behavior
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
	<448E5A2B.9060606@domain.hid>
	<3384.206.81.135.88.1150211884.squirrel@domain.hid>
In-Reply-To: <3384.206.81.135.88.1150211884.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2ADDC1CB7749C2391DC7374F"
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
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2ADDC1CB7749C2391DC7374F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
> Well, I'm working on a desktop but frequency scaling was enabled, so I
> recompiled the kernel without frequency scaling support and the behavio=
r
> still persists.=20

Sure your kernel was updated? Check /proc/cpuinfo for varying numbers
with and without system load.

> I've run the latency program from the test suite, but I'm
> not sure how I should interpret the output.  What indicators am I looki=
ng
> for?

High jitters of the measured delays if the cpu frequency changes. Once
the frequency is different from the calibration time, you either get too
short or too long intervals when reading the time. You will not see any
effect if your CPU is in the same state during both calibration and
measuring time.

But maybe it is better to post a simple excerpt of your test which shows
your problem and let us cross-check.

Jan


--------------enig2ADDC1CB7749C2391DC7374F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjt7KniDOoMHTA+kRAi9ZAJ0ShsrwhQaJEvsjOOjsVoUE1tjf6QCeLZy4
N/cGAQjguWgfO49O29ig9M4=
=uKEA
-----END PGP SIGNATURE-----

--------------enig2ADDC1CB7749C2391DC7374F--

