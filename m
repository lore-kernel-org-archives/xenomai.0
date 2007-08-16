Message-ID: <2862c2c80708152016p293dc1c8t6f564a027ddb1e38@domain.hid>
Date: Thu, 16 Aug 2007 11:16:37 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <46C33453.8060402@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_52682_24666841.1187234197226"
References: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>
	<18113.34663.646158.524696@domain.hid>
	<2862c2c80708150224s4dd154b1j2aad7333ac04d150@domain.hid>
	<46C2EADF.4030505@domain.hid>
	<18114.64293.110182.524820@domain.hid>
	<46C33453.8060402@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_52682_24666841.1187234197226
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Jan and Gilles,

Thanks for your comment.

Is that the RTDM timer created using rtdm_timer_init uses the IPIPE time
base timer? In AT91, it will be the TCx which is configured as time base
Adeos IPIPE.

Regards,
Chun Yeow

On 8/16/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >  > Yeoh Chun Yeow wrote:
> >  > > By the way, do we need to invoke the rtdm_irq_enable after the
> >  > > rtdm_irq_request? After excuting the ISR, is that the return of
> >  > > RTDM_IRQ_HANDLED will reenble the interrupt?
> >  >
> >  > Depends on the version: With RTDM revision 6 (will be part of Xenomai
> >  > 2.4), this is no longer required. Earlier revision needed it, though.
> >  > See documentation.
> >
> > An if I am not wrong, RTDM revision 6 offers timers services as well,
>
> Yep.
>
> > so, Yeoh, developing your own timer management system really looks like
> > going the wrong way.
>
> It takes fairly unusual requirements to go some non-standard way here.
>
> Jan
>
>
>

------=_Part_52682_24666841.1187234197226
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Jan and Gilles,<br><br>Thanks for your comment. <br><br>Is that the RTDM timer created using rtdm_timer_init uses the IPIPE time base timer? In AT91, it will be the TCx which is configured as time base Adeos IPIPE.<br>
<br>Regards,<br>Chun Yeow<br><br><div><span class="gmail_quote">On 8/16/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Gilles Chanteperdrix wrote:<br>&gt; Jan Kiszka wrote:<br>&gt;&nbsp;&nbsp;&gt; Yeoh Chun Yeow wrote:<br>&gt;&nbsp;&nbsp;&gt; &gt; By the way, do we need to invoke the rtdm_irq_enable after the<br>&gt;&nbsp;&nbsp;&gt; &gt; rtdm_irq_request? After excuting the ISR, is that the return of
<br>&gt;&nbsp;&nbsp;&gt; &gt; RTDM_IRQ_HANDLED will reenble the interrupt?<br>&gt;&nbsp;&nbsp;&gt;<br>&gt;&nbsp;&nbsp;&gt; Depends on the version: With RTDM revision 6 (will be part of Xenomai<br>&gt;&nbsp;&nbsp;&gt; 2.4), this is no longer required. Earlier revision needed it, though.
<br>&gt;&nbsp;&nbsp;&gt; See documentation.<br>&gt;<br>&gt; An if I am not wrong, RTDM revision 6 offers timers services as well,<br><br>Yep.<br><br>&gt; so, Yeoh, developing your own timer management system really looks like<br>&gt; going the wrong way.
<br><br>It takes fairly unusual requirements to go some non-standard way here.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_52682_24666841.1187234197226--

