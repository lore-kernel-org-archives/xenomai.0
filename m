Subject: Re: [PATCH v3] kernel:cobalt:heap: replace kzalloc with vzalloc
References: <1597487369-20838-1-git-send-email-pintu@codeaurora.org>
 <1597773391-10105-1-git-send-email-pintu@codeaurora.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5a0ab120-895c-8098-77bb-d2cd3e0567d2@siemens.com>
Date: Wed, 19 Aug 2020 08:31:50 +0200
MIME-Version: 1.0
In-Reply-To: <1597773391-10105-1-git-send-email-pintu@codeaurora.org>
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
To: Pintu Kumar <pintu@codeaurora.org>, xenomai@xenomai.org, rpm@xenomai.org, sunshilong369@gmail.com
Cc: pintu.ping@gmail.com

On 18.08.20 19:56, Pintu Kumar wrote:
> With CONFIG_XENO_OPT_PRIVATE_HEAPSZ, user can request any heap size
> based on their needs. For some application needs, this can grow as large
> as 4MB that is, 2^10 order pages, which is unlikely to succeed with
> kzalloc. Even the default (256KB) may fail on highly fragmented system.
> 
> Moreover, for this heap allocation, we don't need physical contiguous
> memory. Thus vmalloc/vzalloc may be sufficient here.
> 
> Note, we may also use kvzalloc/kvmalloc, but unfortunately these are not
> available in all kernel versions. Thus for backward compatibility we stick
> to vmalloc at least till we support 4.x kernel.
> 
> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> Signed-off-by: sunshilong <sunshilong369@gmail.com>
> Tested-by: sunshilong <sunshilong369@gmail.com>
> ---
>  kernel/cobalt/heap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
> index d01a2e0..5d14a47 100644
> --- a/kernel/cobalt/heap.c
> +++ b/kernel/cobalt/heap.c
> @@ -749,8 +749,7 @@ int xnheap_init(struct xnheap *heap, void *membase, size_t size)
>  	xnlock_init(&heap->lock);
>  
>  	nrpages = size >> XNHEAP_PAGE_SHIFT;
> -	heap->pagemap = kzalloc(sizeof(struct xnheap_pgentry) * nrpages,
> -				GFP_KERNEL);
> +	heap->pagemap = vzalloc(sizeof(struct xnheap_pgentry) * nrpages);
>  	if (heap->pagemap == NULL)
>  		return -ENOMEM;
>  
> @@ -804,7 +803,7 @@ void xnheap_destroy(struct xnheap *heap)
>  	nrheaps--;
>  	xnvfile_touch_tag(&vfile_tag);
>  	xnlock_put_irqrestore(&nklock, s);
> -	kfree(heap->pagemap);
> +	vfree(heap->pagemap);
>  }
>  EXPORT_SYMBOL_GPL(xnheap_destroy);
>  
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

