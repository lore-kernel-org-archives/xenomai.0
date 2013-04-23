Message-ID: <5176AC37.1040405@siemens.com>
Date: Tue, 23 Apr 2013 17:43:51 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51757858.6040604@bollue.de> <51767C09.3070502@siemens.com>
	<51769250.7050504@bollue.de> <5176950F.3040702@siemens.com>
	<5176AB28.7000305@bollue.de>
In-Reply-To: <5176AB28.7000305@bollue.de>
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

[re-adding the list to cc]

On 2013-04-23 17:39, Kai Bollue wrote:
> On 23.04.2013 16:05, Jan Kiszka wrote:
>> Hmm, broken in several ways. First of all, backtraces aren't working 
>> properly in your setup. Please enable CONFIG_FRAME_POINTER.
> 
> CONFIG_FRAME_POINTER was already automatically enabled by IPIPE_TRACE 
> and IPIPE_DEBUG.
> 
>> You can leave the ipipe tracer knob above at its default for the next 
>> run, and no need for the sysrq-l to repeat.
> 
> Next version attached (not so much different from the last one, though).
> 
> We observed a few more things:
> 
> - This message (and the following call trace) always appears as soon as 
> rtping is started (not when the freeze happens):
> [   98.995234] I-pipe: Detected illicit call from head domain 'Xenomai'
> [   98.995234] <3>        into a regular Linux service
> [   99.129249]  |  #*func                0 ipipe_trace_panic_freeze+0x9 
> (ipipe_root_only+0x62[   99.129245] Pid: 0, comm: swapper/4 Tainted: 
> G           O 3.5.7-xenomai-2.6.2.1 #7
> 
> - It is easy to trigger the freeze by putting load on the system. (A 
> make -j 10 to a kernel while rtping is running causes a freeze within 
> seconds.)
> 
> - We saw the "detected stalls" error again (without load, thus after a 
> longer time). Output also attached.
> 
> - One time, the output ended with
> [  863.616378] BUG: Unhandled exception over domain Xenomai at 
> 0x2ba48485cd8c - switching to ROOT
> 
> - Another time it ended with
> [  140.340959] invalid use of FPU in Xenomai context at 
> __switch_to+0x62/0x23e
> [
> (sic, i.e. the output stops in the middle of a line.)
> 
> - We checked again that none of the output is created when only 
> xeno-test is invoked.

Here is the first (and hopefully the only) problem:

[  100.359484] I-pipe: Detected illicit call from head domain 'Xenomai'
[  100.359484] <3>        into a regular Linux service
[  100.493487]  |  #*func    	   [  100.493482] Pid: 0, comm: swapper/6 Tainted: G           O 3.5.7-xenomai-2.6.2.1 #7
[  100.493483] Call Trace:
[  100.493485] I-pipe tracer log (100 points):
[  100.493510]  |  #*func    	        0 ipipe_prepare_panic+0x7 (ipipe_root_only+0x5d)
[  100.493536]  |  #*func    	        0 ipipe_root_only+0x9 (add_preempt_count+0x15)
[  100.493563]  |  #*func    	       -1 add_preempt_count+0x9 (_raw_spin_lock_irqsave+0x56)
[  100.493588]  |  # func    	       -1 _raw_spin_lock_irqsave+0x7 (alloc_iommu+0x68)
[  100.493612]  |  # func    	       -1 alloc_iommu+0x11 (dma_map_area+0x58)
[  100.493640]  |  # func    	       -1 dma_map_area+0x11 (gart_map_page+0x67)
[  100.493666]  |  # func    	       -1 gart_map_page+0x8 (pci_map_single+0x82 [rt_eepro100])
[  100.493693]  |  # func    	       -1 __phys_addr+0x4 (pci_map_single+0x53 [rt_eepro100])
[  100.493721]  |  # func    	       -1 ___xnpod_lock_sched+0x4 (__xnpod_lock_sched+0x21 [rt_eepro100])
[  100.493747]  |  + begin   0x80000000     -2 speedo_start_xmit+0x3a [rt_eepro100] (rtdev_locked_xmit+0x33 [rtnet])
[  100.493778]     + func    	       -2 speedo_start_xmit+0x11 [rt_eepro100] (rtdev_locked_xmit+0x33 [rtnet])

You have an IOMMU enabled, but the rt_eepro100 is lacking support for
premapping its DMA buffers so that it does not call into Linux IOMMU
remapping code during runtime. The latter raises the error above.

Unless you depend on the IOMMU (unlikely unless KVM is on your feature
list), disable it and retry.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

