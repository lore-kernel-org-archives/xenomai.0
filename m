Message-ID: <45A6CB80.9060306@domain.hid>
Date: Fri, 12 Jan 2007 00:42:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_16550A and 8250.nr_uarts=0
References: <45A68383.3070203@domain.hid>
In-Reply-To: <45A68383.3070203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2E93655CE4F8E9FAC8510C47"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E93655CE4F8E9FAC8510C47
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> I have been successfully using the xeno_16550A rtdm serial driver for
> some time.  Up until now, I have always compiled xeno_16550A as a kerne=
l
> module, and then followed this procedure:
>=20
>  Boot using the following kernel options:
>    kernel /boot/vmlinuz-2.6.19.1xenomai2.3.0 ro root=3D/dev/sda1 noapic=

> pci=3Drouteirq
>  # setserial /dev/ttyS0 uart none
>  # /sbin/modprobe xeno_16550A ioaddr=3D0x3f8 irq=3D4
>  # ./sertest
>=20
> My serial test program works fine in the above scenario.  However, if I=

> try to disable the linux serial support at boot time by adding
> "8250.nr_uarts=3D0" to the kernel boot options, my serial test program
> does not work.  There are no errors opening, configuring, or reading
> from the rtdm device, but no data is received from the driver.  I assum=
e
> that my test program is not initializing something properly, so it work=
s
> when linux initializes the serial port.  I can't seem to find what I'm
> doing wrong.  Any help would be appreciated.

Hmm, maybe a PnP issue. If there is no driver registered for the on-chip
PnP UARTS, power might be switched off (or kept off) for them. As
xeno_16550A doesn't perform any validation of the underlying hardware
(dunno right now if there is a pattern to test at all), it may just
operate on dead addresses.

I faced the same issue with irqbench and parallel ports. They get
switched off once the related Linux driver is removed. One solution
there was to register irqbench with the PnP subsystem. I need to check
if this is required here as well.

Jan


--------------enig2E93655CE4F8E9FAC8510C47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpsuAniDOoMHTA+kRAhb9AJ4juvZtH191i4JIOGlFa4VqRUrtmgCfdwcg
xDE4KIwThWtaxhQuVUDlva0=
=3BR0
-----END PGP SIGNATURE-----

--------------enig2E93655CE4F8E9FAC8510C47--

