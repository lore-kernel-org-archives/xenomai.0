Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA212BEFFF
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459731; cv=fail; b=YCFxbheIbAOJqzeAxVdTVoO8NYW7g+JTKP19SC5KT4N1sDjoMrwOnYHae3f1j5SY23MMYEYgjbxr/6z7DwmLx4YF3vchNAW3ZDzhxP+NN/DiLsoAHj6RVb/gwVT856NvSd4p3UqoN4mqWx0T38pFmyP4EZB77d8plpj0hRGwmX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459731; c=relaxed/simple;
	bh=39GCOayIqybswVpLcSNY6Z+YPpxGL4s38r71MQk6sMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNhFTtn4NtgTR2VITzQ7qyOaKx1gNvhq4snSLr0AFXgBwI1uTqorQ1GUwmOOq0GA2C6hIGtBSpri1nKO2+PCigHzaT89iVO4Nf9MclkCRsCKsHhRRl7LuacA2OaJLdbOom38x3XCwe2W2yl0555YINSbhJT7vWIYMpxF6iNPYMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BhdX0doB; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BhdX0doB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsDp+bPFc4qD+DjotVSIrtmlfvD4+byxLBRevWF1Xf1fT/MkdBjAKCZwYEuru5GlDNyu0RqHJitjY23rDT4DX8VvSPu64GPm4MUwxufPpAU3GMikNI1Ip1IJjwHFAK7WHjLMRIZmoviBvNMwPDgRZ3uP1uY7hh6HcpiBpKj57QyxB0kmDDz0pdd7AZOuTYqGpoq8k2/0Ye1XNXCzK+Xwh4nmotAFK+/IU4gn6QpwZIOH8SBT25ktxMFa/nS/Vfgs+FoJENgLYH1cY0tgN/sNn3RKnWbzihc5MCSOulALqr3XTp5GEXbFBesOAxD62i/utkDn+lxdlBivn3sTPPyzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQXEJbUEMkZhOBDwWHD4F10QLN4h9DBdEX12kGS7TzM=;
 b=ARGRBhBJKooBvn4L68gfyAMT70t7PK6gWvXG1jbDGJJUzkfnKDm/0qVCMHFMKaEGVxrZRSQt2ivusG08EXtLMuM2O/i62VEy4ysIyRBScRZNXw4QrRXFkGHsvU1khAdu6CJk/IjFXOwhTv007CMXoFAkfn/llqSAihLcrZfUuYRUgkRoYkunw3S8uJ8ZFYKOzM3rfX3QUyB5gJZH6UcA9HrPVMoULPwvXqSM40uGqrQC0wAe9Ru07ObiezacDtBUpXEGhdkJWlk47xNbqMqmfpg8zF53CqXoOYlfQh49j9bhFIz4KAhCVXXAod4X7nb6U1MGy4iiV/iBO3N74NLnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQXEJbUEMkZhOBDwWHD4F10QLN4h9DBdEX12kGS7TzM=;
 b=BhdX0doBwLCQ2ZdTu4OAHIpvGxo9HsCNiRbf9kFYcRotNGGFMmTPv3PR6kDYupjOOmsxKy3Z8JweAiJHbjvHMe9JB/j4TQm5u9Uh+y+PVFEoI3qrIEztUBLm7Dd+C+KVklLMLcB3wwT26RbHqY6rjuRjrlCHTqtgo7AryXmDlB3PIxVvyCtENXSlx4rrh7q1biSe8GgZ0uq573FiY9Kj0jEU088kgo05LHF0GRH6cHOtEPckDBvMw6MrtKYGTps6gLLAgclrn47XoCpb2ZDtIxZ0C1BVCL5JnoHGupJdxxCACCcTza/t36yOM5TZpv9ejVfUjMNB7z7w/90+YA6HSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:03 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:03 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 04/11] irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
