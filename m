Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D31110E
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6XqsbmkuI+enaBVsySHOBgbdeQV+Z6DPalVtjKTWMrpbRa5K32bGqbOdwgBzJrP2kS08WTtG44bkLGxXCEWh3BT3iSf/rNmBcBdsHIWOIrYrnmPIsU3/i8b2BWpdaLrA3OKdzqHE+ka+OZUURXtKF2EhF2QWI0UCo7UdgpidCycHSRirR54jbx+DvWc+W3rgc8mBNx6DD4zu5LzpKCj5OYuloejYflKXY/FgG7oUjzXqTMDWJh4VcHs1Fb/u5YvWxmdw613lxGVdjWFgjkdVo7agOO7JkCoE1jeISBn9ATMaHaEyBbjRSau+D1hW8N34y9wo+CUWbEsKI5fi7cvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wU5tre8Gl1/CpNlGGD57NhncrFio3vUYZB9ezH4MIc=;
 b=MLCfl9sEdCLLuPiHs5K3yTavJorCZ2BM1sHk/yCmkqvohsqgqk+KIJEt0Is0b/FljK2c4Z38YlUEl2X5M8iCmbiX2mmUkYutvW2LwokcfOxdaZDe/wWaGs4ZHfXfEf+6Lia8IkAk1DEthRYWEBJTZC9fW2z5LRr5+cvfpeWBB8xU8JbRG+rlG9slzIWvyxTwjjdvkexv/ZpifPiQ017jbkfwdxCbbUF4i1RAw+AYR2v77yXrebCcshN2l7NXSSWxKoOfgKoarGH0HxMKi//nJIEmc8fzLri4bKntN3wp2f7KNHhz5V9EH/USfAxwWmQTtc6cJedHh1oYcemdboI6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wU5tre8Gl1/CpNlGGD57NhncrFio3vUYZB9ezH4MIc=;
 b=yyTkNKnjp0xkfVzKaWGGKvqvv61VT7+5eMSubZ3Sgmt9brXmE6bcnl4lfxM2izOQun4I3l7xZ8tux6/W+QkpqQrqgFaaxgYX1GHshw1QCcAlA2FktX404um2Og2gmNzoKn2azyePoV8EXN8in5puXNt6E9K2wSZNjkBRyvFMS9D63dbWN2IKnhgOIfA37kB5ujeiGAZKesVte8kd/6+3Rhzlu6RPMnEzvLdMs68+CIuThbgxGXCwU3riaf7lzTt4dAIuMxv4wg1nPyRPcMkzFF11EKO7G8gVp4jrVpGgiZJzuprIZLVgIfrSX4xafJmmcYUtBIBq1NNZmuFu/iFx4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6525.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:14:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:14:52 +0000
