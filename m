Message-ID: <beda0b9b8a6d35e8179dde7ccb89eab4.squirrel@www.xenomai.org>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664F7578B@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C4664F7578B@MAIL-SINTERS-01.sinters-int.fr>
Date: Tue, 18 Jun 2013 17:39:10 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] No Rootfs after installing Xenomai !
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Younes CHALABI wrote:
> Hi,
>
> I want to install xenomai on the i.MX6Q Sabre Lite board, for this I
> followed differents strategies but still not able to have xenomai on the
> target.
>
>
>      1- linux-3.5.7 vs xenomai-2.6.2.1 vs ipipe-core-3.5.7-arm-3.patch :
>           Using the installation procedure for ARM from :
> www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
>                The problem with this strategy is that I hadn't a rootfs to
> boot the target, so I took a different strategy.
>                     HOW CAN I HAVE A ROOTFS TO BOOT THE TARGET WITH THE
> COMPILED SOURCES ?

A

>
>
>      2- Using the L3.0.35_4.0.0_130424 Freescale Release I built LTIB and
> by the way a rootfs, an uImage and a u-boot.bin which work correctly
> on the target.
>           Once having the rootfs I wanted to build the kernel patching it
> with xenomai and using the previous rootfs (LTIB)
>                PATCHING FAILED
>
>
>      3- I tried to patch the linux-3.0.35 with :
> adeos-ipipe-3.0.36-arm-1.18-11-pre.patch |
> adeos-ipipe-3.0.36-arm-1.18-11.patch |
> adeos-ipipe-3.0.36-arm-1.18-11-post.patch
>           But I had so many rejects, that why I prefered to use the
> rel_imx_3.0.15_12.03.00 and it's advised in :
> xenomai-2.6.2.1/ksrc/arch/arm/patches/README
>                Doing the same procedure as for linux-3.5.7, I had an
> uImage that I loaded on the =B5-SD with the rootfs and u-boot
> either with the generated files from LTIB or the
> L3.0.35_4.0.0_130424_images_MX6
>                     THE KERNEL LAUNCH BUT DOESN'T START :
>                           mmc1 is current device
>
>                           MMC read: dev # 1, block # 2048, count 8192 ...
> 8192 blocks read: OK
>                           ## Booting kernel from Legacy Image at 10800000
> ...
>                              Image Name:   Linux-$ (3.0.15_12.03.00)
>                              Image Type:   ARM Linux Kernel Image
> (uncompressed)
>                              Data Size:    3813344 Bytes =3D  3.6 MB
>                              Load Address: 10800000
>                              Entry Point:  10800000
>                              Verifying Checksum ... OK
>                              XIP Kernel Image ... OK
>                            OK
>
>                            Starting kernel ...
>                            "Stops here"
>
>
> How can I have a rootfs that woks with a kernel patched with xenomai ? To
> boot the target ?
>
>
> Waiting for your answers.
>
>
> Best regards,
>
>
> Younes
>
>
> ________________________________________
> De : Thierry Bultel [thierry.bultel@wanadoo.fr]
> Date d'envoi : lundi 17 juin 2013 16:58
> =C0 : Younes CHALABI
> Objet : Re: TR : Xenomai-2.6.2.1 with a kernel-3.0.15 Freescale Release on
> i.MX6Q Sabre Lite Booting problem
>
> Hi Younes,
>
>
> The kernel I wanted to patch was too much different from the
> rel_imx_3.0.15_12.03.00.
> Mine was rather close to the
> rel_imx_3.0.35_12.09.01<http://git.freescale.com/git/cgit.cgi/imx/linux-2=
.6-imx.git/tag/?id=3Drel_imx_3.0.35_12.09.01>
>
> Thus I took a different stategy, I have taken the ipipe-3.0-imx6q branch
> of ipipe-gch.git, which is an already patched kernel, and merged the BSP
> of my provider into it.
>
> You do not mention if the non patched rel_imx_3.0.15_12.03.00 works fine,
>
>
> dit you try it ?
>
> Thierry
>
> Le 17/06/2013 16:44, Younes CHALABI a =E9crit :
>
> Hi Thierry,
>
> After googling I've seen that tou have already deployed xenomai on the
> i.MX6q, and I'm doing the same with the imx6q sabre lite but have some
> troubles.
>
> I'm trying to install xenomai-2.6.2.1 on the i.MX6Q Sabre Lite.
>
> Using U-boot-mx6q-sabrelite.bin and the rootfs.ext2 from the
> L3.0.35_4.0.0_130424_images_MX6 directory.
>
> The kernel used is rel_imx_3.0.15_12.03.00, and after patching it with
> xenomai-2.6.2.1 following these steps :
>
>  1- Applying
> xenomai-2.6.2.1/ksrc/arch/arm/patches/mxc/adeos-ipipe-3.0.36-arm-1.18-11-=
pre.patch
> (no rejects)
>  2- Applying
> xenomai-2.6.2.1/ksrc/arch/arm/patches/adeos-ipipe-3.0.36-arm-1.18-11.patch
> (no rejects)
>  3- Applying
> xenomai-2.6.2.1/ksrc/arch/arm/patches/mxc/adeos-ipipe-3.0.36-arm-1.18-11-=
post.patch
> (no rejects)
>  4- xenomai-2.6.2.1/scripts/prepare-kernel.sh --arch=3Darm
> --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-3.0.36-arm-1.18=
-11.patch
> --linux=3Drel_imx_3.0.15_12.03.00 (OK)
>  5- make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-
> O=3D$build_root/linux imx6_defconfig (OK)
>  6- make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi-
> O=3D$build_root/linux bzImage modules (OK)
>  7- xenomai-2.6.2.1/configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3"
> FDFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" --build=3Di686-pc-linux-gnu
> --host=3Darm-none-linux-gnueabi (OK)
>  8- make DESTDIR=3D$staging_dir install (OK)
>
> Then putting the build_root/linux/arch/arm/boot/uImage | System.map |
> modules.builtin |   modules.order |  Module.symvers      =3D=3D> to
> /media/boot (OK)
>
> But when booting the target the kernel doesn't start and have this display
> :
>
>  mmc1 is current device
>
>  MMC read: dev # 1, block # 2048, count 8192 ... 8192 blocks read: OK
>  ## Booting kernel from Legacy Image at 10800000 ...
>    Image Name:   Linux-$ (3.0.15_12.03.00)
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3813344 Bytes =3D  3.6 MB
>    Load Address: 10800000
>    Entry Point:  10800000
>    Verifying Checksum ... OK
>    XIP Kernel Image ... OK
>  OK
>
>  Starting kernel ...
>
>  "Stops here"
>
> If you have an idea why the kernel doesn't start or if you can explain me
> how you did, it will be very helpful for me.
>
> Thanks in advance and waiting for your answer.
>
> Younes CHALABI
>


--=20
                    Gilles.


