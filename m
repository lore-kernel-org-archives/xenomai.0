Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD73F484D
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497093; cv=fail; b=p/+awtp3SU8VFfuI3l9qL6FvbMJuDJ95cjJYR6370/xisldxzgWVXK5+SwDQfCJMGIqJmR7BUUVZwLH5tFdL/VKrr118CBcm+9xy8A1OqAQqJIdw+Dc8YbDlkoVmYvQtK1vi37xqPDFJkSfcnHU5/PJiVqgeEBRFg0XR3w4pdSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497093; c=relaxed/simple;
	bh=QMF6dJT4caz8FTq3hk2HCdlafrKfXVdvP46wg2NcS5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jGvU5YYGA+3CnX5YbWj48hHnqjTIV+uHv6vs7lTrUTOo6Cz8GA61kYlJngu2pe+HRac2+xFrGGVWn+wkuve1ncCVbWGKR+t+PPfYmRX/cOG9PS+Bmt1633nOSuUAJkA64KMBeiKL0W7RFEV2QZjW8Ebev88QzJiIhl34oebr/kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fnibLIVj; arc=fail smtp.client-ip=52.101.69.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fnibLIVj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2HH4HeEwmRKFTpiQKsgokADqCrMbyBypISnJZzYa/TGvPjqL0Mf5avFKA7reNBUgxQEfwSqh9iNS4VdOffo9F3ROgUC7mXntRCZKZqYjg32ab4UTuYDcrX0tDUpeSR+82e/nNyLsSM6P+Uxy0KdEYnZp81Ehzsi6PW9z+2D/qDXtxsuOX0o3kynRlCor3f5PDbr3uL2vgIA8ju3EE8CnzFr6tOvDG/X4w8RwRp74z5uTmZ9wWB7OkeZ/1pnkYfoeIT+wcUQvn0OefKWqSoOYfKGAD4AHc3VO1Chy1zO7yW60HTTLOVbWCjgRJ99Zztd6I2by9TI1d6Jx0iwv4igJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytwQAkprqGm8T4yRXXVhzrMIZUQvt0H2A2LcTY/AvFw=;
 b=l65QpPnqs5OWqKHLsP6Vw55jmAjxF4907wpNFSWWvHDRMlrPprIHN4KQriU8LbTL0IYNjj+IHUqmrQtZ0CazwMoWj4BW0HGdGv4X853132XThBkvDHAq6r+kVQUrx1LJywAO+7WXo6rZs7LhzyY9Ak22MR4mmo/MW65dJJn+erpgvYEUt43maZTehxqzABz0sB1/NdgyMeUO3glZ3TAlNDVCVhYDXNHIQf+DlJipZU0nyR0dWve+LTcLaaGyE7HMpsGqtRIVhlEKKV7hHNyrGvUIJCUC3pWBB/2i8Lo+fvBbbQoD1Cip5UFNXMjnk2cdWg16RlrdA6eEMbYW3UBUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytwQAkprqGm8T4yRXXVhzrMIZUQvt0H2A2LcTY/AvFw=;
 b=fnibLIVj0pKrZAMl8jFcKD4qcQ9t1J47aylAk6KRJojxslbIzCLD5dqpa8wa6Gc8wZcyNQgrO/igHXxsUJM6il27g0Tdp2fUhehldGR7nwsXSg4BHzzq+d/apTA6YE1/mgjg+KgCLg/3drC6XaYI6k8oI3g18+6CaHOckqEWcn9TSNsr6lOrQKiobZuF9w/93qLPuFail4lUCxiWUIgAAsHmVNwlV6hp/KPMlMNEz6lEEQ5B/Su/CmqhwjoCEtSdB5oO6ZDTl8kwSZz0VBXI6CPK/DuTyOuYoaDdrcZzAZcV0RhpATc4QDHMqFi4VU9D9J7n7XHGstHPOC4UydAoIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB6393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:51:14 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:51:14 +0000
