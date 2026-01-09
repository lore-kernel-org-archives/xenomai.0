Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9098359FAC
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962551; cv=fail; b=VuaUL5IiSOYJNWDD/RlZQpyy1ugUq5cJa6Dekj0GVxOOOR40RXaSiKQp6YiDwxS52XgWM+eOTFKixk6OxtwJ9FMS6dwg5Ka3DuBXa4GOcvkHRPya47wLBa2ITq4KqzCRfznkNUSa5Ftz3Ii91jrXw2QsBJ7wug0LSwTi8qzrezc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962551; c=relaxed/simple;
	bh=5FYeglsFIGncJot0o3u9hVuw9os3e9Yjo9UCtxhDUAo=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=ilEBtw1G35UyYde0YM14SOkpVcognH2YWcchxA8/HcN0bvXv6PsVcTOSTWqFpTkudz9FQm9YTcjfqovuJBHUtKmRRfFlXJMSsRqoi8nK3p2a2bTPzmxmzmmWIvZH04XUPjONL8yzqYnundYDTnK/2RwEj1eAtdFIbgeKt0SHo8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rmNv/kUm; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rmNv/kUm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAzY/bxQF5IiJtzQ1cGbX3Y1I+eIJle/h0+q06LZLIwOWRtLXndauFEJAXaE8+2gmNTnbTRTf8pCfzw6/l6vQ6AGPri6FxWbqOg1eCrn/Adl5709lY9RdHwSRD9GpVgFKNszfUp/Sxr+mgOkrXCPXljlfTJ7f2SnorkDG1WOrIHShGkds1Qw6fUY5atoI+5m0NGDvdxKvNseeUePVIswYwmPSJY8DHT7ca8ZiY9CjcCg6ez2ybamzihTiBysLTRWT3K5klmg3lb+HMbmzsdmPeiaUCEoV9PinT5KKM3uAdzKNnOAv3J/ZwB367wdB9/Wv3A9WNrESqkJlOt9WR6ZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa0Pm+TYkfKWBMDQF/pt/4A926okSEAbRuWkIy0FcyA=;
 b=P8FjIEIciELJdMpsFCbC4JWhlQ9/8EhnSeQhzEq0KzQIrHoaxo0OSepMmPzXJbbNDQQZTccdtdxc/gemyd03D4FBk8KOYfFLt71ek2M9xJ4xGf05zEkfgfq6lUERknqTDRX+c0s23DVjtugfBOApmsv75hlONIimNIzSqYJd78v/5m+XzqA3lRJNEHIJvckvp4+6ims7doJXWJY4+bzd2QhY1wsHnpN3K6DEMUB+r8qqCHdREyaH907Ay2yaXaPNOjS5OvA/LdYi+3R8F6ubzjEIBsbVSS9ge3TDES0r9RHjNbxD1kTqEC5ulaRDEPNoGQD19h14lIoS2pqMz6bgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa0Pm+TYkfKWBMDQF/pt/4A926okSEAbRuWkIy0FcyA=;
 b=rmNv/kUmtwBoYPBVpxOydREVFAkig1SxNFXvD/U9r+mpMC0nwKgeBmHPqxUXQkkoUmQROkTW+jM61YW+V2ML5yJu+wDaAXT8l577B9xiItx97R3plb44qDjhMYYviy+BfFBNVPBwgKlTRMx3k7pFkWG7mcBoERqadgBzer1j1DsVkkhZMsPBWXyq8vHMG+zuu6Qviwhdmo9fzgaw56FzU76cg2xW9kMvdk9opoKTGrhUT4TRQ9C7l18gkC6v0ukK15VndFQmikFlINZ4t80QB++YN48Cy3f+uoAx5GYfBmuure8aFVxCRpshnDZpbliq355dlZ55pJuS6wLHq2brNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6450.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 12:42:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 12:42:27 +0000
