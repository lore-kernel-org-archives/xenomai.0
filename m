Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1647B
	for <xenomai@lists.linux.dev>; Thu, 16 Feb 2023 09:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDjvI10DeaG/eBPk22GBzu8Xe5DyT+JnKNPXuLfIm9vgAzUbth9CdQykbjzoQuVM8fzJGaz/FWn1s6MFYEnMHxgczuC57wcnoUlAu9HaLfhwGS6308rVnPanAOvQ70faw6n3ac8k1Ko2qUsRbGv9mOM0aniHPaqs/J+u8BHDE8Hz/D4rio/qdGhMTpAYqugAY7FM1DyH5LvFCPR/7tcLUYjMS+uxWQoaimP23tTS5b+vLMJSm/n7cJOjvHpuLf/S6a5qLzGaYdqyri987zi4KgmzEdY0eyZ8Ojf2uZFftzvSwsSlbMj6DlbgmjWwPcV8Gc+iXT4/9J98ltcFk57msw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV8pNFivegliChms4DlxC66dQKk5QhJ8U1OWorjcAf4=;
 b=lhVSYjRb38MckNXIpBqd4pbI1vMgunmomjZH5JTIRl/Lr8F2G6RtvzyzfmpV/qfbPeX+v7fho1gvuxprA+prQRDy3Mhr4puRj5SeM5WVfxJw/+ScGIhnAXLKOA5+VtVj31Q639l6JT3vlILJ3HjoFZy6tqG4OxNxyqD9EdhmKj+w/TVZXrseCYiRPRgqXCw8e2+jRDu7tK8w3poNV84sEndec5/8d32OJzc8Rm+03ZLB4D3cjGnTC+E3/5KWe6Q8CAzQyeDTGb7E3QlO1Fi/aMjTmztH8ZjmuBNUcal/WTZHrkLbrRvGkgC3JRYLp70uQ8+L3frjJGt8g/ob0Eo+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV8pNFivegliChms4DlxC66dQKk5QhJ8U1OWorjcAf4=;
 b=LGxSNncIvJQCCdDFp7uLQzlR0K+3N04pr1Wjjbz4UzDdj88ICMXhKw97/8ly57ICSMkh1UuHWbEm1MMcjsyxIy3Oohqc5ZJgLcc2SB4lOywVEbNj348sHM+ghW5NIyWtJmYkbN5HrCWEjt1f/aAt3Ch4YT98Sfo7ybj9mHRRer2mrIjybnH1imCOc2DlS7mOx8ILYFYRzZeMCCX9Hkldxtz5bluiNDxxCjy4IZS1QU8qMryqz7Bj3TmCIK52zK0IGbbUMw9A265xqm7mA0khMKpXQ2NTo4cTgrLqM+rvJyUem8w9oo17aKeNc9KjuuVGgPSR5bE4UbCwW1jV3nNXfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:541::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 09:31:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:31:42 +0000
