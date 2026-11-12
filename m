Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490702;
	b=UAc0eO35Jwt9Kik/mDYyDmCzeKCdCg7WOkPUP/GNaeUB0Amv/rYmwzd0Y1nipeHICnS0
	 IOB/+f7GWJJo/Y50TOljJkc3Lhw0GdBKQmOLjABwGZOq1AUjtG7OCnfN6SfvR9zoBoZEM
	 xtrQcWMwuX5EndEUaz0m1w/qxVPGpR1wmOgTsUFW9lwtwIBVMTPA67iWQmYYOSnPGM16G
	 g7GdK2v/tpIKJniDPyhurij0JRKlCRH0ARtCiLr2yWDLaqFLMIi2G4ksYhUhNe0vawmkS
	 WmtWtgTWEJA1vwtRQNc34FKkzhsRDg8W5BKgJbWgORomVo6db56AQqJUOwQRNUYX1Pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490702;
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
	bh=rV/A3L1eV/X0/mwChU/vlDrU6gN0pYnIA0lSfD427lc=;
	b=OKXn5hADCJk3t3WD3AtM24fu2JgW6nq0tAx9B0Z+sL8pe+j5IYFp8gVZQ/GVQDH9Q9ND
	 T3brwwIvl2/IoMSqFR1CMDm+4n8vbk0ht+4KgBsKE9h+UFe9kS2q/K/bAXt9ME2cM8Rox
	 o7y6ptvhqyaCT8mqzjx2Pp2c3NQZd2DTQvKGp917xPvAWAZuX5IlzRn+zIte0+1S2U9Ry
	 TNy5EfzfbSBC1+ogL7LicDjl64907ank2n2ZllmIkoQfNUztnj13V7UqyjW5tFRwqFObf
	 EOQg4o0iLw+fE3covJO50FdhqSlBbsuax1aTW/L/nVwlSeO+h2iiM4eGsYDA6eBhhZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZhahTbPG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.13
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBF60A2606
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 13:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CBF60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZhahTbPG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEjZ72EPVH1UrmvaOcX0zeuiWJ+UgV9k+fy8gAfRLw3ASgJiVCmtiVB7jutLoMJ+a5vv3EUYNeeE8WVRI3+22yy8XW8RZ/OAvAHKcuFBMjp3sa0Px4OrVFq0g2tmuUiL04LJLi9kCad6HGYIhbE6u6whHjwjgER6UMCWGA8AQWkzA+jR+LuF6J+8ec+A/Gq+drr7pHXHaHkzSi9djeMtmcfkuKrrbiECOGM9Dsb3/on0eCGlOucboJpWnq9Rb3XQgeEI138iTOeJ3ZVGCPqzXkkW3GbPAMYO+nN/JMpzuV5gq5XLz5VES5zGfkd9FEUjD8UL5A34n7fKwFdEhSWL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV/A3L1eV/X0/mwChU/vlDrU6gN0pYnIA0lSfD427lc=;
 b=uXfmoKl5ZbCOW7keFM7+XY+V3q8pXhsN1TDg4znqa3UgZFgQQAqUFEenaNHDwVYaAMOWSnfltTsazBfoih1Dt16XVtRZuv3EPPu/dV7mFYm9NWBFtTafNr1EV5Imd3SiYnwYXboDcwjT2j9wQ6zUTvZSB1a5X2s+MR8hEqMLwZniC2RthiQwWj/4N2cKix8al8EEG3ooP6Mbcyv7W5VVr6F4tN3D0a/mfnYaDrbUkB7lBs8Ud2VHP6GPZJ6KbOXhzeLfobx/sLeoLCuDyxs5gpaYkpL6wM2V0EDZmvdmjxdXNjvTQ/5rkpzeffhdkudNRf8NSRLab/Zcjn52TGoulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV/A3L1eV/X0/mwChU/vlDrU6gN0pYnIA0lSfD427lc=;
 b=ZhahTbPGyV+FAEQP1u9eyYYWEOzXf7hag5Ucq9u8uQ29KBul8hwXyftWTqgxLTkKwuIcenKejfuuwzjfuAh8oqvDseT3W1DV63A2xaIRocUOgqNXTgmcAgz66ItCiNYVZKJaN4WYCLPubyoTOxYISS1ZR/sOaRvv6G4vHi9jBkuCVx0ScB5iO18aYZytWShfqdrgAMG+IQ13qAw59H7P2y5L+kAByyH8+n7rPp6ck5/U4whhgrarcBVaEmrUMoOnCTzRAySHo8H3mj/Hr6R2/0l/pxuzCI8FaI8sx5NN8a9bDjtqWh4zv0DZi2/CqgaSBDnzH0cKJ0Y74LsM+3qNPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5164.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:326::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Thu, 12 Nov
 2026 13:38:12 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 13:38:12 +0000
