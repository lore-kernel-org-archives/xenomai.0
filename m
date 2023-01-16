Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211241852
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 09:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpNO7yrIgBnA27iSK8HkC2ZNZ2HKjolQAoLInvNlVjFa322PQNumRLmxZyBkbyaLSRoWlPn2PECqn+NPY/33QuS7imbHXc8z/+Omu4yW9D8I/cSumGAwMWGxPXeEHT6DHTE2d+HUKLDqcIId8zjySJV/lBR/fNfzZmlcAYiNzfpybtYGTj9H2LBRwcZKD96mFeBmFUNGdWRqPfnuZyXAoVbkwmfwvvWr7uFT1ga0FplEAnJGt1UJopFPPpf/XyiW8b5RtL9wpDV4i0r1+Lbw7WdLVOXqCowC18ZlQIrn6ylvhyY0b1vFEdluYWORoTMAWzyJ7IQtCqgO+s5KnidZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaQLlBxjZP56JqAHktHClhvY7ryCzTkNbMQT+Xfk3wU=;
 b=hTHrkgMRfNwOYDefcZNUfB10e+qrsMiO/fYW4QIu9Yuteo1+TYxVjAEgboT1PdlFd2QFPGWr04xjp2wIXPcZjR9SNFtLT447tmdoOCyEG90KjsN612ZA5xAbfGqohmvJJOCWXnz+XmvmHluKwHVhLfXagwJ2YmWNBpu2bQEUJSUW+szoZLpG1C87MoGw9PY68/NfEorVclYSOtmhCkhl2ZR4s6QoqdldMs6twPNGsBjoyEdqKbxovCRJYWwDmO8hHJB8t3XFJc555eXy/8rFBMVugePkDJUDQ0yKxfX/x9bak+nTbu6+3REuEycFcVViDgPeLPZIirmsAv/2rVcalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaQLlBxjZP56JqAHktHClhvY7ryCzTkNbMQT+Xfk3wU=;
 b=S/9b7WbfcF7+6ngl8Svl5DrKhwHBRqSBaLLJFA3BEF+ViT6K50jgT5xJzD3Bu4PYaNq6sBBFlosn4bygkO42dbZ/u3YDbX01j27ZXvh67/mCKd4gXRGV9o9YJJnAyo/gJDRmWoS4km2J/vf0KZffJ3vHJsdwUSVy8jVXS3c/T2U25d4b/3NYIZdPNmB35edvrTDOflRu3P+CNwzA15AcQoLwGjpPbvqmqKjA8cxj8uxYnT7eHja12si3Mbi2wMVe0RVRpgsmM9dcDeTDiaC1oA1KU4cHwoDs/Ad3/G+/P5BIj+Fapz8gxhoNeCOXgGXB3BtwECHuP5SjmYJInIeygw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7202.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 09:13:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 09:13:24 +0000
