Message-ID: <52D194F4.6030706@xenomai.org>
Date: Sat, 11 Jan 2014 20:01:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
 <52CC7D71.4040703@steinkuehler.net> <52CC83F1.40000@xenomai.org>
 <52CC85C5.4060703@steinkuehler.net> <52CC8A18.2020807@xenomai.org>
 <52CCA101.2040604@steinkuehler.net>
 <3FA64D57-1BB1-4B4A-AB25-AC8E280105F8@mah.priv.at>
 <52D18B7D.5080705@xenomai.org> <52D18D0A.8010905@xenomai.org>
In-Reply-To: <52D18D0A.8010905@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i-pipe tracer on in production kernels? (was Re:
 Altera Cyclone V)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/11/2014 07:27 PM, Gilles Chanteperdrix wrote:
> On 01/11/2014 07:20 PM, Philippe Gerum wrote:
>> On 01/11/2014 11:22 AM, Michael Haberler wrote:
>>>
>>> http://www.xenomai.org/index.php/I-pipe:Tracer describes the trace API, which could be useful to track down issues
>>>
>>> Q: does enabling the tracer incur significant overhead if compiled in but unused, or is it reasonable to leave it on in a production kernel?
>>>
>>> if the former, we might have to build/make available a second i-pipe tracer enabled kernel to track down issues 'in the field'; if the latter, it'd be less build/distribution chores
>>>
>>
>> The I-pipe tracer is based on the ftrace infrastructure, so tracepoints
>> are left out when the tracer is disabled. If you can live with the
>> minimal overhead ftrace adds, then leaving the I-pipe tracer code built
>> in may be an option.
>
> That is less true without DYNAMIC_FTRACE than with DYNAMIC_FTRACE.
>
>

This is about 10% overhead on low-end 52xx, 5-7% on am335x. I did not check on typical x86 < 2 Ghz yet, but this should be around 3-5%. It is just a matter of how much is too much.

Regarding DYNAMIC_FTRACE, we have had this out for too many moons (2.6.2x...), and we need to reconsider this (this looks somewhat like an old writing from an ancient book, nobody really remembers the meaning of - I wonder if I was not the guy who switched this off, out of some nightmare debugging session).

Anyway, enabling it on am335x looks ok at first sight, and I suspect that the usual problem of synchronizing better and harder against the code patching loop is gone.

i.e.

root@android:/ # cat /proc/ipipe/trace/enable                                  
1
root@android:/ # /bin/latency [   93.709690] request_suspend_state: wakeup (0->0) at 93601080338 (2000-01-01 00:54:46.112646335 UTC)
[   93.760153] init: untracked pid 637 exited
[   93.764831] init: untracked pid 638 exited

== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     26.999|     45.833|     72.958|       0|     0|     26.999|     72.958
RTD|     25.749|     47.208|     71.499|       0|     0|     25.749|     72.958
RTD|     25.416|     47.124|     73.333|       0|     0|     25.416|     73.333
RTD|     25.916|     46.541|     72.499|       0|     0|     25.416|     73.333
RTD|     27.124|     47.583|     75.624|       0|     0|     25.416|     75.624
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     25.416|     46.833|     75.624|       0|     0|    00:00:05/00:00:05
root@android:/ # echo 0 > /proc/ipipe/trace/enable                             
root@android:/ # /bin/latency                                                  
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     -3.209|     21.291|     57.499|       0|     0|     -3.209|     57.499
RTD|      0.000|     26.666|     53.208|       0|     0|     -3.209|     57.499
RTD|      2.291|     19.041|     57.958|       0|     0|     -3.209|     57.958
RTD|      0.999|     16.541|     56.624|       0|     0|     -3.209|     57.958
RTD|      2.333|     17.291|     51.958|       0|     0|     -3.209|     57.958
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -3.209|     20.166|     57.958|       0|     0|    00:00:05/00:00:05
root@android:/ # [  116.008470] request_suspend_state: wakeup (0->0) at 115899865474 (2000-01-01 00:55:08.411433263 UTC)
[  116.027659] init: untracked pid 898 exited
[  116.039731] init: untracked pid 899 exited


-- 
Philippe.

