Message-Id: <1B44D448-6E28-45CD-97E7-7230D3E44D61@domain.hid>
From: Alphan Ulusoy <alphan@domain.hid>
In-Reply-To: <494F9007.5060600@domain.hid>
Content-Type: multipart/signed; boundary=Apple-Mail-30-448409988; micalg=sha1;
	protocol="application/pkcs7-signature"
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 23 Dec 2008 07:46:36 +0200
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>	<492EF786.4040303@domain.hid>	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>	<49301B0B.9010208@domain.hid>	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>	<49302630.4080104@domain.hid>	<D6B7B711-7E2F-466D-857F-53EB7A7C30DC@su.sabanciuniv.edu>	<B41FD0F2-09C0-4DB6-B36C-892B72A63875@domain.hid>	<C7714144-0328-4258-95BD-133AB45C72E9@domain.hid>	<494F6250.50707@domain.hid>
	<20081222133253.lscsfad40kswkwsc@domain.hid>
	<494F9007.5060600@domain.hid>
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


--Apple-Mail-30-448409988
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

I've done the changes you suggested ( addition to sched.c file and  
fram pointers) and left the tasks running last night. Below you can  
find the dump. The hex numbers inside the brackets ( [0x00000001] )  
are newly added. And as you said in your previous post "Actuator  
Aperiodic Task" is the real-time task created and started in the  
process called "actuatorTask" which turns into a zombie. The ps aux  
output says:

root     28213  0.0  0.0      0     0 pts/0    Zl   04:21   0:02  
[actuatorTask] <defunct>


To give you a heads up, the actuator Aperiodic task is a simple  
for(;;) loop which blocks on recvfrom() on a UDP socket at every  
iteration until a packet is received. Then it writes the data it  
contains to a shared variable acquiring and releasing a mutex. any  
ideas?


regards,

alphan.



------- Dump starts here ---------


