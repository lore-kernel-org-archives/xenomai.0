Subject: Re: qemu-system-aarch64 hung in kernel with xenomai
References: <5E991C23.8050102@tj.kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <03961582-e331-fa5b-a89f-66fae41c4198@siemens.com>
Date: Fri, 17 Apr 2020 08:31:23 +0200
MIME-Version: 1.0
In-Reply-To: <5E991C23.8050102@tj.kylinos.cn>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chensong <chensong@tj.kylinos.cn>, xenomai@xenomai.org

On 17.04.20 05:01, chensong via Xenomai wrote:
> hi,
> 
> I tried to start a vm, however it looks like qemu-system-aarch64 was 
> hung and no respond at all forever. I enabled RCU, lockdebug, lockups 
> and hungs, got below messages:
> 
> [   74.088790] watchdog: BUG: soft lockup - CPU#32 stuck for 23s! 
> [kworker/32:2:486]
> [   98.228605] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   98.234513] rcu:     41-...0: (2 GPs behind) 
> idle=86e/1/0x4000000000000002 softirq=410/411 fqs=2986
> [   98.243345] rcu:     45-...0: (3 GPs behind) 
> idle=17e/1/0x4000000000000002 softirq=400/400 fqs=2986
> [   98.252175] rcu:     (detected by 35, t=6004 jiffies, g=1549, q=9727)
> [  102.088607] watchdog: BUG: soft lockup - CPU#32 stuck for 23s! 
> [kworker/32:2:486]
> [  130.088697] watchdog: BUG: soft lockup - CPU#32 stuck for 23s! 
> [kworker/32:2:486]
> [  154.128832] watchdog: BUG: soft lockup - CPU#41 stuck for 21s! 
> [qemu-system-aar:6706]
> [  154.148792] watchdog: BUG: soft lockup - CPU#45 stuck for 21s! 
> [qemu-system-aar:6707]
> [  158.088825] watchdog: BUG: soft lockup - CPU#32 stuck for 23s! 
> [kworker/32:2:486]
> [  182.128875] watchdog: BUG: soft lockup - CPU#41 stuck for 22s! 
> [qemu-system-aar:6706]
> [  182.148871] watchdog: BUG: soft lockup - CPU#45 stuck for 22s! 
> [qemu-system-aar:6707]
> [  186.088875] watchdog: BUG: soft lockup - CPU#32 stuck for 23s! 
> [kworker/32:2:486]
> [  210.128900] watchdog: BUG: soft lockup - CPU#41 stuck for 22s! 
> [qemu-system-aar:6706]
> [  210.148883] watchdog: BUG: soft lockup - CPU#45 stuck for 22s! 
> [qemu-system-aar:6707]
> [  214.088863] watchdog: BUG: soft lockup - CPU#32 stuck for 22s! 
> [kworker/32:2:486]
> [  238.129035] watchdog: BUG: soft lockup - CPU#41 stuck for 22s! 
> [qemu-system-aar:6706]
> [  238.149053] watchdog: BUG: soft lockup - CPU#45 stuck for 22s! 
> [qemu-system-aar:6707]
> [  242.089406] watchdog: BUG: soft lockup - CPU#32 stuck for 22s! 
> [kworker/32:2:486]
> [  249.710123] INFO: task kworker/17:1:354 blocked for more than 120 
> seconds.
> [  249.716971]       Tainted: G        W   EL    4.19.55-xenomai #1
> [  249.723027] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  249.730980] INFO: task systemd-hostnam:1257 blocked for more than 120 
> seconds.
> [  249.738170]       Tainted: G        W   EL    4.19.55-xenomai #1
> [  249.744167] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  249.752123] INFO: task libvirtd:1439 blocked for more than 120 seconds.
> [  249.758717]       Tainted: G        W   EL    4.19.55-xenomai #1
> [  249.764717] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  249.772655] INFO: task snmpd:2213 blocked for more than 120 seconds.
> [  249.778981]       Tainted: G        W   EL    4.19.55-xenomai #1
> [  249.784978] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  249.792893] INFO: task sshd:6746 blocked for more than 120 seconds.
> [  249.799132]       Tainted: G        W   EL    4.19.55-xenomai #1
> [  249.805128] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  249.813047] INFO: task sshd:6747 blocked for more than 120 seconds.
> [  249.819286]       Tainted: G        W   EL    4.19.55-xenomai #1
> [  249.825283] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [  266.131321] watchdog: BUG: soft lockup - CPU#41 stuck for 22s! 
> [qemu-system-aar:6706]
> [  266.151255] watchdog: BUG: soft lockup - CPU#45 stuck for 22s! 
> [qemu-system-aar:6707]
> [  270.091564] watchdog: BUG: soft lockup - CPU#32 stuck for 22s! 
> [kworker/32:2:486]
> [  278.262028] rcu: INFO: rcu_sched self-detected stall on CPU
> [  278.267584] rcu:     41-...0: (2 GPs behind) 
> idle=86e/1/0x4000000000000004 softirq=410/411 fqs=11968
> [  278.276501] rcu:      (t=24006 jiffies g=1549 q=16128)
> [  294.152843] watchdog: BUG: soft lockup - CPU#45 stuck for 22s! 
> [qemu-system-aar:6707]
> [  298.093056] watchdog: BUG: soft lockup - CPU#32 stuck for 22s! 
> [kworker/32:2:486]
> [  306.133374] watchdog: BUG: soft lockup - CPU#41 stuck for 23s! 
> [qemu-system-aar:6706]
> 
> 
> 
> 
>   Starting LSB: QEMU KVM module loading script...
>           Starting Show Plymouth Boot Screen...
> [   15.167317] PKCS#7 signature not signed with a trusted key
> [   74.429849] watchdog: BUG: soft lockup - CPU#18 stuck for 23s! 
> [qemu-system-aar:6724]
> [   74.437879] Kernel panic - not syncing: softlockup: hung tasks
> [   74.443687] CPU: 18 PID: 6724 Comm: qemu-system-aar Tainted: G  W   
> EL    4.19.55-xenomai #3
> [   74.452603] Hardware name: FT2000plus Generic Board & Memsize 64G (DT)
> [   74.459100] I-pipe domain: Linux
> [   74.462314] Call trace:
> [   74.464751]  dump_backtrace+0x0/0x1e0
> [   74.468397]  show_stack+0x24/0x30
> [   74.471700]  dump_stack+0xd8/0x100
> [   74.475088]  panic+0x148/0x2c4
> [   74.478133]  softlockup_fn+0x0/0x58
> [   74.481607]  __hrtimer_run_queues+0x204/0x4c8
> [   74.485945]  hrtimer_interrupt+0xec/0x248
> [   74.489939]  arch_timer_handler_phys+0x64/0x78
> [   74.494364]  handle_percpu_devid_irq+0xcc/0x330
> [   74.498874]  generic_handle_irq+0x34/0x50
> [   74.502866]  __handle_domain_irq+0x68/0xc0
> [   74.506945]  __ipipe_do_IRQ+0x38/0x48
> [   74.510592]  __ipipe_do_sync_stage+0x1f4/0x218
> [   74.515016]  ipipe_unstall_root+0x4c/0x58
> [   74.519008]  __do_softirq+0xcc/0x434
> [   74.522569]  irq_exit+0x12c/0x138
> [   74.525870]  __handle_domain_irq+0x6c/0xc0
> [   74.529948]  __ipipe_do_IRQ+0x38/0x48
> [   74.533595]  __ipipe_do_sync_stage+0x1f4/0x218
> [   74.538019]  __ipipe_do_sync_pipeline+0xa4/0xb8
> [   74.542530]  __ipipe_dispatch_irq+0x174/0x1d8
> [   74.546867]  __ipipe_grab_irq+0x4c/0xc0
> [   74.550686]  gic_handle_irq+0xf4/0x15c
> [   74.554419]  handle_arch_irq_pipelined+0x28/0x80
> [   74.559015]  el1_irq+0xc0/0x180
> [   74.562143]  invalidate_icache_range+0x28/0x50
> [   74.566568]  kvm_handle_guest_abort+0xa18/0xac0
> [   74.571079]  handle_exit+0x12c/0x1f0
> [   74.574638]  kvm_arch_vcpu_ioctl_run+0x4e4/0x918
> [   74.579235]  kvm_vcpu_ioctl+0x49c/0x9d0
> [   74.583056]  do_vfs_ioctl+0xc4/0x8b8
> [   74.586615]  ksys_ioctl+0x8c/0x98
> [   74.589915]  __arm64_sys_ioctl+0x28/0x38
> [   74.593820]  el0_svc_common+0xc8/0x1d0
> [   74.597553]  el0_svc_handler+0x30/0x40
> [   74.601286]  el0_svc+0x8/0x18
> [   74.604319] SMP: stopping secondary CPUs
> [   75.665390] SMP: failed to stop secondary CPUs 18,21
> [   75.670333] Kernel Offset: disabled
> [   75.673807] CPU features: 0x0,00800008
> [   75.677540] Memory Limit: none
> [   75.680661] Rebooting in 20 seconds..

So you are running a Xenomai kernel on the host machine and what to 
start off a KVM machine on top, right? I suspect we have not enabled KVM 
with I-pipe/Xenomai on ARM64 so far, therefore this host-side lock-up.

Likely doable, but it requires some deep digging into the vmentry/exit 
paths to check where and how the need to be made aware of I-pipe. 
Usually, a key issue is that related assembly code needs to be protected 
against interrupts that, due to I-pipe's soft interrupt mask, may now 
come too early.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

