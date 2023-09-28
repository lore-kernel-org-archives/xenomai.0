Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7B13AFB
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 17:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdrAE39gaJRM8Eb5MwbT3jjU2K+YLoit8M+X6Y9GU3SgsA6Ad6ZjHg4lwM/eWNKneszE+uzRY/bYOA+xCCXsa1sNzD9KLeFV5tHq9zYn03Vg030TL55aJzbrNuJ1//vb2XE8CJ2qnNQ5vRN3QvHWzpjQzkbNHUBuClGddRSGGrfLxBLVOQcjd+L6TMkyWCemG1VdYyehgADSHu9atDus1XJI6OloykFb6zRw/mzFvNz9oW5DtVgeW9ak7l8Snl9CpeFhc67b6iq9YKMZbS4WF4DxWSNP9FKHiqS8Afve/I40FSKcq7e8MjmBWplJMVAuulZfSfJN41sOogGnEMpI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb6YQroQiMiIBMtQu0EseHas7LTsiAHinrdgmndfZ9I=;
 b=bLkLCdw10g8wo2SL1UTebVU+SiFbplSHiwL7mpWy6gld8AkWbXt8IAVYwTz7qvp9vs2tnN0S5lawo0VkrdSio/T2ai69Ptw/5G50nMvW4XEWOAeEFZXkbFwHiTcmX1maDtPqjfE86YH0+DURBkWUTTD+4ry18tI1yGaYyIZWppwL+rK0Bg4C0SXnipm8b1Q5dw++TxmLktqZ48o+eSbBHPpQto1SMAuZ7aPcWIavEq5tqQhxMBdWt/GVerzaxPciOoTwxez+mICaCcOpxWr8PxZ5SPu16ZbxtuUIC7rkXKHwAJGGWtDMpQD5Zo57CQtGyPmCx3SG0uhKXAJ4QOQN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb6YQroQiMiIBMtQu0EseHas7LTsiAHinrdgmndfZ9I=;
 b=QA+kzxVPcp+hTwWjiv1/uAfa6kknVc2MmkitBONsw3qEhPvVEZqdbjcht6WmyJ8qZmp2JohMRvh+1ZFEMN6PZtF1PXJOPmp+diqN1P6giukU8TyyoVmaZBGaVC+6kvqFGmSNL6TFBAdKaB+rP63UaqWhqhc2XsgQuG/6FQNQ9pJ8fHG1c3wYmCuRmpLyswzz4lr/l/t8MQGtPzcIs6HbpB+2ZjuPIHO4q4+2Pg2rGjrN6N10Ihif9NiuwgAgGtfmMJFW6yJfny8vcjYH1v1pufqPrYlVOPsrs0F9XJz6vFF9BN9bDyJTO79jQVRlLPywrzxMiyuIEZRhDmR7u27VaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Thu, 28 Sep
 2023 17:04:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 17:04:41 +0000
Message-ID: <5529de6c-16ef-4ef1-b6b9-ceeb1edbe090@siemens.com>
Date: Thu, 28 Sep 2023 19:04:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lib: Drop cpu-affinity=0 from skin-tests helper
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <20230925130311.17757-1-aaron@sigma-star.at>
 <20230925151256.22161-1-aaron@sigma-star.at>
 <20230925151256.22161-2-aaron@sigma-star.at>
 <fb162398-31b5-4b67-9d2c-69955e76b689@siemens.com>
