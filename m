Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22588834
	for <xenomai@lists.linux.dev>; Wed, 21 Jun 2023 06:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQpc1B0do9BpDs8X6dBb+mCPagMZKZ7SYBfdbmq1y4HBx9Qs73iEL4AixlYNNWlOXF9TbtTl6cWFZ4r9F4haAlsWDMjSC8K5ZAEyrP1BNUvpJfQGwpnN0dzFGUdi2geVeBtkiVzGGrPJW/NS9TcMuzkFOfXiomU9KVAJeq+mBSYkdgWtLms15zWqwI/jAgSu+mdgbBrjvjYy2nCajK2Soyb9HxR2IJeL06j+Vf4925RjLoUvmi9vSQunQu5PU9yvBeY3YCa6aa9uHaVNB1es2ZiIEtHnqD7s5RnbBhBoysExeBySfubbcuL+O0DQUzhvxtSENmJwJz+6RTRPmzWY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNqjhRP2iKmhSNDQlF3CTTX6HZKvxyRAGTpHrvHF9xY=;
 b=CI/7kAmZGshIXm56CE1xeThrpk/IzHgtcmEGQbXxpiM8uaBzPB15CVNibHfmXAYRn/s8BhmehJjLMUbxPvz29dlBHiZaFIwtCY/WTOJfbazjJudniLb65kcFrAAg7jREmf5y6eMoRolJT1QuRQUur5xZwR29ERhphKTToYpOL9BKdQiDRAjeDULxR6J6C2Fyj7sJRUPJPcXEoH1iSkcUfSJw8Q6pe2Qw7jATctHREsr5rqcXA4JP0itkqrV8TnFjLFL0FOxh1JmKfbV3MKuUI+70bDahASuMMlKzu4cYnbFqUWRfxsLdB10p0aVrUCOS4kuZkQjBr18+RkCVJyPCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNqjhRP2iKmhSNDQlF3CTTX6HZKvxyRAGTpHrvHF9xY=;
 b=lZfsydjcGYnB08XzXssD40KgLgWqK7w3nepyTwj5gxNvY26JOAOT1CNKyyuKKFdzRYb6Njokv/Pvebi7qJ7JcAlQOLClWr2vQ+HYI+dxOZLBJqIgWaGdrtWEcvghoGVDe3XbWat0g9C/g/dEqb6wENVk0wHlayApzdef3xzg4m6QZhNA+KpLxCn4CIQvydXE9khKdKIV4+0EnSaQ53XrGe5Xnk5pWF1aSaik/HEc8sYQY/pTC5QUrlMtpV14gKFll+iEVE0ZQIewbp33SdRHnpRjazRuFKMMnGJzBE+656PkGlEHX65f1620yoJckVV4CHsmevV5HRX6/otRF7a89A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 06:24:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 06:24:51 +0000
Message-ID: <2f5af611-8f90-3446-042c-6ec33a9d719d@siemens.com>
Date: Wed, 21 Jun 2023 08:24:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Meet-up around EOSS (Prague, end of June)
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>,
 Richard Weinberger <richard.weinberger@gmail.com>
References: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
 <5a62a0fe-d60c-9ded-cf89-2ebfc53a85d0@siemens.com>
