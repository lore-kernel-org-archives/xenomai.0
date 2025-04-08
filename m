Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DB4270ED7
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115685; cv=fail; b=KM1bkYcXVj0YkZeGkFKKsZJDHoiFSDoKNkAVmokG4eXU3W+EVrx8BdiszNJERKKBIfREJS8jI/O2YjiS5fsL5EU8QaWeDJhdhuUOsDiy3fQqk8tNWNYbnundXk+2uzNuHOuISp2RYPlidvcfbeLz04FHdYxQL2Fzi3QcpGvhhwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115685; c=relaxed/simple;
	bh=TFLcHuq76OCQ/E6xiXMDefSSWhOZGfYGn7bHGGpP6g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQl0Ddz1yOAkvUaZcBwAiAaP2BDUzg0/HBDvzrgO+D1NLKuaz7vGopFdbjbF++0d3FM76uDg1bhEnvQLvOD7g9414iTAS7EbPhl/1MqsMOOUmlkvhz8wHSVDKH1D92rVVT6YG9TF4KD8e3XmFODhL2OHxCTuKBWhQXBye4RN9qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=b0uuq5Ky; arc=fail smtp.client-ip=40.107.20.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="b0uuq5Ky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsFExKXRNM41T3OOcaP4QsczEhFpNcEOOdO5p1FUSISUJp3vc04YyBjgOT40/G/M3RO/V1XeOzc5HXflKDvC90uhbOGpQNc1qi8IOrmkorHMMgwRbSE/BmDsXaNKvRqg/9ZPcSzss4cBCo3crl+HS9M3r8U0AHQfqE5r8sb4j7Z2Vz4Q1tuTsJr6D2aL8dAzLwBsUiyI1D1HNJYTAtsToRYG+oZt1zD82YsBfnXIxTEQDIt+n8Xzg8Fajj5YdkO6bwDpkbKdXghoyWrVhosqf7bPOOMsPp5o0Ebp2mdKamzkq/XTFIb8EnqLyDz4lvmy0MoEKfHWMeBIrzTsq18ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7DSZ6qz7Wkdhuji5YYbx9sTcMoH8/fT/uPJpvhmJuA=;
 b=RHVaCK/l1NZ8lyARm73Lw6AFbzY8299aAUzm2z2KxSVFkDmG2usnoofW/cbQofy5yQhkP2BXiDBSf14xWmuRcrfW3AjQQ3a2O194r5CPPCzu/p6pPm2ij3xaoT6isqIrJcXaxBUgb2Y5QgbUHSV2AlfOdRWzXRxFBr8sa/XA0b3og3J4pXleSV1wlOUOl6eJe4ohCYNcopRIDfrRpnRG/KTVb01++dlG3lZkTFxpLKzMGbaOjBNeuRtmrr2qG72zPePEx9wRyqGDYn1ejeAJXOAsmrp2/QPlsoYpq1YBO3N0UqBKU7AOo8WbyKdOmUPjEUpiQ8Bcs/2yLQ5uHNHFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7DSZ6qz7Wkdhuji5YYbx9sTcMoH8/fT/uPJpvhmJuA=;
 b=b0uuq5KyhTSHsCdODSOOQKwKkUTeQc9ZmYVNcep2aER1fPt6UlanTaDjgsLaY1z7NTiTuCpexbOHTFXybljCH0Pi+h+LCcIbEcbWRzHI3m8Y2JKC4MJW37L+y1sFJT1+i7lnVcR6mDt69dwoCGgpDwqbZb+R4DyoLkaull4xPXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by DU0PR08MB9026.eurprd08.prod.outlook.com (2603:10a6:10:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Tue, 8 Apr
 2025 12:34:37 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:34:37 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Lorenz Kofler <lorenz@sigma-star.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 2/5] x86: dovetail: Helper functions for signal frame setup and restore
