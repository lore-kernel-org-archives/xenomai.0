Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7391386439
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611179; cv=fail; b=giF5fIeWKw9wUM+kr9jfea1DtW73Ut8B9LhkZgvB9X7sQP8EYN8Uh188aI8dSvQvjwhFNQ/fz3QqJ9zLErRaVhGxUgMzmfLdTG+9ztSTZi81gabuQW/hUuw4vhpiMaKRTxDB8bnRHQnMrq2yB8dJ8lsa7RmAVrA5Jm5egA9cECg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611179; c=relaxed/simple;
	bh=raFgQ/xo3GusJ9b8cXJR+VQxP85v6Od8+zvwJ3K7DE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+qgjGg0Zy9fHCFpnqdW2ENhNmVVHEohlG/5zcIwgSUmcrMo0H5X1yPjj9zlcTmxMcJILH057jzQ7pTTLYJB2c61Q1P7Mn8y9UFQz1iCDqpkiKbXkDA6s/BOA76pXrfOy+De7yz+cPkDEAFDPtlqZHICC4+191Dr6WZezMKkUiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IrnubaJ+; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IrnubaJ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuqAaCXbCvHp1o9lJMsoLg6igGdBdJ/KjfR7dVRGVxEs7Brhr5sOoRLfSXlDAWs8V8CjNgAQjjtAD1qKbk+e8s2hJpajd2EB4tYiPSvuHNq1e6lPBvWd2l3QOnlFy2ywwn2GliKVobgXdt2bdVGdCoMv+T9B9nHs0tsW55u52QNVH32KN+XtgJmmP8L7aP8+7d/qWLucMzzM/dfTxritdPBvFhpruAIhePzLfwkPR6HtJjMuk6A23GUdxljV63UjVAQ0gnWKTvwZmGSpKuB21i8JD827AA/1Ifcq2Ek7pwXUFWxkh566VK0QszCIM2vLV0Qq7JRulcS3vYoxvLpE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EInB0uLYZA0TcH336Qwui/I/+51ljDBYkOtc1AgWVi0=;
 b=yeWKg869ziTpGvMIC1RcJqGl3tArlkDkPwCNXNJ8lCgTYn72ifjZ+feQ08h8gD/uSEBt4IscyA/0KfBGU/u31S4nlaWt2Tf1+3Jz6COGfO6TF74Nk5AW6nd96xdW9k0jc1UCYfc1Q7C4HWHhSm4dokQ3JdFBxrwDYgAg7gweXZC+pyTnz+LgDr0osefsL176diVMKTGj1KdgCS3Z9pbaqJUVlNY/sCM7Wj4tKpPIl8tzPfKY7GB4P3r7lJdxYLIc4dNumed7kkxOtz+K1Lje2m5P/i2/X8BrK7yVu3FraQbHBOqr8t9P559bnzyThy6ybyQhPpuSKkihVTKuDi4Mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EInB0uLYZA0TcH336Qwui/I/+51ljDBYkOtc1AgWVi0=;
 b=IrnubaJ+0XyPf/UCyXs6jg4EEbsgSI22lXYVj5HwPwn01632eGzAOt92pHN9K+5Y12cVKM/mUYewLelKikBzN2HrSffaRojeVPELmItfS+NUUYmsRnibSvMFtiKYF1VO7zACMxU+ZNR4cUPyuZvR/rGKYB3MVKGMd/S4zdRSw7dCa75OxvUWb/TbmcZ5pN+7p/S1rpR2rW7wVVwZUZdpuByOWbnnSKV+FuQXDfJeelOxtFfCjy+27qvqYL9mKdztW0cFmFCujvbjcf5WYm1l25MzRgzF9xxxv/c4T00/7QiyvDwxnYQQuCcBjkLNceZwFS9PdK+iL6b5hWqOBttlUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB5PR10MB9193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:32:54 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 15:32:54 +0000
