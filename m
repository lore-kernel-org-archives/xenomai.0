Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795614067;
	b=dWSu9xkkQdn/3E/OTAWzdua+K5AVLf/ry6jgGQnGDd7i5CGgfzlUddSiiY606eHFMQgz
	 DRgtA0y4qKm6ABxPG8qVLB5guibdDGvCmsgkN3PWNqELaQdGn/v/5n2lNEj6//1coTKvh
	 iyDKZEa/SJzYoNQbx1OEkGw3cf/ydaQG1pCuTxxtn1S6nlCyUAKFHOVNpUmDAZWVjYAbx
	 fR8srbEzTxmB53QjoEWpAV/jx8Cg76UQWVLgSfzuIkrWkyIUQ4RSwCQDE5NUqClMSaVtd
	 Fm/d23cDDXkF1bZ0OpXRWnA5yv1I67CGFVvmdz3t2llmNIZ6jFTTNE0jt1fIlDWLcvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614067;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
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
	bh=9g10q8sX75TuAg+wv0SmKHZ0vIqIZRc88Wa16G72/e8=;
	b=hSyZnGHLt+Qp6NdKzlUlIDMK0EVhbtotlU5KWGjOP/2iYdBhkPxvyV/tiZeH6xOJO501
	 Aalbnn4wSPklWxwxVMgPnMJ9TsbhpbS7MFZU7IfB8J6ryUBy4Ht0aHzrYa2jRav0+mvCt
	 md0AbffM6KBEFbHf9yaU9mLNeY5IwaMYFkFyBYNyeLim/83D/MGE29tQMwDzKn/N4lZwm
	 Q1K7+wkKg70YKXPTRPwOI2/ATyp1UP98FmO2617oK8GrTigvI0agG4s4jRdtpWGra+oj8
	 OJk0ILY+6+ZoPO9BpqVx/9f/dFUwWyJWCSYtsQf/6laJaHUaPY/BrW2ZtSzmBpshdwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=LaLBt9oK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.34
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70E606A31E
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 13:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C70E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=LaLBt9oK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3OGFU//vug10sqYoQVjyJdG0CKvDvusHO4SpzwnYGhZVePhTdrrIT919i6r504th9yjBKWeFw77qxK8HrdK+1Hn3dVE5xDYorIpDactF58zgSHbXoEE75iEVDzYtpl7Fwg9dMJiRhZoK6KuX+eE1METJclWzcwRfDSRJ7tUUK+ark5nS22BXxeE4Xt8fi6JqgoTAXF9WWSr54ZHoNJXcB02narIODYCPTaok89CprFO9z+OtgvqQYeL5Ee5KF+aPvsCKZ5qAMi9pmICQi4GoV4FLuGpdYIN0CFgCfoIK+quRy69xXl6s/T2kKIrOof/Shltok8nvNed+WqFgQACGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g10q8sX75TuAg+wv0SmKHZ0vIqIZRc88Wa16G72/e8=;
 b=E6nAJv1uJ6J26SXJC+4RaoIxhqdk9/t+N5LdbZTLvHIeoq8xaq8gr68oLmUsbdIuyjY3nanQmoDiFDRuJw6JE8X/xKfmG0jyet5JPFsMGCAgD7rPGHwPWhVIAO4WjH3bMHPIFtlsgUQoX13tqlKuHnRHu8S/Peki+PI69KXoU6NEd2G0Dv+9gPuHYA8TTfkIY7O1KzKW73DDX2EwikXNbZ48xbv6g3lPZZ+vnCYZaksPFVyWgqz2RpymaQ+jQjwYuDGkC9M1zHTpF9KGgZ8p1Ts48wrceqRbT+jS9lLkT0l/kF4YHDhZMxid2BicB8caJNZ9GxoBGhehzbMSPOBpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g10q8sX75TuAg+wv0SmKHZ0vIqIZRc88Wa16G72/e8=;
 b=LaLBt9oKMsjXUtLFq00JbVvEJ2njTmRGBM3oc+WsYU71rpAV//1R++hMBd4UmnOA8cDwmFDHPC2IXcp+eDFNZSpJD200lfi3cxghTTZ2JQohoRGKByO3G7xFBrcQzdahdP7pvIUuVSPtYrER0VKVPIchkdm2nKjwcmDwM8IRdZYv2H08E02xVCvV4DCP0eGW1SoseRFG3XvSthyoe4JWiwWiJ+vmG+sffVYDrlucMAewjj3B5HDWAh6hd0KaPscqmby8vFgFFAuaocrn3pnhmXQqxW1uEWvwRZWT69GluHqokUTMj+z7IErzjdklayRfKDENa/BH2uJ4+f9QQu6hgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DU4PR10MB9166.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:569::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 13:41:03 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 13:41:02 +0000
