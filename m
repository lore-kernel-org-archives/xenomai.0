Message-ID: <4F7C183F.5040009@domain.hid>
Date: Wed, 04 Apr 2012 11:45:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid> <4F560A6C.2080306@domain.hid>
	<4F560B76.5080606@domain.hid> <4F5629D2.50304@domain.hid>
	<4F562B53.7070400@domain.hid> <4F562EC2.6040604@domain.hid>
	<4F56387B.40702@domain.hid> <4F575BA3.7060404@domain.hid>
	<4F576622.1030509@domain.hid> <4F57A567.7030008@domain.hid>
	<4F7C127D.2010400@domain.hid> <4F7C1484.5090406@domain.hid>
In-Reply-To: <4F7C1484.5090406@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 04/04/2012 11:29 AM, Roberto Bielli wrote:
> Hi Gilles,
> 
> i have always this big problem but the timer and the avic are programmed 
> correctly.
> There is something else but i don't know what.
> In this moment i'm doing another work but soon i want to debug that error.

It is undoubtly a timer ack/program issue. There is no other problem,
the trace is quite clear: the timer is programmed, should tick, but
does not.

I had a look at the imx code again for other reasons, what may be also
missing in __ipipe_mach_acktimer function is a read of the timer status
register. As in:

void __ipipe_mach_acktimer(void)
{
        uint32_t tstat;

        if (timer_is_v2())
                tstat = __raw_readl(timer_base + V2_TSTAT);
        else
                tstat = __raw_readl(timer_base + MX1_2_TSTAT);

        gpt_irq_acknowledge();
}

And put that piece of code in mxc_timer_interrupt in the #ifndef
CONFIG_IPIPE section.

You may also want to issue a register read after programming the
compare register. As in:


void __ipipe_mach_set_dec(unsigned long delay)
{
         if (delay > mxc_min_delay) {
                 unsigned long tcmp;
 
                 if (!timer_is_v2()) {
                         tcmp = __raw_readl(timer_base + MX1_2_TCN) + delay;
                         __raw_writel(tcmp, timer_base + MX1_2_TCMP);
                         __raw_readl(timer_base + MX1_2_TCN);
                 } else {
                         tcmp = __raw_readl(timer_base + V2_TCN) + delay;
                         __raw_writel(tcmp, timer_base + V2_TCMP);
                         __raw_readl(timer_base + V2_TCN);
                 }
         } else
                 ipipe_trigger_irq(__ipipe_mach_timerint);
}

-- 
					    Gilles.

