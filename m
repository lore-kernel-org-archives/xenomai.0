Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4B1C10
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 07:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRCMxtGY1SZm3KiWzgOPbQHHXszHle5rMyorz+lHKBJEOFsVtL9w9ky5bR9hwVFkbM8LdI1knBJnd+rlIyYRFaszrwahsk9V5fw8xD3QBhdz4F+oiPZpjwXAXnwaK6OmEzF08+dIUcEiwNQeqMyi4YdV7hoc2cB/F97LD1BuU815zDeTWusImw/q+CAfSjlIWryUNvTbsq9IQx0daiB8IrelDxBPV1SxzFWkp2bUZYpOSZ/TwS9Tv5hYh6VgXRTWaO5SM2rYe4PVkEVDcNoIFtH0l6g8N34dKDnWA65ibRCiCCG5y4sBP/qvd7cQXmNZyIh5ItExDoGidvx9w4Hyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt73P84EZO0djGSs+fc8zDaqK1wS/Qi+IvwV33GNI4g=;
 b=EvFy0D/+xkPigLGLkNfdoiCZX/3W6ifX3uhQMM5r6HIbcpUJNKxwhnEwFGGLStuztVMwkpPeP404gal0C87WmHxEFHXLdM2c2ihQn53cnAIBJerTyMRR4zEk6BDZjHTioIIcAlHr/rxdIHcbARoQKVyrxSqScplKGX6DmBVWzzsRPnYgK78JSGhWleZK/xTxnkswbx38Byof14TcfnQhH4G4Ey4LgQlKS4wVVAEOSQJ9yx/PC6UNamuC+txP1Sm163B2yFaCnJOiBMw1qSw/LnFH6FGWY235zlkyHyDpyPTB0GrPXVkTdKyj4SZD+gfxVoPso14WIlgq2ll6dE+z+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt73P84EZO0djGSs+fc8zDaqK1wS/Qi+IvwV33GNI4g=;
 b=h3hNgE8PelTmSKxhF1pbWyZ3m754v1yvu+phFX13MQ/LYJIBdOuHe/kog6aCzDXcQ2mt3gfomJTl1Csl41kX0iEdM5L9tAjsOEOWdTIllrLBsNUGangkW2kFlTrAgRYJRxdEzMGz86EvdFuegygFi77f4hJ+ZTTf6976bKXdJgWR9CIZl34tbIHi2v5Io0kj1pZflToDmErTi+8OWvVZZ7gT+ukVGpxu9PNJx5Xro60rGpPWX7lR7saGXep16yceAP8KbwpxMkNxM4mL2yAaBoknrK+g03ZFzOv7/APiJMTfgeRur7XMbB+jqtxRV2RZG7fJGTDyiW76prcB6lyOJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB3710.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 07:40:38 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83e0:fdfd:2432:226a]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83e0:fdfd:2432:226a%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 07:40:38 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 1/2] linux-xenomai: Fix SD card boot for beagle bone black
