Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33918B0C
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 11:03:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2SCKpaWtEBO2zP+s8czVI/c1ytgbpUD/qkZE48iQsnvCuzFTP3hB6qXote1Ks2DeebyTNEIazC4FUoBarAz5sCCezSwmp9iS3ELU22HzDkDrVgpE42LtSQ2NTZfVXFZEZyXcJKCaJCXftxznFJQHT5mGUWXGSubxPafeVzbJO+Dqhw3f5+8vcOxgckDb+Hzw6tv/SS74VEwjC4/5JFPKbQEz0xtIE8F9Aym8XpSH6rhUWcX2/EceJRhQXEbIp6Xs0qF7CyNg9pm9nsbb2A5tv3JoxOIF/6M0GwDzToQqenBt72KpNtyUekO3+AedzGF6P+6ZdF3Yp0dd5w7cWYYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybCqNXCUxLcC9g/Xx7j7edXWWkqQLFarW+bccLNJ/ro=;
 b=ggugPv+EZTYHp+2VaxMp0XFGL9Xlk9TGdGRVSzgt2CUydharlOcwcZEfuN1VdvbqpXR9QhsyS1/Uyf4dx0m8MEfK50ERcDujRBSGT0c6lgtNyglWkTwfyNqxSfV/Dk6mrWG+0GovEI7wI3nE2fQtfLnZKahE8I4rR7ENraGBgrWFFzmbL1lWD9K1XxczCNYz3Jqt2w4ER//6fn+/sx54CzjZNOeH8yExklcbvzkiA7pGxSbMTZeXGKNxa3aJkm+A+717Z3h3GF3bGfDKNmF3QjtL47KG1TlwWWLILA+mTIj5sXtMRL/6yIOb53sEH+n3hGHkW8K9aqPLNrXvp4Q3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybCqNXCUxLcC9g/Xx7j7edXWWkqQLFarW+bccLNJ/ro=;
 b=oWorARVkSdrwDiNG8Z4wmHEs+83EgERQFfP1a/PMUhg1dpM+lGG+veasZPmtGTP//M87wrcfjDygQUN2z+xHo49Kr424TKR8N1BxRh1T+vfSEiHHdaliE8EgFpYfE8hWMwG78Rf3/vC8JVi39KxfJ1Q92X9DjLc+LEDWZ0wCky31MJtBt//Da4rThNYLRxBJyxj+QeOLG5OD2Wm8ZsZsJ/JEzUJMomPNgKAdHGLp9nClV0cdiOJj5SuaUug4iWaPycN8QWoNjAfAx1KRazl4MqbeElN7T5r0+U4eeFkVfqaR6GAn0COb5ck3CnyV9GEszFwedgouJjYzDPJsOgE/Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 11:03:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 11:03:33 +0000
