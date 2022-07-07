Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150098.outbound.protection.outlook.com [40.107.15.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F0210C
	for <xenomai@lists.linux.dev>; Thu,  7 Jul 2022 14:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtUe9IiBEGynITHxNmbIEveFLgvJ3PnGnkK6rK6nUNEoqM/j0K+pAjbdh9OW6rRyKFIHmXp0ViaOA9gAT9TZbYX0WZ2NmNbo8wORk3Z2suuvo+C4LN0ZUebQN1QHnv4e72Zm+WkbpxqS8vxCwv0nxN+YTxsksJcGAC2yHVmyoobDffvpvBJ0MQQKS/Di4YpEYnRSiEsJHAhAkJiyE75irLKa4j9KZyXEGVtfnda4/60pA81cE+xGXCTAxPbsWMSZcxJH+NiswATn5SVte14mdq3gG+SN2FcoVQCBI5ynMLIz1iyzct85LwzKjgwOPWr0ykJGh/Lw8TIvhzYdpxf3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg6mIEMuJ0nWmeIppMQzUf+9cwx1pfQhFTyps9vvu68=;
 b=ce6XMVccYcVpwgWQlwi9WJVqXTbypPQYlyO91SYEbAzbGIJ7ynxcR0e2vidYYMZaqJwgu9gb+993ujsOFQ8M5aQFzlGpWxCL6lzYgnAhnTdzXtR4xgTb6iWRszAA5wAURHMJlHgnS14WR4Pv3r8aOFGoOnGW1etaGrfGsFY7D8crqHwRkGzRkGF2gyUOw1l9M//c6HhbW/UIWFi6iwewAPbQ/TdPa40/scD0ZspoGpooM8VNAnNFN9BAJJlLLGeXbS/kbnctdJwW/WFLCyJrwVlQAkXwc8Ve2A3Rbx2ceVWEY2H2mJ/Ils5pwN3Tps/zBd3hsRgsOCJ8uSdpaeuVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg6mIEMuJ0nWmeIppMQzUf+9cwx1pfQhFTyps9vvu68=;
 b=vqH5VpJqflNZ2w9w7/plFoD2ZqlkFtZx6IJPK3hPi/+u/bRQOV60vViYazev0kqPruD99kzd/W4Qn/43nESgebzITYxi2/huYyj0ltij14alpdY245VhMKDTvrHaGhMVA66A9nNIsRG4Ip2JRwyBrcdtGwF6WrnEjxMdP1Bw61E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by HE1PR08MB2666.eurprd08.prod.outlook.com (2603:10a6:7:2f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 14:00:05 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:00:05 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Subject: [PATCH 1/3] rtsignals: part one, core code plus x86
Date: Thu,  7 Jul 2022 15:59:50 +0200
Message-Id: <20220707135952.5171-2-johannes.kirchmair@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: 80f9037f-bc55-4dd7-cb59-08da6020fe4f
X-MS-TrafficTypeDiagnostic: HE1PR08MB2666:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JG5R5AKTSJOJmcJEGdQo+kUCHrWu8K7yu8S5gaXmqwYuf95c9Si0DM2T9ATlXc4wDNLNQDRhQG4tnuKtwbYdFGccSw5rlnIlJe0hWqntIFm8VBA2ltKrKJA0TXkranuazPf9q0tqAt1d36jyeJHx3Lkd++CUVfCDSZBoHXY/v/Jw6W7JiTwtsTGPJOuKTjQ1XJMrsu2O4IlCh3ShrzpjGbUZtSm+RoGiN7kJlBbrP4RjqP1nJm/Qu1tLyO3nY5JXjHO13dVJ6/h1rLPVLa+Rz/fHRAIZJXG7GuPIlJA8P997gvgmoulWCHOSreNiXSGlZQnPVZvpsvPEHBWCDZjGrg8lro5uK14I4ddT6mid9u168F7Na6apUqPa4lB79691tRMhv5MUWdUSF/KQLKIfl4kPDF3f8+hYzeB8p9v/svZI7Q4lURBINTBsGicMQGYvG5n8qYbqSRghqhxQAqzPf4cSe8Mm8bpdzuajuI/tV9BaNd8DixDWOyhAUjEVqdJOAfUHyrK+I0e4fvF6Rs+2KZaKTL0DMqbxU9s0onrQTO/vBx0mnI8Gey4YVFX5iy7ZemggeWYzX/CPop8sIKYWPsotEpojxRreYK12GdwLrK4OjMy41NAPabtQ7uC0Q5eQF4ZhOg07+OO+AfcxxpisENyTQ2CBksFqOdYXbMIaDloTzgV6OH3ONXMRX3SOZ4suiypDV99xt3iHyIwEH/qW6MicSU4sWGGq4I1dK9H6ggpU4hltJekLRQnQ+SOPz+jwWJqF28LaoZveqKsGQBrB8hOkHDDCLYVhFlxiSBybMsFLCbg9QqYyioHucu6QM3Rf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39850400004)(396003)(376002)(346002)(86362001)(2616005)(52116002)(6506007)(26005)(1076003)(8936002)(44832011)(30864003)(6512007)(6916009)(6486002)(5660300002)(66946007)(478600001)(8676002)(41300700001)(6666004)(2906002)(38100700002)(316002)(83380400001)(186003)(38350700002)(66476007)(36756003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?32WuXodge59+/wM36/oMFW4gr7ZkQI96tdL7rX1o3AXXmAEnZUKyMb1i/aKj?=
 =?us-ascii?Q?iN8f2Kkdr2A8oG3FKgV1it3kwliP9aN4HzMldi199ZEzrjqfv/vw+62V+336?=
 =?us-ascii?Q?ZQUTc4Xd6gpdIPIxPyLmrMAJAA+HwwP3nvgTvuheWs9PluiK3fpL5Sbto1FS?=
 =?us-ascii?Q?WnAWvNUFh2BA240uYXS0SnO/b7X6gs4UMNDa+WTfVIe0kdc0aZS9HgqLJN/H?=
 =?us-ascii?Q?xirbHssolnpSyQ7RtADtaZjS0lafz8QOF+fuTpHOKK03+2uEO8Ai/2RGtVYw?=
 =?us-ascii?Q?7IktCBAf575BqqW5l2L9s/AJFiVPxUGus+WKdmBAyOhNReSgZ56zARaNNyWM?=
 =?us-ascii?Q?fOS1zYaOdmm9wd9FSLO/6TG0x3xhaHH79uq6FQS7DczV3KLEp/5ByoXpU0rU?=
 =?us-ascii?Q?7Wu5iyXtDA5/WnbjtY9YtvpgVSAyUyO/6a14D7F4V9SUB6V5MpbGfKqjmbPI?=
 =?us-ascii?Q?g8oRAXB1r31XQ66cJnhs/6tBSLs3SLocOCGQ6gyvCt6N47O6nwaDyM+Fc8kV?=
 =?us-ascii?Q?/xR8M2OnvaQgn8iuh2Azu5iZtHhhPE+JdequBKUfdK45wuychd6bQJLohzJO?=
 =?us-ascii?Q?6wq3/c1NkUXe+CJXWPepZUsATGRfIsPhTKQzQJALtfaXbgpV/PYdYVI9//CD?=
 =?us-ascii?Q?7G3ZJT7jjmDkFOZjuZE87ibnRKhNhC2lKtXWQuvCPoz9QPnLbaG1fdSq/AJq?=
 =?us-ascii?Q?yMkH8Eko2rB15Ml/SX5zlbFQrW6VS3+u7ShdiqIY0A0hmDd++WH5Pjp8MiRs?=
 =?us-ascii?Q?wmg17LgUw8BZB+QeKndpNS5VhKsUj78m3SGc67qH7J4aRcalKHUMxvkpk6Aq?=
 =?us-ascii?Q?07IQiLV0mU07C7BFtnu9jpLXl3RPtMF/eGjt8BHUAMjgvEf96B4m62rXEEhb?=
 =?us-ascii?Q?lR59z1jl9jprSLpoXesiDjwmVeR2WU9E6O4uUPZ6ipAcRK8dHNLJkWxQJJoG?=
 =?us-ascii?Q?fLkwAyngfZU+MSvGG4dJQdSlU1ms431dwmY1otPUpIK+Ragx7asNvXwJmqtt?=
 =?us-ascii?Q?UArYk4LGIQ5tXeRTWp+fi5YnbkkMyJ30uRRJt0wokIjeXl4EIqC5TKtechU9?=
 =?us-ascii?Q?jKrxitbVHFK5XBrHzarCiIKl1+NTvQ0X3r0TzWKJ243WH0AC5Iidp8gVgZTm?=
 =?us-ascii?Q?gsEnLKdEni51mwF7vmyTFPAIPHD5CKwFFYdQ2Ktb9yw39EHnPasEnocW9kXP?=
 =?us-ascii?Q?8JrLpJP07Sk+yZZvLCPW1BWkNelnnbmSqt3BxyAb8JinqShZQvplQXYTpJC5?=
 =?us-ascii?Q?LAT/yS0HdLHAy2Ya/KXVegWdnE6WAF5ja7OYYNWs5RtrzF6cnbhg0Ccqmg3C?=
 =?us-ascii?Q?hFw2QSZWKxbC6f/Yzw/7cPAZuAfYeQovYeS+y5xg8X5afvXeR/PyKFEjOWXc?=
 =?us-ascii?Q?PaJMmL9Lb54II7pocLUl6mEOO/AkguoG3xCNzpPlLwtsVN3tC22XzvsI8Ppg?=
 =?us-ascii?Q?tXtkngMW6yDogFGgFEe0+7pF9AUrjtCNiC6FsYu3xDl0j1Q9XxIYp75D2rzb?=
 =?us-ascii?Q?DiWB33Zrr0EqfL0ccvCX28gfRuJsEDmPxPAfWwKAQHD6nz1OT76toRr6TNt3?=
 =?us-ascii?Q?4c9fAuFcf/jAAphOV2N7WB8vK50pWCJTDCZnqiXsxeEth7OHyIa01BZfFzT1?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f9037f-bc55-4dd7-cb59-08da6020fe4f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:00:05.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAUr+2Vaw3tqGRZJafJhl6oJihDbqwyYPykhkdua9FGne8v/XJF7RtOd4cXBXD0yuxdF6y4dh2j1dFSU6NJ/qHl+by30VU3ZLX54d3MQaL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2666

From: Richard Weinberger <richard@nod.at>

Adds code for implementing signals that are handled in the real time
domain. This is done for 32bit process under an 64bit kernel.
It works in a similar way to signals in the Linux kernel.

Edited-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
---
 include/cobalt/kernel/ppd.h                   |   3 +
 include/cobalt/kernel/thread.h                |   2 +
 include/cobalt/signal.h                       |   2 +
 include/cobalt/uapi/syscall.h                 |   6 +
 kernel/cobalt/arch/x86/Makefile               |   2 +-
 .../arch/x86/include/asm/xenomai/thread.h     |   9 +
 kernel/cobalt/arch/x86/signal_ia32.c          | 293 ++++++++++++++++++
 kernel/cobalt/posix/process.c                 |  10 +-
 kernel/cobalt/posix/syscall.c                 |  25 ++
 kernel/cobalt/posix/syscall32.c               |  16 +
 kernel/cobalt/thread.c                        |  34 +-
 lib/cobalt/arch/x86/Makefile.am               |   2 +-
 lib/cobalt/arch/x86/sigreturn.c               |  22 ++
 lib/cobalt/internal.h                         |   2 +
 lib/cobalt/signal.c                           |  14 +
 15 files changed, 437 insertions(+), 5 deletions(-)
 create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
 create mode 100644 lib/cobalt/arch/x86/sigreturn.c

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
index 03adb2529..6afed4f58 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -563,6 +563,8 @@ static inline void xnthread_propagate_schedparam(struct xnthread *curr)
 		__xnthread_propagate_schedparam(curr);
 }
 
+int xnthread_handle_rt_signals(struct ipipe_trap_data *d);
+
 extern struct xnthread_personality xenomai_personality;
 
 /** @} */
diff --git a/include/cobalt/signal.h b/include/cobalt/signal.h
index 62694f93a..3d6540aff 100644
--- a/include/cobalt/signal.h
+++ b/include/cobalt/signal.h
@@ -54,6 +54,8 @@ COBALT_DECL(int, kill(pid_t pid, int sig));
 COBALT_DECL(int, sigqueue(pid_t pid, int sig,
 			  const union sigval value));
 
+int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index aa3c308d0..64a502f2a 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -123,6 +123,12 @@
 #define sc_cobalt_clock_adjtime			100
 #define sc_cobalt_thread_setschedprio		101
 
+/*
+ * Sigmatek specific syscalls
+ */
+#define sc_cobalt_sigreturn			120
+#define sc_cobalt_sigaction			121
+
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
 #endif /* !_COBALT_UAPI_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
index 1ef407c35..6bbf15651 100644
--- a/kernel/cobalt/arch/x86/Makefile
+++ b/kernel/cobalt/arch/x86/Makefile
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o thread.o smi.o c1e.o
+xenomai-y := machine.o thread.o smi.o c1e.o signal_ia32.o
 
 ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 10cd6ecd5..be93926a7 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -77,6 +77,15 @@ void xnarch_init_shadow_tcb(struct xnthread *thread);
 
 void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   long errcode, int *sig, struct kernel_siginfo *info);
