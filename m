Date: Thu, 28 Aug 2008 16:32:19 +0200
Message-Id: <959374811@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Compiling Problems for Virtex II pro Board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi Phillipe

Once you gave me a patch to add adeos support to the 2.6.23 Kernel from Xi=
linx (see old Mail below).
I managed to install Xenomai correctly that time. I didn't made any furthe=
r tests than those from the testsuite, but they worked fine.
Here's my Question:

What should I do if I want to use a newer Kernel Version at any time=3F It w=
ould be nice to get rid of my dependency to Kernel 2.6.23, because of the =
special patch.=20
Can you give me any information what I can do=3F Is it hard to fix a normal =
adeos patch so it works for the Xilinx tree=3F

Greetings & THX
Joachim

Joachim Meyer wrote:
> HI
>
> I tried to patch my Kernel 2.6.23 with the aedos patch. But I got the er=
ror listet at the end. I was using a Kernel from the Xilinx git tree becau=
se there are all the driver included I need. Next I tried to use a the las=
t 2.6.23 Kernel from DENX, which succeded and they also support the ml300 =
Board but the support for the Xilinx on-chip ethernet is missing. I need t=
hat support. So what can I do=3F
> The Xenomai patch doesn't only work with the DENX Kernels, right=3F

No, but for anything beyond 2.6.20, the DENX tree is our reference
kernel. So you are -mostly- on your own when using other trees.

> But where can I look for the error=3F

arch/powerpc/kernel/entry.S. But the Xilinx PIC code also has to be
adapted to Adeos, which is not done by the original patch, otherwise
this won't work.

> Greetings & Thx for all help
> Joachim
>
> error:
> ------------------------------------------------------------------------=
-------------------------------------------------------------------
> meyer@domain.hid> ./prepare-kernel.sh
> Linux tree [default /lib/modules/2.6.13-15.18-bigsmp/source]: ~/xenomai/=
test/linux-2.6-xlnx.git
> prepare-kernel.sh: cannot access Linux tree in ~/xenomai/test/linux-2.6-=
xlnx.git
> Linux tree [default /usr/src]: /home/meyer/xenomai/test/linux-2.6-xlnx.g=
it
> Target architecture [default i686]: ppc
> Adeos patch [default /home/meyer/xenomai/xenomai-2.4.2/ksrc/arch/powerpc=
/patches/adeos-ipipe-2.6.23-ppc-DENX-1.6-03.patch]:
> patching file Makefile
> patching file arch/powerpc/kernel/cputable.c
> Hunk #1 succeeded at 1298 (offset -89 lines).
> Hunk #2 succeeded at 1327 (offset -89 lines).
> patching file arch/powerpc/kernel/idle.c
> patching file arch/powerpc/kernel/io.c
> patching file arch/powerpc/kernel/irq.c
> patching file arch/powerpc/kernel/process.c
> Hunk #2 succeeded at 333 with fuzz 2 (offset -11 lines).
> Hunk #3 succeeded at 973 (offset -11 lines).
> patching file arch/ppc/Kconfig
> Hunk #1 succeeded at 980 (offset -32 lines).
> patching file arch/ppc/boot/Makefile
> patching file arch/ppc/kernel/Makefile
> patching file arch/ppc/kernel/entry.S
> Hunk #5 FAILED at 726.
> 1 out of 6 hunks FAILED -- saving rejects to file arch/ppc/kernel/entry.=
S.rej

Try this patch instead, it fixes the rejects and also makes
arch/ppc/syslib/xilinx-pic.c Adeos-aware:
http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.23-ppc-xlnx-1.6-=
03.patch

Note: this is a quick hack for the XILINX boards. In theory, this should
work. In practice, I have no idea if it does. The difference between
theory and practice is usually called luck as far as I'm concerned. You
have been warned.

--=20
Philippe.
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=

Verschicken Sie SMS direkt vom Postfach aus - in alle deutschen und viele=20
ausl=E4ndische Netze zum gleichen Preis!=20
https://produkte.web.de/webde=5Fsms/sms




