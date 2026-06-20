Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE22641C6
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781959237; cv=fail; b=tK+4K7Yk98iiEcNR1PkLCg8d4JAxVNm9EKzXkQuVRyDe8ancUPSGrZaTwmXd3XasO/ER3kaxATf6T3wvsYm54A4JoAyXYAMCoBPf1Na0/Lzc5w8/eKEKw2ch+n2Gm3fjgAvBko2Or7iG0ttHpZw7fD9CcC/AxmNirO/SmcaeVrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781959237; c=relaxed/simple;
	bh=tp+iBUyNbK1Bxw7CbmkJ3ryJ5BbOz61M0bP8bx2xJok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tvARnquyFDNzaioQzQC9E6W+SVWIa/EUeHsYZPluNhfdNPrb+Ip+X4S19bpNIW1Z0dvTtZF1GnqtznNZFRpd5xerZwzobokMz6k+mUE4WT7vMvjl1mA+X9Q3FB7+eMmXe37m1le3TyRYpkGkb0sDeW6RVS6c0WHXy8IBnEvTzSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yzfY0T5b; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yzfY0T5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehWidyxPN82b0hlcPhzLNk9WSJU/8a81/Iy3L64xXd/Y5ECQhS8Akp34HTjUSxMUlvrfzis71L1iKq2jvc4+KSpvHLPQFWvJ6cuIlV++Fcd9jK+ZzYUOc2/DDAYUbLVvSv3BYiiCGtLTThDPGf8lp911va7mydX/LzFZMM/tc0C0JQcvn+vCnCTcIa6ok29QdHudrAEtWNQqENlxZjQe8Tx7zkZt4AknH48Vpp7OZ0ZhqmHwdXvl2tOen4L2ezJbhJzqgThPE2CP5h5wxnus6SanLEB7sXSFNhUs366G3JWIu6KMGQRAa0sPWmpFAIvImbSYyBpiQv0UXeXnXLVR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ulOsE4XJmL5UrKWyt056fkuGRYnM1w7dinzuz13oK8=;
 b=zKkXBlYJKH66T8OfnjZ6GPRClrhWpcYfNGYpdlFf24/lm5sXFRY7Xplb0eN7UlvF6DlmNv5rCgY/QjDB+ukCNVBgq/c8Sgp032cZt6I/QHvn7vsj/49u9mO3n1TNmHB/tuSSgsgWzk3PK9m2YY9kmUWd5FuIv+znrGGCnda/4+77upKyO7CgNrnH/w9fcHhoifg/JxZB25qX6oB+/wxcQIxAUqVP/UNMboSqQbtKXD5VBkUeihdt5XfhA069aYBqSuXGo/UK8GQo99l6cpfdvZ/zIGZ6J/sFXMWmjcrhq0LzKB26Ananaj50vva+Qme91TsZ9hiHsiqtxcT8Nz4E7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ulOsE4XJmL5UrKWyt056fkuGRYnM1w7dinzuz13oK8=;
 b=yzfY0T5bIgYKOIUvXOcVzppv68JDS2B4iIMasieH1OkH1HVOatLEzdQ1B8keospv4HQ3qOYJ7mPS6VP1evtpsztcAALtZvYanYRuIr5TS89qb0+xkuluTNZ9EeKQE3d8fdRZbN3H7WhGTSC4cZ+eIgpV3PDFeB82xukr8zSaYSwoRzPL0mw5xfo/os4flxYV/haFeEqrPNbJ+dnzP+BWZTdMOn8FGgU55BT1pyMgEl1Ys8p8iOIuKzR5kHScoB1+o9nZaPAFcXWoVBHVS0nYp7ZtVWNEfJ99xZRa6OstmracTadN5nM7CazCCv1VYZXxaHzHyljmcOsq3HigWy4zew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 12:40:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 12:40:31 +0000
