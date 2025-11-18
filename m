Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960833431F5
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468988; cv=fail; b=ahKVPGOtOGVJh5GBCrfqX1BgMxXvhW21mlFWu6w2c47+BJGt975iv9dovsQLm/e66r89/YSfHOX41w1wgfaDlFIUoXHME1kYIlpQTiECR8EtIGzRSOtkQVzN9zGzQ/wHMBZjRnLpGoIcdu/XoRnUZIdyUXRHcwu1ao1JVH19H84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468988; c=relaxed/simple;
	bh=EqghvdutFsGm1tmm+4L/8DuQdnnw5F9EF1zre4XnqnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MmkH8pAnC6eRKMG3PSh/9Iep3hUjD5Vi/PJsgFU13XcZF4XCa2uMbB8ysCVkxewfkcQlcAgArFz/aUujXsSxIe7K2VAQsWvCb83vYYFn357Nv4RPul0nG1djoClKIMJ6K44ZKnIHYXr4Hipch2FMmAn/f2koRPVGTsjQv6/dM3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oz+2Z0Ws; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oz+2Z0Ws"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id D8DA541C7A
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 12:29:43 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B55B727E0E31;
	Tue, 18 Nov 2025 13:29:43 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=oz+2Z0Ws;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c201::1 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-Status: LEGIT
X-GND-State: 0
X-GND-VSscore: -100
X-GND-VSVerdict: clean
X-GND-VScause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddufedvucetufdoteggodetrfdotffvuc
	frrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthem
	uceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvvehfhf
	gjtgfgggesthejredttddvjeenucfhrhhomheplfgrnhcumfhishiikhgruceojhgrnhdrkhhishii
	khgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeelveffvdfftdetgeelvedttd
	fhvdekteeijedvudeigeettdekheeuteetheetudenucffohhmrghinhepghhithhlrggsrdgtohhm
	necukfhppedvrgdtudemudduudemfhegtdefmegtvddtudemmedupddviedtfeemuddtrgeimedvtd
	gsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgr
	tddumeduuddumehfgedtfeemtgdvtddumeemuddphhgvlhhopeetofdtrfftkeefvegftddthedroh
	huthgsohhunhgurdhprhhothgvtghtihhonhdrohhuthhlohhokhdrtghomhdpmhgrihhlfhhrohhm
	pehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpqhhiugepueehheeujedvjefgtdfgfe
	dupdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhhpmhesgigvnhhomhgrihdrohhrghdprhgt
	phhtthhopeigvghnohhmrghiseigvghnohhmrghirdhorhhg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh08AmKmIfzkKomEZPR3CbuGvbcd41S2HcXfpHWEeilnZp1gcrZlco24tqfjEcXJc2wSLNTHPwJxKqCQ4fvbYYcnva37ZuEoTOWhA1NY3PDyztDPkWWi3YvCqsanGV2kz3G+o6NmbJ2Dg34K2K/W4VDKhV3bhqJEPE6mLi6jp5M9nXgcUzc03+hkcozZY4V2LAZjDxq5iYmsrrCkE6Lin8Jv+gBxqXrFys5oroN53PRnXx0KG8pbG/OLThvBNtsjCLF2Et1SfIW5LqnrT0syKa0BQZhLKqbOT1v+s+sgSkdfNsxQGVx321woFvSnTPLW3wpOCjvhsvXM9zoRSnJvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKjCOxOLhtJJjFMbnBRTzcdZHQwfD+YUufcf0TfSR7Q=;
 b=uCfozV/cefoqNs231Tm3qILAt+OywshEuFNmVDKZ1iUAO1d4bpfeot2HxIAowaEqMy50O7XbFwlEvsPvpxiEOSP50sZpjrnXSFcJLAV9Y/HGr8JqcY+FtCK7PXzq6Jh2+8KT4zJKZjz0M4+2j9II4L05J3RG0+u95QNrvM/bFCLgtecZsAG2mCBicnzwInO8klkQ4/rcN97HlRSqkTCr/ljhDAnBk6B9E0lRbPJFwo20Foba0ACgrqJBCkvb6TqYO4y9fVbhcVmy4DEJ6SblEkJbt6CUhHhpaVE+X3H9Xb7HxYIfFMH3izq06QWPQuDBJTt3I8LkLGtIn1Y6gMuECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKjCOxOLhtJJjFMbnBRTzcdZHQwfD+YUufcf0TfSR7Q=;
 b=oz+2Z0Wsff0eCLKBZWx3jAMHWVQZftGjUgFal+k/7/lQIZAy9+r32zVotlMwfJHjDZT+FTbj1Rpyg9D5g9jCs8W97LrBJ3m5ykd+WWddR8v53Sxw3VMP9LgkssBMadxt+m/01mviczJmabZ8PiCeXx7tPw7CYhotPpRJDa0WJLYJcFmaEHC0jNIWrwUXw1l7HwYBxOoqFaR/4HUAtb0m8UyMYDRE3bZJ8OgNHn8L01VmGuv3mDeEtuAXNukRB0rc3YJE9dFqPsdeI2hbSBTiwG3NZEw99FdxCJL51TC5E2vsq4ZX9zQv11u7Bh7MSOHwD0uEER3WWn9+LzDzfczN9Q==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 12:29:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 12:29:41 +0000
