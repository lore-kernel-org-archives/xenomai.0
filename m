Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44D39658D
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615178; cv=fail; b=urQ9L+vW+nvQKYghVo5LfFRQT2AaROC7O/Bp1Mrrq52XiJBwOzJ23Ss9q2i3WxO8wN8N2SauO06gpIiimxH5Ky6NSiVVUweWIGXUx2ZkqApacYN/egczO8T5U+vdgZzoR4Jr+oZ/DMtNt2bIXFY817WI4/AN5+VphEKplCkZPsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615178; c=relaxed/simple;
	bh=rW0oImQZASo0StksQ2LBYypI4exlWF4J4DPj/VcBd5A=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lh63ayQJYzWeL8lptr/2Jc4vsLdBdHcEcPEKpGEamQ7k+Xm3P8JEFDZtZUNlrYVComWaZWp0YgQi8vJ3pzS5Lv8ORnS8LaLrgzgF4Icir5YBSgUzcjCMeQtHQPTHB0w35Fzrvog1tPM9PKGDH14XLS0W/m1vJQLq3o9n7oP4Fgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yYJiScDt; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yYJiScDt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/W1vmpIJVRRGgiGIA+Ca697FakLdpV0pyP50FMMt2NehW/40DOQS4CDZwjhBBSFdh+Qwv6rC3STFQu528uNfY6MFomJXwOzps76iqZmWwganYZd/gDkICrN+WH0bjxzieY51DE4v4dL5gEQfMXroEOocFGtcnfYZKNhb/N4aa7widcWarBjBBQrfLAM8Z+4sP0zJxj6kH5jaJK5F/glG7zHBvmGG0R3QZlZgr528L3RPbGCP9sqOLw8ni2aOrvtNj+f57+HUOux5ReBxYvpel1t9GQfb+JI/yZqac9iy9TqPcVZ3/BbTXuYKIP6A2jWkCi9nbBgEMDPRvQxD16GUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRVY2dZ0Btl/R/wXwrskYrssTjJxP72EaB+XARpuD24=;
 b=jhDXNdqW4kUmTD4vQ3uFl1vn+/GxB1Lw1dbLLTrF5vdGYVMawmG+66XYFocBxU7rMdf7HgZJGTKWO87sqSlU3ZfHMC3XUYDE1MxPgCqtJd5cu9vqapjE8mQNCCb2gJx3xWjiaCSoTNl8y9xsBfwjZLDTj6JEdETZZn5scmh4RtniP0H7CBtPITH1MBOrtVkCQIvXNz5JDSYm6I+1keoJtlBThhKH475oRO3QmPriv/uBDKIJItKUAW/zoUCro9lAho1VbrBEGJPR7f86KZurdlnjyUSPsZaFfQNAS3A9528WLxmwagrepGEOIF4nyd33d9LgnpKwJZ1hee5zOQRtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRVY2dZ0Btl/R/wXwrskYrssTjJxP72EaB+XARpuD24=;
 b=yYJiScDt/UpSzZ6U+4AOYJ72RKFssMOapLxnibxGcwRqF8JfoA4CN5uHlEfq9pNmtdazsy6BPNv2KgmuYtKdTPnEvp5e1IppA3uTFGJ/k2fW9+ZP1j9H16uVF6thYdgc818dZTuBBNQLlLcl+kAJ9ctEy1F5Kl+nacgYlFbThmvv9I6Oe2TvFM5YR0ckb5oITWj6J+3oXdrDl2p8zkKtGbYDDonkhPqgr/KXcXV6JUZVJH4sW8VkiHcR4Q5b4/z1qHz3D+KS0jCsth/hqIJSWRGpFanSXBph2n+eBydS9Rdn6y2KOWb6n9dU5elJitu9jKLSIjr3LtFETXh4ob/Wxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::20)
 by DU4PR10MB8544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 16:39:33 +0000
