Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9F7489
	for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 15:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwtaVxozF6yVcc9XXjMfR8DuA7pRfiDAtPoMql/m3YW/tM9nu3H1SLZn4WRfNdG3XSrz79BIsF0NOEXIPbvTJ6Rv15xUp0cGBhK/oJGrIjoILV3JzwfHRKy3SLBS6/pRzEZr+w34l+P2uAdfieon1NlMNbIJpdNDJPiVBtFDUGo/UofsI3q61DZ3yfCk3GRHwfYE6oaBGjukXe9v8D7+imaqmHhaftsaWdXERdo/Vi8JhOf2l3VbPd9ZOxzg+ZXiIJ4YnHECXJEx6Ro80BnEoVXMMDDGTsydOn5XcRh+XZvwdZj1v+cEarbCe5LY//i8ujsimhMMmo9iDJlfNOxb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJZZzOoW9n6SD36ZsnGKhyrRqIJzktANO/oUlSjf+4M=;
 b=APdyyyw5Oehj1UKWcdg+X1bV/mVwyQvBA/7pvWiS9D9uaJcfVB29GuL9uqzWPOjxeTrw26VM5aG7kzFFC636amn4b9ngc3HNY8OWV+2pvtxOqPvVtFxF8dDITyJhJl09eIQgw4aoQtG7McVwBL2n2FQOEr0LsPZJlcyQI3ED8HWj18lDtmViM2NR1up9quTm+LoIUVHeiQYpwdjCJvj5UYiGlqceeMf/zlJ89KzDAKU2w6ev9FFHgYHWjBIQlkuenQvtg7MF504xaHwhmRQAoAZzeq4pA4TzDAzbtgTb6vH4KqTGl4Kq2/ncew2YR6lokW3Gql5ZdnQ7c/F/Ha5U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJZZzOoW9n6SD36ZsnGKhyrRqIJzktANO/oUlSjf+4M=;
 b=RRjxO7tAd5qaBsGTVOBJeD/Qk1YAYqMUNTMqlENfBHzonPRejKSJ73QqRzB5r+/G7QTAtn58XyQOk6xwVMW9Gzls9AmZ6khiD+zxAEXLkAFTcSxkPcMmfSpUK2DLtlj5S29hpbGEp1JOQ/7pZohi7aDQVZFB/m8HuS11A/pBvHhkULj07uQoeVvTpIkzCtFCqchZLaQd29pgB+NrlDhjtoQZN/qGlT6OqGgO1xUScC7vVk+1BLmfMj6+EWbVqmqdejKQk0wzbEw+FML7tGyRlM9nhm9RjnEqw/Snb+ocwOJrQDp/wXg/P9xapI1dRO/7278zvtG9BJ1xN15ZFt/PuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 15:42:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 15:42:57 +0000
