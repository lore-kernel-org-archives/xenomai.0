Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E76168E
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GrGCb+rR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWtjlXF72l8Pc9nM40Zr1OSQeZezuMtfJ+69VETtBn8BQ84xc7PRx9bolM6NWWM86r81ysbJNt6u3dGyzLpUBD8i+u4gZzbE1Nqzo7Y6kzZ+Q0EWNmJVN2L7uOfPlp6shrVcMrY66sW9EqU+COleElrhof+Y5uxCu+7nt0ueggAhRNdq8IsofE9ApNkvaAGG/8k8ukAc+hlfXA9zdjx08REZ4mvr/h2Zee3+L2I8HHk4T3xY1n4Wdtvwdmh3topfAJkEGLqukq00B81kc/smYZ9wZ64qjGEMG2lVOJjXBqEx0eiFvVg9Xl3C9e/rnSLW7etxa5RG5g60+aclo7oHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUsM45gVb809oJZUWdKOCDHRWR7EReOwFVICL9uxpPg=;
 b=MaqPjq25VMngBLKqZV9DLJP5uJXn63sva28bQIpPGq6D8LH4ELenlpLWOQphQyamxkJZ9ea0E1Pnh7rV6W6hwggXulovwWDIMRCKmOvxpI6Np1D/yrvi29McgAfUb0gOsC+uOcK526UYzMsVA3PSnBs/ghFBU4bSKAaK6hIOvWTgbgKpP9R5hxCZ16E1NDFoP7jBAVcBTTVEzxgdTPfazsPKpx4gg8HUh8JeQD/eaVzPNmIhVgtgvGOz3+F1FI8r8MpPM863nXH5U2UaFasPm6rUsEfOO7MLO1+S5akchHS5FJfN52V3StXZ2D3Yn5vKmFSdbxVFEEmBaNo7Gn8Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUsM45gVb809oJZUWdKOCDHRWR7EReOwFVICL9uxpPg=;
 b=GrGCb+rRSXKsyg2tMi3509L09P4zZ3lhDxHrxaK0T/WFFZpEyG3gJJbAiR9q1P/4RhSPDw9AUSFXIjc8r/y2sGMR0AmO4q/KqLhstaKA4ab5QQQkNGQOajjmlxZgQKm9SI3RampaNLbp6YkwlPzUaNK9IFYt3Og/E4iQAH5WmVUJRsCZckPGlv+yZLqUz3vbfoMwvOSZLuKghEFFGn+0F31XUlG7sknIZqZ47yBeguLEqVgJjr0edf8m/dUwoyLC0oQ2sprXm7D+nkJkrLPaUX+Ipr6NSLgQhtQaetO3SyohXiYhl2YODlNWhx9baVr0OcJDJVcsgkWsWas5A3Ow/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 13:15:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 13:15:06 +0000
