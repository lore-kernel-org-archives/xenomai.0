Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD41FCC
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 07:09:49 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202308310709416c79f1166a4ef6c19f
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 09:09:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=w14iChf7G0+5AIr/4KOnB0Icq0yg9t+3LV64loO34dU=;
 b=GpBiZkOc5bSTDfRTV08zHs8XCL+LIZLP1zlMKm3JPC9pfk4/Nd0XApxjA6GIVmFlHtz2eR
 u0BvuBLd2AOXnEam7lcZROGNR3NkcBT40pjksDFKBTJ6mQiRAQdRE4DSiNhlkx9DT8T/e/kr
 RujUSul57TnH065YVuC7W6AVR21fE=;
Message-ID: <42d72c52569d30b9ecaf8fd30dd777abd422adf1.camel@siemens.com>
Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Date: Thu, 31 Aug 2023 09:09:41 +0200
In-Reply-To: <MN2PR11MB428547B97385F160CD2E4394F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: 
	<MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
	 <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
	 <MN2PR11MB4285D68E3408171C181D9C20F2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
	 <463948a9bd09ddf6062f879fa9746b0c70e6a9ab.camel@siemens.com>
	 <MN2PR11MB428547B97385F160CD2E4394F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
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

On Thu, 2023-08-31 at 00:45 +0000, Chen, Hongzhan wrote:
>=20
> > -----Original Message-----
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> > Sent: Wednesday, August 30, 2023 9:23 PM
> > To: Chen, Hongzhan <hongzhan.chen@intel.com>
> > Cc: Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev; Phil=
ippe
> > Gerum <rpm@xenomai.org>
> > Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced fro=
m
> > pinctrl device
> >=20
> > On Wed, 2023-08-30 at 07:54 +0000, Chen, Hongzhan wrote:
> > >=20
> > > > -----Original Message-----
> > > > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > Sent: Wednesday, August 30, 2023 3:20 PM
> > > > To: Chen, Hongzhan <hongzhan.chen@intel.com>;
> > xenomai@lists.linux.dev
> > > > Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced=
 from
> > > > pinctrl device
> > > >=20
> > > > On Wed, 2023-08-30 at 03:05 +0000, Chen, Hongzhan wrote:
> > > > > Hi Philippe/Jan
> > > > >=20
> > > > > We found there is irq storm issue like [1] on sd/mmc card detect
> > interrupt
> > > > alloced from
> > > > > pinctrl device with Xenomai 3.2 Dovetail 5.10.*
> > > > > According to our test,  the patch [2] works for such issue in our=
 case. It
> > > > seems that handle_edge_irq
> > > > > never ack the irq to clear the interrupt status for the Linux gpi=
o interrupt.
> > > > >=20
> > > > > I am wondering if there is any side-effect for this patch, Please=
 suggest.
> > > > >=20
> > > > > Regards
> > > > >=20
> > > > > Hongzhan Chen
> > > > >=20
> > > > > [1]:
> > > > > cat /proc/interrupts
> > > > >   14:    2440190          0          0          0  IR-IO-APIC   1=
4    -fasteoi
> > INTC1020:00,
> > > > INTC1020:01, INTC1020:03, INTC1020:04, INTC1020:05
> > > > > 128:    2440190          0          0          0  INTC1020:01  11=
2      0000:00:1a.1 cd
> > > > >=20
> > > > > [2]:
> > > > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > > > > index 6aca6c036ada..4d08eaf076e9 100644
> > > > > --- a/kernel/irq/chip.c
> > > > > +++ b/kernel/irq/chip.c
> > > > > @@ -869,7 +869,6 @@ void handle_edge_irq(struct irq_desc *desc)
> > > > >         kstat_incr_irqs_this_cpu(desc);
> > > > >=20
> > > > >         /* Start handling the irq */
> > > > > -       if (!irqs_pipelined())
> > > > >                 chip->irq_ack(&desc->irq_data);
> > > > >=20
> > > > >=20
> > > >=20
> > > > That doesn't make much sense. A IRQ storm means that we unmasked th=
e
> > > > IRQ to early or forgot to mask it.
> > > >=20
> > > > A forgotten ACK would mean the IRQ stalls, so it would never be fir=
ed
> > > > again. No?
> > >=20
> > > According to the test, it seems forgotten ACK will keep firing interr=
upt here
> > like
> > > following comparing:
> >=20
> > This doesn't make sense (IMHO).
> > Can you provide a callstack from handle_edge_irq() in case
> > on_pipeline_entry() returns false?
> >=20
> > The IRQ should be ACKed on pipeline entry already, even if
> > handle_edge_irq() is called again (from Linux/Inband context) the IRQ
> > should already be ACKed.
>=20
> Following stack is dumped after patching my patch. Without patching there=
 is no intel_gpio_irq_ack. It is called in handle_irq_pipelined_finish from=
 which it already called irq_exit_pipeline before sync_current_irq_stage. T=
