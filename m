Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150070.outbound.protection.outlook.com [40.107.15.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E5EA2
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 22:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2Q67d2k+vvWABmJxjuwzhHXgW34/NN964Z0FUpT2XON7TZwFg3x1c1k6tXDjCjFGodTq44v7tAo/je8sVOstjRYxQlcI+nFCwQenElI3HyStO6ET+9WJFpDz0dpwCUUpLWG2co+S7xUNBEPoB83gQOS3BF/tb9nJIOEZrlCnI4NN0pgtgc9wMODu12G2Z3jAPk4jO8SybQHRsokQi5BuqKHZ4AvdU9Bd1DvlQFaJwgbRPATUa12K2fezycaZW/CzM4BJbn6LLuFjH9d9S/8QFigv26mCV+6VNVusho8zf0oaliQ1ZhX6NrBQ6kY59YM88DiHDuRLIra3/+R+5Nodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BJdxefrz7jLI7eNimddbK8YIjgUED4HkR9vaGi344c=;
 b=WHEAAM2zChW9gucD4LOPaXDNP1y4CzZT57s7tGjTdzpIEiQ7UU50cM8YslMICvxkDEz4ubQi1ATO75wtF3+KOzP3eV3YO/4VSqClsMngvaJMooRdUkMakkQqZhI6O1zktZPld9oqjx3RVIGFF01JzQ7vd22XBUL0PQGZ7NeJKbXtS9LOfWoZH3dTl1mi0Qy/QGtAHnNEVBNtqRagDJ3Cv+bkrBgQ6+CVz98nu6QY7VfSaohCtQivgwWDzvza69TMg6LfOoChGwRAFgvPqoUv+2H5eDHPyKF09T+fIBdNa+uHPFeHPSrXZ9fKvQaPV4o0SOAWAcpkLooREzw+SR5Smw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BJdxefrz7jLI7eNimddbK8YIjgUED4HkR9vaGi344c=;
 b=o07RefC7LRUKq1oQLSs2Xdn2d+s3iflZTgtiajqsD9KYgw5OTONmcUZ1SUWZ30p37fliO5XmMbwSc6NWI57Sv4ERG8ncl52pPKlClV/yPskfVtI2hEnBiGqWdcGdh8mHpSzRYCm0orZ/o9ddHmxCRJa0eQeb9UM5CoKxsS39PdTaPV6tdetjm+khudFMbnTGlQUlkTm/bpgQex7lsSZ0bA4tR4IcUPQ8fXop/XjNzR4KeL3GZt2lDhtLZUSoamOaD1mdLZmwhC+D5eTdVrkUA5OR4mtdkg0He+OWjNKUEY0dusSswpwS1hIdGBTGQRgy/mWFx6qeK8cZItN+y2qE3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB7856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 22:30:48 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3%5]) with mapi id 15.20.5813.018; Mon, 14 Nov 2022
 22:30:48 +0000
Message-ID: <7602d8e3-b725-e4ca-8fe8-0be403c3b0f6@siemens.com>
Date: Mon, 14 Nov 2022 23:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: rtser_config and compat userspace
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
References: <601440741.237005.1668456855365.JavaMail.zimbra@nod.at>
 <19572c30-f131-140f-44dc-92265cdda5c7@siemens.com>
