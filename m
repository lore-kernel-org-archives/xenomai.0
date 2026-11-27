Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787232;
	b=vpffKMerMCGjHDy/xAsm6P5UcpIfpo//W65F5EoxGmWryH3MLmkNxM290Syc9QFifjc/
	 MSjE/evSi/0fjBnKcHY9I5P++qQFCMiiZypN0RtpbHivqIYDIAhj5Qnxd2mew2D+PnZ3G
	 3gYBcA/hpPGFDpZWUXnjr77LLjxi/CZRav60HhrvpzwDSQ8tccamKwSKATCMj2cRsCAMm
	 rkvVioGoZlat5RY3WB1L66BN74kS40eiBnxgvb5oOqt9e1TUhIR39dx8hkiF7zwKLYGAC
	 6FbHuLKzhnfeIZpUyoihNQ05buzTHfpZjsScR1YH4U/lzJWynn7RZP65Lxk6h1Fo88w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787232;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jahIASPfM9altpIqpQFd91GBuOgi8zHbtSoB+mJUPR0=;
	b=hxdrK4nZem77kG4VZQzHCym60zWKBu1OsPxk197C8F7WpUtVXav3gmEiNSuaWNp3ThX/
	 A/SI5cGKipcJ65JTfd09LT9lphmlFF536KbOEfN5x29ulamzAhcUCbQyLL+3vhJtBFa1p
	 9i5Ipww8SVZB/QO9E47V4QDgF1M8sqpgi6mt/LJM8X+oJCN9WgU4MCgj8x8re9j0jfEy9
	 O5wHzWFtcRu/3uQpmMsAtsVSmn0i5VfCgUP3Dw4OY/MOZDRe1Hj0JrQ9D0lzYCtWDLAIa
	 Wj9pvKG2VsQjI0Gtd2DVlIf7MZt5fWOLXdYzyFL8FiyOxavkIK+8y1I3VYWLar8ihhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=NsfOPNWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.68
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A12606A321
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=NsfOPNWE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM1vF/paGHBiHFkpeKpOAsL1OFoN4FbS9eNeYMJE9MdDBLxVyGiSQMVyM1J4OJcuXFifhRCYk/rRwcDd+w2jvAMw2xxHd84RQj3wdT/nkcjewW2/3vRChXbbov11suXMelhY3fZIg+IUPYWpKpf6snM+4TVHP0upddR07e8gIac1nikCRU2sMi0uxsDYvlgFFlvVIXdOJnQA3z+b1alJiMiaY0biGIwkdJSLOHWF9jBkfrMwkm85Yed9mJOxXem3JNXZ7Fgz/PPOy4yOPF9Mqa9fTqbgVdLQQz6Hd0TmVjJpsqLDtLEViUN30LFBYFDHAen2u+1k8ck+ybp85L0AQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jahIASPfM9altpIqpQFd91GBuOgi8zHbtSoB+mJUPR0=;
 b=MILPSlhzpLm70f2qoAs/LuGfml9GSv0u5EJo7YvUSyymXMoBZ2H09hfqw9aGne8VWIYfZ33TPgGnlxPLQ26MlTL+WO5TJT/LmnbuQKPSkq4f8FX8M97TOZFkPMJ2HcwR3ylEYieheIZsFf+QjszLOwPfuACilQJrt5KncFYH2KgDla3AvAeZcFw+tWi/ZY7UfGPOh2Jj0Khszg9Q8jgcQosI1MJr2gIWPAwh0uchZj640yRhrreFrPu/0LP4+9fzyLgbKLPQtVAKGH1GbETHrGh5gxJaMpaY599zaGyY//EW1MZKOShRNBuFL+HFpUZDDm3KLro5jKDubsARKBUnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jahIASPfM9altpIqpQFd91GBuOgi8zHbtSoB+mJUPR0=;
 b=NsfOPNWE5EmiAHT5ryVSiJ6uoLshhF2dQHo8s/FUpngX5Z7IAjXAC6TGcA5KymTAU9x2VOckk7oDXDH4mF4Yif9sJ4fXg9u0BNTAyt4MnwVL8rWtaPNtRIjcp4bhdNUgtxhKEE6BnzIBxAyfE1gMlYaYof++sbyxklQUUdtZfR3KnhYhi4VIR6l6eZkAeyJIcavf8gMK6UCgMcObc8wauUxVXtw8Mn/phqrfdz+kbr/q+vI/t0GWUoqXmNLhX71CZIl1U9yI6mR+FAFEUbe/bEaxYcmFg/6QoeqesY8Y2royTIG5eLFYI7/sB2jfvqRc9rQwCRj1zdpMZs9Qor19Yg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU4PR10MB9640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:645::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:47:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 13:47:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail v2 1/7] dovetail: factor out the mayday check on return to user mode