Date: Mon, 24 Jul 2023 09:40:34 +0200
Message-ID: <20230724074035.81965-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|VI1PR10MB3710:EE_
X-MS-Office365-Filtering-Correlation-Id: 37064683-382a-4c25-4fa6-08db8c1945db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SDZtr0420IXjfCgnwChNJcqmke+O5z3cbFhNP2bcNOW244C1UQMFDYGoO6Oq22cpsQN9c/HqDsVr/z6WcG1zz4nHmaaVRVmkzG0jz49c7oKluEs1Wr7eees8BE+g/V5n3Lb5zYhImvWGd8DJzseona3aeAlT29P2raZvhrINknLk1mgVaJlI0I/nd94B66qt8KznCYcLbIxxw+taGeI88J3oXloG4lnjNGrg+pK6K96+Y2fsi/UXAjUI0h8jTUum05otYjHrLoIzVJcNfjXG7GbDytqrA5s2Wq6AbTyvGwCe2N9kGGCkE2F43/S2Y/ITz2TSn80i7ouJ0EeBfteWlDE0qP52KOwJHhqqIvGi/Eab3UZ4VvtjueiD4wUvIxJ/MHrFhrqj0SDCNiFv8SRS9fq6mjODJEkNxt8Vg3AXdmqL7pfP/a/uQNnh+Vr4b70aG4zX2/scZq7KrQrlK5a0NXEyc40ZYIotG+32+Zc+WVDUFcS2HQGBHJyyQfGA64joKDuCfRBnKZMrqA0aV0kNjGS5rc2e/xncpQ4xg+IeH8jrWu0EmZWjLrVI5+dnGgMv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(1076003)(186003)(6506007)(44832011)(5660300002)(36756003)(8676002)(8936002)(2906002)(2616005)(82960400001)(86362001)(107886003)(38100700002)(83380400001)(6916009)(66946007)(66556008)(66476007)(4326008)(316002)(6486002)(6512007)(6666004)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZRuCv17Rtshs11pDjQIP890rmidAsYLc28hbuS3jy++iu9bJfWlVXWliL2TA?=
 =?us-ascii?Q?9R9lmH3wqkc3iMOUBGFtrmI34Td+LGyzGwjjeSUud3oO4wPsoVRvzA8/7/va?=
 =?us-ascii?Q?yqJQunlqfd8aZpLpRRkzbPJ5auxUsTh4eqrRFMGEnRz+EL3cxzTOAK1VFC6M?=
 =?us-ascii?Q?qqJG3mNLUCA4wQa++cEn7BkHgRMMIcw2Q+NfAc3K/1SenKJjkC7NUU5vmSpq?=
 =?us-ascii?Q?q87+UbyQQ1zRC42L+UdH/weacFT/9xiuFQl8Lpf1LFT/2UzIgKOyFm2ydLpV?=
 =?us-ascii?Q?Z5Bp1fJzAvQddnM/g3VU1OHIMV/r6l+A+MVdTih8lT5Q5IVu1VPUHSDY7/Ou?=
 =?us-ascii?Q?Qj1szbWuCBUxb5JkDLIUH86S35zuLfPkgdHIzPWi3vlbCCYIzquC8IsDHvC9?=
 =?us-ascii?Q?0nHdKQlsCwm+F4g3+Ly8/KVWz7xLqYkNqFHWOpKBjqnMUnQK12rEzKVzrsCn?=
 =?us-ascii?Q?b+lpidEr8KAiGHHAI2tVfHgQCEOInsC/5O/PjmKCljNEcq9nOdZZoftyFfIJ?=
 =?us-ascii?Q?FqNMnTUwU5aKNMYEn+nU6y21WF1+GOvHS19x41tICcRcSvIxUV6DQoYnuKzs?=
 =?us-ascii?Q?gW/PB4729mLHxvHLPP29jJD3wBaZmPBk1wlbpawFdIZaMi3reguM633P90zR?=
 =?us-ascii?Q?IfO1Q9jmoQShPrAvR58f3uBI5PQNbF5ogbuv+tQiE8FumDn8PYwNm4T36/pJ?=
 =?us-ascii?Q?8kNIiq3QY8BA/jhAEPax0eR3EgKoyoWIEq/4wzTfzXPhtA0a0fj4JwJDK7Ui?=
 =?us-ascii?Q?OAEej+Etdb06ko/KaOBBo9SoJuIetNDIIkIrOztxAUbQhYSdwrz/Pt7HRYya?=
 =?us-ascii?Q?15xHL8WWLwsHx9v/cUP4AAGAGlUomTnItyisyefZZVL+Avsg8HeKngfjIhRO?=
 =?us-ascii?Q?H7VoDzrFL6R703hZsbzM0nzOoTOTly7E/el4f3F9tMVrZv3YWJS5y97Ne4Bm?=
 =?us-ascii?Q?YVVM44R5ETQeR3HTyw24pj4CIUlKLW2Q+vT4d5WO2XDc2eSED7fR6Rqj0Egp?=
 =?us-ascii?Q?EdQ8A5cog3G103wMRe3XJyqwhssWlXS/oKZbTC6xgh7ysL14Y5eSILNlnuQG?=
 =?us-ascii?Q?WwbeCiBZMx0WwDIwmHoLAej0/8n7avMvKgwGiwcOHoAn4xd0ViVlv2Wf/dsR?=
 =?us-ascii?Q?anV70Zon4hSOpA2EmNE0M2GNP6w3TgOsxM1NUadqlRHXav0jNL67fzAtTrG3?=
 =?us-ascii?Q?PHXAcNOebP5B1stXSxZm5OkwedI5YimLVS44+nCRsH644Z3ufrCjY+mhM3/x?=
 =?us-ascii?Q?itLJ6K1t62JDgf1OVVYkAdVgGQMMaNFKvUyaT9+QKWMwC95i2Fi0xlEncUsI?=
 =?us-ascii?Q?OvDVhZZ4780xCbuXlJFWbDSO0eI9dD1M6J22EJYdT9EnZTaZBZEGaP3dhAWK?=
 =?us-ascii?Q?raqZeUK7iPLi4+i7XRqwpZQtQSQcXeC/Zl/cbl0dE1v+rNyuy7FUBjJronIl?=
 =?us-ascii?Q?MD5X0WlyGQWGLxNddrODc+VNjVER354PnpvlRhPAr8WGZcUfJO+ODFxjIyY5?=
 =?us-ascii?Q?htqGBY9dIlOgoOixcXfsIHh1z/cHOsBqcELPA9tD503HfWfqumIoNyfhluzS?=
 =?us-ascii?Q?GB4F5IQYQKfVZOTnvY9hQSdxayQZJSDEWXZf2w9uUy4jJu+fR5Ej/EphD5c1?=
 =?us-ascii?Q?HlmqnzLjoQATKArQWUBAi3ClOPmw78pChlZzXpUKIqW6HbpEZ6DOmRwDX0vX?=
 =?us-ascii?Q?v0jOow=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37064683-382a-4c25-4fa6-08db8c1945db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:40:38.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbgtZ7e/+CyrgI8X1owmzQwtsdtrI6QFE/2PHSlen/ElXHVH/5cvW0iCpzunmUHircNBTaFR7vE9Hz0rU9fqkPvNJbXA+nyZl6sw8NttCsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3710

