Subject: Re: [PATCH] pipe_base.h: use tsc_khz for tsc-to-nanoseconds
 calculations
References: <CAB+DZ3mffahwSUD_9vADZMQQek0LdhdVuO9ZL29vk-7SoDEn2Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4ab58cda-0f6b-eff6-a737-32f76d4d95b1@siemens.com>
Date: Fri, 8 Jan 2021 13:14:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAB+DZ3mffahwSUD_9vADZMQQek0LdhdVuO9ZL29vk-7SoDEn2Q@mail.gmail.com>
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
To: Bart Vissers <bvissers@e2mtechnologies.eu>, xenomai@xenomai.org

On 21.12.20 10:49, Bart Vissers via Xenomai wrote:
> This fixes a clock drift issue that is measurable with clocktest. The
> change was suggested by Jan a while ago [0], I tested it again on 4.19.89.
> 
> [0] https://www.xenomai.org/pipermail/xenomai/2019-May/040929.html
> 

Thanks for bringing this up again!

> Signed-off-by: Bart Vissers <bvissers@e2mtechnologies.eu>
> ---
>  arch/x86/include/asm/ipipe_base.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ipipe_base.h
> b/arch/x86/include/asm/ipipe_base.h
> index c09697b1f20c..ea2876aa62b9 100644
> --- a/arch/x86/include/asm/ipipe_base.h
> +++ b/arch/x86/include/asm/ipipe_base.h
> @@ -58,14 +58,14 @@
> 
>  #include <asm/apicdef.h>
> 
> -extern unsigned int cpu_khz;
> +extern unsigned int tsc_khz;
> 
>  static inline const char *ipipe_clock_name(void)
>  {
>      return "tsc";
>  }
> 
> -#define __ipipe_cpu_freq    ({ u64 __freq = 1000ULL * cpu_khz; __freq; })
> +#define __ipipe_cpu_freq    ({ u64 __freq = 1000ULL * tsc_khz; __freq; })
>  #define __ipipe_hrclock_freq    __ipipe_cpu_freq
> 
>  #ifdef CONFIG_X86_32
> 

Merged to ipipe-x86-4.19.y-cip, ipipe-x86-5.4.y and also ipipe-4.4.y-cip.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

