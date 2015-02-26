Message-ID: <54EF5E45.30907@xenomai.org>
Date: Thu, 26 Feb 2015 18:56:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
 <20150220225712.GE2356@hermes.click-hack.org>
 <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
In-Reply-To: <447fv4sk55.fsf@lowell-desk.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 02/26/2015 05:38 PM, Lowell Gilbert wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Your test code in user-space seems to enable the timing IRQ only for a
>> very short time, between the write and read calls to the driver which
>> happen in sequence.
>>
>> Those two interrupts are very close in the time line, i.e. 42 us:
>>
>> :|   +begin   0x90000000   -68	  0.960  __irq_svc+0x44
>> (ipipe_unstall_root+0x88)
>> ...
>> :|  + begin   0x90000000   -26+   1.006  __irq_svc+0x44
>> (__ipipe_restore_head+0xec)
> 
> My actual interrupts are (typically) 10 us apart. There are some

Do you intend to run an interrupt-driven work loop at 100Khz on your
A9-based, dual core board? If so, your system is most likely handling
too many interrupts on the CPU running the RTDM task, preventing this
task to run and therefore increment the counter.

Assuming the interrupt controller for your SoC is a GIC, unless you
explicitly set the IRQ affinity, the GIC distributor will dispatch your
timing IRQ to CPU0 by default, like all other SPIs.

The new task will be pinned to the CPU running rtdm_task_init() by
default, which is likely CPU0 as well.

To check this, I would set the global Xenomai affinity to CPU1 before
starting the test, so that your driver task ends up there.

# echo 2 > /proc/xenomai/affinity

At least you would have the timing IRQ and the task on a different CPU,
leaving some cycles to the latter. This said, 10 us between timer shots
is really too fast.

> I had used a counting semaphore (to account for possibly missed
> interrupts) in an earlier version of this code before changing it to an
> event when I found that the semaphore didn't work. I also tried a direct
> call to rtdm_task_unblock(), and that failed also.
> 

If you look at ksrc/drivers/testing/timerbench.c, you will see a typical
use of rtdm events with ISRs, this driver is used when running
latency -t2 for instance. I'm convinced the RTDM event API is not the issue.

-- 
Philippe.

