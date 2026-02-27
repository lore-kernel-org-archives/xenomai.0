Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC23EFD35
	for <xenomai@lists.linux.dev>; Fri, 27 Feb 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205758; cv=fail; b=IJr9YgMXdbDIbYuTr/ZPFbupwOCvCZWluUMd730XjgtWJZQjF5v3QjxwlcaKMGr15ycHQYBt5phRsDJGa7biGd9tKoBx2MXeiQUcfSagUfjB+L3b0NomBsQ801TP99OHxsCi/yCVic8npD4goXT2ee9H/4dQCKVCNpGRK1LVHZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205758; c=relaxed/simple;
	bh=mz/FOr9Vw+JPFh4mJTHGp9mgIqJNPG+5Ll+p86I8myk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qgb54CuiCMphJC3eSvMQE/vdlWxA0J+9aoqcLEZvrSWu42QsftAoZWuGpKyPT04coRF/+jzO024wrWyIe4MnZrM7zRNP4pj5Wvq0W5srqF9UQ7n1NaE9iMVq6A3xNV1iBZmyjfhMbb3wzF2Ymq97L7vaSi43v25yQqtlj7WmkPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jJjnsLwn; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jJjnsLwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw4oRcurRe9ehuq3+FDVY4kB+Kitvd8k3Kxi3YJ0C0Vh57h1B2oQzTktPqdxoqIwcaMtApj2yHJaiJgb5yhbQQXQlo9zUYqc7/JhVYvDMt4ve8VOv0Go4iOBetZRKO6J3dgLD31ZMzBswnGXVMZFLwgOscMlozOPiNdMoEDJNp4B3cM0+yPJPrpy8vSfM0rB6PuNU1LrTWd9ER0s/nHz+WHJcSUojUDgjjrJroBQvUsnO8AZ3OdY4nPF1UkOZ7tNhekzN+C6XJ4/tR14mpXtOZ+PFagbaiEoOmz+0WmV8lZaboAptMbxA6tZID6N2LZXQ/+pGrya3EQ8ccgmbP99Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4b1Q6XNkcP69lDsuNRM4ml6qLyrAudz2Nel32hfQu8=;
 b=SzFhRGFGOW7b2vtqznaDzX0mg4evLgKm6U9R4cSRIEkJc63/VSV8UewEKCcqXn049JK4g5sw1PPOdOc2Uzya91R83gdtl3hrgp50tqkzHZ+lGbwYn4MD3rcODTVn6YdwgZCd6oKxriT6keiG5cWA7EIepNbcW9ZWiVXRdiuv+W9K0NK47zH5t5VzTd7Ib08QaJtlOXXKFY7oQDcFyagzUbU6r3cmA0s++Mwz4az+pUXdUJeicT/iBEn7Yrxj7XP8ERHjlw/kUinqtE8HqeL/FL6ZM75mCrex9gXpsxER/jw+0etj3gNAvKXO5c/iU6I+Dge47tiHIt97VYwidfLhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4b1Q6XNkcP69lDsuNRM4ml6qLyrAudz2Nel32hfQu8=;
 b=jJjnsLwneJS9v+uc2jqlqQOpi9AQa1dJSlFcW3rlc+Jd1DY4wjs+b9qVtjWGcFK9Yu2PPatE8Y8GgdGjdZWrTp7Z9NmvAidu2iMy1ckqYqQ4dUFabuLvK98JbEmC7ih+qgRdWEYdNSLGL1sPeC+/pB8VUaFg7zPZmf2jHi+EIESC3e4XLILXUjLvKyhTYKzwsAoDIzSSTBVFWg1zINNCk1T36ma3zFukZFcpNikd0zETxNOFJ78UCpq3bRG/e6cdyB2xcVetOiDnlHMt0z4N9GSgfhTkexR51pKHiupSMPIRTjo8NjwBRdL3SxzL4vdJZcAHQifxX925Fc/7MAMs6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB5897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 15:22:34 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 15:22:34 +0000
