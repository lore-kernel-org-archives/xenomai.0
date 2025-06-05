Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFE1A76D4
	for <xenomai@lists.linux.dev>; Thu,  5 Jun 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749100888; cv=fail; b=L9M902o4+tAKOXlyet6MnBlK5Z9rqFWMZg0KCNawsLv/BJVtj9DPvmFnR1s8L9R2npzV3loKPJD26GmOYkdfvF1l0grPOQDhY6AH0r86jKdO/Sq5NJ7IA6uzX8F+zBwlYLs1AW2uTEIH21yrLBojv1PR4hND9vPfNo3zccvjejc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749100888; c=relaxed/simple;
	bh=N+5HIb+lcrKo6YgAVCGOq7ZeadWE+VZPlACEXlzhFFY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jSG3jcHX1QeBCMlXul5v4OLmxj/+8wgy4a3A0T8lvRLeJmlgFRoWvqStHn9R9w/HG/2Mbxei/pEpchqWKh9/lH9mQKG1O652P7zav/l2VvETpoUdE3SuftFNJ9Vrhb6CQ8r4bRuVNZR1WA5tEXoqgA/lvPy5AcsVASKl7w7jsTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DO5vPhUp; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DO5vPhUp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+OlpAMfBbGbEsiIXy5kb1ZqFg/L55rvzuCe7YG9vuqtl2yFgT01fsAfGE3H6ZIwNDSvs70FFZE2Sb7K0n7Y4vzM+7ruaTaKzZEdaE/Ne6XQ5eOcCgq4xSlhnB/sXWUdrj7HuHQDwPIo3jtsCH71QwegvH9YoBfm78N34yx1scDtWehIzjSXFuAKA2yMf1Qzzap8K00vldVfDIm0B88P61sRwuuXTNuB2LZIWlsneCozdoURuaiDOmkmE6kIZOvfbkUomNBqttl/udT4TsuNH38Kxddk4zi50AxRpxM9O8z/4YZz21vKauzhQmzME13x2JPo/e2UikCqN3YC4OLJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SURRC9pumuxM4dEvSYi74sk1eJVXxiA2/IntLoyejY=;
 b=HXkP5lSkbgoxjMuhhphU0LBySkIsdBSO7zV2CawNV7Xe9fXzUnPnKyutmHHoTalN+V89Fj5mU7PY1OCA3f5czyixfRALB5mFsKxNtzuARhHtBLi7QesnkA/3wk9DiagdV7SOr46ez8XGnHz/XX+vUbdE3md01kbg9ot+5FZ88TcuYsmlflVWAnT0pVLlLJiKKSenMuKKjAzWA2eIwhH5duzEuLR2Gp7JQzHfH5A1y1hD29/y+AwRsA9ubNbhiewetlb80tb+sxp8caEVWOGWSRj2ZISYGlhTP6P8szGyTwV9x2KPLh8CFnHwZ6tUGzE/tg4YpCFRaq17KXnVpWP0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SURRC9pumuxM4dEvSYi74sk1eJVXxiA2/IntLoyejY=;
 b=DO5vPhUp5HbOxdldCs4eG7CDO3bue6xZaOvqiKwIvKVem+E95Uyt51a9rL0xW0Ox7at3gWItRjnP+XndY/cq9Aem9LMHx8fdYUEeVsFAtZvbHcU1hZ4kRdVr5/WhweDAxI1gvh0rmrMA6FoxLRYfIRI5b148nfLdSmeaCy7ULIx/IJ+t/rekZNRQm7OrMtjxx1LrgvW9br2Dgsj/z3f9EvwfVpSmtD3AgevxCyjpqqk95eGhFSm3W5QuMm0R+R/GVu8wSCpGY9XHniS5oUKtvo2U5gtLIJNivNksYPga7yiXs/b1SP8Jt569l7YrP+/4C0jwwUWFzrhgsdpgblIzaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 05:21:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 05:21:22 +0000
