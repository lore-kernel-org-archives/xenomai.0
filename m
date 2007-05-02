Message-ID: <46385C3A.1020600@domain.hid>
Date: Wed, 02 May 2007 11:39:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46384E4B.2050200@domain.hid> <1177947596.32698.47.camel@domain.hid>
	<1177686318.5010.106.camel@domain.hid>	
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>	
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>	
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>	
	<784082.1177682909759.JavaMail.ngmail@domain.hid>	
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>	
	<1177685762.5010.104.camel@domain.hid>	
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>	
	<1177706363.5010.158.camel@domain.hid>
	<33288775.1178089500362.JavaMail.ngmail@domain.hid>
	<33481027.1178097243064.JavaMail.ngmail@domain.hid>
In-Reply-To: <33481027.1178097243064.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53C00056022A9B3A789D06F2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
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
--------------enig53C00056022A9B3A789D06F2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> here is the result of this patch.
> I patched in addition to Philippe's patches.
>=20
> Regards
>=20
> Mathias
> ---------
> Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
> Copyright (c) 1999-2006 Intel Corporation.
> ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:=
48:5a:f9:0a
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s 00000000
>  printing eip:
> dfedd3ca
> *pde =3D 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: e1000
> CPU:    0
> EIP:    0060:[<dfedd3ca>]    Not tainted VLI
> EFLAGS: 00010082   (2.6.20.4 #7)
> EIP is at 0xdfedd3ca
> eax: c0112478   ebx: 00000001   ecx: c0114581   edx: df06c001
> esi: dfedf6c0   edi: dfedc240   ebp: 00000000   esp: df06ddf8
> ds: 007b   es: 007b   ss: 0068
> Process ifconfig (pid: 1242, ti=3Ddf06c000 task=3Dc16f9030 task.ti=3Ddf=
06c000)
> Stack: 00000040 ffffffff 00000000 00000007 c03e6f00 000000ec 00000000 c=
03d9180
>        c010f1b5 c015291a decbe080 00000680 decbe080 00000724 c02d6dfd 0=
0007600
>        00000001 00000060 e099a210 00000286 ffffff24 df7065c8 00000000 0=
000000f
> Call Trace:
>  [<c010f1b5>] __ipipe_handle_irq+0x26b/0x2bd

I must have patched crap into this, but I don't see it. Could someone
have a look why there is no printk output related to #IRQ 219
(~0xffffff24, see stack content)?

BTW, Mathias, forcing your kernel into single CPU mode via kernel
command line "cpus=3D1" doesn't expose the issue, right? Could we face
some kind of setup race across the CPUs here?

Thanks,
Jan


--------------enig53C00056022A9B3A789D06F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOFw6niDOoMHTA+kRAjwJAJ9bIRfSxO+xnGzjcMb15rnelLIPzwCfV61u
pxlT8jptoFULmPhtUS5JkWw=
=ua2x
-----END PGP SIGNATURE-----

--------------enig53C00056022A9B3A789D06F2--

