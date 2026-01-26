Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3EF343D8F
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445753; cv=fail; b=o9KTxBmrfrIY0NsAiAJtOBzsC4pI9Qzd9HJQa1vXTZ/cqOOFPz69CJpUxIgtsvUU6NAS3Nisv2mDGGQcMprcqH9M5ZGeGfbt/3gZC7xhWbyNHBSJsSHWgZwNBu65r3qwugz/yPU4A2tghKnGIIRrO/Wl2hd//ElbyomGYbDZsoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445753; c=relaxed/simple;
	bh=ZgLwvzlQkbOX218fRUr91D8hUyrlc/lb7bFGbJIXbn8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QHwWBEr8v88u9q7JKBMKYuKxiW6gr1M4o2JhDW0KuRPJbcIH1H/jVAOVqF8qRx24RWQOrSa4JizPCJtPyRp8ybowRFR+tZtnqPu20vcb2a3qFrndD1hiHdfBf3B9WmBF1U9PJ9G5NZFKQMUK38vn2t9jt2y6bQNt/l7NlJFSf7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dnjHR7/I; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dnjHR7/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE+rCm2SiTkleLDmpOoVWROWW62cd5XWsLk+ph5Gq9DAi1WUU5vKq6M3cRaoQggSGVmqIy1O3/u8HsIF9wl1Y29wLSA/MntXWONsvqYELOuUtrDyFl1+96dhCHMwyi8XGodYiReLc1XO8wOXAHPNj1B9+EaTFOBnCU+5LpBRrVWsIybeOPZSP6/p0y8xu3mF0Q4w7gXVc7Mzizapj63oCiIIhkwWKueV3EbeTikz4Rtzb25BW5ZJ+q4xOD0C1nGn5pvQZL1RdeF8kVB4mawwIkZzZZdm7DhiFJbsp7yLE5X0KZU9bkrODt1cyRidW4/DPUFlnGTh18PWTz5NFbbRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLwCgIkVV3ltSh+bGhSK2pzCXQ0YGsVu57b09tv+z1E=;
 b=KLwBKzy1MIR+xCDeRad2L57BTevwtgd7mP6OlG6XBd1E5S5ZPA6R3ok3DrrbmWrv0AuyJALQvYrDsl9BhjU19EO0QxJbg7anPWukUAIyQrCF2gip35yuZLhMV2n32uUA0xHb7nqMBspz+j/c/pv/6UoyVO1M+0t8ggF4DGzQfl/iORo049lBZnnclCKSfLAdZmPZwLXeSA7NZ6FFTa18x98Ohbo69S0M0+bXkg8VUppaknOJWaMFHNqh6dFkPH4qFkiOk1zwEtDq5d4+iGj1uBYA+X8lbROTZld9PDvLI+lcdgf7m33m4ujbCuJ7lZtBpVgNGS5KMX800Jz5uf1N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLwCgIkVV3ltSh+bGhSK2pzCXQ0YGsVu57b09tv+z1E=;
 b=dnjHR7/IkXGCBMsk+CejOwMJ5UAKAL4MM7Y7r7W71bwQMBsWEhpXP36z8z0Yve9JDrIrrA34X4XjQetdoc9JmkkI39H1VIHlKSNi+dTqqYL8tGI5beznIXxGuljZ3eT1/YEORb30/HMclrrjNk/ulzQFZmrVptCLOCuUX9MpZ0iPyVnvcFLVNea+l+oR5JjMf7uiCSkxnWe0RiejvpeeZEIUg22DDDF/zBmvWbMQpRqH+j5tCC+Z4p/AEIpWEzV/HMVvSW3IidRSUqMY2Bn+k0DBu2vdvs92jshpnoZ0YzPbd1HNS7ItODkjJoWjPPeaPvzV50jRZZ8EGvCN4Vj9CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 16:42:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:42:28 +0000
