Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097D1A4F3A
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154827; cv=fail; b=fXfJdq7IqKWmqUZ0CQuFFlITFqtKsmWym4SKfs76DyUYAgtXn9j0G+KD5q9pCjoUP9RU+um/xutspvcV2ctw/SIKBcWOhGsjdtnw7/Qi1v4qep/LSLRkY6EDQnB6BYPP2gmEuXxbzMRHR7P+wk5xEYqHwMWs/0QqJUpmqS9aPpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154827; c=relaxed/simple;
	bh=trTdIDRHzSaSAHnF2LbU2y367JbAhPEpLnponYrmCh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjfVj/FQTsOXAhUEg72dR6jezxen2m/A4zr7S1f8KLejtxF80peQpWFsci77Om4aOk79vz6XgWRjOoyOme0r/CCjNOKxtDIFVsYCI1HT2YPTzGlEoFqqbf64LQLGebGcF0+8LLhb/EDXdA6/CLhhRmvju7J5GKtv6i3KCQUTR9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cd0pHWSV; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cd0pHWSV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0QnUzlR2bQC5drWauQH2gEJ2VUVDp5PlI14q//6OP/Nh1WUQRoW8u7Yfau8hFkDsnhLGXo1+G1fytekpmIE2vA0uSJIJbMI2Xt0xGzcJMvl1FcEw0gCI3KD3Wh0iPLtkWkDWZlc0sIIWTOHnrMgDxDnbh8a1zWRD4Mjg6fsq3gCIjAM3oHoK4ePfalvs1QI47eWzUEalfjchmtL7LZnNIFn5Ri2tNDBv5RkHy6MGM++2BaPXfG9yjBoYeS2dvudoZiIYfI5MvxefttEBkMjqlrNW2oE2vaTRXaxJ5sdLbYStjwOeYYpoBJd40wyIv5niESwwPJuVkYLkwin4/s4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP+fAn0rIiStWI9jQ8HcLk8+8Q+df0ORfYUf+N17KgU=;
 b=a0TOuC399rTa3XObA5b7iiyX3ajjsR4MAUYOoF41YK/xTEaAPb1lv1LL8MdRk+G39wMcIL+TLXE0E0pNtf7oQKyejRgx4C5qdXrWVHbe913g7LkX/Cldj6+ilGxictK+SOCIO2ilqsvmDdq6BaECxato41LA9VQ6ACo+IpyTDLEIuoMPcbfhwFV+IY6yWyx5FM4TuOlYI09qaM1AYqdxqj2XMnl8iLctqNsfhsKzGp9y9pRU1f5awXv8cQfO4xXU5O7Igjk4PUqlNZX2jpYbh0h6B6Uxy0iasKQPXZy4uhM5kgMBjhX4FFg6p7+KtiptEddxb2nDQeYyXj16Cf4d7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP+fAn0rIiStWI9jQ8HcLk8+8Q+df0ORfYUf+N17KgU=;
 b=cd0pHWSVeYhC5P4Ey/zZvLH7Iuqey8lkdORfg0+Z5SnPUHZBlLgpr0/JWNKVN9x22NL/eJe8ebCWZznRQtR7KlQM+1Ftp6k3VequMhUegmEs2jOqZ0WkeLJ/M1PkOaKdS3vonTlg9XZqYZ/DH8ctF+rz3sLeuYSa77qdUyN6Y40+xUqtS9DVZemOr9+jELLz5NNDOeherEc4sg7/mtRflssTETLCD6uxNJb/wZCoXja8vSiT1pA/OZTQRDQtA6SVDAw6cLFqc+s1o6lx4aCNeCEAFTJqs2z61sKipp5DLVltUs/pdrnPOVxfoTdszcAxnFuMn7xUF6xdbB0eBswOvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by VI1PR10MB7829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 16 Jul
 2024 18:33:35 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:33:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 4/5] ci: Add latency threshold to longterm tests
