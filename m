Message-ID: <507EAE5E.5060200@xenomai.org>
Date: Wed, 17 Oct 2012 15:10:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507E9654.5020503@mind.be> <507EA55E.6010506@xenomai.org>
	<507EAC59.6000909@mind.be>
In-Reply-To: <507EAC59.6000909@mind.be>
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

On 10/17/2012 03:02 PM, Arnout Vandecappelle wrote:
> On 17/10/12 14:32, Gilles Chanteperdrix wrote:
>> On 10/17/2012 01:28 PM, Arnout Vandecappelle wrote:
>>>     Hoi,
>>>
>>>     I noticed that when using the native skin, starting an application with
>>> "taskset 2<my_app>" does not put the application on processor 2.  Diving into
>>> the code, it turns out that calling rt_task_shadow() throws away the thread's
>>> cpuset,
>>
>> That is an issue.
> 
>   With cpuset, I mean the Linux cpuset, i.e. current->cpus_allowed.  There
> may have been some misunderstanding about this.
> 
> 
>>> and also rt_task_create() looks only at the mode parameter and ignores
>>> the parent thread's affinity.
>>
>> That does not look like an issue. Why should a task inherit its parent's
>> affinity.
> 
>   I don't know if it should - it's not specified in the documentation.  But
> it is how posix threads behave.

Ok. That is an argument. But if an affinity is specified by the mode
argument, it should override the parent's affinity.

> 
>   Also, if the affinity is not inherited, there isn't much point of having
> more than one processor in it, because nucleus will just fix the task to
> the first cpu of the set (if I understand correctly).

You understand correctly, Xenomai does not do any automatic migration.
So, there is no point in having more than one cpu in the affinity mask
for a xenomai task.

> 
> 
>>>     Is this intentional?  If yes, that means that using the native skin, there
>>> is no way to set a task's affinity except explicitly specifying T_CPU when
>>> the task is started, right?
>>
>> No, this looks like a different issue.
>>
>>>
>>>     Note, by the way, that calling sched_setaffinity _after_ the task has started
>>> _will_ change the affinity (cfr. switchtest), but any calls _before_ the task
>>> has started are ignored.
>>
>> Well, if the thread is not created, how sched_setaffinity change its
>> affinity?
> 
>   The (shadow) thread is created, but with a different cpuset than the
> Linux thread.  Or rather, the cpuset is changed by shadowing the thread.

Ok, misunderstanding again, for me, when you say "before the task has
started" clearly means that you are talking about a task created with
rt_task_create.

-- 
					    Gilles.

