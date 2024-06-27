Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CD23777
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719469796; cv=fail; b=Q+hPWLk/97gXME9W0tLqFfAvE9+eF0xBLc4LJ99+MTlaqGNi3x33xGmzIj4z9ZBu5P/4YnJLvug5alP3vOild9TdSPkGyUYxkoaApHubPz4ZdKYPmlEf5IyM/QPP3AN1FIL3WhU+g+JiefNG169q5QLTFeKcOa6P8EAgCEdG3ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719469796; c=relaxed/simple;
	bh=9kBw4D9t9olbL992PgnPD0THoh6mHOZWqGO8QfBZCII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jdj6jGvD91cZGGsLBWSSSnz5PrDFnkYiH7hoe2XMJNQy3Adhs+GIw6/85o+e8P+8Jw8jrp0jzhIkWICJj9/Z2dFYQST9ZvCROC7YpKEBhwTJHtTp9t64bXYWAVQJiAraDg/n/UbMgJ/D8beL0V4xOFdoPjNQmFK2Co1ZGbOTUpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sbiyr+LQ; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sbiyr+LQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoeR8O7N2IliWRAAszUPKdJYgf0GOeKb9YZlDY9tE5eNu8mAVxT+iG6DkLIwUvwfhJlbMETAmtY287yNwEFvRIRtFyeBUY6jwImCDPr/amK6v1mRMtmzwJhSqE8HR+Yf1ATAva1KBuzvoafTcG9DKOoH00DLVbHPfx4vOhoXeWjFgN+HagGdbp1aH4jxz/1oYhM/WWp2dm9GtNpSGPE7BtBBw9UH54KbnrNL6aorlsNZNXmfNVOmcr/LjP8Fz30DABE/kRNfIhqYvEYYmO9NFJ3lBfrGdl/whX1UybA0XWV6wpZ7EzFbUmfTGITDPW48+PaL1Ftjn6l3VYXh6vK1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZH/ws+Smnl0PO6Oq6v39uKeACDtlsxkNTP0qDK3jY0=;
 b=Pd9l2Hc7wtFs14OONL6+P5jEeN8PoBMFIwAnF8yr2Myf6liF87/WcS2foeU8+wK0tRutCPtcUCLsYpOwOAZnZn95OlzPmOaRb6Tn7CHpNn+m57noYxfm4Xc7Pz7KgepBWSfDzNtMBgu5HJ2xXn0ghp77+qAjt+/FpMV8wrNmRk39sI/Em7zbZvw966FXuKsueeemRc6eyWuZRX1iodu9hGaaNX+bgO6fY9YxoEEw70uJ1TiybM/yHV5R+3s/PWMOoiDZNrVNSy+iRERGjbOgj1WvuzKAZCtNsVmcfViT94tQG+GwTrbOBqRL59/D2cGGgvvdfUxCw5g2J3P1Sqbhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZH/ws+Smnl0PO6Oq6v39uKeACDtlsxkNTP0qDK3jY0=;
 b=sbiyr+LQqFwRbOFp+LktJGxYH7laS0b9VxiTZm5rXihUwpbEZG5+U1h1tgjV4tiKC2oqGA6f6hOyTJb+iQ7yw7XTGtLnVoj5PHYe2bxduk9AN4xqasNi3XchRJnJza/6CwJnMnugQ9UMFjuKaaD7ADFahRmXHEqxQcYWylgJXoIqqnrNpSW3acYzhH6HN6Jc0tkU/jynwoOijbxDjcRabV9F8V39cazHQrEYa+8l6FIEfxLdseVcMip6BKO6lBTsNe3EXciMFehNCveQ3DpP7qPQWeK451FcPkqKKz85uCa8vOj1BnqeXRY1+QaqYZFUZldfCtw4cMjBQzljdnKpdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 06:29:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 06:29:48 +0000
