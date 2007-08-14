Message-ID: <2862c2c80708140310i22fabe68w5d8d6670c8cc0226@domain.hid>
Date: Tue, 14 Aug 2007 18:10:13 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <18112.16815.606280.878902@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26386_18643472.1187086213037"
References: <2862c2c80708130403v62b21fd5va7b5919bd996dbaf@domain.hid>
	<18112.16815.606280.878902@domain.hid>
Subject: Re: [Xenomai-help] System Timer Interrupt Sharing?
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
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_26386_18643472.1187086213037
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Thanks for your response. Yes, I know that AT91 uses the TC instead of
system timer interrupt.

FYI, I also doing development using Intel M Processor.

regards,
chun yeow

On 8/13/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Yeoh Chun Yeow wrote:
> > Dear all,
> >
> > Is that possible to share the system timer interrupt used for xenomai
> kernel
> > scheduling for any other purposes?
> >
> > Please advice. Thanks
>
> I guess you are talking about Xenomai on AT91. Xenomai on AT91 does not
> use the system timer interrupt, it uses the timer counter interrupt
> instead. So, yes, you can use system timer interrupt for any other non
> real-time activity.
>
> Now, if your question is to know if it is possible to share an interrupt
> between real-time and not real-time activity, the answer is that it is
> not easy. If you want to do this, you will have to move the hardware
> acknowledgement part of the non real-time interrupt handler to a
> real-time interrupt handler, and, when an event is pending for the non
> real-time domain, propagate the irq.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_26386_18643472.1187086213037
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Thanks for your response. Yes, I know that AT91 uses the TC instead of system timer interrupt. <br><br>FYI, I also doing development using Intel M Processor. <br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">
On 8/13/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">gilles.chanteperdrix@xenomai.org</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Yeoh Chun Yeow wrote:<br> &gt; Dear all,<br> &gt;<br> &gt; Is that possible to share the system timer interrupt used for xenomai kernel<br> &gt; scheduling for any other purposes?<br> &gt;<br> &gt; Please advice. Thanks<br>

<br>I guess you are talking about Xenomai on AT91. Xenomai on AT91 does not<br>use the system timer interrupt, it uses the timer counter interrupt<br>instead. So, yes, you can use system timer interrupt for any other non
<br>
real-time activity.<br><br>Now, if your question is to know if it is possible to share an interrupt<br>between real-time and not real-time activity, the answer is that it is<br>not easy. If you want to do this, you will have to move the hardware
<br>acknowledgement part of the non real-time interrupt handler to a<br>real-time interrupt handler, and, when an event is pending for the non<br>real-time domain, propagate the irq.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.
<br></blockquote></div><br>

------=_Part_26386_18643472.1187086213037--

