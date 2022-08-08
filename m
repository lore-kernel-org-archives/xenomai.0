Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398628EA
	for <xenomai@lists.linux.dev>; Mon,  8 Aug 2022 11:58:34 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 64855200004
	for <xenomai@lists.linux.dev>; Mon,  8 Aug 2022 11:58:27 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00058.outbound.protection.outlook.com [40.107.0.58])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 0C579941693
	for <xenomai@xenomai.org>; Mon,  8 Aug 2022 11:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiXWw/f3KWl7zuOthMyFA5xvMGXWT7I/Tg8T8LT1ehwfio0SWW4p7Z/aFfwXPb8ba/nKZj95LACP3MFd+gL8WV9V0aLjE/irWuO0yroeBHTBfpfG3LRPPTQmDvov8NRok2FtHBtxfH6fwKWwPulKMIaJ5ZYAJn+yzAr5Zxz6rq4W4kEj3OD+GvHQjUKiwSUxvoB0Iho5lexzwnPutFrdCjPCCIjj6r6p2rQAs4iU1VF51g872cvKN8Dm7pO0Sr9sorF6j5rWpYMWiauBKeb+RIUzEABUM1PZSBSx/T7MexKrnEvriy9K4AQfr8Rqwb0pjGHRc1SOhDV6rHiIewImRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBFK/gFiKEX6cJTWpEBhC/lLuzq9m474WCrhVAvF0PQ=;
 b=BQFNhTmiZbDC4kLDaKL6dYeb/vuHoAIS1MIpr4As/n/8Axspzw87+DTXIlj04uLBsdIBrG+RLNrd6Mu1uhT7bkU16qmduiau06xHEXD7VbK6Ell5dLcEISlAbwXWUfjiDIftFJrDc6jQJQFFF4uPwmWHFX3qR3Y1aewWrPrGzRdZanM3HoxtzX5TLOHrmvJgXRcmAGoisTZu4KNYTQ4rbdRNJJq2trU+ZQCuD6YsYaEUR7qRJ3pwk5xL9IIYvxLvU4/c+eGq3P9WGFWB+lyjh/YJ3UqBREYgNxEebnAxyFaJbW494a2j+l0GIhmXUOBvlNwEh3X09JivXYe2oDmoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBFK/gFiKEX6cJTWpEBhC/lLuzq9m474WCrhVAvF0PQ=;
 b=Q3d6P9KHJ5ucM6FOYxrq4b+kdVebSDZi9m09QI1Bd1aC6zgfi2L4XeP8bGuq8tFE+JigZraXMPP2lwFioCQOOtRoETodcvaLCuV1mH6Hujq4DAUV+hW1UQb1QLb1A70bpPqfwUbE1bjQa90Uu1RHkoyeh8Smm2/T1ns4KQ12qSXXcQx2ddEEuyl6NggtvCYim9K1uDZBox5Pkfx0Ktc74aOMKn13wncPoaiPwd3TXZeF798s/nVDnVhXXVU/ayswRNqXc6e6OOWLU4uIlk1s8hXnK+3/vx5x2eGLPhMyo48bK6JIov5Eyi4/4c+0fdpaNajJG2Xu60Oroo286mCGYw==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS8PR10MB6340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 8 Aug
 2022 11:58:24 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.016; Mon, 8 Aug 2022
 11:58:24 +0000
Message-ID: <53d63cbf-1298-e63b-dddd-087bd85720d9@siemens.com>
Date: Mon, 8 Aug 2022 13:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit compat
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Konstantin Smola <ksmola51@gmail.com>, xenomai@xenomai.org
References: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
 <01895bb8-7c53-9a6d-c415-2da02ba2c036@siemens.com>