Message-ID: <77eb1c15-be5d-4f99-b023-844a679699cc@siemens.com>
Date: Thu, 27 Jun 2024 08:29:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: Clean up generated syscall_entries.h file
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240626192625.14745-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240626192625.14745-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: e1192993-1267-4675-187b-08dc96728b20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0JRQVVZMlRIREZtUzMvaVJWUEZNS0ZKaUEzdVdHMEFaVjBmdkJqc1NwUUta?=
 =?utf-8?B?UDh3THZ3ME5wLzJFTVZFdVFVcjBoY0N6Qkdyb1oxYUlPaXdQcU1qUzVPeXVW?=
 =?utf-8?B?TVZrUmZaMDNUNTNsWXl3RUNXZ2ZDVmFWR3VzY1UrOWljcitmalBLY3pkcGdp?=
 =?utf-8?B?Tm5yL0dlc0hIdlR2NUI3Y1BEaWJDM1FuMmdtckNTZDZuaUkvLy9jVHdvaVJV?=
 =?utf-8?B?blZ3SkJxSGxxNW9NTlV6TU85RjFNTjZsRGYvenJac0lTZHI4QTRTbmM0WFZn?=
 =?utf-8?B?emFjLzI2Q3JRaHR5cHJ3dFJUUEdCN3Z5QktHOW43THhBTUdJcVdpUDFWQWgx?=
 =?utf-8?B?azZabnJja0VaaTNjS2Njb3hHSnVmdXBwM1R4eTVFaThWcGhrTjBzanVTVnNl?=
 =?utf-8?B?S1MwMkhTS29yRy9raFJlRVhlNk9NbDN5YlN0MzZVNWR6aXZadXEvU2dPU2N2?=
 =?utf-8?B?NDd4Tmd2M1lRQUJGQnpQSkdPT1MvcWFZd2NYZnoyc0NmakRicmJXUXpKOUk4?=
 =?utf-8?B?U1Z1TldBQ3hyMXlCbmx0OEp1ZXpQeEdEQlcvd0NlMXRwMlRYbFhNM1hkMHRk?=
 =?utf-8?B?eTBOMjhDMG1PeUJibnFQZGFmRkdwZUR3RkRoY3ZaSGt1d3RzN2w5bnBBM1pG?=
 =?utf-8?B?VXp5Qi81KzhHeHplMjh4amhKbmVydmE0QWlCKzUrc2FROSs1Q3NQb2luSXdO?=
 =?utf-8?B?QVpVMW96dk9qUjJ1N29Za1NiV21aV2hyQjVmeXRpRXRRTm5DOXQrSEM0eTBX?=
 =?utf-8?B?SU9kT1d5NWhGWUVhVStTZjBNTXczNmU5NU9QSGFxR25qbjluVFMydCtVUWRH?=
 =?utf-8?B?YVhaUFg3NUpQWXZvM2M4ME5sdlpmeG92MkJjVUdjMm1LaWYrN0hwcnpSZ2Nh?=
 =?utf-8?B?M2RxbER6UEE5bVVnTHJ2RXhlaGxESVh3NjVjSlZmOHZsYUMxeDhIeFRRZktr?=
 =?utf-8?B?eHowWTdWYWRpVDRRMUMxVzdLMnVydGxPQkpDTXpDeUlrVG5XZ3RxTi9TZ0t3?=
 =?utf-8?B?RHMwMFp3L3hvZG5YSXpNd2xsWkxkSUZocEh0Mnl6cWVXRStHSEFZa0k3ZzBt?=
 =?utf-8?B?RTFGTm9LMFVya09TbS95UUtJTXhRTjdzWm83Z3RhMjV4dm50YlpyZ3EzdjlJ?=
 =?utf-8?B?OThWTXg3Qnh5UG9kb29rVjJQMWNDb3dGZDZaM001ZHhoc2ZQUktFb1lmRWhL?=
 =?utf-8?B?azZORFBtM3NYWVV4WVJLa283cm1VeEdHQXBud3lLUFV4aUhhbm9DY0xXckJv?=
 =?utf-8?B?YU84MHgxeVFPbkF0dDFkSGZTYnNiMTNFdzhUeW5iTXRZYlo3VlpOSm9mMXR2?=
 =?utf-8?B?c3dKS3RLRVB5WGJSM2lkM3FXa0h3T1NTbVlCYlNGb2dWc2R4d0UvbW5Gd2RR?=
 =?utf-8?B?RFNucFV1VVNHcWxaa0VqdXB4dDNyREk2a0lDdWdnUnFJYmhhMlA5dGtEakY4?=
 =?utf-8?B?T0JTNlFQOE5FZlZFelBPYVZuZlhUc201b1hGZDZncThISG5mbWlUbUtXQkRz?=
 =?utf-8?B?V1Y1WkxwY1dkNjZtQTdKcXhBd21nQ0Z4Myt1Ry9iMFRBUStKa3Y4Vy9CRjM5?=
 =?utf-8?B?T1BpSitlcFhCNGtMSk9HbHBPNUtSSFBraloxVjRUS3dLc1o3ZW9jQmVoakJk?=
 =?utf-8?B?dXk3YkVFQmM5bTZtTlRYbHJHNGpCZHoxWDdFRGlUSnUvTXd5RDExN1lDeks3?=
 =?utf-8?B?cWMrR3VxajEraHBnZVlKekJFUS9vZGdKa3U5MzFhR3JoekpYR3g5VnBnTzQy?=
 =?utf-8?Q?cA3RerbuTM67QrIfLusiTofv91cfLdG9xkuQPpr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3B4SDFwMFJmM1pKVmhwZklVY1MrdzZueCt3NUgvMm9zdmY5OHovUVF1UXRp?=
 =?utf-8?B?QWlOUE45bUJoOGt2NzJKRXlDS3dWeENtQUIwVU0rblprUy91Tmx5MzJqamVW?=
 =?utf-8?B?QzRhUkIwY00yWkV0TkRjRm45cXJxcHh4M1Q4bHVpMEFsWG5YelhvWmhhdmZU?=
 =?utf-8?B?Zm5ORHlpNTNkZVBzdm5sSjNhYWhDYWMyeHRLYy9HT0FPOGhYREhWcUVEcEJk?=
 =?utf-8?B?UnJDN1dJSHJVaDF2Q3ZKMFZvWTJEam5wTEFzOUtTK2dHL3p4UmY5UWpTN3ZX?=
 =?utf-8?B?QnpLa3ZMckIxVTc3OFJHMmt1Vno0MDVRbStXMmNMN3d0Vk9wR2gyUy8rbUZ6?=
 =?utf-8?B?bENPYzdkRU41elhJcnZkdGJHMVNMMis3eDE5YkdMUlRhK3ptODNmRm5KV2Mx?=
 =?utf-8?B?WWFybWtQdkpFTXV6eXhrVjZRcVRSMkI0OU5abHV5cWw4eXdsN0pKNVZoOE5o?=
 =?utf-8?B?eHkxYXgyZUNuRFlrcjZHaFZaZmY3N0ZlTDdoTnNTV1dOK3AreHNZQXNqWmJK?=
 =?utf-8?B?NzA1WmlGMW1Hd2t5QnVveDZoNmRmOVZGdkZOSGhNRVRQMnp0YVR2OTQ5NnpX?=
 =?utf-8?B?NzlJb2p2Vmptc1ZxNGlSWGpIei9hQS9QQ002THY4RDRIcWN0TVB2Y2k2UlNQ?=
 =?utf-8?B?emxGNG9rZWJBcjNIbmxoRFZhWGhuQzRVMkhJVHovcXlXbmF1L04xTEZ1YUpT?=
 =?utf-8?B?R0NGU3NBSi9DcURUTWpKSHRDd0hLVFgvR3NrdlNkc3pFa09od0RBZ3NTRmF2?=
 =?utf-8?B?bHFUVEh6SDQxUVd2ZWpyeFRNUkFReXFWbFliTDQxRDd5emxud3ltZ3Z6bkR1?=
 =?utf-8?B?ZEFxY0g2S0t1eHBzeTloaDhUYWNVODBmblFpSXowQm05bUdoY3pOYXd0V0w0?=
 =?utf-8?B?L0JoaGJLaVA3bzA4VGR0aTNaM3o2VVlTNENHTmlhRU1Yc3FHc1BZQkpRN0k5?=
 =?utf-8?B?Wm9KN0dpaEQ1OTE4ZlZPdW1tTnJZaEYyWEs5Vk41a2lWbnRHR0tDTHpPYmdC?=
 =?utf-8?B?ZHdjdnh3UHBuM1dIVmVLZWtXeXZ1Tnd4WkJTZ01uejVkdjFGTnI3S0hJYk0r?=
 =?utf-8?B?anByZi85TjMrby9yYlhiVDkxUjltSlIxQjJ1Ti9HL25VS0NsT2ZpVTg3QXZ4?=
 =?utf-8?B?MStxcHRHaGNhYVFrb1Q0VG56TURrUlNGdEsvNlV5K29aSDV3ZXA5YzZPTnVB?=
 =?utf-8?B?SDlIR3NnYmxjdXZtYmRraExYMTVkOHIyY3J2bERaTDBuN3E3YkttSEVyNXNQ?=
 =?utf-8?B?TlZkVlVMc0hYek0rbUFHNFc2K2dRVW9vd2tNQlhZcThkbUI3VG93T0g5QVc1?=
 =?utf-8?B?WFdjd1A3WVJ3NkJzZW5ncUlOSmpOSU1VQXhFZ2tIOFg4aEZNQS9wMS9JWldn?=
 =?utf-8?B?ZU5ScCtVMTM5ZWcyU1AxWEdyMUNCL2p1ZVpHUi8vTEZSRVNaWTlrYVJ2RmJO?=
 =?utf-8?B?cXRDNk1ra0hQNjl0Z2VReDZoRHhDektpQ1JpdkdJUTRSWkpmbGRna2ZsWmh5?=
 =?utf-8?B?TjdFa2RxQ3hURzRtbFVtYS9ySHpEakhEalpVL0g0dlJjKzBZK0h5OUtPL2pW?=
 =?utf-8?B?akFTU0lXeGI5OVl6VlFEU3ZHTTg1NG84TWFTV0hURWdEcVFqcXJvK0RRQk5v?=
 =?utf-8?B?ejZ2MzlhbnpFZlg2aSs0QytpWEhMYmU2NGVRSVpGRmxnc0FsNEMrTGF3OWpX?=
 =?utf-8?B?TUNBdFBFL0dqWnlXR1pFcXduSWpKSnY4MG1rN3VtMkNkb3F3Szdvd1JwWWVk?=
 =?utf-8?B?SlZ0ZENqZ0VCY2lrdERxbTI2Z2NNdUlmZENKd3BmSzNGd1g1YTdSWm5qdUNs?=
 =?utf-8?B?WHZoRkNTM1hpYWk3cHE3SyszdVBVWlZ2bnNDd0lXbXJ3Tml4dE05U05ZUUt0?=
 =?utf-8?B?OEFZQ2Fzc2lmQyt1TFJETTVnWHE1R0Z2OGp1ZmNkM1lrR0x4VkJiOWdmbGZq?=
 =?utf-8?B?Z2hqcWJLUjVMRk9lcVN3MDJ3QzJuOEFmQTF1Nnk4MldyeXVmZ0dPVlNld2Ns?=
 =?utf-8?B?RVJmbHRXYmN4ZGxzNlMyZTIweitjcG5kbkRxekJnQ2ptR0dlY1VrWnZDYTdt?=
 =?utf-8?B?YVA3RlFma1g4czhnOHcrYjRIZm1MV1phSlhoMTg2VnNZaUlyTHRnRDRDMkwr?=
 =?utf-8?Q?tB8iys2T8pOcKbrN1kz3Pgom0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1192993-1267-4675-187b-08dc96728b20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 06:29:48.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmzo4Nj2Z4q5PHU605W4EwUgDUPnMTRK8nAvtjxSyL/DwOoS/cv+O53pW5uLAT99cmeBhpj2xC6iRVkEGXLaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5259

On 26.06.24 21:26, Richard Weinberger wrote:
> Add it to the clean-files list, such that Kbuild will remove it
> up make clean.
> Also drop it from the target list, this variable seems unused
> is most likely a copy&paste relict from the past.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/cobalt/posix/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
> index 5b4f3214a..9e2f3f6e0 100644
> --- a/kernel/cobalt/posix/Makefile
> +++ b/kernel/cobalt/posix/Makefile
> @@ -31,7 +31,7 @@ quiet_cmd_syscall_entries = GEN     $@
>  $(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c) FORCE
>  	$(call if_changed,syscall_entries)
>  
> -target += syscall_entries.h
> +clean-files += syscall_entries.h

target is generally needed to prevent re-executing the build although
that target file is already present and recent. Did you check that a
second build will not have this problem after that change?

Jan

>  
>  $(obj)/syscall.o: $(obj)/syscall_entries.h
>  

-- 
Siemens AG, Technology
Linux Expert Center

