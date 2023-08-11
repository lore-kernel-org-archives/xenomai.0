Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B11172E
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 17:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+mevkItwSZwcExsyJZh54uYjw/7C7FI/KlnWcFbhLsE+ZlDKY21PDqCA6oHzUfFaWBzCotzMz+QRHR/53SNxFV4h/PKELiDA5IXWsHDdxfuK2c5jWlCLz/1a/EMZsXEAnuGMxD76fVdJ2Ug2z+sRFWSFpWL2GtV/u1/ZTqKSWupUhY1cwON05dg2Vh72XfICtbvlmWNiOEaeiGy2MbXb/ygBI27k0cbYu/22uYCJxpCr8ZXtVKjJ6E1UD9by3nNYaksgYVx8J6lXggsJ8LT4Ts3pPVmFB6xrTcq3A5v3lPGH/HAA8M6hqbFJJICyKdurucRfBsHswbmXTIXHT05oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPQIB0GxRxCiD82HH3YbcNKpxVAXnScbLWEjC3rvEqs=;
 b=QmEKApHPBM2ANWz/gic7Xf4AThyyVajfi5mV4gwStZXoL+Ddo3BCjqOul+dw5yTbhGBd9KHPSDKRzdEC2fr2VpfF3q/h+tUFfL1xon1l11Iizsarlfyntl7SvAVEi25I1ne7uounOayk/wHkxxfcchqtIslPbOuUg6ltj284kIeP39BuwQ3N7HazmJy2HvrwoXvQMnzyYEqxRql697ooHCZWyQlwa7YO7jcfgQ77pSjZyhmn3VnZh+Mg+8dUAiGFgVsTLFc5iMvLCuV4Kpkokg7uiTrS6dETWXDV/UQ8qEr7uUksJPUX23PWXfoCAKZmgz46TIp+PQa3XRgKtH37cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPQIB0GxRxCiD82HH3YbcNKpxVAXnScbLWEjC3rvEqs=;
 b=CeC68YBid8vjMP0WrrUaffsXsbAwbX7ySdrEyLfzfz0VWcbMLvL94O31A1k2xyRMH3bo8k/JdrrHikQcuAFUqqXuGsognUJ7rSJt4Bezorotx2T632DJGg0R3L8PXmM/uPKWecXe0fEFTssyZlya6+rbfEIcJPTUV3j6SnQV0WvdZwkgpURpLJw3II2OHsEdhDQXAkShpdlrhBzRze0WZ8ltci/Ru1wX9H6YIF03Jsi+f6OJ22T9Sio7ZnG3PbIPjv8rN5SYa04ATEqLATz4dk4CxAFcve+FU7+gkZRn9WtO6PqjG+yeYfvq9q5mHhFHnNEPPZEbAqqtprs4OSwHzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:174::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 17:32:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 17:32:58 +0000
Message-ID: <1befb87a-cc47-460b-9615-10a04f752062@siemens.com>
Date: Fri, 11 Aug 2023 19:32:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
 <20230724135239.10579-2-aaron@sigma-star.at>
 <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3906:EE_
