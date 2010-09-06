Message-ID: <4C84EA0D.5040401@domain.hid>
Date: Mon, 06 Sep 2010 15:18:05 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <20100906080353.574@domain.hid>
In-Reply-To: <20100906080353.574@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0AFC24666061FDFE6C020C3B"
Subject: Re: [Xenomai-help] Xenomai-help Digest, Vol 60, Issue 2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: starknight__@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AFC24666061FDFE6C020C3B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Am 06.09.2010 14:03, schrieb C Robinson:
> Thanks Philippe for the detailed response, that clears up several thing=
s.   However, some things are a bit more confusing.   I've divided my rep=
ly into three section, my aim,  the current state of affairs and what I w=
ill try next. (Thanks for your patience with me).
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DSection 1 ----My goal
>=20
> Can I say that I'm looking for the most straight-forward method of gett=
ing Xenomai up and running on my Ubuntu system.   I have software that re=
quires the Xenomai OS.
>=20
>=20
>>From Philippe's comment, "If you plan to rebuild your own kernel with X=
enomai support instead of picking the one shipped with the distro" I get =
the impression that I have taken the long way?

Debian and Ubuntu don't ship a prebuilt xenomai/adeos enabled kernel. You=
 have to patch and build the kernel yourself.

> Bear in mind that my first question to the mailing list was asking if t=
he Xenomai packages available from the repository (i.e. installing xenoma=
i-runtime, linux-patch-xenomai, libxenomai1 ) were sufficient to turn a U=
buntu installation into a Xenomai OS.   I was directed to the Debian inst=
allation guide.   This indicated to me that it was necessary to build and=
 install the Debian packages, but in addition it was still necessary to c=
ompile a new kernel patched during the process (so I wonder what is the p=
urpose of the linux-patch-xenomai).
>=20
> The requirement to compile the kernel I took from the mentioned guide:
> "for "production" systems, you should just need xenomai-runtime und lib=
xenomai1 (together with the self built kernel as described in the next se=
ction)"

Thats still true, you need to install the packages mentioned and a self b=
uilt kernel.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DSection 2 ----My situation before Phil=
ippe's last email
>=20
>=20
> I found another testsuite located in the install directory of /home/<us=
er>/xenomai-2.5.4/src/testsuite, from which I was able to build the examp=
les.   However, I still got the following:
>=20
>> clocktest man
>> The program 'clocktest' is currently not installed.  You can install i=
t by typing:
>> sudo apt-get install xenomai-runtime
>=20
>  (despite synaptic showing it as installed and v2.5.4)

The testsuite is not installed in /usr/bin/ anymore using debian packages=
, try:
/usr/lib/xenomai/clocktest

/usr/lib/xenomai/ is not in the search path, you have to use absolute pat=
hs.

> The following steps were done while following the guide:
> -----------------------------------------------------------------------=
------------------------------------------------------
> fakeroot make-kpkg --initrd --append-to-version -xenomai-2.5.4 --revisi=
on 1.0 binary-arch
> dpkg -i linux-image*.deb
> update-initramfs -c -k 2.6.32.15-xenomai-2.5.4 && update-grub
> -----------------------------------------------------------------------=
------------------------------------------------------
>=20
> and with xenomai-runtime still undetected, I found another guide with s=
ome additional steps (so I believed) :
> -----------------------------------------------------------------------=
------------------------------------------------------

This is the 'standard' way to install xenomai. Install the debian package=
s like you did, or use this standard way. But don't mix both.

>  User Part
>=20
> cd /usr/xenomai
> ./configure
> make
> make install
>=20
> Test Xenomai:
>=20
> cd /usr/xenomai/bin
> ./latency -p0 -t1
> -----------------------------------------------------------------------=
------------------------------------------------------
>=20
> No success (the configure did work though),  I still received the instr=
uction to install xenomai-runtime
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DSection 3 ----Philippe's last suggesti=
on.
>=20
> Right, so the following are the packages installed according to a cache=
 search for xenomai:
>=20
> linux-image-2.6.32.15-xenomai-2.5.4 - Linux kernel binary image for ver=
sion 2.6.32.15-xenomai-2.5.4
> linux-patch-xenomai - Linux kernel patches for Xenomai
> xenomai-doc - Xenomai documentation
> linux-image-2.6.32.15-xenomai-2.5.4-dbg - Linux kernel debug image for =
version 2.6.32.15-xenomai-2.5.4
> libxenomai1 - Shared libraries for Xenomai
> libxenomai-dev - Headers and static libs for Xenomai
> xenomai-runtime - Xenomai runtime utilities

Looks good.

> Before I follow the steps provided by Philippe, I'm going to try the pa=
ckages provided in the Ubuntu repository.   I realise these are out of da=
te, but if they allow me to finally ave a Xenomai OS on which I can insta=
ll the software I will be working with, then I can perhaps have another g=
o later when I have some of my project underway.
> So I will uninstall the following packages and replace with the ubuntu =
ones after which, if not working,  I will try Philippe's steps

Please don't do this, look first at the directory /usr/lib/xenomai/ and c=
all the utils with absolute paths.


Regards Stefan

> xenomai-doc - Xenomai documentation
> libxenomai1 - Shared libraries for Xenomai
> libxenomai-dev - Headers and static libs for Xenomai
> xenomai-runtime - Xenomai runtime utilities
>=20
>=20
> Cheers,
> Charles
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20



--------------enig0AFC24666061FDFE6C020C3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFMhOoUIPTw9rIdn6oRArPNAJ9L8o/5CAEQIoC4uUX0yvoUhKOTjACfYnf6
QXsG05GfmdggAS8iLXA962w=
=LlmQ
-----END PGP SIGNATURE-----

--------------enig0AFC24666061FDFE6C020C3B--

