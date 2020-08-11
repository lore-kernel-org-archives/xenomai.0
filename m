Subject: Re: [PATCH] kernel:cobalt:heap: replace kzalloc with kvzalloc
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
 <7a76268b-84f6-0073-7830-54a317106c7d@siemens.com>
 <fc87600a-0797-849d-2d35-f2d32d1a7a90@siemens.com>
 <CAAvDm6a2VPs_0uqZZChXc=mhnx7c4Z1sPstbbMRNGceYKZg7_Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <65a89852-1f02-663a-3d08-6e0ad2716044@siemens.com>
Date: Tue, 11 Aug 2020 10:51:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6a2VPs_0uqZZChXc=mhnx7c4Z1sPstbbMRNGceYKZg7_Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc: Pintu Kumar <pintu@codeaurora.org>, xenomai <xenomai@xenomai.org>, Pintu Agarwal <pintu.ping@gmail.com>

On 11.08.20 10:48, 孙世龙 sunshilong wrote:
> Hi, Jan Kiszka, Pintu Kunmar
> 
>> Breaks 4.4 kernels. Please have a look:
>> https://travis-ci.com/github/xenomai-ci/xenomai/builds/179223968
> Sorry, I forgot.
> It seems that kvzalloc is not available for linux-4.4.
> So, this patch
> (see https://xenomai.org/pipermail/xenomai/2020-July/043137.html) may be better.
> 
> For your convenience, here is the patch:
> diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
> index d01a2e0..f9d9a05 100644
> --- a/kernel/cobalt/heap.c
> +++ b/kernel/cobalt/heap.c
> @@ -749,8 +749,8 @@ int xnheap_init(struct xnheap *heap, void
> *membase, size_t size)
>         xnlock_init(&heap->lock);
> 
>         nrpages = size >> XNHEAP_PAGE_SHIFT;
> -       heap->pagemap = kzalloc(sizeof(struct xnheap_pgentry) * nrpages,
> -                               GFP_KERNEL);
> +       heap->pagemap = kvmalloc(sizeof(struct xnheap_pgentry) * nrpages,
> +                               GFP_KERNEL | __GFP_ZERO);
>         if (heap->pagemap == NULL)
>                 return -ENOMEM;
> 
> @@ -804,7 +804,7 @@ void xnheap_destroy(struct xnheap *heap)
>         nrheaps--;
>         xnvfile_touch_tag(&vfile_tag);
>         xnlock_put_irqrestore(&nklock, s);
> -       kfree(heap->pagemap);
> +       kvfree(heap->pagemap);
>  }
>  EXPORT_SYMBOL_GPL(xnheap_destroy);
> 
> 

Could you send a v2 of this patch with the more exhaustive description
you had in v1?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

