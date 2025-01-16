Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051A24A7C6
	for <xenomai@lists.linux.dev>; Thu, 16 Jan 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049065; cv=fail; b=NX5ip+oECJFU1BZdL146vtIuzmoDGGXpiHMlyGaJNrMMliWZ1wmye6A3L99oW7OVzI1NyVAGuyQY91Ol1l302gwzVZ9qb/VG5S+PXPRW5CF0TmZJ+rtREUvfjk9AEUx43B34g2d/iNLkHTOhvSnV/JwsI/6o7/wWp96AHRA6WMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049065; c=relaxed/simple;
	bh=QJj2DOwGvHe53OlzezWpDL/mxQDelBASLsuw8ZuOv/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqFRlrc5uslN2vTfNaVeNGT0o4plPuqd7Yo1D0y44HxKXKSk75sN2lwQ83wJhlyZyf3lEQKxdn6GgBwJtLKOgB2cXNUlkhH7lp2pH6rP4opNxjzNY1ZEdjSqoZf73l/SKKC/dig96q97LhLOpRXw+Gw+Q9HescESyIy5aTlImkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=v0OqqS8f; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v0OqqS8f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+c9bewmlMuLQ/gG2jhROH9UA1lT84EXIT6QDkdFpcYQcg2uiaBjZ3LwWkjIXspePqQggaizgmwgQrNgtDbri9vvegqEK9d8ScDZ9ff3NFDd6ED2VZ0gtmNeQULxIjd4xhJ7iBpu9pC0eef5oUw88MWeHFaoQ2Ma14Bvm5NpDPoJbfrDscj9Yak9ZfI+i/243AiS9hwa0lIWqlkgYXZsr51NNFIxXavkQBEF8LnhWmx81pbY0U/1P3hQgifuJ1RYLMY9Rw/ifAvot0Bms78GafMiRAltIxe3fkk6a5WXpJx3s+tT2Gn5O67HARGfeNrENNvLUdb9qW7E2HOSGNPITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JgMtc0tbKPw/7G6zDObbdNW5XMBAt/wF6gEBGRfhyQ=;
 b=XW/hmMfhzPcXgGBclmpZCGYa3VI5Kg4AU/UnJaTX1towF2Xt32CVxHbp1mK0YQoxX45EOm9wqoFJKUqBRK3uwjIognkZgNHBeWfQGi+aWGhp8XelxDw/0lPnwJTsdh4YAizZxuEYBd/kuaWbgBSNnIZnFwDEm2bNtzutFRmE3L971cXsbPS0k1g9/1zx/TTKLqNvZWATXOhDAkyCkbrWGKgFn+3mylBD//cPxm5lDcDJeMGXaKdzmDcFaNh8sAIE+3p6/jE/fnnXzKjCLcuA7ku65/b13sdpUGLhC+yjxaBh1MF+85/vPLpCJJk7XH7Kh7jvBDyYRrBl0z4NXgCxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JgMtc0tbKPw/7G6zDObbdNW5XMBAt/wF6gEBGRfhyQ=;
 b=v0OqqS8fHkQUqz4DJzs+krdG0/n/tpuGY8CCEPi2YXnhg+j8Ke+/heC4h/uzFY3eklluSilbqTW5LeY1/SZGPGQ7RfD4zWAqdbbeGlptiBrdII/x3kxhDzKj3PirOT1J376MHq7f4IZceBcS4OGpMaAfWoRaSRNqcMLgxI8FEkxdcRdNlNxjXMVZLKHtrBu1G4pBwz2dYKxCq+omJo7DOt+yKbzPDaEu14vL8PjSTSqYSmbD0wHHl3KXzMW143Xrcvyoi9p0SziyQZwb5EQF11xqZiqITZVH3taHxKPByONjPaV+kAntDLjjhV/T/nNb1MU+ZWObgEOxKIxmoHYwOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9104.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.6; Thu, 16 Jan
 2025 17:37:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 17:37:40 +0000
