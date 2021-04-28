From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: gdb  test failure debug status update 
Date: Wed, 28 Apr 2021 03:19:26 +0000
Message-ID: <DM5PR11MB18525F69E34389DE7A8EE49BF2409@DM5PR11MB1852.namprd11.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


According to my validation, gdb test fail on dovetail 5.10 branch but pass =
on v5.9-evl4 tag with same for-upstream/dovetail
xenomai code base.

After further debug , the issue is more clear for me. Gdb test failure beca=
use low priority thread smokey  userspace  is still
executed after "cobalt_shadow_relaxed: state=3D0x4488c0 info=3D0x200"  like=
 log [1] on dovetail-5.10 branch.
The weird thing is that its following first ftrace log  happen at 62235.848=
583 after cobalt_shadow_relaxed in log [1].
It is almost 3ms happened after cobalt_shadow_relaxed. The low priority smo=
ke thread user space is executed during this
3ms period so that test fail.

But in success case with v5.9-evl4 like in  log [2], the time interval betw=
een cobalt_shadow_relaxed and the following first ftrace log
is only about 1us. It seems that low priority smokey userspace do not have =
chance to execute in this 1us because gdb test is successful.

My question is why there is even no interrupt happened during that about 3m=
s period in failure case?  Tick seems in abnormal behavior.
Please comment if you have any ideas to further debug it.

PS: All my tests run on same up Xtream board.

1:
          smokey-2024    [000] ..s1 62235.845648: softirq_exit: vec=3D6 [ac=
tion=3DTASKLET]
          smokey-2024    [000] d.s2 62235.845648: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x312
          smokey-2024    [000] d.s1 62235.845648: irq_disable: caller=3D__d=
o_softirq+0x280/0x428 parent=3D0x0
          smokey-2024    [000] d.s2 62235.845648: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x312
          smokey-2024    [000] *..2 62235.845649: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x312
          smokey-2024    [000] *..1 62235.845649: irq_enable: caller=3Dsync=
_current_irq_stage+0x259/0x280 parent=3D0x0
          smokey-2024    [000] *..2 62235.845649: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x312
          smokey-2024    [000] ...1 62235.845650: cobalt_shadow_relaxed: st=
ate=3D0x4488c0 info=3D0x200
          smokey-2024    [000] *..1 62235.848583: irq_disable: caller=3Dirq=
entry_enter+0x40/0xe0 parent=3D0x0
          smokey-2024    [000] *.~1 62235.848583: irq_pipeline_entry: irq=
=3D4354
          smokey-2024    [000] *.~1 62235.848584: irq_handler_entry: irq=3D=
4354 name=3DOut-of-band LAPIC timer interrupt
          smokey-2024    [000] *.~1 62235.848584: local_timer_entry: vector=
=3D236
          smokey-2024    [000] *.~1 62235.848585: cobalt_timer_expire: time=
r=3D000000002aae459f
          smokey-2024    [000] *.~1 62235.848585: local_timer_exit: vector=
=3D236
          smokey-2024    [000] *.~1 62235.848585: irq_handler_exit: irq=3D4=
354 ret=3Dhandled
          smokey-2024    [000] *.~1 62235.848585: irq_pipeline_exit: irq=3D=
4354
          smokey-2024    [000] *.~1 62235.848586: irq_enable: caller=3Darch=
_pipeline_entry+0x4e/0xc0 parent=3D0x0
          smokey-2024    [000] *..2 62235.848586: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x312
          smokey-2024    [000] *..1 62235.848586: irq_disable: caller=3Dsyn=
c_current_irq_stage+0x246/0x280 parent=3D0x0
          smokey-2024    [000] *..2 62235.848586: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x312
          smokey-2024    [000] d.h1 62235.848587: irq_handler_entry: irq=3D=
124 name=3Dproxy tick
          smokey-2024    [000] d.h2 62235.848587: lock_acquire: 000000004fe=
f83e9 hrtimer_bases.lock
          smokey-2024    [000] d.h2 62235.848588: lock_acquire: 00000000ed2=
aa56a read tk_core.seq.seqcount
          smokey-2024    [000] d.h2 62235.848588: lock_release: 00000000ed2=
aa56a tk_core.seq.seqcount
          smokey-2024    [000] d.h2 62235.848588: hrtimer_cancel: hrtimer=
=3D000000009dcbf7ab
          smokey-2024    [000] d.h2 62235.848588: lock_release: 000000004fe=
f83e9 hrtimer_bases.lock
          smokey-2024    [000] d.h1 62235.848589: hrtimer_expire_entry: hrt=
