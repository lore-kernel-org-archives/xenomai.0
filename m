Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00C32B9AB
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432735; cv=fail; b=uwHTeAbhCw6TR30UP4zPbF1/9bQJh1lY5nMagpJ0J7HoffoUO3RgtVrLje9bcVkdNBHDh2oUe5CJbisgr4rdXSWp0s59PrvKBsltD/O/hSIKzGB6tUoPCGymJTtWQOTenEwlM/0tLRqIt6ezkKHffSj8UoP6APAVkoQ6Vo1lo8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432735; c=relaxed/simple;
	bh=ecFW5OdpPRxTyi8t6yJNVz+MIgKbtt2jp6HKFMfyH8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nTwg2vj5zrfoz9ztMKhGjJb7treq9cfxEiSW66T/IP3L/bUiu5+Uv9cmee5e+r9E4S+Bz9GcpQmIcOjZQOXBc9kLTIHlC3WY4mkyYWHFXhQwa72Wjl0fyLCnA7OFXo87F/KT31ZtQXa8Ja+ZbaPXEz6ix1NXLlTQ1Q3NBICa7yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iyWme28F; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iyWme28F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxyq883fFRP1m3KrSChYJ1YmEE9o48tKAH94DbLSGDbg1Kcj9kZq5jZDtyOy4fml+995QYJGYTJj0qYwWwnT1m8PxSM+I1hN1SoASMRSe/j3A0u4kMOluZE0JDdL1Gx03gS5OHV1qeluQ0iFc/uzjgmoy6KrAGhWa/J1iMHL+pAoXvnBefja5B6L6iGxlZNG8wfzqMyxyF6XOBpt1RIw7lrK9P9dstZispWuJH1HUJhy5I3SaLkkkKKBnl72lgOynoUexvd7DxbVV27yv/9pusd2Cz7E49NMwc0YPLReyURmDF0NPE8KVuUYZ4s8LxZqufROQF6D8YKx0FGbTFiHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdOMeVNIa9GHKMbmRYeIiB8EV1NFz+zmJTpR7aOnX4Q=;
 b=xNOi6900VQVdsTUQnjetUj2wa7J3vI9qqbKWqlMmfZV1yrFJdD82FcG4yds7zbpgaNYzHvb6lxDM/iXtp+dlaW7icdJUoH/mmU86n4q4cSaRClFqPvB3T+wmXp1K5nhjztDOktQQlJVXVpo+q5DGgMA0B3ja4PNCDD9xP1mVP1WOxXBDb5RxfOExm7BMPcdxpI/fA9cb2cjcjP9hYJ/AbElZ8jXg4vSBE7wEKY+fo6/OHDqx1xWeYzFHOUX5LY2+l5SVUho9JSYT/RAAi6lnfT5NP0xSQfCyoS4adaBy9g6QksCqHXfJwhYSCjRMVq4Y3smPoMa/OGB/Yws3cV5W1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdOMeVNIa9GHKMbmRYeIiB8EV1NFz+zmJTpR7aOnX4Q=;
 b=iyWme28FXjjFHR8wYB7KYMJnDGenEkWO9ZuDuIhuOkC1VS/Cf2Q1qSqCRMgEVPvZ62GA8vcpBhEkHxVB6WY4MmoYclND8B8lKqK8Q46no5TC/LVcLc0NCK4dCT1aHQ/ASNxIJR7j4P4L4+xcBMqiGYJzxgqyJA+Ne/0FKsM2n9UASBzvPtX+eJanEN+Z/1auEY6pKCcFkLPLmlWIQigbsn4vo5kfxhzIYWiVKbBViHRw29sRBCPimUZbqhPOuSmLqErnLsKpaWW+9H8ZuDXRIJJbrSXYEODYvOPnlhRa7DAa01YtIGOfBzx/qtqZeSbpta8alg84AZ+DY+tvuv/Ryg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV2PR10MB9614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:302::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 12:38:50 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:50 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 6/8] riscv: add out-of-band aware trap handling
