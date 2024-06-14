Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE001474B8
	for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357000; cv=fail; b=jrUrIlP6QoJJPIUnbVC0VJ9rGf8l7FC0M+w9x8IRk16LFNrMvr0sOt7qOinYSv/tSk4tgfpI0ec7j2PLvG1hkiMi9CjKqndlroJBhs6HMRlysbYivapwQLvWus5cCt8Zd9QviG0s6vsXDrlWNdMfY3e16bBewMNbVXabts2rv34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357000; c=relaxed/simple;
	bh=lMvJEVD6/kLI1DHjfJdyYQhVpI6W9uXsuXGhM3gWj3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OdCXJy0I9iDzhLhfml23wJlR7peGDormFvV6yjRAp+6+HUBJAWHc4uguwu2cTw4pYq+L3PmnYLc0kAEFosPN8/bkotz7EYSFmTaARdCHAEa3hyZaoLTNsuTDKwWgnQ7koWEVBWLslQn6OXqxHZxO3Yyt9nURfzz5pW2NHzhKNWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=E0fz/ieV; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="E0fz/ieV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GynvBPKGUOg5NqRVmChYz2ITyO6USe6JpDL+QeBwtNQMA7mR73MmXdNnT5ZmlyxUg8BxEnTolzgMdfBkmx/7OvGyeboHGeLlSRAX79fzgWhu0RbPq21zt6z65FHmrsT6zl3orNZ0Q0rAVI0o7HGvxAiAI3hd49iIb4T3ltQ1HyCly12xCbDQWO1IqJHeuIOHlx3k2sAdHX2SCbHJe5UweCyO2Y2L3BZOdjbR205F5lVKURvOjqpGu/ZyA/MhblNUHf0pSkZcWFpSKQP/W1DxqoGykEc56xs3nc4+nxNrv5tY9td5D5/ewbsnWXGAItxKFq+P08bWPr4ljjiH7SaY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHfMtZt+vxXu4AsA2YoSNiCBosUQMBQSvuQw8WbT6ic=;
 b=fXX+4oUa2QafPS4M1sWHEytwBgjbzoyecTA+qJEVZUeAhrlXQP594qBq7+w8HwpNkTMnvx6qT+L90t4dtI4scqbKBptW2yAElhHvxPablOf+X3qz/GYNfJIc0GNSqGjVNb9XiV3Z/oW7AqZkwvMbSXWl8LSMniwhrV6J41RXxMJAaVeGMhaChv/GHn79rmAx9bzoGKVwI0hbXnA16tM4CTyTvz/evlvdWVFXtkjI4cgv2RanTPkVH63eX8HtLB+hoxJ0ilA1X5VX4eubBnop4xdfyfYhCqtaCFpsWY2Ld3QAN4Ief29+PlQNs+UbhsUlZv0j679ph7X4lSYLQhj6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHfMtZt+vxXu4AsA2YoSNiCBosUQMBQSvuQw8WbT6ic=;
 b=E0fz/ieVPDKFOQcTBj6RadCMrGPrK53SoTGooGVF04mMv9FoOpodfOOm8FOdIBP70dcCB4a4GX+Yre06aekcaasi19CWK7bXs8k3cPXz2NJ9FcwuIQLvQW8cXsBqgX3ogiv0guFk2zqsb1UCND90Yqo1+ayAIi34E5v4Ztn7Fk7gIn0RyGAaYU2wFW+jimOHYeF+E8Gg/CcfBnWCkGlO9BQCL4GQhTFFl+P3jyPij2/3UOsvufJCYkqron1IHrBTRAkjtBeHyau418IXcI8SyS6GhTyRS7xlDeHoGJ8GPE1RD+zqaVDhVonYBfxLWaLfMMCxl46/Y979ghlf6dtcLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 14 Jun
 2024 09:23:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:23:12 +0000
