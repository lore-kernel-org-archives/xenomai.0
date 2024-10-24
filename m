Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A71B392A
	for <xenomai@lists.linux.dev>; Thu, 24 Oct 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765881; cv=fail; b=uVzzqlYV1UiU0hkwzRG3/A2nCVrUeLmOAs76iB33TKqv+toa7zguBpWnZC/gGluDl97zLBS4VNSgCAWg5Mu5RcEpATE/lxIGNmP/O9U2zlLKfdZxOhMNHrZjRYKgtVqd/5XQxA7xVMKcCKUTRE0hFzxQdrJg6PbUqDBwMV7Kse4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765881; c=relaxed/simple;
	bh=eBGVBRP0BQY/GY0rABxOKfu1IrZGm07x3vGL1PksPIg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ruD2xLJiDZk0V1cqr/r97QuXTz6eU0ajp6/B++h/lgk1l4fOcgKYLmAb0EaYficENxLiN39dSKVEtbrgxCaSF36nqcAz30kWke++fM2Ku5PcaXjOv5sKIePk5solwPHKKHNATzasDOQLqDjDtqyfZD3awEg7AIDZ/xmAOaFKB8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ocaxLvh+; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ocaxLvh+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUwdsoZpLheU0fkR+a7orfyUO7W0MZdgxQ79ydv5JpkjeeWFlXYIcRgGYHmeTQvsjClH5GJuR2EQfX19O8DYYUQR9aqJj62GKHsuocSe15qGT5obFAxxuP81sjQOGrJw5V5LcPVVfVLkyhSqbKDCTSU7pWyl1j+Ur+DfXxGciW6pB7pSvVnYE8AaDIgVGYFOPlZBsgDBR17PWSQyL+GWIYptgyTX3XzAxm1SVfa0k4MU1HOoo0zB1GU3c9/dryevZMYcLgkR/4t37AsoqtAetyo6tTruBx8FNvrsKMAr5eqxRRCeJP4d/1PpD5AACP2jm4gadJydxx8u0yNJ4YBPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWzAWfbdNDNR0N3o5b8+Nv4mdOoj6GmRXn7FkQuwuJs=;
 b=fkgjYw9AjonamlEipAOfMQE6hfcGlbC+1zlh/Zg8x8J+e8gq58WgBSvWcPcN5xHcMpcavQreYBRr/3hsEyg/U62I05zn9FI6WAL7AVjuFbjWv0IXDGFfTftTrh6Em8j5Xze/d+yMVUU4OrwAf+A+hSzQDrv580nhfso75SpfZymObU3hTzG2YLwlutYrAPicsVATqaKqnJ8t3PeDfAVZregI6egLTdnflVrNu2PMmhQyBDu9uQykF6NCtsm36dV7qrRb/FqvzkB6c3+0fxi2ukVtr+BDjZrsYpC2zUELeBX2FB6c3zj+eYO8+gBZXhDDAI/6TwRan6/01shfPWZ5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWzAWfbdNDNR0N3o5b8+Nv4mdOoj6GmRXn7FkQuwuJs=;
 b=ocaxLvh+ArcDO/4P83h/mhs6sTYB/3C0ydrOCGsWLIohAJCr+dHqbaBBThqsCrwYtvK2CxwSckcM4rDvhT1cCRmQk1z5qaENK4Tz35Q6Hla3wQi33yULZFo0YHSmuHuBGKvNSKq5oKN07rMMFxUh12bPRnM4eVjlBbIaTdBDq83Em77qpISkkAOuMEd6BhjeZXi/wbD60wJOd4FyTFtPs4o3CM3oJUDhsmwvpI3PEj1KWO+2aycgITFhe15tre0spPKb+1pysAvn0lk6lOW1Nra9bX2d1Phw94mVJFKiU9dvvVpyzfACCvjZvmafUBh7WFe3V52zDe3aL8e0lSiLUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 10:31:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:31:15 +0000