Message-ID: <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com>
Date: Mon, 26 Jan 2026 17:42:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CPU Hotplug Splat
To: Richard Weinberger <richard@nod.at>, xenomai <xenomai@lists.linux.dev>
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0015.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3344:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dbb05e-3a59-4feb-c3f9-08de5cf9e496
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUR6UkhCbWwydkJLM2wvYkVxQjVwVW1HTzR3blh2NlRCcHNaVEk1TnRjeFJJ?=
 =?utf-8?B?K3pJdkVmejRBUDdmeVNicjhOMTBBVjlCWnFLR2FMS3FVOHN3NmhoY1BZRUZn?=
 =?utf-8?B?YkQ0VGVHN3NleWpRN1o1M0g2UzREc2pncEtiOHZOQ1VwSlBsN1RBcmJxVm1N?=
 =?utf-8?B?UjRRNXlDUFVQZE9qSWppdi9rL2c0NEhnRlI1YTMvMFo5ek9LalFkZ0lnOGFi?=
 =?utf-8?B?UXZZNUdsa2lwOWZJdjlqQTdTcWdWNGVwV3h1VW9IaFJXRUJVekZlQ1cyTTN6?=
 =?utf-8?B?VExua2ozSHR4bkYvNnFtTFNuc05WZkZWUVY1VTJQd1o0NUNRWWc1bjNsZUtk?=
 =?utf-8?B?MVl2aXJabG9VRi9KVVhzUEZJaEY5S2x0RE5wdTNFSmlzTWR6SXZPUDRTY1Vl?=
 =?utf-8?B?QVNnYmdvb2ZLR3AvektycEszeCtwYW8zYjkyS0Z0QTQwYXhLTGhaNVYzWCt2?=
 =?utf-8?B?SlZvVTFWbGVodERaNENkTEs1K2FPbHI4dyt1MDQ0cWI0ekljbFpudXl5ZWZv?=
 =?utf-8?B?ZEVlRVdBT0Z4clJYTmZURkRrSWdWVlBQdnR2Zng1b2s0MDBhM3YvVFpxeDhn?=
 =?utf-8?B?ZVU1ZU9PVUhmOGQwRC9Pb3U0RmVYM0QwdzB3UExFUUI4QnI1UDl4am9kMW9j?=
 =?utf-8?B?cHZ2aU42bHhIcU04QUY3b1NSbjVBZHVqckl5V0VmbTJlUk83ZHF5clJzTFNy?=
 =?utf-8?B?UnlpMmVDOFh2UVN1dTZTQnZ3Rnp4MDNsL3NtT2ZyTzV4UTFHK1hXUi81Q0hU?=
 =?utf-8?B?N3M0UTdYMDh5SUFIY2ozbTZTV3M2bHhmTHA0MEs2emhlSTFNY0p0QXpGYVln?=
 =?utf-8?B?ZUsraHZhMDQ4T3pDWWdwQjF5VE9OSjlEc1M2ek51YWNkNFdpR3kwYjFrV3Ar?=
 =?utf-8?B?dmtsUkRRblJMNHVQOS9uZS8vdklZNm9GL2VjelJFWGdwSmcrc2c5aGZETzJl?=
 =?utf-8?B?YUZVWTlrNnVtcW92VzMyNVpzZjBpRnRjVG10a2RYYTBrYTZlak8vOWRWc3dL?=
 =?utf-8?B?RmQwT084dFE5cFo3RjV4K2grV1RxUThQUHFHQVZ1dS90Z0NqOWNaeFNPc2hM?=
 =?utf-8?B?RFhkK2diYWI3LzlQckEyL09nT1gzLzZ6SjM1ZGJFNGlDZzJyMktjdzdQQnA3?=
 =?utf-8?B?YWRyT2FpWWZwcHp4cmg5cUN2bi9QTmw1ZVRpNk1sdXRRcnh2R1NOYWRQTllS?=
 =?utf-8?B?Ry9ud0hSNzdENVFPUG1raGhZUVA0ZUx5S2tYYzZ4VkpodXU2M2VQQld3U0Fr?=
 =?utf-8?B?NWE5RHJoRVI5WVRadzBQTm9jSHR5Rit1R0YwaVJOeDEycXJyK1NSVExUa3JQ?=
 =?utf-8?B?eTVmaDhvekxNRGhGZjEwQVZuN2hGa3RETU43NVNLeDh2SDIwZ2ZCN0o0amFj?=
 =?utf-8?B?YWJDNmdSTHB1SHdBbVJFV2wxMnRUYXY1ZXJtK3B0a2dZNWM3cS9wOWJVSWl1?=
 =?utf-8?B?b2hVNk5KNUdDVGRJWHVrUzhSajVtdmxpdTZzTmU2blFZNUZxZWh1Qk1pejg4?=
 =?utf-8?B?Qmd3K3FENit2cjFKd013V3RrT2JaaE9aQ3dydE5vRmt4SzhrdnhFQTZ0Y09Q?=
 =?utf-8?B?cmlDZ2VWVmkyYlJ2MUVnSTFST0dORk9UbGxTdUFQV1plazNHYVNnK2ZlenF1?=
 =?utf-8?B?TEMxd0M4Yy91N2NSeGU3YjdnUDVhdnVzU05MYjU1ZmQrMnhTU3MvSml2ZnJD?=
 =?utf-8?B?RjZCRDNGenFCYTZpZnFxVjVrK1ZUZjhYejJuOFlJd2VORngxMS80WElqTFB5?=
 =?utf-8?B?aTMySE83SzRoN1p3cEtRZUpVaVZ0a1hoMGFDQU5RMVlDcnQ4Zlcvc05ZVS92?=
 =?utf-8?B?SVRFMEptdlMrZGZuN01ZZWU3OXVSSkFlWjBGY2sxM21CZzFpVVhXQnlkSXhO?=
 =?utf-8?B?VzhIalp1ZlN1K0wzZ2xueE1ZTTc0U3BzSXhSRUl4OG93SGZYTzVGV2IwTnVw?=
 =?utf-8?B?V0U2NElBMjB3cCtLVVRLM2pzNndHOHlUeERQd2VheFMwcyt2WTl1dW5qK2N4?=
 =?utf-8?B?bzZaSDZ3VzR4ZDhZS01Cc2NMZWw0QUt4QnJBdDVraUkvK21WbktiT0Nhakoy?=
 =?utf-8?B?RVl6NlBQRWdlWDF3Vlk0Z1lhbzNoa3d1RExITlhrVG5mdUxwdTFFT1BnYlZ2?=
 =?utf-8?Q?PCqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djMzUHZhVldvdEFZWXNJSWRTdkpCRk8ycWk5U1V6V1FIbzhzVjV2UXFkSVJ3?=
 =?utf-8?B?WmxYK1dldnBoS01TUjZnaWk4WXFPTjdDWlMyYVpGZkdOamxKM1hWc0k0T2Fs?=
 =?utf-8?B?UExYQmUrMldiR3hnRFFtR2ZlcW5IdkJhd3FzVzc3WjZZRzVlTEpINFpoKzYz?=
 =?utf-8?B?TEJneXBXdzZLbmhQVDZHVVJTemtCZFJtcjlIUStlN2tKV1h6am96aUlWRGdQ?=
 =?utf-8?B?a0VVQS9wNmxnNjJhM1RRSUVLZUViMjRBb1Z6eE9UV1grQ3Y3UmFac3NwVjBy?=
 =?utf-8?B?VVd2SWd0WTlIVWZ5VDJpQzY0dDFwSXBxRnUxSU5wazlEQlRZZjVpSE03UWhl?=
 =?utf-8?B?eTJTY283RGhGeFVXWGdtdk9lbUhwN0lOQ1orUDl2MEwvNWVabkNSVStDbWxl?=
 =?utf-8?B?NWFtWUNOU2pXczE0UmJQRCtZaVlONUdNR1ZpdWFIWis5Ylc0c1pXTFZ6a3lr?=
 =?utf-8?B?UHAyQXUwTmVBektKTFQ0RzdRdTRxb1RRaUlJZ09IaW5SSkRRcFl5Wmg1Snlt?=
 =?utf-8?B?R3lmbzRsd21tdWlSSVhyRHdxZmNiWExlYVRucjFjUHFkeXoxalpZa2dVRCt0?=
 =?utf-8?B?b04rdFVxSTFHTlBUanQ3Njh2SGlkRkVhRUk1RFNHQnB4b0dNSytPM2ZVRjB6?=
 =?utf-8?B?RkpvTmxKUktGV2hpS3VLMnNTUUljaitNbTlDb0QxNUNqNjhaSlRYUW1BKy9o?=
 =?utf-8?B?WXk5UGExVGVvSXlDcnIwcnlkV0RqVnFHcXEyTmF5VmxJSThSTFFCc0wvaEtK?=
 =?utf-8?B?RVcwWXArVWFNZnNNeTJFMkg4cVd1Y3RJd2hhc20wQW1NRFVmOVJrWHRzNTRZ?=
 =?utf-8?B?dm85eDFQRjRDc0M4azJXZ250SFpmZklHL25CeTlBUFlHempOQjVkSFJCTTBE?=
 =?utf-8?B?b0M4SkpwNTFkckFxWklhK1pLR1hBMXJrTndnMXFSN2pGOU0zTzBWOTg2MHZ5?=
 =?utf-8?B?dW11dE1rcUJNaUg5REhZd3N6MDl4eVowQlZ6K1M0SDYyYjVqOCtoWldLcnB3?=
 =?utf-8?B?YXNKb2dabHBkMG10YlZaQ2d1b1dueUUzKzlMRS9mZHliMmgwN2JDNEJvdE5C?=
 =?utf-8?B?elZ6TXNPMisrdUtmU3hxWHhVbmVJR09pTUJUZm5BQy9zZSs1RkZwbWhsUzJJ?=
 =?utf-8?B?RDZjdVg3dkdMenZUOVJRQ2FtOFJkWG5MV09ha1g5QXNjZmNLTGp2bzVQNDU1?=
 =?utf-8?B?K1VCWDVNSXZXTWprc2FxWlUyQ1pxQWx0Z3hPZnZtTmdPQlRaTTZvWnZmc2d6?=
 =?utf-8?B?SGQ5VEZTQlRrZ1BxcGZHaUJPMHVlS0h6WnN5UDFCaTdvOEZ4bjVsclNHRkQw?=
 =?utf-8?B?Vk02MUtKeEhydkRuczZlUXd3Q293RHllajBHN1JrTWlocVUwR2tNR0N1aUdH?=
 =?utf-8?B?YThtTkUvSU1RNk5ST1NCaEpab09NSWRkVjRvVHFZQVNrS1p2UExFb0l5Ny9C?=
 =?utf-8?B?RzdIUVBySytRUS9WUnVWemlSMDZZWnRya1JRdGpaQzNtR1QvVElJcDVuMXVt?=
 =?utf-8?B?K0kwUjQzY3ArQ2kzYnZCYmlEQkJaUXN6T3gvcE1WaE5lSEJDNUVSckNMVGZC?=
 =?utf-8?B?bERob0pLYWZjZnJobUF3WUt0c2hCQ29uMExFVllVWGprZDFnS0FjcHVzMWxM?=
 =?utf-8?B?TjBsTllZNWZHNjlIbjUzUGtzQUZ4d3BieVlndkRyblRiWmNVbm9vaXllQmhu?=
 =?utf-8?B?dE5qSEVLeks2dWxCVzREV3Bra0o5NmZJMGl1STB2dXNoalo3bzFXNFludFJh?=
 =?utf-8?B?aXROM2pQSXZGbm5UZXphYVErNnYwcWluWEkvOERwV2Z4em5ncHo1MlQ2NVBv?=
 =?utf-8?B?UW5EVnYzejhMRmtLZlNJZWNBNytRb2lJSE9LSmtIbU85TTNGUDdqSzF6SEV4?=
 =?utf-8?B?a3A0NmNwTlNJQ2JmdTgvVDViTkxleFhXUlBGTGhkaEtsSlphSXVBZWgxTDZa?=
 =?utf-8?B?eHNUVUlkTWNCcDB5Sk1UbDEyRGowbFRPaERsM2JpTzFjY1N2b3l0bVhxRzl5?=
 =?utf-8?B?QTNjL2RkY2o4Z080VXdSYURNUTM3NUQvRTRBWmM2dlVZMzJDbzF3U0U2RlFj?=
 =?utf-8?B?S1NZMWlVbGlBdXJPYlUzVVpMc0dlL3ZKVmhENThrR2hDTlZ4c1hzNTdQbG9F?=
 =?utf-8?B?b1RlNW1HaGpEbTliK2grVGJqYThUN0xFM1NxWmQ4MU1Tb29SM0pucUtpRGlI?=
 =?utf-8?B?L0tXWGVERVJLcHNMU1BZcVltWi8zTkdRKzZJVUY1UUhaWE5VUlFCN1gxOGpo?=
 =?utf-8?B?OEd3WlJ2bGdOazJPZkR3cHRpZExHci9KUzkwZEJNclR2TnJWYVBnQmRBWFVK?=
 =?utf-8?B?UlBaa2gwQ08zd1U3UTRkaDBQTW1XME9ncExiVWVpTDF6YUhnMW5sdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dbb05e-3a59-4feb-c3f9-08de5cf9e496
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:42:28.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPgD1UFoaRhopJza0bIsCyJ/ZG3nLgQ4DxBTlyL92kAPjRe1HFYmBpF/ktVXRjelwfNAZCYxYlpuAFCrilg11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3344

