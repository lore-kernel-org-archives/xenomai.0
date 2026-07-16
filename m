Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D021CC44
	for <xenomai@lists.linux.dev>; Thu, 16 Jul 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182968; cv=fail; b=CVmEjlC60+8NKLwhY+r9PyaprNZ0Z2TEAK367lSepV3Xm+eM5O42UVts1Lh89C2a1iH6dPs5r4wPeWjZI79ECNifwEALkp5Eiy+HtuVvz87va0o5e9sYTLkiqGURzvQKuWNkotJjkx5g5weLUfAW0FuiUeYoMdpBca4QbkpKoIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182968; c=relaxed/simple;
	bh=4tOYplxgWUD4+lx2EM/errt8WtBNFalHmudKzSUh8UM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ruROD2N2ZLkNaKZwpPUffiRhYWTzG9NKqApQhezPVJdWNt5ccMATOmP2hAA5HK7E1RhH70IjDsdKJ3v+lWqcZG3zbYLNSA97kg37UA4mN3DECg9YTSmPWO2yD4yb86RDhrCH65WpRJ4c8/QCABqUZcS9MU2JJ2IQCnPiUVYO2iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=m328miV0; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="m328miV0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTPdUms7783RylgpylE67pVQV8Zj81oFlg8bkpn+ym5Wk8Xr3iqR7UJ11Gl0kiMrLiRX1QBxkZ4H6io6AT9VHD47FcYjqDeYslj/1P8G+TiHa1avVCbgBAk4enmehu3rauH/Xk//XYXLKHrYWDITgMNVDZT+1ZYvRyeV8RMr2YZGvuA40brYMeaCBdg94XLtTWbEFvuL9DuFpB6/wxgYqhnpILstPOzODT1FRLuFhuj8qi298a0HXvEXc4HXVNL6LFj6G/vCfRtxpY7JjLdp4dZHsfe7GpYeUt4hP7q6m5BzNe8obFE9izDyAXIvBn70+Ql+qxAPW0OClXknyeHpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGEWF7VcmZ06WAB4Z3xWepxhRnMwi1Bpr45l4NEWWEw=;
 b=eSShkoMKeKGvYXK5Hra266/w94Jg9ytq2906JFkS0JtCnEYTqvR8kS1o/NZB7wEC9Ikt6fY6Uo4LeIAFqUaQEtU1LInF0pF6NYsQVsriE4jXbBZpnrOpuPx1fY09REtBOWQGoG9YP5iV9y/BZ5n7cFp5cmyZ2Lk6NbSGD7sQf6JlMhHMZ+InKkXbjlpbDzuY1o2MXn9jD5MB3snXwusQEQzrykX8G+zuDWST+cIKrTgiVYjANtQiwqbRv056dvYg62IA/J1MHrvTWZ21YILvOK9wcWqyBJYAtMcevLiFCJZtVlkqtcz0p1VaTYe7dJ6QoSTUGCkXTo1SdsUJ8uPYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGEWF7VcmZ06WAB4Z3xWepxhRnMwi1Bpr45l4NEWWEw=;
 b=m328miV0jRqyvu4NzL9LTzWwrluzAz/WklyCxiXeGut15IaimPtMKlNIulVF7bzOFsU4TBsSEXyMiDOm9ZX+kK4ceIhQSfSu6qHWAfAYPsCuMtFz2Oh2n9hcS63hIiEkGqv8n994hn9a2eFR67r6pAs2VPcGXeIApx1nrMW6iRNP4XqTL/dQXxuz7i0s2rxt5xlrO1koi5Gu8e35pQBf07ngfamxqkM07/fGgQj9TMrfzuo5iMoNcqIWmfx2akMgc4ZNuQB2o3/zh3ofjI4Khyt9vYf+Xe79fDS5GJikxkdRuUAUvsYRfBKrE2dOLRdvg9ZAPYoQrc5zOFGNHmKn/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:22:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:22:43 +0000
