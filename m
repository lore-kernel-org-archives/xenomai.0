Message-ID: <450D3764.80601@domain.hid>
Date: Sun, 17 Sep 2006 13:54:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E87836FFB72CFBEE93B691B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] official TSC model on SMP
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
--------------enig9E87836FFB72CFBEE93B691B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

reading through timer code of Xenomai I just wondered (again) what our
official model of TSCs on multiprocessor boxes are:

1) (practically) perfectly synchronised without offset

2) synchronised but with (unknown?) offset

3) unsynchronised

I'm asking because I worried about timestamps taken on external events
like interrupts on one CPU and are then used to trigger some timed
operation on another. Such things may easily happen via RTDM devices
where we do not communicate the CPU source of event timestamps. But
there is also other code influenced by the TSC model, e.g. data
collection and evaluation for CPU load stats.

Jan


--------------enig9E87836FFB72CFBEE93B691B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFDTdnniDOoMHTA+kRAoaQAJ9O4q4GeYrm7rj14EigCr8xkwe47ACfaV+1
O9hlz16TuxOJbL7pasOcn+w=
=PYEY
-----END PGP SIGNATURE-----

--------------enig9E87836FFB72CFBEE93B691B--

