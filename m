References: <5734A9F8.10305@siemens.com>
 <20160512163142.GC18298@hermes.click-hack.org> <5734B43B.4040001@siemens.com>
 <20160512165904.GF18298@hermes.click-hack.org>
 <20160512171246.GG18298@hermes.click-hack.org> <5734BA9B.1030503@siemens.com>
 <20160512182049.GQ13285@hermes.click-hack.org> <5734CA76.5000606@siemens.com>
 <5734CCF8.5090508@xenomai.org> <5734CE80.60707@siemens.com>
 <5734D4B9.4070900@xenomai.org> <5734D92F.1000206@siemens.com>
 <57350331.1020302@xenomai.org> <57356C0E.6080205@siemens.com>
 <5735D8E0.3040202@xenomai.org> <5735F39A.8050204@siemens.com>
 <57601E35.3010101@siemens.com>
 <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
 <5760227A.3010203@siemens.com>
 <3162a045-f25f-a4eb-3668-c43a2badf0a9@xenomai.org>
 <57606326.2010708@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5b15e0a7-fae6-b9dd-0ea8-cf044ae43253@xenomai.org>
Date: Tue, 14 Jun 2016 22:13:28 +0200
MIME-Version: 1.0
In-Reply-To: <57606326.2010708@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 06/14/2016 10:03 PM, Jan Kiszka wrote:
> On 2016-06-14 21:48, Philippe Gerum wrote:
>> On 06/14/2016 05:27 PM, Jan Kiszka wrote:
>>> On 2016-06-14 17:23, Philippe Gerum wrote:
>>>> On 06/14/2016 05:09 PM, Jan Kiszka wrote:
>>>>> On 2016-05-13 17:32, Jan Kiszka wrote:
>>>>>> On 2016-05-13 15:38, Philippe Gerum wrote:
>>>>>>> On 05/13/2016 07:54 AM, Jan Kiszka wrote:
>>>>>>>> On 2016-05-13 00:26, Philippe Gerum wrote:
>>>>>>>>> On 05/12/2016 09:27 PM, Jan Kiszka wrote:
>>>>>>>>>> On 2016-05-12 21:08, Philippe Gerum wrote:
>>>>>>>>>>> On 05/12/2016 08:42 PM, Jan Kiszka wrote:
>>>>>>>>>>>> On 2016-05-12 20:35, Philippe Gerum wrote:
>>>>>>>>>>>>> On 05/12/2016 08:24 PM, Jan Kiszka wrote:
>>>>>>>>>>>>>> On 2016-05-12 20:20, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>> On Thu, May 12, 2016 at 07:17:15PM +0200, Jan Kiszka wrote:
>>>>>>>>>>>>>>>> On 2016-05-12 19:12, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>>>> On Thu, May 12, 2016 at 06:59:04PM +0200, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>>>>> On Thu, May 12, 2016 at 06:50:03PM +0200, Jan Kiszka wrote:
>>>>>>>>>>>>>>>>>>> On 2016-05-12 18:31, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>>>>>>> On Thu, May 12, 2016 at 06:06:16PM +0200, Jan Kiszka wrote:
>>>>>>>>>>>>>>>>>>>>> Gilles,
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> regarding commit bec5d0dd42 (rtdm: make syscalls conforming rather than
>>>>>>>>>>>>>>>>>>>>> current) - I remember a discussion on that topic, but I do not find its
>>>>>>>>>>>>>>>>>>>>> traces any more. Do you have a pointer
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> In any case, I'm confronted with a use case for the old (Xenomai 2),
>>>>>>>>>>>>>>>>>>>>> lazy switching behaviour: lightweight, performance sensitive IOCTL
>>>>>>>>>>>>>>>>>>>>> services that can (and should) be called without any switching from both
>>>>>>>>>>>>>>>>>>>>> domains.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Why not using a plain linux driver? ioctl_nrt callbacks are
>>>>>>>>>>>>>>>>>>>> redundant with plain linux drivers.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Because that enforces the calling layer to either call the same service
>>>>>>>>>>>>>>>>>>> via a plain Linux device if the calling thread is currently relaxed or
>>>>>>>>>>>>>>>>>>> go for the RT device if the caller is in primary. Doable, but I would
>>>>>>>>>>>>>>>>>>> really like to avoid this pain for the users.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> What were the arguments in favour of migrating threads to real-time first?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> I currently see the real need only for IOCTLs, but the question is then
>>>>>>>>>>>>>>>>>>>>> if we shouldn't go back to "__xn_exec_current" in all RTDM cases to
>>>>>>>>>>>>>>>>>>>>> avoid unwanted migration costs (which are significantly higher than
>>>>>>>>>>>>>>>>>>>>> syscall restarts).
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I do not find commit bec5d0dd42 in xenomai-2.6 git tree, and I do
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Xenomai 2 is still following the lazy scheme - we reverted that commit
>>>>>>>>>>>>>>>>>>> later on in 7df0c1d96b. Xenomai 3 changed it again with the commit above.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> not remember merging this. However I find commit
>>>>>>>>>>>>>>>>>>>> 13bfdd477ab880499d2e8f3b82c49ef4d2cccff0 from 2010 which seems to
>>>>>>>>>>>>>>>>>>>> explain the reason pretty clear.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> At the time of the discussion we had concluded that it was the way
>>>>>>>>>>>>>>>>>>>> to go. With __xn_exec_current you may enter the ioctl_rt callback
>>>>>>>>>>>>>>>>>>>> from secondary domain, which is counter-intuitive, error-prone, and
>>>>>>>>>>>>>>>>>>>> forces you to cripple driver code for checks for the current domain.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Nope, normal drivers are not affected as they just implement those
>>>>>>>>>>>>>>>>>>> services in the respective mode they want to support there and have a
>>>>>>>>>>>>>>>>>>> simple -ENOSYS for the rest (explicitly in IOCTLs or implicitly by
>>>>>>>>>>>>>>>>>>> leaving out the implementation of the counterpart handler).
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Yes, I got mixed up trying to remember. I think the crux of the
>>>>>>>>>>>>>>>>>> problem is that if a thread running in primary mode gets
>>>>>>>>>>>>>>>>>> (temporarily) switched to secondary mode by gdb, the ioctl_nrt
>>>>>>>>>>>>>>>>>> handler gets invoked, which is almost certainly the wrong thing to
>>>>>>>>>>>>>>>>>> do. You want the thread to migrate to primary mode to execute
>>>>>>>>>>>>>>>>>> ioctl_rt, which __xn_exec_conforming achieves. Otherwise running an
>>>>>>>>>>>>>>>>>> application in gdb causes the application to behave differently.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> And trying and avoiding this issue indeed cripple codes with checks
>>>>>>>>>>>>>>>>> for rtdm_in_rt_context:
>>>>>>>>>>>>>>>>> https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/analogy/rtdm_interface.c#n194
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I don't remember details here, but this is a special case: The driver
>>>>>>>>>>>>>>>> provides also read_nrt - is that really useful for Analogy?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> In most cases, you are fine with not providing the nrt (or rt) handler,
>>>>>>>>>>>>>>>> or with a simple
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> default:
>>>>>>>>>>>>>>>> 	return -ENOSYS;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> in your ioctl dispatcher.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> You are missing the point: if you enter read_nrt, there are two
>>>>>>>>>>>>>>> cases:
>>>>>>>>>>>>>>> - either the thread is real-time capable and has been relaxed by gdb
>>>>>>>>>>>>>>> and you want to switch to read_rt for the reasons I already
>>>>>>>>>>>>>>> explained, in that case, you must return -ENOSYS;
>>>>>>>>>>>>>>> - or the thread is not real-time capable and the nrt handler
>>>>>>>>>>>>>>> applies.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> So, you need at least
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> read_nrt()
>>>>>>>>>>>>>>> {
>>>>>>>>>>>>>>> 	if (rt_capable)
>>>>>>>>>>>>>>> 	     return -ENOSYS;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 	/* Do the normal case here */
>>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Now tell me how many drivers have read_nrt, write_nrt? 1 in-tree.
>>>>>>>>>>>>>> recvmsg_nrt, sendmsg_nrt? 0 in-tree. Analogy is special (still like to
>>>>>>>>>>>>>> understand why, though). And having some special code in the exceptional
>>>>>>>>>>>>>> case is probably better then the side effects we get from eagerly
>>>>>>>>>>>>>> switching now.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sorry, that is exactly the opposite: your use case is exceptional and I
>>>>>>>>>>>>> believe is wrong. The normal use case is the one that does not ask the
>>>>>>>>>>>>> user to track the current mode for knowing what any random driver would
>>>>>>>>>>>>> eventually do depending on the calling context.
>>>>>>>>>>>>
>>>>>>>>>>>> You still miss the point that this is not required in 99% of the cases.
>>>>>>>>>>>> There is no such problem. There only Analogy.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I'm not discussing Analogy at all, those drivers are still biased by the
>>>>>>>>>>> legacy 2.x logic for dealing with modes and need fixing. I have never
>>>>>>>>>>> been convinced by the reasoning behind rtdm_in_rt_context(), which
>>>>>>>>>>> perfectly illustrates why messing with the call mode is not the
>>>>>>>>>>> application's business.
>>>>>>>>>>
>>>>>>>>>> You still need rtdm_in_rt_context() for the (rare) case of having the
>>>>>>>>>> same handler for both service_rt and service_nrt. That didn't change
>>>>>>>>>> with any switching strategy adjustment. It can't as long as there are
>>>>>>>>>> services behind a syscall that may handle any mode, thus that syscall is
>>>>>>>>>> unable to filter for the service in the background. We really need to
>>>>>>>>>> differentiate here.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> Every driver must ensure that a service is only exposed to users in the
>>>>>>>>>>>> right mode. That is a functional requirement, and drivers that fail to
>>>>>>>>>>>> do so only work by chance (thus with the restricted workload they are
>>>>>>>>>>>> tested against). If that is fulfilled, it doesn't matter to the driver
>>>>>>>>>>>> when the switch happens. It's pure optimization.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> You don't seem to get my point either. Let's proceed differently, please
>>>>>>>>>>> sketch the application code that would require __xn_exec_current for
>>>>>>>>>>> RTDM calls.
>>>>>>>>>>
>>>>>>>>>> You cut the more interesting case (migration ping-pong when calling
>>>>>>>>>> non-RT drivers from relaxed threads), and I hope you will not forget to
>>>>>>>>>> answer this.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I'm not ignoring the question, I have been postponing the answer until I
>>>>>>>>> understand why the application could be put in a situation making this
>>>>>>>>> migration a problem, and whether another approach would exist for
>>>>>>>>> solving that problem within the current scheme.
>>>>>>>>
>>>>>>>> These two scenarios are unrelated: this migration issue would still be
>>>>>>>> there even if we solved the one below via a different application/driver
>>>>>>>> design.
>>>>>>>>
>>>>>>>
>>>>>>> Which starts to be an issue only because the caller is a Cobalt shadow
>>>>>>> undergoing the SCHED_WEAK policy, calling a RTDM driver for a non-rt
>>>>>>> operation very frequently. For this reason, those two scenarii are very
>>>>>>> much related.
>>>>>>
>>>>>> Not SCHED_WEAK, but being a shadow in the first place. Unless you
>>>>>> enforce non-shadow thread creation, all are shadowed in a Xenomai
>>>>>> application, thus are affected. However, asking our users to user
>>>>>> __real_pthread_create extensively may not lead to the desired portable
>>>>>> designs.
>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>>> But let's go to our case:
>>>>>>>>>>
>>>>>>>>>> We have a non-blocking service in the driver, the classic case of
>>>>>>>>>> accessing a privileged resource that userspace can't or shouldn't touch
>>>>>>>>>> directly. Think of some kind of register access that requires low-level
>>>>>>>>>> synchronization with other threads and interrupt handlers. That service
>>>>>>>>>> is called by both RT and non-RT threads (SCHED_WEAK) at higher frequency
>>>>>>>>>> (some thousand times per second). The RT threads are obviously on the
>>>>>>>>>> time critical path, must not migrate, and that can be achieved perfectly
>>>>>>>>>> already by providing that service under ioctl_rt. The non-RT threads
>>>>>>>>>> could be migrated to RT, but then they would pay an unneeded price,
>>>>>>>>>> contributing to a higher system load, in the worst case overload.
>>>>>>>>>> Therefore, the very same service shall be provided under ioctl_nrt as
>>>>>>>>>> well. Makes sense?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I understand the conflict with the "rt-always-has-precedence" rule
>>>>>>>>> implemented by the conforming state, then I have another question:
>>>>>>>>>
>>>>>>>>> assuming the nrt thread undergoes the SCHED_WEAK policy because it is
>>>>>>>>> mainly operating from the Linux space but still needs to synchronize
>>>>>>>>> with the rt side at some point, which kind of high frequency interaction
>>>>>>>>> with the rt side is this?
>>>>>>>>>
>>>>>>>>> Sharing some resource requiring mutual exclusion via a Cobalt synchro,
>>>>>>>>> waiting for rt events, something else?
>>>>>>>>>
>>>>>>>>
>>>>>>>> There synchronization need is first of all only on the hardware access
>>>>>>>> (thus inside the driver), not necessarily at application level. In fact,
>>>>>>>> there are even scenarios where you only want to exploit the driver as
>>>>>>>> permission checker on privileged resource accesses (userspace shall only
>>>>>>>> access certain MMIO registers in a page, thus the driver acts as
>>>>>>>> gatekeeper). Then there could be no synchronization at all but still the
>>>>>>>> need to provide migration-free accesses.
>>>>>>>>
>>>>>>>
>>>>>>> I get the idea of the resource gatekeeper, which does make a lot of sense.
>>>>>>>
>>>>>>> However I still don't get which benefit your caller has in undergoing
>>>>>>> the SCHED_WEAK policy - which implies that it has to share
>>>>>>> synchronization points with Cobalt - compared to running as a regular
>>>>>>> (glibc) thread, under whichever policy that could fit?
>>>>>>
>>>>>> See above: it's additional, non-portable instrumentation of your code to
>>>>>> tag non-shadowed threads. And then you may easily run into troubles in
>>>>>> larger, layered application designs that a non-shadowed thread will
>>>>>> still need a blocking Xenomai service, e.g. via some hidden dependency.
>>>>>>
>>>>>>>
>>>>>>> Leaving the non-RT ioctl call aside, which are those Cobalt calls the
>>>>>>> SCHED_WEAK thread needs to invoke for synchronizing with rt threads?
>>>>>>
>>>>>> I don't have these details at hand, but let's consider a large layered
>>>>>> application that also does significant work against Linux APIs during
>>>>>> runtime. You can't always enforce the complete separation. Because if
>>>>>> you can, you could also move the non-RT part into a separate process
>>>>>> that has nothing to do with Xenomai.
>>>>>>
>>>>>> We promote the transparency of the Xenomai POSIX interface, and that
>>>>>> should not make the usage of non-Xenomai services needlessly expensive
>>>>>> or require extensive non-portable tagging via __real_ prefixes.
>>>>>>
>>>>>
>>>>> Ping on this still open topic (will now have to introduce a local patch
>>>>> that restores the original behaviour). Can we resolve the issue upstream
>>>>> as well?
>>>>>
>>>>
>>>> Restoring the original behavior unconditionally would not be a fix but
>>>> only a work-around for your own issue. Finding a better way acceptable
>>>> to all parties is on my todo list for the upcoming 3.0.3.
>>>
>>> We don't have all the issues, as I pointed out. It is a significant
>>> deficit of current Xenomai that you now have to create non-Xenomai
>>> threads explicitly (__real_pthread_create) in order to use Linux I/O
>>> syscalls efficiently (because of the otherwise enforces migration
>>> ping-pong). We didn't have that problem with the original design.
>>>
>>
>> Again, your application has a problem: it expects a real-time API to
>> operate as a non real-time API. This is wrong, really. The __real prefix
>> is a selector to pick the non-conforming API when symbol wrapping is in
>> effect, nothing more.
>>
>> You are clearly misinterpreting what Xenomai is about in that case, it
>> is about providing a subset of the real-time POSIX API which can be
>> seamlessly used conforming to the standard, for real-time purposes.
>>
>> It is definitely not about providing a way to run a non real-time thread
>> by calling the real-time API. This is why your application sees mode
>> switches, otherwise it would not. Please let's move on away from this
>> flawed argument, it does not help thinking constructively.
>>
>> I'm ok to help finding a solution, but please don't try to sell me such
>> broken idea as a de facto Xenomai standard. It has never been so.
>>
> 
> I don't need to sell this "idea" to you. It is not my idea. It is a
> typical valid use case of Xenomai - colocated RT and non-RT workload in
> the same process (that is a value of Xenomai!

Correct. This means using the proper API for that. This is basically
what the dual kernel approach is all about: the real-time purpose
implies to use a separate API.

-- 
Philippe.