In-Reply-To: <19572c30-f131-140f-44dc-92265cdda5c7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0715.eurprd06.prod.outlook.com
 (2603:10a6:20b:49f::34) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|VI1PR10MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 763dc95a-ecd5-4f54-3d14-08dac68fe0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zH/ayON0YzKOiqHakNawJiZwVklc7krm265kqslVKGfV4klVyEY5GtrC91CfIrtPuXnDCewNwZl+0zTU8aFETq0RzN9ipTOVOJjwajOAN7273Vdj+0myt1wdsjJPpo7rhoEPyvun/DoSWeEoVBxxi6PdEex+JiOxPYE4+iOK+VWRv4mE6eUdkezomWpjpCr9hkW3SjLpOwxqlIWJl3gUz8+47S17m1cMjHe26aH6tAkwXsSu2Nlb1sPMaT8HfjuluHJI6beqbSggFfw3wvV5UgjiWDguvtNsBduFQKpQZcbpvdetI8cCTP6g/AWJchM6/AbXXZmeAU06tdxp15UTq7L0n3av7tsfcLkq+RAK7QY1sJgYb0gH4dr0kGMF/ALA0GndTwXvyzeID32eXBjhXfFxIjig5LmVPwBBQo8yu8+m1RsB40copzJyua0JFL/4G0QwPYt0O2sx3YurLQIGAEn2rdH8/i31q8lelyTCxaQd88kddR8BWU/JZul873y+Jb3D1wBD1Dq4XuTic3VVrGSUjAjBiee6tEoj4KX/fAHp9H5TM9nnUa9yZ0XtgULsEPRU8iCfhLTA0FquCjJi70Jae45lMoVTE2e1lV9gVu8EgLrRosHcstyeENIhPEQsDvZ3nPfGuPKHDRwa+PI3Q2Kt8uc8PMe4Kc4nJfAn6GO6nhj6ihknoaQ/nS5nEQaKwhQrex9XQasXzPi78PTalJe67KypBifkYLFCuWcSJgReWJz5fq1UvEVIB/YAPUDXRBTXCvmcozVSJ2JqQkA6X7oT7mwYvWdlfor/Dpzsxzxs2PnFDMwXH7Ku5tkXCaqB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(2906002)(44832011)(4326008)(66946007)(8676002)(6512007)(66476007)(66556008)(316002)(53546011)(186003)(8936002)(41300700001)(6506007)(2616005)(36756003)(38100700002)(31696002)(82960400001)(86362001)(83380400001)(5660300002)(107886003)(6666004)(478600001)(6486002)(31686004)(6916009)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2U0Yjk2cVVXY084ZFZaMHE4ZHJNaXVlOTdNNWdwVTdDcnQzYm56eG11QW1s?=
 =?utf-8?B?WlBNVkNNcldqR055cjFlTFZkaUdEYitLaTJUU0NjVUdIUC9OaUs2ZTRyNGsz?=
 =?utf-8?B?aEJ3T0Y4WlZuS1A2RVZLaXA3NEhTMDBvbGRFclRLU3lHZXo1V1JhRUJIVjIy?=
 =?utf-8?B?ZWFjby9nL0trRDBXaXZCdVBjZFZYcnZHaEFQK2g5YWNRTjJNTW5jNDl3dDZl?=
 =?utf-8?B?UWJUeUl4ZExYU3ovaGUwOUJJL1NlaHNxZlZZUEVYcEdPKytPeG1DVklJWHZV?=
 =?utf-8?B?dnFkT081ZU5ma1dJMVNRZTFqVXlNTlFselNiRC9Ub1Bvbmc1OERwRU5RcDU5?=
 =?utf-8?B?S2JxZlIva1h4L01oWTF1Vlp5NER6WkJyQzlaYUMwb0QrU2tnQ1pIcEZjUjRU?=
 =?utf-8?B?dGtVMFJ2STNXenlJdWQ0ZWY2QXIvaURCbUJxcWZtSHdNZDcvaXUwUVJiUERz?=
 =?utf-8?B?ZGo3eElYSDlZM3FBQmJKWnQyM1RKL3lXSEZmbGMya1RiZ2lBaUVQVXJIdzBJ?=
 =?utf-8?B?QnlxS0NTdHU0N09WWWxDVS9JL2FPV3BEV0NuQ09xTFlQZk5VK1JLN25qUGNY?=
 =?utf-8?B?aDNpeEhPSWFlS3ZEL2xrZnJMbXFnRmZsV2V6OHFvT0padnkrdzFXM3B0OE1s?=
 =?utf-8?B?U3RTR1FpMHVQakloTnlmQk9RLzZJaUl4VjF6cXZZSFVkWDhxYWdLSjdFVWFB?=
 =?utf-8?B?UEVUWXFRNTNTbkkreklpSm14TlZvNi9nbFltdi9rUjhxb2lvOEU1RisxQlJP?=
 =?utf-8?B?TGZkMk1MT0VWb0VoKzA0UmgyZlNoU0pCd1ppK2graUE4OFF6aVB2U3YwN1B2?=
 =?utf-8?B?bWhpRXZ0MWdXT2duS3RDelh6ckVZL1BNT1liakxDR1NkeCsyUkQ1MEpMSk41?=
 =?utf-8?B?MFRZSlEvcWQwbGx6dGsyZEhxcTg2ZWtXSGh2RzhHT2tDZm9HYUJKcGpEbkNO?=
 =?utf-8?B?VzIxU083UGI4VFBPaDdOZ2pOZ3BMWk1PTGRkWUI5Z3lVa1Uwd3pNb0t6RHF6?=
 =?utf-8?B?WndzVGxJTHRkRFFJWXJxd085R0F5RGRKNCtEcHFiZTNyemd2WTBPZUljemJp?=
 =?utf-8?B?OXZTdklTVlFDWVRxWVJFR1ZKemNtRDF3dW9tN01jQU1TcnpqZ1VITXovelFQ?=
 =?utf-8?B?SC9Pc3BONTFJem5FMEFIeHk4NHFrNm42bXBBekh1SEI2Y1pKKzM2MWJXUUhS?=
 =?utf-8?B?bnR3RlhqYXQ5cFJIM3JyTjBFL1lZRlhxTEU0aXNINDFBbzlBS0xKTDNndG1Q?=
 =?utf-8?B?ODBQL1huZVVNNERUVmpYdzRVcFphZkFrSmRzTXJCa1lyZDZrMlpnOHAzWmY3?=
 =?utf-8?B?cDJuNDdsYnkyTFNKSmwzemlzVXNFb0duSnpsck8zb1ZVd1RoMXgrYUR4bUln?=
 =?utf-8?B?QTgxVmRnakFJUHBhMGN0V1IzK29jMXlsMkFmQyttWGl0eE1rWlV6K2xyeDlL?=
 =?utf-8?B?cXZFSjBjVFowd0ZIeXdkNXJOYUNBcUxVbDNrMkh3UXhzR0ZSNEJ3NG1WMExZ?=
 =?utf-8?B?RlJqdldnakI4M0FLaGJFTTRuRkh0TlVka0xNUG1WV2R3b0xhdTBDakRDUzc2?=
 =?utf-8?B?RG9Qemt0SFgxeTRTcGRwQXo5YjY0RmtMMnZ4ajVjL0NWdHNKeEVkL3pTT3hB?=
 =?utf-8?B?V0NmaU9oRHUydmZLb3NGbG5udnRQSXhrL1lvNFJkMTZJTmdwYXpPaHlYZ1E4?=
 =?utf-8?B?Q3FHNUE1NVNLWXdzVjZobzRqU2U5UnVheTM1c3NENkNya3V2N284WHlxL0xC?=
 =?utf-8?B?MklRZlpPa1lscFFhSm1RZEE5alNheVl6K2t5Y0FXMVNIck1KNnhwRnFUdEll?=
 =?utf-8?B?VTBxV2JtN2dTZytNWE5paE1GUzNRQXJBZzhWQXZGeTZ5NkljQXI2V0hqOXFv?=
 =?utf-8?B?UXJDSVlpSUwvZU84dXZJMkhqRTk3MnRmUCs2R1lUUEMrL2loWk9OOFBqMDZK?=
 =?utf-8?B?ZnJnaWYvY1RTRXFzZFV6bWJjc2I0TUVVbTZsS0FFWE1OOEFZQ2xQRWoybVZv?=
 =?utf-8?B?aEVLMzBmaXRPcUsrRFpJdUJ5NW1oekxXbmRPeEgwaytKUU5kQXNNZzNnazRu?=
 =?utf-8?B?VURVR1ZQYUJ1bVgvZEJUVVJoQmN6M09QbUZwSnA0TE5EaDRkM055K2s4dlVP?=
 =?utf-8?B?dDV1Z2V3MHQvcjhnSWYwL0hod3ZxTlA1cDdiM3I1TjU2NjZFelQrZy9MbWJE?=
 =?utf-8?B?bC94ZzgrZWx1b29OVnd1MEtuenR1cDVYalJhdXF2S0NvTERPTE96aXhuUzUz?=
 =?utf-8?B?U1NVMVcrUklmY0c2NUl5VUpWOGRRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763dc95a-ecd5-4f54-3d14-08dac68fe0a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:30:47.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqzZtc3xLddY9ujtgNKnQgYH+q4BIqOUOw2Xc3uEI/7xIjpAQESa3CWnJV5IHSVZiUlhy9PPbhqqExPV/CFQCeqiWdLtSl90Gc6dq+y5/Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7856

