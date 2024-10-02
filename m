Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D561642B
	for <xenomai@lists.linux.dev>; Wed,  2 Oct 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865624; cv=fail; b=ZdjAQYAORBJeCwHiJ2tdAVZUR3vtDZtfvvGP769lJC+3O6u95JCgerkyJjJlPy3JvjKkMoj8hTypzkHgPB8RJxLxm8wMTK532MRmE2wWHtSqz+VT1hCJaEippw2/O33xbzn8Xr1zfv3mTJF+YHycrk+GOmk9sFap8HVXlN48Tpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865624; c=relaxed/simple;
	bh=75kIbeNWCPSsWHjuYlSn2dREDEqleQm7TT3/9t//4RI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XNeicsleUecQjx0ZiMhtrpVyFknAusqj7fAVLmumelhtbWncmJvd/eDRpy+HZ8aeiMtjFCr4pn2Rz8F91SdkH3oG6OxNcUduNUo16gT5A9z/pkUb32gUg7bGZ0a7ccfhRdr75Xc0b1XJrrGkQWh57/tzbgpJid5L3sLFymNgvik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h4r2ZPkE; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h4r2ZPkE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxluOdUgljduF06dHQIr7dqorkn4sJ5mobjmSWMBWctdEHEfNEumX+OEPzDoYpIkI14idhKLfd5KIHeOrVzoG0W8ptxrfyhWsj+Yc2ZVECD4bKvFBtC4WeDHU0wlZ8MKlsB8GtnStCAoR6ldDR8Bp/KAdoaKpVIs4q8sK+L3gPFgyXlSKVCDuxec+ijXhBLXQzBLC4IRNE76U4fII6pnBL8iG54k4WB/8v6aE2PvPJEyUGUVZXwTcI5Q1j0dGllaKKTIBgOYvxXoiOUTM+3b+0TK/F48d3fmk1ZZ58yAGkuFRhvfCrsAzo8cHKjObkKwTBNchfz7gwEztzKrQh6Qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVNiVtl2N96iWWn59HVLHVtIol1ZcGAo3fbwl3C6MAk=;
 b=HMX33wICXSs1xf9mQ72YsQsZd/ZmVspHgNnnYWxGF4xpQAHRYH2bZpoL5koJO2+P4KwboqOYT8wrBHboGDsn8ifELYBHJW4WlmvjHAt9g82o4xZ4Q/JC7BRkQy/p7H7aoqHS0iw4e7inAPQMmVl5MXOklp8D4bee08qlYEfaGq/RQWw0S2X8CfZShfR8e6DE6KOIh1dGYr1f9ze2Dns0fXCRrd/Ce3uZv/x/irQlzUlMODUWM90jNqsDEspe9c1NROL/MlX9s7TNmYhHVdaQsN1Pr1ypmih7L6U4/9Gys/MHPYMp4nLINwI4FbgUmhS92dTlDgE2/6g5+lO3R4xJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVNiVtl2N96iWWn59HVLHVtIol1ZcGAo3fbwl3C6MAk=;
 b=h4r2ZPkEH7BvPAyE05D9UC8awHsrL7A8snQVw3bNG1nFbr8gqps592/gf6pQ8I8786r/9AdWj/VwWPSBNsXhnz1dmHpxx3QKwmw84t9+OqBGfyE4WuJvUqRhjT4U8RR0ob+SLUp19m/0lIKMaYxW/FUaOGx9ekJSIL8ECYFADbxY9DDyhRWIy3fR0vEnJPObnDFcbujovqvE4Hv3ZpBqF64+69F+q8sa1kQ5kcAc6njuCi/iMrmApxMBBxj7u43JqydVpTCyzSirJdUSjNDQYmW1mSl8Bok7nBmz29vua3OMpn0AUsBgKX1oiNBsFX2WDR0iwEfKed1grOU+2f1nVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM7PR10MB3908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 10:40:18 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 10:40:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 6.11 0/2] RISC-V: IRQ pipelining core
