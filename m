Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FE309DDD
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919985; cv=fail; b=rqu67+/TNbYCG0VQ2jmw3oALcf5c62KlJ29q4FSlfJi2X6NrnliToXnz9W5pvJH8VKHtsTSwbJhrtqMFUbgIVmHber7cu3JtuabFJ3lmIRPMBtCGQvRQ7C2Uk1AuL7mXdO2Db2l6k1ON6CDA2ykhu5Biw/p4rZLcHfN6GvKYWh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919985; c=relaxed/simple;
	bh=csidEb5HjYpjhHHSLrR19Fn9XpHQpAgZga6NQavhuPE=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=glHkXhb6jSb735cGDRzDPMj+vPXrZ4+g10gaV6am189Iok45/rkxCWsEs4M7wgUIgslnJjrgpLEbTJmsCz+jv3+PHMoPXBWlyUfO3YFow8Q2in026tX0a6hIDcpZGSwzXWtE899QNyy7UxBpmX0Q7EXEi9NqL1gFsZP9RlPKrSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VSysRS8I; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VSysRS8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huKlpI0LE4jNG4EfNwrV5fmk1dGQrF0wwLSCIoj0CUCmq3HccpEXPjhSdE2UM0z0r2UtCClgEaMPvjdB+ozpFYUpyktVTk9gwq7rTeQaJOrv4JFnPLH+8YcZ6EU+0GqrPRlWPDqAIDPpnQ2KSDyxv7DJTBj6Blcna9f+XbyATgcRWvE4aBh8w8HrFRzdp3MvlICXkbWwwL4FWeZz4URGgOmLs/pqJlKcK3sTwZwRzuThIs6e6cLfEECOCZR3BUsoUnkV6KbuDAq/ilftEyKWxEmjZOhLWJUpakGSBnhDy7KepI2EyirrpOd4oVWZs//cOZ27rIAi2siSpsydPKlSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6/eq1EFQ/q/i6ddJujDVL5Cm/EZ1fpe0FNVibBGkxk=;
 b=svf1gnEgm8BnSsYOPpq1EHy/YjCtj+pUK3VG+44dcelC7fEe7vXeJip9HNkgEbvT75LpNzMmb00a8GLbVjXDjJA3lnP4K1+IUMwEWILBkCU3I+IA0rexeevhx6VtCekK8HhtDiq58xxLnbKe1Lm5CAp5/ZsL9hcY3W89I+jM+nug60vG4/L2QsvVh+S0WsCTdgdCOXnijlK1Hud1PHeiX06JIQCYDGhPROsdhw5Q3kYDFSARb6Pje1aVwja2opeuaDMYRYU7zg0KMBGdLpBycDz2GWW0lzVv3Blf0he0aIdK3nlJiUZoGgXlbHxAyebMpRejZ2C3HWBrjB+lkWMteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6/eq1EFQ/q/i6ddJujDVL5Cm/EZ1fpe0FNVibBGkxk=;
 b=VSysRS8I0kpZEpS4Ui9RGuazkWg9LPiy1sQel2nZ+9Yz50UiJwKpa/rECb76l9PMFYLDM70PCGpAgsiWAaWNdWvcfrmQUTqaBXOvxaaiFrHrgD9DOV30TccRwH9bhLVGPxV8SM9p5sy604cNk4zi6oHwmNOaLdgcn/YPFyARWL03iFx6KJrMX6L83chhiY0Evx0W8fIoPV0NrQP4EmezPv+tGwikgm2CAZFG9NnVeQUdRw1qv7sMoTTmIFAeXzyFTDzhT7bWQIRdzffs0nVGs5IhWXRoUKOZ7KcXVX+fgky57Hzf+rR5zgihTTHDCcxD6Zk8/KtR0QqSR/xLsimwXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB3488.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:19:39 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:19:39 +0000
