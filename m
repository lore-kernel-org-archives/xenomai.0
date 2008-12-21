Message-Id: <D6B7B711-7E2F-466D-857F-53EB7A7C30DC@su.sabanciuniv.edu>
From: Alphan Ulusoy <alphan@domain.hid>
In-Reply-To: <49302630.4080104@domain.hid>
Content-Type: multipart/signed; boundary=Apple-Mail-23-324902281; micalg=sha1;
	protocol="application/pkcs7-signature"
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Sun, 21 Dec 2008 21:28:08 +0200
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>	<492EF786.4040303@domain.hid>	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>	<49301B0B.9010208@domain.hid>
	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>
	<49302630.4080104@domain.hid>
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


--Apple-Mail-23-324902281
Content-Type: multipart/alternative;
	boundary=Apple-Mail-22-324902210


--Apple-Mail-22-324902210
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hello again,

Unfortunately I couldn't solve this issue of 'tasks turning into  
zombies after being killed' on my own. Below you may find the sysRq +  
T output. The name of the problematic task is:  "actuatorTask". This  
is a bit hard to reproduce since it does not happen all the time, i  
hope below output helps.

Also /proc/xenomai/stat says:

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          942268     0     00500080   99.9  ROOT
   0  15817  2899       2906       0     00300380    0.0  Actuator  
Aperiodic Task
   0  0      0          2275392    0     00000000    0.0  IRQ233:  
[timer]


and /proc/xenomai/sched says:

CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
   0  0       80      0          0          master    R          ROOT
   0  15817   80      0          0          master    X           
Actuator Aperiodic Task


