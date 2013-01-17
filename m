Message-ID: <50F7BC13.50009@xenomai.org>
Date: Thu, 17 Jan 2013 09:53:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>
	<50F7AF53.2090800@xs4all.nl>
In-Reply-To: <50F7AF53.2090800@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Emc-developers] "new RTOS" status: Scheduler
 (?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bas Laarhoven <sjml@xs4all.nl>
Cc: EMC developers <emc-developers@lists.sourceforge.net>, xenomai@xenomai.org

On 01/17/2013 08:59 AM, Bas Laarhoven wrote:

> On 16-1-2013 20:36, Michael Haberler wrote:
>> Am 16.01.2013 um 17:45 schrieb Bas Laarhoven:
>>
>>> On 16-1-2013 15:15, Michael Haberler wrote:
>>>> ARM work:
>>>>
>>>> Several people have been able to get the Beaglebone ubuntu/xenomai setup working as outlined here: http://wiki.linuxcnc.org/cgi-bin/wiki.pl?BeagleboneDevsetup
>>>> I have updated the kernel and rootfs image a few days ago so the kernel includes ext2/3/4 support compiled in, which should take care of two failure reports I got.
>>>>
>>>> Again that xenomai kernel is based on 3.2.21; it works very stable for me but there have been several reports of 'sudden stops'. The BB is a bit sensitive to power fluctuations but it might be more than that. As for that kernel, it works, but it is based on a branch which will see no further development. It supports most of the stuff needed to development; there might be some patches coming from more active BB users than me.
>>> Hi Michael,
>>>
>>> Are you saying you don't have seen these 'sudden stops' yourself?
>> No, never, after swapping to stronger power supplies; I have two of these boards running over NFS all the time. I dont have Linuxcnc running on them though, I'll do that and see if that changes the picture. Maybe keeping the torture test running helps trigger it.
> 
> Beginners error! :-P The power supply is indeed critical, but the 
> stepdown converter on my BeBoPr is dimensioned for at least 2A and 
> hasn't failed me yet.
> 
> I think that running linuxcnc is mandatory for the lockup. After a dozen 
> runs, it looks like I can reproduce the lockup with 100% certainty 
> within one hour.
> Using the JTAG interface to attach a debugger to the Bone, I've found 
> that once stalled the kernel is still running. It looks like it won't 
> schedule properly and almost all time is spent in the cpu_idle thread.


This is typical of a tsc emulation or timer issue. On a system without
anything running, please let the "tsc -w" command run. It will take some
time to run (the wrap time of the hardware timer used for tsc
emulation), if it runs correctly, then you need to check whether the
timer is still running when the bug happens (cat /proc/xenomai/irq
should continue increasing when for instance the latency test is
running). If the timer is stopped, it may have been programmed for a too
short delay, to avoid that, you can try:
- increasing the ipipe_timer min_delay_ticks member (by default, it uses
a value corresponding to the min_delta_ns member in the clockevent
structure);
- checking after programming the timer (in the set_next_event method) if
the timer counter is already 0, in which case you can return a negative
value, usually -ETIME.


-- 
                                                                Gilles.

