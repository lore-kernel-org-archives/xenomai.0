Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E83845C8
	for <xenomai@lists.linux.dev>; Fri,  6 Mar 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810091; cv=fail; b=O8VFdxVknNLlCwEPqjuPbpYwRArugZ2Q1gSj86s58P+he39pr7qsU0QOA98MrQsK8cQEr1Acy6odUriiGT9pxrEscBgIscAPVArhW1p37calHxCNnXOUjcKuInvv5yDJrl2cH4MJYXzeuHJ4hC533KxF3d4FXhs4sXqTuHJJrIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810091; c=relaxed/simple;
	bh=qJso43MI6aubh6Nnf9fq/jEpAZM9PGN0DFYDQjQyEsg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=syDoUBeowj3I2km9rO0HGU4ee0slQawRqLWVSFa1LurPdeok+Z4HbDa/TF3nqeGbKYBGa55nUPPDEOaqfrHlGJ2P7YYgnnm4vhiB3fjn3SY5UvKWOoKse8fAq1qJysYPjqfULWZ5tC9MLeH4hoMQ6E0iDszVWFRzNiKABCiVb3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gUyA7lUL; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gUyA7lUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVMB44DtAN16QJTbuOALAx1GIc5/7mGye/7bG0vQAMgBuep3WfpjMLot+L4pCxVE3BAI1YuiJTZSbxcNRw11REN933sEI0HoQD6xitlk4WXckWzoMXr4X74BbH3bWUEbpTbwxxIO9pt4SrdX4aqnJXB28pBF1hJSaVhbYNT+hUBEzj8WytEUZms5Jr3iqoF1jhojkxbK04jdlaR9quO5Qd5Yof6tyduL55d5VP7qL0bp9EwDMpjYo4yiBkbH64fe7ROCFn+tvzeATiuMxBESDwdYKQuLPwqttct0aZdQTJVzCTHbe1M7DenIIQ/xL/toagJw+Ft2uHjhLaxqBiG2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO6G9898V025Jy1qdHsBMAkoAJrmVWKYtoH4ZzjbIcE=;
 b=iOxTWWVUaNdlOchy/LWJT+VaQ408tunHlPZF7RO6o66B0VLOMJzKnhoGfT+qRLk6YUEYAZpqeb2vpHOazLb8jvQguUg5QQNzBtF7O+A0LpDdbv7KiNT1PaaYQ7gzJC1v9bx5DunOXK54MgSqj3A9lRa4aBHup9jTGJN9n9hkiWDBADGP5FfDd84x6K+tcBHViF5miejcpNFC1x0KYKhuekfQ97cfHBU7XzXgBGpKdv7bUmnt82rVHuzzG84XGSGMEjJJIm92KEX63KcxigmfM3+yWjNs9biACzn+OnhChfQcpMcmqCWawdUgqj2LFS+ZmnTES3Cgeq8BI4aR6xR4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO6G9898V025Jy1qdHsBMAkoAJrmVWKYtoH4ZzjbIcE=;
 b=gUyA7lULA6BIATO+U+ebTr7xyGo4cGPZbzBKsdkbvwXXLIxzC+hTRMqQw2uzHDJpAFQjssEAaIhp9tSpwYZ/EcWdMOg/PKEKsiMJ8xf22KzJaYNAP0iEiuZFMUtOrVOJ904IOU4etirlqhiNE51eZNxIyizNv2NZ+hBz7qWYMlNFPl4ZbJk4usyvOhpbcyayXrAi7Ix/VCsgqW/e4zz7Y0yrL286tFgtHceSSKOcZm5LFYkCzkofcSfr6i4Q495uOAy0XUG2QW/yFSfQksrJ5n0lkltX+si63wrzbO1I+BZOwm8pLqES9ZbyoL2cVShlZm6aMlW7skJi/d5pCvo7MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:14:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 15:14:46 +0000
