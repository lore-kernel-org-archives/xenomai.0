Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392532F3D
	for <xenomai@lists.linux.dev>; Thu,  8 Dec 2022 14:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoeM9FMSu4Zl/eHyo5SLO16E4ZeYCnRWio9I/QQnlX8gJxuoLLUED4XXoKp4rwmIaqAu+gxtlXHfL05WQBO+k6Qr95HwxpM8fVhDoPkam2Monx1erwamOY8TxhSnOWv1jUQx4pV8PDgfnpUZWzVxN9z+rASHB041RX1pQu1VL9HzUZc9Y1C39Mg9TJ3ARNzgMEt/T+waf00DUwsYFOB2wBZKZe5SCdU7iD+hxGVMUZL31hHRJnhJYLFYzeOFhQI5Z/lkjVhjEmq/sDw9vP6dfOo+7fHlvDoWOz9wE3ff+7KD+yx+nv1XHdLJXpGIf4df6ddoGNh3VXQo88ec+LY2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=775UT8l+/YfsfdiaDczjSQLL8rY/4l/yEgNq1JGyFNU=;
 b=CUUuPQzyDHtQ+wmvqgzxPdjHkF1STlK1bcP3VaP96usCUtYnAEmi/ojdqutsqVL89DzymyOhurOsa/ff9cW3AzQmR6cdpnntrmTYSQp5xni+Sdr6qTvrZVANM5Ki51vdKYSUeRfTnU5O63OcsWPcEjU4XhtQADCpuJZKxxATgrACJpLRDmltFLP+utGioHUAZbxT33rKjTMlYNhyIPC4NXsdtrNxy/i+a0Vwx/k+KDdFnpSCgu7bmjTWhHnXNmWbr0lPOY+6uqnAsOEDQLF+quyOI1IWHpKxphtqmzr47/mRsqs1TlhJyoyMZkwesb5hDxVzilc/cNOQ33VlRhuqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=775UT8l+/YfsfdiaDczjSQLL8rY/4l/yEgNq1JGyFNU=;
 b=udOaMf3QoLlXCw4NPoY/H5Yjh7lRKEro3jkWaMRl5d8Mn+z7P0Q87X4lYBzmpUq62U2gvvPVTTKAs0KWFTwoehcAOPch5MjLJacaHFhVAqsIXRp6QEmu7uMSctMInwAZwQop1KdHdpgz45ccX9ce5KtwNIsr7cAFRiOd7jt24CV4h1ORJstCEvj9enlMdbermbvXbdFqBOehQDmsKwlF9Ta6bnKq11h99Fzy2pSOducjuSFGOmtsoqOy+OKiqfmGA/lcAYCfcUORVsC01+zzXG4Bfn9D6E3F07UBLSwjVDZ7/UigyxjuDWyk/H77BM18QG9jsJm6AUPt3jABtYO8yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3485.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 14:08:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 14:08:09 +0000
