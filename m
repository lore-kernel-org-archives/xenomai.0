Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB02F22
	for <xenomai@lists.linux.dev>; Thu, 20 Apr 2023 08:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrXzfWK9CCDL7C+GOdKo0aWR1sXi8nSHVe7Z4K1RDNygqMitagSo3fGJ9/si3EDKTCCT9nyF0a1I+iRtF6TLAS3N9LtpQ2Zc+z5Gq/DZKug3J2NGwX+58o4qRAUg40wDF2ql+FggaFwWP7ahygdmu0Bf6T8kggYumRw9Mz5aGRqmcVH2+Y6/APF6TMzuoRhLy1lUY1gQGLm2yZuPxciMEyRA0g8gyXYnW8eWZ/sz1KQXMNVsFRKv9rc71iiWio9W28WZUcupOzL7M/VwypToUJ/NqRuK07lswu87avyz4v9NGq+1pmvIt0rUxMpiSpSbZpNVur63sVNDAQI7ZTpmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtX/udd2MgT2cGwdnFuYprj8LrYThGkFveV6iKVdpkI=;
 b=jldtgeTWG1+mmBJEYJbN3OdQd4mMRBry2rX64AMWzVfAqu1joDqIQMfxrJriUhD7dH67gTL9jgWeEbrwjOJJffNQwbp44hM3K3Zp9MxHp0a95XlVaS6EmPbIv3C6KWfLsZNz3xz5agyQbJmy83P5i5huvNHAfo3UIRwQayqr1pgvuvVSeZZ1eoIu4bzb33Bmc/A4venFwHZ1y+b0YkEu+VFO/k7/T49mDb+B3tM8XFMmdn183iVkU26UbJBmJvv/L2Ulyzyu/Nl3VKGOkImTOtA0s9pHjvLfpsCItn/cUzNbGMVyv98NRecP7vvxX2IrOC3DI4930cRk4Gqz4tZ81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtX/udd2MgT2cGwdnFuYprj8LrYThGkFveV6iKVdpkI=;
 b=qC3gl80DqkBSUil/mMb8R/MZfapbaZKLvbeeRChTcMzyOIep4ulYLx8/R1ljEn2ER+6ooR+QsELpKi7d9iX9PsW436i3eLELayxr5VSMYwm1/a8v/tFD8Yk7yhu3WZ9hHqiHV6HYgJDVG6xPGzuvn6auP/W7qMpr4f0272NnhtBj/ftjwYR2boJa7xIhcGRFsgdvcSvwmr6i1S1kylbxSbZv1XflcQg3tAquvA6vVLez+HSYrMb5FT3XwJbZ4YCsD63Ss5PsJyj6BydPRMflFj6MGTn7aaLiP/f6skPZUdP4lIY44iRvLrQAFQsS2vI7kR7d14aZQ6WZqgljudTZXQ==
Received: from ZRAP278CA0012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::22)
 by DU2PR10MB7648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:490::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Thu, 20 Apr
 2023 08:04:10 +0000
