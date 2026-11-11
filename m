Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794382818;
	b=hhCgs2RL+a0/LUspkG+eouTf/iPa4Ll6mg+UlVojM//JiAAFWuUZx0q8TV97YXAzwBp3
	 cE6+7PbV1X7osbG3vqldL7ixHgZoWLFSst7Ix61Nszcn0auW4TOxLcw3uGKcSiaLNn/RX
	 fBnEb32Z+vf1j3iVbs/UOsiyCCssWHbmbBVD1fuqBtp0MMPGTqHVkjX59xgHRL5UCXWbf
	 HCUuv5yfhgVlTYscSn+S5/HR2JX+0Th3zPkKjAVWUG59ipYi4HzM8l4omq4sOpBy+nJd2
	 CMY5K4dOpMBx1qS7IKYHgh7rXSmvs8hOcWEWu8otSo/Xv5pJJK9O8TSYwdVom6Q48pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382818;
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
	bh=BbQrMUPpRlHX1dKKtK52PJPTx+Qr4+EoJ3r0Pit/XJU=;
	b=PLh7iFPnuN3lzrmcBm+pakO2kU18bzhX7N742yb1UvrM0/DyLp/LFFcYMvqtXt2+BA+a
	 ZLjQTJIpXMrj+sqdmPpTegZkhnfaHCuhBImmMU4oLvEh687cCul/h8Ey30Nmr/F5FvXP4
	 8C6j1jXhkK+a9LvaQ+ZrZW5v8KJfRebz677xzqeH02yxZyDaDIKXXjBuAxJ7rXw3YvVao
	 nyWvM6Vuvf3wsbSMGxOgeqwsnzw03VB6jJYA2NPV6nyCZhe9M30l1IDX0frOGO6ALzqno
	 wAtWKwr+exxN7UUz8wW+lO9QI1wz7C7uLo/Enk9Ijni0WST+zvQkJBR7KdQ0SSfun7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=V6WloXyN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.44
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA50606A33F
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 07:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA50606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=V6WloXyN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtTzroMpAxQmUB/Vx4lmJAkXkCYpyJB5q3nP2eL/xh3usge+ZZ+z2aFTl7MvQw0aBC/o2/k/x967afvXeNBx+hLqLn2u+xYFvo6SFYG3Ot0B14vjnuDiiWeqHZhyU+7oay4zSuy7JyVmoD7cmOZTBA0juEJFuw2IszQgazzFyMwW20ez5vAOGodQeMjKA7Lj8oMiKKNzq/TTqhCpHtg3GgCJf8VKXgTrXdrqR+0YhbWmdoL2z6jnOAbpjGrHG/y5kuH7iJelVgp9HcqSv0GQ3BA30Mt55hJzODc51ZJ+s+ga1lhCk7mcMzgjEUJaOl3wL19PTjymhBmcCPTCXY08vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbQrMUPpRlHX1dKKtK52PJPTx+Qr4+EoJ3r0Pit/XJU=;
 b=C+JhBqmJ9/E6eogTav/LtxmfCKee9omwbMc3RF9cXDJhN2s7z0FYmKnwW62MjBbD+pw4our6ujZpejDzDP0PnoJVXavT1czeMLDv6XDqM/HQkuCT/ebHc5Tqs+FauPQnuu6q3uGxeeanAqORxMM3Az2xL7qDZidEQaRNlPq/n63pZ/3+bO3K5COq8F2Ru/5XEmiTKQCFtIj+NKnB8cdvahESS79Ojn3Lfr0v/3foJQKJDTZMXLLjdqFShid9HZk6VVWb4RJZq+EZ42QZaTG3resDT8c60dfddC0b1l8eLu8sdIAF1aug/lqWbn2bZ8LJn+WSV8CcG20zLndEO8sz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbQrMUPpRlHX1dKKtK52PJPTx+Qr4+EoJ3r0Pit/XJU=;
 b=V6WloXyNs+Nu++ZP7HuRaJd29yjmCpMlvdMPGKdVCnF9ZI6hVOYtu4dI9elaT7li8YhDqggkBZvEP2tKTF+tFNtMLq8j3tG00UK4sUDWdkWYW/O+o7+EeQa6YcCHlX8Kk3M0MhYjSuMEWh/Jc8mQvWONfjzjoA+Cn0lLrKF8znGgXV0kxacGMfNR3a2VqisqW1lDIcjeLPRMjb55S07FLUJNj4ANCYyU72Js4eQ9G+8szw1RmrpdoUfuSgmrQtSy8BpgmmTWE8A3oVT2Ebvkz3Vf/70eIGJhVzl+MCKNfYOXo8nfTtOd4CTBAkbZp4Xbtz8vpLLHTJvPHITN30pEkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB7740.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:648::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Wed, 11 Nov
 2026 07:40:14 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 07:40:14 +0000
