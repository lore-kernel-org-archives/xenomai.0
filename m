Date: Thu, 26 Feb 2015 21:11:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150226201100.GB434@hermes.click-hack.org>
References: <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
 <54EF5E45.30907@xenomai.org> <44a900eaqu.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a900eaqu.fsf@lowell-desk.lan>
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On Thu, Feb 26, 2015 at 02:25:13PM -0500, Lowell Gilbert wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
> > On 02/26/2015 05:38 PM, Lowell Gilbert wrote:
> > The new task will be pinned to the CPU running rtdm_task_init() by
> > default, which is likely CPU0 as well.
> >
> > To check this, I would set the global Xenomai affinity to CPU1 before
> > starting the test, so that your driver task ends up there.
> >
> > # echo 2 > /proc/xenomai/affinity
> 
> Yes, I initialize that already. And give "isolcpus=1" to the kernel so
> that Linux will not schedule anything else on CPU1.
> 
> > At least you would have the timing IRQ and the task on a different CPU,
> > leaving some cycles to the latter. This said, 10 us between timer shots
> > is really too fast.
> 
> Having enough cycles for this isn't my fundamental problem. Running
> everything in the ISR has no trouble keeping up with the 100kHz data
> flow. The problem comes in a *non* real-time task, which is pulling data
> in from an IP socket and pushing it into a queue for the real-time code
> to use synchronously.
> 
> If I could run bare-metal on the second CPU, I would have done so.
> The real-time behaviour is easily characterized, and the periodic work
> can safely be done in 10 us even if all of the data has to be fetched
> from external memory.

Consuming all the time for running ISRs is not normal for OSes like
Linux and Xenomai. Being able to run the ISR in less than 10us does
not mean that there is some time left for the rest of the system;
there is quite some code executed around the ISR, and at this
frequency it stops being negligible. Linux at least needs to run
from time to time for time keeping. If you want to execute something
with this frequency, maybe you could consider using an FIQ. FIQs
have a lower overhead.

So, to be clear, does the ISR run on CPU0 and the thread doing the
reads run on CPU1? If no, does it work if you do it that way? To
know whether the problem comes from the interrupt consuming all the
available time, simply create a periodic task, in addition to the
ISR, with a high priority, and see if it executes from time to time
to increment a counter. If it does not execute, then we have a proof
that the ISR is not letting anything else run.

Another problem may be in handling the /proc/xenomai/affinity, so
could you try without using it? Same for isolcpus. If the ISR runs
on cpu0 and the tasks run on cpu1, an IPI should be sent in
__xnpod_schedule to wake up the task blocked in read, you can check
whether the IPI is sent by using ipipe_trace_special for instance
and checking the tracer trace.

> 
> >> I had used a counting semaphore (to account for possibly missed
> >> interrupts) in an earlier version of this code before changing it to an
> >> event when I found that the semaphore didn't work. I also tried a direct
> >> call to rtdm_task_unblock(), and that failed also.
> 
> > If you look at ksrc/drivers/testing/timerbench.c, you will see a typical
> > use of rtdm events with ISRs, this driver is used when running
> > latency -t2 for instance. I'm convinced the RTDM event API is not the issue.
> 
> I think you meant irqbench.c. And yes, I also am quite sure that the
> event API is behaving fine.

No, irqbench is not use as commonly as the latency test. timerbench,
used by the latency test, uses RTDM events.

-- 
					    Gilles.

