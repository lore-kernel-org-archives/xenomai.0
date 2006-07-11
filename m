Message-ID: <4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>
Date: Tue, 11 Jul 2006 14:53:41 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_105817_23158374.1152600821954"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B1FDBD.4060600@domain.hid>
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
	<44B218C5.9000804@domain.hid>
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
	<44B2216A.1060904@domain.hid>
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
	<44B341E2.9040506@domain.hid>
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
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

------=_Part_105817_23158374.1152600821954
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry that the email was cut off by Gmail (not sure why).

Continue with last mail:

>From the code, it looks rtdm_lock_get_irqsave() will "stalls" Xenomai domain
and implicitly Linux domain, right?

Yesterday I was thinking if a Linux task  uses spin_lock_irqsave() would
disable HW interrupt. So the Linux task can
be protected from being preempted by Xenomai task. But it turns out that
spin_lock_irqsave() will stalls Linux domain only.

Thank you for the clarification.

-Yi

On 7/11/06, Li Yi (Adam) <liyiadam@domain.hid> wrote:
>
> Yes. I am concerned about UP situation. But I am still a little confused.
>
> Do you mean in a "normal Linux driver", I can use
>
> rtdm_lock_get_irqsave() to protect my Linux task from being preempted by
> Xenomai task?
>
>
> The code shows that:
> "
> #define rtdm_lock_get_irqsave(lock, context)    \
>     rthal_spin_lock_irqsave(lock, context).
>
> #define rthal_spin_lock_irqsave(lock,x) \
> do {  \
>     rthal_local_irq_save(x); \
>     rthal_spin_lock(lock); \
> } while(0)
>
> #define rthal_local_irq_save(x) ((x) =
> !!ipipe_test_and_stall_pipeline_from(&rthal_domain)
>

------=_Part_105817_23158374.1152600821954
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry that the email was cut off by Gmail (not sure why).<br><br>Continue with last mail:<br><br>From the code, it looks rtdm_lock_get_irqsave() will &quot;stalls&quot; Xenomai domain and implicitly Linux domain, right?<br>
<br>Yesterday I was thinking if a Linux task&nbsp; uses spin_lock_irqsave() would disable HW interrupt. So the Linux task can<br>be protected from being preempted by Xenomai task. But it turns out that spin_lock_irqsave() will stalls Linux domain only.
<br><br>Thank you for the clarification.<br><br>-Yi<br><br><div><span class="gmail_quote">On 7/11/06, <b class="gmail_sendername">Li Yi (Adam)</b> &lt;<a href="mailto:liyiadam@domain.hid">liyiadam@domain.hid</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>Yes. I am concerned about UP situation. But I am still a little confused.<br><br>Do you mean in a &quot;normal Linux driver&quot;, I can use
<br><br>rtdm_lock_get_irqsave() to protect my Linux task from being preempted by Xenomai task?
<br><br><br>The code shows that:<br>&quot;<br>#define rtdm_lock_get_irqsave(lock, context)&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp; rthal_spin_lock_irqsave(lock, context).<br><br>#define rthal_spin_lock_irqsave(lock,x) \<br>
do {&nbsp; \<br>
&nbsp;&nbsp;&nbsp; rthal_local_irq_save(x); \<br>
&nbsp;&nbsp;&nbsp; rthal_spin_lock(lock); \<br>
} while(0)
<br><br>#define rthal_local_irq_save(x)		((x) = !!ipipe_test_and_stall_pipeline_from(&amp;rthal_domain)

</div></blockquote></div><br>

------=_Part_105817_23158374.1152600821954--

