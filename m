Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3F18AEE
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS7PjmDHdGlVLXYV6GkhJ3jMhNgYuQZnYS11P0ZrO7bCr03oslCKcMlYc9GS66n0ViirIt47AojQOBoeEjizHA3l9r9yftJ8TVN3jFcaY+8/imuoE27hk1C8zeuD/A4CDeKacfa6cBUh9N6J6onFzU4ZzQ3Dmvw7HU/kvBf4qIjRneHLS/itXjOlEE5a3ia6DkiBZQomsDGpTbBuKb0Y4+wlBKFjKwAzxtDKjnro9o4YzZM9a8j80pFbgu+3FcinLa+UHDBc8XrGs4U1dAS9lwo4fiXqUJY+sbWjKQe1Tq/Se9hihS0/aiVh7ICQhPooGvqf86tTVPSZuuF6GGEV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VfdynzlCNxtc5R+9EEQKQRrwwIhnwzWCfdyx8vRpTI=;
 b=f4KukFdVKfwZwmHauXY01rQJRdNbZS5cOgXmgztkWwApp+gLpyOOCevKRQptcp4f9UY70j+A7tujUuxgjJdGxy0w2dYurMOfmOw2WkH3qMCrrDLrn4ldu6NwrKV7ox09g0hYbZWBd1UlBh6TMQPjL/FhcbtJ+uVFSvBlnyIswrFuDFaa/quN8ANVErxRrvZL5yw/ptWcyULsZerdadnYf9zlC1qvsvcz+h20WSJyarP6NAbx7Y4DFNNhp23MgbtBJMB2mCDisphsGtmw9+dUsXtY8nkNhtj2Udd/BukXnyb9C8CFVynt+9ADbkcSHebT9Mt59XL5jq0RFAqV2AWpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VfdynzlCNxtc5R+9EEQKQRrwwIhnwzWCfdyx8vRpTI=;
 b=sMbnfnbFDzPEEjk0np3xgjPbxVJJqElB68Ug8q8FXD6EN4nROyvoaNfUNBKQhB5ayBDgqKtswbAQx+yinmdlJq1WgPEgsTKT8/DOoZFU2E0RhN6IpFZ6iqJ+I/ZyBD9S6KEC5ohnIVQ/A7M60g7yVILnsJA5tsskg/dDxo6QK/obmr5uqpQchWrJMx2q+gxdL2kdQmO9hLktOUv4fS2M7WM5MRFJUuQAUntbF9LVzdKcACPnCfE/O/1B+TluH/YaNRarV1zjc6ay45xukhJ1z1WcblTqDnOWMtmq3xmqIIGqvDci/tUxmIahMiywzQ9fPx/wCSOWhY/r6p0uu2nfPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:680::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 14:54:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 14:54:49 +0000
