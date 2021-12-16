MIME-Version: 1.0
From: Sam Daniel <daniel.jacob.samuel@gmail.com>
Date: Wed, 15 Dec 2021 21:35:03 -0800
Message-ID: <CAPMj8MvTHmgqABPTdvsiN8F5m6j4Sa0EA7iBUjT2hYikyQaY_w@mail.gmail.com>
Subject: Debugging kernel paging request oops
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello. I am running on a Xilinx ZCU102 (ARM64, Cortex A53) development
board and I've written a lot of userspace software against the POSIX skin
of Cobalt 3.1.

For context, I have set isolcpus=1,2,3 as kernel boot args. I only run my
Xenomai tasks on CPUs 1,2,3. I know that despite isolcpus, the Linux kernel
will still run a few kthreads on those cores. I am worried that the cause
of my issues might be my Xenomai tasks completely starving those Linux
kthreads.

I can boot the board and then start and run my application software just
fine. Sometimes, if I start and then restart my application software, I get
a kernel oops related to paging a virtual address that is out of bounds. (I
am using a 4KB page size).

(FWIW the stack trace on this oops is not always in rcu code)

[25721.667165] Unable to handle kernel paging request at virtual address
ffffff484585c150
[25721.675303] Mem abort info:
[25721.678199]   ESR = 0x96000004
[25721.681365]   Exception class = DABT (current EL), IL = 32 bits
[25721.687445]   SET = 0, FnV = 0
[25721.690610]   EA = 0, S1PTW = 0
[25721.693854] Data abort info:
[25721.696836]   ISV = 0, ISS = 0x00000004
[25721.700786]   CM = 0, WnR = 0
[25721.703862] [ffffff484585c150] address between user and kernel address
ranges
[25721.711184] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[25721.716791] Modules linked in: gpio_zynq xilinx_can xeno_can_ddc(O)
xeno_can_sja1000_ddc(O) xeno_can gpio_xilinx
[25721.727087] Process bordline_dm_4 (pid: 24396, stack limit =
0x00000000b3644306)
[25721.734521] CPU: 2 PID: 24396 Comm: bordline_dm_4 Tainted: G        W  O
     4.19.55 #1
[25721.742654] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[25721.747645] I-pipe domain: Linux
[25721.750894] pstate: 00000085 (nzcv daIf -PAN -UAO)
[25721.755718] pc : ___xnsched_run+0xf8/0x640
[25721.759840] lr : ___xnsched_run+0xf8/0x640
[25721.763960] sp : ffffff8008013df0
[25721.767290] x29: ffffff800a0168b8 x28: ffffff800ad17410
[25721.772647] x27: ffffff800911f200 x26: ffffff8008ed4520
[25721.778003] x25: ffffff8008bfb9e8 x24: ffffff8009349000
[25721.783359] x23: ffffffc838478000 x22: ffffffc802216180
[25721.788715] x21: ffffff800ad13e10 x20: ffffff800817883c
[25721.794072] x19: ffffff8008013e70 x18: 0000000000000000
[25721.799427] x17: 0000000000000208 x16: 0000000000000000
[25721.804784] x15: 0000000000000000 x14: 0000000000000000
[25721.810140] x13: 0000000000000000 x12: 0000000000000000
[25721.815496] x11: 0000000000000000 x10: 0000000000001890
[25721.820852] x9 : ffffff8008013dd0 x8 : ffffffc802217a70
[25721.826208] x7 : ffffff80090d8f18 x6 : ffffff80090d8f08
[25721.831564] x5 : 000000000000374a x4 : 0000000000000000
[25721.836920] x3 : 0000000000000000 x2 : 276c5ce9e4fb7000
[25721.842276] x1 : ffffffc802216180 x0 : ffffffc83ab48340
[25721.847633] Call trace:
[25721.850096]  ___xnsched_run+0xf8/0x640
[25721.853871] Code: 92400273 d53b4220 363818a0 97fe0ccb (f8606aa0)
[25721.859998] I-pipe tracer log (100 points):
[25721.864198]  | #func                    0 ipipe_trace_panic_freeze+0xc
(oops_enter+0x18)
[25721.872415]  | #func                   -1 oops_enter+0xc (die+0x40)
[25721.878792]  | #func                   -2 preempt_count_add+0x18
(_raw_spin_lock_irqsave+0x28)
[25721.887531]  | #func                   -2 ipipe_root_only+0x18
(ipipe_test_and_stall_root+0x1c)
[25721.896351]  | #func                   -2 ipipe_test_and_stall_root+0x14
(_raw_spin_lock_irqsave+0x1c)
[25721.905781]  | #func                   -3 _raw_spin_lock_irqsave+0x14
(die+0x38)
[25721.913298]  | #func                   -3 die+0x2c
(die_kernel_fault+0x68)
[25721.920290]  | #func                   -4 preempt_count_sub+0x14
(wake_up_klogd+0xa0)
[25721.928240]  | #func                   -5 preempt_count_add+0x18
(wake_up_klogd+0x18)
[25721.936191]  | #func                   -5 wake_up_klogd+0xc
(vprintk_emit+0xc4)
[25721.943620]  | #func                   -6 preempt_count_sub+0x14
(vprintk_emit+0x1a8)
[25721.951565]  | #func                   -6 preempt_count_sub+0x14
(__printk_safe_exit+0x44)
[25721.959953]  | #func                   -7 preempt_count_add+0x18
(__printk_safe_exit+0x18)
[25721.968339]  | #func                   -7 __printk_safe_exit+0xc
(console_unlock.part.5+0x2d0)
[25721.977074]  | #func                   -7 preempt_count_sub+0x14
(_raw_spin_unlock+0x28)
[25721.985283]  | #func                   -8 _raw_spin_unlock+0x14
(console_unlock.part.5+0x2cc)
[25721.993931]  | #func                   -8 preempt_count_add+0x18
(_raw_spin_lock+0x20)
[25722.001967]  | #func                   -9 _raw_spin_lock+0x14
(console_unlock.part.5+0x2bc)
[25722.010442]  | #func                   -9 preempt_count_sub+0x14
(__printk_safe_exit+0x44)
[25722.018827]  | #func                   -9 preempt_count_add+0x18
(__printk_safe_exit+0x18)
[25722.027213]  | #func                  -10 __printk_safe_exit+0xc
(__up_console_sem.isra.2+0x34)
[25722.036035]  | #func                  -10 preempt_count_sub+0x14
(_raw_spin_unlock_irqrestore+0x30)
[25722.045203]  | #func                  -11
_raw_spin_unlock_irqrestore+0x18 (up+0x54)
[25722.053061]  | #func                  -11 __ipipe_spin_unlock_debug+0x14
(up+0x48)
[25722.060752]  | #func                  -12 preempt_count_add+0x18
(_raw_spin_lock_irqsave+0x28)
[25722.069490]  | #func                  -12 ipipe_root_only+0x18
(ipipe_test_and_stall_root+0x1c)
[25722.078311]  | #func                  -12 ipipe_test_and_stall_root+0x14
(_raw_spin_lock_irqsave+0x1c)
[25722.087741]  | #func                  -13 _raw_spin_lock_irqsave+0x14
(up+0x20)
[25722.095170]  | #func                  -13 up+0x14
(__up_console_sem.isra.2+0x30)
[25722.102680]  | #func                  -14 preempt_count_sub+0x14
(__printk_safe_enter+0x40)
[25722.111148]  | #func                  -14 preempt_count_add+0x18
(__printk_safe_enter+0x18)
[25722.119621]  | #func                  -15 __printk_safe_enter+0xc
(__up_console_sem.isra.2+0x20)
[25722.128530]  | #func                  -15 ipipe_root_only+0x18
(ipipe_test_and_stall_root+0x1c)
[25722.137349]  | #func                  -15 ipipe_test_and_stall_root+0x14
(__up_console_sem.isra.2+0x18)
[25722.146867]  | #func                  -16 __up_console_sem.isra.2+0x10
(console_unlock.part.5+0x2b4)
[25722.156128]  | #func                  -16 preempt_count_sub+0x14
(_raw_spin_unlock+0x28)
[25722.164344]  | #func                  -17 _raw_spin_unlock+0x14
(console_unlock.part.5+0x2b0)
[25722.172992]  | #func                  -17 preempt_count_add+0x18
(_raw_spin_lock+0x20)
[25722.181027]  | #func                  -18 _raw_spin_lock+0x14
(console_unlock.part.5+0x98)
[25722.189415]  | #func                  -18 preempt_count_sub+0x14
(__printk_safe_enter+0x40)
[25722.197888]  | #func                  -18 preempt_count_add+0x18
(__printk_safe_enter+0x18)
[25722.206360]  | #func                  -19 __printk_safe_enter+0xc
(console_unlock.part.5+0x8c)
[25722.215094]  | #func                  -19 ipipe_root_only+0x18
(ipipe_test_and_stall_root+0x1c)
[25722.223915]  | #func                  -20 ipipe_test_and_stall_root+0x14
(console_unlock.part.5+0x84)
[25722.233258]  | #func                  -20 preempt_count_sub+0x14
(__printk_safe_exit+0x44)
[25722.241647]  | #func                  -21 preempt_count_add+0x18
(__printk_safe_exit+0x18)
[25722.250033]  | #func                  -21 __printk_safe_exit+0xc
(console_unlock.part.5+0x2f4)
[25722.258768]  | #func                  -22 preempt_count_sub+0x14
(_raw_spin_unlock+0x28)
[25722.266977]  | #func                  -22 _raw_spin_unlock+0x14
(console_unlock.part.5+0x248)
[25722.275626]  | #func                  -22 preempt_count_add+0x18
(_raw_spin_lock+0x20)
[25722.283661]  | #func                  -23 _raw_spin_lock+0x14
(console_unlock.part.5+0x234)
[25722.292136]  | #func                  -23 preempt_count_sub+0x14
(_raw_spin_unlock+0x28)
[25722.300347]  | #func                  -24 _raw_spin_unlock+0x14
(vt_console_print+0x118)
[25722.308559]  | #func                  -24 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.317731]  | #func                  -24 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.327072]  | #func                  -25 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.335898]  | #func                  -25
atomic_notifier_call_chain+0x24 (vt_console_print+0x2b4)
[25722.344979]  | #func                  -26 dummycon_cursor+0xc
(set_cursor+0x88)
[25722.352411]  | #func                  -26 add_softcursor+0x14
(set_cursor+0x64)
[25722.359841]  | #func                  -27 set_cursor+0x14
(vt_console_print+0x2a0)
[25722.367534]  | #func                  -27 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.376708]  | #func                  -27 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.386050]  | #func                  -28 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.394876]  | #func                  -28
atomic_notifier_call_chain+0x24 (vt_console_print+0x1dc)
[25722.403957]  | #func                  -29 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.413125]  | #func                  -29 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.422466]  | #func                  -30 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.431292]  | #func                  -30
atomic_notifier_call_chain+0x24 (lf+0x80)
[25722.439065]  | #func                  -32 dummycon_scroll+0xc
(con_scroll+0x210)
[25722.446581]  | #func                  -32 con_scroll+0x30 (lf+0xc8)
[25722.452962]  | #func                  -33 lf+0x1c
(vt_console_print+0x2f0)
[25722.459953]  | #func                  -33 dummycon_putcs+0xc
(vt_console_print+0x340)
[25722.467903]  | #func                  -34 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.477077]  | #func                  -34 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.486418]  | #func                  -35 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.495244]  | #func                  -35
atomic_notifier_call_chain+0x24 (vt_console_print+0x234)
[25722.504325]  | #func                  -36 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.513493]  | #func                  -36 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.522834]  | #func                  -36 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.531660]  | #func                  -37
atomic_notifier_call_chain+0x24 (vt_console_print+0x234)
[25722.540742]  | #func                  -37 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.549909]  | #func                  -38 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.559251]  | #func                  -38 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.568076]  | #func                  -38
atomic_notifier_call_chain+0x24 (vt_console_print+0x234)
[25722.577158]  | #func                  -39 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.586325]  | #func                  -39 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.595667]  | #func                  -40 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.604492]  | #func                  -40
atomic_notifier_call_chain+0x24 (vt_console_print+0x234)
[25722.613574]  | #func                  -41 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.622742]  | #func                  -41 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.632083]  | #func                  -41 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.640909]  | #func                  -42
atomic_notifier_call_chain+0x24 (vt_console_print+0x234)
[25722.649990]  | #func                  -42 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.659158]  | #func                  -43 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.668499]  | #func                  -43 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.677325]  | #func                  -44
atomic_notifier_call_chain+0x24 (vt_console_print+0x234)
[25722.686407]  | #func                  -44 __rcu_read_unlock+0x10
(atomic_notifier_call_chain+0x108)
[25722.695574]  | #func                  -45 notifier_call_chain+0x2c
(atomic_notifier_call_chain+0x100)
[25722.704915]  | #func                  -45 __rcu_read_lock+0xc
(atomic_notifier_call_chain+0xe8)
[25722.713741]  | #func                  -45
atomic_notifier_call_chain+0x24 (vt_console_print+0x234)
[25722.722825] ---[ end trace 2297667c45d572b6 ]---

