Message-ID: <b647ffbd0602280120k745ee5e6t@domain.hid>
Date: Tue, 28 Feb 2006 11:20:42 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4403891C.5070603@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16186_1101529.1141118442814"
References: <b647ffbd0602270656m4719d6aes@domain.hid>
	<4403891C.5070603@domain.hid>
Subject: [Xenomai-core] Re: [PATCH] Shared interrupts (yet another movie :)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_16186_1101529.1141118442814
Content-Type: multipart/alternative; 
	boundary="----=_Part_16187_24914808.1141118442814"

------=_Part_16187_24914808.1141118442814
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 28/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > ...
> > Ok, are there any objections as to the current patch? If no, please
> apply.
> >
>
> Oops, I found a minor problem:
>
> make[2]: Entering directory `/usr/src/xenomai/build/doc/doxygen'
> doxygen
> /usr/src/xenomai/ksrc/skins/native/intr.c:523: Warning: no matching file
> member found for
> int rt_intr_create(RT_INTR *intr, unsigned irq, int mode)
> Possible candidates:
>   int rt_intr_create(RT_INTR *intr, const char *name, unsigned irq, int
> mode)


...

int rt_intr_bind(rt_intr_placeholder *intr, unsigned irq, RTIME timeout)
> Possible candidates:
>   int rt_intr_bind(RT_INTR *intr, const char *name, RTIME timeout)
>   int rt_intr_bind(RT_INTR *intr, const char *name, RTIME timeout)
>
> Seems the doc is not yet up-to-date.


Thanks. I have overlooked some parts. This patch fixes it up (should be
applied after the main patch).




Jan
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_16187_24914808.1141118442814
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 28/02/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt; ...<br>&gt; Ok, are there any objections as=
 to the current patch? If no, please apply.<br>&gt;<br><br>Oops, I found a =
minor problem:<br><br>make[2]: Entering directory `/usr/src/xenomai/build/d=
oc/doxygen'
<br>doxygen<br>/usr/src/xenomai/ksrc/skins/native/intr.c:523: Warning: no m=
atching file<br>member found for<br>int rt_intr_create(RT_INTR *intr, unsig=
ned irq, int mode)<br>Possible candidates:<br>&nbsp;&nbsp;int rt_intr_creat=
e(RT_INTR *intr, const char *name, unsigned irq, int
<br>mode)</blockquote><div><br>
... <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">int rt_=
intr_bind(rt_intr_placeholder *intr, unsigned irq, RTIME timeout)<br>Possib=
le candidates:
<br>&nbsp;&nbsp;int rt_intr_bind(RT_INTR *intr, const char *name, RTIME tim=
eout)<br>&nbsp;&nbsp;int rt_intr_bind(RT_INTR *intr, const char *name, RTIM=
E timeout)<br><br>Seems the doc is not yet up-to-date.</blockquote><div><br=
>
Thanks. I have overlooked some parts. This patch fixes it up (should be app=
lied after the main patch).<br>
<br>
&nbsp;<br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br>=
<br>
</blockquote></div><br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Ada=
mushko

------=_Part_16187_24914808.1141118442814--

------=_Part_16186_1101529.1141118442814
Content-Type: application/octet-stream; name=shirq-doc-update.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek0skdfa
Content-Disposition: attachment; filename="shirq-doc-update.patch"

diff -urp xenomai-prev/ksrc/skins/native/intr.c xenomai/ksrc/skins/native/intr.c
--- xenomai-prev/ksrc/skins/native/intr.c	2006-02-28 10:39:54.000000000 +0100
+++ xenomai/ksrc/skins/native/intr.c	2006-02-28 11:05:40.000000000 +0100
@@ -135,16 +135,30 @@ static xnpnode_t __intr_pnode = {
  * the interrupted stack context, the rescheduling procedure is
  * locked, and the interrupt source is masked at hardware level. The
  * status value returned by the ISR is then checked for the following
- * bits:
+ * values:
  *
- * - RT_INTR_ENABLE asks Xenomai to re-enable the IRQ line upon return of
- * the interrupt service routine.
+ * - RT_INTR_HANDLED indicates that the interrupt request has been fulfilled
+ * by the ISR.
  *
- * - RT_INTR_CHAINED tells Xenomai to propagate the interrupt down the
- * Adeos interrupt pipeline to other Adeos domains, such as
- * Linux. This is the regular way to share interrupts between Xenomai and
- * the Linux kernel. At the opposite, RT_INTR_HANDLED can be used
- * instead to indicate that the interrupt request has been fulfilled.
+ * - RT_INTR_NONE indicates the opposite to RT_INTR_HANDLED. The ISR must always
+ * return this value when it determines that the interrupt request has not been
+ * issued by the dedicated hardware device.
+ *
+ * In addition, one of the following bits may be set by the ISR :
+ *
+ * NOTE: use these bits with care and only when you do understand their effect
+ * on the system.
+ * The ISR is not encouraged to use these bits in case it shares the IRQ line
+ * with other ISRs in the real-time domain.
+ *
+ * - RT_INTR_PROPAGATE tells Xenomai to require the real-time control
+ * layer to forward the IRQ. For instance, this would cause the Adeos
+ * control layer to propagate the interrupt down the interrupt
+ * pipeline to other Adeos domains, such as Linux. This is the regular
+ * way to share interrupts between Xenomai and the Linux kernel.
+ *
+ * - RT_INTR_NOENABLE asks Xenomai not to re-enable the IRQ line upon return
+ * of the interrupt service routine.
  *
  * A count of interrupt receipts is tracked into the interrupt
  * descriptor, and reset to zero each time the interrupt object is
@@ -520,7 +534,7 @@ int rt_intr_inquire (RT_INTR *intr,
 }
 
 /*! 
- * \fn int rt_intr_create (RT_INTR *intr,unsigned irq,int mode)
+ * \fn int rt_intr_create (RT_INTR *intr,const char *name,unsigned irq,int mode)
  * \brief Create an interrupt object from user-space.
  *
  * Initializes and associates an interrupt object with an IRQ line
@@ -538,6 +552,11 @@ int rt_intr_inquire (RT_INTR *intr,
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
@@ -635,7 +654,7 @@ int rt_intr_inquire (RT_INTR *intr,
  */
 
 /**
- * @fn int rt_intr_bind(RT_INTR *intr,unsigned irq,RTIME timeout)
+ * @fn int rt_intr_bind(RT_INTR *intr,const char *name,RTIME timeout)
  * @brief Bind to an interrupt object.
  *
  * This user-space only service retrieves the uniform descriptor of a
@@ -645,14 +664,13 @@ int rt_intr_inquire (RT_INTR *intr,
  * interrupt is registered whenever a kernel-space task invokes the
  * rt_intr_create() service successfully for the given IRQ line.
  *
- * @param irq The hardware interrupt channel associated with the
- * interrupt object to search for. This value is
- * architecture-dependent.
- *
  * @param intr The address of an interrupt object descriptor retrieved
  * by the operation. Contents of this memory is undefined upon
  * failure.
  *
+ * @param name An ASCII string standing for the symbolic name of the
+ * interrupt object to search for.
+ *
  * @param timeout The number of clock ticks to wait for the
  * registration to occur (see note). Passing TM_INFINITE causes the
  * caller to block indefinitely until the object is

------=_Part_16186_1101529.1141118442814--

