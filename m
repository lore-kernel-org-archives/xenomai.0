Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F82916
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 18:39:17 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5CDF9C0006
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 18:39:09 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DFD72941CF2
	for <xenomai@xenomai.org>; Thu,  4 Aug 2022 18:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUkr9LFmDDGxUxBBJQcTGPfGCS8m6Fh23Hgs4WjHmqrfiF2epQn4KCy0FNioFjD85Aa6gkFNE9LdriRekI2T0kzDEtowcvC5OPga4FD+0tfX4K7qLYWO0fDuX6jbKiNfqvVo/F0W8WgM23mWbO5Ci+s/KAHWPKepzF2pejtE/n7NJ1fgqsTcNS1NAHcmjsY8LXA6jb/6Uz73y5ynpyoJgcZqhQ3F5kSxXeIIX7GKVk6h6tCTbGt+Kwjz2RORTbldu00yN/naPAGiwea+vG6GI1TKYk2yk5+fkAdY/xvBH1D1A8TugvB9DdbPb8tGs66NLujs7r/ev6l6a4TD1dEI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riXSjq73OIFlz9RBSrXFGuTkocz1kubkSXJtIJMNd08=;
 b=hDROiYe9s41dEBlwUuPuuQtKWQzE1dyjyQEK1Tb2PsYn7gENq6HUp+Gcc491MMV/XBfV5jOzTz4PXg7XBtCBGzUAJVct0gHyFpczFM+pVWNJVm9/C4Sz+gCyzMtpOq0UwhGlXkIxupQ+n9bnlM+XQE4MsHtEYOcRYipyw4Ooj2WpWZJMtlRD1RlzOqVr9FrJpLL9S0sCDXXirRt7nJs20CZuPNo6gMLXRDlri7Rx9KGP5ey7qqWyBBFIDRYOQo+tm+D4SsbXHVW25E2sMBlGfchwLx9GSI+O5SNrg+jwL80k9a9sIwZH1yFwfwjg+HlsERoFLfgrH3TH1/bWbY/vEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riXSjq73OIFlz9RBSrXFGuTkocz1kubkSXJtIJMNd08=;
 b=Xjgt2pvS94lBSMSvWwJs2At4toGW2aDY3oNnipIkRdgaDwOHN4L2f9+ajV10WdQ4hZyUVp8viwVUrUe7UocCNh1+ittJ5xVhKOH8NJkRap3bdK4ADULC8sh9kw2/NIr/KSOvdF0hcD3cplCI3jNKOXM4Zn03kxL0RUJnwwwT2iC4X6RvW4Qr3ehfz6k7gTEGjrXlc+dpZXTce+rxUsUhQ3/N4hOkp0fjOFo89Ig+XVgTC4A+EI0IpDmFqYdPEliu7D42YgV6z/ABYr99HpSxBk+UzhcV/oqQd+lEowsGkc1RU4AZTzIU9x85TP+W2i37z60NHpQeXFOHOYCrYwpbxQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB6PR1001MB1046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:5f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 18:39:06 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.016; Thu, 4 Aug 2022
 18:39:06 +0000
