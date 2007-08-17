Message-ID: <2862c2c80708170409p7946b48fw4a18553d5e51da43@domain.hid>
Date: Fri, 17 Aug 2007 19:09:13 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_72674_22525103.1187348953329"
Subject: [Xenomai-help] I-pipe: Detected illicit call from domain 'Xenomai'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_72674_22525103.1187348953329
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

I have encounter the following problem when migrating a Linux driver to RTDM
driver:

I-pipe: Detected illicit call from domain 'Xenomai'
        into a service reserved for domain 'Linux' and below.
[<c002a474>] (show_stack+0x0/0x58) from [<c00736a4>]
(ipipe_check_context+0x98/0xe4)
[<c007360c>] (ipipe_check_context+0x0/0xe4) from [<c00d4ca4>]
(cache_alloc_refill+0x7c/0x78c)
 r8 = 00000020  r7 = C04A3360  r6 = 00000000  r5 = 0000001B
 r4 = 00000000
[<c00d4c28>] (cache_alloc_refill+0x0/0x78c) from [<c00d54dc>]
(__kmalloc+0x128/0x138)
[<c00d53b4>] (__kmalloc+0x0/0x138) from [<c027ede8>] (__alloc_skb+0x58/0xf8)
 r8 = 00000000  r7 = C04A8B00  r6 = 00000060  r5 = 00000020
 r4 = C065C940
[<c027ed90>] (__alloc_skb+0x0/0xf8) from [<c0222b94>]
(at91ether_interrupt+0x250/0x350)
 r8 = FFC00000  r7 = C0768A60  r6 = C0768B20  r5 = 00000046
 r4 = C03E4C60

<snip>

 | #  end     0x80000000    -44 __ipipe_unstall_root+0x4c
(__ipipe_restore_root+0x70)
 | # *func                  -50 __ipipe_unstall_root+0x10
(__ipipe_restore_root+0x70)
 | # *func                  -56 __ipipe_restore_root+0x10
(kmem_cache_alloc+0x84)
 | # *func                  -63 debug_smp_processor_id+0x10
(kmem_cache_alloc+0x50)
 | # *end     0x80000001    -70 kmem_cache_alloc+0xd8 (__alloc_skb+0x3c)
 | #  begin   0x80000001    -76 kmem_cache_alloc+0xc4 (__alloc_skb+0x3c)
 | #  func                  -83 kmem_cache_alloc+0x14 (__alloc_skb+0x3c)
 | #  func                  -91 __alloc_skb+0x14 (at91ether_interrupt+0x250)
 | #  func                 -100 at91ether_interrupt+0x14
(xnintr_irq_handler+0x48)
 | #  func                 -107 xnintr_irq_handler+0x14
(__ipipe_dispatch_wired+0xf8)
 |   +func                 -113 __ipipe_dispatch_wired+0x14
(__ipipe_handle_irq+0x1b0)
 |   +func                 -119 at91_aic_mask_irq+0x10
(__ipipe_ack_level_irq+0x4c)
 |   +func                 -125 at91_aic_mask_irq+0x10
(__ipipe_ack_level_irq+0x3c)
 |   +func                 -130 __ipipe_ack_level_irq+0x10
(__ipipe_ack_irq+0x24)
 |   +func                 -137 __ipipe_ack_irq+0x10
(__ipipe_handle_irq+0x1a4)
 |   +func                 -143 __ipipe_handle_irq+0x14
(__ipipe_grab_irq+0xa0)
 |   +begin   0xffffffff   -150 __ipipe_grab_irq+0x34 (__irq_svc+0x30)
 |   +func                 -156 __ipipe_grab_irq+0x14 (__irq_svc+0x30)
 |   +end     0x80000000   -164 __ipipe_unstall_root+0x4c
(__do_softirq+0x4c)
 |   #begin   0x80000000   -171 __ipipe_unstall_root+0x70
(__do_softirq+0x4c)
     #func                 -177 __ipipe_unstall_root+0x10
(__do_softirq+0x4c)
     #func                 -183 debug_smp_processor_id+0x10
(__do_softirq+0x38)
     #func                 -190 debug_smp_processor_id+0x10
(__do_softirq+0x30)
     #func                 -196 add_preempt_count+0x10 (__do_softirq+0x2c)

