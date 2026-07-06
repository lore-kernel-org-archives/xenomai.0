Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DC437861
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362586; cv=fail; b=oDntW1w6l7kXkry3LLiQJhY6IunuODe1WrhCAh4HMHdbOQTi+oeHh8agQpScbTvB4w8j7f9nHSb72BQUiOG+iCk+2MGumZnTnh3KaR863cnpC2LFNXxJcPIHSdPWaAKGD+xJOUhuM81JKBrj8C8mv1U4ljiXt9s4LmIjH5JSh+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362586; c=relaxed/simple;
	bh=ZFlG0X3CRNnksGFfFp5k8jC2mWy67cLGno0oaZfk1s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZ0c+8xK0NH0g6+SqGHt1XafeqIlrVyxJfVnyfyyCmtUt2ozlASIQs4utqRF6DElYoWeuNWsR+TYpIKty7EWRXXPNLijOZNQcOSosx7o5tMMvLwG0RMuVPzNSPfVGKzn6KBzA0yGCpAfdhlL5c7wQ3Z04+1GqE992qzbHe60btY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QS6hBb9h; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QS6hBb9h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgPFZQmRc7b1tfFC9ZUuWOXMVl2ISnfyNqPhwIKfmR7q0+2ydud6/MKFJYp1RbqBcwA/enZiZHnLKsEpFx78YDu1WbEwi/2oopQ5+7airO96b/beA64ySsVnphlNBNxY/6kL62f6zsSy+vCKS5cnJMYu8d/ocQLZkJSB+56sx8hys1WSzrGcxCxXDhIuihvvWMxxXFWMwA7yA4idiFnO5pZYoheqHsmwP9pXrpPepm+6y9uGY3JrL2Jt+jB5PXr5/j9EWFOvWt+schWI7u0OFnRzW3Qai70ucM76dNTvri0/cKh1PuzZkd4PtQz0K3ehyNvXW7BUfUSo8J3kBpcqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bBDo8Hl9Tn+8Cpx1m8KpIirlSMaYTkDydhBhr687xA=;
 b=M9M2RudIpa9qK1N8rUAt7VU7NYW9Tnq8OVyTcU0oMwkX899iPJYS9HgAkshdreTyhjT6gSELom93c721FzUcBR9za8gVjPNF8sFVcfXz8ORL03aNvAUY2BQuVBGJQRkxy2wcSEPp/BvGM9wWONlNRWgX73ghT6ZstVCPkVojDaGVQ/Fv4wYlkCVfSelIyjgFj1lx+SkIc1ssru1We/XAjhr0kOT6POMk7CD0PSjrnZ+X3awznr6/X+XVoCxTQO6RxAc7+mV9NFMTmi8BbzcbpkmwNhYu4pTC1shZlRqB2ZImvsBtx3vCBydcw+2g5rR1TLC5PAbkxHE0yMU/grWaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bBDo8Hl9Tn+8Cpx1m8KpIirlSMaYTkDydhBhr687xA=;
 b=QS6hBb9h3SRFWkp16QunujGQrjVaT8ZWkKr/Q1YIFV9qQaWi/0aM0uSEngxsW6wQIo1p6C6EuY5w1rCwIVrXDo/1UQlhdZfOOLqyL3TMkVmTJhYEvWIhlEcrpzlur84rCt0q152H0Bhk7LR5/ee9Q6PHrLWnosM2Xs5qIy3UN9puBENHqc/THs11eF/7DKYot/idTL5XQ7BU+n3vXYLz77f8SQvK0hBZS4tYMEeW4iVsEHVYaVCtEnhjopt9Rz44OTO8cpDKzFNJ8PK43MfUgskom2IAKpA0RUiXqWdxfaubxdCasAlfFleoQx6v7d0VQOK12sckBTyTYzosX3BnJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:37 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:37 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 04/11] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Mon,  6 Jul 2026 20:29:20 +0200
