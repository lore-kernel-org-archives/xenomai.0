MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fvLxlVi6l7"
Content-Transfer-Encoding: 7bit
Message-ID: <17882.10558.579029.893183@domain.hid>
Date: Mon, 19 Feb 2007 23:48:30 +0100
In-Reply-To: <1171560346.24117.77.camel@domain.hid>
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>
	<45D46704.9050109@domain.hid> <1171560346.24117.77.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>


--fvLxlVi6l7
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > On Thu, 2007-02-15 at 14:58 +0100, Jan Kiszka wrote:
 > > Philippe Gerum wrote:
 > > > On Thu, 2007-02-15 at 14:06 +0100, Jan Kiszka wrote:
 > > >> Hi all,
 > > >>
 > > >> I think I found another unwanted side-effect of the no-cow changes:
 > > >>
 > > >> With the I-pipe 1.7 patch series the test for missing mlockall no longer
 > > >> works. I just - once again - wrote a test program that was lacking this
 > > >> call, but only with I-pipe 1.6-06 (same Xenomai version: latest trunk) I
 > > >> get the usual error message on startup.
 > > >>
 > > > 
 > > > I can't reproduce this with 1.7-01 here. Which Xenomai codebase are you
 > > > currently using (trunk/, 2.3.x maintenance or stock 2.3)?
 > > 
 > > Specifically trunk, but the first observation was over 2.3.x
 > > maintenance. The test code is using the posix skin.
 > 
 > I still don't find any explanation for that behaviour, only trivially
 > testing with and without mlockall() in a bare main routine though.
 > 
 > In relation to this, I've rolled out 1.7-02/x86, so that we could close
 > the last pending issue(s) holding v2.3.1 wrt the interrupt pipeline
 > support. Specifically, the -nocow related changes have been amended, and
 > we are now back to the implementation that prevailed in the 1.6 series
 > wrt vmalloc and ioremap memory, while still retaining the ability to
 > break COW eagerly for the RT threads.
 > 
 > Feedback welcome on this.

Here comes yet another amendment of the nocow patch, which avoid a race
between pgd_alloc creating a new pgd, and __ipipe_pin_range_globally not
seeing the new pgd because its task is not yet in the task
list. Unfortunately, __ipipe_pin_range_globally becomes an architecture
dependent function, but at least we should have no race. The patch also
fixes the issue with munlockall not clearing the VM_LOCKED flag.

-- 


					    Gilles Chanteperdrix.

--fvLxlVi6l7
Content-Type: text/plain
Content-Disposition: inline;
	filename="ipipe-avoid-race.diff"
Content-Transfer-Encoding: 7bit

diff -x '*~' -x '*.orig' -x '*.rej' -Naurdp ipipe-2.6.20-x86/arch/i386/mm/fault.c ipipe-2.6.20-x86-avoid-race/arch/i386/mm/fault.c
--- ipipe-2.6.20-x86/arch/i386/mm/fault.c	2007-02-19 22:33:58.000000000 +0100
+++ ipipe-2.6.20-x86-avoid-race/arch/i386/mm/fault.c	2007-02-19 22:39:34.000000000 +0100
@@ -656,16 +656,20 @@ void vmalloc_sync_all(void)
 #endif
 
 #ifdef CONFIG_IPIPE
-int __ipipe_pin_range_mapping(struct mm_struct *mm,
-			      unsigned long start, unsigned long end)
+void __ipipe_pin_range_globally(unsigned long start, unsigned long end)
 {
 	unsigned long next, addr = start;
 
 	do {
+		unsigned long flags;
+		struct page *page;
+
 		next = pgd_addr_end(addr, end);
-		vmalloc_sync_one(mm->pgd, addr);
-	} while (addr = next, addr != end);
+		spin_lock_irqsave(&pgd_lock, flags);
+		for (page = pgd_list; page; page = (struct page *)page->index)
+			vmalloc_sync_one(page_address(page), addr);
+		spin_unlock_irqrestore(&pgd_lock, flags);
 
-	return 0;
+	} while (addr = next, addr != end);
 }
 #endif /* CONFIG_IPIPE */
