Message-ID: <4587A2D4.3020102@domain.hid>
Date: Tue, 19 Dec 2006 09:29:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native leads to
References: <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
In-Reply-To: <4970132.1166516081275.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig33CEC634D857052D10843F76"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33CEC634D857052D10843F76
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> here is my /proc/interrupts=20
>=20
>            CPU0
>   0:     331260   IO-APIC-edge      timer
>   1:          8   IO-APIC-edge      i8042
>   7:          0   IO-APIC-edge      parport0
>   9:          0   IO-APIC-fasteoi   acpi
>  14:         12   IO-APIC-edge      ide0
>  16:       1022   IO-APIC-fasteoi   eth0
>  19:       2358   IO-APIC-fasteoi   libata
> NMI:     331248
> LOC:     331233
> ERR:          0
> MIS:          0

Nothing unusual on first sight.

>=20
> I have enclosed a config.gz file of my 2.6.19.1 kernel.

Two things to try:
 - CONFIG_XENO_HW_NMI_DEBUG_LATENCY_MAX=3D100 (i.e. default again)
 - CONFIG_PROFILING=3Dy (I'm not sure ATM if it may interfere with
                       Xenomai's watchdog)

Jan


--------------enig33CEC634D857052D10843F76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFh6LaniDOoMHTA+kRAlH0AJ4zwBeMOBDqfhmb40+VM+TuD5PySwCfYJB8
7ChQgtA2ZbxVMzSIrrZMw6Y=
=+Z17
-----END PGP SIGNATURE-----

--------------enig33CEC634D857052D10843F76--