X-MS-Office365-Filtering-Correlation-Id: 242b3399-f698-430a-693d-08db9a910120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LgmjTZBXpIwsP1LJxHaMwTlKI8llj0kzYr5Wf+cSIz2pjjyOi1IpFBb7fG+b+1+IsUN1L7i4jDJVan91LIDbMRGEWxcWW52KjzI9D/ey0DLUf2KfjSTacnlj8rJ3QGp2AhOwHvgS8slGYfUfKbmxOKh4QauA0J25bkLq9ayaIwXeS13cvanuVdT3188NAvx7A6umVqgOiZN0WSMOSrdPgyjsXF50bbC+dtvMMY2zYeQOdoUQTI2EYXaNeDKdrX2tpuyir1lqNKiggODo5bQWTYhkdyCnYSsZcjawPyljn6nIBI2rcLoMATjOCFZlyycgmiziNE9L/NYy6CurVZI0X/cCl+B+M06HHH6UgqjAD7YV2o+2tvsTyPhFX926vEnk0V6v8QKe7G0EHHrYMBCFU6F/Mxe4RSwoi/7JmDbxCbQnCLQudCe3JYAp0e2g3egOGcgzQMpe10TDlCNjgxQKlSeirn6iy/QZWezGq/DpZ/h3CfxrStt5X3xm4Ah1gZW/Yd6rexa218NX8ly1eB4ECd8W0gWjX1bTb6Ar89wW2vwJWRPoCZWDELyvbHk5ibH4TPqmZ3v6bLQzSpX0SJk4jXYHqoAw8jfaYbtFG7LosH/AyefvD35w2fi2O+5ZUSwioQ9m7Xh9B0swLL7KQCV8Og==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(1800799006)(186006)(451199021)(66476007)(66556008)(66946007)(4326008)(41300700001)(316002)(6506007)(53546011)(2616005)(26005)(31696002)(86362001)(38100700002)(82960400001)(6486002)(110136005)(6512007)(36756003)(478600001)(2906002)(31686004)(8676002)(8936002)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVhHWmprclovZkVtSHdwTGxycFdLc3BFNW9GVGgrd0NZWmJrOFBCcFVTVlp3?=
 =?utf-8?B?dHFMazlmSEhaUWdLSm8vT08yWEN6blgvRSt2bGhDTVpReEtPd0xyZ2tLeEFo?=
 =?utf-8?B?alRJeXJRNWNUNVRZd3kwQzBGN0V4ZUY5WGNrTTZLeEovNVV3L2xEOFNwWWti?=
 =?utf-8?B?ekd1UjdhMHg4ZGo2R3BLUFdHSUFKWVJEY1ljOCtUZis2cnFLUlJDYzhWZTJz?=
 =?utf-8?B?bmZ5ZzRVSVlhNDdxNzFjdC9tWG5WZzM5eXc5dDF5OG93Tkpuakx2VHhyVVJF?=
 =?utf-8?B?bjRlck94dk5QMHdzUDZyTTJ0d1NHcG55VlIvcTlNbnB0eWdYa0szemtPU3pr?=
 =?utf-8?B?cWV4RTNySVU2Zk9pMGZuT21vMU0wTGJnKzRqaGdQRUZDNkljRm41Ykc1dkIr?=
 =?utf-8?B?MkhtSElNdjRIV3hKUkxzSHFoK3NhdjdFa2RIODZONG95bXV3c1dIb0VyS0dO?=
 =?utf-8?B?aERjUzNJaHRhczBrNXdVb09BcC9TV3JjcHNSOC9OTFhPWDhLV2JKeERRTWxM?=
 =?utf-8?B?a2haTC96aDl2MmtQS0pHd0lWTXlYUUlvN3dyai85Uk5qNElrOVRuYUJGRTQ1?=
 =?utf-8?B?d2RRUGhRdnpUNkRPaDF1NlNJNE0yeTl6aDZ1R0ZYY1dDcmJpWE5nd1owdWNI?=
 =?utf-8?B?bkE1YUM3LzBJUk5aRnJGU0F1WUFrR0xkcDZPb2sxNHVzR2ZEcnpsSHYxc3gw?=
 =?utf-8?B?a1RjdnA5UXRVd3ArV01xT3locjV6VFBJYXl3MVpKbnpvNEhmMHZhSGFBQldD?=
 =?utf-8?B?TXlValFTM2ZxQjlEWlB2RFJrQjNoMzBBcnVQZG5ieVJTSEJUVjVGY05rRmND?=
 =?utf-8?B?OEl1V0FMS2EvQkNJT0JsY2dtM3JBTTJxNTFWdVIxRXZXTitZbTZmS0xIanND?=
 =?utf-8?B?MVc1cDd1dVQrVDV2OTJabzhuMkkrUWlDZEtqbEw0RWhqb0dEM2lieTE1dkt1?=
 =?utf-8?B?M3NnczhtaHFGcVh4YVU3R2pBYSs1RFNyWEV5QkN3SUkwdzFkYkloOXA3blVL?=
 =?utf-8?B?L2E4a1YwTWsyUkZqUStQQWJScVlrb3p6dW55eG9yUWRZSkZFMExuR09GSWZM?=
 =?utf-8?B?K0huczRJbU81bEFJMHVhNzVKWjV2SzNOU0tDd0hzYjN5ckgxUE1ZMmxHTzZT?=
 =?utf-8?B?UVI3bGdxR084VEpyaGtGR29pYkIvTEFmV0RyNUl2WkE5WmVzM3pLTk41VURO?=
 =?utf-8?B?d3VPQURscGRFVGJicXNuVVFxQnVuMUVhUWVkaFdqa1FlVG01TWkzYkxoKzJK?=
 =?utf-8?B?anhVUXlNRjZCSFFuY2YvVHhsd1d1Zk4zWkRxbkYwKzl5L0N0bzFNUUQ3UlAy?=
 =?utf-8?B?VVdzb1IzcXNWLzZhVmtXMGpzamhRMUJjSzhUNlk2eXU4NlBnblZrV1pVQmls?=
 =?utf-8?B?bTN6Lys2cGhoSHJDYlU3LytwSUhRZGMvUWVnMVRINVlXTHdnU09HeSs4K25w?=
 =?utf-8?B?Q05mWmY5ak84dkY2ckprTzZOMGl5MUFyNTVERHB4QUhqMTRPL3hMUWVGTndw?=
 =?utf-8?B?ZjNhUERKSE9JemROQVhFdFVicWYwaTlPZ2Q3eGZpUnJ5YkFmaXc1dTMwQndw?=
 =?utf-8?B?S0dmR0ZUWEN0TndXUkJtdXlFbitTNTROSkFxNEljUEgyRlBoNGpYNzlNZHhn?=
 =?utf-8?B?UVY1TDNmSFRrTnpaTkQxUTlFSWkrMXZKVTNEaFlnVWNqbnBLVW1JSmsvTjIv?=
 =?utf-8?B?czZLMnVVNktpbUpNSkxuenlKT2cyT05MVkxWamczOTNPbk1DYkE4UWpTYSt4?=
 =?utf-8?B?SVQvdDUxQnFrYkJRYTErTkF4RVkzdWRNSS9YY1FmZnVRZEozeEkrSFlUUW9M?=
 =?utf-8?B?YlRjM0h1MlNUWUl2UDBPVWpqMk9Nc3IzbHNkbEQxWldZQWplNlNqZlpmR0Rv?=
 =?utf-8?B?bEZQL0xKN3RyV1ZIY1VuQU96d01MMzNabXZSb2llWWRTZXNxUURQR2lXcmRK?=
 =?utf-8?B?S2t0Ynh4dkE5ekpzVXZtSVhOWkFVenNHdU9LZTJBZkN3clRkcndOcmxqUmY5?=
 =?utf-8?B?eW5tMEwzVEUvVThsUW9wWThUVFo2aDZtRW9UcDdKWml4YmZGdEJHUzQvdVpa?=
 =?utf-8?B?MFJCWUxUeFFIT2o4SkFVdlppUERXMEkwN1kvRm5qdjJENDRQY09FVjZkRlZa?=
 =?utf-8?B?bnVUckNnSDM3bENFVUJqUDN6Rm5qMTE2bWZQbTZjT0ptUHVialVuSkhKaEx1?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242b3399-f698-430a-693d-08db9a910120
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:32:58.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcUm7c/9zAP5BjKeBzrAHTk1FRWaGPSGJzoVqmkkpOzZqdhExJMaixrjg5EPeeoX1KX0rwnJx2/S5WCx1QhRkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3906

