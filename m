Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98EE3D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 11:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQxWg1dOVkczM9fx01zx5MoQLvN9iYnm/Oqu71cYfCC+FjD0UMygaP6LhgDzBGbuGFF14JegVFA7QWOq+vycv+5zHM9sjRKzPgOCVZDtTU69fq3rOsS2xf0vzvv3tihE6OFhQqMqx6an96TNWuWRmPkdTxuMfejS1D+8Ghfqh1b4psLzQcFLvNgHFriGM14O9Sd00V8Zn+paU5HH6S36YtqrHkHBA+4MAh5ggj3c1A4sNYrHMFtotLD1LfArPKDfhy3ImQG0CeHVVz1NI0Yas0PdflkeT/6bNb4RBuTJnqZnKEUXa/NLO5wKrZXekYU0xtXesAzfwKozKjW5my/xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/sWc9bVO2saKiB4sm6oAjFC4uCB9vXR7ev04v2ns3M=;
 b=Is773b8P30gt1ymVoFfBxaR5REkQlDzUlO2lrrE5tcbC+b+RrsTR2V5s150KcO0kumEZRlwzI2NqcDjxcSX9RMdm3Ys9gxodo+OajwhinB3/KXV06CWaDGeWCP+2iNUHXw3IXx+gdeyiLCtF6arNzdJnqr917uqbEjdpI55boeaiJ7fzNJq3gjjrEOE/gv2rT8zswTtJrEh5EpiMJ/+rur3QcWDD4g1MuulfgIp35vuqedTwbkjZajhpwvHa5BISx3GnEfqNdD6Hd5qrmUTzytPiIdsrdFUSIBJlNJJcaF2a7u8usuW+1sFoGAuhhtXezwge/51leXw8MAmOfyfSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/sWc9bVO2saKiB4sm6oAjFC4uCB9vXR7ev04v2ns3M=;
 b=DELtcCA+E9VwyhFYD3WIZfBE/bHgXXnBSCYJCCeKCJTnkv4VfFa8OKznEwcRepccrFDUe/eG7R9U6iEDpCSvELAtD6c7RjKEKwgEyPsFU0Rf3OdoQNuoEWonlTKDb3lnruaogzkpCByUMI2yyqnNfusLe8/yYge0MWUZgbyv4g3nSqa1EQscvq0R2N0+D5DKliFrR2oLW0h9b9lF+s5baOqZ5NSqfEAjYl04ZDPYE8wuwCmB+zNU/25xA7UTf/07XWNBjgChYp79X9Z2Qf4DmDb4M5rTznLFza8/AoO8QabzOljhfA0/x8whib/dZFut+lKtUU7gGYmxpa5YxA/tsg==
Received: from GV3P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::8) by
 DU0PR10MB7264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Mon, 5 Sep 2022 11:44:55 +0000
