From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1254853590.3718.28.camel@domain.hid>
References: <4AC2448B.1080500@domain.hid>
	<1254396765.2703.234.camel@domain.hid>  <4AC62883.1080908@domain.hid>
	<1254505304.2703.347.camel@domain.hid>
	<1254506494.8199.46.camel@domain.hid>
	<1254510029.2703.355.camel@domain.hid>
	<1254853590.3718.28.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 06 Oct 2009 22:10:56 +0200
Message-Id: <1254859856.2784.251.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: 2.5 todo list.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Tue, 2009-10-06 at 14:26 -0400, Andreas Glatz wrote:
> On Fri, 2009-10-02 at 21:00 +0200, Philippe Gerum wrote:
> > On Fri, 2009-10-02 at 14:01 -0400, Andreas Glatz wrote:
> > > > 
> > > > - powerpc32 updates for 2.6.30. Mainly to merge the once experimental
> > > > bits that prevent most alignment faults from triggering a secondary mode
> > > > switch. Andreas told me this works like a charm on 83xx, and I did not
> > > > see any issue on 52xx, 85xx or 86xx either.
> > > > 
> > > 
> > > Can I get a version of that patch for testing? Is it in your git
> > > repository?
> > 
> > I just pushed this commit to my remote tree (ipipe-2.6.30-powerpc
> > branch); it should appear in a few hours once mirrored (cron job).
> > 
> 
> I finally had a chance to test the ipipe-2.6.30-powerpc version
> from the git repository. Unfortunately, I noticed that our application
> dies after some time and that this behaviour is related to that 
> alignment patch (if I take it out everything runs fine for > 2 days).
> 
> Currently I'm investigating the reasons for that crash. It has
> something to do with floating point registers not being restored
> properly. Our alignment exceptions are mainly triggered by accesses 
> to unaligned floating point data.

Does it work any better with this patch in?

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 32cc3df..a04a5e3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -80,7 +80,9 @@ void flush_fp_to_thread(struct task_struct *tsk)
 		 * FPU, and then when we get scheduled again we would store
 		 * bogus values for the remaining FP registers.
 		 */
-		ipipe_preempt_disable(flags);
+		if (ipipe_root_domain_p)
+			preempt_disable();
+		local_irq_save_hw_cond(flags);
 		if (tsk->thread.regs->msr & MSR_FP) {
 #ifdef CONFIG_SMP
 			/*
@@ -94,7 +96,9 @@ void flush_fp_to_thread(struct task_struct *tsk)
 #endif
 			giveup_fpu(tsk);
 		}
- 		ipipe_preempt_enable(flags);
+		local_irq_restore_hw_cond(flags);
+		if (ipipe_root_domain_p)
+			preempt_enable();
 	}
 }
 

> 
> Andreas
-- 
Philippe.



