Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E246B2
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 09:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDzviUdAdGRSaBV01B1m7gGtPYIxLYbH/d1Qu6BuoRUi7YB5qgfhqPNQHuextYyEgnE8LCR1FW+yg6OGfVZM2EjGpT4O7mYK3iY3i5hvU0eMSyUZuzbBihwpkvO8iM272BgPBoVt+7HX+kc3iFRF8KWUVqFbM1reznBlZT+gTx12hE7k4eUxG2XIdx8/XhLNNiTzFE6h77EPZKshYp7rIxD+yZXMG3orfJ3lzEJq7k8QSSQuVKgBKXQgzfX13uPrEC7wtYRM+vGJmwNNAfVrIsY9C/COE3SqAepsB0A/n4bNbaebWU58OVc810f6bv8IGL6uUkvQgdZEgcRT+6QCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7loUegtnLndSf08uVsATJfFiTi6vhf8Fg/fdRtZqF2k=;
 b=BYpoaLPmF0U8lJxTiiUQvcfM+x7ZrA8kH+PR9HG9KQ/+1vJWwwnOhSBAHfKHYaFWUNf0y24CSFH7opI8Z4IN8aUBpCrOMNzzyd3R5fGb2/g8Fxtgq125FpY5TjTqos/cApw9A0McnDvYuB3AdAezIKUG1m+0V9aKxUr/V609UYa4HjFY5FopYWEC5yqAeNa1tf8Xd0Fu2ozs+mrS4FZy9NWMWixtpSQcpHO749Q2QEhLUZU8qKHVk7vhz14cccb7QhFQGD7UfW36Natu9Pt6Iurd8NeQcYliHOaTS1PiFby23qCFdPRGdRTJL9WKJhptIrEZlgJ92ZqMjcUXA5IK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7loUegtnLndSf08uVsATJfFiTi6vhf8Fg/fdRtZqF2k=;
 b=wbmxzTql1s5dkb+ZkJMyu2V+kr5KKoLMQ0FhZ1QktUN1G+CpPYmEjkfuYAhiZZG+9nt3P/mqomBQmmWojdEz1Yok4Kd2l8rOgIPs1wBmFfQGcYUCIeRbTKRy1YI3Iv7N4PjbI/7Pp1c47MZK1Z3m7Uh64aomHgYlD8KCZ9Iiby3deUQRMTrQyq1fN/+XdHdgxpZ1F2YJenmLD+zl5kR2fZkSj5dJwc32q4g8AAEi07a3B+US7WoAxcS37lt9YS9oaDeXgciYnEzLNG5Z7mVH3f8p+ityOT9o8yYkPFYuDS9SDcMVVOPoS/BCLF8jAUDzME5PC9aNtSUO6KiB63c/0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:17:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:17:00 +0000
