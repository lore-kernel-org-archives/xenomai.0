Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF16110E
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeuF1bYXN4FbsjbvbCzSlmor3vLtb2JObwCKh3MBRJg/uI9Mo13Hd5gWht34WI9/MxXaQ46qa3h9bKISHUHY+py4x74K3nT1giBLXXZuOfHuLR1cQEg7kaFPzozaDM1lcxNLj5jknUddSCG2EpOCbCaZK1LXXGTG5haqsMnOJZcaBcBBcCF+bCYyCGFM3vYXRmXTT9bjkkUenRB7LlWDqKwnOtfhkcSk+RGAVfEAMBhgaNJf5r1xPPLfsqzJtHcZCsiOfzhbkQ9tvnDTRzyg/3zrp5cVEHFBLsjce6aU3CC01vnsEbiylGseJ6x3+NpGVG5E3nAxx4yz40r7gPyFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaChub6ImPxNfoZ2cLObWt/78YUlIaosLxnd8+aFTgQ=;
 b=B6tT7iRXVjZWEDQQRoTsqRvpS02Zt4+x0nc2cjubWZKrGuwWAsXZSAJZQtRJm7/MdxVnJcv1Tt19pIKEg0iGw2sT9vbYFyPD9YbqkTfAM1vZV2xvvWsZBaITu7ojSsHf9wv8dp9DJoKjfNPgiRq2eTcApzNkY3Ay0sn0MkldJI1GdhOoy/OtJMxJH5If3/mYXCcNiDo1lMABDnqmL5HaPLjaJAo9ZGYytmQRAC4sl7gBo/xJ9mC6Z9QOCGGULpcMW3RQqaUwEui5+R4YL7q3Eav7oyLnqPXD13dhrszlC7fZN+KnBa0f9fmpgz0NcSOpzfE6wOOFBJYHwtow5BFXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaChub6ImPxNfoZ2cLObWt/78YUlIaosLxnd8+aFTgQ=;
 b=OGOdiIqxfmN7qSvUD7sCBl9zQKJVoLoPrJ4O/AID1klBuxXMpYKNKN6nxz4PvK+iR/F7sTXn8fIMc20JbTkMtVvQDlbUKaSoC9p3jmPgDZz8rjhHQDEiAivZMlgrkfM67Ghdt99m9Lg/kWCUWMxI+mCrZESP2WgNisqQcqAMtKvnd2nf6imyd7HfRKqJwPe/Dvle7fsZrrCMQ9HBuzNiMaghAySLdRK67Va3FM/BA1WfgIcgAiwPLul25MDQroxXVV3jUhro6ice+KMg02+3aS1w+C5ZMurrJf0NgOVf61QS8lNnyE3lsIi/vkeE2OE6P2p8Ut8+KFjvKosT/tVAmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:23:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:23:10 +0000
