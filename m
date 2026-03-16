Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CA3ED10F
	for <xenomai@lists.linux.dev>; Mon, 16 Mar 2026 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691959; cv=fail; b=ZwJ1HMn7Avilc0mIq71+IAZiZdLpPhx/9XgU3c42fjR3W7sOAk2J9l8T3snKDaBxjj7CumHpom4eHV2dBz7AZexKptT8vyoCsHu/m+731CwcXVUnhMooF3Shyl8OjZMI9OCWYeVOexwjtM7aA8HCk63fjh34kqlKWZjzWeu65uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691959; c=relaxed/simple;
	bh=3/c56+00dRHrMYYOOMXmHEDRG8q0cFKR29kCbzaouIM=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=EiUfo7P0zCkaE6XxPCPIXgfnWIbYC/VnnWXKRxARs898P+Dhli0zOKaIF6OAlWAi9gRLnsDKvvLp6MohTRzOxafH8JxMZYydVUT18rVRbLDo+PjERizqhvZBqNDkbV7UAg2F9qkKXM66O9HUsmwNIuGeCNkW+F2iJNdQmCU6RfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jjrSRsKx; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jjrSRsKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByUbeoMmPsLtRgmkwKeQho4fXnoVXHQiUZoGzcn4oP58xd/+r8MBY3ILuEHNwOnlMuzOzdzejvEb18Eb6ZaQNdbrN3zeRS8yz6z6Qh1ZOQ8K1sNkcxwPTMHe7aOW6JMEY2YOnkz8V+bAso6nCRVqlLVInPnO/WEXrIlWVo03SGzf8sUatwHYjIndYsPh9PVhv8GnhH1En87i5XQ/R6u3RYQL54QVCHAY/G5NRYnhDgNOrV+Nxl+a4J3Y/9nOhfIW4GxmYPqqz2Lrn1+ZCDOCjIlbRCdcux1MpJGLlIjxex7wFvdnr8x0/c06PcQWV6FsYj27IBygXcojcRA2VToM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoAisaS1Ne4efDC7zljODq4Y+mzErvvzbcR9GITJImM=;
 b=zKQDyHXpn4tkKW+76/C7jAh/GgJSozT0KMOvooc/upaD+9y80Th2OFYARls7j7cHDUlQq5Vy11UKn+by9xW6nT5wBtcra1ZGhKqE3G3jtODKQipLTftPcfW66wmikpdSf0mzE8pQQdIHYneUEMvO+hHQ+Nsv2xoDIJGBRc1ewO2gofsikFXcx0aqZ1bqN+s3YTWZFhuMMT1yZN72927Nw5/Fa5e5Jn19+McfOJeuequnjRQuGI9QE/CbWiWpkvc5GkAIBZFtcPOtn/rTZHE+VyLIm5R6+wKVvs6fiSPQCqCVObNLvMiGYoimRUjDtuzvSstOPG2nVVlZg66MMrJCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoAisaS1Ne4efDC7zljODq4Y+mzErvvzbcR9GITJImM=;
 b=jjrSRsKxAZVFN6dHZl2KoLhxbOzM2eb4qtw4SGD32/QmML931f/aDmB7AMf61euyuWccyZv//t0HVZcBqx0BTNMzc9e+1aHXdRtDqakFzZOGwaGVgdVA9GujtAt4pyHOzMHJ7LBtPDCAOqHD3QhUAuJRiWkpGaiWCbaO76yWuIKYkFcZTSZNVXVa5tRcPMd7r0SMWP+/jXbuy+gYg/45mos55kHUE6F6DAS1Z+DauTKsOfOEsCa/gcyXWg+zv5W99Vzathc/d50r0gVnRyMrYyD4/mCZQ63GnlJcGb8GiTvCOeeRoHsJ5sZTLW9p60GEeB7xCcVK7n49uD7558TFCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 20:12:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 20:12:34 +0000
