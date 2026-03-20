Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FD3B9DA3
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042640; cv=fail; b=rpv1bs5HBMUBQ2rubWwhtBgwS13Nmc39up1x7YtMXbI3mzpLz39ptqFam15Z5mHogpFGGBmF8BsCY+SFyD1ybha/tMy4vB7zKR4/1eXc+E1mWavYauK/Ye/zANQ97htKI5NzwG9fOhO5cdfyWOqKpIgR9R2GUAdNcp8Hcgq2/Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042640; c=relaxed/simple;
	bh=YPYNvUhRctDSJGE7GHjNs5Z5668S4zp09jgtGXDCBO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbDjqoou0vEGOllX4TFmJn5MbJ1TrSJCMEfYZHBTd1Vw7ga9HxnwPWN+EhM3mueaCkMGJj5/UHcSNzdsTRHgamA9G6ZTaC1wVsVvZbUQJ+x0IyahWAZNpUYU6TrI+ylsOm1U4DzDjVqTvwq0rAkIGJkFEfZ3WUSY6cv0av/cOxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QSW4vzqc; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QSW4vzqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OF0RJ2kTn7OAnovZWJPbr1LHnSM36z2DO/kjn7LMpAU8TYBZpVU8Lz60nwtzSI5jDqTy+/18G6yJgmt9XN2Q8iwGJRc59zz2+U5NpHuOv5fccIJ4lgerPnHR0YlBoYvnOSiHWZ+XLpzmGyIFU4IuZ2O8PoslWcuESXOcSZQPs7WMwPnONtdzP/9EtdrJyVxT9cRdCuW/vnL/zUNMppBkylh9LIA1tyUKaRIhnUOWWy6qkpO6jcWMICFwK+LVh78FXVqDc33CUByXCo34/uzlqJ4jueSYc2iMI302uZx+Pt30NAMmSI5b/HQM8SY6ukqsLYOnDo/SQoO33GAMeNH8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWOVY6RJz7PdiR9oGetpNbQJBWMuJ2etrFun8MGoi2Y=;
 b=cuWXkrU/9AsikZ66YhvHxZAlGI+khvnXWPAQ+olrdPegkw+kaTXLCmOD89w9GT1k0D2JTAQ8ilN66EsCn9909vCU/J5wlT86Ts/pSMWGMT733ikzMAuS8nYeM3m5gQ6CmioxLvayTqDBgkdkUCGr2gMri1mda7Zpq4z99HFREYqs9O+L9y1h/IrTWlM1pG+jGIelzBXmrhdCYjbxoaqliQ+0cI9Y4CfsK5XpCQtKHpG7AMuko4ZwPOyBB+xa3ZB7obMM4DGXLk3UA8eMGlKKja4acFNHvmIZILrkWN8XLd9PpFouuMv92uKsPVVdc8hiKRr90pBrTkontE8K7XVDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWOVY6RJz7PdiR9oGetpNbQJBWMuJ2etrFun8MGoi2Y=;
 b=QSW4vzqcBMPcNztaPa5GnD7dKTsM2tTeEhPOI41Jr8EVOzr6MBI0Ygeb+8/MLBajwPMi5eDHkIzDC59W02mxrJkji5O28qFlDohS8V/B7YvDJfYCQEYkNLCnOSKJgn8I3kmVcTVg50RnhKvvou6x3kKqALmLsqWQmQ8noAefMveJ84uK3WfdyYkknqq/B0wFvSdMqEPkCpz5tKe6Eg+NxADDb40fKepOyGaBIBb+2arKvy2D227UXXNMhrD1m3PP+2cGg1v+O5gVn8LeIO7AMi8LpfmLkNoyVUxmVtdbRbnsC08J5HvbMQUBoYwcfkcZPkLjnFi86RrPc6rehTGWSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:11 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:11 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 08/12] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Fri, 20 Mar 2026 22:36:53 +0100