Date: Tue, 16 Jul 2024 20:33:25 +0200
Message-Id: <20240716183326.1432379-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VI1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: e57cf965-7ab3-4d10-f45b-08dca5c5cd70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LuSjinhFAErUReEtfDxpiaZMkTFoM0xP0rpx1RTlydRTNM9+HT+qVd1112r?=
 =?us-ascii?Q?OdKLQ920MpPyqyjmMHnC00bHkfdv3Rg5P8FNZK6r3dndG1eaXmg0kfyepryq?=
 =?us-ascii?Q?kndJzu41rUP6/6EjIjOuPYmA2n1VpvVSZtFQvqA9gX+sUb6Nm2lUM9TD0chA?=
 =?us-ascii?Q?p1aPEo+CllJFNj68qe3U8diDthRKzs2vKj1Vlt+QZuNqBvAiAEAC/mSukl34?=
 =?us-ascii?Q?DCdFIaBnekECM9+y5g+JXY2e7RfVcyrvVdnYUv2jwCW7oJnToEAXAZBAUIe4?=
 =?us-ascii?Q?gxeW9GLEnYIXe28LKVBPiYB5ImFXROI/TD31kHMmmOv7fC3y9990VaBKnTIh?=
 =?us-ascii?Q?AH9NF/BLO6JgS70KSE/A2aLQe/ebigzeCnYrDDNCRr4MgM7blem2AZ2hqhRa?=
 =?us-ascii?Q?aKWc3ACigBvR5tMCjer3Aibc2Tsm4+g21z5MMhSqDvt5ZwQSfpLJCpg+CGOJ?=
 =?us-ascii?Q?adX8Ps28DXz5Fm5BXy5kgbMy3snhOXtn76tPCm0Z5y8Xn3zZBsQFpqS+Q4Ob?=
 =?us-ascii?Q?pH6EY5+1TM3t2H1a1Yo2tvJbiomjWSiGpLpzlMzGrbhTWy+OfepPO9XU2ffl?=
 =?us-ascii?Q?B8OMw3vcMmE1GhizzEPyEYvrGm43Yv26MAB12WT+wNZlm7P0I8TftflS0I2W?=
 =?us-ascii?Q?SONfHHHee8zq2vUEw/i0pd9T3yC1a4U9sYz8cdA66EOqC3i7VjksU3d4vM58?=
 =?us-ascii?Q?kIJ7omlAogE93Ih7k5qA5JP0HejcFTDw+G8XGNrA7PW9JafMo/UEURVFIidO?=
 =?us-ascii?Q?EdCpOav5yib+zXFqcDZ+PXOQRMQYtWd3Q+qMpxQJR2/yTbkjbk3IbrWDUL1G?=
 =?us-ascii?Q?RxR5mocHHUy9VkRcnT6obvb8QTXCdPlz3PKuDi7oq33nLeHx4Xx41LmgkVdM?=
 =?us-ascii?Q?/nSpdNRGURH0mQ0jkxCWTX8TJeTU8OsNTd415PHvGT5fg7g7JsXonjb6R3gZ?=
 =?us-ascii?Q?MLkeBoTbPEphf9139HFcMF72fnS8PdPB+cGxUOmdmTuTbcpMj+5SQn0kigo2?=
 =?us-ascii?Q?tJMphMiu9eHxaeX5iYxc+Q0LdZyt8Cv0HZmBssehaRSxOyNqAbXhoiBmkihc?=
 =?us-ascii?Q?hZBjWJSUN5cCfKlXP2BvGS5shvt697+hyf7EpO96hxM1NWWQ7PMXqwz3QvSQ?=
 =?us-ascii?Q?foxffRMsZD2+1oXtCF78RIPZHwOZOuRxj+7OnzihmGJKK8qrTUT42L9qu/o3?=
 =?us-ascii?Q?FOjKlRcMjshCP4oJbYWGMAWdl0MTZp0wkaWltV+hohGCbkOPk5LVmCD14vTx?=
 =?us-ascii?Q?CgK1591DYl2Wz/D0jFZTPevUEDY1usz/zwgAisqRXYkEn8LhxYplYYazNJ2F?=
 =?us-ascii?Q?zDdRrU1g9WPRhHSzmiwiziL8LI6VibBhOAxSIWay2bqXIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xk/YtRUmUAZlxyKI9t1UNFb/pVNEbHCluo8pce7jAHCQqceYnI2dtjrVzsPR?=
 =?us-ascii?Q?fTwY2oEV8XABR0wLtiHbuk8iZxg+ktS0iyUSxzicfSrGL+C0vbI11KiLswel?=
 =?us-ascii?Q?jxhzTBv4EZl/UhDIcqjg3dKtFtFK2cfdmlngDxr7xSqVfQryy1zzeErtjWK8?=
 =?us-ascii?Q?DWk5hbw6UPgd9Gvrp/aKb0Fo1UleFUm2ca/k25PkUKcun0k8NYFVBbqUhRKn?=
 =?us-ascii?Q?CYxTRndAyVj/o29VTOAerMPLEZ9LC9aVZfUWyo2c26T8yKr1fl1UQhaOgcER?=
 =?us-ascii?Q?se51kYVUGMX4kXqMYjwq7dlD3T2D7xJGYyg5eYM1GGwoYnzMZwgGmGhEqVM5?=
 =?us-ascii?Q?QNawWIOrLx04QluegSVS1oSvrHcm8A/Zyx3VTcCtYGt1dJVsrbCK9/MVtrw8?=
 =?us-ascii?Q?Ef/jd9W6vDArYiWNGL9wpqI54jnkaTNk3nTeZxNMIUqnJViuBzRdZapXzir0?=
 =?us-ascii?Q?EgbQDeyrza018vpEtOVUK92xN9tytLCgmss4ZWc9jG8BWAUKFkEfqG5qEKEZ?=
 =?us-ascii?Q?PTROorDWL9DFF3fIhVN7PB2o1GD3vb/tdWKSdCU9wwI3Br/0HPj9imvjrlQd?=
 =?us-ascii?Q?AZ4fx9jKXHrNT8ytud57reTpoEWn2VpJSaai8q80SSu5a5qN9FObgds3eD+W?=
 =?us-ascii?Q?//0M7CHesD7SAJt5t0O3LsRGEW8t2j0u05uRDpPXC+/wGzhY/x8TcAJy+y/f?=
 =?us-ascii?Q?2wODsbbcxBrN3vnzyGebwa8C1r7EIimqnppAL63NDR2UGRhgd/AfdfLQAcIY?=
 =?us-ascii?Q?Ayga4iVNKZv18GypC6v3A/Y7LGNKlBr7NEbzwkrqN7J+BsARESMgXbHHssjL?=
 =?us-ascii?Q?T2vUfIPqAaks3cnE3AI4mm7+SzbsmAJfhrXgmU5Fh+g7Eew8IPCtz2m/cOo+?=
 =?us-ascii?Q?Y4D3I6/NQ4oiv0EbWUabxx5ukFCC6bNn5Op9jlKfce6XlUq9TXb2XGmYDGsO?=
 =?us-ascii?Q?8gkV+gcwi6tQ7iO9DbJwsrYD7Y4uUTeZ2UL+cQAaj+Lx+lMYJCozljYG3/fM?=
 =?us-ascii?Q?kp7L2VGOe/AS38n1psvgX7BJ2eMp8g1EXURCb67SWvQMAGDa9vkGMEwrfl9C?=
 =?us-ascii?Q?2j4C7xdszJ47J7p7lAUu38xLycm+UFCSd7QddrqSo5WCbcXyeSPMCID8RZee?=
 =?us-ascii?Q?ObzX8u47pJOHCbTEwIRxnS2WQ4ZashBWz0ORdv1ubX49ycnsJnK8A4oDgcfW?=
 =?us-ascii?Q?Vf731MPnS7hp0uzhYzGvsWngxRY4U0idNPUKVuZsOBqEEnSD/FwytlGVcYTh?=
 =?us-ascii?Q?kyUFrDtm0fdwQ4gVy/1MDSl3JjmUQ1JrMxD3ffTlK/pYMaes4QrqxPIV5vg2?=
 =?us-ascii?Q?QO/ueBL42WmdkcdZIYlad4yluWczECVNYu1czlxMBIwsiX5F8I3b0DOBq3sR?=
 =?us-ascii?Q?tWdH4CsRh1Ezug3CeGcKeaYma6cb0jh3gn7GIhVsAtehaBI68stJZmSs2RfI?=
 =?us-ascii?Q?stvAIH0GTyi9kA3X08Sb0HAdapArWZzRdncUwib9A3TKjomuaAW6CCGtrKfW?=
 =?us-ascii?Q?6shoF4qJAqKPfx2zGgR0gQ9LXEL68pa4N5HQAwxulj2zYZHpnclV5jo/4pPk?=
 =?us-ascii?Q?yoDsOyLKTb9esEa5CYhIPQ4YWOCW3ZajET2dj0kR/DlGzofg71Q1LQdp3zfA?=
 =?us-ascii?Q?9NOZQXBf2RpdX3LF27BoUI39bPCzIOuf13fHC98qo+TmEtyzZ4SxIkQ+knQw?=
 =?us-ascii?Q?TMWoyQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57cf965-7ab3-4d10-f45b-08dca5c5cd70
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:33:35.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vxj4arawm8XNHPuGOMieMmad1xB7zV9uJma72AIrN8eL97QYzFnM4PknYji0UoBDcJjSF20jxfDDvNXRSSse9M1cbgzkSyrXiJmnbK7+3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7829

