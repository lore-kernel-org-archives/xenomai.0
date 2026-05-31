Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549B313543
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206802; cv=fail; b=mn7fqC29Z3hvU9yM8naD5X/rpbyhZLoXCG4h4mMFPCRi18oGt9RcDFiKeqI47HuAr7Iod3F4PLDfNEn2TA068AOg6PXqsWSyHNumiIHfDUmyizSXLaT2pidH4dO2K30L/JmNqUw2U/hIp3C6iCmx83IBNVjV3fjH0P8FfoVrpow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206802; c=relaxed/simple;
	bh=Iy1nrS7eTil3/oXfRjKWY9VqL4hHynOOdXeCqFnlq7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQ6/iIQ3MdO4CFtkNo3+cqmGG2WJy8dLbrc1n43NUibxk21N97j4vfT9lfcgyiIlQif1LVI+3oFzeaihT6uxs0iD8JSpQiGApYUpEvJMQoTGSisV7XPDqJt5NNTCIoGMS4EWEJaRonQrK+3am3w6a0KczBtG1Ebj1CEPHP71ryU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Unh+Bgy9; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Unh+Bgy9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjk5dGxLw4Kv+rFyMd0DSUEjg1LgNW9+CNWCXnv76oVfeFglOuHmNVtdHQsqqi1GHr7FNsvHZXo51ZrR00xkpvJsDf2lKsEF0xJd9vx/LsEY4VOFcZIR8PZOn/0K9aPYhRYjlNi/iQPYQDRSE7WUkjB1VYEkXp1fzn6t4YYU/XiA0Dts3vnwyiGX4tLO7cw3OOzeyRAi3GPMrZWs8+Jiq4RsMfQX30pTzA3AUmxLollQsf6GI10R4n6V9jcNlzBNk2WAa4dNnopigaomXWVNNnS3Y+Ilu0DZPndcO5Bqxy6NVSUNeOKdqGEl2XgqPWFlyfL38/9VweLnD7meJ9lmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrJvV0msrN9WXt0uB1adKK1oFxVQ73oPXYPTa7aT/Hc=;
 b=lwHaPDSDkrASvttUAEv2oOGUs7p9GiI+uqY/l55j9BV/o59AsA48snatdeBLcmmmm7TxWwJXDMZKSXMNlkLb6FNcKA/od7CA4hjkbG2a9UyOr38laftn0PA5LaOMQjUkQ/a2BaCTqcilr0h89YJ25WfNcO17lcXUqJ/qfy4Mu38dv80di1sO+hYpHcyRXM9JSxcBbey4f295bOzQc2Vy6K4N6TZvCmc5RXXMV9zFNqfZWwS+q+s/xtiDN4qZoMIfP5Ja19kX5Y7TlVj35LqAPhF8B9YVPEip0BH/QAtFCfhHcWkLGIsMFOkaMP88142YUtFc7GPlV5W0HpPN9Simnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrJvV0msrN9WXt0uB1adKK1oFxVQ73oPXYPTa7aT/Hc=;
 b=Unh+Bgy9l+Z2pitp0pBzZODT0+QtZN0Tqy90CC7z9rGFnBVtVLQ+iVgOlheWN9UqBTKGv09PKv/GbRpgpgyGtYoEPc/2Kj8k7xI11x7CuJR5i7nGRN4HtbUuoTjwcYKprBbYAnrWzIbe+gVXalx6Di9dapqKmlApv+xJqH5DVow5Jf49LSeR7nBtm51ff+nWTlOTNVy4g5o30UYAFaXtLrwpufcngO6rLh6eZySROD0FsfsRecl/nNr1NCGwBrn5BYZew7NEJMRGjJe1SwRTCx0ZZOohpXZciwAdOjIN3elWn215Ro/2oLYlSq+4K0rMeb7p8o5DOzLpEPABzsMdjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 05/11] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Sun, 31 May 2026 07:52:58 +0200
