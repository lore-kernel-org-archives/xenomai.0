Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C619BDE
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J5pfwJEy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kqd/3wE0FoMf/mtOEss7JwTvKvpWKPTSgw3JiQsD9Pcxa5FJuuVqEdiCMJJGK+PPZoCbAEG2jVdkqfzFkyz+q7kYO0jEUkPHfwtGCE5omROocIj2IvftVELIl90hZZmtvXiZVqM4UOMsrTKlWw61tx3wnKANLUVpHCWEc/GeDJYpY2AIIFttHsNTfmUWtvC9WgGN5m5sQwGIWUaIxP//QVah410JmLphl1ro5bON039FHfoZdg/H4QOirgP+f3cqG14dVG3eT+8M1C+2/spktzgRVS0Qc3Bkgg5JDvQRBR2b3xjPxlRxxj8Aa3SrkjW5jgrvrKSUCGHURVtDHngBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLC8bcPsGlH9/Vn1GVOzT9E5Ylmjrv1gWC4MQ1BlpFw=;
 b=jc3vC8INPojVDj1As3MoozhCT0qL/QnyJW2PuTijJB4CGZK15WPuij8HDwf2+XIv6sweK6tJdAJ25t8/CtVxcoCns/J016gXDmfjmkCyXoa/XC2aF0N5CNZZx6i7hXiM6MvrvdqQ6or/WHxlH9xkApKgUcOwUIyjWBXjSMbPy97w8hPgLME2r94akBparRcIbl94OqdP86WWvxz82hnKopMFxe+U7PKBo76vK1cxLtSjtfoK5DXQMHYawE3GSw1g4fdcIbA1dlm13TN1Dzj9/mpkal6G2cuV8//YZqWp30g6d+5pexGkgR/73d8JxDR9YpMoIK56GYL0egaKj3ggTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLC8bcPsGlH9/Vn1GVOzT9E5Ylmjrv1gWC4MQ1BlpFw=;
 b=J5pfwJEyjoHriwWS7GkTzJuzl3EEg05SLD0cRPRrMSc/sXPrfOLbZcptl4szkhMVN0qqHpQVa7bSl4CBrCZtLP6oksHVcwClu61kz3Iflr96GuDIHGBEn+cAludiYE45/PgwM6+MuH65IfqLFT/mUV0YB4dETR2ya4RVYlE2pN9rKs0Z5QsKzm2TJ8mRvVAawkEBpQgo5nqsLC3DMKZODEv9Z/Ov8Pz4fzVqNkWKfZF5dFmXWBvfehO6VxMdIeopUNlzgIEq0OHoVtdIjqIX/VpuMcjfrf4Nx81+n7FvqCiiRKzf9C2MOGnAwaC74+ofedydM1P2Jc4pa8xLqAuiLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6376.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:557::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 14:54:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 14:54:38 +0000