Message-ID: <90a92c08-e3e6-4b78-a712-8459ae40889e@siemens.com>
Date: Tue, 18 Nov 2025 13:29:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "rpm@xenomai.org" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
 <87bjn1m28m.fsf@xenomai.org>
 <e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
 <f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
 <8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
 <682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
 <87qzvrkcip.fsf@xenomai.org>
 <ed58111d2e01e76f3a64df0379e4f71e90680f0b.camel@siemens.com>
 <f036500881b880d81d25272a4f4745903f28a7a7.camel@siemens.com>
 <6a1784b2fbae193c70a08f6a840e2d0a615d5fdc.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6a1784b2fbae193c70a08f6a840e2d0a615d5fdc.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aa2d99-7146-47c9-9abe-08de269e25f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm1QR1A1S1Z5QmMxbEludFFPT29xV09SVHB5dGpMUlcvQlRYOFpiMGU3Rnk4?=
 =?utf-8?B?THAzd2lmalZKbXNMWXlmcVhWQktxTFVqUnc1dkk4YS9oZnlrZEpiTjBKU0o5?=
 =?utf-8?B?M1JUdnk0alpqT083OHpkNXdLQWlxQ0E4VG8ybFM1V1d6T2ZhOFI1VUNUdkRF?=
 =?utf-8?B?aEc2SmhiYmtvRmh4QStVd0dtei9oWE4wZUxrMjM0QU1SUUlDMlhpV1B0ZE5F?=
 =?utf-8?B?bkJhd0NMSHE1cWtFb240UEdVUHlkUXpUSk5Oa29reHlOWGtmdG1SbVRVamYv?=
 =?utf-8?B?RzZUYVhEUnBhWHRFNUJ5WFd0VTNXc25EYlhBcXU5RkJ6RnE1UjRLYSt5WHFQ?=
 =?utf-8?B?VEtzUWx5WmVEclVyWTJyeERGclNXcEpsWWRoOU5EVTNWdWFFa0JrVFdVclRC?=
 =?utf-8?B?VzVJSkgyWGdFOFE3ZEFDQ2lXL0ZUcjRSSDRJQkFvcUNBOGRFNXNBTnNmaTFD?=
 =?utf-8?B?bTJRK3lxd1F5Z2lUS3VUR2FjYXJ5NGtINUUreGF3QWJwN2g4RDJ0ZUhIc2R5?=
 =?utf-8?B?NTZNYitWWDRGdXZ6Q1BpUTAvWXpBRTR6VHB0OGFVT0p3enV2QUQydjM4eGZM?=
 =?utf-8?B?L01LejM1SEhrcEtRMU1oNzFqSVlOZlo5d1oxY0J4MEVBMGpvTlVLYkRQYjVY?=
 =?utf-8?B?V012cmpqRlJUUWtBeUM3SEhTbkM2dmVTampMbzZndjRxeERvc1ptVmhmYjdw?=
 =?utf-8?B?RVVjNk1TdksxbmlraEFmRTF3Z0o2V3NoUHZxOERIcmVKK0wzSzlrcUk5aCtR?=
 =?utf-8?B?eTVnVkFtMGl6MUU1UkF1cVBTb0h4aXJkWDNqOHh1MHFSQm1zcGE5NkxLN3FI?=
 =?utf-8?B?cm1YSEJiRGNIcDEzeVJISHpYUGN5cG9ZdlhtaG1FalRVemZjNnVxdTFiM2d4?=
 =?utf-8?B?ZkN6TFcrWjU5a0ZWajdRenRWSEllWW9ubTE2REtBMDdWYTZ0UndKcGMxMW44?=
 =?utf-8?B?eXB1VGUrejh1MjNyRmF5N2g3a0VQRmFsTEY1U1R0OGFjRVVtREgwR1dNTlpz?=
 =?utf-8?B?SU4wWW1zbUhaTWRzQjR1NGx2SFZpRzhLNmx3WXNudU1VZXhUZm1OVlNFWjFm?=
 =?utf-8?B?Z1RHNjlMcUlBcXA0SUQ2T0doNkMwdStLLzdZcGRKN2VqVWhxZk5YaDZRbjJk?=
 =?utf-8?B?MldiV0gvYzhVYTQwb2xUdHJFU1pGK0Fvd21Jc3NpaFJiaFJXREJZYkxoV25F?=
 =?utf-8?B?WFdCdEd4YWFuWWJJV0JGb2JaSnlleFFSaXBLQ244R2F0Q25GZmZXM1BvbWdl?=
 =?utf-8?B?cHJPMTNYbGhlbUpMODRaRTVuZmdDeUQzQlZmaFgrUEN2eXY0WEhWaUp5b1B4?=
 =?utf-8?B?STFBMXpiMjJXcWRFKzFSWTNYb1ZFY2x0Nmg3QW4zTlE1U05rdEJWdTVadStr?=
 =?utf-8?B?NlhXSWl6QW9uL3NLWThiNlc2bWIwRGRpVXppVTcxb0NHZHZuQmpINGlpWTFr?=
 =?utf-8?B?Y0RCY1hlQWtPQ1lBeWhnRlVMZmxMWm1PR202K2JXV2VvdG5JKzNCRnJiUjJl?=
 =?utf-8?B?MmQ5WTE4Mm1yaUFnWUFob0U2ckVtZUorWko4ZVF5WVlQL2VldHdRRUtNVHNJ?=
 =?utf-8?B?OG1ZdHYzR1hUbVUvbTMrRUtyaEdtditIN1RsRFFiaVVYRUE5TGVBbDdIV28x?=
 =?utf-8?B?SjQ5QlVmKzBpT2czVFRtajhweEJUS1oxYXRsVDRZYXRCRjBUdUNhSXF2VTBG?=
 =?utf-8?B?bkw4enZhRFhad3lBR2xEeGNCaGVNZmc4c1VZNXJXdlF3NlUxTkNWUEdCTElj?=
 =?utf-8?B?RWZMdnBYUjlIWWtwSk5vZ3FMTlBKcjJmQ2F6aVBQRmdPdE0wRVNHMm1zYU16?=
 =?utf-8?B?UTgvRjVpRk8vVlhQU1VjdUZLRGNLeG9GUStRZWN1cERaWkFlNjhuM2wyV2Nv?=
 =?utf-8?B?a2M3TFJvVnRYUjdQQm5uKzJnVFRPSkpMeUZZL0RaU2p4dFF6a3kvZ09RRzZR?=
 =?utf-8?B?bnBpWFhQbGtTMjZvTkhqWmNrbVFIa0xxSFV4eXd1MURZd1dKZE5icHhoQjQv?=
 =?utf-8?B?R05zTXk2V1dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnQ3WkFYdTJKUHBSU2N3V3ZMaXNiTks0L2I2WXJ0cEd0ZmpveHd2bzNvcXQz?=
 =?utf-8?B?c0lTalExL1Y2VDFUQjFTOGRvRzRJUlJWZThUNnhWN3VCcmhrMVBlMU5GZzZr?=
 =?utf-8?B?V3RmeC9KakpaaTliVEpBUGhhRnVLamIyYWJWOTRWb0ZQaHdZZmxMOHEvV1VD?=
 =?utf-8?B?UEZGZGxHUWFzbkpUQWdjaEhmTGNyU2ZHVm45VTFab1JGZzkxR3ZFdWNwRW8w?=
 =?utf-8?B?ZmlrdDRRVUFKN0ZVMnM3WWo5bXd4THhxSTVHVm45Z1hjaHYzWFRRNk0zVWRr?=
 =?utf-8?B?a2JlRmE2Zk1HQzZ1akFpZTJXbmloMnYyMGN1d2Q1NlVqVisxQVAvYXdLUVVh?=
 =?utf-8?B?eU51ZG9mU2tiUkMwV0pwSmlURWU3eHJ6RVBJbWhBSWk2WS84YW9GVEdRYktN?=
 =?utf-8?B?TFBTSGpwWWNSR3BVVVNZZFlMZmIydEV1YlpySDdkQkVrcjN2RzBHWThwUjJI?=
 =?utf-8?B?TVNuNVJFU0hSOE05akduSzRRRnk2UnVMR2ZsSVNJeFRCVXZIZmZuS3hVSnpw?=
 =?utf-8?B?RlR5U3V2WFEvTG1qNkNOdHpLVEZYaGtyYk5hc2M1MDVodXFwZnY2azJmaTBP?=
 =?utf-8?B?cGdSaWNqbkx5NzN6YVJPSlhGNWFUcUdMRklMQk1CUE54MlU5VkdIT2hVbFFP?=
 =?utf-8?B?eVkrOFdyeWN2RXd1RUdKWXdBekRQL1ZWUUJWdU5XV0lhbmJ4SGNERE00MTFp?=
 =?utf-8?B?ZFdteEVDb25LWFFNZ2k2OVQvNDJkZ2ZwM2pzTkljQUNHa3VwZEI4TU5XcW1R?=
 =?utf-8?B?L213b1YxTHFaOEpBL0FleXlzMEJTUWZGYy9pTkFHWXVFUHN3RjZaVWJBRDZw?=
 =?utf-8?B?TmVBZ2M3QmFsT1ZiRkJjRVRlMGN4SG0wdHpBRFlWTEdjWVcxaENtT2MzdHNn?=
 =?utf-8?B?Ymk4NUN2RUoveDZhVHhmSThaUFZIWCtVNUdHOTBMZkM4ODYxZzlnS0NVOW1x?=
 =?utf-8?B?VzR3MExUd3BOQ1Z2aHM4SFhpeEkvV21PMGt2bUVMMWFHU0JYODQ1K0ptRUFT?=
 =?utf-8?B?eW9aUzRXdThvUVZoTUJUYTZhWmtCcXVjTTAvS3p0VjV0L08vd29XY2pZcy9Q?=
 =?utf-8?B?OFhpei9ENjRTWFVNT2NiMnd6cFFHVnFndXhtcGczQ0tKd0JQdkRJVnZja2Jr?=
 =?utf-8?B?aU0xRk5qZnZnUjNGOElYazJBWDVxalUyNFk4Q0RDR0NKY0F4WjBpQlZEVlk3?=
 =?utf-8?B?N21haDJvR0d4QXpSSzJKNU1laERUSXVjMUJIYi9iMkRMUHlnMnBGdnBISUxY?=
 =?utf-8?B?bVRjaTlWRzU2dnVYMkpuN3h1Sm5rdHBoWHh0YkpFNlpId3RtYTR4NGlwSzd3?=
 =?utf-8?B?eDhoZHBwUG0veWVtbGJiMm1FSS9ReGRsYWlkQytCaUFJbkoyeC95bVhjZGpu?=
 =?utf-8?B?akYxUFJIZ1ZXdnZxVDYrNmlOSnRialNyZlc3S0RTR2JjMmZxM0lIL2dvSGdt?=
 =?utf-8?B?ZnNic05SM1kwbG1sZTBsVGxQWHZlb3VqVHBlZEZRdExqRytvc1VXaGhhazhH?=
 =?utf-8?B?QnlOalAwMEE2d1kvVGVNcmY0SEgvQTdaeVhjRzdiSCtpL2YzNzVZQ1oweHNZ?=
 =?utf-8?B?TGxTS2tsaGFoMWV5aU1VYmwzYmhFZVNycm9PQjAzWDJHMllvZFhVdXo0N2Uz?=
 =?utf-8?B?OFBUZFc3NnJ5K1hUY2t6aTNxTG9uRXVhM21ydmlQUmFKdng5aGplUk9mUlEw?=
 =?utf-8?B?L1VhdmFRNDIzbEUrQlI5UW5ET0FPOHM2SkpkZ2M5aTBsbmN2dG9acXFZRzRu?=
 =?utf-8?B?OFNqVHZWMkh1RXlNQ1VhallIaE9rcEhrU0M2eW9EOEpuZEZQWlZyNk9FMmpM?=
 =?utf-8?B?NjdlMG5vV21aM29xQjZoTHJtc016QmI1eUpzeVVmUHVwaHJCYnVQcEZQVmpD?=
 =?utf-8?B?Z2ZTOGgrck9QeFAvUFE0cXNXNmFodUI5elRFZjNNM3hyZm8zMnZEd0dXNndx?=
 =?utf-8?B?eS92WkV2UEZDV0JxWjBQNUxRY3Rxb0U5VWdmejhoM1NPcHZKemFVbFlYRXZk?=
 =?utf-8?B?TWZnbWJyTE5BYmpYMkljS201cWxONjY1dThOUEZicXJ0dGtxdEQraXRKZzIv?=
 =?utf-8?B?TVRIdkV3VDl1RXFDT21MZmRmNGE3TVZRMlNZdXlBQXlIYWtlb3lDUllNdlJL?=
 =?utf-8?B?NDVkTjBKSDJvR0dmelpBYXBQUzEzMllpdi96MjNWNmZJSnFSWEtDdnFkZFRk?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aa2d99-7146-47c9-9abe-08de269e25f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 12:29:41.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dcn3v0fGEbudoPeElhP1/hWqMbJPiW0E9cMFWuAap25NKl/o/vCIozJJ3Kzl03wPZPHGoNGeKvq75wUBGe+1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5605
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvvehfhfgjtgfgggesthejredttddvjeenucfhrhhomheplfgrnhcumfhishiikhgruceojhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeelveffvdfftdetgeelvedttdfhvdekteeijedvudeigeettdekheeuteetheetudenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvdduuddpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduuddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

