Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D120A5EA
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089941; cv=fail; b=qElCqJZrKIm8Y1znPgUv/MrTmwDGVwXEpDyGlrdz3U6gTE4iKSDEoBJfde0OSkJ2vwhNzYYR99goTUUgNctRaKEszF2JpIuFiWF5u4n63WV5E57lVbhJE0RXVvCjQ7LW5Q8c/4GutnD74mv+p0AYqEJbJGNFKGqqPe9pYV/OyAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089941; c=relaxed/simple;
	bh=HLaWrd348J9wiKUCHvHI/qmzbQtEPo0ry992lAhpy5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtNjFmA2757bDsoBaD0ie+P1Vhb2c0JjjA2jtIOs4f3teQFS6ZbIKOW8cunVYG1rjY23bVy0hzNoz5/QHAcG3WqrLb7mPS+XSiM0ZBpKHJpY3xuy82FM3NgRT20b61eknIq7STuAWo7DCl93FfwgNrf4Nq/akz7NOaxslZc98GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=B+tlrTKr; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="B+tlrTKr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9nhOTC7wv6kuukrTCQvhbLro1Ibl5tqDPudewwV1UhQbh0mTQ6vF0oLpRMnpfX8BhWOf3184/SOspa3X2cXB/4bIsxZyCQfFNo2FKtFhom9G9hN3rnAlRNdEExc1C91C8GWggYltkjGEJifxn/YeuAjmc5hp6/B/7JF5FB75u+VLRIc0sRmpgmE7GP202I6SOn5bXhKLuYr6QsVIzNTotT0rfrmL6yGi5PcBmTD6hxHKZke8luzx2NTDKj6v25mF1lFb5gkATd7lLi9PrZ3sHPkHWnrFLD28SEic+8zRoJNgtA/YBfKvKD+P0uHltkwsLxliDe4iJi5OEnTcIJHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQHYrTopBbIZQ731pmDrFWAbbpOPWD/d4cGp3YGJwEo=;
 b=Wt8R1wgrBWfAtezEpPBrsAEAXqgNA+frSNcnsPe9AkwGRic0X81cTPdlW+cRce8n0uFu5kIzNPYh2dNzqD22Bh+BY+iTOCF7FKs5ooS8N8hpVW5/3N+ttz4Fmbu/TBiqyYYKAGi5VjCXBDBcR0TrVexpXa98txwKvCIN9skz+9eMjKoAFzOvZA/qaQcSqvDzAyrRcGjHZvYQ+SK/x3ZEP9NgLFzEnxcmti6IPptG5mIe6y9mvVdUereggYttGikEMc2B8CLnz/DDFllM0FJ4OaumvyDRYdawswz77jBbMwo2NmJamnXzV25+OWta5C5hV99ojVKa9Jt600JZmA35MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQHYrTopBbIZQ731pmDrFWAbbpOPWD/d4cGp3YGJwEo=;
 b=B+tlrTKrifVKuLHl/c9QPuJz7qFQR3gujBrkmJCKdGYa1C6cNkxTQLbQIkNaeVO0uQcZLCfce6CguCi0KjFjRN0O0/57Ec7uK1c3MFgndfF+lDQ8yYW0IrSOm6vZ18TNp/kX9prJKHl9vBMaAZnnEUd1hnaxn4BXFoGZC5/0RIXVwEZsCivYg7Ik7TK87TsFcSUfrNxF42l51vBOu21Xbx5t8+fFLeQs5CNBkCyuTozMt/IDyju5F6UE8CA6J2cGbzSC7UMBf/BGCT6joCvT5Gy6ZX7TjdYR3a1NShgrtSJmZmgJ7gWjTm8D5mGuvNgUP92K3T2TxL6xpLXQcGamCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:14 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 1/8] riscv: fix interrupt enable/disable order in native_irq_sync()