Message-ID: <544dee0a-c072-4f7d-b5e3-84e6d50df093@siemens.com>
Date: Fri, 22 Sep 2023 13:03:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail 5.15.129 and 6.1.54: New kernel warning on ARM
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <f5149f19-4eaa-4844-8602-1c181532dd88@siemens.com>
 <878r8ymqzp.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <878r8ymqzp.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:610:cd::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: c2dffb6a-74b2-4adf-c5ba-08dbbb5b8fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	00UMaXYcdhdtFli8AEsFMTEGOjnEkyEgJIdRvsgIhh3wFzjjkBcBOpwOwBOt0o4p1CGadzxD58XUA8zaPQnBJw/BMUWmIVE0BALe6iKJgybSzu0ybMfrhYm0fuP7wvRDfbJt3NXQDgjHwTcRRaL1dMEBGicJawr6GQ9IBA3T8eHwxzv14HK9CkGAZQGnAfr6UGgMmLxYzUbfoAiolu925+OcRRN1iX4URMOpEsF0CCVNjtjZatnU/BhInV5Qdq0nT+kO9MdzaXgIZ+kyJFIsV3GPmB90XwInrW2vdVYmxh+8duyKdslzMWJ4toQVs93MqugTJ/SdtUvsPoyMBzOtOTvyq6r2+1qqNOgoXpjZucBe1jMe51VIBt3cbQ0CZE2WT4lP2GezuUwMjzL2Z2xCQO28nTGGXHk8oZAqopfqzoSrqu2kAMqbDWO8cSO6hq20OmssJCdLjFk8WnfVrfRuRpDJ2Kn+rxPBfs2lJ9A5fJFluCEcU6jDnBQm1x0JuDnaABM6DoNnDThFKfh0xE0wjcXcTcHfj29kTtpIP+F53UAl4H4k4BGzbSVbpPCc4R+RPT5PZhsIbK5BwUGuRmJxmRYSafVElw2mQqHiESY5lYIVwtwkadlu2N+iM4btLyv3rZmP4uIMMOwDstcV4ov8Uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(186009)(451199024)(1800799009)(5660300002)(316002)(66556008)(66946007)(66476007)(44832011)(41300700001)(8936002)(31686004)(8676002)(4326008)(6916009)(83380400001)(2906002)(45080400002)(478600001)(82960400001)(53546011)(6486002)(6512007)(26005)(966005)(6666004)(38100700002)(2616005)(31696002)(86362001)(36756003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2cwSkNxS0NhYWhFam9jUHIwTmRNOFBKL1lHN0lpMnlQbUk4U1VnOXNQZG0z?=
 =?utf-8?B?UGkra3RkUVdHZUFuODRiVlBLbmVBMGcrUytla0hDcjkyMHR6dEc2UVU2Snpp?=
 =?utf-8?B?NEZHU3VPSVNMNE1VNWw1WTBsKzVMZTU4WTM3Z092d1JLUWdQc1pNanpZbUZ6?=
 =?utf-8?B?bGlDaDFoOHp0QlJWMlptR3ZORVlnOHBaR0hCTk0rb0NuVGlkTS9SVVY3S0dI?=
 =?utf-8?B?OVN4SnhKT0MxNzg0bERKUnR3dkhFRitLc2JZOUU3bGhvQkRnTzZHa1NUVExy?=
 =?utf-8?B?c3VOdmhSZzRPL0g3OEYrbDB3R2haenRjTDFseU54cEwxODJZcm04Y3JaNlVw?=
 =?utf-8?B?YmJEN1N4T2szUjZSUDJuSEhpbzZDZjFueS9yK0lBTGppTXlUOGh2VWdKR1A0?=
 =?utf-8?B?aGFKK2w4UUh4L2R1SUVGbk50WklMcGNNbXI1ak1EZGp3cjE4b210RjNpc21l?=
 =?utf-8?B?eFNwTSsyd3phNjVLNnlZa2lIQlJ0L2NGOTlGYVRMdWxxdkI5dElOejhZZ1Rq?=
 =?utf-8?B?NWg4UCt0b2FEOWxKb2RVMTk0Wnk1OUxkUlZ0aEJPYlBONHcrcG93OC90RmFO?=
 =?utf-8?B?YklwZU9CelBTeWlNeEtpemsxVW9IKzBMcHY4Y0J5dW1kR0VjaCt6M1h1Q05h?=
 =?utf-8?B?bGw1RFR1SXJTSlkxYmp2R2laQUsvcTZlbzkxSGczQ2cxeEtOSmxxRWVONTQ0?=
 =?utf-8?B?aE1ORCtCWExBck9YK1pVNW9teXd0cWQxcVZQdWNrZVEzTWxwdlJNWFNoU1Rn?=
 =?utf-8?B?OTFlUVVSTStkRmd0VGtoL21jTTJHZVM3aHQ2T1hPZzFkcEhnb0E4WmtMQ2Ft?=
 =?utf-8?B?Yk1NNWtReFNmeU5LdkxWeTA5Tmo4VURzZi80bFRJNldBTlRiNWtITDF4ek1M?=
 =?utf-8?B?TTBWYWxWN21MU2hWYnp5ZldFM0pVekw1c1ltMCtXSGtEM1pQR0JUTkxPTWpw?=
 =?utf-8?B?NEJYeHN0bGx4V1liS080M0JneFFIdGlvMm9vd09iNng3MG5UOG5WTlRINE9y?=
 =?utf-8?B?aHlaTFF4Wk00anQxeS94ZkpQb3R0MkVlWWFRWkdTK3NwaXNRWVN6MFRuR09B?=
 =?utf-8?B?ajBVdWFmaGZZTXZkcFc4S2NQSllWYjNLNy9hMWxUWmErM3VPQTFZZ1VvK082?=
 =?utf-8?B?cVNRNit2MGhBMEEwY2Q4blk2WFJMWURSMTBHKzlORUxWT0krNkd6aUpkQitK?=
 =?utf-8?B?ZlA0aGNTVThDL2xUN2p2aFhUN3hIMWNXSkNWT1lCalNyZEYwdGpDSzFmSmZz?=
 =?utf-8?B?bmhSOXJXaTBucGYyNmFWMTdrVHNKck1ZTkxWdzVnVnVUb0J6UEYvaDNKUXU2?=
 =?utf-8?B?VnVFazhqR0w1YjhtK0RUMlZUUithTm5sa0FTaE9aUU93MmZXS2tYRllhVDgw?=
 =?utf-8?B?NERBWmRna1JoVHRVeTMybmNIbXJuZ0hHdjFCc3FlSFZMNHp2ZlByNnY4RThi?=
 =?utf-8?B?Yit2Z1Q4TktnZDBrd0wvN3hIZG1QbDhKTlFqYTgxQ2J0Y2p4a21mZFdTejRZ?=
 =?utf-8?B?UnU3dVlaQWZKdzBUSHpxcGlTZXJaZmExWXJBbVNxdks3d0liR0NMT05XL29X?=
 =?utf-8?B?TWoySDJPS0ZIZU1OcHdRNEU0TWZXWjRkSUJkNU5XeXRXOUY3Q2F0MDB0OVZ5?=
 =?utf-8?B?UCt4RTZ1MnFPMU9JL2xJRUZYMEZiaVZIQ1BrdEZRZGh5eVJycUpvMWhzZ0NS?=
 =?utf-8?B?Y290WVNmaVZjc3hPcy9HOFRicDVGK0pwQzJxb2RoUHdnUGpDeFZUeExPSWNY?=
 =?utf-8?B?eXRWendUS3h1RzRKYmJweDdqKysyWnR6VndnTGZRTVdqbHF5UlBEK2UyandO?=
 =?utf-8?B?MFIxTGE1M3ROdjFlR3ZiRjVVK2hkNkZnVno5Z1M2aFRGOU13cE5FWGpFUCt6?=
 =?utf-8?B?NHhsM2FRNUFUSlVyRHFhelpCNUMrY0JaV2dBZWJPVkZkNDAyK1JINkt5YmFG?=
 =?utf-8?B?enpWVjFubXNJcERSRWhOeUt4UnhqMWlIWC9yaVNEUCtYNWVONEQ2YzZITHZO?=
 =?utf-8?B?U1piTGtaQTl0UEQrVzBZeVRxdnVkelQ1aVNWZjVtV0pxcXVJb1Uya0diaGVW?=
 =?utf-8?B?cmdUQ0EwMzM2c0EwYmxpenUvemdIKzhkdEhhWlozL3hwRVBaQ1BsZlJDSjhw?=
 =?utf-8?B?YW5LYzBBWFZDbElrSktZL2dCeGxtZzQwcUhYSElZaG1DckxhVms2amNPQnRp?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dffb6a-74b2-4adf-c5ba-08dbbb5b8fc0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 11:03:33.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGH+TSfeIJnBYnMDC7l+lChLTtZCWD4I7/BhxtqrKaXFake8Qr+Xk00bnEXTsMqyFEw8M/lThQegK9Xiac+T0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6348

On 22.09.23 12:21, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> something regressed:
>>
>> 2023-09-21T18:21:40 [    0.000000] ------------[ cut here ]------------
>> 2023-09-21T18:21:40 [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/irq/pipeline.c:1829 irq_pipeline_init+0xbc/0xe0
>> 2023-09-21T18:21:40 [    0.000000] Modules linked in:
>> 2023-09-21T18:21:40 [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.129+ #1
>> 2023-09-21T18:21:40 [    0.000000] Hardware name: Generic AM33XX (Flattened Device Tree)
>> 2023-09-21T18:21:40 [    0.000000] IRQ stage: Linux
>> 2023-09-21T18:21:40 [    0.000000] [<c03117e0>] (unwind_backtrace) from [<c030bd10>] (show_stack+0x10/0x14)
>> 2023-09-21T18:21:40 [    0.000000] [<c030bd10>] (show_stack) from [<c1092dd0>] (dump_stack_lvl+0x8c/0xc0)
>> 2023-09-21T18:21:40 [    0.000000] [<c1092dd0>] (dump_stack_lvl) from [<c0346b00>] (__warn+0x88/0x128)
>> 2023-09-21T18:21:40 [    0.000000] [<c0346b00>] (__warn) from [<c108ea28>] (warn_slowpath_fmt+0x70/0xc8)
>> 2023-09-21T18:21:40 [    0.000000] [<c108ea28>] (warn_slowpath_fmt) from [<c171d37c>] (irq_pipeline_init+0xbc/0xe0)
>> 2023-09-21T18:21:40 [    0.000000] [<c171d37c>] (irq_pipeline_init) from [<c1700fec>] (start_kernel+0x4ec/0x6d8)
>> 2023-09-21T18:21:40 [    0.000000] [<c1700fec>] (start_kernel) from [<00000000>] (0x0)
>> 2023-09-21T18:21:40 [    0.000000] ---[ end trace 58996bc4bee07162 ]---
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693461#L544
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/693455#L543
>>
>> Not seeing this with latest 5.10-dovetail.
>>
> 
> This means the CI runs a SMP kernel on this uniprocessor SoC. It's fine
> except for latency measurement - the impact of the SMP glue on the worst
> case figure is noticeable in this case (+10%). Anyway, I'll work around
> this.

Yes, we are running the same kernel config on arm in xenomai-images.
Given that you basically can't buy new single-core SOCs anymore, it's
more important to test and qualify SMP than UP.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

