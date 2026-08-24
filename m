Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87840407582
	for <xenomai@lists.linux.dev>; Mon, 24 Aug 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568220; cv=fail; b=KElzRMve4/D5cuvOPFjPzzozcnmOqPH9nOObImgIEYf+7hojEKEy5Ha5cQCqwM9UG6R/WWLZzBO2hGnA9jvqaiJ4INZ8+Gx1aiPnNPBLYuTylbN4HFA9RyrYlH+XXId61rdotk1hDrn4AF6ArKFaiCKuT7n/4HoxV1Zo5vl/0M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568220; c=relaxed/simple;
	bh=33N6LRFwXOtBDwnNG/h5wXxDrtxucf+MtToRES3ubeM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5YQaU/UvXopKT1ycyjI+w51bikxGl6vNuMpc5gwfnB5chlfN43IdyIO3jgDCMhLFy3lnwXau5jiCErNaGI5ufSk2gkIaBh70DKf4z1votE1DSM0o7OELwBmwo2rr7y7P9dnAOCpLkpGx62fV8OqhutM2lTDM0G+JctEXPg0hwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VR1bIKsY; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VR1bIKsY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwuJe10FU7ik543BjO/LmV7PNRqmo9JqaFuWAVc3prNqNnVIx4RWWqpNsZtG8uRyIpYGjqmA1IGmcMR8Gy2LundByVIuNN/BpO/BCeELbFtIbgbUwE0pfG5tg2BSK9svfsJTxrVym+ZeWxAhKivfAqwgJG5sDFoLM/J7v0iS0bQ/kNtFRnDAszauVcsKYDgRDV9PqiLeWu1RHdWB9Ln+v4iPu0PXwYBY95hv/LlsNpA5CMtuV0VRcHuaB05XkA/DwPWUSKU5j+0Pf+D8Pzb7og6ursogKV45CkW7d+4+L6/K3Hr8uZud1H2V3JqyjLsBCVyvg6/ThaJ04YaVYofNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2IZXO+2vTcAEzzuEZ60kAbxw0Uko9450M33uxWJvRw=;
 b=KG/Or7+ESg948Jqy4EGyfjXA4r7AZpuOgYYPME/M1ifQWa2uDoRWzhgC2TAuTdCywzorLowd4U9NdC9sfcrsLIFemv5X9FKmnFEUo8oQbjtXfI0UFqArNPaWBmbrc1tQN8SyoyLpwVFeER7W41mKYB10m/mFL6SshWDGefHxHvuwbEGfbPzVu0R8h5AGGX+Zktbywzht+w+T4oJMGOc2p0BxMuWCOE37Zr3tQ5B66Eyy293nN4ZpXQ+BjMzGTKEb1BRZx7VmD9KsD1wXzD8Xeyk/J5f8+JBr0XGSBxH7YGxcOF4Q4lvxEwHmmQ8r/WOGrmFY//pfgWL6t37kJhPZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2IZXO+2vTcAEzzuEZ60kAbxw0Uko9450M33uxWJvRw=;
 b=VR1bIKsY7rXwP4I6sUOjLl+1EStiSzW7NdWtkXMcGqhdKtcHHRCOJjG4xralx4K/P8zNS9RIOruEy5hGxadtIID8uwTJWmNhzctB1+6UAcxtizqiKIxZIzK/rEkIaOrX/YDs91CqYZUxty9O0mF3352dwPRv4FBXZ286XhePi1k9OAt5HvriRRDyO2TQpRONlGqlbmgfciW1Q4WORPIDvRWxrET2T+ySS4knjAqdBojrlI4/O3ymBauA56qj+O6F8vW3C+xDHpQ3UgsuNJozhtT0TcQ+IBY+NEls2gTVymJhwN3d/8vdb88qCrvZohxEI08SzRyzGRWsc2kRL/ukvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:505::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:43:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:43:32 +0000
