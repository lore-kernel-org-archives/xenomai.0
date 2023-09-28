Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A415BF
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 17:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkMk9Td0djO2YSbxebFJ9sU4Kg6MyIgdWMAoLxsQTkij9OIOQ6aHiZEXoO0d47bNeIvvidwWW91vED0yiT/SOB6KZpxmiK9HpmhSYDpMspBOir4X+n7Z2Bgxp27PR1+w0VPzPD52xfvXu5Qc1Z6gmkNykPjnOdPfld6Yoyy6L3XFBlwp42VB6Ra5+W3YkP3StJF2dITpSH8qCeJBzPdrlV/1WQ9dj5oYOR5QGxWxj9DaWZdz0chLCoyBYPbzzixih3O+GUJTDidRPShv+cjvZ4UdByHPUqabUa4fdbPPLmr9LEFm8Y1jXqA7B4q2oUbjdbTKcs29F8tT6plUoT+roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbBl8XRHIukV3qtyuhjOmo0SQJJuzi2txMtE1YUJ8jU=;
 b=OrQD+msZL8F2UzLWgixsm9n/zhRRtG5LgO34pDUGSpwCSfs2lAeY2++RdtRg2j0tH4rW9M2TuEGYaAofzcD47E0Mjx0N2FuC52TW6hw02dcarBHTubU8LlN4SDT8hvUq5Mp3E2+WS4uuLrm/0lTIKDHsmXG9moJrC13sfHYWeqoZCvdaRQ7NmbsG5cCBEg4/dIS5NHUty2TX6BOIq3vW6MUjUktYeEN6XNk53fpk6OFigbSRTlAtoajC5JTQtbToFD4TgxTG3YTaello8+ng/cf9EFkmy4xJgPBQE2rFqwTwIVEtUmP2kRw6aY5QzaIrhyuQk8NAmKUP+PoCwNVb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbBl8XRHIukV3qtyuhjOmo0SQJJuzi2txMtE1YUJ8jU=;
 b=NDUDSiG9D2Ew31BCEcDYepF8r7eOowClgsoHM56skySNGBVIci/4zREB4i5B+0fWnj5ywXqlXcN+AO6QFHUfbDtkM1zm5+HFhjypnS8cxKZAW12ATzu4sG3CU7MLpPL3KHWdxib8qocro2t5pgF7K7E5kN9nDhWI6lFsuLo+2OsOmoB+wfWFhqv8S7DrdSuXkBKQFmbgDvPfJX3kOytiKhd7jxVjk7MaG76Sd42rdLysyhvDlNYOwJTI3rCF6AhdDdMZKefDVbjF2ooh1jLlWP6f8SsUIzrkZzXjPJwRqzgcs4+/U3NMFlqA5TTAZMZyeZBjJ1XSyNePhO0PLklwFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:30:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 17:30:17 +0000
Message-ID: <14e7e3ef-7f7b-423d-b969-43c5e996bf67@siemens.com>
Date: Thu, 28 Sep 2023 19:30:14 +0200
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
 <5529de6c-16ef-4ef1-b6b9-ceeb1edbe090@siemens.com>
