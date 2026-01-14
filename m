Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05937A485
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378603; cv=fail; b=hsl6+1fg+XfB2AcltDZXFE9wGqUolWfz3zLx4CAnKRIvoSaECEb1dkHB3wsWZBq589FCt4rpU/LYRriV7TYrHVh/MURZwRj97f7mVsNgmNaWoQpYhXZaAoznKZ9qrznigyAcIdvKB4leoeQsOJbpxRubvVNBHWxPKZdhaFqiy3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378603; c=relaxed/simple;
	bh=KffU3hkBTObE3NsEubtsTce6aZFPwfBoFjiFdgg+m5Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L7M1Yqhjpam5CaKnYikRkuKw50augLxIZMPTJY+gRm3y85daro7r9c2Wc6gWskA5X+f/eZzE2PscihDiDWLRqtouwlyfAz3sk2vo3vKdTCXIK0//EIP/4TSffaSf9CSSZoMYZP+LvWPxfI5McuTKp6lSubtG7HrUFMHK+mgkTO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aploS6IV; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aploS6IV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3sKjzm/MiCOPhX1HzG7yNY4ZlFDbOaLoWYnW3j4bS23WpbtGpYqOvS9k40Pyoj4iBoJ7lkCBPB7VdP9TiC+g2mzY9ncTzT7tb1Xn0Sgca5xHyT4pRixnvfOVQo20qYh5LbfhPCe1jqw4V0m/nzdzWfDxMqaPmxAeKRkl80tilhrXIvEvBmzvxUWh5p7aVYsrs42bqo+wyLiEOgX+FrZ3Va3nSqVAFrMRakSWEABlD4leS+R7VLPTFWklMWn6aGAcgIsLZUyFYymIG25B9mPWCy0Q8RZXbrz9DBUvhK4Fl8/uv/Jgi8b1rFyE5CO5QFcnjCicb0qleSanFOCLrO/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeD5NvExD0xeR3lBE0XotFzasY1w3u+83XQ6cqZed1I=;
 b=LaGhTr5lJW4z5Qla/uT6Qtcn1iKP6C1X+gskdQbJiwNbzaF2xj/0GZpsy6hOAqpi+/OOMN3MjIGpskTDLxBJTZQD+Ts1QN4GRDomJHr6LlFndh1axo90ChttWOPU3ZjH/O3AZZ+5ZMFOWzo9llsshbMLPIG5umouaA+R+zHAY3faLw3dY4yL5WksburcIDV2SxRUDzhQqlAm1ebfKZoJPem3Poa7Lat2m8tdhemhwUlAY1R8+E8R/CQPN0N2hYRvxN2RvzCn9QVXLEwsPITSVg9aCI6hHIM5DDN529kM6XEOR8cJq8iGGQJTdSgl8mtlYS96smzUUw+X9Yx3svCXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeD5NvExD0xeR3lBE0XotFzasY1w3u+83XQ6cqZed1I=;
 b=aploS6IVkJyzehY8l3Xge0gM46XPtP9tAqo6SxtAICDLX+wTkoxj4sAQCN53wdtnc+DlghtWLR2kpcF8yblsMkHTblp9ldhGI2QAaVLCSV6MWvj36CNHYw5LG0sEXuqbob1jwAYPOQdtqU0hJekQdyily/5cmRI2GCZc4L8GqIlymSR5oXIGg/lPyMn+VxRHBv/mrZjrRQDg7ls3ulTIv4L2nzExo9aXp20ISCcMJ5lrnR++iBQKPe2lrjPnRnaJNDzn0xnpG+2obrGVTSf3Cj2zVWbElA/3gPvBhGdXuGNKhnDL7ItXKnNcMrHR+KF0sBExl7BV06s0kDfioHTlDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3958.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 08:16:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 08:16:30 +0000
