Subject: Re: [Adeos-main] [PATCH] cleanup unused EXPORTs
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45803953.7020608@domain.hid>
References: <45803953.7020608@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 21:46:53 +0100
Message-Id: <1166129213.23946.156.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Wed, 2006-12-13 at 18:33 +0100, Jan Kiszka wrote:
> As I'm unable to find any modular users of the symbols below, I suggest
> to remove the EXPORTs and make __ipipe_pipelock static.

Looks ok. I've queued this for the next release. Thanks.

> 
> Jan
> plain text document attachment (cleanup-exports.patch)
> ---
>  include/linux/ipipe.h |    2 --
>  kernel/ipipe/core.c   |    7 +------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> Index: linux-2.6.19-ipipe/include/linux/ipipe.h
> ===================================================================
> --- linux-2.6.19-ipipe.orig/include/linux/ipipe.h
> +++ linux-2.6.19-ipipe/include/linux/ipipe.h
> @@ -241,8 +241,6 @@ extern unsigned long __ipipe_virtual_irq
>  
>  extern struct list_head __ipipe_pipeline;
>  
> -extern ipipe_spinlock_t __ipipe_pipelock;
> -
>  extern int __ipipe_event_monitors[];
>  
>  /* Private interface */
> Index: linux-2.6.19-ipipe/kernel/ipipe/core.c
> ===================================================================
> --- linux-2.6.19-ipipe.orig/kernel/ipipe/core.c
> +++ linux-2.6.19-ipipe/kernel/ipipe/core.c
> @@ -47,7 +47,7 @@ struct ipipe_domain ipipe_root =
>  DEFINE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain) =
>  	{ &ipipe_root };
>  
> -ipipe_spinlock_t __ipipe_pipelock = IPIPE_SPIN_LOCK_UNLOCKED;
> +static IPIPE_DEFINE_SPINLOCK(__ipipe_pipelock);
>  
>  LIST_HEAD(__ipipe_pipeline);
>  
> @@ -1396,12 +1396,7 @@ EXPORT_SYMBOL(__ipipe_restore_root);
>  EXPORT_SYMBOL(__ipipe_test_and_stall_root);
>  EXPORT_SYMBOL(__ipipe_test_root);
>  EXPORT_SYMBOL(__ipipe_dispatch_event);
> -EXPORT_SYMBOL(__ipipe_dispatch_wired);
> -EXPORT_SYMBOL(__ipipe_sync_stage);
>  EXPORT_SYMBOL(__ipipe_pipeline);
> -EXPORT_SYMBOL(__ipipe_pipelock);
> -EXPORT_SYMBOL(__ipipe_virtual_irq_map);
> -
>  EXPORT_SYMBOL(ipipe_register_domain);
>  EXPORT_SYMBOL(ipipe_unregister_domain);
>  EXPORT_SYMBOL(ipipe_free_virq);
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



