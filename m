Message-ID: <2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
Date: Tue, 17 Jul 2007 18:36:04 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_53109_6308623.1184668564934"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
	<2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
	<2ff1a98a0707160225x7fa9f94fn70fe0de98d9c6055@domain.hid>
	<2862c2c80707160238g15576d2dm8d96634af5a0a8ec@domain.hid>
	<2ff1a98a0707160256w36d61f52nbdd8cb8c091ee97d@domain.hid>
	<2862c2c80707160301i786f94abn6ca72ac76b1b1631@domain.hid>
	<2862c2c80707160352n26db7ac2sddee9a6e6e7dd9c8@domain.hid>
	<2862c2c80707170210s437674f6ua7283d3e03e97a1b@domain.hid>
	<2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
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

------=_Part_53109_6308623.1184668564934
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

I have disabled the request_irq in the atmel serial driver and try to ping
my system and it works. Whenever I re-enable request_irq in atmel serial
driver,  the system can not be PING at all.

As you said, I put a printk in the atmel_interrupt (atmel serial interrupt)
and it is invoked in an endless loop. However, this routine only returns
IRQ_HANDLED and not IRQ_NONE. So how?

regards,
chun yeow

On 7/17/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 7/17/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> > Dear Gilles,
> >
> > Did you encounter any problems with AT91 Serial Ports when enabling
> IPIPE?
>
> No.
>
> >
> > I have debugged the code and found out that whenever the rquest_irq is
> > invoked in atmel_startup in ./driver/serial/atmel_serial.c. The system
> > hangs.
> >
> > Any ideas?
>
> Two ideas:
> - how do you know that request_irq is hanging ? If you are using
> printk to print through the serial console, maybe enabling the serial
> port is a bit like sawing a branch on which you are sitting.
> - if you are sure that request_irq is hanging, you can put a printk in
> the interrupt handler to check if it is invoked in an endless loop.
> Check if there is some path that lead it to return IRQ_NONE and if
> this happens. Check that the acknowledgement routine works correctly.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_53109_6308623.1184668564934
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>I have disabled the request_irq in the atmel serial driver and try to ping my system and it works. Whenever I re-enable request_irq in atmel serial driver,&nbsp; the system can not be PING at all.<br><br>As you said, I put a printk in the atmel_interrupt (atmel serial interrupt) and it is invoked in an endless loop. However, this routine only returns IRQ_HANDLED and not IRQ_NONE. So how?
<br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">On 7/17/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On 7/17/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">yeohchunyeow@domain.hid
</a>&gt; wrote:<br>&gt; Dear Gilles,<br>&gt;<br>&gt; Did you encounter any problems with AT91 Serial Ports when enabling IPIPE?<br><br>No.<br><br>&gt;<br>&gt; I have debugged the code and found out that whenever the rquest_irq is
<br>&gt; invoked in atmel_startup in ./driver/serial/atmel_serial.c. The system<br>&gt; hangs.<br>&gt;<br>&gt; Any ideas?<br><br>Two ideas:<br>- how do you know that request_irq is hanging ? If you are using<br>printk to print through the serial console, maybe enabling the serial
<br>port is a bit like sawing a branch on which you are sitting.<br>- if you are sure that request_irq is hanging, you can put a printk in<br>the interrupt handler to check if it is invoked in an endless loop.<br>Check if there is some path that lead it to return IRQ_NONE and if
<br>this happens. Check that the acknowledgement routine works correctly.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_53109_6308623.1184668564934--

