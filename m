Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504116;
	b=y9Vd6iC5RY1ZuI234p72KgtChBvtzLqOXRvPRYIOpmlU2RH3Gs0r9dW006KpPglN4YLR
	 siV5wWDhd7jN1evfzf374VAhzEKADCcOQPSsnJfaLMh5CnUe1ad+A4Be/ke0f1uqNqNqg
	 okzo1CWe09ttOLE2LUtwiM0vYUda56kOyEohq6bSwaORUKzm+PNNnGx/xyE+BzLHVYTen
	 t4nfbStMTsfyXIkBheoutxkEGa9Blk0LkCOiyjoLAI2KJMmvuJ7WYshXEJ7Uvb1Gc0Z7z
	 zv3gfm9nDF5g5l2+pb+vWHK/RyewTC/TEByfO8GxzApA6+wFmUuHwdKRyO+jo+76UEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504116;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:To:Subject:Content-Language:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=2K3FONN/hKlzO1iG3P2kBDTjmhl8cXfsBx0SJdnRv+I=;
	b=Zn+po+MrNZtmm3RT53bcZqd72zFgQjO3rE/8xJBvErmO56Tsb2agT2Fj2XPjlGKFmm44
	 kAGxlrc/n0dKBvKhifivk/XyfcgNIaBUkjJ03MsEnupKT4XPAbpuYDV3be/hpp/kiTwj9
	 c7vxM0ux1zH08MflROXEZrAqtwlPpC1yoEiNS39OmAkuzFLxviwsw6DIMJwZjG8bF96YM
	 ZmcK0uFnq6wpu9407z7ldd2Kavfm/W/KMfRmb4Wm6TtpKSIuRCZ0ch8xN+TO3BjWgA36P
	 RCOqUqA0tyEW1C3mFOBvx+47XgQoPXg3TiX+0Wu8ur3sk+bPVy785t+qJ8Gbj8p4wyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=gYwO1jyn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.17
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C71606A882
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 17:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C71606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=gYwO1jyn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8OW4iFTX6T4iylGLx6lPD+Hx0auXRjise98lgyESFkW5MOH7agUmq/JSJn+G4sjHeAW6OwnOhvA3RfL9PpXJGNSbq2jh+/aLoO/evaOUKzsxjOJi7BLfvZZqOCMJhuwdsILKcwKTQrXdoxgR4G73cryofmpJ8xcYgy5dGz9ziW+BmBtuNhOtZa0UypJx5auaujklkKl5ly8QRBEGHgZaL64GurFoQg2Xrdm5/cEBF+ZP7kThlou4zTW3qpB5AyMlyMRMoL9RRfO+J5Rjo8br9vHmmMfrzbFM9K8e+WjKx32rj6hjlZ07ZPvRru8l009vevyVj+H7BmRiENwNDXPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K3FONN/hKlzO1iG3P2kBDTjmhl8cXfsBx0SJdnRv+I=;
 b=eWuoBwjjEZ1uKjWFa9jVUcjLM5t/doSOh/l+vXKWjlosNcVncr/BGAMMSVJfRTuPn/FaFt94/oST0YITmq9lBglNYGP+SW3FzRewiJ0HUDOkBj46L82DP64JyyKCwM8N0KhXcspM9B1NqoBMqZPGUWe4Vijphd279gY4++b4c2VP243nbFKsaz2WuovxMlBq9N0Ty/mAcxXENcbgYkeLosNg2C+Iscdr59CnvQlcaLj8XDIf7lPnQt6CdLid+FK0qq1sV+0bew/svlZr7sYLUw9NSbUhwKQ8iUEJRlY1WKFfJN6S1AOwLrQpD9eVNSuFdMx7ErVAl64fqAG60XmhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K3FONN/hKlzO1iG3P2kBDTjmhl8cXfsBx0SJdnRv+I=;
 b=gYwO1jynWfwhPdXPo51gGz3Dh1in6NQUYrzZt4lxmAXiLXWz1/QBxRnMbVk03vKEOAV9/BKLNyh9+gVUuudsSVItSy9f7J+HntiRZuXDzVQvW3vKrpFpMPoj6c/b64uFWCyFnHvUdX6PJKyEwGGCZ5zbCFZ2gWNCRvDkFX91AQIYMjBg8aLp2YGRSHF/wBddCYloRqlxxs0LOueO78HhfKS9ip1aAnlShofNQT8Jis/MTZKAEWj4i/ZAVOk5mcjtHd71ReTIlGnBYxFAXpKQ15fSByEdG3JQIdPaHj1OlNhBVj6FqeiWWF1m6eoTs/eut8lhs3GOh2EupwTmZ+0dsw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV1PR10MB8753.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1d7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Thu, 12 Nov
 2026 17:21:48 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 17:21:48 +0000
