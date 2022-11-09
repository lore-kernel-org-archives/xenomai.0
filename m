Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629219B
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 10:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j52So4VkBbra8boyH3dclPgJvadfFGDKNCPJNQwGkeqiKt3LoyFhxGE1q0AsMQO/eCrmb3Q6LN8i/26GJ4umP1GLyLubTn4M9+tZ8DwhnoMBj94IwG94Kt3yr/PklBz28/M6GJmI9dTgyGIaadBaXUOZBhGtP8P3Le9AYvgAynPaopySU8wQ8Yb6PhiNyfn69MC0srJHfHbkhvmg76YqjynBqutEZyDfutdJnLOzcvjg2twq6TZ5PHV2UkDgASlqV1Y/KS/j5wKLClmLifWUqpvkJ6Uvcb6xTDiRxS/i9ap2VszAD/4zduYFx57pD46gsQuGT+jR+0YQR3nX4wy8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v66YQ4VRpurIusCSo0k6WU3r62uOwWWhPlo2VogXw3k=;
 b=EjIUQ6TukpTDCBXKQViXnK8UOA5chH2biRrwvVuLQVaHqMlbbcOPTX8QdNpzx5esUgpVMKNY0el4mXwHBxhIViWMBaNd0y3SqPeGSeUnNZm6gVpkSVFgwEuv7Z6u97jTWh7pBB4IBZj/Yzxjoj0sYSI34TnITUd3Jb3k9HF1gXcJvw8yoo5N4Qj6Qldkdy1W5PQ8l+Z+ovXuxRJ6/lck8NydbzDBGZ7Zrveel9INn0nNrYQ9NjqH9+Z+mUM5txNoxswbCM8hHpkISeohxW73UmNUspAoos+VfbnyZu0KWEvHqQbEEo7ufMNCANZ+oeFxoN4tenbSJBktQUL5Xs7+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v66YQ4VRpurIusCSo0k6WU3r62uOwWWhPlo2VogXw3k=;
 b=TMUmPvFY5eXbaXjmmZKaOqjTfcLR76u9wM3tMjHuq0sU8dNuhidlzIEYepUSzyZAeX4gMgrXTJhvtnUhRUnAvKLxzSZ/QQX0ANWfL+P3nMdw15Y8vvXSfw2PmT7gJMDmQLdyvO+K8BkK4KjxHi2wGkUlU3jNbRYyjgU8o5j+zORS2+H16q5+iF0yJ4nIxkE0qPuuMGSY3upTDIExtDnVVYfUzIfrAr0KLC+334exOvhxl44K8P1gQl4wF/LW4o8Lwwau1izS3oluuZDmMIcTw+G8XD16ZoqUQpF6NiErhOzGlHSIDeUsbz6Dx8hov3XIe8iQqvTmrbxUtYDx2PjPZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:38:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 10:38:52 +0000