Message-ID: <ef230925-f258-4cf5-9fc1-6426167fc819@siemens.com>
Date: Sat, 20 Jun 2026 14:40:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting
 FIFO thread
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
 <38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
 <87cxxlbik5.fsf@xenomai.org> <87jyrta2c2.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87jyrta2c2.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d0d88e-f05b-4e1a-bfc2-08decec91d38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	hO9zEvjeuRpLU2QWXJaqst+fnoRp+D0CV1Y00gQ1pkuH+Q90NwTW3TQnYpDAN7o5lIS7GUHMi2HVyZmrXFvTHO26/QRA+p8pgX/rrz/7bC4Uzmyl4PkfyEkC6sCRwUaSL5DUdZWroOjqRPk67btQpUoicuizQDj4zTCyoQnbyJuGI5UBrJuqq+X/er294GTkgZHDogE07K3SKRQYzEsQdbwrdn4aaQZFdRBHRGiRwFk2ty7zDJ3WFKKSYMEmgn/+kJJ/ERYCxjulzeFNwPe2Z40hPlKypUC62pnPNbVZwPl0hxtXs3iuucSsKE97qwK/rOp6OCwb6U8cE7em8uaQ709Xe6+hDaXAjHjy1DCaXgCi8nInS4k2xamswENeIJEE9s7/MEOCEI3gfyfvxKmm4fwSVyPlNKRpowxhSNhepoijn7/UJaw9Mk1+MwM1HZHISM+Z1YZDQA7n3QVaF0LXIWldoMxw6VFrpbfjiP+kT6EgmD2ogZ4HNb3IYMT8yxAH3um1T/a/SLWRNnkc2/j8xPIAXThvn4QLfWI5jZXEha80v1nmCRwsw/O/x/u5/sZc6qeXajRnG1dU3JDNWO5d2QgeW0leV14zH3OfLg5s0+W08fWEWWy256JhNtlJC8yMvbOu9wulg2Hyyrr33se40x6KJJvkHlJ1oRgELbOX2ao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1A2ZzBNQ1lMcnprWkhRWENGQnBWaFE3cDFOR0ZvSWt5bk9QR2NoVzNzaGRS?=
 =?utf-8?B?ZVdsZHRMZmUwUExQY05rOHpWdlJubm1xNkJKSm92T0VxeTFFQTlVdEZFNFJs?=
 =?utf-8?B?akpraCtUNGs3NUV0d3I1Z3JXbUVRMlIxQmw4emlkai9xRkx4UVR1L3AwZXd3?=
 =?utf-8?B?UUhHQ2FIckN1dFh3VnBrVWpmRjZtc2IwUE1DeERnbU1GSlJSTFJrVlVidDJN?=
 =?utf-8?B?eG43dlBtbFlqckJtVnEwMmJ1SG5NRjVMZngrT1dWaE01ektnKzZyeU9CVnZx?=
 =?utf-8?B?WmdlUDhybHg2dFdoS1lPV2hsMDVEOHdjUEN4Tk5lTm1xbmRUSHhmbnFBakdW?=
 =?utf-8?B?Q0xDLzU2cWYyclY2RUw1VlpxOVcyTzhzR241OTBaVlNsN3I0LzZEdFFTQnZS?=
 =?utf-8?B?ZytsZlg1UVhwQnBEWElHRmdweXFONzBVSkhBYVBGcVRvRnJrNVVXdFdFTFZ3?=
 =?utf-8?B?RWFpcmlUOTJ3NGY1WnAvb0FGWXRFWlRrTTc5ckVTUzkyNE1jYjB3VytKZlBw?=
 =?utf-8?B?ZzJKbys1OTI3NTlQeVVXaDlVK3NQN1hQak03c0o3alJCb1QvTkRvNnVnQ3Vk?=
 =?utf-8?B?NkVBSkZLaUtYZG5oeGhoVGw4dFVJNHA2eTR3MHhqT2ZFVHkvZlVVbFdFcHE3?=
 =?utf-8?B?Z2pKdEhGMXFCODFqdWtlUjEzb2RLUC91andHQXlkcUJTeU5xTUxSY3FBUkZs?=
 =?utf-8?B?NHhqOFZtSzU1c2NNVGZBaFlENHNXTnhFZ1R4WTNQRFU1NnNvTExFUFpoMzZ3?=
 =?utf-8?B?c2VYUi84TGU0MW5iR2hsZTRDR1BRUGZRNitJOEhtYlB0U21oOUw1Tmx4dTNK?=
 =?utf-8?B?bVhiM2Q3czIwRDZoV3ZCS0Z2OHJIamFNS3NSSVpPR3hObDkwUUNmZ3pnSW1E?=
 =?utf-8?B?ZlNiVzUwTlg4NnpGc08weUlzRHl2NHR4eUQvejdKdW1vUHN1KzBGYXdRZjNT?=
 =?utf-8?B?NEpnMCtEZzFFTElrU20xUHprQ2R3WjV5aTJnTHJwalgrK3ZULzBzbURFcXNy?=
 =?utf-8?B?SFdycFd0OXByeXRoSm9uY0lpZ2hjT3JtVlk5WUR4YzdxMXhVcFRGK0dMUUtM?=
 =?utf-8?B?cU5Jd0htWGU3RFVJc1RBQnd6M3BNNzF4ZjhyM0NxZ21xSlJBenE4cGFJZFBn?=
 =?utf-8?B?WEVWWTZnNmpEWkhlb1piSVNmdlBuVG5zWVNXOThjeWs0ZWRPZndkN2RWL1Ey?=
 =?utf-8?B?MlNtZkhXRVYyQThqWGhneG5nTDdXQnZMYjdEQUdjRlFGMVR6NXhGaFlMYmZk?=
 =?utf-8?B?OUVHNGs1dXovUDR5M1JQRDJqdmxwNU9DNVhMR3B5aUJIZlpmdlVLQ2J0Z3RQ?=
 =?utf-8?B?MlUvR1pnNXNaZVY1dVZLQVhxRk8xcW5EQWNGbDh4RnJTVElsdGU0VzYwWlZU?=
 =?utf-8?B?alpzOUtTTkx5ejBZeVcya3ZSVndST1lud2J3MlFRN2wxVUl6TUYyOStlTnRM?=
 =?utf-8?B?cjNYWENHRlpjZTFXOHAzK01halhQWXlLVkdzaXJDakI2Wkx2SU1IaTdHU0sy?=
 =?utf-8?B?Q3JzOGNjTFBCQUg1WlV2c1NocHBpRVNVVm5NcUZOZlFFWklWSUoyTml2YkNv?=
 =?utf-8?B?WklvZEJsMGVxWVB6cmxSMjdoZ3VJN3BEVXRaWGFVS1Rnb0kydE9hVWJjWGFK?=
 =?utf-8?B?cDFXZSt0S0dEbi9aeEdjVXhzR3JUZ2gzN0tOTXVwTU9HbkJsN0tCVlNlb1FH?=
 =?utf-8?B?a09BWXgzT3ZvWHBmVHYyWmZrVVN4bGdBTm5uV3VnQUhnVS9Dc2NFc21ubG5v?=
 =?utf-8?B?V1RkR0tRZVVJYWx5M2UwNDk2WDM2NTVvRVl5SndSREl1Qlh6d1lZMXM0REd1?=
 =?utf-8?B?TzM2WVJpL3NPbWFZbUZIdWI1UkFNQk52TnMyTDZmMzdyb3cxNTNRcWdpMFFx?=
 =?utf-8?B?bmt5R2x4eTB0TlB0QXJ0cnNQWW5VaFc3Znh6dHBDWHdleityeHl5b0RGRkhR?=
 =?utf-8?B?aGRHZGZpZndubGVseGVyWHdKRko3WitoMm4zRU1TT2xCc0F3ellORkgrcXlq?=
 =?utf-8?B?V29UVW5YazdnNDY0UnNPaDZmM3B6UnZZaEtFSWR6Z2x0RGxmT1c5QXNJbW5m?=
 =?utf-8?B?K2VHeEFBOG1ESnpFRUMwTENOc2k2MWVRcHZnRExaOUhqVTFKVlgvSitFS25n?=
 =?utf-8?B?a2w2endUZDhMMkN1RDJXRDVKN1FjK1QyOTdiSnJzSjRwTU5MbmhsZkZBczFZ?=
 =?utf-8?B?NmY5d3dSOHh1eDNGdi83aW5OUzZUSE5DUUhqZFJEV3RnMHNUeHBMeE9jaW52?=
 =?utf-8?B?dFkyam5XMmlKeDNTaTM3YTZkSVUrWUlhQlUvMEJxZE1rWjFUU1k5dkdhNHE0?=
 =?utf-8?B?ak02ejNDZ1Fibzc4WjM3M1F6WjRJVllTV3crV0xFMGZhV0lFUkpOUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d0d88e-f05b-4e1a-bfc2-08decec91d38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 12:40:30.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaRtjZkIGLXQ4jp+Kwe3KgCZrLmr/45dTbe6Y0XYsFdFd+CuvSY1FCmo6FdtB8tTMrffK9juNHfwFUyltHwyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5793