[ 7565.309991] SysRq : Show State
[ 7565.309991]   task                PC stack   pid father
[ 7565.309991] init          S f7c2a15c     0     1      0
[ 7565.309991]        f7c2a000 00000086 006eec77 f7c2a15c c0575380  
c0126991 00000200 f7c2db64
[ 7565.309991]        006eec77 00000000 00000000 c03c8a0a c013166d  
f7c2dbe4 c0575ce8 c0575ce8
[ 7565.309991]        006eec77 c01265f0 f7c2a000 c0575380 0000000b  
00000400 c01a9b22 f7c2dbe4
[ 7565.309991] Call Trace:
[ 7565.309991]  [<c0126991>] __mod_timer+0xb1/0xf0
[ 7565.309991]  [<c03c8a0a>] schedule_timeout+0x4a/0xc0
[ 7565.309991]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309991]  [<c01265f0>] process_timeout+0x0/0x10
[ 7565.309991]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309991]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309991]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309991]  [<c01088a6>] read_tsc+0x6/0x30
[ 7565.309991]  [<c0139989>] clocksource_get_next+0x59/0x90
[ 7565.309991]  [<c0137d69>] update_wall_time+0x259/0x7d0
[ 7565.309991]  [<c0139989>] clocksource_get_next+0x59/0x90
[ 7565.309991]  [<c0137d69>] update_wall_time+0x259/0x7d0
[ 7565.309991]  [<c0137d69>] update_wall_time+0x259/0x7d0
[ 7565.309991]  [<c01088a6>] read_tsc+0x6/0x30
[ 7565.309991]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309991]  [<c01088a6>] read_tsc+0x6/0x30
[ 7565.309991]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309991]  [<c015463f>] xntimer_start_aperiodic+0x10f/0x200
[ 7565.309991]  [<c029ab23>] number+0x2d3/0x2e0
[ 7565.309991]  [<c0313538>] usb_choose_configuration+0x198/0x220
[ 7565.309991]  [<c01354cb>] hrtimer_interrupt+0x19b/0x1e0
[ 7565.309991]  [<c029b3b7>] vsnprintf+0x307/0x5e0
[ 7565.309991]  [<c014978f>] __xirq_end+0x0/0x46
[ 7565.309991]  [<c0139989>] clocksource_get_next+0x59/0x90
[ 7565.309991]  [<c0137d69>] update_wall_time+0x259/0x7d0
[ 7565.309991]  [<c0137d69>] update_wall_time+0x259/0x7d0
[ 7565.309991]  [<c0147961>] __rcu_read_unlock+0x41/0x90
[ 7565.309991]  [<c01aea09>] __d_lookup+0xc9/0x160
[ 7565.309991]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309991]  [<c01a397a>] permission+0x6a/0x110
[ 7565.309991]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309991]  [<c0197794>] __slab_alloc+0x74/0x510
[ 7565.309991]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309991]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309991]  [<c01b4183>] mntput_no_expire+0x13/0x120
[ 7565.309991]  [<c01a606e>] path_walk+0x4e/0x90
[ 7565.309991]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309991]  [<c029c6c5>] copy_to_user+0x35/0x60
[ 7565.309991]  [<c019f488>] cp_new_stat64+0xf8/0x110
[ 7565.309991]  [<c01aa382>] sys_select+0xe2/0x1b0
[ 7565.309991]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309991]  =======================
[ 7565.309991] kthreadd      S f7c2a4bc     0     2      0
[ 7565.309991]        f7c2a360 00000046 f7c2a4c0 f7c2a4bc 00000000  
c0119c46 f766fde8 c047f1f0
[ 7565.309991]        00003dba f766fdc4 00000000 c0131105 00000000  
c0130f60 00000000 00000000
[ 7565.309991]        00000000 c0103db3 00000000 00000000 00000000  
00000000 00000000 00000000
[ 7565.309991] Call Trace:
[ 7565.309991]  [<c0119c46>] complete+0x76/0xb0
[ 7565.309992]  [<c0131105>] kthreadd+0x1a5/0x1d0
[ 7565.309992]  [<c0130f60>] kthreadd+0x0/0x1d0
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] ksoftirqd/0   S f7c2a81c     0     3      2
[ 7565.309992]        f7c2a6c0 00000046 c0575180 f7c2a81c c0121d9a  
00000000 00000000 00000000
[ 7565.309992]        00000000 c0122120 00000000 c0122219 fffffffc  
c0130f32 c0130ef0 00000000
[ 7565.309992]        00000000 c0103db3 f7c2df20 00000000 00000000  
00000000 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0121d9a>] __do_softirq+0x6a/0xb0
[ 7565.309992]  [<c0122120>] ksoftirqd+0x0/0x180
[ 7565.309992]  [<c0122219>] ksoftirqd+0xf9/0x180
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] events/0      R running      0     4      2
[ 7565.309992]        f7c2aa20 00000046 c012d8c0 f7c2ab7c c04762e0  
c01315a5 00000200 f7c08100
[ 7565.309992]        f7c08108 00000000 00000000 c012e1bd 00000000  
f7c2aa20 c01312c0 f7c37fc0
[ 7565.309992]        f7c37fc0 fffffffc f7c08100 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c012d8c0>] run_workqueue+0x120/0x1b0
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] khelper       S f7c2aedc     0     5      2
[ 7565.309992]        f7c2ad80 00000046 c012d8c0 f7c2aedc f7f22d80  
c01315a5 00000200 f7c08180
[ 7565.309992]        f7c08188 00000000 00000000 c012e1bd 00000000  
f7c2ad80 c01312c0 f7c08188
[ 7565.309992]        f7c08188 fffffffc f7c08180 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c012d8c0>] run_workqueue+0x120/0x1b0
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] kblockd/0     S f7c8323c     0    52      2
[ 7565.309992]        f7c830e0 00000046 c012d8c0 f7c8323c c04762e0  
c01315a5 00000200 f7c19b80
[ 7565.309992]        f7c19b88 00000000 00000000 c012e1bd 00000000  
f7c830e0 c01312c0 f7c19b88
[ 7565.309992]        f7c19b88 fffffffc f7c19b80 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c012d8c0>] run_workqueue+0x120/0x1b0
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] khubd         S f7cd123c     0    61      2
[ 7565.309992]        f7cd10e0 00000046 000003e8 f7cd123c f7c9ad9c  
c01315a5 00000200 f7cddfa4
[ 7565.309992]        f7c9ad80 00000000 00000003 c0306cb4 f7cddfbc  
00000000 f7cd1108 0cb15b1c
[ 7565.309992]        00000000 00000239 f75e7d04 f7eeb21c f75e7c00  
f7c9f01c 00000000 00000002
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c0306cb4>] hub_thread+0x674/0xd10
[ 7565.309992]  [<c0117dfe>] hrtick_set+0x8e/0x1a0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c0306640>] hub_thread+0x0/0xd10
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] kseriod       S f7cd1c5c     0    64      2
[ 7565.309992]        f7cd1b00 00000046 c0197c85 f7cd1c5c 00000000  
c01315a5 00000200 f7ce3fb0
[ 7565.309992]        00000000 00000000 00000200 c0322a7f c0476160  
00000000 f7cd1b00 c03c8219
[ 7565.309992]        00000000 f7cd1b00 c01312c0 c04ae2d8 c04ae2d8  
fffffffc 00000000 c0322970
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0197c85>] kfree+0x55/0x110
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c0322a7f>] serio_thread+0x10f/0x430
[ 7565.309992]  [<c03c8219>] schedule+0x219/0x430
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c0322970>] serio_thread+0x0/0x430
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] gatekeeper/0  S f7e4e4bc     0   148      2
[ 7565.309992]        f7e4e360 00000046 00000000 f7e4e4bc c057c540  
c0577b00 c0581a2c f7e61a20
[ 7565.309992]        c0581a20 c0581a2c 00000000 c0156a77 00000000  
f7e4e360 c03c8219 00000001
[ 7565.309992]        f7e4e360 c0119840 c0581a24 c0581a24 fffffffc  
c0581a20 c01569d0 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0156a77>] gatekeeper_thread+0xa7/0x130
[ 7565.309992]  [<c03c8219>] schedule+0x219/0x430
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c01569d0>] gatekeeper_thread+0x0/0x130
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] pdflush       S f7e4f23c     0   152      2
[ 7565.309992]        f7e4f0e0 00000046 f7e4f0e0 f7e4f23c c03c85be  
c0119684 00000200 f7e5dfc4
[ 7565.309992]        00000000 c017d200 00000000 c017d2d4 f7e4f23c  
f7e4f0e0 00000000 00000000
[ 7565.309992]        c0485e54 f7e5ffc4 fffb6d17 fffffffc c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c85be>] preempt_schedule+0x4e/0x70
[ 7565.309992]  [<c0119684>] set_user_nice+0x114/0x170
[ 7565.309992]  [<c017d200>] pdflush+0x0/0x270
[ 7565.309992]  [<c017d2d4>] pdflush+0xd4/0x270
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] pdflush       S f7e4f59c     0   153      2
[ 7565.309992]        f7e4f440 00000046 00000000 f7e4f59c 00000000  
00000000 00000025 f7e5ffc4
[ 7565.309992]        00000000 c017d200 00000000 c017d2d4 f7e4f59c  
f7e4f440 00000000 00000000
[ 7565.309992]        f7e5dfc4 c0485e54 006edb25 fffffffc c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c017d200>] pdflush+0x0/0x270
[ 7565.309992]  [<c017d2d4>] pdflush+0xd4/0x270
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] kswapd0       S f7e4f8fc     0   154      2
[ 7565.309992]        f7e4f7a0 00000046 00000000 f7e4f8fc 00000000  
c01315a5 00000200 00000000
[ 7565.309992]        c0485340 c01312c0 00000000 c018119b 00000000  
00000000 f7eb9f74 f7e4f7c8
[ 7565.309992]        c0485de8 00000000 00000203 c0116ebb f7e4f7a0  
c0117160 c0180de0 f7e4f7c8
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c018119b>] kswapd+0x3bb/0x430
[ 7565.309992]  [<c0116ebb>] update_curr+0x6b/0x70
[ 7565.309992]  [<c0117160>] __dequeue_entity+0x50/0xc0
[ 7565.309992]  [<c0180de0>] kswapd+0x0/0x430
[ 7565.309992]  [<c011796b>] dequeue_task_fair+0x2b/0x100
[ 7565.309992]  [<c0117dfe>] hrtick_set+0x8e/0x1a0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c0119c46>] complete+0x76/0xb0
[ 7565.309992]  [<c0180de0>] kswapd+0x0/0x430
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] aio/0         S f7f4b23c     0   197      2
[ 7565.309992]        f7f4b0e0 00000046 c04f4338 f7f4b23c 00000000  
c01315a5 00000200 f7c19a80
[ 7565.309992]        f7c19a88 00000000 00000000 c012e1bd 00000000  
f7f4b0e0 c01312c0 f7c19a88
[ 7565.309992]        f7c19a88 fffffffc f7c19a80 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] unionfs_siod/ S f7f9415c     0   210      2
[ 7565.309992]        f7f94000 00000046 c04f4338 f7f9415c 00000000  
c01315a5 00000200 f7c190c0
[ 7565.309992]        f7c190c8 00000000 00000000 c012e1bd 00000000  
f7f94000 c01312c0 f7c190c8
[ 7565.309992]        f7c190c8 fffffffc f7c190c0 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] nfsiod        S f7f944bc     0   211      2
[ 7565.309992]        f7f94360 00000046 c04f4338 f7f944bc 00000000  
c01315a5 00000200 f7c08a80
[ 7565.309992]        f7c08a88 00000000 00000000 c012e1bd 00000000  
f7f94360 c01312c0 f7c08a88
[ 7565.309992]        f7c08a88 fffffffc f7c08a80 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] scsi_eh_0     S f7c82edc     0   874      2
[ 7565.309992]        f7c82d80 00000046 c047f254 f7c82edc f7c82d80  
c0117160 00000000 fffffffc
[ 7565.309992]        f7caa000 00000000 f7cb5fbc c02f4c7a 00000000  
c0117e30 00000000 ffffffff
[ 7565.309992]        ffffffff 00000200 f7c82d80 c0476160 00000000  
f7c82d80 c03c8219 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0117160>] __dequeue_entity+0x50/0xc0
[ 7565.309992]  [<c02f4c7a>] scsi_error_handler+0x4a/0x3b0
[ 7565.309992]  [<c0117e30>] hrtick_set+0xc0/0x1a0
[ 7565.309992]  [<c03c8219>] schedule+0x219/0x430
[ 7565.309992]  [<c0119c46>] complete+0x76/0xb0
[ 7565.309992]  [<c02f4c30>] scsi_error_handler+0x0/0x3b0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] usb-storage   S f7c838fc     0   875      2
[ 7565.309992]        f7c837a0 00000046 c04f4300 f7c838fc c0134fe2  
00000000 00000000 f7c837a0
[ 7565.309992]        7fffffff 00040000 00000000 c03c8a35 0000049b  
00000000 00989680 00000000
[ 7565.309992]        c0116e40 f7c2a6e8 f7c2a6c0 f7c837a0 f7c837a0  
7fffffff c03c94a9 f7caa39c
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0134fe2>] ktime_get_ts+0x22/0x50
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0116e40>] wakeup_preempt_entity+0x70/0x80
[ 7565.309992]  [<c03c94a9>] __down_interruptible+0x69/0xe0
[ 7565.309992]  [<c0135f97>] down_interruptible+0x87/0xa0
[ 7565.309992]  [<c0320c80>] usb_stor_control_thread+0x60/0x240
[ 7565.309992]  [<c03c8219>] schedule+0x219/0x430
[ 7565.309992]  [<c0119c46>] complete+0x76/0xb0
[ 7565.309992]  [<c0320c20>] usb_stor_control_thread+0x0/0x240
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] kpsmoused     S f7cd04bc     0   887      2
[ 7565.309992]        f7cd0360 00000046 00000000 f7cd04bc ffffffff  
c01315a5 00000200 f7c9b880
[ 7565.309992]        f7c9b888 00000000 00000000 c012e1bd 00000000  
f7cd0360 c01312c0 f7c9b888
[ 7565.309992]        f7c9b888 fffffffc f7c9b880 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] rpciod/0      S f7cd18fc     0   898      2
[ 7565.309992]        f7cd17a0 00000046 00000000 f7cd18fc ffffffff  
c01315a5 00000200 f7c9b6c0
[ 7565.309992]        f7c9b6c8 00000000 00000000 c012e1bd 00000000  
f7cd17a0 c01312c0 f7c9b6c8
[ 7565.309992]        f7c9b6c8 fffffffc f7c9b6c0 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] kjournald     S f7e4e81c     0   902      2
[ 7565.309992]        f7e4e6c0 00000046 c0119aaf f7e4e81c 00000000  
c01315a5 00000200 f7fb8500
[ 7565.309992]        00000000 f7fb85c4 f7fb8540 c01f9da5 00000000  
00000005 f7fb8550 00000000
[ 7565.309992]        f7e4e6c0 c01312c0 f7fb8550 f7fb8550 fffffffc  
f7fb8500 c01f9b80 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0119aaf>] __wake_up+0x7f/0xd0
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c01f9da5>] kjournald+0x225/0x270
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c01f9b80>] kjournald+0x0/0x270
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] udevd         S f7c2b23c     0  1004      1
[ 7565.309992]        f7c2b0e0 00000082 808fe474 f7c2b23c f7f94d80  
f7f4fb3c c013166d 00000008
[ 7565.309992]        00000080 00000000 00000000 c03c8a35 c013166d  
c013166d f7f4fbe4 c03c8d50
[ 7565.309992]        f7461060 00000041 c01ca515 00000007 00000008  
00000080 c01a9b22 f7f4fbe4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c03c8d50>] mutex_lock+0x10/0x20
[ 7565.309992]  [<c01ca515>] inotify_poll+0x45/0x60
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c017ab5b>] get_page_from_freelist+0x25b/0x590
[ 7565.309992]  [<c029ab23>] number+0x2d3/0x2e0
[ 7565.309992]  [<c017c5b9>] balance_dirty_pages_ratelimited_nr 
+0x59/0x2c0
[ 7565.309992]  [<c01160b3>] kmap_atomic_prot+0x13/0xa0
[ 7565.309992]  [<c0116066>] kunmap_atomic+0x26/0x60
[ 7565.309992]  [<c019304f>] shmem_getpage+0x4ef/0x960
[ 7565.309992]  [<c0183803>] do_wp_page+0x1f3/0x4c0
[ 7565.309992]  [<c017ba76>] set_page_dirty+0x46/0xd0
[ 7565.309992]  [<c029b3b7>] vsnprintf+0x307/0x5e0
[ 7565.309992]  [<c0113bdf>] do_page_fault+0x29f/0x6d0
[ 7565.309992]  [<c01128d7>] __ipipe_handle_exception+0xe7/0x1e0
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c01aea09>] __d_lookup+0xc9/0x160
[ 7565.309992]  [<c01aea09>] __d_lookup+0xc9/0x160
[ 7565.309992]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309992]  [<c01ae2ad>] dput+0x7d/0x190
[ 7565.309992]  [<c01a3c9b>] __follow_mount+0x1b/0x70
[ 7565.309992]  [<c01a3e45>] do_lookup+0x65/0x1a0
[ 7565.309992]  [<c0195030>] shmem_permission+0x0/0x10
[ 7565.309992]  [<c01a397a>] permission+0x6a/0x110
[ 7565.309992]  [<c01a5237>] __link_path_walk+0x67/0xe50
[ 7565.309992]  [<c0147961>] __rcu_read_unlock+0x41/0x90
[ 7565.309992]  [<c03c8d50>] mutex_lock+0x10/0x20
[ 7565.309992]  [<c0147961>] __rcu_read_unlock+0x41/0x90
[ 7565.309992]  [<c01aea09>] __d_lookup+0xc9/0x160
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c01317d0>] remove_wait_queue+0x70/0xb0
[ 7565.309992]  [<c011f38c>] do_wait+0x3bc/0xc80
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309992]  [<c01a69e9>] do_rmdir+0xb9/0x100
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] kjournald     S f7f4a4bc     0  2073      2
[ 7565.309992]        f7f4a360 00000046 c0119aaf f7f4a4bc 00000000  
c01315a5 00000200 f745a400
[ 7565.309992]        00000000 f745a4c4 f745a440 c01f9da5 00000000  
00000005 f745a450 00000000
[ 7565.309992]        f7f4a360 c01312c0 f745a450 f745a450 fffffffc  
f745a400 c01f9b80 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0119aaf>] __wake_up+0x7f/0xd0
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c01f9da5>] kjournald+0x225/0x270
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c01f9b80>] kjournald+0x0/0x270
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] kjournald     S f7f9481c     0  2080      2
[ 7565.309992]        f7f946c0 00000046 c0119aaf f7f9481c 00000000  
c01315a5 00000200 f745a200
[ 7565.309992]        00000000 f745a2c4 f745a240 c01f9da5 00000000  
00000005 f745a250 00000000
[ 7565.309992]        f7f946c0 c01312c0 f745a250 f745a250 fffffffc  
f745a200 c01f9b80 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0119aaf>] __wake_up+0x7f/0xd0
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c01f9da5>] kjournald+0x225/0x270
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c01f9b80>] kjournald+0x0/0x270
[ 7565.309992]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309992]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309992]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309992]  =======================
[ 7565.309992] dhclient3     S f7c2b8fc     0  2153      1
[ 7565.309992]        f7c2b7a0 00000086 0071a227 f7c2b8fc c0575380  
c0126991 00000200 f7633b64
[ 7565.309992]        0071a227 00000000 00000000 c03c8a0a c013166d  
f74a3a00 c0575db8 c0575db8
[ 7565.309992]        0071a227 c01265f0 f7c2b7a0 c0575380 00000006  
00000020 c01a9b22 f7633be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0126991>] __mod_timer+0xb1/0xf0
[ 7565.309992]  [<c03c8a0a>] schedule_timeout+0x4a/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c01265f0>] process_timeout+0x0/0x10
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c01f3c86>] do_get_write_access+0x1e6/0x480
[ 7565.309992]  [<c01c03e2>] __getblk+0x22/0x220
[ 7565.309992]  [<c01e6eb1>] __ext3_get_inode_loc+0xe1/0x2e0
[ 7565.309992]  [<c01f54f6>] journal_dirty_metadata+0x76/0x120
[ 7565.309992]  [<c01f3312>] __ext3_journal_dirty_metadata+0x22/0x60
[ 7565.309992]  [<c01f3f49>] journal_get_write_access+0x29/0x40
[ 7565.309992]  [<c017ab5b>] get_page_from_freelist+0x25b/0x590
[ 7565.309992]  [<c01088a6>] read_tsc+0x6/0x30
[ 7565.309992]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309992]  [<c0196f6e>] deactivate_slab+0x5e/0x180
[ 7565.309992]  [<c0197794>] __slab_alloc+0x74/0x510
[ 7565.309992]  [<c0117063>] hrtick_start_fair+0xa3/0x150
[ 7565.309992]  [<c0139989>] clocksource_get_next+0x59/0x90
[ 7565.309992]  [<c0137d69>] update_wall_time+0x259/0x7d0
[ 7565.309992]  [<c0198dd8>] __kmalloc_track_caller+0x78/0x120
[ 7565.309992]  [<c0341e48>] sock_alloc_send_skb+0x168/0x1b0
[ 7565.309992]  [<c011941d>] task_rq_lock+0x2d/0x40
[ 7565.309992]  [<c029ab23>] number+0x2d3/0x2e0
[ 7565.309992]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309992]  [<c015463f>] xntimer_start_aperiodic+0x10f/0x200
[ 7565.309992]  [<c029b3b7>] vsnprintf+0x307/0x5e0
[ 7565.309992]  [<c0121d9a>] __do_softirq+0x6a/0xb0
[ 7565.309992]  [<c0121cc8>] _local_bh_enable+0x28/0x90
[ 7565.309992]  [<c0121e45>] do_softirq+0x65/0x70
[ 7565.309992]  [<c0121f3f>] irq_exit+0x5f/0x90
[ 7565.309992]  [<c010f5a0>] smp_apic_timer_interrupt+0x30/0x70
[ 7565.309992]  [<c01160b3>] kmap_atomic_prot+0x13/0xa0
[ 7565.309992]  [<c010318c>] restore_nocheck_notrace+0x0/0xe
[ 7565.309992]  [<c010f570>] smp_apic_timer_interrupt+0x0/0x70
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c014978f>] __xirq_end+0x0/0x46
[ 7565.309992]  [<c0147961>] __rcu_read_unlock+0x41/0x90
[ 7565.309992]  [<c01aea09>] __d_lookup+0xc9/0x160
[ 7565.309992]  [<c01345d2>] enqueue_hrtimer+0x72/0xf0
[ 7565.309992]  [<c0183803>] do_wp_page+0x1f3/0x4c0
[ 7565.309992]  [<c0185d00>] handle_mm_fault+0x3a0/0x670
[ 7565.309992]  [<c0113bdf>] do_page_fault+0x29f/0x6d0
[ 7565.309992]  [<c01aa382>] sys_select+0xe2/0x1b0
[ 7565.309992]  [<c029c6c5>] copy_to_user+0x35/0x60
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] syslogd       S f7f95c5c     0  2294      1
[ 7565.309992]        f7f95b00 00000086 c01e6c14 f7f95c5c f7f957a0  
c01f54f6 c013166d 00000001
[ 7565.309992]        00000001 00000000 00000000 c03c8a35 00000001  
f7437be4 f7ee8000 011a92de
[ 7565.309992]        c03f2be0 00000001 f7ee8000 00000000 00000001  
00000001 c01a9b22 f7437be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01e6c14>] ext3_mark_iloc_dirty+0x174/0x330
[ 7565.309992]  [<c01f54f6>] journal_dirty_metadata+0x76/0x120
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c01f54f6>] journal_dirty_metadata+0x76/0x120
[ 7565.309992]  [<c01f3312>] __ext3_journal_dirty_metadata+0x22/0x60
[ 7565.309992]  [<c01f3f49>] journal_get_write_access+0x29/0x40
[ 7565.309992]  [<c01e6c14>] ext3_mark_iloc_dirty+0x174/0x330
[ 7565.309992]  [<c01e7187>] ext3_mark_inode_dirty+0x37/0x50
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01f3985>] journal_stop+0x135/0x250
[ 7565.309992]  [<c017c5b9>] balance_dirty_pages_ratelimited_nr 
+0x59/0x2c0
[ 7565.309992]  [<c01e9372>] ext3_ordered_write_end+0xe2/0x140
[ 7565.309992]  [<c01b5825>] mnt_drop_write+0x95/0x180
[ 7565.309992]  [<c0175ec5>] generic_file_buffered_write+0x1c5/0x690
[ 7565.309992]  [<c01b5825>] mnt_drop_write+0x95/0x180
[ 7565.309992]  [<c03a1f04>] unix_dgram_recvmsg+0x184/0x2a0
[ 7565.309992]  [<c01747d5>] remove_suid+0x15/0x60
[ 7565.309992]  [<c01b5825>] mnt_drop_write+0x95/0x180
[ 7565.309992]  [<c01765dd>] __generic_file_aio_write_nolock+0x24d/0x560
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c01a2ce0>] pipe_write+0x0/0x470
[ 7565.309992]  [<c019b94f>] do_sync_readv_writev+0xbf/0x100
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c019f488>] cp_new_stat64+0xf8/0x110
[ 7565.309992]  [<c029c413>] copy_from_user+0x33/0x80
[ 7565.309992]  [<c019b7de>] rw_copy_check_uvector+0x7e/0x100
[ 7565.309992]  [<c019c0aa>] do_readv_writev+0xaa/0x190
[ 7565.309992]  [<c01a2ce0>] pipe_write+0x0/0x470
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c01273b4>] sigprocmask+0x74/0x100
[ 7565.309992]  [<c0129fc9>] sys_rt_sigprocmask+0xf9/0x120
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] klogd         R running      0  2300      1
[ 7565.309992]        f7f957a0 00000082 00000000 f7f958fc 00000000  
c01315a5 00000200 f76b7f34
[ 7565.309992]        c01312c0 00000fff 0804d6a0 c011da47 f76b7f1c  
f76b7f1c 00000000 00000000
[ 7565.309992]        f76b7e80 494e9495 00000000 f7f957a0 c01312c0  
f76b7f40 f76b7f40 f7c0c300
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c011da47>] do_syslog+0x437/0x4c0
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c01dbae0>] kmsg_read+0x0/0x50
[ 7565.309992]  [<c01d2990>] proc_reg_read+0x80/0xe0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c01d2910>] proc_reg_read+0x0/0xe0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] inetd         S f7c8359c     0  2310      1
[ 7565.309992]        f7c83440 00000086 f794c000 f7c8359c f7fb8500  
c18de7a0 000fa013 00000006
[ 7565.309992]        00000020 00000000 00000000 c03c8a35 c013166d  
f7fdfbe4 f769c440 f7fc9c80
[ 7565.309992]        00000000 c036fb94 c03f2000 00000020 00000006  
00000020 c01a9b22 f7fdfbe4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c036fb94>] tcp_poll+0x14/0x150
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02adef5>] extract_buf+0x75/0xe0
[ 7565.309992]  [<c035f51a>] __nla_reserve+0x2a/0x70
[ 7565.309992]  [<c035f579>] __nla_put+0x19/0x40
[ 7565.309992]  [<c01160b3>] kmap_atomic_prot+0x13/0xa0
[ 7565.309992]  [<c0116066>] kunmap_atomic+0x26/0x60
[ 7565.309992]  [<c017ac12>] get_page_from_freelist+0x312/0x590
[ 7565.309992]  [<c017af36>] __alloc_pages_internal+0xa6/0x450
[ 7565.309992]  [<c02adef5>] extract_buf+0x75/0xe0
[ 7565.309992]  [<c01160b3>] kmap_atomic_prot+0x13/0xa0
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c0177285>] generic_file_aio_read+0x5b5/0x620
[ 7565.309992]  [<c01776ab>] filemap_fault+0x14b/0x4d0
[ 7565.309992]  [<c0183ed8>] __do_fault+0x188/0x360
[ 7565.309992]  [<c0185a6f>] handle_mm_fault+0x10f/0x670
[ 7565.309992]  [<c0113bdf>] do_page_fault+0x29f/0x6d0
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] nmbd          S f7cd015c     0  2318      1
[ 7565.309992]        f7cd0000 00000086 006edf00 f7cd015c c0575380  
c0126991 00000200 f74c1b64
[ 7565.309992]        006edf00 00000000 00000000 c03c8a0a c013166d  
f74c1be4 c0575c80 c0575c80
[ 7565.309992]        006edf00 c01265f0 f7cd0000 c0575380 0000000c  
00000800 c01a9b22 f74c1be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0126991>] __mod_timer+0xb1/0xf0
[ 7565.309992]  [<c03c8a0a>] schedule_timeout+0x4a/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c01265f0>] process_timeout+0x0/0x10
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0369698>] ip_finish_output+0x1c8/0x2c0
[ 7565.309992]  [<c0343f8f>] __skb_clone+0x1f/0xd0
[ 7565.309992]  [<c0367fc8>] ip_cork_release+0x28/0x40
[ 7565.309992]  [<c03473fa>] skb_queue_tail+0x6a/0xb0
[ 7565.309992]  [<c034394c>] sock_def_readable+0x4c/0x80
[ 7565.309992]  [<c0342933>] sock_queue_rcv_skb+0xa3/0xe0
[ 7565.309992]  [<c0384697>] udp_queue_rcv_skb+0xc7/0x270
[ 7565.309992]  [<c0347c98>] skb_copy_and_csum_datagram+0x258/0x3c0
[ 7565.309992]  [<c0197192>] __slab_free+0x72/0x340
[ 7565.309992]  [<c0197192>] __slab_free+0x72/0x340
[ 7565.309992]  [<c03457f8>] __kfree_skb+0x8/0x80
[ 7565.309992]  [<c034860a>] skb_free_datagram+0xa/0x30
[ 7565.309992]  [<c034860a>] skb_free_datagram+0xa/0x30
[ 7565.309992]  [<c01986fc>] kmem_cache_free+0x7c/0xd0
[ 7565.309992]  [<c034860a>] skb_free_datagram+0xa/0x30
[ 7565.309992]  [<c0121c8a>] local_bh_disable+0xa/0x20
[ 7565.309992]  [<c0341a07>] release_sock+0xc7/0xf0
[ 7565.309992]  [<c0122076>] local_bh_enable+0x46/0x90
[ 7565.309992]  [<c0386324>] udp_recvmsg+0x1b4/0x330
[ 7565.309992]  [<c0341425>] sock_common_recvmsg+0x45/0x70
[ 7565.309992]  [<c033f6c7>] sock_recvmsg+0xd7/0x110
[ 7565.309992]  [<c0139989>] clocksource_get_next+0x59/0x90
[ 7565.309992]  [<c0137d69>] update_wall_time+0x259/0x7d0
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c015259e>] xnarch_next_htick_shot+0x4e/0x60
[ 7565.309992]  [<c03c8d50>] mutex_lock+0x10/0x20
[ 7565.309992]  [<c034cde7>] netdev_run_todo+0x27/0x270
[ 7565.309992]  [<c034a723>] __dev_get_by_name+0x73/0x90
[ 7565.309992]  [<c01a890f>] fasync_helper+0x7f/0x120
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01ab7ab>] __posix_lock_file+0x6b/0x570
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01acb5e>] fcntl_setlk64+0x4e/0x2b0
[ 7565.309992]  [<c01aa382>] sys_select+0xe2/0x1b0
[ 7565.309992]  [<c01273b4>] sigprocmask+0x74/0x100
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] smbd          S f7cd0b7c     0  2320      1
[ 7565.309992]        f7cd0a20 00000082 c01bc400 f7cd0b7c f794c000  
00000000 f7fb8500 00000015
[ 7565.309992]        00100000 00000000 00000000 c03c8a35 c013166d  
f7511be4 f7fbd780 f7535a00
[ 7565.309992]        00000000 c01a21c2 00000014 00100000 00000015  
00100000 c01a9b22 f7511be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01bc400>] __mark_inode_dirty+0x30/0x1b0
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c01a21c2>] pipe_poll+0x32/0xc0
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02adef5>] extract_buf+0x75/0xe0
[ 7565.309992]  [<c02adef5>] extract_buf+0x75/0xe0
[ 7565.309992]  [<c01796ce>] __rmqueue+0x1e/0x1d0
[ 7565.309992]  [<c017995c>] rmqueue_bulk+0x6c/0x90
[ 7565.309992]  [<c017ab5b>] get_page_from_freelist+0x25b/0x590
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c017ab5b>] get_page_from_freelist+0x25b/0x590
[ 7565.309992]  [<c01776ab>] filemap_fault+0x14b/0x4d0
[ 7565.309992]  [<c0183ed8>] __do_fault+0x188/0x360
[ 7565.309992]  [<c0185a6f>] handle_mm_fault+0x10f/0x670
[ 7565.309992]  [<c0197daf>] kmem_cache_alloc+0x5f/0xd0
[ 7565.309992]  [<c0113bdf>] do_page_fault+0x29f/0x6d0
[ 7565.309992]  [<c0197daf>] kmem_cache_alloc+0x5f/0xd0
[ 7565.309992]  [<c019d0bb>] alloc_file+0x3b/0x60
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c01a842b>] do_fcntl+0x2ab/0x310
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] smbd          S f7e4eedc     0  2330   2320
[ 7565.309992]        f7e4ed80 00000082 fffffff7 f7e4eedc 0000000e  
00000009 c01a84dd 00000000
[ 7565.309992]        00000001 00000003 f7c8a000 c01294f0 c0103145  
00000000 00000019 089f6fd8
[ 7565.309992]        00000001 00000003 bfec4fe8 0000001d 0000007b  
0000007b c0100000 0000001d
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c01a84dd>] sys_fcntl64+0x4d/0x90
[ 7565.309992]  [<c01294f0>] sys_pause+0x10/0x20
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] sshd          S f7f4b8fc     0  2335      1
[ 7565.309992]        f7f4b7a0 00000082 f794c018 f7f4b8fc f7f22d80  
c18de7a0 000fa013 00000005
[ 7565.309992]        00000010 00000000 00000000 c03c8a35 c013166d  
f74d3be4 f769d540 f7fc9b00
[ 7565.309992]        00000000 c036fb94 c03f2000 00000010 00000005  
00000010 c01a9b22 f74d3be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c036fb94>] tcp_poll+0x14/0x150
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c01e6eb1>] __ext3_get_inode_loc+0xe1/0x2e0
[ 7565.309992]  [<c01f54f6>] journal_dirty_metadata+0x76/0x120
[ 7565.309992]  [<c01f3312>] __ext3_journal_dirty_metadata+0x22/0x60
[ 7565.309992]  [<c01f3f49>] journal_get_write_access+0x29/0x40
[ 7565.309992]  [<c01e6c14>] ext3_mark_iloc_dirty+0x174/0x330
[ 7565.309992]  [<c01e7187>] ext3_mark_inode_dirty+0x37/0x50
[ 7565.309992]  [<c01eefe4>] __ext3_journal_stop+0x24/0x50
[ 7565.309992]  [<c01bc400>] __mark_inode_dirty+0x30/0x1b0
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c029ab23>] number+0x2d3/0x2e0
[ 7565.309992]  [<c01e9372>] ext3_ordered_write_end+0xe2/0x140
[ 7565.309992]  [<c01b5825>] mnt_drop_write+0x95/0x180
[ 7565.309992]  [<c029b3b7>] vsnprintf+0x307/0x5e0
[ 7565.309992]  [<c01160b3>] kmap_atomic_prot+0x13/0xa0
[ 7565.309992]  [<c0116066>] kunmap_atomic+0x26/0x60
[ 7565.309992]  [<c017ac12>] get_page_from_freelist+0x312/0x590
[ 7565.309992]  [<c017ab5b>] get_page_from_freelist+0x25b/0x590
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c01345d2>] enqueue_hrtimer+0x72/0xf0
[ 7565.309992]  [<c0134df6>] hrtimer_start+0xd6/0x190
[ 7565.309992]  [<c0117160>] __dequeue_entity+0x50/0xc0
[ 7565.309992]  [<c0117e30>] hrtick_set+0xc0/0x1a0
[ 7565.309992]  [<c0195acc>] add_partial+0x4c/0xa0
[ 7565.309992]  [<c0197192>] __slab_free+0x72/0x340
[ 7565.309992]  [<c0185d00>] handle_mm_fault+0x3a0/0x670
[ 7565.309992]  [<c01a27de>] free_pipe_info+0xe/0x20
[ 7565.309992]  [<c01a27de>] free_pipe_info+0xe/0x20
[ 7565.309992]  [<c0197cbf>] kfree+0x8f/0x110
[ 7565.309992]  [<c01a27de>] free_pipe_info+0xe/0x20
[ 7565.309992]  [<c01a27de>] free_pipe_info+0xe/0x20
[ 7565.309992]  [<c01a288d>] pipe_release+0x7d/0xa0
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c0199ea7>] filp_close+0x47/0x80
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] proftpd       S f7c82b7c     0  2422      1
[ 7565.309992]        f7c82a20 00200086 006f461e f7c82b7c c0575380  
c0126991 00000200 f74e3b64
[ 7565.309992]        006f461e 00000000 00000000 c03c8a0a c013166d  
f74e3be4 c0575f70 c04b09d0
[ 7565.309992]        006f461e c01265f0 f7c82a20 c0575380 00000002  
00000002 c01a9b22 f74e3be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0126991>] __mod_timer+0xb1/0xf0
[ 7565.309992]  [<c03c8a0a>] schedule_timeout+0x4a/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c01265f0>] process_timeout+0x0/0x10
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c01088a6>] read_tsc+0x6/0x30
[ 7565.309992]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309992]  [<c015463f>] xntimer_start_aperiodic+0x10f/0x200
[ 7565.309992]  [<c01088a6>] read_tsc+0x6/0x30
[ 7565.309992]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309992]  [<c0134fe2>] ktime_get_ts+0x22/0x50
[ 7565.309992]  [<c013501d>] ktime_get+0xd/0x30
[ 7565.309992]  [<c0117063>] hrtick_start_fair+0xa3/0x150
[ 7565.309992]  [<c01bfe6a>] __find_get_block_slow+0x7a/0x130
[ 7565.309992]  [<c01088a6>] read_tsc+0x6/0x30
[ 7565.309992]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309992]  [<c01c0290>] __find_get_block+0x90/0x1c0
[ 7565.309992]  [<c01f367e>] __journal_file_buffer+0x6e/0x130
[ 7565.309992]  [<c01f3c86>] do_get_write_access+0x1e6/0x480
[ 7565.309992]  [<c01c03e2>] __getblk+0x22/0x220
[ 7565.309992]  [<c01f367e>] __journal_file_buffer+0x6e/0x130
[ 7565.309992]  [<c01f54f6>] journal_dirty_metadata+0x76/0x120
[ 7565.309992]  [<c01f3312>] __ext3_journal_dirty_metadata+0x22/0x60
[ 7565.309992]  [<c01f3f49>] journal_get_write_access+0x29/0x40
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01f3985>] journal_stop+0x135/0x250
[ 7565.309992]  [<c0147961>] __rcu_read_unlock+0x41/0x90
[ 7565.309992]  [<c01aea09>] __d_lookup+0xc9/0x160
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309992]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309992]  [<c029587a>] _atomic_dec_and_lock+0x3a/0x60
[ 7565.309992]  [<c01b4183>] mntput_no_expire+0x13/0x120
[ 7565.309992]  [<c01a606e>] path_walk+0x4e/0x90
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01a6e29>] __user_walk_fd+0x49/0x60
[ 7565.309992]  [<c019f6ef>] vfs_lstat_fd+0x1f/0x50
[ 7565.309992]  [<c01379cd>] getnstimeofday+0x3d/0xe0
[ 7565.309992]  [<c0134df6>] hrtimer_start+0xd6/0x190
[ 7565.309992]  [<c01aa382>] sys_select+0xe2/0x1b0
[ 7565.309992]  [<c0120fa0>] alarm_setitimer+0x30/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] cron          S f7f4b59c     0  2434      1
[ 7565.309992]        f7f4b440 00000082 01d7138e f7f4b59c 00000000  
00000200 00000000 f7fa5f60
[ 7565.309992]        f7f4b440 00000000 bfd44e04 c03c91bb 00000001  
00000000 00000001 c0134ef5
[ 7565.309992]        00000001 f7c3d740 f7659f60 fa1e6b8e 000006e2  
c0134a60 c047f254 00000001
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c91bb>] do_nanosleep+0x5b/0x90
[ 7565.309992]  [<c0134ef5>] hrtimer_nanosleep+0x45/0xb0
[ 7565.309992]  [<c0134a60>] hrtimer_wakeup+0x0/0x20
[ 7565.309992]  [<c0134fb8>] sys_nanosleep+0x58/0x60
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] xdm           S f7c824bc     0  2456      1
[ 7565.309992]        f7c82360 00000082 f794c000 f7c824bc f7fb8500  
c18de7a0 000fa016 00000005
[ 7565.309992]        00000010 00000000 00000000 c03c8a35 c0348524  
f799e900 f7444400 c0385d0f
[ 7565.309992]        00000000 c03f2060 00000010 f7444400 00000005  
00000010 c01a9b22 f7637be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0348524>] datagram_poll+0x14/0xf0
[ 7565.309992]  [<c0385d0f>] udp_poll+0xf/0x100
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0177fd2>] mempool_alloc+0x32/0x180
[ 7565.309992]  [<c01f54f6>] journal_dirty_metadata+0x76/0x120
[ 7565.309992]  [<c017dcdf>] activate_page+0x4f/0xe0
[ 7565.309992]  [<c01160b3>] kmap_atomic_prot+0x13/0xa0
[ 7565.309992]  [<c0116066>] kunmap_atomic+0x26/0x60
[ 7565.309992]  [<c017ac12>] get_page_from_freelist+0x312/0x590
[ 7565.309992]  [<c017af36>] __alloc_pages_internal+0xa6/0x450
[ 7565.309992]  [<c01c0290>] __find_get_block+0x90/0x1c0
[ 7565.309992]  [<c017e733>] lru_cache_add_active+0x43/0x80
[ 7565.309992]  [<c0185d93>] handle_mm_fault+0x433/0x670
[ 7565.309992]  [<c01f3c86>] do_get_write_access+0x1e6/0x480
[ 7565.309992]  [<c01c03e2>] __getblk+0x22/0x220
[ 7565.309992]  [<c01e6eb1>] __ext3_get_inode_loc+0xe1/0x2e0
[ 7565.309992]  [<c01f54f6>] journal_dirty_metadata+0x76/0x120
[ 7565.309992]  [<c01f3312>] __ext3_journal_dirty_metadata+0x22/0x60
[ 7565.309992]  [<c01f3f49>] journal_get_write_access+0x29/0x40
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c01f3985>] journal_stop+0x135/0x250
[ 7565.309992]  [<c01eefe4>] __ext3_journal_stop+0x24/0x50
[ 7565.309992]  [<c01bc48a>] __mark_inode_dirty+0xba/0x1b0
[ 7565.309992]  [<c017007b>] __sem_open+0x23b/0x310
[ 7565.309992]  [<c01160b3>] kmap_atomic_prot+0x13/0xa0
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c0177285>] generic_file_aio_read+0x5b5/0x620
[ 7565.309992]  [<c017a72a>] free_hot_cold_page+0x15a/0x1e0
[ 7565.309992]  [<c018455b>] unmap_vmas+0x2db/0x500
[ 7565.309992]  [<c01855f5>] free_pgtables+0x85/0xb0
[ 7565.309992]  [<c01986c2>] kmem_cache_free+0x42/0xd0
[ 7565.309992]  [<c0187c33>] unmap_region+0xe3/0x120
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] getty         S f7f9559c     0  2468      1
[ 7565.309992]        f7f95440 00000086 00000720 f7f9559c f7c2aa20  
c1816a40 00000042 f7c89b80
[ 7565.309992]        f762b400 7fffffff 7fffffff c03c8a35 00000000  
c02ab166 c0135cee 00000001
[ 7565.309992]        001ae60e c013166d f7c89b80 f762b400 f7c89b80  
f762b400 c02b6254 00000003
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c02ab166>] vgacon_set_cursor_size+0xd6/0x1a0
[ 7565.309992]  [<c0135cee>] up+0x5e/0xa0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c02b6254>] read_chan+0x1c4/0x6d0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02b2b83>] tty_read+0x83/0xb0
[ 7565.309992]  [<c02b6090>] read_chan+0x0/0x6d0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c02b2b00>] tty_read+0x0/0xb0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] getty         S f7f94b7c     0  2470      1
[ 7565.309992]        f7f94a20 00000086 00000000 f7f94b7c 00000000  
c17ec600 00000020 f7c89d80
[ 7565.309992]        f762ac00 7fffffff 7fffffff c03c8a35 f74d4c00  
00485898 c0135cee 00000008
[ 7565.309992]        0000446b c013166d f7c89d80 f762ac00 f7c89d80  
f762ac00 c02b6254 00000003
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0135cee>] up+0x5e/0xa0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c02b6254>] read_chan+0x1c4/0x6d0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02b2b83>] tty_read+0x83/0xb0
[ 7565.309992]  [<c02b6090>] read_chan+0x0/0x6d0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c02b2b00>] tty_read+0x0/0xb0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] getty         S f7cd081c     0  2472      1
[ 7565.309992]        f7cd06c0 00000082 00000000 f7cd081c 00000000  
c17ec600 00000020 f7f51580
[ 7565.309992]        f762b800 7fffffff 7fffffff c03c8a35 f76b2480  
00485898 c0135cee 00000008
[ 7565.309992]        0000446b c013166d f7f51580 f762b800 f7f51580  
f762b800 c02b6254 00000003
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0135cee>] up+0x5e/0xa0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c02b6254>] read_chan+0x1c4/0x6d0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02b2b83>] tty_read+0x83/0xb0
[ 7565.309992]  [<c02b6090>] read_chan+0x0/0x6d0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c02b2b00>] tty_read+0x0/0xb0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] getty         S f7f224bc     0  2474      1
[ 7565.309992]        f7f22360 00000082 00000000 f7f224bc 00000000  
c17ec600 00000020 f7c05a80
[ 7565.309992]        f762b000 7fffffff 7fffffff c03c8a35 f7f77a80  
00485898 c0135cee 00000008
[ 7565.309992]        0000446b c013166d f7c05a80 f762b000 f7c05a80  
f762b000 c02b6254 00000003
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0135cee>] up+0x5e/0xa0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c02b6254>] read_chan+0x1c4/0x6d0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02b2b83>] tty_read+0x83/0xb0
[ 7565.309992]  [<c02b6090>] read_chan+0x0/0x6d0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c02b2b00>] tty_read+0x0/0xb0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] getty         S f7f2281c     0  2475      1
[ 7565.309992]        f7f226c0 00000086 00000000 f7f2281c 00000000  
c17ec600 00000020 f7fc9e00
[ 7565.309992]        f762a800 7fffffff 7fffffff c03c8a35 f76b2000  
00485898 c0135cee 00000008
[ 7565.309992]        0000446b c013166d f7fc9e00 f762a800 f7fc9e00  
f762a800 c02b6254 00000003
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0135cee>] up+0x5e/0xa0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c02b6254>] read_chan+0x1c4/0x6d0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02b2b83>] tty_read+0x83/0xb0
[ 7565.309992]  [<c02b6090>] read_chan+0x0/0x6d0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c02b2b00>] tty_read+0x0/0xb0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] getty         S f7f22b7c     0  2476      1
[ 7565.309992]        f7f22a20 00000082 00000000 f7f22b7c 00000000  
c17ec600 00000020 f7c96080
[ 7565.309992]        f762a000 7fffffff 7fffffff c03c8a35 f7c56180  
00485898 c0135cee 00000008
[ 7565.309992]        0000446b c013166d f7c96080 f762a000 f7c96080  
f762a000 c02b6254 00000003
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0135cee>] up+0x5e/0xa0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c02b6254>] read_chan+0x1c4/0x6d0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02b2b83>] tty_read+0x83/0xb0
[ 7565.309992]  [<c02b6090>] read_chan+0x0/0x6d0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c02b2b00>] tty_read+0x0/0xb0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] sshd          S f7f4a15c     0  2499   2335
[ 7565.309992]        f7f4a000 00000086 00000000 f7f4a15c c048bb60  
00000000 f7f12c10 00000008
[ 7565.309992]        00000080 00000000 00000000 c03c8a35 f7500100  
f7f12c00 c02b4f20 c02b0836
[ 7565.309992]        f768fbe4 f7f12c10 00000007 00000080 00000008  
00000080 c01a9b22 f768fbe4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c02b4f20>] normal_poll+0x0/0x150
[ 7565.309992]  [<c02b0836>] tty_poll+0x76/0x80
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c034e10d>] dev_queue_xmit+0xcd/0x400
[ 7565.309992]  [<c0358eeb>] eth_header+0x2b/0xc0
[ 7565.309992]  [<c0352c55>] neigh_resolve_output+0xf5/0x270
[ 7565.309992]  [<c03695e9>] ip_finish_output+0x119/0x2c0
[ 7565.309992]  [<c0367ec5>] ip_local_out+0x15/0x20
[ 7565.309992]  [<c036a25e>] ip_queue_xmit+0x1ae/0x320
[ 7565.309992]  [<c0121d9a>] __do_softirq+0x6a/0xb0
[ 7565.309992]  [<c0121cc8>] _local_bh_enable+0x28/0x90
[ 7565.309992]  [<c037fa80>] tcp_v4_send_check+0x40/0xe0
[ 7565.309992]  [<c037a84f>] tcp_transmit_skb+0x3bf/0x7a0
[ 7565.309992]  [<c010f570>] smp_apic_timer_interrupt+0x0/0x70
[ 7565.309992]  [<c01267eb>] lock_timer_base+0x4b/0xb0
[ 7565.309992]  [<c0379fbc>] tcp_init_tso_segs+0x3c/0x60
[ 7565.309992]  [<c037bfb9>] __tcp_push_pending_frames+0x139/0x750
[ 7565.309992]  [<c036f705>] sk_stream_alloc_skb+0x35/0xe0
[ 7565.309992]  [<c0198dd8>] __kmalloc_track_caller+0x78/0x120
[ 7565.309992]  [<c0122076>] local_bh_enable+0x46/0x90
[ 7565.309992]  [<c0341b2b>] lock_sock_nested+0xfb/0x110
[ 7565.309992]  [<c0121c8a>] local_bh_disable+0xa/0x20
[ 7565.309992]  [<c0341a07>] release_sock+0xc7/0xf0
[ 7565.309992]  [<c0122076>] local_bh_enable+0x46/0x90
[ 7565.309992]  [<c0371082>] tcp_sendmsg+0x7a2/0xab0
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c033ea22>] sock_aio_write+0xe2/0x100
[ 7565.309992]  [<c01197b4>] try_to_wake_up+0x44/0xd0
[ 7565.309992]  [<c019ba56>] do_sync_write+0xc6/0x110
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c019c8e1>] sys_write+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] bash          S f7f4ab7c     0  2501   2499
[ 7565.309992]        f7f4aa20 00000082 f74d4ac4 f7f4ab7c f741f098  
c0185d00 c013166d ffffffea
[ 7565.309992]        f7f4aa18 0000000e 00000001 c011f60d f7e4fb00  
c02b36aa 00000000 00000001
[ 7565.309992]        00000000 f7f4ab10 00000000 00000003 0000000c  
f7f4aa20 00000001 f7541a00
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c0185d00>] handle_mm_fault+0x3a0/0x670
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c011f60d>] do_wait+0x63d/0xc80
[ 7565.309992]  [<c02b36aa>] tty_ioctl+0x98a/0xab0
[ 7565.309992]  [<c01a288d>] pipe_release+0x7d/0xa0
[ 7565.309992]  [<c02b2d20>] tty_ioctl+0x0/0xab0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c011fcc3>] sys_wait4+0x73/0xc0
[ 7565.309992]  [<c011fd35>] sys_waitpid+0x25/0x30
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] remoteHost    S f7e4fc5c     0  2507   2501
[ 7565.309992]        f7e4fb00 00000082 f7e4fb00 f7e4fc5c 00000000  
c017af36 c0485da0 f769ea80
[ 7565.309992]        00000000 7fffffff f769ec40 c03c8a35 c0122076  
c0341b2b c16fe1e0 00000001
[ 7565.309992]        c0121c8a c0341a07 f769ea80 f769ea80 f769ea80  
00000000 c036e10f 000000d0
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c017af36>] __alloc_pages_internal+0xa6/0x450
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c0122076>] local_bh_enable+0x46/0x90
[ 7565.309992]  [<c0341b2b>] lock_sock_nested+0xfb/0x110
[ 7565.309992]  [<c0121c8a>] local_bh_disable+0xa/0x20
[ 7565.309992]  [<c0341a07>] release_sock+0xc7/0xf0
[ 7565.309992]  [<c036e10f>] inet_csk_accept+0x12f/0x260
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c038ca4f>] inet_accept+0x1f/0xd0
[ 7565.309992]  [<c0340a30>] sys_accept+0xf0/0x210
[ 7565.309992]  [<c0134fe2>] ktime_get_ts+0x22/0x50
[ 7565.309992]  [<c0185d00>] handle_mm_fault+0x3a0/0x670
[ 7565.309992]  [<c0113bdf>] do_page_fault+0x29f/0x6d0
[ 7565.309992]  [<c0340c16>] sys_socketcall+0xc6/0x280
[ 7565.309992]  [<c0199ea7>] filp_close+0x47/0x80
[ 7565.309992]  [<c019b5e2>] sys_close+0x82/0xf0
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] sshd          S f7f22edc     0  9291   2335
[ 7565.309992]        f7f22d80 00000086 00000000 f7f22edc c048bb60  
00000000 f7f4d410 00000008
[ 7565.309992]        00000080 00000000 00000000 c03c8a35 f7f04800  
f7f4d400 c02b4f20 c02b0836
[ 7565.309992]        f7679be4 f7f4d410 00000007 00000080 00000008  
00000080 c01a9b22 f7679be4
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c02b4f20>] normal_poll+0x0/0x150
[ 7565.309992]  [<c02b0836>] tty_poll+0x76/0x80
[ 7565.309992]  [<c01a9b22>] do_select+0x3b2/0x490
[ 7565.309992]  [<c01aa1b0>] __pollwait+0x0/0xf0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c034e10d>] dev_queue_xmit+0xcd/0x400
[ 7565.309992]  [<c0358eeb>] eth_header+0x2b/0xc0
[ 7565.309992]  [<c0352c55>] neigh_resolve_output+0xf5/0x270
[ 7565.309992]  [<c0147961>] __rcu_read_unlock+0x41/0x90
[ 7565.309992]  [<c03695e9>] ip_finish_output+0x119/0x2c0
[ 7565.309992]  [<c0358eeb>] eth_header+0x2b/0xc0
[ 7565.309992]  [<c0367ec5>] ip_local_out+0x15/0x20
[ 7565.309992]  [<c036a25e>] ip_queue_xmit+0x1ae/0x320
[ 7565.309992]  [<c03695e9>] ip_finish_output+0x119/0x2c0
[ 7565.309992]  [<c037fa80>] tcp_v4_send_check+0x40/0xe0
[ 7565.309992]  [<c037a84f>] tcp_transmit_skb+0x3bf/0x7a0
[ 7565.309992]  [<c0121f3f>] irq_exit+0x5f/0x90
[ 7565.309992]  [<c010f5a0>] smp_apic_timer_interrupt+0x30/0x70
[ 7565.309992]  [<c01267eb>] lock_timer_base+0x4b/0xb0
[ 7565.309992]  [<c0379fbc>] tcp_init_tso_segs+0x3c/0x60
[ 7565.309992]  [<c037bfb9>] __tcp_push_pending_frames+0x139/0x750
[ 7565.309992]  [<c0117063>] hrtick_start_fair+0xa3/0x150
[ 7565.309992]  [<c036f705>] sk_stream_alloc_skb+0x35/0xe0
[ 7565.309992]  [<c0198dd8>] __kmalloc_track_caller+0x78/0x120
[ 7565.309992]  [<c01267eb>] lock_timer_base+0x4b/0xb0
[ 7565.309992]  [<c0121c8a>] local_bh_disable+0xa/0x20
[ 7565.309992]  [<c0341a07>] release_sock+0xc7/0xf0
[ 7565.309992]  [<c0122076>] local_bh_enable+0x46/0x90
[ 7565.309992]  [<c0371082>] tcp_sendmsg+0x7a2/0xab0
[ 7565.309992]  [<c01a9e08>] core_sys_select+0x208/0x340
[ 7565.309992]  [<c0117063>] hrtick_start_fair+0xa3/0x150
[ 7565.309992]  [<c033ea22>] sock_aio_write+0xe2/0x100
[ 7565.309992]  [<c01197b4>] try_to_wake_up+0x44/0xd0
[ 7565.309992]  [<c011688e>] __wake_up_common+0x3e/0x70
[ 7565.309992]  [<c019ba56>] do_sync_write+0xc6/0x110
[ 7565.309992]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309992]  [<c01aa2ed>] sys_select+0x4d/0x1b0
[ 7565.309992]  [<c019c8e1>] sys_write+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] bash          S f7f238fc     0  9293   9291
[ 7565.309992]        f7f237a0 00000086 c013501d f7f238fc 09e6bb40  
00989680 c0117063 f7f04580
[ 7565.309992]        f7f4c000 7fffffff 7fffffff c03c8a35 00000200  
f7f237a0 f7f0e900 f7f0e900
[ 7565.309992]        f7f237a0 c013166d f7f04580 f7f4c000 f7f04580  
f7f4c000 c02b6254 00000003
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c013501d>] ktime_get+0xd/0x30
[ 7565.309992]  [<c0117063>] hrtick_start_fair+0xa3/0x150
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c02b6254>] read_chan+0x1c4/0x6d0
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c02b2b83>] tty_read+0x83/0xb0
[ 7565.309992]  [<c02b6090>] read_chan+0x0/0x6d0
[ 7565.309992]  [<c019c411>] vfs_read+0xa1/0x130
[ 7565.309992]  [<c02b2b00>] tty_read+0x0/0xb0
[ 7565.309992]  [<c019c871>] sys_read+0x41/0x70
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] remoteHost    S f7c8281c     0 11799   2507
[ 7565.309992]        f7c826c0 00000086 00000200 f7c8281c c04f4300  
031703f8 c013166d f7592e84
[ 7565.309992]        f7c826b8 00000004 00000001 c011f60d f7592d80  
f7c826c0 f7c56300 00000000
[ 7565.309992]        00000000 f7c827b0 f74b6c80 00000000 00000000  
f7c826c0 00000001 f7592d80
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309992]  [<c011f60d>] do_wait+0x63d/0xc80
[ 7565.309992]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309992]  [<c011fcc3>] sys_wait4+0x73/0xc0
[ 7565.309992]  [<c011fd35>] sys_waitpid+0x25/0x30
[ 7565.309992]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309992]  =======================
[ 7565.309992] remoteHost    S f7c83c5c     0 11800   2507
[ 7565.309992]        f7c83b00 00000082 c03797ed f7c83c5c 00000200  
00000000 00000000 f7653d7c
[ 7565.309992]        f75a4880 f75a48e0 f75a4b14 c03c8a35 f74f4620  
c0341b2b 00000000 f74f4600
[ 7565.309992]        c0121c8a c0341a07 f7653d7c f7653d7c f7653d7c  
f75a4880 c0342564 00000000
[ 7565.309992] Call Trace:
[ 7565.309992]  [<c03797ed>] tcp_rcv_established+0x3ed/0x6d0
[ 7565.309992]  [<c03c8a35>] schedule_timeout+0x75/0xc0
[ 7565.309993]  [<c0341b2b>] lock_sock_nested+0xfb/0x110
[ 7565.309993]  [<c0121c8a>] local_bh_disable+0xa/0x20
[ 7565.309993]  [<c0341a07>] release_sock+0xc7/0xf0
[ 7565.309993]  [<c0342564>] sk_wait_data+0x84/0xd0
[ 7565.309993]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309993]  [<c037173f>] tcp_recvmsg+0x3af/0x8a0
[ 7565.309993]  [<c0134fe2>] ktime_get_ts+0x22/0x50
[ 7565.309993]  [<c0117063>] hrtick_start_fair+0xa3/0x150
[ 7565.309993]  [<c0341425>] sock_common_recvmsg+0x45/0x70
[ 7565.309993]  [<c033f6c7>] sock_recvmsg+0xd7/0x110
[ 7565.309993]  [<c02b5324>] n_tty_receive_buf+0x2b4/0x1020
[ 7565.309993]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309993]  [<c02b51c5>] n_tty_receive_buf+0x155/0x1020
[ 7565.309993]  [<c0113bdf>] do_page_fault+0x29f/0x6d0
[ 7565.309993]  [<c01345d2>] enqueue_hrtimer+0x72/0xf0
[ 7565.309993]  [<c033ef82>] sockfd_lookup_light+0x32/0x60
[ 7565.309993]  [<c03406ce>] sys_recvfrom+0xce/0x160
[ 7565.309993]  [<c0117e30>] hrtick_set+0xc0/0x1a0
[ 7565.309993]  [<c0119a1b>] hrtick_resched+0x4b/0x60
[ 7565.309993]  [<c010260f>] do_notify_resume+0x6f/0x790
[ 7565.309993]  [<c02aedba>] tty_put_char+0x2a/0x40
[ 7565.309993]  [<c03ca20a>] rwsem_down_write_failed+0x2a/0x30
[ 7565.309993]  [<c0119aaf>] __wake_up+0x7f/0xd0
[ 7565.309993]  [<c0340793>] sys_recv+0x33/0x40
[ 7565.309993]  [<c0340cb5>] sys_socketcall+0x165/0x280
[ 7565.309993]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309993]  =======================
[ 7565.309993] rt61pci       S f7f4a81c     0 15243      2
[ 7565.309993]        f7f4a6c0 00000046 c012d8c0 f7f4a81c c04762e0  
c01315a5 00000200 f7644b40
[ 7565.309993]        f7644b48 00000000 00000000 c012e1bd 00000000  
f7f4a6c0 c01312c0 f7644b48
[ 7565.309993]        f7644b48 fffffffc f7644b40 c012e130 c0130f32  
c0130ef0 00000000 00000000
[ 7565.309993] Call Trace:
[ 7565.309993]  [<c012d8c0>] run_workqueue+0x120/0x1b0
[ 7565.309993]  [<c01315a5>] prepare_to_wait+0x85/0xe0
[ 7565.309993]  [<c012e1bd>] worker_thread+0x8d/0xa0
[ 7565.309993]  [<c01312c0>] autoremove_wake_function+0x0/0x50
[ 7565.309993]  [<c012e130>] worker_thread+0x0/0xa0
[ 7565.309993]  [<c0130f32>] kthread+0x42/0x70
[ 7565.309993]  [<c0130ef0>] kthread+0x0/0x70
[ 7565.309993]  [<c0103db3>] kernel_thread_helper+0x7/0x14
[ 7565.309993]  =======================
[ 7565.309993] actuatorTask  ? f759281c     0 15816      1
[ 7565.309993]        f75926c0 00000046 400000c0 f759281c f75926c0  
00000000 00003dc8 00000010
[ 7565.309993]        f75926c0 f75b1edc 00000000 c01202bc c0155590  
c04844a4 00000246 00000001
[ 7565.309993]        f75b1f90 f759276c f75927b0 00000000 00000000  
f75b1f90 f75b1f90 f7fdbe00
[ 7565.309993] Call Trace:
[ 7565.309993]  [<c01202bc>] do_exit+0x4bc/0x730
[ 7565.309993]  [<c0155590>] sigwake_event+0x0/0x140
[ 7565.309993]  [<c012055f>] do_group_exit+0x2f/0xc0
[ 7565.309993]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309993]  =======================
[ 7565.309993] Actuator Aper S f7592b7c     0 15817      1
[ 7565.309993]        f7592a20 00000086 00000001 f7592b7c 00000001  
00000000 00000200 f7e60620
[ 7565.309993]        f7592a20 f7729fb8 00000170 c01560ad 00000010  
f7729f5c 00000001 00000006
[ 7565.309993]        00000000 f7729fb8 00000170 c015628f 00000001  
c0577b04 c0577b00 00000000
[ 7565.309993] Call Trace:
[ 7565.309993]  [<c01560ad>] xnshadow_harden+0x8d/0x1e0
[ 7565.309993]  [<c015628f>] losyscall_event+0x8f/0x170
[ 7565.309993]  [<c014a1e2>] __ipipe_dispatch_event+0xa2/0x190
[ 7565.309993]  [<c0156200>] losyscall_event+0x0/0x170
[ 7565.309993]  [<c0112731>] __ipipe_syscall_root+0x41/0x100
[ 7565.309993]  [<c010311d>] system_call+0x29/0x4a
[ 7565.309993]  =======================
[ 7565.309993] sh            S f7592edc     0 15832  11799
[ 7565.309993]        f7592d80 00000086 f7c56944 f7592edc f7f36080  
c0185d00 c013166d ffffffea
[ 7565.309993]        f7592d78 00000004 00000001 c011f60d f7593b00  
f7c56900 f7c56300 00000001
[ 7565.309993]        00000000 f7592e70 00000000 00000003 0000000c  
f7592d80 00000001 f7593b00
[ 7565.309993] Call Trace:
[ 7565.309993]  [<c0185d00>] handle_mm_fault+0x3a0/0x670
[ 7565.309993]  [<c013166d>] add_wait_queue+0x6d/0xb0
[ 7565.309993]  [<c011f60d>] do_wait+0x63d/0xc80
[ 7565.309993]  [<c0119840>] default_wake_function+0x0/0x10
[ 7565.309993]  [<c011fcc3>] sys_wait4+0x73/0xc0
[ 7565.309993]  [<c011fd35>] sys_waitpid+0x25/0x30
[ 7565.309993]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309993]  =======================
[ 7565.309993] sleep         S f7593c5c     0 16596  15832
[ 7565.309993]        f7593b00 00000086 4b3f0cce f7593c5c 00000000  
00000200 00000000 f7659f60
[ 7565.309993]        f7593b00 00000001 00000000 c03c91bb 00000001  
00000000 00000001 c0134ef5
[ 7565.309993]        f7fa5f61 f754c740 c0576960 86d9d6ce 000006e1  
c0134a60 c047f254 00000001
[ 7565.309993] Call Trace:
[ 7565.309993]  [<c03c91bb>] do_nanosleep+0x5b/0x90
[ 7565.309993]  [<c0134ef5>] hrtimer_nanosleep+0x45/0xb0
[ 7565.309993]  [<c0134a60>] hrtimer_wakeup+0x0/0x20
[ 7565.309993]  [<c0134fb8>] sys_nanosleep+0x58/0x60
[ 7565.309993]  [<c0103145>] syscall_call+0x7/0xb
[ 7565.309993]  =======================


