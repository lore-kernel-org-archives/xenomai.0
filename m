Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED7567B
	for <xenomai@lists.linux.dev>; Wed, 30 Aug 2023 13:23:38 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230830132329174ae3e62766b78976
        for <xenomai@lists.linux.dev>;
        Wed, 30 Aug 2023 15:23:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iFiPwzHsXs1f85NsNY8TdOdywZFlHHbIiF/3QY7uZXw=;
 b=SZ8Rhw5i0gSZ7Hm0wFOGPgB5APoWyPohl7bktOU9EfApRA9czaMbhcyVoIMeZOzylgxBCR
 6TqZxjlq2zUpbTXLy2jvVk2Lm5vWyqf54OvueXSVsA8kAMCxn6BcTRPhAoH8LvGAsnKshNWq
 kz5y1moSv6liAQjAc9nERIcVtVb7M=;
Message-ID: <463948a9bd09ddf6062f879fa9746b0c70e6a9ab.camel@siemens.com>
Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Date: Wed, 30 Aug 2023 15:23:29 +0200
In-Reply-To: <MN2PR11MB4285D68E3408171C181D9C20F2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: 
	<MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
	 <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
	 <MN2PR11MB4285D68E3408171C181D9C20F2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2023-08-30 at 07:54 +0000, Chen, Hongzhan wrote:
>=20
> > -----Original Message-----
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> > Sent: Wednesday, August 30, 2023 3:20 PM
> > To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@lists.linux.dev
> > Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced fro=
m
> > pinctrl device
> >=20
> > On Wed, 2023-08-30 at 03:05 +0000, Chen, Hongzhan wrote:
> > > Hi Philippe/Jan
> > >=20
> > > We found there is irq storm issue like [1] on sd/mmc card detect inte=
rrupt
> > alloced from
> > > pinctrl device with Xenomai 3.2 Dovetail 5.10.*
> > > According to our test,  the patch [2] works for such issue in our cas=
e. It
> > seems that handle_edge_irq
> > > never ack the irq to clear the interrupt status for the Linux gpio in=
terrupt.
> > >=20
> > > I am wondering if there is any side-effect for this patch, Please sug=
gest.
> > >=20
> > > Regards
> > >=20
> > > Hongzhan Chen
> > >=20
> > > [1]:
> > > cat /proc/interrupts
> > >   14:    2440190          0          0          0  IR-IO-APIC   14   =
 -fasteoi   INTC1020:00,
> > INTC1020:01, INTC1020:03, INTC1020:04, INTC1020:05
> > > 128:    2440190          0          0          0  INTC1020:01  112   =
   0000:00:1a.1 cd
> > >=20
> > > [2]:
> > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > > index 6aca6c036ada..4d08eaf076e9 100644
> > > --- a/kernel/irq/chip.c
> > > +++ b/kernel/irq/chip.c
> > > @@ -869,7 +869,6 @@ void handle_edge_irq(struct irq_desc *desc)
> > >         kstat_incr_irqs_this_cpu(desc);
> > >=20
> > >         /* Start handling the irq */
> > > -       if (!irqs_pipelined())
> > >                 chip->irq_ack(&desc->irq_data);
> > >=20
> > >=20
> >=20
> > That doesn't make much sense. A IRQ storm means that we unmasked the
> > IRQ to early or forgot to mask it.
> >=20
> > A forgotten ACK would mean the IRQ stalls, so it would never be fired
> > again. No?
>=20
> According to the test, it seems forgotten ACK will keep firing interrupt =
here like
> following comparing:

This doesn't make sense (IMHO).
Can you provide a callstack from handle_edge_irq() in case
on_pipeline_entry() returns false?

The IRQ should be ACKed on pipeline entry already, even if
handle_edge_irq() is called again (from Linux/Inband context) the IRQ
should already be ACKed.

But: If we use the dovetail sources to build a kernel with pipelining
disabled we have to ACK the IRQ. I assume pipelining is active on your
end.

As Jan said, I'm searching for a similar problem for some time now that
I can only reproduce on VirtualBox VMM. In my case I'm seeing a stall,
not a storm. I will give it a try, let's see.

>=20
> After patching:
> 128:          2          0          0          0  INTC1020:01  112      0=
000:00:1a.1 cd
>=20
> Before patching:
> 128:    2440190          0          0          0  INTC1020:01  112      0=
000:00:1a.1 cd
>=20
> Regards
>=20
> Hongzhan Chen
> >=20
> > Could you please check if we call unmask_irq() with HW IRQs enabled? If
> > so, I have an idea what is going on...
> >=20
> > Florian
>=20

