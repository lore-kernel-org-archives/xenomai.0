Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C234AB09
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035821; cv=fail; b=rfwHEqLOx6IS5RsEBIPnZ9/iqPJUSNzRRG1+HW0GZNfFyisXNKHs1GH1aO/otY8nwdI4+/ULLrxFon8EP8QCfNi8A7G7HFSYGtsNtRJfwANsPac3AgPtK1NIiOtrSV75mw11Yyc8ZcGDJfsyhubFqlhotTjPHs/M4xX77b1tUy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035821; c=relaxed/simple;
	bh=MRV0zm0xoyxnenf3/4raN6mwrIFHcrJ3o7v+vwnH4SE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yb/trKHA90eeQyBczQSz4uSvhyyrltmsCdBsBAo6r0QQ8n0wsrP81aeTTGfI9dFWjla1kF8MX21M4t0DsKcNSmnLnJGWtGBuTDDEQXBB9L4GH4sdXjhwC+TLVdB2Z2T+0lD7cqlG2zsprwUr01S03adVCoTLsb4MiAZqChXrE+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Hbas6EGQ; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Hbas6EGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb89c5QHwLBZTiH7lmg6SAFytZ9l23ZtGHbd8loqcDn4LoABz/jWfR0VMUY/LR4wMzRE9U13l+JYVPUFL9+LsCmWpEBuvO1qVbUw1RGMuxhYsiJWpuhw3S6yVyFXjklEkWx9qx6+fYw3Ouev0XLO0pC9GisNx0rjXDGcx1C55+/XsCePTRQ4tkwk0hyr85EM+pCYJgX+Y3KWiKmuZF/PQH+RMO4Ec8aX9jtR9tp+yEi+DShi7Ai56Y1qRIcbwLhQnVpxyEeSJEy7fJOuGLSRiOhqeHRFrJM2AXw5jvAaAevzhxc36EzqhBAT5u6bZ+BDcBbUoojMkwz3XicLMeOs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohzoCtDE7Rph2Hpzi4eDEdC4ZsPqY5Ri1zKye8DZco8=;
 b=dBmzd1+7WHaYOrD0T/A98xhG12hx12mDxPSW91KA2VwmOj9Ht2CfQMfLFF7fsbYMd2KVb479fKYRdnJFsMXBkZZrx+2bxlnfFMdueJhTWvRF6n79T+1Fsuc08ZvELHmaGY+/1wGybC2Dw96kiU5SKmoYdELJxRfmH/MdFhuS045M1SWAd7JhZ25JY1WWjmca8SB/RsTh9A/nv5JFZadwvpJKUFJ2eIQK0vr6k3H/JLbtBlFU23fiR3o7cjHyvzOmNleleFnc4M4gE0m8YuLlEr2LX0snp5RJ4DQO/+KNku5gFUnmOLCj25hAFLHTfn2SK5UGF6I0gR4AxavjBDsGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohzoCtDE7Rph2Hpzi4eDEdC4ZsPqY5Ri1zKye8DZco8=;
 b=Hbas6EGQ4nOvw8vN170HZPesza7dYx7rCZYZy+ET5hswUvF09MEwwCqsHK0VFTwz2gYfHbaYChN4M09HmuBqalcFH+3zuRjkic2vXhKvkLX8l8YhjKtPK7WQKJRf6heXkBR7B6s0YfSKCthX1VHDUK2B/uPDtvRxLlPF6/y/05uPwSFFWU77YElTFJafmIhAmvQITqBowU3yR6KaxX7gNpJqf2ASzXqzaQQbIrqG2woVvKjAC3gwWkczJIYJ0cGyNYo2tFlodfNQAxn0GNiIeuQPSpM8tXKeACdUhlsqyQP7v+t9OLHoRTG3dI56CZl+5+tn/ZaNOR9bOfmx9PrMHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB7859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Thu, 13 Nov
 2025 12:10:15 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 0/8] riscv: Add Dovetail support
