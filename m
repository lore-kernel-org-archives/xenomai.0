Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69EE3D1716
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768347; cv=fail; b=TCo5gLmoDGHQ4wfJ2NfX9kYC+ihKrtJtYLi2UjttSfNJRwcxMLlMmzIv1LbjphoSRwQQfjxREyEt2m3ocAGKQi4iwJSu+Dsign1vcr9yHCy+BUKLKu/xBtRV86F4ESHVB9eZZqNRQ6AO0H0kiQUuI29KDmUaGLzItDLUDWJY4LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768347; c=relaxed/simple;
	bh=YLpb6p/65kmla4g9BeK+HzYTelX1exmd6x3uMAW+4sg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmf2PfDIq47IeixZMaxnfiggw0gZWQbFAWfUjB89Lx/nD8V1G2TXP00DrxrWLYNxuS4h2jRLKrwdQUYYANnYN9wjhx1IQvpg5Dp7zQxQ7aMOWnjq7WgW8JYHR2BEhId/dS7vNjudgeIN4HiYz2+QWBtt35qCLVQcCTLQhDxCBzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xIkRecKI; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xIkRecKI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhQge62QKccWMdysYsN68drbDt5XuB000yg/JjLOG/5Yyh4WKC0NXmM/ZtYg0VAVgTU3HL+4xyuFw/+VxbdIT3y/fLpgeDYIcDjYGBxDJwJ2n9PGbL6USXHjJkbHK3/L4gJ6t6YXNKs6IAUuxj2BHkmaccQs5gPefBBaS5bvQO1fdUrNfkBDj+FnhEuFVBG9s5USxS+2Hdn8jGyc8zmlOcPygMcq6p1xZmQz8FIMI+Ge1dv40aStMFSXF83fa2mSXUqsYXUiq7nkwOyu1qPU748iZliYUNzjSl0B+0LsB3WsK0ap6hgRR2Rb71MqYUzlHy2RGfwqqKcPSvqY7uacWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtOj9QNOPvbERdATPwQW6gOGwi+yJZ4NkB4Ups55+ec=;
 b=C00wGIrlrA3ETR/yGy5UjPX62T5qWKXrwq6RxHf9IteUZ6LEx2A26UbWfcbrFtSmVH3MGHskTGiBzKPxaEFbiOq33vUYTqQkf7OxwUY31lGJtpVS+1W0q97OaVBFgz8CWdz/K2LBA6VALpZahERmcfhMR7Mea+4EEe8XPEXEIb4T3t+9XlmkGcp7li515qrPOUn8MfxH1+lfCEkhaujsVUo5j04rF3i4x/vhcWhMZt3x0TurPn5PXKqi17Y4lWr0mUPXK6V4Yc2N46EuM/KmIAGZpkAjXlctXP7vywo+UO03ugMHBDxkf2m7WaKzISsic5UKXsBsF/cwibFqIwm5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtOj9QNOPvbERdATPwQW6gOGwi+yJZ4NkB4Ups55+ec=;
 b=xIkRecKIv9zBW+3uKzYTupg19Rvktrteq36by57jDTzbMRO2Yfw+/pOirTHbDJJ7oxJ7+iQOh62NyHyXMAF9SjYTKRHiV/AttwCz5hsaV0kQYkybuXpnoqzOH9FtNigmZXXb6pZOQvpvuwT6FoYMTK3Ojp9FCDgl4tW07w1F/f/YS3FzN5koQmVtQs5OGf+r1rNPOUupvdWy5l80Q5BMS/f0SR0uzZWEq+D6tLoEsWzSk4v8w38PRi+ftVO9PnUZa5YvVAkUBL2BlSBk4bsSAHyz10uyzleTEOz1XZtTCu7ACSNbbBFAYJFP2gZW3WasXM+P8UaHfszA2yM/I211ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:38:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 07:38:58 +0000
