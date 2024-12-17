Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F981F8913
	for <xenomai@lists.linux.dev>; Tue, 17 Dec 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447319; cv=fail; b=m46nVddhS4xiGsWamGE33kEiRcM3aIKLxmkrXvjFYOHmWC1oPmBRZCWl4/P3wbzn/sAh3W2TrdLvapEvqm+IrXyyH4NppB06PaGaXDXtpIKvQCvj08RTXWLuTBM9SvWoTE5XTnYje2I4EhPXj8e4qv8vA0QylSF6F8V6BgFSVLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447319; c=relaxed/simple;
	bh=utiduQvDKUfXCyHE3LGpp1GYGzZD9e3/kUNiUHRTnnk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2B+QuQ4g/VqzThOsKgFjH079qasucBejwSFhf+W8croDFDvdkM7wp09IgjsZLsaQhpKAwfPfotNWnppHXLRO3DzqjLkyVa2Ib3yn+T0B/7ROhxI2WsOg2nJSaUDYVNXAcOBFQVpsQjXrEQLmVs2JBE7HgriIAsUjxVJUE1YOpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bj6z4Gz/; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bj6z4Gz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKYfbiNa0LG1HQPI1FtO54jYF3DYY/YHnWwEE0K5sAqS641cbEyPJSJGFlxDubwJfZKLMJFCuwuzo4GKfZ52O/OpFe1qYz6WYlRyLE00z1ZIwWELET+ablxPxeXbVqg1xiL09DXUSHvvIMyHCZ1vAvMYI7St3wnVSQiMprXmg2GshLtlZVmmOyR9Q1ayOYtZ8byT4eLooMn6crEIvRbyi0BUMxy1OSkPYXwHZSqwvxnNKeXvPcsQ/8+k77lARlXrLRH9oydIwL2ERHQDOvVXTEjv+k4K3Zrtswh3ZpUrwU62W1/KODbskZ9xSeeE4o/WCt8jNwVl/e3PzzsUaS1lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh+CUsLKX807Z5JQKoHvaH82lzNPc+0oovrjp6sQrds=;
 b=O0zXE9kmALsNkNmJriuiTpfCkiz29zDAn4oN68xGPyoDGaURWBNJXKIjXiuf0T8SRoOvwVorCGZQFvuV2ZuXSL5qRjs4Ov0JqDRYtRNJikOToHBfGLp1+Ytjodbny5c1otF/AU9qjVjIXXvCOfF6ZZEM/eZ1F9Qpv3gROi7TUcGWLRh8EHludCQt5o0IVsuyisVdQEOaiczX+c1LA9VpBCWp8THpZrMq0ZPnqC1bAkCClSFUHe8GK9sFKoX1NR2JyPsnt2fT5X0m//jgtcSLOOs/rCVmdRVgSpXkykUZZlkdjY5WRBdOoUPr0hrpxuecG/vrodmVEslEZAX43E6LzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh+CUsLKX807Z5JQKoHvaH82lzNPc+0oovrjp6sQrds=;
 b=bj6z4Gz/UyxOnrCGdBDI/kEZMNhhIQ0e2Ps6ac+ZKtE8sSRSIuI7O0ERPppqb3hwlAKgWnMJ++BlD0u7fohnHjbFqlwJQbR9kskWv8WTpWJs1wcMZ6gwE9xd3Tv7SJQuF/z6GCKZKSjRcx11Cu5bSIEk328fGlkG3AUGWMGKABNc8GS7FXrCqHjHfnFKjcBd8LOofnVahv9lvi7wiorQcaoKfp7UfukxLp/6JzWV8QOf2JVwImkQcrjazlT93c31cg5ZFbcDmNm17GJmnAw4eqaARmp9VjC0gF7GZRFc1XSiLyTF4MVcBTq/8FiYqrQhOk0+ij5varoNW9RcqppTTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 14:55:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 14:55:14 +0000
