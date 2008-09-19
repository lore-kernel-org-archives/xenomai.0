Message-ID: <48D3A905.2030006@domain.hid>
Date: Fri, 19 Sep 2008 15:28:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48D35457.3080002@domain.hid>
In-Reply-To: <48D35457.3080002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] xnpod_shutdown calls xnheap_destroy under
 nklock
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> my ipipe patch to detect stalled top-most domains (a new, NMI-safe
> version will be posted soon) just reported this:
> 
> [    1.853028] Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> [    2.059367] I-pipe: Detected stalled topmost domain, probably caused by a bug.
> [    2.059374]         A critical section may have been left unterminated.
> [    2.062011] Pid: 1, comm: swapper Not tainted 2.6.26.2-xeno_64 #104
> [    2.073041]
> [    2.073044] Call Trace:
> [    2.077168]  [<ffffffff8026b61b>] ipipe_check_context+0x11e/0x128
> [    2.082210]  [<ffffffff802dc017>] kfree+0x2f/0x16d
> [    2.085840]  [<ffffffff8021ed3c>] ? mcount+0x4c/0x72
> [    2.088885]  [<ffffffff802783cb>] xnpod_flush_heap+0x21/0x23
> [    2.091872]  [<ffffffff802722e7>] xnheap_destroy+0xf7/0x1d7
> [    2.094588]  [<ffffffff802783aa>] ? xnpod_flush_heap+0x0/0x23
> [    2.097506]  [<ffffffff8027b47f>] xnpod_shutdown+0x455/0x4b2
> [    2.100424]  [<ffffffff8027bfa4>] xnpod_init+0x67b/0x693
> [    2.102294]  [<ffffffff8028a79b>] ? __native_skin_init+0x0/0x4b1
> [    2.104568]  [<ffffffff8021ed3c>] ? mcount+0x4c/0x72
> [    2.106990]  [<ffffffff8028a79b>] ? __native_skin_init+0x0/0x4b1
> [    2.110175]  [<ffffffff8028a916>] __native_skin_init+0x17b/0x4b1
> [    2.113045]  [<ffffffff80673d92>] ? __xeno_sys_init+0x0/0x1f5
> [    2.115085]  [<ffffffff8028a79b>] ? __native_skin_init+0x0/0x4b1
> [    2.117921]  [<ffffffff80661733>] kernel_init+0x14a/0x2c3
> [    2.120883]  [<ffffffff8026ceba>] ? __ipipe_unstall_root+0x5d/0x60
> [    2.124031]  [<ffffffff8020d1a8>] child_rip+0xa/0x12
> [    2.126421]  [<ffffffff806615e9>] ? kernel_init+0x0/0x2c3
> [    2.129678]  [<ffffffff8020d19e>] ? child_rip+0x0/0x12
> [    2.132379]
> [    2.133128] I-pipe tracer log (100 points):
> [    2.134933]  |  *+func                    0 ipipe_trace_panic_freeze+0xe (ipipe_check_context+0xab)
> [    2.140021]  |  *+func                    0 find_next_bit+0x9 (__next_cpu+0x1e)
> [    2.142709]  |  *+func                    0 __next_cpu+0x9 (ipipe_check_context+0x9f)
> [    2.145600]  |  *+func                    0 find_next_bit+0x9 (__next_cpu+0x1e)
> [    2.148697]  |  *+func                   -1 __next_cpu+0x9 (ipipe_check_context+0x9f)
> [    2.152682]  |  *+func                   -1 find_first_bit+0x9 (__first_cpu+0x13)
> [    2.156781]  |  *+func                   -1 __first_cpu+0x9 (ipipe_check_context+0x79)
> [    2.161291]  |  *+func                   -1 ipipe_check_context+0xc (kfree+0x2f)
> [    2.165331]  |  *+func                   -2 kfree+0x16 (xnpod_flush_heap+0x21)
> [    2.168946]  |  *+func                   -2 xnpod_flush_heap+0x9 (xnheap_destroy+0xf7)
> [    2.172562]  |  *+func                   -3 xnheap_destroy+0x16 (xnpod_shutdown+0x455)
> [    2.176912]  |   +begin   0x80000000     -4 xnpod_shutdown+0x3c9 (xnpod_init+0x67b)
> 
> 
> Granted, it's an error path, but it remains a bug from the conceptional
> POV. Can't we safely drop the locking around the two xnheap_destroys in
> xnpod_shutdown?
>

Yes, that would be safe.

> Jan
> 
> ---
> 
> Index: xenomai/ksrc/nucleus/pod.c
> ===================================================================
> --- xenomai/ksrc/nucleus/pod.c	(Revision 4173)
> +++ xenomai/ksrc/nucleus/pod.c	(Arbeitskopie)
> @@ -472,8 +472,10 @@ void xnpod_shutdown(int xtype)
>  
>  	xnlock_get_irqsave(&nklock, s);
>  
> -	if (!xnpod_active_p() || --nkpod->refcnt != 0)
> -		goto unlock_and_exit;	/* No-op */
> +	if (!xnpod_active_p() || --nkpod->refcnt != 0) {
> +		xnlock_put_irqrestore(&nklock, s);
> +		return;	/* No-op */
> +	}
>  
>  	/* FIXME: We must release the lock before disabling the time
>  	   source, so we accept a potential race due to another skin
> @@ -522,17 +524,11 @@ void xnpod_shutdown(int xtype)
>  
>  	xnarch_notify_halt();
>  
> -	xnlock_get_irqsave(&nklock, s);
> -
>  	xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
>  
>  #if CONFIG_XENO_OPT_SYS_STACKPOOLSZ > 0
>  	xnheap_destroy(&kstacks, &xnpod_flush_stackpool, NULL);
>  #endif
> -
> -      unlock_and_exit:
> -
> -	xnlock_put_irqrestore(&nklock, s);
>  }
>  
>  static inline void xnpod_fire_callouts(xnqueue_t *hookq, xnthread_t *thread)
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.


