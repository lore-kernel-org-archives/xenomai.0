Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300A41DE04
	for <xenomai@lists.linux.dev>; Tue, 11 Aug 2026 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443167; cv=fail; b=koS+YOhu4QjM4DOePr7hx4Q9M9mz109VnbpmnFd8ZGiPjRtOnc6PgDck5JURNlpQjf0bQM7aCJ37EUFc3/Pk0APNr3n3eiBTx8P33aMd58O7OEPKAywIRHRCTHjTVCMV7qNrpc4kxJ1bDtJitxTMRD8KqTCWut4iWUGZPhRnkEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443167; c=relaxed/simple;
	bh=KWIjtrTdmxjRLFxRjr6h8ysZOXxUY7kNFNfRtv67f70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SGYWHXFRuYzPg69c5yeHO2Y8vp4C1T72ckDBqLaMMOjNJ6dLFtTenDLaq/Xr9yE7V0BzZOosGRpkRqeE2dU3j/ERpocgDtlLZER7joBSeqGQHHPx8k2s40SjfJeWVci4jMHyHOrbImP/rrD2Xo/1Pyc4gVYgISqq6V83lipoEME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UuRCb3Am; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UuRCb3Am"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXXOCTjfEfn/OZjO3L/YCMYj5MeD+DVv0oVL0J/LLRN1jLLiTiJrwShRZcHvVzKk6L7juHCnV+EBKnjrvtjlI83uh9eRTpyhVbVORkcEr+ADZ5U+TOI7grOT/12PMHoPIxKLZTSXhSFPLhaUk6qogG1ary2WwNs7gITiETZw0EJNsv6T+22ResdocFaLmtFYhU9D7OMSWUTeR/wi2qnnzQLTBQyc/na+0JT9INf+ENhfQIuaY0kfp5IxcxV5PdoyWHPZGTE/hJ0n8PeeeeCMUi4QDBsvE1XqdWc2uFw7+5IM041eH6u/5HzDCOiFZrS3IebvdUwAk6jWfg5WvWjwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj6ZNM6Py8pGWpXM5SIBLZB6nsSpcHl+3Z823Vud5Rg=;
 b=nnbFdYys67qCG1258eGa5ZNgey2fAm4jIvYCm1flD6q1L+2bbzb94whWypjKuMJzaF76VQm3iQRQ86+nrnkPNdu6deYs7fw7kso8Jc2U2UhfFTdSpJ/j+fhAmlVWMDL84DTByQL4bMP4TIU8yfKYGKLYZNcygLWAfZm+JUl/UmK/0tz5ZKbwBeZEq+l/JzzltRFXlDe73/UhRUV4D2nuA17BumlNWqIEYi2GP1OtKWEu5eJiUFwRZmBs6SZPM6TDQ3RktQeCuj2VZ5siCzgqIBx+hx5OugwS9glTKuiHO8luXftzgXUYaCAxGV5ByPhyBR1eQMSUX2KY1StCGMabgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj6ZNM6Py8pGWpXM5SIBLZB6nsSpcHl+3Z823Vud5Rg=;
 b=UuRCb3Ami5H8BgQ+9mZ6s37pBudmZDcknu3QbZ+Wmo2htFOqB5EfRbmt5FHsL2OnAP5CTtWC8BTRXDMjyWy7Dld+Pt3/7Rxgbez5w4+GU0DLFTF4dD46Pc+ikrvfF4BFceSl9U7Syy229u4zwG8pF/Mne1vknhuSXLZv1K+DS0To6y6XDyqY4f7QBOGNHJxR0Ak14dkdorKZ/2jV9jzAwxPfKRQawFf/H/cUToepEugIAGzL8BuuDQ2lHJNykK+UTvZclLcm/TWpiseX8WaJLQNdy128H11jYRtPq066252mYvFrNolDaSAbPrIavS2XiNL9ljo73WMb6bngs32swA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 10:12:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:12:38 +0000
