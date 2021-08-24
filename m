Date: Tue, 24 Aug 2021 20:48:06 +0800
Subject: Can I use ftrace to analysis cobalt kernel
From: Ivan Jiang <jcgeforce@aliyun.com>
Message-ID: <2EEA4F9C-7739-425E-B57E-1BED69207E6B@aliyun.com>
Mime-version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear guys:

=20

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Can I use ftrace to analysis the kernel with patch of ipipe.

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I find if use function_graph whe kernel will crash like below:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo function_graph > current_tracer

root@smarc-rzg2l:/sys/kernel/debug/tracing# [=C2=A0 377.392724] Kernel panic - =
not syncing: kernel stack overflow

[=C2=A0 377.399125] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.19.140-cip33-=
g6634f0243a91 #3

[=C2=A0 377.407929] Hardware name: RZG2L Evaluation Board Kit (Discrete Power S=
ystem Ver.) (Dual Cortex-A55) (DT)

[=C2=A0 377.418424] necro domain: Linux

[=C2=A0 377.422006] Call trace:

[=C2=A0 377.424856]=C2=A0 dump_backtrace+0x0/0x168

[=C2=A0 377.429003]=C2=A0 show_stack+0x24/0x30

[=C2=A0 377.432790]=C2=A0 dump_stack+0xd0/0x110

[=C2=A0 377.436660]=C2=A0 panic+0x138/0x2a8

[=C2=A0 377.440157]=C2=A0 nmi_panic+0x7c/0x80

[=C2=A0 377.443840]=C2=A0 handle_bad_stack+0x120/0x138

[=C2=A0 377.448356]=C2=A0 __bad_stack+0x88/0x8c

[=C2=A0 377.452224]=C2=A0 sched_clock+0x0/0x90

[=C2=A0 377.455998]=C2=A0 function_graph_enter+0x74/0x138

[=C2=A0 377.460797]=C2=A0 prepare_ftrace_return+0x28/0x50

[=C2=A0 377.465593]=C2=A0 ftrace_graph_caller+0x1c/0x24

[=C2=A0 377.470206]=C2=A0 ipipe_test_root+0x10/0x38

[=C2=A0 377.474447]=C2=A0 preempt_schedule_notrace+0x28/0x150

[=C2=A0 377.479624]=C2=A0 trace_clock_local+0x44/0x58

[=C2=A0 377.484046]=C2=A0 function_graph_enter+0x74/0x138

[=C2=A0 377.488839]=C2=A0 prepare_ftrace_return+0x28/0x50

[=C2=A0 377.493637]=C2=A0 ftrace_graph_caller+0x1c/0x24

[=C2=A0 379.179942]=C2=A0 ipipe_test_root+0x10/0x38

[=C2=A0 379.184182]=C2=A0 preempt_schedule_notrace+0x28/0x150

[=C2=A0 379.189343]=C2=A0 trace_clock_local+0x44/0x58

[=C2=A0 379.193766]=C2=A0 function_graph_enter+0x74/0x138

[=C2=A0 379.198563]=C2=A0 prepare_ftrace_return+0x28/0x50

[=C2=A0 379.203358]=C2=A0 ftrace_graph_caller+0x1c/0x24

[=C2=A0 379.207968]=C2=A0 ipipe_test_root+0x10/0x38

[=C2=A0 379.212207]=C2=A0 preempt_schedule_notrace+0x28/0x150

[=C2=A0 379.217378]=C2=A0 trace_clock_local+0x44/0x58

[=C2=A0 379.221799]=C2=A0 function_graph_enter+0x74/0x138

[=C2=A0 379.226593]=C2=A0 prepare_ftrace_return+0x28/0x50

[=C2=A0 379.231391]=C2=A0 ftrace_graph_caller+0x1c/0x24

[=C2=A0 379.236004]=C2=A0 ipipe_test_root+0x10/0x38

[=C2=A0 379.240244]=C2=A0 preempt_schedule_notrace+0x28/0x150

[=C2=A0 379.245415]=C2=A0 ftrace_ops_no_ops+0x1ac/0x1b0

[=C2=A0 379.250025]=C2=A0 skip_ftrace_call+0x0/0x30

