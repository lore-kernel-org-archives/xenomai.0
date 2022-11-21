Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D06FBA
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 17:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7CFgLVG6ucKgQgyA6RoX41cW+eCK5XeyBH9ahu46KOMLfKdD4s4j6QNv0mDMl3yUCV6qPA5V0vnCwg5Fqt0ChcNMgCbNvWGt65dcnew5PLGvGS0VZ7+nPR9qxfjmUWxDrz75oHK77mFTPNQLycK00yfu18zmEgcsmMpgU7uED0iMrBlD58jHxcwWSJUrI/zmZYIZPMOKXsmailtABrZraYSHEFardfVysK0iYFrZyyQFWNfYFpPqnbS5yh98qO+YAqCwCUOIgSbqRClYr2walmdStuD3Op35EVPUOIOAJ58iwvKdgAc6gH+vRb4PxeIeyyLlSmMPfZza1VpYlwvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOWJJSF2PjnZtJlje0+D809xB4F7ohlOtzV1mn03CzU=;
 b=SKZihGH4GVMp8wXqEjk1oQjKCzCf7YbS+/Q8WLv46bDKNL/PAAyn6jGgkKlxF7AjkOYbpwrXRMAw4oAQH6Kq/oLFcXpAggDFwvJG4wRMPCV9dj2wdki4VPrBLPyBjwIoQCCEkST3ivKcsxLKk5/CLd96VR4IIQEyE0TArPy9mJiT3BT3O0eKXR9OC0C2gbqHlzxVGF6avjsMJ2eOPZMWkIbSrHXphuiDvA+iwOC0d+6ReFqwpLSuurWvpdimosfjpe4BPCaWD8Y78B/Wm63Y84U8Js8h9/xhx/jK2WGW3SNOpeq60tozYEo2y2whiZZIJHIDb71Xizn8cTGs7dor+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOWJJSF2PjnZtJlje0+D809xB4F7ohlOtzV1mn03CzU=;
 b=HAYRxti8PxOAcKunSa5WZTQE7cCFvW6yKIQX/wjoCTDEwhi2kN4p7rVqj4GuAcaoKvU3KKGjKgnIg6lQ2Gg+po3zyV8q1jh5JSHiVqRwauLxLZIBfawi7dCH0NE+FJjhW3PGwRfunrswfEzwb/e8J59hcgbGBDRkxkrEZ78oWXxbvmZggMoAFlMzHOka8CTcArHGp7cIyy4VMDUq5uePf/4uojwK1LUR+LrBboQ2VCQnvPOti8UzwGYSblBJpd3JTr64NxBUQ+vIIwD7mi/p0j78mBwr7+7kPRjBD/ZzEvxy2nASY8nVtsHCKz/SyxgIZy1MCOgN7bCt+OP7PWW+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3283.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 17:49:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 17:49:56 +0000
Message-ID: <5d6838c4-acbc-c0b8-4264-e47b1eec1d49@siemens.com>
Date: Mon, 21 Nov 2022 18:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC][stable 3.0.x] lib: Switch to pthread_mutexattr_setrobust
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20221118154220.869584-1-florian.bezdeka@siemens.com>
 <ea34c26a-e3e5-609e-5af5-2ad3a45e9d96@siemens.com>
 <0afbc24d39c0f299cbdce15ec33c05e2592d0459.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <0afbc24d39c0f299cbdce15ec33c05e2592d0459.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3283:EE_
