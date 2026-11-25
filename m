Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585505;
	b=mu2ccX0aX95eWcBcOmOP/zs6W+XfuOxaD58r3962ADqmrpfempdhlVBWYdTuGKuyszAl
	 0mmAWk042WypOYwqt4SFXex4PHI1ZRuKArL6f0vDd7MmGZZoyKIwRasy+5MBgmZRdFinc
	 otAaSiKVel/u4Hj5iBmePw9gDYdLaktbjCrGww5A3GcTnKiYJt376C62VdnzLHPts2qxJ
	 PHTq0pXC+LaLmhdu5XQ8WmPDG3rpd+eKLIykQ77pSkB5+2wLcUgM/ys+gJCX1aAKri5nd
	 3frb/FWtY8ww8jnwtFFyC/ozO/QviMuwoq3PkHWRZkLgDVTmlUwRJSGfE0u1R+V41aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585505;
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
	bh=NQO7O0K6lnQNp2yTOLtx2HuWDz3NegUjBjsYgkIn+js=;
	b=25HGi8vhvupaAhURmIgt7ZCp9tt87vL47uor2Qn7qaaiq8tR7L6hOa2VDOqSFCUUVIGj
	 kVEu/s5KoZt1QPwsa7Njm+rdJfju91+JsSz2dvyg2SFZ263ONtZKcM2ezaIQNd/cCB4f8
	 QVwSF/bav8nIUTV2Mnphoado51DIMLxKSzmYp4SczaLBMoO9wov/WJmf92vcYE2zIYinn
	 Ll8GzSQDGAMdgqBPDS8FxdORf4X2tV86uIUCO9XZHVlTf2jR7S71J963YtnyhSsuBn5ch
	 i4MjmZTL0ZNnGrdjv//FcWAaPD75coZ/NGgCpmi701IhyDRkOoPJIa0y1DuaehDWq+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=GDL0WAAA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.30
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC5606A323
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 05:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6CC5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=GDL0WAAA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEZ6+A9UnPHj+qQOyMHhFhWmlRGPJ2X2zzZpCd4qHu1PeeTkHqMhlM5Ko351DCtpPHHGI7AJP9WvnyFpaaOmUcLqW/FQCfzYeRJm/QTGYL3apfWANE/Gy2Sqgt+nhRCUsezIeFd34mFN/51+mFXSy8+Uggwf6pA8pQYhzu0TBzdC9zTup3Lm8pALnxWjjJxlQBxaW6wsbcKUFPVkO0IdR3RZqnfs5BUwh2i+oGIXs+VXnMqqs+Lpz+2JF1HEg/k6MVznGJeLISmArwxaVj7WPqQTQkRS40viqp2Xw6GFjZK4bPKuTAxY0S4IHyVufaLc6JEWGiISTkd4BTO9SARDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQO7O0K6lnQNp2yTOLtx2HuWDz3NegUjBjsYgkIn+js=;
 b=D/pDjhowKQ6tcQ5Fdlim07tYhnOh3fmiNnhhVIOx6qjQ0qG2ty/HpdNCJwcXOel0ywdYunmGUzkZblKHW01rnC13o6LiaEEp1X/hULp25AVMOgLEYKP3l6qh7/gmkfzWEnbISkhPGX3ZZNsULk41hpvsJ9/OQsLrQrkuY6qsvlBwHe2HqxBHCCyftrTFZvgWm/To/mtxzCWbb4KYK0q9sNbQ4PJWAvIw/+C+1fj9A96ftTXKLbjefIMY1O3zszY46+Ig6aMmMtOZVc4OPZTsT5w3VqxShJf+CHZHvD26aXdIS9LxAVfhV41Pyot6Y0mtQhSlAvd+bHZgvxzEufEPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQO7O0K6lnQNp2yTOLtx2HuWDz3NegUjBjsYgkIn+js=;
 b=GDL0WAAAb5mjCgCYjKk+1S23BtL5a0KczPglwJnEnH2GQiuEN8K7vUJH9t1zcdKoHt5sd+tl+In3DPxxhe3cpGNj/wwFBxoMnINMMLJxvNjX8eLGB/aVbxD+6Izi+rFqwaBTyzAXk3oqxcfYzN1SzuJA8Zf8lHx4qBmFUhm1gAM/nLVumgP6dwiKNJmvDAJx5YPNUu6qXT7xCZobrVC+ACglKhLTnyg5A4NfQgnvRxHvUKX1RVNeCm/jZn6eX2wcdVvzB9XSW1GS+xWjAWJBwVyFAgFsooYbgyKsyMsl04Gc5xaXtwfEbj5bkHBhEWYXQgjLFFIqpj09BcKjtOZZUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV4PR10MB941218.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:41e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 05:45:01 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 05:45:01 +0000
Message-ID: <907cbf6f-9277-43be-979a-c6ab0a030cca@siemens.com>
Date: Wed, 25 Nov 2026 06:45:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure.ac: Fix typo
To: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>,
 xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at, Richard Weinberger <richard@nod.at>
