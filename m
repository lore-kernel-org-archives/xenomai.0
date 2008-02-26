Date: Tue, 26 Feb 2008 17:51:08 +0100
Message-Id: <609829951@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Compiling Problems for Virtex II pro Board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi
I patched the Kernel sources like this:
-----------------------------------------------
meyer@domain.hid> ./prepare-kernel.sh
Linux tree [default /lib/modules/2.6.13-15.18-bigsmp/source]: /home/meyer/=
xenomai/linux-2.6-xlnx.git
Target architecture [default i686]: ppc
Adeos patch [default /home/meyer/xenomai/xenomai-2.4.2/ksrc/arch/powerpc/p=
atches/adeos-ipipe-2.6.23-ppc-DENX-1.6-03.patch]: /home/meyer/xenomai/adeo=
s
-ipipe-2.6.23-ppc-xlnx-1.6-03.patch
patching file Makefile
patching file arch/powerpc/kernel/cputable.c
patching file arch/powerpc/kernel/idle.c
patching file arch/powerpc/kernel/io.c
patching file arch/powerpc/kernel/irq.c
patching file arch/powerpc/kernel/process.c
patching file arch/ppc/Kconfig
patching file arch/ppc/boot/Makefile
patching file arch/ppc/kernel/Makefile
patching file arch/ppc/kernel/entry.S
patching file arch/ppc/kernel/head.S
patching file arch/ppc/kernel/head=5F44x.S
patching file arch/ppc/kernel/head=5F4xx.S
patching file arch/ppc/kernel/head=5F8xx.S
patching file arch/ppc/kernel/head=5Fbooke.h
patching file arch/ppc/kernel/head=5Ffsl=5Fbooke.S
patching file arch/ppc/kernel/ipipe.c
patching file arch/ppc/kernel/mcount=5F32.S
patching file arch/ppc/kernel/setup.c
patching file arch/ppc/kernel/time.c
patching file arch/ppc/kernel/traps.c
patching file arch/ppc/mm/fault.c
patching file arch/ppc/syslib/cpm2=5Fpic.c
patching file arch/ppc/syslib/ipic.c
patching file arch/ppc/syslib/open=5Fpic.c
patching file arch/ppc/syslib/ppc4xx=5Fpic.c
patching file arch/ppc/syslib/xilinx=5Fpic.c
patching file drivers/pci/htirq.c
patching file include/asm-powerpc/hw=5Firq.h
patching file include/asm-powerpc/time.h
patching file include/asm-ppc/ipipe.h
patching file include/asm-ppc/ipipe=5Fbase.h
patching file include/asm-ppc/mmu=5Fcontext.h
patching file include/linux/clockchips.h
patching file include/linux/hardirq.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe=5Fbase.h
patching file include/linux/ipipe=5Fcompat.h
patching file include/linux/ipipe=5Fpercpu.h
patching file include/linux/ipipe=5Ftickdev.h
patching file include/linux/ipipe=5Ftrace.h
patching file include/linux/irq.h
patching file include/linux/kernel.h
patching file include/linux/linkage.h
patching file include/linux/mm.h
patching file include/linux/preempt.h
patching file include/linux/sched.h
patching file include/linux/spinlock.h
patching file include/linux/spinlock=5Ftypes.h
patching file init/Kconfig
patching file init/main.c
patching file kernel/Makefile
patching file kernel/exit.c
patching file kernel/fork.c
patching file kernel/ipipe/Kconfig
patching file kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/tracer.c
patching file kernel/irq/chip.c
patching file kernel/irq/handle.c
patching file kernel/power/swsusp.c
patching file kernel/printk.c
patching file kernel/sched.c
patching file kernel/signal.c
patching file kernel/spinlock.c
patching file kernel/time/clockevents.c
patching file lib/Kconfig.debug
patching file lib/bust=5Fspinlocks.c
patching file lib/ioremap.c
patching file lib/smp=5Fprocessor=5Fid.c
patching file lib/spinlock=5Fdebug.c
patching file mm/memory.c
patching file mm/mlock.c
patching file mm/vmalloc.c
meyer@domain.hid>
---------------------------------------------------------

