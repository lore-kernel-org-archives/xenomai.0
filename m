Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E1308F23
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206800; cv=fail; b=a6a8Z6Wkzrm/Ei98RUcADdrdg0EV4lsft1qJ4pvV6BRFgqTy+h3YAm8MTgo0qsm22ivvIXZdPPDnTrh6EhkhMK5YxT0ZRLB5NKX4vxoACRJxUWnEGsPg6rlrUVVBESXAn9oRLvRQiFPFkSjnMLK8poULm3dEijUlvYq9UUg2WYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206800; c=relaxed/simple;
	bh=weahQ+dooGdePMBjJDIaPKlQADd7k8uivoV9dNNWpQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lj3gMF+6mVsmrG8RaHRr9kNW5AGwyNWtk5Dx0OceXDr9QYzuwHTIdjpKsjOBVwosWx+ad6Cs8cDd0sZXhgDszRa3j9NihSUsgUUmsbu+2hHafW5ss1JDCA8wLwiJcn1r3g5TjsTIWjM0YvvlaqYW0NKd5yKQgA/kotibQc19m/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KnE1NO0x; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KnE1NO0x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQLlDdwIY3+3mrUOG1dqkg5smEU/hiVEj+UsjbS1GE5hQsOpC85+GFVTOOH1W6EnB5RRmbtI5v9CCP8UXaR8A3Ixi3qO4tnEkuVvmLpUjsTfu5BCXP8O6/AP8MPiCCz5qiPzNL9dQPc+PHsb2N6G07C7k4+nQ36zf75oz8erlY1DApCC8d/zkrPTYYv0o4e5OgKnqzJzE24XR6R6vWeVKkM4BxDHfhZzEdWkWOi961c6ejBsPavZnaS5KjFrAw2gf3/E3Y7+P4rWGWpOsjX5cHAGssbkgrE2Ky1GQGTQwHGlxRm8CxSPiF0Y3HVGHusyXA1B5HyKZsdPi6edFctyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk5jwQbpCv07MQjc4G2pNa5PAnE+iUP9wlVIv42DINw=;
 b=J/tsJ7pcXo2YQMMdXvfKOw8CN8zWpZNoV0ua69bQBjnPYpOqA8QDfXlXRqf0gRgbiXZgvQjkwD4PRgDvz7gTw1opwIj7b8Ni0jYUBP0hfsG5Ac1PCcauoJXarOUeqyyIqhcKOOh8HERosbAv0CZ0+7wQqPMItW+OKKfoYmOj/gK9PpWjr3U+eoj3W6m9zWV5WiIubHHt58sVPZGqN6nxxt/kiLekVk99e/eOXAXO1IyOqJy5UI5YORBQ++l0A9GtlE0vsPUb7V4b650+6Zega2iFJwib5znF3K9k/8zhgSwsTYXC/O6upeuVGAKIi8fpaOyWQnD+6GgRyizjoqsFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk5jwQbpCv07MQjc4G2pNa5PAnE+iUP9wlVIv42DINw=;
 b=KnE1NO0xdnrIKND8GE90QmA8dHXHavj1vgJd4QevPOVUPCcdbSJGznDjhB/9AjBuUXLF5B4bQSPPEdA/lKvxtiUybhKt/Qh5qAbN6AQciJNsbnoGYIEWLjhjUx26ClTOXbJiIYAi0HXwBNRtTJH77AZZlNm1in0a1UzYKdi2czJzWRRk7Ul4Wh5gJT9VaW+vipDRu1BVAtawuarQUwWH40O/WXXcd4aOXjVnnJoykwgRqUhKg1LYEIj0b0fy0gQz32pZkal2fOgfOJh4+Jh1a6jQJI3bKL7YvECCIkQHbkdwYCQdojx89zKOwNbOVomNntJMod2nBhlkI2wG4tipZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 03/11] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Sun, 31 May 2026 07:52:56 +0200
