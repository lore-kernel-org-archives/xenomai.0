Message-ID: <4F5FA6D5.4050400@domain.hid>
Date: Tue, 13 Mar 2012 20:58:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F5F9A8A.4050308@domain.hid>
In-Reply-To: <4F5F9A8A.4050308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 2.6.38] ipipe: x86_64: Fix build regression
	of 747fa81bca
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On 03/13/2012 08:05 PM, Jan Kiszka wrote:
> Signed-off-by: Jan Kiszka<jan.kiszka@domain.hid>
> ---
>   arch/x86/include/asm/ipipe_64.h |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/ipipe_64.h b/arch/x86/include/asm/ipipe_64.h
> index c99830b..0fb92b4 100644
> --- a/arch/x86/include/asm/ipipe_64.h
> +++ b/arch/x86/include/asm/ipipe_64.h
> @@ -45,8 +45,8 @@ extern int __ipipe_hrtimer_irq;
>   #define __ipipe_hrtimer_freq	__ipipe_cpu_freq
>   #define __ipipe_hrclock_freq	__ipipe_cpu_freq
>
> -#define ipipe_tsc2ns(t)	(((t) * 1000UL) / (__ipipe_clock_freq / 1000000UL))
> -#define ipipe_tsc2us(t)	((t) / (__ipipe_clock_freq / 1000000UL))
> +#define ipipe_tsc2ns(t)	(((t) * 1000UL) / (__ipipe_cpu_freq / 1000000UL))
> +#define ipipe_tsc2us(t)	((t) / (__ipipe_cpu_freq / 1000000UL))
>
>   /* Private interface -- Internal use only */
>

Merged, thanks.

-- 
Philippe.