In-Reply-To: <fb162398-31b5-4b67-9d2c-69955e76b689@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 10258252-53d7-4f06-e3e3-08dbc045015a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TeJjFCvcvYzcMcpGu//SnarqqcifkkyofaXWbnLfmuGQeacRv887x5b6geMLH4jKwlqrGgfQOfT3dk5uoSrUoOfGiCvqRFp9En/cSJ/OE8JyxipJxhlV7gUIrsVa46oXEnpF81Mz5CFJL2F18k03eBNeqNrQI3H/i2QWtAOXzvPmL+cbk/zUwA/O6j34xp3hlmpGPORs24p2xk0Z5b+kdJVFbH2P4FktO+t3hXcogwQaPKBjXLyPnjxwcOpK88lacOmGKkHKhV+3yEromeQxLcmKH2xl8zgfcdVRSY6gCKjIMTqqCfIQ4NR1ithgA+O1j5y1L/oWfBWLq4tXPJhUwwYQ7iIMK2ll7v3xNYSmm8RyW8XzTPYABs5mU6tF0JkLywVI96VYLS20qVS+zGl1ySsEIz5VjOG5Y9ITa786eDvsjC37SS3m6POOUgUTJtsOBYaRJJ409bQ0PoPL9v8pGqY3otSd/uEAky519lrmlc2oaZQXjhFWQuOprrNH1frV51UEVgc6OLib67N47uMrQQ9kRm0zolp3oANAMD4EGf750AJsDnR8dFsUP+1QaNFsGFE2dOPHhUHxC8D/5WDTIhNDSaaSo1IsvXGt4y0ASfFxvO19UAV2uouSMHtUmW9RTiOXIYbWAT1IXxZJ2lmdaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82960400001)(38100700002)(31696002)(86362001)(36756003)(478600001)(6506007)(6486002)(8676002)(53546011)(44832011)(31686004)(6512007)(41300700001)(2906002)(66476007)(316002)(2616005)(66556008)(66946007)(4326008)(8936002)(5660300002)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akNWME9rUm16Q3pKcmRBTTB4cCtsOU5iU2QzNENETXI0V3M2ejF1NDhZYlR5?=
 =?utf-8?B?ZnB3UkgrYUdkYVcvRXBQMjR2REhhcFVnRC91ajQxR0t1R1lzaEEwNXJ3RnBa?=
 =?utf-8?B?S29uOENKNEZINFdJUm1Va2VGNVkrTUdjYWJKblEvc3J0UGRqSGdZL2tNZ1J6?=
 =?utf-8?B?L2krZGFySW5qUjVLSVJTZ1VsR2dpMWFYR1lVaXVVZS9KYjUzZ1NnRGxIWU1k?=
 =?utf-8?B?cjVwLzl6OTNWVFlXRFY4azJNeG9jb0FkTjNQbXRvVVFMYlp0UlR0UXlkVVdm?=
 =?utf-8?B?enNrZHdJbDlvd3l5WFV4OVNZNDVubW0ybGl6RXRibHUrZzFIckUxVnMwV3JV?=
 =?utf-8?B?RFVYblB2MmVLdWN5b2pHVG1YL2xBZm9DTnk4SUZuSHFSWllzZkFhNmNwMExY?=
 =?utf-8?B?dTM3VEVPSURBd2FjV1ZDRElrNHd4ZFNkanU5c0JhQ2g4VmRNemRvZ3F1MkZ1?=
 =?utf-8?B?dVJkSnZMUlh2WmQ2cWlCSHh3UXFjNXVtdjQ5a2FKdnY0ZUJhZFhhbFoxUDV1?=
 =?utf-8?B?Tmo4T1JLVnk2MGF4OThsR1BucFNZUU0xQmpIU21pczFoblYxL0dxT1pJN2ht?=
 =?utf-8?B?SjY2SlNVZzNCSTBUSlhjQ1ZNOTk1SnNnUkdrdmRyeUg1SnZXWGZhdkRCVjVX?=
 =?utf-8?B?NFRMeVpJQ1NNWU4rYXRvRkw0U1c5VkhQZmZ0N1lkc3d5cnI5RFZlclhXZEdE?=
 =?utf-8?B?UzU0SCs4cHJpSk1CeXlrQ21tNTkyTFlCRGFwQzdUZG9IaWljSE14em9iNTYz?=
 =?utf-8?B?d3JBVC9JSkREL0VpN1FqUVE3aStiOVVxNHQzalF2VkhwcTAxa3ZVOTFTbllG?=
 =?utf-8?B?NkVFSmJjNHJNVzgweS83WHV0RDhWVlZnbGF2eVVnQXZnTXlyK09jeG42QVlE?=
 =?utf-8?B?cWFWY0lKYjlDcGs4K0o2YnFHcXFVQTNSZkVYU1pYTVJEMi9iM09Fc0ZJeHIy?=
 =?utf-8?B?em1BSm51N2tDN3FhMTZmNXFyOWFzc0lucEpkU0dlckI0UXI3eFNycTRWc2Uy?=
 =?utf-8?B?ajlvNGxLSkNuNDh3UjhqZkVOc3VhMHoxN0NZTWoxT2ZGTWtwKzhrM1RldGYw?=
 =?utf-8?B?WUxDb1RUMzNJc01tVmVERUNqSnBLRS9FWjhDcURUN01zMmtGeXVDdm5PaFpI?=
 =?utf-8?B?TkhwWUx4eVY3dURaaXVabW5nSzlBU1hKckJNQVdzK3ZiVksySjZZaGhSaUdP?=
 =?utf-8?B?dUJKOUY5YStJeWhVNUJSeGJOdVdXNlZvT2tjUTFoOHVUazJNV3Uvek5xR1VE?=
 =?utf-8?B?cEt0RVMrQVlVc0VBMDVaZlNrOTdZcGNPd0M3L1hpVFhrRFNNSmhscjhzanJa?=
 =?utf-8?B?dWJBV3VZdVlEai9ibWpJcmFTQ3krcWJRU3R2dlplRklkaHRZaHFtQUp1VHhH?=
 =?utf-8?B?VEFzZmhZSjJNMHplbzdjanJXR3pPRklvWmJXRTZlR01QK01aa1JrdU9LbG8v?=
 =?utf-8?B?SnFhdU03d240S3RVK1Q1SktacnJHdEhWOTJyaVBXbWVFc2h1ZkE4K0sxb05R?=
 =?utf-8?B?ajJvcy9mU2I2UVJ4eU5KMi9tUTNINmFvYzk1U3dWTWlFaWs2TmU3T2N2S0to?=
 =?utf-8?B?NXhscnRlWnhKMC9UbGtKaXVYT0pQZGE0SnozV21qOUlPSDZvb1A4OHM5YkhS?=
 =?utf-8?B?QjFWbFQ1Znc3elpVVEZibit6Q2JCTEljdGo2cTFpL0lXRG1TeUJzYW1WVnR4?=
 =?utf-8?B?R0hCQi90SDlycjZUYmRzMEo4ekJFOFpuWUg3dE9INDJNck9NZFljWEJub0U3?=
 =?utf-8?B?RjcvZXFXV0g2N0JVSGNvQ1dDOVNGL3UxSDJMSllYYnR6Z3hEY1YydUJmNXEw?=
 =?utf-8?B?WlJaRWF1aHR6VHdLVlBZd3dHdTJQMzVWSE1oaFhveXJOL1IwTktYaStld0p3?=
 =?utf-8?B?SVZWT3Y3Mm80UWFWbjExbW5aUm1nQ0txODFra2wrbXVaL0lFL0xTM1dPSUdM?=
 =?utf-8?B?Zk83aEtObUdURi9WanFwSEpZVzJLR21WMWk0L0UwWmlRVUxEWWFDd1BXNWVo?=
 =?utf-8?B?MXE0Y2xXbTh5cHZqclZ4SUo0OWhOVnhqYXp3cVRBMy9rQ21FQ2g3THpNZkVk?=
 =?utf-8?B?SnhFT3k3M3prUFpXR2pVekhPd0F5SS9tV0VIV1YxVmE5aHQ2UHV5aVVoclFO?=
 =?utf-8?B?ZE56VmhUVFRjUTgvbXhXRmFKZjlRM1hBM3ZsVFRhZGg3MHRJQUY1aVpvUzAw?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10258252-53d7-4f06-e3e3-08dbc045015a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:04:41.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33qdaynY7Xb/k77yteBODg0UEw+ZUJJ6TUxkEEsP0WkGUunsRTM6eXlbfCOyqS1FKKAKV6PB2vJdrgsozNKS3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7696

