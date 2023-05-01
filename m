Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFF20E2
	for <xenomai@lists.linux.dev>; Mon,  1 May 2023 12:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxaNJjCs7EhreaQmH/NDNJTsoLo1zUCZw7/APcXiOXno/Q1PN5qa41KQ9YGp3vMml/paZwG1PgzSDedsh3kllgNgPTRYp7+gnvAR1NDYPw76lD/fxva1TYJT0Bs4aLOa5HYYaAO9he8LwUzf0H3ZgNMLPCWCDedkHFSJutwXNiG3ecijbgbTjDq2UWMcV/W7r18MQ6+hfX8q1O8kCjqz4izsR0+MRgWXA+Kc9U6tz/uriP2eR93ixkAlp7sg5wpW+GldjxhQw9YmiG5kmHJRaK4Y/OdbzpZOg5F7FE4kC7cHqC1GThcMl0FeJjc/d7L5pWRTGv3IQgRK46YgOCshdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEzqf6hL8Yu/XZAJ3sz/SjmscOSLXwLvuSL6w+72HQE=;
 b=TltAkUdBtl7Xh1sJKoIDi1JjJ2Iix0+kas9b3Re2qpOWtwtLB1gh8H5lGoG3PI4yP2VZ+o6wRthEeO0IazfO8RKKBEA11hWvvQTIc0uUNMSn02C8O+7Odi4ZEIdrtGFuiXDrCOCFKCj1j6bbqrcVKRydw1fjVE3cq/LxUIMrp9b/mHpBtlSZ6CBDXAnNggcqvu/bLhye8hoBmG2Bl+0O2cQE2EMiMtixR8MptYRK4cbHysjMPI2XZepaBGSOq6Cc9XFCauFmXR9T+o2Hne4uqlZQA3DjoOFQdCuvHCVmp/Qb6Q075Yw/OVanWqZZ/V0SLbWwlZl5ip5uRZeZ3ltRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEzqf6hL8Yu/XZAJ3sz/SjmscOSLXwLvuSL6w+72HQE=;
 b=Etf1eRC//xA1A6Alvz5oRvhVjLVOeJOP1jQ8/jB4T7cv99zShREVuV4Q6v7ZAezfaR0hVEVsxVC57JpQdxeg9DktYPoy+yewv6ySl9QBpW+2kefneCbREoNsh8/8Oq9PBkrPC8RpqQJaTqlr/FOx9cTJdL4WewnvGJKl7WwArgGIi8Aq9+aFjdM7bywmB8OlnHdYHFHzx1szFWnRHctEatGWyB2Zo7p3eJk1FxRChqRFyz0KcNc0khXR3VlMuOr5hg4q9Q7CNKe+A3mm8Tzw0Dre9cGi8x4lLUfAgw3ZgRwZXZRsyhCDmQY085Ml7ossbx7sQNVsk+R8XeKvfCK0eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:91::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 12:03:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.029; Mon, 1 May 2023
 12:03:21 +0000