Message-ID: <1ff73542-4f90-4550-8c27-20c7ef59c1de@siemens.com>
Date: Thu, 16 Jan 2025 18:37:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail situation report
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, tobias.schaffner@siemens.com,
 shanmu1901@gmail.com
References: <87wmew84pe.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87wmew84pe.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b345b2b-240d-4e44-90a9-08dd3654795d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTFIWFZ6cXVHOUpOVkhVVWlhb0Vxa3EyL2NPbWM0c2ZvVGZGRGlYeGM2RWE2?=
 =?utf-8?B?TkxwcXJpeWJaKyswNXl4Zy9nNHpSaGJuT29jMStDaWlGR1FEWmxwNWxrZlAv?=
 =?utf-8?B?Vis1eVRlYWVvOTZweDJUZk0xbW85U2wwVWFBR0RJQlVBRCtwWXNRYW5lUjcr?=
 =?utf-8?B?Uk9PTC9LOU8vNXF0YXp0R1NvM2hTSGV4di9Mdm5CREFvUTN1WkRDc2dDV1ZU?=
 =?utf-8?B?cTdHVitIdUUvSmhNTGxCVU83L1BzZjZuNW9HcGI2YUpyUWFEN3hVN0RYcEcv?=
 =?utf-8?B?bEZBN0lYNzFudTkxTndsS21CZ3JxZjhlb0FSQkZjNmNMdjlTTnhWZy9SSWNO?=
 =?utf-8?B?Q0FyUVVPWEllbEEyalNkY1J3WFBsRm00Um1tVnJ1MExhVlc3VmdENzAvVXRk?=
 =?utf-8?B?UlAwa0NLSERvSkt6VU42b2tmRXpLcENlbjNZOXBab0RSeDQ3K1VwMEQvcmZH?=
 =?utf-8?B?T3NFdU5tN1g5dERsZDJucTYvZ2Z2ZTExd0lJY2FPWlBHZ1FLM0RMTnNWSjVG?=
 =?utf-8?B?TzBCTy84NHBnRHoxMHBERXMrbUk5eTNEb01MVG9McHNDT013R2gvSEo1UTd2?=
 =?utf-8?B?N3k4Mlk4N3Zxdk4rQkVWeXZSbk5ERlA2MUEzbEtWb1hxV1ZoVFpmN0JBc0RY?=
 =?utf-8?B?YXJSM1pSOU9SbjNhaVExclN4Q2JmZzQ3Z3VHbHJ3a1RKTnBJSUl2TjBIQjZH?=
 =?utf-8?B?TjMyR0dzcloyUGJDODhXTUxiSkdLYlNseEhlYkV0R1YreDJyRUNWbGJCWE5X?=
 =?utf-8?B?WUd1Y1I1aVhaRWlDQ1NaQ3FTcUNKV0d2UWc3MzZQWWc2MWVRZFJBRUpuZWxu?=
 =?utf-8?B?QktCNzFWUlBscllwT1FBSld3NE9qYngzZWdNcjZSbjFtSTFtdDhzQW1wSkJz?=
 =?utf-8?B?UjJSdnhJT2NtSG05OFJxS09SeDkzTW0ycy9RTUxEN3hSR0tZT1k5NmdIeC9T?=
 =?utf-8?B?ZzdLTEdGUThzbUdpNTdpeHVFZFBWSWEvbDRKT0tNdWdlUXJjTS9iVUtuV2Mz?=
 =?utf-8?B?bEsyS2NidWFJZ3JOS3FVS0pzRzRHTE95ZzRlNHlpZUpxWFA3SWFqaWR3QWF3?=
 =?utf-8?B?VHlJVXVESFdzVHpYSTZtc1R5UTJrL2VKVy9RNVFWbUdiaW15NjhpMTlkUVdl?=
 =?utf-8?B?NU9PM1BCald3YUZURm5rKzZXL2pHUTFNL3dxdDlub3haWXk1ODBlVTVuZzZr?=
 =?utf-8?B?VkRlaFVJTlJTdFlnWXFpeENNbHladjZMam9tTyswOG1BdGFIVmUwS0tXSFFx?=
 =?utf-8?B?UVpuemdnRDQ0VmUxMEF3VXRvWnJSbmU2ZnpDUWdhajBLMWc0dU9oUXAxaXZ5?=
 =?utf-8?B?a3JUdCtyNC8xUWx1UzF1UForU21HMFVEdHFYOUwwbU9VbGk2RGxwYzI0dHNy?=
 =?utf-8?B?ODV1TTBiZzBMc1QxNUtzTUdhVlRNOGJxcDlvRXZqanBNQm9JZy9XbEtkbHlF?=
 =?utf-8?B?L3lGQnFpVnJNQ3dtTHB5MVowc0pzbWhlNG05VTQvN0xqbUl0eE5VL2pyZGk0?=
 =?utf-8?B?VVpJMU1JZGthcWxyN2pzazRwUjRFQVBQai9lOHRIbXdRSUR4OWtPbmxqaXdq?=
 =?utf-8?B?SjNzYXY2ck9lMTlQVE1jUyt1d2dQL0c0SW9aditlZ2xha1p4Y2Y1bFY3cjZC?=
 =?utf-8?B?dUZiL2Y0WUhLYWtOSjhZUmpDYzJWbm43eFJpZVZOdGY5UE50MjZ3clgxbVNH?=
 =?utf-8?B?cmtDUEZSaW45bTNlL0ROUkVQWXdwRlB2WXZPMjZEZmZNTnY2SGdiWm1EaHNY?=
 =?utf-8?B?Ukxzbnhob2dka1JUL0J3Mi8yUW5DNXhEdjZ3elNTRjBxdnA1SDY0ZC85WURO?=
 =?utf-8?B?OVR2MVJtYlYzaWtobGx0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YSs0ZXFtS05DNEM2OTdaSUVKUDdvQzVjL053bS91SXVoUFF2alhnWUliaHJP?=
 =?utf-8?B?SXZPWE16MDVSRHhtUloxRmZyUUFScUJnNUdiMU02dURFdkhQNi9tWDMrUURB?=
 =?utf-8?B?WnRsWVpLOCtJKytMUHpZZHEvR3BwTEw0Zkd5TEVwU2Jac01vdm54ejRsVHUw?=
 =?utf-8?B?WVpZOWlha2pTQThKUktJMHJ1VWk3bWlkYnRoV2cvVTJzMU5OTkpXdFdaVC80?=
 =?utf-8?B?eG9KbHNYcExlVkU5NzV5SEtMeWp0MlZ0SDVTSDJPTFpZRzM1Qi9odnZQbzJ3?=
 =?utf-8?B?cDBHQlNCZVZ5b2lPVDJBYlZPN29VZDV3ODdvcHZJaTFIUTIxVWxFbUpPOWow?=
 =?utf-8?B?VlNhSUJvNnpHU1NwNndSSGpuZGp2SGRuSUJVRERHVjdJdlVMMjF5MTVXQ29n?=
 =?utf-8?B?WEU3ZmdVWTlHeEJpTmFrVG1DR1pwQjVhd0ZIT2ZiekptcmEwejBXNktDNHIz?=
 =?utf-8?B?Z1puMWtGbHFMUnFZQXJaWnVqNFQrZi9KZnUyNGFTWXRtb3REZlNYakRzZ3FB?=
 =?utf-8?B?bzdCeUJodmJUSExiSWo1UGg4RnNHNGUxMU55NUY1NFRxcElvQjcrVCtNdlYx?=
 =?utf-8?B?T09TOXFnZjZjNWRiL1FDbHlycGlvVlQ5aGFMcCtoM3g0aW02Y01Gc3JLQ3BQ?=
 =?utf-8?B?THZ2dnhCQTQ4ZlErOXY5N1pUYUZjbk1HaDc0ZDJCUjE3V3A1amFBZFRtbXdM?=
 =?utf-8?B?VXoxaG41ckl6WlVhTUNnV05RU0ZlcEJ5Y3poekRCQVk4aVU4MTdWTFNLSzlx?=
 =?utf-8?B?YmYwVWVJb2U5eUNSbVFlUEJaUXZ6YzdrdFQ2Z0MwQVUzVDFiTVhuNkp5dnV3?=
 =?utf-8?B?eEFtSEZuS3k0VHN4RVRhOU40bWhObm1USHVjeWg5MmcrSUN2OXo5TjU4WjdY?=
 =?utf-8?B?UXNHaC9PUkhqOFlrMk5TQmUxUG1yM0o4UUtlYyszN1Mxak45bFRFcWlwYm9s?=
 =?utf-8?B?T0FIcXk3cW43c0R3ZWFpVDFEN2RhR3d3OCtkUktJdU94Z2JjUGljQTRpa2w0?=
 =?utf-8?B?T3FKajJaYkJNWXVTL1pGZ1czeHBvQnMxd0VYMVBLZHRUaFlKSy84YngwaW5M?=
 =?utf-8?B?Y3MwdmRSNnFheWhnS1Npc3o3amVwN0ZNbnE1ZkM3YmN2Ky8zMFFIcng1Qy9j?=
 =?utf-8?B?Y09hZmxNMFpFN2RWQ1prWUZTdmtSdWRoVVBLeG13OWo3TEdXY2RNekMrYWkz?=
 =?utf-8?B?VThRZC9IWGR1VVJEY0QwYUdtUUZYeEZheDIxai9SeTdjVHV4eURMQ1o1bWJk?=
 =?utf-8?B?VWFVRkxBeWJpZ0psMnRzdy96bWFoNlFQNDA4M3hrR3krd1NGSTZUUDJwQTdz?=
 =?utf-8?B?Wi9GNnlRZHZuMzNzTXFRNGc0cHhtRzJRWUdENVUzOTNZbHBUR2p4L2FROXp4?=
 =?utf-8?B?cmlycmM1VWhKV1ZtUVd2VXJKTExUUjRURCs2OTV2YTY5NUhTbHgzV2E5Z0Y3?=
 =?utf-8?B?VzZ3dmRnT3JWRW1Rclk4Y0hrUHNoR3h2eG16WkpQZUtWN1I2L2s5Rll4TXcw?=
 =?utf-8?B?MXlwZVRVa3FlOW91cVliRVJXYWRRWW9oa2pHK28wNEFzbWJTOUpaRVBTbnI0?=
 =?utf-8?B?LytlY0xsaHduZUxHS0d4QUFZRnhCbFBqR1dPTGx3NUpNd2VkcWMrUFJaRjB6?=
 =?utf-8?B?M2xSd1pMMEV1Q085L283SHBhVjlTL0dyNTVrdGF5RFZFaGRHWXZER0RjTy9m?=
 =?utf-8?B?QndmTUZ2MEZXM1hPNktQaWplUFZFRHRBMm1VTVhzT2p6UnNEdnNnVTNOa2NF?=
 =?utf-8?B?WWlYZk1GRk4xbG82THNiNjdrVUpZL1h1Wk1lanQyNENNNjZ5bEZkQjZzNGVK?=
 =?utf-8?B?ZURJaitWTzU0a0pVeUJQS2tMaDl6RXkwQXBaQVhHUm1TU2V3OE4reFJvaDRW?=
 =?utf-8?B?NmRyR2pWQ3QvNm9CMXN2RlA0bjRCNWJIQUlHaTNZR0MxRFZFcGFLR1hYelIw?=
 =?utf-8?B?Y3lzdDlhYjBFSnI4K3dPUEhvMlVyVjdqVXhTMDRjNEJGaFJJN2N1Zk5lRFJB?=
 =?utf-8?B?Nks1VWYxbHZlY3dWSnZ0WXRVWHhjZUxwaXdqMGVhRS9Qb3RFQVMwUnRtdU4v?=
 =?utf-8?B?bG1YaVp6eHVoVEFqVWFUL2lOYldtT25YcEpwZVpITjFlYUxjSjhKMEI1ZGY2?=
 =?utf-8?B?UTVPa0tncHpIR3RoT21uRHRzbEpIMGQvWFZXR1JETzJNT1FmZHNJaDR6d2J6?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b345b2b-240d-4e44-90a9-08dd3654795d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:37:39.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thx5/DWYrun3n4x/NnKSe1+4dELUZAojibm86Kf+2lyulYJSJHuqai9dcrr33+HSXLyVQjDSdILkVpkepzCslQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9104

