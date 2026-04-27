Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1C3382C8
	for <xenomai@lists.linux.dev>; Mon, 27 Apr 2026 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304644; cv=fail; b=FGzpDnPDLCdAGGjWD8TC/38oCvzoUnU126Z40l9EsuOKIP7jrm0Vet4TLVc9XeeTTSz2yoSM9IkdsLhAhUoe05Np6wkEgpol86zEi7mC4/BJnsUJ9loFXCA8djQ3454JMY2yZjrkfrDV5FVc3vhqWtvXE83S4vsvryuGSmXvfzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304644; c=relaxed/simple;
	bh=wlN4g7AmBVyHjLb5YSoY114qO9gdKymQ0BA4nG07RrQ=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=UcAtE64Gg+7zyOFgjBbp4J7npLS+OkGOJsX9aN/o5OTB0n1Pniv2ml9pUGXveq5V55ethpEoY4hpy2AVv+bDXiyOtEXlgGWvh8WnPTEKUGAFHqlmU4/KWST2neH7i2SXNNVDvQ7Mk8GR2DPOaJW3K4z/tYBb6HobF3wfZT0X7zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ouden8vB; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ouden8vB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iki7HuHQE+sJbqSbhGQAanih1WmszZjND8lEISzNCZeR55ZEU33ilj9tjDKmYoCoIolaBS/AObteUjOmVvpSW4qbJBoWxxl+mzCOy5HDUW966bf+gtYSt3R3uSyAiw0LNY0Yn4CN61QSPpnHYk2m0zY2oFhsi2Hg/AZAiFzKjQof5KLWWm8/34ctQ6HCPFObbn5/wL5YWbaYqvXYfZ95egYWKmVh6hj3OQ0l6R86TYhSg6d4tdjxCfnWePhoMmkMr54bE2OJKi0Idm+OyDN3Id0jASa5OysqOQJVR1lTMpwH61ubF5SCXZ0919+aCIzZupb3m9dt/zl382KRIeaeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdbxZw9sMpoB5mxBSq8+WIXneQOP5j3/H4skYDdMagI=;
 b=Rt17KsVTR2brZ3gXw/5bTxLjPZKguv3SQenxJWRVk6xdMlZN8H0JDUV7LUvQTHPghCSnPHvqIYVcTD84TdP1Uf0bFZiqkaAT03+xzu2ZpfCBaUQETeuiAGBA10+3bFJaFiWDKD0ZbQBdJ9Be+xfz6otn7pINXtNSktfknnOC5ruTP2cooD8kz1RIyrcv7c3Puhas3o+FmngA5ezLsoiiZ+1Zl7YDnFbRytUPVqFd9eDcGGDszB2MPSBfmBXEpJ2yQklVWwS9LHonZ4qNjNHDk0397l0jG5LLu7iLJs3q5h5SqjpWmCfto+6WjhAK8PoWa0TR/a+wCsql7qsf7dieow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdbxZw9sMpoB5mxBSq8+WIXneQOP5j3/H4skYDdMagI=;
 b=ouden8vBNI0P3Ffr8LZvd/E5n2dbxb3KjnHeqQiW9F+AOHmN9zfZHUK/nuorORiJBw236fHStkXMC3VzxW5TfwCwfmPIxdqUHD2opIpZsUD5iw6XT+a87UUBixoDqohBdm3VHv4wN5eYTO5g5vur/V7dh94KNmtk3ot2oOP0goOtuHXvnwSSYeIDF2jNAkUyTEnNsMF+chly9RgJn0sYoVF1qqehdNzXAwqBMq0aYseoLQgEo/vpUsHuAzYGtRmqtj7+kTjdmAGGvbz9XLRCfI0nqKc8Sk8KqUl4Y60PCOacqqFRUr6c51TFSsppphIrbBUbwTQbz6PfuoaCVFdDQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9202.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:43:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:43:59 +0000