Message-ID: <66206a01-1ef6-4c4a-97d2-51c0d2b23109@siemens.com>
Date: Wed, 25 Nov 2026 14:41:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] lib/cobalt: Select the time64 vDSO call without
 __TIMESIZE
To: Yegor Yefremov <yegorslists@googlemail.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <20261124145144.3411177-1-yegorslists@googlemail.com>
 <20261124145144.3411177-3-yegorslists@googlemail.com>
 <781b970cdfb894f40872da68e4f95dbe3dbf83c9.camel@siemens.com>
 <20261125130728.621987-1-yegorslists@googlemail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261125130728.621987-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DU4PR10MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 029870f5-adb7-40bf-0588-08df4af9bf0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|5023799004|11063799006|4143699003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|261026121527099003|56012099006|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CT9qTzKoFHLVSy0kz2mJuOv+Vm7f5aT3hJGcvXbBU91MOJXFRDuZZx4ur0/VOTPqeYq6DmtAk4hkM/dqRNyx39Xjwi65xhJtbR32+iLdRqWe4uyYJlbtniQLdYLyzHuDK7Tj8dNDXZ3rL8KK2tC/dieJtRMhEVP94182dAG+631HQMvOZz8zw73q+R82lx2hZ+Py47ZQ6I2ykiuUEG2kL2JFZDhV8cwxoQWMgOQ+T0fJ3Nchgyiiss+w48f+xhyJBXojdijQbM/z4kq0867iq7wp2fOeQV8GkMqj6tm1HS5D+QHPy0wm0Kw58Sise2UnobIQ5JFvdWUoKrDIQoRpfioqfltMy1cGe7vD2nPEfcbXKmJEavPbA+Qr96qAjJDO68aZ7d+qj9kH3wGRirDGm6PDozw9poVaaO2VMnkd2JMww74KVHGnhyhivKdB2Qbz4xfYdxV8bp47IdIN7y8UIMse6hwduuZjtaGs1r4daalXrDN6Z4GTz1py+A/KMrC9UnBXApncivfbczC4/FWzrrJMZkgtFtLpSYChNF/FMm9MIFLYnS4AKOo5XDzwxkjbguRTwK3OZPn+5aEXyn8tpG0fR85Ye4jISxc+2PgvDsfANcyfC9r2adSg2ePKgu2oRENuJBsLfe1RCoDnbSW35Pwb4qOzZLlm0cLMjo91FQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261026121527099003)(56012099006)(18002099003)(22082099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGZ6ZVpVcEkrdFNocVdtNndEaWYveGVJQnBrYVdFbDZJeW90bXVjZ21NR3dR?=
 =?utf-8?B?UFQ1czJkM3pwSHdzRlJuNEZ3R0FTdjhkKzc5WHVJNjIrTnc1U3RVUjY0c1hn?=
 =?utf-8?B?OGFOajZyRjViZHZjaDhPdGR0M2pGT1FlSkpOeDdERE9ZdWtYYWJ1NHpOQnVB?=
 =?utf-8?B?RFcwM1BwVnNRT1AvblB6WWZXdVhwNFI4aVVjVFgycmNxbk1iUEZRMDhQVG9x?=
 =?utf-8?B?T29vYzY3TjhXUnpaMXlxVHl5L3J5K1BZSXdmMDE1ODFSQTRFVlZJcnlHQS9W?=
 =?utf-8?B?WUpIdVVVUUlmQ2MySDN6a0lSYWF3ZnZLRUJvK1NmbmdTdGdOdTlFMXVYcWpF?=
 =?utf-8?B?TkdnTFpYZzYwc2svcXJ1WlhzbzQ0YTJxY25xeWpMYjlNOG9XRjdodnV4WVRL?=
 =?utf-8?B?TVhqS0x5VTd1S2xiSW5FUFcyNkl5VWg1dk1rTjdrbkdiSkdjSVYxeXdPYyth?=
 =?utf-8?B?S3ViQmdOU3hWSlkwUGxwai9zNkFqbjFGaVhCekpPcVVGanRSRnduZUU0ajhz?=
 =?utf-8?B?Q3M5TDZPR0hhZWJaVG9BRE54TlQ2dUVsRytEb1NtbHRCWGk3WUJLdVA1VWpo?=
 =?utf-8?B?cUpVSlAvU1dWOTk3aUNVczJOSHdyL1ZJRFIvMXI1cjdPeWttWENiRk9iNFZy?=
 =?utf-8?B?aWE0ZlpmOGRPeWZZOVJVTnJQWGtWVXNYNTJ3OVZwVmw2aVlyK00rWHlyenVy?=
 =?utf-8?B?YlNoMkFtSFJET1J0SnJBcHJKM2g0TVdBNlpQRk1NMlFQaGpwNU9NaFpDMzdy?=
 =?utf-8?B?YXRlZU1BU09Sc3NydHc0bkFjMDJBdDVaRStmRytjbjFrTnVoNlN1bnFTdFdC?=
 =?utf-8?B?RkUzTk5pVmpNQWVUb1FSc2hYc2xOZXphQVNGcTNNT3RCbng0TVpXQks2RWZK?=
 =?utf-8?B?ZWdOYzZmdER1M0FZUW9td2V1VVpJN3Arc1Jhd0c3aDBJdzFqRTkwbzVRcnRi?=
 =?utf-8?B?TUNYV2FQLzgzV2VZMUVCeFpuN29lUVk3SnFjY0hiamplN09IQTE0RDgvNTdM?=
 =?utf-8?B?U1ZpNlNDam9OSzN1dVphOElIcWc1R2dhaFhEUG1qdkdIdk1SNVNGZEpIUTNY?=
 =?utf-8?B?RmdsUWc5RkNiZFo2cHVENkJzVS9mdDNTRVE4STZtc05tdUxGOU45aklGYWI2?=
 =?utf-8?B?cVRkN3Q0Z3hlSUw1Y0NkZTBaTXRsdmp0d1JQSklVeEgwdVYreWwreUdzUms5?=
 =?utf-8?B?TEo4VU04UVRVcTR3U0M0Y21qbjd2Umt0dW5WUEFMam9NYkJyZytBN0JHNlUx?=
 =?utf-8?B?VDlOWmR2aGREbGF4M0wxRC9aVTJwU29aUW16MnVKOFh2VXBldVRYRTJ0ZDcv?=
 =?utf-8?B?N3VPRXlLUFg3NStlemkyRytaNzdOeHRUbkNtV01MNEUrbzhhU3lyRXM2K0tI?=
 =?utf-8?B?MThSekdqWmlYOFhNczFyZjQzTmxPYmgwV2FaOWdveVdnWENhMFlEQ1lMbkQy?=
 =?utf-8?B?TmE1MysvMk8vRnFxTUd6ZXVRSXZ2YU56aVF5MUJEbVN0OEZCeUFhejVjbEd0?=
 =?utf-8?B?eDZoRm1vejBraHhUV2daZ25kaURBOXJhMlQzQmVlZGVuZ3JKRWljbU5jSnpz?=
 =?utf-8?B?YUFCdER4RzZnSDlrRkxCVDM5cEhOcVR1OEpicExvZ2xhNVMrM1R5YjMvWXhR?=
 =?utf-8?B?T1A2NTYvSEJFV1RvaU9FT25pdHByUmVET0Y2Y3lPTElmU3pDNzhqTGlPNzdS?=
 =?utf-8?B?TlBFVGd6OXhRKzRXTC9uUlZXak1jSG9QLytuZFZKSHdGOEl3UlVGRWlDMEdw?=
 =?utf-8?B?Y1dRbllzZjRYVm5hbFd6Yk5TeDJCb3hEd2ZyY1dzYlJpSE9UY3BWT1ZkYjho?=
 =?utf-8?B?QUYrQ290cjBENk1SZmc5YkdGUUlqNFV5dTR2T0hJSFAwWmZwcFVDQTRFVEdt?=
 =?utf-8?B?eExzUVY3Z2R3cGwzalhvMnI5NFUvZXFSdWxVa2hGYXJlaXlIbmJHWnozTW83?=
 =?utf-8?B?UXVLNFVuRWNDQTYrNjBoMFR6Sng2UkY0VkxabXNjVytPTTNuZXhSSzFEUWZn?=
 =?utf-8?B?eFl5Y1p4YldNY3ZDR2FrYS9pL0xpdUxITEU5QkI0aWVnMXRFQUJtU0NsRkVy?=
 =?utf-8?B?R2llM3ZyUWtLZG0rbXl5MVI3cS9DYzl2QnRlMnFVSG9UNkxkdmZtVkJvaGwx?=
 =?utf-8?B?QUdWM2ROQ3JlS2JzRWpzakxuNFQ2TlEyV2d4N3c3bmdkVFlUN1RycEpFcFdm?=
 =?utf-8?B?RHIrcW1VSDJpZFJKaVlMbDRYRUNuVzlSVlNPSERnNi83UWtIQWwwYjlBY2xU?=
 =?utf-8?B?NGcyR1E4NXN6ZDZra2I0UnREMjJVRXZ2NUtHaTd0NDVaanlQOHNvTmhURWpj?=
 =?utf-8?B?eW5kV0V2VzIwdnFsWUVhenJUTWhJRFVJbVdmN0hUdGdRcVY5L0RKdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029870f5-adb7-40bf-0588-08df4af9bf0c
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:41:02.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyQ4lDQBFjvlU3VIfWgTATMuEl/JtpW/aEGMZrqSkOaVVnobhafSkGLVMkjXamBd79/37uzON6naI26kSSKgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9166

On 25.11.26 14:07, Yegor Yefremov wrote:
> Hi Florian,
> 
> On Wed, Nov 25, 2026 at 12:44 PM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
>> Not sure if we should really rely on __SIZEOF_LONG__ here.
>>
>> Anyhow, we have more usages of __TIMESIZE in the code base. I'm sure
>> this patch is incomplete and further issues will come up while testing.
> 
> You're right, I went through the other users. They fall into two
> groups:
> 
> 1. glibc symbol redirection: include/cobalt/wrappers.h,
>    include/cobalt/pthread.h and wrappers_time64.c:686. These are about
>    glibc providing both the 32-bit and the *64 symbols. uClibc-ng and
>    musl only have the plain names, which are already 64-bit there, so
>    not redirecting is correct for them and the glibc-only check is fine.
> 
> 2. Kernel ABI: the vDSO selection, the select() wrapper
>    (wrappers_time64.c:771) and clocktest.c:89. On 32-bit uClibc-ng or
>    musl with 64-bit time_t these are all wrong: the clocktest calls
>    SYS_clock_gettime with a 64-bit timespec, and select() passes a
>    64-bit timeval to sc_cobalt_select. The time64 branch of select()
>    also falls back to __select64, which only glibc has.
> 
> So v3 would add one helper for group 2 and use it at all of these
> places, with the select() fallback picking __select64 only for glibc.
> The syscall selection in wrappers_time64.c (XN_USE_TIME64_SYSCALL)
> already works this way, as it checks __USE_TIME_BITS64 without
> __TIMESIZE.
> 
> As for __SIZEOF_LONG__: I found no libc-independent alternative, as
> musl only defines __WORDSIZE in <sys/reg.h> and <sys/user.h>. The case
> where it gives the wrong answer is x32, where long is 32-bit but the

x32 is dead. And Xenomai dropped in 2021 (3.2 series). So it is not
worth bothering about it explicitly, only if there are other, vivid reasons.

> time syscalls are 64-bit. I would exclude that explicitly:
> 
>   #if defined(__TIMESIZE)
>   # if __USE_TIME_BITS64 && __TIMESIZE == 32
>   #  define XN_TIME64_ON_32BIT
>   # endif
>   #elif __USE_TIME_BITS64 && __SIZEOF_LONG__ == 4 && !defined(__x86_64__)
>   /* e.g. uClibc-ng, musl; __x86_64__ excludes x32 */
>   # define XN_TIME64_ON_32BIT
>   #endif
> 
> Does that work for you? If you'd rather have something else, e.g. a
> configure check, I can do that instead.
> 
> Regarding musl: I confirm the build is broken there independently of
> this (error.h, off64_t/open64, the *_NP mutex initializers, ...; see the
> v2 cover letter), so I'd keep that separate.
> 

General remark: This reads a lot to me like coming as-is from an AI
tool. Those are often beneficial to use for supporting patch development
and specifically local review, but I'd like us to avoid pasting replies
directly without marking what came from where.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
