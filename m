Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2097.outbound.protection.outlook.com [40.107.7.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FE12E1D5
	for <xenomai@lists.linux.dev>; Tue,  9 Apr 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682807; cv=fail; b=OgqVN1mxEAi8xUlcGZplBYO9t1FYqvPiLx4EVPu2pU6PUIoOX2sG6Nt5vnd1ce8MdEV0GXz8rIx22gmls8r3wiLwsvAPvH1bsveTMfEqS9EpgD+yt1wUV1stv7EzRJEUaTopyYaf/T5yknDyhILQeTZifNp3FZHJsUJJZVDyXJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682807; c=relaxed/simple;
	bh=3nXoSRsTuC1QYtgvjMCAXBJnJx4qpJBsCBhxvIEQWA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGDH4+nIFpiKjQniMz7kyJU1PEhOTBDwL/HdJDLyJRal4Cv1iVIpPKLXdoWK4Z6/ZPjoTsx71QY/TwjJ7z1MqXujaBCA6Qzi5DNYr/YxPFr/2hfjO8asw8RYW3ccu2kAkqwNx8uLCf3/ez/07nEhAyVkl2qRkd8+ju0eb2HiBgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=G9mHp18l; arc=fail smtp.client-ip=40.107.7.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="G9mHp18l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9M1tbc7QOk7UhZ8VBPIxSyzd4aqDY/4oFPFZT1ZjNlGoB+Oz+RuKLxVt1yLg9Cfr3q4NWaecBTz8vCmK5QEPdKhaKYG9srocFJjeiaaB/HN4NZl2PgMIQwmLQ4LDL2lfZ8gfWQhDBm2F8r5QIJ6j42lvJr3LSXfwFSOJ967evQ/7vShQ3B2zB/f5nk0upPEsYj0HF1K9nSzR1GoXBjEh5/5QVOMT9pZYNZQFIAV7B6TuJRsYHC89JkmXr4l9e7KdAd/GrKQjDMmgustEznvkWS85qOsvhkoygLV5whokCcj8wdxZKR5HSd8Ay46ycXYVZ2lIyh48O4vzqPfss7/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSNdptghG4OAjbu878yQd/pd76IxrIO2pRyT/kCLjeU=;
 b=jhEATyMCNgeAXxDgc40ARejpEvI3O13exeTvOfKGCAPEXahfpGNhvjIRCSpg8W96HeuKXtkHFZ/5xgGsQrrkInN6qrLGrekHOZZwRfqbEUODucc+EYfOGeh/OpsB6/IJSruekh4gGYLHFBNX9ooByZyW4whkiwkcJp0aDaWFAHY+A/6tfoXMTDDHi0rEmvGGl4KSMMeZLRbKIJeYX5AttZRDHogMuFsm57SAKrHFqkMcj9ef9Q3r2wOFAsRMpFnb3i8Gj84s5IKFte/0g02uDWzAoY7zwWBp7gWWuc8WkHH8QJPS0sOohk0xvcihC96c4NzPdWb2pYLQJgOLdiSB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSNdptghG4OAjbu878yQd/pd76IxrIO2pRyT/kCLjeU=;
 b=G9mHp18l7wJy42abSG/1lHGBYgoSYqFj1IZU0a5pCj/mXnIsl53pqqCqNartxR8G1L9HmZf2agZhX+tY6iX+O+YRoGK7+Knoh+hoqQDFimdYy+gQFQQWxgkNdDlkJD69Szjy1Ako1XELHc9KMJfHDHAYWWgAI+MZ5gOPv+4wAqEvZc3uY+VG/Fk9zC8ldyHXZaeR9Tif4dVj5XNLJzojG2c8i5n7Tkxs8RTog+tNgTibMn4PTOOeeWtqawWSG1oOciIDoNh1o/XPynrhQzY6g/vy9YB9ki8IO4sRf9oprxJmGL4bebab9VY7OJvcyQe3m5Mh6AhxpC3/6bjOhtyLUQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8406.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 17:13:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 17:13:18 +0000
Message-ID: <aab40d57-cd36-419d-ad04-5700cbef9d94@siemens.com>
Date: Tue, 9 Apr 2024 19:13:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with rt_task_set_affinity() in combination with
 xenomai.supported_cpus
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
References: <2fc736948068580213268be9548154799b5c8633.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2fc736948068580213268be9548154799b5c8633.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8406:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m1O4QWDaUsrrEaKaBliz9Q2gymJZ5Mz9mqM+iTr8x7lk8s+juccnaHiO9qNlMNnFjdGnS97CbBktzNJylIjdXcfuHoiuV+yKwnJ0tnf3eeRpId9HoqqBCGsL6M2Bo/yRw2fflAoQ8jEXTd0onc2iIJDQb0IC0dhKrhpIebnIpu4xdAaG/2VVFNr+IDXiGyoPWV4uFGGiNITsYuB/cNPo1tajgfSOkHlWLq80zA6widJ54SIUQtv2qz2xtTs+5RRxaF37gQ1XT1vlMZ9MleYxJniv2BGDZnqDtkoazF7yKhgkv4hWA+9hig3k9QaxCrv6NvaJeHoAcAzRqsC/mV43k9errNTMFjHiBnm9HDU42mIsKqCS0vM9bqKy7XQ3h1BJ9PKisI7MGr3nqmHKWcbTxIsA2hWrDXJxQv7dirkkPLhxBrXHSfU6z05ysG/irUBr5qccNsVnZy/xRNQ1zckwPu4gfvkiNjt3ROug0tUEUZ2Rq6hVJDEa8tHl6+4bs9IncjzQccDt2z2y5Di+kG49+ctlH0N63OE7uMRQ9hw+lgtAAoSLPNtJEz054yzXdNuharyTblIj2YI4T+X8o7d8GIhcLveOstLvUs4baSOKTTaHZ7KRQCSmFN7GeUQ7E+qieLaMz0Ggh0gHY/jpyPRGU8ypU7YEwkyUu6shGqWyqB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejhYZDZDaUMzR25WNVpscXN1QzFmTTVVZ1VIZVE2YllUZ0dkZGdMUDBWVC8y?=
 =?utf-8?B?cUFCc1VTZjRLM0xFNmpxZ2owQ01UYjl1ZkY2Y0FCTGJpUWQyMk1ZNjljM2Zp?=
 =?utf-8?B?WmNZZXVWQkhCclV6YUdXVkZsR095Y0pIZG5oNWh6ZURUZ3Y4UUluVXVLVHQw?=
 =?utf-8?B?ck1ZZDF2Wm12bElib3pLR09VeVZ5ZzRpeXNPOG9DdWdvTUpkeGNkdXVOMFl4?=
 =?utf-8?B?bkVodlBLT3g5ZHBuN3VodmdWb2tiOTFCUFdjNDUrYkw4dDlMM3JvQWVRZjJF?=
 =?utf-8?B?RHVWTUczNlJUcmF1RW5MbEVQeHk4T3VqZ1hjTXNQNlNwYWtLOFZrTXNCQ1Nw?=
 =?utf-8?B?b0FrcW9UbVR1c2pJZ2ZVQmNhRlVZWWpkY2tPK3Q0YXl3bDMvcmoxUVEreEp2?=
 =?utf-8?B?a2F4VTFLSUtFMlFUWUw2R2N4bzA4Y25YSzAzTFo3TGgxRDZLTjJjdnN6bGRa?=
 =?utf-8?B?VXEzeGdxMlNZdC9FSkwwSWVjSkp5Q2pSNEIvV25LZTR3ekhSTDRkb05QQ0Uz?=
 =?utf-8?B?YUVXWFVRV1E5TmlLR3huYVEwOE04OTI1U0J0OWxzajFaWFR0TE9aRlc3dCtI?=
 =?utf-8?B?bWlqM3lPQ0cwYWVzb00xU3V6bUFqZUU1dWRtWTlpUGpnZ1BWQURJTmNiV1RK?=
 =?utf-8?B?MU9sSHAzb2ltQVVKMzV2OXlBeHpWRG9nczRTMzBrSmdYNWhPTjFqT0E4cS9w?=
 =?utf-8?B?QWFOSjA3Sm92eDNBN0R5c0lFWWQ0Zm5DMlowZGtIbVRtc1hPbENzbWdPWW1D?=
 =?utf-8?B?TVB3VGZmcUFlTmRGOXF2dTE3VXF4cnkzZW5PNWI1UWZ3aUUxWWJaUmUvNlFP?=
 =?utf-8?B?c3kySGw3dnlheGE0Rk1IaDhUT05HVDJEVW1ESGs1d3dXOEJHSzJQaW9sY0Zp?=
 =?utf-8?B?ekVyOEVqNG5OTVdhT2NYdnFxczVaVWxHQUFLNHhhRmg3cWw4cEtmT3kxYkNU?=
 =?utf-8?B?eGRFdTF6WkcwcWNDS0gySHR2bU1mMHFLaTRuU2huQ2o2enArOFVhRWJWWlVF?=
 =?utf-8?B?UlR6aXY4b0N5cDVUSzJ0WkgvSVY2M214UDBHTm1SU1d0TjNzWUhuUjg3MHFx?=
 =?utf-8?B?d1VYMkZHdkJ4dmFvS1JhVEo5NTgwSEJlTEFTbDdkYTU0RDN1THBnMHpISmFy?=
 =?utf-8?B?bkpoWnY2N2JkZE1IKy8rRG9idUR3Y2RRR0FsbG4welRmTjBkbGFIK0JKNDlI?=
 =?utf-8?B?d3YwTDhEdnJBaTFLLzdJS2paV1k4RFYxSWxnU1VhUlJjb3ZaQmYwVUFzSmNE?=
 =?utf-8?B?K3JqaG1WeEdwSUdlSUhEcTc5eWJoWEI4V2JKY3ZnLzlBRElTK0wzNGRqdU91?=
 =?utf-8?B?ZHgxZFdvM3NjRURsVVNocCtGNFIrbU5CMXZkUWNtKzcySkZFc2ltM0tEM2ww?=
 =?utf-8?B?NGN0OWZyVTdLUXppbjFNUThjTVRBMGFSb0R4eE5hSTE1LzVYZEJza0Z1UkhD?=
 =?utf-8?B?NW1NYk05Q3ZOTDYrcUNyQWx4cFBlUU54NmFpOUliM1Z0bDVaRG5TZldDa3pY?=
 =?utf-8?B?RXBlQWwzZmVKU3I3MC9aRXhNRFZ3MUtyMlR6WW5kdlo2KzlZa3Y5cmdqekd1?=
 =?utf-8?B?ZFZVR0g0R2g2MkpobGt0VWZiNndTT25XY0ZqT2N4SWRTWU10ME5QQjVkOW4y?=
 =?utf-8?B?TkdLcUhCcncraFlBK2pSRTFjd2cvRURlaVJWRVI0ZzdRZlpKcjBYRmpqWkFQ?=
 =?utf-8?B?RWhjUEhuOFdNYlFVVXp6eHIxbkl1M3dxWEpWRVdPNUlXSURZV0hsTmdFSWxp?=
 =?utf-8?B?ZzVJc3llRmZSZXdIWWZ3UGpQWkI0cGM3SVZWTXRpYkkrZWtKRWxiQmsrRXRO?=
 =?utf-8?B?S1VzSVRxc01TQ3ROc2s1Sm9ocGpwbHE4SHNhTEFVMWRRejhoQ3cwbkE4cTA0?=
 =?utf-8?B?ZEtNYlRmbkt5dU9odDFKMTVibVJHYVVSbm1TY1hxNEhEWmgxeXhIVkkyN3h2?=
 =?utf-8?B?dkk2dHpFRVhrNFY1ZjlMYUh2TWhhbFBuM1pjd1BIdlR0ajYvK2ozMDhSK3Vm?=
 =?utf-8?B?VUU0c0hPN3U5R0VQWGdEOFhaVm50bXVKNmp0Mlp6elR2cW54ZFhpYzlHOGps?=
 =?utf-8?B?T3lTUDFCSzh1cE5iVVE0d0d3WVBXSU5SOEJZN0JxaTNhRUExWTNNeFhOcU9x?=
 =?utf-8?B?c3k2RTFSaVdNbkg3MnBONUVHNW4rckw1VFNBQUhWM1Y3V2g0aHlkaFFMNGN5?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429541f7-cc00-40d8-6132-08dc58b859ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 17:13:18.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diGwh2pPxQDGv38egejVpLzunewsUo9/5zfjG4Vo8gf9hrrXcW85P/rr2bCrPwzbYzJutO6ytjxOyV7Uvjj9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8406

On 09.04.24 13:56, Florian Bezdeka wrote:
> Hi all,
> 
> while looking into recent bug reports we were facing a situation where
> we were seeing completely different behavior of provided test
> applications / reproducers than the original reporter.
> 
> It turned out that reproducers were assuming that specific CPUs are
> allowed to run Xenomai applications, which was not the case. The
> cmdline parameter xenomai.supported_cpus=0x3 (= allow the first 2 CPUs
> to serve RT tasks) was used here to shrink the set of CPUs that are
> allowed to run RT tasks.
> 
> Example (out of my head), error handling ignored:
> 
> void rt_main(void *arg)
> {
> 	// do RT stuff
> }
> 
> main()
> {
> 	RT_TASK demo_task;
> 	cpu_set_t mask;
> 	int ret;
> 
> 	CPU_ZERO(&mask);
> 	CPU_SET(3, &mask); // Assumption: CPU 3 is allowed to run
> 	                   // RT tasks
> 
> 	rt_task_create(&demo_task, "demo", 0, 50, 0);
> 
> 	rt_task_set_affinity(&demo_task, &mask);
> 
> 	rt_task_start(&demo_task, &rt_main, 0);
> }
> 
> rt_task_set_affinity() does not report any error in case the supplied
> CPU mask is "invalid" in terms of "there is no usable CPU available".
> If an invalid affinity was set rt_task_start() will block forever.

But the task was already created, is only waiting for the kick-off by
rt_task_start. What happens to it?

> 
> How should the application know that the affinity is invalid?
> 
> My current understanding is that the there is no hook (provided by
> dovetail) that would allow intersecting the sched_setaffinity() call
> that is used at the end.
> 
> Should we implement such a hook? Is there something that I missed?
> 

We could check the mask from userspace in libalchemy. That would remain
racy, though, as the set of supported CPUs could still change after
set_affinity and before start.

Do we only have the problem in libalchemy due to its split create/start
pattern?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

