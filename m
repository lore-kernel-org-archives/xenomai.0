Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5EBA58
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 13:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5rNGmcVEh5tML2mpoQ8293D8fQMtiOHSAsM9YngNYYmhm6jsOTGIZ/cQn0CW5WNbUMEbrgyoG3o9BUG9o3mG8sKT1O+14dGXfBBYwOiU+ehOEpH4DBoFnoAt47KjoDYFATec5uKqr95IpwAarvHDvcWLjcUJj0z/uHpIze2AjNJux8LhvbCW1NxMw3u3zjxDw3V4rrJyIe1OPnbqVZKEQsAx0UhIyrOVu66XBEneV2s1qMoZDLqxv2F1oJylv2/kS4/rFLJuNenU0A1ZROJGTsFCSmR1vK4KNjIlRGaLzCt5rAk8qD7AggQqaUNno0xuPcuQGLkFz3PcstUM3Q0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN/DvwKi0aLi5yTD/QbBghjhekyUzOmIqp1ZT9EsueQ=;
 b=NAVDAnZ/+GXeSv5lrcYoCbKUhi9iFiX40jy837mYD41U0v780mOkmvIXZzwGY26Uvvx782EceDubM3kek3pdy3coE5YEyqcCTHkdIZg28gBfP5fe28sH9CdogwiHSc9C7PpmVdUi8DkrycbX1IeSmdPdYuwV3leWPNk7GJz09i6KatyRXR+bUfthfwKCCvHwJeApudpz4xYX1GvKbijoUppT0fQMDGZsQ8gXhDOzggij46pop4D9G0YwAzNOunQUKkp5xgCN8zEHpmtTiAO1O6B5bGuW7taEo1Sh0BVRcfSkVEiRhCur/dV3Jtp3jCetr62bl/YPjrYPfx/xlhhmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN/DvwKi0aLi5yTD/QbBghjhekyUzOmIqp1ZT9EsueQ=;
 b=jkbbP9mC+N72T/mGjUYOnT//lnPygOFWge1IGnniHku6HNWjiIZ0OxSdsSqU2+9kHxT3v8WBvqvelPa+2GGwBWw47QR5zhmCmTZcPxKEIhyMkeGrRreuSejOf/YAtfSAXVWPPqDSE7S1lVO1ltroQJEo5RtdEkYYDIQPvdwemPjPKWjLRfIu5aDef4mxIx7ygdr6MqJfX2PMP2Qwde1fUi4QKz3mWkQlW0OXN5Ss7TT+v1GvJQXHo93f5WR3wSyUQA81AXAPP39nksIa47U0O4fBAGnXynWZdzD5pBoC6t4/ZCf6S53nlNCbl0+pH7BoEhMDnr/gx2qAaegBO8pa+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 13:48:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 13:48:24 +0000
