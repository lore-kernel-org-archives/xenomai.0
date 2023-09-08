Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2102.outbound.protection.outlook.com [40.107.14.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A51871
	for <xenomai@lists.linux.dev>; Fri,  8 Sep 2023 10:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Inz+nhp+aaD/pIviEq2EMSez5Iexp3VZW7M1A5FPSzemC9o0uWbsbHB5VZUAPtpLtV0zydisxAq1gmuGIkG6hunKma6zpkFVaNgBQC2s1vIrGES9s+kuoqCdXenOgJocGAD1Uaf04Ntze70goRLUTM8/T3VpyNWNIo3c0loFZSTVLkMixwRvU7mjW4mSKAxV6MJjTKd8pPey/CnW122zz1cvG6sE/On3MU+tKaZQqN/PON4asorpxQ9YUy49W1z+Q7hS97HR/W3gZoQrJze+HZJx7qzKoWGGHsYfDILZntlLeDIaHCCz9muV37HG0W8tLk9dDroiZy5Pudn+8JBM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ3YsHymjJ15NhBrb8HiJLv6VHk9jTE5ORbP+Wcm9Wc=;
 b=hD87uZ12JX8kXqaIwo2L2uihzpnZRuMbCJHnLduPGshFe0s3X1Z50wL2JtPtrTP/9kgn/TJNUiNy+GccDW6Wv5r2a8HA84t/MNuF+vsDv8sNnHygeBPqmk4tGU6v8nn/l6tgiLRkREXz8m5ieGb1gCWPo0zATOyKgPkTWo9mvPmmMHcnWTQFvY6U0uu6LdE0415oAuUy+3wvGx0fOD5/R5DI04sjuEsVhESP1YL7RxtNyBOycX9D+0VI380BQniasCaUU5W/WRvXlgGOFD0z/aMOgg2+Whm0AfPddV1qFg0gS1+fbTjAy/jSGej45DgP8rj9sIlGDqbmdorg6iuWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ3YsHymjJ15NhBrb8HiJLv6VHk9jTE5ORbP+Wcm9Wc=;
 b=wFdt1LCDISOYhfsv7rJwpGCcLE6hfkrtZpDffaUjCD6UtsWjuz2dAtBjM24VZBOkQrYILSbaGS6ShKYaNvUkXAj3djZeKVWGGsZ/vlzdyNgaq1xZXGX2XQDcERuEoSeEt25QZ+p8zfg4pDAWV/InlC1FYMnPoRV+xXJFqzcnTfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by PAWPR08MB10059.eurprd08.prod.outlook.com (2603:10a6:102:35d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 10:51:48 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:51:47 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 1/3] [POC] test implementaion of rt-signals
Date: Fri,  8 Sep 2023 12:50:41 +0200
Message-Id: <20230908105043.1355310-1-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 5b32c407-a310-4cad-2126-08dbb0599968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iEon2TGb54VnLEGPv9UJDlqDCRVTcQqrrCJ2FzXLazlby9ZDo2QZIVP6bYh8kHaVgt21hptMHdVMfSO1BKMiqsgGzazQeIPHakHox0+zm8ulbyMrR4j6jyxGMFMoNknHAP5+GkNtWYAA7jelIDemBeU1/tXcGmV+03lDBwTN2KomUe8sJlQcjtpQbxaInUFc0io8JLWoIrkq3mVOZWVXjuORd4dCoLAKtqjJp2xMMpZrGyQFR6XCIgYYg7YucwXv1n8LbRdsB6m0XtZUbb58Pf+wLxNEQrjGO6jvg59dD3629LvJ5WJ1d1HCHl1GdfAkHbbWcfrLm67SovskQkom9PnWd/l59tVUIRBpC/DEg3JERYs7UQqsooaEdpvv1RYVmryN3/Mc4YmQsNtSFViuzJ8lNf2fjWwBvhuPhz6lJINKTVDLu5Vf4A+wHp3sFS60NV4jw2yDrKJ6Fu6RsX2gX/R83+YbiZD2zAT3NV0XlL2GvnSEn4OgKXBbQ58WEW6s7rXentLmIDnfnDZkpnjjM9WUDBL1ri+R8LpfWwBj8qOzvS+B34GPQYzDm6VyOg18BAe5o97Gmq3Jqy1Up5TL70wJtdUBZDETx3QSPOeOdOE/mIRK5lcNLBNe4XKUw3ia
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39840400004)(346002)(1800799009)(451199024)(186009)(6666004)(6506007)(52116002)(6486002)(86362001)(36756003)(1076003)(38100700002)(107886003)(38350700002)(26005)(30864003)(83380400001)(6512007)(478600001)(4326008)(8676002)(5660300002)(8936002)(66556008)(316002)(2616005)(6916009)(2906002)(66476007)(41300700001)(66946007)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZA74VWpxjOqHqf+kXBoU79FlpwCgGtTFjSCVIsLSTs34iyG5OWX2ae4tKJz?=
 =?us-ascii?Q?sODdpfQt5N+3d002/ofPWrQXauqmg4pRvZkwOw/y/YAhKEwqKhGezBaIh0tV?=
 =?us-ascii?Q?1U1t09dsnRMQg6Ff7ToGnp+uFhtp8kdycJQELsTwI881ZNqj/nVQlnSAd2Q6?=
 =?us-ascii?Q?QuRUsp6d8NcvFfrfvOeg3XVj7muwNxv7s2wjWF2j3yjsJiU3qfsUSks4nRLy?=
 =?us-ascii?Q?8fbdGyrntrDlwu8IIIhLA4qtAFfvUGvvmuPCd5v92nztWDO4hTzMzkaUOXN+?=
 =?us-ascii?Q?V3rYUyDbtUywDvnwkhwKgfZIgu5gCinj5HztT789SXZ28oMyFja9mUBA8URA?=
 =?us-ascii?Q?rXfbfxqcqD91WfcoVpjV6KT+7ZGFHLMill1/mNAQI4egfTPdNeNLud+ZyZ7Y?=
 =?us-ascii?Q?bpow+h03sZQSx47St4JUQgots2+NBpISxelk1PUv4VgO1fQnjMDGihu7fqt6?=
 =?us-ascii?Q?DG/VPamezshwu/yv290AwaLiNvb9DrGe9hkqyQkPg+fF5mQo3822wfe09/Bm?=
 =?us-ascii?Q?hliu0FRN0fivLkgjqtFOBKwpYAlr3Je4N6/jpeuGvTmIzqVYjhKdg82O4eEr?=
 =?us-ascii?Q?P/zbG0f6MvmorlM6JUFstDOxNMeX6y+yVRjs2xJ7RV+hojn1+6UT1FTSkD5A?=
 =?us-ascii?Q?pjhku2BWhAGKQbRhXvGRGVGV5E7qG/jl7+3NPOFJLnnCNcsWWP1hRGrRuLJJ?=
 =?us-ascii?Q?jduNdIAOBzoGac+bw+dpRoU568h3aDLqV9xrrCRVZ56uPGibrkDkG2aNWi2p?=
 =?us-ascii?Q?GEG3oRAscEsTiP+kWv3lNe/4VkQcjT0Io4Jr9EdNiQk/7/zq0hkP2Remq7Ip?=
 =?us-ascii?Q?Si7baNZNsUNL4nF5qmjhy3unxVTPx3wjtque890+tBHDZlcCqRKwN4sY7/DV?=
 =?us-ascii?Q?O2rj73U4ard/kl7qt713Z3MxSI24XEwsJWGTZQJl1QL70h5RGYtxNymgyhWj?=
 =?us-ascii?Q?O9zsEvKzYIJYvZGY3XsjtSKhKTcB8iXX4VHkS4GxJ97akjONIenAEE/8r5eY?=
 =?us-ascii?Q?+Z6lKJU2UV/tDnR5fWyWIF6Zf4C3Ep1X6KGKuV5kLuoA0o/W27dFsqQAsEey?=
 =?us-ascii?Q?E4UlIEkeO08Ko607lFxWH3uZrRvqZaGa8h8FG69gOTq6OXfoUGSOqp+ls/jO?=
 =?us-ascii?Q?wSxefN+aFFlzze8IHtrFLELTcsm0gPWKK/9YSm6Qvuvg//LhM5DLplSDJeP0?=
 =?us-ascii?Q?T8bs9KLjbttDkIMetx4t1D/a/BeKC4lKlTiGQP9FluMG3fN4rzsK6juLJ0dh?=
 =?us-ascii?Q?vHG4B28ovWdNUOFCZLP99g0SU2JiuWRcpIlaWtAf7DHPXh4U9ColvkdgipId?=
 =?us-ascii?Q?6UjYk1GEfgkwr/B1OHDA5mBB/TW0ZcIAjLhHUsL3OPy6ykiTZ74pXjAbCVdZ?=
 =?us-ascii?Q?C9Zjet5ydZtcfPbZoYkWTFmGWsSy+hRMRgiTsAFz8ieHRKfd1OqYS7VvduEG?=
 =?us-ascii?Q?6LPtSXu+AXCkqwi7x4nN9/SNhj9k4E69cLA0z2bqXeglUksoureCg5olxbfr?=
 =?us-ascii?Q?x0ae81aHc1vRetbmnt6kzULiBni+YccIfQhihIcwjv1VlT522TUw+dDtx3Qd?=
 =?us-ascii?Q?6eFMPxhLdtl+E6m1LLJbKa9+Im7nb8O8cB+upwci7x1HmU/SKel21IIHS7My?=
 =?us-ascii?Q?lVO2zknYT2x0rYnpLqPeoaE=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b32c407-a310-4cad-2126-08dbb0599968
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:51:47.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp+9w9IWbJs7/MCeNsybNT4HVTyleJyHM9F0CJwxDlUcuQtFn80X8NIx1Cnf233zgQfGoGoCNW1u8EVj2tkwrd4Ty+ymbv0bqisk3ZneWLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10059

