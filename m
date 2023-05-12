Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68492414A
	for <xenomai@lists.linux.dev>; Fri, 12 May 2023 15:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXrKNVH4dCIbSZtS4SAKLvxuyXjXmHBSGRug1MriNuuordV4Oiy8pthmLpF6kVyxiTX+H2r9o4Ry0j40rTIhlY2tjhHccm9jLa56WuoF7bQVWnXuKL9EJx6yz7zNCSqxLmN5fhWOeHr9T2HsH6DSlaKCgfQo7nG1h4CjBKzEBaetlLERKJOom0AQ6EzzuaNY/dCdwH51JbsNVA5fnRUIT9hgenwhqN5J3pnTiDLPvQ5XkLPoDbKoMtYuf6cLtzFqBHLRa9Ono2kbL4fRbU0E3y9GBpJen5FkTUJ7ZK4fAFJbuCK2hdHPRL6XH2CHELZMBpoFapK7GeykNfwya+qNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaQoZ7k36XLfCoTC/EHlG0O2XCkFYmrAAP8qGTIZMx4=;
 b=FuXUrw3HSyTHdalRnnXzsQeFqmrDX5yORUfU0mO+DcMwTW1UKF23iXLbc5WfdvHbKvCdcZMAAMno5zMSP7frviY51DIJXUm132hBwec8W83aBSMYc6KdRR+/qTY69Aj8Vx0X7kgh5o5ksveVehHtD9u9l3DT2a01+Fa8g5pvdRQ6KDhZh5yja4gtp+opgYG0IDJJ5vz9yfkWevZvneaoxAiZTIcfWjpI0xa4bJy79+et89hYcw7eGVIkcu8LGAhWIGk4ZfhD4qF1oDpJrzDOUg3IkVFVDuHppk+Du9jOyon4/iCNN5+vfzp2v8MWjAsF6n3dt8TRoS4rcor28BxTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaQoZ7k36XLfCoTC/EHlG0O2XCkFYmrAAP8qGTIZMx4=;
 b=Lo9fdkwvNtSozy+derGex23d28y+ygwlQkogEf4wkahWCBDoVPN28uI+MiNEhmaZ8SgdcPCj52bV1CAdy4/ArN47L77bzeJ9JSkmfusIUOOosKojlk+S/g03EFU7R19VlFgSTlsRgbXZWRZd2qr60beId8ugSO7Tu+rTNhYBfF2Yo6Q3GdzKvonrhIotdjx9NFo3P6++AtLA7BECyKvocB7j39nxN9oJz8VdSzNVDE+KlR3ciQUwmAmNCHDEp8huieQtSV4bAl5QyPIP+6Ak5WjdX8UPguZkpTa/3afN5PiVFl4D/mzxMpUpd9O+xeQo5G56kjz+Xg3idYJawNhmIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 15:59:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 15:59:11 +0000
