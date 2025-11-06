Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87732B9A9
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432742; cv=fail; b=uVK3z/F/BIX/d5gOuISbp72ZrybZpX4aJqQ75xiD/gbUxKJG4I2w40MHd+ZRlQSmHRRFJQAuWGYD2CpJJhhM++ziPpydicQA2l6bji6vofsNwF+Qu4KsbLzcCrCmrhIId6W0dFon/FDrfDxnIchQTGIiSms7NliSNNWeELUGrRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432742; c=relaxed/simple;
	bh=sYV28jNGWOQDoHcR/+Ex5U1BO57v5SUs3Jx5IPlOCu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q5JvZ2QanmxZF7bHjS0X9MQnY4ZiP4D1H0BFfjhutYMW44fs7SgifPPd+1xeacrrcFeRu8I1Q5oaJNdVobqHqyuiw1zUCcQXTYL7W1/1lAt/f+sbiCbfg04q6/eqNmS27G9IA5PJyp6E8rN7rgH+27+Z5+oeYZU8o9uGZEIngM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=i5xRmuxU; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="i5xRmuxU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywdkE1SmwjDvRwNmgEv1FfHmHJs4YKl+A1CiHn0rETzMOq+svXq5iSwyYkH5Blmtzo3rJaOQRu1ONLTKSpiiNkR9FKEWtsFeQFC5q5iTzkT2apzporp7dLJXp3fp0u1O9DdCAsGyFqW5fum14nH5gUzdYWDyYLzm+mvm89lKUsoe6q4jAMBLzjqHaK0BkXjq/zkmSRdio+7z/mAfJ5vPQ4f0cflnlRqxBZZnTGGMKeS9RFLKfxywpvfW9/Q5uMM/CszyJR8UiBf0NHc78/QuxdKJLYkvXSMdo6rS6pAhdSJN8JS2vwkk3wQGtsNBMDIZ4OQbMwDcI6Cupp2K6ATTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arcdjm39MreY2Wmovi+aVrIwxs0gciUrlXPJn46cwFo=;
 b=OcD+RbzTYOdGjl6qgOvcZSmKcoOQRHPU580yJ+KeJSNn3DZqNeaI6ES0TOn3yJgldPDcALlMg6oTAtmzcFPnyeu2reo5c56NajALj2KSann8Nhu8fjXWSBnAJfG0ZvfrMQiv9vbHdlPcaGJHcaemtPRNm7n1jnIcqmuE0wNm8PL5Wz/BkrsPTfVNXtMUPKSrcJKhnA8LyN7sKlW84uHVkG1UevkKwSaOE2FJbbU7nr3xi5JvUdi0TX4wQ4818ci023P+bcD/CV4+1unt6aQh/J2fM3b+fqxiWpNLIwG9Ht53ruMhiA+73oMV8iWp4TfLjcbz6CgE4rVAEmVkovHBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arcdjm39MreY2Wmovi+aVrIwxs0gciUrlXPJn46cwFo=;
 b=i5xRmuxUs793X4BYls/gq5Als5g+r83wYMBBxRVfmYZurSbby27cwjF1kl6aV6DgsT08deodeqz1Kt9RCy9iBFW9QdU9SQbMFo44iIM3c8XaQW3nwISE9/IUsTa1GFzX0mkt8A6Ltaj4+j/Mm/CO750gi42mYRDHgcByt2pyoEZ9DE7TuSmjCEjYdaLxryzbLuYCA+wDUJOcehsBL6Rrjxa4Jo/D+a+ja0x30dFze3eGvQnY/OOQHvIWoE8lrDCL75iUDPozv21QH2FylAsX3g7MwQWyLFqspJSAt12bLwLWU/tTtosO3gjUfPO40e+RcG4uiFNj8cjM5xsv9PBCAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV2PR10MB9614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:302::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 12:38:58 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:58 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 8/8] riscv: no inpependent irq/softirq stacks when pipelining
