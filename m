Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD53D952E
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092474; cv=fail; b=t+dhB7RFc0rhU9Ajtafb5aqGTi0MD6TwS8Iisp5jxX2bNOSHyAYeR4vOLvqWBqj8q+UHqxArILgbRxZWYI7pS0zCtOFJs+uAnU7iBD5UbGTFDNdH9z8wM/koZ3Zv1k5iipNETp2o+KKiGOXqdzQ4wH3J/jdyvIDE1DR+x8qA0IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092474; c=relaxed/simple;
	bh=zpqT5Wcp1y0pMXPDCyOhEe/1I8S0EXVeGtQcPxYKud4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NY5kusqf8Sww3yIUxzRjo0gy0YmSyn1/7WeIdF8HXIP1KGyOzYgGCf8V645nithgsiQf3HGpHEUI+cdlwlxZjiWI+mateuWBHnkKq5zGKofnNlihG5te41Mw379dFKBzg1EseWr4bnJTBeXgJ9kioAEVSZRXDgigXsfEnwQ5hxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EdloMgc8; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EdloMgc8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otLF5C24VWEwXwpvZe40HE9MSU3dBXNzspkaPR+vU8PaQBJJ1jI6XYosdmv8N0wzF5N0TOnFt8wS+mVjhf8yh0BivBf9yDS6cIs6pxPuqdS/f8sYQPhzPEnRpfyCD9oz175TtPGTFfgZG1KT62byxF3tAPY82fuuFxvJEVtdFg3OBcRHoijYfAlIdl7oORelG5axolCdz4OseFCYkPhfYqOe3DotXmezzEwydqto9N9rFxrh0JUvso0d9qhL+ful059xGS/T9vh+5nLvLHuvzm21FdZ3ppo5UO4ks8InM1EMBCB5oq+x0vIaeVR+542NpyYSGLUtvq48Q0AU3kypgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFyCvXhffDaNfp7nPHoo0FPJ44vGPjZjiu8NyYSxyFA=;
 b=g1buJMSPN34XGBmP0H2h2bDB1YEDzGwwXILBJaoZloqx9qki7AP3ED5ekg/+eDlb1h/9/w21UfyH4PI75HlTUWLWDNKMsgE/9X8kRQv7bRC0EiEb9eJAOevF/Ytp9SufkiyEAzwp+aflUt3Me+BYSld2OAa8LZeRoAZIGm/g/sC9Grcf0agFtC87ev/s/VxnzUlCJC6fQW145qCGdj9EMWvD46tAdvvaEPALviyf8JNqXrd2IGb9Hxn6DOvVx7JWN8s0UKpV7I8tdGlIsXSqwFuIb3OzjmDq8R8E3zJhltjqzvgGczAZU320jfbCoWOuY3bUN26+BvNuJ9wxXEBCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFyCvXhffDaNfp7nPHoo0FPJ44vGPjZjiu8NyYSxyFA=;
 b=EdloMgc8n8KawGRgicNF2MxP6wvN2GqOy1oQP9eVc21wwLZoXkRqgSqsTLir6EPrE2leYiMYOc8set3PoPW7sOWevXR7jK4vlOIQxIrpz+4tsWcsBm98EX18UABHP/bTNvE633KRIPsOjatD7yAhyce821otbO1j+LEy6J17MIAnwLVxu9VWlRhfMpZ3DDk9DSvPcnEjhZcqWM/lEam6mqGgbD0wXcwwoVQVFvqJGxcAU7OjRhyfxPLFkzb4fxRNqc8ehuCdCI8TOJk8VzYwISbJa6CkOrdMVaTtFahAXCoUJvKuOZcitoQO3LvJmjP7EZIlGYAwBEV9hZlsgve65A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:49 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:49 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 03/11] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Fri,  3 Jul 2026 17:27:30 +0200