Date: Fri, 17 Apr 2026 23:01:47 +0200
Message-ID: <20260417210154.2290819-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e57d729-0887-476e-ea5c-08de9cc4937c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	FBrBV0aME5F/vAYSUL4sAxSLt8WJ6yQHZVx2xP5xlrqLg9etCkqdIl++BwDhbixb79V/vnGSFd1XVPYsYd/lGARNNFSyIaObv0wQNwTegZXN+OZ+jLnqqKfBIWiMGs7IM6j9FE+hn2WtUmFMZI7YgM142pC7LOLkazxH6ZPpAl8QJ82R/wlZT1AE1QFSTzPjAsw23yJTQFn5uIlVtZrN4/XvS4YbggjXsBfKCFwvGGsRPYui/c9I4rKX6EW/YZIi76i2SMLK6aFDWZWkmQL7khEbG3W2fUv2vvudFhuHXMvIG6GYl5ek3vgpUGUW2Gj/OqiA8ef4E7o121IbqnzcmHQeAPRF2LF05eYzx4fqILVP4l3Kvu00PbfDuqJwJj6IkFUpNQoFkHYPKrGXZRZg6rv+sJq/LRMXqVnGy4pTY1QqzLVgHFAIxqUFjd9cP/6BMqWtwoX2DKfsmZ8Wg4De/OsG8VrICcF8ONDu3zQoFLdfpXhv9SCXHc3f17YkdIvYEhFWoBh9Rf+yv2jN5YdaaSQ+TSIbHfnqYgDgXEwliu/dITO7nqn7tkxe1iWXo818u3dd2XXmaK89KXXvQ4D3CB09tPrAswU8Crem9FrYNMsTjDwoyHF8ru3+sWEPoJDztviQnltgIIeoH7KQ5Vz2bkOLtSA6hWN3NaDCzywp5ND8eae4pAbOXaJLtt0Q4AoG7dWsxuP4uPexEla2vJnY5/lPcvd7NXQr5B3pFPT+yeQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPbCcehkhcu8uj64+IVbUzuOkFg/TxjiTr21SRrfJW1/pJC5u/NF7tZbRcSt?=
 =?us-ascii?Q?Mmcc64DXCoFAkO8xX+PW5dSYQc1rDtGvziHEP3Ktaj7JEji4oc2LwNIE8r/9?=
 =?us-ascii?Q?WmidQuzia4bPrb4ZNI22Ti7xw0Jv+DXeVERQCc43K9alnyunIy5GlwvlJpCZ?=
 =?us-ascii?Q?Haa+qBOcDw62jGwTOj/OMkLFJpH5Np9HUPA33tFtl/R14BMqrmu59pVx1v7r?=
 =?us-ascii?Q?4RpFNTpVmZClvt/j0p3Uw4+gdcdueQv/gclgu0eZZC6aVOqioidwF+DS23pL?=
 =?us-ascii?Q?v1m+ws2EQkLdLVDTrNiGy+SY3AhInFoszfWbgco+SMC1tzkh+Cb5qoqkcKNn?=
 =?us-ascii?Q?gTHfGAKJImlfudQNW7rKyXjziWoB2UGvj/XVQXIfrZyC9JbTfwJojTCVBEt7?=
 =?us-ascii?Q?gsQR6r3vhC84Sf3jlhZpl1hhgDOXwSyc2H0VXHfMbRIf+WM+wJbp0CgIS9+T?=
 =?us-ascii?Q?zJtd2JAXQGgK2sRPHBNM+QIhyQcy76REN67fe0bz3lW9wIoc/H1QegOJSQvZ?=
 =?us-ascii?Q?5IfCFtkPAOP8YCY74QnXSUDInCBef+QUD0fNo27KD73zpR1OzjxUjMAF0lKO?=
 =?us-ascii?Q?dVoOBBkhBC8Am1gdh0o4h1IYJxfikuEWoGPoMehoBeWwP8wjNKVHA2g7b70J?=
 =?us-ascii?Q?GxjYcxrq1qlMkloeEKR0SP9yW16l074/Y/sgXoGA7u3rvjxT4jkS3uF2Hsez?=
 =?us-ascii?Q?wOOKAPJvp7q3NSsTwOMIuqfyjtKMloDuiJgjMfc2VVy8L5hDAkFl9n/FfXbh?=
 =?us-ascii?Q?5Zz/XR3n8HUnVUol8/BP4/u247SEMNUgeNb5309KIwbcqPnn6AWHyNpzA9yS?=
 =?us-ascii?Q?aGHjoE/qp5kWzBHM5prYeF5/NYyWKf3mIVgXpslBfp6nyfULU67sh57g0NB0?=
 =?us-ascii?Q?hmdrKYzGAyGKlUXvWrbazBObvqwO6jRLPHD0NIY8w3trNNL0HJr2hFm+NXrW?=
 =?us-ascii?Q?G2yX61Z+fnySIzrk4VfjdEIzQUdXpM5Df+bMdZGyYNuKIHdmXB6tpIS2GMw4?=
 =?us-ascii?Q?H+hQnwtlTvcyhsoxzWswA+GQKWXZh6Of+jG1YKNRa0JSTx7O+jU6EbwbYBWi?=
 =?us-ascii?Q?frl95fG2jU2wSIy2IpIptYheHHm6ygIprPe6m6JgFIx9JDtnXE/cY3ZbmoYL?=
 =?us-ascii?Q?DJTSzSY2PA6ncqfkSEzK48ghmG71A+eC+xIzEsSfVaEOONnbV1uwPQBn5mrP?=
 =?us-ascii?Q?HaMh/d2vpcS1X01zzInOUot0ynl4qRHj28qpJuSTxXvf6XspnyU9PaQFKRNC?=
 =?us-ascii?Q?7dlVRItmefvg0QvZDYJBtRGbuxYBrrckY35c+QHiDaVfM5Z573xO4Z3O80at?=
 =?us-ascii?Q?332JIIawsU3WZm21dOSA3G58xaFrmLBwT5rLkNZ36yO9slFzEOhWi5pI0RDc?=
 =?us-ascii?Q?nZc+VRtYZqejNMEQeJ3u7WXgLZPE8zzZKy241sZh79q8BVgT2QofeoLuWf9j?=
 =?us-ascii?Q?dYZ/kWlicmO4O8RBSg4zjzdZyjb1bdYtrtyLbWwZxjhZ4VFzO+XX43obBKme?=
 =?us-ascii?Q?IQ62DoOETf/f2j1olwlj+rY7xeAsStSIrHvzE7OhzR1RYDpgy658FQPuD+Aj?=
 =?us-ascii?Q?Z/WwjhhF1+1B+nUpjxZAjpHFSnakFG4g7Y49as/1TQtkwc/xgt/IpybVq5Lg?=
 =?us-ascii?Q?gki2dlTzYI82byIx/aSQi9kOoAbHeBFa49gFmJCqOppfDlqzLl3ZK2gfIvVj?=
 =?us-ascii?Q?eO4dyGm7vq4/7ilxuxeDChf7CZJWRy/V1CsSaSMHnwl7M0IdwjkmqkOH551y?=
 =?us-ascii?Q?vDc/VrFIo4l82lMooOGIduqtKsa7MtM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e57d729-0887-476e-ea5c-08de9cc4937c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:03.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh8LM/56baT/SoChlKDj2JNyYQ4XXah8m2BM4DJP7eRykc6vWTBvkTPnvZivHHjYa/3+Hmxpt3qcKn8xvuRD4eTKahpTNCtdcEbx7jADnRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609fb..25de8929ea374 100644
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