Message-ID: <847c0a00-2e91-6391-d8e4-6677ca719baf@siemens.com>
Date: Mon, 16 Jan 2023 10:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: while loop in a multi-core cpu
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <94fdf3b0-bc07-7063-7cc6-f6987ad1ed10@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:610:57::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db23a2f-cfbd-4aeb-ba9c-08daf7a1ebc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kg0oFn9/xoJFloMAfLAV226TVGgEIUR6ayNkOUlE44belWVHP68RZHtRzDGdedhuBXuP8JBf/63XVLpl3CMx7J6/lTQuateuoPUzPu9Dr0wW9q69IncO7bfHB6yuy4xYepY+nNVdaqu8U6N89KOP8xmLaL7GshwBdHNt/nsdeyRI3HWQMjMPjl0YcTTqsCXfo8wUxm6XNuMR/Bz/+zpcSk5WdlAHg+BtjtTTS6zrxTIF7tcgkPH3hDUHdmfU/PCBJc6oQesroIEk3+rhG+Y5NBSNbppY1TkLRgFLR9jlgQRqFSUEaTgYP8jdlxR4U6tMuSRoGgebJmXfQkpYU2ogDTmcfg6mf4td2m7AlBV8/n5KWkZRNM0QEf2SPZZkUlpV5kMUpj1O8rrB+RBGCMueH1QBzaFUyzjYC7FxLmGzHfSMWbQYcQp6GygYxj1aqT4D+0u3ef4T414jGz4QJxZKd7sDA+wpI67mp6TKQ1Hd7OkvKgX88HZfAVPeJXilffn86QUZ7ZrsvrAZpDa2QtAfg+sMHYYmp40W33ZYg6T19hCxP8D5pX9if1u8bkMJ9Wzi9UX+r0/R/ITqVIJcsV8uexpndwr2/IAhjPqEJ6rr8eCL1uxg0T2cwDDuQyyZjFI9iT0Ge2Yp8ecs88hver6QvW1sEB8wnDrDv9O+Ac10COrM3lY1is9Z8TeFcNsj/HZraSnjaR+w/p9MPZt4sR0nbC5oJCcHJZQcQ1up94DFlz1kGMJiFwUwnGmkQYd0O2lYtR/gFDYyEepVq/WfMmqfC38xpqBIGsDOAQlksX3xqDQRW66P+tJVV+2JbzcRbaeH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(38100700002)(83380400001)(31696002)(8676002)(82960400001)(8936002)(44832011)(86362001)(66946007)(2906002)(66476007)(5660300002)(66556008)(966005)(41300700001)(6666004)(6506007)(2616005)(6512007)(186003)(26005)(53546011)(316002)(6486002)(110136005)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05SSUNDdGxGZ2MzYzNWWUJYeGNMRDdJblh4aTM1ci80TUR1MDZpYlpiVWJt?=
 =?utf-8?B?MThlQjZ1SS82OG1hVHdERmx4eEFjTDVxcHR1ZVN1QTZISmJtYk5WQllrWmEy?=
 =?utf-8?B?eTVQOHF5dDNiT3NnYmxQZy9JZTB6U201ZkdBdWNCYkJOaWtFQ0p2WmdxeHE2?=
 =?utf-8?B?YVRjakc5SmcwRDRyWThIVzlTbXpTTHQ0YlBmNk1USUtLZjhtcHhYQisydnlI?=
 =?utf-8?B?N0h0TFYzVUZZV2xpcWl3WFlVSzBvU2NwdG5icWU5eFFoWXFUL2tyVlhxMlF1?=
 =?utf-8?B?bjRycGYvWi9rNkg0SVZQa2t0TnJGNHdGS2J4aVUxSnYrTk52clJVNEVNOWRM?=
 =?utf-8?B?elU5cDdLdWhOOENjclJGY2NITHNaeUNrMk4raGl2cWxTOXRpMzVZRFZyakNl?=
 =?utf-8?B?Uk5kb1ZMNHdLcWt0VDZnQ3E2YjZRT29UblZ4MTIrYlBwYW0wakxDOXcwYVR6?=
 =?utf-8?B?N2xrZkNaM28zUG1tSTl1SFBDOUQyLzNQcnBDYS9RM0wwcnVOSHFWUmlCcXpj?=
 =?utf-8?B?b3U4azF2SnVrcVBpbXhBZHFnK0M5VVZHMzFOWUtLRkF1bjcvMzlyYW5Xc2hD?=
 =?utf-8?B?eDhIZ016WDlCNlJ4bWZSN0Fld2x2aEZZenZyNC8vNjlNekgvUlZrMUxLZFdL?=
 =?utf-8?B?Nys1ZmxoSE10cVZDVWQ5REFrUGs1NXE5NUhiNW9jQ0ZOZ0dsOWtvc2lrZXNy?=
 =?utf-8?B?VExjRmhwaXcvZjExQW5Udm81RFloMGhLZ3JidW5wSlAwK01xRTFDQU9meHNp?=
 =?utf-8?B?K2s3TFR0NmJlL3I1ay9JN3ljVjBaMlQ1am5hVHlTQWNweXlyais3TXU5YVZT?=
 =?utf-8?B?L0YxOWZ3ODA2eFJROGtMbG1mcEg5OWpqR0NnaXMvVzFuOVRQZXhMdGZmdHFG?=
 =?utf-8?B?NnF4a1dET0tBSWlNb2tYR2YvenJtTkRjTjN5THRqUEppbVZXTWNvbmhWd2wv?=
 =?utf-8?B?Q3g1Qm1sejRZZktCNk0zaVFWUU5ZS2FjSkczckUxSWVhYXNMS2RzaDJtTmt6?=
 =?utf-8?B?OVQyVGRDUCtueWcxMzRCWVdDaUQzZzZCUHRYSmFnOU16eDZpWlkvTmhrejF4?=
 =?utf-8?B?SzJnNVFjNGRXNys0K1pYSW1QNFUzclUzeWc5cDZVL051STNSazFoRDNBbFJV?=
 =?utf-8?B?d2RKbDQrcy92RHVvS1JuMzVSWHREVC9UOE5kWHdQYktsYVAwaGVMMHBNaVJI?=
 =?utf-8?B?S2J3UThHaXdyZzNOS1h1a3NJdmRsa2EzQVQrQkhLd2piL2dZaXQ5S0lTNDVT?=
 =?utf-8?B?bEl3UVhkSjlaNnVOeXNOZkVpbEx4Yy9jSmMxVTZ1YWkxTzdCbkREVmU0TkE4?=
 =?utf-8?B?Umx3eUhxQ1ZEckN2Z3hQSnBaZkhmVkUxVTdqOThqYzRDYkpVV2puYjJINDFa?=
 =?utf-8?B?OC94djl3WHVjVGI2YkVFMjQrWHNZSFVVRnBabE54cnc0emQvdGJrb3lBVW51?=
 =?utf-8?B?cnNpeFE4TEg1cnFIcFdCNWZGRXJjQjNocTQ0WDFPMDV4aUdNZmFzMkY3YnBh?=
 =?utf-8?B?akhxaUZSekg2WmY5NDZmQmZMYWNCN3lkdWRrZFNYN2lyQzJmNHd4Ung2WStQ?=
 =?utf-8?B?YUtzU1NuZWJtNTlEUU1BeS9YWlJMZUo1aENqMVpOZWk1dXE2U3I4amViS2U1?=
 =?utf-8?B?NEJUVFdkaW1qdVhmejBOaHZwZXJHeVhCVnhmZDJxMDdUdGYvRGhqcVlnNkhi?=
 =?utf-8?B?SzU0Y053bUIvcGlOUTB5SXJQSER6OXdqb2xTN0FwUWFDQUVwaGxQTE0ySkxP?=
 =?utf-8?B?N3RQNHNTSHBFNEIvLzMrUVFub1pEanJaaEZDYzZPZWhiTDFGaXE3b1NuRVEz?=
 =?utf-8?B?eVBFblpJc2lzWTYrY3NMa05UTFVLUkpZcXduN1BOWmRKTmhObkpDVnpSSzFZ?=
 =?utf-8?B?bFZDWHE4OXh4cERzNS9uV29NRlpqellCbUQxYkRmNXRnc0lBaUZDTzRtLzQx?=
 =?utf-8?B?RDlMZHlvWGFNTm9kUkNsQjl6NDlGL3hGOW5GWEtZenRlRmpVTHUyNlFubTR4?=
 =?utf-8?B?K2Z5V01YQXVPdUdGQVNqZEI1OGhYOFJIb2xNY3FIOFZaY1BXdks2Uit1MDl4?=
 =?utf-8?B?ciswbW04VEs1L0NqUWU2WjFIS2VvTEh0ZE9LdVFkRzM1N0gxM0FHdDh0eEc0?=
 =?utf-8?B?eUMyOURma2R3M1ZCa0pteFc1TkFFbzJYZzB5RERDTFFwK2tQdUp1eG9iSElw?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db23a2f-cfbd-4aeb-ba9c-08daf7a1ebc8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 09:13:24.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwcwMa2fwSu7OqIdhe2faWkfDizzPb188FpzRMrUGXDQmmwCSEoDJr8IYN4W2Kgc8O0dnPduNOH0TROjLwXbGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7202

