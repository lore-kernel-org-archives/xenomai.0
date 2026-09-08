Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98753CA68
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870768; cv=fail; b=a28Bkp6kIlLh/8JRHptZDA+OLCrtZ7gb/3hKniXxSEGPt6LgMVNjB4IapTjPRPmEejTXSsZZA2zDZ4FdzTlS7xyruEZ4GZKy2GqvnFPL0W87hLEIrMRwpW9vN7I4IV4EL2ZOB2jYdlofL6ffVsapv0xf1hn+XjHE/l5ieEArCM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870768; c=relaxed/simple;
	bh=+1hKc2EsTusiM8RhqrdIldBrSLUXxM410UN/QEXvaJc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uZnGnmdjEw1QKAhK1hwaBwFzQwJ/llNGwR9evg6lFmRGrJtsHQbcqffnlXe7KwclY7XhjpDzvrTGf9ROkt3hkRXjpuVQcPLmeUOTqzPDJR4flWDRJMXrYaDwxELnPyPzBWFzcF7ik0sa682LXVG9yHwd4ydYChQMpDIQKGyuIos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PzQDxQM7; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PzQDxQM7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAcl5Br2LV+8I7LimM25HMj/A49lzhtZZmV1crZj+SIIiBvlnrMx+Mkt0xmQhVmx4kKMSy/oPwgRPmOrx+qpo0sNeNLqG0igYKWfcyimQqE14oFuXGGQyS8JSULa3SINacGzI8723iQBq4OASaJwMfGPHi4m6LTApksbhYLWtDA90CORRxPiEoXXrTjiIynPfGWO08Amn4E2ncRN8964Y+JdQQqSd8FLeMEYkBeazsbH51g+MsOWKIyWl3XORMQJdZhI3IUWZSX0p3ZesOJBANPp2uOUAzqykbwJmFgfAXHV405+CVpSfGjyJlWGU9WfwHDuHZSESJ5s8qmdEVpb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8O+Tp/6rr++6mkW2iBp+zKCIp9q5W5/y4XpbdKuolA=;
 b=m3NGjW1wq6PWHoRc68S3nSvYfi/FfddmBDnT9YfASEc/rEmA20MpE8eKYIVV/+D6jPYXL+DyZkzje3QRl9g+Fm1M4LRSQSJD2S12suEFY4bUdE2uxaaWAaQeIhXIvFCXtIxuqrUvy7iTXgu7dOruil383U/W8h7H+dUeK4CNvf4HEoJdl+hTJb7Dv2VPt9Qrn2U8zRR2FGGiX3Py9AVPWxAcv0sQhXu6xt8/sLxS3lKSy9KXd4s/kD9bk34th0hPEBTlNGp/op0Kcmt5nL4cR1FAlirfgOsHxwXAR6uwUBlUOdHD/f4xwTdIMQlLOSj2Rk9bGWMvdAiZ4LkWiR+ETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8O+Tp/6rr++6mkW2iBp+zKCIp9q5W5/y4XpbdKuolA=;
 b=PzQDxQM7PTgbVzXAMQmyFeXpJdR15d/jGFPP9UFt95QTi8nOAJso7G8IwdHE+ET/vSFNGWdh3BiEDhA0PT6Ic1BqhF2ULjIH7e18cuoXyyeQknelS63GR1QY53y7MiWyxoVqCVH1zCiU6NA01qT7bg/jzfKMa+GGQuUtJ1DCs1XG10ildV9BkDMOuPgzkm4Ps6b0png6DEMEMfvjNMupmSH4/ZXEtrg9sSmCtfLXFJrN4PSWGaQ2QO3HS65NTvYS2ZgX+qRyNpnx3i4lquZ0QVdgcVqgUIdEDv4WWGj0xBxQjkBh1ZVgD9ncZHhndQQz/IQjcn8bmFVairaBVOf2AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:305::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 12:32:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 12:32:35 +0000
