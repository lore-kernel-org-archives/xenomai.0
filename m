Message-ID: <2862c2c80708230100n72fd7079u6fca56392c8bf284@domain.hid>
Date: Thu, 23 Aug 2007 16:00:43 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <46C59858.7080309@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_43924_14101703.1187856043306"
References: <2862c2c80708170409p7946b48fw4a18553d5e51da43@domain.hid>
	<2ff1a98a0708170507u6906399dxfa47c704a12080cf@domain.hid>
	<46C59858.7080309@domain.hid>
Subject: Re: [Xenomai-help] I-pipe: Detected illicit call from domain
	'Xenomai'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_43924_14101703.1187856043306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

I have ported the at91ether and it now works under RTnet. I would like to
use the networking stack in Linux, instead of RTnet stack. However, I have
problem configure the VNIC with following errors:

[root@domain.hid] ./rtping 172.16.6.174
Real-time PING 172.16.6.174 56(84) bytes of data.
64 bytes from 172.16.6.174: icmp_seq=1 time=1186.7 us
64 bytes from 172.16.6.174: icmp_seq=2 time=1218.7 us
64 bytes from 172.16.6.174: icmp_seq=3 time=1178.7 us
64 bytes from 172.16.6.174: icmp_seq=4 time=1210.1 us
64 bytes from 172.16.6.174: icmp_seq=5 time=1182.4 us

--- 172.16.6.174 rtping statistics ---
5 packets transmitted, 5 received, 0% packet loss
worst case rtt = 1218.7 us
[root@domain.hid] ./rtifconfig
rtlo      Medium: Local Loopback
          IP address: 127.0.0.1
          UP LOOPBACK RUNNING  MTU: 1500

rteth0    Medium: Ethernet  Hardware address: 14:09:07:05:05:02
          IP address: 172.16.6.203  Broadcast address: 172.16.6.255
          UP BROADCAST RUNNING  MTU: 1500

[root@domain.hid] ifconfig vnic0 up 172.16.6.203
SIOCGIFFLAGS: No such device
SIOCSIFADDR: No such device

Please help. Thanks.

Regards,
Chun Yeow
P.S: Sorry for posting the RTnet issue here.



