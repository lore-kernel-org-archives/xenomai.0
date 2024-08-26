Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF16EB7D
	for <xenomai@lists.linux.dev>; Mon, 26 Aug 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665854; cv=fail; b=NdwHamg3kqtX+rf561iF5sfSKM6i4M4cDw0EYp04WnZCY30DRI/XxMxOlTf5j2+eKBX/mcTUAVzkRgmB2kiaReGlwe9/xGelfsAs4GVEFc+4gNbs2DRkPAFX+ZfvxVN6ykRu41dcUiokuVzj0xcBtu/2NKkMD3bBUL6V+bES3eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665854; c=relaxed/simple;
	bh=P00oSanHL4MWaTWI5Zy5SZmgY9gAHVdm21Eb4AuO64E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bmYmc3Qdi0IeEBBPU7tofYMvFWK6x5Xcc0hqXrgz8BSPsKdrutpgdqzmAAfFLYCA9jCEzzd+XBZhIrwYSvDwrbXRa/37L4BJ3pmyBzJdelLZOtjjOZCOftQH6vWpHrTt2r0VisdEwgWRws6oZ/lRqp37YqeLn+1xyh6f4EXgt+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ITvkZ+Q4; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ITvkZ+Q4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1sK4/9+jHgYDEaC0ANs1wn2nc6z+Yb79cau/YiUOo+cUz6dz9QHRBHtRKiIOPhi2X8KFgM1mGxQjLRUq2k0MaIQbalz+6HI+9/qk0EzffxY61NJJmuBlEC4lB5ARTuT99H74dHZXRPdevGBOejQHT6EgnX2dkb5e5zwV8dWuX8qu00L1ODlxx4vybxqsEQudrdYFBYEVeNNPy30YJ00q9hZSL+p2fMbMcTnoJR1iIV6nrNEtUtyeuxQ4BK3Ky/xlr7GvWCz4GW76NWSxk7eeZ77+3ztYOxvfsO5ZUmmj0Ap8lgAGqRO0FZ7400zxPqOSIg4w3T/KwNNmemrDOQFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzhb9L4HQZVGNP5I1QWG8qOSAHyNYRViGzrC/t27frg=;
 b=KaXgzuLEEjetM79vAnj9hsTk4TROqnylpgdsH611/K4snKC09wZWSpQd+ksbQRke0IfN5h8j4xp1heFFY/AvLB+CQZv7of2+q+Fv1pdYf/2GsOvNEjiFV02AX87v2KPHzoP0wMKE0q3jp7XdGxlu2kMkXVtsmTjv2nLCjXwbJcIk+VLPhqcfDOLENpP6E4BcEYp5iq4Zs/0qghmGIWPdS0B45+fF+SLYpdkrC4LPPv8oWi7+erXtOko1IKiUjtWUREXfz9rUq1MaJvm64lL3Mdc4RLSaAUYMdkEwGBPXT33CdJ84G9Hx8nCwS3GGBJBhcFvRouoHdh+YFqMQt4yb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzhb9L4HQZVGNP5I1QWG8qOSAHyNYRViGzrC/t27frg=;
 b=ITvkZ+Q4gvSCYMDv5A6A3LXHD96caB8hwmRemOaiPrae2Yn2UUUsplP8PYGGGGoW+gWWAY9sj7iQDRv0vYEdMR7owMY/ytnLDqMfItdL2d94u6/Swviym9y3GmOSK2nnicjLlF3SpMYLUnC22X2USUPCyapG0d+3Z/IdIUcGZyRUDlLUa2j1ZxOPem8ef+XPnfG+6+lYkEsp64QzR2TpbunH7vBWltlRvTrsRwt6M7mzYXxj+GaQnDgyIjD9s2o/2Zir1BQYNv3tpoDWSFvGreEM6PbDFQE9wv0994ZZMGuuYmy3w6tvQ/laZ/5R97ZQ9L2JPwIyq1dlK84cPzdYYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB8023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 09:50:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:50:45 +0000
