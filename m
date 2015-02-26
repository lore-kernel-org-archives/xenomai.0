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
 <54EF5E45.30907@xenomai.org>
Date: Thu, 26 Feb 2015 14:25:13 -0500
In-Reply-To: <54EF5E45.30907@xenomai.org> (Philippe Gerum's message of "Thu,
 26 Feb 2015 18:56:21 +0100")
Message-ID: <44a900eaqu.fsf@lowell-desk.lan>
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

> On 02/26/2015 05:38 PM, Lowell Gilbert wrote:
> The new task will be pinned to the CPU running rtdm_task_init() by
> default, which is likely CPU0 as well.
>
> To check this, I would set the global Xenomai affinity to CPU1 before
> starting the test, so that your driver task ends up there.
>
> # echo 2 > /proc/xenomai/affinity

Yes, I initialize that already. And give "isolcpus=1" to the kernel so
that Linux will not schedule anything else on CPU1.

> At least you would have the timing IRQ and the task on a different CPU,
> leaving some cycles to the latter. This said, 10 us between timer shots
> is really too fast.

Having enough cycles for this isn't my fundamental problem. Running
everything in the ISR has no trouble keeping up with the 100kHz data
flow. The problem comes in a *non* real-time task, which is pulling data
in from an IP socket and pushing it into a queue for the real-time code
to use synchronously.

If I could run bare-metal on the second CPU, I would have done so.
The real-time behaviour is easily characterized, and the periodic work
can safely be done in 10 us even if all of the data has to be fetched
from external memory.

>> I had used a counting semaphore (to account for possibly missed
>> interrupts) in an earlier version of this code before changing it to an
>> event when I found that the semaphore didn't work. I also tried a direct
>> call to rtdm_task_unblock(), and that failed also.

> If you look at ksrc/drivers/testing/timerbench.c, you will see a typical
> use of rtdm events with ISRs, this driver is used when running
> latency -t2 for instance. I'm convinced the RTDM event API is not the issue.

I think you meant irqbench.c. And yes, I also am quite sure that the
event API is behaving fine.

I think I have two options to investigate. One is to do all of my work
in the ISR, but to somehow re-enable enough interrupts to keep CPU0
doing useful work while the ISR is running on CPU1. The other is to poll
the hardware state rather than using the interrupt.  Do you see anything
else I could do?

Thanks again.

Be well.