Message-ID: <20260703152738.129122-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: db5ac5ca-9376-46d9-e355-08ded917a3a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	VAzInZQARfKd4cdXSH2TmtfaZd+pCUYLyrdjATN5WtQ9cK4bRARgqz/ndcVUZLw8T/Sozfc50qVYIOx6dF0Y9wJ7gO3YVlz/gZ0SOtsCA69ziKepMlXXx6Nz56WMrGdtKlLq+z8tfahet4XUv5oZYKkNivaa7Jaw63m0Hdq64vZY/IsUrxeHAboASCWp48mmWZvkNpMMMzMcCc5hUgrDYPyF4D8A6QsJ1wdsp48D3qXCnlRO2LPedP4k4w3hw3c92jnGEy5zrS/JnflbPIqtMPvoH9ITNVH4raOAGwQL/b5d8rSdvX/ECcjGnQBsbdjn+h9Wv4X1yZ/ELgR+noqBRWr2PgIPpD3H8Tf11vNk+/ktiNQljkGup9ZHGTscA5jtWcks+RLOPBzjHJq61kh4mUAhFsPhozZFIaBOP00rAjtafzg52Bbp1c43W24W5XvBP9Z6kyoPj/A9dCL4H4iqOZKmd1J7kFLdpTItd4U8MhJtDpV8seJgybLnDcI00G4PIvy/hAyKNtdOM5E4prB1eoWE6fyUVwkz9jYFlWP2cpJYJyJ36lmMgxwO2Rk/ikW4K3/4dqkb12u0vVQUD0/gRlj14LutieraIjS70TIuIkqfHL1MFpiqbQnkHsqocVTRFXTPDPF6Qu1WQkgq9teaE+3hPILjhot6sTPvbqNUYnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnrbHwRgcDTWVrbgdGj12S478drPAKEtR7xGutQeuqmULaXnJ7Vk5WxBCRYW?=
 =?us-ascii?Q?DQRabbClw5mJVL15SOYviZyTZM6N+PhKTDumihYZLVHvOMiO2k80GPSav5o3?=
 =?us-ascii?Q?Rues0FYEJPTaf6WR6ZMEsxVRKDltlbdgWJBL+Wy7XsvohQLEepwSN+tvEYfe?=
 =?us-ascii?Q?3dS6EKZZ60bFS4xkMcpO/TJO8S41Qc8Ryv813FSuDv2UDfydYvdC++jgsmbz?=
 =?us-ascii?Q?qz6K+5jm27UjO/jkvTNZiyA1W8vPRr5lY9Xadfw6Hb6g2/8jgLF9Rxx005gP?=
 =?us-ascii?Q?NL7Uk/r8zRn9BvJkcwPItMm3QEdolxyDZ8IWdr3RdWHlnOVs0sqvl7u+rS/f?=
 =?us-ascii?Q?kPz83sXn8a3hfOGG9CYQbWzA22wye6yny1zR7DWu2HNnuECtnpMwom4QpYzz?=
 =?us-ascii?Q?Y7exUXWfuK5nqzv9aTP2LNyJeM+UX+krCdOp5CMlXvkALcnEO8AhMOFQRdIw?=
 =?us-ascii?Q?2bZnhIPQPTjqsw1f0UmbSSvogjSF9A2iQFwPkKYLnZaDV1DFGvSkZ7wh0Lnh?=
 =?us-ascii?Q?G2ys2K7ptRplHIb7lTu1DBsZ3y+0HazhCu6XyUp2XoRGw+lo2QwqPJZjWtrP?=
 =?us-ascii?Q?/emqkLs2DVglagsCeNhwLxBA5ALeY6bggivKBAWYx8vcpGPO0y6C1r96fg1S?=
 =?us-ascii?Q?9uHLJTHE7CkPsOg0XNQnurLvl9kQ29elqdTmhcpOg+z3T5xNeLFKLecKGKOR?=
 =?us-ascii?Q?Wx1+fg1g8Yus31kIFyjthyvtu3jo2hSTxDrVOgAzx91DbMGlqLfLvdEOdfqM?=
 =?us-ascii?Q?GdfkD1VdKOfUJ3VlW10uX0TT3flj6vv6ELTBT3L6SDfs70KzvoCkoGKeHa/q?=
 =?us-ascii?Q?iyR79JpzjSjDb83kNVpPVi/NWrkeFuGdHmlD2nyxbgNwr+hfS8TH8MdQmeSn?=
 =?us-ascii?Q?RN8hXuQrORdYswBCEH/G7yf5qImYkzZZRb5NsO43vtebS+paNnZE0GX8YICZ?=
 =?us-ascii?Q?Pz9NpxwwKxUlbJ06XtduL8m0lrQsuU355cJDn4yRgQqpD0TXmjD9QyjKLUDH?=
 =?us-ascii?Q?hFl/cykO1cz3aKnc/z5wTPjD+uOA2c+neXSSXBLfsE49ZLtQ9e9e15ko9XDl?=
 =?us-ascii?Q?pe8qYAAc2bkWftOkukLokoGbsE8jk/Y/HVfdXei6lZDtp4jJ1sSa5q9ocEOA?=
 =?us-ascii?Q?bR22uR91smLITkaaB9/2yQ/n63dPZONlvlNAQNB0HHQwl2ijjAdYTNn2ZCPt?=
 =?us-ascii?Q?HCVfK+L8x05uNywjyGQYjGQjd2EEsSlA55ghaRZbAHPMJM2pW/124vloEE5v?=
 =?us-ascii?Q?/X6j/LiUND0iYwmOuJm0WLpRsVzNfw6EWCCctHpB9NVOWDRJjlOda7PvPrYX?=
 =?us-ascii?Q?WnXDzEZ1Dn7vwBU6vky1IM0whrXnwn7FA1gEOVY+iCgFW7GLk/TKpuqJd3ln?=
 =?us-ascii?Q?bAwqgHkPnIwZs87DM3CmKQXYy97PUZSgpBlNR9XsoUNKxMFX5VoBa8IhcgXh?=
 =?us-ascii?Q?InyNFqkV3rAQyJE1/75XjO/oFjt9JJQxWmQzPx0Srv/gn1IEbogIS1Wl2LUx?=
 =?us-ascii?Q?Z43vueg8eMN43dsr4bpX3gkXImiBKZom+BrmkJX01wkicTBITNn7yMHFRlb/?=
 =?us-ascii?Q?4rPiYlox3sbNJNz0YLIKXQbxhsdF+qO0cgyFAuAY3f24U7JFFl0vpXIXa8ao?=
 =?us-ascii?Q?WdqdcQ6HjTlsnCXN9zS8k1eTODDNhSU+jqzvIaqWLQiuVGYTItIR3KmXflNw?=
 =?us-ascii?Q?aa6yVyR7947c6FlrHvG7SM0hPyRi6P5C1AcYktyV+jF7LzrBXj9SJeE0zOk6?=
 =?us-ascii?Q?icB1IofHFQhoRTVYd0ARz5OKuTO3IEq6NqHGLP1Zxyo2QXNRiYIaEGrz15lZ?=
X-MS-Exchange-AntiSpam-MessageData-1: hAXwQX9j8c7aUC9HyYQ4zu4jeGVGWFlijAM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5ac5ca-9376-46d9-e355-08ded917a3a8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:48.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjucfxGkn/uNUrDHzKZRRy5RQlSomxeC9Lc7V3bz3vi7JWIwSvw3rA8L9Hd8wb2HrC4ux08OtOnY4h/3C8HP3vl+X8hCPvnTwFd/lgUWKZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

