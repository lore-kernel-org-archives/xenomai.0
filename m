Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C379F3
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 21:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjJWo1fI7qb8AE5UWJMh0tdvejWq90WaYuHcS5MDUHl6nNYoAUvPoOTMthWMDLeFmSQWaV8yIlbIBlrfrGceUKDl0rrZxntqLTT1UxRvlZinCvB5ab+qR1CqRK+nOuLUCczUQP8P45jbw/A+SPhA+rHoDX/oufE6XDV0SvvUGaYmfKiiW+zdX3oxzBbhD9dnCdtuk9gkBQdcrzFTXq1Oyj26eY1l4pKJnEWtLe/0L5eZdNXG+kFX9bZDrxhfWgs66B+bZiCc92U/YVkXrAAEcGCUpLfkiPNfaLJjwFHf9OQiQmFh9vGzc8iQEsUKdDs/iK1iTW0BSbbZF0FrBuFFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O35gIJ844HBcxyoXtyB4fyu11hgTtuniwTIZqfg9zcw=;
 b=euJCfEeD3HjZzhFdvhHatO3BuXSlogwTvsTQTaocvyGJHfM2/c2g+IIpBgvIvukYIbcFQ9+uuQIytKgnQyy6uUfkk2wT4pRmUjxa1jqiO/0Bj/ARd2czndXCOWRsncAUMWrS46rerqoAeHAXYoOPFtAZbL1+6pzC4pCxxfEB3ei/x4ILeWy4EFg46D1jWOPobzZ0Elq7kT8NM+3kP3daNkFdHK/NgMt/IFLm7TVpI1LvGLSh5sbsn2Q8XeF74xTQ7fy4rOva/vqSFU8pDJUCeHzNkbuRBoo79MhVYBYFt+QJJKpmmbbbEMThIW/+tfuGqfqtNa7SJwbBpB0O/x9Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O35gIJ844HBcxyoXtyB4fyu11hgTtuniwTIZqfg9zcw=;
 b=T/Vki38SBlxNSr5BrE97n8EXlarJQnB81VqIVav6y6btVPXIkcMEaRnWAT/ujt8/3T6Yv9cSlufkrShEzi35dHYrLaosoU9bVKBSq83nN6w8OmfSHYQq1PT81egHMoBqsJ7dLEyebvGSSCarwmJDwWxddvwjGdgHeCFMjmHoSvRXs2Yl3g9UYs47JgFxPA9mkths++h/lzh8lI/bvPY8oGdTM7sPLB9DIeVZ2C9hvc1ORUTiGoCmNolzO1wZZRTzHXatIE69l5b1P2u7/OJxYdi2EzEHGS7wOJl8ME8k5IA4/dMoQPM5ShO+z+ktK+FAGReCjpDiikubDxqFN4y/Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 21:53:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 21:53:23 +0000
