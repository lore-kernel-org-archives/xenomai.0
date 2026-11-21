Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795280362;
	b=H2clufx1j2WdzHoM0NlMedXYexrKne5CCR1s8/3SyHcvhq+hujuO/Xgag14CUp2FDvtt
	 eWkg2c1HtULRAGOFQ7yu+LUZKwiN3GNXxxDox4Edjoo8ssC4T6ZlYMv9Fn+FWe6VsheMW
	 BTqH9gL3PdTQRwdpXgW1jQqJy8Go7IuY36WyoFIKbcbxJrl21avKPKtNNO9cE9xpjXBqC
	 WIKWLUG92ZZ0rvpDIvg6utipPfmK2Uz4uUDKBUESSQVv48dz8+UKWC4QrcvXYOw5mZldN
	 6mVFYFqaDxTEPc8t1YJSrXbKxmMHZ6x0dWuW6ic66sIUyLhzxiWZ8vonsnMRhuvDPcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280362;
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
	bh=l4yb8p8JPgJMlskAIszMi9cIf5bfqN/ezxos530Wb5g=;
	b=T3Qoeq6NsDb3lhydl04SLmTjBqoXOXawFXe+p7a9d/dSpSu12yFWpwgh75/ipNLyoSdA
	 nyRrYH2Ht8x3b3Nl9H1iSsFSqQKde/UiDEkf6x+eYFlT08dPSeylaM37omEKYQ0WzPK7q
	 QmxfsFl5FtG86s0LdqumxK9SIazBs/pWJWPenvg/vWTO7ZAW8vq00dpt2xQ9hQNUP+OSx
	 3TJQajBRf/guHXQ6e6Yq1tDD0Jup2p059+8Lg8CE+YBM4iWSSKBJevJMgZWNhHtXqx4JJ
	 SoC4dE4WjmQ+u7ss9/GwrLA70jdiWjMIItxLFQ/xznZBsw/9SMOL94NLoDXDvcNYXhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=FCA5fJiI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4745606A332
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 16:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4745606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=FCA5fJiI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaMsvXR+fh+BsiDRlCNOyWvvtuRxh3ONj2MmSdju9xQUER/HIXZWggWSdfdl0HPfPf124YkrXIE6lmgsfmvbrha5kMXgGqYnSi9UFb51/uAYT+86aKvqd9JTW7ogGHM0OQaN3YEXP9X86dhAYYkp/dYovEuj5CpM7FV9LDd/dvJwtcJXtylA3Ofx5VuZiXdijACCGva5mRBkZRkJev6Lz7LGmH2rG3DDtvcUkZyZ495hLX7pK8McWFFLwy9pYLsbRcvNyzxvz2tQs/a9t/WxDisWR0iswseeLlrfnOwGfhrVHlBHtwMtXogouviu+p3KU+iLUvi8xhn1Jk7if47RNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4yb8p8JPgJMlskAIszMi9cIf5bfqN/ezxos530Wb5g=;
 b=KqCMvn/jdGJxgooECS1le7JVkK478gYXJV/bIyzfn2g3rGlRWS5Ju8PwrZyebpJkxyeEvapq069Q+Np2IKZBtAyoOrUpCQZHNynQq/ed6YN41nLF2xBAkb9t0rJqHWdEuccEPADtNDnEkCpaWa9ewv9dYTbUxGc2XWgfj4YWDZgbiNLvLi2qJpF261vYDNRIJUYkwbrKeMKoPxXZ35q24kl/T94l1SpfJwY/W4bbwiyvVGwpIyQ0dPjUxCCbXwBH1lMIWOdYDwABfllvOH3aBBh95eX7ZngJALxY0Bq0mlMDfjpEZk3vcGMSPoVZapTpb4q7mzANenzcgWkzQUeVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4yb8p8JPgJMlskAIszMi9cIf5bfqN/ezxos530Wb5g=;
 b=FCA5fJiIuJWYCWskkA2zLzcwNp7YKuFnlcidjS9Q7l+YUkT169Ifj868iTsY6JTNBOAGxZX//kq9icD1JG434ZqwiZGD2ccGjBZ5bCYgAVG0Kb6YHa0zF7w5SAGcVU+B6eXTIqGwA97cl0GaM4FkmgWfhFHY2ELKfwjHd9Vq5MIXtPEo3OqDA0PWiMB5rO6P9eilGNTADhdWmEX2rQexyuGWDS+hNATCDLgHx9ti3F68ghbbkYmKv3gi/h5R5O4k4dkyW8xUoLXIa4mxykFEN0bBGvQ7GxMeQRjReWRXZkldEubkDHd1DvVsHswnZi1z1njoeRPrT3qS/LNB52Pajw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Sat, 21 Nov
 2026 16:59:18 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sat, 21 Nov 2026
 16:59:18 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v2 1/4] riscv: dovetail: do not notify traps again from do_trap()
