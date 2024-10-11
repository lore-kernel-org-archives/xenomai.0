Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237E33F7
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630963; cv=fail; b=kDtLvFZnmt+vtnJxhRzP+hFDOexdMrc0BSgUAq2ijHpHYC7vMT46++RZ00rOHRAMJIWMmzZipfrWBBIB1puud3HWDiJXSiilDB/fCCRpMbu7H/NAS4MSKVtlAc94JGCJm3O9N+DewpI5EVwqHoyqF07svTxQaZj1InIa2kTGc5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630963; c=relaxed/simple;
	bh=b9BYSvhZuzCoGDy2sBDvcjzKqeyAti6CXJuhZkcuGy0=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=oHHQ8e4y7pOm9h5GkAU8D5awrV9fVOqmgZ48qf8bTpTnypIdTvGEBVdLnORnZXu/NpASmtth/jwClsRyZ0C3LJkrLaKtVZzEKR7TwpfGkyZyFcegBeklbw/AFC9pheJYWubiziyp86yzklxmAgWZGtqPjUDvWcrCvDoNh2NRZVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OIA6X/Ko; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OIA6X/Ko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuCDHd9kBXJ6tLAQUUIVzJoeptO6yMLo49hAMEsE5Syj0WCZnngT+BgIqLtgbrNcRdyukvCqoGjqTfJfwzC1s7PzzkBKpMP6gwqAMC+KhEva46IBEX2HTFNVq682yPufXOpw3UY2646bfWU2VOAA/z/3vFdq5BASWrPtbtucoo3eENT7TJU//W6wZs57Fz2TveE7/mjJ3dafQ7VP6zlZxp816pm1eRlkc2TJ0Wq3uVB/ceDTCISi6ULQqsdDYP+kLBKadc9aVCA69l0j6ulsIre9JOYsjBJ+ytJGu/KA0A3kqALcSovPYW+7/tLnOuC8xOmjUOUhcQyzbWL2DG0FgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttyGkaizIXxvrRome4xRyxIi55Vn7JxMBzuNEIDZGBw=;
 b=IW7UQyuOcPPeV+vEu1E25xwak/T0KGhiZDM2G7Hfqe1XIfL+630nMNoQmYwEoOnI7EGZZP2htj4nbXuvXlseoer/poF6AXnyVVoPRw3HcCOq63+CVI3HhmxJaBkFvzQkYaSPfRe+vpf2eS0UWpPseAgtoM+ngeUqJan5OzRlFNEGRRj3aPPjCTcJxebCTkf+9v/PB+2SDxi3ju0wuZIvFfOOJeVVRXh/Q4+0GF5Y09FiKTxNPJV+ub5qFPctVJ69lGxqvUAxJCZtxSOqmhA/Ooi+QBsXk9aoaScbeuosgvpozF71ABuHcH+xxH676bsYIndineHCcN8bJGMHrK9Wxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttyGkaizIXxvrRome4xRyxIi55Vn7JxMBzuNEIDZGBw=;
 b=OIA6X/KopYwW66hcbXeYsb2UYrO8K1ZCDLPyTg4/rAWphbTuKg0lPfhnlrrIy6JyQqHhLqTCyxi9aXA3tBryuncXAqfRgcG3wjxCRukOR1hK5RLb4vUFCtiJ0nkDgfv1Fm1AKHtmu8DjjUY/8CcRZH5ioLRC1n+00mDNVIvmUfjwPUnTDPP8ITEcXJyUL303AQnnGlWWzDjZYyFlj1cy4uKttg99XOCi44X01uFjPKGKGbpWGrnsBplel5NgpSMXa70EbAwGyvkDpbyhdt4G/IxEU46pK0e2UG4yMs95cNUJqllgznhJ+rVAJvnf4JWQGL3fLP82GuF29g+LO9KRXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 07:15:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:15:56 +0000
