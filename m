Message-ID: <4871CA89.8060703@domain.hid>
Date: Mon, 07 Jul 2008 09:49:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0b7c9c9d30b7cd3a2ecc4b3b5984d59c@domain.hid>
	<09aa4c21b4e9135f30c4805934e59099@domain.hid>
In-Reply-To: <09aa4c21b4e9135f30c4805934e59099@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
> Hi
> 
> As I have no answer to my questions, I would like to know if you have any
> solution ?
> 

Nobody answered likely because nobody actually understands what you are trying
to achieve, at least it is still vastly unclear to me. You will find a somewhat
fixed version below; this said, using a periodic RTDM task to do that does not
bring much value, except perhaps to demonstrate the use of decoupled timebases.

What has been suggested earlier was to use RTDM to relay tick forwarding
requests from a userland process to pace the VxWorks skin in kernel space (e.g.
using ioctl calls).

Again: read the timebase programming documentation to have a clearer view of the
timer core internals.

--- orig.c	2008-07-07 09:36:01.000000000 +0200
+++ frags/tickoverride/module.c	2008-07-07 09:33:52.000000000 +0200
@@ -5,7 +5,7 @@
 struct drv_context {
 };

-long tick_period=1;
+long tick_period=100000000;

 // RT_TASK vxworks_tick_task;
 rtdm_task_t vxworks_tick_task;
@@ -29,31 +29,31 @@
 /**********************************************************/
 /*            DRIVER OPEN                                 */
 /**********************************************************/
-void open_rt(struct rtdm_dev_context    *context,
+int open_rt(struct rtdm_dev_context    *context,
                  rtdm_user_info_t           *user_info,
                  int                        oflags)
 {
-
+  return 0;
 }

 /**********************************************************/
 /*            DRIVER CLOSE                                */
 /**********************************************************/
-void close_rt(struct rtdm_dev_context   *context,
+int close_rt(struct rtdm_dev_context   *context,
                   rtdm_user_info_t          *user_info)
 {
-
+  return 0;
 }

 /**********************************************************/
 /*            DRIVER IOCTL                                */
 /**********************************************************/
-void ioctl_rt(struct rtdm_dev_context   *context,
+int ioctl_rt(struct rtdm_dev_context   *context,
                   rtdm_user_info_t          *user_info,
-                  int                       request,
+                  unsigned                  request,
                   void                      *arg)
 {
-
+  return 0;
 }


@@ -103,11 +103,19 @@
     proc_name:          tick_driver.device_name,
 };

+extern xntbase_t *wind_tbase;
+
 /**********************************************************/
 /*            INIT DRIVER                                 */
 /**********************************************************/
 int init_module(void)
 {
+    int ret;
+
+    ret = xntbase_switch("vxworks", tick_period, &wind_tbase);
+    if (ret)
+        return ret;
+
     rtdm_dev_register(&tick_driver);
     rtdm_task_init(&vxworks_tick_task, "vxworks_tick_task", &vxworks_tick,
 NULL, 99, 0);
{rpm@xenomai.org} diff -u orig.c frags/tickoverride/module.c
--- orig.c	2008-07-07 09:36:01.000000000 +0200
+++ frags/tickoverride/module.c	2008-07-07 09:33:52.000000000 +0200
@@ -5,7 +5,7 @@
 struct drv_context {
 };

-long tick_period=1;
+long tick_period=100000000;

 // RT_TASK vxworks_tick_task;
 rtdm_task_t vxworks_tick_task;
@@ -29,31 +29,31 @@
 /**********************************************************/
 /*            DRIVER OPEN                                 */
 /**********************************************************/
-void open_rt(struct rtdm_dev_context    *context,
+int open_rt(struct rtdm_dev_context    *context,
                  rtdm_user_info_t           *user_info,
                  int                        oflags)
 {
-
+  return 0;
 }

 /**********************************************************/
 /*            DRIVER CLOSE                                */
 /**********************************************************/
-void close_rt(struct rtdm_dev_context   *context,
+int close_rt(struct rtdm_dev_context   *context,
                   rtdm_user_info_t          *user_info)
 {
-
+  return 0;
 }

 /**********************************************************/
 /*            DRIVER IOCTL                                */
 /**********************************************************/
-void ioctl_rt(struct rtdm_dev_context   *context,
+int ioctl_rt(struct rtdm_dev_context   *context,
                   rtdm_user_info_t          *user_info,
-                  int                       request,
+                  unsigned                  request,
                   void                      *arg)
 {
-
+  return 0;
 }


@@ -103,11 +103,19 @@
     proc_name:          tick_driver.device_name,
 };

+extern xntbase_t *wind_tbase;
+
 /**********************************************************/
 /*            INIT DRIVER                                 */
 /**********************************************************/
 int init_module(void)
 {
+    int ret;
+
+    ret = xntbase_switch("vxworks", tick_period, &wind_tbase);
+    if (ret)
+        return ret;
+
     rtdm_dev_register(&tick_driver);
     rtdm_task_init(&vxworks_tick_task, "vxworks_tick_task", &vxworks_tick,
 NULL, 99, 0);

-- 
Philippe.

