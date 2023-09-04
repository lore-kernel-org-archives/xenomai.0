Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED0ECA
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 07:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XloOvb400C13AIZPm4WRkwqgexLDzcYZCNSMpC1Pttr1pXagQkB636hikEqSGZy6r4FE+L3qWaC1MmXuBnaecqI9Spj1fbZe+24E19Spa4PHLxpoEseLrJXow0m/DZYOa8yK/tcYEJ7w3fyHzo6kBaAXTkgoWqCehGEITBJJB8i4sjGz4W7xZvGlZnTwuLCiO87rSm/73+m0q0E2KFTBt2p9Hg2T/uRHLddmUYB1hzWnIFAfIuElm3EOPPWujOaLVmNQK2C2FCZd7xov1XRYNOP89x4WKlz0NjtGMIla4UwLT/omCsBT6nuBxzPVRIPqWpB7vy9mH6vaEeYjF8EaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoD7peYviHvQ9gQ5UXR+un9+uKxK32LzJG6Gh8Dt1Ho=;
 b=KV7Kt/1nbhMVl8XwDR84x8068I9fSXxUSPAx05faI5EdGP3T2fbd3S3+bT1TVGMm4FWpbR1dEH7hF+blpknNphtdNXjob0usi61G8mHkneSUL2vB3WiZFM+cTTMCc5eloYs0r1lx/6S0O8mEHPgk+yMwijp5GWhZaz5D1/rYpamkBTJ7k54puxrxHwTfaNh/m4A4LVpLdzjCAXsbok194xg/fuw/flmeW4nDiQUIw0EaUZs9cQzNfCDY/HQFMKAepJyofUbWI43MD0l3u6GYbSX7SS8iOYjUqMxURyLoK7xnjLOqiY8YOzMzsXC8glqwvziWSVHYWAZI7Wlo8X0J3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoD7peYviHvQ9gQ5UXR+un9+uKxK32LzJG6Gh8Dt1Ho=;
 b=ooQRRTw5fTSC7N5XPUpzTDKpCbvDTLyfB1/DHEOojsIGdORSx8Pki6EoXscVXurCeEnoJJqi05iyRsDL/2TaYlEOc9FEHQ7QgDOvjuce4lNPSw0rwkkta2QYwP8ekixiEQaVlUn8HGAROYBPIGApW4dBZ29Zvcbrq6o63vT7fCAQ0NEx8fdcP0qr8ChWdFMgFWMrGgE2sUDhNDVXaNuJDAZFjw4qxLJIbJcH1kHuUBiuC2Gyn3hxKet1VSbop0FE6PYU5nATHCk0DK0epZxvqlXoIQ+q+o5cVwxN0WXavU7YlcIeLV/TqJMbSJCbpLV1ppXm/lLKD9Q2zN/BDzeofw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 07:36:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 07:36:23 +0000
