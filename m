Message-ID: <5385B2DF.9050204@xenomai.org>
Date: Wed, 28 May 2014 11:56:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1401236892.2728.11.camel@nswph.gme.net.au>
 <B2415EB1697ACE44AE82CBBFA957DEED48B153@EXCH01.gme.net.au>
In-Reply-To: <B2415EB1697ACE44AE82CBBFA957DEED48B153@EXCH01.gme.net.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 2/2] Add ipipe support for Ti da850 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Howard <phoward@gme.net.au>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/28/2014 02:37 AM, Peter Howard wrote:
> +#ifdef CONFIG_IPIPE
> +			ipipe_handle_demuxed_irq(
> +				irq_find_mapping(d->irq_domain,
> +						 d->chip.base + bit));
> +#else
>  			generic_handle_irq(
>  				irq_find_mapping(d->irq_domain,
>  						 d->chip.base + bit));
> +#endif /* CONFIG_IPIPE */
>  		}
>  	}
>  	chained_irq_exit(irq_desc_get_chip(desc), desc);
> 

You do not need the #ifdef CONFIG_IPIPE here, ipipe_handle_demuxed_irq
is replaced with generic_handle_irq when CONFIG_IPIPE is off.

-- 
                                                                Gilles.

