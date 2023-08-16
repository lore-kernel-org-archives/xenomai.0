Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2136.outbound.protection.outlook.com [40.107.241.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE142D2EE
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 10:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+36BIdi9/Tf6ytQ0WHkP7n3b5f/ASH4AsGt2jGz/7Pah4bDCEVP/XPuzfgYeSYOyaciqZp5hpo0/A+Tgj9Xw8jN1VtChLl7KkQQ0PgNb1T9nrFOpbs3gcJS5jMspiGrt39fjhjqIXwfEDRvBWSm1UcmJZLN9mhkWZ6yPLapfYtPh6Ve6htwYiC7TZkgnp0JcU5FUpzVQNcbePvyEv12/1eU0osIUOrJ8Gwv4gRLfXuBWlCodEx7vw9ZNrQ+vRtCfMD9MnLDcVFS9zv4SNTxeOCRH8Wsks05e/vXgekIxOfvJu5Oj7SOuZ918ql87v7A1xJNSfc9WDRIv4ww1gvAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KO63ad2K7o4c/TYWg9JGrdSgDCWzkx3YZzDaHITX84=;
 b=XzGQoupDjqFr7xKPVxnt0fhGYBuOEM4cXYkPeRCOF3+Yy1eWg4S8B9/NedKEseFKpgAMi+5Afotua07rhxScs2z4iTNgriqpBtzvkz1Ku9C94X+qOwyPgPdvHyr049XVFOE+//38GvTb2PFs6BWQf4WbIpkoKDZK2NqwBgAziYKZLuzsCeUmq85SDeW3I92vJrKJtfl1xktrIpcU7nlSpdnfo9H4MsAGlqL9Ryk2fWyRFgNRAVbMC1eTKs73ZNh7HkOe2RQE/yAxBRrO05y1/8AXnrz5vwtIC72ENwEHbuBOET1hCEB/xmKtbBslAEUDyO7/rh+A2Q6E1QJwlwCVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KO63ad2K7o4c/TYWg9JGrdSgDCWzkx3YZzDaHITX84=;
 b=i5fDbrx38A5EaWAFW0hJbKIGcyBOpICCFtcgLUliCRznXYaCOraANW7ra0g+okmf6gE6nMma7+Rl/P1LnGNGDdKgDZYy2khZ+7htZHnsqNzZqT+Rdbwh3RPPl2Grbha3umIZqkiOUpxuYWcszn9Sj7Z6EO+kkFKX3EGlaKQXMEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:19:53 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470%7]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 10:19:53 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 3/3] [POC] add a tool to measure rt_signal latency
