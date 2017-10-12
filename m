References: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
 <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Message-ID: <a4c6520f-c201-2006-f530-b921d722c3c1@oss-tech.org>
Date: Thu, 12 Oct 2017 11:02:53 -0700
MIME-Version: 1.0
In-Reply-To: <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
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
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>, jan.kiszka@siemens.com, xenomai@xenomai.org

On 10/12/2017 05:49 AM, Christoph Muellner wrote:
> This patch enables interrupt pipelining for ARM/ARM64 SoC with a
> GICv3 interrupt controller.
> 
> The patch was tested on a Rockchip RK3399 (ARM64 SoC) with
> Linux 4.12.14, I-pipe 4.11-arm64 and Xenomai/Cobalt 3.1 (next).
> xeno-test did not show any errors/fails and latency ran
> 72 hours in a row.
> 
> [v2]: Add I-pipe locking and the forwarding calls for locking/unlocking
> the IRQ in case of masking/unmasking.
> 
> [v3]: Using hard_cond_* instead of #ifdef'd hard_local_*.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---


Thanks Christoph, this is much easier to review.

>   
> +#ifdef CONFIG_IPIPE
> +static void gic_hold_irq(struct irq_data *d)
> +{
> +	struct irq_chip *chip = irq_data_get_irq_chip(d);
> +
> +	gic_poke_irq(d, GICD_ICENABLER);
> +
> +	if (chip->irq_eoi == gic_eoimode1_eoi_irq) {
> +		if (irqd_is_forwarded_to_vcpu(d))
> +			gic_poke_irq(d, GICD_ICACTIVER);
> +		gic_eoimode1_eoi_irq(d);
> +	} else
> +		gic_eoi_irq(d);
> +}
> +
> +static void gic_release_irq(struct irq_data *d)
> +{
> +	gic_poke_irq(d, GICD_ISENABLER);
> +}
> +#endif /* CONFIG_IPIPE */
> +

For these, I'm curious why not just do what you had in your first patch:

+#ifdef CONFIG_IPIPE
+static void gic_hold_irq(struct irq_data *d)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+	chip->irq_mask(d);
+	chip->irq_eoi(d);
+}
+
+static void gic_release_irq(struct irq_data *d)
+{
+	gic_unmask_irq(d);
+}
+#endif /* CONFIG_IPIPE */
+


