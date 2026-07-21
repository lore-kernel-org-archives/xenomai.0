Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B2437842
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620988; cv=fail; b=Z5mrbmPSg2LOT5YAYCGvfgt7NIw3O04kVJy8BHNIGvfKy7+p2bmY6b/D2O1aefN8gALGaZaI8gbFmxZwOK6cKh2Z95r5WV5VEqE5wnpUzQAR1pfPqTgxTKnxnuEFgcXeHkocnj1KdwHwu0GyZPGTWBgNE/TfWTSjDC72izN6m8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620988; c=relaxed/simple;
	bh=3meWCApcVTrLwthiVdipALW2CkuhXdM4uvPkz8N2EOE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ryQmUK/DES6tDvhyVpCUOULAfdmPfs/mdKjwqkNEHpEkej3BoFxYYQSmz9XMHWX2Q8IdvVEgb3C35ii8jEj1C8Fs1VxZi84pnq4xqu9lXthXO41/tN8ZqJCGQ1mTjP1gdI6Jdgb/MbmxbfjHiaJGKc81uPPL/DOn7zc+FQgqUkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dug6UklI; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dug6UklI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4paLr59WiuLrUcaKxP8qcGzbYts9xY3OQTtsHvc/NCvKfvz+rC8zm18DNrJUrN0+OK+0HT5qzkpi8eUUQknBsoPkG2m9rL2RtxlHrQbrAvypUtQJkEUr258n80sXblr5wX6xjIQkCiP7rzklwRy/5wNJsUo26JxtNp6GONpjkoa0zb/r//9+anjis//BfGy+P5CzEv4M3JdD9NAGQcJ2CH/duxwukEUB+3yjLKMgn73rQKucnBCBP7QajN5u329DMLhA2nlXWe23XnHUVbdaBbPLsrbPi5ViLshxUUYYihS99Gc0YHm3rS6nxrPsZqxw+ISfZNdXBN3DzmrbexT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msKGc0GmiIWC9tLLug3rEy+ajSqX/fo9wexewL6E64k=;
 b=itGUGaDQ9U2UqwGpahveKIuzCvhZBaAooaiw8hL7cWtj/P114km878mVTpE1tiS1b3Sa8WPGoAfgoOMu0SiQHmcCI9r9w/OgJt3ROAjj/AcwyMhkIRA6h8Q45itATaHNHgnceWW1AC6bzMj8zCM/zWWT5f8YKxuDbd9YAKYrjrD9O6myVjqzL1gsKFWpKZshC/vH0ck5TXBjdew310rLGQsEfya0Wpqu3a21pnbJolR3vq+iXGSROw2hlVg3aFT6mM01OomH3OUgc51vWPnT3+7b6AMAcCNiL3VirqCYLUh39r+X1K6a1wc8v1eVsoSYOuQKO6WpYa893lzXH6c8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msKGc0GmiIWC9tLLug3rEy+ajSqX/fo9wexewL6E64k=;
 b=dug6UklIyQvds/i0TO/8YfEPgsqF3SSLBSY83NRAaSTJQf2psCEEnaFsJN0Lp/fWl13shtl+M0BQ28YzILgt8sZlPvsAn6I7GsbcsRqHCwstUKK6+DoKwddDB8TBnEH7d/Htrzi/Ivjnad8Atuu/EgDdqJsZzbtnuQw1Ul2m7c0lBog5uN12TBdO+A+JAjECx/LctUOFrp/YXkbYcCK/aRGurmlodmiCdTGUq58hwaYm3a42wCun1CGXCVcIX6u1fEK3bF6nZkWXlzuSDAQe9Q6dyCfpfxycyIqFdUEOUn4nEBIDCG9ZAXIVVng3vICJ16D9xwhmKi2UPLItHzPOYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 08:03:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 08:03:04 +0000
Message-ID: <ebb378df-45d1-469c-928c-523f16a39460@siemens.com>
Date: Tue, 21 Jul 2026 10:03:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Hang during smokey posix_cond test w/ cobalt and PREEMPT_RT
 enabled
