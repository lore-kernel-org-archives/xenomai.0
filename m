From: Lange Norbert <norbert.lange@andritz.com>
Subject: 3.1rc4: rcu_sched self-detected stall on CPU
Date: Fri, 13 Dec 2019 12:37:54 +0000
Message-ID: <VI1PR05MB59177B111DEE0A49A8282A09F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Got this stall, when trying to reboot. Apparently a Xenomai process can't b=
e killed.

[  350.298889] rcu: INFO: rcu_sched self-detected stall on CPU
[  350.304621] rcu:        2-....: (20999 ticks this GP) idle=3D546/1/0x400=
0000000000002 softirq=3D9363/9363 fqs=3D5108
[  350.314280] rcu:         (t=3D21000 jiffies g=3D26533 q=3D91)
[  350.319134] NMI backtrace for cpu 2
[  350.322716] CPU: 2 PID: 1 Comm: systemd Tainted: G        W         4.19=
.84-xeno8-static #1
[  350.331151] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.20 08/05/2019
[  350.340542] I-pipe domain: Linux
[  350.343855] Call Trace:
[  350.346398]  <IRQ>
[  350.348510]  dump_stack+0x8c/0xc0
[  350.351922]  nmi_cpu_backtrace.cold+0x14/0x53
[  350.356371]  ? lapic_can_unplug_cpu.cold+0x42/0x42
[  350.361255]  nmi_trigger_cpumask_backtrace+0x7a/0x87
[  350.366314]  rcu_dump_cpu_stacks+0x86/0xbe
[  350.370507]  rcu_check_callbacks.cold+0x1fb/0x363
[  350.375318]  update_process_times+0x41/0x80
[  350.379595]  tick_sched_handle+0x34/0x50
[  350.383610]  tick_sched_timer+0x38/0x80
[  350.387540]  __hrtimer_run_queues+0xfd/0x270
[  350.391900]  ? tick_sched_do_timer+0x60/0x60
[  350.396277]  hrtimer_interrupt+0x106/0x230
[  350.400489]  smp_apic_timer_interrupt+0x46/0x110
[  350.405204]  __ipipe_do_sync_stage+0x15d/0x1c0
[  350.409748]  __ipipe_handle_irq+0xa0/0x220
[  350.413953]  apic_timer_interrupt+0x12/0x40
[  350.418225]  </IRQ>
[  350.420419] RIP: 0010:smp_call_function_single+0xd5/0x120
[  350.425907] Code: 00 00 75 5d 48 8d 65 e8 5b 41 5c 41 5d 5d c3 48 8d 74 =
24 20 4c 89 e2 4c 89 e9 e8 56 fe ff ff 8b 54 24 38 83 e2 01 74 0b f3 90 <8b=
> 54 24 38 83 e2 01 75 f5 eb bf 89 7c 24 1c e8 87 eb 01 00 8b 7c
[  350.444761] RSP: 0018:ffffa22840047b80 EFLAGS: 00000202 ORIG_RAX: ffffff=
ffffffff13
[  350.452471] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
0000b
[  350.459687] RDX: 0000000000000001 RSI: ffff956bbb561548 RDI: 00000000000=
a0040
[  350.466902] RBP: ffffa22840047bf8 R08: 00000000000a0040 R09: 00000000000=
2e248
[  350.474119] R10: 000000000000b2dc R11: 00000000006468fd R12: ffffffff8e5=
6c120
[  350.481338] R13: ffffa22840047c08 R14: ffffa22840047cb0 R15: ffffa228400=
47ce0
[  350.488571]  ? perf_cgroup_attach+0x70/0x70
[  350.492878]  ? trace+0x59/0x8d
[  350.496026]  ? perf_cgroup_attach+0x70/0x70
[  350.500306]  ? smp_call_function_single+0x5/0x120
[  350.505109]  task_function_call+0x45/0x70
[  350.509208]  ? perf_cgroup_switch+0x170/0x170
[  350.513657]  perf_cgroup_attach+0x37/0x70
[  350.517757]  cgroup_migrate_execute+0x2c3/0x370
[  350.522392]  cgroup_attach_task+0x154/0x1f0
[  350.526707]  cgroup_procs_write+0xc7/0x100
[  350.530905]  cgroup_file_write+0x88/0x150
[  350.535012]  kernfs_fop_write+0x10b/0x190
[  350.539121]  __vfs_write+0x34/0x190
[  350.542711]  ? __vfs_write+0x5/0x190
[  350.546377]  ? rcu_all_qs+0x5/0x80
[  350.549867]  vfs_write+0xb6/0x190
[  350.553282]  ksys_write+0x57/0xd0
[  350.556696]  do_syscall_64+0x82/0x4e0
[  350.560473]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  350.565614] RIP: 0033:0x7f6e72efd4e4
[  350.569280] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bc 0f 1f 80 =
00 00 00 00 48 8d 05 19 22 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 8d 64 24 d8 48 89 54 24 18
[  350.588133] RSP: 002b:00007ffd434b8cb8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  350.595845] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6e72e=
fd4e4
[  350.603061] RDX: 0000000000000005 RSI: 00007ffd434b8e8a RDI: 00000000000=
0002a
[  350.610279] RBP: 00007ffd434b8e8a R08: 0000000000000000 R09: 00000000000=
00005
[  350.617495] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00005
[  350.624714] R13: 00000000009abaf0 R14: 0000000000000005 R15: 00007f6e72f=
c6760
[  413.301893] rcu: INFO: rcu_sched self-detected stall on CPU
[  413.307621] rcu:        2-....: (83670 ticks this GP) idle=3D546/1/0x400=
0000000000002 softirq=3D9363/9363 fqs=3D20382
[  413.317366] rcu:         (t=3D84003 jiffies g=3D26533 q=3D170)
[  413.322307] NMI backtrace for cpu 2
[  413.325887] CPU: 2 PID: 1 Comm: systemd Tainted: G        W         4.19=
.84-xeno8-static #1
[  413.334321] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.20 08/05/2019
[  413.343712] I-pipe domain: Linux
[  413.347025] Call Trace:
[  413.349566]  <IRQ>
[  413.351677]  dump_stack+0x8c/0xc0
[  413.355089]  nmi_cpu_backtrace.cold+0x14/0x53
[  413.359535]  ? lapic_can_unplug_cpu.cold+0x42/0x42
[  413.364418]  nmi_trigger_cpumask_backtrace+0x7a/0x87
[  413.369480]  rcu_dump_cpu_stacks+0x86/0xbe
[  413.373672]  rcu_check_callbacks.cold+0x1fb/0x363
[  413.378482]  update_process_times+0x41/0x80
[  413.382761]  tick_sched_handle+0x34/0x50
[  413.386769]  tick_sched_timer+0x38/0x80
[  413.390698]  __hrtimer_run_queues+0xfd/0x270
[  413.395058]  ? tick_sched_do_timer+0x60/0x60
[  413.399434]  hrtimer_interrupt+0x106/0x230
[  413.403644]  smp_apic_timer_interrupt+0x46/0x110
[  413.408358]  __ipipe_do_sync_stage+0x15d/0x1c0
[  413.412904]  __ipipe_handle_irq+0xa0/0x220
[  413.417112]  apic_timer_interrupt+0x12/0x40
[  413.421382]  </IRQ>
[  413.423576] RIP: 0010:smp_call_function_single+0xd5/0x120
[  413.429063] Code: 00 00 75 5d 48 8d 65 e8 5b 41 5c 41 5d 5d c3 48 8d 74 =
24 20 4c 89 e2 4c 89 e9 e8 56 fe ff ff 8b 54 24 38 83 e2 01 74 0b f3 90 <8b=
> 54 24 38 83 e2 01 75 f5 eb bf 89 7c 24 1c e8 87 eb 01 00 8b 7c
[  413.447913] RSP: 0018:ffffa22840047b80 EFLAGS: 00000202 ORIG_RAX: ffffff=
ffffffff13
[  413.455622] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
0000b
[  413.462838] RDX: 0000000000000001 RSI: ffff956bbb561548 RDI: 00000000000=
a0040
[  413.470059] RBP: ffffa22840047bf8 R08: 00000000000a0040 R09: 00000000000=
2e248
[  413.477275] R10: 000000000000b2dc R11: 00000000006468fd R12: ffffffff8e5=
6c120
[  413.484491] R13: ffffa22840047c08 R14: ffffa22840047cb0 R15: ffffa228400=
47ce0
[  413.491723]  ? perf_cgroup_attach+0x70/0x70
[  413.496032]  ? trace+0x59/0x8d
[  413.499181]  ? perf_cgroup_attach+0x70/0x70
[  413.503461]  ? smp_call_function_single+0x5/0x120
[  413.508267]  task_function_call+0x45/0x70
[  413.512369]  ? perf_cgroup_switch+0x170/0x170
[  413.516820]  perf_cgroup_attach+0x37/0x70
[  413.520927]  cgroup_migrate_execute+0x2c3/0x370
[  413.525566]  cgroup_attach_task+0x154/0x1f0
[  413.529879]  cgroup_procs_write+0xc7/0x100
[  413.534074]  cgroup_file_write+0x88/0x150
[  413.538184]  kernfs_fop_write+0x10b/0x190
[  413.542293]  __vfs_write+0x34/0x190
[  413.545888]  ? __vfs_write+0x5/0x190
[  413.549555]  ? rcu_all_qs+0x5/0x80
[  413.553048]  vfs_write+0xb6/0x190
[  413.556467]  ksys_write+0x57/0xd0
[  413.559883]  do_syscall_64+0x82/0x4e0
[  413.563666]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  413.568808] RIP: 0033:0x7f6e72efd4e4
[  413.572472] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bc 0f 1f 80 =
00 00 00 00 48 8d 05 19 22 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 8d 64 24 d8 48 89 54 24 18
[  413.591328] RSP: 002b:00007ffd434b8cb8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  413.599039] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6e72e=
fd4e4
[  413.606259] RDX: 0000000000000005 RSI: 00007ffd434b8e8a RDI: 00000000000=
0002a
[  413.613475] RBP: 00007ffd434b8e8a R08: 0000000000000000 R09: 00000000000=
00005
[  413.620692] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00005
[  413.627909] R13: 00000000009abaf0 R14: 0000000000000005 R15: 00007f6e72f=
c6760
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corporation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
