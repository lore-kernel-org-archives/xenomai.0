Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20EBD310
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LqXRl4z6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNl7BksgVYmTDv+o8futA29PBuAuMK3kbigluFs2xBvAhV52d9CvVEpoFthpC9Vt1FuhL3g93ch7XxykmdoJX3stNlKAx6QNZFef9emHKhXTWeuoisouULitvD+kc4SM+W7QMQTgwTp/GM3euhE33tP7W3wH2sXaJy6AOWbP/8ZHdOsZvYuKTbJJI6Ki/tJfcC+RWUINMvJRVJ9BXbLHM4nGrYHtE2yy+o/xXG3wFj1n80XrRUQY2tYXpkqPQNnLpkkvxy68+1ntBlQvrq3NCr5kpmVl/ZEgt2oZvB8s65yG35NyIRH8XAqO1ksxa8MSd5ucic3JE9Dx3J51dzKZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BStSBcwx0ect6owEv21IwepCBc7wpCA8Q3YZpyQE7f4=;
 b=BgX6J98dAhSX8OEDo/Wol1s7lvPDQyjyHI6OmFdTdFytk+1fL88HIfWbe6XcZlIG0XvVmP1bO8dAI4QJqYBvFSg1Jueh1tVeS9PNTR8nZSC7uc3mnxIqIare5U7kE+wZKi/kfQqAOJ8rKB3+QVnKLaAhNpK//Ra8yqdgbIYvAo/tEgegE35RCXHftLusyGoLfDTYtmxyLeiC0AE71uyn8CJ1XRXyZoVyNRB5K67Z/2hOrBLpc/o43RsX3gHodIW1cTMjV8eped2bQU+UXuuXcBr/GgW++6BY8Slc/D+V+V6XETroqMBdn2aVWTWYXtn1w/K0V1wDG+4ikE92C/bN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BStSBcwx0ect6owEv21IwepCBc7wpCA8Q3YZpyQE7f4=;
 b=LqXRl4z6w3cBTZoYYhtlK/RSm66RdrZP9Z8QFCEvUEqanJaAYPe30hYLsUG/JqWCZ9wfy52NAe84rgE/vKP4VyhDfSZkLlGvlLee1sasW4JF0Cdp26ubA9QQIx49jx7YYhPTk+n6g7117l534pXpHrVWKtJy1h4qvyQipfy4FIZ9WwUeUYgGm63JGYq+LGTQWW+Xt9VqruvN0aAxGpFouhRpZELxtb4xtc0lm5gYH8mB1kAGnIQjC1qVlJu+HjpAB1mJImiBiYoVRQwTep7Sq8m/IlLu7ClPn/Wo0StEny8xOXqgdKW+i5w8uMU61Y4atniYKpdbaj/41CB4jeQSQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 10:47:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 10:47:19 +0000
