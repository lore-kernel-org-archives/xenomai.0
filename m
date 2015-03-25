Message-ID: <55127004.3010708@mitrol.it>
Date: Wed, 25 Mar 2015 09:21:24 +0100
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] fault in ppd_lookup_inner
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,
I'm stressing an arm IMX6 boardwith
- kernel 3.0.35
- I-pipe 1.18-13
- xenomai 2.6.3

With some hours of stress-test I can see the fault at the bottomof the 
email.
I always see this fault, not only on one board (so I think it is not an 
hardware problem).
The PC is always at ppd_lookup_inner+0xec/0x160.

I have checked xenomai 2.6.4 and tried to add the fixes but there are 
not changes to that part of code.

STRESS-TEST (called test-lib)
=======================================================================================
#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <dlfcn.h>

#define N 20

int main(int argc, char *argv[])
{
         int i,pid, status, cnt = 0;

         while(1)
         {
                 for (i=0; i<N; i++)
                 {
                         pid = fork();
                         if (!pid)
                         {
                                 char name[32];
                                 mlockall(MCL_CURRENT | MCL_FUTURE);

                                 sprintf(name, "test-lib-%d", i);
                                 rt_task_shadow(NULL, name, 0, 0);

                                 return 
(dlopen("/lib/libvncserver.so.0.0.0", 1) == 0);
                         }
                 }
                 for (i=0; i<N; i++)
                 {
                         wait(&status);
                 }
                 cnt+=N;
                 printf("cnt=%d\n", cnt);
                 fflush(stdout);
         }
}

FAULT
=======================================================================================
Unable to handle kernel paging request at virtual address 4032022c
pgd = 80004000
[4032022c] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
Modules linked in: mchpar1xxx imx6xendriverCAN_1 imx6xendriverCAN_0
CPU: 0    Not tainted  (3.0.35-2666-gbdde708 #564)
PC is at ppd_lookup_inner+0xec/0x160
LR is at ppd_lookup+0x20/0x30
pc : [<800ca744>]    lr : [<800ca7d8>]    psr: 80000013
sp : 84d8be50  ip : 8b97add8  fp : 00000001
r10: 9fde0300  r9 : 80923998  r8 : 00000b30
r7 : 9ff6e000  r6 : 8b97adb8  r5 : 9fde0300  r4 : 9ff6e024
r3 : 4032022c  r2 : 84d8be68  r1 : 84d8be60  r0 : 4032022c
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment user
Control: 10c53c7d  Table: 2fa40059  DAC: 00000015
Process test-lib-17 (pid: 7787, stack limit = 0x84d8a2e8)
Stack: (0x84d8be50 to 0x84d8c000)
be40:                                     809239d0 809518a0 809518a0 
80923928
be60: 80141ea0 9ff6e024 00000000 9fde0300 80141ea0 800cbb80 80141ea0 
8014eeac
be80: 80946d50 85cd3790 00000000 85cd3790 84ba8d80 9fde0300 84d8bee0 
80141ea0
bea0: 00000059 00000071 00000000 809239d0 809518a0 809518a0 80923928 
00000b30
bec0: 80923998 80923998 00000001 800ac454 20000013 00000000 00008000 
00000000
bee0: 0000000f 00000044 809518a0 9fde0300 ffff7fff ffffffff 00000000 
84ba8d80
bf00: 9fde0300 9fde0300 9fde0334 800442e8 84d8a000 84d8a000 00000000 
8006eb9c
bf20: 84ba8d80 9fde0300 84d8a000 80072db8 84d8a000 84ba8d80 000000f8 
00000000
bf40: 84d8a000 84ba8d80 000000f8 800744d4 00000200 00000001 00000009 
0000002c
bf60: 809518a0 84d8bfb0 fffffdff 00000000 84d8a000 2acde760 000000f8 
800442e8
bf80: 84d8a000 00000000 00000000 80074de8 00000000 000700de 2acde760 
80074ea8
bfa0: 00000000 80044100 000700de 2acde760 00000000 000700ca 2abed4c0 
00000000
bfc0: 000700de 2acde760 2acde760 000000f8 00000000 00000000 2ab33000 
00000000
bfe0: 000000f8 7ee16c6c 2ac6ffc3 2ac19276 60000030 00000000 00000000 
00000000
[<800ca744>] (ppd_lookup_inner+0xec/0x160) from [<80141ea0>] 
(remove_vma+0x54/0x6c)
Code: e592c000 e153000c 9a00000d e1a03000 (e5930000)
---[ end trace c1c53546cece2a33 ]---
Fixing recursive fault but reboot is needed!
=======================================================================================

The system continue to work, is not freezed.
Have you got an idea ?
Thanks for your time

Paolo