Received: from PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cb59:4914:5780:9cbe]) by PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cb59:4914:5780:9cbe%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 16:39:33 +0000
Message-ID: <d7eca2ba-e5e3-439a-8c1d-c7d82b4b2547@siemens.com>
Date: Thu, 9 Jul 2026 18:39:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libevl v2] build: add initial RISC-V support
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260709134451.325524-1-tobias.schaffner@siemens.com>
 <2dcc2289d120ec592539490954f262732f4966b7.camel@siemens.com>
 <bd53dc18-eef7-41ca-bea8-a5e97fb91207@siemens.com>
 <c208544f-f9c5-4f54-972a-cc7256fd2095@siemens.com>
Content-Language: en-US
In-Reply-To: <c208544f-f9c5-4f54-972a-cc7256fd2095@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::20)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4977:EE_|DU4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: f2037738-fc5e-472f-208d-08deddd8a7a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|22082099003|55112099003|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bB8hXGVCdLrkTZF9jyCe3Nv7TUWXNmgYBw6AXJiNZwji6uYDa26L83UeJVGjgyP/rBM7idWMjUy51lMz2ZNODkdzhFNXZa0Sul22FwhuSlN056T+BjsYvn9r2FRmMbMu/eVX+aTLkq8ssz2rSvhWG07AQdZCCrLK5rDRMlaet4wHM3/s3tt2J6vzV2aKhYLJVT8NLd4p31vrOPZzub4M3QGXgkBKES+JI02WBlj2NmNCvgksnydBbsTU3HntXZY6d3llNf+OKoOAS2Fggb4vTqQnNOk1Yz4PDcHoX/NSIoi8KMCr6Qfs6G0KJUYlLy/ooT0k9OXw5UYM7VMJpZ4EJDU+aoZu58aXfrDfLAQrt/8lLlYNWbLUdCpZC5jhoftw4FnSBIVN+AyHau+KX7DO9ojgzUFBIw7oNyY9xIx/IrXg0x6zdmTnmkHAxjcO22oYk4I+epBsGgV0YlP6t8grn9swBNgpn0GK8AGV7D/E1JzL/HndfGCRb2C0LPe3i2lE41AgS5KaOXsXPGwFvAauw+N9IFf8PlvpSZnel1qRfDjdgr6Jeh3D/Ui75YTqOb8xXEY+YFeFmIwrw/aWvG4B4NS9g4l29+Lh8nH9iH0LcjFMPsdURn/RFcmJj/dFnLAQUdkGGLsASWc4BkP4SCDBBhKF32j/8Hi0aw3MVfvwAqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(22082099003)(55112099003)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk5QR212Rys3SzdDc2ltV3QzbTJ5aFJnTzJoaksrYVp4dm1CaUx5ekR0bzB4?=
 =?utf-8?B?WEFNOXZLZ3JhRkZoOG1RSmxXNmNaTVpoQTBWVzI3OG5HVGR6NHgzUy85S1F5?=
 =?utf-8?B?Mk1MZlZnUllMenJ3NGVoV0pIVmVHcndlb3p2TmdmNHF0R0M3dDczekJGL1Q4?=
 =?utf-8?B?OXVFRDQzMWtROEtPb0JXcm5aNkVLWmtxWTF4NnZhejduQTBPZUJCUDZ2Yk1D?=
 =?utf-8?B?STFRakl0QVJUbndPK2E0THRLUkJZQTBMRHh5TG0wSjl5MThiL0tnRWk1L0pF?=
 =?utf-8?B?VEZPVGRRcFlFakZpQVJRVDBySmlwdmZnVTJ0OHdQRlR1UGJhRTFyaVJBeGsv?=
 =?utf-8?B?ZzZGdlV4N29wUmE2K3NjRitEc3BBSXVISHR0dWJPcm56WGk1VUJreU4wcjZK?=
 =?utf-8?B?OW0wODl5a2t5NXFUdDJGd3BjNHRpREluSWxZcHBmTTlielVnb3FvY0M4UjIr?=
 =?utf-8?B?WVlwZStFTXlGUEs3ZDkwMGoyVE9XYzNWMWNTbUU4RytBbHFGOUN1WTBid2V2?=
 =?utf-8?B?N3lEZlVFNktVdk9BTVZ3Tk53RU5lbzdMZmVBeXZFQ2xwZEdGazZScEZvT1Nm?=
 =?utf-8?B?bmVuQ0NjNk02cU1Qd25ZN1lVVVY4Wnp5S0dydE1kVC83L1UyY3lZK3BVUW9i?=
 =?utf-8?B?LzMrWkdJUDJMa0JUMXhDU1BreXVoQzJCdmhDMVZIdUNDUmczZ0ZSTjBxTnZp?=
 =?utf-8?B?cERIZFF6eFMySHFCcWVhWHlMTFV2dEJwSkEyWDFUbit6dlIyRDlRYldyYjE1?=
 =?utf-8?B?NEYrU1FKOEwzakRFa0NudU4vYmRxRm84ZUZvMDJEYnI4cmtzYXFMN2g3cXR3?=
 =?utf-8?B?dW1lTjFzN1FXaXkrc29YVHJqNWlZcnRTN0E5RUtjTTVrYkp3Vml0dWZVT0Ux?=
 =?utf-8?B?ajFmOGxuRlY2MUJaYmpqSHJRVEU0SHZDVmNUeEFNN3dTbDhVSElJcUFmdDZ3?=
 =?utf-8?B?NW5SZEtHZndWU1d0TDY2TFozaWMvaG9EQ1JxclJmMFpVaGdnK0lJMEE1YXMx?=
 =?utf-8?B?MHUzZVVMQ0h5akZJN2lEWThlWDdVd2NFSmlBamo2ZlVwUkxxdFFqN2lXT2RG?=
 =?utf-8?B?dVAvVHUxYllDVlpUUXQ2Q0VyZzQyN3Fuc2U0NDdscW1ReERYNjU5V3ZtenRW?=
 =?utf-8?B?Z2orUnFhUFp0SnEzR1VVb0lXaTF0TElISUhLaGUyVDBIZGRFMzVPNXRtUWxy?=
 =?utf-8?B?NkVyeldaWjh2eFZlZmgwdTZWeXV3UVkxUnZSRUFIU2MrNityRkNWanFyMFBu?=
 =?utf-8?B?RzVsOW8vMEQ4cmVVZnJYUmRJMi94TGp0L055M0V1L3NkdXh6TGU4b0VZaXlt?=
 =?utf-8?B?cDBIc1YrbC9YdXdtdlkyaFd5ZHhTaFk3aDdvVGVuNHdqTURpU0xiVUdVRUgy?=
 =?utf-8?B?aFUxMk9QWStFVktMUTNuK0hpRDA2Rm85c0Y2Z1ZKWG1CTmZNQThUaEc2Q3VY?=
 =?utf-8?B?NDViVEpGVHRPWlFTVUNSVjBYY2JubEVBVzFPNEwydjJoMGVpZFlnSGZsSkFR?=
 =?utf-8?B?NGwwUjBqVmpEK21jWkd4K1pRd2V0dG9OalloZnh2ZnZmV3BTd0szUFNvT0F5?=
 =?utf-8?B?WW9DUzY1NHpRTUlZVHpKZjUxS1JPR1R6d3dHTytzZXdFd0J4TWd5MHBtV1BO?=
 =?utf-8?B?YUZEcGY4VjNRYjBtUHdYRk9YYlV0OVR4dmN1cWhZWE9BUUVtLzJEdkxLdWF4?=
 =?utf-8?B?WmtEQzZNa0JDTkMwNGNKbEFRUUdmdG84alNzeWxWUkFPcGtVTmNML0RjYW5l?=
 =?utf-8?B?Qm9KSDRWU0ZBdW1sVlNFUGh4ZjNwV2hNQ0Z3MWh3OVRNMTlyWFVxMU5Cdy9B?=
 =?utf-8?B?ZXVLU1UzQzFXdmlLWTV3WG9vanl3ck9BZnh3cUUycENWWkVNK3RLMUUwbEJL?=
 =?utf-8?B?K3dHcUhKamE4UkJMdU1LWG9oZjZDc2hScFZFU0ZlMVljRjZrc2lGZE9yZGRW?=
 =?utf-8?B?MWd6SFZqcmpkZlBGL096Z3RMdWxibDhOM1ErNUxVVVdJc1hFaVh5SDdYNUNS?=
 =?utf-8?B?K0tyYTFQcWVsTlBMbk9PMUFHZzMwOUxoTWpqalBqMHROTmR2aG9YUUdBS05V?=
 =?utf-8?B?djM0WSt0TEsrUnJ3WFRFS0pkbjRaNFMwcVl3UlpGb2hOWkQrTXFjMzdYVWVD?=
 =?utf-8?B?d1NVT2ViYUVIUnJtWWlQbHM3VWt3cEpsY3drVVM2Q3NsN2xweG9xdVM1ZVJr?=
 =?utf-8?B?Mlc0ZHFQUW1Ib3NmS3hETjdublVkWTYwNXpKaUZkV21PeG5zSUM4Q2VKbDE4?=
 =?utf-8?B?cldrVFNKSGJLSmtXeTdkNy9KTWtxKytwQno2OEt2NEJSQUZ1L2RNVkpyYjMr?=
 =?utf-8?B?OENtL2MyN0ZRaEJRVlV0ajgrN1BVWllnMmlZWTlHSUxqVjFIQjFOcll6ckQv?=
 =?utf-8?Q?tFZJ1bhcgnxjsjfI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2037738-fc5e-472f-208d-08deddd8a7a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4977.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 16:39:32.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4281mlBx1w3V7XTWv+Q9RVincgCLDn1RE64vjQxzzPCjoDFw5iNurli9SIWtZ29w5MRJ7js7Zg+sA3HcOKnA1RyP0lcNuHDoHypLhRpGNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8544

