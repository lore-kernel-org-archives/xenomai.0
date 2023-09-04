Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B047E
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 09:29:26 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECEFE240007;
	Mon,  4 Sep 2023 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1693819758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfM5cuF/ObgA8rWGSyyXY8RRsMYxdekJ1fLU2oZ8I4M=;
	b=Z6p9LsPK1/6s6qpyMQZJdesYFiQuSF0y0ZTZNnyrEtUeIAVyjVxinPclZ3a9K0p3QFHG4I
	56XbvDod8TVuJUdBrpqCGhoHLrsFjQb6V/b/24gsUS86ixnrqPB3zJNVWHRWGVOlCNp+Ti
	GRZayQFedQNP6eYPD9UPc3nJJBBZSD3YzJ4lGYG2TfJ37iyC3qZsOEwAjD0Mr2MKGeNj6O
	2iZMr+7gnlejyfhcSB0EpxettuxkmEr24wm537U3u2sGisbjlR/MtnrBsJy3j+QB2IRWLn
	5DQQgpmJlwXyTs3RaUt7zkxo2C0I6vjdfP7Sxa+CK0Awn0OarDXS85HJZljZiA==
References: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
 <MN2PR11MB4285D68E3408171C181D9C20F2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <463948a9bd09ddf6062f879fa9746b0c70e6a9ab.camel@siemens.com>
 <MN2PR11MB428547B97385F160CD2E4394F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <42d72c52569d30b9ecaf8fd30dd777abd422adf1.camel@siemens.com>
 <MN2PR11MB4285133F95080135AD983AC4F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <874jkffxe0.fsf@xenomai.org>
 <MN2PR11MB42858E54D7324967AE6D1FC2F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <87zg27egin.fsf@xenomai.org>
 <MN2PR11MB4285669E0D22FE1D5B103E2FF2E4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <874jkewdwi.fsf@xenomai.org>
 <BY5PR11MB42769E5D589385FDF64A7C7EF2E9A@BY5PR11MB4276.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Date: Mon, 04 Sep 2023 11:21:35 +0200
In-reply-to: <BY5PR11MB42769E5D589385FDF64A7C7EF2E9A@BY5PR11MB4276.namprd11.prod.outlook.com>
Message-ID: <87jzt6p9qu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org


"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:

>>-----Original Message-----
>>From: Philippe Gerum <rpm@xenomai.org>
>>Sent: Friday, September 1, 2023 2:35 PM
>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>Cc: Bezdeka, Florian <florian.bezdeka@siemens.com>; Kiszka, Jan
>><jan.kiszka@siemens.com>; xenomai@lists.linux.dev
>>Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
>>pinctrl device
>>
>>
>>"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:
>>
>>>>-----Original Message-----
>>>>From: Philippe Gerum <rpm@xenomai.org>
>>>>Sent: Thursday, August 31, 2023 4:57 PM
>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>Cc: Bezdeka, Florian <florian.bezdeka@siemens.com>; Kiszka, Jan
>>>><jan.kiszka@siemens.com>; xenomai@lists.linux.dev
>>>>Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
>>>>pinctrl device
>>>>
>>>>
>>>>"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:
>>>>
>>>>>>-----Original Message-----
>>>>>>From: Philippe Gerum <rpm@xenomai.org>
>>>>>>Sent: Thursday, August 31, 2023 4:06 PM
>>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>Cc: Bezdeka, Florian <florian.bezdeka@siemens.com>; Kiszka, Jan
>>>>>><jan.kiszka@siemens.com>; xenomai@lists.linux.dev
>>>>>>Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced f=
rom
>>>>>>pinctrl device
>>>>>>
>>>>>>
>>>>>>"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:
>>>>>>
>>>>>>>>-----Original Message-----
>>>>>>>>From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>>Sent: Thursday, August 31, 2023 3:10 PM
>>>>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>>Cc: Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev;
>>>>>>Philippe
>>>>>>>>Gerum <rpm@xenomai.org>
>>>>>>>>Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced
>>from
>>>>>>>>pinctrl device
>>>>>>>>
>>>>>>>>On Thu, 2023-08-31 at 00:45 +0000, Chen, Hongzhan wrote:
>>>>>>>>>
>>>>>>>>> > -----Original Message-----
>>>>>>>>> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>>> > Sent: Wednesday, August 30, 2023 9:23 PM
>>>>>>>>> > To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>>> > Cc: Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.d=
ev;
>>>>>>>>Philippe
>>>>>>>>> > Gerum <rpm@xenomai.org>
>>>>>>>>> > Subject: Re: irq storm on sd/mmc card detect gpio interrupt all=
oced
>>>>>>from
>>>>>>>>> > pinctrl device
>>>>>>>>> >
>>>>>>>>> > On Wed, 2023-08-30 at 07:54 +0000, Chen, Hongzhan wrote:
>>>>>>>>> > >
>>>>>>>>> > > > -----Original Message-----
>>>>>>>>> > > > From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>>> > > > Sent: Wednesday, August 30, 2023 3:20 PM
>>>>>>>>> > > > To: Chen, Hongzhan <hongzhan.chen@intel.com>;
>>>>>>>>> > xenomai@lists.linux.dev
>>>>>>>>> > > > Subject: Re: irq storm on sd/mmc card detect gpio interrupt
>>>>alloced
>>>>>>>>from
>>>>>>>>> > > > pinctrl device
>>>>>>>>> > > >
>>>>>>>>> > > > On Wed, 2023-08-30 at 03:05 +0000, Chen, Hongzhan wrote:
>>>>>>>>> > > > > Hi Philippe/Jan
>>>>>>>>> > > > >
>>>>>>>>> > > > > We found there is irq storm issue like [1] on sd/mmc card
>>detect
>>>>>>>>> > interrupt
>>>>>>>>> > > > alloced from
>>>>>>>>> > > > > pinctrl device with Xenomai 3.2 Dovetail 5.10.*
>>>>>>>>> > > > > According to our test,  the patch [2] works for such issu=
e in
>>our
>>>>>>case.
>>>>>>>>It
>>>>>>>>> > > > seems that handle_edge_irq
>>>>>>>>> > > > > never ack the irq to clear the interrupt status for the L=
inux
>>gpio
>>>>>>>>interrupt.
>>>>>>>>> > > > >
>>>>>>>>> > > > > I am wondering if there is any side-effect for this patch=
, Please
>>>>>>>>suggest.
>>>>>>>>> > > > >
>>>>>>>>> > > > > Regards
>>>>>>>>> > > > >
>>>>>>>>> > > > > Hongzhan Chen
>>>>>>>>> > > > >
>>>>>>>>> > > > > [1]:
>>>>>>>>> > > > > cat /proc/interrupts
>>>>>>>>> > > > >   14:    2440190          0          0          0  IR-IO-=
APIC   14    -fasteoi
>>>>>>>>> > INTC1020:00,
>>>>>>>>> > > > INTC1020:01, INTC1020:03, INTC1020:04, INTC1020:05
>>>>>>>>> > > > > 128:    2440190          0          0          0  INTC102=
0:01  112
>>>>>>0000:00:1a.1
>>>>>>>>cd
>>>>>>>>> > > > >
>>>>>>>>> > > > > [2]:
>>>>>>>>> > > > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>>>>>>>> > > > > index 6aca6c036ada..4d08eaf076e9 100644
>>>>>>>>> > > > > --- a/kernel/irq/chip.c
>>>>>>>>> > > > > +++ b/kernel/irq/chip.c
>>>>>>>>> > > > > @@ -869,7 +869,6 @@ void handle_edge_irq(struct irq_desc
>>>>>>*desc)
>>>>>>>>> > > > >         kstat_incr_irqs_this_cpu(desc);
>>>>>>>>> > > > >
>>>>>>>>> > > > >         /* Start handling the irq */
>>>>>>>>> > > > > -       if (!irqs_pipelined())
>>>>>>>>> > > > >                 chip->irq_ack(&desc->irq_data);
>>>>>>>>> > > > >
>>>>>>>>> > > > >
>>>>>>>>> > > >
>>>>>>>>> > > > That doesn't make much sense. A IRQ storm means that we
>>>>>>unmasked
>>>>>>>>the
>>>>>>>>> > > > IRQ to early or forgot to mask it.
>>>>>>>>> > > >
>>>>>>>>> > > > A forgotten ACK would mean the IRQ stalls, so it would neve=
r be
>>>>>>fired
>>>>>>>>> > > > again. No?
>>>>>>>>> > >
>>>>>>>>> > > According to the test, it seems forgotten ACK will keep firing
>>>>interrupt
>>>>>>>>here
>>>>>>>>> > like
>>>>>>>>> > > following comparing:
>>>>>>>>> >
>>>>>>>>> > This doesn't make sense (IMHO).
>>>>>>>>> > Can you provide a callstack from handle_edge_irq() in case
>>>>>>>>> > on_pipeline_entry() returns false?
>>>>>>>>> >
>>>>>>>>> > The IRQ should be ACKed on pipeline entry already, even if
>>>>>>>>> > handle_edge_irq() is called again (from Linux/Inband context) t=
he
>>IRQ
>>>>>>>>> > should already be ACKed.
>>>>>>>>>
>>>>>>>>> Following stack is dumped after patching my patch. Without patchi=
ng
>>>>>>there
>>>>>>>>is no intel_gpio_irq_ack. It is called in handle_irq_pipelined_fini=
sh from
>>>>>>which
>>>>>>>>it already called irq_exit_pipeline before sync_current_irq_stage. =
That
>>is
>>>>>>why
>>>>>>>>on_pipeline_entry returned false in handle_edge_irq
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> [  291.009330] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U
>>>>>>>>5.10.179-intel-ese-standard-lts-dovetail+ #1
>>>>>>>>> [  291.009331] Hardware name: Intel Corporation Elkhart Lake
>>>>Embedded
>>>>>>>>Platform/ElkhartLake LPDDR4x T3 CRB, BIOS
>>>>>>>>EHLSFWI1.R00.5204.A01.2305180757 05/18/2023
>>>>>>>>> [  291.009332] IRQ stage: Linux
>>>>>>>>> [  291.009332] Call Trace:
>>>>>>>>> [  291.009332]  <IRQ>
>>>>>>>>> [  291.009333]  dump_stack+0x7b/0x93
>>>>>>>>> [  291.009333]  intel_gpio_irq_ack.cold+0x22/0x27
>>>>>>>>> [  291.009334]  handle_edge_irq+0xe4/0x310
>>>>>>>>> [  291.009334]  generic_handle_irq+0x4b/0x60
>>>>>>>>> [  291.009335]  intel_gpio_irq+0x11f/0x1c0
>>>>>>>>> [  291.009335]  __handle_irq_event_percpu+0x77/0x190
>>>>>>>>> [  291.009336]  ? handle_level_irq+0x200/0x200
>>>>>>>>> [  291.009336]  handle_irq_event+0x6c/0x100
>>>>>>>>> [  291.009337]  handle_fasteoi_irq+0xd8/0x250
>>>>>>>>> [  291.009337]  asm_call_irq_on_stack+0xf/0x20
>>>>>>>>> [  291.009338]  </IRQ>
>>>>>>>>> [  291.009338]  arch_do_IRQ_pipelined+0x11d/0x230
>>>>>>>>> [  291.009339]  sync_current_irq_stage+0x157/0x1f0
>>>>>>>>                   ^^
>>>>>>>>My understanding is that you are not handling an HW IRQ, you are in
>>the
>>>>>>>>stage where the inband IRQ log is being processed. HW IRQs are
>>already
>>>>>>>>ACKed at that stage.
>>>>>>>>
>>>>>>>>Maybe we have to understand your IRQ chip routing. Is there an IO
>>APIC
>>>>>>>>involved? handle_fasteoi_irq() would be the first level IRQ entry p=
oint
>>>>>>>>which takes care of masking + ack.
>>>>>>>
>>>>>>> Yes. IOAPIC is the first level for external devices. handle_fasteoi=
_irq() is
>>>>>>registered in io_apic driver. There is second level pinctrl device ac=
ting as
>>>>>>gpiochip which has irq domains where sd/mmc cd interrupt alloced from=
 ,