Date: Wed,  2 Oct 2024 12:40:05 +0200
Message-ID: <20241002104007.991278-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AM7PR10MB3908:EE_
X-MS-Office365-Filtering-Correlation-Id: a6105739-bb49-445b-1e2b-08dce2ce9b4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcSRyuz61cnQQoKw1ZpkqYMknYcBDBy+O+sMXA3sc8opio6UToz7KmdXURf7?=
 =?us-ascii?Q?ihLWzA6wZKYRj7Y3ccu2mOj4XFWikj5qch24JztaLY0/oa6QNsHWF8PfPORa?=
 =?us-ascii?Q?nqxgZjef2Vq9cK1gSkrFDRIVnKZhY/dIAGg50x7wcf6icDFQu8wsiliGVxSr?=
 =?us-ascii?Q?L22KHn1rMVgc8EWirJRqrYnnPSlU5eMOk5gPqlAyzUXchvX2QYs6V1IQQQT0?=
 =?us-ascii?Q?Ty5RtmQQCFrpCviwI6kzCEDC+qHlC7YW9/od41U5KLiPTOPMYmCnK1KSC+Zx?=
 =?us-ascii?Q?DUqFM8XXTF4E446hPejumpBpDTU/3F/6wyfcgIQNPOgdAYfV61jh7OqIVd3N?=
 =?us-ascii?Q?5l9XupKrj/SjqaW0HuE61GzpK/xZyDOzG46bKvc54wHLK6vbdeAUBabHxUnp?=
 =?us-ascii?Q?UDQoUsSGyXRCRlpVATRdIoTxdhdQEw2G/g+RBlAY0Zeo3FLwGl4jXsVfN3xi?=
 =?us-ascii?Q?qO2JkdNGz5wgv8rn2kKlKBrHmbQOVXIgNKUMagvJRSNzdqrelOh6Go2d9AuW?=
 =?us-ascii?Q?SQQ0Anxafvp26ybMOiLK62pUSY4iMdG8g4MaFQy9Z7iDh6MV6GUawcGCDtLE?=
 =?us-ascii?Q?1DqIjW/9HjJPY137W+sTkerJVZHIdw2zUoLyZwkKVgsTFkRqurO8hrbiwVGL?=
 =?us-ascii?Q?DwZmXY+0hLK0lfCNV+5GdmNT7YVl3OliDI7x1zd5gBx4iQF/N7qJxt+9ugwB?=
 =?us-ascii?Q?2Im23DQ3OOwENY2XfJqGSufKmMTZAfBl7IHfOBLQ9gmS4IYWBpFMIR94+C87?=
 =?us-ascii?Q?GmTiwqcdRkhrDwUm7lHpfQIJjO0X8L6Dj+W+GVIxozjdZzddSmTFEu9nMZ3f?=
 =?us-ascii?Q?Mru4HH/K1bREeE/lSbNmUeu3MwDe3hvwL3Vx/TgFGUFQe0fQMbBlEcmXOJXy?=
 =?us-ascii?Q?cJ3XAeN1TDt3SdG0lNpCP1LNmGOiOH6fYZ5ZrtBKc1b3f+y4NVzUi5jf0xZK?=
 =?us-ascii?Q?pJfgOP+58pAW7wEcPye85o9LDUxjjTOKYXwm5HoaipS8RQU6L1mtZse9fv59?=
 =?us-ascii?Q?UdHeNolxpzGJ1sa0H/xkdheg32+24P9XnLo7d+EHNIjkPCKbfeuHQD6u0itT?=
 =?us-ascii?Q?jSXcA0amR7kg9DCk1kvSgWkOxv8A0YNwd5h32t5KzX2o3iQrrCs048KFKvIR?=
 =?us-ascii?Q?Q0mxrLa26ssQUvsa3mYR+Ab9aXGqrhmcJDP1qjFn6w9ZvAHE6HaDyNqDDqV5?=
 =?us-ascii?Q?+kIfL+xJZys/5DklC9CSRjuJHTU1hZtMLVIxEtyVkyTgXFwEKBDMzi4QvyVz?=
 =?us-ascii?Q?vILiyjocWgzcMtfGSE/pPvgwP9aUX+mKg5rN8jkMXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JWHiaGW+u0GdI12135hDf/MbCiLU6efqoEJKXMWf3HwPHiOFY2QSRe/JR3KJ?=
 =?us-ascii?Q?aAyxTKH95+6wb606yTnKzhqZasn79s+GLIdHByBfDBuiiDkx7wPImL7E3E6q?=
 =?us-ascii?Q?WOi13Fu8Pypz996+rkhbvabUkAzOTSorUE+aiD6+rPiZ5GQnBFBtLNT0KA91?=
 =?us-ascii?Q?pXMpem/33ZS9PLplUgjC9T9FiLmT1tRtUy6toBLJBLs0MORkckd4/LK5utHV?=
 =?us-ascii?Q?qcjdoD0C4hO3l8cPJaR0EYikf0bgDq7OpXKXlmToU/8BQSAdyu1kZVJSVNsT?=
 =?us-ascii?Q?sWL1BV97TAL4YJX0lq7nXk4NhHq6Z0o2VcUiA2GFqZcZrdLs7qfgIU/fWDdc?=
 =?us-ascii?Q?a1VLsvD8v4oFrgyaKBS29KNmJoPiLydu8exIQwyfZ/NczxnNOx0tIMVm7D4v?=
 =?us-ascii?Q?dYQwX6rpadU0jMFjs96fJ/rwDjwH51owQ1TpZHrUIZTT5hBGFs/wqrwowTK6?=
 =?us-ascii?Q?EG60YxXOLLMNO+eiTEVOmHjkiP4jytYPM1C7fRUC5KR55rN8eB3lOF6cqHP9?=
 =?us-ascii?Q?ZqFeWZvuFdGorXDlCCVdTDmDSnonF2ICZ3ZnRA+S3nZ4XH8LlDtugQgMhDGL?=
 =?us-ascii?Q?EsU+AtZx9HEBFfkQVO93YtUwi0C7utSYEqyT/2wVMz8iRaqAXuyyE26Pi79B?=
 =?us-ascii?Q?uGeBME/vLkTNxGb843Xayjsa3vrmdXg6peG1JUegV8zFBwtAir9YFNnEBENu?=
 =?us-ascii?Q?W4fTRFxej2y7Q5Zl4VuxAEpA0y0lySMY18N3uUqteBOp1urR+GrYkMeRA8ih?=
 =?us-ascii?Q?1hQT14sN2AHio9bANZExVyreMinGREOqmezFia01iuuZLJowZVEYJoOokCFV?=
 =?us-ascii?Q?uJna1DswRNljw4kHBaSO0Rn0YiDEMgRg84YHYObXwpizRTbz5pWsrPXrU3p0?=
 =?us-ascii?Q?GB0vLyE+llFlrB4G2j5bQWj0JizHPi4H4QCwrtkbVo9FxTk8XSxzu2DQGMgs?=
 =?us-ascii?Q?OSOhyu8rsIS4V3t80i513e2iMEafr8OHYvfLeqkItUc2plOFzFi2CpvPK4pr?=
 =?us-ascii?Q?odoW/kDhjcSoSYGBfRUFLE+LL9a/aDq418f0Jjto9UlJxmRKrUmLphLqKqmB?=
 =?us-ascii?Q?lfZEFZFXz5n8L2SEHKxSqVBvw8MwbSbZZvvZJdZDZuiDexXAwHSSqL96GJEm?=
 =?us-ascii?Q?A+XY/lCMA6p4ICR+tTrPP2iRSaxryfWK2btvVRYYQWkFttGJRprGgXOOoQ4h?=
 =?us-ascii?Q?BfV++ZjsKTu28iLIrGD1JjTJ5cbL4V5K8B3eQDGJXg/yWOdEvVTJjt3GELlR?=
 =?us-ascii?Q?Ze5b5PxfyprJ40SVStu7orqvGtYlTMUnxEiQ6WrMEke39i4Oeeuq0RBQf2Zx?=
 =?us-ascii?Q?c6ssCtffiG92TD2VdeYhJcwkVULnfmmhoaBq07dSL+svX4T/oMQozkHm6I3C?=
 =?us-ascii?Q?KiYwFip4oofMtI/7g28qx5uyd+YoAd/8XaVmLPgmQ3oJAgfMGPkjR7FfKfMe?=
 =?us-ascii?Q?A+jCWHDLESxcw2likx4qrZuj31iv068kNxjFyKm57aWP4EY18mXfxUgmFVWu?=
 =?us-ascii?Q?f4hOw3Yqi+LvDPJfbmbJVdC3yMg2c7CcP7QciOMUVhXTkqe22XtcoAU0icZv?=
 =?us-ascii?Q?lL844CBC/DCAfC4vfM7VMftGjDJHJ8t+vFLpXhVSeWpN74NINvIktzA51e4A?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6105739-bb49-445b-1e2b-08dce2ce9b4a
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 10:40:17.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWWyfjmcesrpjisYmI/7U3N8YgqGN1pl0tcsJZByRZhdQzWBM8Hz28//tzcP3CBIjH7o8E0Ddhk7GMbDMuavV0gGmJemUZNwoh0vPTnBuqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3908

