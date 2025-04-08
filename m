Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2083.outbound.protection.outlook.com [40.107.103.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCD1CD15
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093834; cv=fail; b=lnzftklf6SLCnMCyjs5Fq5kHRFx2yuEGcmsSibIpQ8xeHeDnSiv202q6rRtf6sQGWgza2y7kx/A57EdQaVBR6trhuhcDDL9nXruhtNgxp4R8OrbQdXn3qQjbD0yeDwv5ZxyHUtu29z5Zw/z2wm8ESfz65pjYqqbE52Sc/pEiE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093834; c=relaxed/simple;
	bh=YroVTPf6ZsV8w4KHm+xGVyD5ZQWS3RH2r/BhNemvN64=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=gv06QND4NVslqU4DtSPOfkKupsYGh0hKTY1t4WQgVm515xF9lxnHWFH7mWlSiHRYqg9FUSKc1wHN5RpCT4+b1NqXE34/bYCbY3VqgvdAGvsHW2JywsDruD1pfS7uXSJFVqd4wqw4grv+i90qu9F17KVBBw2KZFDHZjJtkOeFpq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WjZWLpWC; arc=fail smtp.client-ip=40.107.103.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WjZWLpWC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1l49E96o3ZxGLRkvTm0EsGXCiXx/nTQrvEUpGbNqeiTTDCObm+B7raMathh5ai9cY5zm7R4AEsJTuSPvS9Ydc7nuJ2eNeIU4Mbdcb8PblpzFtRp0FpEV2Bn6d+jzFlbAvcWszTtnIyFb0PnzBqEti0TtNgfk99oHvVVlhKhulxd3glf7xi+JsDniwqTd4srr/cKYv5NgUAnRSu+JQ4kAKbSRx3q6Yyc22nIh8g/WKhQnDfgpqUBmY7VXJgi11FVNEEv+P744SdNVrabMR2jZVP/roQUMPzQ+pd9ksgoAeaA/pRgaQZeiCNUbwdN+H9raHiTVrVaoQHxglTdEiA4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psBxlmBPwjf6oJuAK5FsqMGbWqxyhelSNv0NwxcFfjw=;
 b=bMFVy6sFAQ8y3AW5C7z0bTo1VWAOrRlVC9rPZJHsnA61jKlul9qo6dcq2FdWP/gKM/VUOo0uo96T6GnN3dn53Q3S+78RDcjJyS73lIQsAT5E9I8cze5UYW+Rdqn7Z8aEUxMUE3xeJcJVbKT+AjVyR8ehTbK0PXGe6jXvv65vK1rOJnwss7PSccePr8eMoDQKvYE7WksC+0Dw95pwukwN6G+7rTSkzg04EelPNt897T8CKFI8t1YglxhMCkgESgTJFClovluqGBIGe8H3djqhmA1wKq15CWCcKVSYNO/O75zYn1XrxUx5y1i2I8rLOYuo2qeT+CvjhojMENus+B99Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psBxlmBPwjf6oJuAK5FsqMGbWqxyhelSNv0NwxcFfjw=;
 b=WjZWLpWCX6JFvnXGU0iDwiRcByjx604aZ04biuNEjoOn7sWvV3Xr9JQx8nLDmzNY4d+c9r6V7gZQgp5vFgZgqiiOyEVNYYXk6Dh2r4dv8l+Qz2VC0xkq2IE6JGRfRUy5Oor0dGnFI0nP3IvvNKUitco4b7fOrheEP0eafWD5r0HAuELHdTarTmOmn8je3P4SK1/pEojSRZpminUaM6fIgPCL8vDp0MDowWgAmCM9KtiVws6e7kTojjY/hmvlTRFz8qzcnolTPROpJ86W84PNZSTckd4oIYKkdQ4nXyNJ9rSNgYfrbTB6C6LGZGEFQqLLCsoJOAsRVHr64bDhH5POXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 06:30:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 06:30:27 +0000
Message-ID: <01cfc939-4c70-4a9e-9700-6d025793a75f@siemens.com>
Date: Tue, 8 Apr 2025 08:30:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] README: Fix example of wic image path
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea49d6b-ffe9-4fa0-965c-08dd7666d9b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmYyb2thVld1aStLNHBmZ0NlczhzQ3U2Y0JKcXRqcVdTdzYvaDkrRlR1RHRn?=
 =?utf-8?B?Qlg3dTFKZ0dxTm1mR0ZLaVV2U0pqTzZsWUJQRUtLbm4wYmhaT1RjQzJhSnA4?=
 =?utf-8?B?MFQvMmdGdlZ1TTdlR256WWEwOXhaKzRmUUVUNlU4UHFBemFEZ1d5N1ZsWi9D?=
 =?utf-8?B?NE81T3NSNkt6a2lhajdmc1BVcVRZbytGSk9Wd1BFQ2wwU3I1SjhCYkJCRDdv?=
 =?utf-8?B?cUo5Q3hqbnFzL2tZY1dCdVBoQVExVjlsUE5jQUcxTmJZcDVZMWhxUHdiZEIw?=
 =?utf-8?B?MXBvaWR5MFBFTkxpMWRscTUzMmRHMUk4TFNNcWkwOERDR3RONy84NytOS3do?=
 =?utf-8?B?K2s1eEx4d1RDZVArVlpsKzI2L0pHVTFPMENjQ3Y2TERJUmpTRXdYODF3V3lI?=
 =?utf-8?B?RmJBRy8veGFxTjNtRFBGMUhPa0FqTGxyc1ZYU2gyRHlzTVpRb0xsNFB2MTFR?=
 =?utf-8?B?ZHpJQkxEMkFyd2kyUFdnYVVxbE0vMjZST3FwQjBKWU1vbFRkZ2orbEhiY1Bz?=
 =?utf-8?B?QWVvUEdhRFlwN01iRnhPcXUrSkdnN1dGWi9ybnd2QUNyNXlvZi8xb0xUM3pi?=
 =?utf-8?B?UXdwSk1EV3djVW9nZnZ3VGxZbEh2YlFFNi9ORVdDd1QvN3pETyswZUV2OXFz?=
 =?utf-8?B?OU9Va1JHMFJJNzVBWE00T1VLRzFIaXI3OVdVc0MvcHFsb3NFZlR5bkxLQnN0?=
 =?utf-8?B?QkFCYUlkNXFTTEd5TmVJOG9Jd05za1k3R0V6Zk96ZnIrYXFic3h1OXE3SHAr?=
 =?utf-8?B?WXNrZElzWEJaN1gxTU1OTnRpc3p1WUVQM1NaSzUxOE9UQ3hlWTlqSTNub0Rn?=
 =?utf-8?B?NVdaV3FuTm01NGRkcUQ5QnFKQ0l6aUxOK0RsbDR6UTVpNVhrbUxETEpyOTRI?=
 =?utf-8?B?RzhXNFhaNDhpQUtYSXNMRFY5ZE5taGZXenZnc3FFSU1vRkNsOTBxREppbGFK?=
 =?utf-8?B?UUI3YkI1NS8vNmZVWVZZRUpGMk5DY01ZY1FCUDBtOTRDTDdDOVM0Ymt4bUlK?=
 =?utf-8?B?QmgyWFdQeDFXYnVNb2ZRUU0xTW1ScUo0bkxFTTNNR1JSczU5TXdEZHpFMHBL?=
 =?utf-8?B?a3VEMzl3RkZsZWJQamxBQVJOT0N6MG5RRXcyRTdka0xUQmc2UTRwQ0M4OXQ4?=
 =?utf-8?B?a0p6SkVDSVk0ekcxcnh6b2p4d1VIeHQ1Zk9SK1BadVNyaElpMWxYQm82NUdU?=
 =?utf-8?B?Y0ZjbEp1S1RwSHIrc2ZudTI5Ynl1eklYQnFPelNkWXVaQUdHc0N4Q3JidmhY?=
 =?utf-8?B?b0tMdzB4YWpJeUUyU0QwcnREMm1WK3FzNEkxZlk4Z21zOWJ4K3JTM0NBM3h5?=
 =?utf-8?B?UlB5eEhKWUd1cXUwblRteDh4NDZZUHRVRHJDbzdRMTUyaXJCOURLbG5SSGJy?=
 =?utf-8?B?YWt3TWdNdHdHb1lVVGZCaVFBN3JwenpRa280ZTRLV1ZWNzRyVUFDTFdVZGNK?=
 =?utf-8?B?L01rcDN2aHdkYTN6OEFUYmhEejNRamF0THpldXg4OEQyN3RiVmJVbVgyOXFm?=
 =?utf-8?B?bE1XWUZySHdLSkh1TE9aQ01uOFJJKzlXblA4NzB6TlUwYzNvQWhlVFdGcUVZ?=
 =?utf-8?B?ci95UTVZdEY1MHhOTzJuSnMyc0J1aThOa3dJcnBuZnFKR3M3Wnl0RDhkU3J0?=
 =?utf-8?B?Rkt5WnVBN0VCWE9PVlFKME1zV1J3TmRyS0FJYXBXL1lROFZ2SFRmc2V3Wmxn?=
 =?utf-8?B?T0pVQ3A5aEJLVjh1Rkw0cTV5T3NrdGk4ZGJrN29qQlVJZ3Y4NlpvZEhYbXRU?=
 =?utf-8?B?TmtQc3EyQnZqWDY3bW4ra0xtWWZJYVJIUDhJZFFrb3Y4S0x4TVdIeExuTHZt?=
 =?utf-8?B?NU81WXNScGhmTmxURzk3bTVKM05nZFp2Z0ptWGRyT3orN0hpMzYybGtBOVpT?=
 =?utf-8?Q?W5byHlPb7ist2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjFuRkorU09wVzlROWE0RFhDV0VmbDAvQWJsZmt4bExsK2pkeXMzRkUydC9F?=
 =?utf-8?B?SzFJSGlvVFp2cjJ2RE5zRXpSYjdnRjNwUjZUNGYxelZIUTJFWnpkWU4vRlJJ?=
 =?utf-8?B?ak9TRVR5SkR4WFZ2d0t5eVpobHd6YTNXaGVMTUgzR0hyQ3ZFOVFJbTZKZ2V1?=
 =?utf-8?B?YkRnWFBsSGVFL1MvUmlFZUlxYkVqRGxzOHU0cjR5SlRwekVpRlNIbGJ6U1ZY?=
 =?utf-8?B?cXJJRE1MY1hEb0pabGwxRUhJdHpHSFV2Z2ZZODFEWTY0NkRyb1l6aUFBVG9r?=
 =?utf-8?B?MmdvenZaQmFqVURMUC96SHpMWUdmbkozcFI4aE50N2R6dGhaaHRtbUZoVmp2?=
 =?utf-8?B?cjBrOGx2bFhxczVhQTh2c1g5NW41THFuenoyTGc2aU9ZT3FwRXowY1JCS05G?=
 =?utf-8?B?dndMU2wwZWpCNEVwRlZiNkF3aXJiSVpCY1BnLzNmV1h6bW1taCtyTzJPQ2hh?=
 =?utf-8?B?YjBydnNWNWF2eXlZMXdINHlQMXc4c2VNclU0TTdBeXVyRHQwMUYwZGgzV3ZP?=
 =?utf-8?B?d3VxQTloNTQ4T1lVa0JHSmp5RE5yRFdjc2g5QklKTWxmOUZ5djZrV2Q4Q1Bv?=
 =?utf-8?B?UUJTZXd5NkN5MithRk9vUFEzc1lwNHA3cnVMR21pSEM0dis0SDhHVkFWbHlu?=
 =?utf-8?B?UWNhNm9IVjZwTGs3L2VoMWFFVFNoRGxOaHpYTEJlTUhRdjRlSnJqV1RqazZW?=
 =?utf-8?B?a3pXRFFDYUl4MEs2Qjl2dW91YkdYd3pSeldYTllJR1JMNXo2QjFSOWNtekZH?=
 =?utf-8?B?VWUrdDZKMUpBUzQzSlB2TFRJemFUbnhBWTA2MXZoUkhhZzBXYytXWU1yUndz?=
 =?utf-8?B?b1JvWHlSWlk5c1NjRGRKeWo2RXhZalY2c0pCQ01rZmVYdk9ud1dGSm5zQkxk?=
 =?utf-8?B?RUxFc1hZOG01MmU1bDZESjA0TkwvTGRSRHdBVyt5VkJKd2NucXFJWGkvcktF?=
 =?utf-8?B?Q2RQTXIwQ3M0NERxNlVLQU9jTEVFcnhJVWZHeHFjbS9JcmxGNXQ2U1N0dkE1?=
 =?utf-8?B?OFVMKzV1NnQ3V3M1VlhTQXNXb1VKTER6L1lpOUNFZGM3Qy9LR1ZSUjcwaGJn?=
 =?utf-8?B?YThJSEFBbjFEVEtKdHJjNjhLbm9heW5Bc1cyOEROMEFQdG9OYnFwRTl3b1lX?=
 =?utf-8?B?K1kwMUw4WGFoUkZSMFMwQmF3Y2M5aTlpMURYR1ZzMG9rZ0x1bTNZRHBoT0RJ?=
 =?utf-8?B?a0NodStIUHFwZS9lSWFneHpBV2ZwK01DSGZsMlkvWkdxZzdvSDV1OUZZZXoz?=
 =?utf-8?B?VTZNZmU5blM5NGUzU2VKcGFGZEFXRE14WXRIKzR3OGM2ZG96OWhvczRPb2Rp?=
 =?utf-8?B?bUhCMXlJK3c0VFM0dFV6Z1hBeS9maENXSGpGeDdCaW9WdEN3Z210UXdubTBn?=
 =?utf-8?B?amkram9iZDRRVCszRUd3Q0NXcXdETkpwK00vak9ONmJpSkFqR1V4a2hyOXpL?=
 =?utf-8?B?NzFHek5vKzUySmlKM3Z5Q3JDM1d3RHRyUkJHVTE5OGd1alZUODBUL0hpc3Zp?=
 =?utf-8?B?R21YWlVzQWo5eHlvdkloN0VKZktobWJZa3hrdi91WnNnZ2IxakR1STNGZlN6?=
 =?utf-8?B?eDkrSVBQTlJWV2Vsam1pRFFha0FJdFYyY2xQa21QaUxWaGhlbldPbTVBZCtL?=
 =?utf-8?B?YWM0Ly9TeTlmYlE1OGZpRTRCZlptNFM4TmxFemF1SEF4RUxYRld2VVJhMVZt?=
 =?utf-8?B?dGVobHhsdGV4ZUE3ZUMwNUFPQXNuR0pBOThpT3gyRXE3TWxwaThnenlydEQy?=
 =?utf-8?B?ZktvRmhvbWpJOVZsbWdiYi8vNlloOFR6bWt5Wll4dmJkR3JrYTZzN3czQmZ6?=
 =?utf-8?B?TzZWMURiaUV3eG51dFBGZGN1WlhFNWk2LzdQaE1MQU90STJjN1JoVkRqWHFE?=
 =?utf-8?B?aVJXSEtiSWpUdmtMSWpWN2NPQWptWlk5dGtOeUlVTkFnNVdPWXUrdklSV1JV?=
 =?utf-8?B?eWRwOUE3UlV2cUZrU3BXWTNEeWpqYmtBOVR4S3ZIa3RBTHArSG90ZDZWb2lN?=
 =?utf-8?B?N01mbWFFZlhYMTR4ZW9lSzkzT0V0czRyN2FHWHVzVmh4WXg4enZXZWw0anMv?=
 =?utf-8?B?UEhHMktHR0xtWmJFN1ROakV1TGEzVVZRQnM2U05lamIwd1FPZ3lzZVRWc3Y0?=
 =?utf-8?Q?RmpkyBAJkd4BQmgp3VpvXowLe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea49d6b-ffe9-4fa0-965c-08dd7666d9b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:30:27.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJILaJVU2sBtl7F8sxTWMzi3mQKCXfHRcOisxHSOIQWa1PaWr1Jz2lYI7oqO0ZQQv4SKovZZ7VwnWrhL3iem8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8683

From: Jan Kiszka <jan.kiszka@siemens.com>

This was changed in isar long ago.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 03fcacb..7c9869b 100644
--- a/README.md
+++ b/README.md
@@ -35,7 +35,7 @@ armhf(`board-beagle-bone-black.yml`) and arm64(`board-hikey.yml`) targets.
 Each physical target will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run
 
-    dd if=build/tmp/deploy/images/hikey/demo-image-hikey-xenomai-demo-hikey.wic \
+    dd if=build/tmp/deploy/images/hikey/demo-image-xenomai-demo-hikey.wic \
        of=/dev/<medium-device> bs=1M status=progress
 
 ## CI Build
-- 
2.43.0