On 8/17/07, Jan Kiszka < jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > On 8/17/07, Yeoh Chun Yeow < yeohchunyeow@domain.hid> wrote:
> >> Dear all,
> >>
> >> I have encounter the following problem when migrating a Linux driver to
> RTDM
> >> driver:
> >>
> >> I-pipe: Detected illicit call from domain 'Xenomai'
> >>         into a service reserved for domain 'Linux' and below.
>
> [Nice example for how to validate new RTDM drivers or Xenomai skins
> against accidental Linux calls! => CONFIG_IPIPE_DEBUG_CONTEXT]
>
> >> [<c002a474>] (show_stack+0x0/0x58) from [<c00736a4>]
> >> (ipipe_check_context+0x98/0xe4)
> >> [<c007360c>] (ipipe_check_context+0x0/0xe4) from [<c00d4ca4>]
> >> (cache_alloc_refill+0x7c/0x78c)
> >>  r8 = 00000020  r7 = C04A3360  r6 = 00000000  r5 = 0000001B
> >>  r4 = 00000000
> >> [<c00d4c28>] (cache_alloc_refill+0x0/0x78c) from [<c00d54dc>]
> >> (__kmalloc+0x128/0x138)
> >> [<c00d53b4>] (__kmalloc+0x0/0x138) from [<c027ede8>]
> (__alloc_skb+0x58/0xf8)
> >>  r8 = 00000000  r7 = C04A8B00  r6 = 00000060  r5 = 00000020
> >>  r4 = C065C940
> >> [<c027ed90>] (__alloc_skb+0x0/0xf8) from [<c0222b94>]
> >> (at91ether_interrupt+0x250/0x350)
> >>  r8 = FFC00000  r7 = C0768A60  r6 = C0768B20  r5 = 00000046
> >>  r4 = C03E4C60
> >>
> >> <snip>
> >>
> >>  | #  end     0x80000000    -44 __ipipe_unstall_root+0x4c
> >> (__ipipe_restore_root+0x70)
> >>  | # *func                  -50 __ipipe_unstall_root+0x10
> >> (__ipipe_restore_root+0x70)
> >>  | # *func                  -56 __ipipe_restore_root+0x10
> >> (kmem_cache_alloc+0x84)
> >>  | # *func                  -63 debug_smp_processor_id+0x10
> >> (kmem_cache_alloc+0x50)
> >>  | # *end     0x80000001    -70 kmem_cache_alloc+0xd8
> (__alloc_skb+0x3c)
> >>  | #  begin   0x80000001    -76 kmem_cache_alloc+0xc4
> (__alloc_skb+0x3c)
> >>  | #  func                  -83 kmem_cache_alloc+0x14
> (__alloc_skb+0x3c)
> >>  | #  func                  -91 __alloc_skb+0x14
> (at91ether_interrupt+0x250)
> >>  | #  func                 -100 at91ether_interrupt+0x14
> >> (xnintr_irq_handler+0x48)
> >>  | #  func                 -107 xnintr_irq_handler+0x14
> >> (__ipipe_dispatch_wired+0xf8)
> >>  |   +func                 -113 __ipipe_dispatch_wired+0x14
> >> (__ipipe_handle_irq+0x1b0)
> >>  |   +func                 -119 at91_aic_mask_irq+0x10
> >> (__ipipe_ack_level_irq+0x4c)
> >>  |   +func                 -125 at91_aic_mask_irq+0x10
> >> (__ipipe_ack_level_irq+0x3c)
> >>  |   +func                 -130 __ipipe_ack_level_irq+0x10
> >> (__ipipe_ack_irq+0x24)
> >>  |   +func                 -137 __ipipe_ack_irq+0x10
> >> (__ipipe_handle_irq+0x1a4)
> >>  |   +func                 -143 __ipipe_handle_irq+0x14
> >> (__ipipe_grab_irq+0xa0)
> >>  |   +begin   0xffffffff   -150 __ipipe_grab_irq+0x34 (__irq_svc+0x30)
> >>  |   +func                 -156 __ipipe_grab_irq+0x14 (__irq_svc+0x30)
> >>  |   +end     0x80000000   -164 __ipipe_unstall_root+0x4c
> >> (__do_softirq+0x4c)
> >>  |   #begin   0x80000000   -171 __ipipe_unstall_root+0x70
> >> (__do_softirq+0x4c)
> >>      #func                 -177 __ipipe_unstall_root+0x10
> >> (__do_softirq+0x4c)
> >>      #func                 -183 debug_smp_processor_id+0x10
> >> (__do_softirq+0x38)
> >>      #func                 -190 debug_smp_processor_id+0x10
> >> (__do_softirq+0x30)
> >>      #func                 -196 add_preempt_count+0x10
> (__do_softirq+0x2c)
> >>
> >> Is this the problem coming from the alloc_skb function call? {
> >
> > Yes, you can not call alloc_skb from Xenomai domain, as you can not
> > call most Linux functions. Note that if you are porting a network
> > driver, you should consider using rtnet.
>
> The point here is specifically that even if Linux itself provides
> deterministic execution of your IRQ handler, it cannot guarantee that
> there is always memory available for alloc_skb. That's why RTnet uses
> preallocated pools for precisely this scenario. But, to avoid potential
> misunderstandings right from the start, it is _not_ intended as a
> performance or latency "booster" for standard networking applications.
>
> Jan
>
>
>

------=_Part_43924_14101703.1187856043306
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>I have ported the at91ether and it now works under RTnet. I would like to use the networking stack in Linux, instead of RTnet stack. However, I have problem configure the VNIC with following errors:<br><br>
[root@domain.hid] ./rtping <a href="http://172.16.6.174">172.16.6.174</a><br>Real-time PING <a href="http://172.16.6.174">172.16.6.174</a> 56(84) bytes of data.<br>64 bytes from <a href="http://172.16.6.174">
172.16.6.174</a>: icmp_seq=1 time=1186.7 us<br>64 bytes from <a href="http://172.16.6.174">172.16.6.174</a>: icmp_seq=2 time=1218.7 us<br>64 bytes from <a href="http://172.16.6.174">172.16.6.174</a>: icmp_seq=3 time=1178.7
 us<br>64 bytes from <a href="http://172.16.6.174">172.16.6.174</a>: icmp_seq=4 time=1210.1 us<br>64 bytes from <a href="http://172.16.6.174">172.16.6.174</a>: icmp_seq=5 time=1182.4 us<br><br>--- <a href="http://172.16.6.174">
172.16.6.174</a> rtping statistics ---<br>5 packets transmitted, 5 received, 0% packet loss<br>worst case rtt = 1218.7 us<br>[root@domain.hid] ./rtifconfig<br>rtlo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Medium: Local Loopback<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP address: 
<a href="http://127.0.0.1">127.0.0.1</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP LOOPBACK RUNNING&nbsp; MTU: 1500<br><br>rteth0&nbsp;&nbsp;&nbsp; Medium: Ethernet&nbsp; Hardware address: 14:09:07:05:05:02<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP address: <a href="http://172.16.6.203">172.16.6.203
</a>&nbsp; Broadcast address: <a href="http://172.16.6.255">172.16.6.255</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP BROADCAST RUNNING&nbsp; MTU: 1500<br><br style="color: rgb(255, 0, 0);"><span style="color: rgb(255, 0, 0);">[root@domain.hid] ifconfig vnic0 up 
<a href="http://172.16.6.203">172.16.6.203</a></span><br style="color: rgb(255, 0, 0);"><span style="color: rgb(255, 0, 0);">SIOCGIFFLAGS: No such device</span><br style="color: rgb(255, 0, 0);"><span style="color: rgb(255, 0, 0);">
SIOCSIFADDR: No such device</span><br><br>Please help. Thanks.<br><br>Regards,<br>Chun Yeow<br>P.S: Sorry for posting the RTnet issue here.<br><br>
<br><br><div><span class="gmail_quote">On 8/17/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;
<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Gilles Chanteperdrix wrote:<br>&gt; On 8/17/07, Yeoh Chun Yeow &lt;
<a href="mailto:yeohchunyeow@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt;&gt; Dear all,<br>&gt;&gt;<br>&gt;&gt; I have encounter the following problem when migrating a Linux driver to RTDM
<br>&gt;&gt; driver:<br>
&gt;&gt;<br>&gt;&gt; I-pipe: Detected illicit call from domain &#39;Xenomai&#39;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into a service reserved for domain &#39;Linux&#39; and below.<br><br>[Nice example for how to validate new RTDM drivers or Xenomai skins
<br>against accidental Linux calls! =&gt; CONFIG_IPIPE_DEBUG_CONTEXT]<br><br>&gt;&gt; [&lt;c002a474&gt;] (show_stack+0x0/0x58) from [&lt;c00736a4&gt;]<br>&gt;&gt; (ipipe_check_context+0x98/0xe4)<br>&gt;&gt; [&lt;c007360c&gt;] (ipipe_check_context+0x0/0xe4) from [&lt;c00d4ca4&gt;]
<br>&gt;&gt; (cache_alloc_refill+0x7c/0x78c)<br>&gt;&gt;&nbsp;&nbsp;r8 = 00000020&nbsp;&nbsp;r7 = C04A3360&nbsp;&nbsp;r6 = 00000000&nbsp;&nbsp;r5 = 0000001B<br>&gt;&gt;&nbsp;&nbsp;r4 = 00000000<br>&gt;&gt; [&lt;c00d4c28&gt;] (cache_alloc_refill+0x0/0x78c) from [&lt;c00d54dc&gt;]
<br>&gt;&gt; (__kmalloc+0x128/0x138)<br>&gt;&gt; [&lt;c00d53b4&gt;] (__kmalloc+0x0/0x138) from [&lt;c027ede8&gt;] (__alloc_skb+0x58/0xf8)<br>&gt;&gt;&nbsp;&nbsp;r8 = 00000000&nbsp;&nbsp;r7 = C04A8B00&nbsp;&nbsp;r6 = 00000060&nbsp;&nbsp;r5 = 00000020<br>&gt;&gt;&nbsp;&nbsp;r4 = C065C940
<br>&gt;&gt; [&lt;c027ed90&gt;] (__alloc_skb+0x0/0xf8) from [&lt;c0222b94&gt;]<br>&gt;&gt; (at91ether_interrupt+0x250/0x350)<br>&gt;&gt;&nbsp;&nbsp;r8 = FFC00000&nbsp;&nbsp;r7 = C0768A60&nbsp;&nbsp;r6 = C0768B20&nbsp;&nbsp;r5 = 00000046<br>&gt;&gt;&nbsp;&nbsp;r4 = C03E4C60
<br>&gt;&gt;<br>&gt;&gt; &lt;snip&gt;<br>&gt;&gt;<br>&gt;&gt;&nbsp;&nbsp;| #&nbsp;&nbsp;end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp;&nbsp;&nbsp;-44 __ipipe_unstall_root+0x4c<br>&gt;&gt; (__ipipe_restore_root+0x70)<br>&gt;&gt;&nbsp;&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-50 __ipipe_unstall_root+0x10
<br>&gt;&gt; (__ipipe_restore_root+0x70)<br>&gt;&gt;&nbsp;&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-56 __ipipe_restore_root+0x10<br>&gt;&gt; (kmem_cache_alloc+0x84)<br>&gt;&gt;&nbsp;&nbsp;| # *func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-63 debug_smp_processor_id+0x10<br>



