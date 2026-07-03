Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C0417368
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092480; cv=fail; b=az4SS5U6oqy3xIslbAjPqfwoDK17BF4qLjJpoY7y319mrMZMC0RtXjiGmNLLs0p0Di1uz8EFraAYcmNzTk3lNKuxybzrUqKklCC4zqi1oqLTGJezzb2mAxnC4HvbcsdvZn51KjaIwDkIBpUpPmHr5yXjno6qRWEog/6QGEt/Hjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092480; c=relaxed/simple;
	bh=6mQOCTGkqYoblTG2viJ2VgniBCF7SP1KX+1ZS08p8RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLvAhRYXdxQQP803XT0b/FdK7kcfvwhYli8gR6dgrbwc1cjx9WRdxDWnW4Yf7i6H0oLZHWwGl5dS+mhZtkN0GD4k922tJEPPJFa3VorchTBzpKmfC03rCjM3WMo4ixWNHGHtjlBN7Ukhr3rQuraUVEkaax5gHS2bdHxRUxtK0Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=W4Uqte/k; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="W4Uqte/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8ZF4pYfwGrfo5Gne8HURjBW/XyGI7SC3W85Rv75ptvp9S3XfmZQkuB0752dvjeb/tZ6sySMrCLeael1ir0Yy0SqbGWG9uvRvCujD6xILOAeW+PSXD7pGLlZqFjt++E8PqG39eseHA2W8YxGRIb0UMJg1sk7gL79sH2e/2m4wxkb5Vrkg7jMTwXu9DT7C20RBRATav10BQh2DDIDeAqsACjwRsNry0VrdvU/7YF0Y6TXClk/mbw/gr8jszlc87wZN5E3TXBe9Lobtqx1xWGCk5R3GifuVUcc7hV0orZ7w37XQYjzwJMRW1ONDkziJfkcf5jpurDW6+JRJCAjzDrmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOTpuAIdFjyxxaWQGWatRjCPf9GF+srUHag5qrGm7hE=;
 b=irzjhHqoc6z1BYBQGdjduHj0xsnwo4IKdHzR1aDmEXDQS4TVpwGHcW4Bk+SigfbArE2X+h6fAFfxUebm2rOgB7tMZltem425tJ7+NvdTh/91r7v+wbkxhM1neR1KToV2vNLyn36QPydcVOWh2vQOZDwM+Jr5slhLF4KwB02e0T0FwwG3I/4NMOwH3GRXEgamPpEAyR8ZcmZ5CwHHD8e/Q3eZdTm0xnB2bKXY6QVEdspO2BZmGLymrO3quGw1WPKPuz3Ev7i//DEHR1ATPOVj/QTJ2m4DX48OQL4bsgvMEBNuxsMgTr8ZGZV4769iJtRgtArJ6h4OTAZCjxmzz9RvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOTpuAIdFjyxxaWQGWatRjCPf9GF+srUHag5qrGm7hE=;
 b=W4Uqte/kXoQDMvGXCtrVB/czjx/zQ4YZ63EJY0ampdg2TlWqPhtp5ApKzyThT82tj57hFWKVOpHbOKvnIhVrM6nqQWm29N4W5Fkv9WyuUz1cDrM8l5h65r24bUmXozopzgikhO/r5XLJjLa8+lx92kYLWEDo9oerGodtVUVJTU6aGXeC709Y50lnnAJaWs9vSR8A3UvaC/hfWxhxrCUHfyNH0qdUYOFcNDb61F8YLGX5GnPL1c0aOoG2pEvIZ+6i2/Mm5j02SKdRw9zq0QB3P8nANcgl06tacEHPWe5aXOyMLU0BM7HBE/89UsSYSa4Tw0ZfbVGRkSzrgK+qCU7P5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:52 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:52 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 06/11] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Fri,  3 Jul 2026 17:27:33 +0200