Message-ID: <8ef3bdf4-90dc-44e2-a972-347874209b57@siemens.com>
Date: Mon, 27 Apr 2026 17:43:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Switch to Raspberry Pi 4 with kernel
 5.10, 5.15, and 6.1
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 421e81b3-0bee-41ed-ce5a-08dea473cc8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	xm5vpzBdXCJTs9fgiy7MY/7PAKxiW+NLsGIDvOJH9e9eQqd5Zrg4wvg6eJ3GKgfhmcPLnHiZi8xtwCkOR+uzd7fQN/ycdRUl7RQZXXjeMOzzNB42OR7OqSCQbapULfW86ikcBIjKH2O5vEcc74mC10xYjopuUc6WlsTYsGeLCfRl0DhM5eEAnzjYyLW8kOhfQ1xFfAvGVAUIcxCiWqyreiEBh6met0OuB0WRS+CSZvT+avqS4tbUwJBRs0RZlb0gdw/EvBY+1CqVjV0DzOdwlDcOmQ8PuBHzR/q0lQG6/y0fE+FKPqpxBrmK84+YFjUHIWS6z8X6Ty+H2QGSnQ+S+pH6fJw6iNtM/Q1zfWNrLd/NwIY9D6wEoRVh7o+aULqxB9CAgbzQEpmRaVUcaVWt6cZq/ndoS+m94CZ8U6iumwLZwPQoBk/MuU97TJC9qKZ0IFshv5YLko0S4LbV8bKm/M6b1YQoQ2pJEoOFde7XULuhe41SL83oAtHXYVPyry4SYkbwnyP6hXjB82Hj8V3DXm9YfJNetMf73cztQx8VaGc/gacxAcwen7vP485HvRcUxeY8B6ASSPf4fLiQgBXWwrSpehxDnAw07uyPfderHqw9A7MQrhm+OZsblwfjFtyLnZu/H9Jdb9AwYDEo5kMvuAzZLbFye+bYQz9YpE3K5vCrQqmbu6r+DP6A3b84On/jae6huYT+6PtIQJBK+CqdU6eB3kwCCgBk9mEJZTUhD8A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFB3WWtTeU0zbTIxdmVMckVOWVYvS2lyNE52WlNNRWxNWFNsc1VCRDFBZ0R1?=
 =?utf-8?B?RWxWSFlBcXo2YXVnK1BFNi8xeXpFQ0lMeUNCdjFubmtsTWE2dXF3bFBHK2Jr?=
 =?utf-8?B?cXd2RzdxaWI3emQybXQ5S0FHVVI2YTBub3ZuQmJZUWthL3lkUDR4bzlMdEpr?=
 =?utf-8?B?ZjM5eDlSekJCK1dPdWN5S1VLaDBKZ21yL05oUlFDeExTVzIrNkhzZXpYcExu?=
 =?utf-8?B?NWJOcFkwdGhuQTcyUEZoaG1OSmdTOUhKYTZ4NG9WWGlIcUhnb2JnRE5ITzBV?=
 =?utf-8?B?bTR3OWErRWYvVTA5ZnZmY09UM1JTdGRZYTh1aDA1NG5CTW5pYkJRTkd4SUt3?=
 =?utf-8?B?V1ZGRlFxOGZMVkhOUWlia3I3S2RFODFGWmk5ZmVoNjBuREo1dGl4aHA2N3I2?=
 =?utf-8?B?am4yK0NTdzY3SzJJTWw2N3lDdmdIejIwb0JmbEVRRG4xU09YQzJtSjVtL2d1?=
 =?utf-8?B?c3lXUUdEamc4cTRvbzlEYmR5aUdsS3R3am9JRDRXNUl5bVh4WXBDQjR2Rmpm?=
 =?utf-8?B?NjkrTTNFM00vOXhkelAvK3h1QVZ6WGdqV2Z2UHVZK0pGZndZZmp2MU9tWFk1?=
 =?utf-8?B?bGdIb21zM1QrTitEbFRxMmN0ekJLTkFVWXF2STh5aFFldmFOSThFdjVCa0tQ?=
 =?utf-8?B?V2FXRWx0UENqc1VIVFA5U3RoU1JiUDBzRldmNUVOS0ozSkFMc2VNQ3hRQnJW?=
 =?utf-8?B?dFNzcG0zd0pIa2VrRkN5dDBtVUltbk5nOE9nS014UGdsRUtSS2NmZHptb1pL?=
 =?utf-8?B?MG1vQjF3TFFGUWVJSkdmclFFUjk4NzdERXVJbkVqWGZGbzlvUlJuZjlpaC9Z?=
 =?utf-8?B?ZHNGZ2txek1UVS9PT0tZT2hRc09VWGhSV1o4QVpFZkREVjFnOUxJemwwWUNH?=
 =?utf-8?B?OW1rcEg0YTRENTQ3NjFzMGxzVk12cmhOQ2Jod3lxRFM2MDJMSytwY3c1dFF0?=
 =?utf-8?B?eVV4b3c4Rk5wclhJQkxiOWhZSFFIMWE1WU1uRmhjdFhodUhkS3NJem4wZWI5?=
 =?utf-8?B?VzZGUWZhY21xMHJYd3h5alkxbE1YZWd2UjZYZzBvMVpTb2VBcU80aXNFS3R4?=
 =?utf-8?B?aEU5dERiQVUyMUYyMFgwbzNzL0xEdHpUSWlnRWw4M0JRRkRQYlh6cjVid3NW?=
 =?utf-8?B?RHBTVEpZSHhiZGFoMmxIdUVhQVVsWjQ1RzQvWS9OZzZleVFValU0cjhiUk8r?=
 =?utf-8?B?c1RBU3J0V2haNUN6Lzk2YWo0TkdoZU4vN3Z3TXgzU0poK3NmYUJQbGl3aDlo?=
 =?utf-8?B?VVFTVzkrSXJSK1BaQ1ZoL202dzdhbEFrN0JidjBlN25CQmtCV1IrYTNqWmI5?=
 =?utf-8?B?NWY0Q0I5b284S3BYRG5RMWRFeHBob2lKbUpUMTRyam01ZW1xV3FRYTU4MSt3?=
 =?utf-8?B?T09nY1hkakN2RUJRUGRBVTBLd3FLNHhzT3l3UWJRNnZzVEhFK1YvMXlHT1gz?=
 =?utf-8?B?SFdPZkR1MEJqalRJNEVTN2Z0c21ENVlYMnFQajRFWmdYYjE4cE5FVmdBTG1P?=
 =?utf-8?B?SkQxdS9NZHFJNnRhaVRSYzBONlB6VVUyZWZKd09LTXdYelNKSTAyM3hPejlD?=
 =?utf-8?B?OEtYV1lQbWR4d1dHMzc2STVNY0k5SEhtby8xcXU5ZklUN2p3TUFtOEtaWktl?=
 =?utf-8?B?eW1lbC9mbU1TSVh0alQ2NWtLTWFvbGpDbW9mcVJFUjRjYWh4elFIN3RWbXZO?=
 =?utf-8?B?MzlQK1RFbmtsZzZ3VWx5UTl6dDRYbElhK3p0RW9wRzJyYXFoVjdzV1hJZEFM?=
 =?utf-8?B?M2xoUWxpaXVibzFMcnNtRFNhR1hDSTVTeUQ5T3dCREcwZE0xYkpZOC9iM3Ro?=
 =?utf-8?B?TDEwNVZkeTZNWHBrdFdTMDVhTWRrTFQrMTgzbUJTandvMmoxQ3FiS21kTXJI?=
 =?utf-8?B?Tm8wNlJmSG5PZUlKT1pHQzQ1ZDZjRUNzYjRjVGFodnBES3EyS210SVNKa3J1?=
 =?utf-8?B?Z2Uxck02V2N0SFZGT1J0U01oWTEvWWd3QjFnbXRuS2dnem80UlJBSXYrWXZC?=
 =?utf-8?B?UW1oaW1LL0wyd0NwMllZZUVBelUzWmlOa1dqSHo5d3RtcXIxeVVjSWRnWERD?=
 =?utf-8?B?d2J0MXRZK1pBV1BVeVFPei8vdjZZT2ZXTlRsTXBNaWx4S1dNUHB6VHpIM1pE?=
 =?utf-8?B?eklpczZST0VLQmFTZXQzb3lYS0pzY0EzamtTN3NsMTgyazJJY1J3WWoyc3dk?=
 =?utf-8?B?NWsrRUlrbW9id0pacVVyWjZpZlNqeUVYSmp6SHRGdGgxSWFpbzhhdUhhVUNz?=
 =?utf-8?B?UEVxOUY0WkFReVl4cVBxT3dUWEVEN01nNGh5ZHRmd0pRN0NGTmZLVllzOW9C?=
 =?utf-8?B?VHVDUzFpT2dQQlppMWhjZEREeXVCcTZCenJ1MWhkanNuS2ozSklFUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421e81b3-0bee-41ed-ce5a-08dea473cc8c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:43:59.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5f+QQadbKFerhfe0/gKQdMhzByVe7y5Vi/XSn5UwmKAR4uMVC5HCGfEO+zvp/oUO0U4i4VsGLpAK2K14QKpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9202

