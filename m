Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31BF2FC5A
	for <xenomai@lists.linux.dev>; Mon,  4 Dec 2023 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v+x2lzX5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQka0qvm/8mNHDHTtlTgxIuYV629ERC+vhoEIW+53OpPQ2zhXXi2lKu4KAG6waYucayUTgIUVidOqFUFVQaZqXnpgLV+JpoLyRMS+W0aBfTMHN1uppeUP4uvist7g4BCTW7nwAzHgoZE+3BDnC4j3bM4e5XZMQCyf47HxpnNgBtAaaOY/kyJscU//hcXmASA3rktW+WE4RPDV9W+qKySp1NmuIP3d0CUKo5Pybh5YOCFTb7zXu1l54ftqfkhdBu+TSZ2gI+Jnx2WOLGzJULHDqy0ePN6u3fi4Ik2qlwd6L/F/TA8GdL8kjUk/XkKN/OszLShtTRlO1nJXoGaz7sfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toqe0bra9uG7Ho4M42Y0WaOPaYA0n9AFOl5tk792Gos=;
 b=JfAihdlWhdyBpLbWCN5T+b9w61a27hYXp5eImOepKLpMkkMwDGgMLT8H+ercvh2HcYjjDgiIyXA0+yrnTPwyOayliBo0vnwiW3UljUk9RL/qJgPJYaxcFNGD6lxBO6V8tPQGopp1hBHpwJ1AuxX54LELyoeuGvV5yxV975+eE76sPohMFI+Rq2bhvjN4gmE/2ZgWQk4HFap/FWROW/hHy6w4k+vY4/VTMLaOqHZcUbj8bivv8zsxtSpOw60NEopqnywZst9JqEQx62N3qQplxr2L5kpGTj9B0iOPFC6fj6FewJD9D1YncteMnZIK3nebwGoSFQjlUS5hTjDryUojfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toqe0bra9uG7Ho4M42Y0WaOPaYA0n9AFOl5tk792Gos=;
 b=v+x2lzX5lbNZR9EVlpphcu+lHVC35EVWZ64+eGYoJW59VCGQUnf0LmKJWkjeqy4mRGm0Fs1HdfPE8X3W1qQgBV2cJ5NhpFceWRVNV/aVTUisotTGV5lTdbZNG9HgPIBSk51AB++zYk2mf7xMYuKmJf1QBmjavlkwVB3+lLZwu82UOg37ZFxBOP93Oq6mCrZhW2HmPNAQLsI5EbQf/XVhVlwBRCCEfE2+pw6cOxU2cIg+OF6+HAGZnNAJvMEHXNJsuNZMJeZhWqhT1NtwzjAi48faSj97DROwlehm+TrlDNSXeck6b2kuyJ20A8z78lYmY9UFNniIaCZ4cwkxK2q6BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 22:14:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 22:14:44 +0000