On 10.08.23 09:07, Florian Bezdeka wrote:
> On Mon, 2023-07-24 at 15:52 +0200, Aaron Marcher wrote:
>> This is the very first step to have the alchemy tests embedded
>> into our testsuite.
>>
>> Build them using Xenomai's build system and hook them up using
>> Smokey. Every test binary has it's own respective testcase in the
>> testsuite.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
>> ---
> 
> [snip]
> 
>>
>> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
>> new file mode 100644
>> index 000000000..ee8d1703b
>> --- /dev/null
>> +++ b/testsuite/smokey/alchemytests/alchemytests.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <error.h>
>> +#include <libgen.h>
>> +#include <smokey/smokey.h>
>> +#include <stdbool.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
> 
> IMHO includes can be cleaned up. Can't spot a usage of error.h,
> libgen.h, stdbool.h and unistd.h (at least).
> 
> Applies to more locations within this series.
> 
>> +
>> +#define TEST(name)								   \
>> +	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
>> +	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
>> +	{									   \
>> +		return __run_extprog(t, argc, argv);				   \
>> +	}
>> +
>> +static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
>> +{
>> +	int ret;
>> +	char *tst_path;
>> +
>> +	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
>> +	if (ret == -1)
>> +		return -ENOMEM;
>> +
>> +	ret = system(tst_path);
>> +	free(tst_path);
>> +
>> +	return ret;
>> +}
>> +
>> +TEST(alchemytests)
>> +TEST(alchemytests_alarm1)
>> +TEST(alchemytests_buffer1)
>> +TEST(alchemytests_event1)
>> +TEST(alchemytests_heap1)
>> +TEST(alchemytests_heap2)
>> +TEST(alchemytests_mq1)
>> +TEST(alchemytests_mq2)
>> +TEST(alchemytests_mq3)
>> +TEST(alchemytests_mutex1)
>> +TEST(alchemytests_pipe1)
>> +TEST(alchemytests_sem1)
>> +TEST(alchemytests_sem2)
>> +TEST(alchemytests_task1)
>> +TEST(alchemytests_task2)
>> +TEST(alchemytests_task3)
>> +TEST(alchemytests_task4)
>> +TEST(alchemytests_task5)
>> +TEST(alchemytests_task6)
>> +TEST(alchemytests_task7)
>> +TEST(alchemytests_task8)
>> +TEST(alchemytests_task9)
>> +TEST(alchemytests_task10)
>> +
> 
> The following applies here and on several other places of this series:
> 
> Do we really want to have a test plugin for each sub-test? I would have
> expected one plugin for each "test class", so basically one for each
> sub folder in testsuite/smokey.
> 
> Each module could then call all the sub-tests and report back which one
> actually failed - if any.
> 

Looking at smokey --list, I agree with this: too many test cases to
browse now. Please rework this on top of 'next'.

> Btw: I think Jan already reported that: I have to disable the
> vxworkstests_task2 test as it fails CI runs here.
> 

Fix is in next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

