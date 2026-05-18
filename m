Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD63CCFD2
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096103; cv=fail; b=VVQP1XlWFwWVhRGyoWPflOpj3wX6PvGYyGOjeeLoQc4o6PpjVkTUZQjX0yyX26U1IyFGOd/hd7CBtBen+/ye2lzv62BuQDfrA+rVXp9KHk4M8ksMzd+BgkZQJNCljQ+Fs266vaHfF5WcuD1/5OvO3xwmRGTuX3Wt25RqIAeKJ5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096103; c=relaxed/simple;
	bh=kTmOATOV55R7UB8r+X9m41LCk5WorwU3DuCsWjK2hlo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhmRJ4KVYkwvX/wY0LsC0Ve29d/+ufkz2tesG/Bk/aXauHUOrAWzFGvkAsKeIi2E+u9Llj6pwfGKBcLdCKJe0LeiTBaVO98jaQkndHaHHfCMxDj6FOkrHV0T6KpPNHb4LYoKL1r48gHA44JVXFs6tQ5ZBHZA8i9HxCTB9bbEQ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xxovmVVK; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xxovmVVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td2KPTeevGQb2RpiDdzuBKinjAA+rdjyG3gp2DCYeN+ML7WWMAiFtnoDBNvw+JcLLS2GlOO9gUa94fn4CCQrpwmMnWr62PZa0vve7wWEt29XJq/QNnM5Ln85G6bK/xchE60XYCYziPSFzeKts0caBjrk5V9rhU5PGPgc3z6EwMkdMtD8opLn7FSAbR/QJKq5xpIkG/1wjCjVHbyRvOKFp6z/PZ8LMn2XTFRZce+oUoFzWhOTgBC9E7i51mBZKI0nsqtmJ8CrTRwFiBx1tzdy48jZtgOoWOTXGfXjxEq0pDOA7QYtjdzQC2wcRK/joE40AfxH1GWF/mTuDg8GK90Lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tpVEwI4FR5SRbQoKK/WuCf1gfO/L1rYqFh3SP2dU4g=;
 b=r9Wb7WbNS4KV+vdWplJAkGs80EabYCoQa2WVbNl9WG2/IMM5Tfu/Pwl6LBwfUXA5Bex6hbx+R8Jh7l1XYQdziPSA6D+/TBxORHEf9DDuTRr9fhPpAW6jVEnpVcfXJPp6lfOmyyDrzzYdiAO2E6TMJX4XHv5PK+Thgd4/M20q2uRl5UO2Noo0iS7YyS6xoww7dmMCpelgnqTtYoTa8vJRrcyq0BTLjHmXMAfSurQndU+IASCmEUsp10x/lFqe9wbTJofsoZ9zA2a4oPISaVacur0mBBycGaBK1W6vVMyM6fWF8L2o73blvmYkYoSGtGFtsun0i8Hi5/qRyRYs/Qo/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tpVEwI4FR5SRbQoKK/WuCf1gfO/L1rYqFh3SP2dU4g=;
 b=xxovmVVKWeA3HIga/Mu/cojVVUjRFdtT+BZfQkaw3s2clEOnyXt5sKbyjif7u2u0+rheKgd9kfjE0Q1TIsS1GCN9N9DZv/n5SX79dQT5fNnKLXBdSjuzj4ByrAebwd+1zWgT1qLa5g38GEIND/nU+6YDK/Tkv+qCLMScukWeVF4tBrZROxu3RepBDIoTLK3x5vBE/ZQq7H832mDC0OzGpRd41OiQHo1u5mshIErOh2256toC/gRSyhGAijeuat5rii1Doc6U4qSc+O56Lg7bkGr+Gg32qeC5q+vH0xg0I1TNaAFcFGbstzOVv7R/9iP912/GpoMR3O2l1xU6OD5k/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:173::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 09:21:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 09:21:37 +0000
