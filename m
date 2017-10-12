From: =?utf-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@theobroma-systems.com>
Message-Id: <6FABE6F5-B367-4A64-A276-2DC2DF18EBA9@theobroma-systems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 12 Oct 2017 20:16:25 +0200
In-Reply-To: <a4c6520f-c201-2006-f530-b921d722c3c1@oss-tech.org>
References: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
 <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
 <a4c6520f-c201-2006-f530-b921d722c3c1@oss-tech.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: gicv3: [v3] Enable interrupt
	pipelining.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org


> On 12 Oct 2017, at 20:02, Dmitriy Cherkasov <dmitriy@oss-tech.org> wrote:
> 
> On 10/12/2017 05:49 AM, Christoph Muellner wrote:
>> This patch enables interrupt pipelining for ARM/ARM64 SoC with a
>> GICv3 interrupt controller.
>> The patch was tested on a Rockchip RK3399 (ARM64 SoC) with
>> Linux 4.12.14, I-pipe 4.11-arm64 and Xenomai/Cobalt 3.1 (next).
>> xeno-test did not show any errors/fails and latency ran
>> 72 hours in a row.
>> [v2]: Add I-pipe locking and the forwarding calls for locking/unlocking
>> the IRQ in case of masking/unmasking.
>> [v3]: Using hard_cond_* instead of #ifdef'd hard_local_*.
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> ---
> 
> 
> Thanks Christoph, this is much easier to review.
> 
>>  +#ifdef CONFIG_IPIPE
>> +static void gic_hold_irq(struct irq_data *d)
>> +{
>> +	struct irq_chip *chip = irq_data_get_irq_chip(d);
>> +
>> +	gic_poke_irq(d, GICD_ICENABLER);
>> +
>> +	if (chip->irq_eoi == gic_eoimode1_eoi_irq) {
>> +		if (irqd_is_forwarded_to_vcpu(d))
>> +			gic_poke_irq(d, GICD_ICACTIVER);
>> +		gic_eoimode1_eoi_irq(d);
>> +	} else
>> +		gic_eoi_irq(d);
>> +}
>> +
>> +static void gic_release_irq(struct irq_data *d)
>> +{
>> +	gic_poke_irq(d, GICD_ISENABLER);
>> +}
>> +#endif /* CONFIG_IPIPE */
>> +
> 
> For these, I'm curious why not just do what you had in your first patch:
> 
> +#ifdef CONFIG_IPIPE
> +static void gic_hold_irq(struct irq_data *d)
> +{
> +	struct irq_chip *chip = irq_data_get_irq_chip(d);
> +	chip->irq_mask(d);
> +	chip->irq_eoi(d);
> +}
> +
> +static void gic_release_irq(struct irq_data *d)
> +{
> +	gic_unmask_irq(d);
> +}
> +#endif /* CONFIG_IPIPE */
> +

That was my first attempt, but that ends up in a hang during bootup.
I suspect that the .irq_hold() callback must not call ipipe_lock_irq().
And since I added that call to gic_mask_irq(), I cannot call .irq_mask().

Note, that this code equals also the GICv2 implementation in drivers/irqchip/irq-gic.c
(where I got the idea for the pipeline_lock() macros in [v2] from).

Thanks,
Christoph


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP
URL: <http://xenomai.org/pipermail/xenomai/attachments/20171012/1c0ca94a/attachment.sig>
