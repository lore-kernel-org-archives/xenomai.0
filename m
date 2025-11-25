Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ADD523A
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054311; cv=fail; b=RErTEHqdBQma0l8Nk/G86srodDhjlggxcjIyS1/8SSi5OVVdT4qCPHhEyawVZIu0za3okYkUGVsjvpbFLrx0ovTTYfaJDhQDhJUwA6IQ8RlTTjZpc4pJu3KC6BA3gT+doq16WuZKcKVGy5nprvwb4mrEiowEjy7Y9opXClgpHJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054311; c=relaxed/simple;
	bh=hSTpv/ipacp0qcmkCY1Rs8CPhKaTgus3EbXsc4AA8KY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsEyUwFrf2ML9q6jMIaigThGv8UtCW+ciylzEVgmswrEmkGuMWDlkbOI5jf34VjqZekYPFW4HA2voLaO6mo1nOzGI5FXzTKbxIHfhPdv3HXrdIgG7jClanrmtXPPoXAHQjdNaKR6m9sMCvmhx9QpNqtDgGNNziu5lmEC5pXgTj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U1x7pere; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U1x7pere"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 8686643BEE
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 07:04:59 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 25AB1460DF2;
	Tue, 25 Nov 2025 08:04:58 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=U1x7pere;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c202::7 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-Status: LEGIT
X-GND-State: 0
X-GND-VScause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtkeefucetufdoteggodetrfdotffvuc
	frrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthem
	uceftddunecunecujfgurhepkffffgfuvfevfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpe
	flrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggft
	rfgrthhtvghrnhepvdehtddutdfhfffhleehveffkeefgeejhfduheektdejheehgfevvdegheduke
	einecuffhomhgrihhnpehtihgtkhgprhgvghhsrdhmhienucfkphepvdgrtddumeduuddumehfgedt
	feemtgdvtddvmeemjedpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvg
	hrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemudduudemfhegtdefmegtvddtvdem
	meejpdhhvghlohepifggigfrtfdtheevfgdttddurdhouhhtsghouhhnugdrphhrohhtvggtthhioh
	hnrdhouhhtlhhoohhkrdgtohhmpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgv
	nhhsrdgtohhmpdhqihgupedvheetuedugeeitdffhfdvpdhnsggprhgtphhtthhopedvpdhrtghpth
	htohepgigvnhhomhgrihesgigvnhhomhgrihdrohhrghdprhgtphhtthhopehrphhmseigvghnohhm
	rghirdhorhhg
X-GND-VSscore: 0
X-GND-VSVerdict: clean
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eneAYfihlYhvbNbZFPfrnObgRYAnBJVOQED7ziYPbCmFQDLWwMqbt7r0laC5WhOmhcKjfINXCNT1pkhv0BXu0l9NZ9rdNDJqakWIozXHayk+i9Q3EkE8owjW5kUFhI62faMjddRjUJA77GcS8OfEyoqSN3qAuaznzViZ3YWA37fLUxCBc5AlzjRY61yBXfaaoluFI0r12wuWmpRODoguu6lHV4KnNrE+fehYu4VCDUP/Cf3J6ccRspKZbAo1RCUOpWM/6DPgeimUfq+EypubKz3uzEXL8yFOe1KjAhCHcm9njLht7JkKUucvYc1sz37E/OcOKj+MhHSvJHQEj3VDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2md0EIbAc+kHm4AYnKx63ncIlObvyg8ttZEQ/AmqlkQ=;
 b=t7+dm6kKseeG6Lhdb+tAkNSypW7caX4lCeXPQctIEZ8Qq8kqYRKQuuRupJayRAYqm2nR3tT9IijjZYy7dt0ZOsnc9XH2z6VhEcntUy5y4zh1i/lK+dO31Q6gPXm+9Lft89k/4Uy4QwqvNTk7LyOJF3LMJEKcUhV4O3ryvqbWFr7ZUndyyuK7JXmPHPQlpTmefGzLvjacRUAUGf2RrI+QpOV9YnKzYpAXeR8vHN6Mvzs914427DGjj2x4/ZY2UsTs+XaBQXtVrhzsotmB/07P57O9JnS9ynVyb97RrMiYCte9EY/hdUAxhXQSvQ9aLrIamL/DbAJ76IBS8PP727cVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2md0EIbAc+kHm4AYnKx63ncIlObvyg8ttZEQ/AmqlkQ=;
 b=U1x7pereJfR8VcqTZAVenCCgePBfMKk8uDoNSBVFq8dIzzntMCcSlPpJrok9VLF8gUoA8B5Z6SEFp1LIBv0sLCLuXoJL2IKCUgRndh5450sVCCisdL4gT6vH7q4/IgktNcNFTSN024ui3hipBWUKhDcqt7qYyjGrqt8zjSqnHpWD4SsntWkCvdyGyWRmqxyP1sI0nF4macsoZCGblVrVXWI3awxXtr5ixClQs071l7DIWuw4SP/LKt+sFIBvMJAnvFqYeI2v/O2IHPEgJrrcWSLt0Xi6JX6wfwjKyopKSjZXgKsInSYcPeWJkuw0yFwaKpouIgOsJjBLepTucpvs9A==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 25 Nov
 2025 07:04:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 07:04:57 +0000