Add the latency threshold patch to next builds as long as it is not
merged. Use the new threshold option in longterm tests to guarantee a
worst case latency of 150us.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml                         |  1 +
 ci/kernel_6_6_physical.yml                    |  2 +
 ci/xenomai_3_next_long_term.yml               |  1 +
 ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
 recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
 5 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 29960b3..bc9d525 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -22,6 +22,7 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   TEST_RUNTIME_SECONDS: 300
+  TEST_MAXIMUM_LATENCY: 0
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
 
 default:
diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
index 95fc4f2..e57eea0 100644
--- a/ci/kernel_6_6_physical.yml
+++ b/ci/kernel_6_6_physical.yml
@@ -21,6 +21,7 @@ lava-test-6.6:rpi4:
   extends: .lava-test:rpi4
   variables:
     KERNEL_VERSION: "6.6"
+    TEST_MAXIMUM_LATENCY: 150
 
 build-6.6:beagle-bone-black:
   extends: .build:beagle-bone-black
@@ -34,3 +35,4 @@ lava-test-6.6:beagle-bone-black:
   extends: .lava-test:beagle-bone-black
   variables:
     KERNEL_VERSION: "6.6"
+    TEST_MAXIMUM_LATENCY: 150
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index 5fb0de7..e3740f5 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -18,3 +18,4 @@ variables:
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.6"
   TEST_RUNTIME_SECONDS: 3600