+
+int xnarch_setup_rt_frame_ia32(int sig, void *handler,
+			       struct kernel_siginfo *si, struct pt_regs *regs,
+			       void __user *restorer);
+
+int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
+
 static inline void xnarch_enter_root(struct xnthread *root) { }
 
 static inline int xnarch_escalate(void)
diff --git a/kernel/cobalt/arch/x86/signal_ia32.c b/kernel/cobalt/arch/x86/signal_ia32.c
new file mode 100644
index 000000000..17a95faf5
--- /dev/null
+++ b/kernel/cobalt/arch/x86/signal_ia32.c
@@ -0,0 +1,293 @@
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <cobalt/kernel/thread.h>
+
+#include <asm/sigframe.h>
+#include <asm/sighandling.h>
+#include <asm/fpu/signal.h>
+
+#define loadsegment_gs(v) load_gs_index(v)
+#define loadsegment_fs(v) loadsegment(fs, v)
+#define loadsegment_ds(v) loadsegment(ds, v)
+#define loadsegment_es(v) loadsegment(es, v)
+
+#define get_user_seg(seg)                                                      \
+	({                                                                     \
+		unsigned int v;                                                \
+		savesegment(seg, v);                                           \
+		v;                                                             \
+	})
+#define set_user_seg(seg, v) loadsegment_##seg(v)
+
+#define COPY(x)                                                                \
+	{                                                                      \
+		get_user_ex(regs->x, &sc->x);                                  \
+	}
+
+#define GET_SEG(seg)                                                           \
+	({                                                                     \
+		unsigned short tmp;                                            \
+		get_user_ex(tmp, &sc->seg);                                    \
+		tmp;                                                           \
+	})
+
+#define RELOAD_SEG(seg)                                                        \
+	{                                                                      \
+		unsigned int pre = GET_SEG(seg);                               \
+		unsigned int cur = get_user_seg(seg);                          \
+		pre |= 3;                                                      \
+		if (pre != cur)                                                \
+			set_user_seg(seg, pre);                                \
+	}
+
+#define COPY_SEG_CPL3(seg)                                                     \
+	do {                                                                   \
+		regs->seg = GET_SEG(seg) | 3;                                  \
+	} while (0)
+
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   long errcode, int *sig, struct kernel_siginfo *info)
+{
+	switch (vector) {
+	case 0: /* divide_error */
+		*sig = SIGFPE;
+		info->si_signo = *sig;
+		info->si_errno = 0;
+		info->si_code = FPE_INTDIV;
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+	case 1: /* trap_error */ {
+		unsigned long condition;
+		get_debugreg(condition, 6);
+		set_debugreg(0, 7);
+		*sig = SIGTRAP;
+		info->si_signo = *sig;
+		info->si_errno = errcode;
+		info->si_code = get_si_code(condition);
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+	}
+	case 3: /* trap_error */
+		*sig = SIGTRAP;
+		info->si_signo = *sig;
+		info->si_errno = errcode;
+		info->si_code = SI_KERNEL;
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+	case 6: /* invalid_op */
+		*sig = SIGILL;
+		info->si_signo = *sig;
+		info->si_errno = 0;
+		info->si_code = ILL_ILLOPN;
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+	case 16: { /* coprocessor_error */
+		*sig = SIGFPE;
+
+		info->si_signo = *sig;
+		info->si_errno = 0;
+		info->si_code = 0;
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+	}
+	default:
+		break;
+	}
+
+	return -ENOSYS;
+}
+
+static void *xnarch_get_sigframe_ia32(struct pt_regs *regs, size_t frame_size,
+				      void __user **fpstate)
+{
+	unsigned long sp = regs->sp;
+	unsigned long buf_fx = 0;
+	unsigned long math_size = 0;
+
+	sp = fpu__alloc_mathframe(sp, 1, &buf_fx, &math_size);
+	*fpstate = (void __user *)sp;
+
+	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx,
+				     math_size) < 0)
+		return (void __user *)-1L;
+
+	sp -= frame_size;
+	sp = ((sp + 4) & -16ul) - 4;
+
+	return (void __user *)sp;
+}
+
+static const struct {
+	u8 movl;
+	u32 val;
+	u16 int80;
+	u8 pad;
+} __attribute__((packed)) ia32_sigret_code = {
+	0xb8,
+	__NR_ia32_rt_sigreturn,
+	0x80cd,
+	0,
+};
+
+static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
+				 void __user *fpstate, struct pt_regs *regs,
+				 unsigned int mask)
+{
+	int err = 0;
+
+	put_user_try
+	{
+		put_user_ex(get_user_seg(gs), (unsigned int __user *)&sc->gs);
+		put_user_ex(get_user_seg(fs), (unsigned int __user *)&sc->fs);
+		put_user_ex(get_user_seg(ds), (unsigned int __user *)&sc->ds);
+		put_user_ex(get_user_seg(es), (unsigned int __user *)&sc->es);
+
+		put_user_ex(regs->di, &sc->di);
+		put_user_ex(regs->si, &sc->si);
+		put_user_ex(regs->bp, &sc->bp);
+		put_user_ex(regs->sp, &sc->sp);
+		put_user_ex(regs->bx, &sc->bx);
+		put_user_ex(regs->dx, &sc->dx);
+		put_user_ex(regs->cx, &sc->cx);
+		put_user_ex(regs->ax, &sc->ax);
+		put_user_ex(current->thread.trap_nr, &sc->trapno);
+		put_user_ex(current->thread.error_code, &sc->err);
+		put_user_ex(regs->ip, &sc->ip);
+		put_user_ex(regs->cs, (unsigned int __user *)&sc->cs);
+		put_user_ex(regs->flags, &sc->flags);
+		put_user_ex(regs->sp, &sc->sp_at_signal);
+		put_user_ex(regs->ss, (unsigned int __user *)&sc->ss);
+
+		put_user_ex(ptr_to_compat(fpstate), &sc->fpstate);
+
+		/* non-iBCS2 extensions.. */
+		put_user_ex(mask, &sc->oldmask);
+		put_user_ex(current->thread.cr2, &sc->cr2);
+	}
+	put_user_catch(err);
+
+	return err;
+}
+
+static int xnarch_restore_sigcontext_ia32(struct pt_regs *regs,
+					  struct sigcontext_32 __user *sc)
+{
+	int tmpflags, err = 0;
+	void __user *buf;
+	u32 tmp;
+
+	get_user_try
+	{
+		/*
+		 * Reload fs and gs if they have changed in the signal
+		 * handler.  This does not handle long fs/gs base changes in
+		 * the handler, but does not clobber them at least in the
+		 * normal case.
+		 */
+		RELOAD_SEG(gs);
+		RELOAD_SEG(fs);
+		RELOAD_SEG(ds);
+		RELOAD_SEG(es);
+
+		COPY(di);
+		COPY(si);
+		COPY(bp);
+		COPY(sp);
+		COPY(bx);
+		COPY(dx);
+		COPY(cx);
+		COPY(ip);
+		COPY(ax);
+		/* Don't touch extended registers */
+
+		COPY_SEG_CPL3(cs);
+		COPY_SEG_CPL3(ss);
+
+		get_user_ex(tmpflags, &sc->flags);
+		regs->flags =
+			(regs->flags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
+		/* disable syscall checks */
+		regs->orig_ax = -1;
+
+		get_user_ex(tmp, &sc->fpstate);
+		buf = compat_ptr(tmp);
+	}
+	get_user_catch(err);
+
+	err |= fpu__restore_sig(buf, 1);
+
+	return err;
+}
+
+int xnarch_rt_sigreturn_ia32(struct pt_regs *regs)
+{
+	struct rt_sigframe_ia32 __user *frame =
+		(struct rt_sigframe_ia32 __user *)(regs->sp - 4);
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+
+	if (xnarch_restore_sigcontext_ia32(regs, &frame->uc.uc_mcontext))
+		goto badframe;
+
+	return 0;
+
+badframe:
+	xnthread_call_mayday(xnthread_current(), SIGKILL);
+	return -1;
+}
+
+int xnarch_setup_rt_frame_ia32(int sig, void *handler,
+			       struct kernel_siginfo *si, struct pt_regs *regs,
+			       void __user *restorer)
+{
+	struct rt_sigframe_ia32 __user *frame;
+	void __user *fpstate = NULL;
+	compat_sigset_t set;
+	int err = 0;
+
+	frame = xnarch_get_sigframe_ia32(regs, sizeof(*frame), &fpstate);
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	put_user_try
+	{
+		put_user_ex(sig, &frame->sig);
+		put_user_ex(ptr_to_compat(&frame->info), &frame->pinfo);
+		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
+
+		if (boot_cpu_has(X86_FEATURE_XSAVE))
+			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
+		else
+			put_user_ex(0, &frame->uc.uc_flags);
+
+		put_user_ex(0, &frame->uc.uc_link);
+		put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
+		put_user_ex(*((u64 *)&ia32_sigret_code),
+			    (u64 __user *)frame->retcode);
+	}
+	put_user_catch(err);
+
+	err |= __copy_siginfo_to_user32(&frame->info, si, false);
+	err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate, regs,
+				     set.sig[0]);
+	err |= __copy_to_user(&frame->uc.uc_sigmask, &set, sizeof(set));
+
+	if (err)
+		return -EFAULT;
+
+	regs->sp = (unsigned long)frame;
+	regs->ip = (unsigned long)handler;
+
+	regs->ax = sig;
+	regs->dx = (unsigned long)&frame->info;
+	regs->cx = (unsigned long)&frame->uc;
+
+	loadsegment(ds, __USER32_DS);
+	loadsegment(es, __USER32_DS);
+
+	regs->cs = __USER32_CS;
+	regs->ss = __USER32_DS;
+
+	return 0;
+}
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index f762fef2e..ef6fa8e38 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -860,13 +860,21 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 		       xnarch_fault_pc(d),
 		       xnthread_host_pid(thread));
 		xntrace_panic_dump();
