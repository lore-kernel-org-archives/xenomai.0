Message-ID: <48B7A6F1.602@domain.hid>
Date: Fri, 29 Aug 2008 09:36:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <959374811@domain.hid>
In-Reply-To: <959374811@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
> Hi Phillipe
> 
> Once you gave me a patch to add adeos support to the 2.6.23 Kernel from Xilinx (see old Mail below).
> I managed to install Xenomai correctly that time. I didn't made any further tests than those from the testsuite, but they worked fine.
> Here's my Question:
> 
> What should I do if I want to use a newer Kernel Version at any time? It would be nice to get rid of my dependency to Kernel 2.6.23, because of the special patch. 
> Can you give me any information what I can do? Is it hard to fix a normal adeos patch so it works for the Xilinx tree?
>

Adeos/powerpc patches are based on the DENX kernel tree, and looking at the
Xilinx tree, more conflicts are raised over time. I won't say that it's hard to
adapt the patch to the Xilinx tree, but the merge issues are not trivial
anymore, like they were in 2.6.23.

What would help is that more Xilinx bits are sent/merged to mainline or DENX trees.

> Greetings & THX
> Joachim
> 
> Joachim Meyer wrote:
>> HI
>>
>> I tried to patch my Kernel 2.6.23 with the aedos patch. But I got the error listet at the end. I was using a Kernel from the Xilinx git tree because there are all the driver included I need. Next I tried to use a the last 2.6.23 Kernel from DENX, which succeded and they also support the ml300 Board but the support for the Xilinx on-chip ethernet is missing. I need that support. So what can I do?
>> The Xenomai patch doesn't only work with the DENX Kernels, right?
> 
> No, but for anything beyond 2.6.20, the DENX tree is our reference
> kernel. So you are -mostly- on your own when using other trees.
> 
>> But where can I look for the error?
> 
> arch/powerpc/kernel/entry.S. But the Xilinx PIC code also has to be
> adapted to Adeos, which is not done by the original patch, otherwise
> this won't work.
> 
>> Greetings & Thx for all help
>> Joachim
>>
>> error:
>> -------------------------------------------------------------------------------------------------------------------------------------------
>> meyer@domain.hid> ./prepare-kernel.sh
>> Linux tree [default /lib/modules/2.6.13-15.18-bigsmp/source]: ~/xenomai/test/linux-2.6-xlnx.git
>> prepare-kernel.sh: cannot access Linux tree in ~/xenomai/test/linux-2.6-xlnx.git
>> Linux tree [default /usr/src]: /home/meyer/xenomai/test/linux-2.6-xlnx.git
>> Target architecture [default i686]: ppc
>> Adeos patch [default /home/meyer/xenomai/xenomai-2.4.2/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-DENX-1.6-03.patch]:
>> patching file Makefile
>> patching file arch/powerpc/kernel/cputable.c
>> Hunk #1 succeeded at 1298 (offset -89 lines).
>> Hunk #2 succeeded at 1327 (offset -89 lines).
>> patching file arch/powerpc/kernel/idle.c
>> patching file arch/powerpc/kernel/io.c
>> patching file arch/powerpc/kernel/irq.c
>> patching file arch/powerpc/kernel/process.c
>> Hunk #2 succeeded at 333 with fuzz 2 (offset -11 lines).
>> Hunk #3 succeeded at 973 (offset -11 lines).
>> patching file arch/ppc/Kconfig
>> Hunk #1 succeeded at 980 (offset -32 lines).
>> patching file arch/ppc/boot/Makefile
>> patching file arch/ppc/kernel/Makefile
>> patching file arch/ppc/kernel/entry.S
>> Hunk #5 FAILED at 726.
>> 1 out of 6 hunks FAILED -- saving rejects to file arch/ppc/kernel/entry.S.rej
> 
> Try this patch instead, it fixes the rejects and also makes
> arch/ppc/syslib/xilinx-pic.c Adeos-aware:
> http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.23-ppc-xlnx-1.6-03.patch
> 
> Note: this is a quick hack for the XILINX boards. In theory, this should
> work. In practice, I have no idea if it does. The difference between
> theory and practice is usually called luck as far as I'm concerned. You
> have been warned.
> 


-- 
Philippe.

