Message-ID: <507EDDF1.8090904@mind.be>
Date: Wed, 17 Oct 2012 18:33:53 +0200
From: Arnout Vandecappelle <arnout@mind.be>
MIME-Version: 1.0
References: <507E9654.5020503@mind.be> <507EA55E.6010506@xenomai.org>
	<507EAC59.6000909@mind.be> <507EAE5E.5060200@xenomai.org>
In-Reply-To: <507EAE5E.5060200@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 17/10/12 15:10, Gilles Chanteperdrix wrote:
> On 10/17/2012 03:02 PM, Arnout Vandecappelle wrote:
>> On 17/10/12 14:32, Gilles Chanteperdrix wrote:
>>> On 10/17/2012 01:28 PM, Arnout Vandecappelle wrote:
[snip]
>>>> and also rt_task_create() looks only at the mode parameter and ignores
>>>> the parent thread's affinity.
>>>
>>> That does not look like an issue. Why should a task inherit its parent's
>>> affinity.
>>
>>    I don't know if it should - it's not specified in the documentation.  But
>> it is how posix threads behave.
>
> Ok. That is an argument. But if an affinity is specified by the mode
> argument, it should override the parent's affinity.

  OK.  Would you like me to refresh my patch?


[snip]
>>>>      Note, by the way, that calling sched_setaffinity _after_ the task has started
>>>> _will_ change the affinity (cfr. switchtest), but any calls _before_ the task
>>>> has started are ignored.
>>>
>>> Well, if the thread is not created, how sched_setaffinity change its
>>> affinity?
>>
>>    The (shadow) thread is created, but with a different cpuset than the
>> Linux thread.  Or rather, the cpuset is changed by shadowing the thread.
>
> Ok, misunderstanding again, for me, when you say "before the task has
> started" clearly means that you are talking about a task created with
> rt_task_create.

  Yes, that's what I mean.

When you do:

CPU_SET(1, &cpuset);
sched_setaffinity(0, sizeof(cpuset), &cpuset);
rt_task_shadow(&task, "test", 99, 0);

then rt_task_shadow will migrate the thread from cpu 1 to cpu 0,
so it migrates twice overall (assuming Linux had started it on cpu 0).

When you do:

rt_task_shadow(&task, "test", 99, 0);
CPU_SET(1, &cpuset);
sched_setaffinity(0, sizeof(cpuset), &cpuset);

then sched_setaffinity will migrate the thread from cpu 0 to cpu 1.

  My point was that it seems inconsistent that it makes a difference
in which order you shadow the task and you specify which cpu it should
run on.

  Alternatively, you could document in rt_task_shadow that it will
implicitly migrate to the lowest CPU (even if that's not the one we're
currently executing on).


  Regards,
  Arnout
-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F

