Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2243DC87B
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583554; cv=fail; b=K2s9PpxCnn3NhlSrVmc5DKwdyCdJyIu3n1goWZOXQoeAebciPjtg52kwPc65kl0WxoNhmk6eeaMSRSIUq3w1JAQt86B9BBZ9F2dr9CkQzLhipbEfFYbB4wMU7hkCetSZZGRlfBTMjXTdAqGCtKazZDZHGRCZvoA1pe+2fn4bORw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583554; c=relaxed/simple;
	bh=AMt2OTv9X5pMiDhyWmcciiRpLBWsKmZtqkmPQvWSXKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qu6Ss5APsprBol1Z4JqPVC1ES2Mku7yzXZpA2Op8awhimyG+lcFdKaYrXODIlnFv+nSCrA1HGMp+AevC/TfefhdMuN7hjJBJK8HEHDTGJYfHqryXi2kZTL8Ice36rpeWXI32XQ/VjMsVTX9CecaMFPGmNl28mKPfcV4qRg8aCi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=l/39yHwx; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="l/39yHwx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqVDpbQchV0fYotRNH/uvzxhEmzfSQmm8BH/uaaVp+DdZBIgkGQLENlstmK+lWojDwQDTXLG2JWJ6nKQ8DVr3xXqjV8lJ4pqPbjQdfwgxlduaH6gMSo0T2soi0aXmnVGJVzOtLAvIL6K2d9quS4nWMzyDQr03pYxUfpBKUfTArz7x5fvRernwZHAeVfWhcjkklhJudXM6bxcstO5/A4WEIE5lQkCL3h7h6k7x8cSWmquQh26i1tSP4H/9Chcp5LGR1DYkBaEckU8pfgYYcoCibGJCkGFrsD1+tbBI7t0okHnqgpGWuAd/0L/0J+NTQ+FcuShDfFJkQjZPN4xIFiAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUoHWSj6DAMSsS37DJKWcj0X5+V07tWpf0RZ9Q+bLEQ=;
 b=M+V41I6b9BQO0ZJNlnfEIxuNY2vhVo9k4UjON2UtxqH1lmyep4A1g0e9jbEL+WqwHy0Y3yak/JuzgBRVIbT/hL3GumAnB8017CuD8XVPWTURUmNTBKPiBV2ZvBgAacdDRhhoOIWHij2TzHE3cDcBHgnAhmeF8aR9leujyAOY+NGgIF3mirg17dQQlmahIWsnogVctvsPR0WOpP/4IpyjlHCoAB9WJbc+Ci9JQ+q5h4VW50sDuX1tvE1xzPuDCW+kRgRK+oUOYJMnLg+OjDZ32liTWsYm62bPQeXigVWkMDd4sxq3LKIap6ln/M9a0Y/T1L/huTXGrFV4jLB1hcbBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUoHWSj6DAMSsS37DJKWcj0X5+V07tWpf0RZ9Q+bLEQ=;
 b=l/39yHwxxRLK0fdg4jQmzuLZEqjGVQQCvB3xd/68n7d2SOSgjMNrdD3VkWbsXWf3vigb7/CeVoRtNJXa3gRbBO+PyFekEWIm8+Q1XCoujcTmyMq0uxSRN0V9ez6OJGHh2RFdyAiQE2/YX3dJvso9g+eHERtU0zKTnpgQ7C9ntuZiZxxxUCA0OS2VMB6GYl67peH8x5k2rVjYwiJLvLoJJ5a337Txg4TZHCfWf/gwjmr4ayg8JrDvT/EoB+me1ZvtNfeUMjJKKFHyXZZgi8cmiPJj43eO708iQnDf6PM7/MBKZJnU8l+ANIz+BRI73wCVIt4w9TuhlyzuoW7wSxYHnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB6030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:539::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 07:52:29 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 07:52:29 +0000
