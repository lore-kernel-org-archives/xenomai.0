MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18293.27304.743380.115076@domain.hid>
Date: Fri, 28 Dec 2007 22:29:12 +0100
In-Reply-To: <20071228082907.GA27638@domain.hid>
References: <20071219150622.GA15974@domain.hid>
	<2ff1a98a0712190838n68ea4dacs9a27834e07de4939@domain.hid>
	<20071221082724.GA9091@domain.hid>
	<18290.52429.871263.495255@domain.hid>
	<20071228082907.GA27638@domain.hid>
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
 > On 26/12/07 22:51, Gilles Chanteperdrix wrote:
 > > Juan Antonio Garcia Redondo wrote:
 > >  > I've found a workaround for my problem, but I'm not sure if is the
 > >  > correct solution.
 > >  > 
 > >  > First, my test program test_irq.c had an error, after request the irq,
 > >  > it have be enabled; anyway the problem persists because the
 > >  > __ipipe_mach_demux_irq find the irq disabled (gpio->depth = 1).
 > > 
 > > You should not have to enable irqs, this should be done automatically
 > > when requesting the irq. Which irq did you have to enable, the gpio irq
 > > ? Or the multiplexed one ?
 > 
 > I'm using the PIOB_11 as gpio and programming it as input before run the
 > test_irq.
 > I have to enable the irq by mean of rt_intr_enable, otherwise the
 > correspondent bit of IMR (Interrupt Mask Register) is disabled. Moreover
 > the rt_intr_create documentation says:
 > 
 > Note:
 >     	The interrupt source associated to the interrupt descriptor remains
 > 	masked upon creation. rt_intr_enable() should be called for the new
 > 	interrupt object to unmask it.
 > 
 > Anyway, I would like to know your opinion about my patch. As I said in
 > my previous mail, althought the irq is enabled, the correspondent
 > handler is not called because the __ipipe_mach_demux_irq function
 > (arch/arm/mach-at91rm9200/gpio.c) asks for the depth field of the struct irq_desc.

I merged this patch in the v2.3.x, v2.4.x branches and trunk. I think
however that it is the I-pipe patch that should be fixed to avoid using
the "depth" member: Xenomai does not disable lazily the interrupt so
the mechanism looking at "depth" in __ipipe_mach_demux_irq could be
removed. However, if we want xenomai to run with older revisions of the
I-pipe patch, we need your patch.

-- 


					    Gilles Chanteperdrix.