Message-ID: <20260531055304.2890455-6-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ad28092-db17-4d0d-9561-08debed8e7e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|6133799003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	hE4AJSC1tzHEYcEsqxByAKVW1w2eC5WuVy6PL++Soua6LNoq7mGCfwBeomhuExulq/HOfQWwLmjyCSzdWN4pzsO1tWQNM51CTf0+KZlureNogwXmbjRiKUv7q7nGL/VGkw/M1/e/9S88+u74ryszT0Nu4CZXqjXRYbqQxUtrE8KSqItqANUEQS2PoaZq4aZt1WPAQwcoW64afyLHGbyDQ1wdcLiI474R9AlrTBY7+Or8OMz2D0nT0kkFq9qjggmB3ZgM3sLb8FBQF/SMtsm00fmEVHyL1nIaIY+gwKsLGpi46tFIcbmihY9oqPYiSAceDxClp1Jwc6qTqDR91/iWYRqOGTD++xhqDCU4gJBMrSJBe4MG3LLC895zTetnhs+JiVYHSy7bEPfDVGm9dJGV2sTFJTjDvaZcumGkqtnwYjqZI8+2VJnZk1Cnto9OZe22mMt5M87CqOnnepIVzg9yRbXwy3+XVYjRNuUCxEX91/lbv/Dw8kqh9WB9D5x0qAbSDsWWaI6kIFsTRW4mSVIP1ryphYSPNMe1EUwL/uwbfc8/l68FElScMXEIJznloMnIpiLX8ITIGZR8suVJ0mOSRVaUy442YNZ5xhdXQZab+4Ff5RHvnmtiBtWkQD+/+03btKu4eH84vV5qkEHzdRumlh43yqpa+TPyzH9ySmCtz1TaxfBkLUA8Ib/PwU6v/I5E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3u5ycflmw34iz5fsKxIB1Da/DYvYf0a6G1oVfEKaqhMmYlMiRn0h392Px8p?=
 =?us-ascii?Q?DDzQ1pnky1ugf9GQYzZ8pfO0WMDbJlIhl2Z9ICZtymw5ODxaRpb/5TuZFhay?=
 =?us-ascii?Q?id7mvvLxE1FRmTULhCamW3gbdVuHqEazVDtE+FiQb3G6PaCXthcVYeVMCzcy?=
 =?us-ascii?Q?3ehKeESazpsrXJkyWYCEBo2g+ZEjT9QPHPRFu4W9ONa3R5cDzIQxnBKX8Vs0?=
 =?us-ascii?Q?0O4igSIYE71X1b14g/kd9BT4SJOPUv5wWMr/gc2omb85/a82Cemdxoc3jZpz?=
 =?us-ascii?Q?UXuRRioXZTaWmXWyu+BESXmG2sPBtSy7TxfYdcMhAwoZRPf2zfzHSg7IF9qy?=
 =?us-ascii?Q?Cfxuhmmyg5ICc5F2QR2Y3Sp9Cz3H40Nb4XHJfWbzKKqXbFs0/+e6xHDxtW3H?=
 =?us-ascii?Q?jZxzNX76oMbR19RMQBWGbh64f0/rsOIEsbUvLucALDxQU+kiSYLVPoH5GWRp?=
 =?us-ascii?Q?YeuZEJYik3gJlhUkeuXtFaNfvEaFzC5tgjhMIOg+RHVRJvJRK1eF4ukkA01h?=
 =?us-ascii?Q?vLndNkRmH2rzaGC1bTqXuDUYGKdMwXc4ZYNU09TqhsIthy7XQTJESIbb1ZbK?=
 =?us-ascii?Q?gAq3wOYeMFOlGjbh4N67zbyeJpIQTl+8ORFrYhaId19Z4MWOoi5H3WAmg6KD?=
 =?us-ascii?Q?ATkbhGN1KzKwFLX7i9Oa6AbBdvkhQREuFl8it+M7f5jU9D00iXW8FKYAimah?=
 =?us-ascii?Q?GDKu8Qhe47lujwvV7WF40Fn3CYLfWgizh9a3KeZ0AHTgEUkaQc8TLG3rCz1Y?=
 =?us-ascii?Q?0PfFC4hmNOEfih4h7WSjhfQHOTr5s/1+bhIj0oUEGnwjIUSiSAmw/p+QoW7R?=
 =?us-ascii?Q?NiRXvH+9H80BtVLvkHyk+I2LZ89n9w1qKPFEVLwHYr4UHj+rNOiAF5XUHXZL?=
 =?us-ascii?Q?/S4OSVcW8d8ommNVxKCqKEJuLA0ckbvUSHNZmgH1CDi9nqzsqa7wNMIQYDce?=
 =?us-ascii?Q?cnWXATiWf4zszGPfyWrhxf2BnKEj3+p/Dz4U7356/6ygMGaQ6XA5/k/Sjs2v?=
 =?us-ascii?Q?rs0zCJRWTJPrmF7qXGaEVmZt2iA9275mCKg/fu0ngEZGgEh0bhqH7exQrOhk?=
 =?us-ascii?Q?cWS0WLKFyWN/EEwiCDg2usw/ZLhk+3VSTxdN2OzywbWwQx3yHbApqf9lj/Lx?=
 =?us-ascii?Q?JtRIsq585Rao/fx4lHJwIzJvF4OzHT/2gcG2Vm07yFhr4TkuHwqKX7KEeEvt?=
 =?us-ascii?Q?bC/hgVdDC93fRap6A9B3QaQTekFuKMEdSmG6JvMffbTCVWgl79Op7m9gX8Bl?=
 =?us-ascii?Q?uVR6gGzR8MEHc/kQzkNsSjW3rZb5DMY7r3xuWfXjfuJm/Lou7dS0v1pLqRo2?=
 =?us-ascii?Q?Ixy1NfvlJe2pd4CdiPH28gtewv/1Aa+efz0Y1HGqhMY3RDniVPD/xY7gUNXy?=
 =?us-ascii?Q?pC0WmKVaY3697yJdSbeK6qisF9z8wYtqnBdt5lX/bis7abXU0A2aaO4g+JYt?=
 =?us-ascii?Q?o/rLWV0wdghGuhhzcEq+9KFcbMjP/E8D4/C8uA3zID0y8nzmikSkR2kKd09T?=
 =?us-ascii?Q?X6uKR9eqFezBmQplbGb0R3zFgyIoztaIz2ysrLKbnxO5TiRikv+xxu1YaYnj?=
 =?us-ascii?Q?eTxhEf+wiQ+y2wXQgVKj8RSqpKnSRU5uKqZ53MKpvBbGPKi/qnmSv1aSVKXq?=
 =?us-ascii?Q?mg30N0nNMU1SWJUaVpXDAaZwgY6dv6TWC2KbVjfVqf84mYtcvxMvpFj2e2kN?=
 =?us-ascii?Q?R9eNU7WQeFpTLkxJXD15/m9PvMEPRm4Gf9M5h+/gKgVCag4l4+vMKN96KQS9?=
 =?us-ascii?Q?CpJwOVS1ZnSDHDoyoRzjRJ+PqriZd2I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad28092-db17-4d0d-9561-08debed8e7e3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:14.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKMFK9H5BAYmVQJ/EQQpvpdoJDmlk6Gvoos5tEjdZpR9Anq+HN6R2R7Tn6rEY9eIyPa8p4TkB7R+AxzAmKSLcpZMrnswlD7Jn7vu5iG3h1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..0b0dafecbfff 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -219,7 +219,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_retrigger			= imsic_irq_retrigger,
 	.irq_ack			= imsic_irq_ack,
 	.irq_compose_msi_msg		= imsic_irq_compose_msg,
-	.flags				= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+	.flags				= IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.43.0