[33034.505238] SysRq : Show State
[33034.505238]   task                PC stack   pid father
[33034.505238] init          S [0x00000001] c0128feb     0     1      0
[33034.505238]        f7c2bb30 00000086 f7c2bb14 c0128feb f7c2c000  
f7c2c254 c0117a30 f7c2bb40
[33034.505238]        f7c2bb30 c012917f 00000000 00000200 f7c2bb40  
01f382e1 00000000 f7c2bb60
[33034.505238]        c03bffc7 f7f20400 f7c2bbd0 c056fbd8 c056fbd8  
01f382e1 c0128dd0 f7c2c000
[33034.505238] Call Trace:
[33034.505238]  [<c0128feb>] ? lock_timer_base+0x4b/0xa0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c012917f>] ? __mod_timer+0xaf/0xf0
[33034.505238]  [<c03bffc7>] schedule_timeout+0x47/0xc0
[33034.505238]  [<c0128dd0>] ? process_timeout+0x0/0x10
[33034.505238]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505238]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<f88b4c65>] ? __ieee80211_rx+0x195/0x5e0 [mac80211]
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c033e6d1>] ? skb_dequeue+0x71/0xb0
[33034.505238]  [<f88a2482>] ? ieee80211_tasklet_handler+0x72/0x100  
[mac80211]
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c012473b>] ? _local_bh_enable+0x2b/0x80
[33034.505238]  [<c0124839>] ? __do_softirq+0xa9/0xc0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0124977>] ? irq_exit+0x27/0x80
[33034.505238]  [<c0105aad>] ? do_IRQ+0x3d/0x70
[33034.505238]  [<c010311c>] ? restore_nocheck_notrace+0x0/0xe
[33034.505238]  [<c0105a70>] ? do_IRQ+0x0/0x70
[33034.505238]  [<c014be02>] ? __xirq_end+0x0/0x45
[33034.505238]  [<c014bf4a>] ? __ipipe_walk_pipeline+0x6a/0xb0
[33034.505238]  [<c0111f41>] ? __ipipe_handle_irq+0x81/0x1a0
[33034.505238]  [<c01a9e21>] ? do_select+0x1/0x590
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c01aee28>] ? __d_lookup+0xc8/0x180
[33034.505238]  [<c029101d>] ? _atomic_dec_and_lock+0x2d/0x50
[33034.505238]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505238]  [<c01369e5>] ? enqueue_hrtimer+0x75/0xf0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c029101d>] ? _atomic_dec_and_lock+0x2d/0x50
[33034.505238]  [<c01b4476>] ? mntput_no_expire+0x16/0x100
[33034.505238]  [<c01a4530>] ? path_put+0x20/0x30
[33034.505238]  [<c01a691b>] ? path_walk+0x4b/0x90
[33034.505238]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505238]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0297e73>] ? copy_to_user+0x43/0x60
[33034.505238]  [<c019ff4b>] ? cp_new_stat64+0xeb/0x100
[33034.505238]  [<c01aaac4>] sys_select+0xd4/0x190
[33034.505238]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505238]  =======================
[33034.505238] kthreadd      S [0x00000001] f7c31fa4     0     2      0
[33034.505238]        f7c31fc8 00000046 00000000 f7c31fa4 f7c2c470  
f7c2c6c4 f7c31fac c90ecb83
[33034.505238]        00001375 00000000 00000000 00000000 c04783f0  
00006e27 f7663da8 f7c31fe0
[33034.505238]        c013374a 00000000 c01335d0 00000000 00000000  
00000000 c0103d43 00000000
[33034.505238] Call Trace:
[33034.505238]  [<c013374a>] kthreadd+0x17a/0x1a0
[33034.505238]  [<c01335d0>] ? kthreadd+0x0/0x1a0
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] ksoftirqd/0   S [0x00000001] 00000000     0     3      2
[33034.505238]        f7c33fc0 00000046 c0117a30 00000000 f7c2c8e0  
f7c2cb34 f7c33fb0 c0124839
[33034.505238]        00000000 f7c33fb0 c014c146 f7c33fc0 00000000  
00000000 c0124b70 f7c33fcc
[33034.505238]        c0124c3d fffffffc f7c33fe0 c01335a2 c0133560  
00000000 00000000 00000000
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0124839>] ? __do_softirq+0xa9/0xc0
[33034.505238]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505238]  [<c0124b70>] ? ksoftirqd+0x0/0x140
[33034.505238]  [<c0124c3d>] ksoftirqd+0xcd/0x140
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] watchdog/0    S [0x00000001] 0a987ddd     0     4      2
[33034.505238]        f7c39f9c 00000046 00000000 0a987ddd f7c2cd50  
f7c2cfa4 00000073 0a98a945
[33034.505238]        00000000 00000000 00000000 f7c39f94 fffffffc  
00000000 00000000 f7c39fcc
[33034.505238]        c01471c8 f7c2cfa4 f7c2c000 03e66246 00000000  
c011c4ec 00000000 00000063
[33034.505238] Call Trace:
[33034.505238]  [<c01471c8>] watchdog+0x58/0x1c0
[33034.505238]  [<c011c4ec>] ? complete+0x6c/0x90
[33034.505238]  [<c0147170>] ? watchdog+0x0/0x1c0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] events/0      S [0x00000001] c0117a30     0     5      2
[33034.505238]        f7c3bfa4 00000046 f7c3bf7c c0117a30 f7c2d1c0  
f7c2d414 c0117a30 f7c2d1c0
[33034.505238]        f7c3bfa4 c0133b8b 00000001 00000200 f7c08140  
f7c08148 f7c3bfac f7c3bfcc
[33034.505238]        c01307f5 00000000 f7c2d1c0 c01338f0 f7c08148  
f7c08148 fffffffc f7c08140
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] khelper       S [0x00000001] c0117a30     0     6      2
[33034.505238]        f7c3dfa4 00000046 f7c3df7c c0117a30 f7c2d630  
f7c2d884 c0117a30 c9d8651e
[33034.505238]        000000d8 c0133b8b 00000001 00000200 f7c081c0  
f7c081c8 f7c3dfac f7c3dfcc
[33034.505238]        c01307f5 00000000 f7c2d630 c01338f0 f7c081c8  
f7c081c8 fffffffc f7c081c0
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] kblockd/0     S [0x00000001] c0117a30     0    54      2
[33034.505238]        f7cd9fa4 00000046 f7cd9f7c c0117a30 f7c970d0  
f7c97324 c0117a30 f7c970d0
[33034.505238]        f7cd9fa4 c0133b8b 00000001 00000200 f7c1af00  
f7c1af08 f7cd9fac f7cd9fcc
[33034.505238]        c01307f5 00000000 f7c970d0 c01338f0 f7c1af08  
f7c1af08 fffffffc f7c1af00
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] khubd         S [0x00000001] 00000002     0    63      2
[33034.505238]        f7cfdf38 00000046 00000000 00000002 f7ce5aa0  
f7ce5cf4 c0117a30 55f4defd
[33034.505238]        00000000 c0133b8b 00000001 00000200 f7cfdfa0  
f7cb8240 00000000 f7cfdfcc
[33034.505238]        c0301449 f7cfdfb8 002160e9 00000000 123e6adf  
00000000 f7c2d658 f7f3b904
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c0301449>] hub_thread+0x649/0xcb0
[33034.505238]  [<c011996e>] ? hrtick_set+0xde/0x1a0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c03bf76d>] ? schedule+0x2fd/0x570
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c011c4ec>] ? complete+0x6c/0x90
[33034.505238]  [<c0300e00>] ? hub_thread+0x0/0xcb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] kseriod       S [0x00000001] c0198add     0    66      2
[33034.505238]        f7d03f90 00000046 f7d03f84 c0198add f7ce67f0  
f7ce6a44 c0117a30 5761608e
[33034.505238]        00000000 c0133b8b 00000001 00000200 f7d03fac  
00000000 f7f388e0 f7d03fcc
[33034.505238]        c031cb4f 00000001 00000003 f7ce67f0 f7ce6a44  
00000200 00000000 f7ce67f0
[33034.505238] Call Trace:
[33034.505238]  [<c0198add>] ? kfree+0x9d/0xf0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c031cb4f>] serio_thread+0xff/0x400
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c031ca50>] ? serio_thread+0x0/0x400
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] gatekeeper/0  S [0x00000001] f7c87f78     0   150      2
[33034.505238]        f7c87f94 00000046 00000046 f7c87f78 f7c88000  
f7c88254 c0571f40 be53c9c0
[33034.505238]        0000137d 00000000 f7c87f94 c0138047 f7d81a20  
c057be60 c057be6c f7c87fcc
[33034.505238]        c0158f77 00000003 f7c88000 f7c88254 00000000  
00000001 f7c88000 c011a4d0
[33034.505238] Call Trace:
[33034.505238]  [<c0138047>] ? up+0x57/0x90
[33034.505238]  [<c0158f77>] gatekeeper_thread+0xa7/0x140
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c0158ed0>] ? gatekeeper_thread+0x0/0x140
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] pdflush       S [0x00000001] f7c65f80     0   154      2
[33034.505238]        f7c65fa4 00000046 c04ee300 f7c65f80 f7c891c0  
f7c89414 f7c65f88 0d502af9
[33034.505238]        00000000 c011a2b5 c04ee300 00000200 f7c65fbc  
00000000 c017ee20 f7c65fcc
[33034.505238]        c017eedb 0d50119b f7c891c0 00000000 00000000  
c047f094 f7dbffbc fffb6cfe
[33034.505238] Call Trace:
[33034.505238]  [<c011a2b5>] ? set_user_nice+0x105/0x160
[33034.505238]  [<c017ee20>] ? pdflush+0x0/0x230
[33034.505238]  [<c017eedb>] pdflush+0xbb/0x230
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] pdflush       S [0x00000001] f7dbff94     0   155      2
[33034.505238]        f7dbffa4 00000046 00000000 f7dbff94 f7c89630  
f7c89884 00000000 00000000
[33034.505238]        00000000 00000000 00000025 01f304ae f7dbffbc  
00000000 c017ee20 f7dbffcc
[33034.505238]        c017eedb 0d504449 f7c89630 00000000 00000000  
f7c65fbc c047f094 01f379de
[33034.505238] Call Trace:
[33034.505238]  [<c017ee20>] ? pdflush+0x0/0x230
[33034.505238]  [<c017eedb>] pdflush+0xbb/0x230
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] kswapd0       S [0x00000001] 00000000     0   156      2
[33034.505238]        f7dc1f34 00000046 00000000 00000000 f7c89aa0  
f7c89cf4 c0117a30 0d52fb0d
[33034.505238]        00000000 c0133b8b 00000001 00000200 00000000  
c047e580 c0182840 f7dc1fcc
[33034.505238]        c0182bdb f7c89ac8 f7c89ac8 f7dc1f70 c047f028  
f7dc1f70 00000000 f7c2c498
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c0182840>] ? kswapd+0x0/0x410
[33034.505238]  [<c0182bdb>] kswapd+0x39b/0x410
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c011996e>] ? hrtick_set+0xde/0x1a0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c03bf76d>] ? schedule+0x2fd/0x570
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c011c4ec>] ? complete+0x6c/0x90
[33034.505238]  [<c0182840>] ? kswapd+0x0/0x410
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] aio/0         S [0x00000001] 00000000     0   199      2
[33034.505238]        f7d01fa4 00000046 f7d01f7c 00000000 f7f551c0  
f7f55414 c0117a30 0d7079c5
[33034.505238]        00000000 c0133b8b 00000001 00000200 f7c1afc0  
f7c1afc8 f7d01fac f7d01fcc
[33034.505238]        c01307f5 00000000 f7f551c0 c01338f0 f7c1afc8  
f7c1afc8 fffffffc f7c1afc0
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] unionfs_siod/ S [0x00000001] 00000000     0   212      2
[33034.505238]        f7c83fa4 00000046 f7c83f7c 00000000 f7c94d50  
f7c94fa4 c0117a30 0d7a27f0
[33034.505238]        00000000 c0133b8b 00000001 00000200 f7c1aa40  
f7c1aa48 f7c83fac f7c83fcc
[33034.505238]        c01307f5 00000000 f7c94d50 c01338f0 f7c1aa48  
f7c1aa48 fffffffc f7c1aa40
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] nfsiod        S [0x00000001] 00000000     0   213      2
[33034.505238]        f7c5dfa4 00000046 f7c5df7c 00000000 f7c951c0  
f7c95414 c0117a30 0d7b1c2d
[33034.505238]        00000000 c0133b8b 00000001 00000200 f7c1a340  
f7c1a348 f7c5dfac f7c5dfcc
[33034.505238]        c01307f5 00000000 f7c951c0 c01338f0 f7c1a348  
f7c1a348 fffffffc f7c1a340
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] kpsmoused     S [0x00000001] ffffffff     0   878      2
[33034.505238]        f7f03fa4 00000046 00000000 ffffffff f7f91aa0  
f7f91cf4 c0117a30 5625a9d4
[33034.505238]        00000000 c0133b8b 00000001 00000200 f7c4d4c0  
f7c4d4c8 f7f03fac f7f03fcc
[33034.505238]        c01307f5 00000000 f7f91aa0 c01338f0 f7c4d4c8  
f7c4d4c8 fffffffc f7c4d4c0
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] rpciod/0      S [0x00000001] ffffffff     0   887      2
[33034.505238]        f7f09fa4 00000046 00000000 ffffffff f7f911c0  
f7f91414 c0117a30 5954fbff
[33034.505238]        00000000 c0133b8b 00000001 00000200 f7c4da00  
f7c4da08 f7f09fac f7f09fcc
[33034.505238]        c01307f5 00000000 f7f911c0 c01338f0 f7c4da08  
f7c4da08 fffffffc f7c4da00
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] kjournald     S [0x00000001] f7f0bf70     0   891      2
[33034.505238]        f7f0bf94 00000046 f7f5f440 f7f0bf70 f7f93540  
f7f93794 c0117a30 855e8900
[33034.505238]        00001e0a 00000000 00000001 00000200 f7f5f400  
00000000 f7f5f4c4 f7f0bfcc
[33034.505238]        c01f881e 00000000 00000005 f7f5f450 f7f5f440  
00000000 f7f93540 c01338f0
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c01f881e>] kjournald+0x1fe/0x240
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c01f8620>] ? kjournald+0x0/0x240
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] udevd         S [0x00000001] 00000200     0   993      1
[33034.505238]        f7fa5b30 00000082 c0133c22 00000200 f7ce5f10  
f7ce6164 f7fa5b18 d5a96edc
[33034.505238]        00001307 00000000 c0133c22 00000200 00000008  
00000080 00000000 f7fa5b60
[33034.505238]        c03bfff5 f7f830c0 f7fa5b4c c03c02f3 00000080  
00000041 f7fa5b60 c01c9c38
[33034.505238] Call Trace:
[33034.505238]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505238]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505238]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505238]  [<c03c02f3>] ? mutex_lock+0x13/0x30
[33034.505238]  [<c01c9c38>] ? inotify_poll+0x48/0x60
[33034.505238]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505238]  [<c013d146>] ? clockevents_program_event+0xb6/0x120
[33034.505238]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c017c8a7>] ? get_page_from_freelist+0x227/0x530
[33034.505238]  [<c0115cc3>] ? kmap_atomic_prot+0x43/0xb0
[33034.505238]  [<c0296228>] ? number+0x288/0x2a0
[33034.505238]  [<c0115c48>] ? kunmap_atomic+0x38/0x70
[33034.505238]  [<c017e28b>] ? balance_dirty_pages_ratelimited_nr+0x4b/ 
0x290
[33034.505238]  [<c0192c10>] ? shmem_truncate_range+0x150/0x820
[33034.505238]  [<c0117ac0>] ? add_preempt_count+0x10/0x80
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c017d783>] ? set_page_dirty+0x43/0xd0
[33034.505238]  [<c0296b21>] ? vsnprintf+0x371/0x6d0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0185204>] ? do_wp_page+0x1e4/0x490
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0185204>] ? do_wp_page+0x1e4/0x490
[33034.505238]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505238]  [<c01b5a31>] ? mnt_drop_write+0x81/0x170
[33034.505238]  [<c01a3dd9>] ? pipe_read+0x2e9/0x380
[33034.505238]  [<c019c76c>] ? do_sync_read+0xcc/0x110
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c01aaa2f>] sys_select+0x3f/0x190
[33034.505238]  [<c019c6a0>] ? do_sync_read+0x0/0x110
[33034.505238]  [<c019d3fd>] ? sys_read+0x3d/0x70
[33034.505238]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505238]  =======================
[33034.505238] kjournald     S [0x00000001] f74b7f70     0  2019      2
[33034.505238]        f74b7f94 00000046 f7f5fc40 f74b7f70 f7f579b0  
f7f57c04 c0117a30 f7f579b0
[33034.505238]        f74b7f94 c0133b8b 00000001 00000200 f7f5fc00  
00000000 f7f5fcc4 f74b7fcc
[33034.505238]        c01f881e 00000000 00000005 f7f5fc50 f7f5fc40  
00000000 f7f579b0 c01338f0
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c01f881e>] kjournald+0x1fe/0x240
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c01f8620>] ? kjournald+0x0/0x240
[33034.505238]  [<c01335a2>] kthread+0x42/0x70
[33034.505238]  [<c0133560>] ? kthread+0x0/0x70
[33034.505238]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505238]  =======================
[33034.505238] dhclient3     S [0x00000001] c0128feb     0  2097      1
[33034.505238]        f7577b30 00000082 f7577b14 c0128feb f7f56380  
f7f565d4 c0117a30 f7577b40
[33034.505238]        f7577b30 c012917f 00000000 00000200 f7577b40  
01f4ca42 00000000 f7577b60
[33034.505238]        c03bffc7 f7f7b600 f7577bd0 c04a9c8c c056fe60  
01f4ca42 c0128dd0 f7f56380
[33034.505238] Call Trace:
[33034.505238]  [<c0128feb>] ? lock_timer_base+0x4b/0xa0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c012917f>] ? __mod_timer+0xaf/0xf0
[33034.505238]  [<c03bffc7>] schedule_timeout+0x47/0xc0
[33034.505238]  [<c0128dd0>] ? process_timeout+0x0/0x10
[33034.505238]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505238]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c011a3f8>] ? try_to_wake_up+0x58/0x130
[33034.505238]  [<c0108679>] ? read_tsc+0x9/0x30
[33034.505238]  [<c0139cfb>] ? getnstimeofday+0x3b/0xe0
[33034.505238]  [<c0137576>] ? ktime_get_ts+0x46/0x50
[33034.505238]  [<c0137591>] ? ktime_get+0x11/0x30
[33034.505238]  [<c01172cb>] ? hrtick_start_fair+0xeb/0x140
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0197e51>] ? deactivate_slab+0x61/0x160
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c01985b8>] ? __slab_alloc+0x68/0x4f0
[33034.505238]  [<c0117ac0>] ? add_preempt_count+0x10/0x80
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0296228>] ? number+0x288/0x2a0
[33034.505238]  [<c011687e>] ? __wake_up_common+0x3e/0x70
[33034.505238]  [<c011c442>] ? __wake_up_sync+0x72/0xb0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c033cd65>] ? sock_def_readable+0x45/0x80
[33034.505238]  [<c0398a11>] ? unix_dgram_sendmsg+0x461/0x530
[33034.505238]  [<c0352c25>] ? __qdisc_run+0x1c5/0x220
[33034.505238]  [<c0296b21>] ? vsnprintf+0x371/0x6d0
[33034.505238]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505238]  [<c01369e5>] ? enqueue_hrtimer+0x75/0xf0
[33034.505238]  [<c01aef04>] ? d_lookup+0x24/0x40
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0185204>] ? do_wp_page+0x1e4/0x490
[33034.505238]  [<c014a215>] ? call_rcu+0x55/0x70
[33034.505238]  [<c01874e2>] ? handle_mm_fault+0x352/0x5f0
[33034.505238]  [<c0113832>] ? do_page_fault+0x2c2/0x670
[33034.505238]  [<c01aaac4>] sys_select+0xd4/0x190
[33034.505238]  [<c0297e73>] ? copy_to_user+0x43/0x60
[33034.505238]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505238]  =======================
[33034.505238] syslogd       S [0x00000001] 00000200     0  2238      1
[33034.505238]        f755bb30 00000086 c0133c22 00000200 f7f91630  
f7f91884 f755bbd0 f755bb2c
[33034.505238]        f755bb20 c0117a30 00000000 f755bb2c 00000001  
00000001 00000000 f755bb60
[33034.505238]        c03bfff5 f755bbd0 f7ca3b00 00000001 0155bb50  
c03eaee0 00000001 f7ca3b00
[33034.505238] Call Trace:
[33034.505238]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505238]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505238]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c0289288>] ? blk_recount_segments+0x38/0x60
[33034.505238]  [<c01e5fbe>] ? ext3_reserve_inode_write+0x5e/0x80
[33034.505238]  [<c01edcd7>] ? __ext3_journal_stop+0x27/0x50
[33034.505238]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505238]  [<c0179de1>] ? mempool_alloc+0x31/0x160
[33034.505238]  [<c0284683>] ? elv_rb_add+0x53/0x70
[33034.505238]  [<c028e087>] ? deadline_add_rq_rb+0x27/0x50
[33034.505238]  [<c028e126>] ? deadline_add_request+0x26/0x60
[33034.505238]  [<c028448b>] ? elv_insert+0xfb/0x160
[33034.505238]  [<c028454d>] ? __elv_add_request+0x5d/0xa0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0286922>] ? __make_request+0x102/0x340
[33034.505238]  [<c0285aa4>] ? generic_make_request+0x174/0x220
[33034.505238]  [<c0198b9f>] ? kmem_cache_alloc+0x5f/0xd0
[33034.505238]  [<c017991e>] ? mempool_alloc_slab+0xe/0x10
[33034.505238]  [<c0179de1>] ? mempool_alloc+0x31/0x160
[33034.505238]  [<c0108679>] ? read_tsc+0x9/0x30
[33034.505238]  [<c0139cfb>] ? getnstimeofday+0x3b/0xe0
[33034.505238]  [<c0137576>] ? ktime_get_ts+0x46/0x50
[33034.505238]  [<c0137591>] ? ktime_get+0x11/0x30
[33034.505238]  [<c01369e5>] ? enqueue_hrtimer+0x75/0xf0
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c01b5a31>] ? mnt_drop_write+0x81/0x170
[33034.505238]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505238]  [<c017f819>] ? pagevec_lookup_tag+0x29/0x40
[33034.505238]  [<c019c54f>] ? do_sync_readv_writev+0xaf/0xf0
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c019cce3>] ? do_readv_writev+0x113/0x180
[33034.505238]  [<c01a3670>] ? pipe_write+0x0/0x440
[33034.505238]  [<c01aaa2f>] sys_select+0x3f/0x190
[33034.505238]  [<c0129be4>] ? sigprocmask+0x74/0x100
[33034.505238]  [<c012c7fc>] ? sys_rt_sigprocmask+0xdc/0x110
[33034.505238]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505238]  =======================
[33034.505238] klogd         R [0x00000000] running      0  2244      1
[33034.505238]        f7477ef4 00000086 f7477f6c c019c65c f7f90000  
f7f90254 c0117a30 fea8e52d
[33034.505238]        00001307 c0133b8b 00000001 00000200 f7477f18  
00000000 00000fff f7477f38
[33034.505238]        c0120713 0804d6a0 00000000 00000000 00000000  
f7f90000 c01338f0 f7477f14
[33034.505238] Call Trace:
[33034.505238]  [<c019c65c>] ? do_sync_write+0xcc/0x110
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505238]  [<c0120713>] do_syslog+0x403/0x490
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505238]  [<c01dad15>] kmsg_read+0x25/0x50
[33034.505238]  [<c01dacf0>] ? kmsg_read+0x0/0x50
[33034.505238]  [<c01d1d8c>] proc_reg_read+0x6c/0xc0
[33034.505238]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505238]  [<c01d1d20>] ? proc_reg_read+0x0/0xc0
[33034.505238]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505238]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505238]  =======================
[33034.505238] inetd         S [0x00000001] f793eb60     0  2254      1
[33034.505238]        f7fefb30 00000082 c0117a30 f793eb60 f7f939b0  
f7f93c04 f7fefc00 64b26425
[33034.505238]        00000004 00000000 00000001 00000000 00000006  
00000020 00000000 f7fefb60
[33034.505238]        c03bfff5 f7fefbd0 f7fa0440 f7f20e00 f7fefb54  
c0368657 c03ea300 00000020
[33034.505238] Call Trace:
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505238]  [<c0368657>] ? tcp_poll+0x17/0x160
[33034.505238]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505238]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505238]  [<c0115c48>] ? kunmap_atomic+0x38/0x70
[33034.505238]  [<c017c956>] ? get_page_from_freelist+0x2d6/0x530
[33034.505238]  [<c017cc50>] ? __alloc_pages_internal+0xa0/0x420
[33034.505238]  [<c0198add>] ? kfree+0x9d/0xf0
[33034.505238]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505238]  [<c02a9598>] ? extract_buf+0x88/0xf0
[33034.505238]  [<c0117ac0>] ? add_preempt_count+0x10/0x80
[33034.505238]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505238]  [<c01b5a31>] ? mnt_drop_write+0x81/0x170
[33034.505238]  [<c01b1efd>] ? touch_atime+0x2d/0x110
[33034.505238]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505238]  [<c01794da>] ? filemap_fault+0x12a/0x480
[33034.505238]  [<c0176e24>] ? unlock_page+0x24/0x30
[33034.505238]  [<c018588a>] ? __do_fault+0x17a/0x340
[33034.505239]  [<c018728a>] ? handle_mm_fault+0xfa/0x5f0
[33034.505239]  [<c0113832>] ? do_page_fault+0x2c2/0x670
[33034.505239]  [<c01aaa2f>] sys_select+0x3f/0x190
[33034.505239]  [<c0112497>] ? __ipipe_handle_exception+0xd7/0x1d0
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] nmbd          S [0x00000001] c0128feb     0  2262      1
[33034.505239]        f7fa7b30 00000086 f7fa7b14 c0128feb f7f927f0  
f7f92a44 c0117a30 f7fa7b40
[33034.505239]        f7fa7b30 c012917f 00000000 00000200 f7fa7b40  
01f37ed4 00000000 f7fa7b60
[33034.505239]        c03bffc7 f74ead00 f7fa7bd0 c056fdb8 c056fdb8  
01f37ed4 c0128dd0 f7f927f0
[33034.505239] Call Trace:
[33034.505239]  [<c0128feb>] ? lock_timer_base+0x4b/0xa0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c012917f>] ? __mod_timer+0xaf/0xf0
[33034.505239]  [<c03bffc7>] schedule_timeout+0x47/0xc0
[33034.505239]  [<c0128dd0>] ? process_timeout+0x0/0x10
[33034.505239]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505239]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c0362941>] ? ip_dev_loopback_xmit+0x51/0x90
[33034.505239]  [<c0362e85>] ? ip_mc_output+0xb5/0xf0
[33034.505239]  [<c0360f3b>] ? ip_cork_release+0x2b/0x40
[33034.505239]  [<c03611ea>] ? ip_push_pending_frames+0x29a/0x370
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c037cb6d>] ? udp_push_pending_frames+0x1ad/0x3e0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0124ab5>] ? local_bh_enable+0x35/0x90
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c0198add>] ? kfree+0x9d/0xf0
[33034.505239]  [<c0340caa>] ? memcpy_toiovec+0x4a/0x70
[33034.505239]  [<c033ecec>] ? skb_release_data+0x5c/0x90
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c033ecec>] ? skb_release_data+0x5c/0x90
[33034.505239]  [<c033eb9c>] ? __kfree_skb+0x3c/0x90
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0124ab5>] ? local_bh_enable+0x35/0x90
[33034.505239]  [<c033afc9>] ? release_sock+0xb9/0xd0
[33034.505239]  [<c037e9e4>] ? udp_recvmsg+0x184/0x300
[33034.505239]  [<c033aa23>] ? sock_common_recvmsg+0x43/0x60
[33034.505239]  [<c0338fb6>] ? sock_recvmsg+0xc6/0xf0
[33034.505239]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505239]  [<c0346179>] ? netdev_run_todo+0x29/0x270
[33034.505239]  [<c0343a0d>] ? __dev_get_by_name+0x8d/0xb0
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c01abbd1>] ? locks_free_lock+0x31/0x50
[33034.505239]  [<c01abbd1>] ? locks_free_lock+0x31/0x50
[33034.505239]  [<c01abeec>] ? __posix_lock_file+0x6c/0x550
[33034.505239]  [<c0385199>] ? inet_sock_destruct+0xe9/0x1f0
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c01abbd1>] ? locks_free_lock+0x31/0x50
[33034.505239]  [<c01abbd1>] ? locks_free_lock+0x31/0x50
[33034.505239]  [<c01aaac4>] sys_select+0xd4/0x190
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] smbd          S [0x00000001] f74e1b0c     0  2264      1
[33034.505239]        f74e1b30 00000082 f794d0e0 f74e1b0c f7f92c60  
f7f92eb4 c0117a30 f74e1c1c
[33034.505239]        f74e1b2c c0133c22 00000200 00000002 00000015  
00100000 00000000 f74e1b60
[33034.505239]        c03bfff5 f74b0180 f74e1bd0 f74b0180 f7cf5e00  
f74e1b60 c01a2b5f 00000000
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c01a2b5f>] ? pipe_poll+0x2f/0xb0
[33034.505239]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505239]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02a9598>] ? extract_buf+0x88/0xf0
[33034.505239]  [<c02a9598>] ? extract_buf+0x88/0xf0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0108679>] ? read_tsc+0x9/0x30
[33034.505239]  [<c0139cfb>] ? getnstimeofday+0x3b/0xe0
[33034.505239]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505239]  [<c01794da>] ? filemap_fault+0x12a/0x480
[33034.505239]  [<c013d146>] ? clockevents_program_event+0xb6/0x120
[33034.505239]  [<c0176e24>] ? unlock_page+0x24/0x30
[33034.505239]  [<c018588a>] ? __do_fault+0x17a/0x340
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c018728a>] ? handle_mm_fault+0xfa/0x5f0
[33034.505239]  [<c010f1c0>] ? smp_apic_timer_interrupt+0x0/0x70
[33034.505239]  [<c0113832>] ? do_page_fault+0x2c2/0x670
[33034.505239]  [<c01aaa2f>] sys_select+0x3f/0x190
[33034.505239]  [<c0112497>] ? __ipipe_handle_exception+0xd7/0x1d0
[33034.505239]  [<c0111f41>] ? __ipipe_handle_irq+0x81/0x1a0
[33034.505239]  [<c01a8b5f>] ? do_fcntl+0x28f/0x300
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] smbd          S [0x00000001] f757dfb0     0  2274   2264
[33034.505239]        f757dfa8 00000086 c014c146 f757dfb0 f7c967f0  
f7c96a44 f74b0a80 1e46bbf3
[33034.505239]        00000005 00000000 0000000e f757dfb0 00000000  
00000001 00000003 f757dfb0
[33034.505239]        c012bd13 f757c000 c01030d5 00000000 00000019  
0a201fd8 00000001 00000003
[33034.505239] Call Trace:
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c012bd13>] sys_pause+0x13/0x20
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] sshd          S [0x00000001] f793eb60     0  2279      1
[33034.505239]        f74dfb30 00000082 c0117a30 f793eb60 f7c97540  
f7c97794 f74dfc00 f0367a07
[33034.505239]        00001e07 00000000 00000001 00000000 00000005  
00000010 00000000 f74dfb60
[33034.505239]        c03bfff5 f74dfbd0 f7fa1540 f75ab580 f74dfb54  
c0368657 c03ea300 00000010
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0368657>] ? tcp_poll+0x17/0x160
[33034.505239]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505239]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c01f21ff>] ? __ext3_journal_dirty_metadata+0x1f/0x50
[33034.505239]  [<c01e5aa1>] ? ext3_mark_iloc_dirty+0x181/0x350
[33034.505239]  [<c01e5fbe>] ? ext3_reserve_inode_write+0x5e/0x80
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0108679>] ? read_tsc+0x9/0x30
[33034.505239]  [<c0139cfb>] ? getnstimeofday+0x3b/0xe0
[33034.505239]  [<c0296228>] ? number+0x288/0x2a0
[33034.505239]  [<c0154b11>] ? xnarch_next_htick_shot+0x51/0x60
[33034.505239]  [<c013d146>] ? clockevents_program_event+0xb6/0x120
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0296b21>] ? vsnprintf+0x371/0x6d0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0115c48>] ? kunmap_atomic+0x38/0x70
[33034.505239]  [<c017c956>] ? get_page_from_freelist+0x2d6/0x530
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c017c8a7>] ? get_page_from_freelist+0x227/0x530
[33034.505239]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0137365>] ? hrtimer_start+0xc5/0x180
[33034.505239]  [<c011994e>] ? hrtick_set+0xbe/0x1a0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01969a5>] ? add_partial+0x45/0x80
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c019803b>] ? __slab_free+0x5b/0x2f0
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c0198add>] ? kfree+0x9d/0xf0
[33034.505239]  [<c01a313c>] ? __free_pipe_info+0x3c/0x50
[33034.505239]  [<c01a313c>] ? __free_pipe_info+0x3c/0x50
[33034.505239]  [<c01a313c>] ? __free_pipe_info+0x3c/0x50
[33034.505239]  [<c01a3161>] ? free_pipe_info+0x11/0x20
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c029101d>] ? _atomic_dec_and_lock+0x2d/0x50
[33034.505239]  [<c01aaa2f>] sys_select+0x3f/0x190
[33034.505239]  [<c019dc58>] ? fput+0x18/0x20
[33034.505239]  [<c019abe7>] ? filp_close+0x47/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] proftpd       S [0x00000001] c0128feb     0  2366      1
[33034.505239]        f7487b30 00200086 f7487b14 c0128feb f7c8a380  
f7c8a5d4 c0117a30 f7487b40
[33034.505239]        f7487b30 c012917f 00000000 00000200 f7487b40  
01f3e58d 00000000 f7487b60
[33034.505239]        c03bffc7 f7487bd0 f7fa1980 c056fe40 c04ace90  
01f3e58d c0128dd0 f7c8a380
[33034.505239] Call Trace:
[33034.505239]  [<c0128feb>] ? lock_timer_base+0x4b/0xa0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c012917f>] ? __mod_timer+0xaf/0xf0
[33034.505239]  [<c03bffc7>] schedule_timeout+0x47/0xc0
[33034.505239]  [<c0128dd0>] ? process_timeout+0x0/0x10
[33034.505239]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505239]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011cb92>] ? check_preempt_wakeup+0x62/0xb0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c011a3f8>] ? try_to_wake_up+0x58/0x130
[33034.505239]  [<c0108679>] ? read_tsc+0x9/0x30
[33034.505239]  [<c0139cfb>] ? getnstimeofday+0x3b/0xe0
[33034.505239]  [<c0137576>] ? ktime_get_ts+0x46/0x50
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01bfae7>] ? __find_get_block_slow+0x67/0x110
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01bfeeb>] ? __find_get_block+0x8b/0x1c0
[33034.505239]  [<c01f2514>] ? __journal_file_buffer+0x74/0x160
[33034.505239]  [<c01f2b92>] ? do_get_write_access+0x1d2/0x440
[33034.505239]  [<c01f2514>] ? __journal_file_buffer+0x74/0x160
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01f41ff>] ? journal_dirty_metadata+0x7f/0x120
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c011c39c>] ? __wake_up+0x6c/0xa0
[33034.505239]  [<c01f28a3>] ? journal_stop+0x123/0x240
[33034.505239]  [<c01f28a3>] ? journal_stop+0x123/0x240
[33034.505239]  [<c01edcd7>] ? __ext3_journal_stop+0x27/0x50
[33034.505239]  [<c01e8df0>] ? ext3_dirty_inode+0x60/0x80
[33034.505239]  [<c01bc19c>] ? __mark_inode_dirty+0x2c/0x1a0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01aee28>] ? __d_lookup+0xc8/0x180
[33034.505239]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c029101d>] ? _atomic_dec_and_lock+0x2d/0x50
[33034.505239]  [<c01b4476>] ? mntput_no_expire+0x16/0x100
[33034.505239]  [<c01a4530>] ? path_put+0x20/0x30
[33034.505239]  [<c01a691b>] ? path_walk+0x4b/0x90
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c01a7646>] ? __user_walk_fd+0x46/0x60
[33034.505239]  [<c01a7646>] ? __user_walk_fd+0x46/0x60
[33034.505239]  [<c01a019e>] ? vfs_lstat_fd+0x1e/0x50
[33034.505239]  [<c01369e5>] ? enqueue_hrtimer+0x75/0xf0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0137365>] ? hrtimer_start+0xc5/0x180
[33034.505239]  [<c01aaac4>] sys_select+0xd4/0x190
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] cron          S [0x00000001] 00000001     0  2378      1
[33034.505239]        f74c7f3c 00000082 c0117a30 00000001 f7c8b0d0  
f7c8b324 dbcd4aab 00001e04
[33034.505239]        c0478454 00000000 00000200 00000000 f74c7f5c  
f7c8b0d0 f74c7f5c f74c7f50
[33034.505239]        c03c0725 00000001 00000000 00000001 f74c7f98  
c0137462 bfea85e4 f741de41
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03c0725>] do_nanosleep+0x65/0x90
[33034.505239]  [<c0137462>] hrtimer_nanosleep+0x42/0xb0
[33034.505239]  [<c0136e50>] ? hrtimer_wakeup+0x0/0x20
[33034.505239]  [<c0137528>] sys_nanosleep+0x58/0x60
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] xdm           S [0x00000001] 00000200     0  2400      1
[33034.505239]        f7497b30 00000086 c0133c22 00000200 f7c88d50  
f7c88fa4 f7497bd0 f7497b2c
[33034.505239]        c01aa97d f798b918 f74d4580 f756d400 00000005  
00000010 00000000 f7497b60
[33034.505239]        c03bfff5 f74d4580 f7497b54 c037c7b2 00497b54  
c03ea360 00000010 f74d4580
[33034.505239] Call Trace:
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c01aa97d>] ? __pollwait+0x6d/0xe0
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c037c7b2>] ? udp_poll+0x12/0x100
[33034.505239]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505239]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c0115c48>] ? kunmap_atomic+0x38/0x70
[33034.505239]  [<c017c956>] ? get_page_from_freelist+0x2d6/0x530
[33034.505239]  [<c017cc50>] ? __alloc_pages_internal+0xa0/0x420
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01bfeeb>] ? __find_get_block+0x8b/0x1c0
[33034.505239]  [<c01338df>] ? wake_up_bit+0x1f/0x30
[33034.505239]  [<c01f2b92>] ? do_get_write_access+0x1d2/0x440
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01f41ff>] ? journal_dirty_metadata+0x7f/0x120
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c011c39c>] ? __wake_up+0x6c/0xa0
[33034.505239]  [<c01f28a3>] ? journal_stop+0x123/0x240
[33034.505239]  [<c01f28a3>] ? journal_stop+0x123/0x240
[33034.505239]  [<c01edcd7>] ? __ext3_journal_stop+0x27/0x50
[33034.505239]  [<c01e8df0>] ? ext3_dirty_inode+0x60/0x80
[33034.505239]  [<c010311c>] ? restore_nocheck_notrace+0x0/0xe
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0117ac0>] ? add_preempt_count+0x10/0x80
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01b5a31>] ? mnt_drop_write+0x81/0x170
[33034.505239]  [<c01b1efd>] ? touch_atime+0x2d/0x110
[33034.505239]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c017c45b>] ? free_hot_cold_page+0x15b/0x1e0
[33034.505239]  [<c017c52a>] ? free_hot_page+0xa/0x10
[33034.505239]  [<c017fff4>] ? put_page+0x34/0x110
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0185e91>] ? unmap_vmas+0x291/0x480
[33034.505239]  [<c0186e46>] ? free_pgtables+0x86/0xb0
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c01893d7>] ? remove_vma+0x47/0x60
[33034.505239]  [<c01aaa2f>] sys_select+0x3f/0x190
[33034.505239]  [<c012a113>] ? sys_rt_sigaction+0x63/0xa0
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] login         S [0x00000001] f7553f2c     0  2412      1
[33034.505239]        f7553f20 00000082 f74aa140 f7553f2c f7f548e0  
f7f54b34 f7553f08 c0117a30
[33034.505239]        f7553f70 f7553f20 c0133c22 00000200 ffffffea  
f7f548d8 00000004 f7553f90
[33034.505239]        c01221e5 f7f91f10 f7553f78 c0113832 00000001  
00000000 f7f54ac8 00000000
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c01221e5>] do_wait+0x5d5/0xbd0
[33034.505239]  [<c0113832>] ? do_page_fault+0x2c2/0x670
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c012284f>] sys_wait4+0x6f/0xc0
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] getty         S [0x00000001] f7493800     0  2414      1
[33034.505239]        f760feb0 00000086 f7458dc0 f7493800 f7f55aa0  
f7f55cf4 c17ec760 2dd8d213
[33034.505239]        00000006 00000000 f760fea8 c0117a30 00000001  
f7479c00 00000000 f760fee0
[33034.505239]        c03bfff5 00000000 f760fec8 c0117a30 f760ff20  
f760fee0 c0133c22 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c02b193b>] read_chan+0x1bb/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] getty         S [0x00000001] f7493c00     0  2416      1
[33034.505239]        f7451eb0 00000082 f75508f0 f7493c00 f7f56c60  
f7f56eb4 c17ec760 2dd8d215
[33034.505239]        00000006 00000000 f7451ea8 c0117a30 00000001  
f7479400 00000000 f7451ee0
[33034.505239]        c03bfff5 00000000 f7451ec8 c0117a30 f7451f20  
f7451ee0 c0133c22 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c02b193b>] read_chan+0x1bb/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] getty         S [0x00000001] f7493e00     0  2418      1
[33034.505239]        f7539eb0 00000082 f7550630 f7493e00 f7f55630  
f7f55884 c17ec760 2dd8d217
[33034.505239]        00000006 00000000 f7539ea8 c0117a30 00000001  
f7479800 00000000 f7539ee0
[33034.505239]        c03bfff5 00000000 f7539ec8 c0117a30 f7539f20  
f7539ee0 c0133c22 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c02b193b>] read_chan+0x1bb/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] getty         S [0x00000001] f7fb5280     0  2419      1
[33034.505239]        f74e5eb0 00000086 f7d152c0 f7fb5280 f7f54000  
f7f54254 c17ec760 2dd8d219
[33034.505239]        00000006 00000000 f74e5ea8 c0117a30 00000001  
f74c5400 00000000 f74e5ee0
[33034.505239]        c03bfff5 00000000 f74e5ec8 c0117a30 f74e5f20  
f74e5ee0 c0133c22 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c02b193b>] read_chan+0x1bb/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] getty         S [0x00000001] f7fb5d00     0  2420      1
[33034.505239]        f749feb0 00000082 f7d15420 f7fb5d00 f7f57540  
f7f57794 c17ec760 2dd8d21a
[33034.505239]        00000006 f749fea4 f749fea8 c0117a30 00000001  
f75d2800 00000000 f749fee0
[33034.505239]        c03bfff5 00000000 f749fec8 c0117a30 f749ff20  
f749fee0 c0133c22 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c02b193b>] read_chan+0x1bb/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] bash          S [0x00000001] c00bca60     0  2438   2412
[33034.505239]        f7f6deb0 00000082 f7f6de90 c00bca60 f7f91f10  
f7f92164 0000000e f7f6deb4
[33034.505239]        c02a68a6 0000000e f7f6dea8 c0117a30 00000001  
f7479000 00000000 f7f6dee0
[33034.505239]        c03bfff5 f7f6decc f7f6dec8 c0117a30 f7f6df20  
f7f6dee0 c0133c22 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c02a68a6>] ? vgacon_set_cursor_size+0xc6/0x170
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c02b193b>] read_chan+0x1bb/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] sshd          S [0x00000001] 00000001     0 17390   2279
[33034.505239]        f755db30 00000082 c0117a30 00000001 f7c89f10  
f7c8a164 00000000 00000000
[33034.505239]        c0484da0 00000000 f755db28 c0117a30 00000008  
00000080 00000000 f755db60
[33034.505239]        c03bfff5 f763cc00 c02b0380 f755db60 c02abdd0  
f755dbd0 f763cc10 00000104
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c02b0380>] ? normal_poll+0x0/0x150
[33034.505239]  [<c02abdd0>] ? tty_poll+0x70/0x80
[33034.505239]  [<c01aa2b4>] do_select+0x494/0x590
[33034.505239]  [<f88b6bc1>] ? ieee80211_skb_resize+0x61/0xc0 [mac80211]
[33034.505239]  [<c01aa910>] ? __pollwait+0x0/0xe0
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c0362516>] ? ip_finish_output+0x116/0x2b0
[33034.505239]  [<c0362f24>] ? ip_output+0x64/0x80
[33034.505239]  [<c0360e38>] ? ip_local_out+0x18/0x20
[33034.505239]  [<c03630fd>] ? ip_queue_xmit+0x1bd/0x320
[33034.505239]  [<c0137576>] ? ktime_get_ts+0x46/0x50
[33034.505239]  [<c0137591>] ? ktime_get+0x11/0x30
[33034.505239]  [<c01172cb>] ? hrtick_start_fair+0xeb/0x140
[33034.505239]  [<c0378230>] ? tcp_v4_send_check+0x40/0xd0
[33034.505239]  [<c037317e>] ? tcp_transmit_skb+0x3ae/0x770
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c012917f>] ? __mod_timer+0xaf/0xf0
[33034.505239]  [<c037290f>] ? tcp_init_tso_segs+0x3f/0x60
[33034.505239]  [<c0374a5a>] ? __tcp_push_pending_frames+0x2ea/0x750
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0124ab5>] ? local_bh_enable+0x35/0x90
[33034.505239]  [<c033afc9>] ? release_sock+0xb9/0xd0
[33034.505239]  [<c0369aca>] ? tcp_sendmsg+0x75a/0xa40
[33034.505239]  [<c01aa59a>] core_sys_select+0x1ea/0x320
[33034.505239]  [<c03383db>] ? sock_aio_write+0xeb/0x110
[33034.505239]  [<c019c65c>] ? do_sync_write+0xcc/0x110
[33034.505239]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505239]  [<c0124226>] ? current_fs_time+0x16/0x20
[33034.505239]  [<c01aaa2f>] sys_select+0x3f/0x190
[33034.505239]  [<c019d46d>] ? sys_write+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] bash          S [0x00000001] c0137365     0 17392  17390
[33034.505239]        f7499eb0 00000082 f7499ea8 c0137365 f7c8ac60  
f7c8aeb4 c0478454 38c98c11
[33034.505239]        00000bea 00000000 c04ee300 3965f5d5 00000001  
f763c400 00000000 f7499ee0
[33034.505239]        c03bfff5 ffffffff f7499ec8 c0117a30 f7499f20  
f7499ee0 c0133c22 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c0137365>] ? hrtimer_start+0xc5/0x180
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c02b193b>] read_chan+0x1bb/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] remoteHost    S [0x00000001] 000084d0     0 17405  17392
[33034.505239]        f76a1e34 00000086 f7f54470 000084d0 f7f54470  
f7f546c4 c047efe0 00000001
[33034.505239]        00000044 000280d0 000284d0 c047efe0 f7fa3b80  
00000000 7fffffff f76a1e64
[33034.505239]        c03bfff5 c0117a30 f7fa3b80 f76a1e4c c0124ab5  
f76a1e64 c033afc9 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0124ab5>] ? local_bh_enable+0x35/0x90
[33034.505239]  [<c033afc9>] ? release_sock+0xb9/0xd0
[33034.505239]  [<c0366c69>] inet_csk_accept+0x119/0x250
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505239]  [<c038501f>] inet_accept+0x1f/0xb0
[33034.505239]  [<c033a093>] sys_accept+0xd3/0x1c0
[33034.505239]  [<c01874e2>] ? handle_mm_fault+0x352/0x5f0
[33034.505239]  [<c0113832>] ? do_page_fault+0x2c2/0x670
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfa9f>] ? preempt_schedule+0x4f/0x60
[33034.505239]  [<c011cd5b>] ? wake_up_new_task+0xbb/0xc0
[33034.505239]  [<c033a241>] sys_socketcall+0xc1/0x260
[33034.505239]  [<c019abe7>] ? filp_close+0x47/0x70
[33034.505239]  [<c019c1db>] ? sys_close+0x7b/0xf0
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] remoteHost    S [0x00000001] c76f2ef7     0 17406  17405
[33034.505239]        f769bf08 00000082 f7627780 c76f2ef7 f7f567f0  
f7f56a44 f769bef0 c7098ee0
[33034.505239]        0000137d 00000000 c0133c22 00000200 ffffffea  
f7f567e8 00000004 f769bf78
[33034.505239]        c01221e5 f7ce4470 f7627780 f7634bf8 f7f56a48  
00000000 f7f569d8 f764e7c0
[33034.505239] Call Trace:
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c01221e5>] do_wait+0x5d5/0xbd0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03bfa9f>] ? preempt_schedule+0x4f/0x60
[33034.505239]  [<c011cd5b>] ? wake_up_new_task+0xbb/0xc0
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c012284f>] sys_wait4+0x6f/0xc0
[33034.505239]  [<c01228c5>] sys_waitpid+0x25/0x30
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] remoteHost    S [0x00000001] f7fa2640     0 17407  17405
[33034.505239]        f7643ce0 00000082 f7650840 f7fa2640 f7f55f10  
f7f56164 00000000 f7fa2640
[33034.505239]        f7643cf4 c037215d c014c146 bff74101 f7643d70  
f7fa2640 f7fa26a0 f7643d10
[33034.505239]        c03bfff5 c0117a30 f7643d70 f7643cf8 c0124ab5  
f7643d10 c033afc9 00000200
[33034.505239] Call Trace:
[33034.505239]  [<c037215d>] ? tcp_rcv_established+0x40d/0x6c0
[33034.505239]  [<c014c146>] ? __ipipe_restore_root+0x16/0x20
[33034.505239]  [<c03bfff5>] schedule_timeout+0x75/0xc0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0124ab5>] ? local_bh_enable+0x35/0x90
[33034.505239]  [<c033afc9>] ? release_sock+0xb9/0xd0
[33034.505239]  [<c033ba69>] sk_wait_data+0x79/0xb0
[33034.505239]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505239]  [<c036a12e>] tcp_recvmsg+0x37e/0x820
[33034.505239]  [<c033aa23>] sock_common_recvmsg+0x43/0x60
[33034.505239]  [<c0338fb6>] sock_recvmsg+0xc6/0xf0
[33034.505239]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0185204>] ? do_wp_page+0x1e4/0x490
[33034.505239]  [<c019950a>] ? kmem_cache_free+0x8a/0xd0
[33034.505239]  [<c029101d>] ? _atomic_dec_and_lock+0x2d/0x50
[33034.505239]  [<c0129d8e>] ? __sigqueue_free+0x2e/0x40
[33034.505239]  [<c012a229>] ? __dequeue_signal+0xd9/0x180
[33034.505239]  [<c0338930>] ? sockfd_lookup_light+0x30/0x60
[33034.505239]  [<c0339e0d>] sys_recvfrom+0x7d/0xd0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0185204>] ? do_wp_page+0x1e4/0x490
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c01874e2>] ? handle_mm_fault+0x352/0x5f0
[33034.505239]  [<c0339e92>] sys_recv+0x32/0x40
[33034.505239]  [<c033a2d8>] sys_socketcall+0x158/0x260
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] rt61pci       S [0x00000001] c0117a30     0 27579      2
[33034.505239]        f76e5fa4 00000046 f76e5f7c c0117a30 f7ce70d0  
f7ce7324 c0117a30 f7ce70d0
[33034.505239]        f76e5fa4 c0133b8b 00000001 00000200 f764ef80  
f764ef88 f76e5fac f76e5fcc
[33034.505239]        c01307f5 00000000 f7ce70d0 c01338f0 f764ef88  
f764ef88 fffffffc f764ef80
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133b8b>] ? prepare_to_wait+0x7b/0xb0
[33034.505239]  [<c01307f5>] worker_thread+0x95/0xb0
[33034.505239]  [<c01338f0>] ? autoremove_wake_function+0x0/0x50
[33034.505239]  [<c0130760>] ? worker_thread+0x0/0xb0
[33034.505239]  [<c01335a2>] kthread+0x42/0x70
[33034.505239]  [<c0133560>] ? kthread+0x0/0x70
[33034.505239]  [<c0103d43>] kernel_thread_helper+0x7/0x14
[33034.505239]  =======================
[33034.505239] actuatorTask  ? [0x00000040] 00000001     0 28213      1
[33034.505239]        f760df54 00000046 c0198b26 00000001 f7ce48e0  
f7ce4b34 f765a540 c6b973df
[33034.505239]        0000137d 00000000 f7ce48d8 f7ce48e0 00000010  
f7ce48e0 f760ddd8 f760df98
[33034.505239]        c0122e14 c04ee300 00000000 f7ce51c0 00000001  
f760df84 f7ce4a84 f7ce4ac8
[33034.505239] Call Trace:
[33034.505239]  [<c0198b26>] ? kfree+0xe6/0xf0
[33034.505239]  [<c0122e14>] do_exit+0x494/0x710
[33034.505239]  [<c01230be>] do_group_exit+0x2e/0xb0
[33034.505239]  [<c012314f>] sys_exit_group+0xf/0x20
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] Actuator Aper S [0x00000201] f7f01f04     0 28214      1
[33034.505239]        f7f01f28 00000086 c057be64 f7f01f04 f7ce51c0  
f7ce5414 f7f01f28 ce2e19e5
[33034.505239]        0000137c 00000000 00000001 00000200 f7d80620  
f7ce51c0 c01586e0 f7f01f4c
[33034.505239]        c0158576 f7f01f6c c015891a 00000000 f7f01ebc  
00000006 00000000 c01586e0
[33034.505239] Call Trace:
[33034.505239]  [<c01586e0>] ? losyscall_event+0x0/0x180
[33034.505239]  [<c0158576>] xnshadow_harden+0x86/0x1f0
[33034.505239]  [<c015891a>] ? hisyscall_event+0xba/0x290
[33034.505239]  [<c01586e0>] ? losyscall_event+0x0/0x180
[33034.505239]  [<c015876f>] losyscall_event+0x8f/0x180
[33034.505239]  [<c01586e0>] ? losyscall_event+0x0/0x180
[33034.505239]  [<c014c89c>] __ipipe_dispatch_event+0x9c/0x170
[33034.505239]  [<c01122f2>] __ipipe_syscall_root+0x42/0x110
[33034.505239]  [<c01030ad>] system_call+0x29/0x4a
[33034.505239]  =======================
[33034.505239] sh            S [0x00000001] 39eff3e0     0 28229  17406
[33034.505239]        f7665f08 00000082 f74bba80 39eff3e0 f7ce4470  
f7ce46c4 f7665ef0 c0117a30
[33034.505239]        f7665f58 f7665f08 c0133c22 00000200 ffffffea  
f7ce4468 00000004 f7665f78
[33034.505239]        c01221e5 f7c2f0d0 f74bba80 f7506bfc f7ce46c8  
00000000 f7ce4658 00000000
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0133c22>] ? add_wait_queue+0x62/0xa0
[33034.505239]  [<c01221e5>] do_wait+0x5d5/0xbd0
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c012284f>] sys_wait4+0x6f/0xc0
[33034.505239]  [<c01228c5>] sys_waitpid+0x25/0x30
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] sshd          R [0x00000000] running      0  9641   2279
[33034.505239]        f7523e84 00000086 c011a4db f7523e68 f7c2f540  
f7c2f798 f078bddc 71f337e7
[33034.505239]        00001e0b 00000000 00000000 00000001 00000000  
00000001 00000001 f7523e8c
[33034.505239]        c03bfa95 f7523eb0 c011c3c9 00000000 00000000  
f766e914 00000200 f766e800
[33034.505239] Call Trace:
[33034.505239]  [<c011a4db>] ? default_wake_function+0xb/0x10
[33034.505239]  [<c03bfa95>] preempt_schedule+0x45/0x60
[33034.505239]  [<c011c3c9>] __wake_up+0x99/0xa0
[33034.505239]  [<c02aabd3>] tty_wakeup+0x33/0x70
[33034.505239]  [<c02b30e5>] pty_unthrottle+0x15/0x20
[33034.505239]  [<c02b1eb1>] tty_unthrottle+0x21/0x30
[33034.505239]  [<c02afe05>] check_unthrottle+0x15/0x20
[33034.505239]  [<c02b1b5e>] read_chan+0x3de/0x680
[33034.505239]  [<c011a4d0>] ? default_wake_function+0x0/0x10
[33034.505239]  [<c02ae0a7>] tty_read+0x77/0xb0
[33034.505239]  [<c02b1780>] ? read_chan+0x0/0x680
[33034.505239]  [<c019cfc4>] vfs_read+0x94/0x130
[33034.505239]  [<c02ae030>] ? tty_read+0x0/0xb0
[33034.505239]  [<c019d3fd>] sys_read+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] bash          R [0x00000000] running      0  9645   9641
[33034.505239]        f078bd80 f078bd78 f078bd78 c0117a30 00000031  
f078bda8 c02be55a 00000018
[33034.505239]        00000000 ffffffff c0514e38 00b28ed7 c00bd922  
00000009 c0485fa0 00025d5c
[33034.505239]        00000016 f078bdbc f078bdb8 c0117a30 c0476a58  
f078bdcc c0138047 f078bdcc
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c011fcf1>] ? release_console_sem+0x211/0x250
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c0120125>] ? vprintk+0x1f5/0x3e0
[33034.505239]  [<c0117a00>] ? hrtick_clear+0x0/0x20
[33034.505239]  [<c0120125>] ? vprintk+0x1f5/0x3e0
[33034.505239]  [<c0120a2b>] ? printk+0x13b/0x150
[33034.505239]  [<c010f6ce>] ? touch_nmi_watchdog+0x1e/0x20
[33034.505239]  [<c0104085>] ? print_trace_address+0x45/0x50
[33034.505239]  [<c01313db>] ? __kernel_text_address+0x1b/0x30
[33034.505239]  [<c0104119>] ? dump_trace+0x89/0x120
[33034.505239]  [<c01041d7>] show_trace_log_lvl+0x27/0x50
[33034.505239]  [<c01042b0>] show_stack_log_lvl+0xb0/0xe0
[33034.505239]  [<c0104b07>] show_stack+0x37/0x50
[33034.505239]  [<c0117963>] sched_show_task+0x93/0xd0
[33034.505239]  [<c011c156>] show_state_filter+0x66/0xb0
[33034.505239]  [<c02be96a>] sysrq_handle_showstate+0xa/0x10
[33034.505239]  [<c02bec4d>] __handle_sysrq+0x9d/0x180
[33034.505239]  [<c01d8d80>] ? write_sysrq_trigger+0x0/0x40
[33034.505239]  [<c01d8daf>] write_sysrq_trigger+0x2f/0x40
[33034.505239]  [<c01d1e4c>] proc_reg_write+0x6c/0xc0
[33034.505239]  [<c019ce99>] vfs_write+0x99/0x130
[33034.505239]  [<c01d1de0>] ? proc_reg_write+0x0/0xc0
[33034.505239]  [<c019d46d>] sys_write+0x3d/0x70
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] sleep         S [0x00000001] 00000001     0  9709  28229
[33034.505239]        f07c3f3c 00000082 c0117a30 00000001 f7c2f0d0  
f7c2f324 395d65ee 395d6206
[33034.505239]        00001e0b 00000000 00000200 00000000 f07c3f5c  
f7c2f0d0 f07c3f5c f07c3f50
[33034.505239]        c03c0725 00000001 00000000 00000001 f07c3f98  
c0137462 00000000 f741de40
[33034.505239] Call Trace:
[33034.505239]  [<c0117a30>] ? sub_preempt_count+0x10/0x90
[33034.505239]  [<c03c0725>] do_nanosleep+0x65/0x90
[33034.505239]  [<c0137462>] hrtimer_nanosleep+0x42/0xb0
[33034.505239]  [<c0136e50>] ? hrtimer_wakeup+0x0/0x20
[33034.505239]  [<c0137528>] sys_nanosleep+0x58/0x60
[33034.505239]  [<c01030d5>] syscall_call+0x7/0xb
[33034.505239]  =======================
[33034.505239] Sched Debug Version: v0.07, 2.6.26.5 #5
[33034.505239] now at 33034597.126198 msecs
[33034.505239]   .sysctl_sched_latency                    : 20.000000
[33034.505239]   .sysctl_sched_min_granularity            : 4.000000
[33034.505239]   .sysctl_sched_wakeup_granularity         : 10.000000
[33034.505239]   .sysctl_sched_child_runs_first           : 0.000001
[33034.505239]   .sysctl_sched_features                   : 895
[33034.505239]
[33034.505239] cpu#0, 2000.117 MHz
[33034.505239]   .nr_running                    : 3
[33034.505239]   .load                          : 3072
[33034.505239]   .nr_switches                   : 17842168
[33034.505239]   .nr_load_updates               : 542386
[33034.505239]   .nr_uninterruptible            : 0
[33034.505239]   .jiffies                       : 32734505
[33034.505239]   .next_balance                  : 0.000000
[33034.505239]   .curr->pid                     : 9645
[33034.505239]   .clock                         : 33034505.238505
[33034.505239]   .cpu_load[0]                   : 0
[33034.505239]   .cpu_load[1]                   : 0
[33034.505239]   .cpu_load[2]                   : 57
[33034.505239]   .cpu_load[3]                   : 304
[33034.505239]   .cpu_load[4]                   : 538
[33034.505239]
[33034.505239] cfs_rq[0]:
[33034.505239]   .exec_clock                    : 1886543.312516
[33034.505239]   .MIN_vruntime                  : 2038080.995791
[33034.505239]   .min_vruntime                  : 2038100.995791
[33034.505239]   .max_vruntime                  : 2038100.995791
[33034.505239]   .spread                        : 20.000000
[33034.505239]   .spread0                       : 0.000000
[33034.505239]   .nr_running                    : 3
[33034.505239]   .load                          : 3072
[33034.505239]   .bkl_count                     : 116440
[33034.505239]   .nr_spread_over                : 17371
[33034.505239]
[33034.505239] runnable tasks:
[33034.505239]             task   PID         tree-key  switches   
prio     exec-runtime         sum-exec        sum-sleep
[33034.505239]  
----------------------------------------------------------------------------------------------------------
[33034.505239]            klogd  2244   2038080.995791      1243    
120   2038080.995791        97.397021  33015637.631792
[33034.505239]             sshd  9641   2038100.995791       143    
120   2038100.995791        86.680879     15122.725577
[33034.505239] R           bash  9645   2038080.995791        45    
120   2038080.995791         4.542348     15003.827423
[33034.505239]