Message-ID: <ac07d7ec-415d-6571-1c71-7c2aa9917ac9@siemens.com>
Date: Mon, 14 Nov 2022 22:53:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: rtser_config and compat userspace
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <601440741.237005.1668456855365.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <601440741.237005.1668456855365.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3243:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b9ffdf-91b5-49d8-bf41-08dac68aa6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	88wnERmUUUW1krNJykZld+CNbV7unw/Smf0QTZaTFA5dWPFnPRB0U4WMJaArCTDOzIfIxA31seI7s1YaA19XR3XOPIoTsKD3BALIBrh3AOex8nGG7eBlekZBuUz9p4Sr3fd2afnO60z021ys5wDQoSLK5nukEWWIa78na751BZ5V9T5/mRlO0UGjxkAGePfhxyUQdKKsiaWD6TV4FCt6/E0qDzIpszlXlbEnJ1XCsfMHtrqE6vkpIP3aPHU2nAkz9dNxK9E6MhfL/idM47aKkYZtI7AEDCcS3dr07iJQo8Gq45/hvzUemIFg3Ylan/5bEC/nQPkFk1cyfHJkT8kObLQ5FbqHLxmA1vJGG0GOk4Mxfpy3vP1A6lCDmF+qMq9EkzBVqw2gvkHytVrxWgDnY4t2HrQYL4/364LNfs7Xt/utZn2M8SiH+Drqq9GY7haKBecT9QuXSQWAAkZai3L/n9cO8gFsw30NP2PzGxgJGBVT20xbZY77TtTHbpfLAEQSx6LOl/o8OmZ9Hyr7ioVPNjvKhVPiGG5gtiiMOsEHDLtf88VxaZs7LlYpMmKX9ptJCuP0WsAzFrRfHYD/Y8rfmveJW50Qsr7116DN40UzHQY2lYgDMZwZHRhEIb3q4JtdrItS5b9X8IsCjxVnb89mC0LdecozBEw30gpLxpBPhy31lyj9YgshyHb9Pwq4J/td4lBySEqty5leyrqEfdDIrz6/bWwnlvIMCgd4lUXCe3fjvLgJEsyrJNZOiI7u0wqUfKHXKKnxdUrV21BQQZ4zOiNFPalW6NgLqODpY0FlL9K2njFyv376hp/ihtfiq8Bf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(2906002)(31686004)(44832011)(66556008)(66476007)(66946007)(8936002)(5660300002)(8676002)(41300700001)(36756003)(26005)(6506007)(53546011)(82960400001)(316002)(83380400001)(478600001)(6512007)(186003)(2616005)(6486002)(38100700002)(31696002)(86362001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU9IcHBxWTU2SUkzaXhDMEsxc0lXZXpsQjZLTENicVlMRXRadERwU2FWNi9w?=
 =?utf-8?B?TEtUNXllRTBpSHpyTTI1S1NNSTFSanZteGVlVUpxZXBYNUFoS0VQUkJuLzZC?=
 =?utf-8?B?TGdhRVdJbWZSN21kZHpkRnZBN2c4TkdBZGlINDlVaitQTm1iMS9rRnQ5K1dn?=
 =?utf-8?B?T05uYk4zV3cwYTJ2ZG1oMmdQblQxUHBKNitZTXlVZWtSdzlPcWJ1QzJpUFpO?=
 =?utf-8?B?VlB4VG9ETEJBcld0ZGxhbE13ODA2UVQ2cWNJT2oxbDVSSTUrck50Y0RTaU9y?=
 =?utf-8?B?dGpXZVFpUFdaTEoxVyt4OHVKVi8wNmFkZDEvN3hPM1lSU3J0N2ZsZHcrZmxt?=
 =?utf-8?B?cXJHSFZUWFRtanR6Q3NpSVJ3cjBnQXJ3bzI4UmYrSDBmalprbExhaEFoY2Nv?=
 =?utf-8?B?OFRrZnJ4RkNoTlpsVG91cDI5eDljdkQxNHoyQXlIUlQyUXcxOXlTZGljQ2o4?=
 =?utf-8?B?VmEwcXhjOStubVpzZ3grZ0pmTlZrejFTNGRXb0gxQ0JwdlowYlVTRGVGaFpW?=
 =?utf-8?B?WENubDh5REV1amN5YUgvYzdYZ0wyU1RGSGV0V0pyMURnL2hzdHc5d0hxcXBz?=
 =?utf-8?B?eHNteGZ3VkV5SDJXSlhXSXByVkVGYVRpZjJPTzJHNDBhejd1WUpOZ1YrdmVE?=
 =?utf-8?B?REFmVlFreTJxcGRyKzNLZDBSbnVTL2dYSTZvc2E3aXBXOTg0SFFVTlBRR3Yr?=
 =?utf-8?B?NTdvRUlmbVQxS1FtMmFsVGRtNXV6ZlMrZU5Ud1FWQk05M01kY1JUNWRyKytt?=
 =?utf-8?B?cHdCZlF6alZuS2hzWFFkZnZhdWtOckxSQTBCWjFWWER1dEVKTzBZamkxUnNC?=
 =?utf-8?B?RGNSNytSdFVCbjFoeXQxNnRQTVFaTXpNZVp2aUFldlZDdHB4USsrS3RHdEJo?=
 =?utf-8?B?eWhrc0RCa1B6MFhIRWtLL2VoZTdldXBxMW1lNEVOL2N0TDNtbTc5emo1UUI2?=
 =?utf-8?B?ZjcxKzZLNm41dFFyQytIakR5eU1vdXpPdS95VWxLMDJ1dEFBV09IY1VsOEgw?=
 =?utf-8?B?UFhsZFFWaDNaelY0MlF2VGxtdnZkRXpYWGc4TnJCQ0sxN0xMK2dDL2dYWmRI?=
 =?utf-8?B?YnZ3WkFXdy8zeWNDdXpYaXM5WmZjYXhUSmlQVXdibEgvQUd6NXdyUXR4NHF1?=
 =?utf-8?B?QjJmVldEQzN5SWg1TjVJWWc1RjZjejgxbURrL3grb2RORmlyYjZlZk5VREMy?=
 =?utf-8?B?ZTRxR2N6YjJYMGtGV3FiL0g3WjEyQ0NVK0R2a2FzZ3RwMWxaSEZoZUxSOThw?=
 =?utf-8?B?UUZJcDhmWmM1eVJNd2s3WUpIMFM3dTRYTHVJaFUwbTZjMHBuaWxWK251KzZi?=
 =?utf-8?B?ajRGMGFERWpGeGl6UGQ0SkM4TGRLQVhZS2Y3Z2wzTHIxRlhxNUVOYXVJSE9l?=
 =?utf-8?B?clpJWVRaQXBpejVvUHByK0RQVkhCS0NYMy95WWJTQTFua0RyOFhWMTN3ckNC?=
 =?utf-8?B?eVlCMXVXaFBjcHNzdUlnZlAzMTFWaUduOCtNNmMrSEhGTVJvVGNranlZRVhl?=
 =?utf-8?B?SUwzMHhLZ0hQb3J1b2RLcE1nWUxDWUdTZ1ZqenZ3Q2dDVkh2cE9aTjFGQUMz?=
 =?utf-8?B?R2Qvbld4Q1NNMk1uMmtQY1RnWUU0aTFRZUR6ZzQ1U3pFRjZ6bmNOYmlycDJn?=
 =?utf-8?B?VHRDN2N2cnpkSGR2ZUdxVmZUZ2p0RDZjZjlOSE4wOXdqRkJuemFWNm1aSHZW?=
 =?utf-8?B?WXV5MXRXbGpOREtOanlHNzB2akJUTjl2NXlvT2JuY1RwRWxGdXd3YnFTQVlZ?=
 =?utf-8?B?bHBiR3UzSDZIdFlhTEVQM2hOYzBsblJybEhHN28rWWFuWG11bldnamZ3eXJ3?=
 =?utf-8?B?bHloS3RNYWhjMVlGM2Rwc3QzZC9NMDE4WkpNTVo5dzZYRENmTjdKbmtRME10?=
 =?utf-8?B?aTBWeVdLcTlvLzFrTU9kQXhmd2pnTGdoUFIwYzRhbk1zQUlGanhSS2JrT1I5?=
 =?utf-8?B?V2piY09XVlcvTExudVhRMHhWM2pJTG1iNWRmLzd0N0c4NjFpSGhOQ1JoNS9V?=
 =?utf-8?B?V1Z6T05zNEU1YnJ1aFMvSCtDZDJqME1DdjJwNk9sbm05ZEoyM0ZMdmc0R3Zv?=
 =?utf-8?B?Q0VpN3Aybm80T2VvY3FiSFRzZm9tNzgvQm9EbTZGaVpRL3JpRzZMTzF2UjRJ?=
 =?utf-8?B?YUVTWjY3bUtWYnFWUlhDcm1wZ1hxQk1EMDAwTUZRQWxZRTFyYStJcWpnVTV2?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b9ffdf-91b5-49d8-bf41-08dac68aa6e0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:53:23.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYXg3QCkmXnQCBg+FfgiOtkJ0NNmkSLbNBNBlI+715lr2D3BfyEhl6V1vUl5N5NU8CviIU13RGzWcWkprpKXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3243

On 14.11.22 21:14, Richard Weinberger wrote:
> Hi!
> 
> I noticed that a 32-bits x86 application cannot use RTSER_RTIOC_SET_CONFIG and friends when the kernel
> runs in 64-bits mode.
> The problem is that struct rtser_config members have different alignment.
> 
> On 32bits:
> struct rtser_config {
>         int                        config_mask;          /*     0     4 */
>         int                        baud_rate;            /*     4     4 */
>         int                        parity;               /*     8     4 */
>         int                        data_bits;            /*    12     4 */
>         int                        stop_bits;            /*    16     4 */
>         int                        handshake;            /*    20     4 */
>         int                        fifo_depth;           /*    24     4 */
>         int                        reserved;             /*    28     4 */
>         nanosecs_rel_t             rx_timeout;           /*    32     8 */
>         nanosecs_rel_t             tx_timeout;           /*    40     8 */
>         nanosecs_rel_t             event_timeout;        /*    48     8 */
>         int                        timestamp_history;    /*    56     4 */
>         int                        event_mask;           /*    60     4 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         int                        rs485;                /*    64     4 */
>         
>         /* size: 68, cachelines: 2, members: 14 */
>         /* last cacheline: 4 bytes */
> } __attribute__((__packed__));
> 
> Note: I don't know why pahole reports this struct as packed. It is not.
> 
> and 64:
> struct rtser_config {
>         int                        config_mask;          /*     0     4 */
>         int                        baud_rate;            /*     4     4 */
>         int                        parity;               /*     8     4 */
>         int                        data_bits;            /*    12     4 */
>         int                        stop_bits;            /*    16     4 */
>         int                        handshake;            /*    20     4 */
>         int                        fifo_depth;           /*    24     4 */
>         int                        reserved;             /*    28     4 */
>         nanosecs_rel_t             rx_timeout;           /*    32     8 */
>         nanosecs_rel_t             tx_timeout;           /*    40     8 */
>         nanosecs_rel_t             event_timeout;        /*    48     8 */
>         int                        timestamp_history;    /*    56     4 */
>         int                        event_mask;           /*    60     4 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         int                        rs485;                /*    64     4 */
> 
>         /* size: 72, cachelines: 2, members: 14 */
>         /* padding: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> While nanosecs_rel_t is in both case int64_t, gcc adds different tail padding to the struct.
> 
> I propose the following fix:
> 
> diff --git a/include/rtdm/uapi/serial.h b/include/rtdm/uapi/serial.h
> index 9ac691b723a0..3c798de13985 100644
> --- a/include/rtdm/uapi/serial.h
> +++ b/include/rtdm/uapi/serial.h
> @@ -240,6 +240,8 @@ typedef struct rtser_config {
>  
>         /** enable RS485 mode, see @ref RTSER_RS485_xxx */
>         int             rs485;
> +
> +       int             padding0;
>  } rtser_config_t;
>  
>  /**
> 
> 
> But I'm not sure whether you can accept this since it changes the ABI and existing Xenomai
> applications will have to be recompiled.
> 

There are two unmodifiable truths right now: 64-on-64 bit and 32-on-32
bit. The 64-bit kernel must present the same ABI to a 32-bit application
than the 32-bit kernel does. Only that will permit existing 32-bit apps
to run over 64-bit. Data structures used for that need to be modeled
accordingly. That may mean defining a special in-kernel compat version
of the structure that models 32-bit layout (as expected by 32-bit
userspace) on 64-bit kernels.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