From: Jan Kiszka <jan.kiszka@siemens.com>

The HiKey is causing troubles right now. Let's see if the RPi4 does
better, at least down to 5.10. 4.19 remains broken but is unmaintained
for arm64 by now anyway.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

We will check once more if the HiKey can be motivated to work again, 
then leave it for 4.19, otherwise switch to qemu-arm64 for that kernel. 

 ci/lib/kernel/5_10.yml | 10 +++++-----
 ci/lib/kernel/5_15.yml | 10 +++++-----
 ci/lib/kernel/6_1.yml  | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/ci/lib/kernel/5_10.yml b/ci/lib/kernel/5_10.yml
index 0d44681..5561e6b 100644
--- a/ci/lib/kernel/5_10.yml
+++ b/ci/lib/kernel/5_10.yml
@@ -48,16 +48,16 @@ lava-test-5.10:qemu-arm64:
   variables:
     KERNEL_VERSION: "5.10"
 
-build-5.10:hikey:
-  extends: .build:hikey
+build-5.10:rpi4:
+  extends: .build:rpi4
   variables:
     LINUX_BUILD_OPTION: ":kas/opt/linux-5.10-head.yaml"
     KERNEL_VERSION: "5.10"
     CACHE_KERNEL: dovetail
 
-lava-test-5.10:hikey:
-  needs: [ "build-5.10:hikey" ]
-  extends: .lava-test:hikey
+lava-test-5.10:rpi4:
+  needs: [ "build-5.10:rpi4" ]
+  extends: .lava-test:rpi4
   variables:
     KERNEL_VERSION: "5.10"
 
