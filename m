Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D60197512
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023416; cv=fail; b=CRMHldKSKQXtxu4Kly5rEh99rY9pnGlEsWXZ/wDiL1RvIm5ezjThaXbBAjvNhXqNKLVwZlvCbW70BZYt7rqVa4x2OeFwir2pO4na5vbBjbA+Xa6jHQjDaiiEVvvqTRu5Wjo8e8xtQ7mCefyWkwmJHXWj/v77wo70lacrzguGAiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023416; c=relaxed/simple;
	bh=hrBH10pWdVZOWjVkDQVGXGXyqc/Bx5jxHRJ7iGCJsns=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sqIoNgAyTZzOLoZ2Ffce0DmAg+SIFm1c9SLBWE3FD13Vn0WiuhbkK56adSxPpxZnumEkepsRDBZOl10gKatu12mZ7Ce4kcSpQ35TGOcx5zx3v/DqIYtaQHj4fPyz3kHgUzMbJB5A/yQ+5hQS6DDXsF/42kVfI17sffncMBZLB+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=j2b4QV/F; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j2b4QV/F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj7y7f0V2C6CHd9xSitpifiUi4wYV4DOOFU8pqLUd5eQgoAkcXRQd6MJvBAMF8QCz8BTb/Ei7ESpMcNLE7Qa5jB2jVgRc2z5nqJpWTkbz4iWjM7ysDCr+lsXNXLU3YHJhuZEPkaEexZ/d136rAa0hhOz9Bi4eHo+Jm4ZUJTtWu03Dg/X3bYf9KSuhv2/6jff1MOunFCs0/89aIHy4qccbT4JHQ1oecer3KScOz4nSCf0E4pbmTJkUVWx3XR3b7f6tFOwuJDNjEOy5+xPCWidouXku7cnTwYJAiVMQOTqE5d3hRihGL04pNjGG176PhV0B0/Cf7B+0bvu36AxiTPrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu0oQjaeJUprKgxbv4nM9+aJkrwm0du7sDz35kdHCcw=;
 b=HzYyADUJrrh2kdC9Ain+JMgp/UfMV7OgfJipgoC5f8YQNY+dhVsbAnZb/X/OYBeh8FuiOGtGpNSOqEyGnYnqQPTKLQyDEANpNSBGyHg+f87ew+rFkndfsGAGQoLzomJe2d2/HMhZ+RMOuL8SSrb8vtp2oTwaXzXquI4SyUZd1hOkvEKEjTrMn+ZC0FPP4Z9yRsTJVm/iK26fJ23w/CpfzSpaxQcELiE5pmZnNaxgHXPE8xlA9+jPO+2P8xMrqcmH4di7TC4GsrzyZys3P9D3E9ub4vE119RxI1W/cGhjV5OsoxWzGUxfJerc1ZfV2HMDqOzW4uW4Xgzq5k0bUEO/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu0oQjaeJUprKgxbv4nM9+aJkrwm0du7sDz35kdHCcw=;
 b=j2b4QV/F3+oqF7Qwtn9bg+Drtt7DB+KMQaw1kCpOewU7ne1zz72I0baK84YHw5ip44fbnhzzXhY7XWQA1CPPG8dx66lqMINrv7+25vY7JB7xKn0FJ5aAnMQ+uSfd2dsChD7pIF44GPTAQx+lhze9GJaKEPOHr/O9Rl4BAqjXOcVU6TTISvtR8a8Kj6XjZBO/HERuRQKUyhkSNf0v0W7UK0DISv6S3XifnN/KJ4yp/1ZyiwZC2DqpsJ/lkH/ChAXkLPR0Pzd7NImFK/AnMNLq/GJzrjVQkj80pHJGgufD8Vldc7/pRovC4QtpuT6C8ZqwkINl15el6A7uQJWJyXyVUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 13:10:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:10:00 +0000
Message-ID: <eddf3b21-f0bc-4a10-9361-6ea353554509@siemens.com>
Date: Fri, 30 Aug 2024 15:09:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] linux-xenomai: x86: Enable IOMMU_SUPPORT
 and IRQ_REMAP