Message-ID: <d6f59365-676a-4e23-9315-a3e77ac2b88a@siemens.com>
Date: Tue, 17 Dec 2024 15:55:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/spi: Add support for Linux >= 6.13
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241216163212.935315-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241216163212.935315-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: f2970e03-c8c0-40cb-629e-08dd1eaacfd9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djNHWUtUNHlHQVJINjhDY0R4N3NWcVRKRXBycXdBdWY3MWxvWXVkb1BZNEZ0?=
 =?utf-8?B?MkZYcU5XVlJIalJ1anNUSnFWd2h2am92cER5ZnVzM1VjT2VJa2srSHYzWnlJ?=
 =?utf-8?B?ZWpmSXF2RFJ0Ti9LWklMc2NvWkVERFZjRHQxY1B5U01FSndzYXdNUWVuQzI3?=
 =?utf-8?B?ZXBtakplR3Q2VkRWOFc3NFV1QnpEamlSSVE0a081dmhOTkdkeE9SYWJKV0tV?=
 =?utf-8?B?UkE3M2hCWjdTNklKTTVRd2VsY1V5NWxQNkQyY3IydnlDUTYraVdjbkZFMXJO?=
 =?utf-8?B?cGFZcVVITE1KRE1aZzlUTThmbkdKMFdOUWw2cWYxSTdkUmNMMDhRbEVhbWhV?=
 =?utf-8?B?SksxV2dRR2xaWmtUZ2tiYjA4V00rMnNXd0JNNGJZejBLU1Bja0swTE9ING9F?=
 =?utf-8?B?aDZLVURGZVV1STVGbllkTVdHUWZsQjl0V1A5QzRyL2RoWnd2dFdISlZRYTlx?=
 =?utf-8?B?L3huS25uVVliV0E5RGtSa1l0VzFKVXNXUGJHTWZFRE1idEdoUjhBcXZGcHBZ?=
 =?utf-8?B?L29qV2pJbEFlMEFadU9aU1pQZFhRTXhXSFBsRU1ZOUlDSzd1RmlJS1V4ZVpD?=
 =?utf-8?B?YnBHMkI2ZGRHaS9WKzE0YytyQW55SWJ3bFVWUkdrck9kQVhVbTBraGY3dk9l?=
 =?utf-8?B?UmFsZzIyWUhlNkZ3Qk0rY2ZwMUZOaFFGcUJnUHJwMkhKTjdwb1RoQjRZSitx?=
 =?utf-8?B?MjN2NXlOUUF5aGFDQUJ2dWF0QURQRWhiOFRxb2hZT3R6RkVnb21vVERRUERJ?=
 =?utf-8?B?NFNMZEUzZkp1RXk5NG5vZEhRRXpoMGVTUGl0dDZmQzJiQXlMeTQ5Syt2QVB2?=
 =?utf-8?B?bkpHRXA4MTV5MXJhYkZhSmpXQ2tmS1QvMzM3dTVXNzNxMW1XSHZ3VVF3dnM3?=
 =?utf-8?B?aTZscGVwYWxpa1hHdG9vQTlVODA4d1BVVDkrUUNPRDBSTkVqQThtNDZIMUtP?=
 =?utf-8?B?MFR5NjVITTNSNFE1L1BNL3dtYytzQmhCL1c3ekN6Vzc4a2RVTzNYRVY2WU05?=
 =?utf-8?B?VGFLZ1JjMDYyQ20xRjNVeE02cEdQbCtBYzh0TVdxZDFwSStNUmo5c1ZhMGo0?=
 =?utf-8?B?dVNtVFRKcTlsQmQyMWVPL2RRcjhSa1NVcnpHdHgvS24wVlZmbnhRdmNWRi80?=
 =?utf-8?B?dExIcFQzaEV1K3BqZlRLZEkyaFNLZ3hONzJaRThHcEx0ditBWWYzeENNN2Nt?=
 =?utf-8?B?SHYwTlBtMlRiOExQcDIxei9DRlR0eVN5ZlJ0N2Nvd2EzK1Fwa2poQmZOOTQw?=
 =?utf-8?B?MkxueHlHSGNPYTJoNkZrcUpIWTFpVHpJSW8vOTRUV0g1aE00V3YxZ20rWGpX?=
 =?utf-8?B?YllTZ015Rk1vOGFNWDlrc3NRYXliblFuYXpTcjVudDdSNWlHRmR0RnppZ2hq?=
 =?utf-8?B?TWpMbVQ4UUppYXBGd0t3WlJsZEtaK2JOb1FvSDJkdlNSMWNKOUMwcDU3c20x?=
 =?utf-8?B?dG5CNWs0UzJYTG1BNFF0L1B2MDkya1VtTFFJN3k2YjBTLzJEVndaVnBBMkRD?=
 =?utf-8?B?T3djd2Y0MUExSFJVc20xbXp4ZDJQMExBZnIvOEM4WDhjcDZHcEFFckhKTThC?=
 =?utf-8?B?b0ZTUHN2WUdxQ2NDKzJFVk51WWR0Q2E5cHZQd28rS0p1Ni9tNDMzbE5iaGcw?=
 =?utf-8?B?eGcva3pHVVlWL3VTODVRQnU0aTN6WnZMZnR5WWc2clpVd2RzaEZFdW81aVdW?=
 =?utf-8?B?amsyUkU4WVliZUVPRWJzdHVJRVYyVmk0YTJoRWlNek5mbEJ4NWkxSDA2WE5s?=
 =?utf-8?B?cENLV0tsU0ZyRHlvR2g3Z2dNMTZmb3E4bHgvc3BsZncrdXQzcis1TjZPcTBn?=
 =?utf-8?B?emhOeUIra2wxSHdOQnRTTDI3cGQrMHZFdjIrMkRzUHNiclVMTDhvV2RxeFJS?=
 =?utf-8?Q?DL7KXYdGw41Ve?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2RwOWJBKzF0OERlcW1iZVE3NHcvL2pWc1RtRVpwUUVnQ2tGR0gvYUo1cnZY?=
 =?utf-8?B?aVhkYnE1MkxlOUJwSUpnMUhJSStwa2Fpck5hREZKdktTZCtFZmttTkJ1Zzdl?=
 =?utf-8?B?M2JRL0RYVXhpajY5TDlKV0NiU1BYczNwNlhqU2tqZHA2NUZjenhodXpjK3RX?=
 =?utf-8?B?OE91aTAxa1BjeVRsaU8reUV5VW85TC8xbXNvZ0thT2E0R2owNVpvd3ZTZTVq?=
 =?utf-8?B?YlY3Sy9zSEw3YU4rYm1pMmx5eVgwb1FROXo5NDk5VUJLMmpibm5sQSsrdjVj?=
 =?utf-8?B?VnVHWE5WY2lxdm1SSjdZdlB6Qk9PVUNlV2NndUt4ZlpwWlgrbElRVVNqaVJP?=
 =?utf-8?B?MXl2WlFEUjFSd3F6TjVMM0FVMDI3NG0rTGRsM0k1L29qQnFBYUZLVWIvY0dw?=
 =?utf-8?B?Y3QxdG9FR0V6aVN3amFzQW9idFlJMjJUejUwR2RzeWpGbmhCcHVVbFVUVjdD?=
 =?utf-8?B?c09LVXRMczlQeTZodW8raU80OGhsNzAxaGJ1Z3AwY2NWYkN4WmpsNHBwTVVT?=
 =?utf-8?B?a1lsSzgxYzNSL1ZDUnJhV1dlMmFxbkNFS1BTb0hlVjRTUW9iazUwajRZOWpa?=
 =?utf-8?B?Zi9rNFl6K21SM0dFY0hkVU05U1NjeHdYT1ZRbCtRdnNDYklsbEY0cFVwK2hB?=
 =?utf-8?B?TTNZZWtRWlBTYS8rbWc5K3VaMC9nMzlTVVZPN2RDTnhGWW82dnQwd204T01R?=
 =?utf-8?B?WWNUeSt1MElTaExCaUxWVWdBbVlzakFVTHJuRkZLYzlGVElZQnJEYmY5T3Vn?=
 =?utf-8?B?UjlGMjY3NzE5MUozQzFyOWFieG1zL0pOZFhJL2FKNDZsNkFHTkNlSDMrQ05S?=
 =?utf-8?B?NzJnT2VXeGFSWk9zM0xXRmsrQml3NjVrdm11QStFUFNRVDNLakZYZW9RNjk1?=
 =?utf-8?B?Qk85SjFzcVlBSEtNc2QxaHBNb0M3TExVQ3lncTJNcEs0R0NjaFBwMG1PemZW?=
 =?utf-8?B?aDNwUnBxQitBeTN6S0Y4UVZySzRyVUVKTnFDVEZENEk5aEwrcXphVHFENnVI?=
 =?utf-8?B?b2dIMzdNM21kcnVNQnBtMGZwZUFHdnBMOHA3Ymh5TFYyYk9IWS91TDFyRUVR?=
 =?utf-8?B?ZVBjL01aSWhiMW9VcEhrSTUrQmxNWkhRaVk2YUpYcnJMUTFwdnJyeTRRUFov?=
 =?utf-8?B?UWQwb3JWSlpRYUU2eEpDai9DOThjMXFNQTNPR3IrcmM1elRSVzhvei81ZXpw?=
 =?utf-8?B?ek9DY2FEcXNXNW9QcTR1dmFFSTJiMU5vM1pDbnV6VkFlc0oyY2tSZkNxUWE5?=
 =?utf-8?B?bjBzYk5mdVVnTEhKVWhad3Mvdksvdm10NitYRDFZZ0ZGSHRKN0pIZGdSSGZ1?=
 =?utf-8?B?MXFaejVlZW5hOVByVG8vNHMwcjNoa2dCU0ptQTRNeTFMVnlrMlQxMGlMS09j?=
 =?utf-8?B?OWRCdys1ZXNVb3pGYkExZ05QN2JaUmVkTVRDQzlmVi9pbnBnS2pnOVZOSEl2?=
 =?utf-8?B?c3pTbDRGdG1KZDRocldZRUpaWERTSzVZRUxaNlhXV2pRNGI0SVNxZWtHTUFz?=
 =?utf-8?B?V3lpVE5pbWxwNG55N1Q2YWxDekNiMGdTbFRodGU5MmEzR1E4ditMRGNtUGhi?=
 =?utf-8?B?cGVGLzlLODZlQitsQVZpdXhhbUE5UGlPREFwY3FJbmZqenBLVEl6U0lGV3ZI?=
 =?utf-8?B?VmZzTTRtWUVQRnplYXd2RDB2OVkxYTFyYVdQOUZjZXdPV1NaUFhyNGZ2TUtF?=
 =?utf-8?B?NFlFOEZzc2lNbTkySlgxcUVHR3BoM0JnSENLRjZ0MmYvUmgxK1RkZXlxbEZX?=
 =?utf-8?B?ZWFYV0o4S1hrM0Mvd0F5RUdjWTlWUjhyY3NDZExQSkJGNnVkZmlHNFI2eUJ1?=
 =?utf-8?B?RGVlSG1JQkswSHV2ajM0MGJtL294WFc4VUU3TlBSS0kvbnZWUm05RUw4cERm?=
 =?utf-8?B?RTE2RGNtTjVXbytSRmdod2l6ZUlvVFV0RWdKMmVFTy9mUlcvb1pBQzlGWDZ3?=
 =?utf-8?B?aER4eVVpZXdYTi9CcjBRSlJ6YkMwYWw3NEMyVkNaN0dtSUEvVGhpSUkxU0NI?=
 =?utf-8?B?N3BXUEZBc1NJd0VabmN6cS94aGlMSnRhOWtWN3pjSzc0UGlNVUUzbXJjN3Z5?=
 =?utf-8?B?WkdwZFFnTkdqeDliNWpZT0ZuL2NWbWJKNUJNaU1xc01vRlREQ3ZVNnJBM2Vo?=
 =?utf-8?Q?PxS8l2xmdSc4hZx9FT6Y4CUBY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2970e03-c8c0-40cb-629e-08dd1eaacfd9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:55:13.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOtyVzVz/aLOh8//B0jxt4KYA8bkAPXabZ31UmLd4qWx3NOKwwfpFYQA0dYHrjm6q4eKTh70bluFjMmQys0eHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7258

