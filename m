Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EF2561B9
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557155; cv=fail; b=c+lCbPNXFm0Q+DsrIa+VB5gwzhQANHnQfbescjOO1EF+Yh+MHgeAmjQW+19ztU3xChg2HBQRjdvC1sWq3Z1X7mggMvfJigKp0aQ0MyNQr6sceReigaUZV81yBhae8YjDAxDr96cdk+6dyPfpyLBU9/L2UFmlzKyo9Ai1Wmi/704=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557155; c=relaxed/simple;
	bh=ylkceLfnxT4ecDgbXFuiF8VQiMYTqgCFU2iBueAnmhI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4RCU8+Y940W3zHGEd8MYJ/Dy2ZW2dadqcCiRpNFXaSr2W3hk2l0qEIGMJSZXomaYMi3rpC20v9sDSv74w8IV47LK8htS89meWBvH5v+IScLCMASS3F7NUwhVQ0KA713rRknXIiEnZpje7b3IJ1bT7VWvOKqEvH3e55dVFJdakg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nE7yD3Dh; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nE7yD3Dh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqaWNcTYkjqwkvuk7K4lyhdSz3Ya6RbVgnvVZzBygTVF1YrLOTx9s5FyZCv2GXFIN3u+Zt0+Mk/1tIdaRud9bjmf8V/eGML8+Yxxp8cKlqh6hRSIrhb5bzP/v5hXlkerHoQpOiBhqyEzcdhGLUT3U6g6LeHv9ZXjpSz9Mu3k/Pr1LqrqWn9DhHIxXfYrRIzhu5WoMkUMOWxKeMsElUIRUbY6NRdzEjFKc4LBj1ooLT/EtPFMAEjkN+RDBBics0WW5FPanyMAvedd5JbVG2N5Eb5EY5CbpZOLVR4xqQETHliX3QsD0ywyQCJuCRd5KfWtoEEWYsH/9ALg69KlNBhHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e74aQaNC9key4bep584DLJv1U+aOvarYlN2Sc4Mz3TA=;
 b=gD6qh25FmyxzPGbjqzOUs/5rR2hSP/uWqIMPYLtFb44xCDSIb2ON/7PXqlSzZKUHQy+sXs/Sei2lrhujZwHKhMgxARn5YX1WT200m/5BTpeqw0hh5d7G79uk+k5BQNpaC0KgRCEnDsgMfDaFSi76CcKuDc8SJxSYUsomTM5hRy7co+e/J90vN76BRAh18NNkw/39mNVai6NOrt4meshhBHY1BifnY7oE7ydiMXlkTP+y3St5EUM5ZUCmSvK9qqxQVh6SA18LUeWlkLHHKd8aRDMWW/kLyM3PQ5BxQcdUdOLlzQ+eA/PFUQovs9LCrnfRiWQg60J7lRjHmMhBSSgvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e74aQaNC9key4bep584DLJv1U+aOvarYlN2Sc4Mz3TA=;
 b=nE7yD3DhQVCwwAFSpLgzmxAPZNZfibaS5ahTMI2wWYTqDSIkDV8FHPSubmu4JC/i9yav2Ohw704n512vNKywF6sgqITzQ30VPJk7ulyBRQmsPP8W5YES8zolgPh2ycIs/nGyO9kBuYOoUsXxK2HwZ+Vt1PNcplftuRr7aGioNW6tQ0+fJBlwMavakmu7G/hcWVSbZgkQyIHj+PU9XGmu8vPZXDG7MfQ/cEhnEmW9C67pejLcM6TQb0lpCqymJO2JNoxF2J7aPBaRE0LxMVGbEnptZ0a43htNt/27zWK99jcwZG7VJUD5zWeHkudBGX5yav0WKemBBkCjjX7HpvPXVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB5PR10MB7919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 15 Oct
 2025 19:39:08 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 19:39:08 +0000