Message-ID: <14d7f591-075d-4521-8446-b90f22701e7c@siemens.com>
Date: Fri, 27 Feb 2026 16:22:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Prepare for Dovetail 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 67eca470-8c4d-4cab-1337-08de76140811
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	G300hLSbrESypQ0mOKivk7BE1Y/ZxjHQJwxYcuK+jlGE1FMPPDCd8fbviERnStt8RY8x4R1xAyJ24+npOcIuVFCbdneT5lZy7u/K02qgsazmSNDs95wNAh3Hh02N5cbfHHYA3R9hVeSQ1z96UkVp0s/K3Q9w3ec3C5R2V+JsALKBQ6mEFpm8u1b2/Zk5tb9KbKMPT63kjUn50n8sRWYYuR/+r2/g4Dz51Uz8iiaK+WZSeD5EsrSlH1W/yuahO362dSQvmECYxAxvB7TOKVKtVJb/CRM+hXrglinmhh//iJSfTZBZa4K4HSWpRLxcS5QCGnVTurvZLq4OnhbCtOeTXcs2UhPAqNYRtExVe8IMuQ0PY9S+GsOBU0in4f8ZwDJ1MoKvYmvtcnd/xhhtQ05BUf5ebcoW1i+zklOWz/7RkJRiofCesgeFLkOQE9HGWhyyCPqIEM643NQNbfsIsrezIoWCZO5mSRPiF7QHw6aJUQTvycwnPw7vSHGNLMFzxJNAk7AAWfBe8Xe01U9gF2/9bHbgXxfDpcKlutwYbD78cm6GCSEWAW1DgD3m2U5GGzwUHr6WTKTXcUnC5cKlp6c9PEuouY0yJpNIRnze2nQT9gqtvUxAQssTySCmEamPm/dz20+aHyeR0jo8sOsq5XQ5FAlKQ6OBfqI5rQzAB/3nY6vrcNuYoUA4aBvOEfZ3cfvj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGE5N0ZLK2U1RENkLzgyM3p1S2NRUkhhR2g3VUxhaEZZS041T0xDSDJ2OCsy?=
 =?utf-8?B?NUcrWCswaWVqd2JCeVExWDNBdnAySWk0SHptRlY4amhJdkpwRzZ3VVR1dERn?=
 =?utf-8?B?OFk1V3B5QWFXT0JtTlo2TjFoejR1VEpjcFdtM2JZWWMwZnRoRGZ0dDNDWHBW?=
 =?utf-8?B?YnhIZUVYL2MyenlKa3J0KzJYbm1IWEkrTnpPVS95dWkyTE1tclg2TnhhZm5Q?=
 =?utf-8?B?YUNLdDZBUUNjSXV6S1YwZFg1aFl4SGhWd2xrRFBCVmlScVNZWk5qZnhUMTF5?=
 =?utf-8?B?ZkFkb0JuZ2VGWFR3RWFwNnVHWS9wUStvM3pOREVtamJ3ZWtCdmE5RE5sZGdX?=
 =?utf-8?B?S0FWVTB0T0hobGszQUVzREhPcEI4MTUzK3RZUmxmNGo0aG0vMGhtM2hWWGZt?=
 =?utf-8?B?bldCTk8yWjVUTFRQNEtEalE1UVlrV0xmS1J5NU45OTBWQ1orV1FvaGJPYjU2?=
 =?utf-8?B?NDFaRlVGWEI2bmREQTdWdUtmRWZsUnR2TFpyTnhWQ3ptZ01lMzBaMmZSc2VT?=
 =?utf-8?B?MGdta3E5OENRUjVoTEJCWEkyUlNtU296U2x1cWRwMktJWm8xdktDZ09jSFFU?=
 =?utf-8?B?VGx1OHJHTWJ5T3gyQVljT0tLbE8vUHNKWHhaN0ZZUi9lU3h6ZHZpdWpsMThj?=
 =?utf-8?B?L2dGWjdFVUZhTE5wNWZwSDNKQk5NaS9tcVQ5SEhXOWZ1Z01DYUIrbTRsYmY0?=
 =?utf-8?B?bjhvejJyMWV2bk9MRHQ2blBTMjdBUGxkbFVUZ056M0xCSDhtMy9wTjBPSXV1?=
 =?utf-8?B?THRBZzhlMVZRWk5xbHh4WXhWemdpdjlVRTVyYkFsb3FKcjJSeTFqaVJueWhl?=
 =?utf-8?B?WjJIUUYrVzNLU3hTZFFiNjF2RHJZUWZQSlVVQTI2QUltelZoT09HcDdwMCtr?=
 =?utf-8?B?aWFRVkEvLzBoRHRjUXdycE1GUC9vYWNxM2w2TlUvdFB0emdFaysvODNqUmkx?=
 =?utf-8?B?cEdNVHdRTFBlaVU5WXp0enk0Q1BROHlCbGhWRU9jRE8wbDFRS3k3cHB0ME9x?=
 =?utf-8?B?ME1zMzJ5dll5MTU5STZHWExxSitCR2wxaUZaamU0YjZxOHVoRUxHa2xUaFRq?=
 =?utf-8?B?OCtsL0FJcjdnZ3ZBMkZoaXhFa1FhWW5IMjltZ0g2MlMyRTdEVkZxSU5VOUpN?=
 =?utf-8?B?Ym03UTZOQXlGU0FEZjRiSVQwNnVXbllTclBCNC90eDJKdHFyN1Y0U0pLNmxs?=
 =?utf-8?B?Zyswc3dwZE5NVmJCVHc5cHhPMTNJTDQra2pXSFZCbEVndU95dTlEK21uMVhz?=
 =?utf-8?B?VHRVeXJBL1lnQ3lpR0JwZlE5UEpCdGdwZys0eFlRVjRhaG9nbVV5NnZZSHhJ?=
 =?utf-8?B?SGxpems2UVNvSWt4QmwrY1RlRUF1SVpCR2g3aWhnai9GUjBxbWx1TmVpVWl2?=
 =?utf-8?B?M2JHeDRiUWJkMEVkT0VncWtvUEFwTFA3L2FVcHpGN0JhUUREcVVEaDlNa0hY?=
 =?utf-8?B?VGlnTmJ3aGhqanpaUzBiOTI2YWkwOVJiSC9LMVJzZFFwM3RBMnBSQ21pdi9Y?=
 =?utf-8?B?cTRpWEJuK1RhSXU2WWhOdSt2U1BySjFwb0N3aS9QU2pCc0tacVpDZHRtbHZo?=
 =?utf-8?B?UEhOSk9OY0V6NUZQY283dDB1bmRGUzRuRVJmSWJoK2lydFZGYmJ1eU5MQmtE?=
 =?utf-8?B?YU9lNDVaRmQzRFJ6ODhXTml2Z3FMaVVCRDc1T0d1bkhqWHBMankwSXM0Zloy?=
 =?utf-8?B?WFV0dlkxL1NvaUM3b2NjMHdpQUFycVJuNmlPenBlcWVpTFN1cGxaTjlpMzlp?=
 =?utf-8?B?R1ZaWXlOaWNRdG1GOCtzdk1HUVpWS0tVNjIwc3dpYUhQSmhsSmRMbzlHSHJL?=
 =?utf-8?B?cU13aEZDREwyajVuL3M3cCsvRWJkNXJScHZEYmswb0kvQVEySFVPaldTKzZi?=
 =?utf-8?B?WUcxZ3RudjhjTElzdzRqOGJsQmc2azd5bzhJOGplM2p6Mnp5WUxTaXBoQ1NM?=
 =?utf-8?B?Ky9TdEN5RWluSzQ0U3hISVBWWmRISjlNTFVMZWVuRkhZdVA5RHdPQVk4d1lx?=
 =?utf-8?B?ejFreDJXNVVQaC9qRndvTndSZ05XcjEvalNtMEluUytKaDVtenc3b2VQWk95?=
 =?utf-8?B?WDVGWWZUajdCQmdVRXV5YnVPUE5kdUxwZjZDbUxPRGhGdXBKMGtjSnRVVWdj?=
 =?utf-8?B?K2lBR1Z5Y1R3QVJIdk8yb1EzN0JtWHBjZFNnQTJEWkZPaWhZZW1HSzRiaE9R?=
 =?utf-8?B?NHJKM3cvWTZ6R3ppWFc4NGMxOWxkVWJHTjQ0QmppUnkwM1JlejYzVmdGSXdN?=
 =?utf-8?B?bFlOQkpiU1Y2UGcxd1RrcXVNL0xjdkRydjFwTHVzZ3VTMlJNSVFFTER3V1pV?=
 =?utf-8?B?SW9peXpJOWdNeURCNUJGUnVTTW1WSGpoSjBZTkFwei9qZjlVZ1duZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eca470-8c4d-4cab-1337-08de76140811
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:22:34.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9KOgOoINET1kAXuU0bLkB72Jg6jTJqqWO+HG/M1tjSDiYdnXb9S6I78DOWZN7grXlLdPK0zUpPAYm0l3gqt9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5897

