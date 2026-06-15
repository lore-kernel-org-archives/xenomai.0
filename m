Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F6330675
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519086; cv=fail; b=cJ755F50kFX7JPDk0C+JcbtdMUVF8ZVWZzSbNiXeDKX5g8Wl8viUs07Vh9w3yoViA6W7InzuG846oRrXBbyZhmNf8xBdSpQX6hUH020Sxy13btwg1kLcH/wu786XPg62Pt6XyTnNAvfSga1rz2NeqseBkLnDis3hyPew+KaC1BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519086; c=relaxed/simple;
	bh=xAza5G691GUkKUGbDYNj0YTN8gCj3Q5z0Va8V+1dwIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q9kHOyTkLW3hqDWsXAZEwmVCn5iPameC4tUL7Pg2HV2EOMxcLBnvnTokjHhgiL033A+JBaA49Mw5hTkrS5QKhXIGoXj7ROvTPlDix2E/Ky+LRsE6Ppe+7SNyhrSDPDxJiryzebmSVwADVwQgKssb0wcbMbKN1qc/MW/S0zxBjJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GcoDlGkY; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GcoDlGkY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcS7r+kr/+eRYP+kplYSrMs6VqReCLiTi2L7b7Tnh/RB7bTqET17y40WA//+eat+jFhjPwKNwHYVvFjaGnAOV4qQJo3mN3GQoaT64KTg3nTFgW6BFQCrzTT9g7kMjbQecsc9bTjBI1lIOtZl497MDKfl2Dq2VX422shXOMvlll4LWrJU9TVM6AsEdEdYatJyDCh4QZvyyuE+s0nshbEFzwAhtfwslB1m0/jiPDZwJPtecro0qjcvaF+8VHhzA2L18JKvqFOCVMWDjw/3fA6sG9WV10JyamLhwnKOqpGH7dBdbKRXrFkRf3np9mgDYYr509WkkWhkAXi18jYGTI2l+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G/AdINm4PvfoVjKu5WGB0Zk3omFuPD2PSG0TdFyRDQ=;
 b=PWbzacV14vJZlAx1lywz/q2YcW5BQswcMfc4TzD766unenNCjefwbZ63PidOp36WTBYI7bKajti7KU3aDEkaD3OWvvEH8i7/nzDjP3l6BuOEVOFLwwcXwVM/OPu2BXTUsxTjheL9G084jRE1Y+ZKELDTwI6kr2O2E4jCWbckpIAuDsmlSoxeLNIZ3NetwufnvYSSpUOKhOwJ7zZ5eyi0JV/X+fWjw7nbE2sdoJNWm0U3LWkcAR1/GRO5QY0uBSBMKOQKkV0tl+yPekNjomF53p7TDREBhyM4sZVqTYFsfNXicLQbMs+obcePDMzW3sFvuGq9bJN61ul1LNjan8rmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G/AdINm4PvfoVjKu5WGB0Zk3omFuPD2PSG0TdFyRDQ=;
 b=GcoDlGkYiv9+o3VIxKdpXaN2GjdoayBxbQpQuxzVNaMLX1jOw/1/EWqN8e7MMJ1w/NltLpsqU8TisIAtNLm1MrtThyF/Iu051x05T6CCiVVAZZvgEr8tAQZsIq4GUkhtfpP1UVELw7eYU5UEaeATHlEarHiZoLQnbxo3YXVVQCw4Pv7ZZBCWr+5tWC46sxYwXA2eVE4q7i/qnp00TU2jSskC/VbWpJJ5bDxhf+tSsxF8e4h4boadRPGatt/0hPRL5UqF9H0mNjIQo6Jxb5e4px9+junz+/H6kW4+ogLeO5TDiqN8orMLXCmsgvLYdYRcd44JPp+R5XDBHwQ4gGD/ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:24:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:24:41 +0000
