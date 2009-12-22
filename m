Message-ID: <4B30D2AC.5050101@domain.hid>
Date: Tue, 22 Dec 2009 15:07:40 +0100
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <4B309A29.6030405@domain.hid>
In-Reply-To: <4B309A29.6030405@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------000309090108030908050309"
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

This is a multi-part message in MIME format.
--------------000309090108030908050309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix a =E9crit :
> Hi,
>
> Since I started talking about it, I have run build tests fixing a few
> things here and there. The current status is this (still at the same
> place: http://sisyphus.hd.free.fr/~gilles/bx):
>  =20
Hi,

I've watched your log file for nios2=20
(http://sisyphus.hd.free.fr/~gilles/bx/nios2/2.6.30-nios2-linux-uclibc-gc=
c-3.4.6/log.html#1).=20
You have this error because you don't have generated before the HW=20
design for the NIOS softcore processor: after synthesis with the Quartus=20
Altera tools, you finally have a file for programming the FPGA circuit=20
and a .ptf file that gives ASCII informations on your SoPC design (in a=20
xml style...).
The error:
./arch/nios2/Makefile:131: *** Run "make hwselect SYSPTF=3D<system.ptf>"=20
first. Stop.
is due to lack of this .ptf file.
This command generates a .h (nios2.h) file that makes relation between=20
hardware and the Linux kernel (peripheral base address, irq number,=20
peripheral name...)
Please find here: http://uuu.enseirb.fr/~kadionik/nios-xenomai/std_1s10.p=
tf
a valid .ptf file for Xenomai port.
Juste run :
$ make hwselect SYSPTF=3Dpath_to_std_1s10.ptf
for completing the kernel compilation...

Pat.




> * analogy: I have tried to disable some parts of analogy when compiling
> on machines without CONFIG_PCI, as compiling parts using PCI on a
> machine without PCI support, give various levels of warning and even
> errors depending on the architecture. Doing this, I stumbled across thi=
s
> compilation error:
> http://sisyphus.hd.free.fr/~gilles/bx/beagle/2.6.28-arm-none-linux-gnue=
abi-gcc-4.3.3/log.html#1
> this is with CONFIG_NI_MIO, but without CONFIG_NI_MITE.
>
> So, Alex, could you:
> - fix that error, if this combination is supposed to make sense
> - fix the Kconfig/Makefile so that no PCI code is compiled if CONFIG_PC=
I
> is not set (I tried and do this myself, but better one who knows than
> 100 who have to search...). As I said, doing this result in various
> levels of success depending on the architecture.
>
> * blackfin: I finally compiled blackfin! had to build a toolchain for
> that as the binary-only toolchain from analog.com uses glibc 2.8 and
> mine is 2.7. However, blackfin does not compile very well, as can be
> seen by the log:
> http://sisyphus.hd.free.fr/~gilles/bx/bf537-stamp/2.6.30-bfin-uclinux-g=
cc-4.1.2/log.html#1
> It may happen that my toolchain is buggy or outdated though.
>
> * rtcan: on blackfin we seem to have a conflict with rtcan.
> The warning is about CAN_ERR_MASK, sure blackfin is a bit strange to
> define this in core headers which are included everywhere. This said,
> not prefixing a Xenomai symbol with something like XN seems to be askin=
g
> for trouble. Wolfgang, do you think it would be possible to rename the
> symbols with such prefix? Or do you share some code with socket-can tha=
t
> you do not want to touch?
>
> * nios2: I am lacking some important file needed to even start to compi=
le.
>
> Thanks in advance for your efforts.
> Regards.
>
>  =20


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb.fr/~kadionik         +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB                      http://www.enseirb.fr                   +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+


--------------000309090108030908050309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Gilles Chanteperdrix a &eacute;crit&nbsp;:
<blockquote cite="mid:4B309A29.6030405@domain.hid" type="cite">
  <pre wrap="">Hi,

Since I started talking about it, I have run build tests fixing a few
things here and there. The current status is this (still at the same
place: <a class="moz-txt-link-freetext" href="http://sisyphus.hd.free.fr/~gilles/bx">http://sisyphus.hd.free.fr/~gilles/bx</a>):
  </pre>
</blockquote>
Hi,<br>
<br>
I've watched your log file for nios2
(<a class="moz-txt-link-freetext" href="http://sisyphus.hd.free.fr/~gilles/bx/nios2/2.6.30-nios2-linux-uclibc-gcc-3.4.6/log.html#1">http://sisyphus.hd.free.fr/~gilles/bx/nios2/2.6.30-nios2-linux-uclibc-gcc-3.4.6/log.html#1</a>).
You have this error because you don't have generated before the HW
design for the NIOS softcore processor: after synthesis with the
Quartus Altera tools, you finally have a file for programming the FPGA
circuit and a .ptf file that gives ASCII informations on your SoPC
design (in a xml style...).<tt><a name="1"><tt><br>
The error:<br>
./arch/nios2/Makefile:131: *** Run "make hwselect
SYSPTF=&lt;system.ptf&gt;" first. Stop.<br>
is due to lack of this .ptf file.<br>
This command generates a .h (nios2.h) file that makes relation between
hardware and the Linux kernel (peripheral base address, irq number,
peripheral name...)<br>
Please find here:
http://uuu.enseirb.fr/~kadionik/nios-xenomai/std_1s10.ptf<br>
a valid .ptf file for Xenomai port.<br>
Juste run :<br>
$ make hwselect SYSPTF=path_to_std_1s10.ptf<br>
for completing the kernel compilation...<br>
<br>
Pat.<br>
</tt></a><br>
<br>
<br>
<br>
</tt>
<blockquote cite="mid:4B309A29.6030405@domain.hid" type="cite">
  <pre wrap="">
* analogy: I have tried to disable some parts of analogy when compiling
on machines without CONFIG_PCI, as compiling parts using PCI on a
machine without PCI support, give various levels of warning and even
errors depending on the architecture. Doing this, I stumbled across this
compilation error:
<a class="moz-txt-link-freetext" href="http://sisyphus.hd.free.fr/~gilles/bx/beagle/2.6.28-arm-none-linux-gnueabi-gcc-4.3.3/log.html#1">http://sisyphus.hd.free.fr/~gilles/bx/beagle/2.6.28-arm-none-linux-gnueabi-gcc-4.3.3/log.html#1</a>
this is with CONFIG_NI_MIO, but without CONFIG_NI_MITE.

So, Alex, could you:
- fix that error, if this combination is supposed to make sense
- fix the Kconfig/Makefile so that no PCI code is compiled if CONFIG_PCI
is not set (I tried and do this myself, but better one who knows than
100 who have to search...). As I said, doing this result in various
levels of success depending on the architecture.

* blackfin: I finally compiled blackfin! had to build a toolchain for
that as the binary-only toolchain from analog.com uses glibc 2.8 and
mine is 2.7. However, blackfin does not compile very well, as can be
seen by the log:
<a class="moz-txt-link-freetext" href="http://sisyphus.hd.free.fr/~gilles/bx/bf537-stamp/2.6.30-bfin-uclinux-gcc-4.1.2/log.html#1">http://sisyphus.hd.free.fr/~gilles/bx/bf537-stamp/2.6.30-bfin-uclinux-gcc-4.1.2/log.html#1</a>
It may happen that my toolchain is buggy or outdated though.

* rtcan: on blackfin we seem to have a conflict with rtcan.
The warning is about CAN_ERR_MASK, sure blackfin is a bit strange to
define this in core headers which are included everywhere. This said,
not prefixing a Xenomai symbol with something like XN seems to be asking
for trouble. Wolfgang, do you think it would be possible to rename the
symbols with such prefix? Or do you share some code with socket-can that
you do not want to touch?

* nios2: I am lacking some important file needed to even start to compile.

Thanks in advance for your efforts.
Regards.

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
+ Patrice Kadionik             <a class="moz-txt-link-freetext" href="http://www.enseirb.fr/~kadionik">http://www.enseirb.fr/~kadionik</a>         +
+ IMS Laboratory               <a class="moz-txt-link-freetext" href="http://www.ims-bordeaux.fr/">http://www.ims-bordeaux.fr/</a>             +
+ ENSEIRB                      <a class="moz-txt-link-freetext" href="http://www.enseirb.fr">http://www.enseirb.fr</a>                   +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       <a class="moz-txt-link-freetext" href="mailto:patrice.kadionik@domain.hid">mailto:patrice.kadionik@domain.hid</a> +
+----------------------------------------------------------------------+</pre>
</body>
</html>

--------------000309090108030908050309--


