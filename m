Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1911FC2
	for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 09:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BedJqVYwkTeRY4gR+kxhpRK2kmpPgGjDvL945dsszJu6yJMDXK/zEw0Y+9iDrTEGgaNjP7ysO43olhOsGte4og2UDTK9qvoO0PggN2k8/aqK1vLVDZ0uIV6Xd+kqAELbBmxfBai4PKCW3eDI6vRDHlhxEp350RTAKRpiYBxYhRHVDuaSJFNyagaQiSqxa3o6+zKkwlxgH87otJ/Oo7TQ/X8Ko1vXWOdkeysiD0DFP6fk90k3G0Fb1IGoZIYBA7WCFeIZ6zML8DXC/x2x0teeJV1/naAvidxQfwQWm9f4rSGgP526b+sxSuLeAMA7I5NTk87KYUWgaUNLXFFrnDe5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSp/P+pkVireUg58XPvOQbcqGTjrGg9BsQ0XXl5SgDI=;
 b=BDLITxt4m4p8pj94RqVyJBxSmX0AR6zjsxMnHVGV0N9J9/h07kUEH7F6ug0Mon77e+rY1KVExfDtRlJ/uU1lXLE+xM6NI9IVMusOsFt/c/PfTI/AE2jc2F/SzDGwnukAcwLxBol7x094KTGOnB4SFtp9lIZSSHaGzALIk4HSkcYWVwjoMlX4sfrpyztNqSAp7VGDAVrIWpUGZZNOGHVwdYEb75KyWvigtGPOGb2uteDNzNtHsScEHcLQJFmCJ2M3lP3DTHXBRnjJxv9kp7He2N93vSw6GFm6qd2+jz77EpLdYeZTkURBtmyWIUsaP30LHq13ZZqw4yZF2u3gQO2tZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSp/P+pkVireUg58XPvOQbcqGTjrGg9BsQ0XXl5SgDI=;
 b=B7qJUb+Bs2eiffeK9/iJNiOXJ5Y/I1oZLOTY3BxSzNfJTtPJOceYNbWSRqaY3Ig+cveNUeR9i7Ezqqpcv1RobhBStgqQ1eDIg05nVsO6JoawuicjVJarIegcS1u2jNTKhTtliayhpkmCgYf6oAGmW59zEReV0DrbBFkwQ+37j3ambSOc3MaXwMWZavWt9LfyggYakqjtcumn/3oapisBmn8/KN2gPfx52YC0BJ76IbOgK6vYNTvySW3myR/o3NjSF/8lXu1Jw6SN8uX++p9YRJg3e422HCK4de1JypqicQ5ULY5/zvy8cu6VGRXBAiYBWaIXb91gTda7U93kVXGblQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 09:57:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 09:57:49 +0000
