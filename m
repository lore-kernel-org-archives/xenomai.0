Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0F5C8EE
	for <xenomai@lists.linux.dev>; Thu, 14 Mar 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400955; cv=fail; b=ivaE4yYiryQbYbBua+ZNvvjsWB2VJY5IflCt1rHiy4oFg75fCTsmW+JtY5PGWrLdN33en6Eu8L1utBZQaxUu6uGQVEtMcDLfb5NNMMZt8pmHdoGl2T5ACvtxZMfpg+3+jsJ9wPvdkoB3TJr/b7p6MU/T2FFzK1Zo5oANoDNfSDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400955; c=relaxed/simple;
	bh=UT0hWyOyMXcC1efBz35InaiLuijVOdrJPpvPW4obvfI=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=qf77KkB5dSYJdMm4GykboDP9Bg3iZX7qLdZhfZSZcio9gm4AyjzriZfCFGFQbm5NP70VV8/TO5Lbb5XnknRZE4BqO9l3/jByHnHhlXqPW4Tb/KqrBpltLyL8xeE20vfJBgLG7ZXddFyN7tS9RrZxrmIYlsiTatIe96Gb0hlBNvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RhXOp0m+; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RhXOp0m+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt5j/H2FBfrqpKcDK2G13tJ5M2q65z1SMk3u3djjq3fvzeHb0uiXvdk2yF4v4GKfnwBjqRlxGxKOwtOsD4Jo8grq8uREvAMwS+xvQSC9Rm2akifIcSH5h63nYbPEdXvTqir6yxLpwlN5XHezsCuTokoNLnUKlZasjhem+wwJIF+RflYrB4syWS9e1tYH4HD7rX38MT08WVJ1FXQ5iM6/WFdNZGH9PQF9b9CrXdixwcO5RgV3FX3b/F5eiMiOlcezQXnifzOHyyz2XZNoexhBoKcEsjAFIN1npqSRaPb/6L1BN1C701UjeRUg1acXoWBxVrlG4Ix034UhQODL70SF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rm+5hIUyDhvrmOzkaIcPzomMKQJl1f6tPnQQotXWDUw=;
 b=l9sqW7I2YYhDLEkCv7z1wYVtlyqai0P/FhPjjL5cuEdAXlswoQhMKCLo1+KZ5zgwaT28nujO0t14pXh4zKZG9Ka+k2Y/Hos03Lh66BEMk2tqKCEgyMYWDVrATtn8fUamumyAptACBXkJ5h1rkTnyOHSiEt9R8S0Zxodc2mjmLD0B37yRyfJSCc0xu6/rwllfm3d7Lvzp11TSJKQkP60MM7bt4R/aJIJFDFdHTRuygUCw9rwx2Q9CXqQKqIE+KcZnErZ9tS5XSTLi9JQwEcHr24yr4MvtedIS2q1NG9vjuY/h5d/FVtsd/gHV/ZXfUBVokrgpyea0Uq/4fqXWWyuAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm+5hIUyDhvrmOzkaIcPzomMKQJl1f6tPnQQotXWDUw=;
 b=RhXOp0m+ZgQMHLxQLMAM04Te6WaV4KneMHCc9eoV1lzYEPEN4AKpSIL7BGldSVj4wJf2746SDfDkyQdddsjTGlD+Sw6Twjt2QRCIx5sNZ5HXOS/y356YRdxy6fZ1hF6kMSk4v2YsynFuGicLRF5/szMMACdaU7vxWnT2BKMXthhl912wTiNYLLFZ+czuAwI6jIV8jN2R2eI6OAqvMsGVsmQgSh/NXGtXEC7Ty6Vl2hZinXSQ5GCVODME1fJ1W01oHaQGG8j2beORXG1bcMxFtjTQNNdK5kvS4BGt9TwS7FZt+3EudhdZ1nHOX4y45AUQRxZBT50nHQ7ZDoQnvJTRYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 07:22:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 07:22:28 +0000
