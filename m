Message-ID: <448E98A3.6080707@domain.hid>
Date: Tue, 13 Jun 2006 12:51:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig95429F0C26ECCF36BE1B961E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] ns vs. tsc as internal timer base
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
--------------enig95429F0C26ECCF36BE1B961E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

between some football half-times of the last days ;), I played a bit
with a hand-optimised xnarch_tsc_to_ns() for x86. Using scaled math, I
achieved between 3 (P-I 133 MHz) to 4 times (P-M 1.3 GHz) faster
conversions than with the current variant. While this optimisation only
saves a few ten nanoseconds on high-end, slow processors can gain
several hundreds of nanos per conversion (my P-133: -600 ns).

This does not come for free: accuracy of very large values is slightly
worse, but that's likely negligible compared to the clock accuracy of
TSCs (does anyone have any real numbers on the latter, BTW?).

As we loose some bits the one way, converting back still requires "real"
division (i.e. the use of the existing slower xnarch_ns_to_tsc).
Otherwise, we would get significant errors already for small intervals.

To avoid loosing the optimisation again in ns_to_tsc, I thought about
basing the whole internal timer arithmetics on nanoseconds instead of
TSCs as it is now. Although I dug quite a lot in the current timer
subsystem the last weeks, I may still oversee aspects and I'm
x86-biased. Therefore my question before thinking or even patching
further this way: What was the motivation to choose TSCs as internal
time base? Any pitfalls down the road (except introducing regressions)?

Jan


PS: All this would be 2.3-stuff, for sure.


--------------enig95429F0C26ECCF36BE1B961E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjpinniDOoMHTA+kRAn3iAJ0U7MF5QiovC0zBS37MrzgDkjZ6QgCeJam3
DXBtiiB7Hf7hyZiliQtZHVg=
=jnka
-----END PGP SIGNATURE-----

--------------enig95429F0C26ECCF36BE1B961E--

