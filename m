Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7694533D6
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464989; cv=fail; b=kgCa4Mdi6Qq3ydZELtei5oUSNfegRrRUFzaBJUkcqDcyfks1V6V+aUgbCF/WyHz5WQ70pQKZuth/RT8gHDkBArRaMwQ+vUUOUcMFvVmCHFSkUn5cn5FPgueHCCa4DOZWMYavXv02xzF19vPDUPle7fx/h6l6NIxrKsz9CIo0y8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464989; c=relaxed/simple;
	bh=yzGuYt4IxIfCusmWLOWxX4nheGYG+ckOs3LnEfKEdPo=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=uDIFnjqZaxftS1LQorQZr7Kk/39lj3sRQ16Sc70rSxZawxW1BVQD0urdZMAwMKFSY+6+mSOw26ZadwPOjMlqfA36OCIppN62EhV7+22BD3dIYQ4pIxJhoG80OcMzwTYPuCLQmW+AcpBGEroqUU93HbbnY+TwOjMMou0I6mrBa84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bH4WaJsy; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bH4WaJsy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEp6NBoST7aMeh5wZsdqWnaAPDVozm8CttrF2HpVpWzD6L8DiA7SmhlLRy7hD6z7QeEykv0AnvKFQClY54tI1tIvWWBFpOkeAnVX03Uw6kqegAri3sev03zsGht5g/ipDj93eBy96dQj2EraQRMUQ4diCXGzPos6WMFML0zeXkf9dCryuVIEN9gP17Wt4v1O0lt0zl+WnuEnfTd3zrFWWTXoS6f7IFVbZoMSHxGIJiItG2sIUghGBBTuinipoLugQ2py5uJ+oyMvYqQ01iiEN8+3+yWgrGohvlj7aNxNMdhYVayyQKIt5pMQKRRszAs2VrjeYb6RMVvS6oQyNvWUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLvqyrOiBqOGPj33F9BCGDUWNGNjONDTalNLsz3xz/s=;
 b=IESGmCJ4Pu27RGq2KMt8fu9LKNKfXubAlcieqECc0jnMkSLkMu4x/pKFuDJZMAq915wV6PNxK6JzAhZh8IbKtDScybV1t089zU6aQjuzf6eqAZqGg5KVHk4kP6MvTaUgN87Lq3EqRsOB0u1ObxPUdq7hMoXciwZT/Pu8OBOxpAr76HHle2xa/TOTPDUp/04I4CvAr2fa9eozUjaVE0tg+xGt6cu/zD+DJm84XrkDPX6/ye/yavYRAUwhh4bNx/Y8CBcJ8Kj9/wOKicXS9yIEHEXxzc/v25h7wItN5tMnBcuZUHZC1Vrfl9lxstLigKm3wmaUOtPXNogTnhFx2jkKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLvqyrOiBqOGPj33F9BCGDUWNGNjONDTalNLsz3xz/s=;
 b=bH4WaJsyhJzwQ6u5ftoOE0wu3QhxQBLHMzCxIQv0MlCanXgxZFfWcrOC1f6QBwNsxr2Px9HC83Kp+J1ryzoY0IIEilOlDA85GZCRqEfFi/od2EU49e+mAc3zx/PAlTHIlHnaxWTTbqQrpABQeWJKsH5lY7prFkx8LUDfEFl3llqauOq9bKjeB1o4f6scYxMFi2Ry2wTvuSaebEmVZC4/e0nETRGWH6xXiFeWYmISvQwmnRaw568AlUz8NW1IpEFq3ES7B0WKUrpTgO85igo1OgSLcDnY7nAEkPY32FgXqpYf8vU4jnk2Q92DX+x3orn7+79OrH+zrP+aWdeiD6Q2Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 19:23:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 19:23:03 +0000
