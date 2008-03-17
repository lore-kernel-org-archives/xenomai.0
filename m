Message-ID: <47DE7FCE.4050604@domain.hid>
Date: Mon, 17 Mar 2008 15:27:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d6c8ef150803170707l7161255an6fa1bf1f3627395f@domain.hid>
In-Reply-To: <d6c8ef150803170707l7161255an6fa1bf1f3627395f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Kernel functions
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Bosko Radivojevic wrote:
> Hi Philippe,
> 
> is the usage of __raw_writel(), dma_map_single() and simillar
> functions "allowed" in native skin?
> 

I'm assuming you mean "real-time mode". __raw_write routines should always be
ok, but dma_map_single() has an arch-dependent implementation. I would be ok to
call it on Blackfin from a real-time (i.e. non plain Linux) context, but this
would break on ARM.

The rule of thumb is that a Linux service may be called from a co-kernel context
only if it does not depend on:
- regular interrupt control ops (local_irq_*)
- regular spin locks (spin_*)

Which leaves very few candidates, actually.

E.g. dma_map_single() on ARM may invoke kmalloc(), which would break all the
assumptions above.

> Kind regards,
> Bosko
> 


-- 
Philippe.

