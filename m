Message-ID: <4844FDB5.9020208@domain.hid>
Date: Tue, 03 Jun 2008 10:15:49 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <794283247@domain.hid>
In-Reply-To: <794283247@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] still verification problems
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
> 
> I still have problems with 2 tests of the testsuite:
> irqloop doesn't seem to work:
> -------------------------------------
> bash-3.00# irqbench/irqloop
> Test mode:    user-space task
> Port type:    serial
> Port address: 0x3f8
> Port IRQ:     4
> 
> Received IRQs:     0
> Acknowledged IRQs: 0
> bash-3.00# 
> ------------------------------------

Hm, irqloop is from the irqbench test suite requiring a special setup
and does not make sense on non X86 systems: See

http://www.rts.uni-hannover.de/xenomai/lxr/source/doc/txt/irqbench.txt

> latency in kernel mode fails
> -----------------------------------
> bash-3.00# latency/latency -t1
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25
> ---|------------|------------|------------|--------|-------------------------
> RTS|  267928.028|  805352.732|      32.768|       0|    00:00:40/00:00:40
> bash-3.00# 
> -----------------------------------------------------------------------------------
> 
> if nobody can give me hints (modules are loaded) where to look for the errors, maybe somebody can
> send me the manpages. I heard they are availible for debian unstable users, but
> I would have to download and in stall it, just for this reason, so maybe someone
> can manage to download and send them to me.

You can find the error codes here:

http://www.xenomai.org/index.php/Resolving_Error_Codes
http://lxr.linux.no/linux/include/asm-generic/errno-base.h
http://lxr.linux.no/linux/include/asm-generic/errno.h

Most likely the corresponding driver modules for timer testing is not
loaded or linked into the kernel.

> Can I assume, if all the tests in the testsuite work, that everything works fine? Sure there won't be a
> 100% guarantee, but I would do anything to make sure, that later errors won't have there source in
> an non working Linux/Xenomai.

It's at least a good sign.

Wolfgang.

