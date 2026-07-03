Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BA3C583A
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080431; cv=fail; b=uYFOlyPQSBi6FevbHGfH5DT7tIlCuZ9fL69DehCEetZHTlTBb4HNPJlj+5HT1VgG0ayR1Tt20hrPHy9dhYpsd/evUQUeQJc/UIFkuO9qALufuOtnwAv51NVgFhKuGDIn+W/6F/Rj3tEU5ZUQOwXp9FqatDiWF+8sYKTBtL+7Src=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080431; c=relaxed/simple;
	bh=l/B6uImjYpOyyF2+LTFppbjS2pWUC8EnpYYhzZlsIF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TiefRRqu6YRAiTtI7LwVVVOACjfKv3xlU/DnlPg50+kTlts/7tR4hPVOEISnQFPmIwhqQXrcF1ixxeGzq232EYdX9rykmw20YpvU5FwgHlWrFixvfSQbXFffhmanipVRN/PY5PoYdkqeOjuJPEf0IVuVojcax2I+vrXDd3NLYbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zzV6gAkN; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zzV6gAkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI2nTi5KLlxXX0vhgH794qm9k0QnHXFqo0cO2/mC8vq3VEfcZJquAIQSc72cM94SlmDN0eJ30Y7URfac5tkR+ZPxt053aX6E8OM/fSxeitG/DqmNcaOEFNdOROrqzenRmt1qHPYAjZ4/6l9dweYSxmo+CEtbhjAzr6ONbCozV+gSbdgycj8rB3Fb57j10nXYEpPihMmOIfPxEQRoi5PjMxsdWMu+UJe+3+Pvcwyr7rzIDbLtcPP4bEaxjfGoaliJ/Q+LzCqSlF7NJBUraFnYE5TqNk1tZFjYOujrHxCbdBd4UF9ZQbFPnLiot4G0kg/s2yDyZ8ho6TcCHQyiYoIXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsHcg50edqyUGw2d5spcF67tjTWnLTcJM9RefkRrZY8=;
 b=j+wfDRqYoqPnuJoXArr+JIKPyX74T8xSCOMYGWfkgmaQAbZfUgKGnkJAqI/+TlA89SLDjwogoGaPuET1ZdQaENBKsBwYBCTP0WBzbRoSCfxBDfGqbmgwqDMMshwjtVY0QsyOpYa6q5XyKuEWaYT77YUQiUxtlfj00zEUWFSYmbwbGfQzGAdaE0k9smqKb4N4tCWPFTfJkNHWk9ZJ3MWDwsOLC5ErjCjxJQVvWl7CNJygW31b/+T0RbQJWyqfXI4unirn2sS8Nsyhy88gH0F+G2R9vpRGCqEr74cjumxsmPqk+lCid0oNjCHbL7pYmviUbVk+e8U1jQfQZGYauwSYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsHcg50edqyUGw2d5spcF67tjTWnLTcJM9RefkRrZY8=;
 b=zzV6gAkN4d5ZHbGFO+vAKk8vYmeGqfQoeJs7lX8x/GWnIW1Su/MrFv6PNZdba0FmVq7jFViujFWxkJ3Tr5ZWI2G5BauBvKMOG4NXZesBTu+9GVL+DnP5xMYHgBgut653ZLNfBgeri5DFL/5OhBXuyBYdGhIH44Mo/ZTiQ8bv2M9+mHqMk9y/auSvLRyJqjNbEWPpfw1UtoGkOfiBqISYbUn46ut7yYecgfP7oKVopAU4rUG1/IB7PLXF4fJAKSbue4WVHbY0ozgtOJmlLnIKofWDLHk6q9thuSr5cwrLYkyA9MJD22WCpM9epI71jhjQIZ5Cyhf8RsqxhZg2VYO0cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 12:07:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:07:05 +0000