Message-ID: <f990cf59-5dec-43f6-90c3-447fdb12ddac@siemens.com>
Date: Tue, 12 Dec 2023 14:15:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/psos/task.c: Fix psos tests, incorrect error
 reporting
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
References: <20231212-flo-fix-testsuite-v1-1-614eb1703e08@siemens.com>
 <b96c25bb-20b1-48f3-8eb8-a9b1876ee820@siemens.com>
 <a8d23bf707291c5d8ef2534baf8c22b535f16159.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a8d23bf707291c5d8ef2534baf8c22b535f16159.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 77969893-8088-441f-3998-08dbfb145bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/9FKoX2kEfCwf2jUak5U1IpGqHJycv26Yp9YKKR6nzt9eReMXocOL7SZxkIRPc8h+6VBY2DFoe3r/bY7VuLFoIKcSf+/dCVlTLZfs14YLMk5UnwyS7T5msE09onuTMNGXjDw4LomCgMslyWokIEzjxJ0ZJXU/mNqFASYOXB1EZoX0tIA5HnUzfQZUldQzLAqlEoMalzpAORV2dPWlqfTt5nwS5cWZ2Oih98TGfVt1e0EzZ9bIRHYLLU+pXqw7zkX7CAS9nNpPPfRz3mIZrt4JKkxg60TzagWcorPt9PNMt29sWfcZfjEm/8oPI57/gsAC4AyaDlaYV846n7K8slyHPj1XqN5VH1tSy/4j+aTJHaFHci65BaiiCa4xmvfmmBhn3OkjDQve0D2Xs3WcOXd4itxmJBzXqjX6UA2o+kc3gGFxH73uZHZ/iw04nT/3sh6frKuOHpRrSIjA+XtidfL/EYTPBmQTSORrcDL3QMKExKiFIsHNk97h4MYu4tza7WrEQ1nVCqken5EBZuXKc/x/m4wA0OuKRTQS/TiPZb16ekv3iPRGtFGNgd2tNBRvc7owtuExeUlrMMmc3OKcOynZGTuBfTL/u3TH5MeNCyE4pNdCIs3+h1VnaeipDxRuv07xqOA9C/jVjF0Q98QNQAI6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6506007)(53546011)(6512007)(2616005)(44832011)(8676002)(5660300002)(4326008)(8936002)(41300700001)(4001150100001)(2906002)(6486002)(478600001)(26005)(38100700002)(316002)(6666004)(31696002)(66946007)(66476007)(66556008)(36756003)(86362001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWRTVWFjT0YybTlWN1dBb05kTW1VSU1Jb2g1UkUrSDN2aC9xUjV5RlRVOWM0?=
 =?utf-8?B?SjRYZlRHZXNVSWQyN0ZONXhHbHE4MWZXY2xnc0hDVmlQc00zZEVrSHBxbEhm?=
 =?utf-8?B?MlFVODZEK0wrRlVGOC83K3NmRHpnRTJSeWg0Rm54V1NxUXV2bzI4WkRMb2sx?=
 =?utf-8?B?YjRHZXVCSlZuSVFDTFhLSWFpOS9aNnlhOXhoekhyUWxFRkVXUUg3c2Y0TXdL?=
 =?utf-8?B?V0RON2x4RjBOUGMveDcybU8rNEFwMEp2RklYUmw0TU5LMzNGU1c2UXg1Tm9Z?=
 =?utf-8?B?L0JSazVxQzkxL1hxbmVLM0RPYVZld2E3R2FLVCtlK3hMekI0aTczcDRCcTlS?=
 =?utf-8?B?bGJlTjJLbHB6UnRCRkd6bmN4QXgzSU9PSDBOejlDcnRHWHNZclhOeTdhanJP?=
 =?utf-8?B?eDJDMnlQTmFRWW5kMGNDemxweTJVclBYSGJINlhOM1RLUnVhaktyZ1dDc3RS?=
 =?utf-8?B?ZnlOUS9qb0hQcjF1QThJUGtTdkVBQVp2MENFdDduSVpXWkttamZIT1lzSkth?=
 =?utf-8?B?UTN3MXJxcEE1T2ZldjczbFZZSVBLUjMyK2FiMmRoSFVlZi9BK0xOdWo3S2dN?=
 =?utf-8?B?SE5HN3lPSUk2NTdVZWlMb2JIcnVhcER6ZFlGdDAwSUQ3RHMxNEtGNVUwQVdj?=
 =?utf-8?B?b1lsZW8vTEJVMkJVTnQ0Q001TG5kd0pjZGRNRURXNy8rSWFYcWJWM0JaNmNn?=
 =?utf-8?B?U1JNMlkyM0JBS3YxYkdvQzhudFRMNFQreWhCYnc3ZnBhQmdPamdBVkNwYll5?=
 =?utf-8?B?NENqRng0dmt5d1pOdXl4WGRQMHQ3QjMyMHBiWjRJcWJ2QnVpRUpqWlc4Mmw5?=
 =?utf-8?B?dXZyM3Q1T1RWcFIyaWRXcEQzaklUK05LM0ttdzNvT05ELzdhUC9IVUM4anNu?=
 =?utf-8?B?M2VWTHpieXFZNGNvd1JrS01uZEQ4V0VHaWl3d09mVUlnNHZnNTZ6eHltd212?=
 =?utf-8?B?U2QraHY1SDNsa2plZDdmNXNPWXVYcTg1bHVhMXBVV1QrTXZFRC9oSmdGM3hY?=
 =?utf-8?B?bVBuUzVMRDhDZERFejFQWG5SQklGSHJIVFRjN3J1REpSUVQ5alRVTmk1bVNn?=
 =?utf-8?B?N3JIZE15RVVMYVhuNHlxZkE4cXF4WHJtVG5RckdLWFo5YzJVMDlJNm5GZXhT?=
 =?utf-8?B?VzR6VE0zalBvLzFKcVNYcTBTVFhyUkZPeTVSNzZqQmdRYlU2aXQ5RElkMmgz?=
 =?utf-8?B?RXJHaVF0c0YrZkJIb2EzcURGQklPUHBRR3NLcjJ3WDJyck53UVl4RGZwcHpy?=
 =?utf-8?B?WHFUY29BMm5Sb1V4aXFYd2RycVdUTUE0bFZZcEsrdkJPM0I2cWVrenMyODNB?=
 =?utf-8?B?YnlKajgwQXhPSkN1M0Q0bVlxcXg5Mm9tVDBudVRDUWdaWm9BbGFRbjRBbzBh?=
 =?utf-8?B?bzdST2VPV1R3SWpTb0JMRXExNXc3TUFmc0lRWE5DRSt5Q0NsaVJtQkJ3aDlx?=
 =?utf-8?B?WWQwTmlydzFNNU1VUEhwZGdWWExNQUN4RU8yVS9QQndQaU5oM1BtejJSQWY1?=
 =?utf-8?B?Tk1yOURSazNma3hSS3Q5bWFvTk8yNWRyUmJmUzZZemg4M0YrNkJqOGJod0d2?=
 =?utf-8?B?eWRrZmlvNWJhWnk3c0ttdnFlTkZkd09WT0FsYVk2VjdGS21YNEVTdTNiR2g1?=
 =?utf-8?B?aWxERGpBdjNMMldzT0QwTysremhFMEdBYXF4OWtyRWphY2xkSksrYkx1eGxz?=
 =?utf-8?B?UWwvZVpVTi92Yk02dWdLczdRM3M1bWZFMlRtaFdZZXJ0ZzdvbXhIV2lhSHds?=
 =?utf-8?B?VlZmQ1NQQVBCeXN4NDFMK1krTjhVYkhQKzhjMC9scEdjN3dsalBaTTNNeHE5?=
 =?utf-8?B?ZGljdFoyQ05SWUQ1SlFPNmY3dEJkZDV1UXEyWG5pVXZ2L2JQSUNINzdiTCth?=
 =?utf-8?B?TWFvTkxhYTJWTWFmd1pVSXlSOVlBd01tV1NEeXh6b2s2c25ROHhCYTExMU9D?=
 =?utf-8?B?Wk1DdDNXRFhjNGRvUnhUZ2lRdEU3Mm1hdFBwdHBhWUtURndpNjZwcDNidS9j?=
 =?utf-8?B?bjlUS05oVDNScktYVUpmOGYxM0lZOGUwRlNybXVXRTFlV205NWxmSkVwMFJR?=
 =?utf-8?B?aDZZNGJqZ09iVkdPcXZsamx6SjBxRjYyT2Z5YmwzNUk4M2hnQVF4U2V0NElI?=
 =?utf-8?B?VUZwZlE4L2dIVlNtU1J3blB0Y0RLSkdSVmhJQ2c3blZoTlFOdE1EYWRsU0Rk?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77969893-8088-441f-3998-08dbfb145bd3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:15:06.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EdJbdhyeXV/RyyX3nDwJpDdFd5eXyhSYqNSxfZqEGKAdaLRKUkB2d/JubG0FlpQNWAzA96+8cpKhIZvdFqhJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6605

On 12.12.23 13:13, Florian Bezdeka wrote:
> On Tue, 2023-12-12 at 11:47 +0100, Jan Kiszka wrote:
>> On 12.12.23 11:01, Florian Bezdeka wrote:
>>> The following smokey test failure was seen on the current next branch:
>>>
>>>  [1] at task-4.c:22
>>>     0\"011.394| BUG in __traceobj_assert_failed(): [TASK] trace assertion failed:
>>>                task-4.c:36 => \"ret == 0 && regval == 0xdeadbeef\"
>>>  test psostests_task4 failed: 256
>>>
>>> The problem was introduced in
>>> 8dceca122dbb ("lib/psos/task.c: fix build with gcc >= 12 and -Ofast"),
>>> the second parameter of get_psos_task() was unconditionally initialized
>>> with ERR_OBJDEL. Even if no error occurred later on, an error was
>>> reported.
>>>
>>> All users of get_psos_task() and get_psos_task_or_self() have to
>>> initialize the second parameter when the care about the returned error
>>> code afterwards. The value of the parameter will only be overwritten in
>>> case of an error.
>>>
>>> Fixes: 8dceca122dbb ("lib/psos/task.c: fix build with gcc >= 12 and -Ofast")
>>> CC: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  lib/psos/task.c | 9 ++++-----
>>>  lib/psos/tm.c   | 2 +-
>>>  2 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/lib/psos/task.c b/lib/psos/task.c
>>> index 5341289df..70b5c6596 100644
>>> --- a/lib/psos/task.c
>>> +++ b/lib/psos/task.c
>>> @@ -96,7 +96,6 @@ static struct psos_task *find_psos_task_or_self(u_long tid, int *err_r)
>>>  
>>>  struct psos_task *get_psos_task(u_long tid, int *err_r)
>>>  {
>>> -	*err_r = ERR_OBJDEL;
>>
>> This re-introduces the bug that the previous commit was (also) trying to
>> fix: We do not set *err_t when
>>
>> task == NULL || threadobj_lock(&task->thobj) == -EINVAL
> 
> Nope, I don't think so. The caller already does the initialization
> (now). *err_t is only over-written in case an error occurred. That is
> where the "might be uninitialized" error came from.
> 
> We have to look at get_psos_task() and get_psos_task_or_self()
> together. I think it's wrong to do the initialization inside
> get_psos_task().

I don't see why get_psos_task() should set *err_r when
threadobj_get_magic fails but not when that condition above.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

