Message-ID: <52CDDCEC.6030205@xenomai.org>
Date: Thu, 09 Jan 2014 00:19:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org> <52CC62A0.3090108@xenomai.org>
 <44lhyqgkip.fsf@lowell-desk.lan>
In-Reply-To: <44lhyqgkip.fsf@lowell-desk.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Altera Cyclone V
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

On 01/08/2014 11:45 PM, Lowell Gilbert wrote:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> 
>> On 01/07/2014 08:52 PM, Lowell Gilbert wrote:
>>> What I'm hitting at the moment is that gt_setup() is getting called, 
>>> but twd_timer_setup() hasn't run yet, so the frequency isn't set yet. 
>>> Both functions are in __cpuinit, and the file would be used the same for
>>> other chips containing the Cortex A9, so I'm confused about what might
>>> be wrong.
>>
>> gt_setup is supposed to be called after twd_local_timer_common_register,
>> which calls twd_get_clock, which gets the timer frequency from the twd
>> clock node. If your SOC does not have a clock node for the twd clock,
>> then you should add one, because the calibration method yields unprecise
>> results, which may result in "early shots", meaning too many interrupts,
>> if the GT is not used as TSC.
> 
> But I do want the GT to be my TSC, no?

Yes, but that is not always possible, not all cortex A9 have a GT.
And as I said the calibration is imprecise, so, even if you do not get 
early shots, you will still have the Xenomai clock drifting fast from 
the Linux clock (if it is syncrhonized with ntp for instance).

> 
>>>
>>> Any pointers would be appreciated.
>>
>> See:
>> https://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>> In particular, about this specific issue:
>>
>> https://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_Cortex-A9_case
> 
> Ah; I had read that as saying that the clock node would be part of the
> general A9 support. It should be the same for all chips using a Cortex
> A9, no? 

No, every ARM SOC has its own clocks implementation. This is currently 
changing with the switch to device tree, but not all SOCs are 
converted, at least not all of them were last time I checked. Anyway, 
if your SOC uses device tree, adding a clock may simply be a matter of 
adding it to the device tree.

> 
> Come to think of it, this is similar to my surprise at having to write
> my own __ipipe_mach_update_tsc(), which surprised me. I'm clearly still

No, you do not have to write your own __ipipe_mach_update_tsc(). See:
https://www.xenomai.org/index.php/I-pipe-core:ArmPorting#High_resolution_counter


-- 
                                                                Gilles.

