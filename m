Message-ID: <4432B80D.2000102@domain.hid>
Date: Tue, 04 Apr 2006 20:16:45 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on PPC
References: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D87@domain.hid>
In-Reply-To: <CC692F5386B0AA47A62B7484A7CA2B6D027A2D87@domain.hid>
Content-Type: multipart/mixed; boundary="------------090703070003000806040009"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Behre, Frederik - LT" <Behre.Frederik@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090703070003000806040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Behre, Frederik - LT wrote:
> Hello
> 
> I have following Problem when I Build my uImage from my kernel.
> 
> But first my configuration
> 
> Host system:
> ix86
> Suse Linux 10.0 32bit
> 
> Cross Compiler
> Denx eldk ver. 3.11
> (_www.denx.de_ <file://www.denx.de>)
> 
> Target System
> PPC (MPC8270) on Microsys PM827 Board.
> linuxppc_2_4_devel-2005-10-25-1440
> xenomai-2.1
> adeos-ipipe-2.4.25-ppc-denx-1.0-03.patch
> 
> I did following Steps
> 
> installing the eldk
> export Path to the Cross compiler to system Path
> extrakt linux and xenomai
> copy adeos
> 
> THEN
>  >./xenomai-2.1.0/scripts/prepare-kernel.sh --arch=powerpc \
>         --adeos=adeos-ipipe-2.4.25-ppc-denx-1.0-03patch  \
>         --linux=linuxppc_2_4_devel-2005-10-25-1440/
> patching file arch/ppc/config.in
> patching file arch/ppc/kernel/Makefile
> patching file arch/ppc/kernel/entry.S
> patching file arch/ppc/kernel/head.S
> patching file arch/ppc/kernel/head_440.S
> patching file arch/ppc/kernel/head_44x.S
> patching file arch/ppc/kernel/head_4xx.S
> patching file arch/ppc/kernel/head_8xx.S
> patching file arch/ppc/kernel/head_e500.S
> patching file arch/ppc/kernel/idle.c
> patching file arch/ppc/kernel/ipipe-core.c
> patching file arch/ppc/kernel/ipipe-root.c
> patching file arch/ppc/kernel/irq.c
> patching file arch/ppc/kernel/ppc_ksyms.c
> patching file arch/ppc/kernel/traps.c
> patching file arch/ppc/mm/fault.c
> patching file include/asm-ppc/hw_irq.h
> patching file include/asm-ppc/ipipe.h
> patching file include/asm-ppc/mmu_context.h
> patching file include/asm-ppc/system.h
> patching file include/linux/ipipe.h
> patching file include/linux/sched.h
> patching file init/main.c
> patching file kernel/Makefile
> patching file kernel/exit.c
> patching file kernel/fork.c
> patching file kernel/ipipe/Makefile
> patching file kernel/ipipe/core.c
> patching file kernel/ipipe/generic.c
> patching file kernel/printk.c
> patching file kernel/sched.c
> patching file kernel/signal.c
> 
> # I think I is ok ???
> 
>  >cd linuxppc_2_4_devel-2005-10-25-1440
>  >make ARCH=ppc CROSS_COMPILE=ppc_82xx- PM825config
> /bin/sh: ppc-82xx-gcc: command not found
> make: *** No rule to make target `PM825config'.  Stop.

The above output is bogus. First it uses the wrong cross compiler and 
second the configuration file is incorrect (underscore is missing). Try:

   export CROSS_COMPILE=ppc_82xx-
   make PM825_config
   make menuconfig

Maybe you compiled with an invalid kerrnel configuration. I have 
attached a README on how to install Xenomai for Linux 2.4 on a MPC 5200.

> # default settings for my board
> 
>  >make ARCH=ppc CROSS_COMPILE=ppc_82xx- menuconfig
> #
> # Turn off PCI because my targetboard does not support PCI
> # activate Xenomai and Nucleus
> # nothing more, the rest I leave in default settings
> #
> # Exit and Save
> #
>  >make ARCH=ppc CROSS_COMPILE=ppc_82xx- uImage
> 
> make[5]: Entering directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch/generic' 
> 
> ppc_82xx-gcc -D__KERNEL__ 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -fomit-frame-pointer 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/arch/ppc 
> -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized 
> -mmultiple -mstring  
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenomai 
> -I/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/xenomai/compat 
> -nostdinc -I /root/eldk/311/usr/lib/gcc-lib/ppc-linux/3.3.3/include 
> -DKBUILD_BASENAME=hal  -c -o hal.o hal.c
> 
> In file included from 
> /root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xenomai/hal.h:32, 
> 
>                  from hal.c:43:
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h:60:2: 
> #error "Adeos kernel support is required to run this software."
> 
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h:61:2: 
> #error "See _http://download.gna.org/adeos/patches/_"
> 
> In file included from 
> /root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm/xenomai/hal.h:32, 
> 
>                  from hal.c:43:
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h: 
> In function `rthal_get_cpufreq':
> 
> /eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/include/asm-generic/xenomai/hal.h:171: 
> error: storage size of `sysinfo' isn't known
> 
> ...
> ...
> ...ect...
> ...
> ...
> make[5]: *** [hal.o] Error 1
> make[5]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch/generic' 
> 
> make[4]: *** [first_rule] Error 2
> make[4]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch/generic' 
> 
> make[3]: *** [_subdir_generic] Error 2
> make[3]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai/arch' 
> 
> make[2]: *** [_subdir_arch] Error 2
> make[2]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel/xenomai'
> make[1]: *** [_subdir_xenomai] Error 2
> make[1]: Leaving directory 
> `/root/eldk/311/usr/src/linuxppc_2_4_devel-2005-10-25-1440/kernel'
> make: *** [_dir_kernel] Error 2
> 
> #
> # and here is my problem
> # what did I make wrong ??
> 
> 
> Thanks a lot for Helping me.
> 
> Greetz Freddy
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--------------090703070003000806040009
Content-Type: text/x-log;
 name="xenomai-linux-2.4-install.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-linux-2.4-install.log"

*** Get linuxppc_2_4_devel ***

$ cd ~/rt/test
$ cvs -d :pserver:anonymous@domain.hid login
Logging in to :pserver:anonymous@domain.hid
CVS password:
$ cvs -z6 -d :pserver:anonymous@domain.hid co -P linuxppc_2_4_devel
cvs checkout: Updating linuxppc_2_4_devel
...
$ mv linuxppc_2_4_devel linuxppc_2_4_devel-xenomai


*** Get Xenomai ***

$ svn co http://svn.gna.org/svn/xenomai/trunk xenomai


*** Prepare Kernel ***

$ cd xenomai
$ less README.INSTALL
...
$ scripts/prepare-kernel.sh --linux=~/rt/test/linuxppc_2_4_devel-xenomai \
  --arch=ppc
Preparing kernel 2.4.25 in /home/wolf/rt/test/linuxppc_2_4_devel-xenomai...
Adeos patch [default /home/wolf/rt/test/xenomai/ksrc/arch/powerpc/patches/adeos-ipipe-2.4.25-ppc-denx-0.9-03.patch]: <type return>
patching file arch/ppc/config.in
...
Adeos/ppc 0.9-03 (newgen) installed.
 
Links installed.
Build system ready.


*** Configure Kernel including Xenomai kernel parts ***

$ cd ~/rt/test/linuxppc_2_4_devel-xenomai
$ export CROSS_COMPILE=ppc_82xx-
$ make icecube_5200_config
$ make menuconfig
  General setup  --->  
     [*] Interrupt pipeline (NEW)
     [ ] Collect statistics (NEW)
  Real-time sub-system  --->
     [*] Xenomai (NEW)
     [*] Nucleus (NEW)
     Nucleus options  --->
     Interfaces  --->
     Real-time drivers  ---> 
     Machine  --->
  (please set the other options as listed in icecube_5200_xenomai_defconfig
   or use icecube_5200_xenomai_defconfig directly).
...
$ make dep
$ make uImage
$ cp -p arch/ppc/boot/images/uImage /tftpboot/icecube5200ddr/uImage-xeno


*** Make Xenomai user-space part ***

$ cd ~/rt/test/xenomai
$ export CROSS_COMPILE=ppc_82xx-
$ ./configure --prefix=/home/wolf/xenomai --host=ppc-linux
$ make


*** Install Xenomai into /opt/eldk/ppc_82xx ***

$ export DESTDIR=/opt/eldk/ppc_82xx
$ make install


*** Boot Xenomai kernel and run latency test ***

lite5200 login: root
Last login: Tue Nov 29 15:03:01 on console
bash-2.05b# cd /home/wolf/xenomai/testsuite/latency
bash-2.05b# ./latency -t0
== Sampling period: 100 us
== Test mode: periodic user-mode task
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       10345|       14556|       45353|       0|       10345|       45353
RTD|       10706|       14556|       45955|       0|       10345|       45955
^C

bash-2.05b# ./latency -t1
== Sampling period: 100 us
== Test mode: in-kernel periodic task
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|        6376|        6709|        7882|       0|        6376|        7882
RTD|        6020|        6787|       37486|       0|        6020|       37486
^C

bash-2.05b# ./latency -t2
== Sampling period: 100 us
== Test mode: in-kernel timer handler
warming up...
RTT|  00:00:01  (in-kernel timer handler, 100 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       -2045|       -1830|       11102|       0|       -2045|       11102
RTD|       -2430|       -1875|       19566|       0|       -2430|       19566
^C

--------------090703070003000806040009--