Message-ID: <61004f9c-6d5c-6cf9-1b94-d6053f90d9c8@siemens.com>
Date: Tue, 30 May 2023 11:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] y2038: cobalt/posix/select: Refactor
 __cobalt_select()
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
 <20230516-florian-y2038-part-three-v2-1-3fc689b21a32@siemens.com>
 <6d7f05db-4158-9b1d-cc70-7a7681ad9aa0@siemens.com>
 <beb2687da573bcc25e0f42d45c7ac23a55e17553.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <beb2687da573bcc25e0f42d45c7ac23a55e17553.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5693e4-ca50-4769-ebb9-08db60ee9fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7n4GThrateefbsmq+jNEJ41WtM3BXp6nYbMXMau45UZR8DRF9eYGAHFcje1J/Y2oL5m7rGWTeKWCA+s/ya/7M0YZWcuFdJ9WO5dEczpl4ihcPqVokqARyWVoEXy6hAmM5t5BOzgyMv6WRBAaZr2iQVCyNohTKyamEhAlDQXj6/nGNLGHnIMFfnFI1q3vBonnzj3sGi4uMn++JoWlef/gB9N5YiLGIc8FKrKq8HHVIjp7zECHlYv2q5TZ+TEKTiqmUdxzrNVk3i3Byihl9XJvz8jopbTDJDXMBWEA07aHjIRwYOtUUXUdiixO3aHJIaQac+ACTCpvgv0Jem22IwCaXr24EoXOZCfYvwowKZReKA2uPVw+4fWU8jUAPS6szTbMvL/GZUyYD6uejpVwBwd4wmrzC8nlrcRWnGkRdeoft79ZkqMHLyXDZW/rTIdQmxrpryvJ8qGknd8YNHJoWsunJDQuCj7UgO9QPyVXJTmohdR/gNSMPcJuxC5XPfnQaUh1bqnyFckvbB5DEujfmB8D+yphgpjQM6CEhGvl3XtbkjcvcN7NP2n6P2oSeqdNnlOvdsW+y8ktmIDdNrZA+dn4zGdh/jh1k2eh5j7O15AMpvCYojaj0/YenuJSbqueBVOq0wiDNe0rzNc8071IMBlFng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(6512007)(53546011)(6506007)(26005)(6486002)(6666004)(478600001)(82960400001)(66946007)(66476007)(66556008)(316002)(5660300002)(8936002)(8676002)(44832011)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vmg5bWNoS3hIb1JuRUZmczF4SzZ1Q2xaaU5ZK2VIV3R3L1M1ZUM4TkNQMDA1?=
 =?utf-8?B?eE5pSkFXM3JZbEZoZEwrR1d4WGVvMi9vcWJPOUJwMjJ1VEZhV1FVYm95SmVV?=
 =?utf-8?B?eVB1SWE2U0dvcnJoQUxSVzQyVitrVXN1N2NtVGV6NHFHWHlPSERsb1ovV3NS?=
 =?utf-8?B?S3FwVGdwcitna25CWW14blVFNDgxYWhoQjdKNkdJZVFLWmRxdUJEay8yeEVk?=
 =?utf-8?B?RGo2akVqNWNNV1BlbFdGVEpLcWkyZDlkMG5wSktiNk1Qc3NvNHdCSytIL2JQ?=
 =?utf-8?B?RzY3djdLWmNxUTdTcjM4MW9LREhIOWorSW1iQnVXLzdwa0Z0bjhPWmZ6T2lY?=
 =?utf-8?B?ZnVLZytvdDhXNW5kQ1RWVlRlSTVpSW9NRnFDWFhTZS9QSjV2b0p1M2huK2Vt?=
 =?utf-8?B?N3BKallCc2pqeU1CbVdmdDVyZFhxRFN0aVRTRk1xOW5vS3M2c2J2bk5MYTFy?=
 =?utf-8?B?Ull2VXc0R0RYSGhKTjRpTTMrVGgrSnZrTUROaHhIYWg2b3JPZU9MOFgxSldW?=
 =?utf-8?B?Wmt4bXRKRWtpbEtIek9uUGE4REZvS3JYYUxoVGFPVnVURlZ6OXpaK2d2LytQ?=
 =?utf-8?B?T3EzWlRCdUtkUFRvV2JSY1RIcFp3c2ordXJqa1VNazc4cHR0SGk5SENKbUp5?=
 =?utf-8?B?Ky9mQThhWE5lQjNCSVg3dTdUdW9jWDN5UXNjT1pZY0ozN1p3c3RFOTl6aExH?=
 =?utf-8?B?bVd1aXYvMlpLcDNFcXJucnRUSzcyZW5NbWI5d3pWUUp0ZlBJdC9sRWhRUXFC?=
 =?utf-8?B?OWdGY1pkSnlsaHA4Nk5KVDJBanl4aWFGbWh5aFl3cHN4ODEveG1DKzlNbWVB?=
 =?utf-8?B?NmdTcC9FSHpWR1dZRFVvWEFCVkl0NHVpeE1pZjkvd1JWeTRlSUsxUE9qOHBN?=
 =?utf-8?B?Yzh6YjN0cGV6eko2Q3NjbFVBUVhSdWMwZWVqYVF4bHlNaG0ySUtwUzBXcGJp?=
 =?utf-8?B?dDFQcGU0dWNSZTVqNjRqQXNWYUcrZ0VnMm9aSVpURGFwa2xmU3JzNHQ0MGNv?=
 =?utf-8?B?WXNjZjZqUU44azlFeWh4SklsVnVlK09mV285dGp3cklySzZNbGY0VnJ2eWpN?=
 =?utf-8?B?YzlOSmhaQnFUS2lNcnFKbVpBL05jaUhHYkJ6cnk4clVhdC9yMHNPNndVYmxD?=
 =?utf-8?B?dUNjNUxPSUV3Ky9QVXJYK0VRNFNNOCtNN0JnZjFpQy9vMjdLR1MySWgwTndD?=
 =?utf-8?B?aXY0aHU4TGNJR1UzQmF2V3I3d21UYXNyQXphaEF5dnN1K2FZNExrcnM0Zncw?=
 =?utf-8?B?eHVDS0ZpbUhXcklmaTZXblUwam5vd0NhQ3p6VGJaYS8zanFtOHp6QzJ5TlJQ?=
 =?utf-8?B?TzlWY0R2K2xEMTUyT3BxV1paU1RwaTZoTUJGeTBHV1lKVzlGQzFsVWcyaWE5?=
 =?utf-8?B?M1lnOEFPZGJqWmo0TnNTdnduaStZRXdaZFFVY3Z5YmVkUjZPdU14REhnMGI1?=
 =?utf-8?B?TXQ0Vmd4bHRiQ0w3OVhvMU1pVG9wMGp1ZUliR3hQV0UzL2dUQ3BleEorcGZz?=
 =?utf-8?B?QU9SRVNiRE8yKzlHTUwyV0tDeVltZ2lWMmkzT0d3K1libXc0UlkzNkNHNTNC?=
 =?utf-8?B?RFltMDQyMWs0ZURZTEJzNFRYTWxzWjBhS0hMelZhVytoVVhFcjZUWlVXcmJw?=
 =?utf-8?B?bnduY1QxbjR1dEtKeDhlcit3V1JJa3FBNkxiamxvS3czdlo0TEtOc21NS1RD?=
 =?utf-8?B?THdsRzNaWndkUll6Q3RINHZZMmxNY2c0RUJMQjI3NGg1cVJJRm1FY0tyYmov?=
 =?utf-8?B?M3BkZi90YmFpSGxvSG1INTJldlVoc1dTMEV4dG93N0NxdnRVeEdWUUVhMzlX?=
 =?utf-8?B?MlhBckNZV2JLajM2amx5eUttclNwUVBqM0dMUkdxREE5WFUwcnBvbGRCU0wy?=
 =?utf-8?B?aGd4YVhTYTNFZDJ5cWZ3amt3YlNRNGplUnpQZG9uODBreTl2NGoxSEZJazhJ?=
 =?utf-8?B?dk9qcWxUYmU3ZjhVWXl3MDN5L21CMm1uWXhZakRLNHp4TGFZQldtLy9pVjZI?=
 =?utf-8?B?R0d2WkdnMkNSMFpFK014VURDK3NFZnYxQUo4dWh3N2RQd21jMi9WbkFxM0ZN?=
 =?utf-8?B?OE8vMnFSUHpTdVBBSk1Qby9zTXhQQ1JLZnFISWFLY3RlcUExT2FlYWhvNTdI?=
 =?utf-8?B?RUp5bUdFWGRkZ2pEZXpxbzNzWXhsbUNpakVhYXRMNXExVXpxZHkrRFZMcmRo?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5693e4-ca50-4769-ebb9-08db60ee9fe4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:17:00.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJh1Wl9r77/2s4E1AgBOpJyvoRbMsiGoCUhc/6QqsR04ayLhz+t4K5c4Jb6WilLYZXqc3s0PMrjVJmQdmevGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3759