On 15.01.25 16:41, Philippe Gerum wrote:
> 
> Here is some information about the current state of affairs with respect
> to the Dovetail development.
> 
> 1. SLTS, LTS kernels
> 
>    - We moved the SLTS kernel we maintain from v6.1.y to v6.1.y-cip
>      [1], which means that we are now tracking the kernel maintained
>      for the Civil Infrastructure Platform, with a projected EOL in
>      2033. The old v6.1.y[-rebase] branch is still present in the
>      linux-dovetail repository, but won't be maintained
>      anymore. Please track v6.1.y-cip[-rebase] instead.

Maybe to remind of (or first time explain about) CIP and its kernels:

This is not a new baseline for Xenomai. We are already on 4.4-cip and 
4.19-cip with old I-pipe patches. This was primarily driven by needs of 
users inside Siemens, but no one in the community complained so far.

End of last year, I furthermore switched 5.10.y-dovetail to
v5.10.y-cip-dovetail, discontinuing the former in favor of the latter.

If you plan to follow those new v6.1.y-cip or v5.10.y-cip line now, 
please have a look at what I just wrote up on those kernels and their 
maintenance efforts here

https://www.cip-project.org/blog/2025/01/13/kernel-6-12-will-have-10-years-support-via-cip-are-all-your-maintenance-problems-solved

