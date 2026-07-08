Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78C3BBFAD
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492088; cv=fail; b=bJ1l//Tx6NDB5saUEMQBbLRvT7HQxA1nXdPJE7x9CFbVXTXr1BcMc/mXOLJdHAjqN5XxaRclMOVFT3cu8HDPVaKGB8Y5Jer5NSovMDq7/qtqmpeDV8yg8nmhXWqPA+yC1HEE3wMxO2tIbRPXC6xzaljkrWF4PP6hdSEIkSjTRZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492088; c=relaxed/simple;
	bh=cR9Rrx2sFu9lDuyV8bq68p2FDh5riwcqhTJNJDz1VB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rvy7PIgkNOtvkhvRUV6kNnCJX9pOjihPaErTyv0s24FRQ8nISg1w5iu/mFQOWH5aIzvOKu+ODDODNuP0Fr6T7iWsELZrJcEdyiZZ4rNmYq74Iwb2ODDUl+IPJifevlZJu4iYmVzX5CDGg1QfEkyj4kr9eV4Nj3IX1BX5XGyco4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mrVRK56Y; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mrVRK56Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm34D32OcCawzi05dP5JbrtpIDC+JooZ3ur80HZx0pYMXIXTibDfQQEOYCuD0A4oqHF/PzyhlpMQ/0zIYWanGi1kC0/C9/MNNXRcbcab8gjHro2GSM4JMc1n/RM4BwRxlN1tqyeJZ4fsdRdsSwT47vfLUoxqmp3RVLVKu86RDubbSj1yS8+YfcQ4RbRp/NOfJ1Z9OcnQnAVjorxXHHINsONYMc+6qZhPHVSIOFjtysh/TNMIt8Mgd0/ZhWCY6CINgQlpOcSZK8GaeCcZGhseV3sB6sjhuaC203S/UBHyoskLED1j8/V17RDUpwB93jOsXtK/a08mdCaUwbBeAqM3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEIIDWiOmg/0kajlvYUSpbv/F2fmI2Os5Mi5Cwng0NY=;
 b=amtnu2aP5FQKyHa9AHF42+Oqqb+y3ZYsMJAVqh/Vy5TRlHuAJF3DwJ6VJxPMJlgNQCFt2Wc2c385F7QGXd+je8fY4v03rw1fFdKv1cSqhSrTwLz6N8scOTAmv0YTOktMpwJNVgX66ePtyN27oEQk9PBnkIjY58w+UJVWPN5W3rF4Z7cuK1U0j7Ln6I3VhNU66I1x9KiQfhnciFxaPuag5+x7F7T3vV/uk3N5NCcpAz156K/abN9qAvnbGmt8rWjiewps3EtB9GzfTsY5yLGvOghld36zJJzEyy1I3PiljrikbMfwePNP6Hiq3HnwZ9BdM3zN1aTOcWM8woYhUKa2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEIIDWiOmg/0kajlvYUSpbv/F2fmI2Os5Mi5Cwng0NY=;
 b=mrVRK56YvD7qiCQLYmIsJ9DOU5eVrQpmNSl7PnTfx2frRz2WWpOsuudRw8MV87N5Lut5ijvDzaPGaBA2X51fxy3eDOEzXTDUfi5g35g02Yxw6Qa9+3Bj0Lmacp4d7DSVFbhP8EAKYV5s/mujk7WBfGrFU5V+yiQEg0nxS1V0mIF46cXnxWZVltoNUEiPnzEP/X5fFiWStWJ64mgGu3uSAqAojhgx7pkZ9o6P0NgmgwPpkdaNo0ze7BB1qwIyYKEEyokXQ3gomOywfhNJ03L2kz8wtQ/xfMTXh4iCuhU4g5UlgBJKk7PhNS2J/RzL3i+5gehfv+Xc+M/RWArkoYRf6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:58 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:58 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 05/11] irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