Message-ID: <c7f75276-309a-4ed6-91b0-7df82ae8c59d@siemens.com>
Date: Thu, 18 Jun 2026 09:38:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] evl/sched: core: introduce schedule out handler
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
References: <20260617142050.477809-1-rpm@xenomai.org>
 <20260617142050.477809-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260617142050.477809-2-rpm@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f74571d-67ce-402f-c4dd-08decd0ca86b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|22082099003|18002099003|11063799006|56012099006|5023799004|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	X0jLGsQZJ89/IGM/w+4wB3+1bUMnmwFiENMtGvRUc0WCD16kLVVYefZIPFpjFI3UQpKdRtTdxaRtV2/yhik/qJXY4cnA9STuk0FfxINMdceHYO2SNgA3vZSWGcT6+3iWMvNEXfX7oUn+drBghCMasDkedm6PMhg3qAYvDpsMVPF7d9JxPxkpPd1pkvh1JX5sGI8zqEHdEeot5h5ihhu8Y/Vk2VePMHLasQlso8Gh0Ao8tS6vNalOyXYko+9eL7nm4Q51zMTIO+jdD3jWc12XUvvBL+oJ2w9vFpsWP4tqB5bqIyZnYLKQl8s6SiFSXDw9/7b0ejfHBwP7L6wSxUcQDlNNte69YJhTJD4pX03Hmo0zhxurn4F7XFYl960PeGvEbF5Ci77XfViqSFJonhunM2rRBH/ndV6Z6ir9TgRv6zOWrkPFVYi/iiiyXQHy2dBXg71e2w65fivGr5Bi6d2SlH46mjLRw1c76uK2ggXDf8U74ZrPAAbo/788c1HnOGVRUoEE5lZ8pvbBlVoyVJN0bDAgYEm0vfJJykEybbYIVJwotTXMHwKsHwr0gNXotKLJMIl8a7FNO3Plx5qoxqVFzrvHZZeoOFyHHPvaC7DneYwb9BxCG8FUGl2OxIE63GajeSlA8XAZLFOUbXQilSgBDuh+Y980l1M7NPziVGa98yBQoVoy8mEZnCV/BMHaFYXB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUsrNVRieGhkdVdjWlRzclVxTlVBWFp6WjBDc0xtR1JBZGtvaUkyOEVkS3ox?=
 =?utf-8?B?azViWWE1M0ZXd1NTMmZHVVNKTWtKVUQyREJvbVp1UUpEWGdhaGhjRDcvT0dw?=
 =?utf-8?B?alNSMnpRQzFJU2dIbnlpZ3hrSlY1VWlKMkU5QzFyUkFHQndXczBnZmY1VDgv?=
 =?utf-8?B?Q2dmNWFMWUVYaGJoNDYvVmRVM0N6dWFtSy9sUVJQNzBSRFNneVNZSlVRaDhF?=
 =?utf-8?B?eGlQSEk3bUNnejMwU3g4WHMzT0twVGlpVzAwK1VJd1ZXVEJWYlcrVy9QWnVC?=
 =?utf-8?B?NDk4OXFMV3Q1N0xpRnBUeXo2QzlqNi9COGVKUEowUmNlYWF4VlVjRXMrc3FY?=
 =?utf-8?B?ek9sczZTcXdyTWptYkxUbHNabC8zc1lJRFBONXlXMHg2MkNCek5McHROVjVS?=
 =?utf-8?B?SUlnUkFuOGMwVkJaT2tyZXBtcFNrMkhqL2RZNEU4OVREZkZwaTl3NkExNHdR?=
 =?utf-8?B?ZktkRjV5THBZcDhrVmpmdUdRTnFudkNacHRsMTdJa2VtOWNhaW1qTDB0TVhY?=
 =?utf-8?B?VXh6SXFEd0lEeFpEQVUxQXFIZFg4YzlsR2xHZy90S2FuY0huaGFlc0NmS0N1?=
 =?utf-8?B?SVBqdFFnMEFBSWFuSVhkNFlIZEVqYVNPR2J5R0twMWNIZmJhY0xDZE0yNzNO?=
 =?utf-8?B?Q2NwaytjZ205R1ROejdTR1A4YURIT240aVVxLzc0OW5GamtmZkM5dFRTMnFJ?=
 =?utf-8?B?anZJMkVzMmtiTWtHODd0OGZUVXVSeXpmZ29oYjBWUGNUMC9nTlA2NWdpRWI2?=
 =?utf-8?B?VnlhZlNWemRvNzlFMzdmcWx3dERWd0tTdVc2VG9BVUFsTlNkY3ROMGgrOTJo?=
 =?utf-8?B?WkR5T1Z5SjBOZ2poZGtrNlY4MDEzL3RHaFVWMkVOYWRUa0RnczlOaVFldzZo?=
 =?utf-8?B?dExFOHJ3blZ2RWpNa3BEbkhST0dzVnR2NXFoQUZmWktWSXpzRXVwOFR6TU1L?=
 =?utf-8?B?cVo3c1RydjVPLzFJREtrcm9seHNoZGRVSEE2bWF3MWR1L3BDM3E4VC94NnRp?=
 =?utf-8?B?clg4cmdOaXh1Y21hOFV5RG11azFqMDV3R3c0YXlMUXhRTmorVWxKRGJlUHlj?=
 =?utf-8?B?MS9zMFBDMTA0SEhqVGErYWM1b0l5c01WNmJzVDRJRXE3Rk8zWnFzSUtvU0gw?=
 =?utf-8?B?R0tBenJmQjZXb1lyQTZ3am9mZ2NGY3dTTDlwUWNTai9OY3l2K1RqQjNXS0RW?=
 =?utf-8?B?aTNMRndtZG5ydG03RDNaRjhQMHJwVENtN1NMNk1PQWFTcFpuaGlJY3grd202?=
 =?utf-8?B?MFcyazRnUjZFbXJpTWRWMzBBZHFpajBDQXlBM2tUb1JJUTFabWNsWXRWWEwv?=
 =?utf-8?B?bGdGUVBZUmMxMWlGWUlYeDZZWFN2YVJ2Y3ZIVnBlSnpvbXpqeEREdmNsck5S?=
 =?utf-8?B?ZndwSzYxUW51cWN6SWd6VENQTjRjUTU0aEZtMWJ5M2Y5SzF0RFhmSFN0OStJ?=
 =?utf-8?B?RWpFRG9BUnpZbmh4SEM5UFdYOUVrcjRhSDhzdWF1bE9kSkM0dWVDaUdmTVdz?=
 =?utf-8?B?TE9vQ2c5Q29Nb2UyMDhJUkNkekc4dThETEg5TittaDQ5elg3dG54TzhkL0RH?=
 =?utf-8?B?MGZMOHh5VjBzaHJSYytrT1Fqb3NjTkVpQ051dzVZQk11N2srM2IvNGpzS1lG?=
 =?utf-8?B?dDd2cXdwQUZtcExwem1BNzRDd3ExME9IU2l0SmRpQ29lZ1cvSzhrVklmREx0?=
 =?utf-8?B?S3EybTR6VFREalBqSVJsQWRSUllQdUlMMXpkOHJoWElwTmJPbWtBd2x0Z1py?=
 =?utf-8?B?RXNpamhQc3ZxWFhLSC9sYU9aRkNmS1dXMko4c2FYVmhPN2xFODlBak9sMmh5?=
 =?utf-8?B?Yzd1dmN5QktVcGYrMkZrNmdCOG1qSGJQVUJqdG5ROWNPenBySFFIUTZlSkVT?=
 =?utf-8?B?QUJmWUkyeEFlaDg1Sk5lT29ERXRQeUNyWnZMOWU2UHdadXZSVGsza3RQNGVz?=
 =?utf-8?B?S1dlTGpoWFJOb2hGRVRwVFlCS0tVdTF6MnNsN0FESXB5R3RoalJPTWR1YUZq?=
 =?utf-8?B?SU9uSVpwdkNGMmFOTFAxL2YzaGo3WU1aSFlWN3VhYUtWUmlNQUk1Vkg0Slk4?=
 =?utf-8?B?SjYrY2RYZlJEdjJvT0JGZmJaZ0hYSnNPOWEwVk5iVFpoVngrZlBnM2h4c0Ry?=
 =?utf-8?B?aEVZT2tkRlV3NjdKM0pDRmJXck9qU3lyYjBWeGFBeFc1UDhxY1FnS1JtM1di?=
 =?utf-8?B?ckJLY05hdnFIOFBwWUsxcFBaMzl5WFdneWI2RTBFdWxHay93VWNqR0Q2c1lI?=
 =?utf-8?B?dldXVVE1K0JiT0tQaUdJKzBUZXNTSzRDcnk5SWNvS0hpbDRpb2xhaDJOUUxV?=
 =?utf-8?B?VGRUUGc1UStqVU5zamxXOVUwd0dJYTN5bmZPVnE5azlXMGU4T1F6TEV4OXJK?=
 =?utf-8?Q?DUBv/cuD9opLkdyo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f74571d-67ce-402f-c4dd-08decd0ca86b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:58.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXbakr00m8eIfceRB86ohbrgOVRJeE54wE/xUb/e6v6fqzgBK8EVzkcoF4Uzmg1nNWmxhMSav+rm49OfNRFdUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7081

