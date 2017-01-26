MIME-Version: 1.0
From: Jackson Jones <jackson.jones@gmail.com>
Date: Wed, 25 Jan 2017 18:43:04 -0800
Message-ID: <CADXNiGV-eAFW3-+qcT9OOFRvgW1uzow8a5geWrXeD0ieUNVFVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] xenomai 3.0.3 on imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have successfully got xenomai 3.0.3 running on the Freescale/NXP
4.1.15-2.0.0 kernel. Using Mesa graphics I was able too run the xeno-test
-l dohell and other tests.

When I reconfigured the system to use the native graphics (galcore.ko
kernel module) and EGLS2.0, get a kernel bug. I was wondering if anyone had
experience with using the imx6q with the native GPU and Xenomai?

I am sure the galcore.ko kernel module is not playing nice with xenomai. It
is built separately and has no patches in it. Below is the kernel trace as
well as some of the spam messages coming out afterwards.

Thanks for you time,

Jackson Jones

root@ZORRO01:~# warning: process `main_task' used the deprecated sysctl
system call with 8.1.2.
------------[ cut here ]------------
Kernel BUG at 800f6854 [verbose debug info unavailable]
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in: galcore(O)
CPU: 2 PID: 1826 Comm: main_task Tainted: G        W  O
4.1.15-g5599520-dirty #14
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: ce263dc0 ti: c9ec2000 task.ti: c9ec2000
PC is at remap_pfn_range+0x184/0x224
LR is at get_parent_ip+0x10/0x2c
pc : [<800f6854>]    lr : [<800537a0>]    psr: 20010013
sp : c9ec3d40  ip : 80c43c80  fp : 00000707
r10: 80b13554  r9 : 50600000  r8 : 00000103
r7 : a031b000  r6 : 0005a000  r5 : 50400000  r4 : a031b004
r3 : 000007ff  r2 : 7f4be71f  r1 : 00000000  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 313bc04a  DAC: 00000015
Process main_task (pid: 1826, stack limit = 0xc9ec2220)
Stack: (0xc9ec3d40 to 0xc9ec4000)
3d40: a13bd410 523fffff cedb9880 00009c00 80c43c80 d13fd37c 52400000
00000000
3d60: 02000000 cef9bf78 0005a000 00000000 02000000 50400000 00000000
cc023000
3d80: 00000000 8001d18c 00000707 02000000 cedb9880 fffffffa c113f9c0
00000000
3da0: ceb6c740 c113f0c8 8001d0b4 7f002ca0 02000000 c9ec3dbc 00000001
00000004
3dc0: 00000003 7f02ce70 c113f0c0 cea5c300 cf4ceac0 7f008b5c 7f02ca5c
cf4ceac0
3de0: cee27920 cea5c300 cf4ceac0 80115454 cea5c300 cee27920 cea5c300
cee27920
3e00: cea5c308 801153b0 c9ec3eb0 8010fb2c c9ec3ef0 c9ec3f74 00000000
00000002
3e20: c9ec3eb0 00000000 cc023000 8011c614 c9ec3e50 8011d1c8 00000000
cea5c300
3e40: 00000026 00000000 00000000 00000000 cebc6550 cc023000 ce12a028
80b25980
3e60: c9ec3f74 cee27920 c9ec2000 cea5c300 c9ec3ef0 00000000 c9ec3f74
cf81b000
3e80: c9ec3eb0 00000000 00000000 8011e82c c9ec3eac cf81b000 ffffffff
7fffffff
3ea0: 7fffffff 7425d984 00000000 00000000 cebc6550 cc3e0c38 cedb9880
00000984
3ec0: cea5c6c0 c9ec3f74 00000001 ffffff9c cf81b000 8000fac8 c9ec2000
00000000
3ee0: 00000000 8011f7d8 00000041 800f4f70 cebc6550 cc3e0c38 7f34df0e
00000007
3f00: cf81b015 00000000 00000000 cc09c440 cee27920 00000101 00000004
000000ce
3f20: 00000000 00000000 00000000 807863d0 0000000c 8012b70c 74230844
00000002
3f40: 00000000 00000002 ffffff9c cf81b000 00000005 0000000c ffffff9c
cf81b000
3f60: 00000005 80110e14 80b13740 80b0a75c 00010013 00000002 80b10000
00000026
3f80: 00000100 00000001 7425d984 00000000 022ec0f8 7423d54c 00000005
8000fac8
3fa0: c9ec2000 8000f880 00000000 022ec0f8 74230844 00000002 2020534f
ffffffff
3fc0: 00000000 022ec0f8 7423d54c 00000005 022ec0f8 7e814128 00000001
00000000
3fe0: 00000000 7e813f90 76133e19 76133e20 80010030 74230844 00000000
00000000
[<800f6854>] (remap_pfn_range) from [<8001d18c>] (arm_dma_mmap+0xd8/0xdc)
[<8001d18c>] (arm_dma_mmap) from [<7f002ca0>] (gckOS_MapMemory+0x1ac/0x24c
[galcore])
[<7f002ca0>] (gckOS_MapMemory [galcore]) from [<7f008b5c>]
(drv_open+0xb4/0x158 [galcore])
[<7f008b5c>] (drv_open [galcore]) from [<80115454>] (chrdev_open+0xa4/0x178)
[<80115454>] (chrdev_open) from [<8010fb2c>] (do_dentry_open+0x1d8/0x2f8)
[<8010fb2c>] (do_dentry_open) from [<8011c614>] (do_last+0x634/0xc78)
[<8011c614>] (do_last) from [<8011e82c>] (path_openat+0x80/0x588)
[<8011e82c>] (path_openat) from [<8011f7d8>] (do_filp_open+0x2c/0x88)
[<8011f7d8>] (do_filp_open) from [<80110e14>] (do_sys_open+0x108/0x1cc)
[<80110e14>] (do_sys_open) from [<8000f880>] (ret_fast_syscall+0x0/0x3c)
Code: e2844004 e5972000 e3520000 0affffec (e7f001f2)
---[ end trace ae54510c3e7f3927 ]---

