Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EB23A8
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 14:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuRKg0LVM+ivVpgD8A1P4U2kQJBsK0kkl1vbMrN/yi83tG9jNMS1C41wBrqM8/PdLfTjB/NfeaFLHdvsNl44/zDcS4d03982ufal6ZtmPd4vK/fpu/ciwUUVZqhvvxbTTbE03qO9EqeC0KnEf6sykDIGZ42OLjaRMNCx6JDYHVTEeOwIYR3WE4JAiWcRUptX4a2TwVhXH0Rj2kDJg1RYyvtb7R21w9UMtCUwf/DbcwAaLPVLbEpwXFI6EMr80mRckaKZ2p1WCiJGyXJDInSrxThgXDIPdawOF6IQNeMQ/2kZB/uJMn2KpMo/NJHHiEsj3pDwMD02sTO+ivRhKtnZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdZIFlryqeWstBUt/LrcdwL/WEn418491eMiukyxaJw=;
 b=I10XJWZjdin9nRs++SkQDaV9XADioXlXis2cYA44bhllYB4Ysci8/LeCbDau93INaDPO9w/v4Tu1nVMpQiKoabL2u1smUVlhH1/cVEl/WFXNdwZG4p/KDR8urH8vMu5xmJaWEMB85P3pSV/FRMFUISXUPRCqpTccnNwQqfaxC2ha2697K4HFvEi6oKCqRoE6aDs9NEq4sKCsbKAPLskUssw2zkYBZNRbmM7b/hdJWLQCZz34yxT+ugDKUNKmslNWbvesjFD5gBYpr2I6A6ZPtbz9LbGKvUSDgl+xryrWGRGaMdidBhe/sAlbo4MElHG3ByRMTLVvtiO6vy0g7vtxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdZIFlryqeWstBUt/LrcdwL/WEn418491eMiukyxaJw=;
 b=qqAXwQ1sFtoSkt1vaFy/XHTx7PAuvKw6q5M5PHocKL3THtNTXTBY2XAlTHAUKH23+8jvGlMipbXhwrj03wEcoLTfX1uUtOnv4t/lTJ7wnKLdW7pKHS8q7zJZSfKv/k9r0E2Ch02k7DtAXzBaKrfVAC9V88S7UpDAWJ9lZOKzCC41Gct0DHVHAQkoyI/pziqG971qHiVV5pu4PlF+xAzjK7XiB90B1oWclX/PZUojqZ2w9fADoAmsJYV9UqZEdvYvyXwCyft9K8+zkcUDUk8thIrtOtTdlFBUY1fbmugLrRhJGYrQBhRpk5OQxugiXtva1mgPFtrhTYmJctE7X1DZaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 14:20:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 14:20:34 +0000
