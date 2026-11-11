Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794418875;
	b=gCWxQHDlgsHL9XQE6tE628H1nm0Pst+AfNTeewQUZHcujMt1ub5rl/xRYthdieqpxqWy
	 gEdkr7pqNe6+Pru1tsP/sTY9z2N1dmtifxQxN8VRJq6VnQeAu6En7WPvTE2NKqAVg9F47
	 qx89o2EJ5Fu2w0NgqlCbC7jfZakco7R10LpT3CjPB3zrO8yXEnVagQ1ut/4SQzlccf+Zv
	 +EI9WVVNpqJYDB3pahMtS+ogj4l23aFSVcJ7rdqL6sc/ZQi7JoTXWYILe9rPTxV8eMFSW
	 F9/C6V0nBho3/hBSHIkVYvG9fsX5TQUt1yuJR8eAFZnCbFBmaA8PdlbHRdk6+y+SY6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418875;
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
	bh=NUx9ezmfN0o7NoaYm7PyBBwPKMONzLoJIt4YBmOG0Qc=;
	b=ZC/fstqxd9FDRwa7H38FH1KlR9LogJscFcehpXMArXjYO9egK7e9zJvGjhybGJXcaXrQ
	 2ZbbSzllO0BsH4sl1Ae+4HrwaGn4Bnifsv9EkLIOJKdBKy7P3kQT/3fNfIwFT5YxHJKw0
	 g5sj0i8IL9gleFRXHNVw3DnF8+xfIxUwNyDyqPJ21+c18FwTWHBusyLtHn1RAU3saOJF+
	 s3HUAzET6J+ZhE/df679zYSjcNs+8WlpwmdzQhWMbxdzNQ4HOjImNOTWi5S0tkD7qbbQr
	 Ro4oc/YBiMovPC8wmwh6ix0bBooID4gm8dK7iL8367izys46y1A/q0pwOGAkilwYrgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=G6NOF2bT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AA606A32A
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 17:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C83AA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=G6NOF2bT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obbL0Wx80Z83L+ebDRRjtcapAR0+2WNjAZYnsMYxzQyqT3z4IozU4Xk2bh6UiNqtQ15bv+Zgv1hbrl4r72ZNg5FcUqq9H59wkmry6tWBb5x9mL/p5+aJJttBinhMehaX5FRL6xbIqbjlC4Wt1LWdRxX0leK21cbWKs9EpKt7sdZpFjpLImnFLIHC2uIQOA+jyThmPEzXdMCXqMEnwsr3I3rxph1WsCH8gFr45n+T9CcGGheSNl4u/tsYNzeCRZR8qVsEbN5TUMd6JVbR5HnP0GClMy7ehXYreJc6gIFqlS8ryAzdHpdiVEBF2Uy0QArK14XHvlRrTEKeFbiwaDLnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUx9ezmfN0o7NoaYm7PyBBwPKMONzLoJIt4YBmOG0Qc=;
 b=i35qd4nXiC9BZQYeiB0WAj58Du2C8l960sAo5Y9ZVf9wlQXiJqIcjz/lUsrBkvAUApoJBhSmp2/3HN4UXS6k6K7UAC+wFsJC4xTBFxWAruh/XWTF9Dinog3ipLXwv9ZYQup/D0HNoVjHwib+4h+1lhAu7NZCJI6U33FnkbP3aJ/cbWJMrGnClBtfMchnPorduFLaUY0dzzUjagn8cjuwT7sVa5qKcjisS/v7QhfPOELtR4bBH77njoKF4vfqgkXUZQ/aWcKmTfY0HMphfAoAc/mtJ7CX6/m2Xp9GB/8+/rwAL/HruN/4nWpWtbV6L4zlu9fp5udhb7jGj5RMwaPbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUx9ezmfN0o7NoaYm7PyBBwPKMONzLoJIt4YBmOG0Qc=;
 b=G6NOF2bTJe0va1thqoafvUnB6kZ/K9sOm9tZ/N+jtK+sPmUrPvtkWG/bAZ5J1r5nNmryKZTdUcW3ZVx9c5s+L6kPJp2+28Vmc4F62oz/AivFx0t9cO49ZoWkCUpSybaTRcdnVmikRS1ft7wwnWj1XWTOHB3Nu3Om0TXzzOozw4klcpFlhHJdKve+/WwPQlIIaTOBM/17D+rVyntyf6OqBYvn7BtGRcFFsnL71ejVAIVILMZB6I8LG7vIc6Q/S+UcRSeqZRXBDl6+ocfXKRWd3XVQnw6EUzqyfYZMSSEGf1nfRs7QZAegjpfpxvl72P6curEuDzrDM3mIhhSEd45MbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AM7PR10MB3874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:14c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Wed, 11 Nov
 2026 17:41:12 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:41:12 +0000
