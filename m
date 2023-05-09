Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2137.outbound.protection.outlook.com [40.107.241.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969F196
	for <xenomai@lists.linux.dev>; Tue,  9 May 2023 13:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGq+8Ml/snb6iwEGFhHA0eSvy5PMp0TgBLp+M0RxzSqIVnQmvpBVgOV454uK4jJSLoX4KCFbPOMi+i/RtmLi5SErpWOsFkGYBYsuIGy8KtRb9tUwZyHioPhCh7J9AtLDay+imKxccOtIjDw7oOcEcixWTEMGrEU8yQELl2jAWcXjrXIEnsPvH/oISEZ4Af015MCxsTwqR05wRgo+tEG0f0N7ZTDUoN5PwHeCncsXcryRLppY0AdijpGL7K0bgYPPnOVNSzBrEFpmpY2Vwdr+oo1nLgNABrKYfAvx4hkj5cH9N85oBVVRkj3yRKB56lbUTzYftbxnbIrQ6olvAhrS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSjLDvxCzkTB+eFL4LCIE2TXvcpFcGq9NBM4OY8qbFY=;
 b=mmxUIk+UKCQNejbuoKgVm9U2HECx3NVWwl7+UUaEYXjdeZNwWr6UyKkJwDEcYDcs8U3CISiI2/J4+ogzEbXJrf9xP0m0pzOFWK0k3gyjp3cToEuk0Yw1JkR8FLubXnzKOGMcTYjfrb/qs8i3uZp2aLTZygfuRkF1YP4d/XYTNpIDLVwsn1YpvUcxuHQm6w4+mMJLu7nSk40cbHxZTuvgGzfaI5xuRsxgrAkZXhIXjwTlYqGFO6I4bhWSJkJnZIs6aBg79hK9gduy1fOembrXNhJALCNcSZb7cu6f3vkCB29HbLu1HM4kQKBExw4u4/PrLAowlRO4IGZEsDzFY3zyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSjLDvxCzkTB+eFL4LCIE2TXvcpFcGq9NBM4OY8qbFY=;
 b=RsqdPw89Uq8qLRsgZJMfTPgLaJgbSgeX5OMI/oBe5csIl9gBpbZXJGGq13hc4SVet0xNNB9gd44q8YFN4R9ca8xwdmmvKAvYt7E4khEGM5qyU7WVePANcysmVfjJ+w1t2n5UUKvpVQSrRXsIpIgY5BIrqYOdBJmkVB/S/V0T4cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS8PR08MB8442.eurprd08.prod.outlook.com (2603:10a6:20b:568::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:14:24 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::14f1:cfd3:e22a:4e44%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 13:14:23 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: johannes.kirchmair@simgatek.at,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH] add dovtail signal setup function
Date: Tue,  9 May 2023 15:11:51 +0200
Message-Id: <20230509131151.3003178-1-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0101CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::46) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4909:EE_|AS8PR08MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 191bc53e-e2d8-46d5-e080-08db508f4eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c1DqtAs3ypI8x8gFo9iGWRDjOa347d5rzKP+emsKQZohO63an3ZfCafv0bL+BoTrGuVyTN/2g9zoaylyoX24kKYIdR5hxzfTCWptQogaF5QfTqhUqhOxI3IVzJ3BKFuUfVJhw7BPgoutIYprnN/wDGKlBaCYHvVSxa6N3iVPSUL73UG3Ik/lN7SZ2JsY5nR6jca9SK7RPfwnMGoBvmsxpbr0/K7C+KBRXL0AglbIJYzYD+etheWs/0FAd4ayomDCe+7Sugz5g8MOkCo+7JPT0a5bVba+zIM0bnaCdlnl5M85SdSoZOhlmHuxi9nAzRJqr8iKqOoE9WxWtwHqoTb8jzDQA0udvm1L1MxOSmzk8R1ytsgx6sk0bSFHOJzBpd7/Z3FzSTq9A7YQcaxMGY4pXzASRNqp7C15oFjgwtghBoAW5iWjZnijxsUwe4/e2xFhz3NbRkV8Z0wr6Ky2LmRlNzdvOODhpX7cXPToObqIlroX7rrjyDdOCVYsKOgLtyQ6TXt/brhwI21of522Da/fjC8MjrIdpbWOM83Ay4p6xJLyxpIASYepaxtq+YWuBiRRh9NXqqdxyCEnfJPwuQHd4/ywqwka+ARd9qQCHoqRVbqzayvmE4wEwAOrZi+cierf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199021)(8676002)(44832011)(8936002)(5660300002)(41300700001)(316002)(6916009)(4326008)(83380400001)(107886003)(2906002)(86362001)(66946007)(66476007)(66556008)(26005)(1076003)(36756003)(186003)(52116002)(6486002)(6666004)(478600001)(38350700002)(38100700002)(2616005)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TxGkQFvL8qJJxwZH7F6RWSZYb3IKR4nd1D113vY1zyHnUvssph3HHhX2rrMA?=
 =?us-ascii?Q?rh0Osfj3//81HzUIpvSvrYkU+gxNyJ3TZJJKqgeu79AU++U2gpFndGJeJl0t?=
 =?us-ascii?Q?zygc1Tng4qa3b5BlJYt99WO4YzByhDrccIF65+Omaq4nwlcqCD85G15c6OpK?=
 =?us-ascii?Q?m7mTwpZFOXU9/iGSv84Q6vo0syPuXSY7HtiIuZsnMxHQWnZiAhvLT+bvuScf?=
 =?us-ascii?Q?bSI/11FvMpKzEn7QrouuA/mAcPidTGANJIpGS4oZjx25TXGHwWQYtCw3erYv?=
 =?us-ascii?Q?ezDzVSDqHRDvDvDX+UMJExjg5yRaKRnk4SJK4M5jp6UUscEi6BjiZXhi4ms0?=
 =?us-ascii?Q?60CWWUEkKRvsd74w846tTntkq65QZKHahHi6QDvgBq1yup5+1CnHNviKzD4E?=
 =?us-ascii?Q?XIAl3ZXykvxu+dIhH1swMK1y5wd9q2UnVgUVOCE+opJoJAFCCazXeuKEqGqN?=
 =?us-ascii?Q?uF9CervuMF3DEPkfUsRNBdhFT4zHhVFTkv05KSIQQVo4ogn5+fqwb1m1qmur?=
 =?us-ascii?Q?tKC6DXjFz+fBQYmlkMfSRO8cdWuVsSRY++g1RJqa5YTbk0Lk9gIEe+8S7hHY?=
 =?us-ascii?Q?UmIMba7wDLbpYCB63JkS8xE3F9oBc/zPXi6VAPBxxZ4ciecggSwlZPNBVhEu?=
 =?us-ascii?Q?bFCBYocGW4p05co7a4r96mHuA868HtoH6hiTcVux7blfyaE/TriZyeWLWX9J?=
 =?us-ascii?Q?vqvMvcWsU6BxbfIZ6y+K3umo834jgbR/lFhYFNRqnx2L5kwhVv/LjB62BWUC?=
 =?us-ascii?Q?JPM95Qoe5KX/EHB1vxIXtvHWKcuzq63yyHdE5yCIMlrb2qG0fVvpvLWbJ74u?=
 =?us-ascii?Q?duRCcKcUEu8l4aS818axNNxogCJKN/T8xb95curow7QBoVLLEjdY2Vwflfgx?=
 =?us-ascii?Q?7nfPe8mq812kkoLJJMUVuQb/0V9+raK0vbaz0pSF6FQows2iwlnnUlNIO78Y?=
 =?us-ascii?Q?r5oZyx/T3R3/kKHM9E0whxYZfXIr/zNQq3tgJL8NeQnR5/LzKGTAZbHR1sW3?=
 =?us-ascii?Q?eAO1MFg4WOFDrkNn1K9Ow35K58RUyo+T8HGffA4fHpBAdnDMGEDE8SONJ2iH?=
 =?us-ascii?Q?Z5Sje2mn6wDWTavILyPmuiXF/W3WzQCMdX8GQ4jLZHob1AVM4vQnAFnwtWVD?=
 =?us-ascii?Q?uAX5lReYX51ZGOSaQJZQR9jT833UnZA3YTiObVxqAfBaDrH3p7mqeNNzTXr2?=
 =?us-ascii?Q?xDesOXsnX1Y/x3Kp5v3jkn5PKX3nxMUo34rlmOidccNi9r9P37s+6dgu72ss?=
 =?us-ascii?Q?HSUjx7YC/mmo62xLCqHSeuNLnWmwMvhPxd/Ig5sx47gWrM2dfTeqaT4p3Vol?=
 =?us-ascii?Q?2UTiZmvfHlA+dDNF1v1WeutrWbSIIyW7vr1Pnyj78M9opS8b91MmB8iC0u9B?=
 =?us-ascii?Q?Ee2hGo7B9U5TDawV5hbqOHTmMdVh2MC3d5ldbyvpK1JKDAAuXBvFR9ofFv6E?=
 =?us-ascii?Q?kDSFHy5opgsBh0uZpBcZkR9vUplwph1DZNxEKGyDUojc7a63BBQuZ5Snc6KL?=
 =?us-ascii?Q?ycgO7ZZAaXfCbVrM3rXMdVpFUigaHfxPgmOQg5SSUpFFdZFQcOpmXy0677Kf?=
 =?us-ascii?Q?jkeJiL9lBaqU3niOXjBtDO9z4TvkykGNw3c14TuzBzCTEHK50eK0RVVWWNDM?=
 =?us-ascii?Q?p2gKh6V6d3knPdsQghleh/Q=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 191bc53e-e2d8-46d5-e080-08db508f4eb5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:14:23.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rzs/h0k50FD8rbY2IYU8d1HBLEEM8vfXEI5AWkmIv4MNTaDzgf2hvWUt5WvvitPKHRwcfsieCDnhjgThTYM3/TdSLXVy3Iw6DbxTqcJIBDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8442