Date: Sat, 21 Nov 2026 17:59:30 +0100
Message-ID: <20261121165933.57310-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121165933.57310-1-tobias.schaffner@siemens.com>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: c44ed851-124d-4044-2d25-08df47f0c7fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|11063799006|56012099006|261022105027099003|10067099003|261026140227099003|261021123027099003|261028144727099003|261026121527099003|261009223027099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l3tDpvsxthGJDKuhXrdR4nvwDocpQwrFL8J7ypPQG4PF6DEpGeGJdhZL3TvMLg0AofCAU5hwgCb4SelkaLPPzbv2nWGJZBKJdhPM3U3rd4wh85X+rKapzIA+bNzLPcOrs4v461CuVcf32CMGsQyAKKCr90SWHe7WP5v7gxpHpKH3HNXVRoTN1VZBP7mgMPSX9D+X9QCkvRLo2VF9r0LzaQcbmpX9zgY7CYu2xrXtMrn69cjvzb6bx+XOL7ot1xO+7l3Yrq1zxuIL3Q5bYgDxDI+JnDQwFAKiMwFIrKVSADZeMV7ueKbBfWrJw290w5tXND9Fl26QrOc/XaxcrJ7nhGD4R8ErDC1w/rYONmVWLr0wxtPPU7Bq4mkeHiRZseFTrbfW7aQTJTRWO7fBa1DfC3Xd89eyH17A+d8fTOj2Fsse5GUXwW4Ynm29AHKv2n3p8B7qXpkYxeMW45w6nQ+xUNRxsBf3SxFAzdswJRb/Oc2gpast1Hkbrl1IVjSE6NKs5hnA03BkNfGxeqELBmLyEQ6pnhTZBq419kABs34qTLoxYjrSqsWBSr4nncB0qOspTQOOaVZjWrRirFti2oFwODfech0TiGumLPEtBeV4kVvCRxzcmf6j7V3btOKNLVCOPvk5/AN8O4prvWuqA3vjW+GE6s5F7V/glcJvzY4ItEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(11063799006)(56012099006)(261022105027099003)(10067099003)(261026140227099003)(261021123027099003)(261028144727099003)(261026121527099003)(261009223027099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+2PzrC71uiUJa1O0Z2PvjvQPGpROuxfn90in9JVZXCcQpkjEEJtnQZuPVV0?=
 =?us-ascii?Q?IKyKlG35rypSD4e6VlhjKV7P6+vkAwykvk5Z+QpCIL9YAGf13zZwDv8XP3uU?=
 =?us-ascii?Q?d1ZAGKdqeFnwHjUDgeox2p2qv26n+rWmyz+74jWkCNwq0fcHMAkeraEH8XKm?=
 =?us-ascii?Q?awEfSpROD9fvHfABte5Z0AF2dbiyl7MXyoulOU42/yblBIWZQIctDMzcpjGi?=
 =?us-ascii?Q?ruRRYn6OyJBmyl15ip0o12kib2rdQFH99ziexGQhaNDlsZDlg+xRhvHrn2aN?=
 =?us-ascii?Q?ItGRGbGiK4QGO6AxFIIkxWk6EFrzk/23y7OHmT1zNN2EdKgdN+uPENTKdLvX?=
 =?us-ascii?Q?0yQK3GEcSQVXXv5H0vjkZoeraMT6UC7Qc4YqcHfZWJ7AuMmb2kyUNKZdmoXX?=
 =?us-ascii?Q?wP5FNXN8Bil9MlPhI9KznCHTHntRb7PfsQkDkqzD3eUIj6v1mSa6D8Dt7VZF?=
 =?us-ascii?Q?1NR1+RZLwmGlfAidsPYHJhojXsn7AOpFSeYnISjwRu6ycbZ7JVstI6HGUcFV?=
 =?us-ascii?Q?9/gbyKykIX54TnP9uKrcCype5JsrImwz5G6onnhT+g/IjuqyDlSBFZJ0cuCC?=
 =?us-ascii?Q?AiYblQsHq1UwAefYBudAIdYc2isI05eXahOQ2QjUwkMxZO13jrlRYBYcfKCy?=
 =?us-ascii?Q?eSOzH1+3zAd/Op82OhAPC7QmjojGJjjwVbjs34dXO1ocxh4g/sSm1PBtxKC/?=
 =?us-ascii?Q?/KyycMD1HSEYv0bkS61dSwBIW/LlByuq/XXD6YA4fyWKwTOJ3VyCKgnMTFYw?=
 =?us-ascii?Q?QkHoVWfPLcQLuMWU7O9cG3CHuH3SOOPYrIsnjfzVcEugGt9EHjMQE9uLg4LW?=
 =?us-ascii?Q?obGjJ4mmcktnAoSKVPPm9fs1dlXCWGN4MEJq9UsD0m0baRoWJNJNNC5+ONM+?=
 =?us-ascii?Q?oXu3vmltT3hWPgkOMTCRlKde4aXqUVJWUef8X0JkjhK93or7JuQ152GYx/uI?=
 =?us-ascii?Q?AERHHp9oPGJBh20ZeRntmdaZggxOJLc9bnwggB0bWxAtR7XNgeBEMzdBWdu1?=
 =?us-ascii?Q?m+saH2VFsPT2hwAgcBrcmarDs36LVWQuk2jkELLxlTecHncpGVGNHODIImXl?=
 =?us-ascii?Q?pM7jnMmTN9twVVW95LwXGpAacnOSSk14aWH0nvICw7pn8eb7sr01Z6OCCjpo?=
 =?us-ascii?Q?s5v/mnua5ymZe3/T9NGbF28zTLITbtbjoYdBSfiio8kYW++cHPl1bUVCdkeu?=
 =?us-ascii?Q?5K8L/a0/rNFj7RXvjC973DAGZSkfQVbrBRb8qw24OhV21LIHfX4IYMVpMuPf?=
 =?us-ascii?Q?QGOvjYkYgAv+1N+hsfDgm0XvCPMtw+CY1voy2497ttLQWcrJuQYgEuzxymuS?=
 =?us-ascii?Q?DRAJB7BGYWheRjD7FRoeys6J355Vy1bHp61JpvIeP2D+yiGzFcCmlz5NXeBs?=
 =?us-ascii?Q?Aqw8GECmxtGIgFUoiiQpxogQOPWiQl0h6TpzA/+oNGSkLFRhrTxUHfGUtz/W?=
 =?us-ascii?Q?x7x64qnGPXvWkv+5V8A6rf/JBXLneMBzpq7wHmWt2bo/UQo8SnNQmqKcJ6kE?=
 =?us-ascii?Q?+/HYF6FXDwMHBtiOiGO4qkeUpIrsRwQ3CDIArMdrM20Ui4Yi2CtV1GgPxEcg?=
 =?us-ascii?Q?gAfYd0WN0ChSa/JFOkz/f4ZOHv0jRGVo+DtSGHp1g4zGuf8x6O2EtHGNOwbK?=
 =?us-ascii?Q?4L8TXvu97Cf2uqrww8svJQOhCWEZHEKE7d99sUi8m9e6qz5AP+xkJra8V+Fk?=
 =?us-ascii?Q?N5kG8MvPBCU30+4iGc9V7hPO0wFaMlW6LW6/zxx4MNMxT2uL85DP+ZZskONF?=
 =?us-ascii?Q?qubbtyQao0sOTrBeD8INN/WMXqXDjwU9vWSKjt+lB9luwSzzC4i71nb7DhGn?=
X-MS-Exchange-AntiSpam-MessageData-1: b38ciB3nV/Ckp7MoD+ygrCLS1c0WqgeCXhQ=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44ed851-124d-4044-2d25-08df47f0c7fc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:59:18.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqnnN5UO85R2bdE/roTCtW+SGGaUAha2HW8np36nZnTfR8kCpgen4VEsUYIFvx376rt9peHyv1dhKZ2+8ki4FRQdQxhw1So/m/+1hMruAyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

do_trap() is called by trap handlers which already notified the
companion core. The nested mark_trap_exit() unwinds the trap before the
outer handler is done, which then runs with hard irqs off, or over the
out-of-band stage if the trap_exit handler switched back to it. Tracking
the owner frame of the notification does not catch this: do_trap() is
passed the frame of its caller.

Drop the nested notification.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 897fb63ff10b..e2d06cb87c6e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -142,9 +142,6 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (!mark_trap_entry(regs))
-		return;
-
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -156,8 +153,6 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-
-	mark_trap_exit(regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
-- 
2.53.0