Message-ID: <f1f882ef-1794-4b26-bb11-19dbd4cc23db@siemens.com>
Date: Thu, 5 Jun 2025 07:21:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Testing RTnet
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0uHLPf4n0hg+PYLLRB0UHzCJhKOVsrje1Afjc2aJEHq4w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0uHLPf4n0hg+PYLLRB0UHzCJhKOVsrje1Afjc2aJEHq4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc58927-55db-44e1-3d2b-08dda3f0cf5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkpLSG5hUTRWa2xVMFYrK0dZQU81RFYvWGRITWRBa1JNa1pPOG14YTJvY0JU?=
 =?utf-8?B?NTRENW9TdEpUU21mcmt2c0FFMWpSV05MczNMZnhUYjdYaUUvc1N6NURMZzE4?=
 =?utf-8?B?Z3lSbEtwV01CdlBZS0dkeTNtaHRaMFV1dGlMaVBmazhRSzNoMU5TRmxveGtY?=
 =?utf-8?B?WGdnWHBqZUlqT3hvc1JiTEtUQ2JXV2VTcHhFUHJBZWtWYmhRcStzTTV4a2xt?=
 =?utf-8?B?eUxTVzc5WkIyb0tXYnlPL0JtdjlUUzg3ekpMZ2RuaWtnQk9tRk1BNVlmeElh?=
 =?utf-8?B?NVNIbVNSRjRiSDl6VzVpdnFCLzM5cE9QU0RZOUFGME5hTHFLbzgwZjJRSjRk?=
 =?utf-8?B?eXFQU2luSVVteHE4V20vSHhTUTljb1QrY085REhpbk83MFVjeEpxa1VVbFZF?=
 =?utf-8?B?cjRNT2NyV3llUEZFVWwvSE5LM1k2K0lKdDVHNzVrR2ZFelhZWjIzY3hETjRn?=
 =?utf-8?B?TlJ1NlZkUEJEcUtpRUFOMEZHeVNzb2c2c1ZmeDhZZVRJT3p3NXd6Z2V2dGVy?=
 =?utf-8?B?UThDbjQyK20ySXlyUXhyTjIvY2NHbFFLczVjR3RMcVRZYkVuRjhlbXBhVEcy?=
 =?utf-8?B?N2lKZlQ5L1VOenZvbC8vN0xNNUFoWlVrTW9MWXJVYWsrSUI0VnhLRThSZ3Zm?=
 =?utf-8?B?MkJyWDlyYWZyNEVxMXRrYVF3ZmFKT0hLSUszM2VyMzBNaUZVcVBEYkR5Y3dR?=
 =?utf-8?B?K0FTZldBV0gyallYNE0zT3JodXB3QmFiUW5iMG1yTHBlRVdaSkhRSG16b3ZJ?=
 =?utf-8?B?Y2YrcjY1WmpiZm5sQmdsL3VhMCtZamliTHg4Rm5qZXB5SlVpVkxubG5YNE1i?=
 =?utf-8?B?UXpuK0JLZnJrY0p6OTUzdVQwR0REYmVzVHlGL2ZCR2Nid1BxbVRabm1IZUo0?=
 =?utf-8?B?bXFmUHA3cGYvMDVWQWtTY2V1ckxUQTBXVmNER2UzZmxMbWVScXVwaWFWeE93?=
 =?utf-8?B?dFMyL2VaMWJoaWJOUWc3RTlxdURBM2lrY0Zvdms4di8xV2gwb3YrRHI5UjZq?=
 =?utf-8?B?V1Jxa1hnU2MzcU14eG5sNEhZaXVqdEpsbDZFVnhlejh2TXJTNDFUVnJ4eEZL?=
 =?utf-8?B?RVhFdnpjSXQweWRRTXU5MGZwV2hvTEQra1pEMjhXK1pEUXA3clo4UE4zU21V?=
 =?utf-8?B?RjhkMU9hRkpadm1iSmE1MXZDY1FaQThIYzU0QVhnVDRFTzhKNSs1eVVGeUow?=
 =?utf-8?B?cmJRcU5HM1FTWGFUelB5bS9oMEtVZFVhR3F5RHIzaFJhZUtVajVNR1VHU3VC?=
 =?utf-8?B?UVIvSm9IN1BwRDZzVTJJbHU1bDBrMlE0U0h5YWRoWFkvL0NoREw4OEJWTklW?=
 =?utf-8?B?ZTlIdkIvWGlxVDhsVEVLOWlwZS9veUFOdUJZRUhZNWRxNjZmZXFRZjRDTEQr?=
 =?utf-8?B?QUdpc1N3NUxJQWhBTjM0d1BORVpvZTc3U0sxNjVvaDdOY1hteWZJYXBPTTB4?=
 =?utf-8?B?bVNnODB6YU8vN0hzVGlnQlRobEI5SUJIWnYzVGtNQVZmV0xvbjFjL1lDeE4r?=
 =?utf-8?B?UUllQnhQV09hUEZyRE53VlZYV1VNajhzUUJGSFA3ZktqZzFkalBmSVJqYUFi?=
 =?utf-8?B?OVZmWVNxQzJ4YU1zNEFUSVllTnlpZ3lMcDNiSUFyVmFFRXJtTjBOWlI5ekhX?=
 =?utf-8?B?RmJFVFVqWDY2WGt2RUJjYzVhdjRnOUFXZjVDZU5HeFozcUhBRGxxT2JabUZK?=
 =?utf-8?B?MTJIQXU2cmEwaVBXRG1yNHpBYlV4TEFSZDkyRlcvU0NpZG40YlFVa1VGQXYy?=
 =?utf-8?B?V3ZQdXphOS9YQ0RTNUprQ21yK3duRngydE50cXNibVVPTlhFYWR0YkVsTFRj?=
 =?utf-8?B?dmtJNTY3ZG9NNENsV05wWTZtV01zWUhTVGtYMENqYURJdkJ6eHVFWWE1a0lo?=
 =?utf-8?B?RzdxUXVYS25MVjVJUW93cWxTdlFZUkxESytNaDlyOHY3ZFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkRESHBLWlQvekt5L0dqc1o2SGpPbHM4R3NaNU1DS3pyRmVRaEpaOFFXaWg3?=
 =?utf-8?B?d1h3cW5yYlpoZ0xLS0hEaUJSRndFWWZQNU5STitZeU92c3UrNlhiVzVJM2Yz?=
 =?utf-8?B?Z1ZsaUxncWZYZXBvQWwvY1Vlb3BSYzlTWmtkdVk5a3kxZHhYTVhZVUd5N3JX?=
 =?utf-8?B?bHd5M3dWSDBoWjhFMm56RkVTQXc4cVNDa2R4SmNXODdHTkN6UzdoQmlrQ25p?=
 =?utf-8?B?R1hjNVU3Q04zR0lOVzQySGVPRUp5akpFNmo5UGRXZ3gzc3lpamRON0VrZlJZ?=
 =?utf-8?B?ckk1ZVo3c0pZUVp3SGgzRkNFajZBMGdYckdnWGJ6YUVIdWNiQ1VacEVRM01E?=
 =?utf-8?B?MmpLMmMrSFdLYURyQkJQODY1dWNhRE1nbzl4Z215L0ptY3BsSmY4OWJWa2Vj?=
 =?utf-8?B?NTlHZ1hPRndBUnVtTXMxaXNCLy8xQk9TN01oY25oL3l5RkVRZGQyR29VMmJJ?=
 =?utf-8?B?ZExQRzhRQlRIK2I1bkp3SDlTM2VLNktGQ3FMbkRpTjl2eERqekZCUUt1WEpB?=
 =?utf-8?B?SVdWU0VGeHhDM1RISSthNE1SSHE4bVpiZURUZjdxL1EyT1Z5aG5oVWlqMndV?=
 =?utf-8?B?ZHlXLzU3OXREcGZXYmc4TDFwMEVrMTY4MVBNQURBVk81Rzg3THN3MFRtUFRW?=
 =?utf-8?B?YWtDMi96czlJbWxMSDUrM3EyQ202UTZabm1hbXk5MCtNT2FwbkZYTUNkMkE3?=
 =?utf-8?B?YlJuTUxJTXFpWUxIK0FjWS8rR2VwTlFJTllVSUZ5Mm1LbkhRRm5DdUVyQXE5?=
 =?utf-8?B?L1U0aHpJNlRXVFZqeW5UNS9IUXdvakgxcytzZ21pUWFCZFRUS3lmYmxJQ2M4?=
 =?utf-8?B?cTdEemVIUjNrZUJxQUNEWFg1OWlLTFhNRjhOUWF5bkV5YXQwNUtINW1ML2k0?=
 =?utf-8?B?Z0tZRkw0MmNRclNwTWJFOXlSVFlDdFU3WWc1dDcxeUF5ajVsYTNMdlMwWThR?=
 =?utf-8?B?dGdVQ2NZWHl4T0pBTUROcDFtRkNyN2RxNldwK1IrK2JNeEJQQWs3R3QrLzQy?=
 =?utf-8?B?TzBjdE01TnpjTmhoMmoyOGMxbVZhaURDQ0U5b0x4TGtDek15VXdkZzAvcTZO?=
 =?utf-8?B?TVdyQkVDckRQek5qMjBldWQwWGwwMzRybFp5SnVNclhwbDdQK3NKZUJRajF2?=
 =?utf-8?B?KzdqMzNNUnp4cWhXRkRsQ3g3c3YrQlIybi96Y3dPTnVSSE45bWZJRityNU5G?=
 =?utf-8?B?U290cERYREd0SXFOSWVHczF0Q1NnQllabGF4MVBHa2JMWERMYnNEWEVsYUdR?=
 =?utf-8?B?YkdrUmR1Vzd5RWJSOFJJTDFMOUxtVm1BaXdYeWJCS3JwVG40RkFDSExWNkpr?=
 =?utf-8?B?ZGdQc2FiL09zWDFpbjlFTXRxNG9YakJpWkZ3bmRQRjZ2YUZMUkRTQzV5dUVT?=
 =?utf-8?B?dWE4QUhHQ1Y2MU9XbHRTQndocnk3MlZBeUtVaHFmaVZuYmRray92RzBmSkp0?=
 =?utf-8?B?Y0R0UlFybnhkU09QcVJvaTdEMHgzeFZJRlZvc2dnaU9BUFdpMXFBTlRQYnFP?=
 =?utf-8?B?Z3lwM2ZDVzZYS21DVmdsaFQ4eFpmVlhVQnM3Skh0NXNnQWxvWm9ERnc1V0R6?=
 =?utf-8?B?UmRyT2x6UnpQNE1GSnJydEZ2VWg4N3Z1bUhMRHI1L3JXeEhzQUUwS2ZvT2d1?=
 =?utf-8?B?TzZPTitycmQreXdrWlRUOVlOYnJQb2orWkdza1NHVUJxSkdIVGZQNVNUTXBy?=
 =?utf-8?B?VUhHRElPTHpxL29WazV2Ymd5RGhKeUZWaFB1dUIvaVF5T25pc1hHUHVVZlVJ?=
 =?utf-8?B?Mk9vKytpZmgxbEFoc2g2NENPY25LKzhkWjAxVkhpZDgxbFFYdGs2MjA1VHd4?=
 =?utf-8?B?SHpETENDZ3lqaEVXZEdRTXBRb3VxdXdPQmJmNE1WVHRqUzB6aDRRd3NwSjMz?=
 =?utf-8?B?K0JHTnIrb2w3Y0lpRzBHTGZ6Ukk4NjJXeTFPQUE3TElVZCt4dWlNWWlsVkc2?=
 =?utf-8?B?N3hHOTZtNEJMZFphY2xPbzVUNythclRBWTBhNnl5aytxTWtRTlE1SU9lSVA3?=
 =?utf-8?B?OWdqaVh6MkllVEw4VUFZMDA0YWhwcGR4Tm9uOHFkUXlNQ2FmR2F2M0pqc1pw?=
 =?utf-8?B?bEFpcXZtdXpxTnVYRjdORERhUUJzYmh5N3pFVjdOSEhmbnRGTVdMWXlQZG1L?=
 =?utf-8?Q?VLpFpgdpOdUYVHsLOUoaP5TMs?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc58927-55db-44e1-3d2b-08dda3f0cf5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 05:21:22.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWWr0AROGgjfhtyIoUtogVIy72/TrwuXT1cvY6QPk7Nc8KgJAYTBHLvBl6ZG/YQEwdcgPKVupt4H35DQKlc8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756

On 03.06.25 16:21, Pierre FICHEUX wrote:
> Hi,
> 
> Is there any example of  "round trip"  test available for RTnet ?

There are lookback tests in smokey (net_*).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
