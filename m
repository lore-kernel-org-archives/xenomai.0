Message-ID: <4BAF58F7.7070707@domain.hid>
Date: Sun, 28 Mar 2010 15:26:15 +0200
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>
In-Reply-To: <507168.65506.qm@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------000104030907030900030002"
Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space
	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chtourou Sonda <chtourou_sonda@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000104030907030900030002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by plan.enseirb.fr id o2SDPacp020935

Le 20:59, Chtourou Sonda a =E9crit :
>
> Dears,
>
Hi,

>
> I built the uClinux kernel for NIOS II and it run well on the target=20
> board. I followed the typical actions available here :=20
> http://www.nioswiki.com/
>
> Now, I want to add a co-scheduler xenomai to the kernel (uclinux) to=20
> reduce its latency. I followed these steps:=20
> (http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL)
>
I've tried to reproduce your compilation error but without success.

For using Xenomai on NIOS II processor with uClinux, you must add extra=20
hardware in your SoPC design as explained in this tutorial=20
(http://uuu.enseirb.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NIOS%20II%2=
0Softcore%20Processor%20Guide-v1.1.pdf).

It is OK on my Altera 1S10 board  with Xenomai v2.5.1 (see traces).

Sincerely;

Patrice
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Uncompressing Linux... Ok, booting the kernel.
Linux version 2.6.30 (kadionik@domain.hid) (gcc version 3.4.6) #4 PREEMPT=20
Sun Mar 0


uClinux/Nios II
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 406=
4
Kernel command line:
NR_IRQS:32
PID hash table entries: 64 (order: 6, 256 bytes)
I-pipe 1.1-00: pipeline enabled.
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory available: 12108k/3990k RAM, 0k/0k ROM (1931k kernel code, 2059k=20
data)
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




> $ $xenomai-2.5.1/scripts/prepare-kernel.sh --arch=3Dnios2=20
> --adeos=3D$xenomai-2.5.1/ksrc/arch/nios2/patches/adeos-ipipe-2.6.30-nio=
s2-1.1-00.patch
>   --linux=3D$linux_tree
> $ $xenomai-2.5.1/configure --host=3Dnios2-linux
> $ make install DESTDIR=3D$uClinux-dist/romfs
>
> But, in this step, I got this error:
>
> eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm
> libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc=20
> -Wl,-elf2flt -o check-vdso check_vdso-check-vdso.o =20
> ../../skins/native/.libs/libnative.a -lpthread -lm
> check-vdso.elf2flt(.text+0x16c): In function `main':
> : undefined reference to `xeno_sem_heap'
> check-vdso.elf2flt(.text+0x170): In function `main':
> : undefined reference to `xeno_sem_heap'
> collect2: ld returned 1 exit status
> make[3]: *** [check-vdso] Erreur 1
> make[3]: quittant le r=E9pertoire =AB=20
> /home/sonda/Desktop/xenomai-2.5.1/src/testsuite/unit =BB
> make[2]: *** [all-recursive] Erreur 1
> make[2]: quittant le r=E9pertoire =AB=20
> /home/sonda/Desktop/xenomai-2.5.1/src/testsuite =BB
> make[1]: *** [all-recursive] Erreur 1
> make[1]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1=
/src =BB
> make: *** [all-recursive] Erreur 1
>
> what can I do? Please help
>
> Regards,
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>   =20


--=20
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


--------------000104030907030900030002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Le 20:59, Chtourou Sonda a &eacute;crit&nbsp;:
<blockquote cite="mid:%3C507168.65506.qm@domain.hid"
 type="cite">
  <style type="text/css"><!-- DIV {margin:0px;} --></style>
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">
  <div>
  <p style="margin: 0cm 0cm 10pt;" class="MsoNormal"><span style=""
 lang="EN-US"><font face="Calibri">Dears, <br style="">
  </font></span></p>
  </div>
  </div>
</blockquote>
Hi,<br>
<br>
<blockquote cite="mid:%3C507168.65506.qm@domain.hid"
 type="cite">
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">
  <div>
  <p style="margin: 0cm 0cm 10pt;" class="MsoNormal"><span style=""
 lang="EN-US"><font face="Calibri"><br style="">
  <o:p></o:p></font></span></p>
  <p style="margin: 0cm 0cm 10pt;" class="MsoNormal"><span style=""
 lang="EN-US"><font face="Calibri">I built the uClinux kernel for NIOS
II and it run well on the target board. I followed the typical actions
available here : <a class="moz-txt-link-freetext" href="http://www.nioswiki.com/">http://www.nioswiki.com/</a> <br>
  <br>
Now, I want to add a co-scheduler xenomai to the kernel (uclinux) to
reduce its latency. I followed these steps:
(<a class="moz-txt-link-freetext" href="http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL">http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL</a>)<br>
  </font></span></p>
  </div>
  </div>
