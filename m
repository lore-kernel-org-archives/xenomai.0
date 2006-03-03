Message-ID: <b647ffbd0603030252h5f54c436l@domain.hid>
Date: Fri, 3 Mar 2006 12:52:54 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4132_32178559.1141383174577"
Subject: [Xenomai-core] [RFC, Experimental Patch] nested irq disable calls
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

------=_Part_4132_32178559.1141383174577
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

the following patches illustrate _experimental_ implementation of nested ir=
q
disable calls.
This new feature would allow us to have scalar return values of ISR and
avoid the need
for NOENABLE bit.

[ Ok, repeating myself one more time... we would have NONE, HANDLED,
PROPAGATE and it would be possible
to call xnintr_disable_nosync()/even xnintr_disable() from the ISR to defer
the IRQ line
enabling. ]

The pre-requirement : implement as much code as possible on the Xeno layer
with zero or
minimal changes on the ipipe layer (at least, they should not be intrusive
and difficult to maintain for
different archs).


2 main issues which are quite arguable when it comes to possible
implementations :

1) we need to store the "depth" counter and IRQ_DISABLED bit somewhere
(actually, this bit is not that necessary
as the non-zero "depth" counter indicates the same).

So where? There is a sole per-IRQ table that's available for all possible
configs - ipipe_domain::irqs[NR_IRQS].

So the minor changes below don't make any structure bigger. Read the commen=
t
about the 3-d byte.


----------------------------- IPIPE changes
-------------------------------------------

--- ipipe.h    2006-02-27 15:10:41.000000000 +0100
+++ ipipe-exp.h    2006-03-02 12:08:27.000000000 +0100
@@ -62,6 +62,15 @@
 #define IPIPE_SHARED_FLAG    6
 #define IPIPE_EXCLUSIVE_FLAG    31    /* ipipe_catch_event() is the reason
why. */

+/*
+ * The 3-d byte of ipipe_domain::irqs[IRQ]::control is reserved for use
+ * by upper layers and must not be changed on the ipipe layer.
+ *
+ * e.g. experimantal support for nested irq disable calls in Xeno is based
on it.
+ */
+#define IPIPE_RESERVED_AREA_SHIFT    16
+#define IPIPE_RESERVED_AREA_MASK    (0xff << IPIPE_RESERVED_AREA_SHIFT)
+
 #define IPIPE_HANDLE_MASK    (1 << IPIPE_HANDLE_FLAG)
 #define IPIPE_PASS_MASK        (1 << IPIPE_PASS_FLAG)
 #define IPIPE_ENABLE_MASK    (1 << IPIPE_ENABLE_FLAG)
@@ -190,6 +199,12 @@ struct ipipe_domain_attr {

 #define __ipipe_cpudata_irq_hits(ipd,cpuid,irq)
((ipd)->cpudata[cpuid].irq_counters[irq].total_hits)

+#define __ipipe_get_reserved_area(ipd,irq) \
+    (((ipd)->irqs[irq].control & IPIPE_RESERVED_AREA_MASK) >>
IPIPE_RESERVED_AREA_SHIFT)
+
+#define __ipipe_set_reserved_area(ipd,irq,value) \
+    ((ipd)->irqs[irq].control &=3D (((value) << IPIPE_RESERVED_AREA_SHIFT)=
 &
IPIPE_RESERVED_AREA_MASK)
+
 #define __ipipe_set_irq_bit(ipd,cpuid,irq) \
 do { \
     if (!test_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) { \


---------------------------------------------------------------------------=
------------

2) We need somehow to force the .end handler of the PIC (only PPC arch make
uses of it at the moment;
other archs - use .enable instead as .ending for those is just .enabling) t=
o
_not_ re-enable the IRQ line
when the ISR has disabled the IRQ explicitly.

So there are 2 possible ways (at least, I can see only 2 now) :

    2.1) make changes for all PIC handlers supported for a given arch if
their .end handler is about re-enabling the IRQ line :

    BEFORE

    static void openpic_end_irq(unsigned int irq_nr)
    {
    if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
        && irq_desc[irq_nr].action)
        openpic_enable_irq(irq_nr);
    }


    AFTER

    static void openpic_end_irq(unsigned int irq_nr)
    {
    if (!ipipe_root_domain_p()
        &&
!test_bit(IPIPE_DISABLED_FLAG,&ipipe_current_domain->irqs[irq_nr].control))
        return;


    if (!ipipe_root_domain_p() || !(irq_desc[irq_nr].status &
(IRQ_DISABLED|IRQ_INPROGRESS))
        && irq_desc[irq_nr].action)
        openpic_enable_irq(irq_nr);
    }


    2.2) do some trick.

    That's how this patch does. But, well, I do _not_ like this way.

    Look at the xnarch_end_irq()'s implementation below.

---
p.s.

So I tend to think that 2.2 is, at the very least, ugly if even it seems to
be safe at the first glance.

2.1 would be better probably. But then the ipipe layer must know at least
the DISABLED bit. What concerns me is that the logic is implemented mostly
in Xeno but the bits of this interface (check for DISABLED bit in the .end
handlers) is visible for ipipe. Bad localization, I mean.
Maybe something different from ipipe_set/get_reserved_area() should be
introduced to make DISABLED bit and "depth" counter invisible for the Xeno.
Smth like ipipe_irq_depth_inc/dec() and
ipipe_irq_set/clear_disabled() .. I'm not sure yet.

