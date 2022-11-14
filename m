Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91098490
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 22:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2J1HD6kng337YXKGHH6imyxlfOvVn5EdYLsxROmGnQGpAQHfeo/Vq6BfG9BOoRJUnCHXhLaztkBF5+8ElP/wqsvZDZmCxWjIEEV7/7WjXs2FVVOq+j1rZPU4HPXd8XkzFL56RBlUSc5GhDFd2dUxHYKHN7Ta0fAXbkhztypL1pBQ0BddEO74fiUHU8bf1LY/9A8C0dL+8tA+fVB0ZUPPsc3QL5xci2krjaQzpmd8CnNuSqE4z0aCR6ZJFQHeJ+jCSavAubtY7HNmXIkXoQ+oLNSlZbiMwtR5Csc+4bgrCFZoMvoOmcK3RvRb+80eKJRI0wFTuQ7jTop7BL6ZlU4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnKH91iCtEmPi9NAUCoTfsHks6XpsT4hJUtVz1q+FUQ=;
 b=Krx0c8RVws/POF4SsHMpUs1KM+IN16xjxMs2YdXSwcrsQLrPm4JsBDgROBFRVzpmu+CNKmH27d2TMv5ahW9WujiP1odQeL8aewJtfpW4k+Iuj+jL1yW9aPZmR3m/70WldzjUVOKxCk/Jjo5HKTck74lrFlikLmRzP9/pNPmBgnCz+vkeUxOh+1nYmvA+AmcTw2XSRlDcIH2hnURw111DD3WAE7wd1ulBZJE9U5BjmpZHmaTiJ3tO0nC594Yu6N5SLXEmFDrSfg72x64AuttqAvL5+hcKRMtPYWR27QIBSsxi5pmhN1GYTaiHmA92pll5Sq+WjW1y625xnmNU/CP9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnKH91iCtEmPi9NAUCoTfsHks6XpsT4hJUtVz1q+FUQ=;
 b=J7j1E16Vi6KFQ7eS0RlZxKZFGqTD2EwGhWp+E9Xe3H5tmclxyqFX1njfbDRkz2AqWB37gUXQVka7M0olkAnm4rdvWxZr933MOBQwPdvylvABsw4+JmQIRoLNlEUUOpz5vamocvDTAxZvOGjssk4fkCjaqcH4dFBk/AKD56mPnsqTKX6okB3bhxU4IupS/CVzxYbbtC8oakukpCCveBLnyWuImlh00OXcW26hVNVThtTCAlO0Tz0NkztDKEk5dDLtUQGhsq2CwsgpR74hvrdchm9YEijtPmP1Z25phs0DThtRF/iw8iwjapFpocQCSITNWxqKBWsIaBCYve5HeYfjlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PAWPR10MB7650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 22:11:03 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3%5]) with mapi id 15.20.5813.018; Mon, 14 Nov 2022
 22:11:03 +0000