Message from syslogd@ZORRO01 note: main_task[1826] exited with
preempt_count 1
at Jan 25 17:27:35 ...
 kernel:BUG: scheduling while atomic: main_task/1826/0x00000002
Internal error: Oops - BUG: 0 [#1Modules linked in: galcore(O)] PREEMPT SMP
ARM

Message f
rom syslogd@ZORRO01 at Jan 25 17:Preemption disabled at:27:35 ...
 kernel:Process main_[<  (null)>]   (null)
task (pid: 1826, stack limit = 0x
c9ec2220)

Message from syslCPU: 2 PID: 1826 Comm: main_task Tainted: G      D W  O
4.1.15-g5599520-dirty #14
ogd@ZORRO01 at Jan 25 17:27:35 ..Hardware name: Freescale i.MX6
Quad/DualLite (Device Tree)
.
 kernel:Stack: (0xc9ec3d40 to[<80016f6c>] (unwind_backtrace) from
[<80012c84>] (show_stack+0x10/0x14)
 0xc9ec4000)

Message from s[<80012c84>] (show_stack) from [<807814d4>]
(dump_stack+0x84/0xc4)
yslogd@ZORRO01 at Jan 25 17:27:35[<807814d4>] (dump_stack) from
[<800507d0>] (__schedule_bug+0x6c/0xc0)
 ...
 kernel:3d40: a13bd410 523[<800507d0>] (__schedule_bug) from [<80782ffc>]
(__schedule+0x478/0x5e0)
fffff cedb9880 00009c00 80c43c80 [<80782ffc>] (__schedule) from
[<807831a4>] (schedule+0x40/0xa0)
d13fd37c 52400000 00000000

[<807831a4>] (schedule) from [<80785464>]
(rwsem_down_read_failed+0xc0/0x100)
Message from syslogd@ZORRO01 at J[<80785464>] (rwsem_down_read_failed) from
[<800f4c80>] (get_user_pages_unlocked+0x34/0x1a4)
an 25 17:27:35 ...
 kernel:3d60[<800f4c80>] (get_user_pages_unlocked) from [<800ee540>]
(get_user_pages_fast+0x40/0x48)
: 02000000 cef9bf78 0005a000 0000[<800ee540>] (get_user_pages_fast) from
[<8008c2d8>] (get_futex_key+0xcc/0x22c)
0000 02000000 50400000 00000000 c[<8008c2d8>] (get_futex_key) from
[<8008c468>] (futex_wake+0x30/0x134)
c023000

Message from syslog[<8008c468>] (futex_wake) from [<8008e13c>]
(do_futex+0x134/0xa10)
[<8008e13c>] (do_futex) from [<8008ea98>] (SyS_futex+0x80/0x170)

 kernel:3d80: 00000000 8001d18c[<8008ea98>] (SyS_futex) from [<80032348>]
(mm_release+0xd4/0x10c)
 00000707 02000000 cedb9880 fffff[<80032348>] (mm_release) from
[<80035680>] (do_exit+0x148/0x994)
ffa c113f9c0 00000000

Messa[<80035680>] (do_exit) from [<80013078>] (die+0x3f0/0x3fc)
ge from syslogd@ZORRO01 at Jan 25[<80013078>] (die) from [<80009154>]
(do_undefinstr+0x140/0x190)
 17:27:35 ...
 kernel:3da0: ceb[<80009154>] (do_undefinstr) from [<80013860>]
(__und_svc_finish+0x0/0x20)
6c740 c113f0c8 8001d0b4 7f002ca0 Exception stack(0xc9ec3cf8 to 0xc9ec3d40)
02000000 c9ec3dbc 00000001
0000003ce0:                                                       00000000
00000000
04

Message from syslogd@ZOR3d00: 7f4be71f 000007ff a031b004 50400000 0005a000
a031b000 00000103 50600000
RO01 at Jan 25 17:27:35 ...
 ke3d20: 80b13554 00000707 80c43c80 c9ec3d40 800537a0 800f6854 20010013
ffffffff
rnel:3dc0: 00000003 7f02ce70 c113[<80013860>] (__und_svc_finish) from
[<800f6854>] (remap_pfn_range+0x184/0x224)
f0c0 cea5c300 cf4ceac0 7f008b5c 7[<800f6854>] (remap_pfn_range) from
[<8001d18c>] (arm_dma_mmap+0xd8/0xdc)
f02ca5c cf4ceac0

Message fr[<8001d18c>] (arm_dma_mmap) from [<7f002ca0>]
(gckOS_MapMemory+0x1ac/0x24c [galcore])
om syslogd@ZORRO01 at Jan 25 17:2[<7f002ca0>] (gckOS_MapMemory [galcore])
from [<7f008b5c>] (drv_open+0xb4/0x158 [galcore])
7:35 ...
 kernel:3de0: cee27920[<7f008b5c>] (drv_open [galcore]) from [<80115454>]
(chrdev_open+0xa4/0x178)
 cea5c300 cf4ceac0 80115454 cea5c[<80115454>] (chrdev_open) from
[<8010fb2c>] (do_dentry_open+0x1d8/0x2f8)
300 cee27920 cea5c300 cee27920
[<8010fb2c>] (do_dentry_open) from [<8011c614>] (do_last+0x634/0xc78)

Message from syslogd@ZORRO01 [<8011c614>] (do_last) from [<8011e82c>]
(path_openat+0x80/0x588)
at Jan 25 17:27:35 ...
 kernel:[<8011e82c>] (path_openat) from [<8011f7d8>]
(do_filp_open+0x2c/0x88)
3e00: cea5c308 801153b0 c9ec3eb0 [<8011f7d8>] (do_filp_open) from
[<80110e14>] (do_sys_open+0x108/0x1cc)
8010fb2c c9ec3ef0 c9ec3f74 000000[<80110e14>] (do_sys_open) from
[<8000f880>] (ret_fast_syscall+0x0/0x3c)
00 00000002

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3e20: c9ec3eb0 00000000 cc023000 8011c614 c9ec3e50 8011d1c8
00000000 cea5c300

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3e40: 00000026 00000000 00000000 00000000 cebc6550 cc023000
ce12a028 80b25980

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3e60: c9ec3f74 cee27920 c9ec2000 cea5c300 c9ec3ef0 00000000
c9ec3f74 cf81b000

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3e80: c9ec3eb0 00000000 00000000 8011e82c c9ec3eac cf81b000
ffffffff 7fffffff

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3ea0: 7fffffff 7425d984 00000000 00000000 cebc6550 cc3e0c38
cedb9880 00000984

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3ec0: cea5c6c0 c9ec3f74 00000001 ffffff9c cf81b000 8000fac8
c9ec2000 00000000

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3ee0: 00000000 8011f7d8 00000041 800f4f70 cebc6550 cc3e0c38
7f34df0e 00000007

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3f00: cf81b015 00000000 00000000 cc09c440 cee27920 00000101
00000004 000000ce

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3f20: 00000000 00000000 00000000 807863d0 0000000c 8012b70c
74230844 00000002

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3f40: 00000000 00000002 ffffff9c cf81b000 00000005 0000000c
ffffff9c cf81b000

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3f60: 00000005 80110e14 80b13740 80b0a75c 00010013 00000002
80b10000 00000026

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3f80: 00000100 00000001 7425d984 00000000 022ec0f8 7423d54c
00000005 8000fac8

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3fa0: c9ec2000 8000f880 00000000 022ec0f8 74230844 00000002
2020534f ffffffff

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3fc0: 00000000 022ec0f8 7423d54c 00000005 022ec0f8 7e814128
00000001 00000000

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:3fe0: 00000000 7e813f90 76133e19 76133e20 80010030 74230844
00000000 00000000

Message from syslogd@ZORRO01 at Jan 25 17:27:35 ...
 kernel:Code: e2844004 e5972000 e3520000 0affffec (e7f001f2)
