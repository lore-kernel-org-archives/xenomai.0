Message-ID: <5058CD54.4070509@xenomai.org>
Date: Tue, 18 Sep 2012 21:36:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50588110.6030701@siemens.com> <50588458.1010802@xenomai.org>
	<505892E8.6080605@siemens.com>
In-Reply-To: <505892E8.6080605@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [GIT PULL] core-5 for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/18/2012 05:27 PM, Wolfgang Mauerer wrote:

> On 18/09/12 16:25, Gilles Chanteperdrix wrote:
>> On 09/18/2012 04:11 PM, Wolfgang Mauerer wrote:
>>> Dear all,
>>>
>>> here's a rebase of the x86-specific bits of core-4 to core-5. I've
>>> included all x86 specific changes that are not yet in core-5, and
>>> also added the patches I sent earlier for core-4. I did not include a
>>> separate patch for the mechanical changes required to apply the
>>> x86 base patch on top of core-5, but can surely do so if desired.
>>
>> I am not quite finished with x86 on 3.4. So, I would like to start 3.5
>> from the finishing point on 3.4. There are already commits in my branch
>> which you did not take:
>>
>> http://git.xenomai.org/?p=ipipe-gch.git;a=shortlog;h=refs/heads/for-core-3.4
> that's true; my last pull was too old. I'll add the corresponding
> commits to the tree (FYI, the purpose of this tree is mainly to do some
> experiments with the latest ipipe release and the latest kernel, and
> I wanted to make sure that work is not duplicated in case someone else
> is pursuing similar goals)


Ok. We have a currently pending issue on x86 which you should be
informed about before discovering it during your tests: using
rthal_supported_cpus is broken in I-pipe core patches when using the
LAPIC timer: since there is only one irq handler for all the LAPIC
timers, the handler is registered on all cpus, but on non started cpus,
the handler will do nothing at best, and not foward the LAPIC ticks to
Linux (which is still in control of the LAPIC timer on these cpus).

This problem is due to the fact that we keep the same vector as Linux,
and so the same irq. There are two ways out of this:

- change the LAPIC vector when xenomai takes the control of the LAPIC
timer, like we use to do, this is racy with current code because the
timer is taken by Xenomai but still used a bit by Linux, before it is
programmed by Xenomai, and Xenomai assumes that the host tick irq is the
same as the timer irq. All this can be fixed, but the last drawback of
this approach is that it does not fix the issue on architectures where
the local timer irq is the same on all cpus, but can not be changed,
hence the second approach;
- the second approach is to add a test at the beginning of
xnintr_clock_handler and forward the irq to the root domain if the
current cpu does not belong to xnarch_supported_cpus. This means some
patching of I-pipe timers so that ipipe_percpu.hrtimer_irq also gets
defined for non supported cpus when they use the timer shared with other
cpus, essentially what this patch tries (but fails) to achieve:

http://www.xenomai.org/pipermail/xenomai/2012-September/026066.html


-- 
                                                                Gilles.