Message-ID: <bcb594e0-bb84-4b0e-a7ee-d59b4ea4de74@siemens.com>
Date: Fri, 6 Mar 2026 16:14:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Update kernel version filters in trigger
 jobs
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fa623a-2576-473d-0555-08de7b9319f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	GTq30sXkA1WN1kaJA5Ks2NSJDhQGkwYx5TPbuAIXdkXv/pDqzAQwVnjxkWSzxhz1J5cyideSqVGQQJDW1TMwwJNLDoMpPlTXFXz9GavEOLLmgZItREMY8cfEfbVV8hjk0xN4cfY/GF5XueEfxBeDflLTFkCKsCX9kt5kpJV44zSaeC1e36sdmse0h7e+lNN6Oh9Z7PWHAmtgRLAjnehtNJLcL5c+pwgA0Gz21tFjxHmPVXmaOYhpqHu873ICLR93yTASOKbvgbdIniCdR8YSBHRfW3pndmfaZyx7DITZplDViviL7Hd3S39vmAzAL9Wdugcwv+iOU3Odtfc37g4+iAp/ZyS8UYGYLSnqVyPTl/Ur6YMamwC5sO9rov5Ps1iAluLMQ0S9qDLGn7MbgCpmy/AVKm3m8HZ4pz+Lz7Z5m9TccDrr+W3ZR3J4cPSc8BsDf5F2KwZmus2DKHK6G/70/iDsmERrBJFrkI2TzcejAEYnQ/u8uz08yL9/w2pGZe7Fg5JWUZc39evKGb1ajirnfKz82HIxcacpCHb/QJnCEUwyxp4FXND10qh7nE+a9mrvnKZzth8ReggIdMDbVM941vW7v/quVS/uAF49uhLDVqVItoLAVa3gMmE4vc3NYvn3glPNw7818Hd+/uknyyCgXLlzUzxgvbxm9hc4iKaIzQE1MLlwLhA1/7ZiQbRr+ZTqaun6ORmSaUMBZyjHzPx70JYgu5oe9Q6LmQ2rr0kwvCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTVTc1p3dWVtK1FFOXE5ME9Sb1Nvak40dnYxckE4M2tFcThWN2NWNnYvblYy?=
 =?utf-8?B?OHlUaktWeEF2akVxWnFrS0RsZ1orc0lGc1ZSeXBGYWFDekphRGlnWEI4R3pU?=
 =?utf-8?B?L1FlK3ZDeFJpMW5LTFhFMUJ3dDZMM3Q0ckc1YmNQNkhYUU42bWN1RkFJb2xk?=
 =?utf-8?B?bEI4Q2FWUCs3QUhuVTJDVWhwWUhlMGN6N2ZwMHpqYmtnSXlCSlVFcmluWGc0?=
 =?utf-8?B?ZVJKamprMDlhajVBdktFb0hkMHcwWHBnbUM2Q0g5eStYMjRtdnZwTWNEMVJW?=
 =?utf-8?B?UzdTWUgvNE1JZFptcll1OEFnU0FnZjVyWEFpK1lCbjVuV1Q0NndTbUNGa0ph?=
 =?utf-8?B?eDVWa2xwR21ySlhKdGcvbzBobmt3czMvVnJXVXYxZ0VBQkV5cHgvNjE5cE1C?=
 =?utf-8?B?WHRoamFSYW14VC9ZeWdnMTZuZlBtZnVadFVGV3Uwb0F4aTFqTXVoQStudFU5?=
 =?utf-8?B?ekkwaDVYcTdiaFJnWTd3bjJJVkpOOUZxY3Q4MHlETUFTeDNVaHNwU25nT3Nh?=
 =?utf-8?B?NWRIOWoyc3hqTDE3amR6RDc4aHA3NUNPL01CeEhzNXg4UkxsTnpMMVpCakl6?=
 =?utf-8?B?UGlsSjFqeWI0YVZWblVQcis2RTRMWkh6VTFRaVdhdDRub1VXdnhKT2FKbkRC?=
 =?utf-8?B?WU9IUGdFNFRIUWNQYXA4L0tWdXkyTSt6ZXJ2U09EUitOUkhDSHBJTXdGRDJZ?=
 =?utf-8?B?bjRlZlRtYVpjeU1PRFMzMUVvTWQxbnd6ckFtMUR4OFNnd3k5UE1DdWNOMDQ4?=
 =?utf-8?B?USs0TERsNUtZSU1rbXp4TlVhV3J5cVVvb1hXTjZLMUt1WVd2cXpKWE42c1Qx?=
 =?utf-8?B?Z0FwSG5uakY4d1kyc1RRcGt2MkR5MEwvTXQyUTZkQ1BMR1NBRzJwVWxoTnFC?=
 =?utf-8?B?MWpkMjFhYUxHVXJaaE93aWw3b3BXa1ZsY0tBNFB6WDJzR2xXNGlxU25vVFNp?=
 =?utf-8?B?a0J1a0t1VHRMdi8vamJkS2RKVkZ1K3E3dm1iNWs1UnNIUW5UeGZldGxrY3hJ?=
 =?utf-8?B?ejg2ZGJ6QjdFemlWbEYzbS9lcnJIdXhIMXR6ZElzQnJadFpORW5yRGpuMllt?=
 =?utf-8?B?NkMzUk04TFNLdHEvVDB1M1NBQWdWRTVTdEhwVmRDbEV2TDU5d1ZBL1hVKzhD?=
 =?utf-8?B?a25RbGpFM2d5VTFPZmx3S25TSDRsOC9KUjhMN0hmQUlZY0JQUllFdUR3M1JK?=
 =?utf-8?B?Qm44YnV2MTVyRVdBZWxQdEI5c2Q5cm5nbGRmcEFHOG5VMUJDeWxPU3M1QzhS?=
 =?utf-8?B?WDJjRFJpYTRFcUMxeWgyeUp0eWdiLzFrZTNPTU40bmZqOXE5TmFjbTlLSThQ?=
 =?utf-8?B?K3FPU0NRb2VOOUNyVWw4d2lzc1YvbTQxTSs0eTQvd3dWVXVLOVFQZU5JV1Nj?=
 =?utf-8?B?MEZuK1dKU2RoQ0lPNFVQWVQydXdrZitkTXFmeGdnK3h2dkI4TllRYTYvRG83?=
 =?utf-8?B?VVpGQk9wangwZ3IvNmt3WThKMnNmYlN2aG43blVFc3N4R2pNMVYxMFVHSktm?=
 =?utf-8?B?K3o1NWluQVVBUEIrUzlWQ1pLVVhlOGNVdEZNaEpkeU5GRHhvMUFIVXQ3NXFN?=
 =?utf-8?B?aXlSbUJqM3NhRHA5UVdURlVudlBGc1M5M29JUDhWbFplcGxjUy9qWjRCRUk3?=
 =?utf-8?B?T1hKa1c1NWY1cFlBcHNiamlnaW4zUFJkVHcyejFORERDeC8wTEhwbWNDYmdJ?=
 =?utf-8?B?bWdGQ3N6dkZiak8xa1ZMNFI1QVdiS2JqSjFBS1VDL1g1TjdDcUJGc01GOXVn?=
 =?utf-8?B?VXJUVlpHdWRzNGxCZEg1Q0IvQ2pnWG05U0Y3RHNsakltbTl2SkFlbklXeXJJ?=
 =?utf-8?B?MGJEUUlHdmpjbTRhK3JRdmtES0RKZndmQkswdGI3bFBTd242WkhVdzh6eHJZ?=
 =?utf-8?B?cVNQb3RHVWY4cFhwTm0wRWhUakQvb0tKZ3FDL1RTTGQ5c21yMGRkNVJ2d05r?=
 =?utf-8?B?ZWUyRk94WFovbkM2U3BmTitiZEwxbkhRYnJmKzJzd2ZiRS9XT0E1UkRFZWhE?=
 =?utf-8?B?aS84SkNWdEhRcDFMcGNPNVorT01XZjNYRkE4V3pyYkU4UlRHSmRZVGRxc3pH?=
 =?utf-8?B?SFl3cUxtVzM1dmJrU2FiMG1NVlFHYXBlbFFwQlN1Uy9OY29CSktUMTVna2d4?=
 =?utf-8?B?b2hDeVBVbGxCYnUycDJBOWM1UGtkejRLenZKLzBabTJqQXhPbDlqT3FaUHo2?=
 =?utf-8?B?aFY5NlVsczRDTXc4bEJIL25MMTMzVkZtNW5mUjhWSkQ5a0dCRVhNYnF3dHNz?=
 =?utf-8?B?Ly9CRUhJSDRlM0trbUtaTnFHU0loUHorcE5Kc3FGTlZiRjZjbU8zeHNCaG15?=
 =?utf-8?B?MlhyMk1HQ2YxZGd5TTVwUXAwNTZ2MkpoZEE5bjZiTnlwTk5zTlcvUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fa623a-2576-473d-0555-08de7b9319f6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:14:46.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt6XJQqac9gd1ie0bSr6Qqmm+isqnhUTzimEsMIlHZbx84Mwa8z6yqfGV+dJFMtHoJ9vjhDSn5dV/PxyBfSdMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9482

