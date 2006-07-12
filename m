Message-ID: <4546494d0607111851t3d432f80offde2c1a2ef37689@domain.hid>
Date: Wed, 12 Jul 2006 09:51:20 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <4546494d0607110043x45804030td009ed790040420b@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_116389_17411831.1152669080779"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B218C5.9000804@domain.hid>
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
	<44B2216A.1060904@domain.hid>
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
	<44B341E2.9040506@domain.hid>
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>
	<44B35346.2070200@domain.hid>
	<4546494d0607110043x45804030td009ed790040420b@domain.hid>
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

------=_Part_116389_17411831.1152669080779
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jan,

You mentioned that:

"You might prevent rescheduling by
setting the scheduler lock of Xenomai, but this still doesn't protect
from IRQs."

If I don't want to stop Xenomai domain from receiving interrupt at all,
Just want to block certain Xenomai task.
Is there a specific set of functions/macros which disable/enable specific
real-time event
processing (for instance, real-time task execution).  In this scheme,
the ADEOS scheduler still executes, but now checks whether a real-time
task has been "blocked" for execution.  If it is blocked, the scheduler
does not schedule the task. When the real-time task is "unblocked" by
the Linux ROOT domain, it resumes real-time execution.

Thanks,

-Yi

On 7/11/06, Li Yi (Adam) <liyiadam@domain.hid> wrote:
>
> Jan,
>
> Sorry but could you help to confirm the other question in my last (last)
> mail:
>
>
> "Do you mean in a "normal Linux driver", I can use
>
> rtdm_lock_get_irqsave() to protect my Linux task from being preempted by
> Xenomai task? "
>
>
> Thanks many!
>
> -Yi
>
>
> On 7/11/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >
> > Li Yi (Adam) wrote:
> > > Sorry that the email was cut off by Gmail (not sure why).
> > >
> > > Continue with last mail:
> > >
> > > From the code, it looks rtdm_lock_get_irqsave() will "stalls" Xenomai
> > > domain
> > > and implicitly Linux domain, right?
> >
> > Yep.
> >
> > >
> > > Yesterday I was thinking if a Linux task  uses spin_lock_irqsave()
> > would
> > > disable HW interrupt. So the Linux task can
> > > be protected from being preempted by Xenomai task. But it turns out
> > that
> > > spin_lock_irqsave() will stalls Linux domain only.
> >
> > True.
> >
> > Jan
> >
> >
> >
> >
>

------=_Part_116389_17411831.1152669080779
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jan,<br><br>You mentioned that: <br><br>&quot;You might prevent rescheduling by<br>setting the scheduler lock of Xenomai, but this still doesn't protect<br>from IRQs.&quot;<br><br>If I don't want to stop Xenomai domain from receiving interrupt at all, 
<br>Just want to block certain Xenomai task. <br>Is there a specific set of functions/macros which disable/enable specific real-time event<br>processing (for instance, real-time task execution).&nbsp; In this scheme,<br>the ADEOS scheduler still executes, but now checks whether a real-time
<br>task has been &quot;blocked&quot; for execution.&nbsp; If it is blocked, the scheduler<br>does not schedule the task. When the real-time task is &quot;unblocked&quot; by<br>the Linux ROOT domain, it resumes real-time execution.
<br><br>Thanks,<br><br>-Yi<br><br><div><span class="gmail_quote">On 7/11/06, <b class="gmail_sendername">Li Yi (Adam)</b> &lt;<a href="mailto:liyiadam@domain.hid">liyiadam@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Jan,<br><br>Sorry but could you help to confirm the other question in my last (last) mail:</div><div><span class="q"><br><br>&quot;Do you mean in a &quot;normal Linux driver&quot;, I can use<br><br></span></div><div>
rtdm_lock_get_irqsave() to protect my Linux task from being preempted by Xenomai task?
&quot;<br><br><br>Thanks many!<br></div><div><span class="sg"><br>-Yi</span></div><div><span class="e" id="q_10c5c8a6534ce22a_4"><br><br><div><span class="gmail_quote">On 7/11/06, <b class="gmail_sendername">Jan Kiszka</b>
 &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Li Yi (Adam) wrote:<br>&gt; Sorry that the email was cut off by Gmail (not sure why).<br>&gt;<br>&gt; Continue with last mail:<br>&gt;<br>&gt; From the code, it looks rtdm_lock_get_irqsave() will &quot;stalls&quot; Xenomai
<br>&gt; domain<br>&gt; and implicitly Linux domain, right?<br><br>Yep.<br><br>&gt;<br>&gt; Yesterday I was thinking if a Linux task&nbsp;&nbsp;uses spin_lock_irqsave() would<br>&gt; disable HW interrupt. So the Linux task can<br>
&gt; be protected from being preempted by Xenomai task. But it turns out that
<br>&gt; spin_lock_irqsave() will stalls Linux domain only.<br><br>True.<br><br>Jan<br><br><br><br></blockquote></div><br>

</span></div></blockquote></div><br>

------=_Part_116389_17411831.1152669080779--