Message-ID: <2eb233d8-dc9f-5527-7146-00942f665030@siemens.com>
Date: Thu, 8 Dec 2022 15:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] switchtest: test mode switche while in kernel mode
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
 <20221205152104.3555474-4-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221205152104.3555474-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:610:77::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3485:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de10e8b-b4e4-416a-9087-08dad925a2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SqKHZib6WrLRcXrbsA/TE78ubj+JTYV7/ljmd1E+GdvQCFq1t6QL7JxtU5Bbu6N28tKqRD7wgOOI+ne87dcleXjz6Y6oW5hHxejirLuoeQbzNTC98/E2RAgJb+ywKeMHuhoFFZKwUqN6GLHcW2s+9Uv8ue2nrfJANFTIZ1TK47S8gl3oMnXpTxtYj3JoRrdBk+141r53A5X5DTrdfAaU0bXoeF+JrNmAOEwEzI3hk/plRoTmt2TIaqMtPtaf39nwW/KzFZJB3IFnrScZUO5VsX93PB7sJ0BjtNfK0oiO2EkZmLD4snwHpeS/O3fwZ/tVeMIMvJeY0w3q//R3z7HSyx4iK0xWDRKbDWri2ie2Wrqm7OEZYzb4jbzO0OmBKKL0iDlkGEhHUyW6p1OBqVih/TVOPGSLwhRLfuYiQjJjApzO/8IIihlddRDsE+SBmPrkWIoQM6gnw64p9fwoGp8dMmL2vhk2jPDhOhU8ar+QBID0f0/ruEMzRIPKQulIZkDJ2PZMJAYoJpc5y8lCkJFiGniu4wMecW2y5zmQCU/ONqqzkhjNU1puM0L+RJI42Y7ZKYzR3EY67dh9Lcu5Z48XvQ+21hpuQtYPODuHhlNWMzrvxuc4RM9vdYBKSYJDsG/NZ1OXpbVJ3b7MyH8xTAMeKCSumNj978c+NXurDXvkgFbjP+nRltVlFpajBfC5MTm53Kaq1fYKTYPxlaGkQ0FlhQtVtpcPvmO03+NFibSoQ/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(36756003)(31686004)(2906002)(82960400001)(38100700002)(44832011)(8936002)(5660300002)(186003)(83380400001)(2616005)(31696002)(86362001)(316002)(8676002)(478600001)(26005)(6486002)(66946007)(4326008)(6512007)(107886003)(6506007)(6666004)(53546011)(66476007)(66556008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXgzOFpiRW4yNENFK0ZUZ0lKWi9IdUZGR3oxUk93czNydHd1RUNlQnhFTFZt?=
 =?utf-8?B?dGcwcXJkMDBsNmJQNUR5MDYwL3RweHMxV0V6SkFjb2xtTkhKcENPRmR3eUJx?=
 =?utf-8?B?UFlRYktHQmhDQ0d6U0FMa3MzRUwydEt3cTVkSGZiV0NTT3J0c1BxdUZMTlFu?=
 =?utf-8?B?OXZNMUQwbEk1M3RuSlVxcXJFa1ZVcm1vSGFCaUU2cVRSV2tkQk8xM3d4UkF4?=
 =?utf-8?B?SGRiZ2JUYWZkRnFnN2xaT2tVZ2NQOWp2bDZ4MmNtajBMYVI5K0dMb0Y4aHNu?=
 =?utf-8?B?TjNBcVd5dFlLck5BUEROZWc2a0FIblhPNmVXbGJmTzhUYytBSUlrMWdvUllP?=
 =?utf-8?B?UVlqazBqN3pUQWEzSXE1WTNVTmhqOUFjZ2g2UXhMRkV0MEdRV2R3a3RRNSts?=
 =?utf-8?B?akJleElSZWJEVHIrYU1rZWJURldEMGE2UlBJQ1FmOWNUc25oUjMvVUZBRDdh?=
 =?utf-8?B?UW5CNlVvNVBxSlNxSGlWVndzQU5BV24rS1Z6N2FIQ2lMTEdsSlUyQlpjcUJu?=
 =?utf-8?B?MU5SdjVzaUJJTkRmVFNIUHNkdy9aV3lRYVRTOUI5N3V2aDlQNkNvbVZjSDlR?=
 =?utf-8?B?ZWRQd05sc1ZlWlBpdStDNWNPU1o1ZXhtSFVFTmtiTE5ra25GWEg0RWVsZGc3?=
 =?utf-8?B?L29JT0ovWWlQUzU2S2YvWThHQnRoMzJKc0pkK01WL3kvVWg4OWxQM0lWOHNF?=
 =?utf-8?B?OUhocENyQUp4VCtRTXRRNll4MFU4YWl1a0FiWnZXWTdhSlFTTHVlLzVWRzNj?=
 =?utf-8?B?ZlpJNm5TQ3puL3VPazlQQ09aTXIrVDVxL0pQSHg5RkdNNEJaWjBBUDJBdktW?=
 =?utf-8?B?NzY3Tkk4V2RWbk9Hb3BhTm96eWVXdXN5K1JLVHZwQ21QKzVmbzF4TC83N2p2?=
 =?utf-8?B?NnhzcjFqWHI3MWJFbHhGemR3MklrTlB5b1RPVSt5YXBCbGdYYzRKOEZSSEMr?=
 =?utf-8?B?c1ZVMXNGQWNyYXJLZWp3ckFXNW9nYVkwc2lqdmtIRU9TVjJsNXZZeURESWdt?=
 =?utf-8?B?dmNjS281VFZJWEdyNTFoMkVia1JlZHB5SkVJamZlMTFjSldZdWd4UDR2U0VC?=
 =?utf-8?B?WDQvKzQrQTZ3dklhUmh5UVkzeW92L2dqRVI1THZacUNBWjB3cXU5SytXLzNt?=
 =?utf-8?B?MVcyT2ZpK1JJN21xTkhDeUhycmFCNFIrSy9xaHBrOWxoN1ZDd3J1NTI4ZkxV?=
 =?utf-8?B?MVZFaFBPK3diTjdKd2V6ZUhQT3dLZWhPcHh5d0RkelZFaDA2WENSRDBJcEVp?=
 =?utf-8?B?N1hJc1JMS3JqOWo0Q1JoVktaYUlOMldaZXhrQklTaTQrV05aSDZyeFB1c2hP?=
 =?utf-8?B?aU5QRFhJK25UUHdmb083NjlUT2JpdzZYQ3NxV3g3dGdhWWo2TW90ajFKNEkz?=
 =?utf-8?B?QkNybVFDYUZYL1N2S01CZEFuYUZIaVZidFNHRnZNTnhvZy9XWEExSm1YVjdh?=
 =?utf-8?B?M3JwU3BYSHd4aXkwYVVYMnRJQXRvaVZXaHNoZS9DMTFRZkNXUVhPTXpTTkdt?=
 =?utf-8?B?alZtL3JBbFpYWE9tSVYxVWJzM0tFMXFGNktCVU5pbTM2VEhLMFBMZVNOQVND?=
 =?utf-8?B?bDZDWmV1SFF1eVBLVlo0TnBWVDEzWlVuZm1xbysycUFHelhmbWd3T1plZXJ4?=
 =?utf-8?B?RWNpNXUwUzdqOEQ2NzhCck9qb09hVXI1QmxkSUNQYzJUUTlFTjlwZ2w4VlVM?=
 =?utf-8?B?a3dCcEN5N2IrQmJiOXhKRWdkY1NNc2tuWGZNNWZlQjJMM2xnY0xKdUpCaUZu?=
 =?utf-8?B?NEI4b054aGlHNlUxVXVkMWsrb3kyL0IyZ0RFd3lHc3ZVaGl0MEFMdkswWjlr?=
 =?utf-8?B?aXIrVGpwZjJlTEpaaHRkZ2g0bmNiM0szR01mVzJlUkpocXBXbFEwMFRjQmJk?=
 =?utf-8?B?QmtNOTBlRXhOdDhLTzlnL1dJSjFxOFJPMEd4cUNjWG9sRG1VWnhZYnNzYjY5?=
 =?utf-8?B?WVdjenV0bTdYOS92Mk1yc2M0Wko3QWZHU0NEUm15dUdQRllJb2lvTjMydVQw?=
 =?utf-8?B?eWkrVDRYR2tIUWFnb2VrVUhaNnRSSDdaam9BUHgrcjI3QlU3VlhGZ3VYbTZD?=
 =?utf-8?B?bXViWGMrNXo5ZHRlMWFTS1JRQTBOb1NFU1kvV0wyRG9CNmlFUTdJaWYxUEYx?=
 =?utf-8?B?cVQrNU1YaDFMa3lXQU5ncEVETUFHUEh1ZStlVWN3Qkk0ZDdnSG9PdHBJMjVi?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de10e8b-b4e4-416a-9087-08dad925a2a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 14:08:09.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTLs1V2HiVxexr7HpTMhPQMoAxy1DFR+vbH9KB9iw0q83rT7QA3ISoxFGr2QedH4MX2MlmLTqUBtHxRkHyhlbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3485

