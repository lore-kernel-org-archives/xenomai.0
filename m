Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729011C83
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655287; cv=fail; b=e7gonxeTKlMMIN9ApB0SVW4S2m4Ivm0mM5L59J18s96iW60E0evDjON/jmWGCrcLq+QMMBYm7DyDPGlr4r0SpdsyP0hTdiESweRC7fa4ItIuINiJPOiY/T1Pn/2INyZC7lZMbW77yKB4RjGR7AidVsOpabC42yAVGlJbsUxm9v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655287; c=relaxed/simple;
	bh=t5y2UZaxDtFc7oJhS5ixIpiRBHoHurp4TVLmGiIPNiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JbXvQfrar2CWliaFN0ovHVAxaeSGA59z+00QP1nj5Jf/fvJs2aguw2ZFE046LmWJpCXQz07SOANeT7aWmkesmxDu2RbjGhqHZiGzKoNhQyabGjxl7kTXq03zZ1SpyVg0jxXqsSkeHebCk6Pr2/bwXtCbZ+JzVkA6yHnQzWM31yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QPxW5jU9; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QPxW5jU9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYbxK86qSCG8chuCqQAs9wqDP/jfzfjQv4F+SDdCxWVgF2YHz8JBPfjeVOC4ZEwzAy8zKjzBT2VDn1pQb+GRXhGx29ZpXsGUCw6veuIoNCHXHqsayp7MsiCdfRKnZfemD2n/Tlxfe2Vi5Rv5+gejxdjg6uqAKXx2HfCL9l4DAdTQVayZsmRBOniGPnvjOEMERc1k5U8s0lf31G7Rkl8FP+5Jd2F1Em0bpBj+Jy3OvWRPTy5+SWysFyn1IdzYuCNqswi7phPhB3ZH3Y37KyVyE221TQbT0kHnfk1wvNuUqrHPWvahrn75NhxYNiD0aCMyDWhjn8cfkpm2SYYXLfapZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4933nf8MA0tNtycaqqR85/TRqWrUfVmeY4/hubO9SY=;
 b=Ln0NKOjgVmRlm/DH6tY+w5agXrR4nq384IGkBN8ZsuptDgE5liSLOPm1Sywxbq1kp4yrYRdF8TjIbPC4gHOpgoz9FRMVfLiU25thl3bLiSrwzJAZQWsTJezEGdplSX0kdfCN5ia3aw5hKUZZCGkn3H9KYiaNTrUi0Cs9SW7JBUYjc0wIQrisG5PUdEi9slY5z/Mgmg7s1A/0dgk2OW39TaCRukiQ4vyMjLqKMD09cof0Qy6/FSu/imyFgKWVGg01I2GMo6sFwTTSTPwDACaZtrlvOAnNX0ehJUEsk6YIhpSkIvUVp8lDWhEgc2m68eQf2AONP07f4QhKxUKX722rHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4933nf8MA0tNtycaqqR85/TRqWrUfVmeY4/hubO9SY=;
 b=QPxW5jU9DIXlXGcXt49o8i4C4mzPEyo6jxmvg9HMaBPURj0RwTbPKu+JXaEZE1SQ2glnBxvfm/t+7sz2+K3m8Q4g6PCEu3V9dzwZKhxm6sGeBSx8NkAvO92FQodbOyX16SZjp4B5TMNFhQ1TEppIhtT9jn4DJHLRK8vkHK0vyGI0/OSoj4ZcoFwm1bvA0zvYrTnWKU5WTtk645CUCOv/ouhdx1Vyuz9+Tb+oxCB6r6xgX8xXO0ZqdueVjEl54TyHYUwRpjK4A2xhKoYDVcLNxVmDKY+j7vFHaKrUw+vBuSPq2j8OCIEdHlbi8Ngztu8m+ZKQBtlgOVREI6Cb1dae2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:01:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 14:01:18 +0000
