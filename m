Message-ID: <48A43555.3070701@domain.hid>
Date: Thu, 14 Aug 2008 15:38:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080812075358.4cg1ix9945msccsc@domain.hid>	<48A12EA8.4070601@domain.hid>
	<48A34D75.9090509@domain.hid>	<48A359D4.9090002@domain.hid>
	<48A3D20B.2080509@domain.hid>	<48A3D595.9040607@domain.hid>
	<20080814125307.1uviqgmj95no4k0k@domain.hid>
In-Reply-To: <20080814125307.1uviqgmj95no4k0k@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [RTnet-users] e1000 & MSI
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: bernhard@domain.hid
Cc: adeos-main <adeos-main@gna.org>, RTnet-users@domain.hid

bernhard@domain.hid wrote:
>>> Found it. Could you give this patch a try and report the result?
>>>
>>> http://permalink.gmane.org/gmane.linux.kernel/682362
> 
> Applied and tested, no luck...
> 
> I-pipe: Detected illicit call from domain 'RTAI'
>          into a service reserved for domain 'Linux' and below.
> Pid: 0, comm: swapper Not tainted 2.6.26.2-FuCS #1
>   [<c0156866>] ipipe_check_context+0xd6/0xf0
> e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
>   [<c03e206e>] _spin_lock_irqsave+0x1e/0x80
>   [<c024a7a6>] pci_bus_read_config_word+0x36/0x80
>   [<c0254156>] __msi_set_enable+0x46/0x80
>   [<c01176f3>] ? mcount+0x1f/0x23
>   [<c0254498>] msi_set_mask_bits+0xd8/0xe0
>   [<c01176f3>] ? mcount+0x1f/0x23
>   [<c0254737>] unmask_msi_irq+0x17/0x30
>   [<c01542da>] default_enable+0x1a/0x30
>   [<f892f1ee>] rt_enable_irq+0xe/0x10 [rtai_hal]
>   [<f8dabd99>] ? xnintr_irq_handler+0x149/0x1f0 [rtai_rtdm]
>   [<f893164b>] rtai_hirq_dispatcher+0xfb/0x430 [rtai_hal]
>   [<c01021c5>] default_idle+0x45/0x60
>   [<c0102180>] default_idle+0x0/0x60
>   [<c0103cc7>] common_interrupt+0x2f/0x54
>   [<c0102180>] default_idle+0x0/0x60
>   [<c01500d8>] cgroup_file_write+0x118/0x140
>   [<c01021c5>] default_idle+0x45/0x60
>   [<c0101b76>] cpu_idle+0x86/0x140
>   [<c03dd7fd>] start_secondary+0x16d/0x210
>   [<c03d3a88>] initialize_secondary+0x8/0x20
>   =======================
> I-pipe tracer log (100 points):
>   |  +*func                    0 ipipe_trace_panic_freeze+0x9  

I see no option aside of ironing the inner code that reads/writes the PCI
config, so here is an ugly yet possible solution for x86, that might work
(totally untested):

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 6e64aaf..7f32101 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -75,7 +75,7 @@ int pcibios_scanned;
  * This interrupt-safe spinlock protects all accesses to PCI
  * configuration space.
  */