On 30.05.23 11:01, Florian Bezdeka wrote:
> On Mon, 2023-05-29 at 13:11 +0200, Jan Kiszka wrote:
>> On 26.05.23 07:35, Florian Bezdeka wrote:
>>> There is no y2038 safe select() syscall provided by Linuy. If y2038
>>> safety is required the application should not use select() and move on
>>> to something like pselect().
>>>
>>> As we still want to support select() for keeping backward compatibility
>>> - even if y2038 safety is requested - an additional pselect() based
>>> entry will be introduced soon which will re-use __cobalt_select().
>>>
>>> This patch moves all the timeout related userspace copy operations out
>>> of __cobalt_select() and migrates __cobalt_select() to
>>> struct timespec64. That will allow pselect64() to be based on
>>> __cobalt_select() as well.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 ++++++++
>>>  kernel/cobalt/posix/clock.h                        |  6 +--
>>>  kernel/cobalt/posix/io.c                           | 60 ++++++++++------------
>>>  kernel/cobalt/posix/syscall32.c                    | 22 +++++++-
>>>  4 files changed, 74 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>>> index 70b3e68f9..d61b985fb 100644
>>> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>>> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>>> @@ -138,6 +138,28 @@ static inline int cobalt_put_u_itimerspec(
>>>  	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
>>>  }
>>>  
>>> +static inline struct timespec64
>>> +cobalt_timeval_to_timespec64(const struct __kernel_old_timeval *src)
>>> +{
>>> +	struct timespec64 ts;
>>> +
>>> +	ts.tv_sec = src->tv_sec + (src->tv_usec / USEC_PER_SEC);
>>> +	ts.tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
>>> +
>>> +	return ts;
>>> +}
>>> +
>>> +static inline struct __kernel_old_timeval
>>> +cobalt_timespec64_to_timeval(const struct timespec64 *src)
>>> +{
>>> +	struct __kernel_old_timeval tv;
>>> +
>>> +	tv.tv_sec = src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
>>> +	tv.tv_usec = (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
>>> +
>>> +	return tv;
>>> +}
>>> +
>>>  /* 32bit syscall emulation */
>>>  #define __COBALT_COMPAT_BIT	0x1
>>>  /* 32bit syscall emulation - extended form */
>>> diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
>>> index dbaabbc5d..38b59e24f 100644
>>> --- a/kernel/cobalt/posix/clock.h
>>> +++ b/kernel/cobalt/posix/clock.h
>>> @@ -68,12 +68,12 @@ static inline xnticks_t tv2ns(const struct __kernel_old_timeval *tv)
>>>  	return nsecs;
>>>  }
>>>  
>>> -static inline void ticks2tv(struct __kernel_old_timeval *tv, xnticks_t ticks)
>>> +static inline void ticks2ts64(struct timespec64 *ts, xnticks_t ticks)
>>>  {
>>>  	unsigned long nsecs;
>>>  
>>> -	tv->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
>>> -	tv->tv_usec = nsecs / 1000;
>>> +	ts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
>>> +	ts->tv_nsec = nsecs;
>>>  }
>>>  
>>>  static inline xnticks_t clock_get_ticks(clockid_t clock_id)
>>> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
>>> index 45ec09fae..8d408cc90 100644
>>> --- a/kernel/cobalt/posix/io.c
>>> +++ b/kernel/cobalt/posix/io.c
>>> @@ -221,7 +221,7 @@ static int __cobalt_select_bind_all(struct xnselector *selector,
>>>  }
>>>  
>>>  int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>> -		    void __user *u_xfds, void __user *u_tv, bool compat)
>>> +		    void __user *u_xfds, struct timespec64 *to, bool compat)
>>>  {
>>>  	void __user *ufd_sets[XNSELECT_MAX_TYPES] = {
>>>  		[XNSELECT_READ] = u_rfds,
>>> @@ -237,13 +237,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>>  	xntmode_t mode = XN_RELATIVE;
>>>  	struct xnselector *selector;
>>>  	struct xnthread *curr;
>>> -	struct __kernel_old_timeval tv;
>>>  	size_t fds_size;
>>>  	int i, err;
>>>  
>>>  	curr = xnthread_current();
>>>  
>>> -	if (u_tv) {
>>> +	if (to) {
>>>  		if (xnthread_test_localinfo(curr, XNSYSRST)) {
>>>  			xnthread_clear_localinfo(curr, XNSYSRST);
>>>  
>>> @@ -255,23 +254,11 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>>  				goto out;
>>>  			}
>>>  		} else {
>>> -#ifdef CONFIG_XENO_ARCH_SYS3264
>>> -			if (compat) {
>>> -				if (sys32_get_timeval(&tv, u_tv))
>>> -					return -EFAULT;
>>> -			} else
>>> -#endif
>>> -			{
>>> -				if (!access_ok(u_tv, sizeof(tv))
>>> -				    || cobalt_copy_from_user(&tv, u_tv,
>>> -							     sizeof(tv)))
>>> -					return -EFAULT;
>>> -			}
>>>  
>>> -			if (tv.tv_usec >= 1000000)
>>> +			if (!timespec64_valid(to))
>>>  				return -EINVAL;
>>>  
>>> -			timeout = clock_get_ticks(CLOCK_MONOTONIC) + tv2ns(&tv);
>>> +			timeout = clock_get_ticks(CLOCK_MONOTONIC) + ts2ns(to);
>>>  		}
>>>  
>>>  		mode = XN_ABSOLUTE;
>>> @@ -343,23 +330,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>>  	}
>>>  
>>>  out:
>>> -	if (u_tv && (err > 0 || err == -EINTR)) {
>>> +	if (to && (err > 0 || err == -EINTR)) {
>>>  		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
>>>  		if (diff > 0)
>>> -			ticks2tv(&tv, diff);
>>> +			ticks2ts64(to, diff);
>>>  		else
>>> -			tv.tv_sec = tv.tv_usec = 0;
>>> -
>>> -#ifdef CONFIG_XENO_ARCH_SYS3264
>>> -		if (compat) {
>>> -			if (sys32_put_timeval(u_tv, &tv))
>>> -				return -EFAULT;
>>> -		} else
>>> -#endif
>>> -		{
>>> -			if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
>>> -				return -EFAULT;
>>> -		}
>>> +			to->tv_sec = to->tv_nsec = 0;
>>>  	}
>>>  
>>>  	if (err >= 0)
>>> @@ -390,5 +366,25 @@ COBALT_SYSCALL(select, primary,
>>>  		fd_set __user *u_xfds,
>>>  		struct __kernel_old_timeval __user *u_tv))
>>>  {
>>> -	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, false);
>>> +	struct timespec64 ts64, *to = NULL;
>>> +	struct __kernel_old_timeval tv;
>>> +	int ret;
>>> +
>>> +	if (u_tv && (!access_ok(u_tv, sizeof(tv)) ||
>>> +		     cobalt_copy_from_user(&tv, u_tv, sizeof(tv))))
>>> +		return -EFAULT;
>>> +
>>> +	if (u_tv) {
>>> +		ts64 = cobalt_timeval_to_timespec64(&tv);
>>> +		to = &ts64;
>>> +	}
>>> +
>>> +	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
>>> +
>>> +	if (u_tv) {
>>> +		tv = cobalt_timespec64_to_timeval(to);
>>> +		cobalt_copy_to_user(u_tv, &tv, sizeof(tv)); // errors ignored
>>
>> This helps in case ret was already non-zero. But if it wasn't, we are
>> now missing an error.
> 
> ret > 0 is the success case (number of file descriptors changed), ret <
> 0 the error case, ret == 0 the "timeout occured" case. Error handling

I should have written ret < 0 here, right.

> is exactly the same compared to Linux. cobalt_copy_to_user() should
> succeed anyway, that is already covered by the access_ok() check above.
> 

access_ok was run and probably also a read access, but writing here may
still fail.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

