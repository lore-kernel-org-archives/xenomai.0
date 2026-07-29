Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9A1F942
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306725; cv=fail; b=WIp20JRDHI4swzoapGuJ78N9TixX1Z6xeZbV7bzlFenEP8xDsvldcSCtHxgHKaOw4LCeJefuFRx8HWbraNvqTEZFxrLxFUbVOJKITN4wdlxqaUfblHCy0U03awqqOwkaimwIO2T1ZmHVvjyjM4Xn9vyqzJcY6cTRBZ9S+ntjEaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306725; c=relaxed/simple;
	bh=75KMd5PxkStmLy90DjBg/+mUunl4/vY1Xq4P2TfbOGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DvAEDhK96ERfbGZyWLoZJwjdv/c8mquZDocZdk1DQKAbomO6GLNQZIKAVSu+/QSJbntZmoITbc5Ic4rq8I7H2wwhh0PwIdnQGZWLrhUefWbUWTj/KT6lunMdR/N2Zi5YJQxY9+SCItjZ43jSKT0iyQpaOcbJLF/OwdHCfRQUjcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tAUh9YOL; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tAUh9YOL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSMDWsPynTXNEagBmgpLicpQV4kHVg535XhMN6HhOmsfBP0HOKpwEqucZ77pzv2Jk6lNHWdpu209+y2Isvmp9aXwgbJFplOngGJemP12usl3XOAQ58vZxjxIquu3nGfYrB6Qukc8qkbJPS/E2Ig8CvZ7EI83oGoU+26UeJFe1pd2PFOMmjaWNTIG+sk8EyV4Gvb/oSZEtkQsO8O2QE4/kCvphzq9/2pC0vLAT/MFzSciiq1hyaFWiCWvthDAXrUKbXfeHjOwyPwXP7xS2UNXVm0oup3rfujyF7PHSeJGwl8zWXfDoSMrzWkix1wuT0FWTgOGnjn8gYmaFalSddDNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg+MyWWyCoJ70tJj036TOQZ40AL2DiGFomddKZK8qhA=;
 b=PRMSs+n39OHjLbQwsvgJ0gLS3Vsli1wTZpOSMQlI7lWXyhc0axR8n9AsyNeOgjSWMNjli9AFh5bcxiwrJ5mBlGezLOgsIeJ1P75wLfM6W6Rjhjv8kjoE6O/Kt9TkLPAceVPTAniKONZgZ4ifhdCOUQ3gCbdgqfWcHFOw1bMj3nx38bNSBzFTN9I4mAOUo/5OjvOKAFnNaO5BCsLWnwhsuZCZH7SAI/ogWja8yqPeq/SbzWJRo+u/oPZ2fAXLCeC4oM7HVQIKwPSA/S7rMkPiNinx6cugKd3MfVX8vnIrd36z7FI0n27Roj59IUz4OMPLyi6NgS7elcTUFxQRvNfNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg+MyWWyCoJ70tJj036TOQZ40AL2DiGFomddKZK8qhA=;
 b=tAUh9YOLM7Cf3isCG0B6WY59A4iodKqtByxccaOBAA99cdQSQk1RStEH0aTDsBYDOM7KaVFSJfInxxPvaOTe5MtSjx3MuCKHf5+dNJKxW9AzyDZ0iLR/MzYgG8hh5xx+miHxFZYefVSXyVWwtAsg/co6iw7ukdeyvqsCWbrI0RBPEnVBpTJwX8QWA03A7VtsXxdn2B+r7MLTx3VgJzw6VEIeWP5cbJy1pgWfPBhn4s69Xt0NILmbKmMzClrtvefEReZLNJLexwFkY4npwNyxbmtc9Ng6gCdRzZPnCkADQYo6wRV0T58QwK11YspFtk4EiCtQ239NJ3tBA4dolRYsXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6991.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:31:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:31:59 +0000
