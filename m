Message-ID: <50814532.5090408@xenomai.org>
Date: Fri, 19 Oct 2012 14:18:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50812949.5040403@openwide.fr>
In-Reply-To: <50812949.5040403@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] s3c24xx with clocksource/clockevent (kernel 3.2.21)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 10/19/2012 12:19 PM, Romain Naour wrote:
> Hi Gilles,
> 
> First, I followed your advice and I converted the timers to 
> clocksouce/clockevent framework.
>> Other things which could be done for s3c24xx are:
>> - convert the timers to clocksource/clockevent: since this platform is
>> the only one not to use clocksource/clockevent, we have to keep code
>> around for this case in xenomai-forge which could be removed. Having two
>> different timers for clocksource and clockevent would allow to avoid the
>> tsc emulation based on the decrementer, which I am not sure is really
>> reliable since the conversion to CONFIG_IPIPE_ARM_KUSER_TSC.
> I had to reduce timers frequency to 4,21MHz in order to produce an 
> timer's overflow every 15,5ms.

For such overflow period, I would recommend running __ipipe_update_tsc
in the acktimer routine.

> At 8,45Mhz it does not work.
> Thanks to this, I am able to activate hrtimer on Linux :)
> 
> Secondly, I adapted the code for Adeos (Xenomai 2.6.1).
> But I'm not sure about the tsc emulation...
> Should I keep using the IPIPE_TSC_TYPE_DECREMENTER ?
> Do you think we need something like 
> IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN_16 ?

The type should correspond to the type of the hardware timer you are
using, I do not know if you are using the decrementer as clocksource, or
a separate freerunning countdown timer, so, I can not answer. You should
run tsc -w to see if the tsc is wrapping correctly.

> 
> In order to adjust scheduling latency, I set /proc/xenomai/latency to 0
> But I still have negative latency
> 
> (test-latency.txt)
> # echo 0 >/proc/xenomai/latency
> # latency
> == Sampling period: 1000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
> best|--lat worst
> RTD|     -0.238|     16.592|     57.599|       0|     0| -0.238|     57.599
> RTD|      5.925|     16.829|     83.911|       0|     0| -0.238|     83.911
> RTD|      5.688|     16.829|     78.696|       0|     0| -0.238|     83.911
> RTD|      5.688|     16.829|     80.355|       0|     0| -0.238|     83.911
> RTD|      5.925|     17.066|     75.140|       0|     0| -0.238|     83.911
> RTD|     -0.712|     18.251|     84.622|       0|     0| -0.712|     84.622
> RTD|      5.925|     16.829|     76.088|       0|     0| -0.712|     84.622
> RTD|      5.688|     16.829|     73.481|       0|     0| -0.712|     84.622
> ...
> 
> Can you tell me If this seems good.

You can look at /proc/xenomai/timer to see if the timer calibration does
not give a too large value. As a general advice, the "set_next_event"
callback should make as few register accesses as possible, sometimes
register accesses may be slow.

> 
> Finally, I add a last patch because I had a problem with the debug port.
> The Tx IRQ was not unmasked by root domain in some circumstances.
> Therefore, the debug console hangs when you type "dmesg", "ls"...
> kernel 2.6.38.8 is not affected by this bug, but i found It with kernel 
> 3.0.36.

That is a nice work, however working with 3.0 was maybe not the best
choice. Please:
- upgrade to the latest linux version (3.7) and post your patches
(converting to clockevent/clocksource) on the linux arm kernel mailing
list, you will probably go over several iterations before the patches
are accepted;
- when they are accepted, backport them to the latest version of the
I-pipe kernel (it is currently 3.4, but could be 3.5 soon).

Note that moving the clockevent/clocksource code to 3.7 is probably not
a lot of work, and getting this work integrated in mainline means that
you can benefit from other people using and testing the code you wrote.

We currently have an up to date documentation on how to port the I-pipe
patch to a new arm board for such recent versions:
http://xenomai.org/index.php/I-pipe-core:ArmPorting

-- 
					    Gilles.