+  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"
diff --git a/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
new file mode 100644
index 0000000..6adb7d8
--- /dev/null
+++ b/recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
@@ -0,0 +1,76 @@
+From 032a29ccb649cc2d076f14e7769bdee8eba8ecfe Mon Sep 17 00:00:00 2001
+From: Tobias Schaffner <tobias.schaffner@siemens.com>
+Date: Fri, 21 Jun 2024 09:35:08 +0200
+Subject: [PATCH] testsuite: add latency treshold option to latency test
+
+Add an -m option that allows to set a maximum latency treshhold to the
+latency test.
+
+If the option is used, the test will fail if the maximum measured
+latency is larger than the treshold passed in microseconds.
+
+This is mainly implemented for CI long term latency tests to
+automatically let the pipeline fail if the measured latency is higher
+than expected.
+
+Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
+---
+ testsuite/latency/latency.c | 14 +++++++++++++-
+ 1 file changed, 13 insertions(+), 1 deletion(-)
+
+diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
+index 7856b48b8..52e315d9d 100644
+--- a/testsuite/latency/latency.c
++++ b/testsuite/latency/latency.c
+@@ -89,6 +89,7 @@ int32_t *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;
+ char *do_gnuplot = NULL;
+ int do_histogram = 0, do_stats = 0, finished = 0;
+ int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */
++int max_latency_treshold = 0;	/* default = 0 (diabled), -m <max> (in us) to override */
+ 
+ #define need_histo() (do_histogram || do_stats || do_gnuplot)
+ 
+@@ -536,6 +537,12 @@ static void cleanup(void)
+ 	if (histogram_min)
+ 		free(histogram_min);
+ 
++	if (max_latency_treshold > 0 && (double)gmaxjitter / 1000 > max_latency_treshold) {
++		printf("\nMaximum latency exceeded: %11.3f > %d\n",
++		       (double)gmaxjitter / 1000, max_latency_treshold);
++		exit(1);
++	}
++
+ 	exit(0);
+ }
+ 
+@@ -614,6 +621,7 @@ void application_usage(void)
+ 		"-c <cpu>                        pin measuring task down to given CPU\n"
+ 		"-P <priority>                   task priority (test mode 0 and 1 only)\n"
+ 		"-b                              break upon mode switch\n"
++		"-m <max>                        fail if the maximum latency is larger than max\n"
+ 		);
+ }
+ 
+@@ -648,7 +656,7 @@ int main(int argc, char *const *argv)
+ 	cpu_set_t cpus;
+ 	sigset_t mask;
+ 
+-	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:b")) != EOF)
++	while ((c = getopt(argc, argv, "g:hp:l:T:qH:B:sD:t:fc:P:bm:")) != EOF)
+ 		switch (c) {
+ 		case 'g':
+ 			do_gnuplot = strdup(optarg);
+@@ -722,6 +730,10 @@ int main(int argc, char *const *argv)
+ 			stop_upon_switch = 1;
+ 			break;
+ 
++		case 'm':
++			max_latency_treshold = atoi(optarg);
++			break;
++
+ 		default:
+ 			xenomai_usage();
+ 			exit(2);
+-- 
+2.40.1
+
diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index a2e8802..07a63ec 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -15,7 +15,8 @@ require xenomai.inc
 CHANGELOG_V = "9999-${PV}"
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV} \
+    file://0001-testsuite-add-latency-treshold-option-to-latency-tes.patch"
 SRCREV = "${AUTOREV}"
 
 S = "${WORKDIR}/git"
-- 
2.40.1

