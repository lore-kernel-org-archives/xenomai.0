Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D412C53B
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066513; cv=fail; b=WLS653cOkaBsrsuDp6ipbW8vpmRe5v6kQn9658ldbvW3b7oDAT4bNiUYuIoa1CvYTWZhp4gYagrKpJOWzNsyH1Na/CCOUMKtHyYMnT5IgVSg2UEXeC3fgK4mwR59b1CxHg/AIqFrzJDK/fUK/OcVTkAwydVMOsjNNrwhHslo/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066513; c=relaxed/simple;
	bh=84GAHPkjFM2WQLzhRfDIzoJbwg8+SuA5iAeHEQDUJEU=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dj8c8ctdA23XhXErq3q56dXYHYAzd7yniPicdGjjNm5B9lqkn03VhHwCUNAViPKhCbv0PfqGsUGT/B3TJLzG3wm6eWu0F4/pWX/LXDjs89E5NE2Yrrq8c59TjDlZGXKq15GZaw/ywDBazPHI6O+p5eCa41cc41qBcKk7D4IIkWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ymNA7yVC; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ymNA7yVC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0ROZuFv0ZANwfTLW1fAhUzl59cpzA2AdcqVuC1ji1cAy8uva8VUszf1UZLGwyo3aSUy5+W4WDrayfvPppeapMpDqNOGhfPfUFElaGuFQjR0I6aBfd3T38M3HcmW7uDfdcuKAyzDPh6CPcsvYHxgkuCEvT4fduQrwfRTuoY9MmfF58VBeFi5p748yFpB1Y96NGuHE2QgVgRcmp7gPfIezbJTYF1e+PAe9iMT2PGtkKCNubtEqhLotkkRir2/7JY4q4bU7pHVozZq9VyPcy/3WO+GaZLt7CKQCynTGixxMdI1HeHl9EHcwCstp3UdyX6ZNl1m++yBCbUvuxaLAuOzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTmFWs+JqZGpetVpQS1icxRaEJ2nsOye3/oamXt5Rp8=;
 b=LVF9WTSrfXQ+mCk73sB25cPG3iVpmzPvHT9SEiJ/hRbHt3tm1xLRIjOw1UEuXm/1R5zAa7xnq9n1HVVZdXtmPe5OtqTgeCYrdBG/e2YgjDlCk1O9X58GV9rEvWaust8up4fDLmU2m3IingeI43rd0oFeLBqCe8YrsdsfjVibPixRKjfY6FhnCO4EaXslO5hywL8YPklwupELhNgBwbIVt6ZyzFRIzZMrRwFjak0l1vzvRghySoo9cmjQbE03+xLE+QzrNTK7TjJBzUsgP5/fk54ffYlRlbWV3owZWQJ/a558VLbimFmubvGp/H5NFMBMVtbSpUdjAKN5PZTfkVBDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTmFWs+JqZGpetVpQS1icxRaEJ2nsOye3/oamXt5Rp8=;
 b=ymNA7yVCxapyi5jQoa/QyuFL+QSDZhikYAiEiQb+ytOHhPAKLyxw1lGb/Qbx3o4JOm7ytBs4++YTE02xwnKB802um2MIMywQOop1aXFGj7gTBOl8Fz4tP9HrF4NEFm942Kg+UtZ39hFmDFvDXdhFCc1fB/nnO+7vbv8kgorAHyC2XxQHzP4mTvTb0YEYI/RXti55zLHwqQ8MPx8o6TG0ZNB5Mob2r2fKfBbaJFJ9gmbb6AikIe5fbif6dgYg4c+q+SbPejqIt7leY1G7aoixP0G3/bxdARwpZsjTJkYa0+Kr68BV/uFEaMgvLIf2CHPIaEnNrpqFruvjDG1Q9srOpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 21:35:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 21:35:08 +0000
