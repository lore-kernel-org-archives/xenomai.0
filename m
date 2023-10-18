Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18B8F7E
	for <xenomai@lists.linux.dev>; Wed, 18 Oct 2023 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U6Rkau/U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6shgqj3MG+qEypEaWitksMGXeKBiWDmFXE3tTyMnvOQ0LQllyLV0jjQa/xyD8kuEzz+/w0IIDSyVUrLgvbZmcFKbGwcrJjbiTDST16888IR+gwno5yxZ4Y9liHEBTZWFrIJuv86iVKu0ZOzBMVrutPBcbIYo7E6A3VpJcvfChwCwk2l3Rb4gNp10mNChc/y191SMYDx6JdwvwFiAJZy+iIFeV83zPBv+zifJUwCIZNX5l73EXXFgkBYCdqitnm4qtUDzJ756GbmPgmIyLxVafzfTkVU0FqY+61l9F8Mzp9YBkr67DoL/LhJrSRhE5BTZUcIuerzLv+h/niz5Xso8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr1XkCFREeCeRRHogGD5bWks5UvcLNGLP9QKzAbzIpw=;
 b=BKb4NRXvmZi4l7qCeSDKDBPq230OfC4YpH6eUy+de4b9RiZWEkZy8MD/oqk3wGu0mkdlo+6TZ7wcnxeBe6hPtXgkB2CC1IP23K5kz5PGqeMPqjvdGk2rxXFvHSGLd3k9KCaxTjlrIomnbgDFsg6eeHMekmIg+/k0FPvLYdJ3aOGqEyLsyFK+7v/e11HHyj4dOw0tOhNpJLvPxy4VXiefAJD1I8BHf8WKejeli6idIoioUXLfJVDGfa0eFOhpimUfWl31QjMmAmiYpp9TWo1tHg+8iInkJzAkWd+JzvF0hvIVl+9F5V8goTHATOmbIYTo96rye4QODGSOFIZOtibrug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr1XkCFREeCeRRHogGD5bWks5UvcLNGLP9QKzAbzIpw=;
 b=U6Rkau/UftbPdkY9jbRnEs5dAYfgyFWKLh4CtqS0Shj6dh02Gse9ac315NIPPMkh/ihuxgB9uLbEPgEVMkfZsJu2aFn6F7q1RmpYl7DknlE9JzjMDVRToD6A25hUgx+qfj3BZzK5O6yRyqcKPEYNnTV6YDZasODTfMx4+SrXl8vv53ebdKZYNUVN2AItGfZi0nQLUQyycPo9bVm2oTIakYpo1CsS4rvLCJXdIMU0i24qgZfIIh+NlUknItTddlAhG/4XFb+wZx91e/3wNXqEPsJdSnz/G+TQ87iXWednYNJIp+UZs6+g9+lnNolXEpmYiT7R0U9jbAUbs5LNjc0QjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 10:51:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 10:51:14 +0000
Message-ID: <1f32866c-4eec-4525-9cdc-a8bb73d01117@siemens.com>
Date: Wed, 18 Oct 2023 12:51:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] cobalt/arm: Remove arm OABI support
Content-Language: en-US
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20231018081803.298461-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231018081803.298461-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:610:11a::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcccc98-221b-4e5b-0ca8-08dbcfc825bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FS5yUuApBgUMzgtvZg18cmOF77Kucy3FdktRBrl1uoOVk2WCxR20pRE9DW6EEn9pm1cnxB3vGpDxJDugeBDgJyDD4zAqhMNalugardGTeC+B/fUHedB0BEtb7eCtf+e+HDG96BgcBfF97OcfyXckyVKBMQXrNcjtNuJEL5sXiBNzXVs7uwfDvhixUsyPDXQhTOJTG9duZhZeDJPJTV5mZw1qbNbZpJUIbCaw/5R8F1yl7LS0XJDT2OUnS9gCgvAcyGnPfzngB8n8HB3GFt1bXcHtPnd9tsdxKy85KtT6PNzf37iFvK51JxZGbTfZ9W4y3wY45T+FRuZcG8JxPMDLKxMtTSGombhuDdpEUSMpE9PdWbOmxjF42gb8geehS8yaXErmC9nhC0/L1MZrByZukAVD/ms2TsNxtHNuF9NeAtUzYwe0CCx769peH8Fku4nZstUHtdZi2wn+8Xrw/yFFBOmbe3QCBxVimX2huQrxz6BHoQtHbl0NBb24Kt0p9TyVq02RUpIB5v0Vh2IIipOgOQFQPgDevT6F5DGo8kVsXklubZ+6AlAkhsyfp5EI0rOVJH0DFdvKorvPnrGQ+4KTm1cz09l3M2ya3ul6um9m1WE5WRrR7zkFQAwuLiIM/4n0tPq7XUQUo9Os3nHqe3nejw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(36756003)(31686004)(66476007)(66946007)(66556008)(38100700002)(31696002)(86362001)(82960400001)(53546011)(83380400001)(107886003)(8936002)(2616005)(6506007)(26005)(6666004)(4326008)(44832011)(2906002)(478600001)(6486002)(8676002)(316002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QytIZ1dIcENkWXYxZXRBbzJYc08yZE1ncFZ6bmluNFRrTUtacjFIQ1lnckY0?=
 =?utf-8?B?dEI0bE5Nd0s4Q3hhMnhQRTBxeDZpM3Qvc3I2Q3dvNUtqUTExUHR5T1lEQmRM?=
 =?utf-8?B?MlRhak1wTS9WcDBjdWlabG90dDArN0dRS1VPcys5T3Q2MXhNcjRhZi84c2F5?=
 =?utf-8?B?SmhRS1RzMWlMRm5iSkVTMUpKWE1jRzhaM2xNdDFUSnAzQ2xKYWw4em5ubkM2?=
 =?utf-8?B?NWtuTUkxSnI2VlEwM0F6OHphdHZpS0QvL3BFUVhQTXp6cFFwQ0NGMnhxdTkr?=
 =?utf-8?B?b2pRZ3l5Umo4ZDR2c0QwR2NrYVJ3UWVQbjBaUlpGNStZT3N0dDFsczV2S3BW?=
 =?utf-8?B?Rmg5SXFrRWhYdDR6VTVwUUl0djdXaFIwa2JFL3ZMbkNRYmExQmVyekJva2ZQ?=
 =?utf-8?B?Tjd3QWxsNDBMdFhSUnd5SjJ0aExLYXl2Z1h1RmxCeC8rd3l4blJFWU9BSjJs?=
 =?utf-8?B?V1dYbUtYWEFVVE5nYkpZY24wcG1uek9ZdE95SkczQ1pDZmZLeDJOdG9ZZFY4?=
 =?utf-8?B?ekN1ZGpzYzgwNUJVSjd5UG9pNk43My94YlVKN1U5bGRRY1M1TjZmM08rdmdN?=
 =?utf-8?B?R2J0ZUhSa0FwTldyZ1Z1L3dVVjQwOC9qbGJVM1dkWGhkNDBQaHhwUEpLOWI2?=
 =?utf-8?B?VDVId3FlRUFsTzZPNUxIUW4ySFk2U1o2bmVjOXEwSlZqR1VZaGtGWDVUM3RI?=
 =?utf-8?B?a0hpREhBWkpVVE9EM1UraHM0Q0ZPWlRyZHFkV1BEbFJkUEp2aExDVDN0S1hN?=
 =?utf-8?B?UmZQdUJNeWQ2SHJPR0hXZXNUd1VhRWtFMURWYVJoNmZFbDhkVFZNSEZwZ3NB?=
 =?utf-8?B?RkV1MXJPOGJnNE9OemdDbXdObGp0YUsvVzVnVlpvcDJxSEoyS2NYY0MzTnpB?=
 =?utf-8?B?REtTY3VPVGI5UkxGZDV4SlhhaHpJWEk1a3lBdmViV2tGTTBka1hRdmg1RGNU?=
 =?utf-8?B?S1F0NHdvQzZWTUU4RVRxMzRlTjlUczVaMnoxUUUwcVpTOXFsNXBxZjREZUFI?=
 =?utf-8?B?Tm0za1V6Z3RvWjAwbW55amIvazJJNnUxUzVEVENMRSswSzBySVRhd25SM3hs?=
 =?utf-8?B?QU9KSEIrdEdFRnNGMWh6WmVkditnS09uTkU0bmlrWGdiL1BxTzBjTHlsRVYr?=
 =?utf-8?B?d2tKZy9EdHdaK0VrNHNlYU1YT3hRMmY4N1ZLQW5kcHZEVzE5WE1KR0QxaDh0?=
 =?utf-8?B?NTlYU2ZBVG1ndHA1OVVIZUpWc0FBaVVLeDlqK2M0eXo4S1ZiSVFKUktQVUJ4?=
 =?utf-8?B?SFZlQ2x6QWJwNWlhWVUvNFk3NDRpV0pDN1NUL1FLdEd0a2FDd3JFNTl3ekFE?=
 =?utf-8?B?a3AyeFVnNENaT25NY0hVYmNHU2ljMUpsZ2tQTHJDMC91R1ZzOWhoMGdGZzdQ?=
 =?utf-8?B?Zm5PK2ljRVoyVlZVa2NvVWZxK21wc1lIdGlyOTUxZUZIb0hQMFZ3TXJmQWlq?=
 =?utf-8?B?aG1hSDk1NVJ2VlozSDJXZHNCK0k3VVpGOFF5eWRXSmlOT0F3WDlvdG9qVzJl?=
 =?utf-8?B?TFdnM2l6c0FUaGhiSmxWRms3UlNmNnBubFdvaGJ6aHBRUGlNdmo0d3d3NjdL?=
 =?utf-8?B?NGJRTlhvWjBWZjJsSytzRkJjdmUzTVNvWDlQQWdJODNMYTczVVY5MUNGcEYv?=
 =?utf-8?B?Qk81MERqVjVsVXIvY3pKUUVicVF6L3BpRG4wb28wZTZVeEtqb2hEb1I1NXYy?=
 =?utf-8?B?bGtGMzdGUERHSDQ1RjlmOVZQeXBZcnZwZ2hKSWVnVXc0ZGl0VDF4a3F5Qlpo?=
 =?utf-8?B?SjJnS2hiekprVkQvOGNrUDc1YVhQQ21GRDU4SFA3Mzk2c08zVXFwbm4yT0Jh?=
 =?utf-8?B?cFVJL1E0ZWJta2hUVzFIbGw4d3FKQllwWUZ3OEk4MDFTQ2VTVmhCb0FYT3N5?=
 =?utf-8?B?aFBmUllXd0hXeVQ4Qzl3ZEtYd0ZpQi9mYWZaTUFBZXJsN1hWNW9vQWdjTjdP?=
 =?utf-8?B?L3MvcVAxd1NXR3dLc1JlZGpZSWVhcjZpMS80MHZ4SkF1SGhzMGtkSFQrNnp4?=
 =?utf-8?B?QVIxTHArYzBkU0hOcEVBUjNqaFI4ZWxLdi91M2VXN05vWXpnZzI0elBCSUh5?=
 =?utf-8?B?WE1pMm0wdXcxbTcxQXZWOXpvTlk3Nmh2cG1tUDhseE5QeVBuVFZIc2x3clBi?=
 =?utf-8?B?UFlyWHM1eUdwQXJNSWdTU3MvSS85QWZTcHZWNHUyeXFrSVNKMUJKS2pxaUVX?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcccc98-221b-4e5b-0ca8-08dbcfc825bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 10:51:13.8845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpVetr3aLTGrBw6T72K8f9x12/fs8UrKTdusFxe/lx3gCm5lctcbDmvFJGUJuIR1Mo2KdgSRjpBJNxS4VmQjkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6601

On 18.10.23 10:18, Clara Kowalsky wrote:
> As OABI is marked as obsolete since gcc > 4.6.4 (~2013) and Debian
> stopped shipping OABI toolchains long time ago, OABI support is dropped
> from Xenomai. Therefore, the kernel option OABI_COMPAT should not be
> used anymore.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  doc/asciidoc/TROUBLESHOOTING.COBALT.adoc      |  9 +++----
>  .../arch/arm/include/asm/xenomai/syscall.h    | 24 ++++++-------------
>  2 files changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
> index 778e74f96..14a4d53c6 100644
> --- a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
> +++ b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
> @@ -219,12 +219,9 @@ support.
>  
>  Although the program in question may be present, this message may
>  happen on ARM platforms when a mismatch exists between the kernel and
> -user library configurations with respect to EABI support. Typically,
> -if user libraries are compiled with a toolchain generating OABI code,
> -the result won't run over a kernel not enabling the
> -+CONFIG_OABI_COMPAT+ option. Conversely, the product of a compilation
> -with an EABI toolchain won't run on a kernel not enabling the
> -+CONFIG_AEABI+ option.
> +user library configurations with respect to EABI support. The product
> +of a compilation with an EABI toolchain won't run on a kernel not
> +enabling the +CONFIG_AEABI+ option.
>  
>  === incompatible feature set
>  
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
> index 0941e6c84..864330490 100644
> --- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
> @@ -25,6 +25,10 @@
>  #include <errno.h>
>  #include <cobalt/uapi/syscall.h>
>  
> +#ifndef __ARM_EABI__
> +#error "ARM OABI support has been removed with Xenomai 3.3.x"
> +#endif
> +
>  /*
>   * Some of the following macros have been adapted from Linux's
>   * implementation of the syscall mechanism in <asm-arm/unistd.h>:
> @@ -85,32 +89,18 @@
>  #define ASM_INPUT_4 ASM_INPUT_3, "r" (__r4)
>  #define ASM_INPUT_5 ASM_INPUT_4, "r" (__r5)
>  
> -#define __sys2(x)	#x
> -#define __sys1(x)	__sys2(x)
> -
> -#ifdef __ARM_EABI__
> -#define __SYS_REG_DECL unsigned long __r7 = XENO_ARM_SYSCALL
> -#define __SYS_REG_INPUT , [__r7] "r" (__r7)
> -#define __SYS_CALLOP "push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"
> -#else
> -#define __SYS_REG_DECL
> -#define __SYS_REG_INPUT
> -#define __NR_OABI_SYSCALL_BASE	0x900000
> -#define __SYS_CALLOP "swi\t" __sys1(__NR_OABI_SYSCALL_BASE + XENO_ARM_SYSCALL) ""
> -#endif
> -
>  #define XENOMAI_DO_SYSCALL(nr, op, args...)				\
>  	({								\
>  		ASM_INDECL_##nr;					\
> -		__SYS_REG_DECL;						\
> +		unsigned long __r7 = XENO_ARM_SYSCALL;			\
>  		LOADARGS_##nr(__xn_syscode(op), args);			\
>  		__asm__ __volatile__ ("" : /* */ : /* */ :		\
>  				      CLOBBER_REGS_##nr);		\
>  		LOADREGS_##nr;						\
>  		__asm__ __volatile__ (					\
> -			__SYS_CALLOP					\
> +			"push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"	\
>  			: "=r" (__r0)					\
> -			: ASM_INPUT_##nr __SYS_REG_INPUT		\
> +			: ASM_INPUT_##nr, [__r7] "r" (__r7)		\
>  			: "memory");					\
>  		(int) __r0;						\
>  	})

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