Message-ID: <dc28c24a-b070-4fff-b968-e45547bdea44@siemens.com>
Date: Wed, 14 Jan 2026 09:16:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v4 0/3] Trigger CI job for dovetail
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260113113945.1038227-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260113113945.1038227-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3958:EE_
X-MS-Office365-Filtering-Correlation-Id: 801e28d6-3418-4718-1303-08de53453869
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejNlN2E4cDlSZVNxdWlnWG93R3B5L3U4ZTdVZXB2T1RBWEpDTEMzRXFqbGFO?=
 =?utf-8?B?OWkyQThyTlp6SkVxS3ZOcTY4aklBSm4wRVJwUUdlODZIb2RrVCtDVTd2WGtB?=
 =?utf-8?B?RmNnR09zRS9nbWtUZlM1U3Z4UDMwa0srWmI4aTJSWHRmUnd0YTB0dW45QXJT?=
 =?utf-8?B?Y1BSLzQxWFRUaGF3Z1pxa0Jjb0cwQk5pZUpwY1hQcHJRMElETmh3eW1XZERh?=
 =?utf-8?B?QTZaU043S3ZsTlM4TktXVVNCVnllSE95QktkdkY1bE9La3MzTlRsWWI4K2RD?=
 =?utf-8?B?d2VqQUtkbEgvWFBwVlJXSWFYNTlaRTE4TWpoMmZOeU14UXJFMjVnbE1kQ3p6?=
 =?utf-8?B?eXEwV0hTLzBSRHBzRWRYOGxrcCsycmkxN0xrbDNXTEN3YyttWE9Pc0FDZ2c2?=
 =?utf-8?B?eFVjWnJhWm0vNjRELzhNZkxROGxGR3M0Zi95TlRGNk5OTm9LejNuTWdUV1hP?=
 =?utf-8?B?TWlqTFlTYWIzcFJTNjY1dWN4Z29QcmxVclpYS0c5dzhRZHZJRjVqbjNuTmsz?=
 =?utf-8?B?c1MwYUYyK0hlaWVmL1dubVU4cnJxRXgwdmJjMXV1L3NsQ2M4WThSYVRPaWNr?=
 =?utf-8?B?cmx4ZlYxQTNZekQyZUZqMXVrZFc5VVNSS0xkc3RzaU0va0h6b0Y2c3JjTkR1?=
 =?utf-8?B?bVQ5TWgzL2JCb2FENlZHai9lcGVYdklYbFRFRE4wdDEvdmVSOG83T0h5OWxu?=
 =?utf-8?B?Ym5mbzRTLzVqcUk5UG1FcnhwSVREWkMyaFlEZlh1S3B4ZitWVkxnQUJzc3Zx?=
 =?utf-8?B?dU8xNEhVSThhOTFYeDlUL3FPMnlrUDhIY2FIL3NxUy80Wmk5NG50VUdLT05N?=
 =?utf-8?B?bE92ZG5oU3ZNWUNsQWF1ODZGY25xN0JpalF0Y3cydXZjZGY1emNvbnI1bXhy?=
 =?utf-8?B?U01Oc0ZndWY5MHNUbzRjdUpDd0R2MUtKS3ZWcW1aNWZ2dHNvWGltV05kMnJD?=
 =?utf-8?B?YzlFc2hsV1JnSGxBbk4ycHlBQ1VhNEhwVXdGa084VTNpcndqZjAwNzljYnFC?=
 =?utf-8?B?QVlPSlRRY1dBa1BwNW8xRjByREVETHByUkhlWFRuUU9SSHRpZUJwdENrN2Y5?=
 =?utf-8?B?SDJBWkxyYlJiSlpZdGJFc084ZFBWZEpNWjJnMHd3VnF4UU1xSFpQTURUZU1L?=
 =?utf-8?B?Y044QVV2dStjTm1QQ3NqYW1WZGVwaUJBZlZpVlJNcm1Fenc1WXhpMGhKaHRJ?=
 =?utf-8?B?eGpRMTU0eC8zYVFuaWtmaVhZblBnb3RTS2ZDcFQ3aU1HZCsyNVhwaCtwSlY1?=
 =?utf-8?B?VWpFNVpiY0pHQTYvQlV2T3NreHltYzFOWlh2Z2JPRmpxSGNOTEZld0FTalhh?=
 =?utf-8?B?ZnM3RElSanBMM29vazlPbnlwaXJ0am9WT1pqdTZHZzVDNkduc0JqQ01KS25I?=
 =?utf-8?B?dXlMaGY2K2VTK0xhNmNmbWo5T3N1SUZseGkzNG9PMGNNSUZVSFFOaTNwYlFN?=
 =?utf-8?B?YzdYR3lLcFdPbWgrUElJeUFaRTJBUVg1ZWpSL1VTSDFxeFNBR2hLTUFEY3l6?=
 =?utf-8?B?UmFFam44UDNhbjlYYmIvNXA5bWxQSU44TlpmUnJnM0JsVWFqa3V2NHlYQ0NP?=
 =?utf-8?B?Q1ZncWM2eW5GNGhhR2NpbTEreU1vbEFIS1ZKQUNCSG5JbjRTODRKaWVjb3Iw?=
 =?utf-8?B?NXpoNlpLdTJZZVVpREEzazYyMlN4amxFK1JEaUhwOXVoUmJQZ1N3ZFk5em1w?=
 =?utf-8?B?d1QxbUZaRGN0cjJPSTRCZFl5YWtVVXhxK0V5TVNFcWdjY09UOGRkQlIwWnlB?=
 =?utf-8?B?dHJEZkt4UklBVWt0aTJjQ3MrOGtaUkZOMEpyWXZaLzR6Wm80SmFBQldMOG93?=
 =?utf-8?B?blNVK28ycURBUGo4Z1BjR0w0MzlIV3VhTDdzazI5anNLVDI0bGRSZyszanBF?=
 =?utf-8?B?QTlQbFJ6TUxzZy9PaGNhZ01qRFo0WEpRTm9pQ0xtOVNnV053a3JOWVUrTmdV?=
 =?utf-8?B?UElEWnVVdzJWWHk0VGVpbktianFyY2pWRFNkTUJEOVpYbkoxdEVWdTR4ZEFa?=
 =?utf-8?B?Z1gzVmxHcUh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1k5L2NzY002RmJ2NlhWaTZDSkRYMXc2L0ZhamxKbW4waDBOSjZCVGM2Y1Bp?=
 =?utf-8?B?OVBqMVpQY2xtYUs4azdVNUFsSkZhc3VzNFNQdmU1bDRjUndTUlJoUHFPdEtK?=
 =?utf-8?B?SFl0M3pvdGN0c0VVTFFlWWsrU2JjQmIyOTB1YkU5b1lQWU5pYytSZ0NKdzNi?=
 =?utf-8?B?cjB4MTNjMEl6eUFUSDVpR243NWVWcWwxaE55aERTMVh2SXNVMXl4YTFBTUJj?=
 =?utf-8?B?Q0llNXF0UkdtR2RmWjNsUWpNNlcxVVA0N2hWc2tyMlBkeTRxWXhrTmcrQkpO?=
 =?utf-8?B?anMwTXBhU2p6SVBlNFFQOGNtazg1c3ZDMndFZlZlTlk3OUI4RmNla3NMMWVT?=
 =?utf-8?B?K0QzNjF0VlhOOWpETGhaNXJzVmRBbFZDT0ZYUGZ2dUxmbk9LZk9lMVlMRkNC?=
 =?utf-8?B?VmE1ZlhoSHZ4Q04vKzV5ZGVCNDZUT25JVWljcFE4VkpTYXpEZ2RqVzJlT3ZY?=
 =?utf-8?B?Q3VqOTVIalcyeG91RWRKcWJEZjdrREN4Zy9KZWtsN3ZXRmJMUlBNZ2NSblJD?=
 =?utf-8?B?TnNwMjVjbTVmakJVaDQxdjNVK2ZkaVllMDVxZnoyTCtXOEtZTUI1U0lxMHk3?=
 =?utf-8?B?bXlMUCtsWDlZUzFVZW5naWlKQ1ZzT0xTQXFJb2p2RlF6Vi9HM2FZc1kzbSsy?=
 =?utf-8?B?SVJTcWpUcm9RYVVhdFp0UnNvQ2ZvLzcvcHJLZjhXU3VBY3pJK3RKWHZOcFhD?=
 =?utf-8?B?eXpkd293WHFvUlBSQWRqbmxLUWNrRVIzdjRGT05uanp3WlRDVWxhL1dJcWNO?=
 =?utf-8?B?ZG5oZU1DUGMxUC9iaU1UQzNRbUFYdFM4QklBSmJXZEVTdVh0M3VmelYyeVRz?=
 =?utf-8?B?OTA2UU41cGs5L1d3MXBtTmtsQVdlZDNXUlc1OFpSK2NEUDlpaDdGREh1ZGZ0?=
 =?utf-8?B?K1ROVklIa2hMOFlGUjYxNW51TnBWWjRIajM1MmZpdzFuY0dLUUcwNFFtK20r?=
 =?utf-8?B?cUZGZCtHZVRud0dLV3pwQ3hUOEU3MWd3OHR2MWFhY1JmemU3dElyM0FjQS9x?=
 =?utf-8?B?eXF0NzJTaFJBS0QyUjdMYklrLzdtSzlBaVpqNzdKQlVyQm00UkVUdDQ3aWlr?=
 =?utf-8?B?RlN6b3h4ajlnQ2RNaDhTVkRwamh5R1dWcWp1d0laa0lRdXg5bXhXenl6djdu?=
 =?utf-8?B?TXY4aFM1VnZOWHJHcW1MM2RCcU0rSlovNkZDMlRVRTcwS0hpeFZSWGFETDRV?=
 =?utf-8?B?V1k0YTNJRHVITXpJYzY2bHhUUjBQbWk5b3VOM2NRbGRtTEJNR3RsQUNRbFpz?=
 =?utf-8?B?WExIcTJ1RllLSCtyaGJwSVhRbkk3ZXN0LzRoaGs1UmtEL25UcEhqUFlkbkF1?=
 =?utf-8?B?YVdoMHR5bmpsMDBvaVdXeUgwZnpsRythSERjUEIyL2dHWEJicHlBVnE1eWhB?=
 =?utf-8?B?c1VDSXUxRFl2b3BkSktuUmY2Q2VVK0ZCV0RHRllLTExuVW1UWFFFWlphcVR6?=
 =?utf-8?B?U0NGaGtsTXdwYXZMV210STZsVEpFYS9DQWJHaDRtUkRQcFJHbVY4RWdlbm5F?=
 =?utf-8?B?aVdkUlpuWHNEZmp4K1pOdGxPMnlvNy84WVFnalgwa1BKT1dYRDc3cmJIWVh0?=
 =?utf-8?B?VlNNVTk0Ri9UT2xwN29aMEQ3U1FPOHNTVjFiVWs2aVdXc0FrSU80QlQxak1N?=
 =?utf-8?B?cll3eE5nWENtR2lCamZaVENiVnpjeFg1N1h5cnEyYXdGWFZyRGF3Z2oyNFNt?=
 =?utf-8?B?MmtlWHRoWVJMcnNtYWQrVUlZa3V5QTN1cmpBbkpuakZEMThXS3AvdHZyb1dB?=
 =?utf-8?B?UzhjVGhuY3l5em1ZSjM1dnhUSVM3Ui9iY0J5UXFCOTBuQVNKaDBoaXM2b2Vn?=
 =?utf-8?B?d1JmSS94NEdQWlk5emkvcmQ2U21IY2MwdVRBUE9xa292MmxObGZjQzIvZHZG?=
 =?utf-8?B?bzJlazFXZ20ybHZLcFppbG4vdkt5ZHZhbXdmeGlnSVZBMWxzcHJIUnQ0RE40?=
 =?utf-8?B?K1FEWDltU2Z1UEpzSTZHb25lTEdZM2xIdS92Smo5NGlMM0lnMG1VTmtiMFJk?=
 =?utf-8?B?MkpFYXpNTW8vVzgvYUptajJOenVLUlAxTDNDeFUwZWc0M2piZjJnS3hhZnpM?=
 =?utf-8?B?eFJQVEhkN2FRRWpaTmF5cGNTVWQ5Vnp4YVZraUN1QTFZMHZXSzFrS2twTE9V?=
 =?utf-8?B?QmNlMkFySXVodEJMZWxra3pobUhtQlFpYjhZQmVJbGVSR29iZGE3dDYvMVRV?=
 =?utf-8?B?VmtxL2V5cDMyWGRwUTZ6eFRZb21OMTU1K2dlVWJoNGI0Wmx1QStuSlNOUjU2?=
 =?utf-8?B?U1NjKzJqV1FXRHhIWTBsMUFNTWREbHFkVEZYcEJINzJCSXJEdEhUOGRSTmZa?=
 =?utf-8?B?UkxWbFRnWFFJZDFDWGJaUWZnZW1WVDRhdEloVmVKRjlGekdnM0c2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801e28d6-3418-4718-1303-08de53453869
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:16:30.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2csxR8xoPwUGcUCyvOqGD6v9SiWITs48WZh/s8XaUg7BzvAKuE+Y0h0VdKYBM22vHo3CCOX5CweqdIckFMHuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3958

