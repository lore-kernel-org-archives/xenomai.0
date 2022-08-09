Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361E442C
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igBDhJaXv5tRcZjTXWZ1ExzYrtX4tHMP07Q/W0IIqhnLvG/2BCa/JI34+48SutIWxrlairazx6T/O2XIW7OM4ydoclVG/hu4mj4Pioh1O3LFmBwX8Y4VmomjiQuO+pGlJrB3k2m7G+0bLrFxYAAzb4RcThaSljIESoYchCNqDOmlGTo2aUxu6HVT44cZgeuDgPywcsXrYG1Ybn2chlVoygZ/1rBxEfNNdSzSRuLElLadujBA4LBt4SH2+I084KtWlsrnj1DiUn8Zyh7DDMSa67ZawVJ1PVDxfOv/4xOMaMliMHGdRdFy+O27a7NV5oAiIY+uobdhWC0fNqOkQlC+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDUp1Jeh10JUU2HCgIAKhwUM5vyS56BZ2U6nF2fYve4=;
 b=Qqh2Rt218hNNgC56SGcGNR8GFUkHdPYRWkdikrf//ZnJI9hiZA/60r0VwIntg/8n3la8Lp3b2OIe3FIL0eLAchMwJ3VytR7WvYDoSpxjjSE3Swc15sM7Ageqal8XXjAN4fvRJibUSE/+jYwtnxYnNQDFREHAXuPk+DkxprGPfFzFcTHSFvHWU1KEVQ6azCp635d/UPIJF0i4XaOpdIHbXEuAGkrq5vfQkuvwLAdVZWgku18Szk03STwI3qKDBAekWXH5aXPEWmdl0JG9tkM18ptQmwqWutu/IfkLV4gH0fwofle+kssO6uxlq37YSax3CCbrPeUrOo3Rphx+xbOJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDUp1Jeh10JUU2HCgIAKhwUM5vyS56BZ2U6nF2fYve4=;
 b=DJOS1asSlqKeszH9GFcJX2BD8GpzNHlim9z60R1lQAAOBcYvQZu9H39LoJ9PSCFam3J6Gz28HXBgsXrHB5CQuTjLSvJCfoQhIho/Z4ah1gKFaotyKYP3HbuFNRxk56cQHmGeCNxgtZjYDoFGzOEzbaLssOjJlC5+xMPc3HJdnlRh+8Q8ivxyDQVVlQC9UAJ+K08UHQZ3jEKy9UEkQiCmgXsQHbbXA7LuNAIJE4ZhQH5iFRrU6v8To0GRzhiCmVHB0DsIr7Z8Nb1BNvTYs9M+VnJDTYrlL9uAs08o0i5J5H0nu+CT0joMUXo4NJLnTeSMsvnP/Wt5U4MHQgRtnMMkEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:56 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:56 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 42/42] y2038: lib/cobalt: Add additional time64_t related function wrappers