Message-ID: <2c4c9a31-e21f-4477-bbed-fd75845d45c3@siemens.com>
Date: Thu, 12 Nov 2026 18:21:44 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] lib/cobalt: Fix detection of mmap64() and open64() aliases
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::29) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV1PR10MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b37aac-4d55-4738-49eb-08df40e16eca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261028144727099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261022105027099003|261102123227099003|10067099003|18002099003|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	4nMaoLcfNLRFu10s4XYn6pJ6K6SkHx8HwMLbh8ER7VN1pt4tEvIPq4fLCMEO6w3Y5sJlUeYoT+xUdI0yTuYazHU/Yd4jOCBniOat06cD3FL8C+J07z6+EpAYjZ8nF6/1nMc/629is/ABU8A3eGHmkORPmi+JDXuK53eus/Tbgrmgacf3AjktC+ks5h92YUpJk96s7A56Xee0F+4DI2iJN794SxxLxrtQ8CbfLbjj9o8GffBrOO+Nx2YytsCe6DBzyGdD08acwMLaVzyzR5C9/n1ndJzSruKDXcMcSerNWkP4WqiFvxsJsQjMEzW8/3sAY0rSzDus9iwA24fVy9CQgXG1Y0Iy8E2+9RntAVysLZBvGzX2PsPI9cEje/gVBubXuiTEKxxKTuvpkfnIRHFRrda4ERgm9S50WyHjtE0Rb0H9TdAjpsb31fUi2jpu5eAD2o5Yf2OhnnCqlPaLjtKKRP0L9a+XD32WqHBjYHNjJgwrl4ILChoBao5Mu6yGEGSLe32CrmG3N64+QoGo4RNiwWkjlvTdH4RWrDwN0at9S4MtkLXNt/ZQGWN3Bs6dUsUXetkncY6TzDVVAKudrDIwz40kI35NFaPYIgfTvS4ToUkHr58WOJ7HN8mNBrI+DJI4dZROtv+1RzV5Yv1ETvyYnFOUQhtH4JQ+DdXhCjoNHsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261028144727099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261022105027099003)(261102123227099003)(10067099003)(18002099003)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0NNb3pJRzRtaHhYUDhxUVE0YWlpVGdGc05SdzZCeXVBMGFiRzd6UmlITmti?=
 =?utf-8?B?bERHdTBDN0xSTGJSdWFaYXZOV0lQWXJVUHVuaFlRdzFDMU05NzNsdjN6RFA4?=
 =?utf-8?B?SVBYMkJNeDJreVdEWURlQmQxU09CWnIrQlRnK3JjWm84d010eW5LR0djbnlu?=
 =?utf-8?B?K1FNaFNZWGFmZy9iS3F3UHBRM0pQMDVNRE5GcmlCNWM4VDZkd2NrV20zUngv?=
 =?utf-8?B?alUrdDE1VkVpck5BVS9UNXBLR2tmMG56bEVpTUlBV2tVWGpiL2IxajFvZzVi?=
 =?utf-8?B?a2xmTU95MDNzZ1crelZWTlJiWm1qMURFbEJ2eFYycDJQTW9kaEUzRjkwblMw?=
 =?utf-8?B?eWs4UjNVeXdIWUJWQTJST0s5YmxEZ2x0RnpWVmRHWnROd0VIdWhXSC9MZzVm?=
 =?utf-8?B?bS9RNGpkOXVlNGdkWDNCWFF5STc5bG14UUlNaEI3Nm1nMnNEd01OckF5Q0ND?=
 =?utf-8?B?UGVTNWM5Rjcrb01KSzlHakFXWEpCQnYrODJ4S3JENmVzcFJBTndvOUhFSG1S?=
 =?utf-8?B?N05CTS9JRkFrWHFQb2loRk1adFoxMXhDWld0M3BxNysySG5uWVBoYjJwZDh1?=
 =?utf-8?B?UW15WEpxUEE5ZEE2aTk5NmxmUUUzbzkzZ2l2OU5xM3hTZFJDL0U4VXBrNlZT?=
 =?utf-8?B?VVlNdDFPTGNNMVRjalc3dXZTbHN6K1hJdlBXNitxNXJHMnRPZ0dEQm1BSkZy?=
 =?utf-8?B?YThsYm9JWWdKRzFpZU5VYWd1T2d3Z1dHc3g0OGRYZkZxSjNJL3JBVXJvM25G?=
 =?utf-8?B?U1NYY1drd3BPZ1JZaEZ4RWRqYTNwakdrS2J2S0FOVzd2VTRaOTFTOWcvdlp4?=
 =?utf-8?B?a3pBcnJNQ0t5ZUJEaCtYaXNKS2tQVlRoNTlXVVdMcitkMWtsYU54MlBoR25i?=
 =?utf-8?B?Vm50MlNDaHF2R1NlWG9YYVNpaVdHeEtub0RlZ3pNUXBYNXhzZDY4TFB6eUlm?=
 =?utf-8?B?VEZ4SnovbW12czN1UDNoTlFsc2pnUkg1cVNBVXNVQk8wRGVLRnpvOEVBQUFJ?=
 =?utf-8?B?Y2xOakYrZ3hJWHdjREc1Nmh6ZkVZeXJvcVJJMnpuYUhCbHJ2THNnSm1LNFNj?=
 =?utf-8?B?UmFWNTVKaldJdDBTY1dDc1VoK0Z3RkovN1pwS2tBbE56c3lnOFA0VDVzVDEw?=
 =?utf-8?B?Y0VJbVZxV2FpRy8xdTk2NW1TY1BpQnVPeWFTaTVHTGd5bkxzbTlkRjNMQ0Vz?=
 =?utf-8?B?SG9XSk5CZU9BRWwyMXlVdUhvSGJ6NzVmSjN0Y2gwcURsNEVBVlFUdFZtd1dw?=
 =?utf-8?B?M2FYWFM3TmpnMFMrL1RvU0pyYWNUTk85eEM3TCtDU3JiZVV6Ni8reWdMVW4z?=
 =?utf-8?B?dU9qQzBQUjkxT3NzdW5odmowRGdJdWVkcjN4RkxDMUdSdHNxY2xmUGZaOTc4?=
 =?utf-8?B?OU9rOUY0NS9sQTZram9GUW1uamFBMDRyZ2p1WStZbWtoTXhBRFdhZWQrZUR5?=
 =?utf-8?B?S1BoalNZMXJIcjF1MUtZQUt0MHhhdzh4OGlkK3hHVldWeVJNeGpzUFZFNmcr?=
 =?utf-8?B?end5c2FtOXZTWVJCUTlwdXVhV3RHU3o2VFlZRC8xMHIyWVVnWGNOZFhYUCtM?=
 =?utf-8?B?OW5nc3F6WFZHaWpNQnJYYStIcWwxUjlzbzJMMi9lcVljcDlSMTJlMi8vajVs?=
 =?utf-8?B?ZDFxcWJtb1hWb1ZiN3NycUxxQWNUR0ZEK0lzQkVNTDNDZmZlT0ZBQTVZVE55?=
 =?utf-8?B?aUY4N0l1UXdxdTdCdXVnWHBlNE1rd0dSMEtLRHYwRXc1YmM1ZnBPVHoxdVo0?=
 =?utf-8?B?SEZFbHVCT3J4alR6dGpVV3pZV3ZtS0kxRTZWa0FnSWJaNk9nRWk0QmpjaDRp?=
 =?utf-8?B?SFE2VW9VV3REOVdhb05nbUQ2c0VRV1ZDYXhVYndNT1BCUTlJaVpDeFJQWVZw?=
 =?utf-8?B?K3grVHhCTzJ0OGtCUG9mK3lsVkJUTjVDcmF2aDNtSG5Gd2g0ZXR4N2VieXhk?=
 =?utf-8?B?T2NNZ1JSWjRsd2VReS96dzNtQmgzbHQxOU05SkN3U0ZjRk1IUTNVSkxlV3ls?=
 =?utf-8?B?U3JnaW5vc3hwRUo0YklVS2NzWnJodkRJTGhyaU4wSWdmYmJQSmE2TG5WY0Yz?=
 =?utf-8?B?Z29HbXp5Ym5sS0pOOGptU0ZxRS8rY2tpNWg5eFUxSUszSW5uNklJWVVPUG5E?=
 =?utf-8?B?ZU43TmtOZW8wR3A5S2lFYVRtWmpEc3dBbHJiOGUyenJVYkMyR1dCNnQ5VHEy?=
 =?utf-8?B?RG0zdHFjUTVnRUx2Y3M1OWZyM1RGSGIzUkpDTm9KMHhCWUFPMElvU3FDV0Q5?=
 =?utf-8?B?Z2pCRE9qV3FQbW0vODByRmpRMkZFZnErS1paMWVGNk9jVjI1cU5aZ0h4NGNw?=
 =?utf-8?B?d0JmTDN5MTR6QVIxakNFaFQ5S0VoQkh5SHNRRUpPQmcwcTZYTHRLUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b37aac-4d55-4738-49eb-08df40e16eca
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:21:48.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tA6ZABn7zLJCfhiAcbN651dWlrk3TpErO8lHLPK2wzpqSayRhRxUcWQ4XA1RrxeqG38fOi/9sBI5/tgB09lvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8753