Message-ID: <aa889b3e-4b0d-66d7-8096-ae08a103274c@siemens.com>
Date: Thu, 6 Jul 2023 09:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/12] y2038: cobalt: Introduce sched_param_ex64 and use
 it internally
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-1-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-1-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d0ec1e-8a54-45a0-e507-08db7df0b131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EpNhU2jysikFpEmeiYjZfI/YH+UL7tlXTAX+1GH3mhUKhH4pUufBoyvvFPGmUCU01LfgjzToCgsPPN5OwWgW0ihmjqAknF+F9Bdl+IpIfqL4lQz0NyTrKYK4poBhHRCpxBWuMBwFea1DmAc9oBFQ5GHwKvFa5jXm8JDYSYZut1pSu0RgweNV8hnULVOGya3dIsh6wIK0WmNIwfVgoG9tiEhg+EVxg+PW0b++vKNjrAZeY/NyeE3+UxH3X7rwMpgWvvASxRLAc/jT0+GT65xO4+FGucUHxovcAW+80x25gqZIB1VZOUYJ3/6HRDLBd4dZXFW7u6bcuXeWBlQi/deh0izGAiig50sA1bdfePNWYsSzvHJhfHeWa+RMqTginCFB0/v1T+uh0IkwurHbXo/KQU0UFcTcH8JKFBbzy35IfZXqiXhL4eObreWbCpPw2GCLd4UkzFir344cJJE9MvcdHtss+mpr4bSOCqLjTlRoReOcvEhdejuZpo3F99u9nvn4eYn5rsrqXTXgB41sES9gR3ZFchhNiIkeKDQuh42IJCHchUKNcl9okd2fNK6LLmsWzdq+azlr8fFFlJRqjyibzLw7weF1OVFMR6vTiQMocOlGqpLVWmshPXMb3UkHvI+lClLwlv8WYiVxevZH/zJ/kQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(38100700002)(82960400001)(36756003)(31696002)(86362001)(6512007)(478600001)(6486002)(186003)(6506007)(53546011)(26005)(8936002)(8676002)(44832011)(5660300002)(4744005)(66946007)(31686004)(41300700001)(66556008)(66476007)(316002)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1Z1U3BKdms1OEVDL09tVkJZcEhFSHArc1daTnA0U3RIN1VkcG94ZkZoTVBl?=
 =?utf-8?B?SGFqQ1Z0Tm9idGVFUVp0MTVGNy9JZmJCbWZwUnRMa1pVVmJDWXlOWHQrSEFt?=
 =?utf-8?B?Sm42WVdnWUQrM0hadDRWcExYc3J5UyswQUsycUFyd3daQXh2czlHUmxBb21u?=
 =?utf-8?B?QkJzNWprdTZVVXVFV2tQOHFHZmxvR2lQRkZaaXpCdFFGWGgyaStTNW1xbGc0?=
 =?utf-8?B?bUJ5dXlqVjl2ZkcwUDdpUjZ5SWN4RU10THJUS29ud1llTFV4VEU0RklxbEZh?=
 =?utf-8?B?ZWNFbjJhNklHeEJmcHJEWlpPQmRQbEdRMyt5a1l0QjBGK25Xd1FWUmxNMUE2?=
 =?utf-8?B?OEpncE12clFOTnhkS2JTYlgvY0Z6dU5vWHJYTm5WelNESWpjeXNIdVd1dnpo?=
 =?utf-8?B?akFxT3pnRnFpWWNiRnFSS2ZJM2VHODNUYVpFYVdPQ3JwWFNmV09SeHBXQVFI?=
 =?utf-8?B?NFNPNTBjelRSRGF2QTQ4ZGNkdUNoVi8xQnJ4WUp0bkdTa052SWYrUy9sUWxE?=
 =?utf-8?B?cUdmYVhiUmprL0VUaC9PekQxTDFPVnhPdEtNVk04b1lVUzhXQXdrUVBpenFU?=
 =?utf-8?B?bWY0Q2hEcGdRaUlnSjdBY2d4Z2hwWU5TYU9LMnhFQU44QkVscDhodFduMnVu?=
 =?utf-8?B?L1NxcHFzKzRDd2xDK2pRa3JMNEZrY1kxVUgwZnVXRzNSOEkzdERYVzBBaE5n?=
 =?utf-8?B?VHVnVDlSVXdFRTRaa2tORlNNNXhKVlhOZTZOUHFudkU0ZE9iSjdNOExlRkcr?=
 =?utf-8?B?VERtTVFsWmpoS2NSdUpYMDFMMFhCcmdCSEtMUzFDb29VS25OcjVPQm11VThU?=
 =?utf-8?B?M3g1a2pTWXdIcndOdzNlcnhRL2ZoSUJnSXcvdGhwWnJxWWlVNVJVenpoNWkw?=
 =?utf-8?B?dnVCbThXaFl3aTBmYWFXVjFYckZhWnkya1d5QnphUElmazdKSEFwRXRoakVY?=
 =?utf-8?B?OENsNUNmSkU0cDhFU3NGWDhqZW81UC9RaklwZ3Y2d3FMZUlJYnJEQ1NFem5m?=
 =?utf-8?B?VjYrcTNLUGtrcXZGczVTNzFFcTg2UnFjMm0wdkNtdUxCcFliT0ErWG1mSEpM?=
 =?utf-8?B?YUMwZklDaFNSelNUZFhzd3ZveTM0cTZuSFdzVjRrM2E1QVRDRDZ3R1A0Z0x1?=
 =?utf-8?B?Tk5RclBYQmhyamNnVjBqakRGSXpqQUhIRS9UM3BEMU9nVnpRR2tDNEYvdThk?=
 =?utf-8?B?Z0JLSFlLdUlBMEJKVDZlbjlJR0tXZ3AwVC9aZ3o2QzV2TWhRK0FMQ283blZv?=
 =?utf-8?B?WHBsV3VsU0dZaUd6K2p6bkpFa3B3dXloUG0yRFFhdHdjU0FJZy9oWGN3T2l5?=
 =?utf-8?B?SUV4SW5mQkVFMUtoVUt6bXAvYzdjc1JrenFDSjFkN281SEVRNThWQmtqWjQr?=
 =?utf-8?B?TkNzNEloRVVvQUthWXRLVExDaDBuRWFqbHFrZ2hXWVJVcWFGZnV2K2U4VHFQ?=
 =?utf-8?B?TFBObDZad3p6SjFRWEV2dVRRSjViaHBLQWREbTY0ZS9XdWpxcndMRitkZ1Iw?=
 =?utf-8?B?R0g2OW5xZTZUdmZwSWRJaHgyVnRDYlRsKzQ5My90cGRSOHRRMTZSWEFZeVZh?=
 =?utf-8?B?dmJMU3YwMm9MdnJUMXUrNVdmVVRHbmIyYk9RVHBDZFZ2cjVwcWlxeVFRUnJI?=
 =?utf-8?B?a21ZUENuaFdMNjlDenFZNlJMV3FlNkdiU3FadUFmcXJhYzRWZ1hpSllWR2p6?=
 =?utf-8?B?T0N0MTgzRERMRmlGOE1VZ0xqZ2xZbHhmd09CSjBvblFZSVdxQm1XVjdReWw0?=
 =?utf-8?B?V3FUVEQyRDV5N3pONzVBVHFyKzk0eDhUVE11Skp0TUg0OGVvZVhGQ2R3MTQ3?=
 =?utf-8?B?Y1JSMkxKbjk4MENUSHhpRFVSWHF1MU9nbVZEWHlEZkVEOGg5RUZTcGNZeUx4?=
 =?utf-8?B?V0JGUWw0TVFTZDl2QWo5T0xuNGlPNUZEcE1lZ2VFTWJacEp1TU91cTV1U2dM?=
 =?utf-8?B?SmRlVk1scjBvcWxJWUZSRFhlN3d6cTNXQ3lONjhxQ3RSb1haWlJiT3ZpQ2Js?=
 =?utf-8?B?a3g3YVl3alRVaDVCdkpwK2M3WWtZTCtIeHlXc085TUE1NzE1NnlnUXZsR1VM?=
 =?utf-8?B?NkN3bFg2bjV5MldIWWpBbWx5cHlQM01TNXNoSzl3dzRsUTk0alFuZmR4OCt5?=
 =?utf-8?B?V05nMkZDaFc2WUlBODVMeGYzck9nb2lJMTZIMWZVK3FCRTJpYy80MmtaZk1M?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d0ec1e-8a54-45a0-e507-08db7df0b131
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:14:52.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi69O8Ls4Bv1Iaigt5SfjdURL9VlGvDk7Mv+6oAzhMEHacv1g2T3u1o+3P1cPJYzrVjqtytr98r/vlDiVDyY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6525

On 05.07.23 08:38, Florian Bezdeka wrote:
> Introducing a new type sched_param_ex64. All members are (always) based
> on time64_t. All internal APIs have been migrated now. Existing compat
> and native system call entry points will do the necessary translation.
> 
> This is a preparation step for introducing time64_t based cobalt thread
> cobalt services.

One "cobalt" too much here, I would say.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