Message-ID: <84da0295-7aa2-41ab-ad8e-0983971d5b7d@siemens.com>
Date: Sun, 14 Jun 2026 21:23:02 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] libevl: Unbreak release build and update to
 r59
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3ff802-f13c-4aaf-36fb-08deca4a5ab5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|21046099003|3023799007|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9gK69hARvnemDX9ERRkCJzjNSi3bYISduz5um0tT0kwrrURECVvDlhtYuTKMGJXykWnX5JxCwLGnjtr7KxlkGGcxDkMFzcG6s6UJ6lNk1pK6p/+DOscHg7wgPDd3+G4uvSQKuUuTB/4cC6KzWgPaxxDn14K+oFv5ZbPGapsZ+pt4MTgAQHVvCCzDJWQUEv0kl9zKZsvFDjnirUn2MLDb7kOqoojxT8Wd2bbtv8AHw3DzFZ9fOx7ZqT3lGsEW9TFBnDOXk4Nlv7CYUh/iRZVOSFBW9C6t5dbmNnJkBOQ94tmgPoGwd9J3cGHjZccwZrVnGic8EGNfjiwv8gi0ObSFEuW39aLMWznOIy+bzwYNNbyi9nFS4VDQfGvd9m6Dv/856HO1QdHEM+wV3CNJk+1V2sCimtK/6tEba3Lxdj773AEGc1Ig2Itaz+BnOclmdAK9P88nyXBDc+ctJS/rGOITW9TwX3H/jOk3pd71oYJrBkf9FW9W6VE9xT1MW2NYVJUY2FVwiVdzCbBl9tIdLqS8YwJLXwaYj9DRLuwR7hDZ4o6Ys8bN+i5H4eUuaLl83kp8+4xJfak0ekh3Gn/0McZWFJBtzJGl8VumVV8Q6J4v3HqUv4dpa4l7o6ZAJ8ZASLHseSkzNiVvPDm0jsdViLmhJV5cztQiI35H0QLptDZ96+RZsrwuBjJX8j5GbuJwaTNB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(21046099003)(3023799007)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGk1eExpaEtFeWxxcXVJaC9pd2VsdGM3d0xEdEsrY1cvejF6V0RFSG5xUXh2?=
 =?utf-8?B?YzEwYnVqMmwwb2xUTUFBbVU0ZVpkTXllSHVxRkxPT296OEFWMmRlUnRnaWw3?=
 =?utf-8?B?NVRmR2tZMzNWZzFiMEk2WHFyZjJ3RkJkbzZoYXlveXlMazgvZ3pHMk80R0p5?=
 =?utf-8?B?ckNianV3aHpwM1k2WWNNYnNWczNuOXloVWl0NVR4N2JBeHJYOFp5ekZCUTh4?=
 =?utf-8?B?bGJtamlwdE1YaklYMWphd2dPMEFnSG9hbXdRWStHMHY4bSt4MGVWdWNoZ3d5?=
 =?utf-8?B?bHdKWkJ6TE9SWXlEYWJwbWVueWlhakdIZTMxcVVSYWdQbkxtd2lBUmE4TzlI?=
 =?utf-8?B?S3ErUnNkTXk1WkZLQTZ6U3UzdXBScmE2cUUrRDRBaHNINWlueGUzRVY0Z2NG?=
 =?utf-8?B?K05iNlRmZDBsYzRxVU1LVEk4NTFJc1hKR3c0dy9kbnYvby9CNjNPN0V6RGM0?=
 =?utf-8?B?YUh6K1dZOTJmVGx6WHRzNkxhbTFVSk9FQnB2ZDUvWEVxbFNsQW9sK2RFSnZR?=
 =?utf-8?B?YWRza3V6dG5QUmVvV1JrQUZrUml4QWxOQnBwcHhlRDFCbG1UUHpJNkVXalAz?=
 =?utf-8?B?M203SmJhZXVFRUpDREM4QzJTSVJZZkM2UENGaXpBTlFLREtZUUoyTG5ydkRw?=
 =?utf-8?B?YkE1eWNJdzlTSjhTQTkza2lGdW1VNHkwTlFCN1ppMVVIb2lzUkdVODhobC9Q?=
 =?utf-8?B?R2xiTms0Zks0TndjeSt4SVR1TWtma1JGMWRYVVpqVDNqdVVRTm9TQXNNOHpW?=
 =?utf-8?B?bjJqV2FtQjVWVDRSMGxqa0NNWFVsVDF5WXRVM2ZhZzkybUp0SXN3MW5lU3M1?=
 =?utf-8?B?dU9QM251VHFPVy9WeXlJdEhqZXdXRWVibXVJSHRiclRZQzJBYkVDdUU5KzlN?=
 =?utf-8?B?NlAyMW5uZjYyNlNDelhOcmJRaGMvTzlNYUZ6Nzk5UjRTaWNNbWZjVkg2UGNF?=
 =?utf-8?B?bTdCL05NbmhZU1pCSDhVckJTcGl3QTZiNXZiSlE0c2Z5RmxXTnBFTU5iMWJM?=
 =?utf-8?B?WU0xQnB5Q3NHR0Qwcm1NcHNiMDQ3RFRrbnJkQlp6Q1VHb2pnMFlJdFlTUyt6?=
 =?utf-8?B?QXVpUmt1RXRYTkZhRUxwRzB2S24zSjg2NE5DcEZvYVNSdHJ2OUViSUdaS0ZH?=
 =?utf-8?B?WUFEblFGcXJvQU9jb1A5eVlKcFVMM0hXV2xyWXhlNi9uY0gvOU0xS21wODNy?=
 =?utf-8?B?VEpqR2w4SmlPRmJrN1djV200V1N2cWpobmlVa3lib1BnbTlSUkNpUnI0WHMw?=
 =?utf-8?B?WTI5Z1RwU05JTndCSDB6bXU5bWxwNkJoeUcwMVZleThURFh4K1VMaVUzN2l2?=
 =?utf-8?B?SHlaeVhsSHJWakJUc2hmeFoyN2J6RC9QbnlPYm1uaWl3czF1c2VzcUtxSVdU?=
 =?utf-8?B?ZUlJMDB0aEFzRi9mRVRWNmdCbTNZMUFDNURvbXZqTXdSaDM1S3gyUVhia3pM?=
 =?utf-8?B?bU9aK1dqbkswREhlNEF4dk4yNHkzUjVjWXJuaVNXUVNjM1M5Y0FGZ3d3T3Q3?=
 =?utf-8?B?ZjdlZ1hzeDRnaXpSb3FlRWF2Y2JyWEZOSFdzU0FUOXhKQjZpN2JNQWdOdDQ3?=
 =?utf-8?B?eGcycnlaVFB5RlB2L0lEWkhNSWdSQkEvMlcvTGNqcndwRFdTR3BrVUVINSs3?=
 =?utf-8?B?Vlo1d01KUEM0bllhMWZCaUlMeWJKZWdPQlgzUzNSTW43dkF2ektpaXFFYko5?=
 =?utf-8?B?aTlXMlBiSlVoQ1Y3SHdxckhJbHVubG1GOCsyVWRQQlRkMFJOVEdOY0podFJD?=
 =?utf-8?B?UnVEZzZpNTF3Wk9IWUdmL3JUYXU2Yy9zZlkvbzl3TVB4cXppcFJubjBlUjYz?=
 =?utf-8?B?Yzl5NjVBMHFJZE9yUG5JNGdzYmdyVmpqVlJ0N2lhbVI4RmZnMVpkOUtkNlZP?=
 =?utf-8?B?YVFGRXlvaGVQL1ZZbGJOeGxOWmd3STVVOHVNYkhJam42TkRWN0psSEt1RVlt?=
 =?utf-8?B?SittUUlvOUNlc2tpVXRTZkhYRXgvb0dVYWpFVWl3UndkN2xtS3ZHcEhGck5I?=
 =?utf-8?B?b0V6a2k2V3J5V25CRG1qVnlIS25weE9aSnN0bS9pTmpKb2xlVzBrSy9PUlIw?=
 =?utf-8?B?enZKdTE0ck5YSnQzUGhpS1p5NDBndGptLy9XOGVWZFNMeE85aEorV1FBS25o?=
 =?utf-8?B?RHlscEIxeWpUelRzamlKZEtPSS8xYmZFTStuS3JWMGErcW9sNEMwanM4a1JT?=
 =?utf-8?B?THh1TDQzYUtqZWpBSmtrKzhQZnp0VzRlcFNwYmpJYUJMS0FqbTVmaVBqK25p?=
 =?utf-8?B?RDhHUTVnNE8yUXJEbjZEcUxMV1J1NVZrclJWa1pyRmJkZ2t0eTZpelVXYk83?=
 =?utf-8?B?cFNsNlEzR3loa2QrRDB1M1VUS3VSZjUxS25CTk1kb0pyMGs0YnlMdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3ff802-f13c-4aaf-36fb-08deca4a5ab5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 19:23:03.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQUnoLM+Vn5+ri+DdwiD4bs7qcyqvCwpncHVzvRd2IzmQk3FI+3zAnJSyVSDdRvAObtmMH0mfHhxL1spS1GjoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5910