Date: Tue,  8 Apr 2025 14:34:20 +0200
Message-ID: <20250408123423.627477-3-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|DU0PR08MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cca6f5-ef91-4782-98ac-08dd7699b92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymhfz8UFvicA9PFG1Ci1toWCgdgiSOsIAIBFPXoO/oDlcADSfXFBNAR1Fbek?=
 =?us-ascii?Q?cIj7i7mI9s0mScPwXDBg6j3NlrDyIDZgpOfvv4r7WZZI5XqoT20IaoLhpc2a?=
 =?us-ascii?Q?fnWLvGKhSSIZZ+tEuC1QfIS0+4dPoLFwsildEvGz3+ULYfHPseePR/BPYG0P?=
 =?us-ascii?Q?jzvJTsR6K6nktSvc8/qfoVkfFEq5xzZ59/4xX05A06mdpHMhJ0Y2ADR+kyPh?=
 =?us-ascii?Q?PhWPyM8TBhz9BrZI3IgkFLgHKTi+2GqrNTRYNOEczYnIeQwAlQqXqgmNXcaC?=
 =?us-ascii?Q?aw5sIQPLBoheycvr5HwFMcwPVuAriVk8q/6pamECuPlIxx3kVQpWMEqKI6Rm?=
 =?us-ascii?Q?i+Nj3Jn6owiP5Vlc330t2oShN/xXkhCj/7+Uhm3RruO/nk9A4rwrgD4J3/op?=
 =?us-ascii?Q?QqwLD642qW9YGoceQnaL0eHdg7ya3GPuT5t6X2iVKhEG9yBrynopt2tdrgJh?=
 =?us-ascii?Q?wCa0qk6xnyC3PHHhHiMa/DJqB23Ce/tk5EMySeKhUh5kf+bSCJIXrM/76oVX?=
 =?us-ascii?Q?vE1jz3e4G7bMpb56U9YjNSvl9vifChvg1IVtjPrWOVSC+lGOLKTzzTzbYHeP?=
 =?us-ascii?Q?kGKwv49y3JFGSneeiJPWKH07NOQ/eOg/tvYzwHLt7hW83WL0+00NKGBmSchP?=
 =?us-ascii?Q?Syey7lNC0sLtYmAM1+o5fEliUd+IcDEFKhMfyOQLJ2o3m0ltAcVuqDR4J+tv?=
 =?us-ascii?Q?iE2LaiwGxMBq1nyqOa2T8oX1X0BtxYfxZxbpMogOIjIW/zU7HQ8fh4spAbXy?=
 =?us-ascii?Q?18XKXxe/DgNIReyupI1RfYJK+HSyaVV2U1mVw/RyMJEfJfkU6BwpzOOTM/DE?=
 =?us-ascii?Q?GLjoJt1z3w8ZMYfn8IkaAkkCrFzsN+tFDqC9vEvjqItwBZ+a9lNeflm8PWl2?=
 =?us-ascii?Q?F9mt/I8yLS3C/ZYQKbTAa43BvJWZkfpuOy4uWTB/bPqd7pZrFpVRVzjPGj7a?=
 =?us-ascii?Q?mmHzOSQLayzzCkmeRoXzG2o+8wrb9MhNY5d0cyr562gVFnL/brmivIa36Pz7?=
 =?us-ascii?Q?TQoVkxaOarLcGPwFFG2JhxKy2C8ybP6WlbwNN59lrX+PJCOgV61fzUzd6FDn?=
 =?us-ascii?Q?iitYG78Mt7L4AtpnMij0rxftnPPCOKNK5zl63qJjLJZ4KEliPpP4le4fhYvB?=
 =?us-ascii?Q?NguNX/yhTd2mkEvo0TjWVWX3eauJxNT+LZ4VU10oh4D41Vk19NhATxpiJc7n?=
 =?us-ascii?Q?cO6uuvbjSWj3zIe/nUXKDYRBRATLC5xZCCUgsCZYpAZmGL3zGE3IRjDcTJib?=
 =?us-ascii?Q?B1FMa+etwmf+jEB8QleF0KjTBdTFmbUAZGj/ood3nxEdPeBSKdUPkhxDlyJV?=
 =?us-ascii?Q?J7tPeXJgs+Xwutk2ySCKsC/3JfOdDV+kIDwvnzVZTFRDGGYni9rgnfWit67b?=
 =?us-ascii?Q?EuxjjYcd6ajX6mj8O33snY9y08GJZD4ClH3IYFjiIs1mrof34lLSeeuhQaX/?=
 =?us-ascii?Q?lhiXnPKWq+SqiFqZC3G3OHC2fQ+STkgI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?880NkxcjQv7PxI28rcXscj99Iw6x21Is/zldfYYJ42rNqamwWupsuTFcnvpB?=
 =?us-ascii?Q?SppKiY+kTCS/+CQXiLOeYdwDD8mSCx1l2Mdx4NGbYbaMzh8rSYDfyW13XPWk?=
 =?us-ascii?Q?DXXiQ9KMnvP2e3o9pW2luBHzO+LGsCQf6T1EcNgirJG5l3GJozYOWxjFGmMO?=
 =?us-ascii?Q?BUA4/Ux34aNmEtvJHYHWoKtcxnlib/ulqz8fzQNXZjcuD6FXPmgs7P76UKvP?=
 =?us-ascii?Q?k/2FUHBrO77HMJA3l/JfV7aqqlJplZtCJdz3pwb1QYZvVOrRrlBJhXwgftpo?=
 =?us-ascii?Q?09B+qZeQeEUN+ROEwXF46CAj15buONiWflxkgVS222+gqVgsscKyKH7rapvV?=
 =?us-ascii?Q?7krNOBWUV6JSQwVSMgBK9k6JWxB02lbWkToH/u8veGE4+LhZ0vNQ3RDyhR9h?=
 =?us-ascii?Q?lywg2fY+0wfvLEO3ynLAYR6LqUHW9zh3FVaZn3kKDIKgxkTgz5Wdp64nbKwy?=
 =?us-ascii?Q?TvZ8oj01i9Hw1W+EHYN0pG2mqYvW0m9wksNbF17LIWv1yKkof+WKe9L7RSOB?=
 =?us-ascii?Q?lFWbHunhVH8BU2t28k0ckh3SN8Be2ruxJMrK7uPjUEjqZuaiZ1T6Ey+QCHhC?=
 =?us-ascii?Q?NN+/blzTRReJbmkEqlO63dvEKUxeVQuQyXn5e8MleX3zv4WE/fNP2SrJjrm0?=
 =?us-ascii?Q?FA4Yd7Emyk0gUMNPIcNoiaozM6PwvqzFkqxBAd/kFShpqdeYXwT6mDnjRvWP?=
 =?us-ascii?Q?CeprR7HulS43v0OS1FEl0ISAWxYeiAlTEbXY+AL681I5s4/XVTR92CDj5m6J?=
 =?us-ascii?Q?/fJhWDRtKbCRRnu+fOfx/52GCyF0Rijy92CrhmzDBlwCKJ0em1CGObhEkQa1?=
 =?us-ascii?Q?xAqfuQ4FObrnz3RoWOLxdRi6UpwfRFoLDM3X4fYEOhfzUyOQehMgejhCUIht?=
 =?us-ascii?Q?7HcWnMTzA6FubQaefqRJmBxiblgCU5yNpkVhSKLYoEDjc/HZRQ3JhKD7BJ/I?=
 =?us-ascii?Q?Y7qIuw6Taaq/UptqmV69jAM6JIGcOK/ddTLBVEdpjHMLVBdDbk32sZmnYbxr?=
 =?us-ascii?Q?uEoskIQRtrsXajKn1vPpEbR9tv2puk64QGxB/CZ7F3NppEXI0bWIZguvT7+A?=
 =?us-ascii?Q?L5+PV794l49Yjzva4BFwIUHLqu6OaeDjrVzAjFiL7OwvwDBaTwad6fQDi5xX?=
 =?us-ascii?Q?6fEDGI+AL2JNnuHzVs1CZp9t67Fp1ym22GzfRco8O6lxduuu/jpRHaLMd+YS?=
 =?us-ascii?Q?GZdQWl02aCeJ0/D72joZiTF24wUR6d3L8gfStbXB/c4A6vwBLL30Sv2Drkr4?=
 =?us-ascii?Q?PqokYCsqYnPonMTWqtDmxwzG3yQJ2xmMx8qvFkmbtn6InyOWeCq3z9Mvnm39?=
 =?us-ascii?Q?Tw5kBSOyRL5f7RNV9BnXtW89Yw/zVyEQE9KL+9IO9VErXIRVWbSLgYKhT8t6?=
 =?us-ascii?Q?6GZugeivzJiuCW89yjZmn+UTHx+SGiwdjynyHI83KPQ84Z+Plxhfp3jUIFSH?=
 =?us-ascii?Q?0ECjeH8Us88q+sRkSUjZmToDWuYRZ61yLCTJ5HgV6WVRsZqR+/QfIExVpitK?=
 =?us-ascii?Q?XRHPVJbcc0uddNHOtQIXApV8XOCZ+21ayEuUgbC8OVw9WYtWqRqFJXMxX9YQ?=
 =?us-ascii?Q?DwKnviOdmFpyxrTlpuOZKEueVDZJqZEyESFRoD4lJVhA6AJ6aktnO+BA7bdW?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cca6f5-ef91-4782-98ac-08dd7699b92e
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:34:36.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eyd9vpzFgdgWeDc3Q/C3qeUwxhzjGaSTbrchEDYSWNKkJ/zSxNcxewjbwJRqNhnfMNDvfMeALS+5lOCo7dhR5hWd5yr/hpaISrif10h0e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9026