Message-ID: <88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
Date: Fri, 3 Jul 2026 14:07:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have been
 relaxed
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
 <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d4c25c-def5-4d6f-8db1-08ded8fb98fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	0RXarYdQoCbpAcCk4tL6In8egQuRorwJEQaRz+lU3VkumSxj6edk7O93BUBarLG8CkDERCf1akM8tDV7POnbFeAX75JGzqa+Tu5CYhE/RUUsyzQrSbsUhB/lzAo9DWAjx4hlnetiJYpk/2SqF5DHc0BEK90kS6UzsQEd3piSjcmNP5WS1yIDXBFk/LWXyIrVW2q8X+QAi8ZZ873TVS8lSHbE6LLu74PCsNYMRchgEIlHM/xrd67OpiPs/94/jybtujr1tkhXeHT0bfKmBKahtyC2SVdnsWn+5U15vZnfO1gJxyeixlDDZ4c/0wtl/+591xEYj/Gia/jd0cAOfEZMurfdrnJYbvGyZD61RPniZNJXqZYzdUlzDlGWe/6zZE/Su8lKKxwaWyaJ2pLreov/N25TH2qY0I381Gel/ai/2PZqDu0eL8fRiwi3bCaIkdFIEjtrj+eZ2wFaFpJuBUPQaqOaX15pKebd/47Zm36N8vF97/sYyOotnILgiTbofOkSKFan6fqwuo8Iv93ZQ151esM9ntB0CXcgjFk9nqryh6m/EDdpLJ5jOi+mBtnuDXHbWqBImj65HDBbTEY+x4yBIeCtJT5af7T+f+IcYTm3PqaETIlAsnCJAXDw/BM9eJ3alfqPfZA01Ck7/BRVgQqZlValvY6EYR1xLXpa8UJsRsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlN6elUyNEt2QWdraElXZ04vZEJZOXd1RGRZcTFRRHdCUVhNUmQ3K2ZZcEZP?=
 =?utf-8?B?L1NjRXNNWnd5WUZSQ2YxQ2Q4OGFrNkROZVptQkJ5M1lEd2VPbHVuVFFUd3pu?=
 =?utf-8?B?Zi9pYk1IMy91dzNFdit6L09aZDcwZDZ6RnoxUHFGUDFoVU1UYmhiTnk5ckEv?=
 =?utf-8?B?bmxneFJXeVlUdmp6cm9YS3I1V3U0RGZBYlRUQ1hQNTdPQUFzN1B3TmYwOVVN?=
 =?utf-8?B?OVQ1dzVXK3hHb3hKTjVYSG1zZkZKNElEK2xJRzg5WWtCNE5LUExVNmpKdFlu?=
 =?utf-8?B?SFpBTU52Um0xMHcwMnUvZ2pXc0VGUm1nYlFIVEdMUWJ4M3ZOMWtJS0JQM0xQ?=
 =?utf-8?B?dldJYmlDdEdUOVhJRzBnRU50RUVQV085cDJyY2FVRUZwcFEwMVNVSTIvejM0?=
 =?utf-8?B?UHlxRG5icnVaeVd0dkNGSUx1MjkxVDN0cmJpVGJ6L2RqUGtQTEVkMHM2Vzcy?=
 =?utf-8?B?TERNcUFUY3BjV3VPUGdEaDNyUXZBVDFzY0NldnNZTElVUkh2QnR5UnlFOGdU?=
 =?utf-8?B?am1XR0N5VGM1c1VuKzVrM0NsYUg0dUpoVjdOK2ovUmJGakNwMHl5cnlzK0d1?=
 =?utf-8?B?RVdqcnVGZXVlQjhEamRVRE9GM1M1eHQyb05mOTQ4WFJBWEx6RVYvckNlVm5P?=
 =?utf-8?B?SElmemp1ZUd3bUdRSkNCVS9tMkpMYzliUG91RjZrWVBBMzhxcFhUdnIvMHF0?=
 =?utf-8?B?eHltV0hObjg0d2pOTnZ3OU02RGVQSUVzZStWLzdKYmxOZndITXFkOU5kWXdr?=
 =?utf-8?B?aWVqM1Y4QnRxdFBQRU54djdBQjU5WUpnSDB2bHNhSk9lZmJGTUc0U0lLVlMz?=
 =?utf-8?B?a1JMVEpLVTdDTWZLZXN4R1pIaExCR1VsUXpjSUg1WG4zejFXdjRkcUd1TnUv?=
 =?utf-8?B?ekMzbWRsS3hNeVYvcXZUZktTYndvSEl2dlVvNFl1cVI1NWV2dUlUbDgxUms5?=
 =?utf-8?B?WDhaR0lOY2MwTWJoWmx4QkZKTkVTSGcrUzRqaDQvVU91bTZqZktnellLNnk5?=
 =?utf-8?B?dVkyWEJXQ0J4dnJadnVPM3lxVlhWaC9IUlI3dnpEOHNYWmFkTkdscW1kQkZO?=
 =?utf-8?B?djM1ck9PM2xqb05qaDNMdVRDK2pFNnh5WkFTZ2FMdEMzZERrNHNicnJpUlhZ?=
 =?utf-8?B?alNxek5OSmMyWldpaXlTY1lyYlRyZGQyTldXbzIvZnpIQ1huK05tTTJ0enVX?=
 =?utf-8?B?WmZyY3BEY2h0VnVEaXZyNnVYcDI2UVB3Uzd6UGZodm13MmpDR2lpNUIwQW5u?=
 =?utf-8?B?UUJ2NkYwTmZCU3ZaSmVQRTFaRkh0RGlqZFZzek5Qb2ZxZVYrMVM3WU01U0pC?=
 =?utf-8?B?L1NQV0tOY3hkQ3NkWDBZNDlodVdIZkJSMEh5RC9rYllDbnpSdDd0bFRkQy9k?=
 =?utf-8?B?aVgydVZwNml1TEE0UUVuMkVpSmRydlFlNHg5VTF5bVA0NGVudXFzMXllcFVQ?=
 =?utf-8?B?WTMwUE5OeFJnR3FlRjk1dDlvQ2ZzVUxyaFlHbC8raEE1NmdoUU9EUjRFVmZl?=
 =?utf-8?B?YjZQczJzeHQxZXN4a2tLdjJqY1J4dXRhREVLc25ZTDBzdEp6U3J1ZHFhUFo0?=
 =?utf-8?B?NE5BVzlpMFJBVno3Smhwd3UzTTUvb3NISDhNREkvSnl3eU9JdlhRc0VHanU4?=
 =?utf-8?B?MThCc2djeStFNDdjTFFkTjNtY0NjWGR1aGJUQithS2tMemxYYVVzL2gwVGl0?=
 =?utf-8?B?bXg4TTdPTmFYZGxlVzBEM2JaNUE0VmpRc3lnNVJwR3UyVGJLakxxRHhqYjFF?=
 =?utf-8?B?QkZlL3FBVHYxaStqM042QUJPVmpiSG1DbVAvOHM3RXdsbHpERUdqYllGcmhO?=
 =?utf-8?B?cTFSQnNDWE5nbGFtdXZ0RDV4WmNRZkZCdk5GUGVCYzl0Umw4QnZCVTRnajJF?=
 =?utf-8?B?d2RwNUhRQnI0NjQ4djBIa2FyQ0pGTnlRa2ZIOEJ2VklOb0dsN0RRbk5FeUIx?=
 =?utf-8?B?MjNSVzN2ZlpSNjhOOFJoMVNldkZKN0VwN0g1RFpYNkYzYklEUkVxbHFqRlha?=
 =?utf-8?B?KzlFMnpkWGEyQ2hLTkRyMDVoL0c5bFduK0hxUE9pblkreUFNVkFHR3h2b1Rl?=
 =?utf-8?B?d3FGeGRJZ0plYmo3bVduU2ppeDVhYkpqTlhOaU9YbksrOUVRY1FtU25DbzBF?=
 =?utf-8?B?Wm1waDI4bWZMbTZWVjJNTExMUHZOaVg1Qzk0bnJwaE83TVZZa2dDSVcvZWY4?=
 =?utf-8?B?MWxsbUtZeHJsVjdiemRFVVJZdVFVZFg5bm5aT0tDTitOdDRMc0k3UEphYmVW?=
 =?utf-8?B?dEdMZWIxNmljb3VkbE5ibTdOdW5tRUttZ0IzbE8wa1NKZGJiYmxaT2pNZldO?=
 =?utf-8?B?RFJYVi9aSmRQTU9BVmRZNmdHdlNyRGhhSlJPcEJxeEtCSkt6Wklvdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d4c25c-def5-4d6f-8db1-08ded8fb98fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:07:04.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87uH+Sg597S2+7jZ1zlSotEdPhpBt4aFfLw+0S5hGr99sr+GyWZIr1feq5kPvIOsTt0XVTFJRzn6ch48fWVOaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6116

