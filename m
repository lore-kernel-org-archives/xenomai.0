Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFC299A87
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001833; cv=fail; b=ZYwltcMVAq80Ony1Csg8nRGLxrFC+SDLuiZWvscs7UZyNXhleYuku8AJvo0QbZmqHnzP0z3zYD6OXOHS/bsNGlufBqtI/IJcMJKQb5KIId+GDclVKpLdDNupwzrfUUwQ4qYDz1zoazcFTaevXPMtvkMsIfKIhtviPBCx8zGBQs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001833; c=relaxed/simple;
	bh=9sbUJgujMb4Z8Ruyp2KUybrhVHasCW7oPNfV2B2B9ps=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGsCYjyioUhmE3/R3vrqMjT4CI4/jyV+D13xNNEZweypLcMFpj7PiMyhvZVb8c2LW45UZFJaoYvg8kOT08r+U4OPXjpgQ2qDN6Uqnl/9mr8zIIalFi1MbXJyycIG4LC2RwsYyI9mLqL7KywVIXe36RG3quDs+5yZHyDX4nXeCLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XUNDvu4+; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XUNDvu4+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwE33f52b5iQgqQT9NfchbOOFMnAf4ZT/EBJKSyZwxq/9PLchGuI/Y0yHN72c7Zb28OJb195iRuHXITAkb3jEcV08Zk5H8xVo7WmEhdp9DJL7tGdYiWzs6x8095m/d3CNC28moqfxShTCWfusHCC23Olzo+QzSn64Ke/Efw8Wz1TdgYGDFcQxoYumWfmrfaQWLwSYTcC6ZhUq7lELuuID3+qEGTSCZhJaJoyrmy9xhy0L6yQx2oe2uNSBqhUA7i/iczmBQIuSQ/FO/JFaiNK697gwGzwE5itiy29+SC8TW6hPYVDOCmX6yxpKClTBrEN9Zo14Teex3sLUdBIgvPQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDF8ejcSEnjkl3LwaxsNpNaw39JHxWwV1aKeKEB3oi8=;
 b=ExMBXkLgYTHlTutDQStcs3gsuasMMXfLj4MIL2c878GRCfsgpawjus9lYcPuzppTYgM59VsFhchjMk7tVEC6aqSHR27MokTxcOcxgMJPEM0RZ0dqtOTuGaWl0uUdB1FqXu6uRmaOHqlVdc6l/B9+IBrDIldgHgKF50X62ACtLd4RKYTPsZKjjLevU8RZ6jzBahr0VcqzXYYHcO8WEPx3IhVLDkp4ThNak9Ka2h68bv8GAsI06coeZkx+kjWJPmD/ruzx0Z1lBTBA5AO2Y/qyjmjPfvmmgmvB7oXw1VLIlTctcIsIH0llSb+rWCMX/4y9QQ9lHmawg6RNmFfbEmSgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDF8ejcSEnjkl3LwaxsNpNaw39JHxWwV1aKeKEB3oi8=;
 b=XUNDvu4+k1LW4s1D0+76UjqPEq7Sbgumzlik3UuL6H9PWSBa6St0iGts15rDJbe/9vn8GjWU7wd8bHgoJgesGIoEY5xsZeodb90alj6O/M0gGd33wVvNRgC0ZUat0klBQ9AAVBZcBGEoi8w1I0YlQ1vuyoUNDtTh8Oi2JghltcVbzRvlpjYapdpJve+O4Lo9Y8KMm8BG0r72OWKuUseneEd814uLvKhfsXePf0YqEtsXZpAgsdJ5cxWV+EZGMQYlcCf8Vdq9QxqFLOOpFlG1rgPZnDwfKnDe6GmVqWSUa0+av/hsIAdFywlvjx8PBb+mEn6h971PmfKs3Ez56/yYIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3929.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Fri, 13 Feb
 2026 16:57:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Fri, 13 Feb 2026
 16:57:09 +0000
