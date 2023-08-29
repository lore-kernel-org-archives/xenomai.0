Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649C63C0
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 09:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+pNDKNJyzctRYf7H799oR8H2rI4uLRxJjVbhhZi+aTCzP+gISR+hgR12ysmyBklROSZccyJ0dZG5gYwrhqLD0jYMCz0FmsPfcGN2T2belHU8yZruW64iy1LF0Nbg4z5tPid1yEHqKrMYwKsfrGoAwyE6MFtrzDYvGhfONpYd971FYTquX0LUS4dvFyWC0kbJZuJ4nkWfS/wvIs9Q4lGy0A9haRjs5n6Exq4sXGzXSIy70pu88kHeK9Tb9t8AFBjwsj/kEmB5dMHGceaR6SCgUPwdh4B1QRm1GTeB333/XM7AXmfKstqOIW+D+jR6PBt6bNQYITZo5ITAScv/BXrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxz/7EQrm0IjDCLiGIQ2ConnBx8hIXnemZC4GpDk0J4=;
 b=GlM1Zm1FSiSJAWv3zNeBJIXI+sX13O7HEkcwnPpHFy45t9aiHpZv3ivSN9ZgNkW+0OTSpig+bW9PP/Nt/xcRtfdxrx2uWwu/3Xj2bS/7Af9uCzc9GDiGGw2BQ1uoXWEU+YGhvOdZ1YTlbdhh6ZhwIu5h7LfHkE7o6UNRgaRDgGVU1ph7LM+RnWHuZ/7cDjHhK14swbXTqnA0SNhY4qxU8wgdSBXA7R9UBilNBiLaAL3Q/YZw+Z8U1K9Ahw1/1DAorgUMg4t7hTK0S2yC/0WaSBorY8PT3EGXz0v4Tvo02RHcdEopavubtGPAmUUPI1jTJ5S37c2FbigMluzB0OOw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxz/7EQrm0IjDCLiGIQ2ConnBx8hIXnemZC4GpDk0J4=;
 b=T3Gv6W00JhRF7DMrTAhUCUih9CM5TtBU9L02fNC+DIixMqLOAromwUpCj80J2MwO2dAgTgE2fmHRdQurwVJUT0NbercLGXdwx88Tfdf0nJmKQlRKPNqGeVsj6CCPPWuMQRNopKUMipmHUAKF4TBserr0j3PVaJMbtjsOSTGDjpEYpYj4mNd+GuX+77sM7fBK2tIf3bQdclZUMzCKiiTnzdLaOevqoG7UX2LETACYq96y/aR9xKcoiCwfLJ+/vzGBFwzTxOUz+J1E2tRCg+sBNlJyokEXD59QqHxXTA6J5zj6jrufYKil1rsBQ9bmkcputg9qiiuA9KqFvg2PxbpqmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 09:08:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 09:08:15 +0000
