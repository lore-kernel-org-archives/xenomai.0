Message-ID: <4AE85EE2.60209@domain.hid>
Date: Wed, 28 Oct 2009 16:10:26 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <200910281314.00378.leo@domain.hid>
In-Reply-To: <200910281314.00378.leo@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4E03A7E074EE0F6DC35EE6B3"
Subject: Re: [Xenomai-help] Xenomai patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E03A7E074EE0F6DC35EE6B3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Leopold Palomo-Avellaneda schrieb:
> Hi,
>=20
> I'm having a trouble installing xenomai in a debian machines. Actually =
the=20
> official debian package is not useful. You cannot use it because there'=
s no=20
> kernel package that could be patched.
>=20
> Anyway, I would like to ask about if, for example, a patch against a 2.=
6.30=20
> could be used against 2.6.30.4 for example or reverse. I don't understa=
nd why=20
> this four numbers instead of the classical 3. Or, how can I modify it t=
o use=20
> it.

Try to modify the line starting with KVERSION=3D... in the file
/usr/src/kernel-patches/$ARCH/apply/xenomai
Replace the 4 digit version numbers with 3 digits.

However, if suggest to download the kernel source from kernel.org, this w=
ill work
without changing the above mentioned file.

Im using Debian Lenny and the following is working for me:
(replace the version numbers...)

First: build the xenomai deb packages:
--------------------------------------

1) install needed packages as root:
# apt-get install debhelper devscripts dh-kpatches findutils

2) create a new directory:
~$ mkdir -p src/xenomai && cd src/xenomai

3) download xenomai:
~/src/xenomai$ wget http://download.gna.org/xenomai/stable/xenomai-2.4.7.=
tar.bz2

4) repack the archive (*tar.bz2 -> *orig.tar.gz):
~/src/xenomai$ bzcat xenomai-2.4.7.tar.bz2 | gzip > xenomai_2.4.7.orig.ta=
r.gz && rm xenomai-2.4.7.tar.bz2

5) extract the archive:
~/src/xenomai$ tar -zxf xenomai_2.4.7.orig.tar.gz

6) change dir:
~/src/xenomai$ cd xenomai-2.4.7/

7) update debian/changelog:
~/src/xenomai/xenomai-2.4.7$ debchange -v 2.4.7-0 Release 2.4.7

8) build:
~/src/xenomai/xenomai-2.4.7$ debuild

9) as root: install the deb's:
/..../src/xenomai# dpkg -i *.deb


Second: download, patch and build the kernel:
---------------------------------------------

1) install needed packages:
# apt-get install kernel-package libncurses-dev fakeroot zlib1g-dev

2) create a new directory:
~$ mkdir -p src/linux && cd src/linux

3) download kernel source:
~/src/linux$ wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.2=
8.7.tar.bz2

4) extract it:
~/src/linux$ tar -jxf linux-2.6.28.7.tar.bz2

5) enter directory:
~/src/linux$ cd linux-2.6.28.7/

6) patch the kernel with xenomai:
~/src/linux/linux-2.6.28.7$ /usr/src/kernel-patches/i386/apply/xenomai

7) configure the kernel:
[optional] copy a kernel config to .config and run "make oldconfig" [/opt=
ional]
~/src/linux/linux-2.6.28.7$ make menuconfig

8) compile the kernel with make-kpkg:
~/src/linux/linux-2.6.28.7$ fakeroot make-kpkg --initrd --append-to-versi=
on -xenomai-2.4.7 --revision 1.0 binary-arch

if you have a multicore box, use CONCURRENCY_LEVEL=3D to speed up the bui=
ld:
~/src/linux/linux-2.6.28.7$ CONCURRENCY_LEVEL=3D2 fakeroot make-kpkg --in=
itrd --append-to-version -xenomai-2.4.7 --revision 1.0
binary-arch

9) as root: install the deb's:
/..../src/linux# dpkg -i *.deb


thats all folks...

regards, kisda


>=20
> Regards,
>=20
> Leo
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20



--------------enig4E03A7E074EE0F6DC35EE6B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFK6F7oIPTw9rIdn6oRAn/BAJ9RliA6+4DkeWtNEDZsUKpdrl74fACeOJlE
oLf7RpeHTT1HtRZkvUV4vjU=
=5mTh
-----END PGP SIGNATURE-----

--------------enig4E03A7E074EE0F6DC35EE6B3--

