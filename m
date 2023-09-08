Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2102.outbound.protection.outlook.com [40.107.14.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891671871
	for <xenomai@lists.linux.dev>; Fri,  8 Sep 2023 10:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcEWJS9FEqMI/POaKyokLT9CJ6E704czjuwddO2sZoVyzREGdUW37oct+lZ+5pXGvEBLTP1sCpiol3/3WowMDEjrij6Tl07KqeRhRqhlZjb+ehxlXJsJYHdZMI4kwGKC4XcLPhHP214CRMhKvuRtR2Qr3udOph9D/Q2ZN82Jnist1vo3mZse0JPKamAKwSKb+QJ/zGc9zKhl0i4MPp0CUnmyILSmv9tOu5LvzRFdBmswphQpoO5tHc+V7y1/Pi8i2CILjl/M/yDAWPBxy4BtaC0ZvEikWVKCTheADt5H9Hr/B3fFz0+G0Ej64BHIUVKv2wWZsrvqP7gMAWLHDpN8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KO63ad2K7o4c/TYWg9JGrdSgDCWzkx3YZzDaHITX84=;
 b=dr5LgUUu06py/kP9wRd1O7bzxEvTkc4jymWXm8bF+FK+Pjsf69GD8GERRbMVkJzFl3jEWWfPjpitGGdRp/IHbRr3Uztes4cq2k3bM9NwMprr6dKH2y3msNS13uJ4r8hPRP+C5FLfSOjRJUIGAQXD7X+d371UWRRZW5bVJimtlI0fA9FAQGCLPETskojOp5WTXNeves7Uds7R1T4Xx7/DF+Oc8wbeWNSK2f5EhoHtKytVWWwOID2n/WQsUL4SdcTeKoDyupFYyNcKjOg2PVz6hKFPxqj6SUmb3wUuiD6kKNGhpmbLNcFHjyV+X6E1UM/HvSyJdGvtM71ZzQ6I/zXbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KO63ad2K7o4c/TYWg9JGrdSgDCWzkx3YZzDaHITX84=;
 b=RnlKGs7ZdiPN/JX9AI0DeQzSAfbN7lGTQvRiiUk1fkOwbhOLKS2qH2Zs56URyGL+eo5BJM/wib4tjqlOovh9ipkxezG7szeT5TDTuWKdVXrySByk1aFuuR52GSOM0ekVg/CP4/QhvmsaYEm7A0BbrI4QPx8BK7XRxoE/tcJ0K74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by PAWPR08MB10059.eurprd08.prod.outlook.com (2603:10a6:102:35d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 10:51:51 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:51:51 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 3/3] [POC] add a tool to measure rt_signal latency
Date: Fri,  8 Sep 2023 12:50:43 +0200
Message-Id: <20230908105043.1355310-3-johannes.kirchmair@sigmatek.at>
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
X-MS-TrafficTypeDiagnostic: VE1PR08MB4909:EE_|PAWPR08MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 01aea804-4b08-4570-2ae8-08dbb0599b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Y7U4wVcuZ1L34QHTAi3krTglo6L8kDWz8h12mEAtfMoMG4fGdHeOdrFIlNHX2vuQtrZ1+UBCUBAc1gNNBwUbhsBIKyYvqhY04K8DbMTMOVi4vxOamB6ICmJGJyDHih6HUAD4q5xScLjiKTjbjFP1xqEqv6kBUaE80Ge6rHuGGqP/FJIm45cfoJt2W5Z+VRcCqwzNwNDuQHa+Q1okJDVqWeLZry5DBAHAveTfpX1Si1yg15KhGhstGbhhA0+aew9i8PP8MyFWkBlMLvUHywHMnEE92q0fuMnVoXh3wljiJHQNfURVu888rO6bHW2h7cTwd4nwmOi6JN+t8IobDAmP1N2DpP5TbxrpMKxfHmmVBvXSAGmPkWUvSc2C9NrY9t6zU6VBiOJIX+i8nxe7ZiCk7cawVawMZXDE0loPytGpjurNPgVm526/Ubv4N3i5nzDMHws5hruus8fqNFycNPW5q0OPBQgQPGDFznYfCARlzriFjpseIy0EmzZjht4OJ6dzgppuOOyL/06fw44MTROs8HqghY2lf3EmiKwwKhA0NApn8223KKAk2D9PtlIQkHlYNHnww0U0cx4LABOQDxNSUcs3F/KP0JUqKeD6fTz4gO6LeImoKz25w2iSxbW8Tqs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39840400004)(346002)(1800799009)(451199024)(186009)(6666004)(6506007)(52116002)(6486002)(86362001)(36756003)(1076003)(38100700002)(107886003)(38350700002)(26005)(83380400001)(6512007)(478600001)(4326008)(8676002)(5660300002)(8936002)(66556008)(316002)(2616005)(6916009)(2906002)(66476007)(41300700001)(66946007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZDv6F0G/pGExeaJC5zX7WbBTgfTH/wApAEWNWiugSPEUVvQd4y2jBbavPXV?=
 =?us-ascii?Q?vPVfZu5NHnWdQsygsIbFbMaS78X8/Lp/G/IY6u1RT07H2f4qSJoVPtyIeftC?=
 =?us-ascii?Q?6XuTp6xbXlRozvkqMAN6Ne5sDOy/GZvxQGLkPUWHxUO1EDnONbcPmc9FQXJX?=
 =?us-ascii?Q?ahhYv5CTKZqadPHcakDmr3Bn8mkzLF64H2Y+ESUu4Luu8HWrdeXGjII1hpJB?=
 =?us-ascii?Q?zlPwywSPMUStKyY7Hp+wneemyQmuOfvGkHtkYT9B1t6bdoOfGLE01gMaUl2M?=
 =?us-ascii?Q?dcpoHIdS7HdHMbaybYjaTwC4cKm3tqrhL/+gSkurn3JMeWUR8u/Ly+jiDpYS?=
 =?us-ascii?Q?zz8c7EWO+lii3vAX+8GSxp7+wwcmGs8Z6t34eWnlvEhqpcFZ5FXk568VZLcL?=
 =?us-ascii?Q?r7sv3X+CvTZhI5YA1aPopSbWQnJ0bY62dS2R8D5yPWGHGDmaOR8ls8ZBXlJP?=
 =?us-ascii?Q?Qo9DEcrFbaLA6/azASzH/1O21hIe+Fgh9ZO5qHdLdvd3W63IXvCMjxqSgxhQ?=
 =?us-ascii?Q?3saM1oDMzQgKXGIu1XVGYRWD073z0HnEtrvN2qb5XmIQAP/Oznr2BB/v/MUN?=
 =?us-ascii?Q?p5prUajiTusOYdeM5uyRQ70wQutesN5F+qgoX07KH2tzQdoYmioeOeR03LpL?=
 =?us-ascii?Q?zA2VvEjNzfahlmBh/9yspx0fVMjZCreH29Hcp3a4Zm+qNgasR++Vcy7RCN+T?=
 =?us-ascii?Q?dPK5Z8M07SkCqbl8fv0LPy4uUSpNe7l0NJpmGiXZkwdRd28zse3fvSgw8wO1?=
 =?us-ascii?Q?HgMkLHR+XmgxJAgY0CeQq1yImWRBk4WGwm7qCMYsQz053vfkORw6V9yfgBeS?=
 =?us-ascii?Q?huM5O2dKLtX5btjfAKSHnB8dJggNfbcwv644ROHDKRyPAOWgw89KQrPF/hPO?=
 =?us-ascii?Q?9I9mCLFQyJrXxJJCRO4tzn+6a1G/CT0zhykCdP31cNG3D7RwfGcZCBMhkFeW?=
 =?us-ascii?Q?o1WSlmyG29d/LVjZ/wO1wbpKXgh3Q0Ls9Dz9CtmNlcXM7POdemyOGHHRWYxA?=
 =?us-ascii?Q?1sMa4URMzfduegR+rWQleEOKCVU+Ho2VoBkZn82bZPApPPI8pNrme53vmuoD?=
 =?us-ascii?Q?IWARYeI+3fuTiSw8q3InK3dAxjuo89I3Ct6/dDisv215x7zKrzQrAbkEVuhg?=
 =?us-ascii?Q?5BJ7wzBazYU5tGwdRTy9RRYa09zIGuZGMuYrXb0ftSKIFW/sZh6GqzUQ5ysl?=
 =?us-ascii?Q?hT32gRCzd57aiSD6x1cAi08UED+3iTSMON25sdNYu5TQeMGZArUobYk40pQO?=
 =?us-ascii?Q?OK4mXosiabxpEXu7CLXDjPg5MZBrI0v2IfwRxFTsvIdAtD4xp7Fb/SM/zV9o?=
 =?us-ascii?Q?OJMiqNT1BCWhNCf2SAZHIWdEn/JPcDO/CTtQjTnXJnRCsWVP1nq4s2z/OE+b?=
 =?us-ascii?Q?JGUXiBU8RTTCMHr3wo46oMgVneJ4ncuBcjDd5DI32nqansY3Z9klFUvur3qr?=
 =?us-ascii?Q?bxpvhVyOiQCQ+pP3LbX9izpOHelG83phB6Drbdl7WwtxG7rwDzAA550FhfgE?=
 =?us-ascii?Q?lfsBgP7LEwARNiOUbGK73lQ2XfyqNVBEUNbPY/VIMotPifEkQ24OvRhbB5Ei?=
 =?us-ascii?Q?2Z8wB6+0Xv49n8N/jbxiTpTtCS5Ry1bB3cUI+gjJqflG9yHortotfJLW2n0J?=
 =?us-ascii?Q?bBQwTGoCo5v1iPv+LDVN0ZQ=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aea804-4b08-4570-2ae8-08dbb0599b40
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:51:51.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOL85Hc/si9JfHGizhC3VBTCLJjeU0sdWM+5sqZjrD6KHcuxJjPvBI09YXAjR0VSM0sfocfvYtafbelcXvFZoNtViBrWq7zZt3uTCSySX04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10059

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