----- dump ends here -----


On Dec 22, 2008, at 3:03 PM, Gilles Chanteperdrix wrote:

> Mehmet Alphan Ulusoy wrote:
>> On Mon 22 Dec 2008 11:48:00 EET, Gilles Chanteperdrix wrote:
>>> What would be really interesting too, is to have the process  
>>> status. So,
>>> in function sched_show_task, file kernel/sched.c, could you try and
>>> print p->state in hexadecimal? In the dump you sent, the state is  
>>> shown
>>> as a question mark, so we do not really know in what state the  
>>> task is.
>>>
>>
>> The output of the sched says the task is 'relaxed shadow', I believe
>> what you ask for is something else. I will try to make the change you
>> suggested and hopefully send you the dump once the task turns into a
>> zombie.
>
> Unless I misunderstood something, the zombie task (called  
> actuatorTask)
> does not appear in /proc/xenomai/sched and /proc/xenomai/stat, the  
> task
> which appears there is "Actuator Aperiodic Task". actuatorTask,  
> however,
> appears in the sysrq+T output, and its state (for Linux scheduler, not
> for xenomai scheduler, since for xenomai scheduler it does not even
> exist) is "?", so, what I would like to know is its real state,  
> printed
> in hexadecimal. For this, you just have to print p->state using 0x%08x
> as printk format.
>
> -- 
>                                                 Gilles.
>


