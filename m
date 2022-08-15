Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B77E
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 09:56:07 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 50E2AFF802;
	Mon, 15 Aug 2022 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1660557358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOJ02icezSXtOr+aomzZeWqXmjJ77g2sFdrjrAurT9g=;
	b=J69v/aMo8PxG1HhzgON4NEAvT2wh11QFSnKQW8bzYPlv26AIGEXj6eaaLup13wnrMt6wnE
	raBd+0uTbP0nr6IQNGVrjaK+mesSEAoq4y+lphXOJzScoHVs+5Es6Qm8DcuYwVcnF77VYz
	AzWZtPiGyUvUrBOZoONhXnKdIUcBN/XEqvXl+JDPTHSrIWk5TEz5RNlAV0II0guyyJxeNt
	sLLaHerisCuXUBpXxgUO+2xQQYPncn40T2aIMKX4LsgLfNDeB2D+uf8hqZwOl1ntDhmI/p
	d5LqF/eW4zXQgHeljw6ihB69G5PSUlN1LCbT2tw/rrqwqbPgkX+9r2klABrGzQ==
References: <94f8dc12-d019-4736-2423-bfacc6b3b0b2@siemens.com>
 <20220217084830.712756-1-gunter.grau@philips.com>
 <dddc8d33-0379-eb0c-f994-264a20bef4e6@siemens.com>
 <CALLqZ8QTq+g7pLx_L68K76ez1XJum8-OkjbC9RJP7tW-VaxdEA@mail.gmail.com>
 <e24f9de7-7170-5c5e-cb8f-07c778b67c21@siemens.com>
 <CALLqZ8THxAWDYMLOCUTKoGjzNt4V-PZtz_hTf2++FLF1QeCytg@mail.gmail.com>
 <AM7P122MB022912B3CD5B49D168974AD7F2649@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <86ca964e-62d8-2bc9-80f9-97097f1dedc7@siemens.com>
 <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: "Grau, Gunter" <gunter.grau@philips.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH] ipipe: Fix ipipe level irq end
Date: Mon, 15 Aug 2022 11:34:50 +0200
In-reply-to: <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Message-ID: <874jydkez7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


"Grau, Gunter" <gunter.grau@philips.com> writes:

> Hi,
>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Montag, 15. August 2022 08:19
>> To: Grau, Gunter <gunter.grau@philips.com>; xenomai@lists.linux.dev
>> Subject: Re: [PATCH] ipipe: Fix ipipe level irq end
>>
>> Caution: This e-mail originated from outside of Philips, be careful for
>> phishing.
>>
>>
>> On 11.08.22 16:05, Grau, Gunter wrote:
>> >
>> > Hi,
>> >
>> > Unfortunately I have to come back to this.
>> >
>> > On Thu, Feb 17, 2022 at 10:12 AM Jan Kiszka
>> <mailto:jan.kiszka@siemens.com> wrote:
>> > On 17.02.22 15:11, Greg Gallagher wrote:
>> >>
>> >>
>> >> On Thu, Feb 17, 2022 at 4:15 AM Jan Kiszka
>> >> <mailto:jan.kiszka@siemens.com
>> <mailto:mailto:jan.kiszka@siemens.com>> wrote:
>> >>
>> >>     On 17.02.22 09:48, Gunter Grau via Xenomai wrote:
>> >>     > The following commit in the vanilla kernel introduced
>> >>     > a check for the cached interrupt mask flag in mask_irq():
>> >>     >
>> >>     > bf22ff45bed6 ("genirq: Avoid unnecessary low level irq function
>> >>     calls")
>> >>     >
>> >>     > This means if the flag is not serviced correctly
>> >>     > the real bit in the hardware interrupt controller may not be
>> >>     > cleared or set.
>> >>     > The __ipipe_end_level_irq() function does not follow this rule.
>> >>     > It unmasks the bit in the hardware without setting the cached f=
lags
>> >>     > accordingly. So after the first level interrupt is finished the
>> >>     > mask cache has a wrong state. If now the next interrupt fires,
>> >>     > the mask_irq() function will not really mask the interrupt in
>> >>     > the hardware which causes a interrupt storm after reenabeling
>> >>     > the hard irqs.
>> >>     > The fix now also updates the shadow flag correctly.
>> >>     > ---
>> >>     >  kernel/irq/chip.c | 1 +
>> >>     >  1 file changed, 1 insertion(+)
>> >>     >
>> >>     > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> >>     > index 7c03e2931189..ff9a8b3f33db 100644
>> >>     > --- a/kernel/irq/chip.c
>> >>     > +++ b/kernel/irq/chip.c
>> >>     > @@ -988,6 +988,7 @@ void __ipipe_ack_level_irq(struct irq_desc
>> *desc)
>> >>     >  void __ipipe_end_level_irq(struct irq_desc *desc)
>> >>     >  {
>> >>     >         desc->irq_data.chip->irq_unmask(&desc->irq_data);
>> >>     > +       irq_state_clr_masked(desc);
>> >>     >  }
>> >>     >
>> >>     >  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
>> >>     > --
>> >>     > 2.25.1
>> >>     >
>> >
>> > We discovered some situations (with iio drivers) where this fix seem n=
ot to
>> work.
>> > Obviously in the moment where the irq is unmasked, the new interrupt
>> seems to fire again and the irq_ack() code of the new interrupt runs bef=
ore
>> the irq_stats_clr_masked() is called.
>> > When I wrote the patch I thought the irqs are disabled at this moment.
>> Looks like this is not the case. At least when I change the order to:
>> >
>> > irq_state_clr_masked(desc);
>> > desc->irq_data.chip->irq_unmask(&desc->irq_data);
>> >
>> > My use case works again.
>> > Now I am unsure if the above reordering is the correct solution or may=
be
>> just calling unmask_irq(); which was the first proposal is better?
>> > We dropped unmask_irq() proposal because it does additionally some
>> locking, but maybe this is needed. I am unsure.
>> >
>> > Do you have some advice?
>>
>> I didn't wrap my head fully around this again yet, but if you can't ensu=
re a
>> correct, race-free behavior by ordering, you need locking.
>> Maybe have a look again how dovetail works in this context as it should =
have
>> logically the same thing to do.
>>
>
> It looks like in dovetail the masked bit in the description is also not c=
leared (missing irq_state_clr_masked(desc)).
> This might work because the corresponding mask function here seems also s=
ourced from the dovetail patch and is not checking the bit before masking t=
he irq.
> No guaranties here, I am not firm with dovetail and that=E2=80=99s what it
> looks like when checking handle_percpu_irq().

Dovetail does not work the I-pipe did, __ipipe_end_level_irq() is now
handled internally. The only way to re-enable interrupts in this path
would be to reschedule a real-time task, which cannot happen until
irq_exit_pipeline() is called when unwinding the interrupt frame, at
which point the companion core may reschedule, never before. So unless
the core enables back hard IRQs in the handler, which would be 100%
broken behavior, there is no issue.

IOW, both the interrupt flow and event handlers run with (hard) IRQs
masked in the CPU all the way, preventing any interrupt storm, whether
the guard bit is set prior to or after unmasking. Also, the vanilla
[un]mask_irq() logic is kept, testing and setting irqd_irq_masked() as
appropriate, i.e. when using the state cache is applicable.

handle_percpu_irq() is a special case, the vanilla code does not have to
use a state cache because you do not mask per-CPU irqs, you might
disable them entirely if not handled.

This is tricky stuff, so a bug can never be excluded, but I don't think
the I-pipe scenario applies to Dovetail.

--=20
Philippe.
