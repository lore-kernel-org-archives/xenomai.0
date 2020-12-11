Subject: Re: [PATCH v2 3/3] cobalt uapi: Introducing new feature flag for
 time64 availability
References: <157dbba3-5d17-7f84-6319-9ea9eae35854@tj.kylinos.cn>
 <20201116140641.72027-1-florian.bezdeka@siemens.com>
 <20201116140641.72027-4-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dc946872-4e9a-11fd-d5f6-20413b9ba90d@siemens.com>
Date: Fri, 11 Dec 2020 07:41:01 +0100
MIME-Version: 1.0
In-Reply-To: <20201116140641.72027-4-florian.bezdeka@siemens.com>
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
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, song <chensong@tj.kylinos.cn>

On 16.11.20 15:07, florian.bezdeka--- via Xenomai wrote:
> From: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> Adding a new feature flag to allow the library asking for time64
> support. That will allow the library to use the new system calls when
> available / supported by the kernel.
> 
> The feature flag should be removed during next ABI revision bump.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/uapi/asm-generic/features.h                  | 6 +++++-
>  .../cobalt/arch/arm64/include/asm/xenomai/uapi/features.h   | 1 +
>  .../cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h | 1 +
>  kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h  | 1 +
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/cobalt/uapi/asm-generic/features.h b/include/cobalt/uapi/asm-generic/features.h
> index 8a4927c49..705729aae 100644
> --- a/include/cobalt/uapi/asm-generic/features.h
> +++ b/include/cobalt/uapi/asm-generic/features.h
> @@ -51,6 +51,7 @@ struct cobalt_featinfo {
>  #define __xn_feat_nofastsynch 0x10000000
>  #define __xn_feat_control     0x08000000
>  #define __xn_feat_prioceiling 0x04000000
> +#define __xn_feat_time64      0x02000000
>  
>  #ifdef CONFIG_SMP
>  #define __xn_feat_smp_mask __xn_feat_smp
> @@ -70,7 +71,8 @@ struct cobalt_featinfo {
>  #define __xn_feat_generic_mask			\
>  	(__xn_feat_smp_mask		|	\
>  	 __xn_feat_fastsynch_mask 	|	\
> -	 __xn_feat_prioceiling)
> +	 __xn_feat_prioceiling		|	\
> +	 __xn_feat_time64)
>  
>  /*
>   * List of features both sides have to agree on: If userland supports
> @@ -101,6 +103,8 @@ const char *get_generic_feature_label(unsigned int feature)
>  		return "control";
>  	case __xn_feat_prioceiling:
>  		return "prioceiling";
> +	case __xn_feat_time64:
> +		return "time64";
>  	default:
>  		return 0;
>  	}
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> index 74423f68b..f03f483f6 100644
> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> @@ -22,6 +22,7 @@
>  #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
>  
>  /* The ABI revision level we use on this arch. */
> +// TODO: Reminder: Remove __xn_feat_time64 feature flag on next ABI_REV bump
>  #define XENOMAI_ABI_REV   1UL
>  
>  #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
> index f6e67d884..db6dbed24 100644
> --- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
> @@ -19,6 +19,7 @@
>  #define _COBALT_POWERPC_ASM_UAPI_FEATURES_H
>  
>  /* The ABI revision level we use on this arch. */
> +// TODO: Reminder: Remove __xn_feat_time64 feature flag on next ABI_REV bump
>  #define XENOMAI_ABI_REV   17UL
>  
>  #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> index 67c7625f8..30539a5d1 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> @@ -19,6 +19,7 @@
>  #define _COBALT_X86_ASM_UAPI_FEATURES_H
>  
>  /* The ABI revision level we use on this arch. */
> +// TODO: Reminder: Remove __xn_feat_time64 feature flag on next ABI_REV bump
>  #define XENOMAI_ABI_REV   17UL
>  
>  #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
> 

There is a larger pile of refactorings sitting in Philippe's queue that
likely require us to move to 3.2 rather sooner than later. Therefore I'm
pulling this our until we have the patches that add time32 also to 3.1.

The other changes can stay, though.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

