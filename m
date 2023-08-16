Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2096.outbound.protection.outlook.com [40.107.241.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7ED2EE
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 10:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVasPkiu5jirzwkDSI8JhMSaL+mW5eZL9vUfCK/iu6ejhvMUkLUPYiJiXLAaxZ2xpp2x4wt1iv/rHYzu0QLGewZoLYZw7d0vl4N8Z/Ms6FqvVIBLX2SnGeq8OpEeCpASkS3WoZnmsserfXT9T/ygBzZcUtqYsRP879BkHUQ5wUgFqEMQ/7mLjtoSrEyObQxUZb1LFhBVLLNGcFoqZht06vXnZt4uSuyFVY0cA2e9xsjtWvsQm+d2AOE/4SZkjD37XlLh+ASA/pb21AdnyyD8AtZ6A3zXPQR6JrWNzpsNdADcYt/NwreJ64G5XPCsujhc98cAGH5ZxhyslzzNO4UFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR9tymniCFNddqwyCjBQW06TgTjCJNOW5IFeP8zd4pM=;
 b=HWHOd6giUO5JtKOp/yXvZ6ct2nAqP4QGdmzgolYh2rTQnoDm7tWzsciASsJTk35Q4S0XO4ASVpQFmjc/NEG4UUacdqJgh4XVrrfOPbzq+QWJlGsMeui0B2RExmRZC0wtVQFFxcQhqLbhmIxUVi0WfNfQMnWweVmS7MODfoV4unZJuGyNyIi883abEieVJvhh4zfhAQnm8AU8zITbDpZ3embArSNqcT0TaL7/qJ6JOGmIw10kapztIGIbWf3/DzwRbAQN/+3tNzYZabebQPVjK7jtcv0KSsfqvyM+VJw7vN/etX5IX2ymDTnBxB9KKQ239ExFdMMubS09Fk9pMtHs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR9tymniCFNddqwyCjBQW06TgTjCJNOW5IFeP8zd4pM=;
 b=ZFOCeHEY8b1aOZsZhSavBs+xBm6rabgFBBuCVlGStvAaRlPffF4XIZ1f4RzikHC/iAMoIjuxpGaF3ncTQHliDHpxc0Th8NLTq+aGzpyk9Tpo2V3IpLU44OwmYPlbQf7F9ilyeSxuuNTTx9rBU1xRlPtmfJMQeOeQEzzORcRxJmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:19:45 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470%7]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 10:19:45 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 2/3] [POC] Add rt_signal test
