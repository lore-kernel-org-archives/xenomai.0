Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432323AE717
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077397; cv=fail; b=tPWS6qIv0R/5ja7aLdsqITasPrAJzoUNydpjYbnJGCOcJVC2KOTC5xFXpCgARuBLKBBTtg0IDmn7cS709X6RzTtVHf67EYjjI1J4OpTIeE2vXXIbymB2r9i8BCT/EXryDwxLne2hp4mxs5MIanR5byxT6wuw4/HcRPQIUMZtCSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077397; c=relaxed/simple;
	bh=ZhwsQ5MGtecT3HxhvW8+oGhXXeUuiU+X88QDls/J1lE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O0rbnOBU+f1e8YRaaYKsc2RfNHjOP71jz7PSXubNrAeaNCxBgRTBXduty/PADdGt3aM+kJ80QAbqvlLivK419BhaHDhVzuvBsizIGogNyHCUExoN2B5EAOdPo84aiDZYq3lv5o+JEC1JrlW5A9ZPfycugM7ftuZVUdLW3OP5jSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=syAgTy0V; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="syAgTy0V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBinBO5mmJXpEE6/fea/wAROsFxn+OBPYnEOL3L0I87PqtTh2M4O/NKDz+vzFje+m9gyaWMiVozIJieeJoiZMZmHlUuaCaC/JXY9BZ+FIec1jNcrM+R73HKY9p/TrwnbLwAeL/i9CAVRZ3LMSpaPTujem0tdDWVb+sodRxdle6wCzs2wfnPbzSzU30LEY72noREh6dZXWslqEDkoNRfXYVtK/nD+L+nnNUGFXSwdUJSriblhcsx36SuIS302/R1BcWtscYTbpPYCcd4LnAMdDwU6uPFwa+cD+239kqsbMYCm3eXI4l6knxAKSxknpmQpbdy/gMokZEAeUJw4lmxquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79xYapMU3elXR+bShnT+NA0ZJ9APcgNiSeNzS5Iiwps=;
 b=lzO1bNCDt0eqUfNHVfuIR7gBZgIJWAjJ0LIQ5QNUjdF0lfzIxb5vlIot18Z4kyjFx5DlSLzPpM//elW2jjVGEA6bqDF55QLynI7n5gPAvY/9+P4oAj8wnAHhsCRSlwCCkeuEDBIbh5iuH2FCj4CvTdBgq6vt7ZMfXjZEQK9PIKTqTO9oOO7w7j7g4IP0dLSIKTlKHKsoQ6qHGr5noCPgzmHrUzlSZYJ1OcUM0VhrPXYpX6BxYG4m91uvROWxF+e+28I7gtTVpAXXR0tocVZ+7dTndgwY1YufEul9QHvg+3f+hTfclkRXcr2UipSQByK/IcGqO/SnzlNmYx5Z8qB/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79xYapMU3elXR+bShnT+NA0ZJ9APcgNiSeNzS5Iiwps=;
 b=syAgTy0VxdGnmbNwhR9nKFfugI+W0+MZNzKVPqTilwL0b/PAFCsD8ui8da76vxd6X3K4JvFUwFsB+0rejqgufYALgxnXYp8UJ8TYn6YRjotcnbeDAwdr9IovGBwcLRnWQltxwg/q46VVdqQNwhx8EKWTYp6LiImLuD5NG1K7xGbfwwUDWGfEk7k+GaXjOfp+MhNEQbN+4WO2yITRffrA0XGKseGrIiQjWqzLR55Vw7TsBbM2erTOpzNSyP+0S/5TBkVdVgk4uHznl0i9qMgTpD85+XSxD/G8cw4r7J6lyUvEo6ARFpjvIHtmUiwDqr3/MSSyEg33ymMV4f/gj/Tp3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI1PR10MB3214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:23:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 00/12] riscv: Add dovetail support
