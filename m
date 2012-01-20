From: "Terry Fryar" <terry.fryar@domain.hid>
References: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
	<4F19B046.6090504@domain.hid>
In-Reply-To: <4F19B046.6090504@domain.hid>
Date: Fri, 20 Jan 2012 12:24:51 -0600
Message-ID: <D2F2766145E048789E0063D6F386E760@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm difficulties
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Yeh, omap and gpio.....edge irq from a square wave pulse.... 

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Friday, January 20, 2012 12:20 PM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rtdm difficulties

On 01/20/2012 05:17 PM, Terry Fryar wrote:
> Using xenomai 2.6.0 with 2.6.38 kernel and rtdm.  Been working on a 
> rtdm driver for awhile and all of a sudden I've lost stability.  So, 
> I've backed off all code except for registering an empty realtime irq 
> handler using rtdm_irq_request().  I'm getting kernel oops, and I 
> don't know why?  The irq handler simply returns RTDM_IRQ_HANDLED and 
> that's it.  I've rebuilt my kernel several times, and I'm wondering if 
> I'm missing a .config entry for something related to xenomai??  If I 
> take out the irq handler registration, all is fine.  This driver's 
> been working for about 2 weeks, but all of a sudden I'm getting kernel 
> faults.  Here's what I'm getting from my driver
> (vme_pd_drv):

Are you working on omap ? Is the irq coming from a gpio ? Are you returning
IRQ_HANDLED without acknowledging the interrupt at device level (I am
talking about the device on the other end of the irq line).

-- 
                                                                Gilles.


