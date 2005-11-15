Message-ID: <4379AC7B.8040500@domain.hid>
Date: Tue, 15 Nov 2005 10:38:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>
In-Reply-To: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] printk
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Dmitry Adamushko wrote:
>  > > ...
>  > >
>  > > This cannot happen in async mode, since the output would be 
> buffered and
>  > > printk() never called on behalf of the preempted handler.
>  > >
>  > >>
>  > >> let's say at the (*) point
>  > >>
>  > >> void __ipipe_flush_printk (unsigned virq)
>  > >> {
>  > >>       char *p = __ipipe_printk_buf;
>  > >>       int out = 0, len;
>  > >>
>  > >>       clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
>  > >>
>  > >>       while (out < __ipipe_printk_fill) {
>  > >>               len = strlen(p) + 1;
>  > >>               printk("%s",p);
>  > >>               p += len;
>  > >>               out += len;
>  > >>       }
>  > >> (*) <---------------------------- preempted
>  > >>       __ipipe_printk_fill = 0;
>  > >> }
>  > >>
>  > >> When linux gets controll back the virq continues its execution and
>  > >> sets __ipipe_printk_fill up to 0.
>  > >>
>  > >> This cannot happen only if virqs are manipulated with the primary
>  > >> domain being stalled as well. But you told "and under __Linux
>  > >> domain___ stalling protection in __ipipe_flush_printk since it's a
>  > >> virq handler".
>  > >>
>  > >>
>  > >>  > and finally, printk() cannot preempt
>  > >>  > __ipipe_flush_printk under normal operation mode (i.e. async 
> mode).
>  > >> AFAICS,
>  > >>  > there's no race here.
>  >
>  > Mea culpa, Dmitry is right, in the above situation he depicted, we
>  > could drop a
>  > portion of the output buffer. A way to fix this would be to hw lock
>  > a test and
>  > decrement section of __ipipe_printk_fill in the flush handler.
>  >
> 
> Something like that (just a draft) would work probably but I suppose 
> something a bit more graceful would be implemented. Actually, with a 
> small optimization of IPIPE_PRINTK_FLAG.
> 
> void __ipipe_flush_printk (unsigned virq)
> {
>       char *p = __ipipe_printk_buf;
> -       int out = 0, len;
> +       int out = 0, len, used;
> 
> ...
> -       clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
> ...
> 
> + spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
> + used = __ipipe_printk_fill;
> + spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
> 
> + oncemore:
> 
>       while (out < used) {
>               len = strlen(p) + 1;
>               printk("%s",p);
>               p += len;
>               out += len;
>       }
> 
> + spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
> + if (__ipipe_printk_fill == used)
> + {
> -       __ipipe_printk_fill = 0;
> 
> +     used = __ipipe_printk_fill = 0;
> 
> + // when everything is done
> +      clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
> 
> + }
> + else
> + used = __ipipe_printk_fill;
> + spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
> 
> + if (used)
> + goto oncemore;
> 
> ...
> }
> 
> and
> 
> asmlinkage int printk(const char *fmt, ...)
> {
> + int virq_is_active;
> ...
> 
>       spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
> 
>       fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;
> 
>       if (fbytes > 1) {
>               r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,
>                              fbytes, fmt, args) + 1; /* account for the 
> null byte */
>               __ipipe_printk_fill += r;
>       } else
>               r = 0;
> 
> + virq_is_active = 
> test_and_set_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
> 
>       spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
> 
> - if (!test_and_set_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags))
> +      if (!virq_is_active)
>               ipipe_trigger_irq(__ipipe_printk_virq);
> out:
>       va_end(args);
> 
>       return r;
> }
> 

Another approach is about dropping the non-atomic update sequence that hurts, tolerating 
null runs of the virq when the seldom preemption case is seen, but without requiring hw 
interrupt masking to protect the shared stuff. Livelocking Linux inside the virq handler 
would still be possible whenever the RT side spams the kernel log, but this would not be 
an issue for us, since there is no such thing as a fair real-time system anyway.

--- kernel/printk.c	2 Nov 2005 16:29:34 -0000	1.2
+++ kernel/printk.c	15 Nov 2005 09:11:33 -0000
@@ -511,24 +511,23 @@

  static ipipe_spinlock_t __ipipe_printk_lock = IPIPE_SPIN_LOCK_UNLOCKED;

-static int __ipipe_printk_fill;
+static atomic_t __ipipe_printk_fill;

  static char __ipipe_printk_buf[__LOG_BUF_LEN];

  void __ipipe_flush_printk (unsigned virq)
  {
  	char *p = __ipipe_printk_buf;
-	int out = 0, len;
+	int len;

-	clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
-
-	while (out < __ipipe_printk_fill) {
-		len = strlen(p) + 1;
-		printk("%s",p);
-		p += len;
-		out += len;
+	while (test_and_clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags)) {
+		while (atomic_read(&__ipipe_printk_fill) > 0) {
+			len = strlen(p) + 1;
+			printk("%s",p);
+			p += len;
+			atomic_sub(len,&__ipipe_printk_fill);
+		}
  	}
-	__ipipe_printk_fill = 0;
  }

  asmlinkage int printk(const char *fmt, ...)
@@ -548,12 +547,12 @@

  	spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);

-	fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;
+	fbytes = __LOG_BUF_LEN - atomic_read(&__ipipe_printk_fill);

  	if (fbytes > 1)	{
-		r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,
+		r = vscnprintf(__ipipe_printk_buf + atomic_read(&__ipipe_printk_fill),
  			       fbytes, fmt, args) + 1; /* account for the null byte */
-		__ipipe_printk_fill += r;
+		atomic_add(r,&__ipipe_printk_fill);
  	} else
  		r = 0;

-- 

Philippe.

