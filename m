Subject: Re: [PATCH] arm_global_timer: Use 64 Bit hw counter for ipipe_tsc
References: <20210305082259.18424-1-gunter.grau@philips.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <217744bd-4588-02ea-0e85-0bb7d97436c0@siemens.com>
Date: Fri, 5 Mar 2021 13:27:21 +0100
MIME-Version: 1.0
In-Reply-To: <20210305082259.18424-1-gunter.grau@philips.com>
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
To: Gunter Grau <gunter.grau@philips.com>, xenomai@xenomai.org, Greg Gallagher <greg@embeddedgreg.com>

On 05.03.21 09:22, Gunter Grau via Xenomai wrote:
> When using the arm_global_timer as source for ipipe_tsc the mask
> was configured with 32 Bit.
> However this timer is a native 64 Bit counter. So use the complete
> hardware register by configuring a 64 Bit mask on initialization.
> The ipipe_tsc implementation is already 64 Bit ready and reads this
> register as described in the reference manual, so no further
> changes needed.
> 
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  drivers/clocksource/arm_global_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 77c116a3e85f..44c10e364f62 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -82,7 +82,7 @@ static inline void gt_ipipe_cs_setup(void)
>                 .u = {
>                         {
>                                 .counter_paddr = gt_pbase,
> -                               .mask = 0xffffffff,
> +                               .mask = CLOCKSOURCE_MASK(64),
>                         }
>                 },
>                 .refresh_freq = refresh_gt_freq,
> --
> 2.17.1
> 

Thanks for the fixes. You may help Greg with integrating them by telling
us on which kernel versions they apply / have been tested.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

