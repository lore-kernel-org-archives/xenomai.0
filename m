Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1814D6FE
	for <xenomai@lists.linux.dev>; Mon, 12 Aug 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471171; cv=fail; b=dYncLDkyL4TO+pgoSQfMYUeTBPDRb8rAQ7nwyKQk7aUwkc2NJ4Hf3u5EWKifc+IbWNOPR84rYYmoZdWSrDFOC9K0mE3zXgGtyD9tGa7APpXkCDAqNzelzmNoWo9rm/wtLfltzriAVntq1bEnALR0z85uhgcCdptBuiFROHnONCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471171; c=relaxed/simple;
	bh=aNSpTI7nIkh/w8GI27mmmks/o+6nr5f5aS4dAyOpXGI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LLprTtsLUJEE0m4Vi0HtQGU87H+sqwwuG+B/hpC8yKx8rpgbV5Zfs75PD1DIGyYw5MtE1N9cFOF4llND0jDWbeElMHOGYKDqi4w0UKGzObnSgi9WhOhGq2kAso814QD8dOQ+Lnea52W0k+Qd35K27NLdUpCR7YEXNjbW9jZyweM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pt22d89z; arc=fail smtp.client-ip=40.107.104.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pt22d89z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7+/5tlxAR9O9o9BdpP+iAlwrXCvrLIVO6S/sLDTtvfwEbITLZt1vwEuqQl28UoBZUd0zuKaLT6du5w1GKEYAUvTNssqR03zqLj/W4/w9Z/dwj4AOAFH6wdbOOXhZk/LoPN3pdJIG6YeEvLEVNoVCCXaE3yJU1BtXWEFdeikfqcFywtFlURDfCUGFoV9PJaxuk5Jab8zlTMopC3brHQS4GPmShAk7P/tCRkJEOYEUAtCup6k5S6A3MuQW1tzQkwzsdteks/xNFnSmD/+H6kVl7OSFoGkIgS1LQxX81lvRZMGC4Spta9pQ18xAAAij/ay5Ftz4AvHkNb1leiCZZQ5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9yrh8Q1w20thTsZwILD9BjH/EURrkJTA9CcZIwYO6Q=;
 b=GVikrZDWElw2baroL51cGa8PPdrWwC28Kf18MwJghvkQ6Ozjx4K+J/49XrlixrJR557ZeRZ3FRN250kjhFoAUtzn2nBanxZ5DO/QuSGdTnV7pt5le0aHN7feFSNMzx2nodLMPHknEQ0/iyVy+VJNglkgeVZKPHXNjUP5MWIFGCkwY86S5ErOBz8+0Hx1LRYp4SNj+wXnjTmovkysS6hXUsACoRdr7EMmrQfj4Q5ipMtolyjsZtK7kjoCFo0HH2qKL22+KzAn6ooxtwD863HYmi8ldYCdSt+raxdHP/VuizsaJbRlethBCghUj0cPTg5JkTHo3QXSxJiG+3KjZonMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9yrh8Q1w20thTsZwILD9BjH/EURrkJTA9CcZIwYO6Q=;
 b=pt22d89z8eq79VMayr5AU2D4qJ1XeDhrVvgOY6sCw5z78JE53ZQGEswXedbGvbWYqNATJNFpJ1ZRoWmrcViXwWYAMVhRSll8l2CoXWEHL73AYi87/lbxh0mHrKKJZoCKY+YwBcRfxWx4EvEmx7fZTacGdqCB83lJRYf3xc963gIO+VFXC0w/0lM/PTlzFexq5x2pzNT69yeL8PQf5x08bI7iD0zXY279kgO5Xtn4bNKHieug8p4ylJQZuVxack41d3JjlNgBWXI9FfNAY1OEZjaZm5kbN66PMkVb3PHdgI0c68rjVhweRQmENIOH1S3ciULTRno0BBNpWqnTeWW67Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7973.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:407::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 13:59:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 13:59:24 +0000