References: <20261124213345.2245315-1-rw@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261124213345.2245315-1-rw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV4PR10MB941218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb0abae-89b2-4434-d344-08df4ab73f8d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|55112099003|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	6b7RaLAoYzj7EM961PlR5wlFD4xK5jBAQUPUd9j12FgrxlLspCsmyIrx/g5lLLOGfqlkuHNzPNx5UI1A/kuxN4vYrM9zTumrGRK8wnWg3nF8bowHHVyWRuNDgzqfu8OB1x6A48atQ/+jEhk7VcNY3iAXCDRtLzI4j3XxGg0gVqVqCURu8b7wib005u0h8iKehMB0Hd0Fj2zpA5g8FEEqGNDlqfRubTw+m3PhvwpBTiD2vDXFoZc3oZBeeWxPsTFpf82PLNuFAs9M3LkTjhrpdRuT7pT0hCbAPlwhHtcwxCJ+0a57bnRzymtzeTtN+WJjcZ5dyRZ//I0OhBaQG26wj59aOmvdcIBR6p14Drw9coqQ0wZLhtP02BLTJH9mbx5aW+uK0bQURmGTw53aD9I+rNcs4iweqr/kMcOTCCW2Mva00x1Tpw0V+QSKAx2TFlwesxoW0F1rrRBandX0TPTHjHWVG08aHlakZHSHPibCQf3eWxD8uMw6GQfQIUH4ZfT+OIckg80AUK7i3AG6aALvWH5V7zFmTOOwIcnAoJX9vmNaIZNVwXmlvldrDCVkPNxe2sFDQkphbA1yf9Xkco80FKOka9MN3bC671JcHFo95ja8uErGM499jsSv5UilpYPeaJX+9PDywM+Kb2OVHqxxLaTUQAOVls/AFdQmL2/ucD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(55112099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzF6SHdta2dJT2drQkZvQmdvMmE4TWFpUzloTE1KQWdCYTBGWVJlYXJxK05R?=
 =?utf-8?B?Z2g2L3NKMUpKamdQNlg2WW4wOEN0cTNNQlFJU0NHQWVQQWcvTkdjSUc0ZmU1?=
 =?utf-8?B?dkVuUHRDTlNna0xaUGNwYVBzT29IRms2VW5senBRTHY3dFNCUGNRd3dFRmdr?=
 =?utf-8?B?YVNZT3NQT1NtWWxIRDZQMm14cERxeldrblp6NnpLRWRNS3NUcUh1UHZrVW94?=
 =?utf-8?B?VnNGdTBITm1SZmRaemFGbE54eTJOd0NyUTIwRDN1WXZDa3ByVEp1S25ZZ3B5?=
 =?utf-8?B?R3dRc2RkbWNLeE52dUlaS0FPNHk5c1V3Q2xkeVVOdHZpNHIrR2o2SVdwWkNj?=
 =?utf-8?B?WHczZ0Nqdkpaak52QytZQTN5c05uWVZ0cUZzVEFsQVhYVjhUQzFwWmNmN2xl?=
 =?utf-8?B?dThObWxYSVVTdHhNSWp5OG9UTnprSElHd1UyNENSaVJSNmtTWXhZamQ5N3Yv?=
 =?utf-8?B?Mmh2STlzS001VVh5QnkyVWRZRjdWYjA1VCtBdXAyd0FRdjNMRXVSMVU5WmNu?=
 =?utf-8?B?dDQ1TVJjSHMzZGtQVWRWSWwvYkJtNTMxNkVJenI2NUZMQytTZUMyemRSa2NX?=
 =?utf-8?B?VlZuSWN1NmVqUTJ2enIrb1VBN0RUV2REd0c2M05DampoVzFEdUVMaHhzcGRy?=
 =?utf-8?B?eDY1ank2alR3RHhKbjFZVXdTVGxpK1A3TWgvS1NWYWROWHVGOWJnYWNzS05x?=
 =?utf-8?B?V1FRMVA3VkdPdDN6eFRZek1qYkN6WmlmOHFKa0lxV1lGcDJ0dGZaeHpYOGps?=
 =?utf-8?B?ZFlBa01sRVVSMloydGNhWFZlQUZtRWY2WmRKMHdLSGF2VUs5NnJDQXFUT2p6?=
 =?utf-8?B?UGdBd3dyRWlqNFFncWRhT1d2dnZEa1hIS1l2NTFSV3NiV0ZHYkgyL2hER3J2?=
 =?utf-8?B?M0NJYlhWWTUxSjVDbmgrSEhZUTBNWWpqcUYycEQxNHp3VUVwYUhoMG9CeGJ3?=
 =?utf-8?B?NVpNNlZrQ0hPaGtYeXJhMkh2a1p5NjcrNVN6WjVGRkhJVXF0d3M3S1ZJdTk1?=
 =?utf-8?B?SVR0d2p2Y2M2cnhVbVVpOGpQUHp2YzNLWjg2dlJYL3lOWGRoZ2JsTlZ0QXUx?=
 =?utf-8?B?MWh5YWhCeG9yMGhOdjdEQkkwVUVjeXR3SEJwYUUzSzU4ZDJINFNUNVFOb2t2?=
 =?utf-8?B?TlpkcmkzUENKbVhUTSs3MmNlV1h1TE1nQXNuNFdqdVJzODJBd21kN1Rwc0xT?=
 =?utf-8?B?OTJZdVZVSElUOVhQa0hzeFBHR2s0QXByRXdwMmIxb01PYXdBc0MvNWovL2Jj?=
 =?utf-8?B?MGVwS3kraVF6UU5xeTVPRU5qRDl1WFZHK1A0K3BBaWxNMXVOMTBlZXB0SVY1?=
 =?utf-8?B?Z08vTFRkaXZZZGZWaDRRRDFnbFpYczd4d3FROUJFbzFrMEYyR0IrUE10RWpz?=
 =?utf-8?B?R3N6NnVjejBBanI0SDZJM3p1MVRkdkNXT3pKbnBQd3g0MTBvVy9aclpIT04r?=
 =?utf-8?B?eDJOd0JybHRKaDNIMEhETkh4d0czTFl1b2w0Tm1IS0RqRGdjN2ZtRDFzdGtk?=
 =?utf-8?B?WXFmZlNXNXFTckRWRFlNUERZSXBUVjNQVUxjSUhuZlg2YzAxYVB2bDBNRDho?=
 =?utf-8?B?RkQ4MVlNSXFZSDRoZGhXK3Z1SUdqMGt4RUlzcVlEQ3RwYnQyMnA3RkxJMzg4?=
 =?utf-8?B?a3VUVFlld2N6TVhsN1JYU3BaeXNvVEc0T1RGR2JlV2VvUVAzSlJpMjdDQW1r?=
 =?utf-8?B?Y0l4dXFjSzJpSDBmb0FGQXVHSmczRGlIVkNSVXB0amwxVmdONW5VMGNyUFQ5?=
 =?utf-8?B?d1YxcUZSaFJrMVFldmxwV3lNaHduWDJ1ZVBnVy8wOUJOSjkvNGpDUjIyMnlQ?=
 =?utf-8?B?TzBYNERuelhZYjNlOVRiVERsQUNKeEZJRHZmVlErbFBZWS94MUozM0lDRDRm?=
 =?utf-8?B?OUhudXQ4S0ViQlRGa2dwN2RsV1R5VVZFdjExSlhEaFRkSEY2aFllcTArdmsw?=
 =?utf-8?B?YVQ3djZsSUkrZkcrdjhPcmJsR1BRbU1OWkdIY1FXYXRDTk51RTdZMWNYRmpC?=
 =?utf-8?B?bmsrYmhmcTVTOUdjQjdMbk5kTzQ0bEhGQ2dTY2MrUTJMQm9hVkthUUM2SE9T?=
 =?utf-8?B?ekJMekp4NEVIYjJ1ektlaUtOU1FtYWlhTnJxbXAxYTZ0b2d1ZnhBZG1xTXRS?=
 =?utf-8?B?dzZMSVZBR090QjZ5KzJYdytlVnc2LzQ5Z1FxTDRIb0ZlYWJQWklldlBEdHNj?=
 =?utf-8?B?Ym9tNlErMkp6VGZVbGg2NlRsYkg0WDcraTNsS0x6cUsyN08rTy9JVmFZTHk3?=
 =?utf-8?B?WWo5UFdOQ1VqbjB5VHZ5TEd0ajhmelIrNFc5ODhxckF6OVpkUHFjT0Vqd0pD?=
 =?utf-8?B?OGg4eXJKNU44dnVRZTl4RnZvdXJRU3ZhUWttd05SM21ubE5LNFhQZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb0abae-89b2-4434-d344-08df4ab73f8d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 05:45:01.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4Uiig1z0ZBNLbWfCmrVWg3yME1TyL0l77j7L1+8+uWCqALHBn2fYTGGNMZ4kSrnw4qF1PDg7XcuReSbcqBNiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB941218

On 24.11.26 22:33, Richard Weinberger (sigma star gmbh) wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> It's XENO_USER_CFLAGS, not XENU_USER_CFLAGS.
> With the misnamed variable, xenomai was never built with -O2
> on my side and caused funny performance regressions.
> 
> Fixes: 89c1436b3 ("configure: Propagate debug build settings also to plain applications")

At least no stable regression.

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 0d6dd87b6..d707fb11d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -743,7 +743,7 @@ fi
>  if test x$use_assert = x; then
>     XENO_USER_CFLAGS_DEBUG="-DNDEBUG $XENO_USER_CFLAGS_DEBUG"
>  fi
> -XENU_USER_CFLAGS="$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
> +XENO_USER_CFLAGS="$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
>  
>  XENO_USER_CFLAGS_STDLIB="$XENO_USER_CFLAGS"
>  XENO_USER_CFLAGS="$XENO_USER_CFLAGS -I$topdir/include/$rtcore_type"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
