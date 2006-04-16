Message-ID: <44421C1A.9040001@domain.hid>
Date: Sun, 16 Apr 2006 12:27:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200604101640.04255.lbocseg@domain.hid>	<443BA12F.9020505@domain.hid>
	<443BB6B3.8060601@domain.hid> <443C109F.5080208@domain.hid>
	<443C148C.1060504@domain.hid> <443C1F49.30002@domain.hid>
In-Reply-To: <443C1F49.30002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_delete() behaviour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
>>>>Anyway, leaving a native task with rt_task_delete(NULL) raises SIGKILL
>>>>to the whole process instead of just the task (pthread). This lets your
>>>>program terminate unexpectedly - I would say: a bug. And this doesn't
>>>>happen with 2.1?
>>>>
>>>
>>>It's a side-effect of a recent bug fix in ksrc/nucleus/shadow.c; now
>>>killing
>>
>>Er, "deleting" is the right word here. Sending a thread a termination
>>signal must kill the entire process as per POSIX, and will continue to
>>do so. Calling rt_task_delete() to explicitely delete a single thread
>>from within the containing process is another story. The current issue
>>is due to the fact that no distinction is made on the caller:
>>rt_task_delete() targeting a thread from another process should wipe out
>>the entire target process; otherwise, only the local target thread
>>should be deleted. It's not clear whether we should still wipe out the
>>entire process when the target thread is not the current one, regardless
>>of the fact such thread is a member of the same process or not.
>>I'm open to suggestions.
> 
> 
> Killing other threads within the same process currently only works due
> to pthread_cancel. I don't see a portable equivalent for foreign
> processes yet as well. :-/
>
> I guess the thread termination signal sent by pthread_cancel depends on
> glibc internals, specifically its variant (NTPL or linux-threads),
> doesn't it? Didn't we already have this discussion??
>

Actually, the issue is different, it depends on the underlying kernel 
support; it's Xenomai's shadow manager who sends the termination signal 
when demoting threads from kernel space, the pthread API is not involved 
here. The nucleus happens to kill the thread group over 2.6 because 
thread group support is fully implemented on this kernel, and calling 
the kill_proc() API with a termination signal would properly kill all 
threads belonging to the group the target thread belongs to. This does 
not work over 2.4 which puts every new thread in its own group by 
default, de facto making it as a group leader, regardless of the 
CLONE_THREAD attribute being set or not when the glibc calls the clone() 
service. IOW, you actually end up having two different behaviours when 
calling rt_task_delete() whether 2.4 or 2.6 is considered, even if both 
setups rely on the NPTL on the application side.

> For now I would say the best we can do is to avoid the
> rt_task_delete(NULL) side effect in userspace (as I suggested) and live
> with the limitation of terminating the whole process when using the
> (rather unusual) cross-process rt_task_delete.
> 

This would not be a limitation in some cases actually: e.g. continuing 
an application that had thread(s) killed from another _process_ would be 
most often meaningless.

> 
>> a thread raises a group signal wiping out the entire process.
>>
>>>Ok, it's a bit drastic, will fix.
>>>
>>>
>>>>I guess the easiest way to solve this is to catch NULL in userspace and
>>>>call pthread_exit() in favour of the skin service (the POSIX skin uses
>>>>pthread_exit anyway), see attached patch. Someone just has to confirm
>>>>that there will be no problem hidden by this approach.
>>>
>>>
>>>Passing NULL needs to work including from user-space; the kernel-space
>>>is ok with this, and the API must behave the same way regardless of
>>>the execution space. Should fix as needed.
>>>
>>>
>>>>Jan
>>>>
>>>>
>>>>PS: What's the reason for "if (err == -ESRCH) return 0" in
>>>>src/skins/native/task.c, rt_task_delete? Why is that error generate in
>>>>the first place if it is zeroed out here?
>>>>
> 
> 
> <attention: unanswered question above> ;)
> 

I don't think I've coded this stuff, but reading it, I would say that 
since the preceding call to pthread_cancel() might have caused the 
target thread to be wiped out before the nucleus syscall is issued, 
-ESRCH would not be a real error.

> Jan
> 


-- 

Philippe.

