Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35787B
	for <xenomai@lists.linux.dev>; Fri,  6 Jan 2023 09:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1Ek17bloVcD8HeNgwthBQPiXDTgD22QVN4+GcoziswaUQlms0/2IcpjCMeYS5a/C3zl7poEiStbnbXytR4KKb70dn49bY9uCIxaLYXyWKTkI1aGtqar8SH4xfZpAc6s8PXWGE4rmqKaHGwqsIxxOOWGaSQrV8svFQqSlWJ8diSZJRtxHU5z5w2L5GObilc0dV3Kxo1Y0kHV2LaA36QYGcdo26wj8/vBN4bFTiak7SMwHHlrXIORPsjCftryUf8w0j9MgMl7bdfm6HJ0HLzPMBf3FSNkvk69jmGXNbTFyPFKkbry+Ns+ZJZKRovN0VRU6Qryn9sziO7hHsuCO9MMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqPKxqFO4sdyi/oasbxgSO6feEDd9Zo1VmdyYJPskzw=;
 b=jL7C1JpOEUtDsadHKWrpvTAW8B+BoprIJfeQ5dK89BEsTdm7fl0kzAN0dkMkbSKpNawInLTFEfKwkMlH5RfyfMP/KXy6TtDiD935OGWidoz35wjAT0KDICSazA/lsJkZGdypbITKGT79fLdOrT2exmh62Cc9wFya2O7w7hHIMgAsS22rs2v0aP/32onVMJ7F1pRaLtpRs0xsT8/AKrheq/7h9ZHwZ3GNkzYf/McQQYiNQrIe4cva/gVITK8xK3C5yUCFyGj3pitQ0RPrkmAiensVPLPlKPoAcP49zmigC83jZK4XP/pqjsV516cSCxrK+s6uAQ3SQJtspYxf1m6YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqPKxqFO4sdyi/oasbxgSO6feEDd9Zo1VmdyYJPskzw=;
 b=nz0JWPsxOnIOja/DgkoZ+4Ct0FF4voMrcHDcCza74N8dGDEjsubR1FhQ5GIP6/Im0w95XSNIF6Ul+zkZSv3xmNqags7JgKPcKcRXKDSF/i1yAD5nM/hQQgmxD15o2CFdFKasE4CFXPH482vKIg/mJfSJfbbUJ0Ri5V7nk4qCRNT99f9URCHYv3h+cqZfORLVvvVyGdS0aHgzrykp2fO4bSzGSJgxBNhuyUS3hoX/aGaRC78d/+aWvSeYwpFINLGKWIc8ze9WiltbhB8KCqw9bXEcwzrgh87Qe6JRaoFdvEjDRrXxrTnpq4RnwhI58Fngp6bzQrvqSoD/EEhj39RmXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS2PR10MB7903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:647::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 09:04:01 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671%5]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 09:04:01 +0000
