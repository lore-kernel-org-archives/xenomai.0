Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB43B187
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EXELg6i6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3O795Vxky5SYdP2uGizwThJZDCVylNavrIBrBzqpjwsodFmnk/IhjLCCFjqs2OixkV+2v6tSC5sgs9FScWykHkZ2l+LPymSEV6fFfPJ+0dh/pce1suSQu3GmXsbGe2UzrqF2pv2VNzNFcTqrAe6na8tjakkcAMVampSpJOkevK3i8ndfDs5EqIF68DoLyAUP6nq1Sv+75NsFUtPnSPMzXFRJ71yzIRRu4vWVjTeVjUrMb36GqIZk/zvINxkZGdRUi+YI6wYCEwT267aOl0dTr2bcL4rWF2Kye4/5Ch1guCrrlzHstty3akNKWH8t1L5jyQ1EOi6Ei/Sdp9v96p5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jlIbAhaACDkmgD4R4kj685/wfu7AMt66LZwSEzMpqY=;
 b=QqfjbwifS4JzKY7+dUn2o69GUCadlzKToG+GgKDJ9RQMh/SvjaM+DnfKKigfSYl/dmdjF3cUkifbuD9JWqjncn9YiJKBQ7ithlY6YXtFofw5i2/DC7iXsI3Jx5SEX/YJys26ilCuDVgurtLWYxGRwKP3KIAdfJCtE4m+U3dJgvgbKsQu2AL5ygvmd4wKA7qKyyAemc6MPgSLRp6/FlDdeakVqtvV3YHmEX/JqxNxM/qNF8dn+p39TmSy1ObYq13qTWul1/VsJLpcarPfEmWGNlb9FkcGMOIRNLE3m4Li6CUjeIPagDZ9NI5VnSwSZADG7kqJYcrBsmCfjOIM+jn5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jlIbAhaACDkmgD4R4kj685/wfu7AMt66LZwSEzMpqY=;
 b=EXELg6i6JhcwM8DQRvUWW1qgyCw5J3TYFU/z4yPCyHQdKnC6t+cbrelWoma+CPiShA0PkgIQvBpAS2em5TVPx849KLwzIyZgvfRCX0fawL9VpUOwWdj2LPkwjnd+iPN0t47Zjfc5UJPsQraCgT6EftJg6T6l7Y/sAJRR6P0BGlCfPX0/J8TRcPutAm+imuD0JlurtTC1JW2gh9lDQSL7TlUWoYNjJKRZ8ZNCs/YvufEARQ7LnSU+Epuh3aBkvMYzAsu/J35Houhr912RHAhfdGAZW/1mGXXrsI7Wa5GfYWm8KdOdMaBxV6BQdh6JFlzgAm39h5xcNFLYTwQ/U9b6bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB6676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:04:29 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 09:04:28 +0000
