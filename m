From: Rajeshkumar <rajesh.ramasamy@industeqsite.com>
Date: Sat, 30 Nov 2013 06:50:53 +0000 (UTC)
Message-ID: <loom.20131130T074521-186@post.gmane.org>
References: <20110302151603.GA14557@riccoc20.at.omicron.at>
 <4D6E61B6.906@xenomai.org> <4D6E8A06.9060508@siemens.com>
 <20110303072147.GA4353@riccoc20.at.omicron.at>
 <1299137548.2072.3.camel@cobalt> <4D6F88D6.4010105@grandegger.com>
 <4D6F89C8.9060005@siemens.com> <1299156880.2072.6.camel@cobalt>
 <4D702802.5080001@web.de> <1299225060.2107.20.camel@cobalt>
 <20110307092604.GA21619@riccoc20.at.omicron.at>
 <1299515837.2088.47.camel@cobalt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Stuck MSI in normal Linux driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Philippe Gerum <rpm <at> xenomai.org> writes:

> 
> On Mon, 2011-03-07 at 10:26 +0100, Richard Cochran wrote:
> > On Fri, Mar 04, 2011 at 08:51:00AM +0100, Philippe Gerum wrote:
> > > I'm not saying this would be impossible to enable MSIs there, I'm just
> > > saying that so far: nobody cared. Terrae incognitae.
> > 
.................
.................
> 
> +#ifdef CONFIG_IPIPE
> +
> +static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
.................
.................
> +#else /* !CONFIG_IPIPE */
> +
>  static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned int cascade_irq;
>  <at>  <at>  -250,6 +307,8  <at>  <at>  unlock:
>  	raw_spin_unlock(&desc->lock);
>  }
> 
> +#endif /* !CONFIG_IPIPE */
> +
>  static int fsl_of_msi_remove(struct platform_device *ofdev)
>  {
>  	struct fsl_msi *msi = ofdev->dev.platform_data;
> 
> > Thanks,
> > 
> > Richard
> > 
> 


Hi,

I am using linux 2.6.30 & ipipe patch 2.6-70. I am also facing the same
problem. Plain linux msi interrupt is coming. But in Xenomai interrupt is
not coming. I checked with '__ipipe_grab_irq' in ipipe.c, the same function
is invoked. But in device driver the registered isr isn't invoked.

Can I do the above patch for above mentioned kernel. Will it work?


Thanks & Regards,
Rajeshkumar




