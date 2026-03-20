Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D73B5843
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042637; cv=fail; b=k9AERkQcBSS/GI65G2AdyvEvjFCtjMFGVqW1kicTNTFxkIJacuae4PkM1Sm/LrM5cskRdLKzsrgHb4dQvoJDZZy5PW6HO6FiVE6JRrY5RQHBHQsrVAcIMzeFZWPx03JlSqjaRmNxnSQJqIeBlTv/OzveUiVDAPmB7Q/WkQMeme4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042637; c=relaxed/simple;
	bh=weahQ+dooGdePMBjJDIaPKlQADd7k8uivoV9dNNWpQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCb6QzFPtnLQm6ZKMSfTPw1jNgbpWdGp+oa92pNKf9O0njBnkK7TtSFwqd1s+hzkPcYKcmIL5pujqBA1Qwe3N8e5zwzt2qX3GqJ/miEtLCTzp/YKY7+duCcwv77rjxatCxNAZ22XLjYejzDYiIEHp+ZAwbcupeoIFemiXtjBq8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Uk3nA8FT; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Uk3nA8FT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjkncWBvmP/ngL9IsQp9DjIEx9laUpzVksIhjPEu9OCyY2Rt52OrJ+o1rHAe3i03lJzsG7tX+qeEOHN+VglqZVZWnyZJF1j+4PdXjvekBIBlV6nxffUwOA6nopnwQPGEeZH1c+gWHuELoWvValgmRXR963cWY6mXyOoHd/r3EKoDjIMy/k4RUTlPQ8vdWwOKCmNxMGej1EVsTcGuYXjL/rHoWJcLGtmNBTKu39nriTEZcd9BcaZLsAmcPgmUJRQgMzq8ftV44FMJRwIEapzNMgDjNUVKxgMmhrgiWjmBO4MK/VpJmCpJfWxGb6G09faLKNEKLwkCh/IgkNURo0mGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk5jwQbpCv07MQjc4G2pNa5PAnE+iUP9wlVIv42DINw=;
 b=J/RcSzMEYS/CZXgmKfScFCylUr2hXSJ4xJj8V3C8RAgiRBADNA+MQcdGJAoQ0L+D7kZ79u53OParwKN2kxLbcOZCgTOuW3ouFQD2E2B69LZAnzmLYHAbXti9lQLPobWLKwKknPocuymNLydbQNCix90V9gQl5taAzEE6PMld/U7FnR7UpjWf2LMam72IT+/Yzl5/HrqeAAmMbpkN0oSlEgX7tKUDvEwr6gNuBEHR8PdTx4z538JctUyXdw7R49rhDnD1usDd5SR+l3AYghwhPjOAkzzB4TA/BI4EpeEEhMxqHZbybxXb9PJBL1377i2xWXGMkwcaFwhUFKBMn38lJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk5jwQbpCv07MQjc4G2pNa5PAnE+iUP9wlVIv42DINw=;
 b=Uk3nA8FT5TJaYM2kYUQMsYYi09OZhd+CoyR7F5x8TUOlxauikifvMwQQSTwKIQetG/beKEPkyd6DVdVsyb/Z9otuxjppeH50rt5b2vvZVkYmXwjVGjV7+t2XN+9xNHz1jjGXhAORNhjwmcalWIDHm7oqLy12cF4HsqGVgpa6NicsrY8AU8qJTE7YeHW+RUs5orLpncipyxq2AAFaJr4cEAb6a7FWqpKgt1BEu98mq2sn5Ru94m2htB1308R88xDjrkzeAqFmktH7DYuVG1XEVhaMNtn7U7vYkyZo93+v/EUjjG90y0A6IxGEApn9W/rtuY0WIJndCmr+xXicaoksQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 04/12] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Fri, 20 Mar 2026 22:36:49 +0100
