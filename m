Message-ID: <49DCA4DC.3090109@domain.hid>
Date: Wed, 08 Apr 2009 15:21:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37f89760904080541u4cdff5b2weec809904146cea3@domain.hid>	
	<49DC9E5D.90404@domain.hid>
	<37f89760904080607r6ca05fc6ufb8dd3459e2cdfeb@domain.hid>
In-Reply-To: <37f89760904080607r6ca05fc6ufb8dd3459e2cdfeb@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ issue :xnintr_irq_handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: xenomai@xenomai.org

Marcel Soulot wrote:
> But why does it work for my uart driver and not for my gpio driver ?
> They works in the same way about irq management, spoke to the same chip?

I have to admit that I did not really understand what your problem is. I
only told you what "Xenomai: xnintr_irq_handler: IRQ10 not handled"
means. Without seeing the driver code, I can not tell you much more,
except that it all boils down to the driver returning XN_ISR_NONE. For
the system to work correctly, when one driver returns XN_ISR_NONE,
another driver has to handle (meaning really making the peripheral
deasssert the irq line) the interrupt and return XN_ISR_HANDLED.

-- 
                                                 Gilles.

