Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062B1847
	for <xenomai@lists.linux.dev>; Wed, 30 Aug 2023 07:30:22 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023083007200673882490ff98cd4cf6
        for <xenomai@lists.linux.dev>;
        Wed, 30 Aug 2023 09:20:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=p30AavZ+ohw/Sr+0kMPDEsvXIr+RmGp+K2B+jwQpCVc=;
 b=lXUv2Awt6j7Pls98xoWj/qpqlBpnTADoYSJIQ2+1l59aDnVmDtpyp7JkelVgAbRV5Hh+o8
 XfR5QHUjR8It0xKqsVQH9axF2ShrYitgtMpxQftGmeAJ2wFqkxBn+uh0PZ+wEZ+RZpfQ5nDZ
 mrm48NWMasWXz8jcGxP9fr9zD4XDY=;
Message-ID: <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Wed, 30 Aug 2023 09:20:06 +0200
In-Reply-To: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: 
	<MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
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

On Wed, 2023-08-30 at 03:05 +0000, Chen, Hongzhan wrote:
> Hi Philippe/Jan
>=20
> We found there is irq storm issue like [1] on sd/mmc card detect interrup=
t alloced from=20
> pinctrl device with Xenomai 3.2 Dovetail 5.10.*
> According to our test,  the patch [2] works for such issue in our case. I=
t seems that handle_edge_irq=20
> never ack the irq to clear the interrupt status for the Linux gpio interr=
upt.=20
>=20
> I am wondering if there is any side-effect for this patch, Please suggest=
.
>=20
> Regards
>=20
> Hongzhan Chen
>=20
> [1]:
> cat /proc/interrupts
>   14:    2440190          0          0          0  IR-IO-APIC   14    -fa=
steoi   INTC1020:00, INTC1020:01, INTC1020:03, INTC1020:04, INTC1020:05
> 128:    2440190          0          0          0  INTC1020:01  112      0=
000:00:1a.1 cd
>=20
> [2]:
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 6aca6c036ada..4d08eaf076e9 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -869,7 +869,6 @@ void handle_edge_irq(struct irq_desc *desc)
>         kstat_incr_irqs_this_cpu(desc);
>=20
>         /* Start handling the irq */
> -       if (!irqs_pipelined())
>                 chip->irq_ack(&desc->irq_data);
>=20
>=20

That doesn't make much sense. A IRQ storm means that we unmasked the
IRQ to early or forgot to mask it.

A forgotten ACK would mean the IRQ stalls, so it would never be fired
again. No?

Could you please check if we call unmask_irq() with HW IRQs enabled? If
so, I have an idea what is going on...

Florian

