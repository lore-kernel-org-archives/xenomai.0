Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FA253330
	for <xenomai@lists.linux.dev>; Tue, 11 Feb 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288482; cv=fail; b=PNKbrJlwL6sq/FzSWepGWGx2KTJ53XEVxsb3NqjllImEfnfEXTM5T4BmUlGXaPq5UxhbS1JWFyg/+l6nCGh7hSKCIPL5u4X46ALg/r46e2wp47YD8EuZ+sJLyzXpMeGGxZT2NY+Bj1mIMkl1XWDnxsqOYLHPY4OEDfsZ/OgYSkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288482; c=relaxed/simple;
	bh=eJxPR7ALUMjLKbTdrZ8SkXdS9irgTKWwyVbtEganqjQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LllQRlm2Lqb7y93RTonO/Esvyjc6r6KrTxJEHUGqtlYGV8s/pn2fINi/UBEzCOxzoESuIQS7fDc0IAjQ2G86jq58O6C03O0/lzKmwS+VbdpNvGR/zynYCvPqxYUdpsTAJF3D0lf2ijsXpxGSGRx5qE7qeD5QTzJIsoKP/M5CXTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=opXKyJMj; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="opXKyJMj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn93pfOhHHQpv1yEOux4UXHyuc4zWDqoO/0fNZxSo7mancU8XvmQ/GVtGLs1hrrBxBGb0A0NAV5rlm9yqrFCb663T/RkFfmiNO1E4/k0BdStG5h4L4fHXjnYFs1mmW86TG9gPtJsWSCUDx8FGm5w6D6kiAQonDt7+OJjoXvVkuhzkOAqsRSCKo7Od0tY2j+nQQkT4Etq/ITOBWWmr2sB/MvUF9ehhqoy4BTtf9wyz1n1HwMK+PI4UYWpCS4StpPY7AMf2yrEDDhzxG9ENB+f9dBvQTa5+n7myudTvBjOryuB6nTPGvqkLHDrKAMAvsE6prCv2Ppo+ubUUyI8Ezu78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+7KWdpm2VIObzdGqpu4QPaeZkreMi6BH3nEBvFgMLE=;
 b=ruTCUN8DJIp7/O8RE2IQnL4Ird34jlYTck0mN0iz90DUX9CNcliumAJbKeNRKARNWNZCaX7CSReY8Uv3FdYJOwsh5UxmYnnsa8JUTDqtNEvtlM/toVhMAp6Pp0k9iTi0EmptRRoVozRhXfcnsVrEkq6yPazi7u70ClYcan7VUZo6vo+gTbsjUvP1t2DN67S9/+iAZfIyhUK3nFGgKxIVv/QiK3DK/FeX3G+WJ2+ayS/5Q+SVaoOu6TWqB70xd7Quv0G8hbMN5rzHK1jYktznXKANCAgyqEYqQm3ja2tOAteEmusbMxoNcsae6DekQiQCAt8x8fQNLmh23I7t3wUlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+7KWdpm2VIObzdGqpu4QPaeZkreMi6BH3nEBvFgMLE=;
 b=opXKyJMjypddEVyFm84WURUi4uraIqRq20xVu1guf9depCFpdY3K1SSUwLe0x2kP7+KWsKcIXqqUWtNJM83HYiPIqwz8YSAHkxvzQXrJ1jmYQqnMkoxt+Gk/Ld0Gukey8CemZn5J7YNI+K9MkMLcV+rKhWfO6yiLxVeY7UPu8uzNg2rOUzjMDbjGRm01xLwA1Nad+tF9dEkDY2Fb5AytmsGu67JVWu1aFDhXsA1y9hvo+hVWrk12Hp1Lt5RcRh0g+FeI6fJiah5GUpBsLCiAnHIXYEbArWIpxNeBsbHUkNmTijKFATPr8S3eOp6NxMwNvKHuF9hr31L3vdMuFDsdYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6804.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Tue, 11 Feb
 2025 15:41:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 15:41:13 +0000
