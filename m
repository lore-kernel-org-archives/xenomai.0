Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A693A938
	for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 19:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR3ARRWmwqTEHC+kmedm164m7AMPUrsuXTuF0yNie91VElYooJJpW0yuRJ0mqi5vYC04oNZYaxc/9Vq3jRHUr+qJkYVUvrE6qG3Wa+V4kdSeKn6HJyKyNkTNGfFK29WJNPtCYQTccbQjFCc4GnLLGX+PIGRXWbk6/qN5KjUIMWCP4l+sFN9U+E8slEgKPFBYGyYtyYkgKsrdrAc6N12WjdFcwSphruatXJG/9EQzNdR94ZwF0UCyEeCu5ZdSLeUx4ouPx9ygioxvUN8CqQEkH15sgLWmIRLXBvRikZJfAFH7Pxvv8vRgt7SHgEtNQxQ9AVMRY4r6UYlIZpPmcnkA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuYhNPB2OjZiq5caEuMijhKtIFZwb/v2qmE+Mq/j1Xs=;
 b=TbKrWZ8j7Iicww0Dv7AxE+zGK7o8RFidWyB+RRgSJxoO+INHufyw59NKUf6A3nzoTn+nBIJgsPLVpvNeIRfOUNBYDU7/tait1OyXc9ULQZ+MoCPOrOOZpg5KeieU9YyPA9xNFTdExLnAHGGrl54T5XGG07rMuHIODHlh5/DD76iZjZI41PV0yQCbuzahRg6qNPazhCNRbgijDzsJJL9J66kPWu516lxdPUk7gAoJDY4otLSDeK2Bpwq4srwA96YZWvc8P0PaLs/LLcoRhvVi5rU+lu/3IwB76KPeFgO27tUgNHHGnp/XV1509uvo0F9Mjiq75zHFFGzzLGiXJ8Pbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuYhNPB2OjZiq5caEuMijhKtIFZwb/v2qmE+Mq/j1Xs=;
 b=krnPpj9tvvOBjjkc+9Zq3c173JeXEUdUHyZGYjmGTB5+9hS/XrP82edDCh7KbIiPqErNtPypGN1Yr5Cm8YOGEtvMh8ofjZ6p8HWgMA8zsmV02dnMzjZnTBgpY1KzOUTO7UWpnF3cXEeypkSIrtYP78S7TJILp7bDeNRNggdjnd6qydGQ0lXf6eQGWu1plM0o8YoRCk5pOvNRqxkX1Tu2uhcl8AUM4Dd4f6o9QzQ45ZZAcv6UJNI1OiQZV1XYwLlKoHps4K5PYb37uvqNSk0xURgx2G9wq4svlMoSDP2Yg54j8Hm0Sirlj8htiYaRgH4+4Et6WFwstlr1y7K/RX1WZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 19:11:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 19:11:38 +0000
Message-ID: <317a81c6-3da3-7c60-46d0-73cdade17117@siemens.com>
Date: Thu, 16 Mar 2023 20:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Dovetail 5.10.y sync
Content-Language: en-US
To: Giulio Moro <giulio@bela.io>, Philippe Gerum <rpm@xenomai.org>,
 Xenomai <xenomai@lists.linux.dev>