Message-ID: <320a834c-568f-4c9f-b7e6-1900cc96e8ff@siemens.com>
Date: Fri, 11 Oct 2024 16:01:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
 <87frp4aqmu.fsf@xenomai.org>
 <20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20e035c9f61263d0085d6dae2d93829ee575b87e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: ae62982e-395b-44a6-98ea-08dce9fd2dfe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cURlbElVRmdyOE1QWHBFaFFzbTVCWHZ5WnYveU5yTXJoOWFxcnlrb0tOUmN3?=
 =?utf-8?B?RlcwOFZHTVVPeFZhY1VwVElmUVBxN3BsUXFWTUpadzNzcFZyUCt1RlVGU09s?=
 =?utf-8?B?Q2RUNks4bG45d3I2ZU85VWljeWFYbmVpNXJEMzFxckI2Ylc5OTdRajVtZDhk?=
 =?utf-8?B?SGQ5RmJZK2c3Q2VQbE5tS1pNOXNtQTVGcUtxYzloL2NlaGh0R1FhN0ZpeDdo?=
 =?utf-8?B?NUxuc2FNVmZPdFhHcHhyVDI4M3N4QllPL0kxcFhXc1l4eUhtVDIwNTB2cjRF?=
 =?utf-8?B?NldoNkZVMTV1SHFDNEIvb1FWbnFNOUQyOTJBQ3dNdFJTb3NyNW9kMzJYRG5T?=
 =?utf-8?B?clptbXBxZ2lxcnRPNGl3SHVvWnhGL29sanZZVHZWVXJkZkNYNldVTUQ3S3g4?=
 =?utf-8?B?VnJVeW0xNlRsUnIrRU9zN1dhRDNiN2FnSTFzZStTNjhLSHJmSS94SHFuMm9E?=
 =?utf-8?B?QXJPTTBLaVdpdEVGbXpvT1hUWklNQTJoTUdiemljTnRqMFpWaEpaRVlpS1Jm?=
 =?utf-8?B?dG1BV3QxMlJPV0hCRzNWNFRDbGpISkdqNHJydmJpejgvUHBpWjBiTm9vQ1hn?=
 =?utf-8?B?Rm40NjJCaklyNXh6TExmOHBvSEppTEFBazhMbXFGLzR1aDFrczlvcE02T1dm?=
 =?utf-8?B?R1paVXFPM1kwaTBvRzdXV1ZiMU9ObFZCREludUFGTHFXMFBQR2IzVm1FN2Nn?=
 =?utf-8?B?dlpmNi9ZaER1bXJta0hHSXZUUnprRGR4ZldDVjdYVFlDbGJNTE12djlSUy9X?=
 =?utf-8?B?eHIyRGpQVXdSdkUvOXJLK0lNMU1ha2VvTktEZTloTmV4UGF6ZklTTy84UFg0?=
 =?utf-8?B?K0w5UGFWcjNEUU4yZjhtU3dxYytWZmxPbHZYaFNZLzdVVnREODRKa0lrTit2?=
 =?utf-8?B?Y0hUZklEeGpVQjV3YXU5ZkJ1SXcxWCtnK1c2VEFMdFBVUW4ybGNzMWJnMVEy?=
 =?utf-8?B?OUZvWkRocWpWWXBOYVkrQXFySXZHY0I4MTdDNUkwb1FPVnhqa1RVdHorNDR5?=
 =?utf-8?B?QmVHRU8ycWt1MDlGcUg4elZqYzdkKzBhd1E2TlVIcDB0cnpBNGdvejJTazcx?=
 =?utf-8?B?UDNPTU84OFRRVzJPdXRzRW5GRW1UWlZ4REVEaTJlZVloaEkzb1R0OThqOTFy?=
 =?utf-8?B?Rk1iK3R3QWt2bUJiYUJBcTROQVh4bUJWSEo3Y0NKRDRRVUJRL1VDQWpGV2Yv?=
 =?utf-8?B?dzJxZ0ZFU1BrUFlrTnI3NkU4MFFNWnlOWm8zc011Q0hQU1Y0eHQydENWT3lu?=
 =?utf-8?B?SWhiTWxiejRLM0h6R1Evc1djMDgrT0tHd0pUZGdUb0U1Sk14cXZma0tGWmIr?=
 =?utf-8?B?VnlRbXowZG1mSHk4VWJCQzNDWUxOYXRrL1JsNTU5MEpoT2tnbGVZaGNCK2hC?=
 =?utf-8?B?WDZFUGY2V1JmMFhRN05YOGNZaGROZTNONno2NStSZWxubzkwNzUxV0Q2Sndh?=
 =?utf-8?B?K0tmVDhoa0JVckhQR0srWUZLTFJ2QnRiblJrVjhwZU50SHdCZEV0U2NBZTBM?=
 =?utf-8?B?WXdkYTNJaHV2ZmdNakpsR3hxLzRQWXNIL3M3eURxamVZLzVtRkYxdVJrb0dq?=
 =?utf-8?B?NFVoamErdTBWN2pkMXVUTkZVcG1LbzlGd2xtLzZvdnN3aEpYaUJhb0VjU3Mw?=
 =?utf-8?B?S2Nzb2hNU1dpS2dwYkxSTXVtYjlGZlBRU2Y1dnBFVDdrbHRuNHdjWDNOSWUv?=
 =?utf-8?B?ejBxTjlka01lV0JhR1E5UWQrSGVkbzBFbmJBaXdtQWQ0WjVjOHR1Tm93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU1zUWtuTm5YS2ZsZmg5QTF5NVkzcXVUU2dzTzFCd0hJMk1qSWxOdC93ZExw?=
 =?utf-8?B?dUtxRkVEVitxWVRBbmZMZXczWUZrcnB0YWxBTTBjWjI5MnZJSUdROThvMXpY?=
 =?utf-8?B?NXhHcmk0NllaNjR4UjQ0WllkTXBqSGg5dEgzczZpMGpVMCtmVWhVdUx3Nk5Y?=
 =?utf-8?B?TEFpbjBhRUNMdUVWLzVCVXFHNytQMWdUa1JNc2ZCWncrY0JVUW93S2EzN3VN?=
 =?utf-8?B?eVFCbjdrSCtSc2ROYVZ1MDJsRDkzSjNuTzBQZXJJNVlRbklDSTRFaEc4K0oy?=
 =?utf-8?B?Q3J0T2xiakVBUjBMWFBTR1BVT29yb3ZlQWNSUzZNaEdxTGJ0aXpVMnZKK0JY?=
 =?utf-8?B?TTU4ZHRKemRPc1A4M2VsRnZZTUR4aG5LTlFhS1FoVzdZbFNpdStEandFQitQ?=
 =?utf-8?B?TUVYWHREL2RKVkFLQkh0VVB5ZDIyMWtNdHBWcjAyYk12WlVQYm04MnY3R0Rn?=
 =?utf-8?B?MUJDNmw0NFZWemx0d1VoSndtaTFLa2p5ejN6NkxUN1d5bjhUMkhwL3VieERx?=
 =?utf-8?B?cVRrQzhWeU1NSXZIamRKN0dCUmJjRHprNkRkWVg5ZkQzQjFENTZPOEZPSmRm?=
 =?utf-8?B?VVlaeDZJclQ3WEpnVTQxYkx0OFF6RkI1S2VqL2VSTVYwWGRydmhTLzRhK1dn?=
 =?utf-8?B?K0YxMG16TWQ5VDdnQzJ0YXZ1Q2hWZGh5Q1hIRkVYc25CQ05hR2VRT1o0anBJ?=
 =?utf-8?B?ekhqdkxGaS8zMVcwRjBwcHRSR1hISTFseU5FM2tVckdiUks5Wng4ejFCRlA4?=
 =?utf-8?B?M1V1VFpQRHFtYnkyMHBuclZJSFVvTHAwQjd4OHZNMmpVRUtIZWx0YnErSm54?=
 =?utf-8?B?V1c0NVpkWGdidHhXQkhBbWtQdk04Y0E0dXVRa0JPRE4wRUg5Q3dMNElML0I0?=
 =?utf-8?B?dWVIbDIwNVp2Vkl3RGh5WCtLbWJaUEdqNEhBNUdUeFJZU05HeHJvRXhhRlIr?=
 =?utf-8?B?ZW4rT0NLTm90WlV4RVBLb3lvOXpFd1B0RmgwTGZEOHVPNTFkYkFnT0sxRUM2?=
 =?utf-8?B?SWVDM2xhKzh4KzN2K25rT0RLT3dEaXRNeml6emdQYTdWZ2p1OFVmWm9PSStH?=
 =?utf-8?B?VEpqN0JwZnRKdnFqNXU4M3FGL1lTTkE4YTJTOVVkYVh5WUJjZjdIb3crRC9Z?=
 =?utf-8?B?OXpHcDlMRTIyaENWdVFObVE2U2dBK1FUYnhCRTJ0ZndQME4xL1JCVmpQRERu?=
 =?utf-8?B?aFY3d2JoeTRlc3lJMlE0SWh4eVJoYXpsN1JKU1dmaEkyNFl3c3FiVS9UMmhX?=
 =?utf-8?B?YnhwMU8xTGtCWU5PUTV5bXlBaDAyeTFhT0FUZGQ0SkJUemRjc1NiaGlKZjlO?=
 =?utf-8?B?SVREMWNVZWZwa1RqWW5QZHNCSGlkbW4zRU9aUjBxUzFJNVBLYU5MZlJ5STRU?=
 =?utf-8?B?Rml1WTlXS3pMaHZBTW1MS2R4K3JCTlErT3I0TE1yMjdhNDg0c251NDVHSGRE?=
 =?utf-8?B?ZnlOSzBkZWJFc2dzZlNEbk5WZXA0QTI4ajFjTXBEb09iMmlyQVFmczJndDRv?=
 =?utf-8?B?bkxIOU81ZThBdUtEcEFWQVZ4UFRCMXQ2QWR5ZmZ1NlVZR0NlZW5KNjlmdWdo?=
 =?utf-8?B?cWlNRkp1TzVJbXNWR3ZPS0oyTllDQ1VJNER6QnR5U3dmZUVDNG1tMVJwSWdo?=
 =?utf-8?B?aVlsYUwwZEhlb2VKcGdZQjYzTjBLYnhibUpqdlRwTWJwV1ZUeGE2akU5bXhZ?=
 =?utf-8?B?Y3VPbGNCeUdZK0pzcmRoUzhzaEtmdUhtK2JvZlVqWXpmaEZnaHU1UlJpR1Ez?=
 =?utf-8?B?Y3JISXY2ZVVOSkdxUEpGb2xaUzFqMnB6Y1V1NTJmaFJnZ3dsMU04RkRuTXlF?=
 =?utf-8?B?YlNUZm1QcW5PcTBMSFFXZUVyLzFvak16aXh1aDhSbEVzMmxsajIvVG9ZaWZa?=
 =?utf-8?B?WkdMbUdJdm1ocXpSZnFCTUl2bGFQZWhONUJPNnE4cE1KMEw0YWZQSzl0ejU4?=
 =?utf-8?B?WVRYQ0ZLQkJ6SGUzcDJDRXBrMnVXRFh4L3Q5MW1tbkZlaWlDZjV3MFpIYVBy?=
 =?utf-8?B?ckhCVGpkM2QwWnp1SjlBM3p5YWVObkpMdm83ZUlFcXZpdW1vQ3V3Z2FYUUt5?=
 =?utf-8?B?NU1oN2RIOStsQmVmbllBR3ZMcjM3Y2xVTDNlWWQrM0hoL1hrR3hkZVp0VlJx?=
 =?utf-8?Q?sFGgzaJnGX0eVw+6iEjAYCPcl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae62982e-395b-44a6-98ea-08dce9fd2dfe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:01:18.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ugrZidz8QX2x9dcq7KtAcVxSjmVBCfQpE/ECW/XakHJquuKFaTM1TJpRig1ZRL50wRniwkco77yL0SWhUKoCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5560