Message-ID: <20260706182927.281078-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdc87b7-a29d-4345-d745-08dedb8c88c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TKyqQOZb0X5/byA5FmSnDV8lNh1bVDnY/6VO0IqzvfFjHC31Mk4YixiDFUFoySaDcOSk+bSC2rEEFrBOwVTnHq3kPDCUCkiW76mt9EzCt3gnOvBa8Lcd7jH9JzUXp4BwkxgZJuVDtOY3EqOHTWofXke6wS9UDemhHZv7CLzv8V3SPZ0SUv5XphK8hirqzHy2PSEVgwRSlgejcU1CdHoNGOLqrJhnnlvcbBY67EfLvDualpbMR4ksi7vEtsHsfw4+P0G6Bgc8QyFvi1XTs5EWpDJHIsBVD7wA/225DEzliz4j47vEE/yGHB8AwrKh6Cywct63LSMwtgrE+f4SbgazOdMe8Fu9W0JPs7kRI5hv2snAva6+OudQxVrLFOc8EZPEazkO7UjD6ieXaijWIcmjWl7GG2NYmtSFtDDKAEqpDb4QCQ9qFeGcPSXBg/Bq3cP7cui7ExALt0auUj6R8d3INVnNkH/VXU1Ny/DNeuNPA7sN/iC7+wBd51mbeCvJnZwZ5iUhKV68oFTHrSodNcxgcUDOiXbwzvMOtqu5vpfUmttHoO1vQKAQX+WBdagNLuHpeqIkQCjX5iTSxsjjSMwgTdFQdmwLk2LXhaDjQ34tZjvCtywEgG/Xy0C9GcUsc5DT90zDH3OuZXNPNlHgs7jus0zwxeGmUfVZVX6RychD+wE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8mZSdkBgOxUm9txYsUzIpxnrfgn5t9Veiq/QzD4Y0H7l0gEt2Ur3q3boR10?=
 =?us-ascii?Q?K5zSoB15EBUkdvDJi4UtQRyj7KWUR/bVbGEewBfsKJ6fYwpCZKxQnuEe6XKH?=
 =?us-ascii?Q?NkqPeZKB2udXerl1NI4eOW0UlomE39lRfQ+2eIXabutSLZvuclfkaUEcDs4r?=
 =?us-ascii?Q?Ku7tR3zxPNi0UcJVGMB6KFnxnOI9eaxnis8jQmnzzb/8QjqDKX+RfuAhvzaU?=
 =?us-ascii?Q?a1kj2vTFUvw2rU6dfrcJ7D0CqmexCP2LJiVHY8InLpvMStulUjATVoI1QC0p?=
 =?us-ascii?Q?yR6uDwClnf+WEwb/uZpC2RcipxXCmYJ7+G2dQBgcQpXsxFN45/U6VvGTe0YZ?=
 =?us-ascii?Q?mLUkSJiMhKWm/aXlTGm4wWOatVWyEF17XUCEMFcuD9eLhwMu0L69t7bDdHdQ?=
 =?us-ascii?Q?uxuFEn6l4lN4FeRFgLs/Kajj+LE7FLi0e29y/4seae/C2BAE+/V2YXZAOxYV?=
 =?us-ascii?Q?uLTIAy2JRZqAllQiYZBwDgDZoFfhG0JibpgZMCTwi2v/vL0v//63Bo0MBhmX?=
 =?us-ascii?Q?E28ut9CdC/oLSdz7LCQqqH9lNCg8fiBUeVSqWeXAG88Sg8Twb376bKgjSX40?=
 =?us-ascii?Q?6v7xCf+0dzC2+nnaEuN72viMBTsk80+CqGSrVyovtoV12/QKQrjxMBHaOCyw?=
 =?us-ascii?Q?RT6WEuOk0Mbo2OAtGPgDRQTBh6IQI0Lq6kA0IEwoXRBhQ2wlb186MWtxetBh?=
 =?us-ascii?Q?6qbGNwrqwH4RcK0gZh12mNUEdLJ0zt3b1+/JUspyDJone1/ixEqR+E8RBXdD?=
 =?us-ascii?Q?bftnltqYfKDRP3e+NvPyMjcp+Iqsva2+8cMBXWV47PSlGdFTzTZNf/5zvoNt?=
 =?us-ascii?Q?nGR/QojiwlZs+fZ1NadxqVZFNKKL3Io23hJHUXgMfSsDLWuPiHLr+K5Ts0lt?=
 =?us-ascii?Q?vqIjhdEtSIYE20Im5WjOuZpVdWyp/t+lyUsq4CX6D57fb9LQjmH/FZr9k3F5?=
 =?us-ascii?Q?HGKmKVqL4m/UWMcA/hqtE5cOpDSMMozSKZxYAjEFFuwpWcK2d9WhS2f/c3br?=
 =?us-ascii?Q?Uj3FBkkDsXSbZ5t8RdwLsNeTsrhBQQhKPfqN3Mj5jPW51eLDtZDCMZzseIxt?=
 =?us-ascii?Q?1gIAR+CMkcaDE7eiMIJ/4uamfaOxh/XgLLr6Y6drf6wlLsZb5IROV6MLZcD3?=
 =?us-ascii?Q?lklyKcs3IcSzFgZqsBC2639bH2DtMZQ52Hn5uMqQ/CLdh3kr1KtaXA+H85Wp?=
 =?us-ascii?Q?Zub9FBa0pvgKoEyms/4nQJmZeURpL2kf3MeXmOIE2PAUrW9riJk0ZxyzxSp5?=
 =?us-ascii?Q?YzrwrRQiBdBby8P1QWbN61sJYMYMEoEeR7E9Kd1nHUGs0H0FC8DCCTjuewFg?=
 =?us-ascii?Q?EbSdcXpqfXxMrr2UFssvxy4KDlTTVaOJ/54+eN+8xpJr0KXzKbgswjLamnSq?=
 =?us-ascii?Q?Ns1AJoM0cQxFsnPLJsMG7CrBUVCkud3sDhl58tCNyTY+od15LWx1xluUwBGC?=
 =?us-ascii?Q?/euyf9jD5qT4Ce4coIKDuknaKoKI/u1eDAdlrwd0yROnhBvXvhReFijlPm1o?=
 =?us-ascii?Q?o9sTiReVmjRLaXbSJk9TF22ZG+Qi0GbwxZi795Y/icWSiYQCJ9FeOpUkM3TV?=
 =?us-ascii?Q?S6gHYEpBlEZe1p1VckxZiMEim9uwa/N0/mqGBOCzpD6OI1ZoKO0Yg4Lh2Edh?=
 =?us-ascii?Q?aNUQSgTv5l/wTdroQAMWhkc5auYdi/TNe9R+7pgfg1JGDcYJgvrdRZ+9vJOG?=
 =?us-ascii?Q?oDT2Kj5ualNXJhDRnPdv49kp2Y+8T8xWINj3zSiRhLsu34P1eCQGxLcKuoxB?=
 =?us-ascii?Q?F9GzIXky1fMdLe5QZMs/NM/vRAJtKnNxppbhCgijk9TlmPbgoHy83SQQ5Hur?=
X-MS-Exchange-AntiSpam-MessageData-1: WHE0yjPMXrZH0F0p/D/QPE+JlMHOuf1eBQY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdc87b7-a29d-4345-d745-08dedb8c88c0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:37.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1256csq1urVcMlXzbK6OKIm0IGEZiKe/uU/JiW01X97tnOvjAwgWnk5DsdU+wMEwJEaJthVGwNLNZ19FxGK92gKUI4p5vZhC8zoIy2Ovpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609f..25de8929ea37 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -156,7 +156,8 @@ static const struct msi_domain_template aplic_msi_template = {
 		.irq_write_msi_msg	= aplic_msi_write_msg,
 		.flags			= IRQCHIP_SET_TYPE_MASKED |
 					  IRQCHIP_SKIP_SET_WAKE |
-					  IRQCHIP_MASK_ON_SUSPEND,
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 	},
 
 	.ops = {
-- 
2.43.0