Message-ID: <91565036-8b64-6a00-58f0-877fe83ba153@siemens.com>
Date: Thu, 16 Feb 2023 10:31:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: about rcu_preempt detected stalls on CPUs/tasks
Content-Language: en-US
To: "Yao,Yongxian" <yxianyao@126.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <502ffef0.6ee4.186548762d8.Coremail.yxianyao@126.com>
 <f2b91213-82a0-f78f-9948-3c7f9a13888b@siemens.com>
 <6cb72fb7.7353.18654c1e3da.Coremail.yxianyao@126.com>
 <31d280a1-f7bd-fab6-2e37-fc9dbdaad400@siemens.com>
 <40a7d44a.e85.18657d3155b.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <40a7d44a.e85.18657d3155b.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: ec63cb18-ce52-40d0-e63e-08db10009d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kTowKvYv5efXnV1irKXwc6M1nSFEO0YgH15es/8HMoMkMC1geUt+q8HfEGiaY89/KiydvZfgaKJC0OUoovRp12cLEwQ/ERn/Q8hn48B+4xUbeNLDfkEFi1w+GcZ2VIThmQmCp1nbm4akOQfv7X+YJKO7NQ1PJvHGxnH7ZIuXqV8pRhNKpyhn73feWjXNhrXn91ZaH/PJJNji3t6fp7sbSm0oPLs/63PHL9Y4eeXGHvuhSPk5ue9q0jzfrcQDe1jW7l6tsiE4uBR3UcZ+wQHekTebUzZhWwLPFV8Dy9Q8v8K62Zfd8KjwILCL5elEjYmV5ZWF3Ay2NjTN0HLCUrn5qy4ajHgyMfYwRJNN4zokArDHWHg5Z2bnYDwZhraYIhxyO84qVLlpc9uIp6BrIMfDxTIL4ifyEYul3EiR5TMjbTFHzLweN5epbXITciUIi39AsA4/+Av6Floe992mBZRprNaSW+5xPb1tZt7Zo6s9Iqh2FNsahhYI0q761m5bjUQEAVzRMoCzKEDlXEXKMxCdkO7i2hVsrs6DSqANY1n8hBq4P9qtsuwpK/5s8USyLfx1HiOQij7rWQuTg4oc0vp5iEm4S6YbZ+vTnC97RcdkqY/uons/mJybhGoYaUnDWe4xf0eAcH6VeEXjv07Zz/JiErnDAT/+4jYOhUe0Ftw3HaNCKUEK4zkwtySlzHBlrBhpFtopvZhaWgHwgFktsjlUs9nlCgRCK5CUtxDXlDsaiqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(110136005)(316002)(83380400001)(31696002)(2906002)(6636002)(6506007)(53546011)(44832011)(31686004)(186003)(26005)(6512007)(86362001)(5660300002)(66476007)(6666004)(4326008)(82960400001)(478600001)(66946007)(38100700002)(8936002)(2616005)(8676002)(66556008)(41300700001)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MStGczUxWVUzemxFUGN3WUpLd2w1N2tNSE1BUVE0dHg5azUvTG1DRjZOdW5o?=
 =?utf-8?B?dkdmRjNucFNSQmJQWk4yZ0RzRzMxZHFiNlBvM3lqeElobzh4MUVBdjBpaHV5?=
 =?utf-8?B?SkxMWFQzbUliNWprOGhiTVB3Z1QxN08vdEcydjM5MjJpcGF3TWhPNElUUVlT?=
 =?utf-8?B?MVZEbll1cGJ3M2lrdWdkYTJQRWtxeFcxV1J5WXFMSThRUDVkS3c3RUNmOU5u?=
 =?utf-8?B?dC9xTzVXZm55dU1WbUtWMDFSNEJOQTJZUWs4MS9jdkx2MjlPcWdCd3FWbXdQ?=
 =?utf-8?B?N1RLQVlZUXlxTmhybkw2YkRoMU1EQmhoYzE4MEN1MS9qclNUL3BURm9QV1Bv?=
 =?utf-8?B?RSt2eFl2c1QyaTZNZXd5dXcwUHRrVlBWemlRMGh0bWdlOGx5eUgwUmh1T1lr?=
 =?utf-8?B?REV5Zmc5RzZrZ0lNNnBMakk2MnVpZHpRUExtMzMyMmV3bVlJRXZPc3crSGhL?=
 =?utf-8?B?OXBHSWVTNEF3dWVzL2dhVndVMXBsUnpRUnlIZFRjbGtiekhaVXMvRUx6WVZq?=
 =?utf-8?B?OU9BQXUyQ3pIaWZ0bHpkaER5dnVDbmt2dUVQaDd1S2w0Q0NLS0pONjBIelRy?=
 =?utf-8?B?dFd3TlBtUVJ1dE1iL1VaeXZGb3RuL21VMmhsSnRtUGVlZVJ4QWJ3OUkwSnRR?=
 =?utf-8?B?SFhBbEpDOGxtNDZCN2VRYzc3c1hvS2JOUlZYalN0T28vSDdscmY2SUUyWGNk?=
 =?utf-8?B?QnI5VWZXdzdJQmxTa3hGbFF6NERveVF4MWx4UmdFNitSUUFhdEcwaTF5R2Yz?=
 =?utf-8?B?aUdaVlJ5WkJjWjFwN0xGaFVQUmJQTnpWT01lTFZPT1p0K2tNcmswd1UyY3Zx?=
 =?utf-8?B?ZTBhMlVyaHR1NEMwY1Nob1IvemhQVlk1cTdMdW9KVlR6MEIxQ1dCWWZ6aEZa?=
 =?utf-8?B?WmZUYnl0ZmxjLy8rTHRDWGhvQktzNlJzeXNOajkwWExhQlpCMVF3VUxjK2hx?=
 =?utf-8?B?K2hveTNHa2o1bHBlbmZHdFdtSlRmY2dnZDJhaDZCdTlmNSsyZVUyQW92bUFK?=
 =?utf-8?B?NVJpTCtsalNvWmdzUllRbnR2QWQ1ZjN6WDF6dXNFS3dJaXA5REowcEFQdkVa?=
 =?utf-8?B?TzFhQ2YrUXptMVhZOGlTUWdNaEJYRDV5Q3d4aEZoSWE5WEQrRURMdUhrRVJO?=
 =?utf-8?B?WFliK1RsWnF0T1VwV2J6b2o3Z2ZOZk14SHdnUVhOQ0NPWGdnQ1VMMC9zcWRi?=
 =?utf-8?B?bSsyYklMTHZYWnlYdU56YU16QmhodTJWSmpHVW0rdzIzZXhUSHdqRWlhZldW?=
 =?utf-8?B?TDdLbVRFb2d4eWRPWEhnc1JHaDFyem04Y3pDRFpUeS9sWjBsQWJwWENUTjU0?=
 =?utf-8?B?UDdYamI4VEd1Rmo5SkM5RC9oVTRZVDk1NG1DRSsxTExQcGdPNTBaRkdwVHFP?=
 =?utf-8?B?eXFjaExYdTlCTkxYOGxRZGEreEJpdEFWaWtFOTl1NUN1Qy9KTjMzM29GTWlL?=
 =?utf-8?B?UnRtVzFmekx4QTlyS3hFWGRLVTg0R1ZwUWJLOWJFOG1uenJQRDM4c3RyZE1j?=
 =?utf-8?B?LzkxTUVBTWl1S0dzZXQ2SmVBR1k0SWw0NklMT3JlT2wzL29VV0VGcFVrYW5Z?=
 =?utf-8?B?OXkvQkxJQzZCcXYzYVZQeFgvTDd4SGxkdTVNQ29URGlrU1ZHY1NXRUd2RzBu?=
 =?utf-8?B?U3NxNjZVZEttWXJPdlRrZmVRQ3RFMS9LS05ydjJJWUZIei9Xa1NIaGhkZ2pm?=
 =?utf-8?B?aW8xK2pEeUdJSWMyZzlBbFFJRkVuMTU1N2JWMTlabHdoTks1QXVRQkF5REJR?=
 =?utf-8?B?OGFNWHk4MG9ZQzAzRmxlSlVjQjlhQXBRc3pyKytyVmZiWlExcGxqQ3E5am0z?=
 =?utf-8?B?V09NVDBXQU4zY3M5ZmJYZ0hXTndoTWVzQ20reUhyTWhSY3V3VHNnSjA0a2JT?=
 =?utf-8?B?Zm1jOXBmazl2bmNsMDFUa2YxY0lhODRSY2FhNWxiRWs0VmdGOHBGdzQ1UUox?=
 =?utf-8?B?dUFLR0JTRVUva0QyWS9uckw0UkxxTlFnNVNhM1M3Skd6eWFJdVZrbzhDeTlP?=
 =?utf-8?B?dE4xMVlmMGxOMGo3dHdjOUpWNlJQZnlkelRmMFdaY2hkWmNST3d0T0ZzRmVI?=
 =?utf-8?B?eHgwcW1ORkZzcjJybVdGVEJadW5FdFMrME1Ecm0vOG9rU2MxK3JjdFFXekVo?=
 =?utf-8?B?UEYwZXdSU3BlTU5YM0ZjUjJRdW11SW9HQm4zeVpNRXl4Nm5GNVYxZGFZdU1o?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec63cb18-ce52-40d0-e63e-08db10009d1c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:31:42.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxj2q7QKwhDseRkGVlOBiqTPEf8Lw55ZTM4Bpak4hMan8NEPz29q+Rz5X4Iv87CmYc5zY0P+RLkCLm4qo/AW1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6077

