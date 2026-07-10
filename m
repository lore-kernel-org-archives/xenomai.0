Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804917D6
	for <xenomai@lists.linux.dev>; Fri, 10 Jul 2026 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678380; cv=fail; b=Jvek6gAzAw3exbNH+/AC18fb9WleupRCZ57WF9EA2XN9ak21WlQjRvTiPEEvsawisSXfJ4UusRy8jVi3oWESJ1QN3JXMhdMmPR8xHf/8r1Ikz3ja+rLhY8ykzCPKqAyhrG9QT1BPOCxT9Qd8Zu0jwV3EOMoE6hWiQr94+XKcdas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678380; c=relaxed/simple;
	bh=SqcA0drnwc5b9w8pXn11CoNnzIos0XSJ4YP84oUv4Q8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2lcird8rOY456CG/y2nf8eRptpQd4SKO1le/FlHwKCgv+T9f2NpLhp4lFNMkfdU1FIFa/Fi/BoInStorHDW66r75BYNFROz3TIseyvKSGh+RbWA8Pod0RFxYi4BZE8xSH/iZcV0As6W3r8aI+C5o0IOUccovIDFkzMGMnM/i4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=b4pyLnZr; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="b4pyLnZr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apdgPYiY68pYLBrWyISjeWG2q5vdKjd2lmANss3CWCFQhfh9pnB+4u1bp1SHSI5IQq6HS/m8uQd2+mnGhHipKxtsxSY5oHHkuwsE8o4rqMhGCdlLzuzzteCa+j5xB/2II59PsaKFn2+mz+rRtB9QAxZg2Q3f+wWly9lPcaliJKD2cm4gKyvAvlo0RCUIt+ej7c/6HruG/8vVt1rqXGeGUwR2b5kfjcb3HAjy6lv5/lQQ+s6WGteY9/j6vMwBO8+zwwYP8JEe4/7M6slOl1+K3aTck/o/cq6pPTkRXDK5pFGybOT86VO0nkX7oMoxvSQb0NtjPvmxIXrUyFiD63Fqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DbUTQjFyHXgLO2mRwcfFQrbjxb/uTXmPleBkzFGRx0=;
 b=WQK1oGggX54xVP+XD4WZa5PllCDY+21wGA7pPuhh/upIb5jFnaM/5+0vRbezFot8hInHKeGcjb4qMuhra6+qr0P/h0mq8YoANiOkIp2UdU5JMJInKhgBK3QEKfjJbKIqtEqwF0hlhMfejamfCWwuOms/YpJxdb1kpyLRcsUFBMYvc6rTK7aLgTJBiZuqzheOBWBPZWQiPe2hgIyyoOun1pIzjUj4P4YunXWksQhwJxUiIXcxXppNrHSU56WRNiiw1lk4Jl3rLRhZ/ljd09ZQoIY2cNx+wA0BriSH8xaTufnN7ik2s49apjQ3pWCXig9PGtTqj5JkfrtJOrBVhdkIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DbUTQjFyHXgLO2mRwcfFQrbjxb/uTXmPleBkzFGRx0=;
 b=b4pyLnZrRSBOIgoCcMlFVyNND8MSIu2GRFx4BwQKWHBW8yHEkmUxHk2HVVUQCcYspvXTdH2Qbi0K6muysQ/zVvlUTYyg4q8u7zVjxyN/pHqD/MClNeKh2kLU6GJUruYw0DDdWfaJfyUavk1eEQYfduI58HhPpCNxkjUwhpaOzkUEyxLktyxl5dgaYqqXYxVJnmJO4IxvCVXYuRBHSK2OaCsz1yt8eiIsrpNiWUiNuvcU1UAokxSIXIp4WtbkcESc9vGGobA6X0Ubq1MFTqgPNCuwAsERrQiYG0LqENUP/+Go9i2Dp4/+tk0icaxH/r7L1f9ZwMGq4mscVbm8DvLHiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 10:12:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 10:12:54 +0000
Message-ID: <ad8e6855-2d67-49a4-9a52-9819b93b1802@siemens.com>
Date: Fri, 10 Jul 2026 12:12:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip: gic-v3-its: irq_pipeline: Fix OOB context
 in-band lock warning for ITS lock
