Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F421D86D6
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126535; cv=fail; b=mlJoeqWYvRI6WZQYZhkypRl+jkzWdh1VShBzF9EdOb82jboAV0Jazb8CepN3jNa79GEwjBVryJdmUlXr7KDYnpANf3DHSByumi4rguLyNU7N390mjzrNGxf+VNDx7Ycosa3xDX+1+/BZtvX2nE5yQ7H8W8sxnP70srg3wQ+ksn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126535; c=relaxed/simple;
	bh=pmZRARENTPCIegIO3Sng4b+QApWc+FZl3IPl4BlzSA0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=somq5o9zCdym8IR3dnTWsJYbkVUqIhWmdWKaT9OxnNs+3/+YfXviwnIx/zOnMihCOlqST27ENdvWtFaW2H2gCfbzoTfKTG4qdlwA+VkIQ1iAyrBEsN9z4bEF4pxjTL5otkq9lW0fdWLqF46fHeg6b3XKPoCTPmpLYTFyZXj6CxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z7StjesJ; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z7StjesJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+vcFDT2muVp4WdRORWsf1I+3qLJ12AvnTBtZwTVRJfmXMFsicu6pMtl3cE3QeJ803pexBAuaoGG9qOpLqzQ+IcvuhCw00TF4c84+/O3u0WhqCvw3DCtscUaDaV9iqbrSxoy5uiBvPJ5dMvBfqTimx4CMagz6hyvLypvLWr3YRYfUPzPkv62fUzgP08sd4YwINJX6nj0zAxEQb/UnwmOPUuP7Fs9MzuTUdmlg0RYgXwtHmX1YlKlZ9fzYow9zCQ/55aVekjyqT7MaXP3EMxUa6sMK0aARvF4Dbos6MxCGFjeD3FEqPHpW2FeGlZIPgSh3mj9YWROxWNYfddMX6Egog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaKca7Y5ekUaRUFK7RLydBgqTPebrWb40AQXcRpdS+U=;
 b=Tfe3z2vIe65x/VB7GDcH+TbGudUqafEyyxNdr+GGmk58wNzSvBasp8AY0l80jmIiyGFQlUmsrJnwTVjGvFzVp5WUv204Rc4V7wUOks2o4z9Mpffnqu6K+H5f3gSqBGhKpmlc0jo9O6Q9b/bbCv7tGGytiVnNXFOhnlZ3Nu7o5Tnw5cpM8ZxqjnfkvlnXCAdlsyW2AT7YMIm+TdspfcIARNlxLxTGeAwjksHeUQKDrpicwsRubCGBeT8f8uwpabfFgVMRT9oOkf40HVKHUcfEq0acRgxDHAnxEya3W/isEjX1hpYtTBqcb3yAw1PFiLBN++1VQTPdZTc39sKZCsN0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaKca7Y5ekUaRUFK7RLydBgqTPebrWb40AQXcRpdS+U=;
 b=z7StjesJFmJsHWHH4oRIboQ39p1pewYGvXeZKt6q2xZL230zAXU86vuOKtRjZFTIMLXI5GYlewaf1UczaGZbkjYG2sGAh5O9vrQrYdG8w9rU5osFbGMXnYUp+zccaEZ3gUjR/77vxPbL/SPho6O8j0enFpryrPU85CRn0qJfVg9HU2bOG69U7F9sLrdzTnpSUU/mJERslWmRa4cnHj0ihakyfliR5/bPwzN+E73ZHlEOzz8NallF9hfVNgGj4ZVP4SUZd2BvVB5NYzbAOpZ1kmaRSgYOBW44tUvlvVyFpHQ/KQwyua6e/MnXJMvbggVXf/UIm+E1P43goovYT4BjiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::8)
 by DUZPR10MB8070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:02:06 +0000