diff -x '*~' -x '*.orig' -x '*.rej' -Naurdp ipipe-2.6.20-x86/include/linux/ipipe.h ipipe-2.6.20-x86-avoid-race/include/linux/ipipe.h
--- ipipe-2.6.20-x86/include/linux/ipipe.h	2007-02-19 22:33:58.000000000 +0100
+++ ipipe-2.6.20-x86-avoid-race/include/linux/ipipe.h	2007-02-19 22:39:56.000000000 +0100
@@ -337,11 +337,6 @@ void fastcall __ipipe_sync_stage(unsigne
 
 void __ipipe_pin_range_globally(unsigned long start, unsigned long end);
 
-struct mm_struct;
-
-int __ipipe_pin_range_mapping(struct mm_struct *mm,
-			      unsigned long start, unsigned long end);
-
 #ifndef __ipipe_sync_pipeline
 #define __ipipe_sync_pipeline(syncmask) __ipipe_sync_stage(syncmask)
 #endif
@@ -695,7 +690,7 @@ int ipipe_disable_ondemand_mappings(stru
 #define ipipe_cleanup_notify(mm)	do { } while(0)
 #define ipipe_trap_notify(t,r)	0
 #define ipipe_init_proc()		do { } while(0)
-#define __ipipe_update_all_pinned_mm(start, end) 0
+#define __ipipe_pin_range_globally(start, end) do { } while(0)
 
 #define local_irq_enable_hw_cond()		do { } while(0)
 #define local_irq_disable_hw_cond()		do { } while(0)
diff -x '*~' -x '*.orig' -x '*.rej' -Naurdp ipipe-2.6.20-x86/mm/memory.c ipipe-2.6.20-x86-avoid-race/mm/memory.c
--- ipipe-2.6.20-x86/mm/memory.c	2007-02-19 22:33:58.000000000 +0100
+++ ipipe-2.6.20-x86-avoid-race/mm/memory.c	2007-02-19 22:41:06.000000000 +0100
@@ -2808,21 +2808,6 @@ int ipipe_disable_ondemand_mappings(stru
 	}
 	mm->def_flags |= VM_PINNED;
 
-	read_lock(&vmlist_lock);
-	for (area = vmlist; area; area = area->next) {
-		result =  __ipipe_pin_range_mapping(mm,
-						    (unsigned long) area->addr,
-						    (unsigned long) area->addr
-						    + area->size);
-		if (result) {
-			mm->def_flags &= ~VM_PINNED;
-			read_unlock(&vmlist_lock);
-			goto done_mm;
-		}
-	}
-
-	read_unlock(&vmlist_lock);
-
   done_mm:
 	up_write(&mm->mmap_sem);
 	mmput(mm);
@@ -2830,18 +2815,4 @@ int ipipe_disable_ondemand_mappings(stru
 }
 
 EXPORT_SYMBOL(ipipe_disable_ondemand_mappings);
-
-void __ipipe_pin_range_globally(unsigned long start, unsigned long end)
-{
-	struct task_struct *p;
-
-	read_lock(&tasklist_lock);
-
-	for_each_process(p)
-		if (p->mm)
-			__ipipe_pin_range_mapping(p->mm, start, end);
-
-	read_unlock(&tasklist_lock);
-}
-
 #endif
diff -x '*~' -x '*.orig' -x '*.rej' -Naurdp ipipe-2.6.20-x86/mm/mlock.c ipipe-2.6.20-x86-avoid-race/mm/mlock.c
--- ipipe-2.6.20-x86/mm/mlock.c	2007-02-19 22:33:58.000000000 +0100
+++ ipipe-2.6.20-x86-avoid-race/mm/mlock.c	2007-02-19 23:39:41.000000000 +0100
@@ -166,6 +166,7 @@ static int do_mlockall(int flags)
 
 	if (flags & MCL_FUTURE)
 		def_flags = VM_LOCKED;
+	current->mm->def_flags &= ~VM_LOCKED;
 	current->mm->def_flags |= def_flags;
 	if (flags == MCL_FUTURE)
 		goto out;

--fvLxlVi6l7--