&gt;&gt; (kmem_cache_alloc+0x50)<br>&gt;&gt;&nbsp;&nbsp;| # *end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp;-70 kmem_cache_alloc+0xd8 (__alloc_skb+0x3c)<br>&gt;&gt;&nbsp;&nbsp;| #&nbsp;&nbsp;begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp;-76 kmem_cache_alloc+0xc4 (__alloc_skb+0x3c)<br>&gt;&gt;&nbsp;&nbsp;| #&nbsp;&nbsp;func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-83 kmem_cache_alloc+0x14 (__alloc_skb+0x3c)
<br>&gt;&gt;&nbsp;&nbsp;| #&nbsp;&nbsp;func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-91 __alloc_skb+0x14 (at91ether_interrupt+0x250)<br>&gt;&gt;&nbsp;&nbsp;| #&nbsp;&nbsp;func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -100 at91ether_interrupt+0x14<br>&gt;&gt; (xnintr_irq_handler+0x48)<br>&gt;&gt;&nbsp;&nbsp;| #&nbsp;&nbsp;func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -107 xnintr_irq_handler+0x14
<br>&gt;&gt; (__ipipe_dispatch_wired+0xf8)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -113 __ipipe_dispatch_wired+0x14<br>&gt;&gt; (__ipipe_handle_irq+0x1b0)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -119 at91_aic_mask_irq+0x10
<br>
&gt;&gt; (__ipipe_ack_level_irq+0x4c)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -125 at91_aic_mask_irq+0x10<br>&gt;&gt; (__ipipe_ack_level_irq+0x3c)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -130 __ipipe_ack_level_irq+0x10<br>