Message-ID: <a3a53667-9311-4403-9dff-ed461108d0c6@siemens.com>
Date: Thu, 14 Mar 2024 08:22:27 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Drop duplicate HOST_DISTRO setting
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: ac039211-0df7-4e49-9ae9-08dc43f78107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QeynNLdS/yXnIVoOIuddF/kz4duv1zasbRrgTQkyTKBJ7Dqql0dlyYBKxpW3SFVY348CqHEt0NqORVrRPgMpXDbgZAJyW/o2InTomlzoY7RWieJvMU10QWx3yHVxxZ2hbhDiBYykVS3vp+BR65NiK/z22x1DcAS9gH5CZD3M48l72BKgGWvdzwYk6YF3vJ5O/JjiOsMnPICuiQ+/mIJzi5DqkFnVRG65LfJiubfAOjdp/Uer3vsgvvt29A1Bx8+p93IXgLqZFl3Vs81jY73gcvKz5Q16BvUS96X+2vjadRQnG8CQdMMbaM/UaUYY2dL/scJaHNdGW4MBNd1xeGg3saAy50/iuJ1eoScyNIDihylafrKa3Dqga+p3ZYoiqpW9RG+KDANoM7OfT3LLrpyRD9mUB1pge7HTx09y5eaT3n2fuX9M1nArsjh8KLgqrEY4xMlcKV+KbC2nD5rT42LkZ2pxUzfP6rYebN+0KdKImsDcf+VDS/fkeTb9UoacH1WhBjMr3T5ib0NrZY/xhknWM68VwAj3SvOZoAyDjQkbP8KbFUi5YvBLLBhSyTKcXJJODTjPC8G9xX9goFS9SeihMPjtUZ1mKKql9Iqo7twpZ8mKvNm6O1kKZ1uaX/pjbsdgOSWj2bE+2YNwhuHW+jla9VpTz/JAJSzXWvnYzEC6om8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2FsQU9UWlFPZFhKWEcwNzBoeVdIZFZyOU9OSW5qTGtJSlJWb21INFNvQUpj?=
 =?utf-8?B?MHFHN1pyNDJaazlzUXJzRFVmTmJvdkRMWkpIdUdTMTMwQjNPRFdpSHVKVTMw?=
 =?utf-8?B?Q2NaMXF2Z0lJU2lPL0lUemQzZ3JSQm1FN0pucDZDeUowZTFPVVoxRUxrUS9F?=
 =?utf-8?B?Q1J4UUJBSGQ2WHpJUkwvZjMxTWJnV3JoMEZRejNXTnZtR3p5VGU4NnhSY2g2?=
 =?utf-8?B?cmdUNnp6YTFiYldhNkdGUHBialhxOVdwR0ZFYnYyL2E3cnp4Sm0rODJiL2hz?=
 =?utf-8?B?RTBBOGFhcXdNTnkza3haYmFEaFZNT2YwUVk3SlRreDliYldhRVRBZ20zdTVh?=
 =?utf-8?B?NXRqc0VkV21ySEh6QlhKQmx3ZlBVc1FKa1RFSlRYSklYMFJ5c1B2a1dUSEky?=
 =?utf-8?B?NVplQ3BnaXZqN3VGWXJJaVI4enF4YnVkcHhjT2hMSVQvV2hLaXd1ZU82U00z?=
 =?utf-8?B?OStvUjZ1L3RCblNxOW9kNXF5YmI0emFxdklzUzk1OEhFckxORUZRSDNXejR6?=
 =?utf-8?B?WHpTbW1kVzE3cUNsbjlNN0dYempkMjFVUlhNUnJRU3Vtb1Z0cDQ0V0FZYWhl?=
 =?utf-8?B?N1Q3cit5dTRUR3VrZUk0ZUxKSGsvdXkwVDNvVlJTSjdXZzk4ZStmK3ZQcThr?=
 =?utf-8?B?TTdpWm13cS91cHRiWE9GYkRubVdOZkhIV1ZVVm9zYldzdGo3Mm5lemJxemRD?=
 =?utf-8?B?bWlSdUhTVkpid2hLYVNvS2orME1jZ1QwRGxEdWJpOHhwWjBSem5ZbTRoRmJK?=
 =?utf-8?B?ZjZRNkpETEpjMzczL1ZrNVRiR0g1b3loTFkxZTlCRlpOYlhYdmJJTGhjdFJF?=
 =?utf-8?B?QVhrQzhYZW0rTCsxVXUzcXM1M1ZYR0Q5MzBoSzdncmcvYllKQXJ6N2VNUjE4?=
 =?utf-8?B?ZFgyUmNMbHJGbFhicVo4cnJWZk9XSHZwMmQxd0N4WWdIcy9wSmtheENvbHhP?=
 =?utf-8?B?UkU1dVVTUG1va0Z1K3BEU0MrUjhMRkh4eGY2eVNFSWs3MGpsQ2VZQ0R0RVBD?=
 =?utf-8?B?M0lSM2o2TTkwVEhFT1AwNFZ3TkZkbnBMYm5IOXJiRjJyT09JVHV4VFVJVlpt?=
 =?utf-8?B?T3NRalZLaXB2Wi9CNXVId3ptQ0Rwb2l2UHpCQWJNaXpDNU1Qay9SMVRxMEo3?=
 =?utf-8?B?emgvNmFIeWxnOXhTV1pHem9DV2Uxb0h1azlESkltYVhpbkZZbGpyZmR2VFB5?=
 =?utf-8?B?T3dOMTRLNmhmT2MyOVd3T0lFbWgwK2xySmhqei9aU0lrVzhpeCtzZmkvaXRX?=
 =?utf-8?B?SExTOHhQNU5GN093RDdtRnlWN1lFR3loc2U0cDJ3YmRKSjVRUWFMMWV3TlV2?=
 =?utf-8?B?TXo0RG9BaUVCVmEyYThyb0RhcTRIZFFSOEpBUGFVNFFXZmdGdkhxY3ZLUEdq?=
 =?utf-8?B?YlplSEpXZmZkVTJZVmJUMEFCZTQrbnNpUTZ4OE1JbUgvakxWeFlEaWJ0Nk1n?=
 =?utf-8?B?MUNHQ0NyZ2IwZU14Z0ZyMnFQUS96Wk1pZUZVdVkyeng0WlFBcXI0cDRQMEhC?=
 =?utf-8?B?dnI1bUUrRzZ3N2drcjZVRjBwb3NzOXo1WitMSHdwTzFXbkxHMkFaT05XNU55?=
 =?utf-8?B?Zlc3N1ZjNVVMV0c4V2MyVXBQUUJzS0NWaXg3L01DQkJHdjZiYXdBV3BGQVpS?=
 =?utf-8?B?b2FMS0wvZGx0REVFVy85UnloakNKZUtiUVhwWEJST3ZQTGlkNzY4TUFHcjZJ?=
 =?utf-8?B?REtIQkR3aVU0VmdoSW94RFJFR2ZuaGxMWVJxN2V0cUtJUEd5emgzalIwbmJy?=
 =?utf-8?B?NHdFS1ozbGlCeDR1SDMzL01XUm9xaU80UzN5RDFjZWxNNW9FQm42OUtxcFhk?=
 =?utf-8?B?TlVZNnVsOXlIM2RxenhvdS9jSTdHNVd5bWtldEgvSEQ0d3F5TzZrclZYZWtU?=
 =?utf-8?B?S1BHclArRFF6R3JPQUgyVDFuZHR4b1ZuTmxFSHRyN3lCbVhTcDNvVFpER2do?=
 =?utf-8?B?RU96SzRUL2dqaTRkeG1Sc255SmUxR2d3c0tRU2NsSHdGaEZ0ZU5GUEF4b1lO?=
 =?utf-8?B?dFM4bkhHR2Z2VzBjZVdqSFEzVlVHMFg0ZFIrTC84UzEyOGRwK29OaUx0dGFY?=
 =?utf-8?B?S1ZtMXdVRlFZU21mV080ejBLZUNmWjRTV2JGVkRqUlZrRmVvS2VQZjROSGdG?=
 =?utf-8?B?YkNTOXlaaHlLcXNlOVROWVVGeGlxK1ZWZnFsenExd3Fldk0wVzFBVFF2SGYx?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac039211-0df7-4e49-9ae9-08dc43f78107
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 07:22:28.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQH4GnlpPXDyTzp13L+MltMvmonml016DdC/cK2xOy916DYOiJ+ThYwQ4BqlZXS/1BVJhOwQ8tCbZTOSSbs3fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6641

From: Jan Kiszka <jan.kiszka@siemens.com>

Already done by debian-bookworm.conf.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/xenomai-demo.conf | 2 --
 1 file changed, 2 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 9e8c346..222e077 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -21,8 +21,6 @@ include conf/distro/include/xenomai-version.inc
 
 PREFERRED_VERSION_libevl ?= "4%"
 
-HOST_DISTRO ?= "debian-bookworm"
-
 KERNEL_NAME = "xenomai-${XENOMAI_MAJOR_VERSION}"
 
 WKS_FILE = "${MACHINE}.wks"
-- 
2.35.3