--Apple-Mail-30-448409988
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
MQ8XDTA4MTIyMzA1NDYzN1owIwYJKoZIhvcNAQkEMRYEFC/npwSxJecfMnP7ySkKLSmGVk0sMIGF
BgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQWVsRulyu1HASB5MPpvv9RjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQWVsRulyu1HASB5MPpvv9RjANBgkqhkiG9w0BAQEF
AASCAQAcvvP/ErbHlsqb1v81GNQ36jLRsMJGVrZvnU2cP4D/WJLFt86jzk9P7MZv5/CfS6hEh+Y3
1kbvsOET0v91GOO9dj2gZEZMSnmiJD1QblpiPNtiLcfABuB+4vbx7ajSFGejEi2fOZjcaTuv25Hc
XezTjCdA6r2hEe8dEr3v54A3zmqxXXg4q/IdWVviOlhZL6FSw3/6P4xZPOmfQqSKaw+XUoQf2cC2
7buEymvthkK7+Y/KNE3pA+UG9i2bX1x0wzoSrmLhOhAjm0Nx50mB2bVLx31NnkDbeDU0ITmmD3ks
z7OetOi8jO7J66WrYY8kCKKU9j5QC7G4dBnwhp7fcoUPAAAAAAAA

--Apple-Mail-30-448409988--