Is this the problem coming from the alloc_skb function call? {

Please advice. Thanks

Regards,
Chun Yeow

------=_Part_72674_22525103.1187348953329
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>I have encounter the following problem when migrating a Linux driver to RTDM driver:<br><br>I-pipe: Detected illicit call from domain &#39;Xenomai&#39;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into a service reserved for domain &#39;Linux&#39; and below.
<br>[&lt;c002a474&gt;] (show_stack+0x0/0x58) from [&lt;c00736a4&gt;] (ipipe_check_context+0x98/0xe4)<br>[&lt;c007360c&gt;] (ipipe_check_context+0x0/0xe4) from [&lt;c00d4ca4&gt;] (cache_alloc_refill+0x7c/0x78c)<br>&nbsp;r8 = 00000020&nbsp; r7 = C04A3360&nbsp; r6 = 00000000&nbsp; r5 = 0000001B
<br>&nbsp;r4 = 00000000<br>[&lt;c00d4c28&gt;] (cache_alloc_refill+0x0/0x78c) from [&lt;c00d54dc&gt;] (__kmalloc+0x128/0x138)<br>[&lt;c00d53b4&gt;] (__kmalloc+0x0/0x138) from [&lt;c027ede8&gt;] (__alloc_skb+0x58/0xf8)<br>&nbsp;r8 = 00000000&nbsp; r7 = C04A8B00&nbsp; r6 = 00000060&nbsp; r5 = 00000020
<br>&nbsp;r4 = C065C940<br>[&lt;c027ed90&gt;] (__alloc_skb+0x0/0xf8) from [&lt;c0222b94&gt;] (at91ether_interrupt+0x250/0x350)<br>&nbsp;r8 = FFC00000&nbsp; r7 = C0768A60&nbsp; r6 = C0768B20&nbsp; r5 = 00000046<br>&nbsp;r4 = C03E4C60<br><br>&lt;snip&gt;
<br><br>&nbsp;| #&nbsp; end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp; -44 __ipipe_unstall_root+0x4c (__ipipe_restore_root+0x70)<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -50 __ipipe_unstall_root+0x10 (__ipipe_restore_root+0x70)<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -56 __ipipe_restore_root+0x10 (kmem_cache_alloc+0x84)
<br>&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -63 debug_smp_processor_id+0x10 (kmem_cache_alloc+0x50)<br>&nbsp;| # *end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -70 kmem_cache_alloc+0xd8 (__alloc_skb+0x3c)<br>&nbsp;| #&nbsp; begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -76 kmem_cache_alloc+0xc4 (__alloc_skb+0x3c)
<br>&nbsp;| #&nbsp; func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -83 kmem_cache_alloc+0x14 (__alloc_skb+0x3c)<br>&nbsp;| #&nbsp; func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -91 __alloc_skb+0x14 (at91ether_interrupt+0x250)<br>&nbsp;| #&nbsp; func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -100 at91ether_interrupt+0x14 (xnintr_irq_handler+0x48)
<br>&nbsp;| #&nbsp; func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -107 xnintr_irq_handler+0x14 (__ipipe_dispatch_wired+0xf8)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -113 __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0x1b0)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -119 at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x4c)
<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -125 at91_aic_mask_irq+0x10 (__ipipe_ack_level_irq+0x3c)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -130 __ipipe_ack_level_irq+0x10 (__ipipe_ack_irq+0x24)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -137 __ipipe_ack_irq+0x10 (__ipipe_handle_irq+0x1a4)
<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -143 __ipipe_handle_irq+0x14 (__ipipe_grab_irq+0xa0)<br>&nbsp;|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0xffffffff&nbsp;&nbsp; -150 __ipipe_grab_irq+0x34 (__irq_svc+0x30)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -156 __ipipe_grab_irq+0x14 (__irq_svc+0x30)
<br>&nbsp;|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -164 __ipipe_unstall_root+0x4c (__do_softirq+0x4c)<br>&nbsp;|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -171 __ipipe_unstall_root+0x70 (__do_softirq+0x4c)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -177 __ipipe_unstall_root+0x10 (__do_softirq+0x4c)
<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -183 debug_smp_processor_id+0x10 (__do_softirq+0x38)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -190 debug_smp_processor_id+0x10 (__do_softirq+0x30)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -196 add_preempt_count+0x10 (__do_softirq+0x2c)
<br><br>Is this the problem coming from the alloc_skb function call? {<br><br>Please advice. Thanks<br><br>Regards,<br>Chun Yeow<br><br>

------=_Part_72674_22525103.1187348953329--