To: Dominic Rath <dominic.rath@ibv-augsburg.net>, xenomai@lists.linux.dev
References: <8b51814b-b91a-480b-bb7e-2cbf13660f21@ibv-augsburg.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8b51814b-b91a-480b-bb7e-2cbf13660f21@ibv-augsburg.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bf163b-c9e5-4b97-0eef-08dee6fe7db7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|56012099006|11063799006|5023799004|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J85CDYQdXZbTsenyE6Y9OU/YjFYRt2xNlDoJRaa4c/tvvPDZ8RuO52+3ezKsKvRxk7W0BfbgGNp3yf2C0wb8JSOJlDvF5RPfkDI3OklkxW1XJ5ek/NSgg+fCGv4qzGv/84U/2jzrRu2JrZWphf2XVoOojL8oyl+OIOYGuMoHfHObHc1uiTem4nT3pYm4FqQemHW3ZD/qnFm7JsV88uRoW8XOYIwfvhzs4jKtyvucq1Ot0nmadeUerpAAUrOpHUWyr6JLspNyDCK9Yz7CdHxH+EyQh4v7klzUXaQMtj65jT6Yyltqmw0BgzasJbe/XQWagRL9M5XSItK1jwikHwVCuDlE3X3CeYFYvCkNAhXUyZHTUSs6wMGWTdocRnBlWauX2DgjCjRNOjkihya3ij2g2XIy13NvXb6slcWA9dANdWwiOlZjapDE4ZEqMcPMA/BG8jyb9pgCPlSg3KRj5mdc+qTljG8ialY/3eDy8QdoPkD6knpsfLksU34UOxilSHET8si1Nn7xSRnZkNb3VOSW7xAwakfTOSt/VWX+5A1QzXQEshA57ecNoGglOMxjRGyYf7/I1Ai75L5qX3kXQjhgTdcOD8d+SRPiAas3B7ULy99EjxxYduSovC3gcLUA82g8+JQq98JsJg7AYwf3S+NJD9BmZENIzoYTInaqROeEoyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(5023799004)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3o0VXBMNlVhTmNadEtFY200TnhYcVBod3A3OW84VXgzbWg5cVBYVFhDT2FE?=
 =?utf-8?B?ejRqVnlRVTNKc1VrdmNZS3VMak1sOHl4NC9aUGVzMzVsdGlEVDFNQmcvdFdx?=
 =?utf-8?B?Q1Z2ampuUnBkeThPQjdSQ1ZHRGZMUzFjazdKaUxTRENyczEzWWU0djRzbE1z?=
 =?utf-8?B?TDlwWVp4V2gwaStjV3ozckN1ODJQeGtiM1NScmZwTmtub2VDN0d6Zi93VGpI?=
 =?utf-8?B?TElrYmhXeUFNamFZZ2dyME5uOWtIbFRtSDd0MlBPZUF2bE5wV1ROK0hhZmJT?=
 =?utf-8?B?R3ZTbnIwTFp4cWk1ZlhuWDlHTHoxczdsR0l2RjRScXk5Y3JheEg0L1ZkaC8v?=
 =?utf-8?B?VWo1U0NYRGxzbXNhdEJLTVZPS1NjMktYblpvNEFJSVNFTnFUV3dlTElrWTdt?=
 =?utf-8?B?SGgwVXk4TkUyK1pjOHlLbUR0TTAvUmhWd2hzMkNiVlhlUzRGUVZRMHpJL1hv?=
 =?utf-8?B?c1JFdzhvVXhGcmpndTd1VCtVWWFXelRrdUNHaEpuNVNrQmYvNXpLTFdXTnJr?=
 =?utf-8?B?R3cxeVdoOVdRS1lHOWFjcmFmKzE4SkQyVm9zb2dNNXBsUlI1VGZ0YmNzc2FP?=
 =?utf-8?B?Y1dpT2ErZDBYbWJPVmoyVzZqYU5GZEdqZnJ0NE1iSXVZbXROOVZvKy9aWTNN?=
 =?utf-8?B?WURJK0s1cDJiekRVMVpBRy9abFZMUUM3bWhrVkdxdHNSbzJuVnM0Y0JZY2Nh?=
 =?utf-8?B?bmYwY1NGWUIrYi9BdTFWYU14M0plbG15eXgxZ1dMZnNuYU1sUGphNGpCTmln?=
 =?utf-8?B?Qkx2eWVyZWw2YUVXelE3bTFLcnZJTnA5WXNFRFNSdXlZMWVIdUNZSkxHVjFs?=
 =?utf-8?B?ekE3Z2M5YURBZk5WWWowM2VqZXo5R291MWtkejEwYmV6cWpTeHludE5BRnFx?=
 =?utf-8?B?bWFmZkNiRkZPbm9XbUNjRUhxVG85TGNJcDhNeEZtc25CZHNUYS81bkZZUk5u?=
 =?utf-8?B?a2NlMFp0RHkreU1XU21sQjBjam0xQ3MvTlRiVFFvUENjNUVlWkVNN05RZ0tn?=
 =?utf-8?B?Rk9zbnYwSDYyY3prVmVTQitMeVl4UVFvQ0pnTC9Rdk51dHhVSWY4a05MdlFo?=
 =?utf-8?B?S291c0ZFZUNyUVZwd3kyemlGYStTNmxoNXllV0cwa1VFWERQS2F0TUNDUFlD?=
 =?utf-8?B?ckVjTGt2ZjluemQ3L1hrZ29YZUREOFVtcFdtcEg0QmY0dmx5bUNmbDFKSVRv?=
 =?utf-8?B?SmVucE1KRTMvZTRvekpZMzcvSWhVamM5QUxJaTZ4eXpLNkY2bDhRTUQweS9B?=
 =?utf-8?B?aFJoMnNETWhiUkJzWitSOFVwTm02ZmtWdGhGUGtmNDRrNmp5ZlBSaHpVa05E?=
 =?utf-8?B?aFdvWFh3T3BIVmxqNGpveHVrL0pZK05vZmtLdGhmaVhoWkRRWmJQTGpCU2dH?=
 =?utf-8?B?cmRBUXh2QzlBKzc3aHIyODFMaERFbUVhUHI4cXFlMTZ5YkRkWHBQZ3FEZmw4?=
 =?utf-8?B?S1luYy9qY2VZWVlNamNtWE1naHVkNFhRK05vSkNtOWx4R0R6OTZScFRXUy8w?=
 =?utf-8?B?ZXUwMVFPSFcrbkVQUm5pVXRnbE5RbkR0Rk1wSmgwMGRIcUhmbVJlOG5LcGhH?=
 =?utf-8?B?MFVHWm5wRUFSam1jV2JTaHZ3YTVIU1VRNmpHQWJuZmNaQVo0REdKOVFobkRI?=
 =?utf-8?B?cUpRVy9TMkc5SmU2YzFRdmRBNG1oRkZzeURmc0RZcktGcjBhamd2SlNaME0y?=
 =?utf-8?B?cUorNS9BbTc4NzltQ2lQN29JMi9mbkxvUnl5c3pxblplRXI0cUlJeWVGVVN6?=
 =?utf-8?B?dEt3dWd0b1pmMmdiWXR5YUY4UnhzM2d4ei82MG5Qd2lLekw0U3dEN3RDZk82?=
 =?utf-8?B?Yk4vSzRsTkNWUm9US3h3WXZ5d1A0cmdCYUFrNDFGOXNtbUV4MkpaZEg4Y3lJ?=
 =?utf-8?B?ZDhkU2g3N3oxbUVnbHpxMXg0KzJWR053ODgxbzVoa3d5UEVMRlBSNzlsZVl3?=
 =?utf-8?B?ZzNuQzNzeXJRSVJzenI5Mi9ZbHJvTFBiL0hrQysxcUtrSUtRN1Q0THhpc3pY?=
 =?utf-8?B?dGxxYUVpZTlLUGxCWkhCNXVzWDN6MDZDWGw3ejJWR2xIVi9LUFRxRmNVMG5L?=
 =?utf-8?B?N3IzUjlRRk1Ha3RYQy9sOTFTUlFaNG54U3JzUityY056Mkw0RnNSSHpoYXJQ?=
 =?utf-8?B?eXJqbjh6NnNTR3lnYVJwL1g0NzVMa1ZQU20yeEprL1ZnVUV6Q1d4dEM2ZVhr?=
 =?utf-8?B?L1ZhNTM2djRyRlFJUndaS1NGWllQYlIvclVTVWVPc1VtUWZRZWx6K2RWZHNu?=
 =?utf-8?B?d24rSlQ0TUhCNlAvdXZIajBKaGhBWWt0SE1VUGZ6ODdIYm1hZ1NkUjdNNnRi?=
 =?utf-8?B?Skt6dy9RV21mVzNtVU12TDFrNy81bFNKeDhMT0FjQXpNY3dDR3RYdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bf163b-c9e5-4b97-0eef-08dee6fe7db7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:03:04.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC2WpxFbGk9PzQ05s3lKxVhVpd91PHOZk70NbzSSoHHW3BrodwU7eUgxZeBxqy08pfbtB3mSvhNKXUm+fWebXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7252

