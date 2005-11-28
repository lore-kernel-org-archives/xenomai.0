Message-ID: <438B6F43.4060104@domain.hid>
Date: Mon, 28 Nov 2005 21:57:39 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB053A33E3B86D19F95408AFC"
Subject: [Xenomai-core] [RFC] latency tracing
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB053A33E3B86D19F95408AFC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

as I'm lazy, er busy, I'm pushing this idea into public instead of
hacking a patch on my own: wouldn't it be nice to have something like
the latency backtrace of PREEMPT_RT also in Xenomai? Even when the core
is once optimised ;), there can still be drivers with long IRQ locks
nuking the WCET.

I saw that there is already something for SMP spinlock debugging. Is it
a lot of work to extend this to UP and maybe even all IRQ-off locks? Did
someone already look at the backtrace implementation of PREEMPT_RT in
details? Is is complicated to port? Does it require some changes at
ADEOS level?

Jan


--------------enigB053A33E3B86D19F95408AFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDi29DncNeS9Q0k+IRAqWqAJ94SxOsg0/pkG1O1Fixn5DQij1AFACfRsLQ
FhXiZbvOxDrGK55FUriP2aw=
=pa8a
-----END PGP SIGNATURE-----

--------------enigB053A33E3B86D19F95408AFC--