Message-ID: <28121ce6-1939-45ab-836b-15aa782fc4b6@siemens.com>
Date: Mon, 16 Mar 2026 21:12:33 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH v2] ci: Give pipelines a name
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d400d3-1450-417d-ac50-08de83985c7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	kf5OdNOUz7jA/rosYlGI3/wn7YIuFdfSITAu0gpn9lOkGfYCt3QdY678wsWaTHDRDpg2HcR51vnzwqcdJrKaQZNx1ZxZbQN1PIfS7hFT26eWg9u6+bEE1p2VtXqIZxmkb6i8Q06a/qcVdk+JrorHyzWtbpQPH3Az5eou6y4PAU0zggBVdRYLqc0F2rx8Rbdhac58lfQCn1nXAnixL1bswJl6UvA62pXHqbjQOr61KDvMMTOWFlJDrvUggXo0NDpwH3AswB+ViOUBq6HQyIYvx8YeMqmyTBfGkStnaTk+YzxNH7qaKVVJFiT0WpuYE9M6RTVVAry2mAoaYps288EBbmmTAQU+rL6cfQV+QMhbLUcFOWFSPHk3vJMPkyTZzdr3KnZkOnm0KEevQAhq+fJMPOJvDi1wSnXyN3LIt3LxaIgKWrFKsopJsJa6sdYm6nAlbHTe/W3KPYtL1DHxNK4990Q6y6+qKaMVgb2rwCNMpW6UO0KemiI9EMnDnEhERkucVaQrfxsp6Jdd9Jc+WO2X+87VvqbDpEMZ0W+HgrQUb7RgT7dYuViGkEHlf6dgJJbqJdW2kcRsJt/l9K2u8PHuzg1ntqNzavRPZTDr8b9PLvFv3fHAlo1gItqEk1QVqE7g0buCjTDsZXj9odpY0kInRwhl5Vhgr4cfJ9WNBetLJgKuMxvsWOTTqe+Olmjk9cV8hCVmH3clCy4BNjuNaPMrgC32MU+3C7ucXlZN2Cjh7U4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SCtIZlJGUm5aOE1nbFhPS1NVaWg4MzI4Sko2MUQrUDBCTzcxVnFBMkFFdno1?=
 =?utf-8?B?K1U5TTZmUzcxcmRoeTc5cG5CREtzWjhmZE92ckY0dXZQOFphb1JSSGdHSFNV?=
 =?utf-8?B?TkpDQ1U2U0ZnRERtTFF4TnNzbkh0eU0rQ1RYZVVRSHREV0FPWTJPcXJJaXVS?=
 =?utf-8?B?UU1wU05LSzZKeWgrQ0lWbVdROWcwMzFtM1lOZzdxd1I0MlA2ODZoZjZSL2Fz?=
 =?utf-8?B?M081SG04MW5lek1WcXJNY1NyVkxuc2FDTUJNWld1c3RyaXpiU2VkUFB3M2N1?=
 =?utf-8?B?bm91aC9FVWFkbGZ5Qm90dS9PQkJpRDNuS2Jmc2pkWDZWeDREdFQ4aWdkSVVa?=
 =?utf-8?B?VXRkOGpSTGRKdGFhclI2WlgzRFlWMVVOQjhoNGduOXk3NExyRDNLZ3hyTDJF?=
 =?utf-8?B?Tzc4NktYRG9OOCtOUUF1eTlKODd2c1Ewck1FYVpVZzRCMXV4ZXlsNEphU0pm?=
 =?utf-8?B?MERQS3FtRmNQYkhOMk9Md1VGYitJbFJmV1hRRUt0c2ZXTmRmK213Q0hwcnZs?=
 =?utf-8?B?Z01rYjgwZUxWRWVFZTlRSHNGOWhIak9UcUlvUVp1Znl2enk1NE1QNWNoR0lu?=
 =?utf-8?B?djNLdWNkQkZiOHZRL1pWTEZ0a1ZRK3IwWTd1Q1BvV01nZTMxT2NvZk4wQU1C?=
 =?utf-8?B?VEFsdXpBRWhDdGdJN1JHZXFjL3JScWRoNk80b2EvS09BWTNKRGhwQTk4R1Yv?=
 =?utf-8?B?aVJJSE5RaDd0dHpoNmQ1YzZPWXVES2RVOWRlOHFxNVN4MGRPRzhCeXJ4ZE5i?=
 =?utf-8?B?TXM4SjhUT0l2dk1EUGs4K2FlZDBQaWpYZFk0alZxUnBSUGN4Y3IzOVQzblNC?=
 =?utf-8?B?dFpsSEpxTG5HeG5pZlgwaFJidzN6eVpnNEwwczQ5akVTK0h5OFNwOFdlS0Rq?=
 =?utf-8?B?MVp0T2xTemV2YnI0MlFwQjVUbTN2UTNqV0FsdzY2Q1RudGlna0E4Ynl4Wnlj?=
 =?utf-8?B?ekpYa3FsVitGeXc4cDJZNTJTMDdMaEw2VEpldHZYOWg1NmRxVFhZMnZkVmdz?=
 =?utf-8?B?Tm5iSm13aDR1eXMvbkd6MUN1Y2pzMUNZdk80QzdlUVN1VWhPR0F1MVNIVm1h?=
 =?utf-8?B?cVJtZXRwaVdBOVdtZXdRb3B1dDNWNWpFVzU3Y3FzYXdFR0dsRkdubmUvQkY5?=
 =?utf-8?B?WXhodVIrZWZYNm9xeWF2ZVl3L0IwU0R2UEZlYTdCV1BlQXVFcUNoV3R3ZHRr?=
 =?utf-8?B?ekRmZUw4eUF0RGF4UEdtS1dpb2JyY1RBaXVxY09TSE9PLy9xY0tKNFFSN0Nh?=
 =?utf-8?B?UlVmUFpWMTY5ZHZMblpKUER5KzBvRTkzY3BsSmFNdlRLNG9SRThXTitaamt3?=
 =?utf-8?B?TzZuUmhlKyttS1RyZXpLWGZkMW9DQ1JoTTUyQURCa3pqUENmNm0yT3VIUmhC?=
 =?utf-8?B?VEpsZFNreG1oKzFacndvTUdvRFZiQTBKWldxcWFFREVnSEZBcmRHN2VGMW96?=
 =?utf-8?B?MjQ0MUhnaFhYODUrR0E1dGVGVVZMUEdLVlZoQkJXWkR2S2VDbXJhREdKMWtW?=
 =?utf-8?B?VmhtaStpZnhoUlJRVGtnTEM1b3FRNzRRQm9DSXBiY1RwZHFGdUF4S01mVkVi?=
 =?utf-8?B?cjNRMnhRcG5jdXpIYUpaeWZPVUdPVDNSamdWd09nNlVQcExaRmo5NWN5RmE2?=
 =?utf-8?B?ZmplSnprVEcxWTRYMnVFNTU0TmFOc1NReG5sWmVnd2FLeWdRa0IwS3Avc1lF?=
 =?utf-8?B?dEd4SEJaK1pMaWIwRnFOdzZEeFZxbVFBTlZsOFI5bWhCSElHRW9CNFVacmxS?=
 =?utf-8?B?aVFmaFdMaUhrN1o1SnYzTlpmOFM2QytJaDlMRUFvVFhSTXVDa0xMalU0RjR5?=
 =?utf-8?B?aTNmOFR4bk54cDlESUlRSERNOWVhSWZIZGplZTRRSGw2eDQ5NG1udzZ0TVdp?=
 =?utf-8?B?alhmeC92K0hrakRMdHZoQ1ppUGc0STJxM2JXK1BqNU9PREFHWHhlbGJFRjg1?=
 =?utf-8?B?aVkyK2JYTHRFRXBhQ25YeXFUU21YNktIeGxtUUFGYzZ0aTl6UWpSbjVQeldi?=
 =?utf-8?B?SVI1cG5GUmZPK1JHOHFCSW1wS2VyWDZieHkyWU5UZ0dGNGRQZ091aEtsRENn?=
 =?utf-8?B?bkI2YXRUQzhLMUVCVnNnVUdWTkJlU1hVVkgrT2JzV0RMdHZhRGlwaGhJYklY?=
 =?utf-8?B?QnBUTzRFRzN2Skd5VEVIakVlOE5KcVMreW9RSExRSkJPN25XRnhWR0R3RFdH?=
 =?utf-8?B?aC84dVg2a1RRODNWMG9FUldQd1l4T1JjWHgzMUN1L3A1KzYxR1ZCNFVIOG9H?=
 =?utf-8?B?bTdFZlZiWGwvdlBoVG5LcDU5ZG9KNmF3QUZ5by9pUHZPYXhuc3Zpd05ibW9Q?=
 =?utf-8?B?Tmc4OWRHWlFUODRib3BPelBhb3psQ2dTMWZmeDIvU3N3SkxKYW9SQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d400d3-1450-417d-ac50-08de83985c7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:12:34.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1RLsVz2HRpoaZd5Pp5cNUIDrHR9cyEMb9Cz5xiGYUNLjxM+8TaaavGmMKqUunV77vSojwVUSbZvbXtvaOOAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7989

