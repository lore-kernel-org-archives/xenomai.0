Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7DC2EA
	for <xenomai@lists.linux.dev>; Mon, 17 Apr 2023 08:39:50 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id E9C13C0002
	for <xenomai@lists.linux.dev>; Mon, 17 Apr 2023 08:39:42 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9307E74007A
	for <xenomai@xenomai.org>; Mon, 17 Apr 2023 08:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNjMQ90ffMwV8MyXQeD/iWN+OOkRK5MgLd2ZEqwPJbHFAUy7+qEzcEr8Q6684sLZ80GlaWr4JzG8RVg+LT/7Qmog6mLa1DOYZwBTb1eGi/t4i/ZtTrjgTkhRdVaQL6M6AQZ5CWK6Xdmp/zMsrqX23hpCgNFu2cmCGtzy3ZyWh8lQMRZQnnBQ64SfuR7XbvlCw53Uyx8ZZyS3ukPisSi0nbjRg8PWVIA9IEtyd3wcbpZQNQAgtusn7uSrx85zBu2nbOQLiZ94cL3eqBEPxvS2edvE3Lh/rRDlNeyh4PlFu6DGKr2Mn8IbB7BvImTyhpCIUWp/D5VZ539wrbSQx8Hqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4egmDTH/wfJO7kspl/GYk2K+my1zR0fQapFLDG7vL+o=;
 b=VQUsBxy/UgEU/gXvVciPLSv4YYGso7ajDp+AhCr9uK7gDLvelVJQfY7ASIduABu6YFszDfNNXLw8bVh2MtpMTTwf6Mxk741xPhTXSsOlUZF7KGszfDEkcvy1BuCFh/cpm4K2bOiRB81sSXB07Hqd3/uDT6UfsvJmy4hJ4l/rMoOU207zksc1v+KRT6BNjQF/IVlyvh7htCq3h1ijcS6EUzCsV3MAklGApDHK93xW5oVmqHCp4UPBStnKt+MK/45vyFC/4MtGSt5XTsQaGLFGEOb+YdOo6xSCzIScC28MY6BEKRpPf2l0yp6pgpol4mIySINcHOUMYMrp9TSEUZ2+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4egmDTH/wfJO7kspl/GYk2K+my1zR0fQapFLDG7vL+o=;
 b=ASycwoSg540dqDdfDXWVAflJfKJ9gQtifulP3ZJ7AmJEL+4Q8oPY0/l4JqYoQz4jHzHblMRC9UNBBwaRyeOfe6n8hBpx/G8cQfOxK8nJ3Xzrl1+h1JTKSoN7Mfw4QM6atCj0C/ohfLBO0UAy1WJUv9UXsWScPErjml1pCtFO/zSdaiMALUPwNoonRlxM+gHMWKSYcG3F468T7TqYc1jjEe0D6Sfqy44bZpMT4zD6fP/Ez+kpaI0//Q21ZMcU/dsJKtxyIfprkJIBEbFYqV0Z/M1mk1zEYcm3IbLLO0KyJomSA79o/LM6jYC1Sq9jXphcc2lzYNP5ylznHy/ExlVsuA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.19; Mon, 17 Apr
 2023 08:39:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.019; Mon, 17 Apr 2023
 08:39:40 +0000
Message-ID: <8fd09c15-368d-e2c0-a6be-48c07d1ef7ce@siemens.com>
Date: Mon, 17 Apr 2023 10:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] alchemy: Correctly translate return value from
 pthread_mutex_init
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org
Cc: aaron@sigma-star.at
References: <20230416193053.22092-1-richard@nod.at>
 <51bbd78e-47d3-52ff-808c-d0212b84bac7@siemens.com>
 <9e17fba5-a2f3-95ef-2f8a-2dcc64116b4e@siemens.com>
