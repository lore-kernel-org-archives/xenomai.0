Message-ID: <4FFF33F9.9020000@xenomai.org>
Date: Thu, 12 Jul 2012 22:30:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <B8BB1834-3B77-49F2-8F40-C4801E858698@kabelmail.de>
In-Reply-To: <B8BB1834-3B77-49F2-8F40-C4801E858698@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 on beaglebone (TI AM3359 SoC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org

On 07/12/2012 09:54 PM, Stephan Kappertz wrote:
> OMAP clockevent source: GPTIMER2 at 24000000 Hz
> OMAP clocksource: GPTIMER1 at 32768 Hz
> I-pipe, 0.032 MHz clocksource

This is wrong, normally, you should have something like:
[    0.000000] OMAP clockevent source: GPTIMER2 at 13000000 Hz
[    0.000000] OMAP clocksource: GPTIMER3 at 13000000 Hz
[    0.000000] I-pipe, 13.000 MHz clocksource

This is ensured by this piece of code in arch/arm/mach-omap2/timer.c:
#ifndef CONFIG_IPIPE
OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
#else
OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
#endif

So, my guess is that you have some other patch changing this.

-- 
                                                                Gilles.

