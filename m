Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DBC53AF
	for <xenomai@lists.linux.dev>; Wed, 15 Feb 2023 13:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQi19lo/asoZgFfpg9cFPX7lBairSx/dqpUgGVO909jmDdRYeYHfbazELWsbaCyRSD50dLtbOH9C/Yo2Qky5BPP0UquptFVPjxamHhhBTqw5uCRcuklgLJkeOpYpO9cPafpUOW050XvwlXpjNjU1gC96ncpV7HmHZkPqw+A7+bt3nFls9LauhOm/jp18fZSKvNAyA/nKp4D0noEFtdL4cIn2gn7OnF1tYs4N11ASPL+CRbIXrsXcikLZlaIW2b6hnIFsTLZeL/9VcwUZxofNAmHzbNZUqMWwYs7b9rZxQ6/WsUZ2+nHkQ8Y4zx4EDt7PZziiGjwkShlQSkgsMqRw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bopuz2M/EcQrgwCFdjmu5fpmZds0VzdKQsNxW2x3to0=;
 b=gMu+RlKrEQinbHX/o7+fqLRK7GVMRXBYLhJixTrGtDyL/1pYCStMlsekS/QvKwhcsYBkPD+Wa6dKWhtROPIIAbM+BQ80BdQmQs4tAHgurLW+YI45J9s78ltTK63KXk1dcaB6bk36VEuUf5klWYMozDi6KR7Q8fQzQpKbKg/YyDIIDxxNprRj0RAzwBKcTEgxzDCzx/TFsC/U5XrK0WjbtFhAYtu4tNT/eAyzGwC/P98NSgUxK0/QxaMiorxyyGEz3pCw+uEveJikIf1MCm1kfHjBtBn1lmCBxHNLs/+Ygxiww1gs0t3YqzHyW+pkj2LZlvgAzQEoziHlZEOCnCKhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bopuz2M/EcQrgwCFdjmu5fpmZds0VzdKQsNxW2x3to0=;
 b=G/74cyFRIbkh8J++2UyyF8wWLG1gVxfajHFiWaDOEBx99jpcPE0tzWjf58/m8H4rMTO9ZCnXgDObL+soYfK60PDKRWoybFOyEtT10emhrcz+Iv+BjULOGXYnKtK2JAvqpkMhJd94S3sUuXwNX5MKXvDG/X2yxbT+twmctkDPaIQLeH9UwqU1luf4jU3KM0ZPAJ4VcYOSXTcvLGqeuZhOKwuxf2J8xxtBbBCmvNIfeZCsovquwQMzl60UUi5nmd6w/ZKWPzpfrPA2iajPtpYBmxIc+78z3b9EJlY4q50qGZ5Rj/T3sfCFsZ4kl1RiJVEum+a+SQf2uRmJ6tyt/HYI0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Wed, 15 Feb
 2023 13:04:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 13:04:44 +0000
