From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
 <20150220225712.GE2356@hermes.click-hack.org>
 <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
 <54EF5E45.30907@xenomai.org> <44a900eaqu.fsf@lowell-desk.lan>
 <54EF8115.6030200@xenomai.org>
Date: Thu, 26 Feb 2015 17:55:46 -0500
In-Reply-To: <54EF8115.6030200@xenomai.org> (Philippe Gerum's message of "Thu, 
 26 Feb 2015 21:24:53 +0100")
Message-ID: <44wq34cmfh.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> On 02/26/2015 08:25 PM, Lowell Gilbert wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>>> On 02/26/2015 05:38 PM, Lowell Gilbert wrote:
>>> The new task will be pinned to the CPU running rtdm_task_init() by
>>> default, which is likely CPU0 as well.
>>>
>>> To check this, I would set the global Xenomai affinity to CPU1 before
>>> starting the test, so that your driver task ends up there.
>>>
>>> # echo 2 > /proc/xenomai/affinity
>> 
>> Yes, I initialize that already. And give "isolcpus=1" to the kernel so
>> that Linux will not schedule anything else on CPU1.
>> 
>>> At least you would have the timing IRQ and the task on a different CPU,
>>> leaving some cycles to the latter. This said, 10 us between timer shots
>>> is really too fast.
>> 
>> Having enough cycles for this isn't my fundamental problem. Running
>> everything in the ISR has no trouble keeping up with the 100kHz data
>> flow. The problem comes in a *non* real-time task, which is pulling data
>> in from an IP socket and pushing it into a queue for the real-time code
>> to use synchronously.
>
> Could you determine whether the bottleneck is due to the IP stack being
> starved from incoming packets? Or, is the contention observed between
> the non rt task and the real-time code consuming it?

The socket builds up a large backlog in its receive buffers, so the data
is certainly arriving in RAM but not being processed.

I am assuming that the contention is between the producer and the
consumer. I haven't definitively proven it, but because they are (a) on
different cores and (b) each runs with more than sufficient speed if the
other doesn't, I'm fairly sure.

> Since ethernet IRQs are of the SPI kind, the IP stack is likely
> executing over CPU0, assuming that the driver (FEC?) is NAPI-enabled,
> the packet processing takes place on behalf of a softirq context, on the
> same CPU.

That's why I pushed Xenomai onto CPU1.

> Btw, you mentioned a queue as the IPC between both threads. Which kind
> of queue/IPC is it?

It's a ring buffer utilizing shared memory. I use it much like a kfifo,
but I didn't want to incur the overhead of a system call on every write.

>> If I could run bare-metal on the second CPU, I would have done so.
>> The real-time behaviour is easily characterized, and the periodic work
>> can safely be done in 10 us even if all of the data has to be fetched
>> from external memory.
>>
>
> This is what bothers me. The CPU running the ISR code is likely unable
> to handle any regular linux activity in this case.

There isn't any useful Linux activity happening there. I just need to
keep it from interfering much with the *other* CPU.

>>> If you look at ksrc/drivers/testing/timerbench.c, you will see a typical
>>> use of rtdm events with ISRs, this driver is used when running
>>> latency -t2 for instance. I'm convinced the RTDM event API is not the issue.
>> 
>> I think you meant irqbench.c. And yes, I also am quite sure that the
>> event API is behaving fine.
>>
>
> I really meant timerbench.c. The only difference is the use of the pulse
> instead of signal interface, which makes no difference internally.

I see. I was confused because timerbench.c doesn't use IRQs directly.

I know that the event interface works for me, because I wrote a test
which occasionally sent the events from the context of a userspace
thread, and those events were picked up by the kernel task. But the same
events were being continuously sent by the ISR, and those were never
picked up by the kernel task.

To make sure I'm being clear: I had a system where all of the real-time
work was happening on CPU1 in the ISR, using data fed to it by a task
running on CPU0. This left the real-time work starved for data at times.
I theorized that CPU0 might be having trouble with the amount of time
CPU1 was spending in the ISR (with interrupts turned off); to account
for this, I introduced a new kernel task on CPU1, to do the
data-handling that had previously been in the ISR. The ISR would now
have nothing to do except wake up the kernel task. And it doesn't seem
to do that.

>> I think I have two options to investigate. One is to do all of my work
>> in the ISR, but to somehow re-enable enough interrupts to keep CPU0
>> doing useful work while the ISR is running on CPU1.
>
> If I understand this correctly, interrupt masking may not be the issue
> on CPU0, I'd rather think that CPU1 is spending too much time in
> real-time activity, preventing the regular kernel to properly
> synchronize SMP-wise between CPUs.
>
> e.g. IPIs won't flow to CPU1, if some regular linux activity gets
> preempted by the ISR while holding a spinlock, CPU0 could contend on
> that lock for as long as the ISR work keeps running on CPU1 and so on.
>
> I'm likely missing important points about your application, but
> generally speaking, the regular kernel is not going to be that happy if
> one of the CPUs involved in the SMP architecture is not responsive enough.

I really wouldn't mind letting the kernel get time more frequently; I just
need to be sure that my real time task gets at least 8 microseconds out
of every fifteen. Would I be able to guarantee that in a polled
architecture? What would be involved: short sleeps from a high-priority
realtime task?

Thanks again.

