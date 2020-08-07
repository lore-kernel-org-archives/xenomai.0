Sender: pintu=codeaurora.org@mg.codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Aug 2020 10:26:35 +0530
From: pintu@codeaurora.org
Subject: Re: [PATCH] kernel:cobalt:heap: replace kzalloc with kvzalloc
In-Reply-To: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
Message-ID: <006bb9052420d5d99b32facef2d546ba@codeaurora.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org, sunshilong369@gmail.com, pintu@codeaurora.org
Cc: pintu.ping@gmail.com

On 2020-07-31 23:34, Pintu Kumar wrote:
> With CONFIG_XENO_OPT_PRIVATE_HEAPSZ, user that request any heap size
> based on their needs. For some application needs, this can grow as 
> large
> as 4MB that is, 2^10 order pages, which is unlikely to succeed with
> kzalloc.
> Even the default (256KB) may fail on highly fragmented system.
> Further without COMPACTION enabled, the situation can be worse.
> 
> Moreover, for this heap allocation, we don't need physical contiguous
> memory. Thus vmalloc may be sufficient here.
> But for performance benefit we may like to stick to kmalloc.
> 
> Thus, it is better to replace kzalloc with kvzalloc which will first 
> try
> to use kmalloc and if fails, fallback to vmalloc.
> 
> Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
> Signed-off-by: sunshilong <sunshilong369@gmail.com>
> Tested-by: sunshilong <sunshilong369@gmail.com>
> ---
>  kernel/cobalt/heap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
> index d01a2e0..312b41f 100644
> --- a/kernel/cobalt/heap.c
> +++ b/kernel/cobalt/heap.c
> @@ -749,7 +749,7 @@ int xnheap_init(struct xnheap *heap, void
> *membase, size_t size)
>  	xnlock_init(&heap->lock);
> 
>  	nrpages = size >> XNHEAP_PAGE_SHIFT;
> -	heap->pagemap = kzalloc(sizeof(struct xnheap_pgentry) * nrpages,
> +	heap->pagemap = kvzalloc(sizeof(struct xnheap_pgentry) * nrpages,
>  				GFP_KERNEL);
>  	if (heap->pagemap == NULL)
>  		return -ENOMEM;
> @@ -804,7 +804,7 @@ void xnheap_destroy(struct xnheap *heap)
>  	nrheaps--;
>  	xnvfile_touch_tag(&vfile_tag);
>  	xnlock_put_irqrestore(&nklock, s);
> -	kfree(heap->pagemap);
> +	kvfree(heap->pagemap);
>  }
>  EXPORT_SYMBOL_GPL(xnheap_destroy);


Hi,

Is there any feedback or comments on the above patch ?


Thanks,
Pintu