Message-ID: <b41b125c-e243-439f-ab5e-2d410f88298b@siemens.com>
Date: Tue, 8 Sep 2026 14:32:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] xenomai 3: Add support for Dovetail 7.2
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260908-wip-flo-prepare-for-7-2-v1-0-eaf975a56944@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260908-wip-flo-prepare-for-7-2-v1-0-eaf975a56944@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 5279f999-f20e-4ce4-478b-08df0da542a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Nfz5gIM27fljtsKF2RK7i5CMLQ/F2IFjiwh9CVKdhqrmM9Xr4uaTB6qcOAvujzoql+/5CLAmNlybd11qQUv4TOByoxBudMc6f+PHzeC3UaCp21wBBLhmLViaVfaghw3MWdb9X7ahtn0s5srdTxEnXSkiGwuF1CIeSEre5uolLW1A5u7huyMFIESDqO9BJ0dTY3TqtoFzZY3woYX/ee4Kb+2cIn97FQhHqsduBt0mEMXosng7MQ3lZitW27EITu06oKOfXrMVZyQReMOV2iQsJrHzuau1fj9f4dlAh0QWy/pVxELFVfXqiDHPLq/CQ6+c8nxMVNoU8XK+Qe8I3/EFm1PiYuX7MVCiV70fNJXidGVIbDrPzA29uJH0sAD4QFMJkRE4hwuCmrXXBz1nsiPgrW9aRMu94QtT/YN8/LCUJxkPbzPLA5vd7NBPWibjCmMbIHN6VP7ngtHdEgXSvape2PGg1WE70vTMVO0UOmuOjHt4nyZXKRb+ypqCH94VEXGN/7pFq7Q/MdK/dwykO+mfAq1s2ELdA0PM2vE3qegmZ8nWqPeZwSTNveFW3lpTuK4Jn2xbN3KxsgOetNjFwn/P7PehWTA51+ps8wmg9Uyhl+rz+9PJ4xTyBzzM7leqFbs4W8rJfUmF73cNB/JZI0k6KTs34WrE4o71+F0kvahYrgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFheWtFWlNSaUkxMGxOOXpveXdPWlFMN0czVVVXY3FIOFNEeEE3YjRjVTRF?=
 =?utf-8?B?SG1aY1p6cDdkOHNyVEZUM3dWdkNqQnRKeE0ycDlJbmRtYnZhUlhFNDFmZm0x?=
 =?utf-8?B?UEhhSmsxVEpMT0tDS2RoU1N4b3NRaGZxZDJEM0w3QnQ0Q0FOS0h0em9SRlpX?=
 =?utf-8?B?WVRyZlA2c2lKUEFFcVhIdTZsZWZ4UVNxdjZQOUpxZVJJaFF6QW1hQ2xsZjRH?=
 =?utf-8?B?cXFQeG5JaUxEL2xKT3IreCtkMkhmNGp2empEbWtWNllBR0RkbUp3RW93YjRD?=
 =?utf-8?B?Z1ZpditXZUZxbUh6TmpNZ0dxUVprS2FHYVhpSmRoN0xIUGwyMnhrb3FqMUhw?=
 =?utf-8?B?aEJOMWI3RTVWL0MyOFhJRm90c1l1cHFmR3B5aUNpaEExMXl5bm9zV2N2K3Nn?=
 =?utf-8?B?MUhMMGNSSElNVXR1SzFiS2VKRTdhWXNrYklueVh4Z0lJeVdMSFQyM1duUjEz?=
 =?utf-8?B?Y1BvRWhmdTBPZFpLWldtcTh0d1FsMll3MkFLZVBWUjZhbHlmZlFXM3doU25Z?=
 =?utf-8?B?dGk0VE5Ra0hoN0t1R1NFZUZYdEhhUTVZOG16UWFrYncrU3pZQVVkeE5IT2dn?=
 =?utf-8?B?YVBxeGFCNHFoZ3pUWlBYbGdGMlg3eDZ5UW0zcE1ES2FrenZ6Ky9yOXd6Y3Yv?=
 =?utf-8?B?cG5udk1YaXlLdjNjUFZiUUZxUVRPRnF3d0ZMSnQzbUFobjd6OUttRzlCbDJB?=
 =?utf-8?B?Z0hyWDlxcDBxVXM4WFY2bHRFdGRGMW83akxFU01jVnNSRUxseWdvNTV5bzVX?=
 =?utf-8?B?OHAxNXA0UDVscHB0aVZyY3pOMFJETmR0TnJ5OUoxSk5pQk0rWW1UaXFOcE9x?=
 =?utf-8?B?M0Vza21xcExySUZOcHJhV1lzRmtuYjBKM2F0Sm92ZTF0b1Z6VCtKbitXZHJU?=
 =?utf-8?B?SGdCaHRJU1JmcFkxVU5JemYwYm4wVXQyRkYyUVoxeHovdUg3aUtJWm5HY05H?=
 =?utf-8?B?RjFBOFJtdloxeEFtaVRQVE10Z3JTRjRaRVA4VEMybGlyZEsrclFSY1JRNU5t?=
 =?utf-8?B?cHZaTEF6MWd6UkwzYzcrQjlhNHZjanpmZy9ONTNkck9rQVJ1SlVWNHlycHRH?=
 =?utf-8?B?RDFEVVJkUVpmdnZSQ1ZOMnlBL1VaenR1dTJKaHFUUHZNZ3M0U0RXUjdYVVNl?=
 =?utf-8?B?Rm9YeEhwRFZZcDNtbUtqaDg2UWNsV09XaWFDSlhIeFJOaGYwUUZKS2x0RlRO?=
 =?utf-8?B?SVZ3TGd0QzhDdWErck5RSGloS3ZRY0ZCaUZ4QmVCQWYyVUpmZ1lUOTFTM2NO?=
 =?utf-8?B?REVxZ2JZWGE0WExUQVM2YXRLOTk0VWRPQjRET3lNNWVzZVFlWnVHTHpueTlz?=
 =?utf-8?B?UThWK0JCZUkyVGJMblRoWGxmMnVWWWJrWW9Va1c2cWNac3FGMldYSFVtN0R4?=
 =?utf-8?B?WklFRU9mSXJRTEFEZFZDQmtKbUI3RDVSQ3ZmWVhEbnFndkxFTzZyd0hEY1pC?=
 =?utf-8?B?Y2pLT2RxYmt5Nk9RdmJHQUFiSDArSlVtbWxYK2NNaGJvSXdBbnI4WVpvRFFS?=
 =?utf-8?B?U3cvK01VdXVGSUtOMHp0ZTRvbzBVYWgraWpXdElmWG9ueVUvczRMUGZnT0Rs?=
 =?utf-8?B?cGYwOEg1NHhjQTdhWGszSSs4NzlvaXJCcmJIbTdDTFQwaC9xc01uem91bUha?=
 =?utf-8?B?QTJXWi9Jd3gvdlJPR0ExWitHOWpuenVDdkpYV1dTVlFITlpRa2w0Ry8rZ0Vh?=
 =?utf-8?B?UVNEeGorT2FpTUtlekR4T050WXJVa1c0ZTdPemVKdTRBbGYxaS8ySmlNUW40?=
 =?utf-8?B?VU1KMnZCVlMyMzB6QUNGUDc4NEttYzRBT3NUWnZjZVhxcjQzeTczdXBqMDRq?=
 =?utf-8?B?ZVBjbHpLWFVjVm4wYXJxYnJ4bVV1bjVsOWdnaEJxVGpxK00rYjNwN21iSXho?=
 =?utf-8?B?bW83THNoZGVycXFNc0kxcWdjazhmNlVySm9TZHhiVFpLTnVSRm1RaWxONlRD?=
 =?utf-8?B?S2dCWEI5eUlHSzg5Q3ppeTBFTEU0ZXlMVXhlVjZleUxJRnhzSGRCbFVXMXVO?=
 =?utf-8?B?WWliNTA1eDNabGFHWVltNmtPU1FIWnAxS0NwUmRUamxJNlNzOFRpbHg2Mldz?=
 =?utf-8?B?UG02YUZDSFR4elZ3d2EvSTBvQldKK3BlMmlQMzZJODlVa2ZlZkY2VnU5Mk52?=
 =?utf-8?B?cFg2OG9vREd6NllCRUtOcWpHdERJWnZORVdKamsyOFRXbzNCMDdvV2JLVU1z?=
 =?utf-8?B?dThYV2tTbUxVa2RsbzJxSUJYSi82QWc3VWdrV0Jndmo4bmdQa1VjdTJFSTNk?=
 =?utf-8?B?VkV5bXdxRnRCZ00rRjdYbFFoRTVKVnVyTFB2TVgwcHRMSE9KNDlpelh6cmxo?=
 =?utf-8?B?WlZEOVc2cWNLRzZhMWxUUmlNSE9LTE10elpsUittbVp4RHArOG5IRlhNamRk?=
 =?utf-8?Q?JaKlEBMSYjUMjXys=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5279f999-f20e-4ce4-478b-08df0da542a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 12:32:35.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSupHYXGdwvS4JZbtbxw/HBazm6vb5diJcp1D7xaIGqVYTPE1Z6MJaI1it/o5TF1G4o0yO4rWTQ989DkFNxkBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7956

