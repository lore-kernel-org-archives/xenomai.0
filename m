Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728E222582
	for <xenomai@lists.linux.dev>; Wed, 21 May 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845155; cv=fail; b=e3SGDPvgIlG6ZnQlg02nhgw1TWJjVLADMGp7Zu6FiqxR5RRhh05pOiwPuol3V9AJ+IUJUmFJ8MjY1lVzBZR7SrvZwfKSgf7dxZglqa/sAq7Ax3ZRw8A0DAL0KjIHtpTz9qn2W5Gj7WR7oj74yonD2CdXzxk+z94RPKzi+j1S80M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845155; c=relaxed/simple;
	bh=gifQYSgya6q0mVbFFAubaqjRCAqkcpkXGRhnnBFoEUU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DDBiIQmF6TDFRKIwZ38UumCc/OvdBrtS6Linq2USsSL3hIkYB1w+8b+XGUG4qbW6333KcEQ+BovtYqCDJxe64Wm8oHL+mATgg6OFXdTdNXvZ2PfCOlcT+mY2LwykAp7fwuoFx3DR5+a6W3bKjlILjLGmEA+OfzvK2dY0mXnY2ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sS6wAPxJ; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sS6wAPxJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+j8DPnAEXs4SdaEhLi78uJgmxI9RkFVpilyF2ZFBdByI/r/GOygSSLyDqPDcvu3Vy2asMFGi0oqVrWEpdZ/0L07S/VPtVyY7ohVv5CxfLKdz/ZSAzSEqMZH51SBcNwiTG+HblbWi5eIX1C3KwKH+yL/PXCu7wQVXSlPdrENs1Ihfk9WrKoU5PPkVyvgwWvvOgjobeVw94md7yCrCcyblCLNqKN39yiQSUeuN5j9+lnfSfc/NYt89dLdWjCQxo+BFZiKYwvRhErX1oE9xavOwYILK40r1v/AsM3jTEUqgJyFA4ks0c9DkxzVlTM0jc6nYCbRRfpwNvlmpFOdFj2YTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPbssqgg0QpglAjnxEBBQQ49LzHx6a/wD7y1t0h3Y0k=;
 b=bV6kE8Bbgvn6Tlqr8fyxhqmH7pj6/Asqj4zjReZYJTArPAAE+DseqtzSj8mZ+/70fvDtDvnjwBLqz8HBczZfXI0JfDgmPkriv8xo9Q1YImiKQQTxLFrAoP7YD2E+24A74ZCr2zp4i6nSzxSM5XZdtQAwfq76rUd2ZH13swGjxa6zvWRR/MTeiPeucLkf9piUzYOWsUxfwfPyeogUBu0zZT/+bpSQUt4aDl+t4CjgZdXN2meK2eQwSyOgKxxAWi7VMA/3ZeaMR4XSDXQyI4Q0UikPa2RwDb80rUoC16AC6LG5IW6OqnafbYSAdbbDTRtVx7MSonImQUQrB6Li+UsRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPbssqgg0QpglAjnxEBBQQ49LzHx6a/wD7y1t0h3Y0k=;
 b=sS6wAPxJzptwDdIINseQxaKZ8PM0Vc6KupIFa93+V+Q8LvAZ5bTvPYL5i/Fdhess9LKEnnRtaYwoeTrd6o5zoZwi/UFjlzFu6tCvWgyEE9rWu1iY+HajZkxGJVHFEMVYg+oWD/cj2i+5FUbwDWf+xiQaQV9t1xM8Q6BMWUih+C8uYwkf7p5EnsSjfxL06HSJ1BVEogty/paZFzqW7emiwyhG3mpW1dRPSC40b0Pl1Z4UKOofHXb6xuoDhjJO28XB5LOOebbWwh67gRMiMTjQwhcTm3Um5vDhCCt6bQQb2WEpF8UwTVbEVcAnCs2VTtPhVVBfne43KSmI6fCJ0hwigA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:634::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 16:32:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 16:32:21 +0000
