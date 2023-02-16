Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E97B
	for <xenomai@lists.linux.dev>; Thu, 16 Feb 2023 09:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrIhwM6RcU2IxYjs/eGhMXfaX2XxUc0eZfBbZWDPb366NG1o6j9ElsOjvgqGqFvrShvY6D9YO8kj1VS9N2NQwnlQSgT3kUaBL5aN6klkBoGPCmzc55rRrpM13BRRHSxPJvamYg81sl4QWjQc1ZTs6NsXpBgplRnsdBRIMTKQas4dQUbqCD3VHHcQUQHPzZZhICN3hgIotF1rkFOe4z1jIB8018rCy1P1L1XAInXkv9mOB2LVYzpVrrUaGm/8Eo6dhLXAGk9pxUb5LB/XwB9WtlTabHkkog/rDucrMeiM7eKeKw7Q0I5FbIRnT4lMnnivQg5vvNfCxkbkZvVaypiJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5ZnUAUCyfFuHNxFTgLNc4Fx/0lTYvd990UrwPTCLTw=;
 b=jZs5jvxN7AoXx4LxfPzixlZxqA/y21u0pcSQmaRMT8OVwPZrtzTzSWfuf0Tl/hAK0ZF0dq9QjuzIOAKg0tE4QCmS0lhCQzxladdXTcE+WhxvUP2y8RcZ2qvAYgDVm8BI1yyL1JDYjQmpxcgoqu581GDvbK2JihMwPabwB64cSdiZ7wTEeH52UqkwqwtKXwY0W+R4TeBzE7Z+SvQK7bZrpB4UHUrxA2XZigQGP9E1hfwaZt0yHDhpogs4vefU1F5p7tnF3WnIHWbHCTHL+Iykwbm9kzp7XQgviiLrFo9Cx4DceDNrDaV7dgG5o4BcMX/ObeV+bZqTAKVnBDy4Bk0ZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5ZnUAUCyfFuHNxFTgLNc4Fx/0lTYvd990UrwPTCLTw=;
 b=wU9mky8z1asn/VL6MT9uWAkENyA3ZCdVdmwhvLRVs9iiR/mREQnbbDdH343O0rHHdb/ad2JKYi3G0Vy2ukJbnNKaDQMZiqyEQRVVFEkXRxDAUUW1ZcwwIH4jhbDdGBpsvccN7XP0kn4D4FI3UJw+aavNSRpjkcRfd3XCDc85Zt5Ad3+5C3oIQhzg2FKqsyn8cCxD1DaMn4y1gs81SzBBb3T6qIb0d8Ov58Kj4lbb8bwxajH2jon/QoOWIQ0zO38fpjzvSQqxnWrRZyFMZ6edlSVTnC7bL/9yOQkCi7WaJ0tK7hU9Zv22k9RgTAqdJxwehaq4DoYC/syWo5VrLJWiLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 09:36:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:36:39 +0000
