Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B33546F5
	for <xenomai@lists.linux.dev>; Tue, 23 Jun 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202753; cv=fail; b=s3+T8BYtAsYCEbLRLALxT1EiQNxxX5tbmzoJHctfGYQt7WQAgucS4XEjXol5Mp6QHoeSFy+tfdLsSU5YdOFh4Dbf/AqWx/lNuzMweEW4np19v9HlhSu5u8zl7vlQ0SPMHiryGK0G9bAJDDGsFVLT9oP7S1iTHIONumFmlSEl964=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202753; c=relaxed/simple;
	bh=tHWW1eEEjK7oLr0LoDZvbhVkN0tBYyXiwoJmDLKdJ4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VZdIosZQzGgNqYUrLVzf+HQUCDvgoGnpQFukDSVICmf4bSD0UyJQ318zQnyNX+1U+HvjrJK+zDKEcgMpR3LTCFl1PMo5p74ZXSNM4YQtaPNtPB8YSZXXjtIR+LfrUfDVIXhLYlSSHnXqlLk52zbsKMrQ3DD6ZIi40MWkZTm8eC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=S+p62xnm; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="S+p62xnm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2jFiUVSUeSeAs2XxQIChjsJM4GA/aopknyRI7SG4LzIMnbZW2KDeuBmAg2wBJCZL5Gc0SP7L22I5hPLs3g/kf+SFrJer0XfWS1D3E+JK9kswxO0unBTvMV2lacHONVgWse00GBFaaj3Z8ES2tH0EQ1S8TS9T8zc8kag+qoTd+4l8yh4SA1svgJ2M5HV4za/N2hDzNayXBpFDOiw0uMiVQNaH11lz1baJOM4+AvbZ3BVzji2wPPSXfdXlSYiLWkPD6Mlp66bYoXnkV1qM8EW9B3tXWHfPY7KcLE0WjHb1pB40ue4Vtr+3JkYNGP0iRsjjM46A9xPJM7JRp0orTF4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVUSV2gL+iUvlqBK/W2NBkGFCIPbcN3lfRHSk1O8qaA=;
 b=qBrTvLp/u6Wu5SXJ8hoxzyGF1c3M1cVUp1LH7h6HJE2no0YthpqMV3buL/uE82DWPrVCzowCdFn13C4QbWTDdXhg/ywAk4Rt20pGtaSEjmH3Ufwk2xExSaLuvY9leBzXvft6k7EiCelm2Px1hUb36rcrfgq/jXHcx5ZeaexPkVFZvVLVt6wKVqPjodph6oJ3bqRCZXQRQDokCnR/v1DrcFK1EfQQqKOlZGxJKve4ZMtaLKWOxUQPz+XHCSnxJ9DqBYKfIKmgECJaAxvtun1BpVp4iIXqjbpGycnH1fV2zJmY6TIPgShoS+28F9dQAk8NKPehdv1IhvO45+Yc2Mu2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVUSV2gL+iUvlqBK/W2NBkGFCIPbcN3lfRHSk1O8qaA=;
 b=S+p62xnmEtebGHmOUzhAXCkvEeEZLN2R6XT6BO6ORQKnsBAtYnXY+6QTBE8G6XPvwS/aAsoQm+VrNMUaAeS9FJe64KIsDfd1LLS6oNfC2p9Rz5zxaWOsgmpkzCu4QgxvV1c5hDkdCU4U4L0Ny8rWUddUfltzesNS+ewOXa9dgwnBAJOqJOk2DQ7lT3xYtvmDMJoBVADDlcAXJOl+2OuEqAIgfl+GbRVbN3KzUlTao9mLfDyUyzwbq91XzAWv+aDDesHiYgEfSeqX/Ky2ry+khomXDatiRZBuTXcJ8Vu3DtXnAEeg0pO/LiC0VwBTxCuwTBn2uPvyJcXAebh7daKKFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI1PR10MB3309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:19:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:19:07 +0000
Message-ID: <8bf3ced8-42da-470e-88e9-c1b3e0a0247c@siemens.com>
Date: Tue, 23 Jun 2026 10:18:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: EVL 7.1 and below on armhf: System hang when running the
 testsuite under stress
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
References: <32c49c1fb7fa18b0cbb206198b67bc6cf0c7452b.camel@siemens.com>
 <87v7bbdj7d.fsf@xenomai.org>
 <ac2a054ac1e75c91efcde7f68821f4150f8d200a.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <ac2a054ac1e75c91efcde7f68821f4150f8d200a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI1PR10MB3309:EE_
