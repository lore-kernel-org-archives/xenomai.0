Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2102.outbound.protection.outlook.com [40.107.241.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB7C196
	for <xenomai@lists.linux.dev>; Tue,  9 May 2023 13:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osg62zRYQjQlP+vOWGlawYbG0AVi6DlV8Cbfs7xeUPjZcqpZuKb6wHNy5oHqIDF1WymCh2P8RXSLSJxCaF/goLs6Ob60v/jmQJnFQklmJOTUtd+u9wF9S/Lv7SoAG7i7c38uzhDE9lTOqflKEbIXWd0+AoBunlLZl/dbTn37/n+QpCczdqh7PBWv41ZHQzAMshC8FhiK5LJT0J7QQOdwOuAKiz6xPcOPkEmGye34T4sgBxLvw15jWfw1W+ylBQg2jYBX2FSlBKAv+hn7UdYGaXjXggIcdhtxxuIJDKcWXsBCHCGlqWGarsLCDv2p/h6YPsXPJXb1W5i/c9uLOWfg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDXNs2Zn5MyYAIEptWxQaWJJVTpVhygEGi07CZxveys=;
 b=lNIL51Bdv6vlFjXyswtpmcPnfEY0XvKn3X0bj5yBZ5lfGWe7rJR4ItXz8PUE7BYBWM411k9GEaspl+JXBvo4cwsW+c0LyLTp8LPbSToV1f0nENgRaF5epUZ1nBkA4QyE5sV4f2z2+xuel+6FHkInq6z5bJv6F2JpJAePrxHXG8caTZYypc5bGmo09Ehr9O6g3raWfyE8Z9vASDb6bNeUPjz3OKA0D1BZT9Oy361jtIN8OuYb9urlu11myZBNhKp2yiUFwEs9i8d8d+eBx24YzvUU/ijm5lLliSLs55SDLj/10zYKzwziVdSbXbQpcUTaDwDxOlmT8zeRJUzwisdVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDXNs2Zn5MyYAIEptWxQaWJJVTpVhygEGi07CZxveys=;
 b=WzLMQF2uveCq/cIEy2wo/hMzaO6KbJGBqxQmIy1p3LdKfKvo2V2Cb3UfjOBhKOZoY+96qLjrCiWE+lBnnnnt0/+foL/PGyjsYZfTffkdN42iVs8406GRrZB0ZX+4LtLKE8SfrQXzYjSDJlZf+7dW1faZGtvBKafNqQO9azGkEVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS8PR08MB8442.eurprd08.prod.outlook.com (2603:10a6:20b:568::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:14:40 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:14:40 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: johannes.kirchmair@sigmatek.at
Subject: [PATCH 2/3] [POC] Add rt_signal test
Date: Tue,  9 May 2023 15:13:54 +0200
Message-Id: <20230509131355.3003275-2-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
References: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0101CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::44) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4909:EE_|AS8PR08MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6bf1e1-0f20-4f5d-7cfb-08db508f589e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cF0trlB+l9QaUR/h6LxOfzuSfmjl/ouG63k2HU5xcdJIj0oF0wcz9VUIqa7znkW4tLj47q3TBiOJCFUGtuf33AGrWhRm/XlYDFCk7vS5TZEODWD4RYeGJv+BFMenpMGN2SE9hGuANxfem5EI/jxcHkJ9V6qdCg1fEMqfMMtSKQFsVeg4lNbdzm6U1XH/Y1hUUV/wM1GeNalt/7wHb0plBQOWH0xD+SZK+9Qq1nVXeqFY2lAcpPRvZ/e9FNBwe5GCjY5qmVyUojvh0cCtaVeIybnDPxtrLaF/X+LapYfDN8ApXFcvuEg3qy00IiggfKGbN/RuD+ANBHoTUMFUN0rLPGFeXOfbT7fHbGB1v9LYCsqkIcW3drjW7qvM/Jbl6dV53h+9xmgczQwbjlJSXQbJYwUN8XZ9jwt4Jp0CtK0qPK0ftSBYVAkx/R94HSAHi1Pl67VACh2JNKHwAGPNMfiI2UiZBqDHWdtkVnTj8EwBnxsNuG+Whwm+eMssDtkJswfNF8h29Q3gZpwPlyi+Ga6LvdJUtU5TV8dN7pKyS1whT59UdIuGtJT6oLoMdfXTQw5JDNvI0w673kGql+aVfBDRHeTpFkYULgetCT/YL+4oLgn5K6/ekqFhqF/0aJQcPvdD0VE1rfIDARv9B0DLs69gMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199021)(8676002)(44832011)(8936002)(5660300002)(41300700001)(316002)(6916009)(4326008)(83380400001)(107886003)(2906002)(86362001)(66946007)(66476007)(66556008)(26005)(1076003)(36756003)(186003)(52116002)(6486002)(6666004)(478600001)(38350700002)(38100700002)(2616005)(6506007)(6512007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcM58B5nFrpOZI7wgT5wD3yeLFs5AXOnwaj50pKJdvF3jINLtWh1YX8mGVwS?=
 =?us-ascii?Q?fjWrb+bt80VPDy6g8IDQTckysBKTKjLjLSwT75PRN/AO7apdoyOeyREbbaHK?=
 =?us-ascii?Q?vQrtzrscSq0Vs3KVkG4KiRXcrTt4kucvhIMmd12kaC6/S2pDwQVOKhs6p++p?=
 =?us-ascii?Q?8M+QZ9tLN9P7oYCtxUnh1YQ3kax/3pD1i4yaLQi91v/HxirFhnZH7UI9ScXK?=
 =?us-ascii?Q?vykU7h5OT77NLbb9VUY3if86BOr3fcbr399MbnL8yyZvTo6L4fBdLFEdckfV?=
 =?us-ascii?Q?jfB5cPqfHw5efw2l6NuR9xdCm0rmMQyBFfHKYNpbkKNVgNzeYXGLXmOEB9mN?=
 =?us-ascii?Q?d4qnIKKDXm7BMGxu5UnNbvx0o10yCs/o0TdNZplKJls4VTzfcOIszqsoWAyh?=
 =?us-ascii?Q?jXqAWiSnvjfjKsawSIG5Th5VcLWiwbX2crdglbf/QxdPfj1I1FKQRsNrzZv6?=
 =?us-ascii?Q?17Ud4RmujIZarzkks8/zK7G+ENTTvIV2FAnrHcKIF9lV4We5QDeTghZxHHsu?=
 =?us-ascii?Q?wl41GtI/7RxphqxdTPpyj+N1FqXXms10uFfBaZg1Es6ypFZO36+c3Oi3dPlp?=
 =?us-ascii?Q?SZFVDF1BGA1BCUxivur5otQ0LVQFXKIYprAExs2//rZMXeQV0wtcIrXKMTAn?=
 =?us-ascii?Q?V9ML3NGRUf6zKkyH0hYqQxLLJuPJlvh61tjGB99BJT3urIRpZ16n3uN0RAxY?=
 =?us-ascii?Q?Lb5X+i5b/3FAGevN0VZdTOIAnGAcVAe2Kah2Msvfel2U5to0RjkVmo4c6cJv?=
 =?us-ascii?Q?b3BSTZIvrOU0fLmSZm+2yylZYrty/MzHcZm6+4Xcy0+UYsSa+P5zmh14rkeQ?=
 =?us-ascii?Q?8ckm8FGORGJ9rrrCaIhF4J4e3O/vldi6EDv6WhmamcfGeFZCRYL4S0nL8qSY?=
 =?us-ascii?Q?yd2EhX41lNn9yv3QncAUNRAUJgl5WXQBHPeCxjYgcQ8u0ag2dtsv3gtWdf/z?=
 =?us-ascii?Q?3H5IsxJmfBPWNdKbuCVnR3SPwEJ5O/jKcEhrgiyBRKIh7ZOyDyt4+vrhYujY?=
 =?us-ascii?Q?RntQaLWUkzQ5cRvJG1PUtxC70XDUY6N0xm+h1JqlB3K65Xq2Vr5SD29OqcF1?=
 =?us-ascii?Q?XiO+HvkorFZYxC44P8epO1ooiLbdzkG8aFNf+ymAp3L83eQRlTx0Mcx+S6L6?=
 =?us-ascii?Q?rWl5XN+CpXYVllD2ngmvLh6BmvT4FOkGkBbX5vu8sImTC1rx/G0gtM0Xv3sv?=
 =?us-ascii?Q?ej6fQSgv9u5Cn2qBa++NClMkUdsqC6Mgdv+lgtRPZ+X6SvnFGzNZrMOPAhl8?=
 =?us-ascii?Q?3IzAs/HmRg73x0hQz4+F/PftqDSLgKkzGNNJ7y3karzSxP0RNBBz5snLb8zJ?=
 =?us-ascii?Q?XjXN4zDg4qx0os1K3ciM4xzKm46I/FizhEtU2se4v9i9HVzMaw/qMRYhFbmi?=
 =?us-ascii?Q?aKMOg/LYstowJ5fTUcNZvBA4oOx2y4OhnfEo7RDt1MSf76EMtGjuhz1a6z2W?=
 =?us-ascii?Q?6QnLDb4XM5tMeTvMQJ1bnfcwpobw1O00IrqgyOrWjwe/TVtL3PqlKaYmuftg?=
 =?us-ascii?Q?64lTbMQHgeLR5C0478vKEAW3NcLr0pd+N4S1ig7Ae97kPy3EWMHJoQ8cwUup?=
 =?us-ascii?Q?AmXLw5Mtf7QaM8yGAoysKy4l69h2KC0G+TfDOm3KbiGg4jpANqS967vpstAt?=
 =?us-ascii?Q?XSvnybxOwdipRb3rx8Z6VqA=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6bf1e1-0f20-4f5d-7cfb-08db508f589e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:14:40.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJi7NWpD3f3dI2XU8i4FpV2O9CCYDZJoDboQn/MOeSEtJQT7RB1nlyCk8z1lQlDORzy5AYtT6d6CPMVqetEsWQ9w1ZkxAfltmK3vYjFVa6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8442

This commit adds simple rt signal test for SIGFPE, SIGILL and SIGSEGV.
---
 configure.ac                               |   1 +
 testsuite/Makefile.am                      |   1 +
 testsuite/rt-signal-tests/Makefile.am      |  31 +++
 testsuite/rt-signal-tests/rt_signal_test.c | 228 +++++++++++++++++++++
 4 files changed, 261 insertions(+)
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
index 000000000..0d43ac8da
--- /dev/null
+++ b/testsuite/rt-signal-tests/rt_signal_test.c
@@ -0,0 +1,228 @@
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
+static void do_segfault(void)
+{
+	*((int *)0x73) = 0xdecafbad;
+}
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