Message-ID: <b61769b4-7885-41d1-9a31-cc307d90bf88@siemens.com>
Date: Fri, 13 Feb 2026 17:57:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci(libevl): Trigger more kernel
 combinations
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260213093530.2513546-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260213093530.2513546-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3929:EE_
X-MS-Office365-Filtering-Correlation-Id: b746d286-a9f2-4369-67cb-08de6b20eca2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWFvRmNaVW10Y1BxWkhCR2dHWVVqeHpoMzNseVI3UGd5Nm53V3pJSmdwV25C?=
 =?utf-8?B?MlVPWlJiQTBSK2h3S0pWMkpRbzIzdzY3QXk3WXJVNDdGVTZ4WVlYZ3hmZ3F2?=
 =?utf-8?B?WVRpSkF6YlplaUhoaUxhQlY1QlpKQy8wc2dNVmpHbnpiQk9DNkhGYXNFNlZZ?=
 =?utf-8?B?WFY5VmdNQ20xZVNQQmdhZm9tOXpBMGtuejA4SWprSnVaY3BTWUtYWm15TDNm?=
 =?utf-8?B?SGF4Ylgwd3RzM0s4c2tXY2I2NHJXeFJJbXZYeHJ3VjdnWkJwKzBXSDA4M0sw?=
 =?utf-8?B?NWE1YzhNd1FOd21OTkRhbWM5REd6N1ZQdDhvY05PMDBGbGp0UG9nNzlxSC9W?=
 =?utf-8?B?Yyszd3VLY0htV1gzNTJwNkI2TXBLZ0FHdktZRXlaWm9tWGFCMG9Pc3Q3a2JB?=
 =?utf-8?B?ZjNSdmdCZWora3VUb2dtN3Q5OHNNdlgvcGVrWDgvOGZtWC9WK1hEZ1lkOVAz?=
 =?utf-8?B?aFBnYTVTRmZ1cVJCTExLRXNFNGRNbG1FK0d2NHN4dlNoZnYwYXBkK1BEZW5R?=
 =?utf-8?B?QnI2VDNrazFKbXhmZi9nVnlxUVFGTkNPdHlnTWFnL1ZlcDhIcWQzcVBxWmNC?=
 =?utf-8?B?QUY4N3JRRXNNcVEyc0xuQWJ5RjREaHlTSkE0SFo0MW9mOWI0Ni9MVUhaSURF?=
 =?utf-8?B?dzcvZHR2aVlGckhoVGtLYzVNNG4yaHFNaFVqczNpYkFRZDdrZnc0Z21mcFND?=
 =?utf-8?B?dE5qb3pONU9TaVVFalVMR3hmQUV6WXorVEZoL2xSYUs1MjdTN0p3ZUhBeWVO?=
 =?utf-8?B?SXBOdDNqMWM4TGhaSUdKVURZQnlrYWNoZVlHMmZuZXF2KzBXWERVS0lQdUgy?=
 =?utf-8?B?SmcwOGZsM2wvT1NsT21yOVUxNlpFb0hCUS9BQ3lsZkRzZU92SERXQm9LaE9y?=
 =?utf-8?B?aWpUVkczbkVyUllZS293Qm91VFA5MVUzS3pUUmVjT2dJRG5jYksyamZaclJq?=
 =?utf-8?B?bjVOMzNNeUtlY21VZW5td0pkbENMNU1yMytvQ3oyY3lwbFRUOFovcU4vSFpJ?=
 =?utf-8?B?SjJnSzRzeC9RbFgxZmJ4d1l6MVEzd0R2YUNMM2paZ2NCZEdHeGpmQStxWk5Y?=
 =?utf-8?B?cHpGdm83NHZadW9HU0RIYTRhczBGZnV1WWdHQ3lXMXV2R0FYanVqVi9YZmpX?=
 =?utf-8?B?bFlkc1I2aG5tWWVDb29kRjc3cHkvMWwyZlBKVklRNHVKY2w0eVlqdXg5eUFi?=
 =?utf-8?B?ZlRSU1BVS0t1YU95dEFRcXBmMzd4SVlGSnhTRzdqRjAzbzJjZjh6OVNGdGdT?=
 =?utf-8?B?ckZLYUh6bmVua1VreHA1MXNxQU5FeXdQMW1RcHBVd1JKRlBpZnFFek9FQXNQ?=
 =?utf-8?B?WDhMcTlUVmtnYjZubEJvMGxiTjJJUmp2bW9SK1VQM0VCZ24zajZqQ1M4RHZq?=
 =?utf-8?B?b2IvLzFVaGIwSENyS2VuV0N3TjV4U3VjNnpMaWtEWUdlOWIrUElmRVFLTEx5?=
 =?utf-8?B?VE13c1RHdEhnSXExZWJpR3NreDgwQ2VSMDNNbDI5cCszWTZRMHRzSUkzZG5D?=
 =?utf-8?B?QnJmcytRWW5Kd3IzT3ZVUUg2S1pPbXJNdElVbWsyNFY4cjY4bmcwSzZUdk16?=
 =?utf-8?B?YzVOcTZDQ3QxU0tzMkxBSXd2QkY1L0hMUytMMlIvbjBkam5XdGtnWjFUSjB6?=
 =?utf-8?B?dmhDZHlieEo5c3VoOHZVMzBySFo0V0g2QzB2U0Fyai9vOTJGNWdLT0s2amtC?=
 =?utf-8?B?QmxBUUpOZzg3dk1hSFFFS3lTLzk0V2laNi9QK0E4UWUrTGovcDVzd205RE1n?=
 =?utf-8?B?czNLa2lNWkkxODBWaWQwRGsvUjBFM2lTNnZ5RHdOeC96OGtsY2JucXdZL0NU?=
 =?utf-8?B?QXJUeVRCQTV5NXZibU50ZVZUSnViTnUzaHZFdXUvTm9hdG9MYXh3azI3a0M4?=
 =?utf-8?B?bmFLREk3R3VDelNhM0k0OHpCUGF1cjcybFVld1Yrb2ZWQzhYVEhzb2RNc0th?=
 =?utf-8?B?UThJVGlES082aEcrazREaDc2MFAwVEdMbjlzR2NyektTdVQxWktWbHY2YzJG?=
 =?utf-8?B?U3Z6aTdrMjAvRzZlTjhqaW9SbjFqVDhieDRuZEtqc016ZWo1b2pHdVZHV1dK?=
 =?utf-8?B?MGFFRUZTUWltUFFaZDhOekhZbVdUcjQrN3cxQXlTWDBFRnNkL2Y4WDVnOE9U?=
 =?utf-8?Q?27lc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlM5Z2lJY2tkSlRFekx4NHp4NVZUWWQyaWRtU0hiSlRRekV2OFhFZ052T1Z1?=
 =?utf-8?B?TC9yakprRFR1R1J0b1VtRGVQaHJGbkNTL053M0lvSDZBRUJFeUhGckt4K09p?=
 =?utf-8?B?V3dTbUtJeDJJV1p2NVBKUU5RNG1WNVFqZFFiMHNGVm8wR2g5K214Zzg1dnFO?=
 =?utf-8?B?eElTQkpDdW1ueTViNlBHaU5XNHZzeGM5V25aUkZNd3hkY1luaVBzajVEZWIz?=
 =?utf-8?B?SkJZUXhqSEVqN1VNMCtVR1JCdzVZMzdaWmhwcEdianNqVGM1TTgzSHU4VHVN?=
 =?utf-8?B?Rno5QkxENzJRRmkwelVVRXZ0WFltRW1haFZSUDlGVGlYSXhjUmVOSGppc1JZ?=
 =?utf-8?B?MzR3VE0vQXdDek1aK2NkTklzNTdiMk8yaWpUZVludzJmallnU2IycmVURnQw?=
 =?utf-8?B?eUtWS0tqRytzWjZ3N0w0UmhHRnYzU0ZnRm0vUTZMRmk0ZnpRWElZdFM0Z3Jx?=
 =?utf-8?B?UGdTb1FaNC9WNXNLT1ExNG1iMDAxbjVLK1B2WmYxZmV5bWwwcC8vVUdYWTF2?=
 =?utf-8?B?UXE4MGw4YkZWV1ZuRjAwTFRRWE5pZUdzakh1UzMwaFJacUNSdDBPSHY2VDV5?=
 =?utf-8?B?cllkS2IrVXp1KzZTQ3dxR0ZNZDJnYURCdVR4K3hKTmxDc0dUOW1HSHplZnVX?=
 =?utf-8?B?SWxnVUhpWDM0SkFRWUVkMlgwc3RtWlk1eWZsNTNHVWxnQzd3WVVkZFdlbFRj?=
 =?utf-8?B?UkRrWDExeXRJUXJFUnM1TmNDYjNYWDZ2dndlQUphVnhCYzc3L3g3N2V1ZFFE?=
 =?utf-8?B?aFAvY00rMExVb2t2ZUNFUm56QldKTnEvRUZwVGdXNW84MFAzMkFBK3oweTV0?=
 =?utf-8?B?aW9SZGxSS1VrRFJKUkdnbVBFZFZ1QXh0WkNCWXJKcW1jVzljOFZ5a0swd3BJ?=
 =?utf-8?B?eUdOVnVGRXRQay82Nll5dEdSWWtDYkE5OXQ1anlET0wyclhySnpHcy9TKzhS?=
 =?utf-8?B?NERNVW1hYzZEbVZya3J1VVBPZSs1aEVPSGhObXJaa0EwQ2dWTm42MG9KQmcz?=
 =?utf-8?B?VjV3dlhFMGdJSXFCVk9GVklKaDEvTUxkN25mU0NZSHFhMWk1MEwveGw0OVIw?=
 =?utf-8?B?QmJYUzlVeWlXNmlFMy9ob1ExRmxlSFZUM1FQS21sZHBXWHl0NjRUOThJbC9I?=
 =?utf-8?B?K3dVdVlCYTYrcUJYM1NDVmRTSTZldnlHRWJFanJvTDdaT3V6N0gxV09kUEtw?=
 =?utf-8?B?MUNWNU9QR0ZCUndPb3pEQ3N1SUJ1bU9oMHZyMjRyNC9kWWxwL0s4YVByZUo4?=
 =?utf-8?B?MmExdVFJVFJlOWF4aDlqajkvdzU5S2JkT3pxelhEaUp4bStnNFZrNzRkeWF2?=
 =?utf-8?B?SEw2UkltckJObzVISnZpL1J2Mi9FVmRJL1BDeUZxdkEwRUFGT2ZvcXdTODYx?=
 =?utf-8?B?RElNZE1Rem5rOHAyUUF3TytlbU1sZDdWZmp1U1dhbnloTWhRMERWN3ZtdEFM?=
 =?utf-8?B?ZmhEdUZseUptVFN6RmczZG40S1BkbE1tcFN2NUEyT0owbzRBVldqU0V0b0VQ?=
 =?utf-8?B?Uy9qU1J0L3ZCbllFRGNoelhsSFh1YkQwOFBiRExlWXMrMlhqb21ubXllQnZQ?=
 =?utf-8?B?U0F2QW1yaVVwUFVCa3lnYk1Ybngzdnl3aER4L1FuT3V1MVk5dkxrN201a2V4?=
 =?utf-8?B?NVdGSzNjNWJlUXUwdk0yd2d4WnhOZFA0aHlESXQyTU91RFpLUDcycC90eXJi?=
 =?utf-8?B?N21BeEtaN1J3c1kyTzdVR0taOGx2bzZCeS9kRTdzTXRnLy9vN2J2U3QvejE3?=
 =?utf-8?B?MXYwUDJld2ZoSEJuQTBSbE5hTUtWOGJBS1ZsSm1BblJKRENnOUJrQ0NPblJ1?=
 =?utf-8?B?Q293UTdwb2NJVkpyK3k3RUQyY3FDYkpUY3Y3NzVXN1hxeEQ1L3JBUWEvMWsz?=
 =?utf-8?B?TlRKZGJ2TTRVYSthT0E2V2h1blhUYWx3ZjFQNitOWUoyRWRJSVBFU2VUTmoz?=
 =?utf-8?B?YUFMbE15VGdZTkMwOXFFbWpTZ2tnbytrejJUVnNxNEJLS3NjWHc4L2U4ajA2?=
 =?utf-8?B?d2FYUGRFdXA5Yk50dDV2K2l5dGZvNXA3Uk54dmpEUCs0NWJrT1YwbmlVMEhJ?=
 =?utf-8?B?UXVWb1AvNGxFc3hNbllpcW5YVnl1RDFmd0poay9UcHBQNFJ1YmdsaEZQQ29V?=
 =?utf-8?B?dURuK0t1NGNrbDdWK1pMOW1BbDJMbCtwdUw0di8rRFNyeTFqREprNW15TDlH?=
 =?utf-8?B?OVFBdVJGTEh4N1lIWmM0Q2lFNVNtWFhKMFRjMlc1WHNsSU5ISGIvdU1oZG9s?=
 =?utf-8?B?UVQ1MjhBRVhsVGxXOFZVc1RPdVdVZ3hIQ05ZNG1UamZoZHZIUUF3aHpVSldC?=
 =?utf-8?B?NkR5allaMVdQaWxWSS9TNjBYV2JIclk5MDlORXJ4UGpEWjI1T3VJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b746d286-a9f2-4369-67cb-08de6b20eca2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:57:08.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbHeWgQI+8c8K/Uasn70c61vEd5p7fAm3GxnfnMHa3OZfwMQeQZk4Jejuc+ZNdj4TAdp+RsLLwTtnXjCjHpkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3929

