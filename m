References: <0FA1B488-7D1D-40E2-A4B6-DE9E04852EAD@theobroma-systems.com>
 <1c9bedc6-892d-5624-021d-c47f69a976a8@oss-tech.org>
 <3C3217CA-4594-4706-BD2D-E631EDF2C225@theobroma-systems.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
Date: Tue, 10 Oct 2017 16:08:50 +0200
MIME-Version: 1.0
In-Reply-To: <3C3217CA-4594-4706-BD2D-E631EDF2C225@theobroma-systems.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [I-PIPE] [Patch] IRQ pipelining support for GICv3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@theobroma-systems.com>, Dmitriy Cherkasov <dmitriy@oss-tech.org>
Cc: xenomai@xenomai.org

Hi Christoph,

On 2017-10-10 12:59, Christoph Müllner wrote:
> Hi Dmitry,
> 
> thanks for the hint.
> I've attached a new version of the patch including the I-pipe locking and
> the forwarding calls for locking/unlocking the IRQ in case of masking/unmasking.
> 

Is it possible with your mail client to inline patches? That would
simplify the reviews.

[...]
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 9e14388403b9..e68a0589889c 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -59,6 +59,14 @@ struct gic_chip_data {
>  	struct partition_desc	*ppi_descs[16];
>  };
>  
> +#ifdef CONFIG_IPIPE
> +#define pipeline_lock(__flags)		do { (__flags) = hard_local_irq_save(); } while (0)
> +#define pipeline_unlock(__flags)	hard_local_irq_restore(__flags)
> +#else
> +#define pipeline_lock(__flags)		do { (void)__flags; } while (0)
> +#define pipeline_unlock(__flags)	do { (void)__flags; } while (0)
> +#endif
> +

That are hard_cond_* wrappers that should be usable instead of a custom
solution.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