Message-ID: <58bf5f9b-9f82-456e-9567-0837602f3166@siemens.com>
Date: Thu, 2 Nov 2023 15:54:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] testsuite: smokey: Refactor smokey_run_extprog()
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
 <20231030-flo-cleanup-testsuite-v1-2-0fb7bbd2d45f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-2-0fb7bbd2d45f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: c98005a6-23a7-415d-165a-08dbdbb3a310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GGL2DAzDq/wYI9uOcrgBEAXVzRBkuiM1sQ5GgRE6/SGMss3+c+5IrmBsT2D2DR1d541+3e6s9jWudb1qHL/CtZra09cpDeXJ+eZMw0i35NNKzl/M3groMSDjn23otdiHW9mwuB3H2XJLt43cgTx/bWoJAhlYtvc9F+dB0+2yIu8e3HxwYxID9KKyI/KCFutN/fJKkmvKvtnAF91JyzxzZm9kCJJRREuKhPccU2SKdy0lyndHUu7Z1MqS4i1SEwHf8i7BHMWXUN+lerHkK+CLfnx4ppbWytFsysUMJYB3dfN2//eEkRzoxoXQWrInLA7Wt1QAKkZLLtk2OawhtlmvOBLGM7WTHtkwMaLDX9hVRynM6eO1mkVaIC0L60kAFvIoSAZqHWk9mhfrEX0yqaGlqW2dQaLQvKWeNox3NypuO0v+G3kPMgw+jV8wmizpmFO2JWOzNsFHO/hZR5qnTQ09GVmvWm+nWlNWER8jlbsneZWn2OaXt9hdd5BpuuJP74JkHfuxtuVPiY2w0qdJbLa+A1BKu6y0vzxtbZtp1ppKykrKcHDiQ0ln/CFntwrkwfbHYPCPLE1FAo9iUICzotVfrQ1EJXHl755+O1zK0cf3clYi/HU+W7Ldlpp9gXnw0gHneX4F2Lc2K8RBX41q6AR1e5RFnO8Iy7ns2QaoHmZ3bv/bZ5R+1wVf+s0OYxlKbbFg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(30864003)(41300700001)(2616005)(26005)(83380400001)(31696002)(86362001)(36756003)(82960400001)(31686004)(38100700002)(6486002)(66946007)(66476007)(5660300002)(66556008)(44832011)(8936002)(8676002)(316002)(53546011)(6506007)(6512007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cy9SMUVvY1FKQ2VoNjFiRWVEU3paamZCVkV4UjhiaUdvNUs0ZjYwSFNWMFRE?=
 =?utf-8?B?TGxOY29CUnNXV3RiczZjN2RFMWxYcXp1WXVuWTlpMjh4TVhUdW5ub1k2M0th?=
 =?utf-8?B?SkhuMHNZTjh5NitnbjFPUnFyUE43UFQyRTd6L3MycDhYRkwyVHB5ZEszQ2ho?=
 =?utf-8?B?ai9YWHJ5R3R4MEhGTFlKbzhOTy9YWFp5dWh1cG54bXp3U3BFZ3kzcVAwTkIw?=
 =?utf-8?B?eDVTM25kRVc5STdwR0pLZkc4ejRyNEZhSEY4MUxuYytvZ1F5MDAzU2dTUzRU?=
 =?utf-8?B?T0g2TXJNT1phME9hUDBHUDd2bXRic2RHU1RmMWdVQmhYcGZiMnBjOExNS3dR?=
 =?utf-8?B?MVJDZGZPRG16SjNRUTE1emhnYUVaTVA2b0NyWk42Q3pQeHpEQVkxLy9GRDFW?=
 =?utf-8?B?bWtscU5CdmRrVTl4UzBXeVJma2owV3dPZ3FCT2dWUy90dmx1R25CZkR4blBp?=
 =?utf-8?B?dDQ2TWkvVFdXcmRkeWRYVWRGOXQvK1VRTUNkSGdSU0pLQndOa01uUWpPOTRE?=
 =?utf-8?B?NEdkMjMvQ3JVcHJ0TXpKQlordStYZ2NHaUJBSUJYVFMwWG9zK01IYzNXc2ww?=
 =?utf-8?B?WEtFQVlNN1UzQ1o3Y2Y3bmlLTUZTc29kM3JoNXFvWGlxb3dLSEJQNy9Gakhv?=
 =?utf-8?B?TXdsRHNwRGJqVVNXdEtEZXZ5dTRoSkFrdXhUcklqdTl1NFJHd2c0YThRd3RH?=
 =?utf-8?B?VS85UnVyTUVTSWJZdWtUQVNBU1Bhc0xHVStsZkxUcU1wejl1NUN6ci9rWld5?=
 =?utf-8?B?NVcxeFdxWjY5Q0IzU2NOMHFVQTBVOVdkSUJGUDFNSmhic2Q2TTJqa1NSVDRN?=
 =?utf-8?B?bEluYmgyMHUrZGo2WDF4WWRkNUNkQzJhc1lmMFZEZk15VG9XdmpyMXFxeFZS?=
 =?utf-8?B?S1pyWGhKM2pocGg3cTRKaTgyZEdERjRSMURLQkVzUjdveGVScE9sUWNUNGdL?=
 =?utf-8?B?U2xEalJUekRPQWVPcWdzRyt1bEM0SklaK1ZaY21lOHF6bXgwOHN4eDNoeW5C?=
 =?utf-8?B?MGZwUklITTFtM012Nm5KMnlPK2hkanowTGZhUHJ0SWhOVm5Lc3J3UG1xbEFl?=
 =?utf-8?B?U1QzUmE4S0hhZCtBMFpOd1NXRzhjSHZ2VEg2WnZvZmdaSmhScDlZUWRnWlNM?=
 =?utf-8?B?WmcySy9uLzFqenVOc0N5SDBOU2RxYkd5L1VVTVdHd1N4QzFiaytDVEJ5TjU1?=
 =?utf-8?B?T1cxdGp5UDE2TURxUjBmOVl5cXFpUjJNYWw2RzhNdHMwaTY1REh2bDNjWkx5?=
 =?utf-8?B?RXFxTVR0OGx1Q2NnK1RpeC9wZjJJRkNkQklGU2ozMUNIZXRHSDZvMUdGT2Mx?=
 =?utf-8?B?NGRobHI3V3pvWkdOTXRJUGVGbHZ6MlpaOUpWWnYrMGRIK0s4QmxsaEJCc0pr?=
 =?utf-8?B?bjk2TXhrN3hRNndsWDFIMXlIQzJFMWU4bEdWSVcwQ05TaC96SWFKdmRPZ0RJ?=
 =?utf-8?B?QVc5UHZ4Vy9MOC9Id1pzVVVXYmgvWDY4enhxODhtWnY4WklwbUFDZHFTR3p1?=
 =?utf-8?B?aGJPRkZQM0lvL3lhUlRkbmZmWWZ3VFlXVHNBV0RGcU9ucHJFc3dVbmlpYmVG?=
 =?utf-8?B?ekRyazhGTGd3UVk2clhpWERNdFc0cE9FR3Q4YVJ6RTJEZ1VNdGRIOVNpS2Ns?=
 =?utf-8?B?K1pmM3crV2RPWTBRb2pkZmdaZlRmakhWZnlQYk56OUFHSVU4MkY0T21xVVo3?=
 =?utf-8?B?WDdXaDVuUzlLajJQd1ptaU54bXJtQW85NlNPa2J6ZCtaT2d2M3BXekxrRGZI?=
 =?utf-8?B?TUpPeEt1aFYrNkttZitWWjdSTE1MUmVXY05DT3QxVFpPTks0eGRHd2hlNFh5?=
 =?utf-8?B?aUFLVEx3NWc5YVZKMXhtdzY1MXBqS1VmVjdZOHVuTHJNMCsvckZFNTlwSXFq?=
 =?utf-8?B?amZybkRzQlVCc25XVjRDK3N5UFlGbUFlV1l6SlJRNlk5dzNyUlA5NWV2TStj?=
 =?utf-8?B?NDdrYWdwbVBVekJ4cHZ0YVd2U2F5ZGFQYmg5TUpzdXdFVTUxUTBvNm1XQ29s?=
 =?utf-8?B?N1NVSi9UT1l1eWs4Zk5ScmFTSmxNQkhtVnhSZ0d3U0J2MlRFbDZUMEhqNS9t?=
 =?utf-8?B?YW5NdndjcXhTYS9iNHBGeFg5aGpPYUpJTGRKdnR1Q2tlWk9GdFFGWDN1aW9R?=
 =?utf-8?B?NFpXWXU0anVEem0xVGhaQmdwZU0zejZDV3Yrb1Buc3dodFdyejJnK1ZrY2wx?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98005a6-23a7-415d-165a-08dbdbb3a310
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 14:54:38.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kixI9URbQxoNdoHzxjUgPcNtTRYAPmpxpEE5kEJwpO6tiAoVThWmc6VJfIxsPSuaDq5dYSlU4JoHl2kegL3MQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6376