and a general overview at

https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#cip_activities

Check if that fits your needs and how you may help with keeping that 
basis in shape for them.

> 
>    - v6.12 moved to LTS status, i.e. v6.12.y[-rebase][2]. Please update
>      your git remotes accordingly.

Side note: also 6.12 will become a CIP kernel, somewhere later this 
year. 

> 
>    - IMPORTANTLY, we now have three (S)LTS releases to maintain,
>      namely v6.1.y-cip, v6.6.y and v6.12.y. As things stand with
>      respect to our resources, this is one too many. For this reason,
>      we may consider dropping maintenance of the v6.6.y tree. If you
>      have any concern about this possible outcome, you may want to
>      bring us a plan for keeping this maintenance alive.
> 
> 2. RISC-V port
> 
>    There is an ongoing port of Dovetail to the RISC-V architecture
>    which I'm willing to merge when EVL runs flawlessly on top of it.
>    Tobias <tobias.schaffner@siemens.com> and Shannmu
>    <shanmu1901@gmail.com> have been contributing the code so far, I've
>    been reviewing that code and consolidating the resulting tree
>    [3]. No ETA.
>   
> 3. Maintainership
> 
>    Florian <florian.bezdeka@siemens.com> is stepping up as a Dovetail
>    maintainer, along with Jan and myself. [Thanks mate, the past 22
>    years doing just that have been heaven on earth as far as I'm
>    concerned, I hope you'll enjoy too!].

Maybe to explain the worksplit further: Florian specifically supports 
Philippe with forward porting dovetail to newer kernels while I am only 
maintaining some older ones. Right now, these are 4.4-ipipe-cip, 4.19-
x86-ipipe-cip, 5.10-dovetail-cip and 5.15-dovetail. As we have no demand 
for 5.15-dovetail and its in between to CIP kernels, that 5.15 is likely 
to be discontinued soon. Please raise your voice on that, similarly to 
what Philippe wrote about 6.6.

> 
> NOTE: everything mentioned about linux-dovetail above applies to
> linux-evl in the very terms.
> 
> Thanks,
> 
> [1] https://source.denx.de/Xenomai/linux-dovetail/-/tree/v6.1.y-cip-dovetail?ref_type=heads
> [2] https://source.denx.de/Xenomai/linux-dovetail/-/tree/v6.12.y-dovetail?ref_type=heads
> [3] https://source.denx.de/Xenomai/linux-dovetail/-/tree/wip/dovetail-riscv?ref_type=heads
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
