Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D310EA
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 07:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeADOaBNK1bsEkTcTohAKpX6HQaic25G6iYEi4p8lE6uAfzZLj4ZnL+XTbYPsCvRBSwlNE+IJqkgDWdIIToX5XFbK4vHpz0Xa4INW/CgSQx4fR98KAJKDYgbjvsCxhkxe4euBiQIN+Wzy4uzF7oi3NvKKHjG0ng48T3vjWXj9pQ8Cv9ANY8ZskZ4vfId8xv0V5l7Xe3leBsrIAP6Zw/sjGOIJ/8Egk6WMaRZSMrGhcTICSJtBx0r6MM/KJm2ALK5eBMXCweH/ezBPy5nnbCVqdycp6ybrF02D+wyrRwsALPyW4TAgQlAvP8MZjaX3o6aZopdaZFfDHTCLX13pzVHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCJAByRddY+RzgWEUEgDEnrE8AAHcBkpPmqezXBnnDg=;
 b=Z6lO7xYO3DtqXX8ofA9hdvE8gGsONAXXPN7gOoFAjLKcr7LaOeZd1tunrv5z6dDe1PscvvUxRWoJJMhu+MBXV8+r5RSzDqag5KVx+0D5FK484xADcQoFP8VFQ+JL0Lb6sP7zac9WEv4aC7+zKGlDQdgD43TlclKwHzuAZF7H6OERsdIyAOb2uACPEtr/lpTP/OfYXnRLh1yB3NpnkwHvW+tfbOLUhBFw9ZJUYavnGzXISbFfu11ri5ijpVG2mu65Q8EIMIwJfI86DEAs/AM+m9huNwXh1nIH164eIsmGdSeYZIQ2mWVsriWtYsffPuJENJ3Bsxm1SV0vwVtJQY/sUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCJAByRddY+RzgWEUEgDEnrE8AAHcBkpPmqezXBnnDg=;
 b=TdGvrHCd3UijzB6QRJxUpARuQ41TqdmMoY2sWHwkcpWW5KPjJi7/0exFha3hnXGfVHSxCyy8r9AY87xYWGJ+xjhNbSmqUdq7sNBj4JHspKnXOOS3TTuu9uAsRrmtogN466UOFZxL7pY65ICyMV4nXlRjVmhldNxquVL1Puve8feVCMZ7740CCFMeQwib85lZu7iqRGfblHywjFUQusUqlLG8W+Z0BjFT/h1D9NzFoGFmx8nLQ+YSIC4AzMZXOYxSmUu3W13nUd+ksFhPRkRx0DT8Y1XX8aMeiTNlL0Y2O5b9pHxHbzH7r8hcEnteXA6f3oqw4E8MUULJhIwaazfCtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 07:36:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 07:36:46 +0000
