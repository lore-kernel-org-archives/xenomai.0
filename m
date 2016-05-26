Date: Thu, 26 May 2016 18:28:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160526162808.GB2842@hermes.click-hack.org>
References: <CAJ2oMhL-7pF+3ZCHy_yA1OiFo-O327PGwL=Sy8g9-h8JZ0YNDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhL-7pF+3ZCHy_yA1OiFo-O327PGwL=Sy8g9-h8JZ0YNDw@mail.gmail.com>
Subject: Re: [Xenomai] "watchdog triggered" error & irq interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Thu, May 26, 2016 at 06:57:49PM +0300, Ran Shalit wrote:
> Hello,
> 
> On testing interrupt within kernel it seems to work ok.
> I then moved to userspace rt thread waiting on events coming from the
> rtfm kernel driver (witch signals with rtd_event_signal)
> 
> But then I get the following errors:
> 
> dma0chan1-copy0: #15195: got completion callback, but status is 'in progress'
> dma0chan3-copy0: #14335: test timed out
> dma0chan3-copy0: #14336: got completion callback, but status is 'in progress'
> Xenomai: watchdog triggered -- signaling runaway thread 'rtdm'
> [sched_delayed] sched: RT throttling activated
> Xenomai: RTDM: closing file descriptor 0.
> CPU time limit exceeded
> 
> I understand that it mean that cpu is probably in busy wait.
> The interrupt is done on raising edge, and I configure it as following:
> rtdm driver:
> ========
> ret = rtdm_irq_request(&ctx->irq_handle,
>  91, PFI_IRQHandler, RTDM_IRQTYPE_EDGE,
>  DRVNAM, ctx);
> 
> userspace real-time thread
> ===============
> 
> while (1) {
>     rt_printf("11\n");
>     if (ioctl(file_desc, RTTST_RTIOC_GPIOIRQ_WAIT_IRQ))
>     {
>            rt_printf("failed!");
>      };
>      rt_printf("22\n");

If what follows is what is necessary to acknowledge the irq at the
device level, it has to be done in the interrupt handler. Otherwise
when the interrupt handler has finished executing, interrupts are
enabled, and the interrupt triggers again, leaving no chance to the
interrupt handler to run. Alternatively, you may want to disable the
interrupt line in the interrupt handler and reenable it after the
thread has run. Note however that it increases the time necessary to
handle the interrupt and may result in lost interrupts (if they
happen while the line is masked).

>       mymmap[0xe4] = 1;  //mymmap is memory mapped io to 0x80010000
>       writel(1, rtdm_fpga_base_addr + 0xe4);
>       g_value[g_index] = readl( rtdm_fpga_base_addr+ 0x8010);
>      pCnt = &(ledRegister[0x8010]);
>       mymmap[0xe4] = 0;
> 
>    }
> 
> I've been debugging it for some hours in vain. I have no idea, any
> suggestion will help.
> 
> complete sources (driver & app)
> https://drive.google.com/folderview?id=0B22GsWueReZTS3RaV3gzRk9aZzQ&usp=sharing

This code is crap. If you want people to review your code, please
make it short and remove the cruft that you do not use, and remove
the dead code too. As I already told you, you should start from the
"skeleton" code, not from the RTDM test driver which is a unit test
for the RTDM API.

-- 
					    Gilles.
https://click-hack.org