Message-ID: <8128f5be-8891-badd-d83b-c34065438c4e@siemens.com>
Date: Thu, 20 Jul 2023 16:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/10] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <20230406103341.2914-1-aaron@sigma-star.at>
 <20230720145150.24607-1-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230720145150.24607-1-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 755bc9f7-1614-4747-07ab-08db89314423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ymS5nwerydtGfmCfYZVeIC0Fk2pkGmCyJV5vtBC3At7W0ppTNHHRmiuF9DNs3AUgVh5g4/0d2dljssVajxbi4fndtSD4Gs+6V7yrVnk2mth2ry326P4LgG8l2gCodDhnuuBYiA5hqWzaZHRp6hrVsrW0n0+n1ZyHshqtwOOHAG0IboioRvpuuxAf7Qa61QKLgU3SE+Res1dtzA17EUgr0jAlR+EEJSQmeXA+KYbEjbfcJdu870LOQUYNLl4+OM571YtlfyH8Se/UKEVXg8bovh7yMWVjkDUkpJTO8DQKktrJg7o5Ua5fFamJnAGMDBXTyj6pBxiGAfgR7593BoOSYjZ6QbgLTttvVjluRf2oFAlDm8kavaccZ4UAJNxisk1yBJrKcKIfCR6PPSKF+tdvHkQcKsp5yzvpGGsuo7FwBfRj7YyUA8p2sHwmlViGaZ/2+z6Zf+dSkCadnmoxJaxIz49gDD6nYb0LMgfJpDfz2/AAdkEQO0+UFAQmz29wzutdAzver+MfiyWObBw9L+l+Uixn1n2u/qSN3znNM48MHf9uou/Gcrlnt1zNqbHvW3dgF0XtcqZBUOpUFcetQ8RuMW7NEqAjn9vBGhNRxwVDVPUapis8FHRMQmT7VFhxeFE/2ZFo9Yy+uspPmJsBLm+1pg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(6512007)(66476007)(26005)(186003)(66556008)(66946007)(316002)(4326008)(6486002)(41300700001)(53546011)(6506007)(5660300002)(44832011)(31686004)(478600001)(8936002)(8676002)(2616005)(83380400001)(4744005)(2906002)(38100700002)(82960400001)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0hjZnpGSUNnTEVjdjJkK3ZJSzExWXQxcFkwNTZOTlYzMTdTdExweERDUmVr?=
 =?utf-8?B?UmhCaEx4M0RYVFdCMTVwV24rTDRmczBsYTUvaFFXU2hFWlhGQ1RGSWZsaS9k?=
 =?utf-8?B?ZlBsL2lMNVRsZTFubjVqZ1IvekZMZ2F0V0FDV1dUN3lpSzB6eG9ubUE2Y1V0?=
 =?utf-8?B?dTNmQko5TTZMVE5oVW1RVVArSDJFempXSEp0WDBRQ21tdlpXY1dncWJMaEF2?=
 =?utf-8?B?V3FiZEtOQWFaOS81T1Y2ZkMvOHAzNXR3YStwVG03VGVPQ1YvbDJTT1BoaU1Z?=
 =?utf-8?B?SGtjbHlKNyszaDRiWEkyQ0tobndkclgzdjMvMFFjUHRRR2dhWkN3R1hvd2NL?=
 =?utf-8?B?TnhBVlcybm5SRVRLUFFSMTZSbEdvS1J4N1pwZTFSQ1FYSkd1MkpmazZUak5y?=
 =?utf-8?B?VWZIbHVmSHlVald5MWd6Q04rUWVnaUpqTkdRQTNtOFRnbEJSS3VvWTgydnVm?=
 =?utf-8?B?UWFrN09FcHFLWTJCc0UzdERQWGNtMjdtcFVKU2p6bjhBaStyZUZkbFJBNmN1?=
 =?utf-8?B?bklrWXBpSHg3MmdZWHliSHg4ZW1BWE9qV251LzVPSFFvR212NHBxWk5zb0Q5?=
 =?utf-8?B?MjlWRlpmVXdVSEVjdWNIQndnZWpQakVySE5kajU1My9DVzVPS1UvUmYyQUZU?=
 =?utf-8?B?bWs1L0tNQlZ5dmVzb2wzRjkxMVBXck5BUEZDRi84WnM1d3FoM1JVR3kxaUZP?=
 =?utf-8?B?SnJFUVB3N05YejJ3YmpmVGdneWFZTDBQdXk5dTE3cDdVOWpzaHFKL0lyUk9F?=
 =?utf-8?B?RUVyQzgvd1BLZi9RTFZJdml5Zmw5aUZ6TG0wSGVKTXlwemxTa1ZUSDN3WldQ?=
 =?utf-8?B?MVFIUTRhcHIxSUdOL0E4TllKbEpVcFVDSjd1UUNCTFFBQlB4ZVh2STRnLy95?=
 =?utf-8?B?RlI0TjIvdG4ybDFkL0EvdVBIYmZlWGZJZW1rY2FkRmIzWnV4T0dvV042VzZU?=
 =?utf-8?B?bmU0QjVsYkh1eDA4QkRkQXZ1TEJMKytNZ2VDSE40MXBuS0gxUTZWMWxNdWlr?=
 =?utf-8?B?eE5ZUVVpalpkSWxweXluMEg4K0w5ckptYzRZU1pKTFhPQTgrU0FGOW8vNkNP?=
 =?utf-8?B?aTdEVDlxRHFBUEtWMFUxaGlIanU0ZGtKazU4T3pjNyt3THlKell0cHpNcUty?=
 =?utf-8?B?NFFobGd2YUt2VnM1UC8wanF0MkRSY0JXT2J3a3Y0N0NPWUMwYzcwNDFIK3hC?=
 =?utf-8?B?cmNMZjVRZlg1N1NzSHhmQkJtclg1MWRjRzZuTHB0a2Jhd0c3S1BCR0twem5B?=
 =?utf-8?B?NlYvZGxPWjFhY3JYdkZ5Y1hhWlpRakl4QjRpQm5DVE1FeWhqdzA4OWlUSTh3?=
 =?utf-8?B?TGpqT3RLbE5RVTFMamRoN1MweU12amZta3BYdmRYN2JHaUpEVFVWNUxNdEN2?=
 =?utf-8?B?Q3k2dUlkTFN5alA2cDByR0k1NUZDTTc2Y3oxNWtRNXJuU1RGNWdSYWxJbVBz?=
 =?utf-8?B?ZERoYWdWVzFPekVyakE3cWNGelpCeWExTnhvMWRtV1A4VnVQQ1ZjTnBISURs?=
 =?utf-8?B?ZHAxRGp0SWt2aVdMU0hMbVF1QTdoYmpNYXFQTmpTQjRUVTAwSVZjZzFmWURr?=
 =?utf-8?B?b0cwOXF6YW1aTlRkWlJLUGdETzY3a1VFclVPeVU4NS9WUDRWUXI2eGMrVWMv?=
 =?utf-8?B?NlN0a1dqQ0xhWVh3b1ZSQTEzSHZYMC8vUEFubEF3QjN4d09kb2dVaUtDeWpO?=
 =?utf-8?B?WUFwcmI5dkR1TUE4NmFLcFd2RGIwcmtYSld2SS9PNG9kQi9USGRxK1FGbWQ4?=
 =?utf-8?B?R0FjOWwyNzFLTUh3UHVSb25mOEVXOGEyM1BnUk93NlVYWWkwK3dnTDBydEJx?=
 =?utf-8?B?dS9WelBwa3JRTUdXVnJLb2xPOU1POGJxOGlmSDg3ZnZmUDk4R2VxSVZlbUtQ?=
 =?utf-8?B?RWF3eEczdXJBMFlodDZ2NHNtb1czMDg4OEhPNmlDNjVtRDlZdjZCSCtZbTVX?=
 =?utf-8?B?aE1LZU9SdmZWNGlSUkhUUWNuR0dQODhwRWhBRVM2SWpuUUV6b0FlNndpc1lH?=
 =?utf-8?B?WjBrWkcyZXVDMFpMd29TM0VhekRxL3V6b1JTVkZOd3c3MnpIR1VPMnhQYTAy?=
 =?utf-8?B?M2w3QUc0MVRMejRHOUxkNUZOcHhJUlFQbS9GakhDa1RaNytCbk8zSitLSWJi?=
 =?utf-8?B?N3lTck5aVGtsOHdoUGJ3VGdxb1phL3R1Z3hVbWNISkNSL1I3WDRtYlJHc0dH?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755bc9f7-1614-4747-07ab-08db89314423
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 14:54:49.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTSRJk/PDExYcyj79mLwvelJ7lOs8GY/ntkmvm3zqDbbp3zJAurj/+6kQyLCNhO/sH5cn08aAnCSdyZ2djjZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8219

On 20.07.23 16:51, Aaron Marcher wrote:
> This patch series fully integrates the currently abandoned alchemy, pSOS
> and VxWorks tests into Xenomai's testsuite.
> For each test, a Smokey testcase is hooked up.
> 
> Aaron Marcher (7):
>   testsuite: Fully integrate alchemytests into smokey
>   testsuite: Fully integrate psostests into smokey
>   testsuite: Fully integrate vwworkstests into smokey
>   alchemytests: Check pipe-1 asprintf ret value
>   alchemytests: Fix task-2
>   alchemytests: Fix task-5 logic
>   testsuite: disable broken tests
> 
> Richard Weinberger (3):
>   testsuite: Remove old alchemytests Makefile
>   alchemytests: Fix gcc warning in buffer-1
>   alchemytests: Fix gcc warning in task-9
> 

Thanks for the update! For the lazy maintainer at least: What's new in v4?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