Message-ID: <f7e4b137-668e-4e0c-bc65-cdc97e516bc8@siemens.com>
Date: Fri, 1 Sep 2023 15:48:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Status of Xenomai-images
Content-Language: en-US
To: Per Oberg <pero@wolfram.com>
Cc: xenomai@lists.linux.dev
References: <340325180.1522934.1693574777740.JavaMail.zimbra@wolfram.com>
 <926e7876-c2b0-43eb-91b7-7b7f969ab208@siemens.com>
 <955481814.1525807.1693575870993.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <955481814.1525807.1693575870993.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cdff39-c31c-4db7-9bbe-08dbaaf21c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GcYbxa/sdnqrDXcVaHSlPiTEa1geUQBPSLY0cF64mFTGon/ugijnEcbNLEFRGI9Zd++gPDo3HpR3b3I7vkv36xBgFvs7CCQmr3vxh8aWde7gzNmZRI+fpFobPFqBzZhbvsfjnL6IH+LyQrjUGMTB66/Yf430pSGW2T7o5QP/hernOMuR4NCX5/i0wjM2lSbin4gEbEWfA+bQC/8sGO7yTeG+crvWL7raK0+FcuOcmuNomBmwAvcYr137IguxL0FcSPALm1yQvGxqMLX9AtbXRIQSRSNSDrjSTulrtmBLuQPcmtfjWTokZT2lNVvctY267r1R9ElzLbizaf2ok3ROLMkZOmPSG+KPiuxXu1bWZQ5vkXcNKlhI4k4jriesczaipB4G5XEwQhqOzBIc3haMdqnGFnpXSoGxlhO2V46Qu0NjupXTEpFAEKxlNHxTRDpDpkgB/KbupJmtYqkHiiMSFQYF1TATWvyEkkZJrJq8B1NwW0dO2hWygIdQDNFaW7TTvefz0nCAzFrh0UCPuD5kxHlgBEBBMEZ8xMR7adKWctDOUPJMCjbpdoogMYP7rKI6FRDxc/JfQ91pZWI0k7xjeF2nkXwDReNelBeMOygE4REyoC6YXiBj7+G3eaLKjFIQeUJfGOCpILTgaRhNn+yZbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199024)(1800799009)(186009)(6512007)(6486002)(6506007)(53546011)(478600001)(83380400001)(2906002)(2616005)(26005)(316002)(41300700001)(6916009)(66556008)(8936002)(5660300002)(66476007)(4326008)(8676002)(44832011)(82960400001)(36756003)(3480700007)(31696002)(86362001)(38100700002)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXkyTnZOZGNSMEJySzM3K2ZVbG1Gc1dQeC9wZ3FZNTBkVm5McU5yc3k4Ni9v?=
 =?utf-8?B?U1JNdFZrc3dsdTlZUnJzU3JVdkg2L3ZDazU1Y1dYVU1jZ1BDRTdpQ3gxamRK?=
 =?utf-8?B?NzZzbUpZY3VYRXRLTGhobnVtdDd6VkViQ0FhOTB1VXBtNmVUMEtKUmpuUDNt?=
 =?utf-8?B?Qll2blhJSzl0NmVCbUJsa2F2L2Vhank2dmNsSEpvL1U4bDBZQ3pHTWs3YzhX?=
 =?utf-8?B?NVUxbjZXenZEbGdGRm44cy83SElTVjl5TFBwMGZBbUJ5b2pCVUt1SjdKcnRZ?=
 =?utf-8?B?dXNPaDNXb2VJVVJmNlNkckk0RHlYTlNFQkx5c25oTHZqVEdBWjNkSStNU2hx?=
 =?utf-8?B?ekpWNC8wWi9YdStQR3lmcU5DR3pEUVF5eUFwb0ttUXhQZTIwa2Z3LytzRmwy?=
 =?utf-8?B?eWxhMjg5OUcvNERXaVVIUmliNklzeUw5QzN0WmNuWkVic2xzZ0VjZ1FzYXFl?=
 =?utf-8?B?bEdTNzI2cW5aemRUV0dCRW90eE9qZCtLclB3QWRPQUJsNlZldi9DdTVQQkRR?=
 =?utf-8?B?RGdNYVBnV0hwNlc5U0dtajFMbDV1K3RYVXZtOEFKVWdtNkFNOEZVeE9oMGxU?=
 =?utf-8?B?TFF0RXJPZXhTNWQ2YTZuWHhDZzNJQkd0aGl6cGY0ZklsRzV1R3VCMmJLNS9i?=
 =?utf-8?B?UURuZXd5RzUwL3gzdytlNWV2MWFNSDh5SGFsUkJjaEFDUm1yNFZORC9lYThr?=
 =?utf-8?B?bjdnY0RPSHZiZ1VJVmpXNHpaVUJDb1R2dlhHem1aNWo0T2hRak1YSFVQSkNi?=
 =?utf-8?B?eVdBZWhuM25OZkF3ck1GZlN3c09Ud2wrdkhZdVlZeUZyS3FUL0ZnMkpIY1lJ?=
 =?utf-8?B?Z3o3RHpkdUR1ZkhGbnhJVVYvWVVIVEZub1NjeEwrRGNhZ0NCVlZEb3VtSDBB?=
 =?utf-8?B?TU11QklzdDV4YVRicnB5VmZoc0N2VURxSGJ6ait5c3pkVXBlcy9UbkVHR1Mv?=
 =?utf-8?B?ZnRHZ2JWZ24wTktRNFVVSllhaUhGMUpFUmVBa1A1cnNKQ1VCMnFRQ2liaEhn?=
 =?utf-8?B?ZWNmOVlrWktIMGlXWktXOTlTWldicGhTRU1iTWVVM2hOZmZXMTF2SDM0OVhB?=
 =?utf-8?B?ekhSWC8zVVFFZDk3VU1vaXYvYTFxZGY2OHdCQ1YwRXp6UjZVSWtvd3lrdlNm?=
 =?utf-8?B?bVFhRHR6ZUMxck5DaC9tWHkvczZCejBaUzJ4N1NmbkNpVkUrYjNTcU96d2Yx?=
 =?utf-8?B?Z1JEUTgyNklYcGJZMVpkang3Mksyczlway96amxVU2k2SlA0R000ZndlNGJQ?=
 =?utf-8?B?a3RFbnJvVWpTL2tGSEc2VTNnM3dwOTZzTi85S2xxa0JRTnNtMUk3QmgvcGQv?=
 =?utf-8?B?UDdpa2dKbHdNTTNvTmdNVVVYenJvbENXQnp3aDJXd3pkWVhNdkI2Qy9uUWNt?=
 =?utf-8?B?bmRrRUVaMCtNS0lKVUdYSGhVZWptaGNvQ0J4VXZmZENQekY1RlcxeFhWeG5h?=
 =?utf-8?B?czhLbHhUd1VocjlFeTExRURwT1pxUklsSGxtWmVQUlJxV2hTM2tHdkJhc3hr?=
 =?utf-8?B?VXM1V2JLYjV2Rll4QUhCMGpwbTBuSTVld3lBc3lnODBHa0RIOXM4SVlYMFVN?=
 =?utf-8?B?SFlDRFc5MVBTWEw1ZDZZQWg5VUozcCtZeFAwUEluSVNnSVUwQm9rcDlxSU9y?=
 =?utf-8?B?YVVxK2lhZENlT2FBTkNtaHNTbkk2dG5ueHBOYUpacm9BekpZNmlJUjdFZ0lP?=
 =?utf-8?B?NDFERVd3WlF4VzYwQXBPKzhKSTNESERvd1dtUUNNZUVpaHVEVmd2cmJISlA3?=
 =?utf-8?B?WGgyRFp5R014b3dQeHZyQThVRlYxb0lmWjZ3QmpYeUxpM1dYRkpzWjVkcFBE?=
 =?utf-8?B?WURnN3Jsem9OYUdUblRCMkl4eC80Rk1sR25rcWY5SytHbmg0NlZxRzZGVkVq?=
 =?utf-8?B?SllKQ0xLbVI4OTRURTVRK1JhU3dIVFdEYi9idW4xNUd2MmFCdyszOVY1Ujhm?=
 =?utf-8?B?QnNZYlEyRExHdGNoQ3p0L3l4MUNSRm5RTzhzNTltV0xhbVo1WDc0SjE3OVFX?=
 =?utf-8?B?S0tNTEUxQ1RSWmhQOUNUazVIb3RORkZFUmJIM3VjbHlYREtmN1VpeEJyZTNm?=
 =?utf-8?B?QWhKZGRKMkE5NzhQUlhPUkczUlZMdldWK2ZjN0FOTlNNc2Q3NENwZ2lTelE1?=
 =?utf-8?B?aXY2Rk9pWU5mMDAwTVRPUDNHLzVHZENxTXlTemV1WGtwMnVuVXJRMDQreGk4?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cdff39-c31c-4db7-9bbe-08dbaaf21c68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 13:48:24.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z/QnwevbbNiNnMiLSjczIsXqXlBIJLSO+mZpdnKh5mZBe6f0/KWEWLidMhbGIw2k3UC5APXONs6UMxO7CoSYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6834

