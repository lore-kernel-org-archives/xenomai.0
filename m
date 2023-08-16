Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2096.outbound.protection.outlook.com [40.107.241.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6FD2EE
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 10:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvcHkdCUs9It6JLdk4/t1fkfpcNJ7hdzCXDhV0a9+Yx3pgwV0yQSxS2x9BLDYluGmCSsMpHeHhUGMj4seyLdna8h5DTQK5RRNmVbwcW0kevg0Eo3SLYaJSdp3ZdNn2AB2gfhTc+bTwyNJ8rvK57TVyoGt9ogjxAoCOVBXzs0sU/U7f61JjmdCnL9HL2dUU3eqNcE2L5vabfEgy41rK9fI+yU53qHUQYlFg04Bv7cJ3jaYhiLwh8gEEkiXz/lZp95SlvonxOvTk0ZflRQNGjbcCV3IP93SqrIYwgTxejEMfrMQC5zxDRODMySKwEjKdKfLdQqhaPqRhZl5dHHc6N3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dICNxZgnq6W2fhmsvaBuXVz4JDmzcQAOGJo/GB4VnrA=;
 b=QsKzSWBN9MMX0+mxKJdoraxHR4NDKjK1oYsHUOz9JOhcyHnWrNHz+DO/uVhf8JrfQfsYN6d5xlcO//xLPIA+q4i3+axo6wOwugw5dCVNkGIaTWDswxl/69bDViiibfc3+qSuiNGIxABsYrGmeeSH8GdmebxcFoRkZ0NS4pwuzWSD+MukESCD567YE2IVV3BbFN1/onPQSDuT3WY9DJvnWHYM+gvpo2+UNCC7d2g0YgkcKk0xlWNvgW4xp78gZS42brEhPfH7rZzj6/j2nflDMYT8ocG5KqV8B9tl47jHyIP/tSQGpPsX9ldMh7+YdlhVlXK1Za1Z7a9dU4Q/RIRb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dICNxZgnq6W2fhmsvaBuXVz4JDmzcQAOGJo/GB4VnrA=;
 b=eM7lCoAjKfm5qd5eJ+eQR8Ws49MaMTI9Vwa+r16lu9Orku2nwQIvUl+P9eOJLiXd05f859rgR3rTj0UpE19QjmII+GytJ3OptRzSzz9ntsVgbe57lC0aqoPZsNRRCjOgHnziMLTfKLDc0TjmO6f9YL6miGsjeq4RvODfE6lR1fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:19:42 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470%7]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 10:19:40 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 1/3] [POC] test implementaion of rt-signals
