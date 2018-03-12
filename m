From: Nihar Unadkat <Nihar@deltatau.com>
Date: Mon, 12 Mar 2018 19:03:27 +0000
Message-ID: <BYAPR11MB28714348FF015A782E5E7064D1D30@BYAPR11MB2871.namprd11.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Kernel crash/hang upon power on
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Henry Bausley <hbausley@deltatau.com>

Hello support,

I am currently using Kernel version 4.1.18 that has been patched with xenom=
ai-2.6.5.
gcc version 4.9.3 and CPU: ARMv7 Processor

After every one time per one or two thousands reboot,  I get a kernel crash=
/hang at the same position "Waiting for root device /dev/mmcblk0p2...".

Here is what I am getting

[2018-03-11 07:36:40.811] Initializing XFRM netlink socket
[2018-03-11 07:36:40.811] NET: Registered protocol family 17
[2018-03-11 07:36:40.811] NET: Registered protocol family 15
[2018-03-11 07:36:40.827] Key type dns_resolver registered
[2018-03-11 07:36:40.827] Registering SWP/SWPB emulation handler
[2018-03-11 07:36:40.827] hctosys: unable to open rtc device (rtc0)
[2018-03-11 07:36:40.842] Waiting for root device /dev/mmcblk0p2...=20
[2018-03-11 07:37:01.840] INFO: rcu_sched detected stalls on CPUs/tasks:
[2018-03-11 07:37:01.840] =09(detected by 0, t=3D21002 jiffies, g=3D-267, c=
=3D-268, q=3D11)
[2018-03-11 07:37:01.840] All QSes seen, last rcu_sched kthread activity 21=
002 (-277311--298313), jiffies_till_next_fqs=3D3, root ->qsmask 0x0
[2018-03-11 07:37:01.856] swapper/0       R running      0     0      0 0x0=
0000000
[2018-03-11 07:37:01.856] [<80011dfd>] (unwind_backtrace) from [<8000f9bf>]=
 (show_stack+0xb/0xc)
[2018-03-11 07:37:01.871] [<8000f9bf>] (show_stack) from [<80047c0d>] (rcu_=
check_callbacks+0x3bd/0x4dc)
[2018-03-11 07:37:01.871] [<80047c0d>] (rcu_check_callbacks) from [<8004990=
7>] (update_process_times+0x23/0x46)
[2018-03-11 07:37:01.887] [<80049907>] (update_process_times) from [<800539=
85>] (tick_sched_handle+0x25/0x2e)
[2018-03-11 07:37:01.887] [<80053985>] (tick_sched_handle) from [<800539c7>=
] (tick_sched_timer+0x39/0x6a)
[2018-03-11 07:37:01.887] [<800539c7>] (tick_sched_timer) from [<80049f41>]=
 (__run_hrtimer+0x3f/0x86)
[2018-03-11 07:37:01.902] [<80049f41>] (__run_hrtimer) from [<8004a40b>] (h=
rtimer_interrupt+0xbf/0x1e0)
[2018-03-11 07:37:01.902] [<8004a40b>] (hrtimer_interrupt) from [<80312029>=
] (arch_timer_handler_phys+0x41/0x54)
[2018-03-11 07:37:01.918] [<80312029>] (arch_timer_handler_phys) from [<800=
41bc7>] (handle_percpu_devid_irq+0x53/0xa8)
[2018-03-11 07:37:01.918] [<80041bc7>] (handle_percpu_devid_irq) from [<800=
3fd83>] (generic_handle_irq+0x13/0x1c)
[2018-03-11 07:37:01.934] [<8003fd83>] (generic_handle_irq) from [<8003ff7b=
>] (__handle_domain_irq+0x73/0xac)
[2018-03-11 07:37:01.934] [<8003ff7b>] (__handle_domain_irq) from [<8005c31=
9>] (__ipipe_do_sync_stage+0x195/0x1f0)
[2018-03-11 07:37:01.949] [<8005c319>] (__ipipe_do_sync_stage) from [<80009=
2c5>] (__ipipe_grab_irq+0x4d/0x64)
[2018-03-11 07:37:01.949] [<800092c5>] (__ipipe_grab_irq) from [<80009493>]=
 (gic_handle_irq+0x2b/0x40)
[2018-03-11 07:37:01.965] Exception stack(0x805e5f50 to 0x805e5f98)
[2018-03-11 07:37:01.965] 5f40:                                     8005c43=
8 80000133 ffffffff 803b575b
[2018-03-11 07:37:01.965] 5f60: bffcd7a8 00000000 3f9ef000 00000000 805e400=
0 805e6508 805dd380 00000000
[2018-03-11 07:37:01.980] 5f80: ffffffff 805e6440 805d0f90 00000000 805e618=
0 805e5fa8
[2018-03-11 07:37:01.980] [<80009493>] (gic_handle_irq) from [<803b575b>] (=
__irq_svc+0x3b/0x42)
[2018-03-11 07:37:01.996] Exception stack(0x805e5f60 to 0x805e5fa8)
[2018-03-11 07:37:01.996] 5f60: bffcd7a8 00000000 3f9ef000 00000000 805e400=
0 805e6508 805dd380 00000000
[2018-03-11 07:37:01.996] 5f80: ffffffff 805e6440 805d0f90 00000000 805e618=
0 805e5fa8 8003af1d 8005c438
[2018-03-11 07:37:02.012] 5fa0: 80000133 ffffffff
[2018-03-11 07:37:02.012] [<803b575b>] (__irq_svc) from [<8005c438>] (ipipe=
_unstall_root+0x2c/0x3c)
[2018-03-11 07:37:02.012] [<8005c438>] (ipipe_unstall_root) from [<8003af1d=
>] (cpu_startup_entry+0xf1/0x128)
[2018-03-11 07:37:02.027] [<8003af1d>] (cpu_startup_entry) from [<8058c91f>=
] (start_kernel+0x27f/0x2e8)
[2018-03-11 07:37:02.027] [<8058c91f>] (start_kernel) from [<8000808f>] (0x=
8000808f)
[2018-03-11 07:37:02.027] rcu_sched kthread starved for 21002 jiffies!


NOTE: The only way to bypass this issue are=20
1) Pressing ENTER after the above message.
2) complete power cycle.

Please advise what I can do to solve this issue.

Thank you.

Nihar Unadkat =A0
Senior Firmware Engineer
Direct: 818-444-5206
nihar@deltatau.com

OMRON DELTA TAU=20
21314 Lassen Street, Chatsworth, CA 91311
deltatau.com=20
youtube.com/DeltaTauDataSystems