Message-ID: <a8d61005-5fae-416d-8e97-fe5958e173b1@siemens.com>
Date: Wed, 3 Sep 2025 19:19:38 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] README: Update CONTRIBUTING.md URL
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB3488:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cc651c-c723-4c34-a6d8-08ddeb0e104c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTVIZDM4WnE1N2VBYy9GbS94RmY0dW4vY2RVVXVWSlM0VThHRWdxZytmbXFP?=
 =?utf-8?B?bnNSWktERFZsZXFla3RhcVppWklmZkdSM0dsM1hsZzV0anc1SmgvZGhkNGRl?=
 =?utf-8?B?N2dRRjFFNHorS3ZtSHh0bW1BeDRDbG9hd3hXdFp4MmNZRjQzZWhLd0JmSWlL?=
 =?utf-8?B?UDl6ank2Sy96QjJ2NGhPQXl5UEcvdDhLRUVEVWZpY2p5bCtsclU0eEpRcDNJ?=
 =?utf-8?B?emZiaTZxUDFwUWxqNVpvL3VWa2hoMmZUQXg3bVQzWkszcjUwd29rQithZjhm?=
 =?utf-8?B?SXVnd2xIcGVZa20wb0U1RDdSMnNqUnBVbWFtb01mVnc5S3c5YVBWTlg2a2I0?=
 =?utf-8?B?UVpRVnZabzZqN0ZlWVcrZHVHMTNzdzRLR3BPcWpiNTh6Q1VPWnA5MGxqK2Rx?=
 =?utf-8?B?MUpZaVc1aDI1MU5LUm42NDZNb0xSR3RpVVRrYXlXd2xDVmRHV1M1MFUvK3lv?=
 =?utf-8?B?MnRNbzNyYmlQd043Z1d1SmZrZHdkdlVhRWp6ZGlJVDFNc3ExTUx0b1NwM0ZN?=
 =?utf-8?B?bGVZR3JnQjNkNldibkhHNEkyYU5xenJVd0dJRHRwRmxzaTZ1ZFl6MzRpVUJ0?=
 =?utf-8?B?M0Q5a1ZvR3hzOVRsY3FUc0hlV2ZPcFIzZFJzcTF3eERMWUdwNndGT05aRFJS?=
 =?utf-8?B?TlJaUHcrUXB2dlNleWRsRWhpdDd0UW13UkFYVThVU21wSXE0THduTVdzRC9K?=
 =?utf-8?B?K216c3BJVGNDcWFWUkRNMlhzekkyQ3NDZ3FtaU5FS3UrYkJ2UXFEU1ZkaDd4?=
 =?utf-8?B?cEJFc2tMeVE5dU1QMytqdVB4OHlzSmV1TWo3QzJNZHJsUkRZRjdkSHQzQXM5?=
 =?utf-8?B?elJaaHFJTFZ2ZzYycjlPaTR1ZGtKS3hwak5qYllrV1Z2Ym9wOUpTcTVjb3dP?=
 =?utf-8?B?ZXRuMUd2bjNrcXNucjdMaENQY01yR2NWTmZtN3MyRU5NTThyTHVuemFXUy85?=
 =?utf-8?B?eVJKVkN3a0QvYnNhT1dKck93U20vK3FUWUE2R3FVdnpPVENuaExkRHprcVpW?=
 =?utf-8?B?aURObHZ3MmdqdDhlaU1wdENVa0VCb3NYS3huVWV0WFRZWHUwQnZnNmM5RFlp?=
 =?utf-8?B?amN6U1Qwb0ZuU0dURU9ybGpsalNZUXNMNGNsQkZnRlFtbnpzdmppbDhpemxN?=
 =?utf-8?B?aWFDaUllTm80bVhRQnhZZnJHM3U2Z21ZT3BpdHcxYk0rZjZiM2ZueXRCaU5I?=
 =?utf-8?B?UW9VSE03aWZ5dFZPSS9iTGFOMzlEU3lHK2haVlBMZ2tiMzlFL0gwQkgrUjRO?=
 =?utf-8?B?clVLUmVyWlBnUUt6SFdHQzgvZGNuZldoUUxVNWNscUthd0svWVN0ekhQeGVw?=
 =?utf-8?B?RmIyVG5KUHplZFNqUEE4VzFlSWNTSEpNd2FxZVcvSzYrSEUrUmJCcmJWVk9N?=
 =?utf-8?B?YUk1RDgzenNIYjdXTFhoanNzcEtsOUxOTDdaKzlMVlBsbXoxbGRNR3VVQnhF?=
 =?utf-8?B?UG9LM0VJWjlJejdjTFdyU1dGZXUrUWN5eWM2VDdjdTZPbDRpeFl1eGJZQkV3?=
 =?utf-8?B?ajJUY0tWcklES09QR21IbTJRRE1aa2t0c3YwekxEdDB0bHlUZmxvZDJhazZG?=
 =?utf-8?B?dWhQb28yOTMvRm0rMDN2Vnp0LzFUdmFiV3ZTRjMwYXVVa2F3YUttNVNXbVha?=
 =?utf-8?B?TkFvM255YTF4bnlJT1hvTTQvWTQ0ejVtdUc3UDhuM1dUQ3h5Nyt4ZWozYUtL?=
 =?utf-8?B?YkRxZ2h4UGxRT2hUV24ySThUV0ZxQklsakpqY0o3OFZYMkVzMVREdGcrdUpB?=
 =?utf-8?B?QnFTbE02blltWUtQc05FWHhGbmJmWWxQajRrWW40dmJWZk9LTkFETEREK0Qy?=
 =?utf-8?Q?y4DxRRR1rQQpU87yU8abqRHCXq2ndoM0EbCnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEE2R1B5eFhDM3l3OGRQbzY3WlhYcW5tRVduUnlKYjgweHFlODhvcXJGazFR?=
 =?utf-8?B?VDJ2L1pTYTBQbWJKbXRFOFNhbW96VlhhMDdSQ0p0U3oyMlJnSERLczFXdXpu?=
 =?utf-8?B?aHg0cXBraXdvZVRUYk9hTm1NSTM2VGlDQm5ZWGphbWNFS3loang0SWFwKzBB?=
 =?utf-8?B?UFBVUEFlMGlIWkZ1L1BMc1EzSm4rcm9IQmhVVTJCOC9PYit1YzFlSkVqdnBj?=
 =?utf-8?B?NGdLUFFKM016dWQ0WCtHRGR0ekVwV0pURmpROEtld1ZwVy9HQWlZaUtZNmpr?=
 =?utf-8?B?RTFYVGpzS3J2b1ZQSXdOK05WZ0tBYVJNK3MrNUszMy9YT2NCTjZWaXE5VXFr?=
 =?utf-8?B?dUVKVUdnc0ZTa2lmR2RVU2NsOWI4Y0dwZnk5TVJHSGNqbmdqOVFXdHNnWU81?=
 =?utf-8?B?aVZUc3R5b1FHb0o5Tlk4aGZVczdJaFVxYUV5RVpSbktxeElCT0tQTlNjYis4?=
 =?utf-8?B?STVIQVc3NzZYV3pCQ0hib00xeVl0WUY3Y3NaNENqWVdSeU9EdVVVRjhPNnJE?=
 =?utf-8?B?S0svNTlQRXhvREpvWXZZU25DdGVrVnJKbTNDUENjZUlKY3NoWXVRTVl0bGsv?=
 =?utf-8?B?YXJYd0ZZSGlnOHNlcnVYa0V6Mk5yTWk2V1VLMm42eWFXWThjUEhEa01LRjJQ?=
 =?utf-8?B?UTNvY015REl5SGlnVy9DQjZ3Zk5rU0lJMk9RRFJodjc5YkdFWHhGRGNlOTFS?=
 =?utf-8?B?QWIvN0pJK3djTHNXamViWnJvdmNLMUNMSW5DN1dBS0Q5SWpmZzF6TkpXcVlG?=
 =?utf-8?B?bVVZaUt3alJFc01ZSUoybElvVDBqWUVPMTh3SG9FRDN4ODBOTG5SWGVraTFy?=
 =?utf-8?B?VGJ0MzFBZ0J2NFI1dlc0emVEcldoNmhPSTJkdXpoaUt4dGdiZ0FVem4xRWJK?=
 =?utf-8?B?eGw0TVM2dCtJVVN3ajBpS3ZPaW90LzgydGVYNVdSdU52UlJXRVcxVEpJY0JH?=
 =?utf-8?B?TjlLUGZxS1lRZ3p0Ny8xUmFUL2JDemo5UjVGYXFZdk5hdm85S05KVkVTSlh5?=
 =?utf-8?B?VXV6bENrS3FBRkhmdTVsSWhwME5BT1VyOCtkTWxWNWIvSlR6SUpZR3pqSFpt?=
 =?utf-8?B?Rnh5SnVZaWE0cmJlQTI5VUc1YTg0WTIrb2xZQnF4eC9lZlpEZjhsdzJhcEov?=
 =?utf-8?B?V2pXM0ViSFdkbTdZTTdyOG9WYjVnZEVsbmx2SHRWbUJaLzdJUWlidStJNzJD?=
 =?utf-8?B?TkZKUUZ0QTBMdzdjOGVYcHFFM3lhUEU2dDAxQjcrYS9TMmJ2YmhSZDhaUVNF?=
 =?utf-8?B?ZXBxUElwNjFxeURnaHkvQ1RoQTNJUHNWZkpicXl2WjBqWURqNVZ6UDZ0WVlk?=
 =?utf-8?B?Qkdtay9aMTY3dkRZdGpZT3N4L2V5UlNGNVl5SDdPSlhxb29uR2pTMHpHL3JC?=
 =?utf-8?B?M0xHTTAwRzg3cHhSdHRNWTRpaW5iK3VSMWRId0RZbGpLd2tVODZUTDlMSFVk?=
 =?utf-8?B?ODRTa0t6RHhGeGVYVWlPeXcwRThRMnlNYTJPYzhyNTdZRXlEZ2IxWFZJVmRT?=
 =?utf-8?B?dWFVQ2JwSVoyYVhWNXBTVllYVGVVMTNRd0MwRisxbEZXVENvR3VGS3BmVFJl?=
 =?utf-8?B?NmhOVTFHZm9ncWk5TkhyZXQvS0dLdm1kOVJnWTdJZlAxanZybnQwdXVGUW42?=
 =?utf-8?B?bUJjYWhQSkQ5RWNUSGpOSlllMnNUWkY4bFJJendLTXp4V2E5NHFpNkljTzg0?=
 =?utf-8?B?cWUzM3BSeEVEZDhMVVNvVnN3c2xTMFg4NTkxaHJRbmhNQ1RTOWJTY1JkT1hI?=
 =?utf-8?B?TnIzWERlNmdZQm5PWnlQRzBVTDNLN3gvTjlwS1V3WUFhakl6YVpOWnlrQUg0?=
 =?utf-8?B?R3VzSHhpanB2Yk16V2R0Qno2eTArZjdkWEJOLzNqUzFkSTkyWjhDdG5LWVZt?=
 =?utf-8?B?enNMU3Y3YWt2blJDZGFoOWdYOFFHV0FRSk5paEoyTUo4Yi9yNmFNNCt3Y3ZQ?=
 =?utf-8?B?eVFndmxXanF2eUZZbFd5cHZZWHAxRFBqQUtoWFlhdEwwbjNVNWV5ZUVLbDdC?=
 =?utf-8?B?NW5pSjRCUk5OcCtLNFZaOGhLZGZBRWtkb0FiVVk2NGw0NCtnaTdYQ1Y4TGZO?=
 =?utf-8?B?SmxTYzVGaThuTy9aQ2tIYVpmazVyeUJvbXQ5T3AvWUtIdXRIWURSVThoT21G?=
 =?utf-8?B?aTZHTUJFcXdzSVREK2o3eHc3d01xQlloRUlKT2hya2kwU3c4TVh2bi8zMENJ?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cc651c-c723-4c34-a6d8-08ddeb0e104c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:19:39.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSSu4u79Sz09sLDLfojBRMAbdaWZ0XunmH8hFVE4j+97hmrUPV7t32mRjTkgM0PAgXLBPERi3JVrxre8+uDDIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3488

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 1ebef5c..61cb358 100644
--- a/README.md
+++ b/README.md
@@ -77,7 +77,7 @@ lava.xenomai.org.
 See [Xenomai project](https://www.xenomai.org/).
 
 Contributions are always welcome. They follow the same
-[process](https://gitlab.denx.de/Xenomai/xenomai/blob/master/CONTRIBUTING.md)
+[process](https://gitlab.com/Xenomai/xenomai3/xenomai/blob/master/CONTRIBUTING.md)
 that Xenomai is using as well. Please tag you patches additional with
 "[xenomai-images]" to indicate which repository they are targeting.
 
-- 
2.43.0