In-Reply-To: <5a62a0fe-d60c-9ded-cf89-2ebfc53a85d0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ce0e05-a821-4d48-65fb-08db722037c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IQN9GkwHPX3i+TBtsk7mtmGA+tCO20ff6sSYClo4A7zK4ENC6BmPYhZTcjQvX4mISCGEw9dwTeSK+qNgv4MljPU6vr6CX46xbmrD+BzOocnww4UfdztoX7popHPblQbz7f24KbSuHWCHsd20lsOghg2kMZLHKJ6hy/m8wU7Nc93lLmxn0slNR4mz8kGY7+H7ejIKGS04245KfHuyvBmdR7XNQKOdm9nMn/bEBUVWUSVWq0DWUOH4cqHOuJ9HV+bdgKmA2dUsk/Ao3KkUVif0cjEWJcPW5vq0orCpRDxfTYEww5vD6e6XJry+nKlgzNzJ4dqmSnGe02yZ7jTzp8AtnhIG8LI+DaaGjlUgXOuIQVivbMIdoQF3epCAjaCeNULSHKCXxuVnW39w+vcbpI480O4R/KQpvvChAQPc69Y4fkimnVJSQDUjdNugp/8fwL+ZRFB/Y2RNnM/NBwXgP9Ti5pe6mrdP8SPPr6Nh4UiDSUPfVRpDMbBLStc0XcWxweR7cOTbC1c7QIc5QockkmF3tzO3D+9ffQVBnJbKKC3DbEkeejFTo4YGUDfPvyNDOZLqDsJRJ9X159YsaAYn9GQy0gcjGXWhu4m6Pk5ggLODGsG/sXD7HbQNeAazBpDIu2wPBC6EEEcwEHHBNN0SFf9+og==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(2906002)(478600001)(2616005)(5660300002)(44832011)(8676002)(31686004)(86362001)(31696002)(83380400001)(316002)(41300700001)(66476007)(66556008)(66946007)(6506007)(8936002)(186003)(6512007)(26005)(53546011)(82960400001)(36756003)(110136005)(6666004)(6486002)(38100700002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azBwaFBsME5PbHNwTlBjSHFXNFB0ajg2elpVOVVCaGl5dm9mSk91MnBRMlNz?=
 =?utf-8?B?TDFvb1hwdHNaQytDcXJrcjlmZFR4WFFCYU90MWNhZUVYZEZZOFhmdld1c1ZR?=
 =?utf-8?B?dUV5T1kxZnRZLzB3b0pzdmd3ZWhwR0JiQWZ5ZXBYQXYrZlhwZndqb2Fscnhk?=
 =?utf-8?B?UUgwUkYyMitVRDBKaHMzb2tPRGR3cnlPT0lqb2M3OEtqWWdSajZsdk5oaTRw?=
 =?utf-8?B?a0tKMUcvNWtINjhCU0pDVGRhTFVyQnlTZmxlNkJDQkdwYXRlOERiV1NXdTQ3?=
 =?utf-8?B?S0cvNnlKdFcrUmc2dUVWQjJQd3ZodlJ5Q0tKWXBMRXNtdFRVbzRVdFg5aExM?=
 =?utf-8?B?VXBjNi9QWkxaUzdlRmRCWGNIZnFOVlFIdng4bXczRzRMVEUzTnErWnl5Q3cy?=
 =?utf-8?B?QmtMRFdaL20vY2YxQlZIdk9pMlEwUmZpUFFHQUR3a3VyWjBOa0MreHh0c3ZL?=
 =?utf-8?B?SU80ZWszdWs4ZWN2Y0R2ZVh3TEdWL2IzVm44L2EwMDJuSUV2SE5BRjVZUXg1?=
 =?utf-8?B?d2lmbDA5dk9vWTBzZktBZ28zZTk1azBVaExKUkZyZWFuZ1ZrTkV2WFJubHgz?=
 =?utf-8?B?NUVvZXM5NkpYTFZLNGhGRUsvZm1adTBFVUtzc3ArNENhRmhSckFTSERLWTkv?=
 =?utf-8?B?TVp6K0lSSGhiSVo2Q1FWK3FGclpueWQwZFh1ZXNDY2hkQzZYTVc3Q3JVRmV5?=
 =?utf-8?B?TCtDTDZYRFJiRHZOVUFHY3B1b0dvK2xOaXlUUStpbHVHcjBaeGJRV3N2eVJ1?=
 =?utf-8?B?UXNOc2tsNXBrdCsyZnBLdU56R252eTlFRmlXUnRweVV2anY5T3ZJL2RCUCs1?=
 =?utf-8?B?MWtWalZuVmIxcTJwVmliYVNqTjRRNERDM3JCeUpCcFR5a2w3cXFlNVVzbDNp?=
 =?utf-8?B?RFozUk4vYVVVdFk1ZlZOaGw4VERMNHcyS3hXTlA5ejNZSzNwTnRmd3JxWXl5?=
 =?utf-8?B?Vmh2M0QvZlBoREx2empkRWVkMkVweUI2dFJlL3VQQXQxNkxBcGVPVmN2Z1hF?=
 =?utf-8?B?TXA2RVdTV0ZKMTNHdTFLUVpITGZJbHl5TTg4WVl4WHd0eUxUTjdhaUlJR3Ba?=
 =?utf-8?B?UE9RcHVHcHhEakR0amlsVUdWcmZTQ3FOUk16bVExOXRQVkN6Z1VXWFF4elF0?=
 =?utf-8?B?Y0tnNkdHUWJqbndBbHkxUnI1bFl5ZFpqcVYrSXRJSVlaVllaalpHWi93LzZu?=
 =?utf-8?B?cGlFTXNBNUlnakhkQUVBRjBidDFBU0VRUXpwdGRiQ2tRa3RhaUU1OUYrYzJy?=
 =?utf-8?B?U0RuNm5zaEwwK1ZneE0vT29nRXJ3c0pDRUtjaDduaVE3REpVeE5qZ0FYOERm?=
 =?utf-8?B?UThtYndEM3ZVZnBGZjRCdzAvWStUaG0xQnlUY0JtMTNBbEdaVmlodEZGbEdQ?=
 =?utf-8?B?YytxZUhsbG9veGxBVVZlaCtGSlhRYWk0eThaUWlYUGViQTAxZzRKNzFHQ05n?=
 =?utf-8?B?eWhmajc1YUEyZmhjdGJtVGRFWU4wN3lNeGdNdXJoRW9pcEk0WHFzT3dYME1K?=
 =?utf-8?B?UXZOeHdQQUVCUVJtSGZGbCtDQUsyNlNvQnhvTGI2emZCdzJMTXVnWndRMkJh?=
 =?utf-8?B?cVRWRWZObHMwa0JIalBWaFlWUlRMN21FdEpsaVhjRmtFczZjWlE3cmJXSnJR?=
 =?utf-8?B?QnkvTnB4TERpYmJEaVZyZ0ZEdGhUclkrWmNJakVManE3R001c3ZvZzdZL1Ay?=
 =?utf-8?B?SzRYYUdHNVFuMGxGQU1YK2pzT3MvZTBlTHJLSWplOFJkS2g5Nk96aG5KY0tV?=
 =?utf-8?B?bFlTN0RFOXVoWmloclludFgrWm9XbUUyOE1aVnBDNHF0UWxxYi96c1NJV3NT?=
 =?utf-8?B?cUFGeVFCTnZPc2wrb1dwdmd3OWlsTDJaY3FMVXI5c1pnR2ltVldQUnBFeWxG?=
 =?utf-8?B?cjIwYnRBbSs1VFNpQTV1T0Zsd1EvMlhDVGk2SUJqUnE0UzZqZUg4UFgxZGFn?=
 =?utf-8?B?blFvMVBtaFRWV2lad2xsTFlZZzZubkxOQTZMQ09qYzhKSUlVMldyajlGYXpz?=
 =?utf-8?B?V09meGhJc0lLVitMd0RpSUQ3c0RmZXJuOTBuQ3R5VlFDampnczFEaXdoNUpX?=
 =?utf-8?B?Tkl0WCtEVVBYWlN0NEROUVAvcUROTUJGRythQlZ6VTNEK3FFK3pTemJxSVhV?=
 =?utf-8?B?TVhjYVJVbk04VDBXS0lJOVlyM1hXK1R0cTVhVmM1QU5kL2ZwT1J1SEFMaXVT?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ce0e05-a821-4d48-65fb-08db722037c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 06:24:50.4688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnhXfVUiYno5EnvtcZMDSCkzEBQKex96tGfnHP2sOFHx9bLlohgqdqGT9INrY8R4R1ak+iXKJ9MO6Tm4i//i1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6243

On 17.05.23 09:12, Jan Kiszka wrote:
> On 22.02.23 08:32, Jan Kiszka wrote:
>> Hi all,
>>
>> as just discussed in the community call, I'd like to propose having a
>> Xenomai meet-up at or around the Embedded Open Source Summit in Prague
>> this year [1]. If you plan to go there - I do - and are interested in
>> chatting about Xenomai topics face-to-face, please let us know.
>> Depending on the feedback, we would make this more or less formal, from
>> looking for a real meeting room to defining a time and place to have
>> dinner and beer together.
>>
>> BTW, the CFP for EOSS is still open for a few more days in case you want
>> to talk about your latest great Xenomai project at this event.
>>
>> Jan
>>
>> [1] https://events.linuxfoundation.org/embedded-open-source-summit/
>>
> 
> Just a reminder that we sitll plan to have an informal meetup there,
> likely in some nice place for dinner and drinks. Besides Richard, at
> least 3 more folks signaled to join.
> 

Richard and I just selected the Tuesday (June 27th) evening for that
meetup. We would meet on the venue and commute from there, details to
follow.

I would currently plan for about 8 folks to join and look for options
where to go. So, again my call to let me know if you wanna join in order
to reserve a suitable size.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

