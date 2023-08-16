Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2105.outbound.protection.outlook.com [40.107.241.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E9DDBA
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 10:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMXKj9sW9ciz1FsHfo3M5fcUtUuyYT896AkZlR9X5rYNrDsTjIEoTmslqtIVR90ItiDhgBtP0zL6pyHerti34HOttISiovJge7dOGZHiYtrKod9jm1gqMI464oR5xmbGUx4GiINzKeVJrpXfenvjPabxv44CI5o62JE8v3Nx5PkBVHlMHQPJNrNKDjGkbjhYbY+KCKm3VZU507y5ASAgOm0oDh+5qBJ7GSHJQ71v7e0lry0kkQ6smUwDkG0SV2yXEjrNzT/K32K6OCzjXO/HV8z4MK2rGDVmN/b4OvzTZEmMBkqUgaXnCPlTZwu45eOO6zgSDtk/Idmjxt3iI68APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YodcP7nUU9a+VjD4lr8GfJxaxOzfDKoFd35P5wZuT8o=;
 b=NvRGH3zCwXQcD3hfKMc8EpFisNRg9Hxje1kFmbuV5rAM8WZZs/ivAUVXJTj55O9oQ3MHjDLjNuaolnxzA+RX4D5cnASvJFE8tMYwzauWiVycWSxXmx+dhO7rO2SyurckzjabMJcRPJrl/v7JWArGzCeUuavkwDu3smvQ8YH48F+PC0AgpLE/cZN9/DqRveBDxXIdm++aJszDW2VCUG/fKa5kBopsN0vmY26FN+Q0iakUQ2tjFchJ4l4TiPViERi7tWBG3PSVmCLX6DyzK8GTGb256Rea1jqn5MYKPsygccKRrvRpe3OaZ5ET5GmOF/n221WJNz8kRT2kOv8OwIyeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YodcP7nUU9a+VjD4lr8GfJxaxOzfDKoFd35P5wZuT8o=;
 b=cvI0xAkTPHP3NjaibhesdnmetZoy9RI0sLEfvjSLCTTc+AThWzFeaYvvzEQRHPb3t5ayep/SnB/5AT6/SvOvR7UvCszesJXBWZQDB14Yfxnf6otU5mq8ZbADlDGoK1+x4sphjQv+321xx+LNjBiKgVBX51s5jX3h1Gag+gAZ4VA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 10:19:10 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9286:1a5a:446d:7470%7]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 10:19:10 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH] add dovtail signal setup function
