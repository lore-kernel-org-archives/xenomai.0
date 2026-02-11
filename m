Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66651315D5B
	for <xenomai@lists.linux.dev>; Wed, 11 Feb 2026 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815221; cv=fail; b=Kf3s1wwS/llBztcRKVAtD1h3Gbq5GKi6ML8WhctGuYOjOOAYJmV9Oslk+RZNgVF+EXlWbuy88g3QneJVffXCA3dsVBrLJfH4h63Y7WlB1ZT91uo0uLZtgKbY5zHBsTSWxJ7WQUUjy8ZJHxdX+8D/5JmP0VZxUmcIz87DSs/SWMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815221; c=relaxed/simple;
	bh=fRbyLQ1oRsHBTfx5kUxiXdRmJsH5xPDFesBRZZXv2Co=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OzFqopda45t8GDmKAWf0/69pf3IQmhTjs9da5sDra7KDj8LpuD1moWHfJymn4sX1OuLnaId8yr+1rpUoQVybdvvJrjbuRt8D+kOp6yac2x5j8jQuq1w81asSIXmwcYxOft+MULCs/avh/ileBGLm5XBBcRb0i481DI3WGKEmRac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tZyEsxR0; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tZyEsxR0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSmyBgMev8Wpfpx+utb4spxkkP9bsNXcQtffr0DxI+Nuraz3fbTAZt72NEbLERyfdDpH+ryJtil2nGGuCyxo9i3BNUbo0xGcZSwHdkhKsXBzHFc86mlJi+s1viNMseBqZe1aJPrUr7EPYqNSC3lDbT3A6/NOl6F11opZAI8DsUjoWVsO7h/+YtIqRM5Pfgo8V/AzARKrtWCvrsq+weuJoRVw8O8thoa0UEXDopDXF0uoQpOrc0+VEWlXv1j0kgirNQ9ZSYmZ0EsCH3Skj51fjt43Rwc7QbtmFcgqGMPuWdzGjuxyo1wFtSBF71bhRKLyCvuYcEIWzVIyxh5EGtf6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR0yfqejEaH66+9w7rUq6noselv5Jfqx2Z13pn4Vfk8=;
 b=HJ3XOI6aTMUgFMdXaXcUuaPiXnU+YLmNX6xM1+qQS0PLOrLiojdhh0RssGYkbzkdN8os5WViLo7FFjSThD7F2dV8oGk7SnfrDQFS4lclnGsn7U6+/S7hlzRKH6vUZN2zFnH3VnfCcnITZfCWDcqtexkZGbC1GHhuJfs1F8Ivf0ZWOQiO+vYxeEg0k/o3lCv8GRx3s0AHZJPucrsOCfCzk9RQcDLh7wNJF6YVEVb/IbJ7W5iPtp81i3gAYu1pgKzbE03QGw9U8vtqRsQ5YGwHSraRJVVblqYkx4VbnMmDMJSDzh/XVi7JMBagGZ6htFAaADqz40iSDwa8rTKfPZOLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR0yfqejEaH66+9w7rUq6noselv5Jfqx2Z13pn4Vfk8=;
 b=tZyEsxR02nuAfea59lM+rSljPcLbCSgwMw0PUT2npwQRU6tO1QpKSwzDrKEY+TNJZARUEIh4KJCgbNCI2p6MmP94UlWWyTSOS5bmC3c9zUgqPrtyxP5TgePnuTzGokT/yIVv+ZUda6nnMPcxCFBb5AOv7b4iRwBbWNyQlW6bncJNSolYHdRLzylNEFwDOQRgE7rRkYwnt41Y63Q8o3QI4N0FOlktQm5VWj3xZ5NYRBJutn7ki9QPolHpEJWf6eg2EX5uS3fp0U53AanVPA6o7OINnfsp0VdjufjL4R4qN+oCfrmxdmm/MPkiBq7ubeNcdYX3cUETrQ9aAR4JQ93IcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AS4PR10MB5149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 13:06:55 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%6]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 13:06:55 +0000