-	} else if (xnarch_fault_notify(d)) /* Don't report debug traps */
+	}
+#if 1
+	else {
+		if (xnthread_handle_rt_signals(d) == 0)
+			return KEVENT_STOP;
+	}
+#else
+	else if (xnarch_fault_notify(d)) /* Don't report debug traps */
 		printk(XENO_WARNING
 		       "switching %s to secondary mode after exception #%u from "
 		       "user-space at 0x%lx (pid %d)\n", thread->name,
 		       xnarch_fault_trap(d),
 		       xnarch_fault_pc(d),
 		       xnthread_host_pid(thread));
+#endif
 #endif
 
 	if (xnarch_fault_pf_p(d))
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index a9c979903..b63923017 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -270,6 +270,31 @@ static COBALT_SYSCALL(serialdbg, current,
 	return 0;
 }
 
+static COBALT_SYSCALL(sigreturn, current, (void))
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	xnarch_rt_sigreturn_ia32(regs);
+
+	return __xn_reg_rval(regs);
+}
+
+static COBALT_SYSCALL(sigaction, current,
+		      (int sig, void __user *handler, void __user *restorer))
+{
+	struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
+
+	if (sig < 0 || sig >= _NSIG)
+		return -EINVAL;
+
+	sys_ppd->sighand[sig] = handler;
+
+	if (!sys_ppd->sigrestorer)
+		sys_ppd->sigrestorer = restorer;
+
+	return 0;
+}
+
 static void stringify_feature_set(unsigned long fset, char *buf, int size)
 {
 	unsigned long feature;
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index fd4e789b2..bd38dda15 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -658,6 +658,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
 	return ret ?: __cobalt_sigqueue(pid, sig, &val);
 }
 