X-MS-Office365-Filtering-Correlation-Id: 253294d7-3151-44d6-801c-08ded1001881
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|55112099003|11063799006|3023799007|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GfkueWZ8KDH1pYJL67mXql6wOCilAP54zwZABJy59cGwI6f3RX+nQIQnlDNhfBpJ+B+eBMRii8HAvGuojEFL0BzgGrE/X9xMTRPR3W4y3HqATFjlIyYnFViGbP1UJGDxOdDjmtUVW7dJAdfETWG5ZfZx4Ru0ukRXWy2j38PzJTLSSczw/Okpb9JVQj9JgbuhRKxGmuccKE1RmIlFEfEVVqJhn69OtINNuR4XzxCiEI4NTo1PZa5X0cIcyl2bm4hEP8oooDiic4jgi8Qu8Z3kBYwTgvMAnmMc9SA6nkbeKTbLb90hdXN55H/F73r1U3A7f8vzLPXv0rKGKkNS3EjtY2Vp8XRgfe9ihZYJUPR5jjZrsqN70lcczajqblCVSBb46TBYQXnJM/ZNM7OVa253t28/EBbWq4DnGc11HG2MVCVoZ6cD+O9w2+wTX62UX9xuLrWzH14yOiel89KcUAFalvcB79I/fNLF4oRpbhHdn23rtYTtaJJVcUJnF0nZv0DMxN2p5LjCcdteLlDfkEbyGP2bDEfCT+NY8xiEDUp1MHfe2CKIuRaRceE4UWOd65iUgI1zkwAFi+/6W+40LGD9hDpsrfjHO294zxhW9rU8BLCV8f5p057fJOwXz+wWvXpmixbi+gXBUIZx3AaQLeoS2qvC2ST0TaqxcwHWxtyHEzk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(55112099003)(11063799006)(3023799007)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVlsM2pOUC9xc0VkMWltYk5YNTJuZnc4QUVNNU95bEdJMWxoTHN4L215OU5q?=
 =?utf-8?B?T0VINUtjSnF2eDNRamJ0eExrbHFzN0QwUVpCdGRyK2dKL1hXRFFBdENsb2FP?=
 =?utf-8?B?YTY1eXdFckQ5bnMxRkdqWVlXOWJ2TkFXVHBRaGs5NDN6VFJpYWVjS2JOdG03?=
 =?utf-8?B?UUUzN2NxVmxYRHJ5aVNIVHFOVVJDMzgzT0FDdUk4cmUwZ3V6dGNyc3VqSVJq?=
 =?utf-8?B?anNjOTlzb0ZxRHlEdGVPSVFWRnF4ay9wMDd2Q0I1QkIzL204UThHTUdSb0hJ?=
 =?utf-8?B?aEcwdjJGZ0hmNlY0TU95LzJDOGlYNUVvR1RYMTVGTFNZN3EwSk02WCtIR1lT?=
 =?utf-8?B?dFllOVBJUW5GUE5rM3Rtc3F0Q2F4bUtOeHkrMmJpY2dad2RMejdKVzB4UXpV?=
 =?utf-8?B?Z1Y0M0VBMXZaZm15dXJ0Q044Qm1GLzdJcXRjcDlabDJEa3l5eERqRk1HY3Ra?=
 =?utf-8?B?dUdFNnp5ZXVFQWEvbnF2UDZiNmNBZVJnVmVkczNRNUF6bFE0NFh3VzZCQlBk?=
 =?utf-8?B?c05CY2tOQy9LUGxyOEVaZlhQNjBjaW1FV21zQ3NQZFFFZzVBVjk1QW41Qi96?=
 =?utf-8?B?TDR4ODFKK0xqT1M0SEpVZkNYTGdvSnFEZ3JZUTJsVWVVaWk0SWNDS3N4ZHNa?=
 =?utf-8?B?RUowTWJKblh1ZmtPbVJoSEFXUVA3K2NBWTdVQ2E1SU1sVFN5RDlTdFRTTEZZ?=
 =?utf-8?B?aUVNNVFXNzYzZmdaWTJBTVdzNUhIS0puMHUvSm5HcExFU2FTWVhjZVhhTUR1?=
 =?utf-8?B?K1J2d1ZYNm1rYnU5c2dIaTVPTnBrUkZaMmJDL1R1blFpYm5pNTByR1NIVzNY?=
 =?utf-8?B?VWQ3dTV6MjQ1UkloRk9RdGpoYkh3T0ZMZDkybjVObjRXUG90dU44Tk16ZldY?=
 =?utf-8?B?eVNmck1MeVd1Vjl3ZVJwRThPNDNrQ09mTXMxVDVVZE1waFRvL0FIODF3YXFC?=
 =?utf-8?B?aHpOWExMazBzNnNNekM5ZGU5ZXFvajB3TE5zVm1hbXJjakdVSURDOTVka1Y5?=
 =?utf-8?B?M2dRYnN5bFdGaGRwdDZucElUSkdXdXlBM3RjZ3Iwb0hVK0RHTmRMeCt2dVVp?=
 =?utf-8?B?UGhSU2xGYU0yckkxVTk0dEM5N0EwZmlsVDNxaGxIS05PdVZKUkxJUnBIUWRp?=
 =?utf-8?B?TWJ6QzVPVmJkQlRvMXFsS2tmQzZOOTk4VHRBMHpRSFY2RkNmZVhXSFJ2SFNZ?=
 =?utf-8?B?d0dwb1h5TllnTUIwb1dzNU14TmtMMElyWENtTG1QY1hIZFBBSkxoUDY4Z2NX?=
 =?utf-8?B?UE9kUXR6U21DaXZXUEtYb1V4R0FiazZwd1pEc2Q4REdXN1Z5d3NrSHQ4MzBw?=
 =?utf-8?B?bHN2ODRtOUtCSmxOQ0huMVQ3cjFTQ25pTmtTRnAvZHF0NTcvL2ZwMlBpWW9J?=
 =?utf-8?B?WjRoMm9wVVdqeWN4MWg0SUFSVTJLK2JkYzhmaENpMXd0a0hucDgwR0wzRG5T?=
 =?utf-8?B?bU5NZ0Jod2cwd3JRc040K09jM01MUmhDSmd6c09ENEx5UFdSd2g1VjlJWEZH?=
 =?utf-8?B?djZBbENGWEQ4b3p4U3R0QVExczQxTTBMeXY0ejQybktOc2NqTWk3NC9sRWlx?=
 =?utf-8?B?ZE5ia0NrSkhFQUtMdE9aR2VDL3p1Q2VpT1FyR1oyZEk1R3FYWWM2WUszenRC?=
 =?utf-8?B?bnZUTVViSlF3MkpXV1FQWS85TGp1MDhYWjVZUkkwdEZKWTJuK0QydUE0S1cz?=
 =?utf-8?B?a0tVU1VPNnZxOFcwdHpDMlMycENpanJlZ0RML2o1Mjd3c2cvSWFmeldSS1NW?=
 =?utf-8?B?Y3FOaWFhZ3U4WE9odHE4UUFJd2hnOWV4Um0rdUhldFVONnkweDRkYzRiZWlj?=
 =?utf-8?B?R2oxWHZ6S2FzQnJJcUlDb3hsRXJrTXVZWkd6ZjZuVkFNQ3ZJczVrV2xnRGdo?=
 =?utf-8?B?eHB4dzFkOVRZdnNjMGpCRWNvNlFtMWRYTjF0eElHYytsUXZlOGR1MWxkT3ds?=
 =?utf-8?B?clJjZXlzMHB6cTFYbnFxekVvSWFBbXE3NU9vK0hzZ1NXRHd0U2FadFlwSlcx?=
 =?utf-8?B?ZWRiMjU1Y2tIOGpSekYxQnZaVXZXTGEwTG1UdmliZks3NXlwTkNMZUp6TVpG?=
 =?utf-8?B?QnoxZTBIUVk2dFhReDdnVDBvWWlLVGJOQ244VlR1bk14cS8wSHhHSWFlUWdl?=
 =?utf-8?B?K2twOS8wUUQzMEpVOVRNSmJYcFdQTlFNbmVJbG45Ym8vamhUZXNFUXBHV283?=
 =?utf-8?B?NXVwL3RDNm1OaEp6UG9HMHRJL3FvZExJR09uV0FocFk4eFZMMlM1VS9yWjFr?=
 =?utf-8?B?SHEwZUdydnNiWXFxVmxFM05YWGU5MnpJNldmWUtmWnBVdUFsZmxPSmlqb3ZT?=
 =?utf-8?B?RlNBWk81eGh0YXRpZURZSU5hKzZiOGJ4MjExdjNZbzVaV09RWTJoUDZoTEdQ?=
 =?utf-8?Q?CWB+KVUIcIkdIl/c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253294d7-3151-44d6-801c-08ded1001881
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:19:07.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFQsK0K/oKffnQJC6r6zD9qXixwVwTP7Ur7pHS5IlvRZOOrsC9taTMy5/a/xJbEMpIAfhEs2Vi3vMmyOqQ7P1dsSQYEoJGq5z1lme2y8Mz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3309

