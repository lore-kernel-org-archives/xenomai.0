Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8631282B
	for <xenomai@lists.linux.dev>; Wed, 29 Oct 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722279; cv=fail; b=Gjb63ieXHPOZGhxcPafTx5rfPDwXmuDDOLAl9LkuxlZJzHx6SOda8E369qO8+/cstprdBPcqyCLcvgncvPjm50kuFdN/vNmdT52fK3ZHz2WHgEu+obZuPq66MISFsk1GeW8wB1ZsU4UvPzAb7Ypqj9fWZm4v92Be0q/wbwocHvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722279; c=relaxed/simple;
	bh=paCu/do44d+xW+bbQz2gvsLQT1VgAG18TINYvriEggI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2c/fXI6U6vdovmdZmRESOROT742Y6ow85OHnAByIuY1DNYK+SicDE5LcISYXP/jiEyM9T8oUbEXGWzaODwn+2fF2SdNwUNF87cuIKXY1zQnSF3gq+wcaT3DfNUeJ29IK2V3LdJhws2Zq3K9UBsXUxkZvvqC4Sv2lXAN0Zj+CSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=G9xj+3Ka; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="G9xj+3Ka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G45co8KCxXyrNPNDTt6uxhWctU5c9Ky7OO77s6cgC7eB/Gr/txx64QjFCt6tttBm13hm2EfEV9MY+W85lv/n+mmufjLuFmoJyE75kRS8AMiMMEbGSu8/2ATphm9FkvhlryQdZIAYGZfyi8gc8l9SDBt6uwg821KykncyTc6IYH6aEFYq3ul1aLEK6yUUamgmx/hwWSmYTq44NPHtFaZXqdmODChRdnHMSAxRjsnY6ztyfE/M0A+wptD+BYkgc/FdmzjZ9LRLoWdskSidt5xicVnpPf0vStwOog/UlZY5MXf0XThuZvH8H9P0pIu3JPo2ZLP+XKsAz48mFphNT9uXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1URQcVr3QbUrPaH9FJ3mBfO3wD27urflG76Sd1kbgQo=;
 b=CyA8SYS2+f7X/aRcXjF8jbgodnvk5ZjT9SDAYjGOyoPz38Z3NrqN98hvF1Ld3kwf/1BnVmCYmBrG/RWlim2wie2tWuRGg7zjpbjXVyg34T4cK7254m5lkEGYxIw5OcqFYtRI9Pe7PWFYTWjuZ6tGmVDwCoVvjMeMewj35muCP2/XD4xZTa0oniB16pwWs1iqr3RsB4prbkjpzRZOwVGdHrleK/Nora554EEUwIMT1txKUex3Re0QfXCizY/CZt/nij5uqY+3GStH71rFHd48MeK1TSSWf8lV2gtM/0Zu5s7AEcUm9WAWrEI1KhxRWurY+Oy0t6bnPeLibXUcI2V6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1URQcVr3QbUrPaH9FJ3mBfO3wD27urflG76Sd1kbgQo=;
 b=G9xj+3KahhUTyFJwFODp7slDZck+zdwRVH3bSq8xRkCwFRROtzWnwl++ds3/s5agxkx+aClZvDDNaxvi++3ov6B+0YPaH8C4V+I8MFfeTvvOw9xJCjeRfQVdDRJ81MPvtTVyi92EHeQp5XgeCKZcPASZlL5hvdJj90XaucHcb2LC2SObF27xsSL1aygZIhmksHfuQcHhKZbHkdCa/KFSQmOiXeHflPNdQACmKXDsb+nyHHQPByagRaDltd/JvmHSlfjV/GSEpuwLvmy2GmrMwXMk3QTVFwPyqdpjUby5DLiFgUjIjlIe4pjV64bJEgDixXS6n4CF4JYOeI00yFdMtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3634.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:152::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:17:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:17:55 +0000
Message-ID: <5644df7d-6b0f-4bdc-b785-f79d4cac735d@siemens.com>
Date: Wed, 29 Oct 2025 08:17:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai community call on Wednesday, October 15, 2025, UTC 7:30
 AM
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <5a0c551c-3aad-41b0-a07b-eddaf8837faf@siemens.com>
 <CAFLxGvxB9DaOeMMeEtohddyt3vD2NA9Attv_GrckkJ-hB9CJ4A@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvxB9DaOeMMeEtohddyt3vD2NA9Attv_GrckkJ-hB9CJ4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3634:EE_
