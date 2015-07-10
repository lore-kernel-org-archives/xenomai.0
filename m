Date: Fri, 10 Jul 2015 12:49:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150710104957.GT20176@hermes.click-hack.org>
References: <559E65FB.8080904@sigmatek.at>
 <20150709141922.GG20176@hermes.click-hack.org>
 <559E9687.6020109@sigmatek.at>
 <20150709155115.GK20176@hermes.click-hack.org>
 <559F91C3.8090005@sigmatek.at>
 <20150710094655.GS20176@hermes.click-hack.org>
 <559FA1D1.6060602@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559FA1D1.6060602@sigmatek.at>
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

On Fri, Jul 10, 2015 at 12:43:29PM +0200, Johann Obermayr wrote:
> Am 10.07.2015 um 11:46 schrieb Gilles Chanteperdrix:
> >On Fri, Jul 10, 2015 at 11:34:59AM +0200, Johann Obermayr wrote:
> >>Am 09.07.2015 um 17:51 schrieb Gilles Chanteperdrix:
> >>>On Thu, Jul 09, 2015 at 05:43:03PM +0200, Johann Obermayr wrote:
> >>>>Am 09.07.2015 um 16:19 schrieb Gilles Chanteperdrix:
> >>>>>On Thu, Jul 09, 2015 at 02:15:55PM +0200, Johann Obermayr wrote:
> >>>>>>Hello,
> >>>>>>
> >>>>>>we have follow situation
> >>>>>>
> >>>>>>u64 lrtdrv_time_of_irq_ns ;
> >>>>>>void worker_task()
> >>>>>>{
> >>>>>>while(1)
> >>>>>>     {
> >>>>>>     rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull,
> >>>>>>RTDM_TIMERMODE_ABSOLUTE);
> >>>>>>     do_something();
> >>>>>>     }
> >>>>>>}
> >>>>>>
> >>>>>>_kernel_rtdm_irq_handler()
> >>>>>>{
> >>>>>>     lrtdrv_time_of_irq_ns = rtdm_clock_read_monotonic();
> >>>>>>}
> >>>>>>
> >>>>>>the  _kernel_irq_callback() is called every 1ms.
> >>>>>>we will , that the worker_task begin 50us before next irq
> >>>>>>
> >>>>>>But sometime, the worker task start ~50us after irq. Why ?
> >>>>>Best way to know, enable the I-pipe tracer, setup sufficient back
> >>>>>trace points, and when the wrong wake up happens, trigger an I-pipe
> >>>>>trace.
> >>>>>
> >>>>i will enable i-pipe tracer.
> >>>>found out, that
> >>>>
> >>>>rtdm_task_sleep_abs(xxx, RTDM_TIMERMODE_ABSOLUTE);
> >>>>u64 calc = rtdm_clock_read_monotonic();
> >>>>
> >>>>sometime the diff between xxx & calc is biger than 61000ns.
> >>>This is called "kernel task scheduling latency". It can be measured by
> >>>the latency -t 1 test.
> >>Ok, i will test it with this test.
> >>Here a simple list of measure from  rtdm_task_sleep_abs(xxx) calc =
> >>rtdm_clock_read_monotonic
> >Yeah, latency -t 1 does that too. Only much better.
> >
> Result a) only latency -t 1
> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> RTD|     -2.618|     -2.481|     -2.384|       0|     0| -2.618|     -2.384
> RTD|     -2.506|     -2.477|     -2.301|       0|     0| -2.618|     -2.301
> RTD|     -2.590|     -2.479|     -2.192|       0|     0| -2.618|     -2.192
> RTD|     -2.517|     -2.489|     -2.324|       0|     0| -2.618|     -2.192
> RTD|     -2.612|     -2.490|     -2.335|       0|     0| -2.618|     -2.192
> RTD|     -2.723|     -2.490|     -2.300|       0|     0| -2.723|     -2.192
> RTD|     -2.521|     -2.491|     -2.332|       0|     0| -2.723|     -2.192
> RTD|     -2.624|     -2.492|     -2.346|       0|     0| -2.723|     -2.192
> RTD|     -2.520|     -2.490|     -2.341|       0|     0| -2.723|     -2.192
> RTD|     -2.584|     -2.490|     -2.353|       0|     0| -2.723|     -2.192
> RTD|     -2.521|     -2.487|     -2.333|       0|     0| -2.723|     -2.192
> RTD|     -2.521|     -2.490|     -2.329|       0|     0| -2.723|     -2.192
> RTD|     -2.519|     -2.488|     -1.946|       0|     0| -2.723|     -1.946
> RTD|     -2.521|     -2.490|     -2.353|       0|     0| -2.723|     -1.946
> RTD|     -2.605|     -2.490|     -2.343|       0|     0| -2.723|     -1.946
> RTD|     -2.521|     -2.490|     -2.328|       0|     0| -2.723|     -1.946
> RTD|     -2.568|     -2.489|     -2.337|       0|     0| -2.723|     -1.946
> RTD|     -2.520|     -2.490|     -2.329|       0|     0| -2.723|     -1.946
> RTD|     -2.553|     -2.491|     -2.337|       0|     0| -2.723|     -1.946
> RTD|     -2.521|     -2.491|     -2.325|       0|     0| -2.723|     -1.946
> RTD|     -2.521|     -2.490|     -2.341|       0|     0| -2.723|     -1.946
> 
> Result b) with our application, that copy with a releaxed task from/to a
> SRAM on a PCI Card.
> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
> RTH|---lat min|---lat avg|----lat max|-overrun|---msw|---lat best|--lat
> worst
> RTD|     -2.680|     -1.537|    716.496|       38|     0| -2.680|    716.496
> RTD|     -2.680|     -1.414|    691.232|       81|     0| -2.680|    716.496
> RTD|     -3.051|     -0.877|    739.939|     120|     0| -3.051|    739.939
> RTD|     -2.662|     -1.422|    738.747|     160|     0| -3.051|    739.939
> RTD|     -2.713|     -1.637|    726.880|     191|     0| -3.051|    739.939
> RTD|     -2.656|     -1.044|    675.880|     218|     0| -3.051|    739.939
> RTD|     -2.655|     -1.269|    753.354|     251|     0| -3.051|    753.354
> RTD|     -2.661|     -1.344|    633.684|     301|     0| -3.051|    753.354
> RTD|     -2.663|     -1.626|    698.008|     333|     0| -3.051|    753.354
> RTD|     -2.662|     -0.579|    751.352|     379|     0| -3.051|    753.354
> RTD|     -2.669|     -1.455|    733.275|     410|     0| -3.051|    753.354
> RTD|     -2.758|     -1.670|    629.569|     434|     0| -3.051|    753.354
> RTD|     -2.760|     -1.686|    690.451|     445|     0| -3.051|    753.354
> RTD|     -2.668|     -1.032|    753.099|     483|     0| -3.051|    753.354
> RTD|     -2.661|     -1.476|    735.519|     518|     0| -3.051|    753.354
> RTD|     -2.660|     -1.647|    725.828|     552|     0| -3.051|    753.354
> RTD|     -2.661|     -1.236|    250.879|     556|     0| -3.051|    753.354

Your application (and more probably driver) has a problem, it
probably creates large interrupts masking section. Once again, to
understand what the problem is, I suggest using the I-pipe tracer.

-- 
					    Gilles.
https://click-hack.org

