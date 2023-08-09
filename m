Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D926124
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 07:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1poQDvRR+g1EYJPX9wdpHFuND0yeeasqgKzgU+Qo7Xvl2vvPYYISJHgJzQyAW2ziDGtizFnWL/qfnmJcIeRjR7GXcq6K8nrcjY39P2YzVHa1T2bocdl3MMImVFR5Q2FnJCIketPFQdWHHXLFHjtXt+Nf1yyYArGjXpHzFypf28ACtkHfH5Cnho/LgCtZQbgtt6s1aiMXPrEjvHndKww4TGqo95gqc8ihNJIPKr4iTGXW18lKQXQtfftIhtyo6H3e4tbSOHtfKmUulFSylYMjU1/3XtXrxviN46f57E55UOS1m02nr4sD+aS0Be9N5RRTB5INcwKTk+2bRfk+M1EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUOH00ErmvL6OjT7yI8/yK5L2fkMMNwRQhmgFpP5PQs=;
 b=Ki6//ljPuKCfZTCCeR0AKsTn6rKiQowB1xpFzMzuYhgbWiXXMKNS43cya6QLrwlcY17XIzPlmDMl+a8rs+uCNfsqH65z4pjUzSQo9fVBtrAitPJuTxxxdSnyG9LRUSiR5qBkQS9oaTkXfCRiTojzus1K9rW+JKSmEOwBORT5OFTkb8ViolXTov4Ry53bVlnpwDIseURZkwTqmxoOQa2EhLbxgmFpcuBf1sN7W/uLjCfxMCMWamkjLgVIrCg2nt8LGF93+eUYD7zMgN+5AV9mm156h3RfB1cz9AmFvMQeWWhuq3DAEQvuzDqtcgKW5Z4PnSKPyUc4uJXmWzkUzuNKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUOH00ErmvL6OjT7yI8/yK5L2fkMMNwRQhmgFpP5PQs=;
 b=GjPMQppmYokNvlTkxz25BSEFOIFrloSLi93I/pE+upYT2WlCylitx7XQ6FhBJdXxfbQC4wFUtvp1+1tkx0y3NRFZMWdUO09yWi7aG3BnNVp4CqGyt1QDbJCFJM4iLty0+rfO59kGh5P9db2L///zwWV/vyXJYl6VIdesqQNZODvqQtUEHzOvP3BqvwP98LaezkYsVkts130Ar/gXDbGflFhY610AjkulKtTNON7nTvN4VAlYr9K8/0muO5bK2T8GupmYOQ8p96gAbq4Cn6HJ5XpDeCdcv21UK/0mGz11h1yvGIA79cL5Pr6bFL9YsaIvKsLht3AJOaOGOfOhXKiCJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 07:28:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 07:28:44 +0000