Message-ID: <90cc940f-f8cf-4fad-8e57-1279ba75eaeb@siemens.com>
Date: Mon, 4 Sep 2023 09:36:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] testsuite/smokey/y2038: Activate minimal
 clock_settime64
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1693753497.git.jan.kiszka@siemens.com>
 <c5c4fa95852cd25596d07beffb6d8664562c5370.1693753497.git.jan.kiszka@siemens.com>
 <28115494bbd7f93edf8f17bf6bb9c62c76aa0e11.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <28115494bbd7f93edf8f17bf6bb9c62c76aa0e11.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 5945e14a-ab60-45ab-b628-08dbad19a3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yXxzOh6Dqf4Tjd59JGX9IUhO1YG5qKVptSvXgcBVdaoc72Y8mSq6OTeTZJVeJDmZSxz/DpCgH2Quxj2e5Tg3vLsILS83PEZ+xJG5J1/gKnGvFOZd+d+jxDVKV8ClAjwq2wvbvRrdGcPGXxqu8d/8db36u6+zE5nUmgSPwRSeKRHtycitQrGvAUAFIoiKZneaZdHni9bMHt4PE7Sdd5SKlqUY1WlGAkFe0W9cgFH1ijFwx77r/T3kj2As/RAUYwz3L4+5czaK94lkbTsNmHcVwA3zU2j8ikI0IszXa081IlgJO21NT+JwiPjr26vJrcQ3yhvi/QgQq0wmPmCEaktbIk7EhFxk8n3tbQUEmjH4e3+RLdh08MHFJJBzL89PT89B9BEXwy9WpCoyemDWSetOfYhtxkdJcolaNrQsiuLo1A0hAS8oOy3PPneZ3pyW45vsG1nPgZF8lTRrpiEhZ5BDm+NKbNUc7+zd1OEt2wFmh8gmcBS1riQfIPgGAG+IKS7vxP2ofHNNOjhUaMHEHzYtvpqeS+C8Qf8qhG1BZIms73ZM396qzdJt8HcRpKBA8mQR20AVm8a+Isc7EYu60cC0lh0BUuMUjhZ7kQgzolHJfQfLS35JU+XN+y7Ivesih1S+QbjN3TzoOlpap2w2llZFJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(41300700001)(6486002)(6506007)(53546011)(478600001)(82960400001)(38100700002)(83380400001)(2616005)(26005)(6512007)(66946007)(36756003)(2906002)(66556008)(66476007)(316002)(86362001)(31696002)(31686004)(5660300002)(44832011)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NqaVdLMUUvQm03YTJLalJjMDBFc1ZoaEg1WTBjRDFaSzM4aUt5N3pWR0lI?=
 =?utf-8?B?eXJOMzN3WG1wNUZsOXhNUlJoTUFqbjM4MkpZYXh0VGFlZUNsOTFVckFaOGxJ?=
 =?utf-8?B?dlplWFpYMjJuTlFpdkwvbzVqVzc3VjE1L3FCck9rcHRUN2NlbXFlNEVvL2U4?=
 =?utf-8?B?Q1d1aTZER3BSKzV5TGF5OW5jTUgyVk9jNGVWKzhFbnJ5ZVc4aXkrYWdPb0dI?=
 =?utf-8?B?U1FzQWZhNnVSU2Q3S1k0MXI2eWw3cG0zdFpsTzkxTnZJbjJVN2NkeUFLYmtY?=
 =?utf-8?B?Zk0xeWp4YXpEa2pUMGFaOFRLQ2M1TXYvMG5QR3JSNVlGSG9hYkZmOFlvZm8r?=
 =?utf-8?B?b3pYb1d0ZXMwN3ZZaUVBTFEyR3J6R3F0bUJQTFlrM2FZR0p0S09IeUtUMzRR?=
 =?utf-8?B?MzBPWVpoN1ViaTV3M1I4SUhBWmlESlhmQ3BpNExUMkErb1ljUk1zd3dRcit1?=
 =?utf-8?B?UmU0eENjdzY1cTdmYjRvNlQ4YUQ5bElHTFdqVHM0TUtNSVROQ2lNMWpzMERD?=
 =?utf-8?B?ZlpjMzA1UHN4NjFUUi9FeEovbkdFb0k4UU1JU2tFa0JEREhMNnNwaTA3NUVW?=
 =?utf-8?B?T1l6blN4ZkVzRCtKeWNEU2FIbmFyWkU5LzJScERFbXNoUGMyUzhzRUM5OFo1?=
 =?utf-8?B?dEpNblNvTXN6QkNNOFpDYnNEY1lLSnpXaDBvK3c3dFdNZ05TU1BtVGpDVWtY?=
 =?utf-8?B?RVBsMjVIQXd2b241NFFHYmg2a01sQmNzS011UysrRzE0T1lFUUcrVDhjMk92?=
 =?utf-8?B?T1dWTVRjTjRuTXU1UXhMQkNHazk4a2lLSytRd2VPMWVON0ZwcTk1T2wycjdl?=
 =?utf-8?B?L01UZkxtOE9YeXdJV05mYndGNk9aend0TnJLdlNmT2NOc0x3V0hvSXQ1YW91?=
 =?utf-8?B?SURidCtkRHE1QjQxSmJvVURKa0VYZi9XK0pmUmZmTVBML0poMlVtL3N4V2Fp?=
 =?utf-8?B?R08wYVpLZCtnR00zcnFoSGV6eTljZHNDQk1zYmpmU2RaK3N5R2Q3c01KTzJj?=
 =?utf-8?B?MEFpakROdVZoSU1jZTFHb05kMXljRnRhVGFya1RrazU0U0ozb3pXRXJlb3Fn?=
 =?utf-8?B?TGN3ajFHN0VpK2MwK3JtaHRPNzQyQ3p6dVZrM0pjSGpnVzEvYlRtaFlCM29h?=
 =?utf-8?B?TmRCelM1cTIxeTdQS3ZiZGlyWjkvRjRZN3JnWEhBS3Q5YjdhQmYxcUZYdC9q?=
 =?utf-8?B?N2dpNlVtTHZVT21WWk81UEpVdTlMM1Z6RElFTk5hRzVCTjExVkgwbjhEenZK?=
 =?utf-8?B?MUJzU25MWVlwK244STgxOGZUU3U3K1BuK2QzRlFSeE5UR1BTbmZPVnJnNEpS?=
 =?utf-8?B?R3gzN2JMQWlFWHh1Y3hpaFNXQjY0R1FOVlhxN21zYXlKK0g1SGpsb2NnZVlh?=
 =?utf-8?B?b08vQVJNSGltSHROSnl4d1BMM1Jla2ZmQStBNzQvLzE4SjM1SkVhdXZteG5S?=
 =?utf-8?B?ODg0V2x4Z1VjQWsxZ2tVUTNYcG83UllubEJrSzZXNEg3YllLZTdpRWVzMnlP?=
 =?utf-8?B?Yjd2cTQ5aHVHOVdUTExBN2IycFlMZzMwQnFaUWNMV1FpSXB0c2JMSmZmTGw1?=
 =?utf-8?B?dDRpQWRaYnVMNk82TkZhSnJsRFU4SXdDU0V1QStEblkraXBrTzZ4aUJrYk1C?=
 =?utf-8?B?dFhDRkdpRUxXY2d6NjQ5bFN4M1hES3FRZlhScnZMb1c1WUlEWXBmOVJZUlk0?=
 =?utf-8?B?VDZBNXVORmFUbGFKYXVZQ0FjYVNrd3d5WjZDWkQza2xBVnQrbG5FM2ZRSmtJ?=
 =?utf-8?B?TG1Ob1k4OFBHNEVDdE5GMmgvT0hkNTZwbkpzNFh1WFp3WDRJbXU5dkF4Qlo4?=
 =?utf-8?B?WVhyTUgxdFdSa2NhSXZtMVVUb2V5QXdTVkFGbzh1SWphdGk3QnRqL1NUazdm?=
 =?utf-8?B?TUpFVkdlZGprNDB0cGp2VkhnYS9MdDlWb1Q3UnBoRDZ3dThDRU90aktQYzNG?=
 =?utf-8?B?VFpJWW1HcXdCOVhDVlJOaVQvK00vZHdaVzFSRkdsdXozeHM5Mi9xMnB5ZjRq?=
 =?utf-8?B?alNaRTNaZ2FORTJVV0hWUkdITUhQOUx2QUloS2NLbElTYUxMTzg1c0Q4R3Br?=
 =?utf-8?B?QkdXWXQyejZGZmFkV2pLQ2EvUE12eWpqNklkVlE5TzRlamgwNzlCcFFTS2lm?=
 =?utf-8?B?azVCUEU2Rld3TEY1VWlSUmM3NHNscE5qNnEzaUpqR29BTVN0T2tjVFB0WXd5?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5945e14a-ab60-45ab-b628-08dbad19a3ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 07:36:23.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/HUyDQAkyqj3xWM4/PW7hXWbic3K6il5qvSXx07QDYdoUAF4scgV2vsJXCnfxe692QTYJ0s50OP+f8FW6QFag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7382

