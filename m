Date: Fri, 10 Jul 2015 11:46:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150710094655.GS20176@hermes.click-hack.org>
References: <559E65FB.8080904@sigmatek.at>
 <20150709141922.GG20176@hermes.click-hack.org>
 <559E9687.6020109@sigmatek.at>
 <20150709155115.GK20176@hermes.click-hack.org>
 <559F91C3.8090005@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559F91C3.8090005@sigmatek.at>
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
Cc: Xenomai@xenomai.org

On Fri, Jul 10, 2015 at 11:34:59AM +0200, Johann Obermayr wrote:
> Am 09.07.2015 um 17:51 schrieb Gilles Chanteperdrix:
> >On Thu, Jul 09, 2015 at 05:43:03PM +0200, Johann Obermayr wrote:
> >>Am 09.07.2015 um 16:19 schrieb Gilles Chanteperdrix:
> >>>On Thu, Jul 09, 2015 at 02:15:55PM +0200, Johann Obermayr wrote:
> >>>>Hello,
> >>>>
> >>>>we have follow situation
> >>>>
> >>>>u64 lrtdrv_time_of_irq_ns ;
> >>>>void worker_task()
> >>>>{
> >>>>while(1)
> >>>>     {
> >>>>     rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull,
> >>>>RTDM_TIMERMODE_ABSOLUTE);
> >>>>     do_something();
> >>>>     }
> >>>>}
> >>>>
> >>>>_kernel_rtdm_irq_handler()
> >>>>{
> >>>>     lrtdrv_time_of_irq_ns = rtdm_clock_read_monotonic();
> >>>>}
> >>>>
> >>>>the  _kernel_irq_callback() is called every 1ms.
> >>>>we will , that the worker_task begin 50us before next irq
> >>>>
> >>>>But sometime, the worker task start ~50us after irq. Why ?
> >>>Best way to know, enable the I-pipe tracer, setup sufficient back
> >>>trace points, and when the wrong wake up happens, trigger an I-pipe
> >>>trace.
> >>>
> >>i will enable i-pipe tracer.
> >>found out, that
> >>
> >>rtdm_task_sleep_abs(xxx, RTDM_TIMERMODE_ABSOLUTE);
> >>u64 calc = rtdm_clock_read_monotonic();
> >>
> >>sometime the diff between xxx & calc is biger than 61000ns.
> >This is called "kernel task scheduling latency". It can be measured by
> >the latency -t 1 test.
> 
> Ok, i will test it with this test.
> Here a simple list of measure from  rtdm_task_sleep_abs(xxx) calc =
> rtdm_clock_read_monotonic

Yeah, latency -t 1 does that too. Only much better.

> >Are you sure that the tsc is synchronized on both cores (you did not
> >give us much information, in particular we do not know on what
> >hardware you have this issue).
> >
> tsc must be sync, because most time it is correct.

Bad reasoning. The time may be good when the interrupt happens on
the same core as the one where the waiting task is running, and bad
when both do not happen on the same cpu.

-- 
					    Gilles.
https://click-hack.org

