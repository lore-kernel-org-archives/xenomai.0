Subject: Re: [PATCH v2 2/2] kernel: cobalt: Fix up elf_hwcap
References: <20210203070159.3610435-1-greg@embeddedgreg.com>
 <20210203070159.3610435-2-greg@embeddedgreg.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5947a2e0-fab4-d098-cca5-3d3305fec6f3@siemens.com>
Date: Wed, 3 Feb 2021 10:52:41 +0100
MIME-Version: 1.0
In-Reply-To: <20210203070159.3610435-2-greg@embeddedgreg.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 03.02.21 08:01, Greg Gallagher via Xenomai wrote:
> Update to use ELF_HWCAP instead of elf_hwcap directly.
> 
> Signen-off-by: Greg Gallagher <greg@embeddedgreg.com>
> ---
>  kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h   | 2 +-
>  kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> index a76f1e6bb..b8c627bed 100644
> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> @@ -23,7 +23,7 @@
>  #include <asm/hwcap.h>
>  
>  #ifdef CONFIG_VFP
> -#define have_vfp (elf_hwcap & HWCAP_VFP)
> +#define have_vfp (ELF_HWCAP & HWCAP_VFP)
>  #else /* !CONFIG_VFP */
>  #define have_vfp 0
>  #endif /* !CONFIG_VFP */
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> index b7e3f52f2..291c9e5f0 100644
> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> @@ -23,7 +23,7 @@
>  #include <asm/xenomai/uapi/fptest.h>
>  #include <asm/hwcap.h>
>  
> -#define have_fp (elf_hwcap & HWCAP_FP)
> +#define have_fp (ELF_HWCAP & HWCAP_FP)
>  
>  static inline int fp_kernel_supported(void)
>  {
> 

Rebased and applied (and "signed-off" typo fixed).

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