On 25.09.23 17:42, Jan Kiszka wrote:
> On 25.09.23 17:12, Aaron Marcher wrote:
>> Alchemy, pSos and VxWorks tests assume zero CPU affinity, but we cannot
>> enforce that in general.
>>
>> Introduces a parameter to control the arguments.
>>
>> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
>> ---
>>  include/smokey/smokey.h                      | 2 +-
>>  lib/smokey/helpers.c                         | 8 ++++++--
>>  testsuite/smokey/alchemytests/alchemytests.c | 3 ++-
>>  testsuite/smokey/psostests/psostests.c       | 3 ++-
>>  testsuite/smokey/vxworkstests/vxworkstests.c | 3 ++-
>>  5 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
>> index 4d0fe011f..3623ba18c 100644
>> --- a/include/smokey/smokey.h
>> +++ b/include/smokey/smokey.h
>> @@ -259,7 +259,7 @@ int smokey_modprobe(const char *name, bool silent);
>>  
>>  int smokey_rmmod(const char *name);
>>  
>> -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
>> +int smokey_run_extprog(const char *dir, const char *name, const char *args);
>>  
>>  #ifdef __cplusplus
>>  }
>> diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
>> index dfd63b409..99cd019aa 100644
>> --- a/lib/smokey/helpers.c
>> +++ b/lib/smokey/helpers.c
>> @@ -411,12 +411,16 @@ int smokey_rmmod(const char *name)
>>  	return err;
>>  }
>>  
>> -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
>> +int smokey_run_extprog(const char *dir, const char *name, const char *args)
> 
> Actually, argc/argv were dead vars before...
> 
>>  {
>>  	int ret;
>>  	char *tst_path;
>>  
>> -	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
>> +	if (args == NULL)
>> +		ret = asprintf(&tst_path, "%s/%s", dir, name);
>> +	else
>> +		ret = asprintf(&tst_path, "%s/%s %s", dir, name, args);
>> +
>>  	if (ret == -1)
>>  		return -ENOMEM;
>>  
>> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
>> index 5753af423..04f631bac 100644
>> --- a/testsuite/smokey/alchemytests/alchemytests.c
>> +++ b/testsuite/smokey/alchemytests/alchemytests.c
>> @@ -33,12 +33,13 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
>>  		"alchemytests_task9",
>>  		"alchemytests_task10"
>>  	};
>> +	char *args = "--cpu-affinity=0";
> 
> const? Maybe even inline into the call?
> 
>>  
>>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>>  	{
>>  		int fails = 0;
>>  
>> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
>> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>>  		if (ret) {
>>  			fails++;
>>  			if (smokey_keep_going)
>> diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
>> index a54e6ea31..f2a75c841 100644
>> --- a/testsuite/smokey/psostests/psostests.c
>> +++ b/testsuite/smokey/psostests/psostests.c
>> @@ -46,12 +46,13 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
>>  		"psostests_tm6",
>>  		"psostests_tm7"
>>  	};
>> +	char *args = "--cpu-affinity=0";
>>  
>>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>>  	{
>>  		int fails = 0;
>>  
>> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
>> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>>  		if (ret) {
>>  			fails++;
>>  			if (smokey_keep_going)
>> diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
>> index d3ac891ae..24ea8f0a1 100644
>> --- a/testsuite/smokey/vxworkstests/vxworkstests.c
>> +++ b/testsuite/smokey/vxworkstests/vxworkstests.c
>> @@ -24,12 +24,13 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
>>  		"vxworkstests_task1",
>>  		"vxworkstests_task2"
>>  	};
>> +	char *args = "--cpu-affinity=0";
>>  
>>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>>  	{
>>  		int fails = 0;
>>  
>> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
>> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>>  		if (ret) {
>>  			fails++;
>>  			if (smokey_keep_going)
> 
> I'm inclined to ask for v2 of the original series. 'next' is not
> 'master', we can still update it.
> 

Any chance to get a v2 soon?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

