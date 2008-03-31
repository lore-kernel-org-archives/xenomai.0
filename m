Message-ID: <47F062DE.5000709@domain.hid>
Date: Mon, 31 Mar 2008 00:04:46 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	<18413.32341.751841.753799@domain.hid>	<18413.34914.638951.575098@domain.hid>	<47ED9D05.7060707@domain.hid>
	<18415.63399.305120.344817@domain.hid>
In-Reply-To: <18415.63399.305120.344817@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>


Crashed on the very same line as before
Tomas

[  189.558776] ------------[ cut here ]------------
[  189.563377] kernel BUG at arch/x86/mm/highmem_32.c:43!
[  189.568491] invalid opcode: 0000 [#1] PREEMPT SMP 
[  189.573285] Modules linked in: rfcomm l2cap bluetooth ppdev sbp2 parport_pc lp parport sr_mod cdrom pcspkr iTCO_wdt iTCO_v
endor_support shpchp pci_hotplug ipv6 evdev ext3 jbd mbcache sg sd_mod ata_piix usbhid hid floppy ata_generic ahci ohci1394 l
ibata scsi_mod ieee1394 ehci_hcd tg3 uhci_hcd usbcore fuse
[  189.600440] 
[  189.601924] Pid: 4960, comm: ovmtask Not tainted (2.6.24.3xenomaip1 #1)
[  189.608508] EIP: 0060:[<c011a908>] EFLAGS: 00010286 CPU: 0
[  189.613971] EIP is at kmap_atomic_prot+0xb8/0xc0
[  189.618566] EAX: d91a8163 EBX: c2b23500 ECX: fffff000 EDX: c044fecc
[  189.624804] ESI: 00000007 EDI: 00000163 EBP: 08003875 ESP: df673ea0
[  189.631043]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  189.636416] Process ovmtask (pid: 4960, ti=df672000 task=df4d29e0 task.ti=df672000)<0>
[  189.643865] I-pipe domain Linux
[  189.647257] Stack: fffb2000 00000000 c2b2350c c01a96aa fffb7000 fffb6000 df66d278 dfb7a580 
[  189.655648]        dfb7ae40 df846084 df9b7084 08615000 08400000 08615000 f7c3d740 c2b23520 
[  189.664039]        00000000 00000000 c2b2350c c2be8aac fffb3000 08614fff 00000000 00000000 
[  189.672430] Call Trace:
[  189.675045]  [<c01a96aa>] copy_page_range+0x13a/0x560
[  189.680086]  [<c01224ef>] copy_process+0x8df/0x1250
[  189.684951]  [<c012309c>] do_fork+0x4c/0x200
[  189.689211]  [<c01022d2>] sys_clone+0x32/0x40
[  189.693556]  [<c01043a1>] sysenter_past_esp+0x6e/0x72
[  189.698595]  =======================
[  189.702150] Code: 0c c1 fb 05 29 c1 c1 e3 0c 89 c8 09 fb 89 1a 5b 5e 5f c3 89 e0 25 00 e0 ff ff f7 40 14 ff ff ff ef 0f 85
 69 ff ff ff 0f 0b eb fe <0f> 0b eb fe 8d 74 26 00 8b 0d f4 b1 45 c0 e9 35 ff ff ff 90 8d 
[  189.721467] EIP: [<c011a908>] kmap_atomic_prot+0xb8/0xc0 SS:ESP 0068:df673ea0
[  189.728669] ---[ end trace 7363976c5f0598cc ]---
[  189.733269] note: ovmtask[4960] exited with preempt_count 1



Gilles Chanteperdrix wrote:
> Tomas Kalibera wrote:
>  > Hi Gilles,
>  > 
>  > thanks for looking at it. Your analysis is correct, I don't indeed have 
>  > CONFIG_PREEMPT_RT kernel, but only CONFIG_PREEMPT, sorry for the confusion.
>  > 
>  > I've put the kernel config, sources, and binary on the web, so that you 
>  > can be sure you're really looking on the kernel that is crashing, 
>  > http://www.cs.purdue.edu/homes/tkaliber/crash
>
> After looking at the sources, it appears that kmap_atomic disables
> preemption and kunmap_atomic reenables it. In short, the bug should
> never happen. What could happen is that the preemption count is garbled,
> or that a call to kmap_atomic is not paired with a kunmap_atomic.
>
> To check if the problem comes from the preemption count, could you apply
> the following patch ?
>
>   


