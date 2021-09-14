Subject: Re: Xenomai 3: Wierd problem resuming task
References: <7321df79-b945-d152-4bb0-7792189bac2a@tin.it>
 <87k0lq79a0.fsf@xenomai.org> <e2aa120a-d4da-f288-fedc-ccd5823e5587@tin.it>
 <87h7gu71bk.fsf@xenomai.org> <d8dfdd00-7a27-1256-15e5-93248dc66ce7@tin.it>
From: "Mauro S." <mau.salvi@tin.it>
Message-ID: <01011b00-6c16-36c9-12e5-2b3abe270e48@tin.it>
Date: Tue, 14 Sep 2021 16:09:38 +0200
MIME-Version: 1.0
In-Reply-To: <d8dfdd00-7a27-1256-15e5-93248dc66ce7@tin.it>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Language: it-IT
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 19/07/21 10:10, Mauro S. via Xenomai ha scritto:
> Il 16/07/21 16:58, Philippe Gerum ha scritto:
>>
>> Mauro S. <mau.salvi@tin.it> writes:
>>
>>> Il 16/07/21 14:06, Philippe Gerum ha scritto:
>>>> Mauro S. via Xenomai <xenomai@xenomai.org> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> I'm using Xenomai3 (master branch, commit
>>>>> bca41678742be80c3a0d5a01935c671c385a95a1) on a X86_64bit Intel Atom
>>>>> x5-E8000 with 2GB RAM, using kernel from Xenomai repos, in Cobalt
>>>>> coniguration. SMI workaround is enabled and all latency tests are
>>>>> good.
>>>>>
>>>>> I'm facing with a very weird problem in my application. I have some
>>>>> tasks with priority < 90 that call rt_task_suspend() on themselves.
>>>>> Then, I have a task with priority 99 that resumes all other tasks with
>>>>> rt_task_resume(), when they are suspended.
>>>>>
>>>>> Sometimes a task does not get resumed.
>>>>>
>>>>> In /proc/xenomai/sched/stat I have this status for my suspendend task:
>>>>>
>>>>> CPU=A0 PID=A0=A0=A0 MSW=A0=A0=A0=A0=A0=A0=A0 CSW=A0=A0=A0=A0=A0=A0=A0=
 XSC=A0=A0=A0=A0=A0=A0=A0 PF=A0=A0=A0 STAT=A0=A0=A0=A0=A0=A0 %CPU =20
>>>>> NAME
>>>>> =A0=A0=A0 1=A0 620=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0 8=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 13=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0 00048041=A0=A0=
=A0 0.0
>>>>> t12
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>>> That bit (XNSUSP) indicates that the core thinks the task is still
>>>> in
>>>> suspended state.
>>>>
>>>>>
>>>>> Analizing the scenario attaching gdb to the application, I observe
>>>>> that the not-resuming task has this backtrace:
>>>>>
>>>>> #0=A0 0x00007f0ec14c9b38 in __cobalt_kill (pid=3D620, sig=3D65) at=20
>>>>> signal.c:100
>>>>> 100=A0=A0=A0 signal.c: No such file or directory.
>>>>> (gdb) bt
>>>>> #0=A0 0x00007f0ec14c9b38 in __cobalt_kill (pid=3D620, sig=3D65) at=20
>>>>> signal.c:100
>>>>> #1=A0 0x00007f0ec14eb379 in threadobj_suspend
>>>>> =A0=A0 (thobj=3Dthobj@entry=3D0x7f0ec06bfcd0) at threadobj.c:335
>>>>> #2=A0 0x00007f0ec15013dc in rt_task_suspend (task=3Dtask@entry=3D0x0)=
 at
>>>>> =A0=A0 task.c:1154
>>>>>
>>>>> that seems to me OK. If I understood correctly, it is locked in its
>>>>> SIGSUSP handler, that calls sigsuspend() waiting SIGRESM to "restart".
>>>>>
>>>>> Then, I placed some breakpoints where rt_task_resume() were called,
>>>>> and in rt_task_resume() itself. I set tcb->suspends=3D1 with GDB and
>>>>> followed the subsequent call of threadobj_resume(). Then, I placed
>>>>> some breakpoints in threadobj_resume, I forced __THREAD_S_SUSPENDED
>>>>> bit in thobj->status, and I observed that __RT(kill(thobj->pid,
>>>>> SIGRESM)) got called, with a retval 0. thobj->pid has the right value.
>>>>>
>>>>> But the suspended task does not get resumed.
>>>>>
>>>>> Any idea/suggestion?
>>>>>
>>>> You may want to check what happens in __cobalt_kill()
>>>> (kernel/cobalt/posix/signal.c), and in COBALT_SYSCALL(kill, ...), to
>>>> make sure the call actually succeeds.
>>>
>>> I traversed the code until lib/cobalt/signal.c (__cobalt_kill()
>>> library-side) and I cheched retval of XENOMAI_SYSCALL2(sc_cobalt_kill,
>>> pid, sig) (that is 0).
>>>
>>> If I understand correctly, kernel/cobalt/posix/signal.c is kernel
>>> code. Should I add printks? Or should I have to attach gdb to kernel
>>> (I think I'm not able)
>>
>> printk() would be fine.
>>
>=20
> Hi Philippe an Jan,
>=20
> I have to check more deeply my application because there are some other=20
> strange behaviors that make me think that there could be memory leaks=20
> somewhere (and a standalone simple test code does not have the problem I =

> seen).
>=20
> I will be back if I will find something regarding Xenomai.
>=20
> Thanks again for your help.
>=20
> Regards
>=20

Hi all,

after a ton of tries, small test executables, headaches...I think I can=20
assert with almost certainty that the problem I observe is the same=20
reported in this old thread [1] and then that is better to move to=20
semaphores instead of using rt_task_suspend/rt_task_resume.

Thanks to all, regards

[1] https://xenomai.org/pipermail/xenomai/2016-January/035781.html

--=20
Mauro

