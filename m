Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B23D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 11:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Athy4jVh32gtj9zpsgX5sAgZaMLIW9FPY7WuVRHISK/lL1CLfgOr+6XYdl6ZAkykxjPi5XkC4IsfRhkZcEHy3AsBhQ8IM1B5s8LVAgVUk6c//OUQYZpbUO9eU69uH3UEWPTrDzPc2QWoQcG2zdE9L3u2xU7vp0q3u6idhPOOmLmmTw0TpNTzFsd6t8ViFMxuG8uu1JpAAtM5e4iMOZjDcn+hfE5GJrBEA2u/TQWbDKY7yOMgGlcodmCaPnq/mz86kU8J7nmL7Ca19Q2kEXeDqXxY7vk2Eua1PDlwwt5nG5in8Fb5zMBG0cal7hccEgQ494VklQ8roveWqthJz55VMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS1Dch6rJVJeCTyRssOCMSTQXsZkpzU8KyW0Y2j7EoI=;
 b=X/z/fYYmHhJtS/R3ru7u2lLT9HwCxHzkB4z9GBRpczatgkw/EpjVk5eNnDnNRfS4t1f2gEVcgaPZ4uUP4LTKxQcZd/XvWSsQW7XZL8t0ey1Er0bzYVADEoFgJonNpeiT6bbwg8iUFxPMMUslRDSCeAZJcl59oyngTxMwaPHke7gMaEFMVE6bb6JIrBnZsdzFMCyIeUinsMzdG/GMBTgen05Y6tu5E8dCVY58rZkJKbHKXdfAmii6GC9j/NNXR4frnIoN0rY6uA5vV89KMGCwmU9YSnB3+zgW0vZF1mJVIRTpoaVH0U+fi3iqEA8X49wTJ9anIFx5fgKRre5xYUrayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS1Dch6rJVJeCTyRssOCMSTQXsZkpzU8KyW0Y2j7EoI=;
 b=HicRyZ1DsVao+1/uIuiUIzG0OchuXvHmWxLEUlyPt7UeXd2v+QhPjDmdaIn5o/nRRVLmO5urCj8Eby+tPNiRQsnz7g9I8DZGrFxdlg8oRA288WDU/0sBdDK3I2g7BQZkSptSYTyRBSfPr/kFJDVb7IZOEXrDpDCEfbAvjGtpjtazT5dXJL5YvCw2xbs/A6Vp5yBaas30PosXTkgVJgHgkG7R71cDGPO5obDbytQ3CCTefcq8qqbQIE95axpF4p+uxNIZGadZdY3SXq1WhrMM5nO6i/nPuZqTH0NsZdRiwTqpe44LofmZg4fiGyBLaWjCkX67TrHSK6B4B/nvF3sVoA==
Received: from AS9PR05CA0042.eurprd05.prod.outlook.com (2603:10a6:20b:489::12)
 by DB8PR10MB3658.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 11:49:30 +0000
