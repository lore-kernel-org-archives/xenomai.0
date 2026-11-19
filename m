Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106909;
	b=W5o3/rIZgoznlfSsTX4CpnxU2QKoASsi1KNU+/JDd8CuDgTjL2JICcLni3IalhODN3gH
	 6m82b2h35mx12XcDnqpF5zJ84xfJIctQdy7klWIrkRUELT7vUIszpUz9j73w21hYPQsHY
	 phIS7aj1+TYD1T4lxjTg3LX/vlDdmO3W2ouJLXMRGZ4aFDGr+e18bZVv8dlMwP+/hjg0S
	 TmFij5vT22iyAzS5Kqqd3g2ARvMUwZTxY7C3C2Rj2jUJc39Ga0zcg+2Rn5g484GrVa6ma
	 C9buGysot1j+s8GvKoe1A/mFM/VvLJa69m/8zxaUi+lAsgbdST6WHO6sXKXsgXXVzww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106909;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NPe9IndIjHDsLJShOgrToX3q5aEeb5WMMdzp1jAmZqc=;
	b=INyzDXhqIW0xTzHi5JnbsOmX8TfOwGCKqjvYjYGNYdhpIeq1s9fyjQ8Y9PNFR4oX5UTL
	 ap5LM4Ee4/1AD9YqI19YFsOr3yTboU0hlh95FMf2zriDyKToeVL4ay/0+dpmK2+Yc32hK
	 j9UtddLPfHD/2pFl4BuipCT1v+X3ziXBBB8biVLqydEdyFfLPlKrBbjw7hVraT/fw8NkZ
	 wiOxifVEjM578aNwEo7ch9Eh63ywic22WY6uiZTHg8Kptsq+L33Dg45eAQHYxjt9U7mif
	 E3ufOst+CowbGlXSBrmOFGA9//8UvoEQFuhX0RkWdztWpH7xMTireC4TJAFC0N4P6XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ToqMO0TB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.2
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3026606A330
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 16:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3026606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ToqMO0TB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6HSYJSYaEfLSV7w2pjb3ATI1qhtoM4tWSJpPG+9MjA0y0SuWT6c4Tdqa8tKaKP5FH93Jk1VtYe0fgmy3XrzrVu1M0txoejrLTsgN05XDlahjWstNH2PPI/3bCTkHsh4BaMdKMhuGasuUOcbXWVDcty9t8hPQee9VG3neWzDaEx9+Q5wamXQUXz79ld9tFSiSLKDlaOfDJLPXGgIpys/CCZ5AM5hw09ixWjv3+zLBEmxpVTq3D9a/jh8Fu1EjCB+93lc/75Zo7QCn0w5R9JMvs777weFrGZb/tXDR50sbr7jMpLKLiMoJNU9PJkr1An5fIw8RcaQ7P3yAMdzch4mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPe9IndIjHDsLJShOgrToX3q5aEeb5WMMdzp1jAmZqc=;
 b=Z/x/p/O/+eSQsTWnx/Y/MjOLGrapZR/BpFkFGDSbIzG5iPXZuqD0wbgOjdVNRUk7wHoJFdQVLjrgCGGs55vVBlg5es4jzw39DW9ZBR2s0WjhJwFdTxcoelew1WoRDByv4ycQr+VYor+6STdF0hILdiPQoOJYk8QbXEYU08YgOd8WhkFFpKAvrV4nfWh+YkBD1xvnkgtjjiueKUq2tAwE+3mF//2SWxyO0Ttfq1yxgGreRJ8FuRnMCfMRdhfsQWissm3CPTw4FS2l5G2khk64X2pWwJ+Q/ymhUUog6Al5Bc0+blpusIQHgb8gi6297S9Ns2tfsLn5U1vRdb3QuacRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPe9IndIjHDsLJShOgrToX3q5aEeb5WMMdzp1jAmZqc=;
 b=ToqMO0TBLATBtlwENvfg1cpW1P7YE6oSGk34VtOQkBs3YxpBzw8RnJhnuN6UhtDjZad+MIFVpc5TRLN0iki/23S6mWb8kvosQcHXfOgZScSOMgARuCkN4BDc4i+JziNsOswN49b/NFng5TSv6bpf/EXl8WZdhqJc/PKXKBHCF8NZYBPQBU0CyqoPafjRXX1Ux16UbbtkaQXH6YCPfDsl/7oQNWuI2TxKH1Yjp2ubP9mQOzFiZyp8Q2FFkwmak6yelgG939Fe98VC7noeFCbgThjz3VX04G0ijltjuSlLkoNcuvI5hGOeAnK2MI5n+BneUp9FBMLV9N2K+nnpIoHRkQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:b8::17) by VI1PR10MB3149.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:12e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 16:48:23 +0000