Message-ID: <fddc0898-7281-4d72-8d0b-0b712319dd3f@siemens.com>
Date: Tue, 5 Dec 2023 07:14:37 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/psos/task.c: fix build with gcc >= 12 and -Ofast
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Fabrice Fontaine <fontaine.fabrice@gmail.com>, xenomai@lists.linux.dev
References: <20231204083935.629619-1-fontaine.fabrice@gmail.com>
 <e0089ecf-a597-49e8-8186-9944101260f8@siemens.com>
 <51181fc4df79c4b6cbfd17fea731eb512d4740d9.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <51181fc4df79c4b6cbfd17fea731eb512d4740d9.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:403:a::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bed862-6fab-4884-9416-08dbf5166b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x1PoMjlySMFoeDYV0NIagMGeVeQwdHsC6YW3jL5023ohH0/GoAbS6DzTvF7q80b4+pLWdZ3l+HQQV8MMltEtSfjKUTKF8FFUCn3tCVpB+Vo1IeRZEZj6KXcY/T4CjhrCY0BCl9eBnVCO3vgnQhwQtDcyzcSgh3/RgX8rZ9MWgNOBaT8SvWRIvco3F6gTIKzxZC/VteWuqlEIGTJ+T9jJfD1PUdRXFSt+G9bUE2/7ysDLOhYz8vqopN1sb/d23FV8Eo+I/fmyFm3PdeGNPJs9SaK0yWU8W2cWqfU8MKMJVHK3FQg049oDGR+/R6qvHKoEhISOXBUlW/f5stj7iDRwM+7sviLQ62yQ0J0UBTObYHVVehpV0xnmVAUZUwbys2PIjtYtWU1gMuwimtNa6NQJ28xjMhUYKjkF5xioCwG0pWBP7WT+hsQM/LWBX6MVfTvd4diIB7h8DuE6z8yKtqpiGPDFBMDumj1BL0GbXc8dorHiiXEcV8j6bM35dQYCDHHpV0O0dZpKx5xwPdozGNIs1+0QUZk/m944Y/FnciitQvGsx91SelNUA5sJFr+Yb9dM8rQVKcfY/PMeKLXXjpKGmGkMl7E/jadiq5ydYAwyiND2z3m3MJ6Ro32NDDMecIrmWAQjbkfkCjlyubEI6r3bbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(66476007)(66556008)(66946007)(110136005)(966005)(6486002)(38100700002)(2906002)(31696002)(5660300002)(86362001)(36756003)(41300700001)(8936002)(8676002)(82960400001)(44832011)(6512007)(6666004)(53546011)(6506007)(83380400001)(26005)(2616005)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2xMTERONWplNmM4MEo2aC93ZGkwVnJNTkNNaGNub29jWTJ2K25aR0JSc0Rp?=
 =?utf-8?B?elFRSWQ1NEMvcmNHNjVEQ3NsWEpuV1JIUkN2MW0yV3p2QjQ4VXlyUzRMbGJ4?=
 =?utf-8?B?Y09DT2tmY0t5ODAxMWtIWjFQcEhkZHNsMlRsU1BQcWVhZHd4U3hoS1BCVk9M?=
 =?utf-8?B?Zm03Y0VrcXNTS1VLMEVLeC9nZG5QUHBNVHd5M2xlbXVadk0vSlpuWHZKb05v?=
 =?utf-8?B?UjNBZmd4QWRrTmpTU3Y2aklHK1FnTHJZY2NDbVIycm8vUGc4NmxDeSt5ZWVu?=
 =?utf-8?B?NmZ2bTVxRmR5WUsvUWFuOC9jL0J1T1MyZE1nZ21hangwcHF5OTBEeVcxQSty?=
 =?utf-8?B?K1UrS0haRXhSL0ZtQkJLalU2RHpuQlRJYXJzZXE5YzJETWg2Vnl3UWgwdmRL?=
 =?utf-8?B?R01IMVBMM1dSYzYrNm1PUFZqWnFMbWlEYWRoOXVaZURpS3Q4b3VEZFBoKzhx?=
 =?utf-8?B?SzNsd2xhSWJmS2xkd1JxOUhtRW9WaHRLU201enE4UVFFUktwR0dMY0JURUNz?=
 =?utf-8?B?TmRIRys0a0hzT09mL2g2RzZWWkNEbzVUck9nWmpPUDNrRTZrVHd5ZmV6dmtm?=
 =?utf-8?B?N2ZnV3lia0xVamRRcjB4MllPajFnTngwbkNtcy83NU52WVczNGhLOUpVU1Jm?=
 =?utf-8?B?UUhqbVlBRkhQVklBdFJoeElwbXJodkRPOTFSQklhV2dGWTI0UzZVdDBKcTJ5?=
 =?utf-8?B?WlRaSUhlRXVKTTU2Qi9KdzBqSlZTTXdiSlBjVGgzUWRPQjNVZU1WODNxeWJH?=
 =?utf-8?B?L2lpNmFhbjJWODNncU9EU282SjhGbWhGQjg4OHBZcncxQ1NkZ3lkVUk3TUxF?=
 =?utf-8?B?RFZwRHdXVXlwMmNOVWtQaTdzQ3BvcEo1SzI5cWgzdDdMdlNDeHBkMmgrWE5K?=
 =?utf-8?B?Wk9IRUFWTGhMV2cwandUV0xkZmhTbDAxcjF0a3FIVzRCdWJ2cUJ6c29adUxQ?=
 =?utf-8?B?Z3c0TmtGdDVVNVdIMWNnV1FyYmRZOGJ5alRUcDV0dFdIMzIyMG5VSzhQcGp0?=
 =?utf-8?B?R28vSi8rQ3lQREMzMC9iYW9hNzhLVlM1RnZ2YzNMTmYxWHhUOE94SVFKcFBL?=
 =?utf-8?B?MkoxRWk3cnlqMDdiYjl2aTJUMFYxTmxEeG1YY0ltTzFHSUxldC9rZWplamtu?=
 =?utf-8?B?ZFpqQ0FIUDhLWGN2eUdUSW9UZmZyQkd0ZUlWV28xS29Gc1VoTjZJMjhlcDYv?=
 =?utf-8?B?S1ovS0h6aHV0ZUc5T2p0SFRaay9SWWZ0MEphZEU5ZGdoVHI4QVY0Um8xOEtq?=
 =?utf-8?B?RU9aeERnVTBqeGYwSURXMDdQNll2Z1FnWHNlQW5lZVlZbDdKMDRhajVKQ2dk?=
 =?utf-8?B?QXVpb2FWOFE1QzdyODZNemoxY2xjZmphWmxoRmxwdzNSVllvQUtLYWlseUd0?=
 =?utf-8?B?b3c2UDlsVldYcitIMk1GZ3hCaDg3ZGk4YjlJNFh5RUlTQUdLOE8zN0dVVXB0?=
 =?utf-8?B?cUc5Mmg2MTQ0VkZTWG5nOFRSdmxPRyt1amhWZE4xVkdaaWJWeEJHZDE3RUk2?=
 =?utf-8?B?ZDdkOEcyYU1nYUVZeEhlbDBGRG1SWFoxY1Mxc0IxdkE4UVBpVmZvaXdLRno5?=
 =?utf-8?B?UlhBVlJrK2pYZ3dndzE0Vm5sRkcxdVB1UDdGdERpU3JBN0dSOWRPUWhnRkNI?=
 =?utf-8?B?ZGthYW1qekVteGEydWhhL0RQK1YwM3BKY1NhbmJCSlBrNVErVkI3RytjQ3Jt?=
 =?utf-8?B?Skh6SHVMc1pWaXNmbUw1Z0xVU0VTNXdzWk5CSmhGV1UwcmdUbDd2VHhCOTJ0?=
 =?utf-8?B?VytNYitpWDRWL2dMZFlLM0RpOUpDRGk5dDJIOERHMWVYYmpvUk9ObncxOUhN?=
 =?utf-8?B?cDVDd1VVdDZYVU1LbXdwUm03M2hiTmFvdEp6UDhhdHZ2MHpDMkJZMG12MTd6?=
 =?utf-8?B?VUtLbGJqTmJWd3h4TVNYNGlQc3RoelhqSG1ES3J6Zjd2V29DL1ZPL1pqbVZP?=
 =?utf-8?B?NllueTBVTzkvck5CeW5Jbnl5UWJhVTVTVjdsQVRVWXFLSUUydW5aRk5DOW84?=
 =?utf-8?B?eFpvQVNDb1BLR2Q5dzBXM1hMWGdEU1YxZklmV2xta0xEbHppbFhCckhiQUZ2?=
 =?utf-8?B?aVE4S1dZRHhjSjJGcUNTSVFxTnF0bWM5ZDQvU3lYSnBZYkthcWVjN1grbWVy?=
 =?utf-8?B?U2Z2VEUyNlF2RmlVZkJlNW1KbG9FV1FYS2Jrem1KenlCTVNpUnM3TkxyNWZW?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bed862-6fab-4884-9416-08dbf5166b0e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:14:44.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwqXf7FhOLGZPSEizjhwMCjAE407F7pvOxEXHERl9vIoNzLxCxcx84H6pEetuvcH7/qChKNBmVkEGckvxxpbxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8143

