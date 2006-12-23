From: Wolfgang Denk <wd@domain.hid>
Subject: Re: [Xenomai-core] Patches: README.install 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 23 Dec 2006 23:51:32 +0100."
	<200612232351.33192.niklaus.giger@domain.hid> 
Date: Sun, 24 Dec 2006 00:47:23 +0100
Sender: wd@domain.hid
Message-Id: <20061223234723.476513535D2@domain.hid>
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Dear Niklaus,

in message <200612232351.33192.niklaus.giger@domain.hid> you wrote:
>=20
> Thanks your for spotting my errors. I should have rechecked this patch =
before=20
> submitting it, as it was based on a outdated script. Please review the=20
> attached patch again which is based on a script which actually ran and=20
> produced a running kernel.
>=20
> I would also thanks you for providing the ELDK. It was really a lot eas=
ier
> to setup the ELDK once I switched from my PPC PowerBook to a MacMini. I=
 can=20
> really recommend it.

Thanks. I'm glad you like it.

> The only addition to the ELDK I made to run xeno-test was to copy my=20
> Debian /usr/bin/which to the rootfs.

alias which=3D'type -p'

>  -----------------------------------------
> =20
>  A typical cross-compilation setup, in order to build Xenomai for a
> -PowerPC-405-based system:
> +PowerPC-405-based system. Here we use an ELDK cross-compiler and a
> +2.6.14 kernel.
> =20
> -$ $xenomai_root/scripts/prepare-kernel.sh --arch=3Dpowerpc \
> -  --adeos=3D$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14=
-ppc-X.Y-ZZ.patch \
> +$ $xenomai_root/scripts/prepare-kernel.sh --arch=3Dppc \
> +  --adeos=3D$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14=
-ppc-1.5-*.patch \
>    --linux=3D$linux_tree
>  $ cd $linux_tree
> -$ mkdir ../build-powerpc-405-2.6.14
> -$ make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-405-linux-gnu- O=3D../build-=
powerpc-405-2.6.14 xconfig/gconfig/menuconfig=20
> +$ build_root /path/to/eldk

"/path/to/eldk" might be misleading - at least  it  needs  an  expla-
nation;  I  would interpret this as "/opt/eldk", which is the default
installation directory of the ELDK, while I guess you  actually  mean
"/opt/eldk/ppc_4xx" ?

> +$ mkdir $build_root
> +$ make ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- O=3D$build_root xconfig/gco=
nfig/menuconfig
>  # select the kernel and Xenomai options
> -$ make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-405-linux-gnu- O=3D../build-=
powerpc-405-2.6.14 bzImage modules=20
> -# then install as needed
> -$ mkdir $build_root && cd $build_root
> -$ $xenomai_root/configure --build=3Di686-linux --host=3Dpowerpc-405-li=
nux-gnu
> +$ make ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- O=3D$build_root bzImage mod=
ules \
> +  modules_install

Be careful here. "modules_install" will try to run the native depmod,
which will not work. Recent builds (*) of the ELDK will allow to  add
a "DEPMOD=3D/opt/eldk/usr/bin/depmod.pl" argument to the make call.

[This extension was added in July, so you will have to wait for  ELDK
version 4.1 unless you build the ELDK from scratch from the sources.]


Thanks, and a Merry Christmas and a Happy New Year!

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
READ THIS BEFORE OPENING PACKAGE: According to Certain Suggested Ver-
sions of the Grand Unified Theory, the Primary Particles Constituting
this Product May Decay to Nothingness Within the  Next  Four  Hundred
Million Years.

