Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836F376BD2
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680637; cv=fail; b=k2gPy5cbEG/AnuSvbLA3mJEWTuTTsqvtgGF710mIV3dDoCxPoWyO8khpOi5QUjwKoEHhhhepTczddoHoKh5nqzgBEPRuCuRySF+r7TacXWVZbVvcANwYcSRswiWfRVYtoSNlwLCk4rqJsRf+xrPYYGwF2SupHexgc9qs7itU8n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680637; c=relaxed/simple;
	bh=5eUoS3g5TK0ZibkFGdCsAZ3Nw0Dob2EOyCYCeF0mnPc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DFbz6Ck/yxu6wT9oXrlwUgdsDATMCczIVa7DMGW13Pu05NyIl45NpW5h/qdiPtZC3APT4GB7HJtEU+AEyE4qQmI8T002yV+Nw+6UFOdZ8pFz0OXkoTshy+Y8OD0bFOkU4W++faDnk2s3C0ZBXYw8hz3R0m+cuEBh0RtC7QCeOOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Dz1S2kq9; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Dz1S2kq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDIiY+wF5UTlhdrCVE3/yaTUENdnBzd8ZZmv9fptVcTCazjZBB9/MSQxO0IwzUnkBNYQ6IWpooBoDRAf+KpiQ4BdJeZyC+6Ou6MICeJgJAuW2ZRsblOxrWcBGXy4/34M/bYIKdpIWHYyvsXYq/UcqbdC8aXJq8yp+XX80ONV2n1rlaJ3oXNUKTZuw9tC19Ra0ioSeRuS+aU1NlTO2cmqMDG7+xA36d9znx/U6caCpQDEqwrbT9BJLoJisFkztbIDuHW47AT9Y5v6AnuAXtt6nGIKgfokxdsHOYH0wjf9i4YA+fl7A0IXp28EvmhMikVCQO6s3RaIiIKgtQC19m9PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g1hdFfERsr3sTkyzjdSGILLCJNFPhVnFE4OaoKL/ZY=;
 b=D+tww/j8ncarKjO5yJKbYfMy82BoI3H4GG/JMDM0T2tpYSD1B9E9z8nb+Yz7T4jE8Hu28eRmld4qZFq2o1+V4yJIgQTEZ9+5Pl86xBop/3LAaG4SArHmyY270TxyXSXbuW5YkLMXAHAtTM8mZTmY5J7ipF+NRf4QPUN3tioELeH+QGZYHps5z5R9cVGMLULtcE+Xjx7kLmlb7nyMp6ufgcce1FxnuW5fGhx3BqGud3dG+KMnJVEdJhmkLLMJVWpKeqB9xwJ1SdQb47yZEc8n2o8Q60awbu/HNaomVIuHrlROhp6/A9naT7W1gm4SLHUPt1vZDzfKyd//M4Yme/nBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g1hdFfERsr3sTkyzjdSGILLCJNFPhVnFE4OaoKL/ZY=;
 b=Dz1S2kq9vrm9Aauo0mVlHs2h5EtTV0kgYX2ecUWM6jIbaPQQnKUzZ8yFrQIfKvP1ASB0vsfV+EUjsq0j0hq7eEblR5ZciqbxdmB2C0Btetmpd8mC1zwEuJy6cOVobpUNfEbRdNTM+qJyAlNNQSOJ+hfpsbevFU7yMuSc9hZUSJ+YkijVz7sq+h3B76HHJgO7eBlKs4gBMvWgmkjFVQPhcYB3mRVhnGmDV8enoBYfvsXqeAduAD+3OSL7dc8IvvL7wSEepK15N+o5+HEisZdCCBlxIHR2R7n362pPGWllvAmfZTT303t3uDyX5F31M9DynV9iTxz36UbxWsvp9JZBmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6527.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:57:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:57:12 +0000
