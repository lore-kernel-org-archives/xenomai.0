Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE88659
	for <xenomai@lists.linux.dev>; Tue, 31 Jan 2023 07:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS9kfwKmx9qD13gK7YPnpseHDRrWmJTDsrAg+YvOHeIt/smSItq3VB4ShsUxvHZTukgu9EwvWsu7f2qXPlrdnkPIBzmOq9nVE4SL3UN710l7vgGf/xkD4ey9btFGO0KtPt+5fFIQJcltD0CDzz8VIh5POoFprB1scsQt12I/r5R+Ntr13mwv5VNXw+P5HX6k0fFRM8d6P74HTfPZ57JlzoJxkP5vuJiRFZiGaZJfHwwxUDxUuuT57po+BC5AaTdjghG14o39v6C5TPTNta+GIKp1aySKtAH4VvBbAbSdK6Wkrb5Kp1aIp3ipiyCO4i7TVSgwdkostkri5GmaCOSFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knQ/x2pCIBRlSCemXAWHHbeVtyixjt/t08EgxdJyKbE=;
 b=jHls2FR7Iz3whsFJxjgkaDBQnLtgLmYpDAACxa8+02Iy79TVCexrLgG4VHTcmPWfALOsvr3/DmRkZhVEjqbGa4I76aboNMYurv4e6bH49wCwKz6muUXL0YWiG8YsQDLTA+OaGc6Rx4FIKTpSbemytI5U45YSpINJFHtFEcElzC+cTMM/JSYar3N0hjaX2vVCIG9DLMtiiPXViDDSbOIj2lWYkadCLgb2gW6zN6drTzDvhUvSOHfcbp3c6jkpCfUaViskf5PR8MNwtA1fPzH84rfl/6nRrx9Sp0poCogzi/YaHBrtn0ARBA35PaLWN8nJX6O3jW/mUuYzhfjZ/lx9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knQ/x2pCIBRlSCemXAWHHbeVtyixjt/t08EgxdJyKbE=;
 b=Fq3ekDo9IC/NG245TFq5v7guv7zlVBOjWj6xWQ+Pjw81Pajosg47VBrYEL8RmSSPiayMbfLwp5BOvvr6fvlWS1l1+bMp/cVS7KsSadcg6IVA5f5Ds4rqNxblwdPQQ9zwLiiwoLNwlP+mH4/UJxTZfplZT/ayi3vKesG0dOvV+BNqRXfE4UeSLIxl8plGGPHmaoAg3AkEf4FFdkr1Ml3PyYXENfOdWAq89F8jOXmFZC7DaouQX8Uy1zfhw5k0EycoeSV00zaEgNH1P4VXiyPvcPWihNoHfoJMZ/tty/SVfWx2WFH3NTavbD7YRML87frCVg7iEJ/ko+HCeqFFT8tLrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3958.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 07:27:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 07:27:01 +0000
Message-ID: <32e8a845-7f5b-3e0e-db97-087e123a662f@siemens.com>
Date: Tue, 31 Jan 2023 08:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] testsuite: dpdk: Add l2fwd example which is based on
 DPDK.
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20230118130506.30418-1-hongzhan.chen@intel.com>
 <2893142d-70c7-eb2b-89ad-f2a7154f5eed@siemens.com>
 <BY5PR11MB427681AA9D23FEFA04E1748CF2D09@BY5PR11MB4276.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <BY5PR11MB427681AA9D23FEFA04E1748CF2D09@BY5PR11MB4276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3958:EE_
