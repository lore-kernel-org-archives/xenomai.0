MIME-Version: 1.0
In-Reply-To: <CAPRPZsAOCxCGYhNmasXpFAK1bU_9LL78W9ribuLWh-Y1xxs1RQ@mail.gmail.com>
References: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>
 <534BD45B.8070402@xenomai.org>
 <CAPRPZsDSg6Yb3w+UEktb+7AmdZ-7JngVQH4tBbxnk5EV04y0AA@mail.gmail.com>
 <534D44CA.3000105@xenomai.org>
 <CAPRPZsD6r6y6UpYsN544WeLxYEnruKzjoHH4e33NPKEDCswJqQ@mail.gmail.com>
 <534E926F.9090706@xenomai.org>
 <CAPRPZsAOCxCGYhNmasXpFAK1bU_9LL78W9ribuLWh-Y1xxs1RQ@mail.gmail.com>
Date: Thu, 24 Apr 2014 12:21:47 +0200
Message-ID: <CAPRPZsBOngBwdht7FsnaqVAJObuugr=TAGETcnF6ZKVajbPvgQ@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Philippe,


Disabling CONFIG_RCU_USER_QS ('General setup -> RCU Subsystem ->
Consider userspace as in RCU extended quiescent state') at least
avoids the warning.

Further investigation shows that it is actually
CONFIG_CONTEXT_TRACKING_FORCE ('General setup -> RCU Subsystem ->
Force context tracking') that seems to cause the issue
(CONFIG_RCU_USER_QS and CONFIG_CONTEXT_TRACKING still enabled in this
case).


Jeroen.

2014-04-16 22:42 GMT+02:00 Jeroen Van den Keybus
<jeroen.vandenkeybus@gmail.com>:
>> Could you check your kernel logs for this initial warning? Maybe this would
>> shed light, assuming the second bug may be a side-effect of the first one.
>
> You are right, there are no less than 5 such warnings. Please see below.
>
> [  221.680546] ------------[ cut here ]------------
> [  221.680558] WARNING: at kernel/rcutree.c:388 rcu_eqs_enter+0x8b/0xa0()
> [  221.680564] Modules linked in: xeno_native xeno_nucleus coretemp
> mperf ghash_clmulni_intel i915 aesni_intel aes_x86_64 lrw
>  gf128mul glue_helper ablk_helper cryptd e1000e firewire_ohci igb
> lpc_ich firewire_core mfd_core crc_itu_t ehci_pci hwmon ehci_hcd ptp
> pps_core i2c_algo_bit thermal drm_kms_helper fan xhci_hcd drm usbcore
> video backlight usb_common processor
> [  221.680739] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.10.18-ipipe #23
> [  221.680745] Hardware name: Supermicro X10SAE/X10SAE, BIOS 1.1a 01/03/2014
> [  221.680752]  0000000000000009 ffff8802124ffe68 ffffffff814a43cc
> ffff8802124ffea0
> [  221.680774]  ffffffff8103da61 ffff88021580d7a0 0000000000000000
> ffff8802124fffd8
> [  221.680795]  ffff8802124fffd8 0000000000000000 ffff8802124ffeb0
> ffffffff8103db3a
> [  221.680817] Call Trace:
> [  221.680832]  [<ffffffff814a43cc>] dump_stack+0x19/0x1b
> [  221.680845]  [<ffffffff8103da61>] warn_slowpath_common+0x61/0x80
> [  221.680859]  [<ffffffff8103db3a>] warn_slowpath_null+0x1a/0x20
> [  221.680870]  [<ffffffff810be23b>] rcu_eqs_enter+0x8b/0xa0
> [  221.680882]  [<ffffffff810beead>] rcu_idle_enter+0x4d/0x70
> [  221.680896]  [<ffffffff81083f39>] cpu_startup_entry+0xa9/0x260
> [  221.680908]  [<ffffffff8108c058>] ? clockevents_config_and_register+0x28/0x30
> [  221.680922]  [<ffffffff8149b057>] start_secondary+0x24b/0x24d
> [  221.680937] ---[ end trace 0cb6d956934dc702 ]---
> [  221.680944] ------------[ cut here ]------------
> [  221.680951] WARNING: at kernel/rcutree.c:363
> rcu_eqs_enter_common.isra.31+0xd1/0xe0()
> [  221.680956] Modules linked in: xeno_native xeno_nucleus coretemp
> mperf ghash_clmulni_intel i915 aesni_intel aes_x86_64 lrw
>  gf128mul glue_helper ablk_helper cryptd e1000e firewire_ohci igb
> lpc_ich firewire_core mfd_core crc_itu_t ehci_pci hwmon ehci_hcd ptp
> pps_core i2c_algo_bit thermal drm_kms_helper fan xhci_hcd drm usbcore
> video backlight usb_common processor
> [  221.681123] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 3.10.18-ipipe #23
> [  221.681129] Hardware name: Supermicro X10SAE/X10SAE, BIOS 1.1a 01/03/2014
> [  221.681135]  0000000000000009 ffff8802124ffe38 ffffffff814a43cc
> ffff8802124ffe70
> [  221.681157]  ffffffff8103da61 ffff88021580d7a0 ffff8802124edcc0
> ffff8802124fffd8
> [  221.681179]  ffff8802124fffd8 0000000000000000 ffff8802124ffe80
> ffffffff8103db3a
> [  221.681201] Call Trace:
> [  221.681213]  [<ffffffff814a43cc>] dump_stack+0x19/0x1b
> [  221.681225]  [<ffffffff8103da61>] warn_slowpath_common+0x61/0x80
> [  221.681239]  [<ffffffff8103db3a>] warn_slowpath_null+0x1a/0x20
> [  221.681250]  [<ffffffff810be1a1>] rcu_eqs_enter_common.isra.31+0xd1/0xe0
> [  221.681263]  [<ffffffff810be20c>] rcu_eqs_enter+0x5c/0xa0
> [  221.681275]  [<ffffffff810beead>] rcu_idle_enter+0x4d/0x70
> [  221.681287]  [<ffffffff81083f39>] cpu_startup_entry+0xa9/0x260
> [  221.681299]  [<ffffffff8108c058>] ? clockevents_config_and_register+0x28/0x30
> [  221.681313]  [<ffffffff8149b057>] start_secondary+0x24b/0x24d
> [  221.681327] ---[ end trace 0cb6d956934dc703 ]---
> [  221.683367] ------------[ cut here ]------------
> [  221.683375] WARNING: at kernel/rcutree.c:482 rcu_irq_exit+0xc9/0xe0()
> [  221.683381] Modules linked in: xeno_native xeno_nucleus coretemp
> mperf ghash_clmulni_intel i915 aesni_intel aes_x86_64 lrw gf128mul
> glue_helper ablk_helper cryptd e1000e firewire_ohci igb lpc_ich
> firewire_core mfd_core crc_itu_t ehci_pci hwmon ehci_hcd ptp pps_core
> i2c_algo_bit thermal drm_kms_helper fan xhci_hcd drm usbcore video
> backlight usb_common processor
> [  221.683548] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 3.10.18-ipipe #23
> [  221.683554] Hardware name: Supermicro X10SAE/X10SAE, BIOS 1.1a 01/03/2014
> [  221.683560]  0000000000000009 ffff8802124ffce8 ffffffff814a43cc
> ffff8802124ffd20
> [  221.683582]  ffffffff8103da61 ffff88021580d7a0 0000000000000000
> 0000000000051430
> [  221.683603]  0000000000104080 ffffffff81a6b2b0 ffff8802124ffd30
> ffffffff8103db3a
> [  221.683625] Call Trace:
> [  221.683638]  [<ffffffff814a43cc>] dump_stack+0x19/0x1b
> [  221.683649]  [<ffffffff8103da61>] warn_slowpath_common+0x61/0x80
> [  221.683663]  [<ffffffff8103db3a>] warn_slowpath_null+0x1a/0x20
> [  221.683675]  [<ffffffff810c0079>] rcu_irq_exit+0xc9/0xe0
> [  221.683688]  [<ffffffff81046890>] irq_exit+0x50/0x90
> [  221.683700]  [<ffffffff814b46ea>] smp_apic_timer_interrupt+0x5a/0x88
> [  221.683711]  [<ffffffff814b4690>] ? do_IRQ+0xe0/0xe0
> [  221.683724]  [<ffffffff81021ce9>] __ipipe_do_IRQ+0x79/0x90
> [  221.683737]  [<ffffffff810c8149>] ? ipipe_trace_end+0x19/0x20
> [  221.683749]  [<ffffffff814b4690>] ? do_IRQ+0xe0/0xe0
> [  221.683761]  [<ffffffff81021cef>] ? __ipipe_do_IRQ+0x7f/0x90
> [  221.683775]  [<ffffffff810c4ed8>] __ipipe_do_sync_stage+0x1c8/0x200
> [  221.683789]  [<ffffffff810c4f72>] ipipe_unstall_root+0x62/0x90
> [  221.683801]  [<ffffffff813a4440>] cpuidle_enter_state+0x50/0xc0
> [  221.683814]  [<ffffffff813a4575>] cpuidle_idle_call+0xc5/0x200
> [  221.683829]  [<ffffffff8100ad4e>] arch_cpu_idle+0xe/0x30
> [  221.683841]  [<ffffffff81083f3e>] cpu_startup_entry+0xae/0x260
> [  221.683852]  [<ffffffff8108c058>] ? clockevents_config_and_register+0x28/0x30
> [  221.683866]  [<ffffffff8149b057>] start_secondary+0x24b/0x24d
> [  221.683880] ---[ end trace 0cb6d956934dc704 ]---
> [  221.683888] ------------[ cut here ]------------
> [  221.683895] WARNING: at kernel/rcutree.c:530 rcu_eqs_exit+0x89/0xa0()
> [  221.683900] Modules linked in: xeno_native xeno_nucleus coretemp
> mperf ghash_clmulni_intel i915 aesni_intel aes_x86_64 lrw gf128mul
> glue_helper ablk_helper cryptd e1000e firewire_ohci igb lpc_ich
> firewire_core mfd_core crc_itu_t ehci_pci hwmon ehci_hcd ptp pps_core
> i2c_algo_bit thermal drm_kms_helper fan xhci_hcd drm usbcore video
> backlight usb_common processor
> [  221.684066] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 3.10.18-ipipe #23
> [  221.684072] Hardware name: Supermicro X10SAE/X10SAE, BIOS 1.1a 01/03/2014
> [  221.684078]  0000000000000009 ffff8802124ffe60 ffffffff814a43cc
> ffff8802124ffe98
> [  221.684100]  ffffffff8103da61 ffff88021580d7a0 ff00000000000000
> 0000000000000000
> [  221.684122]  ffff8802124fffd8 0000000000000000 ffff8802124ffea8
> ffffffff8103db3a
> [  221.684144] Call Trace:
> [  221.684156]  [<ffffffff814a43cc>] dump_stack+0x19/0x1b
> [  221.684168]  [<ffffffff8103da61>] warn_slowpath_common+0x61/0x80
> [  221.684181]  [<ffffffff8103db3a>] warn_slowpath_null+0x1a/0x20
> [  221.684193]  [<ffffffff810be3b9>] rcu_eqs_exit+0x89/0xa0
> [  221.684205]  [<ffffffff810bef1d>] rcu_idle_exit+0x4d/0x70
> [  221.684218]  [<ffffffff81083f70>] cpu_startup_entry+0xe0/0x260
> [  221.684229]  [<ffffffff8108c058>] ? clockevents_config_and_register+0x28/0x30
> [  221.684243]  [<ffffffff8149b057>] start_secondary+0x24b/0x24d
> [  221.684257] ---[ end trace 0cb6d956934dc705 ]---
> [  221.684263] ------------[ cut here ]------------
> [  221.684270] WARNING: at kernel/rcutree.c:504
> rcu_eqs_exit_common.isra.32+0xcc/0xe0()
> [  221.684276] Modules linked in: xeno_native xeno_nucleus coretemp
> mperf ghash_clmulni_intel i915 aesni_intel aes_x86_64 lrw gf128mul
> glue_helper ablk_helper cryptd e1000e firewire_ohci igb lpc_ich
> firewire_core mfd_core crc_itu_t ehci_pci hwmon ehci_hcd ptp pps_core
> i2c_algo_bit thermal drm_kms_helper fan xhci_hcd drm usbcore video
> backlight usb_common processor
> [  221.684441] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 3.10.18-ipipe #23
> [  221.684447] Hardware name: Supermicro X10SAE/X10SAE, BIOS 1.1a 01/03/2014
> [  221.684453]  0000000000000009 ffff8802124ffe38 ffffffff814a43cc
> ffff8802124ffe70
> [  221.684475]  ffffffff8103da61 0000000000000000 ff00000000000000
> 0000000000000000
> [  221.684496]  ffff8802124fffd8 0000000000000000 ffff8802124ffe80
> ffffffff8103db3a
> [  221.684518] Call Trace:
> [  221.684530]  [<ffffffff814a43cc>] dump_stack+0x19/0x1b
> [  221.684542]  [<ffffffff8103da61>] warn_slowpath_common+0x61/0x80
> [  221.684556]  [<ffffffff8103db3a>] warn_slowpath_null+0x1a/0x20
> [  221.684567]  [<ffffffff810be31c>] rcu_eqs_exit_common.isra.32+0xcc/0xe0
> [  221.684580]  [<ffffffff810be381>] rcu_eqs_exit+0x51/0xa0
> [  221.684592]  [<ffffffff810bef1d>] rcu_idle_exit+0x4d/0x70
> [  221.684604]  [<ffffffff81083f70>] cpu_startup_entry+0xe0/0x260
> [  221.684616]  [<ffffffff8108c058>] ? clockevents_config_and_register+0x28/0x30
> [  221.684629]  [<ffffffff8149b057>] start_secondary+0x24b/0x24d
> [  221.684643] ---[ end trace 0cb6d956934dc706 ]---
>
>
> I've attached an I-pipe trace freeze as well for the warning issued at
> rcu_eqs_enter.
>
> The warning is triggered when a real-time process is started (e.g.
> latency). Before that, there is no warning.
>
>
> Jeroen

