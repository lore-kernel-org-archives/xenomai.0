Date: Wed, 25 Nov 2015 21:10:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151125201045.GA19641@hermes.click-hack.org>
References: <18024a6dcdef450fb51f2e38ce31f272@ATGRZSW1691.avl01.avlcorp.lan>
 <20151125181847.GA25177@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151125181847.GA25177@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Undefined references at cross compiling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 25, 2015 at 01:18:47PM -0500, Lennart Sorensen wrote:
> On Wed, Nov 25, 2015 at 08:58:38AM +0000, Hartl, Fabian AVL/AT wrote:
> > Hello,
> > 
> > I successfully installed xenomai on a native ubuntu installation, the I tried installing xenomai on a BeagleBone Black by compiling it on the BeagleBone itself.
> > This also worked.
> > Now I am trying to cross compile the kernel on a Linux machine for the BeagleBone Black.
> > Doing so I encountered the problem of undefined references while making the kernel (see below)
> > 
> > 
> > make[1]: Entering directory '/home/mmg-linux/rtk/linux-3.18.20'
> > scripts/kconfig/conf --silentoldconfig Kconfig
> >   CHK     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > make[2]: 'include/generated/mach-types.h' is up to date.
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   LINK    vmlinux
> >   LD      vmlinux.o
> >   MODPOST vmlinux.o
> >   GEN     .version
> >   CHK     include/generated/compile.h
> >   UPD     include/generated/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> > arch/arm/kernel/built-in.o: In function `ipipe_get_sysinfo':
> > /home/mmg-linux/rtk/linux-3.18.20/arch/arm/kernel/ipipe.c:244: undefined reference to `__ipipe_mach_get_tscinfo'
> > arch/arm/xenomai/built-in.o: In function `mach_arm_calibrate':
> > /home/mmg-linux/rtk/linux-3.18.20/arch/arm/xenomai/machine.c:59: undefined reference to `__ipipe_mach_get_tsc'
> > /home/mmg-linux/rtk/linux-3.18.20/arch/arm/xenomai/machine.c:61: undefined reference to `__ipipe_mach_get_tsc'
> > /home/mmg-linux/rtk/linux-3.18.20/arch/arm/xenomai/machine.c:68: undefined reference to `__ipipe_mach_get_tsc'
> > /home/mmg-linux/rtk/linux-3.18.20/arch/arm/xenomai/machine.c:72: undefined reference to `__ipipe_mach_get_tsc'
> > kernel/built-in.o: In function `xnclock_core_read_raw':
> > /home/mmg-linux/rtk/linux-3.18.20/include/xenomai/cobalt/kernel/clock.h:118: undefined reference to `__ipipe_mach_get_tsc'
> > kernel/built-in.o:/home/mmg-linux/rtk/linux-3.18.20/include/xenomai/cobalt/kernel/clock.h:118: more undefined references to `__ipipe_mach_get_tsc' follow
> > Makefile:923: recipe for target 'vmlinux' failed
> > make[1]: *** [vmlinux] Error 1
> > make[1]: Leaving directory '/home/mmg-linux/rtk/linux-3.18.20'
> > debian/ruleset/targets/common.mk:295: recipe for target 'debian/stamp/build/kernel' failed
> > make: *** [debian/stamp/build/kernel] Error 2
> > 
> > 
> > 
> > I am compiling the kernel using this command:
> > 
> > CONCURRENCY_LEVEL=8 CLEAN_SOURCE=no CC=arm-linux-gnueabihf-gcc  fakeroot make-kpkg --arch arm --cross-compile arm-linux-gnueabihf- --initrd --append-to-version -xenomai-3.0.1 --revision 1.0 kernel_image kernel_headers
> > 
> > What is causing this error? Patching the kernel was successful under native Linux and native BeagleBone.
> 
> Did you enable ipipe and xenomai in your kernel config before building it?

The undefined references to ipipe functions and the fact that
march_arm_calibration or xnclock_core_read_raw are compiled prove
that I-pipe and Xenomai are enabled. What is probably lacking is
enabling a processor supported by the I-pipe kernel. You should be
able to use for cross-compilation the kernel configurations you used
for native compilation.

-- 
					    Gilles.
https://click-hack.org

