Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F43C3B
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 07:43:34 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A70CAD3F85
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 07:28:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52E5A1C000A;
	Fri,  1 Sep 2023 07:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1693553315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+VpPuNyqSptDPTzBRDlyLdZDRh3PQCgzW11EKXsHZI=;
	b=LGeL9RVkIXuJIwdNMQdKL2jHf/ACc8CsZMY23wKXQY5g2O/ijI9z/xIt3r7RXsk9dWFRT6
	+po6QNLZz9G8/kN7NOHR77LV7REz0v8NUfOK0DyT5Z0aQnaXTVLKhbCt6cjFBcwDuC1dQO
	CNIVY1cg6gGjaV4kUH2V3PgGQXgwS3NvcAbzUPbFM5bFg9RjkBA/0xyqYfNGQ5iJFwYTyt
	/qdnUOm35umFncP8KZ8wM3QqitwBxldFSzPtg4a7ZTGZyHQSO8CsuYBrTVqLJic8BBZvEL
	p+2Uf7i/b0W0uh7Q6QaJqF0qw5zpveYkof6dPi3ETAl/055m93rvKJ5xRWLa1Q==
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
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Date: Fri, 01 Sep 2023 08:35:15 +0200
In-reply-to: <MN2PR11MB4285669E0D22FE1D5B103E2FF2E4A@MN2PR11MB4285.namprd11.prod.outlook.com>
Message-ID: <874jkewdwi.fsf@xenomai.org>
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
>>Sent: Thursday, August 31, 2023 4:57 PM
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
>>>>Sent: Thursday, August 31, 2023 4:06 PM
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
>>>>>>From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>Sent: Thursday, August 31, 2023 3:10 PM
>>>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>Cc: Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev;
>>>>Philippe
>>>>>>Gerum <rpm@xenomai.org>
>>>>>>Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced f=
rom
>>>>>>pinctrl device
>>>>>>
>>>>>>On Thu, 2023-08-31 at 00:45 +0000, Chen, Hongzhan wrote:
>>>>>>>
>>>>>>> > -----Original Message-----
>>>>>>> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>> > Sent: Wednesday, August 30, 2023 9:23 PM
>>>>>>> > To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>> > Cc: Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev;
>>>>>>Philippe
>>>>>>> > Gerum <rpm@xenomai.org>
>>>>>>> > Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloc=
ed
>>>>from
>>>>>>> > pinctrl device
>>>>>>> >
>>>>>>> > On Wed, 2023-08-30 at 07:54 +0000, Chen, Hongzhan wrote:
>>>>>>> > >
>>>>>>> > > > -----Original Message-----
>>>>>>> > > > From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>> > > > Sent: Wednesday, August 30, 2023 3:20 PM
>>>>>>> > > > To: Chen, Hongzhan <hongzhan.chen@intel.com>;
>>>>>>> > xenomai@lists.linux.dev
>>>>>>> > > > Subject: Re: irq storm on sd/mmc card detect gpio interrupt
>>alloced
>>>>>>from
>>>>>>> > > > pinctrl device
>>>>>>> > > >
>>>>>>> > > > On Wed, 2023-08-30 at 03:05 +0000, Chen, Hongzhan wrote:
>>>>>>> > > > > Hi Philippe/Jan
>>>>>>> > > > >
>>>>>>> > > > > We found there is irq storm issue like [1] on sd/mmc card d=
etect
>>>>>>> > interrupt
>>>>>>> > > > alloced from
>>>>>>> > > > > pinctrl device with Xenomai 3.2 Dovetail 5.10.*
>>>>>>> > > > > According to our test,  the patch [2] works for such issue =
in our
>>>>case.
>>>>>>It
>>>>>>> > > > seems that handle_edge_irq
>>>>>>> > > > > never ack the irq to clear the interrupt status for the Lin=
ux gpio
>>>>>>interrupt.
>>>>>>> > > > >
>>>>>>> > > > > I am wondering if there is any side-effect for this patch, =
Please
>>>>>>suggest.
>>>>>>> > > > >
>>>>>>> > > > > Regards
>>>>>>> > > > >
>>>>>>> > > > > Hongzhan Chen
>>>>>>> > > > >
>>>>>>> > > > > [1]:
>>>>>>> > > > > cat /proc/interrupts
>>>>>>> > > > >   14:    2440190          0          0          0  IR-IO-AP=
IC   14    -fasteoi
>>>>>>> > INTC1020:00,
>>>>>>> > > > INTC1020:01, INTC1020:03, INTC1020:04, INTC1020:05
>>>>>>> > > > > 128:    2440190          0          0          0  INTC1020:=
01  112
>>>>0000:00:1a.1
>>>>>>cd
>>>>>>> > > > >
>>>>>>> > > > > [2]:
>>>>>>> > > > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>>>>>> > > > > index 6aca6c036ada..4d08eaf076e9 100644
>>>>>>> > > > > --- a/kernel/irq/chip.c
>>>>>>> > > > > +++ b/kernel/irq/chip.c
>>>>>>> > > > > @@ -869,7 +869,6 @@ void handle_edge_irq(struct irq_desc
>>>>*desc)
>>>>>>> > > > >         kstat_incr_irqs_this_cpu(desc);
>>>>>>> > > > >
>>>>>>> > > > >         /* Start handling the irq */
>>>>>>> > > > > -       if (!irqs_pipelined())
>>>>>>> > > > >                 chip->irq_ack(&desc->irq_data);
>>>>>>> > > > >
>>>>>>> > > > >
>>>>>>> > > >
>>>>>>> > > > That doesn't make much sense. A IRQ storm means that we
>>>>unmasked
>>>>>>the
>>>>>>> > > > IRQ to early or forgot to mask it.
>>>>>>> > > >
>>>>>>> > > > A forgotten ACK would mean the IRQ stalls, so it would never =
be
>>>>fired
>>>>>>> > > > again. No?
>>>>>>> > >
>>>>>>> > > According to the test, it seems forgotten ACK will keep firing
>>interrupt
>>>>>>here
>>>>>>> > like
>>>>>>> > > following comparing:
>>>>>>> >
>>>>>>> > This doesn't make sense (IMHO).
>>>>>>> > Can you provide a callstack from handle_edge_irq() in case
>>>>>>> > on_pipeline_entry() returns false?
>>>>>>> >
>>>>>>> > The IRQ should be ACKed on pipeline entry already, even if
>>>>>>> > handle_edge_irq() is called again (from Linux/Inband context) the=
 IRQ
