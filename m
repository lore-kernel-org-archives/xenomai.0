Message-ID: <48721B0D.5070003@domain.hid>
Date: Mon, 07 Jul 2008 15:33:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <487201E0.9080700@domain.hid>
	<1c0cec5bc2f1021b5f987524064973a8@domain.hid>
In-Reply-To: <1c0cec5bc2f1021b5f987524064973a8@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

Matthieu wrote:
> On Mon, 07 Jul 2008 13:45:36 +0200, Philippe Gerum <rpm@xenomai.org> wrote:
>> Matthieu wrote:
>>> Hi
>>>
>>> Well I'm going to try to be clear :
>>>
>>> I work on a project that aims at migrating VxWorks tasks from PPC boards
>> on
>>> VME crate to X86 Computer ruuning with Linux. The cost of using Xenomai
>> API
>>> instead of vxworks skin seems very costly. The idea is to keep the
>> maximum
>>> of mechanisms.
>>>
>>> As there is no implementation of vxworks periodic task instruction, the
>>> idea was to use watchdogs. In fact, as watchdogs are counting from
>> ticks,
>>> it's easy to make tasks periodic if the period of the task is a multiple
>> of
>>> the tick period. So each task starts it's watchdog, executes some
>> routine,
>>> and suspends itself. The watchdog, when the specified delay ticks
>> elapsed,
>>> resumes the task. And so on...
>> You may want to use a semaphore to synchronize your wd handler with the
>> task
>> instead of suspend/resume calls.
>>
> 
> Sorry, it was a mistake from me, semaphores are used instead of
> suspend/resume.
> 
>>> The use of multiple PPC boards, with periodic tasks that need to be
>>> synchronized, has required the use of an hardware interrupt, spread to
>> all
>>> CPUs, and which handler tickAnnouce() vxworks. I know that this
>> mechanism
>>> isn't still necessary as there is only one vxworks tick on Xenomai, even
>> if
>>> I work with many CPUs.
>> Wrong, Xenomai ticks on each CPU because internal timers are per-cpu
>> resources;
>> only the boot CPU tracks jiffies, but that's a different issue.
>>
>>  But in the new configuration, I have a PCI card that
>>> will send this interrupt. So I need to stop the automatic vxworks tick
>> with
>>> tick_arg=0 and to handle this interrupt to tickAnnouce() manually. As I
>>> will don't have this card all the day, I need to simulate this mecanism,
>>> and I need to create something that will tickAnnouce() at a periodic
>> time.
>>> I created a module that, in on case, will handle the interrupt, and on
>> an
>>> other case, will create a xenomai rt_task that tickAnnouce. And this
>>> doesn't work. I want the ioctl method send the period to the module in
>>> order to modify the period of the tick.
>>>
>>> I still have created this driver has you see but it doesn't work.
>> What your code did is switching the VxWorks timer to aperiodic mode which
>> stops
>> periodic timing; in that mode, the time unit is nanosecond, so every
>> timeout
>> data is interpreted as a count of nanoseconds. This is likely not what
> you
>> want.
>>
>>  I'm going
>>> to test your modifications. Thank you for that.
>>>
>> Forget about this example; actually, those changes do not fix the logic,
>> but
>> only provide some hints about xntbase_switch(), and fix return code
>> issues.
>>
>>> I will also need to get a precise time, and Gilles suggest me to use
>>> xntbase, but xntbase_get_time(&nktbase); isn't recognized.
>> What Gilles told you is that solely switching the VxWorks clock to
>> aperiodic
>> mode (by passing period == 0) would wreck the underlying timing logic of
> a
>> VxWorks app, which does not pass/expect nanoseconds but jiffies/ticks. In
>> short,
>> doing so is not enough.
>>
> 
> I need a clock to get the time with a 10 µs precision. I tought using this
> master timebase, as it gives me a time in nanoseconds, irrespective of
> vxworks timebase. 

That will work. The master timebase is always active and does return nanoseconds
when inquired.

> 
>> Normally, solving your issue would require to make the master timebase
>> paced by
>> your PCI card, which would in turn provide the correct timing for the
>> VxWorks
>> timebase (as the timebase doc states, periodic timebases are cascaded
> from
>> the
>> master aperiodic one). However, doing so would also require to adapt the
>> Xenomai
>> HAL code accordingly, and a PCI hw that is oneshot programmable as well.
>>
>> If you want to hack the Xenomai timer sub-system in order to only affect
>> the
>> VxWorks timebase, what you actually need is to control the coupling
>> between the
>> master timebase (paced by decrementer) and the slave VxWorks one, so that
>> decrementer ticks may be prevented from kicking the VxWorks timebase.
> This
>> way,
>> you would be able to call tickAnnounce() freely to announce any incoming
>> VxWorks
>> tick (i.e. from your PCI handler).
>>
>> In short, when paced by the PCI interrupt, you will need to:
>>
>> - call xntslave_stop(base2slave(wind_tbase))
>> - call tickAnnounce() from your PCI IRQ handler
>>
>> When paced normally (simulation, "somebody stole by PCI card" mode), just
>> leave
>> the burden to the system timer (i.e. ppc decrementer) as usual, by
>> coupling the
>> VxWorks slave timebase to the master one anew:
>>
>> - call xntslave_start(base2slave(wind_tbase),  xnarch_get_cpu_time() +
>> period,
>> period); /* period is given in nanoseconds, depends on the master
> timebase
>> */
>>
>> In any case, you don't need to change the VxWorks tick period.
>> Starting/stopping
>> the VxWorks timebase should do the trick. NOTE: this is a hack exposing
>> Xenomai
>> internals -- we should probably encapsulate this into new
>> xntbase_bind/unbind
>> calls if this does eventually works for you.
>>
> 
> You are right. It was un misunderstanding because I still don't know the
> impact of tick_arg.
> What you propose is very interesting. I's easier than what I tried to do.
> xntbase_bind/unbind seems to be a good solution. I would like to know from
> where I would be able to use these calls (kernel/user space) ?

Kernel space. If you need to relay requests to switch on/off timebase coupling
from userland, then you just need your small RDM driver to do so, via some ioctl
command of your own.

> What I need is to select the simulation working mode (without the card) or
> the PCI IRQ mode during the execution of my code (whose exectution is in
> user space). If I'm working in simulation mode, I also need to specify the
> tick period at the begining of the execution (1ms or 5ms).
> 

Then you will also need to change the period of the VxWorks timebase on the fly,
using xntbase_update() when applicable.

>> --
>> Philippe.
> 
> Matthieu
> 
> 
> 


-- 
Philippe.

