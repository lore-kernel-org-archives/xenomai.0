From: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Date: Fri, 12 Sep 2014 20:52:13 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C891DAD962F@USMLVA0EM24MSX.ww017.siemens.net>
References: <B89CCBE86D4F62448EE4F6367C6D3C891DACCB0F@USMLVA0EM24MSX.ww017.siemens.net>
 <53E14B37.2040202@xenomai.org>
 <1410537098.19920.YahooMailNeo@web142606.mail.bf1.yahoo.com>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD9615@USMLVA0EM24MSX.ww017.siemens.net>
In-Reply-To: <B89CCBE86D4F62448EE4F6367C6D3C891DAD9615@USMLVA0EM24MSX.ww017.siemens.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Question regarding rt_sem_p
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>, "gilles.chanteperdrix@xenomai.org" <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Small correction:

The ipipe patch that we are using is derived from ipipe-3.12.0 branch.

Rgds,
Makarand.

-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of PRADHAN, MA=
KARAND (RC-CA)
Sent: Friday, September 12, 2014 4:36 PM
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Question regarding rt_sem_p

Hi,

[Gilles] Do you have the same problem with the for-ipipe-3.14.0 branch from=
 ipipe-gch git, running with xenomai 2.6 git head?

Unfortunately I cannot upgrade the ipipe patch in the near foreseeable futu=
re. Our system has to continue running on Linux 3.12 and xenomai 2.6.3 and =
the ipipe patch which I believe is ipipe-core-3.8.13-arm-3.patch.

Another issue noted is with rt_task_sleep. It is also returning -38. A simp=
le test program to reproduce the problem is given at the end of the email a=
long with a log of my session.
Tracing the kernel shows that the system call (__rt_task_sleep) is returnin=
g -4(EINTR. XNBREAK) immediately without suspending. All the same, the user=
 space mysteriously sees a return code of -38.
The problem goes away once all the tasks have spawned and are running. This=
 tends to indicate that it's some race condition.
I've tried powerpc and the powerpc seems to run without any issues for the =
same configuration.

Outside gdb this test program runs ok. All the same, we have noticed the -3=
8 return code in other applications running xenomai even without gdb. I hav=
e not been able to write a test code that reproduces the issue without gdb.

Any pointers is resolving the issue would be highly appreciated.

Rgds,
Makarand.

My system:
CPU: DRA7xx (Arch: arm. Texas Inst, OMAP based SOC with Dual Core A-15s)
Linux: 3.12-1
Xenomai 2.6.3

Steps to reproduce the problem:
g++ sem1.c -I/usr/include/xenomai/ -lnative -lxenomai -g
root@ruggedcom:~# gdb a.out
GNU gdb (GDB) 7.4.1-debian
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-linux-gnueabihf".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /root/a.out...done.
(gdb) run 3
Starting program: /root/a.out 3
[Thread debugging using libthread_db enabled] Using host libthread_db libra=
ry "/lib/arm-linux-gnueabihf/libthread_db.so.1".
[New Thread 0xb6d73460 (LWP 27232)]
sem1 create. rc: 0
Spawning tasks
Spawning: task 0. Name: TASK_0
[New Thread 0xb6d6b460 (LWP 27233)]
[New Thread 0xb6d63460 (LWP 27234)]
[New Thread 0xb6d5b460 (LWP 27235)]
Spawning: task 1. Name: TASK_1
Task0: sleeping: 2000000000
task 0: rt_task_sleep: rc: -38
Task0: sleeping: 2000000000
Spawning: task 2. Name: TASK_2
Task1: sleeping: 2000000000
task 1: rt_task_sleep: rc: -38
Task1: sleeping: 2000000000
task 0: rt_task_sleep: rc: -38
Task0: sleeping: 2000000000
Task2: sleeping: 2000000000
Task1: sleeping: 2000000000
Task0: sleeping: 2000000000
Task2: sleeping: 2000000000
Task1: sleeping: 2000000000
Task0: sleeping: 2000000000
Task2: sleeping: 2000000000
^C
Program received signal SIGINT, Interrupt.
0xb6fd16bc in rt_task_sleep (delay=3D100000000000) at task.c:321
321             err =3D XENOMAI_SKINCALL1(__native_muxid, __native_task_sle=
ep, &delay);
(gdb) quit
A debugging session is active.

        Inferior 1 [process 27229] will be killed.