Message-ID: <5c0fa1d3-1940-47bc-8301-de3e7444689b@siemens.com>
Date: Fri, 14 Jun 2024 11:23:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
 <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
 <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
 <dc350628-f444-41e4-93e8-b9724046b5a0@siemens.com>
 <5c4192f8-067d-4a92-9ea2-ac5e77ff65bf@siemens.com>
 <fe10e88839a636a104fa1fedbe75e424664763e1.camel@siemens.com>
 <9c69a0a9-8307-4cf4-804b-1ba49353bb52@siemens.com>
 <79f348d6442039a74eaa2f4129d1a5af5845ffdd.camel@siemens.com>
 <3b341ace-3af3-49b7-80a7-2343608674a1@siemens.com>
 <7abb72db58b5398ddcc353e238d1694fceaba283.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7abb72db58b5398ddcc353e238d1694fceaba283.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d54eb69-f2d0-410e-15ec-08dc8c539d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTJMN01mV3Q4YU9yRTR3RXYxcG0rUU5ybVRlbTl6aGJMd1hYeitpZ0srMGFS?=
 =?utf-8?B?WjlCUmVTMU9xeWMyMUl1VEVGZUFkUFo2ZUhzaTFuWURpNHFXVDNZOERkSnBT?=
 =?utf-8?B?eFI0SEdDRW13M0RlQlhveXRPa0hYZFc3RU9ua2kwUzdkMnBUMmdxSzdORWRZ?=
 =?utf-8?B?M3NIZHFMeUo2SXRqSkxyRmhoZk93VFc4OGJ0T2ZpR2hya1V1M3hRUXI4WW9Q?=
 =?utf-8?B?NEVPZWl6dmMvaWZnNEFkL1BDNGc2S3Ewa004czE4ZEs4NytodjBSbFdMRkV1?=
 =?utf-8?B?cU5wcHFQOE5MQTJvcWNRYUlqdzJMT1ZUQzNoeVZETWJnVTVxakxCQlZhNDF5?=
 =?utf-8?B?Q3gvTFlpc2FXTjdqMkJXNS9NOCswaXdLWEV4amk0QTN5QUpGdkF2eEJWcVZX?=
 =?utf-8?B?TmVBYzRIa1Y1TmdEZEN0N2VZa05NQklVb2dsbHltVGJrNWp2ZFlBS0ttcjF1?=
 =?utf-8?B?UWtwMnJYQkNiZG9HNlZVWWdWaENXRUszOGRzZ21ZWFc4TituL2V1dEkrTDR1?=
 =?utf-8?B?RWYwek5EVWlBZWVtY2MvRGpEdTZFQVg0ZGNBZVp1cXF4TEpXaTJ2bGIzL1Iv?=
 =?utf-8?B?Wm1GNFpvSWxTdWN0N0ZOZzhtdWppYU0wVzVydDFhVS9Ob0lpOUV1R3k2L0pD?=
 =?utf-8?B?TTJ2TkdDdlB3ekh5K3NJTWlIUVJhZWlrOFhMb00rVnUyWVJWRkdkOGI2SGZv?=
 =?utf-8?B?b20zWE9tUjJGUVRGd0pYbzNtbXo2Q0wwRnB6UnNqTHVkTG0yOFFGR3pRaFkr?=
 =?utf-8?B?VFo2Wmo0alZ0aFI0VVJjQmJuZUpyeUdMYjUzRXhmQzh2M2Q3Wm05RjQvOHE5?=
 =?utf-8?B?UmdzUUFXTkFGdk0wMWlWTzVXaDIrMW03am9lK2NlV1hxZjdreXpVbldOd3VL?=
 =?utf-8?B?Y1lVVCtRRHF6eGpWNG0rOTBZbXczUktucTVSNXBsMXF2NW9PZ052VXNIcDZq?=
 =?utf-8?B?VDg4RWtFSE9Sa3lzRE1ObDFkbnFFdWxLTGVXaXVkcGVWbDJxWUVQUXZlV3h4?=
 =?utf-8?B?bTROWU42clNKY1d0ZkhvNXRVak4xWnVxRlhLVGZQRW8yTzZBZlpBbVU2REFi?=
 =?utf-8?B?TjM5eXhyQWFIRzNSdVBGUVlMMGp6ZmNOQTBNL05jalBMSGk3NVhQbmFpNzRG?=
 =?utf-8?B?OWd1RWc2eUM3Ump2ODdHVHNNcjhjbm4xUkxGSncvOC9FMHF1KzEzQVdIeUMz?=
 =?utf-8?B?K1Viemh4MVZWem1ocFB3cnF3KzkvVzJkN00vRHlBTG5MK3VsR2NOaE9kTGtE?=
 =?utf-8?B?NlMzYjIvNHEyVXhUVmNsU25CYUp3MFhDc2VCQnhFcXhYL2dTdlIweitTOTRF?=
 =?utf-8?B?Nm9vOENPc1p0VE43Q09iQm9RSHhycldwUUlKdG1pQzdlZ3BPTW16eEtiQk5q?=
 =?utf-8?B?WmpoOCtyVW8wbU5hWVhaRHVyOE1rNk53RWpkdFA1ODhHM1lZbk5kTnBFSGln?=
 =?utf-8?B?REZmSldKNzhvcjlrc2l0dGtXSUoyS05DRThmVGh3VnVNbFkzRWo4VG9WV1d4?=
 =?utf-8?B?aHBCeWFsK3pzcVdJWGcyRnBvZ1V0Q2xUY3RFRHhMbGZ5U2F1ZWxja1psWGZP?=
 =?utf-8?B?OFRTMXlzTXRVMUhkSXR4SzhWMVhYT0w5VnAwRWYzUGxFWE5FSFRLWmcyN2pB?=
 =?utf-8?B?ZDI4dDlKK3c3NHkxL0piZkFtV2NaMVNMbDduZG1rOWltYlJPWGRtcHN5WVpM?=
 =?utf-8?B?dE94dDBrRFZxYy9kaGlIZ2VLL2VralNtYUFKOEdyVnFrb1BwZnJhMno2QkhO?=
 =?utf-8?Q?yttfaQjXj4i+q4J63cD7d5ldnl648FY5enmeYf9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzRUeGxVSjhuL1lPV3Z4eEtUeGk1b2ZidjVJelBFT0ZhUlZKSFo1NTNrSXFQ?=
 =?utf-8?B?NFZHZXZpTVY2MUljUzQzY3Z6M3Vib1ZvTEYwaCtJcVg2Vlhwbkx5Yi81NDIx?=
 =?utf-8?B?ejRiN2FCS2tuK1NhTy9NMVZXR0RtbEtNQUN3bUM4RUo2UEs0SjZWbWhxaXFF?=
 =?utf-8?B?TE9zYXF5cVFjZlppVFNlbG5LTjFEcm5mOG9wQ2ZJWkpUQkhOSlRjM1Z0ay9h?=
 =?utf-8?B?V3FKNE1DbzVOZU9GMGZIZEV0MTBuS3ZCTnE4TzRmaFpaTmZOZEdheDVFTCs2?=
 =?utf-8?B?VXpqMTlaTndvdHQ0MFdaRm92SENKQ2JuYkd4K2QreGdDVG40djJndUkzazFS?=
 =?utf-8?B?UnQ3ZXpQRks5eThLNGRxanZJM2FvNXNGRlF0SWRCWTYxcmlXUEQ1M2JXWVlx?=
 =?utf-8?B?T2x6QzRuK3E4U1lKODQzU2Zqd01vK0U0SDJXdzE2TmFHZjd6SXVaem50QTRp?=
 =?utf-8?B?Tkl0OHpjbUY5dHVSZkhYM3ZJeXhHUUhMU0wyL01ObW1pMlltVTB4VFlxYTJK?=
 =?utf-8?B?dWxBN2kvN1JsbGRFTXVmaFNyY0k0a3VMUkdYcHMwZWVYQldVcW5zRUNTWk5j?=
 =?utf-8?B?L1Q5SGUrYVVGZGxzaTZpcTV5MTBLTmhPVldlU3h1M2xrSlR0UnB3cG14YkMv?=
 =?utf-8?B?N0w2MEF4UUd6L0k3TDJ5NXJXVDFJNUZ3SXV3ZENNN0g0RFRtemRxNWcrTTJt?=
 =?utf-8?B?VVZicU1BcEhtQU1wbWppSWJwUVc0UWVYdW1idlVIQTFtMjRIemNTMmFDRHV3?=
 =?utf-8?B?NVR2NlVTdSttTU5MKzBMc1hWQ21VbVFZSk1qU2MzTUd0UFNRa2M1K0phNjg4?=
 =?utf-8?B?M2J0V0hzZ2cyZ2JRSkwzb3kyR1dyT0l4MFA4WDBrS012Q00rdGs2VjUyeWly?=
 =?utf-8?B?WWxLRzhBM0gxeTl4NUVRZllFaCtuSmhZZThZcHFNcTYzN3hZV0dmMGZHMldD?=
 =?utf-8?B?SDJIVk5oeEhHVXQrcUthMU5KVHI4elhXeFQ0UEUwSE9WRWtGOVRNREdjVi9z?=
 =?utf-8?B?VEdEQVVLM1hQSktJRlVvK3lOV2NmTXhFL1JIYkZlZGt2eHpKOXlQSHR2aDAz?=
 =?utf-8?B?VXU5R0tmTWRLRG5VNzl0c085Y1BXQStpTXIxVTFYWVBwQ1dxb3kzcU10WW5Z?=
 =?utf-8?B?ME1mbTYycjJpSHpRNVJoanp4ZHhzbVpsUVVMRDNidEZrQUJ6N2k5NmFDREsy?=
 =?utf-8?B?cnM0M3ZHSEdLdDMrUlVRMjZjM0lZeVpvTm96QUdPSlJoUTR3WmJjVmNQSnJY?=
 =?utf-8?B?QTU0R2FqSHlRd0ZoZ3ZyaldrZmxsZ0dvN0N6WEdSM1U3NmFtcTB3NVVKTVZp?=
 =?utf-8?B?YjZSWkk4YmpLeHVyMktMSWl2NGg5NnliL0VlWkllcmI5QXJ4TnQvY2JzWGFE?=
 =?utf-8?B?MFJBUUxXSnVuSi8reS84WHAzTGlkUEt4THVSQy8xOTZwOUprajlYME9JanIx?=
 =?utf-8?B?dlZVK05Scnd6YW1ZZVk1eCtURjFTL0FSQ1VuU3pFWllUQlVLNkVva1p2OCs2?=
 =?utf-8?B?V1RlVmtpbTZpOE52dmlvdTR6ZjY1Q0dSY3BUQU9xMkp6OXRpK3J5amtlVEZ5?=
 =?utf-8?B?SENiT2ZsUHZZeUx6RTNYRVpLdjliZ1pHSlM4NXc1aTdtZEdXeXgzdGZIQUVK?=
 =?utf-8?B?MXI5ZU1URmYwUWJsbUNrQTVqWjhkVk0wUnRnVEFxLzRyVFg5dTB0eWN4NmdW?=
 =?utf-8?B?OU53UmhrYjhiZTBkcnpmMlhtSWYybzAxbVJwNjBYUHNEcFpJWU93dSs1NjdY?=
 =?utf-8?B?Y3BoV2ZkWEh3bkJFU1o1MnlwbGNaMTJQOEVvRkh4OTllR1N0eDcrUXVPR3cy?=
 =?utf-8?B?TnY2K2hpcW1jWUIrM21tMXZwbUsrQVNLdkw0cmRSSUpnemIvdjBqdUFlQ296?=
 =?utf-8?B?b3craGZaMHJrcE03TTFYV2l2eHU3MmdOZzN4U3pmZjNTWTFscU8xK1pVQks5?=
 =?utf-8?B?bXhtaFdHWVRLUkNoeEkvdWZHNjVhSGhmeUxhMVhNNlpDcERuVEt6OW1VTVZX?=
 =?utf-8?B?MEdHaUlKRFIwQmlvZzF6YlNtUERsSDIwa2w4MXJmRG95SytZSDM1cEJtSGZo?=
 =?utf-8?B?UDZsVlY2amExbkhzMEg2VGlqQ1VDT3NyK3pxUUlBb3VXL3YxRU1aYk1wTGZU?=
 =?utf-8?B?QVZ1cUt6SUhkZmkxTmI2ZmNLbkV5UmFpUHV0UTA5Ukg0Yk80V09sQnU1cVVH?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d54eb69-f2d0-410e-15ec-08dc8c539d40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:23:12.9327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T78mjoqlo0MivpeiG48DrlGeV9LD1nRXdIf1FNLdZ/64DQHxLo3QzXyuEyTYORRTnBhfp3Sf7b30fC33YPZ9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3214

