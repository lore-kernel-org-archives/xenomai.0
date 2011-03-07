From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D752659.3070701@domain.hid>
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
	<20110307092604.GA21619@domain.hid>
	<1299515837.2088.47.camel@domain.hid>  <4D752659.3070701@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Mar 2011 22:47:45 +0100
Message-ID: <1299534465.2088.51.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Mon, 2011-03-07 at 19:39 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > +static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
> > +{
> > (...)
> > +	if ((msi_data->feature &  FSL_PIC_IP_MASK) == FSL_PIC_IP_IPIC) {
> > +		if (desc->chip->mask_ack)
> > +			desc->chip->mask_ack(irq);
> > +		else {
> > +			desc->chip->mask(irq);
> > +			desc->chip->ack(irq);
> > +		}
> > +	} else
> > +		desc->chip->eoi(irq);
> > +
> > (...)
> > +
> > +	desc->chip->unmask(irq);
> 
> Do we have to unmask here if we just eoi'ed on entry?
> 

eoi is actually mask+eoi in the mpic case.

-- 
Philippe.