Message-ID: <19572c30-f131-140f-44dc-92265cdda5c7@siemens.com>
Date: Mon, 14 Nov 2022 23:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: rtser_config and compat userspace
To: Richard Weinberger <richard@nod.at>
References: <601440741.237005.1668456855365.JavaMail.zimbra@nod.at>
Content-Language: en-US
Cc: xenomai@lists.linux.dev
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <601440741.237005.1668456855365.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::26) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|PAWPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: f4940d85-5bd5-4453-6015-08dac68d1d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EVNxZG47DK4Jeq6VIKS9OFScVWpvWxx5XuKJtI8W4oknrBt/FKjdVisJ40Q+nO6Q5w75dnCU2C0Hi1iZMr9oxxc8kKrNYhaz/I9/qve7asjEOUh02qNCUm1n8sAGN3UsU7bfSqLEhhI6D+phjJ9PQpA9xSY8lXWO/8c9zSrJLsbPWUjkRiWmTPBrwozPODsvH2hsLTeH2yx34zakKjB1TNC6PMMRXpAOquRguCfDo7ooMVhjFgpn5UZDuRLBMbPHYRKtVCwpyi5i57nlFi+wFJpOnfzJn3tA3kCULqkEpFqRd6RPzcrXNVAQ7kWAy+KcMjBQIp02ljGscw+mPhFaBjPhTxTRsASBywJfuvFWhQz5jaGAi+itBNBL6A/IUEMoe2wdOWBvBlcMjfDOACuNny2nnHvPfIisoRB5FHVvf+jW0r0sL/ldL9/vDtrx87+FtJw0FDOpG7EeXYB0VO8vfJwgSX9qqkyxleSMfP3QJWqF4xajQAKbq0vxOm3JMPC/Ft+Xi9q00nDuTAJxCF1xYmd5kDEqOYA/igAd7hKeLCsEUYqcCRK2oeOl84sadNHbrUe7xBqwY21avJxAXqsgaLzzvse3alQzinxzdZ5ItnCuMghaFq6FEDUSabDcnj74TjSLRq4Awv9HBJhGazyX0VVTVttYuJX8XJOzVZoLVP3iU5TLWWSiO2XbjSePzBhmCmGRJvz6FaJlhhnudzPeLP5oZtd51N9p75Jb0FqUNkfaaqCkybM90dQckdvnF6taTTQcVvksPpLuhDfBE33dSe/Xzyp8vQFI4Uz2Xkp4KMqS2VA574cGPYvEcvU9JXM+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(31686004)(8936002)(5660300002)(66476007)(8676002)(66556008)(44832011)(41300700001)(66946007)(4326008)(316002)(6916009)(6486002)(36756003)(478600001)(31696002)(6512007)(6666004)(6506007)(53546011)(86362001)(2616005)(186003)(2906002)(83380400001)(38100700002)(82960400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REticjlYa203NTd0WThrTWVudGVZQmxyUmh6RXVmSGs3SHoxNUc2YnVub3BS?=
 =?utf-8?B?K003Sm80TmxhWDl6Q2hzWWtCS1dvRDFKNmlyd0NzK1VPUURXR2tSbGFZdlpp?=
 =?utf-8?B?M3RTODZXdG9tbkVkSEtwWXAxY3FPLzNSdmY0NW8yVUgzeFFuU0x2cHM4T3VS?=
 =?utf-8?B?SlVydml6b3JNdjRscTMyMVh6STJ3Yy9xM2E4VElWZWNVb1JacW91Z3p3bEp6?=
 =?utf-8?B?anJld2lEVk5HU2puRm1oWStoek9ReEdVbjAwUEUyNndEMzVyd0laRjVwYmR0?=
 =?utf-8?B?MjR3R2NkTDJ4WXBHY0FvYUpNRGFpKzBnWXFjQVhFWG9NT0FhcUhrSTQxNXFX?=
 =?utf-8?B?eVQyWUtBcFExVDR2VEZUTGJ6OHpSNzR6bjU5cW1wZzdRUDkra0hEdFpmVVJq?=
 =?utf-8?B?UFpkdE4wbG01WWNRaHlVeitpbit2OGZvQzJ6dS9pVlRVTFdQVG9CZEllbDFZ?=
 =?utf-8?B?dVlyZjI0UGJXcHp2YXM3Y1NJWjBVMVdnMmZzcG5ualFPMFlRMllBd0M3T0Vy?=
 =?utf-8?B?N2V3TlNoNVd4TGhsekhFd1RaZWRFVnJ5ZWF6NUtPdTZlUFlqNjl0Nm9QdG8y?=
 =?utf-8?B?bFhVWkU1TVlibWllUCtROE5zMnhNN0s3eHB5Z2ZoSnUzbi9hWDUxc3UwUUpU?=
 =?utf-8?B?NnhsS2xUOVBSU2dSUUdibU5idWEzemJ0cUVOWUFVUUlvUk1uekxPYmZ2V01m?=
 =?utf-8?B?aWJMdVc0UHY3cXU4WlA0Qk96Y1NNNVpCanN6N2hRTldUQTloVTBoSUNxdGcw?=
 =?utf-8?B?RlJQeDQ3MDY0TVIwUmJXUTcwb041Ry9oUC9seE5rYTJreFl2MnpReEppTXFo?=
 =?utf-8?B?czF3QW41QjFYSWQ5SjBBaDB6YWtKUkNsZ0tpMkJvRzVGQ3FvWGlNcFNPemJo?=
 =?utf-8?B?cjhJSTF0VEIyaGFEai9PZUkvaDRaMmpPbU5wZmRrclhad0VEaEFGaW1mWDFa?=
 =?utf-8?B?bUpXNER5c0lsc1lJS1dJSlQ4NFFpd1JYQ1hESzBJYUFwRWFHWUg2T0krbEUz?=
 =?utf-8?B?aDZGaW5IZlNQN1NjQStpK0tnVnRER1Zyc3NDdDU3dXN4MVFGUk1sMUQ5WDhN?=
 =?utf-8?B?cUh4WE5XeGRMUUk1UjY5Vi8wajhLVUFMSlgrUGgzOFFRM21LWHg1S0tNb3c1?=
 =?utf-8?B?R3FMRDBRRVM3TmJ4M013RDU2QUw1ZlhtSXRQTkwrenJlWVZodTRCL3liTXYz?=
 =?utf-8?B?QWlsR0dqTzdaS0RtbGdmWTBPWWJQS3R1WnJjbzJPYkNEWDVtbGRIRFZpM0F3?=
 =?utf-8?B?NG9Nc05PZ1huNjA1UTJpZld2aWNpSnE2S0g4akh5OGRscENKVkxXZzAvU1hx?=
 =?utf-8?B?UjVlUWUzcm1waVhsUjFkUmhoRnFZTmt0a3l4T21sQ3grM3hwUUJZRCtheXB3?=
 =?utf-8?B?UkZyVWJ5VkxRV1R3ODZlanhxTlV4K2ZGMGlLWnBwbGxEbHJiSmV5eE5wNmh2?=
 =?utf-8?B?Q0N0eGs0aUppUTRNUm00SldhRnpyeDl3NVFtdVErSXlmSHNQSU1BRWtzTkM5?=
 =?utf-8?B?VVJRaEJtYVdaRHhZS093bVlZR3liTEhqSm1ETG4wVmZhZlg0SFhmNUE2NC93?=
 =?utf-8?B?eVZqU2ROTmdlSDJTYXFOM2d2bElvMmtBcU9LSkJmYUtscTNhTkY0UEhhWGRU?=
 =?utf-8?B?QlprTUkxRU9ZaXBld2JjanMxZEZBQVd3S1FCVHRyaSsvaUM3cmJMcGFjV2NX?=
 =?utf-8?B?cktyMmZSTzRBSzErcTZjWGRJcUp3a1F5R2ZDZEZNdnhUN2c3S3VqT0NEbTVE?=
 =?utf-8?B?eFA3aHNsaTkyK21NMVM2TWh3bWVQSjc5bkJzdk9WMGo1b1BIQ2pQL2JWTVFl?=
 =?utf-8?B?VmQrYTlseGthRUpoUGZNV0I2NW1ta3N6YnJ1SlBtTlVneVU4Q0VoVXBuckFH?=
 =?utf-8?B?eXBKNUp5MXpicFVTT1RpbW5zN0c3SnpNVXlyWkd3VFQ1a2YvTzdLN2E1NXhv?=
 =?utf-8?B?YUl6azRWK2F5MUc2YjFhenJNV0J6R21TNWF4VkNzN3lMSzVlRHJ4Tk9GUnJq?=
 =?utf-8?B?VTZjNzB2TUw3bDQ0YVpvTGkyYXRjRDFwZ0swNDRmWXRMeS9rS1lkQ0xUMnhw?=
 =?utf-8?B?U1dDZWR0RExrcHA2TjNkTitSdVVFRDgrMDlHenRxZXlhRXUvZ3JCRExweUxt?=
 =?utf-8?B?L0ZLbUxYNFZNZmJZTFJnb2kxNGo1cVNaUTZQcXZoMXpDMXh1RFI0WWt5WVkr?=
 =?utf-8?B?Z21TLzVTbzgxbVBkV1NRSDQwN0Z3aGVIUGpERC9nb0tndTE2K3FHNThzMXZp?=
 =?utf-8?B?VlJhd0h2K25scnhBc2gzd1kxWS9BPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4940d85-5bd5-4453-6015-08dac68d1d9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:11:03.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zC8jTuw7gvsNiNEBtrBzXaYDRffMMbfuwBOX+MzfvktaKAqdDu55nR4Wxkxf9Y22TPj3A4msaqlm5lBoIgl0DlqYK03UiWHxpr/OevHrz2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7650

On 14.11.22 21:14, Richard Weinberger wrote:
> Hi!
> 
> I noticed that a 32-bits x86 application cannot use RTSER_RTIOC_SET_CONFIG and friends when the kernel
> runs in 64-bits mode.
> The problem is that struct rtser_config members have different alignment.>
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

Which Xenomai version are you targeting? Maybe the following arguments
can help. I hope they are correct, it's getting late here.

A 64 bit application can only be served by a 64 bit kernel and for such
applications sizeof() and offsets will remain the same. No need to
recompile as not affected.

A 32 bit application can only be served by a 64 bit kernel as well as we
no longer support 32 bit kernels. That should apply to all stable trees
but I'm not 100% sure about 3.0 and 3.1. No need to recompile the kernel
as it is already 64 bit. 32 bit/compat applications are broken so we
need to recompile anyhow to get them fixed. Should be acceptable, no?

Btw: My understanding is that a 64 bit kernel would always expect 72
bytes for this struct. If userspace only delivers 68 we should report
that (-EINVAL) quite early. Did that happen? If not: We are missing a
validation somewhere.

Florian

> 
> Thanks,
> //richard
> 

