Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1F18C3D
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 14:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgD6ijWd7UgbqyqzQvjTRtCl8OeFyOjuNLMidA8qHBS5IfoFelCRoOeUZnUNoP0T8DEa9N8is+oeYZBJUl6zdF9BKy4JkAQurPYp1vGfjdtE9FlXbrvVgOaXwkiKizIo6AZtpiCoh3OzWAFaFN4OB/tBTBp1eETQWg73252j5wdXMXipcHX/+jqgGrfvtk2F66LTMQ++vy69YRbJSgdbXEBxXzv0R3NGhvbgcUefNC9otOk4S7t1rBn05aktWiZzrI9rAX5klnU3qiB7qOv3XLQgEfvA5UYoG9mqMO+tCIeKdPKrjaQ/JJCicZGV4/dsByKz0Gm9cTDc1cKyxh/Ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz48OUHzGEICMg2q/yuSLS0Mv3V7/IR+qYwdF0Uss/Q=;
 b=hiLhOSi1oV84iR1/5ng2ulVdQkQHBedgDHqltUlRrEj+1cYgHlizTM/AU11qgmBiDMNvLcDV4BPkSSSL7RGiGuUsB1kQ+vJFtvdTDsEenf442dyu4KVdHNVLjfCeRpSfgAvJmXLFItm77Yt/84F/E/65nr79hJgZOSoMw85FhI9epwlVH71zoaFJoZStHa35EbVFVxqwtuQ3bTYXhIVkZLgpxZIymgtqeETL+toR4VzBlkwTD5YcsR0MaNS85Dga/gYEnvyaszEZYMjkbeJuzSLixlhUhf4mXOhegZkfMgcsqbyBBXKZkaz3cWuZ9oo7tlLTVd1k0Ywx+siWsSIouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz48OUHzGEICMg2q/yuSLS0Mv3V7/IR+qYwdF0Uss/Q=;
 b=SAPloPTvsC9y8F/jznmOYSdfOl8VBY/6SZtxYPa3bwY9bosnPkcJpM7J8HV7RuxGQyjyhTrfcXOyZjBj8qf3nsNr3Bh3G9XUHayXso4hyKoozL1W1ExuttjbQCHg4HbkNza9glPjpulsmAW7a8VnTyGaowX0oTF2Vsj5qe1z3b0zzJGxg2+KAKLkUkn1zAmNyeuO2d+O5GTl8yJ+mmMvOAm/dVyv+Tbhhd3b8syjxm7D2Ugpkj4uZ2Tk9wNGsd53pXMHfF1urLO4XIMccpvjQZx0vJN7RwLkCcNTEcyNXt+3xbrZ/xyj1nRC5XZGzB6IzQABtMephj7KrGqC2KdAaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6443.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:02:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 14:02:05 +0000
Message-ID: <c0b1faa1-d791-4245-bbd9-d0156032d9cf@siemens.com>
Date: Wed, 9 Aug 2023 16:02:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debian: Enable lores clock by default
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>, Aaron Marcher <aaron@sigma-star.at>,
 Richard Weinberger <richard@nod.at>
