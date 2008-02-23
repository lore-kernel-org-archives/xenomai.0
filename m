Resent-To: Xenomai-core@domain.hid
Resent-Message-Id: <47C02450.7030400@domain.hid>
Message-ID: <47C021F3.20002@domain.hid>
Date: Sat, 23 Feb 2008 14:38:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>
In-Reply-To: <47C020A9.3050704@domain.hid>
Content-Type: multipart/mixed; boundary="------------020706060208050407020306"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/4] Uninline heavy locking functions
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
--------------020706060208050407020306
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

At least when SMP is enable, already __xnlock_get becomes far too
heavy-weighted for being inlined. xnlock_put is fine now, but looking
closer at the disassembly still revealed a lot of redundancy related to
acquiring and releasing xnlocks. In fact, we are mostly using
xnlock_get_irqsave and xnlock_put_irqrestore. Both include fiddling with
rthal_local_irq_save/restore, also heavy-weighted on SMP.

So this patch turns the latter two into uninlined functions which
reduces the text size or nucleus and skins significantly on x86-64/SMP
(XENO_OPT_DEBUG_NUCLEUS disabled):

Without any patch of this series:
   text    data     bss     dec     hex filename
  79189    2168     308   81665   13f01 kernel/xenomai/skins/native/xeno_native.o
  26668    2176    1104   29948    74fc kernel/xenomai/skins/rtdm/xeno_rtdm.o
 102661    1376  160224  264261   40845 kernel/xenomai/skins/posix/xeno_posix.o
 112482    5440  444340  562262   89456 kernel/xenomai/nucleus/xeno_nucleus.o

With 1+2 applied:
   text    data     bss     dec     hex filename
  76099    2168     308   78575   132ef kernel/xenomai/skins/native/xeno_native.o
  25871    2176    1104   29151    71df kernel/xenomai/skins/rtdm/xeno_rtdm.o
  97816    1376  160224  259416   3f558 kernel/xenomai/skins/posix/xeno_posix.o
 108818    5440  444340  558598   88606 kernel/xenomai/nucleus/xeno_nucleus.o

With this one applied:
   text    data     bss     dec     hex filename
  49469    2168     308   51945    cae9 kernel/xenomai/skins/native/xeno_native.o
  19247    2176    1104   22527    57ff kernel/xenomai/skins/rtdm/xeno_rtdm.o
  60200    1376  160224  221800   36268 kernel/xenomai/skins/posix/xeno_posix.o
  79453    5440  444340  529233   81351 kernel/xenomai/nucleus/xeno_nucleus.o

Given this dramatic reduction, I really cannot imagine any negative
impact on worst-case latencies. Already the first nesting of nklock in
some hot path (I would say, this is the minimum in practice) should pay
of the additional function call. But I wasn't able to test yet. Anyone
is welcome to try this out, feedback highly appreciated!

Jan


PS: Philippe, ipipe_restore_pipeline_head's disassembly eg. looks awful
for an inline function. That's most obvious on SMP, but it is not much
better on UP. The reason seems to be

    ipipe_cpudom_var(__ipipe_pipeline_head(), status)

with its indirections, required to find the head domain slot. Wild idea:
Why not using a fixed slot for the head domain? There can only be one
anyway. That would then also help UP configs where this patch doesn't
improve anything.

--------------020706060208050407020306
Content-Type: text/x-patch;
 name="uninline-xnlock-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uninline-xnlock-functions.patch"

---
 include/asm-generic/bits/pod.h |   24 ++++++++++++++++++++++++
 include/asm-generic/system.h   |   22 ++--------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

Index: b/include/asm-generic/bits/pod.h
===================================================================
--- a/include/asm-generic/bits/pod.h
+++ b/include/asm-generic/bits/pod.h
@@ -295,4 +295,28 @@ unsigned long long xnarch_get_cpu_time(v
 
 EXPORT_SYMBOL(xnarch_get_cpu_time);
 
+#ifdef CONFIG_SMP
+spl_t __xnlock_get_irqsave(xnlock_t *lock  XNLOCK_DBG_CONTEXT_ARGS)
+{
+	unsigned long flags;
+
+	rthal_local_irq_save(flags);
+
+	if (__xnlock_get(lock  XNLOCK_DBG_PASS_CONTEXT))
+		flags |= 2;
+
+	return flags;
+}
+EXPORT_SYMBOL(__xnlock_get_irqsave);
+
+void xnlock_put_irqrestore(xnlock_t *lock, spl_t flags)
+{
+	if (!(flags & 2))
+		xnlock_put(lock);
+
+	rthal_local_irq_restore(flags & 1);
+}
+EXPORT_SYMBOL(xnlock_put_irqrestore);
+#endif /* CONFIG_SMP */
+
 #endif /* !_XENO_ASM_GENERIC_BITS_POD_H */
Index: b/include/asm-generic/system.h
===================================================================
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -332,26 +332,8 @@ static inline void xnlock_put(xnlock_t *
 	atomic_set(&lock->owner, ~0);
 }
 
-static inline spl_t
-__xnlock_get_irqsave(xnlock_t *lock  XNLOCK_DBG_CONTEXT_ARGS)
-{
-	unsigned long flags;
-
-	rthal_local_irq_save(flags);
-
-	if (__xnlock_get(lock  XNLOCK_DBG_PASS_CONTEXT))
-		flags |= 2;
-
-	return flags;
-}
-
-static inline void xnlock_put_irqrestore(xnlock_t *lock, spl_t flags)
-{
-	if (!(flags & 2))
-		xnlock_put(lock);
-
-	rthal_local_irq_restore(flags & 1);
-}
+spl_t __xnlock_get_irqsave(xnlock_t *lock  XNLOCK_DBG_CONTEXT_ARGS);
+void xnlock_put_irqrestore(xnlock_t *lock, spl_t flags);
 
 static inline int xnarch_send_ipi(xnarch_cpumask_t cpumask)
 {

--------------020706060208050407020306--