-DEFINE_SPINLOCK(pci_config_lock);
+IPIPE_DEFINE_SPINLOCK(pci_config_lock);

 static int __devinit can_skip_ioresource_align(const struct dmi_system_id *d)
 {
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 39bb96b..9a74083 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -12,7 +12,7 @@
  * configuration space.
  */

-static DEFINE_SPINLOCK(pci_lock);
+static IPIPE_DEFINE_SPINLOCK(pci_lock);

 /*
  *  Wrappers for all PCI configuration access functions.  They just check

> (ipipe_check_context+0x94)
>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>   |  +*func                    0 find_next_bit+0xa (__next_cpu+0x1a)
>   |  +*func                    0 __next_cpu+0x9 (ipipe_check_context+0x88)
>   |  +*func                    0 find_first_bit+0xa (__first_cpu+0x12)
>   |  +*func                   -1 __first_cpu+0x8 (ipipe_check_context+0x66)
>   |  +*func                   -1 ipipe_check_context+0x14  
> (_spin_lock_irqsave+0x1e)
>   |  +*func                   -1 _spin_lock_irqsave+0x12  
> (pci_bus_read_config_word+0x36)
>   |  +*func                   -1 pci_bus_read_config_word+0x14  
> (__msi_set_enable+0x46)
>   |  +*func                   -1 __msi_set_enable+0x14 (msi_set_mask_bits+0xd8)
>   |  +*func                   -1 msi_set_mask_bits+0xe (unmask_msi_irq+0x17)
>   |  +*func                   -1 unmask_msi_irq+0x9 (default_enable+0x1a)
>   |  +*func                   -1 default_enable+0x9 (rt_enable_irq+0xe  
> [rtai_hal])
>   |  +*func                   -2 alloc_rtskb+0x14 [rtnet]  
> (e1000_alloc_rx_buffers+0x147 [rt_e1000])
>   |  +*func                   -2 e1000_alloc_rx_buffers+0xe [rt_e1000]  
> (e1000_intr+0x37d [rt_e1000])
>   |  +*func                   -4 e1000_intr+0x11 [rt_e1000]  
> (xnintr_irq_handler+0x9e [rtai_rtdm])
>   |  +*func                   -5 xnintr_irq_handler+0xe [rtai_rtdm]  
> (rtai_hirq_dispatcher+0xfb [rtai_hal])
>   |  +*func                   -5 ack_ioapic_irq+0x8 (__ipipe_ack_edge_irq+0xe)
>   |  +*func                   -5 __ipipe_ack_edge_irq+0x8  
> (__ipipe_ack_irq+0x19)
>   |  +*func                   -5 __ipipe_ack_irq+0x8  
> (rtai_hirq_dispatcher+0x66 [rtai_hal])
>   |   +begin   0xffffff23     -5 common_interrupt+0x29 (default_idle+0x45)
>       +end     0x8000000e   -580 default_idle+0x43 (cpu_idle+0x86)
>       +func                 -580 default_idle+0x8 (cpu_idle+0x86)
>   |   +end     0x80000001   -581 ipipe_suspend_domain+0xd7 (cpu_idle+0x84)
>   |   #begin   0x80000001   -581 ipipe_suspend_domain+0xee (cpu_idle+0x84)
>       #func                 -581 ipipe_suspend_domain+0xe (cpu_idle+0x84)
>       +func                 -581 ipipe_check_context+0x14 (cpu_idle+0x5b)
>       +func                 -581 ipipe_check_context+0x14  
> (_spin_unlock_irqrestore+0x23)
>   |   +end     0x80000000   -581 __ipipe_unstall_root+0x4a  
> (__ipipe_restore_root+0x27)
>   |   #begin   0x80000000   -581 __ipipe_unstall_root+0x5b  
> (__ipipe_restore_root+0x27)
>       #func                 -581 __ipipe_unstall_root+0x8  
> (__ipipe_restore_root+0x27)
>       #func                 -581 __ipipe_restore_root+0x8  
> (_spin_unlock_irqrestore+0x3d)
>       #func                 -581 _spin_unlock_irqrestore+0x8  
> (rcu_check_callbacks+0x5c)
>       #func                 -582 __rcu_advance_callbacks+0x8  
> (rcu_check_callbacks+0x35)
>       #func                 -582 ipipe_check_context+0x14  
> (_spin_lock_irqsave+0x49)
>       +func                 -582 ipipe_check_context+0x14  
> (_spin_lock_irqsave+0x1e)
>       +func                 -582 _spin_lock_irqsave+0x12  
> (rcu_check_callbacks+0x2c)
>       +func                 -582 rcu_check_mb+0x8 (rcu_check_callbacks+0x1b)
>       +func                 -582 rcu_check_callbacks+0xa (cpu_idle+0xb2)
>       +func                 -582 rcu_pending+0x8 (cpu_idle+0xa5)
>   |   +end     0x8000000d   -583 __ipipe_unstall_iret_root+0x36  
> (restore_nocheck_notrace+0x0)
>   |   #func                 -583 __ipipe_unstall_iret_root+0x9  
> (restore_nocheck_notrace+0x0)
>   |   #end     0xffffff15   -583 ipipe_ipiX+0x3e (default_idle+0x45)
>   |   +end     0x8000000d   -583 __ipipe_unstall_iret_root+0x36  
> (restore_nocheck_notrace+0x0)
>   |   #func                 -583 __ipipe_unstall_iret_root+0x9  
> (restore_nocheck_notrace+0x0)
>       #func                 -585 __ipipe_do_critical_sync+0x9  
> (__ipipe_sync_stage+0x27b)
>   |   #end     0x80000000   -586 __ipipe_sync_stage+0x21f  
> (rtai_hirq_dispatcher+0x3a1 [rtai_hal])
>   |   +func                 -586 __ipipe_sync_stage+0xe  
> (rtai_hirq_dispatcher+0x3a1 [rtai_hal])
>   |   #func                 -586 __ipipe_ack_apic+0x8  
> (rtai_hirq_dispatcher+0x257 [rtai_hal])
>   |   +begin   0xffffff15   -587 ipipe_ipiX+0x2e (default_idle+0x45)
>       +end     0x8000000e  -318728 default_idle+0x43 (cpu_idle+0x86)
>       +func                -318728 default_idle+0x8 (cpu_idle+0x86)
>   |   +end     0x80000001  -318728 ipipe_suspend_domain+0xd7 (cpu_idle+0x84)
>   |   #begin   0x80000001  -318728 ipipe_suspend_domain+0xee (cpu_idle+0x84)
>       #func                -318728 ipipe_suspend_domain+0xe (cpu_idle+0x84)
>       +func                -318729 ipipe_check_context+0x14 (cpu_idle+0x5b)
>       +func                -318729 rcu_pending+0x8 (cpu_idle+0xa5)
>   |   +end     0x80000000  -318729 __ipipe_unstall_root+0x4a  
> (__ipipe_restore_root+0x27)
>   |   #begin   0x80000000  -318729 __ipipe_unstall_root+0x5b  
> (__ipipe_restore_root+0x27)
>       #func                -318729 __ipipe_unstall_root+0x8  
> (__ipipe_restore_root+0x27)
>       #func                -318729 __ipipe_restore_root+0x8  
> (tick_nohz_stop_sched_tick+0x23b)
>       #func                -318729 ipipe_check_context+0x14  
> (hrtimer_start+0xe1)
>       #func                -318729 ipipe_check_context+0x14  
> (_spin_unlock_irqrestore+0x23)
>       #func                -318729 __ipipe_restore_root+0x8  
> (_spin_unlock_irqrestore+0x19)
>       #func                -318729 _spin_unlock_irqrestore+0x8  
> (hrtimer_start+0xd2)
>       #func                -318729 ipipe_check_context+0x14  
> (hrtimer_start+0xba)
>       #func                -318730 rb_insert_color+0xe (enqueue_hrtimer+0x7d)
>       #func                -318730 lapic_next_event+0x8  
> (clockevents_program_event+0x9e)
>       #func                -318730 clockevents_program_event+0x14  
> (tick_program_event+0x44)
>       #func                -318730 set_normalized_timespec+0x8  
> (ktime_get_ts+0x43)
>       #func                -318730 native_read_tsc+0x8 (read_tsc+0xe)
>       #func                -318730 read_tsc+0x9 (getnstimeofday+0x48)
>       #func                -318730 getnstimeofday+0xe (ktime_get_ts+0x22)
>       #func                -318730 ktime_get_ts+0xa (ktime_get+0x1e)
>       #func                -318730 ktime_get+0x14 (tick_program_event+0x29)
>       #func                -318730 tick_program_event+0xe  
> (hrtimer_reprogram+0x86)
>       #func                -318731 hrtimer_reprogram+0x14  
> (enqueue_hrtimer+0xaa)
>       #func                -318731 enqueue_hrtimer+0xe (hrtimer_start+0xad)
>       #func                -318731 rb_erase+0xe (__remove_hrtimer+0x57)
>       #func                -318731 hrtimer_force_reprogram+0xa  
> (__remove_hrtimer+0x83)
>       #func                -318731 rb_next+0x9 (__remove_hrtimer+0x5e)
>       #func                -318731 __remove_hrtimer+0x16 (hrtimer_start+0x123)
>       #func                -318731 ipipe_check_context+0x14  
> (_spin_lock_irqsave+0x49)
>       #func                -318731 ipipe_check_context+0x14  
> (_spin_lock_irqsave+0x1e)
>       #func                -318731 _spin_lock_irqsave+0x12  
> (lock_hrtimer_base+0x28)
>       #func                -318731 lock_hrtimer_base+0x16 (hrtimer_start+0x1e)
>       #func                -318732 hrtimer_start+0xe  
> (tick_nohz_stop_sched_tick+0x255)
>       #func                -318732 hweight32+0x8  
> (select_nohz_load_balancer+0x58)
>       #func                -318732 hweight32+0x8  
> (select_nohz_load_balancer+0x4a)
>       #func                -318732 select_nohz_load_balancer+0xa  
> (tick_nohz_stop_sched_tick+0x287)
>       #func                -318732 rcu_needs_cpu+0x8  
> (tick_nohz_stop_sched_tick+0x13c)
>       #func                -318732 ipipe_check_context+0x14  
> (_spin_unlock_irqrestore+0x23)
>       #func                -318732 __ipipe_restore_root+0x8  
> (_spin_unlock_irqrestore+0x19)
>       #func                -318732 _spin_unlock_irqrestore+0x8  
> (hrtimer_get_next_event+0xdb)
>       #func                -318732 ipipe_check_context+0x14  
> (_spin_lock_irqsave+0x49)
> 
> 
>>> If it's ok, I guess we should include it in ipipe until someone (From
>>> -rt) manages to get it accepted upstream (I didn't recall much activity
>>> in this direction yet, though).
>> Not true, the patch is in 2.6.27-rcX.
>>
>> But there is also
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ce6fce4295ba727b36fdc73040e444bd1aae64cd
>> which makes me wonder, for 2.6.27, if that may generate cases where
>> masking MSI interrupts will not work as expected for ipipe (Linux should
>> catch masked IRQs internally). However, future problems...
> 
> Bernhard
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 


-- 
Philippe.

