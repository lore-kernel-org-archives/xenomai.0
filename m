Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BAAED2
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOYbZTPOHBB57FyxTShgEV3d5WmAuupfYoh+Z3CQoUMOx1pC+WReWRbGWM+xdXtyJKAx6aRZ1DONjkeOfQTmzyjg8w26CIqeKfEG3yylcPAg+FQMTbnHPRcsSJxydOF35qwlQqm7C8xUUKyJkoI06QBq9rL64f4PX9/o4g42GK3N1GK7JS/OV/UFFl34iTaD/r/5sGBlWvw03Z4lKDisAWmeZ59MQ/az1JeUPRaNGv8Uj+ppfIiWijVEkXiDeq7ViyRydEWG9oYZAAjgOeB/0pOri7klpAkS1wwnb7p9qT9RraAQnA+rOwjFGuExCg1mT7K9DcnVZffQcOXRe9vSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5kSfUh/SNEubE4gU5itgJChhs5/t0tsj5GX71+SbO0=;
 b=V9TfH1BYCb9GnZwpXWvHw4RxI93P6AaY+avSNdpL2ZjZNAwNkuZeScSyA/KjWRrLcrLp12WWKk6K0gpVzXLNZi9tbDnNzf5WiWq35hjHCySNuTkinWSsPV9eqj9UlEkOFM11sOPA3SXLFdgpbliKCTptezPOnRKQUiyxh3JeLKDp28wRoiI4mGOdqRQ9F8MPQw7bfeDjWrpkt9Vy+M5CqTGQasKo9f18IyAi3047NdAAxl+sLfMbtJNfwKUnGIxSJDU/I9MEZcui35q1kk5kqXmyPf3y8WrTV9pucDRdAwkz6J0VaG4BUBIi7dE2wEAEGLXAx2IQq1Mjv0O/DP1Y4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5kSfUh/SNEubE4gU5itgJChhs5/t0tsj5GX71+SbO0=;
 b=mHBLdUh/0cTIdcOAb1bFySkCSYf91fg64y/yMLsMgixxgAnvtJHbu6Jia1J9/wI/+6q8Pnzz0s5q3pfLtPDFu8l6AhAgSrlZZTPsYueL8kajZMOHS/KySmhOVOS0zi8AZmVvcZlHBfwfqC+aKzMdqiaWuSUB//WIqKY1RzT5DHu0hgzuAx56qNHuzPkE5OiTCRy8rBN6WFh3VfE2tw7KzJWQBePBQ7nykHWzZ/O4aFPgadY8flaBp8+pl72i+xobnj6a3sLUondy9NuXkzVSY11CBN3IrgZfiC0Qy+7WO+m4eX3tIolH9+xFuhGUYxS0puFmBbipbCIIPuuPTfawJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:52:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:52:16 +0000