In-Reply-To: <01895bb8-7c53-9a6d-c415-2da02ba2c036@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5188483a-f022-419a-463b-08da79354c3f
X-MS-TrafficTypeDiagnostic: AS8PR10MB6340:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zZjaKi39hxSb8UBHcx9cwmipcX6rY8iRvMwkSq402pgGxZFg9CAe9HN0yvw2EMgkHCOXOFJmtUGuh0WFPpYLNBExxRTO0nZw3DqaVJpwF89TPMPxw6guwUQmZwsMaKchouhallS4OcYN41tHZrPb6yeLGNxyt805PVMmQ5Zj1agn4NlTEf4pOtCgyrjSYIsxG4+k2iDu+FHGa/67kLrlJZg8s4OWmXlE3ACoRNq22Jit03bK9Y4NNlre4pcYtwFzYd1NEXSw7DK0pk76ImxyxTYu9LqKz29bjm9P30R3e+bOMzBR2JbbfHnISaQrdKd/dE5QH0yZcEDW7aL8Bh/usS9muR9RHCKmIYWVxzCHGxCWFvKCt77Dc7MzjHC1pGhIEuryUmUKkpZp6xhfxKts9y7BtWjYR4im6efUx/0t6pMMJpRplD7ijnlSlSXX89TFyvfhrf9SaAYK53G4lzLGV6cTtSEqerMk58q86Xru6rb+AYfqSV6tNI1MDO0K6RObKrzkkwKM4O7wsC261h/tgkwWwo/crh1Ipb8CTUDnZcjcKPbwAU9XYJCOkyRa0qhGqMsfuScfJumtJLwrvul2AxJDS7iHiaMZ3jpzcJCzrZPh5TamWbhn8d8eVa1fKqcDRCEz0isdPrkmthWfl2/lEavS3OChOT3EwT0BvxNJjHcCkYXI9J3zxDVRLVDe0VFLrOnkBMG/zNaPsAjyU2Ld/WLsSVc84jII9qOjfsz/xl+2L2LHHOd7l0rDj0HSZ1SHaeTdOKpGUEDGbdTZpPAJwnRLqHhnWRW1er8+8mxVQnTF6zVq6SqG+5P2LPmRihMbAwzGVAhEEBAWsKcpE+GB3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(5660300002)(6512007)(2906002)(41300700001)(31686004)(82960400001)(316002)(36756003)(186003)(6486002)(86362001)(478600001)(2616005)(31696002)(83380400001)(8936002)(38100700002)(8676002)(44832011)(66476007)(6506007)(53546011)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGJLZEVRVk9lOS9NQk1lZWd2TWxObTQzNkMvYlliSytnL3VsV2txL2xuNlBz?=
 =?utf-8?B?cFVJMmNIaG5RZEg0WXBodHJVVmdhOElxRTBSTFQ4blo0NTN1eXA0ZDJLSEM3?=
 =?utf-8?B?VjlhbHZLWmRJd2U1THd3cHQ1bDVhUWdLRmJjbFV3cmdHdURwOHI2NlVRdm9z?=
 =?utf-8?B?UEtiWHZvRGRFVk1yQmlmNmRKZUl6elJIc3dVYmdzemR6dHEvRDFaZ3poeHlD?=
 =?utf-8?B?WmZON2pwWWU4TkRVTm1FbE9nL3pGem9ZTkM3MVNmM0FQNGhERnAvMHd0Zlly?=
 =?utf-8?B?RjYrS1RMaUtSY0kzbEYzNk5neVdmdlErSDRWb0lUNk1NTTE4MUFlekVMUUt3?=
 =?utf-8?B?RXhlU1FLZG5ob2hQRzlEY0xtdGgwSWdjOEhzM0NlbFI5VGJZWUsyMGY4SUNo?=
 =?utf-8?B?dmJ2VlJtT3JJM2ZVZE0zOVRyWXZFNFRmSG5iVXVKSkFzeXA1U2N0ZDhjWVRH?=
 =?utf-8?B?QWhzV0o4SFlxQkFVQ3ZkUEk5Mkc0bFAvWlo0U01iUUg2YVF1d0VRNVNGZFl1?=
 =?utf-8?B?blI4RzJaSDhZLzlJK3hiNVpCOXdCM1VqNVp0S3ZtcWMvRDd5czVFZC9aZzdP?=
 =?utf-8?B?OTkvYkQrVFBSSHc0Qk1TcXZOR0lRVlp0YjBSTmxia2NjNHpiaDZFRFpqOHpz?=
 =?utf-8?B?Ui91WkxLYTlRc0d2R2VWU0hpcUFzYjZUVUY0T2xkVU5KeTRyNE1FKzNNK011?=
 =?utf-8?B?bFpuQWF6NnBLblVyL2Q1c29VWW1TU2tDK24vSEEwdVpGNi90eWZ0eGQvRDBJ?=
 =?utf-8?B?bnYyZm1VTEkrNlBmaC9EOTlnSE8vWGhqU1VIUGxvejU5Rno1MTVRM0RTY3JS?=
 =?utf-8?B?NElIRjAzTEMzamsrc0NRZUZwcEQ5NENRWjk0eHFmYlBBNm1JRXgwZXprZmxl?=
 =?utf-8?B?UHE4QU5FQnh3TkluUWRoOW5KUkZNcVF2M25DTlRDZ2k3clFHbHE5NnlRdTI4?=
 =?utf-8?B?eit6MlRQdDlmSStBRmpFSUY5SEhhOXNOWVY3SVhxckJJa3NNU3Y2TEtCaGU2?=
 =?utf-8?B?K3d1c2RlOE9PWkJMekhvZ3h3WVhxMm1DMEZtUmQvQWxKM3VMNnFqK0hHQzRk?=
 =?utf-8?B?UUNRS2ZKUGNNVVNiUkdtZTZleVFET2RwNVJ4bHBKdUhHSmEyNWFQMCtkeHdC?=
 =?utf-8?B?dU40UjZuQXNQTUZtLzArRzB5Mkl3a2FwMDZGODJPYWRHR2lIQUdxSXlWM3Q5?=
 =?utf-8?B?MFc4RDkwZFloc25tYTU2dlI3SmRRZkk1Sm1RTXRnYytHSDVUc01EbkVkZjdY?=
 =?utf-8?B?MGJFRWtaVGlVdmRNVFVycHYxMW44TXRCRDlwRU5uUzFNTHQvcmZjUUwzUUkw?=
 =?utf-8?B?dEc1MEUyUW85WFVxR1FRYVpweGo1NEd1OGJQSkM3ZnpsSW5HRTF5c3BaUzNB?=
 =?utf-8?B?VnVqWjlnSlRFK2REdXhvZHJXZVhrendBeVN6RUQvY2lFRkJ5cmJQMHMwSXJx?=
 =?utf-8?B?WXNZd0d5b0RWWWZqRGdxZ3QzbUcrTjdUeFRaS2JyTnJNV2J0dlF2MEhMWUtn?=
 =?utf-8?B?bStXK09ucGUrSnJ0aVFFQklaUmVvbEVEekZvUEV6NXFmQUNkM3V6T3dRZ0xI?=
 =?utf-8?B?dm5mY21Nclc4U2w1QXhjU0VNblQxaHpwOTNGdHBxZmNKbUtmS2hhemk5cXZ0?=
 =?utf-8?B?VklIbVh4aWJMT3gyU2VTRzc5dXRFQmEyQjJBa2VMV3I2eHUrRkVINW5iWW5s?=
 =?utf-8?B?aVA2Y2FBaER3cFRqVGErSG1JaGxnU21qc2pKZzk2dTF6ZG84SWx2aUx3ejFx?=
 =?utf-8?B?NDA0dVA2bzF3NlAySjFtbzJReGZHM2d2cTZISXU4Sm42MmZDVEVXWmlrVndy?=
 =?utf-8?B?eVgzRlRQQkZWTzAyZm04ZW5aUTVhU2VPVGN0cVN0WGw0dFlCcG9IRG5DQmRR?=
 =?utf-8?B?eEtyVFhVZjJscjV2Z2ZsRTh1YkZ0UEMrMS9CSXBLVGlCZ09JUzI4ZUFQdVJJ?=
 =?utf-8?B?dm5VOFk0dmdEbFR5QjE0NCtYRzAwWUo2ZEN5TGhkYnpCbWRzZ0VPd29kOFJp?=
 =?utf-8?B?dVc5Mlh5K3FUR2xMZVVXNWxpNHA1RmlIbmVFWXVNc0tFMjI3SUpKdnljTERa?=
 =?utf-8?B?TUJvTnNSaFBBZjJGTmZGWkJ2cnJxOERHb2YyRWlLemgydUZIdnprbzZWcXdy?=
 =?utf-8?B?UlEyTTVEUHZJVjdwTndDZ2xSaHZld20zL0NCTUxyVGc0SUszYlpMNDA2Y3Yy?=
 =?utf-8?B?VnIzSmNIa2VUdytCd3BncWsxaDYzOVpsTlFSclo0bkJVQnB2NHprU3NjSUYz?=
 =?utf-8?B?NmNlR1Q0ZVZPaUFlY2FtUjNlZTRnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5188483a-f022-419a-463b-08da79354c3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 11:58:24.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvMPR9zoJeTqbG0h+a5dRnkISzXPVLgMvjA4Ab4U1uEpEbD3T+JQq3FPq6OFWAqASjwSmAbRqaMVO8WhNZghRDuS5994GmDTPF6wgRI0f2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6340
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.0.58 as permitted sender) client-ip=40.107.0.58; envelope-from=florian.bezdeka@siemens.com; helo=EUR02-AM5-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Q3d6P9KH;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.0.58 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

