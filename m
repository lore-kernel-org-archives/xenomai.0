Message-ID: <2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
Date: Tue, 17 Jul 2007 12:00:24 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707170210s437674f6ua7283d3e03e97a1b@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
	<2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
	<2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
	<2ff1a98a0707160225x7fa9f94fn70fe0de98d9c6055@domain.hid>
	<2862c2c80707160238g15576d2dm8d96634af5a0a8ec@domain.hid>
	<2ff1a98a0707160256w36d61f52nbdd8cb8c091ee97d@domain.hid>
	<2862c2c80707160301i786f94abn6ca72ac76b1b1631@domain.hid>
	<2862c2c80707160352n26db7ac2sddee9a6e6e7dd9c8@domain.hid>
	<2862c2c80707170210s437674f6ua7283d3e03e97a1b@domain.hid>
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
> Did you encounter any problems with AT91 Serial Ports when enabling IPIPE?

No.

>
> I have debugged the code and found out that whenever the rquest_irq is
> invoked in atmel_startup in ./driver/serial/atmel_serial.c. The system
> hangs.
>
> Any ideas?

Two ideas:
- how do you know that request_irq is hanging ? If you are using
printk to print through the serial console, maybe enabling the serial
port is a bit like sawing a branch on which you are sitting.
- if you are sure that request_irq is hanging, you can put a printk in
the interrupt handler to check if it is invoked in an endless loop.
Check if there is some path that lead it to return IRQ_NONE and if
this happens. Check that the acknowledgement routine works correctly.

-- 
                                               Gilles Chanteperdrix

