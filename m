From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1249509063.4762.84.camel@domain.hid>
References: <1249509063.4762.84.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 19:03:24 +0200
Message-Id: <1249578204.3809.221.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Alignment exception on powerpc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, 2009-08-05 at 17:51 -0400, Andreas Glatz wrote:
> Hi,
> 
> I'm running xenomai-2.4.8, Linux-2.6.26 on a MPC8360 PowerPC.
> 
> I enabled nucleus debugging and found out that tasks sometimes
> switch to secondary mode due to data alignment exceptions (#1536 ==
> 0x600):
> 
> <snip>
> Xenomai: Switching bgndT30_3 to secondary mode after exception #1536
> from user-space at 0x101013f4 (pid 3191)
> Xenomai: Switching bgndT30_3 to secondary mode after exception #1536
> from user-space at 0x101013f4 (pid 3191)
> ...
> </snip>
> 
> I know that we get those exceptions because we pass the -fpack-struct
> option to gcc and some data in structures are misaligned. It would
> be quite a lot of work to go through the code to change it so that 
> we don't have to pass the -fpack-struct option.
> 
> Is there a way to execute the exception handler from primary mode 
> to prevent the tasks to switch to secondary mode?

I have absolutely no freaking idea whether the following patch will
work, but you are welcome to feel lucky:

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 701fe3b..3efe546 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -917,7 +917,8 @@ void alignment_exception(struct pt_regs *regs)
 {
 	int sig, code, fixed = 0;
 
-	if (ipipe_trap_notify(IPIPE_TRAP_ALIGNMENT,regs))
+	if (test_bit(IPIPE_NOSTACK_FLAG, &ipipe_this_cpudom_var(status)) &&
+	    ipipe_trap_notify(IPIPE_TRAP_ALIGNMENT, regs))
 	    	return;
 
 	/* we don't implement logging of alignment exceptions */
@@ -930,6 +931,10 @@ void alignment_exception(struct pt_regs *regs)
 		return;
 	}
 
+	if (!ipipe_root_domain_p &&
+	    ipipe_trap_notify(IPIPE_TRAP_ALIGNMENT, regs))
+		return;
+
 	/* Operand address was bad */
 	if (fixed == -EFAULT) {
 		sig = SIGSEGV;

> 
> Best regards,
> Andreas
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



