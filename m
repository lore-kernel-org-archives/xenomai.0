Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2091.outbound.protection.outlook.com [40.107.20.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C32108
	for <xenomai@lists.linux.dev>; Fri,  8 Sep 2023 10:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aik5H9ffuIRI4sCbypxBPIZga+Z7WZ2Zc8I9PaO9CyaKYJOVmE5tZs4G2PDCZIJ7UP8fB9nESy8VW8HIe4DkpOAEhQbI13Mfq6MlX+qeHLYabS4KF3WeWRjq6AVGvwelhbhw/5GvgZIkYcdGLZYeMDdpIxuuNbJJqCUC0RhfzH+OKyZilztiv9AfLIcHjUPvSDG0QCIkqTTcD4waDR8Z9h41yTYDYPP902ONT8MGIHEweYL2g05fJDz6va0yZzbsf8Lff7SolEL3bq2dZBblXrQ7NUxx/SY6lgT389K/raTaUASEmB8/QKR/zHuRxZFvfDaegAkYqFZH267Eqf9wEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dVU1vlZBdBQO8wUDdDBn9r6XXLPeWUszBk5JSBs49E=;
 b=nndfxQhE5rJTMm6X+yCykwguS1lVa4XoswR2cgm8EXUfxYMewRLVk7BqwEeGVjiMinKfQc5vvgelzP0y7HQi+ag04ctPM/hItkxLPsA2KhtQm8RYlt8vAgET1fUH+PsJeCq9PV+Gj0HNIKqbEvLX54jLmTBukanim66wDJ1hPD2GzA8Ibm3OxC1DvWGYkz6RrgToIDSXsoMT1KpQb8cu86pI9fEUSoCM7MDH+R5asHKPml74eUW61T2OI+f+Lv+d7KAVERS4KSWTfyHYoMF8e+aJk3wGmh18AP3jwoq5m6hTI3bYTVC/UMsBdwX66Lq9jVwnjWM1dtAsMgiyDuo4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dVU1vlZBdBQO8wUDdDBn9r6XXLPeWUszBk5JSBs49E=;
 b=gSQcYCdbZQGHwBN6Ytl7QaM7ml5DW+TkrFccQwdRfsYZcybE5qKyEHp90aakiihiNppVUA2KXn7a9TGKEmzCT9uEkAHCN83TeVIypsYDZTktwmt6Ql+l22YrKLis5m2o2INqQX2zwD9M/EATkDpG+Q44Vl/B44/cOfE8VnbPyZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by GV1PR08MB8570.eurprd08.prod.outlook.com (2603:10a6:150:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:51:49 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:51:49 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 2/3] [POC] Add rt_signal test
Date: Fri,  8 Sep 2023 12:50:42 +0200
Message-Id: <20230908105043.1355310-2-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908105043.1355310-1-johannes.kirchmair@sigmatek.at>
References: <20230908105043.1355310-1-johannes.kirchmair@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4909:EE_|GV1PR08MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb993dd-4722-44b7-e8b2-08dbb0599a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SgetABV7nu9xObQgvFa3Y1USTUsFk5ZAGX96E/S0eurx9oda/vZMZ7jC81jkdMZMKgaJ0RrvBiRGBT9S6PFTVpBVfZLHsSUyMKH73aC7/H6ovPpnKOXCAfs62EtftGQkjImrGGxSYKA+phCZi8nnkQJl83Du+duuapMbBqg4HZuwWeM7f6EZC0ZGxZIUDxTZ/BI8FFpWdU9Q76b+fwO6p9NhbL0P0Cm+pd0+TXo1mPQJL9yygqMoDjPXYOBJ8DA+p9tj4c+tbfDp1q6xwi5g/YDJrDfP2qOCMGXfcxk8v+qVL8laT2E3gTOIJK+OtGbGm3Sa7FOML/DcWHYeP8oigjDUY4eRAE9d7C/Yoc1Osb0rJwt7nhJd15cZTK+eVqRe2em5o8h7Ip1zdUf2oRY/4J/mSBTf+Wd8PQc3bcHlfduPOpMPHa357chtNOK1AJi+stWalFS1EMzhppdQ0Oj7+RyGnDjkxp3JYzPBcDdqmeBiDL4ms76Z6uV9Mqbk7dGw7xeUWwaQcNjvpzzhZKfv9JPXIiku1EBFoOiBZahC/9cGGHTr4smjJU0E/D4ONtPJ6emlu3EF7Sk9l59qbrQaMCRFhs5aeifibTwNVUcrB9v8vBmVcFGpoRa+Hx9M/2NW/NuT+UwQk4Ai0BEJvMzLdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(396003)(136003)(1800799009)(186009)(451199024)(6506007)(6486002)(52116002)(6666004)(6512007)(478600001)(83380400001)(1076003)(26005)(2616005)(107886003)(41300700001)(2906002)(6916009)(44832011)(66556008)(316002)(66476007)(66946007)(4326008)(5660300002)(8676002)(8936002)(86362001)(36756003)(38350700002)(38100700002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rsQ5o1QjG6Uf2yoXtHAZajw/F2EG4wMTR3Vl1spFlQ3muAArD4bv1mXU7w7?=
 =?us-ascii?Q?ZVwXLtpTKIqfdkXoW6c+vb1WVjOMAJLsw2digsM9izBSYKiOIbsd5PLQY3zF?=
 =?us-ascii?Q?g5T7oPtLYeseHLgMi+aqnUruBjYW6KupYnT3u1onLf6sLxiPxWHRq/IKo/qs?=
 =?us-ascii?Q?FX2TPMxlUXuGidY2v3rznPFWaqWCcVUwudfyqM0iipJHo0NWC6qN2i9Hv6Lm?=
 =?us-ascii?Q?bRBM3BNFyj8lAUdZtyJT5y1YaF1KY1i6arp4HFIfMvqY9Mb7k7eD0615Ob7b?=
 =?us-ascii?Q?/DN3ouWP9IEfenxP/i9+IQwTdtNsalBRDT0AvDd46A6AlLOp7am7QWAJBNB8?=
 =?us-ascii?Q?WC5oJSG++652U0jcYisvdX/nnq0FlI0N8mo3afynwnI9jrgGY7ZW8+w4fiXU?=
 =?us-ascii?Q?GhPox8k7NP2wKVcylOK0mDBiZUM6cFxly31E5BGDv61eN5qRoK7fhfxFMFWt?=
 =?us-ascii?Q?2D/ApbEDZ4/IBfgWaG0FftmpxUReUGjdI17HM6bOYQkL9VR8HeDxi3haih/O?=
 =?us-ascii?Q?900+76T+aRtEf+LdEzqHwbjcQsXXuRBH8mCQd5IoeV5AZhB7EN6IQ8DEyiF3?=
 =?us-ascii?Q?Lgek1FMY8ScXZEQ8iqsFb6d4Dzxjuq0L1ouLHqoHXrpooE13hLFQvibORBvW?=
 =?us-ascii?Q?mjnu6oDOdTNrraoFZG15eu2TKg9HvpqWW9gS3V6zRRTFShtnCFLlhU0hujzy?=
 =?us-ascii?Q?dEWlNPaPYACBfldMw1DGvD2XkJgsJTmt93gAqwxx3Jzuge+g8VrtQFk7UMTt?=
 =?us-ascii?Q?k2Vu43SZR5mUsbxIMO+VSPNyhWONUVNodkd09d29Kuof5GSQTK1lleco0zPp?=
 =?us-ascii?Q?7RmJoRPrFsq26UO5N/dZ3oEMfvTNoDkMWtkLV76Gs5xke5o67rVhBl1Sw5Bn?=
 =?us-ascii?Q?sSBhDjPFtRd96kRjRpi7QjztsECRe+Z01JM3e2a4VIR3nXD68eRIG2rmJdCI?=
 =?us-ascii?Q?YIfv7CFOxTCy6G/iAJ06GtZtOVYXqHzUUY213HN4PcDvTS1iVbWCu0VgAWFA?=
 =?us-ascii?Q?o+17QVcuLQC6VMT5N5F4h+JjN3IVWI7gtt8SD7dwwQZMoc9hg7zjy1vN+7T4?=
 =?us-ascii?Q?1hJCFuT2WMfKcFvjps6ecksLAm0WY+9iqZuHfnhvptczwHCbPU2wc6RjsMkS?=
 =?us-ascii?Q?b32SYqDAbWDz/MA9BtCiIaetLarcsZnf2s/ZiALHsCWFYiNiaJWEJeseJM0n?=
 =?us-ascii?Q?4m8RszYBiba0z5w1qraA1E9YYHaftahNCBuPLcEbQ53hFIj6ykAHtkU1LJdT?=
 =?us-ascii?Q?ANhM+YsEu6iiUNx6udx7Z7S3oQpJG1qgUdmFRCVxvtMGAgT+coxcYje56Imj?=
 =?us-ascii?Q?tD7IVA4Kem4Nn++K/3W/BRPvVMnI6tcz0kzGwssqQAJir5VehC1gfWEkKYqm?=
 =?us-ascii?Q?X1iAma3P3grZ1T2YXF0fve86PA95Mka/FT0HmEFJ2/d5cnZobD600SPI/DyR?=
 =?us-ascii?Q?gcIdqG6iJ+oNHpSw3m0cdn8VNVBUSs1uZp+61rUNl7VYs9PpZuc0PUq9iPEX?=
 =?us-ascii?Q?TrWIJByhhx0VOqZ1F7MulIBYu2hRU6o9rV1yRNjA3nrhUmvxVynQTKMSdH6P?=
 =?us-ascii?Q?aooPehs/DUqhqPmH/jtY9vGnuHRZ/z4OCM0Y2lF02wdRLRf+R/sTAOPXokyL?=
 =?us-ascii?Q?3yiMu6kBGC2C1x2BB072Y7Y=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb993dd-4722-44b7-e8b2-08dbb0599a77
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:51:49.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceWpxiwRkrhkJinPHBJ94PGWxHwqmfY3JrUwDhdUML+MPRMpRKB3ZmLfgPcqhVDTzhQaHQDBhEuQjDZ41or3kE1ErRWr58F4KMBCcyOeK7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8570

This commit adds simple rt signal test for SIGFPE, SIGILL and SIGSEGV.

Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
---
 configure.ac                               |   1 +
 testsuite/Makefile.am                      |   1 +
 testsuite/rt-signal-tests/Makefile.am      |  31 +++
 testsuite/rt-signal-tests/rt_signal_test.c | 231 +++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 testsuite/rt-signal-tests/Makefile.am
 create mode 100644 testsuite/rt-signal-tests/rt_signal_test.c

diff --git a/configure.ac b/configure.ac
index 3ce34048e..3325482fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1007,6 +1007,7 @@ AC_CONFIG_FILES([ \
 	testsuite/switchtest/Makefile \
 	testsuite/gpiotest/Makefile \
 	testsuite/gpiobench/Makefile \
+	testsuite/rt-signal-tests/Makefile \
 	testsuite/spitest/Makefile \
 	testsuite/smokey/Makefile \
 	testsuite/smokey/arith/Makefile \
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 4932f6d33..59f36967a 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -5,6 +5,7 @@ if XENO_COBALT
 SUBDIRS += 		\
 	clocktest	\
 	gpiotest	\
+	rt-signal-tests	\
 	spitest		\
 	switchtest	\
 	xeno-test
diff --git a/testsuite/rt-signal-tests/Makefile.am b/testsuite/rt-signal-tests/Makefile.am
new file mode 100644
index 000000000..084347631
--- /dev/null
+++ b/testsuite/rt-signal-tests/Makefile.am
@@ -0,0 +1,31 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = rt_signal_test_fpe rt_signal_test_segfault rt_signal_test_ill
+
+alchemycppflags =              			 \
+	$(XENO_USER_CFLAGS)    			 \
+	-I$(top_srcdir)/include
+
+alchemyldadd =					\
+	@XENO_AUTOINIT_LDFLAGS@			\
+	$(XENO_POSIX_WRAPPERS)			\
+	../../lib/alchemy/libalchemy.la		\
+	../../lib/copperplate/libcopperplate.la	\
+	@XENO_CORE_LDADD@			\
+	@XENO_USER_LDADD@			\
+	-lrt -lpthread -lm
+
+rt_signal_test_fpe_SOURCES = rt_signal_test.c
+rt_signal_test_fpe_CPPFLAGS = $(alchemycppflags) -DTEST_FPE=1
+rt_signal_test_fpe_LDADD = $(alchemyldadd)
+
+rt_signal_test_segfault_SOURCES = rt_signal_test.c
+rt_signal_test_segfault_CPPFLAGS = $(alchemycppflags) -DTEST_SEGFAULT=1
+rt_signal_test_segfault_LDADD = $(alchemyldadd)
+
+rt_signal_test_ill_SOURCES = rt_signal_test.c
+rt_signal_test_ill_CPPFLAGS = $(alchemycppflags)
+rt_signal_test_ill_LDADD = $(alchemyldadd)
+
diff --git a/testsuite/rt-signal-tests/rt_signal_test.c b/testsuite/rt-signal-tests/rt_signal_test.c
new file mode 100644
index 000000000..ef569b30d
--- /dev/null
+++ b/testsuite/rt-signal-tests/rt_signal_test.c
@@ -0,0 +1,231 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <copperplate/traceobj.h>
+#include <alchemy/task.h>
+#include <assert.h>
+#include <setjmp.h>
+#include <asm/ucontext.h>
+
+#ifdef TEST_SEGFAULT
+#define TEST_SIGNAL SIGSEGV
+#elif defined(TEST_FPE)
+#define TEST_SIGNAL SIGFPE
+#else
+#define TEST_SIGNAL SIGILL
+#endif
+
+#define BIT_FAULT_HANDLER_ENTERD     1
+#define BIT_FAULT_HANDLER_FINISHED   2
+#define BIT_FAULT_HANDLER_WRONG_TASK 4
+#define BIT_FAULT_HANDLER_WRONG_SIG  8
+#define BIT_DOMAIN_SWITCH            16
+
+static RT_TASK t1;
+static sig_atomic_t status = 0;
+static sig_atomic_t cause = 0;
+
+// #define JMP_CLEANUP
+#ifdef JMP_CLEANUP
+static jmp_buf jmpenv;
+#endif
+
+static int status_ok(void)
+{
+	return status ==
+	       (BIT_FAULT_HANDLER_ENTERD | BIT_FAULT_HANDLER_FINISHED);
+}
+
+static const char *sigdebug_msg[] = {
+	[SIGDEBUG_UNDEFINED] = "latency: received SIGXCPU for unknown reason",
+	[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",
+	[SIGDEBUG_MIGRATE_SYSCALL] = "invoked syscall",
+	[SIGDEBUG_MIGRATE_FAULT] = "triggered fault",
+	[SIGDEBUG_MIGRATE_PRIOINV] = "affected by priority inversion",
+	[SIGDEBUG_NOMLOCK] = "Xenomai: process memory not locked "
+			     "(missing mlockall?)",
+	[SIGDEBUG_WATCHDOG] = "Xenomai: watchdog triggered "
+			      "(period too short?)",
+};
+
+
+#ifndef JMP_CLEANUP
+static int get_step(void)
+{
+#ifdef TEST_SEGFAULT
+#if defined(__i386__) || defined(__x86_64__)
+	return 11;
+#else
+	return 4;
+#endif
+#elif defined(TEST_FPE)
+	return 2;
+#else
+#if defined(__i386__) || defined(__x86_64__)
+	return 2;
+#else
+	return 4;
+#endif
+#endif
+}
+
+static void do_cleanup(void *context)
+{
+	int step = 0;
+	struct ucontext *uc = context;
+
+	step = get_step();
+
+#if defined(__i386__)
+	uc->uc_mcontext.eip += step;
+#elif defined(__x86_64__)
+	uc->uc_mcontext.rip += step;
+#elif defined(__aarch64__)
+	uc->uc_mcontext.pc += step;
+#endif
+}
+#endif
+
+static void signal_handler(int sig, siginfo_t *info, void *context)
+{
+	RT_TASK *self;
+	(void)context;
+
+	if (sig == SIGDEBUG) {
+		cause = sigdebug_reason(info);
+
+		if (cause > SIGDEBUG_WATCHDOG)
+			cause = SIGDEBUG_UNDEFINED;
+
+		/* XXX: caused by rt_task_delete() */
+		if (!(status & BIT_FAULT_HANDLER_ENTERD) &&
+		    cause == SIGDEBUG_MIGRATE_SYSCALL) {
+			return;
+		}
+
+		status |= BIT_DOMAIN_SWITCH;
+	} else {
+		status |= BIT_FAULT_HANDLER_ENTERD;
+		if (sig != TEST_SIGNAL) {
+			status |= BIT_FAULT_HANDLER_WRONG_SIG;
+			return;
+		}
+
+		self = rt_task_self();
+
+		if (self == NULL || !rt_task_same(self, &t1)) {
+			status |= BIT_FAULT_HANDLER_WRONG_TASK;
+		} else {
+			status |= BIT_FAULT_HANDLER_FINISHED;
+		}
+
+#ifdef JMP_CLEANUP
+		longjmp(jmpenv, 1);
+#else
+		do_cleanup(context);
+#endif
+	}
+}
+
+static void do_div_by_0(void)
+{
+#if defined(__i386__) || defined (__x86_64__)
+	__asm__("xorl %eax, %eax\n\t"
+		"movl %eax, %ecx\n\t"
+		"cltd\n\t"
+		"idivl %ecx");
+#endif
+	//TODO find a cortex-A way to trigger an FPE
+}
+
+static void do_ill(void)
+{
+#if defined(__i386__) || defined (__x86_64__)
+	__asm__("ud2");
+#else
+	__asm__("udf #0xdead");
+#endif
+}
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Warray-bounds"
+static void do_segfault(void)
+{
+	*((int *)0x73) = 0xdecafbad;
+}
+#pragma GCC diagnostic pop
+
+static void task_proc(void *arg)
+{
+	int ret;
+	(void)arg;
+
+	ret = cobalt_rt_signal(TEST_SIGNAL, signal_handler);
+	assert(ret == 0);
+	(void)ret;
+
+#ifdef JMP_CLEANUP
+	if (setjmp(jmpenv) != 0)
+		return;
+#endif
+
+#ifdef TEST_SEGFAULT
+	do_segfault();
+#elif defined(TEST_FPE)
+	do_div_by_0();
+#else
+	do_ill();
+#endif
+
+	if (0) { // so we don't geht defined but not used errors
+		do_segfault();
+		do_div_by_0();
+		do_ill();
+	}
+}
+
+static int test_sucessfull(void)
+{
+	if (status_ok()) {
+		fputs("Test passed\n", stderr);
+		return 1;
+	}
+
+	if (!(status & BIT_FAULT_HANDLER_ENTERD))
+		fputs("Test failed: signal handler not invoked!\n", stderr);
+	if ((status & BIT_FAULT_HANDLER_WRONG_TASK))
+		fputs("Test failed: Signal handler in wrong task!\n", stderr);
+	if ((status & BIT_FAULT_HANDLER_WRONG_SIG))
+		fputs("Test failed: Signal handler of wrong signal!\n", stderr);
+	if ((status & BIT_DOMAIN_SWITCH)) {
+		fputs("Test failed: domain switch happened!\n", stderr);
+		fprintf(stderr, "Caused by: %s\n", sigdebug_msg[cause]);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	struct sigaction sa;
+	int ret;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = signal_handler;
+	sa.sa_flags = SA_SIGINFO | SA_NODEFER;
+	sigaction(TEST_SIGNAL, &sa, NULL);
+	sigaction(SIGDEBUG, &sa, NULL);
+
+	ret = rt_task_create(&t1, "rt-task", 0, 20, T_JOINABLE | T_WARNSW);
+	assert(ret == 0);
+
+	ret = rt_task_start(&t1, task_proc, NULL);
+	assert(ret == 0);
+
+	ret = rt_task_join(&t1);
+	assert(ret == 0);
+	(void)ret; // so the compiler does not complain about not checking ret
+
+	return test_sucessfull() ? EXIT_SUCCESS : EXIT_FAILURE;
+}
-- 
2.25.1

