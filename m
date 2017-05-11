References: <CALC3Xwp-pSsQ+hF6bZFyT7BCrTOE2o0G4A3_hgD7o4i=9hdO7Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8ddcffac-78ab-3933-f5bf-1352f1af6a1d@xenomai.org>
Date: Thu, 11 May 2017 17:17:19 +0200
MIME-Version: 1.0
In-Reply-To: <CALC3Xwp-pSsQ+hF6bZFyT7BCrTOE2o0G4A3_hgD7o4i=9hdO7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Problem with the priority of the task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Aur=c3=a9lien_Le_Floc'h?= <le.floch.aurelien94@gmail.com>, xenomai@xenomai.org

On 05/11/2017 03:45 PM, Aurélien Le Floc'h wrote:
> Now I want to use a special function called StartTask to create my thread.
> This function is called also with a rt_task and she is non-preemptible
> (T_LOCK in argument of rt_task_create). The goal is when you are in the
> StartTask you can call a new task like the first program but you can also
> terminate the calling task. That is the goal.
>

I'm unsure to understand the requirement for an intermediate task, but
that is not related to the issue anyway.

> In the second example 2) you can see that with one children the output is
> as excepted, depending on the priority that you give at the entry of the
> program.
> 
> However if the father try to create two children like in the program 3) the
> thread doesn’t respect the priority at all.
> 
A co-kernel thread is fundamentally an extended regular Linux thread, so
we have to create a regular thread first. Since this operation has to be
carried out by the regular kernel, the parent thread has to migrate to
secondary mode when instantiating a new thread. Therefore, thread
creation is not covered by the real-time guarantee.

T_LOCK won't help in any way mitigating this, since it locks the
co-kernel's scheduler. A co-kernel thread switching to secondary mode
will implicitly drop that lock before suspending Cobalt-wise,
re-acquiring it when resuming back to primary mode.

Now, the alchemy and posix interfaces mitigate the issue by addressing
the most obvious priority inversion between the parent and its child, by
synchronizing both during the thread creation process, so that a high
priority child enters the user routine before the parent returns from
the thread creation call.

However, this guarantee does not extend beyond this, and specifically,
your code cannot assume that a pre-existing, mid-priority thread which
is ready to run in primary mode won't preempt the parent as it spawns
yet another child, due to the secondary mode switch.

IOW, the StartTask() pattern is creating the issue, as it calls
rt_task_create(); likewise for the posix example.
If such proxy task for starting new tasks is a requirement, you should
have it running continuously, accepting creation requests from a queue
or whatever fits the bill, so that the caller does not have to spawn a
new proxy each time (which looks quite overkill btw). Unlike
rt_task_create(), rt_task_start() does not trigger any migration to
secondary mode, therefore no priority inversion would happen.

Also, please note that mlockall() is redundant with Xenomai 3, libcobalt
low inits already did this for your application before entering the
main() routine. Finally, T_LOCK is a relic from the dark ages of RTOSes
which is present only for people who have legacy code to port and want
to get away with it. But fundamentally, locking the entire scheduler for
protecting a particular critical section is just like controlling
traffic flows of an entire city with a single traffic light.

-- 
Philippe.