X-MS-Office365-Filtering-Correlation-Id: 848ee837-6a38-4be6-7f88-08de16bb47b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1RuVTVNb2U2SFVnTlZSemVNYUYwVEcwRzI0dE4xampPYlVYZ3p3VnJaak9w?=
 =?utf-8?B?cDlWNGwvcTk1dlRaaEZNTmZTYlhSTWhQaitHSktIRUVjMkdDOVlIbVl4RmFl?=
 =?utf-8?B?U3AvQ1IxYzRkaGxGSzRLbVBWekwwSEhNczVYbkd1WTFtRzhFeWo4L29FdTBT?=
 =?utf-8?B?MTRKUU9QSXdMaUREckQ5Z3ZRLzdRYlZaSjJzSVhVTlYyUTc2SHRWa1JLelk1?=
 =?utf-8?B?VldqUUlWZFJpekV5UWNQdXh2czVNMjdYd2FQcFJ5dldtQW9zWmQ4MzRzNWlz?=
 =?utf-8?B?RDR6djZ3dU9vcStBaUF2RFl6b0dVYnRVWE1Sdm02T2dDYkE1WEhCVzRCSzUr?=
 =?utf-8?B?eHFCTUgwNTYrejgrTllxRG9oektEZzlzcEZiVVVRWDl5cmlvS1ZzbWVsTHRs?=
 =?utf-8?B?NzRjYkdDeVNOem5tSDgrdU5wYWJLRnBNVDg0S21PQmJReVJvSURTVXV6WDBH?=
 =?utf-8?B?VXI4VlphanhGUlZkL1FLSWtidXZMTHdQMHpNaFdBYUdqNVZnaGh2eDA0YUpX?=
 =?utf-8?B?Q0JtN3E4alh1c3d6YzU0WGd4ajN0QjhpWVlXQVdtT2RnUVVuWUFsSWhEZjJp?=
 =?utf-8?B?RldlTmFuVkRiVXEzcm5hOUo3a0FBZG1YTDRkd2dJd2FWOGE2Yk1ZS1N1RHJk?=
 =?utf-8?B?Wk5NTVJHQWRPOVBvQ1E4T3AycUNBZkh5S2pMdzZtZTh2cFJWSStWVzlMd1RT?=
 =?utf-8?B?M2toYU0vVmg5emp5NHBIdDh2SjlXQ1NSM2NzbXF1ZUVhemVJb1ZEdFdMVkRa?=
 =?utf-8?B?N1NPVGVUcHNhZ0NzaWNyRmVabnNxdS9IRTZ0cjl0czJWZmhOd0RINDQyeU5M?=
 =?utf-8?B?aEltY2FWQmhYMUMxT0NHUStIQUVoZlVuWGVuTGRUYkkrcHVTZjV3ekM0K294?=
 =?utf-8?B?WXBJRkFSUEpqeEdqYW5CenBzZXF2K1dyWndHN28vZVgxaHIxY2NiRUJHODJy?=
 =?utf-8?B?UUk4cmZnM0twTXZvVE0vMFZxazN3RzFubERVdlUwSDRacTNHSVJUSFdDTGo5?=
 =?utf-8?B?SjAwZVlrR3JhZ2RNVkxZMno0QlVnSnFKaERiMU9KNjlpYlNYVGowcWIvMUlP?=
 =?utf-8?B?bXMwWmZWdDNCNldieUFMMFRxczNMVVdVT2VPcFRkVW5tUWxoTEoyQk14ZzEv?=
 =?utf-8?B?V0UwbldIaktWRzJRTUFzL2ZXWE1zOThHRWNzcHNwWkxBandBdlFuQnVtaU45?=
 =?utf-8?B?YXppL2ZuYUNLTUdtbkJNSWRHaUFBaWRzMElBUFNPbUFkT1ZBV0hTSVRFbmh0?=
 =?utf-8?B?NUNZd1NCdGNDYmxkckxVd3NrVUtINHJuRFZuWG5FemFFWlV5b2FRN0hiOElU?=
 =?utf-8?B?Z24zNFZPTmxEek9XZVdDUDdaNVVjM00vaURQbDZuYWhNdElEVzBnaHJQa0dI?=
 =?utf-8?B?VHBSSWU4WmhIL0tYaGZaOW54STRBRC9tYU91Nk1YNzZkYXVxeWYvUWNFMlQ0?=
 =?utf-8?B?b2g4cDJ3OVJpNFcyK1ZCV2xaR3g3WTU2Qm9LRXUyRkdBNHFwTGdtbGlpK2pG?=
 =?utf-8?B?dktQQlZuVVVqOHhiR2hoNVJmaFJOSWIrVEx4QUR4a3N6Q0I1ajQwYjI4a0c5?=
 =?utf-8?B?NlYrTzBwQWUyeSt3b1luTHJYSnRxTkNUZm9lTDNsTTZ5VHFSRVYvWnk3bEQw?=
 =?utf-8?B?b2UzWlFtRnNlYkJIVHVUMjFudGNhN3hodlZuc2o1bk8xbVpUQlFXczJVSG5k?=
 =?utf-8?B?bTJzM1pKZmNMUEZhQ1hkampoSFdaOFdXQyswYzNrKzFHTDVzaGN3c0w5VExs?=
 =?utf-8?B?WjVRQ1cvN0U4RWpoT1kzdlU3SHFiRTdzam9NZExEWHBzZ0c0OVdPeTd0VWlF?=
 =?utf-8?B?ZkJ2My93TjNZMnNHT0N4cWtONFprNUEyd3J3Y2NtSWVkSC9SbThhREorMDhQ?=
 =?utf-8?B?MllGbWRYaEhvQ0I2cFdCNFZuc3QrSWJ4ZHB5a1N6SmpRa3AvMkJLWkdtZCtv?=
 =?utf-8?Q?HRC7vnC1Nl3ENK6XzSE/+pTQ+KQ0UoDl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YURrdGk1alBja0g5QWtIRVhPTHdqMm5PZ3F1VVJjL29YOVZpa252RUQ5SStZ?=
 =?utf-8?B?SEg4TWlTMVpzQ09LVXgwTnFXU2pyaTV0M1lqd3B4NjFDa1ROakRhUXYydGJz?=
 =?utf-8?B?TE9DWU9raVZORTI5TWtDazVOTTBNYzFNSC9WaTVNa1V5SGw2U3ZMcEFXQTFI?=
 =?utf-8?B?VlRZUUh6bW53U0FRamJ1NThROFQvZ2NlSWdYK0orSmcydkxMRVV6TDA5Q0dj?=
 =?utf-8?B?dGgrbGRITHBSNlZ0UzAzYnAyUXkrWVpqNFVOZHlWempZRkZYbkMyTEpyb2Ni?=
 =?utf-8?B?eG4vemk3ZlBXbEpzZXNiQVZHZFNNdUpSZWtDSHp6d2xiQ3E3eEs4MlFDdG40?=
 =?utf-8?B?OHRHU21sK0VVdHNjVHc1L1hyUys5UjNMZkNzRTJlQkJDYVdXU2hLMjF3aFRH?=
 =?utf-8?B?c2x6THYwTUUvd3VxaXV6TW0xNmMydjJNaFFtY3VkNG5ob2lyY1JQc04vUWVv?=
 =?utf-8?B?MnIwNHFHV3laUXRwcm5iMnpQbFpzRVJvV2pSWWRwRVZBdWorVnk5RU5OdVVD?=
 =?utf-8?B?ZDBXZlk0OStLNm43T3RQOGNMQ1Ftc253ZHlMR0MyZkYvbnkvcDlWVTBpbjV6?=
 =?utf-8?B?Zkt4YnFTQmpRKy9LTVBUS3hGL1NoMklqUkUzc2ZCL0d5V3ZYU0hhNy9jdk9p?=
 =?utf-8?B?M1o0ZHVyVDRobUxDQkxDMFRHNEw1c0FUOG8rb2QrY1ZUb0lkWVBHOGZGSDFn?=
 =?utf-8?B?Umg4VHo0RUU4R3AwSXFSOGhhVnJJYTVvWUpLY1pmcFY5Zm1MdjRYSDFvcVpp?=
 =?utf-8?B?bTZheWp1VHJ2aHdWdFdvUU4zVjZLTlhvN3FqR1VoNHh4OUFsWGJseFp0OGRU?=
 =?utf-8?B?RFdjdTFjVkVJT1gwSjJNMHJHam1wZ01pMWwrZHV4blhlSGZrUlg3L000b04y?=
 =?utf-8?B?YzVmeVRBTVF4TFlmaVpncEhMQzBNWERsQXpPZHVTRjVLQm00MjRLUG45TlBu?=
 =?utf-8?B?RmVVdXlLM2d2SFRiTFRPMjkvUDdTR3piSXNHb3pIeG4ycEtCeHU2V3lhUWlF?=
 =?utf-8?B?a012SUJFaW5IRmsvSGxaRGp3WksxaGV0ZXBSbHM0K0E5WEwxaEJ2K3MxT0ti?=
 =?utf-8?B?QmJXZUhPUTZiTWg0WFdOajUrZ2Q2WVp3dytIaFF4UlAwVGtCOWZFYjZnL2xS?=
 =?utf-8?B?SDhxTDQ4MmZKUWszUjlSSi8reXZFR2xsTTcrUzQ4QkdBU3J4emxHdDczbmY1?=
 =?utf-8?B?M3hKdXEvTEE4Q0t6UUlGVm43aUtNY1oydEk3MzI5VGNuVnQzZzZza2pBQnh1?=
 =?utf-8?B?Y2d5MHMvT1VrK1RmSkRITVRzaFd2TDRHQ2xUR2wva1FBRGxsU2U3SHBPUXQz?=
 =?utf-8?B?R09ZZDFiWW1ZZDdqUFBGSjdPTlM0eDkzMUxPeFlVeE1DVWZlU0psZGN4VW11?=
 =?utf-8?B?Z25DcVVhZVRlSk56QmhOT0tJc1VyZ0xrMDNMd2NBMjhKc2drb25pTFVEV1l2?=
 =?utf-8?B?dFpWbkVkNHJHWlRrT3VIZ3NIaEkwMTZyZ0F0SFZybFRIQWVzS21IK0xrMHBQ?=
 =?utf-8?B?TEZseVRmeFFUOU5TQWtscXA4T3VQTFU0Vk9lQUdGWXZQZTB0SFpvalJNQ3BG?=
 =?utf-8?B?UjY4czNBeCt3T0R6eVd3a3Z5a0FWQk9vMXpRMEE0NldRVVVCeTd1Y3RmQWpu?=
 =?utf-8?B?dGh4OXIwUHd6ckFvVEh2T0FWalMyM3Y0cGw0V1g5T3NBdnJXY1kvQkVIYVV2?=
 =?utf-8?B?TmRJc1lRSXk3OTg2WFkwdzVNZXNmNk9wQmZFUGoyWm94MnZld1doTGV2eWRP?=
 =?utf-8?B?QktOZWQ1WWR1a1UyNXJ2L2JtSTROdnpPUDJSUFU2NE9nUmI5VHNLNTF2YUUy?=
 =?utf-8?B?QmU3bEhwODg3UVBWckFaM0JWRUdpTlhqejFJZlJyYTFVQWNnMUxFWUhhSnZ0?=
 =?utf-8?B?YVVVTmlJZHQ3Rk9Fb2hyeVIrbkNBV205QlVTZWdycEppeFNyY2FSM1JJVFU1?=
 =?utf-8?B?MFUyaDZobkFYTG9LTTIzN3Z0cTd5SGFDbFdXeXhWS0Y2ZU40eW05STVRMm95?=
 =?utf-8?B?Qm4velJHclZVS3RFbXc4MTJTODBJY0xDTVVFNHVPU2VwMEgyV1Z2Qkc1Q3Mr?=
 =?utf-8?B?UmJEMW5KKzN6bTFORHVHaFNheVFZK08xcERJbG52TEgvY1o5N1NLTk92ZWcw?=
 =?utf-8?Q?rS3AOXfhEeuHElqeaXQi64xId?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848ee837-6a38-4be6-7f88-08de16bb47b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:17:55.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAunjp3uttgOM+YG7rm7UyQbZOdcqPBBKxV2QOhjXO6SKJyMGbSBaIGlff8/udGnB5tkYTbOYpqXTB8WdRA1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3634

On 29.10.25 08:17, Richard Weinberger wrote:
> On Wed, Oct 15, 2025 at 7:39 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> Topics may include but are not limited to upstream/downstream project
>> plans, status updates, and technical discussions. It's an open online
>> meeting that anyone can join and ask questions (you may have to wait for
>> the organizer to let you in).
>>
>> Time:
>> Wednesday, October 15, 2025, UTC 7:30 AM
>> Paris, France CEST 9:30 AM
>> China CST 3:30 PM
> 
> Do we have a call today?

Ups, yes - need to set a reminder for myself.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