Message-ID: <fb162398-31b5-4b67-9d2c-69955e76b689@siemens.com>
Date: Mon, 25 Sep 2023 17:42:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib: Drop cpu-affinity=0 from skin-tests helper
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <20230925130311.17757-1-aaron@sigma-star.at>
 <20230925151256.22161-1-aaron@sigma-star.at>
 <20230925151256.22161-2-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230925151256.22161-2-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:610:b3::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: a2695d08-9834-4ac7-534e-08dbbdde16ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BTKhcdOBJvL2CojPMfCSyMJMUlxZFB+klkkhbxmR+XaSU4+R1gZF0sHHxv/K9cWnjvPQ0225i0ujToeTl68KWQteigAhWn/9boYW3vYOZKU73KePKO/Tdh7Wgq59UpA0obuwL7/azr9P6da5vcW5rAch8G4KpwOBc4BLKrq9axDgabxSABMQ9+0MTywl+JKc7uuhZxelUbiyC7Xp8tb6PfoMuxGTDIABGbpaDdj4kJVIgriQzjYaUNxGdQeuhIjHqo6c56CC1p6+lJd13w3waxOTa5tc2OlsLIPtgvHSH9U56DMopPM/Lzs+exofjjhRouG7HjcbJDvI+3WFsjvbGZvmOe6YmmOzC5nxy1k1vUe3lOpyuuDwFeTDoMmDcUXRy/LpkDx2j58Oui5SGTAcbbXNZBu666A9NIWJMELipxfDbIeVqS3v6xTuFyf5TINiAf4SIUWU6ipBOp4vW8JqSYYlIiRI/Bdn9oSJoa/R2TLFou2Z5FSyv/VRaHK1A1CxEcxh4YsDf4OMUMULjogUGH/XJ1thFXKBaF+Gup/B9tF3aqF6BnYrReoDTqdKBSBfka3uusqgSg78HnbOLJotBlB5csbr+e6e6Os4oO5oJnQxR7XiN+FUaeAaY+ApxpeEabU37I1w2yd2r5IAWZb3qA2vHKvUUVeWqQSWvrJ/cPceO/EqADbPPovkhoZpJBt0P3nhmsENecRBN3rp/PYUTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(5660300002)(8676002)(478600001)(66556008)(44832011)(66476007)(66946007)(8936002)(4326008)(31686004)(6486002)(6666004)(6506007)(53546011)(6512007)(36756003)(2616005)(83380400001)(86362001)(38100700002)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnZvMEFOdEhTS1V3c2lsTUdQbWZVUWlreUYrRGtOYzBjZStkdHJwSjNQRFRP?=
 =?utf-8?B?ZDU3eWpkWkFtcGhuZHdxU044UWZqWGdjbmtKekVUSGJEN0tJZk90NmJ2N21y?=
 =?utf-8?B?UXAxZ3I3dmtrMkRCVW5nNDZUQm9BbEE0VHl0YTJNTlhIaSt4ZktLWXZLTkVG?=
 =?utf-8?B?U2dMMlJuTEg1SlNMNzRPUHVtTEx3NkdtcFFTQlRwZlhWaTNRRDEzK3RFNWcv?=
 =?utf-8?B?VXJzNHcrNkVQL0NJeEZXMVN1OGVySGYzdlpEdHFSc2VSWGhPb0liY29qblNL?=
 =?utf-8?B?VEQyOEdBaXZEQmVSTWJvV29SYjJ6RU16WUpSamE3OXByajVVNzVQaHVLVEs4?=
 =?utf-8?B?Um1QZzdzeUNzYWUrMkdBYm9JV0NONjhNdWdMb0JyeTVzYlI1a2c5TFU5Tm12?=
 =?utf-8?B?dHZLeURMRm9WdHNYNUF0aS9EeCswekJlU2Y4YndPd0IrOWpIdWxaR0dmY1NG?=
 =?utf-8?B?WnFYMmhMaXl0cGxVcjNkNkZuK2ErV1FMWVQ0Y05MbGlXMXQvK1k4T2ZtUEVj?=
 =?utf-8?B?UlN6czZoOFpQcUlPZ1VXWDhPUDAxTnY2dDB1Qml6cHIwRks1NlBtRWtOcGlC?=
 =?utf-8?B?WXUrM1dBQ1V0bnpPRytNQTRoYzc3MXJzNU5qUDh2WnF0aDVhN3g1QmdtZjEy?=
 =?utf-8?B?bStZcXB6RitOZWZFSWk0U2JrQm5Ha0libGN5NUlyUUZ5TkRzQzFNbTFvT2dH?=
 =?utf-8?B?ZkFwSlRXVFY2dks1UEhTcFY0dXNkZlk5MjltQ1VnRkhSd0RVeDJ5QUNEbkIz?=
 =?utf-8?B?MW12RnYxSktrc1pCeTB6SGFUaXREaXpPVHFCalBjSWZhNEoyaFdoQWkrekdV?=
 =?utf-8?B?cG5abExQd01HVHJ1UG5jSFhvQXY3d1BTVFNoRUJhaUw0N1ZxZDRnb2x4bUhB?=
 =?utf-8?B?S2lWNlNmOEU4aGtoeFdub01XMHBPbnU1Q1lYRTNZVEx3VUtnUjFWeUxVRDZt?=
 =?utf-8?B?c0dGdVFqU1VCMHN6a1JRa2o0WndIL2E0TmJpeEUvVXAvcjBIcSsyODJqdjFu?=
 =?utf-8?B?Um1hVXpCc1Vsek1tT1RtYUxZWHl2UHEyY01JQUZ2b3R1REtaV3ZldU9Ma3Vr?=
 =?utf-8?B?Ylc1OWRQTUx2eG40UXRBcHUzNnk1ZWNTT0wxd3YwUkZpbFNGM1BPaXk5Nkxy?=
 =?utf-8?B?OHJ5SzQ5Qm5YQTNzVWg5cnlrMEZWR3Q2TDNXU0dBcVliaDVRRW5kbW10aXRL?=
 =?utf-8?B?dCtLNFU2ZDhyQXQ5emFMbGFJZkZDeTZqazBiaGFjcFpzQ3JmdlVpVmEvblNY?=
 =?utf-8?B?Vzh0TzF3dm0wUnhLbkxaUDZLbjZ6MC82ZVRBTWdRSkdLbG9YQUtsZG9xRnU0?=
 =?utf-8?B?b2NrdU0vQTNNUEcxb2s5SloyR3VTZEx6S2lVenJTZU93b0N4Zk5lWHllTlJm?=
 =?utf-8?B?UldKV3NTQk1MUmczdWVvaUEyZTNlY1dWb2lQamt1RXZ1Wktlc013TTJHNkdp?=
 =?utf-8?B?ZUN5dVB2a1JIS3k5M3VqOHlvWnFZMjhpZjkxVEJqeFlJdzBVQlVNWHBHc3hS?=
 =?utf-8?B?QUE0RGVxNmR5SDdZbjNaRWVCZEhZWkJrSXdHVHlIdy9vbWh5UnVtT0NMdGs3?=
 =?utf-8?B?TWNXNXZ2OVJYRldpWEh0M3pxR3JtdmhwelBIcDFCczJNTFU3UjZreU85dHNm?=
 =?utf-8?B?S0QwUjZEeHZHTUtERGkwRVhGaUNlK2RZRTU1bTdja1RLL3N1S2Y2QnFDTmZx?=
 =?utf-8?B?dkhKS25qVENVQmtaOTE2Tkt2aVBwSTNWb2xEV3lEdWl1VU9icjdDcTlKYTNw?=
 =?utf-8?B?WmYxaGx0ZmhrMlg4blE4Y29hblE3UzNmMytMRWJlZUdVMXM4bHBjWWMyQ2Q5?=
 =?utf-8?B?OUZqZDYvQkhBRHA3OWdXSXpNQVZLbmpWdWJONHpDWklTL2ZpVm9sTUhyd3lo?=
 =?utf-8?B?V0duZUh2a01lR2JISmljZUlVMEFzblVXTmQwVGVQUWpaa3dYbnBhQ1QwTFA1?=
 =?utf-8?B?a3BGSSt0RjVDeWpvOWhHc05TME9CL0ZXQlRNdnJUZnFnT2ZKUFVRdmZVTjhi?=
 =?utf-8?B?RWdNa3FmVXBLOFBNZHczdWgrNm05SHNPT01OTjhKRzNKdklQeUlnUmlCS2pN?=
 =?utf-8?B?c0U5Vk1vaW5EM3VFME90ekZnc2dzMWtJNFJnejRtbVoyM3NKNjh4S3Rwa0Jr?=
 =?utf-8?B?WitlZHlZT1JheU96SmZqS1hONzlJWTFrWmpXOUJDSnJPTWxUNGlsbE12c1d6?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2695d08-9834-4ac7-534e-08dbbdde16ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 15:42:56.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM6dKX8+94fYc3/T9DTNaEs5wOiJr+KjJ7h0nol+1YpxgCMqK9bxZBrdFIBM/2W5LesWD3HlP3tMksla5t80BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6810

