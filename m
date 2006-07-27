MIME-Version: 1.0
Date: Thu, 27 Jul 2006 08:57:52 -0700
From: "Nathaniel J Villaume" <villaume@domain.hid>
Message-Id: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>
In-Reply-To: <200607271001.k6RA19sN018076@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help] doc patch: RT_TASK_INFO 
Reply-To: Nathaniel.J.Villaume@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi, 
I got the already documented code to show up in the documentation
with the attached patch: (not brilliant documentation update,
sorry :) )

Index: xeno_doc_update/include/native/task.h
===================================================================
--- xeno_doc_update/include/native/task.h	(revision 1231)
+++ xeno_doc_update/include/native/task.h	(working copy)
@@ -66,18 +66,19 @@
 
 struct rt_queue_msg;
 struct rt_task;
-
+/*! @brief This structure provides information about tasks. 
+ @see rt_task_inquire()  */
 typedef struct rt_task_info {
 
-    int bprio;			/* !< Base priority. */
+    int bprio;			//!< Base priority. 
 
-    int cprio;			/* !< Current priority. */
+    int cprio;			//!< Current priority.
 
-    unsigned status;		/* !< Status. */
+    unsigned status;		//!< Status. 
 