Message-ID: <c7b11013-02d0-4827-8706-c4b0caaf151d@siemens.com>
Date: Mon, 15 Jun 2026 12:24:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] evl/sched: Add sched_out handler to sched_class
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <e5e231b6-dcae-4b40-9c49-4c93f2e761d9@siemens.com>
 <87ldcgiah9.fsf@xenomai.org> <87a4swi9sy.fsf@xenomai.org>
 <4797a713-e16f-4792-ab7a-51a2876fb6ef@siemens.com>
 <87wlw0cef9.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87wlw0cef9.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: b27e9bdc-a27e-44c3-888c-08decac84ff1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|55112099003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PL190C7jubhoIcGiS/IIA/03x+piEjFcwMzNFXJ8UYUBUQ3ueA3Bz1Xc7/SuyxebGgb3Yd52ObIOxxyJE7Wn4hdCa2T0aWE/Y7YiI1f2YtJtdMD9NgQSMaXPEAl9CJ8azRzWrNJI+nroFTN/YrPldJ2YdCDmah57AChtm7G7C15Oak1k2Ia8TDfRAvTkvXAQAHPmmDwCHPs89UKrBbIJ9314C8nUnftSdMes25/tf++podc1+hzDwocfc4r6wNgWAuts2z6XArmecsl9JhrDzIEDNRPI5+24mrw3TADEKrmFtWjxcca+SkckK5Jhlg+UxKXsLYR0c7OH0uEdddy2JWRkF/mxNsnEDP3btrm89yelkFUgWFM9Gmd0I2L6S8Maq+dthHL3MPBfVOeMUhnuIYYafX7m7OquH/CCt6VLRQsYK2iZr/tMLVR+F6nYSk+T6x6oLPPMPox+M03AI6jAza6SU8g5NfbfHq9aIxKeYxgKsLySwR3xcjEKSwJkwy8FoZ4eUDSWcofCzdM6mk/t0Ek3QQyO7JHJYWQmRYOJ9E7oMvPeCy4yvH8XeMMQrZFmKmQ5JnD0stQdOk6Od1KIOuJB3AX9k3OfksGKaUdZLPSkhsS4aGRIoPm3h6Bs+wVMwYSHCIOZ8cBo/LPGnpwp02Cl0J6e27RhDhd9lniU7rq9/xZnkC0fEEvYxtHPXEJ6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(55112099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGhrWEhaMjRaSGJWZVI3ZGwyM0lXZ29OMng5Wnc0UGNsVGVTekI5bFBWNThz?=
 =?utf-8?B?REI3MlFEajlCUE1xbGZ0YjRDaVhycmhrNnpOYWRyQlJjWmFZYTZmb1VPNHNl?=
 =?utf-8?B?eU9IM3VGL2F4K2tWd1dTN3MzaHhIWVlKVld1dWNONzJxQUVBeUpIZFd3VENY?=
 =?utf-8?B?cG81WW9vMTlSV1NPQU5FclByN1dkUUJ5R0hyOG9SSCtNZjRkTllEaHJyUEU5?=
 =?utf-8?B?bngrUGtEQ05aUHRLek4wTzltaVNjczU2OGVCWDFVN0FpQmM5MVRZd25pYzhE?=
 =?utf-8?B?N3JBci9WRFdOZ3RjUysxVEFWK25sb2R6YlliR1ZmelVqWTBPTEN4MzI3Nmlh?=
 =?utf-8?B?MkRJTTlPd2d3c01ibnh3MzlDUVZRamhlT3ZCdkpSc2c3d3JBY25qalZaeEU4?=
 =?utf-8?B?SU1haDd1VzB6eHRrQU9oTWcrQ2tvTk5BMmJ2L2ZPTEJmQjdobTh6OTVreVps?=
 =?utf-8?B?OSsrYjlPWCtROFN5NFU5RlE5Y2VGM0NjTWViLzEvYzg5SVNYQkJMUU9rWDkv?=
 =?utf-8?B?UWJsVkpRalNPZ0NKTHozMlluTVJGRXI5QlB1a0lQYmUzaVgrcmxCdmJLeEJu?=
 =?utf-8?B?R3hEZG1nMnY3WE1iNGFocE5zQnlXMEZvVkkzZ3FpTk5Dak9vWVIzVzNwMjB2?=
 =?utf-8?B?RFRsQjdWVUo0bGtHUDVmNk5TcWcySWNJaG0rNWFvcjV4S3YwSmpxTWlUWlFQ?=
 =?utf-8?B?UUxRTnpLa1NNRlpOckZSd0NzUVhTalJNVlNCYUNPclUzNHZkZndmcEZNOU5B?=
 =?utf-8?B?bWgvQnBYRVdXZy9ZVklETUQ2aFhKZnJDUXZmUTdXcnFXQXJEdzdzTTFFZDRp?=
 =?utf-8?B?bWpWRlF4cGxTeU9HL1kwMWVTekxOVHRFRWljeHVnUjBESG41NFkzT2grQnJF?=
 =?utf-8?B?TnlUMU9ONUl1UytkeVh4aVF5WDhYTEg1QnptVHRXTi82M050T3BEK2NaU2xv?=
 =?utf-8?B?Y21yVFpzVmpjOWJHdUZTcUNyT1FHYTVpZG50bDhNTHNsLzRkN0hRY3Q0Zkla?=
 =?utf-8?B?VTl1S1BoY0pPMGk1ZSt5d240ZFlTOHlxSmVxcGtnWWF6RkRjeStQWEFWdjdZ?=
 =?utf-8?B?bFlVZmg0TXNjVERyK2Mwb1FvbjRNK3JjeURwMzhrMXhPSEJrY2IvQ1d3eXVk?=
 =?utf-8?B?c1BmMUtGMDdpS20xRTAzMnJJTnQ0QUhLM3Z2TFpoODNnLzRWam5rYWJyM3g2?=
 =?utf-8?B?SmVWWWQ5aTBjRVUzVERnazFORllwZ29MNDhYS0tZOTR3U0YvaGxseStmS3pk?=
 =?utf-8?B?SU02Vlh6T3Y2dENVNThPK1NlbXJDalZOSW5FWnFEelREcDdvbStNQmZIb3VO?=
 =?utf-8?B?dVhQaFc4a0pJVmx6UERNQ0sza1cyeS90cXRjbGpoWUo4bDE1Sjc4akhwOWZ6?=
 =?utf-8?B?bXlOd0VyWmo0bS9qRXkxU2Y1RGNnQjV2TkhqMVpyL0d3OUtpaWVMcHRJRWsv?=
 =?utf-8?B?OFVaRXJ5ZWdvTkJGWkZlTXgwR0tTdDVtZ1JzMnJXV2NCVnpmMDJHemUvTUFX?=
 =?utf-8?B?WmV5ZVJMZGRPeEFldjMwbnZGcmVMR0JoVUc5REJnOEhLRzlDcldTVDFYSWMy?=
 =?utf-8?B?SmFIU0lZa0YyazI1SGFMMkswZ3J0bjVqcHFzMk5pS3F6SXhCWlZoaTMxYzYv?=
 =?utf-8?B?U01weXEyb3pCRkt4T00yK3VqYXRPaXBZSUIrWUZEQURVcUF6amZoWEdjSmlO?=
 =?utf-8?B?UDJnTnV5SVBKRUZ4ei9pd1N0YTcvSzhqYlRVVWhYRWk5N3RPQlpwanhKRHhs?=
 =?utf-8?B?UWU0aWxvMHFQMzJXSHZ3S2JGdzR4RHJOTStLWW5sZ0hJTDh4dHYxcUFsNnpR?=
 =?utf-8?B?SEdoMEtUS04zUzh1MW5oR2VpeHRwSGxvbjk3bFBBU3k0N3ZsOHd6L1ZiL1V6?=
 =?utf-8?B?ZHhYc2R3dG1zMGl4NkMxZ3BndGxDOXdMWmVlUlFIY2xub3ZvbkJqQmM1SERl?=
 =?utf-8?B?WTI0WUd2VCtJRk9vZTBoWHVRc1FhWFNKb1orYlZ3a1lNcmhuTjZnakhudlJ5?=
 =?utf-8?B?V0ZoTWNBanQ0d0Q5aEVZYlBLUHMxMDh6VXJseGNwQ0IrSURuSk40WEJCT201?=
 =?utf-8?B?T2JIaGhsbTByUGdlU25mM1EvbkNuekttU003WnBPekRXS0JxWXVTbkJxMkdQ?=
 =?utf-8?B?NlZPc25LMHlpYzh0QjFKZ0UrWnQ1ZjlGV3gwTlNzVTZiUk5saGVlY2l3UGxQ?=
 =?utf-8?B?Z1J1RjRJdEsrb3haTUo2dy9NcVlLeThIWFZtVVlIOXFNSHF0dDBvZEtsdWZY?=
 =?utf-8?B?QTM3NHd1S0ZkemlyRk84NXkydDlHSkdVT3lOUUZ1SHJYclJVNHFuR0ROcE1K?=
 =?utf-8?B?WXpnbXQxbnJEejdDZU5uTHBkbEtab2I0MkJNNkQ1dlpGTXNoUGpTQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27e9bdc-a27e-44c3-888c-08decac84ff1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:24:41.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odUnTpOuWAtgTSEslBn1/8L/7628JE8Y56+xSixm/FjRlFVugdWzQVwtGiypjanEJdNR4q/T5tG3OErMlPDQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7051

On 15.06.26 11:59, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 15.06.26 08:42, Philippe Gerum wrote:
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>
>> You also need to update tg->run_start. Otherwise, you will overcharge
>> the next time this group is checked here.
>>
> 
> Yes, this needs fixing.
> 
>>> +	} else {
>>> +		tg->run_budget = 0;
>>> +		evl_stop_timer(&qs->limit_timer);
>>> +	}
>>> +}
>>> +
>>> +static struct evl_thread *quota_pick(struct evl_rq *rq)
>>> +{
>>> +	struct evl_thread *next, *curr = rq->curr;
>>> +	struct evl_sched_quota *qs = &rq->quota;
>>> +	struct evl_quota_group *tg;
>>> +
>>>  pick:
>>> -	next = evl_get_schedq(&rq->fifo.runnable);
>>> +	next = evl_get_schedq(&qs->runnable);
>>>  	if (next == NULL) {
>>>  		evl_stop_timer(&qs->limit_timer);
>>>  		return NULL;
>>>  	}
>>>  
>>> -	/*
>>> -	 * As we basically piggyback on the SCHED_FIFO runqueue, make
>>> -	 * sure to detect non-quota threads.
>>> -	 */
>>>  	tg = next->quota;
>>> -	if (tg == NULL)
>>> -		return next;
>>> -
>>> -	tg->run_start = now;
>>> +	tg->nr_active--;
>>>  
>>>  	/*
>>>  	 * Don't consider budget if kicked, we have to allow this
>>> @@ -439,25 +437,29 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>>>  	 */
>>>  	if (next->info & EVL_T_KICKED) {
>>>  		evl_stop_timer(&qs->limit_timer);
>>> -		goto out;
>>> +		return next;
>>>  	}
>>>  
>>> +	/*
>>> +	 * __pick_next_thread() might have requeued the current
>>> +	 * thread which is still leading the pack.
>>> +	 */
>>> +	if (curr == next)
>>> +		return next;
>>> +
>>>  	if (ktime_to_ns(tg->run_budget) == 0) {
>>> -		/* Flush expired group members as we go. */
>>> +		/* Park expired group members as we go. */
>>>  		list_add_tail(&next->quota_expired, &tg->expired);
>>>  		goto pick;
>>>  	}
>>>  
>>> -	if (otg == tg && evl_timer_is_running(&qs->limit_timer))
>>> -		/* Same group, leave the running timer untouched. */
>>> -		goto out;
>>> -
>>> -	/* Arm limit timer for the new running group. */
>>> -	evl_start_timer(&qs->limit_timer,
>>> -			ktime_add(now, tg->run_budget),
>>> -			EVL_INFINITE);
>>> -out:
>>> -	tg->nr_active--;
>>> +	/* Arm new limit timer on change of running group. */
>>> +	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
>>> +		tg->run_start = evl_ktime_monotonic();
>>> +		evl_start_timer(&qs->limit_timer,
>>> +				ktime_add(tg->run_start, tg->run_budget),
>>> +				EVL_INFINITE);
>>> +	}
>>
>> I still don't fully get how the limit timer should be started on
>> setparam over the current thread. Will curr be NULL in that case, thus
>> curr != next? Is that the reason to go for a separate runqueue?
>>
> 
> Nope, that one is only to make things clearer, since there is no upside
> in sharing the runqueues (this was inherited from SCHED_SPORADIC for no
> obvious reason with hindsight). At some point, I noticed that it would
> even have introduced a bug in a previous tentative implementation using
> sched_class as a discriminator between threads, to figure out whether we
> should call the sched_out() handler. So, the simpler, the better:
> distinct classes, distinct runqueues.
> 
> Regarding the limit timer issue, sched_pick() should not shortcut on
> curr == next. IOW, the rest of the code should run even in this case. By
> turning on the resched bit (which the quota_setparam() caller does), we
> would end up in sched_pick() with either of those outcomes out of
> quota_setparam():
> 
> - 'current' switched group, in which case we would arm a limit timer in
>   sched_pick() because curr->quota != next->quota (provided the shortcut
>   on curr == next is gone).
> 
> - 'current' stays in the same group, so the limit timer still runs unless
>   the budget was already fully consumed.
> 