On 14.06.24 11:16, Florian Bezdeka wrote:
> On Fri, 2024-06-14 at 10:04 +0200, Jan Kiszka wrote:
>> On 13.06.24 18:15, Florian Bezdeka wrote:
>>> On Mon, 2024-06-10 at 23:16 +0200, Jan Kiszka wrote:
>>>> On 10.06.24 09:58, Florian Bezdeka wrote:
>>>>> On Mon, 2024-06-10 at 07:43 +0200, Jan Kiszka wrote:
>>>>>> On 10.06.24 06:21, Jan Kiszka wrote:
>>>>>>> On 09.06.24 13:44, Florian Bezdeka wrote:
>>>>>>>> On Sat, 2024-06-08 at 07:31 +0200, Jan Kiszka wrote:
>>>>>>>>> On 08.06.24 01:04, Florian Bezdeka wrote:
>>>>>>>>>> kvm_wait() unconditionally enabled HW interrupts when called from
>>>>>>>>>> pipeline entry code. That broke the PV (paravirtualized) spinlock
>>>>>>>>>> implementation.
>>>>>>>>>>
>>>>>>>>>> When running with CONFIG_IRQ_PIPELINE enabled we always call
>>>>>>>>>> safe_halt() to allow HW IRQs to be handled.
>>>>>>>>>>
>>>>>>>>>> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
>>>>>>>>>> Linux.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>>>> ---
>>>>>>>>>>  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
>>>>>>>>>>  1 file changed, 53 insertions(+), 6 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>>>>>>>>> index 655b1cf8c9ab..3180a26cdfe1 100644
>>>>>>>>>> --- a/arch/x86/kernel/kvm.c
>>>>>>>>>> +++ b/arch/x86/kernel/kvm.c
>>>>>>>>>> @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
>>>>>>>>>>  	 * for irq enabled case to avoid hang when lock info is overwritten
>>>>>>>>>>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>>>>>>>>>>  	 */
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_IRQ_PIPELINE
>>>>>>>>>> +	unsigned long flags;
>>>>>>>>>> +
>>>>>>>>>> +	/*
>>>>>>>>>> +	 * We always use safe_halt() to be interruptable by HW IRQs.
>>>>>>>>>
>>>>>>>>> Nope, see below.
>>>>>>>>>
>>>>>>>>>> +	 *
>>>>>>>>>> +	 * HW IRQs off:
>>>>>>>>>
>>>>>>>>> Let's stick with the nomenclature "hard" instead of "hw".
>>>>>>>>>
>>>>>>>>>> +	 *
>>>>>>>>>> +	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
>>>>>>>>>> +	 * lock owner.
>>>>>>>>>> +	 */
>>>>>>>>>> +	if (hard_irqs_disabled()) {
>>>>>>>>>> +		if (READ_ONCE(*ptr) == val) {
>>>>>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>>>>>> +			hard_local_irq_disable();
>>>>>>>>>
>>>>>>>>> Just halt() - if we entered this with hard irqs off, we cannot assume
>>>>>>>>> that it is fine to take an IRQ before returning. The kernel doesn't do
>>>>>>>>> that either for Linux IRQs.
>>>>>>>>
>>>>>>>> ACK.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +		}
>>>>>>>>>> +		return;
>>>>>>>>>> +	}
>>>>>>>>>> +
>>>>>>>>>> +	/*
>>>>>>>>>> +	 * HW IRQs on:
>>>>>>>>>> +	 *
>>>>>>>>>> +	 * If inband IRQs are disabled the LOCKDEP state is already correct.
>>>>>>>>>> +	 * We can disable/enable HW IRQs without further bookkeeping.
>>>>>>>>>> +	 * = Linux IRQ context
>>>>>>>>>> +	 *
>>>>>>>>>> +	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
>>>>>>>>>> +	 * infrastructure about the HW IRQ disable/enable event.
>>>>>>>>>> +	 * = Task context
>>>>>>>>>> +	 */
>>>>>>>>>>  	if (irqs_disabled()) {
>>>>>>>>>> -		hard_local_irq_disable();
>>>>>>>>>> +		flags = hard_local_irq_save();
>>>>>>>>>
>>>>>>>>> Why this? We have tested that state above and know it for sure. Just
>>>>>>>>> keep hard_local_irq_disable().
>>>>>>>>
>>>>>>>> Paranoia and to clearly express that we try to restore the state to the
>>>>>>>> state that was observed on function entry. As hard IRQs are/were on the
>>>>>>>> result of irqs_disabled() might be outdated. (I think that would be a
>>>>>>>> Dovetail BUG(), but paranoia...)
>>>>>>>>
>>>>>>>> No strong feelings here. I can change this if this is preferred on
>>>>>>>> other ends.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>  
>>>>>>>>>>  		if (READ_ONCE(*ptr) == val)
>>>>>>>>>> -			halt();
>>>>>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>>>>>
>>>>>>>>> Yep, this is needed to avoid delaying hard irqs while waiting for the
>>>>>>>>> Linux lock-holder.
>>>>>>>>>
>>>>>>>>>>  
>>>>>>>>>> -		hard_local_irq_enable();
>>>>>>>>>> +		hard_local_irq_restore(flags);
>>>>>>>>>>  	} else {
>>>>>>>>>> -		local_irq_disable_full();
>>>>>>>>>> +		local_irq_save_full(flags);
>>>>>>>>>
>>>>>>>>> See above.
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +		if (READ_ONCE(*ptr) == val) {
>>>>>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>>>>>> +			hard_local_irq_disable(); // fix HW state for LOCKDEP
>>>>>>>>>> +		}
>>>>>>>>>> +
>>>>>>>>>> +		local_irq_restore_full(flags);
>>>>>>>>>
>>>>>>>>> How about this instead?
>>>>>>>>>
>>>>>>>>> if (READ_ONCE(*ptr) == val) {
>>>>>>>>> 	safe_halt(); /* enables hard irqs */
>>>>>>>>> 	local_irq_disable();
>>>>>>>>
>>>>>>>> Confused. I think you mean local_irq_enable(), right? Otherwise we
>>>>>>>> would jump back with hard IRQs on (again), but inband IRQs disabled.
>>>>>>>>
>>>>>>>
>>>>>>> Yes, enable. The goal is to avoid that hard-irq back and forth.
>>>>>>>
>>>>>>
>>>>>> Actually, there is no need for this dance at all. Just translate the
>>>>>> Linux version of the "irqs on" branch to dovetail:
>>>>>>
>>>>>> 	hard_local_irq_disable();
>>>>>>
>>>>>> 	/* safe_halt() will enable IRQ */
>>>>>> 	if (READ_ONCE(*ptr) == val)
>>>>>> 		native_safe_halt();
>>>>>> 	else
>>>>>> 		hard_local_irq_enable();
>>>>>>
>>>>>> There is no reason to touch the Linux IRQ mask. It's open on entry, and
>>>>>> we can take any type of IRQ while waiting.
>>>>>
>>>>> Correct, but we would miss this hard IRQ disable event in the tracing
>>>>> infrastructure. Is that OK?
>>>>
>>>> Not sure if hard irqs are actually traced. I thought they aren't with
>>>> the given functions. If they are, you are right.
>>>
>>> hard_local_irq_disable() simply turns hard IRQs off. See
>>> native_irq_disable().
>>>
>>> The replacement of local_irq_disable_full() is:
>>>
>>> do {
>>> 	native_irq_disable();
>>> 	do {
>>> 		bool was_disabled = (arch_irqs_disabled());
>>> 		arch_local_irq_disable();
>>> 		if (!was_disabled)
>>> 			trace_hardirqs_off();
>>> 	} while (0);
>>> } while (0)
>>>
>>>
>>> It's basically hard_local_irq_disable() + tracing when the inband IRQs
>>> were enabled. That would be the case here. Do you agree?
>>>
>>
>> Yes, and as we have no need to fiddle with the latter, I wanted to
>> reduce all this to the hard irqs.
> 
> That is understood. As we agree that tracing is not necessary we can
> simplify further. Preparing v3.
> 
>>
>>> I think it's worth to keep / get a trace event here. The underlying
>>> hypervisor might be the source of some latency. Would be good to see
>>> that in the trace.
>>
>> What business does the hypervisor have with the virtual IRQ mask for
>> Linux that Dovetail maintains?
> 
> There are two ways to come back from safe_halt(). The first one is a
> hard IRQ, the second one is a kick by the hypervisor triggered by the
> current lock holder via hypercall.

Correct - but which trace events are then missing? We are briefly
turning off hard-irqs here, right, but those are not traced anyway.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