Date: Tue,  9 Aug 2022 15:43:26 +0200
Message-Id: <20220809134326.23688-43-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0189.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::7) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac592d3-197c-42f9-2098-08da7a0d49ac
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nvs47c6lh22ON/xlKjq6Go+S3CUDMoFeUCD4ELo8kPqk7w7RzVyCzynjYdDMdmrG3fkX/bp3S2H5IFay7ftOXrh8dC2YzFNkVL78kAPchQpaKUlx1Gnt6Utl9J8UqmVZMgaMfV5OYuM4jJsy1K5AtmU6aKVdf4ZSyJAsNK+Z/gqSk9BBV3gQCGxk0wb21KiUrjd0EUjTIA/0NfY7yJZkdEZXmJnb7Q363lusSbh+D/YQ/tmOeeyK02Aarll/Sh6YPFiaxT2RPg04zk+tkUpzg+H4CKScLiLtq+HbuJ6gKmajPe02775PmjMYjUf2RlkMkbfoy0ZRjuHUhOvAePhg5mqoxAIENll3YybCyP1Hxt5iN8wg3yVWJoMBkku85FnuAu3/J9jy22SXrWfY6CCOmY7jqkdvjmh/8QcGMSDxGI7J0baSq97wlNtQUnZ1ZZQmaBi3Mw0hzUaAgEBE3MbvSWmJsiJra8NZnd18PnvYrr2cu4h55BBsw/WVJmuFqe6Nw+tApatfWAlVBu487ZZNSle19hH49p+Kn4i0G/KJ3t5gYFcOra22a423wGe1cxO5yQMI1iP8x3isnX4UkUWFwubL1EDTEdkXdWDp/23W2If4mulCl2LwY+i4rTSoOOe4dLU2ayf0cRTZ5koz0yLRuuX0lddwBSP8gO6tVwMOSOa12Sni/juHL4aitmI1rDJWNI/wbC0NiebQw2qxHHa9UvZS0FB2vcqUiDnPDgtlxlE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(55236004)(2616005)(186003)(107886003)(36756003)(38100700002)(44832011)(6666004)(86362001)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjpxdgugAJIb25oVOjr4A0iNq9C6qcvvFJi4UIiJNH4MyhqPf/6SMUsd8vsJ?=
 =?us-ascii?Q?T41P9tPT7vPhUrQnGP/77kuWFQ11IkXkl6MfrGA9H65qJjUxYM70qCp5BWpj?=
 =?us-ascii?Q?Z0/S8sAqXjK2xEZEatOjtNgWpResi14lmDlFrCO+xCpeFCKcQ8/Dy62835T5?=
 =?us-ascii?Q?UR7ETP6nU7y8KkEmLs1hyaP72dGbDbk6JM4zdi2tJPX6ygHkzedAXpMJc+sk?=
 =?us-ascii?Q?jWwZxflW0KYFm4njIiQehqsee5Vrimyq2s5EItCzjEbXaKgaDm4bcNfymhJp?=
 =?us-ascii?Q?yl1YImTg9kgyJg9H9JVQhFd60XehcwikhlM6kR25Z+fCBxanIrWfVE+pLUTQ?=
 =?us-ascii?Q?MxvH2oMdv2E7XgAMq1mGPR5qB+9tCsODdpyVqnhBfSNPv0uhaCsKnaXbG6sE?=
 =?us-ascii?Q?Bqx3PWfkkHOD9kDadRQ0WgXw2uFc6V9MBnwGJqyxYVKRIgHLMXJpo0121hTi?=
 =?us-ascii?Q?gchXyfAbOrEqvsMREpQSP0+38la2v+FPYdbDQgQPG+jJmJ2EJxiBWxXDblII?=
 =?us-ascii?Q?6UuTKicikry+c4RLxjKwyw3amnqkRfXcGchNYrU1i0JdRLHW/ZfMWZ89iFW0?=
 =?us-ascii?Q?fDIwTUJ2yS5ChD/qfgXJVNfgakb+W0aExauEgNzJFZT1COPsbc8hOkw8myUV?=
 =?us-ascii?Q?W2NtKFg/bLmc6sP1whiWIIqW8rLYmEMQ2nklNY5WQRW9yKMfvp4FsK2tf1Jk?=
 =?us-ascii?Q?R+dPKDMQu4WuF4l6SRMGDOprW+lK5nFQL97QEXOiQSu6JPPuNZQfto72jXd8?=
 =?us-ascii?Q?VKk8sjrkTNCiNjzlbqPPCPAre2wnzXsZRyPyOzxojO1tfs+9jxAFKQA3IFmc?=
 =?us-ascii?Q?Vh/zVuOLGeub/cMr+p9h7MEEwRijbJejSqIDTXtuwCMDshPpZNEKh2v9NBuC?=
 =?us-ascii?Q?+ruIeKfL5FZoN3aIjsnP7z3ReuAx8yHp79lcup/64YCyL8hjCWOtgEx0+LhQ?=
 =?us-ascii?Q?qsm9gTXcbstnX6wTj61Nk0xjWTKRYmnDHb2+1rNKbQIApbrW7hxbs/qQVk4P?=
 =?us-ascii?Q?F9RP8c1fUc9JrTbb7iBCG/3VhdiDcK6Z8Umoe2MFd1J4mZqqv56DmuH1XSVB?=
 =?us-ascii?Q?tUMs8MAhKoAuuf7x8T5zwaKgPGNvDtS4YkegDqNUtSCYJLhgAF38ExWjE3mt?=
 =?us-ascii?Q?GYLFc7jBEB1jNRKFBM5Jd/Xt23xwL32pNi2viFU5tRd+qnkDQPL4rliTPU48?=
 =?us-ascii?Q?+T+v21mbwEE7+Dpp1yloEQFyfD3g6cJ3/ObG1VW1h5AEnq7ouUOC4crtpX2m?=
 =?us-ascii?Q?Sab4x63238LinwcVO2yQxJ0AUPeDQTWR9Xso+UvfTIuTeThZsiu97zjOGMLf?=
 =?us-ascii?Q?C4wwaGPOMhsPYfeJeKa4LT/xx8Y6ZNFWoVhKrUOXk7CngxsrCI/UEEvZ/INZ?=
 =?us-ascii?Q?p3Koq56tXVrhY/9h29PlLKAm/DOUf6gax6b2S/jF58+MTgh0Xg7mKwckbNPd?=
 =?us-ascii?Q?5uYDyQkgoFHPlnBVxjaaOTnb5pRQy51wdBrho8ZhWKcFgVCAOUCtFM5wF35u?=
 =?us-ascii?Q?khg9VGpxfbWsrzd/7MNjT7c3q2AXHj1jGoizHdnktoyn+WewzKltcgUgb7Hd?=
 =?us-ascii?Q?NOFm6OXzcGEuH2gkr6Zlz/ojPWdrioGBEg7eXqvVmbhCQ9tS69PudB8VoSky?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac592d3-197c-42f9-2098-08da7a0d49ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:31.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99u24xFgA5bY0CqAiwlmLLQYAzRYU2S45F5E5Mto2KTsK7yWlqOV8fqFUBbyEa2k4HlSCS/ADG8JxdxcCxqQOXOy5DQqb5c6drgGAr4aBPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