Date: Wed, 16 Aug 2023 12:18:53 +0200
Message-Id: <20230816101853.3377721-1-johannes.kirchmair@sigmatek.at>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::27) To VE1PR08MB4909.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::22)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4909:EE_|AM7PR08MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2a8eee-9eef-401b-645b-08db9e423b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9n/n5NhEPBO7g52/lnTMKKHBcph6NkjCUbjc4Mt3SETZgn7yqgl9ED+C5Vn6EcpbvxdDL09WTOjZr0eKpYzn1UHL4Is3+nSZS2E8XCRdhVfYIdBc7Mv8QdzTSFYbPJtSVUqsgwPCFKSPaUJF9ijG9i05DWpUyks0F6+LQUkdJXUwxawylkD0yxDlsQkPBAkpy+9spXi4965HDqW5ArITFWGwY/sKczMuslEuMOIq9CUm+e+NDAsy67uF8hCmFZsRTjvDqR4Y4cz9A9dNE6Q+7eNEKOlBBdS/WVTMfeTu47cRuQ3sSiWU/hhoMZxNRb6do32Ap+uJaiPllYlf5vuG8O2u0nk9miIAD3taF2A/YPKogdSTP2KMkPkV12CipynNP2bLzmg4wk5pFhrK3T3TF46irHpeyB2PJXumKHDhp8O06vW7nkYOdXIX5Yk4OLmpp78gcKfK4IB0l3+Q5/PvIX++80A+13DzibftljwwDbK/Q4Yy/F/AK6P5OcCEy0YfFCsrzfFssS2pXn8bQHoifjtNo3DB3gDG4U5AtUNjaIwnq1AigIUJyu5pwlWqPmg2DQL4XEZDPiuns7+Cba+mUDMoixSPemv6ekQ2a7gqeb4RLdFxR5gzEyLIR4l2aMHU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39840400004)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(6666004)(1076003)(107886003)(52116002)(6512007)(26005)(5660300002)(44832011)(41300700001)(6916009)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/6mBUmoN3TK8EOs8Wr7jU1v0gNkOiAmB+wxqcpgPLZeV8KvIwgXvluLAT8Tj?=
 =?us-ascii?Q?Bax0ah3BDcpPOdnVTIf4PFM3WMDiLCIc68JD6eNqckichvcyGngQrHQIhG+m?=
 =?us-ascii?Q?GqMTTzVAj967adZGmJBDfvZ2LVN0m3IZYyHjaPVocOAVa6DxNS9g1WPU0bOa?=
 =?us-ascii?Q?0tSalrmZyE5ovGgR1Ex02R21cOpN/60nzAOWu4ZUZxmxVoJ25bAnhEzwJ1at?=
 =?us-ascii?Q?QGumxG928WflzeaZeeaoglxA5UgqrQ7C/ysA+y0OPWFn8m5vg99/7N5J8LMD?=
 =?us-ascii?Q?J5QDt6RCjprdbBCKzglaeZvVRuGS5CqJa2BKq7o6Nshq4ILg5f240PIR1eqQ?=
 =?us-ascii?Q?VPBv5Xc4XcLL6oFaoaaZCTdTahfOInXLy0isDa+8GoOmZlhQ+IccrRm5spNA?=
 =?us-ascii?Q?sevqGnIzBcp727/OYYR1fJOQqJlQ+6Z2o3zLKXd+EslTFl1pAsiyC+ZQtBQg?=
 =?us-ascii?Q?BuPTO9XxNzk55hStwFCpET+c/9KRyevoblNprv2CaVduuBQm51xSXkMxXpoH?=
 =?us-ascii?Q?A6xB06pQjWPBsy2zC0PbHrpQzIYkMR4MCvxtD3UyfkE2Q+/d4p4OVYPakMQQ?=
 =?us-ascii?Q?x4kbFKZFyrWa4go+5bW0wLPnI0+1edisHil7lYF6EQ0lTbht70ShR61iG7tQ?=
 =?us-ascii?Q?hLXPHldLh7nMiG/ypkz+JEIrAG28fMjSXG0xAChgiVInmHwcVtGMi5XKSE0j?=
 =?us-ascii?Q?fpjxy1gd8B0h46KT23tQWzUR+JjI2WGuiiKWQMVJ9zf3eCbQSMGBvjxroKJP?=
 =?us-ascii?Q?F+44xUJ/t0JW51oKBTC1Xoo1HVTIdJ9/ez+RrqTKeEBeDnQ31ndoO0dVB3pp?=
 =?us-ascii?Q?uFL2K8HN+HHrNT9TYZ335WDqo//zTCdvXtPdbz5lHt/QoYlzEwrz98Fahvtg?=
 =?us-ascii?Q?jVYWbPFjHYkV2LYptO3DolxWvmCrGUTUx9pa+7EQFcrcFKpbRc6YLQQ/Vc2F?=
 =?us-ascii?Q?ez/pq1Y9m4aaCceEaHg671lcq8cAdTQ6cjI2om0a7Wl/iStmZff0K5giRGDj?=
 =?us-ascii?Q?1GGB/EURcpJr6zrSxfRoCJ+dp4apf9AUi9UP190yPvnvKp+2L5aCnNr2vhgX?=
 =?us-ascii?Q?I8zLbMBVi5vReBSCE3TcYI7rSXTBCOzSKLUbzxJnyPgFbRpFlHWjA8QN1/C8?=
 =?us-ascii?Q?YsT47XVTDWvXzeFItyG2/tjkdZRIhVPuh+HjYl+G2nnOlDZCxWQyoPyXj5GE?=
 =?us-ascii?Q?NXpCanpFy8/n+fjsuHA9KSGCa+JBSokILNoWLJuGaHU+/iu2vo8Hw5b42c1g?=
 =?us-ascii?Q?4QJShH1AX4FlEGZvbn/OXM/8V8FU+3Du7D+YGEkS8p56WpfWTts3zUMXYoZK?=
 =?us-ascii?Q?8jKxOU0xrbunsOvVF8d0jq7Iu8bHXbAJJe74iOv6dxw1ZxwdRAxp4dhARzy7?=
 =?us-ascii?Q?IjMfRnradSM5zsKBmykcPWWZOhdaJAgdH69R76cJ+9H+0fz8ZPkdzTfbrSH5?=
 =?us-ascii?Q?aONAdEDpE1cF6XZY1vPbguvuR/UGYwVfpEV5cw16PQIKC1DhbJLkdhOpAcAv?=
 =?us-ascii?Q?QAt6uyg96ThqaGf8F41oaoe0oSqnt0xTV4uxx/sOo0Izdn0BdalfDngoK3q1?=
 =?us-ascii?Q?NJsq9ApwPsekDDklWxA5XaC9XdifZK8FL84b7wHj+PlNXI2I1/BPgFpN+7Zk?=
 =?us-ascii?Q?d3fLHAHuRCzspXmqwFnhtwU=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2a8eee-9eef-401b-645b-08db9e423b34
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:19:10.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMNB6QWyAqnHNxXUiAZLL9222iLIg/07ya9fuNoNTZtqhb1LUnHMsVX47xcl9i3+Tkx7i8S2KE3uIQI76dYipHyDy0OURwITVK7iyTrVFOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496

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
 arch/x86/include/asm/sighandling.h |  6 ++++++
 arch/x86/kernel/signal.c           | 22 ++++++++++++++++++++++
 arch/x86/kernel/signal_32.c        | 13 +++++++++++++
 arch/x86/kernel/signal_64.c        | 17 +++++++++++++++++
 include/linux/dovetail.h           |  4 ++++
 kernel/dovetail.c                  | 14 ++++++++++++++
 6 files changed, 76 insertions(+)

diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4..35ffb1c52173 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -24,4 +24,10 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 
+int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs);
+int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs);
+
+int dovetail_arch_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs);
+int dovetail_arch_restore_rt_signal_frame(struct pt_regs *regs);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index cfeec3ee877e..d060931403dc 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -353,6 +353,28 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 	force_sig(SIGSEGV);
 }
 
+int dovetail_arch_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
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
+	return ret;
+}
+
+int dovetail_arch_restore_rt_signal_frame(struct pt_regs *regs)
+{
+	if (regs->cs == __USER_CS)
+		return dovetail_restore_64_rt_signal_frame(regs);
+	else
+		return dovetail_restore_32_rt_signal_frame(regs);
+}
+
 #ifdef CONFIG_DYNAMIC_SIGFRAME
 #ifdef CONFIG_STRICT_SIGALTSTACK_SIZE
 static bool strict_sigaltstack_size __ro_after_init = true;
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc088f97..a99318a70755 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -145,6 +145,19 @@ SYSCALL32_DEFINE0(sigreturn)
 	return 0;
 }
 
+int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe_ia32 __user *frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
+
+	if (!access_ok(frame, sizeof(*frame)))
+	        return -1;
+
+	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext) != true)
+	        return -1;
+
+	return 0;
+}
+
 SYSCALL32_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 13a1e6083837..67b52bcc5b5e 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -237,6 +237,23 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	return -EFAULT;
 }
 
+int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
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
+	return 0;
+}
+
 /*
  * Do a signal return; undo the signal stack.
  */
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
index 79fd75918b37..de220e90950d 100644
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
@@ -447,3 +450,14 @@ void dovetail_stop(void)
 	smp_wmb();
 }
 EXPORT_SYMBOL_GPL(dovetail_stop);
+
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	return dovetail_arch_setup_rt_signal_frame(ksig, regs);
+}
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
+{
+	return dovetail_arch_restore_rt_signal_frame(regs);
+}
+
-- 
2.25.1

