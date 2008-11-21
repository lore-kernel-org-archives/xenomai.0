Message-ID: <af29ce600811210417u3fcb07b9kbdc2fde3e1451f74@domain.hid>
Date: Fri, 21 Nov 2008 13:17:17 +0100
From: "Stefano Gafforelli" <stefano.gafforelli@domain.hid>
In-Reply-To: <49217095.7080902@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5924_31889211.1227269837381"
References: <af29ce600811170122q83ee743ic771a6f07a70e9b9@domain.hid>
	<492143DF.8040508@domain.hid>
	<af29ce600811170328v79cfa0f0k46d1491c46046f5e@domain.hid>
	<49217095.7080902@domain.hid>
Subject: Re: [Xenomai-help] NETDEV WATCHDOG on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_5924_31889211.1227269837381
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried with kernel 2.6.26 with xenomai 2.4.6.1 but the problem is still
present (same result with kernel 2.6.26.8);
when tried to make a ping I saw the following messages

# ping 192.168.0.230
PING 192.168.0.230 (192.168.0.230): 56 data bytes
NETDEV WATCHDOG: eth0: transmit timed out
------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:222 dev_watchdog+0xac/0x138()
Modules linked in:
[<c002eb38>] (dump_stack+0x0/0x14) from [<c0042d18>]
(warn_on_slowpath+0x4c/0x84)
[<c0042ccc>] (warn_on_slowpath+0x0/0x84) from [<c0254084>]
(dev_watchdog+0xac/0x138)
 r6:c0253fd8 r5:c3c8a800 r4:c03a8c78
[<c0253fd8>] (dev_watchdog+0x0/0x138) from [<c004c100>]
(run_timer_softirq+0x15c/0x200)
 r5:c038a460 r4:00000100
[<c004bfa4>] (run_timer_softirq+0x0/0x200) from [<c0047ee0>]
(__do_softirq+0x54/0xe0)
 r7:00000000 r6:0000000a r5:c038a24c r4:00000001
[<c0047e8c>] (__do_softirq+0x0/0xe0) from [<c00483dc>] (irq_exit+0x44/0x4c)
 r6:00000000 r5:c0368678 r4:00000011
[<c0048398>] (irq_exit+0x0/0x4c) from [<c002a044>] (asm_do_IRQ+0x44/0x5c)
[<c002a000>] (asm_do_IRQ+0x0/0x5c) from [<c0069ad8>]
(__ipipe_sync_stage+0x188/0x2a8)
Exception stack(0xc0361ed0 to 0xc0361f18)
1ec0:                                     fffffffe c038ca20 00000011
c038ca20
1ee0: c036b310 c038e744 41069265 2002326c c0361f1c c0361f00 c0069d60
c0069960
1f00: c038e740 00000011 00000011 00000000 c0361f40 c0361f20
 r6:c038ca20 r5:00000011 r4:c038cc40
[<c0069950>] (__ipipe_sync_stage+0x0/0x2a8) from [<c0069d60>]
(__ipipe_walk_pipeline+0x98/0xcc)
[<c0069cc8>] (__ipipe_walk_pipeline+0x0/0xcc) from [<c002f50c>]
(__ipipe_handle_irq+0x114/0x150)
 r7:00000000 r6:00000011 r5:00000011 r4:c038e740
[<c002f3f8>] (__ipipe_handle_irq+0x0/0x150) from [<c002f5d4>]
(__ipipe_grab_irq+0x8c/0xa8)
 r8:200232a0 r7:c0363d10 r6:00000011 r5:fefff000 r4:ffffffff
[<c002f548>] (__ipipe_grab_irq+0x0/0xa8) from [<c002a80c>]
(__irq_svc+0x2c/0x5c)
[<c002bda8>] (default_idle+0x0/0x6c) from [<c002bc88>] (cpu_idle+0x38/0x54)
[<c002bc50>] (cpu_idle+0x0/0x54) from [<c02a73f4>] (rest_init+0x54/0x68)
 r5:c0380908 r4:c039e698
[<c02a73a0>] (rest_init+0x0/0x68) from [<c0008d80>]
(start_kernel+0x294/0x308)
[<c0008aec>] (start_kernel+0x0/0x308) from [<20008034>] (0x20008034)
---[ end trace 680a8aa3c5f48898 ]---

--- 192.168.0.230 ping statistics ---
8 packets transmitted, 0 packets received, 100% packet loss

What is the problem?

Thanks,
Stefano.
P.S. after have applied xenomai to kernel I had a problem in compilation,
because is missing a "#include <linux/ipipe_trace.h>" in kernel/panic.c
(after it has been patched with adeos-ipipe).

2008/11/17 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Stefano Gafforelli wrote:
> > I tried only with kernel 2.6.25.4 and xenomai 2.4.4.
>
> In order to avoid wasting people's time, please try xenomai 2.4.6.1.
>
> --
>                                                  Gilles.
>