diff --git a/ci/lib/kernel/5_15.yml b/ci/lib/kernel/5_15.yml
index 4f86d10..768200c 100644
--- a/ci/lib/kernel/5_15.yml
+++ b/ci/lib/kernel/5_15.yml
@@ -48,16 +48,16 @@ lava-test-5.15:qemu-arm64:
   variables:
     KERNEL_VERSION: "5.15"
 
-build-5.15:hikey:
-  extends: .build:hikey
+build-5.15:rpi4:
+  extends: .build:rpi4
   variables:
     LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
     KERNEL_VERSION: "5.15"
     CACHE_KERNEL: dovetail
 
-lava-test-5.15:hikey:
-  needs: [ "build-5.15:hikey" ]
-  extends: .lava-test:hikey
+lava-test-5.15:rpi4:
+  needs: [ "build-5.15:rpi4" ]
+  extends: .lava-test:rpi4
   variables:
     KERNEL_VERSION: "5.15"
 
diff --git a/ci/lib/kernel/6_1.yml b/ci/lib/kernel/6_1.yml
index 5d9ca64..e79365e 100644
--- a/ci/lib/kernel/6_1.yml
+++ b/ci/lib/kernel/6_1.yml
@@ -48,16 +48,16 @@ lava-test-6.1:qemu-arm64:
   variables:
     KERNEL_VERSION: "6.1"
 
-build-6.1:hikey:
-  extends: .build:hikey
+build-6.1:rpi4:
+  extends: .build:rpi4
   variables:
     LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
     KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
-lava-test-6.1:hikey:
-  needs: [ "build-6.1:hikey" ]
-  extends: .lava-test:hikey
+lava-test-6.1:rpi4:
+  needs: [ "build-6.1:rpi4" ]
+  extends: .lava-test:rpi4
   variables:
     KERNEL_VERSION: "6.1"
 
-- 
2.47.3