Date: Fri, 10 Oct 2025 11:51:49 +0200
Message-ID: <20251010095156.3756799-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::20)
 To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f31620-2361-489e-ad0d-08de07e2b097
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbSxxytdmiu5DaId0/Fdx3UQPARaTwkeQOvpH7kLv0ptGMn4NHUYo347T+16?=
 =?us-ascii?Q?556w2/Ci4ukI50VHbomVQ7njulDhXYp7+4+9F2Nq3u7xeLdpN+o2wF0dkAbJ?=
 =?us-ascii?Q?jUBi6vTBsh6VbGV9fXaU1gW46LtXE0QJ3IchZMcAzPZxCPbr8vaWQK7R3VG2?=
 =?us-ascii?Q?HLwe2zCxNWHTzZ6VPi4bBThbx398ypqHdQzgpfo5t4wGxSEjG6s9ezclocmq?=
 =?us-ascii?Q?HDGGWVk7yBJ9qW/EthQIhHz6wFXJkt/+ObY6cZI0pOc7kX9nT4tT+8Oa9X/q?=
 =?us-ascii?Q?k17kI9E2TVKPhptMHoxt2sRMJQFn/QyOueSLX8wHpjZDGN0auoSuSs/w7Jbf?=
 =?us-ascii?Q?8QFXaRE61XFcsFUSOIozT4BWKTmO4lnU4KYQTxXvpOrviBF2LXVKmE1A+E9a?=
 =?us-ascii?Q?BiFmJJBKivpijCtdlAsChK1hkGXVWMRmk7SYMM7qRhhcfGRBQYACtxRK7v3l?=
 =?us-ascii?Q?58j1OMKJ1m0qxA52vcXYb6bWKiHDJwcLWYJAUryYRmK90bqTCdCUGnHPAQ/e?=
 =?us-ascii?Q?HcRB9WVXbizQSmg38HTSvGYuMpwWzNFvqiE3DujWKdglbtz5vmndV9n7adfg?=
 =?us-ascii?Q?urCYQoODwI3OIAQCwmdTeuRjVOEOc/m9ZuGLGUxRGLgPaKrmIZaHVtRATqEt?=
 =?us-ascii?Q?MRcgHmq8DS1xG9yg5B7EdRlcO2HtxGsTeTc5pFV3orQBlzb4WkOghKPOB1Jq?=
 =?us-ascii?Q?JLV5ZJEYpOYmqS6TPXMEFuVd9Qv8ziVrN519ZNgTV8XOnNlnxatdas6jWWi8?=
 =?us-ascii?Q?AFQd9NvfnMPCM90vuUngoLfyKimJABs1eRHvqikQVFKxxqhUBxZZxIfnM1wQ?=
 =?us-ascii?Q?vJCyd/0sbpWf4XDZzEK/nuvRCqRNjXDhayf2fawLNIpHDzp0oqnzVAKxx19h?=
 =?us-ascii?Q?7rhRCIy8lpQPvdORsAgMv00LH56j8GdyLoTc3i8mK5/K0wXmPTQQOnO4mJwY?=
 =?us-ascii?Q?eP7ZFER+aBWYUuXHmcpdlH9xp1iRreO6Hl9qBgzWD3urlwD7iD8AdCk+d4hf?=
 =?us-ascii?Q?vQMwIJ5sMURaXzr9/IYUoJZkv2jRdj6tMchh5PH3ivxBiOyYvvykE36U7b7J?=
 =?us-ascii?Q?kB92JOzrEudrxJxTiJI7WCKMW5rR0oNDPq/OER6/iPaORW6q1F+CRYY/UqNL?=
 =?us-ascii?Q?P7CGVSoEWqnVCPLGYpgqugg5Nb35dIG1ZK83GxIWZHrM4z8w7Meauh5kynDf?=
 =?us-ascii?Q?P7Yih5FZaF0fD9Qm+4mjMEhZ+wFQ/Jtfpu30oBChn2XX+kcWyS72QA9ggsJ+?=
 =?us-ascii?Q?Uo3/KehVwunJwnRRM66MYohNdCJVj+9hUcN/H0cMONnUk1WQdXOyuFPct8Sa?=
 =?us-ascii?Q?NAd8YaCeByPDMNfyDUxnZEGekmLEHJ7/Gjts85Mr8CfPgFbNcaAeO2N5/qjI?=
 =?us-ascii?Q?N+lMa0Ye/1NrbvMwJvMgEbPET0jm8MInixTj/P0nNq7oa1RuThkbxkfjQgs1?=
 =?us-ascii?Q?6z6C/JQ3jnzTElbaAM/KfVS4827tStCl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?msh0LofyVtRsQA3gmCVOQ2wBcgntRxNzo7gw5rUVE0TLii9Ew46WGATzvPEZ?=
 =?us-ascii?Q?P2FwkOxyba5sXQaHonxEg+wCYvBBmVjaqWRvioKfPOJQrYgeKG7He4a7qzJM?=
 =?us-ascii?Q?b3StvdSIV6wC4RPgn6fzoz2MsXbh/dwtrvl6NN7yoCUgV81jkajSnfPbtjbw?=
 =?us-ascii?Q?31ip0AY1uqlPEwoSri1tEgYDoZxZ1L1gEmPsjYqcIOACUOmbKFKxm2WwJHal?=
 =?us-ascii?Q?ez1Qur+XULfvKA2o/URlGSK4Bck539H/32ELPWPn+5DfQFPQWpw4I9fP9RCC?=
 =?us-ascii?Q?355NWksdptQN9p6tXFBqlybymEVCYH0khHcq8wIeKWhzoi+5QID8RtYwtxiF?=
 =?us-ascii?Q?uk4n6lPqlngjjyG8eytD00TswdZYOZMYc6xniFWovr0kWOYh2LupTATZMsu1?=
 =?us-ascii?Q?7G6jWvzQF0W27wkuPS15PhJndkCc+ooFmXKtW7yNUBDa8iVD5LKm8OKT/mnm?=
 =?us-ascii?Q?0Xp9bcI9EWo6QdvzkdUx10dA8GjfScnIbuKVQT1ylBVCTJSUvwAwNbwAVzfl?=
 =?us-ascii?Q?2Jo5Fbq9aHcmwnN0GDVQ7X069jGpWlu7jYP7nu9ElRpKeyWHoLDR9BX5se7F?=
 =?us-ascii?Q?PkKpjsr2QkEl2ctW9mMsAS7d1O3UkilzAIFiOssW06xn9P6c9Y4Tw6aYp2v7?=
 =?us-ascii?Q?eSt6wShGUAHCrGAO+6MNefYM68mX0JGpIp1Fzv3OPcN27JnfGm6QCMdc8/Ns?=
 =?us-ascii?Q?76b2AYs81A5WJxSRhGxWX9ohzWG5GNhS7BDOXeHoyeAZcYr7+2RQ0U+MVgC6?=
 =?us-ascii?Q?edwllowCkAdvOwRnTcn9H6kSrl27AGTGXTWZXbEw9lxw/miTWHq3/qBwpNbF?=
 =?us-ascii?Q?ni5+8J2UUkYP9ydHg570WFtgvi/ElMQrVw96yxnnJBZzqDa0vt6eoWAjjG4A?=
 =?us-ascii?Q?3zLmHx6ymrvQWlXZXFVMRQB4wUEmh/BpbvtEeZeLipwnOELLN3mPkYyfI71O?=
 =?us-ascii?Q?e6RYmHnULwcaHk3X6aBsm8K7OavRihL515EYSQ4b7UTeXRuVw4ncCI9IAiny?=
 =?us-ascii?Q?CJi5Fi/MAnYpPh8Kh90yzDvKcP6UFzf/F/dr6S9qycUcwYZaCX+ZEs2e4z36?=
 =?us-ascii?Q?s6y1nlUBFD8XBA4dcNsoJTVc3iApl3CCJNHVgRWoGo8PZbeLFdIVW2GWjj6G?=
 =?us-ascii?Q?MRVf3hID9M8sgCzKZOgY9qX81iO2Su6tNIAjJaqVActy+gjALrD0kxFs4R3R?=
 =?us-ascii?Q?yhL12LGzcqZWdvJBo8p9+1TcpRFitg/LUO1eRlfx37ey1lQyKg8sudJdR6ER?=
 =?us-ascii?Q?O79m5++hKQXHIYiq+Rp21WBdMa5HOmoOIFifzTgaDpaU7M4NGuV/Ic41gA72?=
 =?us-ascii?Q?5rAnhosKdAPDZRJ7oCdA76rlUTsTZKvp+tHobyRLYbJpEbOiy/FDdCUs5kbD?=
 =?us-ascii?Q?puNCwG0oyFBL4BaAmQo+SqPpay8y2pTJrd5qkBdkg9dCGKF2kILZacLtU/4B?=
 =?us-ascii?Q?ytjToPJpDwKTMFkssTG0YkqFmFHD0VsV1gNMTR3ZPGB5RhD+pSh3oTnn+Ri1?=
 =?us-ascii?Q?ZLJLNIsLXk3xPIE8HDhbiUwYyQVKu7+f5Hp1ruwWH0fvGeDJ/Zy7E2Z8Sw0R?=
 =?us-ascii?Q?k4SGeLSL10UOjttZgILtRp2EgjZxJqKBhKJjRvtPU5LBg/VPRGc0VQWwFB6M?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f31620-2361-489e-ad0d-08de07e2b097
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:14.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu9MyJ2baGj09gjeeMYk4uA9a0ythiF+yWx96zj6cUKbQlPoK2XDDHLzsLLVmiaYpJVc1RRLb5+Q9kwGKH7mgQwPcKVhhmD43qS0U+/jUjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

From: shannmu <shanmu1901@gmail.com>

Correct the sequence by enabling interrupts first, issuing the memory
barrier, and then disabling them to ensure proper synchronization.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irqflags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 839aaadfc036..d488b316735a 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -55,9 +55,9 @@ static inline void native_irq_restore(unsigned long flags)
 
 static inline void native_irq_sync(void)
 {
-	native_irq_disable();
-	asm volatile("nop" : : : "memory");
 	native_irq_enable();
+	asm volatile("nop" : : : "memory");
+	native_irq_disable();
 }
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
-- 
2.43.0

