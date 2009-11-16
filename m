Message-ID: <4B01792A.4090206@domain.hid>
Date: Mon, 16 Nov 2009 17:09:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NA3bT-0002c1-7v@domain.hid>
In-Reply-To: <E1NA3bT-0002c1-7v@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Include all
	heaps in statistics
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

GIT version control wrote:
> +void xnheap_set_label(xnheap_t *heap, const char *label, ...)
> +{
> +	va_list args;
> +	spl_t s;
> +
> +	va_start(args, label);
> +
> +	xnlock_get_irqsave(&nklock, s);
> +	vsnprintf(heap->label, sizeof(heap->label), label, args);
> +	xnlock_put_irqrestore(&nklock, s);

Why do we need locking here ?

-- 
                                          Gilles


