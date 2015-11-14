Date: Sat, 14 Nov 2015 19:26:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151114182603.GS1820@hermes.click-hack.org>
References: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
 <20151114123953.GN1820@hermes.click-hack.org>
 <BLU437-SMTP2BEF9B6C71BB45D72DA0EF0100@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP2BEF9B6C71BB45D72DA0EF0100@phx.gbl>
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Sat, Nov 14, 2015 at 08:11:52AM -0800, Mathieu Rondonneau wrote:
> On 15-11-14 04:39 AM, Gilles Chanteperdrix wrote:
> > On Fri, Nov 13, 2015 at 09:31:23PM -0800, Mathieu Rondonneau wrote:
> >>  #ifdef CONFIG_OF
> >> @@ -333,6 +349,10 @@ static struct irq_chip armctrl_chip = {
> >>  	.irq_mask = armctrl_mask_irq,
> >>  	.irq_unmask = armctrl_unmask_irq,
> >>  	.irq_set_wake = armctrl_set_wake,
> >> +#ifdef CONFIG_IPIPE
> >> +	.irq_hold = armctrl_mask_irq,
> >> +	.irq_release = armctrl_unmask_irq,
> >> +#endif
> > 
> > Also, as explained during your lengthy discussion, you do not need
> > to define irq_hold and irq_release here.
> > 
> Kernel does not boot if I remove them (also explained in our lengthy
> discussion). I think that's the part we did not understood each other.
> I am happy to remove them if there is another workaround to get the
> kernel booting.

I can not find the mail where you explain what happens when you
remove it. Could you explain it again, please?

Regards.

-- 
					    Gilles.
https://click-hack.org

