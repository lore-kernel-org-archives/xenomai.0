From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 21:32:27 -0400
Message-ID: <20140401013227.GA17765@csclub.uwaterloo.ca>
References: <20140331205339.GU17765@csclub.uwaterloo.ca>
 <20140331205710.GV17765@csclub.uwaterloo.ca>
 <5339D8EB.3030702@xenomai.org>
 <20140331212534.GW17765@csclub.uwaterloo.ca>
 <5339E2CE.7060703@xenomai.org>
 <20140331215348.GX17765@csclub.uwaterloo.ca>
 <20140331215933.GY17765@csclub.uwaterloo.ca>
 <20140331220421.GZ17765@csclub.uwaterloo.ca>
 <5339E80C.9020604@xenomai.org> <5339EBE1.3060907@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5339EBE1.3060907@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Apr 01, 2014 at 12:27:45AM +0200, Gilles Chanteperdrix wrote:
> Ok, arch_counter_set_user_access disables user access to the 
> architected timer counter. The following patch should avoid this:
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index b605f04e..7aea949 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -374,7 +374,9 @@ static int arch_timer_setup(struct clock_event_device *clk)
>  			enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
>  	}
>  
> +#ifndef CONFIG_IPIPE
>  	arch_counter_set_user_access();
> +#endif
>  
>  	return 0;
>  }

That might have taken me a while to track down.  Excellent work.

root@omap5:~# /usr/lib/xenomai/testsuite/latency 
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.163|      0.488|      3.743|       0|     0|     -0.163|      3.743
RTD|     -0.652|      0.000|      3.092|       0|     0|     -0.652|      3.743
RTD|     -0.652|      0.000|      2.929|       0|     0|     -0.652|      3.743
RTD|     -0.652|      0.000|      2.929|       0|     0|     -0.652|      3.743
RTD|     -0.652|      0.325|      3.255|       0|     0|     -0.652|      3.743
RTD|     -0.652|      0.000|      2.929|       0|     0|     -0.652|      3.743
RTD|     -0.489|      0.162|      3.743|       0|     0|     -0.652|      3.743
RTD|     -0.652|      0.000|      2.929|       0|     0|     -0.652|      3.743
RTD|     -0.652|      0.000|      3.092|       0|     0|     -0.652|      3.743
RTD|     -0.652|      0.325|      3.906|       0|     0|     -0.652|      3.906
RTD|     -0.652|      0.000|      3.255|       0|     0|     -0.652|      3.906
RTD|     -0.652|      0.000|      2.278|       0|     0|     -0.652|      3.906
RTD|     -2.442|      0.000|      2.604|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.162|      3.255|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.325|      3.092|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      3.255|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      3.743|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.325|      3.417|       0|     0|     -2.442|      3.906
RTD|     -1.954|      0.000|      3.255|       0|     0|     -2.442|      3.906
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.766|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.766|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.325|      3.092|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.766|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      3.092|       0|     0|     -2.442|      3.906
RTD|     -1.465|      0.000|      2.929|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.325|      3.580|       0|     0|     -2.442|      3.906
RTD|     -1.628|      0.000|      3.092|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      2.766|       0|     0|     -2.442|      3.906
RTD|     -0.652|      0.000|      3.092|       0|     0|     -2.442|      3.906
RTD|     -0.489|      0.325|      4.231|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      3.580|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      2.766|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      2.604|       0|     0|     -2.442|      4.231
RTD|     -1.303|      0.000|      3.417|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.325|      3.743|       0|     0|     -2.442|      4.231
RTD|     -1.954|      0.000|      2.929|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      2.441|       0|     0|     -2.442|      4.231
RTT|  00:00:43  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.325|      3.417|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      2.604|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      2.929|       0|     0|     -2.442|      4.231
RTD|     -0.652|      0.000|      3.092|       0|     0|     -2.442|      4.231
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -2.442|      0.000|      4.231|       0|     0|    00:00:48/00:00:48

mutex torture tests now pass, cond tests pass, most things seem to pass,
but I think the failing ones need either modules enabled I didn't enable,
or maybe special hardware.

Any recommended way to test if things are really working now?

-- 
Len Sorensen