From: Jan Kiszka <jan.kiszka@siemens.com>

The patch was already part of r56. Update to the latest release while
cleaning this up.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...missing-initialization-of-query_type.patch | 41 -------------------
 .../libevl/{libevl_56.bb => libevl_59.bb}     |  4 +-
 2 files changed, 1 insertion(+), 44 deletions(-)
 delete mode 100644 recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch
 rename recipes-xenomai/libevl/{libevl_56.bb => libevl_59.bb} (66%)

diff --git a/recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch b/recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch
deleted file mode 100644
index 95993ea..0000000
--- a/recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch
+++ /dev/null
@@ -1,41 +0,0 @@
-From 11e695ec96fb07b4a6659f7527350e570c523b3c Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Wed, 10 Sep 2025 14:23:42 +0200
-Subject: [PATCH] utils: net: Add missing initialization of query_type
-MIME-Version: 1.0
-Content-Type: text/plain; charset=UTF-8
-Content-Transfer-Encoding: 8bit
-
-Fixes
-
-In function ‘query_oob_port’,
-    inlined from ‘main’ at ../utils/evl-net.c:483:3:
-../utils/evl-net.c:157:24: error: ‘query_type’ may be used uninitialized [-Werror=maybe-uninitialized]
-  157 |         if (!which || !*which) {
-      |                        ^~~~~~
-../utils/evl-net.c: In function ‘main’:
-../utils/evl-net.c:371:18: note: ‘query_type’ was declared here
-  371 |                 *query_type, *vlan_list = NULL;
-      |                  ^~~~~~~~~~
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- utils/evl-net.c | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/utils/evl-net.c b/utils/evl-net.c
-index b45fa60..b1d06a1 100644
---- a/utils/evl-net.c
-+++ b/utils/evl-net.c
-@@ -368,7 +368,7 @@ static void bad_usage(const char *arg0)
- int main(int argc, char *argv[])
- {
- 	const char *netif = NULL, *modpath = NULL, *ipaddr = NULL,
--		*query_type, *vlan_list = NULL;
-+		*query_type = NULL, *vlan_list = NULL;
- 	bool set_filter = false, solicit = false, permanent = false,
- 		enable = false, disable = false, query = false,
- 		allow_routing = false, set_vlans = false,
--- 
-2.51.0
-
diff --git a/recipes-xenomai/libevl/libevl_56.bb b/recipes-xenomai/libevl/libevl_59.bb
similarity index 66%
rename from recipes-xenomai/libevl/libevl_56.bb
rename to recipes-xenomai/libevl/libevl_59.bb
index 1863210..93fa88c 100644
--- a/recipes-xenomai/libevl/libevl_56.bb
+++ b/recipes-xenomai/libevl/libevl_59.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -12,5 +12,3 @@
 require libevl.inc
 
 SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=r${PV}"
-
-SRC_URI += "file://0001-utils-net-Add-missing-initialization-of-query_type.patch"
-- 
2.47.3
