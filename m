Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBBE2C859
	for <xenomai@lists.linux.dev>; Sat, 16 May 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925017; cv=fail; b=okP3H04eLJ6Qbnc3CGNMEu56pYWX/ZviLghkMyJlvAvBnUzoA+opE9o9xZus6Pe5CA8x21PxonlccDKmlYgylxmrbgeFssHyHJQLLbhTKXpzgY/nikia/9PM8djYu5aq+T4sEhlZfEFYaryVMFDZuVj8Q+MpGh+nnVolPBaa0mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925017; c=relaxed/simple;
	bh=DVun2XQqndqKh7983Yst3jlWbICK9JaTKUCi8KhGrvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGMEm5olmZkmD1jCiFmLbbZn49AAz0PLzkiwHxuIKzlM6ig3RtVHY1Z+zAO9jEUSDh9isARvd4a/DHTYdQMemxPVicBq6edAMeozJnmEW+t7Q9h1lWLopcJjZteZ6GKIouCcVy4QX9iLp3L6kymSh6nlKtSdRatlxXDS2U3i8Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HaTC3RVs; arc=fail smtp.client-ip=52.101.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HaTC3RVs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a01AvqGp6wTf1CHiRUI9JXCCUbQyMF2np6FRW9oceNWZaK3ymerom/Z9A7a6rEEn87s7ZK6m4prL2FfvHlY8ifNYJ4ztWCcknKrUnnmOHLVegl1QLq62mfOwrX4VLJ4vdPPXHb5wehDNANA5bGtJokCfO+F3W9+VfukBL+g1FEi5Zyy+DxpmrUV2+6s67K6vNqE/4hMQF9k3OaIrPAGFZJFwVRqWO/JpVV4oFy73L45cg4f+kani+LFwJl+rG7t4l3UvM3bShnVoXGvfSC8I8wSGJMBQzhWNZoW80/DV6zWcODYSRgiwl2dOPddZys+6HlB5qGkoQSMRG1n5zEZMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrjNtJPyHSlV7Pm6Q4HrYmL3fmbReTprJYHp0U4fQtY=;
 b=UiFgOLHgUqvARYINxKAionKD1l+FDv357VwZFk8zEZq+voSCM1mSW1jhCjiykRZGsGOYcvTh1Gf9+PJAsw0aXZlgA++KDVYaarRLhS6qJZjIznF1mE/NsEOThyGKymtGBMess7es2G/6d1DYP9oi5xqLyCqTeXfZfz/m9EL+jutrE8cS5ZVXkQn+/MOJqrSFKzrVL/Sg4T+DjxFB5zfnGR28iIsqZOz99MKR4Urk1DnielX+kdZw0vtj7uojxWZyAjDME5mw+SmWnp52N1nwjvVhoHcbR+iHxsGj8BMXmjCh61JwB01Wr4/5C5eMUIAX1C1DQd47Rbbj1p9/KfX8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrjNtJPyHSlV7Pm6Q4HrYmL3fmbReTprJYHp0U4fQtY=;
 b=HaTC3RVsHjEK7hBb7iPLTtrfktC5UKLOpcdGstoxeh18KuGJm26WH+Qad8hDPiulOxTHhYr0WWSbDNU+uHUCg2jUXc8zFf1WtaY37K6yf0MFRtEGFz8QAISqPmlkKfvyKNG4qpDN+ipwWXaHDwc3Cn6/nlKhCazZ5YdehqMZ1LQPdY7MyEZSHux8pcJiGNtRPkxA70qnUXOciHo5zijWFJZ4TPzBUIRu3BzhWrp33fEqEkosr9JxYXMEhIvTmq9fqdh18JmIs33ejDLPmL7TbD6x+VeyUjcqg4Pl34XGHoAN5d+TMsdmcMgwgIb76Ou1Jdai5kKiIMn+0MJtTU93iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 09:50:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Sat, 16 May 2026
 09:50:12 +0000
Message-ID: <f8527d17-78bc-4852-9ffa-2c3b5110570d@siemens.com>
Date: Sat, 16 May 2026 11:50:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler already
 registered