>From another point of view, this new feature seems not to be too intrusive
and not something really affecting the "fast path" so it could be used by
default, I guess. Or maybe we don't need it at all?

Any comments please?

---


--------------------------------- XENO changes
------------------------------------------------

diff -urp xenomai/include/asm-generic/hal.h
xenomai-nirq-2/include/asm-generic/hal.h
--- xenomai/include/asm-generic/hal.h    2006-02-27 14:42:59.000000000 +010=
0
+++ xenomai-nirq-2/include/asm-generic/hal.h    2006-03-02 12:12:
55.000000000 +0100
@@ -106,6 +106,9 @@ typedef rwlock_t rthal_rwlock_t;

 #define rthal_cpudata_irq_hits(ipd,cpu,irq)
__ipipe_cpudata_irq_hits(ipd,cpu,irq)

+#define rthal_get_reserved_area(ipd,irq)
__ipipe_get_reserved_area(ipd,irq)
+#define rthal_set_reserved_area(ipd,irq,value)
__ipipe_set_reserved_area(ipd,irq,value)
+
 #define rthal_local_irq_disable()
ipipe_stall_pipeline_from(&rthal_domain)
 #define rthal_local_irq_enable()
ipipe_unstall_pipeline_from(&rthal_domain)
 #define rthal_local_irq_save(x)        ((x) =3D
!!ipipe_test_and_stall_pipeline_from(&rthal_domain))
diff -urp xenomai/include/asm-generic/system.h
xenomai-nirq-2/include/asm-generic/system.h
--- xenomai/include/asm-generic/system.h    2006-02-27 14:42:59.000000000+0=
100
+++ xenomai-nirq-2/include/asm-generic/system.h    2006-03-03 11:28:
09.000000000 +0100
@@ -490,6 +490,14 @@ static inline unsigned long long xnarch_

 #ifdef XENO_INTR_MODULE

