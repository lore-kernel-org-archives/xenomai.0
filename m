Message-ID: <446333C7.1070406@domain.hid>
Date: Thu, 11 May 2006 14:53:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
References: <17502.13773.674199.219762@domain.hid>	<17503.16072.557355.759746@domain.hid>	<445F4CC5.20301@domain.hid>	<17504.54807.68153.142769@domain.hid>	<44611320.8040909@domain.hid>
	<17505.58508.240692.324238@domain.hid>
In-Reply-To: <17505.58508.240692.324238@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> The attached version of the patch do that.

Fine with me, please merge as you see fit. Details follow:

> +++ include/nucleus/ppd.h	2006-05-10 14:27:11.000000000 +0200
> @@ -0,0 +1,26 @@
> +#ifndef PPD_H
> +#define PPD_H
> +

Given that ppds are shadow-specific, I would move ppd.h's contents to 
shadow.h directly.

> +static unsigned
> +xnppd_lookup_inner(xnqueue_t **pq, xnppd_holder_t **pholder, xnppd_key_t *key)
> +{
> +    unsigned bucket = jhash2((uint32_t *)&key->mm,
> +                             sizeof(key->mm)/sizeof(uint32_t), 0);

GCC is likely going to wine on 64-bit archs for attempting to forge a 
type-punned pointer.

> +    xnppd_holder_t *ppd = NULL;
>      xnfeatinfo_t finfo;
>      u_long featmis;
>      int muxid;
> @@ -981,18 +1115,39 @@
>         chance to call xnpod_init(). */
>  
>      if (muxtable[muxid].eventcb) {
> -        int err = muxtable[muxid].eventcb(XNSHADOW_CLIENT_ATTACH);
> +        xnlock_get_irqsave(&nklock, s);
> +        ppd = xnppd_lookup(muxid, curr->mm);
> +        xnlock_put_irqrestore(&nklocks, s);
>

Looks racy to release the nucleus lock that early before actually using 
the found value, if another thread from the same process manages to 
preempt the caller and interleave a binding request on its own (would be 
stupid, I agree, but hey, most of our day-to-day job is to implement 
LARTs pretending that we are "innovating" somehow, so...)

>  
> +/* Call with nklock locked irqs off. */
> +xnppd_holder_t *xnppd_get(unsigned muxid)
> +{
> +    if (xnpod_userspace_p())
> +        return xnppd_lookup(muxid - 1, current->mm);
> +
> +    return NULL;
> +}

Same remark than previously regarding shadow.h, all the xnppd_* services 
are truely shadow-related  services, so calling them 
xnshadow_ppd*something() would be more accurate.

-- 

Philippe.