On 26.01.26 17:28, Richard Weinberger wrote:
> Hi!
> 
> While toying around with CPU affinities I noticed that offlining a CPU
> triggers reliable a crash. Is this known?
> 
> [   32.812858] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   32.812879] #PF: supervisor read access in kernel mode
> [   32.812881] #PF: error_code(0x0000) - not-present page
> [   32.812883] PGD 0 P4D 0 
> [   32.812886] Oops: Oops: 0000 [#1] SMP PTI IRQ_PIPELINE
> [   32.812892] CPU: 4 UID: 0 PID: 36 Comm: migration/4 Not tainted 6.17.0-g970519241701-dirty #38 PREEMPT(voluntary) 

I thinks 6.17 (which is retired BTW) never received this:

https://gitlab.com/Xenomai/linux-dovetail/-/commit/65f59eefa1043e9414b37312826de2a0fa07624e

Jan

> [   32.812896] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [   32.812898] IRQ stage: Linux
> [   32.812899] Stopper: multi_cpu_stop+0x0/0x110 <- __stop_cpus.constprop.0+0x79/0xc0
> [   32.812909] RIP: 0010:proxy_irq_handler+0x13/0x30
> [   32.812914] Code: 9d 5b e9 00 11 ee 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 6c 96 41 02 48 8b bf
> [   32.812917] RSP: 0018:ffff9dcf0018cfd0 EFLAGS: 00010287
> [   32.812920] RAX: ffff8fdea8989000 RBX: 0000000000000000 RCX: ffff8fde00e64108
> [   32.812922] RDX: ffff8fde00e64000 RSI: ffff8fde3bd1dac0 RDI: 0000000000000000
> [   32.812923] RBP: ffff8fde00ea6200 R08: ffff8fde00e64100 R09: 0000000000000000
> [   32.812938] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8fde00fad600
> [   32.812940] R13: 000000000000001b R14: ffff9dcf0005bd00 R15: 0000000000000004
> [   32.812947] FS:  0000000000000000(0000) GS:ffff8fdea8989000(0000) knlGS:0000000000000000
> [   32.812950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.812952] CR2: 0000000000000000 CR3: 0000000058a30000 CR4: 00000000000006f0
> [   32.812954] Call Trace:
> [   32.812976]  <IRQ>
> [   32.812978]  handle_synthetic_irq+0x9b/0x1b0
> [   32.812988]  arch_do_IRQ_pipelined+0x85/0x460
> [   32.812995]  </IRQ>
> [   32.812996]  <TASK>
> [   32.812999]  sync_current_irq_stage+0x159/0x160
> [   32.813003]  inband_irq_restore+0x5d/0x80
> [   32.813008]  multi_cpu_stop+0xdd/0x110
> [   32.813012]  ? __pfx_multi_cpu_stop+0x10/0x10
> [   32.813016]  cpu_stopper_thread+0x85/0x130
> [   32.813020]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [   32.813027]  smpboot_thread_fn+0xee/0x220
> [   32.813031]  kthread+0xf9/0x1e0
> [   32.813037]  ? __pfx_kthread+0x10/0x10
> [   32.813042]  ret_from_fork+0x15a/0x170
> [   32.813049]  ? __pfx_kthread+0x10/0x10
> [   32.813053]  ret_from_fork_asm+0x1a/0x30
> [   32.813064]  </TASK>
> [   32.813064] Modules linked in:
> [   32.813069] CR2: 0000000000000000
> [   32.813072] ---[ end trace 0000000000000000 ]---
> [   32.813074] RIP: 0010:proxy_irq_handler+0x13/0x30
> [   32.813078] Code: 9d 5b e9 00 11 ee 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 05 6c 96 41 02 48 8b bf
> [   32.813081] RSP: 0018:ffff9dcf0018cfd0 EFLAGS: 00010287
> [   32.813084] RAX: ffff8fdea8989000 RBX: 0000000000000000 RCX: ffff8fde00e64108
> [   32.813085] RDX: ffff8fde00e64000 RSI: ffff8fde3bd1dac0 RDI: 0000000000000000
> [   32.813087] RBP: ffff8fde00ea6200 R08: ffff8fde00e64100 R09: 0000000000000000
> [   32.813089] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8fde00fad600
> [   32.813091] R13: 000000000000001b R14: ffff9dcf0005bd00 R15: 0000000000000004
> [   32.813097] FS:  0000000000000000(0000) GS:ffff8fdea8989000(0000) knlGS:0000000000000000
> [   32.813099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.813101] CR2: 0000000000000000 CR3: 0000000058a30000 CR4: 00000000000006f0
> [   32.813104] Kernel panic - not syncing: Fatal exception in interrupt
> [   32.870451] Kernel Offset: 0xfc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Thanks,
> //richard
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
