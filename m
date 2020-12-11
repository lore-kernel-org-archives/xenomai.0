Subject: Re: [PATCH] cobalt/synch: uapi: silence pedantic warning
 (signed/unsigned)
References: <20201204150735.2521575-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a07a26a-1b4f-50bb-559a-785a6b114561@siemens.com>
Date: Fri, 11 Dec 2020 07:44:38 +0100
MIME-Version: 1.0
In-Reply-To: <20201204150735.2521575-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 04.12.20 16:07, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/cobalt/uapi/kernel/synch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/cobalt/uapi/kernel/synch.h b/include/cobalt/uapi/kernel/synch.h
> index 33d7ab3c7..a21eb965e 100644
> --- a/include/cobalt/uapi/kernel/synch.h
> +++ b/include/cobalt/uapi/kernel/synch.h
> @@ -71,7 +71,7 @@ int xnsynch_fast_acquire(atomic_t *fastlock, xnhandle_t new_ownerh)
>  static inline
>  int xnsynch_fast_release(atomic_t *fastlock, xnhandle_t cur_ownerh)
>  {
> -	return atomic_cmpxchg(fastlock, cur_ownerh, XN_NO_HANDLE)
> +	return (xnhandle_t)atomic_cmpxchg(fastlock, cur_ownerh, XN_NO_HANDLE)
>  		== cur_ownerh;
>  }
>  
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

