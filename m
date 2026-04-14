Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5A3EC2F5
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180954; cv=fail; b=jyB4+wgauSjiL/tLdKbk1eqY3E/IdaOpK65AoxpA/zZC0U3zoCHqvcPFmqCukTJvWAdxWBTeq/HZcJbc7JEnylJEL30SD+Ia4LZh2sF5d1+P67xlAtxsBm7BH+R97Qi5q86zaj1gLwQvYftso3yThljhVUvfa/ZUJ5Z+OI+qcbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180954; c=relaxed/simple;
	bh=5/SEJT720io8+J3z+P/Lvahva3nm2U8p5jD9fpEQtB8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=LSwYwzM0h5uz4nlYCu9GxErfGZARTW5P3tPKqvS5YjZOl6z0Ng+41p/wRtqKGz3Xbx+wAjDICU3hvD+ugSRvLzeA3Q1NWmJ9clqWUrk5eZ5zuZrUmUwS9PqQMScxT/70Q1BPLmIJOPULjzY5ybHiPhnyEsBtjHW9cmVxhUuLN7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WfWvi1Cz; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WfWvi1Cz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIORsy/ggbKj+r6QDT3TignvWPfEdLpWvL6Gdoa0t9zA47T9YhvYukCp8I87gtRlFWGcfD608z6qDHx7kZHzTTaYMe43/NvO/QZ7gYYlRN481FfdH/YdK4tPryC3h2LpE5jdJ4bmfq9UJskzCnxM5nhEaeabvA0kEHdlKhKEsXd4MsqKQyiaAmYLlR0pXaMh/LvP0es18yhk0z/aJ1c/Q+aJ9FiyaoqqnfYZmAHzCVAQZa2icZpd4W1Zza+XmCP+piCUeIJOaDg+TRwmxPXj4hafuN/Th3Rj7pY6jCHQ4d+fa/0Dt2Py3s4ciq9M0zyiRrYA/TPYrM1HHb/k2tGOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUhPVrUd4LwHOCXdqEt3HgChJ47LSmlyLbJXwpQGRls=;
 b=FSTE6UfFW1t4WjLuSOJHtehZbIzAC6S21sohcUFsrGRIEwRYPXDokKJZI3rpjX3KyNiO/bR8K7Gf1k/C3pgWqEUs2nYWf3OZNb/2xqMwSRSJJcNPzQgdWtWZpGdUt7W4IenuqMSfQW9rpDrxP6bOx/LA53lFkpxZJP33Fw54nVsEDSGQqyaQrhg9AdGozQEUgZXNCRP3R9o+fzzoofVEfiWxkuxllsDZEjUFWkX1WBisBOfjODI5NJimXzVPfNMVjJAg6V2z1Nsljxb+xWdS7arK5Qpxg837luECXvYz0KkGff7uAC1KY4cOK34S2TuP0Am37qmWb3kc7783vYKFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUhPVrUd4LwHOCXdqEt3HgChJ47LSmlyLbJXwpQGRls=;
 b=WfWvi1CzMzf63qmwuoJHCV94r32cwrHOIzm37b14gmz2PsAs/0fic9zWR8sBeT9Re7AdbAM+uPjvpBwlbORF8Otmxm3hJzvo3XPRWLIlDoTN7jWR5HxJuwCPe3JI3V8kX/5+l38jfJ4frxVaTEEWS8d3DauSGHc244y6XflrrOkNCxjSauW7St5vvtmYB2rkBHWgqOjtYC42kLLinrmkJ+RnG1Nf3I+P8WS60usLW2Srt3AdXhRNZtO8drpW5ndPJ/9X/cfugLOUL+yL+/Q9SLkOTQxLlxCEU8RUH4UCT6wYT3AwJTIqdye3ta8IWfiJC+iwXSSgxhKs1FuqIzx1Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3980.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:35:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:35:48 +0000