On 04.08.22 20:38, Florian Bezdeka wrote:
> Hi Konstantin,
> 
> On 02.08.22 18:46, Konstantin Smola wrote:
>> The rtnet interface was lacking 32-bit support for bind and connect ioctl.
>>
>> Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
>> ---
>>  kernel/drivers/net/stack/include/rtnet_internal.h |  1 +
>>  kernel/drivers/net/stack/ipv4/udp/udp.c           | 39 ++++++++++++++++-------
>>  2 files changed, 29 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/drivers/net/stack/include/rtnet_internal.h b/kernel/drivers/net/stack/include/rtnet_internal.h
>> index ec7e614..8194791 100644
>> --- a/kernel/drivers/net/stack/include/rtnet_internal.h
>> +++ b/kernel/drivers/net/stack/include/rtnet_internal.h
>> @@ -30,6 +30,7 @@
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>>  #include <rtdm/driver.h>
>> +#include <rtdm/compat.h>
>>  
>>  #ifdef CONFIG_XENO_DRIVERS_NET_CHECKED
>>  #define RTNET_ASSERT(expr, func)                                               \
>> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
>> index 5977a3b..89f4d80 100644
>> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
>> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
>> @@ -357,23 +357,40 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
>>  	struct rtsocket *sock = rtdm_fd_to_private(fd);
>>  	const struct _rtdm_setsockaddr_args *setaddr;
>>  	struct _rtdm_setsockaddr_args _setaddr;
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +	const struct compat_rtdm_setsockaddr_args *compat_setaddr;
>> +	struct compat_rtdm_setsockaddr_args _compat_setaddr;
>> +#endif
>>  
>>  	/* fast path for common socket IOCTLs */
>>  	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
>>  		return rt_socket_common_ioctl(fd, request, arg);
>>  
>>  	switch (request) {
>> -	case _RTIOC_BIND:
>> -	case _RTIOC_CONNECT:
>> -		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
>> -		if (IS_ERR(setaddr))
>> -			return PTR_ERR(setaddr);
>> -		if (request == _RTIOC_BIND)
>> -			return rt_udp_bind(fd, sock, setaddr->addr,
>> -					   setaddr->addrlen);
>> -
>> -		return rt_udp_connect(fd, sock, setaddr->addr,
>> -				      setaddr->addrlen);
>> +	COMPAT_CASE(_RTIOC_BIND):
>> +	COMPAT_CASE(_RTIOC_CONNECT):
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +		if (rtdm_fd_is_compat(fd)) {
>> +			compat_setaddr = rtnet_get_arg(fd, &_compat_setaddr, arg, sizeof(_compat_setaddr));
>> +			if (IS_ERR(compat_setaddr))
>> +				return PTR_ERR(compat_setaddr);
>> +
>> +			if ((request == _RTIOC_BIND) || (request == _RTIOC_BIND_COMPAT))
>> +				return rt_udp_bind(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
>> +						compat_setaddr->addrlen);
>> +			return rt_udp_connect(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
>> +						compat_setaddr->addrlen);
>> +		} else {
>> +#endif
>> +			setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
>> +			if (IS_ERR(setaddr))
>> +				return PTR_ERR(setaddr);
>> +			if ((request == _RTIOC_BIND) || (request == _RTIOC_BIND_COMPAT))
>> +				return rt_udp_bind(fd, sock, setaddr->addr,
>> +							setaddr->addrlen);
>> +			return rt_udp_connect(fd, sock, setaddr->addr,
>> +						setaddr->addrlen);
>> +		}
> 
> I'm quite sure that this doesn't even compile when
> CONFIG_XENO_ARCH_SYS3264 is not defined. You have to move the opening
> bracket ("{") ouf of the #ifdef block.
> 
> 

There is one more problem here: _RTIOC_BIND_COMPAT is only defined when
CONFIG_XENO_ARCH_SYS3264 is set.

I will pick this up and integrate it into my y2038 queue which I will
hopefully dump to the ML soon. There is more infrastructure available
now which should be able to handle this case as well.

Florian

> 
>>  
>>  	default:
>>  		return rt_ip_ioctl(fd, request, arg);
> 
> 

