Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E22439012
	for <xenomai@lists.linux.dev>; Fri, 27 Feb 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208473; cv=fail; b=hEGPgcRabMs15mgGRkHDpSPSmZVl4rHvpnzKOTZQwuut5wNPSkT59FVomq+U9eBRaFhiLB2ZW0SKZLQlLyvuEirajlgZMwJmW8JVKj8d+Ykr0vtEZv8+JwdcdlhsyKgv8Ik1QdUgQO8nX8hqwabNtf3DNGMPB09a4eSnIw043Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208473; c=relaxed/simple;
	bh=46eM6MhqegSSSxRNocq85IFBXhIAN1Z3DCjpJ56Z0hY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoZD6wIKFXgiiYeAGKQPdxswuvDLp1LWtaWvgwDKPACN3r/2bbQruaWmU+oehiaaKSp5DkyJnJhjrooAvgVK1nBChoUoHooKCIucMAPlm/flEXZ6r1zFlKZ1lfQa/Ye7zL0jtGJk2LEOWT8IVHXRqckWDeTeSlFYFXsRzXRxBUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=R8rdRFQc; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="R8rdRFQc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHO9MZ+YAScyxpwm2hwR37Rps4lmrqBw/TKPKGc/wOxRuIjylqXWLnfDi1n+oYYwgAZCP4Gjsyc8/OEUMScVp1+DbhOIbsirKSU2sb73E5gKqZ53osp4OE952fWtYDx6peH0e7sCPSLpi9Eu9ea4H2nLerPTcx9Jvt4Cz3JYJDD5m7/wRmAGBlpJ84v/BBSePA2VhvQST5afYf8EhCYQ3PiVqdXROGOYV+Mz2g3F0iA8HjlhdExy5Ncpikn+prdMlv2JSYTW5hj/lmtmwtgqPcw1ae+AzNajOjzAkvph/4pmIGcu9u5j5Q1kEMLnBephTbt2FbfgK1crCK5ppwZw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx6kNCBs/wEr07KIGA6FS2Q3YFU3nzD2CwrAadlhrd4=;
 b=Qd8pUehDap0eeE362rBBdkBfDHDV+PQz0afFiCheIfa2MnmYZMM5ZRParLj5if7yFtNLHKmahds9MjeXZgI4SiyI/taX32EtKZ+rPV7J1jgNoIGYUBjpLf6HHAPolBGaSQTH99rV3hfeztQhxb95upuVlAz4eUfJx09aADPjHZN+edk/Enqez7amHIG0w9/AVA6kpj4CfpRXLOrzwKWKzztxMM2SbWElDDwkHZ3wbMNR+tUv2Io0HWqjWwqwTCipNUZ1Qmky4eMZBYYlspCIO18rlc/RlL9XqNjOP6hKTTQojHuOaOUMC7dkSjdL80aq3UvKBazmZU76UrPocgRzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx6kNCBs/wEr07KIGA6FS2Q3YFU3nzD2CwrAadlhrd4=;
 b=R8rdRFQcka+68EEaQ2vhTt044qGkiyLLRo3+jOh3ECt63cCvwmaeZ1CzheHIlW33YUKfl1LoM1b6819Iz49pDE0KzICaw4T2RB3EJG+ydH9t9mPYPCF+vEhTQCyT+FHnYTwbbJeGZqHKNxq1dzSFwI9O4PIHkIeMw4O1WsQWKyhL/4IJb/7lEmltEbMOqN7uCGnLm5x/eo/aM6Bh8CrVShwIMuXaxxwViGAVsZl60tLxxVF/yuVW3BJ9IPsAU33qulErxCFvM8J6f0g0Ay4VwtjVErt/p0QmU4PMjISIV8sO9a/tw74lV6HFg+pL8WFGqRNb3mf3hKi+qt8WFwE5tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB6692.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 16:07:49 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 16:07:49 +0000