On Nov 28, 2008, at 7:11 PM, Gilles Chanteperdrix wrote:

> Mehmet Alphan Ulusoy wrote:
>> ps aux says Task's state is "Zl+" and it's there for over 6 hours  
>> now,
>> is init's mentioned behavior standard or somewhat optional?
>>
>> If it's standard, then does this mean that there's something else  
>> going on?
>
> If you are able to reproduce this issue with a simple program, could  
> you
> send it to us?
>
> -- 
>                                                 Gilles.
>


--Apple-Mail-22-324902210
Content-Type: text/html;
	charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div><font =
class=3D"Apple-style-span" face=3D"Consolas">Hello =
again,</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">Unfortunately I couldn't solve this issue of 'tasks =
turning into zombies after being killed' on my own. Below you may find =
the sysRq + T output. The name of the problematic task is: =
&nbsp;"actuatorTask". This is a bit hard to reproduce since it does not =
happen all the time, i hope below output helps.</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas"><br></font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">Also /proc/xenomai/stat =
says:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></div><div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">CPU &nbsp;PID &nbsp; =
&nbsp;MSW &nbsp; &nbsp; &nbsp; &nbsp;CSW &nbsp; &nbsp; &nbsp; &nbsp;PF =
&nbsp; &nbsp;STAT &nbsp; &nbsp; &nbsp; %CPU =
&nbsp;NAME</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">&nbsp;&nbsp;0 &nbsp;0 &nbsp; &nbsp; &nbsp;0 &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;942268 &nbsp; &nbsp; 0 &nbsp; &nbsp; 00500080 =
&nbsp; 99.9 &nbsp;ROOT</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">&nbsp;&nbsp;0 &nbsp;15817 &nbsp;2899 &nbsp; &nbsp; =
&nbsp; 2906 &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; 00300380 &nbsp; =
&nbsp;0.0 &nbsp;Actuator Aperiodic Task</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">&nbsp;&nbsp;0 &nbsp;0 =
&nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2275392 &nbsp; =
&nbsp;0 &nbsp; &nbsp; 00000000 &nbsp; &nbsp;0.0 &nbsp;IRQ233: =
[timer]</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">and /proc/xenomai/sched says:</font></div><div><font =
class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></div><div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">CPU &nbsp;PID &nbsp; =
&nbsp;PRI &nbsp; &nbsp; &nbsp;PERIOD &nbsp; &nbsp; TIMEOUT &nbsp; =
&nbsp;TIMEBASE &nbsp;STAT &nbsp; &nbsp; &nbsp; =
NAME</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">&nbsp;&nbsp;0 &nbsp;0 &nbsp; &nbsp; &nbsp; 80 &nbsp; =
&nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;master &nbsp; &nbsp;R &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;ROOT</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">&nbsp;&nbsp;0 &nbsp;15817 &nbsp; 80 &nbsp; &nbsp; =
&nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;master &nbsp; &nbsp;X &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Actuator =
Aperiodic Task</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></div></div></div><div><div><font =
class=3D"Apple-style-span" face=3D"Consolas"><br></font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] SysRq : Show =
State</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309991] &nbsp; task &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;PC stack &nbsp; pid =
father</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309991] init &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;S f7c2a15c &nbsp; &nbsp; 0 &nbsp; &nbsp; 1 &nbsp; &nbsp; =
&nbsp;0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309991] &nbsp; &nbsp; &nbsp; &nbsp;f7c2a000 =
00000086 006eec77 f7c2a15c c0575380 c0126991 00000200 =
f7c2db64&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309991] &nbsp; &nbsp; &nbsp; &nbsp;006eec77 =
00000000 00000000 c03c8a0a c013166d f7c2dbe4 c0575ce8 =
c0575ce8&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309991] &nbsp; &nbsp; &nbsp; &nbsp;006eec77 =
c01265f0 f7c2a000 c0575380 0000000b 00000400 c01a9b22 =
f7c2dbe4&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309991] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0126991>] __mod_timer+0xb1/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c03c8a0a>] schedule_timeout+0x4a/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01265f0>] process_timeout+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01088a6>] read_tsc+0x6/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0139989>] =
clocksource_get_next+0x59/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0137d69>] =
update_wall_time+0x259/0x7d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0139989>] =
clocksource_get_next+0x59/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0137d69>] =
update_wall_time+0x259/0x7d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0137d69>] =
update_wall_time+0x259/0x7d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01088a6>] read_tsc+0x6/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01088a6>] read_tsc+0x6/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c015463f>] =
xntimer_start_aperiodic+0x10f/0x200</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c029ab23>] number+0x2d3/0x2e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0313538>] =
usb_choose_configuration+0x198/0x220</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01354cb>] =
hrtimer_interrupt+0x19b/0x1e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c029b3b7>] vsnprintf+0x307/0x5e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c014978f>] __xirq_end+0x0/0x46</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0139989>] =
clocksource_get_next+0x59/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0137d69>] =
update_wall_time+0x259/0x7d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0137d69>] =
update_wall_time+0x259/0x7d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0147961>] __rcu_read_unlock+0x41/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01aea09>] __d_lookup+0xc9/0x160</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01a397a>] permission+0x6a/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0197794>] __slab_alloc+0x74/0x510</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01b4183>] mntput_no_expire+0x13/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01a606e>] path_walk+0x4e/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c029c6c5>] copy_to_user+0x35/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c019f488>] cp_new_stat64+0xf8/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c01aa382>] sys_select+0xe2/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309991] kthreadd &nbsp; &nbsp; &nbsp;S f7c2a4bc &nbsp; &nbsp; 0 =
&nbsp; &nbsp; 2 &nbsp; &nbsp; &nbsp;0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c2a360 00000046 f7c2a4c0 f7c2a4bc 00000000 =
c0119c46 f766fde8 c047f1f0&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] &nbsp; =
&nbsp; &nbsp; &nbsp;00003dba f766fdc4 00000000 c0131105 00000000 =
c0130f60 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 c0103db3 00000000 00000000 00000000 =
00000000 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309991] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309991] &nbsp;[&lt;c0119c46>] =
complete+0x76/0xb0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0131105>] =
kthreadd+0x1a5/0x1d0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0130f60>] =
kthreadd+0x0/0x1d0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] ksoftirqd/0 &nbsp; S f7c2a81c &nbsp; &nbsp; 0 &nbsp; &nbsp; =
3 &nbsp; &nbsp; &nbsp;2</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7c2a6c0 =
00000046 c0575180 f7c2a81c c0121d9a 00000000 00000000 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;00000000 =
c0122120 00000000 c0122219 fffffffc c0130f32 c0130ef0 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;00000000 =
c0103db3 f7c2df20 00000000 00000000 00000000 00000000 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121d9a>] __do_softirq+0x6a/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0122120>] ksoftirqd+0x0/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0122219>] ksoftirqd+0xf9/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] events/0 &nbsp; &nbsp; &nbsp;R running &nbsp; &nbsp; =
&nbsp;0 &nbsp; &nbsp; 4 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c2aa20 00000046 c012d8c0 f7c2ab7c c04762e0 =
c01315a5 00000200 f7c08100&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c08108 00000000 00000000 c012e1bd 00000000 =
f7c2aa20 c01312c0 f7c37fc0&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c37fc0 fffffffc f7c08100 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c012d8c0>] =
run_workqueue+0x120/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01315a5>] prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] khelper &nbsp; &nbsp; &nbsp; S f7c2aedc &nbsp; &nbsp; 0 =
&nbsp; &nbsp; 5 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c2ad80 00000046 c012d8c0 f7c2aedc f7f22d80 =
c01315a5 00000200 f7c08180&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c08188 00000000 00000000 c012e1bd 00000000 =
f7c2ad80 c01312c0 f7c08188&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c08188 fffffffc f7c08180 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c012d8c0>] =
run_workqueue+0x120/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01315a5>] prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] kblockd/0 &nbsp; &nbsp; S f7c8323c &nbsp; &nbsp; 0 &nbsp; =
&nbsp;52 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c830e0 00000046 c012d8c0 f7c8323c c04762e0 =
c01315a5 00000200 f7c19b80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c19b88 00000000 00000000 c012e1bd 00000000 =
f7c830e0 c01312c0 f7c19b88&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c19b88 fffffffc f7c19b80 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c012d8c0>] =
run_workqueue+0x120/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01315a5>] prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] khubd &nbsp; &nbsp; &nbsp; &nbsp; S f7cd123c &nbsp; &nbsp; =
0 &nbsp; &nbsp;61 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7cd10e0 00000046 000003e8 f7cd123c f7c9ad9c =
c01315a5 00000200 f7cddfa4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c9ad80 00000000 00000003 c0306cb4 f7cddfbc =
00000000 f7cd1108 0cb15b1c&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 00000239 f75e7d04 f7eeb21c f75e7c00 =
f7c9f01c 00000000 00000002&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0306cb4>] hub_thread+0x674/0xd10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117dfe>] hrtick_set+0x8e/0x1a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0306640>] hub_thread+0x0/0xd10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] kseriod &nbsp; &nbsp; &nbsp; S f7cd1c5c &nbsp; &nbsp; 0 =
&nbsp; &nbsp;64 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7cd1b00 00000046 c0197c85 f7cd1c5c 00000000 =
c01315a5 00000200 f7ce3fb0&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 00000000 00000200 c0322a7f c0476160 =
00000000 f7cd1b00 c03c8219&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 f7cd1b00 c01312c0 c04ae2d8 c04ae2d8 =
fffffffc 00000000 c0322970&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0197c85>] =
kfree+0x55/0x110</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0322a7f>] serio_thread+0x10f/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8219>] schedule+0x219/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0322970>] serio_thread+0x0/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] gatekeeper/0 &nbsp;S f7e4e4bc &nbsp; &nbsp; 0 &nbsp; 148 =
&nbsp; &nbsp; &nbsp;2</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7e4e360 =
00000046 00000000 f7e4e4bc c057c540 c0577b00 c0581a2c =
f7e61a20&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;c0581a20 =
c0581a2c 00000000 c0156a77 00000000 f7e4e360 c03c8219 =
00000001&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7e4e360 =
c0119840 c0581a24 c0581a24 fffffffc c0581a20 c01569d0 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0156a77>] =
gatekeeper_thread+0xa7/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8219>] schedule+0x219/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01569d0>] gatekeeper_thread+0x0/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] pdflush &nbsp; &nbsp; &nbsp; S f7e4f23c &nbsp; &nbsp; 0 =
&nbsp; 152 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7e4f0e0 00000046 f7e4f0e0 f7e4f23c c03c85be =
c0119684 00000200 f7e5dfc4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 c017d200 00000000 c017d2d4 f7e4f23c =
f7e4f0e0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;c0485e54 f7e5ffc4 fffb6d17 fffffffc c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c85be>] =
preempt_schedule+0x4e/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119684>] set_user_nice+0x114/0x170</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017d200>] pdflush+0x0/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017d2d4>] pdflush+0xd4/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] pdflush &nbsp; &nbsp; &nbsp; S f7e4f59c &nbsp; &nbsp; 0 =
&nbsp; 153 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7e4f440 00000046 00000000 f7e4f59c 00000000 =
00000000 00000025 f7e5ffc4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 c017d200 00000000 c017d2d4 f7e4f59c =
f7e4f440 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7e5dfc4 c0485e54 006edb25 fffffffc c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c017d200>] =
pdflush+0x0/0x270</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c017d2d4>] =
pdflush+0xd4/0x270</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0130f32>] =
kthread+0x42/0x70</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0130ef0>] =
kthread+0x0/0x70</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] kswapd0 &nbsp; &nbsp; &nbsp; S f7e4f8fc &nbsp; &nbsp; 0 =
&nbsp; 154 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7e4f7a0 00000046 00000000 f7e4f8fc 00000000 =
c01315a5 00000200 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;c0485340 c01312c0 00000000 c018119b 00000000 =
00000000 f7eb9f74 f7e4f7c8&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;c0485de8 00000000 00000203 c0116ebb f7e4f7a0 =
c0117160 c0180de0 f7e4f7c8&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c018119b>] kswapd+0x3bb/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0116ebb>] update_curr+0x6b/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117160>] __dequeue_entity+0x50/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0180de0>] kswapd+0x0/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011796b>] =
dequeue_task_fair+0x2b/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117dfe>] hrtick_set+0x8e/0x1a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119c46>] complete+0x76/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0180de0>] kswapd+0x0/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] aio/0 &nbsp; &nbsp; &nbsp; &nbsp; S f7f4b23c &nbsp; &nbsp; =
0 &nbsp; 197 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4b0e0 00000046 c04f4338 f7f4b23c 00000000 =
c01315a5 00000200 f7c19a80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c19a88 00000000 00000000 c012e1bd 00000000 =
f7f4b0e0 c01312c0 f7c19a88&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c19a88 fffffffc f7c19a80 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] unionfs_siod/ S f7f9415c &nbsp; &nbsp; 0 &nbsp; 210 &nbsp; =
&nbsp; &nbsp;2</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7f94000 =
00000046 c04f4338 f7f9415c 00000000 c01315a5 00000200 =
f7c190c0&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7c190c8 =
00000000 00000000 c012e1bd 00000000 f7f94000 c01312c0 =
f7c190c8&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7c190c8 =
fffffffc f7c190c0 c012e130 c0130f32 c0130ef0 00000000 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01315a5>] prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] nfsiod &nbsp; &nbsp; &nbsp; &nbsp;S f7f944bc &nbsp; &nbsp; =
0 &nbsp; 211 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f94360 00000046 c04f4338 f7f944bc 00000000 =
c01315a5 00000200 f7c08a80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c08a88 00000000 00000000 c012e1bd 00000000 =
f7f94360 c01312c0 f7c08a88&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c08a88 fffffffc f7c08a80 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] scsi_eh_0 &nbsp; &nbsp; S f7c82edc &nbsp; &nbsp; 0 &nbsp; =
874 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c82d80 00000046 c047f254 f7c82edc f7c82d80 =
c0117160 00000000 fffffffc&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7caa000 00000000 f7cb5fbc c02f4c7a 00000000 =
c0117e30 00000000 ffffffff&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;ffffffff 00000200 f7c82d80 c0476160 00000000 =
f7c82d80 c03c8219 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0117160>] =
__dequeue_entity+0x50/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02f4c7a>] =
scsi_error_handler+0x4a/0x3b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117e30>] hrtick_set+0xc0/0x1a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8219>] schedule+0x219/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119c46>] complete+0x76/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02f4c30>] =
scsi_error_handler+0x0/0x3b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] usb-storage &nbsp; S f7c838fc &nbsp; &nbsp; 0 &nbsp; 875 =
&nbsp; &nbsp; &nbsp;2</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7c837a0 =
00000046 c04f4300 f7c838fc c0134fe2 00000000 00000000 =
f7c837a0&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;7fffffff =
00040000 00000000 c03c8a35 0000049b 00000000 00989680 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;c0116e40 =
f7c2a6e8 f7c2a6c0 f7c837a0 f7c837a0 7fffffff c03c94a9 =
f7caa39c&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0134fe2>] ktime_get_ts+0x22/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8a35>] schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0116e40>] =
wakeup_preempt_entity+0x70/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c94a9>] =
__down_interruptible+0x69/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0135f97>] =
down_interruptible+0x87/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0320c80>] =
usb_stor_control_thread+0x60/0x240</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8219>] schedule+0x219/0x430</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119c46>] complete+0x76/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0320c20>] =
usb_stor_control_thread+0x0/0x240</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] kpsmoused &nbsp; &nbsp; S f7cd04bc &nbsp; &nbsp; 0 &nbsp; =
887 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7cd0360 00000046 00000000 f7cd04bc ffffffff =
c01315a5 00000200 f7c9b880&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c9b888 00000000 00000000 c012e1bd 00000000 =
f7cd0360 c01312c0 f7c9b888&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c9b888 fffffffc f7c9b880 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] rpciod/0 &nbsp; &nbsp; &nbsp;S f7cd18fc &nbsp; &nbsp; 0 =
&nbsp; 898 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7cd17a0 00000046 00000000 f7cd18fc ffffffff =
c01315a5 00000200 f7c9b6c0&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c9b6c8 00000000 00000000 c012e1bd 00000000 =
f7cd17a0 c01312c0 f7c9b6c8&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c9b6c8 fffffffc f7c9b6c0 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] kjournald &nbsp; &nbsp; S f7e4e81c &nbsp; &nbsp; 0 &nbsp; =
902 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7e4e6c0 00000046 c0119aaf f7e4e81c 00000000 =
c01315a5 00000200 f7fb8500&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 f7fb85c4 f7fb8540 c01f9da5 00000000 =
00000005 f7fb8550 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7e4e6c0 c01312c0 f7fb8550 f7fb8550 fffffffc =
f7fb8500 c01f9b80 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0119aaf>] =
__wake_up+0x7f/0xd0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f9da5>] kjournald+0x225/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f9b80>] kjournald+0x0/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] udevd &nbsp; &nbsp; &nbsp; &nbsp; S f7c2b23c &nbsp; &nbsp; =
0 &nbsp;1004 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c2b0e0 00000082 808fe474 f7c2b23c f7f94d80 =
f7f4fb3c c013166d 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000080 00000000 00000000 c03c8a35 c013166d =
c013166d f7f4fbe4 c03c8d50&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7461060 00000041 c01ca515 00000007 00000008 =
00000080 c01a9b22 f7f4fbe4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c013166d>] =
add_wait_queue+0x6d/0xb0</font></div><div><font class=3D"Apple-style-span"=
 face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8d50>] mutex_lock+0x10/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01ca515>] inotify_poll+0x45/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ab5b>] =
