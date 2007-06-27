Message-ID: <468254DC.1000603@domain.hid>
Date: Wed, 27 Jun 2007 14:15:24 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060505050701070404080606"
Subject: [Xenomai-help] Todays trunk does not built for 2.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060505050701070404080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

building Linux 2.4.25 for PPC with todays Xenomai's SVN trunk fails as 
shown in the attachment, apart from some warnings "implicit declaration 
of function `xnarch_*_host_mem'" . Any idea why?

Thanks,

Wolfgang.

--------------060505050701070404080606
Content-Type: text/x-log;
 name="make.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make.log"

ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
. scripts/mkversion > .tmpversion
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -DUTS_MACHINE='"ppc"' -DKBUILD_BASENAME=version -c -o init/version.o init/version.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb   -DKBUILD_BASENAME=do_mounts -c -o init/do_mounts.o init/do_mounts.c
make CFLAGS="-D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb " -C  kernel
make[1]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel'
make -C ipipe
make[2]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/ipipe'
make all_targets
make[3]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/ipipe'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb   -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=core  -c -o core.o core.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb   -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=generic  -c -o generic.o generic.c
rm -f ipipe.o
ppc_6xx-ld   -r -o ipipe.o core.o generic.o
make[3]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/ipipe'
make[2]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/ipipe'
make -C xenomai
make[2]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai'
make -C arch
make[3]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch'
make -C generic
make[4]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch/generic'
make all_targets
make[5]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch/generic'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=hal  -c -o hal.o hal.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=compat  -c -o compat.o compat.c
rm -f built-in.o
ppc_6xx-ld   -r -o built-in.o hal.o compat.o
make[5]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch/generic'
make[4]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch/generic'
make all_targets
make[4]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch'
make[3]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/arch'
make -C nucleus
make[3]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/nucleus'
make all_targets
make[4]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/nucleus'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=heap  -c -o heap.o heap.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=intr  -c -o intr.o intr.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=module  -c -o module.o module.c
module.c: In function `__xeno_sys_init':
module.c:1145: warning: implicit declaration of function `xnarch_alloc_host_mem'
module.c:1145: warning: assignment makes pointer from integer without a cast
module.c: In function `__xeno_sys_exit':
module.c:1263: warning: implicit declaration of function `xnarch_free_host_mem'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=pod  -c -o pod.o pod.c
pod.c: In function `xnpod_flush_heap':
pod.c:208: warning: implicit declaration of function `xnarch_free_host_mem'
pod.c: In function `xnpod_init':
pod.c:302: warning: implicit declaration of function `xnarch_alloc_host_mem'
pod.c:302: warning: assignment makes pointer from integer without a cast
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=synch  -c -o synch.o synch.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=thread  -c -o thread.o thread.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=timebase  -c -o timebase.o timebase.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=timer  -c -o timer.o timer.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=shadow  -c -o shadow.o shadow.c
shadow.c: In function `xnshadow_mount':
shadow.c:2410: warning: implicit declaration of function `xnarch_alloc_host_mem'
shadow.c: In function `xnshadow_cleanup':
shadow.c:2449: warning: implicit declaration of function `xnarch_free_host_mem'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=pipe  -c -o pipe.o pipe.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=registry  -c -o registry.o registry.c
registry.c: In function `xnregistry_init':
registry.c:130: warning: implicit declaration of function `xnarch_alloc_host_mem'
registry.c: In function `xnregistry_cleanup':
registry.c:188: warning: implicit declaration of function `xnarch_free_host_mem'
ppc_6xx-ld -r -o xeno_nucleus.o heap.o intr.o module.o pod.o synch.o thread.o timebase.o timer.o  shadow.o pipe.o registry.o
rm -f built-in.o
ppc_6xx-ld   -r -o built-in.o xeno_nucleus.o
make[4]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/nucleus'
make[3]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/nucleus'
make -C skins
make[3]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins'
make -C native
make[4]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/native'
make all_targets
make[5]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/native'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=module  -c -o module.o module.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=task  -c -o task.o task.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=timer  -c -o timer.o timer.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=syscall  -c -o syscall.o syscall.c
syscall.c: In function `__shadow_eventcb':
syscall.c:3694: warning: implicit declaration of function `xnarch_alloc_host_mem'
syscall.c:3723: warning: implicit declaration of function `xnarch_free_host_mem'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=pipe  -c -o pipe.o pipe.c
pipe.c: In function `__pipe_flush_pool':
pipe.c:86: warning: implicit declaration of function `xnarch_free_host_mem'
pipe.c: In function `rt_pipe_create':
pipe.c:250: warning: implicit declaration of function `xnarch_alloc_host_mem'
pipe.c:250: warning: assignment makes pointer from integer without a cast
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=sem  -c -o sem.o sem.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=event  -c -o event.o event.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=mutex  -c -o mutex.o mutex.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=cond  -c -o cond.o cond.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=queue  -c -o queue.o queue.c
queue.c: In function `__queue_flush_private':
queue.c:121: warning: implicit declaration of function `xnarch_free_host_mem'
queue.c: In function `rt_queue_create':
queue.c:251: warning: implicit declaration of function `xnarch_alloc_host_mem'
queue.c:251: warning: initialization makes pointer from integer without a cast
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=heap  -c -o heap.o heap.c
heap.c: In function `__heap_flush_private':
heap.c:127: warning: implicit declaration of function `xnarch_free_host_mem'
heap.c: In function `rt_heap_create':
heap.c:274: warning: implicit declaration of function `xnarch_alloc_host_mem'
heap.c:274: warning: initialization makes pointer from integer without a cast
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=alarm  -c -o alarm.o alarm.c
ppc_6xx-ld -r -o xeno_native.o module.o task.o timer.o  syscall.o pipe.o sem.o event.o mutex.o cond.o queue.o heap.o alarm.o
rm -f built-in.o
ppc_6xx-ld   -r -o built-in.o xeno_native.o
make[5]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/native'
make[4]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/native'
make -C posix
make[4]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/posix'
make all_targets
make[5]: Entering directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/posix'
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=sched  -c -o sched.o sched.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=thread_attr  -c -o thread_attr.o thread_attr.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=thread  -c -o thread.o thread.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=mutex_attr  -c -o mutex_attr.o mutex_attr.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=mutex  -c -o mutex.o mutex.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=cond_attr  -c -o cond_attr.o cond_attr.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=cond  -c -o cond.o cond.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=sem  -c -o sem.o sem.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=cancel  -c -o cancel.o cancel.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=once  -c -o once.o once.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=signal  -c -o signal.o signal.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=tsd  -c -o tsd.o tsd.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=clock  -c -o clock.o clock.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=timer  -c -o timer.o timer.c
ppc_6xx-gcc -D__KERNEL__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb  -D__IN_XENOMAI__ -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/compat -I.. -I/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/include/xenomai/posix -nostdinc -I /data/eldk/v3.1.1/usr/lib/gcc-lib/ppc-linux/3.3.3/include -DKBUILD_BASENAME=registry  -c -o registry.o registry.c
registry.c:216: error: conflicting types for `pse51_desc_create'
../posix/registry.h:71: error: previous declaration of `pse51_desc_create'
registry.c: In function `pse51_reg_pkg_init':
registry.c:401: warning: implicit declaration of function `xnarch_alloc_host_mem'
registry.c: In function `pse51_reg_pkg_cleanup':
registry.c:459: warning: implicit declaration of function `xnarch_free_host_mem'
make[5]: *** [registry.o] Error 1
make[5]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/posix'
make[4]: *** [first_rule] Error 2
make[4]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins/posix'
make[3]: *** [_subdir_posix] Error 2
make[3]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai/skins'
make[2]: *** [_subdir_skins] Error 2
make[2]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel/xenomai'
make[1]: *** [_subdir_xenomai] Error 2
make[1]: Leaving directory `/temp/rtcan/devel/linuxppc_2_4_devel-2007_04_02_1713/kernel'
make: *** [_dir_kernel] Error 2

--------------060505050701070404080606--

