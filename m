Date: Thu, 9 Jul 2015 16:19:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150709141922.GG20176@hermes.click-hack.org>
References: <559E65FB.8080904@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559E65FB.8080904@sigmatek.at>
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

On Thu, Jul 09, 2015 at 02:15:55PM +0200, Johann Obermayr wrote:
> Hello,
> 
> we have follow situation
> 
> u64 lrtdrv_time_of_irq_ns ;
> void worker_task()
> {
> while(1)
>     {
>     rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull,
> RTDM_TIMERMODE_ABSOLUTE);
>     do_something();
>     }
> }
> 
> _kernel_rtdm_irq_handler()
> {
>     lrtdrv_time_of_irq_ns = rtdm_clock_read_monotonic();
> }
> 
> the  _kernel_irq_callback() is called every 1ms.
> we will , that the worker_task begin 50us before next irq
> 
> But sometime, the worker task start ~50us after irq. Why ?

Best way to know, enable the I-pipe tracer, setup sufficient back
trace points, and when the wrong wake up happens, trigger an I-pipe
trace.

> 
> Sometime we call xntbase_adjust_time to sync external RTC with internal
> clocks.
> can this be a problem ?

Normally, xntbase_adjust_time has no influence whatsoever on the
monotonic time. However, I suppose if you have an awful lot of
pending timers with absolute wall clock expiration dates, the
adjustment made by xntbase_adjust_time could create a large masking
section.

-- 
					    Gilles.
https://click-hack.org

