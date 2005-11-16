Message-ID: <437B2D05.6070003@domain.hid>
Date: Wed, 16 Nov 2005 13:58:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OF53595BAB.2AA49C4A-ONC12570BA.0035EF11-C12570BA.0036F2D4@domain.hid>
In-Reply-To: <OF53595BAB.2AA49C4A-ONC12570BA.0035EF11-C12570BA.0036F2D4@domain.hid>
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
> please see comments below...
>
>  >
>  > Another approach is about dropping the non-atomic update sequence
>  > that hurts, tolerating
>  > null runs of the virq when the seldom preemption case is seen, but
>  > without requiring hw
>  > interrupt masking to protect the shared stuff. Livelocking Linux
>  > inside the virq handler
>  > would still be possible whenever the RT side spams the kernel log,
>  > but this would not be
>  > an issue for us, since there is no such thing as a fair real-time
>  > system anyway.
>  >
>  > --- kernel/printk.c   2 Nov 2005 16:29:34 -0000   1.2
>  > +++ kernel/printk.c   15 Nov 2005 09:11:33 -0000
>  > @@ -511,24 +511,23 @@
>  >
>  >   static ipipe_spinlock_t __ipipe_printk_lock = IPIPE_SPIN_LOCK_UNLOCKED;
>  >
>  > -static int __ipipe_printk_fill;
>  > +static atomic_t __ipipe_printk_fill;
>  >
>  >   static char __ipipe_printk_buf[__LOG_BUF_LEN];
>  >
>  >   void __ipipe_flush_printk (unsigned virq)
>  >   {
>  >      char *p = __ipipe_printk_buf;
>  > -   int out = 0, len;
>  > +   int len;
>  >
>  > -   clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
>  > -
>  > -   while (out < __ipipe_printk_fill) {
>  > -      len = strlen(p) + 1;
>  > -      printk("%s",p);
>  > -      p += len;
>  > -      out += len;
>  > +   while
> (test_and_clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags)) {
>  > +      while (atomic_read(&__ipipe_printk_fill) > 0) {
>  > +         len = strlen(p) + 1;
>  > +         printk("%s",p);
>  > +         p += len;
>
>  > +         atomic_sub(len,&__ipipe_printk_fill);
>
> But that's wrong. __ipipe_printk_fill is used as an index in printk()
> and here you use it as a number of bytes still need to be printed.
>

Ok, this kind of stuff should always be designed with the brain turned on. Now
that I have eventually found the power switch, I'm going to fix the printk issue
in the Adeos core along the following lines. The code below basically reworks
your proposal. The construct is still a bit hairy, but unfortunately, we cannot
just go for using a plain atomic compare-and-exchange op in the virq handler,
since we need to serialize its activation among all CPUs - sigh... We also get rid
of PPRINTK - which is redundant - in the same move.

--- ipipe/v2.6/2.6.14/kernel/printk.c	2 Nov 2005 16:29:34 -0000	1.2
+++ ipipe/v2.6/2.6.14/kernel/printk.c	16 Nov 2005 12:18:09 -0000
@@ -518,23 +518,34 @@
  void __ipipe_flush_printk (unsigned virq)
  {
  	char *p = __ipipe_printk_buf;
-	int out = 0, len;
+	int len, lmax, out = 0;
+	unsigned long flags;

-	clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
+	goto start;

-	while (out < __ipipe_printk_fill) {
-		len = strlen(p) + 1;
-		printk("%s",p);
-		p += len;
-		out += len;
+	do {
+		spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
+ start:
+		lmax = __ipipe_printk_fill;
+		while (out < lmax) {
+			len = strlen(p) + 1;
+			printk("%s",p);
+			p += len;
+			out += len;
+		}
+		spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
  	}
+	while (__ipipe_printk_fill != lmax);
+
  	__ipipe_printk_fill = 0;
+
+	spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
  }

  asmlinkage int printk(const char *fmt, ...)
  {
-	unsigned long flags;
-	int r, fbytes;
+	int r, fbytes, oldcount;
+    	unsigned long flags;
  	va_list args;

  	va_start(args, fmt);
@@ -548,7 +559,8 @@

  	spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);

-	fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;
+	oldcount = __ipipe_printk_fill;
+	fbytes = __LOG_BUF_LEN - oldcount;

  	if (fbytes > 1)	{
  		r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,
@@ -559,7 +571,7 @@

  	spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);

-	if (!test_and_set_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags))
+	if (oldcount == 0)
  		ipipe_trigger_irq(__ipipe_printk_virq);
  out:
  	va_end(args);
-- 

Philippe.