Date: Thu, 22 Jan 2026 11:22:52 +0100
Message-ID: <20260122102304.421957-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI1PR10MB3214:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e8e689-ee2c-4016-7d86-08de59a03ee4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0+M+Q1Wvrl3w+uEDaKWBb0WqtHAtqDZF2HJAbbhCNu8BROIQoOynGzBsLjo?=
 =?us-ascii?Q?ehDfFZ9TLjrjsj9scOp7xiKCso7pJN17al0aHy/v4JsDP7Ots8QV2e6VIY3R?=
 =?us-ascii?Q?a+txNPT8trKN4CV8AJ979nDyzUByA4w2+qiwkorah1guYFbtV7zmHK7n3pUc?=
 =?us-ascii?Q?Di99RXuuJUixj57RCLjh9aqmyDA80yLIoIYza1lIqU7FEJqCooFWBz40ofBJ?=
 =?us-ascii?Q?241O7Q8FPWc50EdgSkbVwuuNZGe7DAuWj0tOaJeElvfr4MowgCMr0q/mbQi1?=
 =?us-ascii?Q?nBpqiUd8pP8/D+U1KmibxW4u8ER3X+CVOkuyErwmyxmT6LDLhniN6ly0Zvhu?=
 =?us-ascii?Q?OykRVbpSB+gKH/mZ4lzekNpXBWRw4mLVQ79ByYOSS9c0Bh8lVDnXSili1+f1?=
 =?us-ascii?Q?U5+VfNaW/WOo+mWzNLqjtbIkTlz1CW5rj1AaEvvrw3evGDXWGfzvNBJL3tT5?=
 =?us-ascii?Q?KLMjlso70tYj6/MvdwUXagXbNPsAFd63MH6UMufZCSoXC5wTQc7r7eGAkP8U?=
 =?us-ascii?Q?n2+gfNGbAQmnmP35CSHtuTAy0ioTCvSh2UF4wMYfat0saaVpTHrnqF6m7fUn?=
 =?us-ascii?Q?F8RsB1wx8OBxu2nllwV4il9lip1oAwptcoWtbozJXHcdcRAo4QHCxYUbNIWx?=
 =?us-ascii?Q?FsswnkXdILUwIr8N3Vo1tUWLuFH+6nd8oyvjb1YI084gUt+gN+T6urMx1sUB?=
 =?us-ascii?Q?4zDu7ugrPr3etn5Gm/8fN43lc7s9F8dP9B3gL2Jp7UVaV4hfMQ5TD68GzLVT?=
 =?us-ascii?Q?Z9XB/60j8+muI0kbOUEq40+5dR1xnje0LXcSNFnO+oIHhKGjkd5Eed94/yL+?=
 =?us-ascii?Q?0R/ykDRIhXULyWHmnJKi7nJqj67PcW6V0W9NlnA8/FB2EFgioXXGFMhNbMms?=
 =?us-ascii?Q?GWifmguYI6AqhVGo/OGYAiMyIGbTrUkrrq0whla4txtDrHZAaIb2mEy7Y5VQ?=
 =?us-ascii?Q?6U8qo/KKuKhCDYXLsnOo2X9ROoT2LCAKGp8fS29bvTwuyh8UrmklnK2wFbQH?=
 =?us-ascii?Q?1QRPQQsOz98dnGrFq+1AdHajchT3H5YRBEut+jYiKl4zZ6opiDBFtlNwyJnt?=
 =?us-ascii?Q?OD79R5sBupYTNR1sLynhDIswSYbmxH5rJcWKvoL1BQ5JpyhlUzPdYCRGekj2?=
 =?us-ascii?Q?26kGJI66m/kERoUtLOpOSLBj3ODwhAj1LFyQVTB/te2ssNA8GQiByHMD9jgS?=
 =?us-ascii?Q?sLMG2t1/fuVSExsH9u/Psohy9xahh4tEYaNXG9AghVeNwuxf9wsYUONpvPu4?=
 =?us-ascii?Q?Dfbcr6dtULNbAjqdQ5t2u8BpaBTVnMoYoylqufUTrYdtPVhR1wAJSH0eKUhC?=
 =?us-ascii?Q?JZtuYIYX3Zzl1f3Foq9rklZ9XmTRJNw5/TZEC70fYAmBk3OxnIupwnZZdYM0?=
 =?us-ascii?Q?AyiAH5/+55I45nwWvug/wzZs4355na9b0CCKtlHiOeS708YyEXX5mH2zOEi7?=
 =?us-ascii?Q?BWRSwEQ98U9jxpvoTOjQEO2xz9fAKiVCUeyMND8lulbcvDeQfhfn0JryxgKr?=
 =?us-ascii?Q?1ZQysRQrYN+4lD1F7kcjm+A4crIsXLY/3HXQnBcZynFoWLiwwCWhfoZhFdc9?=
 =?us-ascii?Q?IEyBpYOv7FXZQseKEvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fKKNOIcfz9g0CbackSXPCu2n+LED8QYiY8pK9Larlgr0Y1mLpNT51Ge5BkUw?=
 =?us-ascii?Q?kEu4wsLREMGej/oU48ve8kpIVoZainlvdkdKyg7MSdbTt5g/1fcSATAQYrEg?=
 =?us-ascii?Q?fVoF29pBbzY0WsVYjWSOwP8ZXO37x0+J5DZnpSSmeo4A1OLEM4/nFp/WPr/+?=
 =?us-ascii?Q?dj4ldSigV3nU0VbfUunx9EX1uPBsKPIqFcYr+hNZuEMTowHHe6ScBi4vSWD/?=
 =?us-ascii?Q?zivVOfVORpL1FhkJAoW4tYCiwreM3HlF5JBMnKQJC5+TV9dT/DqgvBI/M9kA?=
 =?us-ascii?Q?LpNXHa5msC8wSjKa+pBjpX8v5A80Eef0YGH8yoOpiPyJsRxzeWNKJqtlqsKx?=
 =?us-ascii?Q?KuMh21J7ju5wV2kYe72Pb3A/qC/7LpB1jeg2z6hJhH4Q5hrX4r0Q2lRBI205?=
 =?us-ascii?Q?Wj++8R8IO5Bh73H22LY88R+p5CeCkoCTSdKQFtocTVFufd67y3jkngw8uAwk?=
 =?us-ascii?Q?tPvBt8ZWcsoV++pQuP7ehETZ0Ib1znr6/J5crijQcL3yCwhFPe7pvxE64uO9?=
 =?us-ascii?Q?T0vtOpG9qpzFyVv/HKlKvRRCMu5H0D/BnnRBJASzZ/eQDXkq1zN+qljM7h2H?=
 =?us-ascii?Q?mTgnJLOxkr3Zf9aDGJqaLEfKlCAD+ULlL/jwXgEJG8+R8vWEj8h3amPdAzZO?=
 =?us-ascii?Q?g8gpO7rZMN4OhWsnJHd1w6kPgQ8CGdecXxCVdBc2ALBub4tteNp0/rIqUEo5?=
 =?us-ascii?Q?XvWn79I2gcHY4wtKYMWEyHpv1FRACGKz/qp74P1O1HUCwU+3olc4TuKmTdDp?=
 =?us-ascii?Q?lta+GeheByJ6yf88ilroUr9lu3bLRPItDGSUUjJiT/PYZ1I0g3UsjoSGGRCD?=
 =?us-ascii?Q?PdrvEYp6ggzwwoJncOXAiO4KjeQNQ8Ylttjv5Jkb3XubI2apLBt8TzG3p0Rm?=
 =?us-ascii?Q?+VnyNRw8/0BoE0v+bDi7v7S/2d4AwBKKEvKCGz8/kZDv+/w3n/qASBZluxjt?=
 =?us-ascii?Q?teqo+MnROfIvixm1nVl4v8YJIM4ts+kCaH2u7gOqFc1yxrGxmyWbsRbqpZo+?=
 =?us-ascii?Q?WfdWjeFhAC7UNaz26rzXpkt/NqphlLt4Wpa90JkvK01ALP6no+8v/Q0WCqlf?=
 =?us-ascii?Q?T9Ca/2LlnpZwH8spNYZB8QDHEaFG3qmcpFf0J+YklBEMcvrTFz9NnXTzW6aP?=
 =?us-ascii?Q?D1dT5TdCx+OHp23etxfevopngjA9Q1/LzVJSliZ9/yyNvBFjaCk5k5tR+ao2?=
 =?us-ascii?Q?s5RyxHRv3tUmDHBHg0ITQERandDy+XvyMnwtbp9dNC/d2Je8/VuBgpX9cAvo?=
 =?us-ascii?Q?Ro47iDmM3+wOD4s0W8+2tGPtDBBlxANiefTEkTbql1pnyQCIbHc5P6giFPnz?=
 =?us-ascii?Q?zGKEBMYDS89Ax5rhC13Aa9kok7zAF6QCAso9TBZROmEMTTIdr0AtdkT8MgYv?=
 =?us-ascii?Q?Q9iN16jOGsALygT9xEBV+fn9L0fKHsg8UyA9ai3Xs4QwVzttgYW4wCLvBbsW?=
 =?us-ascii?Q?UWbYCiTXILJ5tZ/cxiVHgKGtshG8C4c6li+3XU61L647JI05YCZ+D1W07mXY?=
 =?us-ascii?Q?4IFu1SZ5U1m2nwneYYpm7nPGe3jSx7JfxokA14UddjsbtjOSlLILPKiDNCEh?=
 =?us-ascii?Q?LXHOzlku5nba7fCMKUr0wV/QSC05rHvid0DXXav6dhFSD5xbnPDqVvZaLVNY?=
 =?us-ascii?Q?If342m3GW+5vZHxmnZVqgZEDch+wcxuw5shAxlw4UgiW5o8J5902YixnTod4?=
 =?us-ascii?Q?+QKbtj8mCKDmu5WLT0axeltIs64/fb1hcxMOmbJ4pKBylT2hPBbkp2p9hTnl?=
 =?us-ascii?Q?yyAZH8dw/XqJy/tZFekAW9JWQ3tgxqA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e8e689-ee2c-4016-7d86-08de59a03ee4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:11.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6a2kR8pY9VfZumqInHSW3n6k/adxw4YZAg6h/VsEZZEqJP3ztkknZDA3nbvHp2YGo54pntOOA55mGJDXFx+clfJ1jxA5WsyDi/rt6SBHHEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3214

