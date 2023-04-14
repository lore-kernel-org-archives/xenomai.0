Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184D7C
	for <xenomai@lists.linux.dev>; Fri, 14 Apr 2023 11:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8AHVQY6CwZY52SomEccGXmbpdbyx8GKCikIbJAyjm6Xh2JifN+56zY3dntK5S8IMSkRcnE2PEVZ+vwpUQ4970UypOrd1ahFw+hBYwzi//AuSjAhYc2eD0+JBdqfyozHj0IPnrwcN9RIrRg5Z7O8XSdFZlK91osCszqB4SS2q49TSjsuNzskYyvLWuMoc128ZXxDBe7Pp+D1857+KP2fqUaYPnmCdteuWLN4tHoGcvbczAX98EgogDoDNqVeuu0yBrHLAEcFEwYvAuZsPGdB1VaF3bfuFcJFsT0fx/gIG9ZgMFwZuqZdHqMOgeqWz9Cmz6cBu2dOnSi9JfApebIu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJaaZS+nUjXELl+0SOIycwB6rQ9K0zvIge9EA2yRUi4=;
 b=RnZIphspiueZsFqUYbylYBAvcW1RysufK6+Jmhv+uoPSoCBH0riDQGjCffvefNub2YAk6KRrfic1yohpLcVVPv57fw7R6dG3wOVIG9dOFn4MBW4HzF5zVxLU4I6vVST0cdb51sF0jQGMuJRglnDVdUJb/iIC/6Fh9fUEdwf0IYB9yihQOvCOefm8bPdvlqH3zebhka1BtfqbXN1cP4fux+EkOf6H10Lqdu+JisgCgdJm+MRBQ5MeFII485MdeKtv7Ib45zBanG2zljW9Mx9rHxXlTTanc5tvLQh/RsBi/W39cIhGuaihS83G0s/kHQcwImWUNmFqQ6/MtEah93B7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJaaZS+nUjXELl+0SOIycwB6rQ9K0zvIge9EA2yRUi4=;
 b=NkCPhAX/Ups8vdxx6Km5fYo/g0j/McNAJ9XS+UufqfQxiBvUQPebY8UbuHB9ELdK0hZVqXifOksWYXRnJgfSBah+xdyr9W9uSJtDoggYJhUQ2phHKjLGyMl1ZkzWUMt5+GxjW6Q28WV4QpA8Ttv+eirKjFbFi6wxK65Ccd1UlV8eyijc07DrQElR8k3vw+CURfjeu8pddRAyCDYl7Rg2ovl+ZYbm9i2CtYV4LxRfasj5cFQC2SFK5d9gKDKXzACWgWrj3vfUB/w6cQAxmKqCeIYE67E9YK5/fjIQLFChM5OqcWzkplC+T+zs10ZVGTIoHpL3so57aydAFKnXb2pRIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.7; Fri, 14 Apr
 2023 11:37:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Fri, 14 Apr 2023
 11:37:22 +0000
