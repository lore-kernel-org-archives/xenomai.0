Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3A20E6
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 08:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+sXr1ZJAQ3xKadBH0tRJB/ddONvtes1Wb/9/Zxe1eZRaHcZ4igoznsB4axxX45R3QB6NjDhO9Z0dun8uZss51rIfc7DscgsxMru74iBH/5U5Zo9OgSznakW1OlYjh29SyAD/GHogY0KujAcT8qoctpgKjeYhmQovINuZ0rIWOc4AH0cGPPord+sB0FChUrG4XyQ6ZalJ6hzeNBYnGbOG6wOrZ9OpS6qkjbxC2KpoO9jfawwyd3W3nN/F086VOFZaLHFUK6OvMWJl5PkunIhlul4TvGPCNO9t8Q3HC4SH3jINTVcNP9ZZ4r1eHYrfTPdJP5Z08MFk0RGDTIB1Uzb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGCHbi7nAIDOLeZ1WvveEg+y7WWsIr2GZtGyda8tLP4=;
 b=fiQBADw6mdkR3EBSNC2waqYLkfM1l/j60ELJFKaqXLIe6pbRLaDlV/QJKgyuJNRFbJC4YczyCupBCln3ohxMqClqwQB8GCYgyqRXn0KoTuijOaqhRxEC9ST6ePamMWS3GX2C3zGWGG4S1KBhKmM9r1uv21xjVxNR2/qzbZ++0HSsnrqtOirKqO/IgoT0ML88sP1DemLe9iud9x+MzZh8iamPfCv7EDh7DuUqUK0j1GfGng9wu8YTGECQ/pW3WHdxRweOoP3Vvjo80Q7lnLYXwUB1q16YX+3ozCvPzF/UF4OgvkxQ7+xMszLZbymBNN4MsivqBZd9MNxuhqAo7/1cvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGCHbi7nAIDOLeZ1WvveEg+y7WWsIr2GZtGyda8tLP4=;
 b=isi7VRxvsZZS1wmqsZ3enysKy5W1b5uTA4TXNQQA2IMZyKTaKU21W9R+e1o0l4Lvjt8a0wvjEPSPTcbCtKCoQk+kOrOr+i2KrZKJMC0pB9y4EVujRLiGR2UMjRL44Bbb3NVfJ4SCXqVhBvlge79/THU+DY0hYOB9V2P72KsNaW/ilVOHdRerBbkj6w+AUv7fxTavukGvRCmu7Thz3aOJMIHDQMamq9R14IaX+R8JZQaLT3iptnFESqaPwcrZtG38BiDypyuw2qxWQOiKueZk/Wq7nxUeS3JKCBWFQ55RvHkpB6E8QesKGQXdFzWJGesuxESR5IIj7FNBkj+vxqg1NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:604::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 08:14:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 08:14:27 +0000
