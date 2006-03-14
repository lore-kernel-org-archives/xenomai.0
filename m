Message-ID: <44172B67.2000609@domain.hid>
Date: Tue, 14 Mar 2006 21:45:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA08748D591C0C8280D4A1D2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Synchronising TSC and periodic timer
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
--------------enigAA08748D591C0C8280D4A1D2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

for those who haven't followed the endless "RTDM and Timer functions"
thread: we are currently discussing a way to provide high-resolution
timestamps in periodic mode for RTDM users. It was suggested to use the
TSC for this, but I noted that this source will not be in sync with the
periodic system timer and may even be out of sync across multiple CPUs.

A straight-forward approach to overcome this might be to record the
current TSC value together with the current jiffies in
xntimer_do_tick_periodic(). This tuple (per CPU) could then be provided
to skin implementers in order to let them offer a high-resolution
timestamp source even in periodic mode. Hmm, sounds too simple actually,
so I'm waiting now for someone pointing out the pitfalls.

Jan


--------------enigAA08748D591C0C8280D4A1D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFytnniDOoMHTA+kRAhrnAJ9VT1kQZUFpE6ymvycGzGl3+m+o6ACfWiwG
i3EtLCVQzcO6UZ7uJX4Fcgg=
=empD
-----END PGP SIGNATURE-----

--------------enigAA08748D591C0C8280D4A1D2--