Message-ID: <11a89f68-50d0-432c-8774-c5cc6658b383@siemens.com>
Date: Thu, 9 Jul 2026 09:52:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] linux-xenomai: use the wip/evl-riscv
 branch for riscv
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260708194021.1236842-1-tobias.schaffner@siemens.com>
 <8c6ada2a-b6d8-4665-b3ef-61774e919df9@siemens.com>
 <95f135cd-c4d4-4376-a72b-e301abf4dc8e@siemens.com>
 <b6b72107-bfc7-415b-905e-d0541861d557@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <b6b72107-bfc7-415b-905e-d0541861d557@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dd0bde-478a-4e50-e536-08dedd8f05ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|18002099003|4143699003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LVb2IgPprCguvmQ8NDNDIZoazbm56sMHSSoraM5k7Cr2UpfoT/lct2YWxGIUp3Zh+mU2hseZ9YTOiPjvDSSJH97mw7itemEIatbFSuU5WNZa6BBfw81y5heN0Cf20QTIHb0xq624HzaojQBQVi7s/d/q4vXqdQkPhj/KlGBAOi3Qoq77gHGJFexoDu0BLo1h6I02xEf3c8vLVoe9SVkrklAZ61vjhC/cmmFQVy+7jd+pxC//SYDxjCJccQxwtB5GJbHcKFQsQD+1U6mQYo0P8mxXeHb5qJtsIM3O1Q6CFM4fZSg3m6rGEvkOWUZ5YirUIrc3aONMbnIcf7VIXvtXN5tjVPcEpPFc9rfY630tU4o/E7fYvuvMdDb0Wx+DXnIj7V+qnWJuYTEtTUHpniHOSYuQ1uFLH7xDtYsOSv2rFsCY4sqBZ+YxRnXVXrrEh+hzvcqPz/vr0rKAH+dnmqrLxAzMBvDWOFG1zDnNhbWhjPKIeMNkSgxqJ8KQAur9Ev4Rm+32jv8xldus8T+oHZc8ZWTSzr3TnYYtwWAj1N/GaMytVObOfP7pb+X5w6rRyF8+Ej7tEcxjgkHqqudGnYSzVR0dKjaNXhuYS8bBxmV0KgtGN3O6kjM7FnNjLlIfyS2isiSLPr9IWol2X1a6dzfzpBYcb9/xOL3TChWqXOB6DTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(18002099003)(4143699003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXEzZFIyMlcxTHFDYUo4MjRUNFg4REdLK2JRTzdjcklQQjhVVUZQNnN0VXh4?=
 =?utf-8?B?UWQvaFdRME9Gbk9KbUNGRWl6ZXdaYVNTN2U3TEdWT3NqakRJbzRLejUyOXBO?=
 =?utf-8?B?WWZISXcyL3A3K3hlUXJLM1dOZTlwTTkxV0krSnROVjQyT0RXL0NvUng0R01O?=
 =?utf-8?B?OEgyZjNGdG8xS2c3MWN5L1haQmhpejdFMFovTHkxNkNiSFpoNVpTcU56ZWIv?=
 =?utf-8?B?TGpCU2dBUlZhYmRCZlVzQWR0alFtdHBtazYwWmRnNUFEOWFSbWM5OHl1YzE3?=
 =?utf-8?B?OHlOenhVZXM1Y01LOVVWdThZMm8rYmxERkUxVmZKTkNJbVFZUXRKSkl5UHNn?=
 =?utf-8?B?dGRnUEFmcVJQVnFpVUhQaldtU01FN2tBb0g4dllmTWtFWVlVMEhOdVpCUGhY?=
 =?utf-8?B?VFRLZTlac1M4S3doa0NKU1ZmbjZqd2ZZWnZPWEQ0ZnRVK1ZaOWdRcXdsU3Z6?=
 =?utf-8?B?QmRQYmU1ZUxlNUJBUjNUVjdPd1pkYUpSTXExK3hHZkVuLzVJY2I2ZlFLQ0Rz?=
 =?utf-8?B?a2ZXRHV4S1M3Q2ZpZ3ErSWFhL1pkOXhjNm16QURNUE9VTGVzdVlIVnJ1enZO?=
 =?utf-8?B?amhLMHNuUGM3RXY4SHRpM1JudnVrV09LaDdVbC9CdHNjRFpuSlRLT1FTOFRW?=
 =?utf-8?B?QktWRXZwRlkyWTNDSVp5eWtwWW1hUXVMTzJUWFJzOFlWYlN3OFZ2Q0NnOURF?=
 =?utf-8?B?Sjd1UHNTdWRCdjRwdWVoS1hRTTY3UXNnWW1Vd0xOV3NZZ3VTeWdYU2JuaUxu?=
 =?utf-8?B?VXcrZ2JyVzN3aWJLaDlTL2lqUHFmOGJZZWVKWWpLbDIvZDNrK1Vzc1o1T1RO?=
 =?utf-8?B?dEwyMnJ1bHl1bFRlcnFqQVhFUUtHU2JUYnlWV2tJL0lrVTFNVTdSUGxtN1la?=
 =?utf-8?B?YXU0NUhwT3hjRG9Rc3BmTDdlVmZWSDhwVTVad0tjR1pkQW1nQnJVa1ZCbGFC?=
 =?utf-8?B?ZVpmSGxDZG5FMU1rTk1aNkI3REZyaGJIcStNbU9IZEpucE50VnFPOHJyZzRK?=
 =?utf-8?B?MmdHTVB0OHBFbEdrU1QrZm4wM2t0YmhUREhJVnVpNVhjU0ZhYTFSV2RFT0p6?=
 =?utf-8?B?Y3ZUaGZON3YwN0pEeEdjWFRSVndWcjRqUkxGNWw3SzJwK2RuSStpUkVRanJo?=
 =?utf-8?B?eS9MWjdvMlNXbnVMTmw5QVl4OTF2T2haVUNYMEtpRmw5YjlNbGRzT003dFZr?=
 =?utf-8?B?WnJuTWN1MWVtWE5ndGNJV1F6YW5xR2UwNE5BRHZIVlBKa2RMNTlOVCtlS2Q1?=
 =?utf-8?B?eXBacXIwUmRNTWp3TWxUTlRMdTNFMTNVeUpJK3lGMHcxKzgwRGtNNjh0ei9w?=
 =?utf-8?B?V1hyVy95Ui9LR1RPK3gxVjJWYU5mc3lCQW1Pa0NlaDNQZ1lvc0o1dWhGQzdr?=
 =?utf-8?B?N2tOZXhCTnNvd1Z2YmRML1hNdkdpS3hOTzQrVmNzUzRVSW5Ec3MxOEZHQ3pi?=
 =?utf-8?B?ekR4dUJNdWgyWks2aGsreHRZMEs0bmhQU0NaRHV5VzJ1b2M0TWlkVUVWMjNv?=
 =?utf-8?B?VGJac3JWTDl3NUErQlB0YncvWUxVM1VYT0N1bnFsMTloTUpVTVF4eEZPRzJD?=
 =?utf-8?B?S3diNU5JazVGQ1N6c21RM2FZQVpFZ1VVeXk3ampsbEI1ZWNXQjVYV1RyNmVM?=
 =?utf-8?B?UTVyMmNnRW43NDlmcWtDWG9xKytvc3lVS1N5djBQSVBjanFNRnUxNWpKMis0?=
 =?utf-8?B?ejBIbG5VY25EcytYN3dQSW9yZm9wcjZoOFZPcHNjY1FTdUhLUnNHWVVjOWVB?=
 =?utf-8?B?U2krYU9Tc2YzYUR6cDVuQWdDVUNjZTBERWtvcldmSDNyOTNxL2FoMDJOZGtH?=
 =?utf-8?B?dUpUU0xBb0FmL1JjZC8vTjBkeUNpUUtyTE5KSmNhMnNmZzRoZE5GOGdOT0Uy?=
 =?utf-8?B?elkvaVMxKzZRcEkzNGVTdzlNOCtUYzdnR0JvNy9kODEvUk5oR3BrUWNJR05x?=
 =?utf-8?B?dlMvQkVlUUFtcEcxWFhkVjdReDc4NjRORDBJeVZJd211U01jYm5PSU5WV1VP?=
 =?utf-8?B?TVlNQndOUXZnMFpPM0RZQVNMNWRheWVZa3FXL3YyeXBrNHdORzF4RDdScFdV?=
 =?utf-8?B?VW96SFdpYW92eDl5RmM1TFkweDkwQVJ5UEdaMFlxbkRiOXFmVWJRTENaaHpn?=
 =?utf-8?B?YktVRDgvNXNNQzR2cVNmY0l0ZXNSN29NUXhJc2h0OVZJZ3IvMS9DWlpQUGR6?=
 =?utf-8?B?UmMwYmFPV211RU5KWk1nSmFkZ0IwN1hVUGpnMjJuQVFCd0VLQnVzTmNBZ0U3?=
 =?utf-8?B?ek9oNExGYkR4SUwrNmUyRjV3UlQrNHQyUGxBMWNtTDJJUm9Yb2l3K1NXQ01T?=
 =?utf-8?B?c0ZXWUZWYlIzbUFQUWlpTDBoWGZKQmtqNTMyYzgzN2lrcHpnWW1MZFRPMk1p?=
 =?utf-8?Q?/R/8zmvcUvhKyOiU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dd0bde-478a-4e50-e536-08dedd8f05ff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:52:28.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OQQfZGDxnTodqrJp3D0SYdfjKBw9KN7WAUISqYT04GJwrH5mOyzh946YejLu2SNAi78mnxw0yY8/HcPyDjbqG8qZqQUvdlL9/kBYgjgQW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6030



