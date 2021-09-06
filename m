Subject: Re: irq pipeline: Netdev watchdog triggered
References: <e28cb7b73db9bfe4faa08f3c6468a59ed578a366.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0bd9927a-8c31-bd87-2e15-6a9b90bce6c9@siemens.com>
Date: Mon, 6 Sep 2021 15:31:56 +0200
MIME-Version: 1.0
In-Reply-To: <e28cb7b73db9bfe4faa08f3c6468a59ed578a366.camel@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06.09.21 14:58, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> Hi,
> 
> here is another IRQ_PIPELINE problem we're facing on on of our quite
> big Xenomai machines:
> 
> Platform:
> Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz
> 2 Sockets, 6 cores per socket, 2 threads per core
> (2 NUMA nodes)
> 
> As soon as we enable CONFIG_IRQ_PIPELINE the netdev watchdog triggers.
> There is no specific load on the system. In most cases the watchdog
> triggers right after booting up. There is no xenomai task running when
> the crash happens.
> 
> The problem was detected during reboot tests. Disabling
> CONFIG_IRQ_PIPELINE helped. We didn't run into a problem for >400
> reboots.
> 
> Any advise how to debug that? Dovetail torture tests have already been
> run and there was no error reported. CONFIG_DEBUG_IRQ_PIPELINE is
> enabled as well and did not help so far.
> 
> The stacktrace follows but I guess it's not really helpful:
> 
> ------------[ cut here ]------------
> [   42.114151] NETDEV WATCHDOG: enp7s0f0 (igb): transmit queue 5 timed out
> [   42.114173] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:467 dev_watchdog+0x205/0x210
> [   42.163593] Modules linked in: overlay x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul mei_me iTCO_wdt iTCO_vendor_support mei hed ipmi_si ipmi_devintf ipmi_msghandler msr fuse configfs ip_tables x_tables ipv6 autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx hid_generic usbhid hid raid6_pq libcrc32c raid1 raid0 multipath linear lpc_ich ahci i2c_i801 xhci_pci i2c_smbus mfd_core libahci mpt3sas igb i2c_algo_bit raid_class xhci_hcd scsi_transport_sas
> [   42.435191] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.61-dovetaildbg-noxeno-pipedbg-0 #1
> [   42.486198] Hardware name: Siemens <...snip...>, BIOS s2.0a_M1 08/02/2016
> [   42.546050] IRQ stage: Linux
> [   42.563263] RIP: 0010:dev_watchdog+0x205/0x210
> [   42.589837] Code: 91 26 fe ff eb b1 4c 89 ef c6 05 9e 1d b7 00 01 e8 90 86 fb ff 44 89 e1 4c 89 ee 48 c7 c7 48 41 de b7 48 89 c2 e8 8a c1 0a 00 <0f> 0b eb 92 0f 1f 80 00 00 00 00 0f 1f 44 00 00 f0 80 a7 d8 00 00
> [   42.702205] RSP: 0018:ffff9ff4c0003ec0 EFLAGS: 00010282
> [   42.733459] RAX: 0000000000000000 RBX: ffff930cc42438c0 RCX: 4000000000000002
> [   42.776148] RDX: 4000000000000004 RSI: 0000000000000000 RDI: ffffffffb70cb824
> [   42.818841] RBP: ffff930cc7e903b8 R08: 000000000007daee R09: ffff9ff4c0003cc8
> [   42.861531] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000000006
> [   42.904224] R13: ffff930cc7e90000 R14: ffffffffb7686860 R15: ffff9ff4c0003f18
> [   42.946916] FS:  0000000000000000(0000) GS:ffff931bff800000(0000) knlGS:0000000000000000
> [   42.995328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.029700] CR2: 000000c000e50000 CR3: 00000001057ca001 CR4: 00000000001706f0
> [   43.072391] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   43.115082] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   43.157774] Call Trace:
> [   43.172388]  <IRQ>
> [   43.184400]  ? pfifo_fast_dequeue+0x1e0/0x1e0
> [   43.210453]  call_timer_fn+0x2b/0x100
> [   43.232344]  __run_timers.part.0+0x1d9/0x250
> [   43.257879]  ? ktime_get+0x35/0x90
> [   43.278205]  run_timer_softirq+0x26/0x50
> [   43.301661]  __do_softirq+0x105/0x30b
> [   43.323550]  asm_call_irq_on_stack+0xf/0x20
> [   43.348562]  </IRQ>
> [   43.361099]  do_softirq_own_stack+0x37/0x40
> [   43.386108]  irq_exit_rcu+0xaa/0xe0
> [   43.406960]  arch_do_IRQ_pipelined+0x78/0x130
> [   43.433012]  sync_current_irq_stage+0x177/0x250
> [   43.460100]  __inband_irq_enable+0x4c/0x50
> [   43.484593]  cpuidle_enter_state+0x100/0x3a0
> [   43.510125]  cpuidle_enter+0x29/0x40
> [   43.531498]  do_idle+0x1eb/0x230
> [   43.550787]  cpu_startup_entry+0x19/0x20
> [   43.574241]  start_kernel+0x56d/0x590
> [   43.596134]  secondary_startup_64_no_verify+0xb0/0xbb
> [   43.626343] ---[ end trace b219258fce8dc761 ]---
> [   43.654095] igb 0000:07:00.0 enp7s0f0: Reset adapter
> [   46.090948] igb 0000:07:00.0: exceed max 2 second
> 

This is just the warning from the NIC watchdog handler. What we still
need to find out is the health of other NIC interrupts around this
event. Also if other interrupts are possibly affected as well or just
one or more of the device.

BTW, can we recover the device by ifdown/up? Or by driver unbind/bind?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

