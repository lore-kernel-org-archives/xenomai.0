MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18290.52429.871263.495255@domain.hid>
Date: Wed, 26 Dec 2007 22:51:09 +0100
In-Reply-To: <20071221082724.GA9091@domain.hid>
References: <20071219150622.GA15974@domain.hid>
	<2ff1a98a0712190838n68ea4dacs9a27834e07de4939@domain.hid>
	<20071221082724.GA9091@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] PIOX irq problems with at91sam9260
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

Juan Antonio Garcia Redondo wrote:
 > I've found a workaround for my problem, but I'm not sure if is the
 > correct solution.
 > 
 > First, my test program test_irq.c had an error, after request the irq,
 > it have be enabled; anyway the problem persists because the
 > __ipipe_mach_demux_irq find the irq disabled (gpio->depth = 1).

You should not have to enable irqs, this should be done automatically
when requesting the irq. Which irq did you have to enable, the gpio irq
? Or the multiplexed one ?

 > 
 > My workaround:
 > +++ wrappers.h	2007-12-21 08:19:19.000000000 +0100
 > @@ -74,8 +74,15 @@
 >  #define rthal_irq_chip_disable(irq)  ({
 > rthal_irq_descp(irq)->chip->disable(irq); 0; })
 >  #define rthal_irq_chip_end(irq)      ({
 > rthal_irq_descp(irq)->ipipe_end(irq, rthal_irq_descp(irq)); 0; })
 >  typedef irq_handler_t rthal_irq_host_handler_t;
 > -#define rthal_mark_irq_disabled(irq) (rthal_irq_desc_status(irq) |=
 > IRQ_DISABLED)
 > -#define rthal_mark_irq_enabled(irq) (rthal_irq_desc_status(irq) &=
 > ~IRQ_DISABLED)
 > +#define rthal_mark_irq_disabled(irq) do {              \
 > +            rthal_irq_desc_status(irq) |= IRQ_DISABLED; \
 > +            rthal_irq_descp(irq)->depth = 1;            \
 > +        } while(0);
 > +#define rthal_mark_irq_enabled(irq) do {                 \
 > +            rthal_irq_desc_status(irq) &= ~IRQ_DISABLED; \
 > +            rthal_irq_descp(irq)->depth = 0;             \
 > +        } while(0);
 > +#endif

-- 


					    Gilles Chanteperdrix.

