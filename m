Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4E78C7D
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067582; cv=fail; b=afaj72K1qPaUlyS0Q236vwzK1rHSe/32mT/WKwSsZdvggV49mu+kANpuG+L1Mv+yf+T8e4hVaA62/+XSZYf/aCGJ1YJFJPBpw66VPyYfEjZkHnacmE6RTBXwq4+0g14upcmxLrqg091bqT09HTp42vGooz4i53ulfpkMSxPXti8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067582; c=relaxed/simple;
	bh=SfcQasgZ5E3vRJKcO0dZBhaWk0qcXoT3qLJQt5Gv7pA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MwjrC5dSjzTuDKikg+xpfMAis2xkzmyyUolhtKreoeLY1TCUJ+MPNwPzcunZUrldTzwopwGISdTsEcndfhCGFdWIZOWpT4dh2sCwdtBk5o6unzM6GV1jY/Icw1APIlffHAfLzYwV9XXwWpu6gor5sqP0LARvXJJu84y+ayqrL+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AEwI7ctK; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AEwI7ctK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7iFQLr086ejx8thT+Phrkad2pUkWD8+6g7SHAAIgMhPpByTshcXawRbjgr0gqENKGwvsVeS6KbIjsIXwki9YqF8elzV/yCIoIVBY1/gXiirpUOlbfjbM430VeHDba77J6HV2B62NWDQftv3tgZk9kizVsCvZKyBpGHnn2NtdZtPp03/KoSTkBtTJ5HiRzhRqhBbp9ZTNKnAiRA3OBNGib65A/wY8NAe3cbqOvTprYE0BX+YdU88FkQlKZcFw7T0yystu5BYaQoFkHVyE88FmQxhNx6+7HsfF4AJE5TGOqkVDgoj6qoZuFC/yYGCyGYVJiM660zixeg07YyTNuLICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGiHkvnZ3Vt4wjDfuZ8JD2H6BNu2edJ10b21MM44rtk=;
 b=DDG0pucf2v0K2HX3AYQEYl/OmVSuG0wugyHnviObd3Dcvc3+ulwDL4DDVwnKqT9LM8wN4MAEhL97Y2Y86XIdYimIZ+zez3WebxA0KDqbynpm7+vkVeNVmUKjFwaCPlM8cUFGONJogPCdPrHtNxjPrm4mp0zAcjHQ7xUnZG9YaqwMEYayv3MGjVSyyM9OIO9K4lc4iPsfLPUM6SuUKKVdvkaohFv0OyAJx9YpTTDt6jkDhV8Vlnh4OiDZHtYoPEWSNLLP1twrSEQPf9ZHu6TcMWHSJuKq0JXOibGhpd6Qt7D/5U94hW5tgydvMlkD4O4GDW0N52wPp3KGpCaOMKl3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGiHkvnZ3Vt4wjDfuZ8JD2H6BNu2edJ10b21MM44rtk=;
 b=AEwI7ctKu5ZN25A5B3Ra/6HGkGUhEXtWPQvrfRYulp9YTE2i+OkR1fqjcYlj0ukozvlOrSDKkt/Pe1N1Fk4rO/DdEViXS5V/bzqlDSMRSeIalGlMAoT4vp9gT0OPQ213SdvoSkyb7kg7cfm6+z+INALnh167PDNYKVmo5SRvCOmNGUrcIkTLa2E3bn5Z48k877sRm65LWP9aLzdf/qV280tcDtWXR2y9uy7BII3z8ujccFdMvAeMx2SBFEvIa0v5pCvO+HFiEEy/j6OHdWlWq62VCS2ymOJBWKy+/E9mHGHedspUrDT1NpO7YNqiF3E5b54tvU/KHq+1KEAyL2MGjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 21:52:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 21:52:55 +0000
