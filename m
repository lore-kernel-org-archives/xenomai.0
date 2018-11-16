Subject: Re: [PATCH 3/3] vxworks/mempart: fix error status upon failure to
 create partition
References: <20181114104152.11627-1-rpm@xenomai.org>
 <20181114104152.11627-3-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ead0852a-5bf9-090b-cbba-7e185753f83d@siemens.com>
Date: Fri, 16 Nov 2018 07:33:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181114104152.11627-3-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 14.11.18 11:41, Philippe Gerum wrote:
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   lib/vxworks/memPartLib.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vxworks/memPartLib.c b/lib/vxworks/memPartLib.c
> index 22d77bdcf..c8eeb3617 100644
> --- a/lib/vxworks/memPartLib.c
> +++ b/lib/vxworks/memPartLib.c
> @@ -48,17 +48,21 @@ PART_ID memPartCreate(char *pPool, unsigned int poolSize)
>   	pthread_mutexattr_t mattr;
>   	struct wind_mempart *mp;
>   	struct service svc;
> +	int ret;
>   
>   	CANCEL_DEFER(svc);
>   
>   	mp = xnmalloc(sizeof(*mp));
> -	if (mp == NULL)
> +	if (mp == NULL) {
> +		errno = S_memLib_NOT_ENOUGH_MEMORY;
>   		goto fail;
> +	}
>   
> -	if (__heapobj_init(&mp->hobj, NULL, poolSize, pPool)) {
> +	ret = __heapobj_init(&mp->hobj, NULL, poolSize, pPool);
> +	if (ret) {
>   		xnfree(mp);
> +		errno = S_memLib_INVALID_NBYTES;
>   	fail:
> -		errno = S_memLib_NOT_ENOUGH_MEMORY;
>   		CANCEL_RESTORE(svc);
>   		return (PART_ID)0;
>   	}
> 

Thanks, all three applied to next.

This 3rd patch I've also queued for stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