Subject typo: "...mode switches ..."

On 05.12.22 16:21, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Make the rtuo thread switch between primary and secondary mode while in the
> RTTST_RTIOC_SWTEST_SWITCH_TO syscall.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/rtdm/uapi/testing.h         | 10 ++++++++++
>  kernel/drivers/testing/switchtest.c |  8 ++++++++
>  testsuite/switchtest/switchtest.c   | 21 +++++++++++++++++++--
>  3 files changed, 37 insertions(+), 2 deletions(-)
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
> index 12516186b..490e39f1f 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -358,6 +358,8 @@ static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
>  	switch_to_primary_mode,
>  };
>  
> +#define MODE_SWITCHES_KERNEL 2
> +
>  static void *sleeper_switcher(void *cookie)
>  {
>  	struct task_params *param = (struct task_params *) cookie;
> @@ -377,6 +379,7 @@ static void *sleeper_switcher(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -517,6 +520,7 @@ static void *rtup(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -598,6 +602,7 @@ static void *rtus(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -679,6 +684,7 @@ static void *rtuo(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = false;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -727,6 +733,9 @@ static void *rtuo(void *cookie)
>  		while (err == -1 && errno == EINTR)
>  			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
>  
> +		// Return to default: do not switch in syscall

We generally avoid "//"-style comments (kernel style).

> +		rtsw.switch_mode = false;
> +
>  		switch (err) {
>  		case 0:
>  			break;
> @@ -746,8 +755,16 @@ static void *rtuo(void *cookie)
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
> +				// Switch mode on next
> +				// RTTST_RTIOC_SWTEST_SWITCH_TO syscall
> +				rtsw.switch_mode = true;

+2 iterations because we flip rt->nrt and then back to rt this way?

> +			}
> +
>  			mode = !mode;
>  		}
>  

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

