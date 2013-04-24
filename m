Message-ID: <51778E9A.7090206@siemens.com>
Date: Wed, 24 Apr 2013 09:49:46 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51757858.6040604@bollue.de> <51767C09.3070502@siemens.com>
	<51769250.7050504@bollue.de> <5176950F.3040702@siemens.com>
	<5176AB28.7000305@bollue.de> <5176AC37.1040405@siemens.com>
	<5176C108.5050102@bollue.de> <5176C24B.3000300@siemens.com>
	<5176E0D2.2080101@bollue.de>
In-Reply-To: <5176E0D2.2080101@bollue.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic freeze using RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kai Bollue <mlist1@bollue.de>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-04-23 21:28, Kai Bollue wrote:
> On 23.04.2013 19:18, Jan Kiszka wrote:
>>
>> Yeah, its hairy:
>>
>> [   94.352526]  |  #*func    	        0 ipipe_trace_panic_freeze+0x9 (ipipe_root_only+0x62)
>> [   94.360774]  |  #*func    	        0 ipipe_prepare_panic+0x7 (ipipe_root_only+0x5d)
>> [   94.368618]  |  #*func    	        0 ipipe_root_only+0x9 (add_preempt_count+0x15)
>> [   94.376263]  |  #*func    	        0 add_preempt_count+0x9 (_raw_spin_lock_irqsave+0x56)
>> [   94.384515]  |  # func    	        0 _raw_spin_lock_irqsave+0x7 (swiotlb_tbl_map_single+0x96)
>> [   94.392925]  |  # func    	       -1 __phys_addr+0x4 ( |  # func    	       -1 __phys_addr+0x4 (pci_map_single+0x53 [rt_eepro100])
>> [   94.392945]  |  # func    	       -1 ___xnpod_lock_sched+0x4 (__xnpod_lock_sched+0x21 [rt_eepro100])
>> [   94.392954]  |  + begin   0x80000000     -2 speedo_start_xmit+0x3a [rt_eepro100] (rtdev_locked_xmit+0x33 [rtnet])
>> [   94.392964]     + func    	       -2 speedo_start_xmit+0x11 [rt_eepro100] (rtdev_locked_xmit+0x33 [rtnet])
>>
>> Now the swiotlb is active, a software IOMMU that helps on systems >4G
>> RAM with devices that can only DMA to 32-bit addresses (it provides
>> bounce buffers). You can work around that issue by limiting the memory
>> used by your system (mem=) or by using an RTnet NIC that does not have
>> this limitation (rt_e1000e and rt_igb compatible ones).
> 
> Yep, that's it, thank you very much.
> 
> Does the rt_8139too driver support pre-mapping?

Nope, only the two I mentioned (simply because they are more common on
platforms that have >4G and/or an IOMMU). But - wait - the 8139too has a
fixed DMA window (due to some older chips) and therefore does copying
to/from a pre-allocated bounce buffer on its own. That makes it work
with IOMMUs as well.

Jan

> Last year, we built a 
> system with two RTL 8139 and 8 GB of RAM - and did not experience any 
> such problems since...
> 
>>   Or add pre-mapping support to the rt_e100pro. Check e.g. the conversion of the
>> e1000e for the pattern. Patches welcome.
> 
> I will see what I can do. For now, the system runs on an e1000e.
> 
> 
> Regards,
> Kai
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