From: Jan Kiszka <jan.kiszka@siemens.com>

The "#if mmap64 == mmap" and "#if open64 != open" tests were meant to
detect libcs which map mmap64() and open64() to their standard names via
macros. With glibc, none of these is a macro, and the preprocessor
evaluates such identifiers as 0, so the tests always took the alias
path. This has two effects:

- __cobalt_mmap64() always falls back to __STD(mmap()). On 32-bit
  archs, this passes only the lower 32 bits of the offset to the regular
  mmap(): mmap.c is built with native off_t since commit 0bb6608b6fa7
  ("lib/cobalt: Avoid making mmap offset argument unconditionally
  64-bit"), before only --disable-y2038 builds were affected. Mapping a
  regular file or device which is not handled by RTDM at an offset of
  4 GiB or more thus maps the wrong page, e.g. when an application built
  with _FILE_OFFSET_BITS=64 calls mmap(), or when using mmap64().

- The weak __real_mmap64() and __real_open64() fallbacks are never
  built. Applications linked without the POSIX wrappers (xeno-config
  --cobalt) fail to link when calling __STD(mmap64()) or
  __STD(open64()).

Check whether mmap64 and open64 are defined as macros instead, fall
back to __STD(mmap64()) otherwise, and build __real_mmap64() and
__real_open64() under the same conditions.

Fixes: 8e7aa675267a ("lib/cobalt: handle direct mmap64(), open64() wrapping to 32bit versions")
Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/mmap.c     | 5 +++--
 lib/cobalt/wrappers.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
index 069163a855..d30b1722dc 100644
--- a/lib/cobalt/mmap.c
+++ b/lib/cobalt/mmap.c
@@ -49,7 +49,8 @@ COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
 	}
 
 regular:
-#if mmap64 == mmap
+#ifdef mmap64
+	/* The libc maps mmap64() to mmap(), its off_t is 64-bit. */
 	return __STD(mmap(addr, length, prot, flags, fd, offset));
 #else
 	return __STD(mmap64(addr, length, prot, flags, fd, offset));
@@ -69,7 +70,7 @@ void *__real_mmap(void *addr, size_t length, int prot, int flags,
 	return mmap(addr, length, prot, flags, fd, offset);
 }
 
-#if mmap64 != mmap
+#ifndef mmap64
 __weak
 void *__real_mmap64(void *addr, size_t length, int prot, int flags,
 		  int fd, off64_t offset)
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 3a0063f051..dcaef381a9 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -187,7 +187,7 @@ int __real_open(const char *path, int oflag, ...)
 	return open(path, oflag, mode);
 }
 
-#if open64 != open
+#ifndef open64
 __weak
 int __real_open64(const char *path, int oflag, ...)
 {
-- 
2.47.3