Message-ID: <f90ee402-6ee7-42bb-b58d-291bf9661369@siemens.com>
Date: Tue, 25 Nov 2025 08:04:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail]Re: Inquiry Regarding IRQF_TIMER Usage in
 arch_arm_timer on ARM64 (Jetson Platform Porting)
To: =?UTF-8?B?6ZmI5Lyf?= <chenwei43@xiaomi.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: =?UTF-8?B?6YKx5paH5bm/?= <qiuwenguang@xiaomi.com>,
 =?UTF-8?B?5byg5Yev?= <zhangkai16@xiaomi.com>, =?UTF-8?B?5a6J6L+q?=
 <andi6@xiaomi.com>
References: <f8c35bb814fe4e258fb82ba542b83f80@xiaomi.com>
 <e8922e1a-f56e-4ad4-b93f-6c1798bb9a7c@siemens.com>
 <797175708f5042788f4e2abb859b26f2@xiaomi.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <797175708f5042788f4e2abb859b26f2@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a15e7d-ea27-42c7-a73e-08de2bf0f153
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGtCUlMxaWdJbVNtWElYZHR6RkdldUhXS3E2dDNMZCtsOGM0ekxEaTR3aWNH?=
 =?utf-8?B?K3VoZHVyb0x1bytqYWpiVDBxcExuRzBFTkllbUhMbXRoeXkwbkxNU1RQalo1?=
 =?utf-8?B?ekpBZmZuOEk3RGlZbTdLeDF0dEZ3NDZVcFliQUZaWWtqY09yUWp3cUQ1NXJl?=
 =?utf-8?B?MjZFNTRvRFc1SExOUjRTakpuV3ZhOTkycXFQUEVHNnprcWxwcXRsWmxqc2pG?=
 =?utf-8?B?QnJ2Z01PTGpWUXExV01KYm1hdHFaQW5zY01HOHZ5blhCS3VHNGxqWjlOaUEx?=
 =?utf-8?B?MGFSRFg3Y0xSeUd5bTRXZ1BSYVVpa25kMnN1cDdMRDZoMDBoV1ZFZ3hidDJJ?=
 =?utf-8?B?bHZ3dWNXZEEwaHkvNEl3dEd5V0xKRCtHSjJTanNIWVJlaHZxUzJZb2Rjdk9o?=
 =?utf-8?B?NUFheGdkUnZMcG5HRjNrTDU4VFpoSW8rZFp3RGFjZ1BOcWwwTGtWWHpkQUp4?=
 =?utf-8?B?MCtzbFRJWDNuRFoxOWU2aHRDQlNwakJpQ2lZUmZmVFlySjJtTThjYlBwdmgw?=
 =?utf-8?B?ZkJkcVcvV0IzOUQzYkoreC96S3poa21QbXdlNG9MdE1IdVZrTU5FTnA3emJz?=
 =?utf-8?B?NmIwajNWeU85RHZLRGg2RW1WakdYRURzSmgxYm9vTjlXb0hCaVoxRUZTQTVk?=
 =?utf-8?B?UWtPWFhDTGNaOXFvU1ZiL3hKRjg5QS9MY1VtSFdGRWhad2lNWjdMSERrSzY2?=
 =?utf-8?B?TUlveUhXaUZ1bjNySzkzSUlJcjFCMXdLdGtrdlptOHJBMW02OEdEZER4Q3ZM?=
 =?utf-8?B?alN4VUdFUmJQd0ZzU3dRNVl3ZGpnR0ZJODJqT09zejcyRHBwUlZHdHRhWkZv?=
 =?utf-8?B?V2NGNWxzbDZYN2VQTDJYeXRXNmRSMHNRdGV1bFYxdzE0bG1VQ0tZRU5ibkZz?=
 =?utf-8?B?RWV2TnVpb3d2SCtEUlpSdlM0STBmVVdOaGFjUExOT2xRNmVXTEEza2F2NjZD?=
 =?utf-8?B?UVdMbjhURXRqeVlmb0pha25sV3JZWEpMUFlFU2k0WWRVREQxbnpEVTVHWkpL?=
 =?utf-8?B?NVVsU2J0OXFnazlMWFBzcXFneWgwWC9ZL2JOaVQ0UEVqMDc5REN4SEZTTnFl?=
 =?utf-8?B?YzVudDhLbGFLRThKV2dFeUUxQXlFR1FlcG5lT242Y2ptVlVJRHcwQUFORm90?=
 =?utf-8?B?ZEQvNjNOeGtaK2dibE1ranFHOFZ0UW1LVU9JVFlIWkFiS0lkTWRrbjZiSzhx?=
 =?utf-8?B?L0kzUlBlV1RFeGV4c1JpK0pWaHZSWXMyWHU5SVF1QXNmWnhuSnF3ZUIrZENE?=
 =?utf-8?B?QVVneEFBajNIbGZmRnFYaVNzYnJ0dEtHMStXWHM5UkRJVjZOR2xHU1B5MXN5?=
 =?utf-8?B?UitKNGNuZ0tPNVVtK20rM0I3SGVZUVhxT29GMklrMUFodmpxcEpqMkZtRlJB?=
 =?utf-8?B?djM5R2FVZm12U1BpZlVvL3ZTVlhQNFdRMXF0MnpSZXh3dnhHSEdwZDhiREhI?=
 =?utf-8?B?YmpzNHVCMFVaZUtyWkNZNDE1VTh4WW5JQmo5ZzNDeHY1OG9XdkpZeFduZ3Vu?=
 =?utf-8?B?cmg4c3NzWFZXZHpxc1B2MWgzQWpIc0ZUcjM0UTNaZ1NlVFNlaThrRU1nUXBw?=
 =?utf-8?B?NlRydjdSLzdXWVN0NS9QKzlBLzQvWE1BTTdaR2tHd0hidGNRSFF4VWZUcy9M?=
 =?utf-8?B?MElETldERmRMbnVwYkNjZzJCME0zQnpTUldlL2wxL0hSWEFyZ0I5TlFINU56?=
 =?utf-8?B?VkhSQ3pFWlZPclZNTEg3bWNDcGt1OTh3NW1mWnB6UmRuUG5ySGJwZEd6UlJ6?=
 =?utf-8?B?M3NEK2JpUTlhZWNxQ2ZGK01mdHJJMnF1MGdndkZaZkd4QW5UVUh6MVRKSU5s?=
 =?utf-8?B?YkxoQVNiYXNSMmRucTB6bHhKRmV0TmNjYjZDQ1IyR0JRQU0wUFd3dW5wSHd3?=
 =?utf-8?B?NzlXeEdzODVYT3FlUGprYzF4VGk0Nms5RWQ0M1FYZmJLN1BWV2I1SXZPbjJt?=
 =?utf-8?B?UnVtTG1yTFpOdzhuRVBabDRIS1d6bTZSWUNVR3g3MFFSaGxidEx2RGs0ejNW?=
 =?utf-8?B?M2hpUDhSb3Y2eXY1NDRoSmxKZFFnUmg5aGZ5cXl2NkkveFVkT2RJdkJtazNG?=
 =?utf-8?Q?FeU0LA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGVEcVNQNXA0Qys2emhNVzAzeVpDQWdmYXBYZkZxRUZtWExSNHprZ0IxMXVZ?=
 =?utf-8?B?TTNKalNZQk5XdVRIN1ZQSXBTcnI1elY3UGVzRHpsRzhRbTVKdGJYa09SZWFy?=
 =?utf-8?B?OHcwbHhuK3BRL0JuU21GOUhHY1N5VER4U1pLWWVwNzFRZ2dVY3VoT1AzVllT?=
 =?utf-8?B?eE05U2hzS243T2FyVHB3eFgyMG9RcTVsU1NtelZzSWROQnN2WU4zNnlQNUZs?=
 =?utf-8?B?c0ExS05NQUtMRmlOTk9YT2g1S2o1ZHRreTlNT1BYYzVVUDI3KzBBK20zNXdw?=
 =?utf-8?B?N09mYmx3SUFLVXBEWWFzKzgzci81Z2VtVlFIUHE3QVlZYWhPbFNYWFdQWTNT?=
 =?utf-8?B?bmFCamo4bEtBcXIzcjd6THNEdVVIL3h2VUFNMUJqQ09sUHhVZGpjTGdQMWo5?=
 =?utf-8?B?TGpTZExuUEdHUWtaRytkQ2NKLzVkaklvRGhLL3JCNURLeVdiQjRtZURlU1pP?=
 =?utf-8?B?L3JJc2lSQnBvNlNING1WM2QxTExoUEkvWURoSDV5UmxZZjBkM00ydmF2Rk5G?=
 =?utf-8?B?VjU5WndrUlhIaDR1bmtoZlIzeityWXVDRVcwZ0g0dEozUjVDeG80VVBxSytH?=
 =?utf-8?B?Y3BxRjMraldGRXVNK0FnMTNnMTFCT2UwcEZJZWlnU0dHM2xmQkI3MVVudkI0?=
 =?utf-8?B?TklnOGs0M0hFV2RIQnJaNmZ0Yjk4NjgvQW5zWGJVNzVvdldadk04bkVJc1pN?=
 =?utf-8?B?Y28yYjNyQUFPRkFVYmtuZ3d6T2k1cFM5RERyTDFhbFJYOWdydEpxcjhVMDA4?=
 =?utf-8?B?SFNxYm5DaFZBQTRIWGphcUtFQmh2RFFGbmc0TE50SHFWR1lucnNQVWxCdG1B?=
 =?utf-8?B?blhiMzcza05NSEpzUzZROGxsWUdaUUlxVmNzTHdiZ2t2eWdidjI1dHppRlBM?=
 =?utf-8?B?TnlxaVEzcUdtRkFWUjArbUVTMURJUVNsODQrQks2QmtIelptdDlwR1paRWdm?=
 =?utf-8?B?WnBQL0ZabnFsdjZuMExhWHVnWktMbE5DZzM2TjRvTjQ0aWJia1Y1NlY0ZVpM?=
 =?utf-8?B?cUNOdFdWS3lsbXNTVGhHSDZYUGFJT1czOVBZVE90dDlROUZSMmVhU3VycEpI?=
 =?utf-8?B?dE8vaVRabUJPZGRFcnRwdXF6Q2Z5c1NEc0JzL1FjVXpqTG9Fd1J6U2RwakdU?=
 =?utf-8?B?R3kvMlM3TXNBLyt1UnhPU2JiNGkvQlZzV1JjSmFSdVR4ZFB3aVYwK1BjZTRP?=
 =?utf-8?B?UTdXU1g3K3Z1dG5ERHBsbDgzUDRaNFlSbFF2S3MrZlFNRlk1ZVdmRFcwcVBv?=
 =?utf-8?B?OWRCaUhpLyswOEcwTTlMYS9jQW8vdldkb0ZjZHVWd1ZBeWZ1UHFCTHJ3SjdW?=
 =?utf-8?B?WkJWc2plNWlzaHJqdVR5azR4MVRQQjZML3hTUENFWXVBOG9lOUF0eEpGRS9k?=
 =?utf-8?B?MFNoQWZVRndTTVB2RkpPVzFtSGhidkVzSFVrM0VlTVBCQjc2UG1oQVhvTFFu?=
 =?utf-8?B?LzV3R2c2bXBmNFJGZ2lXd2ExMzk0cTJPeUY1d3ROVHBSd2VrSkdkV3Y2NTla?=
 =?utf-8?B?NXRUVFBWLzIrTk5YcDY5eExFLy9aQW9YYzQ4UnBtbzk2cmdPZFl0OWYrNTRi?=
 =?utf-8?B?VmNnRmV5UGMvZGVTai9YMWRVUzFlVUFDNDNZSEcxdk9jbXkyeC9DQWNFZjM1?=
 =?utf-8?B?dS9UMWVhYWw1ZjFwY1VjUkliY1ZBcFMwSjVjQ0VQWk1HbHBiVFlUdXowOEVE?=
 =?utf-8?B?NXZjSVNDbUs1WWtxNjh4L2dJaFBLUkhsOXYrNzI4MWJMQjg0QW5WVnhuYVd1?=
 =?utf-8?B?Rys5SVJxTWhpSVRpaXE1QlRtdE9TMGdmbWkwdVVRVWMzeUFJQUp5NzY4cVhX?=
 =?utf-8?B?NnJFbVZSK3RqblVvQlRMc0twaFRicTZVSFVzNHZwZWFvSVRLN3dDbWt4QUNl?=
 =?utf-8?B?Ylh3TzJ0RGF5N3pTMkJsQ2lJZ3lnaFMzbnJjcVFhUGdIL0dwOFZlNVFiZjN6?=
 =?utf-8?B?N1ZFUHhlQ2lrL0c1K1o5aEJkT1JpQzlwVkJwM0ZISXhCenQ4eUdLcDd0RGtK?=
 =?utf-8?B?bkNQOUk5UjRmaVFkSlJCQk9GZEtKZStaRmg0UnJqVXkvbDhEczNKWjNueWdC?=
 =?utf-8?B?aHowT0F3OURQOW0waVZWMU4xNkwzWmhHS3p4ZjNucElobXd1dytheGJ6MWJy?=
 =?utf-8?B?YnBiT2ZwSjFsdDVWWHRtVVN3NkVKYXh1VGswdDFpaEdlbk51NFhoOW5Sc3p4?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a15e7d-ea27-42c7-a73e-08de2bf0f153
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:04:57.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKVswT+cocbN3PD+46vWW4t1MNW+W5SwEhcXndDaWpUTddSMMq+w4eeKGVQv5gIY2fwgYuvqhgyNVOffPhAqLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8331
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffffgfuvfevfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepvdehtddutdfhfffhleehveffkeefgeejhfduheektdejheehgfevvdeghedukeeinecuffhomhgrihhnpehtihgtkhgprhgvghhsrdhmhienucfkphepvddujedrjedtrddujeekrddvuddtpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddtpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 25.11.25 03:07, 陈伟 wrote:
> Hi, Jan.
> 
> Thanks for your reply.
> 
> 
>>> Dear Xenomai Community:
>>> I am a developer at Xiaomi working on porting Xenomai to the NVIDIA Jetson
>>> (ARM64) platform. During the porting process, I
>>> happened to encounter an issue that I would like to confirm and seek
>>>guidance on.
> 
>>What is your kernel version? And are you targeting some Nvidia
>>downstream kernel, or already upstream? Last time I checked for Orin,
>>upstream (+their infamous downstream GPU driver) was fairly usable, and
>>that was somewhere between 6.1 and 6.12 IIRC.
> 
> 
> I’m using the Total Downstream 6.8 kernel from NV, which works well