To: Hannes Diethelm <hannes.diethelm@gmail.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
 <87340ij2lx.fsf@xenomai.org> <201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com>
 <87jytt34q7.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
 <2686ae4a-c63e-418e-8b4a-be49a22db83f@gmail.com>
 <ee787e06594ea3a32125c2db0c2112e7f6a9a81d.camel@siemens.com>
 <358e950b-4019-4d47-81a4-0a06dc32be1d@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <358e950b-4019-4d47-81a4-0a06dc32be1d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 465fb559-7f46-4ae6-b223-08deb33085d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|13003099007|3023799003|4143699003|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Dyt998xEn/AZlZRbxB1dmK5DSvt0OllN9mn4HJLm7wTwriUg6dszPKHiq8w5zYrsX5V1m/S5grczQPQCzUf5fZFdNvxWLKupXOhTmytPOPCiGNqqTypFGPF8uBLU9Hn6c7QzxCDdaounoz+khpC7NLCiDGrZL620fItkgqwCHaaFEUrYjp0X5tdkky+cpPdAaBQQoq4BInrkbBc2yfsw4kUyOpvThEHTeehSsaRw8mX0Zz8zwIDjjrBGS8mZf1cSABS8tLHE3slkL0SNB74xGByW8CEJ52/0d2inD6vD/o4f/ARXoV5jGRFZcgocJaMQkQyRNxfgUdfXb7czSJZAqD5xBCCWVTFPhRw3KQr2MXVyMMDmSrFsDs+Tj4NhRpKiv2WGIK35/Mx3R+eF9TSrSQu7CQSe0MdfzHreYfOvL0fVkUU+n7x5GKLxw0ydkjgbMGyGqvXCMq3ksWzzjYVGcbh28cXJsdYezdl2iNh1ReTIA6VpUfd/WiMcdk60HD1KLzDUhQAUyq7pxHdBrExdwyQcNA+GU9tSPhYKK3gwrTzXued6Bz1trXEAmHoa1VnNKCTo0wZrkN2e6Qu6QwA70Kyuh9G5fHDmBQWVtcWJExxIlRyA7eOopzclGPTxJ0De8u9J76oDE+skP1KDFYXvDED56p347jsWUgMGVJ4QKIOn3Oq7DzfSKtnn+6Qfwh17Y/JzpVnQpklDzU4jPbD8Dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(13003099007)(3023799003)(4143699003)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDdzaTduZ1dqRHIxZThmOU00U0VRRUprVTJiL2l3S3BWY3Y4Ry9ESUZvbGdM?=
 =?utf-8?B?L2dsTEEzMHBDb1BtekJxWFdjMW1EZU43M0pNeVcxN3cvd25MT1BIVUt3Uysy?=
 =?utf-8?B?WWcwUXVLSlFpNDdpMUFhY0Uvb1FNak1PYWVkUkdKSFkxTEhIdG9hRytJSytK?=
 =?utf-8?B?K0d5NjVrMlZqMm5YZEhrKzRIeVVoRkNEdXBXK2ttZHhoVjVqMlcvWnNnVHh5?=
 =?utf-8?B?d0gxY2ViQmtGQTRFNjk4YldFOEZNK0VwaEh2ekY0N0hmeFJJbUZPZTFoVXph?=
 =?utf-8?B?NG8vRmIveiszb3Ewd2x5V2lVUGtuN2oybWtMK2tRazhUbGFZM0JFMmJJY0dz?=
 =?utf-8?B?d0YwTWxHZHR4QmZHSWViZFJhMEVDRVQwdWxVSHlBbTNweUVqTWZEZEt5dWFO?=
 =?utf-8?B?VWpOUzdYWXdZRXN4aVlReHd2R2Q4Z2tNNGVFRUFLcUMwamowZ1lmMWtqQ2hl?=
 =?utf-8?B?T05pN1FhVmduajFiZWFtczBXK2lzczN0S1B2OFdxVjk3STBIUkpYRFNPVUdT?=
 =?utf-8?B?ZjdMKzJXMlJtMWJ3SXI1UVRiNVkyeFVjbTJJdXZDU2RoOEpxSG1WcWJRdWdl?=
 =?utf-8?B?dnAzNVQ5a0dSTktVeEd2R1NlbUVUK1Z1dUFxQmhQOTRZTUpseDU4bUNLQ1ov?=
 =?utf-8?B?TCswYVVGdVZqTkFvQUNZY0xtWGt3Yy83RGRxSVNFYU9BYlNwWE8xNFcxNmZ5?=
 =?utf-8?B?KzhBTmxpSGUzSjZQQ29JYkkzcTBmbG5aMUdGSVprdEhwYVFTZ0ZEUzZ6b3VP?=
 =?utf-8?B?ZlFvZXhTRFhDcWEyUVZJSDBtMU9sQjBUd0QzVUxHTE1veG91RVY4cUhVUUlG?=
 =?utf-8?B?dnN1c3M2cTR4c3ViNnNMMGp6d25lNFJpb211bm1Dc0tDY084OC9KSjJJNll1?=
 =?utf-8?B?T25kOTBVcytXeGgvT3JvdXBUcFlRTUx2WXdvVjlUcUhKN3lXQ2RGN013Szl1?=
 =?utf-8?B?TTBOYlM5Q0NIRnZpeVRtTFRoSTJoL3ZJTk5zM1BuSUw1NFdUbTdscEFUS0cy?=
 =?utf-8?B?R1h5djR6M2J3SlZIdXhXeFNLdlpSQWVtZkZTQko3MlhmVHp3bHBkSXFmR0dW?=
 =?utf-8?B?WlFYYlBsbWhPUGVsRVorYXFNZkV3VGVTd01nZnpMa29NZzY5WHNkTHJCZnk2?=
 =?utf-8?B?cXJMU2xGNkFCQXg5MkpGaGFuRDYrMEJWeFBJVzI3R3h1dVZObFVWcGZrSXJ1?=
 =?utf-8?B?dnZIeUI0WGw0aWo4K2NDRzNDS1lxUWE5ZTFNN1NTYTJOcVBJQUozQXdMOWEz?=
 =?utf-8?B?RHY3eDlwUktTWjRlM005L1N1ai9QcWZvRkV1eEwwWUhNM3VxMlRKZ3VmUkpL?=
 =?utf-8?B?MHFLOCtxanNSUnFHTTBaMy9JbGZWeFYxdStZbHp5VW5iaDNEcnVnemludEdv?=
 =?utf-8?B?TGJ3d09TQnA5MnFVbUNNSFVIcjd4amVZN0FtOThBa2xzNWFFOTllVjN6K0Zw?=
 =?utf-8?B?a1ZDMkFFUE5PZVZkanArd1F6UHlCK0k4a1pBdHlaT3dBaDNOM1J6ZHplQUNO?=
 =?utf-8?B?aVdkMks3KzdZcWRFWHJFbU40RlROMVpJTzlUbm5MeklBVkVaYWhpdklMcDZC?=
 =?utf-8?B?WloxR0FBa0dMSFZmUjVVOGJWRTFyQmIrdFNwbHVtcmY5TXIrTGt0NTAxc2M4?=
 =?utf-8?B?dXFsWmE4bzRYYjVIQVp6NWNhL2VETDJ2dnZZSUN2cHowTStSSDU2YzlDZmta?=
 =?utf-8?B?UE9mM29IVkQxbkVuUHZNeVhYdTVsbnlhdDRFTTl4S3M0bGhjR0ZmeUpXZWFK?=
 =?utf-8?B?eGtGZ0NEWmpCUGhtNTVvVTBTY2lwOW9CY29yQUNBWmFGOTBTRTZLN3NTejR2?=
 =?utf-8?B?UzZ4dFJ0SkNCWVcvb2dWbTVZTXZaUlpiYUxGYi90ZEZJQUM5bU5VZGtxRk0z?=
 =?utf-8?B?eDc1L3pvWU16cHJReGptNXNzYjhEUUh4cVZXeHR3UGJXN25iSDg2SW9KRXZ0?=
 =?utf-8?B?bVpQSHYwNWk5MDBWT2RUaVVtVzcrQzBvME92RXZkYjdrUzR1REtSTTBIM1pN?=
 =?utf-8?B?SUREOWJHR0JVTm5xSStITDU5Rlgyd0grR3MvaXQ2ajcwa1dBcHd5U0FxTEp6?=
 =?utf-8?B?RkM5Z01xUDhKT2xtUWYzL1M1MWdrS3dhUTlzMG1xTy96MHJZdUlnTTYxc05S?=
 =?utf-8?B?b1dOZ2tOQVMvQlFJMlJPVGQ4MHVWcVY3NWlJT1NaL2xPQ2R6ZWc3a3d4a1Aw?=
 =?utf-8?B?bzdHSWNWS1ZRS1pHZENqcjNKUUVCSGJWak5EVUdsWDhGenNMTFEvcFNmVjNB?=
 =?utf-8?B?czZPd0NHd0NoSm43Z2czVkJYaW9ZZmxiS3J3YWs2K0szVmhRY1Y3NituS0xy?=
 =?utf-8?B?RndqYXhQRDRCbGs4SGlNRTJoTnUvT1ZURDZYcUZQQmpFb2FvN0dtdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465fb559-7f46-4ae6-b223-08deb33085d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 09:50:11.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRaetntfvYPJUUewecF2+KRfaFRDx5MlZzoH5cf5EKeKIpNhUbge5ZJttBZ+rc7ofGDwzF+Q0AVOlmu6gTf4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5205

