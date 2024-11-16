Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232EB161
	for <xenomai@lists.linux.dev>; Sat, 16 Nov 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731763618; cv=fail; b=cIb6efWMx0zKQTfo9rOSzIrNsLa+gSaSWx3oorj1qr50srWY3gxaYRCFijoK/Ex4Ezi/3bgdDU4Oj2NcwSGpPG5K0Gy7hl5TsY7MCbU8wfs5CV0RPVZmAHZICvNCuvv160+jPYqHvK6WYkIhhE/zXaUz7nf+svW5XULigsGyGtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731763618; c=relaxed/simple;
	bh=RLIQhlZ32YDcyqRvnpDXBr3+xdpWtHctTE8J1fO5pNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KcY77qcBM58MbWyjQS3nk6NOibaMZYSrtIN12JZ8UpIdbdA2oXaLsgMKOlqMklLNVm9kFHfLo/DQ0MmsKWWCuQf7ZzkkSQP85v8tp1zGKGUXUHxqcqu50Ugn/Q/Bl8zLO8fN55BYK9y/S1NGj2Jp7wAKQK9Oa74KlLTy5GrIdDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OGb07txt; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OGb07txt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy/4WSAye3fvCu5IHGKEJzl0bElodBvRl6CNjIKAjgPbgfQ7SZO4Uyi5i+aWAqFvZORXX0h1FMIfjj6TyMr/pAGUE+siiXM1R9u5Jxc4T6udNh+uMJ+DseIydrLGSkOstBcobZaR48XgvNGybYf3k3z4lPFLKNwVB8XP1/CoyVWzeqqKqRc/ZSeuspo6jeNVdSpZL5wx6YbGtTHBTWt0WoKMhZnaPvE7wvJ58PmCLpftR0tRFr9YSKLUXTC8SKupBEmaCH9lgHI5AmWmMo5qmRDdIkO4cQ1Js2vZP2/1NJSsutdHQAtRzqm/jRtSWSC/XHEaSUeLI0fY9w71xQ/vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb3PXVlguzG51ueO09PLo428LADf7QSDmchssZAkuiY=;
 b=ZmnGf7ZiA7gWBBLYEGhYZgTI7UJwVas99Xq1r4gxD3DW9ZMED25Ph/uCn5UC0+s3ML4R1ajgNyKMVQpjgXHvlobtM034/F03bm/Onv71B8T5PtTQozkvrM3nNcgJi1e50AFKWiXD6jjPUd6k6J3glJDwj/5W/xJqWBAbpKknpbPQUYUkM8W5ueRUTWPWQquewOm2gsSPd5y4tTsgYhOP5FPk/8bEsmLPrBg9I5BRBozmnQ5/O6i0555spdSR+CRsbbVxbQAcfQ2kSg1h47blAEekJ96KzG8ebIMvwS1PehgUXnLcI5AmG/ILw3EAXVzUODZ+fbZicJkEcFZq5VRJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb3PXVlguzG51ueO09PLo428LADf7QSDmchssZAkuiY=;
 b=OGb07txtCdHw4PaCzV87OXStVH8msC6eLVoRd5q8E671eXvHfFnFBk9isHXgacIISB85julwzciE0rLQ6cFJ/oGkOiw/oa9gZM/VedQwqn/4F06r5YBCqZWhkEeOMduH8Xx/IEjBFr8lAeBrZXw631UneyQXyEEwtLmpMZTinMcYz8pnDxHrTWPn/+/xOzhrhM8IR1wUWDjIiboJow5v5yGJFwfr8wF/DDQK3jUoLNVMT4gacj0kh5dm9mKTkX0/5MDGSI3InkrVykwPIqhgW/16Pliu3F1jUSPh2gJ55P0xTMVRRZ07JWubdKzSHffb902dWeWErZMy/YQ8W8+K6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Sat, 16 Nov
 2024 13:26:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Sat, 16 Nov 2024
 13:26:51 +0000
Message-ID: <9c8bc747-a651-4572-858f-2c947656999e@siemens.com>
Date: Sat, 16 Nov 2024 14:26:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CPU threads supported?
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPEtkU71sT7Dz6U2N-uXLiuuTsXEtvniU5jWBog81D1gvw@mail.gmail.com>
 <ec462a4d-e060-49a7-82d7-088cacd381e4@siemens.com>
 <CA+K1mPFgts0=67-jOYk_0q-Ha4JZ9tjK_REfogp5vsWQYOw8dQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPFgts0=67-jOYk_0q-Ha4JZ9tjK_REfogp5vsWQYOw8dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d61e634-7ed0-4321-c8b2-08dd064254c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFZ2bmYzYUxIa3BnTkhQWVVTY20vc20zQlJrMTNCN2NSRUNVUVU1TFBvaU9S?=
 =?utf-8?B?S0FMUDBZKzdETmE3T1dTSUpCa3hwUCtVRTAyTkxnUDliNXE0MFZiZEtBNjc2?=
 =?utf-8?B?SUxHanYwZitWeXg3U25HRGphV0tjOWNXeThjaWY1OVBKZENoMHFwRUJhbW5x?=
 =?utf-8?B?VzQrdUZISVhrbldQVUpVNEppNXhFMzNoWkJRRmZBcHFrdWNUSmUyWUhOUXRo?=
 =?utf-8?B?cDRkVnRKTDQ5WFc4R1VvU0Z6d3VHYTBxblkrSm5VYmdLc01NOVFVbmJFT01R?=
 =?utf-8?B?ajJrcFhJRkROeUNDeW1CSDZ5YlRxZTRvclpFTFREOFgwZnF5d3FlZnFyd1My?=
 =?utf-8?B?SXdkcEVvb3g5Y1lSTWpLSHlQU1FReXR2Zjd1b0FpQ1pXQm9SL3MwV3hiM2hy?=
 =?utf-8?B?bUVVSDk2Z2pIRk9aZ1c3UnVCam0zdmR6dzhQRFFIcytQZFcwaDdtMjM3dkF5?=
 =?utf-8?B?VElONFJ6ZG5RcGlXcDhVWUEza1pUZ1h4THBOUHNDclB6VENVaDR0TnBPRlY1?=
 =?utf-8?B?cHVaZzcvUDhTNXcrTXRuYU5JblA5RWwyRFcxWGVXYTFPWEtoYWpuSXY0VU1K?=
 =?utf-8?B?aDRsNkJkTkJlS2xyT3M3eCtDOFYrVmxIRkdzTmYyb1VGYzlvb0JTWDVzc21U?=
 =?utf-8?B?d3lsYUI5VWY5b1VDVGt2alB3M1VUb3dNQVhCZ091K2dSSFhZZ1FjdlRYK2d0?=
 =?utf-8?B?MTFEZ0xtaXdnNlIwQVdTbUd4Q2FTUWcyYlRNbjUvamNaR1pJODBPZElsRmZw?=
 =?utf-8?B?b0hCLzZSOThSNHZnSHFsVzV6ckpxZlRFZUlEV1FwTDV5U0orZ2RZNmFPTGdz?=
 =?utf-8?B?ME9zM21lVVJvOVVQWW1XUXlubnB6L2lqWkRLelVWUTJtMXBtMm5USHhQWGVH?=
 =?utf-8?B?c2trQ0VXbjdRbFQ0OHdHMHhFWTVVMVYvdER4RVJyVXFGUVV1V3hIOWVOSE5L?=
 =?utf-8?B?S1k5RWNGMWFGUGVEVVdWM2VkUG1MT05rMTIrbFpUZVcyOWdkM0NmRThuVHoy?=
 =?utf-8?B?WGJOTFdvSVVDUzRGelBKb3R5ODY4eUwzZ3FvVFhyNFdhcU1uSzdHcGZHck12?=
 =?utf-8?B?eTZkTEpxd0gyYWh6OHhjOTFNeFg3UmZNQUQ3eW12bFdEODJ1YWVVdmlVTXU0?=
 =?utf-8?B?V3hja0ljZ3BGQnNsN3BlNVdTZCthc1dsdFBjUTRySDM2K1J6MDR5Yng2MWlz?=
 =?utf-8?B?Nlh4dDF6c0g5WFhrcXAydVpDL0x2UGYyYUE5WW1zeHhNWFJKVndHNVA3cVlN?=
 =?utf-8?B?MmlxNHFadFVMaTFPNUc0KzRlSzhsWCtjM2RyQkYwWjJXU3I3ZWRjMHM4UTFl?=
 =?utf-8?B?eVBZWmF6c0xiMmN6WnoyRGQ4SVJCSzRTWC82d3JhTW14N0ZYQkhSSCs2TXRE?=
 =?utf-8?B?ckhQbjFLQ2xOQ3Y4TUQ1MGF6OHF1UWd1eXFMdnF0RENaV3pZSTRuSUdwengr?=
 =?utf-8?B?aW1vdjAwcEV5cSttNldqTVRjOW1NcUtTZTcyb2xVcTdHQmxiZVJyNnVXWTVB?=
 =?utf-8?B?RjMwenNxMnBSY0dtclpmdVBCWk1TWWhOUWZKNktmVjhteHdBNkVGeFFFc3FS?=
 =?utf-8?B?UWtsQ3hhNTEraE5rakg2ZGtMbGVRSlQ2OEhIakRFMDI4OVgwM2h1ZU1lNVp0?=
 =?utf-8?B?Z2Vqa0o5S2tydTl6STJHSzVCdDVTWkJ3S3NjWlJOeVMzR245eU4wUk5WaHRq?=
 =?utf-8?B?NnM4YUhnU1FOU2ltS2VZK3hTVmNQa2NDWnJFeW9ISGZCMEVndElSV3NUcVFv?=
 =?utf-8?Q?Jjvvn9fBSyidONGEVIY8fy2HNFBXrPGtDm6kiGJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWF4ZExaQlZsTnhZSFNSUVY4cFhuaTlESVlyR1VFVHJHTXFiQjBxQmJQdHNS?=
 =?utf-8?B?NzFZWVN3ZnpJTEh6bDJDeGRjSmtoRmtiUVA5MDJ4c1FxaEM5a2k3ejBnbjYx?=
 =?utf-8?B?MHJSMUd3MGFHV21xcEYzbHVNZEZicW5UNlJZRzJoY0krSUhYS2kwem95c25s?=
 =?utf-8?B?T2lwcERSenVNcjRRY2h6Q2ZaamFUTjE5R2NhTkp6ejJDNlV2dWt5YU41Y2NY?=
 =?utf-8?B?bkZpWTQ0V3RqVkU4UEdCd0N3alN4Y09xcGNIS2YwcjRIT1k3MG1uSDEwRUoz?=
 =?utf-8?B?cHg3RW1XZEY3Q3RJaEZRc0hLcjBHT2VjWk5CNXh1K0NQelFaT0w5cVk4ZHpv?=
 =?utf-8?B?eTNiQm9jMUJLTEt1ejcyRjd6VDR6OFdNVXFYYXBPWWFDc3VuRzVqVHF0Mkhs?=
 =?utf-8?B?VkNYWVVvY1RycCtjNkNWUG1KWWpKMzNJZ0pyclVQbGgzTTRCODBKUkJyazFI?=
 =?utf-8?B?R0VEeWpYSGorMFRZdFZSM3VRY0M0V0tqOHE0S1FQY3JEMVQ1Z3lCclR3Nkxx?=
 =?utf-8?B?Vi92bE5xT1E1QVg0a1BERkoyM1BtZkNCb0NNM3QyREl6b2lVRWUxZmdVNHhj?=
 =?utf-8?B?dXZMOFF0Y1dUOU95WU0rczUzMmJJMk5qd3NtM01YalNCd0dwZjVscHluZTdM?=
 =?utf-8?B?bWwzeVFXenFCUVlUZVY2MUJBRnM1Ti84RGEwaEtyc0F2Yjg0c04xc2hFdzFu?=
 =?utf-8?B?bm1Scmd1ck5vc0dKTkdwV2F1bFFrd1Y4TUFVTzJxT2hhU3BLQnMwelM0UmRC?=
 =?utf-8?B?emlLeGRobDYxOTN1WkUxbkl1aStGdkVUcGhOR0grTFJUd0RReElrWVVLTFpq?=
 =?utf-8?B?ZFNvVW5BMDJKeUZXelZIeE9xSEo1dDBtTDFuZnJlVUNXdjFwc0RJa28rMkpx?=
 =?utf-8?B?QzdVTUx3djBRRGtaR2RCZU1xRzYzeUFxUHFvaG5UK1JqUnZpQjJ5ZTllckFZ?=
 =?utf-8?B?aTV0RUdXNUxBNXlRZi9VaTM4MklWV0k2anp6cFpSOXZ3YU4ybkJkcndrSjI3?=
 =?utf-8?B?enRtZ3N3RWFyeFB0L01xVmhZTzdHL1Z4SlBoVmJqYUlVSlVrRUVvY1R3eVh3?=
 =?utf-8?B?ZXBtM0ZHam9QY0d6WkorTnBaa2EzekxNNHNxTXJZTzBrRnkwZ1N2UzNwV2h5?=
 =?utf-8?B?VXYyWnBWcmNMV1pGWHZVYzM3RG5PbFV3a3BsMHBZQ1hwdXM4WHpLbTZQdnBY?=
 =?utf-8?B?YWM2ODBiMVdtbTRWMUtwekdQeDFoYkYydVptd1JyNDcrSFJoVXplMW9UeEJU?=
 =?utf-8?B?MzR4TDZaSFBTRU96akl0MDVDME9Ld25TR2lCc0I4UXh5WXFFMXg0bzlqdWtx?=
 =?utf-8?B?Z1lsRVJodS9KNFdXVlY1OFlETklhYmgxWllEMnhYRlBicFpzVVdsR3JpSzJ1?=
 =?utf-8?B?OHk1SFdGaWU0ZjY0aWlHbEI0U0c0ZkxPWjNZSStJcTNONU1kTnFuUWlRU1cw?=
 =?utf-8?B?aU1wSVhjOE43ZytVc0V0bmtpNGpGMTdiNHc3ei9tSVNabm1SeXZJRXl4bzFG?=
 =?utf-8?B?bWxyMU5jSkNPdCtYbU40Q3NMT05DUFZnM3BwOXhCbjNOemRvdTNxWXdNdDZS?=
 =?utf-8?B?d2YzQW5mRVhnS0UvMklwRHJNbzVVdGh3R2cwU09xcTdLWXo2OHd6bkJzbDht?=
 =?utf-8?B?OVo4SW9NeE15MVErL2FVcTRBbkxubld3cmhGeGpEYllZd2lVaUYwaHcxdlYx?=
 =?utf-8?B?dVVBTlplZ2huSXB4aFo1NVlwLzBuVVFFTHJacXNiRGF4SHowdFAvaFN2Y21i?=
 =?utf-8?B?MVYvbjFlZnc5U055RXRsb1BxWjVWTGtJb3NlMUJVUkFZRXp6cFV1VlE0NUV5?=
 =?utf-8?B?V3RoOW9oZG8xWTBrSktHUUIzcE5YZFRsbWtpRHd5V0FmWk5wTS9Hbm1ZclpO?=
 =?utf-8?B?S1BXdHJVL3huS0RsOGZWQUY0bzJINURhU054dnY2Ulp4ckY5YVNUUkV6eGJk?=
 =?utf-8?B?QnpSM0NHUlArMm4wejk4djRHNFZDMVg0MlovTno3NUJSOEpyazJORHV0angr?=
 =?utf-8?B?T2ZGVzBmdzEzVnpIdnNVa3ZrcVZkT1pnSGRCbnRBQ1drWlR2UWpXL2FCM1lt?=
 =?utf-8?B?WG53Zi9NcFV3b1VScEZ5WXp4RSt2cEx0VnpzZ2ZoUkdkZXgvL1NxMkhYSVBi?=
 =?utf-8?Q?MF2FRRD2f6SVOcWqUQYsLC0Kb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d61e634-7ed0-4321-c8b2-08dd064254c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 13:26:51.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFQih7QzD9I+M0L3e7P5JaRP4Smsl2d2yxXS+wf1HO16yt5EvzrHMyMh1Iteo9crSML5W1hg4eBFBtPQBSxoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5811