Message-ID: <4c0e980d-32d8-4b2a-b369-ecfb6f190f9e@siemens.com>
Date: Wed, 11 Nov 2026 08:40:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH dovetail 2/7] dovetail: trace stage switches
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20261110180847.633167-1-tobias.schaffner@siemens.com>
 <20261110180847.633167-3-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261110180847.633167-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: c83c8807-7dfb-480c-0965-08df3fc70656
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	0dm3NthAfSBgZ1DryO/8JifjMBe8bFAhB5Gkog7q7Ex/HUv5e508LtOe4bfsOROR/Dfa8nXwdpJVOlDh1WrZGHFuK0yd6RwDGNSw2E2wAyncN6gdETBuSXoBjw2f9uQwM2nmO5Q+nxfT4P3StjpRq80trAo7KRgYBhgtf8VvIP7iAWSF96nCh6gQITWK+8o89cKjDtBCZDYH1Tnf5vqiyZeYYNje2ur2C2N9TKEgJY7cIPHVfpHeJ/gfxJzZxGnNSEz8oZ9CdrpZRIvpEMyNj6qmdFxAO8fO9rgUDhdwF4wY0mCJgmkPUX4hNRXpedZDaTgWlUqGND/yN1SV7HC3epqqQ1aB128xtwIc9H9BpVlSiR8LI1Fj/Cf/rNAWA3DwUe6r5ygQpLib09CZkERsaQd6UxGm5pV3qZ156PvCL5VGFpnX+GKqIwbFaVs7d4OgoXssfX6zbQcXapq3s9C93JmJCJ7M6+KNSnoJsl/ceiwtca/QY4/e/iJpF2Aa0I4rwZlDFPLbp1FlWaycbHR1ncvRp6JMqC34EgoYq5hycqsCWxfmkxcIHauRrWEuQfRHEPUiAPzmjalNTu/GiOX86c0kqkEjOTMKKMApCUFrIsEiqSuzkIRnTbzwTcI6M3wyAEa8mQzJoDHscglZYeUY3kWIbRT4tJ2FBMoIkEhT82g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3N2aEVvcDlhY3p2UDRmZ2NDMjRtaFcxemRIU3J0cXpJSnE5LzlQZXg5Qnpi?=
 =?utf-8?B?NEFFUUZENzdSQTFWMXU1c0taL1dZWWFjVDF6ejkwa3p3bUNwa2RZYmdNQ1Y3?=
 =?utf-8?B?NTk4aVREVnVlZEt6cXdYTkpvRDc2WjFNbXVrWW1ONHpLMmN1MG1ldE9IY2R5?=
 =?utf-8?B?MlplTGIzUEpFNWo3K0RvYm16T25RRTBBNU9QWGZiNy9pODQ4NlVxd3B5dVFt?=
 =?utf-8?B?RXpma2RHQ2hNaE1XTmJFR3c5OEU0OHBPVW1hZjdqSGdyazVFRXdRcTk3OExL?=
 =?utf-8?B?cE5HeGE4QVU5djVVNnBLcGtYSXB2NHRGR2FoT1g4M3lQWHZCcmEzRk15dnV4?=
 =?utf-8?B?NUxYRCtBd05WUVlSMEdmSExnKzI2eHc5N0hzcHZiYkdTZ1U4WHVUVjBQVVp1?=
 =?utf-8?B?R2VLMGJtQUdsZFNaTFNwZ0hDektWWG1FSW9kMDhQRDVrMzlnSWdQOHo1eEcv?=
 =?utf-8?B?R2lGUnpndjl2bytlSTdPYklCd2ZqdzNOTzZ0WnFCbWFRNUllTkY1QlZMMjZl?=
 =?utf-8?B?cjZ5S2p5bkNYWlJ5cXBpTmZUaXZidFpxK1dkNHYrTzhIVXBCOG1Zdy9aOGhv?=
 =?utf-8?B?aXdXVFlmSzFlQ1hFYWxTVmlkajgwUmx0ZnlNVW1hR29XRk5EL2NBdGFmWWpu?=
 =?utf-8?B?bTJXRkZ6UzVudkVjUHB4RnFjRVhqWFBxMjczc3hlaTZXMjhSeEFPbW5Kb3BV?=
 =?utf-8?B?Qm0ycjNhWnUxMFdEZld3RlRnNFMvNSttRG9oSFVVRTRLbnhZTVBweUZtTlR4?=
 =?utf-8?B?cjlTd2EyeFN6K29TcG1aSFBkd2txMUhuT0FRNzZ5Vnk3cm5hVmNud0VVYTNo?=
 =?utf-8?B?bGl0UmhLVUh2ZWlkZnpVeG1XMkNROUltSXZSMlp0YTJhUlJsS0RzZDh5Rjl2?=
 =?utf-8?B?d0h5QnlPd3FrbnByZFZlODhyUXlkTW55MVRTYS9HeENlWjYyN3JaU1cyb29o?=
 =?utf-8?B?WWIwQ09DV2szdU5Eb3BqVUtwc25jeHJFM2Rab1RnVzVSR0I2VlpuMmpienNL?=
 =?utf-8?B?NXMxWTFGQVNucWVnS256YjRmQnRYcUZTR3J6Y1Vac2JYcXlZM2Z5TzRQeEVR?=
 =?utf-8?B?bDB2WldIOFlnS0I4bGs4bUtwUUxUNVMrNkxHQmJqN3FUc0dGZk94eEs0U2JN?=
 =?utf-8?B?aHdldGpwNTB4TlZjMm9xMTJIbFY0VkV4RFVGbC9JYmpVaTJTME5lTzUrSmZW?=
 =?utf-8?B?ZWxUM0hFc2hBZVFGR2tNOUtsUVBIVEZPWUVVZGlTN0d1NTEyTHdVNXFYVTIx?=
 =?utf-8?B?blBrRE1zeHZWNDFrMVI0bHM2dnkvVnRoQ2ZZN0xDWTdrNitHcXdVdm1NUmRS?=
 =?utf-8?B?c0RQZHgycHlXYnlPTWVWQjliRmtHYis1K3ZYTVp3TGltZGlnZWdqcjVaTWZW?=
 =?utf-8?B?SElSS2JNZG44UDdvbHNucHVnWm9INjlYTkdYTFpsSGtqYnNqYXRvTy9tbTJs?=
 =?utf-8?B?eGxSUDE1TnBuR2JVdGJJdDQxM1cyWDl2VVdKNlMvb3BkTExQR1Zxb3dEZ3hy?=
 =?utf-8?B?Yit4M3NIOFZkd2NnK3dKdHdxQ0Z1Mmx1bTd1YVhYSHBuZWhKcVFqWHlQVFVM?=
 =?utf-8?B?U3JTekk3OWRpYW1BcTJUQytzd1AvR1AzUWJMTmdmT09WdUJGdzFiaXlITVB5?=
 =?utf-8?B?VEdLaVplVjN2MW82emM3OVJxYk80U1lpVFlTMHdGZ0ZYa2tvaGlxL2dIMWRI?=
 =?utf-8?B?ZDhFUnc0ZVZONGtKc3EyTTVrRjFhNHBkdy9tY2x2aCtIQkNRTGF3NHJPaVdo?=
 =?utf-8?B?cCtxQThVYzVlUWZ4b2dpbGpjNFczemx1Ynl5SEJtaE1oZjRjZ2Q5dit5MVI0?=
 =?utf-8?B?Z1JKZ3Z5MEpSSGlFbWtOYWMwK1h0WlJRV2V3VmFtdS9qbWw2ZFFQN1ZHbFhH?=
 =?utf-8?B?WVgyZGJPY0NaZGlzcEIwenU3WXdXZ3dtREFSQVBFcjFXcDRiSWRKN0lyaHJo?=
 =?utf-8?B?UVZrOTlHVUo1NktmZ3MyeHc2SFJpWXR1ZjA4L1VuRzR6M0R0VnU2U3FFOXBF?=
 =?utf-8?B?L2VOWUJIKzZJK3ZSOElFOFRKTWZyNzJsV0NsazlCZ1hIUW94SlA4UFNrMHh5?=
 =?utf-8?B?bFUyYmowMTFLcFFlSE41YnlNa212bWlWVTdBVmwvTFZpR09MRUVNdURjZlJR?=
 =?utf-8?B?bXVpejFpN1J4VWhFZ0FYeGV4VHlONGJPQVkzbzF1NjRwK2toUWFyam9JcEE4?=
 =?utf-8?B?NU9Cejh0b04rYmJTc3Y4TGY0RG93eTV5VERoODl6c29QZ2VhaDVqZW1ZTC9k?=
 =?utf-8?B?U1dxUUxhUElOWHQvTjcxTTN1aUdMdWNjalFtUjdkRm1zVmhYY3h6ZHpHL2tN?=
 =?utf-8?B?YTdPTml0S0hmQkEzcTBIVFBVQkVSSXhJMm9WRGtnYThSVUZoZEJRQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83c8807-7dfb-480c-0965-08df3fc70656
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:40:14.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OARZlaAX9Dknu6tH0ywUpxCKbHqXXyscYE1txRSE+8zwmT4TAvP0ybMplPkNFB+lMSmv6RFa7U39fXDSk4LtPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7740

