Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866343DA7FD
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519292; cv=fail; b=i+ZVNR0DO1vPoJ/CiJgsrPqRJ5XCMnBBbyVNc0wrGoxxyBPO0oK+BlLjVSQv/8KJ+pu50mLre882il6tsFfX717FY0wvn5VemrzFZ3B/qtHxVhh591VyFCs8t8n2gxrg7C+ky+zTmtArHUu7SqfiqGhQBCbYzQWMaAjXA0m5Xec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519292; c=relaxed/simple;
	bh=4F/UXGoA3l7RsrFVseBdFG7fEESf1BHhF5sn7OjWinA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c3fO9rjDJYaElTifLBhy9V9BTp9gEdePSAsZ6YP8sazkvQiM0hY+gs/YtTY20BZxLp/mOPxYG0R8ysKqAHT1ZYSDMT24S6GqCHULLVAJw/D+IpWScE31c7+FeSnjH7ueoDaV6qUAzWS9kKU23crbxQV5Y6/86x3ggZtGRNCv0cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JFvVXGas; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JFvVXGas"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csOTh7FLIxiHF8AT/K1ShR0hQ34StfAtW5G+1IQnQ15i3+7dHv8lZr5MJYE9K0B3uPYDEnKpek5Qsuco1v94PiGBxiLTjXBgh2uW0fYtDN3Foya3elFYWhLNankuu1HuRGgJHcwJJg1osnMj6mBrfR16YsRwyXsy2X84sErZuc5mTsTr5T3Eic6ZJ46yAJDKToK21dWDmLag5vluNVeIGbi7oiS6cXBfDDUvPOxU5c5Gn2nUZ/nQoULoyTpUCr180RjWVkBl7Hpbg0cao+Cm+MJmqi28r22IXB74pA5r6IHwr48lhJB6kNuHi4SVVPnPXyJ51kVPr22/Ftj5NdkqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nLH+/bfAEl1fO1+a9OnP0ykq175Mnh8Z+SmIV0l6v4=;
 b=dUqamr7I43Z6D7uyeCYAQqCRMkY0ZS7fMBVSGbwo87EVHLimEkTx4tRPgmPkZ4u1HLXcLz/7JEvboapP/Bfwxi0a9hbbabSxRidbufHhIZvkBFD8k96X25WB8MSNV/MZmRriKt2h0TWQigVkUPVc0WYxxsTO2I6Y9rWf1PA1679CvGPE/yyfITAH1wlh4U8CtZw2D3D8VQrL+Oe1BntXMi2Srz59A5gC1wTmNyuqSR7fmN5theYChEYYDS68jjiAwtPumRzhZY5p+4u5FAATA93auIeSLM54gSPghb6WPjDP/9OK34DFANeAKTfZxT2ohqB2Af0pjOLhMcO0kzFxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nLH+/bfAEl1fO1+a9OnP0ykq175Mnh8Z+SmIV0l6v4=;
 b=JFvVXGasOgUfCk1ogZz+JewJ9mHY0KCwsj4wbjH/OkWeOOXByRCh1EbH9+ytfwpp+JaLAAF7mZspw3MdVyKsdTVNJn/vSeMGUHbC49pzUk+tu0g8eceaDdnNGM1QdDuRnkOdmh28TmLMd1h+j5O9GFRfRVYYxzGlJUQ77Hg2LGzCN1ldYx2L71x01LR9wQHdKlmsLmo8R5P7YuoVnpUq1I2r4GYN2B5b+YFOOyITmEB/1Jyvo+SAqap4+Smvif3gkuzMxtCxG9Z+MXci/8+JTpjy101T161OLiAU+1Yy9YdJBgGRGFVdW7kwvIyeSYcsH2H4L/F26u58h3VUiSihDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI0PR10MB9172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:28:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:28:05 +0000
