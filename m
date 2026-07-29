Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25976436BEE
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311666; cv=fail; b=dKQO9vkhSFA0ejOP1HRPZsAR/2Z2C4xFTUS/iem1kpAIFpz9fsI7RPr6CsQ0Nz2R9fNM8m9OHPSkpV9COmR/B6Ej2cVAUslmgrA1ot4b666rFvrR84/XPg4Nub855evNo+LMO5mL/OpCiKV82G0JF5JgeMylmnm/yjAXoRtn4V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311666; c=relaxed/simple;
	bh=4b8ffRJPLOTEsVfrfFguL/v5Ek+/H90TGVIW+vHk9MQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hyD1v8J/577jpxYQLcbuFqF1+j8rFPoHWKMe1G2EJywnTe+8WjrcmIydbtp9P+kJuc9WJah++vlJCE9fL6tEHpvByknQulHFjPCDBF2VKmqeU9Ox5/dV9hAfVJDxfdGmxGgbuiKL/7N1e8p+Nuboa/wEcKEj8NbgZ+01ruZBFTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jeXxrPoR; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jeXxrPoR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9W7tfaXCKmSj8ErqngWG7msFLUAhchf+qvNIwi6s5AT3M9cwl7niQtEcZ2ltU7PQY5NCIb75NUgY0yvIAK5y9bpW+fgUcplKOdUAtE9FVC48DcKDTOxKm/hTmCbQTvf+4iCBFTIvYP0RPJ9YjBef+FK8l0ggDb6zqqagq7z4Go9W6kLqV40DapMGIwKOur0X1AP0tFKr/ke5ZVBDSAMdVPXpJOP0iEWH7Fgw9+6ma6XxGUcWiCU5vh3QcdydIOx+r0wSB8gXlH4NkUCygWbYUgqrd5pSBrW1jSO+VSWycC5WrZlLJ26cua4OCQyQOjMVPMnE2+dRa/9zzrgyXKksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdlJvt6k8DDDL7QH17oyrkVKdoajmhObQ2xs+vahRrY=;
 b=Hx3558oSAP6Tbjd/TDTtwYDF7ZAn/SA2v+j079Y7DepD9YtlBIiqDcLjxH6z/cHuzbhfOL4xQVIrfL8H9izM4rZ0q+DAQ0V+88i9nO/ZTbASC6Xs0fQOQCpj9873No564gEecJlIc28YWsjS2FODE8XdqQxAzoq7f4B9Kc4Ea94tzUtI6+Lr1SVHZyor6OPvUVG+VKawpPzkJE1J6H/s828MemRMRVSSvYIoHDA66SHN4TdnBcDh7kk5wdRPS54hHtD4aDTK/j0FDDaymbsh0VQCIKTINZdXPtRWmtvuH31p3xF5lS25LX71arQXh5wpWzol8WWJW1EEm0yRt96Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdlJvt6k8DDDL7QH17oyrkVKdoajmhObQ2xs+vahRrY=;
 b=jeXxrPoR7f5guO4/yJiklpgtSpD0ynH6sXkJwdTsLeNXZna7BNumPUH71pARJ+hLihTHpb/2CTlCbuYH6f+sMkSxfuCZQVGEMKXlbQ+9sTkcCIy7PsY6PjGvXsxBXmeI3Xj98e0MD3sE/ZCmYcvBNW2Ij3R0iwUArRRmNL+soSC/OMjJG5Nt8eBl6B+cz5M/A0okZqS8pB71xuM42QVuj4J5Jo1KMsdXwGA94fGpHwe/2Q7JZXMzwHdOuST03vW9wHtfNlOG4OrANKvsryjM8s0VDdZ3ZDWaIVjri2MwEXHSu/v/xHuH9Z8Ga2ksKGYNJydZ/F6NZyXhy0mpesd0jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 07:54:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:54:17 +0000