References: <11477b0a-0aaf-60cb-3a6b-0a8b47414a7f@siemens.com>
 <0d2fbd52-288c-1af5-b462-ec6a4ec1ba0b@bela.io>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <0d2fbd52-288c-1af5-b462-ec6a4ec1ba0b@bela.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b34523-6171-487c-f9a7-08db2652445c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D/lib324h78mkvnZuBxVcVhPMhoGYgKgD9y6FTmSZ5xkgzD5ulFPMeo/3/4DmD9lHstfEgXBp0rY8kz4BGfVtj6VfVJbkfAp6oE8EyC9PtkQNtCX2YXs7NESUPWxY64IYTQzqmW0TuA3hoj1fye9xzsPt8tVpClnswHouCZXzIQDLESmBN5Cx6aQ7C32Z3nD/hULCWxzhN2Gu/wMzgGlAKKJG5Nlaghj6MPCR3bC2WHnG9qBNArONbK/sMrsXzBZ/u91cwdz+oYegWhOpUDtjCmDJkJhgXdzq3g/zafoKVvi5r8qol7OwU1JAyHGx99+43rgDRNLJZDiFGmK9hOjGe5n/SoIpFZW3zQS+ILpy/jzNNiGroTRdKGnjXP7zBW8JXfDErH5ireZ+p1r3vXGH3A4Nazd9j3APmbN6yF+7OzREDn/ir0TKD4OHs3RXzWcQIaR4XhNwT3hk20gZR1b+J+UoVzf06f/3EtHOiIE9m1S1HrIl1IrRymt8w8j/l7hVZxl4lNbf4n3UAP9mo4jrcASPuefydsDPEaffr8Z3wb7p7xZm0HYIPi++4RhYSjG+DxOXeWtSTdwgYDXJD9Ne3k2E71YBkk2Bv5+EzDxAC2hDLPquay0ChTLXX5C69s6VtvMfaU50GuASF8mB2QF7qzvIsIUN/OHEnaNjSEXKpMqDM6DxOuqzo21ChT+kq9xHdahNlsxYG5JvN7jccP9RF7yUWZ3NTzh/XPtxR9bjB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(2616005)(186003)(6486002)(478600001)(31686004)(44832011)(53546011)(6512007)(6506007)(26005)(110136005)(316002)(8676002)(66476007)(66946007)(66556008)(41300700001)(83380400001)(8936002)(2906002)(7116003)(5660300002)(36756003)(38100700002)(82960400001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJGTjdmd0Zyc2JQOXJKdEVRTmQ1SU1wY042Y095ZjhHVHB1eENPbUxhN08v?=
 =?utf-8?B?Q0MzQzI2K08zeU5aUitSWkJBSllYbHZaZ0x4QitLWFRFQlJDT0MrWkJkLzlG?=
 =?utf-8?B?akwzRXhCMTNiRk1LcWZ5TTJoV0RNall5R2poSkxweFc4aE1RWTBEcmhJTlgy?=
 =?utf-8?B?LzJtOEVpY2Jhd2Z6TnNubjhnSEZ6bFh1aGRrWU5pVi9wbzZUeTlmRms4RkFj?=
 =?utf-8?B?ZUl6ZWdKRTliS3VEdGNYQ3V0OUZudnhtUDFDMmRUTEpQbDhjQlUxOHowQ3kx?=
 =?utf-8?B?RGJJQTdVV0REcDN0aUV4SWpUV3FOdkljNCtVNGtmZGxXdXB3RFhlblFqWWxw?=
 =?utf-8?B?RFVna3MxZ3BSUm13dzFuMzdRYWdkMGRFNHkwUVlqWXE2Z2JQSkRYRTg3aElB?=
 =?utf-8?B?UHg2ZkRZd0YzYnBnRVBpNXF3aGo3Znd1Tnkzcy9pN1lOYjI0RENQU3U3c0h1?=
 =?utf-8?B?L09CZmZoWmwyYUdLUDA0SitYZTZMaERHVy9laEpXWTRhbFZBRW82SmRvNE1V?=
 =?utf-8?B?Yzd1WnZXNnhjNnR2WXd0TUlKY1lZdXIwOTkvMTlBSU04VTZEeWRQdGsvNHpP?=
 =?utf-8?B?dVo1ektZMjJLWUtuM3EvVWpnZjFKMzFvMTBqNVZJdTJyYVowYWtyVzErMERq?=
 =?utf-8?B?TVY1c08zTzVsZXE5SldBQWZaemkvbE41Ti9LeHhvMCs2aDErV01KbUtRblpl?=
 =?utf-8?B?SjQyYmZNT1gxTDFNdnNKaTlYTWNBOWxJYkNHRkpkVEtmTlZZeTZQZjNxdWcx?=
 =?utf-8?B?Q0FlQlRGVHNDNVJwbEF6blgyNkpKQ25Ka2FidUl2TTNXUnJRQlN4SUNzSklZ?=
 =?utf-8?B?Tno1eEZtVGtDVHh5STErcDBCVDg3TXpvVmI0T3dCS09PRlppallKcDA0Ni9h?=
 =?utf-8?B?Q1lFS0p3U2sxeW5kbEVvZDVDb3d4NlRreVoxZDFjR29HWVZmVGhuZ29aRDEx?=
 =?utf-8?B?Q0ZSQ1hVcnBXRjNVb3I0Sk9KVDZYMHBnTUh2MFRoZVUvaGhJbG81Wjl5M1NN?=
 =?utf-8?B?M0U4emxDZzBpQVN0elBPV1FONG9TRTNkTjBTK1I2dGNsall2VWRxNlJJSFZG?=
 =?utf-8?B?WDNoemJHN0FaNUFJbUlFejFUR3NsMmpXMTF2MXZTWGZoS1hRc0pQNEVXdzR2?=
 =?utf-8?B?blhDWTVWM1VnL1JKZWRwdG4wOGVVelRSakh1WDRITnFCcnhFT1hNQ2JFejhR?=
 =?utf-8?B?V25UZlBQSEQ5cXg0TFVCMWdBNW5ucFJyR3FiWDhZeFFuRWkzU2MwbFV5NVo3?=
 =?utf-8?B?bnFMV3BjNmNoZW5Db1ZaelJ6Q3FWck9IQVlTeHl1bGkwZjc0ZVNBT2Z0dmZ5?=
 =?utf-8?B?SGYvUXFVNit4WnVlRCtKa3IveDVYQkR2WnVIY0J3bE0rWExRTW5qbUZqU3pX?=
 =?utf-8?B?cmlSbXVGenNSK1VFNm50Tkh0RXFGbmNzNWhheE1jclJaaFdjNk9Rb25ZV21j?=
 =?utf-8?B?Z0pDYlRPLzdmY2xnTGF5UWtOQ0h0bEY2TVlrcjRUMnlWaWZWSFVHa2tuRThq?=
 =?utf-8?B?aWJQc2VGMHZEL2pkZ3NPUFZvRkc3MW5ITFZWYm5tcUwyTGJaTzdXQU9vNmZr?=
 =?utf-8?B?Skc1azlkOVRzRlprSHFtZ2RWbDhFMUpjTHhzdVhZN0I1aGtCSlEvejRpaUh6?=
 =?utf-8?B?RG5JWXNNcDZ2anRhNzk1ZzlBNWI2UWNhVFVYcDcveEY1VEg0d0VNMXMzRVNV?=
 =?utf-8?B?cWNZRnhOWWtjKzh0cW1nd1M1VXBtR3AzQU0xemQxYmlhVDdsOTY1dnlQZFBV?=
 =?utf-8?B?b0pncnFYbnRLM0R1dTh1VnlmU20yUHY1bStLQTh3YmhUTmNWVjJiMnZUZ0sw?=
 =?utf-8?B?cUtZSVZCdjB0MGcyQVhSNDV5NTE5Z0x2SUVpcUdrUmFqMVFRbmZaT1crdGFK?=
 =?utf-8?B?bmV6SEtzVXdKdm5ZdjNZanVrZEpPa0tlTnBBWXo4TlN5L3cyYVNFS1NkZk5s?=
 =?utf-8?B?N0w1SEY5NVNaTjVyeGNJL3VYN1JZc2xQSEFZTFY2SEFSczlhSWV5ZldkWVpl?=
 =?utf-8?B?ZFpBZVBlMllaaGE2RkhHWWV2YXFHWG1EMGljZjRKMmI2ZWhZbkdEZzBUdmVx?=
 =?utf-8?B?TWg4UElPQmZJSDBMUWpqRXlHUFp6SHNuS09ueFN4UmRnd2k3ZWN6MHJyV0Ev?=
 =?utf-8?B?NEZNTVlYRTZSRXVjbTQ4eGZDR0ZMNkxOTFZadXVGS0N6cW9mbk9mQk1SRmxn?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b34523-6171-487c-f9a7-08db2652445c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 19:11:38.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fV/4Du79xlJIKrBvmOFGlLZM5z9Iyx77jM1lcixNhDwVZXl6+OVTR1gi7X47K5xnj3U52qROdzQb16App+SUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6187

On 16.03.23 19:57, Giulio Moro wrote:
> I am totally not involved with the change at hand, but it looks like it
> is related to this:
> 
>  #define TIF_SIGPENDING        0    /* signal pending */
>  #define TIF_NEED_RESCHED    1    /* rescheduling necessary */
>  #define TIF_NOTIFY_RESUME    2    /* callback before returning to user */
>  #define TIF_FOREIGN_FPSTATE    3    /* CPU's FP state is not current's */
>  #define TIF_UPROBE        4    /* uprobe breakpoint or singlestep */
>  #define TIF_FSCHECK        5    /* Check FS is USER_DS on return */
>  #define TIF_MTE_ASYNC_FAULT    6    /* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL    7    /* signal notifications exist */
>  #define TIF_SYSCALL_TRACE    8    /* syscall trace active */
>  #define TIF_SYSCALL_AUDIT    9    /* syscall auditing */
>  #define TIF_SYSCALL_TRACEPOINT    10    /* syscall tracepoint for
> ftrace */
>  #define TIF_SECCOMP        11    /* syscall secure computing */
>  #define TIF_SYSCALL_EMU        12    /* syscall emulation active */
> +#define TIF_RETUSER        13    /* INBAND_TASK_RETUSER is pending */
> 
> ...
> 
>  #define _TIF_WORK_MASK        (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>                   _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
>                   _TIF_UPROBE | _TIF_FSCHECK | _TIF_MTE_ASYNC_FAULT | \
> -                 _TIF_NOTIFY_SIGNAL)
> +                 _TIF_NOTIFY_SIGNAL | _TIF_RETUSER)
> 
> as _TIF_RETUSER is (1 << 13), then _TIF_WORK_MASK no longer fits into 8
> bits and can no longer be used as a flexible second operand to AND.
> Instead, it needs its dedicated MOV instruction.
> 

Ah, that makes sense. Thanks for clarifying!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

