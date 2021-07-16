Subject: Re: Xenomai 3: Wierd problem resuming task
References: <7321df79-b945-d152-4bb0-7792189bac2a@tin.it>
 <407fa882-73f2-4406-6098-0e9d57ac80b6@siemens.com>
From: "Mauro S." <mau.salvi@tin.it>
Message-ID: <34698f8a-137b-d77d-3c95-246d2291fa7b@tin.it>
Date: Fri, 16 Jul 2021 13:32:39 +0200
MIME-Version: 1.0
In-Reply-To: <407fa882-73f2-4406-6098-0e9d57ac80b6@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Il 16/07/21 11:47, Jan Kiszka ha scritto:
> On 16.07.21 11:45, Mauro S. via Xenomai wrote:
>> Hi,
>>
>> I'm using Xenomai3 (master branch, commit
>> bca41678742be80c3a0d5a01935c671c385a95a1) on a X86_64bit Intel Atom
>> x5-E8000 with 2GB RAM, using kernel from Xenomai repos, in Cobalt
>> coniguration. SMI workaround is enabled and all latency tests are good.
>>
>> I'm facing with a very weird problem in my application. I have some
>> tasks with priority < 90 that call rt_task_suspend() on themselves.
>> Then, I have a task with priority 99 that resumes all other tasks with
>> rt_task_resume(), when they are suspended.
>>
>> Sometimes a task does not get resumed.
>>
>> In /proc/xenomai/sched/stat I have this status for my suspendend task:
>>
>> CPU=A0 PID=A0=A0=A0 MSW=A0=A0=A0=A0=A0=A0=A0 CSW=A0=A0=A0=A0=A0=A0=A0 XS=
C=A0=A0=A0=A0=A0=A0=A0 PF=A0=A0=A0 STAT=A0=A0=A0=A0=A0=A0 %CPU=A0 NAME
>>  =A0 1=A0 620=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0=A0=A0 8=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 13=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0 00048041=A0=A0=A0 0.0=A0=
 t12
>>
>> Analizing the scenario attaching gdb to the application, I observe that
>> the not-resuming task has this backtrace:
>>
>> #0=A0 0x00007f0ec14c9b38 in __cobalt_kill (pid=3D620, sig=3D65) at signa=
l.c:100
>> 100=A0=A0=A0 signal.c: No such file or directory.
>> (gdb) bt
>> #0=A0 0x00007f0ec14c9b38 in __cobalt_kill (pid=3D620, sig=3D65) at signa=
l.c:100
>> #1=A0 0x00007f0ec14eb379 in threadobj_suspend
>> (thobj=3Dthobj@entry=3D0x7f0ec06bfcd0) at threadobj.c:335
>> #2=A0 0x00007f0ec15013dc in rt_task_suspend (task=3Dtask@entry=3D0x0) at
>> task.c:1154
>>
>> that seems to me OK. If I understood correctly, it is locked in its
>> SIGSUSP handler, that calls sigsuspend() waiting SIGRESM to "restart".
>>
>> Then, I placed some breakpoints where rt_task_resume() were called, and
>> in rt_task_resume() itself. I set tcb->suspends=3D1 with GDB and followed
>> the subsequent call of threadobj_resume(). Then, I placed some
>> breakpoints in threadobj_resume, I forced __THREAD_S_SUSPENDED bit in
>> thobj->status, and I observed that __RT(kill(thobj->pid, SIGRESM)) got
>> called, with a retval 0. thobj->pid has the right value.
>>
>> But the suspended task does not get resumed.
>>
>> Any idea/suggestion?
>>
>=20
> Can you derive a sharable simple test case from this? That will ensure
> we are not misinterpreting what you code actually does.
>=20
> Jan
>=20


I will try to reduce the application code to a simple test, but I'm not=20
sure to succeed.
I will get back to you anyway.

Thanks.

--
Mauro