Message-ID: <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
Date: Mon, 12 Aug 2024 15:59:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "Mauro S." <mau.salvi@yahoo.com>, Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f95505-9e2e-462a-9cf2-08dcbad6f909
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGsvbEwzVzFaY2xFdGhKK0hsT2RCbnlxZmtrdWZqaWN4QWdoeE00VFkyU082?=
 =?utf-8?B?M21IbUp4ck13cFNNT2NCZG5mdEEvZHRZaHpUc0tidnhZRGRST2F4Y3FJMm41?=
 =?utf-8?B?czJURFE5M3FPbm8yYi9FV0E1TlF6MlM0RWZZN3BpUHBHZmRtcTVvREV2cFVo?=
 =?utf-8?B?bHdKR2g4am80KzdvdjB0UFJQUjlVZXVWNFUyUmdjZzJ0UzEwc1NPMTdEd01H?=
 =?utf-8?B?ZFFPUk5tZWhIMUFWenZCL0g2dlJaZVNQS3dlUGhIelBxbTNsQ1duNW5ONmRB?=
 =?utf-8?B?MzFtQ1RTbTc5akxCZm9yTE92YUxHVnJPeW8waDNEOUJWdVYvQWNRVWIrbnNs?=
 =?utf-8?B?eHB5WmZ2K2FPM0hSYjJCSFZMb0FleGE1RTJTWFc1b1RjTit4R1gzcWhOME9F?=
 =?utf-8?B?TVdUWjB6ZTIwQmFmYzRSemwyNU0zanQxdkhrUTJIOStHVnhkUEMxWHdVRHdJ?=
 =?utf-8?B?ekhtL21la3hvR2l1eHpHL0l4VzE3Mi9KcmQyem56UG9SVm9iRkZBSkFPRzB6?=
 =?utf-8?B?RVF3R2tuMVV6ZDhnZTRnUGFDVTdUdlF5UENRaE5sUllkSjZmeHZPVW02bzFN?=
 =?utf-8?B?amFDaUdnbHNzQ3lhR3VHU3ZNRVduc1IzWFNPRmpTcTFSWW1SNzU3UlllNEZx?=
 =?utf-8?B?YWcvdzZWN2Fra29PNCtBYWNaSXZXajIycWlXSXB4c2I0SHFrcWRwanFYeDFw?=
 =?utf-8?B?RldtRkhCYkJGRjBLTmFFcDI2SlFpbVVlTHJSV3lSUWhpNUp1UXI3dmp5WVlT?=
 =?utf-8?B?U2Zud245dkh3Z0sxa3BKYWxHVlluWDJSSEk0a2NmOTJ3MGRGT0VYTTZOWGIv?=
 =?utf-8?B?MVFWOURNbHhPdWM3VEJtS0w3YlJ1dUd5NkJ5TElvUU14RVBmVnRVd2ZUL2Yy?=
 =?utf-8?B?K3EvYmtybWs5bVpmc0RKYjdKUG1uTnBMT2pEUGl5OExmNldCa05nckM5UUd1?=
 =?utf-8?B?VFJqdTZJdWhvRTJLc1R3RTJvYmx3MHlVYVFKVWtkclNxT3lPaFZERHFaVVJT?=
 =?utf-8?B?VzRvdTVTR293YWpuWFF4bE9ZOUlFV2h6YWVVd1V2TUQ5KzM3Yjc4VjJpRmhz?=
 =?utf-8?B?NHI5KzNrL3FsR2xlYVExdjZIN2pXeUprN3NyUU93QmtXQnpvR0FMYUhxYVZB?=
 =?utf-8?B?ckxHdEJ5azJybCtxQkNRbU16d1pQYW5xaDhGRDdwek5SK0drdXpGbHNscnRJ?=
 =?utf-8?B?bW94WGFMTm4zN0JCUTlFaGhLZnZCTllpZ2Z4eVREdWlSd0M3QXJyMDNTNzBy?=
 =?utf-8?B?bk8weVVrWmFQUG1ZcndkUmprM2RjVFlzblNKQWZyNWs3SHJmdndJTERsaktL?=
 =?utf-8?B?K0FBajdXcHFMRjhodjJBV2NiL2grb1U2eDQ0VU1JYjFZTU5mZTFtU3l0dGFo?=
 =?utf-8?B?Z1B1WFo5L1g4dGpKOUhnSUIvRnNsOUpCSDNZY0g0NkxsVWxRR1hLRTFQcWpm?=
 =?utf-8?B?bkJYZTQ5WUZucE9QNXkwSTZ0eGVCQWF2U2pqL0VyWHZHSTZqWUJJSU5nbGJQ?=
 =?utf-8?B?Ty94cEhtY3hOSktxQStORkk5OHhqODhGQjBHMllzejFObnBWckxzTU4wZks4?=
 =?utf-8?B?VVVnTTR2ZjduTGU2WFIrN01na1NGVGhMYmorMC9LWDRCQmx4U2IzZ2RIQm9m?=
 =?utf-8?B?RGp6WUEwWGlPQmZHMUgxcmZMeGZYSENBenhYWG9IbUhpdmY3TVl5aDkrRDYv?=
 =?utf-8?B?M3g0Sys5dll0TXQwUTFiV0VySXZhOEsvSUQ5QnRYdjY1c1dRMDJSVTRuZEI4?=
 =?utf-8?B?ZTZUcmVaZVlEQm0rZlhTV2JPWnlVdEtkT21IV0k1T0ExK3l3SnRXQVg5bTlz?=
 =?utf-8?B?UWRiVWJ6SDhhdHJDVGRWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVpCamsvcGJ6eVNEbkI5aDYrby9mY1pNdGVBeU5MWDhxMjE0dmZyaEVkMHJD?=
 =?utf-8?B?TmVLUVhSVHRhamd6ZG9ValNINFVpczhSZGwwVGx3UkliVHQzbEVZZUx0MDNJ?=
 =?utf-8?B?NFVJRDNlQTZvU0g3bSs1NElFZ200VzRRbGJydkFGSzVnOGRKN2RrYjZvcUFi?=
 =?utf-8?B?eG55TEE4OUhubEZFc0JVUzBUdUdibCtqUG4wS3J5cnRMTmlpd0hKMkRLeDJi?=
 =?utf-8?B?TXd4bGE1WlRod1doT1V4dDdRME5XUFlGLzhtblMzbkQ4NzdyRWFudEIwQWRk?=
 =?utf-8?B?ZFByelUrZHhyOUc4VStXQnpGbWlQZkc1cXljSEt4Wm9KM2ptQTRhL0xrSkVa?=
 =?utf-8?B?NWQ1K250UGVvcXc0VS9wTDZ3ZUxxQ2d5U0d6dE5MREdxQVFldTI4V0w2a21W?=
 =?utf-8?B?cDd3bVBFb0hYYy83Zy8xWjVMaXB4Sy9oa2haNUNDTmRjNkIyWDhKV0wweWJ1?=
 =?utf-8?B?d1lNQjE4Y3Y3TXBCcm11ako1T3puN0ZEZ3QwMWtqM3BodmpicTRybUJSZjBZ?=
 =?utf-8?B?SkFObUpsbTNBQkxYQk5JdkhyemEvaXhFOVdWa1Y4NnB1bXdIYXdjMmduM25n?=
 =?utf-8?B?L0NFSUFDV214QmNPWE82enFUc0N2bXNGdnM2N0Ewc3p5czFYTzViQitMUG9V?=
 =?utf-8?B?Mm9BQ0NYeDh3aHB2U1hvQWdnZDlIdWRqZk40akhzZVAwTEpHS3hXTXJOTzQ0?=
 =?utf-8?B?cTY1WnBOQ2hIcUlGOEd1bmVCZ2MyamZrejNlc2pNOTRXYmcyZ2tWY2RQK0FQ?=
 =?utf-8?B?ZWtSMWdXNmpNcVhwMTk1dDlzdi9Ic2pBSFZtK2dBd1JDMUg3WEovQjBBT3ZR?=
 =?utf-8?B?VWxUZDdrd3A2WUs3YXZscVVmNWpYN2JZVUxIVk14RUMzSitYZnNrZFIrOEJK?=
 =?utf-8?B?cGRwR3N0cEVoci9BVVN1K2k5UU1vcUFKM3I1amRoVi81M3I1QTNUdEVOWUsy?=
 =?utf-8?B?QWNuVkUxN0xDQ1RTUnhuaG5jTnJGTjVZMzZ2eGQxU0FzRGxlRmJEMHJQNDNC?=
 =?utf-8?B?cmFkeVQrU0FjYjMxc29vYkhuczV2djlFMkxhQmY1MFllOVkwZjFMZllhblVp?=
 =?utf-8?B?eVJBbXJFbFI3MDBDMjIrOUZMNjJjV01BeFd4TlM3eWN5ZnZSeXFUeS9HK1cz?=
 =?utf-8?B?OGhpY3plVzl5THBsTy9uMGVrTGhVZUFtK1JHRWZ4dDFHY0JydmwrUDJRYytB?=
 =?utf-8?B?Ykx3U0RieFZ0aVNZc3M4QXM2ZFh5V0YwZDFhZDRQSEZPbERST3BFYmIvMXF3?=
 =?utf-8?B?WWQ1SXdEeWdRTjFTZjg2ZWtqZGEyTWE4MWtCamhTMnUrWkxiR29BVzRDVkE2?=
 =?utf-8?B?WmUraSsyZ2dwZThSRHVkY2FrazVkVWltSEg0S0ZzUi9KeWN3Ty9JSitQa25E?=
 =?utf-8?B?Qm5YdWo4MlFSYUQvT2FHZjJBd1ZvMXFWUDl4YkZTQ0hmT0VJN2s1ZEVyNU90?=
 =?utf-8?B?Ull5ck54a1dIcXVRQlowckdiQVZIR0tKMjd3cHU1QkVyOWlrdXB4cS9xTDh0?=
 =?utf-8?B?T0VqM3ZkRnRmV1BmeE5ZNzcycncyV0xZTFRIYUtIbldTeTdCQU53RElaTmdR?=
 =?utf-8?B?S21vTVM3aDJjMDdSVzdUUThoL1FXWGQ2dnczVEdRM013QktUTXdCRjllTGgw?=
 =?utf-8?B?bkt2YUZBQUdJRnpSU01nZ05QbkVvajJqeFVCRWFWcHZ3aW1MRE1vajZSWTFT?=
 =?utf-8?B?d2tnZEllajJ1L1ZNOFRPbC9iUEkvWDMyK1JLLzBxaGs3bkR4a0tkd0w4V0NH?=
 =?utf-8?B?TXhIc1pIYjMxSnArZE5mZ1U2Y0ZHMFFHbmNWUm5RT1M4ZW9taUlFT0RYcmFx?=
 =?utf-8?B?NmU0Z3VNV1lYa2xYMVUvbUorLzY5UStadVZXRkJJMDliRnVZNFFVQ1pZNURh?=
 =?utf-8?B?MjR0VG4vdHNZOU85eDdhWTRzcE1LQmk3QVNLaWh5b1FOdmdZcG9RUjZTWVJB?=
 =?utf-8?B?OW1lYzdCTHBHMFkrdkFZKzA2TXRLdWpKTkRFaDRQTVBTc3l3ZTRYSXMvQjBP?=
 =?utf-8?B?U2svTThTNHFQTlJiMDEySjVKYWRralI5NTVveHg2YmdEeWg3SFhibURJQjNp?=
 =?utf-8?B?WVZsejcwakFlYU55dEZwWTkweVlFeVpPZWpJOUxIZXBxcVU4Z0J5R3M0c3B5?=
 =?utf-8?Q?Li/9UuCDBQUouAK6bGhFoRvtZ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f95505-9e2e-462a-9cf2-08dcbad6f909
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 13:59:24.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FArF6BPMQECbi5azF1OrGPMFzGAMXFAMKIrOjInDIVE5JZRFLrILOg6Tz7xky8euSwOJFYcWBsOSUbsEZwPkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7973