On 16.01.23 10:10, Jan Kiszka wrote:
> On 16.01.23 06:53, Chen, Hongzhan wrote:
>>
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Monday, January 16, 2023 1:17 PM
>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; Yunjie Gu
>>> <yunjie.gu1@gmail.com>; xenomai@lists.linux.dev
>>> Subject: Re: while loop in a multi-core cpu
>>>
>>> On 16.01.23 04:05, Chen, Hongzhan wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Yunjie Gu <yunjie.gu1@gmail.com>
>>>>> Sent: Monday, January 16, 2023 12:08 AM
>>>>> To: xenomai@lists.linux.dev
>>>>> Subject: while loop in a multi-core cpu
>>>>>
>>>>> Hi Guys,
>>>>>
>>>>> We are trying to develop a polling mode thread to skip the delay of
>>>>> the interrupt response. This is done by a while loop to check the
>>>>> hardware (say a gpio or a timer) continuously. When we did this we
>>>>> found that the system was frozen, meaning that the other cores are not
>>>>> functioning when we run a polling loop on a single core. But if we do
>>>>> the same in a normal Linux thread, the system is not frozen. I'm just
>>>>> wondering if polling mode is allowed for xenomai, or if we did
>>>>
>>>> Xenomai threads should not dominate cpu too much time in dual kernel
>>> configuration.
>>>> When xenomai was dominating cpu too long time, from Linux 's view, cpu is
>>> like dead
>>>> and Linux can not handle it correctly in such case.  If you enable
>>> CONFIG_XENO_OPT_WATCHDOG,
>>>> it may notify system to avoid such thing from debug point.
>>>
>>> Theoretically, a stable NOHZ-full setup should be able to tolerate on
>>> top a Xenomai-only schedule with full CPU domination. However, achieving
>>> that under Linux is already not trivial, and I haven't tested if Linux
>>> is actually entering the right state when out-of-band Dovetail/Xenomai
>>> takes over.
>>
>> What do you means about NOHZ-full setup? Is it just related to configuration or commands passed for linux?
>> Is it possible to fix such issue that we do not need to modify Linux kernel?
>>
> 
> I'm referring to
> https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-scheduling-clock-ticks-for-idle-cpus
> 

Actually:
https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-scheduling-clock-ticks-for-cpus-with-only-one-runnable-task

> If all works well in such a setup, a single(!) Linux userspace task can
> run at 100% without being interrupted by any timers and other background
> activity. Difference to Xenomai: If Linux finds out that the promise to
> that task cannot be fulfilled, it simply interrupts it. But if that
> should happen to a Xenomai task, Linux can't express that, and we would
> be back to a deadlock situation.
> 
> Jan
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