We implement rt signals to handle exceptions in rt stage.

This is done using dovetail specific functions for setting up the signal
frame.

This can be used to handle fpe exceptions on the fly, like fixing
division by zero. An other use case are breakpoints, implemented using the
illegal opcode exception. The real time handling of the breakpoints would
be handy for conditional breakpoints or also for stopping watchdogs and
other tasks in time.

Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
---
 include/cobalt/kernel/ppd.h                   |  3 ++
 include/cobalt/kernel/thread.h                |  2 +
 include/cobalt/signal.h                       |  2 +
 include/cobalt/uapi/syscall.h                 |  2 +
 kernel/cobalt/arch/x86/Makefile               |  2 +-
 .../arch/x86/include/asm/xenomai/thread.h     |  3 ++
 kernel/cobalt/arch/x86/signal.c               | 51 +++++++++++++++++++
 kernel/cobalt/dovetail/kevents.c              |  3 ++
 kernel/cobalt/posix/syscall.c                 | 32 ++++++++++++
 kernel/cobalt/thread.c                        | 38 ++++++++++++++
 kernel/cobalt/trace/cobalt-posix.h            |  4 +-
 lib/cobalt/arch/x86/Makefile.am               |  2 +-
 lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++++++
 lib/cobalt/internal.h                         |  2 +
 lib/cobalt/signal.c                           | 13 +++++
 15 files changed, 192 insertions(+), 3 deletions(-)
 create mode 100644 kernel/cobalt/arch/x86/signal.c
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
index b79cb8429..33d468419 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -574,6 +574,8 @@ static inline void xnthread_propagate_schedparam(struct xnthread *curr)
 		__xnthread_propagate_schedparam(curr);
 }
 