To: linz <powertree@163.com>, Philippe Gerum <rpm@xenomai.org>,
 xenomai@lists.linux.dev, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <517534d7.8863.19efe1f45f1.Coremail.powertree@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: c45d81a2-987f-40f4-fd14-08dede6bcec1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|55112099003|5023799004|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hsI6Q63hAReYvuiMcTqvJFW3iKpFX99PZmXZxiM0iYMtAUMu6jyABydV1fSVb61X30pdCMeKTXK7kzUrOt55oVNAxIJ/Nv9eVL4EXXIOgit7DZI8yl4hGl3k7mhmGSIHMO3j5tbE7ETTa+lXlHX0ElklwJVCOK4+WipDZisBf5Oyx1mbYyKRQXze2bwi8To2TgCKf1smLH5QSADWNv/+XHN4q0Q8Mfp0hGGBQICXFO28PIpgX+/hoYqe9lltyxM8diOegjhODN89GT/03OPZeS/KX0aS26nyGq8zxzKgyFZX3QAYBy7EnrGzmdy+sMQZPwO1D2rOz7QiB+oQ++iZ3KeX627UaRmZDM96wUpkGhr+LXyVBQ1nytNm3m96/NtjqAdJSR1uYARgOYMgxmPJB8UHPYu7It47qrQX8Z9KGO+HmobiuAjk+NQF0vKqYO9IWNH45vRsyRf3y4133xmb3N9dGKFoAUeho1fxHWdGvfvbZBUCXUvPBhvMxsWOIynkIX+vtWOLy5J3EuOx0Znp0GGcYAczWjJTU01pDIeukJtbvLJKkpKu18K8hPBgKsTEPjYLRvz8K2VAj2kZcIf6o30KKGXIcTjQnWz+twJ9OkvK7jW7XqwKvQB3Rj29bLyB2ByWPVX3vkuIln7/9HgOktRPELlKTFACt+BegIP9ZhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(55112099003)(5023799004)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTdET2lXcUUraHRxcFIvcnFkUXNXNmhjRGFnRllqOXZUSldrOUhVT25TM3No?=
 =?utf-8?B?OEFxcGNKTGl6YzYzdTBaeXhMQXlhdDNWUHdwS2s2UHFDdFk3U1g1ME9RU0dt?=
 =?utf-8?B?Vm5wTTBQQXVrZThJSmVJbk9DTkE1OUhQeTE2R2l6UzZaVFBoSXY1T2tHOTdv?=
 =?utf-8?B?eDU4M3dHNDZWZit0Y0xDYTBQaFFvR1l0eE4rQmtOZjZHZStNdVRkOFNGUlJl?=
 =?utf-8?B?MkQvS1pva1drQkhpVzRRb0hFOHptODFDOVVBeVB6cXZoZFA2WW5kOXNMaFJa?=
 =?utf-8?B?UzBxV3FVRGpPU044bXYzZ0VuU3diWVB4RXR5RDJYdGR2UDBFVHd2VklvbWp1?=
 =?utf-8?B?c0JyRlg2V0U0a2IyQWxRMTFrekVQQXp0V0p3WHlHRCt3ZFB3THB1bVNBeFgr?=
 =?utf-8?B?b3ZmZjlnWStGM1Mvekt2NkFzNHEzanY3NVMyVk9zbW5RblkzaExSQmNKZTIr?=
 =?utf-8?B?OTMyWStsUFNmcmhJSVhHQlE3Nkdic0YwNEhjTjVDVWhhZW9CdU5YZTgxWUMr?=
 =?utf-8?B?bWc1STdNaE5xUmdwOUZIRU9yQWdMb0szcUtzanZKS3R4QUU3MUtLS2RsdXBP?=
 =?utf-8?B?ay8xOVhZdXIwTjlWMi9LbWJld2U4ekhGNHhTMGRORDNObkZhWU9rOXllRzhx?=
 =?utf-8?B?TlZmZXY2M3ZFRkNZMmFFOG8yQncrV2Raa0tBTlcvcnBkTG5vcUcxak9tdmJ4?=
 =?utf-8?B?dEhOcUtZU1g3OG16THBQTHg0azdCdG1IZW1rWU5VZE5SSmhlcHJ3V0tHSFhX?=
 =?utf-8?B?Q0RUdkcvMjlvb3lyelg5bzFIQ1duSTAzczIzcE1Qa0VOS0dKZ3ZXZ2U1WEpL?=
 =?utf-8?B?UTBnS1AvSkVTeHF1UTNVZE4xN28wVWFZNEMxWS9vd1hZSDR4RDc2NnB2eUFy?=
 =?utf-8?B?TGQ0dlh1eFc4NHFOeVN2NXlVMElPNEMxTXVqMWRnVldLM3hVOHhQbkFkRTdH?=
 =?utf-8?B?Y0xqNHVFWGcxcDhFcUJlWmorYnpBOHFPK3pIRXh1a01OakpOQzVPTnpHK2lk?=
 =?utf-8?B?MHpKcXI4M00yVGI5cE1mditQRmFadXdiNWxDY1R1VVo2QVBlTE9vbmFjckxB?=
 =?utf-8?B?dFJ2bGNBUmR1VHdNYlBYSkxvamtaU2pHa3RUZ1FpSUk4WDF2Nnp4enlHM3Ny?=
 =?utf-8?B?Y2lCRUlYdThpUTFKZkU4dHVkV210UjRMZ2ZocUtTMXAzaDQ3cnJsWFJVY2hI?=
 =?utf-8?B?azh5cjN4c2RCb2JiRURJbEQ4a3YxaVZnNy82d0NCQnJzT0dRbTFBVjUyR1lz?=
 =?utf-8?B?RmJ3N0ZRQU9oRXVDeW5xRlkrb3Q3MzVCS1pkOUhtZHNFTU9VQ25JOUFpK3dz?=
 =?utf-8?B?MCtLSTdjRStBZE5PUlBabHI4SUVZVEpkTjlUN3N0bitjMmpUNSsxbmxWV2V5?=
 =?utf-8?B?VURjR0IzUVZHeS9qd1ZLUERuNjhGck9UbnZiUnAyTUFBa1dCeUJpWEZPNDZy?=
 =?utf-8?B?S2VWN0NudHg1RVkrVThJWkNRYnNpb3BRS2thSDVaaktUNkRMblA3eFhmd1Rr?=
 =?utf-8?B?Mkx0NnNSRTQwbjh5R0FWdS9SVzZ6THNoOUh6SnZEUlhORnU5OVRZZ0hQUWU4?=
 =?utf-8?B?aGs1WmxsRVNEdXg1LzNvUFBpVFhvTWhnTTN6ekU0TTNGQmluY0YvNTNEbDdp?=
 =?utf-8?B?ZmJEWUR1VlhJaUNaSkpibmpHL0tWUlYvdXNFUURJWmJYV2t3b1QwT1A5dUhi?=
 =?utf-8?B?QTdyUjkySVNObGNkdm93bkhRZ210Ty9abDNZTWF3Z29nYnBIb1NqeVVTM3Z2?=
 =?utf-8?B?aHFtdGFhSUx3Uk93Si9ZUnpiVlMwRXFuVDVNMDRjWGdPSzBKS1BzY3VXZ3Vr?=
 =?utf-8?B?aXdDTzc5SjU0YXhjQld1dk5sNk9jOVNFN2ROdklHV0VYVzE2NGZEaUFocGJs?=
 =?utf-8?B?N2ZIcU14VVhTNVROY1cvTkdoWWVUYUFjMlhZZDVBNXEzMWFhb2FBYjhLOEVx?=
 =?utf-8?B?aC9Nck9vZDRhQmFXTmxVa3ZXNGIvRUNwbUhidzI1RmV0Q1hUK0hIVzNnK1lC?=
 =?utf-8?B?OWZYeCtHckFWMEZRaWRsakdubHk5V0U2TEl1YmJnRStqdkE4T204RWhBbkRE?=
 =?utf-8?B?UXB1L1VONWpoYmtMYU9kcDllSkNiWGdIaTNCRHNtcHRZMGp3aXRYTGpMRVZZ?=
 =?utf-8?B?MThic1BSWVdBbWJxUjJEV0E5VEtld2QzdUJYMWVyZjU4S0F2eWJlTlNDV0h1?=
 =?utf-8?B?enFPVW56bHR5WGd3OXBFdmVLMGJGb0c5NWh1Z2xrR1JJYXgyMm9ld29uRi96?=
 =?utf-8?B?WFEyeklpSlhWUjcyRzFudXN5UTdmdzAvRHpJR3NuQTJpcWM2UDAyRVc3ckdL?=
 =?utf-8?B?ZTljdDRsaFdxazJIYnAyRWg4bGlkZm9IQVpMYVdVdFl3V3VWT3dUQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45d81a2-987f-40f4-fd14-08dede6bcec1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:12:54.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqGo1MuxkitM+GLKa+8JOf7QJp+iVIbZTgmrvTnqn21OKojhHywNAZhMyvcIepNZlMw8APcoOAh2Bj1CsrD86w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5990