From: Jan Kiszka <jan.kiszka@siemens.com>

First, v6.18 is now an LTS and needs to trigger its dedicated pipeline.
And second, already account for upcoming 7.0 - up to 9.19.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/trigger/dovetail.yml | 8 ++++----
 ci/trigger/evl.yml      | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/ci/trigger/dovetail.yml b/ci/trigger/dovetail.yml
index b904c1a..60fa2ce 100644
--- a/ci/trigger/dovetail.yml
+++ b/ci/trigger/dovetail.yml
@@ -14,8 +14,8 @@
 
 workflow:
   rules:
-    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$/'
-    - if: '$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-dovetail-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12|18))(\.y)?(-cip)?-dovetail-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v[6-9]\.[0-9]+\.y(-cip)?-dovetail-rebase$/'
 
 stages:
   - set_vars
@@ -31,12 +31,12 @@ set-vars:
       apt update -y && apt install git -y
 
       KERNEL_VERSION=""
-      if [[ "$CI_COMMIT_BRANCH" =~ ^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$ ]]; then
+      if [[ "$CI_COMMIT_BRANCH" =~ ^v(5\.(10|15)|6\.(1|12|18))(\.y)?(-cip)?-dovetail-rebase$ ]]; then
           KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?(-cip)?-dovetail-rebase$/\1/p')
       elif [ "$CI_COMMIT_BRANCH" = \
         "$(git ls-remote --tags --head --refs https://gitlab.com/xenomai/linux-dovetail.git | \
         sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | \
-        grep -E "^v6\.[0-9]+\.y(-cip)?-dovetail-rebase$" | \
+        grep -E "^v[6-9]\.[0-9]+\.y(-cip)?-dovetail-rebase$" | \
         sort -r -V | head -1)" ]; then
           KERNEL_VERSION="head"
       fi