&gt;&gt; (__ipipe_ack_irq+0x24)
<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -137 __ipipe_ack_irq+0x10<br>&gt;&gt; (__ipipe_handle_irq+0x1a4)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -143 __ipipe_handle_irq+0x14<br>&gt;&gt; (__ipipe_grab_irq+0xa0)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0xffffffff&nbsp;&nbsp; -150 __ipipe_grab_irq+0x34 (__irq_svc+0x30)
<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -156 __ipipe_grab_irq+0x14 (__irq_svc+0x30)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -164 __ipipe_unstall_root+0x4c<br>&gt;&gt; (__do_softirq+0x4c)<br>&gt;&gt;&nbsp;&nbsp;|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -171 __ipipe_unstall_root+0x70
<br>&gt;&gt; (__do_softirq+0x4c)<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -177 __ipipe_unstall_root+0x10<br>&gt;&gt; (__do_softirq+0x4c)<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -183 debug_smp_processor_id+0x10<br>&gt;&gt; (__do_softirq+0x38)
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -190 debug_smp_processor_id+0x10<br>&gt;&gt; (__do_softirq+0x30)<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -196 add_preempt_count+0x10 (__do_softirq+0x2c)<br>&gt;&gt;<br>&gt;&gt; Is this the problem coming from the alloc_skb function call? {
<br>&gt;<br>&gt; Yes, you can not call alloc_skb from Xenomai domain, as you can not<br>&gt; call most Linux functions. Note that if you are porting a network<br>&gt; driver, you should consider using rtnet.<br><br>The point here is specifically that even if Linux itself provides
<br>deterministic execution of your IRQ handler, it cannot guarantee that<br>there is always memory available for alloc_skb. That&#39;s why RTnet uses<br>preallocated pools for precisely this scenario. But, to avoid potential
<br>misunderstandings right from the start, it is _not_ intended as a<br>performance or latency &quot;booster&quot; for standard networking applications.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_43924_14101703.1187856043306--