On 16.12.24 17:32, Florian Bezdeka wrote:
> spi_alloc_master() has been replaced by spi_alloc_host().
> 
> spi_alloc_host() exists since Linux 6.1.0, so we can savely migrate to
> the new name for "recent" kernels, older versions will introduce a
> inline wrapper to the old API to keep support for those.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/drivers/spi/spi-master.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
> index f58fc900a..59836fd10 100644
> --- a/kernel/drivers/spi/spi-master.c
> +++ b/kernel/drivers/spi/spi-master.c
> @@ -349,13 +349,21 @@ static char *spi_slave_devnode(struct device *dev, umode_t *mode)
>  			 dev_name(dev));
>  }
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 1, 0)
> +static inline struct spi_controller *spi_alloc_host(struct device *dev,
> +						    unsigned int size)
> +{
> +	return spi_alloc_master(dev, size);
> +}
> +#endif
> +
>  struct rtdm_spi_master *
>  __rtdm_spi_alloc_master(struct device *dev, size_t size, int off)
>  {
>  	struct rtdm_spi_master *master;
>  	struct spi_controller *ctlr;
>  
> -	ctlr = spi_alloc_master(dev, size);
> +	ctlr = spi_alloc_host(dev, size);
>  	if (ctlr == NULL)
>  		return NULL;
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