On 25.09.23 17:12, Aaron Marcher wrote:
> Alchemy, pSos and VxWorks tests assume zero CPU affinity, but we cannot
> enforce that in general.
> 
> Introduces a parameter to control the arguments.
> 
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---
>  include/smokey/smokey.h                      | 2 +-
>  lib/smokey/helpers.c                         | 8 ++++++--
>  testsuite/smokey/alchemytests/alchemytests.c | 3 ++-
>  testsuite/smokey/psostests/psostests.c       | 3 ++-
>  testsuite/smokey/vxworkstests/vxworkstests.c | 3 ++-
>  5 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
> index 4d0fe011f..3623ba18c 100644
> --- a/include/smokey/smokey.h
> +++ b/include/smokey/smokey.h
> @@ -259,7 +259,7 @@ int smokey_modprobe(const char *name, bool silent);
>  
>  int smokey_rmmod(const char *name);
>  
> -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
> +int smokey_run_extprog(const char *dir, const char *name, const char *args);
>  
>  #ifdef __cplusplus
>  }
> diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
> index dfd63b409..99cd019aa 100644
> --- a/lib/smokey/helpers.c
> +++ b/lib/smokey/helpers.c
> @@ -411,12 +411,16 @@ int smokey_rmmod(const char *name)
>  	return err;
>  }
>  
> -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
> +int smokey_run_extprog(const char *dir, const char *name, const char *args)

Actually, argc/argv were dead vars before...

>  {
>  	int ret;
>  	char *tst_path;
>  
> -	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
> +	if (args == NULL)
> +		ret = asprintf(&tst_path, "%s/%s", dir, name);
> +	else
> +		ret = asprintf(&tst_path, "%s/%s %s", dir, name, args);
> +
>  	if (ret == -1)
>  		return -ENOMEM;
>  
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> index 5753af423..04f631bac 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -33,12 +33,13 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
>  		"alchemytests_task9",
>  		"alchemytests_task10"
>  	};
> +	char *args = "--cpu-affinity=0";

const? Maybe even inline into the call?

>  
>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>  	{
>  		int fails = 0;
>  
> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>  		if (ret) {
>  			fails++;
>  			if (smokey_keep_going)
> diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
> index a54e6ea31..f2a75c841 100644
> --- a/testsuite/smokey/psostests/psostests.c
> +++ b/testsuite/smokey/psostests/psostests.c
> @@ -46,12 +46,13 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
>  		"psostests_tm6",
>  		"psostests_tm7"
>  	};
> +	char *args = "--cpu-affinity=0";
>  
>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>  	{
>  		int fails = 0;
>  
> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>  		if (ret) {
>  			fails++;
>  			if (smokey_keep_going)
> diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
> index d3ac891ae..24ea8f0a1 100644
> --- a/testsuite/smokey/vxworkstests/vxworkstests.c
> +++ b/testsuite/smokey/vxworkstests/vxworkstests.c
> @@ -24,12 +24,13 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
>  		"vxworkstests_task1",
>  		"vxworkstests_task2"
>  	};
> +	char *args = "--cpu-affinity=0";
>  
>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>  	{
>  		int fails = 0;
>  
> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>  		if (ret) {
>  			fails++;
>  			if (smokey_keep_going)

I'm inclined to ask for v2 of the original series. 'next' is not
'master', we can still update it.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

