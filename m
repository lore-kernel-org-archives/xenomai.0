Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6732B9A9
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432714; cv=fail; b=SygXUlGb2vZWKdYiZB5OWS2+fXpzNxgB+Xxeu5FqTfpN/VeqGtkH8VqszOllivExkibBAEQMkJc3MEJgvXxFrCoBFVRFNjNl4vldkDA1T6wD9zM0NWrkhCAahrGfiPFFaVZnT9CYkBhw5xvcmQm/5tacjfjeuJtH4mhpVjyw6gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432714; c=relaxed/simple;
	bh=HLaWrd348J9wiKUCHvHI/qmzbQtEPo0ry992lAhpy5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFmpQPzBW6lYLd16ACgMqDQC6gSX2zvOgo/DBJOTgQouML+5F0nQ95lJZKtgv7Mwhbrvu5ahO9yulXx76oZhpqqt7GSTKWV35tyXfGfnxSWd66h8h4n9SJATUsyWjJ53lP6rbJlYGfG7B9ZKGcajlxY0CdNIUD51WP6nfyQXnb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BPnvJ+z9; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BPnvJ+z9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le+AeANZTWaYdNAdsWdggzbOd3EdXo3l+7HSkSyrGQOgNlD62vafVG2LX5ONLXNJxEJmfWBdOssr4a3yVVner3y80iHKXxUxCyOac3nL+z3YuueZhvvJXKN2CMy2FMtF/pplMK5JrUD5MHfGTAUT8fnR2jsCPX/UFkgz/EyConRUTOfgGacwuKUSOdCs3mgWLJRvrzJUmK+c5E9KDurX3E+KgRiY2Ec4O7VvT8ypqG1VaD8QXGfFNTbSam1+06uvkREbxD1rJm+F2NZzAyEqawZbTjrYE13/mSzjxvUolNG5WtmrBZ9ykFknYhWPyHyuOncKDtkULyGbcCqz2r8sUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQHYrTopBbIZQ731pmDrFWAbbpOPWD/d4cGp3YGJwEo=;
 b=eVBRPBYaJb6WbjLaLNiyLiwg98spEX/XLdFvhgndMnUJNBT6OQjCvowk+yzS3DRZIh/N5oFA8GH9ncScVIArs0/14q+FdwhS0zFQgr7KkrL6UOuQvSNkEqNfU/uEFGFJVEmQNoKvOEmq037ZqiWh4lqKlW7toOOvJv0q8QQLmNW2c2j87h+6i2IQ0H1hiAGnDNiE6RkXDut1feCLc6ObGXqQMkg0DaOGqA32donnHj/72Gu/wfQfygWM5fIekvf+F/Ml04C5hjazdweZJXZpfUQCXVIE+j0cSmujXE1XOGuDeeYMN4rZsKE9cF8JVp651v8iSkMdCDaiYnZIgbUhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQHYrTopBbIZQ731pmDrFWAbbpOPWD/d4cGp3YGJwEo=;
 b=BPnvJ+z9TRINeoTO0iRf4d4MU323hgwypJ8Wqc2/HTSYJY75QeBKGRw2kTkdrG8La1TTrSG299QiAGsoELMYZy+axAtDwLHSbTjTlKDGUa7mQ1JmfWGZ3kXsnT3Nfv1rVgxWGjhtplPliFIfdCDNyeAVCjGjYGUIEaAOVXCBVLEtxjUDeYAq1eqpBpAAjg2IYzRleIx0PTxGR2gueVaZ2VtM9cwBdFcZTZlFhtt0KyROQu39N0VA0hGSj4Lmy6iDMj3Rn5AH/0FwREcK3zallyBaQYWLcTeLWUC2T4cplhAAVw0jEJTZzrB8PmjVi6Lve1NYi6CgkS4QM+Q6NXNOpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA2PR10MB8819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 12:38:30 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:30 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 1/8] riscv: fix interrupt enable/disable order in native_irq_sync()
