MIME-Version: 1.0
References: <CAMMcbao60ib7YVUDsD5FD=J7aTCzsTAsG3ggUc7vXPHvbvd5uw@mail.gmail.com>
 <8e029de8-dac5-5788-c28b-1d20736ef494@siemens.com>
 <CAMMcbaoNMZWSk=UED8cCk=ToPFPeNq3Abx=KwCyPhL9Zbx9CYQ@mail.gmail.com>
 <498375c5-740c-23c5-0570-cf9b6b91e957@siemens.com>
 <CAMMcbapNQzaDHKEdSWJ2awZrZ3y7j23Lq1U=7k1pPwy8pz3BOA@mail.gmail.com>
 <d2635287-9ab0-180c-24f6-a6d5be950f0e@siemens.com>
In-Reply-To: <d2635287-9ab0-180c-24f6-a6d5be950f0e@siemens.com>
From: Arturo Laurenzi <arturo.laurenzi@gmail.com>
Date: Mon, 16 May 2022 15:56:21 +0200
Message-ID: <CAMMcbapqLdt=66t5eyGFY6o7ai=p67S7Y8SoJykoX5GZNSTnWQ@mail.gmail.com>
Subject: Re: Machine freezes under Ubuntu 20.04
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

> The call-stack is not reported as fully reliable. Are you running with
> CONFIG_DEBUG_INFO=y? Do you have CONFIG_UNWINDER_ORC=y?
>
> Assuming it is reliable, we may try to run some irq-work that no longer
> exists. But that's speculation.
>
> What may help here is ftrace dump on panic, see
> https://www.kernel.org/doc/html/latest/admin-guide/sysctl/kernel.html#ftrace-dump-on-oops
>
> Jan

Hi Jan, all,
sorry for getting back to you after so long. Our test machine hasn't
been available for a period of time, due to independent reasons.
We now enable debug information when building the kernel, as well as
ftrace support. You might want to check the attached .config
for correctness.

We add the cmd line parameter that you suggested
(ftrace_dump_on_oops), and enable function_graphs as current tracer.
Here's the resulting serial dump.