References: <13d42c4f-ee14-4105-9fdb-ad371af50d41@siemens.com>
 <a4bfd7f4abdb40bd676030862b6e070c804d6b6c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a4bfd7f4abdb40bd676030862b6e070c804d6b6c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: c23c3e3e-413a-49e2-313a-08db98e1364d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m1NbRh9CkOHAVYfhS83upwjdAKehzM3SvUcxoQ1dlyNxAlLTT1w4wTg+r8HSkqpBz2/2eqD0kV+IUdC2ZDd83rT+7uO+aoad3uOsbiEg9UiyWEV0a9DdvB32l7NsQDS+dt9pebBphvTfhjlWJZJDY5QbzFTofurbeSaZsn1PTRP+fA18kcd7n2TaCiIU2wRjUsNRdnDJRSGyN9UBp7SlQMD6AMYHpMAdvitOIAfgAmYJGTIRbNs1Kc+xXYO1mTTTIvwyTESNlM9H5Bbuw0QUTLrjr2nlAgl4WWlfLFi4U8clf+GP5HZOoU+o/RHvfoCO8dQET5uU3eFfFTqblyPwkY/LjRZjIEHKnmrV4qmIP/JK0S7rGGfn9i5Nj1bKj0tMfdZ0Rsy1m5VhnBoW0gqCzPOcWwJpJO0gvO4zKzGrCJ/2nD3Jz3uftxOXhhuas8/SQQz+MzHuDpnBi5OttGt5Q2OSAohfUqfM0hsh+40+DYDHzwRB/nUjwfXNFqHA1zlOCeyjL8tgpI+6G44zMgDokhSBluFK4FXq2DPI4YLQd1SL8W6QlIbW/mvpvep6EsvULS/A9jFJmoi2neVWwQFyoKW7w1GZh+JDpaxYI672lsqJRgIBqWGGzmC0GJ+FK2uyo0ci4qgHdAVx/tZkMoPdFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(1800799006)(186006)(451199021)(66556008)(6506007)(53546011)(26005)(6512007)(6486002)(6666004)(86362001)(31696002)(478600001)(2616005)(110136005)(83380400001)(316002)(66946007)(66476007)(31686004)(36756003)(41300700001)(8936002)(38100700002)(8676002)(5660300002)(44832011)(2906002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0VHK1k5ZjZZdmNoaU5XVzczZXVVWGZyQ0VxOG12ck1kZER6b20vODlneGVT?=
 =?utf-8?B?TXFyY3d3UnB4aC9yUXdwTHpMSWJKT3lVeTRDMkpYSnFrY09qdHRPaVFZS3hJ?=
 =?utf-8?B?VkhzZTcyU3kvK0pDUTV5QXdxWGJISVUxcExsREtDQTA4SndzMW5Nb01xTG1B?=
 =?utf-8?B?aCt2NXc0d2Q1QVpJamlWendIdHl4RnFoZGY0cFZLaVVRZ2V2UTR1OGJLY0dp?=
 =?utf-8?B?L1Z4TkM3QkI2ZEloUmtrbEJyQkJsMjhGVTZDWWQxa1I1NC9YTVZzOERFM1VG?=
 =?utf-8?B?UTFTcU50enVwdEVjNmordU84aE9YRmNqZHFWL1hFb3FwZWtFSVpxOFJIZXJG?=
 =?utf-8?B?ejNOWjI3YmVUNlFRM3Z2dFJVYWYxellqUnFDSExoSmUxNzNlUWttZWFZbFUz?=
 =?utf-8?B?Rm9lckZkMGtmWjBudVF0eWFPc0NNOUxGV05OU1dqSnNTN21YUDhEM05rNmxT?=
 =?utf-8?B?cWhvUWtFekYzN0JmQk5CYi96blRkL2x3QzRrY2JLaVdGanVYczlGQXhqN0pU?=
 =?utf-8?B?eFBvRWVSUktoRDV3MXB4NnFreDhRdkpyOVRTNCtHMWE3K1ZUVHdqdVVRNFU2?=
 =?utf-8?B?bEdweGZHMmZaU2hMZUpoNFI3aXVEUTBrWHh5S2tGMkd0YURjbENRNmUrcEd5?=
 =?utf-8?B?RFYyRWlyTDFRa2dVRXNYaEJQU2tKVEEyMVZ0ZURmR0NTZUtsQkJPNEhRS2JT?=
 =?utf-8?B?c3liZ1gvdkdZVWR3VFJyM1AxSzcyWXpSd2RHZW4zdForUXU0YklKeDRGRURP?=
 =?utf-8?B?Tm1HYlZjUXQxRVpWLzB1Ym5hVkRvemFEOUhwSXpPZVlhVW9nUXhEWk5GbHRI?=
 =?utf-8?B?OGt6Umtnc3lIMG1ySEdlVnYvdDdCcHhEYlEyRld2WU0xSjdpcS91Njlad2Ns?=
 =?utf-8?B?NjZ0S2xqekNXeGJha1dqaXJVcnRmVnJjUE92d0ZuRDRlK2NqWXZzdkgyYUhO?=
 =?utf-8?B?cWdrVUc0dER1aUlXelAzb3FuVjd6bGlXNzRPV3Azb1pIMnJRNFRJRDJXek5u?=
 =?utf-8?B?THR5MGttY1ZkTkM3aFA0RG44MkF5Q0ZCaGZndEN2eVcxNWczMGFPc0c2Rnpl?=
 =?utf-8?B?cWpFUjJYck5Bb1cvTWtocjM4ZTdUTCtSa3FNM2FSZkd1elgrbTBkd3JzMEhO?=
 =?utf-8?B?ZndzWUY0WmN1RnByd3BOQTdxTlpiVW5aUnpiSTBtQ2pYb1pMMENRSDV0MFBL?=
 =?utf-8?B?MldTUmFDWG5Hc04vaUd1a2tPWGYvMzZEdGhJbHJCMXZXOW1FYzV2YVgyVURt?=
 =?utf-8?B?a1Q0ZmE0Zy9ta3dFMEJPU2F0UVhaREpQK0VJK1FrUmdpeFkxODZia1Uwd3NC?=
 =?utf-8?B?WS9QYkFlc0g0M2pETWt5bElZVHZFZXdFZUgzV2c0ejdvRDlFNUNqYjJyZDNR?=
 =?utf-8?B?VW5uNm9KYVVqcVhoKy9EZnVIM0pmMUhEUU9mTzNvbHYrdWlLTXBsSzFSaThT?=
 =?utf-8?B?eGJERXZLWU1RcjVURUhLOEJuZ0hFOUlld0lkYm1ZSU5wUHVvT21hL2I3R2FQ?=
 =?utf-8?B?bC9QUVZOdkhRZURNazJQSDI5NFAzRTlvQlFpaEh1V0FpOWc2QlN5QzJ0NE94?=
 =?utf-8?B?dmEyR04ycERxMUJ5bFRLMzRkUDNMOFZSbnU2UEVTdHZPc3pRVUlXdHJIRGlF?=
 =?utf-8?B?dWx4RXBVbnBkRHBnMDdxSytQQ0gwYllRNlBnSU9UZUU1c3I4dFQ4dlFBL2RT?=
 =?utf-8?B?dlhWMm55bndtdWc2aTEwTjdTTU1Vc2FmRlE0RVRmOE5wSnREMjVoZ1RNRFpH?=
 =?utf-8?B?NVlaWitBWTBER3NkOXZxdUNkVVl6L29RVmNHdlk0Mi9EemFkYlFNbG00TkhW?=
 =?utf-8?B?Y243MEJNQ3FjeHdqY1pPWkxSWTk2TVVjSXYyYnNJMVc1TWQyZHlzeDJ4YmFo?=
 =?utf-8?B?WWQ2UlRFa2FYZE5zNXdYVDFkMVVZSWczS2EvVEIvSEZNbWtWbENUdkkrUFZl?=
 =?utf-8?B?Y1RsSmdVZzJWUXBzYXdqZ3EzN056VC9rbzR2TFAyOU1wOWhJbDFjSkFOQmZI?=
 =?utf-8?B?RmxiYnFCVGd6emZUM3FvMnpRTk85RXV1U3R0WXNPRmdmT0lHa1pmaTdtVTJ6?=
 =?utf-8?B?WVlrcnN6Q3JnVDJiRGlndUxxajhDYThkWjBXNkpZV28xUXhlYlFnOXZhMHVY?=
 =?utf-8?B?YnBFOWs3ekdHQnFBeWhRdXNkTEpkUU01cGduMzJLeHJtbkNFcVF2WFJNVW9T?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23c3e3e-413a-49e2-313a-08db98e1364d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:02:05.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JIDdYIUoLuVnXayhj1qqt/v9IU1vt29N/1uwBFFkFPJ0d9Imx7lFx+iijHi/yIJ7Sq6GWSIr4m3R3VJR0lTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6443

On 09.08.23 15:54, Florian Bezdeka wrote:
> On Wed, 2023-08-09 at 15:32 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Having the goal to be generically usable, the debian package should
>> enable also this feature so that pSOS and VxWorks libraries can be used.
>> It comes at the price of a slight overhead in time conversions for
>> hi-res interfaces such as cobalt and alchemy.
> 
> Do I have to expect any performance problems now? How big is that
> "price of a slight overhead" especially on x86?
> 

No recent idea, someone needs to measure this again.

> I'm asking because internal customers are using the debianization "as
> is", if there is now a need to deactivate this feature for them I have
> to be careful during the next release cycle.
> 
> I see the need for activating it here to get CI running again but the
> test should not fail if the feature is not available, the tests should
> be skipped, no? Would say we have a "double fault" here.

Making the tests skip if the feature is not available remains a todo, yet.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

