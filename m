Message-ID: <b647ffbd0602011323o9ac08b3x@domain.hid>
Date: Wed, 1 Feb 2006 23:23:46 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15280_29929138.1138829026267"
Subject: [Xenomai-core] 
	[Combo-PATCH] Shared interrupts (base, /proc support,
	edge-triggered stuff)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_15280_29929138.1138829026267
Content-Type: multipart/alternative; 
	boundary="----=_Part_15281_4546931.1138829026267"

------=_Part_15281_4546931.1138829026267
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

as I promised, here go the following patches (ordered as they have to be
applied one by one) :


1) shirq-base.patch

Adds the "name" field to the interrupt object of the nucleus layer.
Reworks the related bits of the native skin (+ a few minor changes for
posix and rtdm) to support the named interrupt objects.


2) shirq-v7.patch

Generic support for shared interrupts.


3) shirq-proc.patch

/proc support.

Now /proc/xenomai/irq shows the names of handlers.

The related code have been removed from the hal layer to nucleus.


-----

4) shirq-isa.patch

Trying to handle the edge-triggered stuff.

This is a very preliminary version so the only thing I promise so far
is that it compiles successfully.


The functionality added by first 3 patches seem to be working.

--
Best regards,
Dmitry Adamushko

------=_Part_15281_4546931.1138829026267
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi there,<br>
<br>
as I promised, here go the following patches (ordered as they have to be ap=
plied one by one) :<br>
<br>
<br>
1) shirq-base.patch<br>
<br>
Adds the &quot;name&quot; field to the interrupt object of the nucleus laye=
r.<br>
Reworks the related bits of the native skin (+ a few minor changes for<br>
posix and rtdm) to support the named interrupt objects.<br>
<br>
<br>
2) shirq-v7.patch<br>
<br>
Generic support for shared interrupts.<br>
<br>
<br>
3) shirq-proc.patch<br>
<br>
/proc support.<br>
<br>
Now /proc/xenomai/irq shows the names of handlers.<br>
<br>
The related code have been removed from the hal layer to nucleus.<br>
<br>
<br>
-----<br>
<br>
4) shirq-isa.patch<br>
<br>
Trying to handle the edge-triggered stuff.<br>
<br>
This is a very preliminary version so the only thing I promise so far<br>
is that it compiles successfully.<br>
<br>
<br>
The functionality added by first 3 patches seem to be working.<br clear=3D"=
all"><br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>
<br>


------=_Part_15281_4546931.1138829026267--

------=_Part_15280_29929138.1138829026267
Content-Type: application/octet-stream; name=shirq-base.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shirq-base.patch"

