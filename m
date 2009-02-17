Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <499AEE93.1030201@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 17 Feb 2009 18:04:19 +0100
Message-ID: <20090217170419.1425.5174.stgit@domain.hid>
In-Reply-To: <20090217170418.1425.56126.stgit@domain.hid>
References: <20090217170418.1425.56126.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 4/4] POSIX: Do not auto-shadow main with
	dlopen enabled
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Don't perform auto-shadowing in POSIX skin if we might be loaded via
dlopen. Otherwise the wrong thread, the undefined dlopen caller, may be
(re-)shadowed, assigning wrong scheduling settings.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/skins/posix/init.c |   43 ++++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/src/skins/posix/init.c b/src/skins/posix/init.c
index 8fc5a92..b04dbf0 100644
--- a/src/skins/posix/init.c
+++ b/src/skins/posix/init.c
@@ -47,7 +47,6 @@ void pse51_clock_init(int);
 static __attribute__ ((constructor))
 void __init_posix_interface(void)
 {
-	struct sched_param parm;
 	int muxid, err;
 
 	muxid =
@@ -67,28 +66,42 @@ void __init_posix_interface(void)
 								 __rtdm_fdcount);
 	}
 
-	/* Shadow the main thread. mlock the whole memory for the time of the
-	   syscall, in order to avoid the SIGXCPU signal. */
+#ifdef CONFIG_XENO_LIBS_DLOPEN
+	/* Don't use auto-shadowing if we are likely invoked from dlopen, but
+	   take care of auto-mlockall. */
+#ifdef CONFIG_XENO_POSIX_AUTO_MLOCKALL
 	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
 		perror("Xenomai Posix skin init: mlockall");
 		exit(EXIT_FAILURE);
 	}
+#endif /* CONFIG_XENO_POSIX_AUTO_MLOCKALL */
+#else /* !CONFIG_XENO_LIBS_DLOPEN */
+	{
+		struct sched_param parm = { .sched_priority = 0 };
+
+		/* Shadow the main thread. mlock the whole memory for the time
+		   of the syscall, in order to avoid the SIGXCPU signal. */
+		if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
+			perror("Xenomai Posix skin init: mlockall");
+			exit(EXIT_FAILURE);
+		}
 
-	parm.sched_priority = 0;
-	err = __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,
-					   &parm);
-	if (err) {
-		fprintf(stderr, "Xenomai Posix skin init: "
-			"pthread_setschedparam: %s\n", strerror(err));
-		exit(EXIT_FAILURE);
-	}
+		err = __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,
+						   &parm);
+		if (err) {
+			fprintf(stderr, "Xenomai Posix skin init: "
+				"pthread_setschedparam: %s\n", strerror(err));
+			exit(EXIT_FAILURE);
+		}
 
 #ifndef CONFIG_XENO_POSIX_AUTO_MLOCKALL
-	if (munlockall()) {
-		perror("Xenomai Posix skin init: munlockall");
-		exit(EXIT_FAILURE);
-	}
+		if (munlockall()) {
+			perror("Xenomai Posix skin init: munlockall");
+			exit(EXIT_FAILURE);
+		}
 #endif /* !CONFIG_XENO_POSIX_AUTO_MLOCKALL */
+	}
+#endif /* !CONFIG_XENO_LIBS_DLOPEN */
 
 	if (!fork_handler_registered) {
 		err = pthread_atfork(NULL, NULL, &__init_posix_interface);