On 02.11.23 15:41, Florian Bezdeka wrote:
> smokey_run_extprog() and all affected call sights had the following
> problems:
> 
>   - There is already a variable named t, so the loop variables were
>     shadowing an existing variable (did no harm but triggered a warning
>     of my linter)
> 
>   - The combination of --verbose and --keep-going was broken
>     --verbose stopped the test run due to error() usage.
> 
>   - The reporting of the test result was broken. If a failing test was
>     followed by a successful one the failure was never reported.
> 
>   - There was duplicated code at all call sights with the same problems
>     mentioned above and an unused variable (fails)
> 
>   - Checkpatch complained that the test list should move out of the
>     function and that it should be static.
> 
> All users of smokey_run_extprog()
>   - should abort the execution / the test run when the return code is
>     non zero
>   - should use the value of the last parameter for error reporting.
>     An error happened when the value is non zero.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/smokey/smokey.h                      |   3 +-
>  lib/smokey/helpers.c                         |  14 +++-
>  testsuite/smokey/alchemytests/alchemytests.c |  74 +++++++++----------
>  testsuite/smokey/psostests/psostests.c       | 103 ++++++++++++---------------
>  testsuite/smokey/vxworkstests/vxworkstests.c |  57 +++++++--------
>  5 files changed, 118 insertions(+), 133 deletions(-)
> 
> diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
> index 3623ba18c..0c20f5d69 100644
> --- a/include/smokey/smokey.h
> +++ b/include/smokey/smokey.h
> @@ -259,7 +259,8 @@ int smokey_modprobe(const char *name, bool silent);
>  
>  int smokey_rmmod(const char *name);
>  
> -int smokey_run_extprog(const char *dir, const char *name, const char *args);
> +int smokey_run_extprog(const char *dir, const char *name, const char *args,
> +		       int *test_ret);
>  
>  #ifdef __cplusplus
>  }
> diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
> index 4c90a513d..bc4b3f9bb 100644
> --- a/lib/smokey/helpers.c
> +++ b/lib/smokey/helpers.c
> @@ -411,10 +411,11 @@ int smokey_rmmod(const char *name)
>  	return err;
>  }
>  
> -int smokey_run_extprog(const char *dir, const char *name, const char *args)
> +int smokey_run_extprog(const char *dir, const char *name, const char *args,
> +		       int *test_ret)
>  {
> -	int ret;
>  	char *tst_path;
> +	int ret;
>  
>  	ret = asprintf(&tst_path, "%s/%s %s", dir, name, args ? : "");
>  	if (ret == -1)
> @@ -423,5 +424,12 @@ int smokey_run_extprog(const char *dir, const char *name, const char *args)
>  	ret = system(tst_path);
>  	free(tst_path);
>  
> -	return ret;
> +	*test_ret = ret;
> +
> +	if (ret)
> +		smokey_note("test %s failed: %d", name, ret);
> +	else
> +		smokey_note("%s OK", name);
> +
> +	return smokey_keep_going ? 0 : ret;
>  }
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> index b9e84ac1e..e3454074d 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -5,50 +5,44 @@
>  #include <string.h>
>  #include <smokey/smokey.h>
>  
> +static const char * const tests[] = {
> +	"alchemytests_alarm1",
> +	"alchemytests_buffer1",
> +	"alchemytests_event1",
> +	"alchemytests_heap1",
> +	"alchemytests_heap2",
> +	"alchemytests_mq1",
> +	"alchemytests_mq2",
> +	"alchemytests_mq3",
> +	"alchemytests_mutex1",
> +	"alchemytests_pipe1",
> +	"alchemytests_sem1",
> +	"alchemytests_sem2",
> +	"alchemytests_task1",
> +	"alchemytests_task2",
> +	"alchemytests_task3",
> +	"alchemytests_task4",
> +	"alchemytests_task5",
> +	"alchemytests_task6",
> +	"alchemytests_task7",
> +	"alchemytests_task8",
> +	"alchemytests_task9",
> +	"alchemytests_task10"
> +};
> +
>  static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
>  {
> +	int test_ret = 0;
>  	int ret = 0;
> +	int tmp;
>  
> -	char *tests[] = {
> -		"alchemytests_alarm1",
> -		"alchemytests_buffer1",
> -		"alchemytests_event1",
> -		"alchemytests_heap1",
> -		"alchemytests_heap2",
> -		"alchemytests_mq1",
> -		"alchemytests_mq2",
> -		"alchemytests_mq3",
> -		"alchemytests_mutex1",
> -		"alchemytests_pipe1",
> -		"alchemytests_sem1",
> -		"alchemytests_sem2",
> -		"alchemytests_task1",
> -		"alchemytests_task2",
> -		"alchemytests_task3",
> -		"alchemytests_task4",
> -		"alchemytests_task5",
> -		"alchemytests_task6",
> -		"alchemytests_task7",
> -		"alchemytests_task8",
> -		"alchemytests_task9",
> -		"alchemytests_task10"
> -	};
> -
> -	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
> -	{
> -		int fails = 0;
> -
> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
> -					 "--cpu-affinity=0");
> -		if (ret) {
> -			fails++;
> -			if (smokey_keep_going)
> -				continue;
> -			if (smokey_verbose_mode)
> -				error(1, -ret, "test %s failed", tests[t]);
> -			return 1;
> -		}
> -		smokey_note("%s OK", tests[t]);
> +	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
> +		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
> +					 "--cpu-affinity=0", &test_ret);
> +		if (test_ret)
> +			ret = test_ret; /* Return the last failed test result */
> +		if (tmp)
> +			break;
>  	}
>  
>  	return ret;
> diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
> index e35dd82c5..27896d8fa 100644
> --- a/testsuite/smokey/psostests/psostests.c
> +++ b/testsuite/smokey/psostests/psostests.c
> @@ -1,67 +1,58 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <error.h>
> -#include <stdio.h>
> -#include <stdlib.h>
>  #include <string.h>
>  #include <smokey/smokey.h>
>  
> +static const char * const tests[] = {
> +	"psostests_mq1",
> +	"psostests_mq2",
> +	"psostests_mq3",
> +	"psostests_pt1",
> +	// 0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
> +	// testsuite/psostests/rn-1.c:46
> +	// => "ret == 0"
> +	//"psostests_rn1"
> +	"psostests_sem1",
> +	"psostests_sem2",
> +	"psostests_task1",
> +	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
> +	//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
> +	//"psostests_task2",
> +	"psostests_task3",
> +	"psostests_task4",
> +	"psostests_task5",
> +	// 0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
> +	//		testsuite/psostests/task-6.c:62
> +	// => "ret == 0 && oldprio == myprio"
> +	//"psostests_task6",
> +	"psostests_task7",
> +	// Runs forever (100% CPU)
> +	//"psostests_task8"
> +	// 0"002.198| WARNING: [main] lack of resources for core thread, EBUSY
> +	// 0"003.421| BUG in __traceobj_assert_failed(): [root] trace assertion failed:
> +	//	   ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-9.c:29 => "ret == 0"
> +	//"psostests_task9",
> +	"psostests_tm1",
> +	"psostests_tm2",
> +	"psostests_tm3",
> +	"psostests_tm4",
> +	"psostests_tm5",
> +	"psostests_tm6",
> +	"psostests_tm7"
> +};
> +
>  static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
>  {
> +	int test_ret = 0;
>  	int ret = 0;
> +	int tmp;
>  
> -	char *tests[] = {
> -		"psostests_mq1",
> -		"psostests_mq2",
> -		"psostests_mq3",
> -		"psostests_pt1",
> -		// 0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
> -		// testsuite/psostests/rn-1.c:46
> -		// => "ret == 0"
> -		//"psostests_rn1"
> -		"psostests_sem1",
> -		"psostests_sem2",
> -		"psostests_task1",
> -		// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
> -		//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
> -		//"psostests_task2",
> -		"psostests_task3",
> -		"psostests_task4",
> -		"psostests_task5",
> -		// 0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
> -		//		testsuite/psostests/task-6.c:62
> -		// => "ret == 0 && oldprio == myprio"
> -		//"psostests_task6",
> -		"psostests_task7",
> -		// Runs forever (100% CPU)
> -		//"psostests_task8"
> -		// 0"002.198| WARNING: [main] lack of resources for core thread, EBUSY
> -		// 0"003.421| BUG in __traceobj_assert_failed(): [root] trace assertion failed:
> -		//	   ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-9.c:29 => "ret == 0"
> -		//"psostests_task9",
> -		"psostests_tm1",
> -		"psostests_tm2",
> -		"psostests_tm3",
> -		"psostests_tm4",
> -		"psostests_tm5",
> -		"psostests_tm6",
> -		"psostests_tm7"
> -	};
> -
> -	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
> -	{
> -		int fails = 0;
> -
> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
> -					 "--cpu-affinity=0");
> -		if (ret) {
> -			fails++;
> -			if (smokey_keep_going)
> -				continue;
> -			if (smokey_verbose_mode)
> -				error(1, -ret, "test %s failed", tests[t]);
> -			return 1;
> -		}
> -		smokey_note("%s OK", tests[t]);
> +	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
> +		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
> +					 "--cpu-affinity=0", &test_ret);
> +		if (test_ret)
> +			ret = test_ret; /* Return the last failed test result */
> +		if (tmp)
> +			break;
>  	}
>  
>  	return ret;
> diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
> index f7974cb5d..298bb3d1d 100644
> --- a/testsuite/smokey/vxworkstests/vxworkstests.c
> +++ b/testsuite/smokey/vxworkstests/vxworkstests.c
> @@ -1,44 +1,35 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <error.h>
> -#include <stdio.h>
> -#include <stdlib.h>
>  #include <string.h>
>  #include <smokey/smokey.h>
>  
> +static const char * const tests[] = {
> +	"vxworkstests_lst1",
> +	"vxworkstests_msgQ1",
> +	"vxworkstests_msgQ2",
> +	"vxworkstests_msgQ3",
> +	"vxworkstests_rng1",
> +	"vxworkstests_sem1",
> +	"vxworkstests_sem2",
> +	"vxworkstests_sem3",
> +	"vxworkstests_sem4",
> +	"vxworkstests_wd1",
> +	"vxworkstests_task1",
> +	"vxworkstests_task2",
> +};
> +
>  static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
>  {
> +	int test_ret = 0;
>  	int ret = 0;
> +	int tmp;
>  
> -	char *tests[] = {
> -		"vxworkstests_lst1",
> -		"vxworkstests_msgQ1",
> -		"vxworkstests_msgQ2",
> -		"vxworkstests_msgQ3",
> -		"vxworkstests_rng1",
> -		"vxworkstests_sem1",
> -		"vxworkstests_sem2",
> -		"vxworkstests_sem3",
> -		"vxworkstests_sem4",
> -		"vxworkstests_wd1",
> -		"vxworkstests_task1",
> -		"vxworkstests_task2"
> -	};
> -
> -	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
> -	{
> -		int fails = 0;
> -
> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
> -					 "--cpu-affinity=0");
> -		if (ret) {
> -			fails++;
> -			if (smokey_keep_going)
> -				continue;
> -			if (smokey_verbose_mode)
> -				error(1, -ret, "test %s failed", tests[t]);
> -			return 1;
> -		}
> -		smokey_note("%s OK", tests[t]);
> +	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {

I'm seeing quite a few hits for "sizeof(.*) / sizeof(.*\[0\])" and a few
private definitions of ARRAY_LEN or ARRAY_SIZE - maybe we should move
that into include/boilerplate/ancillaries.h? Something to be done on
top, not a blocker.

Jan

> +		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
> +					 "--cpu-affinity=0", &test_ret);
> +		if (test_ret)
> +			ret = test_ret; /* Return the last failed test result */
> +		if (tmp)
> +			break;
>  	}
>  
>  	return ret;
> 

-- 
Siemens AG, Technology
Linux Expert Center

