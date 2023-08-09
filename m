Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814B6124
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 07:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncYgEftrHYKrrJr1F9Dneihoze+YqFt/s0pX6FvE9BmfixpIMtXl2A2zcHxtsEHiYSwPfmHAKDh9kcYUIYREdSWTUhOnbOWkGiqgMNxPM3AH27TNnBLm9QrIACojxtQyGTI8lsTJSy+prwwFJJupzjquk/gX7lLftiLUXYT9U27VjmR+Cv8oqZL4zo2/stCAGF7GggsjxFbZI9bKwJuHVbFZL2unn7Hb6qp+GozyrXDjtx7NtyLzhEXuZlAqxAk5zYB+DqS0jbzsISpWopbDQFcaf/TtQcfBogKuCi+ZG8up39a++UHdQGlypPvHdU68h2pUY9XYyIUlQuc/jsL0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPR0kqtAfw8AVEmsi1P/POX9Bu2Qwh5J5XeCkgFwfCk=;
 b=cOZ0hBKcLwQdsP+Zkb5jrA5HZNm3eGSs/k2ADm1W0lIydiN8YzboVPPtOHxmMyOhRQCLpU00XJl+1oIsE4ibIfnuhMBunBK1BPm8ONR+hBHCd3lQuz9LlZRmUlwg26wz1J+bJDf5nvRxQy4n6GWq9jJXf04OVFTMi2v2K/AIzwNVIC3VN1IS4Jrl7tD02JAqSnwtxkQKeDyR6F4EF2rdQrPP2Uk8lfZPsgtQA236f9jbyKprKMUS6z8Abx36QT29Tp/EW6mGWEOY7t3mq5movqT4iLM9d4N4cnHgOF7l4tR/PYXPGEY6KgmPW825FeV2acrYS3g1TtmvnSIf4DmpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPR0kqtAfw8AVEmsi1P/POX9Bu2Qwh5J5XeCkgFwfCk=;
 b=EDUF0u70BcDawYyWniOwH++23iPOZqiCV4kdkwBt3PO6K9j/FaNkyVaEpjpFagruQUN/5hBTfSvb+yZw8ofhZQWYhRlMQ4eM9nV6RfcpxMspkjn7dww6ZfqB1FS+wet3jywTsFSIAeJVNkN5Hf7bPlTKLVoBLSvbDmIt1eFERXEHSfYuKNuity8EA3UY+QU2r6cWnDR2HVRzoROBG/8cibiM9kdtRdH4pirT2DtwMOOPvHbVD63wyPZulSDQB34FPwz1s4fwVZz5YkIi79ypTXdx7/8yKO6IzU7Zzbw4t0sU1aEJ8EpgdZD2FWxTs3WYBhdcQ3gkAm1uBcmVVe3EgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:36:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 07:36:20 +0000
Message-ID: <6b3a57a7-01fb-f40c-ee81-b8aedaf2ca4a@siemens.com>
Date: Wed, 9 Aug 2023 09:36:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 500effe5-f875-4790-facb-08db98ab5302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CtnqMVXrcVs9B2L9bX9a2iVWNTCLEbUUWrNBGGHDwvWRarP7jRnKWm4LNDub5PrsJisuNP4Xh4lsD+npYrPhOeBe43txBEel+VScgeCMXSO6AEBK7mQkjf/mvjkrIQRXV4j4aAGiIjbOtmk7bH6RwKsvbGMfELucnbPOZrL/TaHOTnNzN6GE4BeBf8bs2f/uWkxvv0+dK9Nb5z8uLyiVJuPFHQKWld29pbBIek9LmYBhu319tLpgDkzlT2c1/pMDlSX9sf5RfOQuP9rolJKufMEN5SxKQEzyGGMt8jmKE3ZWv6nt4eTkRAYCu/BiUBOjX/Ky18vg9uWFKOz/Xzh1M/bWCAZeXW6JLJqZhNVIOAubnd1SB74+lhs79zXsGni4aMqJ8TLXUonVeJi0iuNZBlzD6kC+HzFqxJeA2N77zjzKYFwYkZQb2gueOlKaXyl5xwHfln0EhS7TqVMwu0wZFMPqXu9HyVIwwoiCvT3NvMZOeFHHEROpg0eGI5XKrX1SdJol98FkG0++dXZZI5nPrR5uKuDfO+BydGFcDhWHLtA4Ji0hsOp7KgTnhemdsjQkDKXC1I+Tppa8qSufAfNeT/+1oKd7lqAS9cbRt+dVWYySeXvX2jtE7kMfxzEJgz6EyYpEiYqDy9VgR4xmDhR8iw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(1800799006)(186006)(31686004)(316002)(4326008)(36756003)(2906002)(31696002)(86362001)(82960400001)(44832011)(38100700002)(5660300002)(8936002)(8676002)(41300700001)(6512007)(83380400001)(26005)(6506007)(53546011)(6486002)(478600001)(6666004)(66946007)(2616005)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZThHSVVORUZQYVRoSTRaRXdxVUtlV25uQ3ROTWlJcG4zaXJodmZweENQUUQ5?=
 =?utf-8?B?R3NLUXFIMmpnMTkyWjFRSUo0UDdqUGVaZEFCQjVTNGhOdGRkYndCTnhrNzVS?=
 =?utf-8?B?eDZpUmljVEJ6NmJWU1M5Yk9CeXZxNkc3WHdENUpSTXBHMVhwaGdyV0lCYnNy?=
 =?utf-8?B?dFNZRTdML0YxSjBEa2c1L0krQmtXR2FLbjcvbHovM2hxSnIzWHRGR3pLRUdz?=
 =?utf-8?B?Yk9xZEt3anZweEk1OXJxM3B4QVpSYi8xakw0K1ozOWJIeG92U1pDVkJNZzZY?=
 =?utf-8?B?UGNaa3cvdGt0dm5uZFBhTnJ1TUdBc2wyMk96TUxXdytqTDVFbzF1Tmcxamdz?=
 =?utf-8?B?dzVWWWZmcUtlM0huQ1Y4K3NPTFdHSmlzcVZHN0RmTDN1OVdST0wrQ1R3dS8v?=
 =?utf-8?B?aEtxS29RVFJUb3FSc0kxZ0Y5RTRhRnFwZWFTTHQySmxYY0U1T1JuTkxsS0kw?=
 =?utf-8?B?Sk9BcHBXM3UvS2RCSXBneXVrM0ZJdXdQcmh6QVI3UEpSQm52UUJ6dVRKR0tw?=
 =?utf-8?B?RWJ6WHgyeFZKbm1xbURxdjhaRnRCQlVEWWNQUHlYaG0wR1pjVWNkTWptZTdi?=
 =?utf-8?B?SE9rQ2JKZmJ5aEJqRXRkSEdQU0VMSzFDSE1yM0lLUTIzTVJzMXh1VVRiRVgy?=
 =?utf-8?B?QVdqTk9XeHltTnQyMFNGS0xEUTA0U0xwTmRFcEdkMXR5eFdlMDhCSSswdGxM?=
 =?utf-8?B?NGFSQllod0hsRXhHVGVrOWdWOXRDVzZwdHBCeDh0N1c5a3FtdHRJTmdsZXp0?=
 =?utf-8?B?OUpHYWZIaHBvdExaSmJteGdPZCtUSGVnNUFvcG1WNDBub0lUQng4bFBYYnh3?=
 =?utf-8?B?ZmFvSnBiZFNXWXZsSjBSRVNkaENQWEU4M2MxbFMxbEhnUEViN3pQNjZJcDRF?=
 =?utf-8?B?ZzFiYTE4OUVBQjBoRXVkUkMxcmUvVWE1RlkwdWQ5dGtoU2luM0tablhKOFpY?=
 =?utf-8?B?UlJaUlBuUzc5QUl0eTdZTVRONnhkTkxQZ0Y1Q3F5OURPOThrZ1lQMjVudjYv?=
 =?utf-8?B?c25yM0VyL2xEZGNXTGdFVTR5Ung0Yk1FTmowUDBGUW9qNHByTTBzMmlHNzBo?=
 =?utf-8?B?OTRhcURSSW9FajlpSkU0M1lteHp4ZEhBZ2k1QzBtMWpCYWFld0t2dlpmZG1o?=
 =?utf-8?B?TUZRdE5qbTYxdUp2YlVOKzU5M21wZm5XRGNqeEM5Qm1nOWxOQVZkZXhFS3Ny?=
 =?utf-8?B?U1UvL3BkODQyMGRCODhjdE9PcWNhYzRRaWRDdW4veDB4R1dSR3ZhOHBxTE9z?=
 =?utf-8?B?bjQ2RDgvZGRxMjhhRjlEcWhYVFZMRDhWcWowamlFeXhmSEVDSkF4MnZmUzRn?=
 =?utf-8?B?RTZKSjgzSExWYWNUcWw1NGFsKzNBNVRnclZEelZVcVUvNHhIekF0c29EWHBY?=
 =?utf-8?B?cWNJRmVRN0ZkM1JTR2czaGIyelJvK0NuaUI1ZU8yWEVNMXVBaVhDdFlBUko1?=
 =?utf-8?B?TmtSQ1JYRGwzNWZqc1JlWDBabHJEalpXbFlOSWlwNkF2NFZIMzJ2bTZXc1kr?=
 =?utf-8?B?ODE0dmkzaVVqQ3VVeGszVEIvMlZFZEV3T3FUTzRUY1RhdUR6Tm1UQUlsNjY4?=
 =?utf-8?B?M3FRNDVHQ0lGUzlGWVlFVFpYMktlR1hqYnVzbUZuaE9XcFZwTjVzK1djMWor?=
 =?utf-8?B?aEVnUjJ6UTlZODRSVEE5VXdtazhnbHpqbjVXRzNYOHB6U2dXK04xaVZ5SVhP?=
 =?utf-8?B?aWdEOGdrVndnR01IN2cyZzJ1aTMwZk5HTVpOSjQ2S2RONFliMm9mSTZ4bXB1?=
 =?utf-8?B?eGNLWGFCMlZOb2l3MmwzRjY2ZENUc0YrSEpmOGkzcm9sNkFoQmcxOVRJNlov?=
 =?utf-8?B?TXNNemFxZWl0Z1UyVGRxemRDMzAya3lxbVZ4UEYyVEJ4VjVqbWhOR0YwMlh6?=
 =?utf-8?B?aCtzcmJQb0g0ZXZqNlNMalc1c2JhVFNSM3piaUEvR2Fya2dIUGJReDhlR0hR?=
 =?utf-8?B?YTR5WDl4T0hjQmNVVmgvMGJWcnNpWFdrWDRRVlhlYTExU3dxMmgyYVp3MEpv?=
 =?utf-8?B?NXh3K3duQzloODBoL28yMGFJdjY2Vk5uUmNxWFRkR2wvVTdLZlJKY0puWUgv?=
 =?utf-8?B?UFR2S3k3ZVorclVrc3gvZHdMUWhmcUVZSVN6eTljak1DcUFLV2JDQWtuZDlG?=
 =?utf-8?B?eTZyRlNRUDl0OHVvb2FQR1Y5K2pxUkVTdS9ML3ZFeXIvS0I0TXF3SVVNNGZK?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500effe5-f875-4790-facb-08db98ab5302
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:36:20.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFYJAiaHRf7HdicYasMKP4eC8rjJJcXTjfAINVUKpbNu7/3b6XRIeq2qfmmJ288e/+eFwbulnXUR5QHLjv01Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5502