On 26.02.26 15:37, Florian Bezdeka wrote:
> Hi all,
> 
> This are the necessary changes required for being able to build Xenomai
> against the latest Linux / Dovetail versions.
> 
> Dovetail 6.19 is currently in the making and already build / tested
> against this series. Without this changes the build will simply fail.
> 
> CI tested against:
>   - Dovetail 6.19 (one other build issue remaining)
>   - Dovetail 6.1
> 
> To: Xenomai <xenomai@lists.linux.dev>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v3:
> - Move all adaptions / wrappers to wrappers.h
> - Add patch addressing a include order problem leading to build failures
>   on arm64
> - Address review comments from Jan
> - Reworked some patch descriptions
> - Link to v2: https://lore.kernel.org/r/20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com
> 
> Changes in v2:
> - Rework patch 1, switch to cobalt specific API for newer kernels 
> - Link to v1: https://lore.kernel.org/r/20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com
> 
> ---
> Florian Bezdeka (5):
>       cobalt: Prepare for new signature of __request_percpu_irq() in 6.19
>       cobalt/time: Migrate order of includes to "from global to local"
>       cobalt/kernel: Lower impact of wrapping for older kernels
>       cobalt/rtdm: Prepare for new signature of mm_get_unmapped_area() in 6.19
>       testsuite/switchtest: Add support for Dovetail >= 6.19
> 
>  include/cobalt/kernel/dovetail/pipeline/pipeline.h |  8 +++-----
>  include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
>  .../cobalt/arch/arm/include/asm/xenomai/fptest.h   |  6 ++++--
>  .../cobalt/arch/arm64/include/asm/xenomai/fptest.h | 16 ++++++++++-----
>  .../cobalt/arch/x86/include/asm/xenomai/fptest.h   |  9 +++++---
>  kernel/cobalt/dovetail/tick.c                      |  7 +++----
>  .../cobalt/include/asm-generic/xenomai/syscall.h   |  3 ++-
>  .../cobalt/include/asm-generic/xenomai/wrappers.h  | 24 ++++++++++++++++++++--
>  kernel/cobalt/rtdm/drvlib.c                        |  3 +--
>  kernel/cobalt/time.c                               |  3 ++-
>  kernel/drivers/testing/switchtest.c                | 18 +++++++++++-----
>  11 files changed, 70 insertions(+), 35 deletions(-)
> ---
> base-commit: 363115d15682076ea0766a55c3c5b1eed87e1225
> change-id: 20260212-wip-flo-prepare-for-6-19-8fdbd4c58225
> 
> Best regards,

Thanks, applied (with minor indention taste changes in patch 1).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