Message-ID: <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com>
Date: Wed, 29 Jul 2026 08:31:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.38eb388a.cbef.4959.96f3.b61a0b0ee8f9@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5cc6cb43.b732.48d7.97db.585e1489779a@feishu.cn>
 <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db85bbc-07c4-4353-3430-08deed3b1803
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	isL54JxvihxmO7iW3YCoBCFeje3KaMpidp2xeX0CtkuhWmI8cS1r//QvEAgJHyi0ESEaqh2+q0MqqIMQiSuR96fiIdm1ENr969AQxDXJ+QiiogYB6CIGY6Q6VSkvaXqFw1iLAFHdLKeitr/vHxaQ/lWuAaH+l8QecSjTXfHgercMfTi0IOlCcJQ4plJgqXhhFz7Fy+AN+SQfMfZiPilUyl4lSR5Ssr2gEzExEqqT26preg7ujtGTehaurNipJQyeVtVeQiuPHGBgJtmggppvLIzaRy0ko58TiuKe7TT9nNZ51kqasjtW7n6xMQCZDvve0/TRO4+Cs7aqgUEiOvu9bUbNf7KiDPDW2azFSg2iK+RC85OFYwujW3esJwA/tqrhlqeYeEp4VGvD77zblK8MP6PgU6YlAdgx1R92CqMl508KFgZMOIbMeJzX33wyMCch7VfUWm31U29FaOJp8IVMGm/erEppq2PMidGxxX++tmIbFiUgr+x8Cv1xdx2LSnwj95H9Cq3mwvYSU87/KpGbVCF67z4n403yueBPjRWP3mhZ7i+uBS52Tj2ZWwbPSoZUclQ0vVCzvRAbkslFHkEgydrtIikgRWG9E81lhPsgZ3PTc1If253Z0/cdbikrkpRpsg/SyFqsV9ltcrk7yeidVC5CAd1yTdveXBnCmie0xLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpnTUJpdjRlR3k4cmltSURRMHVnK0l3cEw0aUdaZVJ2SnNkODR6NGR4TXFC?=
 =?utf-8?B?bVlpek00b3ZlMzBqY3ZFbWlieldtakRSN2YyU3lnK0F5YStzTndZZGlTQXdL?=
 =?utf-8?B?TVhFelZCWUUyN0d0UGRBR1VrT2Y4bXc0clF3VGtMUkN1NHpIV3NsdHlEaWty?=
 =?utf-8?B?aWNOUWh0Q0k0bjlJZVRDRjRBMC9xa21uWUFhMnVSbFNXUGp2WlRZUFNhRnRm?=
 =?utf-8?B?U01jbGNOL1pHeWsyUDBhdFNaL3BWMFFHYkMzb3FqYzFOakQ1WnllQzBrbWdM?=
 =?utf-8?B?M1pSa3RNeHpKR1NONkdFYnBobHpzamtRQzk3bHdJOGJSNlR2SFhXaGZPUDN2?=
 =?utf-8?B?MHMvNzBmbnE3VEtYdDd4eEUxbzNoWnRZbWVBVmNtcjZqWVk1ckFzSU10VlEr?=
 =?utf-8?B?Vkllb3ZJMlU1cEVjN1oyTjdiK0wzYTNWMTQ3djN2b0FGS2UxUWxVM1RWZUZm?=
 =?utf-8?B?Z3FmZm9tdmd4bXM5ZVBzNHl1biszZ0wwSFNQL0J1aUxvWWNSUnE4bUp5VHBB?=
 =?utf-8?B?cDBTQWQ2M3hWR3FteHJqNkZaVFRzbG1IYkJlV3hXQ2phTjF4MTh2SCt4TUJI?=
 =?utf-8?B?VXRqUlhvdzFaUlVoZzRud0lnSEhRQk5UVjBnVTVHR1N4dkpnWjhrWHQvS2xw?=
 =?utf-8?B?QTg1SzUweVU1KzFtUC8wc1doN3JFblVwVlhwcEZ5azNnaUNubEtCMlAreUtW?=
 =?utf-8?B?QjQ2WGE5c0p5aW5xM0U4b1NyZGRpQW1EbFJmanhhS1lsM3ozTHZKclIySUx4?=
 =?utf-8?B?eW1HRVNFVVQwdmlqc3pQSWFSNHlBWWNHaXZGLzFZVTd6dm9ucVhwRnRhWGRN?=
 =?utf-8?B?VG9GOWUwcDdvdEJDcmkvTE0vaktwNjFzMXkyejdPbDYrRjRRclptcnNtSDdR?=
 =?utf-8?B?ek5ManJsbDNpcjZxU2txTjNKQWxBRFFiT29qUDQ3c3RFNHNVN2RrQWFXZ2FR?=
 =?utf-8?B?TXhIMFZvQUJyTkZrYU1nWENTUTVPQWZmYkNDd3NNM1BzRTU0OWJiQ1VhR2lS?=
 =?utf-8?B?akRUYiswOUNIWENaMTNKY00rK1V1OVlld082cXV4U3gxVzlLYU4vTVAxanJP?=
 =?utf-8?B?Sk1QTy9mdmQwSzlnbWtxYmdaUEJ4dDBncFpSWGIweUVvRnIrVzFaSk52VlVq?=
 =?utf-8?B?Yit4YnNMMjZHVTg3N21ibUw5YTVmN3RDamkzN2UxYkFZR3VSZVBDVkhmNHRS?=
 =?utf-8?B?U3Z4ZlhvcHNqVCt5eGMvclUwbytYUzgvNzBqcW1uWkZqb250ZExhQnVrTlFV?=
 =?utf-8?B?U1JCU1Z1aWhJWktYcTJmcEdlWTVSTUdFSHJTSGxycUhnWitGb01MY0txdXNm?=
 =?utf-8?B?bENsaGM4aWhsNTBjbC9GK1AwNGFKZWZWc1E4dnBGbENZMEsreG54L2QxU2E5?=
 =?utf-8?B?NDJMSjhLY3QvMXlLVi95WHFpODZYWkx1Sm8yMjk4dVBRZ2p5dnVpWnZlampv?=
 =?utf-8?B?SXNONHQwZ201dVgxMnA2Tnk5OVNrQW50MGc2WXJFWDl6NzdqNlJRTkI4Z1dR?=
 =?utf-8?B?VGdKU3dIOVIzMlZiNHoydDVpWGNUS3hMRUUrOHU0YW1oeHM4QlJHbFhzWG43?=
 =?utf-8?B?UXhsekg2VDE2MWhSVW5MeTdUL1ZjdkY2VWxGcFRmYlFwTnNJNzlPV0hVazVo?=
 =?utf-8?B?MDNNS3ROQkNPUkVZZGhDd2JJVUdEb1ptb0lIb3lvUXJjN0dPRjU3N3Q1eVow?=
 =?utf-8?B?RUNLUlEvVWs3Y2pEcU9Belhnc1psZEZHaTRCSUNqbUNnUkxJVUVvOWZJNTl3?=
 =?utf-8?B?blp6T3IxY0hkMGwxSGJRZmlUT01zNFVNOHpRaWRBVlpEU3NxUXhIcERxTTc2?=
 =?utf-8?B?WTFPU1hRV2IvRXFzT292N2tuSXBack5OOUhUd2hxSUlLY1dLcER5a3hDWUpq?=
 =?utf-8?B?TTFBZVdhenBWS1VsTnRFejNyT3RER0xHQmVaS0NlZjN1ZVBTdDJZd1FPbUpw?=
 =?utf-8?B?ZkRPRTBFZlBtcWYwREl4N2UybmpBcVRlQzJQU0NoUEJWMHlCSzJad0F2QWxS?=
 =?utf-8?B?R2dQelF6MnhBMDVOc2Y1Mm15YVUzaFpFbnpYYzZXdjFDanRKcmFWWVQ5bldX?=
 =?utf-8?B?TFVHakhwRnlkbFI5aUxraDZZVDNJY0cxeERSeFBWSEJBK3RXYlRTYU9HSlhn?=
 =?utf-8?B?K3VtVXRsaXdaZzlnUFpiTkZpUlZQM2tQLy9acFIwajR4NGZDWGhzSFFJMHJK?=
 =?utf-8?B?YzA3ODdLQm5ac29Obk5FcERSTjVwZk5iRXRSSjAzQkpFRGZ3NmNWNXNtQkpy?=
 =?utf-8?B?WjhNYVBKMmRkQkJ4ZGxNaHQ3MGFhZW1LYUtZTW40OEV6YkZtdnB4SmhhK2ho?=
 =?utf-8?B?QnhDZk5ad3ZzNEZKbUozdjBMeWxyaG5HNmFlczVRV1hxUHVYMUcrdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db85bbc-07c4-4353-3430-08deed3b1803
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:31:59.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd3z/HFUqi/5wsSH8VU1AQEJouha/67LqlQJgZjxNxIOWdTjMLkfEioif/lALusGJiS97vsW3uHyN6XgCYYStQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6991

