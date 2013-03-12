Message-ID: <513EB578.9040904@xenomai.org>
Date: Tue, 12 Mar 2013 05:56:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512BFD9E.5010501@crubille.lautre.net>
	<512BE5A2.3090505@xenomai.org>
	<513DA0B5.5060304@crubille.lautre.net>
	<513D8C24.4010009@xenomai.org> <513E5F09.30600@crubille.lautre.net>
In-Reply-To: <513E5F09.30600@crubille.lautre.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux port to ARM Allwinner A13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul@crubille.lautre.net>
Cc: xenomai@xenomai.org

On 03/11/2013 11:47 PM, Paul wrote:

> Some precision and 2 small examples about a preempt test:
> 
> On 11/03/2013 08:47, Gilles Chanteperdrix wrote:
>> On 03/11/2013 10:15 AM, Paul wrote:
>>
>>> Hello,
>>>
>>> ... ... ...
>>>
>>> I check the priority masking with a preempt test which is derived
>>> from the latency test: The real time task loop for 1/4 of its period
>>> reading and rereading the clock, so i get the min, avg and worst case
>>> that the task can be preempted while it is running.
>>
>>> If you are interested in this test, i can post it when I have
>>> modified the output messages.
>>
>>
>> I do not really understand. Why would it be more preempted in the first
>> 1/4 of its period?
>>
>>
> No reason sure but -
>   It can be preempted only while it is running, so between the time it 
> is restarted after sleeping and before it go to sleep again.
> Let it running 1/4 of the period is enough to catch lots of events if 
> there is lots of irqs but not too much so linux, dohell or even xenomai 
> tasks can run just a bit slower.
> 
> 
> Here are some result i get (yes with the priority interrupt masking, and 
> i am pretty sure it work - but the watchdog is on).
> There is a dohell at the same time in the whole experiment and i start 
> X11, stop it , restart it  ...
> 
> 
> root@debian:/usr/xenomai/bin# 
> /usr/src/build_xenomai/src/testsuite/preempt/preempt -p 111
> == Sampling period: 111 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 111 us period, priority 99)
> RTH|----pre min|----pre avg|----pre max|-overrun|---msw|---pre 
> best|--pre worst
> RTD|      0.333|      0.374|      3.333|       0|     0|      
> 0.333|      3.333
> RTD|      0.333|      0.374|     15.666|       0|     0|      0.333|     
> 15.666
> ---|-----------|-----------|-----------|--------|------|-------------------------
> 
> RTH|----pre min|----pre avg|----pre max|-overrun|---msw|---pre 
> best|--pre worst
> RTD|      0.333|      0.374|      3.708|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.874|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.541|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.916|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.541|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.583|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.499|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.833|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.791|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.666|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.833|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.749|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.749|       0|     0|      0.333|     
> 23.333
> RTD|      0.333|      0.374|      3.624|       0|     0|      0.333|     
> 23.333
> ^C---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|      0.333|      0.374|     23.333|       0|     0|    
> 00:13:33/00:13:33
> 
> 
> A second experiment, just setting the period to 100 (and the period for 
> the watchdog is a multiple so 3/4 it never preempt the task:


Looks only like pure luck to me. As you may or may not know, Xenomai
uses the timer in one-shot mode, so, the watchdog tick has no reason to
be aligned with your application timer. I would say the chances for your
task to be preempted by the watchdog tick while it is measuring is 1/4...


-- 
                                                                Gilles.

