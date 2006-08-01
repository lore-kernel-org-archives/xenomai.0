Message-ID: <44CFA184.9090204@domain.hid>
Date: Tue, 01 Aug 2006 11:46:28 -0700
From: Nathaniel Villaume <villaume@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: RT_TASK_INFO status
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>	<44C8EECE.4070209@domain.hid>	<44C90CEF.9090908@domain.hid>	<44C9136C.7080709@domain.hid>	<44C9420D.3070100@domain.hid>	<44C9D319.7020704@domain.hid>
	<17610.5728.464611.778617@domain.hid>
In-Reply-To: <17610.5728.464611.778617@domain.hid>
Content-Type: multipart/mixed; boundary="------------060107050403010603080701"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

This is a multi-part message in MIME format.
--------------060107050403010603080701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please see attached diff. I think I found a good way to do it that 
preserves the readable C-code style ( I gave up using the @define command).
This patch includes changes to the defines and the RT_TASK_INFO and 
RT_TASK_MCB structures.

Let me know if you want something different.

-Nate

--------------060107050403010603080701
Content-Type: text/plain;
 name="defines_documentation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="defines_documentation.diff"

Index: include/native/task.h
===================================================================
--- include/native/task.h	(revision 1383)
+++ include/native/task.h	(working copy)
@@ -34,21 +34,28 @@
 #define T_CPU(cpu) (1 << (24 + (cpu & 7))) /* Up to 8 cpus [0-7] */
 #define T_CPUMASK  0xff000000
 
-/* Status/mode flags. */
-#define T_BLOCKED  XNPEND
-#define T_DELAYED  XNDELAY
-#define T_READY    XNREADY
-#define T_DORMANT  XNDORMANT
-#define T_STARTED  XNSTARTED
-#define T_BOOST    XNBOOST
-#define T_LOCK     XNLOCK
-#define T_RRB      XNRRB
-#define T_NOSIG    XNASDI
-#define T_SHIELD   XNSHIELD
-#define T_WARNSW   XNTRAPSW
-#define T_RPIOFF   XNRPIOFF
+/*! 
+  \ingroup native
+  @defgroup native_task_status Task Status 
+  @brief Defines used to specify task state and/or mode 
+  @{
+ */
+
+#define T_BLOCKED  XNPEND     /**< See #XNPEND    */
+#define T_DELAYED  XNDELAY    /**< See #XNDELAY   */
+#define T_READY    XNREADY    /**< See #XNREADY   */
+#define T_DORMANT  XNDORMANT  /**< See #XNDORMANT */
+#define T_STARTED  XNSTARTED  /**< See #XNSTARTED */
+#define T_BOOST    XNBOOST    /**< See #XNBOOST   */
+#define T_LOCK     XNLOCK     /**< See #XNLOCK    */
+#define T_RRB      XNRRB      /**< See #XNRRB     */
+#define T_NOSIG    XNASDI     /**< See #XNASDI    */ 
+#define T_SHIELD   XNSHIELD   /**< See #XNSHIELD  */ 
+#define T_WARNSW   XNTRAPSW   /**< See #XNTRAPSW  */ 
+#define T_RPIOFF   XNRPIOFF   /**< See #XNRPIOFF  */ 
 #define T_PRIMARY  0x00000200	/* Recycle internal bits status which */
 #define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */
+/*! @} */ /* Ends doxygen-group native_task_status */
 
 /* Task hook types. */
 #define T_HOOK_START  XNHOOK_THREAD_START
@@ -68,31 +75,38 @@
 struct rt_queue_msg;
 struct rt_task;
 
+/** Structure containing task-information useful to users.
+ *
+ *  @see rt_task_inquire()
+ */
 typedef struct rt_task_info {
+    
+    int bprio;  /**< Base priority. */
 
-    int bprio;			/* !< Base priority. */
+    int cprio; /**< Current priority. May change through Priority Inheritance.*/
+    
+    unsigned status; /**< Task's status. @see native_task_status */ 
+    
+    RTIME relpoint; /**< Time of next release.*/ 
+    
+    char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at creation. */
 
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
 
+/** Structure used in passing messages between tasks.
+  @see rt_task_send(), rt_task_reply(), rt_task_receive()
+*/
 typedef struct rt_task_mcb {
 
-    int flowid;			/* !< Flow identifier. */
+    int flowid;   /**< Flow identifier. */
 
-    int opcode;			/* !< Operation code. */
+    int opcode;   /**< Operation code. */
 
-    caddr_t data;		/* !< Address of message. */
+    caddr_t data; /**< Message address. */
 
-    size_t size;		/* !< Size of message. */
+    size_t size;  /**< Message size (bytes). */
 
 } RT_TASK_MCB;
 
Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 1383)
+++ include/nucleus/thread.h	(working copy)
@@ -1,4 +1,4 @@
-/*
+/* 
  * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
  *
  * Xenomai is free software; you can redistribute it and/or modify
@@ -22,38 +22,48 @@
 
 #include <nucleus/timer.h>
 
+/*! @ingroup nucleus 
+  @defgroup nucleus_status_mode Status and Mode Defines.
+  @brief These defines are the used by the skins to report status of 
+         tasks and other objects. 
+  @{
+*/
+
 /* Status flags */
