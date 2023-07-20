Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A952FA20
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 16:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4SIIR6dZsJDibi3i+HD24hOKj9IpL81W+u7esotTFlu54DhkcZ/YFe7VpjDHaLoMOKA7jkBlR5b8Qt6dVQ0V/YAICZr9Yc5x3Dw2QQ6h5znS3b0zx2lGjMJeKnFWIsM9WK2nFKMov7Ccsvu6MwjOmIfPRnqJeUDfv2Qn+aCocASCg08ATDeuX/TI+P5AhiQZQ6Ep4Ih+86c+mSqdpPilIA7LMKtPiCdzD0IJPCzs/qt3xvDgGD75jCyalpC07rvdQs0rYDyl46Si34nPaRresx5nwtWrRiRqtCQx9DrtMdGdFy/hfjI63RxNAAcFJCXlrdbI3rMxI0H/LEGYJc7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMEIApqqxogutNCrZyNGait0X1gAJjVIhRTHJr2/QuI=;
 b=Ipoc7ZtnRH7uJlyg3ibQoY+ghYzr4zFyPtL4zLoiL1GZgGgK75XeUR3+d43YKt1RmsBl/A8eVf0QzoKgdeUlCkzhn+N62gJOhMtv3J20Xm/WBqx28gAKT0jSPpHU2vjj4nkvP0ZmGVuK75/X6bUBZ/R6ECNZw8KInZ4OUdfKQGRNm8nrViQCcSDVWZEPM/HwKS+bdr3zo51GnnyGHOPgT4m78j+YK3YOtAK1Dofjs7/e4T1kUHSG6JIfUesxdt+4+44Lc7FlZpCcOLJ7hi5GnXuiSdqGwa3QszBFGBTznNtACDGZXZlnieb5Bm0G3MqFdDDKLxpmPt5ysp/N6wqzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMEIApqqxogutNCrZyNGait0X1gAJjVIhRTHJr2/QuI=;
 b=OHtD3T3s4hpH/BZbYKcUpvxc34pjP/PmkX1FdZHZ1DC/7CwIIWlQ0XHSxgi9JqEq63Q35iGVd7CPF4GeSGLL8JdJsRv3296V2a/3sVT4R7Il2TdJg9WkuYBBXa0v9myH9RnSu3ej8xObaSmOflyevvuVr9bZiqUzbrGeNId9kAWLN9x0etjrRM7ovuQ67pBLOzmZ/1kIa6T1sKPq/DUBDBYDQDJR/fPPud1Cf7/+6mVNhhiqMw6T+1IPpdisZtlcTxKElSoCLECuct2hWpvKu4/syKOCf6/hWp5I/BaSmfCQ7y8jplwMCcJ6l1LkUgHsv4mRagR3Rd4yLCjqDmJ9Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7435.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 16:37:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 16:37:05 +0000
