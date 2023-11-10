Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48391DFF3
	for <xenomai@lists.linux.dev>; Fri, 10 Nov 2023 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SdX1oDf8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW4N3m96WFmv6s4Ljnf/CcIbuNDPqPgxmeia1YGdgmkOHGxKOhMJ14Qq/BNYopkOiXeUb4xaZHHWlLdGZ9gu0yr8Tx5cVvOxUbO/0enSEIrlJyDEKcnf5wxAVpxw96qlRU/ke107/BWnNw4rzqnl/LKZAbI/VzzaSb5CShCKVRWfcInGQx7E/BoV2JmHefZS1/nOyHJVUeLEwEiymN1KTb0vGDVKRo40kU7qWO0yT1VJIaDta0v4nHVLc86JUp6K5+AgFTAYaAVm1vAin9fUQykYGFP3RoKZL8EAEzfU5XepQ00oeGH+8bLMvWj2kA1NM9ZjCUOUbViRcDI5hTHy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvVBzs32s/gOSxoFBteuA05edklT5vh7Ap4WNnCHD0c=;
 b=RBLmxup+Rtd6X27GJ2Z218PnkPHq4T13PVJCPgo/IEuaATH3pH0EA9mQ1awKTp6pD7pRDYLqb8sT13hjZ1MVlUjwvAjDH5alhAKS1rsCf746wovJLzenBiftFveDQIla6sYrIrThhYXL57ZwsYy0igw0PLIJOtjLuL4BirrFrIVKRRFBAbRQTkkPzOHTl9i5R94F0Ay66IPXrbHFvZaKDKhbSGyWQ+9KivQj9wAawJ01sGKtqgjYJwJiHS/NS6AwEOVuzd+AABURiApzVQkojXjOXQIX49jNoSQWRvPjRrCOpb8IpVVrV3CPhL9ptowmZ+0o2S/JBVe7HZZprfdFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvVBzs32s/gOSxoFBteuA05edklT5vh7Ap4WNnCHD0c=;
 b=SdX1oDf8dFbJH69EIJUnPip0q62hdzsJkMZG3bsq0i1YFgppf0ZuV0PVAEnyJQkhINIz5BZCKwCt/zRVjuWde8OSBURtoJrn4hh2vGfWCDudxEy+XNz7sZrgA/EPx8MigPaK3H6SkvWBimKlLOocjlGuQJxKoQHx5clY44sdd6D2d0ps40m7w11jqpjSBpCAV6QVBFcwG/RhyKDpbihagmQ8pv1NNHFha8OeGHInXJGdNQ0BNuSc5hi7YqylDgp95rZtBJwCRRpCKajceRjjJP3h8kQaIQjBZgRygjl8w1p8REazSxZvQDVwu8Cqq2qysCLcG1ChPPv8emAoouycaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 16:29:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 16:29:59 +0000
