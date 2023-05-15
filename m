Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61171C142
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 09:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbBThISLK6NSWWan03AzStwXhcCwifBIzYYTQzg7HLA2168mKUZm++W/1pa9YtthWHlw7revRSi7Qetk+/4TebMdJBwpYbuk+MIsJsVVeVinXh3jc6IVuCO0mUR+2WbTHlzm0FHlwzseWTatzwszDDPNO0NQbzsFzSDYyf+Ns19BlIxZoThLFO7Xt/hFXcTPf6dBGt5a8kbzClQJI7wyzg36uZhWIpSpCkpcVsE/sL9hq9WTmX9Kh7Gpe0l6kasnPuA8V8/Xbn9oDxfDPTBz6EHrPCJ2KLXrd9z4NXT7FJwBHxW0Dfc1oG2GBQNHGi3NJfT3XXesovA4RjoZ+t3gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5aFkoxgI+9cMkm9L3JxTUQMvSf4f1NQWzSrGhKPjLY=;
 b=c92ZO5IYOihjSBY8vmOR/WoWD+ziYb1hM5TwDKny5uZag46Rnc4jq/wwe5Dq7+CHO4vYT/Mq+CpceiC/2+pxJ0RTxM6xW9qw6bxa9cTVEqb+zA0ayt+Xj7ahtPbmx34W3nMPITHiGLrZTORBH7pWpOfOnjfsQ1RD8AKH70tHC8s44qcj0cHzTAkKgu/vazfFqLEcKxXcuCN72Wfif8Pwubz3LcLQXIxR3dWlYBwkxj3LE9c/XcUP788/EJK/yN+Ga+sK/vc9LdjKYK90Zk0ZONDyk5hgdArOaEgo4eviqQaUdyhDh26qBW3pZNc5SudwnMIQL0mvR0itdy1ew9IKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5aFkoxgI+9cMkm9L3JxTUQMvSf4f1NQWzSrGhKPjLY=;
 b=RSH0Sh18mA4lpAjUBGoFiKWbjdzB/6dfr1v3U1t9wFcJe4blSIYcYbx2nP6aF5eImpAWLQCBO8wVL6ce7axqC0zp9HE/kzuFLBs7YNY3xcXvi32Qjjsj7KS1lersnjIEkgUH5DOWO4yzaGxOPRvupp0+flHhN/nIgVO2VqMJsUzCxcjvF4wKijRAmOT0C480raz4422F7zdJLFc3Wdzt71p55Po9ihKs4RitxJgZuqGW9EjEn/wTwPvDqt865ZCddiwUEXWC9Df2mUBGYC9V8aWJvgT8znSsJ+EN4RsBqp4sAtNFfpQ9vG7r+Qua27Qy7YEswOg8FKBSATWwoXYuPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 09:36:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 09:36:10 +0000
