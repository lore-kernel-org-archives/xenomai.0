Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156E2111
	for <xenomai@lists.linux.dev>; Thu,  7 Jul 2022 14:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf5rQSULqHzh5Fojkr//CDpecwwmAED0+akK7Xn1gkm3o8M9JCbO0uqSoAXjvmK6k3HHH2aUxnCJ/4tCcGFQHvlg6RPjRdKKWcAnEGsiEaR2QgKYyygVML8VEfAQDCVrQCvDrTphwOVpRBQ5qTTuhbL679NbimrKZpjk8C5oX9CnYLD2pZhwwGWBlMA9EtFOyVuQ3y/ZHwipLl7suJEeywyxQ6q3vD40aymj4wJQqBbECzNTR8KoW9LUz0OMBajfxaEnpkTyOcp+x67vFHXAalfgzFApY8kom3RxAIlhalNQ670Tb7eAIHt08NIbNjTGd34IeRLza0HZcK5tfKSqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiOc3RD/EDmbdFzopfFRHWfqjvxpYPWohtvIP99V7bU=;
 b=Gnrj9EwWT10VG4l4SCoA+WKUGH4gNGgXObtD39gO4RDqjo0J7GTe1t0okj34inYwE0uFgdgdxW2KqG2Jn5mAF00CWYcaVwcNARaw3fdgwO8+Pum6oH02oslGyzaVSyK3xbS6P1O74AM41uf2xkt7O+AHmX9G57zydH3mPYQ/69tUhRXaslwi3rRg1myJxW7TMXu2hOKRlBrH+15csNHmR3uXoUxuef7wnsIXir8Mmv2JbOD03U+1VbzNpw5nthu5voWXkicXilsyXD8WVYHLF36rQnmPyPVRAX1AxUAziXnwa/KVmSUBYioTr2ldvy5T00H7dM1+n1WDGFlqEAatbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiOc3RD/EDmbdFzopfFRHWfqjvxpYPWohtvIP99V7bU=;
 b=kGT60k4Vcd5s0txUToHtIcEunr4eqBF1lQJqab7HYmTPsK6EBDtu31CXBqmNf63ZqVALkXCVhmoto4J/DF+6ntZYKhxsq3b6ntZt7k+igKup1PJu3KpdmXM5+PTbVEVZryoyZH/o5Q6WiwxwGAJzEGhzK8kzepAVYUtlMBW5ASc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AM8PR08MB5730.eurprd08.prod.outlook.com (2603:10a6:20b:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 14:00:06 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:00:06 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Subject: [PATCH 3/3] rtsignals: Add rt_signal test
Date: Thu,  7 Jul 2022 15:59:52 +0200
Message-Id: <20220707135952.5171-4-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:803:64::43) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29727248-11be-4c65-13af-08da6020febb
X-MS-TrafficTypeDiagnostic: AM8PR08MB5730:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PPMuPrG9wYHrngUj1Hb7R2S1KBNRYgsJa2DxEkE2thWfmqoPaS5M01nNPb51pd6EMsV8FOMRPMjvzNyThfXWy2eb/SvTBhELU+3DgCmSYcySqmJdEPecsdbrn+hg5z78KurngzLTSgTMBPCZe5DxPeaoW7ShjefE6+uA14mUAySDdcnzr/R2t5WqB6vvygattFcAU1yGzGo0eL+43M0UmtQoXRZNQuAJKg/HTzpuKYQJ0rTc2FnGK9ksbykIf9Rea/JKP2mGUq6JWWsF1KPXFjVJHpUTPjLNzxdA4bf4K86j+ND6yNM0tE/PKfUGchBp7Mhi64+fkpDwsXvLcFVeHnEwKqmADMaueB9nbSp9USTdrwZpq/v47jRLMv5h4UDcnhcUg1BxjCar6wBY9of1K+R1HVgU46bmw7kjHcLB8sFGgN/ZizNutXs3w0ByRVfI5y0gLM0LUsVP+SoPUkOMsm4KLI4MnUds9DzkhoV97dm0uH2/sDZM3KkoWbPxkUS7Fcz2gbKdYnb95bXaTyqvXPilx67tqroM0vF0jKKYuMh52p2sEwxAuZsowglZc8zhdEoEy6A0KNs+qoU5bnOq54gCqhc69KgnHQ8yEK/nbBuSCU7jdFGeYqCe+qfgsk1PpHrzYCJeL1EJ+tjgOTDTFBbgHESVsTgMQoCIbiEvYZOVAV8O/Wfk69pA2p29+NOzRAX6AY+jD1/z5wjmM5IcmdnVGAVPr/cyt5LjHQ/A8aPg5pSkRqAhvtf+gzuIWU/yVtNzZNYQdZ+1erci2NtkOOSWDbZJlhUpVyJImRYrQIv83tiUPaxONSZ5XhlY78MGf3YEdEOWxexUXfpjtdXe4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39850400004)(6666004)(38350700002)(38100700002)(478600001)(6486002)(2616005)(1076003)(186003)(2906002)(41300700001)(66556008)(52116002)(36756003)(6506007)(6916009)(8936002)(5660300002)(8676002)(26005)(86362001)(316002)(44832011)(66946007)(83380400001)(66476007)(6512007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+ZbGb/1RdK5QFr/SSVj4iFBZXu0JvFT2kDWr9W4GmbRzG7WA0K0N6HZpQNa?=
 =?us-ascii?Q?o7aJCyxA7h3e5hTuM1ZM/kXeOo0qH9aPMPtYqc7Hzo01McZ4JiYDNQrEOKyr?=
 =?us-ascii?Q?PLsDpUf1kiDM7xAXiW1ZO5/ILHCmif2D0vY419Mr1REw2dDsM8nSTvK1rl+d?=
 =?us-ascii?Q?GPaEs2coc5AdhtXpw60NuIbr9UxnqpToei67cU0gTeMPOdxWFRmlpuJOvkU2?=
 =?us-ascii?Q?XTVE5FouMF2Kq1RAjs1m38tvPf+LDQX2JyTdLcCrkItM50A3Z2u3BB9aC+VY?=
 =?us-ascii?Q?jSIC+P4G3dZdiWUWCRGAF8kDA1peXO7aZ0MwaRhSvlAvRz4TssIYFDF9tStN?=
 =?us-ascii?Q?UVnHg8Un8F/y1R8V7799pAMVoAf2tzl/JP5wZdUHyZ/8strqsFyD4n3MRM93?=
 =?us-ascii?Q?pJA3BWh8Y+FqYiPEKf3wggayf2I/2PdYmk/AYflLe3UOEQFeyPutOnjB8Gez?=
 =?us-ascii?Q?Hz2YEJe5hcOIggWFFFPs/3KmlS7Nclv1IMNj+4wws/2uQkkgI+jjcTyJwAls?=
 =?us-ascii?Q?+AkXwtmSTtOE5c+JqIW5mwiF2h68G/Z4WfCfobYpj9wQCTeBPVsG5JlA6gMf?=
 =?us-ascii?Q?Dgt9syl8lNFICZ/KJ0bgKC8NjnzuO2YuDmVjvi/uwqY98vRkalNue9jeRVdl?=
 =?us-ascii?Q?rdSRsVMS5KWlFJ1GpCh8JLo1SnUvo8GeZI6JAvlEpldAoSJulrpxO/9tbHq6?=
 =?us-ascii?Q?78MSolbysT82JsjPRUbqdms3uJgIOeg9gvnKahfY9HAGcrr0DmUsxO+sbf7F?=
 =?us-ascii?Q?bOTZmU6f+otDpULb4ymhz5ta9qNxqiwqTo9KLIFlEUOc6deNOY5A9HSarGxI?=
 =?us-ascii?Q?8tUU0ibSl5u8z8JslX1bzniJrfVbc7CR/sbjplNliMvVAip3iKvyxOBLSCb5?=
 =?us-ascii?Q?+SzzdqupqabGDJDHVqUzfMhsNDol8hG1GXsYacMDG4g5rKfoS8hIEH5Crzui?=
 =?us-ascii?Q?Ctvotj/g/9xqwkJ/wD0YvLYhVMpE4It48CMIkY48yXQKwEM8Ukh7IfSZPoTT?=
 =?us-ascii?Q?4ygYlYJtHpXuG3KOcL7+t+FJrcs0FE0TIBJx9oWSii3plb1XjcTz6mKzDxAj?=
 =?us-ascii?Q?NFFNqAP5ol0vmOMWE54jg6oaWIuXADeomIUUNCe5k3+DSwm2x+31Z3o9MDZU?=
 =?us-ascii?Q?/J38FmUrE8wK4TRyPph7l59oJEkYwSott7nVzuLUYc7R9W89dXQoKuPE8upr?=
 =?us-ascii?Q?GOZxLYUYBKQOoD8J0cAqK6S/mLGa0MISEootL5lEEvF19Ih0C1h2HQtbOP7Z?=
 =?us-ascii?Q?5EvpchtHgwv2KSFk2dv9zqc6TOq98jxOh6p76qbGzNVM81ippkIOPZkq4rRe?=
 =?us-ascii?Q?gQ1NJuU1vPyLgSlc/Q9kLearuOlOtFHwgGmSn9Y6byFMvQNUkagTZTjE5LgH?=
 =?us-ascii?Q?NKJt3UOiNyDsrQMtoiBsm0coZQdq2Z2PAsp/8xNlpw6tMAS6OAz4UxwK3NsL?=
 =?us-ascii?Q?NkGwfbrGCZTw9ksSas0c0c9fPKyduCo0ygFK9j2S4shB2n2iiwYXdkqLSKDA?=
 =?us-ascii?Q?UCU5Wa+5qcJxYw4QIpFY2rHTokWc4UI+GTQBKRT5v+QxpvlEW/ZgZMhX70MW?=
 =?us-ascii?Q?/EN4ajAf1EIar7rDYCtCh0/kFADZj0uK9NVV8aPGQvSeo0/r79r7W8rGN1Rc?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 29727248-11be-4c65-13af-08da6020febb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:00:05.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jd2SS/XIfwIgYRrFQOvxmjYl7SZIIRqOHXPGsOKdTsxQlpQyWad12gORPRJsQp8Y886tTgTAcAIVl8yvrbHTb9Vx13jHPyVonBFQoCVjx3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5730

From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>

This commit adds an overhauled version of the rt signal test
for SIGFPE, SIGILL and SIGSEGV.

Edited-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
---
 configure.ac                              |   1 +
 testsuite/Makefile.am                     |   6 +-
 testsuite/rtsignal-tests/Makefile.am      |  30 ++++
 testsuite/rtsignal-tests/test_rt_signal.c | 185 ++++++++++++++++++++++
 4 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/rtsignal-tests/Makefile.am
 create mode 100644 testsuite/rtsignal-tests/test_rt_signal.c

diff --git a/configure.ac b/configure.ac
index 61789af13..db92ddcc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -959,6 +959,7 @@ AC_CONFIG_FILES([ \
 	testsuite/switchtest/Makefile \
 	testsuite/gpiotest/Makefile \
 	testsuite/gpiobench/Makefile \
+	testsuite/rtsignal-tests/Makefile \
 	testsuite/spitest/Makefile \
 	testsuite/smokey/Makefile \
 	testsuite/smokey/arith/Makefile \
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 4932f6d33..87738dc78 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -5,6 +5,7 @@ if XENO_COBALT
 SUBDIRS += 		\
 	clocktest	\
 	gpiotest	\
+	rtsignal-tests	\
 	spitest		\
 	switchtest	\
 	xeno-test
@@ -13,9 +14,10 @@ endif
 DIST_SUBDIRS =		\
 	clocktest	\
 	gpiotest	\
-	gpiobench   \
+	gpiobench	\
 	latency		\
 	smokey		\
 	spitest		\
 	switchtest	\
-	xeno-test
+	xeno-test	\
+	rtsignal-tests
diff --git a/testsuite/rtsignal-tests/Makefile.am b/testsuite/rtsignal-tests/Makefile.am
new file mode 100644
index 000000000..25c1093c9
--- /dev/null
+++ b/testsuite/rtsignal-tests/Makefile.am
@@ -0,0 +1,30 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = test_rt_signal_fpe test_rt_signal_segfault test_rt_signal_ill
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
+test_rt_signal_fpe_SOURCES = test_rt_signal.c
+test_rt_signal_fpe_CPPFLAGS = $(alchemycppflags) -DTEST_FPE=1
+test_rt_signal_fpe_LDADD = $(alchemyldadd)
+
+test_rt_signal_segfault_SOURCES = test_rt_signal.c
+test_rt_signal_segfault_CPPFLAGS = $(alchemycppflags) -DTEST_SEGFAULT=1
+test_rt_signal_segfault_LDADD = $(alchemyldadd)
+
+test_rt_signal_ill_SOURCES = test_rt_signal.c
+test_rt_signal_ill_CPPFLAGS = $(alchemycppflags)
+test_rt_signal_ill_LDADD = $(alchemyldadd)
diff --git a/testsuite/rtsignal-tests/test_rt_signal.c b/testsuite/rtsignal-tests/test_rt_signal.c
new file mode 100644
index 000000000..63ba5c30f
--- /dev/null
+++ b/testsuite/rtsignal-tests/test_rt_signal.c
@@ -0,0 +1,185 @@
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
+static void do_cleanup(void *context)
+{
+	int step = 0;
+	struct ucontext *uc = context;
+
+#ifdef TEST_SEGFAULT
+	step = 11;
+#elif defined(TEST_FPE)
+	step = 2;
+#else
+	step = 2;
+#endif
+
+#ifdef __i386__
+	uc->uc_mcontext.eip += step;
+#else
+	uc->uc_mcontext.rip += step;
+#endif
+}
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
+extern void do_div_by_0(void);
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
+	*((int *)0x73) = 0xDECAFBAD;
+#elif defined(TEST_FPE)
+	// TODO: different instruction sequence for ARM
+	__asm__("xorl %eax, %eax\n\t"
+		"movl %eax, %ecx\n\t"
+		"cltd\n\t"
+		"idivl %ecx");
+#else
+	// TODO: different instruction for ARM
+	__asm__("ud2");
+#endif
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

