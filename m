Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802126FA42
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115320; cv=fail; b=mVhKoo2rUMnpYkPgMwEvVij0Myv8bUZ3AmrKmXzfqBKY86/KdjVZoBQ+INT+9CvDDWBrnZMpbPRZfY92Apr+CuFYtMfTL7nVS4cc5TVZTO5jeXbKjcSlOOBDWmxqTJrvjwM4OIo6XOk0j910VlW5CeR2apecP8kUF4lN1VpbDbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115320; c=relaxed/simple;
	bh=bfTWabjIwY2SxFZ84JPbfUYJi14/aeiJFTitEiN7i8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ab0zNAtO85vIfHtTIKlcnf+2YbA/d9JOu6t7tKZNJgzYJ/YQMo3y88KJRK7uLaFrzAZop0zjdpH54u+3QkkhcXn/tEH9RX1DpR6KItNtuqHDRPAQuiZupaPz2bGGGnfAbs9ymNUOtwJOUrnrqVcAnxo6znocRYmrOd9dOMto8fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=V1PXa5Iw; arc=fail smtp.client-ip=40.107.22.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="V1PXa5Iw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmW8h67YSPPQsKmlGVElCqbrDL5nCgFyH4197053mvoRD99L/bQWjrmarNIlgysSK/nJGqxxrAEjbAba35oKrMSf29UT7XFsnbiC4RjdVbuSvqDgdEtNrBQcUeQAmpmUFKSyFr9VelJ3yigvJcsbI9vcUE3UGvCNkE0eLYSN5xWquMbgi8vlSpXsqfOIpXv0AUaGR4CczNjMvK2plDVm5aOUmJpyeRDoKw2iJPE8blS+l51pSRyvIRNfSsCAxmCOaBbFSsSGE9D/MuY1aLtieur1MHY2JYHrz8zH9e1fGdo3d+sPuSTTB62840Bk9RGe7PZgexVRbGfqYQRMjg2Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDhyh/R4kJSPbsTWS/3/FLmsT06SIALNNrznnsziwNg=;
 b=C0+3NtMRaUxu9Ja/gKDDO4jYU0l4C9mK6O+pLJlEao3QUnaRwwzw/F8eP/oEQ4VHPrKv2UYS3Y8BMAgstxW1deBTt/+mpIXLjw+4rB5gh9q4D9YFvs9onShWHDxD2DVjJsri2r6AcnHlYjNA0jHRDrEb17HWBPs/Rba0ZnCx9dpynlRO88LsaxM0sgHEFEqZdgwqW5RGcvdoD2+DkB2Gqt6oZD2XEizkwBAGYDoFW1R8nBv0OMnWQ77yDXx/Mtvt0OytZApxEZ5yIWk9peu/Pze6MTADSLnyvvNbnhQuiqXUNEQYUaBZpfZPvC0+rjRgNjOSm/NeLAfduGQLRW0zeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDhyh/R4kJSPbsTWS/3/FLmsT06SIALNNrznnsziwNg=;
 b=V1PXa5Iw4hVqaEpYQ6qkqIdJS3VJCX7itdasZg4Zx7rLGsSTKCoE9AWmVI7CZ5XYKBclntOqTU6zcOXwYVd2DUO+M7AmToLPU4ddNI2GKFLBv/YEhXperKf4ItYCXMsHmttQ8hoiyO6nnoBXwkmXuhnyVjm1NkB+CY/E8gGY4qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by AS8PR08MB6424.eurprd08.prod.outlook.com (2603:10a6:20b:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Tue, 8 Apr
 2025 12:28:26 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:28:26 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Lorenz Kofler <lorenz@sigma-star.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 4/6] cobalt: Add signal core code
