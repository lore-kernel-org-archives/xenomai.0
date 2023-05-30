Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21E12B9C
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 09:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvA/UlIwKFiXo6hvmZX0Nn6FVbPnSDQg9zutb5JgQC0MP3XtDD+YXfcVglDeM3uFsc2kEyNmjNa+qOKXH2lISfXorQNs5aMb4N5zZPjHBKFNUx8l9GM27LBjyLKFrGoiSMgUI8ZAmhHCMQo6iAbn8g9BECWOV0Sz2X4xG7sKFkLfNzMyaImV5FlH6j5KciTfI0SwON42N5OhiiHi6a0Z0RoHmTOlI9TopP/W5wPoGy0IaagirWz6d54xvEln1g0dH/uSw7CEgyVZN/UjcHdM4lmZv7BlAY70F/67iIH6tzWdkx5dJ1RNXUxcLSd2nKgE9YWZxAYpspEx7lF/J2UVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg0jA5HWsJUlALUMafQyM5muY7b04tiM+LkM9q/Rnoc=;
 b=PS/45SXj2sZ72RLDsJ49q16ivnj3pdwxqArRgy6YfnAwrVH2QAQ5WrPGfQAi7f/tkYa28P0A2M7Hkg/+gWXBO4hXogTZUhOFVqFo/w0dH2lS+J6adKHziPEBopA9P002aRcpDPM+El9sEgklcp3KlfD8JVixuD+kIBYxcZTQIa0I4ouJrSEB8MfymUvwjQ12ZXOsvusLPVHJbaK8tisxKls24x8qdg6Yhshyabbis9lMgXE7cwPCOSZ8GxNuwosrxPrV4H2ksvGF7bppcGiOJfBrZsc5/80uzhJoe4FXgGn1qIKGDFPtD8aXqj/Ygj/frzcNZtMpe0ekjDuJU9oNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg0jA5HWsJUlALUMafQyM5muY7b04tiM+LkM9q/Rnoc=;
 b=S7pZ/qz/gnok0VUyn9q7PwMmgrLmI4/+Zno0r1kyPRgZgfHNqozVbaGYtf1/BJyv1E4LwEre0ug1ZwJJ+4w+UJ4j9vBOx7bK+z5riMcxL4ZzzNEzOk64//e5Gqw6gEOW6guGM5JPKcv9P8TtwxGEOJU19wZfifbGMs+dkAsbEK885hPqANbueisM//DxvSlDFzoNqq/dEsq515F102mEzk8XEDFycvPi1X1XLZgpV0V6XNvHLy2UN0yCqhL5eTtC4pvRjJ9IUcPCp+cR3CoS23RmL3XJuTqVCaRXskZiDxjX3r7gihQ0W90hjBF1nORCQ0hbjYCRz7gfKQNBJTlhOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:32:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:32:05 +0000