Message-ID: <ad5c6da9-b10d-7400-d10c-4783eeb2c11c@siemens.com>
Date: Fri, 6 Jan 2023 10:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH] Update Isar to latest next version - sbuild
 integration
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20230105132733.3056171-1-florian.bezdeka@siemens.com>
 <ee077ae5-b261-18cb-a903-8d268fa29883@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <ee077ae5-b261-18cb-a903-8d268fa29883@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AS2PR10MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a08410-4fd5-45de-3fce-08daefc4f402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rjoOX7XKmGZB7JUblPC6603+ZxXAdhxBeWMxilHKaPfQqt7Td0z53gLm2Ri8lDif29pCLCwNc71ekhMzO9lrDjz00iN4EHOUfz7UOCeTKVIDPRdzi4pCG1tcuK3YItadT/r821R0MChV45YWcVkAOYKO4nL3tVpZw9F0Twncks83gtaGU85rtgYNIm/0DmgAKqTf30e2SARAlCUMlZupu2sPEiJ4BN325gaQGDw0xx372+nmdklKgUVpUrveUJD82lpksTvCq+AIklYgioVP2O0IHMzgZGoRZ+HahbimYGHyfMAFG1SP56U6aCvAY+dwJ7SHrV9KpAvPfM5ufu6BuTulRNccoOxFJ9YsdevY1Yvlqwt8M7HlbG2cL3m683BASdx3S/E7sT6oSCTR/b9yi0VLwjmQz5jBCZD1oj9m9g/+ohAHd75vpE5uL2SPGqADgQVobx+3lVYCpfMExpfhBu+iZnq9LJ96nc5k0gXePEs6Kg4djGrnXZAsB0SZ9BM09vsKn1MtdmDFyXEYQsMp6BTp07jpQ80JiOckjqE5iGWC8Ziodjsss8dojiYsv6UNj0YqDRJ1RQd+hK+2YvvQMua6RA2iZXj9tK2pTBBABks/Q6OyDALHHHoZ3qZ2BCzkU1JJENhHo8if4doVKVs6xmsrOL/+cH2vXPFxBsB6Pei/8PNMwIlsrFXO0eK9a5EX2lMgjzgCGjQ+8aQOLvmul6Cjun7fva+FirMh42Yw78UGwpdWEAecpQLtZ3gU13jeySQ+ihPb96rt2tS7k12V/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(2616005)(83380400001)(31696002)(86362001)(30864003)(82960400001)(38100700002)(36756003)(44832011)(31686004)(2906002)(15650500001)(66899015)(8676002)(5660300002)(66946007)(66556008)(66476007)(8936002)(316002)(41300700001)(478600001)(53546011)(186003)(6486002)(26005)(6512007)(966005)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlF5TnV6RzlUQllrYWY1SDBLWVhNUC9FZ2RiZU5iaVFWMUVHWEp2OEdzRDRO?=
 =?utf-8?B?ckpEMFpLbUhOelhkWThoUEpRVU9DK2ZoeXZlQ2ZQR2ZVckcydnB3bzg1ZGEz?=
 =?utf-8?B?VGlyMHhDRVhsRld3TUR0UXVJQUFQZEhVVFRpVi9jSXlWOGlVKzh5RzVWWGZa?=
 =?utf-8?B?eTNJcE50bXZMTlhIU3F4MXJSSHE5Wm1sSVdiMk1HSnkvV1haUFNHWXl5ZnlD?=
 =?utf-8?B?RC9Sc3hzdnhmcWYwcGlDOExhMG9WQzdlSmpZU2lYL3NtYSt4ZXRxblhhRHJk?=
 =?utf-8?B?L21VZGpzcmdlQ2NucXoveXVOWEJtdmpyK2p2MTNLWk5nM3FjWE5iYzhXMGtS?=
 =?utf-8?B?MzhkSDIybmtlVVBINWpLZmx3UjkzUWVXd3NnYTAzalNuRHhVL2dQS3M3U2dp?=
 =?utf-8?B?OUZ2UEptUnpZTjFsQmlOcTVCNTJlWjQxeFpLSlJsWXVtelY1MXhISmFyckhv?=
 =?utf-8?B?NDJkTDJVU0lJOHAxOHVPNVYvdkx3cGJQWjVEbmRRNjlxL25QTnhLajNuMXBO?=
 =?utf-8?B?dU1BSlZsWk8yMHhNTU44VmtxRzlWNk1qS0QyMzc2dkhDc1hHTGdaS2c2b3Zw?=
 =?utf-8?B?NW5OSjhOVzFibU8yZDUyU3lXZWNzNWJ4SFJpVkZqODdtSkdaWVM3dE5MZGZr?=
 =?utf-8?B?c01NekFSdG5MdERFYlJ0eTkxaHgrRytWN0Z2cFB0V0x2Wm5tZ1FPWWNVU0h2?=
 =?utf-8?B?d0U4Z0RhUThqTkZudTc5TkNKM2hiclQyeXRvRG5pdEVFaVZtbWVtS01GZUdC?=
 =?utf-8?B?MDR4Z0g1TjdYQlFGS2xkc3dTcXQ4MEljeldUbUxjbEpzWW5lMXNyRTUwYjhJ?=
 =?utf-8?B?QWpva0lYODFGQUxDMnMwSll2Y29FVHJjaThxQ0NFM3ZOY09JL3BqZW56WGRN?=
 =?utf-8?B?ZllQSW5iUUErNTRienIyWm41Rkkwb0MrQWN4VUVFUFNQU0lrMDMrLzlyYkow?=
 =?utf-8?B?SHYyWXd6eUpjWDRoSTE3bEpHbkVnNUs4WWJXMWNKN2tzbHlqOFpmSVgxb3dq?=
 =?utf-8?B?VmM3L2FSU2ttNWVGYUhWOEFicnJYRGNkWmcvcjBNSWVBS0ZRbERZalZHUE1M?=
 =?utf-8?B?SWQzUThlcTRnTGcxVFRVbjk5cmhjL0pmYXhXYWRQWmdna1h3WDA0WUR3VEZ4?=
 =?utf-8?B?R3JmUTl0c29XOGtUbGdDUnhLQlFWcEVGUWRsNHJtL1BDMHM0SStTUHl6RGJz?=
 =?utf-8?B?eTRsdFYxUEQ4bmdTek1MVkhzQ2RMQlJFZ2dHZjhCUHBLUlVDTmJEOWJCY3FY?=
 =?utf-8?B?RUluMllhWngrdmNLSnEwYVVSYytJNTRSd01ON0JvY2hYUVhyVmRpVkVrckF6?=
 =?utf-8?B?bHJRM3hUeWRMNVAvd3BneXdLSWMwTnVIcmNLd1d3OWVRTElBNWVCNzhSOUR2?=
 =?utf-8?B?bTZ5YU9TTGRVUDIrTE1jR1RkaVF5alp2THZvMFh2L2piQjVOZXBMcGRSVWZm?=
 =?utf-8?B?aytNbFk3QnBPWnF2ZHVUb2ZXZUVodEhpZ1RjeTY4QldVQnkxMW85L0dOVzFr?=
 =?utf-8?B?d3RMQWNTK1h4aUV6U0JsNmRGWUlzN3lOd2lVNkVPeC80czY2L1RaNDkxRTJq?=
 =?utf-8?B?UmIxOHhLQ29rNFpINTI5Zjl6MnJ0eDZjQzkwVEEvOVRPZXZzU09QS0JUS0di?=
 =?utf-8?B?TS9USG1ZLzZFaUVYYUpneXFPTGVwTEVqaTliQktwZldGbjQwaDBJeXkvVkp4?=
 =?utf-8?B?RnpwYnRlMEdPcG01aVE5MTNJdHNZdUFycDk4VjJUQldHdG1OT2J3QXBjTTNJ?=
 =?utf-8?B?dkRBY2oycmlXa2pTSUVtcnorUVR2Smw2dEVLNy9UQlY2MEFNSDFQQ2c4L2JJ?=
 =?utf-8?B?TEZ6SHJJQzR5SGdDUjZzeHR6aFl2ZitzSXVCRWRDcWlLNDVBMWN0bml4TWF3?=
 =?utf-8?B?eGUxK2Nrb1dPVEZIZnByd0VxSmxqSEV2SEhrZGZ0NERxeTJJRGxrVGNoNDlW?=
 =?utf-8?B?U2NqRDlhZnRNMTB1RUFiTWpoNG1NdGlFWnZ3a1ZnaWZGa3NLMzVoTmRNdWtH?=
 =?utf-8?B?SVI5cExSVzJ0bC80eFBpdW9vZVdhRnNMaDdqTEYxNlFkSXVjVDdEZHJVZDEz?=
 =?utf-8?B?d1dEcGpVY2dTdDI4M0I5UjhJNVJCUTNpZ1E3N1pZRUNLOGF2bjZlcm1lc0RX?=
 =?utf-8?B?a1M2UWdQL0VsR2JDdGN2M0JONmdhN2RqUUoxUzdVTFBwRzl2Sk1Bb0NOem5H?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a08410-4fd5-45de-3fce-08daefc4f402
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 09:04:01.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsxiX4EXeguAGujnXVJyK9QNRc8ytngZbquzgkfrG0AE23CsQ6UxkPwbP7u3Rxvt2uCkyECcYF58qFrk48XKi+5sly4Z3aV/UiVa4gtrv/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7903