Message-ID: <ed317129-ae09-42a4-8e6c-60c776060c36@siemens.com>
Date: Wed, 10 Jan 2024 10:04:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 01/10] Add Isar patch to permit
 linux-libc-dev upgrades in the sbuild environment
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1704861962.git.jan.kiszka@siemens.com>
 <46b62659d3ca20a7ad418d44432e4359bd6d4a03.1704861962.git.jan.kiszka@siemens.com>
 <2cf2e60d9bd55ff637167704bb0e6c740f865559.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2cf2e60d9bd55ff637167704bb0e6c740f865559.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 2888d0b9-d872-4f7e-41a3-08dc11bb26b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tJLQmNYwSyFbHfsl4rVgEdD5CFu15dLCKs3b+EcCBepmjlBvmDVBt3SCrvbdSIWuQJEKjGHOmO+dfVKezPStts5SOsu28d1iex8EdewrbwdLJzNN8gxlMRAK1ebPRKIT4PN1IVCykPag4nniPOZ5+vfPAl4/12oPnFfaXKLNEMSXkVIfRX50J4ruGOBnEFcderctouEI2Bx5hbFEJ1avMxArlIIn9MvTzxggbRPZsmLtxUPtxD3kqjJ8CFp4wuWcFOKrKp/iilHCNL8pxBrq1eKNsRX7pPs1IsLg7rhr+5LOWICJ8RDYqPq3RdST35f8hmXY0i8p8BtDmayU+1GKCsNkzFqF2pNZvyog/GEdSIasDe8oC5tpU/6Jz4gYtGUJuIfUtCHil4Jm9j0fwW00p3dPZKkiy67HAt/nQ0+I7JTwG7L2UaNiLPxsU29f+VYXCZOYTfLt6GUq9861vI84eZ855hWY7Lm4UAzVEdyQiNIi/HtmrkYiXK7w7YcIdLW4YKbuiqmDw4nv5pbsxZQopyVaMRuy+Z9d15g1B7eSC8ybUViImjAMOvCeFnbMP4OnHS7tiS81nuMald/Ul94RiealSdGjP8ypAKqcKre8oS5KKDpSH+lIzsVEexj5PhGqAVW2WQ+zTfdg2MMb1exiqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4744005)(2906002)(2616005)(66476007)(66556008)(26005)(6486002)(66946007)(41300700001)(31686004)(86362001)(31696002)(36756003)(82960400001)(5660300002)(6506007)(83380400001)(6512007)(53546011)(44832011)(478600001)(966005)(8936002)(316002)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFMSk1jaVlMR1ZEQVV4RUpwdXdzZmNuNVBLZE1OUE1CSXBSVW1ieXI1UnRm?=
 =?utf-8?B?ZW1IWEh1SEtHVGpHWFF4b2o4OXVMOENyQWlEc0kxckluZDBkSFpTVUpWOEZ2?=
 =?utf-8?B?eitUWittbmJNNHFQVEpMMDVidGtPWlViNTJ1b2RiV1R0dXRqU051TjF5eDNG?=
 =?utf-8?B?S0tLNEVmckwxRnFDNTFxL0h4dzE0ZXlxVGsrMUV1Z2laSGMzRk4vT3JyM0pn?=
 =?utf-8?B?OVkxYXVGU1R5bUZqSjZVbmdFQzR2RVNZRTBLdXpxOGZkeXZhZDR0L2tCUk9S?=
 =?utf-8?B?U3djbnZJdENvU24xY2VjUmVNNE5xRGpmMEphczE2dXhBeUpGYTJNc2FOd3gy?=
 =?utf-8?B?bkdHWFZwYkNvQWgyRzJ0Y0YvUHNjZVd3UHExWStLenNsbE15VHEwczhKTXZo?=
 =?utf-8?B?eHNjVnMxNTFMbTRsUjJhdW9IeGQvZWlNbUtnRWhmQ3k4cStoOUJiSm1wNWVw?=
 =?utf-8?B?MEhNVTN6NVRja3BkOXRReHBEbFdZZENYWDRpTUV0cHJyMFQwK0xIbHFSaC9S?=
 =?utf-8?B?b2pYMFJYUUpXVTZOWVozNWhrbGpjdmNYeHVEUFpQY3NVcFk3UG5JVkVGTWts?=
 =?utf-8?B?R3hHSTliS0tteGd3L3g0eHZDN0ZqVHQ0S3l5RG9SdFMwTm1xem1CSlVlNVlE?=
 =?utf-8?B?WHZQbGwxRklzUHRBd09rWFZPOUs1VjVtQzMreTNQaUU4RTVXZVo1ODREaEtJ?=
 =?utf-8?B?ZUtKZGc5MU4ybUo0RTYrbWdZQktuUWRWT3owQnhmeUdtZTJsVFhWMXdBL0dj?=
 =?utf-8?B?SnBSYklab1RVTmJzOThDcXpZSzZtZU54SGlBUldhNHEvaVV0THhzUFhjN0Zl?=
 =?utf-8?B?OEZueGJYWHVTN3UwcXR2UzJ3QzBOTXJlNmZjNUhGVW4ramtnbml6TlR1cTNp?=
 =?utf-8?B?Vjk1WGZtUWRUK0ZmUHdaOUM0bUJseGlQck9YU2pwTU1YWFVhZjMwYTRjOXUy?=
 =?utf-8?B?VzdKYzJkTTZRcjJROGQzSjg2bVk0eUgxVkNrZ3ppQ3pkcUZhdlBWVENGQmNx?=
 =?utf-8?B?UTdwQjFLbTlGZkpTUWd3NHVnU00rZGhiVThXQ25ZQTA4a1VkTEZYcmozTFRT?=
 =?utf-8?B?TGtPbjY2NHl0OEpJWWZGdExSbEZ2VWJrSEh1dHErN0JLRE9iTVpySDJWMlRw?=
 =?utf-8?B?U250SjVJVHlrTFRrQm9RQXJZcVdFRnk0OEVDSU5wWU5RMjA3WTFueXdFMXZs?=
 =?utf-8?B?MUxpNC9mcVJyTjlrZ2J0ZVdaRnZYcUNuUzVmaHJyU1RNazFYd0Z6U0NrcE9Q?=
 =?utf-8?B?WFNxWElOeWZOb2F2L0RJUzRTZjc5MzVoZXpVQ01HRjVoSUM2Z25Jd0pOTVJ6?=
 =?utf-8?B?Tk9Ccnk2TTZVOUxYYjUxcEtma1RjMUxJd0NzVTE2S216L0hNYzdvUk5rTHFP?=
 =?utf-8?B?SEFzU0hXU2FiZUtVbHFhU1pKZE12QmVWL0VQbFFKTG9PRzBJT01IZ2dTM3JI?=
 =?utf-8?B?Nk0yQjB0MXpaNXVhM0V3amRyTk5iTWdqMTNjWTJpOWpsUFhqQ0d0M2Zqejk2?=
 =?utf-8?B?WGM4bERmZ3Q4TWpMeGx2OXIvVDlWVEdHK1AvUlZ0TDZTaUN0U3N2SndsZDhs?=
 =?utf-8?B?QXpxNW1mL0hGYnJNNWhVZzhmVmlTdHNZWC81Y0RDbW1XYVdTV2ZvTUlDQWVO?=
 =?utf-8?B?a01VUzl4SkVXYTQ5Nk1kUXdDRkFicWlPWjJXUG02UEdkUzY1UGw0N3lQbEhm?=
 =?utf-8?B?UjYzWEtZQUhwdHQ3ZDB0bjExT280VXc2UXdFeDRMQjY2VE92RERsTG5HaGJk?=
 =?utf-8?B?ZHNvNXU5ZWhuelFpSEc2bmhXR1p5M1lpUzlkYnRTU3h2WnNQQ21RdVlXcFBl?=
 =?utf-8?B?YjVWZndnMldCS3FOZjNLL0RpYTgrYmgxQWZHRGJtejUvbXlWcENHMyszTHNE?=
 =?utf-8?B?LzU4dHM4eklzcGZVOVZWNzIzUjNwbTRaUnlKSUlqOFBtU3huY0ZOdjMrNXlp?=
 =?utf-8?B?R1Y1eXFKdS9DdmdPUjFxZHdMM2lhMmx4Wm9DVjN6TWYxYjBkeDBuNTc3N0ZN?=
 =?utf-8?B?M2EwaVErSEJ5SmtyQlplT1M2cDVUYmhZWVlnczBWbENBMkswbGxnVXJSakhV?=
 =?utf-8?B?Sy8wWTloOWZBV0ZCLzg0d2E3YjQ4ZXNCRzRQa3dLRUJncjJaa2t4clVSYWdm?=
 =?utf-8?B?NW1rcWQ2aE1mK3lnWlcwRlZaSWdjMDBpYkpRL2FZL0VXMVpHR1dSOHFUWDdu?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2888d0b9-d872-4f7e-41a3-08dc11bb26b8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:04:28.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW78x0sTLXHpMQCWpSEgcY8lin2ZVP2xNCT3gmWwe9ao+5xCms5mqK4GTdWpxfXp1wS48V84ZpNNP9kd/8EkdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6676

On 10.01.24 10:00, Florian Bezdeka wrote:
> On Wed, 2024-01-10 at 05:45 +0100, Jan Kiszka wrote:
>> diff --git a/kas.yml b/kas.yml
>> index 1b2e857..2017e68 100644
>> --- a/kas.yml
>> +++ b/kas.yml
>> @@ -22,9 +22,13 @@ repos:
>>  
>>    isar:
>>      url: https://github.com/ilbers/isar.git
>> -    commit: 216f0721265fcfe965ac48b51a0128d612d89bf4
>> +    commit: 853784cf1732c093acd537fbb1b0b1c54e6b59ff
>>      layers:
>>        meta:
>> +    patches:
>> +      01:
>> +        repo: xenomai
>> +        path: isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
>>  
>>  bblayers_conf_header:
>>    standard: |
>> -- 
>> 2.35.3
> 
> We we're "ISAR patch free" for a long time now. Upstream first? Doesn't
> seem to be Xenomai or libevl specific, so I think we shouldn't carry it
> here.
> 

Isar will only look into that after the currently upcoming release they
told us.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