Message-ID: <6fba0a69-c89d-1a80-5fb9-3e5ab1c9553f@siemens.com>
Date: Mon, 15 May 2023 11:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/13] y2038: cobalt: Introduce some itimerspec64 related
 helpers
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
 <20230508-florian-y2038-part-two-v1-1-a417812fba85@siemens.com>
 <9693dc1a-1606-652b-29a8-8f1a23b9cdbd@siemens.com>
 <f70f996b4840b61fb3b6d2829b4a400ae8f9db40.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f70f996b4840b61fb3b6d2829b4a400ae8f9db40.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edb6f88-eb22-4a99-3f24-08db5527d0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oxXjV2r5EXqaYhyrJp9RyfUwlE1XYcCPP6lKV40VG83lOD+mlw4G3V4B3A6qbtolb3nPrOFLFQz394snivhVrnq6HlJ6si18q4sljA1W0jgVyKVyJfsg7HoBySYispoWNJ4DwqaSnk6t4wOIL6cVx5+1wKypXd+9miIA5MJ7PEKXd9ecTY6Yvny1TiMtE3wqUPnu+3esiWXYSqBPr5BShy4AZyrC88MxSNiOYZAoQir7+z6TbAkzowTV07MR4ZZvleWGfCsJHa+1SBb5m+wq3KMTp0x8yxvKxXmRWsNM+QvvVWMS5ueLBRMHQWgJpg40VE3BHo6Ytf7a6aTofK9P/hf23XtdiW+Cfh//FlqY1SIEyAQuteGUq5+SAJS/2DEmcaJKoohTne4hpxWZMZKOoJJlboYjq1OlCfxsFEo/M6MISiQ9vtz3o0O0i5Si/kXZjzZF33bkKUF/RNugUEr7FBzxM3tmax2tYmX/c978El9itEH4D3mSUzM45XKL/zgydYvjzftbsa6NIGQJjuES+9xbM/U5tf7+MOdhquPNoEhNRO1rSIec9AedvASnUe+1WYPE11fjddEkqi6RGyQ2I8B9ptVy0v6IzwXlqKB65QrVDwpbJhYjC96KFECHXTd1CDA3GG8loErx4PDoFhs2DQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(316002)(83380400001)(38100700002)(82960400001)(31686004)(66556008)(66946007)(31696002)(66476007)(41300700001)(8676002)(44832011)(86362001)(6666004)(36756003)(6486002)(8936002)(5660300002)(478600001)(186003)(26005)(6512007)(53546011)(6506007)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW5CMHR0c2x1Y1FMV2s1YnJsUDdEV1IrS1k2RVp5Tm0xeWg3NXVuQUxmclRw?=
 =?utf-8?B?SXo5SUdvUEJ3dFF0a3BmK0hKMGhJSEpQeENVN09QeXg4QWRuNHJHV05PVnRC?=
 =?utf-8?B?OUVoNjZ4TE9xMDYxTENmVHlycEhZTVdEbHl3aXgyVGk2c25McUsvMmhkb05K?=
 =?utf-8?B?VjU1ZWVQdHRhK2g0cnlWY3FwTUVxdVYwOW1Vem1pOE0xR0FSNXpnQnpNdXN3?=
 =?utf-8?B?U213bGhTWUc0YU94ODZYRUV2R3JHRDY3aGJuTmVsUFlmN2MzQ1NERjJ2NzlW?=
 =?utf-8?B?Z2dsTVQxZXpKanVQWC9LU253aGxxaWZJaFJqa0gyTFBnNDJJOFUvMVJsOUZG?=
 =?utf-8?B?b0xWTHRxdmVwMDZWaS9GcmJmWVZzR0pFMjNpTXRCTGhEVTNzdDlnby9NaGdl?=
 =?utf-8?B?Z0t6OXFRYWxaZUxOaVZsVXcrcEl3UDQvdE5OM2JnNENTdHpRcVNZbS83WHE2?=
 =?utf-8?B?ejBNdVNPUXpkeVB0SHV1bFI3TmkzeHJCL0tsc3pmbGp3TTZ5SVhialR4YSs3?=
 =?utf-8?B?YW5IOU85SXJQcTA5U2VJc1ZEYVNuWFpMUmd2VkNISkZYTkRlYnVqSVIzSFFI?=
 =?utf-8?B?VFp4b1BTTTJncU56MXZlZ0g0cko5MTA4RE9tSE5UTjRtTDkwL2I2Y2I2QjJP?=
 =?utf-8?B?bEZTTGNCM3BuN2ZvRXZxM05pTlRoQ3RFMjZwU1Y4WXJZSHl0aFpFaTJzMTdq?=
 =?utf-8?B?RzBUdUlBUFJkTnZ5a1BNVHE1bTdqNDRiMzVPM3FRdVh0R2ZNd3pjSlhwbVFm?=
 =?utf-8?B?cGorVkRCNm1zTFNQZmJQa0lYNTl4WlhJa1daWlJaUzdyL2haSW55c1NPTE82?=
 =?utf-8?B?RzBEVTRZdVdvK0tHSjRQVktlUjJERUoxT1dWajN1ZWJpaVk2OXczL3ZrTkFK?=
 =?utf-8?B?NjJmdTBMVnY4R0trSlJFU3FIQmh1VGZxbWVxcjJrYnMvZWlNVG9MdlVPbURu?=
 =?utf-8?B?M3ZidVBhZXpEV2EyQW0wRTVwM3dWNEZrWlJ0MWZCZmF0all0S2lPWHhVaENL?=
 =?utf-8?B?WUxoSDVmZ2IyY2c1VGtvR3RkZFdWRisyMjloeWV3QlZYZW1CUXk0SVFTb1py?=
 =?utf-8?B?dS9idjREZ3NjcUhWZmJmaTdlWkJ2MTE5NlBvQlY1c21OKzdLelo3TXVrQXdy?=
 =?utf-8?B?c0dKZnpCeERobTdQWU5VcWh0akpWV0ZreXV2UTlxZFhsQ2FoNi9LUU56ZUt4?=
 =?utf-8?B?V2o3VFdDNU5oNkkwNEZmMEg0SkJxVEI2ZG5TWXFDYUh3b3R4UVQzaEhyaENY?=
 =?utf-8?B?TFRURzREdnlYS1BlelZ3SGk4U004eHdOZ3dScEI5RHV6ZFlKSDRPenpVQ0Nl?=
 =?utf-8?B?YjBvaFUyODYyeUIyQTBuZnQ5OEFJSUQrbVBrOENjM3djVEtqb2pETFZxZGRO?=
 =?utf-8?B?ZWpQbGhJekVsQnNLbGx0RC92R005Q05HRXpIeTBjWVVDclJCUUlZdUxsS2hR?=
 =?utf-8?B?S1ZCaURnUnAycXdVcjZLU3BpT2ZpZ1VDdU1odEhiZWw3N3YyVW9iSHZKalJp?=
 =?utf-8?B?Y054TWdkS1FnbEErT3RnL2NmR2NYc0xUVXczaEZXSFdlNkZMKzdSOUdaWVFl?=
 =?utf-8?B?ODFqdWZVYUNuMmllZi9SK3Y4N0lJTGtsQzlWUTI1Tmp5NkNhWnVSZFU3cU4x?=
 =?utf-8?B?WUdTRyttS21VSlJ4Qi9LUTZQYWtwWVMvY09rOWp6Z2JRTk9MdXdYV25oWEVk?=
 =?utf-8?B?Q2x0M1JCM3g2Vkp5cDdEUVdYSDFjUkhmRXY5Z2J5NVBWL08vVkduUHRJa1Fx?=
 =?utf-8?B?ZGRjYzFvRHlRMU10d0lSQlBCcStlSEMxbjMrTVhzdVVBMFRrUUdJaWZxT2xX?=
 =?utf-8?B?TkRYVkkxdCs2M25tR0NyUG5iYVF6cW9UZ095TmZ3eDE0WjhKaXZsTThRNmdQ?=
 =?utf-8?B?Q1dSNzZ2R2VJN0tuSTUwQ3RNdW9sNTdDMzZVS0REWWlyQzZoZS9pdWU2NGVt?=
 =?utf-8?B?Q2gvNFRlN1BUTVhlMEU3Y2xRbW9xMHlUV0wyTnF0SzFvaUhMb2pRMkpDRTlt?=
 =?utf-8?B?OWswcGsrMzJ5aEt0OGFrRy9QOFZBb2Q0Tkd4dkZvZ0I0dHcycWNDa00vSEFS?=
 =?utf-8?B?Ri9oT0JVQ1Fjai9rUW81c002ZUF3QUI3bHg4dDQ5T0NxQ1NyOVVSVkVid2xE?=
 =?utf-8?B?SndvSFBCNE92WGNSVDIwZ0NZU3o1cXhHUk9UZjdNRVphTWl2RDZRYk42d3VE?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edb6f88-eb22-4a99-3f24-08db5527d0e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 09:36:10.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdhZUW/QtHT0SeIVSlEGaqR9PiSgC7lDnV3etHuxTsx6dama+DvUH9wTAx8IbKEls0JYs0ygFBpoYB/JopjsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7072

