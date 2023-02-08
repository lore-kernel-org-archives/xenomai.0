Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090B944E
	for <xenomai@lists.linux.dev>; Wed,  8 Feb 2023 08:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1mi0zv66dxFX9bYbcdebPgF+p9vGLOF2q/oyYxKkkYoZ5pIK/Ajn/Gvr4GnnORvX+tBcsWfNc+8BcqbI3uDgbiSqxhJkaJW2FbMitKyaDAvSbBP7A6jBZ3VolWastKwh6lHwuW/wZwFamRQzcCLcXxrGe7E6qSIayfLBPzJ1RwEb0e55KETCgzN8+ogmrjFy9UoLXjBjfLt7Tmwbv1MI2KRwXxjgeToAdGjYaz0skL12geGT9rjX/1T2eIDQX9/gYMCY7agsn+SskLDeovHFFhA9GsjsmnowGEIX9kQl+gDihe65lKWgCaFUO9VOreU3LieVFldrSsO5tm5MaIekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OghfMhDfcqoj9YsQSDkYLF8UCSGf1t+HVFe5KSIlPRI=;
 b=GGVMyKEp5n+SfnrT9E24ULbeYZH7J2iogZECSLajpXRJgTnUfxAcy9QjiqOtr+jQV7xL/3mShXs66sS/N764eVwgBJISUR36hz0Gb3BfpmZxvb//lMJsAXAkvLnHKfNMEji9/a1DR2P+BAkYVn0+lXty7XwT+8rxoJc/UGfBQlyjYdcwpf00TzR0wA3edCWyBOgz1S1wqAt4RIzpvyVwc4Ocadyo+grpOuDvdcZMXQL2DdNYlEV/L8+OHYcGDLcM1+bQZtA3aD5lp1/jQWW+lS84egcTEVzk5JS/znCuhDui7/X9gljSUVmVQg0wrpsNV8TynQoBflNtOnoiu96BnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OghfMhDfcqoj9YsQSDkYLF8UCSGf1t+HVFe5KSIlPRI=;
 b=DqCFL1gYEetZsz+86UgV/QjskaLDP+8O41Qdm8wokCYX0uHIG+BsAAQMslVjVADmN5oNMPXp7xUO143rLDPLB/r//ejQ7VjaJlMGque6XgAH3tm2nqadQ6Kz01BDAiwjwlNksDdpz/ftQcGziaTvj1tVXfjFfdjDK9v550yjrue10YwVNts2yOv6/z+QzaAQGxm8KcthOfT/k+jT8A0/YG6NAJHeM+LNH0q9r+3Jx5rNZB95QAqE1n4zCjEtpYlSX4RrRVE1ZVE9gk0YH8aBdrzZgWAwJM4uHRFYCKXyK3RQ0eIqAztNPeswqVmrpAL2+2KpQGuJ2b/XAV5WyBmjbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 08:21:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 08:21:58 +0000
