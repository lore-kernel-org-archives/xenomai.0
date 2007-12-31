Message-ID: <2ff1a98a0712310616n58d0a63en4c36e75e5ed2ab53@domain.hid>
Date: Mon, 31 Dec 2007 15:16:43 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <8b3b30860712301217p6ee4e724lebd1b1c2740d2ebf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
	<2ff1a98a0712280630t7d524928r2f66355fd0731d67@domain.hid>
	<8b3b30860712301217p6ee4e724lebd1b1c2740d2ebf@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 30, 2007 9:17 PM, Racconico Lambrati
<racconico.lambrati@domain.hid> wrote:
> I've done some works, and searched in xenomai's native function.
>
> To replace SysClkConnect I've created a periodic task with priority=90 that
> wait 5ms.
> The last operation in a task's cycle is semGive(gServiceSem);
> A second task, non periodic, have as first operation of the cycle
> semTake(gServiceSem,WAIT_FOREVER);
> the second task has priority=50
>
> when the total time for one cycle of task1 and task2 everything seems run
> properly , when task2 take more then 5ms for do it's cycle
> rt_task_wait_period(NULL) return me 146 and not 0, and the time for task1 is
> not respected.
>
> This sound strange for me, why the scheduler don't switch the task in
> execution?

This looks strange, could you try and reduce your application to a
simple example which exhibits the same behaviour ? Maybe you lock the
scheduler with taskLock/taskUnlock ?

> A second question is, if can I change (TaskIdSelf() == IdTask) with
> (rt_task_self() == &IdTask)?

No, the task id spaces are distinct. You can only use TaskIdSelf in a
vxworks skin task (created with taskInit or taskSpawn) and
rt_task_self with a native skin task (created with rt_task_create).
You can use most native skin services (such as rt_task_set_periodic
with a NULL task id) in  a vxworks skin task, but vxworks skin
services expect a vxworks skin task. If I were you, I would use only
vxworks skin services (for example, watchdog services to make a task
perdioc).

-- 
                                               Gilles Chanteperdrix

