References: <023601d363ac$6ce04c40$46a0e4c0$@sepro-group.com>
 <d2a2bcaf-7cfb-78f9-55cb-b1cca9b4a0be@xenomai.org>
 <02ca01d36468$537ffef0$fa7ffcd0$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b0baf0ab-e11b-0d5d-2310-72249c51b1aa@xenomai.org>
Date: Thu, 23 Nov 2017 15:44:25 +0100
MIME-Version: 1.0
In-Reply-To: <02ca01d36468$537ffef0$fa7ffcd0$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Strange scheduling behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Perles?= <cperles@sepro-group.com>, xenomai@xenomai.org

On 11/23/2017 03:35 PM, Cédric Perles wrote:
>>> Hi,
>>>
>>> I’m working on an iMX6 based board with NXP kernel 4.1.15.
> 
>>> Vendor kernels for i.MX6 are creepy (another vowel comes to mind). A 
>>> recent mainline kernel is just fine if the SoC supports it. If not, 
>>> porting the SoC (and/or missing driver) to mainline is often much > 
>>> better and faster than enduring a truckload of bugs.
> 
>>> I would like to understand why latency max returned by cyclictest
>>> increases from 20µs to 100µs when dohell accesses to USB.
>>>
>>> Since i-pipe tracer refuses to work,
> 
>> Which means?
> 
> I sent a message on this subject 
> (https://xenomai.org/pipermail/xenomai/2017-November/037919.html).
> I don't know why but my kernel don't boot when ipipe tracer is activated.
> 
>>> I used ftrace to record cobalt,
>>> scheduling and irq events. Here is what I see on kernelshark:
>>>
>>> As expected, cyclictest has 1 xenomai thread per core (I can see them
>>> on
>>> /proc/xenomai/sched/threads) that wakes up periodically after a 200µs
>>> nanosleep.
>>>
>>> Sometimes, the wake up seems to be delayed (400µs instead of 200µs)
>>> because of an USB irq treatment followed by a call to usb-storage.
>>> Other times, the wake up seems to be delayed (400µs instead of 200µs)
>>> by a Linux call to ktimersoft, rcu and cat (see
>>> https://drive.google.com/file/d/18-B3WO2QH7PvBzJrt9tK5-TXvAkDxTPn/view
>>> ?usp
>>> =sharing)
>>>
> 
>> The textual trace shows no issue. 40us are spent suspending a Cobalt 
>> thread, which seems reasonable on i.MX6Q with ftrace enabled and the slow 
>> PL310 L2 outer cache you have there. I likely missed your point then.
> 
>>> Is it normal to delay a xenomai task wake up because of a Linux
>>> interrupt (I expected ipipe to act as a shield) ?
>>> How a simple Linux "cat" can delay a xenomai wake up ?
>>>
> 
>> For instance, if the Xenomai task in question dropped to secondary mode 
>> earlier because the app is wrong somehow, then some work queue kernel 
>> thread starts running funky driver code issuing usleep() to sync with the 
>> hw. The rt thread running in non-rt mode will have to wait until the 
>> driver stops busy-waiting for a bit to toggle, causing the next rt 
>> operation for that task to appear as badly delayed. > The point is, that 
>> Xenomai is not in charge when the delay appears.
> 
>> This case has been observed several times with MMC host and PCI host 
>> drivers on fsl kernels; I would not be surprised if that happened with 
>> other vendor-specific driver(s) too.
> 
> I agree, if the application dropped to secondary mode, it would explain the 
> trace. However, I don't think we drop to secondary.
> The application is the cyclictest included with xenomai tools to bench real 
> time performances through posix skin. I don't expect such application to 
> switch to secondary. Moreover, /proc/xenomai/sched/stat indicates no mode 
> switch (MSW is stuck to 1 for this thread).
> 
> I made another test and set cyclictest period to 400µs. In this case, the 
> wake up is sometime 800µs instead of 400µs. It's just like if 
> clock_nanosleep used by cyclictest missed some events.
> 

I see no correlation between the traces you sent and the behavior just
described though.

I don't know which pipeline code you have been using so far, we follow
mainline only. This said, some imx6 have the infamous C3STOP mode
enabled for the TWD, which may cause the main timer to be switched to a
general purpose timer, and the TWD to be temporarily stopped, which does
not cope well with the current Cobalt implementation.

You may want to check if the CPUIDLE framework is not getting in the way.

-- 
Philippe.

