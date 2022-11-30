Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BCAD46
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 21:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msGt8FXW7OpsXHq6MyM4/tkO0eT4dYcAyZCwdErDXCiifM+Kkp3Pj0jZZy1mKH+qrrDnL4yHJK9reUdiNzuFQ5cB1qbehkf0xj0g1PWX1qxIOqoa8wPgsLdUK4COi6fc4E2+UXOZN2yuJcEiQp42xELYicU8lpKTuR21bWH7kjAQGimCk2a4xlCf43kMK9c7xMk64V1krQUjdFJh4pqiTv2AwgJdS4UBufQYi7+gyQIY3GbJdf+fYSsmsuXe0V6p2hu5i3qA8kAVYxoUzczrJ/l62SzWZJOi6wqIpQLnoiahgWW6/QQ6a3mxTtVEL0H+UoFNwgoqUxmRcdcKzA4ZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js1zT0cpUwkzI6nsH3OaSvw7y6Psxfumckt1njtkxJk=;
 b=G5mhrcQqEeTHjGyX4m9qhTefJb7+ppsLEw7lE/fBcIvt45RjA4oLYgjgVroIZCu+7+2sAiWEI7UluEshDmTmXnu5HcZM0vbnkGCigVLwrEFhz0dGWLzDuHGwxZw+YVTwjwmXF6aGN063SntkUblDfg1sIw/+Y8t4yYXkQu+Y0iBAMQic3CZc7a8AQGNreCAQXl2hP0pGpsgNHcMO8AejtCgtxvsDZTpHBhAyBKI2oXHhBQpHEtVJk0pNv/WxLLkkVurkkqeHqzcI+sFa8vdsd/gzC7s9Sj+NgI0JcvXdpXsFeT4toXldqQjomJ0HWaSbEQbV8+Wpg0aRoGfc1UI2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js1zT0cpUwkzI6nsH3OaSvw7y6Psxfumckt1njtkxJk=;
 b=YN3Yh6eQ02ljH6RQU7mPhAFw89DhFS3V2e4HTKYDwn2qXJVu43yCIuAPEdomVkiDTxHs/5Q8UuXds33Qm8r9BU7REDGVJ9JiFT0aE997Ey0fN1X3PQamqeZ6V33wHCnEqVa2kn+M1U1au4OyfjgrAM0iwR7DOfHn1IhgzRKYlHxD6CYSIKQvxlkbGWvUvG1Q87OPQN3pd6ZaXz4AOh2nt1jzhym7sJ5oikWvzUjZhhcskgB0ZwCmm/7go8EqoWW+kgHJCTDXQYMh6l2yQFnNDDrafWVXU+LsNFHeDYsnlMfGkz/bx857ad+ANQfp/4oJ6zIc4WF2KmnUydPr+bEViQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB6641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 21:28:54 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 21:28:54 +0000