Date: Thu, 13 Nov 2025 13:09:55 +0100
Message-ID: <20251113121003.416012-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: b93c8498-5fd7-4b0b-083a-08de22ad9a78
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+P1MAbt6fKxzhGDgl8SrNwSULQRfU8tKavvebybpqxNIK/4ERKvPjY7CSN7X?=
 =?us-ascii?Q?EfwkkfvX4hVRqeuPW2466OZQSjdjy2SEV6fXyvcPA+zTt7YjNl/NOzZtGGpb?=
 =?us-ascii?Q?/BtctAmx74azbNcdMYBXNLFKzajihqgGBOWpDoVXphVVgvH/FDgfhzFZe0yT?=
 =?us-ascii?Q?Zsm+NMWjR1rmWED9+MdzfwMqIXFKvNrNS9lPkaGxCFs+NG+T/mG3cE6uwg63?=
 =?us-ascii?Q?6yM+K63lJSFfDq6mDxe+suMTaQfXUH7c+twJ/6fBfgKfdFTZuYgcptau2on5?=
 =?us-ascii?Q?RYFFFUPHIuFD33Z3nFPVxozIVX2gabOAgVcjQ3E9jIrAyrEQJCoTkhAeynUz?=
 =?us-ascii?Q?/oBjJ1nq1vjmQS3TMSe+Lk34m3MB2p+KVoHz7xPeIysvKgvYO991Fmp6MYDo?=
 =?us-ascii?Q?VL8Sr8ggZ3LKT6LvzS4MhZWN0GPxVhmFFvPOVAWniArsZrRcnt2bERvVrZm0?=
 =?us-ascii?Q?76b6+EhveZwXkCPxwF30e6OiLii0CmHTuYCBJZNwbc+sGDKZ9UKybOGLHUKt?=
 =?us-ascii?Q?SaFbQdDF86YyO8Halbo0rcz1s3eoZh49gp/n6rygmCmJ7NE05Ha8fKW4Oyff?=
 =?us-ascii?Q?OM1YWpw8YcDkxqolzIf0HPrBEA1KHP//h2YbS2q5u6Ww0FZ6S/95mUOQvext?=
 =?us-ascii?Q?dmVoiDA8JRNFQLA0GSgYwHg8/P6B6HL8VA1nckCNSZmrR66GGV9T+ykVc2/d?=
 =?us-ascii?Q?zPLY80Pv9vvJthEjJKVsIedENpRfWDXwiVT/kEpIRPZo7ylPU8MJ23CIr8Kt?=
 =?us-ascii?Q?rB14pI6HTuLp/nPugjJA1Kcfywb/ezpqdEERzAQHrKXYcZfYbZkl9J2Ow0re?=
 =?us-ascii?Q?af38ED7KQtNnpf81WdB08X5JfAqFGJPf3NRe4yu44r+ed79Q4C15vXm42znP?=
 =?us-ascii?Q?hqIYv9URDfGnAMVtu2cmwrbIfuB15gLfJNAH9sxkwOSFM1mFWr0qK+hvgAot?=
 =?us-ascii?Q?LoyEgXcEgkl9V9YpQoiMcLVrUI/miv9lM3v4Zu4QB9MxcjRZ6StRG4n/5Sy2?=
 =?us-ascii?Q?GZSVr1M24fhuioPzBxb2ZhQD49FLELNo3yVr27srnObdPRkvPra2JsMmJNb5?=
 =?us-ascii?Q?1qsSlB71mDV7nFtgY8wxNCDyIIbBusQznSikIytU2gE7b6ftW7DnuIiEpotw?=
 =?us-ascii?Q?YVn/7O7YJ8n4b7pcA29hgGi8GnEE4UbXAq4cvQqlUbqhL5+18KWZFKXz86As?=
 =?us-ascii?Q?bOuRcdv2X2fSN4mT9xVqXvhHb4yA+6uXaD5Zi71x7P+jgWr8OWVrR+cjFgmr?=
 =?us-ascii?Q?T0S7OcB7qa3WklsbwLnBGhBEBOk2mCcVv+6j7K4vSTPhk8UzFmqrOCOScJ6P?=
 =?us-ascii?Q?tvIpXjI8Um2LHBNHCIqtAIoZYvey82tl1P5kCpeMIgXM8+BKWNU8NxtxprQo?=
 =?us-ascii?Q?oUQduIXOFdVx7B6SMPHZ6DFkSdoeiBZxPMixIN4Rz2AaRvyb5zM/ME4whoaY?=
 =?us-ascii?Q?a8Gam9WJs0o6S3bYZfrfdX4u78aY4nNG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQSptAKAxgj+tBxVzGOyOB+01M8GiWrlPx0KozLG8AOTxB6MdaqEm3VFB1yY?=
 =?us-ascii?Q?XPvkRMGEii/1i6MOw/dwUKCv1N9BVqUCVKpgb7r/exMDI8w8GcQZeNlIKPAM?=
 =?us-ascii?Q?mu4B7AFJE7AOrUF04WJ74yr32nlwEKV1pimj4A2CraFO0BFLksZ6V1n8ou+H?=
 =?us-ascii?Q?nBtm6nRbTiiHmVbyDYPkIXOcApl5JpfI1JpTL3SP3CNLRC2bcYGRy2zzUZPc?=
 =?us-ascii?Q?vdi2TJynDw682TMUSehv6msyBY0yG1MEyn18juIwaqDTeqan1Tov0mDgXxq0?=
 =?us-ascii?Q?BJ7qbfQIeiSWU3Z70xmXftnShUcXKv8ISguAi8h7IwmfsbUjARZxEzc8OnfI?=
 =?us-ascii?Q?Olwy6UUCnSr6J9U+Hid5GsAdfxf0cNio6g0IyzQ+21ChAui4za/IY8Xa7Jpp?=
 =?us-ascii?Q?B709zodZg3ICs82ZqTJT6QV0peKCiHD/A6oeRFgRqAGdU8t66BMRu+kSQxUu?=
 =?us-ascii?Q?7strTod47qSRfkTu3a7ozpsdR58GNRZLAbbkv5jqZb4iUE06Jnqp+7sT7We5?=
 =?us-ascii?Q?BKg5aN4GA13ZfGOBfyLknD+7/hrCXyyhID+jobHDbFIvNWv/jfdiEkMeh6Vc?=
 =?us-ascii?Q?XMf7VwBaiAjFZ4jvr5uLMQJxawJzvfx4VRR8QITB+l4/c0Xc8ioLpecUj+hR?=
 =?us-ascii?Q?mVkBWhnZIeadNOc2qQpHlzfKFiOw3cDywQt4VdvuP8QuD8xTABEIEyhBb8rm?=
 =?us-ascii?Q?HvYmKuXBHYPRBTUBKShAdtgnQHzR+34P0w0RgehSC0dOsUF6Aqe5+ZzYegPn?=
 =?us-ascii?Q?hcFiSGVi828ozZAz4fLU8THyBXOuttFeig2xHH4eiWWWzNDuPk2lvJEh6bbh?=
 =?us-ascii?Q?VSObbVzRHTETZeW/V/zmpkSQ9JzBslr+Gtc7amZ17TvQVBar8uYAp24l04B5?=
 =?us-ascii?Q?+Gn+tTy8yQr4R/MCCV7o9UcDv/DPxoOX0zlRZbeqmfybobXoZzEBI04K8F7V?=
 =?us-ascii?Q?9U26p0+GH3zMuwYaL4PO4zV2TUAOJv3YFa6kY/rWu6IiXNDDO/+tsCf3lUh2?=
 =?us-ascii?Q?+xfA9PQjQziLQ/P1VUJgHd7je6ez492MUF3av9YijQGmHRLqBAnF35VKyM2c?=
 =?us-ascii?Q?uwmCh5yCQPzClrCtzBxNuhNCoGF+Tv9xah0WH04ECIOP7su27qvqiGgR9Oyx?=
 =?us-ascii?Q?ZCsP5mvByreqiMTgAlEo7uaCfuYqTLUpTMzbyeFPnxb/zUdVqlY2C80AiV32?=
 =?us-ascii?Q?sBXBRPCrQBHjPYm8E8MHwCIDV59yKQspAshxLb5z+8pNkpGfmcVl0KWdfe4R?=
 =?us-ascii?Q?UPIA5JJnqkj/s8a7KiqOnk9zELLm6bT+Esm4zszobLZC06fjfY6woEdDNe3s?=
 =?us-ascii?Q?NbdpBtQ8Rush10OZ42oH6Hvy330xyWVKvh3NEd1h3JKgJFpm4rWEBnhsIRjA?=
 =?us-ascii?Q?5phcYzeb15nESNPJCaXnsdKDKRyuON3kiCHROAP012OCQXd51hZvB8gQqe2d?=
 =?us-ascii?Q?U0pIRPE2Rm6matY4WRJW0D2beXHtCb6cDBQl5gaM/prorfOM+Xutgt+QWuQO?=
 =?us-ascii?Q?bOyifKshzmuFGA7TdzYVN2sUwispRed+EDiMvGZhFBERh9WgGi8IMhSXe1Wd?=
 =?us-ascii?Q?unS0gRIUNbZ4e3Gcwuv3fUZQoz2hR/7JEGay/SaqPblx6sJ9ChkP5QFogot2?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93c8498-5fd7-4b0b-083a-08de22ad9a78
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:15.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wCbAiHyprGvUPDGPpn93IiyvGsuv0LGM7WnBRALT15TSwhwceVdYwffKn6JFjnagpamyL9WGiOs5Of2UYfgo8iwEo1pif8311pwK5K9NMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859

