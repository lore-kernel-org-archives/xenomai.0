Message-ID: <47C454D0.101@domain.hid>
Date: Tue, 26 Feb 2008 19:05:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <609829951@domain.hid>
In-Reply-To: <609829951@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Compiling Problems for Virtex II pro Board
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

Joachim Meyer wrote:
> Hi
> I patched the Kernel sources like this:
> -----------------------------------------------
> meyer@domain.hid> ./prepare-kernel.sh
> Linux tree [default /lib/modules/2.6.13-15.18-bigsmp/source]: /home/meyer=
/xenomai/linux-2.6-xlnx.git
> Target architecture [default i686]: ppc
> Adeos patch [default /home/meyer/xenomai/xenomai-2.4.2/ksrc/arch/powerpc/=
patches/adeos-ipipe-2.6.23-ppc-DENX-1.6-03.patch]: /home/meyer/xenomai/adeos
> -ipipe-2.6.23-ppc-xlnx-1.6-03.patch

<snip>

> arch/ppc/syslib/xilinx_pic.c: In function `xilinx_intc_disable_and_ack':
> arch/ppc/syslib/xilinx_pic.c:62: error: implicit declaration of function =
`local_irq_save_hw_cond'
> arch/ppc/syslib/xilinx_pic.c:66: error: implicit declaration of function =
`local_irq_restore_hw_cond'
> arch/ppc/syslib/xilinx_pic.c: In function `xilinx_intc_end':
> arch/ppc/syslib/xilinx_pic.c:76: error: `ipipe_root_domain_p' undeclared =
(first use in this function)
> arch/ppc/syslib/xilinx_pic.c:76: error: (Each undeclared identifier is re=
ported only once
> arch/ppc/syslib/xilinx_pic.c:76: error: for each function it appears in.)
> arch/ppc/syslib/xilinx_pic.c: In function `ppc4xx_pic_init':
> arch/ppc/syslib/xilinx_pic.c:168: error: `__ipipe_ack_level_irq' undeclar=
ed (first use in this function)
> arch/ppc/syslib/xilinx_pic.c:169: error: `__ipipe_end_level_irq' undeclar=
ed (first use in this function)
> make[1]: *** [arch/ppc/syslib/xilinx_pic.o] Error 1
> make: *** [arch/ppc/syslib] Error 2
> meyer@domain.hid>
> -----------------------------------------------------
> Any idea?=20
>

diff --git a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
index 39057eb..21286e9 100644
--- a/arch/ppc/syslib/xilinx_pic.c
+++ b/arch/ppc/syslib/xilinx_pic.c
@@ -12,6 +12,7 @@

 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/ipipe.h>
 #include <asm/io.h>
 #include <platforms/4xx/xparameters/xparameters.h>
 #include <asm/ibm4xx.h>



> Greez Joachim
> _______________________________________________________________________
> Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
> kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=3D022220
>=20
>=20


--=20
Philippe.