Message-ID: <6239feef-9326-4ba9-a744-db774134b128@siemens.com>
Date: Wed, 7 Aug 2024 23:52:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Enable sstate caching
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: 73188e8d-d11b-49db-ef86-08dcb72b4b29
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFV3RWZDTng5UktpV1h4TVBra1RoalhMbGVIZ3JxQm94TlpWVHk5YXhtVGpY?=
 =?utf-8?B?dGZhVlp3Y1A5bXI4K21FdWFoT2xIamRiU1Y4ZG9iaWlxM2tOVDRuWXFZV1NR?=
 =?utf-8?B?WW1hSFEvR0ttZFBtVzVUL2l1djNYTjV2cExJMnV3dGVTUUQ4TDNkUEhKcUwr?=
 =?utf-8?B?cnpTUExSc2FBTXBua1ErT0ZQRisxbXMwRFRPeVVNSDVEYWhycXN5MzBOUFp2?=
 =?utf-8?B?VVZFSXhKSkExbDdSUmpRYzJKSTYxMklhTmZpZ1lqeU9OWm8wMndXVDA2SHdj?=
 =?utf-8?B?eTRWNlZMTmhjd3RjQ1lxOVF6eFk4eUx0d3o4ZEdzeGhUbHI4UjFLYUUydUFT?=
 =?utf-8?B?NzlFUWZhNlNnR05wUXppUjBva0dJdFVxVjk4RzcyMm1TRHlQeHpYbitULzNV?=
 =?utf-8?B?SlI5RWMxOUExVUh1bWdzKytmN1ZmL2tpSEdFeEZFSVRyd3JPWHJ2SHdHN0ZE?=
 =?utf-8?B?YlV0OHNaZEYxRXpESUFyYWdrc3lSMG5UT05jQ3lmVDIzSmV6ejFCN1FiNTVD?=
 =?utf-8?B?ekpZWnBVampEN29TcVhhRllqRjJOTTBkYUdEVUtIKzhnbElOSE1OQTFvbFlK?=
 =?utf-8?B?clkzNktMd1JKYk5La3F3NUlFZVZjVkZGRE9aL213THJvRXgwMHNrS1c4eXZz?=
 =?utf-8?B?bmt5NXdzamNSd3BpTFlWTWVIOG40QWpCVzdqWm9YeU5HWlZ6TGxhRHZEeHZD?=
 =?utf-8?B?RHc4aXF5VEpLcE1yakVXVWkvNjNpV0M4akNoUENNYW9FLy9zWUptMGltaUhx?=
 =?utf-8?B?eDlRTTlKVVNhZ0hwZUQ5SWZIZzgwMFN2WGRIc0p6VGd0bWlCTUZNUkh5RVVW?=
 =?utf-8?B?aEVQb2N5WGM5WUhab3Z5SlZCbjNMeTRRcVFYM2t3TG95aTk0dE95YmlPK3g0?=
 =?utf-8?B?aWMwODcrdVJqR0lhOUkvSnU1Y2FrOTEya0x3RXIydFNFY05vUUlUMFFyblhK?=
 =?utf-8?B?cW5VaTRGQ0hHV241cTZ6SkdnaHF6K2JLRzU3bGdDQjRjdFNBdm9JMTFaVUtB?=
 =?utf-8?B?WkFjWGRkUVJLMW9IYXJ4RFFnR25yRkVQRkJtcitJbjd5QTg3cEZidE8yTkFH?=
 =?utf-8?B?Q245V093YXJQeitXRStrdEQrV0VncW1sb2VRZ2ZTYjh4TTY4WEdjTGV4VzBx?=
 =?utf-8?B?NHdyazA5aER3c3o5aVd0NjZXN3RBeUFHcUh1Q2RkdmRJWW1JNExFcEtVdkh2?=
 =?utf-8?B?Z0FkZkEydUM4SVk1eGR0eGVaaXpoV0U2U2thOGJvMzRKaEhLVVVmYW9GcHN4?=
 =?utf-8?B?UnBZZkRZRWMvR21LN2pxZVd2dDNZSGdXdTkyQ055NDNtYnZIa2lJSVNxV3Rt?=
 =?utf-8?B?RU1HY3N1L3JaVy9yUFQ4NXZOaThFQmo0Vlk5Z3NjUk81aytaSzhrYlgxYzdk?=
 =?utf-8?B?a1BrTHZlSVFHK29aazFoVnZqanV0YTV3a2w1QzkyZU1XYTcrbGdlZ0p4ZlZ1?=
 =?utf-8?B?eVBscmljVXBVRkxZZ2FvUGdWNXBVQlc3MEV1VVNEUnpPQjRaOFkxdkVteWND?=
 =?utf-8?B?WFZUVWRMbE9rNjREbkRvNm5TN1lldTZSK2xHUnpvRTYwT05QZlJXM1JGM3M2?=
 =?utf-8?B?UC9INnJJckxtTUNKNG5YYUtBaloyN3B1aFhGQm9WMlZwbWp6SzIzYXJHSW9G?=
 =?utf-8?B?eTgxTFV2OTh4R0l4eE0rL1ZNYm9nL0ZqVHhZaVVLditabFpCWWx6aGVtSm91?=
 =?utf-8?B?TU92ZlpwdzJiMFhqWFo0TFA0SkxqWjQzL0RoK1J0SWZDLytTeDM5cm5HZ05J?=
 =?utf-8?Q?0qS4ZLaiXgB3EUU+ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wno4S0pkUUZzWFNpNXV3MENEMHlzN1VDb0NpeUpFSVZWTHZkOVdSRHpkUjht?=
 =?utf-8?B?STBoTEZaUS9NanlwUVFBSC9LdjhJc0RBNUpIN3lGYjQzcUZwZk9DVThHdVp5?=
 =?utf-8?B?N2NqcU9mUGdXQm1TTFFQNTY2a0JPMGlaQ1llT1loOFcyL0poSmwvTkJsclJx?=
 =?utf-8?B?b0NwUVliUDFMREFnYm1IbzFHTnE0eHZFT0lyaGNBUHR1eStWbk5ISDVLQjUz?=
 =?utf-8?B?akJ0Z1JoS2JGUjU5enk4SXAya0pEVVN5cHhMaUxOakpTbWpKMlVvdlFBanZt?=
 =?utf-8?B?Mkg3NXVvUmJSc0tFeStXMG5HeExEOHNvYlY2c0hZSWc0VWg5WEZZc09lKzlC?=
 =?utf-8?B?bk5oUWtMMVJuMmNadzA5WEdpa09tREFoMDNvZ2VhWWFJOUhjN2orNzBYME9L?=
 =?utf-8?B?QnZhWkd4UXhPUGtOdHc2RWxKQnphMnZRWTFiYVMzUkpWdVVzc3hFQnFuY0Ey?=
 =?utf-8?B?bVVwMHBMWlcrR3dmT1pTYmVDTzMvOForaE1oY0VJYm5UOUFDcktNMzg2WDFa?=
 =?utf-8?B?cXZlakJLQUw5NHQwRGo2SXp5TC9tdmJHV1JZbDBIZkZ1TUtVK1RSd2xvdE1w?=
 =?utf-8?B?RUxBZFZZazQ5S1RkTTBmbElhWnpTNFVBbkswaVc5RE5aWjhpR3VKbGxCNFND?=
 =?utf-8?B?aTdtdkNub0gwM3lCbUxUSjNmeEZwL1RDVzF5WEN5cWFzYXdxd3lXaHVVRkhL?=
 =?utf-8?B?YXlmWmRDRUEvM0x5ZXpIYVlLaU9VT1NhVTF2Q0lNMW5yYkNWY2YrVWNQOGR3?=
 =?utf-8?B?R3dSeW1VSnFhRDA1Z21PbjltdHhneHVSbHI3Z2FZc3VmRkdSM0tETURHcS81?=
 =?utf-8?B?UzZGTDc3aTl1TnFnMi82Wngzc01mVCtmbUJpenM1aDg0WHR3aG0xcGhwdW44?=
 =?utf-8?B?WWRYRUxiSG0xT0ZXeSsvQW4wR1FNSXhwV29lN1VQN0swMUtBZXRucVR4cERS?=
 =?utf-8?B?WnYvcGY1QkZxUmQ0NXBHaW54eHF5Y3BOTU8yZHVVOTAzL0hLRW05azkwckEw?=
 =?utf-8?B?VTc1Y0hvdFFha2lvVDVNNlAvMW1ZZnZhZ0Y5VWNaN2JYMzBpc3V0MWVpU05v?=
 =?utf-8?B?RFVMQ1FkMzZwY29UMVpCc2dMRzFVTlMyUmU3aFQwVVlaVzNrd1NZbzd4Vndl?=
 =?utf-8?B?TWxseEpmeUdJWnJ1ZHlSK0NtSTQxOFROZ0grQXhpczRrK2pzMForNys4dVh2?=
 =?utf-8?B?UmNabzhtYVBIZ0cwdEpycC9MTDBYZWlKRGh0dEVDVWVsbGxQSEtVWlcvcGRD?=
 =?utf-8?B?a3hBZS9SM0t2eENVR0Raci9lN0s2aElrTnhqOUdGaXk3QTRybXBLN3N3aExX?=
 =?utf-8?B?UWRycHNFSWsrNFBSZmp2R29lcDdqMCtpcmFHTEFWWG81YW9lVVZOZUhIbjFa?=
 =?utf-8?B?TVFRMlYrY3BvcWUrdDVYQ2lJeFBIb1FvZ0lCRlp0UnNsNUJtMlZUTkJtRkVh?=
 =?utf-8?B?UnFsdVFoL1ByWlhTNnJKNFBqdFNGaEZzVGRrWGRaYjgya0NWWVc3dVlCbVlt?=
 =?utf-8?B?RUdmaDZWdkhVR3BPNThrbGVtcndpNTJCbkV2cjZJL2RSYlhBUjVsWW9LaG5k?=
 =?utf-8?B?TWUwTE43SG9tZUxTV0kxRjZxbU1VZ2g2Mi9JTjcrUStmYXBZZU9PamNuRkNx?=
 =?utf-8?B?Y0R6YXdMOW9zSSs1RjNUemxPYzhHSGxPZXAwbWEzNjhST040bWkvVHhTNFgw?=
 =?utf-8?B?cUFWMzY1L2NmdkxIUm1INjcvVG1kVFFheU92WkpoZGRhUzRVTmdXbWZkS2li?=
 =?utf-8?B?MjFmZGs3SWxoRWhzWENDU0U4a1ROWnZockFXTWlZWTJKckZVR2g4UnpvM2pI?=
 =?utf-8?B?dkRGTUVrRDhiK2RzalVoLzdiWGRxcXBZcUtVeEdjM0dGYmNIOGNnc0NGTWpB?=
 =?utf-8?B?ZWZBV0w2dEpXTDF1cExhQUg3Z0xzOEFNZ2lZa2NUdVJ3ZDYxZWpObFAyTkF6?=
 =?utf-8?B?cjY1NlJadDh5amU3c3RWZ1VkcDBXY2FkMUlVaFYyN3JUVGlQL1BHRHJ5TDVn?=
 =?utf-8?B?RW50d1FDK1RjVzVpWm9Vb282RCtNOUNhOHozaC9BNXdqY0VQaTZmcGU4MWd1?=
 =?utf-8?B?TWFJU2tXU1JERHlhSGNzRDVmdG5DNzhVMHByNzhaM2FEQWpHWCtmUkliNXNp?=
 =?utf-8?Q?KI7fOghGFDjhvZ2qtDwWH4YEU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73188e8d-d11b-49db-ef86-08dcb72b4b29
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:52:55.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sy9SektHKQ6QC5oQL2uRi+zfER7uNOsSwfOJFC8yRP4t+ysbE3+nv7yyol1VI1CPKbvZuXBh72laQcRhk1U4ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5405

