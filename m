Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04113D610
	for <xenomai@lists.linux.dev>; Tue,  8 Oct 2024 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365261; cv=fail; b=DD21YpT69vzc3+S2L0iL8N5t9J+b2AGI2Jdvfdbq6hBVNFZKla9J83evdpgr3wbZVlK9tdBZxXm3CoESFm6NJheMk3EetL932u+5AsaWQop+rOVEB3NPq7e8XKmoQYRkFSzJXLkjataSNF7J2k9XFe5QJ3TiOh5yF0b+orUS4is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365261; c=relaxed/simple;
	bh=pDwXJwCDXDoAZsLJhabaoO8OQMXwFo2gnez7mYazfk8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=quZPDoO4lH5jpnbucyxJEor37y2NtkMwv8lpBY/FUsbkp/tQ0Ik6hYkZVUBQOL/KKrQvf6sMMOQAj4GIQP/0KUn1Uwk8KY7wV9uyGGrQLRHLJuC+joiBKlLdr3eI9jAZRmM5HsHoIXqVU9dmqOS8AO+icJdaysRESvOGciQI/b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pS4PBq/l; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pS4PBq/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/VQnTKXQjwjBbZMfLiBXIxw9T+gSsnX3z83UA6DI5gyApQdEc+IU9IFBEZYN7w+qOkj8VO5+s8sgD/L8oeQa7V5cAbDWWDb9qZXUcG6J8XhvkHQggT69n7NGdq4+0ButQvOIly9Ldnaee1et2NDy0OotZXn5Xfa/GHtW6HNKrwsGPvhO8G5TH0L4NyLrv1OTvzs7jkH/Xy4SF9/eEJ8KzCwmTcxy65gRH7P/vU9xsF+xHIm6UzDIi0LxFc9O4VsGiAqXeTovlV+iGHO9Z5eW7N/Ocm6U0mqP5Nn7T7R/sxS38kUjMlkGHmSCFkvV9ozhG/6lN8Qro9AORyQ7LZNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrZ2ymD+jdBxqM/hbI3cW8OTwlBBiMCft36CPuQLtMw=;
 b=FBwIyIu/XmDpKE6sFYBfY44vi/1tLnE6AXyaJoPnKgybvb3+uz/63L1BzMHfc6VqeNsHfjSc4rPegVzFn0LNXKOxMIYnKcLeA+TeN3Y3ctTQUu1x0+7Ec9Ev6HK3W355nMmgeE33srFrTNpnQYKmyAlu2GPiHbEe85A+yb+Vl42J039b4DTMPrI+a8PyFE64swD7icQJwT32Pyil4/dGb7BdYYm83F09lXH0AZqqFBWt3Hb1CxEMmV0QYgoTwAlCmxYB7cCG8w7lPLRRLo348aew8Zp/MZsarOOxmpPyjo4RwWwIzyqlDmBD53TXgul/K8SKQ0KA2X8i/PNbftmu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrZ2ymD+jdBxqM/hbI3cW8OTwlBBiMCft36CPuQLtMw=;
 b=pS4PBq/lGSxQUTIIoxUvjkIWCBswFmch/4iUk44fZk/2fmo48WcNgL1z0dihx17AM0u6GclIxljIzNPGMMhmw6uJp8N4ijEfD+ay2aU3u+/Tg82oV6z3Y0ITBQWe5lbAxgLiSvbXNUTIx3B+J4m9GRqPyVA2Yjyga1XpJZSimWCvBw0ifmKwmIxFUEPpYmTaCIx9gfpyST1kxwchb/g+N4oFRT3Ol9G4jh6+s2HhuQQ86XZWco00S2OM7b3yrs32BIee4Tu+D+lEemyLbDsehO2JIJEXmaDYCQpmRTxAVSM9YCjKVc8mTZyZoXKr1t+k1l04q6d+5S9u1X2cECkk8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 05:27:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 05:27:33 +0000
