Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D92ED165
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089944; cv=fail; b=MWB27AFwn49B/klpTkyAqx79dnQds0ktEHGXsstn7YJDXtzF0VoPCDtHTvu9p/IG/g+yJbp7w+RiLEwNqLygoqQ/L8phNp5xFYodJ7qTGWaKq5K3d47BD7VmQZdttLljLPaDSsWNMFbmUdfD3qFA/V+U1+aPfDIXcn2EJbYBFGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089944; c=relaxed/simple;
	bh=gQ4zNccu2bbzG2o3GJrCBL2jCjw4MUt0QK3aMgY8qg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fe1qCzKHq7K7Fe937YInbA5NBTslvUd51QjYH9WSNArgZPKBF/CvfNzkbyNl2B8VYK0+Yrxtb0qjo47RmM5arsiwBJolP3q2+1i7k93h4GeooNm+UAFTa/CnVS5OSNcrVG50BX/3Me11lALd5H72isApIyx/KmP9oYIak3ww8Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mbo32O58; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mbo32O58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTOCaW4Y3h7GkM23UI8XXM4yWHxLMjMNUu5DmIZHzQwyZkl2VgmDqMnR9+eaFSFrMaT8uIUYaz8n37GjQjgXmrMoI6hLLi0Me3HqzyeFxCmhoDcmn8KjXFnLpO01APXm93LeWjdINHIUzlMcMB7ivLk7NFlLmFFG4dnp+iD+zmKINUKBNIDC5iikZEk93bvazDwtgrxqSMj0DfiSYfn9rnCK1iYBQTVpF/wBHV5KYecaQYtks0PUJ7RZxn/k2Ks2SlyfKaw0YKYgvK5FIHZ0KLIUuT6Z1C9OqiFkslQbIi0Uwooq89SXxUEZ2tYZsy6JRIbeVYAb/h3jrgnCPlX4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MG8gfQ0q+6gDdFXodgopaSf3x7gV/9zl/XGbOycoXw=;
 b=TlJO71j8zw3p+xFablKcuCF71VjZsr/yRRFd9Hos6Ak1q2Iny+5d69GNVpCYWixfmWP3c4gKUvksd8fWHHV23WR1ZXibmGbMOKBWqCg0P7XCrAVZ2CuTWduT7OF309Dt2tEYGokBvjW1K66VxvGoNAQTg+6PAqLpIOfaZqlwiHg+yrcubG9zlRezdo5fQoWWLmvJyTjZ23DU1piMCPsPlPn1LklKOqkoVTDA/dmnAmDbbJuSdEJWdkeeHS7ybn2bxUYYmAWUbTg/TAXquv/GLDmhkUHZEKYgI3AJCw/YLzefMOLAPoq3swE5GAoVwjvBERcQfdQy60vuM93hORF0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MG8gfQ0q+6gDdFXodgopaSf3x7gV/9zl/XGbOycoXw=;
 b=mbo32O583V3+8DHkas+mAq/qCqf53K6EJVt3g7k1cPVghmDaDsuDsX+fOh/nLLRd/pd4gVDHG840K/oArjt0+2HmXRzELtF2zDm49gJWh/axX5D/6CCD7/vVb3nTR2oKSMYJJg1jzgwaI+YTYaWs1FTH5b3odkXIcuu3FTcJN1vOx6MRlU0dZp/GbUt8JhGIbguSVybtX02TvDu59AEqcdFOD0vtD6O7M0kM9qtDzDtmTVA69rvVgHhbARIUUKvn86HzuxbVwsMTlmAm16wfRd/l+dlam9i4UXP33t3iIM4XBx8DxWMS+fjTYqz6MCIQk8wavyMYKGiV/WG/xlI5vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:17 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 3/8] riscv: restore exact interrupt state in native_irq_restore()
