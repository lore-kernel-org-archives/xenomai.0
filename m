Message-ID: <4EF44DB9.9000609@domain.hid>
Date: Fri, 23 Dec 2011 10:45:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <56F449AE83D74177BAC5887692E0EF55@domain.hid>
In-Reply-To: <56F449AE83D74177BAC5887692E0EF55@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt numbers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 12/23/2011 01:38 AM, Terry Fryar wrote:
> Using Xenomai 2.60 with 2.6.38 omap kernel on beagleboard xm.  
>  
> Trying to use a GPIO pin as an interrupt and catch this in a xenomai
> userspace program.  Got the GPIO132 pin set as an input and is working fine.
> I guess I'll need to set the irq enable register on the omap cpu to enable
> it to generate irqs.  Now...what irq number do I use in the xenomai
> rt_intr_create() function call??  I'm not sure how the omap gpio interrupts
> are mapped to the linux kernel/xenomai stuff??  Can I use what's in the
> arch/arm/plat-omap/include/plat/irqs.h header file?  It appears that each
> bank of GPIO pins has it's own interrupt number??

Xenomai uses the same interrupt numbers as linux. But rt_intr_create is
deprecated in user-space, you should instead write a driver using the
rtdm skin. The enable bit is handled by xenomai when you request the irq
at xenomai level.

-- 
					    Gilles.