In-Reply-To: <9e17fba5-a2f3-95ef-2f8a-2dcc64116b4e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d577ba-3c3b-453a-8e89-08db3f1f489e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s1SboBXBULeIdbZp6qd+LXvLYDcra7OIIZsbsDmQQyiivYeyGts0z7kIIOT/9Z5kNS0qSpSJACop/EzpHztKlevMnAwY3PUXukFEmegi/J13+5hFTC5OCFHzdoonjCbvc/UYp2uPL4IcO7SuXG3y5TeMJtanO1qcwmgV3tq56qyed88Q//xOccsOu+qwrKbQ6dxZK1whOdV8vBvl442vH8WaI8PFNzWCITvZ4cEDsKHVOmYtvbiKUbERyXMEKbzPetwdFyrfaKDVF8t4+mhfJhiaLzSglqMzq87/vdIhlLC++cVX3amIf5dXn3Abo7Klfo007zZCKLHUUXYOboINyg2uryXE1G3aksNJ0CX/iepKzcg0MZDY73w/p+7O3TuEIRab1ESyRm7iOctw6/FUMDOHXSLiSYARjQIV6J781KxqF06SDetKc245E7MFAonzvI8RumDd+TixM1DunoCuEulvVQ8/oF9Uob4KbcuLXo4lF9w5ehEgH529FYzo/9bzHtlwIOU59w0aGP0TFfoYc1zQmMB4Cw9SL1sOXU7NyWj7CGNqsLQXKGY+KUepoiXHnTJPl4UZUJyILelzDgTzjucuyN5iAGeBkF7IccJ1viNnRwL99xdfHV0Xcznrwyvs6gnP2csCnv8M0AwV23fWHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(36756003)(4326008)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(6666004)(5660300002)(8936002)(8676002)(41300700001)(2906002)(44832011)(86362001)(31696002)(82960400001)(38100700002)(2616005)(26005)(6512007)(6506007)(186003)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkNVbGhJbzJudVhiSXZyNmlrVTFBb2NKb0VhYUY3VjFVUGIxM2NQa2Fkc2Vt?=
 =?utf-8?B?Ty9wdDNadUVIMnJCOERyaUdiemtVc092emJHaWwweWRST2tBbzQrbzhDencw?=
 =?utf-8?B?a3lHeWZhOVFxNXY0WnZ2Wlk1MzdLcVV2M3QrOE54VXJTUXJoWTFrU2hJWFQ4?=
 =?utf-8?B?QW5jSXZWWUVhTytDUzFWV0lGVktzZnZQL01nL0dHbzc5dXQyNFVHa0pSZk45?=
 =?utf-8?B?bm5VUWhhOXdqSk5OU05tUU1zL1hRUG9UN3p5QWxZWUNPUFJwaUJlbDRrSmZt?=
 =?utf-8?B?ZjlhVFMyNXhTOExmcjBTVDA3OTVyZSs5RGYzZnRVc3RCeFJiK3gzMWxNU0tQ?=
 =?utf-8?B?Tkt4bnQzSEVMZ1lpaEdnVlhWRGpBN2tWZWdCeTd4Lzc2SS9JRkc2Y0p2TnJo?=
 =?utf-8?B?OHR0aWtkSlJMd3hWY0E5SlltQzVMcGZ5KzgwN3RuK01YWXJHcDhGd2pZQnZJ?=
 =?utf-8?B?OXlBTnh3ZWhLR25NZmtPdEpmeWdtbnhzL3hrNVhCVGVzQ0h2Rng1K3NkUGF5?=
 =?utf-8?B?OXNjdnRoRlo4L3V6clRpY3NMLzl5QmliNkpnQzdEWTNPREozUHEyZmtOZlJi?=
 =?utf-8?B?YzNFL1dvTGRsaG0yWTBVdE5TdFdXSWhDYkRsMjhWS0lMZk5QK08vcHB0S0Fs?=
 =?utf-8?B?L21NaWhLTm03ZzUxSjVHMTZVU3FBbDFXUDdjcDdjMG4zWXU4cy9CakpMdWQ5?=
 =?utf-8?B?T2xvWkh4SEJrTlY0aWtsaUNKRXZEdWVjdUp2akpkb1A0Q0ZTeXhNOEovcEkr?=
 =?utf-8?B?eThzWlJyTXRLekVuaWN2MWwwV2xvZHh3U0hrQ0lQemZoSnRKZ1B5WkM2RzNB?=
 =?utf-8?B?U0QyK0ZHTkdUWWg1d1IyWTRoNXhlcXovbTBsa0ZLREV3UnNEdTBsQm1xWXhz?=
 =?utf-8?B?dU81YUNWL3BBdHk3dVNhRHZUUkxQOWZGUS9VdTkyMXpGdXd4d3l6eS9uaTFw?=
 =?utf-8?B?TDU5RlpUYXF5MUQ2Sk01RDRTbUp0VnBMb1dtS3Y2YlNybjJWUWxKZ1RNT2Y4?=
 =?utf-8?B?Y0kxTWN1cHJiYUZlelNlRm9yeTREc1JyS2ZCaXpObDVTaHB3c3FaWXRPWTV6?=
 =?utf-8?B?aHhhZW92L094UHl2TzZTYVU2cjdsQ0lBU2lXRlV2V3o0RzYwbk90eW82K21B?=
 =?utf-8?B?MlNEdGVsUzAxTGdCak9SbS9DOW5FTWFoc0ZVK0RPNWlobERVOXY3WUlSM2JU?=
 =?utf-8?B?ZjBzbTRtQmlRMHBMOHNtc0NEb3ZzZVRlK2lSaWtvUjc2ZkszQThrWUtVbDNs?=
 =?utf-8?B?T3hHUFNzZUFuaFNMQXhiekdiUFZEMHJmamJXeE5KMG11bytmanNzZ1pJeHpY?=
 =?utf-8?B?aTlHT0duMFlEVzdhZzF3clpCaERDWVVMT1VxaU5QZUtYVnMxOU02VFZ1R092?=
 =?utf-8?B?OXNCb29lbHNQeEphL2FhZmcrYmhMWFZkMlV2Q0hWVmVRbXFnZXNXTEt1ZWZP?=
 =?utf-8?B?WXQwUXJEZkVrc1lCdFVyb2ppa1EwM2F4V2NSM1VvajFwTjBrUWsvK2o2UFgz?=
 =?utf-8?B?UTBlcTRsS2UzajhkdFJKNi9oQVRPMUYzazluWHd6SHlUeEllQml5T3VqbGY5?=
 =?utf-8?B?TUsyRThWdUc1UHFnUytuRjR4dG9TeTM4cDUvM1doMjZIdW83MDYrVk1Dancw?=
 =?utf-8?B?VlUvby9kU0pnY1Yzanp1QUVCRTdmWWpwU2hHd1ZOVitNSmd4Z2xmV3Zmckdr?=
 =?utf-8?B?MWVJMzA1NzMyRDluTGc3YkgzN3RqVDZPWXZ5Rm40OGJhTDlYQWVTNmVYbzl5?=
 =?utf-8?B?MTExNWFJKzBYdUJ1QVV3Y3AvTEU5YlhkM0ViY255TkRmYlN5WWVBM0hpbDlV?=
 =?utf-8?B?eTNOSkFGZEQrOWNwZkphbXRPUG9mbVV3SUZSWEZuY1YxMlo5VGc3Tk5WUGJy?=
 =?utf-8?B?R2dkcGRlNkRXTVdpaEJ3TTdvMmo0eE9lOTltZXNTNWZSakh3NVBueHltVE1x?=
 =?utf-8?B?YjlaWjNQMklmeG1pWDd5amZrL3dvR1NWclpySzJrR0I5NE9vQmdXcFRZNlNF?=
 =?utf-8?B?VkNsM2RkZ05sZHEzSFRCN0ZLUjJqWjhEbE1RdXE1eTFnZ3F6N0x3T1JQREtQ?=
 =?utf-8?B?L05tMnlrblJXVE5Tczc0T05uUStraTNmUmdBbkNVUkRSSzhCU1N5ckVnMCs1?=
 =?utf-8?Q?4NeMN/xYApFqjAHiBuF1aDxFW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d577ba-3c3b-453a-8e89-08db3f1f489e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 08:39:39.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KRrN99LGMWPhrv+K2cq2yJCbvt2Ki9aX+peGNI/DCX2FSPV8SKB3GdL7uXok2uCDKvnYyehbo1kHV/AnMbLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6141