Message-ID: <20260320213657.2210419-5-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 297b4c55-1715-4fd0-69a7-08de86c8d69e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	GEPn7AkZQJStSbXuQwDJdrn9/bdhHiybB/rSLR2zzCkWsuhWfXhHoGY4r42b2OW7mVIx/3ClqIUZnG3H0ApIP5xT8iD/WOBeQDD35lpOwiDTOGKPWolPUNasH7IuEnsLbwhm3QyrrIhn+UDARn4J8H6tCoOW1IBjbsg8mcdbMixUs2ewg8SN2630zIjYxNUo1fQIbVyvU4QE+RVFFo9pmVZLPy+OseUX6yJuHtSgNtHRtVaxNCZLB7PfIaj21YN2tHIcKc5ITXk0n/pvryLuCmTcKRqniEixvKg6z86YuBlyY1koHoOHKtf9wd+VexfdesYVTa/8JoU6BIk7E4iBGursutp0hCeWERqhNLuEM4gGpkNeXvO7VNIka9NRAM5z/sBOXG55udykbL/z9Cbur4KIPF6W8gMKh0r2vXJnAbwkM+CN/bIu9fC6jv2IkZBbMnctvp1h/lZXNC0amkUAMO6T3zVnb9bjtSkoffhKftFNrqXmpDkT9jpt6ohIS86dJsDqvVdIXhpo/qxi4oGllyxD9X+ihP6xxrzTC+bZJP2Yj0M6j5N30z6M04tpeznOCIFABbIwyDpyGAOe5srdcJ9gl24T4qoWA+lr0G/GNoAFvxRzb+t04768xAMeRQJiu3xNAAJdvRmYjIfehe3mMFHrbTZQo1LXbYAD5Lo3glhMAYqvelyefOa0RP2BGxu8n1r6KmHEWD33UGyQB7sUL9R65Ir0q2j47uCB3qn7sU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5poGs8U1dWUe6QooiS3o6TUofbS6GUJ6OcSnDFxGs0tFrw4F8kZRQLddiaV?=
 =?us-ascii?Q?HZLr4UiWG/2ns6Zo0PT1Zy4F+7vRZvv68/WKa9MV897imfRRCJxL2ogL9dng?=
 =?us-ascii?Q?etzVoPElA3aOxVRgzC13Y72pZIDLy/aVc6QUxNKURah0j6d89xVsquC0TK5P?=
 =?us-ascii?Q?hZl4/jtztO4vN7ofVSiW1z7b56cDx73u8bvnSX/+S8CZ6U9HtDWQ2XorEcCt?=
 =?us-ascii?Q?TB0xKDiPbq7qyW9w8Me55TdTtZ8dEzSVjRwBqIxWEMrJEWsBwxLpvdc2IL14?=
 =?us-ascii?Q?4wfx3IxhkpQy10CPUap8GBHm6zGPqjLDCike0zAkn/Dswr08Xefk+q02Otis?=
 =?us-ascii?Q?lYeoHKgmyxw2wtY0Su0vIAjwpRgixv5D4aVS5WO89cdAy7QXdj+7d26txl/b?=
 =?us-ascii?Q?MbIGyZbyjJ2pzwLLL/8d9KWaCV/yXHg0+t/sXPEvhcMWcbaV4MV78q6DVbUg?=
 =?us-ascii?Q?1hZRG+MG2WiZSZEOeDCHGI6DFqfF9cuNJEWc/tORA0hT8y0ex0QYYTG0uEyr?=
 =?us-ascii?Q?4UuwK3Um87P156d5E5yS5rZvpRrVnav6zYr6RcuuMEDLMDEoLe1LxI1Rafbp?=
 =?us-ascii?Q?VGGAEGVl3d4HlYXEOwLa+V1OLBq090DD1+HyddB7cZ2p8+Wla+p1tSo4IVtq?=
 =?us-ascii?Q?9PNDl9rlQy2UNYZI+Uv0UQ0U1ph/4y3cEK2IUKCl/mRAw+Xoumo+qfGLQldE?=
 =?us-ascii?Q?hHH6GyIRYsr3wbc1ebE9LtrtxrBl9KQcDHJQiagwcHFaRkrs1+ULbNq/N89O?=
 =?us-ascii?Q?zzxEn1tncf/5WXVY4BR1TL5gOCTitXWoxBCb2q+YMCpWCeBiM+YTgF9jnZEe?=
 =?us-ascii?Q?0EFuOm/0ZyAv4DJ+BdNx4KFa0Lx378V++A5Yvg6hvn1ytvdE9W0xbCParwlO?=
 =?us-ascii?Q?9AsuE9+Mpb+Ugp6aTlZbETKcmCHDWjUGlV0rRJ7ivHRODOngaX+sNxuVqIZx?=
 =?us-ascii?Q?e964Rxd3j5wgyDUcHDSLUX2ydHNJaldYlCawv1olgZ121VOGbd/B+8ua0b6u?=
 =?us-ascii?Q?plligLgrzmi/DqshwBIbG2N28xMvI0XlNnORphyoohUYDgRhXjSVw8latIW4?=
 =?us-ascii?Q?JjzEk3SSQdRUteZ9BiLAvpAyNIBPPe6CIzK0T49lSBphE6Og4ktS7fMo2siw?=
 =?us-ascii?Q?ooaBlgU6kFAWbkBVQSYUlX/kDqn897UWRRHYzlWcsuPN7im/oOROiWz42gx+?=
 =?us-ascii?Q?bfqLyDrLBIX8a6KIOUsyGI2Z1Hk7Pc4BGDIkcIl9imk/4HlRZY1auNSldzFQ?=
 =?us-ascii?Q?3O/KqPO+a2wXEMZ7W0LPWH/ELgov1DEJfxaOgM8QASgLjwmd8vV7eFV8z03L?=
 =?us-ascii?Q?vAeVEX02CDwksUsZWWdeMmKRBu4nFBNUWqhB2SUH5buX8BSFnDijuoP9bHnF?=
 =?us-ascii?Q?g/TEu0pZ4BRK0tTg0l6fmyIiQB4vXocQN5XQGwqS1ZpuhPgzdZJgBe9V6oPX?=
 =?us-ascii?Q?iLgmrgvmtBSYa+CIOWtqz7lBgDkVvHkvv2GtEE5afVZpemPhOjyY/cv87MMu?=
 =?us-ascii?Q?jpdf4mlsTuf7gKzS3tUdj/it9YdVnA2eolRd18MjCyOPCifasxCbp1o8jsDS?=
 =?us-ascii?Q?5N9EgqMTHXjrC0xQOlzAwJ1+lOGbW04YEZjuwviVlAL5PrHO3kGv5SDPYV1Q?=
 =?us-ascii?Q?syHGuxSB2swmcPWfPmuTk6mtWPQp2xI0Ki8TOsHj46x006fUw819PgLZrxin?=
 =?us-ascii?Q?mNpUzveiiy+rLo0MM4YknFdbbG2N3Jdda0i0mbuAR63SmvARuAK3ofpomowO?=
 =?us-ascii?Q?rTjDICMZZST/2fcBPTb7CYv1c6FlAmM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297b4c55-1715-4fd0-69a7-08de86c8d69e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:08.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13/2YFs1pf4CKgPGtLsHHu5vtcyQw3C8kOyJJuswat9Ly1KiiNDMdCxmoZZJeV2knOh56AW+3Kc87gZ2X5NsnEU6Q7wU6I3LICUD+YnkH/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 5a9650225dd8..b5d7205e1055 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -89,7 +89,8 @@ static struct irq_chip aplic_direct_chip = {
 #endif
 	.flags		= IRQCHIP_SET_TYPE_MASKED |
 			  IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_MASK_ON_SUSPEND,
+			  IRQCHIP_MASK_ON_SUSPEND |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
-- 
2.43.0

