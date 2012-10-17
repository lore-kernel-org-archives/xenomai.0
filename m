Message-ID: <507EAC59.6000909@mind.be>
Date: Wed, 17 Oct 2012 15:02:17 +0200
From: Arnout Vandecappelle <arnout@mind.be>
MIME-Version: 1.0
References: <507E9654.5020503@mind.be> <507EA55E.6010506@xenomai.org>
In-Reply-To: <507EA55E.6010506@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 17/10/12 14:32, Gilles Chanteperdrix wrote:
> On 10/17/2012 01:28 PM, Arnout Vandecappelle wrote:
>>     Hoi,
>>
>>     I noticed that when using the native skin, starting an application with
>> "taskset 2<my_app>" does not put the application on processor 2.  Diving into
>> the code, it turns out that calling rt_task_shadow() throws away the thread's
>> cpuset,
>
> That is an issue.

  With cpuset, I mean the Linux cpuset, i.e. current->cpus_allowed.  There
may have been some misunderstanding about this.


>> and also rt_task_create() looks only at the mode parameter and ignores
>> the parent thread's affinity.
>
> That does not look like an issue. Why should a task inherit its parent's
> affinity.

  I don't know if it should - it's not specified in the documentation.  But
it is how posix threads behave.

  Also, if the affinity is not inherited, there isn't much point of having
more than one processor in it, because nucleus will just fix the task to
the first cpu of the set (if I understand correctly).


>>     Is this intentional?  If yes, that means that using the native skin, there
>> is no way to set a task's affinity except explicitly specifying T_CPU when
>> the task is started, right?
>
> No, this looks like a different issue.
>
>>
>>     Note, by the way, that calling sched_setaffinity _after_ the task has started
>> _will_ change the affinity (cfr. switchtest), but any calls _before_ the task
>> has started are ignored.
>
> Well, if the thread is not created, how sched_setaffinity change its
> affinity?

  The (shadow) thread is created, but with a different cpuset than the
Linux thread.  Or rather, the cpuset is changed by shadowing the thread.

  Regards,
  Arnout

-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F

