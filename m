Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199C8BE1
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 08:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX+J1H+tL2G+N+ZizmyuGGdkrNnMjv3jWAY9vboQoogWhycix3TB8PwpwEqPUsYcKgOr2hpy3ZhqH8pO9tHh7IakRxXtOBZQK4GBZumaACO0lbRHWBKWJ5wQnjPax+/hI94QjDzKyNvZi0x8KgLTV7Ojx+evHtzG8uVPhOIIgUwRhgN6nHVXu8FkwI/9tGYCIBL+VfipJi8yIxCspESDAHIlWz9NWRzh4JzOyY26OB/147z1Z4dBxPptQqnwmLi97C6nVPunM15SJlS5vvbc8SQ6Wh2KuHBDED73AHS7t55JjWE/XT/XhdezVXck2zaN/aEnwlZmPcEY0cqIKDFSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWmbraTfLsfnVycHqzJX26SjaMX7pH8brUCsK9+fQks=;
 b=QpQBFCnr5D/mn6zDZHTSDGAEfbRomS9eHgrNwAgDJ+g+zwHna3Xg8sFiiug3TmJMFaBr4ndUbwp7WCnpB4EqZzPnejp5gXNRlCsixplpsxHaCTpYIcrMwEISu91UBVH6/f7oDSGqdqxN2sQ3dq+kpVGy/XHo/w/+iFruNNyirc7xx6tLHu4IRHiI0SW9xYSOkyyAlnX0TE61iBPceGS4LXUghOwqnLlDoofNNSGw55zxJ/phkurkjWDxmp7wd0DCehjVmBM/8Ym/ue0cNVvfn+aq8Ew6E5JadJjLrb2Q6hOFCiZP0nm1jGiO4l6XDPT7BlvLk3m7iAmHd80WvHkFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWmbraTfLsfnVycHqzJX26SjaMX7pH8brUCsK9+fQks=;
 b=K16NZ+n8P4muXtQgIACyE+eM4ycc9vhsjWBNYCJYW5w9H2eMjiLNqqWtrQeFUlIfXmAA9m6GP1eqw0E9sM3Dle1FNBPwTx6Qg5SDqY3qv1oJYAsHYC2hLY386pLDLCME6efSYfltGTgdkTLv/nAlY376DdBRjZtPKyYwMHuJ83x9EuWn4x+KMcehRWVv9Pn60LJqCWBUttPoUF5/z2n0Z3EDXdwj9AJcgmvbbw6g+Qelj/f7UqxY2xjP0h8HyKMGuFqemZEScfwHf195LbMPsPtR+X5GdbiaWknEXrLjSCuVUK8puD8W8OaaOgxkLQezMa6mU8RwOWNP+4hGr+c+DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:380::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 08:14:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 08:14:17 +0000
