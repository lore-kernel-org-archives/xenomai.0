Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101C2594
	for <xenomai@lists.linux.dev>; Mon, 10 Jun 2024 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717993326; cv=fail; b=mD4ypFlGvQK26EoVPxF/EAzoEHIJoBq/Tm+29+x3suDUZjmXIv4KTBMwUXTNBx3hHn10kJ+4d2oakM7P7EOTB2bUoPEK8GtPx/+l0wEKuQkIi5RLANpBBDUYuGVuj+yk/b4NjBzcgUR8n46Mgu8KdR2/aHLTAOLlHIp+lYPILFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717993326; c=relaxed/simple;
	bh=tABO5fVwbAzsqGInFIQ3kTmiLtc+mS0wvk9qomYvEIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6c9gj2yhIGbfnAhT3yfZ3JS3oPX1FmfavCICzlQ8AaWfw7mMn4ump19obl4htemXMk7Jxch09k3/3pbdXEmYhF31v1ohXaHmO2nzNV1t6q+ckQeZpWWeFP6YMfIL4Nh/E+ZSWHImAPxyflG2n54vTSxzpYyMZafCQfMX0rmXZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U359jSzC; arc=fail smtp.client-ip=40.107.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U359jSzC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlQrsLNMgfih27prSEFDXB/xFwi4xXhjH6fKY6qe4q1TXfmPTDzuURwMd9kqCyb12F//YKsetwEbi4QuVChbRWZ5k57fwuQQF1o0iyA6QN+5hgphdKcy+n8wDXp2/VN1JV9vgRiblxWDe/kOkn7PhOdeFImCWg0HRoqUAmDJvf2tIA1WqF59WAykNxBnVScvSWo998y8mWwacsdjpEsuwQYJX9o0s3QL8wuNGngJJBDC+dKXRitkq5A96rqdZReWRH2UI1mpEo7GtKyiHac5vJwit8Qo4sIlxyvdikGg+LG1zvtTdyuKxwWj63j7+y9chg/R/0+27BfZF5oA3jkD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEiqm/BqZd2T6u+fJUVMmyhc7l5DBhiC5vAY8qnLRes=;
 b=fIAGbYD5I+yD/HJOt9WvGWB6dYnE/QQi0Xe+H19jWmsIbpLrFqDR+pvuxgD76W/F1W4KYiIgqKiPadf/TdpCIQWnGkkv032CN5GCmmoZ8jziSQ5pStDhmX4Qbe9ydL5yDwTHbladqSwIMv/PQfSt9QdrgIwKQCLQGgbart+iYteRaQ5rEBjdMYex4Pm0D3qmzOUT8BHNS+oKX74HAS9pQCVolKj61utugSM6tW4gQs88ubRupiZNSAMhILKcbiHZnNREtsUOz0StiAZWNkBwQcYH3UWTvQcykETm87keT9rjDB764XtgirGMOhbC4QWXxp10brSy+x9C5VIQDxhv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEiqm/BqZd2T6u+fJUVMmyhc7l5DBhiC5vAY8qnLRes=;
 b=U359jSzCY9ac5NRrmgUpgztYalJz74dCYNaIVOfGkdlxj0GaY840I3hnQ3Q3LClm2s+xzLe29ltBPhpEDfVNB46js39vrYb5grQkI4yDdZteKZnEMdSm+YwvfTZRrxG6GAOYZ+ispHiSjD9801HgiT8gorZWF6IMyZwBDX9uFdRph1b+K1aOeDLC5ZInPhdcCXKfz6873TBDVYyBsAAhpJUdPDK5shfmhsZsZeI3uHFXvpP67nJWbz+b6mwaNJiKOg2EnmkemiR/eGSE8kD2FEhfuKdIIYNhnjaM2cBnkhkN08XwijtLA7xAAX3RIsStxKqFnyk9r8zDo2gOFFxgxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:331::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 04:21:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 04:21:58 +0000
