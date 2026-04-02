Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F953B2FE3
	for <xenomai@lists.linux.dev>; Thu,  2 Apr 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165013; cv=fail; b=XJT9mbikEaNM8D9uwpGP4WTKX4NUsZQllkLgj5brYWKffu9diBHX5R2WyBUg93cDz2loLhUlMacof0rYC5vFFOPEzzkK+lHqqSisOmDcm9jgijVwnOvPXfe1rt/7a0abJdIuH9kPuhJ/mKbB5jpcc+11cnTPFv42Zr2PFhsl9Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165013; c=relaxed/simple;
	bh=ZWZS98RF2GMMwyel9rEYqyGrjpDC40hbnNyNW0G7jgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pHoS7EHCf7SmqTkinosepNdoPHqCjcZGmrYMQTB60F1dhHWEXg2Dmwfc44namPSt+UZCBq++2hagqV6HOTZBAHJmSM4xCiW+22zPlos9ApqOfIZhLonE+hqH1ghPX6TRDDsRTQTw9DErvyZDtzF2ATaoKVMLeKPdkLHaJT0dXU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iHt/Wz1o; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iHt/Wz1o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR0RPWYEl+fFFP0lhAIzXtGqMxuA8Zk2hTsg/PfT0qTxu9lbmpast33HzQ6CPUZ/S0mSXQArzixnL2IXD0APjWXvTLXSx8q3yI0XQuCnJqwnfjVwDn1y2G09sQzWe0zHVhHhJHyK2ZbVoZ0HheS2lJ49Q0UF6PjULRySR+3UnSMcu5BTnk+EF3mCO5rcyQV4mFx4HkVYOMq4nPcnQIC7NfqU0uXN0hWzV8Gngg+7aYkiFX6tcRrjSJC0REGYp21adQeeDbCHuXSm9P0G43Y/C86EbChpgqkyQl4aVObYx3trObG+dT7Pr6TsTNo2F752/7umjgOFDfYr/GTPxlTcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05HdgQ/62c3HXuBETSqSmJRRx2bWK86kLEmiUk7+h9w=;
 b=wOB4dGXJiVl7YOv4cEM+XZk6XYYSknrDufMMJFvlHTF0ALdQKdrpb2iN4ey0tKNKoIsradRBsx8DQRMSZp0stDaIc2gIcwJO+xnvJ4P3ypSTF/aofzesrpOhkEZjPLJ8yMVEjz6cE0TMhKMdTO8Z+qwiZFOByhnD3s3OH5GVxH8WJDQ2e0MfHxavtherMCx1Y7R7hQ5wQ1Hwr4855RCzWD1fViPcvbuxoI00ySu9XTyyFqGaaJiLnKey86/8VpU0GE/BK5eOgF/OikkHtcNZjkJf91Wst2UeuURv2j/s12NC90yydbxtsdsVNIBiijdzzhXK37mrVmmIB+pdaTZrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05HdgQ/62c3HXuBETSqSmJRRx2bWK86kLEmiUk7+h9w=;
 b=iHt/Wz1oVQJFyWs4VeFqo7A9q8OkrVD2ByttcRDVUEsHiquzJ6mqjAU7dAh7gbdlrcBBaEq/fz+2raEUO/aS3S6ftlmJbLshlOqFuy5WUZwmgTy2IGMI3MxIp2p8niEHxHjZWN2KlFavLFNLg2o2rC9yf+N9IcuJ/I1640M4oCO3jBlvtdIykfMvNo3rEo++fW3BuAIu0qg7EDYRRtt1/j6k6OROz0U9+5Mb+KKfVVNzqHgaOg7/vZhq62Dlh2BisSt5oHkoMX5uLQ9Kh2rI/JQNfEorj0MOOq9BKL95g6t7zTC27rbTxhm6Hsj6QTJGLvGzmIu1brqAZv3HG9iyCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8314.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 21:23:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.027; Thu, 2 Apr 2026
 21:23:25 +0000
Message-ID: <55bcc705-d805-4248-a7d8-459e2a3d5b6c@siemens.com>
Date: Thu, 2 Apr 2026 23:23:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
To: Brandon Ho <brandonho667@gmail.com>, xenomai@lists.linux.dev
Cc: Brandon Ho <brho@relativityspace.com>,
 Jay Sridharan <jsridharan@relativityspace.com>
