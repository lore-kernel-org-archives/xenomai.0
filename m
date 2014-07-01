Date: Tue, 1 Jul 2014 16:15:36 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Message-ID: <20140701141536.GN28647@lukather>
References: <1404210421-17081-1-git-send-email-maxime.ripard@free-electrons.com>
 <53B294A7.5010803@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B294A7.5010803@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

Hi Gilles,

On Tue, Jul 01, 2014 at 12:59:51PM +0200, Gilles Chanteperdrix wrote:
> On 07/01/2014 12:27 PM, Maxime Ripard wrote:
> > -
> > -	at91_pic_muter_register();
> >  }
> 
> Obviously, some if (soc_is_foo()) missing here.

Right.

> > +static void __maybe_unused at91_aic5_eoi(struct irq_data *d)
> > +{
> > +	at91_aic_write(AT91_AIC5_EOICR, 0);
> > +}
> 
> You want to make that inline, so that the hold callback ends-up doing
> just two register writes without any function calls, improving interrupt
> latency.
> 
> > +
> >  #ifdef CONFIG_IPIPE
> >  static void at91_aic_hold_irq(struct irq_data *d)
> >  {
> > @@ -258,13 +283,20 @@ static void at91_aic_release_irq(struct irq_data *d)
> >  {
> >  	at91_aic_hard_unmask_irq(d);
> >  }
> > -#endif /* CONFIG_IPIPE */
> >  
> > -static void __maybe_unused at91_aic5_eoi(struct irq_data *d)
> > +static void at91_aic5_hold_irq(struct irq_data *d)
> >  {
> > -	at91_aic_write(AT91_AIC5_EOICR, 0);
> > +	at91_aic5_hard_mask_irq(d);
> > +	at91_aic5_eoi(d);
> >  }
> >  
> > +static void at91_aic5_release_irq(struct irq_data *d)
> > +{
> > +	at91_aic5_hard_unmask_irq(d);
> > +}
> 
> The ->release callback is called with irqs on, so you may want to call
> hard_local_irq_save / hard_local_irq_restore to make it atomic (note
> that the old at91s are also broken by the addition of the call to
> set_backup). Alternatively, you may move the clear_backup/set_bakcup
> calls to the linux mask/unmask routines, so that the register writes
> remain atomic, and you can avoid the save/restore and function calls and
> improve the interrupt latency.

Ok, so, with the changes you mentionned, I can't make the system crash
anymore (or at least, not as easily as it used to be).

But:
  - whenever the program mentionned above calls exit(), it
    stalls. However, ctrl+c makes the program exit properly, and
    everything seems fine otherwise
  - whenever we don't link it against xenomai, it just hangs. I've not
    figured out why yet

With CONFIG_XENOMAI and CONFIG_IPIPE disabled, it works fine.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140701/abc294fd/attachment.sig>