then I made the configs, copied the BSB file and tried to compile, ended u=
p in this:
--------------------------------------------------------------------------=
------------
meyer@domain.hid> make ARCH=3Dppc CROSS=5FCOMPILE=3Dpow=
erpc-405-linux-gnu- zImage
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/ppc/Kconfig
kernel/power/Kconfig:79:warning: 'select' used by config symbol 'PM=5FSLEEP=5F=
SMP' refers to undefined symbol 'HOTPLUG=5FCPU'
#
# configuration written to .config
#
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-ppc
  CC      arch/ppc/kernel/asm-offsets.s
  GEN     include/asm-ppc/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.c
  SHIPPED scripts/genksyms/parse.h
  SHIPPED scripts/genksyms/keywords.c
  HOSTCC  scripts/genksyms/lex.o
  SHIPPED scripts/genksyms/parse.c
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk=5Felfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do=5Fmounts.o
  CC      init/do=5Fmounts=5Frd.o
  CC      init/do=5Fmounts=5Finitrd.o
  LD      init/mounts.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  HOSTCC  usr/bin2asm
  HOSTCC  usr/gen=5Finit=5Fcpio
  GEN     usr/initramfs=5Fdata.cpio.gz
  AS      usr/initramfs=5Fdata.o
  LD      usr/built-in.o
  AS      arch/ppc/kernel/entry.o
  CC      arch/ppc/kernel/traps.o
  CC      arch/ppc/kernel/time.o
  AS      arch/ppc/kernel/misc.o
  CC      arch/ppc/kernel/setup.o
  CC      arch/ppc/kernel/ppc=5Fhtab.o
  CC      arch/ppc/kernel/ppc=5Fksyms.o
  CC      arch/ppc/kernel/ipipe.o
  LD      arch/ppc/kernel/built-in.o
  AS      arch/ppc/kernel/head=5F4xx.o
  LDS     arch/ppc/kernel/vmlinux.lds
  CC      arch/powerpc/kernel/semaphore.o
  CC      arch/powerpc/kernel/cputable.o
  CC      arch/powerpc/kernel/ptrace.o
  CC      arch/powerpc/kernel/syscalls.o
  CC      arch/powerpc/kernel/irq.o
  CC      arch/powerpc/kernel/align.o
  CC      arch/powerpc/kernel/signal=5F32.o
  CC      arch/powerpc/kernel/pmc.o
  CC      arch/powerpc/kernel/vdso.o
  CC      arch/powerpc/kernel/init=5Ftask.o
  CC      arch/powerpc/kernel/process.o
  AS      arch/powerpc/kernel/systbl.o
  CC      arch/powerpc/kernel/idle.o
  CC      arch/powerpc/kernel/signal.o
  LDS     arch/powerpc/kernel/vdso32/vdso32.lds
  VDSO32A arch/powerpc/kernel/vdso32/sigtramp.o
  VDSO32A arch/powerpc/kernel/vdso32/gettimeofday.o
  VDSO32A arch/powerpc/kernel/vdso32/datapage.o
  VDSO32A arch/powerpc/kernel/vdso32/cacheflush.o
  VDSO32A arch/powerpc/kernel/vdso32/note.o
  VDSO32L arch/powerpc/kernel/vdso32/vdso32.so
  AS      arch/powerpc/kernel/vdso32/vdso32=5Fwrapper.o
  LD      arch/powerpc/kernel/vdso32/built-in.o
  CC      arch/powerpc/kernel/module=5F32.o
  LD      arch/powerpc/kernel/built-in.o
  LD      arch/ppc/platforms/built-in.o
  CC      arch/ppc/mm/fault.o
  CC      arch/ppc/mm/init.o
  CC      arch/ppc/mm/mem=5Fpieces.o
  CC      arch/ppc/mm/mmu=5Fcontext.o
  CC      arch/ppc/mm/pgtable.o
  CC      arch/ppc/mm/4xx=5Fmmu.o
  LD      arch/ppc/mm/built-in.o
  AS      arch/ppc/lib/checksum.o
  AS      arch/ppc/lib/string.o
  AS      arch/ppc/lib/div64.o
  LD      arch/ppc/lib/built-in.o
  CC      arch/ppc/syslib/xilinx=5Fpic.o
arch/ppc/syslib/xilinx=5Fpic.c: In function `xilinx=5Fintc=5Fdisable=5Fand=5Fack':
arch/ppc/syslib/xilinx=5Fpic.c:62: error: implicit declaration of function `=
local=5Firq=5Fsave=5Fhw=5Fcond'
arch/ppc/syslib/xilinx=5Fpic.c:66: error: implicit declaration of function `=
local=5Firq=5Frestore=5Fhw=5Fcond'
arch/ppc/syslib/xilinx=5Fpic.c: In function `xilinx=5Fintc=5Fend':
arch/ppc/syslib/xilinx=5Fpic.c:76: error: `ipipe=5Froot=5Fdomain=5Fp' undeclared (=
first use in this function)
arch/ppc/syslib/xilinx=5Fpic.c:76: error: (Each undeclared identifier is rep=
orted only once
arch/ppc/syslib/xilinx=5Fpic.c:76: error: for each function it appears in.)
arch/ppc/syslib/xilinx=5Fpic.c: In function `ppc4xx=5Fpic=5Finit':
arch/ppc/syslib/xilinx=5Fpic.c:168: error: `=5F=5Fipipe=5Fack=5Flevel=5Firq' undeclare=
d (first use in this function)
arch/ppc/syslib/xilinx=5Fpic.c:169: error: `=5F=5Fipipe=5Fend=5Flevel=5Firq' undeclare=
d (first use in this function)
make[1]: *** [arch/ppc/syslib/xilinx=5Fpic.o] Error 1
make: *** [arch/ppc/syslib] Error 2
meyer@domain.hid>
-----------------------------------------------------
Any idea=3F=20

Greez Joachim
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220


