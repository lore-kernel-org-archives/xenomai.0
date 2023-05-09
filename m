Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2137.outbound.protection.outlook.com [40.107.241.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBF196
	for <xenomai@lists.linux.dev>; Tue,  9 May 2023 13:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo/6daGz2xNmVGKDSlmMWd7rSS54pxZ6Xy71fzE6hP5CcC+NDx6ef1wqtymw++TbmGDECK8LRKVEwiQ0ofUSXYI9C4oMrlPYga8CBNLv6cnWLkevs3KCtp966VR2eL8ZWWQhf4o93bCwD6jc305+xYDkgi3JLnlCYNvGZ5sqB8g1BcEZuivrYWFplgCf3H/eCGQIhb9GKi/bo7irP+YQ+FDaeLebD4oMafbRUC8g9FtTAObjMXgQFAN4VCt8i3QPYRDzq0jjDuQDDm+IAwsy93zR4UwRp139h+uWbphlDtDfJNb1Zg7rs99MU6JFmTAfbHaYXb1B5ZndAGnU7rQEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVl8d4uEuymuIsHLBr5pmPL5SiXlUR/FVo7LRbWFn10=;
 b=dCLIIOzN1Kfn6VHBbMMCPlyz2cZ8Zrn03p7u2EX5rhX8crdtfGQVDhuLrgyul9Zo9145oDou4fd/S6VkCv7cKGsthBF5B6fyepW0bmkdw3lMM6XupbahYQvHt08W9/zsZ8nzH2fUgUWtqPtJZtqnaWPOPpTBHjaKoVcyApx3DDehK9ypRU/Ejd+FhBJz6ZWidhtF2y4Op3cA84ZUyyJEVjqfzTVA5lAePZyV3W9ZfxiFR2Xgj2e1Iy5Fn6L6uBxeEw4jXdTHWpPYJZuNzarn/d8l3BNx7BSsf/q0uRvs5Vnbgmtq0tBBB8HaAyZkklUEzNzCAB++CQtHaOn9BlhwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVl8d4uEuymuIsHLBr5pmPL5SiXlUR/FVo7LRbWFn10=;
 b=M/CMrkLXUdZCAqdquIWhs7FyMS1b3ycHieSUXisfr/I4s1aZnRwVNoyKm9cm+9WSti2q2SfL2HMzMIKiGOltMrbNku0Sc94+mJegOVj4P3A3er4+i1un/R7LVVsAhpILQtJm/bUGxTZTYka6Tz1dn0co8MuDo2IIqImWXLF4gAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS8PR08MB8442.eurprd08.prod.outlook.com (2603:10a6:20b:568::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:14:28 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:14:28 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: johannes.kirchmair@sigmatek.at
Subject: [PATCH 1/3] [POC] test implementaion of rt-signals
Date: Tue,  9 May 2023 15:13:53 +0200
Message-Id: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 16f81c30-eca0-4693-8921-08db508f51b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FAD2nKiKdtkfS4iMtLQyEhviRz3TrUPvRtMY+Vt0UEHmQoJxmjuQA35xYHYp7qnbt2jPNjvw067cUYG3q+mYr/Nhg9nUQzJdVQwrvZwZaSJjrGFAu07W0Eu+ISdboKUmEQiaxrvaFFuQnc2m2LkmxWgkXgss06NJYCBqE4AMmY9WfenyutVMiI8YLIUj/z/WGdPD60LYg/nSicp8GJ9Y7K+FmkDWL1RSZ89oZZ/1QuBk8esLXIcLZSPQmcitQU2Vc9Wq6P4p/fWtojjt7m21IMnzTjJopbJ/vCVKpUH2s4zShtauy6J3K5C92yjBbKl2+LXXNB9G02YSeuKFDW6UzB732YDZgI0ohLIZp0gHy1sXPJDLCdkNO4I2VNXf0SiQGwI7ujz9WSNnyPWVvofBNyFq5Nm/qLL9VKdPK6U9wHs9ntgQ4oUoGkqFKxQE/JgOPc/8QPJoQ/OR0Ocf8lUkaA7VG+QeENRnBAzoPI8Hur7mBbaG9z3tXwwq4gWq41qMx7b+wBtmXtpL3kG6g/qzeNRBCA885nhs2U63HnHn2hXVWitQPynpEyzqeGrUfeKOB5NbrXxlmvOaHHrVKE66Pmd5+wdIx5hWzrDRZ66Jh9BUTSdRrMzpvQ3ZFiNwtoX2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199021)(8676002)(44832011)(8936002)(5660300002)(41300700001)(316002)(6916009)(4326008)(30864003)(83380400001)(107886003)(2906002)(86362001)(66946007)(66476007)(66556008)(26005)(1076003)(36756003)(186003)(52116002)(6486002)(6666004)(478600001)(38350700002)(38100700002)(2616005)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDAKoD92NIxax8TIs7pel/LWIQ2xEQa75Ac7WLT/E1ly2oCCGOdLChNtGKqc?=
 =?us-ascii?Q?T191bEFJWEuttjl+B/pJuDZbEZHP4fwNY0jM2yfYJ7mkBWIRsg/YuoqBWkzT?=
 =?us-ascii?Q?Pws2M8CBjl0jW9vbzihUYe8AVgKEVXcKXz8M+E18L08da1gPI2R96d+JbjFR?=
 =?us-ascii?Q?sNiEyAR7Njj3LnmwTBQ6pYyGvSrOToi2qQtdoOk5bMbkG+PDx/JrXmirP260?=
 =?us-ascii?Q?n7lCdbz/tMc/lLgXsYBo1G6ZwsAxzPI0NnErbDRAWOlH2Y/7CjKph/XVFfO6?=
 =?us-ascii?Q?Kv4Yc2F5om6OUAmVScPlyUgMFUJhM/KCxjhQiTEaagnPPagRmpjKhAdruJNj?=
 =?us-ascii?Q?jmryAxGD60urhA4lugNMzYPMh99pkJx+R25z9NZFcV+I6nhbuZRBX4iUwQNi?=
 =?us-ascii?Q?yvGLSbYyRFkfUjLsFJpQR1PMEMvBCHz7Jx/ky8Tcug+eK2EWxHMl9RmQTOUf?=
 =?us-ascii?Q?5a2gzCL0V+Q4/YmZ0uphpyk7roWeU9FwRT+n1p0USqxsFRCW8aRZtCDVVS3W?=
 =?us-ascii?Q?0r/rZgVUC0DrzO8cwgLC/fnBDw4DIlGsFAEDFmVR3pBFjGeHdtQNr1x1ZYaV?=
 =?us-ascii?Q?2CKNQV73yJdVCai1NcEmoSSbQ+lyfuiCxIXqm/KnEzjARXWRjvFUTnO9fL+r?=
 =?us-ascii?Q?r17KKWetwwRgNZRrU2LwUywdUtzstyLi9omDO4hM/G7Ytg5KS6IdRrcmnW4t?=
 =?us-ascii?Q?BkUHZIyrNAXxNDp+yEVaQkGDTN3FEYOdft7C9PeeO6vX7C+n96Hb+L9aAD1D?=
 =?us-ascii?Q?Iyo9KaFiEkPpliMLnOs9PJX7PQUkq+eMqjpD+O+3huZ4IKh7ZTOJ/NIN/uC5?=
 =?us-ascii?Q?iHbAKYM00GNi0pp+kstL90fGUK8KUiG4Tsl8MIFgLGdyoJReP+ZDkKXYLZVv?=
 =?us-ascii?Q?QIIlVl71wsl/t/7rwPGzotlE4js4nX7zpxICvt5r/vrZcNOYgQduHam3JwdR?=
 =?us-ascii?Q?L/D92Ox1vi/KAe2LpYJzo1mc/YMLgHZ6LKyU44O53LNPzATw16ksZlE7hh7s?=
 =?us-ascii?Q?p/UT6YRpgjYaUuQ24oJI5HqHh3qoRuOwYaTpfk2MOMlzMfxvJSDcIJl64+dn?=
 =?us-ascii?Q?aMifm4lKbK4HwPJmXA5OtKJy5j+M3OibHHjZKnXveHJupGUOx8ISHu0Fvv+Q?=
 =?us-ascii?Q?keVDwGAnIOoLzHvIHfWsnr/kUcVj6quV38ahJxm4a4Yf0c8qeB/9TPylVBNV?=
 =?us-ascii?Q?8WqKRBANn1u///fQnN0jCluySymMiZBRyqQYOGqOitlQzQV0HdwS3W3epIYk?=
 =?us-ascii?Q?OOjXNlAEVvMIELZRypXaTXF2Kk7MH91oOC3GE/dy/qf2wPk/qv9krv8yrw22?=
 =?us-ascii?Q?uVx0xkMoIxp+/x0+xv1tUMDZ6LPbqCQkBMUvVM5umxWJQqrydkqTwKGrz6a2?=
 =?us-ascii?Q?9LCy/duLVXsKru6gs/OLF0lCn5B6sg/RXr2NrBHl4UHGhavUBWUAVM1Nec8u?=
 =?us-ascii?Q?SKi1b71mJRNuDNorP/pY7pJJKLIEgwM/qdaZuOmPltQN+EdilmKrOz7wMGVx?=
 =?us-ascii?Q?YZZrVnx3Mcl8SnGKLNF3Wsg5ME3F0Wglh3CelUwo6zC5sfSVgrxJyVbVXHIE?=
 =?us-ascii?Q?K2Nb7pOIblPBjGATDTA2hoHNMOPBqt66EY182Xtc8iWBnNqUjE0Wui81RObI?=
 =?us-ascii?Q?txaepKTNhMsGvE4O5rnPeCM=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f81c30-eca0-4693-8921-08db508f51b5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:14:28.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mot89auDq786PNH2R4xCFdkxdN9zemhj8JswxGKn2Ny9G5jmRPHYw8L4/z1KfCf97KKhHGLrU02WTtzqWLfwQzdXsLAC5L27myfKCjT/h4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8442

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
 include/cobalt/kernel/ppd.h                   |  3 +
 include/cobalt/kernel/thread.h                |  2 +
 include/cobalt/signal.h                       |  2 +
 include/cobalt/uapi/syscall.h                 |  6 ++
 kernel/cobalt/arch/x86/Makefile               |  2 +-
 .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
 kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
 kernel/cobalt/arch/x86/signal_ia64.c          | 26 +++++++
 kernel/cobalt/dovetail/kevents.c              |  5 ++
 kernel/cobalt/posix/process.c                 |  3 +-
 kernel/cobalt/posix/syscall.c                 | 28 +++++++
 kernel/cobalt/posix/syscall32.c               | 16 ++++
 kernel/cobalt/thread.c                        | 39 ++++++++++
 lib/cobalt/arch/x86/Makefile.am               |  2 +-
 lib/cobalt/arch/x86/sigreturn.c               | 32 ++++++++
 lib/cobalt/internal.h                         |  2 +
 lib/cobalt/signal.c                           | 13 ++++
 17 files changed, 266 insertions(+), 3 deletions(-)
 create mode 100644 kernel/cobalt/arch/x86/signal_ia32.c
 create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c
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
index 9646a0d97..6307fae7f 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -137,6 +137,12 @@
 #define sc_cobalt_recvmmsg64			114
 #define sc_cobalt_cond_wait_prologue64		115
 
+/*
+ * Sigmatek specific syscalls
+ */
+#define sc_cobalt_sigreturn			120
+#define sc_cobalt_sigaction			121
+
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
 #endif /* !_COBALT_UAPI_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
index 93929b645..e725afbff 100644
--- a/kernel/cobalt/arch/x86/Makefile
+++ b/kernel/cobalt/arch/x86/Makefile
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o smi.o c1e.o
+xenomai-y := machine.o smi.o c1e.o signal_ia32.o signal_ia64.o
 
 ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 745c32467..4d004680b 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -28,5 +28,18 @@
 #define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
 					 ((__nr) == X86_TRAP_DB || (__nr) == X86_TRAP_BP))
 #define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
