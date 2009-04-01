Message-ID: <49D393D0.3050102@domain.hid>
Date: Wed, 01 Apr 2009 18:18:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f73fef8d0903311153v625518bakc38f1667d73fa99c@domain.hid>	<1238575454.6932.56.camel@domain.hid>
	<f73fef8d0904010855r47751553wd0120d4082b89b5a@domain.hid>
In-Reply-To: <f73fef8d0904010855r47751553wd0120d4082b89b5a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Adam Bennett <abennett72@domain.hid>
Cc: xenomai@xenomai.org

Adam Bennett wrote:
> On Wed, Apr 1, 2009 at 4:44 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On Tue, 2009-03-31 at 14:53 -0400, Adam Bennett wrote:
>>> I'm running xenomai-head, linux-2.6.28.9, with uclibc-0.9.30.1.
>>>
>>> I have to run configure with --build=i586-gentoo-linux-uclibc
>>> --without-__thread.
>>>
>>> The problem I'm seeing is a segfault whenever calling rt_task_delete.
>>> This even occurs with the example program trivial-periodic.
>>>
>>> I have debug enabled in the kernel, but nothing interesting appears in syslog.
>>>
>>> Any thoughts?
>>>
>> gdb?
> 
> Here's the backtrace (this is my first time using gdb, I've been a fan
> of printf) after recompiling xenoami userland libs with debugging:
> 
> Thread 3 (process 1263):
> #0  0xb7f0c5a6 in rt_task_wait_period (overruns_r=0x0)
>     at ../../../../xenomai-head/src/skins/native/task.c:286
> 	muxcode = 134283819
> 	resultvar = 2739887275
> #1  0x08048638 in demo (arg=0x0) at trivial-periodic.c:26
> 	now = 1238598807752498347
> 	previous = 1238598807752498347
> #2  0xb7f0c056 in rt_task_trampoline (cookie=0x0)
>     at ../../../../xenomai-head/src/skins/native/task.c:111
> 	iargs = (struct rt_task_iargs *) 0xbfb2c840
> 	entry = (void (*)(void *)) 0x8048604 <demo>
> 	bulk = {a1 = 134520892, a2 = 134514592, a3 = 99, a4 = 0, a5 = 1026,
> a6 = 147481040}
> 	task = (RT_TASK *) 0x804a03c
> 	self = (RT_TASK *) 0x8ca6138
> 	err = 0
> #3  0xb7f14f78 in pthread_start_thread () from /lib/libpthread.so.0
> No symbol table info available.
> #4  0xb7ec9efe in clone () from /lib/libc.so.0
> No symbol table info available.
> 
> Thread 2 (process 1262):
> #0  0xb7ecc330 in poll () from /lib/libc.so.0
> No symbol table info available.
> #1  0xb7f1aff4 in ?? () from /lib/libpthread.so.0
> No symbol table info available.
> #2  0x000004ef in ?? ()
> No symbol table info available.
> #3  0xb7f152a4 in __pthread_manager () from /lib/libpthread.so.0
> No symbol table info available.
> #4  0x00000000 in ?? ()
> No symbol table info available.
> 
> Thread 1 (process 1261):
> #0  0xb7f0c455 in rt_task_delete (task=0x804a03c)
>     at ../../../../xenomai-head/src/skins/native/task.c:252
> 	err = -1078802316
> #1  0x08048737 in main () at trivial-periodic.c:71
> No locals.
> 
> The line that causes the segfault is 252:
> 
> 248	int rt_task_delete(RT_TASK *task)
> 249	{
> 250		int err;
> 251	
> 252		if (!task || task->opaque == rt_task_self()->opaque) {

try:

if (!task || rt_task_self() && task->opaque == rt_task_self()->opaque)


-- 
                                                 Gilles.

