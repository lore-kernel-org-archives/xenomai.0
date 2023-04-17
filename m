Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281DC2E8
	for <xenomai@lists.linux.dev>; Mon, 17 Apr 2023 08:22:18 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id E5476100002
	for <xenomai@lists.linux.dev>; Mon, 17 Apr 2023 08:22:16 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 798CF78047E
	for <xenomai@xenomai.org>; Mon, 17 Apr 2023 08:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjaOBiFQHus/6vjqr8zPSyRMxeW46nK41iBhiGvt5M5R0OrdAw2lihOF7fjZpPKTzae1XqwnSWqwVWEAV8+wBRhKbzsquf+rK/BUVoe/24i1LyOhv8nQBdisOuzxprKUQx9F/JiDjFTbeV4aCeGhUarV0oQf7nTp8Fb8I9ckehbbpWYoLHzRC4ThCbXX3pIY2Fw5A0wyL8MZbm4Hs1gWAuopccBiWiEcX6ygAZxNusnlQRmrEkekoekzoDHV+dKyXmC49esZQbzqnskkLBo9Zt3LGnbcZsaLav7lU3rIYflmRE12gQrw1SdBLS/mSpBOUXWyDA2svBGwNfDdp1s4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myNRtXiAYj0LdZRgz51y8EQCPj8utzEbTErOWzO7VJU=;
 b=dupUFyllnQeoBWdb68LKLp19RkAoi3KRsQdRM4gWB9xS60QvkyxeJByixfJXToPpn2zCSIGl1e7CRk11Ndof2nRW1Bx8b1cCWvfFh/8yhSPKlU2m24Ex95e04uZURk4dZkcOb73d+huRfm29f1Ud3XkxiG3ToaVrqv+nYJrNbRewuV0mmN71GNK5/RMO8IgLs4eyCwfKqzuYDeqoLGdaJ+AAJcq1K/kfykajd2D51ZS1Y2W8Z5C9bd+5Quqvc0gSQvxSRXWwV6foHkUwGY5pUV8l6U/hASNWvhTL360ObwRTfl2SAAFMtVoKyA1pv2uWoFQX1NFkh9B0bdnNA9wz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myNRtXiAYj0LdZRgz51y8EQCPj8utzEbTErOWzO7VJU=;
 b=lFssYrOz7uGbxmoSDH5RBMMvadu11I6JmjzH3dXjyV/NM1wqyS4UrTG6C/pBDFDGZiQvudGJxUbFoXbKmiMCdi9FDLY3EtdSGuBecNEzLujQvG+x/eO9fKolqX7lmvAwIyGBwFANuuk61t1fs9KhEQx9uUSPcERPKHsS2VBdx81BMaSOxEB6pzDw1tqhY8BQvQwOHxMHBFo27fQYIrrX8W6yNztjHuhgEJ/Bke4DejbKE3nlcxNO3SGtzKbl5Zdtndg7LUZnYQXhTes7ZzxXCNcIrgSAiMGh8Ca0me3L+c5/oIfGGLc4ZSjysVa3wnmMfT/+zUYug4mjmqbBmsuhRw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6569.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.17; Mon, 17 Apr
 2023 08:22:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.019; Mon, 17 Apr 2023
 08:22:14 +0000