X-MS-Office365-Filtering-Correlation-Id: ea857e9c-d466-4cbc-016b-08db035c8b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xRagZcYz2MKW2/sYFbMRNxODI3Lbk9jTNCjyqmx0JCDoURRlGJk3ImWGVPUfWAV2BJ2HEMK2NlML9lWJfJ1O91DvCFz598O97z/gh0p2zwKZjRJW9jNlBemEBAa++xq0Xiqz6zi9Firqj36Rpe2tqRLxTA3zRug39ElHWEn0xcwGgdSQ5athsMhrU12/yu9FTbFK3jYEi3fN1+BZV23HplMNcm1zlWPdM6FMj9Fc0n7BJ7RcBMp9JPubWebsxsB5IsqofOHsUpQG9SGg/u2QROA9Zrj38UMHFZ5+BP5ywPJ7PqcQfJQ5R0r2QEm7cwEAer4vRxQ04n3e+OT0I0nBtrYvnno+x0rJGPfdVi00bCvr1VAc4LGBtX5m1KVlupfNmSmU2jm34kgh5I6sNBdvXAGlXizsYRve/ZedGZ0K1Lj3S/ZzW+i2LWAG6zHKqq8BbJvZs1vUfuyXK7aYZSoL5JwGqvGtkno3W7N191J2IPTtFg6fwNCTtHM1PFr/vRwRITb88rLpyFCY7xkB6T3EvANbCgZc7C+fJ5vU7jaLfgnBVqZcMjxs7zqGXEBU5SajwF1w0eE3LAYIngsOD0Haq6gfdYZyPW+xnFs3dLPWZOxY6/biQ+6VJ5Y5SntV1penWP9nOfN1Sh8V2aZSDYXIJAxO9Mu+0hnTnTC65UWsjC3BzjVDWJSreTzRrkIPKQZT8kFCo+CkzJ3Q8oggV484jzTLa7nF1y4LiJNaKF/iM3ReufSQJL80j6fHTJovLUrs8ZY6LIXt17633WOgjF3Npw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(478600001)(36756003)(8676002)(38100700002)(66476007)(66556008)(66946007)(6506007)(82960400001)(83380400001)(110136005)(316002)(6512007)(53546011)(186003)(6666004)(966005)(26005)(6486002)(5660300002)(41300700001)(44832011)(2616005)(86362001)(31696002)(8936002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzZkVjltbVdYWlhXcmV3YmxFQ0hiS0xkcHZyUVRzZkpUSjQ3c3N1UWpXTjVN?=
 =?utf-8?B?UmpiRVQ3RmhYZXJNK2JrcDlIaXBoVUx2QUhPMW1lR0xBaTNaYlZ0TU1GcXJL?=
 =?utf-8?B?WXlMalFxN2gwSXpBRTA2b1N4YUgwdjI5SlNsSGlSSDV0QnhTaEVPTGtiL091?=
 =?utf-8?B?dzFLL2tZY09jdkxCS3Uzcy9JRHdrUnFIZ0F0SEVXb1NhUG54cHcyd0tRa29S?=
 =?utf-8?B?MGxHc20yK0pCOEdlZkxGWnZkRkw3MFp2VXdxeHA2Nkt4NGhCeTlVOW1tNnVK?=
 =?utf-8?B?Y1N1OEZraXkvRjJ1ZWpLWHdJZjB4Q0hqZ3E0dEZvdUh4R2phWlh2UGhuMDJ2?=
 =?utf-8?B?cXdVUEtrWGdiSGZjNFZJWVVIYTlTa3VlT3NpemR4TVJRcGpRY1NNMzBBVU9t?=
 =?utf-8?B?UDBGZWRSRzRQVGxSR282ODZWTFdzNVlmWGx5dGVVM2VrQUhFL0MwY3RzSkdq?=
 =?utf-8?B?UlBtQnR1T054M0tJWisyUW1LK0lEYS95WFNOREM2bk1kY0M4TjYvVVBLM05z?=
 =?utf-8?B?N2pXK0VldnpickV0R2ltMjUzRGlMQURPRHJKM3RhNkVjeVVxK2FtUkQxT2oz?=
 =?utf-8?B?MU1xR2dvSWV3cjFkcUNpZURTQTRvSDNscHUxS1FuUWRsaldXbG5zK1N6cUk1?=
 =?utf-8?B?bThoVC9UM2xiMmk2Z1JMRlNkYVE0WFdCNTFOL2xqK3o1STMyZjJRWW85VkxF?=
 =?utf-8?B?ZlBKMGM5M1JpTVpSTWx5WlQzS0dPbTh4ZG1SUGdyaVNWN2pSOEUyNWQrR0ho?=
 =?utf-8?B?NjRZV0pVN0tQMkxWUnk1cjJEcGZwS1Yyc1NIUE5sNHNrc09PektEVTF5OEx5?=
 =?utf-8?B?Ykd0K2hXdUJWd0R3c0FzYWh5dzVrQVVZN1RHMWRUY0M2WXREbDdYWXFidVY4?=
 =?utf-8?B?cmd5S2VvdW9DYVVEZDl1aEE0dnl3bUE2U3JOeDVuQkdzRkQvNmk5N2lWRUNl?=
 =?utf-8?B?UDhnZWZzam9WWUtOUFFwYWl6Z0hqMXNWbFNDb1c5V2kzSWNtL25pTkx6YWd0?=
 =?utf-8?B?RjFxTE02ZFk0YkNqeTJteEg3Q2V2RHlwUitBTU5TczkvNzREOFNLd0txSVBK?=
 =?utf-8?B?aDNldzRYWUptVVo1ZUtPaHovN3d6Nkl4Y013SmFodVFIK1pCVk80SG9hOUhS?=
 =?utf-8?B?YnBDSjVoY0xjSFh5NHdETVVzL0pCc0F6MzVFOURRYndWL0E3VTN0bkp6ZWxp?=
 =?utf-8?B?QkZHbS9jVTFFb1RmSy9SV2RqT0JsVzRZeUlWcmVGbnQ4ZUtENFNEbmtNZUto?=
 =?utf-8?B?QzhaY0VMTXlZZUJ2c09aMThZVjBGMC82b3Z1cWRSOGpuUE9yYVkwMUJCQS95?=
 =?utf-8?B?alRsZTlCcituYmpiVEVjMkwzSi9zdFdISzVSbS9TSm83Zis4c21mMHNWSW1m?=
 =?utf-8?B?N3ZWNnRDd21NSkdGdGF1Sld2MWEzRXZBRkZCaG0vUmxCLzVma3YrQ3A0Ujda?=
 =?utf-8?B?Zjgra0xxVGZvL1dNVUdDQjB2aFJDeEZyK3g3bHNJTjgwWXZFUnVTNXVmcTdu?=
 =?utf-8?B?bDR0MEJGaHc4bjgxTWV2eFpVc2Q0QW5OQk9uWTY4WFE3eUZEZmh1dVEwQys1?=
 =?utf-8?B?Znd6am55cmgwaTlmcW1pd0h5UExPY2NVNjh5RGFuRjJnTWF6eHlOdmV2ZUYv?=
 =?utf-8?B?bEdDcWtCcFFGUGEvckNXWmg1L2p1WExmU2RmQUJ3bUVZd3lkdkVHaGZJWWNW?=
 =?utf-8?B?ak9iOTB1MkN3ZVV4WFpYWFpWS0taVHR4ZzRpNDZuNGhHcFZWQVJ1eWpidDIy?=
 =?utf-8?B?UjJ6c3VsKys3WGp0bW0rMFNrMlFTYWZRWDYyVHRhc2E3amR1OE5wZXByYThH?=
 =?utf-8?B?NTk3ZHZTZEdvb1RkY1UwMSszOHg0SFVyaGZtUWhZd0hJWHBjcS9lUjROZHVi?=
 =?utf-8?B?d21BWWpUdG9pNDVBTUdOcU1MT0VEL0dxemRqSm9TcHJjTWVoaW8vMXdyYjdi?=
 =?utf-8?B?aXdaYWJSelpOQmZJNnVnVE9xcmVzWXBXQ3h0V21kck9uMlAwcmpVOVBKMzZV?=
 =?utf-8?B?eU1lalVPOHZwREdGd0dqM0lzY0VnVTlOOG1SS1IrenlvcnJEc1pxSWVpMmtH?=
 =?utf-8?B?RVpPTjVLMTBOTVVCc2RLczFka1RlZHFFTWI2NitGWXVVVHpCZWo4TDVpUmNn?=
 =?utf-8?B?RHdlbHhkUGVQd2FLd0RYc0FkaVNacXVrdGx1d2JEWmNYUXlSVDNkZzJhclc1?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea857e9c-d466-4cbc-016b-08db035c8b36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 07:27:01.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPpumQ0bI54D2Xh/yGyJdgCCJnI8OXmV+osskTRyQe94tbGlK/IlQAJYpl5F4D2H26f8IWFkT4ppc4HaC50QQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3958

On 31.01.23 06:10, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Thursday, January 19, 2023 1:44 AM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@lists.linux.dev
>> Subject: Re: [PATCH] testsuite: dpdk: Add l2fwd example which is based on
>> DPDK.
>>
>> On 18.01.23 14:05, Hongzhan Chen wrote:
>>> The L2 Forwarding sample application(l2fwd) is a simple
>>> example of packet processing using the Data Plane
>>> Development Kit (DPDK).
>>
>> Can you elaborate a bit on the envisioned use cases here and go more
>> into details in the accompanied documentation? The latter only describes
>> the "how", not at all the "why" (or "which use cases"). Some words on
>> the threading model (or limitations of it) would surely be good as well
>> ("how can I integrate this pattern into a real application?").
>>
>> Regarding the patch itself, you should go over it again and eliminate
>> debugging left-overs as well as unrelated changes (there is one at least
>> in testsuite/Makefile.am). The way of the integration looks fine to me
>> in principle.
>>
>> BTW, what prevents the usage of the VFIO driver so far?
> 
> I have not looked into and tried VFIO driver so far. Last time you told me that we may need to
> develop or port VFIO related drivers if we want to use VFIO-based dpdk in Xenomai but UIO-based 
> does not such issue. I maybe misunderstood what you guided. If the main difference between uio and vfio is that vfio is capable of programming the platform's IOMMU as described in [1], after vfio init, there is no linux syscall involved during receiving and transmitting packets just as UIO case, we can do same thing for VFIO with ported l2fwd.

I haven't looked into VFIO myself, but the key question is whether some
userspace activity in the primary domain could trigger mapping activity
of the driver in the secondary one. If not, VFIO should be fine. If so,
and that was the case for some RTnet drivers, we would need to avoid
that. I was just wondering if you explored the path already and could
share your experience.

Jan

> 
> Regards
> 
> Hongzhan Chen
> 
> [1]: https://spdk.io/doc/userspace.html#:~:text=The%20primary%20difference%20between%20uio,User%20Space%20for%20full%20details.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

