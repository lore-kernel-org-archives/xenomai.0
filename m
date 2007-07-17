Message-ID: <2ff1a98a0707170609u5da092a1nf32d4789b579717@domain.hid>
Date: Tue, 17 Jul 2007 15:09:16 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
	<2ff1a98a0707160225x7fa9f94fn70fe0de98d9c6055@domain.hid>
	<2862c2c80707160238g15576d2dm8d96634af5a0a8ec@domain.hid>
	<2ff1a98a0707160256w36d61f52nbdd8cb8c091ee97d@domain.hid>
	<2862c2c80707160301i786f94abn6ca72ac76b1b1631@domain.hid>
	<2862c2c80707160352n26db7ac2sddee9a6e6e7dd9c8@domain.hid>
	<2862c2c80707170210s437674f6ua7283d3e03e97a1b@domain.hid>
	<2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
	<2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
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
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/17/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> Dear Gilles,
>
> I have disabled the request_irq in the atmel serial driver and try to ping
> my system and it works. Whenever I re-enable request_irq in atmel serial
> driver,  the system can not be PING at all.
>
> As you said, I put a printk in the atmel_interrupt (atmel serial interrupt)
> and it is invoked in an endless loop. However, this routine only returns
> IRQ_HANDLED and not IRQ_NONE. So how?

Try printing the contents of the "status" and "pending" (should be
null) variables.  Get the AT91 datasheet and try to understand what
these values mean.

You can also try to put an UART_PUT_CR(port, 0) right after
UART_PUT_IDR(port, -1) in function atmel_startup.

-- 
                                               Gilles Chanteperdrix

