Subject: Re: [PATCH 6/7] kernel: cobalt: migrate to ktime_t
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
 <20190305144521.2567-6-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <74cba403-be71-2e9f-c125-a6e2b6b84728@siemens.com>
Date: Tue, 5 Mar 2019 19:16:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190305144521.2567-6-roman.stratiienko@globallogic.com>
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
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org

On 05.03.19 15:45, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>   kernel/cobalt/clock.c                 | 4 +---
>   kernel/drivers/analogy/rtdm_helpers.c | 5 +----
>   2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
> index 272db3241..f8291b006 100644
> --- a/kernel/cobalt/clock.c
> +++ b/kernel/cobalt/clock.c
> @@ -350,9 +350,7 @@ EXPORT_SYMBOL_GPL(xnclock_adjust);
>   
>   xnticks_t xnclock_get_host_time(void)
>   {
> -	struct timeval tv;
> -	do_gettimeofday(&tv);
> -	return tv.tv_sec * 1000000000ULL + tv.tv_usec * 1000;
> +	return ktime_to_ns(ktime_get_real());
>   }
>   EXPORT_SYMBOL_GPL(xnclock_get_host_time);
>   
> diff --git a/kernel/drivers/analogy/rtdm_helpers.c b/kernel/drivers/analogy/rtdm_helpers.c
> index 8330d0676..675594152 100644
> --- a/kernel/drivers/analogy/rtdm_helpers.c
> +++ b/kernel/drivers/analogy/rtdm_helpers.c
> @@ -32,11 +32,8 @@ static nanosecs_abs_t a4l_clkofs;
>   void a4l_init_time(void)
>   {
>   	nanosecs_abs_t t1, t2;
> -	struct timeval tv;
>   	t1 = rtdm_clock_read();
> -	do_gettimeofday(&tv);
> -	t2 = 1000000000 * ((nanosecs_abs_t)tv.tv_sec) +
> -		1000000 * ((nanosecs_abs_t)tv.tv_usec);

Hmm.... I think this even fixes a bug: Should have been "1000 * ...".

> +	t2 = ktime_to_ns(ktime_get_real());
>   	a4l_clkofs = t2 - t1;
>   }
>   
> 

For the record: This pattern is supported since 3.17. So we are fine.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