Date: Wed, 16 Aug 2023 12:18:42 +0200
Message-Id: <20230816101842.3377643-3-johannes.kirchmair@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: c14bd670-2421-43c8-f1e5-08db9e4254e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	stOVjBALHtiGHz5ZPJw3VD1LBatUFIYIIWL+Hx7cgSm5S/UqsSBaFRgerMINDRBljvc5B8LH15knrNPq3N7R7/NFTaBk9Krb4xvTQMvqdi4A54Em6RvyWCILgKvrRo8oE3bY8g/V8JIxuqjN1YpkftbJ+NbyVoviQxkwCn9DEKo/ftVg5+eWFvKA+N4IRPELhrpmBgOwBiVJWVWmT8n2so4PPbO3bopJU8oj/LDRasZ5hfEgltiq52ogVdDDFO/fD6D6j5oAdLpyhDj/mfehxciLIxzNw8GXVXksiL4NX+T1PMqKJrr96vKgZA85soCpOsjg5BcsKB4Q5vyunIAyuWyHG1wYRkQ61JfQhINgPZFA57TzesHYgAt/NgwdOC7hoigrFmPzRqRtBMbC9edqzQAL0uoMS0MjtRIoYccnAEx6ioHySKw9Uges99rYid9jwxxUwWgTnCblG4kpnnnPxfMa/TxfvghFbNem1pxlAgpf7kcOo3g3gZBaLhly1wiMGQsMa5vhAWyDFvPGVSNynMkOhti6d0/ybzNc2xQZhB6jrhpPeqfPXxe+1FDeK4Np2TKpNnIL1DbaYb7FJgAVUAZilKtd1BUYLvy8MLwCBBoNFyQBm8YFl8W6B5bDIE2K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39840400004)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(6666004)(1076003)(107886003)(52116002)(6512007)(26005)(5660300002)(44832011)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GO84AF2LOut20PYLZZaXsrtnwo86bXT29MTg7mvqc9IDF/GcZWc2c0UKX46/?=
 =?us-ascii?Q?uO6h5pczfH7JhLsLhvUTOlR+Ug5aCASfdLz9uZy3cishw7X9/Fpvyt9Klfgt?=
 =?us-ascii?Q?n42GYsN4F/LdDjC51bQ66ZeghI8i2LW6DcMVZ+VK4Z7P7KwMTIbBJFNwwBO+?=
 =?us-ascii?Q?hyd4Do0szLKyRl+oHtU9x7OqPV8H8bqzOBKYTvmfwYmuljBSoNW3QTofstXJ?=
 =?us-ascii?Q?L1Pzs5ZpsMg6iwnCLAHkwJN6ad8xA9yFMqpDuYOUJbmaQeAl2/YMBHuzR/L4?=
 =?us-ascii?Q?/rs1+K/oZ+mRF4u1pmWM0OzNN748UGe+cKbkg/ywUVfWHuIFSwaEpAPFoB+X?=
 =?us-ascii?Q?Mh/2FjUl/7CoMe1kOcYqBy3skJWhFN+Hz9OX9VfdyOQsaTJdBeIcmFpeHhLJ?=
 =?us-ascii?Q?Sa1t2uDip4PblrdaRCxaOpDBIn1h1LKHu87xqBho10u2T6+UvWXGaeQLYZuC?=
 =?us-ascii?Q?tJVliRmfJcuWEakwLm4m0qJ0uxRFNAj3m6TgNuFKtQ9a0qBDnKxkgk5mMIr0?=
 =?us-ascii?Q?LYGumpdj6jyzq5frJMJHsNP8RdPJKzqnUHpEfyVDai11itL7OkS3iFysLk4Y?=
 =?us-ascii?Q?qokkQYPwXPsOlveZBH08vEERWbIR8JNM3qtvxbsKH7lkJ5++i8eVJsZQN58k?=
 =?us-ascii?Q?PUuPSIwwR3+y5SZRs4NoeeVryFSyBFzzMVKjs39Sk4FuEG22cqz6S+bsw33L?=
 =?us-ascii?Q?wsHII7qyTJSxwOq25mYtX8eByp+qiPtiAfQX/unj2/t+VCnM6shBpCH8Et0C?=
 =?us-ascii?Q?HAGSRoJCZaQ1d748rXjMlUW2cyAhm+kkNHnPsqi9jRDZl7Stky8QISum7yDF?=
 =?us-ascii?Q?askwcMTuROA2IRqHVOVbS6y4Nj767J0IGzW07Dud/dvTtNz23OL6GPVCzJ6h?=
 =?us-ascii?Q?0i1SHYv6lqE+P6zk9GUGW5crG2wcJIx4EzIQ2W5MPKrDIHLq1mtB9FKWSMw2?=
 =?us-ascii?Q?wzO7dJM2GXMI0R6ryz7bu9ICyLFjQj6FrCJ59a7m1kdA2nJKcyORxsiAvMvQ?=
 =?us-ascii?Q?CQM39zzD2yizU7gQUWYe4TW5Q7SCh5O0XDdJ8tDACtUaEKAmDRXg9DvRYfSz?=
 =?us-ascii?Q?/Fx6bJRN0lvDWswQoEc/M7uWWZScNl6qKymx4HXuCXfpDFNexPLbn459BAKM?=
 =?us-ascii?Q?EuUL/u1DcnFM6JaNBst6YsZmMwmszwDBKhVbtVKGSEfal5/XXpw8V1eKKUi1?=
 =?us-ascii?Q?WnrjPIUwDp7IdQTRrMBGKDPEd9MoCNO6rqn13ZiRTuOyiY3TYummT3fgZIUY?=
 =?us-ascii?Q?uf88ZAZVcVu3t+e4kZLpRaGnGJCV4B9630hy4V0C6bDjJxzNgM4MEMl14uch?=
 =?us-ascii?Q?sFsvberYpV3jdzEMSghRLwNXo/HD9WcPhebyXNm/HhaPXpKY41lEFVFhIZYE?=
 =?us-ascii?Q?DaJMfXuLy3coBjO1Uq45aLkxasW66OR7HggjhvvoWa9DxktZCBpkToe4Pzh3?=
 =?us-ascii?Q?ST+mTnAoZ/LPzG23wv4Qv0sGUhHNzMh6s3lqDQqCFarD7QRYaSTLwKfXpZDo?=
 =?us-ascii?Q?ZtsLchyk2H1+5L7c6ddIcBDcEX0a/DZIUDmLaVR1+PCtVuO8cd8f9372pSQz?=
 =?us-ascii?Q?PAGPtGuNTuWNJOJnMyiye+/Wz8cjHBJNJxuotrc+UPeJK5vnSsWGkO1m6SIY?=
 =?us-ascii?Q?8yjh8qxO6QoMf3JWt4N7NXs=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: c14bd670-2421-43c8-f1e5-08db9e4254e5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:19:53.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TERs++E12TXV5LGOMgmT10c0T+Z2F8eK8IdbXm1gXWVQFgbXndPO8q7CD6qpZMZX0C8LjYJ37aXi9aD2Blq5je33jAsRgvmLImMPQa89Wk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496

Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
---
 configure.ac                          |   1 +
 utils/Makefile.am                     |   2 +-
 utils/rt_signal_hist/Makefile.am      |  22 ++++
 utils/rt_signal_hist/error.h          |  14 +++
 utils/rt_signal_hist/histo.c          |  46 ++++++++
 utils/rt_signal_hist/histo.h          |  13 +++
 utils/rt_signal_hist/result.c         |  16 +++
 utils/rt_signal_hist/result.h         |  12 ++
 utils/rt_signal_hist/rt_signal_hist.c | 158 ++++++++++++++++++++++++++
 9 files changed, 283 insertions(+), 1 deletion(-)
 create mode 100644 utils/rt_signal_hist/Makefile.am
 create mode 100644 utils/rt_signal_hist/error.h
 create mode 100644 utils/rt_signal_hist/histo.c
 create mode 100644 utils/rt_signal_hist/histo.h
 create mode 100644 utils/rt_signal_hist/result.c
 create mode 100644 utils/rt_signal_hist/result.h
 create mode 100644 utils/rt_signal_hist/rt_signal_hist.c