Message-ID: <e8fc7489-414d-6467-ae62-bcc75f420e58@siemens.com>
Date: Wed, 9 Aug 2023 09:28:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
 <20230725082959.5144-2-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230725082959.5144-2-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ed859a-b526-45d8-102a-08db98aa4345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5C9JjJI7j1jnDaaULoZo3b6U91W8Jb1BRRHhLUjYsrFUMbjGlc7wuSTATrilKvUIeWQTHat7Jyu2sg9ETYCdJwYOkwnv/k+shtz2BfuPm2AZJn3NZz7fLMiLZN7zuAlvAPu+WULHj6Jola2lnkxhpqbwe/DA/B0iabtaezM3T3Ym3uRiecnuU88y8KwP+PXM6kINMgMngDr/BRf+6GS22v3i+6aReHBF52HoRM5mJZIuvzOmwO3G4o0h5CR5h+641qptb9wC8vuTGppfFgSTKFRA3EMxawF2/fcjtbz8flUt+OE9/rX/fygeOtMPx9MgCoSS1/AXIVMCNcBY1tNGnwNUAlzTPdVClsTEbtDcvVFaDVyJaZfNd7hQwUEo4bg2nIw2JlZaTxiX71KNfgJrB0CntI/8MFGLaSMixdbFFdcv+P8vCbuGqWb0/9Ix3tZz4clf2d4u45E55kzTpyLtAqGDj6ihin4SVfr3yvzaPn00wLR0J9ndYiytVMl9M34FnIrMNrr70yruax0N3aW8h/nmJmYqhhtRx79R2wtOE8vBUqGrSrPML4bwLUm1TLl1OOMmgbLXRub8a9l5MvEt9Jp4CS63anrMYRqbYPXvmzaKm11efqlZ902bZ10CZ3xDX+2f7y4Oaygy5qS47HMIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(186006)(1800799006)(451199021)(53546011)(6506007)(2616005)(36756003)(26005)(6486002)(6512007)(31686004)(478600001)(82960400001)(38100700002)(66556008)(66946007)(66476007)(4326008)(316002)(41300700001)(8676002)(5660300002)(44832011)(8936002)(30864003)(2906002)(83380400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU55OFJYZWR5SHRVaExwdXYrMFRvRnRLRjVPeGhtZU82VVBuYmtEZFRyV1BO?=
 =?utf-8?B?ZFA0K210U2NLWWlCOEZsclIxOHVYRU1OenZsVDBCckloWE5iVU1KZXZjUW5u?=
 =?utf-8?B?UXdjV1E4TGZ0bUdUNkg5a2crR2owRVVPcnEyZm9qVzZZaUZ4RlNad2RxUVJ0?=
 =?utf-8?B?amVFbXBVcU1UOFByTER4RGxhY0piTThuc0tnMGp2MXVxZWRPeWFmMnNVMEtY?=
 =?utf-8?B?TFBNaFZzc2V1L3lhc3FnejFyMGE2bzhZUHJUeVNuQTNWTkc2RzRDeTZ3a05B?=
 =?utf-8?B?dkZCdUlVNVk5MGdSZDJiMk9XSmNLRkFUY1NSZWFRM1ByYjFLb2hiQXQ3ajZm?=
 =?utf-8?B?aGpXQU1Ka3JaT2I2c0JHdW5FME16bHBTWkFhY2h1dW1TN042TXNNczdwR3Qx?=
 =?utf-8?B?enJnRVVhS1BVL1NMMUdXcTFDM1hRR1RXQThnUmM3L1ZmUHd2MEtSNWdxejU5?=
 =?utf-8?B?YnRkNlpodFNqWklGckhuazNlQUlORmd1OXlRZ1FrZ1VBaWROcTQ0d0NXOGtK?=
 =?utf-8?B?Q3ZTcHpFUXNqTWVxVXk5c2ppQksvUzhzcktvVjRJTnZsK01KZ0VRU1dGTnd3?=
 =?utf-8?B?VG5icXM1aHB5NExVNG1HajRjcHJJSDhXYW9hZFpER3ZMb2xVbFNTSXpETTBj?=
 =?utf-8?B?T1lHangvV0xmeG5PVGhFVVBKMWpJSlQ5NHRPejduNGVqTVZmWW9QOG4rTDBL?=
 =?utf-8?B?SVdYa0V3SkF5NHk1NHMxcldPNWk5WVNybW9KOTFibXN4UzY3VUJOMFFjRW5V?=
 =?utf-8?B?dE1hcE8rMndVa3laVThxNllrUThRTzQ0b3FvY0Y5cXNlcGtzcE12U1BJMXFw?=
 =?utf-8?B?OGIydXYxM0NxWDR0U3c4ZmNxZlFJcGtKTjg2TzBDTkJUQXpJOWlONmhtK3RL?=
 =?utf-8?B?aE1HZXk1UlpsSndiNTQyMVAyc2d2M0NUaCtCeTlwL0N6NU5IUVdCZ3A1QmxV?=
 =?utf-8?B?a011UUhCZ1Z0NDVWS3UwdnVhNnFHczVrYVFHcWVRNHlIMkJsc1MvUTRrWHFH?=
 =?utf-8?B?aW9HUHd2Z0hsUHpQcWNwWTlNT1VJR0ovYWg5ZkQ0MEhGa1JhS0h6aWh2bWsr?=
 =?utf-8?B?amxpcjVhanE1OFRBenkyeUNHMXVHUklRZXN3a0ZhMUM2TW1aL2pKSlJLcGk1?=
 =?utf-8?B?Qk9zaWE0RXNxcnVpY2cxUWlCVWZxSnJHMkYybnlGbE1BYmdMQURNVnE0cEFX?=
 =?utf-8?B?OUdoSG90N3pBOXRBTGdiRnBGWGExbFhHUWtkbm9YcElGTmpYbmtJV3MxTmt4?=
 =?utf-8?B?YS9GaTJlOThsY0pHN04rSVNBc29rdmc4MnVnMTRDZDJMd2dueVhGNmFGK0RH?=
 =?utf-8?B?cHR1REtkS1lFRjE5bkJuRnlrU21wKzZMM1JKUlVKTkFpZ1QvMEV0eDI1UGhX?=
 =?utf-8?B?bjMxQ3l2aXVVZmloVVFld0gvSllVVzlRZ0xQSkRHSGRMN1drVUtJQjlscUZL?=
 =?utf-8?B?bGNubC95VXRYTnJPYTFvT2d5WDRRY0hnRFN6LzJTMW5EK0UrYUxQWUhNM3Fm?=
 =?utf-8?B?aE9aWGFHcmJFQ0tZVFBTSC9ONW05RndyU2VWbTBwdFZWNUljK0R2VGxjNng0?=
 =?utf-8?B?cXhLNkhmVFowY3BnT3ZjendGenFGZkpHMU1iSXpHUDdDZDJUWHFDNjQ2a2Zt?=
 =?utf-8?B?NkROa2ZWdzZrV1BmdGFLdnNyYUdNQjhBWWxKbGFTdmhFcHZ5eVhBMkJ5QUZW?=
 =?utf-8?B?QURHODMreW95d3FMZmpLb3pJYXlCSHRjR3ROdlVBV0d2ZTZGQ0JvYlB3V21r?=
 =?utf-8?B?UjNwU1pDcnUvTURSVlUxMjIzeVMzTGZ2NmJWVEpjSk5DclY2R0pNT0o2bVo2?=
 =?utf-8?B?bXFPamFxaCthTVkyNDRjSDhkeDBVU3Z6d1NMd0FmQmF5OFBpcU9aakkzcTJp?=
 =?utf-8?B?cVJtSllMSTFBVHVPcGw0dDZaVnJXaUpHclU3NkV6LzMwMGZBUzV2elRGKzJm?=
 =?utf-8?B?bVdJZUl2eUJHU0JPdEpERGJ6NjREZnpIWmJlRUY2MS9rQytib2dTYWxaNmpO?=
 =?utf-8?B?enRBOFgyZUF1YkR4eVhodnVvK01qeVIydExwMU13Q2NBWDg0SWVqT3YvZEJK?=
 =?utf-8?B?YWZpQ2pScjVHK0s1STYrdC9GUlpENWJjMTFQSXpsSjAvakZvalRGbFRkTkxI?=
 =?utf-8?B?MHBJMmJnR2lqcmlMOTBQUVZCK1VGZldINC8zNCt1clEzNElaTGJUNUlxUkkx?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ed859a-b526-45d8-102a-08db98aa4345
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:28:44.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcZS/XjW4rEmnzC1otESpBH2HFRIOLewvbsOI9puq5ueUOO4uSNR6py8Ja4mk1uNtFdgK+S9AQVaSamO1y2YSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7698

On 25.07.23 10:29, Aaron Marcher wrote:
> This is the very first step to have the alchemy tests embedded
> into our testsuite.
> 
> Build them using Xenomai's build system and hook them up using
> Smokey. Every test binary has it's own respective testcase in the
> testsuite.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---
>  configure.ac                                  |   7 +-
>  testsuite/Makefile.am                         |   8 +-
>  testsuite/smokey/Makefile.am                  |   9 +-
>  testsuite/smokey/alchemytests/Makefile.am     | 148 ++++++++++++++++++
>  .../smokey/alchemytests}/alarm-1.c            |   1 +
>  testsuite/smokey/alchemytests/alchemytests.c  |  56 +++++++
>  .../smokey/alchemytests/alchemytests_driver.c |  33 ++++
>  .../smokey/alchemytests}/buffer-1.c           |   1 +
>  .../smokey/alchemytests}/event-1.c            |   1 +
>  .../smokey/alchemytests}/heap-1.c             |   1 +
>  .../smokey/alchemytests}/heap-2.c             |   1 +
>  .../smokey/alchemytests}/mq-1.c               |   1 +
>  .../smokey/alchemytests}/mq-2.c               |   1 +
>  .../smokey/alchemytests}/mq-3.c               |   1 +
>  .../smokey/alchemytests}/mutex-1.c            |   1 +
>  .../smokey/alchemytests}/pipe-1.c             |   1 +
>  .../smokey/alchemytests}/sem-1.c              |   1 +
>  .../smokey/alchemytests}/sem-2.c              |   1 +
>  .../smokey/alchemytests}/task-1.c             |   1 +
>  .../smokey/alchemytests}/task-10.c            |   1 +
>  .../smokey/alchemytests}/task-2.c             |   1 +
>  .../smokey/alchemytests}/task-3.c             |   1 +
>  .../smokey/alchemytests}/task-4.c             |   1 +
>  .../smokey/alchemytests}/task-5.c             |   1 +
>  .../smokey/alchemytests}/task-6.c             |   1 +
>  .../smokey/alchemytests}/task-7.c             |   1 +
>  .../smokey/alchemytests}/task-8.c             |   1 +
>  .../smokey/alchemytests}/task-9.c             |   1 +
>  28 files changed, 276 insertions(+), 7 deletions(-)
>  create mode 100644 testsuite/smokey/alchemytests/Makefile.am
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (97%)
>  create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
>  create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (94%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (97%)
> 
> diff --git a/configure.ac b/configure.ac
> index 3ce34048e..fe59333ed 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1041,10 +1041,13 @@ AC_CONFIG_FILES([ \
>  	testsuite/smokey/cpu-affinity/Makefile \
>  	testsuite/smokey/gdb/Makefile \
>  	testsuite/smokey/y2038/Makefile \
> -	testsuite/smokey/can/Makefile
> -	testsuite/smokey/x86io/Makefile
> +	testsuite/smokey/can/Makefile \
> +	testsuite/smokey/x86io/Makefile \
> +	testsuite/smokey/alchemytests/Makefile \
>  	testsuite/clocktest/Makefile \
>  	testsuite/xeno-test/Makefile \
> +	testsuite/psostests/Makefile \
> +	testsuite/vxworkstests/Makefile \
>  	utils/Makefile \
>  	utils/hdb/Makefile \
>  	utils/can/Makefile \
> diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
> index 4932f6d33..1be7eaba4 100644
> --- a/testsuite/Makefile.am
> +++ b/testsuite/Makefile.am
> @@ -7,7 +7,9 @@ SUBDIRS += 		\
>  	gpiotest	\
>  	spitest		\
>  	switchtest	\
> -	xeno-test
> +	xeno-test	\
> +	psostests	\
> +	vxworkstests
>  endif
>  
>  DIST_SUBDIRS =		\
> @@ -18,4 +20,6 @@ DIST_SUBDIRS =		\
>  	smokey		\
>  	spitest		\
>  	switchtest	\
> -	xeno-test
> +	xeno-test	\
> +	psostests \
> +	vxworkstests

These changes make no sense and are reverted in later patches. Dropping
them while merging.

> diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
> index 79dc61e9f..633a87387 100644
> --- a/testsuite/smokey/Makefile.am
> +++ b/testsuite/smokey/Makefile.am
> @@ -40,12 +40,14 @@ COBALT_SUBDIRS = 	\
>  	tsc		\
>  	vdso-access 	\
>  	xddp		\
> -	y2038
> +	y2038 \
> +	alchemytests
>  
>  MERCURY_SUBDIRS =	\
>  	memory-heapmem	\
>  	memory-tlsf	\
> -	memcheck
> +	memcheck \
> +	alchemytests
>  
>  DIST_SUBDIRS = 		\
>  	arith 		\
> @@ -80,7 +82,8 @@ DIST_SUBDIRS = 		\
>  	tsc		\
>  	vdso-access 	\
>  	xddp		\
> -	y2038
> +	y2038 \
> +	alchemytests
>  

I'm pushing these hook-ups to a closing patch so that we don't break the
build while applying the series.

Jan

>  if XENO_X86
>  DIST_SUBDIRS += x86io
> diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
> new file mode 100644
> index 000000000..9da3a98f3
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/Makefile.am
> @@ -0,0 +1,148 @@
> +testdir = @XENO_TEST_DIR@
> +noinst_LIBRARIES = libalchemytests.a
> +
> +libalchemytests_a_SOURCES = alchemytests.c
> +libalchemytests_a_CPPFLAGS = 		\
> +	@XENO_USER_CFLAGS@	\
> +	-I$(top_srcdir)		\
> +	-I$(top_srcdir)/include \
> +	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
> +
> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
> +
> +test_PROGRAMS = \
> +		alchemytests \
> +		alchemytests_alarm1		   \
> +		alchemytests_buffer1		   \
> +		alchemytests_event1		   \
> +		alchemytests_heap1		   \
> +		alchemytests_heap2		   \
> +		alchemytests_mq1		   \
> +		alchemytests_mq2		   \
> +		alchemytests_mq3		   \
> +		alchemytests_mutex1		   \
> +		alchemytests_pipe1		   \
> +		alchemytests_sem1		   \
> +		alchemytests_sem2		   \
> +		alchemytests_task1		   \
> +		alchemytests_task2		   \
> +		alchemytests_task3		   \
> +		alchemytests_task4		   \
> +		alchemytests_task5		   \
> +		alchemytests_task6		   \
> +		alchemytests_task7		   \
> +		alchemytests_task8		   \
> +		alchemytests_task9		   \
> +		alchemytests_task10
> +
> +alchemycppflags = 				\
> +	$(XENO_USER_CFLAGS)		\
> +	-I$(top_srcdir)/include
> +
> +alchemyldadd = 					\
> +	../../../lib/alchemy/libalchemy@CORE@.la		\
> +	../../../lib/copperplate/libcopperplate@CORE@.la	\
> +	@XENO_CORE_LDADD@ 			\
> +	@XENO_USER_LDADD@			\
> +	-lpthread -lrt -lm
> +
> +alchemytests_SOURCES = alchemytests_driver.c
> +alchemytests_CPPFLAGS =			\
> +	$(XENO_USER_CFLAGS)			\
> +	-I$(top_srcdir)/include
> +alchemytests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_LDADD =			\
> +	../../../lib/smokey/libsmokey@CORE@.la	\
> +	@XENO_CORE_LDADD@		\
> +	@XENO_USER_LDADD@		\
> +	-lpthread -lrt
> +
> +alchemytests_alarm1_SOURCES = alarm-1.c
> +alchemytests_alarm1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_alarm1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_alarm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_event1_SOURCES = event-1.c
> +alchemytests_event1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_event1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_event1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_heap1_SOURCES = heap-1.c
> +alchemytests_heap1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_heap1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_heap1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_heap2_SOURCES = heap-2.c
> +alchemytests_heap2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_heap2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_heap2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_buffer1_SOURCES = buffer-1.c
> +alchemytests_buffer1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_buffer1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_buffer1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mutex1_SOURCES = mutex-1.c
> +alchemytests_mutex1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mutex1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mutex1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_pipe1_SOURCES = pipe-1.c
> +alchemytests_pipe1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_pipe1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mq1_SOURCES = mq-1.c
> +alchemytests_mq1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mq1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mq2_SOURCES = mq-2.c
> +alchemytests_mq2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mq2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mq3_SOURCES = mq-3.c
> +alchemytests_mq3_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mq3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_sem1_SOURCES = sem-1.c
> +alchemytests_sem1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_sem1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_sem2_SOURCES = sem-2.c
> +alchemytests_sem2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_sem2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task1_SOURCES = task-1.c
> +alchemytests_task1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task2_SOURCES = task-2.c
> +alchemytests_task2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task3_SOURCES = task-3.c
> +alchemytests_task3_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task4_SOURCES = task-4.c
> +alchemytests_task4_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task4_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task5_SOURCES = task-5.c
> +alchemytests_task5_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task5_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task6_SOURCES = task-6.c
> +alchemytests_task6_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task6_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task7_SOURCES = task-7.c
> +alchemytests_task7_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task7_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task8_SOURCES = task-8.c
> +alchemytests_task8_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task8_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task9_SOURCES = task-9.c
> +alchemytests_task9_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task9_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task10_SOURCES = task-10.c
> +alchemytests_task10_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task10_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> diff --git a/lib/alchemy/testsuite/alarm-1.c b/testsuite/smokey/alchemytests/alarm-1.c
> similarity index 97%
> rename from lib/alchemy/testsuite/alarm-1.c
> rename to testsuite/smokey/alchemytests/alarm-1.c
> index 29b3bbe74..eb6c5310a 100644
> --- a/lib/alchemy/testsuite/alarm-1.c
> +++ b/testsuite/smokey/alchemytests/alarm-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> new file mode 100644
> index 000000000..ee8d1703b
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <error.h>
> +#include <libgen.h>
> +#include <smokey/smokey.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#define TEST(name)								   \
> +	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
> +	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
> +	{									   \
> +		return __run_extprog(t, argc, argv);				   \
> +	}
> +
> +static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
> +{
> +	int ret;
> +	char *tst_path;
> +
> +	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
> +	if (ret == -1)
> +		return -ENOMEM;
> +
> +	ret = system(tst_path);
> +	free(tst_path);
> +
> +	return ret;
> +}
> +
> +TEST(alchemytests)
> +TEST(alchemytests_alarm1)
> +TEST(alchemytests_buffer1)
> +TEST(alchemytests_event1)
> +TEST(alchemytests_heap1)
> +TEST(alchemytests_heap2)
> +TEST(alchemytests_mq1)
> +TEST(alchemytests_mq2)
> +TEST(alchemytests_mq3)
> +TEST(alchemytests_mutex1)
> +TEST(alchemytests_pipe1)
> +TEST(alchemytests_sem1)
> +TEST(alchemytests_sem2)
> +TEST(alchemytests_task1)
> +TEST(alchemytests_task2)
> +TEST(alchemytests_task3)
> +TEST(alchemytests_task4)
> +TEST(alchemytests_task5)
> +TEST(alchemytests_task6)
> +TEST(alchemytests_task7)
> +TEST(alchemytests_task8)
> +TEST(alchemytests_task9)
> +TEST(alchemytests_task10)
> +
> diff --git a/testsuite/smokey/alchemytests/alchemytests_driver.c b/testsuite/smokey/alchemytests/alchemytests_driver.c
> new file mode 100644
> index 000000000..7cacbb399
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/alchemytests_driver.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <error.h>
> +#include <libgen.h>
> +#include <smokey/smokey.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +int main(int argc, char *const argv[])
> +{
> +	struct smokey_test *t;
> +	int ret, fails = 0;
> +
> +	if (pvlist_empty(&smokey_test_list))
> +		return 0;
> +
> +	for_each_smokey_test(t) {
> +		ret = t->run(t, argc, argv);
> +		if (ret) {
> +			fails++;
> +			if (smokey_keep_going)
> +				continue;
> +			if (smokey_verbose_mode)
> +				error(1, -ret, "test %s failed", t->name);
> +			return 1;
> +		}
> +		smokey_note("%s OK", t->name);
> +	}
> +
> +	return fails != 0;
> +}
> diff --git a/lib/alchemy/testsuite/buffer-1.c b/testsuite/smokey/alchemytests/buffer-1.c
> similarity index 98%
> rename from lib/alchemy/testsuite/buffer-1.c
> rename to testsuite/smokey/alchemytests/buffer-1.c
> index d6d1d9ad7..fdcb5e8d7 100644
> --- a/lib/alchemy/testsuite/buffer-1.c
> +++ b/testsuite/smokey/alchemytests/buffer-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <memory.h>
> diff --git a/lib/alchemy/testsuite/event-1.c b/testsuite/smokey/alchemytests/event-1.c
> similarity index 98%
> rename from lib/alchemy/testsuite/event-1.c
> rename to testsuite/smokey/alchemytests/event-1.c
> index 0893df36d..9ce679c71 100644
> --- a/lib/alchemy/testsuite/event-1.c
> +++ b/testsuite/smokey/alchemytests/event-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/heap-1.c b/testsuite/smokey/alchemytests/heap-1.c
> similarity index 98%
> rename from lib/alchemy/testsuite/heap-1.c
> rename to testsuite/smokey/alchemytests/heap-1.c
> index 48bc4a56e..f0904439f 100644
> --- a/lib/alchemy/testsuite/heap-1.c
> +++ b/testsuite/smokey/alchemytests/heap-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/heap-2.c b/testsuite/smokey/alchemytests/heap-2.c
> similarity index 98%
> rename from lib/alchemy/testsuite/heap-2.c
> rename to testsuite/smokey/alchemytests/heap-2.c
> index ad67afb2f..1f80db80c 100644
> --- a/lib/alchemy/testsuite/heap-2.c
> +++ b/testsuite/smokey/alchemytests/heap-2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/mq-1.c b/testsuite/smokey/alchemytests/mq-1.c
> similarity index 98%
> rename from lib/alchemy/testsuite/mq-1.c
> rename to testsuite/smokey/alchemytests/mq-1.c
> index ac9801e72..952ff6448 100644
> --- a/lib/alchemy/testsuite/mq-1.c
> +++ b/testsuite/smokey/alchemytests/mq-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
> similarity index 98%
> rename from lib/alchemy/testsuite/mq-2.c
> rename to testsuite/smokey/alchemytests/mq-2.c
> index 9fea471b7..acc6ec051 100644
> --- a/lib/alchemy/testsuite/mq-2.c
> +++ b/testsuite/smokey/alchemytests/mq-2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/mq-3.c b/testsuite/smokey/alchemytests/mq-3.c
> similarity index 98%
> rename from lib/alchemy/testsuite/mq-3.c
> rename to testsuite/smokey/alchemytests/mq-3.c
> index 7fcae020a..cb4c77d43 100644
> --- a/lib/alchemy/testsuite/mq-3.c
> +++ b/testsuite/smokey/alchemytests/mq-3.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/mutex-1.c b/testsuite/smokey/alchemytests/mutex-1.c
> similarity index 98%
> rename from lib/alchemy/testsuite/mutex-1.c
> rename to testsuite/smokey/alchemytests/mutex-1.c
> index ef58a2c86..f08665254 100644
> --- a/lib/alchemy/testsuite/mutex-1.c
> +++ b/testsuite/smokey/alchemytests/mutex-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
> similarity index 98%
> rename from lib/alchemy/testsuite/pipe-1.c
> rename to testsuite/smokey/alchemytests/pipe-1.c
> index 4202be2ba..4011f9c8a 100644
> --- a/lib/alchemy/testsuite/pipe-1.c
> +++ b/testsuite/smokey/alchemytests/pipe-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <fcntl.h>
> diff --git a/lib/alchemy/testsuite/sem-1.c b/testsuite/smokey/alchemytests/sem-1.c
> similarity index 98%
> rename from lib/alchemy/testsuite/sem-1.c
> rename to testsuite/smokey/alchemytests/sem-1.c
> index 3e526eddf..080bcea9a 100644
> --- a/lib/alchemy/testsuite/sem-1.c
> +++ b/testsuite/smokey/alchemytests/sem-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/sem-2.c b/testsuite/smokey/alchemytests/sem-2.c
> similarity index 97%
> rename from lib/alchemy/testsuite/sem-2.c
> rename to testsuite/smokey/alchemytests/sem-2.c
> index c01f6a431..74cce2b7d 100644
> --- a/lib/alchemy/testsuite/sem-2.c
> +++ b/testsuite/smokey/alchemytests/sem-2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-1.c b/testsuite/smokey/alchemytests/task-1.c
> similarity index 94%
> rename from lib/alchemy/testsuite/task-1.c
> rename to testsuite/smokey/alchemytests/task-1.c
> index 34a6c22fd..d3d9a6f7f 100644
> --- a/lib/alchemy/testsuite/task-1.c
> +++ b/testsuite/smokey/alchemytests/task-1.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-10.c b/testsuite/smokey/alchemytests/task-10.c
> similarity index 97%
> rename from lib/alchemy/testsuite/task-10.c
> rename to testsuite/smokey/alchemytests/task-10.c
> index 58f4cb035..c4a29ae76 100644
> --- a/lib/alchemy/testsuite/task-10.c
> +++ b/testsuite/smokey/alchemytests/task-10.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-2.c b/testsuite/smokey/alchemytests/task-2.c
> similarity index 98%
> rename from lib/alchemy/testsuite/task-2.c
> rename to testsuite/smokey/alchemytests/task-2.c
> index e751ddd34..592f2ed20 100644
> --- a/lib/alchemy/testsuite/task-2.c
> +++ b/testsuite/smokey/alchemytests/task-2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-3.c b/testsuite/smokey/alchemytests/task-3.c
> similarity index 97%
> rename from lib/alchemy/testsuite/task-3.c
> rename to testsuite/smokey/alchemytests/task-3.c
> index 06f235af9..eb24935a4 100644
> --- a/lib/alchemy/testsuite/task-3.c
> +++ b/testsuite/smokey/alchemytests/task-3.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-4.c b/testsuite/smokey/alchemytests/task-4.c
> similarity index 98%
> rename from lib/alchemy/testsuite/task-4.c
> rename to testsuite/smokey/alchemytests/task-4.c
> index eba7fbb86..90e0236be 100644
> --- a/lib/alchemy/testsuite/task-4.c
> +++ b/testsuite/smokey/alchemytests/task-4.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-5.c b/testsuite/smokey/alchemytests/task-5.c
> similarity index 98%
> rename from lib/alchemy/testsuite/task-5.c
> rename to testsuite/smokey/alchemytests/task-5.c
> index 3c0fa427c..b9075945d 100644
> --- a/lib/alchemy/testsuite/task-5.c
> +++ b/testsuite/smokey/alchemytests/task-5.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-6.c b/testsuite/smokey/alchemytests/task-6.c
> similarity index 97%
> rename from lib/alchemy/testsuite/task-6.c
> rename to testsuite/smokey/alchemytests/task-6.c
> index 7c88fde9c..fa58d0fdc 100644
> --- a/lib/alchemy/testsuite/task-6.c
> +++ b/testsuite/smokey/alchemytests/task-6.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-7.c b/testsuite/smokey/alchemytests/task-7.c
> similarity index 98%
> rename from lib/alchemy/testsuite/task-7.c
> rename to testsuite/smokey/alchemytests/task-7.c
> index 1350bb39c..d118abf42 100644
> --- a/lib/alchemy/testsuite/task-7.c
> +++ b/testsuite/smokey/alchemytests/task-7.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-8.c b/testsuite/smokey/alchemytests/task-8.c
> similarity index 97%
> rename from lib/alchemy/testsuite/task-8.c
> rename to testsuite/smokey/alchemytests/task-8.c
> index bb6dfff06..959b3d3c4 100644
> --- a/lib/alchemy/testsuite/task-8.c
> +++ b/testsuite/smokey/alchemytests/task-8.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> diff --git a/lib/alchemy/testsuite/task-9.c b/testsuite/smokey/alchemytests/task-9.c
> similarity index 97%
> rename from lib/alchemy/testsuite/task-9.c
> rename to testsuite/smokey/alchemytests/task-9.c
> index e358154c5..56cc7bfeb 100644
> --- a/lib/alchemy/testsuite/task-9.c
> +++ b/testsuite/smokey/alchemytests/task-9.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <signal.h>

-- 
Siemens AG, Technology
Linux Expert Center