Date: Fri, 10 Oct 2025 11:51:51 +0200
Message-ID: <20251010095156.3756799-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: adbd26a2-1001-4c20-e5a8-08de07e2b260
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4MJiUrAq6I6ySM3trN7OQR4VdaunRWN5J0iMXkDLERou7njcyAeGByToN1N?=
 =?us-ascii?Q?9/JznD6vRJHiZh/rHOCY0PwWoqxU36x0NzC3xYF+vOavE+buLZ1NP72TZn3h?=
 =?us-ascii?Q?Zjc99QIpDRRipOYfRmzoUut57pVbF8ZtdHushxStgjMWoI+mA6OU7DOfMfu4?=
 =?us-ascii?Q?OH8Be5KpzGhH/SC4jG2t7ANFQ58w5fD8nBApGDDN/EX4+AfLxOggJV+yh6VF?=
 =?us-ascii?Q?3bIfvnzLXDt9XS9aiBpHSIRB9d5Mty9ug173LSvbdgu0SCmxUMc06EE7VYnw?=
 =?us-ascii?Q?kdGm2ZT5PGfl9sM2fz6KESPmz/y57pDOMyl27DOrq/sgHWXErzcY7zz9QCai?=
 =?us-ascii?Q?SS/yG2bGzcisPCf8kdMS9K1kKu2CVSZOiVOXtk0H03V03avsVcIWQNJ0NLU9?=
 =?us-ascii?Q?omoAf/LNbK2gl4+oswLn4c15DYr+MUen617yTO7GiZBjhfjnl+vszm0//I1u?=
 =?us-ascii?Q?J2gII5S4fDGXP54/x8ui2ZeZIepOyKXWWS96yEvqQ0EYm3Uiyr1j7bSkH+LK?=
 =?us-ascii?Q?5nrrA0FZDkmDNgBYUNCXn7ZTb6N7Ehi2/8gr5FcKVagGcl9tAPF8ZSijh2Ki?=
 =?us-ascii?Q?4uDC6B0dDyTuCfbXCORyshTJvIXMDBroHAQDZEFgVJA9TsECsuwVUrnqi+bR?=
 =?us-ascii?Q?mpFtHWpu9e1eHdIn3FsXQSDdii1rEa3+7nnh2D5SvDFS4T11Wazh4FvBeTkW?=
 =?us-ascii?Q?Xj0v80dlN6g57VJPZQ1/MG+fHWd0ytHx4Ekrm/sA+S9B2UeGNlho0UkES44G?=
 =?us-ascii?Q?Dd2hbHZn9susppySPGtHLUDa5yCw0BUcv4gkem3qHB5jf7KJkY9fpA0ECZoJ?=
 =?us-ascii?Q?E5arYh9ujg/1yPNgsPLIEdCyNVp11KbeXzUmHs86JNBVRpRw2S03KykA4O5M?=
 =?us-ascii?Q?4Ydz1MBKFDkAECMxh5HLoJdg/epa0pls0Blng323aVCHvskFCgnQ+60AKdXc?=
 =?us-ascii?Q?oLNlP/EtINspQJuiMY4ezdXUsU0KPBM78Sythh+EnkkLq+KAp5njXtKuGQqO?=
 =?us-ascii?Q?7XzpDgvbM8ilA7w93igOmPpC9dp3JLaTjHMd1ACTpxw2DkWH19yzGgn6aOZY?=
 =?us-ascii?Q?bnahztwsqFbgl/LeX59BVuR6FNJ2PwZ47EEkOAn+0J0sido7eKLpCVvLDuCI?=
 =?us-ascii?Q?Fzn0tm/G2f+KcJFKwG9w2J6znWmJNxbq/lUrO4mru+yEL4qeOEB2WBP/YJZS?=
 =?us-ascii?Q?kJpyn9sJTV3XadAPbA5o+Lrs/HNN6AxFpER6HUaoLHWUk5Qp3mmvpOe8bOgt?=
 =?us-ascii?Q?cLXA+ExLvKuAsNFs1Iz2Gn+2qqUe2h+TWMYFzLsVy6ArrSWPyL/5EXGD8Z1R?=
 =?us-ascii?Q?O8AmkTumkJH2VYuCTEQOHxRmfGH0qTXvI6BKUiHAhIQHfu5GDaSQlznjqUUI?=
 =?us-ascii?Q?xFNDAcbaSOP2EMQ3cWqYYI5vZyWauhN1bTryo2WUoF8KvJlvhZ6rW+8SxPdr?=
 =?us-ascii?Q?aepSEkdc1Z7jLhKAeaA/CqK2nmc5DlOv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ThszxE3hxycaDUws1DFyi1Srb8j7jrOGSpE6HvLV9Z40QQRWH+je8phUt9l?=
 =?us-ascii?Q?9DsIXuJvj6eRB9cchmSuyD9vfCwQLcWVlC2mc9MNh+IhZF+dOjOZngvDojfU?=
 =?us-ascii?Q?mOTY+ORgzkcG4K1s7420fnyXd5/v9O8aNGdahDNpMmyQI+CS3Y8loJLmDO7C?=
 =?us-ascii?Q?Tz7Ea/rof7DELVVsVZ3clrQYmbFwoMwCESxGJzOiq/o2dzU+vnF5597F7bVm?=
 =?us-ascii?Q?5xej9MWInZhcE9Q4dd/+s6WItunRgZOUrxwor4C5Ve8K5oJRg0/727EJdd4v?=
 =?us-ascii?Q?4YlKqbsLW7l0Mks2olc5xgFpR8NZt+9tp6/iyo2GDurOguqecUR4PIpmMQQk?=
 =?us-ascii?Q?JLWdTjYiN99t6DpZwKp2bvi4oWQlePL2YiehvxsAS2ZR6qQh8w1CVOIXfsqu?=
 =?us-ascii?Q?z66oOgV8QAnh+r1UCoqr+1/sOOHhe//LLwEQxY7QfIzsXJNJvFGXF5MKIDbi?=
 =?us-ascii?Q?zJ99RNIuNLRRgxpbw7MUTYtIv5KjC63faQRW3H0ajXM506HjIBbE3cP4Hjcf?=
 =?us-ascii?Q?KQT/IeufxF/2PgMpfAvXCfYhdvu3LNIpIMOYqXmrrVm8e1H7VzkP9JInJfBe?=
 =?us-ascii?Q?qIRSxxE9zbEITKgzdreKL7yuy2/HyL0X4LdZ7B+F9LxCGWECUutzCRwrPkN4?=
 =?us-ascii?Q?nTQGTBh/afFGWOn15FreVr0AyDHQWYOL++nCEqk5KNcGVF+A/exJfUyoz+P4?=
 =?us-ascii?Q?zKZ0bd2SM0s0aXjgQBZzQaYQ2FN/amk4w+yNx8RFA9k/kh2Hs12Josyt56Yl?=
 =?us-ascii?Q?nqAvN3Aib4VI5m+2QFg8dKVn6p8dQbrAaEfEaej+qcsGDrP/v3vgHj5We+VA?=
 =?us-ascii?Q?JMArajV7zvvF8i8xBq1t1ogDuNUHJQaMI3NcbBJPvuZFxZaysXnREGkAbwf0?=
 =?us-ascii?Q?8CKlrAJvu2g7LY5FxjsqMGivg2bt0U6eMySpGXeLh5fWPr95g2ar1uLSKXB/?=
 =?us-ascii?Q?lQhQ+Ux3jzmfj8Gt+EcWZNesoyLnoosXQSR9zxIUsPssUqRmAgxy4l4rtkKh?=
 =?us-ascii?Q?BeNT2LZ5IQWrSbrKThyQ0lpaVm3gbKWdBvo/Oi2o7HftJjWEQPGzIQgBimrV?=
 =?us-ascii?Q?K3+kZU44StnuKBtJLAbMbe57U2wSezSrvUEamlMEqaBNY50ofHRNBOO3BwKh?=
 =?us-ascii?Q?lVuooTlhZREz5oaqaTYWg3piVjwYezlziGrYRF+hCqC5KiLbgwO6zciKrnhT?=
 =?us-ascii?Q?RncJo6ECuQv+GTewNCKdvIHPl3Oqu2CpGT1cZPBE1kWK2E1U+9Mzi26M5n25?=
 =?us-ascii?Q?7taHBWXjtRnsNe6a1I5ZcIv96QbySe/Z/QHUdi46t7WdBwHUiWbFEJ7qIrYB?=
 =?us-ascii?Q?Yb9l1QzAV20/hcIj7zDLlhFG2Mh9yNDxAT2rM5zUkYiHjgMu2+bYu3sFhukc?=
 =?us-ascii?Q?xxpY4X7KNR0orMMpLKybzfxcQPAheJ462GtJxIMaowxmKXP9odnhxrz0rK5G?=
 =?us-ascii?Q?ggWZI14kRUiU2sC81/n87edYUFuYxfIS39G9V/HdPB2KtUbxx37DE4f2SG41?=
 =?us-ascii?Q?xza9YF4cK0jslaatWQZSiLqKTx6q573DDN0Evh5p6TgcHO0p20cKeRML4AEz?=
 =?us-ascii?Q?HcsIgVPzxaoV5SVMrzQUvKyY1z2smDEio/J2xG9x1So67WNZ2/ZJBcwrNfeg?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbd26a2-1001-4c20-e5a8-08de07e2b260
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:17.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm4F5rrUvxPTtKgOokQPHtevChexTJN2x8Uba8wNfTZFLWVdAwWKmJFdQ2IjqIzHyJacenI9wXyU/dW9ZN5VE2rXgs+QO6K46gy5AdOUvqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

The previous implementation only set the SR_IE bit if it was set in the
saved flags but never cleared it when it was unset. This could leave
interrupts enabled unintentionally. Update the function to both set and
clear SR_IE as needed to fully restore the saved interrupt state.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irqflags.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index c7602250e981..c3087b74752b 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -48,7 +48,10 @@ static inline bool native_irqs_disabled(void)
 /* set interrupt enabled status */
 static inline void native_irq_restore(unsigned long flags)
 {
-	csr_set(CSR_STATUS, flags & SR_IE);
+	if (flags & SR_IE)
+		csr_set(CSR_STATUS, SR_IE);
+	else
+		csr_clear(CSR_STATUS, SR_IE);
 }
 
 #include <asm/irq_pipeline.h>
-- 
2.43.0