Message-ID: <b64fff2d-5c51-4a1c-8d05-ff6bc8b6d7c3@siemens.com>
Date: Mon, 4 Sep 2023 09:36:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] scripts/Kconfig.frag: Switch to I-pipe only
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1693753497.git.jan.kiszka@siemens.com>
 <da4bec53d14a791516e7ef5104bb5e2dbaef7391.1693753497.git.jan.kiszka@siemens.com>
 <8afc5d76d9a514432026f560cf2c9f8015da07a0.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <8afc5d76d9a514432026f560cf2c9f8015da07a0.camel@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8127e712-58d1-4c67-2c42-08dbad19b16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ef+t44/ShOJdeWITRavMIUjzvCbY11ORfWljUkoGsojYDSne5FFTFHSLRknf49mgtMCKt2pSC7m9fBFsA2bKqhsE7Ipmx6yM4PDMMp4+BG/x+TcSVLm7TalkmxYqHfsxVXJoXIAA2Mg8O5VGWAD3wcNBfOdtWRh6njG56gvpoRVMPE8UbHSrzbVsuecFWpERf3x7Pcc+RQictJJRBVPnKTlaNDzNJRHGMfczl7bYB5j7Ev517WZY71FHAdMCS7sprQp/7Zt/s3Zbe7u8ZaTnlMrnvU9QSXv5kkwrSv27aCwenfNqOTcVSmGw/KojOverV9Yrj7ZLifxOZsHBSROOJMWFvCuR2GriqD1CF+cPzDgl7dD0tZT0XCaeR43rONXjZABY+IfQMDeuCq467uVinxfcBZ7kh7fy1Slpy/adtVbrg8zKpLEObot9pYX/6nukIi0qhKyBl+RuPGdMI8SL3XzJLaKM/uzqlgLi7FKZ7ThQLAGNhEWcnSaANuuIqAImsu8Q3MxabFxVhA95S1jgneDWz2U1fCmaT6Xw7D1m59RuvNvSQBKeIQKsCrjMQqsWwMqH5F0JQz8cKSPxDQ3kRrTk89LRo703VQ+JtXNvLal6ol2tWCfWT4qYX13aQ03Rkh6x6bA7LthcHc8V6a3COw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(41300700001)(6486002)(6506007)(53546011)(478600001)(82960400001)(38100700002)(83380400001)(2616005)(26005)(6512007)(66946007)(36756003)(2906002)(66556008)(66476007)(316002)(86362001)(31696002)(31686004)(5660300002)(44832011)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGJKdTRpcDFDSWdJdkV4anhjS3prR0RBMnE4MmZwK3Q0NC9MSW5IUTlOZjBS?=
 =?utf-8?B?Mjh0KzJQdmVPZ3lHdmIrbk93RTlta3Q2eGljeS9CRjA0enIvOEt1WUcrTS9G?=
 =?utf-8?B?U0dFVGVhbTU4RHRIbHBIdkdxbG9BNHRRVmNSdEtOL0VWSktNZWlya0pSci82?=
 =?utf-8?B?Q01rZjFVQ1FRRlNja3g2aUd3WUlpaU1tcVRMb0dvRzNMK0oyaHUwL0xqTzRI?=
 =?utf-8?B?cVlBWUlsUnYxOXZLL0RzVGVDSGZZYU5oSUpXZkg4MkJ5QlR6UHlkdERFcUM4?=
 =?utf-8?B?WWM0YlFMYmZDZ3hpSVNLWkZUY0lia284dHJnWkNUMjNycEEwOXJJZlRyeTdX?=
 =?utf-8?B?R0RNUlB0eHdjUVBlZUNpZ3dnVVV1ZVlEOU0wbEF0ejM4ZHd6TFhHcDdSbVBo?=
 =?utf-8?B?akY1SHBiWVZ4TUlib3MxSXFrbzFqNVlwN1FEU3dCU3RLY005UllteTJUb0tU?=
 =?utf-8?B?N3Q1WU0zZ1h6UC94NW4yd2gxQUxIa3A0WUJsbDhkOThTM3N2UGxYVENnU0tp?=
 =?utf-8?B?ZUNCM2VYdkFOUFNwdlc3cDIxVUdQaUJoSkt1QncvQ3FQU29rMWRLaUNFMzc2?=
 =?utf-8?B?L0U4dnZiWVFkaFFiUkdXem1SR3hOUEM2NVJpblpTNGlYeGdKREkxR3hscDlS?=
 =?utf-8?B?cFhlZWdyTEZFOWVvT1g0L3RuQ3J6NFkwOFRBV3JOUXVCQnNEanNGbkxqSFJs?=
 =?utf-8?B?RXpVTzMrK0ZZOUkrQVBJWHdGQ2Vma3h2L0lWSis1SlpVYjBPSURWaHdaVWlB?=
 =?utf-8?B?QmdxV1FDU25RUXpXc0VPY3J0NCtvZjRPWFgxRHljbnoreHNiazNOYzNSQ1BG?=
 =?utf-8?B?VC9TdTdtcEtMaGJ2U1Q2b3YvOUFDUDI0QUh2OENmaFc2cU5meDd2T0RQbDY2?=
 =?utf-8?B?bXBHdTU5c2pYamViWFhYbThZMGNZUThRcHRkbnNlQ21QaWdxK2ZLZ0Q4NzFj?=
 =?utf-8?B?M0prSDRJTVJTZTVSSTlEdzVFR28zZ1NkWVR5bG5kRHpjbWhSWE4vck1zQkh3?=
 =?utf-8?B?bnJLaGZRZGhIcngvdlVLamRqR2J2VmN0Qm1EZHoxK2VybXdHR2o4aHJ6MFo3?=
 =?utf-8?B?ZHJadnRrUnBzb0hCZWlWQklIRHpRNVlQMU1MY3U3d3ZteTNYcktFVmRsMk4w?=
 =?utf-8?B?QTVpb2xqamFHMGY2My9mcWRFNjh6TUlWQ1FKbFZhazFXMXJVWTh6N242OWg2?=
 =?utf-8?B?cXNkeFJGbCtJRGtTWUFkeHlPSjBTa2ZCWkZsL3ZoMDlKdkpPczFEbG9pVFJp?=
 =?utf-8?B?NC82MDhEVVRLN0NrdjdiN1dJN2hpQ1Fkb2FjMGlHUEtlY1pKMnVjT2xzZWYv?=
 =?utf-8?B?TmFnSkE3bEFWRzFxdk4xaWJTS3pndDFLbkxPTklWTWY3SUJyZU12Y1ZWOEVL?=
 =?utf-8?B?YVIwMzE1dG8wUWs5emRuR1M0NTltZDkzbjFlVzlzaGMvOFh5amxkSEt4dkJY?=
 =?utf-8?B?K1VvT1BLaXlWWFV2YVc1VG5wYVlKaUtPcVNkVUo3SWZrUWdWOHFPUHJMR0RN?=
 =?utf-8?B?SDlrRXUxZ0dMUitLV2E0aVAzSjhqQ2UxdDNicllBaWFQVHBRcFZpMUVLRStL?=
 =?utf-8?B?WG5LZVNwOUxxbFNhR2xrZlJZMlYvNGY5WHlaYmRmRkVRMVZyeWVFRTNjTlNo?=
 =?utf-8?B?YUY2Q2dINkJQZEgrbmh1NTQvcjNJb251Sk1SbFI4NDJlbUlHVzFXSjRvRHgw?=
 =?utf-8?B?Z01FREhEbFhBNHE5VjFUNVZHWXJ2bjR4S1pqdEtOVkR0bWNYcENFazVmSnVG?=
 =?utf-8?B?VjRLNzFzK21qODN2TFdQZzkzNFllVHpWOUMvSDBzZ0Zma25lam9NUm44TmNl?=
 =?utf-8?B?RnFTcUJ2UTR0cUpIak9SUHRYUFprNXlxYUFLTE1hUHZmaFpNa0xUMWRBckQ4?=
 =?utf-8?B?b09HQ2RSVkpuUXhuQ1pPTEZWVVJyU253SDdlTlRqcDlPc0pHYVhza3JwUDJy?=
 =?utf-8?B?MCs1dUVJRjBtMkJhWk1IMXlFZjY3NjV0ZlJSbi9lQW1FTmo5anZPWUMrVmhp?=
 =?utf-8?B?dm9LblVLTVhBdjNyQXpkVXl5VkhRekxUWXYwT1IyYXNaUC93alNVUEJTOGxW?=
 =?utf-8?B?WmIwS3J0R1J6dWIyM1RtOHFZTVhjTHhkU05JTWtPc2V3UHhqN0xjUU1mQnJo?=
 =?utf-8?B?eHlXcmU1dmUzZWdnRWZFalphOVJtUmMxZEhnSExlWEo2aWRaMDRwa1pieDFI?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8127e712-58d1-4c67-2c42-08dbad19b16b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 07:36:46.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0NAxNmtocXZRBB7Z8+NR1D0CXgkzxnuQguIw9RL19CV3RK6cDziLYKp9cwyZ4zbvZ1sk5y2uWDfqbeEkIha8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7382

On 04.09.23 09:13, Florian Bezdeka wrote:
> On Sun, 2023-09-03 at 17:04 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> I think the subject is wrong. It's dovetail only.
> 

Indeed.

Thanks,
Jan

>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  scripts/Kconfig.frag | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
>> index 7921286638..b76d25e535 100644
>> --- a/scripts/Kconfig.frag
>> +++ b/scripts/Kconfig.frag
>> @@ -1,10 +1,8 @@
>>  menuconfig XENOMAI
>>  	depends on X86_TSC || !X86
>>  	bool "Xenomai/cobalt"
>> -	select IPIPE if HAVE_IPIPE_SUPPORT
>> -	select IPIPE_WANT_APIREV_2 if IPIPE
>> -	select DOVETAIL if HAVE_DOVETAIL
>> -	select DOVETAIL_LEGACY_SYSCALL_RANGE if HAVE_DOVETAIL
>> +	select DOVETAIL
>> +	select DOVETAIL_LEGACY_SYSCALL_RANGE
>>  	default y
>>  	help
>>  	  Xenomai's Cobalt core is a real-time extension to the Linux
>> -- 
>> 2.35.3
>>
> 

-- 
Siemens AG, Technology
Linux Expert Center

