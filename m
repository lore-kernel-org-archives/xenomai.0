Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515C20A5EA
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089933; cv=fail; b=QkUvGCi3+iF+TYja9P9rYbMMqqld/814O9WPDs4XsiupsNh2PVDY2rbzs8XWABhQxo/GHfQzW8oFYbX/h7yFTglpMeNmAe2IqkzyLdaFQiXoNOCQfQjpzaVDb4JhTPZmKiWGvyMwY7cye4nIyN2uXjywcP3BGBoA7XI/Xy8jggY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089933; c=relaxed/simple;
	bh=QBEEiaueqzI0zZtJ/rGVj4DflxCdLyYRfeYTPt6rFg4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pPh5sGzMxWLxm3PavjISZQ3DfcqNR41py/3ESzPL+2Qt18iMmCEMZ7xW0E7RYH4hKOM+eTH+AGH5zreJHMOYlGdwRDgWNnk2+wRwH9Ed1NAz3YVQFZ5iAuMbM0I5WppLPNhlsxjmzo2xIDwCXEa1BhIPX+ywfpBDWL5qdEg+b+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pgE0vm71; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pgE0vm71"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr+rj7nlzC4DTwqAoU7/x2wTscNrQVKYmy3D5nHj2ZGk2dvoHHBgoftqGPHRcd+Y7pTvT59k9laeRLVbKR2/Jhzam8NCdGLL6sLa8CrRyI/gaJM7NVYqBXAEzy8DVpc/ZCBxX4e5/cCQ+hEE/1tFOexEBLlvGHnHKgXEsGNCaeDCIHRThw5dzPmgW4CdEhjy87MzxkS1n6CPpuMen3KoUCnCAhIB/zOVr68pJnTyRQUfRIXsLi6+b59W4gTRvgqP5+oME38wHe40cczOTyvYMzNPuUjcqe8ARCEqH53jh05g+7wXZufpf0JIsdU1kIdYBXIpRau2x82mIB3YpY+70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/w6JAyNolG1XjZ2NwX8EG45hc+FmUYyoGwHBem32B8=;
 b=Wa/K7nclctFJmn9S/lRYH+tEMW27s/OQMpMsS0CDGqsIgZHVT1123n6KcgeQK4d54jwGdLoj6oyRTf5Tgfgwtt04iHGrkRQdxo6/ml7Rzh+YVof3hiw/vHxbhTnMI3wSFU2/PNiInoZ2KxWXUlwfvaSFIaQjgW221hYatBRE3kDDpB/AJ5r5uQTcTO4SR/FxM09tnqN+RqW8eu8LMRDc7OcxQsjmVzuA5uens2TrxIYzkHb62m/x/8RUTK/jLvVaRIOGMDVsC1xGGby0KoeqEklA9IBWQyv0CJ+WdPhPL/ih4nTTdJhEoGLWex1vyufXWFwk81iZ7EpwIQ1EC1vwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/w6JAyNolG1XjZ2NwX8EG45hc+FmUYyoGwHBem32B8=;
 b=pgE0vm71kjJOlEt4XmhLyl0JdqzB629JnImFvZDlqQRjSUopBgfTGLRG26gCVVEnrBJJy6ov72i90uvsFrryL7GgBj6rYmEMpuRKlV/rbitHPlghPktBtcuPUvBiPuX4p9jNSRVFK5WZKQ9JBN7IhJTfzHIJ7jMnq89xLCHZomgyCAk/5SLupxV7BUVB2bBv2pj4Tni+j30Rz3DeMTy9jgOnICbGWWx9HcNi1W+xI2NQGmglRiJKKLQdwqX0UH9OrLqcM2d69+X/HrOdKP8D7EMpRCxH1dXaWTrIcU6XQzuYsOQsVbWUJo4ySbkGvUPnRRjcF5PS+NSITUaWu1wkHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:05 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:05 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 0/8] riscv: Add Dovetail support
