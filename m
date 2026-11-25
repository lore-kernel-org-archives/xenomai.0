Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795605012;
	b=GUyHnFuI+UWzDLTNaePSUibib2/BiHSk6NNRPwsy627nQW/9jd1DdOgyDC18NpD8FyYn
	 7pQW5jvUtPb0BdobiYChkqtvdbw/uuUtCO7rKZFVUMSrxS1sHl1ica0aNVqt9AmlSuar7
	 FlxxNeVR911RyR5vDZ7XxjbdRC8tqy939QXy48YjH6OYL0G0YVsFEp/39U9CSgDaLyDSD
	 VVjiNwxFkL/fBhkNAsTo1J9dUzbUw/xuJQmSG147gD0fnnksUZsRM+AE14YefFEPTzUR7
	 VaMDlYihynvreYAPa1zqL8VlNuVADv02zCjzp1PlMMf8PGCA/xtFMN1DOcmjcuyqY2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605012;
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
	bh=wwkEQCOxPtUHt+sep/E0z7DsWZ415najyswIt7VYUCQ=;
	b=TQ88v45vvi0KbwkYqEonxTIfscbQS8mIC/XPlRsf/7KlIhnuxdJ0KjgkfXJdZRTMeaFr
	 RxZkKHYjDJM27kbYfBO90ksKLGUNVr71ehyUsbssDqit0FxskGs+oX+EKzAwCNQ5aH72K
	 3d+1LeSWIJ5lcCHXumlLZuyOUVlwNHprdR3AexZdSCtVMebmUnzcno9KzwsClJODpolLB
	 dV6p38XQUedn7N8wsZkmheDWE9WKRH5o+HjS/3UU0me7RWz79Y2qNxogB+GMtwjoo80AZ
	 1ujZ8jsD3SOWv7DHE8F4hCLVOOVGvJcX47WNVu8591r9n0wgRkdOvYcElt19ksG6aQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hijoxvDZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.68
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD6606A323
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 11:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86AD6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hijoxvDZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnRCwxlAns148MBlgFRpucNrHxOHDnEl2JDTNa0S2zLk3yJJKv9lbDqtTMbn6DlbrEW423y0Lxe3gCGgxq45KqR6kcGX+QKV0quY/a4NkvwaOI9D/HKD4xHuwNIDJ99rVRpqUARxrM7l1qugF0ZyrOBTfqFyW2uLRB84R6twGlRnyE0ySAkOLQ67omEf5jvb993m7wpnwNmJS/aTRObUWBTVGT/PqQukHx/GG5SsK5DUfYlGbJ2Rfq3O+bpIFuCUduXml42LDlVrwHoNhHUhyDgclNgjEwsVXpp/kep+/Ri9bQSIjp2mucpYC2dMnscFxLCz9AKOIfREPfQ2xnyUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwkEQCOxPtUHt+sep/E0z7DsWZ415najyswIt7VYUCQ=;
 b=i39cJPS3FnuOGOnqvvMfSXPhMc9D+s6UtB1wCAeICjXQzo2Z4vSZgMN7xamHxa9gBkZeD2dgCqnE9jU5geAkgDyDgyly4mOuBUuTF9yK0mBNXM89kY95YWQdNq5fQ/ZJfK4VzxzvphosV4UVj9b6F3oGbRA4hb7zQMopWEif7iTlin4rqCvZIE6Yg0LABnX7+/Q/jeYGgS4oimwJIM2c54JIMGwFwtyuwd9iAAf55Z0lix+Mu+lLc2DZjRR7SfLrAPeK8/GOJ3SNRYVDxpX3EVviRHK2LWS3ZH7YUo+KgAgYOCDu+oMKeUfTOGg9OyEnkKrHNvyS3j0ezhmvB6h3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwkEQCOxPtUHt+sep/E0z7DsWZ415najyswIt7VYUCQ=;
 b=hijoxvDZSpFUiNK4VMI1ORjAtK8VwdvVdAUkvv9W5GVf1rqe5ydDdVmxeFyVwl72dTy33rYetXqQh8o/SVyi9iEGYBm/40Nxiad/mfeiDIayEb4I50n984TRYAEPWRe/2+WUtWu1DujWID7PwTnEKDZbJayyA8m/ecOq6iW3a3/4b1dsON89aoisalKlXstZMQxXD2uYXjTfEKksjR5bQiEtSnDLb7/MYmQx/YoNPz4G05sgxSTo8+7Dm+brs77uUlKSxHcO8e5V4/4z/R7Q61UVndMJGpJ/W/S+jQuryXO878OgOdmcCxi2uGbytCztF610AVtzxNgcqIG26lg3oA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AMBPR10MB9239.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6b0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 11:10:09 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 11:10:09 +0000