------=_Part_5924_31889211.1227269837381
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried with kernel 2.6.26 with xenomai <a href="http://2.4.6.1">2.4.6.1</a> but the problem is still present (same result with kernel <a href="http://2.6.26.8">2.6.26.8</a>);<br>when tried to make a ping I saw the following messages<br>
<br># ping <a href="http://192.168.0.230">192.168.0.230</a><br>PING <a href="http://192.168.0.230">192.168.0.230</a> (<a href="http://192.168.0.230">192.168.0.230</a>): 56 data bytes<br>NETDEV WATCHDOG: eth0: transmit timed out<br>
------------[ cut here ]------------<br>WARNING: at net/sched/sch_generic.c:222 dev_watchdog+0xac/0x138()<br>Modules linked in:<br>[&lt;c002eb38&gt;] (dump_stack+0x0/0x14) from [&lt;c0042d18&gt;] (warn_on_slowpath+0x4c/0x84)<br>
[&lt;c0042ccc&gt;] (warn_on_slowpath+0x0/0x84) from [&lt;c0254084&gt;] (dev_watchdog+0xac/0x138)<br>&nbsp;r6:c0253fd8 r5:c3c8a800 r4:c03a8c78<br>[&lt;c0253fd8&gt;] (dev_watchdog+0x0/0x138) from [&lt;c004c100&gt;] (run_timer_softirq+0x15c/0x200)<br>
&nbsp;r5:c038a460 r4:00000100<br>[&lt;c004bfa4&gt;] (run_timer_softirq+0x0/0x200) from [&lt;c0047ee0&gt;] (__do_softirq+0x54/0xe0)<br>&nbsp;r7:00000000 r6:0000000a r5:c038a24c r4:00000001<br>[&lt;c0047e8c&gt;] (__do_softirq+0x0/0xe0) from [&lt;c00483dc&gt;] (irq_exit+0x44/0x4c)<br>
&nbsp;r6:00000000 r5:c0368678 r4:00000011<br>[&lt;c0048398&gt;] (irq_exit+0x0/0x4c) from [&lt;c002a044&gt;] (asm_do_IRQ+0x44/0x5c)<br>[&lt;c002a000&gt;] (asm_do_IRQ+0x0/0x5c) from [&lt;c0069ad8&gt;] (__ipipe_sync_stage+0x188/0x2a8)<br>
Exception stack(0xc0361ed0 to 0xc0361f18)<br>1ec0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fffffffe c038ca20 00000011 c038ca20<br>1ee0: c036b310 c038e744 41069265 2002326c c0361f1c c0361f00 c0069d60 c0069960<br>1f00: c038e740 00000011 00000011 00000000 c0361f40 c0361f20<br>
&nbsp;r6:c038ca20 r5:00000011 r4:c038cc40<br>[&lt;c0069950&gt;] (__ipipe_sync_stage+0x0/0x2a8) from [&lt;c0069d60&gt;] (__ipipe_walk_pipeline+0x98/0xcc)<br>[&lt;c0069cc8&gt;] (__ipipe_walk_pipeline+0x0/0xcc) from [&lt;c002f50c&gt;] (__ipipe_handle_irq+0x114/0x150)<br>
&nbsp;r7:00000000 r6:00000011 r5:00000011 r4:c038e740<br>[&lt;c002f3f8&gt;] (__ipipe_handle_irq+0x0/0x150) from [&lt;c002f5d4&gt;] (__ipipe_grab_irq+0x8c/0xa8)<br>&nbsp;r8:200232a0 r7:c0363d10 r6:00000011 r5:fefff000 r4:ffffffff<br>
[&lt;c002f548&gt;] (__ipipe_grab_irq+0x0/0xa8) from [&lt;c002a80c&gt;] (__irq_svc+0x2c/0x5c)<br>[&lt;c002bda8&gt;] (default_idle+0x0/0x6c) from [&lt;c002bc88&gt;] (cpu_idle+0x38/0x54)<br>[&lt;c002bc50&gt;] (cpu_idle+0x0/0x54) from [&lt;c02a73f4&gt;] (rest_init+0x54/0x68)<br>
&nbsp;r5:c0380908 r4:c039e698<br>[&lt;c02a73a0&gt;] (rest_init+0x0/0x68) from [&lt;c0008d80&gt;] (start_kernel+0x294/0x308)<br>[&lt;c0008aec&gt;] (start_kernel+0x0/0x308) from [&lt;20008034&gt;] (0x20008034)<br>---[ end trace 680a8aa3c5f48898 ]---<br>
<br>--- <a href="http://192.168.0.230">192.168.0.230</a> ping statistics ---<br>8 packets transmitted, 0 packets received, 100% packet loss<br>&nbsp;  <br>What is the problem?<br><br>Thanks,<br>Stefano.<br>P.S. after have applied xenomai to kernel I had a problem in compilation, because is missing a &quot;#include &lt;linux/ipipe_trace.h&gt;&quot; in kernel/panic.c (after it has been patched with adeos-ipipe).<br>
 <div class="gmail_quote"><br>2008/11/17 Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Stefano Gafforelli wrote:<br>
&gt; I tried only with kernel <a href="http://2.6.25.4" target="_blank">2.6.25.4</a> and xenomai <a href="http://2.4.4." target="_blank">2.4.4.</a><br>
<br>
</div>In order to avoid wasting people&#39;s time, please try xenomai <a href="http://2.4.6.1" target="_blank">2.4.6.1</a>.<br>
<br>
--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
</font></blockquote></div><br>

------=_Part_5924_31889211.1227269837381--

