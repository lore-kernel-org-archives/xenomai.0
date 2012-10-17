Message-ID: <507EA55E.6010506@xenomai.org>
Date: Wed, 17 Oct 2012 14:32:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507E9654.5020503@mind.be>
In-Reply-To: <507E9654.5020503@mind.be>
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

On 10/17/2012 01:28 PM, Arnout Vandecappelle wrote:
>    Hoi,
> 
>    I noticed that when using the native skin, starting an application with
> "taskset 2 <my_app>" does not put the application on processor 2.  Diving into
> the code, it turns out that calling rt_task_shadow() throws away the thread's
> cpuset,

That is an issue.

> and also rt_task_create() looks only at the mode parameter and ignores
> the parent thread's affinity.

That does not look like an issue. Why should a task inherit its parent's
affinity.

> 
>    Is this intentional?  If yes, that means that using the native skin, there
> is no way to set a task's affinity except explicitly specifying T_CPU when
> the task is started, right?

No, this looks like a different issue.

> 
>    Note, by the way, that calling sched_setaffinity _after_ the task has started
> _will_ change the affinity (cfr. switchtest), but any calls _before_ the task
> has started are ignored.

Well, if the thread is not created, how sched_setaffinity change its
affinity?

-- 
					    Gilles.

