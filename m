Sender: Michael Welling <mwelling79@gmail.com>
Date: Thu, 4 Feb 2016 17:56:17 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160204235617.GA30230@deathstar>
References: <20160203145146.GB25464@deathstar>
 <20160203150448.GF32138@hermes.click-hack.org>
 <20160203151802.GC25464@deathstar>
 <20160203153341.GG32138@hermes.click-hack.org>
 <20160204195805.GA31015@deathstar>
 <20160204220729.GD11143@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160204220729.GD11143@hermes.click-hack.org>
Subject: Re: [Xenomai] RT FEC net driver for IMX6Q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Feb 04, 2016 at 11:07:29PM +0100, Gilles Chanteperdrix wrote:
> As indicated by the message: the code at line 158 in
> arch/arm/kernel/ipipe.c
> Which is:
> if (WARN_ON_ONCE(irq_get_chip(irq)->irq_set_affinity == NULL))
> 		return;
> 
> That is, the fact that the irq chip does not have an
> irq_set_affinity callback.
>

I was registering the external PHY interrupt to the internal controller.
This was my fault.

> > 
> > What would cause the ioctl to fail?
> 
> The fact that you are missing this commit:
> https://git.xenomai.org/xenomai-3.git/commit/kernel/drivers/net/drivers/loopback.c?h=next&id=04df10d1fdc32e719b66f02da9117d2783a24bd2
> 
> -- 
> 					    Gilles.
> https://click-hack.org