Message-ID: <901c6221-f432-4d90-9b13-95bda2e3fe79@siemens.com>
Date: Wed, 8 Jul 2026 09:51:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: do not skip tests on vm that have been
 relaxed
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
Cc: florian.bezdeka@siemens.com
References: <20260703114846.24710-1-tobias.schaffner@siemens.com>
 <f0b9873b-ce17-4cee-8ea0-4b0ec260e8f1@siemens.com>
 <88e281b1-54a6-41c7-9df4-61376a38c181@siemens.com>
 <e7debecd-2490-40e8-8223-4e076d39165f@siemens.com>
 <27d44aef-6dd8-4323-b24b-70f0770a9f49@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <27d44aef-6dd8-4323-b24b-70f0770a9f49@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: f48c1935-4ddf-4edd-4bd2-08dedcc5af63
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|56012099006|6133799003|4143699003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	mRosWo7rYhtTLdkSb/6YB2F8jCfYEV8uP25kScTH9Ecf6qzRP8E0aAwyp05QVW6k/KQ0K/DNAbZD/UqxVm3xA4rLWPncDINPGekRsZb0gNl+hoFEfM86DbX53mTA2JSxYEn/qoX0u0IjMXkaDiVJhGm4iWjs+Z1TNqR+iOkZJglCsv3qT4IAkPhsl1ijq66+8VItDFAib/keHHCigyq307TTSZzDASwYnOWMPgGVtKOk2SaWuF/GNa/iBhjXYkj4wjjj9OgdGpiZK7CcYAsNLwleit/7slORJTMVY/XrNHNEfoCQPl0taqcB9j4JnwfHArPqRwUalhsfw8xv+K56G0iRAubGN/OEDWprcnTjmIt5VvhXHJxcK0+ZAx+UsDW90mSXC3OfrRRdYd4zuV8urlmh+1uoeVRHT+ExQ0RUlt/GEmke2uH+7pHNa8DNy+8hN/eBAKP4qOml1xIjIf9iBGgUVeakd8ugRJ90fBkZTBYp/5IN9mzoFidFTm0mJY/pDhs32HIjDhK3YbeUun281Um3OsCLRQ6z4AmvqtY0CKeXOEpDS0SyON3jLNyQwY2lsTnXM6se9OX1RkObA2kclf3zkO1P8AaiKFcpVSZMm+6pPozt7GJ/0Qpc274CKc/Hw9F1aGeRpOtKtu3GmZdYwAd97j1mbXHBLN2tB4po8No=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(56012099006)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVNLcEtUSVdaTGlhT2c1YlNkMDFiQWZUKzE1Sjk1QUJ3WG84Qi9DVzBQVnJV?=
 =?utf-8?B?OHdKNUhiRmdZYS9MRDRKczUrZnplRnVCd3JhdUl6TjgwVk02YnRvaTJTL1B3?=
 =?utf-8?B?SEtMMzk0Y1dTeUd2VUg5eVhVQllGcnZMTEdEMTdJUEk1cldqOGRqb0xzUVQ5?=
 =?utf-8?B?d2w4QnZlYmFkaE9vRUwxTk5FN0xaREtCR3hVV01SbDQrUEV5eURONWM1MXVI?=
 =?utf-8?B?S0V3QXMyQ295cGUxdGpncTVSWCtGSkRMa0JBMWJpL3lzdGhKdXNSNDM3QWt3?=
 =?utf-8?B?QVFyTkJPczhXVktDQ3FxMWNiQnU0MW9SeE82MEo1VXArUjRyekdoNGRnVVln?=
 =?utf-8?B?Y2VXRVJ4d3hQNUZJOVBoNi9SSXlyQW8wNC8vanNBUW5BczJ4WlUrV0NWYlNM?=
 =?utf-8?B?ZTlIRUNtcFZMNzZwVG44WDFmdFFLU0ZsNTFqQysxUEFhQ2drTlpqbE9jdDA5?=
 =?utf-8?B?QnRNNFhqS2wvRDVUVDVqQXRJT1d3VEpvZVBJUlJyR1lPaXd0bmZWQ25CaG5U?=
 =?utf-8?B?QkRlaUk0Nm5URUFwVHZwTGg4eW5PMWoyL2VxNlNnblQ2UlpYUVFGay9xOXc1?=
 =?utf-8?B?OTZCK1Jud3RqdWMwWFE2b2ZYK0Nkbmc3djB5S09sNlpSQk1FNTVrYWN5cWp6?=
 =?utf-8?B?RXBpZG5TbDFDOUxoQ0NETXBRVGExMFVLRS9BUjk5RCsvWVpsZmZFK3hNWWNU?=
 =?utf-8?B?SHdZa1k0UE1SRStPZDBZWUZIYkVUK0diLzVmWStiZ1lXQnNVV0M2ekhsSFBL?=
 =?utf-8?B?R2lmc2ZrSERVK1lTVlNPOEVvZHpRZVd1N2dWNk5SZGNtVFVFcnYzQXFHUzU4?=
 =?utf-8?B?ODAzY1RHRkx6L0QvMG1QR2JGNHNUd0p2WFc5bDRvY1UxWnhxbWhaM1RQNHB5?=
 =?utf-8?B?MU1QWWFXaUxvWkdUQWJGOSt3aHRjNXlvSWl2bFRudklBeE9uNVV6N0JiamZW?=
 =?utf-8?B?dG1RT3Z6Sk01UW40WUplUXF4eGUzNDQwL1pGYUkxZHl0MGZBeG5qR3lkUDIx?=
 =?utf-8?B?eTBYY1Q1MHdaTjFVeWVGcVY3WjVYcGFhY3FSejVJeGZxMy9OeW04eXFUUitL?=
 =?utf-8?B?M2ZyOWpibmgrRFlHd2VMU0F1eklMYjFRWnZzNHExRldSdXpsTDBzV1BWdENC?=
 =?utf-8?B?Qi9EdFU1dThWYnVWUDUreGZJV2N2VlpKakUxMjRtWnFyckJBOXlHd0lXVk9y?=
 =?utf-8?B?S3V2TS91OGYvY2tJRGxzTnFZcEMyc0RWZlNXeE9tMHlYaSt1OUVWUkhHQ2NS?=
 =?utf-8?B?b3lvVVlPbVQ0UWFNS1ZBRmZWZ3M0SnFoU1VvK2FhNHpaMjYyRUxJTElpd1d1?=
 =?utf-8?B?S3BlbEFKOSt5Ly9zenU5K0lUSmJNcHhjd1hUS2xQWE9KY1kwUlM5N2ZENWFO?=
 =?utf-8?B?WElxaFpSdmxrRVU3ZDA0dWR4alpUWklaSW93UzA5cE9vSU5ybDJIWUc3d0dR?=
 =?utf-8?B?K1lzWm5FTVdyY0NPMkswL1ZKOThqWS9LbHd3L0Viek5JQ1NMRmFxYkhISFEv?=
 =?utf-8?B?enMxdWx1dHRsQWFmWkMySGVhQnR3QWNJS05oc0doU0xMbldRZ05iZHArL2N4?=
 =?utf-8?B?clMrMEpMcEtUWXcxa25OZHAxQlB5UUprS1h6YXg4QTd5ekRSdGVGRHpwTUow?=
 =?utf-8?B?cW9QcVcyR3ppdUZCQ3IvZjJlL2huSVA0NmN2c3FRenExNklwMGZoV2puWmk5?=
 =?utf-8?B?akE0NVZaRkltYjlvNUVZWXRLWEhYRFdPZVF0emNRdHhKSHM3clRUenhqSk1K?=
 =?utf-8?B?N1U5Szd5emFuNFhINHJOdEdBdXNzWDl2RTVHeGgrcmtTNG50M3U3U2lGSkpa?=
 =?utf-8?B?YWtrc0dVck5aanpYcXZKMkhVc0ZsMExSbVNvdDZCdkROVTQ2VXNNMk8wSkpi?=
 =?utf-8?B?b3cxaVNVZ3ZBUmJ6SWhNUS9ITk9lWmFlR2NmeDZ1aFBsMjRKYTNtLzRkdFFK?=
 =?utf-8?B?bTNVejRwLzlyaU5XVk5DU2x4VUxpREc3VDZWc3RlUlZvM2NGdnJiVCtkaWtq?=
 =?utf-8?B?TG1IT043NWc1Y0NkVm01bENqK0YvaW9xZG44S042enczVVFNRTY5blJqcDRQ?=
 =?utf-8?B?MGN3UWkxZzU0ZDVvVFdSTjREN3YxcURLdmJNa2dzdVRyMU9iK0hYaWdUSXlY?=
 =?utf-8?B?NkY2cnluajBnWU84c3NEaE45VlFyb0Q1RW13MUpQbnZpYXlnMEJmS0tuQWw5?=
 =?utf-8?B?UUx3L2g5R3JvRmZ2UXdUTUlvVkRTRVE0OWQrYzVPMERJSnAwdUwyRlJpcDB3?=
 =?utf-8?B?dytlLzg1ZjM0dFBvS0JvRVh6YUUyNWo1ZU51US9UeUkrSzFreE43YzBPQjZm?=
 =?utf-8?B?NVVvSUw4NGtMbDBwYlY2MEF5TmhiNmc2OE1HNGczZGtmQWRmdHUveXdkSjh3?=
 =?utf-8?Q?SxjX7hrJy/2uoIslkY4TVfKvXTP6Yf2Y9XNRg3dqREoeD?=
