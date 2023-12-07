Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1B36C
	for <xenomai@lists.linux.dev>; Thu,  7 Dec 2023 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OZ8eRdyq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTFUr3OL698VZzr7DPj2KnqHhFlJgkueQwyEjxwogsi08c1h0HjzcuqsQOhZ8BelG7+afZwep33xM9OWy06ia4yui/wv/fQ5Aqa5jeMmvdJWb0XzvyD49GKdwfkEKs79LlGtv/wubwlkIWlgrK0XzGgVKPu5Z7S5pLa6VHNyCuYcXfUh0uhFwnpXSdBe4mN5dKvDPxxyaLHi181WuSYW5yINFAJTfgWv3MoaBvzyYkJW/yqxsn9rAdgqoj5qmGOPG98MIMC2EkXb0RmFoJayycezK+5h9fSI1ke4bqCEAULQ0doSO39fp0ahAIqHa2kBPVAI5IWnJc6FpBV6RAiKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZthgtlc+GnX1Q0D3jAFzxtEb64Uck3FeRlUID70K/k=;
 b=bke30mLsANP8ZbbMKghe+c0A+v1dB713vQJewWlar1OoDq/jYx36bE3Grrl31qzzdSJT9VPwhz2ySr625t/v5unIUnIZWIZSl8/rRvpX6HY20ZU0qQ2XN/kD8691NbUIkkSBhtKe0tPtcJv8z1gY98m9Sao1sHfy65ek9nC0ntxV8wm+CUklfGcvgvkkscHcEHsCzT5UUaXUIBjXP4dp0ydF4LD9UPGT7khQpbL0wJvJ9jrm6d0BrFWn2C6TWtRcuITQyKufgl46v0pR+Ogj2nODmQCdhaWv7ym/Q+Y9avh2JRNKXl09G0bAPcbzPoz05LfETzeD6b4mHyqBrwRU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZthgtlc+GnX1Q0D3jAFzxtEb64Uck3FeRlUID70K/k=;
 b=OZ8eRdyqg3XNt5RbLa97ErzRQvd/ihoFCUw89rI6n1UhOGw2ovysZ4XH+xxQOOfuNej5agK6f2RRSJpJiInraiZS7O0xUyzePVdH2I5kae6CHv+T0CyJMwTPll1Ow30k3JLd0hz0azKScd/lRUjT8gpnwoceEB1Zev+1z7lQ0mQHDshTHTuqACId3UGNyQ8K5k3jLHVrKn4CYqFS4zJP9EyHHMBDSCLRjxjnA/eQZ08QQs5h/+93yQcpMkRSiY3CZy8qOdKE1lbILPqftQbsIoVaLJ7ZEVSX+RxcPHmL4jE0mbrAtWVovrNaLr1Xo5LhHNqwv2/WM9rWQcDIpYWDhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Thu, 7 Dec
 2023 02:37:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 02:37:36 +0000