Message-ID: <ac2d4cb8-8d1f-470a-a074-fe7b6966d7c7@siemens.com>
Date: Fri, 10 Nov 2023 17:29:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] boilerplate: Define ARRAY_LEN once inside
 ancillaries.h
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
 <20231103-flo-cleanup-testsuite-v1-1-628287f21b8d@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231103-flo-cleanup-testsuite-v1-1-628287f21b8d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 517b53a9-f9a4-4960-dc07-08dbe20a4859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kBVNMamDEBMY8Xqmog56h8GnQGg6mLezHHTD6z71fqY+U8T52Gsem92kvfsDyMpLbtwM98478RZUe2mWPUyiHtrnm9KiHxVbCJKEFfx8kf9nyZ5BBnnMlRKLVDcev9QnCs6eYgyZ2S0M0r7DbXtdSCiikE8Y12roDepjugrSFnk/ou9tbr6cIFvdiN4sBoo5ImG0bF1KsCuB8y44huYfuQ5X/cWFyaMSFmsaqiVFdqf5Grwg6s+PLaJ7qQI07CHlw5/RbMPnhUGCpTB37k0DyA6YDfPXlEyvyUJCcDpBPccCPWrYbkXOWWVHmP+eP+3LtoYzITrvLVIzNXLvWp1lErSiD8BAgaA+9ES36YfNAvmNmhT1y3bu5BifhBxM7WHTOXmqmdlW3Sw8kZia0L23GwPQQJoY0dZTz8ReVd4XUfN0bmkO5j5kG9etXrHWqgNFpoZRDxSwm7NJWLUCGbKUmebXVFISoCrkObftA7quBKK8x+vZf+6a5h0s2HEy8aF3hMru8+le5UMNJ3ck3wHe5ER+cM6fBmeMak++epLUnLH+ClXIM5dfq5RuDRaqlZ4e/6fffa4NDNu4MJZv7Vc+3/DaZb63gbwOmaB1g/ws2MUYLwG2gV93oCyo+swUbk1n66OgXmU/zT7rktfG0m6DbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(41300700001)(478600001)(6512007)(6486002)(53546011)(2616005)(44832011)(83380400001)(8936002)(8676002)(316002)(6506007)(26005)(5660300002)(2906002)(66946007)(66476007)(38100700002)(66556008)(82960400001)(86362001)(31696002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkRHM1dxZTJWNWFTVjNSMzl0MXBwbHV1Rmh0MzhHTkhqQzBBVWI5REFVWlFI?=
 =?utf-8?B?eFRCeld0MFRkcFdWOWpadlVWZmpXSWJsMnJmdnYrVER1NkhMcEVRU2JHcThQ?=
 =?utf-8?B?ZjlwQTJsbEJ0VmNnTHNXUlBnWTg3MXd0S3J5dk83WmlIeEFOYWVGK3AvWFJs?=
 =?utf-8?B?RDdEZ0Z4ZG9BUzQrN1g2RDNXekw5dVFkSUx4aHlkSDJHcU9TOVRUY0Z3U0Rz?=
 =?utf-8?B?L0haYkN1YWUzaGJ0bU9pZURWZlVaRSsraWZsdE10b1NWL3EweW1tejhHZis0?=
 =?utf-8?B?Y0xDZUJKOWNxUzVjUnFRY0JoSEpiais0eXgvb2NnbHEyZUVjZkxuNEdoWHg5?=
 =?utf-8?B?TmxpVDdVdXhqcldqRWFseE95c25sSFFzOGYwaE9IV0tjbGcyNjFhT2g0bVh6?=
 =?utf-8?B?QndPQk93blhiRnlMVW5NOXdxdHJpV01KaHhSUkJOZ3FnU2JKdnBVNUNrWER3?=
 =?utf-8?B?bFhpbG93djJOMitrZW5Ha2FkMzNuelBldk8waHFVc1VPcE1IeGtrT01FckNK?=
 =?utf-8?B?UFBrRmRjUUsxdnpJbnlUVUY4WGp3ckFxUVU5VGZOS2tNcnhyamJQK3dpN3RP?=
 =?utf-8?B?UWdRWHhUc0R1RHRvQUZMZ3J4UXIzYWZ2b0p2L2ZTYi8rc2hIalFnWDVjK0po?=
 =?utf-8?B?eGQ5dGdscWF4dmthTTBZVXVzR2xLd3JsdjRjVnZMOFNHQjNEV3NaZEtRd1lh?=
 =?utf-8?B?bWh1b2tTL3Z1ZGhFNHRmcEJnVTlhY3hFb1ZSUGV1NGpabnVCQjlTOWdWQUpr?=
 =?utf-8?B?RnpOQzlFUzB4eXBzY2JKSnR2aDUva2F1cWlTVnhRUmFNOWVVcTJheTJtY216?=
 =?utf-8?B?enVrNFYwQk00TUVBUjNtL1JBdjFSbkZ0KytlbnlUTUJ1TFdzc0N3U2F1dndP?=
 =?utf-8?B?aWt4R1JuLzhQTzhRaVJhRDlHZkRFVnlzaDdTT2g5YnlWdWhqUURheWZFZWRY?=
 =?utf-8?B?aktuRTJMYkk0N1YzSzYrWXBJcm0remErSHFnR09QRzNKUVdDQmVXdU13UG1H?=
 =?utf-8?B?M1NKcFpUcGl3MHhxOXFnUXRrR1BoK0psZDNtQWhlZDlxRXBDR002eDd0WkxX?=
 =?utf-8?B?bnRDSnZSOWQ5TzIxbVFKZHd3MjRoNGo1UW11SmhpUUExQ29PNnp1VE01cWtk?=
 =?utf-8?B?dEVIaU9Sa0plUlRtb01FU0E0MjNpMEJ0YmFVNWE1VU9ITE9zZHpqUmxITzlN?=
 =?utf-8?B?dVhrYitKMzJJaHMrQk50eWQzSTV4UGo0dVBxdERjZmg2aU4zejBhaktGRTNH?=
 =?utf-8?B?aG96N1NSQXgyZEpaRGRDc2FML21icEJseWhDQzhEaW1OZXVzM3lST0FCd3BK?=
 =?utf-8?B?elkrU3M3d2ZHYnlIa2ZrSk82c2RkNmNoY1BLUUFJSDU5bHBUdjdDYjc5bTZR?=
 =?utf-8?B?TVRlZU4ydXI5T1VieDBkUGNiQVlGWVN6NWh6UnFMOFZkdFZicmVJR1JvQTQ2?=
 =?utf-8?B?Z3V4Szk0VFNQcUpPTUM1cVUvWGwvY2pxNGpDR2hSQXUwSGI4RVlNKzJGWGo4?=
 =?utf-8?B?eUFZOFljVjgwUkgzSnhmbjNqRlJldnE3V3FWY0h3eWk1WTRNTW45VGNFeGxL?=
 =?utf-8?B?UE05UTZrT2ZLdGVkdnRHREJOY05xUUtXU3NjZjQ3R2F5ck1UeStlb3FiZlFq?=
 =?utf-8?B?U3g4R2t1aEF6Y1pyR0tvYkdiRlZyTjN2aEJGeUszQ1NTTWYxeGVUVFc5RGJy?=
 =?utf-8?B?RUNwUkhoVjVFTFRxTDByVThLeUxtMm1rVEVtVWhEV3FqSHFsdlpveFJwYXhD?=
 =?utf-8?B?THVvRWJKUy83a1p3Z2MrSGFiRURFcHNLRFZZcXBWOWg4SEFVbzcyR2MwVHFS?=
 =?utf-8?B?UlNybWFrY29KZ09JWHlYN0hHWW0zVUwwQWVZdzZiYjZNRlVGbU1pYm1SZFFL?=
 =?utf-8?B?aHJrWngxTFZCcTZtRzF0OE93cjY3bFhqRUZvWjUyTkxWKzd5a1kxb2lwckRN?=
 =?utf-8?B?SUt4aDB6djhlV2dOckc5TzR6QnVpVCs3UjZhMXlXQSs0YUR3LzhnTzBMNCtV?=
 =?utf-8?B?NGpuZ2ROUkhVclJSUXdwSGJyTUdUSStQakpqYy9TN3phSFNEbEgrdkVHdmQ0?=
 =?utf-8?B?ZXJabUw2U3ZkOWZiNXlFdWxScWdTUnVJY1NsNkhCWEdrdmdOVXNxL1ZpdkZO?=
 =?utf-8?B?ZXNyU25PdWhNR1pzblhXSW0vRC9MeE5jT01PT3JTU1RrQ2dNR245V0oyMzJ0?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517b53a9-f9a4-4960-dc07-08dbe20a4859
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 16:29:59.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/RvOCoy6/elht3hwFGfCKf7eiy7h0ah8fxgbjUUOJb78mXZ4BNdGAY0pnlHuLrFP+iaD8sT+Mr2PXapPKkwHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7331

On 03.11.23 16:23, Florian Bezdeka wrote:
> Cleanup private definitions of ARRAY_LEN and re-use the new definition
> in ancillaries.h where necessary.
> 
> We can use the definition from ancillaries.h inside the testsuite
> as well.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/boilerplate/ancillaries.h            | 2 ++
>  lib/analogy/calibration.c                    | 3 +--
>  testsuite/smokey/alchemytests/alchemytests.c | 2 +-
>  testsuite/smokey/psostests/psostests.c       | 2 +-
>  testsuite/smokey/vxworkstests/vxworkstests.c | 2 +-
>  utils/analogy/analogy_calibrate.h            | 2 --
>  utils/analogy/calibration_ni_m.c             | 1 +
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
> index 319d22f66..e61a0fcfc 100644
> --- a/include/boilerplate/ancillaries.h
> +++ b/include/boilerplate/ancillaries.h
> @@ -30,6 +30,8 @@ struct error_frame;
>  
>  void __namecpy_requires_character_array_as_destination(void);
>  
> +#define ARRAY_LEN(a) (sizeof(a) / sizeof(*(a)))
> +
>  #define namecpy(__dst, __src)						\
>  	({								\
>  		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
> diff --git a/lib/analogy/calibration.c b/lib/analogy/calibration.c
> index b50cb2f9c..83eda706a 100644
> --- a/lib/analogy/calibration.c
> +++ b/lib/analogy/calibration.c
> @@ -27,6 +27,7 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include "iniparser/iniparser.h"
> +#include "boilerplate/ancillaries.h"
>  #include "boilerplate/list.h"
>  #include "calibration.h"
>  
> @@ -37,8 +38,6 @@ do {										\
>  		return -1;							\
>  } while (0)
>  
> -#define ARRAY_LEN(a)  (sizeof(a) / sizeof((a)[0]))
> -
>  static lsampl_t data32_get(void *src)
>  {
>  	return (lsampl_t) * ((lsampl_t *) (src));
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> index e3454074d..742f4d923 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -36,7 +36,7 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
>  	int ret = 0;
>  	int tmp;
>  
> -	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
> +	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
>  		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
>  					 "--cpu-affinity=0", &test_ret);
>  		if (test_ret)
> diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
> index dc0fe1d39..be6443dbc 100644
> --- a/testsuite/smokey/psostests/psostests.c
> +++ b/testsuite/smokey/psostests/psostests.c
> @@ -51,7 +51,7 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
>  	int ret = 0;
>  	int tmp;
>  
> -	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
> +	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
>  		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
>  					 "--cpu-affinity=0", &test_ret);
>  		if (test_ret)
> diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
> index 2a816804b..fa158b4cd 100644
> --- a/testsuite/smokey/vxworkstests/vxworkstests.c
> +++ b/testsuite/smokey/vxworkstests/vxworkstests.c
> @@ -28,7 +28,7 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
>  	int ret = 0;
>  	int tmp;
>  
> -	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
> +	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
>  		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
>  					 "--cpu-affinity=0", &test_ret);
>  		if (test_ret)
> diff --git a/utils/analogy/analogy_calibrate.h b/utils/analogy/analogy_calibrate.h
> index aeb6355d0..728ee1208 100644
> --- a/utils/analogy/analogy_calibrate.h
> +++ b/utils/analogy/analogy_calibrate.h
> @@ -36,8 +36,6 @@ extern struct timespec calibration_start_time;
>  extern a4l_desc_t descriptor;
>  extern FILE *cal;
>  
> -#define ARRAY_LEN(a)  (sizeof(a) / sizeof((a)[0]))
> -
>  #define RETURN	 1
>  #define CONT 	 0
>  #define EXIT	-1
> diff --git a/utils/analogy/calibration_ni_m.c b/utils/analogy/calibration_ni_m.c
> index 6f9be6fc9..a243b5b03 100644
> --- a/utils/analogy/calibration_ni_m.c
> +++ b/utils/analogy/calibration_ni_m.c
> @@ -23,6 +23,7 @@
>  #include <rtdm/analogy.h>
>  #include <math.h>
>  
> +#include "boilerplate/ancillaries.h"
>  #include "calibration_ni_m.h"
>  #include "calibration.h"
>  struct listobj ai_calibration_list;
> 

There are some more cases that could be converted, try

git grep "sizeof(.*\[0\]"

Some are false positives, for sure.

Nevertheless, this is a good start.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