From: Jan Kiszka <jan.kiszka@siemens.com>

This should help to identify why a pipeline was started here, regular
push, external repo trigger, schedule.

Requires that the xenomai 3 CI sets the TRIGGER_SOURCE variable before
issuing the trigger.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - drop inconsistent quotes for scheduled runs

 .gitlab-ci.yml          | 20 +++++++++++++++++++-
 ci/trigger/dovetail.yml |  1 +
 ci/trigger/evl.yml      |  1 +
 ci/trigger/libevl.yml   |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f810dd7..b3d025e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2025
+# Copyright (c) Siemens AG, 2019 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,6 +13,24 @@ variables:
   LAVA_TESTS_ENABLED: "true"
   ALL_QEMU_JOBS: "false"
   CONTAINER_REGISTRY: "registry.gitlab.com"
+  PIPELINE_NAME: "Branch changed: $CI_COMMIT_BRANCH"
+
+workflow:
+  name: "$PIPELINE_NAME"
+  rules:
+    - if: '$CI_PIPELINE_SOURCE == "pipeline"'
+      variables:
+        PIPELINE_NAME: "Trigger: $TRIGGER_SOURCE"
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
+      variables:
+        PIPELINE_NAME: "Schedule: $ONLY_RUN"
+    - if: '$CI_PIPELINE_SOURCE == "web" && $ONLY_RUN != ""'
+      variables:
+        PIPELINE_NAME: "Manual: $ONLY_RUN"
+    - if: '$CI_PIPELINE_SOURCE == "web"'
+      variables:
+        PIPELINE_NAME: "Manual run"
+    - when: always
 
 stages:
   - parent
