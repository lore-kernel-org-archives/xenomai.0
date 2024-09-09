Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C118C31
	for <xenomai@lists.linux.dev>; Mon,  9 Sep 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911924; cv=fail; b=PF7BSesJ6bhHONwVTAf24puzEqBHVk5ZBjwPweXDOgSIb1NKaciI/U9APkKXqtJ7JqZt4ez4R8V1F8E8oYd++ww2x8dsjctCKNWS1XUAK/N18c7Ocquo9QV7XG+FX6o78R7Y6ZCrZyZCBhWZZxoRjcCmol8BRQKfcOE6iPKe2vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911924; c=relaxed/simple;
	bh=P4lbiR3E1R2H5KclDAlDgTQZPpUqOtpXKqHfQOVXY9w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SP4HQGCcYCZ6OC6U7CTM5/ijMGVK6ux8pR7aN7sJa5zaTL9Gr0fUzTcDh7rr+hVN3djp5FqneO/ImDdH03hC/fntINWrAhPL8wcx/o347kw85quuFb1yKaE/SyHGMRcHQuTXXPR5ObO5jTPlD/kJfUFmASQ24n7MWH4atWvO5DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZWA0rduj; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZWA0rduj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huPBoZ8HevJLreD0bLYLA3rFDCbZq0rbEzYTRgRzSgkmq/Wc58QZmtmJ+OEb85bX0Y8oi72AYawfITyJYpVGNjc5xx2iZudBocQJ/Dut/8dqqSNLBCbX1deY4ojmgVzgRdj9BvCB1qTKNoSfGmkYTiM29jtl5TIJWUE5WJB1fN18vrNXbEH57nlauiML+lwGZz4yZx792K2A/bdWRsd55HXCHm8DOumLvs+alY9q718YKpqGRTsGtlY2/9mqOfD0k3XjoVWO2DPLb9NjpQIEgoBAh6Y7ekTOYEEYdTtgkEzcEO7JseUmn3IqSsba/YFYjST1w7K+2okFv5oM5Ycn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fJiLQ46Gvf/6pPTURyfmZSeS/4IzY6zcEhehgXgzN0=;
 b=ahVIOkHklfaUoGGbWoiw2mJOS2H/u4rygV4A/Jnhn0tf7mI1NMaOM4KwsT9mg8JEDcwxH2iEgnwDwvoEseHGoCfB8tE9UM4/Rc7XEe53RZlb1OyOf15ySvFvVwKiBaXC/fWmoNArlC0k3FiT5wVzSbgxBRl+qJpjbScZ6pSJtQco8uwnwmo2CioARVMGZqtTxjWVcdTLWzagbu+Lkfva6Qm9HNiA2nfwEQQBQ9KjLBNiQhl2A1KrLrnKDd0ox7tvDHe3pb35KDQ6fCTb+WrLiFFHhLeh94n0urcwyd/6aO0r66tqmFRsOH3Vc8T8qtsIBjULAm/jTdrKFyu5O1mTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fJiLQ46Gvf/6pPTURyfmZSeS/4IzY6zcEhehgXgzN0=;
 b=ZWA0rdujUtNQQsjPCcwdbVBNi0nR0Feg0QWo5aHk08o6VKlgYNfknim5aH1ha/01Jl7AnIC2p95DdnQPaJ3TARiFZG4botcT1SUXDCu3PFrnrNHI1Z64LgtrIi9PALAfm/6UG74pI+qUGqMVwnAdcKXj5iIzBFUAEHR3C9aSKhEc05mPGvUZc4+5sDn9YZ7COjepmebKLWXr/qyh7CSXK9FEAQeG/t/EhdW052l0i+8fgkb7pwQudtqV1LBHBNiPqhoTiJnJyaovkGjUhMoFeyFTIJc/Js2ZVL82vLMKR453G5IXBY2XOvjN5/gOzT6DqlyiSHX9knzuNxZaRU1NbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7296.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 19:58:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 19:58:37 +0000
