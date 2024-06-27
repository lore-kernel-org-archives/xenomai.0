Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2C46B91
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472172; cv=fail; b=b3FP5Llg8z6PGN9oM+KLXPfMsBv6uITHq9O3wq2nru4SUrXAFY4k9wTQEng0kx12oaJ3vZy3JVqH0cqV+Ns3MkZEuYVDljgIKI141nUv0C8MrykMMBxgNmFr6V3SQgtExD4ufGCZMRPx0InJkIDuuVKUgYiWoyjsAHFP9r2SpZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472172; c=relaxed/simple;
	bh=aFkZ3bgAZ29mpEqWyyzNcb4O8oWw28ArVohD7xSx0wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsFYj+Fstjqj0P6ZDcD3kChdNAoAKcQ59lDWs1mljwU82JCxX9Dq+wiqP9XD6f62eqizlPwNfWGBTq+04FRIBEWasKyzpm0s4Sm8zSY1W3I80qNwk1v9CFokUOEaJjK17b8ZK5e/Mq4dqtTnFXErREJHd8k1QMry9I50uEay54Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jPF21q3S; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jPF21q3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIJaPwpwQdBM1+w/HlcZW+Tah7Jcy+Wp7+I1+4CoAfUz7voE5LhMXaGa9fI/cO5Xpu2D2szEl6ym0jafrAZ5js64RscZCwmEDh7KuvLC/IyO+e+zhdWekiaICHRMY/E9F85pvn0bF0tXxyjEtI6Fq8ti0Na7+rFMmCWgEXm0VJDlEjqNrU9vYe5Af2vMNwyqweqOa6O38l6NCZC5WQRBqmFBFyV/KXpxU67OCD1IAmELYGEGLRAVRjra3TazPCe1aQkEoiWN9oS3LUzdZ+IZGLmhvFh7E81sUNoifzwU0kNYAa1Xy5jw9UCo3zYAoQbk045909/i1WCbDDRyYFRlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtmkBBTFZl33pX9+Z8qWMhTI0BKjH1blOCi8u+/Ou2k=;
 b=PvyeR9xOf9mq+mScnncbYxOlw+Ux/nMe1ACSm4HQWBsPKyzl763LrvtfIM0N+YqYqo74hzb/yTwvv8QLP4xZgci9FUSSvF67gLyblGkopZ5Y9AZ+hE26h2suo1LwqzDdoZv2pnfNzUYoMxkthEWgnAsllmiRf7GxOaKnKe55eLhitQUXtW4lA9NQegw2C8UxwZUqgL/sUCOERvlL/O2IoOF6+eZ6yHvLqASICPWqyQAIVAmPzucc4s+1Nkt0fOHAh4uFIVsyn/4Ef2gwAtbMCxvKezcXM0lFLfQRA//ib96+xrgGHeDVE9hCuoYfO7U3isSvAq6EE92fGz84Eb/GJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtmkBBTFZl33pX9+Z8qWMhTI0BKjH1blOCi8u+/Ou2k=;
 b=jPF21q3S+9kRmC9DuTu2VwpESXB59BuH6AjDRRpSr6irmVdobY2l8Kdv4w5fezo4oJqlVnt1mdt+KIRH/EiqXXMihJb6Gd9C45cIz1kdDWGMHbhFxONfj8ejd1ufbzd+zG8AvI/6oc9qgtNgfVwYB8AaRLEs+HpNA6BFhehTzh3LkMhSKHGZercUId4n76z60++TEqvlcrPumRcpdu/c0WbW1hJElTlOHdUFJ6NnRmQ0f4TQ1VbXsNkc+JGA0SQwsyO+vjJt/kAGKukDTJHsXD4dWx8FGxnSO3ave2eBGstudu5kzPp5Si4raW4xHEsCgtNMvJjL2ArVd2V20uosGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 07:09:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 07:09:25 +0000
