MIME-Version: 1.0
In-Reply-To: <49D3A64B.8080300@domain.hid>
References: <f73fef8d0903311153v625518bakc38f1667d73fa99c@domain.hid>
	<1238575454.6932.56.camel@domain.hid>
	<f73fef8d0904010855r47751553wd0120d4082b89b5a@domain.hid>
	<49D393D0.3050102@domain.hid> <1238603425.6932.59.camel@domain.hid>
	<49D3A64B.8080300@domain.hid>
Date: Wed, 1 Apr 2009 15:34:41 -0400
Message-ID: <f73fef8d0904011234s58b0eaa9nb7d937868ee1105f@domain.hid>
From: Adam Bennett <abennett72@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] rt_task_delete segfault in libnative.so.3.0.0
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
Cc: xenomai@xenomai.org

2009/4/1 Jan Kiszka <jan.kiszka@domain.hid>:
> Philippe Gerum wrote:
>> On Wed, 2009-04-01 at 18:18 +0200, Gilles Chanteperdrix wrote:
>>> Adam Bennett wrote:
>>>> On Wed, Apr 1, 2009 at 4:44 AM, Philippe Gerum <rpm@xenomai.org> wrote=
:
>>>>> On Tue, 2009-03-31 at 14:53 -0400, Adam Bennett wrote:
>>>>>> I'm running xenomai-head, linux-2.6.28.9, with uclibc-0.9.30.1.
>>>>>>
>>>>>> I have to run configure with --build=3Di586-gentoo-linux-uclibc
>>>>>> --without-__thread.
>>>>>>
>>>>>> The problem I'm seeing is a segfault whenever calling rt_task_delete=
.
>>>>>> This even occurs with the example program trivial-periodic.
>>>>>>
>>>>>> I have debug enabled in the kernel, but nothing interesting appears =
in syslog.
>>>>>>
>>>>>> Any thoughts?
>>>>>>
>>>>> gdb?
>>>> Here's the backtrace (this is my first time using gdb, I've been a fan
>>>> of printf) after recompiling xenoami userland libs with debugging:
>>>>
>>>> Thread 3 (process 1263):
>>>> #0 =A00xb7f0c5a6 in rt_task_wait_period (overruns_r=3D0x0)
>>>> =A0 =A0 at ../../../../xenomai-head/src/skins/native/task.c:286
>>>> =A0 =A0 muxcode =3D 134283819
>>>> =A0 =A0 resultvar =3D 2739887275
>>>> #1 =A00x08048638 in demo (arg=3D0x0) at trivial-periodic.c:26
>>>> =A0 =A0 now =3D 1238598807752498347
>>>> =A0 =A0 previous =3D 1238598807752498347
>>>> #2 =A00xb7f0c056 in rt_task_trampoline (cookie=3D0x0)
>>>> =A0 =A0 at ../../../../xenomai-head/src/skins/native/task.c:111
>>>> =A0 =A0 iargs =3D (struct rt_task_iargs *) 0xbfb2c840
>>>> =A0 =A0 entry =3D (void (*)(void *)) 0x8048604 <demo>
>>>> =A0 =A0 bulk =3D {a1 =3D 134520892, a2 =3D 134514592, a3 =3D 99, a4 =
=3D 0, a5 =3D 1026,
>>>> a6 =3D 147481040}
>>>> =A0 =A0 task =3D (RT_TASK *) 0x804a03c
>>>> =A0 =A0 self =3D (RT_TASK *) 0x8ca6138
>>>> =A0 =A0 err =3D 0
>>>> #3 =A00xb7f14f78 in pthread_start_thread () from /lib/libpthread.so.0
>>>> No symbol table info available.
>>>> #4 =A00xb7ec9efe in clone () from /lib/libc.so.0
>>>> No symbol table info available.
>>>>
>>>> Thread 2 (process 1262):
>>>> #0 =A00xb7ecc330 in poll () from /lib/libc.so.0
>>>> No symbol table info available.
>>>> #1 =A00xb7f1aff4 in ?? () from /lib/libpthread.so.0
>>>> No symbol table info available.
>>>> #2 =A00x000004ef in ?? ()
>>>> No symbol table info available.
>>>> #3 =A00xb7f152a4 in __pthread_manager () from /lib/libpthread.so.0
>>>> No symbol table info available.
>>>> #4 =A00x00000000 in ?? ()
>>>> No symbol table info available.
>>>>
>>>> Thread 1 (process 1261):
>>>> #0 =A00xb7f0c455 in rt_task_delete (task=3D0x804a03c)
>>>> =A0 =A0 at ../../../../xenomai-head/src/skins/native/task.c:252
>>>> =A0 =A0 err =3D -1078802316
>>>> #1 =A00x08048737 in main () at trivial-periodic.c:71
>>>> No locals.
>>>>
>>>> The line that causes the segfault is 252:
>>>>
>>>> 248 int rt_task_delete(RT_TASK *task)
>>>> 249 {
>>>> 250 =A0 =A0 =A0 =A0 int err;
>>>> 251
>>>> 252 =A0 =A0 =A0 =A0 if (!task || task->opaque =3D=3D rt_task_self()->o=
paque) {
>>> try:
>>>
>>> if (!task || rt_task_self() && task->opaque =3D=3D rt_task_self()->opaq=
ue)
>>>
>>>
>>
>> Indeed. The following patch is queued.
>>
>> diff --git a/src/skins/native/task.c b/src/skins/native/task.c
>> index 5cf37d9..905d366 100644
>> --- a/src/skins/native/task.c
>> +++ b/src/skins/native/task.c
>> @@ -249,10 +249,10 @@ int rt_task_delete(RT_TASK *task)
>> =A0{
>> =A0 =A0 =A0 int err;
>>
>> - =A0 =A0 if (!task || task->opaque =3D=3D rt_task_self()->opaque) {
>> + =A0 =A0 if (task =3D=3D NULL ||
>> + =A0 =A0 =A0 =A0 (rt_task_self() && task->opaque =3D=3D rt_task_self()-=
>opaque)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Silently migrate to avoid raising SIGXCPU=
. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_L=
INUX_DOMAIN);
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pthread_exit(NULL);
>> =A0 =A0 =A0 }
>>

Thanks, this fixed the segfaults!

Adam

>
> Mea culpa.
>
> I would just suggest to put rt_task_self() into a local variable to
> avoid double evaluation.
>
> Jan
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>

