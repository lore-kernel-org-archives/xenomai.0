Message-ID: <44686D9B.2010509@domain.hid>
Date: Mon, 15 May 2006 14:01:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CPU load over 90%
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2B3D@square.bfh.ch>
In-Reply-To: <AD78122AD7C05B4B936EBAD7F49738C0AB2B3D@square.bfh.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA6A1ABCB22A76D45B04ADA3D"
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
To: Lauener Nathan <Nathan.Lauener@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA6A1ABCB22A76D45B04ADA3D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Lauener Nathan wrote:
> Hi,=20
> I am using Xenomai to read data from different sensors in real time fro=
m
> user space. So far I am reading position data from a device attached to=

> a serial port. The CPU load is at about 1%. I also have a
> microcontroller attached via USB to read encoder data. The USB device i=
s
> a USB-to-serial converter. As soon as I open the (USB-)serial port with=

> normal systemcalls and read the incoming data my CPU load skyrockets to=

> over 90%. I only read about 30 bytes every 100ms.
> I ran the application on a much newer computer also to rule out any
> buggy hardware. The results stayed the same. Intensively searching the
> mailing list and provided documentation have not helped solve the
> problem.=20
> I'm using Xenomai 2.1.0 with kernel 2.6.15.6. Xenomai is compiled into
> the kernel. I also use the driver xeno_16550A loaded as module. The
> USB-to-serial bridge used is a CP2101 from Silabs.=20

Is there any IRQ conflict between the USB host controller and some
RT-device? Please check /proc/interrupts and /proc/xenomai/irq.

Which process is consuming your CPU time? At system or at user level?

Jan


--------------enigA6A1ABCB22A76D45B04ADA3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEaG2bniDOoMHTA+kRAngAAJwJV/UZe0ZIIsv7KnlAVrtC2bptGwCeLKrk
cqEcJv9ti2pG+KrCQefJed8=
=GfAM
-----END PGP SIGNATURE-----

--------------enigA6A1ABCB22A76D45B04ADA3D--