In-Reply-To: <5529de6c-16ef-4ef1-b6b9-ceeb1edbe090@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: f056b532-f81e-4d93-3eb6-08dbc04894c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TNm6GaGyz1DOpAK0T8TA1HCqpKeB2R7FUXqri4pECXOC9erzOTTFgxtFvre2liVnZILn5vBgOF/drOBfVaLoH9ErmVbbwvtA8N7T4BI2PKjobtLzCK39LnBr7nnD2l0BZL9M9I9PvDqSF/Ptp3C4LlAeb1FWzSvKb3tjpzV7LfLr5Si/+cuI9k/A6f3xZh0b2mjJF0S5AARcZVjhRNxOElf6S8WJTXldATKGjH22iYof7KVc1iKU03VyAmCUQaTXaGGLFAVFqlgGNNC9m8OrOB9APdH9S5eYIFnqhYczQHSffuVQi1OplzfYjUBnDKQi6bI1mR74Fe4MXqxa5QcNrQ33BbVWhUfe5MTj35vspyvI9GJB2VztZwUUCJE/HjJF6nTEYiOfpCk0x+3hcSdA67KFoGDAUpUflVsgBcwsW2gbr6p0ZHvsJk87Tm59Tzmyzc47AJq+2fEOjx/usGrAErhCuvdNC2PeaaC+oAlhGLznLOe0RBgrUyqVM9d8lvqBFyBI2ukgzp07MdkCD/V76TSI+JaAQ4XmCbdzJtZ+3iTYrsFWTmrXbdYwjh9zJLQGWhprZ5ko3N9oJCCWmYfDgiAog0xmh+0xVswhcYLapS1N0sBJVgFjr6BwjagojZidlMTTgxVvGzunOF1ULoGL8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6666004)(2616005)(82960400001)(2906002)(83380400001)(38100700002)(6512007)(66476007)(53546011)(66946007)(6486002)(5660300002)(66556008)(41300700001)(6506007)(478600001)(8936002)(4326008)(26005)(316002)(8676002)(44832011)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajFQaHNjVkJVWDBXZUVtbWNqd1p3dmxtb3F2L0haU0tZbFhYWmt4Tlc1UFJm?=
 =?utf-8?B?VFRkdExHRVowTWFQb1IxOWZ6b0IyMFFydFp5ODVqZncrVis1ckpLZ1p6L29X?=
 =?utf-8?B?ZnlTT3NlaTJUQlFSUFVHZFNTWnZwTXlYUXEwbUtBNGdtNk1MUmpUVU9EeFk2?=
 =?utf-8?B?bkxFZ1VOaDlqTWRzUTl5akRmaXJzRmNzRVBDeTJnN3pXaitQemoxQkM5MlJM?=
 =?utf-8?B?L1Q3ck4xcXg5YWoxVEo3Z0ZPcDF2K3FYaXIxd3V1eWxwc0pZOHFqVW9wSzlC?=
 =?utf-8?B?UjRyd1duejFwdmpoaW9VWTZVWldOLzZ5enlCV3pwZXBUN0VOeHVhQ0pHVXhs?=
 =?utf-8?B?ZEI2N0VKWkp3UDZVY00zOW4rYlJ6d3MyeEdiM0p0WHcwTVJtT2t2ZkR4cVVv?=
 =?utf-8?B?dC9yVVk4U1ZRU2tqZ1JJWU8rUE1yMDBPczExclAxREVrRVdBVzZBZUZSTnlX?=
 =?utf-8?B?azlCdGhGVFhTREZmQzl1M21SclpEM3JhYnhwcTBhSlFuOGxOSEhZOHVYKzJ6?=
 =?utf-8?B?Ny9nUzc4U1dzcWxROGNUNmFLWGkyb3YrNTZKQkFaNGVlMEQ1bUIrdHBSbVpI?=
 =?utf-8?B?QkJPZDdlanRDclhLZElTNlFYalBIUHB6dWx6R0t6cVQ0ZDZQU2cxWklvRXBj?=
 =?utf-8?B?a0VJV0NVdXdFUVlHdWRTY1RoalcvTmlIamh5VkxNempKczgycHhqdTFiTWFj?=
 =?utf-8?B?bHRvUlRjbWtRQzBTc2RVbkx1M096c0EyMHMzbXJldTBvaStXRTBvM2pqWGI1?=
 =?utf-8?B?bU03Q0tBa2FIaE5mbjB2b21oaWNEbzZ1cFhIUnA5eTJ0RldsV2xaTFZUNjAz?=
 =?utf-8?B?SlRYWXI1WC9UNjFFQytCR04vdzZBeFRSU0NvSXRPWE84WW02UnhZNTcrR3M2?=
 =?utf-8?B?OFhqTFFiOCtsMjRndE44RWYxWEdFTVdvZ3JvYllWZEZBeTNmOEFIblNTZ0Vs?=
 =?utf-8?B?M29ra0VEZ3pNczlRMjZITk1BSkxmRFh1ZE5XS0Z6L2FhODl3VEVGUUNnRE5q?=
 =?utf-8?B?a0lMUFpBdEJ4T1FKUHgrQ3JLenpNK1g0YU9RWGpyL0Z1UDJzeU01WkNRWDB0?=
 =?utf-8?B?ZEJ6WlVwWk1GMTBvRk42dzh5Q09veWpvdURLV09qd2NIVitmQ0xHdE53K1hx?=
 =?utf-8?B?L3R5RUN5S0xsY1J1VjAremZMeWxnSXZEdGMxQXoyUE92V0cybVZyc3hObXI3?=
 =?utf-8?B?OHc1ekRwcy9rNWY5S0hiQitVdkhmaHcwYmZlZG9lOGkyWmdScXVUa2FBaTJp?=
 =?utf-8?B?eUhXL3YzZWVMZmtVa3g5Wm40YmgxbXRmTjIwczJReWVJVHJROTQ1bkFpYWMz?=
 =?utf-8?B?Mk5wckI2SXRmNjJ6RlM2YUpYZEx6T0pSN1o2ZUxxYTR6LzU3L2RUeW9odlcx?=
 =?utf-8?B?THl6R0NNMGgvRTQ3eU96ZFMzQWU4ZTRiYi8zL0w5bWFZbU9rYkl4ZXllVlZF?=
 =?utf-8?B?VHZyOHJ3TDljV3Q1a3d6aXhEYkVJeHNGUWh0bWxNaGNpcnZ3a2VIZ0svVzlM?=
 =?utf-8?B?RnQrbTE1US9QNzcxOXRCUUNvMzllL01xYklLdVJmRk5ZV1BXNUNOaVZRVEtn?=
 =?utf-8?B?cFJtMG1JcVMyRDV3MUJHdHpiTzVmTWQzeWxOS2NBQ05rMFZDdC9ua0NWYmUy?=
 =?utf-8?B?ejJyQ1pxM3lqQVRXbUxxR1FwUHhpL1dXVEcwMkJtWXptaUN2ZXl1cXFHTzU1?=
 =?utf-8?B?ZEFEWUNNV3FtOXkvd1lZN29UUzR0YW9xYmVRYXNPeWh5aFBjd3d3MkJEVUNJ?=
 =?utf-8?B?MUFoVUpHYVhRZy9RNWwwQmNwSFltN292MDNVSWhpUDZzMldGamlNTHFVSVFW?=
 =?utf-8?B?RkJPSXVwM0VOZVhSOEtwSjFJQjk2RlY3RldOTWlTTXQxQXhnZTdoc040bHJC?=
 =?utf-8?B?ZjlVYW0wb0pJNTJ0MG9LWVZlTGI2NUcxMTQ0aUhwYi9YY0MzdWlDNFNCZFRh?=
 =?utf-8?B?Yk93N0VWa2wvV0V4R0ZHaUpLZG0vZzZPR1dacEJjMUZBRHg1ZEpSUzlTYW5l?=
 =?utf-8?B?akhxbkg2YSs1bmhhbFR4NFFtVGxUU1A0ZERid2VNR0k5emRFU2w4RFQ5RUlK?=
 =?utf-8?B?TnJMT01NaDVpd2dHNmgrRzd2WFhJU3Y2cHM0d0YvbllyQXdtTUxnNTFsY0F2?=
 =?utf-8?B?L3RVYW1IQWpsZkpMdEFoM3gxU0piV3VXVWZzTWhWMGEyRHJ3Rm1KU213aDRa?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f056b532-f81e-4d93-3eb6-08dbc04894c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:30:17.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlemhxfBoR6hDqdd3MD1lHsHlC1CorvWypGlI9NeHQMNc5BZLFeTs3qnPvd9Y0jAdRAJVaz1kEL/Ihrr8cyxpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7990