[  444.320303] kernel tried to execute NX-protected page - exploit
attempt? (uid: 1000)
[  444.320306] BUG: unable to handle page fault for address: ffff963f5a327040
[  444.320309] #PF: supervisor instruction fetch in kernel mode
[  444.320311] #PF: error_code(0x0011) - permissions violation
[  444.320313] PGD 44e001067 P4D 44e001067 PUD 80000001800001e3
[  444.320323] Oops: 0011 [#1] SMP PTI IRQ_PIPELINE
[  444.320326] CPU: 7 PID: 4206 Comm: xbot2-core Not tainted
5.10.89-xeno-ipipe-3.1+ #7
[  444.320328] Hardware name:  /TS175, BIOS BQKLR112 07/04/2017
[  444.320330] IRQ stage: Linux
[  444.320333] RIP: 0010:0xffff963f5a327040
[  444.320336] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 08 a4 8
[  444.320338] RSP: 0018:ffff981f00238f90 EFLAGS: 00010202
[  444.320343] RAX: ffff963f5a327040 RBX: ffff981f0339fdd0 RCX: 0000000000000000
[  444.320346] RDX: ffff981f0339fdd8 RSI: ffff96421fd80000 RDI: ffff981f0339fdd0
[  444.320348] RBP: 000000000339fe70 R08: 0000000000000048 R09: ffff963f349f3000
[  444.320350] R10: 0000000000000002 R11: ffff963f349e0a60 R12: 000000000339fe70
[  444.320353] R13: 0000000000000000 R14: 0000000000000024 R15: 0000000000000000
[  444.320355] FS:  00007f52856c5600(0000) GS:ffff96421fd80000(0000)
knlGS:0000000000000000
[  444.320358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  444.320360] CR2: ffff963f5a327040 CR3: 000000019a0d4005 CR4: 00000000003706e0
[  444.320363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  444.320365] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  444.320368] Call Trace:
[  444.320370]  <IRQ>
[  444.320372]  ? irq_work_single+0x2c/0x40
[  444.320375]  ? irq_work_run_list+0x2d/0x40
[  444.320377]  ? irq_work_run+0x14/0x30
[  444.320380]  ? inband_work_interrupt+0xa/0x10
[  444.320382]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320384]  ? handle_synthetic_irq+0x61/0xf0
[  444.320387]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320389]  ? asm_call_irq_on_stack+0x12/0x20
[  444.320391]  </IRQ>
[  444.320394]  ? arch_do_IRQ_pipelined+0xbe/0x140
[  444.320396]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320399]  ? sync_current_irq_stage+0x1af/0x230
[  444.320401]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320403]  ? __inband_irq_enable+0x47/0x50
[  444.320406]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320408]  ? _raw_spin_unlock_irqrestore+0x1e/0x20
[  444.320411]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320413]  ? __set_cpus_allowed_ptr+0xa1/0x230
[  444.320415]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320418]  ? sched_setaffinity+0x1b0/0x290
[  444.320420]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320423]  ? __x64_sys_sched_setaffinity+0x4e/0x90
[  444.320425]  ? ftrace_graph_caller+0xa0/0xa0
[  444.320427]  ? do_syscall_64+0x3f/0x90
[  444.320430]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  444.320432] Modules linked in: fuse rtpacket binfmt_misc nls_ascii
nls_cp437 vfat fat i915 rt_e1000e i2c_algo_bit evdev drm_kms_helper
cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fon
[  444.320553] Dumping ftrace buffer:
[  444.320556] ---------------------------------
[  444.320558] CPU:5 [LOST 200196842 EVENTS]
[  444.320561]  5)   0.903 us    |              } /* down_write */
[  444.320563]  5)   0.255 us    |              anon_vma_interval_tree_insert();
[  444.320566]  5)   0.175 us    |              up_write();
[  444.320568]  5)   7.399 us    |            } /* anon_vma_clone */
[  444.320571]  5)               |            kmem_cache_alloc() {
[  444.320573]  5)               |              _cond_resched() {
[  444.320576]  5)   0.173 us    |                rcu_all_qs();
[  444.320578]  5)   0.535 us    |              }
[  444.320580]  5)   0.174 us    |              should_failslab();
[  444.320583]  5)   0.173 us    |              mem_cgroup_from_task();
[  444.320585]  5)   0.173 us    |              rcu_read_unlock_strict();
[  444.320588]  5)   0.171 us    |              rcu_read_unlock_strict();
[  444.320590]  5)               |              obj_cgroup_charge() {
[  444.320593]  5)   0.182 us    |                __inband_irq_enable();
[  444.320595]  5)   0.542 us    |              }
[  444.320598]  5)               |              _cond_resched() {
[  444.320600]  5)   0.175 us    |                rcu_all_qs();
[  444.320602]  5)   0.532 us    |              }
[  444.320605]  5)   0.184 us    |              __inband_irq_enable();
[  444.320607]  5)   0.171 us    |              rcu_read_unlock_strict();
[  444.320610]  5)               |              __mod_memcg_lruvec_state() {
[  444.320612]  5)   0.176 us    |                __mod_memcg_state();
[  444.320615]  5)   0.543 us    |              }
[  444.320617]  5)   0.186 us    |              __inband_irq_enable();
[  444.320619]  5)   0.173 us    |              rcu_read_unlock_strict();
[  444.320622]  5)   0.172 us    |              rcu_read_unlock_strict();
[  444.320624]  5)   6.404 us    |            }
[  444.320627]  5)               |            kmem_cache_alloc() {
[  444.320629]  5)               |              _cond_resched() {
[  444.320632]  5)   0.172 us    |                rcu_all_qs();
[  444.320634]  5)   0.547 us    |              }
[  444.320636]  5)   0.174 us    |              should_failslab();
[  444.320639]  5)   0.177 us    |              mem_cgroup_from_task();
[  444.320641]  5)   0.173 us    |              rcu_read_unlock_strict();
[  444.320644]  5)   0.168 us    |              rcu_read_unlock_strict();
[  444.320646]  5)               |              obj_cgroup_charge() {
[  444.320649]  5)   0.186 us    |                __inband_irq_enable();
[  444.320651]  5)   0.172 us    |                rcu_read_unlock_strict();
[  444.320654]  5)   0.174 us    |                rcu_read_unlock_strict();
[  444.320656]  5)               |                __memcg_kmem_charge() {
[  444.320659]  5)               |                  try_charge() {
[  444.320661]  5)   0.180 us    |                    __inband_irq_enable();
[  444.320663]  5)   0.557 us    |                  }
[  444.320666]  5)               |                  page_counter_try_charge() {
[  444.320668]  5)   0.172 us    |
propagate_protected_usage();
[  444.320671]  5)   0.171 us    |
propagate_protected_usage();
[  444.320673]  5)   0.172 us    |
propagate_protected_usage();
[  444.320676]  5)   0.179 us    |
propagate_protected_usage();
[  444.320678]  5)   1.635 us    |                  }
[  444.320681]  5)   2.748 us    |                }
[  444.320683]  5)               |                refill_obj_stock() {
[  444.320686]  5)   0.183 us    |                  __inband_irq_enable();
[  444.320688]  5)   0.541 us    |                }
[  444.320691]  5)   0.173 us    |                rcu_read_unlock_strict();
[  444.320693]  5)   5.330 us    |              }
[  444.320695]  5)               |              _cond_resched() {
[  444.320698]  5)   0.192 us    |                rcu_all_qs();
[  444.320700]  5)   0.551 us    |              }
[  444.320703]  5)   0.186 us    |              __inband_irq_enable();
[  444.320705]  5)   0.176 us    |              rcu_read_unlock_strict();
[  444.320708]  5)               |              __mod_memcg_lruvec_state() {
[  444.320710]  5)   0.177 us    |                __mod_memcg_state();
[  444.320712]  5)   0.548 us    |              }
[  444.320715]  5)   0.186 us    |              __inband_irq_enable();
[  444.320717]  5)   0.176 us    |              rcu_read_unlock_strict();
[  444.320720]  5)   0.174 us    |              rcu_read_unlock_strict();
[  444.320722]  5) + 11.236 us   |            }
[  444.320725]  5)               |            down_write() {
[  444.320727]  5)               |              _cond_resched() {
[  444.320730]  5)   0.173 us    |                rcu_all_qs();
[  444.320732]  5)   0.533 us    |              }
[  444.320734]  5)   0.899 us    |            }
[  444.320737]  5)   0.195 us    |            anon_vma_interval_tree_insert();
[  444.320739]  5)   0.176 us    |            up_write();
[  444.320742]  5) + 27.739 us   |          } /* anon_vma_fork */
[  444.320744]  5)               |          __vma_link_rb() {
[  444.320747]  5)   0.184 us    |            vma_gap_callbacks_rotate();
[  444.320749]  5)   0.570 us    |          }
[  444.320751]  5)               |          copy_page_range() {
[  444.320754]  5)               |            _cond_resched() {
[  444.320756]  5)   0.178 us    |              rcu_all_qs();
[  444.320759]  5)   0.538 us    |            }
[  444.320761]  5)   0.177 us    |            _raw_spin_lock();
[  444.320763]  5)   0.179 us    |            _raw_spin_lock();
[  444.320766]  5)               |            _cond_resched() {
[  444.320768]  5)   0.176 us    |              rcu_all_qs();
[  444.320771]  5)   0.535 us    |            }
[  444.320773]  5)               |            __pte_alloc() {
[  444.320776]  5)               |              pte_alloc_one() {
[  444.320778]  5)               |                alloc_pages_current() {
[  444.320781]  5)   0.178 us    |                  get_task_policy.part.0();
[  444.320783]  5)   0.176 us    |                  policy_nodemask();
[  444.320785]  5)   0.178 us    |                  policy_node();
[  444.320788]  5)               |                  __alloc_pages_nodemask() {
[  444.320790]  5)               |                    _cond_resched() {
[  444.320793]  5)   0.176 us    |                      rcu_all_qs();
[  444.320795]  5)   0.540 us    |                    }
[  444.320798]  5)   0.174 us    |
[  444.320803] Lost 233836 message(s)!
[  455.241663] ---[ end trace f09305f9ddaf2ac5 ]---
[  455.241667] RIP: 0010:0xffff963f5a327040
[  455.241671] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 70 00 00 00 00 00 00 00 08 a4 8
[  455.241675] RSP: 0018:ffff981f00238f90 EFLAGS: 00010202
[  455.241683] RAX: ffff963f5a327040 RBX: ffff981f0339fdd0 RCX: 0000000000000000
[  455.241687] RDX: ffff981f0339fdd8 RSI: ffff96421fd80000 RDI: ffff981f0339fdd0
[  455.241690] RBP: 000000000339fe70 R08: 0000000000000048 R09: ffff963f349f3000
[  455.241694] R10: 0000000000000002 R11: ffff963f349e0a60 R12: 000000000339fe70
[  455.241698] R13: 0000000000000000 R14: 0000000000000024 R15: 0000000000000000
[  455.241702] FS:  00007f52856c5600(0000) GS:ffff96421fd80000(0000)
knlGS:0000000000000000
[  455.241705] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  455.241707] CR2: ffff963f5a327040 CR3: 000000019a0d4005 CR4: 00000000003706e0
[  455.241710] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  455.241712] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  455.241715] Kernel panic - not syncing: Fatal exception in interrupt
[  455.242117] Dumping ftrace buffer:
[  455.242119]    (ftrace buffer empty)
[  455.242122] Kernel Offset: 0x34c00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Does this help in any way? What else can we do to increase the amount
of reported information?

Thanks,
Arturo and Davide