On 16.05.26 10:48, Hannes Diethelm wrote:
> Am 27.04.26 um 11:18 schrieb Florian Bezdeka:
>> On Sun, 2026-04-26 at 23:32 +0200, Hannes Diethelm wrote:
>>> Am 26.04.26 um 21:24 schrieb Philippe Gerum:
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>> Am 25.04.26 um 20:50 schrieb Philippe Gerum:
>>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>>
>>>>>>> Hello
>>>>>>>
>>>>>>> There is a Kernel WARNING: "notifier callback netevent_handler
>>>>>>> already registered right after boot". It is repeated 5 times.
>>>>>>>
>>>>>>> Config:
>>>>>>> Debian Trixie with xfce4 Desktop
>>>>>>> libevl: r56
>>>>>>> linux-evl: v6.12.67-evl2-rebase
>>>>>>>
>>>>>>> I traced the issue already trough the following code:
>>>>>>> net/core/net_namespace.c:355
>>>>>>> kernel/evl/net/net.c:35
>>>>>>> kernel/evl/net/ipv4/ipv4.c:41
>>>>>>> kernel/evl/net/ipv4/arp.c:323
>>>>>>>
>>>>>>> However, I lack the knowledge to do a proper fix. One way would
>>>>>>> be to just check in evl_net_init_arp() if it is already
>>>>>>> registered and don't do it more than once but that doesn't feel
>>>>>>> right.
>>>>>> It looks like the system is instantiating multiple network
>>>>>> namespaces,
>>>>>> for each of which we set up an ARP front cache by calling
>>>>>> evl_net_init_arp(). Bad idea to hook a system-wide handler there as
>>>>>> well. Could you confirm this fix [1] works for you?
>>>>>> Thanks for reporting this.
>>>>>> [1]
>>>>>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/
>>>>>> commit/569beef061321c2c00d775b13ad0aec1a1d2a416
>>>>>>
>>>>>
>>>>> Thanks, that was fast. The WARNING is gone now.
>>>>>
>>>>> But now after just updating to the kernel including your fix, I
>>>>> have a different behavior on
>>>>> incoming packages. It seams that the default when no filter is set
>>>>> has changed from EVL_RX_SKIP to EVL_RX_ACCEPT.
>>>>>
>>>>> linux-evl: v6.12.67-evl2-rebase
>>>>> -After evl net -ei enp7s0, I can ping another host.
>>>>> -oob-net-icmp does only receive packages when I use an eBPF filter
>>>>> with EVL_RX_ACCEPT
>>>>> -After that, ping doesn't work any more
>>>>>
>>>>> linux-evl: v6.12.y-cip-evl-rebase
>>>>> -After evl net -ei enp7s0, I can NOT ping another host.
>>>>> -oob-net-icmp does receive packages
>>>>> -If I use an eBPF filter returning EVL_RX_SKIP, I can ping again
>>>>>
>>>>> I am not using VLAN's.
>>>>>
>>>>> Was that changed on purpose?
>>>>
>>>> Yes, this is implemented by this commit [1]. The rationale here is that
>>>> if you turn on the oob port directly on a base device, then the evl net
>>>> stack may assume that the device is entirely dedicated to oob traffic,
>>>> as opposed to enabling such port on some upper device based on the
>>>> former (e.g. a VLAN interface). As a result, all ingress traffic
>>>> received by such base device is diverted (RX_ACCEPT) to the evl net
>>>> stack.
>>>>
>>>> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/
>>>> commit/3026e69cee2a1de047818fa06ad8c44623461a0d
>>>>
>>>
>>> This makes sense. It took me some time to get evl reading packages by
>>> activating an eBPF filter and it's mostly save to assume that you don't
>>> have mixed traffic on an real time network interface. With this change,
>>> a filter is not needed any more.
>>>
>>> A bit off topic:
>>>
>>> Is there anything like rtping for evl? I have seen oob-net-icmp.c but
>>> this is answering requests.
>>>
>>> In Xenomai3, there is a debian package configuration. Any interest in
>>> one for libevl? I have one working but it's still very basic. If it's
>>> presentable, I can send a patch.
>>
>> There is a debianization for x4 in xenomai-images already. See [1].
>> Can't tell why it hasn't been upstreamed yet. Maybe Tobias or Philippe
>> can comment on that.
>>
>> [1] https://gitlab.com/Xenomai/xenomai-images/-/tree/master/recipes-
>> xenomai/libevl/files/debian
> 
> Thanks for the hint. This debianization is also basic, looks like it is
> only built for
> CI purpose. But it helps to improve my version.
> 
> There are a few things missing:
> - Build dependency's

Which one? We are building the package in a clean sbuild env, so missing
build dependencies should have been revealed.

Note that Build-Depends is templated so that we could adjust it to
different libevl versions (not needed right now, though).

> - Optional: evl group + udev rules to allow non-root usage
> - Probably much more for being a install & use debian package
> 

Always open for patches to improve things. We might also move
debianization to libevl (like done for Xenomai 3) if that brings more
value to users.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