Message-ID: <f8bdb69f-b500-4a5d-9739-90cb1a1a88d8@siemens.com>
Date: Mon, 9 Sep 2024 21:58:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Compilation error kernel Xenomai3 for x86 32 bits
To: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2b577d-c4b7-44c6-1552-08dcd109cb10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzRSRWFnYXRRQlVhTUNuREVud2VoTDM2ZDBidlVLbitpQnNwZDdiSVpkYkdK?=
 =?utf-8?B?WWo4RHB6TkpGbSswTUZFaWsreXh2QmJKbXU3WjJTQXhLRml2UkxMTWRPM3pY?=
 =?utf-8?B?ZmRKM0RzTnd1bFo4Y05tWGxQdFZjREgwV2x5UEdZV3B6cGIxdmZlK0xtbVA3?=
 =?utf-8?B?K2owL253Rzd3eGVabEErQUZZaUdSekhQZVViMlVHRk5SZjVKWVpUVTFvUXZ6?=
 =?utf-8?B?YkY4NjQzOHdSQU5IYU5tUVd0QzVqaWlXQTdla1R0c0FJeld5OU5jOGRMWHBm?=
 =?utf-8?B?TFNQMVR2c25pNHBTMDR1emhCa1ZRTTFBam9ZZFZvZWFpYkpTUE5USWxnQUlx?=
 =?utf-8?B?a2d5UXRuc2RkbnVUWDdZUGlYRklGcGwybFBMTUlDMkU2eDMvYWUvNDRqNmZT?=
 =?utf-8?B?K3hTRTcwdUVXWDN6N1pBU2xGbm5LeTZFaWlVWmdZZGFIZlZ5Tmo0MzhVNjVL?=
 =?utf-8?B?QTlyRldHbWtVdFYzY3V2N0NONit3Zy84Y0RxOU0yS29DWHNxTFBWK3R1OGpC?=
 =?utf-8?B?ZGdYTThjRENWK2dZKzhUbm5GZmFFakJXUmw2WWg2SG05a290WDMyNVl0cmRH?=
 =?utf-8?B?UWV2U0RJbit0YjVyL0ZYSnBUMVQ5bkYyNnMySkFyY0JlTzFTYVRwL1I5QTFK?=
 =?utf-8?B?N3RxQmVJNm96ek9XTzlmTGdHZi9KRysxT1p2NWRudzdWYml6R0dERkVKRHJh?=
 =?utf-8?B?ZGIvODZHeWdtQk0wTEszSkhPZ0dyZmpZNzVVdVp3VGVGclo4L0RoT1ovcTVq?=
 =?utf-8?B?YmRLWGZscWZ1bTFPcmlUMVZ2eEJGbFN4alNQVUZLZ1hsUjVBV0RuNzZPKzJk?=
 =?utf-8?B?MUYvR2JJZ3Judmw5VjdHZ0ExUjh4WDFKTHhtblZiM1kvckduT1RzWlkreDZl?=
 =?utf-8?B?QmhGNlV3Rzd1OXZMUjgyN056N3ZaYWtWRXM5MVJHdzBUdVNYMC9oSlFTcFdK?=
 =?utf-8?B?RS9BNHJHR05kTjR6bnZoUlVLUjhLTlNrMjNFRTRjU2E1VUVLQkJDM0pCbllq?=
 =?utf-8?B?NndvYkZ2KzV4VFV2eWN1UG01U3hZeGtxZjB3OXl1SG5mVWM4dkw0T2x2WUpv?=
 =?utf-8?B?TWUyTEtrMm9GeHBpVHlnZHNDTHpVOTIxRmVwblV4dm1HOFltZDFxZ1BjRU5H?=
 =?utf-8?B?c3VBdExMbGhmUWZ1YUZPL1Z4d2RqMkVBZHRDeHI0SnNvbUUwVWphZEZWSktY?=
 =?utf-8?B?MldRWWlXQk0rTVR1cFNaeEhxNjlHQWN1UHNsWk5QT1FCY1BNdzduWDcrODVx?=
 =?utf-8?B?Y0ZSRDEwY1Q4K3dZQXZvR25rVDNGZnI5ZW41TlpmaGd0ZW4wbWVpT2lYakYw?=
 =?utf-8?B?aXlNWTdMQ2ZadHV6Z2k0STJLWG9BN21PNmpxZFlRV1NodThYc2dKUFIyKzRz?=
 =?utf-8?B?NkhhbldDMDZDT2ZvZlplUmhXNmpEQXlyMHp2QTJGb3BpdEQxQzltNXF4eDQ4?=
 =?utf-8?B?cW9mTS9taHJCQVlLamxKRTJsbHZEVzlEeHR0S2pFeVJWY3NNanNFM0hCRytp?=
 =?utf-8?B?Q2lYUkpUNi8vdHVONFhHSC9BRnVoL2JxYVNZQlFnZWxsK21tRW8xL1RWNURB?=
 =?utf-8?B?NUMyWXFYNEpiUGZiWGRJd0JZczdsR3FWS0lIS2FkV0RUcXdvaTNzVXdwTVdo?=
 =?utf-8?B?R0hLMmRsTmFwcXduOVB4K20yamw1L1YyVkhOaHo1TmU1dXJLZDdHQVMyOW5m?=
 =?utf-8?B?Z1VRYys1UkNuRno2dklyNXJUNUNhVG5RbFdzOWFLeUIvaWU4STMyL285WkU4?=
 =?utf-8?B?ZDNvdFYxb21lZ0xNdTlyK0FQQ1BEZ3hQb215NE5HemdheW1LRDA0azJnWFRW?=
 =?utf-8?B?SmdCdlVCRHB3dG53YmFwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDByZU5mcmNlZzgxTXZCSG8wUlVYUXlKT2RsQnRFUU5xeXdRQ3V6dGFPYVh6?=
 =?utf-8?B?UlF5eDFaYlNXV1RvVCtmV3lmQXI3Qmxsb2VPSXlrc29yMmV1bTMydWt6ckZD?=
 =?utf-8?B?a3hCTzNxZ3BadEhNcW54V0s3a1dlSjBIWEJ0RWsvR09LSEpBNjRyVXZNL1Nt?=
 =?utf-8?B?TkJSR0IwVHhwMU90NE9YSlVwQ1U2RE5QdytKdzB1QUZPY042RTJHWGZOME5u?=
 =?utf-8?B?SVVvR2M5Qks5NUd4NUlPZ2VIOUFNVmxCMG81NEJYY1ZuWFNEMXFPOXFVejg5?=
 =?utf-8?B?UVRCWUt3MWRvS3pSc3JXMFMwUjQ3aUYraW1jWEZoU3pzMDEvbjVuN25OM0ph?=
 =?utf-8?B?cGFLZG5LeVVSS3g1Vzk5SG82ZUh6TmV0TVlHRklFSzA4ME94dGtCcklydjdY?=
 =?utf-8?B?OVlGTklJdHJYNHpSZnlZWGxXSmxQM0VqY3M3My9VUkxpN0JBK2U3UzBjd3pG?=
 =?utf-8?B?QzN0RzE1Y25aYjBmdUxqL2NuaHBmNjRwbm4zWlZuVEVwTVpyYW1xU3V4YmZq?=
 =?utf-8?B?dnF6VFhPeXVHSGlOVysvWDVSZlZ1RTR6KzU4RE5ONzg4NXlVNFRFZkRwUHo0?=
 =?utf-8?B?Qm1hcEQrTkhqVVhBOUVJOVp0bnJYbFdEb1ZpdExuaEd2SVdpOWNUa0tPbTl2?=
 =?utf-8?B?UmUvMzBLa0Nua1BOV0ZsVm9DeHZpWEtNUGZZTlM1YWZSNUxmOGlkaTFweVNQ?=
 =?utf-8?B?QysrVjRUMlZWZFYxYWxocHV0ZkxybVB6aDhYNW16d2E3Q1o2WFdRZzdqSG12?=
 =?utf-8?B?Z3l5Z2FCSllVc25IZFcyditRcXE1VCs0SUtUZzdGU0cwenhHRmh5VGtZcitX?=
 =?utf-8?B?WFora3RrMmNWODFrb3dUbE1IbDdGVTJXUkREaHZZd0ZiTmpZdzlFZFlTNTIx?=
 =?utf-8?B?OUE2L2cwYWlHVTdtMWFpMlh1MmZSc05qbmU0ckd6ck8wS1BoR2hqVFNJclZ3?=
 =?utf-8?B?Z3h1WjMzWDBsWE1JSCtpTVl2RzJoLzYzOUFHSTFWUEo1cXZ6RmlKT0tzVHll?=
 =?utf-8?B?eEVhU0c1YWFDTG82KzludTh4Uld5bmZlZGxHZ0tJTmhydjFtemhyek56UHJF?=
 =?utf-8?B?RlFIZmtsYkw4S0xmTjNkczVRQTZ6c1JRaFpwemlQZGw3Zk4xWDJuYnlXMTZw?=
 =?utf-8?B?SWo2M3dhdERncVdJbUNydG9BT2wwN0hhZWpwQzJ4VTRjRlIyUUlYdURlUTBx?=
 =?utf-8?B?ZjNBQ0JoZFhZS3dscTh2S0pLY0FRL0lNT21tQ2NQeGcxcGs3UGhnMTI1dmZB?=
 =?utf-8?B?bmNCaEMrbXhQdWRhZXVtYmpISDNzMzNWTmMwckRuZURVc0dVS2hEYjFTazZF?=
 =?utf-8?B?UGVxemxKd1QyN0lFUTJ1TUY3d0xpSE40ekxQN1hHVURmbG9icHdHNWcvek5T?=
 =?utf-8?B?NHc5NTEvWlBKblk3TUIwdC9UMlBKeDlrcEZqMWx0RVk5YnJIUmJiWWZ4dm84?=
 =?utf-8?B?bjJpUGhoNmpBMFB3YjZ5YzFhZ25jQ2RDSDlNSG9IWEJtRU5kZjVBbWd5Tzc3?=
 =?utf-8?B?cENKUkxRRmVWbVBsTjRlSjlvbzBCWG5OV1U4WmtLK05sTjJTaVdWTVN3M083?=
 =?utf-8?B?RnFLcENXeGhaUE1KVjRmck1hOGFDbVQzSGFqemhkVVY4TXd1RkJId0k2Znd3?=
 =?utf-8?B?TFd4QW11dnp1NW4ram81a1czVW14Z21wNEduejNPN0VYVHdZYnJVM2FKK0dW?=
 =?utf-8?B?dTV6dFlRdk9kUm9FRXpUWGZaS0c0MGJCdFMrRUN6Yno4a1NXN0hHZU0rM2hW?=
 =?utf-8?B?ZzZmam9qSWJodW9KZDRrRlZVdkE5ekd2dTJtQzU4SFBrUEZVUStKY3dCTWN0?=
 =?utf-8?B?aFQ3SWJJSVBqaFlCcmVqR0gzTWJwaHZsVG5lWi80TXFMN3o0NDBwbUdrODR1?=
 =?utf-8?B?aDZhRG0vVkU0UWVqTERlZjU2bnluaURKQVRscWV2SFdrZy9DSXY1QzNaRkZM?=
 =?utf-8?B?UDM4bEpiekhmNHdCb1NTMy9McFpJUy9XNDlZQ3cyZlY5Rng3OWplZFNIdVVt?=
 =?utf-8?B?dnFZeEZJWG1XSjhiT2JYSnVwTmdlZ2JMZUhUMmJJZkNKcTA0YWM1OEd2S0pC?=
 =?utf-8?B?R1EyS3pLWk1pY2E5WHZTaTk0VUJsWTJ1djJ1a1hjMmlJNkkra1lLVTRoVDF5?=
 =?utf-8?Q?O34pSbXxJHpwoi/WORAXm4Lhu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2b577d-c4b7-44c6-1552-08dcd109cb10
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 19:58:37.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uK4uCMzeOga7TsZIp0tVqcjrWI+T+VY0AUfDkgRTZZme/ZiKCkc/AAuxYTAqCHHuCbeypUbNxdyNvfH6tj0kmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7296

