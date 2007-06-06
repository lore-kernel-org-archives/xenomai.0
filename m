Message-ID: <7289437c0706060631x6db05689x37fd5206c8a88fb5@domain.hid>
Date: Wed, 6 Jun 2007 15:31:05 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <4666B186.6090303@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20402_1179934.1181136665598"
References: <7289437c0706060600n22effdc6l872cb6ba0df2e818@domain.hid>
	<4666B186.6090303@domain.hid>
Subject: Re: [Xenomai-help] Compatibility "Preemptible kernel" and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_20402_1179934.1181136665598
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for informations

On 6/6/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Perrine Martignoni wrote:
> > Hello,
> >
> > I would like to know if Xenomai is compatible with the option
> "Preemptible
> > Kernel" (CONFIG_PREEMPT) of Linux 2.6.19.
>
> It is. Though, you don't have to enable it to obtain good Xenomai
> latencies, tuning Linux is orthogonal.
>
> > And if CONFIG_PREEMPT  is the patch PREEMP_RT.
>
> Nope, PREEMPT_RT comes via this patch:
>
>        http://people.redhat.com/mingo/realtime-preempt/
>
> But this clashes with Xenomai at the moment. Until we provide a separate
> patch for a preempt-rt-patched kernel or the latter goes mainline (end
> of 2007 according to a fairly optimistic schedule), you have to stick
> with vanilla Linux.
>
> Jan
>
>
>

------=_Part_20402_1179934.1181136665598
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for informations<br><br>
<div><span class="gmail_quote">On 6/6/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I would like to know if Xenomai is compatible with the option &quot;Preemptible
<br>&gt; Kernel&quot; (CONFIG_PREEMPT) of Linux 2.6.19.<br><br>It is. Though, you don&#39;t have to enable it to obtain good Xenomai<br>latencies, tuning Linux is orthogonal.<br><br>&gt; And if CONFIG_PREEMPT&nbsp;&nbsp;is the patch PREEMP_RT.
<br><br>Nope, PREEMPT_RT comes via this patch:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://people.redhat.com/mingo/realtime-preempt/">http://people.redhat.com/mingo/realtime-preempt/</a><br><br>But this clashes with Xenomai at the moment. Until we provide a separate
<br>patch for a preempt-rt-patched kernel or the latter goes mainline (end<br>of 2007 according to a fairly optimistic schedule), you have to stick<br>with vanilla Linux.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_20402_1179934.1181136665598--