On 18.11.25 11:55, Florian Bezdeka wrote:
> On Wed, 2025-10-08 at 13:35 +0000, Bezdeka, Florian wrote:
>>>> lines:
>>>>
>>>> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
>>>> index 0958d5e2a..b8c0c39c5 100644
>>>> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
>>>> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
>>>> @@ -10,16 +10,20 @@
>>>>  #include <linux/errno.h>
>>>>  #include <asm/xenomai/uapi/fptest.h>
>>>>  #include <asm/hwcap.h>
>>>> +#include <asm/neon.h>
>>>>  
>>>>  #define have_fp (ELF_HWCAP & HWCAP_FP)
>>>>  
>>>>  static inline int fp_linux_begin(void)
>>>>  {
>>>> -	return -ENOSYS;
>>>> +	kernel_neon_begin();
>>>> +
>>>> +	return 0;
>>>>  }
>>>>  
>>>>  static inline void fp_linux_end(void)
>>>>  {
>>>> +	kernel_neon_end();
>>>>  }
>>>>  
>>>>  static inline int fp_detect(void)
>>>>
>>>> This was just done in v4 by [1], no issue detected afterwards by the
>>>> 'hectic' test (switchtest equivalent).
>>>>
>>>> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/0396a52a9b3dc352ef10e6a9d2ed096718ef5d80
>>>
>>> Thanks for the reminder...
>>>
>>> I'm quite sure I had sent that to the list. Might have got forgotten or
>>> it's hiding successfully in my xenomai queue. I will check and take
>>> care of the test enablement.
>>
>> I did some tests with that in-kernel FPU usage enabled. My tests were
>> based on xenomai/next with Kernels down to 5.10.
>>
>> Results:
>> - 5.10: Missing backport
>> - 5.15: Missing backport
>> - 6.1 : Has the backport but that looks slightly different compared to
>>         6.12. At least the following is needed to get the kernel into
>>         a "stable" state, but still no test success:
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 7ee823a6a5e45..be3d37554de0f 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -2216,6 +2216,7 @@ void fpsimd_suspend_inband(void)
>>  	 */
>>  	if (__this_cpu_read(fpsimd_context_busy)) {
>>  		fpsimd_save_state(kfpu);
>> +		__put_cpu_fpsimd_context();
>>  		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
>>  	}
>>  }
>> @@ -2224,8 +2225,11 @@ void fpsimd_resume_inband(void)
>>  {
>>  	struct user_fpsimd_state *kfpu =
>> this_cpu_ptr(&in_kernel_fpstate);
>>  
>> -	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED))
>> +	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED)) {
>>  		fpsimd_load_state(kfpu);
>> +		__get_cpu_fpsimd_context();
>> +	}
>> +
>>  }
>>  
>>  #endif
>>
>> - 6.12 and newer: OK
>>
>>
>> Btw: I'm on vacation for ~2 weeks now. So please don't expect any
>> progress on that topic ;-)
>>
> 
> I finally found some time to debug that issue again. To recap: As soon
> as I enable the in-kernel oob FPU usage (see patch at the beginning of
> this mail) the xenomai3 switchtest utility will fail when running ontop
> of Dovetail < 6.12.
> 
> The winner is
> 
> aefbab8e77eb ("arm64: fpsimd: Preserve/restore kernel mode NEON at context switch")
> 
> which is part of 6.8 and newer. That explains why Dovetail versions
> below 6.12 show this problem. It allows to preempt in-kernel FPU usage
> sections by implementing the necessary context save/restore.
> 
> My summary for now is that the hard_preempt_disable() in
> kernel_neon_begin() - as part of get_cpu_fpsimd_context() - does not
> work as it should. Seems we need a fix for Dovetail < 6.12.

It is not hard_preempt as there is a hard_cond_local_irq_restore at its
end, and that lifts all the preempt disabling we have in oob from
dovetail perspective: irqs off.

> 
> Could someone please have a look and share some thoughts? Confirming my
> assumption / theory would be a nice starting point for me.
> 
> Possible workaround: I could implement a version specific test
> enablement, but I'm not sure if that is papering over a real problem.
> The FPU usage in such a context looks valid to me.
> 

We should rather look into backporting that upstream commit, I would
say. Or does it have tons of dependencies?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
