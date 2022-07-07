Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820F2111
	for <xenomai@lists.linux.dev>; Thu,  7 Jul 2022 14:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd+octBN5c1AygT5duMlLq0VNd5OYyPnMU9zhqCH4h+DH3E5Pom8hSC717PC+92b+iBtQTKiFbGUrbTu+66olOBxspr+vKhJc2/LgQa0Yy5Dpl35JHk3tFemEwjRf+8G3vMGH5o3gpkUOkd7rSiE8vQ1Cf+bBoQobfJVPPARGse7ftrzqJz3+6/b3OhG3A04lZ9d3bP4rZkNVJ8aC+uQ1LJa4lqL/bOKqsmEtpIJQDhCHsL/c59hWpgc9PLdI9F2482Jjva9bF/tEUQEIbfg2LMYHMquyC0E1IWVXyPDUjZUqms1hyYj4W02cELY84QtCT6cUEdOhO6Zib1w0xEg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icJHgR5IC/41Xk1o/GmP6318fPsx9Z6bhoxq7odZp4k=;
 b=lQfkoqINKG5pRUx13UBHLzxVaIGafTsVLJ2J89df5O3SrC/L8HfywdKgwXGUkgvu4fgwFbx0WePDAGb3l7Z+HUWDF45WKtgvFXcsqeIl0oSmlc5ykV4zKH0WOGs+CFjKw0UknxSo7loyjDJg0NIAZuRwAyZISB4ypfhb1LtQ0Qt9jrsStsXn/muBtf/vQU25VFaQsWx6tefshLzcQX3xJBSWZVOZPDhryIYEypIcTY8kFKtWTtDAbl08kJwMU9QRIaejGh5O5QJwxKYFhgKwVqAf9wnoetDzxlOTDLyLCoBAQImjCf3Cer5NXW7rbmijKDbx0pfOWbyB3GUr3ZR3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icJHgR5IC/41Xk1o/GmP6318fPsx9Z6bhoxq7odZp4k=;
 b=Nw8y0VrWe6VRRGu9KDBfm0zOlwmQa68f89QjzlENPbIYTCU+rfV3rwlhTV/xQ/VRCy0MdiGG9+76P7qXEJBRulBkUIFGmV3ROhjmUiz+sCen9TCXD2o3ebS/O9ZR+U4iC3bT2/xF9tD7WyhqNTRCF5XPJOBcsdqRcbDhos8L3Aw=
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
 14:00:05 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Subject: [PATCH 2/3] rtsignals: add i64 signal handling