Message-ID: <d483ecb2-7228-4972-9e3e-e87f94b9e32b@siemens.com>
Date: Tue, 8 Oct 2024 07:27:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 3.2.x] cobalt/posix/process: Sync on thread-hosted irq_work
 items before exiting
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbc4389-14ee-4aaf-e7f7-08dce759e996
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXZaSzI1cHIwV2hzQmZGV1RQeHZjbW9BWGZLNE90VkdnNngzUk5zNHd4RHdk?=
 =?utf-8?B?dDJXRTVrWVJvZFZ4dVRhRDNsNnNicUhiSjRLcW52SWlIMTFrWjhSQ0dLY1Jz?=
 =?utf-8?B?azJhVmdUbGFEWFc1K3A1bHVPWHpUaVA0eS9kSUpyMnRmRStFSlNvdU9UalND?=
 =?utf-8?B?R2t0UlJ2UHdFbVNUdWNDZXRiSm1ac1Q1YXNGYXpOU1RHbjNqNmxzZnpaQ0py?=
 =?utf-8?B?V2tUQVBpajVYRmsvSHk4Z3k1WVlaZE4yY0ZQK0l5d21YWFRsQnp3M0FIRXdN?=
 =?utf-8?B?bDBnbVQrQXlMdFNhVVd1WU1wK09RYWxSZFJJMnhSaFYvckRWa0tiaVZDcThH?=
 =?utf-8?B?V3BQc0ZyTEdQbncrTitoVzFNZ2xnRFBucmxnOGQxempRRWRaSU5oU0NjODY0?=
 =?utf-8?B?dHEzTkVLdlN6aERGNll1WHZoQjJzUFJlQzZhcloxb2lpKzhzTDlXY3k3R0ZY?=
 =?utf-8?B?MEEwN3M5ejBObUQ5ME9iRGprZFhKeE9wN1g3Q1JtK1d3aFlDUmZ0RFdNUHJy?=
 =?utf-8?B?dUxkMkxTKzFIbytJeHozU3dKSGhWOU10UDZxandGMjZvVDZvMWlFeTdPNEpY?=
 =?utf-8?B?UUZVVTlTdFNkR29nVmFnWlZlZWVRZ242MFRCSkVoUnV4L25BbUk5NGhqNXhC?=
 =?utf-8?B?L3IyaVhnQWJvZy9FUUNlaWtOcms2K1NGOGVkUVF2N2FpWmsvcmJpek55SU9S?=
 =?utf-8?B?dTYyaHRYY2JMZVZYeUxXMURkZ3F2UGYwMTVSTFgxQ2RsVi9SNmlWampjcUZ2?=
 =?utf-8?B?VERYQ2lCK01xcUt6ZGxyZVRzRTdlcU1Lb0RFYkhhRnZ3bXRYRGJhRXpNVS94?=
 =?utf-8?B?dXVtbk5ZM1V0dHVkVTlsVjJtVTVJbUtXeGdUWGEyM2VnaTlEQm1DeWtlQldP?=
 =?utf-8?B?eko1WVRQUEJMQzRyK0NDTTRYMHhNMS9VQXBxbEcwaGw5ODlLYmVDdzY2UTVK?=
 =?utf-8?B?d3NmT0ttUjNJOWh5TkFrc2owN0RDektjU28vUlNwMUpVT0ttNEZpeE5TYk1T?=
 =?utf-8?B?V3VDNFZsYTRXK2UrVEV4eCtnMlF1akZlSVlSMExnREsvQ2ZwaVd1L2FVbCta?=
 =?utf-8?B?WW1YSVR4aWRhWTZHMzgyN0pidFNXc3Mxc096WlpCSWlEM3cyTVhqMUdiaG9h?=
 =?utf-8?B?THBOalBML0pDWEx1ZTFmaVRrNnJMdkFvQm5hVzgwNytrMUI1Y2N1OUpsZjdy?=
 =?utf-8?B?RGdhS3p3STIwWFZ4a2hveVdJaG53UEtFTEMzeDhkRTZBQ1dkWUFBWlh4Rjhy?=
 =?utf-8?B?SDllOU1Oc1BOa1FVSnZaSmVFdlFGdUtRdTBlMVRjclk2Y2VFcDhCR0FGT1Va?=
 =?utf-8?B?Q2ZGdzBFUnkzcm0zSHdIM2NYTkl4NFI3SVBUbkRpMyswdTVRNkpaYXlsZ1FK?=
 =?utf-8?B?MEZ6NHFKbGtXUUFhYWVTTW1mVlA1S3hYMllMSnJBOExGQW8vVERjWk0yVHlT?=
 =?utf-8?B?b1FNUmRraXlSdmd1TGVreEtyNFpVVTVBRXBoUVhBV0dYVkFpS0hJQ1p5R2JK?=
 =?utf-8?B?VVVqN05QVXh2RzMyL0ZvaHZIMkM2OUtoQzRKODBnNUxJcWZNNElTYlRqaFh3?=
 =?utf-8?B?UWtpVzdiTTRVeXJjZTltK1VRcE5Ya2lZZXcwQVZDY1ZUTXRXSm9Yb3Z4b25w?=
 =?utf-8?B?MHE0dFI2Wm1TaTNkNzhzOThHK0p2SUw5MUtCcHZhMXQ5ZjJ3NlBDTXRyZ3FX?=
 =?utf-8?B?b2NWNVhBaDhZSWg3M1pZdzhrSTNpRVBRYmJlbVFlZkZraXM5d2ZqZXpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1FXMkQwbUdoZTZ0NWFrNnJJRnJBT1lScXpYd2JsZWpzSFdVUUlLN1BFMnY1?=
 =?utf-8?B?YTBGUkozc2loODZidVE3UG0zbTBBTlFoOXk2Y3ljUTQ0REZQMTdyL3FzTmtN?=
 =?utf-8?B?NDhDOXhuTDJ1cGEwU3JOZm96TXVUNGpleUVLd2tUaFI0WHpPRTdlOTNLQkZu?=
 =?utf-8?B?WmFBVjBVdW5Tc2NSQmd2bmp3TDVLTnlyNUlVaUdVZHBwazBJckdzN1NKT2hx?=
 =?utf-8?B?b00xb2NlSVBQTVk1b2RLQ0R2YzZkSFBGMTA2QUJNS3lJL0FwcUdNb0dMVmRI?=
 =?utf-8?B?dW1ITlRzd3VmZTNuaytqb2NiZzF2ZUlObTJBRGhSR0dKMXh1eFhnemlqL3hX?=
 =?utf-8?B?dU9CdzRGQ0txSmF0R0VQYXRwMzFrQUQ3OTJKMVN3cFlmY0ZHczJ2V2lBV0pj?=
 =?utf-8?B?NFg1SUo1eU0yRzQvcUxJMXhIbDV4a2M0M1krWUJKRTRENEZWUEw3MzJsbG1H?=
 =?utf-8?B?RHNWeWxyRS93dE40Y251MVFkVSthYjNXWko3T3hiMkJrUy9MSTU0cnlWd0Vk?=
 =?utf-8?B?bjh1b3RodnY5ZDN6di9kcEZnNHE4OUNtNHg5TW5tVnl3WVNvR2ZwWUhPZThU?=
 =?utf-8?B?NVp2VXR0VTRMNVpOUnhrblRySGVWa2Q0MTFnQm9qL1FMODFndHlOV0hKSzNK?=
 =?utf-8?B?U1cwSDZESWppTlZBakpueUo2WW0wTDVHdnV1WHcyNUhUOWM5U0lJNmxPWTlX?=
 =?utf-8?B?NUFwNDVUdVVDNFhwMk5LSmRTbFdBbGhKTGhhRVdXVmxHTExreTREa0FGSFZX?=
 =?utf-8?B?U25NRWhPM0lpeWlzY3RSc0VyKzNGOENHcWhISFZrODNyeDZ1K05UcG9tMlkv?=
 =?utf-8?B?djhGRThoRkZyeFZDdXJtODAxZGpYcjNuWjIzWElDNUtySm5MQUNKZlNydkR0?=
 =?utf-8?B?azVYNTRmR2NYbGJqaWFJVHZTT0l5NExRckZSKzlGanM2R1JuV3ZmMkhlQ3Fo?=
 =?utf-8?B?b0pVVUJRZnFqajY5Q0tGdXdoOHMzclpwWDdjZGp1NWZtR1UxQVFCSkZOeFM3?=
 =?utf-8?B?K1JUajZNUmUyb1RwSUxPV2tNUlQvbkJ6TERjaWFqUkhNN3BvVytSQnpxRXlJ?=
 =?utf-8?B?dm80NmgxK3B0RDNzS1VDajR1L2NMZFlFWVVta3pFbUZjdWZ4RHJVN0JpTTE4?=
 =?utf-8?B?UGFveTJUVnFKM2tOQUNxZ3BEeVBZalZ6LzFTNS9PNkZVMFVIaDlvaUV5Ujhq?=
 =?utf-8?B?eFVFRlBnM3RCZ2dPYzAvM0MxR3kwQ3BDemtGTFZxZ3VDZVVOMHlSemYxMEx5?=
 =?utf-8?B?RVFTVFFpWittcUN3ZmFzcVdwN2tFUmQ0NXNBV2lTc0V1K0xhdlNaZS9IZHFX?=
 =?utf-8?B?QkRNQWtYOFdZdy81bGRwZEUySVlGK0RuaDBBYkszdUQrMWFSb0NLY3NvZnZI?=
 =?utf-8?B?UzhDRnY5Wlh3eFZjdHpxU3phNGNHMnhJOHUzc0JjaUUwdThLQXk5Wi82UkVv?=
 =?utf-8?B?S0c1Y3ZVMHN0UkM1cEQzOHdLU3VsR2U1K2Y5Q0VCSEZUb080SXNqMHRzU3Z4?=
 =?utf-8?B?R2pONWEvbjZIWEE3bnVZSmZ4ckw3bEFMMVZtYWNNWWthYjNiVXdoOVZ0aDAr?=
 =?utf-8?B?azJDaFBEbUo3Z01KSHRPREhCNDJYcjk1V0ZleFVYWmNwZ3JnRVJrZlJjVXZ2?=
 =?utf-8?B?Qy9YQWFCM2hzc0ZQamZXdytpZmtqYlVTQjE0Rzh5M0VXcDZtVW4xNG1SbzNW?=
 =?utf-8?B?c1ZicE51aDVLeENxLy9Jb0UxdENWKzRpR0pMb1pXUjZReUdKbk92T1NwRWRo?=
 =?utf-8?B?SEhEZksvMTBWRVR6T2JXcHgzajFpb2lzVzQ5MmFXZEVSV1lpN3Q2OXdLNDJS?=
 =?utf-8?B?SDBqOGZsRU5OOWN0ckRsWW9Uc0w3WGRTNVRKMGpoT2hSZ2FJSlp6SnZMa3Uy?=
 =?utf-8?B?dm41dGlCSXRLbldKa3lMdkNMMkFyYUx0K2gvVEhqMjkwSFV1YWJwZjMrOHJF?=
 =?utf-8?B?cTMvZjltdE9rQU41Sm92Q1FTTmN0QTI5bzlUVzNIRGJiN0ZhWXREUVVxZWc3?=
 =?utf-8?B?dUM3RGszOGdpb2xDUVBET1dieCtPVDJCK1h4QjJiUXJMc0N3YVR2VC91SFRX?=
 =?utf-8?B?VlRaRkV0RUo5ajRNMkR2R2NGMXdOa2ZXVkVNeDJTZi83SGEwcWVLNTlKUmJp?=
 =?utf-8?Q?h+dvEAZMrOQaerETKFlWEbZm8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbc4389-14ee-4aaf-e7f7-08dce759e996
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:27:33.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJdX7AUpcLOVwsL7NdujJT6jpYQqvDCYQU1V7+45pT8xD4hKH8JtSHL0xYeG4jpYjgdyZTnbp2McDamwdOOtDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8237