Message-ID: <f080f6b9-a75d-4dfc-b510-d89a492d40c5@siemens.com>
Date: Thu, 27 Jun 2024 09:09:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gitlab-ci.yml: Drop --enable-smp from configure calls
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240626194043.15307-1-richard@nod.at>
 <20240626194043.15307-2-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240626194043.15307-2-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0381.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 86047393-9b63-47c4-701f-08dc967813d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWgva2VVMUtVNnNueVNRRnlSOUx2YURpNkRLLytBNWErMmZ3R2tuV3pBVlFV?=
 =?utf-8?B?ZDhEZm9NYVRqMWcrcmVpZ1BvSm5KZWUvanhYck4zSjhlSTFGVU83Q2Y4RWpv?=
 =?utf-8?B?YTQ1L2JzeDgxRThwU0Irb1pmWE5RaExoWG5TR1dwa3htTktpeWJiQURsaHU1?=
 =?utf-8?B?TTcydEFHOTU3cXd1NU5xdHVMcDZLYkE4UkczaHRhQmJiSE1SMWVOMGVSclN2?=
 =?utf-8?B?d3NoVUJ0VlQwVXlVc0ZFdVlvbVZwaVIvY0h3YSttZjhaWnF2Ym5pdUtKb2RN?=
 =?utf-8?B?VVJKSmc0QnhEYzU4R3ZuWjQrNzF5NndrRmphRXAyRkhzNG9rd3VZc1FqYXRG?=
 =?utf-8?B?SGZaaWMxZ1phT2RsSURPcXVnRy9ZSjVyVDZGWWtZSDU5VVdySjNvWE4xRDZC?=
 =?utf-8?B?anlFSTZuQ01YM2VXbFR6MG1tejlNZHJnYmJPendLOG1kN1NYNFZ4TXVUQmg3?=
 =?utf-8?B?eGJ5V0Q5c1pjSFZqNFlTeWIwYnlmVWQvdXg2Z21mNDFjWllZMjhraEFZV0la?=
 =?utf-8?B?Sk4weUdTUjU3b25jaXpoYlVoeHhLTXNHTFVVcXlHRXdNa2ZZTEpyL2ZITmpT?=
 =?utf-8?B?dXRIazFXbENXMFlBckpvWWVNbFdzemQ1dFVMRTZRZUwrcUtSR0RQY2pBeHM3?=
 =?utf-8?B?SHliWGhpR3krOFdLVE1mdzFoVjZZRW42SytCcWxCNnZndTl6dnp3dnY2SFds?=
 =?utf-8?B?bVZOMTNVSy90WUpkdldiWFQyYjcxSjV0ZXl6L2tKeEtrNmp2cnJvcmxzd3lD?=
 =?utf-8?B?TkI0Mm1jQUU1clJKeFdTZytzajRiSmszVGlVb0JvL1RORSsycnNsMVQ2M2NC?=
 =?utf-8?B?NTR6RnFJSDNSUmd3dG5QOFVESDd4eXY5VXBxQ0Z3b0tEazNtTlVnNHZPdHA0?=
 =?utf-8?B?TWFnb3ZJNXBTeHNiUjFxQUJuZXp5dTVpRkNXNFBlbXkwL1lYWDd2SC9EK3lt?=
 =?utf-8?B?T0hoTTVCQjNuTDRjUDcwSFo3NVozTFJaRFI0STBNOG9mU0hOUVMreUoyaWVa?=
 =?utf-8?B?aWgwVkx2QXkyRE9UVWRoWlpCOGs2UHpJZ1NNN0pBakdUUVNnYUlsbDZlKzRU?=
 =?utf-8?B?eWZoRzBsMmJrMDBPZmQ1WWV2bU5iT3lJNCtVUCtlalVJSytaemRuRzY1OVlK?=
 =?utf-8?B?Wk0yN0tDTEdUaFFjK1pEbjRRYTZjZStQMGV6K2pmTk1vUGZSS2tsOGkrNzJE?=
 =?utf-8?B?eHpGUVJnKzRVYkxkSURqUzVtblB4TjZJV3p5ZHFVS2NiK0ltRnExdEFrdldT?=
 =?utf-8?B?dEt6Rkh2N0NiQ3NmNjJrQ29vZHUvOCtBWGxkaG45NDMrU0Z2cWl0TFAwZXF0?=
 =?utf-8?B?T2xyYURiYXJDN0FCeVVUSjBOWjErNWRXais5dWZrTkp4RENoSElhSXJPNE5q?=
 =?utf-8?B?cnRnekZvK0V1OTgzQ3pnK0pQY0VRUTMzVFc2dFVnTTNSc0RhdmxVeVRUdGVw?=
 =?utf-8?B?WjN6a0swQSs0d0JrNjY5Z1RNbzgzN1ljR1d0ZnRvQlVrQnRqWXk2TWFYamxY?=
 =?utf-8?B?bmhwdW1mUzZtazR1d1MvTEphVm1LWmpERlBqcXoxQU5HdnkwUGJTNURqQi9I?=
 =?utf-8?B?OTM4OGtZYk9aekN2WmM3c0pMUmRuMEl1M0NSYThocllZYUcwOHc4ck5udHNt?=
 =?utf-8?B?UzBTMXB6bVVCNE9FTk9xcm02djZZRW9sSnN4enpSQXI0T0phcFJHWHFzQkVS?=
 =?utf-8?B?aXZqTG90d1dyWkVjNGhieGZzSXlRcFVVVVhQTjd1QWRYVEpDNTZGeEtncEl5?=
 =?utf-8?B?VUU2N3Y0OSs3alFDNXBFTTJ6d3pqWW9YZWN4MmYxZU05RkxkQ2RrWE1wUmJj?=
 =?utf-8?B?YkZhbHpYaktlL3RHWktkUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUpXY1h0VWJTakFOc1FhMTdkOEJXT1BtcDJ0a3F6UlNJSzJReU5VWExST1BU?=
 =?utf-8?B?UWZtQ3ErN2hmamh2anpaZ2ZZWTV5RUtQS2V1SDJmUWNWVTZJbVB2TU9tRGhx?=
 =?utf-8?B?RUYraHR6N25IK1JYcE5VZlpsNU8rNlBaUk5SSDlrT3F5THhoK2psQi9DdjZR?=
 =?utf-8?B?elhEaStZM1F2akZNRjFvOGtrUzEraGxJMnZFdU1KbGx0MnJjMkgwU1R0OTd1?=
 =?utf-8?B?OEtGa01iTGNjblZmRncyaXVidW1mUno3anY1bzRKT0dNOSsvVnlhbGU0aWxX?=
 =?utf-8?B?NDgxQ1JJVHIxam5xbzZsSzRJS3hKejl4ei9xcUM1czVaMTIzY0dTVksvYXNr?=
 =?utf-8?B?d3ZoMHBkb0RYMjFSSS9mbTkwVm01NGNEcmt2QmlndVhaSTNybHdiSFl3ekRu?=
 =?utf-8?B?VHRuZkoyK1BVMm9NWk0ydEJjOFVKN1U2ZC9DeW9nelhrT3FISUdPZTF0Y2Vm?=
 =?utf-8?B?RldLV1NKak56V09PdmljSDZaN2R0dkVXU1pjT1BQcUthcnovRGVlK2tqSFRr?=
 =?utf-8?B?MUs2YkVNM01FUXpvazloUVVvdllPbHhVWGlORGdlUWRyVTArNWNmc083QkNB?=
 =?utf-8?B?WVVkTGFuVnVXYUo3RlRpbHNmWlBqZGNxalVvdDg2MXhmU0hETHk4R29LdUZE?=
 =?utf-8?B?YlFncVd6eVdzdGVYMVJRUURyb0p5M3RJV1FwSmpuekJrRUpjVjlzSmRUWGxv?=
 =?utf-8?B?SG5XVHcyUFdlN3Z2TDdwMUNQdzVseEh0SnUxOXBxMTk1MzFsRnM2cjN6a0NF?=
 =?utf-8?B?V0dXejRmdThqR2p1ZFBRYUNEdUFTR0sydEhhRUlDd0hjNHZYNHc2THBXZkxj?=
 =?utf-8?B?TTdueThQc2tuNDNxbEJVR1AvVHJaRnhLb25KZHp3QlNVWmp5M24vcURlQlNP?=
 =?utf-8?B?WHhHMnZ4RXVHOEVzajQrV25IU2Nuem1OQnZoV3hrN1lnVG1wd1RTY3NCb0ho?=
 =?utf-8?B?NGs2SVkzZE8wbGVZaXRiZlFVMCs0Z2JWdVNxdWxNMEtmU0pseEtOY1MzNWhv?=
 =?utf-8?B?cWhxQklmdGNRelVGL3A4UTdibUgyeWNMN2JWQ2tZT0ludjEzOGVYTkl3b0VB?=
 =?utf-8?B?bmFqNVUyblZmZlYrUzZTZ1IwMjFiVDJISE1kLzFGNmlYelJWSkI1c0EwVmlU?=
 =?utf-8?B?eG1IRk5iek1KWUVPMW5XTExKMVljcnd0MVc0K0lpNHNVVHdybDU5cmI4VXlY?=
 =?utf-8?B?WGFSVVhhOWpRaG1UZ0lLckFJRGFHTVk3dkZlV3owOFNkd2J5UXJwS3Fpcy9q?=
 =?utf-8?B?UUxpa0ovNnZEVERUOWlVUVhzTEdvYnF5cTFHbU53S05rS3J2ODIvTTJFaFVK?=
 =?utf-8?B?TmJTWnBIcmhoNTJDajcyWUZ5QTE1MVNVTExyZGpyamV3bVlvYVF4R3RJZUVC?=
 =?utf-8?B?QTY4NEszN0JEU21kR0Rxb0NxdzBGZmQzY29oZUJVL2RFakJNL2Vzc1B1UjNK?=
 =?utf-8?B?MFNudWNkYWFTNWFndFdQV2JnNlZiS3o5VXB4TzlDWTRJa2IvZFdZUWw1aW9G?=
 =?utf-8?B?ZDliMXZCbCt5TGNMUmY3QXR4L2loU1dUTFNOWnJTeEpTZm5PRXBWOUhOODhU?=
 =?utf-8?B?MlRXcDhmdTdiTlpIa3U4V2lpMmZOSzFXclFPQnJLdFJXQzZKWEk3YVJ3N1pj?=
 =?utf-8?B?WldWbEJBczIvWFNzRzM2aEpiUU9ubnFVMTBWYnZaQU1pZE5aR2wrVXhPbWZo?=
 =?utf-8?B?cWxPVVdyVkY4MDlTMXliS1FGcFpjdFZacFhzS0ZKMW9BRGR1ODgrTm1aeDM0?=
 =?utf-8?B?cGN0UG43YnVPVXIwbnU2S0VmTXdieWJhZmxjV3FDakV3TWVxOFRwZmlud0FX?=
 =?utf-8?B?NUlwVld5OWpUSytPU0ZHR0drMmJpdVI5dFlHb0NHTE5LZVdRbFF2aEtEbE1U?=
 =?utf-8?B?eThETTg4U29hMVhsTURhTkpiQ05yc2ltK1llaFl4Sm13V2piTTlDemF1NjJG?=
 =?utf-8?B?WWx6OENtTENxcU4wZ2g2eFE1eTkraUxsRXptV0hBbkhFL05zN0tmUjNKR3Zx?=
 =?utf-8?B?SWdHOVVhVGdVckRpdm9SNnB6VHRFS1R5bXFiZGx5UlE5b0ppZ25PbUJPcFBV?=
 =?utf-8?B?elVRb3RVVWR0dHFEZmlQSFlJb1BaT0x6WURrd2JEcjY3cUtweWk4Wmw5V0x0?=
 =?utf-8?B?MWpjMXp2VXdHOWRzWUJuVWMyYzFhYmlFdGpZT0J3d3lMR3FZOCtVQlMzbUtG?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86047393-9b63-47c4-701f-08dc967813d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 07:09:25.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AiXu/HfZokpMnJNFCwEfaCIVRWsqBgDZbQ+ZY7nv5dPJ1qY3tyevLAmiJiIa3tptYDhRZtnY8zF6k1oISeuAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7014

On 26.06.24 21:40, Richard Weinberger wrote:
> SMP is enabled by default these days.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  .gitlab-ci.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e174fdc48..fa9203525 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -175,7 +175,7 @@ variables:
>      - make -j $(nproc) all
>      - popd
>      - scripts/bootstrap
> -    - ./configure --enable-smp ${CONFIGURE_OPTS}
> +    - ./configure ${CONFIGURE_OPTS}
>      - make -j $(nproc)
>      - ccache -s
>    interruptible: true
> @@ -254,7 +254,7 @@ i386-userland:
>    script:
>      - export CCACHE_DIR=$(pwd)/.ccache
>      - scripts/bootstrap
> -    - ./configure --enable-smp ${CONFIGURE_OPTS}
> +    - ./configure ${CONFIGURE_OPTS}
>      - make -j $(nproc)
>      - ccache -s
>  

Thanks, both applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