+#define xnarch_fault_code(__regs)		((__regs)->orig_ax)
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   long errcode, int *sig, struct kernel_siginfo *info);
+
+int xnarch_setup_rt_frame_ia32(int sig, void *handler, struct kernel_siginfo *si,
+			  struct pt_regs *regs, void __user *restorer);
+
+int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
+
+int xnarch_setup_rt_frame_ia64(int sig, void *handler, struct kernel_siginfo *si,
+			  struct pt_regs *regs, void __user *restorer);
+
+int xnarch_rt_sigreturn_ia64(struct pt_regs *regs);
 
 #endif /* !_COBALT_X86_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/x86/signal_ia32.c b/kernel/cobalt/arch/x86/signal_ia32.c
new file mode 100644
index 000000000..e78c8c4d4
--- /dev/null
+++ b/kernel/cobalt/arch/x86/signal_ia32.c
@@ -0,0 +1,75 @@
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <cobalt/kernel/thread.h>
+
+#include <asm/sigframe.h>
+#include <asm/sighandling.h>
+#include <asm/fpu/signal.h>
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
+int xnarch_rt_sigreturn_ia32(struct pt_regs *regs)
+{
+	int ret;
+
+	ret = dovetail_restore_rt_signal_frame(regs);
+	if (ret < 0)
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	xnthread_call_mayday(xnthread_current(), SIGKILL);
+	return -1;
+}
+
diff --git a/kernel/cobalt/arch/x86/signal_ia64.c b/kernel/cobalt/arch/x86/signal_ia64.c
new file mode 100644
index 000000000..a7044db40
--- /dev/null
+++ b/kernel/cobalt/arch/x86/signal_ia64.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
+ *
+ *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
+ *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
+ *  2000-2002   x86-64 support by Andi Kleen
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <cobalt/kernel/thread.h>
+
+#include <asm/sigframe.h>
+#include <asm/sighandling.h>
+#include <asm/fpu/signal.h>
+
+int xnarch_rt_sigreturn_ia64(struct pt_regs *regs)
+{
+	return dovetail_restore_rt_signal_frame(regs);
+}
+
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 4da4f51b7..61417717b 100644
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
@@ -88,6 +91,8 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 		xnstat_counter_inc(&thread->stat.pf);
 
 	xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAULT);
