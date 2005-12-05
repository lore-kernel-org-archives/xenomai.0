Message-ID: <25192.193.52.24.125.1133817387.squirrel@domain.hid>
Date: Mon, 5 Dec 2005 22:16:27 +0100 (CET)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Xenomai-PPC: Two problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi everybody.

I'm working with an Apple Powerbook 15" G4, Xenomai 2.1 (SVN), Linux kernel
2.6.14.3. I'm using Umbutu 5.10 with gcc 3.4.5

simone@domain.hid:~$ gcc -v
Reading specs from /usr/lib/gcc/powerpc-linux-gnu/3.4.5/specs
Configured with: ../src/configure -v
--enable-languages=c,c++,f77,pascal,objc,ada --prefix=/usr
--libexecdir=/usr/lib --with-gxx-include-dir=/usr/include/c++/3.4
--enable-shared --with-system-zlib --enable-nls --without-included-gettext
--program-suffix=-3.4 --enable-__cxa_atexit --enable-libstdcxx-allocator=mt
--enable-clocale=gnu --enable-libstdcxx-debug --disable-softfloat
--enable-targets=powerpc-linux,powerpc64-linux --with-cpu=default32
--disable-softfloat powerpc-linux-gnu
Thread model: posix
gcc version 3.4.5 20050809 (prerelease) (Ubuntu 3.4.4-6ubuntu8)

I have two residual problems:

1) The machine is unstable (freeze after a while) if Xenomai FPU support in
the kernel is active. This is a know problem. Gilles help me to find the
catch and complete the installation. The problems is related to the Altivec
unit present in the G4. I tried to fix the problems eliminating the  Altivec
support (in the kernel coinfiguration) without success.

2) If I activate the interrupt shield in the kernel, the kernel compilation
stops this this message:

root@domain.hid# make
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      kernel/xenomai/nucleus/pod.o
  CC      kernel/xenomai/nucleus/shadow.o
kernel/xenomai/nucleus/shadow.c: In function `engage_irq_shield':
kernel/xenomai/nucleus/shadow.c:164: warning: implicit declaration of
function `__raw_read_lock'
kernel/xenomai/nucleus/shadow.c:170: warning: implicit declaration of
function `__raw_read_unlock'
kernel/xenomai/nucleus/shadow.c: In function `disengage_irq_shield':
kernel/xenomai/nucleus/shadow.c:188: warning: implicit declaration of
function `__raw_write_lock'
kernel/xenomai/nucleus/shadow.c:198: warning: implicit declaration of
function `__raw_write_unlock'
  LD      kernel/xenomai/nucleus/xeno_nucleus.o
  LD      kernel/xenomai/nucleus/built-in.o
  CC      kernel/xenomai/skins/native/task.o
  LD      kernel/xenomai/skins/native/xeno_native.o
  LD      kernel/xenomai/skins/native/built-in.o
  LD      kernel/xenomai/skins/built-in.o
  LD      kernel/xenomai/built-in.o
  LD      kernel/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `disengage_irq_shield':
shadow.c:(.text+0x42708): undefined reference to `__raw_write_lock'
shadow.c:(.text+0x42840): undefined reference to `__raw_write_unlock'
shadow.c:(.text+0x42868): undefined reference to `__raw_write_unlock'
kernel/built-in.o: In function `xnshadow_reset_shield':
: undefined reference to `__raw_read_lock'
kernel/built-in.o: In function `xnshadow_reset_shield':
: undefined reference to `__raw_read_unlock'
kernel/built-in.o: In function `lostage_handler':
shadow.c:(.text+0x42c64): undefined reference to `__raw_read_lock'
shadow.c:(.text+0x42d54): undefined reference to `__raw_read_unlock'
kernel/built-in.o: In function `xnshadow_relax':
: undefined reference to `__raw_read_lock'
kernel/built-in.o: In function `xnshadow_relax':
: undefined reference to `__raw_read_unlock'
kernel/built-in.o: In function `schedule_event':
shadow.c:(.text+0x44a00): undefined reference to `__raw_read_lock'
shadow.c:(.text+0x44af8): undefined reference to `__raw_read_unlock'
make: *** [.tmp_vmlinux1] Error 1
root@domain.hid#



TIA

       Simone Mannori - INRIA Rocquencourt (Paris)
       www.scilab.org - www.scicos.org







