Subject: Re: [PATCH 3/4] cobalt/kernel: fix compile error for incompatible
 pointer type
References: <20200918063234.8557-1-fino.meng@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <96436f26-007a-41ee-17c6-247a17faa8c0@siemens.com>
Date: Fri, 18 Sep 2020 15:05:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200918063234.8557-1-fino.meng@linux.intel.com>
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
To: Fino Meng <fino.meng@linux.intel.com>, xenomai@xenomai.org, fino.meng@intel.com

<no commit message>

On 18.09.20 08:32, Fino Meng wrote:
> Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
> Signed-off-by: Mingliang Hu <mingliang.hu@intel.com>
> ---
>   include/cobalt/kernel/stat.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/cobalt/kernel/stat.h b/include/cobalt/kernel/stat.h
> index b857cd19f..be529ad72 100644
> --- a/include/cobalt/kernel/stat.h
> +++ b/include/cobalt/kernel/stat.h
> @@ -58,7 +58,7 @@ do { \
>   #define xnstat_exectime_set_current(sched, new_account) \
>   ({ \
>   	xnstat_exectime_t *__prev; \
> -	__prev = (xnstat_exectime_t *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
> +	__prev = (xnstat_exectime_t *)atomic_long_xchg((atomic_long_t *)&(sched)->current_account, (long)(new_account)); \

Which upstream change made this necessary? Was the issue hidden behind 
too relaxed compiler warnings, or was there a real type change? If the 
latter, why is that cast OK?

Jan

>   	__prev; \
>   })
>   
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