Date: Tue,  8 Apr 2025 14:28:15 +0200
Message-ID: <20250408122817.626897-5-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
References: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|AS8PR08MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1cbff9-4234-4fe6-669a-08dd7698dc53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dgNy9bwNLIhhl5eCjAWSn6DLV3rngEtLDP3tTIXIMnO6RmNK73mmgBoOOrJ?=
 =?us-ascii?Q?Aofl2hwjKADw1HaigkdgjDHiC6nz3O3/EO+nfjKkUTS5rWS+59JbEUEHpJk2?=
 =?us-ascii?Q?0reCp8pANwPUNpeGqbI3k/md3kXSOEp16w+hkvFvPUtal0mQ729+fB2enchm?=
 =?us-ascii?Q?MWDsJ+YE5zSSYKJC5CQhOwk7mlT3922hcmjQ4B1dKPz6jQuYA5Y32xAFQa1b?=
 =?us-ascii?Q?U3Vx2CxvoQdS1yHz0oraEwoSqul/CY3/3OnxVMzYx/2XH5SZtpveknV5JqR1?=
 =?us-ascii?Q?eDQNau9TztBFegClYDKau3VR3jKMa3FeGr73dYVOb6ue+9CgLbeq8torEpLZ?=
 =?us-ascii?Q?ALcIg17FzzF5HPO9raV++uDihmsuwjaachqAUcVEYn1FEF0KpSbeBkPliSCU?=
 =?us-ascii?Q?JInrAJ+ST0pZAqtUzgN192XL+AEGhqEmxAMCS9hUNNULQfSumKEFou+tU6wI?=
 =?us-ascii?Q?IVELWO7jNA2tNmiW9mr+MWfmXSFqrUXPWvU35Tej8UsF7grkRMR6HKR07cvY?=
 =?us-ascii?Q?zWFZEzANLPhPTDccLRRJuWEl9B5YLP0xE6if3Tm/WrdagM7fNUDkFh0wEBT/?=
 =?us-ascii?Q?TK9pYGkEk/1ftK3i+WT8NHomJ0OgPkEU3CqEM8pk6Wg4KkrzzgGq8u/m4+7e?=
 =?us-ascii?Q?CDoK3Zw9lqpY5dGlq6OsT1Zulvme96055Cv3T+0h/CXlZG3i2/C/+Oo1v5zm?=
 =?us-ascii?Q?CKyt7Hv1L6QLGjlFn7WW0pNNQeyYS3qMz8FdQ7xwfDtGz1PLRvI2KxMwar3H?=
 =?us-ascii?Q?4inS+L5T3EhnpIY2M0OL5DQRvTtD+ec41w4Q8qjXNQyQrOHvVh5KKN2c+q35?=
 =?us-ascii?Q?aK6yxsvvo1WPTvZAmfGO4VjlcEdh4wDqcWFI01X0KnrfjWiKvSdNM95L9RxX?=
 =?us-ascii?Q?6AXv9lkGfaF+cGttwj70O/LS6bG/MXDvrkBD2L4ZwZscqh3UMMwnjNsv3Ime?=
 =?us-ascii?Q?Dzrdndr52W53roZjOOyupiW3xhh7efhvfNIp8OY3R6st1x9Pb/jl18ad0giP?=
 =?us-ascii?Q?0MHZPw9RdPkkkyORV5H9zWbk6itrhZyoitYTwEhIIHQxkB/IpkiLTrXP3rkL?=
 =?us-ascii?Q?OAeqOT+GbVnraeMWDmMFTev8z3ySL0wtmNUBpiLZmq85aIwfYY3h8DoZYzcz?=
 =?us-ascii?Q?VZXdbA4ADxXgptzsx45ZX9Un9QwIPt66auRwOWIag3T1CsRkGyc+Kyb8gb88?=
 =?us-ascii?Q?p3AefSRuNd7TajbRkILX/mtxqspg4yHU4JM9BozGITCJ1EeLnPJXktEsQT3C?=
 =?us-ascii?Q?Jn/R1/1zYuu1f6NyCtCl1YNJy8H+KxL76EA23UCqm9ylpawW1B13Fq8q9a5A?=
 =?us-ascii?Q?udXWmmwv1hubWwJ9Tp9wROmoGxd5+VeVKiUHxVL14nOVkpOP6/oW8OlTsqVd?=
 =?us-ascii?Q?HlfkOCTcuyMfOvvuO1YG2mPwjN6ZPJokQEgxIh/HIEhCkdjRDSTUreyqkiwO?=
 =?us-ascii?Q?8df1IpGZyURr0R+rt4Ihg4K8nuh/Xncn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zdgI8jc3E9eFHQxofDo4tpur2ZqG+THln/nwl8F9AAKS+E27gNcrZIyU7UR+?=
 =?us-ascii?Q?wDUNXYKXEwlSuL/ycOQoTThq9cvhfkiVmOtl+yaf9HI5ecgZvOToG6fGKrIJ?=
 =?us-ascii?Q?97xQbryT1/8a4cuXPTW77Xxl3C6q5+OhFJJjl40Er5kPUy4ns/SWoMjkx5v8?=
 =?us-ascii?Q?tcpU7VCwDN1FrTcXrrRf5Qj0WQN10meUESgtggPYTzDiHz+UOm+A5h2OP/bo?=
 =?us-ascii?Q?eSkmxp/x5TkeErLGTnSZ39GgT8VHZmOjd7ONNeYDOxGI+D4UkS1VVs6qcNoO?=
 =?us-ascii?Q?wsMk9fy8U7+hgpcpKjlKyAevuoEVZdtrHt/sapAxVoFE9NiRFiqBDp8egAYH?=
 =?us-ascii?Q?NiQ/TLlNnUNZy869honxXJNEsO+mSEnLNzFOQNV4JbmaG8joKlJHY3nVWukr?=
 =?us-ascii?Q?u36xwppG3/E10hiOx7P4uDZKeM49FxGIS3H4cgTl8iSholZa/RZSHEfivNO6?=
 =?us-ascii?Q?oBaJapoc2WGuxzfNsaYgOkSuXpAtAhuOLxpS9nuGsQXUzWrDr1syU2gRM3Vj?=
 =?us-ascii?Q?zHwls0ep+x4veR23sg3S+nZ8tcRkkQ7USWxaziTqhToBgc9ayH6RYZNK9YNy?=
 =?us-ascii?Q?kEWu8vP98rTRytjge2XHlzs4gORiieHwYyja6wlf6JkilrDYIFGLFUD3+jQr?=
 =?us-ascii?Q?1/vBcE7g/Rptx2UZ75RSYJTynABqVRP/2cPvsXm2xI//4JIpOsZ10pkr0KCG?=
 =?us-ascii?Q?3dIYSwNfy8CSK6mHQbPZtTe2j1UMBUJrJwaj+XOgW2cXqRXjqI2upN8B6Khl?=
 =?us-ascii?Q?PJYIN7blz02NjrswdSUKUP4CsN+PfTva+pLmKTttPavOwZLhtg8oyZOj0J3Z?=
 =?us-ascii?Q?fNmvZ2tw104gblUgvFi0Q9p0dDmpo3ixesPqh6a1LEcBrqwU2REAMwja+irj?=
 =?us-ascii?Q?oGVzdhf6LDImVYeELHza3KEfhOt4GuNDaB/T62EGvxhCj4RJUWgVXan8u3m0?=
 =?us-ascii?Q?CS1TxRxOPZrR4I19CiOPvMLZuM6FGJK7ya8I5mZe/Fd/LE8SNqW9f7q4uRh4?=
 =?us-ascii?Q?wMA4W6/QkoEJlYRV8Tz09nD2t72i8B8UPlr2gg/LajcNP+1TnwHKL0ALk8xK?=
 =?us-ascii?Q?yHtgDQvj0ZANypLNGQvb7RQt6JM183o4L+OSsOTFqi1zD2mehuQck+Bn4fIJ?=
 =?us-ascii?Q?bfHE9nXIoC4k5oIUX7lDNGUxoR05g5S1moRgj+U9ICA2zrYBP073oUV+juPr?=
 =?us-ascii?Q?BBgqvxeSc8h5VH4q5AKdewPwiMwRURCvSf7CPfis6KFbQxS0cCBNAZJkluIj?=
 =?us-ascii?Q?kNEluq3LMFCRliXe5fzqUC+rrzsUQ+jNQnCqhOKgDLcji7aG9buabNdMxyrs?=
 =?us-ascii?Q?PTOCwtS9s95Fi+ssNXrkLNW5vgU2Xp41HBQrG4vGRn0zJWa+bzMN6v33IXWX?=
 =?us-ascii?Q?sA10k/dusHhMGU0N/yjVbqFjU6ULXu+UWRUbjuvit/lxDXXLpmlIu2mY4Tua?=
 =?us-ascii?Q?mKJK6y5VV6lClOmJbvy9iXSxTL3uw2DiDMkkbuT9HZbH4hNfDZMauAdVUzJV?=
 =?us-ascii?Q?apEC8r9fWtGWxxLqhT0ilkXfY9EqpNnYvAO+IxvzpZc2yE9VhP42KBza1xeu?=
 =?us-ascii?Q?PjaS8Zp/1Px0LvEhtdvexPv8iB+6Lv8KOCsD8khuW3LBl2vJoazHwLVFTLt0?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1cbff9-4234-4fe6-669a-08dd7698dc53
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:28:26.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5g5SYGaZUSYR4nU6XV7gbx1geJxStRFqc/oMt7joXXAa48Qma8XovsZCNUgIJrpW7UFlQNa/MFrF3T2HFzpGzL1TMUwk/t1T2cssup0atQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6424