On 05.01.23 19:06, Jan Kiszka wrote:
> On 05.01.23 14:27, Florian Bezdeka wrote:
>> Updating to latest Isar will allow us to use Debian bookworm as base
>> distribution. Bookworm ships a recent glibc which will help to enable
>> y2038 testing in the CI environment.
>>
>> This is the first version of Isar with sbuild enabled, so we can't use
>> the tricks around ${BUILDCHROOT_DIR} anymore.
>>
>> xenomai: The scripts/bootstrap call is already part of the upstream
>> debian/rules file, so we do not have to call it again.
>>
>> linux-xenomai: Moving the prepare-kernel and patch-kernel step into
>> debian/rules requires patching the debian/rules file deployed by the
>> Isar linux-custom.inc helper.
>>
>> The added Isar patches can be removed on next Isar update. The problem
>> was that the rootfs is no longer added to /etc/fstab. As a result the
>> rootfs was mounted read-only failing LAVA tests. As the oe -> isar ->
>> xenomai-images transition will need some time the patches are added here
>> as well.
> 
> I think we should wait for Isar and/or OE to react on those patches
> before moving the Isar revision forward. But we can already start
> refactoring the problematic recipes as that should be independent of the
> update. Comments on that below.

Getting this comments was the main reason. Thanks. We can wait for OE
but it seems this will take longer than expected.

