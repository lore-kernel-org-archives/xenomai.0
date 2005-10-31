Message-ID: <436613FF.50604@domain.hid>
Date: Mon, 31 Oct 2005 13:54:23 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig47EF0D1DA224DDA8516A4EC6"
Subject: [Xenomai-core] [RFC] support for sharing IRQs
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
--------------enig47EF0D1DA224DDA8516A4EC6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

at the moment the 16550A UART driver that comes with Xenomai does not
support IRQ sharing between serial ports or with other real-time
devices. I first considered adding such support to the driver
internally, but I think it's better work on a generic approach for Xenoma=
i.

I have some code hanging around here which implements IRQ sharing at
skin level for an experimental in-house development over Xenomai. The
code is smart enough to register an IRQ sharing trampoline handler only
in case sharing is actually practiced for a specific line. The IRQ API
is just extended by a single flag (imagine RTDM_IRQ_SHARED) which is set
upon registering an ISR that is capable of IRQ sharing. The semantic is
the same as the kernel's SA_SHIRQ.

I think it would be possible to break this out and generate a mainline
patch. Anyway, the question for me is where to put this best, at skin
(RTDM?) or at nucleus level? Both is technically feasible, but which way
is desired? (I would vote for the nucleus...)

Jan


--------------enig47EF0D1DA224DDA8516A4EC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZhP/ncNeS9Q0k+IRAkRtAKDqPF/WUU3UvyWOK7J3ttQzpkdpIgCfbMB4
e5O1kTcjSR1pV+71u7aEKYY=
=88n9
-----END PGP SIGNATURE-----

--------------enig47EF0D1DA224DDA8516A4EC6--