Date: Thu,  6 Nov 2025 13:38:15 +0100
Message-ID: <20251106123822.1160385-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:610:74::14) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA2PR10MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5324a934-39c7-4b52-7fdf-08de1d316418
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YW/hMjESmKji7Mxqkx3coBpCa4jL0LfHD3AA/nsIrA+8TeQZhe+oevi+zaRo?=
 =?us-ascii?Q?QSFf69RyM4mwDqfcwTkPlAIg/f5fiP18arcKiKGn7HJK2le8DhAOvAMEJN8T?=
 =?us-ascii?Q?AJL4BgJBgqE+qnQqXC/hRNzgc31S+lwqCHXh63tfXjFb+W4OMsXUUzKXLgBf?=
 =?us-ascii?Q?Fqfvy2IxH/XVAcgkLVp7JTynIsTLocRrGN23SYAenZaBbV8PF4R3nHrTlo6F?=
 =?us-ascii?Q?ZBUBSlLvDT7dS1j90MjW1ykMtFjqkz2wcR/DO8WYuvE0j+zk/86LdBnTlAfh?=
 =?us-ascii?Q?DEj4Mgsn6xOFBFJSTy+ruj9F7Lz74zDCjLcn2XCoX83sQwITPiCBIjR5Hzcd?=
 =?us-ascii?Q?t8RPF2q4AFtyAEbOsQkyPlXIQ9iRq7vOdFICcFDuNzxkkELagA8WFaxokaYQ?=
 =?us-ascii?Q?aXlf39IemUDHQxLrDfe5rPP3CH/PWbWJSj6r2ZpAKnkDZU1BVVginBcrxJfw?=
 =?us-ascii?Q?JzVy3/3DgEx5TZWtFKe2Ctd+WUQe7aHgujXzaDT2l8954DhEfcFI6KN3NJcy?=
 =?us-ascii?Q?S6Y1JUP9rgwE1lnWkxcHbsQUx+E6N74nEFvhUsOpi/11ko296v84Ch7Ezfmr?=
 =?us-ascii?Q?Z9dI9jI9VrlTq6K8Yxp78wYKjk0An7Xf6MCSH5ogdejfb4N3PSotRmn1Un4n?=
 =?us-ascii?Q?zUL3CQ4SqXWVavJPt77G0V2KM8tVVvXw6oljQ3yxqgcraiJOB4smd1C832Xd?=
 =?us-ascii?Q?5uDjL2NFA63xLJcckRkM3oEMOTklCAYJlBOhgAihbHPkUWwx38GKzkpV0lAf?=
 =?us-ascii?Q?x91LUEhHe/SDmEP+5EFkqBFVUfnmMmUB3PTo6/ksv7yQwnuz5RxUAw+3U5/Y?=
 =?us-ascii?Q?zEBLZQSnMh1kCPUoOCVXnaj2qhohwqhbRLDNFnsavIKHslT6UGSQLz1gX7So?=
 =?us-ascii?Q?QuAVe2vMNIQxzCkHFXKOzVItmj1lB1QVLiJdo1Kle/ZWELW9zAD7okMk+z8D?=
 =?us-ascii?Q?duUO8OZ8TNzJ4ZLXDBfD+VUcaM5eXnyKgOtaijpMaym48EAi5hTu8EX7IR5f?=
 =?us-ascii?Q?YnmAFzrQ1HSDivLURwc+WTa8rFPFQqkw1E1UUTO/Pm3kg+/KyjJp2u0cbdkM?=
 =?us-ascii?Q?PMVxhDVVx3rlRteZ6GAoaGmtkuDoNfmaC+hOALHHv+apzv5P4WGNKgUryKpc?=
 =?us-ascii?Q?YM14gozpotm9EbqbDxOYe7Icx8N9GCRlSFsNbU8lmSzDlJ92VzNUCE377CCN?=
 =?us-ascii?Q?pX70T+Qxh188THBqt9zpKPIAquEAJ18TFv4ssGriVinJD/mNstz1jnF6WECp?=
 =?us-ascii?Q?i1rF3zUH20K3uZIYal6fuZfinxYaJGm7CTAsxryEXdwYhzHxJIb1A8jJQReB?=
 =?us-ascii?Q?MBKbkogYpMFzKxglIrRQ+zd8qgq2imQBFzUzGyjY2jtyQ0oZk7BobXxzOc7y?=
 =?us-ascii?Q?UMmKcxSwO2JZNRUrU3cMQtFUJIRutajwv8ctY5u9qUy4U7KTbS1hx5/M/ZUP?=
 =?us-ascii?Q?pTsG20XTNF/WP6KLWkV2SJbb3j8pgaZw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ioJbYshNScoATqXukdn05taybjBpp49c/YOUlE1Mr48lNB3jOKfVAlaQzSGt?=
 =?us-ascii?Q?2aof1eGL5oDAG1kOkLfUcO4P5c4ElrfMzt8bEvRVlVwtxHSKl/io5b+C9I/D?=
 =?us-ascii?Q?dwqKtzoiYbMQkAAXMiwMin8OVWQm5Cs5cDVK4TNjBSXSgXDlKBX9OaBBzK/C?=
 =?us-ascii?Q?PkZ6JLFYWWhdZuLeupTn2Ud1A+k0AylMJZNDxTdlYL68MtW73nygOtVdxdtI?=
 =?us-ascii?Q?o9X05ixkS+vF9CC9whvCt2jETsz6M5DShclpHlwj/3E4nfTuKzRw7ZecApaf?=
 =?us-ascii?Q?FKB9Al5kimeMYrFg6gDvLOGyp4BjmaYaIu+KIV6K/cHFjD3ZOA5CY1RdrWeJ?=
 =?us-ascii?Q?8/eCThQYRvExldtqaGG3BBVLgOWzFt/4btLbP4ax9+1PcQaMlfbr7HwWKjkO?=
 =?us-ascii?Q?6YCnvxKrYGsRgMKhHXT4zG9piyA01VYiNjCFgtYbrtFyLxkHCrgHIBMjynb9?=
 =?us-ascii?Q?sxG+tsPKbhNhP9avtY6t14Pvswb5CN0ueLjWhF/EbL3xVkM4WAJX6GT2orod?=
 =?us-ascii?Q?RBjXTjza7meW40dGE5wOf8Blu7h3E+gAfEWvBsn30R9PRqCLa5Veit4X6/+f?=
 =?us-ascii?Q?W4phiWV+OlgHwp7cRnJuQhjAHgDDBaZTIRzSkwF6UIATKMK96C5C5pD12JbO?=
 =?us-ascii?Q?GVG5mK8vTLD5NIY8hlpXHWzFK6AdPuCaqmMq7fKwIq57sG5T3ECBig2Bll5Z?=
 =?us-ascii?Q?rzJbfrusVPdDJoxweOC/HPhlPcWXLi3gXEhsJbPEouYhKfBN7oMDmjcIclDL?=
 =?us-ascii?Q?6Mbz8lKcaue9gr6sUm5EHom22pJHXJBEWOz+rvn6euvDyGizPb0upQt8KalD?=
 =?us-ascii?Q?vASGU4VMX2QqGtd5AdJbTbvXGhhJ6o03pgQ/iLgCR9UQg+xkvesF9tpztZZf?=
 =?us-ascii?Q?wVTUPSOpMaTAP1MRC/YU/QDBWR+tTjhvLHEMKLeSNEpObfgYvp2TVE9NhyQZ?=
 =?us-ascii?Q?43irQFRpGcpwjtvc9Nw+58gobrYD41JIYAkE0WZGh6i74xTAvpezRmW/Kmu4?=
 =?us-ascii?Q?hbX/Kow0ZsLEZkn3TMKi5Y4iVC2YsSieBOJ0Q9RwL9+qxzJqSppvUtHm04qN?=
 =?us-ascii?Q?GdgemvHrCB0tgi9ofihSA6Lcf5QDD8bjbJj6bu2Wq0alfdBEy3NG9XWa/kAc?=
 =?us-ascii?Q?K0XKnVVZJp6Hq5bJ6SfzX++lIUDNm8bLVNNSxUyYn6lxP/N1B6t4pVjTKXxn?=
 =?us-ascii?Q?/v4qEq1Clbka47nb0rMSic1Y+uwv0ySuw8gBUnEu7Na1+pXoBApWqTeWKH7Y?=
 =?us-ascii?Q?IfpqKs9KS0Mpxvo1z1SOrSHktHFsOv8VQLZKpc+FjEmt0qUr2CS3kQWR3sy9?=
 =?us-ascii?Q?UeFUEQepn9UuSXgcVBfi/jOT/z3l3zqoFh482xYrw7v12FhGqPuRCXqwX1nP?=
 =?us-ascii?Q?0huFOpUp9gw9upAIC0Kzm7E50clzc8t16PSyhow5fkovhJdIuo21tWsAHon6?=
 =?us-ascii?Q?1Q9BRRbzPl9FcWQd2fZdFdVhA8hl8nNgJzVf5o+56oSpmbbJybCc6DjOYRkK?=
 =?us-ascii?Q?DBbx29Mv5kfKbrVr8Oe8U8EXJrqIaSmi7cfXaTZD6npfMD9b8vdoFyRhXbmP?=
 =?us-ascii?Q?2HBkSQtES3ahjZSx6r7ucjoMt3eYk7sVJ5AlosgvmrtgPdYKC50+kBh/5kPv?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5324a934-39c7-4b52-7fdf-08de1d316418
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:30.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQTjZCOXWSC5bMOZWhwO8dL47ZDCi3tmlE8862Zku89JHiyohBpm6mDtL3MpjJSGdnrm0f+ej2njZ+L2r+jShW8qF5/EgIUvDiXHJ5vdy+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8819

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