+COBALT_SYSCALL32emu(sigaction, current,
+		    (int sig, void __user *handler, void __user *restorer))
+{
+	struct cobalt_ppd *sys_ppd = cobalt_ppd_get(0);
+
+	if (sig < 0 || sig >= _NSIG)
+		return -EINVAL;
+
+	sys_ppd->sighand[sig] = handler;
+
+	if (!sys_ppd->sigrestorer)
+		sys_ppd->sigrestorer = restorer;
+
+	return 0;
+}
+
 COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
 		    (struct cobalt_monitor_shadow __user *u_mon,
 		     int event, const struct compat_timespec __user *u_ts,
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index e286bf48a..34066e614 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -39,6 +39,7 @@
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/thread.h>
 #include <trace/events/cobalt-core.h>
+#include "posix/process.h"
 #include "debug.h"
 
 static DECLARE_WAIT_QUEUE_HEAD(join_all);
@@ -2077,7 +2078,7 @@ void xnthread_relax(int notify, int reason)
 	struct task_struct *p = current;
 	int suspension = XNRELAX;
 	int cpu __maybe_unused;
-	kernel_siginfo_t si;
+	struct kernel_siginfo si;
 
 	primary_mode_only();
 
@@ -2210,7 +2211,7 @@ static void lostage_task_signal(struct ipipe_work_header *work)
 	struct lostage_signal *rq;
 	struct xnthread *thread;
 	struct task_struct *p;
-	kernel_siginfo_t si;
+	struct kernel_siginfo si;
 	int signo;
 
 	rq = container_of(work, struct lostage_signal, work);
@@ -2663,6 +2664,35 @@ int xnthread_killall(int grace, int mask)
 }
 EXPORT_SYMBOL_GPL(xnthread_killall);
 
