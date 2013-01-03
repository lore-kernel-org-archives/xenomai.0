Message-ID: <50E5E614.8020802@xenomai.org>
Date: Thu, 03 Jan 2013 21:12:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50E062E8.6030903@openwide.fr>
	<50E0BD01.1020404@xenomai.org>	<50E17756.7030400@openwide.fr>
	<50E4C4E3.2070909@openwide.fr>
In-Reply-To: <50E4C4E3.2070909@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.2 user-space compilation error on ARM <
 armv6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 01/03/2013 12:38 AM, Romain Naour wrote:

> Hi Gilles,
> 
> I did a test today with your previous patch, it works correctly.
> However the following patch is required since the new ipipe-core.
> 
> Signed-off-by: Naour Romain <romain.naour@openwide.fr>
> ---
> 
> We need a minimal reload value for s3c2410_itimer, otherwise the hardware timer stops.
> 
>  arch/arm/plat-samsung/time.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
> index 8d14b85..97fbdc5 100644
> --- a/arch/arm/plat-samsung/time.c
> +++ b/arch/arm/plat-samsung/time.c
> @@ -364,6 +364,8 @@ static void s3c2410_timer_setup (void)
>  
>  #ifdef CONFIG_IPIPE
>  	s3c2410_itimer.freq = tcnt * HZ;
> +	/* hardware timer can't be reloaded below 120ns */
> +	s3c2410_itimer.min_delay_ticks = ipipe_timer_ns2ticks(&s3c2410_itimer, 120);
>  	ipipe_timer_register(&s3c2410_itimer);
>  #endif /* CONFIG_IPIPE */
>  }


Merged, thanks.

-- 
                                                                Gilles.

