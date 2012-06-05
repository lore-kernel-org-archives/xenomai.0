Message-ID: <4FCE4D08.9030006@xenomai.org>
Date: Tue, 05 Jun 2012 20:16:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>	<4FCDFB35.1050705@xenomai.org>
	<CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
In-Reply-To: <CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 06/05/2012 05:34 PM, Marcin Ku=C5=9Bka wrote:
> 1. crosstool-ng-1.15.2
> 2. linux-3.0.13:
> *# make ARCH=3Darm vexpress_defconfig
>    [*] use the ARM EABI to compile the kernel
> # make ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnueabi- modules
> # make ARCH=3Darm INSTALL_MOD_PATH=3D/home/marcin/Documents/arm/target
> modules_install*
> 3. busybox-1.20.0
> 4. ramdisk:
> *# cd /home/marcin/Documents/arm/target
> # find . | sudo cpio -o -H newc > /home/marcin/Documents/arm/rootfs.cpi=
o*
> 5. Kernel:
> *# cd linux-3.0.15
> **# ../xenomai/scripts/prepare-kernel.sh --linux=3Dlinux-3.0.13
> --adeos=3Dadeos-ipipe-3.0.13-arm-1.18-09.patch --arch=3Darm
> # make ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnueabi- zImage*
>=20
> and the result is
>=20
> *  CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      kernel/xenomai/arch/generic/hal.o
> In file included from kernel/xenomai/arch/generic/hal.c:45:
> /home/marcin/Documents/linux-3.0.13/arch/arm/include/asm/xenomai/hal.h:=
91:2:
> error: #error "Unsupported ARM machine"
> make[4]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> make[3]: *** [kernel/xenomai/arch/generic] Error 2
> make[2]: *** [kernel/xenomai/arch] Error 2
> make[1]: *** [kernel/xenomai] Error 2
> make: *** [kernel] Error 2
>=20
> *"Unsupported ARM machine" - any suggestions to this?*

It means you have to follow the I-pipe porting guide to add what is
missing to support your board/SOC combination.

--=20
                                                                Gilles.