On 13.02.26 10:35, Clara Kowalsky wrote:
> The libevl next branch triggers a pipeline in xenomai-images in
> combination with all available kernels (6.1, 6.12 and head). The
> physical targets are built for all kernels, the QEMU targets just for
> the head.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  ci/trigger/libevl.yml | 2 +-
>  ci/xenomai_4_evl.yml  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
> index bbd4e13..f9228dd 100644
> --- a/ci/trigger/libevl.yml
> +++ b/ci/trigger/libevl.yml
> @@ -19,8 +19,8 @@ trigger-xenomai-images:
>    stage: trigger_xenomai_images
>    variables:
>      ONLY_RUN: xenomai-4/evl

Why not simply triggering xenomai-4/next? That would be in line with
https://gitlab.com/Xenomai/xenomai3/xenomai/-/blob/master/.gitlab-ci.yml?ref_type=heads#L272

Jan

> -    KERNEL_VERSION: head
>      KERNEL_VERSION_WITH_QEMU: head
> +    KERNEL_ALL: "true"
>    trigger:
>      project: xenomai/xenomai-images
>      branch: next
> diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
> index 0404ca3..abc1e56 100644
> --- a/ci/xenomai_4_evl.yml
> +++ b/ci/xenomai_4_evl.yml
> @@ -13,13 +13,13 @@ include:
>    - local: '/ci/lib/gitlab-ci-base.yml'
>    - local: '/ci/lib/kernel/6_1.yml'
>      rules:
> -      - if: '$KERNEL_VERSION == "6.1"'
> +      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_ALL == "true"'
>    - local: '/ci/lib/kernel/6_12.yml'
>      rules:
> -      - if: '$KERNEL_VERSION == "6.12"'
> +      - if: '$KERNEL_VERSION == "6.12" || $KERNEL_ALL == "true"'
>    - local: '/ci/lib/kernel/head.yml'
>      rules:
> -      - if: '$KERNEL_VERSION == "head"'
> +      - if: '$KERNEL_VERSION == "head" || $KERNEL_ALL == "true"'
>  
>  variables:
>    XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