Message-ID: <cc04e011-056c-08ef-57d9-57c14c6a6758@siemens.com>
Date: Thu, 20 Jul 2023 18:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] cobalt/posix/syscall32: Remove unused
 mq_fetch_timeout
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v2-1-b4e888eca2d9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v2-1-b4e888eca2d9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e87da2-bf80-45fc-7231-08db893f8d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FJYAjAbaoxu3PH1J1fnYY/SIyKg+U7jOgew5jHyI3cm3iiKYhTqDOSfCLWAZsdpx4w/6O2uN6WvLKfKhH5ShfWY/kDley6SE2yo3+08wx5ZaxTOrFTP61AgABah8aAYUo2tSNAyHr54fGDWgYpv6qSzhtVRa12flt0ScjM9CBXmcL8V8GpPnUK4cBO1ycG659b6ImXCaokueDo+/sY8M64UuZ6Jkiwtudt3llOd8Bl5km4Q8XplDKmbzYbukKnXzF6BPtpL2EShS94IrQ0Lt+1V8w1TFJX3avOQfYtVXYqOH8DuuEumt8In7/9MTbVJFpBza5jsgzztUO+tYj4c7BOWUnFygh5lMhz6cffAc3jGxbEU88F2dAr9N7SCTfnpRb1VLYKbA0C63Bf08TOCe/oQtwm7n+H/82qkxWfdhubJCA0KamGVLAMRugZBDRyEDsv8GlszIEnWsiYkbYjzjmKijo7XyZGkneqtJ5UJgQP+UNCUHAggs/1the93HEyUmbuSaJmFs17tUUNnSE+7zyR/m/a/0Q1k7XHNHjIAa4P8VU7Ozi0pSGyNA+lVdW5NjYk8SSg7TOFunOMstk6dWKGjXrxuDDGb7zfJQdJiuzUKNLMN496W4ueGCcoLmDlS19ssOz3naUgLmljHWRx8tFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(82960400001)(53546011)(6506007)(478600001)(26005)(6486002)(186003)(66476007)(66556008)(66946007)(83380400001)(31686004)(2616005)(6512007)(38100700002)(5660300002)(8936002)(44832011)(8676002)(2906002)(41300700001)(316002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzN3bUpNV25DRVBBSjJDSDd5bXpYODVibkx5RjA2MUdrOHp3dndIMFdFaGpo?=
 =?utf-8?B?bjZxZElsdm1JeDBnaVVlMFpSekVPY0dERWhsWFh6Wm5jSHY3dHErWFZZK21n?=
 =?utf-8?B?QWRkOXVrWWVOSkltbkNLSHgyK2t1TG0xYlBPYk5vVjFiNk10dy9BblZRU0h0?=
 =?utf-8?B?R3JnMnBFVS9HNDA1dFMvK3VsUXk2dVlPVW1aVDdMTnpGRTBsZHliQy9LY01z?=
 =?utf-8?B?dENEdzBzdWsyd1RNYjZIYmtBMXNwN1NhWlViOTRoUFV0SkU4VGdvblNadlFy?=
 =?utf-8?B?S2JZTjNCUnZZU2ZGRTREMXRlVXI4SWgzWlVONENocVcvSjJKOVVYZ1M5YUhE?=
 =?utf-8?B?QkpGTlh0YWJrcnJiZjMvQlUyQUtyU0h0enlROW5veVo3L3EyK1libWJ4Mld3?=
 =?utf-8?B?OUtCdTMyS0JNNmNnZmE4NWYrM29JZ2FQN1l6UUdaQWhEYkJTU3BYYkJvVTBQ?=
 =?utf-8?B?Y3NRdlRMZm9ZbHNRK2NSQm1Cc2hPS0EzUVF3MGZTZjJrbnIvYkFaWWhxMU0y?=
 =?utf-8?B?QzNvSHZGTDhSb1EyQjdYM3RYQWdabjgxL2w3S3lBdWgzSmRlYnF5K2tUU2VL?=
 =?utf-8?B?K2YrSHBhazY2eGtoK2RtTHhILzlvajdJSTdRYUJIMnUwSkl0SUVVUUY1NnpZ?=
 =?utf-8?B?dkJhemN3aW9GVTFMQ2RZZDRkUy9xMmZWNTN2ZmVFZWh6WjRrSXg2bk5vQjJ3?=
 =?utf-8?B?M2NvQlhuYzg2Yit4MGxiYkhyMXdBNmdSZ2phNkl2ZFBWdlJ3TUJsSGpSUW01?=
 =?utf-8?B?SWF5QmJJMXFzcjdPNmUrcStXa214YjJnWXQ1NkN6eVhjQVJ3ejRhakdzOVNM?=
 =?utf-8?B?SVQzVndveVp6QkpxTlBza1dNejVKZjJONmh2ZDJmYVhDWmZVNzFrb0tNOW1N?=
 =?utf-8?B?QytLYlZhK1MrNHZuU3JGTGlmK0x2cDZ1UURjTzhtODVYSDNmeFRNMjNLMHVQ?=
 =?utf-8?B?YURvajE5NFB1YmswQ0NlRThTWWlWcXBmL1ZzZVBkSG9yUDlhaUpxbklabzl0?=
 =?utf-8?B?eU9nNElwRjdTWUdZYXVQOUxhZ1pMUVdRcEM1TTl0bG5ENHR4Zk1yanFwUUxX?=
 =?utf-8?B?cEFOOFhtUGNwaXZwaUY3eGJGaE9LMnVwUStOWGc3VERqa3F2RldoMklDUjQw?=
 =?utf-8?B?Q3BFeDAyVW56S3B4WkV3dkppelg4eXRMa1pwczgxS3pEL08rSDBLTUNlRWlq?=
 =?utf-8?B?L3RVMWxMaUkvRGdZcE9hL2N4S0RlcjVDVTJVTEJIQ0hMMFpFTjdIamRjdmJx?=
 =?utf-8?B?U2dmUkcwNEZxcXNTdFNWOXFnWkZLSFY4L2dPNnhrUWNLTXdsYzl5RFZKTFJK?=
 =?utf-8?B?M0lseWtnR1ZCdTExL0JvTFMyejdzcDR1U2xtQUVPcElZZ2EwRUwrejdzakZx?=
 =?utf-8?B?VThhdEZpUy9ocDkzUUZ6bmVHZEI4eFQzbndFYmRZK2FvbldidDZ6WG5BWk4v?=
 =?utf-8?B?c0ZhbW9ZOXp1MC9SUmhza1pwMGl2Z0pRWWtQblpWM2c5YTExNnFiblFYejZr?=
 =?utf-8?B?bTQ5d2w3cXk2RWlZWTg4ZDJSVkw0YU9PeUU1OWtRc0ZSU3REZ0lKbytrUk15?=
 =?utf-8?B?QTRwUGxKOUYyNFh6Y2kxUzEwZ1ppQWZsQ2NSTlQrVzc5SHU5TEFMNWlsS2pv?=
 =?utf-8?B?S2tOQUNPT0d5emNQOG9tVTRFdlR4cFBnUkd2YUMzL3ZzSjJuai94bldWSVFV?=
 =?utf-8?B?cUpxL2F5MnNwczUrSkoveVNtL3pHejM2REdBYk5zL3RpUmwrWXVnamdMN3V0?=
 =?utf-8?B?a2xocVhSZnNYMHlLSFVXZUxQZGlVWFFSa0YrZGNMZG1iT1FXeGVFRXU3dkth?=
 =?utf-8?B?Y1lWakVWRU80aER2RGFHcTBqa2lzWDBFZXdib1g0aVZsUndDNUN1T2huUi9q?=
 =?utf-8?B?eENFejdtbEcrV21TWVJ1YnZxakk4U0U5NXVWYzdVZ0NRZEdaYk83Njk3cHUv?=
 =?utf-8?B?aUEwblJSRzR6VDVlVnpMcTdvZVFTM3FraVhOOWNOallZZDVaa3Z2ZnBGUEJr?=
 =?utf-8?B?VFQvTGRZNzlKeW95OTBWbHBkemtCV2MrTGlvSmNMeWh6eFpSRzB6djd3TTBa?=
 =?utf-8?B?UW9XRnRtTnJZandmQnE1bnhOLzV2SnEwNnVISDgya1B1eUFTUFp3RWQvbGJu?=
 =?utf-8?B?ZVY3OThWSTc4YzM0bDRkeUVTc2NXVlZ5YldhSGEvK3AwYktTZlZranB1RUJw?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e87da2-bf80-45fc-7231-08db893f8d40
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:37:04.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUf6YMX6bPVG8VcRjk/iuty7bWVALFkaWiyGOMGeMX3e+jGhK9B3pCnlwXaI4/u/Awupn967b85P5+YfO5J3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7435

On 17.07.23 11:10, Florian Bezdeka wrote:
> Removal of unused (and broken) code. Using cobalt_get_u_timespec would
> have been wrong and sys32_fetch_timespec would have been correct.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/posix/syscall32.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
> index 780d276b1..c82cc60a2 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -318,12 +318,6 @@ COBALT_SYSCALL32emu(mq_timedreceive64, primary,
>  	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
>  }
>  
> -static inline int mq_fetch_timeout(struct timespec64 *ts,
> -				   const void __user *u_ts)
> -{
> -	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
> -}
> -
>  COBALT_SYSCALL32emu(mq_notify, primary,
>  		    (mqd_t fd, const struct compat_sigevent *__user u_cev))
>  {
> 

Applying this cleanup already.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

