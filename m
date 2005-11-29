Message-ID: <438CBAC6.4050104@domain.hid>
Date: Tue, 29 Nov 2005 21:32:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems linking a custom vxWorks application
References: <200511292017.04476.niklaus.giger@domain.hid>
In-Reply-To: <200511292017.04476.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> I update to the latest xenomai/trunk (revision 207) and compiled and installed 
> without problems xenomai for my PPC405 board (using busybox).
> 
> The kernel starts (using a NFS root) and I can login without major problems. 
> Tools like xeno-load and xeno-test do not work as there is no /bin/bash 
> around. I usually work around this problem by calling insmod and alike 
> manually. 
> 
> In xeno-load I also remarked that 
> prefix="/mnt/data.ng/hcu/rootfs/usr/xenomai" 
> points to the mount point while compiling/installing xenomai, but not to the 
> mount point after starting the target (where / 
> equals /mnt/data.ng/hcu/rootfs).
>

The proper way to use a staging directory is:

blah/configure --prefix=/your/target/root
make DESTDIR=/mnt/host/dir

So that files are installed to /mnt/host/dir/your/target/root with the 
target prefix info still being /your/target/root.

Is this the way you compile/install Xeno?

> My real problem is that I cannot link my custom UVM application, as I get the 
> following error. Here are as the complete calls to compile (only the last 
> file) and link the application:
>     
> ccache /home/hcu/tools/powerpc-405-linux-gnu/gcc-3.4.1-glibc-2.3.3/bin/powerpc-405-linux-gnu-g++  
> -c -Wno-deprecated -g -DAB_DSP_5 -DVXWORKS -DBB_VERS -DIMC_VERS -DSYM_VERS 
> -DCEL_VERS -DRTAI -I. -I/mnt/data.ng/hcu/rootfs/usr/xenomai/include -O2 
> -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -D__XENO_UVM__ -O   
> -I/home/hcu/project/metaframe/1_3_5_1/BSys/mak/linux 
> -I/home/hcu/project/metaframe/1_3_5_1/BSys/src 
> -I/home/hcu/project/metaframe/1_3_5_1 -I/home/hcu/project/vx_skin 
> -I/mnt/data.ng/hcu/rootfs/usr/xenomai/include/vxworks 
> -I/mnt/data.ng/hcu/rootfs/usr/xenomai/include 
> -I/mnt/data.ng/hcu/kernel/build-xeno-hcu3/src/include 
> -I/mnt/data.ng/hcu/rootfs/usr/xenomai/include/vxworks  
> -O  /home/hcu/project/metaframe/1_3_5_1/BSys/src/BSysTypeInfoVXWorksParser.cpp  
> -o ../../obj/xeno-ppc405/BSysTypeInfoVXWorksParser.o
> ar ru  ../../obj/xeno-ppc405/BSys_lib.a  \
> ../../obj/xeno-ppc405/BSysTypeInfoVXWorksParser.o
> ranlib  ../../obj/xeno-ppc405/BSys_lib.a
> /home/hcu/tools/powerpc-405-linux-gnu/gcc-3.4.1-glibc-2.3.3/bin/powerpc-405-linux-gnu-g++  
> -g  -o 
> TSysMain   ../../obj/xeno-ppc405/TSysMain.o  ../../obj/xeno-ppc405/BSys_test.a ../../obj/xeno-ppc405/BSys_lib.a  
> -u__xeno_skin_init -L/mnt/data.ng/hcu/rootfs/usr/xenomai/lib -luvm -lnucleus 
> -lpthread -lvxworks -lvxworks
> 
> /mnt/data.ng/hcu/rootfs/usr/xenomai/lib/libnucleus.a(pod.o)(.text+0x674): In 
> function `xnpod_init':
> : undefined reference to `xnarch_atomic_set'
> /mnt/data.ng/hcu/rootfs/usr/xenomai/lib/libnucleus.a(pod.o)(.text+0x6b8): In 
> function `xnpod_init':
> : undefined reference to `xnarch_atomic_set'
> /mnt/data.ng/hcu/rootfs/usr/xenomai/lib/libnucleus.a(pod.o)(.text+0xfe8): In 
> function `xnpod_set_thread_mode':
> : undefined reference to `xnarch_atomic_set'
> /mnt/data.ng/hcu/rootfs/usr/xenomai/lib/libnucleus.a(pod.o)(.text+0x26a8): In 
> function `xnpod_delete_thread':
> : undefined reference to `xnarch_atomic_set'
> /mnt/data.ng/hcu/rootfs/usr/xenomai/lib/libnucleus.a(pod.o)(.text+0x29a8): In 
> function `xnpod_restart_thread':
> : undefined reference to `xnarch_atomic_set'
> collect2: ld returned 1 exit status
> 
> What is wrong with this?
> 
> Thanks you in advance for your help.
> 


-- 

Philippe.