Message-ID: <174b3fcf-32ff-4b80-a33e-1c87d0585159@siemens.com>
Date: Thu, 12 Nov 2026 14:38:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH] x86: dovetail: Drop bogus
 local_irq_disable_full from __bad_area_nosemaphore
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <e6cbf1cd-dbf7-44f9-8956-95d010fff9a0@siemens.com>
 <87v76219j8.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87v76219j8.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0058.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::20) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: c450b478-edc8-4e8b-9078-08df40c23256
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|261028144727099003|56012099006|4143699003|11063799006|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261026140227099003|261102123227099003|261026121527099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TdeCczqNLR0t8Uvp2EsU4bENKyaEcOSfBr2KipVLIf04ITglIJFQx04m9MvSksU4AdCxH+2gHzdunqdDrAB9ZSGcUYSYKTBV5ZPOZ2atidq7FCukcJAb6qxGKSwVBZgf8LyS7PX+Mt7+NDzBgrdIqBpNcx97g1XjR253yqdSm4tjEFa92/Y8aFhEdeapOoFFBjd8u1W54ksDKdawuZOrepwwUMgYhXh4+wJHJ3ww73Bi3K4izUeMjvB1bOf+NGidRsiMwY9bgh9ttwOQThUZZ+nQ6+pJtYsfvBTdypkL4EbgAmwt19sDHKvIA9S50J6XJMihlMQ6lkX1w9z+VfQI+yhUEISJI2JCVHb3NGdYEOqYM57lAVBg5IX04LjJaUNvdoXWth13/p7i3tomr2yzO6jwoIFBdUC9owhYsgUNnLGhovWNsv//fDuuYxlAJm55dmg7wc8p8m10S+KB4LeHA66m1l2bV7TZfOf7rplzArVfJHFF1g1e/Pj09YA6wBeXGTNq7XOZCqsRiXyjA55grw3XB829eS47pJPRbXXLzbzngxwHQK8sov/P3FFSTxt8ITc13R8VA5o3K57PH4b2J2AysdYJMBJf7h48tjHRKW8PtTeV+X8sb6FbYjTBSNH6Act38N5Bg36fpcdfe6LYOrA53rEJLZlePVbsyVhfOfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261028144727099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261026140227099003)(261102123227099003)(261026121527099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlhxMlJYekFDdlpreWNWRTIwSFIvQ243WkhabGZvS2NlbzVLL25mVjRWV216?=
 =?utf-8?B?eDFwR2EwODlxSi9GUjc4WTVFbW41eGJzM3BwbEFsVEtGMGM0MytMUGtCMGo5?=
 =?utf-8?B?NXUxalNaMXZ6L0hjQnpTUHVQRS82OU43WThNbmhkM09QU1QxTlE0S1QwMzJX?=
 =?utf-8?B?M1VDV2FnTWVFN2JLTmdCVWJ4RVZUeUZEOWNhcjlNSjZCaWdSdE9KMkRhQUZS?=
 =?utf-8?B?bXg5b3p3T2ZGT1dGdEt0T2pFU29wS0wwTnNXUlN4dFBxWEhxeHZsS2FtNTI2?=
 =?utf-8?B?VlVTdzZ4NDF3OGllcWpGK2VmWDQ1UlFjUm9hcVVWRDMzRE9XTm1Vd1dVemYx?=
 =?utf-8?B?eUlLaGt0ZjZ6SjZTdUtoNDQ4WEV1ZGgvYW5xWHBhUndNdktEZVJsL0lFK2Fn?=
 =?utf-8?B?MkxtY2hab1lpclM0Rm53ekZaY3VYbE9wVmwxd0hBN1UwSHB1bUxXQ1J5VTc5?=
 =?utf-8?B?dHBjREFkYWhzUW1wNjdUU0JCTklsbUFsamhZeEc3Mzc4Vlh5RFk4RkZSb0t4?=
 =?utf-8?B?TGN5MGhyM05TWGdYYVhVSnZDVHduYXB1dWJGeU0wS0NlUndqOXFGcUdXTXl4?=
 =?utf-8?B?K3RoZ1VBWnNZdm1qekRZRHRRMnI0YnYrbTh5bmQxbWlvVEk1bDZRNzk5bW5F?=
 =?utf-8?B?NHBJL3AyZUtxUjlLWi92QTNLc2VIOVhkeWZvS2Q5cmc4c3VGQUpoK3RUK25M?=
 =?utf-8?B?MjRqSWplWGVCMlpiQ0FSdmc2L0R3amEvdWJNL1VjN3hwN2VoQ1ozRldXc1Bz?=
 =?utf-8?B?TWxwNmx4dWU0TkdSRWx1cVErRS9vTzhXWTVUZGNJOEJrRkNGNGdVTWwzMFQw?=
 =?utf-8?B?OCtVcVBLbThFWnJRMXdvTTNvN256bFpNY0wzalJJL3RvZzNmS0RDK3J0ZGs2?=
 =?utf-8?B?QU80MWJQQlNaVGxCaXp5cGZVQVh5OENRZmV5cGRhVllNbjY0TlVNQmZVMmpU?=
 =?utf-8?B?ZGplZ00wY1BVRk9qU3FVYVEyMU13dC9wS292dlMrWjlCajhnT3ZrWHBjRmh5?=
 =?utf-8?B?RE9TeW1qR3FCK1FUY2FWa1huSmVMaTd5Yjk4MXFzbUxzbVJOeSsxaVErSjdU?=
 =?utf-8?B?a2ZBN21ZRys5ZWUrMHZKL0VGcS9JRVBzVENIM3RsNXd4bkViY1ROdHNRQTgr?=
 =?utf-8?B?UTBDWTdQaDFiaFhDRVk0QkNHeW5CN1RkYXVySkk5eVV1Y2RaN3JGSXJwRytz?=
 =?utf-8?B?Z3FRM3ZxeTEyZ1BPc3JkRlh5Q3VLMFNRYmQwenFHb2dlZFB5RnJ6WmlUYTRL?=
 =?utf-8?B?QlBicysyVXBreERhVU56Z1o4OWQ2M2ZhL3BNSjlWcGl6dnZucDRoM1l3THJH?=
 =?utf-8?B?T1IvR2hJNlFrdnVOQ2FQU2NrcGdNM215eFI4Ym4zdHBRSHA5bStqUjhSWlpB?=
 =?utf-8?B?QnI5V1h1Y1hVQng1VHFWS0prbzhRN09laFprcXB4Rnh5T3NiTm1qTHUrdHR4?=
 =?utf-8?B?czBEdm8rejZKTThpeUlYQklkaVdtZ0owblhUY2JHSUZSUlNZRnNzQkVzNk9T?=
 =?utf-8?B?RzdaTDUxRFVLVTQxRFU0S1FqZ1VQYmcwVFM5RHgvaFcxaTNHUEVVZU9Pb1h4?=
 =?utf-8?B?RXhVamdsVGR3bTFLdUFFZDJnZTNFb0lYaGNsWWYwblJjM3hpOTc0c0lpa1la?=
 =?utf-8?B?S1J4VEFPTnBsQW56MVQyejNXQ3RkUWJDN2wyeTE4dVUxS1J5dEJja0wzNStU?=
 =?utf-8?B?d1ZOQWFNTUJUeUpOSHlXY0R1MmxXSXVvbDFqQUdjUThkaXgzRERSRnpxWVhn?=
 =?utf-8?B?OGR3aU1JM0RzL0NXa3M3eWtaQWZJT1AvWitaZnYvUFFLa2RtMUJ5SS9vZDVN?=
 =?utf-8?B?VnlMYU90K3o2NUgzaXJzZ1E4V0YwK3oyazZsQ2VxMmhSZFpicTV5Q1BIaDFP?=
 =?utf-8?B?RHNxZkZCOWlQMis2QnJxRlE2K3g1WEEvbS8zamNMK2ZsQnB1bmV1aUVJTDdU?=
 =?utf-8?B?TTVKb0dta05iTklFcXBKb1lrWnBacFRVeW1iQWZrRSttc1lpNjBudlZEdTFh?=
 =?utf-8?B?emRtVUN3V0phalBlRHo0WXVIL3RuTm5zZVJScFJoQUd1Ni81Sk91WjQwOXNW?=
 =?utf-8?B?N2t0R0NUbmxZVzdLcnhJVjhoNEFRdEdiaDA1dVRxSXZzVXBBUTNoeGZEdEdN?=
 =?utf-8?B?OGhZZGtXc3ZNY0lZL0tNcUxDZ0hOenBQSWc5RzZJMld3b2Q3ZEdJcHBQUTJi?=
 =?utf-8?B?aU1uVk9KNkwvVUsrVHdrNjZBNlR3TUR6OURrZ2IySnBCWnJoR3lkQlExd25T?=
 =?utf-8?B?VWp2RkUyNHY3NnN2NTE2Z2U4amNrUExSNFpORXN4TlBueFpuNWNpOWZRTzV1?=
 =?utf-8?B?VFgrQ0JjUllhaEplY2Z6U09UTWtsQW5IbHNNaUpqQmV6Qit2aFdYZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c450b478-edc8-4e8b-9078-08df40c23256
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:38:12.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQDYil1BbEbABieP5KNmuXPIdhxfh3tpAfPEBP/ZOOLMtAb/K16kDeFHxawuygtpXavikSIJ4PXlGDPH/cLDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5164

On 12.11.26 14:09, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There is no technical reason to disable IRQs here again, neither when
>> the IRQ pipeline is enable nor when it is off, which this change also
>> causes. We are never passing this point from OOB because of the
>> !running_inband check and jump earlier in function. The inband case is
>> identical to the !IRQ_PIPELINE case, and that one does not need any
>> additional IRQ disabling as well (upstream code path).
>>
>> The addition was most likely a mismerged during the forward-port from
>> 6.18 to 6.19. Remove it.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/x86/mm/fault.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index e41ed2092730c..e9a08a5d26e60 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -886,8 +886,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>  		force_sig_pkuerr((void __user *)address, pkey);
>>  	else
>>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>> -
>> -	local_irq_disable_full();
>>  out:
>>  	oob_trap_unwind(X86_TRAP_PF, regs);
>>  }
> 
> When removing such code, replacing it by an assertion like
> WARN_ON_ONCE(irqs_pipelined() && !irqs_disabled()) would catch wrong
> moves.
> 

IRQs are enabled at the point where local_irq_disable_full was located
(-> cond_reenable_irqs_user / local_irq_enable), so this warning would
always trigger.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