Message-ID: <83e848e4-aaa3-4bb6-a6d2-7b2b6b4caa54@siemens.com>
Date: Fri, 27 Feb 2026 17:07:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] linux-xenomai: x86: Enable NETCONSOLE
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260227154931.2831872-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260227154931.2831872-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: add0baaf-325c-4f29-c83e-08de761a5a5d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	6jIz7fqIOUbzfCYuf5VIADYzb3gQ0zoVvicEF6iHt/F6hezIvN4rBn3jz5wprCPAcw+n94R546oo7RRYI/p1s0y0YozqSe/PioxzGjRGnRlpGuKhXuyNC0dOd6d59HElMmpI4hUH49cwje37CbEw5CkiOKXCSpeb4QpZWRnKQ7EdQKBZBl96FApevKaUn+5fTUGc1f9ldRKwRaTNsVH113fEAnt02Yj5Usm6A9TOygtnMyV8ydpbVwmlQbXwn+/+yLBvf4sbSXy6dh1s+4ZxsoE05aAkh8jPHmNVnTaGOxoxFqNqMu8zN1CaNqUzYf2zGVlpECyKZETDEwlfK9vzlWDW26ONdLNEKPkLk697ZOSbtibTu/HmiWONoXSmK1gEGWt52qTfKUiOzy2iAsnwtJef8C3BzyHmXbgolfeROrtiRBt6z2QOi28qEHQeXLhnkOplH9EaiB5kw48I9lJPpFp4rboUtT+QVCO6psewrg8bkD9AoOOg1F4Ezln7EBZPun0rBcJf98DVrABm8tpFuBfCRNvXE+CFVit4h7GetECpnvT5F7Ucaye1G4ZtIHg/y8I4RWKxQ4LHPX22/+E7nuTL7AcNBArHK2JWVUTge1QzTMWnJBNtYD1lVY2nxepdcc8DG2l6yg7IZKwoMNFmVWbefAnp2DsbpcELCqDkh9L6JwrM1oATtg7KIWPFhpth1wGaUPZKa5sk145CN/LzzG+Vq3j1rT474XNcy5fNbCI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFNWR3hVYTUrZjVaWEVUbHBEQjdXRlVYYUR3YzlnMytXU1IrZ2hoVTgwcjBN?=
 =?utf-8?B?OWRLNllMNndXSHcxb3NuU3RYajB2bkl1bjBmTi9vUlhsNXhVTHpDSmk3UlN0?=
 =?utf-8?B?STZrUGdTQWlFN1NTOXhJNG54S2NVZXpFWDNpSk91eXBtUFZRZkN6WnFjN1hI?=
 =?utf-8?B?V1RDWlB5ZDBGakF3T09VcUdmU1NLSXVkampIcXVObmRpYWZKYys2aEZTSHo0?=
 =?utf-8?B?RkZRNUlNcVpCZnk0dmt0OFU5LzByUkNTTlhXeFZVbDI2Wm5IcFhtd1RrM0d6?=
 =?utf-8?B?d2dwY3NsYnVlc1czTXRlVjdwZk83U0hPVXltQ0hFMDhwL21wKzZ4UG5QZmNN?=
 =?utf-8?B?Q2t6a2VrT2txcjNhZ1F6bUJxYlJ3MWMrcExYMjF6blQrUGF3MFRpNTNWendF?=
 =?utf-8?B?bER1QW9WOFZ5ZHRwVDVUbTVMeHFuWElETGRTaW1wd1NNa01jV3BYalh5bVV3?=
 =?utf-8?B?SHo4WndvcVFsQ1pOajRXTnpDY3FYeExZK2NxQ3hEU2lnMlFmc2xSL2ZCNjI0?=
 =?utf-8?B?QVJRbU9abzBHeFVrMlNKNmZOSzlRdWJQUlF5eitrYWlGb0ozK3JTN01DVGFv?=
 =?utf-8?B?K1hpZXR5cWc1VTR2ZktYTEIyVndLZEhDZVBnUk81NFY0aVZ4MmJnMkczQnhU?=
 =?utf-8?B?cUd3ekFCdUphRUdhS1NPbkVhUmY4bWZpM1BXVWdpZUoyVFlTMXNOSmNkYzNo?=
 =?utf-8?B?UGhTdVVuY2JXNkNhTzZzbzlPLy8rekg0SHh4ZmFadTJaOGZGNWVnd1loUkwx?=
 =?utf-8?B?WU5VeG1QdzdEclZvbndRQWExejNJMGxndllDS3lCQTM2ZkNERnBmaTlLSzls?=
 =?utf-8?B?UXZESG1CZGVmRS9wK2JXdG1qWFhxMlVNK0lYekpDdElCcHBITmtFN1cyTkhw?=
 =?utf-8?B?enhKbUM0b3NyQjhlejBHQ3ZKMFczSTV0L1lzLzdlWCtjS256TnJqeUt1cTZE?=
 =?utf-8?B?a1FkUnU5NWFGVUZ6U21YZ0VmR04rUTV0aE1ZVmkvS0RaRTJkMkQvNUVsbWV6?=
 =?utf-8?B?cU5kSVFLcmF4VkY5R3MrYnZNM3FQY3R1c1ZMdElMWmEybGEyQXQ2dXVSNE9i?=
 =?utf-8?B?UUQ2N2JEQkQ1VnJjNmI4WWhud2hZR0dPUHR2Q1ZWSXNRd1VpRUNXOWsvOEsz?=
 =?utf-8?B?eEg1NmI3OFJhWDhNZ3pLc0IwQ0VjUExEV3F3d3diTmRZS0tOdWZVeW1OWmFz?=
 =?utf-8?B?OTB6STFBY215YXJsUzZrcG51c1VzNVR5TXFobHBBVXlnNVBvYlhsVy8xVENL?=
 =?utf-8?B?RThrUXJuVVRiRk5KajU5aEoxS3FHVndzVEU1NEZOYXlQSDRuZUJoMnhMNW5j?=
 =?utf-8?B?dnA0Zk9qSDh6Ri90VVdqcXdkQkZqU3pjMmh6RHJibFhVQ0V2K25sZXMwZC84?=
 =?utf-8?B?KzJ1NFA5K3Y0UFZaYUZGQ1BvUWdZdUVySjVlakJFaDVBTGpKWHFTdC9uQzBB?=
 =?utf-8?B?YUxXak9CeXhrYlZRcVgwa25yRGdBSndBdUZDRnMzbEI3cFpwb0JlMVNhc2sv?=
 =?utf-8?B?UkVrbGc2U0UxMzlWNlFIM2lWZEpVelA3QUN3RnVoZjV5WU1qWTlSSEtGdEVV?=
 =?utf-8?B?UzV4akx6WEptSHd0RHJURzNwanBIUnZqbXpUUElpdEYySHFwRTNXeEl5SWlQ?=
 =?utf-8?B?RmlYNEhKeWNjMFpWL2s1akUxaHZHRC9yeTVlWGJoVHFuZ3VZVFNPcnd5K2pB?=
 =?utf-8?B?elFtalZXYzNJeFdwcEpRbi9aRHRyVEJwUGluTGMvei9mSEp3WU40S2ZQM0xx?=
 =?utf-8?B?eU94bW5kQjZEaGdKQTZwN0o3b3pYVDMzODg1YnpHU00vTm9QcmFNdDErS2FF?=
 =?utf-8?B?U3VCVmlHRjBuYjdzWTdPMHdsVjVlbWlHTGtHaHQrdjNqZ0RzelRaTXBQMUx0?=
 =?utf-8?B?cTgvaHpuS2M3emliYkc1WEtGTnl6VkFtakp4a2pRWUJaZHVzeU43ZmhJNVZq?=
 =?utf-8?B?L1U3Y0FUT1dBYUVRTXh0bEZqakdUTkJESUMzelA1dkUybnF3bHhNN2ZDMVVp?=
 =?utf-8?B?c2ZXam9mTnRXMEUrYnAycTVraFNIanJvSkdMU1JjQTdhZDZGVXlIR3RMU01z?=
 =?utf-8?B?UWJBQ05vYS9QbDVCQmFKamtDMHRNVmduZytQUXdFYnJKTmhxN1pvSzg5dnVm?=
 =?utf-8?B?bmZEUS8wU3o1bkhJWnU3c2E2cHlRWEx1V09MVWl3VUN2b3hHMU1HajJlVFhx?=
 =?utf-8?B?QzF4Rk96QkFoVExpb3ZrdXNnMGdLNUlJMjhqLzA4TFlEd1F0NS9rcjU4aExH?=
 =?utf-8?B?clgwQk1GejA5dXJJYlEyNlJXU1JPRVNXNEhLeC9IZCtZUVREcFE3RVZGZk5Y?=
 =?utf-8?B?cXBEZXFONEFaOHlMTFlhU3FHQkdodlRJNjE3MVYwYlBxRFBvcXhFUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add0baaf-325c-4f29-c83e-08de761a5a5d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:07:49.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zY+ulePRJWj3HwmhevfEJCVN0AnvFxRfi8hplRu6NipQMZ5QIbAuvsjnqxI1HDxdqIEFqyfcs+0Ub78TcWCGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6692

On 27.02.26 16:49, Florian Bezdeka wrote:
> The e1000e driver has some dovetail specific extension that depends on
> CONFIG_NETCONSOLE. Enabling NETCONSOLE as module helps to detect build
> failures early.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  recipes-kernel/linux/files/amd64_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
> index a0a516f..23170ba 100644
> --- a/recipes-kernel/linux/files/amd64_defconfig
> +++ b/recipes-kernel/linux/files/amd64_defconfig
> @@ -1791,7 +1791,7 @@ CONFIG_NET_FC=y
>  # CONFIG_MACVLAN is not set
>  # CONFIG_VXLAN is not set
>  # CONFIG_MACSEC is not set
> -# CONFIG_NETCONSOLE is not set
> +CONFIG_NETCONSOLE=m
>  # CONFIG_NETPOLL is not set
>  # CONFIG_NET_POLL_CONTROLLER is not set
>  CONFIG_TUN=y

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