Date: Fri, 10 Oct 2025 11:51:48 +0200
Message-ID: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0092.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:c8::8)
 To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb3cc5b-3842-49d5-0897-08de07e2ab69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W88rg8eNE/TmFAJ2/pAU8/LGVyHBNYeN2KCBzMZ9twA+wpgVuI7mn1uSXqe+?=
 =?us-ascii?Q?Vie25ZEhFNBLsGCVF8aYvcQ3h9u+lOhnzp/83HlnSiGLPYfPSLZKxnUdndM2?=
 =?us-ascii?Q?nZkxX7MPENqwO1ClNmsnOoXPTMRR/+FC1HYaRSK+wsnLBBiVy0hhQg5LyrbQ?=
 =?us-ascii?Q?QZmk9Q7AHavinESBqJW65sXOhWB8B8HVd7/SGSWrMHkXo4L9JaqxKwtwYV4l?=
 =?us-ascii?Q?KbBoofNdrOxpp3u7sfimz9qmykL2F/sxbLmbcoaVyAJBs+OmG1/E+HDO7e8q?=
 =?us-ascii?Q?NVWVxaCPA4SjiohmDGIXvOVF0ON5Y6+2eA7Pmg8+aqRAcmPl8o1OIL1YeYP3?=
 =?us-ascii?Q?IB+9hTs1sYaBDdi1cJI2WU2MOZlt2hDA9+2e8y7MLtiEXI8Q5KWg7b2bnGux?=
 =?us-ascii?Q?QYu2E0RP+aMgZqLlqhPCP1Taa6f+HQ2Ev3FxQy0r0pSYO79OCyah3XGJmcSn?=
 =?us-ascii?Q?b0A9ne4djOv84GuqyjIEhjAAkSiwE1tVmMdnTFRoq7U3bnOsv8OYHVOnjQbe?=
 =?us-ascii?Q?HRomYJtdqfxkq+q+ZTSWPvBFAsrmi6SyfQgGlPgEs62op/XsEcu2n79t/KiH?=
 =?us-ascii?Q?vyn8OcxxEbs+2ce8zOQfGJqGtel4JwuzF/4kZJhPI7PKWoO1wxJO6eBL86y1?=
 =?us-ascii?Q?WmR9sadUTnb+I6onSc26GsP8Mvo2HRnOGNoPbtHjOAU59JaF2ibt3ikIkIb6?=
 =?us-ascii?Q?Ry2sNAs9fwJ09WchgEYWfRmS0w3HAWzzmj9VFLyuyDIbJJkLQriYUAYU+NQs?=
 =?us-ascii?Q?NCL04WX5EaVJxA++FNafjpPdhx7gsbW+Gk+eEco9opcP/OURSbDYisj9SrO3?=
 =?us-ascii?Q?xEqXmXaabg+yLDGzWyJQD6SaEa/yCGfF/rMR2B8oZA7uVGYXXb/XWBetfnj8?=
 =?us-ascii?Q?XwzPVYLTgRZUaqQ07yODdu7uNyvT1uI9MTJkJUAjuw/UXmdwPZYLPgIBPGSs?=
 =?us-ascii?Q?tF51Es0HD2Xg+XQFcMf4ysJXmowGZEl4VfjYmrhr4w3uYzhlTcICxSDURnd3?=
 =?us-ascii?Q?HBOhqEFjo+TsUr1H9ato51vOloJMPX26GBBuqrRiHSbyDJFOG/rTanjZEvM5?=
 =?us-ascii?Q?YWgpnW9Yhkw+aJnMcDuhDdSGLUjcRyoR6fmlSXRldI503TkPFm9XCQZyxhLU?=
 =?us-ascii?Q?ZIuz1TZpF+LLxS887eKqWrtvtDM5l8v7Lgk1M07+kIVW3nlhWt4PdtSlFE2z?=
 =?us-ascii?Q?CK3xrjp2ATY2zX/9Lupfmfd/WDNvWV16uMUJtAkzmV/v+/xu1DQyASUD2Bw3?=
 =?us-ascii?Q?jlnvTX3hElA/IP5gs7/tS/u6m3ayubpXBpUYabj8bh9H/A1pJvU7vpw+ruIq?=
 =?us-ascii?Q?zRlEgW+KDruao2RczzXPzcZKCISWVhbmvVAinUgAdkgK/sLYD+LdDoBXgsdu?=
 =?us-ascii?Q?env0PGKh9kUE1bcROSv79blL0HsfyBUCV3+97YNzlC12B047+Jl7kkFoudzj?=
 =?us-ascii?Q?DIcH3pBvLIzMOxRV/ZiFE77VsG26Ms0m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Ffmu9Wvvt7FeBtMuHCp4PjdivLvkqbQvx42hnDnsT+DLKO1JjHk0G2yJe/x?=
 =?us-ascii?Q?HQ5WJ+MdXcrABhKLLYEc1/TyzTTDCK3JUZgAiq1JwGNpVkhFzQAr81uZ/Xn+?=
 =?us-ascii?Q?wR4HHNLXNSyi3hJLxXBcuk1crgsFZXG4KQhI0c5AHfnxNemTc9WKiCr/e8EP?=
 =?us-ascii?Q?Fivrzs2a91Ksx4fn3TYyweDZFesES7uBXGDtM325KMU9wWZXWjTBOraaNrDS?=
 =?us-ascii?Q?DN4cHcEIGDqZdiz6tb0Gm5IOwm+ay/wJQQKV4tMB0N4lb/wFrXFw0L3Kn5XK?=
 =?us-ascii?Q?DOdMtkxos5ewK5PPLxowzDAbILRsMMlzMabSr1fCae3aOmNT3RBAZyycxBjh?=
 =?us-ascii?Q?HqOUKE8KU4HReyzSFd05z3uYlAFn+LAlGsNAD2yt39eJyYlq4m12EW7zboG7?=
 =?us-ascii?Q?zv5vxl3Aas1mJ5Sn7cb+6ETyoge0uUG+hgdmoCUGEcU63XgSwhiQpEgePiiE?=
 =?us-ascii?Q?Mf722JYG37qCKHx/pFjf0T8tdf+nmdNIekE3qJUOLRc3S0tD90eVqEcha6i5?=
 =?us-ascii?Q?G9LHHHSy8z4fa3gxzA+pWPAF/qCoce1AjE9WR+laMAv3FcW+axfkPSygoMFO?=
 =?us-ascii?Q?f6pvCOHL4QfLmJQSdajlOCoYgZvfVdwhKyjTPClTRVx+Ju5r9YOz4bpHGOQ8?=
 =?us-ascii?Q?OmkwxHknnalYgvyxU+npP+VOZFs6b/upilaQL80BvAvDj3lJ/6WijQrphzyM?=
 =?us-ascii?Q?KhrZHoe2KKajqX7LA/yp0AEx+d9w8SM3dceeNecTscN8AYU0wWMfMkvrzRqk?=
 =?us-ascii?Q?QoS5yKpg1FIEtuGx7Ak3Knx52UcDJyl2XI9We0ekgE1i3iENqOgqQxq58ukZ?=
 =?us-ascii?Q?alNdg0TDmKDUuFWIfCLs4eAUd7ZnQJLbSMEy+SVf/IbKE3mud8tyjIunGGlb?=
 =?us-ascii?Q?eAiz8ngpwfxC5Wke8Bk5dnFes9z0jRuQtONIMczZNwB2pbXfooGx7rZEEaa5?=
 =?us-ascii?Q?fYwwxYOvNg49w8tvFPaA3AmurFnzKxC2zRR80KIagO3oSTq2CDPdQQP0Ru7w?=
 =?us-ascii?Q?roaFmKBJL8e1L2wPnVI/7+CbwF5cuj8fZKn04zkg04svV66OmJwSMEJihiZz?=
 =?us-ascii?Q?hOZ6aJNEwAWAp4DfhW9AZWxek3yNCoAT1D6Zhp3SY8VbTPPNhL9moHp3mzVy?=
 =?us-ascii?Q?CNev92zkMKph3m3aqJ9b9iEsWEn0QwEyhADkNg2dz89PB4F455MwKT8d0Zxh?=
 =?us-ascii?Q?Tuw/eaaHHKyUBpfkVu1tbsWD3THJfELOlisPXhT1pI0gwX6jQ1vsfCUy4Tao?=
 =?us-ascii?Q?naHeApCdQHd3nPiX/nA0Q1FIlDVxGPz0Ln0ZW4kYEsHBql6Yf846qHGp6e5L?=
 =?us-ascii?Q?1nlFNcbTZ4pKGklu6PJm7Y1XR5D+/BS/sgxri04Z/tpWKGu83DMBXZOJn7D5?=
 =?us-ascii?Q?OYdbfxxtKR+NFr0UUX9igPy4WV7QlX+RIxS7+6eW5M4l6jloJ1xFmKAn3T+9?=
 =?us-ascii?Q?OzWuDLqtUb43jc/BmfB7FIw75aTpTfpTl3BRIEvI/Va8mgnxWdJqhKKeWgPH?=
 =?us-ascii?Q?yPplO8pC7xDD+0Ok0zE47KJELYoH7nEVyXoqcR7TCvJfyM1uTaeMMXUU1hW7?=
 =?us-ascii?Q?u8f10vvaUFylHNoXU5Mq5a5nJwcQ9guPM48fUE95AEjSY2eF9w8EUSjbvScx?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb3cc5b-3842-49d5-0897-08de07e2ab69
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:05.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRRVSx5S5nDrddtY8qIHDae/DHKfRQaZByPBxfQPfK0br1TO9TrTf+V8+OQPrr1WFddZb3GUQrdxbz3hTJ+72y+cyFdTlXFOmj6o5R6csK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