+int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs);
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
index 3e65efaab..3913cc610 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -141,6 +141,8 @@
 #define sc_cobalt_timerfd_settime64		118
 #define sc_cobalt_timerfd_gettime64		119
 #define sc_cobalt_pselect64			120
+#define sc_cobalt_sigreturn			121
+#define sc_cobalt_sigaction			122
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
index 93929b645..e3d8eb476 100644
--- a/kernel/cobalt/arch/x86/Makefile
+++ b/kernel/cobalt/arch/x86/Makefile
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o smi.o c1e.o
+xenomai-y := machine.o smi.o c1e.o signal.o
 
 ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 745c32467..70f3df2f1 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -28,5 +28,8 @@
 #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
 					 ((__nr) == X86_TRAP_DB || (__nr) == X86_TRAP_BP))
 #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
+#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   long errcode, int *sig, struct kernel_siginfo *info);
 
 #endif /* !_COBALT_X86_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/x86/signal.c b/kernel/cobalt/arch/x86/signal.c
new file mode 100644
index 000000000..2e8fdc571
--- /dev/null
+++ b/kernel/cobalt/arch/x86/signal.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <cobalt/kernel/thread.h>
+
+#include <asm/sigframe.h>
+#include <asm/sighandling.h>
+#include <asm/fpu/signal.h>
+#include <asm/trapnr.h>
+
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   long errcode, int *sig, struct kernel_siginfo *info)
+{
+	switch (vector) {
+	case X86_TRAP_DE: /* divide_error */
+		*sig = SIGFPE;
+		info->si_signo = *sig;
+		info->si_errno = 0;
+		info->si_code = FPE_INTDIV;
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+	case X86_TRAP_UD: /* invalid_op */
+		*sig = SIGILL;
+		info->si_signo = *sig;
+		info->si_errno = 0;
+		info->si_code = ILL_ILLOPN;
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+	case X86_TRAP_MF:
+		*sig = SIGFPE;
+
+		info->si_signo = *sig;
+		info->si_errno = 0;
+		info->si_code = 0;
+		info->si_addr = (void __user *)regs->ip;
+		return 0;
+        case X86_TRAP_PF:
+                *sig = SIGSEGV;
+                info->si_signo = *sig;
+                info->si_errno = errcode;
+                info->si_code = 0;
+                info->si_addr = 0;
+                return 0;
+	default:
+		break;
+	}
+
+	return -ENOSYS;
+}
+
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 4da4f51b7..09eb12acb 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 		xnsched_run();
 	}
 
