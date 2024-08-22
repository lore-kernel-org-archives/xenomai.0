Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2065.outbound.protection.outlook.com [40.107.103.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE617B421
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318530; cv=fail; b=YJQXn6u7BQMCPo1S0Iu/itxuQ9VggjgVe3+REGbddvzXzuVwbOg2/LYp1wsi5DFvear20ts47Li6onC9JwgIvD04bC01rR+PpxhEfAYSrkyV77JSfuK2inAcEw2yG9SpRhWhXPaq2ckT2zH5TSzlVQhPyae2Xi2QqsgRG4Nh/J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318530; c=relaxed/simple;
	bh=CGbST7rP5AKJjTllNZ6jgtd6rGCJF5amlJW3+oMFsAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QFcqQ3+25cAeFdZXCW49/d+R8kcbReZcR9pRJDrCNQnX2NwjqHrSge8vqm0WL01UnKLn8W7vg+o/T4/qLEnkGnBVYvFpf19sK5RHLqFsvN/DvcDeP77IpRudz8mK7mXHGpfdzC7RO7ZXmmaUNlXGxPfUO6z6b07dtk5Hzqcj6Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=l8Pg6Lnn; arc=fail smtp.client-ip=40.107.103.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="l8Pg6Lnn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaF6vrNBbDun7FaDnhbvuuIjWaohZkF4OcJHQIMJrcIECUYC9mJCfNLHY/U0uApovC7BTyNA51BAJi0mnQXCMKSrQWwnQI99DhNfta8JA9RYhS5B3k+8s3oUdjxW71VLPiN/a7PtzgliG7F70M4+3lbt2SoSs4TfLnB+fRmGxDrfim1+Ec5UE12bD6Nq0FvZF2arZcesH6iqeuiDt9yoqlWwKl3KFQ9TrEsfonOnkH9XSPZex2UTaL7s5zYp0/Bt6HSPUlqbpASM3yzgE38zyq6agbLMfetNEbb67+90O5t/9mrO+lsuRlhgq2c1Io4UBPiQQY7NubTY7UfsWVROmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjaZIQ1dGVriSTFkQOezxSuRs+RgdQmoF+Up5cJkMl8=;
 b=BDXZeJqAx3/KtdpGrUzTfCYUnxqeTz8Blkjpg2cZj/mshqoDn8ibMmV4JgCvtSFF9xrhWhlnjTHfIHmYCgBkOwZaTTkh6NvpnM8oQaVQWJB8d+fvCDL/HBQSjU71HQErRssSzm1JqUtwcXVhad+cve0efiZ0z9umHq1dvZ8etomvXOWhPqLYo2+ZH94Mo/5OfH/Ca2z1NJwE8DqY4TWV8UJxBWBEoCfpCQOYnuG5tUY85hPEk8S2YjqNaKOrRup4bvgDtE2thAcWYYE2N6QwXFl63NPjPe9Hz0gduO203gfL4aP0P8sncyQd0RQYWUnZ/MB7rlTH4QK7mtDjlItjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjaZIQ1dGVriSTFkQOezxSuRs+RgdQmoF+Up5cJkMl8=;
 b=l8Pg6LnnXgPyiB/BBkHJWjJmgwBY5NwWmfB/WPjTXEVkDNzCdvQmOacJfQmMOSHitLDVLEzC3c6sEeDQvwd7OX4bNRrptW8wjY0LMhZwdCwfeerHI82PvsEjtdQM6CZN3Fbq8NbESt7AZyQBXhdtU8T2M+Cey9aE68hmkHWGlFLQLGBhhesQK8Ak7PtWMtzVFo/YLqXpIsohHx18S+A9huxhfCP+M1UWQA6Pe5EuuzDYpEvMzbDUTteiHQzy/SjSNtfwLO2H3AG8i/lyxCsdW5DJui6F1E1CHE4SBUF4UbgNkMkJ+cpdILZgT9ucsTVsHSTImPpYN0ieUaDdnJzvdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PR3PR10MB3998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 09:22:03 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:22:02 +0000
Message-ID: <6dc0eaa3-c7cd-43ab-aedd-ba65cf17e536@siemens.com>
Date: Thu, 22 Aug 2024 11:22:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iddp-sendrecv: Make it configurable
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240818111208.19026-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240818111208.19026-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PR3PR10MB3998:EE_
X-MS-Office365-Filtering-Correlation-Id: 45381a8c-9efd-4937-0731-08dcc28be1d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGpoSmMvZGpuVDVGRVc1eWRYRDcyeXBZd0VNVVNVcGl2dzlRSDdHa0NnVFlq?=
 =?utf-8?B?eEZVQlFGWkg5dldKaDBDWVgzdEZ6Z2p5K2FkcVlwdnlmbUE1dHI1N3dIYzlK?=
 =?utf-8?B?WFNiYmo5NUlXU2UrbHk2czdxNzNjdDFMenZscFlLTDJYVXl2ZnRFcWRuQk5H?=
 =?utf-8?B?RkJVbjU5MUlOV25RcDJSdkV3WnVIWTFRR2djbWMxMHJnQ3JlNWJCa2pXOUs0?=
 =?utf-8?B?eUVyWC8xc1BUeGVicy8zUmdqWnEyL0lTSUlEQnJBbWZjbDJIcHQ4NDFMeWNm?=
 =?utf-8?B?SS8vSk9qM3IzdHo2ZG9YTnJWLzV3WHdJeGVNOTlMT1JubC9KcGhCV0hTcnVw?=
 =?utf-8?B?cVU3eERmRVVXb3JsV0w5YXJhWW5FNXV4U1Z5c2xlQXdWaUtOUVB4M1BTUkxF?=
 =?utf-8?B?RFhBSlp5NnJ0VmxjZGR3cWdQOUdxTUNpSDhlQXpxMVUrWG5VTncrWXFacDF2?=
 =?utf-8?B?Zms2M2tiWlYyaGtZZDdEVmZPRjRnMm8zc24rck9yTGVIbjJGeHNGbjFRQ25s?=
 =?utf-8?B?SE0zVCs0Y1N6OUZsc01UUTVmQW1BanAxbTRKakxES09qODlFekRyckt6bk1o?=
 =?utf-8?B?NDB1QU9ZY2RHTU9wS21aRHI2SnVTaWlXYUZvQ0VHazRZYWkvcGpOdzZnOHFR?=
 =?utf-8?B?cHJSbTQ3bW1GY2UwVjB0T0FQdU16MHZWcjdlTlJDYk5wZmFpVDZ4NHdRa3F0?=
 =?utf-8?B?ei9ob2ZCY1hISmJJU1N1bXJHTlRvUERRaTRqMnlWQ0grZUdKWHl1L09kZHJZ?=
 =?utf-8?B?bWR3UE0zU1pRckNQdTBIdm9XT2t5TmlCUjJGN0JrQ3paZnpJZXZjcWZVbHlh?=
 =?utf-8?B?bjlqVnhlbnhUOUJEOGxEYjgyWCsyTE1xaEkxYVZhU0dZeHdjSXNhN3V2alc0?=
 =?utf-8?B?WnlIOE9rT1ZWOWJvdk5BdHhHdytyS3V1eU82UUkxYXBuaXZEdmdrbDZkVlJ2?=
 =?utf-8?B?d01ENm1qRFd3YVhEOHJhK2ZlUEhDay9lcUpuV3QxUVd1MC9ndUtMN25TVWc4?=
 =?utf-8?B?Z0QrWWVXNStuU0o2WFIzcDZuZU11L2FPSnBobE1MTHpnYkN0VjJEQjcwWHZF?=
 =?utf-8?B?REpLVVJJYXloYkVWV2htb2doS0lCOE5XOFdsQW92NkZQTU41blpTUTF4ajVB?=
 =?utf-8?B?N2Z4UUp3OEYwS3ZOVGwzUWdtNWtaWGU3Y2U5dHYwUnEwRFVvZEM3UTg3dE5X?=
 =?utf-8?B?ZjlPdHpmeUM2SE9pclRPMVh4RW9sOFdEdnY0R3V3MWt3aEFraGRxUVBRYTZr?=
 =?utf-8?B?RG9tYlFOWkFtcld2a1ppeHNEUVVVdHFmZldkU3ZGMDhuUVVuN0hoQ1cxT3Nk?=
 =?utf-8?B?Z1FWYXRXaDMrSDl1YzZ6ekdwOVY2SGNEM2xncDRQdG1TOUJIMDNvVE5hcE5m?=
 =?utf-8?B?SDVYR0NHTzZzSFBZbjNzUXZqcCtwaEljaHhNMUprVGJaQzIvZGRhQlJMbURE?=
 =?utf-8?B?TnRqNHdFU2VEMG5KVEV4L28rS0dSSEtjYUVXWFhEK09ueHJ1ZmNRYkNNbnRv?=
 =?utf-8?B?alhZNlFISHcrbE5qb0lrLzJTMlQrOEpaVk9wZzVkeHN3dVV2RHM5NnhVVFBG?=
 =?utf-8?B?a3FURlpkYTBzVHFsdU5HWElFVERUOUI4VU0xaVlDc29wUnR6RXcxNUQ2Qitm?=
 =?utf-8?B?cWNWVEp6M1NzMkhpZjRhR0NMUko4QjN4R0V0R0FaNCtHcTFiME1QUUVmek16?=
 =?utf-8?B?TmdTN2luMHorRDNod203aFpDS2h2T2tSMGhFTUVJYU5GWDh6NnNkUXhyWk05?=
 =?utf-8?B?L282aGR6NlBuaEs0Ky9JalV2WXZ6M2dERnErY08rNDVPdlV5WnNFMGd2UFda?=
 =?utf-8?B?YnVrbm5QcDJ6aUZwZEpVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1FCOUFOSVQ1dEtZRXRla3RFVGFBTmxnQ3VDMldEYjNHcERMdGlNRXE4T0Rh?=
 =?utf-8?B?UXVDSHNWWHBvZEhsMWEvVWgySUFqNnJRang4ajVDSlVqT2Y5cGRCend0UXpZ?=
 =?utf-8?B?V0xYQlh2TmdBMzNtSGRzT01yYlJSSm1jcXRCeldFWW4rcGt5elptbnE4cHhH?=
 =?utf-8?B?RkdpWGZTMHRzZGJ1QmVVWDlFUlFraWZWUEdsK05VRVBQNHkzWllRclV6bmlO?=
 =?utf-8?B?aWthWGlGNWRGalUzYk1BUVV4R2MvMWo4OFlPVndUWWd1Wjgwa0RzbjIyMUJZ?=
 =?utf-8?B?Q280SHpjUDg3dEpuNWE1ME9Obkx0SXJUS0VUV2tYWUtuYWYvNEloWXFzUG90?=
 =?utf-8?B?WEk5aUdtTXE0MW9zNW9lR2JteWVsUzFzbWpjbVF1bGwwTXRLa3A4STBNKzh4?=
 =?utf-8?B?WWlRQ2RzTWxJeXJyYXRuVFAweDV3blFZS3hCa3RaSjRYUVRZR1ZHekZpQzJG?=
 =?utf-8?B?dVlzL2orWDlHVDNPV016M0NWSUZnZHFTNm01WUdRRm1JVFpTWHMwTUhBUjRl?=
 =?utf-8?B?cU95eGxLYWxIR3hPeXZtdWIzRjc1QWxYYW8zMUkwckFUcUg3UGwrOXVZYnlS?=
 =?utf-8?B?aVZMSG9EOGJkUCtxNDRiUlJpQ3hXR3hmaVpCUFk2bGdxM2VDaWJySzRtUldW?=
 =?utf-8?B?S1EvNk94M3VtMmNwSGxVS2pTaHNWclJsSTUxWmRSMHlLTW80YnhjTHd2UkJX?=
 =?utf-8?B?UWtSak1tRUlEeUh2bkMyQk1OSE9RYWxTR1Nqa0xlQTRTWlZzTnROVTVqMkRD?=
 =?utf-8?B?dXpXV2hSTGo0UCttc3RCODB4dzk1TnYrWWRqd1BXVlNaMlVIVm8xNW1DV0t3?=
 =?utf-8?B?QWtPM1dsdjNqZUJsOG95OXpCM1cvUHNabm9VcmtGUGVJYjFhSVhNcExCZFdG?=
 =?utf-8?B?WURESzZqYVo4L2JRekF1aysxUy82NW5IcmREU0J6Z0hXeDBrQmw0OUR6eGRw?=
 =?utf-8?B?dlFwSUswQXd3VitVTkhEYmFEMEVCMk9uN3RUOXhPbzNZQ1ZlMkVrMkhXd1FM?=
 =?utf-8?B?WU1kNFVGR0hVQVBMUzd2UUxYRHpFY05tVVhlRkNtM1ZvTHlKMk5IdWtLckJr?=
 =?utf-8?B?VTdXaVZsaUQ5cytTTWl3VWZpUDNjTnU3Wk9nZTY1dE5HMEd6RHVHN0dqRFZU?=
 =?utf-8?B?WmZVMHZwdTRGdjFiMVA5VjFoV3psbG5Yd2w0Nk5LSndGYjFoNG1PWHZRSnUz?=
 =?utf-8?B?dEhWVjhRSEFJZXNsSlpBWTBybS9ORTQ5bEZIZzdoeHFzWDc0NkQzVlh3TERO?=
 =?utf-8?B?Z3JOQlFsdHVPU1FzaDF1L2ROdlVlcmpaWHdmdVIyM25GdXVZcmVoYmdHYmp1?=
 =?utf-8?B?RUkrUnhXVHdaWldZYXZKakZxUituWE5sTVVSelp6TE9jM0VhSnY5NmE3MEFo?=
 =?utf-8?B?SVMwSHlCcTl1K2ZYV01EeUxHNmQwandnSi9hTWxMdUl4bzlqYVBTcVFJTTN5?=
 =?utf-8?B?ZE1xa2EwSm0rdE1mQkRmTW0vNXdFOW5oaFVUa0thM09zVmZzc2lxcU1rcFhE?=
 =?utf-8?B?V0hEaUl5OTFySUxmdHpGSVlZSWNkN25OaXB1R0UwZGVnYkc5VTdaTEwrdy9o?=
 =?utf-8?B?cUo3R20vcEc1UnFWZGlFYk9SREFUcEJicXZ2NURXVFhNdG9US1lQQnFFOFJu?=
 =?utf-8?B?NHJEQkE2dSs1QWVYVi9uRVhFZGsyVjZ3Z25WemtkQWdvSSswM0ZTOEtESml0?=
 =?utf-8?B?YjJDWElKaVJxV1BsYWFldFNNRDl0ODFEVkZPYmNvR0NNVWtQNGdaWXBiZkx3?=
 =?utf-8?B?bDAxRHJSbUhpbE5pRW9PZjJyZWg0anlZMWQrTUltTStSbE5YYlFnU2hzMHk2?=
 =?utf-8?B?dUhUYnowQ05oVDFIV3VGZmRPKy9YR2pMUm1yYXZKS2cwUkpTNk01TnVrcU1s?=
 =?utf-8?B?V1RSSzYyWUVnWHJqOUhFRW1DRFhsdjh5UGd4Z21sZWM0YTJzNFIyRjVUOTdK?=
 =?utf-8?B?L3RTSGs0QUV1TVhRVFZheVpVd0xvODhaZ2ZrSU4zZ2hSaTY5N01xbEZ0bHpZ?=
 =?utf-8?B?Z0xWMjVxckpGaDFLd1hWT0dPUjhhd1NONDc3Vk5xazB5bjBPY05HUGNpa1lN?=
 =?utf-8?B?TUdpYjlxZmp2eENzR25iemdyT3VWRE4rT0x4YnVHOHFMUDFKYmxzbVMvVnBM?=
 =?utf-8?B?SitRL0FlejRsblVia0luRnlHY3N4YXQ0Ny80VWMwUUREcnNHMERlZktFZEZ0?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45381a8c-9efd-4937-0731-08dcc28be1d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:22:02.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP7kU3Wkc09zRqNlnDKjnosrmx+GHSDhaxVSr0PkV85o01Y9E9rH/TlNxCE60aWwovzq7SgJxiTnqTepRkEVQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3998

On 18.08.24 13:12, Richard Weinberger wrote:
> By making it configurable, iddp-sendrecv can act as a powerful
> tool to debug IDDP related issues in Xenomai.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  demo/posix/cobalt/iddp-sendrecv.c | 193 +++++++++++++++++++++++++-----
>  1 file changed, 164 insertions(+), 29 deletions(-)
> 
> diff --git a/demo/posix/cobalt/iddp-sendrecv.c b/demo/posix/cobalt/iddp-sendrecv.c
> index 6cec083a4..e2ee9ce15 100644
> --- a/demo/posix/cobalt/iddp-sendrecv.c
> +++ b/demo/posix/cobalt/iddp-sendrecv.c
> @@ -26,6 +26,7 @@
>   * optional.
>   */
>  
> +#include <argp.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -37,7 +38,15 @@
>  #include <rtdm/ipc.h>
>  #include <boilerplate/ancillaries.h>
>  
> -pthread_t svtid, cltid;
> +#define MODE_SERVER 0x1
> +#define MODE_CLIENT 0x2
> +
> +static pthread_t svtid, cltid;
> +static int mode;
> +static int send_delay_ms;
> +static int send_timeout_ms;
> +static int max_messages;
> +static size_t poolsz = SIZE_MAX;
>  
>  #define IDDP_SVPORT 12
>  #define IDDP_CLPORT 13
> @@ -71,24 +80,26 @@ static void *server(void *arg)
>  {
>  	struct sockaddr_ipc saddr, claddr;
>  	socklen_t addrlen;
> +	unsigned int i;
>  	char buf[128];
> -	size_t poolsz;
>  	int ret, s;
>  
>  	s = socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_IDDP);
>  	if (s < 0)
>  		fail("socket");
>  
> -	/*
> -	 * Set a local 32k pool for the server endpoint. Memory needed
> -	 * to convey datagrams will be pulled from this pool, instead
> -	 * of Xenomai's system pool.
> -	 */
> -	poolsz = 32768; /* bytes */
> -	ret = setsockopt(s, SOL_IDDP, IDDP_POOLSZ,
> -			 &poolsz, sizeof(poolsz));
> -	if (ret)
> -		fail("setsockopt");
> +	if (poolsz) {
> +		/*
> +		 * Set a local pool for the server endpoint. Memory needed
> +		 * to convey datagrams will be pulled from this pool, instead
> +		 * of Xenomai's system pool.
> +		 */
> +		poolsz *= 1024; /* bytes */
> +		ret = setsockopt(s, SOL_IDDP, IDDP_POOLSZ,
> +				 &poolsz, sizeof(poolsz));
> +		if (ret)
> +			fail("setsockopt");
> +	}
>  
>  	saddr.sipc_family = AF_RTIPC;
>  	saddr.sipc_port = IDDP_SVPORT;
> @@ -96,7 +107,7 @@ static void *server(void *arg)
>  	if (ret)
>  		fail("bind");
>  
> -	for (;;) {
> +	for (i = 0;;) {
>  		addrlen = sizeof(saddr);
>  		ret = recvfrom(s, buf, sizeof(buf), 0,
>  			       (struct sockaddr *)&claddr, &addrlen);
> @@ -106,8 +117,15 @@ static void *server(void *arg)
>  		}
>  		printf("%s: received %d bytes, \"%.*s\" from port %d\n",
>  		       __FUNCTION__, ret, ret, buf, claddr.sipc_port);
> +
> +		if (max_messages && ++i >= max_messages) {
> +			printf("%s: stop receiving after %u messages\n",
> +			__FUNCTION__, i);
> +			goto out;

Why using a jump to a plain return statement?

> +		}
>  	}
>  
> +out:
>  	return NULL;
>  }
>  
> @@ -121,6 +139,16 @@ static void *client(void *arg)
>  	if (s < 0)
>  		fail("socket");
>  
> +	if (send_timeout_ms) {
> +		struct timeval tv;
> +
> +		tv.tv_sec = send_timeout_ms / 1000;
> +		tv.tv_usec = (send_timeout_ms % 1000) * 1000;
> +		ret = setsockopt(s, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));
> +		if (ret)
> +			fail("setsockopt");
> +	}
> +
>  	clsaddr.sipc_family = AF_RTIPC;
>  	clsaddr.sipc_port = IDDP_CLPORT;
>  	ret = bind(s, (struct sockaddr *)&clsaddr, sizeof(clsaddr));
> @@ -146,26 +174,19 @@ static void *client(void *arg)
>  		 * iterations.
>  		 */
>  		ts.tv_sec = 0;
> -		ts.tv_nsec = 500000000; /* 500 ms */
> +		if (!send_delay_ms)
> +			send_delay_ms = 500;
> +		ts.tv_nsec = send_delay_ms * 1000000UL;
>  		clock_nanosleep(CLOCK_REALTIME, 0, &ts, NULL);
>  	}
>  
>  	return NULL;
>  }
>  
> -int main(int argc, char **argv)
> +static void run_server(void)
>  {
>  	struct sched_param svparam = {.sched_priority = 71 };
> -	struct sched_param clparam = {.sched_priority = 70 };
> -	pthread_attr_t svattr, clattr;
> -	sigset_t set;
> -	int sig;
> -
> -	sigemptyset(&set);
> -	sigaddset(&set, SIGINT);
> -	sigaddset(&set, SIGTERM);
> -	sigaddset(&set, SIGHUP);
> -	pthread_sigmask(SIG_BLOCK, &set, NULL);
> +	pthread_attr_t svattr;
>  
>  	pthread_attr_init(&svattr);
>  	pthread_attr_setdetachstate(&svattr, PTHREAD_CREATE_JOINABLE);
> @@ -176,6 +197,12 @@ int main(int argc, char **argv)
>  	errno = pthread_create(&svtid, &svattr, &server, NULL);
>  	if (errno)
>  		fail("pthread_create");
> +}
> +
> +static void run_client(void)
> +{
> +	struct sched_param clparam = {.sched_priority = 70 };
> +	pthread_attr_t clattr;
>  
>  	pthread_attr_init(&clattr);
>  	pthread_attr_setdetachstate(&clattr, PTHREAD_CREATE_JOINABLE);
> @@ -186,12 +213,120 @@ int main(int argc, char **argv)
>  	errno = pthread_create(&cltid, &clattr, &client, NULL);
>  	if (errno)
>  		fail("pthread_create");
> +}
> +
> +static error_t parse_opt (int key, char *arg, struct argp_state *state)
> +{
> +	switch (key) {
> +	case 's':
> +		mode |= MODE_SERVER;
> +		break;
> +	case 'c':
> +		mode |= MODE_CLIENT;
> +		break;
> +	case 'd':
> +		send_delay_ms = atoi(arg);
> +		if (send_delay_ms < 0)
> +			argp_usage(state);
> +		break;
> +	case 't':
> +		send_timeout_ms = atoi(arg);
> +		if (send_timeout_ms < 0)
> +			argp_usage(state);
> +		break;
> +	case 'm':
> +		max_messages = atoi(arg);
> +		if (max_messages < 0)
> +			argp_usage(state);
> +		break;
> +	case 'z':
> +		poolsz = atoi(arg);
> +		if ((int)poolsz < 0)
> +			argp_usage(state);
> +		break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct argp_option options[] = {
> +	{"server", 	's',	0,	0,	"Start an IDDP server" },
> +	{"client",	'c',	0,	0,	"Start an IDDP client" },
> +	{"send-delay", 	'd',	"DLY",	0,	"Delay in ms between messages sent by the client" },
> +	{"send-timeout",'t',	"STO",	0,	"Send timeout in ms in client" },
> +	{"max-msg", 	'm',	"MAX",	0,	"Maximum number of messages consumed by the server" },
> +	{"pool-size", 	'z',	"PSZ",	0,	"Size of receive pool in KiB, specify 0 to use system pool" },
> +	{ 0 }
> +};
> +
> +static struct argp argp = {
> +	options,
> +	parse_opt,
> +	NULL,
> +	NULL,
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	sigset_t set;
> +	int sig, ret;
> +
> +	ret = argp_parse(&argp, argc, argv, 0, 0, NULL);
> +	if (ret) {
> +		return 1;
> +	}

Braces not really needed here.

> +
> +	if (!mode)
> +		mode = MODE_SERVER | MODE_CLIENT;
> +
> +	if (send_delay_ms && !(mode & MODE_CLIENT)) {
> +		fprintf(stderr, "--send-delay works only with --client\n");
> +		return 1;
> +	}
> +
> +	if (send_timeout_ms && !(mode & MODE_CLIENT)) {
> +		fprintf(stderr, "--send-timeout works only with --client\n");
> +		return 1;
> +	}
> +
> +	if (max_messages && !(mode & MODE_SERVER)) {
> +		fprintf(stderr, "--max-msg works only with --server\n");
> +		return 1;
> +	}
> +
> +	if (poolsz != SIZE_MAX) {
> +		if (!(mode & MODE_SERVER)) {
> +			fprintf(stderr, "--pool-size works only with --server\n");
> +			return 1;
> +		}
> +	} else {
> +		poolsz = 32; /* 32KiB default */
> +	}
> +
> +	sigemptyset(&set);
> +	sigaddset(&set, SIGINT);
> +	sigaddset(&set, SIGTERM);
> +	sigaddset(&set, SIGHUP);
> +	pthread_sigmask(SIG_BLOCK, &set, NULL);
> +
> +	if (mode & MODE_SERVER)
> +		run_server();
> +	if (mode & MODE_CLIENT)
> +		run_client();
>  
>  	__STD(sigwait(&set, &sig));
> -	pthread_cancel(svtid);
> -	pthread_cancel(cltid);
> -	pthread_join(svtid, NULL);
> -	pthread_join(cltid, NULL);
> +
> +	if (mode & MODE_SERVER) {
> +		pthread_cancel(svtid);
> +		pthread_join(svtid, NULL);
> +	}
> +
> +	if (mode & MODE_CLIENT) {
> +		pthread_cancel(cltid);
> +		pthread_join(cltid, NULL);
> +	}
>  
>  	return 0;
>  }

Thanks for the proposal - but it looks like this tool and
testsuite/smokey/iddp/iddp.c become more similar now. I wonder if they
could be even united so that smokey calls this in specific configuration
for running the tests.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