Message-ID: <8492aae1-06a7-2250-1dfe-5069ac8b9a72@siemens.com>
Date: Thu, 16 Feb 2023 10:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] testsuite/smokey/sched-quota: Allow building with gcc
 12
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230215230254.166268-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230215230254.166268-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fc6ed2-5c75-4335-e067-08db10014dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x70pjdsnlKH3OIOdYM+DZCJKk4zWYIYQaP7sJNSpH1VXLDvzOuLVMPzMz1sNDBd/VIVnkpkyLk8rc25CJRWaEfSQhsgW86kHIN7K79gtN42jdZbyWmvbsRBzUl9VuJ7v0adtSoCECV4VvX07A7SeRmKSBDqTu5/VZiKUexBLpIn9VWLUFGiEqgRbs7GMGX8vpilBiqmDN1rWGnXDwiuWeegb7ydbCUXcgP4GdwpY3+K6zQo2DujExB8BPlAD3JePNt9T/mkZjFbi2ZeizLEgycSn3L5P83+v6DCweG5VEAPa37MH3zWITn7Q2IoERfg3OVRVvalxFywRFQ28YGVbIqmuaFYHNOYaNdQ0fmopQZjt8q4VdUWkoE61Bo+fkWsHdxWNKkRiVl8jYsbFYbg9Q5IH6/M5Rug8V6BRilDCPELD8X7WzaLNMFQxxmjUPwfb1nwUKskCqtnxLIXxZ6tySFfEsd4avpTwmS7l3D7ZIH08OOmLDK/J8E1OziW5s4pYmn2j7iRe6TCzHEibJt+ZuHVZ5Puqn2scBbT2E1AHseHxhv0+rsY4ev5S9GpaUB6Y+GXEj3DFrDsFwmyYcGMkJzDDAoFUkLNn18FUKp/snjmblY0b1Ws1n0zncoaWYGgobmnsLI5DS0xtQgCdy6yCz8OJUIJTPfcp/AKAt31No9ZAUTwaXpXAS8Mi76N861UgnGOD5LF1Wh32jC9eWkqUX5BJXVZ60Witc0toHErn33A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(36756003)(86362001)(82960400001)(6666004)(66946007)(31696002)(8676002)(66476007)(66556008)(6486002)(478600001)(41300700001)(38100700002)(2906002)(44832011)(83380400001)(5660300002)(186003)(15650500001)(26005)(8936002)(6512007)(316002)(6506007)(2616005)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEV2bXVWbUpnWWFWUDJYYWUrNnlUSkZDZ3g2OGU5bVJMaFBZMlpHYnBVdUg0?=
 =?utf-8?B?L29lWE5pdTBTTStVRlVpYU82QU12UDBiNldiSWpUdzZhTEhXNWxYQXpxbGhu?=
 =?utf-8?B?K1AxczVGRktWOEVRTzc3RXU5cWlBRGtYMWNoYlNIT3VTaTNoOGJmRGlVU05D?=
 =?utf-8?B?SFBtazJDaW1FclBka1JBM3pNWXpHNW9UckdsTlRENmk0Wjh1bjdSVUZUVmh2?=
 =?utf-8?B?TnhPVEhWN1VtRmxzWE1aNlF4QXNhbG92dGlLZW5rOTdCZlIzckViR3F5dlBu?=
 =?utf-8?B?aXBmcHdndnZkVWZtWWgzMUEvYjFxLzBLKzduaHQvR0xwVWNOVzhvOEdqUnIz?=
 =?utf-8?B?dDhjUXBHTGhyQmxTSkcwZkxXTFJ5UjNjdjQzZHhYekQ5Rk9FdTU2Z3RMY3dr?=
 =?utf-8?B?RTBYRUZDbnlZdE1NQm5seHpYN21xVXdlZVo5cCsxcVdYYlV2TXRLcW91eHRD?=
 =?utf-8?B?ZkRXRHVCeWxyMG9zekRsMzZ2VTZqR3FwMlMzOThXRjRDRnRQZ1Y3SUJtbXNJ?=
 =?utf-8?B?MjhZVFJseE9aRXlhclE3Q0ROTElRWXFIRUlrdFQvM0FSOE9JejZOKytGa0lO?=
 =?utf-8?B?TG91akw1OW5UVjRYUG1LUnVRMklhVkZUTG1NdHJqWTI2Ujl1bkZjRzMwTE8z?=
 =?utf-8?B?a3ZINjZDUjJOOERMQ0JhNmdRemZJZzh0RGpXUytoeWVJY1pRQWE5Y2FSM21n?=
 =?utf-8?B?Rk9CN3pKZVZ2QitHOXZEYnpLRUgrUnVuK2FsdWVPaHNBcDBBeTN5ZHdTMzVQ?=
 =?utf-8?B?L2tVSmRRRjBiOGdkdW9iZHIwZUsxdkNUdG9yZHVOMmlENUM2bDJQTHRtQ3VU?=
 =?utf-8?B?b3J2ck4rZVlzM1ZyOGtZRmVna21NcEJLMDYxajBoWUlvS2haTWVkQWlpd1VL?=
 =?utf-8?B?RWtRcGdGWDQ3OEd5cnJ6QzQ0SHVRV1kwUVBVTlM1bGljT1pWK1JpYWxZMkcv?=
 =?utf-8?B?RHVnZ0V5KzFrbkNaYmJxRUtnQ1Jkd1pFNmNFbkxzQ1l3aWpXYWdBcThhcUF2?=
 =?utf-8?B?bDRMMGdvUk81MHFrbFgzTkZkY1I2K0wrZjB1VzdRNmNuNHY1MzdlbFpRbEll?=
 =?utf-8?B?TTY2TkNvaXd6Y0piSkxkSDM1QXdHKzM2ZnprQWo5Rm9xZGRxUTZTYm9pT0w0?=
 =?utf-8?B?MUYvRXpGK0xCSElaeW1qMmhRRkpmVjQrSGYzdHlRazc2b3pramlMWjdSRFVL?=
 =?utf-8?B?UGJYZENFMlhwSG5iMDJuNnpxdzB2Z0ZHbGpXcmlwZFVnblBCd0NhTVhwTUtH?=
 =?utf-8?B?YzA0UEJHYUJVSmRveFdFRk5uajBqRUhNa2FzbFpkSmhCYWIrMTJWc2Y2U1RD?=
 =?utf-8?B?ejVIZk9wb1Zlb2p1cGZpTWpWZmNoK0JVYUtJRUhkZWV0MnNzc3MzNGZGN3dU?=
 =?utf-8?B?VUxsYSt0VkpFSm1LWitWTVpBTXExelVDRm5VSHBPNmhDKzNUOUsyS1RxVHBL?=
 =?utf-8?B?TU1xc2FnK3B4Wk1WK2FFUFZZRU1Mc3huc05MNEtBZytNc2p4bFpFWUc4dnkz?=
 =?utf-8?B?Q3JoUFFJanFZbThTeDliblFwZGJFdWpnVlBxTHUyQ2laem04VTV3czg3ZjNR?=
 =?utf-8?B?d3MvYmJsVHlwUHZmRU1kUGVVMVZlMUw5TlpiK0dEbUVhOWRpeUNPZ3IyM05R?=
 =?utf-8?B?ODlIYWJvNllqbWZvdWxLcjBUZE9nVFlSUmQ2Tk5zQXF1Sm1EZ1YzdW5MNkdV?=
 =?utf-8?B?cHhuQU8zSS84enVyZm5CRWk4NFNoL1NXQ1BtOFFFV3BROEVCRmxRRlRxR0Yr?=
 =?utf-8?B?YzdVZHV4NUgwcjB1WGJhbXNtS3VYWWZmK013WHE2dE5OOFdmcklxb08xWlZB?=
 =?utf-8?B?UjJ6MWlEQnlIbi9OOFU1Q2FsSFpRSHpzSkdjdERXaDExdUd6emM4MzVwdjNS?=
 =?utf-8?B?ODJaV0hXcmk1bHdyd1RWQjZBZFRCU1lkb2N5Y2xXMGE0d3JhT3djS0hGc2N1?=
 =?utf-8?B?bTE0cDV2RWFlNFFEMEJseXQ2cmFQVnRMeEoyb2tNOUUwajNJZzBQRDkwNENw?=
 =?utf-8?B?ZEZUMlFDRzlsM25jSHJmQjVEUHVqWGVKclc3UW5EWkdjYVAxSTZYRGRlTEhT?=
 =?utf-8?B?QWI0bnZUMCtLdmcvcWFoQmxTSkgrUktyTHRzSVhkbjY4WmVNeHlSZ1FaVmIw?=
 =?utf-8?B?NFVCMXVBczd3TGNlcFpYOFpoVHRsSm1kNk1iY25CMkdwMFFUbndCWXhMbmpu?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fc6ed2-5c75-4335-e067-08db10014dd4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:36:39.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysLQgIdPfDt1hF5I06sot8XXKdY6/tETjEj71VDpDWJsbMpH6bORhaJueIGs2zmptZ12Xkjqfr59AkS7QO1zAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7128

