MIME-Version: 1.0
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Date: Tue, 4 Sep 2018 17:59:44 +0200
Message-ID: <CAAjAsiy=cp_nZsSpfcsE=0YDWppHuT1ZTpFgW4F-b1f6ovbQ+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] kernel crash when debugging userspace realtime task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm using the xenomai cobalt kernel with ipipe-core-4.9.51-arm-4.patch over
a Sitara AM335x custom board.
Occur a strange problem  when debugging an userspace task with
gdb/gdbserver.
In detail, sometimes into a debugging session, kernel crash at the moment
that I add a breakpoint in a realtime task.

  Unhandled fault: page domain fault (0x01b) at 0x001412dc
  (see below for the complete kernel panic)

This problem is not easily reproducible because occurs only with the
Windows toolchain (gdb in windows environment).
With the linux toolcahin never occur but I don't exclude that problem exist
and it's shadow for any timing reason...
With boot toolchain program works correctly if running unless debugging.

So, using FTRACE, I take a snapshot of the kernel internals at the moment
when problem occurs:

  killer-0-510   [000]   152.421095: function:
 preempt_count_sub <-- finish_task_switch
  killer-0-510   [000]   152.421100: function:             do_DataAbort <--
__dabt_svc
  (see below for the complete FTRACE snapshot)

Does anyone have any advice to give me to try to solve this probem?

Matteo Facchinetti,
Sirius Electronic Systems s.r.l.


* KENEL PANIC