Message-ID: <2bae4c4d-a833-e558-1786-3143c2a0bdb8@siemens.com>
Date: Wed, 30 Nov 2022 22:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/5] switchtest: test mode switche while in kernel mode
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
 <20221130141134.2503172-6-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <20221130141134.2503172-6-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0302CA0020.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::30) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DB9PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad5c14b-1da5-49cb-78a8-08dad319e191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eXX8lnnuaSjXaIN+9q2wUYL7llGVKsPy5jcd5W3xACDvScm3hrpDU6mNzAl1CEEg1EfSIcLeunzYd5zknWP7wTVv6Dzo+DxlRRSV0qZ9SJ0trtnoINSlMpIk8+kgWWNrTjpTGOYUCwcgGMTjm4+qnJvDQJr1O5Eiyo6aoKyRtDTo4fcgSm9V9Uxlz+vpVQJqUbtrrqrrvbZLWl/MFWuKn/oNGymNkOq7LSoxkd+yklLWtpfkll4Nd3jRHQLlf/vyuaIXXFtEC+0QmMJbCAz1qBarvNnoC+qz0QwdyAD1Dae6W+32GEnjhNZAbqCq/x1hFjO6VCYsfvbJ3LWQ3RLL+h9cd7Kcb8IlwMpH5RBpXNniYQPwa/EQoBLJTwRcPZZCHS3F4CGxesWuTzMq6f1DWs4JDia0ak3SWFgh5ZV6/F81ALQIGsV7H9gvoHIaWe8UsMTG8FGCGQEFdJ1s+58FfhoLnwuS+ziaPQKcgL+aYHHR0moHaSLofQr2sYGSmzGoBDUdc2OaWjbxQR8FCpgjHfCrf6ZlAWTHbU4HLNRgFOgdpTNrVeqAHaBmPeRjswaeBteVuthEyZuD/JSbUmT6JEUMzZhGFJzA9onAkv3tIPBRBdZRdah4YXGL8ub975KMPHKayWosW6BV40byxEWqNq6CUekqU4En3MVad4u1Poj/I8Y/e0iJPtUa4WY+B5MCdYoKWiMJ3YjerisiAbSziqcoidCDjc8jZ7/KAHSkGi8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(2616005)(186003)(31686004)(316002)(6486002)(86362001)(31696002)(82960400001)(36756003)(38100700002)(83380400001)(8936002)(6506007)(6666004)(53546011)(107886003)(6512007)(5660300002)(4326008)(44832011)(478600001)(66946007)(41300700001)(2906002)(66556008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFdCWmVGb3AvTHlMdVBONGFsT3JkeFBkQWF6UEJaWStJUVMrZ2lNd2VrSDcz?=
 =?utf-8?B?VmFFZXVSeVVZdWRCbWN0aU5MV0xZdzIydUhBejl3M0N1aDhPTTJOYzJCQUp0?=
 =?utf-8?B?VG1DS1JhZHc2dFZvSEFoOUkzTGdodm4rVi9sMGQ0WW0zRE1PbVg0RXovNHVS?=
 =?utf-8?B?UC8xUDlxT0VCQUFwdW4rVUw3aGJnY1kvRHUzOGRBNHgrczA5a09sR2hCWDNp?=
 =?utf-8?B?WmVWRmxSbU95ZlFwYzBxTXA3Z3ZsYis5anh3dlZYMnVycFBSV1JkRVV0dzRx?=
 =?utf-8?B?YUFRcUkybUhKRXZDZk1seS9rRjZuRHZESEsvenNVajcrNVBLeUh3ZUhqckFD?=
 =?utf-8?B?ZWxqYncwMjF5cVc5Qk1UNjBiY1BOSjcyRkJNWkdVQjJwYzFVdTl6T2ovZTMw?=
 =?utf-8?B?SHYwb2w1ZUl0L3MycFhpeDJXbUJtNDBRVXBaemY0SzdMV042dGc2WG5mNVBY?=
 =?utf-8?B?dXJVN1lQNmxDTlhja2RReHM4YUJLTDR6L1VRRW80d3h0WlFTSnMwLzI5bU0r?=
 =?utf-8?B?L2hMb25rbmF0SlVnNlR4OXRTQ1JBeG05RXZmZUJtd1cySlFyQVRKNENlZllp?=
 =?utf-8?B?VnBENWJxcU5rWjhBZ2w2ZzdheUpETisvbkxJYnNnSThTcHdPdW9xcUIwa3Rw?=
 =?utf-8?B?TWl2QVo3MGNjaDFDUEQ5OGloTjlJV09VUWcramVseDh2b1JQMzhLSC9MVFky?=
 =?utf-8?B?V0djcURkMDBTNUwxbHM2VTdpcFg3VjMxSmxqbDdTb2VyQXR0clE1cG9hSTZD?=
 =?utf-8?B?c1ZKWVZWMnh3Slc2QW9Xb3JHZ1ZWNkF4Q2VkdmlqTjd6Y2V1Qi85OXdsdi8z?=
 =?utf-8?B?Y3lPVFAvTENQWmJHbGt6Ukl0WDRYa28xVGE4cmIyV1QzQ2RtdUZlM0NRVVpN?=
 =?utf-8?B?NEdLSXVlQVQ5SEh3WEJjZ0ZKaTlhZ2U5RnNBeXAyUEpNMnUraUp2Qi9FK1Yz?=
 =?utf-8?B?dy9DNUpLSXJSaDY4WGM3N2UycVB5MTVHNHVFY25JNDJsNDV0Q1dxTFgrZDBD?=
 =?utf-8?B?RFFQdkJZczVqaTBmcmZSamsvTENIZHlSZjJjcHVKOUViNzZYbUViV09YcEZB?=
 =?utf-8?B?MHpaM0JmM1l0ZTJ2a1YrRVlBUkJCQ0xCTjJYOFNvWEpwV3VsTDNrb0Z0NWZ6?=
 =?utf-8?B?V2NVeUEvdWtzaHc4YXhEWXVEWU52MS9zYW1DcjRLZ1VQQ1d1SW1MVlFURiti?=
 =?utf-8?B?MEtxMkgrdU9oS29IR2xIcElmazhDSjRkZGx1NnVRWG1PUyt3RC9VQmRvYy9R?=
 =?utf-8?B?bEJwa2thMHZoQi9FVTJTMW1vM1NNbkpGa210NWpTK08rOGpBV2pNbFlQRXcr?=
 =?utf-8?B?akFYV2MrbEdTZEdDb1NwOHBwUTBPdzhQelFyL1pBQU90RFFqSi8zM0pHRFpO?=
 =?utf-8?B?a2FTbVUyeTdRMDRZbnRBdXZGcTcwd1dLb1poZTl2YmlDWUx5VXc5aDkwWWRX?=
 =?utf-8?B?SUt1c3Fab2p4OVgydWVSM3IzZmhUdGdPWmVIczRNMkpmNEU2dGdWamNhZW1H?=
 =?utf-8?B?enlhaS94bDBOVWxWWmFjdndtQ1BWK1NZTlA5V091cXlISFlOcDlBN2VCbjZ3?=
 =?utf-8?B?dkVDUUEvOU1kNEhIbGtxQzA0WkFTS0lsSWluczhMNHpwa0NnZDJWSnNTb0V0?=
 =?utf-8?B?Tld4QmZsQW5YMFk1NXRya1NTNFd3MUZFZEhWWERsQlRIdDJ3Sk1DK0M0eVJm?=
 =?utf-8?B?OUR2NFJncGZIVStxUFhHdWRNM3pOYi9CZCt4ZkNNZU15VjFJZndJaVlDQkNu?=
 =?utf-8?B?NUxqYm0rL0pGNEVvc1hyQkl3L24xWnpHZmoxdkVjTnpBcDZhcm5Td0swdXhv?=
 =?utf-8?B?dHRTZkp6NDJIREsxNGJYdno4OE5vMDVqdk1VSXlsd1h4L0pueXVhZWkzcmlz?=
 =?utf-8?B?aDArWU5hL0g0eWVkcnd3Qy82cFJsK1ZYRzBtaG9YMm5uT3RwYTlOeUJPOWxX?=
 =?utf-8?B?SUtzdEpaRmxHQlMyTEZhdHlFTTdqWlNLZjBxN1JUbURRVWNrWjQyRkhWK01L?=
 =?utf-8?B?OWdPK3BwMDdLMWRRN2JKNHZ0MFNCQjdrRVJsU2ZQYTRScHgxQStiTnhOcm5Z?=
 =?utf-8?B?SkUxN25tKzdRWDUwWW82VXlnNExzVXRqRzFxT0hrekVTMnd5dGhJOG5ZMU5n?=
 =?utf-8?B?RnZmRnErbTlucENoaVRlQ0hKUG9CR284ekZ5bjVwdmlZVEcvUjhuMnVXcFls?=
 =?utf-8?B?T3k5Nms4MTZDelhHWHowY3RiVlBGN1FzVGhTSUNjN1BIQTQvT1hxSU9FaVZS?=
 =?utf-8?B?dk5rMk5zTnVQazRnQWM5ckJvLzh3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad5c14b-1da5-49cb-78a8-08dad319e191
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 21:28:54.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3EwI4msoqnjpoWhB5K2BXdCktw+MZMh+MToI740lbN4Ak/RuP09wC0AoB5X12Fvg5bXFpAZoRPeWK0WqKc+4OVHckyScz/NhNnjaQmuIdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6641

On 30.11.22 15:11, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Make the rtuo thread switch between primary and secondary mode while in the
> RTTST_RTIOC_SWTEST_SWITCH_TO syscall.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/rtdm/uapi/testing.h         |  4 ++++
>  kernel/drivers/testing/switchtest.c |  4 ++++
>  testsuite/switchtest/switchtest.c   | 15 ++++++++++++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
> index f8207b8c7..059a1e0b6 100644
> --- a/include/rtdm/uapi/testing.h
> +++ b/include/rtdm/uapi/testing.h
> @@ -24,6 +24,7 @@
>  #define _RTDM_UAPI_TESTING_H
>  
>  #include <linux/types.h>
> +#include <stdbool.h>
>  
>  #define RTTST_PROFILE_VER		2
>  
> @@ -74,6 +75,9 @@ struct rttst_swtest_task {
>  struct rttst_swtest_dir {
>  	unsigned int from;
>  	unsigned int to;
> +
> +        /* Switch mode of from thread on RTTST_RTIOC_SWTEST_SWITCH_TO call. */
> +	bool switch_mode;

I'm not sure here. Maybe we should use something like doxygen "doc
format", so /** instead of /* here or even move the documentation
infront of struct rttst_swtest_task.

While at it: Maybe it's time to document the other members as well?

>  };
>  
>  struct rttst_swtest_error {
> diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
> index 312b4d870..05938a261 100644
> --- a/kernel/drivers/testing/switchtest.c
> +++ b/kernel/drivers/testing/switchtest.c
> @@ -647,6 +647,8 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
>  				    arg,
>  				    sizeof(fromto));
>  
> +		if (fromto.switch_mode)
> +		    xnthread_harden();

Code style: whitespaces vs tabs / tabs mixed with ws.

Should normally be detected by checkpatch (part of the kernel sources).

>  		return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
>  
>  	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
> @@ -701,6 +703,8 @@ static int rtswitch_ioctl_rt(struct rtdm_fd *fd,
>  				    arg,
>  				    sizeof(fromto));
>  
> +		if (fromto.switch_mode)
> +		    xnthread_relax(0, 0);
>  		return rtswitch_to_rt(ctx, fromto.from, fromto.to);
>  
>  	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
> index 970790b2e..e7441f9d4 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -376,6 +376,7 @@ static void *sleeper_switcher(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -516,6 +517,7 @@ static void *rtup(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -597,6 +599,7 @@ static void *rtus(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -678,6 +681,7 @@ static void *rtuo(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -721,10 +725,14 @@ static void *rtuo(void *cookie)
>  		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
>  			fp_regs_set(fp_features, expected);
>  		}
> +
>  		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
>  		while (err == -1 && errno == EINTR)
>  			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
>  
> +		// Return to default: do not switch in syscall
> +		rtsw.switch_mode = false;
> +
>  		switch (err) {
>  		case 0:
>  			break;
> @@ -743,7 +751,12 @@ static void *rtuo(void *cookie)
>  
>  		/* Switch between primary and secondary mode */
>  		if (i % 3 == 2) {
> -			switch_funcs[i / 3 % SWITCH_FUNC_COUNT]();
> +			if (i / 3 % (SWITCH_FUNC_COUNT + 2 ) < SWITCH_FUNC_COUNT) {
> +				switch_funcs[i / 3 % (SWITCH_FUNC_COUNT + 2 )]();

Magic numbers: 2 and 3

> +			} else {
> +				// Switch mode on next RTTST_RTIOC_SWTEST_SWITCH_TO syscall
> +				rtsw.switch_mode = true;
> +			}
>  			mode = !mode;
>  		}
>  

