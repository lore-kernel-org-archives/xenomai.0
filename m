Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9643EA66
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500128; cv=fail; b=lLy/kWsF17egf0QoSrSv/wVLm3vIz71vkLkSE9rBkhUzQgvT9QnXUVByfWwW6W7dXZjX4kI23d4ahiS1pe30+0GLa1f0486SR90oeCYXP3MGV6igiuo4mb1/bxhG+udJmFGVX3hFl7m9zdkxS+u2PJex5tCVrq3ggfielfkAYP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500128; c=relaxed/simple;
	bh=37/D5dXWf8ZUbx+p/RvbBe0BuQyZYO/tERp1mSvT7Fw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FTJrD21ENCaw3qcp+41c6g1BZDSVFFKajYdMo45tRhq7Stjs0vpQQOghtgEiTMp6Ae7cySFnerwgAink3PObkyAJ2ae09JJkaJHR4B09xJ0mGHS3gdSctu1vbtJO4BXoOJd69zbjYKC1u0GAWNCgNP4c7Q2faJErdnzRnvM83wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zFjNL1X9; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zFjNL1X9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHCiJfrfAdjEBfqhinwvzAi704QrHeH20Ut4plkyokGetWJt3dI8brUKMdpfoSTQNGHPHnZ5QVRz9qVqQOZpZ5vo+Jfwkw4SEku7V+bf4VoCRs+ftH6pWc9pBjKM3dMYVYLWYQF7z75XW+qygV8rfjh3dulTzOruom3nvlZcwCcYTB/Y2dw6cfTZTj3HOAlQwwBC/g3VrZcdNF2afNlbcFvt0/XWmIpIscSciuQlhmA53xsiRMnnTX75u+Mm/Xv0QeV2j/mOP5CqqlY0BLSKYzHPbHrlZGp47Iy4N2lgn3sG/WnpJviepgv+fUidSmq68qSMqaqcbBiPU6dQ7gEZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP32RN2IlV0nR9gv1CItVlKHgaBam0kjfs9JotEv5do=;
 b=jsFEzEpzZerKtGSNTQAe4d9Vsxl8M8eAdXcvyafCSWPu6Jl4xBfgopZGIRrm6LUo0QzA7xmI772+6whqXGt0kY6BY8PYsXCfHsTp3Onwu99PRlxxI97nolW/eM60eUZRANQQGsV1+UOQL165I9jsf2K6d588gT6UpuS/BY4Qly3Knvfa+35sYmtz4iymNHcJgM1r6cOjjI5pw+DTVe9uRh3BhElXg8/4OYTkol87rQm80jSP80o9LXnXJ4BQEmebLH3SDv/NMGNkvTc9rQgweIkwiFqc3ayRv6eiANNr4M7HGiCC66hZ1/HHH596HchNM8kEJUKCVsF4rmheHBCvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP32RN2IlV0nR9gv1CItVlKHgaBam0kjfs9JotEv5do=;
 b=zFjNL1X9vzmFy2IgVAV5wvEumBm+mNSMw6j206jtjO0U1tQpom87Ps37LVmxU5f6NqbWSxBPg5oCpZVOwz2z5EGwc4CiYeBWOrJDFoJgp57NWtPanCYlI6Z2BVcK5+aDlDudrFr4aorRSVmb8wMCgIj2JB4GoAehsP7WSN/0V7WrJCxLyjnViapTqBXDDmFhAUQStUom90gKUXhg3TuwQkayGxy2SdBQMgW6YQ6yTyUq+34+d/KoDwvQj/jR/HxO1MaUiQo4ZJPQbQhegTP56ob34ytEt0mf97W/N1d6RrxgFAYTRvBZZjFA6mvYz0KMG//25Otf+ys+CGFPienyaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3975.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:08:44 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 05:08:44 +0000
