Message-ID: <454F2A8D.8080204@domain.hid>
Date: Mon, 06 Nov 2006 13:29:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Modbus TCP
References: <454F10B5.7000804@domain.hid>
In-Reply-To: <454F10B5.7000804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig57603610DE1191F78549A8B4"
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
To: rtai@domain.hid
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57603610DE1191F78549A8B4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marco Cavallini wrote:
> Hello,
> I wonder if does exist any Modbus TCP or Modbus UDP project for real
> time (Xenomai or RTAI)

I'm not aware of specific real-time Modbus implementations, I only heard
of some Modbus library for Linux (libmodbus), and then there is also a
Java version (jamod.sf.net).

If you want to use TCP, it will be as simple as switching to secondary
mode in your Xenomai application and communicate over the Linux TCP/IP
stack - it's non-RT anyway then. But when using UDP, libmodbus should
(in theory) be applicable in combination with RTnet over the POSIX skin
in primary mode (hard RT). You should just audit the time critical paths
of libmodbus for RT-safeness. Please share your findings, they might be
of common interest!

Jan


--------------enig57603610DE1191F78549A8B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFTyqNniDOoMHTA+kRAokhAKCBqcharhaujXp4sf13TXl8ctf7EQCfdXGD
kN0HTkhp7qCbVMuH/rELWsQ=
=DRSi
-----END PGP SIGNATURE-----

--------------enig57603610DE1191F78549A8B4--