On 15.11.24 22:23, C Smith wrote:
> On Fri, Nov 15, 2024 at 2:33 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 15.11.24 08:29, C Smith wrote:
>>> Does Xenomai support the _threads_ of an Intel x86 processor, or just the cores?
>>> I'm using Cobalt kernel Xeno 3.2.5  kernel 5.4.281
>>> I have this 8-core CPU: 11th Gen Intel(R) Core(TM) i7-11850HE
>>> I don't see anything in my kernel config that indicates thread support
>>> is enabled.
>>> lscpu says there should be 2 threads per core but does Xenomai 3.2 use them?
>>>
>>
>> Xenomai does not differentiate between physical and logical cores. And
>> that means, if you want to get a decent latency (<100 µs, on some CPUs
>> even just <1 ms), you need to make sure yourself that the sibling
>> core(s) are not used (e.g. offlined via cpu hotplug).
>>
>> Jan
> 
> I definitely want the low latency, so I guess I want to prevent the
> CPU from using any logical cores.
> 
> But looking at the CPU hotplug docs they list kernel options to limit
> CPUs, but I don't see instructions
> on how to restrict using logical cores per se.
> If I have 8 physical cores and use the kernel option maxcpus=8 would
> that prevent the CPU from ever
> having more than the 8 physical cores? ie: prevent logical cores from
> ever being used?

If you can't turn of hyperthreading the BIOS, we need to study the core
topology, e.g. via /proc/cpuinfo. Watch out for processors with the same
"core id", those are hyperthread siblings.

To offline a logical cpu:

echo 0 > /sys/devices/system/cpu/cpu8/online

Jan

-- 
Siemens AG, Technology
Linux Expert Center
