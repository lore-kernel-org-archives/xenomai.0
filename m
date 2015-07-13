Date: Mon, 13 Jul 2015 21:58:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150713195856.GA1552@hermes.click-hack.org>
References: <20150710094655.GS20176@hermes.click-hack.org>
 <559FA1D1.6060602@sigmatek.at>
 <20150710104957.GT20176@hermes.click-hack.org>
 <55A3C023.5070000@sigmatek.at>
 <20150713140208.GC1554@hermes.click-hack.org>
 <55A3D1B2.50905@sigmatek.at>
 <e5d48b6984cbc1b098062b303b56b0db.squirrel@sourcetrek.com>
 <55A3EE26.5070802@sigmatek.at>
 <7413ead94cb8c4f3a91d1288a27103c9.squirrel@sourcetrek.com>
 <55A3F4B3.1090908@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55A3F4B3.1090908@sigmatek.at>
Subject: Re: [Xenomai] usage of rtdm_task_sleep_abs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: xenomai@xenomai.org

On Mon, Jul 13, 2015 at 07:26:11PM +0200, Johann Obermayr wrote:
> Am 13.07.2015 um 19:21 schrieb Gilles Chanteperdrix:
> >Johann Obermayr wrote:
> >>Am 13.07.2015 um 17:24 schrieb Gilles Chanteperdrix:
> >>>Johann Obermayr wrote:
> >>>>without your application, there are no large latencies.
> >>>>with your application see frozen.txt (with latency -f)
> >>>I am confused. You mean "our application", not "your application",
> >>>right?
> >>>lrtdrv_monitoring_irq is not part of the code delivered by the Xenomai
> >>>project.
> >>>
> >>>>We see the problem only if one task (background) is accessing the SRAM
> >>>>on your PCI-Card. if we stop this task, all is ok.
> >>>Again: the Xenomai project does not make PCI-card. So, you probably mean
> >>>"our PCI-Card"?
> >>yes, our PCI-Card. (sorry for my bad english)
> >>>>So we have a higher prior task (pci-locker), that interrupt the
> >>>>background task, so that the pci bus get free.
> >>>I am not sure I understand your explanations. But the trace is pretty
> >>>clear:
> >>>
> >>>At time -658 the timer is programmed to tick at -561.
> >>>
> >>>>:|  # event   tick@-561   -658	  0.112  xntimer_next_local_shot+0xca
> >>>>:|  + func                -651	  0.145  lrtdrv_monitoring_irq+0x4
> >>>>[sigmatek_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
> >>>>:|  + end     0x000000ef  -651! 641.640  apic_timer_interrupt+0x52
> >>>>(<102d0254>)
> >>>But at that point the tick is delayed for 600us. And according to the
> >>>trace, the last traced function called before that delay is the function
> >>>
> >>>ltdrv_monitoring_irq.
> >>>
> >>>So, I do not know what this irq is doing, but I would suggest having a
> >>>close look at it.
> >>>
> >>>
> >>hello,
> >>
> >>i have disable our lrtdrv_monitoring_irq.
> >>Only have this callback
> >>static void irq_hook_handler(unsigned int irq, unsigned int state)
> >>{
> >>      if (fpga_interrupt == irq && state == 0x01)
> >>      {
> >>          time_fpga_irq = rt_timer_tsc();
> >>      }
> >>}
> >>same latency
> >Maybe, but your trace does not contain enough points to see it. The trace
> >should at least contain the "tick@" event which gets missed, so that we
> >can see how much the interrupt is delayed, and what was happening at the
> >time.
> >
> >
> Hi,
> 
> Sorry, here with more points.

Ok, what is irq_hook_handler ?

-- 
					    Gilles.
https://click-hack.org