On 29.07.26 08:05, 刘杨 wrote:
> Hi.
>     I have already performed the following tests:
> 1. Linux 6.18.20 + Xenomai 3.3.1: the system hangs during boot, but SSH login is still possible.
> 2. Linux 6.12.90 + Xenomai 3.3.1: the system completely freezes (hard lock).

Self-ported? Latest 6.12 is only v6.12.85-cip22-dovetail1

> 3. Linux 6.12.55 + GRUB configuration with xenomai.state=disabled: the system freezes.
> 4. Linux 6.12.55 without Dovetail and Cobalt: the system runs normally.
> 5.Linux 6.12.55 + xenomai 3.3.1  Using the Xe driver instead of i915   the system freezes.
> 6.Linux 6.12.55 + xenomai 3.3.1 and nvidia_uvn.ko with uvm_disable_hmm=1 uvm_perf_prefetch_enable=0    the system freezes.

That's quite a lot of variations. Pick the simplest one, with least
dependencies on special things, reproduce the issue and compare to a
working setup, I would say. Such hard freezes left and right are
unusual, and there must be one more or less special variable that
triggers them. E.g., if you just use our x86 6.12 image from
xenomai-images, does that run the basic tests on your hardware?

> 
> CONFIG_XENO_OPT_WATCHDOG is enbale and set to 30.
> 
> On Ubuntu 24.04, I monitored the CPU; the CPU utilisation is around 30%. A Gemini 360L camera is connected to the USB controller. I ran nvidia-smi and obtained the following output (please provide the output if you need further analysis).
> There is also an f81601a CAN interface connected to the machine, which uses CAN FD to connect six motors.

Does adding/removing this part of your workload make a difference? I
guess not when you describe those boot freeze with 6.18 above, but still
a variation from a generic system setup.

> +-----------------------------------------------------------------------------------------+
> | NVIDIA-SMI 580.173.02             Driver Version: 580.173.02     CUDA Version: 13.0     |
> +-----------------------------------------+------------------------+----------------------+
> | GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
> | Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
> |                                         |                        |               MIG M. |
> |=========================================+========================+======================|
> |   0  NVIDIA GeForce RTX 4060 ...    Off |   00000000:01:00.0 Off |                  N/A |
> | N/A   37C    P0             27W /  115W |     141MiB /   8188MiB |      1%      Default |
> |                                         |                        |                  N/A |
> +-----------------------------------------+------------------------+----------------------+
> 
> +-----------------------------------------------------------------------------------------+
> | Processes:                                                                              |
> |  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
> |        ID   ID                                                               Usage      |
> |=========================================================================================|
> |    0   N/A  N/A            1892      C   /usr/NX/bin/nxnode.bin                  131MiB |
> +-----------------------------------------------------------------------------------------+
> 

Not loading the nvidia driver does not make a difference for the
freezes? Or is it mandatory to even start some reasonable load that is
needed to trigger the freezes?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