imer=3D000000009dcbf7ab function=3Dtick_sched_timer now=3D62232458752330
          smokey-2024    [000] d.h1 62235.848589: lock_acquire: 00000000ed2=
aa56a read tk_core.seq.seqcount
          smokey-2024    [000] d.h1 62235.848589: lock_release: 00000000ed2=
aa56a tk_core.seq.seqcount
          smokey-2024    [000] d.h2 62235.848590: lock_acquire: 00000000228=
6d635 jiffies_lock
          smokey-2024    [000] d.h2 62235.848590: lock_acquire: 00000000717=
4a29a (null)
          smokey-2024    [000] d.h2 62235.848590: lock_release: 00000000717=
4a29a (null)


[2] :
         smokey-703     [000] d.s2  5674.404286: rcu_dyntick: ++=3D 4000000=
000000000 4000000000000002 0x26e
          smokey-703     [000] d.s1  5674.404286: irq_disable: caller=3Dinb=
and_irq_save+0x20/0x30 parent=3D0x0
          smokey-703     [000] d.s2  5674.404286: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] d.s1  5674.404287: rcu_batch_end: rcu_sched =
CBs-invoked=3D8 idle=3D....
          smokey-703     [000] d.s2  5674.404287: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x26e
          smokey-703     [000] d.s1  5674.404287: irq_enable: caller=3Drcu_=
core+0x3b6/0xb60 parent=3D0x0
          smokey-703     [000] d.s2  5674.404287: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] ..s1  5674.404288: rcu_utilization: End RCU =
core
          smokey-703     [000] ..s1  5674.404288: softirq_exit: vec=3D9 [ac=
tion=3DRCU]
          smokey-703     [000] d.s2  5674.404288: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x26e
          smokey-703     [000] d.s1  5674.404288: irq_disable: caller=3D__d=
o_softirq+0x2bd/0x471 parent=3D0x0
          smokey-703     [000] d.s2  5674.404289: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] *..2  5674.404289: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x26e
          smokey-703     [000] *..1  5674.404289: irq_enable: caller=3Dsync=
_current_irq_stage+0x259/0x280 parent=3D0x0
          smokey-703     [000] *..2  5674.404290: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] ...1  5674.404290: cobalt_shadow_relaxed: st=
ate=3D0x4488c0 info=3D0x200
          smokey-703     [000] *..2  5674.404291: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x26e
          smokey-703     [000] *..1  5674.404291: irq_disable: caller=3Darc=
h_pipeline_entry+0x13a/0x170 parent=3D0x0
          smokey-703     [000] *..2  5674.404292: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] d..2  5674.404292: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x26e
          smokey-703     [000] d..1  5674.404292: irq_enable: caller=3Dexit=
_to_user_mode_prepare+0x118/0x1e0 parent=3D0x0
          smokey-703     [000] d..2  5674.404292: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] d..2  5674.404293: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x26e
          smokey-703     [000] d..1  5674.404293: irq_disable: caller=3D_ra=
w_spin_lock_irq+0x12/0x50 parent=3D0x0
          smokey-703     [000] d..2  5674.404293: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] d..2  5674.404294: lock_acquire: 000000007f2=
9b2fb &sighand->siglock
          smokey-703     [000] d..2  5674.404294: kmem_cache_free: call_sit=
e=3D__dequeue_signal+0xf7/0x150 ptr=3D000000003929a99e
          smokey-703     [000] d..3  5674.404295: lock_acquire: 00000000250=
5fb17 &p->pi_lock
          smokey-703     [000] d..3  5674.404295: lock_release: 00000000250=
5fb17 &p->pi_lock
          smokey-703     [000] d..2  5674.404296: lock_release: 000000007f2=
9b2fb &sighand->siglock
          smokey-703     [000] d..3  5674.404296: rcu_dyntick: ++=3D 400000=
0000000000 4000000000000002 0x26e
          smokey-703     [000] d..2  5674.404296: irq_enable: caller=3D_raw=
_spin_unlock_irq+0x1f/0x30 parent=3D0x0
          smokey-703     [000] d..3  5674.404296: rcu_dyntick: --=3D 400000=
0000000002 4000000000000000 0x26e
          smokey-703     [000] ...2  5674.404297: lock_acquire: 00000000e71=
4a308 read tasklist_lock
          smokey-703     [000] ...3  5674.404297: lock_acquire: 00000000909=
a50fe read rcu_read_lock

Regards

Hongzhan Chen