Hi all,

this series introduces initial support for Dovetail on RISC-V and
adds some fixes to the current IQR Pipeline implementation.

It is based on the current tip of the wip/dovetail-riscv branch.

Feedback, suggestions, and especially reviews are very welcome.

Best,
Tobias

Tobias Schaffner (5):
  riscv: only store interrupt enable flag in native_save_flags()
  riscv: restore exact interrupt state in native_irq_restore()
  riscv: save program counter in arch_save_timer_regs()
  riscv: add initial dovetail co-kernel skeleton
  riscv: add out-of-band aware trap handling

shannmu (3):
  riscv: fix interrupt enable/disable order in native_irq_sync()
  riscv: add dovetail-aware memory management
  riscv: enable Dovetail support in KVM

 arch/riscv/Kconfig                    |  2 +
 arch/riscv/include/asm/dovetail.h     | 23 +++++++
 arch/riscv/include/asm/irq_pipeline.h |  1 +
 arch/riscv/include/asm/irqflags.h     | 11 ++--
 arch/riscv/include/asm/kvm_host.h     |  6 ++
 arch/riscv/include/asm/mmu_context.h  |  2 +
 arch/riscv/include/asm/syscall.h      |  6 ++
 arch/riscv/include/asm/thread_info.h  |  9 +++
 arch/riscv/kernel/traps.c             | 92 +++++++++++++++++++++++----
 arch/riscv/kvm/vcpu.c                 | 13 ++--
 arch/riscv/mm/cacheflush.c            |  5 +-
 arch/riscv/mm/context.c               | 18 +++++-
 arch/riscv/mm/fault.c                 |  3 +-
 arch/riscv/mm/tlbflush.c              |  5 +-
 14 files changed, 166 insertions(+), 30 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h

-- 
2.43.0