Message-ID: <d350aa9a-ff06-4761-b54d-f167888d9306@siemens.com>
Date: Mon, 15 Jun 2026 12:28:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Possible Xenomai 3 latency regression on arm64
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
 <87tsr4fe74.fsf@xenomai.org>
 <28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI0PR10MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: c37446b9-dbc6-464b-7a4b-08decac8c96c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info:
	rKtLGOTst6NYY4tn0gqLOguuFPW+g17dB/UY0mwrp2vTYXpUsfKHswXBgk1Bs6jyzwzs+Erd9uRYM/gRt17X/HC9YP/6xMHN0oG5Z8B3roxSHuklIjrG+czKOOjyZwLv2Dhx3N1vyBzoWhgmJCek//mCBvF+1eL2fAifWOscIERx38VFgVrITjhqjkVngyU3cNAf5+jt9VS9RehRMoZv+piiiV+FVDzzFeIjZsfW7MtmpYOZlrO1O+0HB+ePNQ39Ok0lkEVulYyguN+WeJppiRyCYRZMGAq/U/SOFihlQ3Avc77AdCMF8+gjBzQsS/mhgMBZXXTzqzONaNMsQGTzob36/W84Xwn6bk1+AU+wnbJBA5uz9eIZ7T2OibJiJhbJvlOgujAADjrU8t4tVnbr1viF6rbyZs9xaFGPcZKYaCINTduOm5zdbiPXmNXbEagh5gSHroKn6aBe0w3NJ0ahEq6+HMJyIazRmEJujZWkbG559SuVP+ZHi4a2gmZzgJD5P7Kp1EeS4uPplteimMKYT1kEphY7tBQ9IO4UTIZHKJqdI4lZOsgf8r8hxsSEKKj15oKcHVwkWfalhOPEsMiwwvZCpm/3KtmUkl/wLCqI3BGNukezO8EUABi+18mTjx2GTl6agcIqtMKWOOQCsa0p4N+Urj7v8PrnBtD9NBDnLnMwxOqb04S/N8NK3O0eZ2OW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekQ2cVN1NU1EaVNJMjlqZHN5bkV5OXVZajFSdkp5bVFjcWhtOFNpalBkSWUr?=
 =?utf-8?B?UU8xcDJWSGdhNjlRa1ZRQzBnM2JhSVEvWml5OVltdWgzckZXcDR0VHlFWXJS?=
 =?utf-8?B?RGVJekwrUUVBR0NvSDVCUnliUFVsUHROek1FVyt4Y2ZBRm1Ga0R6cExXTTNP?=
 =?utf-8?B?TFlBVFpSK2U2M2dvZGVtaGg3OWwzTU5ldXZHbVhsODg5b3hib0t3bTJqTmhq?=
 =?utf-8?B?UVdJM1pwQzZkL3BlTXJ4UW1lTmtheWpsbzlKaEp0U3lOK205eXlQaFIrMTBM?=
 =?utf-8?B?b1g1V0FCMkRBWUQ0UVlNRHZQbjh5OFpveTEvMTBoT1Q1Y2NYMXJkNWJ4MGtR?=
 =?utf-8?B?R2RjcUpvemtZYUVpa1p5aGR2eVM3UHFsVDhWVEMvUTVEcWxteGRabEQ3UEth?=
 =?utf-8?B?Vjh1QWI5NjI5ay9Dc2dnK0dZeGw2K3ZqeVBuMytBWEd0YStOVDg2UEIyV09o?=
 =?utf-8?B?eEUyc1dmZzdpa3hOSzlNSnM0MDVnVUplYVJFWitQSkkvSCs1eTlwamVabXZ0?=
 =?utf-8?B?dk5ZVXZDUVl5WE1BQjJSUlpGdTg1dnFuNEc2cEkxdEhBRWtYRkZvWjcwcWpl?=
 =?utf-8?B?cStKWGtmUXpzS0JEc2ZGaGpSbURUd0t4dEYzWWdMNVRoOTQzY1orOUNwVXB6?=
 =?utf-8?B?d2lpMmJvZlJ1eXltS0prWU0vajJvbXdBdG12dUI4VEtVakRPZkZENDI1NTVo?=
 =?utf-8?B?MVArTVZrTDFYbjZtY0NnR1ErZFRiTHZWVG1GaXI4L2FzUm9GQmhGbWNvRG1w?=
 =?utf-8?B?SnJnMExZZ0hzR2VkV2xhRjNETHdQa2lkS1BaWnhNNCt1dlRyOHZvSUtua0dQ?=
 =?utf-8?B?SUh1Y3d3dGFMWE5CYnpRcmZIcHNYT2JEdk1Cc3MzQlVwRUM2dGROT1VJc0RX?=
 =?utf-8?B?cE9yemc3cmxhZUFVMHRLdnRHWG9Pd1I0VEpNNDRsUWJiQjAxZzNFd2UvN2li?=
 =?utf-8?B?bXhLRnBrMGFMRFhva21DaG5lR0FON0dwVHBYclBLeU5sbjBRZUUxK3FoTDJu?=
 =?utf-8?B?Si9nRkxXSDVHc3BFbmlSSTkrVlhRNUxMV1FqYkh5WkFMZXlaNHNlbHoySVA0?=
 =?utf-8?B?L29XdXl0OHpTYkZ4R292UUZWMFkzWjN6eThHQTBlbDhlTVVXVU0rSlo1eU0z?=
 =?utf-8?B?NVp1OXI1WTdva3dWMVVRSFl0OGREUktRRzNsbDFZcVh5Vi9vTk11cS9Gdzhm?=
 =?utf-8?B?bUhzUkFDdGdRVFkvNEptOEsrM2hJcTNRTC9IaHJpMjJ3cTVTeFFpRkRkRlZx?=
 =?utf-8?B?TUtmQyt0ejJYZURtUU0rNFdONFdaVEw4cnNiVnRMRko3T1UrbkQzdWFLbThI?=
 =?utf-8?B?b0J4bEhtUmpsZGw3dG5XS1UxbnU3cWttZG9lb0hKVVNQcmxsRFZwb3Y2a2M4?=
 =?utf-8?B?YWpaTEQ0MzJlS2dMd1EzREVSRzFkTWZDTXJMbFF2dDFHU1pqOHZUQWpTaEZ6?=
 =?utf-8?B?RHRBZ1lmZEdRUG1kaGJ2ZjRUa0dJa3ltaEc4MjNjSGc0dC9iVG1mWVFLMlhq?=
 =?utf-8?B?T1QrdHBBMW91T2xwdURxUlVyOXYyM2xtZXBVbndMbEZqTzFINHhuZWdRMTdU?=
 =?utf-8?B?ckZqOWh6SUVJOXVQUlA5blFKZkR1bUpTNy91UjBNeXh2ckx4UUEyUHV2bCts?=
 =?utf-8?B?US9xMjRhTmFCMzdBdS9DUk9zaUxjZitKU3hMOVBzOHhJM2ZOeTdrR09yVUY1?=
 =?utf-8?B?Z1dzUlE5dGV1dUpmQVJLMnFlUFpxcXFSaFFlMStyRmw1dFhZTHczV1RIanZx?=
 =?utf-8?B?cSsrRUxwTzZ2akpBYVREMXM0T2FldFVxb3ZTcDY0NVF6TklGbnhyaWVPQTVC?=
 =?utf-8?B?YllISzRjUnhOL2lxbTNjRzEvZ3ZWSG1jRTNzVUlDYStkRVpnNFd3TlVSWGZS?=
 =?utf-8?B?SUJ2UTV1TlZxZjUwOTQySS9nTkc3T01zWUFHaW5rZ05KMytGWWIyVGxtTnUx?=
 =?utf-8?B?MnFvNjN2UE5HbFZSRHZHZEJ1bzIyalBXdCs4T2Y3NDVoblYxM0pLanNRZm5x?=
 =?utf-8?B?bnJEczZnWHJIaDVPNUJ5UlBsaFFjdjZnWUpGMENxRlRSU0RpTjRsMEQvaDhZ?=
 =?utf-8?B?MllaYU9vQkxxZWdHNVFEZEVDRk91amJ3SmJFdmpLRzE3RDlMTFU0bzRPQXg4?=
 =?utf-8?B?VDFJMFJmNm1YaTFWNldDY2Z1L0k4enlrR2V6amZ4cUhBMEM5cjAvSXpHZ29I?=
 =?utf-8?B?dWwrcGhEWCtuR3hUVjdEZkxuVXhCU08vNzZCcGhaR2VlajJHSzJCZmVYYU9u?=
 =?utf-8?B?U0ZieW1RQkhiS2V1RS9JTWtjWEF4Vk9pYnpuclh3R0NVS0dJVnVYK2owaWFU?=
 =?utf-8?B?SUV6MXc1M1R0cG8rSG53OXJ2Q3RsZlRkOGQwcmNIWDkrZWV3b0VSanhEWDFx?=
 =?utf-8?Q?lK4eCavjwp8VJEl3b3Ncs4c8u/qeU9UhEYOYbQWJEgOs9?=