Received: from MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7724:b942:fb9b:6063]) by MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7724:b942:fb9b:6063%5]) with mapi id 15.21.0662.000; Thu, 19 Nov 2026
 16:48:23 +0000
Message-ID: <340dcf92-40dd-4f00-9473-434e58e9dc34@siemens.com>
Date: Thu, 19 Nov 2026 17:48:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH] x86: dovetail: preserve in-band stall state
 across handle_bug()
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <edda3386-02fc-4d36-9e87-ce3f2c4f1916@siemens.com>
 <87qzghnf5x.fsf@xenomai.org>
 <e06d42af87e95d790ebb9b41f361385f3f1a0251.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e06d42af87e95d790ebb9b41f361385f3f1a0251.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:b8::17)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR10MB992304:EE_|VI1PR10MB3149:EE_
X-MS-Office365-Filtering-Correlation-Id: 25104788-a5fd-4e24-0840-08df465cecea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|261026140227099003|11063799006|4143699003|261026121527099003|56012099006|261102123227099003|261022105027099003|10067099003|261021121427099003|261028144727099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	51fDhDfoR3+IAkUGlC3z+4sUbsVn8lgHgX82F/5qVWF4TLCClh6pOiVnNBBArh4SvjnUNBBM9n+Ks7oRjIzTP+NcB9t7JAReIV3pgQnGqY5ExQsUUSwtQQ3sU5kYCPi8Ox88FTaYx0h9+5uteLHYFBGGacTMKXzIwumatCC9DygL/Y00Y0HVwinsW44/h9BQ+j/YXFMiBeayXf6u3fjWod5LCdzeAYVNR4uJ76GdEujFN3BcDY/Oo/a15qNYZ5dYGmkoH1xybL1alMoP+iQTesllEDTr93Gmq+C4qebm7GURFAOFqlOlDdqYOO+p56EvL27f+q3BYK5MGD5EkFcUzHAKYtdFZiWP/3yz3TMWHL2wTfxnt/MHCKhnwIrjrk86PJ72doAgvElg8092oGSlEPQKfG/8q2o5XMdLc7LWHYxaHGF+fLeC4LRbRICimyoKSXO1X63ETE8w7nbalz5kamEyKbfTF1K0IzaMCdsn/G7dT/jY/0A3XjQp4mtUNNVi/QbCi7ZnA0BCvyJm/mlDOuz/zu7QQYUE474T9a+FVOmdU7DUubJN27v1AyPBmSNwl5Jvmq2LV2pcqKPDawZLmHlBFxUAfPki8x3X/0ejf0Ju6N0e+mj3ZsQriDKpQxwEQurSNdV4xb1v+QIj8FXHnc+XI9OFUFTUD67zvl3pXow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261026140227099003)(11063799006)(4143699003)(261026121527099003)(56012099006)(261102123227099003)(261022105027099003)(10067099003)(261021121427099003)(261028144727099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGRmWlhheVVGY2M2YzlBMkNleDlxclZuRDB5aFJ4QVlLazE5VDBiRkpXS1hQ?=
 =?utf-8?B?MVR2bDZlbm1mNlZFQUFhWkhUdW96MytmaFdTYkI2Q3graDdSL2p2azRsKy9U?=
 =?utf-8?B?SUh1QURNUGlZTzlUeUFRa3NQVmZ0TmtPU0lCS1VqWlg5OU5LNVRrMVNXSVBY?=
 =?utf-8?B?UFJsRzNSZVk1VUcvWDZPQ0tDY1pCUXBMYkNmMkhBTGdYaHQzS3lwNVQzaDdH?=
 =?utf-8?B?M2tSUVVSL3RFR0V1WlQwSkdFblhkc2dVOW12bjBjRWxHMG5yUEk5V2QraHhU?=
 =?utf-8?B?WENsaEUxQXQ2TGgzZTcvY1dxSFJxR0pMZ2JvWVVxN3IzNjJsb09Nc2hUWWYw?=
 =?utf-8?B?dDNzOVp6M0VkRjBSRWVOYlNiQjZWSXZhTGx1eGV6THdQY2hOWVJlN2xVV01H?=
 =?utf-8?B?dHFENVdyN2hwM3FtMGI3WVpkcHllQzR3S0JpR2JJMWZYY0c5THRxZkN6Q1B2?=
 =?utf-8?B?Uk1saHo1S2tUc2oyT1VMSC9BR25iRXl2bHdMRWRvY0V0MjRLeUhRSHRoQXE1?=
 =?utf-8?B?VDZKS1lJU1VNQ3ZYVmY4cnBtLzhLdG03TzB4YUpXNEpFeWJpUHhaaWdSQk9Z?=
 =?utf-8?B?V1NhSDVQNkFjeGJDNnBXcElKdk96VGdQSUF3NU1LR0dCZlVSVkJkTVdEcGpp?=
 =?utf-8?B?WDZTTWFFNXUwU1BqUTRldUN4UzBaSmJqdzFleTlXMnFsKzRZdEY3YTl1VWtw?=
 =?utf-8?B?ZGRVL3pnOWpPM0ViRjczTWd5MnhOcytWZnZSZm1BdTR3MXBKdklVa3dzVm9a?=
 =?utf-8?B?Z1Nmc3liRHlGcEMxbkRHMG5OSzFMdFNBZ3c0M3NNaEJNMm1xQVdGQ2VIU3gy?=
 =?utf-8?B?ZDdsTXQxK2xyVFplOGErSDFQMkxaMjRYM2pQby9ySG01alZOaU9lcHRzRTMz?=
 =?utf-8?B?MWlDR0Y1MDFhWVJ5dkxhblFxQ3JIc25oalhvc3JaTlZWcmNHZWZZT0txcmZu?=
 =?utf-8?B?MWVJRXNPbzVKUEc4ZjYvTlhodTdBL2NKYURmTHpteXpFOG1hT09uM1Y3SWlD?=
 =?utf-8?B?ekFDN3h0a0FxMENsVUhBeEZKYXVmZjIwWXhtQVZaVEtKU1RiczhBM2JZODFB?=
 =?utf-8?B?V2Eva1RxUmdpSjZROWFzTUxnS1p3Qi9lLzVuVXFxNm52YXFIRWFrWVI2Vmk2?=
 =?utf-8?B?Smk3MWFQZ0JKbHpLMUVDOXVBTmJrOWNKVGU5MjQxaWJHWHB6eHFtTit0ZURG?=
 =?utf-8?B?N1pCWDZRN1B6TnNuRTlubVFiNzA2L1hnVVliZ1NpR1Q5cElJYUJpUHdBODRG?=
 =?utf-8?B?T25yL29uaitUSHYzakNoUU5IbVBGNFE0WC9tYUhxZXJmdUY1REVwVEhDU1pK?=
 =?utf-8?B?ZGFXVDBHVTZzZnJvVlEwTC9qbWFnTk90dUtFQ081R1h5eHE0ODdpbzg3Y3V6?=
 =?utf-8?B?VFBnZTNMcTlWV296RDdPbTl4OFhIRmFYTVVUWS8yWmZoOUc1Snk5OVBDOUF0?=
 =?utf-8?B?Ry80S2dDekFUM21relZRMjQ0bTJQV2gxbmpyckJpWU9aWVN5V3lCZUNxdzRh?=
 =?utf-8?B?R29RTG1nelJkYTY2c3RJbGphdXV0Ymh1bjVobGg0ek1kVkUzcDZWbGFwMjJr?=
 =?utf-8?B?L3ZXWHk3UTRQNWFIOGVwZzhGdXMzUE1vSS92LzVQWmJSdHZFZ0s2WmNCdWlO?=
 =?utf-8?B?aDlEenZxZVNTMzgxQXVNd1FNVWk4Znh5RHlwajJyanhMQTdSNXhycThtSzkz?=
 =?utf-8?B?bnNWbG4zWTVFQ3g1b0J4K3J2S2l2WTFHcnNpckxRUjlGd3UzSFVqeFEydGRW?=
 =?utf-8?B?VGZHcFBOc1I1bVVYVzNJWkEvWUJ4cHo1RVBYR3ExRjYwY2hrSWlIdFd6bUJq?=
 =?utf-8?B?MXo3V3N1dFRON2xONWNBQ3grY21YWVZ2ZzlqZzFTUmFXZlhlQUZNTWZTQ01w?=
 =?utf-8?B?c1RUUEZqeFA5a0k0dEFyd1JnMnhmakdyaUtHalFHa3dxdy9OeU1nUUtReHhn?=
 =?utf-8?B?M3hNWDg1anhmbm1FWHdvSkg3Rk53OUltUnMzNUFBZ3h4VVRMNC9hMWxmMTZE?=
 =?utf-8?B?WGpmbW9ZUUIwdVpYajA4WVVBZDBLSDZqekJqekhOa0YrM0pESXZISXl3Q3Nh?=
 =?utf-8?B?WXJLMG1Hei9UYWZ3L1dmQ1QxcGluYjFReEtGVHpmRGVXTHNadkNtQUR6VjZJ?=
 =?utf-8?B?U2ExbktkR1Z2RW9nM1BsWjJra28vRjQ4cURabkJEQ0hTKzhLOU5xNUFJb0hx?=
 =?utf-8?B?U004TUN3UmdGdXE5UGNmSjNpb2ZmRVlESDV3ZlBIbUNUK05sQk54cFVSNTUx?=
 =?utf-8?B?VGlwR2VvcWdkZlFsaTJqbGNQdnA3V2E5Tm1JTEl4TFhWK09zL0pJZmVNSm1s?=
 =?utf-8?B?bTFkamVvd1A0a2RxMzNCWGR6U3dvZXZOZkN5REZKUG1YRnZ5Y3FHQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25104788-a5fd-4e24-0840-08df465cecea
X-MS-Exchange-CrossTenant-AuthSource: MI9PR10MB992304.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:48:23.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HcUKFYjMIC5Kl5MrTEbogH/iLmuVu36pacmDhamXBFZfi20p+oHn3RcAQ4p3c745sJGp9d7Rb9NOPxt5NSVGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3149

On 19.11.26 16:58, Florian Bezdeka wrote:
> On Thu, 2026-11-19 at 14:07 +0100, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> handle_bug() runs from the raw #UD entry, before irqentry_enter(), and
>>> returns straight to the exception site when a WARN() was handled. The
>>> trap only cleared the hardware interrupt flag, the in-band stall bit
>>> still reflects the state of the exception site.
>>>
>>> When the site ran with hard irqs on, handle_bug() used
>>> local_irq_enable_full() and local_irq_disable_full() for the in-band
>>> stage, which also unstall then stall the in-band stage. As a result:
>>>
>>> - a WARN() hit with in-band interrupts enabled returned with the
>>>   in-band stage stalled, leaking a virtually disabled interrupt state
>>>   into the interrupted code, until the next in-band irq enable.
>>> - a WARN() hit with in-band interrupts disabled (e.g. under
>>>   spin_lock_irqsave()) unstalled the in-band stage while reporting.
>>>
>>> Only restore the hard interrupt state, like upstream does with the
>>> (then non-virtualized) interrupt flag, on both stages.
>>>
>>> Assisted-by: opencode:Opus-5.5
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> To simplify the next forward port and the usual history cleanup:
> 
> Could you please add / provide the Fixes: tags for all the patches
> recently merged? Thanks!
> 

Those are not overly important, specifically over time as rebasing are
invalidating their commit IDs. AI is also good in identifying missed
backports (found several for 6.18 or 6.12).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