Message-ID: <5c6e7f95-dccd-4ddd-840b-32ddb343adbd@siemens.com>
Date: Thu, 7 Dec 2023 11:37:19 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Migration to ARRAY_SIZE() and further include
 cleanups
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e7fe0d-0729-464a-d303-08dbf6cd7879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CUyIcYRuJX3yK75D0bJgPcvOaep4iGxSiwbTPoSwjkyPsInsGoAqRhv5bmgMNnwNt0kMJWOjgY0529QjUHlnq/hGi5b/x01AO6PWsTI0E7N3noy7cayvnykBBK85bUwE6xui++cy4Noeu8KjhiAPxsN+EUFu19NIophcNGSd5QH4sYRr+j6kEZAWZ9I89yLVU486X0CrtcIB9zUKwB0kq2mKPLohqDuUMx/IsAoyd0tenIjL9Ax2nCFSTIqheVgvMmKOcihS14w6v/lG1kfKfbAWDnvtFkA6SV75woqtBwUg67zwBCbom+1INf1RPYX8TqfJ71iB/kxq1OZtGJ921LmyCqYLO7dTP3XibzYTNEWnzhqa0A5kZQuTPs6hOgR9MBzn5SrCq8btHVTxPTGg3rq8qtW5EYYbqtABCaBZUS9dEXWDAN/kdM3cxWbR3jAxy6wApytx768WVlclXVGVJrgH/VAfZc9ccGsaFU2l4NDyo8AdnK+pTUiMYbYUF4qBzlCtddB1so/iOOEZ8jyUB2Lqf3R01uALdOslpYRUNB9M730zUq2EKkmGpDa75l4oOImz5l+iJaNF9HoBRMvN3RsNsLUd8mQpj0UwKyN+bhwO80tsTyDswYUchc6Gm6En0hn3WVvTtMvm9j853iwcglix1PnBbb0ZXUM30SVu/HN+ltTVm/8mCRTMaszmm/a6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(82960400001)(31696002)(86362001)(38100700002)(36756003)(478600001)(66556008)(66946007)(41300700001)(2616005)(26005)(5660300002)(6512007)(2906002)(53546011)(6486002)(6666004)(8676002)(8936002)(6506007)(31686004)(44832011)(66476007)(83380400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVRINjRocnY5MmNDZGthUVNEV0x0cXJQRlRtbkVZbnIwSjJKUHhya2xWN3hV?=
 =?utf-8?B?clBNZDRnSEJPU3M3YlNQOU5DTnd4YmVualNGYjhFWThSYlNOeTFVUGRZZlVU?=
 =?utf-8?B?YXF6UmVsTVorWEpDTktrWEdMcW5GMDMvODhZSy82T2w0YTRuVlBwZjh1SkZN?=
 =?utf-8?B?QjJVSDdPTEZyWlJWeUdlQ1dFSkRIRHhTQnJVak1Ub0EzbmtSQlh0cTQ1bVNa?=
 =?utf-8?B?TzhmQkY0U2FUSDVKVnpnU0VYbWlKbUpUZE13aFltWVFYTkR1Mjk3bmFhYWJH?=
 =?utf-8?B?ZzFUcEd1U1F4YU9QUStGZ0NkWUlEamszaVFWdXR2T3NYaFEwM292VmhPUkRC?=
 =?utf-8?B?aUVscHRoVTlidW1YTnJLeUJRVDkwZjRSV3FsYnVpYW5kTU5XNUFEM0RQZnFi?=
 =?utf-8?B?Q2U2K3BQbkFOZW9TR3U1bFh6NDNuZXZSRWRRN21FUWNjWW1uOHJvSFFreW05?=
 =?utf-8?B?elZWcjhrY1hqdDlFWDlPbS9JY21mVlREWmY5ekF0Z1B5MWdtdnkvaWlESUs4?=
 =?utf-8?B?bXllYktLOCtXSzVYZ2gxYkR1ZFJLZVFvNit1eEYrdmpkcmtRbzgxVk1Wdnlz?=
 =?utf-8?B?NlkydWpXS2VTMzBkK21CbkFPVkFSc2lpLzJMQWdzYUdEcWRsMDJpZzFtSGRi?=
 =?utf-8?B?VkJXU3F1QkZRMk1qOVF2Q3RDWHBuNitacTVXWXFCSG9BSDhqMHV0UmVSTWUx?=
 =?utf-8?B?Mnk3bktrNktnQUJkd1NwakdJbTdQS0ZUSXBFM2tTZHBIelN4dC9kaTh4ank5?=
 =?utf-8?B?NXE3ZE5IUzRkcW4zRjNJTDFkamt1ckJGQUdLNXhKSlJwc3dzUG9uamNJMStB?=
 =?utf-8?B?b2dQQ3k5N3IxZFlMRDlRUHFScG1FVnRXSnV0NmlWSCs2VUlZQXdaNUpaRVRq?=
 =?utf-8?B?djAyb0VIWVBZZXREWG1udDhWdzgyVjU2OVk5ZGhqWE5wcCtGUDR1RmxUcWZr?=
 =?utf-8?B?eHhmOExZcTEzaDcvQjh1aWhiWTliZFFQRnljOVRBMlJwU05EVEgyM2wwWExQ?=
 =?utf-8?B?Z3JYNHJrOGxlUkRIR0RlNHo5KytLamh2UXdQaGVpUkZFNG16U1kxVE5tU0tu?=
 =?utf-8?B?THd0cVc4MVVnVTQ3WXRGTlZKdzVINHJTV3RIWWI4R2pHalg3T0tiZjJCaXcx?=
 =?utf-8?B?YWZsSzU0YlQxbzQxbzZxdWd4RFl4aFIvOE1QRVZ6TlhIL0srQkJHZHRIUFkz?=
 =?utf-8?B?VjNWeGZUSUJLamlSQXltYXg0V1FOamdSejdqazFvVVpmTE5QY0hGME93NUJ3?=
 =?utf-8?B?RXNyci9tRzdnYTl0Slo0NEtlMGFOM1dldXlFTzlGdldKS2tMYXZGK1VkaDRX?=
 =?utf-8?B?RFJwTE5TaW9udnJiWjVLd2pLalF2UjV2OTFRZ2lhWTc4RUF3RGx4MU1qWUhV?=
 =?utf-8?B?VHVZS3hGZXYwbFpmd0Z3YnJwRnpoYjZxS0NjSWpBTHNIUE5GTnQzZ1FWVWdq?=
 =?utf-8?B?MjF6MjYwbndTNWVYRENJalVCUVNOY2lNNWwwUXNhUmZ3bVNmYm5FU0N2OTlO?=
 =?utf-8?B?dTNQeVZWREZrblE2a3JSQVVqZ1BFeTRjdE1NanNLVkNYVVpoZjJvZjV2dnY4?=
 =?utf-8?B?M3VXdjRXSTFzWHNFNHBPcnFsOE1lU1h0aVlSTlhjS3pXN2huVGpsZk05VzNu?=
 =?utf-8?B?RnlvTWp5NU5HL05vY01SRzY0ZC9yNjN3aWwzVVR5Q0RxVlpUcDl6eGhVSFow?=
 =?utf-8?B?TndtSFQxcWZSTVg5VFZkZlA0Vm8yMVRjVHVGVmc4ZTBQK2JxSlBpbkRROW9K?=
 =?utf-8?B?QXlJdEJqSWdvVFJldG9NTWRSV0dJL0V6K0lsOXllVUJuQjRITFQrSXFZRCsy?=
 =?utf-8?B?NmEzckpEY2pyRUJGaVJRV3FKR1d0d1BDSC9YZVNkckJuZS84MCtERFlFcERQ?=
 =?utf-8?B?RFJzNWxxSkhxcFBtRldtREZQOEprdUR5TE9NSGF4Um9HUWJIcXZkQXcwS0cy?=
 =?utf-8?B?TnU5NjNkQVdrTm9WMG1LSDk0eXE1SjEvbldrRUY4VmNMMmtVYkljTU5QNlFY?=
 =?utf-8?B?Z1FUbDNMS1hHWjBJTWRYdkpsZE9wV0Jkd3l2eDhPR1JaVFowKy9Yd2h0WGNx?=
 =?utf-8?B?TlViUzBtcDA5OWxKZ3ZaVVc2ZTM0KzFzbFd2cjVGYktvaC9nZHBUV2dlaEcx?=
 =?utf-8?Q?JPTPluWqAZdc4hJyAfmDjbEfh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e7fe0d-0729-464a-d303-08dbf6cd7879
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 02:37:35.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1fk6MPTF6AWygQfgCfj4Wn2hkhwO1T4hYvLJaIix0tBEQnjQMUaxGQ1he2OpfNR6F7o7qNJcLFSxLy17paOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6902

On 05.12.23 20:41, Florian Bezdeka wrote:
> Hi all,
> 
> Warning, this is high altitute work ;-). I had some time on my flight back
> from New Zealand, so review carefully.
> 