On 13.01.26 12:39, Clara Kowalsky wrote:
> Hi,
> 
> this adds the functionality that if new commits are pushed to dovetail,
> the corresponding kernel builds in xenomai-images are triggered.
> 
> Changes in v4:
> - Fixed https://gitlab.com/Xenomai/linux-dovetail/-/pipelines/2258056311
>   by adding the same rules for trigger-xenomai-images as for set-vars.
>   Pushes to any branches not matching the regex
>   "^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$" are now completely
>   ignored. Tested for v6.18.y-dovetail-rebase and v6.12.y-dovetail.
> - Fixed https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2257965129
>   by setting XENOMAI_VERSION and XENOMAI_BUILD_OPTION as top-level
>   variables in separate files and including them based on rules. That
>   way, they are for sure set for the build and lava jobs, which wasn't
>   the case before when they were set in templates. Tested for
>   v6.12.y-dovetail-rebase.
> - Renamed ci/xenomai_3_dovetail.yml to ci/dovetail_xenomai_3.yml to
>   match the structure of the added files for the xenomai options.
> 
> Best regards,
> Clara
> 
> Clara Kowalsky (3):
>   ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
>   ci: Add build job for pipeline triggered by linux-dovetail
>   ci: Add CI for linux-dovetail
> 
>  .gitlab-ci.yml                  |  8 ++++++
>  ci/ci-dovetail.yml              | 49 +++++++++++++++++++++++++++++++++
>  ci/dovetail_xenomai_3.yml       | 35 +++++++++++++++++++++++
>  ci/dovetail_xenomai_3_3_x.yml   | 14 ++++++++++
>  ci/dovetail_xenomai_3_next.yml  | 14 ++++++++++
>  ci/gitlab-ci-base.yml           |  4 +--
>  ci/xenomai_3_3_x.yml            |  2 +-
>  ci/xenomai_3_next.yml           |  2 +-
>  ci/xenomai_3_next_long_term.yml |  2 +-
>  ci/xenomai_4_next.yml           |  2 +-
>  10 files changed, 126 insertions(+), 6 deletions(-)
>  create mode 100644 ci/ci-dovetail.yml
>  create mode 100644 ci/dovetail_xenomai_3.yml
>  create mode 100644 ci/dovetail_xenomai_3_3_x.yml
>  create mode 100644 ci/dovetail_xenomai_3_next.yml
> 

Thanks, applied. I just changed the tag "lava" to "small", which is the
same but makes more sense than what I originally proposed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
