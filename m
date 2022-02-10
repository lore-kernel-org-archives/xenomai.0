MIME-Version: 1.0
References: <20220210153313.2229625-1-gunter.grau@philips.com>
 <20220210153313.2229625-2-gunter.grau@philips.com>
In-Reply-To: <20220210153313.2229625-2-gunter.grau@philips.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 10 Feb 2022 10:37:43 -0500
Message-ID: <CALLqZ8S5fC5=FzScBqSobETZGtxUP6-=FCM=HxyTQ8Lfx-YyuQ@mail.gmail.com>
Subject: Re: [PATCH] ipipe: Fix ipipe level irq end
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gunter Grau <gunter.grau@philips.com>
Cc: xenomai@xenomai.org

On Thu, Feb 10, 2022 at 10:35 AM Gunter Grau via Xenomai <
xenomai@xenomai.org> wrote:

> The following commit in the vanilla kernel introduced
> a check for the cached interrupt mask flag in mask_irq():
>
> bf22ff45bed6 ("genirq: Avoid unnecessary low level irq function calls")
>
> This means if the flag is not serviced correctly
> the real bit in the hardware interrupt controller may not be
> cleared or set.
> The __ipipe_end_level_irq() function does not follow this rule.
> It unmasks the bit in the hardware without setting the cached flags
> accordingly. So after the first level interrupt is finished the
> mask cache has a wrong state. If now the next interrupt fires,
> the mask_irq() function will not really mask the interrupt in
> the hardware which causes a interrupt storm after reenabeling
> the hard irqs.
> The fix now calls unmask_irq() which is handling the cached flags
> correctly.
>
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  kernel/irq/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 7c03e2931189..79a09b92a1b1 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -987,7 +987,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>
>  void __ipipe_end_level_irq(struct irq_desc *desc)
>  {
> -       desc->irq_data.chip->irq_unmask(&desc->irq_data);
> +       unmask_irq(desc);
>  }
>
>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
> --
> 2.25.1
>
>
> ________________________________
> The information contained in this message may be confidential and legally
> protected under applicable law. The message is intended solely for the
> addressee(s). If you are not the intended recipient, you are hereby
> notified that any use, forwarding, dissemination, or reproduction of this
> message is strictly prohibited and may be unlawful. If you are not the
> intended recipient, please contact the sender by return e-mail and destro=
y
> all copies of the original message.
>

I=E2=80=99ll add this to the arm/arm64 ipipe kernels this weekend.

Thanks

Greg

>
>