Message-ID: <d9608046-cbd4-ebd2-c440-d668e47c471f@siemens.com>
Date: Fri, 14 Apr 2023 13:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: tracing: irq_pipeline: skip RCU check if oob
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 39211843-259b-4a69-6f95-08db3cdc9c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HFWiwbQKMjIPLwtpJ9XZwYvtuhcJnfYeALSWoMin0ORk0bHze0RlqMKgM0ST96rsbsRsRtibHKLQVzw1blWz1VCytDcWk4VvyR/V2kQqXAqlTfxeOr1XlA127NsxNL6R5/6C+S4Ayx6ZWIA0MPstzPEZDGExPrwBzA1gycS5T+xrwmQu9eXCY0/thT17S/tWT21nJl4soSw3CQ69OUMXss4LVyAGT7vNjW87K64RwbDRysRSaG47mTh/f3vEfv4aIhAaNv1TehKE00UQfI7S8eG4ATuHvRdAUJ/YdpUIpKt9Mu/liarDfdGxgX86TDbOz7p0DkRA4FmUPVoqkkv5sDbLR3mSsm3dL6o7skwdjRKEGBJHN2HvObBQhI7eC5TNVqmGkOHKaWRnwaIl2/sW7bDy0e+NLDMOtHQMDIb7OrDpFO68xCbDT8ZrNkFcIPoHgM6scQcJqYvr4C0MHBFo52fIvMMY+NqidEhOlRfDIJy7gRLYYhjNkWZlFYzo2tqdOlcbEqnm4vOmlrO2lj+k1Ym6/H5efm1l5wdTAhHnikDwuUZiV2Yc35VehzRkpgshAIWOb5UwwN7zSaaFDpab6Gboi9Lcw27hKt9mFyjeS9uZwRcExUHBuuuTzMliYabtY9KPMFab2w7ksdW2CvcD5SPpuzoZT9jGI0ehM7ejqJqqRaHAQHLHnh1/EHpxDvK4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(26005)(6506007)(6512007)(41300700001)(316002)(110136005)(44832011)(186003)(966005)(6666004)(6486002)(36756003)(8676002)(38100700002)(8936002)(5660300002)(478600001)(31686004)(31696002)(66476007)(86362001)(66946007)(66556008)(2616005)(82960400001)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFY0SEVFRUhBL3YvbDV6UC9Da3lSbXNGTzJOelAxWWZYcjhsZEFhYzBCRHo2?=
 =?utf-8?B?RFQrSGUzRWYxdjQ2Nm0xSUV6TWY3aVpiK29lMlhQL2syK3VFYkdwSzFDVmhq?=
 =?utf-8?B?aTdMQWxWVS9ReHptNHd6ell4U1pkZ1h6K2g0cjlYTTg2RnVUWlZjNEpIeVJ0?=
 =?utf-8?B?ZGdnc1R0Y1lGNkRNL1RYRllid25TeVczaE1QQUxYaXhROXg1aTUyOFg4dkVy?=
 =?utf-8?B?bnAvdnZ2UHFxVVdOV2ZBYjBwK292UFdMbFJiRDFETEZTOFB0Z2dnb25UV3U1?=
 =?utf-8?B?QWxxc0kzdXk3RjRKaEVoNXk5NGdsc2M1SVFUZWMrWDVDNksxUktVUlV0SC9k?=
 =?utf-8?B?V3lYYm9HUlFtNjRET1VLOHVrVEpLd2hxZitOYWhTZ0o1WFEySTRKdlRnNExD?=
 =?utf-8?B?VXpWQUZ4L0VVQkZMeGZNbVFlMy81SW5FVFBWbkdWSmxJbzNXcndNMGNBL2ZG?=
 =?utf-8?B?bURjWXJZOVpQTmd3eGZnMEF2a0I0aS9CUG9NSTFZNk9ENDhXWE1SUXRSK3pK?=
 =?utf-8?B?RGM0MGNSdEZZamNod3ZacFVIOWlZbC9IUnJQcVJEU3ZhbVE5RUNrQ2FxbjZS?=
 =?utf-8?B?NUxTbWdTNFJvVDdGczF2TDlZN1J1UkpjN2cyZjFObXRMcDl6N05aUExJV1VP?=
 =?utf-8?B?bkpRMS9Wa3YyRmV5YjU5UGhCRlFSL1ZuS2pjQWJxQ0hTUng5a0dEZU5tVTFX?=
 =?utf-8?B?MVdXdGVsaDZna253ZXNKR3puZ2podEYrQlpXZ1NEdTF3VDc5WUJ6djVILy95?=
 =?utf-8?B?MlNZckJBNU1tcHNHanczUk9VakYrYkQ0TjBmWUZUQzBiaEF0M0FyekxyT2pa?=
 =?utf-8?B?OTRPeERNODdpc1k0K3N0bDdvaTFoTnR6dDlLY09yTG1JdjAvQzVwODduMkwz?=
 =?utf-8?B?S1dTTFJTT0R5THdFV2VBWEZiY2xvOFE3anQrUWpPUGwxWWpRMUZEbHdJUHhx?=
 =?utf-8?B?OS9GV1MvWTRydG1YYjFWMGhuV0ZaajA4WjdLRUoxY29zQ2s1cENTS2UwQ3Rv?=
 =?utf-8?B?Ui9kQWZSOUdxc1VBREZUb3lxMTlQZ3dXRnVMYk1hTldCMzRsQmwwN01EV2JR?=
 =?utf-8?B?Q2N5ajIwcitMY21aS2xDZDZOSzRibTdFc3RKWW9Xd0RYRUNzMlFNVzFZUDNM?=
 =?utf-8?B?RWl6MFJ1ZCtBWjVXam5Gd3VibWNMYi9XdWYxVzVUaU9HZG1ua0RyTzlHL25F?=
 =?utf-8?B?eE1ORXFNOWs5NWd5cDNmajRMUXprRmZlSUNiQTBReVJWSmErcHIrODNGdHVO?=
 =?utf-8?B?cFk4N3Mvc1k3cGI2RXh3ejhWSFdoSEZaYnQyUStacVByWktrUEUrakw2bi9h?=
 =?utf-8?B?dFJJTjRCQzVSK0ZmSFQ4dlBZNU9BbjdTN1dVNWVpK3BFSXlqM0NCWm83d3JV?=
 =?utf-8?B?Z041dUlWSFBQOTJZMGkxdTJYQ1N1Q044SWl4TEorM2NwSDNDVGEwYWU5R21K?=
 =?utf-8?B?SmEvK2V5aTFqRjZVRURLcU9QUm9vYmZWRmNqcXZ3TDJCa1NPK3Rwa1ZLQ1Ni?=
 =?utf-8?B?TDVCa0pRd0RPUjRlMC9wZ2VSMXRGS0ZDQXVUZ1U1dWxadjgxbDZ2OVZjbHNz?=
 =?utf-8?B?TC96KzA2c3hqdzE5MTNoeWVtY2dqTllGWGh4WjBGbUgrczNQZHBwTVpPWHdj?=
 =?utf-8?B?NU9JSXdhRFNZZ2k4L2ZvNHc5dXJBWk0rbUpuUHJ1M2dZK20vM2RyTEFRTWho?=
 =?utf-8?B?dVNEWmp1QXRlQ1NRTy9NdkpHUDNKMVlTZ280UmoyY01CdjUreUNPWjRmWnM5?=
 =?utf-8?B?eHNHTXZMSC9oMDlYTnM0THl0bzgwUmh6VXh6RFpLcFIxVUNMVzcxYnV5YUo3?=
 =?utf-8?B?RXlTUk5HMTBmM21ZVU1vem1lT29IL1ZvaVlSVGpSSm01YVRNajFBUStnVUJi?=
 =?utf-8?B?R0diMUkwY09uVHVQK256Wjg0bU44aU1HWmxBRlVwR1FYTFAyQVl6aGFXOTZ3?=
 =?utf-8?B?RE5PeUp4c3pOUklnK1JMcHZ2VWMwSlZmTVNUdDZpcXFiajhXRGg0VWRrc1dL?=
 =?utf-8?B?VXFpUW83cjRhTS9qWWd4T0hhbFB4alhEd29oVDZtSFYzQ0NqUVc2ME9zZFh2?=
 =?utf-8?B?VVUxQi84VHVaaWUrV3hobno2MC9oS1AxcGpRMi91NVduaEdqbkg2djdUeUM5?=
 =?utf-8?Q?qNkAWcvPtbz6YHBUqPc4fHb9q?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39211843-259b-4a69-6f95-08db3cdc9c79
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 11:37:22.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDk2C13YQYYDTeDn5Utu4a7T1/NAL3d3jmrdYrniOINW/KyQrvmpOp8tZC0+vITtw7KxewuqLcaMrhNK3HLVTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7209

Hi Philippe,

I just found changes like [1] in dovetail, something I did for I-pipe as
well [2]. But, as I wrote in the I-pipe commit, there it was laziness
combined with carefulness. I don't think we need that laziness at least
in dovetail and fix that issue properly (rcu_nmi_enter/exit on oob
entry/exit?). Or what were your thoughts?

Jan

[1]
https://source.denx.de/Xenomai/linux-dovetail/-/commit/3656186a1d544274bd9a468902d2010b8b67f86c
[2]
https://source.denx.de/Xenomai/ipipe-x86/-/commit/005d9b97b2144b32e92063f40a8d65fe03f6b6eb

-- 
Siemens AG, Technology
Competence Center Embedded Linux