Message-ID: <5905a920-e911-48bd-9959-d8702b512272@siemens.com>
Date: Wed, 29 Jul 2026 09:54:16 +0200
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
 <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: d05d767b-33dd-43c0-c959-08deed469723
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|5023799004|4143699003|22082099003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QqZUncjA4oHzvL6Tdomh4Ypi6RhdsErGutR/yPaqHmFpF2p73qUK1a09oamSrd1gfvBQYvQa2iipJUJAZ9k4KTp607HMKhIkuJ1X6JUK8KPL03bHmP/oQdyWrbTLCoHg/r+/jbpTKlRGoAo3MO8zC95H3RKqWgPVHtT7MJD7CRvZZHkbTmYBoDHUuZDd/lNckAAydWZKurcA22s1CsOIZhR1vC1e1TNfarj4MujMGuNWWJFK1oJt4Nbgaalr4rVxllSac3k4GTWxVCPK4lnKLH5lWDwI/cGu+co+LCg2DpuRURxsHFignUXV0EAzsg1Ks2aLxPz8D/vLo3/sNjbNoVDmp/ufw9Y14XZ2rM1WZgOuhT+JsfItsHaD0aLrTujaQR3zHi9zl5KDcDzmsTA8n+1+bsyHGocXr470C6EGqTgFhTBbhfcrZtv4F05zjulkHd1HG+20mjHUi8Ek04j0Nm8+pHySvHYNseWoJj/WvCINXeSdZcTap/50WcFv+HPWSIqrfrL/VkgX2tuUHwCqxERM0Ob41k++RI07nz3P+9S42kacO45dU0UXYNYUnh7CM1lUW/SUwgpX6M1hSa8X5vsGuO8drISQHkglbFLzSQnQoydnb1X5mMixz9fH8LZQpxlShKHIuDLF51x8pPB5jn1orAv+XeVvS8RIHI8vwaM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(22082099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFU5R0F1SUkwc2E5NEFJcDUrS3dKTi9JVHZxb1k4Tk9JaDdUcG9hdEYvUUV1?=
 =?utf-8?B?MERYcjMrOHRrZ1o5cSttUS9MdnBnRDBxeFRXa25uMHNUU3lEakFnb0hoQmhX?=
 =?utf-8?B?WVNweUdUR3d6Z09hdStsR1VldStrY3VXMnNUUnhza1VlYmZZbEJKbEdPMVRi?=
 =?utf-8?B?clQxTkozOTh6SmpZMGpFcU1DYXdSMTFmYUxaRmNaV1dUK1pCZzhyVjZ4TGRw?=
 =?utf-8?B?VHRVQlFZazZTWmFLNHVaS2RwVVdLa2NOalFBMC9DYTNZMWpkQVpCZ1B3ZG5N?=
 =?utf-8?B?VW1OSExSRHQrOTUzZnFSVjAzUytRZTExc0JvcUpSS1hJR3lYbEpPTU1ETHhW?=
 =?utf-8?B?Mjh2bktyVFhpSHdhMjNzbDJDN0cwblNkejdueU1BN1daNU5VSHhaeklaNlpB?=
 =?utf-8?B?NzZCSlhxSnVEeUJNQjJNNmVZSTgvUDJwMzhVZzV1Vm9nV0hKTzNnRTE3ZmRa?=
 =?utf-8?B?VG9VVzJZQWlxVm9IZkF2YjZvc0t4Q2luQ0FCT1p0bnMrQnFLNGkrOGp0SnRt?=
 =?utf-8?B?WStkTlJxZEFvSGJyU2t3WGRYYUUrNW5rMmZ4K0Npa0lHeGlkckhTSEcwMVkz?=
 =?utf-8?B?dzVWaHhpUkp0YkV1MHhYeU9kOUZnMDJYYlZiaGZQU2phRXVySmZXd3R2OUFN?=
 =?utf-8?B?TEhpUVQybU5mVHBIU0NXdWY1WGYxWFdVQWEvZGxIL1I0MnMyU0ZQUXdLdkpZ?=
 =?utf-8?B?VkNUeWNKQ2xMM1N2cjVDVHc0b1VlblYzYkpXeWxQbHZmYTJCb3p6U2s1Rkp5?=
 =?utf-8?B?aHB5dlN1Y0lCSjlMN3RBaWVORTRZcHlPUWlHejV4cjlCelBJQzdZNUVXMWJ0?=
 =?utf-8?B?VzFiU21CNFlQTzdRV2hpZXFBaXhwN25MTGdIL2Y3TTJ5LzF5aVB0YUwyMFl0?=
 =?utf-8?B?MWJQWTBpYTdkME56RGE4RmRoZDlTb08zaFBVdktkRG5pYmZPaElqaTFiTGp4?=
 =?utf-8?B?dFF4N0lUbENMN0tXcU5Tazk3ZmhVNllEbld3YjIwMGVWRkVCQmM3ZDZON2px?=
 =?utf-8?B?T2wwdXNieWlFWFhTNXhFOW96WEZuTWZLN2oyUDA5bm8yVE0yWXd1R1pzcnI2?=
 =?utf-8?B?ZWRUL0pGSXBRbXVDbHpteHAwWVRzVzVwb3VvSWRkMFNyUy9CQytWeVJmZ2kv?=
 =?utf-8?B?dmlUUTM1bmlkWnZwdDBGckxsUWc0YksxMC9ETEpPZHlsVW9PVHJSR05yek5u?=
 =?utf-8?B?em9DUzE2UW9VcjEvZzZReXJob1Fxdlk3K0xMYktLQUFudmdVN1pxQklkbThu?=
 =?utf-8?B?b0VxYUZUQlBHSVJlRVJDWldVdDI3K0ZUSVF6NllHVGxNY0hNaVEzaktXRTBX?=
 =?utf-8?B?NlR2aHF5c0dBUFRiZndGZUZxdlZLaDRYS3QzSzdGMTVVS0l3TjVrZk1xS0pH?=
 =?utf-8?B?TERVME4xVkRYZ2ZlbnRIanduQ3d3OWI2QVhMQVJqdmVMK3U5TTFVY1BoY3Mx?=
 =?utf-8?B?Mm1Bb055bm1oTThzYVM4VUZsZUpWODY4YWZaQ0VYd1hFcnVEai9kVlVNRDd1?=
 =?utf-8?B?YmpOTUsxaDVkVEZtUHVsbDV3VzVCYjAyUTdlUmpVM1p4SlRNME9qb0N4aUlI?=
 =?utf-8?B?d0NFcVVzU1RIMlNNdEgxbVBCc3RtczVCc1o4VGlxd3FidVhJc0p0S1BxRCtU?=
 =?utf-8?B?d2VKRmlyOWlWT25HRWlIb29rRWg5ejdURWxSU2Yrd3pGRHJaYVY2OWVDVlk5?=
 =?utf-8?B?QnNkaXRnbEdnbDIwMUlOMDJhUFd5VndRcDZiZTJqejZneEdIZll1MG94WnJm?=
 =?utf-8?B?T0puaXVxSUdCaytmMmh0b1VwOVFYR2RyTHRkL1prSXhVUW9DUWMxRU1xdkJS?=
 =?utf-8?B?ejZJK2k4VFEzV1F3VnN5NDZvcjUyTWhRYkZzSVYyMDJ3bDhLaHZOVWhkajd1?=
 =?utf-8?B?VHlaYzFLUWg3ZS9ZcVI0MDd1OEFqaUR5blZ3UDdRQWN6Qlc0Y2RaT1lKUkY0?=
 =?utf-8?B?QyttWWw4Y1RYcVhxamxkb2o0SFZYaXJMQzZjZDJOOFcwN0M1QWpndmpObFp0?=
 =?utf-8?B?K20zU09HNTNmWkJIcHYzdXRNYWR1YUprUDhHODBnd0ZUV0k5eE9yZEFWY2hI?=
 =?utf-8?B?Z0tydnNyb3hhbTl4M1VXbGQ0Yy9lU0pEaEtqc3lYeDIxOVVoeUt2R3ZBa0F0?=
 =?utf-8?B?NktGeGJaaUtEaVhubG5jZUhDTkduNE4yUU92MUY1RVU2aUw2RlRDNVBMSk1k?=
 =?utf-8?B?dXg1UVBWZEpmdlZMYnkxZnYwdjZLZEtQTFVKMkMwWVA2VE9QRGtiWmd1ZnFy?=
 =?utf-8?B?R3hHNzRORHFyM3lCcXZYRU9DdS9jRHJKdTg5aUxWMGdjc0luYjJvak1FK3p6?=
 =?utf-8?B?WVh4YkVFNTlJWFJFWVBqTkdFMVoyVEJnUVE4UmhwMWtOSTRYQUJpZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05d767b-33dd-43c0-c959-08deed469723
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 07:54:17.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5O69JcgfocWief6zaANqZcKt8ea2Lb9Hh6n2t+5K/AEVSZXYMLJjzBrrY0B1Sb/CSkzRb9k1pkdsAkg8ergeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8694

On 29.07.26 08:57, 刘杨 wrote:
> Hi,
>    We have already conducted long-term tests on the following hardware platforms using kernel 6.12.55 with Xenomai 3.3.1: N100, N97, J6412, i5-12400, and AMD Ryzen 7 8845HS. I am using the 6.12.y-cip-dovetail-rebase branch, and the latest kernel version available in this branch is 6.12.90. I can use the xenomai-

Ups, I guess I need to re-sync the v6.12.y-cip-dovetail to -rebase soon...

> image provided officially by Xenomai. Could you please provide a download link for the xenomai-image corresponding to the 6.12 kernel version?

We do not offer pre-built images, but it should be rather simple to
generate one yourself, just following the README.

> If we completely disable the NVIDIA driver, our test programs may not run properly. I will disable the nvidia_uvm driver later for further verification.
> For the 6.18 kernel, I compiled it from the 6.18.y-dovetail-rebase branch. The 6.18 kernel exhibits the same issue: the system hangs after running for a certain period. However, when using the 6.18 kernel, SSH remains accessible even after the hang.
> 

Then you could try to let tracing run during the test and extract an
event trace after the hang. Maybe that reveal how the core(s) lock up,
over which exact workload.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
