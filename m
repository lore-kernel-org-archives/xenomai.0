From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Wed, 16 Aug 2006 20:20:45 +0200
References: <44E2DC1C.2010304@domain.hid>
	<200608161305.54411.Sebastian.Smolorz@domain.hid>
	<44E32B21.8060508@domain.hid>
In-Reply-To: <44E32B21.8060508@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9H24EcoFRmRVx8f"
Message-Id: <200608162020.45918.Sebastian.Smolorz@domain.hid>
Subject: [Xenomai-core] Re: Time representation in RTDM profiles
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
Cc: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_9H24EcoFRmRVx8f
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Jan Kiszka wrote:
> >> Sebastian Smolorz wrote:
> >>> The possibility of redefinition was not the main goal here. As you
> >>> mentioned it would be problematic. No, I introduced nanosecs_abs_t and
> >>> nanosecs_rel_t because they are more intuitive and more "speaking" to
> >>> the programmer. The meaning of a variable of such a type is clear at
> >>> first sight.
> >>
> >> Yeah, sounds reasonable to me. Then let's move these typedefs to rtdm.h
> >> and document them as self-explanatory defines of the underlying standard
> >> types, freezing their width and signedness at the same time.
> >
> > Agreed.
> >
> >> Actually, this would be useful for the driver API of RTDM as well.
> >
> > That's right. No objections from my side.
>
> Done.
>
> Though I checked things more then twice, some regression may be hidden,
> specifically as I changed the signedness of timeout parameters of a few
> RTDM driver API functions. All documented under
> ksrc/skins/rtdm/API.CHANGES, and everyone is warned now.

Here comes a follow-up patch. Compile-tested successfully.

Sebastian

--Boundary-00=_9H24EcoFRmRVx8f
Content-Type: text/x-diff; charset="iso-8859-15"; name="rtcan_timeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtcan_timeout.patch"

Index: include/rtdm/rtcan.h
===================================================================
--- include/rtdm/rtcan.h	(Revision 1450)
+++ include/rtdm/rtcan.h	(Arbeitskopie)
@@ -507,16 +507,6 @@
 /** @} */
 
 
-/*!
- * @anchor RTCAN_TIMEOUTS   @name Timeouts
- * Special reception and transmission timeouts
- * @{ */
-#define RTCAN_TIMEOUT_INFINITE    0     /**< wait for ever  */
-#define RTCAN_TIMEOUT_NONE        (-1)  /**< equivalent to non-blocking */
-/** @} */
-
-
-
 #define RTIOC_TYPE_CAN              RTDM_CLASS_CAN
 
 
@@ -946,7 +936,7 @@
  * @param [in] arg Pointer to @ref nanosecs_rel_t variable. The value is
  *                interpreted as relative timeout in nanoseconds in case
  *                of a positive value.
- *                See @ref RTCAN_TIMEOUTS "Timeouts" for special timeouts.
+ *                See @ref RTDM_TIMEOUT_xxx "Timeouts" for special timeouts.
  *
  * @return 0 on success, otherwise:
  * - -EFAULT: It was not possible to access user space memory area at the
@@ -976,7 +966,7 @@
  * @param [in] arg Pointer to @ref nanosecs_rel_t variable. The value is
  *                interpreted as relative timeout in nanoseconds in case
  *                of a positive value.
- *                See @ref RTCAN_TIMEOUTS "Timeouts" for special timeouts.
+ *                See @ref RTDM_TIMEOUT_xxx "Timeouts" for special timeouts.
  *
  * @return 0 on success, otherwise:
  * - -EFAULT: It was not possible to access user space memory area at the
Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 1450)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2006-08-16  Sebastian Smolorz  <Sebastian.Smolorz@domain.hid>
+
+	* include/rtdm/rtcan.h, ksrc/drivers/can/rtcan_{module,socket,raw}.c:
+	Get rid of RTCAN_TIMEOUT_* defines and replace them with RTDM_TIMEOUT_*
+
 2006-08-16  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* include/rtdm/*.h, ksrc/skins/rtdm/drvlib.c: Refactor RTDM types
Index: ksrc/drivers/can/rtcan_module.c
===================================================================
--- ksrc/drivers/can/rtcan_module.c	(Revision 1450)
+++ ksrc/drivers/can/rtcan_module.c	(Arbeitskopie)
@@ -112,7 +112,7 @@
 static void rtcan_get_timeout_name(nanosecs_rel_t timeout,
 				   char* name, int max_len)
 {
-    if (timeout == RTCAN_TIMEOUT_INFINITE) 
+    if (timeout == RTDM_TIMEOUT_INFINITE) 
 	strncpy(name, "infinite", max_len);
     else
 	sprintf(name, "%lld", timeout);
Index: ksrc/drivers/can/rtcan_socket.c
===================================================================
--- ksrc/drivers/can/rtcan_socket.c	(Revision 1450)
+++ ksrc/drivers/can/rtcan_socket.c	(Arbeitskopie)
@@ -49,8 +49,8 @@
     sock->err_mask = 0;
     sock->rx_buf_full = 0;
 
-    sock->tx_timeout = RTCAN_TIMEOUT_INFINITE;
-    sock->rx_timeout = RTCAN_TIMEOUT_INFINITE;
+    sock->tx_timeout = RTDM_TIMEOUT_INFINITE;
+    sock->rx_timeout = RTDM_TIMEOUT_INFINITE;
 
     INIT_LIST_HEAD(&sock->tx_wait_head);
     list_add(&sock->socket_list, &rtcan_socket_list);
Index: ksrc/drivers/can/rtcan_raw.c
===================================================================
--- ksrc/drivers/can/rtcan_raw.c	(Revision 1450)
+++ ksrc/drivers/can/rtcan_raw.c	(Arbeitskopie)
@@ -556,7 +556,7 @@
     /* Set RX timeout */
     rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
 
-    timeout = (flags & MSG_DONTWAIT) ? RTCAN_TIMEOUT_NONE : sock->rx_timeout;
+    timeout = (flags & MSG_DONTWAIT) ? RTDM_TIMEOUT_NONE : sock->rx_timeout;
 
     rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
 
@@ -839,7 +839,7 @@
    
     rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
 
-    timeout = (flags & MSG_DONTWAIT) ? RTCAN_TIMEOUT_NONE : sock->tx_timeout;
+    timeout = (flags & MSG_DONTWAIT) ? RTDM_TIMEOUT_NONE : sock->tx_timeout;
 
     rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
 

--Boundary-00=_9H24EcoFRmRVx8f--