Received: from VE1EUR01FT083.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:10:cafe::30) by ZRAP278CA0012.outlook.office365.com
 (2603:10a6:910:10::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 08:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT083.mail.protection.outlook.com (10.152.3.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Thu, 20 Apr 2023 08:04:09 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 20 Apr 2023 10:04:09 +0200
Received: from L15-Gen2.fritz.box (167.87.31.19) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 20 Apr 2023 10:04:07 +0200
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <jan.kiszka@siemens.com>, <johannes.kirchmair@sigmatek.at>,
	<richard@nod.at>, Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH] testsuite: Add exception handling tests to smokey
Date: Thu, 20 Apr 2023 10:03:52 +0200
Message-ID: <20230420080352.2403887-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c5238f77-0f7a-34eb-6e8c-ef7bfb6908bb@siemens.com>
References: <c5238f77-0f7a-34eb-6e8c-ef7bfb6908bb@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.31.19]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT083:EE_|DU2PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: ad24c569-3b77-4fbe-365e-08db4175d234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bXBimI3sCEpgtaZRLmgaStcV4tqjcRo3a2SG9AJpHCId/T0/OhocNO/Xxy769DD1kjobvj9cqzQDrF7TvdmjtYIAvfb6FAl9fUhcr0DTeD0B31sURMg/AubViohQ513W7bHu5o+E3en9YiwKJwKGyQ0abqAlqnzUQdR1ziRalHUU01s6KstxJSgfWEgIOIMYBLEMz7h1aEeBR6TYHdkf3mCqqnMGaHU61qCy4iBpTgcul+3ggjwNvxm28oxa6JSaekDLkmxsHOgg9/C/1UMiPy3iIIA0gqmdaSR1MEP+7pazDso7MbDscY/5pkn/Mhc6o818TMuv/l376tgxvCgmmLa+uXsElq8U/FVx+2NR7uU7q4D/2bH6/Y1rvyRlWPQbY4CA3QtVBRtlsVYSCcIKZiMWUNd4HIqyVpMyRGY8Sur4XNn1W2wk8kEa9DbeGPBTIWkhWFVxcijRGieRwXo9MAT2Y51qco9aC5SSlw9aa8df94DBWcm04qugJt7VBDapLOk0Rn68hciT6J4bPklKexWb7qp2DYWlmr8N9kw7n0P1+Cpk/YHRq4/5N4eJOF0/D2TMRoTMNjtIx1U1S8h/vEi8YfuefhXH0iUP+bwxxGRAzkXgq/TS8WyX+Q9ogUkdIc40E7SUWoKocsYU2I2YtjysyLAnNoFQafUfrMTwizNtyRNrwVuXcaEfnZW8k74OUhnDK7e+VrSunXxOKRRnIw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(7636003)(2906002)(356005)(82960400001)(82740400003)(7596003)(5660300002)(30864003)(8676002)(8936002)(16526019)(186003)(478600001)(4326008)(6916009)(41300700001)(316002)(70206006)(36756003)(70586007)(54906003)(36860700001)(40460700003)(47076005)(83380400001)(336012)(6666004)(86362001)(966005)(40480700001)(956004)(2616005)(66899021)(107886003)(1076003)(26005)(82310400005)(2004002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 08:04:09.6048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad24c569-3b77-4fbe-365e-08db4175d234
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT083.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7648

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Add a testsuite that ensures that different exceptions lead to the
designated signal described in the signal posix standard [1].

Introduces tests for floating point exceptions, illegal opcode
exceptions and segmentation faults.

If setup correctly the generated signals should not lead to a migration
but should be handled by the configured handler.

Further test if signals raised while already in the signal handler are
handled correctly with and without SA_NODEFER set.

Add an additional Makefile.standalone Makefile that allows to build
without the Xenomai kernel for reference. If build without Xenomai all
tests should pass.

[1] https://pubs.opengroup.org/onlinepubs/009695399/

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 configure.ac                                  |   1 +
 testsuite/smokey/Makefile.am                  |   2 +
 testsuite/smokey/signal-tests/Makefile.am     |  15 ++
 .../smokey/signal-tests/Makefile.standalone   |  16 ++
 testsuite/smokey/signal-tests/main.c          |  51 ++++
 testsuite/smokey/signal-tests/signal_test.c   | 243 ++++++++++++++++++
 testsuite/smokey/signal-tests/signal_test.h   |  93 +++++++
 .../signal-tests/signal_test_exceptions.c     |  84 ++++++
 .../signal-tests/signal_test_exceptions.h     |  51 ++++
 .../smokey/signal-tests/signal_test_thread.c  |  61 +++++
 .../smokey/signal-tests/signal_test_thread.h  |  37 +++
 .../smokey/signal-tests/signal_test_utils.c   |  80 ++++++
 .../smokey/signal-tests/signal_test_utils.h   |  44 ++++
 13 files changed, 778 insertions(+)
 create mode 100644 testsuite/smokey/signal-tests/Makefile.am
 create mode 100644 testsuite/smokey/signal-tests/Makefile.standalone
 create mode 100644 testsuite/smokey/signal-tests/main.c
 create mode 100644 testsuite/smokey/signal-tests/signal_test.c
 create mode 100644 testsuite/smokey/signal-tests/signal_test.h
 create mode 100644 testsuite/smokey/signal-tests/signal_test_exceptions.c
 create mode 100644 testsuite/smokey/signal-tests/signal_test_exceptions.h
 create mode 100644 testsuite/smokey/signal-tests/signal_test_thread.c
 create mode 100644 testsuite/smokey/signal-tests/signal_test_thread.h
 create mode 100644 testsuite/smokey/signal-tests/signal_test_utils.c
 create mode 100644 testsuite/smokey/signal-tests/signal_test_utils.h

diff --git a/configure.ac b/configure.ac
index db92ddcc6..0e0bd0f44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -978,6 +978,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/iddp/Makefile \
 	testsuite/smokey/bufp/Makefile \
 	testsuite/smokey/sigdebug/Makefile \
+	testsuite/smokey/signal-tests/Makefile \
 	testsuite/smokey/timerfd/Makefile \
 	testsuite/smokey/tsc/Makefile \
 	testsuite/smokey/leaks/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 02613c7dc..877b16702 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -35,6 +35,7 @@ COBALT_SUBDIRS = 	\
 	sched-tp 	\
 	setsched	\
 	sigdebug	\
+	signal-tests    \
 	timerfd		\
 	tsc		\
 	vdso-access 	\
@@ -73,6 +74,7 @@ DIST_SUBDIRS = 		\
 	sched-tp 	\
 	setsched	\
 	sigdebug	\
+	signal-tests    \
 	timerfd		\
 	tsc		\
 	vdso-access 	\
diff --git a/testsuite/smokey/signal-tests/Makefile.am b/testsuite/smokey/signal-tests/Makefile.am
new file mode 100644
index 000000000..728a90744
--- /dev/null
+++ b/testsuite/smokey/signal-tests/Makefile.am
@@ -0,0 +1,15 @@
+noinst_LIBRARIES = libsignal-tests.a
+
+libsignal_tests_a_SOURCES = main.c \
+                       signal_test.c \
+                       signal_test.h \
+                       signal_test_exceptions.c \
+                       signal_test_exceptions.h \
+                       signal_test_thread.c \
+                       signal_test_thread.h \
+                       signal_test_utils.c \
+                       signal_test_utils.h
+
+libsignal_tests_a_CPPFLAGS = @XENO_USER_CFLAGS@ -I$(top_srcdir)/include -DXENOMAI
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
diff --git a/testsuite/smokey/signal-tests/Makefile.standalone b/testsuite/smokey/signal-tests/Makefile.standalone
new file mode 100644
index 000000000..15f7c79f3
--- /dev/null
+++ b/testsuite/smokey/signal-tests/Makefile.standalone
@@ -0,0 +1,16 @@
+# Use this Makefile to build without XENOMAI
+
+CC      = gcc
+CFLAGS  = -g -pthread
+RM      = rm -f
+
+default: all
+
+all: clean signal_test
+
+signal_test: *.c
+	$(CC) $(CFLAGS) -o signal_test *.c
+
+clean veryclean:
+	$(RM) signal_test
+
diff --git a/testsuite/smokey/signal-tests/main.c b/testsuite/smokey/signal-tests/main.c
new file mode 100644
index 000000000..cf3bbb39a
--- /dev/null
+++ b/testsuite/smokey/signal-tests/main.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "signal_test_utils.h"
+#include "signal_test.h"
+
+#ifdef XENOMAI
+
+#include <smokey/smokey.h>
+
+smokey_test_plugin(signal_tests, SMOKEY_NOARGS,
+		   "Test for signals on exceptions.");
+
+static int run_signal_tests(struct smokey_test *t, int argc, char *const argv[])
+#else
+int main(void)
+#endif
+{
+	TEST(test_exceptions_fpe());
+	TEST(test_exceptions_invalid_opcode());
+	TEST(test_exceptions_segfault());
+
+	TEST(test_exceptions_nesting_fpe());
+	TEST(test_exceptions_nesting_invalid_opcode());
+	TEST(test_exceptions_nesting_segfault());
+
+	TEST(test_exceptions_queuing_fpe());
+	TEST(test_exceptions_queuing_invalid_opcode());
+	TEST(test_exceptions_queuing_segfault());
+
+	return signal_test_testsuite_exit();
+}
diff --git a/testsuite/smokey/signal-tests/signal_test.c b/testsuite/smokey/signal-tests/signal_test.c
new file mode 100644
index 000000000..eaefce485
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test.c
@@ -0,0 +1,243 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "signal_test.h"
+#include "signal_test_exceptions.h"
+#include "signal_test_thread.h"
+#include "signal_test_utils.h"
+
+static int depth, handler_calls = 0;
+static bool wrong_thread, wrong_signal, migration, nested, do_reraise = false;
+static void (*exception_raise_func)(void);
+
+static void test_signal_handler(int sig, siginfo_t *info, void *context)
+{
+	if (thread_id != pthread_self())
+		wrong_thread = true;
+
+#ifdef XENOMAI
+	if (sig == SIGDEBUG) {
+		migration = true;
+		return;
+	}
+#endif
+
+	if (sig != signal_test_exceptions_get_expected_signal()) {
+		wrong_signal = true;
+		return;
+	}
+
+	handler_calls++;
+
+	if (do_reraise) {
+		if (depth++)
+			nested = true;
+
+		if (handler_calls < 3) {
+			(*exception_raise_func)();
+		}
+
+		depth--;
+	}
+
+	signal_test_exceptions_recover(context);
+}
+
+static int run_exception_test(int sa_flags, int signal, bool reraise,
+			      int expected_handler_calls)
+{
+	struct sigaction sigact = { 0 };
+	sigact.sa_sigaction = test_signal_handler;
+	sigact.sa_flags = sa_flags;
+
+	depth = 0;
+	do_reraise = reraise;
+	handler_calls = 0;
+	migration = false;
+	nested = false;
+	wrong_thread = false;
+	wrong_signal = false;
+
+#ifdef XENOMAI
+	ASSERT(sigaction(SIGDEBUG, &sigact, NULL), 0);
+	ASSERT(cobalt_rt_signal(signal, test_signal_handler), 0);
+#else
+	ASSERT(sigaction(signal, &sigact, NULL), 0);
+#endif
+
+	ASSERT(signal_test_thread_start((void *)exception_raise_func), 0);
+	ASSERT(pthread_join(thread_id, NULL), 0);
+
+	ASSERT(!reraise || nested, true);
+	ASSERT(depth, 0);
+	ASSERT(handler_calls, expected_handler_calls);
+	ASSERT(migration, false);
+	ASSERT(wrong_signal, false);
+	ASSERT(wrong_thread, false);
+
+	return 0;
+}
+
+static void reset_signals(void)
+{
+	struct sigaction sigAct;
+	sigAct.sa_handler = SIG_DFL;
+	sigaction(SIGSEGV, &sigAct, NULL);
+	sigaction(SIGFPE, &sigAct, NULL);
+	sigaction(SIGILL, &sigAct, NULL);
+#ifdef XENOMAI
+	sigaction(SIGDEBUG, &sigAct, NULL);
+	cobalt_rt_signal(SIGSEGV, (void (*)(int, siginfo_t *, void *))SIG_DFL);
+	cobalt_rt_signal(SIGFPE, (void (*)(int, siginfo_t *, void *))SIG_DFL);
+	cobalt_rt_signal(SIGILL, (void (*)(int, siginfo_t *, void *))SIG_DFL);
+#endif
+}
+
+static void setup(void)
+{
+	reset_signals();
+}
+
+static void teardown(void)
+{
+	reset_signals();
+}
+
+static int fork_exception_test(int *status, int sa_flags, int signal,
+			       bool reraise, int expected_handler_calls)
+{
+	setup();
+
+	pid_t child_pid = fork();
+
+	if (child_pid < 0) {
+		fprintf(stderr, "fork failed in %s:%d", __FILE__, __LINE__);
+		return 1;
+	} else if (child_pid == 0) {
+		exit(run_exception_test(sa_flags, signal, reraise,
+					expected_handler_calls));
+	} else {
+		waitpid(child_pid, status, 0);
+	}
+
+	teardown();
+
+	return 0;
+}
+
+static int test_exceptions(void (*exception)(void), int signal)
+{
+	int status;
+	exception_raise_func = exception;
+
+	fork_exception_test(&status, SA_SIGINFO, signal, false, 1);
+
+	ASSERT(WIFSIGNALED(status), false);
+	ASSERT(WIFEXITED(status), true);
+	return WEXITSTATUS(status);
+}
+
+int test_exceptions_segfault()
+{
+	return test_exceptions(&signal_test_exceptions_raise_segfault, SIGSEGV);
+}
+
+int test_exceptions_fpe()
+{
+	return test_exceptions(&signal_test_exceptions_raise_fpe, SIGFPE);
+}
+
+int test_exceptions_invalid_opcode()
+{
+	return test_exceptions(&signal_test_exceptions_raise_invalid_opcode,
+			       SIGILL);
+}
+
+static int test_exceptions_queuing(void (*exception)(void), int signal)
+{
+	int status;
+	exception_raise_func = exception;
+
+	fork_exception_test(&status, SA_SIGINFO, signal, true, 3);
+
+	ASSERT(WIFSIGNALED(status), true);
+	ASSERT(WTERMSIG(status), signal);
+
+	return 0;
+}
+
+int test_exceptions_queuing_segfault()
+{
+	return test_exceptions_queuing(&signal_test_exceptions_raise_segfault,
+				       SIGSEGV);
+}
+
+int test_exceptions_queuing_fpe()
+{
+	return test_exceptions_queuing(&signal_test_exceptions_raise_fpe,
+				       SIGFPE);
+}
+
+int test_exceptions_queuing_invalid_opcode()
+{
+	return test_exceptions_queuing(
+		&signal_test_exceptions_raise_invalid_opcode, SIGILL);
+}
+
+static int test_exceptions_nesting(void (*exception)(void), int signal)
+{
+	int status;
+	exception_raise_func = exception;
+
+	fork_exception_test(&status, SA_SIGINFO | SA_NODEFER, signal, true, 3);
+
+	ASSERT(WIFSIGNALED(status), false);
+	ASSERT(WIFEXITED(status), true);
+	return WEXITSTATUS(status);
+}
+
+int test_exceptions_nesting_segfault()
+{
+	return test_exceptions_nesting(&signal_test_exceptions_raise_segfault,
+				       SIGSEGV);
+}
+
+int test_exceptions_nesting_fpe()
+{
+	return test_exceptions_nesting(&signal_test_exceptions_raise_fpe,
+				       SIGFPE);
+}
+
+int test_exceptions_nesting_invalid_opcode()
+{
+	return test_exceptions_nesting(
+		&signal_test_exceptions_raise_invalid_opcode, SIGILL);
+}
+
diff --git a/testsuite/smokey/signal-tests/signal_test.h b/testsuite/smokey/signal-tests/signal_test.h
new file mode 100644
index 000000000..51e945ed2
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test.h
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/**
+ * @brief Test if a segfault leads to a SIGSEGV signal.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_segfault(void);
+
+/**
+ * @brief Test if a floating point exception leads to a SIGFPE signal.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_fpe(void);
+
+/**
+ * @brief Test if an invalid opcode exceptions leads to a SIGILL signal.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_invalid_opcode(void);
+
+/**
+ * @brief Raise a second segfault while in the signal handler. Test if the
+ * second exception leads to process termination even if a signal handler is
+ * set.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_queuing_segfault(void);
+
+/**
+ * @brief Raise a second fpe exception while in the signal handler. Test if the
+ * second exception leads to process termination even if a signal handler is
+ * set.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_queuing_fpe(void);
+
+/**
+ * @brief Raise a second invalid opcode exception while in the signal handler.
+ * Test if the second exception leads to process termination even if a signal
+ * handler is set.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_queuing_invalid_opcode(void);
+
+/**
+ * @brief Test that that a second sefault raised while in the signal handler
+ * will be processed nested if SA_NODEFER is set.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_nesting_segfault(void);
+
+/**
+ * @brief Test that that a second fpe raised while in the signal handler will
+ * be processed nested if SA_NODEFER is set.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_nesting_fpe(void);
+
+/**
+ * @brief Test that that a second invalid opcode exception raised while in the
+ * signal handler will be processed nested if SA_NODEFER is set.
+ * 
+ * @return int 0 if the test was successfull
+ */
+int test_exceptions_nesting_invalid_opcode(void);
diff --git a/testsuite/smokey/signal-tests/signal_test_exceptions.c b/testsuite/smokey/signal-tests/signal_test_exceptions.c
new file mode 100644
index 000000000..fa74dfb46
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test_exceptions.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <signal.h>
+
+#include "signal_test_exceptions.h"
+#include "signal_test_utils.h"
+
+static int expected_signal;
+static long unsigned int return_address;
+
+int signal_test_exceptions_get_expected_signal(void)
+{
+	return expected_signal;
+}
+
+void signal_test_exceptions_recover(struct ucontext *context)
+{
+	context->uc_mcontext.rip = return_address;
+}
+
+void signal_test_exceptions_raise_segfault(void)
+{
+	expected_signal = SIGSEGV;
+
+	__asm__("leaq .label%=(%%rip),%%r15;" // Store unique label address in r15
+		"movq %%r15,%0;"
+
+		"movl $0xDECAFBAD, 0x0;" // Raise SEGFAULT
+
+		".label%=:;" // Unique Label
+
+		: "=g"(return_address)::"memory", "r15");
+}
+
+void signal_test_exceptions_raise_fpe(void)
+{
+	expected_signal = SIGFPE;
+
+	__asm__("leaq .label%=(%%rip),%%r15;" // Store unique label address in r15
+		"movq %%r15,%0;"
+
+		"xorl %%eax, %%eax;" // Start raise FPE
+		"movl %%eax, %%ecx;"
+		"cltd;"
+		"idivl %%ecx;" // End raise FPE
+
+		".label%=:;" // Unique Label
+
+		: "=g"(return_address)::"memory", "eax", "ecx", "r15");
+}
+
+void signal_test_exceptions_raise_invalid_opcode(void)
+{
+	expected_signal = SIGILL;
+
+	__asm__("leaq .label%=(%%rip),%%r15;" // Store unique label address in r15
+		"movq %%r15,%0;"
+
+		"ud2;" // Raise invalid opcode
+
+		".label%=:;" // Unique Label
+
+		: "=g"(return_address)::"memory", "r15");
+}
diff --git a/testsuite/smokey/signal-tests/signal_test_exceptions.h b/testsuite/smokey/signal-tests/signal_test_exceptions.h
new file mode 100644
index 000000000..62652f1ea
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test_exceptions.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef SIGNAL_TEST_EXCEPTIONS_H
+#define SIGNAL_TEST_EXCEPTIONS_H
+
+#include <asm/ucontext.h>
+
+/**
+ * @brief Raise a segfault.
+ */
+void signal_test_exceptions_raise_segfault(void);
+
+/**
+ * @brief Raise a floating point exception.
+ */
+void signal_test_exceptions_raise_fpe(void);
+
+/**
+ * @brief Raise an invalid opcode exception.
+ */
+void signal_test_exceptions_raise_invalid_opcode(void);
+
+/**
+ * @brief Recover from a exception by jumping to a label
+ * after the exception.
+ */
+void signal_test_exceptions_recover(struct ucontext *);
+
+int signal_test_exceptions_get_expected_signal(void);
+
+#endif
diff --git a/testsuite/smokey/signal-tests/signal_test_thread.c b/testsuite/smokey/signal-tests/signal_test_thread.c
new file mode 100644
index 000000000..95a0963e7
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test_thread.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "signal_test_thread.h"
+#include "signal_test_utils.h"
+
+pthread_t thread_id;
+
+static pthread_attr_t attr;
+static struct sched_param sp;
+
+static void (*signal_test_thread_function)(void);
+
+static void signal_test_thread_run(void)
+{
+	thread_id = pthread_self();
+
+#ifdef XENOMAI
+	pthread_setmode_np(0, PTHREAD_WARNSW, NULL);
+#endif
+
+	(*signal_test_thread_function)();
+}
+
+int signal_test_thread_start(void *thread_function)
+{
+	signal_test_thread_function = thread_function;
+
+	ASSERT(pthread_attr_init(&attr), 0);
+
+#ifdef XENOMAI
+	sp.sched_priority = 1;
+	ASSERT(pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED), 0);
+	ASSERT(pthread_attr_setschedpolicy(&attr, SCHED_FIFO), 0);
+	ASSERT(pthread_attr_setschedparam(&attr, &sp), 0);
+#endif
+
+	ASSERT(pthread_create(&thread_id, &attr, (void *)signal_test_thread_run,
+			      NULL),
+	       0);
+	return 0;
+}
diff --git a/testsuite/smokey/signal-tests/signal_test_thread.h b/testsuite/smokey/signal-tests/signal_test_thread.h
new file mode 100644
index 000000000..5c42d2659
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test_thread.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef SIGNAL_TEST_THREAD_H
+#define SIGNAL_TEST_THREAD_H
+
+#include <pthread.h>
+
+extern pthread_t thread_id;
+
+/**
+ * @brief Start a thread that runs the given function.
+ * 
+ * @return int 0 if the test was successfull and 1 on failure.
+ */
+int signal_test_thread_start(void *);
+
+#endif
diff --git a/testsuite/smokey/signal-tests/signal_test_utils.c b/testsuite/smokey/signal-tests/signal_test_utils.c
new file mode 100644
index 000000000..117d32e8a
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test_utils.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "signal_test_utils.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#ifdef XENOMAI
+#include <smokey/smokey.h>
+#else
+static int smokey_verbose_mode = 2;
+#endif
+
+static int testsuite_result = 0;
+
+int signal_test_assert(char *file, int line, int under_test, int expected)
+{
+	if (under_test == expected)
+		return 0;
+
+	fprintf(stderr,
+		"\n\x1B[31mAssertion error in %s:%d: expected \"%d\" but was \"%d\".\x1B[0m",
+		file, line, expected, under_test);
+
+	return 1;
+}
+
+void signal_test_entry(char *function_name)
+{
+	if (smokey_verbose_mode > 1) {
+		fprintf(stdout, "Test %s... ", function_name);
+		fflush(stdout);
+	}
+}
+
+void signal_test_exit(char *function_name, int error_code)
+{
+	if (error_code) {
+		fprintf(stderr,
+			"\n\x1B[31mTest %s failed with error: %d\x1B[0m\n",
+			function_name, error_code);
+		testsuite_result = 1;
+	} else {
+		if (smokey_verbose_mode > 1)
+			fprintf(stdout, "OK\n");
+	}
+}
+
+int signal_test_testsuite_exit(void)
+{
+	if (testsuite_result) {
+		fprintf(stdout,
+			"\nsignal_tests failed with error: %d\n",
+			testsuite_result);
+	} else {
+		fprintf(stdout, "signal_tests OK\n");
+	}
+
+	return testsuite_result;
+}
diff --git a/testsuite/smokey/signal-tests/signal_test_utils.h b/testsuite/smokey/signal-tests/signal_test_utils.h
new file mode 100644
index 000000000..ceaa21c35
--- /dev/null
+++ b/testsuite/smokey/signal-tests/signal_test_utils.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) Siemens AG 2023
+ *
+ * Authors:
+ *  Tobias Schaffner <tobias.schaffner@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef SIGNAL_TEST_UTILS_H
+#define SIGNAL_TEST_UTILS_H
+
+#define NAME(name) #name
+
+#define ASSERT(under_test, expected)                                           \
+	if (signal_test_assert(__FILE__, __LINE__, under_test, expected))      \
+		return 1;
+
+#define TEST(func)                                                             \
+	do {                                                                   \
+		signal_test_entry(NAME(func));                                 \
+		signal_test_exit(NAME(func), func);                            \
+	} while (0)
+
+int signal_test_assert(char *, int, int, int);
+void signal_test_entry(char *);
+void signal_test_exit(char *, int);
+
+int signal_test_testsuite_exit(void);
+
+#endif
-- 
2.34.1