Makes sense, now.

> So I would revise my latest patch as follows:
> 
> diff --git a/kernel/evl/sched/quota.c b/kernel/evl/sched/quota.c
> index 3ac650c08ccb..8f1321d46cac 100644
> --- a/kernel/evl/sched/quota.c
> +++ b/kernel/evl/sched/quota.c
> @@ -407,6 +407,7 @@ static void quota_out(struct evl_thread *thread)
>  	now = evl_ktime_monotonic();
>  	consumed = ktime_sub(now, tg->run_start);
>  	if (consumed < tg->run_budget) {
> +		tg->run_start = now;
>  		tg->run_budget = ktime_sub(tg->run_budget, consumed);
>  	} else {
>  		tg->run_budget = 0;
> @@ -440,20 +441,13 @@ static struct evl_thread *quota_pick(struct evl_rq *rq)
>  		return next;
>  	}
>  
> -	/*
> -	 * __pick_next_thread() might have requeued the current
> -	 * thread which is still leading the pack.
> -	 */
> -	if (curr == next)
> -		return next;
> -
>  	if (ktime_to_ns(tg->run_budget) == 0) {
>  		/* Park expired group members as we go. */
>  		list_add_tail(&next->quota_expired, &tg->expired);
>  		goto pick;
>  	}
>  
> -	/* Arm new limit timer on change of running group. */
> +	/* Arm new limit timer if need be. */
>  	if (curr->quota != tg || !evl_timer_is_running(&qs->limit_timer)) {
>  		tg->run_start = evl_ktime_monotonic();
>  		evl_start_timer(&qs->limit_timer,
> 
>>
>> Looks ok otherwise, tests pass as well.
>>
> 
> Uh? Ok. That was absolutely unintentional at this stage!
> 

Tests aren't perfect either: sched-quota was "tested" before, and my
current proposal apparently missed the corner-cases we just discussed above.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