On 25.06.26 11:32, linz wrote:
> Hi, I find a call trace when I use v6.6.y-dovetail + xenomai v3.3 branch, the call trace is as follows
> 
> [    1.510903] IRQ pipeline: some code running in oob context 'Xenomai'
>                              called an in-band only routine
> [    1.510912] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G S                 6.6.63-dovetail2 #8
> [    1.510918] Hardware name: Pe2204 DEMO DDR4 (DT)
> [    1.510920] IRQ stage: Xenomai
> [    1.510923] Call trace:
> [    1.510926]  dump_backtrace+0x90/0xe4
> [    1.510940]  show_stack+0x14/0x1c
> [    1.510946]  dump_stack_lvl+0x84/0xc8
> [    1.510953]  dump_stack+0x14/0x1c
> [    1.510957]  check_inband_stage+0xb0/0xc8
> [    1.510965]  inband_irq_save+0xc/0x28
> [    1.510971]  _raw_spin_lock_irqsave+0x14/0x90
> [    1.510977]  its_send_single_command+0x24/0x154
> [    1.510984]  lpi_update_config+0x9c/0x144
> [    1.510990]  its_mask_irq+0x2c/0x64
> [    1.510997]  irq_chip_mask_parent+0x18/0x20
> [    1.511005]  its_mask_msi_irq+0x1c/0x28
> [    1.511012]  handle_fasteoi_irq+0x1cc/0x2b4
> [    1.511016]  generic_pipeline_irq_desc+0x6c/0xa4
> [    1.511021]  generic_handle_domain_irq+0x18/0x20
> [    1.511028]  gic_handle_irq+0x4c/0x120
> [    1.511032]  handle_irq_pipelined+0x40/0x64
> [    1.511038]  call_on_irq_stack+0x24/0x30
> [    1.511044]  do_interrupt_handler+0x138/0x158
> [    1.511050]  el1_interrupt+0x40/0x110
> [    1.511055]  el1h_64_irq_handler+0x14/0x1c
> [    1.511061]  el1h_64_irq+0x64/0x68
> [    1.511064]  default_idle_call+0x30/0x78
> [    1.511071]  do_idle+0x128/0x150
> [    1.511077]  cpu_startup_entry+0x34/0x38
> [    1.511081]  kernel_init+0x0/0x1d4
> [    1.511088]  arch_post_acpi_subsys_init+0x0/0x8
> [    1.511096]  start_kernel+0x504/0x5cc
> [    1.511103]  __primary_switched+0xbc/0xc4
> 
> 
> The function call causing the issue is as follows:
> generic_handle_domain_irq
>     => generic_pipeline_irq_desc
>         => generic_handle_irq_desc
>             => handle_fasteoi_irq
>                 => mask_cond_eoi_irq
>                     => mask_irq
>                         => its_mask_msi_irq
>                             => irq_chip_mask_parent
>                                 => its_mask_irq
>                                     => lpi_update_config
>                                         => its_send_inv
>                                             => BUILD_SINGLE_CMD_FUNC
>                                                 => raw_spin_lock_irqsave(&its->lock, flags);
> 
> 
> On Dovetail-enabled kernels with Xenomai IRQ pipeline, GICv3 ITS interrupt handling runs in OOB (out-of-band) interrupt context. The original raw_spinlock_t used for its_node->lock invokes the standard in-band-only raw_spin_lock_irqsave() interface.
> This triggers the following pipeline context violation warning: IRQ pipeline: some code running in oob context 'Xenomai' called an in-band only routine
> 
> raw_spin_lock_irqsave() is an in-band exclusive API and cannot be safely called from Xenomai OOB interrupt context, which violates the IRQ pipeline isolation rules.
> 
> I think that fix this by replacing raw_spinlock_t with hybrid_spinlock_t for the ITS node lock. The hybrid spinlock supports both in-band Linux kernel context and OOB Xenomai pipeline context, adapting lock/irqsave logic dynamically according to the running context, eliminating the context mismatch warning while guaranteeing lock mutual exclusion.
> 
> The fixed up patch is as follows:
> 
> From 1037fcf6d75ecf37e1caf283d1198177e7410be3 Mon Sep 17 00:00:00 2001
> From: zhanglin <powertree@163.com>
> Date: Thu, 25 Jun 2026 16:56:31 +0800
> Subject: [PATCH] irqchip: gic-v3-its: irq_pipeline: fix OOB context in-band
>  lock warning for ITS lock
> 
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 0e57735eac..847b008b71 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -94,7 +94,7 @@ struct its_device;
>   * list.
>   */
>  struct its_node {
> -    raw_spinlock_t        lock;
> +    hybrid_spinlock_t     lock;
>      struct mutex        dev_alloc_lock;
>      struct list_head    entry;
>      void __iomem        *base;
> -- 
> 2.34.1
> 
> Please help to review it, thank you.

Thanks for reporting.

Philippe, Florian, any comments on this?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