Message-ID: <bd53dc18-eef7-41ca-bea8-a5e97fb91207@siemens.com>
Date: Thu, 9 Jul 2026 17:32:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libevl v2] build: add initial RISC-V support
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260709134451.325524-1-tobias.schaffner@siemens.com>
 <2dcc2289d120ec592539490954f262732f4966b7.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <2dcc2289d120ec592539490954f262732f4966b7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB5PR10MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e18c693-6f93-4df2-b321-08deddcf588e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	DxyUp4Azkm4r4HhBh4fA7es+WldwAH8La/P89rwVib10JHWTKLZ5FZJnvvPnnVot3OxGtCU8np9MxL5k+HDV2B6qSsGtdCBibnDo2cxQ1KjmQdQlf7RjZqPJIYP0QoL2voczyEgNGC9tSCO4OpGSiV/ZTUFESdJVVoHK3UpOTuo9/ca1ws/i1ePdABrNM0iQRNNFWrTuGaBZ+UuZ/EPHymch67a8EW21RGBXAr/cilELWsrOJs+1+wRYxyouAAI++96ZgY343kaaQgpHizdwTY0KfHdHPMUveoM2CO6tBbAeiTsH9dcoLmQprEOAuKIeaa0Tm0QlH/Su+Lm1ZLr/6G1nMd+V5YWT1AZhtoyUFtjSL13FWvlFyKhVrMcT4hBWJvHZJomFDkb/3RQKBynzHz3/QVxU8U/SwKO+U8y6F2Nfi0oi3uDRMm6p/JwboOy/vXN+QMxtVDm2hxVrKW5yMyTsf3/06MHWnKm0gDo3RHr9il9tFo9vXxaYtbMJ/QxNKyTVLGNXRX6wOLCvrcu4Y4mY7Aw01qVA5/skPF0OyYh8A1wxeG7gzf+UbKolbhOR8ZEfpU56WUQlx5EbncAItUwZ0rcNl4s9bHocBK/EKXx1gkMXIozU/n5TcTxCEVaggsMcXjqrVKGgK0eU5NyyNuNXL7W18LCm1MdiFLim8kU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3pKWlFWVHJVb0NGQ0hpeTVkRWhhNkJVR3cwU3dKenkwOEdmcWllMFBQZDNs?=
 =?utf-8?B?UE1jRWhOd0NNWlR0SlpLQkMvaDdvSlk5TUtsVk51TFYvbVRLT0dyVTE0MnFL?=
 =?utf-8?B?aC9DZmtES3BuQ2w5VEk4bXJFakdHeHJDLzN2b2ZXdkl6TjJJWWNjcDBrelU5?=
 =?utf-8?B?VDRGb0xXZkVteVMrdDcxQUJiYVV2TzVHMGYxeElZa0lnK1V3SjR5UTNTK1Jo?=
 =?utf-8?B?RFNrWlJOSFl2czRsUWFXaGhJNU5oRzlqakpabkZGckxINkNxZFIrZHFZa0tH?=
 =?utf-8?B?RXJSWDRmUGk5MGdpNmg4RW5iMlhzdE5zT3ZRbkVwSXlsaUQ2OS9kRDFOZjhQ?=
 =?utf-8?B?ZTBYZGtORXh5Vmt0OVRuZWl3b1RFa214ZXRCbU85aU5PeGVYMGcxTFJzc2dJ?=
 =?utf-8?B?OEVZVDBCa3hMUEtIZGV6bndtSCtWWnFBUmY0OXBFYmZHaklKZis1L2EzYXRE?=
 =?utf-8?B?dmpYaXc3NThkQUplcFBIVmxmcHVaY1l6R09EM0JWMC9kMFViTmFCRnNxSk0x?=
 =?utf-8?B?ZzR3UXZoc1ZhSEplbW96UEd2OTBxalBYdHFSM2t6SCthbmlKNHBQL1JYMmlj?=
 =?utf-8?B?OUdBbEw2ZmV4RWYyZ3M0N1hqSWJtc2tESGZHV0R6c1ZRY3lnTmNsUk5KY0Zm?=
 =?utf-8?B?MWFGMDF1WjNyVEJPVFVwR2ZhbHkrR1ZzVGdzUCtIVWVIQXlQd3dIc08rUUha?=
 =?utf-8?B?dm95T3hXZlNCOUxkWDBTYmppSTdXT21oTlZvbHFJZ1FwajAwdzNCaUdtcUFN?=
 =?utf-8?B?bXR5VDRxSWg2MXVPMnpUOWdsVUs5YWl0SWRuVUQyL200N1ZWUGZwRVd3c2JR?=
 =?utf-8?B?Wlc1L3dCYWlDNFMvVjZoYVRqSHNNZTVGV1hRS2w3WTRPejV3ODF1OXlkYXdx?=
 =?utf-8?B?V3pVTEJPYVQzeHVtQm1YaGFOVzJXV0hKODhGb0libENhSDRwM3pncmpKVUF2?=
 =?utf-8?B?by91M2MvV0xkbkZCNlRBMUorMlpLb0dUWnE5eG9GR3pvZDFaa2FuZzRhVDZJ?=
 =?utf-8?B?S3l1eWowdWpsVUh6bnR3UWF0QmRKeVpTdUhPajNaNnJXNDd3aWpwdGl2Q1dD?=
 =?utf-8?B?eXFlL2t5S2xJSnVqbGZsYUJCaG5Jd1BONU9DUjRwcFptajZpZW9CVkZEWGRM?=
 =?utf-8?B?NXRJdEZTWHAwSnhSYytCaTJQMzA3bVZCQWlNWlFZZ0hJWjFSUk82bkg5dXdw?=
 =?utf-8?B?SU5BS0VSdytIWHJ5Rk1SZ3NUUTZ1N2oycmMzZ3dha2VyQVVpUVhFcitqK2tI?=
 =?utf-8?B?Z1lCRlM2Z3MyWldhT3JsdUgrMEg0QTBPRzh6UE1QSzJTM0tUakw0eURQQTJh?=
 =?utf-8?B?REt5K0RTbTh5emdXVjdBQUNlM21Mc1kvcXZpTWVuS3pYTExZUi9KK3FueFU0?=
 =?utf-8?B?cmQzS212RnhmTEZHQkJkcUZYZk1wbnFIYVFHYXljYlhwUFEzbk01V3Y4RlNh?=
 =?utf-8?B?OVZUN0pMRkRtZ0MyaHpaL0I3OVA0Nmh6TUFzUHBtN29MR3ZQN3krRVNOYTQz?=
 =?utf-8?B?MHdzUnE0VjV5VnhvOEY5dlRYcjlLK1Qza01wTkN3SHhMWm1lZjBkekZwclUv?=
 =?utf-8?B?SGR2QjZYY3F5Z0pvZDRlWENXc3RSQnpwYW0zYS85d2JRZTJHdFdVTmRRZFpD?=
 =?utf-8?B?Y3VSTzBLL05hNU9GVStCSWx6RnhNb1AvLzlqeHMvMXBVNkFyWnBTTFdjekRs?=
 =?utf-8?B?bFVrOC9tNDZpN0t4ckVrbm5NckZxZCs3U2c2OU1RWEVEMVpWc2ZObm9oRklQ?=
 =?utf-8?B?Z3dEQTJVVUc3WXpCOVkrcDVPcDY0ZkdVYnhtNVR3eWp1SVFwUGxueVM1ZFFr?=
 =?utf-8?B?U0x6ZnIwTzRnTUpjeFVQS2VTMmJ4cXB4dTZNN0RmZlVHbkNhRmhVS2c0dFFK?=
 =?utf-8?B?bE5zZjNiKzR3WUhoK1NPNStBYUhwQll4YXBNOGtVTHZlWFR0dlFoYUhSTHN2?=
 =?utf-8?B?cWRoNDNCR0hnVmlGbGdjbUp4R3BUbGpiSUw4YzJkYXRxeXdUcXJNTWwvQUQr?=
 =?utf-8?B?N0NtaE03TU96ZlEraUdEbGRSdGlLU3RRVEhTcnlaUmsyVG1NdlpEMitOcUtt?=
 =?utf-8?B?N2x4aGhRZXd4MFFocmpuSzV6WXUzV3c2SE5kVDJTcHVpWlB5RlhKcVVGbCsx?=
 =?utf-8?B?Sll1YUU0M29zTU1yWm5lOWpxTTdNbWlMT3ZLcnZtRUtBUGljZHRvMDcrS2t1?=
 =?utf-8?B?eVo1QzdNNklCMmM4clNBQUg1U3BEdnI2eTk2RHFzZmM0azRTWEZ4OU1wam84?=
 =?utf-8?B?dkh1VXdyVjZFZUhWMTV5YXV1Y0t0Rm9JdHB6M2ZLcFZUTDF3ZUZZWXU1cTZx?=
 =?utf-8?B?cW40MkZIZnZjZG1wNTF0amtQZXV4cmprWDRYZytMVXVOSmpSVTZSUnlFcnV5?=
 =?utf-8?Q?AaquwpVsFFmt96Yg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e18c693-6f93-4df2-b321-08deddcf588e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:32:54.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HONl/WvFXJzu/1EHrIDN8HeYcMNAsOM7eY4Gy0qQrEJ9d+zdjYi0q9yNQgjEj3RtLVjW4JysS4ysUd+vfRSTQlrXL2LDn9LA8nypveA7ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9193



On 7/9/26 17:17, Florian Bezdeka wrote:
> On Thu, 2026-07-09 at 15:44 +0200, Tobias Schaffner wrote:
>> Provide the basic build infrastructure and VDSO definitions
>> required to build libevl on RISC-V.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
>>   meson.build                           |  4 ++++
>>   meson/riscv64-linux-gnu               | 17 +++++++++++++++++
>>   3 files changed, 35 insertions(+)
>>   create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h
>>   create mode 100644 meson/riscv64-linux-gnu
>>
>> diff --git a/lib/arch/riscv/include/asm/evl/vdso.h b/lib/arch/riscv/include/asm/evl/vdso.h
>> new file mode 100644
>> index 0000000..5e331fb
>> --- /dev/null
>> +++ b/lib/arch/riscv/include/asm/evl/vdso.h
>> @@ -0,0 +1,14 @@
>> +/*
>> + * SPDX-License-Identifier: MIT
>> + *
>> + * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
>> + */
> 
> ^^ Copy paste mistake? At least wrong year...

Shanmu directly copied this from one of the other vdso header files 
without modifications to the copyright header and I did not touch it 
further.

Would leaf it as is if it is ok for you even if the ifdef was slightly 
changed.

Best,
Tobias

> 