Hi all,

this series introduces initial support for Dovetail on RISC-V and
adds some fixes to the current IQR Pipeline implementation.

It is based on the current tip of the wip/dovetail-riscv branch.

Feedback, suggestions, and especially reviews are very welcome.

Changes since v1:
 * Disable independent irq/softirq stack usage when pipelining
 * Drop KVM changes as long as they can not be properly tested

Changes since v2:
 * Rework trap handling

Best,
Tobias

Tobias Schaffner (6):
  riscv: only store interrupt enable flag in native_save_flags()
  riscv: restore exact interrupt state in native_irq_restore()
  riscv: save program counter in arch_save_timer_regs()
  riscv: add initial dovetail co-kernel skeleton
  riscv: add out-of-band aware trap handling
  riscv: no inpependent irq/softirq stacks when pipelining

shannmu (2):
  riscv: fix interrupt enable/disable order in native_irq_sync()
  riscv: add dovetail-aware memory management

 arch/riscv/Kconfig                    |  3 +
 arch/riscv/include/asm/dovetail.h     | 23 +++++++
 arch/riscv/include/asm/irq_pipeline.h |  1 +
 arch/riscv/include/asm/irqflags.h     | 11 ++--
 arch/riscv/include/asm/mmu_context.h  |  2 +
 arch/riscv/include/asm/syscall.h      |  6 ++
 arch/riscv/include/asm/thread_info.h  |  9 +++
 arch/riscv/kernel/traps.c             | 92 +++++++++++++++++++++++----
 arch/riscv/mm/cacheflush.c            |  5 +-
 arch/riscv/mm/context.c               | 18 +++++-
 arch/riscv/mm/fault.c                 | 24 ++++---
 arch/riscv/mm/tlbflush.c              |  5 +-
 12 files changed, 167 insertions(+), 32 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h

-- 
2.43.0

