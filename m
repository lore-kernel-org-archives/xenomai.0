Message-ID: <44C9420D.3070100@domain.hid>
Date: Thu, 27 Jul 2006 15:45:33 -0700
From: Nathaniel Villaume <villaume@domain.hid>
MIME-Version: 1.0
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>
	<44C8EECE.4070209@domain.hid> <44C90CEF.9090908@domain.hid>
	<44C9136C.7080709@domain.hid>
In-Reply-To: <44C9136C.7080709@domain.hid>
Content-Type: multipart/mixed; boundary="------------060307080100040207050505"
Subject: [Xenomai-help] Re: RT_TASK_INFO status
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060307080100040207050505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan,
Ok, so I played around with your request some.

 My goal here is to produce documentation, but not at the expense of 
source-code readability and maintainability.  It's not hard to document 
defines, but it CAN make the source look uglier.
Witness nucleus/thread.h:

/*! @def XNSUSP */
#define XNSUSP 0x00000001 /*!< @brief Suspended */

/*! @define XNSUSP */
#define XNSUSP 0x00000002 /*!< Sleep-wait for a resource. */

In the first case, @brief is used to get the comment up into the brief 
listing (duh). If this is not done, then a detailed section is created 
with the comment, which is a little kludgier on the output end, but 
still completely usable.

Second order of business: refering to this new documentation. In 
include/native/task.h I made a group native_task_status that encompasses 
all the define documentation. This makes it easy to refer to from within 
the RT_TASK_INFO::status documentation (and anywhere else)

Third: I removed the duplication as you requested. This is not without 
consequence.  Please note the difference between RT_TASK_INFO and 
RT_TASK_MCB (which remainded the same).  To keep the brief member 
documentation, I had to use the /**  comment */ syntax. This is 
inconsistent with other usage, but... this gives the results we want.

Please see the patch and let me know what you think for this initial set.
Again, the decisions to be made are:
1.) Do we document the defines at all?
1a) If so, do we include brief in the define documentation (or not)?
1b) Do we group the defines (or not) for easy reference? (they show up 
under modules/native/Task Status)

My default action is to continue with the style/grouping as in the patch.

-Nate

Jan Kiszka wrote:

>Nathaniel Villaume wrote:
>  
>
>>In RT_TASK_INFO, can someone tell me what is the set of all possible
>>values for status?
>>I'd like to include that in the documentation.
>>    
>>
>
>They are defined in include/native/task.h [1], but they widely redirect
>to defines in include/nucleus/thread.h [2]. Maybe you could add comments
>to the native/task.h defines and include them in doxygen.
>
>Thanks again for your effort!
>Jan
>
>[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/native/task.h#L37
>[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/nucleus/thread.h#L25
>
>  
>

--------------060307080100040207050505
Content-Type: text/plain;
 name="task_defines.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="task_defines.diff"

Index: include/native/task.h
===================================================================
--- include/native/task.h	(revision 1383)
+++ include/native/task.h	(working copy)
@@ -34,8 +34,20 @@
 #define T_CPU(cpu) (1 << (24 + (cpu & 7))) /* Up to 8 cpus [0-7] */
 #define T_CPUMASK  0xff000000
 
-/* Status/mode flags. */
-#define T_BLOCKED  XNPEND
+/*! 
+  \ingroup native
+  @defgroup native_task_status Task Status 
+  @brief Defines used to specify task state and/or mode 
+  */
+/*! @addtogroup native_task_status 
+  @{
+  */
+
+/*! @def T_BLOCKED  
+  Task is blocked. See define #XNPEND*/
+#define T_BLOCKED  XNPEND 
+/*! @def T_DELAYED  
+  Task is delayed. See define #XNDELAY*/
 #define T_DELAYED  XNDELAY
 #define T_READY    XNREADY
 #define T_DORMANT  XNDORMANT
@@ -49,6 +61,7 @@
 #define T_RPIOFF   XNRPIOFF
 #define T_PRIMARY  0x00000200	/* Recycle internal bits status which */
 #define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */
+/*! @} */ /* Ends addtogroup native_task_status */
 
 /* Task hook types. */
 #define T_HOOK_START  XNHOOK_THREAD_START
@@ -68,31 +81,50 @@
 struct rt_queue_msg;
 struct rt_task;
 
+/*! @brief Structure containing task-information useful to users.
+ *
+ *  @see rt_task_inquire()
+  */
 typedef struct rt_task_info {
+    
+    /** Base priority. */
+    int bprio;  
 
-    int bprio;			/* !< Base priority. */
+    /** Current priority. Can change through Priority Inheritance.*/
+    int cprio;
+    
+    /** Task's status.
+     * Status may be any of the defines in task.h
+     *  @see native_task_status shows possible values.
+     */
+    unsigned status; 
+    
+    /** Time of next release.*/
+    RTIME relpoint; 
+    
+    /** Symbolic name assigned in creation */
+    char name[XNOBJECT_NAME_LEN];  
 
-    int cprio;			/* !< Current priority. */
-
-    unsigned status;		/* !< Status. */
-
-    RTIME relpoint;		/* !< Next periodic release point. */
-
-    char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
-
 } RT_TASK_INFO;
 
 #define RT_MCB_FSTORE_LIMIT  64
+/*! @typedef RT_TASK_MCB
+  @brief Structure used in passing messages between tasks.
 
+  @param  flowid  Flow identifier.
+  @param  opcode  Operation code.
+  @param  data    Message address.
+  @param  size    Message size (bytes).
+*/
 typedef struct rt_task_mcb {
 
-    int flowid;			/* !< Flow identifier. */
+    int flowid;
 
-    int opcode;			/* !< Operation code. */
+    int opcode;
 
-    caddr_t data;		/* !< Address of message. */
+    caddr_t data;
 
-    size_t size;		/* !< Size of message. */
+    size_t size;
 
 } RT_TASK_MCB;
 
Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 1383)
+++ include/nucleus/thread.h	(working copy)
@@ -1,4 +1,4 @@
-/*
+/*! @file nucleus/thread.h
  * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
  *
  * Xenomai is free software; you can redistribute it and/or modify
@@ -23,9 +23,13 @@
 #include <nucleus/timer.h>
 
 /* Status flags */
-#define XNSUSP    0x00000001	/* Suspended */
-#define XNPEND    0x00000002	/* Sleep-wait for a resource */
-#define XNDELAY   0x00000004	/* Delayed */
+
+/*! @def XNSUSP */
+#define XNSUSP    0x00000001	/*!< @brief Suspended */
+/*! @def XNPEND */
+#define XNPEND    0x00000002	/*!< Sleep-wait for a resource */
+/*! @def XNPEND */
+#define XNDELAY   0x00000004	/*!< Delayed */
 #define XNREADY   0x00000008	/* Linked to the ready queue */
 #define XNDORMANT 0x00000010	/* Not started yet or killed */
 #define XNZOMBIE  0x00000020	/* Zombie thread in deletion process */

--------------060307080100040207050505--

