MIME-Version: 1.0
In-Reply-To: <CADXNiGV-eAFW3-+qcT9OOFRvgW1uzow8a5geWrXeD0ieUNVFVA@mail.gmail.com>
References: <CADXNiGV-eAFW3-+qcT9OOFRvgW1uzow8a5geWrXeD0ieUNVFVA@mail.gmail.com>
From: Daesik Kwak <daesikcom@gmail.com>
Date: Thu, 26 Jan 2017 14:27:23 +0900
Message-ID: <CADy8pceLkMjpUOW8g5fgXXnnJFZhh2pN2KU_dS-do5ADbhAERw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xenomai 3.0.3 on imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>
Cc: xenomai@xenomai.org

Dear Jackson,


I have the same problem in i.mx6q (Linux 3.14.38 + xenomai 2.6.5).


Crash message appears at the same part when using the xenomai api in a Qt5
application.


I had debugging a GPU driver.


GPU driver had too much virtual memory and physical memory mapping and
memory allocation.


I think this was the main cause of the GPU driver crash with xenomai.


I agree your opinion that with xenomai and galcore module does not work
fine.


I attach the my crash message (as below).


Regards, Daesik Kwak



note: helloworld_qt5[884] exited with preempt_count 1

BUG: scheduling while atomic: helloworld_qt5/884/0x00000002

Modules linked in:

CPU: 0 PID: 884 Comm: helloworld_qt5 Tainted: G      D W    3.14.38 #28

[<800147dc>] (unwind_backtrace) from [<800117b4>] (show_stack+0x10/0x14)

[<800117b4>] (show_stack) from [<807248f4>] (__schedule_bug+0x4c/0x60)

[<807248f4>] (__schedule_bug) from [<80729688>] (__schedule+0x48c/0x550)

[<80729688>] (__schedule) from [<8072bce8>] (__down_read+0xe8/0x16c)

[<8072bce8>] (__down_read) from [<80029318>] (do_exit+0x114/0x9d4)

[<80029318>] (do_exit) from [<80011964>] (die+0x1ac/0x37c)

[<80011964>] (die) from [<800083c4>] (do_undefinstr+0x1c0/0x1ec)

[<800083c4>] (do_undefinstr) from [<80012420>] (__und_svc_finish+0x0/0x20)

Exception stack(0xa99d9cd8 to 0xa99d9d20)

9cc0:                                                       00000001
80ad4300

9ce0: 34c9030f a99d8000 6d6ff000 a9432400 6d800000 809f6010 00000307
00000101

9d00: 0003c700 a94323fc 000020fb a99d9d20 8004b360 80136008 20080013
ffffffff

[<80012420>] (__und_svc_finish) from [<80136008>]
(remap_pfn_range+0x1f0/0x228)

[<80136008>] (remap_pfn_range) from [<80018898>] (arm_dma_mmap+0xc4/0xc8)

[<80018898>] (arm_dma_mmap) from [<8052de44>] (gckOS_MapMemory+0x188/0x21c)

[<8052de44>] (gckOS_MapMemory) from [<80533c28>] (drv_open+0xb0/0x134)

[<80533c28>] (drv_open) from [<8015a35c>] (chrdev_open+0xd4/0x1cc)

...


On Thu, Jan 26, 2017 at 11:43 AM, Jackson Jones <jackson.jones@gmail.com>
wrote:

> I have successfully got xenomai 3.0.3 running on the Freescale/NXP
> 4.1.15-2.0.0 kernel. Using Mesa graphics I was able too run the xeno-test
> -l dohell and other tests.
>
> When I reconfigured the system to use the native graphics (galcore.ko
> kernel module) and EGLS2.0, get a kernel bug. I was wondering if anyone had
> experience with using the imx6q with the native GPU and Xenomai?
>
> I am sure the galcore.ko kernel module is not playing nice with xenomai. It
> is built separately and has no patches in it. Below is the kernel trace as
> well as some of the spam messages coming out afterwards.
>
> Thanks for you time,
>
> Jackson Jones
>
> root@ZORRO01:~# warning: process `main_task' used the deprecated sysctl
> system call with 8.1.2.
> ------------[ cut here ]------------
> Kernel BUG at 800f6854 [verbose debug info unavailable]
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> Modules linked in: galcore(O)
> CPU: 2 PID: 1826 Comm: main_task Tainted: G        W  O
> 4.1.15-g5599520-dirty #14
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> task: ce263dc0 ti: c9ec2000 task.ti: c9ec2000
> PC is at remap_pfn_range+0x184/0x224
> LR is at get_parent_ip+0x10/0x2c
> pc : [<800f6854>]    lr : [<800537a0>]    psr: 20010013
> sp : c9ec3d40  ip : 80c43c80  fp : 00000707
> r10: 80b13554  r9 : 50600000  r8 : 00000103
> r7 : a031b000  r6 : 0005a000  r5 : 50400000  r4 : a031b004
> r3 : 000007ff  r2 : 7f4be71f  r1 : 00000000  r0 : 00000000
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c53c7d  Table: 313bc04a  DAC: 00000015
> Process main_task (pid: 1826, stack limit = 0xc9ec2220)
> Stack: (0xc9ec3d40 to 0xc9ec4000)
> ...
> [<800f6854>] (remap_pfn_range) from [<8001d18c>] (arm_dma_mmap+0xd8/0xdc)
> [<8001d18c>] (arm_dma_mmap) from [<7f002ca0>] (gckOS_MapMemory+0x1ac/0x24c
> [galcore])
> [<7f002ca0>] (gckOS_MapMemory [galcore]) from [<7f008b5c>]
> (drv_open+0xb4/0x158 [galcore])
> [<7f008b5c>] (drv_open [galcore]) from [<80115454>]
> (chrdev_open+0xa4/0x178)
> [<80115454>] (chrdev_open) from [<8010fb2c>] (do_dentry_open+0x1d8/0x2f8)
> [<8010fb2c>] (do_dentry_open) from [<8011c614>] (do_last+0x634/0xc78)
> [<8011c614>] (do_last) from [<8011e82c>] (path_openat+0x80/0x588)
> [<8011e82c>] (path_openat) from [<8011f7d8>] (do_filp_open+0x2c/0x88)
> [<8011f7d8>] (do_filp_open) from [<80110e14>] (do_sys_open+0x108/0x1cc)
> [<80110e14>] (do_sys_open) from [<8000f880>] (ret_fast_syscall+0x0/0x3c)
> Code: e2844004 e5972000 e3520000 0affffec (e7f001f2)
> ---[ end trace ae54510c3e7f3927 ]---
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
