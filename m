Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BEB37106A
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042639; cv=fail; b=iQc6xintd4RHVeuvSjT+Rb5IRigddoxugL05icy3Xy1dRFTKMQpXowO+2C37bamlzOmx8aei+b2E6RHBvzCSYesAHC4Xdoe9HzzkVlk8S70vb7HzScx5PfsQHGn+hnnf0uyZHaIEVKhyfhZ6AVaub2f7L43SVAUWGK3K4lahv9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042639; c=relaxed/simple;
	bh=t9/8BvTOxaxxtZun+CiCNcJeIOxh3E5guEfLGpcNiTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2gOlkyhiS+Iagb8JwlkB9GjxbjofxTw5PNwszvQkvxFzCfffmx/doTgeChfhOYm8zkpOtKQ3vEET2gHcxsO6EpV/RPD07rJ0iFaFeSVg+BKReVpr1cjbzelwOI2X1Mhz5UfCa4VUlaP5J3jsqy9L95+jpuWwCdXX2xQaSdeyy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YObsmB5i; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YObsmB5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDusj5Xol5PzrIYukiU9eVpvRkJn7nOsSZ0KsDpQePiIAUMPS71ZWHkitNUSPlRO6pYHdsSPnZPBMOwKucmiJx5scv+X9RoVG4Nr5IDSHNOEvDkM1LaL2pAvQYnz4s3GV80I3oWaySVw+3YCZb3oesGKg8DpAGyYwoAiH2cTTgylvuYrficN2yQjGLdI8r9W0QT03izr1lIw0Kf8jDEbW3m3+nCOKs+XPx76AzgO51fk6XeumBSEa6f9lOT/pktm3q4DZ1x4kHsOUXOHVgyXu5X9KB8c9nBXOSMfqiVOa1SXBJNjeWyADrEs/MNmUUMnxUKu4f7xl/qqvBbBOQorBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbpIl8ZTNc2LrKX+50gNgpcHxXL1cOwymo55vLqep/0=;
 b=kg4k52xaU5Ud5K8K/mxLlkuTcLlIG0NN5/gvc13Ox/npnoQrCa+TJpqlNaCZWUo7E3MmUj3NhrwCTGIIgSe2lXASO8VAoNJox6dLP/UZnH+Y+AoFh/Rc//xtBdbUTd/e9XwtnYEoRiO2U5ukiPQ41dROMEgLD5QGpdOzB36EEB3UOMO5MXcYGLGJ2DjbFoSB1Ll8NZAvdN8fmZrfH0/iZVxpIyYIm2tAyeVS861W1V1uqk1PUONq31J8iREctQ56+JXq7Nm1cY2YfDBZ7KtxzSLPm+TyHDKpkKe9ZnYw+PD8uaub7bgq9ASglXRK3WCdbMUiVVXsq/EG919bg0sH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbpIl8ZTNc2LrKX+50gNgpcHxXL1cOwymo55vLqep/0=;
 b=YObsmB5i963PLQRjwo6rk0IGNwVqw0/DAHExDGhcCxBVEAQxhS0yj3wcR8X75bGYiTkgFb0KkyxX05BDoPaCYGiTL6QgFYfMf7O21vnxpdoJ8BnMaBYC9VWbZXhhBdOUZE7DXkUEWj3NQ9Wzb2RmEDyj6Rw7v3LYnokfXcX75e6GPk+mqiHcgM4dzTle7i7/4g23NPCxEbkxRsdnEu8gy+IozkJCDxGY228KDNDhuYKdlaSkSoo2UaYxiPNZRrl8iyI08OBzq9UhJOX3WdpX4chteBFiAzHTn9NrA+EFeRnRCkMa3yikIb4UiKyVf7vCc31M1uvzXx+4i5yL4QlD2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:10 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:10 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 07/12] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Fri, 20 Mar 2026 22:36:52 +0100
