Message-ID: <507F0E11.1080204@xenomai.org>
Date: Wed, 17 Oct 2012 21:59:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507E9654.5020503@mind.be> <507EA55E.6010506@xenomai.org>
	<507EAC59.6000909@mind.be> <507EAE5E.5060200@xenomai.org>
	<507EDDF1.8090904@mind.be>
In-Reply-To: <507EDDF1.8090904@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Native skin rt_task_create/rt_task_shadow doesn't
 inherit affinity
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arnout Vandecappelle <arnout@mind.be>
Cc: xenomai@xenomai.org

On 10/17/2012 06:33 PM, Arnout Vandecappelle wrote:

> On 17/10/12 15:10, Gilles Chanteperdrix wrote:
>> On 10/17/2012 03:02 PM, Arnout Vandecappelle wrote:
>>> On 17/10/12 14:32, Gilles Chanteperdrix wrote:
>>>> On 10/17/2012 01:28 PM, Arnout Vandecappelle wrote:
> [snip]
>>>>> and also rt_task_create() looks only at the mode parameter and ignores
>>>>> the parent thread's affinity.
>>>>
>>>> That does not look like an issue. Why should a task inherit its parent's
>>>> affinity.
>>>
>>>    I don't know if it should - it's not specified in the documentation.  But
>>> it is how posix threads behave.
>>
>> Ok. That is an argument. But if an affinity is specified by the mode
>> argument, it should override the parent's affinity.
> 
>   OK.  Would you like me to refresh my patch?


Yes, please.

> 
> 
> [snip]
>>>>>      Note, by the way, that calling sched_setaffinity _after_ the task has started
>>>>> _will_ change the affinity (cfr. switchtest), but any calls _before_ the task
>>>>> has started are ignored.
>>>>
>>>> Well, if the thread is not created, how sched_setaffinity change its
>>>> affinity?
>>>
>>>    The (shadow) thread is created, but with a different cpuset than the
>>> Linux thread.  Or rather, the cpuset is changed by shadowing the thread.
>>
>> Ok, misunderstanding again, for me, when you say "before the task has
>> started" clearly means that you are talking about a task created with
>> rt_task_create.
> 
>   Yes, that's what I mean.
> 
> When you do:
> 
> CPU_SET(1, &cpuset);
> sched_setaffinity(0, sizeof(cpuset), &cpuset);
> rt_task_shadow(&task, "test", 99, 0);
> 
> then rt_task_shadow will migrate the thread from cpu 1 to cpu 0,
> so it migrates twice overall (assuming Linux had started it on cpu 0).
> 
> When you do:
> 
> rt_task_shadow(&task, "test", 99, 0);
> CPU_SET(1, &cpuset);
> sched_setaffinity(0, sizeof(cpuset), &cpuset);
> 
> then sched_setaffinity will migrate the thread from cpu 0 to cpu 1.
> 
>   My point was that it seems inconsistent that it makes a difference
> in which order you shadow the task and you specify which cpu it should
> run on.


Yes, I got it, we need to fix that too.

Regards.

-- 
                                                                Gilles.