From: Jan Kiszka <jan.kiszka@siemens.com>

Better safe than sorry: Due to migrations, there could theoretically
still be signal or relaxation work pending on different CPU. To avoid
reaping the carpet underneath of them, sync on all per-thread work_irq
items when a former RT thread is terminating.

Backport of a1029bef54ff78bc01795032aee5bdec7c86fe41, only addressing
dovetail due to lacking sync support of I-pipe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/inband_work.h | 3 +++
 include/cobalt/kernel/ipipe/pipeline/inband_work.h    | 3 +++
 kernel/cobalt/posix/process.c                         | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/include/cobalt/kernel/dovetail/pipeline/inband_work.h b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
index af3d70fc69..826785e437 100644
--- a/include/cobalt/kernel/dovetail/pipeline/inband_work.h
+++ b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
@@ -25,4 +25,7 @@ struct pipeline_inband_work {
 #define pipeline_post_inband_work(__work)				\
 			irq_work_queue(&(__work)->inband_work.work)
 
+#define pipeline_sync_inband_work(__work)				\
+			irq_work_sync(&(__work)->inband_work.work)
+
 #endif /* !_COBALT_KERNEL_DOVETAIL_INBAND_WORK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/inband_work.h b/include/cobalt/kernel/ipipe/pipeline/inband_work.h
index 12ef07b00a..03e5f97e4a 100644
--- a/include/cobalt/kernel/ipipe/pipeline/inband_work.h
+++ b/include/cobalt/kernel/ipipe/pipeline/inband_work.h
@@ -29,4 +29,7 @@ struct pipeline_inband_work {
 #define pipeline_post_inband_work(__work)	\
 	ipipe_post_work_root(__work, inband_work.work)
 
+/* unsafe, but I-pipe provided no equivalent */
+#define pipeline_sync_inband_work(__work)	do {} while(0)
+
 #endif /* !_COBALT_KERNEL_IPIPE_INBAND_WORK_H */
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 935007f821..d789c4cdd9 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -838,6 +838,7 @@ static void __handle_taskexit_event(struct task_struct *p)
 {
 	struct cobalt_ppd *sys_ppd;
 	struct xnthread *thread;
+	unsigned int n;
 	spl_t s;
 
 	/*
@@ -861,6 +862,10 @@ static void __handle_taskexit_event(struct task_struct *p)
 
 	xnthread_run_handler_stack(thread, exit_thread);
 
+	for (n = 0; n < XNTHREAD_MAX_SIGNALS; n++)
+		pipeline_sync_inband_work(&thread->sigarray[n]);
+	pipeline_sync_inband_work(&thread->relax_work);
+
 	if (xnthread_test_state(thread, XNUSER)) {
 		cobalt_umm_free(&cobalt_kernel_ppd.umm, thread->u_window);
 		thread->u_window = NULL;
-- 
2.43.0