Message-ID: <911efba1-3f55-4486-8b57-4bcd4b17c2b5@siemens.com>
Date: Tue, 11 Aug 2026 12:12:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@lists.linux.dev>,
 =?UTF-8?B?5a6L5YGl546u?= <songjianwei@sinsegye.com.cn>,
 =?UTF-8?B?5p2O5bCP5a6B?= <lixiaoning@sinsegye.com.cn>,
 =?UTF-8?B?6ams5ZCb?= <majun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn>
 <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.c699737c.9d30.43b7.9ed8.a2a9042fb8f3@feishu.cn>
 <67ed5d8f-0a4c-432b-ab59-a4cbcbe91a34@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.feee15f9.216e.4b39.b573.9ad554d5eb50@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.30d266af.c20f.4e5e.b7f2.5899ed8cff1b@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.016f3d46.7d4b.4b85.be4a.b6c524f3b5d7@feishu.cn>
 <b1da1fc4a8a4e44d3b398ef4d514bdb738f0598d.camel@siemens.com>
 <e6caf0a7-8a76-48dd-a523-3c6fcf8fbf3b@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.b20ddc61.4e2f.4a01.970c.b8487512fe9f@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.b20ddc61.4e2f.4a01.970c.b8487512fe9f@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3603:EE_
X-MS-Office365-Filtering-Correlation-Id: 554933c6-8331-49f5-9d29-08def79111eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	SjVkBc9/4VoiW7fyfkrNRpqPd0Ubc4Upoc/3GV2Q2mBUNPPSPilSvlomi+urX0vQPfugEBpoO6Nd9pU+O0kz9iLv7ou0ps9G8UkA0DKdxe+7kSb4LMVVWpBWPPgKKzil4d5+69YYEosoy/JO0z10nEa7CkNqUcBFc8LI56zhLuvgIV3/6aKRtPTN7/bqLEsW8fxmxoXdhYyqhNOXlENMde9sOkA8r2sTFNofN6HiNU32m3ExyOF68zuc7lZ3CnyzcOHqzoFACZ7SDU3RV5wIEbjUTnlu7GT22tapf9HhJ7g8rrEC5d2AUY9DiSY6UX9k3rlzyUAH9itpNczrh7O9r1/OiqJE3W172m4cZj051sCQ2tYo4bZ2YmK9gtxf25AMhCjk0K0P1iGzDTQdJFJUvittTSyVnIqZ4tB+REFVr0P0UIHC2bhlpktmxxbPe4ssi9nrQ4cz1Awjp6iseWSDiVe9M+0NuOmB7hHJkDIHNC8Xr7xKJrScBzEKsxSgMiEKGe+AD/agrrwtt+usmrc+HEKUENOYQx2+Fk8V6CpWJf0nTyFjHS8he7nLCjSXtw3QPY5SCd7cjimHiAtEtw+49KOLXaPX8uKvlrwZWmLOK8xsBRG6yoZ1cmccl4eOmZTK2MOmIoHrTQBDHzveIDT0q72Zz39bDG6lPv2vJYRuZLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDZYbWRpM3p0NzJNeE5jSktJZFV2eVR3d2QzQVdnaVladmxFQWp0RGdHSlc5?=
 =?utf-8?B?OFJjc2IwYXV6UzNmRVpoVExUU2pGMEtCZEtkL3hnOFc2QU9ZeXV2am9qdWVm?=
 =?utf-8?B?dU5rR2trMDFXSVpoK2s1S0h3MkVRU3Racy9tYlU3dHZZa24wNDlCblF1VzN0?=
 =?utf-8?B?TkJ0NGc5L2VVYzlIc0tPRVQvcElpVkRMWDNOcTBrbWpXbGk2TkpUS2d4R25r?=
 =?utf-8?B?dkpxd1EyNU5FbTV5RzdBNzVhMU1WY3RBZTVPZ0NNcUhNVDhMbjU2T2RxeG5Q?=
 =?utf-8?B?Ym1rN3lWU0prMDBORy93Z0ZHVUd3dDc1RVRMbTBIUER4WmtzRk8vTEtWcE5T?=
 =?utf-8?B?YjNMUGptL2Q0L080SFpsWnpxVXVFSlhUWW9uNXkxaXF5UVFSWVNHaCtHQS8x?=
 =?utf-8?B?N3JIc1BxYWR6VWJNeU51aFllSjlnVHdiWUZYRjZ0RW1EejNIRTRmbk0rMmdW?=
 =?utf-8?B?Qm5Yc0pqcSsyZytCbWM2ek5MdXZVTTh0Snp4QmlaMWhPNFZmbXo4QWRIc2Z1?=
 =?utf-8?B?LzhsNmY4ekxjR3AwRnRweDRiS0l6eWg3aXR4VGVMZ093aWE1aEQ0RjdRZmg0?=
 =?utf-8?B?SFZPYkhyMDBTc01vN1hpdVpiRW9wdTBsZENoVXd4bzVMb0U0bnpzakpRdWZt?=
 =?utf-8?B?YTJPN1pvUUoyNnJtL29XazdvUXM5azVnZmhZMTkxWmxCNzFiRHB0RDFwZmZQ?=
 =?utf-8?B?VDJiQWR0SytHVk9DZEZ5NTNPL0kyMEVuL3p3dTZVY2xaQVlOclIzd25BWTBi?=
 =?utf-8?B?cFhmZUxiNmtVR2Fyc2Y5My92MG04QThaTlVONkNxSk8rRlBDeUpWcTFCL05K?=
 =?utf-8?B?VmJsTnp6T0VaQXJQRlpVb3VUQUhHZVRXWUQwRUI2MUllbjU2L0RCYnY2RDFj?=
 =?utf-8?B?Z0Q0VXpYY2hqZ1BnZWxsNjVJcHczb2RZaDNUYVJKODQ4Sk42WU5rdzlyRkJY?=
 =?utf-8?B?NjgyRFBnYi80UWRkbkpROVVQR1VMUWllRkNVSFp0U1ZLOXJuMmFhN0l1bk4y?=
 =?utf-8?B?bDd1Mm44WVRtdHhxS2dvWmEySVRqbzBCU09FWWV1Unc4ZWdLcC9ZUm1za0lu?=
 =?utf-8?B?RHRqa1ZaN0xqMDdGeGJKQlBEKzlRSDM2RVJ0bzdVVjFkTC9Fa3RhcmRwSm16?=
 =?utf-8?B?SU1JeTArMWRSMFNQOVR6dEhPWUZ4WVJZblZIL0g3UFpjbmtYa1lkMGx3WGRu?=
 =?utf-8?B?TFlwcnNmODZhR1ljVlNtRHpnV1htWlh2eE9IZHdGZytQaGFVdktubVJWM2Vy?=
 =?utf-8?B?SWlmWGZodTlpRytnYmxYYVp1QXozaGF2L3pjdWdWUFZKS0E4R2wwQmlJVUM3?=
 =?utf-8?B?cFpGVWUzYjUzVVo5enhmOTFldmxOT092NVJOelUvRHR0WEJNNXplTThZOHM3?=
 =?utf-8?B?eVZHUlp3WnZJMnZsNk0xNHZxS0NVZThqYWl4bTRJRkZlLzNaaHVJM0VqVFdO?=
 =?utf-8?B?Z21naHdaaHJjUHBEeFA4SC9STm5CMjdYdjNYR25jMldOTEFKallzSElLWXdr?=
 =?utf-8?B?NnA0NExhUEdnQzRuRU1Vb3lGWUtGc0FaRWJhUWpZMWE4RmFEbm1yR1J3Vm4r?=
 =?utf-8?B?Y1ZhZ3dsaFRsbTlNbTI5bkU2OEozSEtKOHYvUHNlN0lxTXlYTUFuVFhNMjVU?=
 =?utf-8?B?RUxmMTlRdFI0L21ZTWFRV2xoaExDbGVpbXRsV2JVS0d4MFI4d3JiMysrK3V5?=
 =?utf-8?B?U0ZUUCtWS3Y2SVpDL3YxU1VqUHVRYjdvbWlGcHYyaXpVSGFaczF4UE9PemYv?=
 =?utf-8?B?dEhxU2FxT3hacU9lcEMxbXFNRGp0Uy9NeXdpSUdYc1RHVGFsZThWeGpqNFNW?=
 =?utf-8?B?bTA5M0x1bXJBaVkzUDh2ZFBqR2s4WGR0NkdwQ3ByT1huRFpQcXFYRUt3S244?=
 =?utf-8?B?bmczM0RRNE16STRjaTNiNk01WlY1MjFoc2c5NnpFdk5HcUZJd0ttUzVRYTlw?=
 =?utf-8?B?bjZ4SGszNzZ4cVg1N2tlYW1lM2l5RER4VDlaS3VpOWNxditnVmtXMW1YRU40?=
 =?utf-8?B?WUk0R01mR3hSeUtlc28yTTN2bEM2Q1ZOSXNHVXZtZVgyUktTYkNmY0JGL3cw?=
 =?utf-8?B?WFl6d2lINU5yWFhwY1IyNVAwMXpDYkJsZ09ROXhsYWMzVGdUV044UFphUktt?=
 =?utf-8?B?TjE1NkZXbFhEd2dLNGtDMWgvanRVSlVaR2c5RDFkbFFHenZjN2VwTG0xZ2sy?=
 =?utf-8?B?MDg3Zm9RNnh2bTdCd2diaHYwVmpHSE9kZ1ZXU2V6cEcyL0QyYVdhTU84bGVZ?=
 =?utf-8?B?d2x4dXlsb1UwRnMwb0xzc1RRdVJKQ3NJUW5NS1pJbEZFdFRYYkpqZG1SSk5S?=
 =?utf-8?B?Wkl1Z1ZxWUluTWM1UTFsdUowWHVwYTJyNVg2WXhtd2dQRklGTiszYWc5SFlG?=
 =?utf-8?Q?fHBU/sRmkfP+Z9vI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554933c6-8331-49f5-9d29-08def79111eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:12:38.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSuPqA7R7GUjlsO7wHhcNUA1+YGyQDRzCjWxeNFK8hj+dcDiP1xNJ0fNPB2kMo5XHIPDrrtEOppYFwK7DFokcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3603

