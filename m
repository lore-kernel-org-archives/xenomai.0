Message-ID: <5009902B.7070705@xenomai.org>
Date: Fri, 20 Jul 2012 19:06:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21B0B94DE9@mary.at.omicron.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai 2.6.1 on ixp4xx hangs on boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Lausch <michael.lausch@omicron.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/19/2012 01:27 PM, Michael Lausch wrote:
> Hi,
> I'm trying to get xenomai-2.6.1 running on an ixp4xx board
> with kernel 3.2.21.
> 
> The kernel boots with Xenomai and IPIPE disabled in the kernel configuration.
> 
> The kernel also boots with Xenmai disabled and IPIPE enabled.
> 
> But the kernel does not boot correctly with both, Xenomai and IPIPE enabled.
> 
> Using a JTAG debugger i found that the kernel always hits a breakpoint
> On xnintr_clock_handler() with this backtrace:
> 
>  #1  0xc00516b8 in __ipipe_dispatch_irq_fast (irq=5) at kernel/ipipe/core.c:1272
> #2  0xc00083b0 in __ipipe_grab_irq (irq=<optimized out>, regs=0xc381ff30) at arch/arm/kernel/ipipe.c:458
> #3  0xc0008db0 in __irq_svc () at arch/arm/kernel/entry-armv.S:216
> 
> The last line is repeated very often, but i think this is just a gdb artefact.
> The kernel seems to loop in __irq_svc->__ipipe_grab_irq->__irq_svc.
> Maybe the timer interrupt is not cleared and therefore executed as soon as the
> IRQ service function finishes?

Please try the following patch:

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index f4b878e..cafa9fa 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -593,6 +593,7 @@ static void ixp4xx_set_mode(enum clock_event_mode mode,
 static struct ipipe_timer ixp4xx_itimer = {
        .irq = IRQ_IXP4XX_TIMER1,
        .min_delay_ticks = 333, /* 5 usec with the 66.66 MHz system clock */
+       .ack = ixp4xx_timer_ack,
 };
 #endif /* CONFIG_IPIPE */



-- 
                                                                Gilles.