Message-ID: <dda83d6a-554f-48bf-8f00-5d1a1deaa82d@siemens.com>
Date: Wed, 11 Nov 2026 18:41:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: O_OOB ABI
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <18f772e8-118f-46f6-963a-58db46724e24@siemens.com>
 <87v76346l0.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87v76346l0.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AM7PR10MB3874:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ca1530-f88e-4a18-2d1b-08df401afa30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|261021121427099003|10067099003|261102123227099003|56012099006|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6o27cLLAjscftc9LQKloP7w6WdpVdCogBbi+uD+ptp1YqqE3fo1KhFVJbw88e95KN+H42zuJt1A8SfJ8FS3hEHRJagHwbfdW0xgzflSjX7Xu5F6FHd7OjHxv4j7zy+0q2Fcaq8KVUfdgANORI8r0vOm9hp1DlUJ8yWBVlIVufmsDEaSSVMnizJ1l+IsHjRmXXAi83wAik6umhdnZ6xwfyf7ePNwicWxvp7cbOng1Xqj+tfn3Gq3WZZIk9Zet8Dh45yXmFVMWNHbWWAaXbFt1uJlbG5+41QwQBiESSMIlEqIgBfvkQ5OLIEgkjNWNeMl3esG5UnnwHz3O7H+Nr3ZhtxExRiiI7ofbszTGyZCbgjcQssoFSOObiuH1CEUx2nEb8f4kX40zA6FcvqVkSmllJftpc0/R4CbpNrSHQr3W3GmenXWz1/hHNAhz4DJcs31VUSOgEF7XojNAM3m4I86U/oJGEmY0EQJAOSRWV6p46yklDWvYUHhRokpy+EeN4HilGqwN7zA1KqElsGcnALFCk739NtTppjc2zuPQeBGZgC2AXUGhwTjqTeVR1hod8I+fni2N1IfvM0DSC4wf0HJ3mqE1Q1Oe9flaqkjzTod9Qwy8Yu3z8/AXu0ggk+GSPrZjoEeF0uOMkp+v76H7plfCRtw7mcksa7ZCgFQ/BySoVPg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(261021121427099003)(10067099003)(261102123227099003)(56012099006)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFIWkpXbUtnd0R5bGtyMTgwVHBSblhoU2tkYlhUSm5CWU40Nmw2YndFU1dN?=
 =?utf-8?B?eG9ZdVJxR3M5UHBPaXluRVkyVnJ4MXNneUFTOVJ1Y1hWbnZ2aTE5WXROQkRF?=
 =?utf-8?B?TWlnS1lORmcxMjNIWE5FblFqd3FVaTNyejhhdU5XYXVILzJvc3VIRFVtQ2R1?=
 =?utf-8?B?a3NlNnVNdlBpQkoyVU4xdnhBeHIrREFhd0NOTzh3empubnQyVTRLRlNQSEQ3?=
 =?utf-8?B?QXg2cGt5WlpvZ2VLSzhvbzFXc0F4QW1ZMHhROWhaaGxmVFk1ZytibUNUL2lV?=
 =?utf-8?B?TFM0dk03ZjB0bXY0VDQ0cTVRSDE5azNac3R0QUVFL1UwY28rcGFQMGt0RS9s?=
 =?utf-8?B?MUhkNlltWXFCUUxFeENERm8vcWoyZWdLTHNkWndIcXZsbVB5Yk5VeThZVDlj?=
 =?utf-8?B?RWt6cWJFRGVkODd2UkRGdkhselRFQ1c2RWJQNm04N3FieXJLa0hNNTFUSnRY?=
 =?utf-8?B?dExGaVZ5UjdjN1RpN2FMS2J4aC9qYWRFMUN6eVJVSTk2a3ppN25MMkRMUmVW?=
 =?utf-8?B?Tms1by9EeFBjek5DY1FCenk4emhYeUowNmpMUUpNb2s1Qmk3Uzc3TGRWK0VY?=
 =?utf-8?B?bUdTSFdmZDlsUGI4UHRLbHNMOGJKZ05YamtaenZySTFCb2tJYVF2YjRGTXBZ?=
 =?utf-8?B?ajJWRXJQVzBheEFsVUQ1bHlrU2xNYW1vaHdnbDRaTUtrL01MaDI5MkMwRjNG?=
 =?utf-8?B?cG01aThvRmdtcFBnMW8zYUpzN2pjQXJSb2FLQTVrVDRXZmdMd1NTQy8vMGhF?=
 =?utf-8?B?ZUVYay9xRkR6YUFtZHMzaXd5VUlGTE9UYkI4UU9RRjVIQUJjd3B5OGZaVUsx?=
 =?utf-8?B?VWs3UW13bXJqS0N4WDQ3MFd3YllzY2NaQTl4M3JOQWsrc2hPVVZKNGo5ZFJ5?=
 =?utf-8?B?OGRYWHQvVHQyRE1hcUczUmY5ZWVKUTlSSVpSV3FvZjJNTmloUTIyMncxbWhi?=
 =?utf-8?B?dy9hTnFrcElLT093K0licXo0Y0tjYWJUK2hUamxTOFR1eGpMMkdDMnpMNEs0?=
 =?utf-8?B?M2Z6VkZGZGZSWlhSekRXS0hzYmhYSUlOUCtIdlM0anlmSEU0T1VIdEhsem50?=
 =?utf-8?B?K2R4cSsxM0Z1Q2NqQm5jdmlwcjdOdmNnaERFQ2lxOXpTY2lSeTFueDd6UU9n?=
 =?utf-8?B?N083UDl6a3h1eEQxalI5ZXovRXYzc3M4ejI0eXBmR0FvSVdGeDlHNjJobXQ2?=
 =?utf-8?B?UTI1dlB5Vk1vSG81MTRyWEZIOHNad1l4S2NJb1Z2T0ttSFh6ZjdnK0lxTzBO?=
 =?utf-8?B?TFlRdnpHdnhYcW0vS3RoTnR1ZVVqeGpRa1kzKzdqWk8xQ2ZZM1NiZ2xubFhn?=
 =?utf-8?B?Y3FNTnJwdHZtWlkrQkk3bGhOVHhtd0NOUVVCMFZpUC9kSUR2ZlloVmZ1T0Jj?=
 =?utf-8?B?SlUyVGxISTVHRWFaaFVNSnZzMndmQVZzRVl0TmQ2TFhSM1gzaEZlSFBlN1R6?=
 =?utf-8?B?d2E5N1ZjeTc0dDZEa2NwMzZjUVI2RlRPeTh5dVdrNU5Mb2xHZTlES2hLRGVR?=
 =?utf-8?B?Qy9LUlQzdXJUVk9SUFNlRkNVOHpSbnNDelphZW9tcFZYTGk2eGZhM1ljeHl4?=
 =?utf-8?B?Zm1SOElzMDh4Skk0cmxBbkpWWUJSL2RzWnFod3NUNzJibjZ4QWdiSHozMW5R?=
 =?utf-8?B?TjRkYS85dWozbFVvcy8xSTB4ZithZlFpK05zOVpKSTk4STJrMnplOG9OUTZL?=
 =?utf-8?B?NVZ3MnFvV1JDTE85b3JHZ1RSR3ZsWnAzc21vVTAwbFJlamxncGVQd0ZpUXB6?=
 =?utf-8?B?YStEQ0hsRnphcFlkcExjMDJndkI1M1hGZzRXZzd6bnNSajg0VmVZUk5id1ZN?=
 =?utf-8?B?RFBmMWVTUitSTnB4NkpSQ2RFQVlPVjRCbmdqRHVtb3JzajdDZ21NNk94alZK?=
 =?utf-8?B?Q0hsY0tSdDY5MnJUdy9uOEhOdmlsWjFMMW1ueEFyNXZMOTJ0NHI0V3orM0Ix?=
 =?utf-8?B?L0ttU3RuNXhjQjdCVFIzTmZKbmVUL1ppODJmMmNaTG9HL0VPRS9SYzdsVkJ0?=
 =?utf-8?B?ZE1ybUQvNS9sRDc2M1pKYVM4dlhTT284cWV5czZSSEpURHZjcGh2QXd3ck10?=
 =?utf-8?B?Uy9XWU91bGJqdlcrbXNzK3ZjM1ljS1hvY3cxdkNTQWd3YUhUeHY2VGFFQ28x?=
 =?utf-8?B?Yi9XRnVHOWprQ0NBKy9oOVV0T3ZmcmR3UlBLTTREZS9TbmM1dWVvN1h1WjVK?=
 =?utf-8?B?MDV3RDlvNnNTV1pYUW9SQ1JwQTVWZVF3RjVsUlR1dlljNDVJWmI0Y3VwVTk2?=
 =?utf-8?B?dDJRbGlMQUZpUjdERlY1aEdGSktrdzI2eXIvTm1Lb0Npb2l1RUo0VksxTlZ0?=
 =?utf-8?B?MmpFRFUxQUJLSFY2SFZ3WnpLL0pYcVhZRnVZTm1DejVvSEhYNEN1Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ca1530-f88e-4a18-2d1b-08df401afa30
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:41:12.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC6FbLHnsCo9a6I9v66mJ0SQZxUsZB6cx06iRU7YDM9FuCNyEzTUQFnPQsWgGHr76hAXY0pjQPhHJVCrtbRyCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3874

On 11.11.26 18:32, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> FYI. I assume this is an evl-only topic - if at all:
>>
>> "O_OOB changed from 010000000000 (1<<30) to (1 << 29) starting with the
>> v7.2 port. That changes the userspace ABI compared with 6.18 and ≤7.1."
>> (opus-5.5, while reviewing my 6.18 rebase)
>>
> 
> Correct. Only the evl core enables the oob capability for regular
> drivers, which userland may request by setting O_OOB in the open
> flags. This is out of scope for cobalt.
> 

OK, but shifting the bit was no problem for existing evl applications?
Handled by the ABI matching between kernel and library?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