On 28.09.23 19:04, Jan Kiszka wrote:
> On 25.09.23 17:42, Jan Kiszka wrote:
>> On 25.09.23 17:12, Aaron Marcher wrote:
>>> Alchemy, pSos and VxWorks tests assume zero CPU affinity, but we cannot
>>> enforce that in general.
>>>
>>> Introduces a parameter to control the arguments.
>>>
>>> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
>>> ---
>>>  include/smokey/smokey.h                      | 2 +-
>>>  lib/smokey/helpers.c                         | 8 ++++++--
>>>  testsuite/smokey/alchemytests/alchemytests.c | 3 ++-
>>>  testsuite/smokey/psostests/psostests.c       | 3 ++-
>>>  testsuite/smokey/vxworkstests/vxworkstests.c | 3 ++-
>>>  5 files changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
>>> index 4d0fe011f..3623ba18c 100644
>>> --- a/include/smokey/smokey.h
>>> +++ b/include/smokey/smokey.h
>>> @@ -259,7 +259,7 @@ int smokey_modprobe(const char *name, bool silent);
>>>  
>>>  int smokey_rmmod(const char *name);
>>>  
>>> -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
>>> +int smokey_run_extprog(const char *dir, const char *name, const char *args);
>>>  
>>>  #ifdef __cplusplus
>>>  }
>>> diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
>>> index dfd63b409..99cd019aa 100644
>>> --- a/lib/smokey/helpers.c
>>> +++ b/lib/smokey/helpers.c
>>> @@ -411,12 +411,16 @@ int smokey_rmmod(const char *name)
>>>  	return err;
>>>  }
>>>  
>>> -int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
>>> +int smokey_run_extprog(const char *dir, const char *name, const char *args)
>>
>> Actually, argc/argv were dead vars before...
>>
>>>  {
>>>  	int ret;
>>>  	char *tst_path;
>>>  
>>> -	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
>>> +	if (args == NULL)
>>> +		ret = asprintf(&tst_path, "%s/%s", dir, name);
>>> +	else
>>> +		ret = asprintf(&tst_path, "%s/%s %s", dir, name, args);
>>> +
>>>  	if (ret == -1)
>>>  		return -ENOMEM;
>>>  
>>> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
>>> index 5753af423..04f631bac 100644
>>> --- a/testsuite/smokey/alchemytests/alchemytests.c
>>> +++ b/testsuite/smokey/alchemytests/alchemytests.c
>>> @@ -33,12 +33,13 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
>>>  		"alchemytests_task9",
>>>  		"alchemytests_task10"
>>>  	};
>>> +	char *args = "--cpu-affinity=0";
>>
>> const? Maybe even inline into the call?
>>
>>>  
>>>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>>>  	{
>>>  		int fails = 0;
>>>  
>>> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
>>> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>>>  		if (ret) {
>>>  			fails++;
>>>  			if (smokey_keep_going)
>>> diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
>>> index a54e6ea31..f2a75c841 100644
>>> --- a/testsuite/smokey/psostests/psostests.c
>>> +++ b/testsuite/smokey/psostests/psostests.c
>>> @@ -46,12 +46,13 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
>>>  		"psostests_tm6",
>>>  		"psostests_tm7"
>>>  	};
>>> +	char *args = "--cpu-affinity=0";
>>>  
>>>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>>>  	{
>>>  		int fails = 0;
>>>  
>>> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
>>> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>>>  		if (ret) {
>>>  			fails++;
>>>  			if (smokey_keep_going)
>>> diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
>>> index d3ac891ae..24ea8f0a1 100644
>>> --- a/testsuite/smokey/vxworkstests/vxworkstests.c
>>> +++ b/testsuite/smokey/vxworkstests/vxworkstests.c
>>> @@ -24,12 +24,13 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
>>>  		"vxworkstests_task1",
>>>  		"vxworkstests_task2"
>>>  	};
>>> +	char *args = "--cpu-affinity=0";
>>>  
>>>  	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
>>>  	{
>>>  		int fails = 0;
>>>  
>>> -		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
>>> +		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], args);
>>>  		if (ret) {
>>>  			fails++;
>>>  			if (smokey_keep_going)
>>
>> I'm inclined to ask for v2 of the original series. 'next' is not
>> 'master', we can still update it.
>>
> 
> Any chance to get a v2 soon?
> 

Just looked into this again and decided to update in-place:

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 4d0fe011fa..3623ba18c2 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -259,7 +259,7 @@ int smokey_modprobe(const char *name, bool silent);
 
 int smokey_rmmod(const char *name);
 
-int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
+int smokey_run_extprog(const char *dir, const char *name, const char *args);
 
 #ifdef __cplusplus
 }
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index dfd63b4092..4c90a513d4 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -411,12 +411,12 @@ int smokey_rmmod(const char *name)
 	return err;
 }
 
-int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
+int smokey_run_extprog(const char *dir, const char *name, const char *args)
 {
 	int ret;
 	char *tst_path;
 
-	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);
+	ret = asprintf(&tst_path, "%s/%s %s", dir, name, args ? : "");
 	if (ret == -1)
 		return -ENOMEM;
 
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 5753af4233..b9e84ac1e4 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -38,7 +38,8 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 	{
 		int fails = 0;
 
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
+		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
+					 "--cpu-affinity=0");
 		if (ret) {
 			fails++;
 			if (smokey_keep_going)
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index a54e6ea316..e35dd82c59 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -51,7 +51,8 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 	{
 		int fails = 0;
 
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
+		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
+					 "--cpu-affinity=0");
 		if (ret) {
 			fails++;
 			if (smokey_keep_going)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index d3ac891ae3..4b694b30bb 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -29,7 +29,8 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 	{
 		int fails = 0;
 
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
+		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
+					 "--cpu-affinity=0");
 		if (ret) {
 			fails++;
 			if (smokey_keep_going)

Jan

-- 
Siemens AG, Technology
Linux Expert Center