When requesting y2038 support from recent glibc versions some
preprocessor magic will happen. clock_nanosleep will be replaced by
__clock_nanosleep_time64 for example.

To fix up the necessary function wrapping that we need on linker level
we have to wrap all the necessary glibc symbols/functions again.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 configure.ac                           |  16 ++-
 lib/cobalt/Makefile.am                 |   7 +
 lib/cobalt/cobalt-y2038-glibc.wrappers |  20 +++
 lib/cobalt/wrappers_y2038.c            | 187 +++++++++++++++++++++++++
 scripts/xeno-config-cobalt.in          |   5 +
 5 files changed, 232 insertions(+), 3 deletions(-)
 create mode 100644 lib/cobalt/cobalt-y2038-glibc.wrappers
 create mode 100644 lib/cobalt/wrappers_y2038.c

diff --git a/configure.ac b/configure.ac
index ce708a00b..2ab662032 100644
--- a/configure.ac
+++ b/configure.ac
@@ -945,17 +945,27 @@ dnl in-tree executables which require POSIX symbol wrapping.
 
    modechk_wrappers="$topdir/lib/cobalt/modechk.wrappers"
    cobalt_wrappers="$topdir/lib/cobalt/cobalt.wrappers"
+   cobalt_wrappers_y2038_glibc="$topdir/lib/cobalt/cobalt-y2038-glibc.wrappers"
+   all_wrappers="$modechk_wrappers $cobalt_wrappers"
+
+   linker_flags="-Wl,@$modechk_wrappers -Wl,@$cobalt_wrappers"
+
+   if [[ "$CONFIG_XENO_LIBS_Y2038" = "yes" ]]; then
+      all_wrappers="$all_wrappers $cobalt_wrappers_y2038_glibc"
+      linker_flags="$linker_flags -Wl,@$cobalt_wrappers_y2038_glibc"
+   fi
+
    if [[ $ac_cv_ld_file_option = yes ]]; then