Message-ID: <20260320213657.2210419-8-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1383e978-f558-4839-9403-08de86c8d7c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	fLR+wKLx2tX5lHlHSr70NeBfdHeSDYI6JWTFm5cJ2KwJlkqK61CfoQUqzuRBKnVP18AMi8yzgmNb6aH8Fu6ybd1/gYATdJoPhmgqEW6sYwAIm7/Inx5VncPc6lB/fFjo6IDtDSON/O9LIf+sLkaKtOmURxBf+aZAcbJJj+3pttpwVy3f0NQrHW3an7mprxgnhYKuAIMJBph935wcpVjiIsMLgWG/8QQ8RI9c8XJDbuC0L35EfTfFL5I2KwHYX851RNoIPgTrK8iJ9T6oLrYNNsiod8CWo7WxT2xBKK0nwV+B9D+iDVmGpbmJBWOzh8907xVB270rqooUytRCO/MOlSrkfqVanc8Q7TKauwklTjpDAZrq3lqGYKmodp5u/hovh2X9S7XvT/b95AjC5bkxBWpp28JbAxvr9Sy0l1QPgV/zxG/mQSoLHXt4yGyvmR+LQrLqJXisRkvp6HWAkYzkEFWHXVWGaYUj/80NeA9GWxmX9at/GnWgFJoy245K7I/7xYqAakYlsBdFYsq8D7RpYiUzDvI/26hz8umQ8cn+jYy/PsNu/0FMTiWc0oe2f3iQnfZ1fHhfq5cdPVdNe6iuIofL0FuDCtpl7ygMRZW8iThTk5zeq5WxlGMZYMQgZiPziCN9PZz3oY/NkGxsNKC2OjTxmkthazyZ39GoI57DHH+1/v8N6njPC1tcXRO2pTteNWlqlorGFwA4h/KcJ8M4VLHsZtsswb9OEyMJE+YyZ8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iftsA+99O0QtRbuetfXNTkVXqKiVTx2/flxI+zNhxKSqdmvz+TRGwPIOt4M?=
 =?us-ascii?Q?hOSkJRkEStEPg79CocJaCbQVp39vfrUHAZDCJ7hvUzonu2RN55xssavQxAmB?=
 =?us-ascii?Q?UDopzHkG9z81BIofwlve1bGqOr00fs5n+h6rCRZ5C07RJgXwcWfWP0yDbc5D?=
 =?us-ascii?Q?Svltv6+BJJVyiAHzR5ROu5e04aihuHMVresDzLFyIffMpWBCcy/jL5sDhvjI?=
 =?us-ascii?Q?XPHAYj+pErxZBolmW98bkZTMTlAGwiYivOPMJ3lsSJfaSNSshndPiTnj1Rua?=
 =?us-ascii?Q?HWDeE+mm1i2Z6GQft6IBvIUc5iAZMkstteFnUVFLaLha21I563oV7E9QTUu5?=
 =?us-ascii?Q?Z4n1tio0tA9xq8qSNI1HYDeLS87MrgO7j6YPc50oaqiaZUGDn/fmyCXD55on?=
 =?us-ascii?Q?9yvpmBFgXycX1K96YQdwYtDp3UrMkl0TpQKyrl+zEPLf8sbT8urCHeimyLYR?=
 =?us-ascii?Q?2i2kZBlgHbuhH9znZUlfOHj65S59/e+tzOZiOz0xKh+gCvGkoubJMiN2J80J?=
 =?us-ascii?Q?TnE2SI794EQgylQz6jkiXqbH/l7DLWljQ4mlJ9Z7zSaSJJsu2v5rZtPFiOBg?=
 =?us-ascii?Q?7LUoXQb+FHIbhDX+epJJNO13lKN8Y+dQW2OJrF7OoUYjF1RtwHdSw6MsKlyf?=
 =?us-ascii?Q?44BCKL0Fs33dpLUSW3w+gs50htBZhC7/KFGnQIWpHQpm4Q+W+Oc95UtKk07a?=
 =?us-ascii?Q?+yoGIU3MDOWqKOKdDGbJU5FAFuCQCUHoZ1RBbBgFJ8R7/PXmRyKEot42bk3O?=
 =?us-ascii?Q?AwPYOGJOsfws/H5OyKiiXM3BvDh5t92OgR34w5nrO0197EHI+51Wd4kU9ki/?=
 =?us-ascii?Q?+yroK3oQy4e0v35EIzjVhD44ulS3E0SGRgxCvKaVo/KWSMwsRomnbO6FA3aQ?=
 =?us-ascii?Q?MJ9b25qafjSB64wZaO9LnJlv3LT2U4YJtfNx6Pvo2VkoRTGgzC24caUzmnT8?=
 =?us-ascii?Q?XFKRWsKteIwY+eCo0Zgix/Qlq6QFEHSy3VqNosxCdlj+8H5hNd+KdtdpRuUl?=
 =?us-ascii?Q?/1YZ2PwHUW2KLYJFAHBBHlBR4w4AVaCxOMMZE6A/n/9BLkh2B+JCGq6YNzn5?=
 =?us-ascii?Q?Tq6ZbrNu/+SUjS/0UFKLxN+7yk2QlBRTw9cWTvsUuFIcYype7m04FifDgNym?=
 =?us-ascii?Q?pnJtvgiM7bMgbMXbH62XsssOqjqTpqj/kuyT1N81Xnkx8kV6vMcVX4t6GB76?=
 =?us-ascii?Q?MwMBCBl3EC4yXTShwfq09ajTMIIkwlh0bUhnaIjSCikW3sfAyhilzm1PTZm4?=
 =?us-ascii?Q?HjOFR3lqqxmuUeXTHP1NpgW4CcUR1Rcs9u2AfJUfZL8XATZb7xwyfNdKSQiy?=
 =?us-ascii?Q?sb77dAdnoAbfz724y/gB/a/6gorCY7ftpU6nAPQhf0nJaJ4GaUdPdWx2oyO4?=
 =?us-ascii?Q?8cPxRORRO9roqUAskdbBJC31vzphVA85LMlRta8x2xGHR4aY96HO5z2Odvv/?=
 =?us-ascii?Q?lwLdLO744nA/UTwyMhAcKcSVFtAfmhvSV+fHyWp5r+aOiUNoakL5B2wIqC4Y?=
 =?us-ascii?Q?8xOWotF9Xd2lMHo4DR9Vy3hY+GpRbRPVsO4YL1pQ270+3deiPyx3VxKzWdpQ?=
 =?us-ascii?Q?r0YHSsPK5MfhRVaNe5jG4viyHzgw9GGsk0yfFssTGXtW0sD26KrAPPDLtxZ0?=
 =?us-ascii?Q?ib30wVEYnwNZ8ct2VTPi2VPKyQZjhVizEjWTraFp37YRtQwI5kIbpVXvK/Ca?=
 =?us-ascii?Q?VzlR14xmg73rYEc4RwC1CX2pHSHuiDgYmfpNZRLmW33pn1defGkxqTy/fB3o?=
 =?us-ascii?Q?BcT5oe1l/nqco2G22cRMvZV8mBvaNa8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1383e978-f558-4839-9403-08de86c8d7c6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:10.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsMYOniyusksuy9mmexCkpXMUD4mcnVaZRArrU9bnqXQ/W2IDFr5tf5LRpiQUSTcDA+m9L4ymhAFE5E9TamzKUS3E44qGCCveXV4kxX+4mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
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