Message-ID: <9693dc1a-1606-652b-29a8-8f1a23b9cdbd@siemens.com>
Date: Fri, 12 May 2023 17:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/13] y2038: cobalt: Introduce some itimerspec64 related
 helpers
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
 <20230508-florian-y2038-part-two-v1-1-a417812fba85@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-1-a417812fba85@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0867cb27-7772-4df8-a328-08db5301d33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mnAeR9oY5O0YLQiJ2ST/z02Gef+p+D1YUBMnh1g1PS96HlRt0qi3XDGTWWiAQrVc78WXchdPbeU+DLVytn8+nZIgpUQFW3GlOn0ZG3XMpzpDM9/uY4LaxaAzHpdw11fYcQ7/9Eo+a1/2u/x5ju4mD9IlHg3u9MMnLwiqRUyYtQKVmpKLQQDdwvrRS0LRRqHPtfHSBqHHEy5ZkD8M2laj6U8je8P+gcmWXsusOQORFpH9OAIclEsEWWYFVD3Nz1D6E9LAvAvMOzjBoOYhWpQ3tqM7nn5pl7YTo1Dy3ip21jkUtV3MXkrf0u+Gt+31ftJSwp8mpX4ZVjrIRCv+GX9g1e9p6WUWlG5WFiabCohOlntMvOenO9QKSAWbjBqATSlzfNDT1WSOxlekhzxGdviKGq9MiotWoKiSLYMhUg/PNFyjBqqRUViV7halAllatLyzKQV8VdMLvOEQfn7H1qnpLK1yrtJB58pFo2U2NJFVH5JD1WeGCRNZS+To8nnT7uqJ7Wf7g2IS3WHqun0TPqmCouTgb/dpy9P+SFFfFDE50vnOZ+1O+IpzmhZjquCiEXRCZ1fHxB0Rh2kiQ779JxUu6TyG4o9kaBxbVxANGcBjNT9SdN1ntuVTSfwxY3nvkIuK7lAB1YX3MIchJfm9SKRiiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(31686004)(6486002)(66556008)(66946007)(478600001)(66476007)(316002)(31696002)(86362001)(36756003)(83380400001)(26005)(186003)(53546011)(2616005)(6506007)(6666004)(6512007)(8936002)(8676002)(41300700001)(2906002)(44832011)(38100700002)(82960400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjQ5dGlSWVdENkFXTUtJYUVWOU5tZHZRaFFPS3lvaHVuSWR2UjJNM1Z2cHhW?=
 =?utf-8?B?SlZHYUFyc2tDc2VMcllwLytlamtOejljR1pKeVNmYWY1Mk1nMGdxejVWL3NH?=
 =?utf-8?B?K1BLNzRkMDNDblBvc284cUZOWVBsMUg0VmZNL3lqT0I2WHAzdENYcVhUVGti?=
 =?utf-8?B?RkpMZlp2enFiOS9TVWhCN3NxQ1MyNldST01pQU45dkVpR2JoMHVzVDRBNkpF?=
 =?utf-8?B?eHZuNWZJRytUbGdOanFGU0FWSkUzcmV2bHlpTnJraElnMjNnenNJZHZZOFRR?=
 =?utf-8?B?NDUzc083TmNUVy9LNEdlamlyUzM4RURGajZvbUtDWG9VdFc0ZmpmR2xVK0s3?=
 =?utf-8?B?OXlnTk5RM2dIdlBld3cwSy9rN3pmaklYeU1BQlJsMGo1RlFMTlEvWW41UW5S?=
 =?utf-8?B?RGJvak5qOU1idExDMmZ2QmhQVTlnQUprNE9oclNVQmVueEYyMkpMUm5VektF?=
 =?utf-8?B?Zm1USzlodThmZFNMaGErYXAvMllKQmVrKzBacStCb1lSaHBvd000Ty9iUGMz?=
 =?utf-8?B?QTJWb3NvVzZhYitDTW80bFdmaHJlWHhXN2ludmhrc3RLejFtaC9qSWNBUGVO?=
 =?utf-8?B?K2xhS2FzSEVFZ2ZCRmlPTWdPdVlVRWhKLzhhVEtzUjIzOHUycVpvOFNkV3I5?=
 =?utf-8?B?eG00ajIrUXBlZzNKNDExNFVzZ2srNy94bHlPNEtsNTBPMDEyMERXRElhQ0FJ?=
 =?utf-8?B?ZGJ5dlViaUdMV2t4NVo3MjhwUUZPMjBYYjM0di9RdEtGUWtzSkJzbjBWTHRl?=
 =?utf-8?B?cnRBNkQwcGxSMmc1cnNzMldHVUU0bFVCeS9leXk1VnlFN2Z1YXRtdTh1Unlh?=
 =?utf-8?B?UW52dm5lMUh5WDkzT0NCdUxPd2M4NjJvNnkvVjJrZVVUaVVxbEdEd3BOekJi?=
 =?utf-8?B?eEFodFVlUDFtZFVSY25XUEVib0hKSDUvOERiSGpGVmtiQXV3YXNnZExWK1FT?=
 =?utf-8?B?c0FsdDFudGpJSTZvU0RyYy91VXY0WUZCUXRDeVFHKzc5bUltM1Q1QzJQbEt1?=
 =?utf-8?B?Y2ZqV3VseDB1TkkydTFZT0R3WDl3WE81czZzNmpNNU1HVm5Db3paTHEwSVNk?=
 =?utf-8?B?dHNiQnY5alg3bUdubTNuUWJDbWpuSFhaamtvbksyc1VxTUtKb1N1VzNPMGp0?=
 =?utf-8?B?RjV1akVId0J0SnloOUUrQWtrMzIxMTZIYVJDM3o4V3FHbmJtdGh6WWt6SVVs?=
 =?utf-8?B?S2pKcWttWmxhVzFCdWc0OVc5VndLUDJHc2VMSlZ0MDEza3NtQ0tOaG0rdXAw?=
 =?utf-8?B?aDhDUTdyYkpSVjlYVXBRb2tQZXV4THFIMUw2aFlsRThDYzk0QXMwU1BWeEZE?=
 =?utf-8?B?b3RZdmJFWmNRYnVyVXpNcTZwMFlqd0ZsajI1WGF3OXp5VC94OW5INnBHZUhr?=
 =?utf-8?B?VnlBTk0vSDVHNGs4Q3NkSi9RYyszOEFMYTZVSGd6dEtoRUI0bk5xVWhjTVRE?=
 =?utf-8?B?bkV5ZTRpUWF0Q1BnWXdvR2VEQWFYYUpkaDI5KzNSQUZGdGhVTEphZlh5a0VK?=
 =?utf-8?B?WlJQaEhnbmFsbzU4V3JEZkptRnZndzVEUm1CV3paZlZhVWcvenBFWEdiNG5r?=
 =?utf-8?B?bVAxbXcwd25oU3VSVEdmeGNwNnNtT1FqV1dyNnJFbEtVRnA2bktiRWphWDJN?=
 =?utf-8?B?MkY2Z1dMOUNhOTlLZ3MvK2RwRFJlUmh3aWhreEdzT1BHVWErQUUrSHc0bHA0?=
 =?utf-8?B?dEx1TWluT29rVXBoSWJ1TFdIaUxWZThVb2c2Z2hlYVlVSHR6WDd4ZlZwMUoz?=
 =?utf-8?B?WkNrOThQcVRvRVEwZDA0T2d5UGdVUFBuWktaRVE2d1hDaEJOK1RDdTF6QmEw?=
 =?utf-8?B?MGl5Q09qdWY0TzBXbnlhNTFnRkdlNmF6UjFZVWluRllvbnJudm5FTXRaOHpH?=
 =?utf-8?B?TWVaRFpOKzU0Y2lwNjFvVEdZWE1Tek1EaFRaZmFDdklyVUlRQ0t6a0s4cEZP?=
 =?utf-8?B?bzhpUnh3Yi9WRlcwZnhoSTJsTkFWQktuaVh4dUdmRnQ4RW1TaTQvL295Nlkr?=
 =?utf-8?B?QkZKWGhhNExXcEVtcERBNWRqYVRDOHA2NkE5bEw2clFaTlVLNmdWZ3NpZ2ZR?=
 =?utf-8?B?S3BrSE5Uc0JMaXBDcHJNNlBwdGVEbFNnbURnZWJVc05sODUzbWlDZXduemg4?=
 =?utf-8?B?cElDRnZ4K1BVNmYzNEFiRGVXTG02T3kzdC9ia1k2emdOUFQwcE1wMXZwY2VH?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0867cb27-7772-4df8-a328-08db5301d33d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:59:10.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4FqpsmRDb6MQZaGrepMXRCLSFp7Loz1/tW6mDoZ49CFw2PjgXIENd7o7JXuHRdX3XiIFT7EPf7EMGSDaQ0n1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5311

On 08.05.23 10:13, Florian Bezdeka wrote:
> The introduced helpers will be used by the timer and timerfd y2038
> related services for reading/writing itimerspec from/to userspace.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/time.h | 21 +++++++++++++++++++++
>  kernel/cobalt/time.c         | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
> index a55398068..e348cf9b8 100644
> --- a/include/cobalt/kernel/time.h
> +++ b/include/cobalt/kernel/time.h
> @@ -28,4 +28,25 @@ int cobalt_get_timespec64(struct timespec64 *ts,
>  int cobalt_put_timespec64(const struct timespec64 *ts,
>  			  struct __kernel_timespec __user *uts);
>  
> +/**
> + * Read struct __kernel_itimerspec from userspace and convert to
> + * struct itimerspec64
> + *
> + * @param dst The destination, will be filled
> + * @param src The source, provided by an application
> + * @return 0 on success, -EFAULT otherwise
> + */
> +int cobalt_get_itimerspec64(struct itimerspec64 *dst,
> +			    const struct __kernel_itimerspec __user *src);
> +
> +/**
> + * Convert struct itimerspec64 to struct __kernel_itimerspec and copy to user
> + * space
> + * @param dst The destination, will be filled, provided by an application
> + * @param src The source, provided by the kernel
> + * @return 0 un success, -EFAULT otherwise
> + */
> +int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
> +			    const struct itimerspec64 *src);
> +
>  #endif //_COBALT_KERNEL_TIME_H
> diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
> index 27dbf8290..716223dc5 100644
> --- a/kernel/cobalt/time.c
> +++ b/kernel/cobalt/time.c
> @@ -36,3 +36,41 @@ int cobalt_put_timespec64(const struct timespec64 *ts,
>  
>  	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
>  }
> +
> +int cobalt_get_itimerspec64(struct itimerspec64 *dst,
> +			    const struct __kernel_itimerspec __user *src)
> +{
> +	struct timespec64 interval, value;
> +	int ret;
> +
> +	if (!src)

Can that be enough to validate the pointer? Or is it even needed? We
must validate it via cobalt_get_timespec64 anyway, no?

> +		return -EFAULT;
> +
> +	ret = cobalt_get_timespec64(&interval, &src->it_interval);
> +	if (ret)
> +		return ret;
> +
> +	ret = cobalt_get_timespec64(&value, &src->it_value);
> +	if (ret)
> +		return ret;
> +
> +	dst->it_interval.tv_sec = interval.tv_sec;
> +	dst->it_interval.tv_nsec = interval.tv_nsec;
> +	dst->it_value.tv_sec = value.tv_sec;
> +	dst->it_value.tv_nsec = value.tv_nsec;
> +
> +	return 0;
> +}
> +
> +int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
> +			    const struct itimerspec64 *src)
> +{
> +	struct __kernel_itimerspec kits = {
> +		.it_interval.tv_sec = src->it_interval.tv_sec,
> +		.it_interval.tv_nsec = src->it_interval.tv_nsec,
> +		.it_value.tv_sec = src->it_value.tv_sec,
> +		.it_value.tv_nsec = src->it_value.tv_nsec
> +	};
> +
> +	return cobalt_copy_to_user(dst, &kits, sizeof(kits));
> +}
> 

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

