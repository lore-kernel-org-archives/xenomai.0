Message-ID: <469746E9.6050503@domain.hid>
Date: Fri, 13 Jul 2007 11:33:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20070713092440.281340@domain.hid>
In-Reply-To: <20070713092440.281340@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB75181E60C0588A6889FD5B9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] error compiling linux 2.6.22 or 2.6.22.1 with
 adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB75181E60C0588A6889FD5B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Karl Reichert wrote:
> Hello,
>=20
> tried the adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch, but it works neithe=
r with linux 2.6.20 nor 2.6.20.1
> patch and prepare-kernel.sh worked, after make menuconfig I tried to co=
mpile with make and get the following (my gcc gives me german errors, so =
I tried to translate as good as possible):
> [...]
> In file included from include/asm/xenomai/hal.h:40,
>>from kernel/xenomai/arch/generic/hal.c:42:
> include/asm/xenomai/wrappers.h: in function wrap_switch_iobitmap:
> include/asm/xenomai/wrappers.h:86: error: struct tss_struct has no elem=
ent named io_bitmap_base
> include/asm/xenomai/wrappers.h:96: error: struct tss_struct has no elem=
ent named io_bitmap_base
> [...]
>=20
> Any hints? My gcc is 4.1.2

Don't use 2.6.22 patches for 2.6.20! Pick ipipe-2.6.22-i386-1.8-05 for
your test.

Jan


--------------enigB75181E60C0588A6889FD5B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGl0bpniDOoMHTA+kRAviKAJ0Toom0OucfxXfjdZ24MnLGTLYVWwCdGjea
PdAs7JrSPxzwbMLPPLipYaY=
=DNk1
-----END PGP SIGNATURE-----

--------------enigB75181E60C0588A6889FD5B9--

