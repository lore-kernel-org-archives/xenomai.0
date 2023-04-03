Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3D631
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 05:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOAhMJinclcMVw8kj5ADKiGTXzLWZLWSoTIk3gGDaq2HHdq2j11mU+I+JRDOFAUgJMtkrNIMsGQKE9YSpvISqTNxWiohd8FPBiZ9P/c5anPL4f3qC3eqo3aU/1OyMzwSWD2tdUXG9K02Ogfk/tbbw4983w8u+1lV0qf333yVu7wUe5jGH1JDALWaiw+gEujB7XpjLgZCuSK7kvH+YxLSe7ItlvZtKeqJFu1X3bCYloPdLHV5IgoPh8jb8ZDGifsfzRauehY4MaDxwzydofC4jCr8Bo0nK1XmQ8/TxnZK7suOf47hIW50K/9P2rD6gqbMFGT3/eJM8hB9MnY+RELdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY7pXQsNnnb4eGbeCwXtOw0sGo58g502oFn2E/LbXuo=;
 b=a4bmox2iEzShCD42VFaPALlP8/upiT3+zjammhE//kg8aJisvSqgtB6PGT4jsf3t0fsL+rBTMPFCvs4j+VUixvsOqBhXPd3i3eZSBc2rgWTovnmYcx3EoXdj3EXxXYWgebbhdfEqqqDr9NpI3BakhJOaGAtnUrfChhzf+BUAilZCiFGcEdJ0UAiQ2g6uzX34grFneOH98d7+0oo46xFG1FK7JONUQiFFi9tEG0ZfgJWT2JN1f6mcZsxb5gSLkakpeuxM7Nt2V9P2dz3B62gTD8tY4VtKYYVPxBg3XfZLTq1g36olqAsWyMrwAP3YXPB2Srjtj/vhdWM2SE3dYhLH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY7pXQsNnnb4eGbeCwXtOw0sGo58g502oFn2E/LbXuo=;
 b=mQr5vZkLCaabjVAxDVGTXzQtTUV2Rwo8yL7cZJdKhM/7SfAkHZRdszbfp0NdpJfGaCP2YenfE++e4CcBeVg6qWBLj4OC3dWHhl0W+mU1/qVYTX8FhOWN2WPHU0bsGE5huG6Q77Bo5GaFaWHcEA0THchSUmu1oQ0A2HEp3adaL/D9L6+CP7XsWY9Xqhrrw2fWP4mfYXDSIXyneRB6idPd3RonHEFpmPMFae8trEzfcofiQIGCIelR4cTovBThxlWWMwQSAl96XoEmjSrk04cH9KyehYOsnt4Ta5kIbhscIEZBlde2LFB5+8mqnEGiMVWtLYWBLMWZ8rO1Qz1eSYDEQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Mon, 3 Apr
 2023 05:29:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Mon, 3 Apr 2023
 05:29:43 +0000