On 14.11.22 23:10, Florian Bezdeka wrote:
> On 14.11.22 21:14, Richard Weinberger wrote:
>> Hi!
>>
>> I noticed that a 32-bits x86 application cannot use RTSER_RTIOC_SET_CONFIG and friends when the kernel
>> runs in 64-bits mode.
>> The problem is that struct rtser_config members have different alignment.>
>> On 32bits:
>> struct rtser_config {
>>         int                        config_mask;          /*     0     4 */
>>         int                        baud_rate;            /*     4     4 */
>>         int                        parity;               /*     8     4 */
>>         int                        data_bits;            /*    12     4 */
>>         int                        stop_bits;            /*    16     4 */
>>         int                        handshake;            /*    20     4 */
>>         int                        fifo_depth;           /*    24     4 */
>>         int                        reserved;             /*    28     4 */
>>         nanosecs_rel_t             rx_timeout;           /*    32     8 */
>>         nanosecs_rel_t             tx_timeout;           /*    40     8 */
>>         nanosecs_rel_t             event_timeout;        /*    48     8 */
>>         int                        timestamp_history;    /*    56     4 */
>>         int                        event_mask;           /*    60     4 */
>>         /* --- cacheline 1 boundary (64 bytes) --- */
>>         int                        rs485;                /*    64     4 */
>>         
>>         /* size: 68, cachelines: 2, members: 14 */
>>         /* last cacheline: 4 bytes */
>> } __attribute__((__packed__));
>>
>> Note: I don't know why pahole reports this struct as packed. It is not.
>>
>> and 64:
>> struct rtser_config {
>>         int                        config_mask;          /*     0     4 */
>>         int                        baud_rate;            /*     4     4 */
>>         int                        parity;               /*     8     4 */
>>         int                        data_bits;            /*    12     4 */
>>         int                        stop_bits;            /*    16     4 */
>>         int                        handshake;            /*    20     4 */
>>         int                        fifo_depth;           /*    24     4 */
>>         int                        reserved;             /*    28     4 */
>>         nanosecs_rel_t             rx_timeout;           /*    32     8 */
>>         nanosecs_rel_t             tx_timeout;           /*    40     8 */
>>         nanosecs_rel_t             event_timeout;        /*    48     8 */
>>         int                        timestamp_history;    /*    56     4 */
>>         int                        event_mask;           /*    60     4 */
>>         /* --- cacheline 1 boundary (64 bytes) --- */
>>         int                        rs485;                /*    64     4 */
>>
>>         /* size: 72, cachelines: 2, members: 14 */
>>         /* padding: 4 */
>>         /* last cacheline: 8 bytes */
>> };
>>
>> While nanosecs_rel_t is in both case int64_t, gcc adds different tail padding to the struct.
>>
>> I propose the following fix:
>>
>> diff --git a/include/rtdm/uapi/serial.h b/include/rtdm/uapi/serial.h
>> index 9ac691b723a0..3c798de13985 100644
>> --- a/include/rtdm/uapi/serial.h
>> +++ b/include/rtdm/uapi/serial.h
>> @@ -240,6 +240,8 @@ typedef struct rtser_config {
>>  
>>         /** enable RS485 mode, see @ref RTSER_RS485_xxx */
>>         int             rs485;
>> +
>> +       int             padding0;
>>  } rtser_config_t;
>>  
>>  /**
>>
>>
>> But I'm not sure whether you can accept this since it changes the ABI and existing Xenomai
>> applications will have to be recompiled.
> 
> Which Xenomai version are you targeting? Maybe the following arguments
> can help. I hope they are correct, it's getting late here.
> 
> A 64 bit application can only be served by a 64 bit kernel and for such
> applications sizeof() and offsets will remain the same. No need to
> recompile as not affected.
> 
> A 32 bit application can only be served by a 64 bit kernel as well as we
> no longer support 32 bit kernels. That should apply to all stable trees
> but I'm not 100% sure about 3.0 and 3.1. No need to recompile the kernel
> as it is already 64 bit. 32 bit/compat applications are broken so we
> need to recompile anyhow to get them fixed. Should be acceptable, no?

I missed the 32 bit application on 32 bit kernel here, as Jan already
mentioned in his answer. That is working now, but would break existing
applications if they are not updated in lockstep with the kernel.

Instead of implementing the full compat stuff with all the necessary
changes: Can we hide that behind some API-revision bump? Forcing users
to recompile? I assume that would reduce complexity a lot.

> Btw: My understanding is that a 64 bit kernel would always expect 72
> bytes for this struct. If userspace only delivers 68 we should report
> that (-EINVAL) quite early. Did that happen? If not: We are missing a
> validation somewhere.
> 
> Florian
> 
>>
>> Thanks,
>> //richard
>>
> 
> 