Message-ID: <0ecf767b-f720-44ad-87e0-6821e9342ed0@siemens.com>
Date: Wed, 11 Feb 2026 14:06:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 0/4] Trigger xenomai-images CI for
 linux-evl and libevl
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260209144346.487179-1-clara.kowalsky@siemens.com>
 <9091ec50-b519-41b2-8105-5dd03e28822f@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <9091ec50-b519-41b2-8105-5dd03e28822f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AS4PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e9ed57-9c45-4d17-1a8f-08de696e6e8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjFjNlB6eWVSZjMzNVNoOTNGNGUvTDJjcHZ2NlA1ajQvNG9GYlRieHF2cnFI?=
 =?utf-8?B?NStVOTVJbENUS3RYRmpidmQrQnFQYnBLV3d4L3JOS0hqOXhzRUV1TXVLOXRP?=
 =?utf-8?B?d2dLWTRRcXQ2c3RueWdpdzNJSE11QWNScmY3Q2tVcmVQZlZVeUZxSnhRNXk4?=
 =?utf-8?B?MzRhZjhOK0Q3NXVSTE9IZTNETm1zeTlVaTlBNEJ3NVU2Z3pkVit0bzVPaG9J?=
 =?utf-8?B?Q2VjbThHeVBXcDcvWE4yOFZKNWhTV213bFoycDRtci9xRWU4S0V6dXBxSkdT?=
 =?utf-8?B?UHpLdmxCVHh2WDRLZUhBbHNIeUpjWnlEdUROOEQrN1NIbU4yQ3FRZjRzR1B6?=
 =?utf-8?B?dWM3Z3ZwQTRoRGU4OG00Y05OQk5nREpSY3VpTkpaZmhKSTQvWDBxMXNBVE5R?=
 =?utf-8?B?SDAzYmxDOEZUM0NndEt4OGRKbkw2WUNFWXVtUnBpVzZ1cmlGSURnbkNla3c1?=
 =?utf-8?B?ZlI2WnlFb1gyV0l5a1NVU05jZExLdEczZGE1OXBxTmNmYVpha2szdTJrcjNW?=
 =?utf-8?B?emcrSUtkYlBDNklFNXBZdEV2NzZxTFRjUjByYW5aSm5LVmxxblJlVFcxcE05?=
 =?utf-8?B?YmtPT25LNEczRy9CZzRyazdnNHZUeThmTkpCbGU4V0Y0VTdUUkZxVVlKdXBI?=
 =?utf-8?B?VkYyNlMyS2x6UFg0NGZJaS9KS0c4NUhDbE1qWGJPakxWaFNJdUp3ZmNmNThw?=
 =?utf-8?B?Z1IrcG93RldERExEd0xqZ2FVYzkramJhOW9acHROblhnb2V6L3dRM29yZWNX?=
 =?utf-8?B?UVBxb1FrVXZFTzl6UjFFTG53K01KeGFRS2hrUmQ1WHc5TDNmL2prRFR0eDBq?=
 =?utf-8?B?ZXIwaG9VM25DTllBM3N6Z2V2VUFLQ2dmWnRSNGVoRzg5NmovcmhGOVIveGZl?=
 =?utf-8?B?c0YrMEVQQm5CZjh3RzdYcXhpd0UzajBKU3R1S2lFeE1LNVNrS0xyTWRqSDRF?=
 =?utf-8?B?V3RoejFpZzg2OFR4TjZTN1V0bnN5MkpRb1hpQmt4OEsrdDluQWZHRkdET1Vj?=
 =?utf-8?B?N3FhU3YzUnR1b2xrMDZjdWZ1ZWtJV2hxT2p5TG1oaEQybGZiYWdsclRwU2hw?=
 =?utf-8?B?RHFEZHdkQ1dsaTNHRHNkSnovNTliUEl3RjFQTnVJbVkyVEMvbktYN0tNZmJE?=
 =?utf-8?B?MGs5R3JGQWVXajgyMUpFOHdmY2xMbHdYZEZWZ3BhWEQvL2NYbnpBTmZDdE9P?=
 =?utf-8?B?KzdhWGZ0bUxaTW1vQXVab2w3c0RHUkFEbVJMdmZjQUlqT1N4MTg2RWlKWWpW?=
 =?utf-8?B?d0ZUSGZCSXF2dTRrMWs1QVpGNWtnbGc2SHl0WTNrb3dEOVhuUEwwQk9NcWU4?=
 =?utf-8?B?ZG9GWVQ0bUdOVUFzWXF4RHcxSFFPTis3bmIvbFNKR1ZLbWxkNWVNQjFyQ0Fm?=
 =?utf-8?B?TlVWbXQ5VE4vWTJqNkhaNW1tcC9hS0pEV2N2VzEwWUJ2K3l1dUFyN1BIZzVE?=
 =?utf-8?B?Q3VyRkUwRk0zdVRNSEdEUUk0VXNDUTdGVlJCdExENmoyRHEzbmlpWkNxa090?=
 =?utf-8?B?MFpKTzZiVytKWlNxNEJkMitlL1U0UkQxN2pRRDJybWtjb2Y3eTFKcjJTNzdP?=
 =?utf-8?B?V0t4MldHQS92czgzeXlYaVRLSXVaYkUySkQwMWRJQTF4TEN2VjhwQ0VNTmVz?=
 =?utf-8?B?bFg1Y0xqNUxPMDdERE5aSE11V3k5MWwyQWlIWTFHZ0VXZm9SQ2VNcEx2YWFh?=
 =?utf-8?B?LzFtOHJ4R2JwbnJWRnFwbVFFdkdOVHFKWWpxSWNpTFl4ZGVkYWFPbXRTUCtq?=
 =?utf-8?B?akJIY1pFeDgyQnF4YzcvaE45eW9tTTZIZitBaktiaWVCVkJDV3RUSWg0R25U?=
 =?utf-8?B?V0pqUDRIRVlqSGE1QjhJWUNiNjVUNktQN1N0ZWJRcGpJcGVZNnN2aWtKN1d0?=
 =?utf-8?B?T0c4L2MyT0ZhQ3ZWZmxPT3U5VVNwQzN1OFdIQUdxTk5KZU9pb25uM3ljSUUy?=
 =?utf-8?B?dlJMc1VENFNsdUFQYXlmcGNjeE1mSjBjOXZsZmZCaUdXUklTU3dkZ0x5VXFX?=
 =?utf-8?B?bVFyYU5ERmF3clRzNWFlNW53VWFFNkw0YWxsQXhnUEQ2RHA3U2hGYVZzdnRS?=
 =?utf-8?B?WFE3RFRoUjRYOXhhRTJvRnZhR2I2MFRrWHJESTlxZm9CVzkyMTAzakZuUWZl?=
 =?utf-8?Q?upp8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXNOZ1JGOFN0ZjRPeHhyZmxLNlZNNlJZbTYzbWpYandKVzg0SHFZczlwK1Iw?=
 =?utf-8?B?alU2OGwrVm8yN1BDdURsMXNSajB3ZWFEUE5KRVVLMHdITnRTRGdTMlJkZWZz?=
 =?utf-8?B?OGtVd3VuOTZaWEJPSFByRHE1Nk1MbXlYeWhwaHprZnJsWm1KVmtnRG5vKys5?=
 =?utf-8?B?cnc3Um1Xc2VvckpaMzY0TlhsVjN5VkJqeHEvS0tLT1FkMWVVc0piL3p0MWVl?=
 =?utf-8?B?Z0g4VmY5UmJma29ZUzBkYjBuZG9qRk52YmJkV1VzU3hhRXVnR09NOHlZSFE0?=
 =?utf-8?B?N2xLeDY0ZWgrd2Qza2ZuWmhkYXVpUnRUbmdUWHZhZWNKdEpMckF6NXdUV2Z2?=
 =?utf-8?B?TWw2SU9HK2owNCtJVWpRL1N4Z3JoUDFlSGt0K05tTkVhUUszczd1OWY3MDh4?=
 =?utf-8?B?VmwzVEpjTlFDaWQ4UTQ4ZWwvTGJvYWYrMnRyYVk5ZGR4eGtLZ1YyWXQ1ZlB6?=
 =?utf-8?B?QzlZaFNNaVJuajRnWFRrOW1HRG84K1lZRnJRbDMzVkFQMHgrMDdMM2l2SkRN?=
 =?utf-8?B?YndvQlNBdXZBWCtVcXBFaE9PRklXak5MU2hubWlyRElmT1BKaHJwOXVZZkR1?=
 =?utf-8?B?dXNGdVVyYUhwL2tjaHNySFZlVVlEb0EzQ3laRHB4SEZDSDZHcTZCeTRpRUE5?=
 =?utf-8?B?RWYwRmJOZFJnSzY1dmtEUE4zNlJVbXFtdmYvamF5cFNtZHd6OTVSZmFPd3Ir?=
 =?utf-8?B?aFRpVjI5SVBCWEpjUkRIbmJYYzc1NGhWRFhKYjNCUzBjYmYvUHlGTUo1Q2pU?=
 =?utf-8?B?OU9MTlZFakdnRzluV29sekxJYkRJTy8yOFR0TFFiSk9GWGpSZlVmL3dJUStr?=
 =?utf-8?B?Vk45M2NXckludHlOM283ZWp3VU96dlBJa040ejBvQktXMElTVE5tYXo1c05X?=
 =?utf-8?B?MURvcm82R3Ezdk44c1Z0K2JYZDRVa3lDb3g4dUVzYlVSM09HbHAwalh0TUox?=
 =?utf-8?B?OC9XZTVkOCt0VU9WWGR4eDBrVFdlNmVadi9mdkt2TkF4bXpoektqNU5jeWhw?=
 =?utf-8?B?ZkVWUWs4dnZiSitpdHhVRWdBa1RrZGw0T0p4TDUvM0tXZktvTFozelhKWVQy?=
 =?utf-8?B?RldiS3ZYK29HeFdvVXFybHpHMitka25qYnYyZXVNSE1aR0pGaU5teVJGbE4w?=
 =?utf-8?B?NEM0YndxRGt4QThSQnhla29OWWpkbzlHWUN4T1FjNDFoZ0lkUDBhZU45c0dv?=
 =?utf-8?B?Y2cvbjVzYzJabGFLVG4xNTVoYVcvak5sWDNPajAzNWptTmZzWk8vMFZRYlNv?=
 =?utf-8?B?eENtV3hSWnN0cHlkcXp4cjI2QTVFQVFXWkdTZFFER0o1L1lRTnRmLytvYmNs?=
 =?utf-8?B?QnlYYUlUZ01zbmtjamJGS3BPZGtDOXE1elh2eWk4YjVjbi9zblgvdjZZV1Zr?=
 =?utf-8?B?ekJMRC82REpwQmhwU0lMS2Q1ZzBLd01TOTV4eDIxcWxNZ2ZKblpUR3FXN3RV?=
 =?utf-8?B?WmJDUFk1VlhYb2cyN0NqcjR6Sld5M05JNkRPVWlPTW1ZUHQwbXRGT3lnbm1p?=
 =?utf-8?B?bjBXWFkzeEVqeWVpWjE0eWVZZW45aFhiK3ViV0J5QW5pN0dvMjB3S0RVQjJH?=
 =?utf-8?B?d0NzWnUxSmNNTHgrMnVyeVpKVnZ0VjRWZy9FeVZDNmd1dTZVMG9XaTlyZDc2?=
 =?utf-8?B?WitEdWZ1cHF4WDhzelBkcmNJSjl5V1BidG5kaWFBMjNDeUZPRzBrTDdlZVdH?=
 =?utf-8?B?NlpHcU1KV054YVYrRkZqZXVMU0tlQjF6UFlLSG1NMktTU0poMTd0NklKRGxC?=
 =?utf-8?B?ZWxkZjdnbmM2SnQwaEc5MGV0NVlraWRvc1lxbEpVRmFHRzA5UjdUaVA2c0FH?=
 =?utf-8?B?SjB5amtIcXVJMWJNaUN1WWoxOG9IR1laWjQ1Y1pKTGJ4Qy9peldJYzh0bVh4?=
 =?utf-8?B?eGxpZVhxWGIybmlMTFAvb3hJMk8vTTNVOWptSFdKQXV6WkpvbUpxczByNjBH?=
 =?utf-8?B?N0FmQUxhKytza2pWY3hXOTJFcDQrSVVKZEJNamV4U1c5UXFoeTFENmQ0eVgx?=
 =?utf-8?B?ZC9kTE81MlkvNGNRaGZ2VnhITkZtWVlsNnNiNGcxQ3hhR1VlY29JeElSYXhr?=
 =?utf-8?B?bG1lbW04VTZSMlFZMjFROE1oOTk1R2V2cGQ3L2xvNUd3dmJLa2ExYXJrbmdy?=
 =?utf-8?B?RlJiZmRuNXNQQ1d0YU1aZmRVL3RQNHRnc1loMmE0VXFLbFNUbTg2VnhzRDJW?=
 =?utf-8?B?VzczZVZtbUl4eXdVRHZtaWtiaktSemZNOExsMm1FbVBKa2VaZnFoTStvSlQ5?=
 =?utf-8?B?Sk9mVWJ5Rjdvb2ZUc1Nvb2RLYkZ3dUlXdzE4QWwvSUNSTWsrMHZUbmVqU1Uw?=
 =?utf-8?B?aDNiNjErTTU5MERtaGs1bG5DdXhrcUxWTHlzN1BEd1pPbkloY2xsU3lydFQw?=
 =?utf-8?Q?7nV0luSu2MwHv42I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e9ed57-9c45-4d17-1a8f-08de696e6e8f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:06:55.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QayIs+sjd4aDbIxtOuTmU7a4gx9Hp2fvTbKsBvm1VhVl1fBsmccUNH0JyRJdvH77j2SBGiEYuBCOfROZ4uCj+jKjR4j9aN+RRBz/yVzguw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5149



