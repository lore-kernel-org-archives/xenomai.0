Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DF3E51C9
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547483; cv=fail; b=Xin6yIeItH3MAcoD1TQzLIzdCE2FRJOGlRD9ZJ4/osw/b6UBWhfjbUWFN9gUxLVOoYi0FaFXU1VNBonnTlQVDglzFDDljG7B+VW0GZGXG0IJ+7drek3Lie4BEsefpQ8PMjtGXEP98ZA53SbXE2pYIgS7W23bFmZkLjbx1aTMhQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547483; c=relaxed/simple;
	bh=X4jvMFxOthl9BNbditVzefjy+cdEpKUtitjpTU0Hw/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DNhHF7fcp+ZIHZuIuYxBQWBAtGDk7ZO6iVaxI4I1JqIY6Cn5lNlsNtcZ3jOkLkrgYHi6LSk+IudqzTJmZIVtm9f4XnM2spYJK1S7URStApQK+PFcBdy1m2+lZ4+tMeMrqTYyq+r4SQxfDx+5xybhupmMnDawMoP37z/gkWFQkQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wPVBE1ON; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wPVBE1ON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO6rZCVVaAaqGrkiZIGnygDVH/9dBehXicdkAYWZebG1vwWSAwhbC2JyR5QNzpgvplY8QG7OgKo17MgWLtkzR7lxVlYJdWjTX3blVfRYbSX4EeRvk6nZExwPTwS7LXccAd0IjY+zeucXsECYegZ9EBqo2+aQZypZtjtnQWuNe7lvA28vCAg2iyhuJbF6pr+KCQp7WttqtUBVaPfWt/L9KP7cHm0mlnhvoI4vJyNOGgEgoO1Y+ln4bK1dfBEAxGGrd7LKrqlGv9da4NzaXBUcEGJNPCTLRaAT15Eq2gftFvzSvSrPdq78ibyi3v9zOO/OfES/2Jsb3VUrTMsXeP89EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TsOAEvUcqONhccQU8dOunBAKIt102H9FDeFVIlv0s4=;
 b=IS75wDcu7ZLJEGhcMng/eNHEaBJdQOcKRbExE/rAi1ADhIZ11/zNe2CCc3stU2PLv/ENFG2CT15R2T5Mj9WEPQJVBouJfhPyaBCgAN86rr+2T6TF2B1HdtiEAy4W62QoI2V/8fJMiVzJFd+N3w1W2uZ/2X0OzpoOrpZBnWwMqUDalaKQ+yDtzEVM+qBpnZZXXJFNeO7a0lKEkQCeFZka6tjsuCx+pWHbHl/6eTuedmRUd5B5/PdeJmMEjoAZBjqhPsTmxZNddlE10hsTA/1cpMaS/t33i4MPz8lO9UqjOFFxRWmZmEecTOgRCT4m/aCpiBcl16zbG36yfyb26Z4jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TsOAEvUcqONhccQU8dOunBAKIt102H9FDeFVIlv0s4=;
 b=wPVBE1ONHhlMLlHvP8OVnN2MRF9MFrowUvZm9p4XyglpNJ1KgjW9uJsXeib4UKXaPjhHjn6d9uWbvx8k1J8NTIWF8DoSYZ7pkP2j4zYrxwCidCtB6s+Af+HFKq7iRWFtG2KpJh8zWI/Qxpq17DKX1v3mI8N0fW9DnpHmplhQSplmxGsX49wV0hl3KW72rNXmh0oTxu6PvKXLtwV+wtOiSzheY1GF1OR2EI80SVaaVvTwNYiyhhg2Nxl9Jp4HHs3NIZ2/K8a9VcLJ94e0PsCKnAr/yHJZIop4p/eHHwgC499+VESFsuzJrBHW/2akUVtWvDcRcXgQzYugk32ct2xuSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 07/11] irqchip/irq-sifive-plic: enable pipelined interrupt control
Date: Thu, 30 Apr 2026 13:10:57 +0200
Message-ID: <20260430111101.1539377-8-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|FRZPR10MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fc9213-178f-447f-8037-08dea6a930d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	nX37BPt+8HybxHs+SB09hL4FCeMUaIBQj2PwW3oRmmxvjfdIB+pQq0iSo9ISFyHb0w9kYmis/e+jHf2WBzDijc/zWykFnQud2QL4QbpdIdl6M2FxS591mSwXi7qBywG84yFezNYJTpCHu3SxfEUV8BZNuLxr5kACcCMiBjtM4kF4jJ9zlLfup5HXHeSxNkcHYbCDjoC192cXFGn80RiGEAi58wj5NULiA6AA6m4NxH5xjIrYgmpkVolGKpBoqxDxeN0R8KI6yFSyme6qKWlXo4vy6G5ipqkgJ5v/pLNSXprSxhiXYWUI0Unr6eNqAUYVzxIwWi+y5givqbVPIXpgKIeO5YQP+ffRoMe6b2ZnaAM5eOpwV2XLwfWrNsDU1NGrvtvaF0FBWgOLzHmU7BcTuzYWEnUtDcnz0FMJ5YYwv10ikJ7YlcKhhXKILik5voabbpWrpiREfTdM1Yjm+MvLnvwuYIR9UEZ4PxBg3Ecjctm+mAbrEa3kdplfhp0ljRY8xqasoMRe+jjXZBYTLD+NtPLeqVq+S76XO8ZoI7YqRm1YbVuPo874CvwagW1jP+zBOsDHBK1PrrdgF6LKxeTqbgF2R7zHKQ2Qc83TrhCDYNJpSD45KKb+M5LKr8qFIj0LBJWjEQKCXEA97BTzVg4fREWtWi3Cjac5i3VrNkRWFcqGBTW00FgBM9J/dls/E4Zu3X3y7n4dohYnP54hu8ysFH05m2RVsX2EyqXpkxjNKT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KOlp2q3WI+qgAC9GtONP2EHF/Eanvk/aUADmIxbLMx5BEK3M91GrQpvCcoxB?=
 =?us-ascii?Q?dXpsA4djpdHf6vxa82bZMKwqufHU2yYwPY7FsOXGvierb7pa1t6VOpJ/uM+A?=
 =?us-ascii?Q?hSnCZ4bXISbfkUoOZqSnqnDEk26CUFL5Xw/LKc6ehd8geqNgrMDFvimxOezP?=
 =?us-ascii?Q?V6tmd6H/8EwAT2SHnbuZqY1mcAmv3ISXpQrgNsHv4I3vxaVIVMlB9EtprSgL?=
 =?us-ascii?Q?78OP3ZZFn4FSdE7kdBcRgpmuz7PGMPyk00hew79kKsHfsuw0vHM9Ddnff1mS?=
 =?us-ascii?Q?Docn+dADdx/YDnNYoPBEmHIAYlQcdzA+Ed6SngsaxCAT/AJzleLUeKbUSbjz?=
 =?us-ascii?Q?Ttx/GuV+1Jb2vsLZrb7sM3c+2NUpK+VkNx95FM0/IxwEEc56TnvU6FBw3msi?=
 =?us-ascii?Q?BlsVIeT4GNIMACdWjpAnJVrtzoPJBodmLqbKNA2/PKpakyS7y/ZgQLK7N9Ru?=
 =?us-ascii?Q?VRz0zbaB/UOJS4XRJNG0oSi4BeSnvMaLhBFon1mvrmCxLC8xwDpCaUFEsKh1?=
 =?us-ascii?Q?J2QOG/6GKJF0NRaHJ0vAGOBEhRNkxfUNrxDYKVSmipqGeyCW4XhP+e8xRqB+?=
 =?us-ascii?Q?Rq0a0LCy+qGYwtCK0lkbXF/lSIjXiCXSf51z/jC0U0wpggrQrgiI4pL5HxiH?=
 =?us-ascii?Q?rs5egeQO1TBVXqYmyBi8/ju8f3sf8yE0f6BFEwBY+1hcgrtK6ATcNSiElWaI?=
 =?us-ascii?Q?9qNZmEw2sImkOWRvK95WkbbaldvOx7f7DY/CNqI5h19Qw1zmcwzooQjxiNL/?=
 =?us-ascii?Q?3e0olKNsuLiwmuyMsyDVN6/TU5Y6hL+u0839leYGDkm6puLcdE2zwGz66Z2a?=
 =?us-ascii?Q?NhH28p5nQmEXMFJ7HzhP7CaM1u9kOL5XLzu4ieqmX/vzg3k6MDELWHQcPPun?=
 =?us-ascii?Q?BydEtaOmID+xo5em6sX4twbZiif5ZgkED9qeT9Bghy74j+bPUBIVeLOUmR3m?=
 =?us-ascii?Q?LZiBWvw0AhFl1X3b50DCxWR+e91rxmaDLBPY8WNEPsLhng/RBVSympp5tGV9?=
 =?us-ascii?Q?xw0/N1C2GpPYrnukPw2l58cPoOg//CkP4z79XjpbSdfFFt9difO2gj3SW1i8?=
 =?us-ascii?Q?3QaI3HS9zEhuFkAai0NnQXIIy3hQum+tck442m7a/vbfgu5iO2/ZsPOtPvpn?=
 =?us-ascii?Q?fTZ9oY6Va7/mxANE/SWiVuYcLgJMIBvk710Meb9pwAttemviw8kKAGt+5pt5?=
 =?us-ascii?Q?F4mDJrA2jRh0Uom5gGM4XG2kyl1FQbvjtgqZlPwp9+IAsOZnNLR5Brwh6BPw?=
 =?us-ascii?Q?Bmwq8QR0IRRUWXb0FQ+VRxLFkVG99fp1QVRSWh2lr8rkYZKdOnCrQ8k3r9gQ?=
 =?us-ascii?Q?YswfWqujlb4B5jHzDkbej2aRgdnICy5swPRrdkql4cuj4P4nGAJXbmvGYP9R?=
 =?us-ascii?Q?xyvA5joFjWlZMV1WWboJJboUeP82PcbrQdSl7LPggHzUGg9uCCE0sO2D5IDL?=
 =?us-ascii?Q?+gWMdnLSz7P9OSadIA6TGrR+abn2fVyynXc9MzYgVN57dzMGUyO2363m1pd/?=
 =?us-ascii?Q?c920AMcg6RyOFgPzOS01bojm6Uso4mekiDJ3/VVMtjC1lupjf7DcTCdcT9u8?=
 =?us-ascii?Q?S8wFhu1ejFAEDVWGNbRZbmAjHHBSwb3OCcvSaCTG66MUNe1Kk/BzV+V0Wac0?=
 =?us-ascii?Q?msQZKQYbpjYaBrmd/rXsYrCtABZPohLEgKH/Nj33zbxIhPH6A1VSIiSzJRnD?=
 =?us-ascii?Q?9Tvmzfx4/07YZvWNy/ZqTF5TtIR/iAxWEptvAks9Y0s5KQ/EeoiXOmB+JUfD?=
 =?us-ascii?Q?BaQiOlNBNUCoHnG3xQVcJ2rUi8DC81E=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fc9213-178f-447f-8037-08dea6a930d8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:13.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXO8mHU8ho9lw9KXa/TGbP0o55Y1FIZuc9AoA3Jav3m9zAQOJCSJI/8sH94vseeLB8yTZRzLReVMsqdvX2GBUbWuA8F8fOxLga0cCngxFLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-sifive-plic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b0dac1048140..e9ea0c86366ec 100644
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

