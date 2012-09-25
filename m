Message-ID: <506199BA.3070203@xenomai.org>
Date: Tue, 25 Sep 2012 13:47:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmsUnaOGUb9KQf=c-68h1YHB7R=Uc-GvMzsJL_L1jG2cJw@mail.gmail.com>	<50616788.7070109@xenomai.org>
	<CANKLDmvKpEAtesr9gRbMr9bA=mUpE-0+zBm5kpNz2NS6gi+zig@mail.gmail.com>
In-Reply-To: <CANKLDmvKpEAtesr9gRbMr9bA=mUpE-0+zBm5kpNz2NS6gi+zig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] No TSC in SMP on Intel Atom
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: xenomai@xenomai.org

On 09/25/2012 11:00 AM, Henri Roosen wrote:

> On Tue, Sep 25, 2012 at 10:12 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 09/24/2012 03:33 PM, Henri Roosen wrote:
>>> Hi,
>>>
>>> I'm currently doing some tests on an Intel ATOM D2700 and try to run
>>> Xenomai threads on different cores. Currently using kernel 3.4.6,
>>> x86-32 SMP, and Xenomai 2.6.1 SMP.
>>>
>>> It seems the kernel detects the ATOM's TSC as unusable in SMP
>>> configuration and switches to the jiffies clock. This because there is
>>> an offset between both TSC counters of both cores. It seems even
>>> though the CPU has constant_tsc and nonstop_tsc, there is no guarantee
>>> for the counters to have the same value. I guess just the offset stays
>>> the same.
>>>
>>> My question is what are the implications for Xenomai not being able to
>>> have a TSC in SMP configuration, as Xenomai heavily relies on the TSC?
>>
>> Xenomai should not take what Linux does into accout, and continue to use
>> the TSC, you should see if that is the case by running
>> cat /proc/xenomai/timer
> 
> Yes, Xenomai is still running on the TSC:
> root@target:~# cat /proc/xenomai/timer
> status=on:setup=32:clock=187739919672:timerdev=lapic:clockdev=tsc
> 
> Basically Xenomai is running in this SMP configuration.
> The direct problem I am currently seeing is that our code, which has
> only been used on single-core up to now, uses the TSC as a fast high
> resolution 'wall time' (rt_timer_tsc()). This fails when running
> Xenomai threads on different cores and the TSC of the cores don't have
> the same values.
> 
> I'm sure Linux has a good reason to switch away from the TSC in this
> case. So I have to rephrase my initial question to: are there any
> implications for Xenomai-SMP when the TSC counters of the cores
> running Xenomai threads are of different value?
> 
> I'm not sure whether there is a way to set the TSC's to the same
> value? That would solve all my questions and concerns. Intel
> documentation states it is done when the cores receive RESET, so I'm
> not sure whether this is applicable to the ATOM architecture.


No, this is an issue which was already discussed in the past, and
currently, we have no solution.

-- 
                                                                Gilles.

