Message-ID: <45DEF122.2060406@domain.hid>
Date: Fri, 23 Feb 2007 14:50:26 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DEE913.9080809@domain.hid>
In-Reply-To: <45DEE913.9080809@domain.hid>
Content-Type: multipart/mixed; boundary="------------090803040400030507030505"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------090803040400030507030505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles,

>> I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-svn-2007-02-22
>> on an AT91RM9200 (160MHz/80MHz).
>>
>> When starting "latency -p 200" it runs for a while printing
>>
>> RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
>> RTD|      11.200|     139.200|     236.800|       1|      10.800|     280.800
>>
>> but then hangs. The timer LED stops blinking. No "soft lockup detected" appears.
> 
> The only explanation I have is that the period is too small. I do not
> observe the same behaviour with latency -p 1000. Note that setting the
> period to a value comparable to the latency is not considered a normal
> use of Xenomai. 

Sure but I would still not expect the system to hang!
As I said missing a deadline is bad but ok.
But hanging the whole system is not quite ok.

>> Using a BDI200 it looks like that in kernel/sched.c:schedule() he is returning
>> in the lines
>>
>> #ifdef CONFIG_IPIPE
>>         if (unlikely(!ipipe_root_domain_p))
>>                 return;
>> #endif /* CONFIG_IPIPE */
>>
>> When stepping trough I only see him getting into schedule() but leaving
>> it in the above lines and in include/linux/proc_fs.h:proc_net_fops_create() ...
> 
> Ok. Thanks for pointing this out. That is interesting, but not very
> informative. It would be interesting if you could get the full
> backtrace. What would be also interesting would be to set a break point
> on the timer interrupt handler and to follow what happens from timer
> interrupt to timer interrupt.

I tried! Attached the patch I used. Since teh scheduler hangs I can't use normal printk(), right?

*ipipe_current_domain != ipipe_root_domain !
*ipipe_current_domain = c01fc2c0
*ipipe_root_domain    = c01af2c0

But I don't get the output of __backtrace()!

my_printk() works with __backtrace(). The dump of a soft lockup works.


Steven


--------------090803040400030507030505
Content-Type: text/x-patch;
 name="debug-xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug-xenomai.patch"

Index: linux-2.6.19/arch/arm/lib/backtrace.S
===================================================================
--- linux-2.6.19.orig/arch/arm/lib/backtrace.S
+++ linux-2.6.19/arch/arm/lib/backtrace.S
@@ -100,7 +100,7 @@ ENTRY(c_backtrace)
  */
 1007:		ldr	r0, =.Lbad
 		mov	r1, frame
-		bl	printk
+		bl	my_printk
 		ldmfd	sp!, {r4 - r8, pc}
 		.ltorg
 		
@@ -134,12 +134,12 @@ ENTRY(c_backtrace)
 		ldr	r2, [stack], #-4
 		mov	r1, reg
 		adr	r0, .Lfp
-		bl	printk
+		bl	my_printk
 2:		subs	reg, reg, #1
 		bpl	1b
 		teq	r7, #0
 		adrne	r0, .Lcr
-		blne	printk
+		blne	my_printk
 		mov	r0, stack
 		ldmfd	sp!, {instr, reg, stack, r7, r8, pc}
 
Index: linux-2.6.19/include/linux/kernel.h
===================================================================
--- linux-2.6.19.orig/include/linux/kernel.h
+++ linux-2.6.19/include/linux/kernel.h
@@ -146,6 +146,12 @@ asmlinkage int vprintk(const char *fmt, 
 	__attribute__ ((format (printf, 1, 0)));
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+
+
+asmlinkage int my_printk(const char * fmt, ...)
+        __attribute__ ((format (printf, 1, 2)));
+
+
 #else
 static inline int vprintk(const char *s, va_list args)
 	__attribute__ ((format (printf, 1, 0)));
Index: linux-2.6.19/kernel/printk.c
===================================================================
--- linux-2.6.19.orig/kernel/printk.c
+++ linux-2.6.19/kernel/printk.c
@@ -524,6 +524,21 @@ void __ipipe_flush_printk (unsigned virq
 	spin_unlock_irqrestore(&__ipipe_printk_lock, flags);
 }
 
+/*FIXME*/
+extern void printascii(const char *);
+asmlinkage int my_printk(const char *fmt, ...)
+{
+        va_list va;
+        char buff[256];
+
+        va_start(va, fmt);
+        vsprintf(buff, fmt, va);
+        va_end(va);
+
+        printascii(buff);
+	return 0;
+}
+
 asmlinkage int printk(const char *fmt, ...)
 {
 	int r, fbytes, oldcount;
Index: linux-2.6.19/kernel/sched.c
===================================================================
--- linux-2.6.19.orig/kernel/sched.c
+++ linux-2.6.19/kernel/sched.c
@@ -3327,8 +3327,14 @@ asmlinkage void __sched schedule(void)
 	struct rq *rq;
 
 #ifdef CONFIG_IPIPE
-	if (unlikely(!ipipe_root_domain_p))
+	if (unlikely(!ipipe_root_domain_p)) {
+		my_printk("ipipe_current_domain != ipipe_root_domain !\n");
+		my_printk("ipipe_current_domain = %p\n", ipipe_current_domain);
+		my_printk("ipipe_root_domain    = %p\n", ipipe_root_domain);
+		__backtrace();
+		while (1) { barrier();};
 		return;
+	}
 #endif /* CONFIG_IPIPE */
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into


--------------090803040400030507030505--