Message-ID: <9f027e6c-9719-c643-cd48-8e42ed5dfe75@siemens.com>
Date: Mon, 1 May 2023 14:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.3 released
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: d1676cf2-afbe-4600-17e9-08db4a3c0ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1w/5fwadwZPZYxk+3PjhY9ToYdRnFAMoBVbJtOIjU4b7CQN63PdE9UiuLmH5KJShjZDUBwo7gTj5MnxuoAUQ90rNVbxVtxG/ybsjySDGn3cxYs5dO4xhr1qpEeDcpeExGUwyZ3xBsQvgCWjU9cunqmhNcnibEZRmDkAD5pzMF8LsOsZdN0sCYKVeDaHUTW+o7b4P46iZ33TB2AnQM5yekdW9l9TEJiE0LaPbeSozHMchdfa09YFvXCQRuvdXLfGshLmtQurnX1eRUeOIZPKcwCQBp+NWAzDRjjO2/BGl2DxhVohjY1l6IDmI4zls+S6et/C0jTkfZ82pvZ7xcqg/RkEGpr5Tb7+dC3JSXSTbyr3ATe2nXd87Ksm9069vVzXD+uDgpynQWGFHRoaicDHYc4WUhrjDSBZbefQnVirzdD4ArX4I5utu1sVwAo1z4v+qnXyXKc3FmrRaNuP/i1eJNx4QkC2sQeayTP9uVRESnaaRMMgT07JCqJRyLARFT8BDT6S2cNYTiqc7EaupdNywP/23Ddiuym/WFrKWVPHGiu670E3ccLzB5e+crijDqADsd22L2eWe8VTB+YD+DPhMjQKlESEHaY1rv3fhgL+MU5gOZF8E3eb5mtipM4aJAEM0Yu3Ejif44/PyQoNaW1ZfhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(2906002)(478600001)(66476007)(66946007)(41300700001)(6916009)(66556008)(316002)(5660300002)(8676002)(8936002)(44832011)(38100700002)(6512007)(6506007)(82960400001)(83380400001)(2616005)(31686004)(31696002)(36756003)(86362001)(966005)(6486002)(6666004)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWd2ek1QQ1VveFlvQTBjSVJNOXNiWW5udk1ua2EzME90TGFhVktCMkRWRTJD?=
 =?utf-8?B?QThFOTNCZVRVeUJNS1phak9JSldyVnZLSFR1UzJKWUZMamI2V3I1UDFPVTdw?=
 =?utf-8?B?ZkVsVzJQYVhodFJMMkRZWVlFbXcrZnEzN1E0VnBwdnE3dWs3L2VVQjdtNGp0?=
 =?utf-8?B?RXcxWmgrYWxPM3Q5WWJqaS96dExLRFI2eTJua0JyYmJLM3Y1Mm15YWhFZE1j?=
 =?utf-8?B?bHFlMnRlekxhTDg4b1dVZWN1SGtTRUtxVHpsVXpiRlhVMGFzeG94b0o5ZmJa?=
 =?utf-8?B?ZlNXanRzdEN1TmV4MDBNKzQ4emlpTW1od29hTmMrazVwQVoycHhLbUllN1gw?=
 =?utf-8?B?S1VyVjZpcmU3NWZjWnZiTktwVkRub1NvQ1ZVTjB0T2VqeWZFcXBvc29jcGFN?=
 =?utf-8?B?SmNZS1NoN3MrRkZpc3I0K05ZYjNZcmVQY0p1S2tzSjZjQ1VmbS9Uc1RpY2pK?=
 =?utf-8?B?ZEVXeGlpNWFvWURrWmVPYWU4RTA1am5Xa1hFblhFc2N0V0FpbmJNUU1FUGJH?=
 =?utf-8?B?RHpkU2FIZFJjampwZ01BYUFlVi9vQ1p2eE93U3Z4dXJZZStiTEt1eG90a2tw?=
 =?utf-8?B?NTdvZlk3L2ZVS2liNGVuMWphT2RUMnF2NXkyM0RDb2cwaHowUjBFR3hEMVcw?=
 =?utf-8?B?RFJkTGZWZDRoNXU2ZWpzaGh5clNsa3ZHbFgvZnBLTTliK1JOMUlweU5EOUI0?=
 =?utf-8?B?TUtRRHJHdEMwM3FiVU9vSG92WjhJNWVmdksxV3VMZFpJcWpCZlR3azdXUFRZ?=
 =?utf-8?B?TE9hOEZUWjEzOU1tUk1xRlhzYjBZOVJxNGJCUUhYMmVXeHUrVGZpUE9qcGpy?=
 =?utf-8?B?Q2Q3ZXRiRSs5ODNrd25TKzIveFo1Q0JZck5yY0xQRWJoejFCd0xrY2VJcDBn?=
 =?utf-8?B?VHQxTmQ2RG9SQ0Y1WlF0OTRaUG42cE9Dc21ENlhNcHRIbnYvckgvQk5SWkt5?=
 =?utf-8?B?ZlVZTmxwVW9xdzNxV3ltbk5pd3ZKdjhKTTg1R3hQRTNPK3d3TmFzZkNQWktQ?=
 =?utf-8?B?Sk5CeTUzNDZOTGRWWHVOL3VNNE9zaDFjVzE5RHlLM2dIQzB5ejJ4OFIwN0NJ?=
 =?utf-8?B?b052TFhyM05ROHdIa3h2U0liaFYyWkN0aVdMMHBwL0hURE8zNU5TWGFWNlVm?=
 =?utf-8?B?UXBUY2dESVNsQjZ0dy9NVERpREVkUzJMQ0pCSWZkS0xweTF3Q09pblAxK2I0?=
 =?utf-8?B?K2IrWjFINE8rVXBTNFQrUTZGVlhQaDM4bjlXSjJnZzZ6RHplbTdmOHBiaTRU?=
 =?utf-8?B?SU9VTTU3b25hSUoxU1JQa0wvVlJoWkFvVFJ0MmNNZ3hpelZzNGk5amNMOGNG?=
 =?utf-8?B?L0ZWVXN5dVlYMnNVOGdxNk94ZUNvaEEyMDJJNlJiMUNNbHFtNnZjb1k2d2dn?=
 =?utf-8?B?cmh3WW9HYmFvaExmZHZuVEhGcWhaVFVQOVlDeFdYZjIxYzNaT1BEbFF0MnlI?=
 =?utf-8?B?UE44cmkvampXdFMrckF4QzNYRU9Ba1VvbjRacnhFbDBHZXVjbmdZZXNMMjVi?=
 =?utf-8?B?T1cweG9wOFpoclNteUNaQWE3Wm9zTEp0c0dxSFRBSTZvTUFOUEFOU0lEelJk?=
 =?utf-8?B?OU8rc3VXa0RXUUVNcHUrMVlaMGhicStlR2haOElVWkMxZFRoKzdOamVJaloz?=
 =?utf-8?B?b3owcEV3MGJaNjBCR01iQUJWS252NmtGbzBKSzVJN1Zjcm1FTXFYb0FCR2lN?=
 =?utf-8?B?aTBmTG9UZzlIKzNnOFhaT3dlSlFHMjdqQVBRT0U5WEpndGdyWHdURWJTS01V?=
 =?utf-8?B?RHFzYWJsVUJMdG4vcXE1WW5jWTQza2JwRWRISUxvaC9yMmhmSzIwc1QwN2VO?=
 =?utf-8?B?U3RyMGNBWGdXNUpOd05tcmNOdE9VQzl5Vy8rZEt5TFlPRGhROEcvYitmVDc2?=
 =?utf-8?B?MlliOHYrWVNGR3QxT3EydmZNUVpmMjVyR3k3M3RhV0ZwSDJzam1PZnlvVmg5?=
 =?utf-8?B?TTV1aEwvaStEVk5ocExkNDdnWHdyQVZrRkN1MG5UN3hpL0IxS3RmT2srUktv?=
 =?utf-8?B?OFoyaGg1OU41dXQ1QkZGc1QvY2piNGNubVRBbTh6enJJRVkyK1BDQlc2b0JD?=
 =?utf-8?B?VmdKK3JVdHYwTHp0Z0phZGZzNWlzTnZQcmd6aDg4Yms4TW9sUHA4K0ZMRFJu?=
 =?utf-8?Q?x3N1trpxQ22qDvCmUZc8HTD5V?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1676cf2-afbe-4600-17e9-08db4a3c0ee7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 12:03:21.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BT4rO3+LvRjkihxgVACJKrL1m2yx3KZ3wcv3sNcKgf6oUVVrdl/9wWQu06UCbk0bbvqhU8GaF5BldKqLWw1Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6219