-	XENO_POSIX_WRAPPERS="-Wl,@$modechk_wrappers -Wl,@$cobalt_wrappers"
+	XENO_POSIX_WRAPPERS="$linker_flags"
    else
-	XENO_POSIX_WRAPPERS=`cat $modechk_wrappers $cobalt_wrappers | \
+	XENO_POSIX_WRAPPERS=`cat $all_wrappers | \
 			while read wrap_option symbol ; do \
 				echo -n "-Wl,$wrap_option,$symbol " ; \
 			done`
    fi
 
    AC_SUBST(XENO_POSIX_WRAPPERS)
-   AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$modechk_wrappers $cobalt_wrappers"])
+   AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$all_wrappers"])
 fi
 
 dnl Multi-library support.
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 3159695b3..2d9a87497 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -38,6 +38,11 @@ libcobalt_la_SOURCES =		\
 	umm.c			\
 	wrappers.c
 
+if CONFIG_XENO_LIBS_Y2038
+libcobalt_la_SOURCES +=         \
+	wrappers_y2038.c
+endif
+
 libcobalt_la_CPPFLAGS =			\
 	@XENO_COBALT_CFLAGS@		\
 	-I$(top_srcdir)/include/cobalt	\
@@ -59,10 +64,12 @@ AM_LIBTOOLFLAGS = --silent
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(libdir)
 	$(INSTALL_DATA) $(srcdir)/cobalt.wrappers $(DESTDIR)$(libdir)
+	$(INSTALL_DATA) $(srcdir)/cobalt-y2038-glibc.wrappers $(DESTDIR)$(libdir)
 	$(INSTALL_DATA) $(srcdir)/modechk.wrappers $(DESTDIR)$(libdir)
 
 uninstall-local:
 	$(RM) $(DESTDIR)$(libdir)/cobalt.wrappers
+	$(RM) $(DESTDIR)$(libdir)/cobalt-y2038-glibc.wrappers
 	$(RM) $(DESTDIR)$(libdir)/modechk.wrappers
 
 EXTRA_DIST = cobalt.wrappers modechk.wrappers
diff --git a/lib/cobalt/cobalt-y2038-glibc.wrappers b/lib/cobalt/cobalt-y2038-glibc.wrappers
new file mode 100644
index 000000000..036bab044
--- /dev/null
+++ b/lib/cobalt/cobalt-y2038-glibc.wrappers
@@ -0,0 +1,20 @@
+--wrap __sem_timedwait64
+--wrap __clock_gettime64
+--wrap __clock_settime64
+--wrap __clock_nanosleep_time64
+--wrap __clock_getres64
+--wrap __clock_adjtime64
+--wrap __pthread_mutex_timedlock64
+--wrap __mq_timedsend_time64
+--wrap __mq_timedreceive_time64
+--wrap __sigtimedwait64
+--wrap __recvmmsg64
+--wrap __pthread_cond_timedwait64
+--wrap __timer_settime64
+--wrap __timer_gettime64
+--wrap __timerfd_settime64
+--wrap __timerfd_gettime64
+--wrap __setsockopt64
+--wrap __getsockopt64
+--wrap __select64
+--wrap __ioctl_time64
diff --git a/lib/cobalt/wrappers_y2038.c b/lib/cobalt/wrappers_y2038.c
new file mode 100644
index 000000000..f42c7830c
--- /dev/null
+++ b/lib/cobalt/wrappers_y2038.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG 2022
+ *
+ * Authors:
+ *  Florian Bezdeka <florian.bezdeka@siemens.com>
+ */
+#include <asm/xenomai/syscall.h>
+#include <cobalt/mqueue.h>
+#include <cobalt/pthread.h>
+#include <cobalt/semaphore.h>
+#include <cobalt/signal.h>
+#include <cobalt/wrappers.h>
+#include <cobalt/sys/ioctl.h>
+#include <cobalt/sys/select.h>
+#include <cobalt/sys/socket.h>
+#include <cobalt/sys/timerfd.h>
+
+#include <errno.h>
+#include <time.h>
+#include <stdarg.h>
+
+COBALT_IMPL(int, __sem_timedwait64,
+	    (sem_t *sem, const struct timespec *abs_timeout))
+{
+	return __WRAP(sem_timedwait(sem, abs_timeout));
+}
+
+COBALT_IMPL(int, __clock_gettime64, (clockid_t clock_id, struct timespec *tp))
+{
+	return __WRAP(clock_gettime(clock_id, tp));
+}
+
+COBALT_IMPL(int, __clock_settime64,
+	    (clockid_t clock_id, const struct timespec *tp))
+{
+	return __WRAP(clock_settime(clock_id, tp));
+}
+
+COBALT_IMPL(int, __clock_nanosleep_time64,
+	    (clockid_t clock_id, int flags, const struct timespec *rqtp,
+	     struct timespec *rmtp))
+{
+	return __WRAP(clock_nanosleep(clock_id, flags, rqtp, rmtp));
+}
+
+COBALT_IMPL(int, __clock_getres64, (clockid_t clock_id, struct timespec *tp))
+{
+	return __WRAP(clock_getres(clock_id, tp));
+}
+
+COBALT_IMPL(int, __clock_adjtime64, (clockid_t clock_id, struct timex *tx))
+{
+	return __WRAP(clock_adjtime(clock_id, tx));
+}
+
+COBALT_IMPL(int, __pthread_mutex_timedlock64,
+	    (pthread_mutex_t *mutex, const struct timespec *to))
+{
+	return __WRAP(pthread_mutex_timedlock(mutex, to));
+}
+
+COBALT_IMPL(int, __mq_timedsend_time64,
+	    (mqd_t q, const char *buffer, size_t len, unsigned int prio,
+	     const struct timespec *timeout))
+{
+	return __WRAP(mq_timedsend(q, buffer, len, prio, timeout));
+}
+
+COBALT_IMPL(ssize_t, __mq_timedreceive_time64,
+	    (mqd_t q, char *__restrict__ buffer, size_t len,
+	     unsigned *__restrict__ prio,
+	     const struct timespec *__restrict__ timeout))
+{
+	return __WRAP(mq_timedreceive(q, buffer, len, prio, timeout));
+}
+
+COBALT_IMPL(int, __sigtimedwait64,
+	    (const sigset_t *set, siginfo_t *si,
+	     const struct timespec *timeout))
+{
+	return __WRAP(sigtimedwait(set, si, timeout));
+}
+
+COBALT_IMPL(int, __recvmmsg64,
+	    (int fd, struct mmsghdr *msgvec, unsigned int vlen,
+	     unsigned int flags, struct timespec *timeout))
+{
+	return __WRAP(recvmmsg(fd, msgvec, vlen, flags, timeout));
+}
+
+COBALT_IMPL(int, __pthread_cond_timedwait64,
+	    (pthread_cond_t *cond, pthread_mutex_t *mutex,
+	     const struct timespec *abstime))
+{
+	return __WRAP(pthread_cond_timedwait(cond, mutex, abstime));
+}
+
+COBALT_IMPL(int, __timer_settime64,
+	    (timer_t timerid, int flags,
+	     const struct itimerspec *__restrict__ value,
+	     struct itimerspec *__restrict__ ovalue))
+{
+	return __WRAP(timer_settime(timerid, flags, value, ovalue));
+}
+
+COBALT_IMPL(int, __timer_gettime64, (timer_t timerid, struct itimerspec *value))
+{
+	return __WRAP(timer_gettime(timerid, value));
+}
+
+COBALT_IMPL(int, __timerfd_settime64,
+	    (int fd, int flags, const struct itimerspec *new_value,
+	     struct itimerspec *old_value))
+{
+	return __WRAP(timerfd_settime(fd, flags, new_value, old_value));
+}
+
+COBALT_IMPL(int, __timerfd_gettime64, (int fd, struct itimerspec *curr_value))
+{
+	return __WRAP(timerfd_gettime(fd, curr_value));
+}
+
+COBALT_IMPL(int, __getsockopt64,
+	    (int fd, int level, int optname, void *optval, socklen_t *optlen))
+{
+	return __WRAP(getsockopt(fd, level, optname, optval, optlen));
+}
+
+COBALT_IMPL(int, __setsockopt64,
+	    (int fd, int level, int optname, const void *optval,
+	     socklen_t optlen))
+{
+	return __WRAP(setsockopt(fd, level, optname, optval, optlen));
+}
+
+COBALT_IMPL(int, __ioctl_time64, (int fd, unsigned int request, ...))
+{
+	va_list ap;
+	void *arg;
+
+	va_start(ap, request);
+	arg = va_arg(ap, void *);
+	va_end(ap);
+
+	return __WRAP(ioctl(fd, request, arg));
+}
+
+/*
+ * The y2038 wrapper for select() is a little different:
+ * There is no y2038 safe syscall for select() itself, but we have pselect()
+ * without signal support.
+ */
+COBALT_IMPL(int, __select64,
+	    (int __nfds, fd_set *__restrict __readfds,
+	     fd_set *__restrict __writefds, fd_set *__restrict __exceptfds,
+	     struct timeval *__restrict __timeout))
+{
+	struct timespec to;
+	int err, oldtype;
+
+	if (__timeout) {
+		to.tv_sec = __timeout->tv_sec;
+		to.tv_nsec = __timeout->tv_usec * 1000;
+	}
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	/*
+	 * Note: No sigmask here, we already reached the limit of 5
+	 * syscall parameters
+	 */
+	err = XENOMAI_SYSCALL5(sc_cobalt_pselect64, __nfds, __readfds,
+			       __writefds, __exceptfds, __timeout ? &to : NULL);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (err == -EADV || err == -EPERM || err == -ENOSYS)
+		return __STD(select(__nfds, __readfds, __writefds, __exceptfds,
+				    __timeout));
+
+	if (err >= 0)
+		return err;
+
+	errno = -err;
+	return -1;
+}
diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index a093779b9..ccbc17ccf 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -20,6 +20,7 @@ XENO_COBALT_LDFLAGS="-L${staging}${libdir} -lcobalt"
 XENO_POSIX_LDFLAGS="-lpthread -lrt @XENO_USER_APP_LDFLAGS@"
 XENO_LIBRARY_DIR="${staging}${libdir}"
 LD_FILE_OPTION="@LD_FILE_OPTION@"
+CONFIG_XENO_LIBS_Y2038="@CONFIG_XENO_LIBS_Y2038@"
 
 unset skin_list compat codegen
 
@@ -252,6 +253,10 @@ if test x$do_ldflags = xy; then
 	case "$skin" in
 	    posix|rtdm)
 		ldflags="`dump_wrappers cobalt.wrappers` $ldflags"
+
+		if test "$CONFIG_XENO_LIBS_Y2038" = "yes"; then
+			ldflags="$(dump_wrappers cobalt-y2038-glibc.wrappers) $ldflags"
+		fi
 		;;
 	    cobalt)
 		# do NOT wrap POSIX symbols in application code with
-- 
2.37.1

