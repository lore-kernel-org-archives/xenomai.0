Message-ID: <50ABE79B.8080502@xenomai.org>
Date: Tue, 20 Nov 2012 21:27:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABXfH65sLwQOJuyde1JyGEBTe_Sn0bfow-O+NRo3rSzr4Wrvfg@mail.gmail.com>
In-Reply-To: <CABXfH65sLwQOJuyde1JyGEBTe_Sn0bfow-O+NRo3rSzr4Wrvfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Section mismatches ipipe-core-3.2.21-arm-1.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Reed <johnreed073@gmail.com>
Cc: xenomai@xenomai.org

On 11/20/2012 09:14 PM, John Reed wrote:

> Dear Xenomaiers,
> 
> If I take this vanilla kernel:
> http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.2.21.tar.bz2
> 
> And I run
> scripts/prepare-kernel.sh --linux=$DIR/KERNEL --arch=arm
> --adeos=$DIR/../xenomai-2.6.1/ksrc/arch/arm/patches/ipipe-core-3.2.21-arm-1.patch
> 
> make -j3 ARCH=arm LOCALVERSION=-x15 CROSS_COMPILE="ccache
> /home/johnreed/toolchains/linaro-4.7-2012.10/bin/arm-linux-gnueabihf-"
> zImage modules
> 
> For the kernel config, I am using a .config file I loaded Gilles' example
> for Pandaboard into menuconfig:
> http://sisyphus.hd.free.fr/~gilles/config-panda


This config file is completely outdated, in particular it does not have
CONFIG_SMP, which you want, as I understand, so, it is removed now.
Anyway, to configure a kernel for pandaboard, simply start from
omap2plus_defconfig, and in the system type menu, only keep omap4
enabled (not omap2 and omap3).

> The only change I made was I turned on the kernel switch for debugging
> section mismatches. This .config file has ARCH_OMAP3 disabled. I realize
> that config file is for 2.6.38.8, but I didn't find a .config file example
> for pandaboard on kernel 3.x on the internet.
> 
> ***Then I get section mismatches***. (Just to make sure it wasn't due to
> other patches I am using, I disabled those patches this time.) In the end,
> it's not building all of the modules, and I think it may be due to the
> section mismatches.
> 
> I looked and there was no ipipe patch of the same version in the stable
> xenomai-2.6.0, but the ipipe patch for this kernel version is the same in
> the xenomai git. Does anyone have any ideas?


I have to admit I never run with sections debugging enabled, and the
warning show it. Anyway, someone simply has to do what the warnings tell
you to do.


-- 
                                                                Gilles.