-#define XNSUSP    0x00000001	/* Suspended */
-#define XNPEND    0x00000002	/* Sleep-wait for a resource */
-#define XNDELAY   0x00000004	/* Delayed */
-#define XNREADY   0x00000008	/* Linked to the ready queue */
-#define XNDORMANT 0x00000010	/* Not started yet or killed */
-#define XNZOMBIE  0x00000020	/* Zombie thread in deletion process */
-#define XNRESTART 0x00000040	/* Restarting thread */
-#define XNSTARTED 0x00000080	/* Could be restarted */
-#define XNRELAX   0x00000100	/* Relaxed shadow thread (blocking bit) */
-#define XNHELD    0x00000200	/* Held thread from suspended partition */
 
-#define XNTIMEO   0x00000400	/* Woken up due to a timeout condition */
-#define XNRMID    0x00000800	/* Pending on a removed resource */
-#define XNBREAK   0x00001000	/* Forcibly awaken from a wait state */
-#define XNKICKED  0x00002000	/* Kicked upon Linux signal (shadow only) */
-#define XNBOOST   0x00004000	/* Undergoes regular PIP boost */
-#define XNDEBUG   0x00008000	/* Hit debugger breakpoint (shadow only) */
+#define XNSUSP    0x00000001 /**< Suspended. */
+#define XNPEND    0x00000002 /**< Sleep-wait for a resource. */
+#define XNDELAY   0x00000004 /**< Delayed */
+#define XNREADY   0x00000008 /**< Linked to the ready queue. */
+#define XNDORMANT 0x00000010 /**< Not started yet or killed */
+#define XNZOMBIE  0x00000020 /**< Zombie thread in deletion process */
+#define XNRESTART 0x00000040 /**< Restarting thread */
+#define XNSTARTED 0x00000080 /**< Could be restarted */
+#define XNRELAX   0x00000100 /**< Relaxed shadow thread (blocking bit) */
+#define XNHELD    0x00000200 /**< Held thread from suspended partition */
 
+#define XNTIMEO   0x00000400 /**< Woken up due to a timeout condition */
+#define XNRMID    0x00000800 /**< Pending on a removed resource */
+#define XNBREAK   0x00001000 /**< Forcibly awaken from a wait state */
+#define XNKICKED  0x00002000 /**< Kicked upon Linux signal (shadow only) */
+#define XNBOOST   0x00004000 /**< Undergoes regular PIP boost */
+#define XNDEBUG   0x00008000 /**< Hit debugger breakpoint (shadow only) */
+
 /* Mode flags. */
-#define XNLOCK    0x00010000	/* Not preemptible */
-#define XNRRB     0x00020000	/* Undergoes a round-robin scheduling */
-#define XNASDI    0x00040000	/* ASR are disabled */
-#define XNSHIELD  0x00080000	/* IRQ shield is enabled (shadow only) */
-#define XNTRAPSW  0x00100000	/* Trap execution mode switches */
-#define XNRPIOFF  0x00200000	/* Stop priority coupling (shadow only) */
+#define XNLOCK    0x00010000 /**< Not preemptible */
+#define XNRRB     0x00020000 /**< Undergoes a round-robin scheduling */
+#define XNASDI    0x00040000 /**< ASR are disabled */
+#define XNSHIELD  0x00080000 /**< IRQ shield is enabled (shadow only) */
+#define XNTRAPSW  0x00100000 /**< Trap execution mode switches */
+#define XNRPIOFF  0x00200000 /**< Stop priority coupling (shadow only) */
 
-#define XNFPU     0x00400000	/* Thread uses FPU */
-#define XNSHADOW  0x00800000	/* Shadow thread */
-#define XNROOT    0x01000000	/* Root thread (i.e. Linux/IDLE) */
-#define XNINVPS   0x02000000	/* Using inverted priority scale */
+#define XNFPU     0x00400000 /**< Thread uses FPU */
+#define XNSHADOW  0x00800000 /**< Shadow thread */
+#define XNROOT    0x01000000 /**< Root thread (that is, Linux/IDLE) */
+#define XNINVPS   0x02000000 /**< Using inverted priority scale */
 
+/*! @} */ /* Ends doxygen comment group: nucleus_status_modes */
+
 /*
   Must follow the declaration order of the above bits. Status symbols
   are defined as follows:

--------------060107050403010603080701--


