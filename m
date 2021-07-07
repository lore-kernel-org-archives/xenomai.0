Subject: Re: [PATCH] cobalt/rtdm: fix memory leak in rtdm_irq_free()
References: <24eda037-abaa-a4c9-0ac9-057e8e6aa956@grandegger.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d7f905b2-6711-5d0a-5a12-2030ffe95c37@siemens.com>
Date: Wed, 7 Jul 2021 17:59:28 +0200
MIME-Version: 1.0
In-Reply-To: <24eda037-abaa-a4c9-0ac9-057e8e6aa956@grandegger.com>
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
To: Wolfgang Grandegger <wg@grandegger.com>, xenomai@xenomai.org

On 07.07.21 16:54, Wolfgang Grandegger via Xenomai wrote:
> The space allocated for irq stats in xnintr_init() will not be freed
> by rtdm_irq_free(), because it just calls xnintr_detach(). Replacing
> it with xnintr_destroy() fixes the issue.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  include/cobalt/kernel/rtdm/driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 894e6f6..d69166d 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -858,7 +858,7 @@ static inline int rtdm_irq_free(rtdm_irq_t *irq_handle)
>  {
>  	if (!XENO_ASSERT(COBALT, xnsched_root_p()))
>  		return -EPERM;
> -	xnintr_detach(irq_handle);
> +	xnintr_destroy(irq_handle);
>  	return 0;
>  }
>  
> 

Good catch. Became problematic with 9a989e8a, ie. only 8 years ago.
Before that, xnintr_detach and destroy were equivalent. Only recent
dovetail variant is not affected (again).

Applied to next, will make it to stable as well.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

