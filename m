MIME-Version: 1.0
Date: Thu, 28 Jan 2016 11:37:14 +0200
Message-ID: <CABaOOZ3YZn8wUym7q1ix3HBT2Vtg_O2pjp7Kab4w=X1euVBPWw@mail.gmail.com>
From: Stratiyenko Roman <picoworm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Task resume problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi.

Can anybody help me with one not easy to debug problem.
Problem happens once per week or two weeks.

I have 2 user-level rt-task.
One task (rttask) is scheduled isochronous using rt_task_wait_period() and
have an max priority: 99
Second task (AFrttask) is started once, then it suspends from itself and
resumes from the first task.

Program works as expected, but sometimes (very very rarely) AFrttask not
resuming.
I connected to the running process using GDB and tracked it. rttask works
as expected, It calls resume function of the second task, but second task
is not resuming.

Here is the dump of /proc/xenomai/sched/stat
CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
  0  0      0          2537012    0          0     00018000   89.1  [ROOT/0]
  0  25095  14         18         75         0     000680c0    0.0  main
  0  25097  352        25832      25486      0     00048041    0.0  AFrttask
  0  25098  20         1012279    1043897    0     00048042    0.9  rttask
  0  0      0          43139223   0          0     00000000    7.8
 [IRQ16641: [timer]]

I can see that CSW of rttask is incrementing, but CSW of AFtrtask isn't

<stack trace of AFrttask>
[Switching to thread 8 (Thread 0x7f66123e0700 (LWP 25097))]
#0  0x00007f6611cdd394 in __wrap_kill () from
/usr/xenomai/lib/libcobalt.so.2
(gdb) bt
#0  0x00007f6611cdd394 in __wrap_kill () from
/usr/xenomai/lib/libcobalt.so.2
#1  0x00007f6611ef370c in threadobj_suspend ()
   from /usr/xenomai/lib/libcopperplate.so.0
#2  0x00007f661210167c in rt_task_suspend ()
   from /usr/xenomai/lib/libalchemy.so.0
#3  0x000000000043bb6c in AutomationFlow_c::suspend (this=0xd17420)
    at /Compile/t3/src/Common/AutomationFlow.cpp:30
#4  0x0000000000441f39 in PFlow_c::loop (this=0xd17420)
    at /Compile/t3/src/Common/PFlow.cpp:157
#5  0x000000000043b9f3 in APRun (AF=0xd17420)
    at /Compile/t3/src/Common/AutomationFlow.cpp:14
#6  0x00007f6612100d3a in task_entry () from
/usr/xenomai/lib/libalchemy.so.0
#7  0x00007f6611ef262b in thread_trampoline ()
   from /usr/xenomai/lib/libcopperplate.so.0
#8  0x00007f6611cdd76b in cobalt_thread_trampoline ()
   from /usr/xenomai/lib/libcobalt.so.2
#9  0x00007f6611ab6182 in start_thread (arg=0x7f66123e0700)
    at pthread_create.c:312
#10 0x00007f6610db547d in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111

I run my code on virtualbox x86-64, [Xenomai] Cobalt v3.0-rc7 (Exact Zero)
Host machine works on Windows 7, and I shutdown host PC using hibernization
several times when my xenomai program was running.

Why my task not resuming from suspend? I will not kill my process if any
idea where to look the state of thread using gdb, proc etc. Please help me
understand why this happends.

Thanks.
Roman Stratiienko