Received: from VE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::dc) by AS9PR05CA0042.outlook.office365.com
 (2603:10a6:20b:489::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 11:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT102.mail.protection.outlook.com (10.152.3.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 11:49:29 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 13:49:29 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 13:49:29 +0200
Message-ID: <9b981542-16b9-2ca0-dddc-3444b84c0f23@siemens.com>
Date: Mon, 5 Sep 2022 13:49:28 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220818071442.16567-1-florian.bezdeka@siemens.com>
 <20220818071442.16567-3-florian.bezdeka@siemens.com>
 <7d4cb6f9-1d02-9253-2dc0-7e7d3d7e9e44@siemens.com>
In-Reply-To: <7d4cb6f9-1d02-9253-2dc0-7e7d3d7e9e44@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.275900-8.000000
X-TMASE-MatchedRID: aZnThng3P7U5QaOxwNGfvo9bHfxDWoibKx2x0HdtdQGqh5pv1eDPzwD4
	keG7QhHmGcBq4eMuIsxR3ZVJbCL+bO9CQ8wc8LEOMrz2KSw9dvdK860sg9ASI8Vbb3pjW5MnAaj
	W+EL+laM/gf7afIrQU9N+VO8UR4MhfGzuoVn0Vs6PQi9XuOWoOCf9wxvvYmtJEVuC0eNRYvKOQO
	sE4nDCdFgLks93sG9tPy24lbkT8XLSY5haeed3YLWm60ke8R66w4mZjhdFeRWwVIp8Y8imtUEe5
	VjFzwNb4PRrWDwT3Ut7qLCJ87oUjOV1TwPGhIjaF2fSo3wa4LzSKNGAayk1lXzmmMD/HXF+a01m
	hnn7t6QELMPQNzyJS7KBpljvKsfOniqjVU+K8M96vsh3cr2uXZXvqupO0P3ML8y5bOx03xnLQx8
	PUawjW5soi2XrUn/JyeMtMD9QOgChMIDkR/KfwI2j49Ftap9EOwBXM346/+xxLXWnfRNswG7bmF
	g2h0E0IBJl6wKp3rsB+msBI4C9EAg6WLls9JQU
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.275900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 612EA95830906297F01D8D29A813E68732DBA7961F6280D93882402F1CDF0A892000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c242a983-d6da-482f-8a65-08da8f34b103
X-MS-TrafficTypeDiagnostic: DB8PR10MB3658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qV7hY2bpcJ6tg5kY1fjOakWH20G1ofchpWfOeERt4lXzP9xBUwRSH7cvt4Ru9faaJGu4WZtSJ+nWLTpuZHWq/O8aH0E+df0UnjT38tVX8RvbGvlYCgyBAkOZR/JqcEJpjr6Fyx794BNrVfVBlxBc5lhHXD6zANQtc1pl9vqZg+MAey+4f+jSOTe9lvCQsOJSVKy9qgpDltepRpzJUmXiT1lswGbKsCvOP13yp2T7yuBuiu6Wl08Y4CUphSqP9d7F2S431znVMh6tGl2Kq9jyVyf64LPAAfsesHdfZBXGjeHQJ2Y/Zfs6D+yT6hYrIY7/JPDt0Slz5O7YZpDj75YDx3bSQ00gq6h8T88Xz3OJGwjxbXjmCF0+r1aIc/O2gedcsaBdNCgqWwwobNf4cb/nhflaUXmSxl9vX9njoVeJqHjtBv+M47ooDbLQ57lcSlXcR3iw3E05/wTh5TQ2PnjhsYPDW4wiid9aNxsHR0X4Hs32HFReviQrca3I0onfL0mziBmt6b7+cqgzYJUjARn6WynEIQObob3cNb3li89jMk/QqBoVe+lHhXNuSyJf/DoreCB2Zp+5EkyrXeM0NUZn7pOptAgEvV5DuNVsYoSk+0LH0a5bbUg/uj9oI9C/Che7WeAa1FoY/wBoFVfI2zQl1J6+JSj52XY9jUGjB6um8opAwja3URY4v12+9Cb4o3EURSb6kQgmLsXEGsU4sQi3W/q57qUHJKt5T6+9AkzSL+sqs+TB8+gPdaeR5inrnJwR9WZhuRPemN6xVfs3zqbcknKzF9hc73yqbcnhq4BVmHAyZsfYHJCFrSsKOLrjuT2u9iVOu2LbWR5h+ST8++Ti53+6lblE9ertacJdjdA9qww=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(40470700004)(46966006)(2616005)(186003)(956004)(40460700003)(5660300002)(82310400005)(6706004)(47076005)(110136005)(336012)(356005)(82960400001)(16526019)(8936002)(81166007)(82740400003)(316002)(83380400001)(41300700001)(53546011)(70206006)(26005)(16576012)(86362001)(2906002)(44832011)(31686004)(8676002)(70586007)(478600001)(36860700001)(40480700001)(31696002)(36756003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:49:29.6592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c242a983-d6da-482f-8a65-08da8f34b103
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3658

On 05.09.22 13:44, Jan Kiszka wrote:
> On 18.08.22 09:14, Florian Bezdeka wrote:
>> Once Xenomai was running as compat application (=32bit applicaiton over
>> 64bit kernel) the can smokey test failed. This patch fixes the test by
>> implementing the necessary compat bits.
>>
>> Affected ioctls:
>>   - _RTIOC_BIND
>>   - _RTIOC_SETSOCKOPT
>>
>> Affected syscalls:
>>   - recvmsg
>>   - sendmsg
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  include/cobalt/kernel/rtdm/fd.h |  16 +++++
>>  kernel/cobalt/rtdm/drvlib.c     |  17 +----
>>  kernel/cobalt/rtdm/fd.c         | 122 ++++++++++++++++++++++++++++++++
> 
> Can you factor out the RTDM extensions into a separate commit? Deserves
> to be argued over on its own.
> 
> And can those helpers then be used also be RTnet?

Ah, they are, but only partially. Why not the others? And what about the
IPC drivers?

Jan

> 
> Jan
> 
>>  kernel/drivers/can/rtcan_raw.c  |  42 +++++------
>>  4 files changed, 157 insertions(+), 40 deletions(-)
>>
>> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
>> index 058a9c638..176c67e22 100644
>> --- a/include/cobalt/kernel/rtdm/fd.h
>> +++ b/include/cobalt/kernel/rtdm/fd.h
>> @@ -29,6 +29,8 @@
>>  struct vm_area_struct;
>>  struct rtdm_fd;
>>  struct _rtdm_mmap_request;
>> +struct _rtdm_setsockaddr_args;
>> +struct _rtdm_setsockopt_args;
>>  struct xnselector;
>>  struct cobalt_ppd;
>>  struct rtdm_device;
>> @@ -403,6 +405,20 @@ int rtdm_fd_valid_p(int ufd);
>>  int rtdm_fd_select(int ufd, struct xnselector *selector,
>>  		   unsigned int type);
>>  
>> +int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
>> +				 struct _rtdm_setsockaddr_args *dst,
>> +				 const void *src);
>> +
>> +int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
>> +				struct _rtdm_setsockopt_args *dst,
>> +				const void *src);
>> +
>> +int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
>> +		      const struct user_msghdr *msg, bool rw);
>> +
>> +int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
>> +		      const struct user_msghdr *msg);
>> +
>>  int rtdm_device_new_fd(struct rtdm_fd *fd, int ufd,
>>  		struct rtdm_device *dev);
>>  
>> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
>> index 4eaf3a57c..30455c3d7 100644
>> --- a/kernel/cobalt/rtdm/drvlib.c
>> +++ b/kernel/cobalt/rtdm/drvlib.c
>> @@ -2211,14 +2211,7 @@ int rtdm_get_iovec(struct rtdm_fd *fd, struct iovec **iovp,
>>  		return 0;
>>  	}
>>  
>> -#ifdef CONFIG_XENO_ARCH_SYS3264
>> -	if (rtdm_fd_is_compat(fd))
>> -		return sys32_get_iovec(iov,
>> -			       (struct compat_iovec __user *)msg->msg_iov,
>> -			       msg->msg_iovlen);
>> -#endif
>> -
>> -	return rtdm_copy_from_user(fd, iov, msg->msg_iov, len);
>> +	return rtdm_fd_get_iovec(fd, iov, msg, false);
>>  }
>>  EXPORT_SYMBOL_GPL(rtdm_get_iovec);
>>  
>> @@ -2233,13 +2226,7 @@ int rtdm_put_iovec(struct rtdm_fd *fd, struct iovec *iov,
>>  		memcpy(msg->msg_iov, iov, len);
>>  		ret = 0;
>>  	} else
>> -#ifdef CONFIG_XENO_ARCH_SYS3264
>> -		if (rtdm_fd_is_compat(fd))
>> -			ret = sys32_put_iovec((struct compat_iovec __user *)msg->msg_iov,
>> -					      iov, msg->msg_iovlen);
>> -		else
>> -#endif
>> -			ret = rtdm_copy_to_user(fd, msg->msg_iov, iov, len);
>> +		ret = rtdm_fd_put_iovec(fd, iov, msg);
>>  
>>  	if (iov != iov_fast)
>>  		xnfree(iov);
>> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
>> index ed2e13578..29555cb21 100644
>> --- a/kernel/cobalt/rtdm/fd.c
>> +++ b/kernel/cobalt/rtdm/fd.c
>> @@ -31,6 +31,7 @@
>>  #include <cobalt/kernel/time.h>
>>  #include <pipeline/inband_work.h>
>>  #include <trace/events/cobalt-rtdm.h>
>> +#include <rtdm/compat.h>
>>  #include <rtdm/fd.h>
>>  #include "internal.h"
>>  #include "posix/process.h"
>> @@ -998,6 +999,127 @@ int rtdm_fd_select(int ufd, struct xnselector *selector,
>>  	return ret;
>>  }
>>  
>> +int rtdm_fd_get_setsockaddr_args(struct rtdm_fd *fd,
>> +				 struct _rtdm_setsockaddr_args *dst,
>> +				 const void *src)
>> +{
>> +
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +	if (rtdm_fd_is_compat(fd)) {
>> +		struct compat_rtdm_setsockaddr_args cargs;
>> +		int ret;
>> +
>> +		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
>> +			return -EFAULT;
>> +
>> +		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
>> +		if (ret)
>> +			return ret;
>> +
>> +		dst->addr = compat_ptr(cargs.addr);
>> +		dst->addrlen = cargs.addrlen;
>> +
>> +		return 0;
>> +	}
>> +#endif
>> +
>> +	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
>> +		return -EFAULT;
>> +
>> +	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
>> +}
>> +EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockaddr_args);
>> +
>> +int rtdm_fd_get_setsockopt_args(struct rtdm_fd *fd,
>> +				struct _rtdm_setsockopt_args *dst,
>> +				const void *src)
>> +{
>> +
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +	if (rtdm_fd_is_compat(fd)) {
>> +		struct compat_rtdm_setsockopt_args cargs;
>> +		int ret;
>> +
>> +		if (!rtdm_read_user_ok(fd, src, sizeof(cargs)))
>> +			return -EFAULT;
>> +
>> +		ret = rtdm_copy_from_user(fd, &cargs, src, sizeof(cargs));
>> +		if (ret)
>> +			return ret;
>> +
>> +		dst->optlen = cargs.optlen;
>> +		dst->optval = compat_ptr(cargs.optval);
>> +		dst->optname = cargs.optname;
>> +		dst->level = cargs.level;
>> +
>> +		return 0;
>> +	}
>> +#endif
>> +
>> +	if (!rtdm_read_user_ok(fd, src, sizeof(*dst)))
>> +		return -EFAULT;
>> +
>> +	return rtdm_copy_from_user(fd, dst, src, sizeof(*dst));
>> +}
>> +EXPORT_SYMBOL_GPL(rtdm_fd_get_setsockopt_args);
>> +
>> +int rtdm_fd_get_iovec(struct rtdm_fd *fd, struct iovec *iov,
>> +		      const struct user_msghdr *msg, bool rw)
>> +{
>> +	size_t sz;
>> +
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
>> +#else
>> +	sz = sizeof(*iov);
>> +#endif
>> +
>> +	sz *= msg->msg_iovlen;
>> +
>> +	if (!rw && !rtdm_read_user_ok(fd, msg->msg_iov, sz))
>> +		return -EFAULT;
>> +
>> +	if (rw && !rtdm_rw_user_ok(fd, msg->msg_iov, sz))
>> +		return -EFAULT;
>> +
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +	if (rtdm_fd_is_compat(fd))
>> +		return sys32_get_iovec(
>> +			iov, (struct compat_iovec __user *)msg->msg_iov,
>> +			(int)msg->msg_iovlen);
>> +#endif
>> +
>> +	return rtdm_copy_from_user(fd, iov, msg->msg_iov, sz);
>> +}
>> +EXPORT_SYMBOL_GPL(rtdm_fd_get_iovec);
>> +
>> +int rtdm_fd_put_iovec(struct rtdm_fd *fd, const struct iovec *iov,
>> +		      const struct user_msghdr *msg)
>> +{
>> +	size_t sz;
>> +
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +	sz = rtdm_fd_is_compat(fd) ? sizeof(struct compat_iovec) : sizeof(*iov);
>> +#else
>> +	sz = sizeof(*iov);
>> +#endif
>> +
>> +	sz *= msg->msg_iovlen;
>> +
>> +	if (!rtdm_rw_user_ok(fd, msg->msg_iov, sz))
>> +		return -EFAULT;
>> +
>> +#ifdef CONFIG_XENO_ARCH_SYS3264
>> +	if (rtdm_fd_is_compat(fd))
>> +		return sys32_put_iovec(
>> +			(struct compat_iovec __user *)msg->msg_iov, iov,
>> +			(int)msg->msg_iovlen);
>> +#endif
>> +
>> +	return rtdm_copy_to_user(fd, msg->msg_iov, iov, sz);
>> +}
>> +EXPORT_SYMBOL_GPL(rtdm_fd_put_iovec);
>> +
>>  static void destroy_fd(void *cookie, struct xnid *id)
>>  {
>>  	struct cobalt_ppd *p = cookie;
>> diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
>> index dffc6e837..92b7617fb 100644
>> --- a/kernel/drivers/can/rtcan_raw.c
>> +++ b/kernel/drivers/can/rtcan_raw.c
>> @@ -41,6 +41,7 @@
>>  #include <rtdm/driver.h>
>>  
>>  #include <rtdm/can.h>
>> +#include <rtdm/compat.h>
>>  #include "rtcan_version.h"
>>  #include "rtcan_socket.h"
>>  #include "rtcan_list.h"
>> @@ -411,17 +412,15 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
>>      int ret = 0;
>>  
>>      switch (request) {
>> -    case _RTIOC_BIND: {
>> +    COMPAT_CASE(_RTIOC_BIND): {
>> +
>>  	struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
>>  	struct sockaddr_can *sockaddr, sockaddr_buf;
>>  
>>  	if (rtdm_fd_is_user(fd)) {
>> -	    /* Copy argument structure from userspace */
>> -	    if (!rtdm_read_user_ok(fd, arg,
>> -				   sizeof(struct _rtdm_setsockaddr_args)) ||
>> -		rtdm_copy_from_user(fd, &setaddr_buf, arg,
>> -				    sizeof(struct _rtdm_setsockaddr_args)))
>> -		return -EFAULT;
>> +	    ret = rtdm_fd_get_setsockaddr_args(fd, &setaddr_buf, arg);
>> +	    if (ret)
>> +		return ret;
>>  
>>  	    setaddr = &setaddr_buf;
>>  
>> @@ -447,16 +446,14 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
>>  	break;
>>      }
>>  
>> -    case _RTIOC_SETSOCKOPT: {
>> +    COMPAT_CASE(_RTIOC_SETSOCKOPT): {
>>  	struct _rtdm_setsockopt_args *setopt;
>>  	struct _rtdm_setsockopt_args setopt_buf;
>>  
>>  	if (rtdm_fd_is_user(fd)) {
>> -	    if (!rtdm_read_user_ok(fd, arg,
>> -				   sizeof(struct _rtdm_setsockopt_args)) ||
>> -		rtdm_copy_from_user(fd, &setopt_buf, arg,
>> -				    sizeof(struct _rtdm_setsockopt_args)))
>> -		return -EFAULT;
>> +	    ret = rtdm_fd_get_setsockopt_args(fd, &setopt_buf, arg);
>> +	    if (ret)
>> +		    return ret;
>>  
>>  	    setopt = &setopt_buf;
>>  	} else
>> @@ -575,11 +572,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
>>  
>>      if (rtdm_fd_is_user(fd)) {
>>  	/* Copy IO vector from userspace */
>> -	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
>> -			     sizeof(struct iovec)) ||
>> -	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
>> -				sizeof(struct iovec)))
>> -	    return -EFAULT;
>> +	ret = rtdm_fd_get_iovec(fd, &iov_buf, msg, true);
>> +	if (ret)
>> +		return -EFAULT;
>>  
>>  	iov = &iov_buf;
>>      }
>> @@ -716,9 +711,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
>>  	iov->iov_base += sizeof(can_frame_t);
>>  	iov->iov_len -= sizeof(can_frame_t);
>>  	/* ... and copy it, too. */
>> -	if (rtdm_copy_to_user(fd, msg->msg_iov, iov,
>> -			      sizeof(struct iovec)))
>> -	    return -EFAULT;
>> +	ret = rtdm_fd_put_iovec(fd, iov, msg);
>> +	if (ret)
>> +		return -EFAULT;
>>  
>>  	/* Copy timestamp if existent and wanted */
>>  	if (msg->msg_controllen) {
>> @@ -922,10 +917,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
>>      if (rtdm_fd_is_user(fd)) {
>>  
>>  	/* Copy IO vector from userspace */
>> -	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
>> -			     sizeof(struct iovec)) ||
>> -	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
>> -				sizeof(struct iovec))) {
>> +	if (rtdm_fd_get_iovec(fd, &iov_buf, msg, false)) {
>>  	    ret = -EFAULT;
>>  	    goto finally;
>>  	}
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux
