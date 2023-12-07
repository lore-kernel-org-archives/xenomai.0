Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E56328C7
	for <xenomai@lists.linux.dev>; Thu,  7 Dec 2023 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Z8yI8LpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql+A2wnfspDpD90uP2Gc/NAXDg0c0vJBhg1NrqUb/zZL3Q50JHT2ALZ90+C6RXqnqSgHeCYBVBR59C6HFLKLo4q5uQhbD+qXan+WGmGNnmhoAIpvZuLDTJmeEwTAr5rPtRK0Q9y7ttpTRBYh5nv8pQEViXcV5/8gYpQnJ8qXWJTHFednX0USjQ5jGiVRqW7tOSrFqOP2M2DrJLVXq9EJRCF3oJBLkVFnHqGDGrIs/KenLPfyLZyRyoj3l//G25wNV3s1d46JIgVbjh/HWGPQtql2NUDjfBfIknaM/orG8PaiM9V9BTPq3Lo2ZYmuqwpY0NzjpJkJuGMUHWUfcP7HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMjZQJsGsTCxxMcuSqEze2nPySZ3OJsryKxEt4Nr5JA=;
 b=CKPc4p9qauOiZFJkxNt3YMzTE5jY4ewAQjEA7veQH3lO3jmMMUhk38LEK2IepIAt/g87g5AUn2GFl8eYmidfbfXn3EQDErIj+SNyBBrJUf2l9oiK3uzR4hD5QKrksuR4YIWHx0MyIs+VLd4cZ3j4qEpndUgRPMr+ALOsdB6yF1lYiwpQsbUH86UXv95iQYlk7aFDLak+9n2SvsUXwMr+5XG87w3Dh+uhVrT/WVohzQiSWihnR/YLGRWV/tvqAqHR90gVma1lyNx66IvW7ukaLwhbIkq9bOH1zUVnQg2hi6AYgRtMbgSKzG7LsCiAj0dIPfoxmLAzFBUQYWbUXYSvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMjZQJsGsTCxxMcuSqEze2nPySZ3OJsryKxEt4Nr5JA=;
 b=Z8yI8LpQyDCuwH9ug2l/LrZDbv7sqLERZ4y0RkO7MW54Of9b0X8OsO+FITWR1Y/gkefb/WqVzLjpJScJ4e/3kIFwd9NhEwUk38bh44JZ7co6qevZ1zSXID4Ntl39YWYXMdAlGHMK56o1w0rESc+GmL+vDmbhNkCRg8Y/Lvx5CElcnX1JpKXxWOl9b9DSxjuHTqnS/KxLsexPhdNqWr4VGba+Hlu96zZx12oE/YE147NIMVq6e9faJIGkTdsrpkO6F2AiQbOdHyR+T/Iko6EIH3uWqsnoI/FmqwnJs4lDVzQrIKWEXJuu/yEFcLBC/bpTmJiVwgY0m8TR7vA3DBx+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 09:13:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 09:13:08 +0000
Message-ID: <340d4492-7a49-4249-ad9d-6afc143775f7@siemens.com>
Date: Thu, 7 Dec 2023 10:13:04 +0100
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
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3476:EE_
X-MS-Office365-Filtering-Correlation-Id: cac80415-610c-4bb2-f659-08dbf704ba48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nStwhNBNwKZ7Uk3LVnsfiPkaDzweNnVqCZufWs1bF4yBn0Nz2l6Szl8uvSWO2d9fxi/rqUbxhG8DpdDbZibSfxcIGKsbMRrgvMGv5VKtR40BVb2SLAVbzhZ9bnJLIF6LIh0e2RQEQL6MP/a0qWnXwEXU+zCvxD4sOH7Bk0eowV7kP01+Fo5E8zvGpvRDyHgKbmmUDICw40GJSIQgQISxcqSYxqjNInvakE71Y2tjiT9AfzFKBK/osJx6AW84Sns7hRy0t66HspF/vkmWy3dWq9gCMdv+822drEUd30lbifKqGHw9aZYHjzgE1+6Z42S5vkMI08ku4cd39v3O1SOseVKjpFyS9Kfw7eB+EbRKePiynMaHQhJcbTT5L97Uu+CKIHZDTkKfpUDCSvlrP2TZtdilKXQQZdVV5Z4y7lodUaWLAqHsRIUSpElokxI3f2xIwPP+57SvcgqdvTJ5t0CHwqwSZ0a5NqktCjLjm0HH3DDI6FcNOTt1/0W/ERzbUnDzzw/v0Qjlm4X3UzXq3gQ7FFENiXBvgO/5GMi0Z24BsKIBTNEc/ytxflTSb4gCL6L+R23MlZ7shj2eMmyTxD3UQry+TJPdpkizFE031FrY6ZvoyQG4wdxAJaqXNDP1DieAWy6V8mqoW/p0QuruBXluUVJY3Rtxf7ilfbMNo/8AHxL2opIYJTdywml4tZRGhd3J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(6486002)(82960400001)(38100700002)(478600001)(8936002)(8676002)(36756003)(86362001)(66946007)(316002)(66476007)(66556008)(31696002)(2616005)(83380400001)(26005)(41300700001)(6666004)(6506007)(53546011)(6512007)(44832011)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTZFTFczdnNYcnNGaVkzUU15cGpmWlJETkk3SDUwYmRGU05zbG02MjhqQTgw?=
 =?utf-8?B?eE5laDNsaFFMdmpjMnFndldUdnNBUzJhT0ZSVmxjY0FLYld6RDRHNWFZaS83?=
 =?utf-8?B?Z25ucE5CWk5HelpHdTQ1bTZTSE5PY0M2RnRWc3lrZmZZN0JKd0UwOVNZWmlo?=
 =?utf-8?B?SVdrMFNMbUlINVVVSlFNRDZNZVUxcFAxbjdzZVhRTjVhSXoyY241V3VmeFQ5?=
 =?utf-8?B?RFNIOWczSXh1NDl0dVkrSHZsZWNHSXdER2gvMDN2OXorMCtmRFpqTEhwUERi?=
 =?utf-8?B?VExmeGJZUDZPY0VyUGxiZjBzSDRySzFpd2VOSk83YTd2Q3cya1laT0hUUjJL?=
 =?utf-8?B?NnRETTNKOGJFRWRmR2JKMVlMWnNReEU2a2N4bFRGRVJWcjhFdUVRS2h4Z1Rh?=
 =?utf-8?B?WG8yN21ZUm1tY3Z1cDloYVRkRDMxcmVodVd4ZDBaVngrSWJWU3BwSUpFaGZp?=
 =?utf-8?B?QnVlY2pQT2VGN01qSTZjTVdzNk43cXlHdzJqeXFEQWhYV3BjcHFoejBRTDVi?=
 =?utf-8?B?SkxMVVNEZktYWHBNYm1RbUdGU0lBbk1KY1dnMmFiK25zUS9FeDNMbHJTQkN1?=
 =?utf-8?B?MmZnd3RRZlBTK1k1UXNPR2lCR0NlYTB2Vi9XOXBDaDE3R1dVOVRTYkZsNDFX?=
 =?utf-8?B?VlBxUWwvZURWV0x1ckdCc2pGYlN6UUQvZDFWeXdjK25PUHI4Mzlvb1BpNktD?=
 =?utf-8?B?NkZWNkQrcXlMVWNDaUdla1BMWmdueTk3V2VIeHNkOWZUNk9WUU1McHpxMzJH?=
 =?utf-8?B?MUJ0VW50MExjb2EwalhwREJYMWNnc01oZVAybG95emZhWEhMc0dMZGtKeDhF?=
 =?utf-8?B?c2I3cS9ZdHBLQnlrMXZtT09GNlVVNnBiNGhPbHZpK05ySHFkWFlCU1lSYlVY?=
 =?utf-8?B?YjN6Wjd2cDRZdkdkM0JRbTRvSThta0ppZ05JQUdsdjBiK3h1Z3N3a0RGb0Q0?=
 =?utf-8?B?WElXUUV2MnJKbHoyM25ZUVFsOWpyd1JYdjNkQXJnbmtTZHVCcTUydmZ0MXpl?=
 =?utf-8?B?TElnU0x5SnhHTUZqOXUyTlRQR2VJcHgyUmFMUS9FcXNXTENaN21ITzVJeE5n?=
 =?utf-8?B?K0JYLzEzL3hYeHhheXpuNm05NVZHQXFFd2h6UUgyMTM2NldsSnFyVGZSZFM0?=
 =?utf-8?B?WW1CVXpYM1Ard1Q2QUM0WGRZWHRNYTBFU2lvSTR3UU8vdW11Y1lyb0lENjJj?=
 =?utf-8?B?T2hxWnVSUW5sanpnYjdJM3R3Y3lXRmhSa0tQczlzWGc5V3NaTXBZeUJnMHhV?=
 =?utf-8?B?Q0t5MkZuTHVSTDlKT0E1R01DeXE5T0hGTWR6MXd4VWJDL0pxclpsMlZUQXN4?=
 =?utf-8?B?NGw1SXdaWC9iMGlWMWR1MFVTVU13SVpMdFRLQzFVM2N3ZHEyYUZpZGFDRVhq?=
 =?utf-8?B?ZVVFUTM5TlBoc0FGd3pGQ0lna2ptWWc4c25XNjROZWVzSjU3dzh2MlNWVEV2?=
 =?utf-8?B?bmZrRzFaNldQa3ViMkl2dW9EWU50VUozdlcrQ1plTDMwT01QeDFseEQzQWdP?=
 =?utf-8?B?T2R6azB4dHdKWVJYSzB5M0NvVW9tSHVRZGJyT1prYlgya3NaY0dVYlc5eXFh?=
 =?utf-8?B?dnUzc2hFK084bnZuTGUzZ1NQS2VKemdTRitWK3hsejdhUmZubmZHUnJWRlY0?=
 =?utf-8?B?akRZcGQyaHNDY2tncDlkNG5PQUJVZE14NUcwcTMyY1lReUVKS01KRVJFaDA2?=
 =?utf-8?B?TG8xeEtpblRWOTlvNXc2T3BGaUlCamZJRlg3UkE4WEdwQ2JaQnhWYU92UTJD?=
 =?utf-8?B?NG9pd2tDQ3JBbjFOVnFIbGNaRW1COTNKcWFpYnVBekZRSnFmRHR3RnhsVE9K?=
 =?utf-8?B?dDFZSGJMeUFramtSTzNtLzAxR05QMlRNNzY3K1JDZFdaNHd1RzZhVTQ2RCtN?=
 =?utf-8?B?NnVlUFRnZzFUNWlFV2dZcFJYdkZweWxRQnh2WXh6TmZrck14OVNRTHN6aHFR?=
 =?utf-8?B?QzlINWdZNmFIZHhlR2U1YmJBejZ1cnI1RUkwWmtHMy8yd3pYekhhVXkzODJr?=
 =?utf-8?B?SlRZcndvUDYyb25mODh6V3JkYi9Fd0JlanRrZWFHNzdLS3NNWENPUVZueVg3?=
 =?utf-8?B?UkNVTFkzbW13cThhZEpTTmtXSXcrVG83TlA3dE80MlRPWENHLzVMMDEybWlu?=
 =?utf-8?B?VUJTNXdOMDRZajBjV2wyYy96clcxRjZuaUY3V1ZlZkt0elo3SU9OQWVqL3Fl?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac80415-610c-4bb2-f659-08dbf704ba48
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 09:13:08.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udG4oJkZp1YKnlIKnpQM0Le/LkINJ5oBMXLs4Thbt2cQIVi4sZVm7saWtixB77pGRYkcCQtBMZT40xUAx6dy8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3476

On 05.12.23 20:41, Florian Bezdeka wrote:
> Hi all,
> 
> Warning, this is high altitute work ;-). I had some time on my flight back
> from New Zealand, so review carefully.
> 
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

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