hat is why on_pipeline_entry returned false in handle_edge_irq
>=20
>=20
>=20
> [  291.009330] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U            =
5.10.179-intel-ese-standard-lts-dovetail+ #1
> [  291.009331] Hardware name: Intel Corporation Elkhart Lake Embedded Pla=
tform/ElkhartLake LPDDR4x T3 CRB, BIOS EHLSFWI1.R00.5204.A01.2305180757 05/=
18/2023
> [  291.009332] IRQ stage: Linux
> [  291.009332] Call Trace:
> [  291.009332]  <IRQ>
> [  291.009333]  dump_stack+0x7b/0x93
> [  291.009333]  intel_gpio_irq_ack.cold+0x22/0x27
> [  291.009334]  handle_edge_irq+0xe4/0x310
> [  291.009334]  generic_handle_irq+0x4b/0x60
> [  291.009335]  intel_gpio_irq+0x11f/0x1c0
> [  291.009335]  __handle_irq_event_percpu+0x77/0x190
> [  291.009336]  ? handle_level_irq+0x200/0x200
> [  291.009336]  handle_irq_event+0x6c/0x100
> [  291.009337]  handle_fasteoi_irq+0xd8/0x250
> [  291.009337]  asm_call_irq_on_stack+0xf/0x20
> [  291.009338]  </IRQ>
> [  291.009338]  arch_do_IRQ_pipelined+0x11d/0x230
> [  291.009339]  sync_current_irq_stage+0x157/0x1f0
                   ^^
My understanding is that you are not handling an HW IRQ, you are in the
stage where the inband IRQ log is being processed. HW IRQs are already
ACKed at that stage.

Maybe we have to understand your IRQ chip routing. Is there an IO APIC
involved? handle_fasteoi_irq() would be the first level IRQ entry point
which takes care of masking + ack.

> [  291.009339]  handle_irq_pipelined_finish+0xa2/0x1a0
> [  291.009340]  arch_pipeline_entry+0xdb/0x120
> [  291.009340]  asm_common_interrupt+0x1e/0x40
> [  291.009341] RIP: 0010:cpu_idle_poll.isra.0+0x3a/0x110
> [  291.009342] Code: 00 85 d2 0f 8f 9c 00 00 00 e8 72 33 28 ff 65 48 8b 1=
c 25 00 ad 01 00 e8 a4 29 27 ff 48 8b 03 a8 08 74 0b eb 1c f3 90 48 8b 03 <=
a8> 08 75 13 8b 05 cc 6b 01 01 85 c0 75 ed e8 f3 22 2a ff 85 c0 75
> [  291.009342] RSP: 0018:ffffffffa1803ec0 EFLAGS: 00000202
>=20
> Regards
>=20
> Hongzhan Chen
> >=20
> > But: If we use the dovetail sources to build a kernel with pipelining
> > disabled we have to ACK the IRQ. I assume pipelining is active on your
> > end.
> >=20
> > As Jan said, I'm searching for a similar problem for some time now that
> > I can only reproduce on VirtualBox VMM. In my case I'm seeing a stall,
> > not a storm. I will give it a try, let's see.
> >=20
> > >=20
> > > After patching:
> > > 128:          2          0          0          0  INTC1020:01  112   =
   0000:00:1a.1 cd
> > >=20
> > > Before patching:
> > > 128:    2440190          0          0          0  INTC1020:01  112   =
   0000:00:1a.1 cd
> > >=20
> > > Regards
> > >=20
> > > Hongzhan Chen
> > > >=20
> > > > Could you please check if we call unmask_irq() with HW IRQs enabled=
? If
> > > > so, I have an idea what is going on...
> > > >=20
> > > > Florian
> > >=20
>=20