On 7/9/26 08:31, Jan Kiszka wrote:
> On 09.07.26 07:03, Tobias Schaffner wrote:
>> On 7/8/26 23:26, Jan Kiszka wrote:
>>> On 08.07.26 21:40, Tobias Schaffner wrote:
>>>> The wip/flo/v7.1-evl-rebase+riscv branch was a temporary branch
>>>> for integration of the riscv patches into 7.1.
>>>>
>>>> Switch back to wip/evl-riscv which should generally hold the
>>>> current riscv patch set ontop of the latest next.
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>    recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/
>>>> recipes-kernel/linux/linux-xenomai-4_latest.bb
>>>> index 48499ca..a542e80 100644
>>>> --- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
>>>> +++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
>>>> @@ -34,7 +34,7 @@ GIT_BRANCH = "${@ \
>>>>        'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
>>>>        else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
>>>>        else d.getVar('LATEST_KERNEL_BRANCH') }"
>>>> -GIT_BRANCH:riscv64 = "wip/flo/v7.1-evl-rebase+riscv"
>>>> +GIT_BRANCH:riscv64 = "wip/evl-riscv"
>>>>    
>>>
>>> This branch became stale, that's why I switched (535ce20bf0e8). You just
>>> updated it to 7.1, but its baseline is again outdated.
>>
>> Florian updates the Dovetail branches and after that these changes have
>> to be rebased into the evl branches and I again have to rebase or
>> cherry-pick my dovetail and evl patches on top of that.
>>
>> What is your expectation here? There are three different parts and at
>> least two people involved and I do not have something like a automatic
>> pipeline.
>>
>> I am still trying my best to keep the dovetail, evl and libevl branches
>> up to date.
>>
> 
> Also because of this split between to persons, I was switching to his
> branch, assuming that, when he updates the baseline, he will also rebase
> riscv.
> 
> But this issue should be resolved now within the next 2 or 3 weeks by
> finally having riscv as part of the latest evl-rebase branch.
> So I'm unsure if it is worth switching branches once more or rather wait
> until we can simply drop that line above.

Fine by me as long as I do not have to change any additional technical 
stuff until then and riscv makes it into v7.1.

Care that the riscv patches included in the 
wip/flo/v7.1-evl-rebase+riscv branch are already superseded by v11. As 
this revision only contains cosmetic changes this is fine.

We are choosing between the latest riscv patchset and the latest state 
of dovetail integration here as both developments happen in parallel.

Best,
Tobias

> Jan
> 

