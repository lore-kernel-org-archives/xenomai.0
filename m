Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9074CDF7
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Jatox8KE"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231205124140b308796c0d668dcf5f
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LQiOxP8FRcH569htcKLbEiQga2uAd9LDQ6JFKWKPyaQ=;
 b=Jatox8KEXKxEFAjh+XXRfdk3jSwVD2okZwjuapy/8T7IGvcZmhAztavGu5NdRYfsETzZYw
 q/slm8bonENALNQYbloW9Zi4LpAhfmaOxmjjYtSPwI8PENLbug6fs9lqOJyGBpES9KBcUYxF
 fvrGraTq6bO4s6lJ6zpBBNKyhjq+I=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:38 +0100
Subject: [PATCH 01/13] testsuite: Migrate to ARRAY_SIZE()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-1-3e0abd7c68fa@siemens.com>
References: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
In-Reply-To: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Use ARRAY_SIZE() where possible. No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/smokey/smokey.h                      |  2 +-
 testsuite/smokey/alchemytests/mq-1.c         |  3 ++-
 testsuite/smokey/alchemytests/mq-2.c         |  3 ++-
 testsuite/smokey/net_common/server.c         |  8 ++++----
 testsuite/smokey/net_common/setup.c          |  2 +-
 testsuite/smokey/posix-select/posix-select.c |  4 ++--
 testsuite/smokey/vxworkstests/msgQ-1.c       |  3 ++-
 testsuite/smokey/vxworkstests/msgQ-2.c       |  3 ++-
 testsuite/switchtest/switchtest.c            | 16 ++++++++--------
 9 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 0c20f5d69..cf9701966 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -88,7 +88,7 @@ struct smokey_test {
 	pvlist_for_each_entry((__pos), &smokey_test_list, __reserved.next)
 
 #define __smokey_arg_count(__args)	\
-	(sizeof(__args) / sizeof(__args[0]))
+	ARRAY_SIZE(__args)
 
 #define smokey_test_plugin(__plugin, __args, __desc)			\
 	static int run_ ## __plugin(struct smokey_test *t,		\
diff --git a/testsuite/smokey/alchemytests/mq-1.c b/testsuite/smokey/alchemytests/mq-1.c
index 952ff6448..8e1aa4c6d 100644
--- a/testsuite/smokey/alchemytests/mq-1.c
+++ b/testsuite/smokey/alchemytests/mq-1.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 #include <alchemy/queue.h>
 
 static struct traceobj trobj;
 
-#define NMESSAGES (sizeof(messages) / sizeof(messages[0]))
+#define NMESSAGES   ARRAY_SIZE(messages)
 
 static int messages[] = {
 	0xfafafafa,
diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
index acc6ec051..a389e46db 100644
--- a/testsuite/smokey/alchemytests/mq-2.c
+++ b/testsuite/smokey/alchemytests/mq-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 #include <alchemy/queue.h>
@@ -13,7 +14,7 @@ static int tseq[] = {
 	7,
 };
 
-#define NMESSAGES (sizeof(messages) / sizeof(messages[0]))
+#define NMESSAGES   ARRAY_SIZE(messages)
 
 static int messages[] = {
 	0xfafafafa,
diff --git a/testsuite/smokey/net_common/server.c b/testsuite/smokey/net_common/server.c
index 39d59c31f..cade79fa6 100644
--- a/testsuite/smokey/net_common/server.c
+++ b/testsuite/smokey/net_common/server.c
@@ -119,7 +119,7 @@ static void server_loop_cleanup(void *cookie)
 	int *fds = cookie;
 	int i;
 
-	for (i = 0; i < sizeof(protos)/sizeof(protos[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(protos); i++)
 		__RT(close(fds[i]));
 	free(fds);
 }
@@ -131,7 +131,7 @@ void smokey_net_server_loop(int net_config)
 	int i, maxfd, *fds;
 	fd_set rfds;
 
-	fds = malloc(sizeof(*fds) * sizeof(protos)/sizeof(protos[0]));
+	fds = malloc(sizeof(*fds) * ARRAY_SIZE(protos));
 	if (fds == NULL)
 		pthread_exit((void *)(long)-ENOMEM);
 
@@ -139,7 +139,7 @@ void smokey_net_server_loop(int net_config)
 
 	FD_ZERO(&rfds);
 	maxfd = 0;
-	for (i = 0; i < sizeof(protos)/sizeof(protos[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(protos); i++) {
 		p = &protos[i];
 
 		if ((net_config & p->config_flag) == 0) {
@@ -164,7 +164,7 @@ void smokey_net_server_loop(int net_config)
 
 		check_unix(__RT(select(maxfd + 1, &tfds, NULL, NULL, NULL)));
 
-		for (i = 0; i < sizeof(protos)/sizeof(protos[0]); i++) {
+		for (i = 0; i < ARRAY_SIZE(protos); i++) {
 			p = &protos[i];
 
 			if (fds[i] < 0 || !FD_ISSET(fds[i], &tfds))
diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index f97c14823..8a3562ba9 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -70,7 +70,7 @@ static int option_to_modid(int option)
 {
 	unsigned i;
 
-	for (i = 0; i < sizeof(modules)/sizeof(modules[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(modules); i++) {
 		if (modules[i].option != option)
 			continue;
 
diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
index 1484fa639..e9f8c70d0 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -96,7 +96,7 @@ static void *mq_thread(void *cookie)
 		}
 
 		smokey_trace("received %s", buf);
-		i = (i + 1) % (sizeof(tunes) / sizeof(tunes[0]));
+		i = (i + 1) % (ARRAY_SIZE(tunes));
 	}
 
 	return NULL;
@@ -121,7 +121,7 @@ static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
 		return ret;
 
 	for (j = 0; j < 3; j++) {
-		for (i = 0; i < sizeof(tunes) / sizeof(tunes[0]); i++) {
+		for (i = 0; i < ARRAY_SIZE(tunes); i++) {
 			ret = smokey_check_errno(mq_send(mq, tunes[i], strlen(tunes[i]) + 1, 0));
 			if (ret < 0) {
 				smokey_check_status(pthread_cancel(tcb));
diff --git a/testsuite/smokey/vxworkstests/msgQ-1.c b/testsuite/smokey/vxworkstests/msgQ-1.c
index 71eedd44f..4050388a2 100644
--- a/testsuite/smokey/vxworkstests/msgQ-1.c
+++ b/testsuite/smokey/vxworkstests/msgQ-1.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/taskLib.h>
@@ -8,7 +9,7 @@
 
 static struct traceobj trobj;
 
-#define NMESSAGES (sizeof(messages) / sizeof(messages[0]))
+#define NMESSAGES   ARRAY_SIZE(messages)
 
 static int messages[] = {
 	0xfafafafa,
diff --git a/testsuite/smokey/vxworkstests/msgQ-2.c b/testsuite/smokey/vxworkstests/msgQ-2.c
index d3ee1397c..008078047 100644
--- a/testsuite/smokey/vxworkstests/msgQ-2.c
+++ b/testsuite/smokey/vxworkstests/msgQ-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <vxworks/errnoLib.h>
 #include <vxworks/taskLib.h>
@@ -14,7 +15,7 @@ static int tseq[] = {
 	7,
 };
 
-#define NMESSAGES (sizeof(messages) / sizeof(messages[0]))
+#define NMESSAGES   ARRAY_SIZE(messages)
 
 static int messages[] = {
 	0xfafafafa,
diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index cb8e956d5..91ac91303 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -173,7 +173,7 @@ static char *task_name(char *buf, size_t sz,
 			;
 
 	pos = snprintf(buf, sz, "%s", basename[param->type]);
-	for (i = 0; i < sizeof(flags) / sizeof(flags[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(flags); i++) {
 		if (!(param->fp & flags[i].flag))
 			continue;
 
@@ -478,7 +478,7 @@ static double dot(volatile double *a, volatile double *b, int n)
 
 static void *fpu_stress(void *cookie)
 {
-	static volatile double a[10000], b[sizeof(a)/sizeof(a[0])];
+	static volatile double a[10000], b[ARRAY_SIZE(a)];
 	struct task_params *param = (struct task_params *) cookie;
 	cpu_set_t cpu_set;
 	unsigned i;
@@ -490,11 +490,11 @@ static void *fpu_stress(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
-	for (i = 0; i < sizeof(a)/sizeof(a[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(a); i++)
 		a[i] = b[i] = 3.14;
 
 	for (;;) {
-		double s = dot(a, b, sizeof(a)/sizeof(a[0]));
+		double s = dot(a, b, ARRAY_SIZE(a));
 		if ((unsigned) (s + 0.5) != 98596) {
 			fprintf(stderr, "fpu stress task failure! dot: %g\n", s);
 			clean_exit(EXIT_FAILURE);
@@ -1121,7 +1121,7 @@ static void usage(FILE *fd, const char *progname)
 		progname, progname);
 
 	for_each_cpu(i) {
-		for (j = 0; j < sizeof(all_fp)/sizeof(char *); j++)
+		for (j = 0; j < ARRAY_SIZE(all_fp); j++)
 			fprintf(fd, " %s%d", all_fp[j], i);
 	}
 
@@ -1130,7 +1130,7 @@ static void usage(FILE *fd, const char *progname)
 		"running:\n%s", progname);
 
 	for_each_cpu(i) {
-		for (j = 0; j < sizeof(all_nofp)/sizeof(char *); j++)
+		for (j = 0; j < ARRAY_SIZE(all_nofp); j++)
 			fprintf(fd, " %s%d", all_nofp[j], i);
 	}
 	fprintf(fd, "\n\n");
@@ -1333,10 +1333,10 @@ int main(int argc, const char *argv[])
 
 		if (use_fp) {
 			all = all_fp;
-			count = sizeof(all_fp)/sizeof(char *);
+			count = ARRAY_SIZE(all_fp);
 		} else {
 			all = all_nofp;
-			count = sizeof(all_nofp)/sizeof(char *);
+			count = ARRAY_SIZE(all_nofp);
 		}
 
 		argc = count * nr_cpus + 1;

-- 
2.39.2

