Subject: Re: [PATCH 1/2] kernel: cobalt: Fix up elf_hwcap
References: <20210127054348.2128285-1-greg@embeddedgreg.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e577f54b-43c8-0291-ef3a-e48b77d2ebdf@siemens.com>
Date: Wed, 27 Jan 2021 07:13:39 +0100
MIME-Version: 1.0
In-Reply-To: <20210127054348.2128285-1-greg@embeddedgreg.com>
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

On 27.01.21 06:43, Greg Gallagher via Xenomai wrote:
> Update elf_hwcap to ELF_HWCAP, this will work for newer 5.4 kernels
> 

I assume you mean "also work" - or does it break on certain older
kernels? Just asking before consulting our CI. ;)

> Signen-off-by: Greg Gallagher <greg@embeddedgreg.com>
> ---
>  kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