+#ifdef CONFIG_SMP
+static xnlock_t xnarch_intr_lock =3D XNARCH_LOCK_UNLOCKED;
+#endif
+
+/* Operating the per-IRQ reserved area providen by the ipipe layer. */
+#define XNARCH_IRQ_DISABLED    0x80
+#define XNARCH_IRQ_DEPTH_MASK    0x7f
+
 static inline int xnarch_hook_irq (unsigned irq,
                    rthal_irq_handler_t handler,
                    rthal_irq_ackfn_t ackfn,
@@ -507,19 +515,81 @@ static inline int xnarch_release_irq (un
 static inline int xnarch_enable_irq (unsigned irq)

 {
-    return rthal_irq_enable(irq);
+    int ret =3D 0;
+    char area;
+    spl_t s;
+
+    xnlock_get_irqsave(&xnarch_intr_lock,s);
+
+    area =3D rthal_get_reserved_area(&rthal_domain,irq);
+    switch (area & XNARCH_IRQ_DEPTH_MASK)
+    {
+    case 0:
+        xnlogerr("xnintr_enable() : depth =3D=3D 0. "
+             "Unbalanced enable/disable calls for IRQ%d!\n",irq);
+        break;
+    case 1:
+        area &=3D ~XNARCH_IRQ_DISABLED;
+        ret =3D rthal_irq_enable(irq);
+    default:
+        rthal_set_reserved_area(&rthal_domain,irq,--area);
+    }
+
+    xnlock_put_irqrestore(&xnarch_intr_lock,s);
+    return ret;
 }

 static inline int xnarch_disable_irq (unsigned irq)

 {
-    return rthal_irq_disable(irq);
+    char area, depth;
+    int ret =3D 0;
+    spl_t s;
+
+    xnlock_get_irqsave(&xnarch_intr_lock,s);
+
+    area =3D rthal_get_reserved_area(&rthal_domain,irq);
+    depth =3D area & XNARCH_IRQ_DEPTH_MASK;
+
+    if (depth =3D=3D XNARCH_IRQ_DEPTH_MASK)
+    {
+    xnlogerr("xnintr_disable_nosync() : depth =3D=3D %d (MAX_ALLOWED)."
+         "Too many nested disable calls for IRQ%d.\n",depth,irq);
+    goto unlock_and_exit;
+    }
+
+    if (!depth)
+    {
+    area |=3D XNARCH_IRQ_DISABLED;
+    ret =3D rthal_irq_disable(irq);
+    }
+
+    rthal_set_reserved_area(&rthal_domain,irq,++area);
+
+unlock_and_exit:
+    xnlock_put_irqrestore(&xnarch_intr_lock,s);
+    return ret;
 }

 static inline int xnarch_end_irq (unsigned irq)

 {
-     return rthal_irq_end(irq);
+    int rt_off =3D rthal_get_reserved_area(&rthal_domain,irq) &
XNARCH_IRQ_DISABLED,
+    linux_off =3D rthal_irq_descp(irq)->status & IRQ_DISABLED,
+    ret;
+
+    if (rt_off)
+    set_bit(IRQ_DISABLED, &rthal_irq_descp(irq)->status);
+
+    /* We must not re-enable the IRQ line here in case it has been
explicitly
+       disabled by the ISR. To this end, we _temporary_ set the
IRQ_DISABLED bit
+       so that the .end handler of the PIC will not re-enable the IRQ line=
.
*/
+    ret =3D rthal_irq_end(irq);
+
+    if (!linux_off)
+    clear_bit(IRQ_DISABLED, &rthal_irq_descp(irq)->status);
+
+    return ret;
 }


 static inline void xnarch_chain_irq (unsigned irq)
diff -urp xenomai/include/nucleus/intr.h
xenomai-nirq-2/include/nucleus/intr.h
--- xenomai/include/nucleus/intr.h    2006-02-27 14:42:59.000000000 +0100
+++ xenomai-nirq-2/include/nucleus/intr.h    2006-03-03 11:26:14.000000000+=
0100
@@ -25,10 +25,7 @@
 /* Possible return values of ISR. */
 #define XN_ISR_NONE        0x1
 #define XN_ISR_HANDLED     0x2
-/* Additional bits. */
 #define XN_ISR_PROPAGATE 0x100
-#define XN_ISR_NOENABLE  0x200
-#define XN_ISR_BITMASK     ~0xff

 /* Creation flags. */
 #define XN_ISR_SHARED     0x1
diff -urp xenomai/ksrc/nucleus/intr.c xenomai-nirq-2/ksrc/nucleus/intr.c
--- xenomai/ksrc/nucleus/intr.c    2006-02-27 14:42:59.000000000 +0100
+++ xenomai-nirq-2/ksrc/nucleus/intr.c    2006-03-03 10:44:17.000000000+010=
0
@@ -46,6 +46,11 @@ static void xnintr_irq_handler(unsigned
 /* Helper functions. */
 static int xnintr_shirq_attach(xnintr_t *intr, void *cookie);
 static int xnintr_shirq_detach(xnintr_t *intr);
+static void xnintr_synchronize(xnintr_t *intr);
+
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+
+#define xnintr_synchronize(irq)    xnarch_memory_barrier()

 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */

@@ -72,27 +77,18 @@ static int xnintr_shirq_detach(xnintr_t
  * return this value when it determines that the interrupt request has not
been
  * issued by the dedicated hardware device.
  *
- * In addition, one of the following bits may be set by the ISR :
- *
- * NOTE: use these bits with care and only when you do understand their
effect
- * on the system.
- * The ISR is not encouraged to use these bits in case it shares the IRQ
line
- * with other ISRs in the real-time domain.
- *
  * - XN_ISR_PROPAGATE tells the nucleus to require the real-time control
  * layer to forward the IRQ. For instance, this would cause the Adeos
  * control layer to propagate the interrupt down the interrupt
  * pipeline to other Adeos domains, such as Linux. This is the regular
  * way to share interrupts between the nucleus and the host system.
  *
- * - XN_ISR_NOENABLE causes the nucleus to ask the real-time control
- * layer _not_ to re-enable the IRQ line (read the following section).
- * xnarch_end_irq() must be called to re-enable the IRQ line later.
- *
  * The nucleus re-enables the IRQ line by default. Over some real-time
  * control layers which mask and acknowledge IRQs, this operation is
  * necessary to revalidate the interrupt channel so that more interrupts
  * can be notified.
+ * The ISR may issue xnintr_disable_nosync() call in order to defer
+ * the IRQ line enabling until later.
  *
  * A count of interrupt receipts is tracked into the interrupt
  * descriptor, and reset to zero each time the interrupt object is
@@ -345,12 +341,22 @@ int xnintr_enable (xnintr_t *intr)
  * Rescheduling: never.
  */

-int xnintr_disable (xnintr_t *intr)
+int xnintr_disable_nosync (xnintr_t *intr)

 {
     return xnarch_disable_irq(intr->irq);
 }

+
+int xnintr_disable (xnintr_t *intr)
+
+{
+    int ret =3D xnintr_disable_nosync(intr);
+    xnintr_synchronize(intr);
+
+    return ret;
+}
+
 /*!
  * \fn xnarch_cpumask_t xnintr_affinity (xnintr_t *intr, xnarch_cpumask_t
cpumask)
  * \brief Set interrupt's processor affinity.
@@ -405,9 +411,9 @@ static void xnintr_irq_handler (unsigned
     s =3D intr->isr(intr);
     ++intr->hits;

-    if (s & XN_ISR_PROPAGATE)
+    if (s =3D=3D XN_ISR_PROPAGATE)
     xnarch_chain_irq(irq);
-    else if (!(s & XN_ISR_NOENABLE))
+    else
     xnarch_end_irq(irq);

     if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
@@ -487,7 +493,9 @@ static void xnintr_shirq_handler (unsign

     while (intr)
         {
-    s |=3D intr->isr(intr) & XN_ISR_BITMASK;
+    int temp =3D intr->isr(intr);
+    if (temp > s)
+        s =3D temp;
         ++intr->hits;
         intr =3D intr->next;
         }
@@ -495,9 +503,9 @@ static void xnintr_shirq_handler (unsign

     --sched->inesting;

-    if (s & XN_ISR_PROPAGATE)
+    if (s =3D=3D XN_ISR_PROPAGATE)
     xnarch_chain_irq(irq);
-    else if (!(s & XN_ISR_NOENABLE))
+    else
     xnarch_end_irq(irq);

     if (sched->inesting =3D=3D 0 && xnsched_resched_p())
@@ -535,19 +543,19 @@ static void xnintr_edge_shirq_handler (u

     while (intr !=3D end)
     {
-    int ret =3D intr->isr(intr),
-        code =3D ret & ~XN_ISR_BITMASK,
-        bits =3D ret & XN_ISR_BITMASK;
+    int ret =3D intr->isr(intr);

-    if (code =3D=3D XN_ISR_HANDLED)
+    if (ret =3D=3D XN_ISR_HANDLED)
         {
         ++intr->hits;
         end =3D NULL;
-        s |=3D bits;
         }
-    else if (code =3D=3D XN_ISR_NONE && end =3D=3D NULL)
+    else if (ret =3D=3D XN_ISR_NONE && end =3D=3D NULL)
         end =3D intr;

+    if (ret > s)
+        s =3D ret;
+
     if (counter++ > MAX_EDGEIRQ_COUNTER)
         break;

@@ -562,9 +570,9 @@ static void xnintr_edge_shirq_handler (u
     if (counter > MAX_EDGEIRQ_COUNTER)
     xnlogerr("xnintr_edge_shirq_handler() : failed to get the IRQ%d line
free.\n", irq);

-    if (s & XN_ISR_PROPAGATE)
+    if (s =3D=3D XN_ISR_PROPAGATE)
     xnarch_chain_irq(irq);
-    else if (!(s & XN_ISR_NOENABLE))
+    else
     xnarch_end_irq(irq);

     if (sched->inesting =3D=3D 0 && xnsched_resched_p())
@@ -645,7 +653,7 @@ unlock_and_exit:
     return err;
 }

-int xnintr_shirq_detach (xnintr_t *intr)
+static int xnintr_shirq_detach (xnintr_t *intr)
 {
     xnintr_shirq_t *shirq =3D &xnshirqs[intr->irq];
     xnintr_t *e, **p =3D &shirq->handlers;
@@ -695,6 +703,11 @@ int xnintr_shirq_detach (xnintr_t *intr)
     return err;
 }

+static void xnintr_synchronize (xnintr_t *intr)
+{
+    xnintr_shirq_spin(&xnshirqs[intr->irq]);
+}
+
 int xnintr_mount(void)
 {
     int i;


---------------------------------------------------------------------------=
--------------------




--
Best regards,
Dmitry Adamushko

------=_Part_4132_32178559.1141383174577
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi there,<br>
<br>
the following patches illustrate _experimental_ implementation of nested ir=
q disable calls.<br>
This new feature would allow us to have scalar return values of ISR and avo=
id the need<br>
for NOENABLE bit.<br>
<br>
[ Ok, repeating myself one more time... we would have NONE, HANDLED, PROPAG=
ATE and it would be possible<br>
to call xnintr_disable_nosync()/even xnintr_disable() from the ISR to defer=
 the IRQ line<br>
enabling. ]<br>
<br>
The pre-requirement : implement as much code as possible on the Xeno layer =
with zero or<br>
minimal changes on the ipipe layer (at least, they should not be intrusive =
and difficult to maintain for <br>
different archs).<br>
<br>
<br>
2 main issues which are quite arguable when it comes to possible implementa=
tions :<br>
<br>
1) we need to store the &quot;depth&quot; counter and IRQ_DISABLED bit some=
where (actually, this bit is not that necessary<br>
as the non-zero &quot;depth&quot; counter indicates the same).<br>
<br>
So where? There is a sole per-IRQ table that's available for all possible c=
onfigs - ipipe_domain::irqs[NR_IRQS].<br>
<br>
So the minor changes below don't make any structure bigger. Read the commen=
t about the 3-d byte.<br>
<br>
<br>
----------------------------- IPIPE changes -------------------------------=
------------<br>
<br>
--- ipipe.h&nbsp;&nbsp;&nbsp; 2006-02-27 15:10:41.000000000 +0100<br>
+++ ipipe-exp.h&nbsp;&nbsp;&nbsp; 2006-03-02 12:08:27.000000000 +0100<br>
@@ -62,6 +62,15 @@<br>
&nbsp;#define IPIPE_SHARED_FLAG&nbsp;&nbsp;&nbsp; 6<br>
&nbsp;#define IPIPE_EXCLUSIVE_FLAG&nbsp;&nbsp;&nbsp; 31&nbsp;&nbsp;&nbsp; /=
* ipipe_catch_event() is the reason why. */<br>
&nbsp;<br>
+/*<br>
+ * The 3-d byte of ipipe_domain::irqs[IRQ]::control is reserved for use<br=
>
+ * by upper layers and must not be changed on the ipipe layer.<br>
+ *&nbsp; <br>
+ * e.g. experimantal support for nested irq disable calls in Xeno is based=
 on it.<br>
+ */<br>
+#define IPIPE_RESERVED_AREA_SHIFT&nbsp;&nbsp;&nbsp; 16<br>
+#define IPIPE_RESERVED_AREA_MASK&nbsp;&nbsp;&nbsp; (0xff &lt;&lt; IPIPE_RE=
SERVED_AREA_SHIFT)<br>
+<br>
&nbsp;#define IPIPE_HANDLE_MASK&nbsp;&nbsp;&nbsp; (1 &lt;&lt; IPIPE_HANDLE_=
FLAG)<br>
&nbsp;#define IPIPE_PASS_MASK&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (1 &lt;&=
lt; IPIPE_PASS_FLAG)<br>
&nbsp;#define IPIPE_ENABLE_MASK&nbsp;&nbsp;&nbsp; (1 &lt;&lt; IPIPE_ENABLE_=
FLAG)<br>
@@ -190,6 +199,12 @@ struct ipipe_domain_attr {<br>
&nbsp;<br>
&nbsp;#define __ipipe_cpudata_irq_hits(ipd,cpuid,irq)&nbsp;&nbsp;&nbsp; ((i=
pd)-&gt;cpudata[cpuid].irq_counters[irq].total_hits)<br>
&nbsp;<br>
+#define __ipipe_get_reserved_area(ipd,irq) \<br>
+&nbsp;&nbsp;&nbsp; (((ipd)-&gt;irqs[irq].control &amp; IPIPE_RESERVED_AREA=
_MASK) &gt;&gt; IPIPE_RESERVED_AREA_SHIFT)<br>
+<br>
+#define __ipipe_set_reserved_area(ipd,irq,value) \<br>
+&nbsp;&nbsp;&nbsp; ((ipd)-&gt;irqs[irq].control &amp;=3D (((value)
&lt;&lt; IPIPE_RESERVED_AREA_SHIFT) &amp; IPIPE_RESERVED_AREA_MASK)<br>
+<br>
&nbsp;#define __ipipe_set_irq_bit(ipd,cpuid,irq) \<br>
&nbsp;do { \<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!test_bit(IPIPE_LOCK_FLAG,&amp;(ipd)-&gt;irqs[=
irq].control)) { \<br>
<br>
<br>
---------------------------------------------------------------------------=
------------<br>
<br>
2) We need somehow to force the .end handler of the PIC (only PPC arch make=
 uses of it at the moment;<br>
other archs - use .enable instead as .ending for those is just .enabling) t=
o _not_ re-enable the IRQ line<br>
when the ISR has disabled the IRQ explicitly.<br>
<br>
So there are 2 possible ways (at least, I can see only 2 now) :<br>
<br>
&nbsp;&nbsp;&nbsp; 2.1) make changes for all PIC handlers supported for
a given arch if their .end handler is about re-enabling the IRQ line :<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; BEFORE<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; static void openpic_end_irq(unsigned int irq_nr)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; if (!(irq_desc[irq_nr].status &amp; (IRQ_DISABLED|IRQ_IN=
PROGRESS))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &amp;&amp; irq_desc[irq_nr].action)<b=
r>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; openpic_enable_irq(irq_nr);<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; AFTER<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; static void openpic_end_irq(unsigned int irq_nr)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; if (!ipipe_root_domain_p() <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &amp;&amp;
!test_bit(IPIPE_DISABLED_FLAG,&amp;ipipe_current_domain-&gt;irqs[irq_nr].co=
ntrol))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; if (!ipipe_root_domain_p() || !(irq_desc[irq_nr].status =
&amp; (IRQ_DISABLED|IRQ_INPROGRESS))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &amp;&amp; irq_desc[irq_nr].action)<b=
r>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; openpic_enable_irq(irq_nr);<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; <br>
<br>
&nbsp;&nbsp;&nbsp; 2.2) do some trick.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; That's how this patch does. But, well, I do _not_ like t=
his way.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Look at the xnarch_end_irq()'s implementation below.<br>
&nbsp;&nbsp;&nbsp; <br>
---<br>
p.s.<br>
<br>
So I tend to think that 2.2 is, at the very least, ugly if even it seems to=
 be safe at the first glance.<br>