On 17.06.26 16:20, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Some scheduling classes may need a way to perform specific
> fixup/accounting work for a thread which is being scheduled out.  We
> cannot rely on the sched_pick() handler for this since the first one
> to successfully pick a thread prevents other handlers down the class
> hierarchy to run.
> 
> To address this issue, we introduce the sched_out() handler which is
> called for the current thread when scheduled out. This handler is
> invoked unconditionally when present prior to picking a new thread.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/evl/sched.h     |  1 +
>  kernel/evl/sched/core.c | 20 +++++++++++++-------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/evl/sched.h b/include/evl/sched.h
> index ae9690860146..cc824c28004b 100644
> --- a/include/evl/sched.h
> +++ b/include/evl/sched.h
> @@ -120,6 +120,7 @@ struct evl_sched_class {
>  	void (*sched_dequeue)(struct evl_thread *thread);
>  	void (*sched_requeue)(struct evl_thread *thread);
>  	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
> +	void (*sched_out)(struct evl_thread *thread);
>  	void (*sched_yield)(struct evl_thread *thread);
>  	void (*sched_migrate)(struct evl_thread *thread,
>  			      struct evl_rq *rq);
> diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
> index d1d025e06a5d..7127d4e52df9 100644
> --- a/kernel/evl/sched/core.c
> +++ b/kernel/evl/sched/core.c
> @@ -773,7 +773,8 @@ static inline void set_next_running(struct evl_rq *rq,
>  		evl_stop_timer(&rq->rrbtimer);
>  }
>  
> -static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
> +static __always_inline struct evl_thread *
> +__pick_next_thread(struct evl_rq *rq)
>  {
>  	struct evl_sched_class *sched_class;
>  	struct evl_thread *curr = rq->curr;
> @@ -821,8 +822,14 @@ static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
>  /* rq->curr->lock + rq->lock held, hard irqs off. */
>  static struct evl_thread *pick_next_thread(struct evl_rq *rq)
>  {
> -	struct evl_thread *next = __pick_next_thread(rq);
> +	struct evl_thread *next, *prev = rq->curr;
> +	struct evl_sched_class *prev_class = prev->sched_class;
>  
> +	if (prev_class->sched_out)
> +		prev_class->sched_out(prev);
> +
> +	next = __pick_next_thread(rq);
> +	trace_evl_pick_thread(next);
>  	set_next_running(rq, next);
>  
>  	return next;
> @@ -972,21 +979,20 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
>  		return;
>  	}
>  
> +	prev = curr;
>  	next = pick_next_thread(this_rq);
> -	trace_evl_pick_thread(next);
> -	if (next == curr) {
> -		if (unlikely(next->state & EVL_T_ROOT)) {
> +	if (next == prev) {
> +		if (unlikely(prev->state & EVL_T_ROOT)) {
>  			if (this_rq->local_flags & RQ_TPROXY)
>  				evl_notify_proxy_tick(this_rq);
>  			if (this_rq->local_flags & RQ_TDEFER)
>  				evl_program_local_tick(&evl_mono_clock);
>  		}
>  		raw_spin_unlock(&this_rq->lock);
> -		raw_spin_unlock_irqrestore(&curr->lock, flags);
> +		raw_spin_unlock_irqrestore(&prev->lock, flags);
>  		return;
>  	}
> - 
> -	prev = curr;

This hunk subtly look like a pure cosmetic change, without any logical
impact. If it does have one which I missed, it should be explained in
the commit message at least.

Jan

>  	this_rq->curr = next;
>  	leaving_inband = false;
>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