On 04.09.23 09:12, Florian Bezdeka wrote:
> On Sun, 2023-09-03 at 17:04 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The clock_settime64 syscall is theoretically still relevant, even with
>> libc-based settime for standard clocks, but only for external clocks -
>> which we do not have in-tree. But we can at least check that invalid
>> parameters are detected and rejected
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  testsuite/smokey/y2038/syscall-tests.c | 30 --------------------------
>>  1 file changed, 30 deletions(-)
>>
>> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
>> index 0c7de52161..3d4a9106bd 100644
>> --- a/testsuite/smokey/y2038/syscall-tests.c
>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>> @@ -278,18 +278,9 @@ static int test_sc_cobalt_clock_settime64(void)
>>  {
>>  	int ret;
>>  	int sc_nr = sc_cobalt_clock_settime64;
>> -	struct xn_timespec64 ts64, now64;
>> -	struct timespec now;
>> -
>> -	if (!cobalt_use_legacy_tsc())
>> -		return 0; // Not implemented, nothing to test, success
>>  
>>  	/* Make sure we don't crash because of NULL pointers */
>>  	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
>> -	if (ret == -ENOSYS) {
>> -		smokey_note("clock_settime64: skipped. (no kernel support)");
>> -		return 0; // Not implemented, nothing to test, success
>> -	}
> 
> We could keep that. In case someone is running the testsuite against a
> kernel not providing the syscall under test. Unlikely but possible.

Not possible anymore due to ABI revision bump (and all the changes later
in this series as well).

Jan

> 
>>  	if (!smokey_assert(ret == -EFAULT))
>>  		return ret ? ret : -EINVAL;
>>  
>> @@ -298,27 +289,6 @@ static int test_sc_cobalt_clock_settime64(void)
>>  	if (!smokey_assert(ret == -EFAULT))
>>  		return ret ? ret : -EINVAL;
>>  
>> -	ret = clock_gettime(CLOCK_REALTIME, &now);
>> -	if (ret)
>> -		return -errno;
>> -
>> -	/* Provide a valid 64bit timespec */
>> -	ts64.tv_sec  = now.tv_sec + 1;
>> -	ts64.tv_nsec = now.tv_nsec;
>> -	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_REALTIME, &ts64);
>> -	if (!smokey_assert(!ret))
>> -		return ret;
>> -
>> -	ret = clock_gettime(CLOCK_REALTIME, &now);
>> -	if (ret)
>> -		return -errno;
>> -
>> -	now64.tv_sec = now.tv_sec;
>> -	now64.tv_nsec = now.tv_nsec;
>> -
>> -	if (ts_less(&now64, &ts64))
>> -		smokey_warning("clock_settime() reported no error but no new time seen");
>> -
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.35.3
>>
> 

-- 
Siemens AG, Technology
Linux Expert Center