Message-ID: <d0dc4947-3124-4781-a09a-fc1eeff23578@siemens.com>
Date: Fri, 29 Sep 2023 10:14:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] y2038: Finalize and enable y2038 support
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
 <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
 <6dccc04e926ae6a658c297cd7f45566e55fbeb7d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6dccc04e926ae6a658c297cd7f45566e55fbeb7d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: b0604d3e-fa8c-4490-3c69-08dbc0c4133d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aD8DFcL0Y2i1juXxa/FFJINyvAwx7DwvUEXKklnyMlZ2XxzpoOxiI+Dd+YoylEeA2JotmhucC8zGTOvJpzAYS1aQ2pJ0YMyodHINdqib7SN/QbV3UZotMrlN+r2m5X/qy7/9DElhDNYY0IBqW/VZXrF/vd1rB3ougiPJDdpkwU4roLevbnvVVpfePbtVjfdeALNWIt6nNxY3u9N4RPWqX8cJnnjOrRsG4UmcRXHHbQdWakOPeNcQwxqj5T2vbtNhsdmo4r1Gke4csfaacf2MfXkw39DD8KDp8E/REI63tLK4+f3cISi3aL+LYthCUPryhJwjrIKPfHSpdteWKFz2HV15y3mAW4grzgicUP6p1wjHONPuQSZmJTadGb7qnieViRcUCX6bT95WSUFaI2Ru6MLYMHli325uL4IOHyhRVSYJr6+k8O0kC6IORmSwBfOBiNHVJc4WCpXmChkfrCgOqFPJf4ug26o5sFip3WfOnwqwNcNDbeapKv6QwSUQP5pGmYaRnDpOvdVAh2h0BMSdIXmTkjknYo3gKmRKeoH5MF10eo/rSLSBc4wCRvvB9f5Pglt3ONV9JOwvn5apJnVIf9qunSY0xWcYHgCrPzwmrix09vMcZo4LHlnoEvtIkanfOmATdOcTLKYAzt/chACiMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(83380400001)(6486002)(36756003)(86362001)(26005)(82960400001)(38100700002)(2616005)(31696002)(53546011)(6506007)(6512007)(8936002)(41300700001)(8676002)(316002)(44832011)(5660300002)(66946007)(478600001)(31686004)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtjYnV6cHRrQUZOUUZyUGtHcjUzZkYxNXhGNmN2TXpzUzA0b016dkRsSGtj?=
 =?utf-8?B?Y3BOeW16Y216YWJHK3Y0K0FWWEsvQ3R2ek9pcW5YQ1R1d1RGQVl3VXlJdUdD?=
 =?utf-8?B?cWRQM3ozNWpvaFhtbGh1VFZjVURPKzFUWml0UGxGcFd2U1NXUDFEcWJCMk1P?=
 =?utf-8?B?ZlhWN2twY3lFNTNweFQzSWpGdjl6UVUzdGtRUE9vS2tpWXl6eFcwK2NJUnNP?=
 =?utf-8?B?Rm5YTGxjcEFDVU1jZjd6OTlib3A2TndLNWxiT1FRN1VpTHJ5RTNjb0RxYzha?=
 =?utf-8?B?WGpsUXpObVNZYmpQTXFaOFBmTjRwMFRtajdFNkRpRGtJSVdzaGdnUFZ2TXlh?=
 =?utf-8?B?Qy9VZUtSMWtHdGY0bXFLbmZYTHNQbk01UnRHZHNiMFlHcEZwV3hFeVVzN0Ux?=
 =?utf-8?B?bzBkelMzWlpRdE5pWTNzd1VzVkE3WDFzdUtPWXZOZzFvWUZJOXpGUmJJb3ly?=
 =?utf-8?B?QUc0WUIxanpBMzZXVFhZTmFPaGMwbU9PK1BEZ3VUZjhGQUh1MXViVCtOU2pV?=
 =?utf-8?B?N1FOWW1Yay90SEFMYkYwN3lyUFlaVk9OVURxdFp0K0VzSUZpMmRpTWZpbzdB?=
 =?utf-8?B?VXRVcXR1Vlg0cFhNQUVvTklsc3V1VlRublRXT3B5Vks5d1NtczdydFRZWnhX?=
 =?utf-8?B?K0FLVFpIN29jL1hBVkswRnU4MkRnZDdGVkxoTzVGQzJKbHBPWXVJNUVieGE1?=
 =?utf-8?B?cU9mMXJRNzVpNkZ3OTcvMDJqRXZBSjVSZXIvd09Bc0NLd29BNXdIYkZmUGJT?=
 =?utf-8?B?VGt3NlR4ZHVLcG9tQUVjanZoKzQ0Rlh5ZERxckx3K3FsL1kvWDQwR2ZCVHFL?=
 =?utf-8?B?TGEwbEtTTGtLckVQZXBudnByUnhKL3Jla0V5Y1QvN0tzL1B3TEJuWDIvZXRZ?=
 =?utf-8?B?VXhUVk16dkh2UEw5UlpDQU83TnVPV1VwbkVXYTRZZmVMcCttdSsxaXp2TWVF?=
 =?utf-8?B?OHdGeC9FRnJ5b3RFNlo5Z1lqcHZQb0l3dHVrYWRTK1pvNzdqbVMxcGt6ellR?=
 =?utf-8?B?MUpheUZBMU44QXVWWWtPRzhDd0JXemU2YXIwclFMcUh3ajB6djJSUVRYT0x4?=
 =?utf-8?B?bnpkNGNsWjcrTnpHVk0zWm9uWTNVK1B4U3FBaUI0U1lwQVJ3dkpTY2FSL2Ur?=
 =?utf-8?B?NmhTazdaUlFUNFVISk1wbjQ5K2krczhnc1FnVEthWnkycHZRUStPZDhoYjlh?=
 =?utf-8?B?R2RHQXJ0QXNXWGFwTGF5Qkg2Z0VudHRVcDBSRmJaM0J1RzBiYk9SQ2RwZmt4?=
 =?utf-8?B?TGpoc3IrZVJCQ2FLVmR6Z0RKYXdtcnJiVEZMWWxFT0V3YzFBc21USWpQdGRk?=
 =?utf-8?B?ZnJyc3BoVmZwNjNyMU5uajRPS1JlWmVlalI4V25GZVJvZ01NVFdIanE1VlJp?=
 =?utf-8?B?TGN1dGhCalFpT0ZzMFRHdXdrTmFJaXArYVJsaDlhWS9TQk1CdEN5a1YwZWNy?=
 =?utf-8?B?anVqSUNFZXU2dFVselQ4TG5KWm1lTVdNWGQ4OGlHQ1VkVTNnVHNSRHdLMFJO?=
 =?utf-8?B?WnRvWm5ST1BHdGtyUjJJZVJ6NlZrWlNkb2tzRzZoM3ZFTjFLaFVZd1FCRkU1?=
 =?utf-8?B?Uk1UeGJtMFd6RC9RQ2pxaHkvUkhaWVlOQ0YvZElMcXhzTFRRYWJqcStBQU1N?=
 =?utf-8?B?Zk9Fd1lnaUptYTN0RXFMd2R2WGlWVXpMQmsrcTdwK3UzM2ZhcHM3SlgzbWgx?=
 =?utf-8?B?RUo2bFhOSFRhdGtoaWtIQ3BleFg1RnppejE5Q3VIYUR4NkxySDI5dFBFMFhp?=
 =?utf-8?B?OXNOQ2J4Mk9SQzhJUXlLUTVFczdBdlVCS2JtbmxRWTBrZlZYY0IyTktaTW9Q?=
 =?utf-8?B?RTFHdVRtYWc3M1E4amJPUkhpMkZlWkhDNXpnTHVzMmowMWJQL2JXNjVaL1l4?=
 =?utf-8?B?ZSttN2VYdUY4aHExZ2VyQWt0MXN5OEF0ODNZTGhxZVBvZnovWDM0VjBWcGFB?=
 =?utf-8?B?VTNUWlpoYkxFcSt3dFh1UDFjSDZtWldlMDk5Skd5b0tFRDl3T01yalcvMGF4?=
 =?utf-8?B?U1dNTDRzTEVFTmhTa3h2QUFBbWM2alhQQXFSNW55dk5nSS95SCt1Zy9MVzhN?=
 =?utf-8?B?ckNZNDRIeHloUEx2K3doNWl3WU1DNkhvT1dSQVI2bU9JVThtS0s5MTN2NlBR?=
 =?utf-8?B?RmFlMlVJSVFTaFdyYkRjVWdMTXBCQVNsdW4wVG9GN2phZEU1d04zWFRpSkpT?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0604d3e-fa8c-4490-3c69-08dbc0c4133d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 08:14:17.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wnLhWMTx0T80UUq8+vXgUXgI4A8nNpnOi133wPjsiGKBdecmRaGJoP5CMKaBM59HLlKKUt0elzDKhm5XSxAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6240

On 29.09.23 09:45, Florian Bezdeka wrote:
> On Thu, 2023-09-28 at 18:25 +0200, Jan Kiszka wrote:
>> Thanks, this is sure a major step forward!
>>
>> How confident are your that all these now possible combinations are
>> still tested? Our CI will run with y2038 enabled, right? How is the
>> disabled case tested, at least build-wise? Or the case "unsupported by OS"?
> 
> Per default, y2038 support is enabled if
>   - the architecture we build for is affected
>   - glibc provides y2038 support as well
> 
> All 32 bit targets that we have (bbb, x86-compat) are now built with
> y2038 support enabled.
> 
> All 64 bit targets are not affected, so y2038 support is disabled (not
> required).
> 
> The only thing that we do not test right now is the building against
> older glibc versions. I'm not sure if it's worth to add more CI jobs to
> cover that case.

I think adding one disabled or y2038-incompatible build test with 32-bit
to Xenomai CI (not -images) would be good, at least for now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

