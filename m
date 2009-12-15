From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B1CCE12.4080106@domain.hid>
References: <4B1CCE12.4080106@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Dec 2009 17:54:23 +0100
Message-ID: <1260896063.2216.172.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Fwd: Re: [Xenomai-help] How to fix t_delete
 call in psos skin?]
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-12-07 at 10:42 +0100, Fabrice Gasnier wrote:
> Hello,
> 
> I come back to you to submit a slightly different patch.
> I observed that __psos_t_delete sometimes returns ERR_OBJID after 
> pthread_cancel has been issued, due to thread isn't found on kernel side.
> The attached patch uses the same mechanism as in native API 
> (rt_task_delete) where equivalent error is being filtered.
> 

Correct.

> Please find attached this patch (formated with git format-patch origin).
> 
> If it's looks like ok on your side, do you think this patch can be 
> integrated in xenomai project?
> 

Yes, this patch makes sense. Time for nitpicking now:


+	#ifdef CONFIG_XENO_OPT_PERVASIVE
+    u_long pthread; /* hidden pthread_t identifier. */
+	#endif
+

Preprocessor statements should start at column 1.

+	if (!__xn_access_ok(curr, VERIFY_READ, bulk.a1, sizeof(name))) {
+		return -EFAULT;
+	}

Single executable statement in conditional needs no braces.

@@ -99,7 +107,10 @@ static int __t_create(struct task_struct *curr,
struct pt_regs *regs)
 		 * about the new thread id, so we can manipulate its
 		 * TCB pointer freely. */
 		tid = xnthread_handle(&task->threadbase);
-		__xn_copy_to_user(curr, (void __user *)__xn_reg_arg4(regs), &tid,
+		#ifdef CONFIG_XENO_OPT_PERVASIVE
+		task->pthread = bulk.a5; /* hidden pthread_t identifier. */
+		#endif

Same as above regarding the indentation, but most importantly, testing
CONFIG_OPT_XENO_PERVASIVE is redundant, since this file is only compiled
when in pervasive mode.

+		#ifdef CONFIG_XENO_OPT_PERVASIVE
+		pthread = task->pthread; /* hidden pthread_t identifier. */
+		#endif

Same as above.

Additionally, please make sure to prefix the commit message with the
sub-system impacted, i.e. psos in this case, and be more descriptive
regarding to the fix involved.

E.g.
git commit -a -m "psos: send pthread_cancel() upon t_delete"


-- 
Philippe.



