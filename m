From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 18 Feb 2007 13:51:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702181351.53069.niklaus.giger@domain.hid>
Subject: [Xenomai-core] buildbot: how to setup for ppc with 2.6.19 kernel?
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

Compiling ppc fails for me with 2.6.19 kernels. 
( I compile on a Pegasos PPC 601 Debian Linux).

If I use ARCH=ppc then I get the following error:
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CHK     include/linux/compile.h
> gcc: include/asm/byteorder.h: No such file or directory
> gcc: no input files
>   CC      arch/ppc/xenomai/hal.o
> arch/ppc/xenomai/hal.c: In function 'rthal_arch_init':
> arch/ppc/xenomai/hal.c:353: error: invalid type argument of '->'
> make[1]: *** [arch/ppc/xenomai/hal.o] Fehler 1

Trying to use ARCH=powerpc fails already while configuring the kernel
like this:
>  make ARCH=powerpc menuconfig
>   HOSTCC  scripts/kconfig/mconf.o
>   HOSTLD  scripts/kconfig/mconf
> scripts/kconfig/mconf arch/powerpc/Kconfig
> init/Kconfig:564:warning: 'select' used by config symbol 'XENOMAI' refer to
> undefined symbol 'IPIPE' #
> # configuration written to .config
> #
And a make gives me
>  make ARCH=powerpc menuconfig
>   HOSTCC  scripts/kconfig/mconf.o
>   HOSTLD  scripts/kconfig/mconf
> scripts/kconfig/mconf arch/powerpc/Kconfig
> init/Kconfig:564:warning: 'select' used by config symbol 'XENOMAI' refer to
> undefined symbol 'IPIPE' #
> # configuration written to .config
> #
What is wrong? Did I miss something in my setup? Wrong config?

Best regards

-- 
Niklaus Giger