Message-ID: <b96c25bb-20b1-48f3-8eb8-a9b1876ee820@siemens.com>
Date: Tue, 12 Dec 2023 11:47:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/psos/task.c: Fix psos tests, incorrect error
 reporting
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
References: <20231212-flo-fix-testsuite-v1-1-614eb1703e08@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231212-flo-fix-testsuite-v1-1-614eb1703e08@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 179dd153-526e-4e13-2887-08dbfaffb66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lw8J+zoI4v+6OW4wBl9mk5rJgymRQuhh3OnjtxyBrm8ZLwwugSFRTupvlUFA85Mc9U3g81QV+60kW1h4Jm/gObp94i+DC/SZD0cvFPuZ6G3f9Jht1fTk78FGsZMfKpfC2KzhwpFd7X8sPGwAaF25oQQ3SGivw70Q2iwhW3/cQtNQWTQ9ezhi6r0WYCJtlXnNB5b+3VyGq9T9+QhRnYFti1MvC5Xo3nJLhX5KIWsLn5beZrDVZ+OGw4x7lghe8SgAK8nFGdTRN14/pQphpow/0hcCPvCKxAPs0LihoO7z3QN6zvUkCrVGXvEuS5/+ppDsEB4TDK0vv4cGo3D0IjiXnP4DnAtfXXPTGv02no04o23+zr+uN8LComqO1TA2azRS9sqcJUQL2ts3FrulRM89lOBlJ+9eYCA2fD/FQOZnJ4W4ZEp/TDySkxhp+ttK6BVRvbw5gaCTbJK/xmXGIVrqp+ryhsDkOGVrSuej50aQlIUCBHbwpAeUURZjEl/PTk/+mS/snpC3s5c1s1mJM9/xRWVV+vG3GYTsaBd28A7G+MrZH3tvwDktybdNNwSCHcHYQgUow9pV5cD+OMxLkjnOwhMkXZLpPCCOk1ipaj6mor2BThzXhJT6mRuAPBY1ZlcaYvwaN865zNmE8f/i9DR/ag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(53546011)(6512007)(26005)(2616005)(6506007)(6486002)(6666004)(478600001)(41300700001)(83380400001)(44832011)(5660300002)(66476007)(66556008)(66946007)(4326008)(8936002)(316002)(8676002)(2906002)(31696002)(38100700002)(86362001)(36756003)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkZ1a1hVeE5PUW9rOWZYV1U4eDg3SE82Q0MxQ1JrOG1xb1BGWXN1TDY1TDRn?=
 =?utf-8?B?WlNlWFgvNXdadTg1MC8ydXZBbVNPVFBCaEhUSExxT2czNXd3UmdBNFF0VVhx?=
 =?utf-8?B?d3N6L1p2MEVaMWt2aUMyU2Z1QzRDNGkwL1dtSXJSMVNFYTJJbGZkd0RTRk5h?=
 =?utf-8?B?cGRMV0JsL0gra1ZJSVhvTi9ITTFjZjRVU2graHZkTFFIN1dyRktLbVo0WkdV?=
 =?utf-8?B?VXhTbkJUU1J0Y244OWJSVzVMVnRaTnZCTktGM1A3ZTdpNEZQY282K3NxS0JL?=
 =?utf-8?B?VUxaYVNta1ZRME91OTByL0MxR24xaVFNcFh1U3ZLSDNmMEF5UHZkWTIwdTR5?=
 =?utf-8?B?NW1KTWdwcXRtZU9XdHErcDlOU0praXZQQ2Jxbm53M3JWWFhEQ1VyZGpOMlZx?=
 =?utf-8?B?Yi9RTWxScGFqTUU3eG5MVWVwdXVxTjNFR0lGWEFUak8rTk5TVXVlZVB4VFFR?=
 =?utf-8?B?V004SGNpRnN0NmN5TWVlb3dkR3NLQytTZWhrQm54Z3BhMVJhanN4QTdOMklo?=
 =?utf-8?B?dHdYOFpyVForRlFnU0pwamhnS0g1ZjhPU1J2eTJvMUhVNzI0S0lYVUlDaFYz?=
 =?utf-8?B?aVRmNVdXSkFQZDNRTS9DYVRXdmZvQjQwRnBUOWtZSWkxRHI4WnN5VktGUHh6?=
 =?utf-8?B?NmpPdWQ1UjdkUWNuSjBrNGlNZnkrRTU1c0VHakVmMVZkRWQ1bS9rNlBKckNT?=
 =?utf-8?B?bkwraDd4aHB6QjlRMHFjcVVSWGJkS2FuRUtjRi84S21wQWJWZHdpQVNQMldR?=
 =?utf-8?B?UU91a0JxNmk1Sk54NFJqN0NieHl2enJ6WWRML2t2WWxCK3FuUzdTaGJtT3hI?=
 =?utf-8?B?K2FsblBVY05uYlFqbzBCWUREOFlQWSsycW5ORHZXNnErVUtTT2w2K3VNbUha?=
 =?utf-8?B?dndQNVo1K01rdnp5Y2lSckFvb0xTaGxHM2tpSElaQlVPZUozN3JrN3l1MG5z?=
 =?utf-8?B?L0E2M0dlWDI5UXZKc3NhSWtHYjFZRDRWL0ltenlnRnhzZ2UrU1liTW9Cb0Yx?=
 =?utf-8?B?SlZCb0ZGanJRUHZlWk9hVXlFdklwVWtPZUlTTUJ4dTV4YkZ2dnFqakpiMEJE?=
 =?utf-8?B?ZzdwRjRGQ0NWakJTdEs1cUNZbVQ1SGtSYklsRWltU01uMmNwVEl2dVoxZlZE?=
 =?utf-8?B?M0c1SEpuQzhWTzE2ZnJXTlIxZzg4SlZaMTVGdk1yUnd1OVFYTFRORjlXYUdR?=
 =?utf-8?B?ZGtiR3dPV0RmUXpwcDUxT3J2RE1hZFl3QVMzUzc1RTJWQjJpTm9yRy9oaFdB?=
 =?utf-8?B?bGx0WXpibEh6d1kxWk5KakwzZklyTXhFejhQRHdQd2ZnbERhTTd4VmhSc2RO?=
 =?utf-8?B?blRZcmNhbUdtMWYza2lWaGg0WVl5TDVvZW13MXZFZkhwSkI4RCsyT2MyWndY?=
 =?utf-8?B?czZSRnAvRXFLd2VwQ0VHVW1hbGNPaS9IejRHaDRuR0RSYUN5UUZBb3NZdSt0?=
 =?utf-8?B?cHVlY0Y1QXZlSjRISWl6UFR1UXlPUkdmUUFHSGs1MmRFa0FWM1p1Y2d6Zm43?=
 =?utf-8?B?dzZxS0twQTNnRFRtekVsZ1kxQ0JXYmNxdU5sQnIzUGs0VVJVY0JJVUtMVHQ4?=
 =?utf-8?B?cFJSRFpPUEZzUDRBZVhKZTRTZnFjR1U1ZTg3Z1JLM0Rocko1Y2xwOXBYMUhL?=
 =?utf-8?B?Y3RBcjNrZTZ0MzFxVnpoY3Y1eWV5ejBreWZzU1RoT3N2SUVmakNnMm1CRXFT?=
 =?utf-8?B?Y3hLN2lJM2Y5OHZBenRkZ1JJZ2hDNXJqbDRoOXpOZzBpU0NOT2Q5b0NKSTZW?=
 =?utf-8?B?NWQrMjdrZjFyMlhkQ0E2Z0NvRThRWTZ3K1dtVHNIbVUrMjRYZ3FWYS9hMmxv?=
 =?utf-8?B?WkVWREJUN2pXN25rRFVNNFdEOTZ1anVwUE9jUTlYL1lISU90azBWd1lpVHdQ?=
 =?utf-8?B?QnBiRnhEQ1dQUDNtejhMU3NnbTIxQlpQTHN0djN4UU5WMVVGdkdSNlAwbmR5?=
 =?utf-8?B?aDBRS1IveUpSbk83RTluY2VvdldSNmJEUUxZWTZXQnFyc3NzZHg0V2RRZHhx?=
 =?utf-8?B?MDI1OHJnaUR0Qzl1citvbm1HOVdyR3JtUk5Ld0FMYUZleG5SMm51aVpId3ln?=
 =?utf-8?B?S0F6Tm5nSTF2bXo5bjZIZTUwRGgweklmaFFoWnZZbVpzdytwUm9WbnZmRXpY?=
 =?utf-8?B?R0RGSW5wMUpJOHlMeGFpcytwdGxwdno0SkF2NW9xMWNpd0s5SWdLdXpzK1Ft?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179dd153-526e-4e13-2887-08dbfaffb66b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 10:47:18.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYKsmREeiA+u7W17gpIhRPTViliCNvh0ztqpjX+GeeQOUzLlpQ5YQzbyk8ULJHR0whiPruVY7WUC0HknYumGyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5643

