Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2090.outbound.protection.outlook.com [40.107.247.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB6270ED3
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115683; cv=fail; b=Agq2nVNH+JLlGdyO0Bo5hq2uHCIXN/dibjZyqaeWkcnX4wLRPLfbr6Fo9FMu9Q7FHNWX3z/Q3FvU95bBkLuhSn7ha4cvLde2BXL6kLFWhP9tGN20A8WdNSFAVjQq69X49et4ZusIGfNLyf16eHh0V8abk6Sd97kL/e2J13AQVOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115683; c=relaxed/simple;
	bh=U8i5G83R7BAwyMCf+DE+Hg/p3R4kHHpmSp9oybAO+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrRBcxQ+97bpYLBRRvweeG8LTeOjk1ns27Des4RjGYJCg87r3G1jouDRj7/y7ySVbmd799/289OH9LT8y3migBqcgYwoYqJsj0dArxZpbm+Fhb35x7cwcoUImQ49ljNrw4yDNT9k22F/jZ1718pwR5lx35KA7EJGG0RlGSCxBdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=JeTtl0Sr; arc=fail smtp.client-ip=40.107.247.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="JeTtl0Sr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL5GrzCMex1hYDt2muDBaakroM56w6PRX02EUUpeiqsasljx1IVHVPhI+3suI/90qhnAatAY19vYYtnCZ5DMQbY8kXaASm8WHKDcgJDZah1f1T8bZgOhmp1jrfrfy2eaiJQPHeI6xZ+3IKXcdTngxmnUk8YMUdLotAG/+E3ZyIyRSeEGrjm/OXjeWevsQhcQRKPyz+MeqbzQP6GpxAw8wwoD3ZG3/ve+F986pc3GTbUb/f3AzAFNwOrhHVlaG3lhh16/RfmzEsDYsVB5vezSYPLlrjOvTMC8qKHX3mvtQmD0LK9YtfpB3O/mHvqY1YKbrIVKdEdXX65132bI/C3H0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM2y0IMT0l1gvYejaGAKYILKt53JuS7PIUECzEU8Ym4=;
 b=y4O4q/f9WOvK4poZZ5zUFkzuuVHjIuijgCl8G0fr1GggN70I8pcRo2ASeKclyterierhc7F4l8ij+Vfw4t8/a12quRPByI14H3YI4U52YGStOZsoo9xreO6+K1zfwIEsFaKlUcLDs46fwNvMbW0BGbG9V37sDECqnKbqOwg7fQBxmSuQdfbiGRB2OA42ixBbOM4H/1JOa/3Wl9ZtqvyjzN85F57OVayagnsEGzrZBw024vb+x7dE5VE3FBWSZt52bwVBL3ej6KDLXFvK8wX4kzSua01Ivy7nmLch+QopEjpmimNO4+1Z9lOX39fIRxgpePsajkkV6zk9z/+yMduEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM2y0IMT0l1gvYejaGAKYILKt53JuS7PIUECzEU8Ym4=;
 b=JeTtl0SrqQ41FJlQM8v8JAUE0I7U5vE0eiCOc8j4rT0XKsWX4JezJkq6KlhdjU7pK16IKz08MCNQMcw3CGyiE4Qr4+f7WfGYy/BQ3tnWq4dy12Cftzs25Yv9BGQ/eLklyCOtEZTH0jEhsS4F+5INuRjtMqkjvGpV+ZjR+zfAW+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by DU0PR08MB9026.eurprd08.prod.outlook.com (2603:10a6:10:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Tue, 8 Apr
 2025 12:34:36 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:34:36 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/5] arm: dovetail: Fix user mode UND exception handling
Date: Tue,  8 Apr 2025 14:34:19 +0200
Message-ID: <20250408123423.627477-2-nikolaus.funk@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: 4f82aa0d-376b-405e-c293-08dd7699b8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cj8X6BHOK+iQHJV3Lmd0R7nozPyy/bLIeT0bbLZNeg1Nupvzjr6ocj/wynwI?=
 =?us-ascii?Q?Ty7rKQzVtbj9A5eX3J6cZqLlokvCI6D53TOofQM/po7xAnlnjQn1s8pWzVwV?=
 =?us-ascii?Q?jDioQnuguhwrddmaKwogRbGXx5WfZZzqYTvWZX2uZPDjntsaN7CRsucCruDH?=
 =?us-ascii?Q?Zegn27PWfIBxXzohFQklQyKXVQvweVhbWRrvyatKDd5K4dKii1ClC/yiaEpl?=
 =?us-ascii?Q?/3Oyl215+fqUbKjVn1RAtYPyUldhD+feaqAbvNLIaYRvjHQkFJo7vVAW4J7h?=
 =?us-ascii?Q?3HXzuQEqJHAPXYdFFGQ3hw+Suh2TvD3xRTQodLWBpBw5aZUaxpqjNyT9CIpB?=
 =?us-ascii?Q?3uj7OsoJZardtCR3ioXSnZacpl1E2h3sl3UQCHxe15W53DjPrC++FjI1oqUl?=
 =?us-ascii?Q?9pkRG8yB/6h2koXlr6sCB6bwqR2YfpmqA/ImznEtNWRosYJIxKJPcaNg75CC?=
 =?us-ascii?Q?clhCTGCzBj1teaGm29ULMcZX9FzdSsEFGw6IbGEl8v1HYk3+JCkWifIOfpt8?=
 =?us-ascii?Q?VWthc4GVIKlYyLTVRybdFeSc7CjGWVtPl7bc+W6Kxyh6RyJQyRbf9Q6xVSF7?=
 =?us-ascii?Q?D8CfzmuqMhje6w5XnApehQFymv29CLNoia6MTRO1sxE/CHGINHwQ+Z8caJS9?=
 =?us-ascii?Q?AferK4tj2UmABeQauCUJgGXBeAsVPvdzzm89jxfHgXO0WGTAK+Iz7YN7TL8d?=
 =?us-ascii?Q?/UPiZxu4x3Tk0Qlpb2TyDOmygHODrYSRmvnn0A3JT1iWx9OofuwT/90C1SLZ?=
 =?us-ascii?Q?quPL9m1v6FCB6MgtnOisE+7xmVTDmiB7+ihzQ8743+0DASKhmOHfuYudoYIl?=
 =?us-ascii?Q?Mp08rCGZ1MVgk4MdOGpl1K+Rlrl4AHqqZFyVx5H6fwjEPDr6Y9TS8PohcHIg?=
 =?us-ascii?Q?lY/4KDlvxGoy1oJqDYkC7eH59sylEo05LUdedGICVJFhDWk96yd920VEjvB8?=
 =?us-ascii?Q?bbTfcxc67SY8hDHIs9LzvGFjQ/buKsmA2p0VuNUvtznGp5ShckONbCitHRcL?=
 =?us-ascii?Q?kov+RrlUrHkCvgC6q+MZzcfWhKfEXDHVHolQyR0iVmRteh4+Y7E3HCULfzf1?=
 =?us-ascii?Q?zgPXOwBcn3PGrprNg8FENxiZbtCSoJUr2sqM3SHnrmqfb4sK9YznYNQNYu/9?=
 =?us-ascii?Q?enETafUEZyNkepBhgM5X3hljwQmwQ2P6GVn3MKWceqQtAzO1EwN9STxto548?=
 =?us-ascii?Q?o9Cl9W0t5qNXPNz5zKYjZw/fpBcoWntvpWXjGC7nUeEczp281gscBAF2fXGZ?=
 =?us-ascii?Q?Thwr54t3aVRfA/nf+4dn4hdoNJfe5v9BgojNTnRLG6+pHgN7ZVKn0RGNzg+g?=
 =?us-ascii?Q?OcPSqK1MmdhOYP6u9++fp2jZPicHpaPaEI2CriDHHFrWVqsPQksy5Mo60dle?=
 =?us-ascii?Q?OTFQB7nJbFWPggXp8SPyitY8COmGWubKBIGUltU9v8kqxmEIv/70vWGI4jYJ?=
 =?us-ascii?Q?SLdYbOjuLUgrYFpw8SPzvzcXdLl1oOvm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3uFk8lhgNcDkinq12jLq2li221GfjcP/iQ52vCBYkg4VNkFKmm1ORzjv+ov?=
 =?us-ascii?Q?2iFT7/5zrOmtZt6eHw+CNOkL2p9g/a7YQ/oXk+8KvGkZZfHSkwncR35mlQVI?=
 =?us-ascii?Q?VM1tossF1uT8VkQtMYvBlx8UDakjjYAWOoq62p7B9OYozzK3K1Iu9Dz04giS?=
 =?us-ascii?Q?XSJbeCuLE6Og5BCU9R8cJocc46+zTsgN+QRu/jWzqyFgjV4OJx4kWD2o0+Pz?=
 =?us-ascii?Q?oedw3VSuWfSaHdkYpSw8KYFEQySq2/PN6bZb0pTGJLZZ6B+3zL62QkClfR4B?=
 =?us-ascii?Q?nnQA+lM7GQsuQoPNpIeIfXfR7u3Ltu/zE4kE6ZanfSirckgx0jN6hzyWG/Ev?=
 =?us-ascii?Q?FIqoG6UMVmQrJbGRbQs/jsCYXo/YyJgs/WiKfVoG7QALBNcNgNNpF5p0nhc+?=
 =?us-ascii?Q?FqIRw5x15Pry+B8eNjQbmzmPWfe57xaYvDi0zmuokP/4aKek90iPS2Qr84mS?=
 =?us-ascii?Q?JOLqR+0eCnOIYOpS/I16OYzQiGC2lo4KYeStyLBj6L0TVnO9CZPJbNfS+5ND?=
 =?us-ascii?Q?unjJV90M2/5oCdcTlR+yAfK089gvAy7AdcO9PK9gzWZkGIIB97RFSia32cCX?=
 =?us-ascii?Q?D9J4G7Rx073gRNfOhhqB89qbWe86/oQlYMBJsNBhgVcWJUz4JiCoKGCGI9C8?=
 =?us-ascii?Q?4j/YumP+aZBtD3g0re23H7LdaRXdOnYQSQ/GK+QvdfzafwQBeJ99SNYMGC73?=
 =?us-ascii?Q?BhdMP9f2dpvVw+k9SVGt7G7FoAM1f/VMR1rtI6jQS0W/R3yUx77lVkozgR/C?=
 =?us-ascii?Q?et8p1hrYBFvO3SmogBOTc+7+polrG4LZtY8ZnvUibxdSaMMjB2R1eSbrfBck?=
 =?us-ascii?Q?AAQafNZbKljW7PW+jWd4sZiFsvVM5IfJAnDZrF2BIN70Ookgw93aNKpdUuUi?=
 =?us-ascii?Q?VCUt+mlmdQNkdclg+VWI7AtScKVBoH2ZVkfOapkw+bHaOabdHWvYQJtYuePc?=
 =?us-ascii?Q?INHkI+jgVg/jwcDcgVkMWQBp6DsLYWpA7VMR43DWck0cM2cy6s4xDRN6Kjea?=
 =?us-ascii?Q?l6aF5KxHOAX5DOpmZSPySsol7+/IZ3gvD7WYElqcztVZWi6RjzQlt4BjpXgY?=
 =?us-ascii?Q?Y2QLDC4of7z+mVbneizSs2i8HmTmSV3+7QTku52sLwLf67WAPf/DYUTlVGpt?=
 =?us-ascii?Q?YQfsnNe+50M8+XeqHA5g3kPSHqpgkkhefrtM+SAjZrNLGYMEKIaAPsIhcBwg?=
 =?us-ascii?Q?CSqc1KD8Kz3y2ctexeshKS/SeqYqNqQ9DzLQ811usCJXgcCI7E5ah4EHEbwB?=
 =?us-ascii?Q?ThnKGAJOy3S2Zg38jgKy3JJZNGCzos3DQ7FI+SZUVyVuJrBK7iS5KSi/DXwN?=
 =?us-ascii?Q?/d2qDhkuuDdOf4LzR7BQod+mQbc29zacFY6iGiDbq2grqfULUCTGz0z1yi6s?=
 =?us-ascii?Q?v334WGrIPGZM3YfoR9yhnt3f/dyOrmmfyloMdyaud+c5eCZsJIuWkHKE0/A9?=
 =?us-ascii?Q?0VawNpNyb8UOe8htyv2upIN1poFy1dmsfVk4xyb84klJBr8nG6TttYdqLilA?=
 =?us-ascii?Q?vh/EYLr5bmeeLkhiLdIqUhmcEo1jrFEc5Wb8pMiO/gdR64yCuM5+pVc5Y8NC?=
 =?us-ascii?Q?R9yGija/T9I1toTnbMvnUIIDD7Co2dbufHwy/tA2SofAtGI8FqD0YuXwcwJ5?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f82aa0d-376b-405e-c293-08dd7699b8cf
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:34:36.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fnGg/I9Rfw/adb8+0PyIo81zdB4wfOxUbpKiGXuv1bDSVQjGwauwd6Y/sAEnnrUJqjFr82vFCKF1Oylp87flPAlCKMfMSWzAKAMb5bu+UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9026

From: Richard Weinberger <richard@nod.at>

When a real-time thread triggers an UND (undefined instruction) exception,
it will not be relaxed. As a result, the Linux signal mechanism cannot
deliver a signal to terminate the thread,
often leaving the system unresponsive.

To address this, trigger the ARM_TRAP_UNDEFINSTR trap if no undefined
instruction hook has handled the exception.
Make sure to do this only when the task is running in user mode.
In kernel mode, the UND exception should trigger ARM_TRAP_UNDEFINSTR
via entry-armv.S.

In preparation for real-time aware signals, allow fast exit from
user mode UND exceptions.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/kernel/traps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 9838b1f3e797..0de8123662b3 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -488,6 +488,9 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs, instr) == 0)
 		return;
 
+	if (user_mode(regs) && !mark_cond_trap_entry(ARM_TRAP_UNDEFINSTR, regs))
+		return;
+
 die_sig:
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_UNDEFINED) {
@@ -499,6 +502,9 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 #endif
 	arm_notify_die("Oops - undefined instruction", regs,
 		       SIGILL, ILL_ILLOPC, pc, 0, 6);
+
+	if (user_mode(regs))
+		mark_trap_exit(ARM_TRAP_UNDEFINSTR, regs);
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 
-- 
2.48.1