Received-SPF: pass (spool2: domain of siemens.com designates 40.107.7.82 as permitted sender) client-ip=40.107.7.82; envelope-from=jan.kiszka@siemens.com; helo=EUR04-HE1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=ASycwoSg;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.7.82 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com

On 17.04.23 10:22, Jan Kiszka wrote:
> On 16.04.23 23:14, Jan Kiszka wrote:
>> On 16.04.23 21:30, Richard Weinberger wrote:
>>> The alchemy API uses negative error values, so the return value from
>>> pthread_mutex_init() needs translation.
>>>
>>> Cc: aaron@sigma-star.at
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>  lib/alchemy/mutex.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
>>> index f8933858647a..5836af59f05e 100644
>>> --- a/lib/alchemy/mutex.c
>>> +++ b/lib/alchemy/mutex.c
>>> @@ -133,7 +133,7 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
>>>  	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
>>>  	/* pthread_mutexattr_setrobust() might not be implemented. */
>>>  	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
>>> -	ret = __RT(pthread_mutex_init(&mcb->lock, &mattr));
>>> +	ret = -__RT(pthread_mutex_init(&mcb->lock, &mattr));
>>>  	if (ret) {
>>>  		xnfree(mcb);
>>>  		goto out;
>>
>> Thanks, applied.
>>
> 
> However, this didn't help with the alchemytest issue I saw, just tried.
> 

BTW, my test setup has --enable-pshared and --enable-registry, maybe
that has an influence.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