Message-ID: <01cbe2f7-ad57-a8e7-3def-924037a4b42b@siemens.com>
Date: Mon, 3 Apr 2023 07:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] debian/control: Fix missing dependency to gdb
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
References: <20230327105542.1320510-1-florian.bezdeka@siemens.com>
 <aeb950f3-558a-f704-dcf0-7e6ffc1c7283@web.de>
 <54f04d62-9f13-b8c1-f69d-f42f5f394272@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <54f04d62-9f13-b8c1-f69d-f42f5f394272@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 733252f1-e2ca-4ad8-4b49-08db34046df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/l3ZnHfeCi0/vc6n6TqG1QeZ7m53Ale8BtEni6PlahL/RjTONarbxqfLjio3yksGcsMIv+hSsJbykN+iRXhQsqjr4br5Wp14NAWJ8ErTRsQKzDLHuWficP9WHkQR9fgScfDCrBfvC7KBKSMuR5biXZRce7U0nIF0zF7Qlny+JlIGu0ueoOKqcN9NszFmKxtGKle581Ykqbt3iuCb8NVb4Q2JoxJgXcrRu6DD4PDgsJ02neON8uGm14qNhvlII+3ZumOaujbMUF0hhM5UlVF7mDIZtMP91RRLU2Bwfq4FDxfMKkkBGS7UFx/yaERgdcTPHzuY+qsBgzANxYPpKYti4g+UlZApj/BBg7NuSsOWxTgpehjjoGuDdijVphwzwbNcC9Qagn06LLyUmtTntDl0Csl7zdJ3WXHsr8XHJDcfVrckNYamOFhN1U8KBYitdbYHeD8xHpltY/R/MrxaftcpALM/g8BE/kpaDiNLvRAjVJIXDwTqkxE5yQTwgVge9l24YQc8egffwKQkVvypQXPx/d4ghkTc8XxtX6OZ2dAqglR1Bjl8Zi7KKAG0wy0Jd7O6vIATDHyCZaDjkU00JVODorP3lbM0Nmcg+Jy2N+6cHyAqlyJpfmmocpCUWez0BksSnqdlAxFczqWwg3PLhJ7CRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(41300700001)(8936002)(82960400001)(26005)(110136005)(316002)(5660300002)(31696002)(38100700002)(86362001)(44832011)(66476007)(66556008)(66946007)(31686004)(8676002)(478600001)(2906002)(83380400001)(6486002)(966005)(2616005)(186003)(36756003)(53546011)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkVTSzRXblZhVE1vclRmWHIrdm43aHNIc3JXUjFLbU9hS2U5U0Y0RmJMSk5k?=
 =?utf-8?B?VlBQVU1FZ2p5M0tsYkxDN1NTdmxzY1FSM3o0WXBjb01uY0lkR2ZKMXVNQ1Vj?=
 =?utf-8?B?dHVDbHJGOEFKT1htUXgrQkpiWjVYeGpDR0RPNDAvdVg0OFk3V3ZmN3VmSU43?=
 =?utf-8?B?RFJFRmsxY0xEMWJFVEF4UGNLbS9uK011NnpobmViM1RzZFE2R1c0M2gyckda?=
 =?utf-8?B?U1dTVXVxVVRDS1MreEJaTUt3SGJZUW5EaDBJL3JvcXVFTHU1U01qb0tuSU9j?=
 =?utf-8?B?cEIwOFgweC81UjB1N3dGbFd3aUR6bHZmcWtmQUlobGE5Q2NjUzVpM0F1ekpv?=
 =?utf-8?B?UkY1WXp6K09qVGhHT2x1UXpKRVBhYnNLb0NKRHA3bXkrc2JXTFo0NUVJellx?=
 =?utf-8?B?M2VnRHVzSThHSTQrTXFDbktaQk1OUFk3emViUTZldlZzdXNRTDBiakNFM3d2?=
 =?utf-8?B?cklONGlZMHFwVEszalphUytnTkRJdkdBYWYvMVIzaEUyMFNlSk1uQTl5ZzR4?=
 =?utf-8?B?b1QxNmljcllDZUp4TkpoMTZYM1diN1AwTWFIdVA1NEc5bEJyRjJpQVdYYW9N?=
 =?utf-8?B?WDFmYncxUzAxeExRdFNBUjFRSDQvdEVoRldNUm1neVZ6SER3M2lpdkxWQTFj?=
 =?utf-8?B?MFhONEs0Um4vQThsTG95bDgrTXVZSWpBalF6UVhsN0NKR1pLNkRvQnBCMWgw?=
 =?utf-8?B?WnNWMUJFTEQ3dFJFeVRvdk5GNXNmdVJvai9tNytRd0plZXpaMWN5WFhLKytT?=
 =?utf-8?B?ZDloN0RabWNIQzZTcXgxS2hYbDl3THo4bmFpd2xrQzNhQllZNUlTZnBsUkls?=
 =?utf-8?B?Sm15SUtMVzNsTWJXYmc3UGFxMVdsOWxuYm1aVDdUOU5KbnhrM3ZaSGI0RnE2?=
 =?utf-8?B?SmZ5Q3NPNW9Bek5vMURvb2ZRbFdRaXlZa2pBNzhXZDV2dlQ4MWI5UGZMNHAw?=
 =?utf-8?B?VXRrZ3VMU0d2RmUwNUJHVkpHOEttcEpzU0Z6TmJaOWQzWXpHTjJkRlhmeU5C?=
 =?utf-8?B?aDlkS0dSTkNiQzJVNU5MYTdQUFptS1RoMnluZ2NLRGJ0ZXVENnRvcHI2emZm?=
 =?utf-8?B?M213RUtFRnV4SlR6SjlaYWNvcG5lUTJlSmFsUmwvSlJ6K0JZQjNtQmtMTWVq?=
 =?utf-8?B?ZENQaWIrSXhscVZqR05EM2locTZmMEtEek9UamkwSkdKcW1kMStkOGdOdUdx?=
 =?utf-8?B?L1BiTTM3aTliWGFGczVpVlVFWjVnZjdTaWZpSER4Wmk1aDhJQWJubFdodVNR?=
 =?utf-8?B?V2d6YVVvaFFzVGUrU0pNd3lvTHAySkhSd2VNNG9LaTN1eDBMaVBpQW0wTUNt?=
 =?utf-8?B?R3FhWWNncEd1T1JZSzlCa2s1SzlzTzREUGk0ZjZ0VlhDUmpvbndkMzBBcmto?=
 =?utf-8?B?MFdBVzVJcnpkMTN2ZG9Denk5SEVUR2NPc3luais5SlFMY1J2aU5FVGN5ZTBI?=
 =?utf-8?B?N3BqamJpbVZyeXQ4TDVka3JnQ2JnK0VEK2tMb0FlSDh6TWdqbGJGeEZIUW1Y?=
 =?utf-8?B?ZW05dGlBdFBha3FXK3RtTno0V3lUclRxbnNaM3crdGRMc0RnZ21FV1c1MUVq?=
 =?utf-8?B?allBcDdWbjhlQ1hLbStNUFdBVVUyS1ZYUWdzRXUvVTdNem8zMndyNjBxZ29s?=
 =?utf-8?B?WVVrN053Q3VRZkI2T2FxNDJRSlVqUzlya05qQmNXN3VmY0tCMG5DUU5vZVR4?=
 =?utf-8?B?UHRFVlYzVGlOcUkwSUk3Yi9sa2piZitsUXlNaml5Ly8yUXFJbmpHWng1SVVB?=
 =?utf-8?B?M1pWTDFENitXRHZRNTc4UitLTXZtK3EybUR0bExnYUxxblZlbm1lMkFHSlhQ?=
 =?utf-8?B?Q0VjbkhoYVJOYlROait2akVla0FRTnVPc25hc1BMRFRhK29HZ2Z5S3ViV296?=
 =?utf-8?B?Z25vOE9yQlBrYXNuWjVrZkhPdURrUXI4bzVjWmlJcmpsQ1RTc01zZmgwWVJI?=
 =?utf-8?B?c2lNTmgrS2l6T2dzWE1hZW9wcVR2UGZyd1FtbGEweVJiamc4SjRNRW9nbDdm?=
 =?utf-8?B?cVFFNjdEdU1QYnpKMkZrSEpUcWNndHpBQUwzdlNvZTFHaSsySEg2QTlOUWMy?=
 =?utf-8?B?NEwrblRjRy9adXZuV3JKR3Jqd29UVjRxTDVaMURuWEpaR1VLYlE1cTlSNHRi?=
 =?utf-8?B?b3Z2RXR4eldlblAwczJmMGtER3JNY1l2UzJMS3VKQW84T3V5WFhGRURMT0ww?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733252f1-e2ca-4ad8-4b49-08db34046df6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:29:43.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLGGbQXauEvw990LhcOw5fEMHXJgQJICScqCnZy+n8VVlcL6xbaODmQWka6UmJOyfOnYHGrJltdZVM/Wuauo8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7268

