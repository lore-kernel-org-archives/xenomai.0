Subject: Re: rt_pipe_read(): timeout does not expire
References: <25ffc50c-94ab-d09a-fd2c-e2d04f18a185@tin.it>
 <d10d2469-b6fe-87ea-7506-cf43f75d8023@siemens.com>
 <c76efd4f-af8a-c7a7-054f-bf47cc358f6c@siemens.com>
 <f4c9ce98-3ce9-84aa-eb02-eebf3f76d716@siemens.com>
 <fa58c202-fc36-669a-46ba-6325b08673c4@tin.it>
From: "Mauro S." <mau.salvi@tin.it>
Message-ID: <dfcde5a9-fd34-2f3f-ec29-0b57b59ab7bc@tin.it>
Date: Mon, 18 Oct 2021 09:06:41 +0200
MIME-Version: 1.0
In-Reply-To: <fa58c202-fc36-669a-46ba-6325b08673c4@tin.it>
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

Il 06/10/21 13:30, Mauro S. via Xenomai ha scritto:
> Il 06/10/21 12:26, Jan Kiszka ha scritto:
>> On 06.10.21 09:00, Jan Kiszka via Xenomai wrote:
>>> On 05.10.21 18:00, Jan Kiszka via Xenomai wrote:
>>>> On 25.09.21 18:20, Mauro S. via Xenomai wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm using Xenomai 3.1.1 in cobalt mode, on x84_64.
>>>>>
>>>>> Please consider the attached simple test code.
>>>>>
>>>>> When I start the application, I never see the "Pipe task running"=20
>>>>> printf.
>>>>>
>>>>> When I close application (ctrl+c), rt_pipe_join() on pipe task hangs.
>>>>>
>>>>> Analyzing the code with gdb, the timeout in tv structure inside
>>>>> rt_pipe_read_timed() is the following
>>>>>
>>>>> (gdb) thread 13
>>>>> [Switching to thread 13 (Thread 0x7ffff7189700 (LWP 528))]
>>>>> #0=A0 0x00007ffff7f89471 in do_recvmsg (fd=3Dfd@entry=3D3,
>>>>> msg=3Dmsg@entry=3D0x7ffff7188c40, flags=3Dflags@entry=3D0) at rtdm.c:=
250
>>>>> 250=A0=A0=A0 rtdm.c: No such file or directory.
>>>>> (gdb) bt
>>>>> #0=A0 0x00007ffff7f89471 in do_recvmsg (fd=3Dfd@entry=3D3,
>>>>> msg=3Dmsg@entry=3D0x7ffff7188c40, flags=3Dflags@entry=3D0) at rtdm.c:=
250
>>>>> #1=A0 0x00007ffff7f89e11 in __cobalt_recvfrom (fd=3D3,
>>>>> buf=3Dbuf@entry=3D0x7ffff7188d60, len=3Dlen@entry=3D4, flags=3D0,
>>>>> from=3Dfrom@entry=3D0x0,
>>>>> =A0=A0=A0=A0 fromlen=3Dfromlen@entry=3D0x0) at rtdm.c:343
>>>>> #2=A0 0x00007ffff7fc38ab in rt_pipe_read_timed (pipe=3D<optimized out=
>,
>>>>> buf=3D0x7ffff7188d60, size=3D4, abs_timeout=3D<optimized out>)
>>>>> =A0=A0=A0=A0 at pipe.c:423
>>>>> #3=A0 0x00005555555555c0 in rt_pipe_read (pipe=3D0x555555558150 <MyPi=
pe>,
>>>>> buf=3D0x7ffff7188d60, size=3D4, timeout=3D500000)
>>>>> =A0=A0=A0=A0 at
>>>>> /opt/smitec/3.1.5_SDK/sysroots/corei7-64-poky-linux/usr/include/xenom=
ai/alchemy/pipe.h:72=20
>>>>>
>>>>>
>>>>> #4=A0 0x00005555555556d4 in MyPipeFun (arg=3D0x0) at test_resume_pipe=
.c:55
>>>>> #5=A0 0x00007ffff7fc196a in task_entry (arg=3D0x7ffff732ddc8) at=20
>>>>> task.c:237
>>>>> #6=A0 task_entry (arg=3D0x7ffff732ddc8) at task.c:219
>>>>> #7=A0 0x00007ffff7faaca9 in thread_trampoline
>>>>> (arg=3Darg@entry=3D0x7fffffffe9c0) at internal.c:251
>>>>> #8=A0 0x00007ffff7f8b93e in cobalt_thread_trampoline=20
>>>>> (p=3D0x7fffffffe820) at
>>>>> thread.c:123
>>>>> #9=A0 0x00007ffff7f58ea4 in start_thread (arg=3D<optimized out>) at
>>>>> pthread_create.c:477
>>>>> #10 0x00007ffff7e7edcf in clone () at
>>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>>>> (gdb) frame 2
>>>>> #2=A0 0x00007ffff7fc38ab in rt_pipe_read_timed (pipe=3D<optimized out=
>,
>>>>> buf=3D0x7ffff7188d60, size=3D4, abs_timeout=3D<optimized out>)
>>>>> =A0=A0=A0=A0 at pipe.c:423
>>>>> 423=A0=A0=A0 pipe.c: No such file or directory.
>>>>> (gdb) print tv
>>>>> $1 =3D {tv_sec =3D 1438, tv_usec =3D 783700}
>>>>>
>>>>> It seems a value related to uptime (system was up by about 24 minutes,
>>>>> 1440 seconds, when debugging).
>>>>
>>>> Right, Xenomai's CLOCK_REALTIME starts at system boot, not at the=20
>>>> epoch.
>>>> That's at least true for I-pipe deployments.
>>>>
>>>>>
>>>>> The API documentation says that rt_pipe_read() accepts "a delay
>>>>> expressed in clock ticks". In Xenomai code, rt_pipe_read() becomes
>>>>> rt_pipe_read_timed(), that accepts "An absolute date expressed in=20
>>>>> clock
>>>>> ticks", with a note saying "abs_timeout is interpreted as a=20
>>>>> multiple of
>>>>> the Alchemy clock resolution" (I dont' understand this latter=20
>>>>> sentence).
>>>>>
>>>>
>>>> The Alchemy clock may not simply tick in single nanoseconds but may=20
>>>> have
>>>> a courser resolution. That's why there is rt_timer_ns2ticks which you
>>>> are already using.
>>>>
>>>>> If I'm not wrong, the "absolute date" would be a date expressed in
>>>>> seconds after the epoch. Could the alchemy_rel_timeout() call in
>>>>> include/alchemy/pipe.h calculate a wrong timeout?
>>>>> Otherwise, what could be the problem?
>>>>
>>>> Cannot say yet, but I can confirm seeing the issue (too long=20
>>>> timeout) as
>>>> well. Did you try to debug further already?
>>>>
>>>
>>> Looks like rt_pipe_read_timed is wrong: SO_RCVTIMEO takes a relative
>>> timeout to my reading of the man page and the code, but
>>> rt_pipe_read_timed passed down an absolute value. This confuses me
>>> because the function was like this for ages, so I might misread
>>> something ATM. Philippe?
>>>
>>
>> It is definitely broken in alchemy, I've created
>> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/30 to track the
>> to-dos. Any helping hand welcome.
>>
>> Jan
>>
>=20
>=20
> Hi Jan,
>=20
> sorry for the delay.
>=20
> Thank you for your explanations and your analysis.
>=20
> Mauro
>=20

Hi Jan,

I confirm that your patchset has fixed the rt_pipe part.

Thanks, regards

--=20
Mauro S.