Message-ID: <b84b91e1-4316-4b5c-8190-73bd46742c1a@siemens.com>
Date: Mon, 18 May 2026 11:21:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] testsuite/smokey/psostests: Fix compile error seen
 with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
 <20260518-wip-flo-gcc-16-v2-4-f93562624fb4@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260518-wip-flo-gcc-16-v2-4-f93562624fb4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3748:EE_
X-MS-Office365-Filtering-Correlation-Id: 055cf175-cdaf-4870-1b48-08deb4bedcd7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799003|22082099003|56012099003|18002099003|55112099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Nw+IgTC/4lC9rm2CYXyG6CRWa29/4SusIMzGH/cxIyt6QnBrNYj+k6KaGRzTK2xvguNl6OXkA3bY8TyS9SjqENjhqRrHh40FSPmbsYfXsJGcDqFg/KpgQjLceu9ovaEzRODUCvc6yPP8DR2F11757zHhXE5+3IeSNrcxQTZfCKgP/mE7IsCuySYtMnonLTYE5BNaEFrUdXFp7EiLejszpSpO4uKTqpOxCUvWo2L7YWdQHcR5SdY8Hx41jny/PECNf04uoc0qaQKj646KteSPEgi69tbXvDxTDTWTVLGcSYT6EVPDHKbYI6JoP1n38RaiARMR2JOPvZ338N/e3uGWadp9TmqaTSPvuOMuekgNVZa8IKCEmDdSrtihvOIG1FiJNUSS6c1eXCn+FHdw2NiMiAcPrccdwz6BRo5TW8NZ7F8q/ULAI/86zpdhHfyJk26/r3X66rQCrvXnFcNFcxfeCCyg8HVqsaCBdSeIufF7BeKYQ89bvK1Xm08yS2Z1kIwa5Ugvkw60tBy419npgrsh2/7F5BwdkXjASepWq1h4EO2hYA2nR1bv/T1BMfwghvTWWEABVymnuoyEdO9/3aRUDXQ8fkID+qdpHvyRkU/KGeBCwrhu8kEfdBahGeRuaWiXYf1oPY7Gsf8Rb0K+TT1NYokfGfQ6nDqfrO62Zw3AfqSDA/XkPAHOL6qZwsWYy7Ka
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(55112099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjFzb2lJOXk5bEpsa3ZpeDNjYmZnY3VYWmdBZ3NkOE1rTWIzL3JuNWFLSTNa?=
 =?utf-8?B?RXo4enFLemF5ZDMvSjZLd2ZXM2o1b0d3K29kNUx0TkJDN2NsVGhlSzYwRFlr?=
 =?utf-8?B?U3VEVzM2aWNnK3o0ZHNKVDFmNklqZlVrRUdjRzhLbXNYU2phOWs5N2ZKaTh4?=
 =?utf-8?B?eXhVbUxJV2xQUVlOL0wvNXR1MSt4TGh0WXAyMmtUV2hvckJqbWhCRXZvaHNJ?=
 =?utf-8?B?MlhEUFBUY1NUUUtKeEZwNFVQQ1R6QVJicjlNeC9xa2N2OGNoM0xYdmx2ZWlC?=
 =?utf-8?B?WmdrY0U0WXArdHVIN1ZiOUlKT3BrZ3d6MDQ1TzlYWGdnek92a2VOQkZEM3Nh?=
 =?utf-8?B?SU43UVBkbW9CS0RTcEJRTGhmakJMdTF4M2FTSXl0Ym9HM3IxOFRIMm9ndDFs?=
 =?utf-8?B?V2NiSHhlQ3NZOGtSTEppZ2cxcnMxOUZXL0Z5RGlCN2FDMERPUmtTTGF3S2Fs?=
 =?utf-8?B?ZytXSE8zYWRJWmN1Nk1seHduZEJPSlFYZWQ0MlRZdXFOQ2c1SWthaXgvUFdy?=
 =?utf-8?B?bkhzNm9ySmt1YnJGYnFDTHFHRy9SS1NMc21FdEdGRGl3Wi8zUXAvR3p4R2Ns?=
 =?utf-8?B?Ly9FY0J4b2Q4TjI4VTZ4Nkg1dW5uSjlqTjI5WFhWVTFEQklPYytOcmtybzZQ?=
 =?utf-8?B?M2NSbkRMektQa20vL0ZXVXNWOFJWS3dOSE5TUmNkRitLQSt3ZXRyWGpCRjVB?=
 =?utf-8?B?ZHBoVnhZNUJ4VHpoSEt2bUdLcFRwRmptNkVzallWNkM0ZlpWSW5GWUZ2WXpy?=
 =?utf-8?B?emtwUFJUNERibzBHRHJuaEl1eVdiVEdmMEdndXZ2SFFpZlI3SndTYVZrdTA5?=
 =?utf-8?B?OW1zbGRHZUsrZjd5Z1ZNZStpb0g4d1NBYVZsMXBzcVN2amRRQjhCWHd1aFlz?=
 =?utf-8?B?eXZWTkoyMGxjVkNaSVhnRm5jejdmWWFGSGEwV2kra3lwUU5KTlVtSldGa3Qr?=
 =?utf-8?B?aDEvalltNm80MVhFSW1tWmlYbmFlWSs5enBRVXRtOW1SeTBHZi9MZHg0amZm?=
 =?utf-8?B?WUJYYk9zdWV0a0JIZ3B0OVdVSmNsbnI5cGlSUnhQWjlXQ2Y5UXZuZGhUS3B0?=
 =?utf-8?B?ajhXOXZDeFRyYVdKWDBXZWNFRURiYjdXcTZTVkkrT1NTSW9xT2d1eW1FOVBi?=
 =?utf-8?B?WVZRK3V1TnhCZ044dTQ4eFU2OWNhclpsOHdDc1BjQmU2TnFVZ2tKbW5GdG9O?=
 =?utf-8?B?bWdhWUs2b0x1Q2IyMkFLWnVnNmM4T0JkNnovQi8vN29ia08xYmtnYTJTMnE3?=
 =?utf-8?B?MU05VThjbVJ1U295MW9SaCtaSmp6YW1NSEtKTmF2cjdpaFVFK05LTVVpTlMv?=
 =?utf-8?B?OFFFSHp0eERtK1lsdDFGOXJMKzZYQlFXOGVDM0d4V1ZhNEVQajF1NzUyUUdq?=
 =?utf-8?B?U2ZrWFdMdkh1WmZsanc2aGlJRm40cytUMUswOEZJeWduS2crWXBlL2o4dG9X?=
 =?utf-8?B?WWh4MS91cWhveVZCN0RteGtDcWpCSGFuc3ErRGZUQzJZV1ZHa3d6WHF5UnlQ?=
 =?utf-8?B?WHpPSTRmMU1nclY3MmgzcGpxRXBudzJxcDZpdC9sNkc3WHhDK1ZscWkyWG1D?=
 =?utf-8?B?aURMa3V3TkFQYjFZemdXVFNNNHpuSHNucEE4eVFwRWdXTzNvYXA4U3NVd0Rh?=
 =?utf-8?B?UUh0SmFIbndWUXRDRjBHemJQbkluVHJEV2lCQzQrV3VoTWpQYjlHUDFoWVBX?=
 =?utf-8?B?WWVHZ2ZyUnlzWU9MaURYMGJrVG9sVkk5MERDTmlaczF4VjFwS29KMDdEL256?=
 =?utf-8?B?NktJaU1udGc1RUNoWncxMlpOdnhGYUhydnBONmNXREdiVVk5VXFJb1loRFEy?=
 =?utf-8?B?Sm9pQzM5V2o1V2M2YW50QmJnQzd3NjVLamxTZkNtclltVlVyb2NTTGJhS011?=
 =?utf-8?B?S0sxK1UwODhvaHl5Ynp5TEhhWk15VzVWYVNLY0p2YVE3blRJYlNjVVBSRVFZ?=
 =?utf-8?B?aWhUVGJ6cTdqMmNPMjZaTyt6cTRYRU5SZ1dPVU1oZGtxUVRiU1dXdjdid085?=
 =?utf-8?B?U05SUGpwVU0xZkFIS3gxbjlQNXlrNmt0NDBlNW5KRVNvTms2Q3lJNitVN0VW?=
 =?utf-8?B?eFp1c0hnQmlzMWpZb25FNWZ1YzJhelhjY2NPVjhId1FiZzBHU1Rnc0QwQVE5?=
 =?utf-8?B?ZHd2dVl6MjdOanU5a21KVWw4d1ZWNFN1c2xJWHNMeEhUd0pNOTBQOWgreTUz?=
 =?utf-8?B?Ry80Z1RjUzNaQ0VRc05xdk1sNmQ5UTgzL0RFc3A3b3lhZXZuN1lCb2x0a0tR?=
 =?utf-8?B?elVpbm80V3RnYkZtdDBiaW5iQkp0ZkdCQy9NRnlMeFg2ZFJwazB5VDVJczJ0?=
 =?utf-8?B?RXpCU1VDMUE0dzV0a0JnZitBM0Y4dFRzUHQyR1IyRWEvQzJ0eHdRZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055cf175-cdaf-4870-1b48-08deb4bedcd7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:21:37.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9OQDcMUPkXwPhPVtgcsVuN1EhrMZ7cYerLKUuVBOTupgjAjrYn+6gVgaWGOq1CfR0UxUbNgEHYA3h6su0bupA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3748

On 18.05.26 11:02, Florian Bezdeka wrote:
> Fixes the following compile errors:
> 
> rn-1.c: In function ‘alloc_task’:
> rn-1.c:16:18: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
>    16 |         int ret, n;
>       |                  ^
> rn-1.c:15:22: error: variable ‘alloc_size’ set but not used [-Werror=unused-but-set-variable=]
>    15 |         u_long size, alloc_size = 0;
>       |
> 
> task-2.c: In function ‘backgroundTask’:
> task-2.c:19:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>    19 |         unsigned int safety = 100000000, count = 0;
>       |                                          ^~~~~
> cc1: all warnings being treated as errors
> 
> The counting busy loop has been replaced by an interval based busy
> loop.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/psostests/rn-1.c   | 7 +++----
>  testsuite/smokey/psostests/task-2.c | 5 ++---
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psostests/rn-1.c
> index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de3e550a5d10a8be4694de5 100644
> --- a/testsuite/smokey/psostests/rn-1.c
> +++ b/testsuite/smokey/psostests/rn-1.c
> @@ -12,15 +12,15 @@ static u_long tid, rnid;
>  
>  static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>  {
> -	u_long size, alloc_size = 0;
> -	int ret, n;
> +	u_long size;
>  	void *buf;
> +	int ret;
>  
>  	traceobj_enter(&trobj);
>  
>  	srandom(0x11223344);
>  
> -	for (n = 0;; n++) {
> +	for (;;) {
>  		size = (random() % (sizeof(rn_mem) / 8)) + 4;
>  		ret = rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
>  		if (ret) {
> @@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
>  			break;
>  		}
>  		memset(buf, 0xaa, size);
> -		alloc_size += size;
>  	}
>  
>  	traceobj_exit(&trobj);
> diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
> index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..be1b6ca18c5354ba092d55b3655bae9a294f2ce7 100644
> --- a/testsuite/smokey/psostests/task-2.c
> +++ b/testsuite/smokey/psostests/task-2.c
> @@ -2,6 +2,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <copperplate/traceobj.h>
> +#include <copperplate/threadobj.h>
>  #include <psos/psos.h>
>  
>  static struct traceobj trobj;
> @@ -16,7 +17,6 @@ static u_long sem_id;
>  
>  static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>  {
> -	unsigned int safety = 100000000, count = 0;
>  	int ret;
>  
>  	traceobj_enter(&trobj);
> @@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
>  
>  	traceobj_mark(&trobj, 2);
>  
> -	while (--safety > 0)
> -		count++;
> +	threadobj_spin(1000);

That's just 1 µs, isn't it? That sounds rather short, not only for VM
setups.

Jan

>  
>  	traceobj_mark(&trobj, 3);
>  
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
