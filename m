Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFE3ACA72
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249224; cv=fail; b=btJ2svsarQqHVPUbXIUJZfQ++9K2fCCl7Gjex2noPouhqfWgAamQma1B7LEXCDL9HKZz8V2BvekeG4pRfgo0dywfCJ7mlNccPeZYG2Ub+oZn6lZXTQ/oEicQBX14zllSiUIsjmE+1BCmUNOdxO+s6h+BBo3uwRJF+4lGH2Ej0XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249224; c=relaxed/simple;
	bh=1WW7TTkkWDn3slqXSp4lR9vOwXesdKIW95Cfiyp2zf4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DbkHsG5VlXxBHJU9ikvIAlGCLNETJGDDVyV9EClzDHc4V4naiTAlfwjQZAj0Z9WyFs9DWURulNYg+ylqaT5Jcw1BTgHF54+dGUO8bNqd8Do6I19+8cg3O+IZ3f5cnHUUMWg80QKs2FtmIu7mTRCVnGi1BylWZJt+da6ZtUA51CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w132SrMi; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w132SrMi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su7M2d/5sp0dKEEJV/1LXnn+jwTB8JbiW8puMq352NalwAfIOG4V04QDeeS5OPTAE1+ZQxpX2fTWyOcQnfRAB8z1jTjOnCIR3IkygXa8P+oBhcPF/IrqWm+nH4CF4ev4y+Sqy4twmGN6y7i07IsKz9byvVOz0ZX0ebfrXdPPKt/GFwPaBwc3ZhvHdOfRkr7luSoA9kEPeofhoXFONI98eTWEa3F8D+NB5FhG72ZAEqjdGLUn88PSwiWZFHKD1xYl7ClHJ7dtuk5VVFVALJwLgqPQg+5ReMRKZ9KdoEvHuRqVJhthemrnSVgxLYzpWwN2y+qqUSSA0w1Ztwvj8dsV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlkVDmhawtyylt+GoOGEc5ctQ3xcQgAwC1uvcpJc7BQ=;
 b=mzoFJ+rq9Xegb5ioTZDTMx8BV4M1++mfz/owRAzpM/V2YgLZCqxr+YevSWRkWe3ckOL/VeTbXSeYv/VhlNyDwogsKDh/NZkVDat/nbekqyw4JnB/IQUt/VxU72N2qFWejmjilmSxNqK9IU6yl8daKurWDDUejP3C5g51dJu1ZA74qbtPMgLPzqonK+Ti9lUESzA8JuzbWqUWt6ZKANHFv3gk1ouUrSy4mf/Yuh4WzhflAUfkczglwfmAGXDdhYvxLmAFs0ATkkhpt/KGM9NZV67Mj6PJjFO4R8By8lnB1Y0LB+9lLTkMu4LbWmWGBbJ87p9NSk3uBPe84IQZedsNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlkVDmhawtyylt+GoOGEc5ctQ3xcQgAwC1uvcpJc7BQ=;
 b=w132SrMi9ZAVCTHw8k2cPixvAvKzxEdoRFTpWtqdK9YLnl5uppbnpBQmNbU41G9Wg0NDV/1xfOs1l62uEhum3dr12afZ2tEoSwmUglkwvM2BhMHVZ8fwo1zVa0hti/JEZjwqny1qmJFL7POjzrptaz9FSzUyLE2iU4EPaq8I+RA4ExMcVVsTkl8++/7RNT5tsAb4xp3eahYF/UhhkyBqdAxYwKSUZp8hENPEwozOyh2tfvHSGz4qfnBS6xvMd4QGF89wXA/pLV+S41oOinWH42qTro/URE5Z5K9m1jGDrXOCMKdOf9xYrcKqp/j/mT+4mYDlrYnTjZHv/cMTif70jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PR3PR10MB4030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 14:33:40 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:33:40 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] libevl: remove the riscv custom branch