Message-ID: <5aa16691-f61e-4566-955b-fec07b144322@siemens.com>
Date: Thu, 24 Oct 2024 12:31:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] y2038: lib/cobalt: Fix __STD() macro usage for some
 services
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241024072656.179803-1-florian.bezdeka@siemens.com>
 <7d1df6ce-21bf-4a1c-b8cc-ff2c449c6575@siemens.com>
 <2bca1fdbb9ff21c91cd13a583deaace3157baedc.camel@siemens.com>
 <dcfe813f-0186-45da-acb3-76fdd9ba9b9b@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <dcfe813f-0186-45da-acb3-76fdd9ba9b9b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: a7de4cb4-9261-4fe5-6b4a-08dcf416fd57
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dityQ1JHdjZGdDcyMk5oZUovMGdUKy9BUXRrVkJXN3ZiWXY0S3dSc3c1TFVE?=
 =?utf-8?B?d2xpbiswU3BmSUp4c1pjRk9OOThqK2NjdnJtNnNieUZUQzZNckRXNDArR2Fs?=
 =?utf-8?B?clNQeWpNUU1nZ2RQOVZvMHZWd0wybm5ObUdKWUNaZnBGeDh6TlVHYzhMcVhr?=
 =?utf-8?B?cHZyY3dRZ1VhTHVFVm5POW56cFVRRVB5WG8wMGZvVEd4NnNuWmFaWit1Zzcv?=
 =?utf-8?B?OUNkNVB4VkVYMTY2c0REVUpDU2tLc1V5Z2F0cUQ2WDdkaU1NUWxnTjNqcHlE?=
 =?utf-8?B?YVF0c050ZVZFK2tiVUZWYW5qdU5iOWpDQStzeG40c2dIVXQ5Z0hGUkt6bmNQ?=
 =?utf-8?B?Y09xNGUyRkIwT1NLNHlzOXBiUGtqOURzdGF2REFGK0RMVGQ1bk5qekNiVzV3?=
 =?utf-8?B?YU9mYnd4NXBaZnR6MHlZdkFQclpSS0RWa3lKdkUwQldsTmdUNTJQaS9mVFhZ?=
 =?utf-8?B?amFyeWxhLzJsRDZDQVZnVXhxcTF1RlROTUpwT0NYeW5LVWZFU2haTnorRkVR?=
 =?utf-8?B?dE4ybHN4bkYvWDZ6QVFldVd6b0dZekdhZG4rQkpDMUhoRmxjZER6L3hqSWlR?=
 =?utf-8?B?Znd1ZkcvTkZoYnBVZFREQ241ZUFOcjNYWTFnZ2N6VWRiSERnT3FtL3RHbXh5?=
 =?utf-8?B?RTRPcDNFRkg1UlF2TzZhTWVlbWo0VWdtRUxLZEZmbUJ0RTdhaWJYdjdrNVNK?=
 =?utf-8?B?b1czSldXSktRS3BvbWRUYkc5OHc0b3FlUjgwYnlXcmY0amVkOUNRSG5rNWI2?=
 =?utf-8?B?d2JudnFtbS80SDJUSmd6Z1FBaS9jN3B0ekRBRTNuY0JmYjB2dWlEaDBwY2pT?=
 =?utf-8?B?Tm8xTldMblhMQW9hcEJXMHFSRFNIZUNvQXhvWTBrbTEvOGQySUM2aGdUZ25C?=
 =?utf-8?B?bkh0MnRxQ0JZUXNNSGtYVEt0Q3BVcElKSWgzWjJjaVBucFF0cFV0VjlIUy9J?=
 =?utf-8?B?TTAwOFFHWTV3QVBVcGhBQmprMFdOcjYrbGx4bVlsUTMwVVEwQitMMFlPWXJG?=
 =?utf-8?B?R2J4L0ZRKytTRnJHQ01DbjF6WVIxa2VoSWpYLy8xSUhWUWRIUm5HVmcrdU9I?=
 =?utf-8?B?Zm5BVWxPWlpEbGhHRnQrdTdOSTlIVmNzanNqWXhxV1JKZElpcE5BM2Z5MkJw?=
 =?utf-8?B?R1dsT2NXVUdrS25EODcvSU41OHdLZk1RRjV1ZzE4K2tjOWlEQzhEVi82bHdX?=
 =?utf-8?B?WDV0eUJVK2dlY3RLSWxvYnAySHBxWnliK1ZYZ3JDQ3NjNzhyOElRdUpDMXZj?=
 =?utf-8?B?b3pPdHRrcVcvdUlDbGlhcWJmTVVFWHJ2SWJQN0hxNW80dGNMSVEwTktFUkZF?=
 =?utf-8?B?aUxLc2VtMnVKclV2bVJVUW5XckE1MG81WVpaNGo0QlRpQWdQUmRYTysrYm9E?=
 =?utf-8?B?U2xkaXNnTWtIWTY3Q09Ycm1tWC91L3JSbTdpSGVYdnk0NXpDK3RYdit5dXJY?=
 =?utf-8?B?WTBsVUt1Mm9lOHM5Y2JMZ0dYemdDcjBpZzhLZDFVNWZRL2IvUkxZWk14M2xC?=
 =?utf-8?B?T2lnMkRCZUYweDgvNjFENmRBTWp0VTBJbFkrbW5vaFdBbGpoalhvaTExaXRx?=
 =?utf-8?B?T0JwY2kvdEE0SWxTNzQ0a2JDUkpiaGdDQ1l2Wnp4U1o5TC9ORmxVOWRqYWt2?=
 =?utf-8?B?end3L05vZjBOTFRlWjVFTXhyYnJYWGpiTml4WmVTR09zSVdlSVBsUnBQRVd0?=
 =?utf-8?B?dFlKZFNPTnZMNnhZUUY1TUFqY0VMUlZwcy95MlZLZEx4Z2tsZm5YdFl2VG1Z?=
 =?utf-8?Q?VJI0Xo2Rp5YTfIYTtB21b4V/hniaDkYWelEcjkC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUpPTFlsaW1FOTA5bjd3TXFOMDF6REVUVHpPR1pzaHZRcHUwZEs2Y3BNaVQ2?=
 =?utf-8?B?SjBqb25lSXhlRWludDVrRllwZTQzMDNHN3BWR3RCVEdHTk91Z2QvOTgvbHI5?=
 =?utf-8?B?UFB2bDFOZklzUkI2OGI0cEN6YVhSVm9jMkFPWmV1UU9PaWFrdkdIRVJ3TEZi?=
 =?utf-8?B?TFRUeFl3M2x6MHg4cEoySkc5Vnh6WXNTenlnNnI0RFJ5Z3BQeDRteHNUVHhR?=
 =?utf-8?B?U1J3THpKMTEzSjJudWNLNnp6V2xTL290dWVZNjdZNDdseW91NVdYVnRKQmU2?=
 =?utf-8?B?cW1ScCtoYzhzWEI1U3FjeGNUSlQvYlFzNWlpdkZucWdSS2Y5M3JjMWhOS3pq?=
 =?utf-8?B?YjJoS0UwQ2VqYnE0WjdVeW5BZzh3WkgrVFlIcHBwVGVWVHNTazdzY2x2TWFF?=
 =?utf-8?B?WFBIL005NVpjZmQ1ZDNMalBCaExoZTdZNW9QU0FTc2ZtNGlCaW5uK2xNUE5M?=
 =?utf-8?B?NThkZmowZkpMa05RWTJ0cXY4NnN5dWpLQmhxM2RLaE9QVGJLeTZqUEtIOUdL?=
 =?utf-8?B?QVJHVGVzM1JNZHJMZy9xc0Z0NmNta1RTVzNZcHNiTGNieDdySUhhcTBKeXR3?=
 =?utf-8?B?ci9JTUFhVTdTVVRSeEtCL0RtZDkrOXRnV2t4eC9KZTRSZFJEVEE2T1czMjdi?=
 =?utf-8?B?RUNtU2VJUmlYY1YrcDBGNk1PcHVaaXZpV0NGd0dRbUtHeWQxS0xpY3RyNmVG?=
 =?utf-8?B?aGhITGhiSWxMMGhVTTZ4SktibktvSWhDUzRIL2tTdElTSUhMWTBlTkVhbDJZ?=
 =?utf-8?B?SVNaZ2tMM3V3OHcyV0FyWUNlUlpHUjlUZ0dJNHBvM3ZLMVgvSkJqR3NPK0xK?=
 =?utf-8?B?b2YxUTZQeDk2L2x3VVArNlpmVElqekE2L0UrSzhLbjZyOGZxcUlkMTFsWjYr?=
 =?utf-8?B?Mi80eWVMNWswcFhTSDBJOFJFRmw3dUcwNGg0dW9ubW93b3FOZWJEcWxsdDRM?=
 =?utf-8?B?V0JudWgwMGZIMWdLc1ZYbkU0OFV0akw5dHgwMXdpbU50Nnd1dm1tZEI0N0Ji?=
 =?utf-8?B?dFArYk1RMjNWWEtVQXhzV3NYK1hKeWhJeWtZNExHWHZjaDlEMFgxOHV3MHov?=
 =?utf-8?B?bDRCbUJpRG9EaU4wYVIxWkxvMjViMFhoa2FyeXBaRjhRdkg2R0Y3TUNwdkFH?=
 =?utf-8?B?VHFjc1ZyT243SER3a3JBKy8rTjNUVVh5R2U0bjI5Nnl5c3pINFdGYVpFS1NI?=
 =?utf-8?B?cldzNHRFbWV1SnIwM3JhbDQ5UVNIWitEcm9WL3lNMmFSSlByNy9LWFp3Vk0w?=
 =?utf-8?B?aHo5b0RIaDM5YTVROUsrZ043ejFjZW9HRXpvWW8rYU9TTDYzS09nVGhLZU5B?=
 =?utf-8?B?WS9URHpiWmpBUE8yNGFqWnlpaEpKTUdQZlNBTFlIdDlmQ3lCV1RQSXFPckVx?=
 =?utf-8?B?UlJVWnRMdXpXdkIzR0x3R3Fxa3lnTkNFd01lZy8yYWE2Mkh1UUNicExUS3li?=
 =?utf-8?B?S25aS21hV29PQi9QdEdsRDBRVVVTNHNRZEsvZE04VXNvWnBOVmdla3dpaTYw?=
 =?utf-8?B?aXRaWXRQUDBDclFLMzlBM3FjeVVNUGR4SUpIdlpxelVTMFN3ZnRqd3lrQTkx?=
 =?utf-8?B?V245VXJwaEhEdXhLQUFQYXlwak9tc3J4SzdKV1AreTNEU3lWdHY2bktKNXlM?=
 =?utf-8?B?WkVIUXFjUW4xR2F0R1RLREJoMEZyWVFxcWpyQnprNnZMRmtMait6OHNuL0ZQ?=
 =?utf-8?B?RkR4WldJTFZGR0ZFMGFkOER6dVozSFh2MVV0Rmk0WmlSYkJ2bGhWMlF3NzNr?=
 =?utf-8?B?Yk1neG9xSHBzOWpIRmYybFJHRHNLRFRQK3lBZ0pJK2p1NkRPR2ZnT1BxUUtU?=
 =?utf-8?B?NGYvcmd5ckVBSE9aWWdGS0Q2MFpMN21jNXpGYUpadk83ZVNmVitKV25VaFc2?=
 =?utf-8?B?TXRVQUxxWnZDQnFEMk9WZnI3c0t5RTRaZ1B1RjJmei91WnNFYkpZRUxPMHIy?=
 =?utf-8?B?L1NiTHpNUHI3ZHpzeWx4b0E4RXQ0QjN6Uk83bmZiWlJ2SXc5UGFEZlRmdzc3?=
 =?utf-8?B?M0dtSkZVMjVHU2RjRUlBU04yazl6d1d6YnhpRW1xbm50QWdoNnUzdDJEMWJF?=
 =?utf-8?B?dTZOZ0hXZGgvbnlmc1VGMTRycTM2UGFWaWNQbWxJeUdHUUQ3Q3dydmNrakNr?=
 =?utf-8?B?VXZZL3hNTEFGRDFRR3ZjVm5hL3QxOEJnWDFWL0F6dm1KM0l3ZXpDTW5VQjlI?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7de4cb4-9261-4fe5-6b4a-08dcf416fd57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:31:15.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ltJY6bE6xDJ6JAiLXd2uDzWL0pVSSkmwCXgx9Yl6n7PO8URsLU7Mw1Uo2RRJwWyYWxv9WymL33A6n9mWBwiKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8843

On 24.10.24 12:30, Jan Kiszka wrote:
> On 24.10.24 10:07, Florian Bezdeka wrote:
>> On Thu, 2024-10-24 at 09:59 +0200, Jan Kiszka wrote:
>>> On 24.10.24 09:26, Florian Bezdeka wrote:
>>>> The macro usage was broken for the following services:
>>>>   - recvmmsg
>>>>   - mq_timedsend
>>>>   - mq_timedreceive
>>>>
>>>> The message queue services were forwarded to wrong libc functions,
>>>> the recvmmsg was missing the correct routing.
>>>>
>>>> Detected while trying to remove the function wrapping at all.
>>>>
>>>
>>> Can you elaborate a bit on the visible impact for users? And it affects
>>> 3.3 only?
>>
>> Yes, this is 3.3 only.
>>
>> Something like __STD(recvmmsg()) had not the desired effect on compat
>> applications with y2038 support enabled - which is the default for
>> compat applications now.
>>
>> Rare use case but still relevant I would say.
>>
> 
> So, I wrote "The __STD macro usage was broken..." in the commit message
> while merging.
> 

...which was already mentioned in the subject - missed that.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