On 01.09.23 15:44, Per Oberg wrote:
> 
> ----- Den 1 sep 2023, på kl 15:34, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>> On 01.09.23 15:26, Per Oberg wrote:
>>> Hello list
> 
>>> I just tried out the xenomai-images [1] but I couldn't make the images boot on
>>> my hardware. The qemu variants worked.
> 
>>> I used "kas-container menu" without any changes and tried a few combinations
>>> like
> 
>>> * Generic x86-64 EFI target
>>> * Latest 3.2.x release / Head of stable/v3.2.x branch
>>> * Latest 4.19-cip I-pipe version / Latest 5.4 I-pipe version / Latest 5.10
>>> Dovetail version
> 
>>> The hardware I tried so far were PCs with intel core i3 or AMD Ryzen based
>>> architectures. I managed to get my USB stick flashed with the wic-file and boot
>>> into grub. But then it hung with a blinking cursor when trying to boot the
>>> linux kernel.
> 
>>> Am I making some sort of silly mistake ?
> 
>> Maybe framebuffer output is not working, and you are only "seeing" boot
>> messages on the UART then.
> 
>> Not sure if we allow for an interactive grub session, but you could try
>> adjusting the kernel command line there to use console=tty0 instead of
>> ttyS. If that was the reason, we should likely fix something.
> 
>> Jan
> 
>> --
>> Siemens AG, Technology
>> Linux Expert Center
> 
> Yes, that was it. 
> 
> Completely removing console=ttyS0 showed me the regular linux boot. 
> But then it got stuck in initrd because it couln't find the root partition. 
> Seems to be looking for the wrong uuid.

...or we lack USB support in the kernel built-in or as modules in the
initrd so that your USB stick can be found. That may be a matter of
tuning the x86 defconfig in use.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