Message-ID: <dc350628-f444-41e4-93e8-b9724046b5a0@siemens.com>
Date: Mon, 10 Jun 2024 06:21:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
 <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
 <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 509fb992-9aa1-47cd-d7f7-08dc8904de1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3NvL2NEbWxNYVVYLzBBdnVMcjRWSEx6VVJ6bkRZeTZ3L2RLMFdJYXU0Qnkr?=
 =?utf-8?B?bnkwKzlLejU0Sit0c2JSTHNJUktCc0ZNVmxjeEhBL09XanFUQjRJcjFiaVBh?=
 =?utf-8?B?cEtCUXFTekFQUTJPTUJpWGV4L1NBUDU4NG1PNWpQYmFyczMyc2FzN2JBS2tX?=
 =?utf-8?B?RkRYeXgvMmRXOHp1MHlrcUZUYjZWTllLUEZBcWtJUHpwSFEzMW4xMzh6d1hB?=
 =?utf-8?B?eWprQ2Y0M0NJYWNuTUFUcnJ6QngweEJJSVFZYUdiTUc0K0NHaDhuM2dHcXFO?=
 =?utf-8?B?VWt3eGNpMzZyZVMvcXhFdHBMZWE0a1B0aVpaR01vZXp3eWswUXVQTTRKNXNO?=
 =?utf-8?B?OFIrdlo1QWNvUUdleG1nTVV6N3BaM3pLSE1LaVJ1eTFpZFhKUngwdUpRaEtE?=
 =?utf-8?B?L1V0M096WWtQUzZMU2g0Y1dlNHUvdFNOVG10ekRWWXdrWFI0eVA2L1Vta0w4?=
 =?utf-8?B?TUhoU0dudkllckZYSUhCelVXYi84Rk9XZno2S1RqSCtsc0xmRndRU1FpUCsr?=
 =?utf-8?B?MHBNa0ZhbmxaaHF2UnFxK1BQMWg5SHZjSlZ5VkNzOUprakh5RmpybHpoakRO?=
 =?utf-8?B?VjBVMW42aHBQWk5rVnlXMEFwa3pEUHlIWWpaN0x1bWJrbXBGVllsR0htYUxp?=
 =?utf-8?B?c0JxMFlyclY5NmpMUmQvYStWOEdwRFFHOFRKdU1qOWR3MGY0VlNVb2tXbHc3?=
 =?utf-8?B?UEVldnphMFBOUE5UM24zZXhNc3c0TE9yamFaMkxGaXdVZDYzV2FKYytscHJT?=
 =?utf-8?B?aHdmWUpJaXJCTEY3b01GY1RGQlJWR21XZEdJMUVhZGdyQ0E1SHMvb2kzc1dj?=
 =?utf-8?B?NmhENlJaaUVZb2VpeWQ2WGhuNlI4QnZkbndlVnpqbnZBeGRRYURZNW10VjJW?=
 =?utf-8?B?ckZoR2JYTWZrcDR0TEZBQXE0YXVDeHFseFRFdVRvREpXencyK2FoUTJ2bTNz?=
 =?utf-8?B?YlIyS2J0dTlqRDA1OEdyaGJSRjRpWHdXc01MUzF4M2pkUVM3c0ozVWdLV0do?=
 =?utf-8?B?ZFdKcGNjMThUTHZ4d3R6S1NZQVMvUW12NjdLcUR5cXVRbWVabjRPbDhvTnp1?=
 =?utf-8?B?OUFUU0dnMzZXU2JDbDlrY1kzVzdZNHJsN0F0bmk2YVhIYzdEcGFlSFRwREQy?=
 =?utf-8?B?eDJPbU0rSUFHNnh0RTkvVVY2Zm1XQlIzdGdwWndyVWt0eGFMVEdDTGJXb1RP?=
 =?utf-8?B?bTBwc053LzZROTlnQWxsTmQ1ZnZHQjFveXc0NTdtRlBXUEt4U0N1SXRub1NK?=
 =?utf-8?B?OHpXdVVWYm1DT2RtZ09nU3BFMitwR0UzeFJwNTF1dzZrNHhvd0grTzhoSjNK?=
 =?utf-8?B?dFZMbjdKSUJYcVEzaTc2Nnl3WXYyYU1EMjBrUE9vSlNhVVpxcWo2bVJVZHVt?=
 =?utf-8?B?dHdrcXFTdjBzRXFGNnFUT2lzVDdyM0c1MGZTT1Y4V3pJODc4N2ZOZ01IQTgv?=
 =?utf-8?B?eUlsdkEwdk9uTDUwT3pyaE9FSU43MThiUG0yVm16VXNVeWxVNElHbmJRdDJj?=
 =?utf-8?B?c0VFczgyVWh0L3hHNzZmWDF6S2Iyd3dsUEoxTjNxSU9pM0JrUzcwYXNYZkRQ?=
 =?utf-8?B?V3RCRmtnS3dBei9idzBPY1VZRXhnRU9RWkNNbHhhcUN2b3BPVEE0Z3NYL1JT?=
 =?utf-8?B?aEo5NnpqY1I5SjJjblJqSG91dFA4M0w1R2JrczBoYkEwanVlNUVyN0lMY1RS?=
 =?utf-8?B?UTNLQzNNRmRCVEdJUEVVU1JZNm5icnZlZ3dsVTdoQTlHYjQ1U2duaGhSSGJv?=
 =?utf-8?Q?O2hn7JlWBoHUnD9feNUwBT4o82LmXAw99jsT9tf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZvN0RScTlRaVBMazdVRDNMOE9yM0VIanNEMllEUkhsNmpMZi9nTmpacUg3?=
 =?utf-8?B?b21FOElYbkFpMkJXRmlPQjhZN0tyaFBJYWgyQ2lGTFYreW5mN0hMR2JtSkZJ?=
 =?utf-8?B?STZodEREY1E4V2phc1N3Z0EvbDQ5RUYwTXRwZ0NucEhRSUtsT01hS3hoTzFq?=
 =?utf-8?B?aXU5TzFVOEVSckE3NnlUT2xwN29LZWd2cFNRMXo5cUdiQXVKK1haZWV3Tmw3?=
 =?utf-8?B?SE9OL3I4L1N3UHZ6NHpZTFBPNWhkYWx5VUJ1MDM2RFVKNDcvNzlVMlZzVC9Q?=
 =?utf-8?B?NFlnTjBVUDNuL1NNQ0IyU2tMZDM3TEJiVjJ2TVBiekFSazBDU25QcmRpMzF5?=
 =?utf-8?B?RjRiNFBmS3hvZ0RXQWNTODlMeTJYd1FUOStFeEVoOG9DSUROSWpmSldlbjZE?=
 =?utf-8?B?aENpNUdRRmJ1S0ZYOTFMMVgrNG5UZ2pOekxRMGgrTTYyNUF5WDBkdFJ3T2wv?=
 =?utf-8?B?cnlUVUlPYkIwcWRiSUt6WERMaXJpN1BWRDR3UU5Id2JqMUZUTS9oMTBVcG9m?=
 =?utf-8?B?TklJc0RwVUJNODUvcHJPV3FER2oxOSswWnNkbksvOE13a2ZNRkVUdG83TlE5?=
 =?utf-8?B?ZktSZGMwZW5FbFhDaUpzL3ZDNXhlZi9NUUdkZ1psK2ZBSVRJMVBqaHZWUW9q?=
 =?utf-8?B?V0oydXN1TWprZkhsYmw0L2JXcXpXMW1jY2lOWHRHczljLzc3Q1dNMXlJbUVT?=
 =?utf-8?B?bjVGOHdVNGxFbTRWaEJsSHdhdWMwd1RveWh4VC9pTFhOUytZbTNUYWRXWk5w?=
 =?utf-8?B?am1yeStGa1h1UUxEWXRLZzBuRHIwZTB1MDRMV3hrdkpoVXR4MjlJLzhWeE1B?=
 =?utf-8?B?STRUSjUzYzdDSUdONi9aMXNBY2FVWDI2c2pEbTJlVStvZFh2a0RxaW1DZUZO?=
 =?utf-8?B?akJGb1I4d2pleXU0cEdETE10d1B0SU5IY3BnR1FBZXBmczFxdjJzYUJkei9Z?=
 =?utf-8?B?bzdLSkUyaFdUTFF3UFlET2xqODFSYTlZQnlQZzJoQ0lkM0l4alpBTnM4ZjF6?=
 =?utf-8?B?L0xxaURaNTJIZXJiWGhGdU5zVUE4K2x1V0V6c2xVNnBvc0trZ3d2NXpEVDk5?=
 =?utf-8?B?SWVnYk1uMXArMEo5TlBDWEJTV284ZXlPemdVeEd0NGpkUG1iZ1BvYXY4VHBr?=
 =?utf-8?B?STMwTHIxa1EvS3ZUTmthaW5hbmRidFZSeTMxQU9BQjlUcXIxUGZ6WU5mTjFr?=
 =?utf-8?B?aUR6dUhzb1RmUHp1VXNsOEU5V3ZtTkVJV3BjdEJHQUJJQlpOd3NxUitvWUFq?=
 =?utf-8?B?Qm42dWVyZFAwenZjdmQ3cUI4MERJb3JSQ0JOb2thd0VvczNXU3pTT2U3YWlv?=
 =?utf-8?B?b0k2SG1RWEp4QXd6NC9lS0J3R1NnWjBBNjdHdFZodTZYQnRVN0dISXhPbEdM?=
 =?utf-8?B?dXFNV1FwSUJKYytJOGJTRzIzaUJtRXNrMitvZnM3TDlxMzNtSE5RcU43aDJz?=
 =?utf-8?B?U05QaFJuWVZkRlVhMCtvZ2pjVUNGK20rUUFlWWNmUlBXdnkrRDBvUmZoR213?=
 =?utf-8?B?c1pMSnA5WjA5N3lKNWNIZVBrOUluRVpiMW5EbmFXOEprSTZiSGpwMWZBWkJL?=
 =?utf-8?B?WHdSV2VQVmY2VVNDRHE5SlEwMEhkak51MUVqdE1KdjU2ZTRYeHdJQWdsRzcy?=
 =?utf-8?B?dytaa0dNZFFrRnpuajBOdkNXTmE0amZIejFiNzFmU0ZKSElnQ2cva3JqVnpE?=
 =?utf-8?B?MGtkYWRNNHV4K3ZnREg3bnhsRW5wMHpsdTV0L1pYYWVkWkxWd1pDamwwQkpB?=
 =?utf-8?B?NU41ZWZKVit0dVE1ZnhLZWZuZVdrWjlIdnpVRi8xQVNXV3YxVzNJNTNZaEkx?=
 =?utf-8?B?M0dkQ3lFRnA2NmRuNHlqMFF1Y1FtZmtvNzlzSzNXMnJBclg5ZW9QTzZ4Qi8x?=
 =?utf-8?B?bmwwTnAyQWVUQWVvekhlWVdQY3pPWThraVUwRFB4SVc3Q3JUeUVyWGxRZ1du?=
 =?utf-8?B?Sk1LWjBZVERzdU9WV3BWMDlBM3c5ckV1Z3gyV3AyTUI4cjVuZ0x5bllGWFVz?=
 =?utf-8?B?YVNsLzI2NkU2d1crWnpUcDYrVWl3aGgxUFptbHF1QjMzZ1BMa3dRbUFyV1pw?=
 =?utf-8?B?UER2SFhvcDIvZUNKMlRtdXRvV1p3S0hLdG42dGRHbXYrYWlHNnZudDZva1kz?=
 =?utf-8?Q?z7srNgpYVFNQZmNgctjMn59Y0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509fb992-9aa1-47cd-d7f7-08dc8904de1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 04:21:58.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGdD+P0A3I24AU+LTv4N6V9QXtBrDYBa82tBXs2ZRel3aHbi8Z77Sb8dDcFhAPloOnnll6DwlPTd8WiTvFPD1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5138