Hi all,

This introduces IRQ pipelining for RISC-V into Dovetail. The patches
are on top of v6.11-dovetail-rebase. Feel free to ask for other targets
if needed.

I thought about splitting the patch up into smaller parts, but decided
to stick to the structure of the analogous patches of the other
architectures. Maybe this will make the rebasing process easier.

Testing was done in QEMU with IRQ pipeline torture tests, both with and
without SMP enabled.

Looking forward to your feedback.

Tobias Schaffner (2):
  clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
  RISCV:  irq_pipeline: add IRQ pipeline core

 arch/riscv/Kconfig                         |   1 +
 arch/riscv/include/asm/irq_pipeline.h      | 143 +++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h          |  35 +++--
 arch/riscv/include/asm/mmu_context.h       |   5 +
 arch/riscv/include/asm/syscall.h           |   6 +
 arch/riscv/include/asm/thread_info.h       |  17 ++-
 arch/riscv/kernel/Makefile                 |   1 +
 arch/riscv/kernel/irq_pipeline.c           |  26 ++++
 arch/riscv/kernel/smp.c                    |  93 +++++++++++++-
 arch/riscv/kernel/smpboot.c                |   2 +-
 arch/riscv/kernel/traps.c                  |  88 ++++++++++++-
 arch/riscv/mm/fault.c                      |  83 ++++++++++--
 drivers/clocksource/timer-riscv.c          |  11 +-
 drivers/irqchip/irq-riscv-aplic-direct.c   |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c      |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |   3 +-
 drivers/irqchip/irq-riscv-intc.c           |   2 +
 drivers/irqchip/irq-sifive-plic.c          |   3 +-
 18 files changed, 478 insertions(+), 47 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

-- 
2.43.0

