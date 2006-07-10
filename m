Message-ID: <4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
Date: Mon, 10 Jul 2006 17:31:16 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <44B218C5.9000804@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_95001_2350533.1152523876013"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B1FDBD.4060600@domain.hid>
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
	<44B218C5.9000804@domain.hid>
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
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_95001_2350533.1152523876013
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I searched the web and find these RTDM sample drivers (Thanks for the
contributors):

In Xenomai src tree: ksrc/drivers/16550A/16550A.c
http://www.captain.at/xenomai-real-time-driver-example.php
http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/
http://www.captain.at/xenomai-serial-port-example.php

Just wondering are there more samples?

Thanks,

-Yi

On 7/10/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Li Yi (Adam) wrote:
> > Thanks Jan.
> >
> > You mentioned:
> > "Depends on what you have to protect. The easiest way for short code
> > passages are still spinlocks with hard IRQ protection (under RTDM:
> > rtdm_lock_xxx). "
> >
> > I read the code of rtdm_lock_xxx and find it mapped to spin_lock. If I
> > understand correctly,
> >
> > a RTDM driver using:
> > rtdm_lock_get(&my_lock);
> >
> > a normal linux driver using
> > spin_lock(&my_lock);
> >
> > Can be used to protect some shared data structure between RTDM real-time
> > driver in Xenomai Domain
> > and a normal Linux driver, right?
>
> Yep. See also real-world examples in existing RTDM drivers.
>
> >
> > I just started to write a RTDM driver, and I am not sure what existing
> > linux
> > kernel services
> > I can use in the RTDM driver, e.g, wait queue, semaphores,
> request_dma(),
> > free_dma(), etc.
> > I have concern that the RTDM driver may not synchronize with linux
> kernel,
> > since it will
> > preempt Linux kernel whenever the HW interrupt is not masked.
> > Is there any guideline there?
>
> Keep in mind that Linux may have been preempted AT ANY POINT when your
> driver executes some code in hard real-time mode. Therefore, calling
> almost all Linux services from RT context must be considered unsafe
> (unfortunately, it often works fine in practice, just fails/crashes
> "magically" from time to time).
>
> But it's usually not required to do so as most of Linux interaction can
> be performed during init/cleanup. Just register your open/socket and
> close handler as "_nrt" so that they are only executed in pure Linux or
> secondary mode, and you can run whatever Linux service you like.
>
> If you encounter any Linux service that you have to call for your driver
> from IRQ or RT context, please report.
>
> Jan
>
>
>
>

------=_Part_95001_2350533.1152523876013
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I searched the web and find these RTDM sample drivers (Thanks for the contributors):<br><br>In Xenomai src tree: ksrc/drivers/16550A/16550A.c<br><a href="http://www.captain.at/xenomai-real-time-driver-example.php">http://www.captain.at/xenomai-real-time-driver-example.php
</a><br><a href="http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/">http://www.rts.uni-hannover.de/rtnet/lxr/source/examples/xenomai/</a><br><a href="http://www.captain.at/xenomai-serial-port-example.php">
http://www.captain.at/xenomai-serial-port-example.php</a><br><br>Just wondering are there more samples?<br><br>Thanks,<br><br>-Yi<br><br><div><span class="gmail_quote">On 7/10/06, <b class="gmail_sendername">Jan Kiszka</b>
 &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Li Yi (Adam) wrote:
<br>&gt; Thanks Jan.<br>&gt;<br>&gt; You mentioned:<br>&gt; &quot;Depends on what you have to protect. The easiest way for short code<br>&gt; passages are still spinlocks with hard IRQ protection (under RTDM:<br>&gt; rtdm_lock_xxx). &quot;
<br>&gt;<br>&gt; I read the code of rtdm_lock_xxx and find it mapped to spin_lock. If I<br>&gt; understand correctly,<br>&gt;<br>&gt; a RTDM driver using:<br>&gt; rtdm_lock_get(&amp;my_lock);<br>&gt;<br>&gt; a normal linux driver using
<br>&gt; spin_lock(&amp;my_lock);<br>&gt;<br>&gt; Can be used to protect some shared data structure between RTDM real-time<br>&gt; driver in Xenomai Domain<br>&gt; and a normal Linux driver, right?<br><br>Yep. See also real-world examples in existing RTDM drivers.
<br><br>&gt;<br>&gt; I just started to write a RTDM driver, and I am not sure what existing<br>&gt; linux<br>&gt; kernel services<br>&gt; I can use in the RTDM driver, e.g, wait queue, semaphores, request_dma(),<br>&gt; free_dma(), etc.
<br>&gt; I have concern that the RTDM driver may not synchronize with linux kernel,<br>&gt; since it will<br>&gt; preempt Linux kernel whenever the HW interrupt is not masked.<br>&gt; Is there any guideline there?<br><br>
Keep in mind that Linux may have been preempted AT ANY POINT when your<br>driver executes some code in hard real-time mode. Therefore, calling<br>almost all Linux services from RT context must be considered unsafe<br>(unfortunately, it often works fine in practice, just fails/crashes
<br>&quot;magically&quot; from time to time).<br><br>But it's usually not required to do so as most of Linux interaction can<br>be performed during init/cleanup. Just register your open/socket and<br>close handler as &quot;_nrt&quot; so that they are only executed in pure Linux or
<br>secondary mode, and you can run whatever Linux service you like.<br><br>If you encounter any Linux service that you have to call for your driver<br>from IRQ or RT context, please report.<br><br>Jan<br><br><br><br></blockquote>
</div><br>

------=_Part_95001_2350533.1152523876013--

