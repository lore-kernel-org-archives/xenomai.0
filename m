Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE43B8D69
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077420; cv=fail; b=ad2xzolzIQEjf1zymmVzoXoK07Lm9Ds4AwlRgqdX23UyOwXSRAL2S7M0RVJHer7mjmJATkc34oC8zz8Ez6PzCVfnre/cyLi7EA/B31o58Ll+ITpf89XPzLA4tmWqDdJcBx5SzC2HMRJPSHWLETDi+ConTEWe5B0hVpVRxI9UYSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077420; c=relaxed/simple;
	bh=8g3SbLklP4bQdhLYp/vP3LTRaXioYNTW22M7VfS+7rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJuaC7fGxe5FXFy4lA7UjSV7ac2iQ4LPBovUqtVkpGcvoIc4OCMWhhfSoSxIwoufv61DkhO5qDg3I4qnqU2Ql7G6BQD8kflQIJkIpCgDhrB5MIy2q2gg9kmjhhZvuTcA2rCtGuzn86hJkaf1/VRNhNE3ggHrWoL/GjYc31Stwvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Z98WIZT3; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Z98WIZT3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcNxFsJjGFfXWmztz+0ofP0I6i/oFmgU7gSKCC0mxDAVMRE3FaRKW6w+7qZbOowYNbh9PNdqSVFQPIRXYoczcWBJs2R0lFbg1fYCpPxhQcYCsP1AEOIdlAVBD/LW8vFLxGqr8rGr1FFf3WcZ5SkY39s4SWNNcxzyGDdX37pBE3Lk5jCamz/Ysqi5klk22p9iGQiqDXe4yy8EvPISsvISO4O5vn2Lk/zfC8XUI1t790+n8cCtJ0Jmf0z+RWGb73VH5j5nLsCKGM2VqsopR/ikGaIlF4SKMzhAytUMKXqFGH5HlOowc096m0CMzm8FP5E14sYjxeE46sCarIf7FixlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6loL1XCZIuelO4KCNxerDFEdRTWA9SpLfRp2k/1t+S0=;
 b=QROPm+eYBtaKnOiIzsxQYU67rSWsb0tgtQcQWa8+i3oNnh2yyhr4Lq/E2gng3Phrz1XhaRHnNTClu41I2cW3f1RxmlM+DaAPhcDjH1Wh2ehJ+4KNrJnKgB+h5oDkjufis8sRz7QxMuYsYI5lP25Qvs+bfke18Zfsajy7CLMBPigClt+4T1NhHiYiey9kX8kn42DyB4rghFbVNZqdtxAdpV3+Z+sEF65npm/8E7qQcIhtu9Tc94uItUffiADiAhlPpNFaxQ7Lwzm5mlWuLTjoXd4w0q0/h/B3+S3sA/yv9SnZA5fh5U419zIHpdGojb6IEj99GlAMCrOlAt+5OyzIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6loL1XCZIuelO4KCNxerDFEdRTWA9SpLfRp2k/1t+S0=;
 b=Z98WIZT3vfYpBGKpzCMp16GhU7A+1AobUZzGpzV4EPJKcGUSmqxfDZmKJo/F1/C2uuNnPiQSXP+EyBkKH6rGLnwpBlMkEhbgIGCQVD7813ul5PUQeTQAF/Tpto/69VLZYPM90s20Fbc8irkofDasHZRz3z2JjccE5GY/H01fchNZWsSmrjrmX0bntXpvrAez6HQxwEzqLMao9Nzsugq26qNGFs7Jy8rr4OnafcYXl4BhCPF5sNDIGfb45VZ0ukdqVticuomvlUeWE/9tWQ1rWuUazi/CPQ8boMdt+LZndEl0chNtQc3PFQSiYdyxmw6OvCnjyAr41mwPR/unXtti3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 02/12] riscv: irq_pipeline: fix irq stack handling