X-MS-Exchange-AntiSpam-MessageData-1: ojkrqCtD+BDHB90qVdf3QshRznOI73dyFu8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37446b9-dbc6-464b-7a4b-08decac8c96c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:28:05.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIVYDY6+7J2MNG/t0nybfq+ZqznM8x/dPiiC0dDx/D+X/cP4Q3w602jwXZxmvTrYdiV7cTTbAQKrYX3hGqOMFIqrnZBuIwSAR1nDzUK1snI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9172

Hi Jan,

On 6/15/26 10:33, Jan Kiszka wrote:
> On 15.06.26 09:35, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> Hi all,
>>>
>>> it seems we got some >10% worst-case latency increase over the last
>>> month with Xenomai head and 6.12 - that is at least the setup we use in
>>> our long-running weekly test.
>>>
>>> Tonight, the RPi4 test triggered by exceeding the configured limit of
>>> 150 µs [1]. About half a year ago, we were in 130 µs range with it [2].
>>> x86 and beaglebone are apparently not seeing this change.
>>>
>>
>> My rpi4 fried. Is the issue visible with x4 as well?
>>
> 
> We do not have long-running latency tests for x4 yet, do we, Tobias?

no automated tests in the CI yet, but I already discussed this with
Philippe.

Plan is to move latmus into 'evl test' as already done with hectic.
Combined with the backround stress changes this would allow similar
latency tests as in x3.

I will try to jump back to this topic as soon as I finished polishing of
the riscv patches.

Best,
Tobias

> Jan
> 

