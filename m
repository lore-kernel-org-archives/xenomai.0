Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5317A2F48
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 16:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzj6HYjbZkXHwLk1AaIzzzWhfqaJTQFz82tHpvvqfT7EPm+bOOgOQegSaye5IkehhGujrqAilKjzrLGqUzv5bbLx/TnqBlUrK4v+NrGPBxVmDWkdKNPyTaUYKH5PhzscaMjbFeQaxn2gdl8+kCHJ6Pyr4i4yFsrfjWRRPG/RRdl6QP7QVeMDVYMcuZoKkYzZxKKb5QD1SNGbXT0MHr1trekVtZoNIRN84suekJKWotqo2rfslVmuV70Lvn/faWAWrFrdJJvDTuchvhgiG1cRVfKNBTeAlfItSZ6r0DuAVY8uWZygmvk+J8l1kSTfMPyVHIZc/4kpyORzQmoln4f3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbzhdraYQw/fG5TIaKXur9Fq+NwyDh+Zdj8UKNzHiiI=;
 b=dAPtiUGFM+9Q9ET7OPoUtcHo8Zc3SeNg2gw/zwK8DmHJOi71u1d1BJzlArx1HMkixWKO6zJhNMlmUojOc3CtctQkrYa/n1Ad0XXqR96Muyi5+5cwYjO73pEtdRPpYoUXmXRzHIJZVMErLjiLfYRLI/9wAhvI2QD/K8V2qDc6yXa73qVLaCzCLyAd1QethSQS1W7NfF86W4hNnsGngv2BBz5Zw8jW7I93+wLZSo/Fg3rqqeDBPAl2MmEaM9lYPamVnd4+B4gANm/NFhh82r4e207ZaHpm51+KwlZC+haeZva9bN6Rgjg3zTIdqMIYgcf9ERGGIQxveGsmIp7cUjL+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbzhdraYQw/fG5TIaKXur9Fq+NwyDh+Zdj8UKNzHiiI=;
 b=YGYPXJzrs7UtF12PtoCnD7Xb1nf1GZvrHDhyXhgsF4UKykkHBI9X9I55Skq1CoPlb9CcUUZfcStvrlkgdi7LRGl5wZa6rBbXTwwHkZuss6VKzd5m01SB0b1UM7G7FUae+hVSCfsBFBy/godVY/5V6DxQ22rUcpfAPaX0cXIspc/o0KO1/28fQYfPz/NezxO/FSed+t0q7LxcjV9p2SE119I3u70zA62bQHLXHPfIMQYeJXB0wM1h0Ku9txFC2A4ScWrVV/hRP/gT+CSNjzIeyowghRp48+ZWBjhtF+EJv7OQXKHVEo7P+9vu09KjWKNJ7gT5+046LRIDAjB2h86fqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 16:05:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 16:05:29 +0000