>>>>>>> > should already be ACKed.
>>>>>>>
>>>>>>> Following stack is dumped after patching my patch. Without patching
>>>>there
>>>>>>is no intel_gpio_irq_ack. It is called in handle_irq_pipelined_finish=
 from
>>>>which
>>>>>>it already called irq_exit_pipeline before sync_current_irq_stage. Th=
at is
>>>>why
>>>>>>on_pipeline_entry returned false in handle_edge_irq
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> [  291.009330] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U
>>>>>>5.10.179-intel-ese-standard-lts-dovetail+ #1
>>>>>>> [  291.009331] Hardware name: Intel Corporation Elkhart Lake
>>Embedded
>>>>>>Platform/ElkhartLake LPDDR4x T3 CRB, BIOS
>>>>>>EHLSFWI1.R00.5204.A01.2305180757 05/18/2023
>>>>>>> [  291.009332] IRQ stage: Linux
>>>>>>> [  291.009332] Call Trace:
>>>>>>> [  291.009332]  <IRQ>
>>>>>>> [  291.009333]  dump_stack+0x7b/0x93
>>>>>>> [  291.009333]  intel_gpio_irq_ack.cold+0x22/0x27
>>>>>>> [  291.009334]  handle_edge_irq+0xe4/0x310
>>>>>>> [  291.009334]  generic_handle_irq+0x4b/0x60
>>>>>>> [  291.009335]  intel_gpio_irq+0x11f/0x1c0
>>>>>>> [  291.009335]  __handle_irq_event_percpu+0x77/0x190
>>>>>>> [  291.009336]  ? handle_level_irq+0x200/0x200
>>>>>>> [  291.009336]  handle_irq_event+0x6c/0x100
>>>>>>> [  291.009337]  handle_fasteoi_irq+0xd8/0x250
>>>>>>> [  291.009337]  asm_call_irq_on_stack+0xf/0x20
>>>>>>> [  291.009338]  </IRQ>
>>>>>>> [  291.009338]  arch_do_IRQ_pipelined+0x11d/0x230
>>>>>>> [  291.009339]  sync_current_irq_stage+0x157/0x1f0
>>>>>>                   ^^
>>>>>>My understanding is that you are not handling an HW IRQ, you are in t=
he
>>>>>>stage where the inband IRQ log is being processed. HW IRQs are already
>>>>>>ACKed at that stage.
>>>>>>
>>>>>>Maybe we have to understand your IRQ chip routing. Is there an IO APIC
>>>>>>involved? handle_fasteoi_irq() would be the first level IRQ entry poi=
nt
>>>>>>which takes care of masking + ack.
>>>>>
>>>>> Yes. IOAPIC is the first level for external devices. handle_fasteoi_i=
rq() is
>>>>registered in io_apic driver. There is second level pinctrl device acti=
ng as
>>>>gpiochip which has irq domains where sd/mmc cd interrupt alloced from ,
>>>>which need to be acked in handle_edge_irq.
>>>>>
>>>>> Regards
>>>>>
>>>>> Hongzhan Chen
>>>>>>
>>>>>>> [  291.009339]  handle_irq_pipelined_finish+0xa2/0x1a0
>>>>>>> [  291.009340]  arch_pipeline_entry+0xdb/0x120
>>>>>>> [  291.009340]  asm_common_interrupt+0x1e/0x40
>>>>>>> [  291.009341] RIP: 0010:cpu_idle_poll.isra.0+0x3a/0x110
>>>>>>> [  291.009342] Code: 00 85 d2 0f 8f 9c 00 00 00 e8 72 33 28 ff 65 4=
8 8b 1c
>>>>25
>>>>>>00 ad 01 00 e8 a4 29 27 ff 48 8b 03 a8 08 74 0b eb 1c f3 90 48 8b 03 =
<a8>
>>08
>>>>75
>>>>>>13 8b 05 cc 6b 01 01 85 c0 75 ed e8 f3 22 2a ff 85 c0 75
>>>>>>> [  291.009342] RSP: 0018:ffffffffa1803ec0 EFLAGS: 00000202
>>>>>>>
>>>>>>> Regards
>>>>>>>
>>>>>>> Hongzhan Chen
>>>>>>> >
>>>>>>> > But: If we use the dovetail sources to build a kernel with pipeli=
ning
>>>>>>> > disabled we have to ACK the IRQ. I assume pipelining is active on=
 your