Quit anyway? (y or n) y
root@ruggedcom:~#

kern.log for an instrumented xeno_native.ko:
Sep 12 20:49:58 ruggedcom kernel: [92692.073071] __rt_task_sleep: delay fro=
m US: 2000000000 Sep 12 20:49:58 ruggedcom kernel: [92692.073082] rt_task_s=
leep: Thread: TASK_0: starting: Delay: 2000000000 Sep 12 20:49:58 ruggedcom=
 kernel: [92692.073211] rt_task_sleep: Thread: TASK_0: test info: 4. Return=
ing: -4 Sep 12 20:49:58 ruggedcom kernel: [92692.073218] __rt_task_sleep: r=
eturning: rc: -4 Sep 12 20:49:58 ruggedcom kernel: [92692.075162] __rt_task=
_sleep: delay from US: 2000000000 Sep 12 20:49:58 ruggedcom kernel: [92692.=
075171] rt_task_sleep: Thread: TASK_0: starting: Delay: 2000000000 Sep 12 2=
0:49:58 ruggedcom kernel: [92692.075749] __rt_task_sleep: delay from US: 20=
00000000 Sep 12 20:49:58 ruggedcom kernel: [92692.075757] rt_task_sleep: Th=
read: TASK_1: starting: Delay: 2000000000 Sep 12 20:49:58 ruggedcom kernel:=
 [92692.075886] rt_task_sleep: Thread: TASK_1: test info: 4. Returning: -4 =
Sep 12 20:49:58 ruggedcom kernel: [92692.075892] __rt_task_sleep: returning=
: rc: -4 Sep 12 20:49:58 ruggedcom kernel: [92692.075932] rt_task_sleep: Th=
read: TASK_0: test info: 4. Returning: -4 Sep 12 20:49:58 ruggedcom kernel:=
 [92692.075938] __rt_task_sleep: returning: rc: -4 Sep 12 20:49:59 ruggedco=
m kernel: [92692.077787] __rt_task_sleep: delay from US: 2000000000 Sep 12 =
20:49:59 ruggedcom kernel: [92692.077795] rt_task_sleep: Thread: TASK_1: st=
arting: Delay: 2000000000 Sep 12 20:49:59 ruggedcom kernel: [92692.077842] =
__rt_task_sleep: delay from US: 2000000000 Sep 12 20:49:59 ruggedcom kernel=
: [92692.077849] rt_task_sleep: Thread: TASK_0: starting: Delay: 2000000000=
 Sep 12 20:49:59 ruggedcom kernel: [92692.077960] __rt_task_sleep: delay fr=
om US: 100000000000 Sep 12 20:49:59 ruggedcom kernel: [92692.077967] rt_tas=
k_sleep: Thread: Task 0: starting: Delay: 100000000000 Sep 12 20:49:59 rugg=
edcom kernel: [92692.078085] __rt_task_sleep: delay from US: 2000000000 Sep=
 12 20:49:59 ruggedcom kernel: [92692.078091] rt_task_sleep: Thread: TASK_2=
: starting: Delay: 2000000000 Sep 12 20:50:01 ruggedcom kernel: [92694.0684=
70] rt_task_sleep: Thread: TASK_1: test info: 0. Returning: 0 Sep 12 20:50:=
01 ruggedcom kernel: [92694.068479] __rt_task_sleep: returning: rc: 0 Sep 1=
2 20:50:01 ruggedcom kernel: [92694.068485] __rt_task_sleep: delay from US:=
 2000000000 Sep 12 20:50:01 ruggedcom kernel: [92694.068511] rt_task_sleep:=
 Thread: TASK_1: starting: Delay: 2000000000 Sep 12 20:50:01 ruggedcom kern=
