Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448132143F
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459350; cv=fail; b=HQV21y6Jk5huiS2Hlbvcry6nkvTcexrc9SuAqOZAgQooJg4dJIPUMYytJEj0fY7iO+EIDHtwnlUJHDtnZfPGLxVESsmb2Ifrrmad2fW4XabjAr8vH7fxfbLtT/9T+0jO4e8jz5Zyid2NtGUO/tHyyB+6BIqVrN4ezMtiHw6i4yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459350; c=relaxed/simple;
	bh=V1RvsRy+N/9S1n0wBvyXpHOD+mEyeCt2wY1gbiD2b/4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MOgd1J4aeKyzVXdq16qpH3AAEBnqO7CQOd6fj5DZ9vokn3VO5K0GELiauszLeJ54rXvMAvcLnrBORXzg4AXNt172/GgQdogU35nPjnzLAFaTkLWMYxOfBBsSxLw4f9co/JDWVtAPBrznAReZMDs21yMpccxy3w1wtWFW2oeMm88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lCP11R3q; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lCP11R3q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2vBGd1602fHr2c7Jz0nRgo2e9tK8l+0fwBM9o3VWJ5BZ+ytbNqOgJveuRqtSSeBQTeepCuw4m8y/+Li3yOlKnvqJBcD4pnxqwTPqrKudBPcTUV0V8caJE7aqMtXUS7PJy06ibQjF12aVN8J3EwsDJ9DxmbQ2V4vgEl4cecWrQm9+sYlFD2tJML7X11SlOdToDglKHtvtCohI2QRZpVZm6RCx9Q1GcnSjCSjMaApWwCcxABd08tlPQyLDihmKgXn+VXgDDCGHtGPtjZkUPV/iTYaRwWvVcndsOQ5qubmHfy+RoaUxDDu/63CdLnfU3tt2Lh5gcUYkwZo0E9v8rmxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5wFK2h7boguzbwCL7ki8wyTtf2AxphVmt7KMgEoeMc=;
 b=EXHb1MyN5nbtg5LKvmAsKVGJz4vg7HYuwXkSXeEEc6mXgS+TRIKmI4Rr8xJFC1uQQcYFJR2QzvhpGwrIDhORCmNdsCMlKPK53TZUvNipQ+2Fh4uaZtJ37pHa35QpWAhLwVeXNae672+fIhdkLjkGAwS1jMKtOJa4RRyjJ85Of0n1/yGaGEUZFWur4IZ+bGbZzRRUprrjQ+PYhxTtkIP8s/MR7tN8O2ViTdII2jwWUZj0yp11DK2/Bap2hHSIYUImgarX1cHp4Nl5NYNu079iYZ39qMHTPQo4rU6vPuqjaq2i28VWi71bHjkKsRsZGYtilma0jI6SEJLfwqO90orVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5wFK2h7boguzbwCL7ki8wyTtf2AxphVmt7KMgEoeMc=;
 b=lCP11R3qVPwPcNi5Mny/jPOn2nmB5S1ouruaQdjnZRrCiYPKJFx9+EHdJZo3Pwsj8yWIip8mP0G6phIT5KW0DT/nyBCHODvhcXu2QPGW9lg4adswmZzeCj+gMAJH7MwKyztGieuf4EYLcDdG9FH8b/eZROnfBYtdiuGpLNUOXLBMs8UujNUBv3wm2+o7O4ehTX+evf1p1ilOEIH9SuEDQSIB9kOV/gKVM7w/GaIHKeLx/RRRwG16OPr213HKjhStVsjaQksNtIBE2eUQYlwCtEujHTIAeOS92bzycWAkrb3hqnzhGlA3ZwDThTH/rNJlRtEcqjuWEHK0b9alVzGmuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:55:45 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:55:45 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] evl: Add the new CONFIG_EVL_NET switch to evl config