On 09.06.24 13:44, Florian Bezdeka wrote:
> On Sat, 2024-06-08 at 07:31 +0200, Jan Kiszka wrote:
>> On 08.06.24 01:04, Florian Bezdeka wrote:
>>> kvm_wait() unconditionally enabled HW interrupts when called from
>>> pipeline entry code. That broke the PV (paravirtualized) spinlock
>>> implementation.
>>>
>>> When running with CONFIG_IRQ_PIPELINE enabled we always call
>>> safe_halt() to allow HW IRQs to be handled.
>>>
>>> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
>>> Linux.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 53 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>> index 655b1cf8c9ab..3180a26cdfe1 100644
>>> --- a/arch/x86/kernel/kvm.c
>>> +++ b/arch/x86/kernel/kvm.c
>>> @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
>>>  	 * for irq enabled case to avoid hang when lock info is overwritten
>>>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>>>  	 */
>>> +
>>> +#ifdef CONFIG_IRQ_PIPELINE
>>> +	unsigned long flags;
>>> +
>>> +	/*
>>> +	 * We always use safe_halt() to be interruptable by HW IRQs.
>>
>> Nope, see below.
>>
>>> +	 *
>>> +	 * HW IRQs off:
>>
>> Let's stick with the nomenclature "hard" instead of "hw".
>>
>>> +	 *
>>> +	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
>>> +	 * lock owner.
>>> +	 */
>>> +	if (hard_irqs_disabled()) {
>>> +		if (READ_ONCE(*ptr) == val) {
>>> +			safe_halt(); // enables HW IRQs
>>> +			hard_local_irq_disable();
>>
>> Just halt() - if we entered this with hard irqs off, we cannot assume
>> that it is fine to take an IRQ before returning. The kernel doesn't do
>> that either for Linux IRQs.
> 
> ACK.
> 
>>
>>> +		}
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * HW IRQs on:
>>> +	 *
>>> +	 * If inband IRQs are disabled the LOCKDEP state is already correct.
>>> +	 * We can disable/enable HW IRQs without further bookkeeping.
>>> +	 * = Linux IRQ context
>>> +	 *
>>> +	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
>>> +	 * infrastructure about the HW IRQ disable/enable event.
>>> +	 * = Task context
>>> +	 */
>>>  	if (irqs_disabled()) {
>>> -		hard_local_irq_disable();
>>> +		flags = hard_local_irq_save();
>>
>> Why this? We have tested that state above and know it for sure. Just
>> keep hard_local_irq_disable().
> 
> Paranoia and to clearly express that we try to restore the state to the
> state that was observed on function entry. As hard IRQs are/were on the
> result of irqs_disabled() might be outdated. (I think that would be a
> Dovetail BUG(), but paranoia...)
> 
> No strong feelings here. I can change this if this is preferred on
> other ends.
> 
>>
>>>  
>>>  		if (READ_ONCE(*ptr) == val)
>>> -			halt();
>>> +			safe_halt(); // enables HW IRQs
>>
>> Yep, this is needed to avoid delaying hard irqs while waiting for the
>> Linux lock-holder.
>>
>>>  
>>> -		hard_local_irq_enable();
>>> +		hard_local_irq_restore(flags);
>>>  	} else {
>>> -		local_irq_disable_full();
>>> +		local_irq_save_full(flags);
>>
>> See above.
>>
>>> +
>>> +		if (READ_ONCE(*ptr) == val) {
>>> +			safe_halt(); // enables HW IRQs
>>> +			hard_local_irq_disable(); // fix HW state for LOCKDEP
>>> +		}
>>> +
>>> +		local_irq_restore_full(flags);
>>
>> How about this instead?
>>
>> if (READ_ONCE(*ptr) == val) {
>> 	safe_halt(); /* enables hard irqs */
>> 	local_irq_disable();
> 
> Confused. I think you mean local_irq_enable(), right? Otherwise we
> would jump back with hard IRQs on (again), but inband IRQs disabled.
> 

Yes, enable. The goal is to avoid that hard-irq back and forth.

Jan

>> } else {
>> 	local_irq_enabled_full();
>> }
>>
>>
>>> +	}
>>> +
>>> +#else /* !CONFIG_IRQ_PIPELINE */
>>> +	if (irqs_disabled()) {
>>> +		if (READ_ONCE(*ptr) == val)
>>> +			halt();
>>> +	} else {
>>> +		local_irq_disable();
>>>  
>>>  		/* safe_halt() will enable IRQ */
>>>  		if (READ_ONCE(*ptr) == val)
>>>  			safe_halt();
>>> -
>>> -		local_irq_enable_full();
>>> +		else
>>> +			local_irq_enable();
>>>  	}
>>> +#endif
>>
>> Yeah, we indeed need to preserve the original version for the
>> !IRQ_PIPELINE case. This was also broken.
>>
>> Jan
>>
>>>  }
>>>  
>>>  /*
>>>
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center
> 

-- 
Siemens AG, Technology
Linux Expert Center

