Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74A10FA
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 21:23:55 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 9EE13CAB91
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 21:15:18 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 1AACE1BF20A
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 21:15:10 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E2813780450
	for <xenomai@xenomai.org>; Sun, 16 Apr 2023 21:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbtChNc3cT1PfOOWKciFf4mgpjMuedmZKk1J/gizyR32A+RVI6EdYWjaZMZeoAnqs2tB9muEeZDCUeba0GxyC8DxutPUqx1qB343U2gZDZNcc9S4xG4pND2iSC20EDw8VA5dbxfJDx5/lpnqkt+8aS404NzOMLN3zusCUdTdDdraJy05tTzpTAkey4nUtILVqKYZF5KSqukOap36Sqet7zGf0lncvxxN43qWPV2BKv6Tm8oGXL8DY41AnGujlahwQ8f35uEFob9biKJxd5jHKIPk6bKi+hbXN8mCFObSLJsrKVwFT1+CRtElbdKRzTU5VRE3EZ709IlLXvafUOIxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDlifPxJWP1+7LuSZt3Gkq1bDKcYWkAI1LlE73iBdB0=;
 b=Fb3HIhByElgS/Z6RHWXygWjDh/kScuWXuzcyxiUocjSF9/ObFxdBii+IWZRNe+F/WjrKyK1TwnRyRfF0SC09BhVuwyP8fsvSGhGMBhJlETb0YUgvg41KoLeZNXQ8M1aga86cxpDH5/4Yq04iqC7tcT51RuKLa71JEJ6alvGUK2rL4dQpCP3aOhnb+Owjc0Y5JVaXdt4ZQhhD9gxKko3e0+ixrznoMeg+sBehc5KhkMdFV24gdkPP6IKdhuu+djaJPoIm3f982GDqzFKjfIq7JxQ1V+HJChUR2eTOc+VPQq3Ffhot1nCh9qYgqUf68rK2UGJbBxN2oCalqsTt7q7+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDlifPxJWP1+7LuSZt3Gkq1bDKcYWkAI1LlE73iBdB0=;
 b=m/mXdIWYiptQxmejYqDOFHpThGS8hm8iDIMT56Wkhw4VSMpVPb/DC1pAKUq4eMscF33MpJUDi0zOA8j3uTJxTkDvljwDPfOYKlofvQMb+eJLA3UdctwTV1xO6P3AQSApirE7aAND6XmjQWHhK7xTk320S1vyrvS1glINXoSOPWtr8l4cjhZS30SlTDiMiC2zTy9tsaFAW51AUa0hZjnmQfM4JYxVNmE9eWpqlaDbzfA5MPrqglcumhVlsZ2BOXSNWz7nymy3SLy3INgmBPA+JdDHgseIwYjzl0m0oAfWYFfAqg2YNtaYNV8hjUjR+PF//PaNb6Ta7ZwKWPWAxPyu5Q==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5569.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.12; Sun, 16 Apr
 2023 21:15:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.019; Sun, 16 Apr 2023
 21:15:05 +0000