>>>>>>which need to be acked in handle_edge_irq.
>>>>>>>
>>>>>>> Regards
>>>>>>>
>>>>>>> Hongzhan Chen
>>>>>>>>
>>>>>>>>> [  291.009339]  handle_irq_pipelined_finish+0xa2/0x1a0
>>>>>>>>> [  291.009340]  arch_pipeline_entry+0xdb/0x120
>>>>>>>>> [  291.009340]  asm_common_interrupt+0x1e/0x40
>>>>>>>>> [  291.009341] RIP: 0010:cpu_idle_poll.isra.0+0x3a/0x110
>>>>>>>>> [  291.009342] Code: 00 85 d2 0f 8f 9c 00 00 00 e8 72 33 28 ff 65=
 48 8b
>>1c
>>>>>>25
>>>>>>>>00 ad 01 00 e8 a4 29 27 ff 48 8b 03 a8 08 74 0b eb 1c f3 90 48 8b 0=
3 <a8>
>>>>08
>>>>>>75
>>>>>>>>13 8b 05 cc 6b 01 01 85 c0 75 ed e8 f3 22 2a ff 85 c0 75
>>>>>>>>> [  291.009342] RSP: 0018:ffffffffa1803ec0 EFLAGS: 00000202
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>>
>>>>>>>>> Hongzhan Chen
>>>>>>>>> >
>>>>>>>>> > But: If we use the dovetail sources to build a kernel with pipe=
lining
>>>>>>>>> > disabled we have to ACK the IRQ. I assume pipelining is active =
on
>>your
>>>>>>>>> > end.
>>>>>>>>> >
>>>>>>>>> > As Jan said, I'm searching for a similar problem for some time =
now
>>>>that
>>>>>>>>> > I can only reproduce on VirtualBox VMM. In my case I'm seeing a
>>stall,
>>>>>>>>> > not a storm. I will give it a try, let's see.
>>>>>>>>> >
>>>>>>>>> > >
>>>>>>>>> > > After patching:
>>>>>>>>> > > 128:          2          0          0          0  INTC1020:01=
  112      0000:00:1a.1