Message-ID: <64c4befa-111c-43c4-ba24-5f079e17c4c7@siemens.com>
Date: Thu, 29 Jan 2026 10:57:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 upstream@sigma-star.at
Cc: upstream+xenomai@sigma-star.at
References: <20260127213927.26960-1-richard@nod.at>
 <2c9f0b74-4e8c-4542-b0ef-ee13ad21c2d0@siemens.com>
 <3506084.tBmWVcJkqe@nailgun>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3506084.tBmWVcJkqe@nailgun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ef699c-e95c-4fea-6321-08de5f1cc5f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUJuT05sYjlxUldCU1VzRndSdUhIMUlYZzhmRzJzdHluRS95SEVoZHNYcDZX?=
 =?utf-8?B?cURpRTZUUWd1aExndmtYaGRvWkZGQUJQL1U5TFkxWGpRRDhmNFBJTnp0VXVB?=
 =?utf-8?B?QmpqNWFyWHJRb3lYVFlqZjRsT3NkazlzU3J3MnE1bzJMRjN3NkQ5Z1QxQ1c0?=
 =?utf-8?B?YnZEcGtZaTRkRkw5bWgxWlAwWnd0TkJUdlFHT280TXB0K3NkYVlvWkcrVUE3?=
 =?utf-8?B?a3VzeXZLZEVRdUFYNFd3V0NkUW9rMGdTYXhnMVBrM0tXRlJpTko3UDlib294?=
 =?utf-8?B?cmdXckhwSjhTeTVPTy9OYWhGbjJ1VXhvUDkwdG94WmtuRnkwTUE5dFZacVFF?=
 =?utf-8?B?QWZxTXNWdnFvMUVHVkRTV2xkV1hnWGtMdFd4K2VmNnl2R25zZ09IZC9iOEJK?=
 =?utf-8?B?a3J3N3B1R3YxN2tSQ0xPYnpjSEFoSkJWS1FpTklSV21tT0h3cTA0RXhvREpD?=
 =?utf-8?B?UDBlK0FnMWJxQ0I3SWtyQ0R1UjM3M3I4SFFpNVdYejB4Y3A3Q0lqM05mVHdj?=
 =?utf-8?B?K3Y3c2ZNTW5ZWDJzYlNBYWJCRklmdWlHYWV0elBjNkVkdGxYd0R1T3k5aU11?=
 =?utf-8?B?TFZOUElkdzZ6NjV4cHYwZHFtcEluYnR1NDk0SjhLcUtmTjZOR3NaYzhROE1U?=
 =?utf-8?B?MlN5N0tRUjREd01TOWpWeFc5alNnTFdYQm1rQjVNNnovd1VaQ2t4eTV0OTAy?=
 =?utf-8?B?UTVhK2lOUDVLNjRibkhhaWZWRnI3dVZHWUdOMjNHZ0diNWJqSmk2akRvWUUr?=
 =?utf-8?B?VjQ3UmJrVXJRckFJOEZ2RDNTUmI2dCtHaUhEb2VacmtvNG9xc2liOGM3L1Zu?=
 =?utf-8?B?K25CN2w0cEVVMGNvd0FNbkFUUERrQlA3bHYxcm42Znk0NUZDUWtiVEIxVWky?=
 =?utf-8?B?cThaZEluR1JlYmsrSkp3VjI5S2VqSGJzckFQQlVkYmZYMEFGT0tabW9oYTFj?=
 =?utf-8?B?RjFQdVJqZS8vMURHMmZMT09WOUlxYlRZZVZtWkxtdHdxL041eWQ2b2RLVkpJ?=
 =?utf-8?B?SjZrVlpUSTRNM2tBZ0dTWGNTOGlkeW5MTGNjZk52Z2htOWF0TU5TaS9EdHQ3?=
 =?utf-8?B?eUwwM2ZRMkdiLy8rNmQ2ZHpwQUdiemc2bWc2VTVQRGcvWUJHNDJPT2JlS0xR?=
 =?utf-8?B?dkwzVHF4M1JxYXNXNmsxb09RbXIzZGduOWhsd3lDSmJ3S2NxaVpuaEM4RlVu?=
 =?utf-8?B?R0V5aE96U0FnUjNDd0VzZ0FwVi9NQnczeG9OOXRFWVRXajZraTU3VGI5SWJt?=
 =?utf-8?B?TDg3Q2xsTVJ4ZHl2aHh6YW5kcU1FUE84WTl5MGtBaXp2SC93ZkZVLzJjUGFO?=
 =?utf-8?B?Q2NSTVl0c3J6QWlhRVlOR09kY1pjUEsvSVAwVWhYMEh4dUFpbDFDNXBDSzVN?=
 =?utf-8?B?OXFPS0hyVkhkUk0xTnlaZGhWbFhnMU5OazQ1RmV1cldlQVBlWlduR3ZyYXA4?=
 =?utf-8?B?VHlaNWR4ZlRhUFVlSFUyblhBZUZwbWhYMVlKTUNKNzY5UXZFOFlaY3NRNXNp?=
 =?utf-8?B?VnBPblVLYXNac1hxelg1c0JFMyt4LzQzNFh1R2dOdlNKM01hR2RTQ2lqL0Nz?=
 =?utf-8?B?dFY2S2FOcmpFQUtxMmg1emwwa3lZVkJCcmVkRmpBYldCOVVJVFYvbGlHTHpw?=
 =?utf-8?B?Sis5N0JLYW03TWw3cWhxd1dJZTVtSU5TSU5YbjlDS2M3L3ZpeXBkRWFBcElp?=
 =?utf-8?B?Tm9YNDRoMWl4K3VzRldzeXZyL3lDU1loYkxxR2JCRTRxY0cyVkZXWGJPclRR?=
 =?utf-8?B?bFJ6VTRycXVEMkxaTHdPR3RxUzlwazZNYkpxNERQYVB5MGU5UXJWM2NoQTVi?=
 =?utf-8?B?SW9ZQTd5Mk1UYnQxaHF0M3lqR3VmcmlERmJOUU5jQjN2NXBGVlFrdlVHMDB5?=
 =?utf-8?B?WGxOWi82RGkrQWxsQWdDSDVRay92dklxb2hOODN2TlRweUp4RXppdCsxdEhG?=
 =?utf-8?B?NFJBT21sU0RyNHhZVnNSZjYzbFNwbE55NGlWMDJZNWlVL0dacmpuQzQ1Zm5Z?=
 =?utf-8?B?RzhCOFNUaFJiMHg3MGdLR2laSVM5ZXZKZjgvQzZBMGY3cUhnRk5Na2JVdzBQ?=
 =?utf-8?B?dkdhT3dOVitIbkh3L3FDQ05KR2lKaU1hZnFJU292U0lwMUhtamg3T1dFdDFr?=
 =?utf-8?Q?SH+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG11TUFWOHU0ajZCa1NKcjRhaTFxa1JqOG13QjBMbFhWUDZKYWxjZlgrTVJK?=
 =?utf-8?B?T3VzdXhtNDJEODczREFEUkxpdGtoK283UDRGa2NDNWNPREJKaDducU0wM3BV?=
 =?utf-8?B?ZUhuSUVuYm4xd0VGc3lnN0NoNWVSaEY0RTBIWXdXRUZ1V3pWMko4T281N0Fk?=
 =?utf-8?B?SHRqbm1LaWc4ejMreVRrOW5yUzlrU3V4QTFLaXpjOTdSWDRIRWZHQTZSUEgx?=
 =?utf-8?B?NVZadHAzeGh5TUxhODJuWmxLaWRJbTBrY3BjMVppVVllVXBrMGpWVnZSSkdC?=
 =?utf-8?B?NExzL3RBU1RxTytlcDZMa2RtRVZ5dkdKWkJlZFBIRDlhVUFvaTdST3V4UUs0?=
 =?utf-8?B?QzNrbzV1TlBFZ2g2M2NIT2pxYmNBK240NzhkUTJQZE1GeEFOZ2gzaThhWnhB?=
 =?utf-8?B?YjNBVlNWYUE4TzU4NkFoUzE4NCtTVVV4VW1DRXdvVVE0cDYrVW40b3V4RE9Z?=
 =?utf-8?B?eGR2UFp3aGJDUWM1cjNuNjJnbmxHaXhVK2dyWFUzN0MxVHN0blJSdUtJQ2lI?=
 =?utf-8?B?Ym1qM1oyQ0RvUEFmVkk5NlBaSTNweUxMZnBBNWdOR1hERGxJV1lHanlxRXhs?=
 =?utf-8?B?SU1nZExUMysxUEE3cndkMmlMcWllM3VNNDJINW1FREsyV1R1dTcyMXZleDZn?=
 =?utf-8?B?aTIvS2xVd0xHQkNnVzYxVW5Fck5Dcnd2NzBiZkNTQlN1c1pZaDlBYm1GU2dZ?=
 =?utf-8?B?Zy9wcXhWNzVmam5DNXY4RnpBamU3VzlYeU5mcExkTkpuYmNIYTdoUGZQY29j?=
 =?utf-8?B?M21IOS9IbE1XNVBabUNoMVU1SXlUR0lzbWdReFRkTENtRGRYS3pSS1FCT2R5?=
 =?utf-8?B?Vk9pVlRPOEh4Rm5valB2Y3hEME5DMDBIRGFGcWVkRTlveHp1R29mRkN2Z3RF?=
 =?utf-8?B?QWdLa25YOG1xaXdNaVR6R250dldZN1VsTmdnZXFIOHhBUGVQWnJ3VWErSnho?=
 =?utf-8?B?YUZtNTFCcFNBSnhHV0x0Wlo5bDBJMnFqWmpCK0FES1JrcFY3d2FGL1JrdlRV?=
 =?utf-8?B?NTNxb0JUTVZOby9rc2dsWWRjRDVveTNqMkxJQVZHYnJFRURGbkpwMFYvMDJo?=
 =?utf-8?B?Z0ZGVUxpMnpsK3BHKytZUlBzNVJ4em02cWxrVlp2SUNLUTVYeWRhNUdSMmxP?=
 =?utf-8?B?QWhGQUM0NmVFbVFTekVhYndxdmQxb3pjNWZYWktSNVYzczIxa1Zza0ttU0J4?=
 =?utf-8?B?UXVYUVpwRW5qMDFnSHNRMzVzZCs2WktRbHRTamRTdWVsSVBYZXhzR2s3QlBz?=
 =?utf-8?B?VlFkWDE0dWw5WnVrNFdvV05aWjRxa2ZtcW9aK25tQkxXTGlMek9CbDNLc2E3?=
 =?utf-8?B?a3RuUXhjRTU4aFpDL1RuL3F3ZFVMTkwwcXA3aFFmd0h1QWpyblhWb001dXA5?=
 =?utf-8?B?SmhpTVBXY0dORE9ISWU1R2VCTmlCK1VQRkdQS0FRM2FhRUNVOTJUbm5oanBQ?=
 =?utf-8?B?R3lMc3BLdUxiWXBrRnphY1M5N0VDQTBNeElxSTVWMkM2OXo5VGFSR3ZkUEVI?=
 =?utf-8?B?UVpvcWpEUVRUbHFhRUtXQ2NzM0RxN1pybUQvbmRSOE1ybjdydExqQ0Q0QjVn?=
 =?utf-8?B?M2JXeVh0SmRJRDFmMzhNN1Q4M3REbFRUYTFONjg4MXJVWkVKVTFWZWFDZEdi?=
 =?utf-8?B?Q3ZzYmh4aWhIUmVodU1sRGdPRFNadDM1Q0ZGanhBR0Q3NW9UVEE4UTRiSWRO?=
 =?utf-8?B?MDFvUCt1WDJHdlFhbHNKWlprUlBuWVNOTFdsTWdLb0VTa3BjbFNCNlFGZDNY?=
 =?utf-8?B?RnhZSE5UeDgyR3F0NlBhY05FZlBRWW5MMHdkVmw2MXJkQ0QzNkQyVWdKeDlE?=
 =?utf-8?B?ZGRzK3NPQnA4b2UyOHBTRzYrZTVOMFErSFFRNE1EM24zTC9HUnJ4Z1MvM2Yz?=
 =?utf-8?B?UVk0eS9TbmY5TnVBd3lWSzQrWXI5clQvNEp6bkROajNTb2JRVjNqNUR1dTY3?=
 =?utf-8?B?OFJvbHdydWdMWE9iZGtiZDNFYTBmdCt2Z3JEK1YrY3NMRDFLMVJ5OWJsYjY2?=
 =?utf-8?B?Vmk1c01nbE1iTllkekwyaEpJQ3dWOTJ6WW1DS2xlS29pb3FoTzFMTjZNZDYz?=
 =?utf-8?B?blRxaFdVRVBhMmI4QlF6Z1pkMnNrc09aZnFNRVBvM1NOcWhQekhaUTFqVkdt?=
 =?utf-8?B?eHdQZEZEOVhhNFhTWDNaS0RIVlVpSHQzeXc4eEEyUmxSM3NoUzNmczZyYkhU?=
 =?utf-8?B?NUZGeG4zdDMrMFRnektGOGFyS2pIZm1Bd21UYWd4Tjk1QjhyVUhKZHk5QmFX?=
 =?utf-8?B?TkpyNWpiU0V0bUdlWkpaaUtmOFh5YzFvR3F1REgwSlZyQ3lybW9ndFhMd2pB?=
 =?utf-8?B?azYzNDhPaHdQTWppQjRyZ1FWWWFTS1hkdmZGUloySTlPc2gySFZEQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ef699c-e95c-4fea-6321-08de5f1cc5f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:57:11.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqIt55mMVodB5Ni7tXLkXoKWFUUvtvShxjYC/Q3WChtAIAZJwgqQ0juDaXOSub2w/hjaPcQbx9tv+X0taSJ/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6527

On 29.01.26 09:36, Richard Weinberger wrote:
> On Donnerstag, 29. Jänner 2026 08:45 'Jan Kiszka' via upstream wrote:
>> On 27.01.26 22:39, Richard Weinberger wrote:
>>> Ensure that the task structure remains valid until the join operation is complete.
>>> Previously, a race condition could cause the structure to be freed before
>>> xnthread_join() accessed it, leading to a use-after-free scenario.
>>
>> Where exactly? xnthread_join performs some checks for the existence of
>> the target, and it is locking it (find_get_pid).
> 
> xnthread_host_pid() in xnthread_join() dereferences the task struct via
> task_pid_nr().

Then then next question would be what is protecting the task struct in
case of userspace task. Is this here only papering over a more
fundamental issue?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
