References: <e28cb7b73db9bfe4faa08f3c6468a59ed578a366.camel@siemens.com>
 <87sfyhiwgn.fsf@xenomai.org>
 <283717e4400fce5376df6e92339e8fdd41f634ea.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: irq pipeline: Netdev watchdog triggered
In-reply-to: <283717e4400fce5376df6e92339e8fdd41f634ea.camel@siemens.com>
Date: Mon, 06 Sep 2021 18:16:03 +0200
Message-ID: <87lf49issc.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>


Bezdeka, Florian <florian.bezdeka@siemens.com> writes:

> On Mon, 2021-09-06 at 16:56 +0200, Philippe Gerum wrote:
>> Bezdeka, Florian <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi,
>> > 
>> > here is another IRQ_PIPELINE problem we're facing on on of our quite
>> > big Xenomai machines: 
>> > 
>> > Platform:
>> > Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz
>> > 2 Sockets, 6 cores per socket, 2 threads per core
>> > (2 NUMA nodes)
>> > 
>> > As soon as we enable CONFIG_IRQ_PIPELINE the netdev watchdog triggers.
>> > There is no specific load on the system. In most cases the watchdog
>> > triggers right after booting up. There is no xenomai task running when
>> > the crash happens.
>> > 
>> > The problem was detected during reboot tests. Disabling
>> > CONFIG_IRQ_PIPELINE helped. We didn't run into a problem for >400
>> > reboots.
>> > 
>> > Any advise how to debug that? Dovetail torture tests have already been
>> > run and there was no error reported. CONFIG_DEBUG_IRQ_PIPELINE is
>> > enabled as well and did not help so far.
>> > 
>> > The stacktrace follows but I guess it's not really helpful:
>> > 
>> > ------------[ cut here ]------------
>> > [   42.114151] NETDEV WATCHDOG: enp7s0f0 (igb): transmit queue 5 timed out
>> > [   42.114173] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:467 dev_watchdog+0x205/0x210
>> > [   42.163593] Modules linked in: overlay x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul mei_me iTCO_wdt iTCO_vendor_support mei hed ipmi_si ipmi_devintf ipmi_msghandler msr fuse configfs ip_tables x_tables ipv6 autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx hid_generic usbhid hid raid6_pq libcrc32c raid1 raid0 multipath linear lpc_ich ahci i2c_i801 xhci_pci i2c_smbus mfd_core libahci mpt3sas igb i2c_algo_bit raid_class xhci_hcd scsi_transport_sas
>> > [   42.435191] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.61-dovetaildbg-noxeno-pipedbg-0 #1
>> > [   42.486198] Hardware name: Siemens <...snip...>, BIOS s2.0a_M1 08/02/2016
>> > [   42.546050] IRQ stage: Linux
>> > [   42.563263] RIP: 0010:dev_watchdog+0x205/0x210
>> > [   42.589837] Code: 91 26 fe ff eb b1 4c 89 ef c6 05 9e 1d b7 00 01 e8 90 86 fb ff 44 89 e1 4c 89 ee 48 c7 c7 48 41 de b7 48 89 c2 e8 8a c1 0a 00 <0f> 0b eb 92 0f 1f 80 00 00 00 00 0f 1f 44 00 00 f0 80 a7 d8 00 00
>> > [   42.702205] RSP: 0018:ffff9ff4c0003ec0 EFLAGS: 00010282
>> > [   42.733459] RAX: 0000000000000000 RBX: ffff930cc42438c0 RCX: 4000000000000002
>> > [   42.776148] RDX: 4000000000000004 RSI: 0000000000000000 RDI: ffffffffb70cb824
>> > [   42.818841] RBP: ffff930cc7e903b8 R08: 000000000007daee R09: ffff9ff4c0003cc8
>> > [   42.861531] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000000006
>> > [   42.904224] R13: ffff930cc7e90000 R14: ffffffffb7686860 R15: ffff9ff4c0003f18
>> > [   42.946916] FS:  0000000000000000(0000) GS:ffff931bff800000(0000) knlGS:0000000000000000
>> > [   42.995328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [   43.029700] CR2: 000000c000e50000 CR3: 00000001057ca001 CR4: 00000000001706f0
>> > [   43.072391] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > [   43.115082] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > [   43.157774] Call Trace:
>> > [   43.172388]  <IRQ>
>> > [   43.184400]  ? pfifo_fast_dequeue+0x1e0/0x1e0
>> > [   43.210453]  call_timer_fn+0x2b/0x100
>> > [   43.232344]  __run_timers.part.0+0x1d9/0x250
>> > [   43.257879]  ? ktime_get+0x35/0x90
>> > [   43.278205]  run_timer_softirq+0x26/0x50
>> > [   43.301661]  __do_softirq+0x105/0x30b
>> > [   43.323550]  asm_call_irq_on_stack+0xf/0x20
>> > [   43.348562]  </IRQ>
>> > [   43.361099]  do_softirq_own_stack+0x37/0x40
>> > [   43.386108]  irq_exit_rcu+0xaa/0xe0
>> > [   43.406960]  arch_do_IRQ_pipelined+0x78/0x130
>> > [   43.433012]  sync_current_irq_stage+0x177/0x250
>> > [   43.460100]  __inband_irq_enable+0x4c/0x50
>> > [   43.484593]  cpuidle_enter_state+0x100/0x3a0
>> > [   43.510125]  cpuidle_enter+0x29/0x40
>> > [   43.531498]  do_idle+0x1eb/0x230
>> > [   43.550787]  cpu_startup_entry+0x19/0x20
>> > [   43.574241]  start_kernel+0x56d/0x590
>> > [   43.596134]  secondary_startup_64_no_verify+0xb0/0xbb
>> > [   43.626343] ---[ end trace b219258fce8dc761 ]---
>> > [   43.654095] igb 0000:07:00.0 enp7s0f0: Reset adapter
>> > [   46.090948] igb 0000:07:00.0: exceed max 2 second
>> > 
>> 
>> Might be an interrupt stuck in the in-band log of the pipeline, in which
>> case the CPU would go idle without synchronizing the log, leaving a
>> pending IRQ unhandled until the next exit from the idle state. I wonder
>> if the unstable TSC issue might not be another symptom of that kind of
>> cause.
>> 
>> Do you see any change when booting with idle=poll?
>> 
>
> The call stack looks different with idle=poll, as expected:
>
> [   48.752335] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:467 dev_watchdog+0x205/0x210
> [   48.801769] Modules linked in: sha512_ssse3 sha512_generic cmac sha256_ssse3 sha256_generic libsha256 hmac nls_cp437 cifs libdes libarc4 xt_conntrack xt_MASQUERADE xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conn                track nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc overlay x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul mei_me iTCO_wdt iTCO_vendor_support mei hed ipmi_si ipmi_devintf ipmi_msghandler msr fuse configfs ip_tables x_tables ipv6 autofs4 hid_generic usbhid hid raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq libcrc32c raid1 raid0 multipath linear i2c_i801 lpc_ich i2c_smbus ahci igb mfd_core xhci_pci libahci mpt3sas i2c_algo_bit raid_class xhci_hcd scsi_transport_sas
> [   49.213706] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.53-xenomai-0 #1
> [   49.254843] Hardware name: Siemens <...snip...>, BIOS s2.0a_M1 08/02/2016
> [   49.314694] IRQ stage: Linux
> [   49.331907] RIP: 0010:dev_watchdog+0x205/0x210
> [   49.358477] Code: b1 26 fe ff eb b1 4c 89 ef c6 05 fb 23 b4 00 01 e8 d0 87 fb ff 44 89 e1 4c 89 ee 48 c7 c7 18 09 df b9 48 89 c2 e8 c3 c1 0a 00 <0f> 0b eb 92 0f 1f 80 00 00 00 00 0f 1f 44 00 00 f0 80 a7 d8 00 00
> [   49.470849] RSP: 0018:ffffa041c0003ec0 EFLAGS: 00010282
> [   49.470851] RAX: 0000000000000000 RBX: ffff90ca43edb8c0 RCX: ffff90c9ff817948
> [   49.470852] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff90c9ff817940
> [   49.470854] RBP: ffff90bac76e03b8 R08: ffffffffba139e28 R09: 0000000000009ffb
> [   49.470857] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000000002
> [   49.672860] R13: ffff90bac76e0000 R14: ffffffffb96ca7a0 R15: ffffa041c0003f18
> [   49.723877] FS:  0000000000000000(0000) GS:ffff90c9ff800000(0000) knlGS:0000000000000000
> [   49.780606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   49.823302] CR2: 00007f96466f7048 CR3: 0000001087a60006 CR4: 00000000001706f0
> [   49.868591] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   49.911284] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   49.953977] Call Trace:
> [   49.968593]  <IRQ>
> [   49.980597]  ? pfifo_fast_dequeue+0x1e0/0x1e0
> [   50.006654]  call_timer_fn+0x2b/0x100
> [   50.028544]  __run_timers.part.0+0x1d9/0x250
> [   50.054078]  ? proxy_set_next_ktime+0x155/0x180
> [   50.081163]  run_timer_softirq+0x26/0x50
> [   50.104620]  __do_softirq+0x105/0x30b
> [   50.126512]  asm_call_irq_on_stack+0xf/0x20
> [   50.151518]  </IRQ>
> [   50.164059]  do_softirq_own_stack+0x37/0x40
> [   50.189067]  irq_exit_rcu+0xaa/0xe0
> [   50.209920]  arch_do_IRQ_pipelined+0xbf/0x130
> [   50.235974]  sync_current_irq_stage+0x157/0x1f0
> [   50.263061]  handle_irq_pipelined_finish+0x8b/0x190
> [   50.292240]  arch_pipeline_entry+0xb0/0x100
> [   50.317247]  asm_sysvec_apic_timer_interrupt+0xf/0x20
> [   50.347459] RIP: 0010:cpu_idle_poll.isra.0+0x46/0xe0
> [   50.377147] Code: 40 3a 99 ff e8 8b 7c 92 ff e8 06 2b 99 ff 65 48 8b 1c 25 c0 6c 01 00 e8 c8 be 91 ff 48 8b 03 a8 08                 74 0b eb 1c f3 90 48 8b 03 <a8> 08 75 13 8b 05 e0 35 a7 00 85 c0 75 ed e8 07 61 94 ff 85 c0 75
> [   50.489518] RSP: 0018:ffffffffba003eb8 EFLAGS: 00000202
> [   50.520767] RAX: 0000000000204000 RBX: ffffffffba011940 RCX: 000000000000001f
> [   50.563463] RDX: 000000001bbb4d5a RSI: 0000000000000000 RDI: ffffffffb97afefa
> [   50.606154] RBP: 0000000000000000 R08: 000000001bbb4d5a R09: 0000000000000000
> [   50.648840] R10: 0000000000001400 R11: 0000000000000000 R12: 00000000000000ac
> [   50.691537] R13: ffffffffba6150a0 R14: 0000000000000001 R15: 0000000000000008
> [   50.734226]  ? cpu_idle_poll.isra.0+0x2a/0xe0
> [   50.760278]  ? cpu_idle_poll.isra.0+0x38/0xe0
> [   50.786336]  do_idle+0x7e/0x200
>
> Where would be the right place to add a warning when one of the CPUs
> tries to enter the idle state with pending IRQs?