Message-ID: <baf7839a-4b16-48cf-9f34-0683612aa6d2@siemens.com>
Date: Wed, 25 Nov 2026 12:10:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure.ac: Fix typo
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>,
 xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at, Richard Weinberger <richard@nod.at>
References: <20261124213345.2245315-1-rw@kernel.org>
 <907cbf6f-9277-43be-979a-c6ab0a030cca@siemens.com>
 <8e670dcbe9ce7d1107d0fb2a8e3055bd967b6dcf.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8e670dcbe9ce7d1107d0fb2a8e3055bd967b6dcf.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AMBPR10MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: dc60fae6-25a0-4b10-4cc1-08df4ae4aae3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|55112099003|6133799003|22082099003|18002099003|261022105027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|56012099006|10067099003|261021121427099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	quki2MP/VHcX+TmAvSMQFw3m+QJO6Ga0/GQ6DS4gyTw6x6zzfUY/oljhY6ZIuy3IMinNIYUi7o2u0kA5zt30VuQfWR9twGYHuGA3hDtKl/hHHBEinrXmjDZPQRwkdvpDaiBqXSTVUbMHc5Y/uAB9hdkZe9tf2mW9yNmbi84nbMpK0r7y4uK1BJTPRoF/gh6QD1kdX6YtE5rXXiXl3JSNIqNOKlHCNzxlmVqwMe2zje5bou/FvhobhhuQurqVaNGhkFJxa4FtvVso5e0QBY1Chxoih7+4U4oK9jfCs7cE74xcvHYIZJa9/Gz/iqQELerjfS24XP4SU+Af5vvO+/CVAOEaVf2/hNVObaWBG+hY6oLe1fVBNO1z10IBWLdRflqdWdYwhomx1w7OIGDomoAk1DOH+K6f/u8lUFmGp9PJNWTPGtTKHhsf5YniMiVnupmGPQV5sVkP4KfjaKdDeXcTD6O41i2+veZcpl3F6uu/2EQOJNjxOmHq2lhE0/eP0zDVnLsyOYBVtpXSnj8+0CSE184xH+unS42eFt0QWdq1f3shjNODsHK8J5jdG3EeqOl006yBauCVv0B66PyUo8U77b4QbENtg2ZX0IzS6AfijtuADKvABwKr/mX842PRw+hHTJRdrSLpeIWajX5IIsAIi8fBVrVeR84queoquQ+vg74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(55112099003)(6133799003)(22082099003)(18002099003)(261022105027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(261021121427099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHdzcmxwOC84VHlFQlBhTlZ4K1NLTURacC91ZTlWU3BYc1U0d2ZoTXZwRXFF?=
 =?utf-8?B?Ni9ZR0J5dXBIUW9CR3pibmExOFpDYWhrTks5VmJ4dkxKK3dxZVBTY3l5cmFC?=
 =?utf-8?B?TGVHUjFCckNOeXlZUlZJcHJYb1RRSmpwUHRQbEVaWUlWZW5HbkZGNmEvRUxU?=
 =?utf-8?B?aWNFTjJOdW9MbHEyTG96QTBmbmdCMUJMUWlGakFuWjExdnM3N2RXdU8xNzhh?=
 =?utf-8?B?d2lzdTFBMjNQKzBaeldhSjB0V1VKQzd6WjBxN294aTZXVnlPaUFaS1VvUW9r?=
 =?utf-8?B?eWM1cjhuMmVoc0R6cTNZcDIrbGlYLzVrZ2VqbUdXblhVSEM1TE1QWEF2Q0Nr?=
 =?utf-8?B?WldPeDVRTzR4d0pCSGtqSlRYb042VGw0M1BuZHQrMDFvWkFQWEpjNW02YkNW?=
 =?utf-8?B?dVZmaFE2UnZKU0NhRW9UazNxdHljQTRVQ2RQcFZuaGdzMGlETFllc2VMMVdw?=
 =?utf-8?B?K0diMVBBM2Rwb0RkRlkvSnNzeXBIUGI0d3R2d0RRWnFoQzhnZ2gyenh1TVdr?=
 =?utf-8?B?NUxMbGZ5V2FuOFRQNURrbkFsdDNDaHlRSzNaWG91TlNqR1AvRkVjRjNDeTRJ?=
 =?utf-8?B?UTZJVkN3bnNDeDhNenlRTUx3Mm5DdDcraExMcjcrY2hlbU9mNFpKTmorTXNQ?=
 =?utf-8?B?dkZGUzJlaEZCeEMwMDF3dEJVL0JDQUpaRTBpQW9WSDJZL3dVcG16aHBFQmhW?=
 =?utf-8?B?Q0NsYVI1Q2x1dk1GUmJYQStEZjEvRlJjVmdhMElweldKamtvNG5MRTJHUENn?=
 =?utf-8?B?c2xZUXZUbWhTNTllV3F0V295QzhDdjh0emJWVXdJNEhXejVob1piUEl6QUFX?=
 =?utf-8?B?QTM5d3dXNERlMk5PQ2JEL2VzK2hJZEU5TXFubzdQOGMzaDAram52cjFPUURx?=
 =?utf-8?B?ckV4M3dIMFdWeWgzdWFaL0FIR29Zb2U2MTZuYkdhMGNYYXFiRHhQcUxWOWhL?=
 =?utf-8?B?Y2tEdzNISUoyVTIwU3UzYUdtMWNzUU5ua3ZidjZwaWo4WTVaZEY4OUxkSHhk?=
 =?utf-8?B?VEt4c0NZblJsd01OZE94L1pMVHZtT3UzS0IzWTVXTHhQQi9jVERBZHVyaUFO?=
 =?utf-8?B?TXdHT0FSWXdXbFl0c1ZLMzYxcmtFRUhQUWpvVThncGxNV1hSZ1BKWnFvNGFI?=
 =?utf-8?B?b3Nodng0a0JPT25WOGludXdZbm5XaFZwWCtMSm5CdXI4MGc1TjlrYkFUL0Fu?=
 =?utf-8?B?VlFCTFhvSUFwQ1NLSFpEZWtIZVlYdHloU2h6QVBkYVNlT1B3bUJBTmRFRDhF?=
 =?utf-8?B?cFNqQXpoaVB0NkRrVGU4clNJS0JaV1BQZ1FZbzBGY2lHRUhJc0hYMjZlYnNs?=
 =?utf-8?B?VW1peUdIRExHZXZWbWd5ZlYyQW05SE5LZlJVSXhtSHJZV3FOdmVXUEh3UlR0?=
 =?utf-8?B?SjFBdURoKzJzSjN5N09xWlBFSmx1QTZmS2tsUmpyRUdzUmZaYlBpR1d2MEwx?=
 =?utf-8?B?SUhXQ1VDRTUxMHljNVZFNExONXFJN09HekJQejJiSzd6WGo2ZWJBMjYwaERS?=
 =?utf-8?B?WjUrQURKTGlIMTN4cmM5a2VHV3dPMzdLdWl1dlp5TzRFVlZDejZ4SGl0T0N2?=
 =?utf-8?B?N04wa1U1YUpVdUx3WWgzY1J2ZkI0UE56MzhRbkNMVVRHTzhYZDBvVzlOZ29Z?=
 =?utf-8?B?ZWpiVDUxMFdodlFXcFFCTEZZdU9KaVR3dS9yN1BWZHN5ZE5xMFJHUUVNS3Ey?=
 =?utf-8?B?bTR6UDA2YVk5V24rYmR0alZ1cDh2QVFSb2c0NENtOEZuQi82UDczcC9WdHlB?=
 =?utf-8?B?NG01OWpVTlRnb0ZrTUZ2VVkvcUNoa3dlK2VlRTJBZHNrd0FhNG9CWFZ3Y3RE?=
 =?utf-8?B?SHh5Ti9ZdTdqSlNoSXJJb0ViV09BNS9mbXliK0NPeVJWQ3g4YnhCS2xTSFRI?=
 =?utf-8?B?VkRJVHBpb3JMeEg1MGZQbWY2THZVTVlEUXYrTy9FRUI1VUVtb1M3TmhWdWpS?=
 =?utf-8?B?RXR6eTlOVEZUU1E3RElWWXExZk1TS1J0MncyTFV4QUlibWFyTTJOaGdYc2lh?=
 =?utf-8?B?VlRSZmNNTnYxY21EUnJUT0ZVemdNMS95YXZQNVNJZjhhK3lkNUViM3E5eU9U?=
 =?utf-8?B?bTVRNWxNSWpWZ2xhNHNNaENkcmRld3pDNU0yMWFJSVpTME1Ob0NrL2dZYWJH?=
 =?utf-8?B?OTNWT3FWbWVLakVodWpjZG01aWg0eHVHeUlBTTNPandvcVlOVm45bzh3Ny9K?=
 =?utf-8?B?YkQwY2RCVVNNRk9OeEFRL3lhdDdQTXJ6WkNzU0o2d2dWUy92V2diZnd2bkxa?=
 =?utf-8?B?VDMzdDIyd0MrbkM3ZGNxaDBmc3czeU02RlpiSHRCU0ZlazRqMFlvV09rRVpK?=
 =?utf-8?B?ZExiencwaXhKaWQ2NC9nQ0xUTkFxbkRsSFRNaTYyYVVSemNGOHo4U0FaNUx0?=
 =?utf-8?Q?B1e1iyJ7SNObhooo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc60fae6-25a0-4b10-4cc1-08df4ae4aae3
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:10:09.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rQRz0WT/Tslf4L3Nrndw9E5w//xOHg+3M7V+hgkJ0OzkSY89IkVvVSnAdzMRshyQ+5jhQoMgjjYaOtuWATtbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9239

On 25.11.26 10:13, Florian Bezdeka wrote:
> On Wed, 2026-11-25 at 06:45 +0100, Jan Kiszka wrote:
>> On 24.11.26 22:33, Richard Weinberger (sigma star gmbh) wrote:
>>> From: Richard Weinberger <richard@nod.at>
>>>
>>> It's XENO_USER_CFLAGS, not XENU_USER_CFLAGS.
>>> With the misnamed variable, xenomai was never built with -O2
>>> on my side and caused funny performance regressions.
>>>
>>> Fixes: 89c1436b3 ("configure: Propagate debug build settings also to plain applications")
>>
>> At least no stable regression.
> 
> Shouldn't the optimization level be separated from the debug settings?
> -02 inside a variable named XENO_USER_CFLAGS_DEBUG looks a bit strange.
> 

XENO_USER_CFLAGS_DEBUG is not simply appended when debugging is on, it
controls what kind of debugging-affecting switches we inject. And the
optimization level can affect debugging, thus is kept here.

But that has nothing to do with this typo.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