I also occasionally see these kernel logs:

[  989.859879] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  989.865825] rcu:     0-...!: (0 ticks this GP)
idle=e96/1/0x4000000000000002 softirq=64453/64453 fqs=0
[  989.874984] rcu:     2-...!: (1 GPs behind)
idle=5aa/1/0x4000000000000002 softirq=19889/19890 fqs=0
[  989.883876] rcu:     (detected by 1, t=21022 jiffies, g=144381, q=23)
[  989.890073] Task dump for CPU 0:
[  989.893302] fcm-dm          R  running task        0  2682      1
0x00000202
[  989.900380] Call trace:
[  989.902837]  __switch_to+0x9c/0xf0
[  989.906249]  __FUNCTION__.48533+0x0/0x10
[  989.910180] Task dump for CPU 2:
[  989.913415] bordline_dm_1   R  running task        0  2764      1
0x00000220
[  989.920493] Call trace:
[  989.922946]  __switch_to+0x9c/0xf0
[  989.926353] rcu: rcu_sched kthread starved for 21022 jiffies! g144381
f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[  989.936643] rcu: RCU grace-period kthread stack dump:
[  989.941703] rcu_sched       R  running task        0    10      2
0x00000008
[  989.948775] Call trace:
[  989.951228]  __switch_to+0x9c/0xf0
[  989.954635]  __schedule+0x2f4/0x990
[  989.958133]  schedule+0x58/0x90
[  989.961284]  schedule_timeout+0x1e4/0x440
[  989.965307]  rcu_gp_kthread+0x5d0/0xf50
[  989.969149]  kthread+0x130/0x140
[  989.972386]  ret_from_fork+0x14/0x1c

Any help is great appreciated.

Thanks
~ Sam
