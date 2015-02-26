From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
 <54EF5E45.30907@xenomai.org> <44a900eaqu.fsf@lowell-desk.lan>
 <20150226201100.GB434@hermes.click-hack.org>
Date: Thu, 26 Feb 2015 16:58:06 -0500
In-Reply-To: <20150226201100.GB434@hermes.click-hack.org> (Gilles
 Chanteperdrix's message of "Thu, 26 Feb 2015 21:11:00 +0100")
Message-ID: <441tlce3o1.fsf@lowell-desk.lan>
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

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> On Thu, Feb 26, 2015 at 02:25:13PM -0500, Lowell Gilbert wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>> > On 02/26/2015 05:38 PM, Lowell Gilbert wrote:
>> > The new task will be pinned to the CPU running rtdm_task_init() by
>> > default, which is likely CPU0 as well.
>> >
>> > To check this, I would set the global Xenomai affinity to CPU1 before
>> > starting the test, so that your driver task ends up there.
>> >
>> > # echo 2 > /proc/xenomai/affinity
>> 
>> Yes, I initialize that already. And give "isolcpus=1" to the kernel so
>> that Linux will not schedule anything else on CPU1.
>> 
>> > At least you would have the timing IRQ and the task on a different CPU,
>> > leaving some cycles to the latter. This said, 10 us between timer shots
>> > is really too fast.
>> 
>> Having enough cycles for this isn't my fundamental problem. Running
>> everything in the ISR has no trouble keeping up with the 100kHz data
>> flow. The problem comes in a *non* real-time task, which is pulling data
>> in from an IP socket and pushing it into a queue for the real-time code
>> to use synchronously.
>> 
>> If I could run bare-metal on the second CPU, I would have done so.
>> The real-time behaviour is easily characterized, and the periodic work
>> can safely be done in 10 us even if all of the data has to be fetched
>> from external memory.
>
> Consuming all the time for running ISRs is not normal for OSes like
> Linux and Xenomai. Being able to run the ISR in less than 10us does
> not mean that there is some time left for the rest of the system;
> there is quite some code executed around the ISR, and at this
> frequency it stops being negligible. Linux at least needs to run
> from time to time for time keeping. If you want to execute something
> with this frequency, maybe you could consider using an FIQ. FIQs
> have a lower overhead.

Sure. In a static test, with the ISR being the only thing assigned to
the isolated CPU, an idle task does get run time.

An FIQ doesn't really make sense if, as I suggest, my problem is that
the system is spending too much time with interrupts disabled.

> So, to be clear, does the ISR run on CPU0 and the thread doing the
> reads run on CPU1? If no, does it work if you do it that way? To

The other way around, but that's pretty much what I have set up. CPU0
handles work that doesn't need to be real-time, and CPU1 handles only
the real-time work.  In particular, CPU0 reads a stream of incoming data
from a TCP socket, processes it slightly, and writes it into kernel
memory.

If I preload several seconds worth of data before enabling the
interrupt, the ISR is able to keep up with the workload while a busy-
loop task gets roughly 15-20% of the cycles (on CPU1). On the other
hand, if I delay starting the ISR, my (non-real-time, or at least not
necessarily real time) network task (on CPU0) can load data -- at a
speed several times that which the data will be consumed at. But once I
release the ISR, the network task can't keep up, and the ISR eventually
runs dry.

> know whether the problem comes from the interrupt consuming all the
> available time, simply create a periodic task, in addition to the
> ISR, with a high priority, and see if it executes from time to time
> to increment a counter. If it does not execute, then we have a proof
> that the ISR is not letting anything else run.

I did this with a low-priority task, and with nothing but it, the ISR,
and Linux housekeeping running on CPU1, it did get some time.

> Another problem may be in handling the /proc/xenomai/affinity, so
> could you try without using it? Same for isolcpus.

I can certainly try that, but what should I be looking for? 

> could you try without using it? Same for isolcpus. If the ISR runs
> on cpu0 and the tasks run on cpu1, an IPI should be sent in
> __xnpod_schedule to wake up the task blocked in read, you can check
> whether the IPI is sent by using ipipe_trace_special for instance
> and checking the tracer trace.

Ah, thank you. That may be very helpful.

Be well.