Message-ID: <bf826225-8056-47d8-8a9c-f71f368dc26c@siemens.com>
Date: Fri, 11 Oct 2024 09:15:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] RISC-V: enable IRQ-PIPELINE
To: shannmu <shanmu1901@gmail.com>, xenomai@lists.linux.dev
References: <20241011063730.310568-1-shanmu1901@gmail.com>
 <20241011063730.310568-2-shanmu1901@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241011063730.310568-2-shanmu1901@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7016013a-f601-4343-967c-08dce9c48cb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmM3b0RmTTJFTUJFamtGL0NhelNRVUg3U2RhV3RvTUNTY2hMSTlLc2lSUlRR?=
 =?utf-8?B?NDBkVVRsMW9heGRQd2RtRjh5Ylpudksza0dJSEQva3U5NGEvMzk2eDhMaFRN?=
 =?utf-8?B?dm5YYkMzbjBVZ3B4dW5aOFY5cXVnTnY3VmhRS3M4RzVleXlDZkk4TjlnWlBE?=
 =?utf-8?B?ODl5NzZrN1V4MWVCeHI1S3FkMkNpUThpTUZYUVFzSGhBTkRiOEJnZ0Z5VHEr?=
 =?utf-8?B?bmtITS9jSUN1V3BuTG05S0VjZHBiUmJlc3pEOFUycmgwaW5rem5nZ3pteTZn?=
 =?utf-8?B?ZHphY2hnMzJRTE9Yb0YvK01DS1dDNXY4a3BGRG5xT3dlSUxYUCsvL0hOT2JC?=
 =?utf-8?B?UkZiRGgyeFExM2ZFWW45aHYyR2FDd3IxUzBTblB1STBwcTlCL2lnNlhmV0J3?=
 =?utf-8?B?VncrVHZIenBEUzRhbzJzSTBmSHBXZ0M3RkJVR2R6aWlsSEtoUDQrM0tUSlFw?=
 =?utf-8?B?K2l1VFdCN1BsZUhWL2lOM1Y3d1NkdmJvVjIwak5YYmwwb1g2V05CdTNXQ3Ux?=
 =?utf-8?B?SVI5OHdTLzZqOEQ0ajRteG9XM3hEVVVKcUlFUkw2MnBxVTNEZStBVjkzUnNG?=
 =?utf-8?B?SFdpblEyU2tESU84MFJXNVJrL0czR09CZDZ5QVl0N1FjOVVRSmVmTzNpU2Zq?=
 =?utf-8?B?STVaMC9zeTMyZTVxVnFOSXdiWTNCM1ZDcjFQTjNnNDFrZ1E2QVUzcnlNSTBz?=
 =?utf-8?B?NkVHWFZSeEpQVzV6WXhLLzhPRG1ENE1GUVAxVWV1dDNveHM3WFBmYnhyZ05y?=
 =?utf-8?B?cjVmQ0s1aTFpSVFJMzBZUDRHa2xTWGQ3eWxweGs0TkN2QWhUYVIvY3VZa2RP?=
 =?utf-8?B?T0trVHVsNEcwZWxVcjJsMy9neW5vWUpGS0VpNnkzTUZVTGxlalVHWkxhY3VZ?=
 =?utf-8?B?TDV6RHlKbVZ4V21OanVoVk9LM0VkQ0ZORFd1ZFphbHNqZzF3c0xiOEpXTFZT?=
 =?utf-8?B?YVpyZGk0elE2MlAvTHlXWEg0T2pLdXhXWmlTUTlwVjRPOVArRERUNTFVMmtG?=
 =?utf-8?B?T1FxcGx3VWFmczcxSEJQdFpiK0xObmVNVTFIL3J4NVRSNFFpclRvbmFTQWNr?=
 =?utf-8?B?NnY2TGxtRENIL2R5cm8wNFpjQ2ZyMG5VU3RhRERXWWdydEJpMWVFalRGckx4?=
 =?utf-8?B?WWhLMUVqWVl4UFk3Tmp3OTVxUGoxRUJwR3FlYVFHZkhqbHBtazAvZWhvd1ZH?=
 =?utf-8?B?MzRaQytsM2JRQzQ5VXpUb2VBa0Jya2VvQjllZHRQdktoREV6anF6enJZYkZP?=
 =?utf-8?B?MENmNzFXYjdVY1ZVRStqU2pXOE01S0VOQ01RY0EwZmZWYVFCN1FCQXFGeFA3?=
 =?utf-8?B?cFBJUlhqMGtoamZQNUp3N0ZQeUdWQjR5YmN3bStacndiVDlDNnJJRUtzU1ov?=
 =?utf-8?B?WUpPaDcrM283TlFsSGpoYWlVRjBEelh1RDZCL0ozNGsrSHpmL3hVWjNaaVUv?=
 =?utf-8?B?MjhUNVE1bVpMYkhXQ01MNlBNQmFMWElQWFRlNTdyZWFIamZkb1VlaGZzS2tx?=
 =?utf-8?B?Z0RleGx1a05FcDNhTktSQ2d1WUQyTTRocW1mejM4SStVeEdFMVYvZFJmOWpG?=
 =?utf-8?B?SlBUa2tHSThZMVoybWRsQnJKSlpjanZlWHhwVStkRC85c1RBaTgrQW16TTNF?=
 =?utf-8?B?bXRXRHU4cVhKZnJUbjRveHRjaWxGQnVEV3lxUkpLRVNlaEJ5Vkx2djFtamwz?=
 =?utf-8?B?NW00WEJhb1YrS2tHNXRLOTNQZHh5VWQ0US9FNW9ISVI3MEF5T1V3djZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q054a21ZSkZrNWVKV0JnczJJcm9MVlVUSVIzOWFQYzRBNWFYSDZ2MVNOWHk0?=
 =?utf-8?B?UWFRSmVyQzcrdUdhUlN1TE40aVJFTGNkdmw3YkxhZWFZbVhUU2hLQ0J0RXQy?=
 =?utf-8?B?Q1FSd2RURjFIQmhoWDFvTnRUakU1N1N2SHZzMk50UzdVdDV2QVpqcEdPQW5M?=
 =?utf-8?B?cnhXQ0ZsVGhBNExhR2poblc2eW90QW45VWRyVHlYRjZLcGdiVHQ1WE4vT01G?=
 =?utf-8?B?SW1ETzNoTWpTR2xwRDgzWDgwYUpNWVpaa2N2aUxMdVc1bGlkWE1GYVFyVDVs?=
 =?utf-8?B?RnhkaVhCSEMzWC8rVEErbTdSaWMyanZyWTV6T3ZtZStyT2tCSVVYN2FCY01k?=
 =?utf-8?B?dkZTYmd1ZTR2QjhTNnZ4Q0h3Y3ZXbWtKMnRCMDg1MXo5WVRIaFBaSWlucGlE?=
 =?utf-8?B?angxQWgzZGppb2dxeFpQL255bUNLSjIxWktzczdrS1NGbG0wYmI1NW41ZjRM?=
 =?utf-8?B?U2V2UzlZa1czSm5iamwzQzB2NmM2azdnaVlRelViWXFKRURQQTZTZWVZVkoz?=
 =?utf-8?B?OCt6aXR6elc1K3dGMjU4V2hwbWptbVBjaUZiV01qV2c3ZitwYzZ0cUo3Rm16?=
 =?utf-8?B?dndBcFdWdmFZZ0RpQmlqa1ZJVk51c1NvaGUvRTZOMmVQM1Z2S3M5YzExZWhj?=
 =?utf-8?B?eE5JT0pMd3VzNCtJOWNaWHlmWFc5YXZhMjJOQlgyUC9nMEljUmVndXJ4c3Iz?=
 =?utf-8?B?UjdxU2drK1FpRmZIc0VFN2ZLVEtXL0RyMHdjWWJMSUNyY3ZoZU00bTUza0ln?=
 =?utf-8?B?MW5KeFdudmk5bk5hWmxESVUvaVI1SHE0VExjSGlpK29OWHhPOXlDVlJJOEhm?=
 =?utf-8?B?MCt1VmtlWU1pSXJSQUo3MnRBcVJZM1pOL0YwUFMrdytDRnViUGljVzF6QVNN?=
 =?utf-8?B?WGh5N2NwZ1QrdjE5L21JaGZOSnhsb2RBd3JjbGJibXQ4djNWTDhBTUJrbkFM?=
 =?utf-8?B?MHZDcXlwK3Y2QUthdStkQXpVNEExdUFndVMwdit2RHZubWF0K2EvcVh1aDdU?=
 =?utf-8?B?b1Q0ZzZMa01ESTVjSjZDdkRXUjNSKzI1anJnUG91bWY1VENDc0ladVhFK0hE?=
 =?utf-8?B?Qm1WN3VUbEFmWTBMaFpEVGZzK2tyL1VxMStzNTVkeUpNWHJCMnpZVTAwcm53?=
 =?utf-8?B?TVRFMDRGRUVMTXhZUGlPQzVGRGZBcDI0c1FoVERtWDhZU1lUbHRLV3hKYk9l?=
 =?utf-8?B?U0k0T1NMU01NcWRoMWxaK3JQbVFLRG42ajN4Rm9JUVdiVUhuZmd0TXBUV09V?=
 =?utf-8?B?SmtCMjBDQUtwcTc3c3JmV3FuQklBT2lZSEh2VU8vT2VOMmdzWXAvOWZzS3NF?=
 =?utf-8?B?Zi9Hajd2SGd2dmpUTEZCM3krUzYzNndRL09pU1NRWEJaT2dvK3VMTi8vZTgy?=
 =?utf-8?B?bnZ0VGU4cjJQZ1lWOEEybGpLNlN0L3c2UjRQQUJPLzlFMThUR00zNWxOc2pJ?=
 =?utf-8?B?L3d0bTZhWmxKTWRVZmFLeWlkWFpPZ2h2OWN4MllVSmdZOTA0WTk2L2xuY1Av?=
 =?utf-8?B?QnAvMitTS2FSODVKQUlxWUMvS0tnQklhTXZ5ckl5UlRqR3lwQnBrVTd1UGUy?=
 =?utf-8?B?amV0NUs4a3ptMDhqNVh1MWxKQjZaZTZVWTRqNGx0WGtaT2s0cXZJK0Y0bVps?=
 =?utf-8?B?N3hPQk9NMWYxRmNlQi9oaTBIb2QzeTVlbFlkaERzaHZnSXFDc0RTRGM0ZzJ5?=
 =?utf-8?B?ZmtJS3o0TGRjdTc5OHJ3MjIrSFZEeXI2Zm1Fd2dNV0I5VndHZ0cwWjA2eVJE?=
 =?utf-8?B?ZEQ0Z1gyT1FJaWdEYnFHK0JuSVMwVTJ2RXRVTUw3c2pDQjJHazgxT21LOExl?=
 =?utf-8?B?M2V5SDlQRXdUNU9aTm9BMm95cUpFRGRYWHNZY0tJa09pMW1IamQxMy94M0Qw?=
 =?utf-8?B?aFliM2RnMEFKcHdrWlpWL1FsSnk5blJkSTFHeWM3THdxL2lNR2pCN1l5Tmw2?=
 =?utf-8?B?Q0RWQXU4WjF1SjNOQm1KcGwzNGdlU0hxbDJtc3Q1WTJEMlZadzJlZ2ZTa2xI?=
 =?utf-8?B?NTlFL1VxNW9xT1QxZFZMTStUU0tndGxvYU1Oa3J4V1R0SE5rdlhZaGcrMEpH?=
 =?utf-8?B?Q0loaFQ3dGwrQ3ZSejRxZ2dUd2xaV093SGlvdE0weCtFazBGSTdOMkk1SURj?=
 =?utf-8?Q?bWRjHx39X+6ABKA11nwH3S3Px?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7016013a-f601-4343-967c-08dce9c48cb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:15:56.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tCur3+FsSwH2yjgw2Af0LTgRr5mVk9JTvQeqQds8Lpn4C/4cMM6EJ2gkwyrfGQKA7eQ5aZhbn3ZSxQtq3T56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5618