Sorry for the noise this was not meant to land on the ML.

On 7/9/26 18:36, Tobias Schaffner wrote:
> Click on a legend element to toggle display of that core, ctrl-click 
> inverts display, shift-click enables all.
> 
> Data to construct the above plot have been generated using the RT test 
> utility cyclictest.
> Unexpectedly long latencies may be caused by SMIs
> Total number of samples: 100 million
> Resolution of latency scale: normal
> Duration: 5 hours, 33 minutes, lowest P state: performance
> 
> On 7/9/26 17:32, Tobias Schaffner wrote:
>>
>>
>> On 7/9/26 17:17, Florian Bezdeka wrote:
>>> On Thu, 2026-07-09 at 15:44 +0200, Tobias Schaffner wrote:
>>>> Provide the basic build infrastructure and VDSO definitions
>>>> required to build libevl on RISC-V.
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>   lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
>>>>   meson.build                           |  4 ++++
>>>>   meson/riscv64-linux-gnu               | 17 +++++++++++++++++
>>>>   3 files changed, 35 insertions(+)
>>>>   create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h
>>>>   create mode 100644 meson/riscv64-linux-gnu
>>>>
>>>> diff --git a/lib/arch/riscv/include/asm/evl/vdso.h b/lib/arch/riscv/ 
>>>> include/asm/evl/vdso.h
>>>> new file mode 100644
>>>> index 0000000..5e331fb
>>>> --- /dev/null
>>>> +++ b/lib/arch/riscv/include/asm/evl/vdso.h
>>>> @@ -0,0 +1,14 @@
>>>> +/*
>>>> + * SPDX-License-Identifier: MIT
>>>> + *
>>>> + * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
>>>> + */
>>>
>>> ^^ Copy paste mistake? At least wrong year...
> 
> Click on a legend element to toggle display of that core, ctrl-click 
> inverts display, shift-click enables all.
> 
> Data to construct the above plot have been generated using the RT test 
> utility cyclictest.
> Unexpectedly long latencies may be caused by SMIs
> Total number of samples: 100 million
> Resolution of latency scale: normal
> Duration: 5 hours, 33 minutes, lowest P state: performance
> 
>> Shanmu directly copied this from one of the other vdso header files 
>> without modifications to the copyright header and I did not touch it 
>> further.
>>
>> Would leaf it as is if it is ok for you even if the ifdef was slightly 
>> changed.
>>
>> Best,
>> Tobias
>>
>>>
>>
>>
> 