Message-ID: <b0c6393c-a41a-4e01-bb4d-b69890b6f4b5@siemens.com>
Date: Wed, 7 Aug 2024 23:35:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: Don't do any kernel checkouts for userland jobs
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
References: <284056a4-b1f9-4642-906e-1ca208d722dd@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <284056a4-b1f9-4642-906e-1ca208d722dd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d04a92e-c0c1-413d-58cd-08dcb728cf03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVZzTWM5U0NhUW5KOXZsQ2I5b1dCVk5Ia05oMGRtTUN4MUF0aE56NWlMSElH?=
 =?utf-8?B?RWxncDNETXg1TDN5UEhKWDltRzRCQkNlOUpKUTFLRmEwYk5Zc1NhTVF6MWIv?=
 =?utf-8?B?Q1IwSHA4WnpXWVFraFEzYVIzMlVXUnErUyt5ZU0rS1RERzZSbkNqS3FJZWJv?=
 =?utf-8?B?Zmp2WE1YTE5rVG5LaHpSZlRMdmE0YkVJbURyN0Ftb2hVaDRMRGQzWko2YzUr?=
 =?utf-8?B?MzladHRvaUpiWnBvNk1ZZ0dvazIzN3RvMUNhbzlBN3k5dHhQVnczZUh5QmJu?=
 =?utf-8?B?RW5nekhLNUZET29waU0xMGZIRnRybUh6dkNxaU9lMENTNVdBY09PODVGbHRT?=
 =?utf-8?B?djZFZ1JBZ0pCS29DWE81dm4wenVnejk2eDdnMEthSlJTQTFjWnVETmQrdm55?=
 =?utf-8?B?L21vMUJ1dnkya3Z6Mm43Q2UySnd0YnpVVGFxS0tFYkMxRjJPSk5LT1ZhY0E3?=
 =?utf-8?B?SDFFQ3FzZUpubGpPeGZRb0VTY0Rxa2ZnRVdqdmRlK0RDZHBrVDgyYUY4K3hG?=
 =?utf-8?B?UzVoWlMzWGVqeWdGemE4Tjh0NGk3cUwwTkRBTFFLLzczNFZwS2wweDRIeTQ4?=
 =?utf-8?B?a0NLQnpXNXJmVDBCUjRJKzVTVThFVEZzS01uNUR2Y3U1dG9OZzVvanRycGY4?=
 =?utf-8?B?NHRqNkhwamZZR3oyTGVWTnFucFFwYmtWSzVFUEZ0eklpYnkvNWlkZTBqNUtz?=
 =?utf-8?B?QlZaZnJxL1BVaFJNOVJQRVN6dWtvazBRY3NhK2E2RHhnRGs1VDdrdDVJK2Z2?=
 =?utf-8?B?RDVUVzY5cHNSSFBoK0p6T0YzU2xoYjI1S2d4aXdzWGRmcndJVFN5YmZEV0JD?=
 =?utf-8?B?VGNjbFNPL2JNQ3pVY1F6c0VpeW9oRzdLMUd4aUFncFF0NEZVcmY2aFFna3dV?=
 =?utf-8?B?RzM3aWFEYmZsb3ZjblR2Rm51SXpQVUFkU09FM3dPZm93SklPU1JzYmRSZWtE?=
 =?utf-8?B?eDc3WHRYb2lwUlF5TTg4aVZHYlorSXNqZXlKM2E3a3FlbU02czc2TW9xcTdu?=
 =?utf-8?B?bVJPMlBLNmhNTFowby9tVVlKRHNyczcvTHdRRUV6M25ORkltU3JIckt4Tktl?=
 =?utf-8?B?Q2JsTjZuaGdRRlN5UUswZFdOY0JhMVNYNkdGbngrclFLVUFFbmlndzhNdWZU?=
 =?utf-8?B?aEZXaEU4akdCS0VWdmJkbGh1RkZkZjN4OWZUbDFqYytJMWlNZVcvaUg1d3BW?=
 =?utf-8?B?VXBQcHFFRlMwUkpWbUc0VERTbkwxdVpnZDcwOVlYSDY2a0Y3YVJUYTJPQUhE?=
 =?utf-8?B?TEdnRUN0OVYwWWNTejlBMHJFOTlRcDFTcHpGM3lzeW5pVjZVS3U2Wmp2ZUtU?=
 =?utf-8?B?SzJ1VWx4SmVoY1NGOFZndWgxMDk0c3NLaERYZ1lBN0ppYXJnM2ppSlZ6YW45?=
 =?utf-8?B?M2xwKzVteUprMHNBcnlPQkV1c1lGNlAycFdSY3FUM3NtWmRJWlFUM2ZUNm1k?=
 =?utf-8?B?TEQ5Z3VJM1VielZvUmFDVjY0c3d2MFZad1haaEtKYXpzWFR0eGU3WUZJTk55?=
 =?utf-8?B?RHlkSUZhS0ZPZkxjNWYvdGI4UlNCTG1wSmpZcE5OdlFkblVrV1dpSEh5S0Nz?=
 =?utf-8?B?OW5OYVRyUUZ3a0hlV2tqUjNlS2JiUU0vS0Yra2RFU0IxSk5ya3ZtMFpoQjdY?=
 =?utf-8?B?Q3hPMk9XakRGQlM2REQvVHNjNlhhdlhPM25OMlE5alprQnpZVUtNd2VDekto?=
 =?utf-8?B?a2hjcjRkeUplMGhiaC9wNytHSFZWdlppaCsybk42VlVkb3FicFpQdFdBT1RK?=
 =?utf-8?B?bkVJMkx0MXVlSXFNeXMrb3J1bVVpeDBDTVAwcE10ZFgvdXJMSm84SllicnFJ?=
 =?utf-8?B?dXR3REJ2TmszOHUwcmQyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckIycXRmdVJXdVRrOUluS0w2T3FyUjljcHdrcktwdTJNWjhRUy9DLzhscFdD?=
 =?utf-8?B?ZjBzNTdjZzlRcjBjVjVVeEdpb2NiU3F6ZEJVSUdVdG5JUVJSUW1RdGY3UUlm?=
 =?utf-8?B?YmlBTHFNOExhdVE1M0tRdHdRL2pDd3AwMUQ2ZjRwanR4S0lQamtUb0x5NTJT?=
 =?utf-8?B?UWY2KytidHpvYXBITkdsREppelk1R3FIZmpUWlJIN2VCY0FUUWY1Ly9RbCtu?=
 =?utf-8?B?VjFxMXZ4VGZjV00rdUlzRzZKUXNVckYxc2NwRGtaUnZwa0hGL0F6QTU2WWNZ?=
 =?utf-8?B?UnhLdCtkQjRudHFZK05OTFVtNnVZQTdDSGNyRkNHK093Zy9YTlJwM2Jxa3VY?=
 =?utf-8?B?bHV0TmJXZ1RpVUw2bUFCbmRGMmcrWE9XWTl5S3R0UWEzb2RkdExvSnpIWlFP?=
 =?utf-8?B?RG5nTksxN2Z0VmFLVktPUDRqZnl3R2QzaHlSYjhwYlppVnJ5UlgzdXF1Q2px?=
 =?utf-8?B?WlFhUldJSVN0NHcxZEtZNkU4Ull0dHQxS1FvQXNSM2dHbG8rRTF2UmphNE1D?=
 =?utf-8?B?aXFUcVozRm5qa1k1TVZUc3E4c3NrdHMySHV0UXRKQXhhSzR2Zm5ER2RIZG9U?=
 =?utf-8?B?U1F3QXRjWE1QSUt6M0JQNEhjUm9PRUlwTFkwL0RabkhUU0xxeW5DUlJQQkw3?=
 =?utf-8?B?cHlDNW5tUXNPbWhJUHpQSXJOYnZJbnhXMzVWSkNOZ0Z3UGphU1N4QkZ5UlZq?=
 =?utf-8?B?M3NGYnV4WmIxUTdhcTRsWEdNSUpEeTRvWHR4ZVRjbVJJWnFrelNkZjllUklm?=
 =?utf-8?B?MmZBQnBtWU5mcjNOVHNRTFpTallzUkY2bTZaWHJQQ3g0K1dQRCtJclRmaDh4?=
 =?utf-8?B?NklDUVBFR1p6R2cySTVGTGp5TmQ2WHJpVUhVajV1RDRYRy93Y3pvZnQxcHJG?=
 =?utf-8?B?Znp2ZVlXL0tWbCtVcUFsSjNjNldFK3RJVXUrQ0NSbEt4R00wY0h0OUI4REFu?=
 =?utf-8?B?Q25IYXhsNUlveklQYVRHZnI4TGhpOU9wU3lSdG9KdkVaWmErSHQ3N3dYNGk4?=
 =?utf-8?B?SHZRTk1mNndNSllNcGNrRmFjQUJUa2FSWmRUZjd6WG15bUVCcDFEeEQreDE4?=
 =?utf-8?B?LzVHeldLeDE4M2c1QmszT0lDTkd2N1VnUzNsbmlOS2duRGZOV21BWTJIK2Vy?=
 =?utf-8?B?YTkxTG1VNWtGa0w4dnhIQkhjdEluaktUYXNBVjVHUk92SDZPNUlsTE1xUUlD?=
 =?utf-8?B?YzE0VGtDWTlXdC9nVjlrWEc1MnY4V0lKRHBORkF3a2dEL1N4MWpuTnRucUNj?=
 =?utf-8?B?aHYyb00rZlVkMlc0MVdReGJPZTRVZkUwUVBYdE9Jek1vdlRDV2ZkTGkyTmlr?=
 =?utf-8?B?OEVsajNxVHFiWmY0cWVhZmJQck9LYWVSc2gzNmFRMVRuTHYreGlYQ1hUMVBy?=
 =?utf-8?B?SkJ2Y3U3VlErWkJvMjlBbXRRaVlNLzRwd0FEaGxrVlRaeEZkT3QzaDZ2SkJu?=
 =?utf-8?B?SlZBR0hrR05QS0U3VXIvamVDQkw3TmdhaDFDVzYrdzVrOXNGRDRmMzFzRnNO?=
 =?utf-8?B?UUNkeHFXWjkwVUcvK2ZmS09OVjFRTE90d1dmcUZSVlhYbVR5Y1ZWZ0NLeXA1?=
 =?utf-8?B?RE5ZY3pORFl0TGtkN29MRXd2L1pFY0kxYnV2MHhwNnhhQTU2bHdRZTkvNDRY?=
 =?utf-8?B?U0tVcWlQQnIzeU9CVmpQZG9lYnEva0JQMjJkYklmLzBuc1V0RUJud2ZhdElw?=
 =?utf-8?B?aTZ3UFpEeHJpbGJoaEhwQUttK2NIV2d6VzJoelF0S1VKSzZxTGpiRGdRK3Vu?=
 =?utf-8?B?ZVIzMDUvZy8zcHdCWmhRK1h0MzhkdmRwcTlGUmxBRTlLaFpFSlk0OWJUM294?=
 =?utf-8?B?dTljbXh6SzJyQ2lXTEs5UlFRNzN3S24wc0RCbTVDNVNoN1kwQWY1VFg4eVA3?=
 =?utf-8?B?aU1zWTA0OEV3QjRoS29ObW5JM0Y4SFFFMmQrOFpkL1Q4TUtnUEcrSFkvQlVv?=
 =?utf-8?B?UTdhOEhkVHFRY202YnRLajBpTHhKS3YzSmxKajY0c2o2eUVDWGJKY0hCTjZN?=
 =?utf-8?B?QXF6RlNwTFNmeFpDK1ZTL0s4N1QyREtodUdLL01wQWI2ZmlwUjNUZlhIaklT?=
 =?utf-8?B?ald0M2prUTRYeXJ1dGl0dnV0b2FLemNpcE1pZFNib3NOcXhmZmNJV3QxZnBa?=
 =?utf-8?Q?zwpK2KSs0BinppMP32ojSTKYY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d04a92e-c0c1-413d-58cd-08dcb728cf03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:35:08.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPeQkuGyoF1Nn2ZGhyBg44J8Rel8wAy6ikJGTdCJHKr08hSL8+WpO7YiK10kvc8Boq+NfYCH8jeaVf0DzgOB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8084

On 07.08.24 23:29, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Testing for PIPELINE_KERNEL being non-zero used to work but became
> broken with 2e92c3ae2e22.
> 
> This also fixes sporadic failures of userland jobs over the evaluations
> for setting REV.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .gitlab-ci.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 09702af904..975c4e573d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -41,9 +41,9 @@ variables:
>      - apt update
>      - ARCH_PACKAGES="PACKAGES_${ARCH}"
>      - apt install -y ${PACKAGES} ${!ARCH_PACKAGES}
> -    - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -k 1.4 | head -1)
> +    - test -n "${PIPELINE_REV} && REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -k 1.4 | head -1)

Missing closing '"' - in next is now the version that has it.

Jan

>      - test -n "${REV}" || REV="${PIPELINE_REV}"
> -    - test -n "${PIPELINE_KERNEL}" && echo "Checking out ${REV}..." && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
> +    - test -n "${REV}" && echo "Checking out ${REV}..." && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
>      - case "${ARCH}" in
>        "arm64")
>        export CROSS_COMPILE=aarch64-linux-gnu-;

-- 
Siemens AG, Technology
Linux Expert Center