Unhandled fault: page domain fault (0x01b) at 0x001412dc
pgd = cd8a4000
[001412dc] *pgd=8d87b831, *pte=99d3e1cf, *ppte=99d3ea3e
Internal error: : 1b [#1] PREEMPT ARM
Modules linked in: canopen_sync(O) mchpar1xxx omap_rng rng_core
xeno_can_c_can_platform xeno_can_c_can xeno_can cdc_acm fuse
CPU: 0 PID: 717 Comm: serv_p95_t4 Tainted: G        W  O
4.9.51-yocto-standard #23
Hardware name: Generic AM33XX (Flattened Device Tree)
I-pipe domain: Linux
task: d801ea00 task.stack: d7d24000
PC is at __und_usr_thumb+0x4/0x40
LR is at finish_task_switch+0x13c/0x214
pc : [<c091bc44>]    lr : [<c0154af0>]    psr: 200f0113
sp : d7d25fb0  ip : c0154094  fp : 00000000
r10: befff4b4  r9 : c091be0c  r8 : 10c53c7d
r7 : 10c5387d  r6 : ffffffff  r5 : a0070030  r4 : 001412dc
r3 : a0070030  r2 : 001412de  r1 : c0fcc690  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8d8a4019  DAC: 00000051
Process serv_p95_t4 (pid: 717, stack limit = 0xd7d24218)
Stack: (0xd7d25fb0 to 0xd7d26000)
5fa0:                                     ffffff92 00000000 00000000
0010cd18
5fc0: 00000000 b61061fc b60a6d94 b60a6d68 b60a6e1c 00000000 befff4b4
befff55c
5fe0: b6f510f0 b60a6d68 b6f993d0 001412de a0070030 ffffffff 00000000
00000000
Code: f57ff06f e28fed05 ea00000f e2424002 (e0f450b0)
---[ end trace dd36d2533af939fc ]---

Unhandled fault: page domain fault (0x01b) at 0x001412dc
pgd = cd8a4000
[001412dc] *pgd=8d87b831, *pte=99d3e1cf, *ppte=99d3ea3e
Internal error: : 1b [#2] PREEMPT ARM
Modules linked in: canopen_sync(O) mchpar1xxx omap_rng rng_core
xeno_can_c_can_platform xeno_can_c_can xeno_can cdc_acm fuse
CPU: 0 PID: 715 Comm: serv_p87_t12 Tainted: G      D W  O
4.9.51-yocto-standard #23
Hardware name: Generic AM33XX (Flattened Device Tree)
I-pipe domain: Linux
task: d801a7c0 task.stack: d7148000
PC is at __und_usr_thumb+0x4/0x40
LR is at kretprobe_table_unlock+0x2c/0x58
pc : [<c091bc44>]    lr : [<c01ad07c>]    psr: 200f0113
sp : d7149fb0  ip : c0154094  fp : 00000000
r10: befff4b4  r9 : c091be0c  r8 : 10c53c7d
r7 : 10c5387d  r6 : ffffffff  r5 : a0070030  r4 : 001412dc
r3 : a0070030  r2 : 001412de  r1 : c0fcc690  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8d8a4019  DAC: 00000051
Process serv_p87_t12 (pid: 715, stack limit = 0xd7148218)
Stack: (0xd7149fb0 to 0xd714a000)
9fa0:                                     ffffff92 00000000 00000000
0010cd18
9fc0: 00000000 b6105dfc b60b7d94 b60b7d68 b60b7e1c 00000000 befff4b4
befff55c
9fe0: b6f510f0 b60b7d68 b6f993d0 001412de a0070030 ffffffff 00000000
00000000
Code: f57ff06f e28fed05 ea00000f e2424002 (e0f450b0)
---[ end trace dd36d2533af939fd ]---
Unhandled fault: page domain fault (0x01b) at 0x001412dc
pgd = cd8a4000
[001412dc] *pgd=8d87b831, *pte=99d3e1cf, *ppte=99d3ea3e
Internal error: : 1b [#3] PREEMPT ARM
Modules linked in: canopen_sync(O) mchpar1xxx omap_rng rng_core
xeno_can_c_can_platform xeno_can_c_can xeno_can cdc_acm fuse
CPU: 0 PID: 711 Comm: iec_p10_t12 Tainted: G      D W  O
4.9.51-yocto-standard #23
Hardware name: Generic AM33XX (Flattened Device Tree)
I-pipe domain: Linux
task: d801dcc0 task.stack: ce386000
PC is at __und_usr_thumb+0x4/0x40
LR is at kretprobe_table_unlock+0x2c/0x58
pc : [<c091bc44>]    lr : [<c01ad07c>]    psr: 200f0113
sp : ce387fb0  ip : c0154094  fp : 00000000
r10: befff644  r9 : c091be0c  r8 : 10c53c7d
r7 : 10c5387d  r6 : ffffffff  r5 : a0070030  r4 : 001412dc
r3 : a0070030  r2 : 001412de  r1 : c0fcc690  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 8d8a4019  DAC: 00000051
Process iec_p10_t12 (pid: 711, stack limit = 0xce386218)
Stack: (0xce387fb0 to 0xce388000)
7fa0:                                     ffffff92 00000000 00000000
0010cd18
7fc0: 00000000 b61059fc b60c8d94 b60c8d68 b60c8e1c 00000000 befff644
befff6ec
7fe0: b6f510f0 b60c8d68 b6f993d0 001412de a0070030 ffffffff 00000000
00000000
Code: f57ff06f e28fed05 ea00000f e2424002 (e0f450b0)
---[ end trace dd36d2533af939fe ]---


* TRACE

gdbserver-499   [000]   152.421041: function:
 update_min_vruntime <-- update_curr
gdbserver-499   [000]   152.421043: function:             cpuacct_charge
<-- update_curr
gdbserver-499   [000]   152.421044: function:             __rcu_read_lock
<-- cpuacct_charge
gdbserver-499   [000]   152.421047: function:             __rcu_read_unlock
<-- cpuacct_charge
gdbserver-499   [000]   152.421049: function:             check_spread <--
put_prev_entity
gdbserver-499   [000]   152.421050: function:             __enqueue_entity
<-- put_prev_entity
gdbserver-499   [000]   152.421055: function:
 __ipipe_notify_kevent <-- __schedule
gdbserver-499   [000]   152.421056: function:             ipipe_kevent_hook
<-- __ipipe_notify_kevent
gdbserver-499   [000]   152.421058: function:             __switch_mm_inner
<-- __schedule
gdbserver-499   [000]   152.421061: function:
 check_and_switch_context <-- __switch_mm_inner
gdbserver-499   [000]   152.421065: function:
 __ipipe_switch_to_notifier_call_chain <-- __switch_to
gdbserver-499   [000]   152.421068: function:
 atomic_notifier_call_chain <-- __ipipe_switch_to_notifier_call_chain
gdbserver-499   [000]   152.421070: function:
 __atomic_notifier_call_chain <-- atomic_notifier_call_chain
gdbserver-499   [000]   152.421072: function:             __rcu_read_lock
<-- __atomic_notifier_call_chain
gdbserver-499   [000]   152.421073: function:
 notifier_call_chain <-- __atomic_notifier_call_chain
gdbserver-499   [000]   152.421075: function:             vfp_notifier <--
notifier_call_chain
gdbserver-499   [000]   152.421077: function:             thumbee_notifier
<-- notifier_call_chain
gdbserver-499   [000]   152.421079: function:             __rcu_read_unlock
<-- __atomic_notifier_call_chain
gdbserver-499   [000]   152.421081: function:
 __ipipe_restore_root_nosync <-- __ipipe_switch_to_notifier_call_chain
 killer-0-510   [000]   152.421083: function:
 __ipipe_complete_domain_migration <-- ___xnsched_run
 killer-0-510   [000]   152.421085: function:
 complete_domain_migration <-- __ipipe_complete_domain_migration
 killer-0-510   [000]   152.421087: function:
 ipipe_unstall_head <-- xnthread_relax
 killer-0-510   [000]   152.421089: function:
 __ipipe_reenter_root <-- xnthread_relax
 killer-0-510   [000]   152.421091: function:
 finish_task_switch <-- __ipipe_reenter_root
 killer-0-510   [000]   152.421093: function:
 ipipe_unstall_root <-- finish_task_switch
 killer-0-510   [000]   152.421095: function:             preempt_count_sub
<-- finish_task_switch
 killer-0-510   [000]   152.421100: function:             do_DataAbort <--
__dabt_svc
 killer-0-510   [000]   152.421103: function:             do_bad <--
do_DataAbort
 killer-0-510   [000]   152.421105: function:
 __ipipe_notify_trap <-- do_bad
 killer-0-510   [000]   152.421107: function:
 __ipipe_notify_trap <-- do_DataAbort
 killer-0-510   [000]   152.421109: function:             printk <--
do_DataAbort
 killer-0-510   [000]   152.421113: function:             vprintk_default
<-- printk
 killer-0-510   [000]   152.421115: function:             vprintk_emit <--
vprintk_default
 killer-0-510   [000]   152.421119: function:             preempt_count_add
<-- vprintk_emit
 killer-0-510   [000]   152.421141: function:             log_store <--
vprintk_emit
 killer-0-510   [000]   152.421144: function:
 log_make_free_space <-- log_store
 killer-0-510   [000]   152.421151: function:             preempt_count_sub
<-- vprintk_emit
 killer-0-510   [000]   152.421153: function:             console_trylock
<-- vprintk_emit
 killer-0-510   [000]   152.421155: function:             down_trylock <--
console_trylock
 killer-0-510   [000]   152.421157: function:             preempt_count_add
<-- down_trylock
 killer-0-510   [000]   152.421159: function:             preempt_count_sub
<-- down_trylock
 killer-0-510   [000]   152.421162: function:             console_unlock
<-- vprintk_emit
 killer-0-510   [000]   152.421164: function:             preempt_count_add
<-- console_unlock
 killer-0-510   [000]   152.421166: function:             preempt_count_sub
<-- console_unlock
 killer-0-510   [000]   152.421169: function:             preempt_count_add
<-- console_unlock
 killer-0-510   [000]   152.421171: function:             log_from_idx <--
console_unlock
 killer-0-510   [000]   152.421174: function:             msg_print_text
<-- console_unlock
 killer-0-510   [000]   152.421178: function:             print_prefix <--
msg_print_text
 killer-0-510   [000]   152.421180: function:             print_prefix <--
msg_print_text
 killer-0-510   [000]   152.421183: function:             log_next <--
console_unlock
 killer-0-510   [000]   152.421185: function:             preempt_count_sub
<-- console_unlock
 killer-0-510   [000]   152.421187: function:
 call_console_drivers.constprop.15 <-- console_unlock
 killer-0-510   [000]   152.421191: function:
 serial_omap_console_write <-- call_console_drivers.constprop.15