On 15.05.23 11:31, Florian Bezdeka wrote:
> On Fri, 2023-05-12 at 17:59 +0200, Jan Kiszka wrote:
>> On 08.05.23 10:13, Florian Bezdeka wrote:
>>> The introduced helpers will be used by the timer and timerfd y2038
>>> related services for reading/writing itimerspec from/to userspace.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  include/cobalt/kernel/time.h | 21 +++++++++++++++++++++
>>>  kernel/cobalt/time.c         | 38 ++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 59 insertions(+)
>>>
>>> diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
>>> index a55398068..e348cf9b8 100644
>>> --- a/include/cobalt/kernel/time.h
>>> +++ b/include/cobalt/kernel/time.h
>>> @@ -28,4 +28,25 @@ int cobalt_get_timespec64(struct timespec64 *ts,
>>>  int cobalt_put_timespec64(const struct timespec64 *ts,
>>>  			  struct __kernel_timespec __user *uts);
>>>  
>>> +/**
>>> + * Read struct __kernel_itimerspec from userspace and convert to
>>> + * struct itimerspec64
>>> + *
>>> + * @param dst The destination, will be filled
>>> + * @param src The source, provided by an application
>>> + * @return 0 on success, -EFAULT otherwise
>>> + */
>>> +int cobalt_get_itimerspec64(struct itimerspec64 *dst,
>>> +			    const struct __kernel_itimerspec __user *src);
>>> +
>>> +/**
>>> + * Convert struct itimerspec64 to struct __kernel_itimerspec and copy to user
>>> + * space
>>> + * @param dst The destination, will be filled, provided by an application
>>> + * @param src The source, provided by the kernel
>>> + * @return 0 un success, -EFAULT otherwise
>>> + */
>>> +int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
>>> +			    const struct itimerspec64 *src);
>>> +
>>>  #endif //_COBALT_KERNEL_TIME_H
>>> diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
>>> index 27dbf8290..716223dc5 100644
>>> --- a/kernel/cobalt/time.c
>>> +++ b/kernel/cobalt/time.c
>>> @@ -36,3 +36,41 @@ int cobalt_put_timespec64(const struct timespec64 *ts,
>>>  
>>>  	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
>>>  }
>>> +
>>> +int cobalt_get_itimerspec64(struct itimerspec64 *dst,
>>> +			    const struct __kernel_itimerspec __user *src)
>>> +{
>>> +	struct timespec64 interval, value;
>>> +	int ret;
>>> +
>>> +	if (!src)
>>
>> Can that be enough to validate the pointer? Or is it even needed? We
>> must validate it via cobalt_get_timespec64 anyway, no?
> 
> I think we could remove this check but it improves the readability (and
> code flow) a lot. 
> 
> Without this check cobalt_get_timespec64 (called below) would trigger a
> fault while reading from this address when src is NULL. (&src->it_* is
> a low offset). The result is basically the same but we would migrate to
> seconary domain first, handle the fault there and then exit to
> userspace. No?

&NULL->offset is just a pointer, not a dereference. And even if we check
for NULL, NULL+1 would still pass.

Jan

> 
> Florian
> 
>>
>>> +		return -EFAULT;
>>> +
>>> +	ret = cobalt_get_timespec64(&interval, &src->it_interval);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = cobalt_get_timespec64(&value, &src->it_value);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	dst->it_interval.tv_sec = interval.tv_sec;
>>> +	dst->it_interval.tv_nsec = interval.tv_nsec;
>>> +	dst->it_value.tv_sec = value.tv_sec;
>>> +	dst->it_value.tv_nsec = value.tv_nsec;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
>>> +			    const struct itimerspec64 *src)
>>> +{
>>> +	struct __kernel_itimerspec kits = {
>>> +		.it_interval.tv_sec = src->it_interval.tv_sec,
>>> +		.it_interval.tv_nsec = src->it_interval.tv_nsec,
>>> +		.it_value.tv_sec = src->it_value.tv_sec,
>>> +		.it_value.tv_nsec = src->it_value.tv_nsec
>>> +	};
>>> +
>>> +	return cobalt_copy_to_user(dst, &kits, sizeof(kits));
>>> +}
>>>
>>
>> Jan
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