Something like this:

diff --git a/include/linux/irq_pipeline.h b/include/linux/irq_pipeline.h
index cbeb0109fa7ff47..17436e10e620072 100644
--- a/include/linux/irq_pipeline.h
+++ b/include/linux/irq_pipeline.h
@@ -88,6 +88,8 @@ int handle_irq_pipelined(struct pt_regs *regs);
 
 void sync_inband_irqs(void);
 
+bool irq_is_pending(void);
+
 extern struct irq_domain *synthetic_irq_domain;
 
 #else /* !CONFIG_IRQ_PIPELINE */
@@ -134,6 +136,11 @@ static inline bool inband_irq_pending(void)
 
 static inline void sync_inband_irqs(void) { }
 
+static inline bool irq_is_pending(void)
+{
+	return false;
+}
+
 #endif /* !CONFIG_IRQ_PIPELINE */
 
 #if !defined(CONFIG_IRQ_PIPELINE) || !defined(CONFIG_SPARSE_IRQ)
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index c4974a8d7244dec..116214690d47cda 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1575,6 +1575,18 @@ bool irq_cpuidle_enter(struct cpuidle_device *dev,
 	return irq_cpuidle_control(dev, state);
 }
 
+bool irq_is_pending(void)
+{
+	unsigned long flags;
+	bool ret;
+
+	flags = hard_local_irq_save();
+	ret = inband_irq_pending();
+	hard_local_irq_restore(flags);
+
+	return ret;
+}
+
 static unsigned int inband_work_sirq;
 
 static irqreturn_t inband_work_interrupt(int sirq, void *dev_id)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e8bb54eeb0c98af..702e08143108881 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -115,6 +115,7 @@ void __cpuidle default_idle_call(void)
 		rcu_idle_enter();
 		lockdep_hardirqs_on(_THIS_IP_);
 
+		WARN_ON_ONCE(irq_is_pending());
 		arch_cpu_idle();
 
 		/*
@@ -252,6 +253,7 @@ static void cpuidle_idle_call(void)
 	}
 
 exit_idle:
+	WARN_ON_ONCE(irq_is_pending());
 	__current_set_polling();
 
 	/*
-- 
Philippe.