</blockquote>
I've tried to reproduce your compilation error but without success.<br>
<br>
For using Xenomai on NIOS II processor with uClinux, you must add extra
hardware in your SoPC design as explained in this tutorial
(<a class="moz-txt-link-freetext" href="http://uuu.enseirb.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NIOS%20II%20Softcore%20Processor%20Guide-v1.1.pdf">http://uuu.enseirb.fr/~kadionik/nios2-xenomai/Xenomai%20on%20NIOS%20II%20Softcore%20Processor%20Guide-v1.1.pdf</a>).<br>
<br>
It is OK on my Altera 1S10 board&nbsp; with Xenomai v2.5.1 (see traces).<br>
<br>
Sincerely;<br>
<br>
Patrice<br>
========================================<br>
<br>
<tt>Uncompressing Linux... Ok, booting the kernel.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Linux version 2.6.30 (kadionik@domain.hid) (gcc version 3.4.6) #4 PREEMPT
Sun Mar 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
uClinux/Nios
II&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Built 1 zonelists in Zone order, mobility grouping off.&nbsp; Total pages:
4064&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Kernel command
line:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
NR_IRQS:32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
PID hash table entries: 64 (order: 6, 256
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
I-pipe 1.1-00: pipeline
enabled.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Dentry cache hash table entries: 2048 (order: 1, 8192
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Inode-cache hash table entries: 1024 (order: 0, 4096
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Memory available: 12108k/3990k RAM, 0k/0k ROM (1931k kernel code, 2059k
data)&nbsp;&nbsp; <br>
Calibrating delay loop... 24.06 BogoMIPS
(lpj=120320)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Mount-cache hash table entries:
512&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
net_namespace: 264
bytes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
NET: Registered protocol family
16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
init_BSP(): registering device
resources&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
bio: create slab &lt;bio-0&gt; at
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
NET: Registered protocol family
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
IP route cache hash table entries: 1024 (order: 0, 4096
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
TCP established hash table entries: 512 (order: 0, 4096
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
TCP bind hash table entries: 512 (order: -1, 2048
bytes)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
TCP: Hash tables configured (established 512 bind
512)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
TCP reno
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
NET: Registered protocol family
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
I-pipe: Domain Xenomai
registered.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Xenomai: hal/nios2
started.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Xenomai: scheduling class idle
registered.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Xenomai: scheduling class rt
registered.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Xenomai: real-time nucleus v2.5.1 (Speed Of Light)
loaded.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Xenomai: starting native API
services.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Xenomai: starting POSIX
services.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Xenomai: starting RTDM
services.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
io scheduler noop
registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
io scheduler deadline registered
(default)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
ttyS0 at MMIO 0x810840 (irq = 5) is a Altera
UART&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
console [ttyS0] enabled&nbsp;&nbsp;</tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
<br>
<br>
<blockquote cite="mid:%3C507168.65506.qm@domain.hid"
 type="cite">
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">
  <div>
  <p style="margin: 0cm 0cm 10pt;" class="MsoNormal"><span style=""
 lang="EN-US"><font face="Calibri">$
$xenomai-2.5.1/scripts/prepare-kernel.sh --arch=nios2
--adeos=$xenomai-2.5.1/ksrc/arch/nios2/patches/adeos-ipipe-2.6.30-nios2-1.1-00.patch<br>
&nbsp; --linux=$linux_tree<br>
$ $xenomai-2.5.1/configure --host=nios2-linux<br>
$ make install DESTDIR=$uClinux-dist/romfs<br>
  <br>
But, in this step, I got this error:<br>
  <br>
eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm<br>
libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc
-Wl,-elf2flt -o check-vdso check_vdso-check-vdso.o&nbsp;
../../skins/native/.libs/libnative.a -lpthread -lm<br>
check-vdso.elf2flt(.text+0x16c): In function `main':<br>
: undefined reference to `xeno_sem_heap'<br>
check-vdso.elf2flt(.text+0x170): In function `main':<br>
: undefined reference to `xeno_sem_heap'<br>
collect2: ld returned 1 exit status<br>
make[3]: *** [check-vdso] Erreur 1<br>
make[3]: quittant le r&eacute;pertoire &laquo;
/home/sonda/Desktop/xenomai-2.5.1/src/testsuite/unit &raquo;<br>
make[2]: *** [all-recursive] Erreur 1<br>
make[2]: quittant le r&eacute;pertoire &laquo;
/home/sonda/Desktop/xenomai-2.5.1/src/testsuite &raquo;<br>
make[1]: *** [all-recursive] Erreur 1<br>
make[1]: quittant le r&eacute;pertoire &laquo; /home/sonda/Desktop/xenomai-2.5.1/src
&raquo;<br>
make: *** [all-recursive] Erreur 1<br>
  <br>
what can I do? Please help</font></span></p>
  <p style="margin: 0cm 0cm 10pt;" class="MsoNormal"><span style=""
 lang="EN-US"><font face="Calibri"><o:p>Regards,</o:p></font></span></p>
  </div>
  </div>
  <br>
  <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
Xenomai-help mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a>
<a class="moz-txt-link-freetext" href="https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/listinfo/xenomai-help</a>
  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             <a class="moz-txt-link-freetext" href="http://www.enseirb-matmeca.fr/~kadionik">http://www.enseirb-matmeca.fr/~kadionik</a> +
+ IMS Laboratory               <a class="moz-txt-link-freetext" href="http://www.ims-bordeaux.fr/">http://www.ims-bordeaux.fr/</a>             +
+ ENSEIRB-MATMECA              <a class="moz-txt-link-freetext" href="http://www.enseirb-matmeca.fr">http://www.enseirb-matmeca.fr</a>           +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       <a class="moz-txt-link-freetext" href="mailto:patrice.kadionik@domain.hid">mailto:patrice.kadionik@domain.hid</a> +
+----------------------------------------------------------------------+
</pre>
</body>
</html>

--------------000104030907030900030002--