Message-ID: <31d280a1-f7bd-fab6-2e37-fc9dbdaad400@siemens.com>
Date: Wed, 15 Feb 2023 14:04:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: about rcu_preempt detected stalls on CPUs/tasks
Content-Language: en-US
To: "Yao,Yongxian" <yxianyao@126.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <502ffef0.6ee4.186548762d8.Coremail.yxianyao@126.com>
 <f2b91213-82a0-f78f-9948-3c7f9a13888b@siemens.com>
 <6cb72fb7.7353.18654c1e3da.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6cb72fb7.7353.18654c1e3da.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 15be5802-4ffb-4fd4-e27b-08db0f553522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W6ntGN83E1Gvxc2zZ/br6Y+AZvGInCVLpWwqGjJKlAfxcjTUwKHI0k5jjafwfNEVrL2PF0s8F6vjmfImrMmPsIgpem8KrUaFzBqWpXWjjbQelU6qwJqKe49vyuOavaz0SlMYxoWjmh+7R6KPsJnKXzbnayGbrlyPp64GOv4dOS6mW7cqIP1fI1R2D7ovO4fZP92RewneGXQC9mhBqokAzhBqdfWA7FipQNqmLxWhS9k+bwNcBJNzGkw4NTLngOVHv/IYTbh42kSl74rkSCwDaRIsaCDeksSPNSg6Zt8QYXjPD9ilY/zydkuKGF88HRAtegeyeb8k4IiBcr9FAlXfrdpTcGkyt+6Lu4r8yxjv8DTuFb5T8zqzSLT3oIEfCI5li6XiNQ9DmMAbtpX0h1wF1HxJpz7RZyiEsYFkBaMf0sUnl9pMO/9EcRkAMz0qblKBUlZCSNEGBR4g7KfPaCFrwnjjnXUCseBVMF9CNol+J6+X6ekUTWaHpYfWKX3dlCv2lds9TnP+buawy1skKrTRznaluFr3+fMgAHnlNwcytLah8onhJnxAm0sx1fcNVkGhhlImEDcRkypEghxYGfv4woOyQbq13ERR5XnB3SK4LUnl7WEEK3cn/X2SZkb0aJtUPxU4RdQVn2N/uQlfjmhzrrDJHRTgqFeezz+SATdRr1Nlq5Q8mmt4ep5QGikXBprh5qgGbk2HfPp6prrPrdcE+B7kczdxvTWL39amjkOB+TY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199018)(5660300002)(86362001)(8936002)(6512007)(38100700002)(83380400001)(66946007)(66476007)(6916009)(41300700001)(4326008)(8676002)(6506007)(36756003)(478600001)(26005)(6666004)(82960400001)(6486002)(316002)(66556008)(186003)(2616005)(53546011)(31696002)(31686004)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2FSSnRJdmx2L0NpRkVhOXcwUUpVS09FT01wWkVsbmZGSm1sYm16Y2V1dExM?=
 =?utf-8?B?WXVHSWt1bzVYYW1GT25sTFNZWVRNNWIyc1B2Y0NLcGpDakh4ekhmY2RqY21y?=
 =?utf-8?B?eXdDd3V6ekxDOEZjd0hZOG1kOE9jV3dXNmwvc3lMMnBsQ05IbFRqTlpKWmlY?=
 =?utf-8?B?ZTB6NjYxU1lEa1Y1QTFPYm5kTEpvcVk1bDVtTU1JcVlQVTlwVk5rMFF0YmtV?=
 =?utf-8?B?aTBvSEUyLzRHQncybnV6MHpUcS94MGtmVHhoY29ZYWlBRzkwWDQ3cDZsREtw?=
 =?utf-8?B?UUluSmU5V21HS0kwTmo0RlhQVElzbDZtWjhoVXNXQzhIRjBmU1BiVjY0RDNn?=
 =?utf-8?B?TW55cWJyaGU1U0JCZmQ0SHVJZUR6TWh1by9qSjBsN3EzeEUzRHhGbDd5MFFu?=
 =?utf-8?B?YmdBWGZacUxsOHpiaXdycTFMQlhYcWdGWDQ0RnBtZGR1SzlkQ1hENEI1R3J4?=
 =?utf-8?B?MmRrTVk4NmtVdXh6UkpiaTFrZmNpUWsvREF2SHp2OG85NHprTVhiT0ZUYklj?=
 =?utf-8?B?ellLbTY3RzU0OXFhaXhHZDc5UThDVE5SSHVsekx1VDhRSDN0Yy8zUnI0ZG10?=
 =?utf-8?B?VWNPc0ZBTDFrQlRSN3dtZTA0KzBISHplMGdzd21kOGgwMm80aTl5TGZyUEcr?=
 =?utf-8?B?NS92Qk9HMW5BNFdpb1pTd1lYNVpST3BhQ1YyQ3pTdE85bFFzSGR1K3hzVDh5?=
 =?utf-8?B?eDY3UFVVSzBFK2wvcnlaRnBVQ0dNc2RsVlZKRHg5QXIreG1uNVZ5UjJhd0dh?=
 =?utf-8?B?alRGMng5NGVVa0JHSDZqRUxXdkZTYzZBcDBjT0pDeEdjMU9zWGxFQ0tvTkkw?=
 =?utf-8?B?NGdNRnk1T29xMHo1SzRzUWw4RS9kSW44WlpUclJQWEU1cXFuNHpKOVhWRjlD?=
 =?utf-8?B?ZmltV2lQbzRUZGxyUXpIRU8yd01BOEFiVnV4bGNDSnJtSWtOYnNLNmJ3WVBt?=
 =?utf-8?B?emNCaGwyZk1wUXFSbXNlc0duVVZaSXgxeW5DZktpbFo1WXhxWCt2R3huNytI?=
 =?utf-8?B?WW96MWV1eTl2dVZFa3EzZW84aFdoV3dDSEF0VGdsYjRGZ3N3cGNtc0VWYkJi?=
 =?utf-8?B?b1pKWi8yaC9DTXZEZDJEak5OdHlHVGtmcUpLNkZzVklKNWJ1MlV2OEV2dXdO?=
 =?utf-8?B?K2VVZ1BUL1g0a3owYjB5VGowV1JyN0xZSDc0L251TmUxV2p3Nldrd1k0Z2lR?=
 =?utf-8?B?NE9wcENla3pxeTd2em9HY3VzQ294TXRWOGczcWdyK0p2Y2UzMGIzVndJMFpF?=
 =?utf-8?B?NnNoWDdJZUtLd2hRQmhHMlF6dlpGeXVKdHhBNWgvTEZzRnNWeDZISkhDZGRs?=
 =?utf-8?B?dncwN25zY1RkSjlPdkxuWjZXYWRReXY4Mk5FdGtPYVFCa05rd0o2Y1A1MWZO?=
 =?utf-8?B?TXRuREJiUjNKa0ZNM0cxbENGWWJGR29rNXZVV0NhV1RCUmFmSGhWVGRJMWYy?=
 =?utf-8?B?WTYwQ2xBM2ZMQm1pTi9pTG1RaDY3RURlT3YvRlNLRjNjNHphRFJFd0MvWkpJ?=
 =?utf-8?B?RU42ZjU0a0N2WlBEQzM2QVRWMVV4ZUk0TVNlNjRZZjJzL0dlbldwNktPZkVQ?=
 =?utf-8?B?d2FGa29hOW5WNDczRWV4TWJRQUxSbzF6UFh2ZHl1OXhqYmFtZmF0Tk9iRVg2?=
 =?utf-8?B?L1AyWmhuQnBsVFhXMDB3MW4zZnF5L000SXkzZW4xZUFmQngrZGFmbnRGUEhv?=
 =?utf-8?B?MlJYR28xcVNrV00wMUl6dzBnSFpNWXhacDgyRUxQNC9NWmJITXR6dVdobm1r?=
 =?utf-8?B?SjZNN2pob0ZyY01CWmJMR0dGNFF5MzhZVXNpWXZCenlDazZXR1FTSWFnQ3Mz?=
 =?utf-8?B?QkM2NDhGbitQb0ZXUVh4d3pXajVGSW9FZFVSa3VYVkdJZGRSdW5RaXczM0dL?=
 =?utf-8?B?T0VJV2s4YnkzbC9tdUpJcGlBSmQ4azJqY0NQdHREMVZLc3kxdU90aHZOM01U?=
 =?utf-8?B?Tk1ZMEszU3U4Zm1xRmkyVjlxUWZHMXJwQUovejAxS28wUjVYYUJDamk1KzlH?=
 =?utf-8?B?QVMvOVFLMXVtUE9jV3BUUkh6cnUrSS9vdVpmcWxwYjgxNnpGTjArdUtFcnNX?=
 =?utf-8?B?cWsxVC9GOWxveVBubWlnZmpmWENqbENVYkZ5QVlTTzRRTU40QjZYTDhzTU43?=
 =?utf-8?B?QklXU3VXdytGbFdyZEFsZEdjUG9JWGNiWVp1aGdsQnowY2NTK1RHeU9iS3g5?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15be5802-4ffb-4fd4-e27b-08db0f553522
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 13:04:44.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ens964GB7jG9dP3qRLFJqcrKmuctBL4KxLccSDicYZZXmSr6khHVy/z7X/V9gtfldlht6PvYEjZkpvIhevTrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4063

On 15.02.23 12:07, Yao,Yongxian wrote:
> 
> Hi Jan,
> 
> on 2023-02-15 18:49:11，"Jan Kiszka" <jan.kiszka@siemens.com> wrote：
>> On 15.02.23 11:03, Yao,Yongxian wrote:
>>>  
>>> Following exceptions occur on the Debian10.3 using Linux+xenomai kernel. 
>>> Please give me some hints. 
>>
>> Is your Xenomai application dominating a CPU for more than a few dozens
>> of milliseconds? Do you have the Xenomai watchdog enabled (it would
>> catch such cases, after some seconds)? If you do have such a workload,
>> Linux complaining about not having the time to "breath" on such a CPU is
>> no surprise.
> 
> Real-time applications will not occupy CPU continuously for a long time.
> Adn the xenomai watchdog has been turned on.
> 
> CONFIG+XENO_OPT_WATCHDOG=y
> CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=1
> 

Ok, then:

 - Any other error messages before the one you shared?
 - Already tried if the issue persists with a (more) up-to-date kernel?
   ipipe-core-4.19.266-cip86-x86-25 is latest on 4.19, last I-pipe is
   5.4, and we have plenty of dovetail kernels
 - Any details on how this can be reproduced?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