Message-ID: <9b900049-af84-471c-941a-0c2fb3370547@siemens.com>
Date: Tue, 29 Aug 2023 11:08:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and
 4.19 backports
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <5214e623-87fe-4452-88dd-05b98c1055e3@siemens.com>
In-Reply-To: <5214e623-87fe-4452-88dd-05b98c1055e3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3718:EE_
X-MS-Office365-Filtering-Correlation-Id: f3af1a9f-0b27-4fbf-b29b-08dba86f7a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6eOkt+K9jak5xpaxUE7hftgpYyyyq3kvYgjw4NIT5UDi6PMRnBWIoz6m9ZV+awsGvMiaGy03mItI1w9rQLNWBlrD/JN+KBYYIj/LhsoIcvH2DFQgWGBuYuHSQ33Y2Q4rLuvcwg4Wp6060UUWKfk/EFDfxmqrshreMUmrJKDNMtHlxJuA0JnrNbYZQjsgniLGrED4LQZddlUgqcAXQovZarWi2u40AfPwPjDIgki0vsK72NMu2cT/eoda0eJpUscH7mu2X9kzGnxabjDcKExh748o4GTT0fIsZxkoosUd504L8a4/kEYuULbpXfM+dk/tQnPLhekqrWAgD63aA3IV+CV3NPxJtnsL3X2iBD5Uqg8mMHJCLKl9gO/qx09MRyC4SblStxw8We5WOYESpxvjhAGcwUcJlC/qq7tgGZUeyyLWgcuhPf9jZxrvCtEMi2QPna9DH/4gKWUbx1s4y58SAR1Q8vWX0xaFfgEo3P1y9m0moEQ2u9thlKJH8NtTAFkgXueNJ9nU6Twqoq8rZE/YX2ETTrcZbL5vGd+9HuQgl3IXlOCx71CeVsmsV8BPWwzUj8OtmiOrHAb9Z/2scdhraO4A6CjEzGs4q2FovNPZNYjx0TXNSb4MwL4zI8s4kKDGvwvrwG+7nR9uZpqmJ8vyvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(6916009)(41300700001)(82960400001)(4326008)(2906002)(83380400001)(31696002)(86362001)(2616005)(107886003)(36756003)(26005)(5660300002)(44832011)(8676002)(8936002)(6506007)(6486002)(66556008)(66476007)(53546011)(66946007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmM2eWthaUpWcm9CSGlWdHE5ZmQ0RTFrQUg3MXNyc1UxMEVlUHRNeUZjaU1J?=
 =?utf-8?B?ZGcrSXVLdkVUQ3pRWGdsMFJJUEREVEJTaTl1SWR6blZuTHl6TkkyTVZZUzNH?=
 =?utf-8?B?MndCVTJSWUZiejFCOWpXY0QxVy8xbjRvVWJNbGdXYXRwNTViTnJzWE02cy9K?=
 =?utf-8?B?Z29QV3lMSUtoUlppMzdKZXl2LzVRNVRYZExQZ1RPOWx1NW54MUlyVUJQZU9x?=
 =?utf-8?B?em9jWXVURUg2bmp0ZzluY3l0aEJHcnc2VnhQWEh6TjlRZTJZMk84M1AxYjFo?=
 =?utf-8?B?TXNMVDBvMDBxRk9NV290NlVIQWs1ZFg2UFFwazNjbmt5SnFrT0llSldRWWJK?=
 =?utf-8?B?TkEwOWtXanhyMzdqL3c1Wk92TExUSTcvV2lxb2hOUHRIbjRsRG9DSDh4UHli?=
 =?utf-8?B?ZnRCUHo4alF4Ly9BWm52MHkzaEl6ZlFKV1FpR0pxeUdvWnZZYjdiMjhJc0Fa?=
 =?utf-8?B?SzNtU2VTeTRFWHNZZy9ubEpOOXd4ZitMN3dUY3AzUng0c3hadUNGbjAySDEw?=
 =?utf-8?B?L2tyVWFiY3dmNEYrRmFjTFhqSG5nWDZMdUovZzJBd2ZxbGZaWURhZWhIdGYv?=
 =?utf-8?B?Wm1FSzhvbnVvL3BCUmJyVXRlT1cyLzBQM1lBYUVwRms4TEI2c2V1bFZGZkhv?=
 =?utf-8?B?ZG9vWUdFR011MWFKNUEwUkNtRkVXNkh5eFVIcmU2MytDWHRPWk9mZFZRRUxY?=
 =?utf-8?B?TGVzTE1MQzJIVDBYOE9Tdlpnc0IyUFBtT21hK2RPdlNNak1uMklmdGFZMnE1?=
 =?utf-8?B?YU1tYTBHcVFvREVFVWpaUU9EZFVQWktFdzYzUC9NdDRvOHNrR054SkhpV0FY?=
 =?utf-8?B?Vkc0UHNrZ3hMZm1YMVNnZTNmenZCWUVRRkh0ZmZVcG0xdldIbndtZGFlNmlv?=
 =?utf-8?B?NloyTldsVGk2WWlna2oyek84TFY4TFRSNVlQaGVCVXltUlZ4bXFZb1VwcVVa?=
 =?utf-8?B?ZWM5NXZod1laZ0pGeVdwYk1xZ1JUV1J3cXRjZFpiT0huWHFyeGh1WXpKbEI0?=
 =?utf-8?B?c3hhdFRjSXlmMGdzanhCUHFWcEloWlgwTjd3enFqZkl1eWhCODBibHY5cFpt?=
 =?utf-8?B?UitYNzJBSElaRmV5bm1pTDRzR2M2ZVZia0tYRmtxakJBMlZrSzB4RENTd1Jp?=
 =?utf-8?B?cFZIbW91d3FoSDNaQmx3WE84Vm81WlhBSWlXYkNMV3NMN0dKOFo5WjY5V25C?=
 =?utf-8?B?VzRGV3dYVEEveUUwenJGVksyMzFZcTFOSVk4VXk4YmV1QnI4SDBaSUhPdXZY?=
 =?utf-8?B?ZThoaW9sbUMzMnFITjQvMnpDZEo4b0hHYk81R29ocWI5UCtWaDhaZW9DR283?=
 =?utf-8?B?aldvR1gzYlNHMllvZzN0TkIrRzY4cDB0dmlObXJVcVV4N0tQSjlVdlBMNFVW?=
 =?utf-8?B?Y0ZZUlFrcmw2OEpoVFBMajl3OElZZFZZUWNJZ2FZWHl4QW5lWjBXcU9QZjds?=
 =?utf-8?B?VUxKNW1pM3FQdVJGSmpUSmZMVzVVejZ6c2F5ZWZTTnpUK1JqWVVBNHZKU3Y0?=
 =?utf-8?B?ODRYMnNzQlBrdFZld0E3REVFZmc5WnpNM0NKOTU2dWxMVXVkOHJpVkkvRGhG?=
 =?utf-8?B?VkNvNWdzc0dnb1NNc1NENFRqeWtraUhkRkRlV0VyaXFzK0lkRHdzK2g2N29n?=
 =?utf-8?B?emJxWkdsQ09SSUQxRFNWQW5qMjlJeXlLazJBVjZ1dXFFRVQxbFliTU4yaUdx?=
 =?utf-8?B?b0dOblZsa0ticXpMU0VqMENyUXdMc3A2Uk05VXlvTUREdmxNV1dCeFZ4dmhB?=
 =?utf-8?B?cGRGWW5RQ1RuYVRLV1RBZmxiQ0ZUL3NnWHUvTTdFenRwSWRqRG12ME1ic2pB?=
 =?utf-8?B?ZkZKK1I2WUFLaUNMWDBUWTR0VmhqaDBVM1J2Rjh1NXBMRk44Z3dJaXkvZDBN?=
 =?utf-8?B?UzRUanROd1M0OWhheVJVRFB6L1BGcTZRZW1jZmtGSk8vQnZhaWpPbCtXdDlP?=
 =?utf-8?B?VDRTcngraDBoOVJwUDU5dlVtMk00bldCY1ljSDQrS1RuazUyTVh2N3JyT3ow?=
 =?utf-8?B?UzhsWFdzcDJFSnlNL3VoUitkV0x4cU9rZ0FxS0hXRFU0OWhJNHA4ZUswamxO?=
 =?utf-8?B?TEgrb0VoMUQ2cThITHhDemViMmhFVE9UdE5jUnE4Y1ZJd0VaNzJjR0lVbEVI?=
 =?utf-8?B?cVg0NGRmK2U5RkRKdDlrQWY0dnl4eVovR28vVit2U0k5UlI4MWFKTjh5RW5k?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af1a9f-0b27-4fbf-b29b-08dba86f7a9b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 09:08:15.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlwUAwVFnQukkUFwoLfPxGhRhXh875Wh0dcAaq5rqAhAqeFSFI8RW5VdDts5Y3wodf9jb1BNwi/or0W6PSgA4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3718

On 29.08.23 10:55, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Some stable kernels gained this helper meanwhile as well.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> index ea7ed3ad56..75a1da3504 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> @@ -54,7 +54,13 @@
>  #define close_fd(__ufd)	__close_fd(current->files, __ufd)
>  #endif
>  
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) || \
> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251) && \
                                                    ^)

v3 to follow...

Jan

> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) || \
> +     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
>  #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
>  #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
>  #endif

-- 
Siemens AG, Technology
Linux Expert Center