+
+	return;
 }
 
 static inline int handle_setaffinity_event(struct dovetail_migration_data *d)
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 1abc86f37..2069129cb 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -738,9 +738,10 @@ void cobalt_unregister_debugged_thread(struct xnthread *thread)
 		cobalt_resume_debugged_process(process);
 }
 
+#ifdef CONFIG_SMP
+
 int cobalt_handle_setaffinity_event(struct task_struct *task)
 {
-#ifdef CONFIG_SMP
 	struct xnthread *thread;
 	spl_t s;
 
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 46c4998e4..b4bd4c587 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -277,6 +277,34 @@ static COBALT_SYSCALL(serialdbg, current,
 	return 0;
 }
 
+static COBALT_SYSCALL(sigreturn, current, (void))
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	if (regs->cs == __USER_CS)
+		xnarch_rt_sigreturn_ia64(regs);
+	if (regs->cs == __USER32_CS)
+		xnarch_rt_sigreturn_ia32(regs);
+
+	return __xn_reg_rval(regs);
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
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index b65a0a760..f8b21bfb2 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -774,6 +774,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
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
 		     int event, const struct old_timespec32 __user *u_ts,
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 41804b24f..71f97c481 100644
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
@@ -2520,6 +2522,43 @@ int xnthread_killall(int grace, int mask)
 }
 EXPORT_SYMBOL_GPL(xnthread_killall);
 