Message-ID: <1f722c62-3688-4209-be37-a2dca22bed02@siemens.com>
Date: Wed, 15 Oct 2025 21:39:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-xenomai: Add arch specific debug kernel
 configuration snippets
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
 <20251009111228.3504354-2-tobias.schaffner@siemens.com>
 <0b90eeb8-aacf-4d1d-8523-4226a098d886@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <0b90eeb8-aacf-4d1d-8523-4226a098d886@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DB5PR10MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: b6299e15-931a-49a0-3d06-08de0c2281ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RERNK1p6K0dpWjZEaVdSN0NXbS9FQUNabk85RmhwRTdyaEhaaVpPNkM1MWFh?=
 =?utf-8?B?NnpvTlhTdEMvdXhLbW1NK0ZUNTZIdll4NGZ4V3J5cDFzN29RTnZVbVRkeDNU?=
 =?utf-8?B?eU1jZ2ppSXZGNTZpV1NaaTFQUzVTUS8zb0RNZkVKNDNyNGFuNGxKam5LNGdQ?=
 =?utf-8?B?dHVDQkVOd2RqTnhsejFITG11ZGlNODVObURQWnp1cWo4amRmMm5mL0xHMWVQ?=
 =?utf-8?B?NTJQeHpsYjlCMWRoRUQrVkJYZGp5Q0FneTdTSVFHZW5wRWtrN2JlblozbEVZ?=
 =?utf-8?B?ZDBlSk5maHg0RzVPWHR6K1MxRUNIclpvYUhvZnplSHdiZmwrUnlWUDhYMTJO?=
 =?utf-8?B?c1lXRU1MYThkWitoZzQwL1g1eFBNOGdUMXUzV3oxVEs2WjR4NHArQTVNYnVX?=
 =?utf-8?B?b05pTnpsclJtV09ldkY5TGRvdmpwVEdPMWhNY2psOE00UGVTeTl3am5sS3Nu?=
 =?utf-8?B?N2l2Q0RSZUQvSXBITUdjYVpEcmdwN0l0WEkwUVA4cXRiQ1V0c0JMMUcxdDNC?=
 =?utf-8?B?bFVqSmlMcW9QN2Y5ZHYwTmFiZ1ZUaWZNTUxmV0dNSzlZNHR1V25kYXlKaGND?=
 =?utf-8?B?MXNrUEp1YmIwbks3TnE0U293MXdYS29DN3B5QmxVZW9wTUt3MkF4aldHSzJK?=
 =?utf-8?B?OHh0cW9tSXpzWnZCZHdnS2N5Zll4dS95RFBGZUQyeVFXeXhWZlhxYTVROVRv?=
 =?utf-8?B?b0c0MGxFcjg3TjN3VXRRL0ZUd1FNbVI5Ujl0cW1KUllVUU1xYkxRbVp2UEZt?=
 =?utf-8?B?aUFNRC9NbmxjdEE5dUZQWGd0UVpNY2ticmlHa3hRZm1DaXVpZ3VoTDlWNlQ2?=
 =?utf-8?B?VEhUVlpTTkVPYzNoZXpHYXRkbzU4cHZpdjNxekZ0Q2dwMWlNcTBnZmJNaVhY?=
 =?utf-8?B?Tml6clg1NFNlNHBOTlVnSHVTa3RjRFNmYmxWQkNHSUp0SHZvZzBZWWtHR2N3?=
 =?utf-8?B?UXNoSTYyYmdzL2NLNXdmQ2FIUDQ0dndTd1h5UTRuM1o5VWhzd1BRWXhJSyty?=
 =?utf-8?B?d3J4QVliWHh0eFJSWU1aTVlsZGNxazBIRk90VnhVNlVXQUFuQVAwUWczMytP?=
 =?utf-8?B?UTdJaGdQSkpZdHhWam1wZW5PWUVNcm02MGhXSHE3akJZMldHVjk3bVNwbmVF?=
 =?utf-8?B?RlMwZlRiN25JYWhnNXJIWjlVTHQ3K3dlaWxDdHJPeXdQNmkxYk1sdlNRRXNM?=
 =?utf-8?B?R2F6QWVkNUtiVGVRYW5xekJncUViNUtNbUZZTGErSlk4OU5Bejh0SmYrRlB2?=
 =?utf-8?B?TFVEQ21HdjJqU2lRL0JrbjgrTVY4SllyWkxDR2ZTQUxhS25Ta09BUU91NU4x?=
 =?utf-8?B?TW90UTlIWExHUGZReXI3dThGam8vSythdWoxL25tTEo4WGxDcFA5cGhRR3VC?=
 =?utf-8?B?dVFRbnRsc3F4WStvWjg5NkdlTzJxSjBrbGJOMWFtbUJoRVNMNSs4b01pYVJp?=
 =?utf-8?B?bmJxSGNGYlg4cnZCV29obE1FY3pWMzVQc1ZhOEh6Q2RlaWZtNWxwUi9Rdzk0?=
 =?utf-8?B?MEhYUklIclUzMW45c1FUY21WWkxhSVFQUHM5aWVSNkZPd2IwcEgwNkpiOGo0?=
 =?utf-8?B?aTJRR0I5QVdoNzZSY2c5YlVVdzlnemJMaWtYMnZMWXQ1VXc5bE1YYnk0bVlN?=
 =?utf-8?B?SXpldnpKWUI0WFYzeUQ1TFNWVTF3QUZ3d2puY29OVjRwQy9jdVJGZm5HVGhz?=
 =?utf-8?B?R2FnN2dLa0JncGJuT0wrNmtRVXRMRXhNbjlMV1loMUNlSG9GaUlMZkdYYjdz?=
 =?utf-8?B?Tzl5TnhzcjJDUWxlV1U2ZXlIbzM1M1N2ekY1ZnJEeHZxR1dLdjdlaElFZHVS?=
 =?utf-8?B?SER1OVp0WE1tWEpCb2ZJd2lOT0JrY01ITHVXZVIwU2dYamx0QXlGZytqSHI4?=
 =?utf-8?B?K0R5cThMZnhrYy9LSG5Xa1NoOTRDWElZcGRjdURCRHJrSHExSHRFWEQ4bWZj?=
 =?utf-8?Q?cGwdWoDyAxdGy/dbIjYXnIrIid9j3MFY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTVRY0JiSUE1aDZnMnQwMUhlU0pHNGwvUEpseEYzWHREWWRJc0IvWm1Wa3Vx?=
 =?utf-8?B?aUZ5SCtqMlNoemVwTW1YbVZJSnJGSWl5L0FLcmVHRjV2NlpDRUJ4ZkxTY0Ex?=
 =?utf-8?B?QkpJL25ObTViOGhrbzdUYjNTU25Ga1p2S1FCOVl5Uk5QWitHT056eklZaXFL?=
 =?utf-8?B?VmFCREtIRW1ZM1dNOGE0TjBVN29JU25Sb1lITU1XQWFHV0gyQzdPMDZjY1pH?=
 =?utf-8?B?UjlUNy9yTXMvY29uYXNLanRzaTEyQXJFUGJUV1ZoQldHVThSenpFVzJrQ0hR?=
 =?utf-8?B?ZXFUcWZRbVVYbmJVM2RSV3IvNnVSNDZ5Q2NLV3JQeCtNczFCeXYyWHlYQWlW?=
 =?utf-8?B?YlFWMmdCY2RnemF3OEVMUVJyeHVIbUJrQ0V4N0xNSjlXanRHd3JhN1RVTy9Y?=
 =?utf-8?B?MDBsZWVLY3FObHBOc0JVdncxUnpOMjRTSVpSM2NyVjRTMUFuQWg5K1gwVk5Y?=
 =?utf-8?B?ajFUUHRQU2FleVVLTnhJWVV5SE5ON0xXekx2NDEzeWxJL0VJTUpPQmNzc2hL?=
 =?utf-8?B?V2hwVG1zMkpzbTBEVkRNckljNnJKcllGSkNJTmNPbkZFUE5Cd2dMenluSUVW?=
 =?utf-8?B?Tmd1NENTNGt3cWpKTXdDcit0QzlrM09DajBUcVhFTm1FM1RrNFlTdEtOQkty?=
 =?utf-8?B?Tit5S1d4RDRGVDVVOHcvdTlBcGx5SjVhNWlIWGRXWlpDcXBmWWQ4U0dKZ2dJ?=
 =?utf-8?B?ZkZNMFd3bHpLc0R3Tndlb0tMN0ZlM2g4U09uZmNVZ0w4UW5zYk9xNU4xNU9z?=
 =?utf-8?B?ZzBGNkJGcTczcmJucXhGYWlvd3JHckN1OXhpbXdCdGliVVZ5NDZCNlNkU3pF?=
 =?utf-8?B?azhLNkFnNjVoUmk3dmtLTTl5c2NZUnFqVlBGT2x0NUVlaEsvRXBVb045V3Nh?=
 =?utf-8?B?azBmdXRXZUFjZng1enJoTFBCZ0JNOWd4VkVsU2tWNUVUd3VGa3hxeUZnNUFC?=
 =?utf-8?B?eEZuRnFTYW9DNlhWdkEvaDV6ajkvSUtVcVpqbXZSejRFeXFmdFBOWXdTZXJD?=
 =?utf-8?B?UkxuMmxlUGhnSk1DejBDYVFpRGNTUW9SZGNsTStUbWRlN2xHRmMvTFc3cW9E?=
 =?utf-8?B?d3RqQnpIem5POVZqby9YT3BrV0hNN2pYcUN2QXNzOUIxdjVFOFNsVlgzdzNW?=
 =?utf-8?B?elF2UC9tZnVVMjI1UVF4c1pkT01VeW9iZnJFb0djRUJWZktVOUxiQUZPZlVR?=
 =?utf-8?B?Sjd1V1paUEx3M0N1eUo3aE52TnVkek15aXpmMUpRZEd2c0tTQW5MQzgzTXhD?=
 =?utf-8?B?ZE9vSE00ZVRaM0d2MERacWVnUTlRdkVOUlVQZGwzdHRxVkF6b3Y1ZDFhSHdp?=
 =?utf-8?B?cEJtUWF2TUxNR3BVTGtuOVVGazExdElaZUhzcHdZRERReTA1ZnFFOUp4RURa?=
 =?utf-8?B?QUdKNlByZ3k3aThINXA4K3hDOTlDbTJGVTY3QTE2WGwwZURVa3pIK2R3S3N4?=
 =?utf-8?B?LzA0R1Q0Wm5UeFpCc09yL1ltd0JTWGVaemRNK2F3OWhjcEc5TmlCU1laOWNz?=
 =?utf-8?B?ZlpkSVNqWEZYNCsralBJNEhNNklYa1RETnREWkxaNlpVblZ3cGJCOGl4Mmtq?=
 =?utf-8?B?VXF0Y0pwY3F2WVdkMjFDc1F0MHhHUEFueEQ5bExscGl5TVdHMGovSVY5NkpI?=
 =?utf-8?B?UVlZVVRBekJCR1FIT05EemFBYW1salZoSDVLS3preG13RC94VDlPaEFLY0xX?=
 =?utf-8?B?RXVtZWZ4d0x3TWVkL05VMDZpcGUzVlBzQS9GZzRoQjNlVjFEY2I4Mzg0UHJm?=
 =?utf-8?B?M2o4eER6eEluVnZwL21iM1M0QzFaa0JBN2lqRk5jeGk0WVpYZkFKRnpIZTlo?=
 =?utf-8?B?N0w1OTkxOUdTY2lSdHRjcExlVzAzMGlscXpkb241emVlZE84bnhtSDYxcFRS?=
 =?utf-8?B?RmJZR2hWQ0owbkpVcTljNHFTS0VGOFZVaTgvbDRDZHFMVFdJanQzRWVucG1I?=
 =?utf-8?B?UVpRb21JejJFL0dOd2tVWFRIZXlUZ2laK2pTS0Y4RTI0THR2aUVFZ0IyUlEr?=
 =?utf-8?B?cTEyQjEzS2VCd05URFpBTzI4VkpZa1VZZFFlUHEvMDRMTXdvY2p4OXNVQ2pj?=
 =?utf-8?B?SmhlZ0Z6REJKM094aC9MNzk3RXM1YTFpWXF2THVoUkdOOXVDVS8wb1QrNXVr?=
 =?utf-8?B?MnJXRnRiRmpMd0gzY3hZS0JibHhzN3ptRGlRemJaeDZYbFFlWnZEWFVjRlRV?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6299e15-931a-49a0-3d06-08de0c2281ee
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:39:08.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kkn1ydg0G6O40OkgeWgJi6zRzLR3y6BegVpIlEns2PV1rfn8NvdJYoTClJ/xRvlTEsgQNv8M1tym2/5SEWyg66KakVG1Lgivpgu0kjs6xRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7919

