Message-ID: <7289437c0712030905p62cec8ebt769a03fbdd9d1a9a@domain.hid>
Date: Mon, 3 Dec 2007 18:05:01 +0100
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <2ff1a98a0712030253h6c9e6053q8143777cc37d9cdc@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5712_2554723.1196701501600"
References: <7289437c0712030216y5bd7d9f1p6af2a9cd4870d813@domain.hid>
	<2ff1a98a0712030253h6c9e6053q8143777cc37d9cdc@domain.hid>
Subject: Re: [Xenomai-help] RTDM : Event wait
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

------=_Part_5712_2554723.1196701501600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, Thanks.
I'll do it with RT User-space Task. So, how can I include rtdm_driver.h in
my user application to use by example rtdm_event_wait ?
I have this error : "This header is for kernel space usage only. You are
likely looking for rtdm/rtdm.h"



On Dec 3, 2007 11:53 AM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> wrote:

> On Dec 3, 2007 11:16 AM, Perrine Martignoni < perrmart@domain.hid> wrote:
> > Hi,
> >
> > I would like to know what mecanism allows to wait events from User-space
> > task (RT and non RT). I want to have some User-space Tasks waiting
> events
> > from the kernel.
> > I just read that rtdm_event_wait can be called only from RT User-space
> task.
> > Any idea ?
>
> The non real-time task waiting for an event should use one of the
> wait_event_* calls defined in linux/wait.h. In order to signal the
> event from a real-time task, you will have to post a non real-time
> signal (rtdm_nrtsig_pend) that will call one of the wake_up_* calls
> (also defined in linux/wait.h).
>
> For an explanation of wait_event*/wake_up* see Linux Device Drivers
> chapter 6:
> http://lwn.net/images/pdf/LDD3/ch06.pdf
>
> --
>                                               Gilles Chanteperdrix
>

------=_Part_5712_2554723.1196701501600
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, Thanks.<br>I&#39;ll do it with RT User-space Task. So, how can I include rtdm_driver.h in my user application to use by example rtdm_event_wait ? <br>I have this error : &quot;This header is for kernel space usage only. You are likely looking for rtdm/rtdm.h&quot;
<br><br><br><br><div class="gmail_quote">On Dec 3, 2007 11:53 AM, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank">gilles.chanteperdrix@xenomai.org
</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div>On Dec 3, 2007 11:16 AM, Perrine Martignoni &lt;
<a href="mailto:perrmart@domain.hid" target="_blank">perrmart@domain.hid</a>&gt; wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I would like to know what mecanism allows to wait events from User-space<br>&gt; task (RT and non RT). I want to have some User-space Tasks waiting events
<br>&gt; from the kernel.<br>&gt; I just read that rtdm_event_wait can be called only from RT User-space task.<br>&gt; Any idea ?<br><br></div></div>The non real-time task waiting for an event should use one of the<br>wait_event_* calls defined in linux/wait.h. In order to signal the
<br>event from a real-time task, you will have to post a non real-time<br>signal (rtdm_nrtsig_pend) that will call one of the wake_up_* calls<br>(also defined in linux/wait.h).<br><br>For an explanation of wait_event*/wake_up* see Linux Device Drivers chapter 6:
<br><a href="http://lwn.net/images/pdf/LDD3/ch06.pdf" target="_blank">http://lwn.net/images/pdf/LDD3/ch06.pdf</a><br><br>--<br><font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles Chanteperdrix<br>
</font>
</blockquote></div><br>

------=_Part_5712_2554723.1196701501600--

