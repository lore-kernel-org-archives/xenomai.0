Message-ID: <50FAAE9A.2060705@xenomai.org>
Date: Sat, 19 Jan 2013 15:32:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>
	<50F7BC13.50009@xenomai.org>	<50F7FCD8.7020105@xs4all.nl>
	<50FA9FA0.7020400@xenomai.org>
	<F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>
In-Reply-To: <F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Emc-developers] "new RTOS" status:
 Scheduler	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 01/19/2013 03:09 PM, Michael Haberler wrote:

> 
> Am 19.01.2013 um 14:29 schrieb Gilles Chanteperdrix:
> 
>> On 01/17/2013 02:30 PM, Bas Laarhoven wrote:
>>
>>> On 17-1-2013 9:53, Gilles Chanteperdrix wrote:
>>>> On 01/17/2013 08:59 AM, Bas Laarhoven wrote:
>>>>
>>>>> On 16-1-2013 20:36, Michael Haberler wrote:
>>>>>> Am 16.01.2013 um 17:45 schrieb Bas Laarhoven:
>>>>>>
>>>>>>> On 16-1-2013 15:15, Michael Haberler wrote:
>>>>>>>> ARM work:
>>>>>>>>
>>>>>>>> Several people have been able to get the Beaglebone ubuntu/xenomai setup working as outlined here: http://wiki.linuxcnc.org/cgi-bin/wiki.pl?BeagleboneDevsetup
>>>>>>>> I have updated the kernel and rootfs image a few days ago so the kernel includes ext2/3/4 support compiled in, which should take care of two failure reports I got.
>>>>>>>>
>>>>>>>> Again that xenomai kernel is based on 3.2.21; it works very stable for me but there have been several reports of 'sudden stops'. The BB is a bit sensitive to power fluctuations but it might be more than that. As for that kernel, it works, but it is based on a branch which will see no further development. It supports most of the stuff needed to development; there might be some patches coming from more active BB users than me.
>>>>>>> Hi Michael,
>>>>>>>
>>>>>>> Are you saying you don't have seen these 'sudden stops' yourself?
>>>>>> No, never, after swapping to stronger power supplies; I have two of these boards running over NFS all the time. I dont have Linuxcnc running on them though, I'll do that and see if that changes the picture. Maybe keeping the torture test running helps trigger it.
>>>>> Beginners error! :-P The power supply is indeed critical, but the
>>>>> stepdown converter on my BeBoPr is dimensioned for at least 2A and
>>>>> hasn't failed me yet.
>>>>>
>>>>> I think that running linuxcnc is mandatory for the lockup. After a dozen
>>>>> runs, it looks like I can reproduce the lockup with 100% certainty
>>>>> within one hour.
>>>>> Using the JTAG interface to attach a debugger to the Bone, I've found
>>>>> that once stalled the kernel is still running. It looks like it won't
>>>>> schedule properly and almost all time is spent in the cpu_idle thread.
>>>>
>>>> This is typical of a tsc emulation or timer issue. On a system without
>>>> anything running, please let the "tsc -w" command run. It will take some
>>>> time to run (the wrap time of the hardware timer used for tsc
>>>> emulation), if it runs correctly, then you need to check whether the
>>>> timer is still running when the bug happens (cat /proc/xenomai/irq
>>>> should continue increasing when for instance the latency test is
>>>> running). If the timer is stopped, it may have been programmed for a too
>>>> short delay, to avoid that, you can try:
>>>> - increasing the ipipe_timer min_delay_ticks member (by default, it uses
>>>> a value corresponding to the min_delta_ns member in the clockevent
>>>> structure);
>>>> - checking after programming the timer (in the set_next_event method) if
>>>> the timer counter is already 0, in which case you can return a negative
>>>> value, usually -ETIME.
>>>>
>>>
>>> Hi Gilles,
>>>
>>> Thanks for the swift reply.
>>>
>>> As far as I can see, tsc -w runs without an error:
>>>
>>> ARM: counter wrap time: 179 seconds
>>> Checking tsc for 6 minute(s)
>>> min: 5, max: 12, avg: 5.04168
>>> ...
>>> min: 5, max: 6, avg: 5.03771
>>> min: 5, max: 28, avg: 5.03989 -> 0.209995 us
>>>
>>> real    6m0.284s
>>>
>>> I've also done the other regression tests and all were successful.
>>>
>>> Problem is that once the bug happens I won't be able to issue the cat 
>>> command.
>>> I've fixed my debug setup so I don't have to use the System.map to 
>>> manually translate the debugger addresses : /
>>> Now I'm waiting for another lockup to see what's happening.
>>
>>
>> You may want to have a look at the xeno-regression-test script to put
>> your system under pressure (and likely generate the lockup faster).
> 
> running tsc -w and xeno-regression-test in parallel I get errors like so (not on every run; no lockup so far):


At this point we know that you do not have any issue with tsc emulation,
so running tsc -w in parallel is useless. The point of running
xeno-regression-test is to reach the "switchtest + switchtest -s +
latency + ltp" point, where the system will be put under stress, and
will be more likely to trigger a timer issue if there is one. So, if the
tests before that do not pass, simply comment them in
xeno-regression-test (xeno-regression-test is a shell script).

Also note that if you are running a thumb2 user-space or running the
kernel with CONFIG_THUMB2_KERNEL (which the segfault in sigdebug
suggests), on a processor with a cortex a8 core, you need to enable
CONFIG_ERRATA_430973, otherwise you will get random faults due to the
correspondig processor erratum.

-- 
                                                                Gilles.