On 11.10.24 08:37, shannmu wrote:
> This adds virtual interrupt functions `arch_xxx`,
> irq-pipelined top-level interrupt handler `handle_riscv_irq`
> and `handle_arch_irq_pipelined`,
> real interrupt-flags functions `native_xxx`,
> `mark_trap_entry` and `mark_trap_exit` in trap functions,
> multiplexed ipi_message_type `IPI_RESCHEDULE` for in-band ipi.
> 
> Signed-off-by: shannmu <shanmu1901@gmail.com>
> ---
>  arch/riscv/Kconfig                    |   5 +
>  arch/riscv/include/asm/dovetail.h     |  58 +++++++
>  arch/riscv/include/asm/irq_pipeline.h | 173 +++++++++++++++++++++
>  arch/riscv/include/asm/irqflags.h     |  26 ++--
>  arch/riscv/include/asm/mmu_context.h  |  21 ++-
>  arch/riscv/include/asm/syscall.h      |   6 +
>  arch/riscv/kernel/Makefile            |   1 +
>  arch/riscv/kernel/irq.c               |  72 ++++++---
>  arch/riscv/kernel/irq_pipeline.c      |  46 ++++++
>  arch/riscv/kernel/smp.c               | 135 ++++++++++++----
>  arch/riscv/kernel/smpboot.c           |   2 +-
>  arch/riscv/kernel/traps.c             | 212 +++++++++++++++-----------
>  arch/riscv/mm/fault.c                 |  46 +++---
>  13 files changed, 633 insertions(+), 170 deletions(-)
>  create mode 100644 arch/riscv/include/asm/dovetail.h
>  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>  create mode 100644 arch/riscv/kernel/irq_pipeline.c
> 

Thanks for sharing your work! Could you explain how these bits compare
to what Tobias sent earlier [1]? Is it possible to combine your work
with that to ensure nothing relevant is missed?

Jan

[1]
https://lore.kernel.org/xenomai/20241004190633.1814057-1-tobias.schaffner@siemens.com/

-- 
Siemens AG, Technology
Linux Expert Center
