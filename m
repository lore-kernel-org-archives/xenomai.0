MIME-Version: 1.0
In-Reply-To: <CAOuPNLjnKTf153puu+6-h+2M35uOebSfuSuDbOBJh5z_peK2bA@mail.gmail.com>
References: <CAOuPNLjnKTf153puu+6-h+2M35uOebSfuSuDbOBJh5z_peK2bA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 27 Jun 2018 13:01:14 -0400
Message-ID: <CALLqZ8Ro1oBFDYLyUPWLNci4Hmwb51_gsX08ow211RNYcDH3og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] KERNEL OOPS : hikey620: arm64 - while xecuting
	xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

This is an ipipe issue.  CPU4 seems to be stalled or starved.  I'm
doing some RPI3 testing and I haven't seen this yet.  Which board is
this? Is it from 96boards with the octacore A53?

-Greg

On Tue, Jun 26, 2018 at 7:56 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Dear Greg/Philippe,
>
> I am running xeno-test on hikey620, with following details:
> - Kernel version: 4.9.51
> - ipipe: ipipe-core-4.9.51-arm64-4.patch
> - xenomai-3 : next branch
> - xenomai-3 commit until: scripts/prepare-kernel.sh: drop left overs
> from obsolete ports
> - version: 3.1-devel
>
> Build xenomai next using the following:
> # ./scripts/bootstrap
> # ./configure --with-pic --with-core=cobalt --enable-smp --disable-tls
> --enable-dlopen-libs
> # make -j8
> # make install
>
> => Enabled CONFIGS related to xeno-test in kernel:
> CONFIG_XENO_DRIVERS_RTIPC_BUFP CONFIG_XENO_OPT_BUFP_NRPORT=32
> CONFIG_XENO_DRIVERS_RTIPC_IDDP
> CONFIG_XENO_OPT_IDDP_NRPORT=32
> CONFIG_XENO_DRIVERS_RTDMTEST=m
> CONFIG_XENO_OPT_SCHED_TP
> CONFIG_XENO_OPT_SCHED_TP_NRPART=4
> CONFIG_XENO_DRIVERS_RTIPC_XDDP
>
> The run xeno-test:
> # /usr/xenomai/bin/xeno-test
>
> Some tests passed, but after sometime during smokey test, we get this
> back trace in kernel:
>
> If you have any pointers regarding this issue, please let me know.
>
> Thanks,
> Pintu
> ===============================================
> [  487.848376] INFO: rcu_preempt self-detected stall on CPU[
> 487.848446] systemd[1]: systemd-journald.service: Main process exited,
> code=killed
> , status=6/ABRT
> [  487.848497] INFO: rcu_preempt self-detected stall on CPU
> [  487.848506]  6-...: (1 GPs behind) idle=99d/1/0 softirq=1452/1452 fqs=0
> [  487.848508]
> [  487.848513]  (t=29983 jiffies g=391 c=390 q=319)
> [  487.848519] rcu_preempt kthread starved for 29983 jiffies! g391
> c390 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> [  487.848523] rcu_preempt     S
> [  487.848527]     0     7      2 0x00000000
> Call trace:
> [  487.848548] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [  487.848558] [<ffff00000895e120>] __schedule+0x1a8/0x5e8
> [  487.848563] [<ffff00000895e59c>] schedule+0x3c/0xa8
> [  487.848569] [<ffff0000089613b8>] schedule_timeout+0x128/0x280
> [  487.848576] [<ffff00000811164c>] rcu_gp_kthread+0x4dc/0x798
> [  487.848582] [<ffff0000080da538>] kthread+0xe0/0xf8
> [  487.848587] [<ffff000008082fe4>] ret_from_fork+0x14/0x30
> [  487.848598] Task dump for CPU 3:
> [  487.848600] systemd-logind  R
> [  487.848602]   running task        0  2294      1 0x00000200
> Call trace:
> [  487.848611] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [  487.848617] [<ffff0000087ea7d0>] __sys_recvmsg+0x40/0x80
> [  487.848621] [<ffff8000318b2648>] 0xffff8000318b2648
> [  487.848623] Task dump for CPU 4:
> [  487.848625] swapper/4       R
> [  487.848627]   running task        0     0      1 0x00000002
> Call trace:
> [  487.848635] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [  487.848638] [<ffff80003311c200>] 0xffff80003311c200
> [  487.848640] Task dump for CPU 6:
> [  487.848642] swapper/6       R
> [  487.848643]   running task        0     0      1 0x00000000
> Call trace:
> [  487.848653] [<ffff000008088900>] dump_backtrace+0x0/0x1b0
> [  487.848659] [<ffff000008088ac4>] show_stack+0x14/0x20
> [  487.848665] [<ffff0000080e5608>] sched_show_task+0xa0/0xf8
> [  487.848670] [<ffff0000080e7d70>] dump_cpu_task+0x40/0x50
> [  487.848676] [<ffff0000081906c4>] rcu_dump_cpu_stacks+0xb4/0xe8
> [  487.848682] [<ffff0000081123d8>] rcu_check_callbacks+0x810/0x9e0
> [  487.848688] [<ffff00000811627c>] update_process_times+0x34/0x60
> [  487.848693] [<ffff0000081162f0>] update_root_process_times+0x48/0x58
> [  487.848700] [<ffff000008125784>] tick_sched_handle.isra.4+0x5c/0x70
> [  487.848705] [<ffff0000081257dc>] tick_sched_timer+0x44/0x90
> [  487.848710] [<ffff000008116dec>] __hrtimer_run_queues+0xec/0x170
> [  487.848715] [<ffff000008117178>] hrtimer_interrupt+0xa0/0x1d8
> [  487.848720] [<ffff000008123d70>] tick_receive_broadcast+0x28/0x48
> [  487.848726] [<ffff00000808e74c>] handle_IPI+0xa4/0x140
> [  487.848730] [<ffff00000808e808>] __ipipe_do_IPI+0x20/0x28
> [  487.848735] [<ffff000008153d74>] __ipipe_do_sync_stage+0x1ac/0x1d0
> [  487.848739] [<ffff000008153e8c>] ipipe_unstall_root+0x44/0x50
> [  487.848745] [<ffff00000874e174>] cpuidle_enter_state+0x154/0x220
> [  487.848749] [<ffff00000874e278>] cpuidle_enter+0x18/0x20
> [  487.848754] [<ffff0000080f7f6c>] call_cpuidle+0x44/0x88
> [  487.848759] [<ffff0000080f8170>] cpu_startup_entry+0x190/0x1e8
> [  487.848763] [<ffff00000808e174>] secondary_start_kernel+0x164/0x1a0
> [  487.848766] [<00000000009681a4>] 0x9681a4
> [  487.849172] systemd[1]: systemd-journald.service: Unit entered failed state.
> [  487.849674] systemd[1]: systemd-journald.service: Failed with
> result 'signal'.
> [  487.851292] systemd[1]: systemd-journald.service: Service has no
> hold-off time, scheduling restart.
> [  487.852621] systemd[1]: Stopped Flush Journal to Persistent Storage.
> [  487.852792] systemd[1]: Stopping Flush Journal to Persistent Storage...
> [  487.852838] systemd[1]: Stopped Journal Service.
> [  487.854881] systemd[1]: Starting Journal Service...
> [  487.862458] systemd-journald[2553]: File
> /run/log/journal/7ed7bca1519a40c9b60c6577cb9072c1/system.journal
> corrupted or uncleanly shut down, r
> enaming and replacing.
> [  487.872215] systemd[1]: Started Journal Service.
> [  488.193484]  4-...: (2 GPs behind) idle=4b5/1/0 softirq=933/938 fqs=1
> [  488.200004]   (t=29983 jiffies g=391 c=390 q=877)
> [  488.204710] Task dump for CPU 4:
> [  488.207931] swapper/4       R  running task        0     0      1 0x00000002
> [  488.214982] Call trace:
> [  488.217431] [<ffff000008088900>] dump_backtrace+0x0/0x1b0
> [  488.222827] [<ffff000008088ac4>] show_stack+0x14/0x20
> [  488.227876] [<ffff0000080e5608>] sched_show_task+0xa0/0xf8
> [  488.233357] [<ffff0000080e7d70>] dump_cpu_task+0x40/0x50
> [  488.238666] [<ffff0000081906c4>] rcu_dump_cpu_stacks+0xb4/0xe8
> [  488.244497] [<ffff0000081123d8>] rcu_check_callbacks+0x810/0x9e0
> [  488.250500] [<ffff00000811627c>] update_process_times+0x34/0x60
> [  488.256416] [<ffff0000081162f0>] update_root_process_times+0x48/0x58
> [  488.262768] [<ffff000008125744>] tick_sched_handle.isra.4+0x1c/0x70
> [  488.269030] [<ffff0000081257dc>] tick_sched_timer+0x44/0x90
> [  488.274599] [<ffff000008116dec>] __hrtimer_run_queues+0xec/0x170
> [  488.280602] [<ffff000008117178>] hrtimer_interrupt+0xa0/0x1d8
> [  488.286344] [<ffff000008123a4c>] tick_handle_oneshot_broadcast+0x164/0x1a8
> [  488.293218] [<ffff000008786278>] sp804_timer_interrupt+0x30/0x40
> [  488.299221] [<ffff000008102f64>] __handle_irq_event_percpu+0x9c/0x128
> [  488.305658] [<ffff00000810300c>] handle_irq_event_percpu+0x1c/0x58
> [  488.311833] [<ffff000008103090>] handle_irq_event+0x48/0x78
> [  488.317402] [<ffff000008106abc>] handle_fasteoi_irq+0x8c/0x130
> [  488.323231] [<ffff000008102054>] generic_handle_irq+0x24/0x38
> [  488.328972] [<ffff0000081026d4>] __handle_domain_irq+0x5c/0xb8
> [  488.334801] [<ffff0000080949d8>] __ipipe_do_IRQ+0x28/0x30
> [  488.340196] [<ffff000008153d90>] __ipipe_do_sync_stage+0x1c8/0x1d0
> [  488.346371] [<ffff000008153e8c>] ipipe_unstall_root+0x44/0x50
> [  488.352114] [<ffff00000874e174>] cpuidle_enter_state+0x154/0x220
> [  488.358117] [<ffff00000874e278>] cpuidle_enter+0x18/0x20
> [  488.363424] [<ffff0000080f7f6c>] call_cpuidle+0x44/0x88
> [  488.368645] [<ffff0000080f8170>] cpu_startup_entry+0x190/0x1e8
> [  488.374474] [<ffff00000808e174>] secondary_start_kernel+0x164/0x1a0
> [  488.380736] [<00000000009681a4>] 0x9681a4
> [  488.384767] NMI watchdog: BUG: soft lockup - CPU#4 stuck for 112s!
> [swapper/4:0]
> [  488.392160] Modules linked in:
> [  488.395216]
> [  488.396705] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> 4.9.51-hikey-g0dda863 #1
> [  488.404356] Hardware name: HiKey Development Board (DT)
> [  488.409575] I-pipe domain: Linux
> [  488.412796] task: ffff800005febe80 task.stack: ffff800034400000
> [  488.418714] PC is at ipipe_unstall_root+0x34/0x50
> [  488.423412] LR is at 0x0
> [  488.425939] pc : [<ffff000008153e7c>] lr : [<0000000000000000>]
> pstate: 60000145
> [  488.433330] sp : 0000000000000000
> [  488.436639] x29: 0000000000000000 x28: 0000000000000000
> [  488.441955] x27: 0000000000000000 x26: 0000000000000000
> [  488.447266] x25: 0000000000000000 x24: 0000000000000000
> [  488.452578] x23: 0000000000000000 x22: 0000000000000000
> [  488.457890] x21: 0000000000000000 x20: 0000000000000000
> [  488.463203] x19: 0000000000000000 x18: 0000000000000000
> [  488.468514] x17: 0000000000000000 x16: 0000000000000000
> [  488.473824] x15: 0000000000000000 x14: 0000000000000000
> [  488.479136] x13: 0000000000000000 x12: 0000000000000000
> [  488.484447] x11: 0000000000000000 x10: 0000000000000000
> [  488.489758] x9 : 0000000000000000 x8 : 0000000000000000
> [  488.495069] x7 : 0000000000000000 x6 : 0000000000000000
> [  488.500380] x5 : 0000000000000000 x4 : 0000000000000000
> [  488.505690] x3 : 0000000000000000 x2 : 0000000000000000
> [  488.511000] x1 : 0000000000000000 x0 : 0000000000000000
> [  488.516311]
> ^[[B
> [  907.617444] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  907.617448] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  907.617463]  4-...: (1 ticks this GP) idle=4bd/1/0 softirq=943/943 fqs=0
> [  907.617470]  (detected by 2, t=104775 jiffies, g=-240, c=-241, q=3)
> [  907.617475] Task dump for CPU 4:
> [  907.617483] swapper/4       R  running task        0     0      1 0x00000002
> [  907.617486] Call trace:
> [  907.617503] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [  907.617508] [<ffff80003311c200>] 0xffff80003311c200
> [  907.617515] rcu_sched kthread starved for 104775 jiffies!
> g18446744073709551376 c18446744073709551375 f0x0 RCU_GP_WAIT_FQS(3)
> ->state=0x0
> [  907.617521] rcu_sched       R  running task        0     8      2 0x00000000
> [  907.617523] Call trace:
> [  907.617528] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [  907.617538] [<ffff00000895e120>] __schedule+0x1a8/0x5e8
> [  907.617543] [<ffff00000895e59c>] schedule+0x3c/0xa8
> [  907.617552] [<ffff0000089613b8>] schedule_timeout+0x128/0x280
> [  907.617565] [<ffff00000811164c>] rcu_gp_kthread+0x4dc/0x798
> [  907.617572] [<ffff0000080da538>] kthread+0xe0/0xf8
> [  907.617576] [<ffff000008082fe4>] ret_from_fork+0x14/0x30
> [  907.722732]  1-...: (1 GPs behind) idle=44b/1/0 softirq=870/871 fqs=0
> [  907.722739]  4-...: (0 ticks this GP) idle=4c8/0/0 softirq=944/944 fqs=0
> [  907.722753]  (detected by 1, t=0 jiffies, g=393, c=392, q=1366)
> [  907.722756] Task dump for CPU 1:
> [  907.722762] swapper/1       R  running task        0     0      1 0x00000002
> [  907.722764] Call trace:
> [  907.722775] [<ffff000008088900>] dump_backtrace+0x0/0x1b0
> [  907.722781] [<ffff000008088ac4>] show_stack+0x14/0x20
> [  907.722787] [<ffff0000080e5608>] sched_show_task+0xa0/0xf8
> [  907.722792] [<ffff0000080e7d70>] dump_cpu_task+0x40/0x50
> [  907.722798] [<ffff0000081906c4>] rcu_dump_cpu_stacks+0xb4/0xe8
> [  907.722806] [<ffff00000811256c>] rcu_check_callbacks+0x9a4/0x9e0
> [  907.722812] [<ffff00000811627c>] update_process_times+0x34/0x60
> [  907.722816] [<ffff0000081162f0>] update_root_process_times+0x48/0x58
> [  907.722823] [<ffff000008125744>] tick_sched_handle.isra.4+0x1c/0x70
> [  907.722828] [<ffff0000081257dc>] tick_sched_timer+0x44/0x90
> [  907.722833] [<ffff000008116dec>] __hrtimer_run_queues+0xec/0x170
> [  907.722837] [<ffff000008117178>] hrtimer_interrupt+0xa0/0x1d8
> [  907.722845] [<ffff0000087859dc>] arch_timer_handler_phys+0x54/0x60
> [  907.722852] [<ffff000008107528>] handle_percpu_devid_irq+0x68/0x128
> [  907.722857] [<ffff000008102054>] generic_handle_irq+0x24/0x38
> [  907.722862] [<ffff0000081026d4>] __handle_domain_irq+0x5c/0xb8
> [  907.722869] [<ffff0000080949d8>] __ipipe_do_IRQ+0x28/0x30
> [  907.722875] [<ffff000008153d90>] __ipipe_do_sync_stage+0x1c8/0x1d0
> [  907.722879] [<ffff000008153e34>] __ipipe_do_sync_pipeline+0x9c/0xb0
> [  907.722883] [<ffff000008154024>] dispatch_irq_head+0xd4/0x118
> [  907.722888] [<ffff000008154514>] __ipipe_dispatch_irq+0xdc/0x1d8
> [  907.722892] [<ffff000008081308>] __ipipe_grab_irq+0x80/0x98
> [  907.722896] Exception stack(0xffff800005ff7db0 to 0xffff800005ff7ee0)
> [  907.722901] 7da0:
> 0000000000000000 000080002d101000
> [  907.722906] 7dc0: 0000000000000000 ffff800035f0d8e8
> 000000d05b9e082f 0000000000000015
> [  907.722910] 7de0: 00000000001c687d 0000000000000009
> 000000000000000a ffff800035f14ed4
> [  907.722914] 7e00: 000000000000000a 000000000000000a
> 071c71c71c71c71c 0000000000019cbc
> [  907.722918] 7e20: 0000000000000000 0000ffff93297cc0
> ffff000008219428 0000ffff931a57b8
> [  907.722922] 7e40: 0000000000000a03 000000d35236d708
> ffff80003474fe00 0000000000000000
> [  907.722926] 7e60: 0000000000000000 ffff000008f045a8
> 000000d35236aebf ffff800005ff4000
> [  907.722931] 7e80: ffff000008f21853 ffff000008f21000
> ffff000008e48000 ffff800005ff7ee0
> [  907.722935] 7ea0: ffff00000874e174 ffff800005ff7ee0
> ffff000008153e7c 0000000060000145
> [  907.722939] 7ec0: ffff000008f045c0 ffff80003474fe00
> ffffffffffffffff 0000000000000000
> [  907.722943] [<ffff0000080816ac>] gic_handle_irq+0x54/0xa8
> [  907.722946] Exception stack(0xffff800005ff7db0 to 0xffff800005ff7ee0)
> [  907.722949] 7da0:
> 0000000000000000 000080002d101000
> [  907.722953] 7dc0: 0000000000000000 ffff800035f0d8e8
> 000000d05b9e082f 0000000000000015
> [  907.722957] 7de0: 00000000001c687d 0000000000000009
> 000000000000000a ffff800035f14ed4
> [  907.722961] 7e00: 000000000000000a 000000000000000a
> 071c71c71c71c71c 0000000000019cbc
> [  907.722966] 7e20: 0000000000000000 0000ffff93297cc0
> ffff000008219428 0000ffff931a57b8
> [  907.722970] 7e40: 0000000000000a03 000000d35236d708
> ffff80003474fe00 0000000000000000
> [  907.722974] 7e60: 0000000000000000 ffff000008f045a8
> 000000d35236aebf ffff800005ff4000
> [  907.722978] 7e80: ffff000008f21853 ffff000008f21000
> ffff000008e48000 ffff800005ff7ee0
> [  907.722982] 7ea0: ffff00000874e174 ffff800005ff7ee0
> ffff000008153e7c 0000000060000145
> [  907.722986] 7ec0: ffff000008f045c0 ffff80003474fe00
> ffffffffffffffff 0000000000000000
> [  907.722990] [<ffff0000080827c8>] el1_irq+0xc8/0x108
> [  907.722994] [<ffff000008153e7c>] ipipe_unstall_root+0x34/0x50
> [  907.723000] [<ffff00000874e174>] cpuidle_enter_state+0x154/0x220
> [  907.723005] [<ffff00000874e278>] cpuidle_enter+0x18/0x20
> [  907.723010] [<ffff0000080f7f6c>] call_cpuidle+0x44/0x88
> [  907.723015] [<ffff0000080f8170>] cpu_startup_entry+0x190/0x1e8
> [  907.723020] [<ffff00000808e174>] secondary_start_kernel+0x164/0x1a0
> [  907.723024] [<00000000009681a4>] 0x9681a4
> [  907.723027] Task dump for CPU 4:
> [  907.723034] swapper/4       R  running task        0     0      1 0x00000000
> [  907.723036] Call trace:
> [  907.723041] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [  907.723047] [<ffff000008092f38>] arm_cpuidle_suspend+0x28/0x30
> [  907.723053] [<ffff00000874fcb8>] arm_enter_idle_state+0x50/0x70
> [  907.723058] [<ffff00000874e10c>] cpuidle_enter_state+0xec/0x220
> [  907.723062] [<ffff00000874e278>] cpuidle_enter+0x18/0x20
> [  907.723066] [<ffff0000080f7f6c>] call_cpuidle+0x44/0x88
> [  907.723071] [<ffff0000080f8170>] cpu_startup_entry+0x190/0x1e8
> [  907.723075] [<ffff00000808e174>] secondary_start_kernel+0x164/0x1a0
> [  907.723077] [<00000000009681a4>] 0x9681a4
> ^[[B[ 1087.848025] INFO: rcu_preempt self-detected stall on CPU[
> 1087.849439] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 1087.849442] INFO: rcu_sched detected stalls on CPUs/tasks:
> [ 1087.849452]  4-...: (1 GPs behind) idle=4d1/1/0 softirq=944/953 fqs=0
> [ 1087.849458]  4-...: (1 ticks this GP) idle=4d1/1/0 softirq=953/953 fqs=0
> [ 1087.849459]
> [ 1087.849460]
> [ 1087.849466] (detected by 1, t=45031 jiffies, g=-238, c=-239, q=1)
> (detected by 3, t=45031 jiffies, g=394, c=393, q=627)
> [ 1087.849471] Task dump for CPU 4:
> [ 1087.849472] Task dump for CPU 4:
> [ 1087.849474] swapper/4       R
> [ 1087.849477] swapper/4       R
> [ 1087.849479]   running task      running task        0     0      1 0x00000000
>     0     0      1 0x00000000
> Call trace:
> [ 1087.849490] Call trace:
> [ 1087.849506] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [ 1087.849512] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [ 1087.849516] [<ffff80003311c200>] 0xffff80003311c200
> [ 1087.849520] [<ffff80003311c200>] 0xffff80003311c200
> [ 1087.849525] rcu_sched kthread starved for 45031 jiffies!
> g18446744073709551378 c18446744073709551377 f0x0 RCU_GP_WAIT_FQS(3)
> ->state=0x0
> [ 1087.849530] rcu_preempt kthread starved for 45031 jiffies! g394
> c393 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> [ 1087.849532] rcu_sched       S
> [ 1087.849534] rcu_preempt     S
> [ 1087.849537]     0     8      2 0x00000000
>     0     7      2 0x00000000
> Call trace:
> [ 1087.849543] Call trace:
> [ 1087.849547] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [ 1087.849551] [<ffff0000080859ec>] __switch_to+0x8c/0xa0
> [ 1087.849566] [<ffff00000895e120>] __schedule+0x1a8/0x5e8
> [ 1087.849571] [<ffff00000895e120>] __schedule+0x1a8/0x5e8
> [ 1087.849575] [<ffff00000895e59c>] schedule+0x3c/0xa8
> [ 1087.849579] [<ffff00000895e59c>] schedule+0x3c/0xa8
> [ 1087.849584] [<ffff0000089613b8>] schedule_timeout+0x128/0x280
> [ 1087.849588] [<ffff0000089613b8>] schedule_timeout+0x128/0x280
> [ 1087.849595] [<ffff00000811164c>] rcu_gp_kthread+0x4dc/0x798
> [ 1087.849600] [<ffff00000811164c>] rcu_gp_kthread+0x4dc/0x798
> [ 1087.849605] [<ffff0000080da538>] kthread+0xe0/0xf8
> [ 1087.849609] [<ffff0000080da538>] kthread+0xe0/0xf8
> [ 1087.849613] [<ffff000008082fe4>] ret_from_fork+0x14/0x30
> [ 1087.849616] [<ffff000008082fe4>] ret_from_fork+0x14/0x30
> [ 1088.048411]  4-...: (1 ticks this GP) idle=4d1/1/0 softirq=953/953 fqs=1
> [ 1088.055193]   (t=45031 jiffies g=394 c=393 q=948)
> [ 1088.059899] Task dump for CPU 4:
> [ 1088.063119] swapper/4       R  running task        0     0      1 0x00000002
> [ 1088.070171] Call trace:
> [ 1088.072622] [<ffff000008088900>] dump_backtrace+0x0/0x1b0
> [ 1088.078018] [<ffff000008088ac4>] show_stack+0x14/0x20
> [ 1088.083067] [<ffff0000080e5608>] sched_show_task+0xa0/0xf8
> [ 1088.088548] [<ffff0000080e7d70>] dump_cpu_task+0x40/0x50
> [ 1088.093857] [<ffff0000081906c4>] rcu_dump_cpu_stacks+0xb4/0xe8
> [ 1088.099688] [<ffff0000081123d8>] rcu_check_callbacks+0x810/0x9e0
> [ 1088.105691] [<ffff00000811627c>] update_process_times+0x34/0x60
> [ 1088.111606] [<ffff0000081162f0>] update_root_process_times+0x48/0x58
> [ 1088.117958] [<ffff000008125744>] tick_sched_handle.isra.4+0x1c/0x70
> [ 1088.124221] [<ffff0000081257dc>] tick_sched_timer+0x44/0x90
> [ 1088.129789] [<ffff000008116dec>] __hrtimer_run_queues+0xec/0x170
> [ 1088.135791] [<ffff000008117178>] hrtimer_interrupt+0xa0/0x1d8
> [ 1088.141533] [<ffff000008123a4c>] tick_handle_oneshot_broadcast+0x164/0x1a8
> [ 1088.148406] [<ffff000008786278>] sp804_timer_interrupt+0x30/0x40
> [ 1088.154410] [<ffff000008102f64>] __handle_irq_event_percpu+0x9c/0x128
> [ 1088.160847] [<ffff00000810300c>] handle_irq_event_percpu+0x1c/0x58
> [ 1088.167022] [<ffff000008103090>] handle_irq_event+0x48/0x78
> [ 1088.172592] [<ffff000008106abc>] handle_fasteoi_irq+0x8c/0x130
> [ 1088.178421] [<ffff000008102054>] generic_handle_irq+0x24/0x38
> [ 1088.184163] [<ffff0000081026d4>] __handle_domain_irq+0x5c/0xb8
> [ 1088.189994] [<ffff0000080949d8>] __ipipe_do_IRQ+0x28/0x30
> [ 1088.195389] [<ffff000008153d90>] __ipipe_do_sync_stage+0x1c8/0x1d0
> [ 1088.201564] [<ffff000008153e8c>] ipipe_unstall_root+0x44/0x50
> [ 1088.207307] [<ffff00000874e174>] cpuidle_enter_state+0x154/0x220
> [ 1088.213308] [<ffff00000874e278>] cpuidle_enter+0x18/0x20
> [ 1088.218617] [<ffff0000080f7f6c>] call_cpuidle+0x44/0x88
> [ 1088.223837] [<ffff0000080f8170>] cpu_startup_entry+0x190/0x1e8
> [ 1088.229666] [<ffff00000808e174>] secondary_start_kernel+0x164/0x1a0
> [ 1088.235928] [<00000000009681a4>] 0x9681a4