On 09.09.24 17:00, LE-DOUARAIN Marc wrote:
> Hello Florian,
> 
>>> I’ve tried to compile linux-dovetail-v5.10.214-dovetail1 github 
>>> repository for Xenomai 3.2.5 (from a Debian12.6 i386), and it failed on theses errors :
>>> (the same with Xenomai 3.2.4)
>>>
>>>   CC      kernel/xenomai/pipeline/init.o
>>> kernel/xenomai/pipeline/init.c: In function ‘pipeline_init’:
>>> kernel/xenomai/pipeline/init.c:23:9: error: implicit declaration of 
>>> function ‘enable_oob_stage’ [-Werror=implicit-function-declaration]
>>>    23 |         enable_oob_stage("Xenomai");
>>>       |         ^~~~~~~~~~~~~~~~
>>> kernel/xenomai/pipeline/init.c: In function ‘pipeline_cleanup’:
>>> kernel/xenomai/pipeline/init.c:49:9: error: implicit declaration of 
>>> function ‘disable_oob_stage’ [-Werror=implicit-function-declaration]
>>>    49 |         disable_oob_stage();
>>>       |         ^~~~~~~~~~~~~~~~~
>>> cc1: some warnings being treated as errors
>>> make[3]: *** [scripts/Makefile.build:286 : 
>>> kernel/xenomai/pipeline/init.o] Erreur 1
>>> make[2]: *** [scripts/Makefile.build:503 : kernel/xenomai/pipeline] 
>>> Erreur 2
>>> make[1]: *** [scripts/Makefile.build:503 : kernel/xenomai] Erreur 2
>>> make: *** [Makefile:1832 : kernel] Erreur 2
> 
>> I think the main point here is that we do no longer support 32 bit kernels. We still support the compat case, so 32 bit applications running on a 64 bit kernel. Might that be an option for you?
>> Should work as long as your board supports is 64 bit.
> 
> We are working step by step to update OS with an old base hardware (ISA bus) as transitional for now, and will use a 32 bits CPU "Vortex86DX3".
>  
>>>  
>>> I’ve used the command « /prepare-kernel.sh --linux=########/linux-dovetail-v5.10.214-dovetail1 --arch=i386 » before configuring kernel.
>>> Not better with linux-dovetail-v6.6.23-dovetail2.
> 
>> Haven't touched the prepare-kernel script for a while. Seems we should bail out and complain loudly when trying to use --arch=i386.
> 
> If I can understand that for the “new” Xenomai 4, 32 bits is excluded,
> it's perhaps a pity that Xenomai 3 can't continue to be used, especially if there's not much to be done to fix it and make it work on 32 bits.

32-bit x86 kernels are practically history since almost a decade,
independent of Xenomai. 32-bit applications on 64-bit kernels are still
supported (even with Intel upcoming cuts), but only few people were
testing 32-bit-only x86 kernels that long ago. Probably almost no one is
doing it in this decade anymore. Distros have dropped 32-bit, and CPUs
that lack 64-bit support can be counted with one hand - if not even a
single finger.

> Is the error, on Xenomai side, or moreover kernel patched ?
> Which kernel / Xenomai latest versions were running on 32 bits for sure, or at what time ?

I would not say that Xenomai 3 is definitely dead on i386 but no one
looked at it in a very long while. It could theoretically still work
with ipipe-4.4.y-cip, but anything newer dropped it. While we are still
carrying i386 in that kernel, we didn't test it for many years now. Also
note that this kernel is now getting closer to its EOL.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

