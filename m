Message-ID: <44689BBE.1000304@domain.hid>
Date: Mon, 15 May 2006 17:18:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9A3937179A9742CC3CB2327C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] LTTng intergration roadmap
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
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A3937179A9742CC3CB2327C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

the need for a high-level tracing tool constantly increases with the
growing code base of Xenomai applications.

Yesterday I started a short discussion with Alexis about the status of
his LTTng combo patch, the Xenomai integration, and the advances of
LTTng itself. But there are certainly more people interested in this
topic and may contribute ideas, comments, or even concrete code.

Daniel, you once said that some of your students would start to work on
this topic. In which domain precisely, more at patch level or rather on
tools? What is the scheduled beginning and/or deadline for this thesis?

Moreover, does anyone on this list recently tried LTTng on standard
Linux? Can we consider it reasonably stable and usable? One new thing
about LTTng internals which Alexis brought up were changes in the custom
tracing event interface. As this is a rather crucial point with respect
to the Xenomai instrumentation, we certainly do not want to change it
back and forth until LTTng stabilises.

Jan


--------------enig9A3937179A9742CC3CB2327C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEaJu+niDOoMHTA+kRAtHBAJ9s9RMczEBNe5V8rsfhqqHpLUMy/wCfYypb
INHyfJ1ScKTTVNakP6QS9as=
=hnlE
-----END PGP SIGNATURE-----

--------------enig9A3937179A9742CC3CB2327C--

