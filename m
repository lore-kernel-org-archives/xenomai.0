References: <tencent_7EFF3BC22CBB53AA568408E6@qq.com>
 <0fe39a24-b767-dff2-230d-18fa0b3766dd@xenomai.org>
 <tencent_5E5F68F22D0540CF4309F8EE@qq.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2ded9de8-95c1-52ea-8e56-55398d454fbd@xenomai.org>
Date: Tue, 13 Sep 2016 09:47:25 +0200
MIME-Version: 1.0
In-Reply-To: <tencent_5E5F68F22D0540CF4309F8EE@qq.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "Ctrl + C" makes system crashed when exitting
	from"cross-link"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

On 09/12/2016 05:30 AM, Jack Lee wrote:
>> ------------------ Original ------------------
>> From:  "Philippe Gerum";<rpm@xenomai.org>;
>> Date:  Sep 11, 2016
>> To:  "Jack Lee"<jacklee11@foxmail.com>; "xenomai"<xenomai@xenomai.org>;
>> Subject:  Re: [Xenomai] "Ctrl + C" makes system crashed when exitting from"cross-link"
>>
>> On 09/11/2016 01:12 PM, Jack Lee wrote:
>>> Hello, everyone!
>>>   My computer is Advantech MIO-5251, (the J1900 version, 
>>> http://www.advantech.com/products/bc6786b7-b69b-4fdd-9b63-79180dbd5dcb/mio-5251/mod_ff8534cc-e858-40ba-9bc2-386f19bfee4a)
>>>  linux kernel version is 4.1.18, xenomai version is 3.0.2, system is lubuntu 16.04.
>>> I remove the original UART drivers and modprobe the xeno_16550A driver. cross-link demo
>>> works fine, but when I type in "Ctrl + C" to exit from it, the terminal outputs these and the system
>>> just dies.
>>> ...
>>> main: /dev/rtdm/rtser1 (read) -> closed
>>> main: /dev/rtdm/rtser0 (write) -> closed
>>> main: delete write_task
>>> write_task: error on rt_task_wait_period, Interrupted system call
>>> write_task: exit
>>> main: delete read_task
>>> ---
>>>
>>> Sometimes, it outputs these:
>>> ...
>>> main: exit
>>> ---
>>> The system does not die, but the cross-link does not exit actually.
>>> I run "cat /proc/xenomai/sched/thread" to get the pid and kill it,
>>> the terminal just outputs "main: exit" repeatedly.
>>>
>>> What's wrong, and  how can I solve it? Thanks!
>>>
>>
>> The reader task may be hanging around although it should have received a
>> deletion signal, causing the main thread to wait for all its children
>> indefinitely. This said, issuing rt_task_delete() and friends over a
>> signal handler is not legit, so the demo code has a problem anyway.
>>
>> You could run the cross-link application over gdb, then check the stack
>> backtrace of the reader task at exit (or any task that appears to be
>> stuck), to find out where that task is stuck (^C, then switch to the
>> reader task context using gdb's "thread" command, then "bt").
>>
>> -- 
>> Philippe.
> 
> Hi, Philippe,
> 
> I run the "gdb cross-link" "Ctrl + C" and other instructions you showed, 
> results are beblow:
> 
> ^C
> Thread 1 "cross-link" received signal SIGINT, Interrupt.
> 0x00007ffff7586d1d in pause () at ../sysdeps/unix/syscall-template.S:84
> 84	../sysdeps/unix/syscall-template.S: No such file or directory.
> 
> (gdb) thread find read
> Thread 1 has target id 'Thread 0x7ffff7fde740 (LWP 3382)'
> Thread 2 has target id 'Thread 0x7ffff6fa4700 (LWP 3383)'
> Thread 3 has target id 'Thread 0x7ffff7ec9700 (LWP 3384)'
> Thread 4 has target name 'read_task'
> Thread 4 has target id 'Thread 0x7ffff7eb8700 (LWP 3385)'
> 
> (gdb) thread 4
> [Switching to thread 4 (Thread 0x7ffff7eb8700 (LWP 3385))]
> #0  0x00007ffff77a390f in do_ioctl () from /usr/xenomai/lib/libcobalt.so.2
> 
> (gdb) bt
> #0  0x00007ffff77a390f in do_ioctl () from /usr/xenomai/lib/libcobalt.so.2
> #1  0x00007ffff77a3d84 in __wrap_ioctl () from /usr/xenomai/lib/libcobalt.so.2
> #2  0x0000000000401459 in read_task_proc (arg=0x0) at cross-link.c:200
> #3  0x00007ffff7bd0b1a in task_entry () from /usr/xenomai/lib/libalchemy.so.0
> #4  0x00007ffff79bd0ab in thread_trampoline ()
>    from /usr/xenomai/lib/libcopperplate.so.0
> #5  0x00007ffff77a5acc in cobalt_thread_trampoline ()
>    from /usr/xenomai/lib/libcobalt.so.2
> #6  0x00007ffff757d6fa in start_thread (arg=0x7ffff7eb8700)
>     at pthread_create.c:333
> #7  0x00007ffff72b3b5d in clone ()
>     at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
> 
> Is there something wrong?
> 

Can't tell yet. What does "info threads" say?

Also, is the issue translates to a hard lockup without any message or
did you notice any warning or kernel oops on the console channel due to
a crash/BUG assertion?

If this is a silent, hard lockup, then you may want to enable
XENO_OPT_WATCHDOG in the Xenomai debug options of the kernel
configuration. This would catch any runaway Xenomai thread which may
freeze the box before it's too late (4 secs by default), giving us a
hint about the issue we are chasing.

-- 
Philippe.

