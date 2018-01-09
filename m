From: Henry Bausley <hbausley@deltatau.com>
Date: Tue, 9 Jan 2018 22:35:11 +0000
Message-ID: <BN3PR1101MB10425C38098D5CD44E2EDDB2B0100@BN3PR1101MB1042.namprd11.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Stack Overflow when changing Affinity
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

We have an application that gets run repeatedly that causes a stack overflo=
w.  The source is at the end of this mail.
We have tracked it down to changing the affinity.

We have used xenomai 2.6.5 and 2.6.4 and kernels 3.14.28 and 4.1.18 and see=
n identical results.  Our platform is an LS1021A NXP/Freescale ARM processo=
r.  Is this a bug or are we incorrectly using affinity


ubuntu login: root
Password:
Last login: Thu Jan  1 00:01:45 UTC 1970 on ttyS0
Linux ubuntu 3.14.28-ipipe #37 SMP Mon Apr 18 14:06:56 PDT 2016 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@10.150.168.227:/opt/ppmac#<mailto:root@10.150.168.227:/opt/ppmac#> cd =
testgpascii/
root@10.150.168.227:/opt/ppmac/testgpascii#<mailto:root@10.150.168.227:/opt=
/ppmac/testgpascii#> ./testgpascii
testlib counter: 1
testlib counter: 2
testlib counter: 3
.
.
.
testlib counter: 502
testlib counter: 503
testlib counter: 504
Unable to handle kernel NULL pointer dereference at virtual address 000002e=
0
pgd =3D bd3cdc00, hw pgd =3D bd3cdc00
[000002e0] *pgd=3Da6b3e003, *pmd=3Da8176003, *pte=3D00000000
Internal error: Oops: 207 [#1] SMP ARM
Modules linked in: rtpmac(O) atemsys(O) libppmac(O) libmath(O) ppmachw(O) r=
8169s
CPU: 0 PID: 4339 Comm: testlib Tainted: G           O 3.14.28-ipipe #37
task: bd1b8400 ti: a6b50000 task.ti: a6b50000
PC is at __lock_task_sighand+0x20/0x84
LR is at __lock_task_sighand+0x18/0x84
pc : [<8002c1d8>]    lr : [<8002c1d0>]    psr: 80000013
sp : a6b51d10  ip : 00000001  fp : a6b51d2c
r10: 00000000  r9 : 00000002  r8 : 0000001c
r7 : 00000000  r6 : a6b51d34  r5 : a6b51d68  r4 : 00000000
r3 : 806e6860  r2 : 3f8f0000  r1 : 80000013  r0 : 00000080
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c53c7d  Table: bd3cdc00  DAC: fffffffd
Process testlib (pid: 4339, stack limit =3D 0xa6b50240)
Stack: (0xa6b51d10 to 0xa6b52000)
1d00:                                     00000000 a6b51d68 0000001c 000000=
00
1d20: a6b51d54 a6b51d30 8002c368 8002c1c4 a6b51d5c 00000080 8077aabc 807783=
48
1d40: ffffffff 0000000c a6b51d64 a6b51d58 8002c5f4 8002c348 a6b51e14 a6b51d=
68
1d60: 80093144 8002c5e4 0000001c 00000000 ffffffff 00000000 00000000 000000=
02
1d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
1da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
1dc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
1de0: 00000000 00000000 00000006 807669c0 80766a00 00000000 8076732c 807669=
c0
1e00: 807460c0 00000024 a6b51e3c a6b51e18 8007a188 80093048 8007a0a8 807460=
c0
1e20: 80746080 806fb47c 0000040f 807564c0 a6b51e74 a6b51e40 8007798c 8007a0=
b4
1e40: a6b51e6c 806e8ba0 80077b4c 806e6860 807215c0 806f474c 807460c0 807460=
80
1e60: 00000000 00000000 a6b51e9c a6b51e78 80077a84 8007779c 00001198 806e68=
60
1e80: bffd7a00 00000088 00000000 898521ae a6b51eb4 a6b51ea0 80077e9c 80077a=
24
1ea0: 806fb790 00000000 a6b51f04 a6b51eb8 800c66c4 80077de0 a6b51ee4 000000=
00
1ec0: 00000000 00000000 898521ae 00000000 0000000a 00000000 806fb790 a6b51f=
b0
1ee0: a6b50000 7ecbfd28 00000000 8077a894 807460c0 00000000 a6b51f34 a6b51f=
08
1f00: 800f5fe0 800c6178 76dd8000 be41d340 00000000 00000000 00000021 000000=
00
1f20: a6b51fb0 00000010 a6b51f5c a6b51f38 800952a0 800f5f50 bffd6860 807215=
c0
1f40: 806f474c 806e6860 807460c0 0000119c a6b51f6c a6b51f60 800795a0 800951=
ec
1f60: a6b51fac a6b51f70 80078390 80079550 40000000 807460c0 806e8ba0 a6b51f=
b0
1f80: 800418a4 7ecbfd28 7ecbfd2c 76f0f000 000f0042 8000e6e8 a6b50000 000000=
00
1fa0: 00000000 a6b51fb0 8000e640 800782c8 0202022b 76dd8000 00000000 7ecbfd=
58
1fc0: 7ecbfd28 7ecbfd2c 76f0f000 000f0042 76dd8000 00000000 7ecbfd58 000000=
00
1fe0: 76efe0c8 7ecbfd28 76ef3387 76f02fe4 20000030 0202022b 00000000 000000=
00
Backtrace:
[<8002c1b8>] (__lock_task_sighand) from [<8002c368>] (do_send_sig_info+0x2c=
/0x7)
 r7:00000000 r6:0000001c r5:a6b51d68 r4:00000000
[<8002c33c>] (do_send_sig_info) from [<8002c5f4>] (send_sig_info+0x1c/0x28)
 r7:0000000c r6:ffffffff r5:80778348 r4:8077aabc
[<8002c5d8>] (send_sig_info) from [<80093144>] (lostage_handler+0x108/0x154=
)
[<8009303c>] (lostage_handler) from [<8007a188>] (rthal_apc_handler+0xe0/0x=
160)
 r10:00000024 r9:807460c0 r8:807669c0 r7:8076732c r6:00000000 r5:80766a00
 r4:807669c0
[<8007a0a8>] (rthal_apc_handler) from [<8007798c>] (__ipipe_do_sync_stage+0=
x1fc)
 r8:807564c0 r7:0000040f r6:806fb47c r5:80746080 r4:807460c0 r3:8007a0a8
[<80077790>] (__ipipe_do_sync_stage) from [<80077a84>] (__ipipe_do_sync_pip=
elin)
 r10:00000000 r9:00000000 r8:80746080 r7:807460c0 r6:806f474c r5:807215c0
 r4:806e6860
[<80077a18>] (__ipipe_do_sync_pipeline) from [<80077e9c>] (__ipipe_restore_=
head)
 r8:898521ae r7:00000000 r6:00000088 r5:bffd7a00 r4:806e6860 r3:00001198
[<80077dd4>] (__ipipe_restore_head) from [<800c66c4>] (pthread_setschedpara=
m+0x)
 r5:00000000 r4:806fb790
[<800c616c>] (pthread_setschedparam) from [<800f5fe0>] (__pthread_setschedp=
aram)
 r10:00000000 r9:807460c0 r8:8077a894 r7:00000000 r6:7ecbfd28 r5:a6b50000
 r4:a6b51fb0
[<800f5f44>] (__pthread_setschedparam) from [<800952a0>] (losyscall_event+0=
xc0/)
 r7:00000010 r6:a6b51fb0 r5:00000000 r4:00000021
[<800951e0>] (losyscall_event) from [<800795a0>] (ipipe_syscall_hook+0x5c/0=
x70)
 r10:0000119c r8:807460c0 r7:806e6860 r6:806f474c r5:807215c0 r4:bffd6860
[<80079544>] (ipipe_syscall_hook) from [<80078390>] (__ipipe_notify_syscall=
+0xd)
[<800782bc>] (__ipipe_notify_syscall) from [<8000e640>] (pipeline_syscall+0=
x8/0)
 r10:00000000 r9:a6b50000 r8:8000e6e8 r7:000f0042 r6:76f0f000 r5:7ecbfd2c
 r4:7ecbfd28
Code: e1a06001 ebffa2f0 e1a00380 e5860000 (e59452e0)
---[ end trace 4957e0eecbed6249 ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D    O 3.14.28-ipipe #37
Backtrace:
[<800118c4>] (dump_backtrace) from [<80011c54>] (show_stack+0x18/0x1c)
 r6:00000001 r5:00000001 r4:00000000 r3:00200040
[<80011c3c>] (show_stack) from [<8051ae7c>] (dump_stack+0x70/0x8c)
[<8051ae0c>] (dump_stack) from [<80014260>] (handle_IPI+0xe0/0x178)
 r4:00000000 r3:806fa574
[<80014180>] (handle_IPI) from [<8001432c>] (__ipipe_do_IPI+0x34/0x44)
 r6:806fb47c r5:80746080 r4:807460c0 r3:806e8ba4
[<800142f8>] (__ipipe_do_IPI) from [<8007798c>] (__ipipe_do_sync_stage+0x1f=
c/0x)
[<80077790>] (__ipipe_do_sync_stage) from [<80077a84>] (__ipipe_do_sync_pip=
elin)
 r10:00000000 r9:410fc075 r8:80746080 r7:807460c0 r6:806f474c r5:807215c0
 r4:806e6860
[<80077a18>] (__ipipe_do_sync_pipeline) from [<80078228>] (__ipipe_dispatch=
_irq)
 r8:80003010 r7:be09df7c r6:00000000 r5:00000001 r4:bffe0860 r3:806e6860
[<8007806c>] (__ipipe_dispatch_irq) from [<8000843c>] (__ipipe_grab_ipi+0x7=
0/0x)
 r6:806f48d0 r5:be09df48 r4:be09df48 r3:0000040c
[<800083cc>] (__ipipe_grab_ipi) from [<80008778>] (gic_handle_irq+0x58/0x60=
)
Exception stack(0xbe09df28 to 0xbe09df70)
df20:                   8000f2a0 80077da0 60000013 ffffffff be09df9c be09df=
48
df40: 80012400 8000872c 00000000 bffe0860 3f8fa000 00000000 be09c000 807211=
d5
df60: 80524cc4 806f44a0 80003010 410fc075
 r4:c0802000 r3:00000005
[<80008720>] (gic_handle_irq) from [<80012400>] (__irq_svc+0x40/0x4c)
Exception stack(0xbe09df48 to 0xbe09df90)
df40:                   00000000 bffe0860 3f8fa000 00000000 be09c000 807211=
d5
df60: 80524cc4 806f44a0 80003010 410fc075 00000000 be09df9c be09dfa0 be09df=
90
df80: 8000f2a0 80077da0 60000013 ffffffff
 r6:ffffffff r5:60000013 r4:80077da0 r3:8000f2a0
[<80077d50>] (ipipe_unstall_root) from [<8000f2a0>] (arch_cpu_idle+0x88/0x9=
c)
[<8000f218>] (arch_cpu_idle) from [<80057d08>] (cpu_idle_loop+0xb0/0x114)
[<80057c58>] (cpu_idle_loop) from [<80057d80>] (desc_set_defaults+0x0/0xf0)
 r7:8072184c r6:30c23c7d r5:0120c302 r4:00000001
[<80057d6c>] (cpu_startup_entry) from [<80013e40>] (secondary_start_kernel+=
0x12)
[<80013d20>] (secondary_start_kernel) from [<80008804>] (__enable_mmu+0x0/0=
x1c)
 r4:be023440 r3:800087ec


#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <pthread.h>
pthread_attr_t myprocess_attr;


int main(int argc, char *argv[])
{
  int rtnstatus =3D 0, repeat =3D 0;
  char buf[256];
  int is, core_id, num_cores;

  core_id =3D 1;
  num_cores =3D 2;  if ((core_id < 0) || (core_id >=3D num_cores))
    printf("Invalid CPU number: %d\n", core_id);
  else
  {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(core_id, &cpuset);
    pthread_attr_init(&myprocess_attr);
    const pthread_t current_thread =3D pthread_self();
    is =3D pthread_setaffinity_np(current_thread, sizeof(cpuset), &cpuset);
    if (is !=3D 0)
      printf("pthread_setaffinity_np() in testlib returned with error code =
%d\n", is);
    // Now check affinity
    is =3D pthread_getaffinity_np(current_thread, sizeof(cpuset), &cpuset);
    if (is =3D=3D 0)
    {
      if (!CPU_ISSET(core_id, &cpuset))
        printf("Unable to set cpu affinity of cpu %d in testlib\n", core_id=
);
    }
    else
      printf("pthread_attr_getaffinity_np() in testlib returned with error =
code %d\n", is);
    pthread_attr_destroy(&myprocess_attr);
  }
  return EXIT_SUCCESS;
}

#include <stdio.h>
#include <stdlib.h>


int main(void)
{
  int rtnstatus =3D 0, repeat =3D 0;
  //---------------------------------------------------------------
  // Launch testlib
  //---------------------------------------------------------------
  while (1)
  {
    rtnstatus =3D system("/opt/ppmac/testlib/testlib");
    if (rtnstatus =3D=3D -1)
    {
      printf("Error: testlib\n\6\n");
      return 1;
    }

    usleep(5000);
    repeat++;
    printf("testlib counter: %d\n",repeat);
    if(repeat >=3D 10000)
    {
      printf("testlib test successful for %d counts, stopping test cycle\n"=
,repeat);
      break;
    }
  }
  return EXIT_SUCCESS;
}



