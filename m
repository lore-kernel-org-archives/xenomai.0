Message-ID: <7289437c0710050018r3eed443bi7fe66a0d9b238e04@domain.hid>
Date: Fri, 5 Oct 2007 09:18:22 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <470563EE.9000406@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14086_14468821.1191568702448"
References: <7289437c0710040254t676bf4u2615d5d794e82045@domain.hid>
	<470563EE.9000406@domain.hid>
Subject: Re: [Xenomai-help] IRQ managment with RTDM
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

------=_Part_14086_14468821.1191568702448
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can use set_irq_type() just before rtdm_irq_request() ?
I don't use shared IRQs, so I wouldn't have any problem.

On 10/5/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Perrine Martignoni wrote:
> > Hello,
> >
> > I would like to know how we configure interrupts in falling edge or
> rising
> > edge with RTDM.
> > I have to rewrite a linux driver in RTDM module and I don't find the
> > equivalent of IRQF_TRIGGER_FALLING.
>
> There is no such thing in RTDM. You can use set_irq_type() for this,
> like some Linux drivers do as well. But the cleaner approach indeed seem
> to be to let RTDM manage the flags (and check if there conflicts in case
> of shared IRQs). Will put it on the todo list, but not with a high prio.
>
> Jan
>
>
>

------=_Part_14086_14468821.1191568702448
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I can use set_irq_type() just before rtdm_irq_request() ?<br>I don&#39;t use shared IRQs, so I wouldn&#39;t have any problem.<br><br><div><span class="gmail_quote">On 10/5/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;
<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Perrine Martignoni wrote:
<br>&gt; Hello,<br>&gt;<br>&gt; I would like to know how we configure interrupts in falling edge or rising<br>&gt; edge with RTDM.<br>&gt; I have to rewrite a linux driver in RTDM module and I don&#39;t find the<br>&gt; equivalent of IRQF_TRIGGER_FALLING.
<br><br>There is no such thing in RTDM. You can use set_irq_type() for this,<br>like some Linux drivers do as well. But the cleaner approach indeed seem<br>to be to let RTDM manage the flags (and check if there conflicts in case
<br>of shared IRQs). Will put it on the todo list, but not with a high prio.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_14086_14468821.1191568702448--