Date: Thu,  6 Nov 2025 13:38:20 +0100
Message-ID: <20251106123822.1160385-7-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:610:4e::40) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV2PR10MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: d09323f6-f69c-4283-10d5-08de1d31702a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65a+EjPyQFhhVT2d31hhaynM4UNPTpL3xSuouTJpoy1Y6PfUGvIMqSFBYVbZ?=
 =?us-ascii?Q?M1lA2qs/9Hg2Ifb6RYE58f8Xp8t9yFjmp+PUNA6JK7Kd6/ZV+gUbY4Odj21T?=
 =?us-ascii?Q?gQUEuPwQ72a/hlwlP0obV6MJ5M89DXTBQBc+aLM2CGCVroTKEfh0csWus7+d?=
 =?us-ascii?Q?Qi+LEbra50VDAT1965SpH8mDVpXBgPam6Aq64pcaY5gZXwQdAEjjYS1V7sv1?=
 =?us-ascii?Q?ODsIK9l2j/QAw4vPATGXcoOVyG8rl8pHXZ8PNH5Ci/jg1oNGaamHNVcaewtX?=
 =?us-ascii?Q?yxWeBX76eBvM7WpYf8VSulyxrtGc8EJ0ch8fog2JDJFcCDqb8IALVerYRLQA?=
 =?us-ascii?Q?KYCdMb1xfpBTAvqvI6BO+gY/p0OBa6PBChuuwrDf38TR0xc7NurUGKSAdn8Q?=
 =?us-ascii?Q?P2gZH3BRl/nQZLtlBlcfgnUrNVuVMoQ8e1mGyjrBztpZ/rf6e2EbPRUyxPxY?=
 =?us-ascii?Q?0EXMME++0EnbN01pvZ05IcOEYdrLNaJP/JPqT3ph+FaaCpK4O7wmhFHxSOg0?=
 =?us-ascii?Q?rWZZAkSvBfcLnjDOuTwGEZ/YZ4depT2vEUJB8F1mRZZkvru4E0/2QE6KDT8n?=
 =?us-ascii?Q?evRYMG8aOuvhpnqDZoNnUZwAqoNtTHyP+1QYrTTaBsGz6Jswnx09CQtGb1Ji?=
 =?us-ascii?Q?XDwbo6MqO8ttJUKYfrLg9CLTTlF0mdkM4NHL3G0PG9Qf1Utxvmd1gsENjAa0?=
 =?us-ascii?Q?Ubvl3wOYmWg2qllO1kODTzLtbRO253U2mTKSimpOFk4jsQbngWx8l12jBzcF?=
 =?us-ascii?Q?QvOw9o+bf/GkUW9cYDuRTPDBIpOlCeVjvTNSd/KG7aF68li0W5MWN4BbLsIS?=
 =?us-ascii?Q?6VFOoIw8oPDqMCO0/ekNLAQQVZyznmNGsejebYpNbXumbvx3csMfOVmkbFyN?=
 =?us-ascii?Q?DqvZPxKEVj0nGEtXBjBuTWgi6rYmC3bbb8xwnMVk7dTTfDE5bfuB7DkosZ46?=
 =?us-ascii?Q?p/kfxSIhyOhk4LGpjDHjhfm07MoLo2M4UIMigu/2aaccRlmkHhXDmrOYNzlE?=
 =?us-ascii?Q?cxdZyDTv9jgJv70Z1YYv9irKtqaOy9iDSKFZugdRyZKR4BH+VCIW/pKiGSMR?=
 =?us-ascii?Q?4E6XWmv8DRP+UrM5MFHLPp26ajthx2jaQImQ26SmyTYLM08e/PmFLpXCnMhF?=
 =?us-ascii?Q?QCXROU3DYpL3D4Evdq2c5qC67nlK3suLYhUVXjnnPlc6xyCckV4uboB2G4fy?=
 =?us-ascii?Q?++bSy+Ri33hujYmvaQiM6SuWM9fhdXd3LLD42Ty3OUd7FZtEuwMoK+4Co2Dp?=
 =?us-ascii?Q?eBzlm9q0d0XoWZptZIle6Mcnu/qnqulKpWmAH11dCzEFf0frObH7cz0/W4nL?=
 =?us-ascii?Q?HJ4u9uu9lql1jLYTHXQCFp4vi6x+lbmVSnLIM0R1U/iX9IbFGHm4ztxaTk7b?=
 =?us-ascii?Q?HiwCJkFH94tae+50+GowzQ+JQ/VwBL9EK0xDD9n/zPozqlFUxfE8/itaUi3W?=
 =?us-ascii?Q?SkKt1sL9GgTShVwLj8V2GLeZJAobDZT1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6Y1VI1dUzdPtiEk1+ynQiKreUr0yoY8xaTmNQNkC0MXUeFcRQ6IBG3PhRTu?=
 =?us-ascii?Q?SzEmK15Fca5wBiy5YBm4elfNyrjjJEFBK4XTcgRDyr7VKnnFRNmCKDE5m8DV?=
 =?us-ascii?Q?yWjdvDYTbT4/3AhBiqrPDdGXpOubnGOm29mC345i36lb3bqgeIXgNgpnT7YY?=
 =?us-ascii?Q?LUUuVNaJuC3NXMcTdIvHBe2sGc/jWUCb3QZ0b5i+HRTbcgVsj3V3QAYoLV9k?=
 =?us-ascii?Q?8wHoPPGIC+dUJdPTi/AobV87QOWuX7vdvEOUrJAhj36qLjcsivuq72nbOVPl?=
 =?us-ascii?Q?sokXiSbTSGK/cZ6xbAbr0KLFbgjFrA9UIA7R3kUWURNhSTm1VOpFvNQfzKr/?=
 =?us-ascii?Q?EG8s/PoyfSozs9tpEcJP2KcYeECY6i94AfrBR1Vw2bhBhDncQ7OxCzWYtIWq?=
 =?us-ascii?Q?re7j2z2NNwomtmlJIykQnXfulaULSqcScsdYn+jqJYFqMHbU5V/ss5I7c5fo?=
 =?us-ascii?Q?FEEuEt8eh7cziSnHsRdr4fdbrmRlaj255KcQCGEN2d2OwaZF6qqzKXk6Fjd/?=
 =?us-ascii?Q?HEo9pqSfrc/fHcw2cZcfCVwVbE+YpM2I+BWI8FScTBmVCqPYRr3dKNoYEtjQ?=
 =?us-ascii?Q?g2fssRG6vbkHpH//If6YAc/e8y4kMpwE2NHYdDbvQRfR5kziSKJJRiesa5YY?=
 =?us-ascii?Q?7i0C0L5z6mnQeA2XJAjxcNSCA7yAMzllwTOqYMsptROB7Mw3jPnmIxnRtQO8?=
 =?us-ascii?Q?VL+WdzlwuVx8LkZUgbOS+9CD2d+WTJI7dzVwAee1/EbzJ9AFfJ9MVGABTq2S?=
 =?us-ascii?Q?oR5aoqQRqrHnx6TWkyJyMubJnEwkqj/c+ACJWDdjaTFvTe7NsBTiOB5sgKdA?=
 =?us-ascii?Q?q7zauHNvd6os85pcRv5hp3ekYKORVsK5nGZ3Me+GolHqbOMfiWUekMWA4BKs?=
 =?us-ascii?Q?icPH85Wq+7oez2Ajr0gFOGoCpeB0ZzfqD6QFpMc17+mOLg1/Cd4qQX/6cdja?=
 =?us-ascii?Q?patziiJzmoEB5XCG+cO/87gxQw6KOLnIkX1bZCLz0JySFQa+jt+MuvNwRGPS?=
 =?us-ascii?Q?FXYIiDjGbTlEa258sC/pqbWM+TJSRu2QCluIK/EpJv/UWBeYk3enevfYOqB2?=
 =?us-ascii?Q?MU9tf7UtAokF2jyUdmEyVGyWDpa0iGBZXSfJZFsYxRJ2H0YZER7A9bmbKARk?=
 =?us-ascii?Q?Befq36qyOE5g6t5JR7Umrvt6DZAKZmUm09s5kFUH3oQczHK92l4krc9lbpf+?=
 =?us-ascii?Q?iHNq9Bhydb+8cixAP5QauQAVP58u048wcvho4mRWjGsQ3QF7BJocFhnHQuKh?=
 =?us-ascii?Q?KZREe3R0ruoXnCrvdeCv/XxbyFNE2vEoAfz7WtMxq3PSidPHifKk0xIdiryy?=
 =?us-ascii?Q?T+lp+mzwmxQSeaT8xBulDxUXee/utSD/3UcZXWqBfUIbR6M/djipQ8KZ7ENy?=
 =?us-ascii?Q?yhXp/bawNuOd/i3JqufQLLquzx3VQTYeDQjspdVt4qAqav+ACjWTWZwWcKwE?=
 =?us-ascii?Q?+zI9kn9S9mwpgdI4g4rq8ulRzX/xfEyn6j6y+KGiP8eV7mS99KC0YIq9M7yr?=
 =?us-ascii?Q?JWh8KVnowJ1W8X06ECy4OYbW5I64ekUGqhFV9C5LvJJx4XVbuTPdDc7EsIyo?=
 =?us-ascii?Q?bWYBORqgBUzpmfYao58Tlss4LY8mo/KDBXH/Et99cO3YT81ygth4YkP/tWzW?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09323f6-f69c-4283-10d5-08de1d31702a
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:50.7083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVIcLyJZKqfkrSznN4PMyAIwhVJPV3nvKw2RZQsundAlw6zo0sfR60AA3qurxEy5XEVveTaMc7pX5Q9HoN+hhDHNxw5s2B5vy3rMultY5H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9614

