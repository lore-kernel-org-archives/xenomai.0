Message-ID: <472043C1.1040506@domain.hid>
Date: Thu, 25 Oct 2007 09:20:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e4ef24880710241635p102f5f44i3f5e5e88bc0e4b02@domain.hid>
In-Reply-To: <e4ef24880710241635p102f5f44i3f5e5e88bc0e4b02@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9469061C9E8F42B8DCD7AC10"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux
	2.6.23
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9469061C9E8F42B8DCD7AC10
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Robert Gubler wrote:
> Hello,
>=20
> I am trying to build a kernel that supports xenomai, but every combinat=
ion
> of xenomai releases, adeos-ipipe patches, and linux kernels don't seem =
to
> build successfully for me.  First, I'd like to know if someone recommen=
ds a
> particular version of all of these that is known to work for you?? Righ=
t now
> I am trying to use:
>=20
> linux-2.6.23.tar.bz2  (from kernel.org)
> xenomai-2.4-rc4.tar.bz2
> adeos-ipipe-2.6.23-i386-1.10-10.patch
>=20
>=20
> Heres is what I am doing:
>=20
> # ./prepare-kernel.sh --linux=3D~/incoming/linux-2.6.23--adeos=3D~/inco=
ming/adeos-
> ipipe-2.6.23-i386-1.10-10.patch --arch=3Di386
>=20
> ..... (no indication of failure) ....
>=20
> # cd ~/incoming/linux-2.6.23
>=20
> # make clean distclean mrproper
>=20
> # make menuconfig
>=20
> # make
>=20
> ......
>=20
>=20
>   AS      arch/i386/boot/compressed/head.o
>   CC      arch/i386/boot/compressed/misc.o
> In file included from include/linux/ipipe_base.h:29,
>                  from include/linux/kernel.h:17,
>                  from include/asm/system.h:4,
>                  from include/asm/processor.h:18,
>                  from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/vmalloc.h:4,
>                  from arch/i386/boot/compressed/misc.c:14:
> include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
> directory
> make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1
> make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
> make: *** [bzImage] Error 2

This should not happen anymore. Could you post your .config so that we
can try to reproduce the error?

>=20
>=20
> I've read the included README.INSTALL and TROUBLESHOOTING docs included=
 with
> xenomai, but they didn't seem to help me in this case.  If anyone has
> recommendations for me that would be great!
>=20
> Thanks,
>=20
> Rob
>=20

Are there more combinations that do not build? Note that the issue above
is 2.6.23-specific.

Jan


--------------enig9469061C9E8F42B8DCD7AC10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHIEPBniDOoMHTA+kRAtOGAJ4pN44IkbsN9TtbpiVY/HIAvyvJrgCfceQp
6AiGnqbX3ZfMT5jPxvfpAhQ=
=aqxt
-----END PGP SIGNATURE-----

--------------enig9469061C9E8F42B8DCD7AC10--