> 
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>
>> Some notes:
>>   - One step closer to y2038-safe builds
>>   - The upstraming process for necessary Isar patches started already
>>     Might take some time until patches hit Isar next
>>   - Internal CI did not report any issues
>>   - Comments (especially on the sbuild stuff) are welcome
>>
>>  kas.yml                                       | 11 +++-
>>  ...age-remove-entry-from-fstab-template.patch | 28 ++++++++++
>>  ...2-wic-replace-existing-fstab-entries.patch | 52 +++++++++++++++++++
>>  recipes-kernel/linux/files/debian_rules.gdiff | 14 +++++
>>  recipes-kernel/linux/linux-xenomai.inc        | 35 +++++--------
>>  recipes-xenomai/xenomai/xenomai.inc           |  7 ---
>>  6 files changed, 116 insertions(+), 31 deletions(-)
>>  create mode 100644 patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
>>  create mode 100644 patches/isar/0002-wic-replace-existing-fstab-entries.patch
>>  create mode 100644 recipes-kernel/linux/files/debian_rules.gdiff
>>
>> diff --git a/kas.yml b/kas.yml
>> index f8790e5..b6e5133 100644
>> --- a/kas.yml
>> +++ b/kas.yml
>> @@ -1,7 +1,7 @@
>>  #
>>  # Xenomai Real-Time System
>>  #
>> -# Copyright (c) Siemens AG, 2018-2020
>> +# Copyright (c) Siemens AG, 2018-2023
>>  #
>>  # Authors:
>>  #  Jan Kiszka <jan.kiszka@siemens.com>
>> @@ -22,7 +22,14 @@ repos:
>>  
>>    isar:
>>      url: https://github.com/ilbers/isar.git
>> -    refspec: 213b8f62fa74e87321f927fb6b4ed9db93e5cb37
>> +    refspec: 8530a94bdc8919fadccad13e6061832d2f2c1fcc
>> +    patches:
>> +      "0001":
>> +        repo: xenomai
>> +        path: patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
>> +      "0002":
>> +        repo: xenomai
>> +        path: patches/isar/0002-wic-replace-existing-fstab-entries.patch
>>      layers:
>>        meta:
>>  
>> diff --git a/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch b/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
>> new file mode 100644
>> index 0000000..4354d32
>> --- /dev/null
>> +++ b/patches/isar/0001-Revert-image-remove-entry-from-fstab-template.patch
>> @@ -0,0 +1,28 @@
>> +From 5c9df8b8ac0691c2c4b11deaf763999bb7a136e6 Mon Sep 17 00:00:00 2001
>> +From: Felix Moessbauer <felix.moessbauer@siemens.com>
>> +Date: Thu, 5 Jan 2023 08:45:02 +0000
>> +Subject: [PATCH 1/2] Revert "image: remove / entry from fstab template"
>> +
>> +This reverts commit fc4f004eb67237d9d09b1ffad0de1a19217fa94a.
>> +
>> +Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> +Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> +---
>> + meta/classes/image.bbclass | 1 +
>> + 1 file changed, 1 insertion(+)
>> +
>> +diff --git a/meta/classes/image.bbclass b/meta/classes/image.bbclass
>> +index d8d605d..ccff810 100644
>> +--- a/meta/classes/image.bbclass
>> ++++ b/meta/classes/image.bbclass
>> +@@ -327,6 +327,7 @@ image_configure_fstab[weight] = "2"
>> + image_configure_fstab() {
>> +     sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>> + # Begin /etc/fstab
>> ++/dev/root	/		auto		defaults		0	0
>> + proc		/proc		proc		nosuid,noexec,nodev	0	0
>> + sysfs		/sys		sysfs		nosuid,noexec,nodev	0	0
>> + devpts		/dev/pts	devpts		gid=5,mode=620		0	0
>> +-- 
>> +2.39.0
>> +
>> diff --git a/patches/isar/0002-wic-replace-existing-fstab-entries.patch b/patches/isar/0002-wic-replace-existing-fstab-entries.patch
>> new file mode 100644
>> index 0000000..63e852b
>> --- /dev/null
>> +++ b/patches/isar/0002-wic-replace-existing-fstab-entries.patch
>> @@ -0,0 +1,52 @@
>> +From d162b4cfe3c8cce723372519bedb9d861e305135 Mon Sep 17 00:00:00 2001
>> +From: Felix Moessbauer <felix.moessbauer@siemens.com>
>> +Date: Thu, 5 Jan 2023 08:45:03 +0000
>> +Subject: [PATCH 2/2] wic: replace existing fstab entries
>> +
>> +This patch extend the imager direct class to check if the mountpoint of
>> +an to-be-added entry in the fstab is already there. If it is, the old
>> +entry is removed and the new entry is appended.
>> +
>> +This solves issues with duplicated entries which coming from the rootfs
>> +itself. One example where this happens is when generating images for
>> +both direct kernel boot and EFI. In this case, the rootfs mountpoint
>> +needs to be in the fstab of the rootfs and needs to be replaced in WIC.
>> +
>> +Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> +Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> +---
>> + scripts/lib/wic/plugins/imager/direct.py | 11 ++++++++++-
>> + 1 file changed, 10 insertions(+), 1 deletion(-)
>> +
>> +diff --git a/scripts/lib/wic/plugins/imager/direct.py b/scripts/lib/wic/plugins/imager/direct.py
>> +index c44159b..7f8733a 100644
>> +--- a/scripts/lib/wic/plugins/imager/direct.py
>> ++++ b/scripts/lib/wic/plugins/imager/direct.py
>> +@@ -104,6 +104,14 @@ class DirectPlugin(ImagerPlugin):
>> + 
>> +     def update_fstab(self, image_rootfs):
>> +         """Assume partition order same as in wks"""
>> ++
>> ++        # return the mountpoint from an fstab entry
>> ++        def _get_mountpoint(line):
>> ++            parts = line.split()
>> ++            if line.startswith('#') or len(parts) != 6:
>> ++                return None
>> ++            return parts[1]
>> ++
>> +         if not image_rootfs:
>> +             return
>> + 
>> +@@ -141,7 +149,8 @@ class DirectPlugin(ImagerPlugin):
>> +             passno = part.fspassno if part.fspassno else "0"
>> +             line = "\t".join([device_name, part.mountpoint, part.fstype,
>> +                               opts, "0", passno]) + "\n"
>> +-
>> ++            # if this mountpoint is already in the fstab, replace it
>> ++            fstab_lines = [item for item in fstab_lines if _get_mountpoint(item) != part.mountpoint]
>> +             fstab_lines.append(line)
>> +             updated = True
>> + 
>> +-- 
>> +2.39.0
>> +
>> diff --git a/recipes-kernel/linux/files/debian_rules.gdiff b/recipes-kernel/linux/files/debian_rules.gdiff
>> new file mode 100644
>> index 0000000..477e581
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/debian_rules.gdiff
> 
> Is .gdiff some specific file extension? Or is it just to avoid
> interpretation by the do_patch job? That could also be achieved by
> "...;apply=no".

Ha, too easy. Thanks!

> 
>> @@ -0,0 +1,14 @@
>> +diff --git a/meta/recipes-kernel/linux/files/debian/rules.tmpl b/meta/recipes-kernel/linux/files/debian/rules.tmpl
>> +index 8063c49..5ce2c5f 100755
>> +--- a/meta/recipes-kernel/linux/files/debian/rules.tmpl
>> ++++ b/meta/recipes-kernel/linux/files/debian/rules.tmpl
>> +@@ -24,6 +24,9 @@ override_dh_auto_clean:
>> + 	$(isar_env) && bash $(deb_top_dir)/isar/clean
>> + 
>> + override_dh_auto_configure:
>> ++	/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
>> ++		--linux=$(S) \
>> ++		--arch=${KERNEL_ARCH}
>> + 	$(isar_env) && bash $(deb_top_dir)/isar/configure
>> + 
>> + override_dh_auto_build:
>> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
>> index 7dba96e..eed372d 100644
>> --- a/recipes-kernel/linux/linux-xenomai.inc
>> +++ b/recipes-kernel/linux/linux-xenomai.inc
>> @@ -19,6 +19,7 @@ XENOMAI_DEBUG ?= "0"
>>  
>>  SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>>  SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
>> +SRC_URI += "file://debian_rules.gdiff"
>>  
>>  DEPENDS += "xenomai-kernel-source"
>>  KBUILD_DEPENDS += "xenomai-kernel-source:native"
>> @@ -32,26 +33,16 @@ def get_commit(d):
>>  LINUX_COMMIT ?= "${@get_commit(d)}"
>>  
>>  dpkg_runbuild_prepend() {
>> -	case ${DISTRO_ARCH} in
>> -	armhf)
>> -		ARCH=arm
>> -		;;
>> -	arm64)
>> -		ARCH=arm64
>> -		;;
>> -	amd64|i386)
>> -		ARCH=x86
>> -		;;
>> -	*)
>> -		bberror "Unsupported architecture ${DISTRO_ARCH}"
>> -		exit 1
>> -	esac
>> -	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
>> -			 ${PV} ${LINUX_COMMIT})
>> -
>> -	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
>> -		--linux=${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=$ARCH \
>> -		--outpatch=${WORKDIR}/xenomai-kernel.patch
>> -	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
>> -		-p1 -i ${WORKDIR}/xenomai-kernel.patch
>> +    bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
>> +                     ${PV} ${LINUX_COMMIT})
>>  }
>> +
>> +do_patch_debian_rules() {
>> +    # debian/rules is a template deployed by the the linux-custom helper in
>> +    # Isar. The template needs some patching before it is processed by the
>> +    # templating engine. We have to feed in the xenomai specific
>> +    # "prepare-kernel" and "patch kernel" steps.
>> +    # Note: We can't use the .patch or .diff file ending here (bitbake magic)
>> +    patch -d ${WORKDIR} -p5 -i ${WORKDIR}/debian_rules.gdiff
> 
> I wonder if we could also come of with a pattern that uses the original
> rules of Isar, including it, just adding a prerequisit to
> override_dh_auto_configure:
> 
> include isar-rules
> 
> override_dh_auto_configure: prepare-kernel
> 
> prepare_kernel:
> 	...
> 
> .PHONY: prepare_kernel

Nice idea. Will try.

> 
>> +}
>> +addtask patch_debian_rules after do_unpack before do_transform_template
>> \ No newline at end of file
>> diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
>> index b874a4a..4994533 100644
>> --- a/recipes-xenomai/xenomai/xenomai.inc
>> +++ b/recipes-xenomai/xenomai/xenomai.inc
>> @@ -34,10 +34,3 @@ do_prepare_build() {
>>      rm -f ${S}/debian/source/format
>>  }
>>  
>> -dpkg_runbuild_prepend() {
>> -    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
>> -                     ${PV} ${COMMIT})
> 
> We lost this part now.

Nope, it only moved to dpkg_runbuild_prepend() above.

> 
>> -
>> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
>> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
>> -}
> 
> Jan
> 