Message-ID: <23c86ecf-7291-486c-af6c-0b84ee7b215a@siemens.com>
Date: Mon, 26 Aug 2024 11:50:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail: x86 compat syscall handling broken, missing backport in
 6.6 and 6.1
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <f5d625d498678060902ff7362d72b8b16387fee5.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f5d625d498678060902ff7362d72b8b16387fee5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b1bef6-2f3e-45a6-9eb7-08dcc5b48e42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVNXRFZtc3JLbkZpWE9OUTh0WXBpUjdNd2hxcCt0ZHZEOTluNTZqL2IwTEs0?=
 =?utf-8?B?QjRxSjh5ZjYzaXFTV1JiUVdLNTQycjkrUFhJVExuRytCbEtkVVJxSzZJbzY2?=
 =?utf-8?B?eFBPdTJpM0NTSk41ZFd6a3NkMW9nZUVGdmpoZmpvZDEyNGx0eUQ0UVkxeWdi?=
 =?utf-8?B?bk5YVnBxelpnWFVHSWZaSUhkY1hSbUFjSXRkWlQrZFlQeWEwTzM5Q3VTcmlL?=
 =?utf-8?B?QXVlOWRZZG9zRVFrQWV4dWl6aDBmYzBZOHVVNmxCMFVENzdoNVVHSW1jL0ox?=
 =?utf-8?B?RFdpNHdSbTIzK2x1T3hoSjJHT3hNYWgvUHJyUW1sYnVYb0JaSHVUOTc3Tnpt?=
 =?utf-8?B?a1I3clBldkNnMXJiczI4WS9NT1FKUitLVmxDSDdYTnh5SnRJMGErbWxjempt?=
 =?utf-8?B?dmluNEd0bmJDdHZKOGJhc2dCV1NCK3g0N01LeTZhYVlINjlsdWRkK2xZaEpE?=
 =?utf-8?B?VXgvaG1oOGhjb0xJRmd5MUFnWTIxV1l3R1o3YlJaRFBEL0lxV3BMVnJPRitl?=
 =?utf-8?B?MklrWVZyeGpCcDRBRTNnZUtxWWZxa0QyNWdsUzZtYjBMeVBLcFBOT1hycWVw?=
 =?utf-8?B?cjVmMlNwU2tCb0g3dm94dTB1ZW9rQWFTRHZVL0FWaE95TXg3WTRtNCtLZHVw?=
 =?utf-8?B?OURlc3YzNGhHSVBhVmVaVzROblRjdlRaMGptN2NRcXpmcmd3WS85NFNUVHN5?=
 =?utf-8?B?QTE0STRRMjVhdXN0TFlEWlBUSjlwcndjTVRscDI0bWpDaDYycW5JOUJQbXZa?=
 =?utf-8?B?VVlENE56NkdGN0d1NjlMQUVQTndBazVRNmJkUFNVTjFBRWVPSzNLdVZldU9V?=
 =?utf-8?B?UlVFYXZOOElTUzVwanA1UERpTmRNNFQrNkFIVHBoU2RnaHBNcW8yTUZ6NFdO?=
 =?utf-8?B?S3JYbG9vVk9nVTRQZy83dVBKcWxPZEVjTmtpdy91U25xU1VFQTFNL0RiR2xx?=
 =?utf-8?B?MmtHVmovbWwvTGlFYmZrY3J4VzNlaUorc3Z4K3djQ29iZkhieTUzRlBMMVZT?=
 =?utf-8?B?Y3NZTkZSQ2pPOEZneFNpU05ESHBYaTBUUk9ramFiRGNJa1ZXTzZjdTdXMmtu?=
 =?utf-8?B?Njk5MFdLMC90TVNwVWw4SnJkeE9JVlphZnFMVUwxVFdUYVFTOHB1ci91NGoz?=
 =?utf-8?B?NHBDUm5SYUxadWtrOStTNHBkdG1qbStQTmtQVVFCMmNMdjR2VGIxSS95YWts?=
 =?utf-8?B?SFJwaHZyaFlTeGI1RE81ZThYbzZmUjV0WjVtM25SWUJMb1JHK0lORnp3bHZW?=
 =?utf-8?B?cE9KOHRZbGdwSlBtYUpJZmVndVAxUjF2NlZwL2t0RUhVM1J5V0FubTNKOHll?=
 =?utf-8?B?VUc0dzVlTGhqc05mbDl1UkRKVlU5ZDhtMjdwaTZpMGY1VUF1NkVyMWtqeVlM?=
 =?utf-8?B?VGwxbHJpM3k1TUl4YkNsRjBNZTdGeFg4RXg4T3h5L09jWEkrcnV5Q0RMUXN1?=
 =?utf-8?B?QWExT09pc0lyR0RvSWtldlFKUUhRcEd1bVNmekNyZXBUeXFQcWlWeFFOckk3?=
 =?utf-8?B?cUlqRnVVcWpiUnRkYklLV2ZYTzNSK25xNElydG1xL3dMMDVWTTNZLzlENkdW?=
 =?utf-8?B?UDFCc3ppdC8wZitIaVFaM2wwMnZrTkZ3Q3dvVlREdXV3azFzbzVYU0R2Q3Yw?=
 =?utf-8?B?aGVLQ0JoL2wrdUprdkxpaWllQVRqOE9lL2tqNlIxdXMwNzUwN2JmUlFUSWU4?=
 =?utf-8?B?V2lxYks2ZmpIR2tmZ0FWaGZBcThHK25ZOE41a3FiTnU2Q1Y3VGtPR3hYQjdp?=
 =?utf-8?Q?jLmknzbDrRNvDHUOpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWRsZkNZb1ZBSXJMaUVaeW4vNUZPb0plZnlTOEdXZi9QbzU4ZDNxaFVaNmd0?=
 =?utf-8?B?NG5nQzZJRUxOajRnejZxd3k2ZUg3ZmRsdXBFVzRsZVZBcnF5Qld1VTZ4WHhw?=
 =?utf-8?B?V2RydGRiNG50STFNUFd6VWJ0bG5qSEJ2NWtieEVPVi8vNXlCQ0ZUYStRS1B4?=
 =?utf-8?B?VXF4U1AyTEV3cVE3di9BYTBNVk5GNlFBNjBwbWFzeDNrWVlWSkVOTzZwL0pS?=
 =?utf-8?B?UUIyOU5HdGhtUVlhbll6Mk0rUnJETFBwVHFtQUR5SnVrZHFRdTZtaUNQRDVt?=
 =?utf-8?B?UDh1TmtZc2hDcVZHYUNhSTRub3JoblRRK25CY1F5UTV6ODRnbGFKaHQ0UmVS?=
 =?utf-8?B?eUthOGZHbkVHM1krSFIyYVZGK0pObktRa3l2amdrajQ1Q1RSRGR5ekdoZHhp?=
 =?utf-8?B?RG83YUR0V0g5azBSejZ1RkJTdUNsZUVVQk9jU2RDU24wTEVPOGxYSklRZytJ?=
 =?utf-8?B?bDROeWpaNExaaGVOMkZqK1RJb0Ivb3ViQXM4TnpISWZHcVcwK2t3aDRhTzBj?=
 =?utf-8?B?a1I2WkdWYXZNcHVlenJrRzIwTWtCQ0RrZjlFZnR6OEQ4WVhKUkZQUFFxUmth?=
 =?utf-8?B?OE5TaWs3N05FemRWdUYzSUErTU8zTk5qTythVlpvQURvMk9WZThveGZYaDhp?=
 =?utf-8?B?bXNzaGUvb21mM3UybnJSODRoalF3cXFxWlJjc3hxa2ROZjVOcXFYUGJ0SWFR?=
 =?utf-8?B?SVA0Tm9odXRHWlpvWnhIRXMzUmE5ZTBUSmxKeGZsTWxNOFNBWVNlSFBQcC84?=
 =?utf-8?B?Wjk3L3gwbEJ6SGdaL1djbGFvelJ2ZzNHVXJzOTNGMG1IVFluamE5WmlTaStJ?=
 =?utf-8?B?RGliVFE0Tjd3cjNaWmY1c0UvWEk2d2crYzBPb2xrWndtUXZqOHFMZ25ndXQ3?=
 =?utf-8?B?V2FRMVU4aXphNHhZbmJsOTUzNGVHYjIrOCtPc3F2dFJwUUFWZWFqd1RmMWRw?=
 =?utf-8?B?eGpEajFPR3pzWHN0cHNtVmo4MVlzUXZ1ZS8ycGNOTkYvNkhrSTF3S3NGdnpy?=
 =?utf-8?B?OC9DRWNjREZtcDNsRllrNHc1T1MvdE1oTnl2dXVCRGx5RGllbGlHRVplQXFX?=
 =?utf-8?B?ZThzSEdiT0YvZ1R0NEEwMm5KTkFKQ2krSU5GR3FkNGVlM3NYTVlFb2czMW5i?=
 =?utf-8?B?L1NOYmNWeHMyanBrM3VEcHQzcjF3K2JMVzAwYy9kSXMyeHBnSEFvdHNQaklL?=
 =?utf-8?B?ajdjbk5aZWZuazd5OHlmUGtIeUpsRHI4eVptMXFVc2JDS2JwSlp0NkltSE9z?=
 =?utf-8?B?ZW9hNmU4bzNVLzlqN1Z3K0xQTDNZTmFiY2pQalJnVElCYk1ybkJvSUdDWFVw?=
 =?utf-8?B?bzl0VGpxaVNiQXlaRXhINUNoNksxOGtsWnl1R0d5SUpZclI5NkZCOC8reTNh?=
 =?utf-8?B?cm1OZXphKzd3eUkwdURkTkhmb21TTFBlaEZlZ2ZrV2o5WVh6eTVnY1BoMDMx?=
 =?utf-8?B?NVhCdE1ydldIV1pEVkQ4NDhlVzc4clpZc3d4bFcyU3gvNWFyLzJ4RVJ6ek9D?=
 =?utf-8?B?cXl3aXNaR0dBcllXRCttaXdJTzNCc044c2pJbW4yUEN3eVk4TjM2RUhaaDFr?=
 =?utf-8?B?MGk0Y0o0WnRpSEFaQXJNSWlBL1c2ZUVnbUpKVWRiQnowRjFqRy83aVNKeW80?=
 =?utf-8?B?T3JvVnA3eHI2c2JXVzU2WUJpbTVIQ3lPMnVvT1ZRdFJQL2NueGY5VTFHYTVu?=
 =?utf-8?B?VnFnMjVCRllRYjJ3UE1YYjM3ZElTUDBCeHNyUXVrUlhOSGlwbExpbnhPeWJ4?=
 =?utf-8?B?ajIwY1pyUnNXMzJUL3BuRm55R1A4czMvaVVXYWJ2NEo2T1BxaWpJK01BZ1pq?=
 =?utf-8?B?a3ZkalNWRlZ3ajR4b2Rqdzg2SjI1c0ZJYUZNeFNOcFNMNjVMdWllb0xybitP?=
 =?utf-8?B?WFNMZXp4MmcweG4xL2VicDd2MjNua3ZFNHVweTlRQVN3aDBMdHFRZXozVi9s?=
 =?utf-8?B?cWRLczNzV3BkMkNzVlFxZ0FhSUpPZ0xKcUlSV3pab21tZCtsVlpiWjd5VGpO?=
 =?utf-8?B?ZExTSWpJaDVLSVZrUUVuZGljYXRNS2ZFZ0QzOS9ITUF6MERyWE5UbnZnTGha?=
 =?utf-8?B?SnlVVUpEaWxkOFBxK2NZbXZBRXpKT2I5ZldsbGpRYlJ6VlNsNnhhM1JDbUtB?=
 =?utf-8?B?alN0dG8wbmV3b3NJNVBFRU9ZNHI1TEJZbzI3RkRPQXNkSHR2djFmNkdnWU42?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b1bef6-2f3e-45a6-9eb7-08dcc5b48e42
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:50:45.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYNwmgDWDc9NHCg0p997u4elfKsi0eDv6QuygEkE3iQG5gAnPmVi++Pfm1AM1cG9UZ8lOV31N3XoNIBDQdb85g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB8023