Date: Tue, 28 Jul 2026 16:33:32 +0200
Message-ID: <20260728143332.2746337-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PR3PR10MB4030:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c0a36f-c732-45d4-c8f1-08deecb537c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|11063799006|56012099006|10067099003|3023799007|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UNDhqIncQlyeWMlfJursGT2oEqPzJThSSqEr4VY3HMXHiRYxb2MHR2NqSfXGSJXhKooYyX3Vlh87bOl676LNYhpRQ12vqhopRRe+nz6qABDdRRlc9MpT+P0N9Dy7a+KNocDozq0chBBEjSC6J/nxKT2sB9oRnouc//fgpD46S24IzMxL1OfHLknn8dWQe+/WzrsfW+wQTZKoaUO3mh/Q6J9+yHm5ng3XiNtKKgmZN0hiaUesPMD/ngb+RWmhUBhHg01sd7fHxrfMQUA4aFRiSbpgTWlN1KA3/4TGaCj95EBOfKtGNvE9DnNEU5qzTz7q6lmReS5jP5vP4/KkmvHSkcQs75iB9iHNQOrl92QUxb2fn1kpr83w5GncJ0AjxXp1AzAnwi3lGoi6nqKGPahix2sBUZSrmIa8kPFQueyktWiZE/t48aKcIivb9us46cfSzrVAu+/gwUtbwXqIJkNTnNEbzwdMhyvj4gXAfxAg1vLjrB2USzXdN57NlTrrQ+t0blaKvwl0R5nul/TeOJcTNINn/i3jFvAdszQLhQbdUizvBpvDSivqra8z/g4PkKmnK++Jjsp/NTxDMnF9hlsTpPMzLfwLgB+8CEz3Ih17vs2Fso5qNVEBFNJvNbfrpDOQAizjs7OuZgzB8Q/tO8lNQItb5Aw7a1J1jIzX9G4DJHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0mzte+7gB3co6m/WZSbkEDhLF8PvwhQewo2cWGZxAA9o3lAUPf/jvgbNF0T?=
 =?us-ascii?Q?Ny9FoZpY1FGj15rLFn57kI4aa8JYjl4Z7Di0A90Cb7neU67X6wtRylUYrBJI?=
 =?us-ascii?Q?t3Xe8amXWuyrDgM7LBMXH/WdKrefGZk0Jy9vBSQ4Ty/cBt6TSyaBT4Eznqyb?=
 =?us-ascii?Q?Q/gQwioh9XL92DEknZZ6OOyjuBiUjNisC59hJdBNx57FT/z5XDA9EXddhDlL?=
 =?us-ascii?Q?/F3hvRAqgn06vjySImzT1LBKPavzVSjG2+6ZjjEabj4Ru1XQzfVtg+8EvdAE?=
 =?us-ascii?Q?3JHWnqqK62Qw2tpKbi7bJEMb0kQ7Q2iM8CxukizqOdR+Vrn49ghRqLrJZvnm?=
 =?us-ascii?Q?tqTVHb20/gzjFPmCuVeGGWZ1+meD478fcTeJFjspLxtN6srmC6aY5wabCi+j?=
 =?us-ascii?Q?7uSDA29UuNPkAl1/lcNGKfzzdoLNXeGL0QkRbGSwfmeI6TSHVOIfTyynb02k?=
 =?us-ascii?Q?D/QR2BUAntSdYT7nO18dAilFhXupX0BOMMo8vPO1dZ9pCp3KAIjBUN5JtpRt?=
 =?us-ascii?Q?1FRaKAaBoAVFq8X+HvXRc/nQSaODVXyTKmqk7TLGLQaGn0HPzYBm0ieb00GQ?=
 =?us-ascii?Q?XTiN8YucUODGYott2KhAj0trfOAK1CBMd0SfTC7cCFYsqUujl2OZ2cjWxHBn?=
 =?us-ascii?Q?sxYTbii19uDJEAlJRx3u9EsZeFDP8V0sBm8SbE4NcjcZx3vfDZxuEovZwxZd?=
 =?us-ascii?Q?ucolWFjTazsTIdgmW3WoaYZZPpanIksAjWJZOY3cjTnJgjvF8ulreb2fdyAJ?=
 =?us-ascii?Q?ikdvVLQ9bnb2L2x1WC0Y+zx/6zcXhH2rDK5FfPF5DpscA1gTXEsqESY31WG9?=
 =?us-ascii?Q?L9O913Zw7jE39fVkfFnJYv5lIFMG27TcChanzHu9bcFOYi568H8P3FDJYrKC?=
 =?us-ascii?Q?Dt22wX4F1HIdiV8sZX6UPfe9iJgCkHVouDkG8/nqDv7JGTH3Thn3TUnG0A1t?=
 =?us-ascii?Q?UDW1y8O3rlSJvMrPMzV8hc7QEBnOz6moH/UTqq6enFEULvdCw4qMOzChBOlp?=
 =?us-ascii?Q?5ur/iQBOGdVDCxQBfJDgAHwb971wy/0JObab25IQ7377AQOtwU6HKOG5f/l5?=
 =?us-ascii?Q?9DGgo1Q3PyMVmcUzHuc9ecSJ6Um999GCACj9pFjHLhdeYhKGFDc+62RDPbHo?=
 =?us-ascii?Q?qKEl7tyVfPa/kUMCtoIg9AT9H91mdHsHjsqUjXrG/lVhW2afJG5ySg0Q9iz8?=
 =?us-ascii?Q?t1JK5ZElT6Ewqp1PmeQvC26aVnd2xy109fW9BNCkr7ec6IepBgb9ZSeBEyWs?=
 =?us-ascii?Q?kcp1uX0cfJoMmhAoWHlqktgKbC/z8xDd99o/UPc/OQSWK3SAMmdqUiIlw1r2?=
 =?us-ascii?Q?LHjacS3dX3LzvhLzdnpe3ySiKCTBiuzl0XK9PoL4u+yg5qCw4QbMFLq4B52+?=
 =?us-ascii?Q?7JrJIJgYgEUbeFtSmqexrq7DKBpGfdcJiui13Hh07niUUZKQvDgERCK3kem8?=
 =?us-ascii?Q?wAivw24xIrIYrHBO281Gd9IcyzNFbtXndcKW/4jSHDGwUsMgQQ29JuRJFjsh?=
 =?us-ascii?Q?brn8C8qWRWBsnPDbmuCbKvEm2ORsxY8r8+wv6ZhgkPNzxTDj1dGIp/gq0QWG?=
 =?us-ascii?Q?jPqCMziUGS1YWpvXE8IE5/Z+piBnH0PXnLvrvucuiXftSzOPMP05KnXmKhBq?=
 =?us-ascii?Q?VsM6iLr49o/75yhzBSvfHhynLjIYrR7RkT4/fMMd7d/8TeP2otKaGo5c09dq?=
 =?us-ascii?Q?Z0Cc9SiW8YIe9xF5ZXNLiyjZdNozpSyZtAuJyIK/+4xZQtjAM9AxQ3GjuBan?=
 =?us-ascii?Q?eQW3Cj4C2fyyiPccehI3UpVqfpFDl5o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c0a36f-c732-45d4-c8f1-08deecb537c2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:33:40.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ictLNNIljECz5a3Pj+EYSZ88NN/ERhVOQmEyTRhhmcPrvTsyDQu1Ap7NQfbjW2GFKVWbos/6Xy6W9bjFzh8lfXv4ZAG7HMeIlf1zS6AkJvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4030

The riscv build bits have been merged into the libevl next branch
and the custom branch is therefore not needed anymore.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-xenomai/libevl/libevl_master.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
index 48f10dc..f59949d 100644
--- a/recipes-xenomai/libevl/libevl_master.bb
+++ b/recipes-xenomai/libevl/libevl_master.bb
@@ -12,7 +12,6 @@
 require libevl.inc
 
 GIT_BRANCH = "${PV}"
-GIT_BRANCH:riscv64 = "wip/libevl-riscv"
 
 SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=${GIT_BRANCH}"
 
-- 
2.43.0