>>>>>>> > end.
>>>>>>> >
>>>>>>> > As Jan said, I'm searching for a similar problem for some time now
>>that
>>>>>>> > I can only reproduce on VirtualBox VMM. In my case I'm seeing a s=
tall,
>>>>>>> > not a storm. I will give it a try, let's see.
>>>>>>> >
>>>>>>> > >
>>>>>>> > > After patching:
>>>>>>> > > 128:          2          0          0          0  INTC1020:01  =
112      0000:00:1a.1
>>cd
>>>>>>> > >
>>>>>>> > > Before patching:
>>>>>>> > > 128:    2440190          0          0          0  INTC1020:01  =
112
>>0000:00:1a.1
>>>>cd
>>>>>>> > >
>>>>>>> > > Regards
>>>>>>> > >
>>>>>>> > > Hongzhan Chen
>>>>>>> > > >
>>>>>>> > > > Could you please check if we call unmask_irq() with HW IRQs
>>>>enabled?
>>>>>>If
>>>>>>> > > > so, I have an idea what is going on...
>>>>>>> > > >
>>>>>>> > > > Florian
>>>>>>> > >
>>>>>>>
>>>>
>>>>To start with, prior to any further analysis:
>>>>
>>>>diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/in=
tel/pinctrl-
>>>>intel.h
>>>>index 65628423bf639..b7afa763ee079 100644
>>>>--- a/drivers/pinctrl/intel/pinctrl-intel.h
>>>>+++ b/drivers/pinctrl/intel/pinctrl-intel.h
>>>>@@ -222,7 +222,7 @@ struct intel_pinctrl_context {
>>>>  */
>>>> struct intel_pinctrl {
>>>> 	struct device *dev;
>>>>-	raw_spinlock_t lock;
>>>>+	hard_spinlock_t lock;
>>>
>>> I already modified it at first when we found the issue.  But it does no=
t work
>>with it.
>>>
>>> After patching my patch[2] I mentioned, the issue disappear finally.
>>>
>>
>>Ok, but the patch is papering over the real issue I believe.
>
> What kind of real issue it would be? What checkpoint I need to check to f=
ind the real issue out? Please suggest.
> Continuous fired irq is obviously caused by forgotten ack behavior for th=
e issue. The ack is supposed to happen elsewhere=EF=BC=9F
>

Edge ack is supposed to happen in handle_edge_irq() when a pipeline
entry is detected a few lines earlier, your patch would cause a double
ACK in the common case when pipelining, which might cause events to be
lost. As you found out already, the problem is that such flow handler is
called _outside_ of the pipeline entry path, so the ack is not
delivered.

This happens due to this particular interrupt path, which chains two
irqchips, edge on top of fasteoi, combined to the fact that there is no
oob handling of the fasteoi IRQ, so interrupt delivery has to go through
the per-CPU pipeline log first, therefore handling is postponed until
the pipeline is synchronized, _after_ we left the pipeline entry
context. As a result, the fasteoi flow handler does have in_pipeline()
set, but the edge flow handler does not, causing this bug.

handle_irq_pipelined_prepare()
[on_pipeline_entry: true]
arch_handle_irq()
        handle_fasteoi_irq()
                handle_oob_irq()
                        mask_cond_eoi_irq()
handle_irq_pipelined_finish()
[on_pipeline_entry: false]
        synchronize_pipeline_on_irq()
                handle_fasteoi_irq() [!on_pipeline_entry]
                      intel_gpio_irq()
                           handle_edge_irq() <<< failed to ack

This is a bug in the Dovetail logic for stacked IRQ chips. I may have
some cycles spare the next couple of weeks to work on this issue and the
rest of my Dovetail backlog if nobody comes up with a fix earlier.

--=20
Philippe.
