From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <53316C4C.6000708@sigmatek.at>
 <CANKLDmuMDpiUC7Z7dsXa5K3LYNA4LNwA7mhAicJ_Dey+2S9PCg@mail.gmail.com>
 <53335D9A.9040902@xenomai.org> <5333F22F.70805@xenomai.org>
 <CANKLDmttO4jZtRxV-bjYQwg3YkGBKwFL74ATkdM2SBH8Xby31A@mail.gmail.com>
 <53345143.7000009@xenomai.org> <53346835.4030202@web.de>
 <53346CF7.2020805@xenomai.org> <53346E91.8080903@web.de>
Date: Thu, 27 Mar 2014 16:18:28 -0400
In-Reply-To: <53346E91.8080903@web.de> (Jan Kiszka's message of "Thu, 27 Mar
 2014 19:31:45 +0100")
Message-ID: <444n2j1jl7.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] Rescnt imbalance in rtdm_mutex_timedlock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka <jan.kiszka@web.de> writes:

> On 2014-03-27 19:24, Philippe Gerum wrote:
>> On 03/27/2014 07:04 PM, Jan Kiszka wrote:

>>> if (unlikely(...)) - locks are generally unlikely to be contended
>>> (unless something is suboptimally designed at the user site).
>>>
>> 
>> I'm unsure we really need to take a chance at giving such hint. Modern
>> CPUs tend to have branch prediction right.
>
> Then likely/unlikely will be emptied by Linux. But I'm not aware of any
> plans in the kernel community to phase out this tag.

Hints tend to be overused. They are only useful if they not only correct
a branch assumption that was incorrect, but also allow for a performance
improvement as well. Aside from the fact that sometimes the optimal code
is identical either way, it will often differ by just an instruction or
two without even stalling a pipeline.

But hints won't go away, either, for many reasons. Obviously, not all
CPUs that run Linux have great branch prediction. The compiler can do
some optimizations by rearranging the code to keep the likely path in
the cache, so even if the CPU will predict the branch correctly, the
compiler may not be able to, and an opportunity is missed. Even the best
dynamic branch profiling has limits, and a priori knowledge (like the
fact that locks are usually available) may be able to outperform
anything available. Et cetera.