>>>>cd
>>>>>>>>> > >
>>>>>>>>> > > Before patching:
>>>>>>>>> > > 128:    2440190          0          0          0  INTC1020:01=
  112
>>>>0000:00:1a.1
>>>>>>cd
>>>>>>>>> > >
>>>>>>>>> > > Regards
>>>>>>>>> > >
>>>>>>>>> > > Hongzhan Chen
>>>>>>>>> > > >
>>>>>>>>> > > > Could you please check if we call unmask_irq() with HW IRQs
>>>>>>enabled?
>>>>>>>>If
>>>>>>>>> > > > so, I have an idea what is going on...
>>>>>>>>> > > >
>>>>>>>>> > > > Florian
>>>>>>>>> > >
>>>>>>>>>
>>>>>>
>>>>>>To start with, prior to any further analysis:
>>>>>>
>>>>>>diff --git a/drivers/pinctrl/intel/pinctrl-intel.h
>>b/drivers/pinctrl/intel/pinctrl-
>>>>>>intel.h
>>>>>>index 65628423bf639..b7afa763ee079 100644
>>>>>>--- a/drivers/pinctrl/intel/pinctrl-intel.h
>>>>>>+++ b/drivers/pinctrl/intel/pinctrl-intel.h
>>>>>>@@ -222,7 +222,7 @@ struct intel_pinctrl_context {
>>>>>>  */
>>>>>> struct intel_pinctrl {
>>>>>> 	struct device *dev;
>>>>>>-	raw_spinlock_t lock;
>>>>>>+	hard_spinlock_t lock;
>>>>>
>>>>> I already modified it at first when we found the issue.  But it does =
not
>>work
>>>>with it.
>>>>>
>>>>> After patching my patch[2] I mentioned, the issue disappear finally.
>>>>>
>>>>
>>>>Ok, but the patch is papering over the real issue I believe.
>>>
>>> What kind of real issue it would be? What checkpoint I need to check to=
 find
>>the real issue out? Please suggest.
>>> Continuous fired irq is obviously caused by forgotten ack behavior for =
the
>>issue. The ack is supposed to happen elsewhere=EF=BC=9F
>>>
>>
>>Edge ack is supposed to happen in handle_edge_irq() when a pipeline
>>entry is detected a few lines earlier, your patch would cause a double
>
> Following patch is OK for you? It should avoid double ACK.  Because on_pi=
peline_entry after  ack
> it set IRQS_EDGE. so we can ack here when find that  IRQS_EDGE is not set=
 to avoid double ack.
>
> index 6aca6c036ada..d06cf4a79f2a 10064
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -868,8 +868,10 @@ void handle_edge_irq(struct irq_desc *desc)
>         if (on_pipeline_entry()) {
>                 chip->irq_ack(&desc->irq_data);
>                 desc->istate |=3D IRQS_EDGE;
>                 handle_oob_irq(desc);
>                 goto out_unlock;
>         }
>
>         kstat_incr_irqs_this_cpu(desc);
>
> -       /* Start handling the irq */
> -       if (!irqs_pipelined())
> +       /* Start handling the irq
> +        * Avoid duplicating ack when IRQS_EDGE set
> +        */
> +       if (!(desc->istate & IRQS_EDGE))
>                 chip->irq_ack(&desc->irq_data);

This is getting closer but not yet correct. The idea of tracking the
pending acknowledge using a per-event bit from the internal descriptor
state looks right, we need something along these lines.

However you may not reuse IRQS_EDGE for this, first because the latter
deals with IRQ resend, so the semantics are different, but also because
this bit is cleared early when leaving the flow handler upon its initial
invocation for an IRQ. This won't work because we are interested by the
second invocation of such handler for the same IRQ event, the one which
replays the event from the in-band stage. There are some gory details
about the interrupt flow at [1] which may help understanding.

[1] https://evlproject.org/dovetail/porting/irqflow/

--=20
Philippe.