Date: Fri, 17 Apr 2026 22:55:37 +0200
Message-ID: <20260417205537.2290111-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: f23c7508-c672-443f-151d-08de9cc3b217
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QTHMK+JSHUij4ZqV5tjcp2E0ke2TLOD1hQVcbb/F9kSiyPob/spnl84QsicfA2PRHY8FbJszoFHZVdX9jcGvneRtJLGMrUHOAgkvVJGN9K2N8hdlf02ZgHDzkPWX7/w4L6sbkAUsiCwLq9wUWSQHfePfyl9FJ/o5xIaFJTeyCwAiDWedGtk1Ef+bpus54K17pTQMQLumUDJozEUbrKU9+jUyVdUzRTXIjvZt2+W3KlJ+2+qIJo7ZuMKpefK93pBKpQXaqDBkWRtvXW4ZazBVaBoJ1WsRGzfwgiJqkmYiezZTfxksoo/COYzT6WXPqpDngsKKmQbNZ1Ch10zxdoBt8/50Wk/ZhzY6uo7EdHVZVvWpiflxt2ii/fPE6gmDc31TO1r26TTUcBkRL/4685SAX8c8owNdy3MpeCa9bTfOsLDQG+G3fy8/ftKhQfozfPPgjuo+1vDI0E4A359347rH82+wwOMzlIEgtkzmp0yKuoZbCOJIHWU1PsR7wpUS8/5/4sWKLLElWZJU7zdj0FD/P6K6jP9Cl/qjxrUMI4eJGMuvV8WyvIZZyNyp8Lv0VWTv6URXZW98Ef+PqnVJICH4Tt7GETRqzjA5a0wgISbmHjXNj/g92Yluca6+ooNjHDOwfzpQfxpJzS+QLdQyeEwydsfBvgv8nr2t3x5xoeWVNlttKED7SehUM2bGIlEYefp4GXXS6+nx8iFCWtW6GPoGy40bt3D6f5GOhy+olCHJjG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJV6Hffp8+a/SeCuFm47kLD1BJJWntda1XYuIx/aLIZ/crWK4wnfm27rmxHb?=
 =?us-ascii?Q?66petsKqncD/ow4KZnMKkYVsZq/zxEoAFUUVFtztcAkyX210hUppkkYl/sTm?=
 =?us-ascii?Q?EYb9yXbC9WfJNriVISbCFTnM/u9y61cW331OBwYL2Vu9lhm5ahREysQBetP4?=
 =?us-ascii?Q?6e9ew8JdJBoonqebQsPeI1eLm7OGoGAAYfep+veH9CwhxnSK5y7EPZefizd3?=
 =?us-ascii?Q?9a8qFdBad5cd/Hu97LsyHp8+dPqYiQsELVOl5QJGUbRJVyPoxpSccd6e5EVB?=
 =?us-ascii?Q?twrHwD8oSSpAY1AQLP7UFureofG+NC7NfShI8ELzpPuCgYSFsyp1QpSFV5Tz?=
 =?us-ascii?Q?pezgFRF908etTyulopwq9xF7H/v2cbBkOi8wRGAj3ki2knS9x+VzMTfFOlSU?=
 =?us-ascii?Q?OjwkdYK1167tKYNG9l+GAfFeYtoGmiER4u+u33c5o/PD/DMQiY5YP4Bg9Qil?=
 =?us-ascii?Q?lN+ZyFuO7PosHaKVdj/PbVN84CJu+0505gfNKBxNQJ8pL2h6zCpz96eDRwxp?=
 =?us-ascii?Q?Xou+RZEGlVm8xa587oXNj4Ltuw2Dx+C4TX4tPrODlR9dzM5mupaOOgrQUdAG?=
 =?us-ascii?Q?XDl9TULf9wCV5e6XIZq8aZ2mV1CXZPDTZaBPFyC2Qa1Vn7lkTXdv3XJ8k0H2?=
 =?us-ascii?Q?/RWMbKTEtR5K4vc7iuTJaIF4QPa8Z5v6HpLEDtEj/Tol1Ul64npdQkOmEaiP?=
 =?us-ascii?Q?zkeeFBBqHvPTQ24TyS8zTHWZtPIa/jxYalVx+WPby2kZjQAKCkdIj5cHtHnv?=
 =?us-ascii?Q?S0apRRZHnorBvbxQJcYIlUjvKMYCmMP6g2KYkPsVuIzpWXlOCISaGvSQVieL?=
 =?us-ascii?Q?pq8N+tjjxaFhnZBl7ZGKCZlmH+510DJhEufBET5E6+vkGidV4trdsRmP/5Wj?=
 =?us-ascii?Q?QzUJMnmX6SqVYnF5Ogxh0setbR/SSfy7+6zOARrCROiD0NwPQ111vC0pT1vi?=
 =?us-ascii?Q?or/AJFCy1HeGQ1duuSPAUl6C+qNIRwz+fHrpKNKFi3qi6MPrc9TyJkiXaboS?=
 =?us-ascii?Q?rA5jTO0NwoafaEP1M/jYLdW36/G5nv8Fxa/5pVzuR7kl4SJxBxwFGMM71ZKU?=
 =?us-ascii?Q?v99HvVfirmVEwoiQ2Ut6z6B+WLsnNLc3J9rXAoTGfcgLJxGhR9e2XJDhRJth?=
 =?us-ascii?Q?Cd5w3PAK4ebA1NfVtWKKGuHyEp77BFR9D9cr/T7sciqLRsf2BUf13rkzzyqm?=
 =?us-ascii?Q?DeM/JOcjtNsN7Zavd+6VxLiQLE6x3bMj/CjQo5tlYpa9HaFFcaw0pvWn0yh3?=
 =?us-ascii?Q?I3eQ71rChsxOgyK2oQzw2q0nuzqH2No8ZgkLOxd0OnyQTFYO64MdCT7p1Osm?=
 =?us-ascii?Q?rGjbI6ZbXa9LVLi6DRIWnOycBXaiGZWnboIGJqb+ijPcEpwuh+FJMeKago/w?=
 =?us-ascii?Q?tcqaDXjAHeMmObkTy3u+6PwVxecMY4wIhqR5xPP4Bt0kcReH7YHo6fXSm+fY?=
 =?us-ascii?Q?Z4dlZq/SeRHLKE/O4TXxCMbxOFzC5a2ddAPq0hV7esVcVbKrxBAY4ZEbvxg4?=
 =?us-ascii?Q?UH3+42pNXS6EbtKNnrsb9jLePMuhvl3419BxxwmxW/T8110BDy4iXibIqfZc?=
 =?us-ascii?Q?9op4G+6QU1U8GgoTxJV+30LoxPbsS9/HHP0ceRwjVUzV8hBqlrqz15sySXqp?=
 =?us-ascii?Q?TMqWARYsaqXiNva7Bj6JL4L/vC0IC2k0Yn/w/ndNFoquSXDEQAtgZEh8quS6?=
 =?us-ascii?Q?aXyooHws/hXhM7gDOvmz7s2eXX3+QUl+CsitbcTfO4xn6lUHaBK+eiKqUxt+?=
 =?us-ascii?Q?XmCD0VzSRDh0kTSZ/POGWzmhzjjOpI8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23c7508-c672-443f-151d-08de9cc3b217
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:55:45.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV7U0MSbIEyPcvayFtCTSwxNekDngvh3LQOEIs02cYXgw3W/qZ5pdpQ3FKq9M3lShrxV+n4YSPwRB5uNQp/XpCB6cgp4Wk+pS/qf9vyz+m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

Enable CONFIG_EVL_NET to at least test the build in CI.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-kernel/linux/files/evl.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-kernel/linux/files/evl.cfg b/recipes-kernel/linux/files/evl.cfg
index 65d9b33..a56e4ae 100644
--- a/recipes-kernel/linux/files/evl.cfg
+++ b/recipes-kernel/linux/files/evl.cfg
@@ -1,3 +1,4 @@
 CONFIG_EVL=y
 CONFIG_EVL_SCHED_QUOTA=y
 CONFIG_EVL_SCHED_TP=y
+CONFIG_EVL_NET=y
-- 
2.43.0

