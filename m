Message-ID: <4BB1B839.9060002@domain.hid>
Date: Tue, 30 Mar 2010 10:37:13 +0200
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
In-Reply-To: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Huan Fang <huanf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 30/03/2010 00:20, Huan Fang a =E9crit :
> Hi Patrice,
>   =20
Hi Huan,

Have you really used  uClinux with NIOS2 without MMU in your Quartus II=20
design? Have you synchronized the =B5Clinux kernel file version with the=20
NIOS2 ipipe version?

> Many thanks for the tutorial, Now I am able to run xenomai patched ucli=
nux on my DE2-70 board.
> But the kernel doesn't boot unless I modified one file :linux-2.6/arch/=
nios2/kernel/time.c
>
> na_timer0 ->  na_sys_clock_timer which I guess is the clock timer used =
by Linux. Did you manually patch this file?
> The adeos patch doesn't seem to change this part.
>   =20
Not at all.

If you have done this:
$ make vendor_hwselect SYSPTF=3Dmy_design.ptf
it generates a nios2.h under uClinux-dist/linux-2.6.x/include/asm-nios2
in which you have na_sys_clk_timer redefined as na_timer0.
For example, in my nios2.h generated file, I have:
/* Executing ...scripts/nios2.h/altera_avalon_timer.pm */

/* system timer input clock frequency */
#define nasys_clock_freq                                        50000000
#define nasys_clock_freq_1000                                      50000

/* Redefining sys_clk_timer -> timer0 */
#undef na_sys_clk_timer
#undef na_sys_clk_timer_irq

#define na_timer0                                  ((void *) 0x00810800)

Please send me in a private email your nios2.h file.

Patrice



> currently my timer settings are
>
> /proc/xenomai>cat timer
> status=3Don+watchdog:setup=3D1030:clock=3D1638046732:timerdev=3Dhrtimer=
:clockdev=3Dhrclock
> Does it looks all right?
>
> Best Regards,
> Huan
> ________________________________________
> From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Be=
half Of Patrice Kadionik [kadionik@domain.hid]
> Sent: 28 March 2010 15:26
> To: Chtourou Sonda
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space=
 support
>
> Le 20:59, Chtourou Sonda a =E9crit :
> Dears,
> Hi,
>
>
> I built the uClinux kernel for NIOS II and it run well on the target bo=
ard. I followed the typical actions available here : http://www.nioswiki.=
com/
>
> Now, I want to add a co-scheduler xenomai to the kernel (uclinux) to re=
duce its latency. I followed these steps: (http://www.xenomai.org/documen=
tation/xenomai-2.5/README.INSTALL)
> I've tried to reproduce your compilation error but without success.
>
> For using Xenomai on NIOS II processor with uClinux, you must add extra=
 hardware in your SoPC design as explained in this tutorial (http://uuu.e=
nseirb.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NIOS%20II%20Softcore%20P=
rocessor%20Guide-v1.1.pdf).
>
> It is OK on my Altera 1S10 board  with Xenomai v2.5.1 (see traces).
>
> Sincerely;
>
> Patrice
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Uncompressing Linux... Ok, booting the kernel.
> Linux version 2.6.30 (kadionik@domain.hid) (gcc version 3.4.6) #4 PREEMPT =
Sun Mar 0
>
>
> uClinux/Nios II
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4=
064
> Kernel command line:
> NR_IRQS:32
> PID hash table entries: 64 (order: 6, 256 bytes)
> I-pipe 1.1-00: pipeline enabled.
> Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
> Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Memory available: 12108k/3990k RAM, 0k/0k ROM (1931k kernel code, 2059k=
 data)
> Calibrating delay loop... 24.06 BogoMIPS (lpj=3D120320)
> Mount-cache hash table entries: 512
> net_namespace: 264 bytes
> NET: Registered protocol family 16
> init_BSP(): registering device resources
> bio: create slab<bio-0>  at 0
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 512 (order: 0, 4096 bytes)
> TCP bind hash table entries: 512 (order: -1, 2048 bytes)
> TCP: Hash tables configured (established 512 bind 512)
> TCP reno registered
> NET: Registered protocol family 1
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/nios2 started.
> Xenomai: scheduling class idle registered.
> Xenomai: scheduling class rt registered.
> Xenomai: real-time nucleus v2.5.1 (Speed Of Light) loaded.
> Xenomai: starting native API services.
> Xenomai: starting POSIX services.
> Xenomai: starting RTDM services.
> io scheduler noop registered
> io scheduler deadline registered (default)
> ttyS0 at MMIO 0x810840 (irq =3D 5) is a Altera UART
> console [ttyS0] enabled
>
>
>
>
> $ $xenomai-2.5.1/scripts/prepare-kernel.sh --arch=3Dnios2 --adeos=3D$xe=
nomai-2.5.1/ksrc/arch/nios2/patches/adeos-ipipe-2.6.30-nios2-1.1-00.patch
>    --linux=3D$linux_tree
> $ $xenomai-2.5.1/configure --host=3Dnios2-linux
> $ make install DESTDIR=3D$uClinux-dist/romfs
>
> But, in this step, I got this error:
>
> eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm
> libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc -Wl,-elf2f=
lt -o check-vdso check_vdso-check-vdso.o  ../../skins/native/.libs/libnat=
ive.a -lpthread -lm
> check-vdso.elf2flt(.text+0x16c): In function `main':
> : undefined reference to `xeno_sem_heap'
> check-vdso.elf2flt(.text+0x170): In function `main':
> : undefined reference to `xeno_sem_heap'
> collect2: ld returned 1 exit status
> make[3]: *** [check-vdso] Erreur 1
> make[3]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1=
/src/testsuite/unit =BB
> make[2]: *** [all-recursive] Erreur 1
> make[2]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1=
/src/testsuite =BB
> make[1]: *** [all-recursive] Erreur 1
> make[1]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1=
/src =BB
> make: *** [all-recursive] Erreur 1
>
> what can I do? Please help
> Regards,
>
>
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid<mailto:Xenomai-help@domain.hid>
> https://mail.gna.org/listinfo/xenomai-help
>
>
>
>
> --
> Patrice Kadionik. F6KQH / F4CUQ
> -----------
>
> +----------------------------------------------------------------------=
+
> +"Tout doit etre aussi simple que possible, pas seulement plus simple" =
+
> +----------------------------------------------------------------------=
+
> + Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik =
+
> + IMS Laboratory               http://www.ims-bordeaux.fr/             =
+
> + ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           =
+
> + PO BOX 99                    fax   : +33 5.56.37.20.23               =
+
> + 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               =
+
> + FRANCE                       mailto:patrice.kadionik@domain.hid =
+
> +----------------------------------------------------------------------=
+
>
>
>
>
>   =20


--=20
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