Message-ID: <20260531055304.2890455-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c3329d-a8dc-4065-e7aa-08debed8e752
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	FDs4VsXamyZgb6DtlagG4KkINeVWAdhE+MZn6IXV7RCxVcllkwVl8G+Rc0UbZk9/RZCG8m5JH10ZaQK2OygKW1hzVxBTk7KmJ2n3iAVKyMkHZQUZNPHyAAzVvtl7meoO170407hNWfBH2CzD1Zejr1eR7/I33GDNDfq5b1zXsFRybHS0zQpECtKt+h4kr2gKq8fYpQjKnA2AVmDn9ghoUxNN6rdwROkeAyBL2RK7ZbAeCVSWIKhjVdi+cSges7/hWuQr1vMsuCpVIWtSz4tVxsilK/yCAXZaVdxJCiY6UN5VqL6uE2BL/2nJ7CCtSw2bN/9YPwU1Cl96NAz3yaRGvvSOfQw3382v70EkzuFt4OzVFUEviPvUHxOOuQ9t7mtuEf/bi3C6fos+fGZoWZC5N5Kg4YZQgJh66tveQEtUi/yfS3YhtEb7KlTYc5pXQqFj4kRQ9IzXGTvXhFDgZuGR2OLeCidMsBHE/L3Oxiy35lkoXGFa7rLN/k0BQmTULU+nbJZD+EmMPipVIxlfpjrbNB31qp4nwFn0oneXTy87bpDbQ12cVWRLfHsUiluRjE+Z4WxiVva57nKSIQqKDN4LZ7bB4fSGC7PHaG3n+1R2SQEK3cPV/6Wu2TgILpSjcqCn3lzYH4Jpi9DWmVfd1tLBzNbW8Gh46xCs/xDp7DauBEnz+ZkRiiXv3csCBzSY83oT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?swghValXyOpKgDl5F09YaFgFakN7y2xcbZnABME7SnFKGsFn88wPWavRI/gP?=
 =?us-ascii?Q?eYpsfyIUm5TZNHVy6Cp/vRNACwCL53SmIYCTfBGzquOUEBZrjU69haxOXzer?=
 =?us-ascii?Q?GTfLSEPP3yrw+ntH7x7Ki99yPhGQYEy03H3ppLJwHrj+CZVM1eexwHdUapse?=
 =?us-ascii?Q?v3W415xfz1OAeUTX5vsYg9UnOcM0Wn4E6xVenBfcWIdBXl5zsaUe0eJS9UTU?=
 =?us-ascii?Q?cswW04fz4qMfE2TmFIqjw1xQuxd5nJKiA3eA94+izfMvMJWODsMqYbAit0/z?=
 =?us-ascii?Q?qZePNQtSX86Naoak2jUKTUlK/YeREghXc1sfD7H/KLgnL+nL+caPWbUX6l9s?=
 =?us-ascii?Q?VJFbBRSJyVgNuvbuY+g/qFJpAckfdxc0SbBPXwZuyGjjG9/lOiLEXUeLYyAg?=
 =?us-ascii?Q?g+fjOPFH/0KZ32RO/O5IPvCWVOUzNY2psD3sgro2aoeQnU+X8x0/oTjhdUsH?=
 =?us-ascii?Q?zgDe0bhKFKsv1PYCCG1JbKfE7WFK+V+pVbkuBM3qQk+cdU3eBn11AvK3CNGF?=
 =?us-ascii?Q?1yoWq0u6TX51LhlAeXA11EKq0he/CxNi5QsNMJi1Kn/P5Kl6zrMb7zeFVQhy?=
 =?us-ascii?Q?pqxrFQzJHjCbstXLixdaQEBOHSwx2phUa7UwQookSFC/TdB+vgORp1c7Xrpv?=
 =?us-ascii?Q?7Y6lyTTRgdRHl+bpIUD6oB1DfIRS+zHnzWee/BnUawc7C/HEnkKWSSMHmLtx?=
 =?us-ascii?Q?yfUzhuLZmLII3vQEN3CJRWLCh5uo9Eo64EeNBCMV+2GebVSa8DwWEUwDHI7j?=
 =?us-ascii?Q?bwE+fzR9YzY4LdyYZnKE5k4ayhgFtG9gjh0NSclcqkWOupXopNUQT2fKauSy?=
 =?us-ascii?Q?BKNam7O+OVv3vlZ9xBoJLKPWTCTN2nkBxVeBlao400gCYDCTcERHVbokMnz+?=
 =?us-ascii?Q?7/SyAy3j6BbiLA3NobD7Va95QEKLkYSOdNz1vrTRURBRyyd1p/Z1MXS37o3X?=
 =?us-ascii?Q?ujNe13gIfGj+ZWZ28KNcEqvMwzJehMTSzQr6ckbZHEgONUkHujbR2gHNymZJ?=
 =?us-ascii?Q?SXHuGKjAjurT0TMxyLiiCJ0McAHQZ629TfYjVyF6hzXmNC9LoFzh7CRvvWDY?=
 =?us-ascii?Q?85z544fyWE3Er0HhaNxrJgHzJa6fbgLFs7AUh11n8/b9Oms+98bEKm+NoV+q?=
 =?us-ascii?Q?TnZVonaROiltJbqG5fUyi0myiHb6tto6wllLu3sknnC9QoQcuOvyYRfnkvAO?=
 =?us-ascii?Q?10ERRu2tRvLFXb/N7DkY1qKjzYVqN8JGfb64JcDei+Jfk5Z95DTSIxqwzKAM?=
 =?us-ascii?Q?bY/+ecopo/IOYWPegDlLx13UPHBwlESY3o34Da5kpmJj4QmeWtB5muCMXrvw?=
 =?us-ascii?Q?grIs1Y0q3BSnu7vMzeIeeSTvoJF9GvtFWojsIARC1uHx0DsdAbvBYgkF2g9d?=
 =?us-ascii?Q?lYxxgNZrIvcBsIlyYPzHp05cjSfS4D8woW8/96xO8VRi3VC4dFLFXUoOMKRS?=
 =?us-ascii?Q?PbaUKbU3iqriGemDNGw/Zbn+4nswHIYuKncL486xV3r1VtAUF6Qtqcj+B2VS?=
 =?us-ascii?Q?lg+VzZb+igKiwaL5VwwxH4Jir6r/fNLRB0sdmzUW4aZa7VH2fCHEg0NmNczC?=
 =?us-ascii?Q?JRV75cBIHlUJBURfKcGdZAobERK8zPn4pZ0Q9PoJyzr9Rzaf7kZXieaay+HP?=
 =?us-ascii?Q?BXVS4+8FZAp/PXi/Uan/5+vJxNHhcofUQJzC6s2iWevzwk4n2Siq+nWXAoAb?=
 =?us-ascii?Q?hZokilPOPMnlQYof8wIEUlhIHHiIBibjtQhjs+4cld+NM2j93nKxv+s59eM/?=
 =?us-ascii?Q?oa3rchoUoWTlRz2GLjiDB4Zw9YFwbcY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c3329d-a8dc-4065-e7aa-08debed8e752
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:13.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4G9Yy9osE06+Yrebjwp4P5fmIVoILpeN6NnxlQIhIkpfIoNlI1hSUbk7OhmHsjZeUf64oocWrJwXC3yDvnjaXkRRLl1DGddUsyvqM7pnh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

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