+	if (xnthread_handle_rt_signals(trapnr, regs) == 0)
+		return;
+
 	/*
 	 * If we experienced a trap on behalf of a shadow thread
 	 * running in primary mode, move it to the Linux domain,
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 46c4998e4..d570bd595 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -277,6 +277,38 @@ static COBALT_SYSCALL(serialdbg, current,
 	return 0;
 }
 
+static COBALT_SYSCALL(sigreturn, current, (void))
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	int ret;
+
+	ret = dovetail_restore_rt_signal_frame(regs);
+	if (ret < 0)
+		goto badframe;
+
+	return __xn_reg_rval(regs);
+
+badframe:
+	xnthread_signal(xnthread_current(), SIGSEGV, 0);
+	return -1;
+}
+
+static COBALT_SYSCALL(sigaction, current, (int sig, void __user *handler,
+		      void __user *restorer))
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
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 41804b24f..ae8fa5c88 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -25,6 +25,7 @@
 #include <linux/signal.h>
 #include <linux/pid.h>
 #include <linux/sched.h>
+#include <asm/sighandling.h>
 #include <uapi/linux/sched/types.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/timer.h>
@@ -43,6 +44,7 @@
 #include <pipeline/inband_work.h>
 #include <pipeline/sched.h>
 #include <trace/events/cobalt-core.h>
+#include "posix/process.h"
 #include "debug.h"
 
 static DECLARE_WAIT_QUEUE_HEAD(join_all);
@@ -2520,6 +2522,42 @@ int xnthread_killall(int grace, int mask)
 }
 EXPORT_SYMBOL_GPL(xnthread_killall);
 
+int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs)
+{
+	unsigned int code = xnarch_fault_code(regs);
+	unsigned int vector = trapnr;
+	struct cobalt_ppd *sys_ppd;
+	struct kernel_siginfo si;
+	struct ksignal ksig;
+	int sig, ret = 0;
+
+	code = xnarch_fault_code(regs);
+	ret = xnarch_setup_trap_info(vector, regs, code, &sig, &si);
+	if (ret || sig == 0)
+		return 1;
+
+	sys_ppd = cobalt_ppd_get(0);
+	if (sig >= _NSIG ||
+	    sys_ppd->sighand[sig] == NULL ||
+	    sys_ppd->sighand[sig] == SIG_DFL)
+		return 1;
+
+	if (sys_ppd->sigrestorer == NULL)
+		return 1;
+
+	ksig.sig = sig;
+	memcpy(&ksig.info, &si, sizeof(si));
+	ksig.ka.sa.sa_flags = SA_SIGINFO | SA_RESTORER;
+	ksig.ka.sa.sa_restorer = sys_ppd->sigrestorer;
+	ksig.ka.sa.sa_handler = sys_ppd->sighand[sig];
+
+	ret = dovetail_setup_rt_signal_frame(&ksig, regs);
+	if (ret)
+		return 1;
+
+	return 0;
+}
+
 /* Xenomai's generic personality. */
 struct xnthread_personality xenomai_personality = {
 	.name = "core",
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 47dc77e1c..8eda3bb27 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -173,7 +173,9 @@
 		__cobalt_symbolic_syscall(timer_gettime64),		\
 		__cobalt_symbolic_syscall(timerfd_settime64),		\
 		__cobalt_symbolic_syscall(timerfd_gettime64),		\
-		__cobalt_symbolic_syscall(pselect64))
+		__cobalt_symbolic_syscall(pselect64),			\
+		__cobalt_symbolic_syscall(sigreturn),			\
+		__cobalt_symbolic_syscall(sigaction))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
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
index 000000000..df961469e
--- /dev/null
+++ b/lib/cobalt/arch/x86/sigreturn.c
@@ -0,0 +1,36 @@
+#include <cobalt/uapi/syscall.h>
+#include "internal.h"
+
+extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribute__ ((visibility ("hidden")));
+
+#define TO_STR(x) #x
+
+#ifdef __x86_64__
+#define build_restorer(syscall_bit, syscall)                                   \
+	asm(".text\n"                                                          \
+	    "    .align 16\n"                                                  \
+	    "__cobalt_sigreturn:\n"                                            \
+	    "    movq $ " TO_STR(syscall_bit) ", %rax\n"                       \
+	    "    orq $ " TO_STR(syscall) ", %rax\n"                            \
+	    "    syscall")
+#endif
+
+#ifdef __i386__
+#define build_restorer(syscall_bit, syscall)                                   \
+	asm(".text\n"                                                          \
+	    "    .align 16\n"                                                  \
+	    "__cobalt_sigreturn:\n"                                            \
+	    "    movl $ " TO_STR(syscall_bit) ", %eax\n"                       \
+	    "    orl $ " TO_STR(syscall) ", %eax\n"                            \
+	    "    int  $0x80")
+#endif
+
+/*
+ * __COBALT_SYSCALL_BIT | sc_cobalt_sigreturn
+ */
+build_restorer(__COBALT_SYSCALL_BIT, sc_cobalt_sigreturn);
+
+void *cobalt_get_restorer(void)
+{
+	return &cobalt_sigreturn;
+}
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index acb3989f1..4782d154a 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -132,4 +132,6 @@ static inline bool cobalt_features_available(unsigned int feat_mask)
 	return (cobalt_features & feat_mask) == feat_mask;
 }
 
+extern void *cobalt_get_restorer(void);
+
 #endif /* _LIB_COBALT_INTERNAL_H */
diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 40d315ebb..af174d570 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -126,3 +126,16 @@ COBALT_IMPL(int, sigqueue, (pid_t pid, int sig, const union sigval value))
 
 	return 0;
 }
+
+int cobalt_rt_signal(int sig, void (*handler)(int, siginfo_t *, void *))
+{
+	int ret;
+
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sigaction, sig, handler, cobalt_get_restorer());
+	if (ret) {
+		errno = -ret;
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.25.1