diff --git a/configure.ac b/configure.ac
index 3325482fc..fe4a3b3e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1054,6 +1054,7 @@ AC_CONFIG_FILES([ \
 	utils/slackspot/Makefile \
 	utils/corectl/Makefile \
 	utils/autotune/Makefile \
+	utils/rt_signal_hist/Makefile \
 	utils/net/rtnet \
 	utils/net/rtnet.conf \
 	utils/net/Makefile \
diff --git a/utils/Makefile.am b/utils/Makefile.am
index 4de6434a9..79c39ac90 100644
--- a/utils/Makefile.am
+++ b/utils/Makefile.am
@@ -1,5 +1,5 @@
 SUBDIRS = hdb
 if XENO_COBALT
-SUBDIRS += analogy autotune can net ps slackspot corectl
+SUBDIRS += analogy autotune can net ps slackspot corectl rt_signal_hist
 endif
 SUBDIRS += chkkconf
diff --git a/utils/rt_signal_hist/Makefile.am b/utils/rt_signal_hist/Makefile.am
new file mode 100644
index 000000000..810a63bba
--- /dev/null
+++ b/utils/rt_signal_hist/Makefile.am
@@ -0,0 +1,22 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = rt_signal_hist
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
+rt_signal_hist_SOURCES = rt_signal_hist.c histo.c result.c
+rt_signal_hist_CPPFLAGS = $(alchemycppflags)
+rt_signal_hist_LDADD = $(alchemyldadd)
diff --git a/utils/rt_signal_hist/error.h b/utils/rt_signal_hist/error.h
new file mode 100644
index 000000000..4aa50e70e
--- /dev/null
+++ b/utils/rt_signal_hist/error.h
@@ -0,0 +1,14 @@
+#ifndef ERROR_EXIT_H
+#define ERROR_EXIT_H
+
+#include <stdio.h>
+#include <stdlib.h>
+
+static int error(char *reason, int ret)
+{
+	printf("%s: err= %d\n", reason, ret);
+	exit(1);
+}
+
+#endif
+
diff --git a/utils/rt_signal_hist/histo.c b/utils/rt_signal_hist/histo.c
new file mode 100644
index 000000000..36e51201b
--- /dev/null
+++ b/utils/rt_signal_hist/histo.c
@@ -0,0 +1,46 @@
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "histo.h"
+#include "error.h"
+
+void initHisto(struct histo **histo, unsigned long n)
+{
+	int i = 0;
+	*histo = malloc(sizeof(struct histo) + n * sizeof(unsigned long));
+	if (!histo)
+		return;
+
+	for (i = 0; i < n; ++i) {
+		(*histo)->data[i] = 0;
+	}
+	(*histo)->max_index = 0;
+	(*histo)->n = n;
+}
+
+void writeHisto(struct histo *histo)
+{
+	unsigned long i;
+	FILE *f = fopen("hist.txt", "w");
+	if (!f)
+		error("can't open \"hist.txt\n", errno);
+
+	for (i = 0; i <= histo->max_index; ++i) {
+		fprintf(f, "%lu %lu\n", i, histo->data[i]);
+	}
+
+	fclose(f);
+}
+
+void updateHisto(struct histo *histo, unsigned long curr)
+{
+	unsigned long index;
+
+	index = curr;
+	index = index >= histo->n ? histo->n - 1 : index;
+
+	histo->max_index = histo->max_index >= index ? histo->max_index : index;
+	histo->data[index]++;
+}
+
diff --git a/utils/rt_signal_hist/histo.h b/utils/rt_signal_hist/histo.h
new file mode 100644
index 000000000..63c92014a
--- /dev/null
+++ b/utils/rt_signal_hist/histo.h
@@ -0,0 +1,13 @@
+#ifndef HISTO_H
+#define HISTO_H
+
+struct histo {
+	unsigned long n;
+	unsigned long max_index;
+	unsigned long data[];
+};
+
+void initHisto(struct histo **histo, unsigned long n);
+void writeHisto(struct histo *histo);
+void updateHisto(struct histo *histo, unsigned long curr);
+#endif
diff --git a/utils/rt_signal_hist/result.c b/utils/rt_signal_hist/result.c
new file mode 100644
index 000000000..a863d7182
--- /dev/null
+++ b/utils/rt_signal_hist/result.c
@@ -0,0 +1,16 @@
+#include "result.h"
+
+void initResult(struct result *resu)
+{
+	resu->min = (unsigned long)-1l;
+	resu->max = 0ul;
+	resu->avr = 0ul;
+}
+
+void updateResult(struct result *resu, unsigned long curr, unsigned long ith_entry)
+{
+	resu->min = curr < resu->min ? curr: resu->min;
+	resu->max = curr > resu->max ? curr: resu->max;
+	resu->avr = (resu->avr *(ith_entry - 1) + curr) / ith_entry;
+}
+
diff --git a/utils/rt_signal_hist/result.h b/utils/rt_signal_hist/result.h
new file mode 100644
index 000000000..9895535ee
--- /dev/null
+++ b/utils/rt_signal_hist/result.h
@@ -0,0 +1,12 @@
+#ifndef RESULT_H
+#define RESULT_H
+
+struct result {
+	unsigned long min;
+	unsigned long max;
+	unsigned long avr;
+};
+
+void initResult(struct result *resu);
+void updateResult(struct result *resu, unsigned long curr, unsigned long ith_entry);
+#endif
diff --git a/utils/rt_signal_hist/rt_signal_hist.c b/utils/rt_signal_hist/rt_signal_hist.c
new file mode 100644
index 000000000..076084e9e
--- /dev/null
+++ b/utils/rt_signal_hist/rt_signal_hist.c
@@ -0,0 +1,158 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <stdio.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include <asm/ucontext.h>
+
+#include <alchemy/task.h>
+#include <cobalt/signal.h>
+#include <copperplate/clockobj.h>
+
+#include "histo.h"
+#include "result.h"
+#include "error.h"
+
+#define TEST_SIGNAL SIGILL
+#define USE_GETTIME 0
+#define USE_RT_SIGNALS 1
+
+static RT_TASK task;
+
+static void do_cleanup(void *context)
+{
+	struct ucontext *uc = context;
+
+#if defined(__i386__)
+	uc->uc_mcontext.eip += 2;
+#elif defined(__x86_64__)
+	uc->uc_mcontext.rip += 2;
+#else
+	uc->uc_mcontext.pc += 4;
+#endif
+}
+
+static void sighandler(int sig, siginfo_t *info, void *data)
+{
+	do_cleanup(data);
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
+static void registerSignal(void)
+{
+	int ret;
+
+	ret = cobalt_rt_signal(TEST_SIGNAL, sighandler);
+	if (ret)
+		error("cobalt_rt_signal", ret);
+}
+
+static void printPreRunInfo(void)
+{
+	if (USE_GETTIME) {
+		struct timespec time;
+		clock_getres(CLOCK_MONOTONIC_RAW, &time);
+		printf("res_sec = %ld res_nsec = %ld \n", time.tv_sec, time.tv_nsec);
+	} else {
+		printf("res_nsec = %lld\n", clockobj_tsc_to_ns(1));
+	}
+}
+
+static inline unsigned long ns_now(void)
+{
+	if (USE_GETTIME) {
+		struct timespec time;
+		clock_gettime(CLOCK_MONOTONIC_RAW, &time);
+		return time.tv_nsec;
+	} else {
+		ticks_t ticks;
+		ticks = clockobj_get_tsc();
+		return clockobj_tsc_to_ns(ticks);
+	}
+}
+
+static void task_func(void *cookie)
+{
+	struct histo *histo = (struct histo *)cookie;
+	struct result resu;
+
+	unsigned long start, stop, curr;
+	int i, j;
+
+	printPreRunInfo();
+
+	registerSignal();
+
+	initResult(&resu);
+
+	for (j = 0; j < 10000; ++j) {
+		for (i = 0; i < 1000; ++i) {
+
+			start = ns_now();
+			do_ill();
+			stop = ns_now();
+
+			if (stop <= start) { // dismiss on counter overrun
+				continue;
+			}
+
+			curr = stop - start;
+
+			updateResult(&resu, curr, i+1); // + 1 as we add with index i the (i+1)th entry
+
+			updateHisto(histo, curr);
+		}
+
+		printf("min = %lu max = %lu avr = %lu\n", resu.min, resu.max, resu.avr);
+		rt_task_sleep(1000000);
+	}
+}
+
+static const char *task_name = "signal_test_task";
+static const int prio = 80;
+
+int main(int argc, char **argv)
+{
+	int ret;
+	struct histo *histo;
+
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = sighandler;
+	sa.sa_flags = SA_SIGINFO | SA_NODEFER;
+	sigaction(TEST_SIGNAL, &sa, NULL);
+
+	initHisto(&histo, 100000000);
+	if (!histo)
+		error("could not init histo", -ENOMEM);
+
+	ret = rt_task_create(&task, task_name, 0, prio, T_JOINABLE);
+	if (ret)
+		error("rt_task_create", ret);
+
+	ret = rt_task_start(&task, task_func, histo);
+	if (ret)
+		error("cant start task", ret);
+
+	rt_task_join(&task);
+	rt_task_delete(&task);
+
+	writeHisto(histo);
+
+	return 0;
+}
+
-- 
2.25.1