Message-ID: <20260320213657.2210419-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
References: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c4c4bf-41d4-4113-289c-08de86c8d81a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Ly7ZnYEzNt18AnjfWOtTB/zwOLayMTf7aVvemy917HIgvFLsXy2b/+161JEULLPAL/GHu8rAm9+y2FLfCFGjl89RZPxz+uedFRq4iJ3NfgZbibRbXp0yiaA/5ru4oWjgn0kTqPM8fCgt+MLdNpXpGkfZKijSHPYA+pkMj0IpX28jUgBwAIFVLERNhH0zhGb+8b7LfdAJcZ82Nhshrc1VC50aeNLz5Qu7cGiM6H+j4RvEUFj0a7NSZUgvBS1ZUa5qAKqKszgQw0ZNmuZkfr7DzSU0MvCUKtLeChOUAiUazWUYIf6GVO5RPZtDO7ZxLrfGB8jCNmXZDVUiQ4sOboLO2H4A1Sm3HP+rgwB6myA+hzwu3+nhqpA6EygJuCD5QHzw9AYB1PDkNohKudKb+QhbcFnjmvRZ4Rj/LPukPpMuS3X7P98E+O+4vRFfhbAy7iOurUCrpP+FXeAfRRuImpIz7IpZGAyrgCB/xdDzvNdvz+riUO+I6Yy4tRrYcfn8krZmnLZSnYcxEe92tuWmulSjxRRvIDJ+nVOdBqIZEO4ag1RFNFTjuVlJKXKRpEYcICnBAugCs5R/XbXB1oCeKpVpX7IbjnyIDUTK0PXtmYlR/2DCHXII2Cbm9VxECqu+9jVfzkm2hqilCVgMjRFXU/Qnl+ix6q/GLUTRNAcg8F8Phb3plopKMky6AOcO5CL7xYk2nKg83qp5rm9Ifv2wtAQLKQTNzH1OAN5e241QJRiMdhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QfcUp3xAW/ogK4gBj0th5aALErWFKwBHjRvtHK6xSmFxrGXGV92mIs+aDUvU?=
 =?us-ascii?Q?jLnab3YIAshWVtoPAvYRo0FDFQUeUjdaULe3XjWp5W4pPgaDZ8gxVQaaTm6/?=
 =?us-ascii?Q?En+VUpwPenrOSfSp6my2/E9Y/Kfqmi2eNC7F2d/FI8Zu8Ff8rtiS0zXR4Y0X?=
 =?us-ascii?Q?x98LCseKCuqCeylc15zh0G3T3zsCuY50fkoBsHUNU+zRqOOJD/P6ru5IbVG+?=
 =?us-ascii?Q?6UanzhVo2wQAXl/dBEKxAVKDEEEwRMACktTWGGqrBkaxUMe/FCJojp00MRJG?=
 =?us-ascii?Q?LFKlLOS3UvH/1LRQbLkCSmTGpopE5O71v5DwmpKGs8pZIPyZmij4F6xqWnPH?=
 =?us-ascii?Q?3duofZDqE+iRu5hyOO89ks8pTgMuffnmGn/o91mz1U4blXBGEXk+d4XZ7+Oy?=
 =?us-ascii?Q?2oJGthRfXyZFGBVOxB4GSLAGn0TDFpwjphGjtcEWk7+F3nTGXROLvzB6ENMn?=
 =?us-ascii?Q?3yykKRo4KuFgSZMlybywDPQxW1CUVgm4I2zoZjxvFWpL+ECw3Br/gaMMqDvu?=
 =?us-ascii?Q?30v8pAKzODnxwz7lei97G5rwb8QAJGul9VwibD+6xm3lBPtT6EsdZTu3BRII?=
 =?us-ascii?Q?IgxOfppAkTM5PyE2vsgA/tt64Y2GLnNQz8xW7S0EAh0do81x1hMgRFVhZ/KR?=
 =?us-ascii?Q?dHswvsavQFslSsPFsJ/PqrF67R/zs9JFpmCeYB4LtQWy/fnBnR6k950/DJGN?=
 =?us-ascii?Q?S9ziYXWX9SebkOHNNfceq3uZ8y5id6z4OuSjtN/4rAyPoZawz2BMmnNWTKR8?=
 =?us-ascii?Q?t1/tfQTbBs7w10rJrfynq5RKS0nhmmKYllv/UxhqkS17qX21l+C/zWLvKduo?=
 =?us-ascii?Q?Ubk4vpStEA/0tPEy9msaTKnBukhDOf7L63mJFExTp690PHhxxTMmozTmjSRC?=
 =?us-ascii?Q?Eh4k2l7kgcS884UpGY/1nUzh9qjNh9L3IqupjgQH9xjZzAXKSkjZmfgwqVje?=
 =?us-ascii?Q?LFJtQE/tN5CjSYAJsmXd0K7yzEcC3Py+3PCkNZPuo04j7/JYS+sdcEsFKvpk?=
 =?us-ascii?Q?OaObKEN1mpIl3xCoOckuzGy111JU7KEWarOUCEutwnGqwi4668c0ZXFQThve?=
 =?us-ascii?Q?bLyAF97aNNjlCLHgNvBoPnfmgjgFlu00QXVazTv9DVZsHvM2yEr0qaapgqbm?=
 =?us-ascii?Q?ilcZzco23CAME6NazJdTN8y+CQlmxv5/yiQ2XmJRhy9MW6fS2p7shyTET/uz?=
 =?us-ascii?Q?Ti9F7KXs+dx9Ya5sXIsGdajD1obuAwKwE4CQh66HjtbMezfOqFnjPYjB6QrR?=
 =?us-ascii?Q?za26fv2rrfQ2BvwqmluNiJ3geZtjf3bm2MdHDhdQjaDOEL4zxY6VfxG+BFtf?=
 =?us-ascii?Q?LkGTW4117Uur3d969uLszgdIpEw5jNBghLYUeE2wYy4r3MwX3VVaZ4RaO9Iz?=
 =?us-ascii?Q?bd98WjGiquyg1dsyBDeNTjYkDYnnKpbbt5L87JiEXCgRtwSRBTakDpI0ESrd?=
 =?us-ascii?Q?utUixTbYmByvlhFwZ5nMO0aHgLmHSQLKIoobWE08tuxDrK/LDIel51NfDsco?=
 =?us-ascii?Q?0Sf2/sddstrbI+Rf75vmXgqtmgXtD70+Oa5NuMffN4lqzGXJiU/TnUB2vLbg?=
 =?us-ascii?Q?bXWyTrnz7TnOh1IL2lz+gwy+DAzBAh8XpeOGoxbIMv/VPwGFoKuIOSg3UJVI?=
 =?us-ascii?Q?o5X6nJXgPBygqbgylsWyR9w6eDcVu/Geek5disv3nNYCGKFyqoqTGTIcd+u3?=
 =?us-ascii?Q?O4eXfqyHAc+lDL0D0proqSaC7xa1xu8NCI8Am0wyJhG059q1zqKTOWcYD48J?=
 =?us-ascii?Q?Zfa/9Cf/8FOmAM3+jF52kPOvo0I89+Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c4c4bf-41d4-4113-289c-08de86c8d81a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:11.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrFFP82cBEDXQzOdZgGd4uWLHmAjdSK5vYtYYrwfseyL0S5XjB3ztajQdVS7ltmrnOk75aoEbWR/1uGZgRR5IzJ6hru62mLp/VeCgQbzuUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-sifive-plic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b0dac104814..e9ea0c86366e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -88,7 +88,7 @@ struct plic_handler {
 	 * Protect mask operations on the registers given that we can't
 	 * assume atomic memory operations work on them.
 	 */
-	raw_spinlock_t		enable_lock;
+	hard_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
 	u32			*enable_save;
 	struct plic_priv	*priv;
@@ -227,7 +227,8 @@ static struct irq_chip plic_edge_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip plic_chip = {
@@ -242,7 +243,8 @@ static struct irq_chip plic_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
@@ -444,7 +446,7 @@ static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler, void __iome
 	u32 iso_mask;
 	int i;
 
-	guard(raw_spinlock)(&handler->enable_lock);
+	guard(hard_spinlock)(&handler->enable_lock);
 
 	/* Existing enable state is already cached in enable_save */
 	iso_mask = cp100_isolate_pending_irq(nr_irq_groups, handler);
-- 
2.43.0