X-MS-Exchange-AntiSpam-MessageData-1: 5kndsr1fZWuxuqHDmv+wCqrZcz0frz0MT6o=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48c1935-4ddf-4edd-4bd2-08dedcc5af63
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:51:14.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnDS9BKftNBktbEkS4t14LfIhYYNSFoLlocVhvqdmYBoOCjrT6r83sBdVkbgz10TW44f7fUxGOCA4T6NizGe8ILKd+a6V/iprO/WwAAZKQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6393

Hi Philippe,

On 7/7/26 13:21, Jan Kiszka wrote:
> On 03.07.26 16:00, Tobias Schaffner wrote:
>>
>>
>> On 7/3/26 14:07, Jan Kiszka wrote:
>>> On 03.07.26 13:54, Tobias Schaffner wrote:
>>>> Hi all,
>>>>
>>>> in some of my test runs the sched-tp-overrun test was failing with:
>>>> 2026-06-23T17:25:44 ../tests/sched-tp-overrun.c:119: FAILED:
>>>> evl_read_observable(tfd, &nf, 1) (=Resource temporarily unavailable)
>>>> 2026-06-23T17:25:44 ** sched-tp-overrun: BROKEN
>>>>
>>>> I only see this on virtual targets.
>>>> e.g.: https://code.siemens.com/ebsy/debian/xenomai-images/-/
>>>> jobs/393605372
>>>> Mostly on arm but also saw this on qemu-amd64 in one of my recent runs.
>>>>
>>>
>>> Maybe improper/missing synchronization during test startup? Or when is
>>> this hit?
>>
>>
>> Does not look like a synchronization problem to me.
>> The key part of the test failure is this combination:
>>
>> /*
>> * Trigger an overrun condition by staying busy for longer
>> * than the duration of our allotted time window.
>> */
>> for (;;) {
>>      evl_read_clock(EVL_CLOCK_MONOTONIC, &now);
>>      if (timespec_sub_ns(&now, &start) > OVERRUN_TIME)
>>          break;
>> }
>>
>> /*
>> * Now check whether we received the overrun event as
>> * expected. Since non-blocking input is enabled, a lack of
>> * notification would amount to an error (EAGAIN).
>> */
>> __Tcall_assert(ret, evl_read_observable(tfd, &nf, 1));
>>
>>
>> The OVERRUN_TIME of 200us seems to be not enough to trigger the overrun
>> or in some cases or at least the message was not send in time.
>>
>> I suspected the issue to be time stealing but saw the fixup parts of the
>> tp scheduler trying to handle missed time frames. I think we just have
>> to increase the overrun time but not sure how much to still keep the
>> fixup parts tested. I guess these code paths are only exercised on
>> virtual targets.
>>
> 
> So, do you want to drop tp-overrun from this patch for now, or how to
> proceed?


@Philippe:
What is your opinion on this? Do we want to also relax the overrun time 
here?

Best,
Tobias

> Jan
> 