Message-ID: <de3ed98b-e52a-47d6-824c-8df84ff53608@siemens.com>
Date: Tue, 11 Feb 2025 16:41:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Fixes many broken links and some outdated
 information
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: luis@eichitek.com, Xenomai <xenomai@lists.linux.dev>
References: <d992ccd8-b509-40cd-83f0-704c24929688@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d992ccd8-b509-40cd-83f0-704c24929688@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4737c64d-3c4b-4811-4aed-08dd4ab283fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTBkeFV6NGRYdGFPQWh5TXE2TGZCUktCVUR1dEE2cFdhbGFQaHdyQzh2V2Q5?=
 =?utf-8?B?SHFNMm1JTGxSdmlpZlY5cTY4eHdEM1R5aUtBVGZCQm1LV2V3RFIrNFp0R1hE?=
 =?utf-8?B?RDd0ekd4SGROck50K0E5eG5IYXc2NnRUYlo0NWU4clozcXR0YnprSm5LTzZQ?=
 =?utf-8?B?MHFXM296RUxEVWNkNzVuU1JsRitJbDBOVjJQZ3BtRGhCSkcvYU9QcVpEcjV1?=
 =?utf-8?B?eVFsT29jRE9KazBuazk0QTVzSTE2VHVBdHkwTVZJOXJPQzAyWEI4SWRrNERF?=
 =?utf-8?B?VEhQRzQzeXdlYXFsQjlYUkRqT3FZTVFEd3pkamhOUTNaM2U0M01UY05kNlQw?=
 =?utf-8?B?TFAyRVNhRjJBWW0rMjhVYk1UOXhEcDU3Zno1aWNXSndMbDdZMUFaR05JQ3Na?=
 =?utf-8?B?dW5QTm9XNHdaTm5kRVpWb3VZWDB1ZXVidjdEeWtPRUJZb3hjMWhmUzcxMGlY?=
 =?utf-8?B?ZERWRHJsQ0Z6UnYrbUlQNlkyZURQR2h6a1lKQS9IWlU0bUkvNzFRdU9iUXpR?=
 =?utf-8?B?SzBYdmZ6ZHlVR1JmRnB2d1hvUzJpUitueTlVQnRSRzNybWJMaFNFOVRlWWI1?=
 =?utf-8?B?MG5ObjhEemdXbTROZll0WXk1WEVrZ2FTS3pvWWJ0SDZVdjV1d0JYRVV4aUJ5?=
 =?utf-8?B?a2lJaDJyZW91Z014VFR1VW96VzRmKzdYUUIzOXFKWDBqSWlLYmhqTUU3N1lY?=
 =?utf-8?B?ajVEUW1CQmpXZ21nRmM2SHlYbUZLeDVOa29HdEc3aCtkRDNSajJzVHFZVDRv?=
 =?utf-8?B?aWVyUjJoVzJpOEtWY2xBRjlYeWVDWjFJTlZ4VXViaTdONDhjOXExdThRVldT?=
 =?utf-8?B?RXBvc1YxQlF2ME8yS2ZZbnNheHJhYjF6aHVCS205ZzJSeU5KWHBsOGk2NGZK?=
 =?utf-8?B?RzlnRTkwcWhJNi9kTVhKM1NFNVpZR2liN2FjRmZxMi9iTkkvZnFxdkRNZkdz?=
 =?utf-8?B?S2gzVWx3S1ZsMmdxaXVNbk1kMjJ1c29CT2oxdWxkNXBudkl3Z0kzR3dSWUNq?=
 =?utf-8?B?T0Y2VXBQOHI5RC8xSzY5QjR1OHJ2N0E0TzVhY3dxZmJYQkhFb1V1QnhmTms5?=
 =?utf-8?B?VVVlMUhzUFQ0V0VZS1hadlRSdGhCbm9VMjhOaFdGSDlubW02aHZuc1lva3RB?=
 =?utf-8?B?VG5JL1BsajlCZ2tHNGtmV3FCU3kreHdHSXZrR0RpNVh4VXVYSDZpT3VJTWY1?=
 =?utf-8?B?S3VkbXlmMGtrempzNFlSVE90TG5zWlNwY1E3N2Z2UE15TzJkaHFEcW43eW01?=
 =?utf-8?B?NEIyVHRMNm4zV0c3QkQ0N29mMTVQQ2hqa0Q2ZDVDa2NTTXRIMERMM3BhU1Nk?=
 =?utf-8?B?Rm5yTFlMRWhjOTRyZjhneXZHbHFvdUpmK0UrdGhSWDFLdVY2U2FUd3pOUFMv?=
 =?utf-8?B?eWRQWTRLK0ZMaDFUU0NXVDNIM0tDaERNQmRzU3dJQmIxdERjZGJEeTU2eXU3?=
 =?utf-8?B?UlNSVVptOVBORU5qUU44RHllZ2xQclUrY3NURjBaV00vRklsbVVwVUorTFEx?=
 =?utf-8?B?SzBVcnNsWms2WVJNT2lLWUdCY203bWUyMnF6aGRuVitjNC82c21saU5sY1BM?=
 =?utf-8?B?RGN6TExzNjBoVTJ2aE9KbzhoV3E3WGgwM3JNZTRhQ3UvM2ozR1o3UFkwVXYx?=
 =?utf-8?B?eHYxaG9UaFh5ei9FZko5Nk95Q085cVRBNUp5TDlVQm1zQmg2THRQYUtjQ3dF?=
 =?utf-8?B?djVKTXhYM1A3elE2TnZ4eUNpdFZoREtTOGJyTzlrOU40VU4xSE56SWZWV3Rq?=
 =?utf-8?B?K29mTzUrUXEwR3R2dE9vaEdUUVhQb20veFlhRklsamVybVZWMlJNdmZvYkdK?=
 =?utf-8?B?KzBwZmlBMm1BQnpBaDdDUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHNhT0ptVER0bHA1Z28wZDdURFJ3NEE5NzZKV1lsOFYzRFl0bVJ3am5hT3c2?=
 =?utf-8?B?bTlENEJ1WW1XZ29kYUZWbXV5cTRUWjBGNFp2K0wxMUVxdTh1L3NYTmFhb2hC?=
 =?utf-8?B?NmNzNWtVNzVwSk40cTBpaEEwQ3VEUWJBRFdBT1NESFVqWTU0VFVTYk0vdWlD?=
 =?utf-8?B?UG5CSy9DZkR1MkYvZTNtRE9XMVZKTlVqVk1iQVF6OXY0UnVza2YvbmM3MjZv?=
 =?utf-8?B?N3ZReUp3TWpWSGN1R1JSb0NTbUprWlNQTG5RQzFWT0lsdzR4N3Vha1NrVnJw?=
 =?utf-8?B?d3JGTHU4RGloZkptdWZhUDhrQ1Vabm1UNFpsTEJzZVR4cmJWc0ZnSnRKZDJG?=
 =?utf-8?B?RU8vV05PYU44amUwcEMvZnBsdkpqc0xEZXU5a0l5ZjVVb2pHdnhJYVZZTGFp?=
 =?utf-8?B?ZGxiYlErSzRXRDJIaUNIQnhQQUJWVDZPK3hQbXlvamh1RVZaQ3JvYmVnTE9G?=
 =?utf-8?B?ZWpBdmFZSUJESkFlZTE2emo5cFBsSFNndlk4TERRZjU2N2dqYmhUdzFPZzNU?=
 =?utf-8?B?a0N3Rk83ZmZrNlVhYWVaU2tGSTFiQStYclFROHpMVmJETUt3MEhhSVlSWDFR?=
 =?utf-8?B?WlF3ZXNlMVBWMVJTM2pYMmgyM0FIZm9QRGFDNnU1NlhHY25qMzIwMDlFeDh3?=
 =?utf-8?B?KzkxRC95ZTNEUzZQSndJQ094ZmdTTHpOb1ZNOVNLSUl0UklOOXExRzc2eVp2?=
 =?utf-8?B?YkphdmE1MHBQbjJMU0hrek9MMGtyUHBVRlpsTGxIdGcxbFEyRERiY0Zlay91?=
 =?utf-8?B?Q0lKY3hxMFdOWEtHcStSYjhET3hnbUxUUkpQTE9EbTlTWHFDakFsenVUZ2Nn?=
 =?utf-8?B?WkgwVlpIeHlXdE1PUVNyMVpqSE55STBBSnUvUHJYWEw0OW1wNmRMVWdWcGRl?=
 =?utf-8?B?WHVmaWl4aEl5TlY5U0tYdXNtbXQvUEQrN0FHbHNUNXFwcUxQZFFNNE9hQlpt?=
 =?utf-8?B?cXd4ZStFcjZ0RDcrSmYvNG9mUEZNeHFXTmVkc3FrOFJPbmJSbFQ3Rks4VGJ0?=
 =?utf-8?B?bHB2OWlCZ1hRdlFKdHBvZVY2bDZWaGxqNGtEUUhMdzhCemVDaHVNRUxETE5z?=
 =?utf-8?B?TXlqZEF3VmFrNERnUE9CcTVoUUh3b3ROa0xqQmtwNzZGV3djanN4WU5KQ05j?=
 =?utf-8?B?NWNzMC8vZFpNTW1saGZ1N0RiWjVxcEx6VUR3Q3RhUmJXbUNlWmdkT2VHMjdU?=
 =?utf-8?B?dVloclJ6ZzU3SndIMTZTblBWa1pWWWY4QUlPbVFPY3U3VGQ0elhCRmxFWmcr?=
 =?utf-8?B?TWFMS2tSa3plVVpXcnd0eXh1VUFTRjlmamZYK1RKY2pBY1FnL1IvODlvLzNh?=
 =?utf-8?B?U0cza3Z4L05aaE1oQmtEVlZLK0Y3WE0rcFgrZG10SUw5UDN1U0dweWQ1WUIw?=
 =?utf-8?B?R1Zjd3ZLNitPZDcyVGdOZXl6YlBjQ1pzanUycFdBelRJNW1jbitZN1djeER0?=
 =?utf-8?B?WXprZTh3VHhSeGJiZU9MdTJtekF5d3RwekFCOVRLdVREQ0h2eVBGVWh5eWE5?=
 =?utf-8?B?b0pUTGk1UGVlZ0cyYTErOEpuOEpUamdMbW5ZRFgxT3FmU0VkM3owTHRBWHQy?=
 =?utf-8?B?STFkekNwaTNHaWJUcEYweDhOWTJCNEtudVJkcTZya2Vxbk5nT1NBL29telZS?=
 =?utf-8?B?anE4SUx6dkk4YVZQQ2Y2eFVZUXd6ckRqT3hrNzVVcXFENS8xaitHbktYS3JH?=
 =?utf-8?B?MHZSVlpVem9zbnUxaXFQRmRZRFZRVENONFUzOHFncGJ6czBYdHZEbzlHSnI4?=
 =?utf-8?B?NWJUcHpJLzU1RTQybmVVY2RkbGNkL2l4cWhCSk9acTZiL3cxbG5kdWpGdjFX?=
 =?utf-8?B?VU4zY2htS2dOSmFsT0lmSVZnSDFaZ3dmbTE2aitFeWZ1Mmp0RlVLYW5VNXVS?=
 =?utf-8?B?bkZjdWVDOWdoOFRsbVhITzVqb0hOSUFMeGZUNzdtWlZWV3FTTm9iUzhsL1Vx?=
 =?utf-8?B?TWJ5cGNsVGxIOVUxSDl5OGZwNm50clBXaTZndktNK0pMYU5ZSUp2YW9BMStS?=
 =?utf-8?B?V3lQQkcrc1ZrenQ2ekZVOUZ1QWowaDRzWk85ZGkwK3RUWUVSSCtBdkU2dERr?=
 =?utf-8?B?VTR1eTM2NGZWM2lIV3VrczYyVS9MUk1wNFRVM0FCa0NnK2NqRXBnN1REL090?=
 =?utf-8?B?aTJxQ1VrTDBMRFNBT3hWTWptQ3d2MmIxd1FkY0VEenBCYmdFblEzVTdUMWtV?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4737c64d-3c4b-4811-4aed-08dd4ab283fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:41:13.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJfc8EkFicwGuXyj008A7huXQZKL7tnpLbHoPxg7cxRMBt+FfCgqrEN4P9yXMEGo16NeI6AQVekyKcQwcNTYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6804