Hi all,

this series introduces initial support for Dovetail on RISC-V.

Feedback, suggestions, and especially reviews are very welcome.

Changes since v1:
 * Disable independent irq/softirq stack usage when pipelining
 * Drop KVM changes as long as they can not be properly tested

Changes since v2:
 * Rework trap handling

Changes since v3:
 * Included the IRQ pipelining patches to have all riscv specific
   patches included
 * Rebased to dovetail/v6.18.y-dovetail-rebase
 * Merged most of the fixes
 * Fixed IRQ Stack handling and enabled IRQ_STACKS again

Best,
Tobias

Tobias Schaffner (11):
  riscv: irq_pipeline: add IRQ pipelining core
  riscv: irq_pipeline: fix irq stack handling
  riscv: irq_pipeline: synchronize IRQs on exit to user mode
  irqchip/riscv-aplic-direct: enable pipelined interrupt control
  irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
  irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
  irqchip/irq-riscv-intc: enable pipelined interrupt control
  irqchip/irq-sifive-plic: enable pipelined interrupt control
  clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
  riscv: add initial dovetail co-kernel skeleton
  riscv: add out-of-band aware trap handling

shannmu (1):
  riscv: add dovetail-aware memory management

 arch/riscv/Kconfig                         |   3 +
 arch/riscv/include/asm/dovetail.h          |  23 +++
 arch/riscv/include/asm/entry-common.h      |  28 ++++
 arch/riscv/include/asm/irq_pipeline.h      | 148 +++++++++++++++++
 arch/riscv/include/asm/irqflags.h          |  32 ++--
 arch/riscv/include/asm/mmu_context.h       |   2 +
 arch/riscv/include/asm/syscall.h           |   6 +
 arch/riscv/include/asm/thread_info.h       |  17 ++
 arch/riscv/kernel/Makefile                 |   1 +
 arch/riscv/kernel/irq_pipeline.c           |  26 +++
 arch/riscv/kernel/kernel_mode_vector.c     |   2 +-
 arch/riscv/kernel/sbi-ipi.c                |  10 +-
 arch/riscv/kernel/smp.c                    |  97 ++++++++---
 arch/riscv/kernel/smpboot.c                |   2 +-
 arch/riscv/kernel/traps.c                  | 180 ++++++++++++++++++---
 arch/riscv/mm/cacheflush.c                 |   5 +-
 arch/riscv/mm/context.c                    |  18 ++-
 arch/riscv/mm/fault.c                      |  75 +++++++--
 arch/riscv/mm/tlbflush.c                   |   5 +-
 drivers/clocksource/timer-clint.c          |   8 +
 drivers/clocksource/timer-riscv.c          |  11 +-
 drivers/irqchip/irq-riscv-aplic-direct.c   |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c      |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |   4 +-
 drivers/irqchip/irq-riscv-intc.c           |   2 +
 drivers/irqchip/irq-sifive-plic.c          |   3 +-
 26 files changed, 632 insertions(+), 82 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

-- 
2.43.0