Oh... risky path, Ubuntu baseline plus NV changes...

I would still recommend giving 6.12 or 6.17 (soon to be replaced with
upcoming 6.18-lts) ad try. Nvidia does officially support mainline, so
this is not unrealistic. And it can be much cleaner (I found strange
things in the NV kernel...), and your maintenance efforts will go down.

> overall, except for some issues with the display driver. I believe the
> problem is related to the driver itself rather than an issue with
> Xenomai or the porting process.
> 
> 
>>> In the copy_timer_regs function, checking is performed on desc->action-
>>> >flags for the __IRQF_TIMER flag. If this flag is present,
>>> The function updates pipeline.tick_regs (which includes PC and PSTATE
>>> information on ARM64). However, in arch_arm_timer.c,
>>> when registering the interrupt, the code uses:
>>>request_percpu_irq(ppi, xx, "arch_timer", arch_timer_evt);instead
>>> of:__request_percpu_irq(ppi, xx, IRQF_TIMER, "arch_timer",
>>>arch_timer_evt);As a result, the timer interrupt never carries the
>>> IRQF_TIMER flag, and copy_timer_regs never updates pipeline.tick_regs.
>>>
>> >My question is:1. Is the omission of IRQF_TIMER intentional in
>> >arch_arm_timer.c, or is this something that should have been updated but
>> >was overlooked?
>> >2. If this design is intentional, could you please clarify the rationale
>> >behind it?Thank you very much for your time and assistance.
> 
>>I think this is even a question to upstream Linux because it's not
>>dovetail which invented IRQF_TIMER. I suspect we need something like
>>this - in upstream:
> 
> 
> As you mentioned, IRQF_TIMER is a concept from the upstream Linux
> kernel. However, I’ve noticed a difference in how arm_arm_timer and
> arm_global_timer are handled. Specifically, arm_global_timer was adapted
> from request_percpu_irq to __request_percpu_irq with IRQF_TIMER during
> the Dovetail porting, while arm_arch_timer was not. I’m not sure if this
> difference is due to hardware or something else, so I’m looking to get
> feedback from the community on this.
> 