The sd card boot was not working due to missing driver support. CI did
not recognize this as we use NFS boot, so no sd card inolved.

While at it: Convert a DIY machine check into a machine override.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-kernel/linux/files/armhf_defconfig   | 5 +++--
 recipes-kernel/linux/linux-xenomai_latest.bb | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index b9342a5..dee6f5e 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -5192,7 +5192,7 @@ CONFIG_PWRSEQ_EMMC=y
 # CONFIG_PWRSEQ_SD8787 is not set
 CONFIG_PWRSEQ_SIMPLE=y
 CONFIG_MMC_BLOCK=y
-CONFIG_MMC_BLOCK_MINORS=16
+CONFIG_MMC_BLOCK_MINORS=256
 # CONFIG_SDIO_UART is not set
 # CONFIG_MMC_TEST is not set
 
@@ -5204,8 +5204,9 @@ CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_QCOM_DML=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_IO_ACCESSORS=y
-# CONFIG_MMC_SDHCI_PCI is not set
+CONFIG_MMC_SDHCI_PCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OMAP=m
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_AT91=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 7d002f1..e5348c6 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -74,4 +74,4 @@ GIT_BRANCH:arm64 = "${@ \
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
 
-SRC_URI:append:armhf = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) and d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
+SRC_URI:append:beagle-bone-black = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) else '' }"
-- 
2.41.0