get_page_from_freelist+0x25b/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029ab23>] number+0x2d3/0x2e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017c5b9>] =
balance_dirty_pages_ratelimited_nr+0x59/0x2c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01160b3>] kmap_atomic_prot+0x13/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0116066>] kunmap_atomic+0x26/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019304f>] shmem_getpage+0x4ef/0x960</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0183803>] do_wp_page+0x1f3/0x4c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ba76>] set_page_dirty+0x46/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029b3b7>] vsnprintf+0x307/0x5e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0113bdf>] do_page_fault+0x29f/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01128d7>] =
__ipipe_handle_exception+0xe7/0x1e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aea09>] __d_lookup+0xc9/0x160</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aea09>] __d_lookup+0xc9/0x160</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01ae2ad>] dput+0x7d/0x190</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a3c9b>] __follow_mount+0x1b/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a3e45>] do_lookup+0x65/0x1a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0195030>] shmem_permission+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a397a>] permission+0x6a/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a5237>] __link_path_walk+0x67/0xe50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0147961>] __rcu_read_unlock+0x41/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8d50>] mutex_lock+0x10/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0147961>] __rcu_read_unlock+0x41/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aea09>] __d_lookup+0xc9/0x160</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01317d0>] remove_wait_queue+0x70/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011f38c>] do_wait+0x3bc/0xc80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a69e9>] do_rmdir+0xb9/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] kjournald &nbsp; &nbsp; S f7f4a4bc &nbsp; &nbsp; 0 =
&nbsp;2073 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4a360 00000046 c0119aaf f7f4a4bc 00000000 =
c01315a5 00000200 f745a400&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 f745a4c4 f745a440 c01f9da5 00000000 =
00000005 f745a450 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4a360 c01312c0 f745a450 f745a450 fffffffc =
f745a400 c01f9b80 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0119aaf>] =
__wake_up+0x7f/0xd0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f9da5>] kjournald+0x225/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f9b80>] kjournald+0x0/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] kjournald &nbsp; &nbsp; S f7f9481c &nbsp; &nbsp; 0 =
&nbsp;2080 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f946c0 00000046 c0119aaf f7f9481c 00000000 =
c01315a5 00000200 f745a200&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 f745a2c4 f745a240 c01f9da5 00000000 =
00000005 f745a250 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f946c0 c01312c0 f745a250 f745a250 fffffffc =
f745a200 c01f9b80 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0119aaf>] =
__wake_up+0x7f/0xd0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f9da5>] kjournald+0x225/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f9b80>] kjournald+0x0/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] dhclient3 &nbsp; &nbsp; S f7c2b8fc &nbsp; &nbsp; 0 =
&nbsp;2153 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c2b7a0 00000086 0071a227 f7c2b8fc c0575380 =
c0126991 00000200 f7633b64&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;0071a227 00000000 00000000 c03c8a0a c013166d =
f74a3a00 c0575db8 c0575db8&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;0071a227 c01265f0 f7c2b7a0 c0575380 00000006 =
00000020 c01a9b22 f7633be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0126991>] =
__mod_timer+0xb1/0xf0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a0a>] =
schedule_timeout+0x4a/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01265f0>] process_timeout+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3c86>] =
do_get_write_access+0x1e6/0x480</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01c03e2>] __getblk+0x22/0x220</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e6eb1>] =
__ext3_get_inode_loc+0xe1/0x2e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f54f6>] =
journal_dirty_metadata+0x76/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3312>] =
__ext3_journal_dirty_metadata+0x22/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3f49>] =
journal_get_write_access+0x29/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ab5b>] =
get_page_from_freelist+0x25b/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01088a6>] read_tsc+0x6/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0196f6e>] deactivate_slab+0x5e/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0197794>] __slab_alloc+0x74/0x510</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117063>] =
hrtick_start_fair+0xa3/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0139989>] =
clocksource_get_next+0x59/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0137d69>] =
update_wall_time+0x259/0x7d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0198dd8>] =
__kmalloc_track_caller+0x78/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341e48>] =
sock_alloc_send_skb+0x168/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011941d>] task_rq_lock+0x2d/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029ab23>] number+0x2d3/0x2e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c015463f>] =
xntimer_start_aperiodic+0x10f/0x200</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029b3b7>] vsnprintf+0x307/0x5e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121d9a>] __do_softirq+0x6a/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121cc8>] _local_bh_enable+0x28/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121e45>] do_softirq+0x65/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121f3f>] irq_exit+0x5f/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c010f5a0>] =
smp_apic_timer_interrupt+0x30/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01160b3>] kmap_atomic_prot+0x13/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c010318c>] =
restore_nocheck_notrace+0x0/0xe</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c010f570>] =
smp_apic_timer_interrupt+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c014978f>] __xirq_end+0x0/0x46</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0147961>] __rcu_read_unlock+0x41/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aea09>] __d_lookup+0xc9/0x160</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01345d2>] enqueue_hrtimer+0x72/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0183803>] do_wp_page+0x1f3/0x4c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0185d00>] handle_mm_fault+0x3a0/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0113bdf>] do_page_fault+0x29f/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa382>] sys_select+0xe2/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029c6c5>] copy_to_user+0x35/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] syslogd &nbsp; &nbsp; &nbsp; S f7f95c5c &nbsp; &nbsp; 0 =
&nbsp;2294 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f95b00 00000086 c01e6c14 f7f95c5c f7f957a0 =
c01f54f6 c013166d 00000001&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000001 00000000 00000000 c03c8a35 00000001 =
f7437be4 f7ee8000 011a92de&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;c03f2be0 00000001 f7ee8000 00000000 00000001 =
00000001 c01a9b22 f7437be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01e6c14>] =
ext3_mark_iloc_dirty+0x174/0x330</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f54f6>] =
journal_dirty_metadata+0x76/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8a35>] schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f54f6>] =
journal_dirty_metadata+0x76/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3312>] =
__ext3_journal_dirty_metadata+0x22/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3f49>] =
journal_get_write_access+0x29/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e6c14>] =
ext3_mark_iloc_dirty+0x174/0x330</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e7187>] =
ext3_mark_inode_dirty+0x37/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3985>] journal_stop+0x135/0x250</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017c5b9>] =
balance_dirty_pages_ratelimited_nr+0x59/0x2c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e9372>] =
ext3_ordered_write_end+0xe2/0x140</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01b5825>] mnt_drop_write+0x95/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0175ec5>] =
generic_file_buffered_write+0x1c5/0x690</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01b5825>] mnt_drop_write+0x95/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03a1f04>] =
unix_dgram_recvmsg+0x184/0x2a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01747d5>] remove_suid+0x15/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01b5825>] mnt_drop_write+0x95/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01765dd>] =
__generic_file_aio_write_nolock+0x24d/0x560</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a2ce0>] pipe_write+0x0/0x470</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019b94f>] =
do_sync_readv_writev+0xbf/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019f488>] cp_new_stat64+0xf8/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029c413>] copy_from_user+0x33/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019b7de>] =
rw_copy_check_uvector+0x7e/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c0aa>] do_readv_writev+0xaa/0x190</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a2ce0>] pipe_write+0x0/0x470</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01273b4>] sigprocmask+0x74/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0129fc9>] =
sys_rt_sigprocmask+0xf9/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] klogd &nbsp; &nbsp; &nbsp; &nbsp; R running &nbsp; &nbsp; =
&nbsp;0 &nbsp;2300 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f957a0 00000082 00000000 f7f958fc 00000000 =
c01315a5 00000200 f76b7f34&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;c01312c0 00000fff 0804d6a0 c011da47 f76b7f1c =
f76b7f1c 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f76b7e80 494e9495 00000000 f7f957a0 c01312c0 =
f76b7f40 f76b7f40 f7c0c300&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01315a5>] =
prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011da47>] do_syslog+0x437/0x4c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01dbae0>] kmsg_read+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01d2990>] proc_reg_read+0x80/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01d2910>] proc_reg_read+0x0/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] inetd &nbsp; &nbsp; &nbsp; &nbsp; S f7c8359c &nbsp; &nbsp; =
0 &nbsp;2310 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c83440 00000086 f794c000 f7c8359c f7fb8500 =
c18de7a0 000fa013 00000006&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000020 00000000 00000000 c03c8a35 c013166d =
f7fdfbe4 f769c440 f7fc9c80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 c036fb94 c03f2000 00000020 00000006 =
00000020 c01a9b22 f7fdfbe4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c036fb94>] tcp_poll+0x14/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02adef5>] extract_buf+0x75/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c035f51a>] __nla_reserve+0x2a/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c035f579>] __nla_put+0x19/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01160b3>] kmap_atomic_prot+0x13/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0116066>] kunmap_atomic+0x26/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ac12>] =
get_page_from_freelist+0x312/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017af36>] =
__alloc_pages_internal+0xa6/0x450</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02adef5>] extract_buf+0x75/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01160b3>] kmap_atomic_prot+0x13/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0177285>] =
generic_file_aio_read+0x5b5/0x620</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01776ab>] filemap_fault+0x14b/0x4d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0183ed8>] __do_fault+0x188/0x360</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0185a6f>] handle_mm_fault+0x10f/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0113bdf>] do_page_fault+0x29f/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] nmbd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7cd015c &nbsp; =
&nbsp; 0 &nbsp;2318 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7cd0000 00000086 006edf00 f7cd015c c0575380 =
c0126991 00000200 f74c1b64&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;006edf00 00000000 00000000 c03c8a0a c013166d =
f74c1be4 c0575c80 c0575c80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;006edf00 c01265f0 f7cd0000 c0575380 0000000c =
00000800 c01a9b22 f74c1be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0126991>] =
__mod_timer+0xb1/0xf0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a0a>] =
schedule_timeout+0x4a/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01265f0>] process_timeout+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0369698>] =
ip_finish_output+0x1c8/0x2c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0343f8f>] __skb_clone+0x1f/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0367fc8>] ip_cork_release+0x28/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03473fa>] skb_queue_tail+0x6a/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034394c>] sock_def_readable+0x4c/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0342933>] =
sock_queue_rcv_skb+0xa3/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0384697>] =
udp_queue_rcv_skb+0xc7/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0347c98>] =
skb_copy_and_csum_datagram+0x258/0x3c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0197192>] __slab_free+0x72/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0197192>] __slab_free+0x72/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03457f8>] __kfree_skb+0x8/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034860a>] skb_free_datagram+0xa/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034860a>] skb_free_datagram+0xa/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986fc>] kmem_cache_free+0x7c/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034860a>] skb_free_datagram+0xa/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121c8a>] local_bh_disable+0xa/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341a07>] release_sock+0xc7/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0122076>] local_bh_enable+0x46/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0386324>] udp_recvmsg+0x1b4/0x330</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341425>] =
sock_common_recvmsg+0x45/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c033f6c7>] sock_recvmsg+0xd7/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0139989>] =
clocksource_get_next+0x59/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0137d69>] =
update_wall_time+0x259/0x7d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c015259e>] =
xnarch_next_htick_shot+0x4e/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8d50>] mutex_lock+0x10/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034cde7>] netdev_run_todo+0x27/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034a723>] __dev_get_by_name+0x73/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a890f>] fasync_helper+0x7f/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01ab7ab>] =
__posix_lock_file+0x6b/0x570</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01acb5e>] fcntl_setlk64+0x4e/0x2b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa382>] sys_select+0xe2/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01273b4>] sigprocmask+0x74/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] smbd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7cd0b7c &nbsp; =
&nbsp; 0 &nbsp;2320 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7cd0a20 00000082 c01bc400 f7cd0b7c f794c000 =
00000000 f7fb8500 00000015&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00100000 00000000 00000000 c03c8a35 c013166d =
f7511be4 f7fbd780 f7535a00&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 c01a21c2 00000014 00100000 00000015 =
00100000 c01a9b22 f7511be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01bc400>] =
__mark_inode_dirty+0x30/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8a35>] schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a21c2>] pipe_poll+0x32/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02adef5>] extract_buf+0x75/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02adef5>] extract_buf+0x75/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01796ce>] __rmqueue+0x1e/0x1d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017995c>] rmqueue_bulk+0x6c/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ab5b>] =
get_page_from_freelist+0x25b/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ab5b>] =
get_page_from_freelist+0x25b/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01776ab>] filemap_fault+0x14b/0x4d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0183ed8>] __do_fault+0x188/0x360</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0185a6f>] handle_mm_fault+0x10f/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0197daf>] kmem_cache_alloc+0x5f/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0113bdf>] do_page_fault+0x29f/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0197daf>] kmem_cache_alloc+0x5f/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019d0bb>] alloc_file+0x3b/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a842b>] do_fcntl+0x2ab/0x310</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] smbd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7e4eedc &nbsp; =
&nbsp; 0 &nbsp;2330 &nbsp; 2320</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7e4ed80 00000082 fffffff7 f7e4eedc 0000000e =
00000009 c01a84dd 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000001 00000003 f7c8a000 c01294f0 c0103145 =
00000000 00000019 089f6fd8&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000001 00000003 bfec4fe8 0000001d 0000007b =
0000007b c0100000 0000001d&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01a84dd>] =
sys_fcntl64+0x4d/0x90</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c01294f0>] =
sys_pause+0x10/0x20</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0103145>] =
syscall_call+0x7/0xb</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] sshd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7f4b8fc &nbsp; =
&nbsp; 0 &nbsp;2335 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4b7a0 00000082 f794c018 f7f4b8fc f7f22d80 =
c18de7a0 000fa013 00000005&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000010 00000000 00000000 c03c8a35 c013166d =
f74d3be4 f769d540 f7fc9b00&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 c036fb94 c03f2000 00000010 00000005 =
00000010 c01a9b22 f74d3be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c036fb94>] tcp_poll+0x14/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e6eb1>] =
__ext3_get_inode_loc+0xe1/0x2e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f54f6>] =
journal_dirty_metadata+0x76/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3312>] =
__ext3_journal_dirty_metadata+0x22/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3f49>] =
journal_get_write_access+0x29/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e6c14>] =
ext3_mark_iloc_dirty+0x174/0x330</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e7187>] =
ext3_mark_inode_dirty+0x37/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01eefe4>] =
__ext3_journal_stop+0x24/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01bc400>] =
__mark_inode_dirty+0x30/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029ab23>] number+0x2d3/0x2e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e9372>] =
ext3_ordered_write_end+0xe2/0x140</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01b5825>] mnt_drop_write+0x95/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029b3b7>] vsnprintf+0x307/0x5e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01160b3>] kmap_atomic_prot+0x13/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0116066>] kunmap_atomic+0x26/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ac12>] =
get_page_from_freelist+0x312/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ab5b>] =
get_page_from_freelist+0x25b/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01345d2>] enqueue_hrtimer+0x72/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0134df6>] hrtimer_start+0xd6/0x190</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117160>] __dequeue_entity+0x50/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117e30>] hrtick_set+0xc0/0x1a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0195acc>] add_partial+0x4c/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0197192>] __slab_free+0x72/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0185d00>] handle_mm_fault+0x3a0/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a27de>] free_pipe_info+0xe/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a27de>] free_pipe_info+0xe/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0197cbf>] kfree+0x8f/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a27de>] free_pipe_info+0xe/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a27de>] free_pipe_info+0xe/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a288d>] pipe_release+0x7d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0199ea7>] filp_close+0x47/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] proftpd &nbsp; &nbsp; &nbsp; S f7c82b7c &nbsp; &nbsp; 0 =
&nbsp;2422 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c82a20 00200086 006f461e f7c82b7c c0575380 =
c0126991 00000200 f74e3b64&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;006f461e 00000000 00000000 c03c8a0a c013166d =
f74e3be4 c0575f70 c04b09d0&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;006f461e c01265f0 f7c82a20 c0575380 00000002 =
00000002 c01a9b22 f74e3be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0126991>] =
__mod_timer+0xb1/0xf0</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a0a>] =
schedule_timeout+0x4a/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01265f0>] process_timeout+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01088a6>] read_tsc+0x6/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c015463f>] =
xntimer_start_aperiodic+0x10f/0x200</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01088a6>] read_tsc+0x6/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0134fe2>] ktime_get_ts+0x22/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013501d>] ktime_get+0xd/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117063>] =
hrtick_start_fair+0xa3/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01bfe6a>] =
__find_get_block_slow+0x7a/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01088a6>] read_tsc+0x6/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01c0290>] __find_get_block+0x90/0x1c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f367e>] =
__journal_file_buffer+0x6e/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3c86>] =
do_get_write_access+0x1e6/0x480</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01c03e2>] __getblk+0x22/0x220</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f367e>] =
__journal_file_buffer+0x6e/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f54f6>] =
journal_dirty_metadata+0x76/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3312>] =
__ext3_journal_dirty_metadata+0x22/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3f49>] =
journal_get_write_access+0x29/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3985>] journal_stop+0x135/0x250</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0147961>] __rcu_read_unlock+0x41/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aea09>] __d_lookup+0xc9/0x160</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c029587a>] =
_atomic_dec_and_lock+0x3a/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01b4183>] mntput_no_expire+0x13/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a606e>] path_walk+0x4e/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a6e29>] __user_walk_fd+0x49/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019f6ef>] vfs_lstat_fd+0x1f/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01379cd>] getnstimeofday+0x3d/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0134df6>] hrtimer_start+0xd6/0x190</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa382>] sys_select+0xe2/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0120fa0>] alarm_setitimer+0x30/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] cron &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7f4b59c &nbsp; =
&nbsp; 0 &nbsp;2434 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4b440 00000082 01d7138e f7f4b59c 00000000 =
00000200 00000000 f7fa5f60&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4b440 00000000 bfd44e04 c03c91bb 00000001 =
00000000 00000001 c0134ef5&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000001 f7c3d740 f7659f60 fa1e6b8e 000006e2 =
c0134a60 c047f254 00000001&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c91bb>] =
do_nanosleep+0x5b/0x90</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0134ef5>] =
hrtimer_nanosleep+0x45/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0134a60>] hrtimer_wakeup+0x0/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0134fb8>] sys_nanosleep+0x58/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] xdm &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; S f7c824bc &nbsp; =
&nbsp; 0 &nbsp;2456 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7c82360 00000082 f794c000 f7c824bc f7fb8500 =
c18de7a0 000fa016 00000005&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000010 00000000 00000000 c03c8a35 c0348524 =
f799e900 f7444400 c0385d0f&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 c03f2060 00000010 f7444400 00000005 =
00000010 c01a9b22 f7637be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0348524>] datagram_poll+0x14/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0385d0f>] udp_poll+0xf/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0177fd2>] mempool_alloc+0x32/0x180</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f54f6>] =
journal_dirty_metadata+0x76/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017dcdf>] activate_page+0x4f/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01160b3>] kmap_atomic_prot+0x13/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0116066>] kunmap_atomic+0x26/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017ac12>] =
get_page_from_freelist+0x312/0x590</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017af36>] =
__alloc_pages_internal+0xa6/0x450</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01c0290>] __find_get_block+0x90/0x1c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017e733>] =
lru_cache_add_active+0x43/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0185d93>] handle_mm_fault+0x433/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3c86>] =
do_get_write_access+0x1e6/0x480</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01c03e2>] __getblk+0x22/0x220</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01e6eb1>] =
__ext3_get_inode_loc+0xe1/0x2e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f54f6>] =
journal_dirty_metadata+0x76/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3312>] =
__ext3_journal_dirty_metadata+0x22/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3f49>] =
journal_get_write_access+0x29/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01f3985>] journal_stop+0x135/0x250</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01eefe4>] =
__ext3_journal_stop+0x24/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01bc48a>] =
__mark_inode_dirty+0xba/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017007b>] __sem_open+0x23b/0x310</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01160b3>] kmap_atomic_prot+0x13/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0177285>] =
generic_file_aio_read+0x5b5/0x620</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017a72a>] =
free_hot_cold_page+0x15a/0x1e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c018455b>] unmap_vmas+0x2db/0x500</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01855f5>] free_pgtables+0x85/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01986c2>] kmem_cache_free+0x42/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0187c33>] unmap_region+0xe3/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] getty &nbsp; &nbsp; &nbsp; &nbsp; S f7f9559c &nbsp; &nbsp; =
0 &nbsp;2468 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f95440 00000086 00000720 f7f9559c f7c2aa20 =
c1816a40 00000042 f7c89b80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f762b400 7fffffff 7fffffff c03c8a35 00000000 =
c02ab166 c0135cee 00000001&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;001ae60e c013166d f7c89b80 f762b400 f7c89b80 =
f762b400 c02b6254 00000003&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02ab166>] =
vgacon_set_cursor_size+0xd6/0x1a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0135cee>] up+0x5e/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6254>] read_chan+0x1c4/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b83>] tty_read+0x83/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6090>] read_chan+0x0/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b00>] tty_read+0x0/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] getty &nbsp; &nbsp; &nbsp; &nbsp; S f7f94b7c &nbsp; &nbsp; =
0 &nbsp;2470 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f94a20 00000086 00000000 f7f94b7c 00000000 =
c17ec600 00000020 f7c89d80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f762ac00 7fffffff 7fffffff c03c8a35 f74d4c00 =
00485898 c0135cee 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;0000446b c013166d f7c89d80 f762ac00 f7c89d80 =
f762ac00 c02b6254 00000003&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0135cee>] up+0x5e/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6254>] read_chan+0x1c4/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b83>] tty_read+0x83/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6090>] read_chan+0x0/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b00>] tty_read+0x0/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] getty &nbsp; &nbsp; &nbsp; &nbsp; S f7cd081c &nbsp; &nbsp; =
0 &nbsp;2472 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7cd06c0 00000082 00000000 f7cd081c 00000000 =
c17ec600 00000020 f7f51580&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f762b800 7fffffff 7fffffff c03c8a35 f76b2480 =
00485898 c0135cee 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;0000446b c013166d f7f51580 f762b800 f7f51580 =
f762b800 c02b6254 00000003&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0135cee>] up+0x5e/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6254>] read_chan+0x1c4/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b83>] tty_read+0x83/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6090>] read_chan+0x0/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b00>] tty_read+0x0/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] getty &nbsp; &nbsp; &nbsp; &nbsp; S f7f224bc &nbsp; &nbsp; =
0 &nbsp;2474 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f22360 00000082 00000000 f7f224bc 00000000 =
c17ec600 00000020 f7c05a80&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f762b000 7fffffff 7fffffff c03c8a35 f7f77a80 =
00485898 c0135cee 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;0000446b c013166d f7c05a80 f762b000 f7c05a80 =
f762b000 c02b6254 00000003&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0135cee>] up+0x5e/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6254>] read_chan+0x1c4/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b83>] tty_read+0x83/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6090>] read_chan+0x0/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b00>] tty_read+0x0/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] getty &nbsp; &nbsp; &nbsp; &nbsp; S f7f2281c &nbsp; &nbsp; =
0 &nbsp;2475 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f226c0 00000086 00000000 f7f2281c 00000000 =
c17ec600 00000020 f7fc9e00&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f762a800 7fffffff 7fffffff c03c8a35 f76b2000 =
00485898 c0135cee 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;0000446b c013166d f7fc9e00 f762a800 f7fc9e00 =
f762a800 c02b6254 00000003&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0135cee>] up+0x5e/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6254>] read_chan+0x1c4/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b83>] tty_read+0x83/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6090>] read_chan+0x0/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b00>] tty_read+0x0/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] getty &nbsp; &nbsp; &nbsp; &nbsp; S f7f22b7c &nbsp; &nbsp; =
0 &nbsp;2476 &nbsp; &nbsp; &nbsp;1</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f22a20 00000082 00000000 f7f22b7c 00000000 =
c17ec600 00000020 f7c96080&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f762a000 7fffffff 7fffffff c03c8a35 f7c56180 =
00485898 c0135cee 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;0000446b c013166d f7c96080 f762a000 f7c96080 =
f762a000 c02b6254 00000003&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0135cee>] up+0x5e/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6254>] read_chan+0x1c4/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b83>] tty_read+0x83/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6090>] read_chan+0x0/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b00>] tty_read+0x0/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] sshd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7f4a15c &nbsp; =
&nbsp; 0 &nbsp;2499 &nbsp; 2335</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4a000 00000086 00000000 f7f4a15c c048bb60 =
00000000 f7f12c10 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000080 00000000 00000000 c03c8a35 f7500100 =
f7f12c00 c02b4f20 c02b0836&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f768fbe4 f7f12c10 00000007 00000080 00000008 =
00000080 c01a9b22 f768fbe4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b4f20>] normal_poll+0x0/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b0836>] tty_poll+0x76/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034e10d>] dev_queue_xmit+0xcd/0x400</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0358eeb>] eth_header+0x2b/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0352c55>] =
neigh_resolve_output+0xf5/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03695e9>] =
ip_finish_output+0x119/0x2c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0367ec5>] ip_local_out+0x15/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c036a25e>] ip_queue_xmit+0x1ae/0x320</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121d9a>] __do_softirq+0x6a/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121cc8>] _local_bh_enable+0x28/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c037fa80>] tcp_v4_send_check+0x40/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c037a84f>] =
tcp_transmit_skb+0x3bf/0x7a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c010f570>] =
smp_apic_timer_interrupt+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01267eb>] lock_timer_base+0x4b/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0379fbc>] tcp_init_tso_segs+0x3c/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c037bfb9>] =
__tcp_push_pending_frames+0x139/0x750</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c036f705>] =
sk_stream_alloc_skb+0x35/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0198dd8>] =
__kmalloc_track_caller+0x78/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0122076>] local_bh_enable+0x46/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341b2b>] lock_sock_nested+0xfb/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121c8a>] local_bh_disable+0xa/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341a07>] release_sock+0xc7/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0122076>] local_bh_enable+0x46/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0371082>] tcp_sendmsg+0x7a2/0xab0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c033ea22>] sock_aio_write+0xe2/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01197b4>] try_to_wake_up+0x44/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019ba56>] do_sync_write+0xc6/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c8e1>] sys_write+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] bash &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7f4ab7c &nbsp; =
&nbsp; 0 &nbsp;2501 &nbsp; 2499</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4aa20 00000082 f74d4ac4 f7f4ab7c f741f098 =
c0185d00 c013166d ffffffea&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4aa18 0000000e 00000001 c011f60d f7e4fb00 =
c02b36aa 00000000 00000001&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 f7f4ab10 00000000 00000003 0000000c =
f7f4aa20 00000001 f7541a00&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0185d00>] =
handle_mm_fault+0x3a0/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011f60d>] do_wait+0x63d/0xc80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b36aa>] tty_ioctl+0x98a/0xab0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a288d>] pipe_release+0x7d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2d20>] tty_ioctl+0x0/0xab0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011fcc3>] sys_wait4+0x73/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011fd35>] sys_waitpid+0x25/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] remoteHost &nbsp; &nbsp;S f7e4fc5c &nbsp; &nbsp; 0 =
&nbsp;2507 &nbsp; 2501</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7e4fb00 =
00000082 f7e4fb00 f7e4fc5c 00000000 c017af36 c0485da0 =
f769ea80&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;00000000 =
7fffffff f769ec40 c03c8a35 c0122076 c0341b2b c16fe1e0 =
00000001&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;c0121c8a =
c0341a07 f769ea80 f769ea80 f769ea80 00000000 c036e10f =
000000d0&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c017af36>] =
__alloc_pages_internal+0xa6/0x450</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8a35>] schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0122076>] local_bh_enable+0x46/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341b2b>] lock_sock_nested+0xfb/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121c8a>] local_bh_disable+0xa/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341a07>] release_sock+0xc7/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c036e10f>] inet_csk_accept+0x12f/0x260</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c038ca4f>] inet_accept+0x1f/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0340a30>] sys_accept+0xf0/0x210</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0134fe2>] ktime_get_ts+0x22/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0185d00>] handle_mm_fault+0x3a0/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0113bdf>] do_page_fault+0x29f/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0340c16>] sys_socketcall+0xc6/0x280</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0199ea7>] filp_close+0x47/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019b5e2>] sys_close+0x82/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] sshd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7f22edc &nbsp; =
&nbsp; 0 &nbsp;9291 &nbsp; 2335</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f22d80 00000086 00000000 f7f22edc c048bb60 =
00000000 f7f4d410 00000008&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;00000080 00000000 00000000 c03c8a35 f7f04800 =
f7f4d400 c02b4f20 c02b0836&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7679be4 f7f4d410 00000007 00000080 00000008 =
00000080 c01a9b22 f7679be4&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c03c8a35>] =
schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b4f20>] normal_poll+0x0/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b0836>] tty_poll+0x76/0x80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9b22>] do_select+0x3b2/0x490</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa1b0>] __pollwait+0x0/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c034e10d>] dev_queue_xmit+0xcd/0x400</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0358eeb>] eth_header+0x2b/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0352c55>] =
neigh_resolve_output+0xf5/0x270</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0147961>] __rcu_read_unlock+0x41/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03695e9>] =
ip_finish_output+0x119/0x2c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0358eeb>] eth_header+0x2b/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0367ec5>] ip_local_out+0x15/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c036a25e>] ip_queue_xmit+0x1ae/0x320</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03695e9>] =
ip_finish_output+0x119/0x2c0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c037fa80>] tcp_v4_send_check+0x40/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c037a84f>] =
tcp_transmit_skb+0x3bf/0x7a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121f3f>] irq_exit+0x5f/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c010f5a0>] =
smp_apic_timer_interrupt+0x30/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01267eb>] lock_timer_base+0x4b/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0379fbc>] tcp_init_tso_segs+0x3c/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c037bfb9>] =
__tcp_push_pending_frames+0x139/0x750</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117063>] =
hrtick_start_fair+0xa3/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c036f705>] =
sk_stream_alloc_skb+0x35/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0198dd8>] =
__kmalloc_track_caller+0x78/0x120</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01267eb>] lock_timer_base+0x4b/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0121c8a>] local_bh_disable+0xa/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0341a07>] release_sock+0xc7/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0122076>] local_bh_enable+0x46/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0371082>] tcp_sendmsg+0x7a2/0xab0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01a9e08>] core_sys_select+0x208/0x340</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0117063>] =
hrtick_start_fair+0xa3/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c033ea22>] sock_aio_write+0xe2/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01197b4>] try_to_wake_up+0x44/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011688e>] __wake_up_common+0x3e/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019ba56>] do_sync_write+0xc6/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c01aa2ed>] sys_select+0x4d/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c8e1>] sys_write+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] bash &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7f238fc &nbsp; =
&nbsp; 0 &nbsp;9293 &nbsp; 9291</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f237a0 00000086 c013501d f7f238fc 09e6bb40 =
00989680 c0117063 f7f04580&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4c000 7fffffff 7fffffff c03c8a35 00000200 =
f7f237a0 f7f0e900 f7f0e900&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f237a0 c013166d f7f04580 f7f4c000 f7f04580 =
f7f4c000 c02b6254 00000003&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c013501d>] =
ktime_get+0xd/0x30</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp;[&lt;c0117063>] =
hrtick_start_fair+0xa3/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8a35>] schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6254>] read_chan+0x1c4/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b83>] tty_read+0x83/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b6090>] read_chan+0x0/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c411>] vfs_read+0xa1/0x130</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c02b2b00>] tty_read+0x0/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c019c871>] sys_read+0x41/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] remoteHost &nbsp; &nbsp;S f7c8281c &nbsp; &nbsp; 0 11799 =
&nbsp; 2507</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7c826c0 =
00000086 00000200 f7c8281c c04f4300 031703f8 c013166d =
f7592e84&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7c826b8 =
00000004 00000001 c011f60d f7592d80 f7c826c0 f7c56300 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;00000000 =
f7c827b0 f74b6c80 00000000 00000000 f7c826c0 00000001 =
f7592d80&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011f60d>] do_wait+0x63d/0xc80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011fcc3>] sys_wait4+0x73/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c011fd35>] sys_waitpid+0x25/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309992] remoteHost &nbsp; &nbsp;S f7c83c5c &nbsp; &nbsp; 0 11800 =
&nbsp; 2507</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f7c83b00 =
00000082 c03797ed f7c83c5c 00000200 00000000 00000000 =
f7653d7c&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;f75a4880 =
f75a48e0 f75a4b14 c03c8a35 f74f4620 c0341b2b 00000000 =
f74f4600&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] &nbsp; &nbsp; &nbsp; &nbsp;c0121c8a =
c0341a07 f7653d7c f7653d7c f7653d7c f75a4880 c0342564 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309992] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03797ed>] =
tcp_rcv_established+0x3ed/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309992] =
&nbsp;[&lt;c03c8a35>] schedule_timeout+0x75/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0341b2b>] lock_sock_nested+0xfb/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0121c8a>] local_bh_disable+0xa/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0341a07>] release_sock+0xc7/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0342564>] sk_wait_data+0x84/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c037173f>] tcp_recvmsg+0x3af/0x8a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0134fe2>] ktime_get_ts+0x22/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0117063>] =
hrtick_start_fair+0xa3/0x150</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0341425>] =
sock_common_recvmsg+0x45/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c033f6c7>] sock_recvmsg+0xd7/0x110</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c02b5324>] =
n_tty_receive_buf+0x2b4/0x1020</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c02b51c5>] =
n_tty_receive_buf+0x155/0x1020</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0113bdf>] do_page_fault+0x29f/0x6d0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c01345d2>] enqueue_hrtimer+0x72/0xf0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c033ef82>] =
sockfd_lookup_light+0x32/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c03406ce>] sys_recvfrom+0xce/0x160</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0117e30>] hrtick_set+0xc0/0x1a0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0119a1b>] hrtick_resched+0x4b/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c010260f>] do_notify_resume+0x6f/0x790</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c02aedba>] tty_put_char+0x2a/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c03ca20a>] =
rwsem_down_write_failed+0x2a/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0119aaf>] __wake_up+0x7f/0xd0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0340793>] sys_recv+0x33/0x40</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0340cb5>] sys_socketcall+0x165/0x280</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309993] rt61pci &nbsp; &nbsp; &nbsp; S f7f4a81c &nbsp; &nbsp; 0 =
15243 &nbsp; &nbsp; &nbsp;2</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] &nbsp; =
&nbsp; &nbsp; &nbsp;f7f4a6c0 00000046 c012d8c0 f7f4a81c c04762e0 =
c01315a5 00000200 f7644b40&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] &nbsp; =
&nbsp; &nbsp; &nbsp;f7644b48 00000000 00000000 c012e1bd 00000000 =
f7f4a6c0 c01312c0 f7644b48&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] &nbsp; =
&nbsp; &nbsp; &nbsp;f7644b48 fffffffc f7644b40 c012e130 c0130f32 =
c0130ef0 00000000 00000000&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp;[&lt;c012d8c0>] =
run_workqueue+0x120/0x1b0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c01315a5>] prepare_to_wait+0x85/0xe0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c012e1bd>] worker_thread+0x8d/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c01312c0>] =
autoremove_wake_function+0x0/0x50</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c012e130>] worker_thread+0x0/0xa0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0130f32>] kthread+0x42/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0130ef0>] kthread+0x0/0x70</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0103db3>] =
kernel_thread_helper+0x7/0x14</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309993] actuatorTask &nbsp;? f759281c &nbsp; &nbsp; 0 15816 &nbsp; =
&nbsp; &nbsp;1</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f75926c0 =
00000046 400000c0 f759281c f75926c0 00000000 00003dc8 =
00000010&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f75926c0 =
f75b1edc 00000000 c01202bc c0155590 c04844a4 00000246 =
00000001&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f75b1f90 =
f759276c f75927b0 00000000 00000000 f75b1f90 f75b1f90 =
f7fdbe00&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c01202bc>] do_exit+0x4bc/0x730</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0155590>] sigwake_event+0x0/0x140</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c012055f>] do_group_exit+0x2f/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309993] Actuator Aper S f7592b7c &nbsp; &nbsp; 0 15817 &nbsp; =
&nbsp; &nbsp;1</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f7592a20 =
00000086 00000001 f7592b7c 00000001 00000000 00000200 =
f7e60620&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f7592a20 =
f7729fb8 00000170 c01560ad 00000010 f7729f5c 00000001 =
00000006&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;00000000 =
f7729fb8 00000170 c015628f 00000001 c0577b04 c0577b00 =
00000000&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c01560ad>] xnshadow_harden+0x8d/0x1e0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c015628f>] losyscall_event+0x8f/0x170</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c014a1e2>] =
__ipipe_dispatch_event+0xa2/0x190</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0156200>] losyscall_event+0x0/0x170</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0112731>] =
__ipipe_syscall_root+0x41/0x100</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c010311d>] system_call+0x29/0x4a</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309993] sh &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;S f7592edc =
&nbsp; &nbsp; 0 15832 &nbsp;11799</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] &nbsp; =
&nbsp; &nbsp; &nbsp;f7592d80 00000086 f7c56944 f7592edc f7f36080 =
c0185d00 c013166d ffffffea&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] &nbsp; =
&nbsp; &nbsp; &nbsp;f7592d78 00000004 00000001 c011f60d f7593b00 =
f7c56900 f7c56300 00000001&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] &nbsp; =
&nbsp; &nbsp; &nbsp;00000000 f7592e70 00000000 00000003 0000000c =
f7592d80 00000001 f7593b00&nbsp;</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] Call =
Trace:</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp;[&lt;c0185d00>] =
handle_mm_fault+0x3a0/0x670</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c013166d>] add_wait_queue+0x6d/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c011f60d>] do_wait+0x63d/0xc80</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0119840>] =
default_wake_function+0x0/0x10</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c011fcc3>] sys_wait4+0x73/0xc0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c011fd35>] sys_waitpid+0x25/0x30</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" face=3D"Consolas">[ =
7565.309993] sleep &nbsp; &nbsp; &nbsp; &nbsp; S f7593c5c &nbsp; &nbsp; =
0 16596 &nbsp;15832</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f7593b00 =
00000086 4b3f0cce f7593c5c 00000000 00000200 00000000 =
f7659f60&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f7593b00 =
00000001 00000000 c03c91bb 00000001 00000000 00000001 =
c0134ef5&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] &nbsp; &nbsp; &nbsp; &nbsp;f7fa5f61 =
f754c740 c0576960 86d9d6ce 000006e1 c0134a60 c047f254 =
00000001&nbsp;</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">[ 7565.309993] Call Trace:</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c03c91bb>] do_nanosleep+0x5b/0x90</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0134ef5>] hrtimer_nanosleep+0x45/0xb0</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0134a60>] hrtimer_wakeup+0x0/0x20</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0134fb8>] sys_nanosleep+0x58/0x60</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;[&lt;c0103145>] syscall_call+0x7/0xb</font></div><div><font =
class=3D"Apple-style-span" face=3D"Consolas">[ 7565.309993] =
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</font></div><div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></div></div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font><div><div><font class=3D"Apple-style-span" =
face=3D"Consolas">On Nov 28, 2008, at 7:11 PM, Gilles Chanteperdrix =
wrote:</font></div><font class=3D"Apple-style-span" =
face=3D"Consolas"><br></font><blockquote type=3D"cite"><div><font =
class=3D"Apple-style-span" face=3D"Consolas">Mehmet Alphan Ulusoy =
wrote:<br></font><blockquote type=3D"cite"><font =
class=3D"Apple-style-span" face=3D"Consolas">ps aux says Task's state is =
"Zl+" and it's there for over 6 hours now, =
&nbsp;<br></font></blockquote><blockquote type=3D"cite"><font =
class=3D"Apple-style-span" face=3D"Consolas">is init's mentioned =
behavior standard or somewhat =
optional?<br></font></blockquote><blockquote type=3D"cite"><font =
class=3D"Apple-style-span" =
face=3D"Consolas"><br></font></blockquote><blockquote type=3D"cite"><font =
class=3D"Apple-style-span" face=3D"Consolas">If it's standard, then does =
this mean that there's something else going =
on?<br></font></blockquote><font class=3D"Apple-style-span" =
face=3D"Consolas"><br>If you are able to reproduce this issue with a =
simple program, could you<br>send it to us?<br><br>-- <br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles.<=
br><br></font></div></blockquote></div><br></body></html>=

