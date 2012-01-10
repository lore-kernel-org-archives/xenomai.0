Message-ID: <4F0C5524.9020501@domain.hid>
Date: Tue, 10 Jan 2012 16:11:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F0B530A.80905@domain.hid>
In-Reply-To: <4F0B530A.80905@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Issue with Auto relax and nested mutexes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/09/2012 09:50 PM, Makarand Pradhan wrote:
> Hi,
>
> I am running kernel 3.0.0, xenomai: 2.6, powerpc 8360.
>
> I am noticing an issue while using the auto relax feature related to
> mutexes. I am using nested mutexes. The code is attached to this email.
>
> The problem is that I am not relaxing after a RT thread grabs and
> releases a mutex. On further investigation, it was noted that the rescnt
> is not going down to 0.

 From your code, task1 would auto-relax only if started with priority 0, 
which is what I get here:

-bash-3.2# ./relax 0 1
Spawning: tasks
bP: 0, cp: 0, mode: 0
Acquire complete
Release complete
bP: 0, cp: 0, mode: 0
Acquire complete
Release complete
bP: 0, cp: 0, mode: 0
Acquire complete
Release complete
...

Conversely, I get the right behavior if setting a non-zero priority to 
task1:

-bash-3.2# ./relax 1 0
Spawning: tasks
bP: 1, cp: 1, mode: 1
Acquire complete
Release complete
bP: 1, cp: 1, mode: 1
Acquire complete
Release complete
bP: 1, cp: 1, mode: 1
Acquire complete
...

In any case, the priority of task2 should have no impact on the result.

I'm running current 2.6 HEAD commit (168da46de), kernel 3.1.5/powerpc32 
(52xx), pipeline 2.13-06.

Which priority arguments are you passing to your test program?

> Another observation is that I do not hit
> rt_mutex_release in the kernel in the problem scenario, I believe when
> the thread undergoes a priority inversion.This may be a problem as the
> rescnt would not get decremented. Not sure how the mutex is releasing
> wiithout hitting rt_mutex_relase or am I missing anything?
>

These are fast mutexes, the thread does not have to jump to kernel space 
unless the released mutex was actually contented.

> If I have both the tasks running at priority 0, I stay in the secondary
> domain, rt_mutex_release is invoked as expected, the rescnt goes down to
> 0 when all the mutexes are released.
>
> Has anyone faced this problem?
>

I'm unsure there is any yet. Auto-relax applies to non -rt Xenomai 
threads only (i.e. prio == 0).

> Rgds,
> Makarand
>
>
>
>
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