On 11.10.24 15:56, Florian Bezdeka wrote:
> On Thu, 2024-10-10 at 18:07 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>>> The following kernel splat was found when running the Xenomai 3
>>> testsuite in compat on dovetail enabled kernels:
>>>
>>> [  513.620975] IRQ pipeline: some code running in oob context 'Xenomai'
>>>                              called an in-band only routine
>>> [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #76
>>> [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>> [  513.621005] IRQ stage: Xenomai
>>> [  513.621007] Call Trace:
>>> [  513.621011]  <TASK>
>>> [  513.621015]  dump_stack_lvl+0x6f/0xd0
>>> [  513.621202]  __inband_irq_enable+0xb/0x60
>>> [  513.621249]  do_int80_emulation+0x68/0x160
>>> [  513.621265]  asm_int80_emulation+0x1a/0x20
>>> [  513.621285] RIP: 0023:0xf7f692ba
>>> [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
>>> [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_RAX: 0000000000000127
>>> [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000ffeedfa0
>>> [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 00000000f7f7aff4
>>> [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0000000000000000
>>> [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>> [  513.621319]  </TASK>
>>>
>>> When entering the low level entry code from the out-of-band stage
>>> the in-band IRQ state was changed. That is now avoided by calling
>>> syscall_enter_from_user_enable_irqs() as all other entry points do.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  arch/x86/entry/common.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>>> index 467e2511df2e..13589f1ca89b 100644
>>> --- a/arch/x86/entry/common.c
>>> +++ b/arch/x86/entry/common.c
>>> @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
>>>  
>>>  	nr = syscall_32_enter(regs);
>>>  
>>> -	local_irq_enable_full();
>>> +	syscall_enter_from_user_enable_irqs();
>>>  	nr = syscall_enter_from_user_mode_work(regs, nr);
>>>  
>>>  	if (dovetailing()) {
>>
>> Ack. Merged into 6.1.y, 6.6.y and 6.11, dovetail and evl trees.
> 
> Philippe, I have to apologize. The patch is correct for 6.11, but not
> for the older ones. syscall_enter_from_user_enable_irqs() does not
> exist in those branches.

Sure?

$ git grep syscall_enter_from_user_enable_irqs origin/v6.6.y-dovetail-rebase
origin/v6.6.y-dovetail-rebase:arch/x86/entry/common.c:  syscall_enter_from_user_enable_irqs();
origin/v6.6.y-dovetail-rebase:kernel/entry/common.c:syscall_enter_from_user_enable_irqs(void)
origin/v6.6.y-dovetail-rebase:kernel/entry/common.c:    syscall_enter_from_user_enable_irqs();
origin/v6.6.y-dovetail-rebase:kernel/entry/common.c:    syscall_enter_from_user_enable_irqs();

$ git grep syscall_enter_from_user_enable_irqs origin/v6.1.y-dovetail-rebase |cat
origin/v6.1.y-dovetail-rebase:arch/x86/entry/common.c:  syscall_enter_from_user_enable_irqs();
origin/v6.1.y-dovetail-rebase:kernel/entry/common.c:syscall_enter_from_user_enable_irqs(void)
origin/v6.1.y-dovetail-rebase:kernel/entry/common.c:    syscall_enter_from_user_enable_irqs();
origin/v6.1.y-dovetail-rebase:kernel/entry/common.c:    syscall_enter_from_user_enable_irqs();

Jan

> 
> I have to check why the build error was not properly detected on my
> end. Can't tell yet...
> 
> I will work on backports, meanwhile you should drop it from 6.6 and
> 6.1. Thanks, and sorry.
> 
> Best regards,
> Florian

-- 
Siemens AG, Technology
Linux Expert Center
