Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795280363;
	b=hsSU4YA8Z2SQvKPuZSNNWxv4TzSnl0Gdr3LeAS9wXtvFse9ikPk5teVufd3OgXJ7LUqO
	 1aYDBlokCJyPyuj8o3XAxqvajvP4dTbdaOuoFvOmpJARqU9/7oPxDvOGwk2gPzj+NNzmX
	 QZELPn8iw9Wy6odeAFnF5Y8nqyPI5DcPLNE7irTqnvtLjeQyimKpZYq2mKap2UXw80x8g
	 aAVlY7dAhoGGuF2tDO4gJyPcBQpOgFVZ1VpWnO7s6FRch1IGU41mxwqR9yPIUpMsXrqp1
	 SKiQ818ReyN4gRWGnuIFgYiRwFn0FqkheEww6BuIodubrapzJ1lqN6m2g708BEMOf6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280363;
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
	bh=gKwsFwxod+7x3EoeFR9XmJLTgfp01pqxGAiwqYDvnCE=;
	b=C0UXruQxrsHLxSPXDZYo6pkjsGi8NVoDHlITsyoxP76IKmR1FOe3OJdZz6STLa22aQ1m
	 ldf7rSxidYKSE8THpIVSG9vQav1EeHpuS+gLtPEv9v+4uRYz0W0ko7ofdVdjoA5Gj0Ppb
	 QtCJg/Dc3J021kZC+jgLrnbMXGIetLkYESEsWle2lCIu4GtbfR4zBPsUgABBaC08Q49KH
	 Qk8qJ3IXaNFc/6SJtGa40+h6aeQQ6REQJoBDRwwqCrJDwkC9w2IuqshTvq3mrAoKjQh+Y
	 WhP2iGA8jeU8xdAHwWWILElSHv8FTwYDhW3P6QzpqbkCVJibgVnCR3y/v84ttzSn/PQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Fw3X+mOa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0D606A32A
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 16:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A0D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Fw3X+mOa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr+9SuGKAE0v3YAKH/nwsJKWd3pOzAoW/l215+x30ipIwvmzXXsycl8hAuPSMyRi9ZGf2bR1rc3FpmTGq634aPdIPYLN2yi3n2SlCFOUjAdt1kp8P7hRm7lLDzwj0kfheArUwIDMc7lq8T5rhAO5NM0+BueV096d6xJA5li9mc7My0vFzxDSq4QoAe2kVkZbW+PYSUoOoPfsVGqWks4Zxd8kq2CLIRNGuLM5oQDUZFG/XRmKZQaLnAILps86fTQ4/3bjsPXgyqjlmo1jTZMsT8uUhoTG+XKWlKvKaBLREXNlfZTZW+skjXz/XphVdRuvOqdKUnq1jEIKzKb4upWBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKwsFwxod+7x3EoeFR9XmJLTgfp01pqxGAiwqYDvnCE=;
 b=n8Adj5kRC6z4ei36rKW8oOuDvT8YWSKdwc3JqWvSWd0w1UWYOXLmV0vXAlcvGIgwwWDpKuHUcpRlM79OKXE221tIs4+vEAev8BD5oTWwmpSt3lOBpjJFA75klxW/GHjRHcbjkRXlykNHiYXnTPSIGnZUQaZwG+iifWKloiULh5o1l6ajP0gYOqdoAMMC/8KUvGXrCboVuKiRFEVmerL0sbSJUe/zx5RTTlJyX0pwD+XHPNFbrawSnpimxRwlO6OZXmqxgNMBA351VvUmUS18Vu8p12DABLd587opgpfgDo63gszgOMRXjj9QW222xPFPpI+I/MG75zxaDw7CfsqpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKwsFwxod+7x3EoeFR9XmJLTgfp01pqxGAiwqYDvnCE=;
 b=Fw3X+mOa0cgq+8lgE8Yz61po/NcmbGMr9ORUSCSU8us6mumppwHKp09xNIRAd/ojbBk6TwzGzP+OZL2fPAvNtyoXrcWj0D0bUdmac5d5Jpf3MXac6AUDo9C8IJ7bVZiY63iA6xWrrp2Mt7iU94HGatPxtxwgJJJ+n7fVSr/BYH6bYvX0xFZNaXVjwTvlIjJNsVPL8n4cyDEA3xvd7ZUgtEMVorVv6XVDdHXKJ6Rlk1uW6u/qvrR7TlQ1op1G0RwKg5xb5EYXv1htRreFqCt0cV8IuBFl/oRkuflkg9fuo/jtJ5TdNtO7Uu7CF8SdKWljRB63lvBBYONaJmhVduLk2A==
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
Subject: [PATCH dovetail v2 2/4] riscv: dovetail: run kernel trap handlers the core did not demote for
Date: Sat, 21 Nov 2026 17:59:31 +0100
Message-ID: <20261121165933.57310-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2facdf37-f55a-4f2d-361b-08df47f0c843
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|11063799006|261022075727099003|56012099006|261022105027099003|10067099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|18002099003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2Yl4kYLA8Rob9VCFz2y67gXLQ2L++lETlcx/4eTMJxwsCrlnJkN5i8fmgxuUhRgyNiMIvaGQTrY8sYonn8Zezg64B7VH2fZrAM09Uhu1Kl32PA11IQNXvVQoDm/18sr+QyZW46h/BQJ3CO7oL09YHbUJ/AZjTHvylRMEsfdwm2APSlApZMA3yugFfE8I20y3rAXW8Voq5Hy3NzCxtA8csqIEjI2pgA+qH39iqNtmT0Tc7bMsaMOAfNsy2RhcIL/BUgPFj0iynDg5+2yKU8PVlr+RFwiksU0PSn4evfCwcZC1rUH09H++kaBdrBRp+KLtsPJpDBv+3nu/0QdJA+y8dGBuUgUWvsEAYK/g5HPlVjQI5Y5lVObeyFhHyDf+ESgqAfq98U/orEXz2iFHrMtLoVaEl6XKQ8orhY/pITCBIDPwpcYgKFWREv+9ZnprPmHbqgycReNYB/VxkxrdUQYGP+NU5gX0+UHSqmpWxNHYwoMUSC+WkAef8D+4446pgU5/jdPfXL6PjQ1EWvcAd38n/W4ANiin7SQldTLyZ0HVwrghpAZ+dI6/w4iJPzkVUwY0UBvvcU+c9xjDGUJ428CenVwet3tyMMNpd79ljm1Ic7gX2kaOPPweSuk3G1J2znCS54xOAvUxfhznI30lwbCbv4TsKJziicE3u8FQmgTel9o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(11063799006)(261022075727099003)(56012099006)(261022105027099003)(10067099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6m1KfMmtTHzFvDKdNjAYJJKkOF9j0oFhThdYcw7XbdmAZiCRipJ1uQw4lskq?=
 =?us-ascii?Q?pt8r0LVzjY5FCneqa+qcsD6Z5BELtMNwklenEmy83cL/gpUZzRELUr/nEOGp?=
 =?us-ascii?Q?gQc+IJBIDloe7ngCZGTmVGaC2agjwhFWDTg9ab4QJVPh6aQt8TkOQmspNhzW?=
 =?us-ascii?Q?uVUr9y/cCnSnFgFYDU5NIfIrKuBu8N2zjRUUVUlYbpeX+wR/iuoHAPLPHKBA?=
 =?us-ascii?Q?/W4HTOLjfvY7DuKd42sYWFoRZsxe+8XlZ3APB7MhGNQSNpKijOUq/GcKnjYV?=
 =?us-ascii?Q?dXpVXE/NnwjCC9f4moNRJsoZbk1MhMF1WjfbUtqd4rhmAFFFndORJfCVUvbb?=
 =?us-ascii?Q?dHNjcMxnYZSB12q+HZQoRrno5Tspuh77xfBJO0/jZHQ+/OVCGSV6dfPBkz2W?=
 =?us-ascii?Q?BUJcFHCKbkQZva55cTVmwpFkKjr4jJlefRi1hegNa5qHx+VXntr1nX7FaqQz?=
 =?us-ascii?Q?kxpabBMk/dOEgQpMH2+iM6eLzH+vpqDgcEHU4IUPlqdPC/7DzC8N8LUNca+h?=
 =?us-ascii?Q?rM+Pr6GospM0HGGQR4E0sJbxmj3lge/XIIcQW/fUnhFsXKpIol2Tf8YrVIMP?=
 =?us-ascii?Q?GgMcwDCZOCs5e56Nvlp37rFba2GfYoJ4cwL0cVaJ1U1JJUvZS238Rbvk87OK?=
 =?us-ascii?Q?IbQV5HRAtaKb2Z3AfBYYlmXtvi2mGOT3scZEvMw9M9jiPRADPR1jJEjwMC4P?=
 =?us-ascii?Q?Obo1IYQYwZky1PNqstMeCzS+nEXpu/I6tEjIH4VH3D1ny/uHaBsq60iEMNuz?=
 =?us-ascii?Q?LV1YTn6+gYCr2VMvDpp/UGVEcqm56KekJD7CeUhDkQL5miHMxw5WgQCq2zdm?=
 =?us-ascii?Q?9GYxS4HYhXKfo6n3zG8lEPm35Zg5+ZvXT8RofV1XRvS5pqHT28ytNz0JDl63?=
 =?us-ascii?Q?ptnjOZlRoDTSPnenF2HzgMj13/EKFPF/5skE1VqMRVe/DBnLwux76gHcuyAq?=
 =?us-ascii?Q?0bVkLKmK5oj71UIR1oK3nEZma5a2fHwApYfsSFi5zvqZFluqGUY9cYmqexkV?=
 =?us-ascii?Q?oUHi7E5aIlRDOAMx0ZV6CAj5wpGGK3EmWfeBrwJNQxIl6sU5i7nKHAKyn6fK?=
 =?us-ascii?Q?U2kehCHMcNPGx15x09geEisT5/unegTP4iStgnjfs32nEoOTU6qJPuACvMN+?=
 =?us-ascii?Q?vGMxsf8QPebLwG2OZj6PWhsEfleq+vk0VItCpcNwJKCZuo5nj+B5ODirghej?=
 =?us-ascii?Q?Ju93WwBRrUeFZt79wmSLDH/vf2uukRXHFxIaeQpodSO9MDVJRE32+DPv4jju?=
 =?us-ascii?Q?3gLDxqQLgEYZ6dIQTcHi2awtWcTy/RaI+53+oXWHkB6C5ZWRTLm68UKixlG+?=
 =?us-ascii?Q?DAh/FTMDWQL3oPEFBy87EoyLi0X1+0CgJNlAtsGyl7e76x5dvXqwLXmzX9NW?=
 =?us-ascii?Q?ztCc0WBfvIeVW8ps4L/kkni/Uo3VjqDls4ms+Os5XR/zsMD4eM3yGzxHmAK2?=
 =?us-ascii?Q?snYXtSX7TcmRnMaCXU6l50jkRJH7vemXuTCsaev6XQDCCETMd3IdKo627w4V?=
 =?us-ascii?Q?8pOtxYIJ/hiatBcqiziHN6NWnLM2mTiNvPUJ2ohnSYLDEGF4uonurvYx664q?=
 =?us-ascii?Q?XrRW9wwUd90GEkVYAf8ud0fGtc/oirPRs3xkS6XdusdWSCinKwMtMhksSHnn?=
 =?us-ascii?Q?iZ7+EOCeVeQVDBMwLKAC6S21NMkzE7bPzNAWpJpQ+RJon4qLiGqdj+egEOod?=
 =?us-ascii?Q?GFJN2hNX0YvU379q9So0nNfQk5BmIuVQ3iLwLK5I/FhphSlQEOk0r58VGu3p?=
 =?us-ascii?Q?3XaYdgR8tA3Etmn4ir/kum6XhTOTrr8sf0eRwPxK3WtxCfkd5iyb9KxmVyjP?=
X-MS-Exchange-AntiSpam-MessageData-1: qYB1rZ+DN1V1MtLiYxIx3oq+TPyXw+2XNf4=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2facdf37-f55a-4f2d-361b-08df47f0c843
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:59:18.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVkaE7NApI3ooI21UbSa7kvKcazGbCzhB9MeC455LUrdB5qI1+Mhc2opcxhUK9Fx5mcvOiu0Y5HTkcKK5nzASb0LxyhFyoR4eTpZ/ai2jh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

A kernel mode trap is skipped if the companion core leaves the current
context out-of-band. Kernel mode traps are notified from within
irqentry_nmi_enter(), where a core may not demote the current task (EVL
bails out on in_nmi()), so a kprobe, an access fault or a misaligned
access hit out-of-band in kernel mode is never handled and the faulting
instruction traps again forever.

Run the kernel handler regardless, as arm64 does. Only user mode traps
are still skipped, the core having to deal with those itself.

Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index e2d06cb87c6e..a8e37ec27cc2 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -113,6 +113,11 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+/*
+ * Kernel mode callers ignore the return value: skipping their handler
+ * would trap again on the same instruction, so it runs whether the
+ * core demoted us or not.
+ */
 static __always_inline
 bool mark_trap_entry(struct pt_regs *regs)
 {
@@ -183,10 +188,9 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
-		if (mark_trap_entry(regs)) {					\
-			do_trap_error(regs, signo, code, regs->epc, "Oops - " str); \
-			mark_trap_exit(regs);					\
-		}								\
+		mark_trap_entry(regs);						\
+		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		mark_trap_exit(regs);						\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
 }
@@ -221,11 +225,11 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-		if (mark_trap_entry(regs)) {
-			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
-				      "Oops - illegal instruction");
-			mark_trap_exit(regs);
-		}
+
+		mark_trap_entry(regs);
+		do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
+			      "Oops - illegal instruction");
+		mark_trap_exit(regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
@@ -262,8 +266,7 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 		local_irq_enable();
 	} else {
 		state = irqentry_nmi_enter(regs);
-		if (!mark_trap_entry(regs))
-			goto out;
+		mark_trap_entry(regs);
 	}
 
 	if (misaligned_handler[type].handler(regs))
@@ -366,10 +369,10 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-		if (mark_trap_entry(regs)) {
-			handle_break(regs);
-			mark_trap_exit(regs);
-		}
+
+		mark_trap_entry(regs);
+		handle_break(regs);
+		mark_trap_exit(regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
-- 
2.53.0