Date: Fri, 27 Nov 2026 14:47:19 +0100
Message-ID: <8e286fce008f976aa924cd346c9c297bcf086505.1795786695.git.tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795786695.git.tobias.schaffner@siemens.com>
References: <cover.1795786695.git.tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU4PR10MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce5fb91-1e99-4977-fac3-08df4c8ced69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|10070799003|366016|18002099003|22082099003|55112099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Gqih51Tr+ktiyHTeZV+1I2fqNGha4HcXLw/W7X1A2c7OU3MeKpzXSItpowHn70oXEz/s1jpxUuUBso1Mv9M3NOqrHOlVkE/DXGgsw1ryuaTt0KJRb6BDjXFGYwCdtxGdkXP0RLhfITMYRLikYEbHF6BuFek/DNDHUypMBAAkIKxNufKQ1qLAnm2cnVlwaLR4tIISv4wyqP94cbH7rp8ZovR/dBED3TjNXC1wN2P2pAamk1oCgbzOcZCjzL9kArpj2RJVI0nur3F2yANewS3DXcYXlnDYjK26lMlkQe4ig+2D44itmxYaVkUX03zKYaMVlMLMCx8SoUQ/YeE/vm+GgZZVWbNsNf9XiZLCN+/j+i9RtrFNPQwGelxXMxQj6aw1lEphJzbeGzlOSC7XPlF8v+pif9DHPfgMvmfR5JPAGoUHKAGPsow+qyiZR3oCj+6HPM4LDC+afNmf4zIrJ4z8k/eBnn+H3DQ6cQguTNLiyIMPmPR74JNptm4KpsZtBnMRzeZdoW+/DTTQRLmf/6UHMCnN8lN2VLnVmE2mh+8VUTrzmUD8tnGidh23UK/5kFFWPac26YcPfYLl2ojXic3bql5RGncK/j8RbwjSoMX7agi8TS+XxIpBo5TP6RYicvTHu77o/NSrpsZpJ3d648WEJjzxiYOv08Rdfy3vaUWObN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvga/5OpqDTrD3lXvtGD+f0IlKcTVSqO2nWNrYtdbfbVXQ71YGeNBcm2F5VY?=
 =?us-ascii?Q?m/jcUX+u8neTNW5JF7WGk32qecsb06PVw49g7z25qyLiHM0uyHNUuHZlHdSE?=
 =?us-ascii?Q?U/IhUaI2lo2hpe6LJsgEqW6smaYwXBC+uM72IDxCOQjz7xMRs5JfnMvNjW5W?=
 =?us-ascii?Q?cf7fDW5RIje40sN0D4QeZqt8pulKH6zYRIvhCx6sc9mfFPjnU3DOxKSG5KWn?=
 =?us-ascii?Q?rS8tJN9j4oLHblBixvbnaJ8GAFop4jp0ekr94BLQaWh4mlnQarbAhYeete0m?=
 =?us-ascii?Q?JCf4jVd0jLbfp5q2mjCd+w3ZPmLLGHCmz3gmNPwyWOI+D5mQ4d0TOFyJ90W4?=
 =?us-ascii?Q?Qw2qTXLkqIpw8BqpHEJOuaR3IXZ/4IYrGkyh0hFhVYCubXY3oU+cEC1voVvR?=
 =?us-ascii?Q?aOfe3MCGFC8d5fShKzbjvNuE/ZR0+OeemmXjxlvXu0E1lwDUhSrJWUy6vV25?=
 =?us-ascii?Q?Y9jc74lY2XehDsEOcJHEEtz356tFO4CDoOELx1EWl0Eu08k3reylaoRld3uB?=
 =?us-ascii?Q?5Y8OYBOTvYpbEDtHvJAQzkRq2ys/L0hU7m7ygAvaKTG02Gy+Yrp//p2eEXLh?=
 =?us-ascii?Q?2kmdpDI4dUlQfcQmJHFn4A8SAJokjuFLJ9WPqb9SlR+AhBKX90Jr0R5SD2wa?=
 =?us-ascii?Q?CxrZmAdThVVH7S+KfPpEh7uTKpWCEw1NhBekBMoORURph4IB+rqh4e+eLabp?=
 =?us-ascii?Q?Cn6chjEoksb5VtTyrU3MBeu48M9Gu0CPl6Csh4aWIaqMD4Rhv8x+Dvp0dSG1?=
 =?us-ascii?Q?NnQ7MUff+6aUxh15FiHQRNDYuoza1+wRf7uLWdts9fq5/O9ARXmd3jNnmV1I?=
 =?us-ascii?Q?l7LbdXFIAZW4CX0OisQZSyJLhOMfc7g9KWYdZ5DWv5LMcJ8STcHBkLcD10/S?=
 =?us-ascii?Q?lTnb2zPI070E7cmI9sJDOxubx2AL1/6Tu0dMmqx5ctCfBvR6SpcaoyWEpcbB?=
 =?us-ascii?Q?h+QRJCL4fY0PpsvQOTVrN1aMEeoEm6cQPRUutuE2qDXOFJVMQEHo0VjBRS8P?=
 =?us-ascii?Q?xlcrb1jVPMNOSW2oHvwORq8yw8OBwuzm/9Cp5qSRF64en1Hx4wWh0IjCO7KB?=
 =?us-ascii?Q?mtfClSAulbpi6QP3PTQyAfHLvmzfXuCuKtGiUOEpoleR26g5OFbPwUsp4j9D?=
 =?us-ascii?Q?60KDajqv6ORUr0UG+Osh6QgFZVKRnpqCiYZ/yjR6MSAmEptKXrUbXXuYQtZd?=
 =?us-ascii?Q?+AWwSoCcV0T8ctxIAHj8IWg37QAJn8FdPZP97TE/mY6ygsosmZ2IHB6vh9vu?=
 =?us-ascii?Q?bJ98hjVeGW9K92skhY0r/jSKX4ooU5Iqhk+Lea7nbS+hWivT0u9dSKFL7EYw?=
 =?us-ascii?Q?cxmiHtS+4uz4oSPQbRefj/OWCUu/FCDVtZEusdt2nRh0/ixAbN+zrRX2skdv?=
 =?us-ascii?Q?7O8AiEzZmbsvDuaX9T1FGvjbAHUr0MZIcGwrEQMqNFoxw/z5HlFFIz5CkdUG?=
 =?us-ascii?Q?CrPYfWUwASEHvzALPYPdfsWVWEQmND5C0JA4WD1g9xyI+OSVB6pzrmQotyxZ?=
 =?us-ascii?Q?nBa8mBzf0OB3q2RXXlnJieG389ucYpQo7waqxR38K/714R9P8+9H6UCA4+8o?=
 =?us-ascii?Q?/dFpAZM/wrgTRFYDx9moJbRZQpxbWKD6aUko5qRlHnb2ZASLTaRNpzI4urkT?=
 =?us-ascii?Q?PLGQ7nipTQwS0gkW6w8I8nJHicVmCYXw4rYPQUV+BX/IimSKR/Jzl3e08SQA?=
 =?us-ascii?Q?hRcoNSjUn5R9k1axZAujGch+YT+MReQ6uGLd09cvFG+2Ho8NZDZdviHvEdPm?=
 =?us-ascii?Q?aOho+yUTX7gd3EK5yw0Hemf+mDGhDm/24Gh+yMlp42VIjcs8NPXcQ/8waRrL?=