Date: Thu,  7 Jul 2022 15:59:51 +0200
Message-Id: <20220707135952.5171-3-johannes.kirchmair@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: 0ef1833c-968e-41a2-8c3f-08da6020fe92
X-MS-TrafficTypeDiagnostic: AM8PR08MB5730:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fNg/E1CWI0JhyIyFG+74fHAdz4zsHCUv+vKuH3fOtDLMZ6bWp3Rqko5vG2xhJQXkvY1AbOhyCUhbSCTNwWYI2lUBpWqWWUW5KD4W++hB6nJYKbBF1xEPWbFR/gBdofFWB9JE97tOUx8GoIflrmD2aRtEUBXeXnaGhX+nc59n4/XvoySCy9NpxLNAiLZyagVTbP7hUxk2Fo6jJfoTg5rgmrMYUZk3HB8DpjjFAijvbV+GMA6qcmiSIph9eMSbSaieSW4bLKA4MfF5wwOZDd7c28/n34j4DZEVLgr2tTnMkHyEK/U7y1GmYUg8zRRiD/4n5ywzvox1GJ2SDm4zlBxrVoWjrTAjP3+M4k0nGZk3AVbgHs2hyilVASi2LzN58Z0kbkypEnaT54N6ruwPN8tsGMdejINxwzWDOGF1+4kW+dT4JPGVq0/174X5TrD4wX0vIIHOCJzz9W/ooH01KmsSSzUHpuXttQeh7LyPegAuEq+jvSLVX+jhYRH0dR7aFiSNqB8p2bD+DSzahZv0igPidCRVFd0eT+5xeLcb6XTzz4cX2MDnd/jr+iU/HIbKRfKOW4ShDuyYxC4LTsrYcfq7yQXTS2S16o8B2Mzkusgm1RgP128zq0w+PVDk7vJ0uLWfA92/1C8V/2ki9IV3S+QuoJWXNKDFvKLNizG1VIZnPwik4i3zP5YI6c0MiZ6N7LR+kkYLPUUfCEPSf0vTZo8DznTiMckKhaK3BenjesxaVU6t0NVkWmYf8dyQp8R6TSoyws86XmajZjr9WhWdmFNfC664+gETFmRVigv08tf1YaCRBGp5g8+WLFKcnzp1LuYU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39850400004)(6666004)(38350700002)(38100700002)(478600001)(6486002)(2616005)(1076003)(186003)(2906002)(41300700001)(66556008)(52116002)(36756003)(6506007)(6916009)(8936002)(5660300002)(8676002)(26005)(86362001)(316002)(30864003)(44832011)(66946007)(83380400001)(66476007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c0CDUtOfkWvfuL5y2huwu4tG41Cx99CnhqZFPuLBVnXLLEd3Zsc4hZsNP4AB?=
 =?us-ascii?Q?CAGDNEsxURBgeN+eeG4HfAYbwohXtmgAgzI6Mpv0U7zDC+fxHjPxwHUYI+EC?=
 =?us-ascii?Q?L8xG0j3bfHeOOBK29Gu0nhOrVcCJKqBZJnwKXRdpBmYtfb4Sho4Df68IC5mi?=
 =?us-ascii?Q?mKv6PGGXnUTBubeXKl2WAXoab+v/ieIbhTlGHGvyRprRD+eetcvH0NShqRVl?=
 =?us-ascii?Q?9200kM07pJNI//NTJpie3VQ0JrUp6Lgk9mqxv/eiUwslopMY4MNSBh5ldAxS?=
 =?us-ascii?Q?UWV7cozPL/D72+mKL0OuBV9kwKwKZnD7CGJ2HNEVLKwADJPQcXQRzptMH5m+?=
 =?us-ascii?Q?240Uze0JYevgrSyH+XIYcj3FjR7ek8BMyxvRZCnhYxhSKs/L7b1N1Fsi4d+L?=
 =?us-ascii?Q?+4iNBFeEnvC4Jgu4KjS8pQXAjUS3WaWlw3jYrZIezYdT2IXtBm1nOQDKjGjc?=
 =?us-ascii?Q?jNNCtyVdsG9LUkcBy4Dn/VCuVUbHbymsuhDLbFd9lrSsCrDi6kOB/ydstyuW?=
 =?us-ascii?Q?/g5cYn5fK2V05xglb7itYM7ugqywZL0lYM+r1TPElCEseiJOmT3g9xJ2Jkmv?=
 =?us-ascii?Q?y9mj19hxmWntjseDO6waYlPGvdeHkevvMYi2aPYns1lsKkAAXg0qUkQKQh0Q?=
 =?us-ascii?Q?IKTnNhtCrEMfxNvFM67UaK3nHZ0rNbjyfO0gMgAivHlgMqgI5fKK1Y6rNnAS?=
 =?us-ascii?Q?lDtVLHRkoyUj1AtIxfo+L0T6mxN0Wa93ahqyYKFkkHjQoCq5P+LExhFs9uSf?=
 =?us-ascii?Q?L7KL4PJuNTYe0T2rC8pUiQR5W77GCsWx0do+Qds3O/YyJhWMm1QsNh7bdPGw?=
 =?us-ascii?Q?GpKCMzgAZDrQH0Zcr3jKDs2jaY9aBu8t1oPX8YrIUvcRX9GAmd1EwwZNjj1e?=
 =?us-ascii?Q?x0RQdicN0A0rPcrwf4e7VuZQ84G8IjTHY8s5cdmuWVBbWXkizvrevE+AOyCq?=
 =?us-ascii?Q?QoBTstdZ/pQKCBFMX8yAZMCJerA9rYnpS8BxjJhnrJb6zKkuvUZ0dLRCR4Zv?=
 =?us-ascii?Q?zrWXXX1w/s8OAIi2UOJWkxdPKuZLdHvW+DmYhLpoy9FokKNe/MaLn/Txizzm?=
 =?us-ascii?Q?0NoP4Yj6JzcwXIesNlnZNiPtVHh7U25B+hXQH/6tvVs/JTjnjnWPP6mVY75e?=
 =?us-ascii?Q?Lkm2OU/MCJezE6TZk2quBpYpYZQoGNQcYjk0M4zcTwv+lBQW/IsROYpu4Czo?=
 =?us-ascii?Q?PPF51X/NgO7Wuh7uUbpDl/yx/lts3H256pZw7dorUE8nTb+NzlKQgiae6YF9?=
 =?us-ascii?Q?MLnY8bhgjlX5juaeDO2tqSU1n0NxuqU0bsnW15lTOoXYpiBZHK1uTmzL1oEu?=
 =?us-ascii?Q?5rLk4A8KREffCKkEB8g0D+ce9m2xHXs2hWD7aBS6UqYulA72DTSSmCC+cDdp?=
 =?us-ascii?Q?bXP6vn4PJOTuoEDlGY3HwVc2K8eW0Ui9qRmpLVw943KsbevkID11+pziwe/j?=
 =?us-ascii?Q?57hkQQ91iLaAg1PiqkIe4BP/vb4yxqUXHFiD4MSv+ntg2O82eZKNNpGdlWrJ?=
 =?us-ascii?Q?NZPZ7ZxCkcjoxrxrJVrwbeif8CpUG8YvhnkOXel2clPhDytU+JY9JTk754Tw?=
 =?us-ascii?Q?1PzQVvnNbRWap/AU1mnM0nfki2Mzw79Be5fserEqFKTSjDbe9mt+7JjkeMM+?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef1833c-968e-41a2-8c3f-08da6020fe92
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:00:05.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5E72hUb7fpYCzDy1xqCVUEsxYee/0mMd+jsMygpDqAlbtF3tIXqPzfdoIThkYQ6pDP3xELW8MqgR2FpM/uaC/PsWwr7zH2zoP2ViFwbOYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5730

Adds code for implementing signals that are handled in the real time
domain. This is done for 64bit processes.

It works in a similar way to signals in the Linux kernel.
---
 kernel/cobalt/arch/x86/Makefile               |   2 +-
 .../arch/x86/include/asm/xenomai/thread.h     |   6 +
 kernel/cobalt/arch/x86/signal_ia64.c          | 283 ++++++++++++++++++
 kernel/cobalt/posix/syscall.c                 |   5 +-
 kernel/cobalt/thread.c                        |  10 +-
 5 files changed, 302 insertions(+), 4 deletions(-)
 create mode 100644 kernel/cobalt/arch/x86/signal_ia64.c

diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
index 6bbf15651..bf58998cc 100644
--- a/kernel/cobalt/arch/x86/Makefile
+++ b/kernel/cobalt/arch/x86/Makefile
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o thread.o smi.o c1e.o signal_ia32.o
+xenomai-y := machine.o thread.o smi.o c1e.o signal_ia32.o signal_ia64.o
 
 ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index be93926a7..2505021c6 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -86,6 +86,12 @@ int xnarch_setup_rt_frame_ia32(int sig, void *handler,
 
 int xnarch_rt_sigreturn_ia32(struct pt_regs *regs);
 
+int xnarch_setup_rt_frame_ia64(int sig, void *handler,
+			       struct kernel_siginfo *si, struct pt_regs *regs,
+			       void __user *restorer);
+
+int xnarch_rt_sigreturn_ia64(struct pt_regs *regs);
+
 static inline void xnarch_enter_root(struct xnthread *root) { }
 
 static inline int xnarch_escalate(void)
diff --git a/kernel/cobalt/arch/x86/signal_ia64.c b/kernel/cobalt/arch/x86/signal_ia64.c
new file mode 100644
index 000000000..fd986e966
--- /dev/null
+++ b/kernel/cobalt/arch/x86/signal_ia64.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
+ *
+ *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
+ *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
+ *  2000-2002   x86-64 support by Andi Kleen
+ *
+ *  2022        changes for use in xenomai by Johannes Kirchmair
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <cobalt/kernel/thread.h>
+
+#include <asm/sigframe.h>
+#include <asm/sighandling.h>
+#include <asm/fpu/signal.h>
+
+/*
+ * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
+ * alone.  Using this generally makes no sense unless
+ * user_64bit_mode(regs) would return true.
+ */
+static void force_valid_ss(struct pt_regs *regs)
+{
+	u32 ar;
+
+	asm volatile ("lar %[old_ss], %[ar]\n\t"
+		      "jz 1f\n\t"		/* If invalid: */
+		      "xorl %[ar], %[ar]\n\t"	/* set ar = 0 */
+		      "1:"
+		      : [ar] "=r" (ar)
+		      : [old_ss] "rm" ((u16)regs->ss));
+
+	/*
+	 * For a valid 64-bit user context, we need DPL 3, type
+	 * read-write data or read-write exp-down data, and S and P
+	 * set.  We can't use VERW because VERW doesn't check the
+	 * P bit.
+	 */
+	ar &= AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
+	if (ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
+	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
+		regs->ss = __USER_DS;
+}
+#define CONTEXT_COPY_SIZE offsetof(struct sigcontext, reserved1)
+
+static bool restore_sigcontext_ia64(struct pt_regs *regs,
+				    struct sigcontext __user *usc,
+				    unsigned long uc_flags)
+{
+	struct sigcontext sc;
+
+	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
+		return false;
+
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
+
+	regs->r8 = sc.r8;
+	regs->r9 = sc.r9;
+	regs->r10 = sc.r10;
+	regs->r11 = sc.r11;
+	regs->r12 = sc.r12;
+	regs->r13 = sc.r13;
+	regs->r14 = sc.r14;
+	regs->r15 = sc.r15;
+
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
+
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
+
+	/*
+	 * Fix up SS if needed for the benefit of old DOSEMU and
+	 * CRIU.
+	 */
+	force_valid_ss(regs);
+
+	return fpu__restore_sig((void __user *)sc.fpstate, 0);
+}
+
+static __always_inline int
+__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+			  struct pt_regs *regs)
+{
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
+	unsafe_put_user(regs->r8, &sc->r8, Efault);
+	unsafe_put_user(regs->r9, &sc->r9, Efault);
+	unsafe_put_user(regs->r10, &sc->r10, Efault);
+	unsafe_put_user(regs->r11, &sc->r11, Efault);
+	unsafe_put_user(regs->r12, &sc->r12, Efault);
+	unsafe_put_user(regs->r13, &sc->r13, Efault);
+	unsafe_put_user(regs->r14, &sc->r14, Efault);
+	unsafe_put_user(regs->r15, &sc->r15, Efault);
+
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->cs, &sc->cs, Efault);
+	unsafe_put_user(0, &sc->gs, Efault);
+	unsafe_put_user(0, &sc->fs, Efault);
+	unsafe_put_user(regs->ss, &sc->ss, Efault);
+
+	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
+
+	/* non-iBCS2 extensions.. */
+	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
+	return 0;
+Efault:
+	return -EFAULT;
+}
+
+#define unsafe_put_sigcontext(sc, fp, regs, label)                             \
+	do {                                                                   \
+		if (__unsafe_setup_sigcontext(sc, fp, regs))                   \
+			goto label;                                            \
+	} while (0);
+
+/*
+ * Set up a signal frame.
+ */
+
+/* x86 ABI requires 16-byte alignment */
+#define FRAME_ALIGNMENT 16UL
+
+/*
+ * Determine which stack to use..
+ */
+static unsigned long align_sigframe(unsigned long sp)
+{
+	sp = round_down(sp, FRAME_ALIGNMENT) - 8;
+	return sp;
+}
+
+static void __user *get_sigframe_ia64(struct pt_regs *regs, size_t frame_size,
+				      void __user **fpstate)
+{
+	/* Default to using normal stack */
+	unsigned long math_size = 0;
+	unsigned long sp = regs->sp;
+	unsigned long buf_fx = 0;
+
+	/* redzone */
+	if (IS_ENABLED(CONFIG_X86_64)) //TODO kirjoh ?
+		sp -= 128;
+
+	sp = fpu__alloc_mathframe(sp, 0, &buf_fx, &math_size);
+	*fpstate = (void __user *)sp;
+
+	sp = align_sigframe(sp - frame_size);
+
+	/* save i387 and extended state */
+	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx,
+				     math_size) < 0)
+		return (void __user *)-1L;
+
+	return (void __user *)sp;
+}
+
+static unsigned long frame_uc_flags_ia64(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	if (boot_cpu_has(X86_FEATURE_XSAVE))
+		flags = UC_FP_XSTATE | UC_SIGCONTEXT_SS;
+	else
+		flags = UC_SIGCONTEXT_SS;
+
+	return flags;
+}
+
+int xnarch_setup_rt_frame_ia64(int sig, void *handler,
+			       struct kernel_siginfo *si, struct pt_regs *regs,
+			       void __user *restorer)
+{
+	struct rt_sigframe __user *frame;
+	void __user *fp = NULL;
+	unsigned long uc_flags;
+
+	frame = get_sigframe_ia64(regs, sizeof(struct rt_sigframe), &fp);
+	uc_flags = frame_uc_flags_ia64(regs);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+
+	/* Set up to return from userspace.  If provided, use a stub
+	   already in userspace.  */
+	unsafe_put_user(restorer, &frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, Efault);
+	user_access_end();
+
+	if (copy_siginfo_to_user(&frame->info, si))
+		return -EFAULT;
+
+	/* Set up registers for signal handler */
+	regs->di = sig;
+	/* In case the signal handler was declared without prototypes */
+	regs->ax = 0;
+
+	/* This also works for non SA_SIGINFO handlers because they expect the
+	   next argument after the signal number on the stack. */
+	regs->si = (unsigned long)&frame->info;
+	regs->dx = (unsigned long)&frame->uc;
+	regs->ip = (unsigned long)handler;
+
+	regs->sp = (unsigned long)frame;
+
+	/*
+	 * Set up the CS and SS registers to run signal handlers in
+	 * 64-bit mode, even if the handler happens to be interrupting
+	 * 32-bit or 16-bit code.
+	 *
+	 * SS is subtle.  In 64-bit mode, we don't need any particular
+	 * SS descriptor, but we do need SS to be valid.  It's possible
+	 * that the old SS is entirely bogus -- this can happen if the
+	 * signal we're trying to deliver is #GP or #SS caused by a bad
+	 * SS value.  We also have a compatibility issue here: DOSEMU
+	 * relies on the contents of the SS register indicating the
+	 * SS value at the time of the signal, even though that code in
+	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
+	 * avoids relying on sigreturn to restore SS; instead it uses
+	 * a trampoline.)  So we do our best: if the old SS was valid,
+	 * we keep it.  Otherwise we replace it.
+	 */
+	regs->cs = __USER_CS;
+
+	if (unlikely(regs->ss != __USER_DS))
+		force_valid_ss(regs);
+
+	return 0;
+
+Efault:
+	user_access_end();
+
+	return -EFAULT;
+}
+
+int xnarch_rt_sigreturn_ia64(struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+	unsigned long uc_flags;
+
+	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+	if (!restore_sigcontext_ia64(regs, &frame->uc.uc_mcontext, uc_flags))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	// signal_fault(regs, frame, "rt_sigreturn"); //TODO kirjoh kill prozess
+	return 0;
+}
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index b63923017..ad54380fa 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -274,7 +274,10 @@ static COBALT_SYSCALL(sigreturn, current, (void))
 {
 	struct pt_regs *regs = task_pt_regs(current);
 
-	xnarch_rt_sigreturn_ia32(regs);
+	if (regs->cs == __USER_CS)
+		xnarch_rt_sigreturn_ia64(regs);
+	if (regs->cs == __USER32_CS)
+		xnarch_rt_sigreturn_ia32(regs);
 
 	return __xn_reg_rval(regs);
 }
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 34066e614..68473ac8f 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2685,8 +2685,14 @@ int xnthread_handle_rt_signals(struct ipipe_trap_data *d)
 	if (sys_ppd->sigrestorer == NULL)
 		return 1;
 
-	ret = xnarch_setup_rt_frame_ia32(sig, sys_ppd->sighand[sig], &si, regs,
-					 sys_ppd->sigrestorer);
+	if (regs->cs == __USER_CS)
+		ret = xnarch_setup_rt_frame_ia64(sig, sys_ppd->sighand[sig],
+						 &si, regs,
+						 sys_ppd->sigrestorer);
+	if (regs->cs == __USER32_CS)
+		ret = xnarch_setup_rt_frame_ia32(sig, sys_ppd->sighand[sig],
+						 &si, regs,
+						 sys_ppd->sigrestorer);
 	if (ret)
 		return 1;
 
-- 
2.25.1