On 28.03.23 16:33, Florian Bezdeka wrote:
> On 28.03.23 00:55, Jan Kiszka wrote:
>> On 27.03.23 12:55, Florian Bezdeka wrote:
>>> The xenomai testusite - part of the xenomai-runtime package - needs the
>>> gdb binary for testing the gdb support. The dependency was missing so
>>> running the testsuite on a fresh Debian system failed.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>
>>> Backports to all the stable branches will follow.
>>>
>>>
>>>  debian/control | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/debian/control b/debian/control
>>> index 857d8ff8f..aba59949c 100644
>>> --- a/debian/control
>>> +++ b/debian/control
>>> @@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
>>>  Package: xenomai-runtime
>>>  Section: devel
>>>  Architecture: amd64 arm armeb armel armhf arm64 i386
>>> -Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
>>> +Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
>>>  Suggests: xenomai-kernel-source
>>>  Replaces: xenomai
>>>  Conflicts: xenomai
>>
>> Looks like xenomai-images installed that "manually". Can be dropped once
>> this fix is in all stable releases.
>>
>> Eventually, we should split off a testsuite package to allow installing
>> tools without pulling all those deps of the former...
> 
> Yes, might be the right follow up. I guess the situation is different
> for stable branches, so such branches might stay as they are now, right?
> 

In fact, I would not consider this patch stable-relevant. No one
complained there so far while its side effect is pulling in a rather
large binary. In that light, let's fix this in next and leave stable as
is (manual installation of gdb if testsuite should run those test).

Alternatively, you can make the gdb tests skip in case gdb is missing
for stable.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

