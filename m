Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAB3D1CBC
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077417; cv=fail; b=PKyEEJmRtvpsaYhMhqrm1Xd240AUMeuopyhI3C25dR/f+u7PL/w2U7KRhx0HACh5uowvPNSV87yJY/TnRb1XZpC8rsm4RvAEojqDbBSWLUARtLSDpz+yS1GN9nzs98qRLzbDuQ2xhRSxfYPZoAAAyc907hJMKSNweBPRnXc6qwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077417; c=relaxed/simple;
	bh=PHylgouQoEvWv9s33zPGdwJMDKZ+H2/z9FKjHwg/M/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDMhqSQFBUwEwCQ0K85msO32oItIv8CmVBww+Oz/vzgtdvp17D+1MCuKTL0oc45GKIR3RmW2JRvR31cDKrVBZhwaXo9NO0U2iOUDnf59eTPrX1rhkSYqY8z3suzD/Kq2PGMhDliVUeG1/HFc5djfHo5kAKLtVvIAMs4CSqi7Ct0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WeLr+m1P; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WeLr+m1P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG+l7m/0HeebTRG4e1oKKI7yUpe9jsBAG+c9jwkMKurgNckd7zuk4hpy4mYBcdszL+tsdrBvw/Bo5XQ5xd2pW7DpthDWFd7aeoj3Si42kK+ywHpc1yYK8wDgByzYbFkpIAM7/0pGrD6uczAv1SAFss523pJRH88UKRLbD4M29YQRqDQNZrSjuYDT4PgoHQVboay7Y6IRaq3rwOWMRzb1HrcvkMlDX5LFC+BREfS0Nge9pNjfArksXUmPg+b8j6rhNYKycjhAMMl9RxIC76Plcu5231ShRU+xCyucMhqIyYhxbTof/lMY5NuxjZnihIah1fTxu6+C93SL0iUCIaFlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0bFfS3gwFiePTa7y8mIIewh9oAm1xNXYgg4XYJIgIc=;
 b=srfeKKvsP94hcOAgkwVMLfpmaLxWIhsPWKg2KgNBWQB61NOGzIG9DrOhM+hf4YVs1X/JVTSopxN+wI6SDqyTfI7614c/A6Csdb2FNSQ8MmGwK0e9jBBYQwMCaNOMs4xNqaSOO1pdIfpY4BoXOnTY23SX2I+JR51EqakEKCwfsPn05PG6aQo0azmQUlFFbeiNlwtGZuyDnSKkqzkScJOIN33bY4Oi9kxtCyzb6+2wVe9Q9Afz/fZt0syy6zgH6wslsmGdCHvEnz+9taPCOmLUz+tUU3Ddl+uW6tWX+5dcxT7aDgvNNIiO88zhzvH3dVgsbUEjVM5CL4ljh9Hqil/Bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0bFfS3gwFiePTa7y8mIIewh9oAm1xNXYgg4XYJIgIc=;
 b=WeLr+m1PppZhUGBrGF1Fj+Imbl21mBp6JPr+Q2t1PhoaaP4Msl67KhCYBRp1tSc7aGIMW3bWbgt/QCbjbuFxqVb84KrNcdEJRYuRyFeTGNe4SgW08C5/WzQwFjJ7AcmlsitqIAj9sV0nW+3pMzxIozySqesr5tvR9QWwchn3ILFNiO5XmlWxpbTPNaCqPeku6Gx42VV++ofC2CpVSUap1d7bfIngb7K/X4sRey1ejI5VayUY73UtwXHxStgp45chZXrNKIX4xV2eProK1upIYgtN6iUyhrthEVms7OxH5Qwgzn1KC/76jSh2DSqJ9bCgptuKBzOoxBKPH6QiP/Z+KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:17 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 10/12] riscv: add initial dovetail co-kernel skeleton
