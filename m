Message-ID: <47B0ADE8.5060504@domain.hid>
Date: Mon, 11 Feb 2008 21:19:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24D7E8A54DA6D704F3B100EC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] irq0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24D7E8A54DA6D704F3B100EC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> I used the idle=3Dpoll option so I'm running the tsc now, and irq0 hand=
ler
> still has a lot of overhead.=20
>=20
> =20
>=20
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>=20
>   0  0      0          2          0     00500080   94.2  ROOT
>=20
>   0  0      0          1          0     00100082    0.0  sound task
>=20
>   0  0      0          1          0     00100082    0.0  tone task
>=20
> 0  0      0          775585     0     00000000    5.6  IRQ0: [timer]
>=20
> =20
>=20
> I'm seeing about 17,000 context switches a second for IRQ0. Sound task
> and tone task are doing nothing. They're just blocked.
>=20

Ah! That could mean the timer gets misprogrammed, fires too early and=20
thus too often. I had this effect on an standard PC when we used a=20
slightly wrong APIC frequency. Do you use the APIC? -> /proc/xenomai/time=
r

Also this effect can nicely be confirmed via LTTng traces.

Jan


--------------enig24D7E8A54DA6D704F3B100EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHsK3oniDOoMHTA+kRAu+oAJ9hA+NzA+kyp0Vc1/gAySpr1zb/LgCeLsBD
IqqPLE35t2rIQsrsiOuYyXw=
=S2DX
-----END PGP SIGNATURE-----

--------------enig24D7E8A54DA6D704F3B100EC--

