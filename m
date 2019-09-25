Subject: Re: [PATCH] Dump ABI revisions
References: <e6218fb4-0419-0a45-8220-a006ffbc06e2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <22a4dd8a-df2a-f453-1a90-6540933bf7d4@siemens.com>
Date: Wed, 25 Sep 2019 11:16:26 +0200
MIME-Version: 1.0
In-Reply-To: <e6218fb4-0419-0a45-8220-a006ffbc06e2@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

Well, not "Dump", rather "Bump"...

On 25.09.19 11:13, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We've changed ABI in several details since 3.0.x, so we need to update
> the ABI revision as well.
> 
> Reported-by: Lange Norbert <norbert.lange@andritz.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h     | 2 +-
>   kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h | 2 +-
>   kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h     | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> index 44bbbbdb08..c3c777cb93 100644
> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> @@ -22,7 +22,7 @@
>   #define _COBALT_ARM_ASM_UAPI_FEATURES_H
>   
>   /* The ABI revision level we use on this arch. */
> -#define XENOMAI_ABI_REV   16UL
> +#define XENOMAI_ABI_REV   17UL
>   
>   #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
>   
> diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
> index cbc64f27a4..f6e67d884b 100644
> --- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
> @@ -19,7 +19,7 @@
>   #define _COBALT_POWERPC_ASM_UAPI_FEATURES_H
>   
>   /* The ABI revision level we use on this arch. */
> -#define XENOMAI_ABI_REV   16UL
> +#define XENOMAI_ABI_REV   17UL
>   
>   #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
>   
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> index 0a06d128c9..67c7625f86 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> @@ -19,7 +19,7 @@
>   #define _COBALT_X86_ASM_UAPI_FEATURES_H
>   
>   /* The ABI revision level we use on this arch. */
> -#define XENOMAI_ABI_REV   16UL
> +#define XENOMAI_ABI_REV   17UL
>   
>   #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
>   
>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

