Message-ID: <441E9698.5080506@domain.hid>
Date: Mon, 20 Mar 2006 12:48:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>	<4417C14A.2010900@domain.hid>	<44180FB8.7080200@domain.hid>	<17432.5656.591747.248941@domain.hid>
	<44189C13.3010301@domain.hid>
In-Reply-To: <44189C13.3010301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig246EBD19905C3E10121CB80B"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig246EBD19905C3E10121CB80B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> ...
> The issue that worries me - provided that we bound the adjustment offse=
t
> to the duration of one tick after some jittery - is that any attempt to=

> get intra-tick precision would lead to a possible discrepancy regarding=

> the elapsed time according to those two different scales, between the
> actual count of jiffies tracked by the timer ISR on the timekeeper CPU,=

> and the corrected time value returned by rtdm_read_clock. And this
> discrepancy would last for the total duration of the jitter. E.g., for =
a
> 100 us period, xnpod_get_time() could return 2 albeit rtdm_read_clock
> returns 300, instead of 200. Spuriously mixing both units in
> applications would lead to some funky chaos.
>=20

Trying to pick up this thread again, I just tried to understand your
concerns, but failed so far to imagine a concrete scenario. Could you
sketch such a "funky chaotic" situation from the application point of
view? And what would prevent us from improving the accuracy of other
timestamping API functions beyond RTDM as well, e.g. on converting from
ticks to nanos in rt_timer_ticks2ns()?

Jan


--------------enig246EBD19905C3E10121CB80B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHpaYniDOoMHTA+kRAmGaAJ46W1mE2vY/RVA8nzDaLU01x6KToACdGVJB
xMRgYYTwKkYO+OwLqsuJLgo=
=XWUJ
-----END PGP SIGNATURE-----

--------------enig246EBD19905C3E10121CB80B--