Introduce trap handling hooks for the Dovetail co-kernel, integrating
out-of-band (OOB) notification and unwind support.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 87 ++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 83aef3fac26f..7b7e7e511fa7 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <asm-generic/signal.h>
+#include <linux/compiler_attributes.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -114,6 +116,8 @@ void die(struct pt_regs *regs, const char *str)
 static __always_inline
 bool mark_trap_entry(int signo, struct pt_regs *regs)
 {
+	oob_trap_notify(signo, regs);
+
 	/*
 	 * Dovetail: irqentry_enter*() already synchronized the
 	 * virtual and real interrupt states for us. If running
@@ -125,22 +129,41 @@ bool mark_trap_entry(int signo, struct pt_regs *regs)
 		return true;
 	}
 
+	oob_trap_unwind(signo, regs);
+
 	return false;
 }
 
 static __always_inline
 void mark_trap_exit(int signo, struct pt_regs *regs)
 {
+	oob_trap_unwind(signo, regs);
 	hard_cond_local_irq_disable();
 }
 
+static __always_inline
+bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
+{
+	oob_trap_notify(trapnr, regs);
+
+	if (running_oob()) {
+		oob_trap_unwind(trapnr, regs);
+		return false;
+	}
+
+	return true;
+}
+
+static __always_inline
+void mark_trap_exit_raw(int trapnr, struct pt_regs *regs)
+{
+	oob_trap_unwind(trapnr, regs);
+}
+
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (!mark_trap_entry(signo, regs))
-		return;
-
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -152,8 +175,6 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-
-	mark_trap_exit(signo, regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -180,9 +201,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)					\
+#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
+	if(!mark_trap_entry_raw(trapnr, regs))					\
+		return;								\
+										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
@@ -192,19 +216,24 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
+										\
+	mark_trap_exit_raw(trapnr, regs);					\
 }
 
 DO_ERROR_INFO(do_trap_unknown,
-	SIGILL, ILL_ILLTRP, "unknown exception");
+	SIGILL, ILL_ILLTRP, "unknown exception", EXC_INST_ILLEGAL);
 DO_ERROR_INFO(do_trap_insn_misaligned,
-	SIGBUS, BUS_ADRALN, "instruction address misaligned");
+	SIGBUS, BUS_ADRALN, "instruction address misaligned", EXC_INST_MISALIGNED);
 DO_ERROR_INFO(do_trap_insn_fault,
-	SIGSEGV, SEGV_ACCERR, "instruction access fault");
+	SIGSEGV, SEGV_ACCERR, "instruction access fault", EXC_INST_ACCESS);
 
 asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
+	if(!mark_trap_entry_raw(EXC_INST_ILLEGAL, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -233,13 +262,17 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 		irqentry_nmi_exit(regs, state);
 	}
+	mark_trap_exit_raw(EXC_INST_ILLEGAL, regs);
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_LOAD_MISALIGNED, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -257,10 +290,15 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_LOAD_MISALIGNED, regs);
 }
 
 asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_STORE_MISALIGNED, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -278,13 +316,15 @@ asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_STORE_MISALIGNED, regs);
 }
 DO_ERROR_INFO(do_trap_store_fault,
-	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
+	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault", EXC_STORE_ACCESS);
 DO_ERROR_INFO(do_trap_ecall_s,
-	SIGILL, ILL_ILLTRP, "environment call from S-mode");
+	SIGILL, ILL_ILLTRP, "environment call from S-mode", EXC_SYSCALL);
 DO_ERROR_INFO(do_trap_ecall_m,
-	SIGILL, ILL_ILLTRP, "environment call from M-mode");
+	SIGILL, ILL_ILLTRP, "environment call from M-mode", EXC_SUPERVISOR_SYSCALL);
 
 static inline unsigned long get_break_insn_length(unsigned long pc)
 {
@@ -336,6 +376,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -349,11 +392,16 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
 void do_trap_ecall_u(struct pt_regs *regs)
 {
+    if(!mark_trap_entry_raw(regs->cause, regs))
+		return;
+
 	if (user_mode(regs)) {
 		long syscall = regs->a7;
 
@@ -365,6 +413,16 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		if(dovetailing()) {
+			if (syscall == EXIT_SYSCALL_OOB) {
+				hard_local_irq_disable();
+				mark_trap_exit_raw(regs->cause, regs);
+				return;
+			}
+			if (syscall == EXIT_SYSCALL_TAIL)
+				goto done_inband;
+		}
+
 		add_random_kstack_offset();
 
 		if (syscall >= 0 && syscall < NR_syscalls)
@@ -382,6 +440,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 */
 		choose_random_kstack_offset(get_random_u16());
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -391,7 +450,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
-
+	mark_trap_exit_raw(regs->cause, regs);
 }
 
 #ifdef CONFIG_MMU
-- 
2.43.0