Message-ID: <06fd27a8-8d59-47c3-9e1a-731c7f7f375d@siemens.com>
Date: Thu, 16 Jul 2026 08:22:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images 1/3] ci: use stress-ng to stress EVL tests
To: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
 <20260715092822.223712-2-tobias.schaffner@siemens.com>
 <ed278400f8b7ca4cf3ad1c653989f86db14d867d.camel@siemens.com>
 <8c44d8f7-25a3-4a9d-84fa-4b0c0fb82032@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8c44d8f7-25a3-4a9d-84fa-4b0c0fb82032@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 02536b6e-8f14-4419-b8a4-08dee302a53a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|55112099003|22082099003|4143699003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Xg9w1MJMr6iPGkS44M+WLmCoLuZhr5ssXwaTVixR8v+TSBfFciu3Hj/15pFLBb37NWvEimYYX9CyzMj756I/ZaDp4o2365q+qVW4eiysMqHGdBVRoG5nMhQi9HPSpzAToNd2WpqKHovaetVJNbvtq419DyMkAS7TBIYsh7a+nlbC3tKtzNLUUpuc2MpSuP6O7cRShjBumDZ/Nhgpnrggw0swI/uZ2XFoeamMJk86cEMxpzZkA+Nt+ciCn9bk976s+CrcpkTNPNY5Y5qxAwj2a8TAfjBXnYB4AGVnA/Vielhxjv5yfH0jWAEuoh/cBD7RSWrJ7hd2IGf/l0YKvUXe9idV+sndWmyVHmvDUh537NIOtZAeYTgyaq5rCdmlJ3/IHzddDyDwSn4QDqU0EJ1QUvQL9xsHddyAcLxXVkt8wBu8hHkR5luGX0MTtrRVYx80TNCiyy1gjUHSdymTXptP+Ge33YSSzFoOPhZLZPO0e1fKor/QaTuq35WHmpk0qFnNp58ibaL9kNoBgDXd5U5KcMW6hVGhRxePq7FmDKGkNsHywFt2fVMPZ/KN0uFH7/vcUU4xWmKuW0nplabzcRZmHsGJwEAdRgYt8ODAjNaxM5lJDuZLpgR0GnfOc5QhCcN6NIF65q5NegSu/QCDtKlrHP2i7rWhZnrsizFxFl1O3Ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(55112099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWNybnRHQkJnQVhVaEI2Z2dhOUZPczVkcnk2ekcyeGErV2plMGU5L3VQUHVO?=
 =?utf-8?B?U2hEaXFucjhLMWozOTZab0QvNEVXNGdicHlGQUloTzNkdnl5ZUczbDZuMTdm?=
 =?utf-8?B?YWgrR2FRd09hZDh3QzhIcjY5M3hQRXQybDNUeXpWWVE2cHg2eTdqclRZWnB5?=
 =?utf-8?B?dlJQMENtZ2lIL0IwT2R6b3JTaW12Q1VTR04rbWkrZUlCeDBHQlJCbFJtZXhR?=
 =?utf-8?B?c0NNeWlRaVpkMGM1cWVkWXp5TXRLRVBUZnJWZGg4RUtFNWNwT2Q2YURUK2hI?=
 =?utf-8?B?anZwcm9uRzRMOFphdVh5TXlXb2pvNS9xZ2lYc3ZXaFNvdTNCOUZCMkdHZ0dK?=
 =?utf-8?B?UGEvK0RrdUJEY1pSOXVZdGpqSk10WWhVNkdQcUR6ZU4vZEI1dVdZSE5OL2lt?=
 =?utf-8?B?bG1DMDFJVWVQTHR5ZVdCeWducG85RVBTZSs4SGpDdnNveW9HVWQ0T2o1QUxi?=
 =?utf-8?B?dyt5d0k4RGtabjNaZ1hZVm9WWDR6cnJsRnA1RG13YmRIb2hxdExXVXFQSmlq?=
 =?utf-8?B?QzR5WlR4TC9UQXluN2lNbzRZREJGNlZCOUxXdWFSRmNzdG5tcEx3MnRGK1lG?=
 =?utf-8?B?cHIwdWgvd0dKVjNVaHh3QWNodUllY3V0M202RzBpZ3daY1NZOVVRN0VFeXVh?=
 =?utf-8?B?SjhIamJ6ZDFNTG8xdk91T3dQdHlDRTl3UzJVQXZiZHZaRit1MWlrL3V5MzRT?=
 =?utf-8?B?R1Y1eEp1OE5zZDdvdm45QWNsYVJxZGxSRmkzWVpsVnFTZ2FUY0hROWpCTkdx?=
 =?utf-8?B?TUJTMkZDM2J4OW9DRnRHcWdPbGZEZW5ydE0xSkdmZ0JQREVnTWNIZnJmUk1k?=
 =?utf-8?B?OVhFZ2NPWEt1bTZWQTBaMERYbnFkUS9NOFZuYjdaNDVoM1R2aWZYdk9MQ1ZS?=
 =?utf-8?B?S1MxNTNscGRoME1mNWV1Q2FDWDRsQTd3TkFiQllWaURuZSsxT3dpVnI4dGFU?=
 =?utf-8?B?RTdPVWtxdXIrdm9aUTBjVnIvOTJHRXB1SkRHZTVtSkxVTjVTTDFEUVF0NEdV?=
 =?utf-8?B?cUNXVGkxYlpTME94WWgvb21aQTkzSjRkTk1SOS9hK2p2aGl3VklGTnk3Tm9l?=
 =?utf-8?B?QjZ5ckxHcEhZbFM2eWZyMmlPMjBXVE5GVUt3Y05BUUtIa1RROGg4MUYrVWo2?=
 =?utf-8?B?cWdqbmU4a1I1R3NpWWxFWXNpQzlwUW1lNmt1L2xLNXFHWFJxK1hTcHJaRFRv?=
 =?utf-8?B?REFCUjBZMWFIYXdpRU9peVBhQW5XalpNSmY3RHJWVWNwSnoxZmxFcE90bDll?=
 =?utf-8?B?RjNVdEg1KzZpeHR0Z1EySWVlSVBXRXcyamUrY1dlUTJ0ek9YTUYyYTNDWUYz?=
 =?utf-8?B?YUMxMHJ1WEJlcld6aWJONWMzQnozRklud0NwQmhSOGlIWmR0QXJweHNSNk9F?=
 =?utf-8?B?ZTNDQ1ZSQ24zOHpxMmNmaUZYT1MxSllNTnFOT3dZaDRRUWpKcTkrVGVaY25X?=
 =?utf-8?B?QUpSa3h0aTF4cXcxdVpCOGtIK3RHWEJnajBvMU1NZWRhcU9yTk1RWmRJQW5o?=
 =?utf-8?B?VUxaQnBKdzdaSU1BdFg5VFhFRlcwczNMb2Y0UlRBOUpLNW4yM2RHRlVaL1Jq?=
 =?utf-8?B?bi9ZbXJWenNFM2NBbXBmNFV6N1BwS1FISjliSXBnRGZrZ1NRZWhvT1FJOVNI?=
 =?utf-8?B?RWpaSm9kcFdOaVhIMXc0WHBwN2xTV1JwQnpIODNvNnc2MXNWSGxQbklZQ0VE?=
 =?utf-8?B?Q2ZURlcvbnBNNnpSQ0xucjRmZjR5MlE3M3U0S2c1aUpsTjV4TVA4c05VdG5C?=
 =?utf-8?B?eWtReGxIMHZReWlVenlFTkpkN0UzSWpRSzRHVHlRMXV1TmhBWXRwaW5EN2Z1?=
 =?utf-8?B?dnVpUkh2RmQ1Z1ZkZ3ZsL0NRQUZ4NFZ5ajJaQWREUWsxbjVkQVkzYzRUM21h?=
 =?utf-8?B?M1QxZnJVaDVuVVliYmVLL3ZBc3ZIV2NsN3lzdmU4VCtQRDZ2L3pJc1F0dVVh?=
 =?utf-8?B?RE94V1RDWUNmZFl5Ukxxb1pnMFh1dk1HUUpEa1g3cFNWSXhqTjdUamZIRUN5?=
 =?utf-8?B?QzV0Nmc3RVFPOXROS2FQb283M1pSZFVqdEQ5NHphOWV1TEkwL3h0WmVSVHdQ?=
 =?utf-8?B?SC9aU2JGL2E3SUN1eTBDU0crVzhZRUU2cmFqVFMwNXNxcjl3NWs0RS9icTBp?=
 =?utf-8?B?a25JSkU4bllwTG5DSWJDU1EyaHdUTHNPNGhjQ1l2ekNjdzZpRGNDbEt0Mnlk?=
 =?utf-8?B?VUtnWktCejZNSlhkNkJKQS9rN0xpQm5xejIvUTBHR0o2MzB4d0pEcFdsWUtx?=
 =?utf-8?B?WFBpb0YrT1BtTXhucVFjSnVGU2VOQTJES3VpdnFuTHUrN0k0THlCa3U3NlRY?=
 =?utf-8?B?VXJ2M2d2cFNZbVNoNXRzUFAxMU5nSk5tNWpmc0djZHJrd1FMUDVXQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02536b6e-8f14-4419-b8a4-08dee302a53a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:22:43.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR5zO1r54HTzHM2Nb5TIHOYGlC9js8geHwmBlEz58inKdkrc57mG37aRhfgQS3lD4ZMt5mtKprogKz4Hbdw2CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8823

On 15.07.26 20:47, Tobias Schaffner wrote:
> Hi Florian,
> 
> On 7/15/26 15:00, Florian Bezdeka wrote:
>> On Wed, 2026-07-15 at 11:28 +0200, Tobias Schaffner wrote:
>>> Use stress-ng to apply CPU, virtual memory, FPU register, and procfs
>>> load
>>> during EVL tests, mimicking the stressors used in Xenomai 3.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>   ci/lib/gitlab-ci-base.yml | 2 ++
>>>   ci/xenomai_4_evl.yml      | 2 +-
>>>   ci/xenomai_4_next.yml     | 2 +-
>>>   kas/opt/ci.yaml           | 1 +
>>>   4 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
>>> index 0540628..a3359bb 100644
>>> --- a/ci/lib/gitlab-ci-base.yml
>>> +++ b/ci/lib/gitlab-ci-base.yml
>>> @@ -25,6 +25,8 @@ variables:
>>>     ADDITIONAL_TEST_TIMEOUT_MINUTES: 10
>>>     TEST_MAXIMUM_LATENCY: 0
>>>     TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp
>>> ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>>> +  EVL_STRESS_COMMAND: stress-ng --cpu 1 --vm 1 --vm-bytes 64M --fp 1
>>> --procfs 1
>>> +  EVL_TEST_COMMAND: evl test --stress-cmd "${EVL_STRESS_COMMAND}" -k
>>> $(evl test -l | grep -Ev "${EVL_TESTS_SKIP_PATTERN}")
>>>     SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>>>     SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/
>>> PATH;downloadfilename=PATH"
>>>     SSTATE_MAX_AGE: 14d
>>> diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
>>> index 283a1fd..c6a92b8 100644
>>> --- a/ci/xenomai_4_evl.yml
>>> +++ b/ci/xenomai_4_evl.yml
>>> @@ -29,4 +29,4 @@ variables:
>>>     XENOMAI_VERSION: "4-next"
>>>     BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>>     CACHE_KERNEL: evl
>>> -  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev
>>> \"${EVL_TESTS_SKIP_PATTERN}\")"
>>> +  TEST_COMMAND: "${EVL_TEST_COMMAND}"
>>> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
>>> index 6ef4b6a..7ecfbb5 100644
>>> --- a/ci/xenomai_4_next.yml
>>> +++ b/ci/xenomai_4_next.yml
>>> @@ -21,4 +21,4 @@ variables:
>>>     KERNEL_VERSION_WITH_QEMU: "head"
>>>     BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>>     CACHE_KERNEL: evl
>>> -  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev
>>> \"${EVL_TESTS_SKIP_PATTERN}\")"
>>> +  TEST_COMMAND: "${EVL_TEST_COMMAND}"
>>> diff --git a/kas/opt/ci.yaml b/kas/opt/ci.yaml
>>> index e1466a0..f9e4bb7 100644
>>> --- a/kas/opt/ci.yaml
>>> +++ b/kas/opt/ci.yaml
>>> @@ -20,6 +20,7 @@ local_conf_header:
>>>     xenomai-ci: |
>>>       ROOTFS_POSTPROCESS_COMMAND:remove =
>>> "image_postprocess_sshd_key_regen"
>>>       IMAGE_INSTALL += "customizations-ci"
>>> +    IMAGE_PREINSTALL += "stress-ng"
>>
>> Hm... As the CI configuration is now requesting stress-ng it seems right
>> that it is pre-installed by the CI image.
>>
>> OTOH I hate those loose dependencies. Maybe the (lib)evl test package
>> should pull it in instead? So that the dependency is handled at package
>> level. Someone else might like to install the test package and get all
>> dependencies accordingly.
>>
>> To solve that properly it might make sense to make stress-ng the default
>> stressor. That would allow the packaging to properly depend on it,
>> instead of only "suggest" stress-ng.
> 
> I see your point but the decision to not make it a dependency was
> intended.
> 
> First stress-ng is a debugging and evaluation tool and we do not want to
> have it installed in production most of the time.
> 
> Second there are indeed persons/projects that have specialized other
> loads. OSADL for example is using unix-bench in its realtime farm.
> 
> But most important this is a huge dependency. The large number of
> libs needed for all the implemented stressors adds up to a total of
> ~240MB. Imo that is to large for libevl which also targets embedded
> systems.

There is xenomai-testsuite on xenomai 3, and we have libevl-test here.
Both need a hard dependency on a stress backend in order to run their
measurement-based tests. If any of them supports multiple options, then
you model that instead ("stress-ng | unix-bench", e.g.).

None of that would bloat libevl, xenomai-runtime or whatever you use for
production.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