[=C2=A0 379.254260]=C2=A0 ipipe_test_root+0x10/0x38

[=C2=A0 379.258501]=C2=A0 preempt_schedule_notrace+0x28/0x150

[=C2=A0 379.263670]=C2=A0 trace_clock_local+0x44/0x58

[=C2=A0 379.268093]=C2=A0 ftrace_return_to_handler+0x78/0x128

[=C2=A0 379.273261]=C2=A0 return_to_handler+0x1c/0x38

[=C2=A0 379.277677]=C2=A0 __do_softirq+0x23c/0x3d0

[=C2=A0 379.281822]=C2=A0 run_ksoftirqd+0x40/0x50

[=C2=A0 379.285874]=C2=A0 kthread+0x130/0x138

[=C2=A0 379.289551]=C2=A0 ret_from_fork+0x14/0x20

[=C2=A0 379.293651] SMP: stopping secondary CPUs

[=C2=A0 379.298123] Kernel Offset: disabled

[=C2=A0 379.302072] CPU features: 0x4,22002238

[=C2=A0 379.306299] Memory Limit: none

[=C2=A0 379.310010] ---[ end Kernel panic - not syncing: kernel stack overflow =
]---

[=C2=A0 379.317786] Insufficient stack space to handle exception!

[=C2=A0 379.317830] ESR: 0x96000047 -- DABT (current EL)

[=C2=A0 379.328901] FAR: 0xffff00000805ffc0

[=C2=A0 379.332867] Task stack:=C2=A0=C2=A0=C2=A0=C2=A0 [0xffff000008060000..0xffff000008064000=
]

[=C2=A0 379.339903] IRQ stack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0xffff000008000000..0xffff00000800400=
0]

[=C2=A0 379.346945] Overflow stack: [0xffff80007ff95290..0xffff80007ff96290]

[=C2=A0 379.353984] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.19.140-cip33-=
g6634f0243a91 #3

[=C2=A0 379.362818] Hardware name: RZG2L Evaluation Board Kit (Discrete Power S=
ystem Ver.) (Dual Cortex-A55) (DT)

[=C2=A0 379.373333] necro domain: Linux

[=C2=A0 379.376921] pstate: 00c00005 (nzcv daif +PAN +UAO)

[=C2=A0 379.382282] pc : sched_clock+0x0/0x90

[=C2=A0 379.386428] lr : trace_clock_local+0x20/0x58

[=C2=A0 379.391227] sp : ffff000008060000

[=C2=A0 379.394995] x29: ffff000008060000 x28: ffff0000095b60c0=20

[=C2=A0 379.400978] x27: ffff00000959c000 x26: 0000000000000100=20

[=C2=A0 379.406958] x25: 0000000000000040 x24: ffff0000095b6110=20

[=C2=A0 379.412940] x23: ffff0000095b9b38 x22: ffff000008df9b70=20

[=C2=A0 379.418923] x21: ffff0000081c03d4 x20: ffff0000095b9748=20

[=C2=A0 379.424904] x19: ffff80007dbe6e00 x18: 0000000000000000=20

[=C2=A0 379.430885] x17: 0000000000000000 x16: 0000000000000000=20

[=C2=A0 379.436869] x15: 0000000000000000 x14: 0000000000000000=20

[=C2=A0 379.442852] x13: 0000000000000000 x12: 0000000000000000=20

[=C2=A0 379.448839] x11: 0000000000000000 x10: 0000000000000f90=20

[=C2=A0 379.454822] x9 : ffff80007d806400 x8 : 0000000000000018=20

[=C2=A0 379.460805] x7 : ffff8000776d0fa0 x6 : 0000000015d5de14=20

[=C2=A0 379.466793] x5 : 00ffffffffffffff x4 : 0000000000000000=20

[=C2=A0 379.472781] x3 : 0000000000000000 x2 : 0000000000000041=20

[=C2=A0 379.478757] x1 : ffff0000081c03d4 x0 : 0000000000000001

=20

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I was wondering if there=E2=80=99s some option I should use differen=
t from normal linux.

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thank you.

=20

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BR.,

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ivan

