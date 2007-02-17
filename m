Message-ID: <45D76A71.20504@domain.hid>
Date: Sat, 17 Feb 2007 21:49:53 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Extended CAN frame filtering
References: <45D338C2.9030203@domain.hid> <45D5A56F.8080900@domain.hid>
	<45D711DF.8060802@domain.hid> <45D741AE.9020501@domain.hid>
	<45D7475E.1030504@domain.hid> <45D74F70.2090200@domain.hid>
In-Reply-To: <45D74F70.2090200@domain.hid>
Content-Type: multipart/mixed; boundary="------------020008010906040908010308"
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

This is a multi-part message in MIME format.
--------------020008010906040908010308
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>>>> Index: ksrc/drivers/can/rtcan_raw_filter.c
>>>> ===================================================================
>>>> --- ksrc/drivers/can/rtcan_raw_filter.c    (revision 2193)
>>>> +++ ksrc/drivers/can/rtcan_raw_filter.c    (working copy)
>>>> @@ -55,13 +55,13 @@ void rtcan_raw_print_filter(struct rtcan
>>>>  static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,
>>>>                        can_filter_t *filter)
>>>>  {
>>>> -   if (filter->can_id & CAN_EFF_FLAG)
>>>> -    recv_filter->can_mask = ((filter->can_mask & CAN_EFF_MASK) |
>>>> -                 CAN_EFF_FLAG);
>>>> -    else
>>>> -    recv_filter->can_mask = (filter->can_mask & CAN_SFF_MASK);
>>>> -
>>>> -    recv_filter->can_id = filter->can_id & recv_filter->can_mask;
>>>> +    if (filter->can_id & CAN_INV_FILTER) {
>>>> +    recv_filter->can_id = filter->can_id & ~CAN_INV_FILTER;
>>>> +    recv_filter->can_mask = filter->can_mask | CAN_INV_FILTER;
>>>> +    } else {
>>>> +    recv_filter->can_id = filter->can_id;
>>>> +    recv_filter->can_mask = filter->can_mask & ~CAN_INV_FILTER;
>>>> +    }
>>> Why do you push CAN_INV_FILTER internally into the mask instead of
>>> keeping it in the filter's ID - as the pseudo code above states?
>> To simplify the filter calculation. It actually avoids the expression
>> (filter->can_id & ~CAN_INV_FILTER). As this is in a very frequently
>> called function, I think it's worth the trick.
>>
> 
> Ack. I missed that point on first run.

Attached is a revised patch including change log entry. As this patch 
just extends the existing filter capabilities, it could be applied to 
trunk and the 2.3.x branch as well.

Wolfgang.

--------------020008010906040908010308
Content-Type: text/x-patch;
 name="xenomai-rtcan-filter-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-filter-2.patch"

Index: include/rtdm/rtcan.h
===================================================================
--- include/rtdm/rtcan.h	(revision 2193)
+++ include/rtdm/rtcan.h	(working copy)
@@ -289,9 +289,15 @@ typedef can_id_t can_err_mask_t;
  * @anchor CAN_xxx_FLAG @name CAN ID flags
  * Flags within a CAN ID indicating special CAN frame attributes
  * @{ */
-#define CAN_EFF_FLAG  0x80000000 /**< extended frame           */
-#define CAN_RTR_FLAG  0x40000000 /**< remote transmission flag */
-#define CAN_ERR_FLAG  0x20000000 /**< error frame (see @ref Errors) */
+/** Extended frame */
+#define CAN_EFF_FLAG  0x80000000
+/** Remote transmission frame */
+#define CAN_RTR_FLAG  0x40000000
+/** Error frame (see @ref Errors) */
+#define CAN_ERR_FLAG  0x20000000
+/** Invert CAN filter definition (used for struct can_filter) */
+#define CAN_INV_FILTER CAN_ERR_FLAG
+
 /** @} */
 
 
@@ -446,23 +452,30 @@ typedef enum CAN_STATE can_state_t;
  *
  * This filter works as follows:
  * A received CAN ID is AND'ed bitwise with @c can_mask and then compared to
- * @c can_id. If this comparison is true the message will be received by the
- * socket.
+ * @c can_id. This also includes the @ref CAN_EFF_FLAG and @ref CAN_RTR_FLAG
+ * of @ref CAN_xxx_FLAG. If this comparison is true, the message will be
+ * received by the socket. The logic can be inverted with the @c can_id flag
+ * @ref CAN_INV_FILTER :
+ *
+ * @code
+ * if (can_id & CAN_INV_FILTER) {
+ *    if ((received_can_id & can_mask) != (can_id & ~CAN_INV_FILTER))
+ *       accept-message;
+ * } else {
+ *    if ((received_can_id & can_mask) == can_id)
+ *       accept-message;
+ * }
+ * @endcode
  *
- * Multiple filters can be arranged in a filter list and set with 
- * @ref Sockopts. If one of these filters matches a CAN ID upon reception 
+ * Multiple filters can be arranged in a filter list and set with
+ * @ref Sockopts. If one of these filters matches a CAN ID upon reception
  * of a CAN frame, this frame is accepted.
  *
- * @note Only @ref CAN_EFF_FLAG of @ref CAN_xxx_FLAG "CAN ID flags" is
- * valid for @c can_id and none for @c can_mask. This means that the RTR bit
- * is not taken into account while filtering messages.
- *
- * Extended IDs are received only if @ref CAN_EFF_FLAG is set in
- * @c can_id. If it is cleared only standard IDs are accepted.
  */
 typedef struct can_filter {
 
-    /** CAN ID which must match with incoming IDs after passing the mask */
+    /** CAN ID which must match with incoming IDs after passing the mask.
+     *  The filter logic can be inverted with the flag @ref CAN_INV_FILTER. */
     uint32_t    can_id;
 
     /** Mask which is applied to incoming IDs. See @ref CAN_xxx_MASK
@@ -470,12 +483,11 @@ typedef struct can_filter {
     uint32_t    can_mask;
 } can_filter_t;
 
-
 /**
  * Socket address structure for the CAN address family
  */
 struct sockaddr_can {
-    /** CAN address family, must be @c AF_CAN */    
+    /** CAN address family, must be @c AF_CAN */
     sa_family_t  can_family;
     /** Interface index of CAN controller. See @ref SIOCGIFINDEX. */
     int          can_ifindex;
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 2193)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2007-02-17  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/rtcan_raw.c, ksrc/drivers/can/rtcan_raw_filter.c,
+	ksrc/drivers/can/rtcan_module.c, include/rtdm/rtcan.h: The CAN filter
+	definition can now be inverted with the can_id flag CAN_INV_FILTER.
+
 2007-02-16  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/skins/native/queue.c (rt_queue_delete): 
@@ -57,7 +63,6 @@
 
 	* ksrc/nucleus/pipe.c (xnpipe_write): Use regular copy_from_user()
 	and check return value.
-
 2007-02-07  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/arch/i386/patches: Upgrade to 2.6.19-1.7-01.
Index: ksrc/drivers/can/rtcan_module.c
===================================================================
--- ksrc/drivers/can/rtcan_module.c	(revision 2193)
+++ ksrc/drivers/can/rtcan_module.c	(working copy)
@@ -262,11 +262,11 @@ static int rtcan_read_proc_filter(char *
     rtdm_lockctx_t lock_ctx;
     RTCAN_PROC_PRINT_VARS(80);
 
-    /*  fd __CAN_ID__ _CAN_Mask_ MatchCount
-     *   3 0x12345678 0x12345678 1234567890
+    /*  fd __CAN_ID__ _CAN_Mask_ Inv MatchCount
+     *   3 0x12345678 0x12345678  no 1234567890
      */
-    
-    if (!RTCAN_PROC_PRINT("fd __CAN_ID__ _CAN_Mask_ MatchCount\n"))
+
+    if (!RTCAN_PROC_PRINT("fd __CAN_ID__ _CAN_Mask_ Inv MatchCount\n"))
         goto done;
 
     rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
@@ -275,10 +275,13 @@ static int rtcan_read_proc_filter(char *
     while (recv_listener != NULL) {
 	context = rtcan_socket_context(recv_listener->sock);
 
-	if (!RTCAN_PROC_PRINT("%2d 0x%08x 0x%08x %10d\n",
-			      context->fd, 
+	if (!RTCAN_PROC_PRINT("%2d 0x%08x 0x%08x %s %10d\n",
+			      context->fd,
 			      recv_listener->can_filter.can_id,
-			      recv_listener->can_filter.can_mask,
+			      recv_listener->can_filter.can_mask &
+			      ~CAN_INV_FILTER,
+			      (recv_listener->can_filter.can_mask &
+			       CAN_INV_FILTER) ? "yes" : " no",
 			      recv_listener->match_count))
 	    break;
 	recv_listener = recv_listener->next;
Index: ksrc/drivers/can/rtcan_raw.c
===================================================================
--- ksrc/drivers/can/rtcan_raw.c	(revision 2193)
+++ ksrc/drivers/can/rtcan_raw.c	(working copy)
@@ -67,7 +67,10 @@ static struct rtdm_device rtcan_proto_ra
 
 static inline int rtcan_accept_msg(uint32_t can_id, can_filter_t *filter)
 {
-    return ((can_id & filter->can_mask) == filter->can_id);
+    if ((filter->can_mask & CAN_INV_FILTER))
+	return ((can_id & filter->can_mask) != filter->can_id);
+    else
+	return ((can_id & filter->can_mask) == filter->can_id);
 }
 
 
Index: ksrc/drivers/can/rtcan_raw_filter.c
===================================================================
--- ksrc/drivers/can/rtcan_raw_filter.c	(revision 2193)
+++ ksrc/drivers/can/rtcan_raw_filter.c	(working copy)
@@ -55,13 +55,13 @@ void rtcan_raw_print_filter(struct rtcan
 static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,
 					  can_filter_t *filter)
 {
-   if (filter->can_id & CAN_EFF_FLAG)
-	recv_filter->can_mask = ((filter->can_mask & CAN_EFF_MASK) |
-				 CAN_EFF_FLAG);
-    else
-	recv_filter->can_mask = (filter->can_mask & CAN_SFF_MASK);
-
-    recv_filter->can_id = filter->can_id & recv_filter->can_mask;
+    if (filter->can_id & CAN_INV_FILTER) {
+	recv_filter->can_id = filter->can_id & ~CAN_INV_FILTER;
+	recv_filter->can_mask = filter->can_mask | CAN_INV_FILTER;
+    } else {
+	recv_filter->can_id = filter->can_id;
+	recv_filter->can_mask = filter->can_mask & ~CAN_INV_FILTER;
+    }
 }
 
 

--------------020008010906040908010308--

