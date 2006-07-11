Message-ID: <4546494d0607110043x45804030td009ed790040420b@domain.hid>
Date: Tue, 11 Jul 2006 15:43:29 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <44B35346.2070200@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_106133_3938606.1152603809222"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
	<44B218C5.9000804@domain.hid>
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
	<44B2216A.1060904@domain.hid>
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
	<44B341E2.9040506@domain.hid>
	<4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
	<4546494d0607102353j99dee1na4209decc75b05ec@domain.hid>
	<44B35346.2070200@domain.hid>
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

------=_Part_106133_3938606.1152603809222
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jan,

Sorry but could you help to confirm the other question in my last (last)
mail:

"Do you mean in a "normal Linux driver", I can use

rtdm_lock_get_irqsave() to protect my Linux task from being preempted by
Xenomai task? "


Thanks many!

-Yi

On 7/11/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Li Yi (Adam) wrote:
> > Sorry that the email was cut off by Gmail (not sure why).
> >
> > Continue with last mail:
> >
> > From the code, it looks rtdm_lock_get_irqsave() will "stalls" Xenomai
> > domain
> > and implicitly Linux domain, right?
>
> Yep.
>
> >
> > Yesterday I was thinking if a Linux task  uses spin_lock_irqsave() would
> > disable HW interrupt. So the Linux task can
> > be protected from being preempted by Xenomai task. But it turns out that
> > spin_lock_irqsave() will stalls Linux domain only.
>
> True.
>
> Jan
>
>
>
>

------=_Part_106133_3938606.1152603809222
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jan,<br><br>Sorry but could you help to confirm the other question in my last (last) mail:<br><br>&quot;Do you mean in a &quot;normal Linux driver&quot;, I can use<br><br>rtdm_lock_get_irqsave() to protect my Linux task from being preempted by Xenomai task?
&quot;<br><br><br>Thanks many!<br><br>-Yi<br><br><div><span class="gmail_quote">On 7/11/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Li Yi (Adam) wrote:<br>&gt; Sorry that the email was cut off by Gmail (not sure why).<br>&gt;<br>&gt; Continue with last mail:<br>&gt;<br>&gt; From the code, it looks rtdm_lock_get_irqsave() will &quot;stalls&quot; Xenomai
<br>&gt; domain<br>&gt; and implicitly Linux domain, right?<br><br>Yep.<br><br>&gt;<br>&gt; Yesterday I was thinking if a Linux task&nbsp;&nbsp;uses spin_lock_irqsave() would<br>&gt; disable HW interrupt. So the Linux task can<br>&gt; be protected from being preempted by Xenomai task. But it turns out that
<br>&gt; spin_lock_irqsave() will stalls Linux domain only.<br><br>True.<br><br>Jan<br><br><br><br></blockquote></div><br>

------=_Part_106133_3938606.1152603809222--