Message-ID: <68fd52af-9c3a-059a-d4f7-1c798c3ae17b@siemens.com>
Date: Thu, 6 Jul 2023 09:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/12] y2038: cobalt/uapi: Align memory layout for time64
 related types
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-6-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-6-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: faa4b273-a52f-473c-39ac-08db7df1d9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XmvRllyxxYgU0QcTZHr/+zhXpMbo5sUTES7f4QOmqCUzOKQqcrclBoNjGC6Nps/azTmz9QqXEuoJQo5UjvOCRkUTKwMEJqeXmN5MwWVlOEqG5hvaEwxoOgWAx5MxlTvb41xp8viiK3gX/4lpRHcX8oAYJsDLS2O2l1BIOzBPhLL++17bo2tvuq6u22wjWHFSndx1eHRs2wWqY0k7pOqHzQDJmkc8EKoz7QIo4xmaK6Cgp6uTBYX7yVv6i6atv0FQ3XvEu7AZjG2oJiBRpTHQfaYnimXD+YZgpvr5Y9A9co9i8FVW55Nu60vZuqVlEnItY7pFY4ePF4XZkUd3sErvDWSqLcAZCRbPQRSSHuGEXhIa2ZE9hZrrCNqQsSZKVN4cH0HloI3j2tODPFQb+SQ+krXt3XFohJDoIXE9v89xRzgrv+26+Kka7qLDZoq/IKClfhsIUSDhNKP+4bmfLTg5pFP2+9gZsGl6Aok+vsISDHbr7OHo5MDiDWG0j6V90PhABNJgqPihriYUmj9GjIdcusy2rykBRf5S/ldeL7MKVkVjsb8LJ1fYvX4YOQ6uiE+BIbYqZPKxeRL3QsHGheRq8Bzn0OAUfJ/nDXFwbXl8MMX0qsl6AXbKkcuez+h1Va1BB7CjuBRVNJbwSVivhxEeAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(6666004)(478600001)(6486002)(2616005)(83380400001)(36756003)(31696002)(86362001)(31686004)(2906002)(26005)(186003)(6506007)(66946007)(6512007)(41300700001)(53546011)(82960400001)(38100700002)(316002)(66476007)(66556008)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE9INmtZb2ZvTnFvRDRTNGc4Q21MajJJR2Y0Mnh3aW9Wb0N1NEl2QWVleEJM?=
 =?utf-8?B?TXFxbGdLNzJyaEQ2VnFXTFp6VUpGeXp3R2xhczdDbXgzSVRFajBHREpiR0NO?=
 =?utf-8?B?MGJqOHdwdG1yTDBDZlMyUXl5bEdTUExjVXdqbFlXVyt3ZlhkUGVoMVlsb3oy?=
 =?utf-8?B?L3VzUDlXRm5JUlRwdXlJZjkvV0Z4eEdtY2VRdkNDVFVUTldjSUlhU3A1OGs4?=
 =?utf-8?B?Sk80cDdPMGhaRXhaZ3hwU1k4SzlpYjBleVZyM2ZVWVIzckZiQTRZdlZwUi90?=
 =?utf-8?B?Tmd5WWVyenhkdkRqTTB2M1pDWUNIL213Z0VUYjVtc000T0FYaTV1a0dyOVU5?=
 =?utf-8?B?d0x2bER5VkFpUjlGWjV6OVdWL2R1TTFDbTNGUEptckpaKzRTRzI3c0ExS0Qv?=
 =?utf-8?B?eUJSbGhGVVRvTm1KSHpVZ2pqRTJaQWYyTW5Kc2d1QkZSamRqdkt3blY3Y3JK?=
 =?utf-8?B?azRFWkJMSDdFT2E5ZUYzUlhXelk3QXU3NXJmNk53MFRlMW1URWloa3ZyRFRv?=
 =?utf-8?B?YmZzM3UvY1ZCQ3VjRVJUNFFLckNDNkJEaE9kQmcvUGQ3OXB2QXMxMlhwbnIz?=
 =?utf-8?B?RitKOE5BamZxUmo5Y09qZFVoVzF1b2pKR3U4aFNuK0dTZ2Y1UkFQK05UNTRo?=
 =?utf-8?B?OS9SeTdQdFBRS3AzN2RsOHU0cStjekRlQWhmbGNmeVZWakNrWUQ0T0lYYmFW?=
 =?utf-8?B?SWN4VlRqSUZ4VXYxSGd0Ti9JcWozYU81MG9xdlRnMXhsaXVXY2RUUlRXdHZD?=
 =?utf-8?B?K1V5cGp6NDlrd2NOY1ZZWVl6MDFkM2tZVjluVll4K1FUU3dzSk8xdWFTVlhZ?=
 =?utf-8?B?ajRwZmI5RXNjWEMxUG9Md3VPM2xIa2E4eWhEbVNzbjZDOUtvWDBzeS9nbGMw?=
 =?utf-8?B?bFA3eHBQbU1pYUJ5aUZSNnRhemEvcXZlU2RiZjV6Mldlb3JKZ2xsalUwTkJx?=
 =?utf-8?B?SlNUa1NwUElnYVRlLy9zNXljbXNDWHhieG84Y1JRc0EyTVRxSXdnemFyL2Fh?=
 =?utf-8?B?Z29UakhHYVR5YXpHRW4zdTJnSXdMS0xZR2NHRjBvOXNBSXlSS0FZbXlqWDcy?=
 =?utf-8?B?QStCNy9lZnJESnA1WnVtQU9aVTk3bS9vMlZra3VMMU8rdjY1WlBtbnBDWHo5?=
 =?utf-8?B?QzZEUEtKV1c2MEJxaWIrMFdvR2VSTTUyYkt3VUhrRTJEbll0NVM3M1VmSWZY?=
 =?utf-8?B?RUNhQ2drOUJkQnkwakY4b1lHb0lhM2k0Z2p3UUpaaWJka21Jc0hhNUxDK2Rt?=
 =?utf-8?B?cHZZSHp1aXdFYXBrb3djcHJHSDEvVVdFS1ppNWZZSDVyL3VqRnY5aU96L0hi?=
 =?utf-8?B?MlRNNUxmSWVDS0wxWUVXMGh4TUxIRzFZalJWc08rVnltWkRoYTNPSjhXbEcy?=
 =?utf-8?B?OG5QeDZ4M3dFMnBHUGJVWWxWYUlRSGNQbjdKVElsUlh3T1N2L1JlbW1zajJQ?=
 =?utf-8?B?RzNsSnlFdVVBM2ZvLzNLa3dmQm5jbHRWbU1LTmtLZDhQYWxyeGtXVExJQUYv?=
 =?utf-8?B?MEpPQUNRUVBuNDV4Y2RQeVp5YmtkR05sdEhDR0ExbFNvSUdvY3dYUDNmVGg4?=
 =?utf-8?B?QXkxcjk3dGlibGNES3EyWE9DRFp6ZWs3ZmxrMHA3VnZyR2Z6cSt0N1AzWWVJ?=
 =?utf-8?B?aUhhVlpWVEZraGJheDRyK0tMMXlyanJQYlJaTlNRcmQvRkdIMWNxTGlodVZz?=
 =?utf-8?B?TVpEc2Y0bGpuL1NPYkNjZjRTVzhzZlJsMU1PZmZjRjRmUW95Q0gwK2lLeUxy?=
 =?utf-8?B?S2VyZnFjQlNCbGdFYlNhdk85cXVNNHk5LzBOMEkxTGVyQ3Y4aWljakVXTmUw?=
 =?utf-8?B?OVBEWDU0YTZ3YXYzSmZCekJ6eGpCTng3WjhQT0xMeTVZYkJjNFhRaWlBZHVm?=
 =?utf-8?B?T3o5THhhRSsveUVzZ0JXd2d5aThqeEVReVRheEwzOWlYVmU0aTZqWGc2dWpT?=
 =?utf-8?B?cWQvRWpOb0Nvd2lKNFFYVGU3ODgyU2VVdlJueEQ0TjhZT2hlbG96Y2ZqZWwx?=
 =?utf-8?B?dG96am5DM1RDRnFlN1JmY0NhZ2VJclhEdENaSHpNQ1pNQkpmdlNleUFTQU5J?=
 =?utf-8?B?anFhYmQ1TWpicWxuMkFLRGF3Yitxei81cnU0dFZSeTZyRldDM2FIS0dUaHcr?=
 =?utf-8?B?RXpCenJMaGJkTGs2TWUycm16THFFSC8xYXR3ZnovMHRpdXh2VWNqN2hVUHFj?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa4b273-a52f-473c-39ac-08db7df1d9f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:23:10.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VO2z46K95yHiWjeqW1o8Pfvhb82SzMcRIXIgESMfwFu77o2rpgL+G4rq4x5IGfwmPxHv42kBg6RG9gHLo4kcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3357