Received: from HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::94) by GV3P280CA0028.outlook.office365.com
 (2603:10a6:150:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 5 Sep 2022 11:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT025.mail.protection.outlook.com (10.152.0.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 11:44:54 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 13:44:53 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 13:44:52 +0200
Message-ID: <7d4cb6f9-1d02-9253-2dc0-7e7d3d7e9e44@siemens.com>
Date: Mon, 5 Sep 2022 13:44:52 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] drivers/rtcan: Implement compat support for the rtcan
 driver
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220818071442.16567-1-florian.bezdeka@siemens.com>
 <20220818071442.16567-3-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220818071442.16567-3-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.285900-8.000000
X-TMASE-MatchedRID: ObgwaKFsELA5QaOxwNGfvo9bHfxDWoibKx2x0HdtdQGqh5pv1eDPzwD4
	keG7QhHmGcBq4eMuIsxR3ZVJbCL+bO9CQ8wc8LEOMrz2KSw9dvdK860sg9ASI8Vbb3pjW5Mneou
	vej40T4gGmHr1eMxt2UAc6DyoS2rI3BlBvFCka9uXdjRyFeyfOSf7ZnjOtvquCtzGvPCy/m7ESS
	xPxTa9g754YCapH5tARyqMLIj/WA2ceOSXXTgby4m6LcRGJJ1s08q9KSsUtVcJ6xTeI+I0LCv2B
	WU4g3/qWkqr3dgqWbjTohhY3qi5AviXRazGZ0jHXVY6w74lRC/qoZjr3sTUk8zSKGx9g8xhhVDn
	kfzD7uadzjX37VUcWtufb2MQVcanK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrRZjEy1CyBP93Vwgj50dS38C3obqWaq33CRmip
	XluQXQbR4zVBcR1b8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.285900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: E83E46C1580CD1C1765DDD4789C8D2A7F979C80B80467CF8C822730FFA3A12E22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 369c1ee2-52f3-4b58-be56-08da8f340d4e
X-MS-TrafficTypeDiagnostic: DU0PR10MB7264:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZsZaYLW8oDYzoiDegyiF3bZE5PWpL+sUErzJWJoqP8UCOGpsr3ajmpOHQ2De4S81WSVZzFz1jeAdMyHogctLUCgRGI1j56bsTpBN04i/AfebdObal+R8Pyhi8e6cxVHJhcNwKr8C25ub5gKNO+mNe3RRgx3m/j/CDTZk0fR7vURifJjjE4Qu3o6rtl15oRDhHQdaOUa3og+IdtamZBqTu0E8uIAzcjPt0zKuvwUEEvnWGJxWsfDhSvpotczFx+DhvQxo8LYRMNoB2IESeUIxfjguPKEiTgh0PptT52t1mqQNaaK2Q6sw4rGh4e61+V9SQV3qWkgl8aUie5MmPgS8hKysANVv5Xh4xtxyOfdxpBoRVZylFihJDRfDHI8k7NGO0DUQuSKBQYakl0CpF3j8VDRi5oPcc2oQijpw8G3s3fidt92xnDlmSyOjDLHyXh1UPX3GXJntSQ/oyKqj47hg9GcFpkcu0CEPw/jeg5ZIr+dgjn4nOqnrqpGAGPpWmdrRj1C2RxBEkQtrCADCpYFrbJgVzqCGfOeK6Y183SWnEBUdSSPVHj8u5dkun7GrM4F6Ymq/8IICtCKlSXUiB3YMzcYcDjHp4VotghHVHuBt42Eb1hLB2ggpYktKR+/+iLcwunY+fmgm7GEs7HK4B2n5d1pcdUCjKQB2lJj3D13UbiZuoZtwBnnRUI+sZ2PnashfHeZKuj5Jv1Qbwl8f7lrakn28q281/sH138lY/pNblVZiPzANOD8rAnDGZ0btb3s/eCXb1OTh+rdnsjBgMY/gTegVKX1EgUxOgobMC9dcISTdIBFtk4UrPvFd+QzDsfpgw9MWc+dMxpllOcjD2tYnGEAUViKU/F52PtyRyEA2UF0=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(316002)(82960400001)(356005)(16576012)(86362001)(81166007)(83380400001)(31686004)(70206006)(36756003)(8676002)(110136005)(478600001)(82740400003)(6706004)(70586007)(40480700001)(2906002)(336012)(40460700003)(8936002)(186003)(53546011)(82310400005)(2616005)(44832011)(5660300002)(41300700001)(16526019)(47076005)(31696002)(956004)(36860700001)(26005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:44:54.9588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369c1ee2-52f3-4b58-be56-08da8f340d4e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7264

On 18.08.22 09:14, Florian Bezdeka wrote:
> Once Xenomai was running as compat application (=32bit applicaiton over
> 64bit kernel) the can smokey test failed. This patch fixes the test by
> implementing the necessary compat bits.
> 
> Affected ioctls:
>   - _RTIOC_BIND
>   - _RTIOC_SETSOCKOPT
> 
> Affected syscalls:
>   - recvmsg
>   - sendmsg
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/rtdm/fd.h |  16 +++++
>  kernel/cobalt/rtdm/drvlib.c     |  17 +----
>  kernel/cobalt/rtdm/fd.c         | 122 ++++++++++++++++++++++++++++++++

Can you factor out the RTDM extensions into a separate commit? Deserves
to be argued over on its own.

And can those helpers then be used also be RTnet?

Jan

>  kernel/drivers/can/rtcan_raw.c  |  42 +++++------
>  4 files changed, 157 insertions(+), 40 deletions(-)
> 
> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
> index 058a9c638..176c67e22 100644
> --- a/include/cobalt/kernel/rtdm/fd.h
> +++ b/include/cobalt/kernel/rtdm/fd.h
> @@ -29,6 +29,8 @@
>  struct vm_area_struct;
>  struct rtdm_fd;
>  struct _rtdm_mmap_request;
> +struct _rtdm_setsockaddr_args;
> +struct _rtdm_setsockopt_args;
>  struct xnselector;
>  struct cobalt_ppd;
>  struct rtdm_device;
> @@ -403,6 +405,20 @@ int rtdm_fd_valid_p(int ufd);
>  int rtdm_fd_select(int ufd, struct xnselector *selector,
>  		   unsigned int type);
>  
> +int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
> +				 struct _rtdm_setsockaddr_args *dst,
> +				 const void *src);
> +
> +int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
> +				struct _rtdm_setsockopt_args *dst,
> +				const void *src);
> +
> +int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
> +		      const struct user_msghdr *msg, bool rw);
> +
> +int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
> +		      const struct user_msghdr *msg);
> +
>  int rtdm_device_new_fd(struct rtdm_fd *fd, int ufd,
>  		struct rtdm_device *dev);
>  
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 4eaf3a57c..30455c3d7 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -2211,14 +2211,7 @@ int rtdm_get_iovec(struct rtdm_fd *fd, struct iovec **iovp,
>  		return 0;
>  	}
>  
> -#ifdef CONFIG_XENO_ARCH_SYS3264
> -	if (rtdm_fd_is_compat(fd))
> -		return sys32_get_iovec(iov,
> -			       (struct compat_iovec __user *)msg->msg_iov,
> -			       msg->msg_iovlen);
> -#endif
> -
> -	return rtdm_copy_from_user(fd, iov, msg->msg_iov, len);
> +	return rtdm_fd_get_iovec(fd, iov, msg, false);
>  }
>  EXPORT_SYMBOL_GPL(rtdm_get_iovec);
>  
> @@ -2233,13 +2226,7 @@ int rtdm_put_iovec(struct rtdm_fd *fd, struct iovec *iov,
>  		memcpy(msg->msg_iov, iov, len);
>  		ret = 0;
>  	} else
> -#ifdef CONFIG_XENO_ARCH_SYS3264
> -		if (rtdm_fd_is_compat(fd))
> -			ret = sys32_put_iovec((struct compat_iovec __user *)msg->msg_iov,
> -					      iov, msg->msg_iovlen);
> -		else
> -#endif
> -			ret = rtdm_copy_to_user(fd, msg->msg_iov, iov, len);
> +		ret = rtdm_fd_put_iovec(fd, iov, msg);
>  
>  	if (iov != iov_fast)
>  		xnfree(iov);
> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
> index ed2e13578..29555cb21 100644
> --- a/kernel/cobalt/rtdm/fd.c
> +++ b/kernel/cobalt/rtdm/fd.c
> @@ -31,6 +31,7 @@
>  #include <cobalt/kernel/time.h>
>  #include <pipeline/inband_work.h>
>  #include <trace/events/cobalt-rtdm.h>
> +#include <rtdm/compat.h>
>  #include <rtdm/fd.h>
>  #include "internal.h"
>  #include "posix/process.h"
> @@ -998,6 +999,127 @@ int rtdm_fd_select(int ufd, struct xnselector *selector,
>  	return ret;
>  }
>  
> +int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
> +				 struct _rtdm_setsockaddr_args *dst,
> +				 const void *src)
> +{
> +
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	if (rtdm_fd_is_compat(fd)) {
> +		struct compat_rtdm_setsockaddr_args cargs;
> +		int ret;
> +
> +		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
> +			return -EFAULT;
> +
> +		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
> +		if (ret)
> +			return ret;
> +
> +		dst->addr = compat_ptr(cargs.addr);
> +		dst->addrlen = cargs.addrlen;
> +
> +		return 0;
> +	}
> +#endif
> +
> +	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
> +		return -EFAULT;
> +
> +	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
> +}
> +EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockaddr_args);
> +
> +int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
> +				struct _rtdm_setsockopt_args *dst,
> +				const void *src)
> +{
> +
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	if (rtdm_fd_is_compat(fd)) {
> +		struct compat_rtdm_setsockopt_args cargs;
> +		int ret;
> +
> +		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
> +			return -EFAULT;
> +
> +		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
> +		if (ret)
> +			return ret;
> +
> +		dst->optlen = cargs.optlen;
> +		dst->optval = compat_ptr(cargs.optval);
> +		dst->optname = cargs.optname;
> +		dst->level = cargs.level;
> +
> +		return 0;
> +	}
> +#endif
> +
> +	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
> +		return -EFAULT;
> +
> +	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
> +}
> +EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockopt_args);
> +
> +int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
> +		      const struct user_msghdr *msg, bool rw)
> +{
> +	size_t sz;
> +
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
> +#else
> +	sz = sizeof(*iov);
> +#endif
> +
> +	sz *= msg->msg_iovlen;
> +
> +	if (!rw && !rtdm_read_user_ok(fd, msg->msg_iov, sz))
> +		return -EFAULT;
> +
> +	if (rw && !rtdm_rw_user_ok(fd, msg->msg_iov, sz))
> +		return -EFAULT;
> +
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	if (rtdm_fd_is_compat(fd))
> +		return sys32_get_iovec(
> +			iov, (struct compat_iovec __user *)msg->msg_iov,
> +			(int)msg->msg_iovlen);
> +#endif
> +
> +	return rtdm_copy_from_user(fd, iov, msg->msg_iov, sz);
> +}
> +EXPORT_SYMBOL_GPL(rtdm_fd_get_iovec);
> +
> +int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
> +		      const struct user_msghdr *msg)
> +{
> +	size_t sz;
> +
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
> +#else
> +	sz = sizeof(*iov);
> +#endif
> +
> +	sz *= msg->msg_iovlen;
> +
> +	if (!rtdm_rw_user_ok(fd, msg->msg_iov, sz))
> +		return -EFAULT;
> +
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	if (rtdm_fd_is_compat(fd))
> +		return sys32_put_iovec(
> +			(struct compat_iovec __user *)msg->msg_iov, iov,
> +			(int)msg->msg_iovlen);
> +#endif
> +
> +	return rtdm_copy_to_user(fd, msg->msg_iov, iov, sz);
> +}
> +EXPORT_SYMBOL_GPL(rtdm_fd_put_iovec);
> +
>  static void destroy_fd(void *cookie, struct xnid *id)
>  {
>  	struct cobalt_ppd *p = cookie;
> diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
> index dffc6e837..92b7617fb 100644
> --- a/kernel/drivers/can/rtcan_raw.c
> +++ b/kernel/drivers/can/rtcan_raw.c
> @@ -41,6 +41,7 @@
>  #include <rtdm/driver.h>
>  
>  #include <rtdm/can.h>
> +#include <rtdm/compat.h>
>  #include "rtcan_version.h"
>  #include "rtcan_socket.h"
>  #include "rtcan_list.h"
> @@ -411,17 +412,15 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
>      int ret = 0;
>  
>      switch (request) {
> -    case _RTIOC_BIND: {
> +    COMPAT_CASE(_RTIOC_BIND): {
> +
>  	struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
>  	struct sockaddr_can *sockaddr, sockaddr_buf;
>  
>  	if (rtdm_fd_is_user(fd)) {
> -	    /* Copy argument structure from userspace */
> -	    if (!rtdm_read_user_ok(fd, arg,
> -				   sizeof(struct _rtdm_setsockaddr_args)) ||
> -		rtdm_copy_from_user(fd, &setaddr_buf, arg,
> -				    sizeof(struct _rtdm_setsockaddr_args)))
> -		return -EFAULT;
> +	    ret = rtdm_fd_get_setsockaddr_args(fd, &setaddr_buf, arg);
> +	    if (ret)
> +		return ret;
>  
>  	    setaddr = &setaddr_buf;
>  
> @@ -447,16 +446,14 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
>  	break;
>      }
>  
> -    case _RTIOC_SETSOCKOPT: {
> +    COMPAT_CASE(_RTIOC_SETSOCKOPT): {
>  	struct _rtdm_setsockopt_args *setopt;
>  	struct _rtdm_setsockopt_args setopt_buf;
>  
>  	if (rtdm_fd_is_user(fd)) {
> -	    if (!rtdm_read_user_ok(fd, arg,
> -				   sizeof(struct _rtdm_setsockopt_args)) ||
> -		rtdm_copy_from_user(fd, &setopt_buf, arg,
> -				    sizeof(struct _rtdm_setsockopt_args)))
> -		return -EFAULT;
> +	    ret = rtdm_fd_get_setsockopt_args(fd, &setopt_buf, arg);
> +	    if (ret)
> +		    return ret;
>  
>  	    setopt = &setopt_buf;
>  	} else
> @@ -575,11 +572,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
>  
>      if (rtdm_fd_is_user(fd)) {
>  	/* Copy IO vector from userspace */
> -	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
> -			     sizeof(struct iovec)) ||
> -	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
> -				sizeof(struct iovec)))
> -	    return -EFAULT;
> +	ret = rtdm_fd_get_iovec(fd, &iov_buf, msg, true);
> +	if (ret)
> +		return -EFAULT;
>  
>  	iov = &iov_buf;
>      }
> @@ -716,9 +711,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
>  	iov->iov_base += sizeof(can_frame_t);
>  	iov->iov_len -= sizeof(can_frame_t);
>  	/* ... and copy it, too. */
> -	if (rtdm_copy_to_user(fd, msg->msg_iov, iov,
> -			      sizeof(struct iovec)))
> -	    return -EFAULT;
> +	ret = rtdm_fd_put_iovec(fd, iov, msg);
> +	if (ret)
> +		return -EFAULT;
>  
>  	/* Copy timestamp if existent and wanted */
>  	if (msg->msg_controllen) {
> @@ -922,10 +917,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
>      if (rtdm_fd_is_user(fd)) {
>  
>  	/* Copy IO vector from userspace */
> -	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
> -			     sizeof(struct iovec)) ||
> -	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
> -				sizeof(struct iovec))) {
> +	if (rtdm_fd_get_iovec(fd, &iov_buf, msg, false)) {
>  	    ret = -EFAULT;
>  	    goto finally;
>  	}

-- 
Siemens AG, Technology
Competence Center Embedded Linux