Message-ID: <d99de5a7-3c00-8c61-374d-5c0366c794b4@siemens.com>
Date: Mon, 12 Dec 2022 17:05:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 3/3] switchtest: test mode switches while in kernel
 mode
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
 <20221212121650.1294772-4-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221212121650.1294772-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbcbf63-5490-4514-fc05-08dadc5ab0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TvbvQqjMqmSnzVSv8lfk3Nb33twKe/kXXZooCbkqlivLnTtNs6gM5v9ClQQ/UtdkhsVmNLdxwMeiVydCYNofgqqtVBLxW24KHv8aI3imu5Qvky3fb8nLTbjsfgn+E+gNPq1WabO1T/S5xovGKj8NepXqMCoYokOWkW4vbbENSvdUo+mSAKKEokBwyi+rQCq/05EyB7AXYAqKdGAnu5GqVph9fdXDL/uOVVbj4022G68bPl1Xo8MAuSvfucflmpF9TY4xNSutvDbUbQPLfSUF1xF4HrhAA7UiJQcfv8ZOtXottWsh4gwNoyDqwN6J3MWNYO6fQRVVNs9ngVqvvCAA6Fh2TIYjJz1d7cA/bSjALoWAaHaS3SIOL6Vg0d8iS12AHd+DmMByWbAU0Cti3udENujYiu7EkJhSgSGfanCKJOvfgFAeouEq360XoVcmcN1HAr1kha6Y4mIP8FPVHnxzS6veLqlGdQ7hLni0yz9nTyA5pzKnOhBZ+LZ3QJnEe9g5i2RS14pCs0RWa6V6htUcTgHI7ReJBCE9Akns3OBSxn4K599h/h8+OSBKxgosXrn1GcfaOT2qeyclVUj1vOQaB2osURN7j4/m4J/uyp3R7SIM1Mz+VH9gfMztLMgAR2SeGKDwJv2HcgkrmEe16S8Mmwq1wYwfW95w5vUBJyCtB8j/QpJCQgkQJpP+pzgEEuCw9pcAzBwLuzgTKAvnD8a61GxQT+4QnGR9O3x6FUXEELPqoZ+qbEWSNgzF5gGD7L8F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(2616005)(36756003)(2906002)(66476007)(86362001)(44832011)(83380400001)(31696002)(107886003)(6486002)(6506007)(82960400001)(478600001)(26005)(6512007)(53546011)(966005)(186003)(38100700002)(4326008)(5660300002)(8936002)(8676002)(66946007)(41300700001)(316002)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEVzTkFLbWZtaVFrSmJWcTUwaGRZV3VGTWQrSWZsVG0wenF1MlRqUVdkV21V?=
 =?utf-8?B?VFpYMnVzdTFIakxzVmtDK3JLL3NxZ0RVOG5wd2dtdEdvL3VHWnlNam03Q0NO?=
 =?utf-8?B?dDM1bE1SQUdXL3dpQXlzSXBjOWZlTExieldFRVMyU2JFUVhTKy9RbEw5V3dL?=
 =?utf-8?B?U1BHRklmOHVyQ212bTZUNmZaQmF3Y2tsalVpeklISzJ1ZkRCVXQ0V00rQk95?=
 =?utf-8?B?bUE3QWc3MS82TVRHcFdPd1Q0aENsSXpUT3RNUUJjR1ExUUNhRUZJSGpERk5v?=
 =?utf-8?B?dEFxVWJjQ1ptcmVjcHVMck5uSDdXQmFMaUprVEROeDM2Q2NLZGRpOFo0OTlj?=
 =?utf-8?B?TG45bnFlbjI1NzJOMHdvUWw5dzZQWWtHZWdiS01xSkFQVGpIZDU2c3BCUnlW?=
 =?utf-8?B?azg2NlBUYk1VVDkxM0VtVzd1aTNGMWc2MEptVU5vTElna2Y5S1JGc0grL0Nq?=
 =?utf-8?B?NWJrWGNpblBtdzlsUlFFWng1UjBtMGRkM3VxUm1nTzZucU1iczE2dTBqYk5Q?=
 =?utf-8?B?M0hPTnJCcko2cHljQWcvMkRZamthM0FyN1BaRVY2MnM0Q09xSk5meHM0Y2Fa?=
 =?utf-8?B?eWZqQjljQ0JEK2VnMzB1S1RGNCtEZmpSNW1OOHR3OVplVXc3aTdleUFpa0d0?=
 =?utf-8?B?TFBZdVhnRTJtd3NjNHk0QXEwbitkSWVvU09ROU1nZzhCZVc5d1hXZ2ZmQVFa?=
 =?utf-8?B?ZG1tbVFid0loWmQvc1RtdzJEZDRneTM4RGpXVkhCbUQ2dm9penFHaHcxVFR3?=
 =?utf-8?B?K3VTcEF6aXh2SUdWUWUxR1MxeWdsRkJ3SUowOVV1TVVsNUdXWHdFOC9IN2ZM?=
 =?utf-8?B?N2ljdkNLazBmQ21IcTg4S2t3K1ZNTVg1azh0LzFkc2RkM3BQWk4wKzhUTG1X?=
 =?utf-8?B?UEplbGdDRzc5eFdOYXNTM3l2ODFWeXhaeEh6RmdvYzAyK0hEazJ6SmxOeGRU?=
 =?utf-8?B?MldIeUNocVhpYUwvQkdSbTVGR0I5QTQrRnRyV085TUtrZ09nQS96bjZhMTNZ?=
 =?utf-8?B?bDhaaWJmZDRKSjh2cld1VldLK2U4UzJtSmNyS1dhL2t1TzNYWWtJM3JUblNK?=
 =?utf-8?B?UDh5dDM0cUdvdFpKRnc0T1I0T2hYMnFmWFN2dVhmRzhMMktMWm9QM2xiWVFy?=
 =?utf-8?B?N2FYK3RBSHZjV0lDSTBsK3FjTlBPTDNnaEtYRGd5a2RUeTFNRFV3VXgvRXh0?=
 =?utf-8?B?N2cxS2J0cTExUkJUZFFxdmc0OWFTbi80bTRGaW4yT0FrUnRkUXo1VDh4WW0z?=
 =?utf-8?B?YlJNSXNxTE9xWW5ycHUwUE5melY1S21HdjFGUnV0VUJJeE5DWWZmVUhiSytK?=
 =?utf-8?B?TWM0N0hIcTBncEw1UGxqaElHQkRvaCtpdVE4WFpEcTBHMlFNeFhzWnFnblZa?=
 =?utf-8?B?dHA3MHZycmRuVytESmp1c0ZYU2NYZUFURCtVQ2pjenMxdTRwdWlLWjAxRjVh?=
 =?utf-8?B?Syt2ckxVcEcwd0UzTlhvKzZpcG4wRjdhYnZjSC9kZE9Md3dIUVFRQjZIQzVZ?=
 =?utf-8?B?bngvaVYrQ2IwZGVab2pFVkQ0cFNZdzF6azFjTWQ4L0FtUlZXZ0E4SVRTcXVs?=
 =?utf-8?B?dEtVNENpVDZwYzlzeWRnbzEyTWFrUXM2NDdWcEpGbmY0Zllkd1NCalY4L1Jl?=
 =?utf-8?B?bEZSb1F3ZlVtbUEzWjNtekVrVFNEMWxwM0FKUWpHdzZUOG5sQk1RRDZtS1ox?=
 =?utf-8?B?czBhUGY1b242MWxNUEVtV05hUURHSjNJbXY1OGdGZDZ1ejI2aElvTENmQWN6?=
 =?utf-8?B?aFg4TUt6NFZSalhhcURqK01IbWp3T2V0dXgwRWhYZjl6NCtNM0RRY05qMjZD?=
 =?utf-8?B?aVhwbzlHVEJoZlFnWllkaFU4YmNxMXp5eElpQlkwVUtmWUxTMFp1Q3l6bWlG?=
 =?utf-8?B?cWRybHUrckN0b3BtbU9DMWF2T1dvWFlweTFzQkxXMVAxY040RkN2cXJhL1kv?=
 =?utf-8?B?d281RmJlWU53RXZQcSsxV3diWE1kTTdKVFN1Tms1RWlVNyttV2RITzBFR3lF?=
 =?utf-8?B?M3ZWYTFZbUg2RGVGSHV1UFlwbCtJWTZ2TXp5NnQ4K011R2p3OUJtMUZDZDkx?=
 =?utf-8?B?aUxORWtFelRMLy94Sm5reXJtWStlSFcrcW5uaFdHWEgxMWRNTVJpR3R0aHpm?=
 =?utf-8?B?UlFCS2t2cUt1SytRZlZtUzZBTTI2SVhPUDdHb2Z5TE5Fd0ZSWUFpRS9nVzRM?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbcbf63-5490-4514-fc05-08dadc5ab0cd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 16:05:29.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3BZCKAhafkSvkwSv7TuLtPxcFl0O+bWVYa4MSF20yaLe5LxQjVAln6cuTa5meFcilBs/on7Lqo8XFyD2sA9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5517