On 05.07.23 08:38, Florian Bezdeka wrote:
> When turning on time64 support the memory layout of
> struct sched_param_ex (used by userspace in any case) and the "shadow
> type" (struct sched_param_ex64, used by time64 related entry points)
> have to match.
> 
> Simplified example for different memory layout (offsets) of
> struct sched_param_ex:
> 
>                                            offset 32 bit   offset 64 bit
> struct sched_param_ex {
> 	int               sched_prio;           0                0
> 	struct timespec   __sched_ss_param;     4                8
> 	...
> };
> 
> With padding we get
> 
> struct sched_param_ex {
> 	int               sched_prio;           0                0
> 	struct timespec   __sched_ss_param;     8                8
> 	...
> };
> 
> This is a backward compatibility breaking change. Incrementing the
> Xenomai ABI revision on all supported architectures to express that.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/compat.h                               | 4 ++++
>  include/cobalt/uapi/sched.h                                  | 4 ++++
>  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h   | 2 +-
>  kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +-
>  kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h   | 2 +-
>  kernel/cobalt/posix/thread.h                                 | 3 +++
>  6 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
> index f2dce74b4..71010e3a9 100644
> --- a/include/cobalt/kernel/compat.h
> +++ b/include/cobalt/kernel/compat.h
> @@ -30,9 +30,11 @@ struct sched_param_ex64;
>  
>  struct __compat_sched_ss_param {
>  	int __sched_low_priority;
> +	int: 32;
>  	struct old_timespec32 __sched_repl_period;
>  	struct old_timespec32 __sched_init_budget;
>  	int __sched_max_repl;
> +	int: 32;

Why not u32? And why not using that type for the other int fields as
well? Same below.

Jan

>  };
>  
>  struct __compat_sched_rr_param {
> @@ -41,6 +43,7 @@ struct __compat_sched_rr_param {
>  
>  struct compat_sched_param_ex {
>  	int sched_priority;
> +	int: 32;
>  	union {
>  		struct __compat_sched_ss_param ss;
>  		struct __compat_sched_rr_param rr;
> @@ -60,6 +63,7 @@ struct compat_sched_tp_window {
>  	struct old_timespec32 offset;
>  	struct old_timespec32 duration;
>  	int ptid;
> +	int: 32;
>  };
>  
>  struct __compat_sched_config_tp {
> diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
> index 730456d89..4081fbc0e 100644
> --- a/include/cobalt/uapi/sched.h
> +++ b/include/cobalt/uapi/sched.h
> @@ -39,9 +39,11 @@
>  
>  struct __sched_ss_param {
>  	int __sched_low_priority;
> +	int: 32;
>  	struct xntimespec __sched_repl_period;
>  	struct xntimespec __sched_init_budget;
>  	int __sched_max_repl;
> +	int: 32;
>  };
>  
>  #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
> @@ -63,6 +65,7 @@ struct sched_tp_window {
>  	struct xntimespec offset;
>  	struct xntimespec duration;
>  	int ptid;
> +	int: 32;
>  };
>  
>  enum {
> @@ -128,6 +131,7 @@ struct __sched_config_quota {
>  
>  struct sched_param_ex {
>  	int sched_priority;
> +	int: 32;
>  	union {
>  		struct __sched_ss_param ss;
>  		struct __sched_rr_param rr;
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> index 43b7afb10..fdd5c0e32 100644
> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
> @@ -22,7 +22,7 @@
>  #define _COBALT_ARM_ASM_UAPI_FEATURES_H
>  
>  /* The ABI revision level we use on this arch. */
> -#define XENOMAI_ABI_REV   18UL
> +#define XENOMAI_ABI_REV   19UL
>  
>  #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
>  
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> index b98a96392..301797748 100644
> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
> @@ -22,7 +22,7 @@
>  #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
>  
>  /* The ABI revision level we use on this arch. */
> -#define XENOMAI_ABI_REV   2UL
> +#define XENOMAI_ABI_REV   3UL
>  
>  #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
>  
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> index 65f8164a0..045adf0c1 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/features.h
> @@ -19,7 +19,7 @@
>  #define _COBALT_X86_ASM_UAPI_FEATURES_H
>  
>  /* The ABI revision level we use on this arch. */
> -#define XENOMAI_ABI_REV   18UL
> +#define XENOMAI_ABI_REV   19UL
>  
>  #define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
>  
> diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
> index fb4306351..f663acde7 100644
> --- a/kernel/cobalt/posix/thread.h
> +++ b/kernel/cobalt/posix/thread.h
> @@ -114,9 +114,11 @@ struct cobalt_sigwait_context {
>  
>  struct __sched_ss_param64 {
>  	int __sched_low_priority;
> +	int: 32;
>  	struct __kernel_timespec __sched_repl_period;
>  	struct __kernel_timespec __sched_init_budget;
>  	int __sched_max_repl;
> +	int: 32;
>  };
>  
>  struct __sched_rr_param64 {
> @@ -125,6 +127,7 @@ struct __sched_rr_param64 {
>  
>  struct sched_param_ex64 {
>  	int sched_priority;
> +	int: 32;
>  	union {
>  		struct __sched_ss_param64 ss;
>  		struct __sched_rr_param64 rr;
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