On 11.08.26 11:14, 刘杨 wrote:
> Hi,
> Thanks for the feedback.
> We agree an oob thermal handler is unlikely. The board can still run hot (we have seen package temperatures around 100°C and many TRM interrupts). We have not changed the cooling yet; we will also address this on the hardware side later.
> We only adjusted the software thermal handling path for now. With that change, the system has been under test for over 72 hours without any freeze or RCU stall.
> Do you think a software fix for the thermal handling path is still
> necessary, or is solving the overheating on the hardware side enough?
> 

If a thermal interrupt is coming, if "normal" or not, we should handle
it correctly, rather than causing even more problems this way. So, yes,
we need your patch.

Jan

> Best regards,
> liuyang
> 
>> From: "Jan Kiszka"<jan.kiszka@siemens.com>
>> Date:  Tue, Aug 11, 2026, 15:36
>> Subject:  Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel Ultra 5 125H
>> To: "Florian Bezdeka"<florian.bezdeka@siemens.com>, "刘杨"<liuyang@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
>> Cc: "xenomai"<xenomai@lists.linux.dev>, "宋健玮"<songjianwei@sinsegye.com.cn>, "李小宁"<lixiaoning@sinsegye.com.cn>, "马君"<majun@sinsegye.com.cn>
>> On 11.08.26 09:19, Florian Bezdeka wrote:
>>> On Tue, 2026-08-11 at 10:17 +0800, 刘杨 wrote:
>>>> Hi,
>>>> We captured the following on the serial console during an RCU stall. CPU 4 was interrupted in the idle/nohz path and spun on the timer lock inside the thermal handler:
>>>>
>>>> [ 2205.999617] Sending NMI from CPU 8 to CPUs 4:
>>>> [ 2205.999619] NMI backtrace for cpu 4
>>>> [ 2205.999620] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G     U  W  OE      6.12.90-13-rkernel-cip24-x64-industry #metaOS
>>>> [ 2205.999621] Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>> [ 2205.999622] Hardware name: Sinsegye SP8000-C340/SP8000-C340, BIOS SP80000020260708B 07/08/2026
>>>> [ 2205.999622] IRQ stage: Linux
>>>> [ 2205.999623] RIP: 0010:native_queued_spin_lock_slowpath+0x78/0x380
>>>> [ 2205.999625] Code: 2c 24 08 0f 92 c2 41 8b 04 24 0f b6 d2 c1 e2 08 30 e4 09 d0 a9 00 01 ff ff 75 5c 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3 90 <41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c
>>>> [ 2205.999626] RSP: 0018:ffffb065802dce38 EFLAGS: 00000002
>>>> [ 2205.999627] RAX: 0000000000000001 RBX: ffff9334dfaaa428 RCX: 0000000000000000
>>>> [ 2205.999627] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9334dfa53580
>>>> [ 2205.999628] RBP: ffffb065802dce58 R08: 0000000000000001 R09: 0000000000000000
>>>> [ 2205.999629] R10: 0000000000000000 R11: ffffb065802dcff8 R12: ffff9334dfa53580
>>>> [ 2205.999629] R13: 0000000000000000 R14: 0000000029f00004 R15: ffff9334dfa53580
>>>> [ 2205.999630] FS:  0000000000000000(0000) GS:ffff9334dfa00000(0000) knlGS:0000000000000000
>>>> [ 2205.999631] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [ 2205.999631] CR2: 00007f56540d1b68 CR3: 00000001637a8005 CR4: 0000000000772ef0
>>>> [ 2205.999632] PKRU: 55555554
>>>> [ 2205.999633] Call Trace:
>>>> [ 2205.999633]  <IRQ>
>>>> [ 2205.999634]  do_raw_spin_lock+0xbe/0xd0
>>>> [ 2205.999636]  _raw_spin_lock_irqsave+0x59/0x70
>>>> [ 2205.999638]  ? lock_timer_base+0x7b/0xa0
>>>> [ 2205.999641]  lock_timer_base+0x7b/0xa0
>>>> [ 2205.999643]  add_timer_on+0x70/0x140
>>>> [ 2205.999646]  __queue_delayed_work+0xac/0x110
>>>> [ 2205.999648]  queue_delayed_work_on+0x94/0xb0
>>>> [ 2205.999650]  therm_throt_process+0x164/0x180
>>>> [ 2205.999653]  intel_thermal_interrupt+0x12b/0x350
>>>> [ 2205.999655]  __sysvec_thermal+0x46/0x180
>>>> [ 2205.999658]  sysvec_thermal+0x9f/0xc0
>>>> [ 2205.999660]  </IRQ>
>>>> [ 2205.999660]  <TASK>
>>>> [ 2205.999661]  asm_sysvec_thermal+0x1f/0x30
>>>> [ 2205.999663] RIP: 0010:_raw_spin_unlock+0x0/0x50
>>>> [ 2205.999665] Code: 01 00 00 00 31 c9 ba 01 00 00 00 31 f6 41 bc 01 00 00 00 e8 32 04 2c ff 58 48 8d 65 f0 44 89 e0 5b 41 5c 5d c3 0f 1f 44 00 00 <f3> 0f 1e fa 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc 48 83 c7 18
>>>> [ 2205.999666] RSP: 0018:ffffb065801c3e00 EFLAGS: 00000246
>>>> [ 2205.999666] RAX: 0000000000000001 RBX: 0000000100161a47 RCX: 0000000000000001
>>>> [ 2205.999667] RDX: 0000000000000004 RSI: ffffffff90217c1e RDI: ffff9334dfa54840
>>>> [ 2205.999668] RBP: ffffb065801c3e58 R08: 0000000000000001 R09: 0000000000000000
>>>> [ 2205.999668] R10: 0000000000000001 R11: 0000000000000c2c R12: ffff9334dfa53580
>>>> [ 2205.999669] R13: ffff9334dfa54840 R14: 00000197236c7580 R15: ffffb065801c3e7f
>>>> [ 2205.999672]  ? __get_next_timer_interrupt+0x132/0x380
>>>> [ 2205.999676]  timer_base_try_to_set_idle+0x17/0x30
>>>> [ 2205.999678]  tick_nohz_stop_tick+0x70/0x370
>>>> [ 2205.999681]  tick_nohz_idle_stop_tick+0x72/0xd0
>>>> [ 2205.999683]  do_idle+0xb8/0x150
>>>> [ 2205.999685]  cpu_startup_entry+0x30/0x40
>>>> [ 2205.999688]  start_secondary+0x10e/0x130
>>>> [ 2205.999690]  common_startup_64+0x13e/0x141
>>>> [ 2205.999694]  </TASK>
>>>>
>>>> We addressed this with a local kernel patch, and the issue no longer reproduces on our side after applying it.
>>>> Could you please review whether this change is correct and acceptable upstream?
>>>>
>>>> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>>>> index 1b9264e5b..bbd20cfe2 100644
>>>> --- a/arch/x86/include/asm/idtentry.h
>>>> +++ b/arch/x86/include/asm/idtentry.h
>>>> @@ -803,7 +803,7 @@ DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,              sysvec_deferred_error);
>>>>  # endif
>>>>
>>>>  # ifdef CONFIG_X86_THERMAL_VECTOR
>>>> -DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,           sysvec_thermal);
>>>> +DECLARE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,         sysvec_thermal);
>>>>  # else
>>>>  # define fred_sysvec_thermal                           NULL
>>>>  # endif
>>>> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
>>>> index aecdb2d02..c432c22ed 100644
>>>> --- a/arch/x86/kernel/irq.c
>>>> +++ b/arch/x86/kernel/irq.c
>>>> @@ -605,7 +605,8 @@ static void smp_thermal_vector(void)
>>>>                        smp_processor_id());
>>>>  }
>>>>
>>>> -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
>>>> +DEFINE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,
>>>> +                                 sysvec_thermal)
>>>>  {
>>>>         trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
>>>>         inc_irq_stat(irq_thermal_count);
>>>> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
>>>> index 8c9d587bf..c7ade9c2c 100644
>>>> --- a/arch/x86/kernel/irq_pipeline.c
>>>> +++ b/arch/x86/kernel/irq_pipeline.c
>>>> @@ -164,6 +164,11 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
>>>>                 run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
>>>>                                         regs);
>>>>                 break;
>>>> +#ifdef CONFIG_X86_THERMAL_VECTOR
>>>> +       case THERMAL_APIC_VECTOR:
>>>> +               run_sysvec_on_irqstack_cond(__sysvec_thermal, regs);
>>>> +               break;
>>>> +#endif
>>>>         default:
>>>>                 printk_once(KERN_ERR "irq_pipeline: unexpected event"
>>>>                         " on vector #%.2x (irq=%u)", vector, irq);
>>>>
>>>  
>>> Yes, the THERMAL_APIC_VECTOR implementation has a pipelining problem.
>>>  
>>> Main question: Should the event handling take place in-band (Linux) or
>>> out-of-band (cobalt/evl)?
>>>  
>>> You selected the first option, which looks sane to me. You now delay the
>>> handling to the in-band stage.
>>  
>> It's rather unlikely that there will be any oob handler for the thermal
>> thing.
>>  
>> At the same time, the occurrence of a thermal event is very likely
>> already a problem of its own (which does not mean we should not fix its
>> handling). Is your system overheated? Will it possibly die soon when you
>> continue like that? At least, it may go into thermal throttling, and
>> that will not make your RT workload happier.
>>  
>> Jan
>>  
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>>  


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