el: [92694.068518] rt_task_sleep: Thread: TASK_0: test info: 0. Returning: =
0 Sep 12 20:50:01 ruggedcom kernel: [92694.068524] __rt_task_sleep: returni=
ng: rc: 0 Sep 12 20:50:01 ruggedcom kernel: [92694.068529] __rt_task_sleep:=
 delay from US: 2000000000 Sep 12 20:50:01 ruggedcom kernel: [92694.068535]=
 rt_task_sleep: Thread: TASK_0: starting: Delay: 2000000000 Sep 12 20:50:01=
 ruggedcom kernel: [92694.068753] rt_task_sleep: Thread: TASK_2: test info:=
 0. Returning: 0

root@ruggedcom:~# cat sem1.c
// ./a.out <no. of threads>

#include <sys/syscall.h>
#include <sys/mman.h>
#include <stdio.h>
#include <native/task.h>
#include <native/mutex.h>
#include <native/sem.h>
#include <native/timer.h>
#include <nucleus/thread.h>
#include <rtdk.h>
#include <stdlib.h>
#include <unistd.h>

#define NANO_SEC_IN_SEC 1000000000LL

RT_TASK rt_task_array[128], task0;
char buff[8192];
RT_SEM sem1;
int tasks_are_being_spawned =3D 0;

void task_func(void *arg)
{
        int task_no =3D *(int *)arg;
        int sleep_for =3D 2;
        int rc =3D 0;

        while (1)
        {
                rt_printf("Task%i: sleeping: %llu\n", task_no, sleep_for*NA=
NO_SEC_IN_SEC);
                rc =3D rt_task_sleep(sleep_for*NANO_SEC_IN_SEC);
                if (0 !=3D rc)
                {
                        rt_printf("task %i: rt_task_sleep: rc: %i\n", task_=
no, rc);
                }
        }
}

#define MAX_TASKS 4096

int main(int argc, char **argv)
{
        int tasks =3D 0;
        char task_name[MAX_TASKS];
        int task_no[MAX_TASKS];
        int i =3D 0;
        int task_counter =3D 0;
        int rc =3D 0;

        // Get no. of threads to spawn.
        tasks =3D atoi(argv[1]);

        // Init
        mlockall(MCL_CURRENT|MCL_FUTURE);
        rt_print_auto_init(1);

        rt_task_shadow(&task0, "Task 0", 10, 0);

        rc =3D rt_sem_create(&sem1, "sem1", 1, S_PRIO);
        rt_printf("sem1 create. rc: %i\n", rc);

        rt_printf("Spawning tasks\n", rc);

        for (i =3D 0; i < tasks; i++)
        {
                sprintf(task_name, "TASK_%i", task_counter);
                task_no[i] =3D task_counter;
                rt_printf("Spawning: task %i. Name: %s\n", task_counter, ta=
sk_name);
                rt_task_spawn(&rt_task_array[task_counter], task_name, 0, 2=
, 0, task_func, &task_no[task_counter]);
                task_counter++;
        }

        while (1) {
                rt_task_sleep(100000000000LL);
        }
}


----- Forwarded Message -----
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
To: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>; "xenomai@xe=
nomai.org" <xenomai@xenomai.org>
Sent: Tuesday, August 5, 2014 5:23 PM
Subject: Re: [Xenomai] Question regarding rt_sem_p

On 08/05/2014 10:33 PM, PRADHAN, MAKARAND (RC-CA) wrote:
> Hi All,
>
> I am facing a unique problem related to Semaphores and would appreciate a=
ny suggestions that you may have.
>
> My system:
> CPU: DRA7xx (Arch: arm. Texas Inst, OMAP based SOC with Dual Core
> A-15s)
> Linux: 3.12-1

Do you have the same problem with the for-ipipe-3.14.0 branch from ipipe-gc=
h git, running with xenomai 2.6 git head?

--
                                                                Gilles.



_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai


This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