diff -urp xenomai-cvs/include/native/intr.h xenomai-intr-iface/include/native/intr.h
--- xenomai-cvs/include/native/intr.h	2005-11-01 23:37:45.000000000 +0100
+++ xenomai-intr-iface/include/native/intr.h	2006-02-01 16:10:28.000000000 +0100
@@ -71,8 +71,6 @@ typedef struct rt_intr {
 
     rt_handle_t handle;	/* !< Handle in registry -- zero if unregistered. */
 
-    char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
-
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
 
     int mode;		/* !< Interrupt control mode. */
@@ -101,6 +99,7 @@ int __native_intr_pkg_init(void);
 void __native_intr_pkg_cleanup(void);
 
 int rt_intr_create(RT_INTR *intr,
+		   const char *name,
 		   unsigned irq,
 		   rt_isr_t isr,
 		   rt_iack_t iack);
@@ -122,7 +121,7 @@ extern "C" {
 #endif
 
 int rt_intr_bind(RT_INTR *intr,
-		 unsigned irq,
+		 const char *name,
 		 RTIME timeout);
 
 static inline int rt_intr_unbind (RT_INTR *intr)
@@ -133,6 +132,7 @@ static inline int rt_intr_unbind (RT_INT
 }
 
 int rt_intr_create(RT_INTR *intr,
+		   const char *name,
 		   unsigned irq,
 		   int mode);
 
diff -urp xenomai-cvs/include/nucleus/intr.h xenomai-intr-iface/include/nucleus/intr.h
--- xenomai-cvs/include/nucleus/intr.h	2005-11-01 23:37:45.000000000 +0100
+++ xenomai-intr-iface/include/nucleus/intr.h	2006-02-01 16:10:28.000000000 +0100
@@ -42,6 +42,8 @@ typedef struct xnintr {
 
     void *cookie;	/* !< User-defined cookie value. */
 
+    char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
+
 } xnintr_t;
 
 extern xnintr_t nkclock;
@@ -55,6 +57,7 @@ void xnintr_clock_handler(void);
     /* Public interface. */
 
 int xnintr_init(xnintr_t *intr,
+		const char *name,
 		unsigned irq,
 		xnisr_t isr,
 		xniack_t iack,
diff -urp xenomai-cvs/include/rtdm/rtdm_driver.h xenomai-intr-iface/include/rtdm/rtdm_driver.h
--- xenomai-cvs/include/rtdm/rtdm_driver.h	2006-01-03 19:53:37.000000000 +0100
+++ xenomai-intr-iface/include/rtdm/rtdm_driver.h	2006-02-01 16:10:28.000000000 +0100
@@ -743,7 +743,7 @@ static inline int rtdm_irq_request(rtdm_
                                    const char *device_name,
                                    void *arg)
 {
-    xnintr_init(irq_handle, irq_no, handler, NULL, flags);
+    xnintr_init(irq_handle, device_name, irq_no, handler, NULL, flags);
     return xnintr_attach(irq_handle, arg);
 }
 
diff -urp xenomai-cvs/ksrc/nucleus/intr.c xenomai-intr-iface/ksrc/nucleus/intr.c
--- xenomai-cvs/ksrc/nucleus/intr.c	2005-12-02 19:56:20.000000000 +0100
+++ xenomai-intr-iface/ksrc/nucleus/intr.c	2006-02-01 16:12:37.000000000 +0100
@@ -42,7 +42,7 @@ static void xnintr_irq_handler(unsigned 
 			       void *cookie);
 
 /*! 
- * \fn int xnintr_init (xnintr_t *intr,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
+ * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
  * \brief Initialize an interrupt object.
  *
  * Associates an interrupt object with an IRQ line.
@@ -82,6 +82,9 @@ static void xnintr_irq_handler(unsigned 
  * descriptor must always be valid while the object is active
  * therefore it must be allocated in permanent memory.
  *
+ * @param name An ASCII string standing for the symbolic name of the
+ * interrupt object.
+ *
  * @param irq The hardware interrupt channel associated with the
  * interrupt object. This value is architecture-dependent. An
  * interrupt object must then be attached to the hardware interrupt
@@ -120,6 +123,7 @@ static void xnintr_irq_handler(unsigned 
  */
 
 int xnintr_init (xnintr_t *intr,
+		 const char *name,
 		 unsigned irq,
 		 xnisr_t isr,
 		 xniack_t iack,
@@ -130,6 +134,7 @@ int xnintr_init (xnintr_t *intr,
     intr->iack = iack;
     intr->cookie = NULL;
     intr->hits = 0;
+    xnobject_copy_name(intr->name,name);
 
     return 0;
 }
diff -urp xenomai-cvs/ksrc/nucleus/pod.c xenomai-intr-iface/ksrc/nucleus/pod.c
--- xenomai-cvs/ksrc/nucleus/pod.c	2006-01-10 21:47:24.000000000 +0100
+++ xenomai-intr-iface/ksrc/nucleus/pod.c	2006-02-01 16:13:10.000000000 +0100
@@ -3042,7 +3042,7 @@ unlock_and_exit:
        attached directly by the arch-dependent layer
        (xnarch_start_timer). */
 
-    xnintr_init(&nkclock,0,tickhandler,NULL,0);
+    xnintr_init(&nkclock,NULL,0,tickhandler,NULL,0);
 
     __setbits(nkpod->status,XNTIMED);
 
diff -urp xenomai-cvs/ksrc/skins/native/intr.c xenomai-intr-iface/ksrc/skins/native/intr.c
--- xenomai-cvs/ksrc/skins/native/intr.c	2005-11-29 15:15:54.000000000 +0100
+++ xenomai-intr-iface/ksrc/skins/native/intr.c	2006-02-01 16:10:29.000000000 +0100
@@ -119,7 +119,7 @@ static RT_OBJECT_PROCNODE __intr_pnode =
 #endif /* CONFIG_XENO_NATIVE_EXPORT_REGISTRY */
 
 /*! 
- * \fn int rt_intr_create (RT_INTR *intr,unsigned irq,rt_isr_t isr,rt_iack_t iack)
+ * \fn int rt_intr_create (RT_INTR *intr,const char *name,unsigned irq,rt_isr_t isr,rt_iack_t iack)
  * \brief Create an interrupt object from kernel space.
  *
  * Initializes and associates an interrupt object with an IRQ line. In
@@ -155,6 +155,11 @@ static RT_OBJECT_PROCNODE __intr_pnode =
  * be valid while the object is active therefore it must be allocated
  * in permanent memory.
  *
+ * @param name An ASCII string standing for the symbolic name of the
+ * interrupt object. When non-NULL and non-empty, this string is copied
+ * to a safe place into the descriptor, and passed to the registry package
+ * if enabled for indexing the created interrupt objects.
+ *
  * @param irq The hardware interrupt channel associated with the
  * interrupt object. This value is architecture-dependent.
  *
@@ -205,6 +210,7 @@ static RT_OBJECT_PROCNODE __intr_pnode =
  */
 
 int rt_intr_create (RT_INTR *intr,
+		    const char *name,
 		    unsigned irq,
 		    rt_isr_t isr,
 		    rt_iack_t iack)
@@ -215,7 +221,7 @@ int rt_intr_create (RT_INTR *intr,
     if (xnpod_asynch_p())
 	return -EPERM;
 
-    xnintr_init(&intr->intr_base,irq,isr,iack,0);
+    xnintr_init(&intr->intr_base,name,irq,isr,iack,0);
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
     xnsynch_init(&intr->synch_base,XNSYNCH_PRIO);
     intr->pending = 0;
@@ -228,7 +234,6 @@ int rt_intr_create (RT_INTR *intr,
     xnlock_get_irqsave(&nklock,s);
     appendq(&__xeno_intr_q,&intr->link);
     xnlock_put_irqrestore(&nklock,s);
-    snprintf(intr->name,sizeof(intr->name),"irq%u",irq);
 
     err = xnintr_attach(&intr->intr_base,intr);
 
@@ -238,7 +243,7 @@ int rt_intr_create (RT_INTR *intr,
        half-baked objects... */
 
     if (!err)
-	err = rt_registry_enter(intr->name,intr,&intr->handle,&__intr_pnode);
+	err = rt_registry_enter(intr->intr_base.name,intr,&intr->handle,&__intr_pnode);
 #endif /* CONFIG_XENO_OPT_NATIVE_REGISTRY */
 
     if (err)
@@ -492,7 +497,7 @@ int rt_intr_inquire (RT_INTR *intr,
         goto unlock_and_exit;
         }
     
-    strcpy(info->name,intr->name);
+    strcpy(info->name,intr->intr_base.name);
     info->hits = intr->intr_base.hits;
     info->irq = intr->intr_base.irq;
 
diff -urp xenomai-cvs/ksrc/skins/native/syscall.c xenomai-intr-iface/ksrc/skins/native/syscall.c
--- xenomai-cvs/ksrc/skins/native/syscall.c	2005-12-30 11:44:10.000000000 +0100
+++ xenomai-intr-iface/ksrc/skins/native/syscall.c	2006-02-01 16:10:29.000000000 +0100
@@ -2894,6 +2894,7 @@ EXPORT_SYMBOL(rt_intr_handler);
 
 /*
  * int __rt_intr_create(RT_INTR_PLACEHOLDER *ph,
+ *			const char *name,
  *                      unsigned irq,
  *                      int mode)
  */
@@ -2901,6 +2902,7 @@ EXPORT_SYMBOL(rt_intr_handler);
 static int __rt_intr_create (struct task_struct *curr, struct pt_regs *regs)
 
 {
+    char name[XNOBJECT_NAME_LEN];
     RT_INTR_PLACEHOLDER ph;
     int err, mode;
     RT_INTR *intr;
@@ -2909,11 +2911,22 @@ static int __rt_intr_create (struct task
     if (!__xn_access_ok(curr,VERIFY_WRITE,__xn_reg_arg1(regs),sizeof(ph)))
 	return -EFAULT;
 
+    if (__xn_reg_arg2(regs))
+	{
+	if (!__xn_access_ok(curr,VERIFY_READ,__xn_reg_arg2(regs),sizeof(name)))
+	    return -EFAULT;
+
+	__xn_strncpy_from_user(curr,name,(const char __user *)__xn_reg_arg2(regs),sizeof(name) - 1);
+	name[sizeof(name) - 1] = '\0';
+	}
+    else
+	*name = '\0';
+
     /* Interrupt line number. */
-    irq = (unsigned)__xn_reg_arg2(regs);
+    irq = (unsigned)__xn_reg_arg3(regs);
 
     /* Interrupt control mode. */
-    mode = (int)__xn_reg_arg3(regs);
+    mode = (int)__xn_reg_arg4(regs);
 
     if (mode & ~(I_AUTOENA|I_PROPAGATE))
 	return -EINVAL;
@@ -2923,7 +2936,7 @@ static int __rt_intr_create (struct task
     if (!intr)
 	return -ENOMEM;
 
-    err = rt_intr_create(intr,irq,&rt_intr_handler,NULL);
+    err = rt_intr_create(intr,name,irq,&rt_intr_handler,NULL);
 
     if (err == 0)
 	{
diff -urp xenomai-cvs/ksrc/skins/posix/intr.c xenomai-intr-iface/ksrc/skins/posix/intr.c
--- xenomai-cvs/ksrc/skins/posix/intr.c	2006-01-03 21:41:36.000000000 +0100
+++ xenomai-intr-iface/ksrc/skins/posix/intr.c	2006-02-01 16:10:29.000000000 +0100
@@ -27,7 +27,7 @@ int pse51_intr_attach (struct pse51_inte
     int err;
     spl_t s;
 
-    xnintr_init(&intr->intr_base,irq,isr,iack,0);
+    xnintr_init(&intr->intr_base,NULL,irq,isr,iack,0);
 
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
     xnsynch_init(&intr->synch_base,XNSYNCH_PRIO);
diff -urp xenomai-cvs/src/skins/native/intr.c xenomai-intr-iface/src/skins/native/intr.c
--- xenomai-cvs/src/skins/native/intr.c	2005-11-01 23:37:45.000000000 +0100
+++ xenomai-intr-iface/src/skins/native/intr.c	2006-02-01 16:10:29.000000000 +0100
@@ -24,24 +24,22 @@
 extern int __native_muxid;
 
 int rt_intr_create (RT_INTR *intr,
+		    const char *name,
 		    unsigned irq,
 		    int mode)
 {
-    return XENOMAI_SKINCALL3(__native_muxid,
+    return XENOMAI_SKINCALL4(__native_muxid,
 			     __native_intr_create,
 			     intr,
+			     name,
 			     irq,
 			     mode);
 }
 
 int rt_intr_bind (RT_INTR *intr,
-		  unsigned irq,
+		  const char *name,
 		  RTIME timeout)
 {
-    char name[XNOBJECT_NAME_LEN];
-
-    snprintf(name,sizeof(name),"irq%u",irq);
-
     return XENOMAI_SKINCALL3(__native_muxid,
 			     __native_intr_bind,
 			     intr,

------=_Part_15280_29929138.1138829026267
Content-Type: application/octet-stream; name=shirq-v7.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shirq-v7.patch"

diff -urp xenomai-intr-iface/include/asm-generic/hal.h xenomai-shirq-7/include/asm-generic/hal.h
--- xenomai-intr-iface/include/asm-generic/hal.h	2006-01-13 15:10:23.000000000 +0100
+++ xenomai-shirq-7/include/asm-generic/hal.h	2006-02-01 16:16:47.000000000 +0100
@@ -62,6 +62,7 @@
 #define RTHAL_NR_CPUS		IPIPE_NR_CPUS
 #define RTHAL_ROOT_PRIO		IPIPE_ROOT_PRIO
 #define RTHAL_NR_FAULTS		IPIPE_NR_FAULTS
+#define RTHAL_NR_IRQS		IPIPE_NR_IRQS
 
 #define RTHAL_SERVICE_IPI0	IPIPE_SERVICE_IPI0
 #define RTHAL_SERVICE_VECTOR0	IPIPE_SERVICE_VECTOR0
diff -urp xenomai-intr-iface/include/asm-generic/system.h xenomai-shirq-7/include/asm-generic/system.h
--- xenomai-intr-iface/include/asm-generic/system.h	2006-01-03 19:53:37.000000000 +0100
+++ xenomai-shirq-7/include/asm-generic/system.h	2006-02-01 16:16:47.000000000 +0100
@@ -101,6 +101,8 @@ typedef struct { volatile unsigned long 
 
 #define XNARCH_NR_CPUS               RTHAL_NR_CPUS
 
+#define XNARCH_TIMER_IRQ	     RTHAL_TIMER_IRQ
+
 #define XNARCH_ROOT_STACKSZ   0	/* Only a placeholder -- no stack */
 
 #define XNARCH_PROMPT "Xenomai: "
@@ -470,6 +472,16 @@ static inline unsigned long long xnarch_
 
 #ifdef XENO_INTR_MODULE
 
+#define XNARCH_NR_IRQS		     RTHAL_NR_IRQS
+
+static inline unsigned long xnarch_critical_enter(void (*synch)(void)) {
+    return rthal_critical_enter(synch);
+}
+
+static inline void xnarch_critical_exit(unsigned long flags) {
+    return rthal_critical_exit(flags);
+}
+
 static inline int xnarch_hook_irq (unsigned irq,
 				   rthal_irq_handler_t handler,
 				   rthal_irq_ackfn_t ackfn,
diff -urp xenomai-intr-iface/include/asm-i386/hal.h xenomai-shirq-7/include/asm-i386/hal.h
--- xenomai-intr-iface/include/asm-i386/hal.h	2006-01-04 11:32:29.000000000 +0100
+++ xenomai-shirq-7/include/asm-i386/hal.h	2006-02-01 16:16:47.000000000 +0100
@@ -191,6 +191,9 @@ static inline __attribute_const__ unsign
 #define RTHAL_APIC_TIMER_VECTOR    RTHAL_SERVICE_VECTOR3
 #define RTHAL_APIC_TIMER_IPI       RTHAL_SERVICE_IPI3
 #define RTHAL_APIC_ICOUNT          ((RTHAL_TIMER_FREQ + HZ/2)/HZ)
+#define RTHAL_TIMER_IRQ 	   RTHAL_APIC_TIMER_IPI
+#else  /* !CONFIG_X86_LOCAL_APIC */
+#define RTHAL_TIMER_IRQ		   RTHAL_8254_IRQ
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #define RTHAL_NMICLK_FREQ	RTHAL_CPU_FREQ
diff -urp xenomai-intr-iface/include/asm-sim/system.h xenomai-shirq-7/include/asm-sim/system.h
--- xenomai-intr-iface/include/asm-sim/system.h	2006-01-03 19:53:37.000000000 +0100
+++ xenomai-shirq-7/include/asm-sim/system.h	2006-02-01 16:16:47.000000000 +0100
@@ -75,6 +75,9 @@ typedef unsigned long xnlock_t;
 
 #define XNARCH_NR_CPUS              1
 
+/* Should be equal to the value used for creating the mvmtimer object (mvm_start_timer). */
+#define XNARCH_TIMER_IRQ	    1
+
 #define XNARCH_DEFAULT_TICK         10000000 /* ns, i.e. 10ms */
 #define XNARCH_HOST_TICK            0 /* No host ticking service. */
 
@@ -365,6 +368,16 @@ void mvm_tcl_build_pendq(mvm_tcl_listobj
 typedef void (*rthal_irq_handler_t)(unsigned, void *);
 typedef int (*rthal_irq_ackfn_t)(unsigned);
 
+#define XNARCH_NR_IRQS		     MVM_IRQ_LEVELS
+
+static inline unsigned long xnarch_critical_enter(void (*synch)(void)) {
+    return 0;
+}
+
+static inline void xnarch_critical_exit(unsigned long flags) {
+    return;
+}
+
 static inline int xnarch_hook_irq (unsigned irq,
 				   rthal_irq_handler_t handler,
 				   rthal_irq_ackfn_t ackfn, /* Ignored. */
diff -urp xenomai-intr-iface/include/asm-uvm/system.h xenomai-shirq-7/include/asm-uvm/system.h
--- xenomai-intr-iface/include/asm-uvm/system.h	2006-01-08 15:35:54.000000000 +0100
+++ xenomai-shirq-7/include/asm-uvm/system.h	2006-02-01 16:16:47.000000000 +0100
@@ -74,6 +74,8 @@ typedef unsigned long xnlock_t;
 
 #define XNARCH_NR_CPUS             1
 
+#define XNARCH_TIMER_IRQ	   0
+
 #define XNARCH_DEFAULT_TICK        1000000 /* ns, i.e. 1ms */
 #define XNARCH_SIG_RESTART         SIGUSR1
 #define XNARCH_HOST_TICK           0	/* No host ticking service */
@@ -270,6 +272,16 @@ void xnarch_sync_irq (void) /* Synchroni
 typedef void (*rthal_irq_handler_t)(unsigned, void *);
 typedef int (*rthal_irq_ackfn_t)(unsigned);
 
+#define XNARCH_NR_IRQS		     0
+
+static inline unsigned long xnarch_critical_enter(void (*synch)(void)) {
+    return 0;
+}
+
+static inline void xnarch_critical_exit(unsigned long flags) {
+    return;
+}
+
 static inline int xnarch_hook_irq (unsigned irq,
 				   rthal_irq_handler_t handler,
 				   rthal_irq_ackfn_t ackfn,
diff -urp xenomai-intr-iface/include/nucleus/intr.h xenomai-shirq-7/include/nucleus/intr.h
--- xenomai-intr-iface/include/nucleus/intr.h	2006-02-01 16:10:28.000000000 +0100
+++ xenomai-shirq-7/include/nucleus/intr.h	2006-02-01 16:16:47.000000000 +0100
@@ -26,21 +26,31 @@
 #define XN_ISR_CHAINED   0x1
 #define XN_ISR_ENABLE    0x2
 
+/* Creation flags. */
+#define XN_ISR_SHARED	 0x1
+
+/* Operational flags. */
+#define XN_ISR_ATTACHED	 0x100
+
 #if defined(__KERNEL__) || defined(__XENO_UVM__) || defined(__XENO_SIM__)
 
 struct xnintr;
 
 typedef struct xnintr {
 
-    unsigned irq;	/* !< IRQ number. */
+    struct xnintr *next;
 
     xnisr_t isr;	/* !< Interrupt service routine. */
 
-    xniack_t iack;	/* !< Interrupt acknowledge routine. */
+    void *cookie;	/* !< User-defined cookie value. */
 
     unsigned long hits;	/* !< Number of receipts (since attachment). */
 
-    void *cookie;	/* !< User-defined cookie value. */
+    xnflags_t flags; 	/* !< Creation flags. */
+
+    unsigned irq;	/* !< IRQ number. */
+
+    xniack_t iack;	/* !< Interrupt acknowledge routine. */
 
     char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
 
@@ -52,6 +62,8 @@ extern xnintr_t nkclock;
 extern "C" {
 #endif
 
+int xnintr_mount(void);
+
 void xnintr_clock_handler(void);
 
     /* Public interface. */
diff -urp xenomai-intr-iface/ksrc/nucleus/intr.c xenomai-shirq-7/ksrc/nucleus/intr.c
--- xenomai-intr-iface/ksrc/nucleus/intr.c	2006-02-01 16:12:37.000000000 +0100
+++ xenomai-shirq-7/ksrc/nucleus/intr.c	2006-02-01 18:30:14.000000000 +0100
@@ -41,6 +41,57 @@ xnintr_t nkclock;
 static void xnintr_irq_handler(unsigned irq,
 			       void *cookie);
 
+typedef struct xnintr_shirq {
+
+    xnintr_t *handlers;
+    
+#ifdef CONFIG_SMP
+    atomic_counter_t active;
+#endif /* CONFIG_SMP */
+
+} xnintr_shirq_t;
+
+static xnintr_shirq_t xnshirqs[XNARCH_NR_IRQS];
+
+#ifdef CONFIG_SMP
+
+static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq)
+{
+    xnarch_atomic_inc(&shirq->active);
+}
+
+static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq)
+{
+    xnarch_atomic_dec(&shirq->active);
+}
+
+static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq)
+{
+    while (xnarch_atomic_get(&shirq->active))
+	cpu_relax();
+}
+
+#else /* !CONFIG_SMP */
+
+static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq) {}
+static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq) {}
+static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq) {}
+
+#endif /* CONFIG_SMP */
+
+int xnintr_mount(void)
+{
+    int i;
+    for (i = 0; i < XNARCH_NR_IRQS; ++i)
+	{
+	xnshirqs[i].handlers = NULL;
+#ifdef CONFIG_SMP
+	atomic_set(&xnshirqs[i].active,0);
+#endif /* CONFIG_SMP */
+	}
+    return 0;
+}
+
 /*! 
  * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
  * \brief Initialize an interrupt object.
@@ -134,6 +185,8 @@ int xnintr_init (xnintr_t *intr,
     intr->iack = iack;
     intr->cookie = NULL;
     intr->hits = 0;
+    intr->flags = flags;
+    intr->next = NULL;
     xnobject_copy_name(intr->name,name);
 
     return 0;
@@ -169,7 +222,8 @@ int xnintr_init (xnintr_t *intr,
 int xnintr_destroy (xnintr_t *intr)
 
 {
-    return xnintr_detach(intr);
+    xnintr_detach(intr);
+    return 0;
 }
 
 /*! 
@@ -186,8 +240,7 @@ int xnintr_destroy (xnintr_t *intr)
  *
  * @param cookie A user-defined opaque value which is stored into the
  * interrupt object descriptor for further retrieval by the ISR/ISR
- * handlers.
- *
+ * handlers. *
  * @return 0 is returned on success. Otherwise, -EINVAL is returned if
  * a low-level error occurred while attaching the interrupt. -EBUSY is
  * specifically returned if the interrupt object was already attached.
@@ -209,9 +262,62 @@ int xnintr_destroy (xnintr_t *intr)
 int xnintr_attach (xnintr_t *intr,
 		   void *cookie)
 {
+    xnintr_shirq_t *shirq;
+    xnintr_t *prev, **p;
+    unsigned long flags;
+    int err = 0;
+
+    if (intr->irq >= XNARCH_NR_IRQS)
+	return -EINVAL;
+
     intr->hits = 0;
+    intr->next = NULL;
     intr->cookie = cookie;
-    return xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,intr);
+    shirq = &xnshirqs[intr->irq];
+
+    flags = xnarch_critical_enter(NULL);
+
+    if (__testbits(intr->flags,XN_ISR_ATTACHED))
+	{
+	err = -EPERM;
+	goto unlock_and_exit;
+	}
+
+    p = &shirq->handlers;
+
+    if ((prev = *p) != NULL)
+	{
+	/* Check on whether the shared mode is allowed. */
+	if (!(prev->flags & intr->flags & XN_ISR_SHARED) || (prev->iack != intr->iack))
+	    {
+	    err = -EBUSY;
+	    goto unlock_and_exit;
+	    }
+
+	/* Get a position at the end of the list to insert the new element. */
+	while (prev)
+	    {
+	    p = &prev->next;
+	    prev = *p;
+	    }
+	}
+    else
+	{
+	/* Initialize the corresponding interrupt channel */
+	err = xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,NULL);
+	if (err)
+	    goto unlock_and_exit;
+	}
+
+    __setbits(intr->flags,XN_ISR_ATTACHED);
+
+    /* Add a given interrupt object. */
+    *p = intr;
+
+unlock_and_exit:
+
+    xnarch_critical_exit(flags);
+    return err;
 }
 
 /*! 
@@ -246,7 +352,52 @@ int xnintr_attach (xnintr_t *intr,
 int xnintr_detach (xnintr_t *intr)
 
 {
-    return xnarch_release_irq(intr->irq);
+    xnintr_shirq_t *shirq;
+    unsigned long flags;
+    xnintr_t *e, **p;
+    int err = 0;
+
+    if (intr->irq >= XNARCH_NR_IRQS)
+	return -EINVAL;
+
+    shirq = &xnshirqs[intr->irq];
+
+    flags = xnarch_critical_enter(NULL);
+
+    if (!__testbits(intr->flags,XN_ISR_ATTACHED))
+	{
+	xnarch_critical_exit(flags);
+	return -EPERM;
+	}
+
+    __clrbits(intr->flags,XN_ISR_ATTACHED);
+
+    p = &shirq->handlers;
+
+    while ((e = *p) != NULL)
+	{
+	if (e == intr)
+	    {
+	    /* Remove a given interrupt object from the list. */
+	    if ((*p = e->next) == NULL)
+		err = xnarch_release_irq(intr->irq);
+    
+	    xnarch_critical_exit(flags);
+
+	    /* The idea here is to keep a detached interrupt object valid as long
+	       as the corresponding irq handler is running. This is one of the requirements
+	       to iterate over the xnintr_shirq_t::handlers list in xnintr_irq_handler()
+	       in a lockless way. */
+	    xnintr_shirq_spin(shirq);
+	    return err;
+	    }
+	p = &e->next;
+	}
+
+    xnarch_critical_exit(flags);
+
+    xnlogerr("Attempted to detach a non previously attached interrupt object");
+    return err;
 }
 
 /*! 
@@ -355,17 +506,41 @@ static void xnintr_irq_handler (unsigned
 
 {
     xnsched_t *sched = xnpod_current_sched();
-    xnintr_t *intr = (xnintr_t *)cookie;
-    int s;
+    xnintr_shirq_t *shirq;
+    xnintr_t *intr;
+    int s = 0;
 
     xnarch_memory_barrier();
 
     xnltt_log_event(xeno_ev_ienter,irq);
 
     ++sched->inesting;
-    s = intr->isr(intr);
+
+    if (irq == XNARCH_TIMER_IRQ)
+	{
+	intr = (xnintr_t*)cookie;
+	s = intr->isr(intr);
+	++intr->hits;
+	}
+    else
+	{
+	shirq = &xnshirqs[irq];
+
+	xnintr_shirq_lock(shirq);
+	intr = shirq->handlers;
+
+	while (intr)
+	    {
+	    s |= intr->isr(intr);
+	    ++intr->hits;
+
+	    intr = intr->next;
+	    }
+
+	xnintr_shirq_unlock(shirq);
+	}
+
     --sched->inesting;
-    ++intr->hits;
 
     if (s & XN_ISR_ENABLE)
 	xnarch_enable_irq(irq);
@@ -389,6 +564,7 @@ static void xnintr_irq_handler (unsigned
     xnltt_log_event(xeno_ev_iexit,irq);
 }
 
+
 /*@}*/
 
 EXPORT_SYMBOL(xnintr_attach);
diff -urp xenomai-intr-iface/ksrc/nucleus/module.c xenomai-shirq-7/ksrc/nucleus/module.c
--- xenomai-intr-iface/ksrc/nucleus/module.c	2005-11-30 10:36:33.000000000 +0100
+++ xenomai-shirq-7/ksrc/nucleus/module.c	2006-02-01 16:16:47.000000000 +0100
@@ -713,6 +713,8 @@ int __init __xeno_sys_init (void)
     xnpod_init_proc();
 #endif /* CONFIG_PROC_FS */
 
+    xnintr_mount();
+
 #ifdef CONFIG_LTT
     xnltt_mount();
 #endif /* CONFIG_LTT */
diff -urp xenomai-intr-iface/ksrc/nucleus/pod.c xenomai-shirq-7/ksrc/nucleus/pod.c
--- xenomai-intr-iface/ksrc/nucleus/pod.c	2006-02-01 16:13:10.000000000 +0100
+++ xenomai-shirq-7/ksrc/nucleus/pod.c	2006-02-01 16:19:45.000000000 +0100
@@ -3038,11 +3038,10 @@ unlock_and_exit:
 
     /* The clock interrupt does not need to be attached since the
        timer service will handle the arch-dependent setup. The IRQ
-       number (arg #2) is not used since the IRQ source will be
-       attached directly by the arch-dependent layer
+       source will be attached directly by the arch-dependent layer
        (xnarch_start_timer). */
 
-    xnintr_init(&nkclock,NULL,0,tickhandler,NULL,0);
+    xnintr_init(&nkclock,NULL,XNARCH_TIMER_IRQ,tickhandler,NULL,0);
 
     __setbits(nkpod->status,XNTIMED);
 

------=_Part_15280_29929138.1138829026267
Content-Type: application/octet-stream; name=shirq-proc.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shirq-proc.patch"

diff -urp xenomai-shirq-7/include/nucleus/intr.h xenomai-shirq-7-proc/include/nucleus/intr.h
--- xenomai-shirq-7/include/nucleus/intr.h	2006-02-01 16:16:47.000000000 +0100
+++ xenomai-shirq-7-proc/include/nucleus/intr.h	2006-02-01 16:21:18.000000000 +0100
@@ -66,6 +66,8 @@ int xnintr_mount(void);
 
 void xnintr_clock_handler(void);
 
+int xnintr_irq_proc(unsigned int irq, char *str);
+
     /* Public interface. */
 
 int xnintr_init(xnintr_t *intr,
diff -urp xenomai-shirq-7/ksrc/arch/generic/hal.c xenomai-shirq-7-proc/ksrc/arch/generic/hal.c
--- xenomai-shirq-7/ksrc/arch/generic/hal.c	2006-01-10 18:44:02.000000000 +0100
+++ xenomai-shirq-7-proc/ksrc/arch/generic/hal.c	2006-02-01 16:21:18.000000000 +0100
@@ -697,45 +697,6 @@ static int hal_read_proc (char *page,
     return len;
 }
 
-static int irq_read_proc (char *page,
-			  char **start,
-			  off_t off,
-			  int count,
-			  int *eof,
-			  void *data)
-{
-    int len = 0, cpu, irq;
-    char *p = page;
-
-    p += sprintf(p,"IRQ ");
-
-    for_each_online_cpu(cpu) {
-	p += sprintf(p,"        CPU%d",cpu);
-    }
-
-    for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
-
-	if (rthal_irq_handler(&rthal_domain, irq) == NULL)
-	    continue;
-
-	p += sprintf(p,"\n%3d:",irq);
-
-	for_each_online_cpu(cpu) {
-	    p += sprintf(p,"%12lu",rthal_cpudata_irq_hits(&rthal_domain,cpu,irq));
-	}
-    }
-
-    p += sprintf(p,"\n");
-
-    len = p - page - off;
-    if (len <= off + count) *eof = 1;
-    *start = page + off;
-    if (len > count) len = count;
-    if (len < 0) len = 0;
-
-    return len;
-}
-
 static int faults_read_proc (char *page,
 			     char **start,
 			     off_t off,
@@ -862,12 +823,6 @@ static int rthal_proc_register (void)
 		  NULL,
 		  rthal_proc_root);
 
-    __rthal_add_proc_leaf("irq",
-		  &irq_read_proc,
-		  NULL,
-		  NULL,
-		  rthal_proc_root);
-
     __rthal_add_proc_leaf("faults",
 		  &faults_read_proc,
 		  NULL,
@@ -890,7 +845,6 @@ static void rthal_proc_unregister (void)
 {
     rthal_nmi_proc_unregister();
     remove_proc_entry("hal",rthal_proc_root);
-    remove_proc_entry("irq",rthal_proc_root);
     remove_proc_entry("faults",rthal_proc_root);
     remove_proc_entry("apc",rthal_proc_root);
     remove_proc_entry("xenomai",NULL);
diff -urp xenomai-shirq-7/ksrc/nucleus/intr.c xenomai-shirq-7-proc/ksrc/nucleus/intr.c
--- xenomai-shirq-7/ksrc/nucleus/intr.c	2006-02-01 18:30:14.000000000 +0100
+++ xenomai-shirq-7-proc/ksrc/nucleus/intr.c	2006-02-01 18:32:23.000000000 +0100
@@ -536,7 +536,6 @@ static void xnintr_irq_handler (unsigned
 
 	    intr = intr->next;
 	    }
-
 	xnintr_shirq_unlock(shirq);
 	}
 
@@ -564,6 +563,35 @@ static void xnintr_irq_handler (unsigned
     xnltt_log_event(xeno_ev_iexit,irq);
 }
 
+int xnintr_irq_proc(unsigned int irq, char *str)
+{
+    xnintr_shirq_t *shirq;
+    xnintr_t *intr;
+    char *p = str;
+
+    shirq = &xnshirqs[irq];
+
+    xnintr_shirq_lock(shirq);
+    intr = shirq->handlers;
+
+    if (intr)
+	p += sprintf(p, "        ");
+
+    while (intr)
+	{
+	if (*(intr->name))
+	    p += sprintf(p, " %s,", intr->name);
+
+	intr = intr->next;
+	}
+
+    xnintr_shirq_unlock(shirq);
+
+    if (p != str)
+	--p;
+
+    return p - str;
+}
 
 /*@}*/
 
diff -urp xenomai-shirq-7/ksrc/nucleus/module.c xenomai-shirq-7-proc/ksrc/nucleus/module.c
--- xenomai-shirq-7/ksrc/nucleus/module.c	2006-02-01 16:16:47.000000000 +0100
+++ xenomai-shirq-7-proc/ksrc/nucleus/module.c	2006-02-01 17:06:36.000000000 +0100
@@ -526,6 +526,48 @@ static int timer_read_proc (char *page,
     return len;
 }
 
+static int irq_read_proc (char *page,
+			  char **start,
+			  off_t off,
+			  int count,
+			  int *eof,
+			  void *data)
+{
+    int len = 0, cpu, irq;
+    char *p = page;
+
+    p += sprintf(p,"IRQ ");
+
+    for_each_online_cpu(cpu) {
+	p += sprintf(p,"        CPU%d",cpu);
+    }
+
+    for (irq = 0; irq < RTHAL_NR_IRQS; irq++) {
+
+	if (rthal_irq_handler(&rthal_domain, irq) == NULL)
+	    continue;
+
+	p += sprintf(p,"\n%3d:",irq);
+
+	for_each_online_cpu(cpu) {
+	    p += sprintf(p,"%12lu",rthal_cpudata_irq_hits(&rthal_domain,cpu,irq));
+	}
+
+	p += xnintr_irq_proc(irq, p); 
+    }
+
+    p += sprintf(p,"\n");
+
+    len = p - page - off;
+    if (len <= off + count) *eof = 1;
+    *start = page + off;
+    if (len > count) len = count;
+    if (len < 0) len = 0;
+
+    return len;
+}
+
+
 static struct proc_dir_entry *add_proc_leaf (const char *name,
 					     read_proc_t rdproc,
 					     write_proc_t wrproc,
@@ -614,6 +656,12 @@ void xnpod_init_proc (void)
 		  NULL,
 		  rthal_proc_root);
 
+    add_proc_leaf("irq",
+		  &irq_read_proc,
+		  NULL,
+		  NULL,
+		  rthal_proc_root);
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
     iface_proc_root = create_proc_entry("interfaces",
 					S_IFDIR,
@@ -633,6 +681,7 @@ void xnpod_delete_proc (void)
 
     remove_proc_entry("interfaces",rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+    remove_proc_entry("irq",rthal_proc_root);
     remove_proc_entry("timer",rthal_proc_root);
     remove_proc_entry("version",rthal_proc_root);
     remove_proc_entry("latency",rthal_proc_root);

------=_Part_15280_29929138.1138829026267
Content-Type: application/octet-stream; name=shirq-isa.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shirq-isa.patch"

diff -urp xenomai/include/nucleus/intr.h xenomai-isa/include/nucleus/intr.h
--- xenomai/include/nucleus/intr.h	2006-02-01 16:23:35.000000000 +0100
+++ xenomai-isa/include/nucleus/intr.h	2006-02-01 22:29:47.000000000 +0100
@@ -25,9 +25,11 @@
 #define XN_ISR_HANDLED   0x0
 #define XN_ISR_CHAINED   0x1
 #define XN_ISR_ENABLE    0x2
+#define XN_ISR_NOINT	 0x4
 
 /* Creation flags. */
 #define XN_ISR_SHARED	 0x1
+#define XN_ISR_ISA	 0x2
 
 /* Operational flags. */
 #define XN_ISR_ATTACHED	 0x100
diff -urp xenomai/ksrc/nucleus/intr.c xenomai-isa/ksrc/nucleus/intr.c
--- xenomai/ksrc/nucleus/intr.c	2006-02-01 18:04:30.000000000 +0100
+++ xenomai-isa/ksrc/nucleus/intr.c	2006-02-01 22:32:24.000000000 +0100
@@ -41,6 +41,9 @@ xnintr_t nkclock;
 static void xnintr_irq_handler(unsigned irq,
 			       void *cookie);
 
+static void xnintr_isairq_handler(unsigned irq,
+			       void *cookie);
+
 typedef struct xnintr_shirq {
 
     xnintr_t *handlers;
@@ -288,7 +291,8 @@ int xnintr_attach (xnintr_t *intr,
     if ((prev = *p) != NULL)
 	{
 	/* Check on whether the shared mode is allowed. */
-	if (!(prev->flags & intr->flags & XN_ISR_SHARED) || (prev->iack != intr->iack))
+	if (!(prev->flags & intr->flags & XN_ISR_SHARED) || (prev->iack != intr->iack)
+	    || ((prev->flags & XN_ISR_ISA) != (intr->flags & XN_ISR_ISA)))
 	    {
 	    err = -EBUSY;
 	    goto unlock_and_exit;
@@ -304,7 +308,12 @@ int xnintr_attach (xnintr_t *intr,
     else
 	{
 	/* Initialize the corresponding interrupt channel */
-	err = xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,NULL);
+	void (*handler)(unsigned, void *) = &xnintr_irq_handler;
+
+	if (intr->flags & XN_ISR_ISA)
+	    handler = &xnintr_isairq_handler;
+
+	err = xnarch_hook_irq(intr->irq,handler,intr->iack,NULL);
 	if (err)
 	    goto unlock_and_exit;
 	}
@@ -564,6 +573,70 @@ static void xnintr_irq_handler (unsigned
     xnltt_log_event(xeno_ev_iexit,irq);
 }
 
+#define MAX_ISA_COUNTER		128
+
+static void xnintr_isairq_handler (unsigned irq, void *cookie)
+
+{
+    xnsched_t *sched = xnpod_current_sched();
+    xnintr_shirq_t *shirq;
+    xnintr_t *intr, *end = NULL;
+    int s = 0, handled = 0, counter = 0;
+
+    xnarch_memory_barrier();
+
+    xnltt_log_event(xeno_ev_ienter,irq);
+
+    ++sched->inesting;
+
+    shirq = &xnshirqs[irq];
+
+    xnintr_shirq_lock(shirq);
+    intr = shirq->handlers;
+
+    while (intr != end)
+        {
+	int ret = intr->isr(intr);
+
+	if (!(ret & XN_ISR_NOINT))
+	    {
+	    handled = 1;
+	    end = NULL;
+	    s |= ret;
+	    }
+	else if (end == NULL)
+	    end = intr;
+
+	if (!counter++)
+    	    ++intr->hits;
+
+        if (!(intr = intr->next))
+	    intr = shirq->handlers;
+
+	if (counter > MAX_ISA_COUNTER)
+	    break;
+        }
+
+    xnintr_shirq_unlock(shirq);
+
+    --sched->inesting;
+
+    /* If we encounter this case, the line is non-usable any more. */
+    if (counter > MAX_ISA_COUNTER)
+	xnlogerr("xnintr_isairq_handler() : failed to get the IRQ%d line free.\n", irq);
+
+    if (s & XN_ISR_ENABLE)
+	xnarch_enable_irq(irq);
+
+    if (s & XN_ISR_CHAINED)
+	xnarch_chain_irq(irq);
+
+    if (sched->inesting == 0 && xnsched_resched_p())
+	xnpod_schedule();
+
+    xnltt_log_event(xeno_ev_iexit,irq);
+}
+
 int xnintr_irq_proc(unsigned int irq, char *str)
 {
     xnintr_shirq_t *shirq;

------=_Part_15280_29929138.1138829026267--

