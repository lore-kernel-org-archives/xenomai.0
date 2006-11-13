Message-ID: <4546494d0611121951n600c6a53pe3a08097e923435d@domain.hid>
Date: Mon, 13 Nov 2006 11:51:23 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
In-Reply-To: <4554A498.8030202@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_103458_11769056.1163389883422"
References: <4546494d0609300059p2879d7bcwb9bc898f279df140@domain.hid>
	<45203E31.6050707@domain.hid>
	<4546494d0611100554h6dfee69boca6fa79978f1fac2@domain.hid>
	<4554A498.8030202@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] ipip tracer porting for blackfin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

------=_Part_103458_11769056.1163389883422
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please see my comments bellow:

On 11/11/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Li Yi (Adam) wrote:
> > Hi Jan and Philippe,
>
>
> This must be
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2337
>
> saying "root thread is about the be scheduled away". But then I'm
> missing code here that one would normally see on x86:
>
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2442
>
> Likely inlined on bfin, but this *must* make some noise:
>
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2453
>
> Instead we enter the pending timer interrupt. This currently makes no
> sense to me, rather make me think that something is skewed. Maybe only
> the tracer, maybe more...


Do you have a tracer-log for i386 for reference? So I can do some compare.

> :|  # end     0x80000000   -50+   2.278  ___sched_text_start+0x5ca
> (__start+0xfffff000)
> > :|  # func                 -48    0.922  ___ipipe_grab_irq+0x22
> (__common_int_entry+0x72)
> > :|  # begin   0x00000006   -47+   1.820  ___ipipe_grab_irq+0x34
> (__start+0xfffff000)
> > :|  # func                 -45+   1.530  ___ipipe_handle_irq+0x1e
> (___ipipe_grab_irq+0x3c)
> > :|  # func                 -43+   1.168  _rthal_timer_ack+0x8
> (___ipipe_handle_irq+0x178)
> > :|  # func                 -42+   1.102  ___ipipe_dispatch_wired+0x14
> (___ipipe_handle_irq+0x190)
> > :|  # end     0x00000006   -41+   2.010  ___ipipe_grab_irq+0x42
> (__start+0xfffff000)
> > :   # func                 -39+   1.090  _ipipe_unstall_pipeline_head+0x8
> (_xnshadow_harden+0xce)
> > :|  # begin   0x80000001   -38+   2.308  _ipipe_unstall_pipeline_head+0x18
> (__start+0xfffff000)
>
> That's another weirdness, but now very likely of the tracer: both
> tracepoints should contain the same parent entry, but the second one is
> just nonsense. And there are such kind of parents all over the place -
> hmm, actually any explicit trace point shows this problem. Is there no
> way on bfin to get the caller from everywhere in a function? I guess
> there is, likely a register, right?


Yes, by using the frame-pointer register (FP) it is possible to get parent's
return address. The reason is that __builtin_return_address(1) is not
implemented for Blackfin gcc. I have submitted feature request for the
toolchain developer, hoping they could help.
Thanks for pointing out.

-Yi

------=_Part_103458_11769056.1163389883422
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please see my comments bellow:<br><br><div><span class="gmail_quote">On 11/11/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Li Yi (Adam) wrote:<br>&gt; Hi Jan and Philippe,<br><br><br>This must be<br><a href="http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2337">http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2337
</a><br><br>saying &quot;root thread is about the be scheduled away&quot;. But then I'm<br>missing code here that one would normally see on x86:<br><br><a href="http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2442">
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2442</a><br><br>Likely inlined on bfin, but this *must* make some noise:<br><br><a href="http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2453">
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L2453</a><br><br>Instead we enter the pending timer interrupt. This currently makes no<br>sense to me, rather make me think that something is skewed. Maybe only
<br>the tracer, maybe more...</blockquote><div><br>Do you have a tracer-log for i386 for reference? So I can do some compare.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; :|&nbsp;&nbsp;# end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -50+&nbsp;&nbsp; 2.278&nbsp;&nbsp;___sched_text_start+0x5ca (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -48&nbsp;&nbsp;&nbsp;&nbsp;0.922&nbsp;&nbsp;___ipipe_grab_irq+0x22 (__common_int_entry+0x72)<br>&gt; :|&nbsp;&nbsp;# begin&nbsp;&nbsp; 0x00000006&nbsp;&nbsp; -47+&nbsp;&nbsp; 
1.820&nbsp;&nbsp;___ipipe_grab_irq+0x34 (__start+0xfffff000)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -45+&nbsp;&nbsp; 1.530&nbsp;&nbsp;___ipipe_handle_irq+0x1e (___ipipe_grab_irq+0x3c)<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -43+&nbsp;&nbsp; 1.168&nbsp;&nbsp;_rthal_timer_ack+0x8 (___ipipe_handle_irq+0x178)
<br>&gt; :|&nbsp;&nbsp;# func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -42+&nbsp;&nbsp; 1.102&nbsp;&nbsp;___ipipe_dispatch_wired+0x14 (___ipipe_handle_irq+0x190)<br>&gt; :|&nbsp;&nbsp;# end&nbsp;&nbsp;&nbsp;&nbsp; 0x00000006&nbsp;&nbsp; -41+&nbsp;&nbsp; 2.010&nbsp;&nbsp;___ipipe_grab_irq+0x42 (__start+0xfffff000)<br>&gt; :&nbsp;&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -39+&nbsp;&nbsp; 
1.090&nbsp;&nbsp;_ipipe_unstall_pipeline_head+0x8 (_xnshadow_harden+0xce)<br>&gt; :|&nbsp;&nbsp;# begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -38+&nbsp;&nbsp; 2.308&nbsp;&nbsp;_ipipe_unstall_pipeline_head+0x18 (__start+0xfffff000)<br><br>That's another weirdness, but now very likely of the tracer: both
<br>tracepoints should contain the same parent entry, but the second one is<br>just nonsense. And there are such kind of parents all over the place -<br>hmm, actually any explicit trace point shows this problem. Is there no
<br>way on bfin to get the caller from everywhere in a function? I guess<br>there is, likely a register, right?</blockquote><div><br>Yes, by using the frame-pointer register (FP) it is possible to get parent's return address. The reason is that __builtin_return_address(1) is not implemented for Blackfin gcc. I have submitted feature request for the toolchain developer, hoping they could help. 
<br>Thanks for pointing out.<br><br>-Yi<br></div></div>

------=_Part_103458_11769056.1163389883422--

