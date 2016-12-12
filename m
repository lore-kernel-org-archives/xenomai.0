Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <3342334e44e5352a44fc.1481549526@devws148.be.alcatel-lucent.com>
Date: Mon, 12 Dec 2016 14:32:06 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH v2] copperplate/mercury: introduce tunable to set
	max priority
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch introduces a tunable in the mercury copperplate code that allows
to put an upper limit on the priority used by the created thread objects.

Before this patch the complete OS scheduler's FIFO range was used and it was
not possible to restrict it. Restricting it can be useful in case other
activities (typically platform related things) need to get a higher priority
than the application threads.

The following tuneable can be used to configure the max priority to be 92:
set_config_tunable(sched_max_prio, 92);

or using a command-line option:
--sched-max-prio=92

diff --git a/include/copperplate/threadobj.h b/include/copperplate/threadobj.h
--- a/include/copperplate/threadobj.h
+++ b/include/copperplate/threadobj.h
@@ -136,6 +136,8 @@ void threadobj_save_timeout(struct threa
 		corespec->timeout = *timeout;
 }
 
+int threadobj_sched_get_priority_max(void);
+
 #endif /* CONFIG_XENO_MERCURY */
 
 /*
diff --git a/include/copperplate/tunables.h b/include/copperplate/tunables.h
--- a/include/copperplate/tunables.h
+++ b/include/copperplate/tunables.h
@@ -93,6 +93,20 @@ static inline read_config_tunable(sessio
 	return __copperplate_setup_data.session_gid;
 }
 
+#ifdef CONFIG_XENO_MERCURY
+extern int threadobj_sched_max_prio;
+
+static inline define_config_tunable(sched_max_prio, int, prio)
+{
+	threadobj_sched_max_prio = prio;
+}
+
+static inline read_config_tunable(sched_max_prio, int)
+{
+	return threadobj_sched_max_prio;
+}
+#endif /* CONFIG_XENO_MERCURY */
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -77,6 +77,13 @@ static const struct option copperplate_o
 		.flag = &__copperplate_setup_data.shared_registry,
 		.val = 1,
 	},
+#ifdef CONFIG_XENO_MERCURY
+	{
+#define sched_max_prio	5
+		.name = "sched-max-prio",
+		.has_arg = required_argument,
+	},
+#endif /* CONFIG_XENO_MERCURY */
 	{ /* Sentinel */ }
 };
 
@@ -264,6 +271,11 @@ static int copperplate_parse_option(int 
 		if (ret)
 			return ret;
 		break;
+#ifdef CONFIG_XENO_MERCURY
+	case sched_max_prio:
+		threadobj_sched_max_prio = atoi(optarg);
+		break;
+#endif /* CONFIG_XENO_MERCURY */
 	case regroot_opt:
 		__copperplate_setup_data.registry_root = strdup(optarg);
 		break;
@@ -285,6 +297,9 @@ static void copperplate_help(void)
         fprintf(stderr, "--shared-registry		enable public access to registry\n");
         fprintf(stderr, "--registry-root=<path>		root path of registry\n");
         fprintf(stderr, "--session=<label>[/<group>]	enable shared session\n");
+#ifdef CONFIG_XENO_MERCURY
+        fprintf(stderr, "--sched-max-prio=<prio>		set max scheduler priority used\n");
+#endif /* CONFIG_XENO_MERCURY */
 }
 
 static struct setup_descriptor copperplate_interface = {
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -488,6 +488,7 @@ int threadobj_stat(struct threadobj *tho
 #else /* CONFIG_XENO_MERCURY */
 
 static int threadobj_lock_prio;
+int threadobj_sched_max_prio;
 
 static void unblock_sighandler(int sig)
 {
@@ -542,6 +543,8 @@ static void nop_sighandler(int sig)
 static inline void pkg_init_corespec(void)
 {
 	struct sigaction sa;
+	int max_prio;
+	int max_sched_prio;
 
 	/*
 	 * We don't have builtin scheduler-lock feature over Mercury,
@@ -555,7 +558,10 @@ static inline void pkg_init_corespec(voi
 	 * holding the scheduler lock, unless the latter has to block
 	 * for some reason, defeating the purpose of such lock anyway.
 	 */
-	threadobj_irq_prio = sched_get_priority_max(SCHED_FIFO);
+	max_sched_prio = sched_get_priority_max(SCHED_FIFO);
+	max_prio = (threadobj_sched_max_prio==0) ? max_sched_prio:threadobj_sched_max_prio;
+
+	threadobj_irq_prio = ((max_prio > max_sched_prio)? max_sched_prio:max_prio);
 	threadobj_lock_prio = threadobj_irq_prio - 1;
 	threadobj_high_prio = threadobj_irq_prio - 2;
 	threadobj_agent_prio = threadobj_high_prio;

