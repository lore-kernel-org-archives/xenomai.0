Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2102.outbound.protection.outlook.com [40.107.241.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AE182BC
	for <xenomai@lists.linux.dev>; Tue,  9 May 2023 13:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxD7J8hHze5uT146tYucdmaDFFdcSMNInDF0l+dA6yv3M2VAicSBFvw8pXtL1Z6JT70BNXk0w5p425Ci3DzhP2ROLlv+bx+V0aWri+qQxJBNcFqSUSlSdY9qcqKBS71kzOuJ6XCoJPpaQJHUKlH3zc57aAc0CxcvTg2MRKcqlQbdT4HCCfqJXtnOXyuAZTcnKeL60PjOANcPJ023JuRnW6aKCUcaYtufaJtTfeHNfrgYfjvBWxHJEtGzZwDcp/5Qo1UcwPExg3wzZkolBDxUvpPD3DAYqkMKXTVFGzwyJmF/f0yVAr7ASIrgqAVhFg8yXs7/jJ+rS3l761n2zsNERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KO63ad2K7o4c/TYWg9JGrdSgDCWzkx3YZzDaHITX84=;
 b=OTENTnMUU3fu/AXUQkAZvPdfM5DzTUOGFB4m7Mf8DE1E31Q6eR9E3PrT5qhSMNDClxS6XogkaOkZWKlKQ1xtve61appshfrNG1gK+EKG5C3ehw+AFFC+k9+GwrSLfYF2WpFbvp1fR5cZT5Xj14q4OdtjclromXgZT2qWM/8CT/2Ioui96t9qXczjB/QUBiV9gDNzgtuv1TGGrWQNiSj1Kb8UAEMgVlIwOmpxfRqsA2VCngTV7UeSafDJJ36x5xzQ16njieuy6Fi6WDoyu4n7pXPXEqCElpmXuLmqQiBg/vNh+5VyeQ26AFrKweNMqR47uMJ3nm5+Z7f4b5WSSMIE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KO63ad2K7o4c/TYWg9JGrdSgDCWzkx3YZzDaHITX84=;
 b=gc44GG8ESE4FXoO4bnauSOQ9MPpvSme/wjBZ5UiXRgbexERIA9GZQMS4sZu5MR6B16CUviqs4GaqwKMQQW1/9RAUdy6voKmdBCoITsRS4Ey+eyPqX3COsCubjg/m3wlkDYP4XJbguO9+CKGKTOXnet4E2Co7qe1buv/Pfbj/9Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS8PR08MB8442.eurprd08.prod.outlook.com (2603:10a6:20b:568::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:14:43 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:14:43 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: johannes.kirchmair@sigmatek.at
Subject: [PATCH 3/3] [POC] add a tool to measure rt_signal latency
Date: Tue,  9 May 2023 15:13:55 +0200
Message-Id: <20230509131355.3003275-3-johannes.kirchmair@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: 53f29b95-8a64-46e4-c43c-08db508f5a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9i9twPJMxHBnO0K5B1mAeA9Y+hBfHsc88r71fn8kSOTd+PQPfZUtcRNAekR/QOh83X3weLUw6PyXTXSO5cfcJf7mjwrnXlE7KoF1gYBaAs6j0vfAdNBo4gaFGnqOUj25r8tSVzEogTrQmq0qDDVfyszTpglJGiBINy367v/SRgdLrJvB0K/Y20X1rhD96rbrv6iy2QPa/LFZDc0yxkfJnrPcV3gckGwthyCras01Lg1Zy6jfEDjSyQu+FNr9/HxyO6OleN5Z7alOkCkwwYrTmpnW732xSa4cKwarupWiO0sMI3hZ2o46ntjJGf66Gl6283HDxl1tlv705wvUMrmsbuuTBTNkR7ZmsLYiKrNkfoEz6Tol03Xx50eSaMhVaHYfEEn3PVTNcBKKsY56SF8UuIMHkwuV0weKdfPiW4A2RUURZ39NSdnkGQj60tY2/Oglv7VOu7Jp86bWrNk1X+cwZsaOI70Ta9H689TGdpfSddBkbztVlotcqAfCxc/hcf4DfAtKA+vYvY5bDkZT4Bh7SWZhg3StkFDQ0AgAXl33eujaz5S0mIRIW3QL0BGMi40tkCVPMhrV0sZMbm2fMmmP61LTJ/u1aYJt3eOagzEflcVkBtireRJA0zSGkQllbJMW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199021)(8676002)(44832011)(8936002)(5660300002)(41300700001)(316002)(6916009)(4326008)(83380400001)(107886003)(2906002)(86362001)(66946007)(66476007)(66556008)(26005)(1076003)(36756003)(186003)(52116002)(6486002)(6666004)(478600001)(38350700002)(38100700002)(2616005)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVRU6YENb/7hPK8ujtsn4wRre7V+XA+yv1Zq3EHr1nJXC4mnumqIbhUeNcq2?=
 =?us-ascii?Q?gE2lbKcJetaTTeZavJzDY08BNt603phqaOwwezITrDp2/AvoFy8Sndp6h8yj?=
 =?us-ascii?Q?ykqk0tx7PI3iEUinWvpU10Ag25NLBIMc9SAEk3KXFzUK9SYsc6Qy9DK4kl2c?=
 =?us-ascii?Q?oVFvTgppwxUg04r1WmavUnG6gBjkujfGG3uK2nER8j1i0FGDwATbcEQwDwks?=
 =?us-ascii?Q?s4zsqJGoEjmv39Zu9l61x4DrJeBgvWpnJqnPGbFDZXzP3y61csGMtRuTHSlj?=
 =?us-ascii?Q?lASRai44x1KrlvtDXL8IyoJw/+od5bdh5DQPkQHUJum4dbxDqcXGFxGVFTKX?=
 =?us-ascii?Q?S2NakJalGz6mJK12d7TpAympKkUqucfzyIGoTt9U9IbVMaE/Swau6Gagxq/f?=
 =?us-ascii?Q?GOAsikFaU9YCd+Grfc9L9U7uneBj8XiQuxvmsLaZ933vMM72bfwe4asBY/hT?=
 =?us-ascii?Q?bu3KVmxe4grufslS3dJ30IPPZkjM25UScb9z5N9e3LJ8Nqi2iQSGHApnOCsA?=
 =?us-ascii?Q?iE9Ces3AoCqL3LPOcNooM70RddHM4MbGuLaALwDd8KV6hjGZ8KUy/sAP50mo?=
 =?us-ascii?Q?VBTodCzNq5T3jYKdj8CA7/f1abylm0fj1wwuXlPvgWIb81MLEZL/IdVJoU2G?=
 =?us-ascii?Q?VhKBuOiGaPJnM0MFnrnfkcGUDqCxz6y4dpZtwA0w2h8OYxvyDYAnYIGfuKe7?=
 =?us-ascii?Q?iOnM5J1XGVD5VdTmRc6EhPLkkEIRX0zZWAuicL3T14hRg7u0/8Qbq3B/ZFA1?=
 =?us-ascii?Q?yyO0D+xQkNZHThzhpYK4d7mP45TztBLCvDFbk4SeRurVxC4JtiC9t9/YG7op?=
 =?us-ascii?Q?Q4QwpOuGZD4PwRp6xQMbj47EOIfESeNaYQMpzD0Xmb8bpknW8wXZmc8Ix98h?=
 =?us-ascii?Q?Fc7pzcKqhBLiOBqmdCQp0hGtQ5twaIi3CTfXh/AZ0HEGCgvGHr7Kh4St66xw?=
 =?us-ascii?Q?jyb/lez5HJi5JHqrESBFrUVKxXX/yIcasIzuVOZ2k9FnY1kfiV+VGv/rKq17?=
 =?us-ascii?Q?RQeQfNISIRMMhb7dhArE1M27oBlLpd2tGnmul4PiSgHrzReJPljSdiswFeuG?=
 =?us-ascii?Q?CV9ujJNeAKlRZW/mnDY4YvMqAZ3WvTnjq2Q8YxlnM1TTIVkaCo1HulsTQGEn?=
 =?us-ascii?Q?EE20FCXyJNgLCh1lNfqL9lqnqvh6LrYujHSVQCOLCzI0drJW1EPblaCtu5fp?=
 =?us-ascii?Q?OwWpFmWC1fvAjfiK3zniD2JXkxC/j93uLHdEQXsPwtqYVJ4SPRn9STFFP4Gk?=
 =?us-ascii?Q?qvgduNihcKnF7E7BAuKK+xL1gV0v+7gSD3eAYHxl4s8SvOVWrRG7KpZJUGjX?=
 =?us-ascii?Q?b8iAREFkiChpEHm3vVfsVpNUidjjf3RUbq2XoxrpPvNW3uqHpDOnhx+wOiXW?=
 =?us-ascii?Q?W4v7eJnOmIVC5uvhlniAJdvBEtiZrnq0iwtW/wQKtykatYl49dP/XC18dXQS?=
 =?us-ascii?Q?zb4jUwnxSi09P7Ng0hnyW3+wtqeDL/iPMQlLjuXm7SeNP7X1P89WN+yajFo8?=
 =?us-ascii?Q?Dvq1oTSNRIof8H8FRkqNGFuxlpACZF66EkhAcUgj+g/VBNyK3O2Hu3jzWA+z?=
 =?us-ascii?Q?3WV67Z8iB45xXkP5Kv1w3YYoUs2w+wNoedcXZzZXjQq87pC2w9db6MiZMxyM?=
 =?us-ascii?Q?NAhX4oThVLcaTP8ExY6Kgpc=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f29b95-8a64-46e4-c43c-08db508f5a52
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:14:43.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTAhcP5jVEEpz//h6R6t69XltVF/HNMbMqriRDld9pXWigtQ8urBA3EKHx7BynGYm4JV0XwbD82u9peQx82psQJsuSBu5p1bMWUDSXzJH2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8442

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