Message-ID: <20260703152738.129122-7-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ab035b4-fe63-4681-72bc-08ded917a4db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MMd6SxDahanpxbcKsyigEj41TjXZUrzCQx2FZIointQ+jG01g9RN+OGbncAN+FlI2zJ8H5dO2W/y+UMx+ubJ65CE+d3YKJTCRO0JPZVSQCVXraEE011Kwvag+C711X4xYSZ0saZSmqSeXv4hWmtKha8kqLcnFNe+/zS5iGpJZr7lvTGAiA1eo27wwfoWB1NlHHrYp+7c+zxwyZaxURDaBrSOHuUPxO9P3oHgQY3vIsLPJM6xnv1b7Ui0egiL7L3DrsiFZKezZF+XW1lfXET/Rc24A3RH5iE0VGV83oOt3LAUF0qIB83jiA6UpZ7TLoRP1ihZxWfvwoDYP0KW9UW7WdxcX2QYjLImJK6ODV5r/G3yuM/Y8kUWRDT+KQU34MDclYOdEp2IcluxuwRo6OqZvSE0lqLydBAUepWIIGkjG8AsP36BZJ5kMDnjoYILQaJOeJKD/RW1iqhtHXKCi6VGgMzjbDjwJ1vVuquq5qDie2fwD0LjCn+Hf+XUiZM3rUFd73L1zGTbX+JpJF8MWNf+u4SpbicgGByiDQbnwrQQXk+d4SGWKbb0GQ+pVfHyND7xlCZdABOCFUVzlw7LGvh4r4mx4urTotVFFY3P/BzwIiWV2kBIBvL01KioMi0iFrLJeqehiLQcgmy20HSQ1X1rxxO0vTyNDarmsYMMwR6TsbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RqT3/S4PYek6YJ+5WMMcaAI2ZDB5RYGaR4mRvp6cia652LoZE5o8aKutPHrs?=
 =?us-ascii?Q?D3JotuVnWBFfjPtNGw7tv7HgrdtsJJcFt6i7fg1b96IcZ35CeP7Ca/mM4H7Z?=
 =?us-ascii?Q?gjMV31jYsMHQWsD014QFz4gzVV05P79ZAi+RraYjwsy8aIcdHkp4M+MqQalS?=
 =?us-ascii?Q?yz2Igy5dvZfjCLZMFf4kZGZR5A8VmBYD02ZzPwl7KjIIgzyYuqlOMthmqBIx?=
 =?us-ascii?Q?qWAg9aaISJ65WWlAE+fVif1Y4gTYHk9ohalw+oKi0rqrS3Ztp1yEevdgjA+n?=
 =?us-ascii?Q?2qRWVoT3KoobP3T3gQOByxkXMI7z1vwg7EmFxaIJZPaIUZ2vkfEsV+tyGGFk?=
 =?us-ascii?Q?jCy+Ldh0fa49/qH3YFpkodS+22NaAoodkj8WQX5w28bKGO5zOcIgU7socFhu?=
 =?us-ascii?Q?QBT4AtEMTg/SuBajeaWHoF0TRtiQF2zx0BQNrKoumt1qql43rY1K5BeiRzQU?=
 =?us-ascii?Q?20ljBfp0SHLFtQD0gmXhj+/PMQkS1v1PN15PMRGs2dz6VclNbX8Z8io3IGZ3?=
 =?us-ascii?Q?fPiBi9ZNdt+ecw2fUterKeLDApE4XVz0VztIrcEg5NejTNt6Sn6bKyYJk/f2?=
 =?us-ascii?Q?lO4GqSl1hoFp2U3WNfJ2tFgXyxUD6vFKVAEjJaMBKhSV741WSxgs8q0G09RP?=
 =?us-ascii?Q?sll0v6OU0Zcve+aX7XA1hYUYVayRUhdsOleDRdy57c5+KUy5hCXWS2JopEZ/?=
 =?us-ascii?Q?LJRT7f/6qCtGCKdtiZJRyL0JYbgBABkI/xq/v1EvssMWRI534YJwK8UBbnTh?=
 =?us-ascii?Q?sgGl0yL9dD3rZgfEex/loeLfAGq3cVNzqBeNjzIAnrIiy55h2XsTgOCHvYeT?=
 =?us-ascii?Q?J9ug1rPD1a0lJe+A5Vkw2MTw4E7x97n6hNSadORu6tyR7XqKeWoFXZEQBxAS?=
 =?us-ascii?Q?5pwav1Ko1TUQG9zwf4eFwDtAGSRoQRSCOvlrtXYELmY80Mcgqhgm+lVW5bNy?=
 =?us-ascii?Q?g9V7PgWpjdQQ29HkyL+WGk5aC4opS+fi7zhT4jpaxXJ5UU17+9dL/JAMvnvT?=
 =?us-ascii?Q?JpjfrCjMtgKRZ42Z/bTOEcK+JW8uSrdYRkVaHA1UZABdjOPxMPCHr0ygSxdA?=
 =?us-ascii?Q?4oquPqPaSE34kJycpBgyZcbYSpIe/+V2lGobzpugTRbC4JLts0OxC6O70LnR?=
 =?us-ascii?Q?2QOWk33Cqn06PVGsylRIjLUjrHT8V/QuhuEN9tgroZXP1W2JGjxUkO+EiOYV?=
 =?us-ascii?Q?mmOE11eipsFRUSu2UWDGO2mG1MzoPHX0JKB57zopH27QvSCtFo4vVv7aBgPa?=
 =?us-ascii?Q?sAriWACv+FkO2sMYPapxvw+G0cdu1ta38HTwEHycxdMSGp+4li08+FfKp6Fi?=
 =?us-ascii?Q?la4Aq3qtD64mbmKyhsbfP0oGWRMzOIsXi6gMJzRl73PPuP4uoHUFEMyuXHF+?=
 =?us-ascii?Q?DwzJDwEmmsRMupMUReTtIqFRK4kdIwcPeRDBAlRK+EOAMZpu68DSt4kn7Yqt?=
 =?us-ascii?Q?ipJPv+Ny6tzze29YF1lyTrHQYjsVJo6gh3pawCntovYG9AJPLp5ipa3EZA/l?=
 =?us-ascii?Q?MKKGvcPzGQeFiq+2UK6VzoA6Ys3KN2yZkNY83kEqkz7tU41LJKf5hbmMiCzA?=
 =?us-ascii?Q?3+CF2yRx5OMAvB/nNQcXnoIOoBKjv700bpjSPFPfoKymF/uVTRQvEEIvyErM?=
 =?us-ascii?Q?d1LAygHpvEqo+bVCaK8JLrlI63/Z40SLi6ThvrjhIZhY9iP/J3VBwwhcOaLv?=
 =?us-ascii?Q?/iW3OzSPM5MiZQVBi/XGxqch9hbzBjIUFGdIHTiXk3vM7icoMU9ODw2PYdd+?=
 =?us-ascii?Q?RRlk+dn8Mqd6KENxdmiDjV9c1tGB1e0pT4Svzyanws/ko2c4NKFdNrsh9MOJ?=
X-MS-Exchange-AntiSpam-MessageData-1: A4vRObJJmfCA41xY4zYNhIO/585Xh2FLo0I=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab035b4-fe63-4681-72bc-08ded917a4db
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:50.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5AxH7ftqvgnTx+X6Yiq3H66BhyYzDbaPnxOudIr9L0TJlHmyI9LSPogkD/u0IlB3NIfWwgAP/d4sqX+9RC7g/PAC2c7DoL08QmEmpcBCik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 84418dbd5a27..855ce8dde27a 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -111,6 +111,7 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip andes_intc_chip = {
@@ -118,6 +119,7 @@ static struct irq_chip andes_intc_chip = {
 	.irq_mask	= andes_intc_irq_mask,
 	.irq_unmask	= andes_intc_irq_unmask,
 	.irq_eoi	= riscv_intc_irq_eoi,
+	.flags		= IRQCHIP_PIPELINE_SAFE,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
-- 
2.43.0