diff --git a/ci/trigger/dovetail.yml b/ci/trigger/dovetail.yml
index 633ebc4..b904c1a 100644
--- a/ci/trigger/dovetail.yml
+++ b/ci/trigger/dovetail.yml
@@ -59,5 +59,6 @@ trigger-xenomai-images:
     KERNEL_VERSION: $KERNEL_VERSION
     KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-3/dovetail
+    TRIGGER_SOURCE: linux-dovetail/$KERNEL_VERSION
   rules:
     - if: '$KERNEL_VERSION != ""'
diff --git a/ci/trigger/evl.yml b/ci/trigger/evl.yml
index fdbd15d..fe87bcb 100644
--- a/ci/trigger/evl.yml
+++ b/ci/trigger/evl.yml
@@ -59,5 +59,6 @@ trigger-xenomai-images:
     KERNEL_VERSION: $KERNEL_VERSION
     KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-4/evl
+    TRIGGER_SOURCE: linux-evl/$KERNEL_VERSION
   rules:
     - if: '$KERNEL_VERSION != ""'
diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
index ece5f06..bb996b4 100644
--- a/ci/trigger/libevl.yml
+++ b/ci/trigger/libevl.yml
@@ -19,6 +19,7 @@ trigger-xenomai-images:
   stage: trigger_xenomai_images
   variables:
     ONLY_RUN: xenomai-4/${CI_COMMIT_BRANCH}
+    TRIGGER_SOURCE: libevl/next
   trigger:
     project: xenomai/xenomai-images
     branch: next
-- 
2.47.3