Message-ID: <ce47a52d-aac5-f761-849d-a3938b40f3ab@siemens.com>
Date: Wed, 14 Dec 2022 09:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 3/3] switchtest: test mode switches while in kernel
 mode
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221213195205.2870828-1-tobias.schaffner@siemens.com>
 <20221213195205.2870828-4-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221213195205.2870828-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f0f1bd-6ced-4b37-5cf9-08daddab37a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iqFdm55ZLPbVjwoBvs39SlXgtd5sDQOutXHd8NRGwaeEojUkLKB0yGv85hCfix7WqZKMxnUWzSoz8ktCBTfpvMfYF8Q52iOyqdQCwArBXp50OWij229o9wGD1Lqgh3oG/w3P9gc+cvYxVg3JkfuH35G0AYL/faGzehWM+OZlozWWO8Lh78k4Tjv9jT4AmlZw8C9ulOaXfgSXUIVSYZbvAbKWhckn4TWH1bW/SkMLVBhoMRmOS2Wd8b+M8x+iy7GdCeJOqn2IFT8gSpOqNKYeVvTDDZgYtHgk1wbpr79zc6JxV1jrDVh3h8BewQ7GXVTls9f46xN1ugP9VJ9eouUIsxKCBWulBf56EPMlwa/Oo8gedaLw5+t99W7Az5fi6PYxWxbZtywKCEV+g54zFx/HluHqbIdZOEsYTSxQIGs9CSxSqy2ePkRxMb0Y8KM5CwffSiMuF6Ro7bJPbSDPRcWdmjPzkLoxRsKNnQVqUK+f9aqTbDzxsMxIOGZhnJsk2PX8AvX1bPGgi0EkxAbAAcqgvgxTe3NE0u6wmIIBcoC8MElEleP/2SggFRb19HN40G8EJm7LhS4SMB+FeCLBTdHlZjIlkVC/46Z+BOPwsvNXXvtQ5ZOqtLR5MTEh0bTa23oItUGE+DtzhIRbxyv+ipPdfaZWUVuscNZSljh7H7qTGgT2DhuTr5QSRNQJ9LE8hRP0qYw9tzRAneUCZUgGHtEGmcrX4z9GPvTgFAJuULTicSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(107886003)(31686004)(6512007)(6506007)(316002)(186003)(53546011)(26005)(2906002)(6666004)(2616005)(8676002)(36756003)(66476007)(66946007)(66556008)(41300700001)(82960400001)(4326008)(83380400001)(38100700002)(44832011)(5660300002)(478600001)(8936002)(6486002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFhGL0phcXV6eVlTUVdnS2d0ZXFDY2RtVHpCWENVTndCM1RsdDlxMGdZZlRs?=
 =?utf-8?B?NEhVVWswSWhWTmFIUDkrTEVwbzM2Uko3UVNFbGNjVXF6WC9QNVhrR0U1Y1Y3?=
 =?utf-8?B?Y3JYOS9CRVFNQzJublV1aVYxWnJ1NG1PclVHWCtYS21ONzlJVG1ja1lzcW1F?=
 =?utf-8?B?ekdBdk1BRTAyeVNhc3R2TzNPYm4raG41UC9NQWtBZjhPV0sxUC9hRktCNzJ0?=
 =?utf-8?B?Uy9MTGhXTjdxK3pYUkhkUmEvQTVzWWdLOFhHb0xkbEt2TWwxU3pJMFQwdWVK?=
 =?utf-8?B?N1JUQmJ1YWR3VEF5NmorZTM1UWcrQ0pUb3BSQ0Z1M1JNT0loM1ZXU0p2eVNW?=
 =?utf-8?B?VkFmMzhBcXhCV2xZMzRoNHBrYnNTK2tpMk00cTR2bkVQcWFvZktRMlArWnBC?=
 =?utf-8?B?T3F0K0puU2hFOEUyZkpUMm9IdUxiZHVPRHJFNTM0RUlEZ1NpYkx2MWdEd1Nj?=
 =?utf-8?B?SGI0TkhmS3EwWFpaVVp3OC8yQzFjeXNOTklTUktwU0NBQkU3MGNnTUhsK2hO?=
 =?utf-8?B?T1p2WVd1enRTdjNibnQzR2h0bCtGQWg0UUVQTEpZZFUyUnB1czJSME16ay9k?=
 =?utf-8?B?dzlWcldvZnJEbDN6MENiTWkrWW5vdGYrcys5TWFFSEVOa1FuQm01ZmVEc0I2?=
 =?utf-8?B?REhXWDcwaFV2Q2NsaUlNYTVmdUNXT2pQTTI4bHR1NEtOZGdwZDBKOXVGVkY2?=
 =?utf-8?B?SmxEeVBQdGtHSHVOWXcxVGpram5udDQrNVFLYmZEcnE1TUVpVGphZW5KbzZl?=
 =?utf-8?B?RFZUWnl3SzdkbHdONGtOb1c3T0pIT1QxaENoZzlreXd1dm4rNEt4RlVRZTBy?=
 =?utf-8?B?Q0kvOXNGU0dPZUlXUEdDRGR4cjF1ajhiTWRhcGpVUDFKY2NqQVJuTUxFL2Jj?=
 =?utf-8?B?cUZ4OUpzM1EvelhBZkw4bkx0SS9sTmFNVWJsV3JUWjU1SUJCeHB1Uy93SHRi?=
 =?utf-8?B?akw5b3VxSDhpSzRic2tBaEpFMHhrL3hSazNkSEtFYzNycTVyK0g0cnR5RVRD?=
 =?utf-8?B?cFlNd3ZDTHFNb0dYY1lLSFVVTzlmMG5vYlp3ZWFTT2VZZ2F4OFFxU0h1WHpF?=
 =?utf-8?B?bGhtOFRjR3FrNFhmSDg1Zk5VaFJIMVdCR0ZhTmRadm5TMVREczJ3WE44elpo?=
 =?utf-8?B?T3J6ZkRKSzQ2WkR5cjdJL1VxZDlkSWNXYThjV0Z1NHpXQnI4Mm56MGhhdnNm?=
 =?utf-8?B?MHNvOGQ0d2l6SmEvbGFuTm5Rb2RtVVR0ekZ4eFRaSG8yWTNYOGlxeEpCSUpP?=
 =?utf-8?B?bFVIbnVBb2VSZ0dvU0xRUE1CdXkzTC9LTjUzanNnQnNSbzN3c1gvZU0rVUFC?=
 =?utf-8?B?SjRwQ2hEcWt4T25iNjhRWkZYbHR5V2FPZC9BM3ppQUV1QUxHSHpIMDBVOHI4?=
 =?utf-8?B?OU9TVEdpZlhjc1l2QmFxcTBsUjYyTTdtaTdnQVduSFBPbFdTSFFLVjdITUZ2?=
 =?utf-8?B?c3VHdUVFSTBwTEhVSWo2ZnFBak1xVlNST2pkSC9hc2JZcGtmNXA5ZkNQdVd4?=
 =?utf-8?B?MUVtQW1qcCttdnI4T09iTlJKRFhDZ2ZHK2dYM0ZFaDF0aHB0RHZMZTRHSFYv?=
 =?utf-8?B?dFpTdkNKdnJ3N0hRYzVoeEUzNy9FeWJRM2w5Zmx2ZmQyZTRJUTliWHpwWG5i?=
 =?utf-8?B?T2hxZEhQNDNlM1oxbEhOaXZ3L2JYZFo5Z3JlQlFxZk1Cc0V2U3h2TGNtb2pI?=
 =?utf-8?B?dVZ5ckRHcVZtRGNaTEVhSWFNNVhGd2xORUp2cTZNYW14NXdaUXRua0ErZ0lH?=
 =?utf-8?B?WGEzbG1sWk41Q3c2dk8rQ0xlbW9lNEdGYyttNWZJOHJ3L1YyNmRrMTV1ZVQr?=
 =?utf-8?B?ek5mMi9MdHV0ZHplVDQyQ3NwVmNDYlBJYlhMNVhDbG9qZmx1U1QxaUlhemp6?=
 =?utf-8?B?Q2ZQcFVVeGdxcGZ1UlhuMk1oclRsUTRKU0Rhc1IwRW1mMlVIV2tuS3FLcDIw?=
 =?utf-8?B?TDdVQVFFTk5hTGFlaDVXa1FlMEJLenJXQWtFZnBBeTZIZFJCU0JoWDZuUWUz?=
 =?utf-8?B?NTIzNGZob2lWYkJnblNGeEhSK0czbmhhN2hYUmg0VFZUUEhOYVJlVm94blFW?=
 =?utf-8?B?dkF1bUdMNGhMOGIxNTRmQ09ZRkpHaGgzNU1tQ2k3QnQwUEZqd0d0NGVKYkVh?=
 =?utf-8?B?RTFDRHgrRy8waG92ZGxzT2lrV2xWU29ZS3lyOUI5RmxqeDdtbVNoc0xOeTdL?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f0f1bd-6ced-4b37-5cf9-08daddab37a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 08:14:27.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WO6ePTGwZcIdM0AoGu3XLWuA+DKj7D1oIcM7P4XjY4jWPakWbJZ2d9S8UofoxlP0+sGuH6K4vs5xzXR1rvriHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7372

On 13.12.22 20:52, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Make the rtuo thread switch between primary and secondary mode while in the
> RTTST_RTIOC_SWTEST_SWITCH_TO syscall.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/rtdm/uapi/testing.h         | 14 ++++++++++++++
>  kernel/drivers/testing/switchtest.c |  8 ++++++++
>  testsuite/switchtest/switchtest.c   | 22 ++++++++++++++++++++--
>  3 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
> index 49f0b7f25..3674ae2de 100644
> --- a/include/rtdm/uapi/testing.h
> +++ b/include/rtdm/uapi/testing.h
> @@ -70,9 +70,23 @@ struct rttst_swtest_task {
>  #define RTTST_SWTEST_FPU		0x1
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
> +	/** Index of the thread that should be replaced. */
>  	unsigned int from;
> +
> +	/** Index of the thread that should run. */
>  	unsigned int to;
> +
> +	/** If the mode should be switched: 0 for no switch, 1 for switch. */
> +	unsigned int switch_mode;
>  };
>  
>  struct rttst_swtest_error {
> diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
> index b6d0242de..674cdef73 100644
> --- a/kernel/drivers/testing/switchtest.c
> +++ b/kernel/drivers/testing/switchtest.c
> @@ -622,6 +622,10 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
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
> @@ -676,6 +680,10 @@ static int rtswitch_ioctl_rt(struct rtdm_fd *fd,
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
> index e9c552216..cb8e956d5 100644
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
> +	rtsw.switch_mode = 0;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -517,6 +521,7 @@ static void *rtup(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = 0;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -598,6 +603,7 @@ static void *rtus(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = 0;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -679,6 +685,7 @@ static void *rtuo(void *cookie)
>  		clean_exit(EXIT_FAILURE);
>  	}
>  
> +	rtsw.switch_mode = 0;
>  	rtsw.from = param->swt.index;
>  	to = param->swt.index;
>  
> @@ -727,6 +734,9 @@ static void *rtuo(void *cookie)
>  		while (err == -1 && errno == EINTR)
>  			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
>  
> +		/* Return to default: do not switch in syscall */
> +		rtsw.switch_mode = 0;
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
> +				rtsw.switch_mode = 1;
> +			}
> +
>  			mode = !mode;
>  		}
>  

Applied this to next now as well (patches 1 and 2 were already via v3 of
the series - I assume they didn't change).

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

