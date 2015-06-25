MIME-Version: 1.0
Date: Thu, 25 Jun 2015 13:52:29 +1000
Message-ID: <CA+R+utphWuYg5Xu5u-j9my43wTEkqZfw34mwGUa2_2f_k6TD5w@mail.gmail.com>
From: Antoine Demirdjian <antoine.demirdjian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Kernel compilation issue for RaspberryPi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I'm trying since a while to have a Raspbian/Xenomai on my RaspberryPi,
without success.
I'm using Xenomai-2.6.4 and linux-3.8.y .

Here are the steps I've done in my xenorasp folder (where xenomai-2.6.4 is
already decompressed) :

[xenorasp] $ *git clone git://github.com/raspberrypi/linux.git
<http://github.com/raspberrypi/linux.git> *
[xenorasp] $ *cd linux*
[linux] $ *git checkout d996a1b*
[linux] $ *patch -p1 <
../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberry-pre-2.patch*
                   patching file kernel/trace/ftrace.c
[linux] $ *cd ..*
[xenorasp] $ *xenomai-2.6.4/scripts/prepare-kernel.sh --arch=arm
--linux=linux/
--adeos=xenomai-2.6.4/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-4.patch*
                    checking file arch/arm/Kconfig
                    Hunk #4 succeeded at 977 (offset 17 lines).
                    Hunk #5 succeeded at 1189 (offset 18 lines).
                    Hunk #6 succeeded at 1678 (offset 18 lines).
                    checking file arch/arm/boot/compressed/decompress.c
                    checking file arch/arm/boot/compressed/head.S
                    checking file arch/arm/boot/compressed/string.c
                    checking file arch/arm/common/gic.c
                    checking file arch/arm/common/it8152.c
                    ...
                    ...
                    checking file mm/mprotect.c
                    checking file mm/vmalloc.c

/* 1st question, is it normal that it is "checking" and not "patching" ? */

[xenorasp] $ *cd linux*
[linux] $ *patch -p1 <
../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberry-post-2.patch*
patching file arch/arm/Kconfig
patching file arch/arm/mach-bcm2708/bcm2708.c
patching file arch/arm/mach-bcm2708/bcm2708_gpio.c
patching file drivers/spi/spi-bcm2708.c
patching file kernel/trace/ftrace.c
[linux] $* make ARCH=arm defconfig*
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'versatile_defconfig'
#
# configuration written to .config
#


/* Then I ran menuconfig and I just set "embedded" to " * " */

[linux] $ *make ARCH=arm CROSS_COMPILE=/myPath/myCrossCompiler*
......
......
......
  CC      lib/radix-tree.o
  CC      lib/ratelimit.o
  CC      lib/rbtree.o
  CC      lib/reciprocal_div.o
  CC      lib/rwsem-spinlock.o
  CC      lib/sha1.o
  CC      lib/show_mem.o
  CC      lib/string.o
  CC      lib/timerqueue.o
  CC      lib/vsprintf.o
  AR      lib/lib.a
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
arch/arm/kernel/built-in.o:(___ksymtab+v6wbi_flush_kern_tlb_range+0x0):
undefined reference to `v6wbi_flush_kern_tlb_range'
make: *** [vmlinux] Error 1

And the compilation stopped here...

Where am I wrong?
I don't know at all how configure the kernel, maybe my mistake is when
using "make debconfig" .

Thanks a lot for your help,

Antoine
