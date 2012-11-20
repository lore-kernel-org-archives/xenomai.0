MIME-Version: 1.0
Date: Tue, 20 Nov 2012 21:14:53 +0100
Message-ID: <CABXfH65sLwQOJuyde1JyGEBTe_Sn0bfow-O+NRo3rSzr4Wrvfg@mail.gmail.com>
From: John Reed <johnreed073@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Section mismatches ipipe-core-3.2.21-arm-1.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomaiers,

If I take this vanilla kernel:
http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.2.21.tar.bz2

And I run
scripts/prepare-kernel.sh --linux=$DIR/KERNEL --arch=arm
--adeos=$DIR/../xenomai-2.6.1/ksrc/arch/arm/patches/ipipe-core-3.2.21-arm-1.patch

make -j3 ARCH=arm LOCALVERSION=-x15 CROSS_COMPILE="ccache
/home/johnreed/toolchains/linaro-4.7-2012.10/bin/arm-linux-gnueabihf-"
zImage modules

For the kernel config, I am using a .config file I loaded Gilles' example
for Pandaboard into menuconfig:
http://sisyphus.hd.free.fr/~gilles/config-panda
The only change I made was I turned on the kernel switch for debugging
section mismatches. This .config file has ARCH_OMAP3 disabled. I realize
that config file is for 2.6.38.8, but I didn't find a .config file example
for pandaboard on kernel 3.x on the internet.

***Then I get section mismatches***. (Just to make sure it wasn't due to
other patches I am using, I disabled those patches this time.) In the end,
it's not building all of the modules, and I think it may be due to the
section mismatches.

I looked and there was no ipipe patch of the same version in the stable
xenomai-2.6.0, but the ipipe patch for this kernel version is the same in
the xenomai git. Does anyone have any ideas?

Cheers,
John


WARNING: arch/arm/kernel/built-in.o(.text+0x5828): Section mismatch in
reference from the function __ipipe_tsc_register() to the variable
.init.text:__kuser_helper_end
The function __ipipe_tsc_register() references
the variable __init __kuser_helper_end.
This is often because __ipipe_tsc_register lacks a __init
annotation or the annotation of __kuser_helper_end is wrong.

WARNING: arch/arm/kernel/built-in.o(.text+0x582c): Section mismatch in
reference from the function __ipipe_tsc_register() to the variable
.init.text:__ipipe_tsc_area_start
The function __ipipe_tsc_register() references
the variable __init __ipipe_tsc_area_start.
This is often because __ipipe_tsc_register lacks a __init
annotation or the annotation of __ipipe_tsc_area_start is wrong.

WARNING: vmlinux.o(.text+0xac68): Section mismatch in reference from the
function __ipipe_tsc_register() to the variable
.init.text:__kuser_helper_end
The function __ipipe_tsc_register() references
the variable __init __kuser_helper_end.
This is often because __ipipe_tsc_register lacks a __init
annotation or the annotation of __kuser_helper_end is wrong.

WARNING: vmlinux.o(.text+0xac6c): Section mismatch in reference from the
function __ipipe_tsc_register() to the variable
.init.text:__ipipe_tsc_area_start
The function __ipipe_tsc_register() references
the variable __init __ipipe_tsc_area_start.
This is often because __ipipe_tsc_register lacks a __init
annotation or the annotation of __ipipe_tsc_area_start is wrong.