Message-ID: <e4e17554-9101-413e-877c-fd4917212509@siemens.com>
Date: Mon, 15 Jun 2026 07:08:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 1/6] Kconfig: Permit to enable debug mode
 for Xenomai 4
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1781428654.git.jan.kiszka@siemens.com>
 <f4ff8f75dd3ae44a85beb8f38391720e8760108f.1781428654.git.jan.kiszka@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <f4ff8f75dd3ae44a85beb8f38391720e8760108f.1781428654.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3975:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea0e076-0e8d-4e39-a1f1-08deca9c2c4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|23010399003|6133799003|55112099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O0uWrwM51bJyGDQn8NML2haKP+kCB52Lg+WIAh3Sn0iLwEZ00FFF8YkhqwXx9JZLFG7p3VfFPhEOhT1fiO7YFT1cUQndqLz2WN0pAlTR3TeIrqAfaw4cQfPl9E7AQqYUwp3LBnHKL56lS+vbD91JUNYAsD0a0mvqA9SpyS9hY/pce2jwEsWP/SXGWAPxGF/3H888gwTeMEyhOVycB6/FHVh8jKDyhW3Zb+OW8/+w2IT4aMuqPu2Pyduu4kjZIn6YejPm5xptCP32KB7TMppre+rixmWXSJBwSmfULx3meDJLdM6R1bDS691cD5lHOPeXhWvtdo+VTKRdbNAtvNKBWHcWqnGnVfqNqpa6TAOrPfZaX0oYjzhzfB/QCtrxltqSt4olmpz3rWotCvLZwxcyU/JrMGShL/zKuel8c+lRCvsAsyxb6RkOl5EtzvchmE3tL/5CPx5ZAMlnYco2c8yuCUBD/Da4dVcq9ave0CwrOSknB/5E+gG/u+M0/VeKhQxAuQl+KQeubvu/cTRYgKpyEbA0xAemHirVUYPIrbkNSzkikS210h/b3euUItLxQhF5Ljn7rZlUixjQGg9LwTMsXtr/igLxg/Gg58dvIRptfSzlhIuWkO7Mfrud1c5HPLdawM4gDtI+PnW+s8ErseapRYMWEGOFaunxIavUCCx8Dt72H32mxHeb5SwDcmQz+SKN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(23010399003)(6133799003)(55112099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJjbUNPaEd5QWdSNXp0Y3dkQVp6VG1nMzhCdmh0Zkgrd0tnUmVMYU9EcHRV?=
 =?utf-8?B?Ly95VGJHVVVTYnJhL0d4TmZjUWNKcGwveEVrNmU5WUkwSGlHVWhqS1ZCRlNi?=
 =?utf-8?B?clI2QnZ6NGFORysra0lObkg2ZnlKekNhdHpwV1FWSzJyWGFIUUo1Z0JDV2JW?=
 =?utf-8?B?UWx4VkFFeTlFR2xlQ2ZkRXVheGhzQ3lpUUVldS80R3ByOUd0NnlZWFJOQk1z?=
 =?utf-8?B?akhPa3dJd3lzUVcwaWV1QldJaTl6VjhicGY2RncvaXY3UEthZTduQXZ3TmVQ?=
 =?utf-8?B?SWxpWXU2QVYySk9wR3NqOXB5dDhSWGZLaW9LeXFwUDl6QkNRVW5GN01iaW9p?=
 =?utf-8?B?WDRRSXJ4Z2RtZnhBNWIvV3BWd2xSWC9ZSkdtdTViSy9rNy9RQTZHZFJ4V3NR?=
 =?utf-8?B?dk1pbUwweXlNaEQ3bVpDWUlnSnE1Wk1vWlZ5VkVFMTZEZGhDdXdyR1B2OEw2?=
 =?utf-8?B?WS9RVHIvVDZrYldxaWhBaVhmYU0wQTFGZjhSR0tibEpiSnM2T2FmVFZvRUxy?=
 =?utf-8?B?SHFuYUc2TkpqZjc5bkgyQTU1TVJUQTlNVXlvZ3ZvbFdIbWE5Q3FobVF0bFFC?=
 =?utf-8?B?bUFrOWJySWlVVm1yZnFhRG93Q0k4Y3lFWTVKRDlTL3JuY0xBVjJEN0VzeXNS?=
 =?utf-8?B?NUlmNk56MlluVllVZVNCTXREbDBRcW1YWjVWSEZpeEQ1eWRzTGtjK0w4cGx0?=
 =?utf-8?B?QzJQRngzM1JzVHMwSHlmMVhNZGlhTURGRUUyc2RqRXliWEdEbUZ1d010dlVx?=
 =?utf-8?B?MGNRaC9ZcW91RzRQVlN1M2tjcjQwSjVMc3BCQlNieFVPSnBZeXlUVUUzWmtI?=
 =?utf-8?B?UUlyZ1c4QTRxV0d6ZTBBYU5SL0I5UU0wM0dzWEpBd0tEZFRCQU5vWitMcHg1?=
 =?utf-8?B?UHNoUWdWbURoWW1zRGpiN2VrNTdyWDcxMGprbGpjTkFsZ1NmL0UwMVpMN3VJ?=
 =?utf-8?B?K2RIL2tIazMzS2FPQ3drdEYxMG4rNTVPUlA0bjZxZjFTV090NmhYK3F1UWpL?=
 =?utf-8?B?UVB0VEQ2VWUvaVg4eTdacGMvck51WUI5UjNqSjRHK0lsL2t2NHJvamE3ZU1v?=
 =?utf-8?B?bG0vb3ZmMHZtSi9neDhWU0RaanJ5bDE1VXZQeXlESkRKVGt2bWFpT3h5bHBU?=
 =?utf-8?B?N1duMDZiUlJNUlNKa3VXYTcySFQxZUNSWVE4YWJRaEdHTjJxZkN1VThNWGZQ?=
 =?utf-8?B?S0IwRkZRV1VrZDVEMFYrUzdwT2xJWVhCcUlQekppNFV6VkJ0dlNLbGtScHYz?=
 =?utf-8?B?T3BxSWVXTm8ra2NYLzRIczI4bHBlV1h0Z05VZHBLd2p3d0lIZ1k1SkJkbk9T?=
 =?utf-8?B?bCtMa3ZoNVY0WUF2dEYxL3NhWVJpc1MyVjlwK1VLaTJtVTB1b1hQc3ZiNE5p?=
 =?utf-8?B?TGR6SlVKbVRYVFRJdnRrMXBkMjZlUGZmbjZrSkNoblFscHBIa3NjT1NjY3V3?=
 =?utf-8?B?SHhRSWlqeS9XVzNtV1JLQjVySnNEdWNZVnkraWVtdlkzUGNDaFdWY3MvMzBj?=
 =?utf-8?B?bXNWSXNSVFQ5K29PaHQ2V29FUmVRV3BwWmI2b2MvWFpvMHlUVGxCcmI3Y01x?=
 =?utf-8?B?Nk1aK1NmVHd2UGJzM2ZudFpqc0NabDhxaXNtbzBOc0k2dmdwMlRrNzBYdnF3?=
 =?utf-8?B?cElURUoyNkRRbmJMZFhQcjBVZDBJWkZxOXZNcHpMdkRneHpveFB1T3pLaURh?=
 =?utf-8?B?aUhyMzdyMmVrbHZKWldLeEQrc3p1aEpaZVhidUV1bXE5T2g2T0h5UzZPcW9j?=
 =?utf-8?B?MFR2ZGZLS0pGQ0RONHo3TGVTWVVubnNpUWVKN0k0UWRsZjRhaDRSUU1waGhS?=
 =?utf-8?B?ZzBNbWRrWHVjQzF4ZjVrVThHTTFOS3hFZGdIRUwxekwvMzhXcUlBYndwL2kr?=
 =?utf-8?B?L0lCWU9LTkwyMWpUM3FSMmZLYklnaFprWjByZ2N1YmpicjJldTdiL28zV2dn?=
 =?utf-8?B?b0tmbkttNXo5OERrTE5nbG5vbmJlUzF3Vm95UE5yay9iVnVhZ2h5VnRjZys0?=
 =?utf-8?B?dVhlTE5GQXZ5QS82SHpNQ1czVFpVTVZ2anZyeGlhMHJjNGE4eVNjbk1rdFBw?=
 =?utf-8?B?UFo2enRmVEhuVko4MVdOa0VzNGNBcUJMM05Ia2dPbmR3VStDZTZIQjdkRmky?=
 =?utf-8?B?WGcxQk10MWpxaXdxNjd6dzh6NnJ4a3dVMFFIU1htU3crWlZNZUtCMHozNUdX?=
 =?utf-8?B?emI2U2I2bndnS04yYU15elV0V1dTM0xMUVA2RWVHdFJ6QWNKWFFIWWk4RHBk?=
 =?utf-8?B?QzZNOXd5cjlmZ3RiSEdPQ3A3aXljSGp4TTRleGlwWW5OaisvWHI1bjVhK1py?=
 =?utf-8?B?eW40Z0t3RWNIbkxLSHdLMThlZFQwOTlHdjNOSUc4Y0JHM1dxc250amVVaE9t?=
 =?utf-8?Q?g3BA04pMUH13MKHCc2MYWpHhRLEAGm418folufCWbnVHU?=
X-MS-Exchange-AntiSpam-MessageData-1: bljOYjVVCingLFrLUHWfUKl38ZaqlHsmZzQ=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea0e076-0e8d-4e39-a1f1-08deca9c2c4e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:08:44.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtkkWsLvG7G0jG8V8IvIT4cNSivTWu+QBJRA5tNbkq0aHFNbt15XJoAJMhmmwt++gx2Lhda5ecHNduy2sAlN8q9WCtSS63JIo03yFLWD1Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3975

Hi Jan,

On 6/14/26 11:17, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> No reason to limit this feature to Xenomai 3 configs. The compat mode,
> though, will remain 3-only.

Care, that nobody enables the EVL_DEBUG_ switches at the moment. So this
might be a bit misleading now.

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   Kconfig | 51 ++++++++++++++++++++++++++-------------------------
>   1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 98cbfeb..dc79700 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -201,31 +201,6 @@ config KAS_INCLUDE_KERNEL
>   	default "kas/opt/linux-4.19-head.yaml" if KERNEL_4_19_HEAD
>   	default "kas/opt/linux-4.19.yaml" if KERNEL_4_19
>   
> -comment "Features"
> -
> -config DEBUG
> -	bool "Build debug version"
> -	help
> -	  This enables various debug options in the kernel that can help to
> -	  validate the correctness of a particular Xenomai version and kernel
> -	  patch.
> -
> -	  However, these options also significantly degrade the performance and
> -	  maximum latencies, so don't use such a configuration for
> -	  benchmarking!
> -
> -config KAS_INCLUDE_DEBUG
> -	string
> -	default "kas/opt/debug.yaml" if DEBUG
> -
> -config COMPAT
> -	bool "Build 32 bit Xenomai userspace"
> -	depends on (XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
> -
> -config KAS_INCLUDE_COMPAT
> -	string
> -	default "kas/opt/compat.yaml" if COMPAT
> -
>   endif	# if XENOMAI3
>   
>   if XENOMAI4
> @@ -292,3 +267,29 @@ config KAS_INCLUDE_LIBEVL
>   	default "kas/opt/libevl-latest-release.yaml" if LIBEVL_RELEASE
>   
>   endif	# if XENOMAI4
> +
> +comment "Features"
> +
> +config DEBUG
> +	bool "Build debug version"
> +	help
> +	  This enables various debug options in the kernel that can help to
> +	  validate the correctness of a particular Xenomai version and kernel
> +	  patch.
> +
> +	  However, these options also significantly degrade the performance and
> +	  maximum latencies, so don't use such a configuration for
> +	  benchmarking!
> +
> +config KAS_INCLUDE_DEBUG
> +	string
> +	default "kas/opt/debug.yaml" if DEBUG
> +
> +config COMPAT
> +	bool "Build 32 bit Xenomai userspace"
> +	depends on XENOMAI3
> +	depends on (XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
> +
> +config KAS_INCLUDE_COMPAT
> +	string
> +	default "kas/opt/compat.yaml" if COMPAT

