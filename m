Message-ID: <50D3AD33.5070803@xenomai.org>
Date: Fri, 21 Dec 2012 01:28:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50CCEA7E.1080000__518.307140055363$1355606686$gmane$org@xenomai.org>
	<50CCF3B8.5000201@linux-kernel.net>
	<50CCF6C4.80408@xenomai.org> <50D05218.1080406@web.de>
	<50D081EB.6080800@xenomai.org> <50D084A7.8080508@siemens.com>
	<50D22C63.6060800@xenomai.org> <50D33B52.6010301@siemens.com>
	<50D33BF4.5030506@xenomai.org> <50D33DFC.3010006@siemens.com>
In-Reply-To: <50D33DFC.3010006@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] core-3.5 for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: Wolfgang Mauerer <wm@linux-kernel.net>, Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/20/2012 05:34 PM, Wolfgang Mauerer wrote:

> On 20/12/12 17:25, Gilles Chanteperdrix wrote:
>> On 12/20/2012 05:22 PM, Wolfgang Mauerer wrote:
>>> On 19/12/12 22:06, Gilles Chanteperdrix wrote:
>>>> On 12/18/2012 03:58 PM, Wolfgang Mauerer wrote:
>>>>
>>>>> On 18/12/12 15:47, Gilles Chanteperdrix wrote:
>>>>>> On 12/18/2012 12:23 PM, Jan Kiszka wrote:
>>>>>>> On 2012-12-15 20:16, Gilles Chanteperdrix wrote:
>>>>>>>> On 12/15/2012 11:03 PM, Wolfgang Mauerer wrote:
>>>>>>>>
>>>>>>>>> Hi Gilles,
>>>>>>>>>
>>>>>>>>> On 15/12/2012 22:24, Gilles Chanteperdrix wrote:
>>>>>>>>>
>>>>>>>>>> I see some (recent) activity on this git repository:
>>>>>>>>>> https://github.com/siemens/ipipe/commits/core-3.5_for-upstream
>>>>>>>>>>
>>>>>>>>>> In what state is this branch, can I pull from it?
>>>>>>>>> please don't pull yet, I need to port a few more patches forward
>>>>>>>>> and fix one known issue with the tree. But I'll try to send a
>>>>>>>>> pull/discussion request next week.
>>>>>>>>>
>>>>>>>>>> At least the changes allowing preempt_disable()/preempt_enable() to be
>>>>>>>>>> called from non-root context look dubious.
>>>>>>>>> are you referring to 767f0d43fe3? This one still carries a TODO
>>>>>>>>> item in the description to remind me to check with which
>>>>>>>>> non-x86 archs this can cause problems, and what we can do about
>>>>>>>>> them.
>>>>>>>>
>>>>>>>>
>>>>>>>> Actually, we already have ipipe_safe_current(), so I guess what you need
>>>>>>>> is ipipe_safe_current_thread_info() ?
>>>>>>>
>>>>>>> That cannot work unless you patch all the ftrace and perf stack - which
>>>>>>> would surely not be a good idea /wrt maintainability.
>>>>>>>
>>>>>>> The point is remove the instrumentation from preempt_disable/enable at
>>>>>>> least on those archs that do not need it. And then to look at the archs
>>>>>>> that still have stack-based thread_info, if we cannot change this, at
>>>>>>> least for CONFIG_IPIPE enabled.
>>>>> are you talking about moving the arch's thread_info away from the stack
>>>>> to some per-processor area like x86's PDA? At a first glance, that
>>>>> sounds more invasive than changing preempt_xyz() in perf and ftrace
>>>>> to me, especially since the changes to perf/ftrace should be fairly
>>>>> straightforward -- just replace calls to preempt_xyz with calls
>>>>> to preempt_xyz_save() based on ipipe_safe_current_thread_info().
>>>>>
>>>>> The easiest thing is to simply say that perf and ftrace are not
>>>>> supported on archs that cannot reliably read thread_info from non-root
>>>>> context, but that does not seem very attractive to me.
>>>>
>>>>
>>>> What I am talking about is:
>>>> - defining preempt_disable/preempt_enable to be
>>>> ipipe_safe_preempt_disable/ipipe_safe_preempt_enable when CONFIG_FTRACE
>>>> or CONFIG_PERF is on
>>>> - for x86_64 (because even on x86_32, preempt_enable/disable use the
>>>> stack pointer) definee ipipe_safe_preempt_disable/enable to be normal
>>>> versions
>>>>
>>>> Now, if you think the implementation of
>>>> ipipe_safe_preempt_disable/enable I propose for non x86 architectures is
>>>> not what should be done, then do not define anything and generate a
>>>> #error when ipipe_safe_preempt_disable/enable are not defined (and
>>>> ftrace or perf are on).
>>> no, your proposal is quite fine. But I guess it would be advantageous
>>> if we could keep the root-only checks in all preempt code except
>>> when employed for ftrace and  perf. This can be done by
>>> exchanging the preempt_xyz() calls in the appropriate files to the
>>> variants based on ipipe_safe_*(), and leave the rest unmodified.
>>> How's that sound? I'm trying to finish the patch soon, but there are
>>> unfortunately lots of other commitments towards the end of the year.
>>
>>  From what I understood from Jan answer, we want to avoid that for ease
>> of maintenance.
> I don't think maintenance would be so painful, so I'd like to at least
> discuss the corresponding patch later.
>>
>>>
>>>>
>>>>>>
>>>>>> The problem is the "then", we can not stay with a solution which works
>>>>>> only for x86_64. The current contents of the github tree which disables
>>>>>> the ipipe_root_context check on all architectures can not be merged as is.
>>>>>
>>>>> sure, the tree cannot be merged as is. That's why I asked for some more
>>>>> time ;)
>>>   >
>>>> The thing is, I would like to release before next week-end... I know I
>>>> have waited many monthes, but this has to take place at some point...
>>>
>>> oh, sorry, I was not aware of a release deadline. Knowing it would have
>>> been beneficial for the planning... But if you want to release soon,
>>> then how about just dropping support for ftrace and perf? I can prepare
>>> a corresponding tree for this scenario if you like.
>>
>> It would be great, thanks.
> okay, will do. Most likely not today, but tomorrow.


Hi Wolfgang,

I restarted from your commit 4b451bb6508b3a2f27b6d0e5c1d813f4f109abdb
and fixed a few issues on x86_32 and x86_64 UP. The result is here:
http://git.xenomai.org/ipipe-gch.git/?p=ipipe-gch.git;a=shortlog;h=refs/heads/for-core-3.5

I am currently running tests on my xe86 machines.
It would be nice if you could check whether it still works for your case.

Regards.

-- 
                                                                Gilles.