References: <20260331231457.141480-1-brho@relativityspace.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260331231457.141480-1-brho@relativityspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ea640f-87a2-4af6-e599-08de90fe12d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	v7QQBH2jIEfRm9kLmx+idaGKZyNm3IebQ99qIJT6MwxmEy3mMOXtARPJc4NfKN0isq0aiiL/8eRCFlWBHRD/MYErsFMrpKLHiQDBGepKPNJ2OraSjo599RQjWevP/y7LSukhLbxRHUgu0MKHJZgK63pxLooo6TENlMFXXLPwTMM0BYbENp1UMLkCYvygSddB1CtsRjabn0Utz1myaqqibnD3wjEFVxQbPtGEDc0C5J9TPL+xmAnJ/DicIGK2wajz4qCjy1gJwkAP7xJH4zFWO2uUKg4iNY5WxVEnk0v6h1eEJPotSSesnik5/H9psRCzzyWv7AvD0bAtc/kL3xUmlqSmhhXZN918/5RaDbka3dO6UbU119Ej0rcMDfTEwxr5YJVmllnl4lRiJUTzgTwBb+xVG6If8QN4xNz/64jBOxC3vXOMNqf6IhxKJgo6PHi43HWumb2LrT9Hrg4KUt9CS+Dtou5IoUu74DD03LMBCIJgm4++KVGf71KE0/l98lCBWXBGDkScgSTuumP3Pv4obZ1uZ97c1bWQ9/LI4jfsLDJekRkza57B6H1l+6p5mnO21rwMeeJobN2/kfJyY+YLeM0edqtku8PKwX8/tC2Q2V4quR5IUyMie2lcAG4QytZ/phjO9g+HZBaSfvXWf65GxQX8z1FzgktrFxTP2dXEPeBW0ObJSx1Bm74S65nhI19IOMZgaMJ2QuXMCrejpQaQG/C9SgpZZeLyXNO/syMgAiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFlaOFVZaStBbjJmVjE0NiszdmQ2bFdXNDF0S3pzcVJCbDVEdXdRQUxramFO?=
 =?utf-8?B?Sk95ZWNqMk4yL1lFc3dhcXlEU1Mvb2M4Nk5COVBmU3BqWGN3MDZNMXVQOHVq?=
 =?utf-8?B?SEMreXRBWGtudVRMUko5OFpJcnN3dXpsei9MMEZ0amRCYWlvSktiTEpsam9r?=
 =?utf-8?B?dURJQW82MVhXUUxqMm5xUm4vWnhFYnJ2ZlNDUVFURXp1MEMzd25Fcm9iczdV?=
 =?utf-8?B?Ly9qU0hTbERNWE94eEpsYTJCcGhnWUp4aHlva1ArQTlGRUU2MVFiSkZ2MEt5?=
 =?utf-8?B?MlF3eUpLaHhRTnk0dDFoaVdoMVFzOUVTWndnSXdOSlo3UVJGcEFnOUlUWVhI?=
 =?utf-8?B?b0xtMnpJYjlKR3ZiNjF2NlI0MkNsSk54UjJ1K1VjblFvY3hPZkJvSStPcmZM?=
 =?utf-8?B?Z0g5OFdKcWRZUlZMRytRQ1dnb1BLYXJlTkFrUUZNcE1VanU4TEFzWDdxTnJx?=
 =?utf-8?B?b01GZnFhdDlLWm9yVCt4ZWFWNk85YVZVemJLbmJPbFJBVGlkd2s5VjFyeFov?=
 =?utf-8?B?YXRqRjZGMlRFNkd6NlZsWC9pU0IwU01tSzIrZi9RMHAwSWRMNjMzWXRkeFRT?=
 =?utf-8?B?SUdRQzkvelFzNjdnMXU0WU9ENTMrR2dSNHZaWXVYSi9tQ1c5QkYxNUhvQ2hG?=
 =?utf-8?B?VDBPWVNNaktaektONTBJWW8xNmhNSFFkdTFMcUJBNnkxd3NtODRtRDJMTmg4?=
 =?utf-8?B?V3QzRzU3dW1YOERiRFNlREF3MFB3UmNJSDhJZ0ZKdnJRL1J1aDdyd1BqNFQy?=
 =?utf-8?B?cjl0NmV2RWJvMzJiL3hlcWNEQmlYL253bFl0TVVQc055OUNHaGFtVjRuRGVB?=
 =?utf-8?B?WnJ6OHExZ3pKd2wvQ3EzQVdxOEhER0FDdXd5THAyMythd3JsTUIvSkhzNVVt?=
 =?utf-8?B?L2hycUpwWHRUWHVLMHJQVnNjK25BK09yMHdCajBBUlk4QSttV21DalJnV3V4?=
 =?utf-8?B?bkhzdlNqL0JmRVpjeFN1U3krQVJYTzBteStHL2o2VEJEZThhOHZqam1ubm9X?=
 =?utf-8?B?TzdGQzJPKytzVWd6Q2hHT240Wm5senlhVExnTU9PNXQrNHBXY09zT1dMQTNv?=
 =?utf-8?B?SzdTbjFza2VMTFlLTkl6UFMvd1R2SXVzcWxtL0ltV0pNZ1dmazRwaktqaEVt?=
 =?utf-8?B?ZzdBYVBXY3lkeDFTQ01qNDFNQm00V1hQRzEzVWVYYllIR0RaOGFlclJ2S0Qw?=
 =?utf-8?B?YndHNlgvd09UUjBBMW5uN3FpYjRBbmxqd0VvcjUzL0pGOUJxbWUzdkF0eURX?=
 =?utf-8?B?UUlHeDQ1QWVJRlRYTHU0ZEpFZVFzaDF1dXdVZk1KVXhaY1dzL05qWDJGdXdI?=
 =?utf-8?B?TktGTnloZ3EzTVVvK1ZPU0l4VEI0d3RPcmxXOFVMd1puQW1tTXNhSit1OWo2?=
 =?utf-8?B?Si9NckplaW5DYmR5dGNmUCswZDF2OEhaL2VUY3lwM3hiOFB3RTBXUHZneUJ4?=
 =?utf-8?B?R2dSREI2ZmRDUHF1VEMvZERmcFVidkhwVGZBSVQ3SHAyNDcydFZ3SEgycFBN?=
 =?utf-8?B?OHRvelJpUnpLRVh0RnNyczh1dVNqVjRlc29xczdTZmJ0MUlRQVJSV0pjVzd5?=
 =?utf-8?B?aEhlV2FBSUFQUVlZRjM4cFM1ZkNLcVc0U0IxRzJISnB5Y0lha29NL0NndFh4?=
 =?utf-8?B?MDRDTGJOQ1c5a0FPMmFEU2ZPNnBZazNCWmFseEQ5QVZveUoxeXNLR2d1WkxC?=
 =?utf-8?B?Y3l6VWtVNUJMRk9QaGFvbm5Oak5FQ0kwRFJocU1kWjRRbTEwU0N2MUZJTXNS?=
 =?utf-8?B?VlhHVTd1emhBWUFORkVYNVZ1VWdJRlZsWmNFZVpFQXJWLys5QjB1aERJdWhq?=
 =?utf-8?B?UThBRks0MlZUQVV1MkNpQmRXVEJ3Zjg2M2FZTmRPTU9taWdPQ0dlWTk2MHM2?=
 =?utf-8?B?VDQrd1ZYT2l0UktFTi9HajNDc0YxSEJPdHRnWG16UlJRazJiS3A2dDdvMDFw?=
 =?utf-8?B?VE1XSnFPSTEweUFYckxITER1OGpBcHdEbDJoUUJIb1BiN0dsd2hlSUFpRk5Q?=
 =?utf-8?B?QUJJWGtxWUtjYitsdDdLSDh5ZGFwRGhhdG5JSXA3SUdmOEtkK2ttMHJpQ2lJ?=
 =?utf-8?B?M0xVMk5aV0Z4VVlLbHdsTXZTVGFKK2tzZUtPdUdNYitzZHZSNVlDZ1p5aXg3?=
 =?utf-8?B?OVhqa1lacndnNFh1M1FnSjF5UjNnbGFsK1doenZvbUlJY3hlR0pDam1vRDJw?=
 =?utf-8?B?TldNMUZQcVFPcEhnYWZucTc2RlNaRldCdTA3dGdsTUdpZVIvUzB6WW9reEVm?=
 =?utf-8?B?TlhpUzQyUStodEdoMkhJTEFET1J4L2xQNTZWUUd6ejc4aU5kclNCQmE5SWFy?=
 =?utf-8?B?cTI0aDR6YjBmaXdnUDVMeGFscmJnT1I4VnM2QnJwWkdVS1cweGVSZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ea640f-87a2-4af6-e599-08de90fe12d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:23:25.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1Yod2ePah5vBPcyz90hxcV1AvunFb1wgfdj7kecMQ0kVgvoWNHT4AyJcbCcwsy68F32f1R4oY4pDaI92I4kRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8314

On 01.04.26 01:14, Brandon Ho wrote:
> Hi Xenomai team,
> 
> I'm working on a real-time control application using Xenomai and we've been
> experiencing unexpected in-band transitions caused by minor page faults during
> kernel memory compaction. Even though our RT threads use mlockall(MCL_CURRENT |
> MCL_FUTURE) and we've pre-faulted memory, the kernel's compaction process seems
> to temporarily invalidate PTEs on our locked pages, causing faults when the RT
> thread accesses them.
> 
> Has this issue come up before? I'm wondering if there's a mechanism to reserve
> a section of RAM that's excluded from compaction/migration entirely, or if
> there are kernel/Xenomai configurations we should be using to prevent this.
> 
> Any guidance would be appreciated!

Memory migration as well as compaction are not compatible with
deterministic system behavior. Both Xenomai 3 and 4 should warn about
them, and you should disabling these features in your kernel.
Unfortunately, current kernels do not allow a more fine-grained control.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