Date: Wed,  8 Jul 2026 08:27:42 +0200
Message-ID: <20260708062748.1029852-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 08773dfc-9799-4d32-18a1-08dedcba0d5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|6133799003|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QGYTIgEhck/oydmfk5eIlyIMY7oX50wcab/FYKPfJKe2A5SWd6xqdjB/Agc6Iseo6/OnAKl8zkNGI1RAAURablrpYsoq0eF1IDdKT6gN9T4Dmgpjap+5U6TO/74c3hCqFS4NT6bxgH7pRHjA7NRIJFLEWnJX/pPusJmLnmrWzCgM1SF8/LwaiyFDeeYuhheq5T+TPU6uN6esvnOtUCmCyeTuiHQVGqymOygeJlIexH9fRMNfndRIvkPjOVElwiQMPMLW3ftjqpR6wrWvYYoZE9HYRqTbKwYQE0Yl4lS2vuUrnkFlH+CJnVv450mdk0GeSJvglJEL5uXXTkSLtfCS/uztEByarT0FtOkJWkjb/f5BD4QZV+RGNbDkzC+Ia4UiSpW2ve+c59cOUxCal9InMN6ej1YooLDd6nFjSEuX3Tg1h66OSD95fLoXYD3aF9IxyQeVorYe3UXKoMZIUcMwIjyJC1eKkLZI6m+7AmQq1NcSvpBZwauQ5B0PMR+wGIDn6ysZ7OnGUixKwtm0i/aY9p3+zPqmSHnbKaiOatAJovcsDL9aw9vAvZKdEx37A+v7l6cLoeeYxVKClIt1d/uZJR52KHI9cm83z0ENgIr+gqTx1J2UX+SRuTgdAItRIGmhlTOH4+fYlokPkj0CXDq2RnTsNUEO/0vrnyCENdx7CbQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+99LIbLrww81h8DIBicFFPYB6dlXfmlQEIDxLkNMoP44NuOgojxux7ja1jdS?=
 =?us-ascii?Q?EKA4tp1zp8J2fM5tYYXrCFSWODhfRiwjRDDV7nF3SM4q0GTINbOAC4dovaUC?=
 =?us-ascii?Q?60hLAobAkK7KkcDmChGy8QH+Na2twGRqm5FIoieKyZ0wLnhftBo6rM+YrqmE?=
 =?us-ascii?Q?xhqsv6BnpDPly9z2cs8pnKAxerDBozm0rbgUnoDo3ViNGH21Sopvv57r1EMO?=
 =?us-ascii?Q?HXWkLih849krv/5Yq90kA118UcspGeBC4XfBBgz80DfuldK4nrFSlezEYEls?=
 =?us-ascii?Q?VvTSgC9SQ2+95DgMTOqOqClAY84dSuoATbp0C++8tewDpoRT5bkBAJRaRNpe?=
 =?us-ascii?Q?k0Jk8K0aNQws/Efa61bL3MuAW84wTRfYwNo+OiSi6yZyZJziUbXVKsaEm75K?=
 =?us-ascii?Q?+Ne9ZLnS1pC5PwJfpe6CUVnLmuLnevFTZCKOuiigkb6lri1djzhgFkWEaxw6?=
 =?us-ascii?Q?acKs5cQJSuODEAlYiFh4Yt/JojPAHB0oiaTYv6pnQu4C5PScQQByyyS3BDzM?=
 =?us-ascii?Q?Fe5YtcgWDoFqR0xgkssNViN1LK2/yxMDRJJiOOWCQJQxROpdAW2C4iGXugiZ?=
 =?us-ascii?Q?YKztYTMbdNdaQocApqf5VYbHHH6gyWBlns6NM3g7l1Sj2Gk7+ZxgIZ5SiSh7?=
 =?us-ascii?Q?Z2HTV/XMPteyXFgRYRg4+WAinJRrYU9m6rhggPLC7k06mm4+F2HMqSe0ai80?=
 =?us-ascii?Q?6Sj2OINFazlaqjw4P1RH3KTH+Hpw9bjvaRmlAxpRfq87aFG6gHqpIYIBhScy?=
 =?us-ascii?Q?JMgvAAQLGFpOrD27lMNRMQh/zy7C2L/fpTC7SudG9mmMlkOKvYptLS0AufRJ?=
 =?us-ascii?Q?ljcbLi1BFIQFu9r6hkoA9zAawHAzQGTU+3HqzzIZggAKXl3glZucpryyVbs5?=
 =?us-ascii?Q?hPyBSzQiIi/2FWmR6jaY89FmqMhVtTZjXq3CVveDe3rrlJy8dD7seBJkzKcF?=
 =?us-ascii?Q?T015pAQGHXQoDx3WOb9R/sMVxogUmnV5AzbOdjH2uUxzgX82IeNHg8CB7lWm?=
 =?us-ascii?Q?q4D5ISuoeUb69QiVd5hn9rDvarqKarP7Yfl4o8KApF+vMOAstro9HL/hy+R4?=
 =?us-ascii?Q?daFkoZK31xIVcIaTLgSflthO5c/e16U8cnLypV9+CCbu+swMadZFw7bOkDWb?=
 =?us-ascii?Q?txPtPpedI6Pb3u1zNrch+VyoyCFm8Z0jaeIQtKEPA301Q22NIMwLww2bw0oi?=
 =?us-ascii?Q?AHrbQhnuNMWEfP0nVOQkBmyRpAC525o+XWVU5Czmb/I5YK4n40cndD8ACFWX?=
 =?us-ascii?Q?RBDTSDqVHNfI33RbRBJe+tK1Usqb5/zEzfVhNlstpYkYZqi0UC714/X1iCOw?=
 =?us-ascii?Q?7lbLf4/8EOewLR/cOohsLX1b93I50aWq+c6+Aq0sDZeLI8m74TQ09E5LIHOc?=
 =?us-ascii?Q?SiczfyV7W7CCUlxBM9sydDR0v80twFdWXjMR0g1IdAaH4W5AU5W6nisydpoN?=
 =?us-ascii?Q?dRwvCvlO2PMh0dgLqtONCfhOOVKPy1b9NuW+tMOlmXhlucgtXsm7MymYMzl9?=
 =?us-ascii?Q?Cp/F0lF17QzNYFgjo014Ubw02nuSWmDbi69bY6+m9G/uqty7lUTitiag6YHc?=
 =?us-ascii?Q?e5XXz+tcg8iZpWSuSPIEpAqRXxmhP2hEt6YCAiNZyVPAcgZUJD4Noin297ps?=
 =?us-ascii?Q?K0PDZsCMqs03N6j8TO/8bsoCuK6p3yznmthsUhbfnBNxr7rRcOG6COqnfw2f?=
 =?us-ascii?Q?1wevOI616uShmY/bk8y60Pb4pD9202K+Nk0ynqOoQEdvRdzvRTbLLGg1jyKs?=
 =?us-ascii?Q?0z+cD+RQmZ6Q6KONeYS8RZ1D6SQK59fQZIBXhFXUxbCs/n0MV//qBSGG6Vw4?=
X-MS-Exchange-AntiSpam-MessageData-1: LOGljXdvyvBkq3s6qCqfEk2CnCDoxWAIVlI=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08773dfc-9799-4d32-18a1-08dedcba0d5b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:58.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpS+XdE0CQzBhOYzqucQ52H7DC8S51uKm9v0tNQnji49bGSmlF/aictPghcbYF6Hv+D6RlOi3lxL7pY/oeMy+l60XidbFn76FT//SuMrKZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

