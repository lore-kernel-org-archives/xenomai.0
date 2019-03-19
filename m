Subject: Re: [PATCH v2 09/10] kernel: cobalt: migrate to ktime_t
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
 <20190306175331.25444-9-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3cbd44b4-6440-5886-9c3b-bfec3141dfa4@siemens.com>
Date: Tue, 19 Mar 2019 15:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190306175331.25444-9-roman.stratiienko@globallogic.com>
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

On 06.03.19 18:53, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> As do_gettimeofday is very old and deprecated, use ktime instead
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
> +	t2 = ktime_to_ns(ktime_get_real());
>   	a4l_clkofs = t2 - t1;
>   }
>   
> 

I'm leaving a note in the commit log that this also fixes a conversion bug in 
a4l_init_time.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