Message-ID: <9e17fba5-a2f3-95ef-2f8a-2dcc64116b4e@siemens.com>
Date: Mon, 17 Apr 2023 10:22:07 +0200
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
In-Reply-To: <51bbd78e-47d3-52ff-808c-d0212b84bac7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8613c1-3538-467b-a98f-08db3f1cd913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Jqdjfs+AcoM+pBEIw05HvnqmpcioAMNDuS8Ia1ZMm7dtcywc4+xrPkIDQ1TgZQGqIKRUrx0WIafrl7V1rZlkrUpD7q1gVDQdWQf6d1A/6UsvsiiWDiqobYB4QyowgNV6v8XI8wTkkeBm5mOtUbAglt0C9a+P71m/x+oK1HVrATXkWSphwKNWxxjWwRZMDzN6ChTSBt/NOn8Z9Yt4WMlJyHz/rVHDvZeqwY/V4Tb6MIDBZRH0J+52rp20vlknblkS/a+K9TOw4CRqo+/hwLqBH60+0otmuZpmL//tEOW0zwAi86+jLDmZd7afetfQqDQg1qWt852+lhbvDrtKvuh8qHuvL85OBUPCWOHZMce6XKCYHBgLfblljUcwNh/Qdrnzumq2LRH8tJngWCC5CylwVGJsMlTLxlBqKTEzzR+EXkIjgnlundZw5kb9kIPMblzmLthDADCyCcFhL186h3+cO532JJqJ+LctGcCy+ZUT3S3sDFpdZoJVMy1tX10Bz5yE8257KV26ZV4jM9+9LBUB5d9By3Nm1HGSY/cKMlIuLvZ4DosP+QT0M38bpuIchF0B8+AcllDJHuojpGjHmzArrqqdmSVQqZ2o2Wm+R6254L/cHuqlNb11GTnZv8QeJqOlHlRuB4X0Ey4CmDtmVuVpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(478600001)(316002)(5660300002)(2906002)(36756003)(86362001)(44832011)(8676002)(31696002)(4326008)(82960400001)(66476007)(66556008)(66946007)(186003)(41300700001)(8936002)(38100700002)(31686004)(2616005)(6506007)(53546011)(26005)(6512007)(6486002)(6666004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFdVZ24xSEpjRmM2dXNpeEpvNXlPb0dva3BzdTFKcytnZ3gxNG1mdSs4M1BM?=
 =?utf-8?B?QmRoLzByZkhjK2VRRXJmR2s2TTRINEJidXpZODcyNTJZMW1aVU43cW0wRUw4?=
 =?utf-8?B?WEpHUTVxS01pQjY1UzNUa0lJQzEyeU9aNzJabjI0c3ZOWncyZW1FL2hSY2di?=
 =?utf-8?B?VXdnR2dZaEVOZXFZMjJPN3dVSmhDU1dpSDltL21EL2NENjYwb1pZQUZ4Z1N0?=
 =?utf-8?B?SXJOOGhPQmpLMlNPOVR1K1dwNEtUVmxUNUdmK0pZRGt4Qjdoanp3Q0Z5RFY5?=
 =?utf-8?B?YTBhcDNVNVQyRE5Ka3UwQ3ZLc00wbHVDYUpoQVZxZHg2azBhcnFUV3ZReEJU?=
 =?utf-8?B?Y3EzcFoyREZSWU5VK1J5KzZlYXhlOGRaZlFQZ3NRMm82UHoxaUczK1lIUGJ0?=
 =?utf-8?B?aHhxaGd4Wm4zNGdtbys3R0VheVBTVnNFejNNSnRZYkNyOEZQL3Mwb3kvbkpX?=
 =?utf-8?B?NkRGdFNBblA3ZDNrSEdTN2Y5VGhLeDBrOCtZd0xjMGN1cG5KNTNxa0wvUVJH?=
 =?utf-8?B?SFhKWVJFWTJuYis2VXVTcjl6VTNiWmtKRmEzaklwSXBtV0pyb1FrL3h4Qkkv?=
 =?utf-8?B?bHhHVkdZN24zblNoV3VtYnlFcGhCbmU0WkU3endvVjlwNDNGTUhZRldOcy9V?=
 =?utf-8?B?NXE4c1cxUHA3dUdNa2ZwL0ZEbnlTaXFvUXo5Ykh1Z1dLSVowUDJMUVRWQUM2?=
 =?utf-8?B?czhLVmlRa01pMndtYUdCR2IzNEZscVQ1b2d1alU2SENHNU1EeW5zU3VkRFZD?=
 =?utf-8?B?SFNFSWRKYTJlQkdHOHcwK0dhaFBGdkliYTNRd21MUDcyelA5N28vN2wwbDZR?=
 =?utf-8?B?UTJVR3pkcmpEcXp5d3lqNzB0cG1pZDRKQTBENUZIRjFldkFPWDU4RXpoVmU4?=
 =?utf-8?B?SkJmWWtIQ3A1T25NVlZaZGpNeUJKR0VLd1ArajIxcWtjNHY5WXd5VFI5WENM?=
 =?utf-8?B?T1FVVk0wTUt2RUdGVlRxc004MVFXNDFUTDRlaW5JQmxaa3JjSFdDb3ptMUxo?=
 =?utf-8?B?WFpRWTBsWXpabUg5bFprZEU1d2J2OFF1bkNuQjk4N1d2UVFxcE1jL0tBRUhE?=
 =?utf-8?B?bzhCTGZjNmZyR0s0MC9HU3lrazN6WW53dHVzOXYxN2J5bUtxK21wOFkvYVFD?=
 =?utf-8?B?OFJBcUllVDJOU2dmTzE4bmJMZ3pUL05tU1ZRa3haOHduQ2ZIdGZEM1o3UzJa?=
 =?utf-8?B?dzF1Wk80WUh4TWdIakNPZFFkZ0dsRjBtOVRWdnAvYk9scW5wOWxoNlg1REdj?=
 =?utf-8?B?L0g3eStmT2cwZEZiTTlrSUJjeXRiNk9iSnkxNENRaTJ0Nzllb09pa205ckdp?=
 =?utf-8?B?TGo2NXI4S3U2ZmFFTXU3ZkRQQ0p3WnhaZ1k4bHVhZlVTTkdKRlMvb2RhZFBJ?=
 =?utf-8?B?eGJpVFhHS2RGd0t4WXZxc21wM0xhRVQ4QzZxcFRWL2E4Rzc0NElXT3E4cnZa?=
 =?utf-8?B?THM1NWNNa1kyWXNnMGJJV0l0d3g1WVFZQXN2ZmNQOGFETXZKNmhIbXpBYXRz?=
 =?utf-8?B?Wk1VTFNwaTBnS2EwRmxUenJkbjJ2S1EyNHA0WlRwdmtmWVAzbTFnWUpPTmRG?=
 =?utf-8?B?S25vMGw1bXc4Zkc4dVBTUEV2a3ExbVJTc0pFWjhPODJpYmZnNEs4VUl3eUEz?=
 =?utf-8?B?bzlEaFZkRktJRjlqcWQvcmh6dW93c045VmRZc29QVG0xd2M4dGRNdk82a2F6?=
 =?utf-8?B?bjZNZGtFa2ZrL3ZreXorajBtZnZUdGsvemlaZ1dXVGxuWlgralZBUE4rZ1pY?=
 =?utf-8?B?TndITXZmRGdrOHdCSm05N2xMallvTXdmNUg1RmFQcDZEYk1PWGx3M0FsWlRZ?=
 =?utf-8?B?TEpvdDJ4V2lmTGJSRGoyZklndGYwdFd1cGFjSnB1RFd4d0ZZSVIrN1R5a0dP?=
 =?utf-8?B?K1dpNzJBSElhOFBraDZGSlcxU01YV2g3aU5pRlFtWHFQNjJ6R0dYYit0dnND?=
 =?utf-8?B?WVdWb2ZpSWlmeUp4d1h4b0UzdVNSZU44MW9mbWRNR3dvYmkzTGc1SHMrallO?=
 =?utf-8?B?a0tyV2YxK0hVR0dVcENoQXludlVPeElocXJVbkNSNTVucS9nYTBKWFUzV0ta?=
 =?utf-8?B?dGlBL0FJM1ZTc0VOY3VmVVJGZFJXU2FaSElnekF5bndVcjFYR3NRdnc2dEJF?=
 =?utf-8?Q?VKGmJDUlOhMfu1tn8Vu/mj/nl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8613c1-3538-467b-a98f-08db3f1cd913
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 08:22:14.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9BVzNKVLHIuLkXdRbiYm/xZoaDHhH0ozasJBLr4ClItuoSnWlN7qLm1xafw+tlTwX2BIAZqX5bx5jKnloTu8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6569
Received-SPF: pass (spool4: domain of siemens.com designates 40.107.241.47 as permitted sender) client-ip=40.107.241.47; envelope-from=jan.kiszka@siemens.com; helo=EUR02-VI1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=lFssYrOz;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.241.47 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com

On 16.04.23 23:14, Jan Kiszka wrote:
> On 16.04.23 21:30, Richard Weinberger wrote:
>> The alchemy API uses negative error values, so the return value from
>> pthread_mutex_init() needs translation.
>>
>> Cc: aaron@sigma-star.at
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  lib/alchemy/mutex.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
>> index f8933858647a..5836af59f05e 100644
>> --- a/lib/alchemy/mutex.c
>> +++ b/lib/alchemy/mutex.c
>> @@ -133,7 +133,7 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
>>  	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
>>  	/* pthread_mutexattr_setrobust() might not be implemented. */
>>  	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
>> -	ret = __RT(pthread_mutex_init(&mcb->lock, &mattr));
>> +	ret = -__RT(pthread_mutex_init(&mcb->lock, &mattr));
>>  	if (ret) {
>>  		xnfree(mcb);
>>  		goto out;
> 
> Thanks, applied.
> 

However, this didn't help with the alchemytest issue I saw, just tried.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