Message-ID: <bac774aa-a722-8ba6-d0ab-efca68e3559e@siemens.com>
Date: Wed, 5 Jul 2023 08:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: dovetail kernel build fail on 6.1
Content-Language: en-US
To: yo sang <stlfatboy@hotmail.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <DM6PR14MB38719DD14CE4CBF6F612C036A32FA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB3871F74C7C44DB95CAA1C6C0A32FA@DM6PR14MB3871.namprd14.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DM6PR14MB3871F74C7C44DB95CAA1C6C0A32FA@DM6PR14MB3871.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d2e6c1-4510-4e8c-cc3a-08db7d245e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U0Hipl39PadJufT1HaSszbqwTNlZmjbLmetYTVzmxWF6Y6wBVX7PfUwgJkq/Y4oR/xqzbsWyfg/pjtMTKCm5tFCIr8TFIUrWygjllFXM5SbUvZgGvSsfj8AZL3UDecAuoEL8r/0cNQl93+bRhgtgmX8VkWF+W082gok1FyWvLL7PWlivHqKAjr3vbSilifuhOcbNUqUWSe8DcH/DqGvGKjQfmlMHo0tzoTeHbRE/hmZsDOhhtohKcCtHhfevDmLMIh9dWUi3UgpfOcFLunQYhWcIVnmgT3EmB3so/SHF+gsqs5nljRN3FPaD0ETBXxr6MW4P1oOrWZPDMbp27+VuvJq+hHGRsaPtk1+2CC3CLUuKCrRFdoNjZsFN5Z/I5oyon8W0WGzb9SyiuwmgFmqJzCguVPHGTNFmXyLRaFbfgey49M2WBg90pFcPmtXJW2nF5BW1gXJZNDc1Q8yi18uPJRvIWyj29sH4Y+P+QlaYhMAmHqds7iys1Bt3yglzYUNKQEHyrSMDYM95ao3QOBm9KoRpl2H5edmjryqKGLHqUHOK9EKZ1+NYBepDi2H9DQQhD8cg8Sa0zW6QCvN8bI5Th0WG+zGjowXHbI8ir+A2/6lJNgy05h9C7IuiijV5GZMbsXb7g58ks8yQpF+6kDFf7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(478600001)(83380400001)(6666004)(6512007)(86362001)(31696002)(6486002)(66946007)(82960400001)(6506007)(316002)(38100700002)(26005)(186003)(53546011)(66556008)(31686004)(66476007)(110136005)(2616005)(8936002)(8676002)(44832011)(2906002)(41300700001)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdBdmgzc0laT2pacGk4cTR2TVJETmFZTERkcG9lMGFlR0JqeFlmZlBQcHlL?=
 =?utf-8?B?N3hQZmxBNjBoeEh0NU1WYlFOeklUUUFpazZFc2dFaytIV3RUQTBHN3l6d1Br?=
 =?utf-8?B?czlSUFhydHZ1UFFWdGRWa0RlVTlmSHZ3cDRteVBZZEpIdXdRVWQ2VVJRcy93?=
 =?utf-8?B?U1V3K3dUS1YxK2JOZXU1aU9NN0xXYkVPV0R4QVJHN21UMkNaRjZ5VEVvNHFp?=
 =?utf-8?B?Rm9SSVkwSVFoRUNkNlVBNjBTYklaU3Z3ZXBiREErT1BtQkdONU12QVdiUHUy?=
 =?utf-8?B?OTFnMGJiU2hQTFUxeFc1VkZJQmJxaWJVMENwWncwbEhDMEV3RTNPNUl0dm14?=
 =?utf-8?B?VnJaRi9XMzRNVCtveXNER3djeFdDWnRLNlh5c3JyMEdvT0g2M3EzT2dwL0F2?=
 =?utf-8?B?aHZPOWovRkNvVEhpeUxqYlVDOXJwV0VMbU9QNVk5Q0RBN3NJd3MzdksyNG4z?=
 =?utf-8?B?dXQ1SENBT0NrZnJodGxIMWkvNWZRS2ZKU291MnY0eHJKU0NSdkV6UlhPLzlq?=
 =?utf-8?B?OHMwQTdJa1lzZ2NoTUY0Q3I2dnY5ZTVsekFWOGRJQThDVkJ3ZmhLdFdwd3dq?=
 =?utf-8?B?Nk5kZGdxVm9mdk9McFRuSko3VFlmempIODZWeVYyRStXSWRRaDJnVklGR3Rv?=
 =?utf-8?B?cks1S01yMUI5UlNJQXFKeXZ5UHNHSC9mNWwxaTBZZUVOeWRPMGFkcTNVaVVJ?=
 =?utf-8?B?WjFJY3ljcnFVTDU1b1l5d25JMkNTRVJPQUVhMFVnTmdYeWFSY09JcWhYS0cr?=
 =?utf-8?B?YnpTNStNd0RsVDVRWWsvbjBPWStRRjRZQnpvcWRGL1pTdnAyeHVWZFdiOEtq?=
 =?utf-8?B?aDJzazFWNlBqZy9Hb080QWQ3ZG9IRkttdTdjV2tjS25VcVFDSW1DL0p0bC9a?=
 =?utf-8?B?OFA1UGgwTlZvUHNvbmhndEJNNE40NUk2QXZuY0pyTU5idFBjRFBCMUhVekNY?=
 =?utf-8?B?cEoyTjN4a0t3WUlUMjZ2V1NoN1lPelpmYVBjdEpMVHFaa2hVbnQyYU9XS2pB?=
 =?utf-8?B?bzlpNjdobFpsWllITkJFYWtRRHp5MGoyRmFYR3pLNjIrdHJuUDVRaHI0RGZ3?=
 =?utf-8?B?MVFtVE56bVAxckczRHh6ZEF2ZTBvRlJCK1dsOWh2dVhyTEJaNmR5WmtyVXo2?=
 =?utf-8?B?SXQxVW1mVDZhK2MrbENnMGoxbFI0dVRRbnAraVZLdjd6UDBlcXk1UFNRdVg5?=
 =?utf-8?B?QjRaSzFTT0cvbk5lZXYwcFBTYjA1OFdGZTRKYTNOYTJFK21kYXRTUmlpbHZM?=
 =?utf-8?B?VmJWc2pnQUdTVFlkMEFjYzRTQlVadkMyN2pua3k5aTI3MmgxUmpOeWFkT2Nu?=
 =?utf-8?B?TE5zZzBBM2drQk9OckZieVEyK3dkalVYT01VY3dDeGhLQVp6YnhPTzJmeklz?=
 =?utf-8?B?aFBITEtNeFBkT3pVL21GMnB3RlZGeFJob1p6RzBmWWliM1J5bHQxNUlZK1R0?=
 =?utf-8?B?OTNxbG9LdFpveGcxVUN0emUwWXROR3BMam5KWUpVcXdxRnlOTlFXakRyVnFI?=
 =?utf-8?B?SlVsYmcwSnBMVDVZYVFkWU4yWTlVeGZYek8vV1NkTzVxQkZOZUJEWHI3NkNu?=
 =?utf-8?B?SDM4YTBVMHE0VlV2QlRYeUNTM0g2MEZBekZsTExwVkgyVldMcFBPR05uQytC?=
 =?utf-8?B?Y3IyQ0JuTnVoL0JSQ0NEQ2dHN3EzNk02Ky84alVpZWRMNG0wK2NJZ1NMUVFS?=
 =?utf-8?B?ZFlHaW9idyt0dFl3Q01FYVJzTWNybW1hUUFTSUxVeUdtSGZMNm9SNktkUjJu?=
 =?utf-8?B?SWJHZHFZMUNnQXp4WG1ZUHlCOHlDTEUxRlNxdXMyQUh1N3phTDlORnozcXZo?=
 =?utf-8?B?Nk0vTlV5Sk95aGZCZ2kxY0ZjMmJrTnJHVndQSy92TFlUL0R4ajhPekhQcGhH?=
 =?utf-8?B?Rk9KdUYrbHlIVW9GYy9rV05TVmtlK1hrZm1UVW1WbFd4SUFza2IzUytpZysr?=
 =?utf-8?B?cFNIdFdmdTF3MFZ5d1BzT1A5TzcrT1NWeXFVUlA1VzE0SWQxOEJNV3BRb2Zm?=
 =?utf-8?B?YXIxVkdpcUJGZVVLZzVkTG0ydHFHK0d3QnZFMlNWSGhJZ1ZxT2Vmdys4TUlU?=
 =?utf-8?B?RlE1dFJmdHVtZVovQmJLWXFtNTZJWXFzMFRmcFdobkRvS1JhbVJvUEtwd1Jn?=
 =?utf-8?B?VkZZUXY0YkUvUUxkeWRhUFp0S3k1VE9YVFpNL3RvU21jczQ1STM3WTlVaTJB?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d2e6c1-4510-4e8c-cc3a-08db7d245e38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:52:15.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8WMl39s70pqwMo119Hpt6D0RGmlB9ykADBKoCmWMMFtTLFx6yQ6y7xFpJvibe9kHl/tmX9QOfJLDz/L8obNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5631

On 05.07.23 07:27, yo sang wrote:
> Hi, All
> 
>        I am trying switching to 6.1 from 5.10. It's ok when build with xenomai v3.2.3 + dovetail v5.10.179, but failed using same xenomai version + dovetail v6.1.34 (building in released Debian bookworm with gcc 12.2)
> 
> In file included from ./include/asm-generic/xenomai/syscall.h:26,
>                  from ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
>                  from ./include/xenomai/pipeline/pipeline.h:12,
>                  from ./include/xenomai/cobalt/kernel/lock.h:26,
>                  from ./include/xenomai/cobalt/kernel/sched.h:23,
>                  from ./arch/x86/include/dovetail/irq.h:12,
>                  from kernel/irq/pipeline.c:16:
> ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal error: asm/fpu/internal.h: No such file or directory
>    44 | #include <asm/fpu/internal.h>
>       |          ^~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> 

You need Xenomai master for kernels > 5.15. Changes to make that work
also with v3.2.x would be a little bit too invasive for stable.1

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