X-MS-Exchange-AntiSpam-MessageData-1: Q0WZQAuakPy3GhTclp4PAF9wAcPxozBIKJ4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce5fb91-1e99-4977-fac3-08df4c8ced69
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:07.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htGIex8l4x1ASXug+d5/qUpNolDp7gey+/JEcGiNfyvMUrtFOoEZ9SLR00rXcfbDNRz/edHgsQ/StI+U6UEuab5Sh14D2xse2lNcR5sNqfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9640

Dovetail checks for a pending mayday at three places before returning to
user mode out-of-band. Move the check into dovetail_oob_exit_to_user().
On the IRQ path it now runs only when returning out-of-band, as an
in-band task has no mayday pending.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/dovetail.h |  2 ++
 kernel/dovetail.c        | 14 +++++++++-----
 kernel/irq/pipeline.c    |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 1140c5b7c99f..b41ea0f8fc4e 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -198,6 +198,8 @@ struct oob_mm_state *dovetail_mm_state(void)
 
 void dovetail_call_mayday(struct pt_regs *regs);
 
+void dovetail_oob_exit_to_user(struct pt_regs *regs);
+
 static inline void dovetail_send_mayday(struct task_struct *castaway)
 {
 	struct thread_info *ti = task_thread_info(castaway);
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index d2ea78913fb6..da4016697b67 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -99,6 +99,13 @@ void dovetail_call_mayday(struct pt_regs *regs)
 	hard_local_irq_restore(flags);
 }
 