Labor day, so let's do some work and tag a few stable versions. This one 
is for the 3.2 series.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.2.3/xenomai-v3.2.3.tar.bz2

Changes since 3.2.2:

Florian Bezdeka (9):
      y2038: posix/mqueue: Fix compat case for mq_timedreceive64
      y2038: cobalt: rtdm/fd: Take care of compat mode for recvmmsg64
      y2038: cobalt: posix/signal: Take care of compat mode for sigtimedwait64
      rtnet: Enable compat ioctl interface
      cobalt/rtdm/fd: Adding helpers for handling compat affected data structures
      drivers/rtcan: Implement compat support for the rtcan driver
      drivers/net/stack/ipv4/udp: Implement compat support for the udp driver
      testsuite/smokey/sched-quota: Allow building with gcc 12
      lib/cobalt: Fix possible fd leak in __map_umm

Gunter Grau (1):
      net/drivers: Fix out of tree builds for fec driver

Jan Kiszka (16):
      cobalt/x86: Fix FPU switch during thread hardening
      ci: Mark build jobs interruptible
      ci: Switch to native trigger
      Fix several sign-conversion warnings in interface headers
      lib/copperplate: Release main threadobj on exit
      cobalt/debug: Detect DSOs via presence of vm_file
      drivers/net: Remove dead smc91111 driver
      drivers/net: Account for changes to of_get_mac_address in 5.13
      drivers/net: fec: Account for changes of get/set_coalesce ethtool callbacks in 5.15
      drivers/serial: rt_imx_uart: Make it DT-only
      ci: Add 5.15 kernel
      lib/copperplate: Also deregister main thread from registry sysgroup
      automake: Avoid usage of user variables CPPFLAGS and LDFLAGS
      testsuite/smokey/gdb: Skip test if gdb is not available
      lib/copperplate: Add libfuse if building with registry support
      config: Bump version number

Julien Blanc (1):
      cobalt/intr: Fix interrupt request not working on non SMP systems

Richard Weinberger (1):
      alchemy: Correctly translate return value from pthread_mutex_init

Tobias Schaffner (3):
      switchtest: split the set_mode method
      switchtest: test multiple secondary switch cases
      switchtest: test mode switches while in kernel mode

Zqiang (1):
      drivers/net: Make rtskb pool cache being an usercopy source

Thanks to all contributors!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