On 16.02.23 02:24, Yao,Yongxian wrote:
> 
> Hi Jan,
> 
> At 2023-02-15 21:04:34, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 15.02.23 12:07, Yao,Yongxian wrote:
>>>
>>> on 2023-02-15 18:49:11，"Jan Kiszka" <jan.kiszka@siemens.com> wrote：
>>>> On 15.02.23 11:03, Yao,Yongxian wrote:
>>>>>  
>>>>> Following exceptions occur on the Debian10.3 using Linux+xenomai kernel. 
>>>>> Please give me some hints. 
>>>>
>>>> Is your Xenomai application dominating a CPU for more than a few dozens
>>>> of milliseconds? Do you have the Xenomai watchdog enabled (it would
>>>> catch such cases, after some seconds)? If you do have such a workload,
>>>> Linux complaining about not having the time to "breath" on such a CPU is
>>>> no surprise.
>>>
>>> Real-time applications will not occupy CPU continuously for a long time.
>>> And the xenomai watchdog has been turned on.
>>>
>>> CONFIG_XENO_OPT_WATCHDOG=y
>>> CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=1
>>>
>>
>> Ok, then:
>>
>> - Any other error messages before the one you shared?
> 
> That's all the error messages.
> 
>> - Already tried if the issue persists with a (more) up-to-date kernel?
>>   ipipe-core-4.19.266-cip86-x86-25 is latest on 4.19, last I-pipe is
>>   5.4, and we have plenty of dovetail kernels
> 
> The customer sites now use the ipipe-core-4.19.89-x86-9, which is difficult to keep pace with the release of the xenomai community. 
> We are planning to update the new kernel.
> 
>> - Any details on how this can be reproduced?
>>
> 
> Many sites have deployed this version of the kernel. This problem has only occurred once, and there is no way to reproduce it.
> 

That sounds indeed unpleasant.

> In your opinion, what are the reasons for this problem?
> 

No idea yet.

Florian, from our own deployments of older 4.19 in our MRT scenarios, do
you recall any similar reports?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