X-MS-Office365-Filtering-Correlation-Id: c7857aa6-5464-46cf-0198-08dacbe8cc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8bVaD2cdLqt7VtcpDtHul2L4WPw3re5IZk6w83m64Oyn9JHX/uY6PS2hnCk93EfVYH59AXK/vTs6XTNn8fBx9jxkotreLFxOF89XXuBIxPKZrX4HcsgQ2mp8AuCGhpd1CPchUhPMGwaX2dos54Qyhah528Efv1bjKJNUf7FN87nmdHce3Y2wntM7OZgigQWbnUyHHOwZpmZBOEbPL+PZS9SK05tAoKfpWirxrA3oRLQl2xs1S/a8udjcMqO6ZpFCm9mpr43ncYi9mLGu9oMns7BPvR0OtN5Yncekb621y1waOHq2FE6Q58BQVUR+0tBkW+Fq6KnbF+V/9/x86DP77irAMIOnRTemcecn353Y0c0DJmADRzhScU37VQ9z5Xgvh9JlOTxkn7G3Y682YYOUhC0l4tvMgrLpUv8Ho5qJsfuLXRE/RSVcwkpljnef4qLYvIfPgvrVyMaMu7kB+FQBQgDsKKCrMJvcYQMnz6Gu809+eHmAEejpgpBpA2zWvToOJ/59Aktdn723af1Vqdv3xLD3Jo4OVaRWNrH1fhiPm1qSFdtwr1tFEEFI0cEGcUAdZ9ecLajTn36o0ZirLYoCok1zuz6YuxDe5SPHI16zR23QXvJ2q0SBctpAHkR9z4sPwjfNHR6XX5FT1015dz19fZ/8Tdc5bZfdTJFRnWPWivkWcljg81TNWy4vu26k8elx09xRYAxi/PUphfHbDnBsvsNLfZC+7b3b1IW8Q5sE/I0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199015)(6486002)(26005)(110136005)(2906002)(36756003)(6506007)(86362001)(6666004)(82960400001)(31696002)(478600001)(83380400001)(6512007)(38100700002)(53546011)(2616005)(186003)(4001150100001)(44832011)(8936002)(41300700001)(31686004)(66556008)(66476007)(5660300002)(8676002)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1ZETGlBL3J5WlFzdWV1czEwd2diaUZyL3FBVk9wNER3ZkNmeWpQM0M3YlU4?=
 =?utf-8?B?QzJDUll5R29Qa0tYZmFWOE5xUU92L1Q2UmpMbDFHbWhvYlZYendLOUd6ekZ1?=
 =?utf-8?B?VXh2cXBuUCs5dHd0dHhlbEFiU0R1Z0o5R1I0aytBOUw5MGtGaERXbVBVaDBQ?=
 =?utf-8?B?cDRxM1JRcUcyNDVBQ0xZcGxPbzdMbUJXeTFVZkVkcHpOWnYyczdGT0hsNGRk?=
 =?utf-8?B?Y1pUY0UyeWVib290SDF4WU5mZ0pPWVY3T0psMjRobkwvREhpTC9DTXB3bHR0?=
 =?utf-8?B?RFBYVW0zdVIrcWV1blVWeXpvaG5zSlQzVDlFVUVWWlBDR0JTTVpDdnVIaGNq?=
 =?utf-8?B?cGgwTEN0RkQ3OHJlek5LWXJBbFdIWmJSb1hhcVhHSzNSM2F4dzF0Y1kvY0VS?=
 =?utf-8?B?Z0dzRTFIbjlaTGpQQjkrVURJZm5mNzd3akJYOGdmNUpyZWMwRWZsbkg5V1dH?=
 =?utf-8?B?OEQ2QTRWamJoN1dUWG5PTUhiS3I1MHg3RUN3Uk41L0VqNFZ4dGtJMHYxd0Fm?=
 =?utf-8?B?cWxSKy94Qkx1RjRuWlRWM2JqejZtZjhPeTNYSFBpTjM5ZUtLNjFWZ1FwU0Mw?=
 =?utf-8?B?ZExNRmV4SU4xNjBDY2NxaUtFT002Vlc4WG16NFcxaFdjVVFrVC83Zk5XYVIx?=
 =?utf-8?B?eUh0ZlF1b01IcEg4Sm1VZnowcmlzaDRuYVE0TEZQQUp1NmJLclJUay81YVVh?=
 =?utf-8?B?QWZnQkNMVTh4L2QzNlpzSitUYjM2djFFZFBEY2kwaUIwUGhPci9JMUJ1eTA1?=
 =?utf-8?B?Y1B0SE9vY3ducHBpYTJERk5CVHowVmRmdmpOdjFMNklyMC9lN05hRWozVnpy?=
 =?utf-8?B?UGtlM1d3TFpBVndqSEx3OXE3SHJ2aGFaVCtKRHlPZllqdWJVbllUTjlEVjIw?=
 =?utf-8?B?ajdUaTFFbDFwUGhOZDRJV0F5MGR0VjJDUFFrclVXTnNDczhNU2p0c2pxdG5O?=
 =?utf-8?B?NjAzNE0zcFNVVk96QVYxQ3dBTEtkWWR4RTkyMWlzSEc1NXJiMURzZGgrZjd0?=
 =?utf-8?B?Zm9KVy9vSHlOd2hPbjZ0U0lJWk5iKzVtazI2K2wxaC90eW04Rm9iRmpwaVNh?=
 =?utf-8?B?ajMrM2ZjeXdnUFRaNjRWWm4zZ1ZtVXo5NzJaRHpBdEQ1NXlTZ2piWWIzL09W?=
 =?utf-8?B?Q0RIVk5WN0JCcjJDNVZ1RXY2WjhoTEdsenBKb0Irc3NFU01Jc3BVbnp5Si9B?=
 =?utf-8?B?QTNzYXZ4ZzVSYmtpcnVuRWU0QWRvNWlHd2R6VjVHY2xMMnU0dk42bUI4bS9E?=
 =?utf-8?B?bkR5YjYrSTIwbFVxVW5KcHVNQzFySFlTUG9jc3NZSEgrQWpCYkxyK2k5a0lL?=
 =?utf-8?B?UXEycVAyWHAvWS8zbWFKaG9OQURwclR1bDQ1UHYyVzlYQWMwQ0NhZkpkZktn?=
 =?utf-8?B?QW5HU09SQ0F0Nml2SkR2SG9GZzZ4dzNjQVdMdm1hVHhhRGtlcWtWQVoxYUh4?=
 =?utf-8?B?SHk1V0NSMUg4b2ZTOVdDSjRGWGlkUkllNzR5RXFNbFVTd0JmbnVVSnh5ZTZF?=
 =?utf-8?B?QVZNcnRJTHRZMWpjQmlnazRKNEZrTE5YQ2NJZmlrOU5DRW9vTDZrbXZwWU9X?=
 =?utf-8?B?amFIN1QwckU2MTNQY1JVQ3A0dk80V1FndjFDeEhrOFJyUmRlOEVmQzUwQWd1?=
 =?utf-8?B?ZmI3N3NjSDlsMjRFOUYrVjM0clpvUVNERjNIcW0wRUljeWwxRVVkY1dYSmV1?=
 =?utf-8?B?cXZsQmZBdTdDSEdTNWp6V2pXREduOXVNK1h6STlITUhOeWFNZElBa0paQzBT?=
 =?utf-8?B?OWFUYUxZc3FzdVA2aW1aWTc5blNhUmo4anhDUzdWR1ZIZS9tMWZzTExsQTFU?=
 =?utf-8?B?UXBQdXBFNVIwWkFGeUJJaDdHTnMzMDRubDZVa2M3U2FSY0ZVQnVVd2NlVVJq?=
 =?utf-8?B?YWM4VUczSWhoSCtZaXlYZVVRUldZcTF2aGh1NlpzUG1kYjh5V2prUDFnRkIw?=
 =?utf-8?B?bzVacHhXa3BJMUE0WHY3NDd3RnVMa2VHVXdSam1Obkp6VDNJVVlUcXM5VGZP?=
 =?utf-8?B?cTJHUCs5aGdERkVMQm1RSWV6ZTQrKzEwR3dNcGlWTHNXTjJ6OHJpVERYQnZZ?=
 =?utf-8?B?VlkyV3RNaGZMOUNpWHhLNk5wa1Y5eVlFTGRGMWh3aXc3V0Joem9TQXdOV1Rh?=
 =?utf-8?B?MzJleHQyZ0VUQzNTemh6cTgzdWpKNGF4Nm1qSEIxUjFpL2NOb21pdThZSzhk?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7857aa6-5464-46cf-0198-08dacbe8cc4e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:49:56.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qxr8RLA98np3dHjQuGDwS18M7WQjYIREazLHA0tFlbpa0dBj9IjiCXMCH3daYtwdgzSf9LoevpiNuWFL7+UXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3283