Received: from GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a379:4409:568d:91d2]) by GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a379:4409:568d:91d2%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:02:05 +0000
Message-ID: <cda878a6-8bc6-444a-9127-14de86579c49@siemens.com>
Date: Fri, 10 Oct 2025 22:02:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv64: Add support for RISC-V architecture
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
References: <20251010101717.3759565-1-tobias.schaffner@siemens.com>
 <20251010101717.3759565-2-tobias.schaffner@siemens.com>
 <2225a246-5cc5-45aa-a5cd-8434065ff69a@web.de>
 <1c53c64e-c23b-4978-b595-ef150e7eb7ef@siemens.com>
 <962e5de9-5659-4a3e-bbf3-d408a14e21f1@web.de>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <962e5de9-5659-4a3e-bbf3-d408a14e21f1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:8b::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6345:EE_|DUZPR10MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 37aba3f9-1970-4091-614e-08de0837e2dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q01LclpPY0x4RlFERmYxR1crenlJbVBWVUtodlJCeU9Xa0lqNkY2WC9aeUE2?=
 =?utf-8?B?T215OGhZMUdzN05vSXNpLzdGbGJia20vSmNoOTdsMkFaRzJiQkJTME55TmlR?=
 =?utf-8?B?cmJSSWt2MGVTSVVJeUFlV3MrNzIxL0F5OW5JZmFHZkFyNEwrRGFaenBJekpq?=
 =?utf-8?B?bkc0SDR5VUFsRzBaMEJ6TVBTWVVLQS9ua0J3cG9rMEdQKyt1TWZ3eWhDNHFK?=
 =?utf-8?B?QkFOd3lDamJJSmY4aVR5NUxIN1MrbUp4ZVhKWGhxbDM4RGp0R0xJT1U3MDJH?=
 =?utf-8?B?TVduYUJDdmJJUTUzSDN6bDVFTGpVQTVkZUhpMXZpcE1vYVdsQVF3RDlMWVJB?=
 =?utf-8?B?cVZGSkppM2E5M1lKSXZZeENRdmNsZ1VNekYxWk1sTndUb0Y2NnQ4Tlc3cTlO?=
 =?utf-8?B?WXZndGU4cDFEVTlHNzBqMm1EK3RKeEFpYWFpb3FPTEUxa0ExQ3pMTjhzbzlZ?=
 =?utf-8?B?blQ3ckdRd3BabWdrYWxoanQyWjYzclU2MXlmTWxFWmVnNUM3RXhmcmhZYnh6?=
 =?utf-8?B?SGVnN2xBNWJSQy9pUDFBKzRtL2FncUFRUzM5azhpTUF4WFJrZy9SZitSeHNn?=
 =?utf-8?B?c1d3L0tubWxqY0F3VlU1UzVHSkpheUZOS2E0UjFsQ3c2QXlSVS9mMUFLSitD?=
 =?utf-8?B?a2dscUtaM0RyTU90MlRCdytVRXQzdnpNUERBY0dTSk9hR01TVmlOd1JiWDZr?=
 =?utf-8?B?SnFKcFo0UC9IOUJqNGk3K2N3NTBRUjVSN2MxYkhsVkcyWkQ5b2RacjBEdUt4?=
 =?utf-8?B?UTF3QXB1TUtUUTNPN2E5MXJoVE5wVnBWUTZGenp0amRvcGNxM2FnWFRNbjFm?=
 =?utf-8?B?WWkrdHgzNGhJUkZnSWJTZUVaU1A4cDd2OEdKcUpzTjlva0grK3Y3OVRlamJp?=
 =?utf-8?B?THVBR2xJUXptc3NMcXM3LzNXREw1eDVBampBZDIxQkFwRkhSUjgzTmMybTdQ?=
 =?utf-8?B?ZlA4ZVBUdkw5NmUzUlJaL2NUN0FXLytCdlN0QWdVWG1NckVNS0FJMDg1dXlp?=
 =?utf-8?B?eU4vdjhzeW5ZSmZ4UGgzbmRta2FtcjJ3WlNscGlabGxkQXpnV1FWS3VVTnc4?=
 =?utf-8?B?WUhPWnZOdWVTVDhqcmVrc2duSHlzNThFd2tIL1VBRmY1WjBOTGNUV3NEajRF?=
 =?utf-8?B?T0dpTHNQOTZqbHNhQUd4UWl6d0pWZ3hUYVRHWlBJVTdGMHQxRDhsNk5lNURJ?=
 =?utf-8?B?Q084TVlrWmZOVG1BTXhzYWhxNG5oRkZod3lVbTVPTGxYMFFaT0J1eUJFR2py?=
 =?utf-8?B?MDJ2YlZpL2thT2xieExpQXNPQ1VvNVM3c0ZBaTYxQ1J0Uys5bDVyUW1vejE3?=
 =?utf-8?B?OW9HaFhBZUFGeHdEV0lrUUlYdElSb0ppaWNjL0hHTlZnN09JSXlGbmhjdlJQ?=
 =?utf-8?B?SE4vMExVUEx6UkRxS1RwSExtcTdpalROWTRFRlpuNTJITm45N0haYlhNU1U2?=
 =?utf-8?B?MHA5aldzejhlZExNaENlSjM3UjI3RVgyWUlmQjcvWURRalZvL1ByTTFNZzFH?=
 =?utf-8?B?MmVoaUVML1FnYjBsUmdTQ1J1b0g2SmlyaldwcjRRYkFWWU1xKy9Rbm5OTW0w?=
 =?utf-8?B?OVpxZFRSZDBuV25lKzFEZWxRMHFVM2s4L3hVSEQxN2d4UGhmNThvdVpMcCtM?=
 =?utf-8?B?RmRuc2JCdjZJMUxJTWRTMWZYcWZNZ0pXWkZRQXZCbUxXYVc2cGZFd0V3MzFR?=
 =?utf-8?B?SGRnR3laYy85UW9UZGJUMzVDRWdIKzBBOU81V0dwU0VCZHFxQmhhODFuWW1T?=
 =?utf-8?B?VUtjT1pqVlR6WTgyWFJ6azd3bS9Tc2dYL0tEMmxKdHpraE5kVU80dmRlRE1K?=
 =?utf-8?B?WnN3bGtRL0RNN2pBSDdDenoxQkd1d1I5MG1BSWw1THZCM1ZHWTN3NTlUS1Av?=
 =?utf-8?B?WkN4LzB1R2M5T0t4THVFbnNhWlhNMFVUYXZ5ZzVFSGRCODJYV1ZkcDVBMXI0?=
 =?utf-8?Q?hTVMTbluUUisKe0LfSDeRt34At9J0Coc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFFBdjNJUFJ3RkgzMW55YU01YXRjZnNoaWhTZjlOUUxndkFqRWZTdU9QM0V3?=
 =?utf-8?B?WWFLaXZGT2QrZlNVTzAyVGo0eVg1bDE4Q2txeHRSZXl1SnVZRmR6Q2lHNkxO?=
 =?utf-8?B?Z3QzekpBQ1didlBFMnNJM1VocUF2SVMxL3VjcDlCSjczTkN6Zkh2Qi81Qkpv?=
 =?utf-8?B?NXkrVGRYY2MzNVRPSXFvUURMK1p5dWtsZEV3SEJqVFhhNzdHMWFmV2hrK1JT?=
 =?utf-8?B?KzhhcU9YRS9YZmxHbEFWSGo2Sm1HWm9mR1NrVlZub1BhMU1TZFg0V3N4RTlS?=
 =?utf-8?B?WjZvcjQ2UFJ0RW5sUEJQOGVxMWhIZ1Q5UjZVN0piM3l4dDF0NHU4amx1cWcy?=
 =?utf-8?B?V2VvZ2JuQlhoM1hidGNSdEJZS2l0VEZDUld0VzVWYWFiclRPRTJTd3RESHlO?=
 =?utf-8?B?OUt3QUZMRG9pMDB2Uk9TVHFmdnRPakgyN2w5ZWtRbGxsbDBVK0FYVGlHUzlR?=
 =?utf-8?B?VEN0OERoL1d6RXBhd2hGRFhwSFNIdUxEL3RadWdPWU1tb1p6Y3pjT3hRK0tq?=
 =?utf-8?B?NVJweGZlU2V1WDFRV1RMdmJSbzZnOUhDdlQ1QTV1WVlSaEQ5dkFlL3ZZeXpM?=
 =?utf-8?B?VVRZdTZEeW8rN3RkZFFBdWoyL0lVTGVCN1VVSHdXN052ZHpOeEhveWM4YVVz?=
 =?utf-8?B?WFhMUGRKem1CUzY3V1N1eXE3R2MrQWxVVEkzVFVUMDFmVzZtb0dLNGNQb0tV?=
 =?utf-8?B?c1cxTFRBTyt2T000ajJ1djVySjNMbUNCYTVaM1lFcE1jNTZ5TDd6TWhMTmNk?=
 =?utf-8?B?aDhUTGQ0dnl6Y01hQW1iVmVhMEhCeThCNDZkbjMxcHl5U2dycFRidlh5eVZ5?=
 =?utf-8?B?eHhkVWg4Mnl3ekVCTk5CTWVqMVNxL01BMzRuVmNLTXhlR2Q5YUFQMy9ZTk9W?=
 =?utf-8?B?Y1ozRCtvVFI3ck4zRS9rVVo1b0pDelNQbHQ0eFpOWkFheFpraFVGMGZueXJu?=
 =?utf-8?B?MjFOZlVRVklUSFBsclFsenJUOEhPY0hIbyt5amgvem5aNmZ6QllGYUhobmlt?=
 =?utf-8?B?czBHNGNnaXlrNll6c24zd21xS0NhZXFiMUQxRzAxODRlb0RHeDJKU0NCOG15?=
 =?utf-8?B?WnRrTndUVzNMeEJRS1RsWDRsdnZtSUhoOEE1RVR3SlZPYmI5d0k0U0twY3RZ?=
 =?utf-8?B?QTd5UDdMdUlsZXYyQmVYYnk4TVU4SkUrTWp1YVJHajBYQUlZZkpucFhZWWNp?=
 =?utf-8?B?a2s5bHFKeXJZUmJkdHlhOGxEUG5RRDlSMWNYYVBHZVZzQnBqT1ZsUUd1K2NW?=
 =?utf-8?B?d2FaaGg3ZWh2V0FuTU1EZGIrSkZMZTVKM1IybDMxQWs5emsrTVA1cll4Znk5?=
 =?utf-8?B?V0NNZG9NS0JJRGErazJzR2pKVkxnY1hLamZ1amxUQThTV0gvYXVodFhERE1i?=
 =?utf-8?B?Z0Fwb3lCS3U1RG1sRWVxVjNkdVBRb0l4amxtSzdZd2xVZUhHc0piWHVuMXpr?=
 =?utf-8?B?MW5FcU1JejM3cmZjSjBFVW1qL0V6VUFmNjU0eFh3MWxEUVFmeXNqRysvN2xO?=
 =?utf-8?B?L1hFUXhNQlZQbUFDZ0VUVHRLM3gwbDk2VmZpNTF4dTR3bFc0L3NBWEgzUmlY?=
 =?utf-8?B?N01BbkNINCtXaGxyZ1ZuRGhxTzdHRW14MkJ0NlkrbEVwdStMeUQ5MFJtZkpS?=
 =?utf-8?B?a2YrS1NiT3p1bU1SeTVvQVk5RVRnK0gyUGxWQkVvWHdBSGZqbVVReDhJUXJL?=
 =?utf-8?B?UHpkcFd5V0dObmttOE16WXNZTFI0Y2pLbGVua3NGcFhSMC8ySW1oN2ZHMytM?=
 =?utf-8?B?U3JQS0N0SWk2MG1wTmkvZExwQmxhZVo0c1BrOEc4UEEycmRnVkpORjVCZlVj?=
 =?utf-8?B?SHhBMEpYZ1JCd2lDRkt4aU53Tk1MRzA2aE9VT3RvUC82NGpuTDBuSnlrMDJa?=
 =?utf-8?B?WXBqUFBnZmU0Vzl5RVdpbU1CcFE5UjlNdVZiVklyYW9zS1ZKNmlXS0pPNmxl?=
 =?utf-8?B?emRRdHBNbFoyaHEyeWdybDRVYTg1ZmtDUDFjdmFmbGsrWGE1c2t4N3d1SlFJ?=
 =?utf-8?B?WDFhTUNVZEVkQ3g4Y05qTjRpUHY1Ujd1SFdTNms5SStMYnlyUmRqVGYwSVNz?=
 =?utf-8?B?UGZ5blpZN0U4dG02RWVnNVoxT3lQdmdzQ0lZZGlSTjNXZGxoVVpBd0EwbnBI?=
 =?utf-8?B?UUtqRGdvaEM1a3ZxZ2hoRjVnTUl5Z09PQmUzVlNmTW11eFZpUVdWUllYSmxv?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aba3f9-1970-4091-614e-08de0837e2dc
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:02:05.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amIh/UFF/tyaxO+FhWFaveOB+v2s4lMjGP+fPYnnm9rat5pYnPKddhUdbwqEiOezVh0SLfA4NFGB/9Re3rRPq8cJmMPo35r2u+v47wS4NUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8070