On 25.07.23 10:29, Aaron Marcher wrote:
> This patch series fully integrates the currently abandoned alchemy, pSOS
> and VxWorks tests into Xenomai's testsuite.
> For each test, a Smokey testcase is hooked up.
> 
> Changes since v5:
> - Improved task-2 fix commit message
> 
> Aaron Marcher (7):
>   testsuite: Fully integrate alchemytests into smokey
>   testsuite: Fully integrate psostests into smokey
>   testsuite: Fully integrate vwworkstests into smokey
>   alchemytests: Check pipe-1 asprintf ret value
>   alchemytests: Fix task-2
>   alchemytests: Fix task-5 logic
>   testsuite: disable broken tests
> 
> Richard Weinberger (3):
>   testsuite: Remove old alchemytests Makefile
>   alchemytests: Fix gcc warning in buffer-1
>   alchemytests: Fix gcc warning in task-9
> 
>  configure.ac                                  |   7 +-
>  lib/alchemy/testsuite/Makefile                |  70 ---------
>  lib/psos/testsuite/Makefile                   |  49 ------
>  lib/vxworks/testsuite/Makefile                |  43 -----
>  testsuite/smokey/Makefile.am                  |  15 +-
>  testsuite/smokey/alchemytests/Makefile.am     | 148 ++++++++++++++++++
>  .../smokey/alchemytests}/alarm-1.c            |   1 +
>  testsuite/smokey/alchemytests/alchemytests.c  |  56 +++++++
>  .../smokey/alchemytests/alchemytests_driver.c |  33 ++++
>  .../smokey/alchemytests}/buffer-1.c           |   3 +-
>  .../smokey/alchemytests}/event-1.c            |   1 +
>  .../smokey/alchemytests}/heap-1.c             |   1 +
>  .../smokey/alchemytests}/heap-2.c             |   1 +
>  .../smokey/alchemytests}/mq-1.c               |   1 +
>  .../smokey/alchemytests}/mq-2.c               |   1 +
>  .../smokey/alchemytests}/mq-3.c               |   1 +
>  .../smokey/alchemytests}/mutex-1.c            |   1 +
>  .../smokey/alchemytests}/pipe-1.c             |   7 +-
>  .../smokey/alchemytests}/sem-1.c              |   1 +
>  .../smokey/alchemytests}/sem-2.c              |   1 +
>  .../smokey/alchemytests}/task-1.c             |   1 +
>  .../smokey/alchemytests}/task-10.c            |   1 +
>  .../smokey/alchemytests}/task-2.c             |   5 +-
>  .../smokey/alchemytests}/task-3.c             |   1 +
>  .../smokey/alchemytests}/task-4.c             |   1 +
>  .../smokey/alchemytests}/task-5.c             |  11 +-
>  .../smokey/alchemytests}/task-6.c             |   1 +
>  .../smokey/alchemytests}/task-7.c             |   1 +
>  .../smokey/alchemytests}/task-8.c             |   1 +
>  .../smokey/alchemytests}/task-9.c             |   3 +-
>  testsuite/smokey/psostests/Makefile.am        | 148 ++++++++++++++++++
>  .../smokey/psostests}/mq-1.c                  |   1 +
>  .../smokey/psostests}/mq-2.c                  |   1 +
>  .../smokey/psostests}/mq-3.c                  |   1 +
>  testsuite/smokey/psostests/psostests.c        |  69 ++++++++
>  testsuite/smokey/psostests/psostests_driver.c |  34 ++++
>  .../smokey/psostests}/pt-1.c                  |   1 +
>  .../smokey/psostests}/rn-1.c                  |   1 +
>  .../smokey/psostests}/sem-1.c                 |   1 +
>  .../smokey/psostests}/sem-2.c                 |   1 +
>  .../smokey/psostests}/task-1.c                |   1 +
>  .../smokey/psostests}/task-2.c                |   1 +
>  .../smokey/psostests}/task-3.c                |   1 +
>  .../smokey/psostests}/task-4.c                |   1 +
>  .../smokey/psostests}/task-5.c                |   1 +
>  .../smokey/psostests}/task-6.c                |   1 +
>  .../smokey/psostests}/task-7.c                |   1 +
>  .../smokey/psostests}/task-8.c                |   1 +
>  .../smokey/psostests}/task-9.c                |   1 +
>  .../smokey/psostests}/tm-1.c                  |   1 +
>  .../smokey/psostests}/tm-2.c                  |   1 +
>  .../smokey/psostests}/tm-3.c                  |   1 +
>  .../smokey/psostests}/tm-4.c                  |   1 +
>  .../smokey/psostests}/tm-5.c                  |   1 +
>  .../smokey/psostests}/tm-6.c                  |   1 +
>  .../smokey/psostests}/tm-7.c                  |   1 +
>  testsuite/smokey/vxworkstests/Makefile.am     |  94 +++++++++++
>  .../smokey/vxworkstests}/lst-1.c              |   1 +
>  .../smokey/vxworkstests}/msgQ-1.c             |   1 +
>  .../smokey/vxworkstests}/msgQ-2.c             |   1 +
>  .../smokey/vxworkstests}/msgQ-3.c             |   1 +
>  .../smokey/vxworkstests}/rng-1.c              |   1 +
>  .../smokey/vxworkstests}/sem-1.c              |   1 +
>  .../smokey/vxworkstests}/sem-2.c              |   1 +
>  .../smokey/vxworkstests}/sem-3.c              |   1 +
>  .../smokey/vxworkstests}/sem-4.c              |   1 +
>  .../smokey/vxworkstests}/task-1.c             |   1 +
>  .../smokey/vxworkstests}/task-2.c             |   1 +
>  testsuite/smokey/vxworkstests/vxworkstests.c  |  46 ++++++
>  .../smokey/vxworkstests/vxworkstests_driver.c |  33 ++++
>  .../smokey/vxworkstests}/wd-1.c               |   1 +
>  71 files changed, 749 insertions(+), 177 deletions(-)
>  delete mode 100644 lib/alchemy/testsuite/Makefile
>  delete mode 100644 lib/psos/testsuite/Makefile
>  delete mode 100644 lib/vxworks/testsuite/Makefile
>  create mode 100644 testsuite/smokey/alchemytests/Makefile.am
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (97%)
>  create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
>  create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (96%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (94%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (95%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (98%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (97%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (94%)
>  create mode 100644 testsuite/smokey/psostests/Makefile.am
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-1.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-2.c (98%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-3.c (98%)
>  create mode 100644 testsuite/smokey/psostests/psostests.c
>  create mode 100644 testsuite/smokey/psostests/psostests_driver.c
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/pt-1.c (96%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/rn-1.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-1.c (98%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-2.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-1.c (95%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-2.c (98%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-3.c (96%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-4.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-5.c (98%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-6.c (98%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-7.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-8.c (98%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-9.c (98%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-1.c (95%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-2.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-3.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-4.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-5.c (97%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-6.c (95%)
>  rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-7.c (95%)
>  create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (99%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (99%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (97%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (98%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (96%)
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (98%)
>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
>  create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
>  rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (97%)
> 

All applied, just with some whitespace massaging and a reordering of
when the build system is actually updated. See next branch for the result.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

