From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200704201143.01336.jweber@domain.hid>
References: <200704161449.27506.jweber@domain.hid>
	<200704170821.10282.jweber@domain.hid>
	<17957.7492.656703.120363@domain.hid>
	<200704201143.01336.jweber@domain.hid>
Content-Type: text/plain
Date: Fri, 20 Apr 2007 19:24:51 +0200
Message-Id: <1177089891.6466.24.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] page faults
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

On Fri, 2007-04-20 at 11:43 -0500, Jeff Weber wrote:
> On Tuesday 17 April 2007 14:17, Gilles Chanteperdrix wrote:
> > Jeff Weber wrote:
> >  > On Monday 16 April 2007 16:34, Gilles Chanteperdrix wrote:
> >  > > Jeff Weber wrote:
> >  > >  > On Monday 16 April 2007 15:43, Gilles Chanteperdrix wrote:
> >  > >  > > If the fault you observe is due to an access to some memory after
> >  > >  > > a call to fork or one of its derivative (such as system, popen,
> >  > >  > > etc...), the patch would have copied the whole real-time process
> >  > >  > > address space at fork time instead of setting up COW mappings.
> >  > >  >
> >  > >  > No process forks are involved.  Though mlockall() was called from
> >  > >  > Linux main(), and the page fault was encountered by a separate
> >  > >  > Xenomai task. Here's the task history:
> >  > >
> >  > > The fork may well be hidden in some library. The best way to know if
> >  > > there is really no fork is to register a callback with pthread_atfork.
> >  >
> >  > pthread_atfork confirms that there is no fork.
> >
> > Ok. I am afraid you will have to help us a bit. Could you try Xenomai
> > 2.3.1 in case the nocow patch magically solves your issue ?
> Indeed, stepping up to:
> 
> linux-2.6.20.3
> xenomai-2.3.1
> ipipe-1.7-03
> 
> magically solved my page faults.

Ok, so some memory which was referred to must have been lying in a COWed
shared VM page, since what 1.7-03 does is that it eagerly breaks COW for
all the virtual memory space available to real-time threads.

In case you really, really, really don't want to upgrade to 2.3.x for
product maintenance issues (albeit I would really, really, really
recommend it, because there are really, really, really nice improvements
there over 2.2.x), I've crafted a quick patch to disable ondemand VM
mappings with older Xenomai revs using recent I-pipe patches. IOW, this
patch against v2.2.x should allow you to run the latter over I-pipe
1.7-03, and make use of its COW-breaking feature (uncompiled, untested).

--- include/asm-generic/hal.h	(revision 2323)
+++ include/asm-generic/hal.h	(working copy)
@@ -304,6 +304,13 @@
 #define PF_EVNOTIFY  0
 #endif	/* !PF_EVNOTIFY */
 
+#ifdef VM_PINNED
+#define rthal_disable_ondemand_mappings(tsk)   ipipe_disable_ondemand_mappings(tsk)
+#else /* !VM_PINNED */
+/* In case the I-pipe does not allow disabling ondemand mappings. */
+#define rthal_disable_ondemand_mappings(tsk)   (0)
+#endif	/* !VM_PINNED */
+
 #ifdef CONFIG_KGDB
 #define rthal_set_foreign_stack(ipd)	ipipe_set_foreign_stack(ipd)
 #define rthal_clear_foreign_stack(ipd)	ipipe_clear_foreign_stack(ipd)
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 2323)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -828,6 +828,14 @@
 			thread->name, current->pid,
 			xnthread_base_priority(thread));
 
+#ifdef CONFIG_MMU
+	if (!(current->mm->def_flags & VM_LOCKED))
+		send_sig(SIGXCPU, current, 1);
+	else
+		if ((err = rthal_disable_ondemand_mappings(current)))
+			return err;
+#endif /* CONFIG_MMU */
+
 	/* Switch on propagation of normal kernel events for the bound
 	   task. This is basically a per-task event filter which
 	   restricts event notifications (e.g. syscalls) to tasks
@@ -836,11 +844,6 @@
 	   plain (i.e. non-Xenomai) Linux tasks. */
 	current->flags |= PF_EVNOTIFY;
 
-#ifdef CONFIG_MMU
-	if (!(current->mm->def_flags & VM_LOCKED))
-		send_sig(SIGXCPU, current, 1);
-#endif /* CONFIG_MMU */
-
 	current->cap_effective |=
 	    CAP_TO_MASK(CAP_IPC_LOCK) |
 	    CAP_TO_MASK(CAP_SYS_RAWIO) | CAP_TO_MASK(CAP_SYS_NICE);
-- 
Philippe.