Date: Thu, 22 Jan 2026 11:23:02 +0100
Message-ID: <20260122102304.421957-11-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8a9d8b-aea6-4082-a9b5-08de59a04227
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1a3jukyd83c0tWVykklDyUc+qpv77dJKdvIlqOPzUr4jcxggqnhwTULX3TC8?=
 =?us-ascii?Q?3XJh4ytjdkXZZDCfLBLojQLYwjzMfKK3cIEEDbMPUQjvz/dtGwA33rZYrWXk?=
 =?us-ascii?Q?wXAxf5XZpcgQoRRgsnlg0Q3KYffmtVpSbVzJ4qPJ75uQPXEB0RqOByWxU5dS?=
 =?us-ascii?Q?0DMLwHAsEfFQ+WEKEC899na+QPvFGKrUrablEMmMMVVjTHOFYvE2x/lXDypW?=
 =?us-ascii?Q?KDaTK5zpg+7D34LO+KfnbfWX5Rn3M1o7ADKGpS/aOO1/4jPRHwm9FzmPXNza?=
 =?us-ascii?Q?1d31OSAdDsZTO2Uj/UKyp1GRwHp16Hz+dGOXFElpLtJiBWuitBo1oEDYmsNr?=
 =?us-ascii?Q?sAav2535Mk8eytDAAhp4v9rFvcpPMowvPF+av9jolftM8VAJLAOEUKSLXyjP?=
 =?us-ascii?Q?WsJ3umwJSclul+jAj2rsVeP5DeZLYalPDpV16gRr317H2IiaD0in1fd8hzhC?=
 =?us-ascii?Q?jdprfWFfj8HJ2jLmfVZ9Dc3jVyK4LScPR/xNLBxQr7e2Nld6se0lI+8dIjx1?=
 =?us-ascii?Q?B93lQO81nkTaI5+sZmcilrmjRuG/xQn2UkM60URGbtuIKo2L/8wtRQZ3vhQq?=
 =?us-ascii?Q?R1XopfQxH4Qm4oqcYTQ7sg1FU5xfAz1ICYlRv7XYi2iwWdVgr2a/Xwp2iJ1s?=
 =?us-ascii?Q?hoPiJDtMwFudkosL0RSw7EjfvvtPl3cm6U+5d6/PHLFaA5uVgrOs5oybQdm3?=
 =?us-ascii?Q?8n0aNPg6tETEowLRSK5mTiVSMeG+lyjrD2pABJCvVe9eYcgzjqmsmp8hZnkY?=
 =?us-ascii?Q?7baYlCX1Ex41r1xyWnDy+iAvLdw1KnZbVBgR4Fo+JsVNt4d4BpC5ynveAgmt?=
 =?us-ascii?Q?joOqoUNoq0mXRqTzH5BypSGXrSs435c5XH5x78rxevGI3AFqnY0ecqpPEJsF?=
 =?us-ascii?Q?OAHqYmDYrHLXAbfGTFK3AFeNlHUoHmuvPThdjuWnt8AD5vw0ObtQ340etSYe?=
 =?us-ascii?Q?lObt5xSTGVaFwaq+pgAgGs7a9mLRrwWBfjqWGf7O6nqwrESzw4Il+sshdkjv?=
 =?us-ascii?Q?U1NpnBXGQzLqleqPKV/7j57plAVoPaKDQtfxK5TOBTJsFlZB4gE/BrH4IsCX?=
 =?us-ascii?Q?8WdBHb1Em2uOWKP8araAnqcTvh2U0VdV1yz2DfaXx/SO5a/h5zS5gY4wkSts?=
 =?us-ascii?Q?secqCNvZdxQ322SdTEBQ7l5RMjaHbHmVCh7fG4+Ud4vwBtNJWZC2ocwLB//E?=
 =?us-ascii?Q?5QFyne6knhnjKFRYTasDWsOxFHJK+S5NA+VPjJaXOEXwQ6XYurnIZlTWh80d?=
 =?us-ascii?Q?D3s7iUkNbAsZVZ+6IomDcTqUoYWrw7TKfRKaHFJ5iAtEZplzafDAMfv2dmdB?=
 =?us-ascii?Q?fYdIJnmtnJndiQTAwVZZ1cV2knZ2BOE5o8sCOKV95NpnwvRNfxQK5ovwx57v?=
 =?us-ascii?Q?dYdV15hPJyMrQg048zsKNEQqn4FaT6NsUUacQ5UADSwsREVQVlTmd4sjuE/z?=
 =?us-ascii?Q?/k0pGVm5+ft0Jw7023iKNm+kGeh1eh8MzikqFewZn5vTn/F4FR80DT3XU5x2?=
 =?us-ascii?Q?JWdSite33kcpxE4bSqmS1ilGiY+ag74z7kz3FER5PtIMtT36w4JJ+ld3VNYI?=
 =?us-ascii?Q?9qaNJ1Eryy3NFojjaVY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zW+3lkJ6bkusDhsO/COfBApKmEESWSdc6CEbEoy6+GA89qRhOvy3FF3uqPXM?=
 =?us-ascii?Q?s8yGBQ9ibz/DIMolZ3jUEfc3K+isoOHpasQpWshaAjc/PrnNCMycIULh3onA?=
 =?us-ascii?Q?HxhqUf7m4Fy0nTerk6bh+kMxdoK4kXsUzrgN9rbyOcn4RNfaXkY7nGaSsReN?=
 =?us-ascii?Q?gw/pCbtHleR+eST861NgbzIMmDrg7xQiAocBySfr5s+pUbrVglLN6sCa42np?=
 =?us-ascii?Q?AVGmNgOHlSZ01WecgcrJF4EhRTDviqRDN/gC6wG7/MDfjIpoOaUhz45iN84s?=
 =?us-ascii?Q?GGv4NhtTZy4Vx1zG4JciFjIOXy6hWFQByqWjhUJ5Uz/sFcX3j5F3NS9w3K8y?=
 =?us-ascii?Q?9NxOqRgg33sNGUUF94OOUg2rg1DhL/EvRFqoLiM1of3MOlQjfvwScKPUQH/w?=
 =?us-ascii?Q?GxYm7Ydtp6uVzeYs9hyAEo5A85UPz9PKdSDLwEQhtFwu9Y3GjWh01kr4DPhN?=
 =?us-ascii?Q?fAu6QlAGJfvN1npAO5XxAqrXMqaEhjpOO7pK2UyBAHztb/E32koGNz9ZSn1N?=
 =?us-ascii?Q?Ui29GxEml6K3sQjjo8bJlAHvvZ9s5+ZCrn07un/or4fDLrbQeGlsLr4PD3l5?=
 =?us-ascii?Q?t855NIP1O6GNwK1vK2CaC40b15awF785C5SFEVfmfrZk1/CqKnTu5/sp0rQC?=
 =?us-ascii?Q?7lGzOwuXu2071+pJIdGPC2UVq1znhnLGR2mbk1TAS32SRW/caAFNR5LD1VRq?=
 =?us-ascii?Q?vxU0geU4D0xBqoYLKcoTueuz6iFpWAH7ZFl3qfi3QG2G7CxzU3VDkxkXsA9P?=
 =?us-ascii?Q?TQENKrg4r2sgXH/kBzWUuShkifkv3aceTgF3FHJL2hafPHna0X1+Uq2GdSmP?=
 =?us-ascii?Q?FNzdrsx3OIPYmoOnydhNrQ2m7dW/GV+pu17RXJk4cfCrBsqoE/JQop6BFr/5?=
 =?us-ascii?Q?f+7W9cEe3E+zHiv9uoAGIPrZcGWTvdUlWsGvXIceAxY8Dtw+zWttOKVy21R+?=
 =?us-ascii?Q?PHeGh8KR9aRwkUuPaorSn3qNnVAiJMdH/IInvXVXp6s34DHnmu6EJu4f3K7m?=
 =?us-ascii?Q?Wb6PP6XJ2woHbBrDtHXQ03CJT3CG2kjG+EAx/aXtAohK9fzxxocFdRZJp08O?=
 =?us-ascii?Q?hZ5SFHO0XqU1j4oDTQGTqEI+6i29q31St0kJh+76aSk2YufVOLbzGw3RSsqu?=
 =?us-ascii?Q?JBhOTqfMsadKdklrQwxXVwkv6rpjl7b44JKVpORzc88QDwBI67bFtfvljDYY?=
 =?us-ascii?Q?RD7tDhZKVDL7dOsC9vrv8PXgO0XrJg2A4h/bhQ9i9XjO5FIWiN8HgjWfn09n?=
 =?us-ascii?Q?0oMvCc/JIksSNEmuzM8Wf1WyFcp1Ypk5fT1eibrGlF6efOp+dlVIPLzEil/y?=
 =?us-ascii?Q?3btyTRm9qpFDEzIQ9sgWnjuw/S5xahjJGoTfjhfq9ZAaW+aDXAwEpZcWZrRM?=
 =?us-ascii?Q?fpqCN1UtjHmHZW1CDBOulhgLKSuAfh4FUGKrb7aS+riCaiz4Zuo3753UIal1?=
 =?us-ascii?Q?IK0C2Aj8atMQA9QwDRb9xPWyJCO9e9ha3aMDgO26cjvVkLPRt8iqR811wFr9?=
 =?us-ascii?Q?df/JGH/Zu4DogYMfKI+MpuPtqDNXsr4hWxakpNLE/VDOtT1QJHbWjoZpa8U7?=
 =?us-ascii?Q?pSqjX+EMypb7ll2U6VRa2EoXtj4SAMQsz17zxkObL2g69j1Y9l7Q9JgsmFpH?=
 =?us-ascii?Q?RaprCqXB8J3ZfiDSPedqXV0uA8nwaDiM8z0ImErXvCZ2VEPSOxa9VyxtI+m2?=
 =?us-ascii?Q?m6MuhBjdKBXiDH5XlMtFYZJIVr3Wq+SI1/ZP/tPPXRnaD85elEoE6G1T2XMG?=
 =?us-ascii?Q?EfxJ4NWTf5NnEbOTQhomPE2FHl3PqlQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8a9d8b-aea6-4082-a9b5-08de59a04227
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:17.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U58TW/KfotYJyY9NNgOXHKG9dfssPRsNmYzy49Q0VK38U7Aov/KOwxdPTTJZyNQkUDgiQ16U5u1NGUqpX4DyipgpItueqQ0GkKP1c5JSL6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                   |  2 ++
 arch/riscv/include/asm/dovetail.h    | 23 +++++++++++++++++++++++
 arch/riscv/include/asm/mmu_context.h |  4 ++++
 arch/riscv/include/asm/syscall.h     |  6 ++++++
 arch/riscv/include/asm/thread_info.h |  8 ++++++++
 5 files changed, 43 insertions(+)
 create mode 100644 arch/riscv/include/asm/dovetail.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e93a0b6f9f2b..abec407aced5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -149,6 +149,7 @@ config RISCV
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_IRQ_PIPELINE
+	select HAVE_DOVETAIL
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
@@ -377,6 +378,7 @@ config AS_HAS_OPTION_ARCH
 
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.errata"
+source "kernel/Kconfig.dovetail"
 
 menu "Platform type"
 
diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
new file mode 100644
index 000000000000..bb342e9eb18a
--- /dev/null
+++ b/arch/riscv/include/asm/dovetail.h
@@ -0,0 +1,23 @@
+/*
+* SPDX-License-Identifier: GPL-2.0
+*
+* Copyright (C) 2024 Tobias Schaffner
+*/
+#ifndef _ASM_RISCV_DOVETAIL_H
+#define _ASM_RISCV_DOVETAIL_H
+
+#if !defined(__ASSEMBLY__)
+#ifdef CONFIG_DOVETAIL
+
+static inline void arch_dovetail_exec_prepare(void)
+{ }
+
+static inline void arch_dovetail_switch_prepare(bool leave_inband)
+{ }
+
+static inline void arch_dovetail_switch_finish(bool enter_inband)
+{ }
+
+#endif /* CONFIG_DOVETAIL */
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASM_RISCV_DOVETAIL_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 8c4bc49a3a0f..444136d7b253 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -38,6 +38,10 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
+static inline void
+switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	      struct task_struct *tsk) { }
+
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
 #ifdef CONFIG_RISCV_ISA_SUPM
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 34313387f977..6ae989aafbcd 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -117,6 +117,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 	return false;
 }
 
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
+{
+	return regs->orig_a0;
+}
+
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
 asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 9e4c9b884b5a..6c40e29f6445 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -41,6 +41,7 @@
 
 #include <asm/processor.h>
 #include <asm/csr.h>
+#include <dovetail/thread_info.h>
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -77,6 +78,7 @@ struct thread_info {
 	 */
 	unsigned long		a0, a1, a2;
 #endif
+	struct oob_thread_state oob_state;      /* co-kernel thread state */
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
@@ -120,6 +122,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #include <asm-generic/thread_info_tif.h>
 
+#define TIF_MAYDAY			14      /* emergency trap pending */
+#define _TIF_MAYDAY			(1 << TIF_MAYDAY)
+
 #define TIF_32BIT			16	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to user */
 
@@ -129,5 +134,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
  * Local (synchronous) thread flags.
  */
 #define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
-- 
2.43.0

