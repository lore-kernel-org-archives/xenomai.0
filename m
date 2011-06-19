Message-ID: <4DFDF2E1.1060106@domain.hid>
Date: Sun, 19 Jun 2011 15:00:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid> <4DFDCBEA.6010905@domain.hid>
	<4DFDDAB8.4090709@domain.hid>
In-Reply-To: <4DFDDAB8.4090709@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/19/2011 01:17 PM, Gilles Chanteperdrix wrote:
> On 06/19/2011 12:14 PM, Gilles Chanteperdrix wrote:
>> I am working on this ppd cleanup issue again, I am asking for help to
>> find a fix in -head for all cases where the sys_ppd is needed during
>> some cleanup.
>>
>> The problem is that when the ppd cleanup is invoked:
>> - we have no guarantee that current is a thread from the Xenomai
>> application;
>> - if it is, current->mm is NULL.
>>
>> So, associating the sys_ppd to either current or current->mm does not
>> work. What we could do is pass the sys_ppd to all the other ppds cleanup
>> handlers, this would fix cases such as freeing mutexes fastlock, but
>> that does not help when the sys_ppd is needed during a thread deletion hook.
>>
>> I would like to find a solution where simply calling xnsys_ppd_get()
>> will work, where we do not have an xnsys_ppd_get for each context, such
>> as for instance xnsys_ppd_get_by_mm/xnsys_ppd_get_by_task_struct,
>> because it would be too error-prone.
>>
>> Any idea anyone?
> 
> The best I could come up with: use a ptd to store the mm currently 
> being cleaned up, so that xnshadow_ppd_get continues to work, even
> in the middle of a cleanup.

In order to also get xnshadow_ppd_get to work in task deletion hooks 
(which is needed to avoid the issue at the origin of this thread), we 
also need to set this ptd upon shadow mapping, so it is still there 
when reaching the task deletion hook (where current->mm may be NULL). 
Hence the patch:

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index b243600..6bc4210 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -65,6 +65,11 @@ int nkthrptd;
 EXPORT_SYMBOL_GPL(nkthrptd);
 int nkerrptd;
 EXPORT_SYMBOL_GPL(nkerrptd);
+int nkmmptd;
+EXPORT_SYMBOL_GPL(nkmmptd);
+
+#define xnshadow_mmptd(t) ((t)->ptd[nkmmptd])
+#define xnshadow_mm(t) ((struct mm_struct *)xnshadow_mmptd(t))
 
 struct xnskin_slot {
 	struct xnskin_props *props;
@@ -1304,6 +1309,8 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 	 * friends.
 	 */
 	xnshadow_thrptd(current) = thread;
+	xnshadow_mmptd(current) = current->mm;
+
 	rthal_enable_notifier(current);
 
 	if (xnthread_base_priority(thread) == 0 &&
@@ -2759,7 +2766,15 @@ static void detach_ppd(xnshadow_ppd_t * ppd)
 
 static inline void do_cleanup_event(struct mm_struct *mm)
 {
+	struct task_struct *p = current;
+	struct mm_struct *old;
+
+	old = xnshadow_mm(p);
+	xnshadow_mmptd(p) = mm;
+
 	ppd_remove_mm(mm, &detach_ppd);
+
+	xnshadow_mmptd(p) = old;
 }
 
 RTHAL_DECLARE_CLEANUP_EVENT(cleanup_event);
@@ -2925,7 +2940,7 @@ EXPORT_SYMBOL_GPL(xnshadow_unregister_interface);
 xnshadow_ppd_t *xnshadow_ppd_get(unsigned muxid)
 {
 	if (xnpod_userspace_p())
-		return ppd_lookup(muxid, current->mm);
+		return ppd_lookup(muxid, xnshadow_mm(current) ?: current->mm);
 
 	return NULL;
 }
@@ -2960,8 +2975,9 @@ int xnshadow_mount(void)
 	sema_init(&completion_mutex, 1);
 	nkthrptd = rthal_alloc_ptdkey();
 	nkerrptd = rthal_alloc_ptdkey();
+	nkmmptd = rthal_alloc_ptdkey();
 
-	if (nkthrptd < 0 || nkerrptd < 0) {
+	if (nkthrptd < 0 || nkerrptd < 0 || nkmmptd < 0) {
 		printk(KERN_ERR "Xenomai: cannot allocate PTD slots\n");
 		return -ENOMEM;
 	}
diff --git a/ksrc/skins/posix/mutex.c b/ksrc/skins/posix/mutex.c
index 6ce75e5..cc86852 100644
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -219,10 +219,6 @@ void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
 	xnlock_put_irqrestore(&nklock, s);
 
 #ifdef CONFIG_XENO_FASTSYNCH
-	/* We call xnheap_free even if the mutex is not pshared; when
-	   this function is called from pse51_mutexq_cleanup, the
-	   sem_heap is destroyed, or not the one to which the fastlock
-	   belongs, xnheap will simply return an error. */
 	xnheap_free(&xnsys_ppd_get(mutex->attr.pshared)->sem_heap,
 		    mutex->synchbase.fastlock);
 #endif /* CONFIG_XENO_FASTSYNCH */


-- 
                                                                Gilles.

