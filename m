Subject: Re: [PATCH 5/6] genirq: irq_pipeline: export oob status to
 /proc/interrupts
References: <20210722094859.3580166-1-rpm@xenomai.org>
 <20210722094859.3580166-6-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e5e4ad37-149b-f6b3-9c03-192f98c0ae80@siemens.com>
Date: Thu, 22 Jul 2021 11:55:33 +0200
MIME-Version: 1.0
In-Reply-To: <20210722094859.3580166-6-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 22.07.21 11:48, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/irq/proc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 7c5cd42df3b93e7..1428d83d7da8658 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -518,6 +518,9 @@ int show_interrupts(struct seq_file *p, void *v)
>  		seq_printf(p, " %*s", prec, "");
>  #ifdef CONFIG_GENERIC_IRQ_SHOW_LEVEL
>  	seq_printf(p, " %-8s", irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge");
> +#endif
> +#ifdef CONFIG_IRQ_PIPELINE
> +	seq_printf(p, " %-3s", irq_settings_is_oob(desc) ? "oob" : "");
>  #endif
>  	if (desc->name)
>  		seq_printf(p, "-%-8s", desc->name);
> 

Small but valuable - already received a question in this direction.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

