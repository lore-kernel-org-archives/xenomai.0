Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795280361;
	b=cLG3h05Qs/m+rNO22gMs2UH4Kah9J9mmC6LMcvSFZtgGBVIHrst1qjxbHo37aaLkMCjJ
	 VE/MLqTp0NnDeIdAh+LpfRA7wKJp0cH3ccm8n+y3e7eAFEu6HukC36w3tV04/JIMnEnN7
	 98B9yBhkMgUuBpipj/FI3PkGtz06gBdfzXjsgD8/64V/uRbAkh111ay5OiqeFkE9D8omO
	 Ln1v+SLXUMV1fsTUZ1TLFayqAaiFBJEl2AxKT1GkOEzxoqrGaRxZKsmk8KQy8VgOR9V0Q
	 Wc98ojGoEvd9EKsABBeW8HjboQSQ2RzazF9v04u0htE+AZQcRxlwKxxuA17+Mvaragw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280361;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=08LrWeLfde2p705pQqC+oClutADdBdG5WeISlKr+SUY=;
	b=h8iltMzHv5uCmS2MOJFaNEzJmSdDJv5n47ED+nM9gP+8t61R/zqvfjtshKHiYYQBGtDW
	 Er9MJZVvfbjbs1InQMTnFceGHGdyl2mGCaDkGmQ5aB65O01vvtZgj5BIs2GxNYu8NIUnp
	 HCAsouP6C2iYevzyoGGUvEyOdgT2l1cWslSgS/R4DUjwVnlIw/ZTakcP2iLI2SIrgAhrl
	 Vkiy6i4bFJyiHDsUFZXRcnpzC7HhcEBp1uUYch9hfffgvCScGQJb44sJajHTp0GbTebck
	 g4cD3VLAFR4DZsBE/9AGamgAvau6HF/2qATh5DIuAWBl50x+wpNJORqdUAZvDsozy0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=RP+rBmOk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.61
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FF606A330
	for <xenomai@lists.linux.dev>; Sat, 21 Nov 2026 16:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61FF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=RP+rBmOk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyqUvePBxuaLzruYO+6VrVILfvJXz4RxJh1ELlJrYRcgeNFWQl2Ntin3GCZS5Yhja8Tc7im1xKcCWIqCBhAM0DP1OroHFHufwE9y/CyZLZhzADberuWrqFCtIKK/ZIgyL1lj4dr83rmkiR4KIIJ9U4FpuzLUw/izWLrV/0j7M/rY3TzWSXIhf1sm/RSjCfaI/YU0cD7K41gwuht/nc4jxEVvdGJtXECQqHyDv/MTeFj5W7FhBX0dojGz5uKrtqCJe3H0BKYSk+B6QvUCQ+j8c/P2oJs8Z9iVXRufT05tGGCyhHzPzWKU5sFYCajlETI+b/vuSKmoS+xn9i8RjqI0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08LrWeLfde2p705pQqC+oClutADdBdG5WeISlKr+SUY=;
 b=xWBqU7Ga4Kxe4PyAbvmYxbdlKB7sDvqVgfme5NCEr4xfNGdo/WFGdxNTCttMNOcTY21a+aSJ3q+FcmJrU7JZo6MoCObobzxQKUj7prcMCwFX9pZosOv8FU3s9ttfTywXE/IlK+SMWH9yUTj76uXeCHPmPPH/NsmRBQZXzdyOG7XT63qLEi+6iJQEZpRLG6eLuhrXRaF2usRuOzAcYyiKW1Vc8FZjPznk0WQlha5EEYsZGJLAINJftOunJw3HEaAts75T1EHpskGUdCIH1Nz/d2IPJ1VjCTeJddQSdJzdjslBnJS0v/xlYBZjqhiFtDyb7a0yfmJ6NMwf9hEr6xlTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08LrWeLfde2p705pQqC+oClutADdBdG5WeISlKr+SUY=;
 b=RP+rBmOkxNxQOex958Rm5AYqRlTXYunXhkJlCCUUPgl9oftxEAH9WqVed/omLH4cLg+BNiI10NKX+MtQEwH2bHr08tJEwafJ05rOat6e71i2SZrWfEe9gnGIoJ7/5mTM3IBUCwkKuxAJ3Rx1KWmD+l2kM6hD7YsDikwbssgzOlkuKtLlvVyh7/D86OwCdsybWag4Mu4SZPBODjOLYaVg0/t49AKqOKpcpOtJGF7CgCIXlzL2xfq5NxDom/PfrwHzQNpqwvb34LN1tksI8ou5ZB/DY1cgq9F9G9clDMDNYscN9OqpMezvbLH9g9NVeWv+AFaDgcsrEy5a9vKGkWKeKQ==
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
Subject: [PATCH dovetail v2 0/4] riscv: dovetail: trap handling fixes
Date: Sat, 21 Nov 2026 17:59:29 +0100
Message-ID: <20261121165933.57310-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: e247afca-8fc2-4c80-ae80-08df47f0c7c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|11063799006|56012099006|261022105027099003|10067099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	TQHDO5f9wHGYFJSdL57UJaYN/4v6W/c2LdmM/yVexfGXNDNDV7NstQ/eYBO5SwL5mHBewYDwtx+n0erWBfBI4ibHvEUB0AKtSn7PpFip1iMdao4WauTTKuKPTdLzGUr35sRI/APwJQPNPtvgLm4KfooL9a6/SrYL/nrWLOQyP5WXO1fXp5bUvM6HuwYqdyz1h7HnWZb4NsqzvTGj2F0koAgqXTBFeE+bzQkt8r6zYJ90zkABb669tTaJTN/vXNJCHn1iG76tt33mZ+L0Bur3w+4LiS3Po/cUX/I3IlzgHi9cIFTN/nZ9cbOrjQdyY07s+hVtbxTh+SS0GeXzfUfw29INRL3GIsWphofgZE/rSKJbKPARu4fKUJWpz5Or47qNf1zqqSluktVGZYvyDjcriVd740lot52j+h7icYWcMJHFMnaR2Ehz/DkeV1BjJ194uNo47m9IYF7l7+8rdQiEMij7wvENuOPTs2+MlxuWswi11a9l20vkR1p+pqi1whqFGoxEqd3fvVi4vy71CfhfUH/cKYaRWS5IutF30RuDec0bDZwpZfa1VBQZup0rcXvgDBVVx1kqDRn+RvnUYEMTDQcwgOjHEWnd5yawwG3SnNqhObKs8CkjP1FsXa7+xjHmQzdk9XpB0IM/kGmFUs0J37X39R/nSdlDKiT4dTSRoiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(11063799006)(56012099006)(261022105027099003)(10067099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhz35HB7srdORCGE3PcUiChxatH9LtGJq6RlU2DPRaz4iNs5wHKD9/bErHi8?=
 =?us-ascii?Q?GJ5h7QnjOfA07XvXXeGKgHULne7xQh3I2oAn1942Ufzni/SGGLmZ9kdb0slO?=
 =?us-ascii?Q?AzM3DS18H1g/m1PIWYVxefraQt3HbRYHPBFqq846N0m3rPciEmcAURhfIibX?=
 =?us-ascii?Q?t0PDe0GG3mewLWcSl9ihOgilJ7yuiElqRruXC/ixSGqo2qJH7UaXJY1eYB19?=
 =?us-ascii?Q?EedTUesfStQuc2HW/XjQBkWlBCklLfATTq53U67E4ZBsH/MxteBH29wXVMeE?=
 =?us-ascii?Q?h4DjReC6J2AMHR/WcM/vwGiKrT0gR7tIhonnU50+UVuX7774URbdnmOeVFZk?=
 =?us-ascii?Q?A3W+0UUKoUag8erD/rhs0suRfhBTxNGr2Nx7vBE1rDIw6rDjGdIVZvsBJx/T?=
 =?us-ascii?Q?LIq3cfvXktlxRo9DG42QKTtemdE8RLLHjzwuu7pziUejkkoRxpnWWvfd9l/A?=
 =?us-ascii?Q?ms1nC7JfUbljlzNl2sOwRcUqHWNhCOE9Sk2FqJppFegyZjhSWvPip7A7FXS1?=
 =?us-ascii?Q?LulNE7pyTBOvHTO0h2VZ44zOLM+6zSX07u59beWh8jqlJlp9hMzEce+L7I1D?=
 =?us-ascii?Q?GgoX7fllyo5cvjkv0LZgtgqM7DlXm0vb7snYbnv3Q08ui3rIp+l+gER8XbgG?=
 =?us-ascii?Q?srv6Dk7k2wVI9N1fWdCh6twc5oSzY7XYiiaGe93xcssNtyJtJHw/F8BRXMW0?=
 =?us-ascii?Q?Wa8zffNIABtmGFep0OEbgGX0LkQiI/7vyf9w/pCZhbE9lTXMEBN9FVUKVeOW?=
 =?us-ascii?Q?thVz5C0ChWa2B/NZxLFokmffPADlaVrPXvreMm7kA2XGYFEf78VjInK/ZIzS?=
 =?us-ascii?Q?4ooR8Xoa4X4/iqBncB+Wre4zRl1jC1uIYlZNAdTxkHUqN+l7xarIbSWGt5q6?=
 =?us-ascii?Q?YGzsyWEHGxx74nmKtsl9y1K4y2MwIGfXg4ZvpllXGJwxEQG3epc939Lk2zZi?=
 =?us-ascii?Q?1c95eDifZN6u7e5uJXgH8okVM/+ZjsbNo5rE+qoCNGBPK1phoH+BWm8qX07m?=
 =?us-ascii?Q?MC25m8MkMJGRTo971Mq4eWLRvIPCJNtZ2q3KzMRJkAUrpqp1RqTiO3vC1vg1?=
 =?us-ascii?Q?79hjj3I3HzlN3Ye00GvujbkyXaJKTb0/nS90RZ7NYdQwjC5/AaX+0xHJvtIH?=
 =?us-ascii?Q?vf8BpThg/sOgp4ltifuGCh1ad2BLsZkjpKHwrId2IhYwAz/P90I6TM0ckO4X?=
 =?us-ascii?Q?tEeoMowCYCjvG42ekXjMM1fuRUedOcsF8+XCrIV7JSplwXomZeKUc7c2wQBe?=
 =?us-ascii?Q?KGuH4x35dQ6+BI5HMxibsvXAxk3yZKfZyYUJAdK4tU24hZwfyDUHRp7CfUve?=
 =?us-ascii?Q?nrjvflfiTWrikn4amMiGjKkMEtmm/DeXC0CGoMZJhvUD4YOH9xi+qtRuIjs0?=
 =?us-ascii?Q?VcauIZKu5/aGSBa/rgVAVyf2EH21FbOxm6/YSLCFwdcAqbs5hT1csLInCvVb?=
 =?us-ascii?Q?vY8FxqDT9zoAdQvmJ7PI0A8TKkUuhMhXXP0FMyzwdItn7og9AOUvTC/pKYDP?=
 =?us-ascii?Q?BWM6fAt5x+LNgKZ8EFGxcXoE/NSIu+Z4984Z9rOLYN929NLrgVaVsfZh0yxF?=
 =?us-ascii?Q?zdu+879Wz5772wtGiMst+WtrYMFc2rlswktKj+ZBuCnQOLzKKEqFGdyrLQcB?=
 =?us-ascii?Q?Znxy/9Ud5hEckBia7QeJT3ca1vJs76SK9p6tP+Fz9T1ncnEDHR80m8Bd2FS6?=
 =?us-ascii?Q?Mus90g86P2DQjDY/60D/UK5WQ4u0b4t3nOo2oQjhp+LSXzqSrFJ1FG3LmJzM?=
 =?us-ascii?Q?k/+XPPUjX/dM3AY4Wl2CsyM2yznjcgpjd0NfB/71drartaRU7Knmof1wajif?=
X-MS-Exchange-AntiSpam-MessageData-1: ruQGd5P1+nmt0n/vV0qPG63KbZ8dCOThWbg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e247afca-8fc2-4c80-ae80-08df47f0c7c0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 16:59:17.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5943M2Z3Mbp/4W1BVlgFTSSlHicH4XkTIPTARxFp88yR7J0q/DRKSeOVbGkdx1g2h62nHFkI21tzGy7S3QoHXX0D2zIQwyiZLi+nHtmW5iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

Hi all,

this series fixes the riscv trap handling of Dovetail.

Thanks to Jan for sharing his AI reviews on this which made me have
a look at this.

The bugs were verified by running a trap matrix test, which raises
every kind of trap from an out-of-band EVL thread, with a more detailed
oob_trap RV monitor from the Dovetail RV RFC enabled.

Testing was done on v7.3 with EVL under QEMU riscv64 and on a StarFive
VisionFive2: the trap matrix test, the libevl suite and kprobe tests
hitting out-of-band syscalls, IRQ handlers and nested faults all pass
with a clean kernel log and no monitor reaction. For 3/4, the oob_trap
monitor was extended to report an interrupt or a context switch while a
kernel trap over a context with hard irqs off runs, and the trap matrix
got kprobes whose fetch argument faults within the trap, in-band and
out-of-band, under timer interrupts: with v1 of that patch the monitor
reports every run, with v2 none.

Changes in v2:
 - Dropped "riscv: dovetail: do not nest the unknown trap handler in
   software checks": in favour of Jans changes that handle this for
   all architectures.
 - 3/4: Reworked. We inherit the hard irq state of the interrupted
   context from parents state instead of enabling hard irqs for kernel
   mode faults whenever in-band now. Thanks for the review @Florian

Thanks,
Tobias

Tobias Schaffner (4):
  riscv: dovetail: do not notify traps again from do_trap()
  riscv: dovetail: run kernel trap handlers the core did not demote for
  riscv: dovetail: inherit the hard irq state on kernel page faults
  riscv: dovetail: read the CFI trap value from the saved registers

 arch/riscv/kernel/traps.c | 51 ++++++++++++++++++---------------------
 arch/riscv/mm/fault.c     |  7 ++++--
 2 files changed, 28 insertions(+), 30 deletions(-)


base-commit: 2089e615c61844a111f5a09e80a6a7e2959e48f9
-- 
2.53.0