Message-ID: <01895bb8-7c53-9a6d-c415-2da02ba2c036@siemens.com>
Date: Thu, 4 Aug 2022 20:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit compat
Content-Language: en-US
To: Konstantin Smola <ksmola51@gmail.com>, xenomai@xenomai.org
References: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:206:1::25) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 547d1452-a04b-4321-7a09-08da76489c2a
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1046:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ef81yNVgzt3My1ougCcqpm0Kat0OJyeRUBMaSkVjDVFksGB+M0icv67zyVQoH6AwtJ5o+wbij71NEg5ygCIHN0VpGuSge143IN/aeVS/nMXw28SwWjOOeYTCreAyTFJBhqznFzY6gHdY435pFBcWsUMFsgIRCPDc6oZSUN6ZPBZbbQ4E+Eoafr8g4jpKbwXNf/XCc4U6qtWzO3mw56N3dpMPxHjGsuXZEd2kPlO9f1bK9YV92yl1fsXslT4PSQkEVFrqhJ3nbQT2BgU8YS0OvppsbWAWCSnskulJ2rM4qFCDwbxiN1DZFpYGObykBoArrGnwCOU3uwWD1kMUN1UetcAUZNxuamseGsMYNMMtpXRSQONosba2FSakf5dvzPH3gzUq7TaSk7K+8/gscOV5C+HLzlLMMV4jUWQX7WdlWOQwAYiJ/MguaU3zkg3KNukIodUKdWVqy3gp5O9VKWTbjG8R2Xlvjuwhvcln8pO+ocbqG41EJG/nTMGU2QQNTTdl2OwTuT5nxtR23EqIq9kOplnNOvriJW/hWpQafg1mjKe9F4KQFZn/BCrapLc8ubLMQBY7nRaxGUxXWxjOoPiLAcMo7B6M5LP0TJ9kz5hz7HpuhQVB2ZZ4vuFm2D6UtTGXlrP8pu2YQuob5w3G09vpaQCMBdJjfo11G5Yx/2ZnkdCEIEn9nJ96EidSCcFDW0URlY/0UnG/t7phmxKZFs9suoduMxOVwn1X+V5uYFygKcsDgfAGXWDxCG0o+FztwZ05HacJvTpUZU1R7Sz2zH0hJkDLSlpvnX9VaRs9E2gig6dDfSEKTcQfGtQK3XlEfH5Q1yEPBLGYD7UKpEpcv5CClg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(38100700002)(2616005)(6512007)(6506007)(36756003)(82960400001)(31686004)(53546011)(41300700001)(6666004)(83380400001)(2906002)(5660300002)(8676002)(8936002)(66476007)(66556008)(316002)(44832011)(66946007)(31696002)(86362001)(6486002)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkgwNXBybTJkQXhyK2tzK1djTzhOQTVtcldzbU80dW45dWZKWWRUNndya05P?=
 =?utf-8?B?V2d6RXhJa1pLUlpNYWtwaDVqOUU2MEE2YldpK1o0aCtPNjNFQUEyRFlVQkRk?=
 =?utf-8?B?eG9iSERHUDVzNlZHM0ZOQktweHlHcU5Vc2hsZkFpV1JqK0NaaFFYMGoyK0FG?=
 =?utf-8?B?RW5aaVZ6UnoyWWh2THdOWEpudnJscEg4WGdTbG0xSCtoRnQzWTFKRkJsUm1Y?=
 =?utf-8?B?WWU1ZlAzZm44V2ovQlc0Nnd5c3FCdUFnUFYwTGNMSDhhaDMvRzU4bFZTRXJ3?=
 =?utf-8?B?bHVEdmM2NjErbGdOVE5vQlJ2Y21NMk9wR0FVdUowZTVIcnlGaW1XdWRXTCto?=
 =?utf-8?B?MXBCWHBmb1dsVm1Yc1FSUnRLdUVIZlRmQWZrU2ZSMEhndzUvYm9NaHd2WkN4?=
 =?utf-8?B?bktWeWtJK010NEhLaVZEb3dFcU5UWXNqN0JkNmtSOVBhZ1Y3R0xrL21HTThx?=
 =?utf-8?B?NDY4SDZOY0owMnRCVEpLVVBFSmtldnhyYUo4RXlpbjRUU1pMNGp1WGttVzYr?=
 =?utf-8?B?ZFNROXZDb2R5OXFsS0pNNXJkdGc4TkhRaGU5Tm5mTnYvTkJKZ01veHZ6Nzl1?=
 =?utf-8?B?TnFxc2VwNFk0VVhOdUExZnBLRCs3akhQVmdSRC81d05tTkl4cTU0UDlKaTVr?=
 =?utf-8?B?MzRwVHdGQXB4OTNvbUVVL090VjIrTWwzbjcwSURzdCs4ak9ucGI4bEh2SmRW?=
 =?utf-8?B?M0Zpc2ZPUUtRdkV3RVpNTE8rV3lNRXZqd0xucVBtQVl5aEpkaWYzRlE2U0Zt?=
 =?utf-8?B?M1NSelU1M1hTdWJKeU9vNmlvc3JvODRKK21OU05CUU93WHlUYit0aXZianV1?=
 =?utf-8?B?QktreXRDZHhWNCtVeFNBcXBiejg2dGc3c3RQMnJaNmlOejJuVWVkR1ZORUZ1?=
 =?utf-8?B?eUFMZ2c0cDduLytTaHhvSlJqYkdiVmNPeFgxbkpvaXpVcXNTNmJUaHhSZlZL?=
 =?utf-8?B?bzVPRHhOVkppZzNadmNKR0FtZ0VERjZwTUFBM0JvOGxqc09jQVB3ZDg5RTNF?=
 =?utf-8?B?LzBTcEMrSm1YS0RtdDA3cFJoTzBpNDBVczNIenNQU2NrQXdzeW1Lb1NzZFAz?=
 =?utf-8?B?UHJZRUJ0TW92RDZ5RGU3TEVGT2FTOFhsSkNVZHdsYnlCdDJUWGlvMHJsVTJt?=
 =?utf-8?B?Y1ZRaVRVTGFSdTdwUWU4MjZBS3pYelBlOGVLVmp1MGlKZVg4cjFXdVdIYUx2?=
 =?utf-8?B?NjU1YmpaQmhMT3l4c2h3ajRyQ1R6TlBpb0xJcDlmclAwQUFDMlN0K2l1OEc0?=
 =?utf-8?B?dDZ2ZVNYaCtvTnhJZUswN2UvYWJEamZUdFFnVHhGbHUyUSt4VFM2TFNBSk5i?=
 =?utf-8?B?QkV1SXNKNUIyL3Z4NWMxS0VHZlVScTJiUzMvUSszcmgyYUxDQkc0V3p2NFkr?=
 =?utf-8?B?Z2FBeFFraWx2SkRpL1FjbjJSYkZPejJ3dG1JNHNjeUllcld5eEpUbTV4TzBr?=
 =?utf-8?B?UDVaWmIrNC9qcG92MmNudTVlTDFXdWw1dzJ1WFRpQXdVU20xMmpVZERqWWw5?=
 =?utf-8?B?STYwbW5INFpmMTNPK1ZJamMzRHgyQjRWWGd1V3luTU8wenpmTFQ4RzVLK2U5?=
 =?utf-8?B?WkZpeEd1MndCWWRaUlF3SllMalVzZnhOaDJhYitFSzRWcE5mdXBTUHRIQkVB?=
 =?utf-8?B?eXpMSzIzNkhZKzUxbWsvTmdFbWNiVmw1M01oZUZLMHgwZU5oQVJvOFNFeWpJ?=
 =?utf-8?B?VUdrckNrczYybXZnbHNrYjVBQnovSHNJT0tCeFJYWWhaODJmeHJ5ZTIrVW92?=
 =?utf-8?B?ZnpvUEVYN0ZKMTQxZ0huQmFkK1IvUGZ5c3dCMm5FVEgvTEFxTzhtMERSSkRm?=
 =?utf-8?B?U2FHclgzRlIvTEdHVEVQYmJxQ0JWeXBJN0pNeklyL2V6ekxSaUxodzM1RHl5?=
 =?utf-8?B?WG9MaVZBcmx5dkttbUU3Q2s2Y0Z5TzZUV0dsRDZpb0M5Z0lZNjRlUFlMdmF2?=
 =?utf-8?B?YTVQejBNLzZyWXpqM28vc3ZpVXVBTTQ4cTNFcHJmRTdlYTFVNkg1b2xvT25n?=
 =?utf-8?B?ZWIrREV4NWIvWmtyalZXc3lQY21JdkxnR1A2R01kU0daKy93Nkt0dzRFaTdj?=
 =?utf-8?B?R0hWd2U2NzY5UnBMRGs1eUpqWS9sQXlQYU0vQkNVdUQ3K2ZiV0wyWTU5d0Zr?=
 =?utf-8?B?a1RFdDU1QVhXMnliQm54V3RQUnRvMHRPRGRCQ1JvWmQ1bjZLa09QUms5blFh?=
 =?utf-8?B?Q25wL2ZNWTd5MlhFTGJRRWM4L1VLbzVYU3ljNGdwRWUyd0VmaFZ5K2ZYMXNX?=
 =?utf-8?B?Zzg3TVdjSFU3Z3RHVHpuM2g0N3F3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547d1452-a04b-4321-7a09-08da76489c2a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:39:05.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkusiSjy5/DtPQ1NUM8CzhFUKUBUhBTUh2jghYwmofSX0hxRPietm6vlXSn5LOImZmv3b8HH3Q1xu+AuLfEBqojNQhwyKIuj2FSM6pmDPi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1046
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.104.84 as permitted sender) client-ip=40.107.104.84; envelope-from=florian.bezdeka@siemens.com; helo=EUR03-DBA-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Xjgt2pvS;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.104.84 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