To: Fabian.Scheler@siemens.com, xenomai@lists.linux.dev
References: <20240830125533.30195-1-Fabian.Scheler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240830125533.30195-1-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3664:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec4667e-f8a4-4129-22e8-08dcc8f50dbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHc3bk1Bb0pTUXJtVjVQNHI5SFhiUjI2bzVDYW1SQUxwelRqRzNUc2tEZmlx?=
 =?utf-8?B?U2VLWDNGOTRiUkErR3pQUC81VkRSR0tEbk9EaFRxemZ1SWgvRFZNYy9rZzI0?=
 =?utf-8?B?YkloWEJKRWdLM01ZajJkSHRhNDk3YWhpbk9VeDk3QXI2MXduSHNCalFmZlVk?=
 =?utf-8?B?Q0xvWnVncm1EL1ZoQlVjL2pjM1FQbCtOYUVEZVFubzhqV0pwUFhvZzlwaVhw?=
 =?utf-8?B?RlVGeXo0OE9oem42MGNWc2hwNWYzT3hOdjNZOG5DbmM3eWQvcHF2R3lTWURN?=
 =?utf-8?B?M3Z4ZjdobDRCcyt6VmszZUNMMmFRaEJCVXVhY3d6Y1k3aDdHU0ZQdmJDamJt?=
 =?utf-8?B?eEhZcWFxNFRMRlpHN1ZPMXRMQ2dSYXRyVENqZXNjbEs0UGYzYUFHMFUzaWtB?=
 =?utf-8?B?KzNlbTlIb2ZIclExNEZ2QVA1RUtxMUJEYndDWk8xOFFiL2dIOGtRb2FoV25U?=
 =?utf-8?B?TmdNYUx3ajUzTmFVSFI4R2hBWm5EdGFYVGtmd3ZxRmJsMWdvQjIwUTk0WFhQ?=
 =?utf-8?B?d2RiMWJvVUxVWTd5U3E2VzMwNERnSG55N1RWQnVFNE9NNDNjeWN0MW9sS1pV?=
 =?utf-8?B?cmRyVWtYOThQallRZ2NWQ1dXaWdadkFKNkpJaDQyS1hlcDd1Z0Y0NEI1aUd1?=
 =?utf-8?B?U2Z0WmRIMm1BdzV2NTVKSWd1aW1uRVFvR05UTEtka3RPME10QzBqK0NNOWNI?=
 =?utf-8?B?SzB5Q3I5YlVYcEdKRkJaRmNhb3VERXRaN0FiUWw0bEpZc2lHdStwUXhnQjhU?=
 =?utf-8?B?SGxyQ2U4dmsyQkRGTjRyaVphKzFnaU4wZkFiM0x2dEpvaTcrbFgwMDlnMURO?=
 =?utf-8?B?cVdFTEMrMEZXVWRuT2s0UW1CNXh6OWNWSTVkZnN5VVc0enhCNUpHelFST1Az?=
 =?utf-8?B?YkUyNE5zaHhCNlBBSUo0cVBwWWpHS0dZbXptZDl0YnRtODhIanRzUFMvWVBF?=
 =?utf-8?B?MjJ2b2ZRazA0U1NvbjB0UENVdHQwV2FFaWxrOVFzMTB2MEc2WU96aGNjNmpL?=
 =?utf-8?B?ODFGeDEva2pwTEpLWk9XNlN2eDcweTJDRVB0M0FjSXRiNVI1aWl0N0YxRDhw?=
 =?utf-8?B?TzQwZ0piQ0NzZUgyUGNLYnBNT2ZqUFU1ckpmTFlRSU0zYW9CQnFvZFRnZkJE?=
 =?utf-8?B?ZDUra1hBVjBLVlFNYWJPREt5WTJGRHF2M0NpY2dFU3h1eXFKZk5SQnVFYzJv?=
 =?utf-8?B?NjVGSmYydlc5eFdUZzRFMEpUUlhGM1NZRTg4SFRpa3YvUDhPeU5iY1ZaMzJC?=
 =?utf-8?B?anZ0dUN4TkhSblQwQXZ4dU41QXE5UFFDVmk3NWQvWHU1bnRYYXRhU3dxUktB?=
 =?utf-8?B?SEZwN2l0RVM3Y3dDV29WZ1AzK05LR2psMjcraDhiWE9XNzdVQUw4b3AxZU5B?=
 =?utf-8?B?dy9xV1QzQndFRnJNMmxVdVIyTGlRMFRYSjVCL1YwUzZvQVdia0N6cTIwN0hn?=
 =?utf-8?B?blFuYWFtL25QWEV2NFJ6bkUrb3FXSFo4cnFQZnhoblVyeVIxN1YyVHd2Tnpu?=
 =?utf-8?B?SkxyY3huV1dqUlFFK1kxc0J3bGx4RHpXM3lFMm9EdXFPSGxhZTRHRXVJYkN6?=
 =?utf-8?B?bjBoWmprc3Zva3h5U1QvUGZUejNpT0lRM0pjb1ozMStlWkp1b2tLWlAwdlBM?=
 =?utf-8?B?RDk1MUlVNkViQmdJU2Z4WVBsOEFpVCtmUkJJQXdXVHlsbUxkaXdsTjUxN0Nw?=
 =?utf-8?B?M0Y4L0JscklLblRsK2NzOXZEZHVORUV3bEpROUJvUjFTV2NrVE8yaEtiaEhD?=
 =?utf-8?B?VWQ5N2NvbFBZdkhOejhpUXA5WGVEZHRZczRRbGVkb3g0a3FJWkhmdGxQVFRX?=
 =?utf-8?B?ZlR1VmRIK3pNYUdjS2FrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9hbWhycjJ6Ry9PZWxYOHp0ckhZaFhrd0wxQ3Yvc1lrR1lVZ0VOU0owVnA4?=
 =?utf-8?B?WDNqMEg0citEZnExSm4rUlRNZlF4bWZ1eTVlMlBIZ0FVVE9Gbm11NzViUDQ3?=
 =?utf-8?B?aUxmbHNrN1Yrd0lxR3hrSTBrblRSanFoQzZ6MGc1ekswYTN2QWhxZUF6OXV0?=
 =?utf-8?B?QnZyRzNtVGhWdzhjQ0JmRlRmbzJZN1pZMnowMXRRK2IzMFBmN2V0YlE0VjRD?=
 =?utf-8?B?QU9rdlhCQTUwSHFYczFuVGU4REhnQ2w1Y3NYbkpnUXNhVFYzdHF4a01XdjZr?=
 =?utf-8?B?TDdMalZGV2R4TXNCaWhSSHR2SEhZR2pObGNmUEJZRVNiM0tFK203ZEJpTTRs?=
 =?utf-8?B?K09LRkFhVHFpNzVQT0o1Z2NsN204WUpFYUhRcTZwRVE5Z1VXZStIWXVkYWwr?=
 =?utf-8?B?dmtTUldMQ1QrZ3ZkTzZtTG94Z29yRTR1NHFaR2VmTUx0U1RLNW1ZUnptVDlh?=
 =?utf-8?B?Q2ZWcXlBWU5YRzZqUW1XeWxSZXNwa01ORmFXZnVvbjJPVmN1ME1SZmVTRWZC?=
 =?utf-8?B?cDVCOFo5N3R2ZjJCNUprbG1yaTczSFgybTBHNTBzQUI3ZEhRS09jQm5wQzk5?=
 =?utf-8?B?dU81QUFXTkx6QTF4TlV6bk91Mk1kQUdCU1hpamZ2bHhETkpqdVRJeFJ0QUdI?=
 =?utf-8?B?N0lhMTYrZXdGcU1JUkREeXp1UDFpTjRHSkpneEd2QnIxSmhIbkFMSUhxQ1h6?=
 =?utf-8?B?T1RkekUrQlFzSFB1ai9TVU95OWNOVklsN3BiUjVKZEdvWjZSemZab2V6YmVz?=
 =?utf-8?B?cytzZ01vTE45U1VXQm9KYThDVWdUN1RaT3FPVU5tUERuRWhRRlZjY1dXaTNm?=
 =?utf-8?B?R0I1K1R4M0lVWitiY01WUkhzcjRBMW5vSzhkc3ZlN2xSNU9ZZ0JOVHBIaHNi?=
 =?utf-8?B?aUo5VUZxVDIxWEoyd04yNjkveWZucUxWQWNNb21EV1ordTROeFlOQWlEYnJp?=
 =?utf-8?B?ZlZYMzNJZXZhRVhXSnIvMDA4bGVZVThLVDlKRVp4UHUzbUEzMHY2RjJjQnZ4?=
 =?utf-8?B?eExkdkxjdXFJcVJUL0NxaHVUd1djT29pN1Y0QmYzY05oWkZiWG5USlE4OG9h?=
 =?utf-8?B?NzdBbEdTVys5emdJSXRIc3RoODZaSnNqOXNlbDUyRXA1MFBrMUk0dzZTckF4?=
 =?utf-8?B?TGVOa01QUG5aQU5WSjUzVHg2NUQ2dXRidzhiYXdGdkx5L1Jrb25XNUlVQ0N6?=
 =?utf-8?B?Z3U1RUJwMjZwd2M5N2lMNUROSFFPWUZhWG5Pcm9ORDlybXJodUlNcEQxbXNF?=
 =?utf-8?B?V3Z2UnJOVHIwdGtOZnNha1RDeURhcnhrdmhUSEMxakozWXMvSDZsYU1VYy8x?=
 =?utf-8?B?MDZZVEVXMXNWanVXTGhvYWFZbkErYktRSDlLS0J5Zmp5Mk1zdmx6YnRRYUVI?=
 =?utf-8?B?YktyL0d0c1RrY3dWQ1RZSURkYmFLZlM4a0JzVzVub1pzOEZvQ2x3eEFGSjZx?=
 =?utf-8?B?OUw4Y00xaE5PTnplUkQ5RG9yVlI5ZXBicER6TjRVZ3NsL3JSTGMxNitSNzg2?=
 =?utf-8?B?MFVxYkRJeEJITUlyQno0QzdJUElnS2RjZTVSV3k1NG42TVU3RjZKRi90Vmsz?=
 =?utf-8?B?WDdxU2pRdkdlcFV4aGtiNVJmZ25CUVBITDFXODFMODJOU0U1SDlVdm9hZm9Z?=
 =?utf-8?B?S2tJbTd1MkNLMVBqY2tiNHBiS2REeVpqUndXeWFQU2s5U2xkb3JGU1hVVjNF?=
 =?utf-8?B?ZUovTFNZdmFxOXhWNjBBV3dFdW55by9RS21ucnBsd3BPZkVCMDZFZVBtczQ3?=
 =?utf-8?B?M0dsOVAwTytma0ZXcTJqWGszakRZeTd6a1JEWVhmVmlTV1VrRE9QNG5zNUFJ?=
 =?utf-8?B?Zmo4cEVSV2lwV0FmTWxHZ2p6amV2VkJuUmNKSUZDQ1lXNmpWcGNJMk5qSHla?=
 =?utf-8?B?V0xSNHFXL2E1elhjR25rY05FNjBacERSVHRZYXVGUlJUODNjRHZZdmFGb0Q2?=
 =?utf-8?B?VUlOUHhzRTJsdWNGdHVuNnl4VU5lWHZwMTYwZ2JROEFlOGFXb1V4eFJrRElh?=
 =?utf-8?B?cWtJdEUxSVhNY0paeXR5T0JUVlFTV2haai92NWFxSjQrT1Nsc3ZiczBPc1pn?=
 =?utf-8?B?Rk9JbUk4NitMMlYzTzR3YTBuVmVwL3E5M1k3Y2gvMXNBbGVKbitGRHRWck1X?=
 =?utf-8?B?ajd6TEUvMk0vZ1hIWG9DblJkK2VaS3ZVZU9SVlovQ0FwVE9NOFUrSGZjc0NJ?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec4667e-f8a4-4129-22e8-08dcc8f50dbe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:10:00.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf2WRsl5y4cF2uo1eCl7ENvEM7/4fFWhj99BLoYhokLXiHvc11ZG7ybAjiRu3TH0JM+yHvFVzYDiwvEjcroC1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3664

On 30.08.24 14:55, Fabian.Scheler@siemens.com wrote:
> From: Fabian Scheler <Fabian.Scheler@siemens.com>
> 
> Booting up the demo-image on an x86-testboard with IO-APIC failed due to these
> missing options.
> 
> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
> ---
>  recipes-kernel/linux/files/amd64_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
> index 4f58c34..a0a516f 100644
> --- a/recipes-kernel/linux/files/amd64_defconfig
> +++ b/recipes-kernel/linux/files/amd64_defconfig
> @@ -3424,7 +3424,8 @@ CONFIG_CLKBLD_I8253=y
>  CONFIG_MAILBOX=y
>  CONFIG_PCC=y
>  # CONFIG_ALTERA_MBOX is not set
> -# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_IOMMU_SUPPORT=y
> +CONFIG_IRQ_REMAP=y
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