On 16.02.23 00:02, Florian Bezdeka wrote:
> The build with gcc 12 failed with two overflow warnings. gcc is
> stricter in checking specifier overflows now.
> 
> In this case "t%d" requires up to 12 characters but only 8 were
> available.
> 
> The warning:
> 
> sched-quota.c: In function ‘calibrate’:
> sched-quota.c:244:34: error: ‘%d’ directive writing between 1 and 10 bytes into a region of size 7 [-Werror=format-overflow=]
>   244 |                 sprintf(label, "t%d", n);
>       |                                  ^~
> sched-quota.c:244:32: note: directive argument in the range [0, 2147483646]
>   244 |                 sprintf(label, "t%d", n);
>       |                                ^~~~~
> sched-quota.c:244:17: note: ‘sprintf’ output between 3 and 12 bytes into a destination of size 8
>   244 |                 sprintf(label, "t%d", n);
> 
> Fixed by extending the label/buffer space. In addition the migration to
> snprintf avoids a buffer overflow.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Hi all,
> 
> this patch can be applied to the following (stable) branches:
>  - next
>  - stable/v3.0.x
>  - stable/v3.1.x
>  - stable/v3.2.x
> 
> It allows to use gcc 12 (coming with Debian 12) as compiler for the
> Xenomai code base.
> 
> Best regards,
> Florian
> 
> Changes since v1:
>  - Rephrase commit message 
>  - Extend the buffer space (detected in the stable/v3.0.x branch)
> 
>  testsuite/smokey/sched-quota/sched-quota.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
> index acb9055fd..26bc15e72 100644
> --- a/testsuite/smokey/sched-quota/sched-quota.c
> +++ b/testsuite/smokey/sched-quota/sched-quota.c
> @@ -163,7 +163,7 @@ static double run_quota(int quota)
>  	struct timespec req;
>  	int ret, tgid, n;
>  	double percent;
> -	char label[8];
> +	char label[12];
>  
>  	cf.quota.op = sched_quota_add;
>  	cf.quota.add.pshared = 0;
> @@ -184,7 +184,7 @@ static double run_quota(int quota)
>  		     tgid, cf.quota.info.quota_sum);
>  
>  	for (n = 0; n < nrthreads; n++) {
> -		sprintf(label, "t%d", n);
> +		snprintf(label, sizeof(label), "t%d", n);
>  		create_quota_thread(threads[n], label, tgid, counts[n]);
>  		sem_wait(&ready);
>  	}
> @@ -228,7 +228,7 @@ static unsigned long long calibrate(void)
>  	unsigned long long ns, lps;
>  	unsigned long count;
>  	struct timespec req;
> -	char label[8];
> +	char label[12];
>  	int n;
>  
>  	count = 0;
> @@ -241,7 +241,7 @@ static unsigned long long calibrate(void)
>  	crunch_per_sec = (unsigned long long)((double)ONE_BILLION / (double)ns * crunch_loops);
>  
>  	for (n = 0; n < nrthreads; n++) {
> -		sprintf(label, "t%d", n);
> +		snprintf(label, sizeof(label), "t%d", n);
>  		create_fifo_thread(threads[n], label, counts[n]);
>  		sem_wait(&ready);
>  	}

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