On 6/23/26 00:30, Florian Bezdeka wrote:
> On Mon, 2026-06-22 at 11:21 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>> <snip>
>>
>>> sem-wait: OK
>>> simple-clone: OK
>>> [ No futher output, seems we are stuck in stax-lock test]
>>> [ It's always within this test ]
>>>
>>> I was able to fetch the following rcu warning from the serial console
>>> via gdb/lx-dmesg. Wasn't that helpful for me, but maybe it rings a bell.
>>>
>>> [   57.488273] EVL: fault:1957 switching in-band [pid=1957, excpt=0, __copy_to_user_std+0x74/0x374]
>>> [   57.489105] EVL: fault:1957 resuming out-of-band [pid=1957, excpt=0, __copy_to_user_std+0x360/0x374]
>>> [   57.489398] EVL: fault:1957 switching in-band [pid=1957, excpt=0, user_pc=0x4707ea]
>>> [   86.772645] EVL: fault:4193 switching in-band [pid=4193, excpt=0, __copy_to_user_std+0x74/0x374]
>>> [   86.772942] EVL: fault:4193 resuming out-of-band [pid=4193, excpt=0, __copy_to_user_std+0x360/0x374]
>>> [   86.773029] EVL: fault:4193 switching in-band [pid=4193, excpt=0, user_pc=0x4507ea]
>>> [  177.579348] EVL: watchdog triggered on CPU0 -- runaway thread 'post-many-flags:10780.9' signaled
>>> [  374.037157] EVL: fault:25707 switching in-band [pid=25707, excpt=0, __copy_to_user_std+0x74/0x374]
>>> [  374.037582] EVL: fault:25707 resuming out-of-band [pid=25707, excpt=0, __copy_to_user_std+0x360/0x374]
>>> [  374.037705] EVL: fault:25707 switching in-band [pid=25707, excpt=0, user_pc=0x4507ea]
>>> [  493.107954] EVL: watchdog triggered on CPU0 -- runaway thread 'post-many-flags:2062.4' signaled
>>> [  599.153154] EVL: fault:9187 switching in-band [pid=9187, excpt=0, __copy_to_user_std+0x74/0x374]
>>> [  599.153624] EVL: fault:9187 resuming out-of-band [pid=9187, excpt=0, __copy_to_user_std+0x360/0x374]
>>> [  599.153725] EVL: fault:9187 switching in-band [pid=9187, excpt=0, user_pc=0x4007ea]
>>> [  627.334572] EVL: fault:11456 switching in-band [pid=11456, excpt=0, __copy_to_user_std+0x74/0x374]
>>> [  627.335530] EVL: fault:11456 resuming out-of-band [pid=11456, excpt=0, __copy_to_user_std+0x360/0x374]
>>> [  627.335752] EVL: fault:11456 switching in-band [pid=11456, excpt=0, user_pc=0x4907ea]
>>> [  730.251556] EVL: watchdog triggered on CPU0 -- runaway thread 'post-many-flags:18782.6' signaled
>>> [  747.230444] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>> [  747.231393] rcu: 	(detected by 1, t=2102 jiffies, g=103469, q=1205 ncpus=4)
>>> [  747.231467] rcu: All QSes seen, last rcu_sched kthread activity 2100 (44723-42623), jiffies_till_next_fqs=1, root ->qsmask 0x0
>>> [  747.231599] rcu: rcu_sched kthread starved for 2100 jiffies! g103469 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>>> [  747.231628] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
>>> [  747.231642] rcu: RCU grace-period kthread stack dump:
>>> [  747.231701] task:rcu_sched       state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000000
>>> [  747.232543] Call trace:
>>> [  747.233011]  __schedule from schedule+0x20/0x130
>>> [  747.233751]  schedule from schedule_timeout+0x84/0xf4
>>> [  747.233784]  schedule_timeout from rcu_gp_fqs_loop+0xe8/0x450
>>> [  747.233807]  rcu_gp_fqs_loop from rcu_gp_kthread+0xf0/0x110
>>> [  747.233871]  rcu_gp_kthread from kthread+0xe8/0x10c
>>> [  747.233901]  kthread from ret_from_fork+0x14/0x30
>>> [  747.233957] Exception stack(0xf0879fb0 to 0xf0879ff8)
>>> [  747.234087] 9fa0:                                     00000000 00000000 00000000 00000000
>>> [  747.234108] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [  747.234122] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>> [  747.234251] rcu: Stack dump where RCU GP kthread last ran:
>>> [  747.234387] Sending NMI from CPU 1 to CPUs 0:
>>> [  747.234579] Spurious and unmasked percpu IRQ23 on CPU0
>>
>> Hard to say at the moment whether the pressure imposed on the
>> virtualized system by the test is responsible for this hang, or the
>> inter-stage synchronization in the core has issues. Any change with this
>> patch in?
>>
>> diff --git a/tests/stax-lock.c b/tests/stax-lock.c
>> index 51576d9..87511ef 100644
>> --- a/tests/stax-lock.c
>> +++ b/tests/stax-lock.c
>> @@ -66,18 +66,17 @@ static void *test_thread(void *arg)
>>   	me = 1 << serial;
>>   
>>   	oob = !!(serial & 1);
>> +	delay = running_on_vm() ? 1000000 : 100000;
>>   	if (oob) {
>>   		__Tcall_assert(tfd, evl_attach_self("stax.%ld:%d",
>>   					serial / 2, getpid()));
>>   		do_ioctl = oob_ioctl;
>>   		do_usleep = evl_usleep;
>> -		delay = 100000;
>>   		/* Any in-band presence is invalid. */
>>   		invalid = 0x55555555;
>>   	} else {
>>   		do_ioctl = ioctl;
>>   		do_usleep = usleep;
>> -		delay = 100000;
>>   		/* Any oob presence is invalid. */
>>   		invalid = 0xAAAAAAAA;
>>   	}
> 
> Yep, that helps.
> 
>>
>> Clearly, an improvement would not rule out some issue in the
>> implementation of the stax mechanism, but this might give us a valuable
>> hint anyway.
>>
>>>
>>> This problem is unrelated to the arm pipelining cleanup series. I'm
>>> going to post v3 now.
>>>
>>> Another finding triggered by some analysis is that we disable a couple
>>> of tests in CI. There are two tests failing often in this arm qemu
>>> setup:
>>>     - clock-timer-periodic
>>>     - sched-tp-accuracy
>>>
>>> The timer test is especially failing when there is some load on the
>>> host.
>>
>> Since r58, we have the running_on_vm() predicate available to test code,
>> which checks whether the "EVL_ON_VM" environment variable is set to
>> 1/y/yes/Y/YES (unfortunately, I'm not aware of any way to detect this
>> without user input like the valgrind vm allows via some hypercall).
> 
> systemd-detect-virt implements a couple of mechanisms to detect a lot of
> different hypervisors. Could we depend on it?
> 
>>
>> sched-tp-accuracy, sched-tp-overrun, and monitor-event-untrack have been
>> fixed up accordingly not to trigger false positive on vm.
> 
> Nice.
> 
> Tobias, any plans to clean that up in the CI setup?

Great!
Yes I will send a patch.

>>
>>>
>>> Now the question - mainly in the direction of Tobias:
>>> Why are the other tests disabled in CI? Namely:
>>>     - sched-quota-accuracy
>>>     - sched-tp-accuracy
>>>     - sched-tp-overrun
>>>     - monitor-event-untrack
>>>
>>> Shouldn't we better fix the tests than simply disable them? Haven't seen
>>> any failures on arm64. x86 pending.
>>>
>>
>> Yes, it would be better to fix them specifically for vm context, even if
>> that means disabling some checks based on timing accuracy.
>>
>> --
>> Philippe.

