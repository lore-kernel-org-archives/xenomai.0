Message-ID: <470B32F0.6030601@domain.hid>
Date: Tue, 09 Oct 2007 09:51:12 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000508060508010608040503"
Subject: [Xenomai-core] [PATCH] documentation: rtdm functions available in
	user space
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
--------------000508060508010608040503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When checking the documentation I found that a lot of rtdm functions are 
indicated as available in user space, but AFAIK these functions are  
only available in kernel space or interrupt contect.
The documentation is generated using ksrc/skin/rtdm/drvlib.c. Below is a 
patch file that corrects this.

(I did not check other documentation to see if there are more functions 
defined for use in user space)

Kind regards,
    Johan Borkhuis


--------------000508060508010608040503
Content-Type: text/plain;
 name="xeno.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno.diff"

diff -r -u /opt/eldk/ppc_85xx/usr/src/org/xenomai-2.3.2/ksrc/skins/rtdm/drvlib.c /opt/eldk/ppc_85xx/usr/src/xenomai-2.3.2/ksrc/skins/rtdm/drvlib.c
--- /opt/eldk/ppc_85xx/usr/src/org/xenomai-2.3.2/ksrc/skins/rtdm/drvlib.c	2007-04-19 16:01:52.000000000 +0200
+++ /opt/eldk/ppc_85xx/usr/src/xenomai-2.3.2/ksrc/skins/rtdm/drvlib.c	2007-10-09 09:32:26.000000000 +0200
@@ -67,7 +67,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -106,7 +105,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -160,7 +158,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -180,7 +177,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -200,7 +196,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -221,7 +216,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: always, unless a timer overrun occured.
  */
@@ -240,7 +234,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -256,7 +249,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -284,7 +276,6 @@
  * This service can be called from:
  *
  * - Kernel module initialization/cleanup code
- * - User-space task (non-RT)
  *
  * Rescheduling: possible.
  */
@@ -330,7 +321,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: always.
  */
@@ -370,7 +360,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: always, unless the specified time already passed.
  */
@@ -419,7 +408,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine (should be avoided or kept short)
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never (except due to external interruptions).
  */
@@ -517,7 +505,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -542,7 +529,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -576,7 +562,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -598,7 +583,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -622,7 +606,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -666,7 +649,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: possible.
  */
@@ -709,7 +691,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: possible.
  */
@@ -783,7 +764,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -821,7 +801,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -854,7 +833,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -884,7 +862,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: possible.
  */
@@ -930,7 +907,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: possible.
  */
@@ -1002,7 +978,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -1046,7 +1021,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1078,7 +1052,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -1097,7 +1070,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -1125,7 +1097,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: possible.
  */
@@ -1167,7 +1138,6 @@
  * This service can be called from:
  *
  * - Kernel-based task
- * - User-space task (RT)
  *
  * Rescheduling: possible.
  */
@@ -1264,7 +1234,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1285,7 +1254,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1305,7 +1273,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: possible.
  */
@@ -1325,7 +1292,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1361,7 +1327,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1378,7 +1343,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1396,7 +1360,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never in real-time context, possible in non-real-time
  * environments.
@@ -1555,7 +1518,6 @@
  * This service can be called from:
  *
  * - Kernel module initialization/cleanup code
- * - User-space task (non-RT)
  *
  * Rescheduling: possible.
  */
@@ -1620,7 +1582,6 @@
  * This service can be called from:
  *
  * - Kernel module initialization/cleanup code
- * - User-space task (non-RT)
  *
  * Rescheduling: possible.
  */
@@ -1659,7 +1620,6 @@
  * This service can be called from:
  *
  * - Kernel module initialization/cleanup code
- * - User-space task (non-RT)
  *
  * Rescheduling: possible.
  */
@@ -1699,7 +1659,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine (consider the overhead!)
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never in real-time context, possible in non-real-time
  * environments.
@@ -1721,7 +1680,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine (consider the overhead!)
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1739,7 +1697,6 @@
  * - Kernel module initialization/cleanup code
  * - Interrupt service routine (consider the overhead!)
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1762,7 +1719,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1786,7 +1742,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1815,7 +1770,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1845,7 +1799,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1874,7 +1827,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1904,7 +1856,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1935,7 +1886,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */
@@ -1954,7 +1904,6 @@
  *
  * - Kernel module initialization/cleanup code
  * - Kernel-based task
- * - User-space task (RT, non-RT)
  *
  * Rescheduling: never.
  */

--------------000508060508010608040503--