On 21.11.22 10:51, Bezdeka, Florian (T CED SES-DE) wrote:
> On Mon, 2022-11-21 at 10:16 +0100, Jan Kiszka wrote:
>> On 18.11.22 16:42, Florian Bezdeka wrote:
>>> With recent glibc (at least 2.34), autoconf fails to detect
>>> pthread_mutexattr_setrobust_np. But that is long deprecated anyway. So
>>> switch to pthread_mutexattr_setrobust and only fall back to _np when
>>> needed.
>>>
>>> This is a backport of the following commits from stable 3.2:
>>>
>>> 746cbeb6ccc0 ("lib: Switch to pthread_mutexattr_setrobust")
>>> 3f85c174e297 ("lib: Fix fallback signature of pthread_mutexattr_setrobust")
>>> 2d947e6fe3f8 ("lib: Re-add "static" to pthread_mutexattr_setrobust fallback stub")
>>>
>>> Backporting allows the stable 3.0 branch to be build with the latest
>>> Debian toolchain, so we don't need a special CI setup for the 3.0
>>> branch.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>
>>> Hi all,
>>>
>>> would it be acceptable to apply this patch to the 3.0.x stable branch? 
>>> It would allow us to build this branch with the same infrastructure once 
>>> we like to update to the next Debian version (12).
>>>
>>> Especially the y2038 tests require a recent glibc version the next 
>>> Debian stable release (bookworm, Debian 12) will ship such a version.
>>>
>>> One alternative would be to use different build environments for
>>> different Xenomai stable branches. I fear that's hard to maintain -
>>> especially the CI configuration will likely explode.
>>>
>>> WDYT?
>>>
>>> This patch has been tested with both build environments, so Debian 11
>>> (as is now) and the upcoming Debian 12.
>>>
>>
>> I don't mind backporting with this use case in mind, but why can't we
>> cherry-pick and possibly massage the original commits?
> 
> Hi Jan,
> 
> I tried but the first one requires merging / does not apply directly to
> the 3.0.x stable branch.
> 
> How to proceed? Should I resend without RFC tag?
> 

I've merged these four into stable/3.0.x here:

fed3436a19 lib: Re-add "static" to pthread_mutexattr_setrobust fallback stub
e4111b3c17 lib: Fix fallback signature of pthread_mutexattr_setrobust
87c719d48a lib: Switch to pthread_mutexattr_setrobust
cafb1e21ef lib/boilerplate: Convert pthread_mutexattr_setrobust_np stub into inline function

Only the second one (from the bottom) required a simple conflict 
resolution.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

