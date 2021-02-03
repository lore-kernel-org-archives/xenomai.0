Subject: Re: [PATCH v2 1/2] kernel: cobalt: Remove header file for newer
 kernels
References: <20210203070159.3610435-1-greg@embeddedgreg.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <15001d4b-48ce-7192-d5e8-0e4dab9a55e0@siemens.com>
Date: Wed, 3 Feb 2021 10:50:18 +0100
MIME-Version: 1.0
In-Reply-To: <20210203070159.3610435-1-greg@embeddedgreg.com>
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
> 5.4 kernels do not have compiler.h, only include this header file for kernels older then 5.4
> 
> Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
> ---
>  kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> index 7444cc823..17be10339 100644
> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
> @@ -29,7 +29,11 @@
>  #define XNARCH_HOST_TICK_IRQ __ipipe_hrtimer_irq
>  
>  #include <asm/barrier.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
>  #include <asm/compiler.h>
> +#endif
> +
>  #include <asm/cmpxchg.h>
>  #include <asm/switch_to.h>
>  #include <asm/system_misc.h>
> 

There is still arch/arm64/include/asm/compiler.h in today's master.

What error exactly are you fixing? That we should rather including
linux/compiler.h? Or is that header obsolete for us now, for all kernels?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