Hi Konstantin,

On 02.08.22 18:46, Konstantin Smola wrote:
> The rtnet interface was lacking 32-bit support for bind and connect ioctl.
> 
> Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
> ---
>  kernel/drivers/net/stack/include/rtnet_internal.h |  1 +
>  kernel/drivers/net/stack/ipv4/udp/udp.c           | 39 ++++++++++++++++-------
>  2 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/include/rtnet_internal.h b/kernel/drivers/net/stack/include/rtnet_internal.h
> index ec7e614..8194791 100644
> --- a/kernel/drivers/net/stack/include/rtnet_internal.h
> +++ b/kernel/drivers/net/stack/include/rtnet_internal.h
> @@ -30,6 +30,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <rtdm/driver.h>
> +#include <rtdm/compat.h>
>  
>  #ifdef CONFIG_XENO_DRIVERS_NET_CHECKED
>  #define RTNET_ASSERT(expr, func)                                               \
> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
> index 5977a3b..89f4d80 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> @@ -357,23 +357,40 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
>  	struct rtsocket *sock = rtdm_fd_to_private(fd);
>  	const struct _rtdm_setsockaddr_args *setaddr;
>  	struct _rtdm_setsockaddr_args _setaddr;
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	const struct compat_rtdm_setsockaddr_args *compat_setaddr;
> +	struct compat_rtdm_setsockaddr_args _compat_setaddr;
> +#endif
>  
>  	/* fast path for common socket IOCTLs */
>  	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
>  		return rt_socket_common_ioctl(fd, request, arg);
>  
>  	switch (request) {
> -	case _RTIOC_BIND:
> -	case _RTIOC_CONNECT:
> -		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> -		if (IS_ERR(setaddr))
> -			return PTR_ERR(setaddr);
> -		if (request == _RTIOC_BIND)
> -			return rt_udp_bind(fd, sock, setaddr->addr,
> -					   setaddr->addrlen);
> -
> -		return rt_udp_connect(fd, sock, setaddr->addr,
> -				      setaddr->addrlen);
> +	COMPAT_CASE(_RTIOC_BIND):
> +	COMPAT_CASE(_RTIOC_CONNECT):
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		if (rtdm_fd_is_compat(fd)) {
> +			compat_setaddr = rtnet_get_arg(fd, &_compat_setaddr, arg, sizeof(_compat_setaddr));
> +			if (IS_ERR(compat_setaddr))
> +				return PTR_ERR(compat_setaddr);
> +
> +			if ((request == _RTIOC_BIND) || (request == _RTIOC_BIND_COMPAT))
> +				return rt_udp_bind(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
> +						compat_setaddr->addrlen);
> +			return rt_udp_connect(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
> +						compat_setaddr->addrlen);
> +		} else {
> +#endif
> +			setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> +			if (IS_ERR(setaddr))
> +				return PTR_ERR(setaddr);
> +			if ((request == _RTIOC_BIND) || (request == _RTIOC_BIND_COMPAT))
> +				return rt_udp_bind(fd, sock, setaddr->addr,
> +							setaddr->addrlen);
> +			return rt_udp_connect(fd, sock, setaddr->addr,
> +						setaddr->addrlen);
> +		}

I'm quite sure that this doesn't even compile when
CONFIG_XENO_ARCH_SYS3264 is not defined. You have to move the opening
bracket ("{") ouf of the #ifdef block.



>  
>  	default:
>  		return rt_ip_ioctl(fd, request, arg);

