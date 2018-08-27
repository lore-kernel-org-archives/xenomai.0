References: <cover.1535375976.git.henning.schild@siemens.com>
 <8861ff377012947ab2239066c864253975ea5bad.1535375976.git.henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <14df678f-9f1c-8588-4c73-5f64b010f0b9@siemens.com>
Date: Mon, 27 Aug 2018 18:18:01 +0200
MIME-Version: 1.0
In-Reply-To: <8861ff377012947ab2239066c864253975ea5bad.1535375976.git.henning.schild@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 2/3] cobalt/x86: add ipipe-4.4 eager fpu
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Xenomai <xenomai@xenomai.org>

On 2018-08-27 15:28, Henning Schild wrote:
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>   kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> index 73df60cc6..0156e86f0 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> @@ -29,6 +29,12 @@
>       LINUX_VERSION_CODE > KERNEL_VERSION(4,9,108)
>   #define IPIPE_X86_FPU_EAGER
>   #endif
> +// actually 4.4.138 drops lazy, but in IPIPE we do it at 72

Huh? We also do lazy up to 4.4.137, at least in x86 staging (latest 
release was .71, indeed). But nothing has been removed from that old 
version to prevent laziness.

> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0) && \

Again, redundant condition.

> +    LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0) && \
> +    LINUX_VERSION_CODE > KERNEL_VERSION(4,4,71)
> +#define IPIPE_X86_FPU_EAGER
> +#endif
>   
>   #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>   #include <asm/i387.h>
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