Message-ID: <c3a61a34-0028-57c1-1201-d18c1d9b1da0@siemens.com>
Date: Tue, 17 Jan 2023 10:57:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: while loop in a multi-core cpu
Content-Language: en-US
To: Yunjie Gu <yunjie.gu1@gmail.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, qiyu_sjtu@163.com
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
 <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com>
 <MN2PR11MB42855B83E5F981669B6B0ED9F2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <94fdf3b0-bc07-7063-7cc6-f6987ad1ed10@siemens.com>
 <847c0a00-2e91-6391-d8e4-6677ca719baf@siemens.com>
 <MN2PR11MB4285E612761676D50EF5571DF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <b3eeb9f2-21a4-feab-a605-70f6fbe9285f@siemens.com>
 <CAKcohPz3z+HVJxsaYcEr0Z1QDwxWHdbryoBUuc7+FxynR3nk6A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAKcohPz3z+HVJxsaYcEr0Z1QDwxWHdbryoBUuc7+FxynR3nk6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: c55dfa5f-3fdc-485e-1054-08daf8714a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OjESiUCxaWp5aFQM8RoOEGInM9Gxb0P/lJr/fYj4XDTEDAQRZA7jD3DteUlum+qmJcEppb72VXJu7NO/CjY4r71JdC8BxrUSS4bmBvNu490AwNbGFxqv5o7jcoQOw29ZkqYINx+vITQc5+McjQe9blqYqcugsnhKJPSbya9HMNzHhDOapvSri/TNbwnnVm9QDEjWi+TR4tzK9R2dM31kh11fHZOoCKfG1Sky/3GyujEduBN8kJ8cijdtxCcrVACaPQQt8R2qVYD99/MuDFSdjGvk+RCU5/AGs0cKGP0L99se/rn++jyZCirXk0X9in4uOjhqUBU3f8I4XHr/lUH4yqUKIi7ptPV9QshQnvlrsswTB9Ej/Jr0/1qBZRFA/Qap+JAhyumH1LYKEC/Oo98+5/U+21JK24zrmFJ/pxdfN4O5Y/AFRb1KyW1eQlKVSCzl0DH33F2jOo95JDcgEe3b1IBNbfTZgKxHfLhBYejfuixRkGAweUNtJcpeu5/d8+f7G1nUmFkX7gOBjwFTtWgqAclz+q2iHzDGdIzLyF4yjrakw4UDPdSYbSkWyluN+1rct9vEou81HNLd43GvbaERTYOK57dG56sByus5SeMKI5kcuOu+cT0RD8pO7UbLZUTmDi4nJp0H+B88B3hgTvefdn8/GRput1KtMlcXwgcJooV3zmfRSoRWKc2Vjnhr3Aji+lnPQImxMm2usGaoPvt5H6X5XgeVyF+i8YICiAgPVZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(82960400001)(86362001)(31696002)(38100700002)(478600001)(6486002)(6512007)(26005)(36756003)(6666004)(6506007)(53546011)(186003)(31686004)(5660300002)(4326008)(6916009)(8676002)(66476007)(4744005)(66556008)(2616005)(316002)(66946007)(54906003)(41300700001)(8936002)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVVFUCs3S2YwSTlQaFpxdU93bEFUNTR2K09iTXU4SE5xbnBTQWE0Zm1Ic0Ns?=
 =?utf-8?B?KzVhclNXbFRFUm5mQTZCWGlkNmZObHUxT05jODJQYVY4M01ZU1dTTk43UXBz?=
 =?utf-8?B?Wm9MTzVkMDlqeUZHTzZTcUlGbUdoYjJFZkJSbURKWmN3ODhKL0lnelhTQUJ3?=
 =?utf-8?B?ekxJNElCZ1J1ZXJLMExsQkJlTUdUQVZ5Smk1eWk4WHJXOFl6TUVkR2R6Y09T?=
 =?utf-8?B?YjJQSlphSUJJZmFQdnFUTmQ1OFRreTdyOHZjS21lazZtUnQ5TytmY2p0Yi9p?=
 =?utf-8?B?M1NXM29zRG9VQXRTT21nTHpEeEZvdkg4WlU0NVBVWmhzaURwcEpGN0FhU1ZV?=
 =?utf-8?B?MkpiN0hkMTF2YjBnSHFIbjJiR3R5SGQ3WGw1L1F0ZWxxWWladTQxN2UzMC9S?=
 =?utf-8?B?bE9wdUs3SVFVRjNOS09SdjhtNTJ3eHNrTlFsTEJSeUhTMzlxVlJWaTBhbEow?=
 =?utf-8?B?OXgvU25MajdHaTlpNGFSN3RjdkdsZGNmdHpmeHBjTUVBK3FMTG9UT0hqa0pa?=
 =?utf-8?B?UGV6WkcydXZXSXF2ZkF3NGlPR243a096NmRDQVE2SDNNUWdUekpJTjdPQ0Jh?=
 =?utf-8?B?Q0F6SGJyRjFZYlJLM0cwcjYrNEFRSTlyL0RFN3ZpR2NQZ0p3U0tRYmovclg0?=
 =?utf-8?B?SDBydVBSMDU1b2hZTzgyRGFJbVhMSmMvT2grblozK3RrNk9WdVpoRDhiemw3?=
 =?utf-8?B?dUVwMlVyNmZOc0JTZmt0M3FIdXczSlBLcE9WUmFZOGlIQWtDWm1XNjJGZTN6?=
 =?utf-8?B?WkhDcGhnZmpCUVhsaUlYWmhJa3JDYnFtQ3M0TnVteDhYR2VTVElBdk51UnZo?=
 =?utf-8?B?NXRka0J1RitpeGMzbDUwUmh6QnM4ci96ZVU3dnRGc3BGRnQ3blpRNTdteTJa?=
 =?utf-8?B?MCtrdktDcTB2SEVMLzNpbWFRb2JSbkErNFk5ZEJyUWgyRXN4bHBYY3Y2WTVK?=
 =?utf-8?B?M2FsT3FwampDQWEwa3M3c2lpOVhDYXJQVlpIK0YxRVMvVW1SSlJRV0d3U3NS?=
 =?utf-8?B?SGhWM1Npc1pYMVRWdUxOMWhDR1hHTGdpYjAxVG41bzRQeXF6WW9QeGVwYUE1?=
 =?utf-8?B?VnVoa1l6eUFHaHFPTjN5bDVIYzBCcEpneXY4aFBJREZlTEt2dGdYZFhNZkdE?=
 =?utf-8?B?NE9Cb3dWS3M0UVhJSlZzWXF1MFRXQ0lHbTVDbVBXRS9PaXdkNlpVdk10MDNZ?=
 =?utf-8?B?QTBFNldkeXpBdFpyMUtxQ3NKSHpIRzQ3clhJcEU5ZHhZbjJ1VWlJYmtUWVMy?=
 =?utf-8?B?eFl3UzUvbFV5TjZzbXgxU3lRZmp1cUlZTzVnSW9IczczenpYOElNVWwyMEUz?=
 =?utf-8?B?eFRVdUFuNGFGMHpkMzhxVTJXbHpYaDdtcUdha3daMGlsQ2dWSVpZV3F3SXd4?=
 =?utf-8?B?Z0NPRVNGZFFhZ2FiaGZKb08zNzgyWExwa2lIY2FWVklzUzJtQ1QwUU5zL1Br?=
 =?utf-8?B?dkpSbVpCT29yMUVBUmNmdjYwblJ6SjJBTGtUaStBTzhibmZnclRjQUM3TXli?=
 =?utf-8?B?d1c2c3N6VEFkRFkxUEYwaHlvb3JWMTEyQUJ6TWxmTEdnVXI1RFkyTnduLy9V?=
 =?utf-8?B?bFVLOHFWUUFJaVhJaEg1bkVMZmRBck9wUzl2UnBSMFdYaCswcUZZeWVKUW9Z?=
 =?utf-8?B?S2J2MERrTmVPSy8xZ3IyTVo2RE1NdllqSEwxek1sTzBvaFBibXNpZ2VrbWsz?=
 =?utf-8?B?ZFJUaDRDU0VoWGczdWRIOERuSjk1TkRzMjNNZEx5bVhuMDc1bmQ2TkNMUVFN?=
 =?utf-8?B?cmdpOVdFcXRsaE50Q1pVaEVpNEJmVmNzZWkvR1RWK2wvcmlyVGhUUHpZQTQy?=
 =?utf-8?B?RmJFTGs4aHljdy9MTHV3ZWQ5U0pjb3lTOGhCUGRiQitnUTQzNVVBTVJhVHpl?=
 =?utf-8?B?blBiUXZmM0lNZVhpdmJiZkNCNUlORTdIMWZUdnY1cURucUVmTWxaUGxaMlpD?=
 =?utf-8?B?ZzY4SHRWd0g0cXhGdm1ZYlRBOU9ZRjhEZW9rVk9UVGEzcnhhVjRQbXNXTmsy?=
 =?utf-8?B?Z0ZBcWg0VzJTQnYxZjJTMkFOL3k0dUlraDN1VEtvVytTaHVPZFlKNExxbkJG?=
 =?utf-8?B?VXFTSmwyMFh0NmhWRG03VUtCb3Z6T0pUUkxPMU9lTE5yYmtJc1NqU3g0aUdF?=
 =?utf-8?B?SHlpUzgyOC8waXRNbjY1VlRoM1BZY0lGZktGZ2cwcmVXT2YwbTBqSDR2NmFY?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55dfa5f-3fdc-485e-1054-08daf8714a9a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 09:57:49.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fqm+KyTKxk2T1FPZ3UiNScemVi4qRFSgn8394ku8lRJS+dMlOE3WQxcGWwjQqnbpEF7GgchpBXSrmVHL9WCN3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6237

On 17.01.23 10:50, Yunjie Gu wrote:
> Hi Hongzhan and Jan,
> 
> Many thanks for the answers. Is this also true even for multi-core
> cpus? When one of the cores is running a xenomai thread 100%, what the
> other cores are doing?

NO_HZ_FULL only works on multicore - you can't operate a complete Linux
system with only a single runnable task.

> If we really want a core to run a 100% while loop, how can we do that
> in a dual-core xenomai system? Say, can we isolate one core that is
> not managed by the OS (i.e. kind of bare-metal) to do this?

An architectural alternative to using 100%-tasks under Linux is applying
a hypervisor and running that task on an isolated core bare-metal.
Jailhouse (https:github.com/siemens/jailhouse) is one example for such
an hypervisor. That comes with its own pros and cons, though.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