On 12.12.23 11:01, Florian Bezdeka wrote:
> The following smokey test failure was seen on the current next branch:
> 
>  [1] at task-4.c:22
>     0\"011.394| BUG in __traceobj_assert_failed(): [TASK] trace assertion failed:
>                task-4.c:36 => \"ret == 0 && regval == 0xdeadbeef\"
>  test psostests_task4 failed: 256
> 
> The problem was introduced in
> 8dceca122dbb ("lib/psos/task.c: fix build with gcc >= 12 and -Ofast"),
> the second parameter of get_psos_task() was unconditionally initialized
> with ERR_OBJDEL. Even if no error occurred later on, an error was
> reported.
> 
> All users of get_psos_task() and get_psos_task_or_self() have to
> initialize the second parameter when the care about the returned error
> code afterwards. The value of the parameter will only be overwritten in
> case of an error.
> 
> Fixes: 8dceca122dbb ("lib/psos/task.c: fix build with gcc >= 12 and -Ofast")
> CC: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/psos/task.c | 9 ++++-----
>  lib/psos/tm.c   | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index 5341289df..70b5c6596 100644
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -96,7 +96,6 @@ static struct psos_task *find_psos_task_or_self(u_long tid, int *err_r)
>  
>  struct psos_task *get_psos_task(u_long tid, int *err_r)
>  {
> -	*err_r = ERR_OBJDEL;

This re-introduces the bug that the previous commit was (also) trying to
fix: We do not set *err_t when

task == NULL || threadobj_lock(&task->thobj) == -EINVAL

is false. Maybe just moving this assignment under that condition, before
the return, will solve both? And I would prefer a v4 of the previous
patch as it is not yet in master.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