diff --git a/ci/trigger/evl.yml b/ci/trigger/evl.yml
index fe87bcb..a02873b 100644
--- a/ci/trigger/evl.yml
+++ b/ci/trigger/evl.yml
@@ -14,8 +14,8 @@
 
 workflow:
   rules:
-    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-evl-rebase$/'
-    - if: '$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-evl-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12|18))(\.y)?(-cip)?-evl-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v[6-9]\.[0-9]+\.y(-cip)?-evl-rebase$/'
 
 stages:
   - set_vars
@@ -31,12 +31,12 @@ set-vars:
       apt update -y && apt install git -y
 
       KERNEL_VERSION=""
-      if [[ "$CI_COMMIT_BRANCH" =~ ^v(6\.(1|12))(\.y)?(-cip)?-evl-rebase$ ]]; then
+      if [[ "$CI_COMMIT_BRANCH" =~ ^v(6\.(1|12|18))(\.y)?(-cip)?-evl-rebase$ ]]; then
           KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?(-cip)?-evl-rebase$/\1/p')
       elif [ "$CI_COMMIT_BRANCH" = \
         "$(git ls-remote --tags --head --refs https://gitlab.com/Xenomai/xenomai4/linux-evl.git | \
         sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | \
-        grep "v6\.[0-9].*-evl-rebase" | \
+        grep "v[6-9]\.[0-9].*-evl-rebase" | \
         sort -r -n -k 1.4 | head -1)" ]; then
           KERNEL_VERSION="head"
       fi
-- 
2.47.3