add an interface to dovetail for signal frame setup and restoring.

This is useful for implementing rt signals within Xenomai.

The interface makes it possible to use the setup use functions provided
by Linux.

This is just a proof of concept using a very naive approach using most
of the code provided by Linux to setup signals.
The patch should be discussed, especially considering if using the
Linux functions is viable in a rt context.

Also to discuss would be the interface itself,
for convenience I used the kernels struct ksignal for testing. But maybe
we should maintain our own struct, that is not that feature rich.
---
 arch/x86/include/asm/sighandling.h |  3 ++
 arch/x86/kernel/signal_32.c        |  2 +-
 arch/x86/kernel/signal_64.c        |  2 +-
 include/linux/dovetail.h           |  4 +++
 kernel/dovetail.c                  | 57 ++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4..ed6b7fcd7250 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -24,4 +24,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 
+bool ia32_restore_sigcontext(struct pt_regs *regs, struct sigcontext_32 __user *usc);
+bool restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *usc, unsigned long uc_flags);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc088f97..dc8d60378e75 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -74,7 +74,7 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 /*
  * Do a signal return; undo the signal stack.
  */
-static bool ia32_restore_sigcontext(struct pt_regs *regs,
+bool ia32_restore_sigcontext(struct pt_regs *regs,
 				    struct sigcontext_32 __user *usc)
 {
 	struct sigcontext_32 sc;
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 13a1e6083837..d24845ee6a8d 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -47,7 +47,7 @@ static void force_valid_ss(struct pt_regs *regs)
 		regs->ss = __USER_DS;
 }
 
-static bool restore_sigcontext(struct pt_regs *regs,
+bool restore_sigcontext(struct pt_regs *regs,
 			       struct sigcontext __user *usc,
 			       unsigned long uc_flags)
 {
diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 70b78fd55d5e..3384437a4c74 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -150,6 +150,10 @@ void oob_trampoline(void);
 
 void arch_inband_task_init(struct task_struct *p);
 
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs);
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs);
+
 int dovetail_start(void);
 
 void dovetail_stop(void);
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 79fd75918b37..2a61bf1dbc23 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -11,6 +11,9 @@
 #include <asm/syscall.h>
 #include <uapi/asm-generic/dovetail.h>
 
+#include <asm/sighandling.h>
+#include <asm/sigframe.h>
+
 static bool dovetail_enabled;
 
 void __weak arch_inband_task_init(struct task_struct *p)
@@ -447,3 +450,57 @@ void dovetail_stop(void)
 	smp_wmb();
 }
 EXPORT_SYMBOL_GPL(dovetail_stop);
+
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	int ret;
+	if (regs->cs == __USER_CS) {
+	        ret = x64_setup_rt_frame(ksig, regs);
+	} else if (regs->cs == __USER32_CS) {
+	        ksig->ka.sa.sa_flags |= SA_IA32_ABI;
+	        ret = ia32_setup_rt_frame(ksig, regs);
+	} else {
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+	unsigned long uc_flags;
+
+	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -1;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		return -1;
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		return -1;
+
+	return regs->ax;
+}
+
+static int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe_ia32 __user *frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
+
+	if (!access_ok(frame, sizeof(*frame)))
+	        return -1;
+
+	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext) != true)
+	        return -1;
+
+	return regs->ax;
+}
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
+{
+	if (regs->cs == __USER_CS)
+		return dovetail_restore_64_rt_signal_frame(regs);
+	else
+		return dovetail_restore_32_rt_signal_frame(regs);
+}
+
-- 
2.25.1

