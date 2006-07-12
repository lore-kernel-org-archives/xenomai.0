Message-ID: <4546494d0607120034l3635fb89yda1c79bcbd6c196b@domain.hid>
Date: Wed, 12 Jul 2006 15:34:25 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <44B497FE.9090207@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_118730_31190345.1152689665458"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B2216A.1060904@domain.hid>
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
	<44B341E2.9040506@domain.hid>
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>
	<44B35346.2070200@domain.hid>
	<4546494d0607110043x45804030td009ed790040420b@domain.hid>
	<4546494d0607111851t3d432f80offde2c1a2ef37689@domain.hid>
	<44B497FE.9090207@domain.hid>
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

------=_Part_118730_31190345.1152689665458
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Jan.

If I understand correctly, a normal Linux task (in kernel or user space) may
call rt_task_suspend()/rt_task_resume()
to suspend/resume the execution of a RT task -- Originally I am thinking
only RT tasks can use such APIs - Looks I am wrong here.

Thanks for the clafiication.

-Yi



On 7/12/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Li Yi (Adam) wrote:
> > Hi Jan,
> >
> > You mentioned that:
> >
> > "You might prevent rescheduling by
> > setting the scheduler lock of Xenomai, but this still doesn't protect
> > from IRQs."
> >
> > If I don't want to stop Xenomai domain from receiving interrupt at all,
> > Just want to block certain Xenomai task.
>
> Then take care of this in the IRQ handler: if some task shall not
> receive any notification, do not deliver. Or disable the specific IRQ
> (rtdm_irq_disable) as long as it is not shared and no other tasks are
> waiting for it.
>
> > Is there a specific set of functions/macros which disable/enable
> specific
> > real-time event
> > processing (for instance, real-time task execution).  In this scheme,
> > the ADEOS scheduler still executes, but now checks whether a real-time
>
> Adeos has no scheduler, it only maintains the IRQ/event pipepline.
>
> > task has been "blocked" for execution.  If it is blocked, the scheduler
> > does not schedule the task. When the real-time task is "unblocked" by
> > the Linux ROOT domain, it resumes real-time execution.
>
> rt_task_suspend/resume of the native skin may help you. But, of course,
> this will not prevent the IRQ handler from being executed. And there are
> likely other ways, but this depends on your application design which I
> don't know. In any case, nothing RT-specific here.
>
> Jan
>
>
>
>

------=_Part_118730_31190345.1152689665458
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Jan.<br><br>If I understand correctly, a normal Linux task (in kernel or user space) may call rt_task_suspend()/rt_task_resume()<br>to suspend/resume the execution of a RT task -- Originally I am thinking only RT tasks can use such APIs - Looks I am wrong here.
<br><br>Thanks for the clafiication.<br><br>-Yi<br><br><br><br><div><span class="gmail_quote">On 7/12/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Li Yi (Adam) wrote:<br>&gt; Hi Jan,<br>&gt;<br>&gt; You mentioned that:<br>&gt;<br>&gt; &quot;You might prevent rescheduling by
<br>&gt; setting the scheduler lock of Xenomai, but this still doesn't protect<br>&gt; from IRQs.&quot;<br>&gt;<br>&gt; If I don't want to stop Xenomai domain from receiving interrupt at all,<br>&gt; Just want to block certain Xenomai task.
<br><br>Then take care of this in the IRQ handler: if some task shall not<br>receive any notification, do not deliver. Or disable the specific IRQ<br>(rtdm_irq_disable) as long as it is not shared and no other tasks are<br>
waiting for it.<br><br>&gt; Is there a specific set of functions/macros which disable/enable specific<br>&gt; real-time event<br>&gt; processing (for instance, real-time task execution).&nbsp;&nbsp;In this scheme,<br>&gt; the ADEOS scheduler still executes, but now checks whether a real-time
<br><br>Adeos has no scheduler, it only maintains the IRQ/event pipepline.<br><br>&gt; task has been &quot;blocked&quot; for execution.&nbsp;&nbsp;If it is blocked, the scheduler<br>&gt; does not schedule the task. When the real-time task is &quot;unblocked&quot; by
<br>&gt; the Linux ROOT domain, it resumes real-time execution.<br><br>rt_task_suspend/resume of the native skin may help you. But, of course,<br>this will not prevent the IRQ handler from being executed. And there are<br>
likely other ways, but this depends on your application design which I<br>don't know. In any case, nothing RT-specific here.<br><br>Jan<br><br><br><br></blockquote></div><br>

------=_Part_118730_31190345.1152689665458--