Message-ID: <b3eeb9f2-21a4-feab-a605-70f6fbe9285f@siemens.com>
Date: Mon, 16 Jan 2023 15:20:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: while loop in a multi-core cpu
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 Yunjie Gu <yunjie.gu1@gmail.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
 <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com>
 <MN2PR11MB42855B83E5F981669B6B0ED9F2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <94fdf3b0-bc07-7063-7cc6-f6987ad1ed10@siemens.com>
 <847c0a00-2e91-6391-d8e4-6677ca719baf@siemens.com>
 <MN2PR11MB4285E612761676D50EF5571DF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285E612761676D50EF5571DF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0439.namprd03.prod.outlook.com
 (2603:10b6:610:10e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c081e5-08b4-4558-9583-08daf7ccd4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LnCwSBpMU/b2kmWHGL5c6zBhgwDy9jbk1RJnwBkD4Zxg6HO61GtBoxBwoLJKCOaXhw25Yd4x2x2egIy+77oH4wVlAtqDpvFQZ/25k08+Is+1ChS+A0ubxgnZDQ0U9yb2m+gmdT60E1KvymVGpWgaBvu/5B+8cguVaaQrm8AlijBRSyzaElKtxEH+gmK3Rv03M+lPPABgbyd1RxMO/DtgvatkBkruYmwd3LuhQulGWRT/zW4mVFO/3CzaAB71hLggTaPmvdQWC2bnr4S70U8WdHu35FVl4g3Qsk+rDHIpyWL9LrEMbt6ehv4ewQJ9g/gnfSLRu7p+2wqmsJhTFz6nkQY4NJb3LlaQAhyzv1TsyNi7YiTiXJhDKBV/20LlUmXFpHml3OSd38JzefrAC5UbQpL7ZrHphMX9zxoqDAgafoqmDoLx88toqbW7OyVhIt9m/Pa/enCRSIuz1Vtn7NOxPTWrmbadBj2RFaKAGzaMHSpajwSnJl/oDofRQ7eaGfl39S7/6cPRLjJ81b5UARQ+RoGh7eJflnmpBYlcfxlFgDmKwI8/scHQoKJITK3f8bPxqAJn9j5oPyQEGmzWsd4FzJFfo7V/ZdpypBjLl5q61gGbVsCv1KO8Tx2pfnggrYFXhhmDX5ffnMCdoML50ivig5d5ub6cF0pHcnf0BzcCsXfvrTv+BEZxSJXXwjOPrOFShuLbYd5ppX5/HxY9IHR8uxlQRLMOrZ4WD6J7lifFWib+/HaJuVPUFOpgM5e6NOrX78Gctkej7f/jooeSIkgb4Yf0zmC1Yj3J648Z8bIMJM1pUqo8flV+p7JTjzvQYJgr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(31686004)(36756003)(38100700002)(86362001)(8676002)(8936002)(44832011)(66556008)(66476007)(66946007)(31696002)(2906002)(5660300002)(82960400001)(83380400001)(478600001)(966005)(316002)(110136005)(6486002)(6666004)(41300700001)(2616005)(53546011)(6512007)(186003)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dStidkdCSEgxUDNBNlpleVZOa0JuZXZRbFNYSk9HQmlYaVZ0ajlReW0xZURM?=
 =?utf-8?B?YXNYbFBVWVkxOHFtM3dIVGZjV3RoZDZXWEpvQmdBc0pCSjRXU2tET2VOc0Vm?=
 =?utf-8?B?NDlFWEZXOWk0bXdBN2tqZ1U2Y2ZUQ0dmbFZ6WUVrcldkT2M2anhKZUd3MVFW?=
 =?utf-8?B?ZFpXTVc2dFZUaFIvVjdUdnNMYlVkQnBBOEhkYmh0Z0RoazZOTytqdThXamNa?=
 =?utf-8?B?WmRCYTFwbXJRN0VJK01hZlZ0OXgzS2E1cnorN25TNG5oUHVuQlRsVDI4N0ph?=
 =?utf-8?B?RGRmOWVlOEZ6R2JMSElFY3FOajNvUSt2YVFYcVQ3bkl0bzFYdFpsSE9LQktZ?=
 =?utf-8?B?TjIyMzNPT2xoOHBzY1FLamh4RFZqRm9TSGVmZWFwRDk5dnlEdTZOcXRNb2tk?=
 =?utf-8?B?VDRPVi9vRE5mdXIvWFJVVkttQzZOOHdUc0x2Y2pzc1g2V2RsUEF0b1ZxY1Bx?=
 =?utf-8?B?SGdiUGNRYVNMaTJiZGZTN3prVjdpN0FGRldOd3FHVkR6WTQzT0xBRVllS0pp?=
 =?utf-8?B?M1JVTGhHdWdObktkeXZuTzBudVlpTGhpN3BVdml6bk5Bd1FsbHFCQ1VucVBZ?=
 =?utf-8?B?RjRvOVpBdmhvb2wzNEFsVXRSWmVaZlVuTnJ3ck9EZWFXWVBXMHlMNU5WVEFM?=
 =?utf-8?B?Z2N1V2NIUWZHZTErM29NNy9DOTM5NmxMOTQ2T2xpYVo1eFpkcEFObHBJYWIw?=
 =?utf-8?B?T24wcVU5dGlnOWZ0RHdDWGxXaXFQN0NtaDJUWkRlSU9BMHFMa2t6VVh5MGFp?=
 =?utf-8?B?dzY4dVIzWGY0K1B0dmk2TXJ5NkJYU0QwK0pPOHVROEdFbXd0K1JGQ1lYRzNa?=
 =?utf-8?B?ZWtORU1JSE5kTW1QaUpRVWhtcUpWN3ZwZE15YThKOTdaYTNQN0doU0h4Y3Jj?=
 =?utf-8?B?aUUwS1cvSjRYcjhUM0FDOUZQSDg4UkF0SVArN0FSOUFUQ3hNbWtOMTdKVGRP?=
 =?utf-8?B?SXY1UkE0M1hEZS9VNDErR29kNXpwMlF5QWkwSytvTlEwdDN3UEV5N1IyQzNz?=
 =?utf-8?B?ekwzMXd1dDlheGRvaDBZU0FRY2djZEFQS3dJQi9hUUdzeHpRS0ZlSm5JS1Np?=
 =?utf-8?B?bnh2REVjVTZtMlRNUWZqa3ozOGtxZFJHcWs1eGtQZGRUM3EvNzJ2S3ZiVnYy?=
 =?utf-8?B?SFJtNHlWMmhCWmRjUCt5RWlSaEpqaU8rWEN0eGNOV1pkTG1MRm5YQ0psaEdv?=
 =?utf-8?B?ZmV4Q2lxenJTRlF2YXlzbDRDdXdIY00zVlFmTUlYUnNwUVVZMmJ3dHZpZVlo?=
 =?utf-8?B?MmJLdmx2VUc0c2tra05qQlkyeVZYb1F5TmJEcmYrbE5ZWi8vOTR6NDlPMEJY?=
 =?utf-8?B?Uy9FYzcraEplZFdPUXRLZW1uU3BHNlNoZ3ppcWlvZlRMQTFhd0FRL2FCZE5N?=
 =?utf-8?B?czhENDVFL0ZwdlBuOWpobWxCZ3NpSTFZZWxmeVZvNUJ5U09GZ21wUUhqendH?=
 =?utf-8?B?dXBKNjlUWFREZXM0RHplMkxFbmZ5SE5Vdk1nS2pOcmNMeE1jYW8vWHlZV1VJ?=
 =?utf-8?B?WEVLb1BhN29wdndIbHFCRU9lbGg4eVlraEtJTDhMd2ZTM1p1Q3U5K3FEU2RF?=
 =?utf-8?B?OGxrcUlEbUU2akFJOEtHTFNubjR5dGFiSVBSbEROVHJ5ek84RDRIZzArc1FL?=
 =?utf-8?B?TFp0M0M4dFRjQ0RaWkMzYmNNVnNjT0JUSzhXMHdneGp5TGNOUktFZGN5encr?=
 =?utf-8?B?aHJDOUM1RXZEYjJWSHh3NWk3Ny9hbFYrWUNFL2ExQUYxaWFyVGg4UTJuVitK?=
 =?utf-8?B?OGV2cUVVeERaeitkcDhQeit3bGx4ZjBOV2gwZGJMN2JGM2xzSWZyakRiTWlx?=
 =?utf-8?B?Zm41WXE5Y25nQWRoV0ZOeUJNS3NZQWRHUnM0Rjh0eVlFMFBKMWRXU2g1Mmlq?=
 =?utf-8?B?bWRvTEVpaFk0dndwa2NPeU1BZ2pMdjIwTHNWcVVDUnR5ZytFWGg2WlgrcXlS?=
 =?utf-8?B?bElzNzFpVWdBS3VPWVNVYU5RN1JjMm95N24xVlZTNEFVR2hiTlp1c3NEVW40?=
 =?utf-8?B?OWo3TnNHTlE5WlZJVklKNmlCMmo2MC9JNFJmVWNucFliaENLTkJJeDFhVVZB?=
 =?utf-8?B?SlNUSE1JalZpSnNDNmRuMzVvdjBCMjhHZU1qcHdwNStPVnlCeUFPWWlxaXUx?=
 =?utf-8?B?L3hMWkJjb29ROStCcnR3VWsxU2lYbnJwYzhTTWFmMS9KN1lyc05yUDVoRXVW?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c081e5-08b4-4558-9583-08daf7ccd4dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 14:20:34.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBWByVhXgLFcm7PwOqtq5DeRfCMRDzNyO6fWRfxYZZYUt/obKTvb1nmFCOVeVBgtnhrRCO0WsIFVl66RuNjiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6893

On 16.01.23 15:09, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Monday, January 16, 2023 5:13 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; Yunjie Gu
>> <yunjie.gu1@gmail.com>; xenomai@lists.linux.dev
>> Subject: Re: while loop in a multi-core cpu
>>
>> On 16.01.23 10:10, Jan Kiszka wrote:
>>> On 16.01.23 06:53, Chen, Hongzhan wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Sent: Monday, January 16, 2023 1:17 PM
>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; Yunjie Gu
>>>>> <yunjie.gu1@gmail.com>; xenomai@lists.linux.dev
>>>>> Subject: Re: while loop in a multi-core cpu
>>>>>
>>>>> On 16.01.23 04:05, Chen, Hongzhan wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Yunjie Gu <yunjie.gu1@gmail.com>
>>>>>>> Sent: Monday, January 16, 2023 12:08 AM
>>>>>>> To: xenomai@lists.linux.dev
>>>>>>> Subject: while loop in a multi-core cpu
>>>>>>>
>>>>>>> Hi Guys,
>>>>>>>
>>>>>>> We are trying to develop a polling mode thread to skip the delay of
>>>>>>> the interrupt response. This is done by a while loop to check the
>>>>>>> hardware (say a gpio or a timer) continuously. When we did this we
>>>>>>> found that the system was frozen, meaning that the other cores are not
>>>>>>> functioning when we run a polling loop on a single core. But if we do
>>>>>>> the same in a normal Linux thread, the system is not frozen. I'm just
>>>>>>> wondering if polling mode is allowed for xenomai, or if we did
>>>>>>
>>>>>> Xenomai threads should not dominate cpu too much time in dual kernel
>>>>> configuration.
>>>>>> When xenomai was dominating cpu too long time, from Linux 's view,
>> cpu is
>>>>> like dead
>>>>>> and Linux can not handle it correctly in such case.  If you enable
>>>>> CONFIG_XENO_OPT_WATCHDOG,
>>>>>> it may notify system to avoid such thing from debug point.
>>>>>
>>>>> Theoretically, a stable NOHZ-full setup should be able to tolerate on
>>>>> top a Xenomai-only schedule with full CPU domination. However,
>> achieving
>>>>> that under Linux is already not trivial, and I haven't tested if Linux
>>>>> is actually entering the right state when out-of-band Dovetail/Xenomai
>>>>> takes over.
>>>>
>>>> What do you means about NOHZ-full setup? Is it just related to
>> configuration or commands passed for linux?
>>>> Is it possible to fix such issue that we do not need to modify Linux kernel?
>>>>
>>>
>>> I'm referring to
>>> https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-
>> scheduling-clock-ticks-for-idle-cpus
>>>
>>
>> Actually:
>> https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-scheduling-
>> clock-ticks-for-cpus-with-only-one-runnable-task
> 
> The last paragraph of known issues in https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-scheduling-
> clock-ticks-for-cpus-with-only-one-runnable-task, it mentioned that there is still the needs which 
> are are currently accommodated by scheduling-clock tick every second or so including calculating CPU load, maintaining sched average, computing CFS entity vruntime, computing avenrun, and carrying out load balancing.
> If we can not meet these needs , may it cause other system issue?
> In dpdk, we may also need 100% dominating cpu in PMD mode, it is worth giving it a try.
> 

Yeah, didn't check in a while that status, just recalling the at least
mainline was not able to provide 100%, but there were concepts (or
hacks?) to get it at that level. Obviously, if there is still no 100% in
mainline, we would just prolong the phase of CPU domination also for
Xenomai tasks, but not eliminate the need to periodically release it for
a while.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