On 23.07.24 16:08, Tobias Schaffner wrote:
> Enable isar sstate caching to an aws s3 bucket by using the
> SSTATE_MIRRORS environment variable.
> 
> The isar-sstate script is used to upload, analyze and clean the remote
> sstate cache on every build.
> 
> Cached artifacts will be cleaned every 14 days. This can be overwritten
> by setting SSTATE_MAX_AGE.
> 
> Credentials have to be injected using the AWS_ACCESS_KEY_ID and
> AWS_SECRET_ACCESS_KEY environment variables. This is already done for
> download caching.
> 
> Currently the size of the cache is ~20G in size but I expect this to
> rise to a multiple as soon as this is used in productive environment.
> Keep an eye on the output of isar-sstate info.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml | 47 ++++++++++++++++++++++++++++++++++++-------
>  opt-ci.yml            |  4 ++++
>  2 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 1dc05a8..f5009e3 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -24,12 +24,39 @@ variables:
>    TEST_RUNTIME_SECONDS: 300
>    TEST_MAXIMUM_LATENCY: 0
>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
> +  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
> +  SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
> +  SSTATE_MAX_AGE: 14d
>  
>  default:
>    image: ghcr.io/siemens/kas/kas-isar:4.4
>  
> +.sstate-prepare:
> +  script:
> +    - kas checkout kas.yml
> +    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
> +    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
> +
> +.sstate-analyze:
> +  script:
> +    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
> +    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
> +    - echo "=== Check for cacheability issues in build/sstate-cache ==="
> +    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
> +          --sources-dir "${CI_PROJECT_DIR}"
> +          --build-dir   "${CI_PROJECT_DIR}/build"
> +          --pedantic
> +          --exit-code 0
> +
> +.sstate-upload:
> +  script:
> +    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
> +    - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
> +
>  .common-config:
> -  before_script:
> +  script:
>      - if [ -n "$ALT_DNS_SERVER" ]; then
>            sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
>        fi
> @@ -40,17 +67,22 @@ default:
>        fi
>  
>  .build:
> -  extends: .common-config
>    stage: build
> +  before_script:
> +    - !reference [.common-config, script]
> +    - !reference [.sstate-prepare, script]
>    script:
>      - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
>      - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
> -    - du -sh build/downloads/deb build/downloads/git build/downloads
> +    - du -ah -d1 build/downloads
>      - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
> +  after_script:
> +    - !reference [.sstate-analyze, script]
> +    - !reference [.sstate-upload, script]
>    cache:
> -    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
> -    paths:
> -      - build/downloads
> +    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
> +      paths:
> +        - build/downloads

Strictly spoken, this chance is not needed because we only have a single
cache entry. Anyway.

>  
>  .build-qemu:
>    extends: .build
> @@ -59,8 +91,9 @@ default:
>      - if: '$ALL_QEMU_JOBS == "true"'
>  
>  .test:
> -  extends: .common-config
>    stage: test
> +  before_script:
> +    - !reference [.common-config, script]
>    script:
>      - scripts/install-lavacli.sh
>      - scripts/run-lava-tests.sh ${TARGET}
> diff --git a/opt-ci.yml b/opt-ci.yml
> index 01d5c07..e1466a0 100644
> --- a/opt-ci.yml
> +++ b/opt-ci.yml
> @@ -23,3 +23,7 @@ local_conf_header:
>      IMAGE_INSTALL:remove = "sshd-regen-keys"
>      IMAGE_INSTALL:remove = "expand-on-first-boot"
>      IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
> +
> +env:
> +  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
> +  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}

Thanks, applied. Let's see how it will behave.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

