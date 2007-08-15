Message-ID: <2862c2c80708150224s4dd154b1j2aad7333ac04d150@domain.hid>
Date: Wed, 15 Aug 2007 17:24:24 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <18113.34663.646158.524696@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_41454_32420032.1187169864271"
References: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>
	<18113.34663.646158.524696@domain.hid>
Subject: Re: [Xenomai-help] Kernel Opps calling rtdm_irq_request
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

------=_Part_41454_32420032.1187169864271
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Sorry, it's my own mistake. I forgot to append the dev_private when openning
the device. I am actually using the TC1 for testing and not TC0 (TC0 is
selected for IPIPE usage).

By the way, do we need to invoke the rtdm_irq_enable after the
rtdm_irq_request? After excuting the ISR, is that the return of
RTDM_IRQ_HANDLED will reenble the interrupt?

Please advice. Thanks

regards,
chun yeow

On 8/14/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Yeoh Chun Yeow wrote:
> > Dear all,
> >
> > I have try to attach a AT91 TC hardware interrupt using
> rtdm_irq_request.
>
> Sorry, I misunderstood your question. No, you can not do that, the TC
> hardware is driven by Xenomai in one shot mode, you can not expect it to
> tick on a regular basis. Besides, timers (either posix timers or native
> alarms) are really what you are looking for. Nevertheless, you should
> not get a oops when trying to do that.
>
> >
> > Whenever the rtdm_irq_request is called, the kernel Oops occurs.
> >
> > Any ideas on the problem?
>
>
> Either a programming error, or a bug in Xenomai. Could you show us the
> code that triggers this behaviour ? Did you enable support for shared
> IRQs in Xenomai ? The TC irq has to be shared in Xenomai domain, since
> it is used by Xenomai and you also want to use it.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_41454_32420032.1187169864271
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Sorry, it&#39;s my own mistake. I forgot to append the dev_private when openning the device. I am actually using the TC1 for testing and not TC0 (TC0 is selected for IPIPE usage).<br><br>By the way, do we need to invoke the rtdm_irq_enable after the rtdm_irq_request? After excuting the ISR, is that the return of RTDM_IRQ_HANDLED will reenble the interrupt?
<br><br>Please advice. Thanks<br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">On 8/14/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Yeoh Chun Yeow wrote:<br> &gt; Dear all,<br> &gt;<br> &gt; I have try to attach a AT91 TC hardware interrupt using rtdm_irq_request.
<br><br>Sorry, I misunderstood your question. No, you can not do that, the TC<br>hardware is driven by Xenomai in one shot mode, you can not expect it to<br>tick on a regular basis. Besides, timers (either posix timers or native
<br>alarms) are really what you are looking for. Nevertheless, you should<br>not get a oops when trying to do that.<br><br> &gt;<br> &gt; Whenever the rtdm_irq_request is called, the kernel Oops occurs.<br> &gt;<br> &gt; Any ideas on the problem?
<br><br><br>Either a programming error, or a bug in Xenomai. Could you show us the<br>code that triggers this behaviour ? Did you enable support for shared<br>IRQs in Xenomai ? The TC irq has to be shared in Xenomai domain, since
<br>it is used by Xenomai and you also want to use it.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br></blockquote></div><br>

------=_Part_41454_32420032.1187169864271--