Message-ID: <796829a8-f7f4-443b-8995-930ca11c7e6e@siemens.com>
Date: Mon, 24 Aug 2026 12:43:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kernel/cobalt: Address SIGSHADOW_ACTION_HARDEN and
 self-hardening race condition
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <48f88dbd-c051-4eb9-971b-d0518dfeacf1@siemens.com>
 <87bjefs6cw.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
 <a006030cc98da209b4764b5117c41d93fa3d9399.camel@siemens.com>
 <535f40eb-3af9-427e-85db-2afaf69b847e@siemens.com>
 <87h5nvl5ct.fsf@xenomai.org>
 <2894b9cf-09c9-44ab-945d-cb3edbe5fd60@siemens.com>
 <CAFLxGvwSE28X_PG2NsyhnFxq5SGjrS3WH9bhJcX4gyrroV2z1A@mail.gmail.com>
 <d8c7650d-d0cb-4fda-8664-177adec000d8@siemens.com>
 <CAFLxGvxXvMq5THr1i7u5AFUu2SB=HgBA7rikBMM=Fa0nskz8UQ@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvxXvMq5THr1i7u5AFUu2SB=HgBA7rikBMM=Fa0nskz8UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1364d73d-2349-4d8b-8920-08df01cc8ad2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|55112099003|22082099003|18002099003|11063799006|3023799007|6133799003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	95b0RyQBTIwYTdc28g7DYoPauWQQBNw2P0zZBkTu40FOTi3VtG0te298HnyJ0PGfagrH4BOXDLujDKNDuH2HZfHL3ZG2HRjRb1JwL5XMzZ+oG7ydLDD+Nw7VTD7mml5Gksek3p23Wf+T6eaol6kG2ISjoJnGdpalJEOTxdukckq1wts7fGAGonO7ffwQyHTJuYhrddFhDTKqh8AbDJw+j5YZ56/ktQlTlbn3sTsADG/cjyoBlwrbIhNXEEjoLZvMJiS3orqR414l5bxCUNjHqCao8uWpd84aUREpMe6HEsY9vqA4WROVeZVgTCezdmjz5pnJxeJDrgMW7lBtqgGrR/L67RRT1C/yt9wTDwcHEDTyhz38RJy28U3kMXARtzOiPszu9N2VGvKr8kYhyymShOGt0y0T4Peup6lc7Uwvl6RXfPrFiJ5crM4MShWKIP10GQ6JRodYSQXBgT6stPoIwH6/fDnAUYQEgzmUMQ9+oJ1rAh6SPTzDuisIOoI9aQUAxznvvNLMWboOIT6ExZCT3yU1QvpopU/4YpLB2QLgb9FngcUI9FcacNgea2i6CrOd7SU//y1PUmBGX7PT8+mb5N2IkF+wHh/x0WNESz0Pa8xdxN5/8rW7tEINsJk6mRjxIXv7fvz/fmzzR+tO7HkaOZ9y+fHQpwrhOmumcZhvgWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(55112099003)(22082099003)(18002099003)(11063799006)(3023799007)(6133799003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBzeUh3dFlTTG1WNy9ramtXamZZay9qMlBQSWh6WHNRL1REVXBkR0tEQ0c4?=
 =?utf-8?B?d05ocU1SdjA5NmNnVUk3cjAveGNqZDR5NEpoenV5QlNIWWxqcCtPczFqMEJl?=
 =?utf-8?B?SzAwVkJIeWExSDZNZVAvNkdNLzFVMTU3RURHNmVraVcvNU00Tk1FN0R5NGw5?=
 =?utf-8?B?bWlueldrdlpyaGRQYzFyelFZMWZUeVR3K2ZUVEhJSFVEQ2llWDA5QVlhWTMx?=
 =?utf-8?B?RjBoSFV2eDdkZmMvcVE1OTdhaFNVbERmekVFbkttN2E2K0MyQm95MW9JSEJM?=
 =?utf-8?B?YnFBVnA1NVlYamdoL3g5WGJJTm1BWDdoZEovYldFM3N5UTlJVWJQenJoOVQ1?=
 =?utf-8?B?VytuU2VDL2ZieWo2cVZpUGdJUnBTNlAvdnBhR0MxcUY2S2RzZUVHNERIYjRw?=
 =?utf-8?B?cGN5dFRaZTNkOXZUdlYxbVFYTllaRXovWXM3RFVFVFNCTHJrNVdLbFVJWm9T?=
 =?utf-8?B?c1VKOGJVWlppMjVYaFR5RFFkTHdIbVVoci83aWtwM01xTWh6RGZYK1BkOUU3?=
 =?utf-8?B?QmJpbFVOWmh3U1RWN2ZFNTlCQ1FGd0VnWkdWSG1UdE5WOCt5cE9VbnV0NmlS?=
 =?utf-8?B?a3ZGaWxhdnRzK25XNFJCSSs4NXlqM3l2KytEQytMZEQyZWRHdmo2cDJoL2ZI?=
 =?utf-8?B?NkU4aEptaXoxMStUUEZNSFRuTXdxMlF1eVpQZ1BHelRDY1lhNDVkQVBUYzV4?=
 =?utf-8?B?ZWQ3V25MQ3EzVWpsMFdaWmVrT0lXV2llSStObnB3dkYxN0U5eUJrS0MzUU40?=
 =?utf-8?B?WGdyby9WK29mT2JHN0JIQ0pBWGkxQnZyZElkRlp4cytRREl1cENHbHBQS0lw?=
 =?utf-8?B?MS9rWWprbGxPTXRZM1p2T2dCWjZibzRZdHVweEdVRFBYajRnbjhFVFZuZG83?=
 =?utf-8?B?bUhlQ3YySnlqQ0YyOStRWlpRTEZtbGNoVGdTaE45cGg3ZFBVOUk3d2lZQk0r?=
 =?utf-8?B?NHNMcFdVbW9Ta3pHc3haZnRtVnRrcitjcFFmTVVPTS95UXJEaHZDczNGUmZC?=
 =?utf-8?B?aGhjRnZ0TkxoRUtJcnUzZDJpRXpEU3ZOZ25tOXQwM1FMOWNXVlh1OGJCOU4y?=
 =?utf-8?B?V2h0cEQwbjFPQmVYWjZudDlrTG51cWNORkJHZHBJQUNqd21FdmRDWVNHS1dL?=
 =?utf-8?B?Z01HZEdFdXpweFFOOS9UZHBJeHJGbUFMN2FMVGptK25nZThUVEQzSmJubG9X?=
 =?utf-8?B?dW9md0RGY2JZdnJBcFpkUWVVcWZHcFZCZmp2L1dkY1ZRL2wwdVo2RHkxUll3?=
 =?utf-8?B?c3g3ZWd0Y1JPUEl6akpVcjRabzl2VnZzZi9hdHVRbUVnQ2NXbkNZZDk5LzAw?=
 =?utf-8?B?d0VkUnA1QlBMYzZORHhNWi9LL3ZDQTBFTWttSDdpMWFOMkRMdm1sS3BpMHcz?=
 =?utf-8?B?c3pmN1I5OGQycjcvUTkzdmZ4V2N6NzdPU3RoUkhEczdXdlFRTERwK09DZDc1?=
 =?utf-8?B?MVpneW0vNnpUQjNWYVBKRlNib2xCTHJyeUQvQXhkYUZFZ3ZrcHk4UitTcGpE?=
 =?utf-8?B?N3h4SG8vdno2UWdkbE54d3BsQm81RWVIeWxzZU9rcGdtUEhaWno0MHhpUkQ5?=
 =?utf-8?B?a2JYaGVBV2xmcnBlL01qL0dQczIzNzZTY1VZVWRIOFdCOHR6ZjRYb045VGMx?=
 =?utf-8?B?RVl6VnpXVTdLbXF4eE5NY24zU2FIZVZDMldMZCtBMk1kcDJTKzJQbFhtd3Rx?=
 =?utf-8?B?UFZ6WlY0S2FLMldjbVVBNnlMd0pRUE1RU0NhNzVoZ3hkdjFFOEhnV004NVBp?=
 =?utf-8?B?VlZKYjJYeCtINzJWcEZOY3NCMks2TFZNUEpKY2lrSEtTeXk1V0oyaERaRmly?=
 =?utf-8?B?cStIc1BFRC9iVGdrUkZmK2FWOXc2Mm1RQWRIZ0pKRUhuKzVvYWlYZVp0Nmwz?=
 =?utf-8?B?WmpjVitpVzVaOUhqRHFiV21iLzN0UFFycWlxeG1STmZDay8xd0h1aXN0K3hh?=
 =?utf-8?B?WWk4MVFlczI4WTdxQnJxdERER2Q3L0tUazRYV3FMRm5FZHk5M3gvMHpiQnhY?=
 =?utf-8?B?ZCs4c2E4dGdNNHEzQjcwR251TUxJaDJSbU1pWFVoa1pUMkJ1cXNlNWNSR1F3?=
 =?utf-8?B?d3ZOeDRBVUs2SzMwTzhOeXFjQnRIbUZHMnlWZldTbEZ3dXU1TWFaL2Z0eWZr?=
 =?utf-8?B?RmxKKzdzUWwrQUVreUdvUU9xa3RWMW9FWnBQaXpwWFV2Z3lDK2FySXZ6NzBU?=
 =?utf-8?B?a1YrWHpzS3VkRlNxWkV5b1lVV2VYZGxrczJYK002akFsamkzbHVZWDFUdnhE?=
 =?utf-8?B?SmY0NWJiTGpTY0crRytLL2c5dUtQM2lYZHJBMFVGWjg5WEU0R01pV2s0VEcr?=
 =?utf-8?B?QU9raW1CM1hGK0FWczFTUER5NjIyblJQTzB5VFRpaEwxVnh0dEdPdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1364d73d-2349-4d8b-8920-08df01cc8ad2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:43:32.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpEDnANGDjbY9V/i879rGrDb2mSdZxT0XgC2Q3iOQF0rUmDskxOftIzythdLbvHkX+gEE74+BBUVqiNt3eYGoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5798