On 10.10.25 18:27, Jan Kiszka wrote:
> On 10.10.25 16:48, Tobias Schaffner wrote:
>>
>>
>> On 10.10.25 15:55, Jan Kiszka wrote:
>>> On 10.10.25 12:17, Tobias Schaffner wrote:
>>>> Introduce support for building EVL for the RISC-V QEMU target.
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>    Kconfig                                      |   12 +
>>>>    conf/machine/qemu-riscv64.conf               |   14 +
>>>>    kas/board/qemu-riscv64.yaml                  |   15 +
>>>>    recipes-kernel/linux/files/riscv64_defconfig | 7378 ++++++++++++++++++
>>>>    4 files changed, 7419 insertions(+)
>>>>    create mode 100644 conf/machine/qemu-riscv64.conf
>>>>    create mode 100644 kas/board/qemu-riscv64.yaml
>>>>    create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
>>>>
>>>> diff --git a/Kconfig b/Kconfig
>>>> index a3e3885..23d5f4a 100644
>>>> --- a/Kconfig
>>>> +++ b/Kconfig
>>>> @@ -17,6 +17,9 @@ config ARCH_ARM
>>>>    config ARCH_ARM64
>>>>        bool
>>>>    +config ARCH_RISCV64
>>>> +    bool
>>>> +
>>>>    choice
>>>>        prompt "Target board"
>>>>        default TARGET_QEMU_AMD64
>>>> @@ -41,6 +44,10 @@ config TARGET_QEMU_ARM64
>>>>        bool "QEMU ARM64 virtual target"
>>>>        select ARCH_ARM64
>>>>    +config TARGET_QEMU_RISCV64
>>>> +    bool "QEMU RISCV64 virtual target"
>>>> +    select ARCH_RISCV64
>>>> +
>>>>    config TARGET_HIKEY
>>>>        bool "LeMaker HiKey"
>>>>        select ARCH_ARM64
>>>> @@ -58,6 +65,7 @@ config KAS_INCLUDE_TARGET
>>>>        default "kas/board/qemu-armhf.yaml" if TARGET_QEMU_ARM
>>>>        default "kas/board/beagle-bone-black.yaml" if TARGET_BBB
>>>>        default "kas/board/qemu-arm64.yaml" if TARGET_QEMU_ARM64
>>>> +    default "kas/board/qemu-riscv64.yaml" if TARGET_QEMU_RISCV64
>>>>        default "kas/board/hikey.yaml" if TARGET_HIKEY
>>>>        default "kas/board/rpi4.yaml" if TARGET_RPI4
>>>>    @@ -65,9 +73,13 @@ choice
>>>>        prompt "Xenomai version"
>>>>        default XENOMAI3
>>>>    +if !TARGET_QEMU_RISCV64
>>>
>>> no, rather...
>>>
>>>> +
>>>>    config XENOMAI3
>>>>        bool "Xenomai 3"
>>>
>>> depends on !ARCH_RISCV64
>>>
>>> BTW, we will likely have some kernel version deps as well, won't we?
>>
>> Most likely. :) Noted: will set this as soon as we have something
>> integrated upstream.
>>
>>>>    +endif
>>>> +
>>>>    config XENOMAI4
>>>>        bool "Xenomai 4 / EVL"
>>>>    diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-
>>>> riscv64.conf
>>>> new file mode 100644
>>>> index 0000000..65c1a53
>>>> --- /dev/null
>>>> +++ b/conf/machine/qemu-riscv64.conf
>>>> @@ -0,0 +1,14 @@
>>>> +#
>>>> +# Xenomai Real-Time System
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2025
>>>> +#
>>>> +# Authors:
>>>> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +require qemu-machine.inc
>>>> +
>>>> +DISTRO_ARCH = "riscv64"
>>>> diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
>>>> new file mode 100644
>>>> index 0000000..a659c2b
>>>> --- /dev/null
>>>> +++ b/kas/board/qemu-riscv64.yaml
>>>> @@ -0,0 +1,15 @@
>>>> +#
>>>> +# Xenomai Real-Time System
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2025
>>>> +#
>>>> +# Authors:
>>>> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +header:
>>>> +  version: 14
>>>> +
>>>> +machine: qemu-riscv64
>>>> diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-
>>>> kernel/linux/files/riscv64_defconfig
>>>> new file mode 100644
>>>> index 0000000..c57065e
>>>> --- /dev/null
>>>> +++ b/recipes-kernel/linux/files/riscv64_defconfig
>>>
>>> Is this a real config, not a defconfig, right? Is that needed?
>>
>> It's a defconfig with some debug switches (some of them EVL‑specific)
>> applied.
>>
> 
> I was just looking at the riscv defconfig in the kernel, and that is
> about 300 lines.

Okay, now I get it. I just learned the difference between the result 
of `make defconfig` and an actual defconfig, and discovered that 
the `_defconfig` files in this project aren’t real defconfigs.

I think that using this plus a snippet for the debug parts should be 
sufficient.

Thanks!

>> I think I could unset KERNEL_DEFCONFIG and add only a debug_config
>> snippet. The ISAR custom kernel recipe generates the defconfig in this
>> case.
>>
>> Do completely generated defconfigs introduce more changes across kernel
>> versions than using an old config and relying on the defaults for newly
>> introduced switches? If the defaults of existing switches rarely change
>> over time, this may be a good idea.
>>
>>> Jan
>>>
>>
> 