<br>
2.1 would be better probably. But then the ipipe layer must know at
least the DISABLED bit. What concerns me is that the logic is
implemented mostly in Xeno but the bits of this interface (check for
DISABLED bit in the .end handlers) is visible for ipipe. Bad
localization, I mean.<br>
Maybe something different from ipipe_set/get_reserved_area() should be
introduced to make DISABLED bit and &quot;depth&quot; counter invisible for=
 the
Xeno. Smth like ipipe_irq_depth_inc/dec() and<br>
ipipe_irq_set/clear_disabled() .. I'm not sure yet.<br>
<br>
>From another point of view, this new feature seems not to be too
intrusive and not something really affecting the &quot;fast path&quot; so i=
t
could be used by default, I guess. Or maybe we don't need it at all?<br>
<br>
Any comments please?<br>
<br>
---<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
--------------------------------- XENO changes ----------------------------=
--------------------<br>
<br>
diff -urp xenomai/include/asm-generic/hal.h xenomai-nirq-2/include/asm-gene=
ric/hal.h<br>
--- xenomai/include/asm-generic/hal.h&nbsp;&nbsp;&nbsp; 2006-02-27 14:42:59=
.000000000 +0100<br>
+++ xenomai-nirq-2/include/asm-generic/hal.h&nbsp;&nbsp;&nbsp; 2006-03-02 1=
2:12:55.000000000 +0100<br>
@@ -106,6 +106,9 @@ typedef rwlock_t rthal_rwlock_t;<br>
&nbsp;<br>
&nbsp;#define rthal_cpudata_irq_hits(ipd,cpu,irq)&nbsp;&nbsp;&nbsp; __ipipe=
_cpudata_irq_hits(ipd,cpu,irq)<br>
&nbsp;<br>
+#define rthal_get_reserved_area(ipd,irq)&nbsp;&nbsp;&nbsp; __ipipe_get_res=
erved_area(ipd,irq)<br>
+#define rthal_set_reserved_area(ipd,irq,value)&nbsp;&nbsp;&nbsp; __ipipe_s=
et_reserved_area(ipd,irq,value)<br>
+<br>
&nbsp;#define rthal_local_irq_disable()&nbsp;&nbsp;&nbsp; ipipe_stall_pipel=
ine_from(&amp;rthal_domain)<br>
&nbsp;#define rthal_local_irq_enable()&nbsp;&nbsp;&nbsp; ipipe_unstall_pipe=
line_from(&amp;rthal_domain)<br>
&nbsp;#define rthal_local_irq_save(x)&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; ((x) =3D
!!ipipe_test_and_stall_pipeline_from(&amp;rthal_domain))<br>
diff -urp xenomai/include/asm-generic/system.h xenomai-nirq-2/include/asm-g=
eneric/system.h<br>
--- xenomai/include/asm-generic/system.h&nbsp;&nbsp;&nbsp; 2006-02-27 14:42=
:59.000000000 +0100<br>
+++ xenomai-nirq-2/include/asm-generic/system.h&nbsp;&nbsp;&nbsp; 2006-03-0=
3 11:28:09.000000000 +0100<br>
@@ -490,6 +490,14 @@ static inline unsigned long long xnarch_<br>
&nbsp;<br>
&nbsp;#ifdef XENO_INTR_MODULE<br>
&nbsp;<br>
+#ifdef CONFIG_SMP<br>
+static xnlock_t xnarch_intr_lock =3D XNARCH_LOCK_UNLOCKED;<br>
+#endif<br>
+<br>
+/* Operating the per-IRQ reserved area providen by the ipipe layer. */<br>
+#define XNARCH_IRQ_DISABLED&nbsp;&nbsp;&nbsp; 0x80<br>
+#define XNARCH_IRQ_DEPTH_MASK&nbsp;&nbsp;&nbsp; 0x7f<br>
+<br>
&nbsp;static inline int xnarch_hook_irq (unsigned irq,<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp; rthal_irq_handler_t handler,<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp; rthal_irq_ackfn_t ackfn,<br>
@@ -507,19 +515,81 @@ static inline int xnarch_release_irq (un<br>
&nbsp;static inline int xnarch_enable_irq (unsigned irq)<br>
&nbsp;<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; return rthal_irq_enable(irq);<br>
+&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp; char area;<br>
+&nbsp;&nbsp;&nbsp; spl_t s;<br>
+<br>
+&nbsp;&nbsp;&nbsp; xnlock_get_irqsave(&amp;xnarch_intr_lock,s);<br>
+<br>
+&nbsp;&nbsp;&nbsp; area =3D rthal_get_reserved_area(&amp;rthal_domain,irq)=
;<br>
+&nbsp;&nbsp;&nbsp; switch (area &amp; XNARCH_IRQ_DEPTH_MASK)<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp; case 0:<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xnlogerr(&quot;xnintr_enable() : dep=
th =3D=3D 0. &quot;<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &quot;Unbal=
anced enable/disable calls for IRQ%d!\n&quot;,irq);<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case 1:<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; area &amp;=3D ~XNARCH_IRQ_DISABLED;<=
br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret =3D rthal_irq_enable(irq);<br>
+&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rthal_set_reserved_area(&amp;rthal_d=
omain,irq,--area);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; xnlock_put_irqrestore(&amp;xnarch_intr_lock,s);<br>
+&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline int xnarch_disable_irq (unsigned irq)<br>
&nbsp;<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; return rthal_irq_disable(irq);<br>
+&nbsp;&nbsp;&nbsp; char area, depth;<br>
+&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp; spl_t s;<br>
+&nbsp;&nbsp;&nbsp; <br>
+&nbsp;&nbsp;&nbsp; xnlock_get_irqsave(&amp;xnarch_intr_lock,s);<br>
+<br>
+&nbsp;&nbsp;&nbsp; area =3D rthal_get_reserved_area(&amp;rthal_domain,irq)=
;<br>
+&nbsp;&nbsp;&nbsp; depth =3D area &amp; XNARCH_IRQ_DEPTH_MASK;<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (depth =3D=3D XNARCH_IRQ_DEPTH_MASK)<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp; xnlogerr(&quot;xnintr_disable_nosync() : depth =3D=3D %=
d (MAX_ALLOWED).&quot;<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&quot;Too many nested disable =
calls for IRQ%d.\n&quot;,depth,irq);<br>
+&nbsp;&nbsp;&nbsp; goto unlock_and_exit;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (!depth)<br>
+&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp; area |=3D XNARCH_IRQ_DISABLED;<br>
+&nbsp;&nbsp;&nbsp; ret =3D rthal_irq_disable(irq);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; rthal_set_reserved_area(&amp;rthal_domain,irq,++area);<=
br>
+<br>
+unlock_and_exit:<br>
+&nbsp;&nbsp;&nbsp; xnlock_put_irqrestore(&amp;xnarch_intr_lock,s);<br>
+&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline int xnarch_end_irq (unsigned irq)<br>
&nbsp;<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp; return rthal_irq_end(irq);<br>
+&nbsp;&nbsp;&nbsp; int rt_off =3D rthal_get_reserved_area(&amp;rthal_domai=
n,irq) &amp; XNARCH_IRQ_DISABLED,<br>
+&nbsp;&nbsp;&nbsp; linux_off =3D rthal_irq_descp(irq)-&gt;status &amp; IRQ=
_DISABLED,<br>
+&nbsp;&nbsp;&nbsp; ret;<br>
+&nbsp;&nbsp;&nbsp; <br>
+&nbsp;&nbsp;&nbsp; if (rt_off)<br>
+&nbsp;&nbsp;&nbsp; set_bit(IRQ_DISABLED, &amp;rthal_irq_descp(irq)-&gt;sta=
tus);<br>
+<br>
+&nbsp;&nbsp;&nbsp; /* We must not re-enable the IRQ line here in case it h=
as been explicitly<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disabled by the ISR. To this end, we =
_temporary_ set the IRQ_DISABLED bit<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so that the .end handler of the PIC w=
ill not re-enable the IRQ line. */<br>
+&nbsp;&nbsp;&nbsp; ret =3D rthal_irq_end(irq);<br>
+<br>
+&nbsp;&nbsp;&nbsp; if (!linux_off)<br>
+&nbsp;&nbsp;&nbsp; clear_bit(IRQ_DISABLED, &amp;rthal_irq_descp(irq)-&gt;s=
tatus);<br>
+<br>
+&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
&nbsp;static inline void xnarch_chain_irq (unsigned irq)<br>
diff -urp xenomai/include/nucleus/intr.h xenomai-nirq-2/include/nucleus/int=
r.h<br>
--- xenomai/include/nucleus/intr.h&nbsp;&nbsp;&nbsp; 2006-02-27 14:42:59.00=
0000000 +0100<br>
+++ xenomai-nirq-2/include/nucleus/intr.h&nbsp;&nbsp;&nbsp; 2006-03-03 11:2=
6:14.000000000 +0100<br>
@@ -25,10 +25,7 @@<br>
&nbsp;/* Possible return values of ISR. */<br>
&nbsp;#define XN_ISR_NONE&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;0x1<br>
&nbsp;#define XN_ISR_HANDLED&nbsp;&nbsp;&nbsp; &nbsp;0x2<br>
-/* Additional bits. */<br>
&nbsp;#define XN_ISR_PROPAGATE 0x100<br>
-#define XN_ISR_NOENABLE&nbsp; 0x200<br>
-#define XN_ISR_BITMASK&nbsp;&nbsp;&nbsp; &nbsp;~0xff<br>
&nbsp;<br>
&nbsp;/* Creation flags. */<br>
&nbsp;#define XN_ISR_SHARED&nbsp;&nbsp;&nbsp; &nbsp;0x1<br>
diff -urp xenomai/ksrc/nucleus/intr.c xenomai-nirq-2/ksrc/nucleus/intr.c<br=
>
--- xenomai/ksrc/nucleus/intr.c&nbsp;&nbsp;&nbsp; 2006-02-27 14:42:59.00000=
0000 +0100<br>
+++ xenomai-nirq-2/ksrc/nucleus/intr.c&nbsp;&nbsp;&nbsp; 2006-03-03 10:44:1=
7.000000000 +0100<br>
@@ -46,6 +46,11 @@ static void xnintr_irq_handler(unsigned <br>
&nbsp;/* Helper functions. */<br>
&nbsp;static int xnintr_shirq_attach(xnintr_t *intr, void *cookie);<br>
&nbsp;static int xnintr_shirq_detach(xnintr_t *intr);<br>
+static void xnintr_synchronize(xnintr_t *intr);<br>
+<br>
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL &amp;&amp; !CONFIG_XENO_OPT_SHIRQ_ED=
GE */<br>
+<br>
+#define xnintr_synchronize(irq)&nbsp;&nbsp;&nbsp; xnarch_memory_barrier()<=
br>
&nbsp;<br>
&nbsp;#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE *=
/<br>
&nbsp;<br>
@@ -72,27 +77,18 @@ static int xnintr_shirq_detach(xnintr_t <br>
&nbsp; * return this value when it determines that the interrupt request ha=
s not been<br>
&nbsp; * issued by the dedicated hardware device.<br>
&nbsp; *<br>
- * In addition, one of the following bits may be set by the ISR :<br>
- *<br>
- * NOTE: use these bits with care and only when you do understand their ef=
fect<br>
- * on the system.<br>
- * The ISR is not encouraged to use these bits in case it shares the IRQ l=
ine<br>
- * with other ISRs in the real-time domain.<br>
- *<br>
&nbsp; * - XN_ISR_PROPAGATE tells the nucleus to require the real-time cont=
rol<br>
&nbsp; * layer to forward the IRQ. For instance, this would cause the Adeos=
<br>
&nbsp; * control layer to propagate the interrupt down the interrupt<br>
&nbsp; * pipeline to other Adeos domains, such as Linux. This is the regula=
r<br>
&nbsp; * way to share interrupts between the nucleus and the host system.<b=
r>
&nbsp; *<br>
- * - XN_ISR_NOENABLE causes the nucleus to ask the real-time control<br>
- * layer _not_ to re-enable the IRQ line (read the following section).<br>
- * xnarch_end_irq() must be called to re-enable the IRQ line later.<br>
- *<br>
&nbsp; * The nucleus re-enables the IRQ line by default. Over some real-tim=
e<br>
&nbsp; * control layers which mask and acknowledge IRQs, this operation is<=
br>
&nbsp; * necessary to revalidate the interrupt channel so that more interru=
pts<br>
&nbsp; * can be notified.<br>
+ * The ISR may issue xnintr_disable_nosync() call in order to defer<br>
+ * the IRQ line enabling until later.<br>
&nbsp; *<br>
&nbsp; * A count of interrupt receipts is tracked into the interrupt<br>
&nbsp; * descriptor, and reset to zero each time the interrupt object is<br=
>
@@ -345,12 +341,22 @@ int xnintr_enable (xnintr_t *intr)<br>
&nbsp; * Rescheduling: never.<br>
&nbsp; */<br>
&nbsp;<br>
-int xnintr_disable (xnintr_t *intr)<br>
+int xnintr_disable_nosync (xnintr_t *intr)<br>
&nbsp;<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; return xnarch_disable_irq(intr-&gt;irq);<br>
&nbsp;}<br>
&nbsp;<br>
+<br>
+int xnintr_disable (xnintr_t *intr)<br>
+<br>
+{<br>
+&nbsp;&nbsp;&nbsp; int ret =3D xnintr_disable_nosync(intr);<br>
+&nbsp;&nbsp;&nbsp; xnintr_synchronize(intr);<br>
+<br>
+&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;/*! <br>
&nbsp; * \fn xnarch_cpumask_t xnintr_affinity (xnintr_t *intr, xnarch_cpuma=
sk_t cpumask)<br>
&nbsp; * \brief Set interrupt's processor affinity.<br>
@@ -405,9 +411,9 @@ static void xnintr_irq_handler (unsigned<br>
&nbsp;&nbsp;&nbsp;&nbsp; s =3D intr-&gt;isr(intr);<br>
&nbsp;&nbsp;&nbsp;&nbsp; ++intr-&gt;hits;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (s &amp; XN_ISR_PROPAGATE)<br>
+&nbsp;&nbsp;&nbsp; if (s =3D=3D XN_ISR_PROPAGATE)<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnarch_chain_irq(irq);<br>
-&nbsp;&nbsp;&nbsp; else if (!(s &amp; XN_ISR_NOENABLE))<br>
+&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnarch_end_irq(irq);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (--sched-&gt;inesting =3D=3D 0 &amp;&amp; xnsch=
ed_resched_p())<br>
@@ -487,7 +493,9 @@ static void xnintr_shirq_handler (unsign<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; while (intr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp; s |=3D intr-&gt;isr(intr) &amp; XN_ISR_BITMASK;<br>
+&nbsp;&nbsp;&nbsp; int temp =3D intr-&gt;isr(intr);<br>
+&nbsp;&nbsp;&nbsp; if (temp &gt; s)<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; s =3D temp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++intr-&gt;hits;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intr =3D intr-&gt;next;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -495,9 +503,9 @@ static void xnintr_shirq_handler (unsign<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; --sched-&gt;inesting;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (s &amp; XN_ISR_PROPAGATE)<br>
+&nbsp;&nbsp;&nbsp; if (s =3D=3D XN_ISR_PROPAGATE)<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnarch_chain_irq(irq);<br>
-&nbsp;&nbsp;&nbsp; else if (!(s &amp; XN_ISR_NOENABLE))<br>
+&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnarch_end_irq(irq);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (sched-&gt;inesting =3D=3D 0 &amp;&amp; xnsched=
_resched_p())<br>
@@ -535,19 +543,19 @@ static void xnintr_edge_shirq_handler (u<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; while (intr !=3D end)<br>
&nbsp;&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp; int ret =3D intr-&gt;isr(intr),<br>
-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; code =3D ret &amp; ~XN_ISR_BITMASK,<=
br>
-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bits =3D ret &amp; XN_ISR_BITMASK;<b=
r>
+&nbsp;&nbsp;&nbsp; int ret =3D intr-&gt;isr(intr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (code =3D=3D XN_ISR_HANDLED)<br>
+&nbsp;&nbsp;&nbsp; if (ret =3D=3D XN_ISR_HANDLED)<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ++intr-&gt;hits;<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; end =3D NULL;<br>
-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; s |=3D bits;&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp; else if (code =3D=3D XN_ISR_NONE &amp;&amp; end =3D=3D =
NULL)<br>
+&nbsp;&nbsp;&nbsp; else if (ret =3D=3D XN_ISR_NONE &amp;&amp; end =3D=3D N=
ULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; end =3D intr;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; if (ret &gt; s)<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; s =3D ret;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (counter++ &gt; MAX_EDGEIRQ_COUNTER)<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
@@ -562,9 +570,9 @@ static void xnintr_edge_shirq_handler (u<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (counter &gt; MAX_EDGEIRQ_COUNTER)<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnlogerr(&quot;xnintr_edge_shirq_handler() : faile=
d to get the IRQ%d line free.\n&quot;, irq);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (s &amp; XN_ISR_PROPAGATE)<br>
+&nbsp;&nbsp;&nbsp; if (s =3D=3D XN_ISR_PROPAGATE)<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnarch_chain_irq(irq);<br>
-&nbsp;&nbsp;&nbsp; else if (!(s &amp; XN_ISR_NOENABLE))<br>
+&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnarch_end_irq(irq);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (sched-&gt;inesting =3D=3D 0 &amp;&amp; xnsched=
_resched_p())<br>
@@ -645,7 +653,7 @@ unlock_and_exit:<br>
&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;}<br>
&nbsp;<br>
-int xnintr_shirq_detach (xnintr_t *intr)<br>
+static int xnintr_shirq_detach (xnintr_t *intr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnintr_shirq_t *shirq =3D &amp;xnshirqs[intr-&gt;i=
rq];<br>
&nbsp;&nbsp;&nbsp;&nbsp; xnintr_t *e, **p =3D &amp;shirq-&gt;handlers;<br>
@@ -695,6 +703,11 @@ int xnintr_shirq_detach (xnintr_t *intr)<br>
&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;}<br>
&nbsp;<br>
+static void xnintr_synchronize (xnintr_t *intr)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; xnintr_shirq_spin(&amp;xnshirqs[intr-&gt;irq]);<br>
+}<br>
+<br>
&nbsp;int xnintr_mount(void)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
<br>
<br>
---------------------------------------------------------------------------=
--------------------<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; <br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_4132_32178559.1141383174577--