On 15.10.25 07:46, Jan Kiszka wrote:
> On 09.10.25 13:12, Tobias Schaffner wrote:
>> Add dedicated debug configuration snippets for each architecture to
>> consolidate common kernel debugging features. This replaces the
>> previous approach of using an inverted no-debug configuration to
>> disable debugging options.
>>
>> Separating debug and no-debug configurations improves maintainability
>> and simplifies future consolidation of debug settings across
>> architectures.
>>
>> The change has been verified using the kconfig library. Applying the
>> new debug configuration to the updated defconfig and running
>> ‘make oldconfig’ produces an identical resulting configuration to the
>> previous defconfig for all supported architectures and kernel
>> versions.
>>
>> Several debug switches that were previously left enabled in the
>> no-debug configuration have been moved to the new debug snippet.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   recipes-kernel/linux/files/amd64_debugconfig | 436 ++++++++++++++++++
>>   recipes-kernel/linux/files/amd64_defconfig   | 313 ++++++-------
>>   recipes-kernel/linux/files/arm64_debugconfig | 404 +++++++++++++++++
>>   recipes-kernel/linux/files/arm64_defconfig   | 149 +++----
>>   recipes-kernel/linux/files/armhf_debugconfig | 438 +++++++++++++++++++
>>   recipes-kernel/linux/files/armhf_defconfig   | 164 +++----
>>   recipes-kernel/linux/files/common_nodbg.cfg  |   9 -
>>   recipes-kernel/linux/linux-xenomai.inc       |   3 +-
>>   8 files changed, 1594 insertions(+), 322 deletions(-)
>>   create mode 100644 recipes-kernel/linux/files/amd64_debugconfig
>>   create mode 100644 recipes-kernel/linux/files/arm64_debugconfig
>>   create mode 100644 recipes-kernel/linux/files/armhf_debugconfig
>>   delete mode 100644 recipes-kernel/linux/files/common_nodbg.cfg
>>
>> diff --git a/recipes-kernel/linux/files/amd64_debugconfig b/recipes-kernel/linux/files/amd64_debugconfig
>> new file mode 100644
>> index 0000000..a07ec9d
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/amd64_debugconfig
>> @@ -0,0 +1,436 @@
>> +#
>> +# Debug Kernel Configuration
>> +#
>> +CONFIG_LOCKDEP_SUPPORT=y
...
>> @@ -1,9 +0,0 @@
>> -# CONFIG_IPIPE_DEBUG is not set
>> -# CONFIG_XENO_OPT_DEBUG is not set
>> -# CONFIG_DEBUG_VM is not set
>> -# CONFIG_DEBUG_LIST is not set
>> -# CONFIG_BUG_ON_DATA_CORRUPTION is not set
>> -# CONFIG_FTRACE is not set
>> -# CONFIG_PROVE_LOCKING is not set
>> -# CONFIG_DEBUG_LOCK_ALLOC is not set
>> -# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
>> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
>> index 8c7df40..501c212 100644
>> --- a/recipes-kernel/linux/linux-xenomai.inc
>> +++ b/recipes-kernel/linux/linux-xenomai.inc
>> @@ -16,9 +16,10 @@ FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
>>   
>>   XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
>>   KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
>> +KERNEL_DEBUGCONFIG = "${DISTRO_ARCH}_debugconfig"
> 
> Why _debugconfig? Isar only picks up .cfg config snippets automatically
> and adds them to the base config.
> 
> And what makes the debug settings arch-specific? Do you have some examples?

I split the process into extracting all debug switches from the 
defconfigs and merging the resulting debug snippets, to make reviewing 
and tracing specific switches easier. In the end there is no need for 
arch specific snippets.

Good catch with the filename inconsistency. I will fix this in the next 
version.

Best,
Tobias

> Jan
> 
>>   XENOMAI_DEBUG ?= "0"
>>   
>>   SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>> -SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
>> +SRC_URI += "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
>>   
>>   S = "${WORKDIR}/git"
> 