Date: Wed, 16 Aug 2023 12:18:41 +0200
Message-Id: <20230816101842.3377643-2-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::35) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4909:EE_|AM7PR08MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 983d7a35-70c7-407c-9f8c-08db9e42502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O0fU2mVA0HjPtQ0i+Hq952ydzkbjF+7BweD3vU5OfxgUd7/qCtU2zLsoQb6kB7GNhGldSSP/yi641rnpMCVd2lWIUFxEi0q0qd6V64B+XsT+ngmdEllLQwgLPMEfZ0q5cyGF+tILkK5efeQaKTpOx4nJMA5M9GonIGIZarRNSrgH2mdyUK2W5V2qP24tN6cto3SCWlr2Jio2Xsb0SoZdawAld0+ks6/r7xFtGa9KmP4MIqW5n8b/gZSiZzW77255VpNiuPoMrGtJY+sGr6ocFVUQP0LU2oVPzM5IeFafjzHf9wezoV4T2GpxL9ZMlulvrYGZN51Uf3Fl82aYRj6Km+C5Bswnn2fvy/kD1e1s8xRDuPsEFpyyE5HdPI27Ler7e2bBkVvmiknUcXUY2TC+I/THmHMDORDlQtsKCDvECJC2k6Ss1/dbNMLQZ9Gd/zSAjz/oZNL9K9E7sA03j2j4idyvBWJM7MvNdx5keACrOv/S9vmtuy4NJaXCihYYpHqjK9we0E9I7g8G+vGzv6HMTQz9ZLajBo4t4VmIf8pLYgfeKTNn67MA/IyX/QWE3UXBE6eeee6ty4c10/cbtXdFmxIDg8AplldXUTAGbWTHM4/PWsMLOpHhieZATgyU6p+3JscPBHKWEK0p6c1kJ3oFNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39840400004)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(6666004)(1076003)(107886003)(52116002)(6512007)(26005)(5660300002)(44832011)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(38100700002)(38350700002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KkkpK/HJtkHltPQFlY/ioXaOp9VLtPgonmTwbZjq5rUFEfSg25hwYTVejfah?=
 =?us-ascii?Q?Rulk1TO2EaLy6sq6DGg2Zhyd22t41tBJN4+FHZRtqCko9sMXAjfQ3Q4YIN01?=
 =?us-ascii?Q?nI1/NrKgXYzvlV+L+bcqV6UDr5ogNdlmHQjU24WHLzYj6LjV7Dx0iF8P1HPP?=
 =?us-ascii?Q?GBZ9L127nkZCKgif/9zkvkSi7B5AVs2wmkLwFKAejMxeo/dA5nAJ5UGP3I+d?=
 =?us-ascii?Q?4E4Swr4oR0yHw/pv4gUcv/8wqG6i4VpMwrnSHN4U5Tejap7IxPpTBQJ5VTHW?=
 =?us-ascii?Q?ui7ZwOIhVO4gl5wdNudScubYL1pEa6pNZjzQ8VmxUoB1I8/n1M8lRy6EfzeO?=
 =?us-ascii?Q?f0Txmu+c6TjDz2h0Z4fxT5aHNMZTTfoHUjk68EETWJA4K1F0oPVsl4MTjDVf?=
 =?us-ascii?Q?xYWW8Jgpum59zZJiRW4v366gCvJCbM3+ReX2njQdQxvMsoss7QWjq20NbbvV?=
 =?us-ascii?Q?2P7mPTN/lEi1xjsBi24XDfwB0xNeIAf+zD1QaRjPEr7MwnB2AU7BMF6X+35t?=
 =?us-ascii?Q?MYvm/ZtHfkW1s8GezZ7a/7amxvnQcF6rVC5FnoabTldnuzNvoS1cc0CNkoEe?=
 =?us-ascii?Q?lPRKj1TMhghaKI7OvVwGOwe1Zy7wIQ9JgV/LDcHb1tzLKKXwnUv9mrKRHx0g?=
 =?us-ascii?Q?StWwyrXOJT2hzKvUpV7l2SD5I4yvVT7H1HSi9Tw/4JEBHtofn3PqfPam1mpB?=
 =?us-ascii?Q?tVCChgRKeiHlMZRIojSD27w+eCWINwUxmXt5nbgvw2Wns5oTPp0da8PffgAv?=
 =?us-ascii?Q?C0VKx6NoNofiEcxeCt9pBsROEoIOozL4f9rqcm/bGWyQty3t21qOVaqlYT7s?=
 =?us-ascii?Q?kYGr2WArVdHOrqg3bnu9x3showNw+a7J6XSM8JgkNddLZ34cB91SzxQkAavN?=
 =?us-ascii?Q?YceafZZB1z6tiRC3elvq0H03mKrC+BKOw0Wm9S8n5fbkAoBkdb0uQxmPJLC5?=
 =?us-ascii?Q?H3RTMHuNS9UVC2rQG589cM6EAZImt6N4+dqQrTeiykcU8PUaJQeji+xwn3Iw?=
 =?us-ascii?Q?RB9PvJe1p95Vd5FOvE9E7fvInlWT88LIdAZUFYy6Ly/amzOXk8XaUVwP00nv?=
 =?us-ascii?Q?UgfxQ700VaQtJxl5fuJCNuq5LSdivfdfdSNCsvK6Xowyr+NCdsfvmwKm60CV?=
 =?us-ascii?Q?2Dn7Exli94eA3HUx8p2AQMYkvDaV+khu41SRJRxcrlWWv9uvFly3oRuYhw+1?=
 =?us-ascii?Q?4ZxB3sWpUWn5fmuUs2d8//pUEZyz6nRJHPaFyO7QIJOwH0CQEPXRGqiin+Dy?=
 =?us-ascii?Q?cC8K6F09R8XONOEnshp8St23jBEivkjDDvohggIcfsYhMT5VnIjrNrPSPMb/?=
 =?us-ascii?Q?8xL22FuO46XZkso+jRXAHuTCTSs5BUGx+/wWkjt4lw5DZY+br9kau3W0xKcO?=
 =?us-ascii?Q?wpnAfdGclMf7FMnCkrw23DvMy6DQrFqlrykGiCH4Kku5XCu9luUjvkr6JxS/?=
 =?us-ascii?Q?adJpUBOpE8jliKFgai0Z3IILfD1hx6feaGO1DHLgQMcyA552Wk/GBbN17lbu?=
 =?us-ascii?Q?mDpoTC1JLkYPfXZpeAdanrTR9NnJ4/c3GEKblmDU535mLEDEC6MhWI9tMOmv?=
 =?us-ascii?Q?dv8pX77Y4XgWJFwTAmyYn0wHjNs/30WlICUoVKbB5VcixwnQORFki76xdNai?=
 =?us-ascii?Q?26PXLYJ/UlhvktJsMiTXmRY=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 983d7a35-70c7-407c-9f8c-08db9e42502f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:19:45.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSEX5SK8gcl9AeORtjxXKV65WQrK3L/46JTIUUDnJeMl+/68UwxbOWjtpqO7iHe2KTzxQz6SSmrqahlvEq+g9xiU2mPaqs5O2CX4QKM1c1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496

This commit adds simple rt signal test for SIGFPE, SIGILL and SIGSEGV.
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