On 21.07.26 09:21, Dominic Rath wrote:
> Dear Xenomai team,
> 
> we're seeing a hang during the execution of the posix_cond test in
> smokey. When breaking into the stuck test, I can see that the main
> thread is waiting on a semaphore in thread_spawn, and the newly spawned
> thread appears to be stuck in cobalt_thread_harden, before it had a
> chance to post the semaphore.
> 
> Apart from that single test, all other tests run successfully, and our
> application was running fine, too.
> 
> We're using Xenomai 3.3.3 on an ARM64 running Linux kernel 6.12 with
> PREEMPT_RT enabled. The kernel is a heavily patched vendor tree based on
> v6.12.y-cip merged with v6.12.y-cip-dovetail, and I can't rule out that
> we've made some mistake there.
> 
> When running the tests without PREEMPT_RT enabled, the tests complete
> successfully.
> 
> Looking at some tracepoints and function traces we noticed that the
> newly spawned thread actually wanted to relax again, but instead the
> kernel is in an endless loop calling lostage_task_wakeup on the main
> thread.
> 
> What happened is that the main thread wanted to relax, hardened again,
> and called xnthread_relax again. On that second relax the
> relax_work.inband_work was queued via irq_work_queue again, while it was
> already on the lazy_list, resulting in the endless loop.
> 
> It seems that the main thread is continuing execution in the Linux
> domain after the first call to xnthread_relax without
> lostage_task_wakeup running first. That gives it a chance to harden and
> call relax the second time, where the endless loop on the lazy_list gets
> created. Only afterwards is irq_work_run_list executing again and calls
> cobalt_lostage_wakeup, eventually in an endless loop.
> 
> This is possible, because relax_work.inband_work gets completely
> initialized on each call to xnthread_relax via IRQ_WORK_INIT.
> This causes the check for pending irq_work in irq_work_queue to not
> detect that this item was already queued.
> 
> I was able to fix this by moving the initialization of thread->
> relax_work.inband_work to __xnthread_init. With that changed, the test
> successfully completes even with PREEMPT_RT enabled.
> 
> I believe the reason why this works without PREEMPT_RT, or when using
> IRQ_WORK_INIT_HARD (tried that, too), is that the irq_work is called
> immediately when the core is back in secondary mode, whereas with
> PREEMPT_RT it is deferred (to the next tick?).
> 
> What I'm not so sure about is the following:
> 
> - is running Xenomai 3 with cobalt on a kernel with PREEMPT_RT
> supported, i.e. should this work?
> 

Conceptually, yes. Practically, this combination is very likely
undertested (e.g. not part of our CI).

> - is it conceivable that the main thread continues execution in the
> Linux domain before lostage_task_wakeup got called? Or does this
> indicate that there's something else wrong with our setup?
> 
> I've enabled all of the Xenomai, dovetail and PREEMPT_RT debug checks
> that made sense to me and I'm not getting any errors, but of course I
> might have missed some useful CONFIG option.
> 

Did you already compare the event flow you are seeing with a reference
flow you could generated from qemu-arm64 image of xenomai-images? That
may help looking for the essential differences.

Furthermore, you could patch xenomai-image to turn on PREEMPT_RT for
6.12 on qemu-arm64 as well and possibly run your test in that setup
(provided its portable enough).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