Date: Wed, 16 Aug 2023 12:18:40 +0200
Message-Id: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 06832e4b-d8cc-4ddb-6d76-08db9e424d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DilXqPzZJcWoiHcOFdh50I/c6i3wfBGHGbSL8TZJUABifcI25v/ZdwdO1I/xOjJcnznYXfrXyBft066lbmi2C3EjN1ilI2HteXVwb5q3H8NKJlDH4mv/zZX2HAdz23uOKeWNDpCnaTKJzeuMRpH8PmfzYv6wZVg/RCN99odLZVBw9IrRPPxcqn5yNtM13aYUiNG1g3iYOGXlfwjACZOCH8j72stvpTlZCFCToOnmSGPL5t+6UDt3mdJyfjh2iBDnAVsTzPwfPkTnLnAuPKcDtdkDInfT+2zJ4Bbzd31PiAyVj7b9AXJ417qMmjG0NZdqPgpw/0CkoolYlm1RxKWn+YwDaek5K+56ol3+8egONH82LX+pcuAMUEDA14seaDPEg7P/excM+ekrznwvBW2cIwUm89oveJtyNhhB77kOJhfC2LTkEyuEqLr4uFPP+P9s8aLACv8PJClZ+vzt9wUuN4KyXUeyIq0WyVHFvOj+CYjI9Q3GdcAPv4QOHfSJWM6ew141O+bs065YxgdE7IeSFsy0k5Y4+oMS17RF0l2bNV08QqpSgVWqQe7dT6Yw4RSvV/1TGLKk7nKIdpYPtrWpHCclRNh+pzmxs4VKhQlIo1yK3Tc9ikAqFUD54ui14iRa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39840400004)(1800799009)(451199024)(186009)(2906002)(30864003)(83380400001)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(1076003)(107886003)(52116002)(6512007)(26005)(5660300002)(44832011)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3AsrUWvKzrGv4M2LAmmQkEiN30ShxtukuZZIFcbsKZKefKBxwSG/DwpCKHCq?=
 =?us-ascii?Q?sl5Nt/dV5tX19g277KJ7WejrPxCjScu9GILVbQpcrMVu/FzFrtH9T8eQjyvQ?=
 =?us-ascii?Q?+BzMGu2Uf5g4AdV8OUdgdloXMqy0nfhRLxVO6l4945LlN0pyt4Fh5Nu0btxz?=
 =?us-ascii?Q?/UBOujDlCZai6mtvmqheSyN5WE9DG5LOLc8A7qHWWpSD/xsaFIHzXHsPxG7P?=
 =?us-ascii?Q?jVtAhFuAKqyEg0HHgolIULL02zC79jYS3lW3asRHKI2qxj8Uq0ukPOJKu02e?=
 =?us-ascii?Q?zLQjhqD0nyC29maXiCgcoRtWyrqR3uKBrpiAd6M+1Rcp6FaNcUn2yaRBkkd7?=
 =?us-ascii?Q?EKsToLb7agtsqU4aLI5/RqeQ/FkTBE9ssbCfiszVTETIuK6f1LApVY1kW72Y?=
 =?us-ascii?Q?4q0tkG1FCNpIddgdhgynpz3GkW5I6wzEtnHMgQFH+w6sM0fIw8P9ETKUxYqP?=
 =?us-ascii?Q?BrOVKu0wqf+5/Sxt4nVv1LUYU0qEuJ3TK2WIYxgeU69+9PuZ6qFJTah4QHfg?=
 =?us-ascii?Q?hhdC5n/553+oMlV6oqUKSVUyBcD4j/WjC34Tv8vB5IIVawSO13IHLpfel23E?=
 =?us-ascii?Q?6wQgfWsc0ya2DjzBRJjPtLCVNB/588BxIId4RIr0dDGzq2RWPaslibJ49HAy?=
 =?us-ascii?Q?UfYVtbpVLlMsqyUEyZgi3k065A+A/zD50Zq2+lSteaaRMRdzP6qNXx6ePDhr?=
 =?us-ascii?Q?wVVnq7FBY0C1iOhm8R51ufP0pTKnwZ0wWCVnxhQNfmApmTLSiPApSaODXyjN?=
 =?us-ascii?Q?WI3NLJtHm/YvrK/iQEZzYiAZsD4kqAEywatoqQIuSfb5fvnQJyNxy+cZ4mSA?=
 =?us-ascii?Q?KJA5vAis6gW3wGf95q9wwYUmFcZJ1yr7BfRUbu8vFi/Jcm3nedkaBpeAM/AG?=
 =?us-ascii?Q?zTEAhwTudLDH7/emNfVEYC0kz19Ql0++Y7N7si1h0GT/t1zfs4dy8qIIIgk8?=
 =?us-ascii?Q?7coM6b4/J60qncjnaTXJsjlxcRUIQ2iRER82sFHJwjQS0SR2b6QbXWwtEr6/?=
 =?us-ascii?Q?cG1x4DZWAILUMt/DtDa6FIvw2Wmd6iPsImQtesM7tyGCoGqjGw5fHCmBU5Ek?=
 =?us-ascii?Q?LuEVaXQZsVO6aGKeyn7AtfL7TyC5hIzVRh7zOzwOVYjhySsWkT8ngMH9SZRC?=
 =?us-ascii?Q?bKdZsabMlgyp67uUfo2o3a3F1S7a+jKYWgszbnVKWysgXzqP/NUqra3YZQB2?=
 =?us-ascii?Q?nNPjkfW0cCo/FKt6lzKosXaSsCOUZcX+ASjtvUZkibui7oCIqoZcmbo9X7v/?=
 =?us-ascii?Q?BT6ppDZHFejGuh+5y5JukL2MDdy8zH6sjlkoBlCs6Kg/uS/l4vbMdh/xM4uD?=
 =?us-ascii?Q?GKhBGuoo/7C1ELBui64m+zT2p1Qt0jykA3SJBfARt32faaYfwOmQGsPxaOV2?=
 =?us-ascii?Q?W19IHP2WjbZY6ayXMkkcBlk3xAq2Zmh1fun6ue0GKf1wFgNzOt1wXP5S6WtI?=
 =?us-ascii?Q?e6ahgPANqjjk4vqSBcR/qH2oj3shQvVh25tZyZLYSpFkumDdV1gsCpC9Vb7i?=
 =?us-ascii?Q?KAl2HdvkincLbiHsbTZ3cPBfK/fpHhB9cv6IWkX5ngNtroRac+5u5iZSLxuZ?=
 =?us-ascii?Q?Eay7LHShf/bFPMVPD2gLRirtImqOOP7pQ6o4isLgWMGqXkT0saARw5Tt47GX?=
 =?us-ascii?Q?FH7ijf8gh4xW8AsJLt9oM7E=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 06832e4b-d8cc-4ddb-6d76-08db9e424d26
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:19:40.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qnruyyKx8SRbOZvMkzMkWs28GGqXg93OVqn556xkOu2bvHOIcrBeM66VbAfAO3DjOEuF+UlWu8/z4rV7Mzw5Th6pgWKrszqI9cKTGz9S3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496

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
 include/cobalt/uapi/signal.h                  |  1 +
 include/cobalt/uapi/syscall.h                 |  6 ++
 kernel/cobalt/arch/x86/Makefile               |  2 +-
 .../arch/x86/include/asm/xenomai/thread.h     | 13 ++++
 kernel/cobalt/arch/x86/signal_ia32.c          | 75 +++++++++++++++++++
 kernel/cobalt/arch/x86/signal_ia64.c          | 37 +++++++++
 kernel/cobalt/dovetail/kevents.c              |  5 ++
 kernel/cobalt/posix/process.c                 |  3 +-
 kernel/cobalt/posix/syscall.c                 | 28 +++++++
 kernel/cobalt/posix/syscall32.c               | 16 ++++
 kernel/cobalt/thread.c                        | 39 ++++++++++
 lib/cobalt/arch/x86/Makefile.am               |  2 +-
 lib/cobalt/arch/x86/sigreturn.c               | 36 +++++++++
 lib/cobalt/internal.h                         |  2 +
 lib/cobalt/signal.c                           | 13 ++++
 18 files changed, 282 insertions(+), 3 deletions(-)
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
diff --git a/include/cobalt/uapi/signal.h b/include/cobalt/uapi/signal.h
index 8a7ea15a4..1afb6050a 100644
--- a/include/cobalt/uapi/signal.h
+++ b/include/cobalt/uapi/signal.h
@@ -68,6 +68,7 @@
 #define SIGDEBUG_RESCNT_IMBALANCE	7
 #define SIGDEBUG_LOCK_BREAK		8
 #define SIGDEBUG_MUTEX_SLEEP		9
+#define SIGDEBUG_SIGRESTOR		10
 
 #define COBALT_DELAYMAX			2147483647U
 
diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 3e65efaab..f14bd8ffe 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -142,6 +142,12 @@
 #define sc_cobalt_timerfd_gettime64		119
 #define sc_cobalt_pselect64			120
 
+/*
+ * Sigmatek specific syscalls
+ */
+#define sc_cobalt_sigreturn			121
+#define sc_cobalt_sigaction			122
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
index 000000000..140016460
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
+	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
+	return -1;
+}
+
diff --git a/kernel/cobalt/arch/x86/signal_ia64.c b/kernel/cobalt/arch/x86/signal_ia64.c
new file mode 100644
index 000000000..3b8cd3330
--- /dev/null
+++ b/kernel/cobalt/arch/x86/signal_ia64.c
@@ -0,0 +1,37 @@
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
+	int ret;
+
+	ret = dovetail_restore_rt_signal_frame(regs);
+	if (ret < 0)
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	xnthread_call_mayday(xnthread_current(), SIGDEBUG_SIGRESTOR);
+	return -1;
+
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
index 780d276b1..7c858f904 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -705,6 +705,22 @@ COBALT_SYSCALL32emu(sigqueue, conforming,
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