On 12.12.22 13:16, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Make the rtuo thread switch between primary and secondary mode while in the
> RTTST_RTIOC_SWTEST_SWITCH_TO syscall.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/rtdm/uapi/testing.h         | 10 ++++++++++
>  kernel/drivers/testing/switchtest.c |  8 ++++++++
>  testsuite/switchtest/switchtest.c   | 22 ++++++++++++++++++++--
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
> index f8207b8c7..c389cdc25 100644
> --- a/include/rtdm/uapi/testing.h
> +++ b/include/rtdm/uapi/testing.h
> @@ -24,6 +24,7 @@
>  #define _RTDM_UAPI_TESTING_H
>  
>  #include <linux/types.h>
> +#include <stdbool.h>

Breaks latest kernel build, eg.

https://source.denx.de/Xenomai/xenomai/-/jobs/541475

Jan

>  
>  #define RTTST_PROFILE_VER		2
>  
> @@ -71,9 +72,18 @@ struct rttst_swtest_task {
>  #define RTTST_SWTEST_USE_FPU		0x2 /* Only for kernel-space tasks. */
>  #define RTTST_SWTEST_FREEZE		0x4 /* Only for kernel-space tasks. */
>  
> +/**
> + * @brief parameter for the RTTST_RTIOC_SWTEST_SWITCH_TO syscall
> + * @anchor rttst_swtest_dir
> + *
> + * This structure is used to tell the RTTST_RTIOC_SWTEST_SWITCH_TO syscall
> + * which threads should be exchanged and if the mode (primary/secondary) of the
> + * from thread should be switched.
> + */
>  struct rttst_swtest_dir {
>  	unsigned int from;
>  	unsigned int to;
> +	bool switch_mode;
>  };
>  
>  struct rttst_swtest_error {
> diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
> index 312b4d870..e2c0f4bcd 100644
> --- a/kernel/drivers/testing/switchtest.c
> +++ b/kernel/drivers/testing/switchtest.c
> @@ -647,6 +647,10 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
>  				    arg,
>  				    sizeof(fromto));
>  
> +		if (fromto.switch_mode) {
> +			xnthread_harden();
> +			return rtswitch_to_rt(ctx, fromto.from, fromto.to);
> +		}
>  		return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
>  
>  	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
> @@ -701,6 +705,10 @@ static int rtswitch_ioctl_rt(struct rtdm_fd *fd,
>  				    arg,
>  				    sizeof(fromto));
>  
> +		if (fromto.switch_mode) {
> +			xnthread_relax(0, 0);
> +			return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
> +		}
>  		return rtswitch_to_rt(ctx, fromto.from, fromto.to);
>  
>  	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
> index b1a87b27e..cd6da2936 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -358,6 +358,9 @@ static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
>  	switch_to_primary_mode,
>  };
>  
> +/* Switch two times: primary to secondary and back from secondary to primary */
> +#define MODE_SWITCHES_KERNEL 2
> +
>  static void *sleeper_switcher(void *cookie)
>  {
>  	struct task_params *param = (struct task_params *) cookie;
> @@ -377,6 +380,7 @@ static void *sleeper_switcher(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -517,6 +521,7 @@ static void *rtup(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -598,6 +603,7 @@ static void *rtus(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -679,6 +685,7 @@ static void *rtuo(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -727,6 +734,9 @@ static void *rtuo(void *cookie)
>  		while (err == -1 && errno == EINTR)
>  			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
>  
> +		/* Return to default: do not switch in syscall */
> +		rtsw.switch_mode = false;
> +
>  		switch (err) {
>  		case 0:
>  			break;
> @@ -746,8 +756,16 @@ static void *rtuo(void *cookie)
>  		/* Switch between primary and secondary mode */
>  		if (i % TASK_SWITCH_MODES == TASK_SWITCH_MODE) {
>  			uint switch_iteration = (i / TASK_SWITCH_MODES %
> -				SWITCH_FUNC_COUNT);
> -			switch_funcs[switch_iteration]();
> +				(SWITCH_FUNC_COUNT + MODE_SWITCHES_KERNEL));
> +
> +			if (switch_iteration < SWITCH_FUNC_COUNT) {
> +				switch_funcs[switch_iteration]();
> +			} else {
> +				/* Switch mode on next
> +				 * RTTST_RTIOC_SWTEST_SWITCH_TO syscall */
> +				rtsw.switch_mode = true;
> +			}
> +
>  			mode = !mode;
>  		}
>  

-- 
Siemens AG, Technology
Competence Center Embedded Linux

