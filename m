Message-ID: <48B41527.70507@domain.hid>
Date: Tue, 26 Aug 2008 16:37:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B3FD37.4060701@domain.hid>
	<dcca602eeac0de54e5e7095d60c77710@domain.hid>
In-Reply-To: <dcca602eeac0de54e5e7095d60c77710@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with tcb.handle and taskDesc.td_tid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
> 
> On Tue, 26 Aug 2008 14:55:19 +0200, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>> Matthieu wrote:
>>>> Hi
>>>>
>>>> I would like to understand the coherence between the task identifier of
>> the
>>>> task control block and the task id given by taskDesk (function
>>>> taskInfoGet()). In fact, I init a task with taskInit, I get the tid
>> using
>>>> tid=tcb.handle. The use of taskInfoGet(tid, taskDesc) gives me a
>>>> taskDesk.td_tid different from the tid.
>>>>
>>>> I want to test if the task is suspended using taskIsSuspended(tid) or
>>>> taskIsSuspended(taskDesc.td_tid), but both get me  a 3d0001 errno (code
>>>> error of WIND_OBJ_ERR_BASE S_objLib_OBJ_ID_ERROR). The PID given by
>>>> /proc/xenomai/stat also has no connection. Idem with a ps -AfL
>>>>
>>>> Thank you in advance for your explanations
>>> You are not supposed to use the internal fields of the structures. A
>>> valid id is one returned by the taskIdSelf(), taskNameToId(),
>>> taskIdDefault(). I can not find a service which returns the task Id for
>>> a given TCB. Is it what you are looking for ?
>> By the way, if you could call taskInfoGet, you already have a valid task
>> id...
>>
> 
> But using taskNameToId, taskSuspend(tid) makes the same error and so is
> taskInfoGet().

Ok. So, we have a bug and these functions do not work as expected.

In the sources, I saw that taskInfoGet seems to be a
> reentrant routine (see ksrc/skins/vxworks/syscall.c where a taskInfoGet is
> call in the taskInfoGet routine) 

If by reentrant you mean recursive, no, not at all, taskInfoGet is not
recursive. You see, the interface between user-space and kernel-space is
not a simple function call, it is a system call, that is the way the
whole Linux kernel works. The difference between Linux and Xenomai is
that Xenomai APIs are symetric between kernel-space and user-space. So,
the function implementing a kernel-space service is used to implement
the system call used by the user-space service of the same name.

What you see in ksrc/skins/vxworks/syscall.c is that the function
__wind_task_info_get, which is the handler of the vxworks skin
__vxworks_taskinfo_get system call, calls the kernel-space taskInfoGet
function, so there is no recursion.
in src/skins/vxworks/taskInfo.c, you will see that the taskInfoGet
function emits the _vxworks_taskinfo_get system call.

-- 
                                                 Gilles.