On 2/11/26 00:06, Jan Kiszka wrote:
> On 09.02.26 15:43, Clara Kowalsky wrote:
>> This brings support for triggering the xenomai-images CI for pushes to:
>> - linux-evl branches: head (6.18), 6.12, 6.1, in combination with libevl next
>> - libevl branch: next, in combination with linux-evl head
>>
>> I noticed that the case that a branch matches the rule
>> "$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-evl-rebase$/", but is not
>> the head branch (6.18) or a xenomai-images supported branch (6.1/6.12)
>> was not covered yet (this would be e.g., v6.6.y-evl-rebase /
>> v6.6.y-dovetail-rebase).
>> To cover this, as GitLab rules are evaluated once at job creation, I
>> introduced a dynamic child pipeline that triggers xenomai-images in
>> case of a valid branch. If the branch should not trigger xenomai-images,
>> the child runs a dummy job to fulfill the GitLab requirement that the
>> resulting pipeline of the trigger job cannot be empty.
> 
> What would happen today if someone pushes to an unsupported branch? CI
> for the triggering repo would fail, right? Or something worse?

If someone pushes in linux-dovetail or linux-evl to retired (like 6.6.y) 
or not yet supported branches that match the regex rule of the head 
branch (e.g., rule "$CI_COMMIT_BRANCH =~ 
/^v6\.[0-9]+\.y(-cip)?-dovetail-rebase$/"), this would cause the 
downstream pipeline in xenomai-images to fail with the error "Jobs 
config should contain at least one visible job".
> 
> This would not be a big issue for dead branches. OTOH, a silently
> passing build for a new branch that is awaiting xenomai-images support
> would also not be optimal.

Alright, then let's say this is intended behavior.
> 
>>
>> I tested the patches for:
>> - linux-evl branches: 6.1.y, 6.6.y, 6.12.y, 6.17, 6.18.y
>> - linux-dovetail: 6.6.y
>> - libevl branch: next
>>
>> Best regards,
>> Clara Kowalsky
>>
>> Clara Kowalsky (4):
>>    ci(xenomai-images): Add build job for pipeline triggered by libevl or
>>      linux-evl
>>    ci: Add CI for libevl
>>    ci: Add CI for linux-evl
>>    ci(dovetail): Trigger CI only for head and supported branches
>>
>>   .gitlab-ci.yml       |  8 +++++
>>   ci/ci-child.yml      | 27 ++++++++++++++++
>>   ci/ci-dovetail.yml   | 35 ++++++++++++++-------
>>   ci/ci-evl.yml        | 74 ++++++++++++++++++++++++++++++++++++++++++++
>>   ci/ci-libevl.yml     | 28 +++++++++++++++++
>>   ci/evl_xenomai_4.yml | 29 +++++++++++++++++
> 
> There is a certain structure in all those new files under ci/, but I
> think they are just getting too many. Also for the existing files, I'd
> like some separation:
> 
> - ci/trigger/*.yml for files that are consumed by 3rd-party repos to
>    trigger us
> - ci/<trigger-repo>_<trigger-branch-or-version>.yml
> - ci/lib/*.yml for anything reused by some other yml (e.g. the
>    kernel_*.yml)
> 
> Maybe you have an even better idea for names and structures. The
> principle should be that the ci file structure already gives a hint
> where to look at when traversing the pipelines, from .gitlab-ci.yml to
> individual settings per job.
> 
> Jan
> 
I'll send a v2.
Clara

