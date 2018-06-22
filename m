From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 22 Jun 2018 17:42:35 +0200
Message-Id: <ff9785e25bf415d3dc9715e2c974315a2bc58994.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 3/4] cobalt/posix: Provide compat version
	signal_copyinfo extension
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Enables compat-capable implementations of this extension.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/extension.h |  4 ++++
 kernel/cobalt/posix/signal.c    | 20 +++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/posix/extension.h b/kernel/cobalt/posix/extension.h
index b831a3a1a6..ae365c7874 100644
--- a/kernel/cobalt/posix/extension.h
+++ b/kernel/cobalt/posix/extension.h
@@ -54,6 +54,10 @@ struct cobalt_extension {
 				       void __user *u_si,
 				       const struct siginfo *si,
 				       int overrun);
+		int (*signal_copyinfo_compat)(struct cobalt_extref *refthread,
+					      void __user *u_si,
+					      const struct siginfo *si,
+					      int overrun);
 		int (*sched_yield)(struct cobalt_extref *curref);
 		int (*thread_setsched)(struct cobalt_extref *refthread, /* nklocked, IRQs off. */
 				       struct xnsched_class *sched_class,
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index c29b45ebd5..9d8353bbc2 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -337,17 +337,23 @@ done:
 		goto out;	/* Return signo only. */
 
 #ifdef CONFIG_XENO_ARCH_SYS3264
-	if (compat)
+	if (compat) {
 		ret = sys32_put_siginfo(u_si, sip, overrun);
-	else
+		if (!ret)
+			/* Allow an extended target to receive more data. */
+			cobalt_call_extension(signal_copyinfo_compat,
+					      &curr->extref, ret, u_si, sip,
+					      overrun);
+	} else
 #endif
+	{
 		ret = signal_put_siginfo(u_si, sip, overrun);
-	if (ret)
-		goto out;
+		if (!ret)
+			/* Allow an extended target to receive more data. */
+			cobalt_call_extension(signal_copyinfo, &curr->extref,
+					      ret, u_si, sip, overrun);
+	}
 
-	/* Allow an extended target to receive more data. */
-	cobalt_call_extension(signal_copyinfo, &curr->extref,
-			      ret, u_si, sip, overrun);
 out:
 	/*
 	 * If we pulled the signal information from a sigpending
-- 
2.13.7