Message-ID: <f4093a39-ac63-4b0e-bf5a-e01aee97fade@siemens.com>
Date: Tue, 14 Apr 2026 17:35:47 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Switch head jobs to kernel 7.x
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3980:EE_
X-MS-Office365-Filtering-Correlation-Id: 885dd62d-b5a5-4fd5-1702-08de9a3b805f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	9SQlYCn7wrAWJCN6gj3xYMIg9xFV45HoVRGNWUprw+I148U0z4U1J2iwiesqyVyoxjn8koqct1oh8CNC6UNNtsMuUCc18LUynm6s8ab5Ij37PtZoOWuWk7ihiPmaJQ8Q++9G/3iQYGZH3a4EKUEIgNa0p1utWVaNEDaYbEjYKZYJbPKNpWSOXb7WGDP0V9JIm0iPF729XWFLARNKf5nJk7B8w3+ZAdOA4BktUR5aQeInxiQTC+xmhSgHZrALg8VHpAQ5pIenCdmeO9P1Uls2FSfuXCF8maVtIKVuGKmXqgjKR2bZyxpmmUO3hDT3lOYjgPQR120kvMZ+KqSKy2Fc3aUyZnlRtpPjvTstCLnLIhWuJjs8x1P3UYQygPcXpLtRSx8Uqk02z/FU3lLgza3Smwdy79W4q0+fzGQ5H47+34K3SLPosIfqrN2FGihVPisk0RiDQBi3fEEPQB0ipA+XeLxwQD46ZdG6PA55KtUDtwd7NriOyb741Ur5GAfXKe0HF7s7wP58dnqOrXyqz/TP1RJyveVkZzocDmYB82v6C1pUci4aWqeYCAzbjBTk+Wm1nhv4GGbv20KY7WDuU/wSXLclg4ieLAv+NOdTgnrnPk1PPCgFmAVlneuH5zMYvvKqVwZcnNZXt2g/3X3f7jflHhI7V3PP+sNoFnAb7Uro4kLSB6C3nHZim8eJGn4p+hkj5SDKDSzN7e4KzfayL0rixOAE1Soe0Hcp+mjoTnjljHk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGVyNEhBRGpNanEzdExyRnFVUDBub08xbDVlYzNCNkV2Mm50TlVuTVZ0eHZD?=
 =?utf-8?B?MWRKWjVNcy9yUDZnZUZFZmtjYXhlWkdJZ0VvNFlNdWl6R1FHTUVlRHhRdHdR?=
 =?utf-8?B?WUE0YU1xbDlReTFNczAwN2Zqcnl5eFZGSG51amZubFU3bE5qNmFra1dsL3B1?=
 =?utf-8?B?bis1cG90L3dkVUtSeHU5TjVvenJLelk1amloKzZhQ05XV3VXU1AwMkpEcWJr?=
 =?utf-8?B?UnNDLzZtRW1GK1lrMFdsWHBNTTZtVHNiNSs1VlpkaU9aaG1teGdTZ3JJaUVO?=
 =?utf-8?B?RDBoa3R3OHJra3VUMHBqV3hoT3p2bVdxVTZnb1V5cWphZk5MY2J3bitkRWU4?=
 =?utf-8?B?bGUxWFZOZ2paN2p3WXhiUkxqZWJOaHNkZ05naUhaZ0QwMncyc1BCUkx2MDFx?=
 =?utf-8?B?ODBpWU9yOEV5aDd2OWU4RG1YN3VLWUVHT05iL2EyVk5ZMDR5UG1FQmtYN2tN?=
 =?utf-8?B?YWpET2dlMzAzNHNVcVVGNzQ1dnJQa1JxWWNDdlVyZlB2Y1VRMExTYkxFTFpE?=
 =?utf-8?B?YzhNTEY4cTRUbFRUd0FPOEY4elhnYitFOFM3blMyRWZmUCs5OW1wNUdaK3p1?=
 =?utf-8?B?S3BVdFhvWEhhdkVVVytxSEc2RnZjd2VETnNTaXJHZFVmR2pHdjdWUFRHbWVS?=
 =?utf-8?B?c3JBOW9JaHl0Yjh2TXgzMi8wVU03dmdVMTBIaVNoWVc2b0xXenRGdkl4dnNv?=
 =?utf-8?B?M1YwWVJxbmNKWHEwZEhId3dWdk5lb0tDY3o0OXFiT3VrWFk5eGp4cEp0V3gr?=
 =?utf-8?B?S3grRS9FOXp1ejVBYTgxeFQ2ZXdGU1pTdXY5cVNrZzRqMkp0eDV3YkkrZzJm?=
 =?utf-8?B?ZTU1V2F5N2ZNM2dpdnhqUjNaUHNSOUYzbkF0RVNGdTdVSnZSWkwwd2pzd3F5?=
 =?utf-8?B?NFZoMXVOSGJUTHAremRlUytwYWI3dzNTdTlHRXhtb1VlRHlhdEp2RVlsUkpv?=
 =?utf-8?B?VC92TzZrd2NGOXZjcklxWmUxT2J1cmhXTzRWNjdLUWZEMC9yclA3L3NnOHV4?=
 =?utf-8?B?bmJGTEdTQ1pLQlpxd2d2dW9MQ1QvVUI5RlQ4UUxPUnY1Mit5WHZIM3dyNWxR?=
 =?utf-8?B?dUdkc2duQ2NqZkpHT0ZRdllRWlU5cFBMWU1GTFlic3c0c3JVVkx5d3hkVEZh?=
 =?utf-8?B?S0RLSExPTUZzUmg1dTJtZkJOZ1ZlUHpBdlF0aEljTVVlOHBjMFplSmNYcGNj?=
 =?utf-8?B?SnB3Q0ZqRHpoTDJPc3BTeUx0VEc3Ym5YSHZMV2pjakFnK3I5Y0VHQ2lUU3lV?=
 =?utf-8?B?NVdtM3IxWExDa2tIbEovYXJVemt4aFhxMWJnMGhrMlpHVE9rVkYvMmxqNVV2?=
 =?utf-8?B?bFI2SnkwcVBIejNCQmVNejR5alFCZ0Q1Qm1oS2EzYWZsZ0lKTUFyWmFBU1VO?=
 =?utf-8?B?QklETVFKU0gwUDNNMkhlOGU1RERmeW0zeDVWaFFYMjAvK1hkQnoxRjU4S0hV?=
 =?utf-8?B?NWNzSUp4ckNYMkpKY0FKTG5JMkgzanJINzdxOXR0Q1pBQUdPbjU5ckRmeDdH?=
 =?utf-8?B?ZFArNjRJQWpLR0h2RjVwcHlJZysvcHdFc1dXallrN0hWRWdDdUcyLzhqdTky?=
 =?utf-8?B?L1dkRkNlNGZhMFBXZ1Y5K2o3SmVRaGlwcEZUV3ZGNUxISlhaVEMxc1BWRmlV?=
 =?utf-8?B?ekcrc2YvN2tmeXMwbFgxN1ZDYlRhN2wyNU9xU1E2VnZyR0c3NWFVYUpxVW1a?=
 =?utf-8?B?M1NVVDJoWlA5bzNmNlF0cWFXVXNzVE9OUmhkSHBSUGJMdEgwQ1VkQ2J6NG5y?=
 =?utf-8?B?dXBuV1piTUMvR3VKRlNpRDdyK0hENiswQ0JOT0ZDVGZaZWIxamg5SldTdS9m?=
 =?utf-8?B?UjZ2TEF0TkN1azZObzZYcG5uenpQRS9WNjJlaTJ6TlZqRWQzUGExM0cvaXQv?=
 =?utf-8?B?YmxPN0pvcEhZZXpFeFp5cmxqMjZIOCtvVzROeVloSjBiMnAwV2ppcG9mVjJK?=
 =?utf-8?B?RVNnVHpPRCtnSXdMWVl1WHpUYXNEQ2xaN1BSUElvcXBEd05taTBaeVVXTjlE?=
 =?utf-8?B?Q1JhTE02RHh3cjhFL0hoazY5MVVNcTlvS2RhNmp0NGR0eFdJZTAyYlRoRUgy?=
 =?utf-8?B?aXBOVHl2WlcyTHNCK2FxcS9HZWZJRUtZL2RCMVNYQzBIcStwbGZOOXMzeHBH?=
 =?utf-8?B?NzlQaHNiazlrNDdpR3RreUxFNys5OTgxcnk1QTF5bGRmWGFKdldFZTFOSkt3?=
 =?utf-8?B?RE5rNldaNUtoWjdTb3BFS2pXejZTY0VlcUl5SXBiQXlpeWQyTUh5S1dOM0Mz?=
 =?utf-8?B?WkJGYTRpbTZUTDdMWll6WnJwS1U5N3FDcGxVdndwc3B2M2tDdWVBc1ZnVDBk?=
 =?utf-8?B?dW9qT0RVMFBZa21UREZSODltMkJKUzExS2htQUJjQjFCTVJqR3hPb0NpbW1Q?=
 =?utf-8?Q?V2DVzAfeyfbp/aFU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885dd62d-b5a5-4fd5-1702-08de9a3b805f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:35:48.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2RI8Z1pvKYctKi8F6/jNkTFATj+rhpQXOWxnDUMkprluyv+/IHv+r4Dc/aMGUKplhMYOTaqV089w4P7krgcmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3980

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8755bc4b80..b82df7e436 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -186,11 +186,11 @@ variables:
     paths:
       - .ccache
 
-arm-6.xx-latest:
+arm-7.xx-latest:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
+    PIPELINE_REV: "v7\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-6.12-head:
@@ -207,11 +207,11 @@ arm-6.1-head:
     PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm64-6.xx-latest:
+arm64-7.xx-latest:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
+    PIPELINE_REV: "v7\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: defconfig
 
 arm64-6.12-head:
@@ -228,11 +228,11 @@ arm64-6.1-head:
     PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
-x86-6.xx-latest:
+x86-7.xx-latest:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
+    PIPELINE_REV: "v7\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-6.12-head:
-- 
2.47.3