On 03.07.26 13:54, Tobias Schaffner wrote:
> Hi all,
> 
> in some of my test runs the sched-tp-overrun test was failing with:
> 2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED:
> evl_read_observable(tfd, &nf, 1) (=Resource temporarily unavailable)
> 2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN
> 
> I only see this on virtual targets.
> e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/jobs/393605372
> Mostly on arm but also saw this on qemu-amd64 in one of my recent runs.
> 

Maybe improper/missing synchronization during test startup? Or when is
this hit?

Jan

> Best,
> Tobias
> 
> On 7/3/26 13:48, Tobias Schaffner wrote:
>> Remove the broad skip list previously used for tests that fail on QEMU
>> targets. The list is not needed anymore as the evl test suite autodetects
>> if it is running in a VM and relaxes the tests as needed.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   ci/lib/gitlab-ci-base.yml | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
>> index dfb33ad..0540628 100644
>> --- a/ci/lib/gitlab-ci-base.yml
>> +++ b/ci/lib/gitlab-ci-base.yml
>> @@ -123,7 +123,6 @@ default:
>>     variables:
>>       ADDITIONAL_XENO_TEST_ARGS: "--vm"
>>       ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>> -    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|
>> sched-tp-overrun|monitor-event-untrack"
>>     rules:
>>       - *test-qemu-rules
>>   @@ -174,7 +173,7 @@ default:
>>     extends: .test-qemu
>>     variables:
>>       TARGET: qemu-riscv64
>> -    EVL_TESTS_SKIP_PATTERN: "ptrace-sync|sched-quota-accuracy|sched-
>> tp-accuracy|sched-tp-overrun|monitor-event-untrack"
>> +    EVL_TESTS_SKIP_PATTERN: "ptrace-sync"
>>     rules:
>>       - if: '$XENOMAI_VERSION != "4-next"'
>>         when: never
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