On 20.06.26 13:17, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Test that higher-prio SCHED_FIFO threads do not run on the bill of
>>> SCHED_QUOTA threads and that their accounting is not otherwise
>>> disturbed.
>>>
>>
>> This patch introduced a regression when determining the accuracy of the
>> policy with respect to allotting threads the expected runtime budget:
>>
>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>> sched-quota-accuracy: 494.0%
>>
>> The proper result would rather be close to the following:
>>
>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>> sched-quota-accuracy: 99.1%
> 
> Ok, I guess the fact that the calibration process does not factor in the
> disruptor explains the full breakage we have with the accounting now:
> 
> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
> picked CPU1 for execution
> CPU1: calibrating: 893547 loops/sec
> CPU1: new thread group #0, quota sum is 10%
> CPU1: done quota_thread[0], count=150399
> CPU1: done quota_thread[1], count=145636
> CPU1: done quota_thread[2], count=141552
> CPU1: 3 threads: cap=10%, effective=49.0%, disruption=49.6%
> sched-quota-accuracy: 489.7%
> 
> Which does not make any sense since the effective value should be capped
> at 10% in the above case, compared to the nominal (full) report which
> should be:
> 
> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
> picked CPU1 for execution
> CPU1: calibrating: 899203 loops/sec
> CPU1: new thread group #0, quota sum is 10%
> CPU1: done quota_thread[0], count=26818
> CPU1: done quota_thread[1], count=26709
> CPU1: done quota_thread[2], count=35612
> CPU1: 3 threads: cap=10%, effective=9.9%
> sched-quota-accuracy: 99.1%
> 
> Dropping this patch from the -next branch for now.
> 

I would rather recommend taking a trace and debugging the scheduler -
this could very likely be remaining issue in the quota fix.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
