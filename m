From: Huan Fang <huanf@domain.hid>
Date: Tue, 30 Mar 2010 00:20:30 +0200
Message-ID: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
In-Reply-To: <4BAF58F7.7070707@domain.hid>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai
	user-space	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrice Kadionik <kadionik@domain.hid>, Chtourou Sonda <chtourou_sonda@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Patrice,

Many thanks for the tutorial, Now I am able to run xenomai patched uclinux =
on my DE2-70 board.
But the kernel doesn't boot unless I modified one file :linux-2.6/arch/nios=
2/kernel/time.c

na_timer0 -> na_sys_clock_timer which I guess is the clock timer used by Li=
nux. Did you manually patch this file?
The adeos patch doesn't seem to change this part.

currently my timer settings are

/proc/xenomai>cat timer
status=3Don+watchdog:setup=3D1030:clock=3D1638046732:timerdev=3Dhrtimer:clo=
ckdev=3Dhrclock
Does it looks all right?

Best Regards,
Huan
________________________________________
From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Behalf=
 Of Patrice Kadionik [kadionik@domain.hid]
Sent: 28 March 2010 15:26
To: Chtourou Sonda
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space sup=
port

Le 20:59, Chtourou Sonda a =E9crit :
Dears,
Hi,


I built the uClinux kernel for NIOS II and it run well on the target board.=
 I followed the typical actions available here : http://www.nioswiki.com/

Now, I want to add a co-scheduler xenomai to the kernel (uclinux) to reduce=
 its latency. I followed these steps: (http://www.xenomai.org/documentation=
/xenomai-2.5/README.INSTALL)
I've tried to reproduce your compilation error but without success.

For using Xenomai on NIOS II processor with uClinux, you must add extra har=
dware in your SoPC design as explained in this tutorial (http://uuu.enseirb=
.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NIOS%20II%20Softcore%20Processor=
%20Guide-v1.1.pdf).

It is OK on my Altera 1S10 board  with Xenomai v2.5.1 (see traces).

Sincerely;

Patrice
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Uncompressing Linux... Ok, booting the kernel.
Linux version 2.6.30 (kadionik@domain.hid) (gcc version 3.4.6) #4 PREEMPT Sun =
Mar 0


uClinux/Nios II
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line:
NR_IRQS:32
PID hash table entries: 64 (order: 6, 256 bytes)
I-pipe 1.1-00: pipeline enabled.
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory available: 12108k/3990k RAM, 0k/0k ROM (1931k kernel code, 2059k dat=
a)
Calibrating delay loop... 24.06 BogoMIPS (lpj=3D120320)
Mount-cache hash table entries: 512
net_namespace: 264 bytes
NET: Registered protocol family 16
init_BSP(): registering device resources
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
I-pipe: Domain Xenomai registered.
Xenomai: hal/nios2 started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.1 (Speed Of Light) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
io scheduler noop registered
io scheduler deadline registered (default)
ttyS0 at MMIO 0x810840 (irq =3D 5) is a Altera UART
console [ttyS0] enabled




$ $xenomai-2.5.1/scripts/prepare-kernel.sh --arch=3Dnios2 --adeos=3D$xenoma=
i-2.5.1/ksrc/arch/nios2/patches/adeos-ipipe-2.6.30-nios2-1.1-00.patch
  --linux=3D$linux_tree
$ $xenomai-2.5.1/configure --host=3Dnios2-linux
$ make install DESTDIR=3D$uClinux-dist/romfs

But, in this step, I got this error:

eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm
libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc -Wl,-elf2flt -=
o check-vdso check_vdso-check-vdso.o  ../../skins/native/.libs/libnative.a =
-lpthread -lm
check-vdso.elf2flt(.text+0x16c): In function `main':
: undefined reference to `xeno_sem_heap'
check-vdso.elf2flt(.text+0x170): In function `main':
: undefined reference to `xeno_sem_heap'
collect2: ld returned 1 exit status
make[3]: *** [check-vdso] Erreur 1
make[3]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1/src=
/testsuite/unit =BB
make[2]: *** [all-recursive] Erreur 1
make[2]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1/src=
/testsuite =BB
make[1]: *** [all-recursive] Erreur 1
make[1]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1/src=
 =BB
make: *** [all-recursive] Erreur 1

what can I do? Please help
Regards,





_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid<mailto:Xenomai-help@domain.hid>
https://mail.gna.org/listinfo/xenomai-help




--
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+