On 12.08.24 15:41, Mauro S. wrote:
> On 06/08/24 09:33, Mauro S. wrote:
>> On 05/08/24 23:41, Jan Kiszka wrote:
>>> On 05.08.24 16:40, Jan Kiszka wrote:
>>>> On 05.08.24 16:28, Mauro Salvini wrote:
>>>>> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
>>>>> <jan.kiszka@siemens.com> ha scritto:
>>>>>>
>>>>>> On 14.03.24 15:22, Mauro S. wrote:
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> finally I managed to have a piece of code that makes the issue
>>>>>>> reproducible. It's not exactly small, but not too big either.
>>>>>>> I hope that this makes the issue reproducible also on your test
>>>>>>> system.
>>>>>>>
>>>>>>> The zip contains:
>>>>>>> - a little main program (test.c)
>>>>>>> - a little library (in mylib dir). Some pieces of code are never
>>>>>>> reached, but leaved to avoid potential compiler optimizations
>>>>>>> that could
>>>>>>> remove other relevant parts (maybe cycles?)
>>>>>>> - a script (build.sh) to build the two components above
>>>>>>> - a script to launch the test (start-test.sh)
>>>>>>> - the configuration of the kernel in use
>>>>>>>
>>>>>>> After building the program and the library with build.sh, you can
>>>>>>> copy
>>>>>>> on the target:
>>>>>>> - the start-test.sh script
>>>>>>> - the built program xeno-test-session-hang-on-exit
>>>>>>> - the built library libmylib.so.2.0.0
>>>>>>> and create the library link /usr/lib/libmylib.so.2
>>>>>>>
>>>>>>> Start the test with "./start-test.sh &" and follow what happening
>>>>>>> with
>>>>>>> "tail -f log.txt": after a time that varies from a couple of
>>>>>>> minutes to
>>>>>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT
>>>>>>> ~~~~~~"
>>>>>>> line: the hang is happened.
>>>>>>>
>>>>>>> A small recap:
>>>>>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>>>>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>>>>>
>>>>>> Can you only reproduce with this setup, specifically with this
>>>>>> compiler
>>>>>> version and only on real hardware? If you rather use
>>>>>> xenomai-images and
>>>>>> qemu/kvm target but still the same kernel and xenomai version, the
>>>>>> issue
>>>>>> does not occur?
>>>>>>
>>>>>> I'm trying in kvm right now, also with different compiler. Iit
>>>>>> would be
>>>>>> good to align / rule out variables if my first setup turns out to be
>>>>>> unhelpful.
>>>>>>
>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> Sorry, I never tried on an emulated system like qemu, I did the tests
>>>>
>>>> qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
>>>> gives similar execution patterns as on real hardware.
>>>>
>>>>> only on real hardware (using different samples of the same hardware,
>>>>> just to exclude hardware problems).
>>>>> I can do a test with Xenomai images on real hardware if it would be
>>>>> useful.
>>>>
>>>> That would already be useful to rule out the toolchain as contributor,
>>>> yes. When at it, testing in qemu-kvm would also be nice.
>>>>
>>>
>>> FWIW, I've pushed ipipe-core-5.4.281-x86-16. It's not that I expect
>>> positive impact on your issue, but you never know (until you understood
>>> the actual root cause).
>>>
>>> Jan
>>
>> Hi Jan,
>>
>> I've seen, thank you.
>>
>> I will try xenomai images on real hardware and I will back to you with
>> results.
>>
>> Thanks again, regards
>>
> 
> Hi,
> 
> first results after some tests on real hardware:
> 
> - xenomai-image does not show the problem
> - xenomai-image started with my custom kernel instead of the
> xenomai-image one does not show the problem

How did you build that custom kernel? Is it the same binary that failed
before?

> - I didn't manage to run the xenomai-image kernel with my rootfs yet (it
> does not start, but at the moment I have a headless system and I'm not
> able to debug it)

The kernel we build in xenomai-images may lack some config switches
needed for you rootfs.

> 
> While waiting the verification with xenomai-image kernel with my rootfs,
> could we conclude that the problem lies in userspace then? Could be the
> Xenomai config flags? Or the compiler version? Do you have suggestions
> about other tests to run?

Until we understood the reason, we do not know where the problem lies.
Your userspace may trigger something that the Debian image we build does
not.

> 
> Note that the test binary is always the same in all scenarios, built
> with my toolchain (that is built by Yocto), and my rootfs and
> xenomai-image have both Xenomai v3.2.3.
> 
> Side note: xenomai-image still has 5.4.228 kernel, maybe you didn't push
> the upgrade patch to 5.4.281? Anyway, it seems that does not matter.

Only the next branch of xenomai-images contains the update of the
released versions so far. But when you build "head of tree" kernel, you
should also get that latest version.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