Message-ID: <d19b9dbf-9831-99ab-67bb-01d06b9b00f4@siemens.com>
Date: Wed, 9 Nov 2022 11:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Xenomai <xenomai@lists.linux.dev>, Richard Weinberger <richard@nod.at>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
 <VE1PR08MB4909620AE0E4EE0139B54276923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <f275bac0-492e-c8da-ea30-a48ebae505c4@siemens.com>
 <87iljoh1gd.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87iljoh1gd.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0063.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e380aca-3071-4039-1af5-08dac23e984c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UgPfckqGhmORkw3+3+tF/Vsi5kRi8mBiEdjCARgK5cD0MgxAH/y53NEdU4ZrdJgu2BGgH66MsPSdQEEjHXTNE6LgAJb/C8KfNTbrkfzKfXN7vSpAChrZ3cC6QsGBSOJWoWNdJFJ7EKnRzMajUPzBFX6Ut8+R3VPIwrp1XArvxwQPxJ3vWTU2x6OMAru3RJ7sZ8O2FEE++dJXGRBdu3ldhm9O/HOtppHCzFi4NNSl3+J5MZ8srrROoi4/mGnBNbljIMRq4KrLUU6irkllPdy35X4lWxSN4eJKEprUkQttEwX2kxXIykeMOVIbZgkRoSj30tLZ7nMrx7kptXrC01CIOwNrGViU+zqUS5zDnPQiCat6rgyk9xI3fadSV6SfcrougjcaFQtaojfEdbuRlYPeAzihaRmD94n74+QjvxgP1TeRharY1mXqFgiAUcBuZuHiGfkPoQDLmmB2xAxZ2VIZbZpg/L8ga0fZXZQhnaq44R7vtPX4UiVEcPfH5svg+9PAPrPyJoIK0d7Juy271GQNbDs8icA0HZK8ZHfjvNxJoZyvjIZHluDuvtuJD4tCMgsvU+tyWj1qilwSeS7JMKTQiHVQW81wPwmjus4oVT4VJvIUYZQHdAFaYXc78qI0lta9ZUE91GEgmtSEzawG2juVPmv/DKSgXt9WylFhaVsNaUGaTroXmkdVlL4P3fAyBAaMq1qSNJApC26egIRswvA5ZINtCFt6mmTWlXGc0ib5jtTLFfcRKFekr98shgj2aa3oOrLd4wMEverrI0w9wovwJqftaJNJ4l59kYVHNE1AKgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(83380400001)(26005)(6506007)(53546011)(2616005)(38100700002)(186003)(82960400001)(5660300002)(44832011)(2906002)(6512007)(478600001)(54906003)(6916009)(6486002)(41300700001)(8676002)(316002)(66476007)(31686004)(66556008)(8936002)(66946007)(86362001)(66899015)(36756003)(4326008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmVVdnIwZ0F4KzQxeEh5VEJJL1RHTVhEOVN0bWk5UGw1UFVBdCtkUUxsekZT?=
 =?utf-8?B?QU8yeUZQaDU0SEtadE0vSmhEejI5UWpTY2xKU1ROSldkY3ZrcjBRMGZNRTEr?=
 =?utf-8?B?OFFjUnFibkl2c0RQaDN4bS9tbFBRelRXOFd0c09zWjJ1ZkZMZDF6YWZ6aEdy?=
 =?utf-8?B?U1JYb3N3aDcxTE82cDNybTBKaHE2YjlDVjZQNmxEU0JXbE11U0thRTdKK01J?=
 =?utf-8?B?ekk4UGJCM1dhdUYzdFpWTTJpTXdsdW9NdjdSMzNPblJMUGN6V1pEQ053REVU?=
 =?utf-8?B?UW9sSnlNSGduTktHWlhmN0xoYVVFYWZSS28wdThhRnJZTVZsT21JN2d0b0Yy?=
 =?utf-8?B?dTJYWkpQd3VVTnJCWThML3I3NnFBdEVqdmhkcU9CaEZWZVpNSHRHR1liUi9w?=
 =?utf-8?B?U1dlTmZkOWJyb0VpRHhoQjh2NmRGenFUcUpuWHNXa1BPamtpZzdQS095bUJJ?=
 =?utf-8?B?MytYNEpmSGx4b2hXUFRYdWg0bmdURzZUT2dWd2RLUmNQQ3ExeVp0MmJLeW5H?=
 =?utf-8?B?Mk42cnowRXJHWkZkcHlLQ0tqVTdIZUVnVVZMbWtQUlFiaDVvMUNjZVRFcC9y?=
 =?utf-8?B?VzBpazZCeW9sM3BBTVhhZ2wzOVBSelVxRjF4SHdPM3J3VE1mTThxVUtuZVF2?=
 =?utf-8?B?Q3VET3RRS1pod1pmaE9raForMmh6ZXR0NFk5djI0d0Rab3RQWVlWRHB1SFc0?=
 =?utf-8?B?Y2ZhQ3IvWDJnYXQ2MlFzSlBsNklXSlRiL3dHcDVFam9Hc3FMSFUvNU15UDB3?=
 =?utf-8?B?bUVzQWhCdHJLRjF6Sk1EZTVacWc5MnFMbi9uajM5b0hFN1NlLytOenZBL0My?=
 =?utf-8?B?VXUreW9OTlhic3FESmNYbzdYZ1N6SE5FY2ZSeFhOMEFHOGptQkZsbUxkZUxM?=
 =?utf-8?B?SWtjaU10TkgySjlhTTZDNUk0RzNuS2VDcEV1UUlIYThOUjFzblB1ZVQzZlFQ?=
 =?utf-8?B?UWVXMmgzMzJCT0hrZE5SV0pUOHVHZDZxNXd1SkxEN1FwZE04R2lnVW9GTUdM?=
 =?utf-8?B?VDhVOUxrcEVFZmtDaFA2c3d0Sm5BMDJBazB0dk5pTlR2TTMzVTlIaU55NkhB?=
 =?utf-8?B?WHU4Nm5EK1cvaGFDdGx2aENjZEdLOVZyNU50STdQMEZtR1dIbWJ1bnZBMmt0?=
 =?utf-8?B?b1F0VFl3VFBNQUlya1ZzZnk1NzFOWEVObll6TU0vWU5kL2trZlZQR3ZORVJ5?=
 =?utf-8?B?RDFYT2NpbEFSMU1VNWg5YlFGdnRkdGo1bEZmT1ZmdEdZVTFNSnlXOHdadHh3?=
 =?utf-8?B?bTkwNUp6dSs3a2VpUzVhNXpOTEppTzhJQnUwTkUwd1VKeHBQOWFPOSs0ME1I?=
 =?utf-8?B?dTZBUkx1WXNhNGUxeUNOTk5PdGhXMlVyRDYyVUNTSWVYajBlRzdOYmRMVWk3?=
 =?utf-8?B?KzQvSElKTzl1K0lrYWUzOVpxOVh5NXVLaTM0cTZycGpsUGRVRHhpdldMSEpJ?=
 =?utf-8?B?ZlZ3VGsxN0xpeXpGVUZEVGhyTThHRnV5SmNrRWJCY05LRjA5YkFZNTh1clVx?=
 =?utf-8?B?QUNibk9NSUt2dTdvQzAvRnkweE1KMzV4bEorWWN2d3hlcG8yVDhySm54NXox?=
 =?utf-8?B?a3ZQeUp0OGFZdStqZEc5SWNvamloTEdrVTdLckhESEU2ZTZvTGIxV3FDRWtT?=
 =?utf-8?B?U2lidkhaZm44SGhtcFlzbVdPbUFIZ1BzMjBZNE9hcldYWjB5N2U4Snp0V1pN?=
 =?utf-8?B?ZEZBYWs5cmZ4Wk80TE1nTVNoOWtTYTFxYXowQnBXVVh5cE00NXVVSkY0MjhQ?=
 =?utf-8?B?SXlwTWNWSldoa3VYNG9YVVU1M1lXYWtQZDVjWjdqU0JLZlR1MTdDZUpOd1FM?=
 =?utf-8?B?VC9WZGlhZm8xeEtmeTZwbEFkNE5qY0xxckRQdGhPV00vSjdFWEQzOWRaejhO?=
 =?utf-8?B?Q2oxRVl3b3NTWW55cm5LME1BQ0RiWHkxQnErWTIzdyt6V3o2ZjdjZmtxTmQ0?=
 =?utf-8?B?K1hZRXZTbWtKZC8wNzZBTEIybnVVZnlxZUpCaDBkdkpBMEJMQktVU3V4KzVr?=
 =?utf-8?B?UThYTjlOUFAyYzFLemE3eEFzUmlZOThpb0NwUTYyK0RscmJEdGc5YzBTQjdr?=
 =?utf-8?B?VEkyeUswR3JJUjZrQjNUNjJvYjU3SmVXb0o5SCtyaThPWU8ybnUrTW12T0xS?=
 =?utf-8?B?eFVDenkzUFRxeEVPcmw5OURrQUJYNjhLMU5EdlRGd2FCTUZ1bDlnd0Fudzc5?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e380aca-3071-4039-1af5-08dac23e984c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:38:52.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbGFRXn2uqSBcdhrP37SlD6Fki5UBpkx6DHXpZPszxLDrRNJ8xT5z0P2eBDLHsP+OEi1FQSKdpAc3as7OLbuIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3152

On 09.11.22 11:06, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 09.11.22 08:31, Johannes Kirchmair wrote:
>>> Hello all,
>>>
>>> I just recently found the time to test this patch in the context of our rt_signals.
>>> As a matter of fact it works quite well for us.
>>>
>>> So is there any intent/possibility to bring this upstream?
>>>
>>> I also did some similar changes for arm64. As we also use imx8 boards.
>>> If there is interest in those, I could post them.
>>
>> Yes, please share. Then we can continue with proposing it for the latest
>> dovetail port (6.1 now).
>>
> 
> There is a slightly different approach which expresses the intent of
> that notification hook Dovetail-wise:
> 
> - if the real-time core switches in-band upon notification, then the
>   in-band kernel code may assume that all regular fixups need to be
>   applied next. This is the common case for most traps.
> 
> - if the real-time core stays on the out-of-band stage upon
>   notification, then the in-band kernel code should assume that all
>   required fixups were done from that stage already, returning asap from
>   the outer trap handler.
> 
> This gives the same flexibility than by expecting the hook to return a
> continuation status, but makes sure that regular fixups cannot be
> bypassed when/if switching to in-band mode is required to handle the
> trap. Rationale: the regular in-band trap handlers know better about the
> way to deal with those events from in-band context.
> 

Sounds interesting, indeed. Would also obsolete the need to adjust users
to a new calling convention.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