Date: Thu,  6 Nov 2025 13:38:22 +0100
Message-ID: <20251106123822.1160385-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:610:4c::31) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV2PR10MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ebde24-82aa-4afc-2236-08de1d3174da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HxQlftwottvh7adAa+tbuLTeTzp66IWZMgwQTXz05dOsaPeMsRp7D3/b5ysg?=
 =?us-ascii?Q?h8ZSUDIKZvENnC3YAwzcgpi94wi9V8wBkYxMsKAMK2jwCI/Nb7ZXe173XH6k?=
 =?us-ascii?Q?BnyUmNmTWCEKa9iTYLblogfDcH8nMFOhnd3auqMRgw2rE0mLbYJxUrk6+lih?=
 =?us-ascii?Q?tm5sGeAapu0LkN7w63ip3l5BnxdsKh6qrotgt/7i+CADM8GnwdbtMU0TpUw+?=
 =?us-ascii?Q?H25KG8g/kh5u6HKY41a9/wq3N2fkVeNtSx/sQgy7OiUOIPRJZg8RApX5RBrJ?=
 =?us-ascii?Q?6itNHzDsioPrmu0RmeQCqfXBpNJKg3mtd+CbB4WdTUo9EmB41n3V+YFM55NM?=
 =?us-ascii?Q?i4xPzvpdS/TzRn6jKqbO2DpGdF4wMsit8W87d20zD5GYYWr3VuE6f91uB17J?=
 =?us-ascii?Q?mOJ8yFUSV81WjS6OqUi8br6JWg5c7Cq8RYwGV6oJfUmI81Uuhzt7Uu1uK7QU?=
 =?us-ascii?Q?xBuX6gTHCg4IwqG1REIqStHbDr+9Sdo4B57yA7EDy6N3uBKY06CPrhcsTvkA?=
 =?us-ascii?Q?5qj3JlBXjhBFq5O8ugabBZdi0vK+Jx+b7EdZ95mPtavHBD5gAPqy19SSDIR9?=
 =?us-ascii?Q?fHRjJa56zxPmCwq/wEKBGcXHdPvolRDIldTQz77AhL1sWDc8xh2qrU4ZHjR5?=
 =?us-ascii?Q?MBNr01G3x22KgNi/u1/G3h6dtIn5Xg2UbdgfA1EiSPDao7nuR3B3ClY8zfNf?=
 =?us-ascii?Q?BRZTwBPq/Ignt8PX24ezgRPwXnAMQupcJAVTIp6zKeMD6rQROM4xDamEqhqT?=
 =?us-ascii?Q?TMmXGoshP6Fk6JepOdcxbIduJHjKO8oo5yRZvCm7slkafuE+1sc6Pkorzxha?=
 =?us-ascii?Q?GcKUHOl8dNSHndHdPOmrDAmSjqhoV8SaYRonauV6jLKQ3Tr/lRHaF7R1Eece?=
 =?us-ascii?Q?43KQzmTQksKbHDQdBU2L74N6uk5CE3eFM7HSUnlDyc8ulqKE+8x54ZypecOt?=
 =?us-ascii?Q?AsFXaF3djVXtZTJaXcghK0N0ejwsIvOkM3+g1nVi4tgTGzYD5Ws4sQBFN0Ud?=
 =?us-ascii?Q?zUlWNpjmASAXxr9uGAI2iE6VHn8L6UrqJrdVw5ztZaMWxQwJWQOSFfZ33QnC?=
 =?us-ascii?Q?APRvG2jV6OeZvv18VKDENoqhsQs0PIev6mg1aeTR9/vBRPEW1MS623YmKONw?=
 =?us-ascii?Q?L3lKW/9t/+Yy7ygD1We6zBfYnVgega/cPRYLthetnP9Fyut8/kSqurt1BxAN?=
 =?us-ascii?Q?JDh73fa6PMYqXCwv94HD+cSGMEqYX8W+g0p9TRGYYozVjyTlVBeNCzjuX4o8?=
 =?us-ascii?Q?p6RVOW/mpO4MgGcyt59Vbp7Tw9GijTflfJULLBn3AN3qrbYClDfADFqzDJdS?=
 =?us-ascii?Q?mHiUXyhsTVZY01TCOC8KtD1+zSsUweLLts4qJ+6v7PvghrZ3l2lRm0ytrikg?=
 =?us-ascii?Q?rWQuQPCHCTxMBSb+O1FU/i4iZLgsKwZKZHyhekA4X2X1OCptGHx9O+YhrnjB?=
 =?us-ascii?Q?QlqAot925K/GQxUrPCwPbZqRUkYJjX3Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Czi1khrsVlD8aR3XZBXUbquDTw/zmJDT4ffPbc9kppISFh+pWRdHdn3lb/lB?=
 =?us-ascii?Q?oSb4gNISQ18OzLt/bHYvbFgycPNO3X4cI/tdpUC6ma8V0ZqjcDbtVfoZqJfE?=
 =?us-ascii?Q?LtxS1iw+a6ntHZnufO2jC2M0YF4IwitIDrRF6wv5oIZdefqLDvbQ2uHMdftm?=
 =?us-ascii?Q?MJ93WheUugl69VtGn6ejkP5mIF0rt3UmQJHW01h7cR3J3/liXjkWk5hK562x?=
 =?us-ascii?Q?KDOvtHye7GL4fX+bvpDahWjWLj7UwqD1jkepuXwZyyKKnR88ZT3Lz8lBSXI/?=
 =?us-ascii?Q?HOER/Ia0S7UuBaRFjKdMfqJAEG5WHIYV9hkLdDhvuS6xWMVbkYcJwbPr6mnK?=
 =?us-ascii?Q?b/2TZfDg17iw1CBYDmpopHo7OPAfh175ZjHQwJvlf2g3qdlFp2GTZX6ww6br?=
 =?us-ascii?Q?r3pPr6gzntKZqFwO7DGG5Q93g4JbvQSRldL55ylUeMGuf3uJlwSFbfT1lYLo?=
 =?us-ascii?Q?vbxf23WKqun4Wlq7ICHBzPgCztUqFu0dDYr/fEf8bhzza6IHg8+LiwH8RNHk?=
 =?us-ascii?Q?uOfEx5xIIzo078je8OuRzD7n4TZxZkFpJF/vmMBNoIGwSWrrmDmaz+CmNXgn?=
 =?us-ascii?Q?NEsQB/4XaDE2rgK2oJoLNJRcx1jxcNlsPYuJd7v+KqirtfwMQxpxNtLzskwR?=
 =?us-ascii?Q?Z9mXtaaVFOhHDzB3E9G9s9xWfBKqun7ywhfa8cQMVqARuc+JvY467bL89aZ0?=
 =?us-ascii?Q?93lwwD2JYkZOKvog2f6rB0253GRcu/3Pn0C7Em7GtjNx6orPmO/LXAJo+U/O?=
 =?us-ascii?Q?lzspgMt/UQ2mvHOMmuUoc01Rh+zMKNtVlEGb/Ri0J1VrpcWwCWgVKOdnaR/k?=
 =?us-ascii?Q?DaXhwhkvzWZAU2RXETjLgaGkJD6nBzxMl3smBykEuy3UN6cDUoc1qtlolq8L?=
 =?us-ascii?Q?KwUen93aNePYQ/6S5C+nZYbJBUIEHgGSfbX9tKmS3De4dFNyo/KJaBxWRPxd?=
 =?us-ascii?Q?y7Bx07SkNBuAgrVX8RkwAWwaNlusyiQxGEMON19+UDyeDc+d4FYQss+cKsq8?=
 =?us-ascii?Q?jkUB6JehMqhRKyX3TfmaqBvWKLr90Dt4nDc7O2IqfYBmoFpc/Ejg/iyPkDIl?=
 =?us-ascii?Q?PfwMCrMpyE96rX0KBoKRWMZCH0s13wcMd7S7kp3etad0+BtBkxKwSns78Lou?=
 =?us-ascii?Q?wzgJGGgzHee4j5zSflAhZVmbVH0zSxi1ik/FIf9JUDWiBJG33WUJ2UtElbv3?=
 =?us-ascii?Q?IZTlv4LrNUw6jes9ZC7ee4wPsDTxFEc4Ye1D4OTlmSXbFa8tnl+kzNPPAMfZ?=
 =?us-ascii?Q?/qPV57um+4wmHA/xTtfhybsm3C5JNL4MOyJUiKtARW0S8Fr5fNqEY1zcxsNW?=
 =?us-ascii?Q?UazaPFpmFfG++h8u7YGy668NPhonjO2AzafDuIJe+CrECDZ3XbkBd9AoisiZ?=
 =?us-ascii?Q?x6afynnnw3aXI+REOiZ3U9Zy2Xa1TXsfF8SzPZ/bjgYJrekQghDBeiombVzz?=
 =?us-ascii?Q?7XliVS/N4ILU3BR/eDMG3KqWg8N1jkU3sMYistfXkWhIhyJzH6W6q9gL3mWi?=
 =?us-ascii?Q?tNXRCw3+rcFYc1B6DrUpm6q3vkjKfRkVg5RQJLMwnjdFI4CYfM8T9xnKPggG?=
 =?us-ascii?Q?3Ks4W6FEAM1wjo0ZPRg+5lOUo1lcRXXjjw40I0dEFtGQgpvR/NuCC/ZLDysj?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ebde24-82aa-4afc-2236-08de1d3174da
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:58.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+nw0Rf+fh15EWLNoqQloRQFJEkDf4pcfiq8Jdiu7D2QVD5YDksTmfyoQcGTite8QNvCap60JoxHXqhc7m0OviXVhaqN57pwUOCjiAUoDOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9614

Do not use independent irq stacks when irq-pipelining is configured.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5cc3df56a58c..0e720f52261a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -770,6 +770,7 @@ config FPU
 
 config IRQ_STACKS
 	bool "Independent irq & softirq stacks" if EXPERT
+	depends on !IRQ_PIPELINE
 	default y
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_SOFTIRQ_ON_OWN_STACK
-- 
2.43.0