From: Lorenz Kofler <lorenz@sigma-star.at>

This introduces an interface for handling signal frame setup and restoration,
enabling realtime aware signal support within Xenomai. The implementation uses
existing Linux signal setup functions to avoid code duplication.

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Co-developed-by: Richard Weinberger <richard@sigma-star.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 arch/x86/include/asm/sighandling.h |  3 ++
 arch/x86/kernel/signal.c           | 80 ++++++++++++++++++++++++++++++
 arch/x86/kernel/signal_32.c        |  2 +-
 arch/x86/kernel/signal_64.c        |  2 +-
 include/linux/dovetail.h           |  4 ++
 5 files changed, 89 insertions(+), 2 deletions(-)

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
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 5f441039b572..65fd0f940f4f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -437,3 +437,83 @@ bool sigaltstack_size_valid(size_t ss_size)
 	return true;
 }
 #endif /* CONFIG_DYNAMIC_SIGFRAME */
+
+
+#ifdef CONFIG_DOVETAIL
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	int ret;
+
+	pagefault_disable();
+
+	if (regs->cs == __USER_CS) {
+		ret = setup_rt_frame(ksig, regs);
+	} else if (regs->cs == __USER32_CS) {
+		ksig->ka.sa.sa_flags |= SA_IA32_ABI;
+		ret = ia32_setup_rt_frame(ksig, regs);
+	} else {
+		ret = -EINVAL;
+	}
+
+	pagefault_enable();
+
+	return ret;
+}
+
+static int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+	unsigned long uc_flags;
+	int sig;
+
+	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		return -EFAULT;
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		return -EFAULT;
+
+	if (copy_from_user(&sig, &frame->info.si_signo, sizeof(sig)))
+		return -EFAULT;
+
+	return sig;
+}
+
+static int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
+{
+	struct rt_sigframe_ia32 __user *frame;
+	int sig;
+
+	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		return -EFAULT;
+
+	if (copy_from_user(&sig, &frame->info.si_signo, sizeof(sig)))
+		return -EFAULT;
+
+	return sig;
+}
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
+{
+	int ret;
+
+	pagefault_disable();
+
+	if (regs->cs == __USER_CS)
+		ret = dovetail_restore_64_rt_signal_frame(regs);
+	else if (regs->cs == __USER32_CS)
+		ret = dovetail_restore_32_rt_signal_frame(regs);
+	else
+		ret = -EINVAL;
+
+	pagefault_enable();
+
+	return ret;
+}
+#endif
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a..eecc9b2ee4d1 100644
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
index ee9453891901..d59e5924a89e 100644
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
index 31e9d5eaed55..6bde62227c4b 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -151,6 +151,10 @@ void oob_trampoline(void);
 
 void arch_inband_task_init(struct task_struct *p);
 
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs);
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs);
+
 int dovetail_start(void);
 
 void dovetail_stop(void);
-- 
2.48.1

