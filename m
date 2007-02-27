Message-ID: <45E3F802.5020907@domain.hid>
Date: Tue, 27 Feb 2007 10:21:06 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050107010200070502070507"
Subject: [Xenomai-core] Some doc improvements 
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050107010200070502070507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

attached is a patch improving the Doxygen generated documentation. If 
nobody complains, I will commit it to the trunk. Nevertheless, it 
remains the problem, that some symbols are not hyperlinked, mainly most 
of the rt_dev_* functions. For some strange reasons it works for a few, 
e.g. rt_dev_setsockopt. I tried Doxygen v1.5.1, which didn't help (but 
it has the nice frames, BTW). I'm going to report the problem on the 
Doxygen ML when time permits.

Wolfgang.

--------------050107010200070502070507
Content-Type: text/x-patch;
 name="xenomai-doc-improvements.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-doc-improvements.patch"

Index: include/rtdm/rttesting.h
===================================================================
--- include/rtdm/rttesting.h	(revision 2239)
+++ include/rtdm/rttesting.h	(working copy)
@@ -50,8 +50,8 @@
  * Specific return values: none @n
  * @n
  * @b IOCTL @n
- * Mandatory Environments: see @ref IOCTLs below @n
- * Specific return values: see @ref IOCTLs below @n
+ * Mandatory Environments: see @ref TSTIOCTLs below @n
+ * Specific return values: see @ref TSTIOCTLs below @n
  *
  * @{
  */
@@ -153,7 +153,7 @@ struct rttst_swtest_error {
 
 
 /*!
- * @anchor IOCTLs @name IOCTLs
+ * @anchor TSTIOCTLs @name IOCTLs
  * Testing device IOCTLs
  * @{ */
 #define RTTST_RTIOC_INTERM_BENCH_RES \
Index: include/rtdm/rtserial.h
===================================================================
--- include/rtdm/rtserial.h	(revision 2239)
+++ include/rtdm/rtserial.h	(working copy)
@@ -50,8 +50,8 @@
  * Specific return values: none @n
  * @n
  * @b IOCTL @n
- * Mandatory Environments: see @ref IOCTLs "below" @n
- * Specific return values: see @ref IOCTLs "below" @n
+ * Mandatory Environments: see @ref SERIOCTLs "below" @n
+ * Specific return values: see @ref SERIOCTLs "below" @n
  * @n
  * @b Read @n
  * Environments: RT (non-RT optional)@n
@@ -312,7 +312,7 @@ typedef struct rtser_event {
 
 
 /*!
- * @anchor IOCTLs @name IOCTLs
+ * @anchor SERIOCTLs @name IOCTLs
  * Serial device IOCTLs
  * @{ */
 
@@ -460,7 +460,7 @@ typedef struct rtser_event {
 /** @} */
 
 /*!
- * @anchor RTSERutils @name RT Serial example and utility programs
+ * @anchor SERutils @name RT Serial example and utility programs
  * @{ */
 /** @example cross-link.c */
 /** @} */
Index: include/rtdm/rtcan.h
===================================================================
--- include/rtdm/rtcan.h	(revision 2239)
+++ include/rtdm/rtcan.h	(working copy)
@@ -78,8 +78,8 @@
  * @n
  * @n
  * @b IOCTL @n
- * Mandatory Environments: see @ref IOCTLs "below" @n
- * Specific return values: see @ref IOCTLs "below" @n
+ * Mandatory Environments: see @ref CANIOCTLs "below" @n
+ * Specific return values: see @ref CANIOCTLs "below" @n
  * @n
  * @n
  * @anchor Bind
@@ -252,7 +252,7 @@
 
 #include <rtdm/rtdm.h>
 
-#define RTCAN_PROFILE_VER           2
+#define RTCAN_PROFILE_VER  2
 
 #ifndef AF_CAN
 
@@ -264,6 +264,18 @@
 
 #endif
 
+/** Particular CAN protocols
+ *
+ *  Currently only the RAW protocol is supported.
+ */
+#define CAN_RAW  0
+
+/** CAN socket levels
+ *
+ *  Used for @ref Sockopts for the particular protocols.
+ */
+#define SOL_CAN_RAW  103
+
 /** Type of CAN id (see @ref CAN_xxx_MASK and @ref CAN_xxx_FLAG) */
 typedef uint32_t can_id_t;
 typedef uint32_t canid_t;
@@ -306,7 +318,7 @@ typedef can_id_t can_err_mask_t;
  * Possible protocols for PF_CAN protocol family
  * @{ */
 enum CAN_PROTO {
-    /** Raw protocol of @c PF_CAN, applicable to socket 
+    /** Raw protocol of @c PF_CAN, applicable to socket
 	type @c SOCK_RAW */
     CAN_PROTO_RAW,
     CAN_PROTO_MAX
@@ -527,9 +539,6 @@ typedef struct can_frame {
 
 #define RTIOC_TYPE_CAN              RTDM_CLASS_CAN
 
-
-#define SOL_CAN_RAW 103
-
 /*!
  * @anchor Rawsockopts @name RAW socket options
  * Setting and getting CAN RAW socket options.
@@ -631,7 +640,7 @@ typedef struct can_frame {
 /** @} */
 
 /*!
- * @anchor IOCTLs @name IOCTLs
+ * @anchor CANIOCTLs @name IOCTLs
  * CAN device IOCTLs
  * @{ */
 
Index: src/utils/can/rtcansend.c
===================================================================
--- src/utils/can/rtcansend.c	(revision 2239)
+++ src/utils/can/rtcansend.c	(working copy)
@@ -216,7 +216,7 @@ int main(int argc, char **argv)
     if (verbose)
 	printf("interface %s\n", argv[optind]);
 
-    ret = rt_dev_socket(PF_CAN, SOCK_RAW, 0);
+    ret = rt_dev_socket(PF_CAN, SOCK_RAW, CAN_RAW);
     if (ret < 0) {
 	fprintf(stderr, "rt_dev_socket: %s\n", strerror(-ret));
 	return -1;
Index: src/utils/can/rtcanrecv.c
===================================================================
--- src/utils/can/rtcanrecv.c	(revision 2239)
+++ src/utils/can/rtcanrecv.c	(working copy)
@@ -236,7 +236,7 @@ int main(int argc, char **argv)
 	}
     }
 
-    ret = rt_dev_socket(PF_CAN, SOCK_RAW, 0);
+    ret = rt_dev_socket(PF_CAN, SOCK_RAW, CAN_RAW);
     if (ret < 0) {
 	fprintf(stderr, "rt_dev_socket: %s\n", strerror(-ret));
 	return -1;
Index: src/utils/can/rtcanconfig.c
===================================================================
--- src/utils/can/rtcanconfig.c	(revision 2239)
+++ src/utils/can/rtcanconfig.c	(working copy)
@@ -168,7 +168,7 @@ int main(int argc, char *argv[])
 	}
     }
 
-    can_fd = rt_dev_socket(PF_CAN, SOCK_RAW, 0);
+    can_fd = rt_dev_socket(PF_CAN, SOCK_RAW, CAN_RAW);
     if (can_fd < 0) {
 	fprintf(stderr, "Cannot open RTDM CAN socket. Maybe driver not loaded? \n");
 	return can_fd;
Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(revision 2239)
+++ ksrc/skins/native/task.c	(working copy)
@@ -42,6 +42,7 @@
 /** @example kernel_task.c */
 /** @example bound_task.c */
 /** @example sigxcpu.c */
+/** @example trivial-periodic.c */
 
 #include <nucleus/pod.h>
 #include <nucleus/heap.h>
Index: examples/rtdm/profiles/can/rtcan_rtt.c
===================================================================
--- examples/rtdm/profiles/can/rtcan_rtt.c	(revision 2239)
+++ examples/rtdm/profiles/can/rtcan_rtt.c	(working copy)
@@ -237,7 +237,7 @@ int main(int argc, char *argv[])
     rxdev = argv[optind + 1];
 
     /* Create and configure RX socket */
-    if ((rxsock = socket(PF_CAN, SOCK_RAW, 0)) < 0) {
+    if ((rxsock = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
 	perror("RX socket failed");
 	return -1;
     }

--------------050107010200070502070507--

