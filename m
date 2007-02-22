Message-ID: <45DD54A4.5040204@domain.hid>
Date: Thu, 22 Feb 2007 09:30:28 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45DC1D05.1000206@domain.hid>
	<45DC2478.2020602@domain.hid>	<45DC39DE.8050802@domain.hid>
	<45DC3E6C.8040905@domain.hid> <45DC4281.8030903@domain.hid>
	<45DC9C9D.4050107@domain.hid>
In-Reply-To: <45DC9C9D.4050107@domain.hid>
Content-Type: multipart/mixed; boundary="------------050101060303020008070509"
Subject: [Xenomai-core] Re: (was: [Xenomai-help] CAN driver)
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
--------------050101060303020008070509
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gilles and Jan,

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>>>> BTW: some time ago I provided a patch to make the CAN utility programs
>>>> part of the Doxygen documentation. IIRC, we said it's nice to have
>>>> hyperlinked examples in general.
>>> Some link at hand? Does it still apply? Sounds like something worth to
>>> apply.
>> See https://mail.gna.org/public/xenomai-core/2006-11/msg00033.html.
>> My patch was for the CAN utilities only. The idea was to have a more
>> general implementation including code snippets and now examples as well.
>>
>> Wolfgang.
>>
> 
> Gilles, as you are planning to regenerate the docs for trunk anyway,
> would you merge this patch (or better the corrected version) at that chance?

Attached is a revised patch for hyper-linking with example and utility 
programs. Apart from the CAN utilities, I have also added cross-link.c 
for RTserial and the code snippets of the native skin by adding 
"@example" tags to the appropriate source files. For the "demos" of the 
skins it was not obvious for me where to put them. The examples are then 
also part of the PDF documentation. Please have a look, hope you like 
it. I personally find the hyper-linking very useful.

Wolfgang.

--------------050101060303020008070509
Content-Type: text/x-patch;
 name="xenomai-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-doc.patch"

Index: include/rtdm/rtserial.h
===================================================================
--- include/rtdm/rtserial.h	(revision 2221)
+++ include/rtdm/rtserial.h	(working copy)
@@ -459,6 +459,12 @@ typedef struct rtser_event {
     _IOR(RTIOC_TYPE_SERIAL, 0x05, struct rtser_event)
 /** @} */
 
+/*!
+ * @anchor RTSERutils @name RT Serial example and utility programs
+ * @{ */
+/** @example cross-link.c */
+/** @} */
+
 /** @} */
 
 #endif /* _RTSERIAL_H */
Index: include/rtdm/rtcan.h
===================================================================
--- include/rtdm/rtcan.h	(revision 2221)
+++ include/rtdm/rtcan.h	(working copy)
@@ -1163,6 +1163,15 @@ typedef struct can_frame {
 
 /** @} */
 
+/*!
+ * @anchor CANutils @name CAN example and utility programs
+ * @{ */
+/** @example rtcanconfig.c */
+/** @example rtcansend.c */
+/** @example rtcanrecv.c */
+/** @example rtcan_rtt.c */
+/** @} */
+
 /** @} */
 
 
Index: ksrc/skins/native/mutex.c
===================================================================
--- ksrc/skins/native/mutex.c	(revision 2221)
+++ ksrc/skins/native/mutex.c	(working copy)
@@ -42,6 +42,8 @@
  *
  *@{*/
 
+/** @example mutex.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(revision 2221)
+++ ksrc/skins/native/task.c	(working copy)
@@ -38,6 +38,11 @@
  *
  *@{*/
 
+/** @example user_task.c */
+/** @example kernel_task.c */
+/** @example bound_task.c */
+/** @example sigxcpu.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/heap.h>
 #include <nucleus/registry.h>
Index: ksrc/skins/native/intr.c
===================================================================
--- ksrc/skins/native/intr.c	(revision 2221)
+++ ksrc/skins/native/intr.c	(working copy)
@@ -27,6 +27,8 @@
  *
  *@{*/
 
+/** @example user_irq.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/heap.c
===================================================================
--- ksrc/skins/native/heap.c	(revision 2221)
+++ ksrc/skins/native/heap.c	(working copy)
@@ -41,6 +41,9 @@
  *
  *@{*/
 
+/** @example local_heap.c */
+/** @example shared_mem.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/event.c
===================================================================
--- ksrc/skins/native/event.c	(revision 2221)
+++ ksrc/skins/native/event.c	(working copy)
@@ -37,6 +37,8 @@
  *
  *@{*/
 
+/** @example event_flags.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/cond.c
===================================================================
--- ksrc/skins/native/cond.c	(revision 2221)
+++ ksrc/skins/native/cond.c	(working copy)
@@ -39,6 +39,8 @@
  *
  *@{*/
 
+/** @example cond_var.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/sem.c
===================================================================
--- ksrc/skins/native/sem.c	(revision 2221)
+++ ksrc/skins/native/sem.c	(working copy)
@@ -40,6 +40,8 @@
  *
  *@{*/
 
+/** @example semaphore.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/queue.c
===================================================================
--- ksrc/skins/native/queue.c	(revision 2221)
+++ ksrc/skins/native/queue.c	(working copy)
@@ -40,6 +40,8 @@
  *
  *@{*/
 
+/** @example msg_queue.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/alarm.c
===================================================================
--- ksrc/skins/native/alarm.c	(revision 2221)
+++ ksrc/skins/native/alarm.c	(working copy)
@@ -34,6 +34,8 @@
  *
  *@{*/
 
+/** @example user_alarm.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <native/task.h>
Index: ksrc/skins/native/pipe.c
===================================================================
--- ksrc/skins/native/pipe.c	(revision 2221)
+++ ksrc/skins/native/pipe.c	(working copy)
@@ -45,6 +45,8 @@
  *
  *@{*/
 
+/** @example pipe.c */
+
 #include <nucleus/pod.h>
 #include <nucleus/heap.h>
 #include <nucleus/registry.h>
Index: doc/doxygen/Doxyfile-common.in
===================================================================
--- doc/doxygen/Doxyfile-common.in	(revision 2221)
+++ doc/doxygen/Doxyfile-common.in	(working copy)
@@ -389,21 +389,27 @@ EXCLUDE_PATTERNS       = 
 # directories that contain example code fragments that are included (see 
 # the \include command).
 
-EXAMPLE_PATH           = 
+EXAMPLE_PATH           = ../../ksrc/skins/native/snippets \
+		         ../../ksrc/skins/native/demos \
+		         ../../ksrc/skins/posix/demos \
+		         ../../ksrc/skins/psos+/demos \
+		         ../../ksrc/skins/vxworks/demos \
+		         ../../src/utils \
+			 ../../examples
 
 # If the value of the EXAMPLE_PATH tag contains directories, you can use the 
 # EXAMPLE_PATTERNS tag to specify one or more wildcard pattern (like *.cpp 
 # and *.h) to filter out the source-files in the directories. If left 
 # blank all files are included.
 
-EXAMPLE_PATTERNS       = 
+EXAMPLE_PATTERNS       = *.c
 
 # If the EXAMPLE_RECURSIVE tag is set to YES then subdirectories will be 
 # searched for input files to be used with the \include or \dontinclude 
 # commands irrespective of the value of the RECURSIVE tag. 
 # Possible values are YES and NO. If left blank NO is used.
 
-EXAMPLE_RECURSIVE      = NO
+EXAMPLE_RECURSIVE      = YES
 
 # The IMAGE_PATH tag can be used to specify one or more files or 
 # directories that contain image that are included in the documentation (see 

--------------050101060303020008070509--