On 08.09.26 13:08, Florian Bezdeka wrote:
> Hi all,
> 
> Turns out the code base needs - at least - the following adjustments to
> build against Dovetail 7.2.
> 
> This series has been build tested against Dovetail 6.1 and 7.2. There
> was no CI run this time - I had to move on.
> 
> To: xenomai@lists.linux.dev
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       cobalt: Replace strncpy() with strscpy()
>       cobalt/x86: Replace {wr,rd}msrl() with {wr,rd}msrq()
> 
>  include/cobalt/kernel/ancillaries.h                        |  3 +--
>  kernel/cobalt/arch/x86/c1e.c                               |  5 +++--
>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h       |  2 ++
>  kernel/drivers/can/c_can/rtcan_c_can_platform.c            |  2 +-
>  kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c           |  2 +-
>  kernel/drivers/can/rtcan_dev.c                             |  2 +-
>  kernel/drivers/can/rtcan_flexcan.c                         |  2 +-
>  kernel/drivers/can/rtcan_module.c                          | 14 +++++++-------
>  kernel/drivers/can/rtcan_virt.c                            |  2 +-
>  kernel/drivers/can/sja1000/rtcan_adv_pci.c                 |  2 +-
>  kernel/drivers/can/sja1000/rtcan_ems_pci.c                 |  2 +-
>  kernel/drivers/can/sja1000/rtcan_esd_pci.c                 |  2 +-
>  kernel/drivers/can/sja1000/rtcan_isa.c                     |  2 +-
>  kernel/drivers/can/sja1000/rtcan_ixxat_pci.c               |  2 +-
>  kernel/drivers/can/sja1000/rtcan_mem.c                     |  2 +-
>  kernel/drivers/can/sja1000/rtcan_peak_dng.c                |  2 +-
>  kernel/drivers/can/sja1000/rtcan_peak_pci.c                |  2 +-
>  kernel/drivers/can/sja1000/rtcan_plx_pci.c                 |  2 +-
>  kernel/drivers/net/drivers/e1000e/netdev.c                 |  6 +++---
>  .../drivers/net/drivers/experimental/e1000/e1000_ethtool.c |  8 ++++----
>  kernel/drivers/net/drivers/experimental/e1000/e1000_main.c |  2 +-
>  kernel/drivers/net/drivers/igb/igb_main.c                  |  2 +-
>  kernel/drivers/net/drivers/igc/igc_main.c                  |  2 +-
>  kernel/drivers/net/stack/ipv4/route.c                      |  2 +-
>  kernel/drivers/net/stack/rtdev.c                           |  2 +-
>  25 files changed, 39 insertions(+), 37 deletions(-)
> ---
> base-commit: f40522cb9f6d971872c510028f2a44a7f19ba22f
> change-id: 20260908-wip-flo-prepare-for-7-2-a3e5125e70c6
> 
> Best regards,

Thanks, applied. Let's see if the full CI passes again.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