+int xnthread_handle_rt_signals(unsigned int trapnr, struct pt_regs *regs)
+{
+	struct ksignal ksig;
+
+	unsigned int vector = trapnr;
+	unsigned int code = xnarch_fault_code(regs);
+	struct cobalt_ppd *sys_ppd;
+	int sig, ret = 0;
+	struct kernel_siginfo si;
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
index 000000000..76292e145
--- /dev/null
+++ b/lib/cobalt/arch/x86/sigreturn.c
@@ -0,0 +1,32 @@
+#include <cobalt/uapi/syscall.h>
+#include "internal.h"
+
+extern void cobalt_sigreturn (void) asm ("__cobalt_sigreturn") __attribute__ ((visibility ("hidden")));
+
+#ifdef __x86_64__
+#define build_restorer(syscall_number)                                         \
+	asm(".text\n"                                                          \
+	    "    .align 16\n"                                                  \
+	    "__cobalt_sigreturn:\n"                                            \
+	    "    movq $ " #syscall_number ", %rax\n"                           \
+	    "    syscall")
+#endif
+
+#ifdef __i386__
+#define build_restorer(syscall_number)                                         \
+	asm(".text\n"                                                          \
+	    "    .align 16\n"                                                  \
+	    "__cobalt_sigreturn:\n"                                            \
+	    "    movl $ " #syscall_number ", %eax\n"                           \
+	    "    int  $0x80")
+#endif
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