Message-ID: <9489ceb1-502d-4586-ae53-e0d506bf679a@siemens.com>
Date: Fri, 9 Jan 2026 13:42:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: b6127277-1bad-4427-1b40-08de4f7c8ba1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3RyenBOcXYxUDBic1kzbEtTWDRtaThHRm9BdzBlU3VZQVFCZFlDS2I1VEdI?=
 =?utf-8?B?bXhTVW82OEd2ZG1EaEVqeXZTVmtweWMvRzhmamZzN1JiSnAzblJpVFVUakxJ?=
 =?utf-8?B?Nk5tRElYNjNTdlM3QVlPclc4cmZlQU1DQ2tCZUJJWkFiL0xnTVNUOG12Wmlx?=
 =?utf-8?B?K0xOUnRzVk9SRVBqWUhlM2M2ZWwvbVp1ckpScnZGanlqdW05S05WWjRoaGNs?=
 =?utf-8?B?emdvM1ROZ2dUYklCS2VpUGdmb2JVOEpkdldQT3o1MWo5TStDU3lYS05YbUFq?=
 =?utf-8?B?aThRU2V5NFdrQkthVXN4S1hQSGpkNEVUbTFUOXZkd0tjL2VmNDd5M3BsaW9l?=
 =?utf-8?B?VW54UkFTeVJzOFZ6aTdzM3NlZW5XTVprUlZCR2k0YzR6Q2NzWjR4TnBSOE5X?=
 =?utf-8?B?aElGU1A4eEhRWHNmVVU3SExaaGVuLzJ3QWNCa3RmVkV6NmlEN1FPWjloS2FX?=
 =?utf-8?B?bjFXQ0RUS3YremJZWFg3SGF4TFAydmdVZnhUU29WemhKSFZhUDNEcGVpaVBF?=
 =?utf-8?B?a05ZMkJNK0QraE5yRVdYcWs4OU1VdGV1YkM4Nll6L2tBQ2xkeXNuWGsyTml6?=
 =?utf-8?B?bTJFRVM0QXNCQjROSEN0d09iNXJCNFVqQzEzendSclBIWDIrc2ozUmdBUksv?=
 =?utf-8?B?Y0w2K2NvL1NXc29tY2NZNURyY0RyaG0zQWdQVFFPamNTeEU3bG9pMjZLK0JW?=
 =?utf-8?B?blRFNElBYXpIRUZCMW02TDYrKys5NWNtV3Q5a3ZDMzRuMURoRnFUa25McnJs?=
 =?utf-8?B?QXlzL2tuRVI0Y2cxTFJ3bFB1NkRrOVR0bExtRFp6ZHJpRUFaVnZ4OTRTaGFF?=
 =?utf-8?B?RjRDN0hFVGFGaVNkMWFzNGl0SUtxL0VvZUllVFJrbEJoMmdGNUV2MWRweUNL?=
 =?utf-8?B?RlN2c1VaNWhmUjJ0Z2lVZ1FYb3BTWlFOUGcxLzNHY0pUeWVaay9RTUYxOFFD?=
 =?utf-8?B?SGl1S05pQ2NCTENUZmhCZDN5eWxnK1B4dXN0b2pOT05uaWxKOXl2MTJTV2tz?=
 =?utf-8?B?T2JCYTRGeUsvRUZWV3NabDhOaXpHaHlvdTVDMHAxOVd5dkZqRnJWbkhVNXlR?=
 =?utf-8?B?ZDUxcmZhaXQ2ak9XQWVjTENUclZjZkhLYUJLa1Z4NEdpSXJ6eDF2U2poYU9s?=
 =?utf-8?B?L2RPM0ROMERtMWpCTUFUbHV1SGVUZHpES1gyK0o3OHgyT0FqTWozQ29NQkcz?=
 =?utf-8?B?R0E0TGx3aUYrVi8vTThXdHJ3K2tvYW1CeVQ3YjhBWkR3U1V2NDFLRXJCbkRw?=
 =?utf-8?B?S3BHcmc2a0lXTXJkaUIwNUwvRTdKNkZlZW9JUGVWQ3RyLzN0R3IvZFlGVzdo?=
 =?utf-8?B?c3loRWx0WXlzcFM5ODdhZXUyT3ZMN3VpYm5ZME80NWYrbUZDYUQ0b3V1N2g1?=
 =?utf-8?B?MndSZTdmNTBVSnVrZ3N5L2ErMWQ1bG1WajgxNHJvRmVZSVZmQktyR01DSUZ3?=
 =?utf-8?B?eVJ3NzFEbjgrMGF1TmdMZVRpVFRyUnB6bnAvN0RZZTBuengrbVByY1o0NDdp?=
 =?utf-8?B?emZRTTNxNzRvc21xaFNWSkxjMjJQZEQ3eUNUQVJHL0pNUE1FTzBDeU5FcTlP?=
 =?utf-8?B?a2Y5SkJzT2JPdlZYaHUyckhObHJpRUUwRERtRDBaWitqMk1uYVU2Z096OXg5?=
 =?utf-8?B?R0psc2VZSFRDOXI0dnNNd2ZRYTVxT2gzTlpyZC9wdS9mV1QycTZtLysxSUVy?=
 =?utf-8?B?U0RvamcyZVczS3ZxS0ZYeHF2OWhDZGQxUUdrOUd6RmdCdm96MWZIZWtTUmJh?=
 =?utf-8?B?NktldVBjODFFclFCZzIxdTdDc1ZVSU5lcm5lRHFQc2luM1NmSlZ0L0t6cjVh?=
 =?utf-8?B?djk2ampadGladjZJM0dwM0hqOGlqOHo0bnlDQWp0WEM1NTJJTVdWN3cxY2ds?=
 =?utf-8?B?elMza1p0KytSMUxYYlBjeWhUbUozYmJiUjRIcVpWSEhya0orRlZlV3pacGsx?=
 =?utf-8?Q?TdBLIEDurPg9J4jZcppa8pdfhxdq4clQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWR2V0NwdWpXaEYxNnZhRjJCelY2S09Yb0kyeHJna3pFWHlHbzMyOEZkZ3ZC?=
 =?utf-8?B?TTdzeHpTQllCRTFpRGxGZTlleURRcmU5ZXA4ajlNemRDUmlnSEo5ME9EazVu?=
 =?utf-8?B?dUI2TnpyZmUwclhOK2htQVRsQmVmRDhoS21NRjI4RFpRdUVzOE01M3pHWEJK?=
 =?utf-8?B?bTZRMytCTElzaFA4YWo5TlR1ZytrUlVxQ3JTTjdrYlduNkJqejVTbG02Wjky?=
 =?utf-8?B?ZWQ4T2JBOFUrMHhWZkpyNHlmRGhWRUVGUG1HUDhqU2VWU1dPTyt1dUJwb0ZD?=
 =?utf-8?B?cDJBcnVVc3Y2NnlNb3lPUFlIQnNSSS9LVVRQbFRyU2xuQUZ1Y3VLUzUyZ1Q2?=
 =?utf-8?B?YXlaZjlOUWZVeHB2SUJYMFBCVU5XUEtiQTc3cXpqdW9RR0cwUTZrc2lRODZG?=
 =?utf-8?B?VzF5QTVHVUJXQW9yenBMOWFaVTNseHRJdStHZC8zSm1XV2lHejZac0srQVEw?=
 =?utf-8?B?dWp0R09xNnVtSnJObTM0TkIza0NId1N1MzBFU3dhbGdXSnNQQ2VFeEhvNkN4?=
 =?utf-8?B?cTZBVjAzSnVtTnRBZmdCU1ZtdGk3bUR6WUhxWS9wRktXWVJNWDFkNTNtZkFB?=
 =?utf-8?B?bjMwTmIwSGhDYzVJcnhPaThjNXQwQXkzeXhvMlIxaDZkZ004VDF4ci9QT1FK?=
 =?utf-8?B?RDdRbHIvOE9IdEVlT2xtRUx2S0tMZzJlUmRoMjNMNjdDMHZ1MS9yV2g2ZVRp?=
 =?utf-8?B?dUQ2Wi9yRlhFN3VpSldXM0Q3cE0zQndLMXRYLzMyVGEzTk5BeXpzbTJxZ21W?=
 =?utf-8?B?TGlua2pKVXZyUFlhRFFsWGsreDVzd1YvZVF4dDJRa055MmJSYUk4ZmtVUDdB?=
 =?utf-8?B?bVZGVXVDa2ZkRlJuV0ZENlRhYTcrdTkyeG5KaWlPV1lqMk1mK3hrYUphWm8r?=
 =?utf-8?B?UEFyNi9CaXlDUzhOa2ZXUGhveW05NVJKc216cUJpdWIvWmxKWjBOUHBmeVF4?=
 =?utf-8?B?QS9aQ3pIY2pLZXFmTlltUUdUd2NsN1krbGpUcHhsR1dGaDNYdElvelpZMkc1?=
 =?utf-8?B?YnE1aEhNd1BJN2VIZnNKYzRvMFZzcnRPMS81RVNFWWZyem5WNEZDcVVSRTRN?=
 =?utf-8?B?dlRLR0xoNTUxK2dMNVVmMXZpQW5DTXRGTDdMb05ibnE2YjJ6Vy9YTVlTeHRs?=
 =?utf-8?B?UWsyeEsrQlBoMmhaTkhXTjc2ZDhlMk84ZWRoZUtOY283NjR4SE1lellwVmQ5?=
 =?utf-8?B?aTc0ZmhGaUZsSDJjZXZkVzBNZGprZVJvUmxucDFTL25YMytQQXRSNytVV1Bq?=
 =?utf-8?B?NE1xN3FtNURoMldBTURtQVA1NGtSdzhXQXN3NURxNEdDc09PaHIxNWY3ck9j?=
 =?utf-8?B?V3hSb0pHb0RIL0hzRGZxbUpvRWZrOGZYeUdPOVpFZEs1dFlhQWtqMFdBRjNK?=
 =?utf-8?B?eWcrUWkzbEtPai9VaEhlWjlHYnc4ODE4YkdEenhKdGMzVTRUVkM2Uk9Dd1Ny?=
 =?utf-8?B?OHRjYUx0akFDMmp6eDM3YnN0MzVOcVlhRUNsUm91aFh6Skcya0tvY09qVnE5?=
 =?utf-8?B?ZFI1M3NKb3BLWmlEWmhsQ3NOM3JiOTZnTkQxblN2TFNBNzUrdDNqUWIyTk5P?=
 =?utf-8?B?UnpORDdmcTJudWtzR0tMTDBMUTU4eXY4cGl2eHY5K1FrZ240WThIQXdTZ1ZV?=
 =?utf-8?B?V0Y4R1gxL3JRdXB3bldkUm43RlJ5STJJTWlkS0JZL2c1WFNsNStFcXJMZWRB?=
 =?utf-8?B?OVZKZlRPZE4yN0I1Wlp0bkRyUVVmNGtUU3E4WEVDZ1QzZ05yVm9WUUhLUlho?=
 =?utf-8?B?S0VjblFTMENnNUVHdTFJdmhSRnhQblJHczQ2cXFSWjM3UVp1cWVWcGs1SjBX?=
 =?utf-8?B?OGdxaGd3RUhXbkdYSk9lK3h6WWZpZkUwZ0lHTnRhQUxLZjMzS0c4WVgwaUYy?=
 =?utf-8?B?VzV3ZXJ6dW0wckZ2Zi9Fdjh1Nm9jaytaYUlidUxtSW50QmZrdmg5dy9ESE5I?=
 =?utf-8?B?cnpxdk1ZU0dLcmdKZFdtS1FXUWtVTkN5TDFtVlYxNkRwaTlKQko1c2NzWWg3?=
 =?utf-8?B?U2thMlJxMzNITnYyQmZtVlFHRDFwVlAyNVByVUF1ZExmYzVzYnpPREFlYWdL?=
 =?utf-8?B?UDFLYU5JNkdjRVk3TzhPd2hHaTBkYTRRdEo3c2tJWjl2SHljM2xYUlhQdTBn?=
 =?utf-8?B?RVBoaHJlbUd5QlgzdEo5MC9WZnlTUTY1SW5oRFVCYytZZE53ai83WWZQbnJk?=
 =?utf-8?B?WENJOUFlalZEQkx3UlBNaVd4ZDJRVlNCS05qVFkzOUZkYUtEaUJIcVB1cEQ1?=
 =?utf-8?B?UG0vRmVpY0N3WlFjRG9NUEE3dHQwN2Zsd3hiakQraERGcFJtRUpLckhHVmpM?=
 =?utf-8?B?RzZNYzYzOFEvaUNHMTg5cmhFNEEvNUVDUUZrbVdPSVhOMHI3cXI2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6127277-1bad-4427-1b40-08de4f7c8ba1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:42:27.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVa+wwNP2Ki307WREnGrq7JVjQPuu2GN4DJ5NuESIt/czrD2lyoB7n8MUFKQ49VxxZk8dhNe3qGa1fwsM6+4qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6450

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the last patch as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...-building-of-linux-libc-dev-cross-pa.patch | 35 -------------------
 kas.yaml                                      |  8 ++---
 2 files changed, 2 insertions(+), 41 deletions(-)
 delete mode 100644 isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch

diff --git a/isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch b/isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
deleted file mode 100644
index e1d6f76..0000000
--- a/isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From 4e46a398718df47e7efa0256c1ac62d1262ee47c Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Thu, 18 Dec 2025 16:43:07 +0100
-Subject: [PATCH 1/3] linux-kernel: Fix building of linux-libc-dev-*-cross
- packages
-
-The cross variant of linux-libc-dev is always built along with the
-kernel, just like the native variant. Ensure this by additionally
-enabling pkg.${BPN}.cross when :cross-profile is active.
-
-Fixes: afba99fe6aeb ("linux-custom: fix name collision on cross profile")
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/classes-recipe/linux-kernel.bbclass | 5 +++--
- 1 file changed, 3 insertions(+), 2 deletions(-)
-
-diff --git a/meta/classes-recipe/linux-kernel.bbclass b/meta/classes-recipe/linux-kernel.bbclass
-index 8f38a617..e129527e 100644
---- a/meta/classes-recipe/linux-kernel.bbclass
-+++ b/meta/classes-recipe/linux-kernel.bbclass
-@@ -125,8 +125,9 @@ BUILD_PROFILES = "pkg.${BPN}.kernel pkg.${BPN}.kbuild"
- BBCLASSEXTEND:append:cross-profile = " kbuildtarget"
- 
- # When cross-profile is active:
--# build only kernel (including config) with the default variant of the recipe
--BUILD_PROFILES:cross-profile = "pkg.${BPN}.kernel"
-+# Build kernel (including config) cross packages (linux-libc-dev-*-cross)
-+# with the default variant of the recipe
-+BUILD_PROFILES:cross-profile = "pkg.${BPN}.kernel pkg.${BPN}.cross"
- 
- # -native: kbuild package for host
- BUILD_PROFILES:class-native = "pkg.${BPN}.kbuild"
--- 
-2.51.0
-
diff --git a/kas.yaml b/kas.yaml
index 7aa5a83..f856ae1 100644
--- a/kas.yaml
+++ b/kas.yaml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2025
+# Copyright (c) Siemens AG, 2018-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,13 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: d887bcef5084660a03776bd13028dd3fb58ce569
+    commit: 9792d18e9334b3cec72e2ade6a1065084c0c24d6
     layers:
       meta:
-    patches:
-      p1:
-        path: isar-patches/0001-linux-kernel-Fix-building-of-linux-libc-dev-cross-pa.patch
-        repo: xenomai
 
 bblayers_conf_header:
   standard: |
-- 
2.51.0
