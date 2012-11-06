Message-ID: <50991915.7050500@basystemes.fr>
Date: Tue, 06 Nov 2012 15:05:09 +0100
From: Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] pthread_set_name_np
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have some issues when I change the name of a task (created with the 
native skin) with the posix skin (pthread_set_name_np) on xenomai 2.6.1 
(kernel 2.6.38.8). This is a task created by a external library and we 
can not set the right name at the first place.
pthread_set_name_np seems to work only on tasks created with the posix skin.

Here is a test program (that worked with linux 2.6.38.8 + xenomai-2.6.0 
and crash with linux 2.6.38 + xenomai 2.6.1) :

#include <sys/mman.h>
#include <stdio.h>
#include <native/task.h>

RT_TASK task1;

void task1_main(void* arg)
{
     pthread_set_name_np(pthread_self(), "foo");
}

int main()
{
     int ret;

     mlockall(MCL_CURRENT | MCL_FUTURE);

     ret = rt_task_create(&task1, "task1", 0, 50, T_JOINABLE);
     if( ret )
     {
         printf("rt_task_create : %i\n", errno);
         return 0;
     }

     ret = rt_task_start(&task1, &task1_main, NULL);
     if( ret )
     {
             printf("rt_task_start : %i\n", errno);
             return 0;
     }

     return 0;
}


BUG: unable to handle kernel NULL pointer dereference at 0000039c
IP: [<c10bff87>] __pthread_set_name_np+0x65/0x96
*pde = 00000000
Oops: 0000 [#3] PREEMPT SMP
last sysfs file: /sys/devices/pci0000:00/0000:00:03.0/class
Modules linked in: xeno_16550A ipv6 pcspkr uhci_hcd

Pid: 5694, comm: task1 Tainted: G      D     2.6.38.8-os-0201patch04 #1 
Bochs Bochs
EIP: 0060:[<c10bff87>] EFLAGS: 00010286 CPU: 0
EIP is at __pthread_set_name_np+0x65/0x96
EAX: 00000000 EBX: cea33fb4 ECX: 99f915b3 EDX: df403180
ESI: 00000000 EDI: cea96130 EBP: e082d840 ESP: cea33ee8
  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process task1 (pid: 5694, ti=cea32000 task=cea96130 task.ti=cea32000)
I-pipe domain Linux
Stack:
  006f6f66 c102da2d 00000000 00000082 c174b180 00000000 c1071458 00000046
  b7733b90 dead3540 cea33fb4 00000000 cea96130 c1090bf8 00000000 00000000
  cea33fb4 00000050 c183d080 00000000 00000038 df40cf24 c183d080 c1090a3b
Call Trace:
  [<c102da2d>] ? try_to_wake_up+0x1e7/0x2bc
  [<c1071458>] ? __ipipe_restore_pipeline_head+0x11/0x100
  [<c1090bf8>] ? hisyscall_event+0x1bd/0x30e
  [<c1090a3b>] ? hisyscall_event+0x0/0x30e
  [<c107088f>] ? __ipipe_dispatch_event+0x10d/0x3d7
  [<c1017de5>] ? __ipipe_syscall_root+0x3f/0x183
  [<c150a6dd>] ? system_call+0x2d/0x53
Code: 00 85 c0 78 e4 c6 44 24 1f 00 8b 03 89 44 24 20 64 a1 cc 94 74 c1 
8b 80 c8 00 00 00 89 44 24 24 8d 44 24 20 e8 fc fb ff ff 89 c6 <8b> 98 
9c 03 00 00 8d 83 d8 01 00 00 b9 10 00 00 00 89 e2 e8 e2
EIP: [<c10bff87>] __pthread_set_name_np+0x65/0x96 SS:ESP 0068:cea33ee8
CR2: 000000000000039c
---[ end trace c8148c10eacbfd85 ]---

Jean-Baptiste