Message-ID: <b953b20d-f866-5bec-faf3-f8560354bf59@siemens.com>
Date: Wed, 8 Feb 2023 09:21:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: undefined reference to `fuse_main_real_compat25' when build with
 --enable-registry
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Mauro S."
 <mau.salvi@yahoo.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <fc2f8e65-dce5-452d-3789-70ebc838abf2.ref@yahoo.com>
 <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
 <MN2PR11MB4285DF9642B16AE3F170431FF2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285DF9642B16AE3F170431FF2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:4e::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: e01ae8b9-b39e-4ca4-a8e8-08db09ad8b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W9hGvYyiLDi9Pv3RxaRnTL3t0EuZxKWFVORb2NUGKYawTD2y5VAcW0dOCaDaQTFvLWmPvRNVD1a8Ylucp5/h9sWy0bLsWDojd8kwRIapdFO0gQYfoX/OPygHgT6YZOWbmKrApF/0RE4TWkn3iLXXSk0pZsSQ0U9TZjL19NHDKZNfXEY9N1lcys2mLO3bdILnz1PGjpbNGonnMo0zMXHTbUSTIVggvRHPCtjRqw1SWNRF5jDcF3IN0gGtF4CTTcxl7bf+SJ6gJZ2IqsGyWJPxd949ib8J9aLsNm23p+WkmYEJlR16dlh0SnA4DeBQphQhsHrlZhqz8SeXBzOVXhbsUNhFrceM5NX8SsV2B0jAoP6+lwGkfLC3ClXWU+sDGdy91xbH5PvK/vChKOGi2FrgW2ABV2sGPDlFDly3mEhzPMGeqhcesMCLoBlFYbvA0BfW71mT6Ek6ArYaNnr5pZZIV65n9ORvhNLtir2vZieG8NDdRp+WXb8hwgDs9+uVofupEr344cnCsmTfwYQzrDEghna5NxQU2h0Sw74M+jW7nkX2mqSvpsRltg6Onoz36GzIbKjViwiJkh/C0yCvHjit5yiDJpgIwouvRp2ycDORQNmhPuFlOjtJVzu9e4A+/HkuNCWvVpsejaerXG9sskGY/NXpQi0UHRgSwZwH7/hEn88PwL83LkdtmuwcF29qLnTPesjOY+4BRgHOtYqNGcauuzJNRn8Hgt5eS9648DEjrl45dy6lYKh/Jjj/8TY09Epa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199018)(66946007)(316002)(83380400001)(66556008)(66476007)(5660300002)(8936002)(110136005)(41300700001)(8676002)(6666004)(478600001)(6506007)(6512007)(53546011)(186003)(26005)(2616005)(6486002)(36756003)(31696002)(86362001)(38100700002)(2906002)(44832011)(82960400001)(31686004)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVXMTZLdHJlNWIwTHQrTWRIWGVTRFJjYU5mc1hvbTJ0MEVEMWxhSWZGUURv?=
 =?utf-8?B?OHM3MXpNdEdFd2lRRUZObVB6cW5NbVRBcWhTVTBwM0QvM3hhYzE3RkZyQ3V3?=
 =?utf-8?B?eGF4SElmZjdpQTg3MUNJb1Zka2lwRllNeWVFM3hTYzJWOGxUaE1sTmx6T2dG?=
 =?utf-8?B?NjYvd2dnenpwZ2VZWDh6d3ZNWC9peERvSjloQ0dLdmVzcFhGQk5Pd0w5ajhM?=
 =?utf-8?B?Z2xwMU1yeFUrZURrd0UyMkc0T2ZpSzM2WGhNVUZhd1Z5OGNuTEhCSnA4M25B?=
 =?utf-8?B?SzhCM3VWUk5LSG82azAwN1NaNkpHU01YRE1yRGdNdW9IWVl5ZTRCWFkyNWRn?=
 =?utf-8?B?U0RXaS9qRm03WFgya2dmYk03VzlRK2dVY0t4dEFZdEh3cG14SEs0ejNMcjJa?=
 =?utf-8?B?ZHBERFZlaVYwcEtiU0drY0liTHhsZGhVN1dYN3BEeC9rUG1QaVdaejJPOC9I?=
 =?utf-8?B?SWJETFVCNGNWWXlHVW80eStVSllKSFl6dE5ucnEwY0NPanNBYUVqM3Y0NWxn?=
 =?utf-8?B?RE1IVnR2MHhHMmpkL2tUemd3b0ZHS0N6SS9wY2w1SFRYTElWekZCVlV5d040?=
 =?utf-8?B?RjEvZlc1dDl5RW1kSTR6RWdOcG03TUIveHhULzBSbnlsNzdvTE1CVk1wSUdy?=
 =?utf-8?B?c2oybm0vQXBua2oyTEY2ZlA1Z2F2Z0luMldUZmppb25rQ1JOOS9FZWhyTVV2?=
 =?utf-8?B?cnZkbTBtTUZzSEc2NlN3alZtS1JLczJFMmttMEJQYk05S3ArVENadnMzdXdM?=
 =?utf-8?B?dzM3TGtHZld2RWxhb0ppN3NIbUtYcGo4N3N2aFhhQlViY1hBTHFGaExaYm1M?=
 =?utf-8?B?NEVWSE5zM0RsZTQyeUZwSEc4eTFhQmN3RXdDNjIvWnFaakRQVnpvT0lHcnly?=
 =?utf-8?B?Q3NpbkxKUTJpMjFGK2JMbFVmZFc5eWJ5TDNlZUVOVHZNSytQMGlYbWFZeWhu?=
 =?utf-8?B?ZEFDclNseFVDd1dlZjMrcithcGs0RDB0QlkxNWtMODQzbVF2eTFGYWZ6ZTB2?=
 =?utf-8?B?dlR6RWVOYU9GOXFGNkkyZGc4N2hRUWpDczVwSm5jRXgyQmFSK2VSRlVFN2xi?=
 =?utf-8?B?WGRYbUYxMWF0QjdZd1AxQ0Z0WEFjcjBSZHNJcU1JQmtNUWlaRDc1eFBZdU9F?=
 =?utf-8?B?dDdwMGp0akQ4bEszS0VyY1JMZW5VeTJGektKQ1NGUnNLQk5lS2lRYkwwWWlF?=
 =?utf-8?B?U0l3SGNMQnJBMDdpRUp3OHQ0VEpJTUovVE1ZRWRHRWVRNFk5SkRtSkJuR3Jr?=
 =?utf-8?B?cXBZZlJ3bjRIbjl6c0xDdWtxQ2lPTnJmRkwzSjBrc05YUElyTFpvUHRFb01L?=
 =?utf-8?B?OUhQWHVmbGlqTVFjUXA4Tks4Z3I3WXlJc25DMnRWRzdySXVQYTZpY2RUaCtR?=
 =?utf-8?B?R1BzbW1rOGlFNU1XUVRiOFJDNWZvTkR0SWp3TVhUUkhmVFZvenlGOVZEdjJj?=
 =?utf-8?B?VVdON21nOHFGMzdWelVkbFVqdTR0VTRLbXprZUtaRWhqcTlTMTlkc1hrQlRR?=
 =?utf-8?B?UTU5T1VlaFdGSStuQnpjVXB4MTRYMVV3K2l4WVd4NW8vUTFtN2pQaGFoQUps?=
 =?utf-8?B?enJDWlplaUoyK0FaUXBkQzBlaE1lU25kUmdubTFIMUtzbzd2YkFrQkYvOS9P?=
 =?utf-8?B?UlBORVNZMDlGN2FSNDQ3YnFwZWNNeTZvc3MxVEhGR1hjVVJtZmoxS3RoT1dz?=
 =?utf-8?B?NlM4L2FwdlRyMU50aXpMczVVNEFDTUdRdWdYVnA2aFNnaUpkbjAxdVN6bE5h?=
 =?utf-8?B?bEZmZThqZFVUR2lGQm9hTDVtNVEwdUZGd3NjeCt3d0JKMC9HUHJQbUg0N2Fy?=
 =?utf-8?B?Vi91Y05HcWlOQlZGRVdyZVRWcUJ2RTJoYWI5V2x2bjdqU2hSa0dEWXNUNGpp?=
 =?utf-8?B?RERoQlhsbFpTeTZqazZTcHErQmh6NjlXS0JFNlU0Z3dEZXg2K3NIMnQzNWNx?=
 =?utf-8?B?QkVTeXo4NlZxUFkyV0NaUWZKdEJFUXJSeEFaeDBZZVlxdjYyV1FUT2pYWjhQ?=
 =?utf-8?B?amlQbGVlZkNINGU3bTBGZWo1Z3FZNnVRMW9iOVdySUxzSk5WeDd6T2k2czRV?=
 =?utf-8?B?WWhwUExnbXFWazN4NDdQSjNkV1Q2dEZ1YXc5RzRaenM3RHdXNVRCMldCVFV1?=
 =?utf-8?B?ZDBGVjg0b2JLVU5uYTE5RTZEbU1hc01aSG1CSm40MU51RWEyVWRvUU9ueDFv?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01ae8b9-b39e-4ca4-a8e8-08db09ad8b6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 08:21:57.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceJx+JmhOuEfUIF4HbcckI9JEVsqDpx4J7sMXcgsZlk4nEExEA8EBOpBIR9tfgE2RoOuhDV/fDAO772BuOlhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7701

On 08.02.23 03:27, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Mauro S. <mau.salvi@yahoo.com>
>> Sent: Tuesday, February 7, 2023 9:46 PM
>> To: xenomai@lists.linux.dev
>> Subject: undefined reference to `fuse_main_real_compat25' when build with -
>> -enable-registry
>>
>> Hi all,
>>
>> I'm bulding Xenomai 3.2.2 for x86_64.
>>
>> When I configure the library with --enable-registry, I get the error
>>
>>   ..
>>     CCLD     rtcanrecv
>>   libcopperplate.so: undefined reference to `fuse_main_real_compat25'
>>   collect2: error: ld returned 1 exit status
>>   ..
>>
>> libfuse-dev package is installed (the configure script finds fuse), and
>> it has the function fuse_main_real_compat25 exported
>>
>>   readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>> fuse_main_real_compat25
>>    318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>> fuse_main_real_compat25@@FUSE_2.6
> 
> I do not know if it might be related to fuse version. In configure.ac , it selects fuse version 25 but you are using 26?
> 
> if test x$use_registry = xy; then
>         PKG_CHECK_MODULES(FUSE, fuse)
>         FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>         AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>         AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
> Fi

That's a good hint. I vaguely recall similar issues when building
against a newer version and trying to run that against an older one on
the target.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