Date: Thu, 22 Jan 2026 11:22:54 +0100
Message-ID: <20260122102304.421957-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ce5403a-5d4b-448b-6e4a-08de59a03f7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xQHO+ik2fA6nSECPIv6ogk7e6doOLMc353KVjAWbRTU6Xtf/wjYjTyzdZqx?=
 =?us-ascii?Q?oTMpI/9djPrblF/S94mAF1hTeOwyDRpkfUBtd1Id7ypl9CZGZIFpizsq1SFy?=
 =?us-ascii?Q?399KGPIeic9AwZIL56iGxP6ZY+wMFF5j09g8rx4K55BAbtfDn+uWpamHra5O?=
 =?us-ascii?Q?ygCjQ35MGJFodKJYReLX1Yi+a4kcezPx64PReFfFuPytWCdfdrf13Pescp38?=
 =?us-ascii?Q?2IhiTwb/quwn+6gu468CUccuZJYbgsObelCgnlkJ04dAg6nFnZccyJgO0LiM?=
 =?us-ascii?Q?hqcKO8TisngmlD0zCEuKFnS5BI+xl1RJHPQX2kh9uizlxaYAH2WWKOV7oykP?=
 =?us-ascii?Q?L12uyTPMQv5xf8Q4wMCfbU0lMfMc6VGYCm77bZMDcB8dRaRDXl3PxmbGTWWN?=
 =?us-ascii?Q?ITa/AqxHzzefU8nexCwQ7YjJwGCKJzDvMhNpBIqcRHWplsguzGGJVnsg896T?=
 =?us-ascii?Q?7YX0vkRqiOmwOpL6ErmXMcKLi7mNsNRlPMZhICz27222W2RE7hhpl6x6n1mY?=
 =?us-ascii?Q?g6xSNfp9lr9wy/tY2BXiizgE+N5RSp+F9eUyJQd1dts6zde9WNUJwnWOuTP3?=
 =?us-ascii?Q?koOoLx1LPYJaV1bxA2xSBKbajllTTSrXIs4ot65W7zvpYCi08DrbvVQUpT4H?=
 =?us-ascii?Q?/sdBOhO9BToXr8rdSSofSYGNw2eGGJVCEh8Bl1b1HdBOEohevdljZMYXjVyN?=
 =?us-ascii?Q?FSFcF+p8pkbSa3+O4wfAfhLYd+Q2CP1Pn5Occ6g+JJiB9zTmu4P7Fn+CuwRt?=
 =?us-ascii?Q?LdZVBkV/abrlRwo+O1x2BOMLsB37yyCT6d+h7MtNCIlsyTnFQaEA5woWhfec?=
 =?us-ascii?Q?3Xzs1wu28wg/OOuk2WpBWC69RrtjwgcgSXDEli88UUKWHg/vR+HJYfh7tmf6?=
 =?us-ascii?Q?lRhHLXza2BXrrd0IbYEB0JYQvZ8mtOQCjLOmo43eqPEN9UATAFIZ4lJS057J?=
 =?us-ascii?Q?M1DQ4NsoZlnJ5HaFoB2xMpWrmGZDd3BcfgDno5wEUgVqFPceS71ktdde31Eo?=
 =?us-ascii?Q?b8+3KAVqHLUd5IbUoIPteYOvvHdPumULbP42z9v87mreaFVN/kEURcXJ014t?=
 =?us-ascii?Q?tmIcwPOk7CN0x76z5w9VheiULSU8R5OCJu+sc00zqinfVLn6HUUAol5DTm0/?=
 =?us-ascii?Q?dU5HA5oZIWWTJrg0tIscs0wVv04pR7jnablUiywwfnF2ceQ5MjY8OBgkHF3m?=
 =?us-ascii?Q?ig+fg+h4VphG6X2mTw4C5YGnTDN8J26LcjkpRvQRk+Iil8UYFNFspe93wHTk?=
 =?us-ascii?Q?sZ+p+1JD7qWEdfqbOi1BCUytV49qy1H5a30sLkwKNOTSG2FGf/WcaKCYHCCW?=
 =?us-ascii?Q?IaH5irh5AV1e9zFmS+T7W339PNrL/AYX3LATBykBn0KyzvGyTs1Dqv2XY+vI?=
 =?us-ascii?Q?XAQOxw5XqsoIfIpf7h7Hrp6/wlEczr5sqevUyfxkG7Hl1XR9p200efr4Hbj4?=
 =?us-ascii?Q?DAEbYXu1/KyJONmH8FSu32fat+L6I+KrDWTpg7DaLnPFnUod4K8XD94vYTPL?=
 =?us-ascii?Q?sk/emIbKXqQNKNfwBg1pHKkx22VrGSeRMgSe6GlahVqUkxxIuvonRfclQJnb?=
 =?us-ascii?Q?kzddevfwooIIPRitpAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lkH7ElY1c2Z4xbSVy+NHL8oIdDJ7ORO/UxvU9c/3/U0xJbRIbhfUw/kQw5BR?=
 =?us-ascii?Q?lfBdGJN4WM/N7WFnqefD2A2OnSSQ3LVuFOrmx2Wl0u+QnhhAhR5t789jc/Gj?=
 =?us-ascii?Q?r9/KinjIP9Ba+e1NODdmuosLrSQvNuEq2wRznwyPmbVP2G+irE0C2kChJ1Wk?=
 =?us-ascii?Q?IcMSMgeUiPUJJOXYjnKz1S8zxizKS21nbVuxJ2M/505vtBa3E/B7+ntxm2m/?=
 =?us-ascii?Q?KuCudXHG0Eq0LPmdwCB+6M/d27zopFgkRnEOaJQR++0tt82HPvAdBRjkKT81?=
 =?us-ascii?Q?GUKVUFHphuEZbpvD26n/k+8D1xCvXOceAEpHNZDtJ36vj+ioPhb4c59DeThW?=
 =?us-ascii?Q?Jxyzf0AtwF+eDMrVTuJx8rplRF1FiM67wPAgQ6xS/QMYkHF+Auz2ny0wUlym?=
 =?us-ascii?Q?gMEtZYi4Jmib9au2Az2rlOEl6hwzMLtgj3tJIXUBSc+as+8l+WmGxa3Q4HIm?=
 =?us-ascii?Q?CELoU464Fb7kK45DGk2S+ZgSI64lBjcf43wOISPTsxLyfT4Q7lUI2FF6P91k?=
 =?us-ascii?Q?6Wr8+tRhcRGKSVXA3txhpgUl3Ni4lJ9k8gZpEkr2oYA/a0ndnKvq4vfAuFAQ?=
 =?us-ascii?Q?D9jQao9m2NadTUJM0RK8yCDmp+As0AQ+gbFv8P+wLkabZ56xZtlfmc22AWDh?=
 =?us-ascii?Q?nxOqwnkv+edAoSvKjaEAYXwvwUioDqzFNJiMLTEXmLUSF6HxhY/zqYWERj6D?=
 =?us-ascii?Q?nBwt+gxUeRossTeXm0/saWwSZoLFj3jDjQsYMlSZrGvnIQTTjMPc7PGyapmK?=
 =?us-ascii?Q?vsoCDsjGffr+KWPhiowCqdBQgS/IDQxJJcwwpkqbK5aWfHafdw0dMAV7pkJT?=
 =?us-ascii?Q?wv0Kx3UEWs+uenYVv/xJYlOcrS8oFPLEnvBUYhh+bVob+YpurzmeXIknnCII?=
 =?us-ascii?Q?gYeY9MeQbLM+3R7Ku+O0yAf4u8aNDkb77mixZyi+asCgqFx2ugO/3c0BI297?=
 =?us-ascii?Q?93twpNGEWCVc4+GIwNKBmRoaVJR1tGcTk8GkfPh5Qx+L9TuxNs9wa9tCPHvr?=
 =?us-ascii?Q?Sx8fQe3qTXibzrVCi0q8B2qYx0hOyjNej6oVFYC7kL5PP02wZk1VherZppOv?=
 =?us-ascii?Q?t7CyJXfZwNfICuxJRdPlZtQfZSvRo7MNeFWpcyLlqJ6oSMyUY412gIoBMrbo?=
 =?us-ascii?Q?iH7fwJMdbjJX/HWqTIFF2dUIyHw9KnkA/xprP9Fa7jyJIZHVBrH7r5+JGcn/?=
 =?us-ascii?Q?AYKd0R+1U+mGIGcEiHrOFnQb5z7Jyijev3DkBIU5U3ov3wG9lkYZYEotbP1d?=
 =?us-ascii?Q?ai1jqKS9EXJaeeYcCS0JUStUJ/95OoZxDwXYhac1ygDGu7LFzDp4RePGncx+?=
 =?us-ascii?Q?uk9FwUOKZn7Su/vMYd1pnMvIr6npP3M60jCtSAFBiSnGxM1iHQxGrfUnKnCY?=
 =?us-ascii?Q?S7mdmKaS3aUhGDO/90+KYo3KooxNQ5E03aOD7D+I12GY3MSuSO/3lNd0/0sL?=
 =?us-ascii?Q?SGI+QWo0WJUCg1H2q+pGrpMd+LOyjDWVdN8L3pBP+zos+Gtbw7IUFKATv2KD?=
 =?us-ascii?Q?k6Ik2pJx4iz+3KFIyOWA5uDvnNYISBUJwDWQkNTBNRVu7gfWOTI5hCD0eDkB?=
 =?us-ascii?Q?wo1yavGWCQy70jgG3JYPpa9JAE2RvGeka08KKhdEXKrS3veu8b0senYGMgiP?=
 =?us-ascii?Q?zFZHRjubmJgT9uGCsRhPf5AqVKzKOkerFEvofOc7zXiaUPmfsdAdq0YfcuYj?=
 =?us-ascii?Q?4R9bYaRQzy939+BobYYqqoUIZPLtV5tnvRyhM+cb3maroq/LiTK92xeWM4oH?=
 =?us-ascii?Q?xe+j+pzeL4QFmkD++kTSgiL7drHOgyI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce5403a-5d4b-448b-6e4a-08de59a03f7d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:12.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPJgZ/VFZp1X/FLGI9KDXpIJ1P6nuQenj1SDDecpqBA4guiPvA6Hdgd46ma51tQFmkaVwgRrRouZrWtiziyW9XaRsEAICMIiaNaZVNcQx3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

We can not rely on the task pointer with the companion core potentially
switching contetexts over the irq stack.

Track the nesting depth instead like arm64 does.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 44b627d762f9..d0400086a075 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -443,14 +443,21 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 
 extern void (*handle_arch_irq)(struct pt_regs *);
 
+DEFINE_PER_CPU(int, irq_nesting);
+
 asmlinkage void noinstr do_irq(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-	if (IS_ENABLED(CONFIG_IRQ_STACKS) && on_thread_stack())
+#ifdef CONFIG_IRQ_STACKS
+	if (this_cpu_inc_return(irq_nesting) == 1)
 		call_on_irq_stack(regs, handle_riscv_irq);
 	else
 		handle_riscv_irq(regs);
+	this_cpu_dec(irq_nesting);
+#else
+	handle_riscv_irq(regs);
+#endif /* CONFIG_IRQ_STACKS */
 
 	irqentry_exit(regs, state);
 }
-- 
2.43.0

