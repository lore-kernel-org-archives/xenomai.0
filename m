Message-ID: <b054e88e0809290735x19e1618eh6facc56ee6baef18@domain.hid>
Date: Mon, 29 Sep 2008 16:35:08 +0200
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1671_24753773.1222698908273"
Subject: [Xenomai-help] Error while building Xenomai on Powerpc with
	instrument function entries enabled
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

------=_Part_1671_24753773.1222698908273
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While building the kernel with I-Pipe Tracer turned on with "Instrument
function entries" enabled i got the following error:

giammarco@domain.hid> make
make -C /home/giammarco/xenomai-ppc/linux-2.6-denx
O=/home/giammarco/xenomai-ppc/linux-2.6-denx-build/.
  Using /home/giammarco/xenomai-ppc/linux-2.6-denx as source for kernel
  GEN     /home/giammarco/xenomai-ppc/linux-2.6-denx-build/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL
/home/giammarco/xenomai-ppc/linux-2.6-denx/scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL
/home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/systbl_chk.sh
  CALL
/home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/prom_init_check.sh
Error: External symbol '_mcount' referenced from prom_init.c
make[3]: *** [prom_init_check] Error 1
make[2]: *** [arch/powerpc/kernel] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

The machine the kernel is configured for is a bPlan Efika computer, based on
mpc5200b.

I'm using DENX linux kernel 2.6.26, Xenomai 2.4.5, and a gcc 4.3.1.

Thank you

Giammarco

------=_Part_1671_24753773.1222698908273
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">While building the kernel with I-Pipe Tracer turned on with &quot;Instrument function entries&quot; enabled i got the following error:<br><br>giammarco@domain.hid&gt; make<br>
make -C /home/giammarco/xenomai-ppc/linux-2.6-denx O=/home/giammarco/xenomai-ppc/linux-2.6-denx-build/. <br>&nbsp; Using /home/giammarco/xenomai-ppc/linux-2.6-denx as source for kernel<br>&nbsp; GEN&nbsp;&nbsp;&nbsp;&nbsp; /home/giammarco/xenomai-ppc/linux-2.6-denx-build/Makefile<br>
&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/utsrelease.h<br>&nbsp; CALL&nbsp;&nbsp;&nbsp; /home/giammarco/xenomai-ppc/linux-2.6-denx/scripts/checksyscalls.sh<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<br>&nbsp; CALL&nbsp;&nbsp;&nbsp; /home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/systbl_chk.sh<br>
&nbsp; CALL&nbsp;&nbsp;&nbsp; /home/giammarco/xenomai-ppc/linux-2.6-denx/arch/powerpc/kernel/prom_init_check.sh<br>Error: External symbol &#39;_mcount&#39; referenced from prom_init.c<br>make[3]: *** [prom_init_check] Error 1<br>make[2]: *** [arch/powerpc/kernel] Error 2<br>
make[1]: *** [sub-make] Error 2<br>make: *** [all] Error 2<br><br>The machine the kernel is configured for is a bPlan Efika computer, based on mpc5200b.<br>
<br>I&#39;m using DENX linux kernel 2.6.26, Xenomai 2.4.5, and a gcc <a href="http://4.3.1.">4.3.1.</a><br><br>Thank you<br><br>Giammarco<br></div>

------=_Part_1671_24753773.1222698908273--

