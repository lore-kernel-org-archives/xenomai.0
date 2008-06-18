Date: Wed, 18 Jun 2008 13:20:27 +0200
From: "Axel Beierlein" <belatronix@domain.hid>
Content-Type: text/plain; format="flowed"; delsp="yes"; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.ucxy4dpbt06gyn@domain.hid>
Subject: [Xenomai-help] problems with configure and --enable-linux-build
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Hello,

I try to install the actual Xenomai Version 2.4.4.
I get my kernel sources (2.4.25) from the denx git and my target system  
was an ppc and my host an PC with ubuntu 804. The cross compiler is based  
on the denx eldk41 for freescale ppc´s.
Patching the kernel with the adeos patch was succesful. I call the config  
script from my build directory with the following line:

../xenomai-2.4.4/configure --build=i486-linux-gnu --host=powerpc-linux  
--enable-linux-build=~/\ linuxppc_2_4_devel CC=ppc_6xx-gcc CXX=ppc_6xx-g++  
LD=ppc_6xx-ld

$ARCH and $CROSS_COMPILE is already set by the eldk!

but when i call

make DESTDIR=<destdir> install

i get the error

find: /home/axl/build_root/linux/include/asm: No such file or directory
scripts/mkdep -- init/*.c > .depend
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  
-I/home/axl/build_root/linux/arch/ppc -o scripts/split-include  
scripts/split-include.c
make[1]: *** Keine Regel vorhanden, um das Target  
»include/linux/autoconf.h«,
   benötigt von »include/config/MARKER«, zu erstellen.  Schluss.

when i call configure without --enable-linux-build, there are no problems.

So i have a look at the copied linux sources in the build-tree and i must  
see that configure doesn't copied all necessary files from the kernel  
source directory like the file /linux/include/linux/autoconf.h.

The symbolic link asm to asm-ppc is missing as well.

So where is my mistake or is there a bug in configure?

Axel