Then let's only check this while doing something similar (on my route
back from Tokyo) :p

Jan

> Everything is compile tested and passed our internal CI already - as
> usual.
> 
> I'm trying to address some comments / further cleanups mentioned by Jan
> during the last testsuite cleanup series.
> 
> Best regards,
> Florian
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (13):
>       testsuite: Migrate to ARRAY_SIZE()
>       demo: Migrate to ARRAY_SIZE()
>       lib: Migrate to ARRAY_SIZE()
>       kernel/drivers: Mirate to ARRAY_SIZE()
>       demo: Cleanup includes
>       lib/alchemy: Cleanup includes
>       lib/analogy: Cleanup includes
>       lib/boilerplate: Cleanup includes
>       lib/copperplate: Cleanup includes
>       lib/psos: Cleanup includes
>       lib/smokey: Cleanup includes
>       lib/trank: Cleanup includes
>       lib/vxworks: Cleanup includes
> 
>  demo/alchemy/altency.c                                   |  2 +-
>  demo/alchemy/cobalt/cross-link.c                         |  3 +--
>  demo/posix/cobalt/bufp-label.c                           |  5 ++++-
>  demo/posix/cobalt/bufp-readwrite.c                       |  5 ++++-
>  demo/posix/cobalt/can-rtt.c                              |  2 --
>  demo/posix/cobalt/eth_p_all.c                            |  2 --
>  demo/posix/cobalt/gpiopwm.c                              |  3 ---
>  demo/posix/cobalt/iddp-label.c                           |  5 ++++-
>  demo/posix/cobalt/iddp-sendrecv.c                        |  5 ++++-
>  demo/posix/cobalt/xddp-echo.c                            |  5 ++++-
>  demo/posix/cobalt/xddp-label.c                           |  5 ++++-
>  demo/posix/cobalt/xddp-stream.c                          |  5 ++++-
>  demo/posix/cyclictest/cyclictest.c                       |  6 +++---
>  include/smokey/smokey.h                                  |  2 +-
>  kernel/drivers/analogy/national_instruments/mio_common.c |  6 ++----
>  kernel/drivers/analogy/national_instruments/ni_670x.c    |  2 +-
>  kernel/drivers/analogy/national_instruments/ni_stc.h     |  4 ++--
>  kernel/drivers/analogy/national_instruments/pcimio.c     |  2 +-
>  .../net/drivers/experimental/e1000/e1000_80003es2lan.c   |  3 +--
>  .../drivers/net/drivers/experimental/e1000/e1000_82541.c |  3 +--
>  .../drivers/net/drivers/experimental/e1000/e1000_phy.c   |  6 ++----
>  kernel/drivers/net/drivers/igb/e1000_phy.c               |  6 ++----
>  lib/alchemy/alarm.c                                      |  2 +-
>  lib/alchemy/buffer.c                                     |  2 +-
>  lib/alchemy/cond.c                                       |  2 +-
>  lib/alchemy/event.c                                      |  2 +-
>  lib/alchemy/heap.c                                       |  1 -
>  lib/alchemy/init.c                                       |  3 +--
>  lib/alchemy/internal.c                                   |  2 --
>  lib/alchemy/mutex.c                                      |  2 +-
>  lib/alchemy/pipe.c                                       |  3 ++-
>  lib/alchemy/queue.c                                      |  2 +-
>  lib/alchemy/sem.c                                        |  1 -
>  lib/alchemy/task.c                                       |  2 +-
>  lib/analogy/calibration.c                                |  2 +-
>  lib/analogy/descriptor.c                                 |  1 -
>  lib/analogy/math.c                                       |  1 -
>  lib/analogy/range.c                                      |  1 -
>  lib/boilerplate/ancillaries.c                            |  8 +++-----
>  lib/boilerplate/avl.c                                    |  1 +
>  lib/boilerplate/debug.c                                  |  7 ++-----
>  lib/boilerplate/hash.c                                   |  2 +-
>  lib/boilerplate/heapmem.c                                |  5 ++---
>  lib/boilerplate/iniparser/dictionary.c                   |  1 -
>  lib/boilerplate/init/bootstrap.c                         |  1 +
>  lib/boilerplate/setup.c                                  |  7 +++----
>  lib/boilerplate/time.c                                   |  1 +
>  lib/boilerplate/version.c                                |  1 +
>  lib/cobalt/mutex.c                                       |  2 +-
>  lib/cobalt/sigshadow.c                                   |  2 +-
>  lib/copperplate/clockobj.c                               |  4 ----
>  lib/copperplate/cluster.c                                |  3 ---
>  lib/copperplate/eventobj.c                               |  2 --
>  lib/copperplate/heapobj-heapmem.c                        |  7 +++++--
>  lib/copperplate/init.c                                   |  4 +---
>  lib/copperplate/internal.c                               |  4 ++--
>  lib/copperplate/syncobj.c                                |  2 --
>  lib/copperplate/threadobj.c                              |  1 +
>  lib/copperplate/traceobj.c                               |  1 +
>  lib/psos/init.c                                          |  8 ++------
>  lib/psos/pt.c                                            |  5 +----
>  lib/psos/queue.c                                         |  7 +------
>  lib/psos/rn.c                                            |  5 +----
>  lib/psos/sem.c                                           |  4 +---
>  lib/psos/task.c                                          |  5 +----
>  lib/psos/tm.c                                            |  3 ---
>  lib/smokey/helpers.c                                     |  1 +
>  lib/smokey/init.c                                        |  8 +++-----
>  lib/trank/init.c                                         |  1 +
>  lib/trank/internal.c                                     |  4 ++--
>  lib/vxworks/errnoLib.c                                   |  1 +
>  lib/vxworks/init.c                                       |  3 ++-
>  lib/vxworks/kernLib.c                                    |  1 +
>  lib/vxworks/memPartLib.c                                 |  1 +
>  lib/vxworks/msgQLib.c                                    |  1 +
>  lib/vxworks/rngLib.c                                     |  1 +
>  lib/vxworks/semLib.c                                     |  1 +
>  lib/vxworks/sysLib.c                                     |  4 ++--
>  lib/vxworks/taskHookLib.c                                |  2 ++
>  lib/vxworks/taskInfo.c                                   |  1 +
>  lib/vxworks/taskLib.c                                    |  6 ------
>  lib/vxworks/tickLib.c                                    |  6 +-----
>  lib/vxworks/wdLib.c                                      |  1 +
>  testsuite/smokey/alchemytests/mq-1.c                     |  3 ++-
>  testsuite/smokey/alchemytests/mq-2.c                     |  3 ++-
>  testsuite/smokey/net_common/server.c                     |  8 ++++----
>  testsuite/smokey/net_common/setup.c                      |  2 +-
>  testsuite/smokey/posix-select/posix-select.c             |  4 ++--
>  testsuite/smokey/vxworkstests/msgQ-1.c                   |  3 ++-
>  testsuite/smokey/vxworkstests/msgQ-2.c                   |  3 ++-
>  testsuite/switchtest/switchtest.c                        | 16 ++++++++--------
>  91 files changed, 136 insertions(+), 168 deletions(-)
> ---
> base-commit: ed69c34214f9fcf57b459e701ed4f65f6753bb8c
> change-id: 20231201-flo-array-size-f30df8dd25e9
> 
> Best regards,

-- 
Siemens AG, Technology
Linux Expert Center