On 10.11.26 19:08, Tobias Schaffner wrote:
> Add tracepoints for a task leaving the in-band and the out-of-band stage,
> for use by the Dovetail RV monitors.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/linux/dovetail.h        |  9 +++++++++
>  include/trace/events/dovetail.h | 23 +++++++++++++++++++++++
>  kernel/dovetail.c               | 13 +++++++++++++
>  kernel/sched/core.c             |  2 ++
>  4 files changed, 47 insertions(+)
>  create mode 100644 include/trace/events/dovetail.h
> 
> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
> index b41ea0f8fc4e..5ab07e69152a 100644
> --- a/include/linux/dovetail.h
> +++ b/include/linux/dovetail.h
> @@ -18,6 +18,7 @@ struct files_struct;
>  #include <linux/mm.h>
>  #include <linux/thread_info.h>
>  #include <linux/irqstage.h>
> +#include <linux/tracepoint-defs.h>
>  #include <uapi/asm-generic/dovetail.h>
>  #include <asm/dovetail.h>
>  
> @@ -163,8 +164,16 @@ void dovetail_stop_altsched(void);
>  
>  __must_check int dovetail_leave_inband(void);
>  
> +DECLARE_TRACEPOINT(dovetail_leave_inband_tp);
> +void __trace_dovetail_leave_inband(struct task_struct *p);
> +
> +DECLARE_TRACEPOINT(dovetail_leave_oob_tp);
> +void __trace_dovetail_leave_oob(void);
> +
>  static inline void dovetail_leave_oob(void)
>  {
> +	if (tracepoint_enabled(dovetail_leave_oob_tp))
> +		__trace_dovetail_leave_oob();
>  	clear_thread_local_flags(_TLF_OOB|_TLF_OFFSTAGE);
>  	clear_thread_flag(TIF_MAYDAY);
>  }
> diff --git a/include/trace/events/dovetail.h b/include/trace/events/dovetail.h
> new file mode 100644
> index 000000000000..785a653252d3
> --- /dev/null
> +++ b/include/trace/events/dovetail.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM dovetail
> +
> +#if !defined(_TRACE_DOVETAIL_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_DOVETAIL_H
> +
> +#include <linux/tracepoint.h>
> +
> +struct task_struct;
> +
> +DECLARE_TRACE(dovetail_leave_inband,
> +	TP_PROTO(struct task_struct *p),
> +	TP_ARGS(p));
> +
> +DECLARE_TRACE(dovetail_leave_oob,
> +	TP_PROTO(struct task_struct *p),
> +	TP_ARGS(p));
> +
> +#endif /* _TRACE_DOVETAIL_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
> index da4016697b67..98892f0a63da 100644
> --- a/kernel/dovetail.c
> +++ b/kernel/dovetail.c
> @@ -12,6 +12,19 @@
>  #include <asm/syscall.h>
>  #include <uapi/asm-generic/dovetail.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/dovetail.h>
> +
> +void __trace_dovetail_leave_inband(struct task_struct *p)
> +{
> +	trace_dovetail_leave_inband_tp(p);
> +}
> +
> +void __trace_dovetail_leave_oob(void)
> +{
> +	trace_dovetail_leave_oob_tp(current);
> +}
> +
>  static bool dovetail_enabled;
>  
>  void __weak arch_inband_task_init(struct task_struct *p)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3ec77a682c4a..b2ad0ab0626c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10689,6 +10689,8 @@ int dovetail_leave_inband(void)
>  	 */
>  	if (likely(__schedule(SM_NONE))) {
>  		arch_dovetail_switch_finish(false);
> +		if (tracepoint_enabled(dovetail_leave_inband_tp))
> +			__trace_dovetail_leave_inband(p);

Why does trace point have to be conditional? Rather unusual.

Jan

>  		return 0;
>  	}
>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