On 04.12.23 21:36, Florian Bezdeka wrote:
> On Mon, 2023-12-04 at 21:52 +0900, Jan Kiszka wrote:
>> On 04.12.23 16:39, Fabrice Fontaine wrote:
>>> Fix the following build failure with gcc >= 12 and -Ofast (found by
>>> buildroot autobuilders on xenomai 3.0.10 [1]):
>>>
>>> task.c: In function 't_start':
>>> task.c:398:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
>>>   398 |         return ret;
>>>       |                ^~~
>>> task.c:364:13: note: 'ret' was declared here
>>>   364 |         int ret;
>>>       |             ^~~
>>> task.c: In function 't_resume':
>>> task.c:444:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
>>>   444 |         return ret;
>>>       |                ^~~
>>> task.c:428:13: note: 'ret' was declared here
>>>   428 |         int ret;
>>>       |             ^~~
>>>
>>> [1] http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1f73a6ed8a
>>>
>>> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>>> ---
>>> Changes v2 -> v3 (after review of Jan Kiszka and Florian Bezdeka):
>>>  - Move ERR_OBJDEL to get_psos_task
>>>  - Update commit message to mention -Ofast and xenomai 3.0.10
>>>
>>> Changes v1 -> v2 (after review of Jan Kiszka):
>>>  - Replace SUCCESS by ERR_OBJDEL
>>>
>>>  lib/psos/task.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/lib/psos/task.c b/lib/psos/task.c
>>> index f678be61d..b5cd087e4 100644
>>> --- a/lib/psos/task.c
>>> +++ b/lib/psos/task.c
>>> @@ -99,6 +99,7 @@ static struct psos_task *find_psos_task_or_self(u_long tid, int *err_r)
>>>  
>>>  struct psos_task *get_psos_task(u_long tid, int *err_r)
>>>  {
>>> +	*err_r = ERR_OBJDEL;
>>>  	struct psos_task *task = find_psos_task(tid, err_r);
>>>  
>>>  	/*
>>
>> Thanks, applied.
> 
> Hm... err_r can never be NULL?
> 

This function already assumed that err_r is always non-NULL before this
change.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

