Subject: Re: [PATCH] Revert "cobalt/assert: pipeline: add TODO() marker"
References: <20211201011312.32144-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <053b15a0-0f05-6a1e-6c56-21854b78eb9d@siemens.com>
Date: Wed, 1 Dec 2021 07:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <20211201011312.32144-1-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 01.12.21 02:13, Hongzhan Chen via Xenomai wrote:
> This reverts commit 5c9cbcfce83083d9ea280f3b9143525cacfecfc8.
> 
> We revert this because we fixed all related TODOs.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/include/cobalt/kernel/assert.h b/include/cobalt/kernel/assert.h
> index abe044100..98218ce6c 100644
> --- a/include/cobalt/kernel/assert.h
> +++ b/include/cobalt/kernel/assert.h
> @@ -55,8 +55,6 @@
>  	do { } while (0)
>  #endif
>  
> -#define TODO()    BUILD_BUG_ON(IS_ENABLED(CONFIG_XENO_TODO))
> -
>  #define primary_mode_only()	XENO_BUG_ON(CONTEXT, is_secondary_domain())
>  #define secondary_mode_only()	XENO_BUG_ON(CONTEXT, !is_secondary_domain())
>  #define interrupt_only()	XENO_BUG_ON(CONTEXT, !xnsched_interrupt_p())
> diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
> index 88953ff24..3233de1b1 100644
> --- a/kernel/cobalt/Kconfig
> +++ b/kernel/cobalt/Kconfig
> @@ -487,9 +487,3 @@ config XENO_OPT_WATCHDOG_TIMEOUT
>  	  Watchdog timeout value (in seconds).
>  
>  endif # XENO_OPT_DEBUG
> -
> -config XENO_TODO
> -	bool "Reveal TODO places"
> -	help
> -	  This option causes a build time assertion to trigger
> -	  when the TODO() marker is found in the compiled code.
> 

thanks, applied

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