On 24.08.26 12:41, Richard Weinberger wrote:
> On Mon, Aug 24, 2026 at 12:32 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 24.08.26 12:20, Richard Weinberger wrote:
>>> On Tue, May 26, 2026 at 2:39 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>> Finally, there is a now a fairly exhaustive test in libevl to exercise
>>>>> this fix which could be easily ported to v3, see [2]. It managed to
>>>>> trigger several tricky issues when debugging the fix, so this may help.
>>>>>
>>>>
>>>> Thanks for the pointers, I need to drill through them - unless $someone
>>>> has more time this week (I'm hanging out at Embedded Recipes).
>>>
>>> After some time this issue re-emerged again on my desk.
>>> IIUC these two patches have been dropped.
>>> If so, how was it finally fixed upstream?
>>>
>>
>> That whole thing is stuck behind the scheduler fixes for quota &
>> sporadic because it touches sporadic bits (or would benefit from those
>> being dropped). Yeah, needs to be resumed...
> 
> Ok! At least I didn't miss something. :-)
> 
> The most recent issue on my desk is related to this particular patch.
> It misses the case that one could suspend and resume a thread before
> the SIGSHADOW
> handler runs. In this case the resume operation is lost.
> 
> Just to be sure, Xenomai offers no way to wait until a thread is
> finally suspended?
> 

Nope, it's fire-and-forget when you are targeting remote threads.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