Message-ID: <f011dc68-e0ba-4fee-b3e8-00d135f2e6b2@siemens.com>
Date: Wed, 21 May 2025 18:32:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: schedule_work() from primary domain
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvxhk27ps98JL0afZx1+iecouV2NFsDHv6Ccp=zpn-yESg@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvxhk27ps98JL0afZx1+iecouV2NFsDHv6Ccp=zpn-yESg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 0011e991-9684-43c6-dca2-08dd98850f1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGhPR3pBNkV0N2ZrUDlvREkrRCtYNjl4c1lYc2JyNnl0RnBiYUluMHViU3NZ?=
 =?utf-8?B?a3l1SFE1MTdQazNqUkp0NElFa0p4Q2VjcVZ5S1RwcVVVRk1yLzdvYzdRZWh4?=
 =?utf-8?B?ZTNGMzBDMEpyZkZWV08zNEFvaHF3ZGtNWnVqTG1zM0pIYjlSd3NBV3NMVjFu?=
 =?utf-8?B?alRqUDJQUTFGTFpGckh6clFEenFLMmF3SzZZaVRoZDJmcU5OYWtiKzlLOStu?=
 =?utf-8?B?R0x1OEg1YWRwaVphZlNLNXhXczNEVFl0c2JYaFl2L280RG5icU1hbmUrczN1?=
 =?utf-8?B?NXFMYW9KK2kyZnFvWDJoYWd1N0JLbWgyekF0Q0sxZ0FZbkVCVjhBWmpaTGxG?=
 =?utf-8?B?aWlZSU1VUTVqRWZQeFNCdkFHUnp0d3UxTGJRZzRVcUxpZlhLMlBNSHdORm9i?=
 =?utf-8?B?amY2WVdzSEZNaHhLUVRKVFB0MTNEOGFJbHNlR1FreWp3RXhNN3FJVGg4TmVL?=
 =?utf-8?B?SkdFdEdHQndQM1ZkZzVyRlJqQkMvR0F6dVZWQiszaXZVa1g5QjZyTzM0RUxy?=
 =?utf-8?B?cEtqRVNkSlBDOTI3YlVncFBIaFh4TEZpblorZTNNTVN6bTZhNFNjVnNlOFZl?=
 =?utf-8?B?YzlEZ0V3UXlOMWM3Qjg5SWVtT3dMWG5zTGx2Q21GTko1Ukg2SCtmbk5kbGpo?=
 =?utf-8?B?dE10SkljeFJHbU5RZ0VWZkhwTVA3ZVBCQnZnUkVJbi9ZaE92c3dQRjBMM2ZY?=
 =?utf-8?B?T2pxSlh2U0QzVlJNVFdDRlFQcGxacU94U0t0TVdlMm13M2Q0T0M2d3QyUmtj?=
 =?utf-8?B?THVyK0FIQlNYQWp5RjBIRSt0YllCc1dsVnJFTTJsdVdEcVJNQ0tvbFNTQzlC?=
 =?utf-8?B?ektiWi9oVVV2RUdtV0o1Y010UVpEWXR4bWpPZ2tsdFdJU0lZM0gwa1lIUTRE?=
 =?utf-8?B?enF6aGdPUjhKNEwwcHYzTTQvQmJSZGcrZlNlVEVyQ2txS2JXV0hlMkZjL3Mx?=
 =?utf-8?B?ZUR5R1VvV1M0NmFRSk40N2lYVnZBM1pJYTZMak5PWUd1d3hPb1lkd203VCsr?=
 =?utf-8?B?QUxPWmVMR1gvSzNmekEya0wrZDg3bEo2UzlIemM1bGtQWCt4NTlUMjNqckhk?=
 =?utf-8?B?Q0wvV25mU0V6a3FCbnJDYnNiNFJ2d2tiLzI2VE5ybUFRVXp6bG1oSThtODM4?=
 =?utf-8?B?RTJkN2d4d0JGVVU0dlJOYnViaUwxNzhwNlk5dXVzblRrb2pFbkJYcmd4TGRW?=
 =?utf-8?B?Y0o1YXlQNVBBeUF3UkRGalVCdEl0Z2o4Mmp0VUtkMUdweitLZE1hK1FvaUNK?=
 =?utf-8?B?dENnalR0MHdtUTNCLzdadnc4dE1lV1h4bm9yYlFHYlc4MndEMWl6bUpWVU1n?=
 =?utf-8?B?UXpIcWxQcUV0VVlWUDAreXdzNlB0WmdBSjhrS1Nta3JkQmdyNzdFMHBoMkJS?=
 =?utf-8?B?bU9LU3lDRU5ZU1FyWDlZeG4yR3NlNlNxVWJmcU8zVTVhNWIra0NXOTkvYXE0?=
 =?utf-8?B?YlkzbG9xZjlTaWl2Q280c0Fhc2tLQWRyczh2SUoyQXViclVDeU16T2NqZUFH?=
 =?utf-8?B?TEVCMy9mMytobXRhbXdLeW9EYUxFU2VXK1lTMkpCSGIvR3NGMytUbjRrcXRB?=
 =?utf-8?B?anMxc3ZzakFZeDF6VE1odEFVWDM2cThwTTN4eGZlZnR2dmhRUklDdTZLbk5X?=
 =?utf-8?B?U2tJSWtaUXR0dGdQYnlTQ21Idy9MQTRPcHg2cjY1eEJZaEZIZGdXUTluQWtq?=
 =?utf-8?B?NHdGZjN3OWFBc3FCVEVjMXVBdWVjRG9kWiszRHJTdTRObFBhcDlteVdHZ3p2?=
 =?utf-8?B?VjgrblpYbk5Pc0F2WmF3dWdYWjNWdzkxMHRGRnEwbll4Q2REL3hkVlNjT3g3?=
 =?utf-8?B?M2hnWG5HOStRczFxc0RUWHRWc29yaXR1aVVHbk5JV1V4Y3dVNC9QOTNIdjdM?=
 =?utf-8?B?M3pObWR3S3pRZnJZdHdaVm1xenZnR3V2ZHN3SWwzaFF1WE1nbWJRVVdkOHZO?=
 =?utf-8?Q?+fPKQIeKlNo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YURTOEwrNnV0ak1xcWp4RSswNmxBWUpTb1JvM3cySXhIV1huNENCRld0aXJl?=
 =?utf-8?B?UkZUZUExeTdnOEhycFRVcUs0TjlIanJJOVVxS1FyMzlCaEp6RGdkRHFCbitW?=
 =?utf-8?B?WnVIRlhNa2swV0gwa1hod0ZuTndXUXJXSGNBOEdHMklVcGxTaFlubUxVZ3My?=
 =?utf-8?B?RUhjL2ZmM1dENnV1SHRFSUxza0pIbWVrTUNTNmZTRS9vRUpZRTJsbVdLU0ts?=
 =?utf-8?B?QytIQTg4V0p6TWxlb2JHY0VneDBxQ01FaHdhcHMxR0tqbGN0UEs0NzJCUUpl?=
 =?utf-8?B?UFlDRmJESUFwdFIwUDNGaE04TXgyMU16RUIrMmJXNU9QRCtvaUpUK0lLRHlH?=
 =?utf-8?B?dWhPSEpVNE1ES00xUDh3MVpXT2JJN1htUFNhNHdyc2MwV3FRUUFmb0RmNms0?=
 =?utf-8?B?NUV0YXBuMGZUaXo2bmliYzB6a0hFUjNwOHNJeW4vQTFzNTJjbCthcGs3QVJw?=
 =?utf-8?B?WGhJcERmbnhQSGNGSG4wQzExakNya2kwTktkSXhlbXMyQWhiV3RYNmVxVklS?=
 =?utf-8?B?Y2JiTElaQVRqQlp5d2VCZXhHSFJ0MW9hUS9yOUV2RDc0d3BCYmcwd2ZpQjc4?=
 =?utf-8?B?VitBd0plRElUSmVXbEd3VzVlMkk1M2lla0xnU1JmN05GOGQvNXJ0ZGxEK2Mr?=
 =?utf-8?B?YUNxcUd6MWRMVk9PWDBpeEh3Z3Q2bTNWOU5MaGFqc1EzanZWK1NwK2ZEY1RL?=
 =?utf-8?B?VjhrK2EycUhZVXNOS1pxNkJwL2RIaHcxeHRDaFRSbUx5TW95TjZjRnlreHE0?=
 =?utf-8?B?K3JmbXpaK05lWFlpTXhvVmY2UC9CeFVLaWtFcXpqbHl3UFZZMUFuWUdjRFVK?=
 =?utf-8?B?OVVSUi9aOEtHeWpic1BpaDd5QVR1TkZxbFYrNjhJbFd6VmpUNS9VdE1HWGIy?=
 =?utf-8?B?a0o1UU5ZZXBzRmd6K2d1Rm95UXZSdDY2TUQ4cEMvS3FmL2R5VVdiblpXckhX?=
 =?utf-8?B?WEw4M2h0LzJ4dDQ2TEd5YS9jaGlTQzJOUDVXc2lmYUl3WGJKSkpYT1FrUVNr?=
 =?utf-8?B?ZGJuUlRyNTBKbjB3ckFzUjMrejRyOE0zQll1WlE4dHNKM25WQWNWYXpMUzFU?=
 =?utf-8?B?S2U0YUUrQWROamlPQXJYSFBLVndZWVVIdXB0QjRMdlZiUWNJK1ZmZGIvM3Jq?=
 =?utf-8?B?UzRsMmh1T1FLaTk3dlFmQisxSytKZytQc0Fzb2dSMDJUY0w4L0c5Q0JRRDJi?=
 =?utf-8?B?eUxsQUx1TXhoKzlaQVNEWXVGL1QxUk5hQjBiVjU5TnVmb010SmgxOGFER294?=
 =?utf-8?B?bHc2Z3NoY0gvTTJRNjhkcEFHaW15TnJCMFkwWnEzUDcrdmZEeGVQdVNFMEZi?=
 =?utf-8?B?RFhZYVBFaC9EN3NZVlJPYkttbDNIWlJGc3RjcnExM0diQ1lxbU84WnQrckQr?=
 =?utf-8?B?YitYZmpLbjNwOG85eGlKb3VqVUNiTm9JN0QyR01UbFBERzh1djlvQkc1WTlX?=
 =?utf-8?B?dWs2a0M2ZkVLaE03bjhDWlpOYVA1Unl0amlnU2M3NkVIUVdyNWwydTlLb1Rv?=
 =?utf-8?B?N0VFVWdTdFpjVlI0QTRScmxSSGtCaktHNFh5U0FWeDRIKzdXNkltRGM5WkFL?=
 =?utf-8?B?U0p6ZmZ3NFpnUjk5SjIzMVlMYWlWemhuaWUrZXhPZU1wdnJiY2RhdlhNMDVt?=
 =?utf-8?B?azdRdk5GdTk3eElkYy9zbitUVnc0ZzZuWUk3WVRza21XUE5rRW9pSWo4L3M2?=
 =?utf-8?B?d0dUSmwwbC9ENzVVL0cySzV3NURrY2hzejBQd1ZMUEErMnlBS1Y4ZnNrZGJ2?=
 =?utf-8?B?ejZsTXNNM0tCcjBlTG43VmJLTUVQNm9qVEZVU2JYaWQ0U2s5Q25mRVM2NCtX?=
 =?utf-8?B?VjF4ek9RdUI0WkU3NkVJeGM2Z29nbExobVo3aGk1RXJUV1dSbjlJMEpGS2t6?=
 =?utf-8?B?Zmw0NzZWZUFzamlQMEVwRUNQV1lrZ1ZzSEVkVVhKemQ3dVdFUGFlYnpndWwv?=
 =?utf-8?B?dTFYVnhlOEU2ZzJTOGNvVzNaaTZvV0xNeXgrY2hEeXBiczBxYUtRblpTQlZE?=
 =?utf-8?B?ZldzOHNFY25mb0FEYVptdWhNSW1qVmdBWU9zKzQwenhicENLOGJyWVlXR2dQ?=
 =?utf-8?B?MHdqN280UHRkdzNGUzd0ZGZ3azUrakZqcnBFbkxSbjdFR3drR2I1VU1lZ2lX?=
 =?utf-8?Q?EdH/Oz3hq2jV3awJivcix73qp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0011e991-9684-43c6-dca2-08dd98850f1e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 16:32:20.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP/Zod+mimBqcfNbmUzYpBoTzdMTIQGcC1DkIpoUWeV/PIpCPnChG/PdXFvG1U7ajvJbmM/KJ5WHR8eJTMlb/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7683

On 21.05.25 15:40, Richard Weinberger wrote:
> Hello,
> 
> While debugging a crash, I realized that calling schedule_work() from
> the primary domain is not allowed.
> That's why we have rtdm_schedule_nrt_work(). So far, so good.
> 
> However, it still puzzles me why exactly schedule_work() does not work
> from the primary domain.
> I always thought this function more or less just appends to list.
> Is it because __queue_work() makes certain assumptions about the
> interrupt state?

It makes assumptions about being able to trigger in-band rescheduling
when lifting the preempt_disable while releasing a spinlock. What you
need is an NMI-safe (from in-band perspective) trigger of work. That is
what irq_work_queue->irq_local_work_raise can provide via the dovetail
changes.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