On 26.08.24 09:36, Florian Bezdeka wrote:
> Hi Philippe,
> 
> I think we found a missing backport in dovetail 6.6 and 6.1. Jan
> observed the kernel splat below while testing.
> 
> I'm quite sure that [1] should be applied to both mentioned branches.
> 

And it seems to help with my 6.6 case - didn't see the splat again after
applying the change.

Jan

> Best regards,
> Florian
> 
> [1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/1e530a1a8bbd0b7db0e660d27a3c191a649718c3
> 
> The log:
> 
> [  101.430669] ------------[ cut here ]------------
> [  101.430671] WARNING: CPU: 3 PID: 1944 at ../kernel/irq/pipeline.c:303 inband_irq_enable+0x10/0x20
> [  101.430676] Modules linked in: 9p netfs rt_e1000 rt_e1000_new rtnet
> [  101.430682] CPU: 3 PID: 1944 Comm: ld-linux.so.2 Not tainted 6.6.41+ #105
> [  101.430684] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [  101.430684] IRQ stage: Linux
> [  101.430685] RIP: 0010:inband_irq_enable+0x10/0x20
> [  101.430687] Code: cc cc 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 80 3d aa 3f 2b 03 00 75 09 9c 58 f6 c4 02 75 02 <0f> 0b e9 69 ff ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [  101.430688] RSP: 0000:ffffc900016d7f28 EFLAGS: 00010046
> [  101.430690] RAX: 0000000000000046 RBX: ffffc900016d7f58 RCX: 0000000000000814
> [  101.430691] RDX: 0000000000000000 RSI: ffffffff829c5c37 RDI: ffffffff8299b2c4
> [  101.430692] RBP: ffffc900016d7f48 R08: 0000000000000001 R09: 0000000000000001
> [  101.430693] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000002d
> [  101.430694] R13: ffffffffffffffda R14: 0000000000000000 R15: 0000000000000000
> [  101.430695] FS:  0000000000000000(0000) GS:ffff88803ed80000(0000) knlGS:0000000000000000
> [  101.430697] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [  101.430698] CR2: 00000000f7f79270 CR3: 0000000006676004 CR4: 0000000000370ee0
> [  101.430699] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  101.430700] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  101.430701] Call Trace:
> [  101.430702]  <TASK>
> [  101.430704]  ? __warn+0x81/0x180
> [  101.430707]  ? inband_irq_enable+0x10/0x20
> [  101.430710]  ? report_bug+0x10b/0x200
> [  101.430718]  ? handle_bug+0x50/0xc0
> [  101.430720]  ? exc_invalid_op+0xc7/0xe0
> [  101.430722]  ? asm_exc_invalid_op+0x16/0x20
> [  101.430731]  ? inband_irq_enable+0x10/0x20
> [  101.430735]  do_int80_emulation+0x62/0x120
> [  101.430740]  asm_int80_emulation+0x16/0x20
> [  101.430742] RIP: 0023:0xf7f88907
> [  101.430744] Code: 00 50 8d 87 34 46 ff ff 50 e8 35 91 ff ff 66 90 66 90 90 e8 08 33 00 00 81 c2 eb 26 01 00 53 b8 2d 00 00 00 8b 5c 24 08 cd 80 <89> 82 20 0a 00 00 39 d8 72 07 31 c0 5b c3 8d 76 00 c7 82 24 0a 00
> [  101.430745] RSP: 002b:00000000ff9b80d8 EFLAGS: 00000292 ORIG_RAX: 000000000000002d
> [  101.430747] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000000000c
> [  101.430747] RDX: 00000000f7f9afe0 RSI: 00000000f7f9afe0 RDI: 00000000000007f0
> [  101.430748] RBP: 00000000ff9b8294 R08: 0000000000000000 R09: 0000000000000000
> [  101.430749] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  101.430749] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  101.430758]  </TASK>
> [  101.430759] irq event stamp: 1889
> [  101.430760] hardirqs last  enabled at (1889): [<ffffffff821c444d>] do_int80_emulation+0x5d/0x120
> [  101.430762] hardirqs last disabled at (1888): [<ffffffff821c440e>] do_int80_emulation+0x1e/0x120
> [  101.430765] softirqs last  enabled at (1724): [<ffffffff810949cf>] handle_softirqs+0x23f/0x3e0
> [  101.430767] softirqs last disabled at (1715): [<ffffffff8109525f>] irq_exit_rcu+0x9f/0xd0
> [  101.430769] ---[ end trace 0000000000000000 ]---

-- 
Siemens AG, Technology
Linux Expert Center