+int xnthread_handle_rt_signals(struct ipipe_trap_data *d)
+{
+	unsigned int vector = xnarch_fault_trap(d);
+	unsigned int code = xnarch_fault_code(d);
+	struct pt_regs *regs = d->regs;
+	struct cobalt_ppd *sys_ppd;
+	int sig, ret;
+	struct kernel_siginfo si;
+
+	ret = xnarch_setup_trap_info(vector, regs, code, &sig, &si);
+	if (ret || sig == 0)
+		return 1;
+
+	sys_ppd = cobalt_ppd_get(0);
+	if (sig >= _NSIG || sys_ppd->sighand[sig] == NULL ||
+	    sys_ppd->sighand[sig] == SIG_DFL)
+		return 1;
+
+	if (sys_ppd->sigrestorer == NULL)
+		return 1;
+
+	ret = xnarch_setup_rt_frame_ia32(sig, sys_ppd->sighand[sig], &si, regs,
+					 sys_ppd->sigrestorer);
+	if (ret)
+		return 1;
+
+	return 0;
+}
+
 /* Xenomai's generic personality. */
 struct xnthread_personality xenomai_personality = {
 	.name = "core",
diff --git a/lib/cobalt/arch/x86/Makefile.am b/lib/cobalt/arch/x86/Makefile.am
index a5095be3d..14f5eff97 100644
--- a/lib/cobalt/arch/x86/Makefile.am
+++ b/lib/cobalt/arch/x86/Makefile.am
@@ -2,7 +2,7 @@ noinst_LTLIBRARIES = libarch.la
 
 libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
 
-libarch_la_SOURCES = features.c
+libarch_la_SOURCES = features.c sigreturn.c
 
 libarch_la_CPPFLAGS =			\
 	@XENO_COBALT_CFLAGS@ 		\
diff --git a/lib/cobalt/arch/x86/sigreturn.c b/lib/cobalt/arch/x86/sigreturn.c
new file mode 100644
index 000000000..6a3ecf07d
--- /dev/null
+++ b/lib/cobalt/arch/x86/sigreturn.c
@@ -0,0 +1,22 @@
+#include <cobalt/uapi/syscall.h>
+#include "internal.h"
+
+extern void cobalt_sigreturn(void) asm("__cobalt_sigreturn")
+	__attribute__((visibility("hidden")));
+
+#define build_restorer(syscall_number)                                         \
+	asm(".text\n"                                                          \
+	    "    .align 16\n"                                                  \
+	    "__cobalt_sigreturn:\n"                                            \
+	    "    movl $ " #syscall_number ", %eax\n"                           \
+	    "    int  $0x80")
+
+/*
+ * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
+ */
+build_restorer(0x10000078);
+
+void *cobalt_get_restorer(void)
+{
+	return &cobalt_sigreturn;
+}
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index 4d81b70c2..74a20e6f1 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -126,4 +126,6 @@ static inline bool cobalt_features_available(unsigned int feat_mask)
 	return (cobalt_features & feat_mask) == feat_mask;
 }
 
+extern void *cobalt_get_restorer(void);
+
 #endif /* _LIB_COBALT_INTERNAL_H */
diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 7e033019a..de7f7bbb0 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -122,3 +122,17 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, const union sigval value))
 
 	return 0;
 }
+
+int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
+{
+	int ret;
+
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler,
+			       cobalt_get_restorer());
+	if (ret) {
+		errno = -ret;
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.25.1

