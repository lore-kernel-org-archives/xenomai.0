From: "Grau, Gunter" <gunter.grau@philips.com>
Subject: RE: [PATCH] cobalt: ipipe: intr: Fix return value check of
 ipipe_set_irq_affinity
Date: Fri, 20 May 2022 14:32:58 +0000
Message-ID: <AM7P122MB0229C667A4B3A4E15AA57579F2D39@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
References: <d00-62584d80-1a5-12ac4c80@96928095>
 <20220520142913.2081560-1-guntgrau@bbl.ma.philips.com>
 <20220520142913.2081560-2-guntgrau@bbl.ma.philips.com>
In-Reply-To: <20220520142913.2081560-2-guntgrau@bbl.ma.philips.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Sorry, looks like something went wrong with the reply-to.
It belongs to this issue: https://xenomai.org/pipermail/xenomai/2022-April/=
047624.html

Thanks, Gunter


> -----Original Message-----
> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Gunter
> Grau via Xenomai
> Sent: Freitag, 20. Mai 2022 16:29
> To: xenomai@xenomai.org
> Cc: Gunter Grau <guntgrau@bbl.ma.philips.com>
> Subject: [PATCH] cobalt: ipipe: intr: Fix return value check of
> ipipe_set_irq_affinity
>
> Caution: This e-mail originated from outside of Philips, be careful for
> phishing.
>
>
> From: Julian Haller <julian.haller@philips.com>
>
> ipipe_set_irq_affinity directly returns the value of the regular
> irq_set_affinity method. As described in irq.h in the linux kernel, the
> following return values indicate a success:
>
> /*
>  * Return value for chip->irq_set_affinity()
>  *
>  * IRQ_SET_MASK_OK      - OK, core updates irq_common_data.affinity
>  * IRQ_SET_MASK_NOCPY   - OK, chip did update irq_common_data.affinity
>  * IRQ_SET_MASK_OK_DONE - Same as IRQ_SET_MASK_OK for core. Special
> code to
>  *                        support stacked irqchips, which indicates skipp=
ing
>  *                        all descendent irqchips.
>  */
> enum {
>         IRQ_SET_MASK_OK =3D 0,
>         IRQ_SET_MASK_OK_NOCOPY,
>         IRQ_SET_MASK_OK_DONE,
> };
>
> As one example, the GIC in i.MX6 devices returns IRQ_SET_MASK_OK_DONE
> on success. Fix the xintr_attach function by treating all positive return=
 values
> as success.
>
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  kernel/cobalt/ipipe/intr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c inde=
x
> 378c7f07d..cb15597f7 100644
> --- a/kernel/cobalt/ipipe/intr.c
> +++ b/kernel/cobalt/ipipe/intr.c
> @@ -869,7 +869,7 @@ int xnintr_attach(struct xnintr *intr, void *cookie,
> const cpumask_t *cpumask)
>                         return -EINVAL;
>         }
>         ret =3D ipipe_set_irq_affinity(intr->irq, *effective_mask);
> -       if (ret)
> +       if (ret < 0)
>                 return ret;
>  #endif /* CONFIG_SMP */
>
> --
> 2.25.1
>


________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