Yeah, this was likely just forgotten. I may still be worth to push
upstream towards consistent flagging. If that should have side effects,
we are better off identifying and resolving them.

> 
> 
>>diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>index 90aeff44a276..05a85067beef 100644
>>--- a/drivers/clocksource/arm_arch_timer.c
>>+++ b/drivers/clocksource/arm_arch_timer.c
>>@@ -1023,25 +1023,29 @@ static int __init arch_timer_register(void)
>>       ppi = arch_timer_ppi[arch_timer_uses_ppi];
>>        switch (arch_timer_uses_ppi) {
>>        case ARCH_TIMER_VIRT_PPI:
>>-               err = request_percpu_irq(ppi, arch_timer_handler_virt,
>>-                                        "arch_timer", arch_timer_evt);
>>+               err = __request_percpu_irq(ppi, arch_timer_handler_virt,
>>+                                          IRQF_TIMER, "arch_timer",
>>+                                          arch_timer_evt);
>>               break;
>>        case ARCH_TIMER_PHYS_SECURE_PPI:
>>        case ARCH_TIMER_PHYS_NONSECURE_PPI:
>>-               err = request_percpu_irq(ppi, arch_timer_handler_phys,
>>-                                        "arch_timer", arch_timer_evt);
>>+               err = __request_percpu_irq(ppi, arch_timer_handler_phys,
>>+                                          IRQF_TIME, "arch_timer",
>>+                                          arch_timer_evt);
>>               if (!err && arch_timer_has_nonsecure_ppi()) {
>>                        ppi = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
>>-                       err = request_percpu_irq(ppi, arch_timer_handler_phys,
>>-                                                "arch_timer", arch_timer_evt);
>>+                       err = __request_percpu_irq(ppi, arch_timer_handler_phys,
>>+                                                  IRQF_TIMER, "arch_timer",
>>+                                                  arch_timer_evt);
>>                        if (err)
>>                                free_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_SECURE_PPI],
>>                                                arch_timer_evt);
>>                }
>>                break;
>>        case ARCH_TIMER_HYP_PPI:
>>-               err = request_percpu_irq(ppi, arch_timer_handler_phys,
>>-                                        "arch_timer", arch_timer_evt);
>>+               err = __request_percpu_irq(ppi, arch_timer_handler_phys,
>>+                                          IRQF_TIMER, "arch_timer",
>>+                                          arch_timer_evt);
>>               break;
>>        default:
>>                BUG();
> 
>>(untested)
> 
>>Maybe the extra semantics of IRQF_TIMER are not needed for the arch
>>timers, and that is why the flag was never attached in upstream. Still,
>>it looks inconsistent and should probably be discussed with them.
> 
> 
> I’ve tried a similar patch to the code above before sending the email,
> and the tick_regs part works as expected. However, I don't assume there
> are no side effects. It may require more comprehensive testing. Thanks
> again for your input, and good luck to you!
> 

We are happy to take your feedback - or your patch proposals.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