On 15.01.25 15:10, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This may be incomplete. Specifically the link to the SMI document cannot
> be recovered - if that ever existed.
> 
> Besides that, this drops obsolete i386 installation instructions and
> underlines that bootstrap needs to be done even with the tarball now.
> 
> Reported-by: Luis <luis@eichitek.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Philippe, we are missing a link to the README.APPLICATIONS on 
> doc.xenomai.org, aren't we? And when will those changes here be picked 
> up again? Did I have to trigger something? Problem with remembering 
> stuff you only touch ever other year...

Gentle reminder for my questions.

But I'm merging to master now - maybe magic that I forgot will just happen.

Jan

> 
>  doc/asciidoc/README.APPLICATIONS.adoc |  6 +-
>  doc/asciidoc/README.INSTALL.adoc      | 89 +++++++--------------------
>  2 files changed, 24 insertions(+), 71 deletions(-)
> 
> diff --git a/doc/asciidoc/README.APPLICATIONS.adoc b/doc/asciidoc/README.APPLICATIONS.adoc
> index 4447bc05a8..0a4f109cb3 100644
> --- a/doc/asciidoc/README.APPLICATIONS.adoc
> +++ b/doc/asciidoc/README.APPLICATIONS.adoc
> @@ -5,7 +5,7 @@ Running a Xenomai 3 application
>  -------------------------------
>  
>  For _Cobalt_, you will need the real-time core built into the target
> -Linux kernel as described in link:installing-xenomai-3-x[this
> +Linux kernel as described in link:../README.INSTALL/index.html[this
>  document].
>  
>  For _Mercury_, you need no Xenomai-specific kernel support so far,
> @@ -17,7 +17,7 @@ latencies.
>  
>  Any Xenomai-based application recognizes a set of standard options
>  that may be passed on the command line, described in
> -link:application-setup-and-init#Standard_Xenomai_command_line_options[this document].
> +https://v3.xenomai.org/application/#x3-command-line[this document].
>  
>  In addition, the *Alchemy*, *pSOS (TM)* and *VxWorks (TM)* APIs running
>  over the Xenomai core can define the clock resolution to be used,
> @@ -36,7 +36,7 @@ i.e. +--alchemy-clock-resolution=1+.
>  Specifying a resolution greater than 1 nanosecond requires the low
>  resolution clock support to be available from the Xenomai libraries
>  (see the +--enable-lores-clock+
> -link:installing-xenomai-3-x#Generic_configuration_options_both_cores[configuration
> +link:../README.INSTALL/index.html#_generic_configuration_options_both_cores[configuration
>  switch]).
>  
>  Valgrind support
> diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
> index 31ab801a50..60f1f9149b 100644
> --- a/doc/asciidoc/README.INSTALL.adoc
> +++ b/doc/asciidoc/README.INSTALL.adoc
> @@ -16,12 +16,6 @@ One of the two available real-time cores is selected at build
>  time. The dual kernel core is codenamed _Cobalt_, the native Linux
>  implementation is called _Mercury_.
>  
> -[NOTE]
> -If you are looking for detailed information about installing a legacy
> -Xenomai 2.x release, please refer to link:installing-xenomai-2.x[this
> -document] instead. Please note that Xenomai 2.x is discontinued and
> -not maintained anymore.
> -
>  Installation steps
>  ------------------
>  
> @@ -70,8 +64,8 @@ $ scripts/prepare-kernel.sh [--linux=<linux-srctree>]
>  
>  `--dovetail`:: specifies the path of the interrupt pipeline (aka Dovetail)
>      patch to apply against the kernel tree. Suitable patches are
> -    available from the project's link:/downloads/dovetail/[download
> -    area].  This parameter can be omitted if the Dovetail has already
> +    available from https://source.denx.de/Xenomai/linux-dovetail[here].
> +    This parameter can be omitted if the Dovetail has already
>      been patched in, or the script shall suggest an appropriate
>      one. The script will detect whether the interrupt pipeline code is
>      already present into the kernel tree, and skip this operation if
> @@ -106,7 +100,7 @@ Xenomai configuration options are available from the "Xenomai"
>  toplevel Kconfig menu.
>  
>  There are several important kernel configuration options, documented
> -in the link:troubleshooting-a-dual-kernel-configuration#kconf[TROUBLESHOOTING]
> +in the link:../TROUBLESHOOTING.COBALT/index.html#kconf[TROUBLESHOOTING]
>  guide.
>  
>  Once configured, the kernel can be compiled as usual.
> @@ -143,7 +137,7 @@ is expressed in kilo-bytes. | 256
>  |xenomai.state=<state> | Set the initial state of the Cobalt core at
>  boot up, which may be _enabled_, _stopped_ or _disabled_. See the
>  documentation about the
> -link:../documentation/xenomai-3/html/man1/corectl/index.html[corectl(1)]
> +link:../man1/corectl/index.html[corectl(1)]
>  utility for a description of these states. | enabled
>  
>  |xenomai.smi=<state> | *x86-specific*: Set the state of the SMI
> @@ -167,60 +161,25 @@ The examples in following sections use the following conventions:
>  
>  
>  [[cobalt-core-x86]]
> -Building a _Cobalt/x86_ kernel (32/64bit)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +Building a _Cobalt/x86_ kernel
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> -Building _Xenomai/cobalt_ for x86 is almost the same for 32bit and 64bit
> -platforms. You should note, however, that it is not possible to run
> -Xenomai libraries compiled for x86_32 on a kernel compiled for x86_64,
> -and conversely.
> +_Xenomai/cobalt_ only supports 64-bit x86 platforms. You should note, however,
> +that it is possible to run Xenomai libraries compiled for x86_32 on a kernel
> +compiled for x86_64 if that kernel supports compat mode
> +(CONFIG_IA32_EMULATION).
>  
> -Assuming that you want to build natively for a x86_64 system (x86_32
> -cross-build options from x86_64 appear between brackets), you would
> +Assuming that you want to build natively for a x86_64 system, you would
>  typically run:
>  
>  ------------------------------------------------------------------------------
>  $ cd $linux_tree
>  $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86 \
>    --dovetail=patch-X.Y.Z-dovetail.patch
> -$ make [ARCH=i386] xconfig/gconfig/menuconfig
> -------------------------------------------------------------------------------
> -...configure the kernel (see also the recommended settings
> -link:configuring-for-x86-based-dual-kernels[here]).
> -
> -Enable Xenomai options, then build with:
> -------------------------------------------------------------------------------
> -$ make [ARCH=i386] bzImage modules
> -------------------------------------------------------------------------------
> -
> -Now, let's say that you really want to build Xenomai for a
> -Pentium-based x86 32bit platform, using the native host toolchain; the
> -typical steps would be as follows:
> -
> -------------------------------------------------------------------------------
> -$ cd $linux_tree
> -$ $xenomai_root/scripts/prepare-kernel.sh --arch=i386 \
> -  --dovetail=patch-X.Y.Z-dovetail.patch
>  $ make xconfig/gconfig/menuconfig
>  ------------------------------------------------------------------------------
>  ...configure the kernel (see also the recommended settings
> -link:configuring-for-x86-based-dual-kernels[here]).
> -
> -Enable Xenomai options, then build with:
> -------------------------------------------------------------------------------
> -$ make bzImage modules
> -------------------------------------------------------------------------------
> -
> -Similarly, for a 64bit platform, you would use:
> -
> -------------------------------------------------------------------------------
> -$ cd $linux_tree
> -$ $xenomai_root/scripts/prepare-kernel.sh --arch=x86_64 \
> -  --dovetail=patch-X.Y.Z-dovetail.patch
> -$ make xconfig/gconfig/menuconfig
> -------------------------------------------------------------------------------
> -...configure the kernel (see also the recommended settings
> -link:configuring-for-x86-based-dual-kernels[here]).
> +link:../TROUBLESHOOTING.COBALT/index.html#kconf[here]).
>  
>  Enable Xenomai options, then build with:
>  ------------------------------------------------------------------------------
> @@ -293,9 +252,7 @@ although this is not mandatory if building with `--disable-tls`.
>  
>  - If you plan to build from the sources available from the Xenomai GIT
>    tree (git.xenomai.org), the autoconf (>= 2.62), automake and libtool
> -  packages must be available on your build system. This is not
> -  required when building from a source tree extracted from a
> -  link:/downloads/xenomai/[release tarball].
> +  packages must be available on your build system.
>  
>  _Cobalt_-specific requirements
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> @@ -304,7 +261,7 @@ _Cobalt_-specific requirements
>  
>  - An interrupt pipeline (Dovetail) patch must be available for your
>    target kernel. You can find the official patches issued by the
> -  Xenomai project link:/downloads/dovetail/[there].
> +  Xenomai project https://source.denx.de/Xenomai/linux-dovetail[here].
>  
>  - A timestamp counter (TSC) is required from running on a x86_32
>    hardware. Unlike with Xenomai 2.x, TSC-emulation using a PIT
> @@ -329,10 +286,6 @@ source tree:
>  $ ./scripts/bootstrap
>  ---------------------
>  
> -If building from a link:/downloads/xenomai/[release tarball], a set of
> -autoconf-generated file will be readily available from the extracted
> -source tree, and therefore reconfiguring will not be required.
> -
>  When run, the generated `configure` script prepares for building the
>  libraries and programs, for both the _Cobalt_ and _Mercury_ cores. The
>  core-specific code which may be needed internally is automatically and
> @@ -776,7 +729,7 @@ $ dmesg | grep -i xenomai
>  
>  If the kernel fails booting, or the log messages indicates an error
>  status instead, see the
> -link:troubleshooting-a-dual-kernel-configuration#Kernel_log_displays_Xenomai_or_I-pipe_error_messages[TROUBLESHOOTING]
> +link:../TROUBLESHOOTING.COBALT/index.html#kerror[TROUBLESHOOTING]
>  guide.
>  
>  
> @@ -792,7 +745,7 @@ $ /usr/xenomai/bin/latency
>  The latency test should display a message every second with minimum,
>  maximum and average latency values. If this test displays an error
>  message, hangs, or displays unexpected values, see the
> -link:troubleshooting-a-dual-kernel-configuration#the_latency_test_shows_high_latencies[TROUBLESHOOTING]
> +link:../TROUBLESHOOTING.COBALT/index.html#_the_em_latency_em_test_shows_high_latencies[TROUBLESHOOTING]
>  guide.
>  
>  If the latency test succeeds, you should try next to run the
> @@ -813,7 +766,7 @@ recommended to calibrate the core timer specifically for the target
>  system.
>  
>  See the documentation about the
> -link:../documentation/xenomai-3/html/man1/autotune/index.html[autotune(1)]
> +link:../man1/autotune/index.html[autotune(1)]
>  utility.
>  
>  Building and running Xenomai 3 applications
> @@ -823,11 +776,11 @@ Once the latency test behaves as expected on your target system, it is
>  deemed ready to run real-time applications.
>  
>  You may want to have a look at
> -link:building-applications-with-xenomai-3.x/[this
> -document] for details about the application build process.
> +https://v3.xenomai.org/application/#x3-building-app[this
> +page] for details about the application build process.
>  
>  In addition, you may refer to
> -link:running-applications-with-xenomai-3.x/[this document] to learn
> +https://v3.xenomai.org/application/#x3-running-app[this page] to learn
>  about the command line options available with Xenomai 3 applications.
>  
>  Migrating applications to Xenomai 3
> @@ -835,4 +788,4 @@ Migrating applications to Xenomai 3
>  
>  If you plan to port an existing application based on Xenomai 2.x to
>  Xenomai 3.x, you should have a look at
> -link:migrating-from-xenomai-2.x-to-3.x/[this migration guide].
> +https://v3.xenomai.org/legacy/migrating-to-xenomai3/[this migration guide].

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