From: Lorenz Kofler <lorenz@sigma-star.at>

Currently, any exception that occurs in primary mode triggers a switch
to secondary mode, and Linux posts a signal.
This change enables certain exceptions to be handled directly in the
affected thread while remaining in primary mode.
The approach is loosely inspired by Linux's signal handling but is
implemented in a simpler manner.
For example, nesting identical signals is not supported. Additionally,
while a signal is being handled, it is added to the thread's blocking
set.

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Co-developed-by: Richard Weinberger <richard@sigma-star.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 include/cobalt/kernel/ppd.h                   |  3 +
 include/cobalt/kernel/thread.h                |  8 +++
 include/cobalt/signal.h                       |  2 +
 include/cobalt/uapi/syscall.h                 |  2 +
 kernel/cobalt/dovetail/kevents.c              |  5 ++
 .../include/asm-generic/xenomai/thread.h      |  3 +
 kernel/cobalt/posix/syscall.c                 | 41 +++++++++++++
 kernel/cobalt/thread.c                        | 59 +++++++++++++++++++
 kernel/cobalt/trace/cobalt-posix.h            |  4 +-
 lib/cobalt/signal.c                           | 19 ++++++
 10 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
index f0079fe6e..fb2f682da 100644
--- a/include/cobalt/kernel/ppd.h
+++ b/include/cobalt/kernel/ppd.h
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/rbtree.h>
+#include <linux/signal.h>
 #include <cobalt/kernel/heap.h>
 
 struct cobalt_umm {
@@ -32,6 +33,8 @@ struct cobalt_umm {
 
 struct cobalt_ppd {
 	struct cobalt_umm umm;
+	void __user *sighand[_NSIG];
+	void __user *sigrestorer;
 	atomic_t refcnt;
 	char *exe_path;
 	struct rb_root fds;
diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 04fad0e49..6c6609ef4 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -220,6 +220,8 @@ struct xnthread {
 #endif
 	struct lostage_signal sigarray[XNTHREAD_MAX_SIGNALS];
 	struct lostage_wakeup relax_work;
+
+	sigset_t sigblocked;
 };
 
 static inline int xnthread_get_state(const struct xnthread *thread)
@@ -581,6 +583,12 @@ static inline void xnthread_propagate_schedparam(struct xnthread *curr)
 
 extern struct xnthread_personality xenomai_personality;
 
+bool xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs);
+
+void xnarch_fixup_trap_regs(struct pt_regs *regs);
+
+bool xnarch_is_supported_signal(int sig);
+
 /** @} */
 
 #endif /* !_COBALT_KERNEL_THREAD_H */
diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
index 55cb2baba..cd37652c4 100644
--- a/include/cobalt/signal.h
+++ b/include/cobalt/signal.h
@@ -54,6 +54,8 @@ COBALT_DECL(int, kill, (pid_t pid, int sig));
 
 COBALT_DECL(int, sigqueue, (pid_t pid, int sig, const union sigval value));
 
+int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index f27988f55..0f43c5488 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -141,6 +141,8 @@
 #define sc_cobalt_timerfd_settime64		118
 #define sc_cobalt_timerfd_gettime64		119
 #define sc_cobalt_pselect64			120
+#define sc_cobalt_sigreturn			121
+#define sc_cobalt_sigaction			122
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 0f70dbc27..d962d5418 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -56,6 +56,11 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 		xnsched_run();
 	}
 
+	if (xnthread_test_state(thread, XNUSER) &&
+	    user_mode(regs) &&
+	    xnthread_handle_rt_signals(trapnr, regs))
+		return;
+
 	/*
 	 * If we experienced a trap on behalf of a shadow thread
 	 * running in primary mode, move it to the Linux domain,
diff --git a/kernel/cobalt/include/asm-generic/xenomai/thread.h b/kernel/cobalt/include/asm-generic/xenomai/thread.h
index 3881917bd..e886a706a 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/thread.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/thread.h
@@ -21,4 +21,7 @@ struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
 	return tcb->altsched.task;
 }
 
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+		int *sig, struct kernel_siginfo *info);
+
 #endif /* !_COBALT_ASM_GENERIC_THREAD_H */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index a26da154c..2a8c1e56b 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/kconfig.h>
 #include <linux/unistd.h>
 #include <linux/dovetail.h>
@@ -269,6 +270,46 @@ static COBALT_SYSCALL(serialdbg, current,
 	return 0;
 }
 
+static COBALT_SYSCALL(sigreturn, current, (void))
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	sigset_t *blocked;
+	int ret;
+
+	ret = dovetail_restore_rt_signal_frame(regs);
+	if (ret < 0) {
+		struct xnthread *thread = xnthread_current();
+		spl_t s;
+
+		xnlock_get_irqsave(&nklock, s);
+
+		xnthread_set_info(thread, XNKICKED);
+		__xnthread_signal(thread, SIGSEGV, 0);
+
+		xnlock_put_irqrestore(&nklock, s);
+		return ret;
+	}
+
+	blocked = &xnthread_current()->sigblocked;
+	sigdelset(blocked, ret);
+
+	return __xn_reg_rval(regs);
+}
+
+static COBALT_SYSCALL(sigaction, current, (int sig, void __user *handler,
+		      void __user *restorer))
+{
+	struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
+
+	if (sig < 0 || sig >= _NSIG || !xnarch_is_supported_signal(sig))
+		return -EINVAL;
+
+	sys_ppd->sighand[sig] = handler;
+	sys_ppd->sigrestorer = restorer;
+
+	return 0;
+}
+
 static void stringify_feature_set(unsigned long fset, char *buf, int size)
 {
 	unsigned long feature;
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index bdd053140..367726e0d 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -20,6 +20,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
+#include <linux/dovetail.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/signal.h>
@@ -42,6 +43,7 @@
 #include <pipeline/kevents.h>
 #include <pipeline/sched.h>
 #include <trace/events/cobalt-core.h>
+#include "posix/process.h"
 #include "debug.h"
 
 static DECLARE_WAIT_QUEUE_HEAD(join_all);
@@ -287,6 +289,7 @@ int __xnthread_init(struct xnthread *thread,
 	init_completion(&thread->exited);
 	memset(xnthread_archtcb(thread), 0, sizeof(struct xnarchtcb));
 	memset(thread->sigarray, 0, sizeof(thread->sigarray));
+	sigemptyset(&thread->sigblocked);
 
 	gravity = flags & XNUSER ? XNTIMER_UGRAVITY : XNTIMER_KGRAVITY;
 	xntimer_init(&thread->rtimer, &nkclock, timeout_handler,
@@ -2511,6 +2514,62 @@ int xnthread_killall(int grace, int mask)
 }
 EXPORT_SYMBOL_GPL(xnthread_killall);
 
+__weak int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+				  int *sig, struct kernel_siginfo *info)
+{
+	return -ENOSYS;
+}
+
+__weak void xnarch_fixup_trap_regs(struct pt_regs *regs)
+{
+}
+
+__weak bool xnarch_is_supported_signal(int sig)
+{
+	return -EINVAL;
+}
+
+bool xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs)
+{
+	struct cobalt_ppd *sys_ppd;
+	struct kernel_siginfo si;
+	struct ksignal ksig;
+	sigset_t *blocked;
+	int sig, ret;
+
+	ret = xnarch_setup_trap_info(trapnr, regs, &sig, &si);
+	if (ret)
+		return false;
+
+	sys_ppd = cobalt_ppd_get(0);
+	if (sys_ppd->sighand[sig] == NULL ||
+		sys_ppd->sighand[sig] == SIG_DFL ||
+		sys_ppd->sighand[sig] == SIG_IGN ||
+		sys_ppd->sighand[sig] == SIG_ERR)
+		return false;
+
+	blocked = &xnthread_current()->sigblocked;
+	if (sigismember(blocked, sig)) {
+		return false;
+	}
+
+	ksig.sig = sig;
+	memcpy(&ksig.info, &si, sizeof(si));
+	ksig.ka.sa.sa_flags = SA_SIGINFO | SA_RESTORER;
+	ksig.ka.sa.sa_restorer = sys_ppd->sigrestorer;
+	ksig.ka.sa.sa_handler = sys_ppd->sighand[sig];
+
+	ret = dovetail_setup_rt_signal_frame(&ksig, regs);
+	if (ret)
+		return false;
+
+	sigaddset(blocked, sig);
+
+	xnarch_fixup_trap_regs(regs);
+
+	return true;
+}
+
 /* Xenomai's generic personality. */
 struct xnthread_personality xenomai_personality = {
 	.name = "core",
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 41bbb04b9..6c5691d8c 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -172,7 +172,9 @@
 		__cobalt_symbolic_syscall(timer_gettime64),		\
 		__cobalt_symbolic_syscall(timerfd_settime64),		\
 		__cobalt_symbolic_syscall(timerfd_gettime64),		\
-		__cobalt_symbolic_syscall(pselect64))
+		__cobalt_symbolic_syscall(pselect64),			\
+		__cobalt_symbolic_syscall(sigreturn),			\
+		__cobalt_symbolic_syscall(sigaction))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 6e40a3680..d6a95c96e 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -125,3 +125,22 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, const union sigval value))
 
 	return 0;
 }
+
+XENOMAI_BUILD_SIGRETURN();
+
+extern void cobalt_sigreturn(void) __asm__ ("__cobalt_sigreturn")
+	__attribute__((visibility("hidden")));
+
+int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
+{
+	int ret;
+
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler,
+			       cobalt_sigreturn);
+	if (ret) {
+		errno = -ret;
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.48.1