+/* Returning to user mode on the out-of-band stage. */
+void dovetail_oob_exit_to_user(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_MAYDAY))
+		dovetail_call_mayday(regs);
+}
+
 void inband_retuser_notify(void)
 {
 	clear_thread_flag(TIF_RETUSER);
@@ -137,7 +144,6 @@ bool in_oob_syscall(struct pt_regs *regs)
 
 int __pipeline_syscall(struct pt_regs *regs)
 {
-	struct thread_info *ti = current_thread_info();
 	struct irq_stage *caller_stage, *target_stage;
 	struct irq_stage_data *p, *this_context;
 	unsigned long flags;
@@ -189,8 +195,7 @@ int __pipeline_syscall(struct pt_regs *regs)
 		if (stage_irqs_pending(p))
 			sync_current_irq_stage();
 	} else {
-		if (test_ti_thread_flag(ti, TIF_MAYDAY))
-			call_mayday(ti, regs);
+		dovetail_oob_exit_to_user(regs);
 	}
 
 	hard_local_irq_restore(flags);
@@ -244,8 +249,7 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs)
 		local_flags = READ_ONCE(ti_local_flags(ti));
 		if (likely(ret)) {
 			if (local_flags & _TLF_OOB) {
-				if (test_ti_thread_flag(ti, TIF_MAYDAY))
-					dovetail_call_mayday(regs);
+				dovetail_oob_exit_to_user(regs);
 				return 1; /* don't pass down, no tail work. */
 			} else {
 				WARN_ON_ONCE(dovetail_debug() && irqs_disabled());
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 88911489aeb6..f9c9c13d7137 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1244,8 +1244,8 @@ int handle_irq_pipelined_finish(struct irq_stage_data *prevd,
 	 * Sending MAYDAY is in essence a rare case, so prefer test
 	 * then maybe clear over test_and_clear.
 	 */
-	if (user_mode(regs) && test_thread_flag(TIF_MAYDAY))
-		dovetail_call_mayday(regs);
+	if (user_mode(regs) && running_oob())
+		dovetail_oob_exit_to_user(regs);
 #endif
 
 	return running_inband() && !irqs_disabled();
-- 
2.53.0