Message-ID: <37c81316-1496-9742-1a6e-999ac3eb3c44@siemens.com>
Date: Tue, 30 May 2023 11:32:03 +0200
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
 <61004f9c-6d5c-6cf9-1b94-d6053f90d9c8@siemens.com>
 <a7499de6f30946b8b87cc3f3a65070ecef81a15c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a7499de6f30946b8b87cc3f3a65070ecef81a15c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 9180b2a3-4fbc-4843-fd1f-08db60f0bb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	foeY90HAsnbbo6aYvSlExnzABfuIYYOfMYwZq08EvY6qMy2voVVcfSdpE1UugOxAYOxJ+ZlYwkf+0WYQg5GegpNYErQIUGeBFgi+LYS9W6xXHuAl+KvRhXrUjQ7+ZCVQsr6EaphOApNi8xsybp5fgJ5suT3qbZ+3BHAVTwl6TDrZK2QeGrmJavP8W28M1hNDOHnQT2pTj4phNML1dpn1ArlDdlzzhUDEJII2bcaBlWcuWWHLC47uH/S07JeJVTmGgtU076HyUFU78rJZpykWePxEK6q/1nko8wl8/yaYxY42cZGflfjA2JUADA6NHPd98HREO/2lX8MBsY5uWpRbg+K+M806h6lhBxxjUEfZUCaGDtX8EQM99AS/rK51hXEkVpwOl/dX/wqqmEfCaQfBPclSAPkPZQaF5y9ylUoqxlGVv9aeJoPRCYnn/A3vJ2S61NWPoxBXNLkwCvTtjTz2JA0DXzBHwbMX6aTeuxU6rgbiyIDGf+EbIYP2H5dS49cGYgAA/x0y5+qulif38iFXOrgBhlPFewrttRT70Wxnt5p2nVE5VnwYdcn3NydBd8FQtTXzGly5iJmD7Bjp+UQueJhibSzRdgRgxq8E2JWLhCM0aF9duDRTaRT9yU9YCmUWefBG+1rZuH1c4V2K29IdQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(8936002)(5660300002)(8676002)(44832011)(36756003)(2906002)(86362001)(31696002)(66476007)(82960400001)(66946007)(66556008)(316002)(38100700002)(41300700001)(2616005)(186003)(6506007)(6512007)(53546011)(26005)(6486002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3d3UDV2UlIrT3VxS1VOVWxlWXRDZXJxWkhRd242OC9SQm14OS9LZThwbjhv?=
 =?utf-8?B?bXVTZkhzRlBWakJvMU1RcVozQm54NEFWUGcwTjVhaEdRU1VmTmFSSU4yZDBN?=
 =?utf-8?B?M3NxallEejJHNGtpaFM0UVR3NXZaTzJQbHBheHJrcEVSTHFvdE9RM2JkeS96?=
 =?utf-8?B?MmNlWXNSVUQ5bXBYU0JzbmhWdGI4aUFod1VDVGxydVpsUzNuaTRvd0Jad2VG?=
 =?utf-8?B?SHJsVmw4M1EvZFNSci9UMVNJVFFGeUtPWXR1TmpQQ2wwQ1AzcXVndEsvVlE0?=
 =?utf-8?B?RTR6cEREVEZFK3owSFdXcnhjTGZONVF5TSt0OTRSTVRqRnlXOEFyZ0ZteHZ5?=
 =?utf-8?B?MWVMNUw1R3FDMWt6MS9NWGxFbjVZVUoySEFlU3NKMjRDNlNQS3NaK2plQmRv?=
 =?utf-8?B?b2JidHdEYlpiZGREcUFHbGhjbVFLM1JobFJDRVhZSEhkSHM5emdhL1pnTVph?=
 =?utf-8?B?MmtBaDQxSjlSY3RxODh6MTRiK1MxMnZ4Y2phMFh5S1dGdzlFTWJZY3NvajFY?=
 =?utf-8?B?K0dwZmFBOGgrelVNdWRjWFBkR25WWEVhMHUzZEd3djR1RmVaczd5emxnWjhh?=
 =?utf-8?B?cXhXd1hyZ2dVdXA0cjdSR0JUK3pWYWw5S2hJRFc5b2x5RzRwQXcyWG5ncURI?=
 =?utf-8?B?SHZPT2xRalo2MlFTNU1MWGRUY0oxZDh1b0NOTkF3VzR3RjNOQWZmTUE1TW5K?=
 =?utf-8?B?K3luMnZWckV2Q2R3NkFNNzB4Z0FoQzVzNVJZRGxMNW9uOVRUMzNhWURpb1JV?=
 =?utf-8?B?M1dxRW9sS2l6dWpZcEpyUzhEdlFvNW44cDVkK1NqM2VuVUVwOUV4NVpOVzAr?=
 =?utf-8?B?NWVlRVF6dTRCQXFIcHpkNEhnUHFRbmkzSHU2d0dpUnA1QkdXM1g1cGhYQzE4?=
 =?utf-8?B?Wkp2RGc1bGdNdzgreENJVDQ4U25FYit4aUUwRk5hMmxXR0t5dGxXcnVJQUNq?=
 =?utf-8?B?VVo2RWduL0tnam16TmdqUmVleDdrbzVVVHU1YzNlWkFGaGRZZ0d0a0NjaUtY?=
 =?utf-8?B?Qkl0WTlVSU1sc2xGWkQ0Y1NITjlPV3BaSG9pamtqSTQ2Q3Mwd2VqNS9RTzU2?=
 =?utf-8?B?STRYWFZYYWlSQ0ZtUHh1OHovS3pBN25qdmVLYmVRZVRSQ2lNVG91Z2N0eWVD?=
 =?utf-8?B?bjFCZ0RQZGV2U0NBdExYcmZBS2plQURoaUY4K3lxa1lrYnQ1TzNYSEQxclBt?=
 =?utf-8?B?OFFRU0M1MkthMmw5L01iRjFrUWFrOXltdENKY3ZsSXRJV2duZ3V6dnFpRHlB?=
 =?utf-8?B?dlVZbElYNFVPZHppb2U5VjhydlFKMXpjdURuWmFtOVlsOVdER1RwWFlxaVRv?=
 =?utf-8?B?VHhXSlc4MjhIQzBWdlM3OVc3cWRIdGF0WmhSZy9sN0x2bS85ejBWcVlHRm9y?=
 =?utf-8?B?Nk04dGJGVUpVMlBBVFMwOTRuL2JnMHBlTlJtL2s2MTlabmVEMFJXaU1MUElK?=
 =?utf-8?B?UDhxeFVkenFRZEJvZnB0Yk1oMjdDZ1NtVElZejBQcmJ1ek1JbGhrS1VGQ1Vp?=
 =?utf-8?B?Z1JGQXBBOUJLcDJscnZUSDBSMm9LUFNhMlp5ZVFIc3luSXAra2dQM1pVWWFm?=
 =?utf-8?B?QXN2cDNmMVZ5U3ZSVlpLald3aVlZa1JmR3pvWGtMOFhrR0JFNkNZakF2Yk4z?=
 =?utf-8?B?ZTZtaUdET1hKL054THhUaVM1d2w3WkIrYmZqNkM2UXRoQk9FK3dISGhyL0E0?=
 =?utf-8?B?d1c5RGV2THBYYVEvcU5EWWZ6bWtuSjJKS1FsaTZudzJKMUQ4Ky93V0cwN0NE?=
 =?utf-8?B?d0NXd1JHTXBuVHJITXcyWm1oRXRtZGE3SzN5Rm5neDVCTkg2Mk9WSkEzd25I?=
 =?utf-8?B?bGtuL1RXdkZoekc3SVRVZjY5WGxyN1RMUG1Ma2pmUE8yUGpydXoyU0pScDhx?=
 =?utf-8?B?bXcyWFplaUlYYlhZUUM1WVh3VitoTVBXTWdHL3k5ZUJLNXdjemtNeWVvMDdY?=
 =?utf-8?B?ZFJFRHoyd213OUYrWWVLN2NmZm0rUUNoWndYckdldWJoZ1MwMWdGVHdybUJK?=
 =?utf-8?B?T1VEbFZQRjhXMFB6bDVJTDU0REhNN0tlaDd5b0Q1ZlUyY24rbGRWcm5VSVhu?=
 =?utf-8?B?d2tPYVFtY2ZWMWp5RHk5MUIrQVJYTGsycEVNa2t1N0lrWUxuZTZCc2dQZklK?=
 =?utf-8?B?TmNnb1FqeWlMVTZvY21hZXpxeVdoVm03YTdjN3ptMnhtYlNLQ25PdGFobXZa?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9180b2a3-4fbc-4843-fd1f-08db60f0bb84
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:32:05.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7LD8uq3Z1E0zwJ4uLDLVhH0x2+BrT2+LvXNf+fbucbKjEGi175b9J03SLP+6uIX7qxtwwg5k3cw9PCyDOZ7qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7101

On 30.05.23 11:19, Florian Bezdeka wrote:
> On Tue, 2023-05-30 at 11:16 +0200, Jan Kiszka wrote:
>> On 30.05.23 11:01, Florian Bezdeka wrote:
>>> On Mon, 2023-05-29 at 13:11 +0200, Jan Kiszka wrote:
>>>> On 26.05.23 07:35, Florian Bezdeka wrote:
>>>>> There is no y2038 safe select() syscall provided by Linuy. If y2038
>>>>> safety is required the application should not use select() and move on
>>>>> to something like pselect().
>>>>>
>>>>> As we still want to support select() for keeping backward compatibility
>>>>> - even if y2038 safety is requested - an additional pselect() based
>>>>> entry will be introduced soon which will re-use __cobalt_select().
>>>>>
>>>>> This patch moves all the timeout related userspace copy operations out
>>>>> of __cobalt_select() and migrates __cobalt_select() to
>>>>> struct timespec64. That will allow pselect64() to be based on
>>>>> __cobalt_select() as well.
>>>>>
>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>> ---
>>>>>  .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 ++++++++
>>>>>  kernel/cobalt/posix/clock.h                        |  6 +--
>>>>>  kernel/cobalt/posix/io.c                           | 60 ++++++++++------------
>>>>>  kernel/cobalt/posix/syscall32.c                    | 22 +++++++-
>>>>>  4 files changed, 74 insertions(+), 36 deletions(-)
>>>>>
>>>>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>>>>> index 70b3e68f9..d61b985fb 100644
>>>>> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>>>>> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>>>>> @@ -138,6 +138,28 @@ static inline int cobalt_put_u_itimerspec(
>>>>>  	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
>>>>>  }
>>>>>  
>>>>> +static inline struct timespec64
>>>>> +cobalt_timeval_to_timespec64(const struct __kernel_old_timeval *src)
>>>>> +{
>>>>> +	struct timespec64 ts;
>>>>> +
>>>>> +	ts.tv_sec = src->tv_sec + (src->tv_usec / USEC_PER_SEC);
>>>>> +	ts.tv_nsec = (src->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
>>>>> +
>>>>> +	return ts;
>>>>> +}
>>>>> +
>>>>> +static inline struct __kernel_old_timeval
>>>>> +cobalt_timespec64_to_timeval(const struct timespec64 *src)
>>>>> +{
>>>>> +	struct __kernel_old_timeval tv;
>>>>> +
>>>>> +	tv.tv_sec = src->tv_sec + (src->tv_nsec / NSEC_PER_SEC);
>>>>> +	tv.tv_usec = (src->tv_nsec % NSEC_PER_SEC) / NSEC_PER_USEC;
>>>>> +
>>>>> +	return tv;
>>>>> +}
>>>>> +
>>>>>  /* 32bit syscall emulation */
>>>>>  #define __COBALT_COMPAT_BIT	0x1
>>>>>  /* 32bit syscall emulation - extended form */
>>>>> diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
>>>>> index dbaabbc5d..38b59e24f 100644
>>>>> --- a/kernel/cobalt/posix/clock.h
>>>>> +++ b/kernel/cobalt/posix/clock.h
>>>>> @@ -68,12 +68,12 @@ static inline xnticks_t tv2ns(const struct __kernel_old_timeval *tv)
>>>>>  	return nsecs;
>>>>>  }
>>>>>  
>>>>> -static inline void ticks2tv(struct __kernel_old_timeval *tv, xnticks_t ticks)
>>>>> +static inline void ticks2ts64(struct timespec64 *ts, xnticks_t ticks)
>>>>>  {
>>>>>  	unsigned long nsecs;
>>>>>  
>>>>> -	tv->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
>>>>> -	tv->tv_usec = nsecs / 1000;
>>>>> +	ts->tv_sec = xnclock_divrem_billion(ticks, &nsecs);
>>>>> +	ts->tv_nsec = nsecs;
>>>>>  }
>>>>>  
>>>>>  static inline xnticks_t clock_get_ticks(clockid_t clock_id)
>>>>> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
>>>>> index 45ec09fae..8d408cc90 100644
>>>>> --- a/kernel/cobalt/posix/io.c
>>>>> +++ b/kernel/cobalt/posix/io.c
>>>>> @@ -221,7 +221,7 @@ static int __cobalt_select_bind_all(struct xnselector *selector,
>>>>>  }
>>>>>  
>>>>>  int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>>>> -		    void __user *u_xfds, void __user *u_tv, bool compat)
>>>>> +		    void __user *u_xfds, struct timespec64 *to, bool compat)
>>>>>  {
>>>>>  	void __user *ufd_sets[XNSELECT_MAX_TYPES] = {
>>>>>  		[XNSELECT_READ] = u_rfds,
>>>>> @@ -237,13 +237,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>>>>  	xntmode_t mode = XN_RELATIVE;
>>>>>  	struct xnselector *selector;
>>>>>  	struct xnthread *curr;
>>>>> -	struct __kernel_old_timeval tv;
>>>>>  	size_t fds_size;
>>>>>  	int i, err;
>>>>>  
>>>>>  	curr = xnthread_current();
>>>>>  
>>>>> -	if (u_tv) {
>>>>> +	if (to) {
>>>>>  		if (xnthread_test_localinfo(curr, XNSYSRST)) {
>>>>>  			xnthread_clear_localinfo(curr, XNSYSRST);
>>>>>  
>>>>> @@ -255,23 +254,11 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>>>>  				goto out;
>>>>>  			}
>>>>>  		} else {
>>>>> -#ifdef CONFIG_XENO_ARCH_SYS3264
>>>>> -			if (compat) {
>>>>> -				if (sys32_get_timeval(&tv, u_tv))
>>>>> -					return -EFAULT;
>>>>> -			} else
>>>>> -#endif
>>>>> -			{
>>>>> -				if (!access_ok(u_tv, sizeof(tv))
>>>>> -				    || cobalt_copy_from_user(&tv, u_tv,
>>>>> -							     sizeof(tv)))
>>>>> -					return -EFAULT;
>>>>> -			}
>>>>>  
>>>>> -			if (tv.tv_usec >= 1000000)
>>>>> +			if (!timespec64_valid(to))
>>>>>  				return -EINVAL;
>>>>>  
>>>>> -			timeout = clock_get_ticks(CLOCK_MONOTONIC) + tv2ns(&tv);
>>>>> +			timeout = clock_get_ticks(CLOCK_MONOTONIC) + ts2ns(to);
>>>>>  		}
>>>>>  
>>>>>  		mode = XN_ABSOLUTE;
>>>>> @@ -343,23 +330,12 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
>>>>>  	}
>>>>>  
>>>>>  out:
>>>>> -	if (u_tv && (err > 0 || err == -EINTR)) {
>>>>> +	if (to && (err > 0 || err == -EINTR)) {
>>>>>  		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
>>>>>  		if (diff > 0)
>>>>> -			ticks2tv(&tv, diff);
>>>>> +			ticks2ts64(to, diff);
>>>>>  		else
>>>>> -			tv.tv_sec = tv.tv_usec = 0;
>>>>> -
>>>>> -#ifdef CONFIG_XENO_ARCH_SYS3264
>>>>> -		if (compat) {
>>>>> -			if (sys32_put_timeval(u_tv, &tv))
>>>>> -				return -EFAULT;
>>>>> -		} else
>>>>> -#endif
>>>>> -		{
>>>>> -			if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
>>>>> -				return -EFAULT;
>>>>> -		}
>>>>> +			to->tv_sec = to->tv_nsec = 0;
>>>>>  	}
>>>>>  
>>>>>  	if (err >= 0)
>>>>> @@ -390,5 +366,25 @@ COBALT_SYSCALL(select, primary,
>>>>>  		fd_set __user *u_xfds,
>>>>>  		struct __kernel_old_timeval __user *u_tv))
>>>>>  {
>>>>> -	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, false);
>>>>> +	struct timespec64 ts64, *to = NULL;
>>>>> +	struct __kernel_old_timeval tv;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (u_tv && (!access_ok(u_tv, sizeof(tv)) ||
>>>>> +		     cobalt_copy_from_user(&tv, u_tv, sizeof(tv))))
>>>>> +		return -EFAULT;
>>>>> +
>>>>> +	if (u_tv) {
>>>>> +		ts64 = cobalt_timeval_to_timespec64(&tv);
>>>>> +		to = &ts64;
>>>>> +	}
>>>>> +
>>>>> +	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
>>>>> +
>>>>> +	if (u_tv) {
>>>>> +		tv = cobalt_timespec64_to_timeval(to);
>>>>> +		cobalt_copy_to_user(u_tv, &tv, sizeof(tv)); // errors ignored
>>>>
>>>> This helps in case ret was already non-zero. But if it wasn't, we are
>>>> now missing an error.
>>>
>>> ret > 0 is the success case (number of file descriptors changed), ret <
>>> 0 the error case, ret == 0 the "timeout occured" case. Error handling
>>
>> I should have written ret < 0 here, right.
>>
>>> is exactly the same compared to Linux. cobalt_copy_to_user() should
>>> succeed anyway, that is already covered by the access_ok() check above.
>>>
>>
>> access_ok was run and probably also a read access, but writing here may
>> still fail.
> 
> We should have a helper for checking rw access... Let me check that.
> Might be an additional improvement.

You may only see the error when actually writing (what if userspace
mapped a page r/o?).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

