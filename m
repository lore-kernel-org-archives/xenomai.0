Message-ID: <50E45035.4050704@siemens.com>
Date: Wed, 02 Jan 2013 16:20:21 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1348579158-5686-1-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1348579158-5686-1-git-send-email-wolfgang.mauerer@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] hal: Fix cpu bitmap handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>, xenomai@xenomai.org

On 2012-09-25 15:19, Wolfgang Mauerer wrote:
> Don't left-shift further than the bit-width of the
> shifted type allows. In this particular constellation,
> this leads to selecting CPUs that are not specified in
> supported_cpus_arg on systems with more than 32 cores.
> 
> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
> ---
>  ksrc/arch/generic/hal.c |    2 +-
>  ksrc/nucleus/intr.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
> index ac6c171..f6ac722 100644
> --- a/ksrc/arch/generic/hal.c
> +++ b/ksrc/arch/generic/hal.c
> @@ -539,7 +539,7 @@ int rthal_init(void)
>      int cpu;
>      cpus_clear(rthal_supported_cpus);
>      for (cpu = 0; cpu < BITS_PER_LONG; cpu++)
> -	    if (supported_cpus_arg & (1 << cpu))
> +	    if (supported_cpus_arg & (1ul << cpu))
>  		    cpu_set(cpu, rthal_supported_cpus);
>  #endif /* CONFIG_SMP */
>  
> diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
> index 0f37bb2..e77f25e 100644
> --- a/ksrc/nucleus/intr.c
> +++ b/ksrc/nucleus/intr.c
> @@ -1083,7 +1083,7 @@ static int affinity_vfile_show(struct xnvfile_regular_iterator *it,
>  
>  	for (cpu = 0; cpu < BITS_PER_LONG; cpu++)
>  		if (xnarch_cpu_isset(cpu, nkaffinity))
> -			val |= (1 << cpu);
> +			val |= (1ul << cpu);
>  
>  	xnvfile_printf(it, "%08lx\n", val);
>  
> 

This fix wasn't merged into 2.6. Just forgotten?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

