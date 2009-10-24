From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20091020113725.9069.88823.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
	<20091020113725.9069.88823.stgit@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Oct 2009 19:25:55 +0200
Message-Id: <1256405155.2862.501.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v3 6/9] rtai: Try to fix _shm_free
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-10-20 at 13:37 +0200, Jan Kiszka wrote:
> This is totally untested but should not make things worse than they
> already are.

I cowardly agree with this accurate analysis.

Looks ok anyway, and if not eventually, well, there are one or two -rc's
left, for the one or two users of this skin to check and validate those
changes.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
> 
>  ksrc/skins/rtai/shm.c |   31 +++++++++++++++++++------------
>  1 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/ksrc/skins/rtai/shm.c b/ksrc/skins/rtai/shm.c
> index 4c56495..21c3b07 100644
> --- a/ksrc/skins/rtai/shm.c
> +++ b/ksrc/skins/rtai/shm.c
> @@ -260,19 +260,24 @@ void *rt_heap_open(unsigned long name, int size, int suprt)
>  	return _shm_alloc(name, size, suprt, 0, &opaque);
>  }
>  
> -#ifndef CONFIG_XENO_OPT_PERVASIVE
> +#ifdef CONFIG_XENO_OPT_PERVASIVE
> +static void __heap_flush_shared(xnheap_t *heap)
> +{
> +	xnheap_free(&kheap, heap);
> +}
> +#else /* !CONFIG_XENO_OPT_PERVASIVE */
>  static void __heap_flush_private(xnheap_t *heap,
>  				 void *heapmem, u_long heapsize, void *cookie)
>  {
>  	xnarch_free_host_mem(heapmem, heapsize);
>  }
> -#endif /* CONFIG_XENO_OPT_PERVASIVE */
> +#endif /* !CONFIG_XENO_OPT_PERVASIVE */
>  
>  static int _shm_free(unsigned long name)
>  {
> -	int ret = 0;
>  	xnholder_t *holder;
>  	xnshm_a_t *p;
> +	int ret;
>  	spl_t s;
>  
>  	xnlock_get_irqsave(&nklock, s);
> @@ -283,27 +288,29 @@ static int _shm_free(unsigned long name)
>  		p = link2shma(holder);
>  
>  		if (p->name == name && --p->ref == 0) {
> +			removeq(&xnshm_allocq, &p->link);
>  			if (p->handle)
>  				xnregistry_remove(p->handle);
> +
> +			xnlock_put_irqrestore(&nklock, s);
> +
>  			if (p->heap == &kheap)
>  				xnheap_free(&kheap, p->chunk);
>  			else {
> -				/* Should release lock here? 
> -				 * Can destroy_mapped suspend ?
> -				 * [YES!]
> -				 */
>  #ifdef CONFIG_XENO_OPT_PERVASIVE
> -				xnheap_destroy_mapped(p->heap, NULL, NULL);
> +				xnheap_destroy_mapped(p->heap,
> +						      __heap_flush_shared,
> +						      NULL);
>  #else /* !CONFIG_XENO_OPT_PERVASIVE */
>  				xnheap_destroy(p->heap,
>  					       &__heap_flush_private, NULL);
> -#endif /* !CONFIG_XENO_OPT_PERVASIVE */
>  				xnheap_free(&kheap, p->heap);
> +#endif /* !CONFIG_XENO_OPT_PERVASIVE */
>  			}
> -			removeq(&xnshm_allocq, &p->link);
>  			ret = p->size;
>  			xnheap_free(&kheap, p);
> -			break;
> +
> +			return ret;
>  		}
>  
>  		holder = nextq(&xnshm_allocq, holder);
> @@ -311,7 +318,7 @@ static int _shm_free(unsigned long name)
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  int rt_shm_free(unsigned long name)
> 
-- 
Philippe.