--Apple-Mail-22-324902210--

--Apple-Mail-23-324902281
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMzCCAuww
ggJVoAMCAQICEFlbEbpcrtRwEgeTD6b7/UYwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDkxMDE4MjkxMFoXDTA5MDkxMDE4Mjkx
MFowSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZYWxw
aGFuQHN1LnNhYmFuY2l1bml2LmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKju
oEccePvK+1FqYYzkT3ZagQMkK86SRcJIznx9wqt7mIE6oYI/SjcjURCvuaoU4l0zG3dhC5Jlgg1A
u5xtAQCxd/mrvyRm6fM+AMs+qvyZjVBLqAnHT/HxHTV3Ju5BE4U2G6Dj+x18WuRy/YSj4fihhdAI
AcsPuJri8Dfvusecef7Xam6gcl0kkRexmEDiiMSb3SEziOdjQqAZEArTRMYZYGFANsMJvXzNN76I
qyAkaAcr8IuUoXt0RYwwn2DhUcBTrg1SfIqYdTrWi7TmCVpudfND6hHlz8+RogQi7ohbMbwKFwKa
3gXhcRnc1dABGNnyXDJR1nCWKMHq1KE72DUCAwEAAaM2MDQwJAYDVR0RBB0wG4EZYWxwaGFuQHN1
LnNhYmFuY2l1bml2LmVkdTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBACe45E4PvEZO
ZjwogK3R7lVPLQ4bfNF1hpUDfK0Kgba6jbDlIRSmx0Cz3xgMdC2SGpf3aCu+7PJQa4u0NA2QAlEs
AMI9QFNtu0HhyXKtdR3a7sHRCR4XiczLQUHS4S9LRKueHGvWaVx6jQICMH9lJBlW62gnd2TgOcWP
TGxJWK9YMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTAT
BgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUg
Q29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIG
A1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25h
bC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUA
A4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7
n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAw
QwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJl
ZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRl
TGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aUnX9M
Ibj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowg
T2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAxAwggMMAgEBMHYw
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhBZWxG6XK7UcBIHkw+m
+/1GMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTA4MTIyMTE5MjgwOVowIwYJKoZIhvcNAQkEMRYEFEfiBEDavwURt63taezTQ9UdDUq9MIGF
BgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQWVsRulyu1HASB5MPpvv9RjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQWVsRulyu1HASB5MPpvv9RjANBgkqhkiG9w0BAQEF
AASCAQCOcx9hMbs2NWd1OgJyQmHZ6nEbf5Nm5/bKOUsQMnR/MLew2U9U9+8cfuL/bN+1E9hBC4IF
81WrVYzhWTPCq69knwvmw99ecDoccdRantZGmqnHNwIFhG03vP1WQdq+JTihgO7dTqxBFtSsix3g
ixDXGwhGUxZXXOlcmIpKgSWz9qvd1Ww0vwz7oxr2xBeUeM6SOicJdB3onwBlTRzkUt5/6UrJrT1T
UbMu/pUnwKmZ+PMeybg8W9WtGR/jr+g4cCs/Ln9GpVfTZ22RI3OjYSad3JkwYooUKuMDGuCmVjEZ
IgkuApFu2z7BR4S1Zw0syz9nitYfaWyIfQa7GMTIK/O0AAAAAAAA

--Apple-Mail-23-324902281--