Message-ID: <51bbd78e-47d3-52ff-808c-d0212b84bac7@siemens.com>
Date: Sun, 16 Apr 2023 23:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] alchemy: Correctly translate return value from
 pthread_mutex_init
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org
Cc: aaron@sigma-star.at
References: <20230416193053.22092-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230416193053.22092-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0073.eurprd03.prod.outlook.com
 (2603:10a6:208:69::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2296ef-5782-4e9e-c7c5-08db3ebfa581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Bniku4Yz2m8beY2EkR0XlsGPrhy2I9kGvdX1idkzxi7qtXmoFZTOFApiG5i51jMs7Ox2D5YgBRL0WWZV00Aqy4rLAXWCIW4Wb7nbVOkAXm+4K2Ip9hqziENMtq939imzSlrLeTVfOCTud5JKVMlEdGzs+SIlMI7L8ND3UsZZVTt5JZzWelOWlSE115JuP83k1HofnEzmOEfKjncQ0HkelUqOJSlJKSAMzztOVSKF47BHnFkT8LGM6VL9MzDzrQK3WVgWyrM/XYRRcTdFm+0bIJArCLnuJcr8rAEux0frtZIxqTFaLH0prHnkgWmWNTSSxGiN7YThfT56cnmgo04y9Y0nqtKGKzYL6/YYGdRFR+xJalJ4n9iJf94eTtebO0oxNEIj9J5iddZKBWppQHLbvv5FbPguHPJKRTRUyIUR6Zu4KcWu6EB1XAEuH/hvWUbJ2LX4D5LUSEripeF+kz2Wua+L+oENZSd5ovbAcmHTlfRduPS460t3pcsv22IkIrjbKfvkXRxq4rcsbtpkVLsZo2KDqc7C2/R00TvoUxaa/SPyycNQYrLEfQoxZ8XMFl/fpl6dXctwDiu312SBDpBsfGrV7mqMYufCIUcgU6zop2FtzqHlAzC+NqLakvDdohYKGwn84CFYSzHVaDkYP46Iw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(6666004)(6486002)(41300700001)(316002)(36756003)(82960400001)(38100700002)(8936002)(8676002)(66556008)(44832011)(4326008)(66476007)(5660300002)(66946007)(2906002)(4744005)(478600001)(6506007)(26005)(53546011)(6512007)(186003)(31696002)(86362001)(83380400001)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bldoZHBKZmhlN3VwNFcvcmRocU9FcnhaZ2NuODdHalliaFNLWS9wQnR3VTVQ?=
 =?utf-8?B?ejRzbENhRGZDckh1dWswRjF1MEJ4ZDF6R2FuZjdXT3hRUGErOVB3WEdvV2dI?=
 =?utf-8?B?azY5WkhEc0g3MW5zb0YrblBqS216L2dETmlFait4SmQybUlDM2c2dU5ZeXUz?=
 =?utf-8?B?dHdqejVGcll3L2Q1TkxXWFUrS29CdVE2VFBMMU5ROWJ4enFSbWNGTmhja0R6?=
 =?utf-8?B?VG9PbHIrZm4wakZZTENpZk4vTTMyNHQ3R3lEa0I3YUVyQVVWaUpWamJ4cDd5?=
 =?utf-8?B?czVWaDFEQzAwOXplOGVYV213WTZtbjRGYXZuWExWMDFOMVNMUlVCbVptZVJR?=
 =?utf-8?B?SXE5VG5PNjBrd3lWNnFpMzgza2FZSTFEZFo3S256aUFmWkVpWGFMREt6UTVQ?=
 =?utf-8?B?V0JWaldweWJNWkh1MVZnRUphZW5WS2xKOVNFVUFKSmdTQ2tMRDJNNTYyVkQr?=
 =?utf-8?B?SW8xejVTeXloMjk3ZHZ1dUFsVXdaL05kWS9qNFVjSzhTS3pFQ003M1VCWVJw?=
 =?utf-8?B?OEtLMmJURk9oWlF0b3BjNElOMjlFenhqczFmSkhxNmYwWjFxV2VnOURrQndo?=
 =?utf-8?B?SGttbmVJaXBZV3hkaklQUmJ0RVc0dXVmc2lPclcwbExBNGw0OGM3NWFHcmly?=
 =?utf-8?B?TkJRTkVJNGo2NHkzT3k0bkU3a1Qyb0ZyNWZCOEdyYXZIY0tzMXFHdlBpMmUr?=
 =?utf-8?B?VHVrWWl5dnpXcUo3ZGdxNlZITm5mT0VpT1hoWis5TSszWFBCeW1kQ0xZb2N6?=
 =?utf-8?B?SzE1aXBhUGlRYmdBYnBXK1BwWmRRSWpKZmtMemxvZTUxdVVBcVN4Y0V2cTcv?=
 =?utf-8?B?bmlmNzhoRU91VndYeGZBU2lxZlE4bXVta0ZDcXd6MllVUEliT1g2alEzNjdS?=
 =?utf-8?B?cTlqZ2xndERxTlhZNzFsZTdvb1BqTXU1Ri9jcHB3c0VDUzJNbnIweVhiZUxm?=
 =?utf-8?B?bGVLTnFrYlA5SGExSU5ZekY4UmRMNUJZRVFWY0xnaVVHZklYcEIxOFBzUmUr?=
 =?utf-8?B?RWVxMXk2YkY5ZE1JZGh5QjVVc0JUeDhmUmVZVkhYQVBuQkFhQUcyYW5wVVBG?=
 =?utf-8?B?UzhPdTEzVUMrTWpSclovdVNHWjJndTdaSjBkQnNSYzg3clgvWXUyTG0rNTVG?=
 =?utf-8?B?a1JBbTcxZnBWZXNwZG5wUXUwMk5PelMwWFc5OEpCbjNOdFlrTU1uQk05Y0V5?=
 =?utf-8?B?VS9KK2tIVU9GTStZNzZlVFBUREoycVJJSDZrSnA4TTVvbkFQQnlaM3BGL3JJ?=
 =?utf-8?B?QmMra3FOVW05dHo2U29KRHBNQTNZcEtpNXVpZys5ek45alVDTWpLTys0eTdm?=
 =?utf-8?B?ZFFGRUVoSVk1aFpYYVFYakJWY2pDVElzVjZMNlV2SjlPbW4vVjRCbUpvbzhW?=
 =?utf-8?B?eWxEekFTdVNvYXp5L3hSUHlWd1JGOFJEY3lVL1kwTnppSkY3dnNFN2dQdnFY?=
 =?utf-8?B?Q3RjZENqeERxbHkvVytmL1RVNmxnWGp2eWQ0K0F5ZGtFUGxkVE5maExiSTNJ?=
 =?utf-8?B?b0xMTGFtdHc4WVp4K2tMRXd1RW53c1g0L3Y1R1VvOERhQ2pnb0ROSkVBL2VQ?=
 =?utf-8?B?dTMxN002YkpmbC9KaFNZVUdBL3diaFRGaWgxRDBnV21tcFBIaFArcFRUdmNn?=
 =?utf-8?B?UUtncUwybnN2dzJodUJCQTdBakxGMm1HTVpMMndMMS93L1h3aC9aRzBvRldV?=
 =?utf-8?B?aUs1YTNPMTAvR1MzTGxITzVpSzRxUmFHUjlwS0MxQjNVNkZJbEpvdy83MGl1?=
 =?utf-8?B?eWpjcmRFcTl5UWwyUkMrUWpjdjhFTmhyQUZNR1NteFJVRERWWGRNcGlsMU1I?=
 =?utf-8?B?MXFXd1NUeEhWN2xtcGZHRTZGMDJPZVRVVXE1ZjJZNmFRZ2ZJWDEyUnllbGs3?=
 =?utf-8?B?K3AwNzU2UUg3VlBjRUt5Ky8rL0xSand3SWRlNmNzU0xnMVh5aDBaZ3VuZElZ?=
 =?utf-8?B?bGlFNnpNeTdGWmE5QTQxNjNjaDFNN01keC9qM3ZRbEhoVHE1K0orVVhnc083?=
 =?utf-8?B?Z2diVncxQ1hzM1AwQ3FhYUZKWVR4c3VlTmRibmlRa3lCZVpnNENKckxmVDZj?=
 =?utf-8?B?eWRWWkg5RTNLUUNNbzRjTmt1a2I5UzM5SUFUK0drVm0vWC9BcU54cDlHLzQ3?=
 =?utf-8?Q?c1ozPf3Itj4KKSoQpW8utmAJg?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2296ef-5782-4e9e-c7c5-08db3ebfa581
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 21:15:04.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlsbZTN5RfnjZ8hx2waWl6kxWMZ9cZaJZNFROTLjCb4hHR54NckK3jRqZv7Jx7mMrZj2qEA44O4tvXmQWMssSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5569
Received-SPF: pass (spool4: domain of siemens.com designates 40.107.7.53 as permitted sender) client-ip=40.107.7.53; envelope-from=jan.kiszka@siemens.com; helo=EUR04-HE1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="m/mXdIWY";
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.7.53 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com

On 16.04.23 21:30, Richard Weinberger wrote:
> The alchemy API uses negative error values, so the return value from
> pthread_mutex_init() needs translation.
> 
> Cc: aaron@sigma-star.at
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  lib/alchemy/mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
> index f8933858647a..5836af59f05e 100644
> --- a/lib/alchemy/mutex.c
> +++ b/lib/alchemy/mutex.c
> @@ -133,7 +133,7 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
>  	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
>  	/* pthread_mutexattr_setrobust() might not be implemented. */
>  	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
> -	ret = __RT(pthread_mutex_init(&mcb->lock, &mattr));
> +	ret = -__RT(pthread_mutex_init(&mcb->lock, &mattr));
>  	if (ret) {
>  		xnfree(mcb);
>  		goto out;

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

