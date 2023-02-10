Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AB63AB
	for <xenomai@lists.linux.dev>; Fri, 10 Feb 2023 17:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Idsza5QEU9qFzKA9Cg9ZsEem4vKyc+5ZIjJNxoSpSmNGF2yiKv+A4uvTeUzqkC5gcuBMmXQCecbwKYM95lcHEsOWvvnDBlO4HqaA+DrRr1VnVqp9RKxEkp8jDZz79MUQsAr3X3wF4IiOhvdcVgLOEduuZdBlf9DPkwqi+az8Dd2ZeM7fyfMupF7s2kKPCSHuYoJv2uoZYpyn8OX3xknIFLstLpe9vbqbkMFpDgCc6SIr0e+i4xLrvQjS+kFNwFbewdfLynxhaagjvICP5vg8tL4aMQrg0Ymd9VE35DUM8LZf44jN2Ou3owo5L/IvDSp8qX19ftz/DgTZeO0C4t2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0oq+D33yJcwOQjALJXa9fQ5ijKyhKgX91boe8kNI4o=;
 b=kPZBqCDQdJfrcEfhpdiChUQka9ohkAhbpfACptU9QRdIY+sSxX5porzNwo2pyx2JSDskmndvEplo0NFOxiVRPWYLGQc82ZOmgLRvZ10lbyTDp5iZETJFWCDymJJRyX6gkbLya3Xy/tRhbf0qTnBH9MCFJK1nHXKN7u+Gk/cp6yu4fNkGNuMVLCCRfUvWSLCebpsqmQEU9ZPixRPzq+dGIBPisIHufjj9oXRZRgQmZssyi4U30ocQnxRgDXcYGzyl8Wvx/AI27VVoYX6k4iyRlQruP4cWAqlNLxePr1+jCKitZWVDnt1EW989RrWxWn9aiTjHf517CdizNUN4mL7tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0oq+D33yJcwOQjALJXa9fQ5ijKyhKgX91boe8kNI4o=;
 b=mJwZ8XeM34OgvgmzJ0nnWSg/ehCbBq0JyXyzerUGSC8TaTkkzR40j3HuMW0AqAMITiNuuP51k8k+n26/heV+xnf8BepEiCSfGvR3wHrI4iky/Xb5eDRwoZmvq3pBtSH+P0oyQQnpKH/qm4H7lmIxKDkPQghRBzR9nrNs6EU0gpHLnNRS/dSeaqG7+vsCpn65EiYwFVLr0JLxw6XDkEsD0811jp8D53BNIyN7IFQdscMQVf2JkUv/EiWc90udfA2+gjeUnXbUwblWpnuJQLGjX4G3TYlxbKTEWPg/eAvxQPzO9hRFeNn7z79ePQhwf33Dk1/9b6xTFtIPlBNB/TR0EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3796.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 17:47:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 17:47:37 +0000
Message-ID: <ef51ab56-b118-643c-4f0b-17745c3ca76d@siemens.com>
Date: Fri, 10 Feb 2023 18:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: stable-3.2 gaining kernel 5.15 support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3796:EE_
X-MS-Office365-Filtering-Correlation-Id: fc17ebb6-1e09-47ff-121a-08db0b8ee5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	23aLwox8DxbLpwmMLJYJBV8XfO+fNRI73JWzacMYqQATXBmJiQF0F9dytqCsmF0COOuADZYbAJxE4DhHDT/RTUTWxR7pAYcYy6V7pZWaruq36He5gauoyNBWbZmJWfju/mBms5NpZuIDWMWpINi5C4CT8Tt4KEsU5r4gveWmB3f9IWi8QlhC3HfXWR5yHZas5SGn2EsMLs+9DcgWNzGIt/8EpUUBwVQct0ht2+BOW5B57q1IYTNkVvjsPC7iKlOPhonjMY6ozhIQVC3TVKUSag7oTn82hu/2777wbaCs9cbk4BH9fN24WM/V9Ezb8wduZnJAjpS6T7IA6srUPhC/CrK4dtK/Q55PWY4n4bckcS6k5J35/162p88CISYF9nOVxjc8LWz1kboHWv8MIUphANTnoQWS247BuJev3I4Xi3npA99bGp4S8oaSa7xe4L0kMtaQDFyLhVOVtZm6I2SwCbTFq2YIb3kVyNIEp83zdQG/55+jgmmuHghVXZ7tP3rH2qb95/f3o45KS4q2qvb+YJrR17ASy7MvM4lpxdp47aANJuZ2GXWKnA8Cl+DJohwmuGbPKq4bdiIYYZCzqEjxTC/Mt+lUHLfK5y3hRn0kcixuUh0oxcikSZ4sL9NeymMtO5N9eM4RUWkq9YtIK0DPg4q1DpJ1ByjOlotYLRMMPbWIaisCguKTK5bp7i0zUM4/5g2Fk8C4xowb9cq/UhHR8Suqh4MRNVmcb1N1mN1X5mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199018)(66476007)(66946007)(66556008)(316002)(8676002)(5660300002)(8936002)(41300700001)(6916009)(478600001)(6512007)(6506007)(186003)(26005)(2616005)(6486002)(31696002)(36756003)(86362001)(2906002)(44832011)(4744005)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnFRYmZKd3l0WnlPV01welo3WHpsRnZrbUtWeU5VSEVhMXlPUmRKRUJtRGov?=
 =?utf-8?B?S2o5VDh6V0pFT3QySDZiTFBEOU90ejNPSFBXV3hKZWorcEkrQWRYWFhIRFN4?=
 =?utf-8?B?NS9XNGw5aTc0QjA4b0RLbzVQVXdBQllWbGliMEwxanBoZWJIbXgvZkwycFg0?=
 =?utf-8?B?M0tKUFBtcWJPelMyeWgySlV5UUxOTEZXNGVMb21lS1dHa2RLN2Fqb2VEaVJS?=
 =?utf-8?B?L0ExNCtKdW01OHVoU0IzMVNucldLeDZOM2RHTkpXS3IrL0F3bGxiRGpRR0JY?=
 =?utf-8?B?QWY4djV4Zk1OT2tzS1lXeGRUK3BwV3hFeFRYbUxPbExleE96UlJQbStmNXJ2?=
 =?utf-8?B?Z0YyTi90YXBad0EzNWp4d3RpTWVTSjdjK3B3a2NpTWk5N2NLbEZLc0ZIbzVa?=
 =?utf-8?B?dTUyZjAxS3czTzZUa2N1aTh1eDJROWRxcWNJQWVDdldEZDFoTGdkV3NxRDAy?=
 =?utf-8?B?NEV0SElIdTZvR20yRlo2RWFNVnhjbi9tdEdpNnM0cUJUbWQ3ZmhXTDNKYWlW?=
 =?utf-8?B?NCt0R3JUYUVHMmRaMDNkRG1CTWFOSjJ5Q1ZPVWsydTNoYmp6dVVKN2MzS3BT?=
 =?utf-8?B?aVR0NmNhNG1EN0NjaGk3dGMvRExFY3FyeTg1WWc0RFFINlFENmh2VTI4aDU2?=
 =?utf-8?B?SVpMVG9NdXRNdFNVS3VsRnloVU5aaTNEeEdsMXBHcEdYZkxNaVowZG1SQlFk?=
 =?utf-8?B?UnhJblJTZGFMa0F3WlUrZUFYN3Z6dm91dW4vVXVmS0phNkc3S1VOY1c3ZHBl?=
 =?utf-8?B?K2lXRllHRnBPcEV1ZXIxNjBMeEFOclozN3FmUlZIZGlvblhpWUVvbVQrYXF2?=
 =?utf-8?B?TFNpNFRCbTZUNGNTWm45ZmFlSjNpejdGaGdQNFlsbU9IYkVyaTBrUWo2SHdI?=
 =?utf-8?B?RFR2ZEtVSGsvOW1OYmVGc3JOSVhzQUtJRlREZTlsdUN1bkl2TjVZSlJlVEhq?=
 =?utf-8?B?Y0IwSWE1S3YxTitqb0FzK1BabVk5UjJENlFqK1VWRHJSUFoyNGE3L1VTaE9i?=
 =?utf-8?B?NFhISnBMYmZLblBZL1llUkdaaCtqdFJnQzVoV3k5NjJEVXBic25NODdaang0?=
 =?utf-8?B?UVJYRm9BaEZ0VVpuM0Mramd0SFVReHNITW9MZFpZSDZnbTNXOWM4M0x1MitD?=
 =?utf-8?B?UmZYQnFPSVppR0l1aHFKd3kyV1V6dUJvMEx5VllYWEJ4MkpUK2JCbzc5MWM3?=
 =?utf-8?B?NzF0RXZsN1o1OFptMGd6M3F4WDhPeHFDZ21WcXZ5YmIzMlFld2hiL2xxR0lr?=
 =?utf-8?B?YUltVzcvUUw0cEFwUHF0N3Z0NE5MREtTWUJPNjE5cW4vZjQydkhoTmhxdXdl?=
 =?utf-8?B?OHp0NE5CSVNNcGdnSXdnVXhKeFNxeUZkYzRHVUxLYkFXck44T1JhckkyblBh?=
 =?utf-8?B?aHFrMC81TGk5Q08zTTYwL20zaUc5OVZPODJnOEJZZFhkTzExdlQ2RzB0R05B?=
 =?utf-8?B?RTBteVZWYzNtMGpOUktrR2lSVnVHaWxLVHVhYjc5QzZsV05JaXA3b1JJclhB?=
 =?utf-8?B?eExMZTh0c0ZSRWlXZytrMG1hWEI2cUljc2ViSVJyZE9BMDBNa2Jtdnc5WEdZ?=
 =?utf-8?B?Ym56RGRtSzRFU2l2dDA3VVdoOGkwTkRKaG00R3JSOGNwOFFpSlp5VktiSkg5?=
 =?utf-8?B?TDJUa1ArZjUvUVdCVHdBbkxjdDBRaEpiekQ4VFNyRnBWK3o2YnlORHVIQWx0?=
 =?utf-8?B?TG1PeStlZkM5TzZBTDZzMmZpUEZGejhCWDNGSHRTMUJOZE16d1dWWlB4blB6?=
 =?utf-8?B?UG1CQUdoZkFJbzdyeGdUOFFyRnlnVk9Ed2E1OCs0RHBPUkg1d2xVU2xPWEJN?=
 =?utf-8?B?YlFiOFJCbmJkUXZsYWFwcExYY2xjaEllZ1Eya21FREgvczFrVmJyd2xuT0p4?=
 =?utf-8?B?UC9nWnRPTWMvakFnNnJIZEt2UHUrLyszSzFUd3VnMHpRdTVYMGRpN1NJR0Nm?=
 =?utf-8?B?d2JnMXE5cW44M0krTERsdG5Za2J0RHhtempEK3kyUlRteTdNSmg0a1NVK2hE?=
 =?utf-8?B?aTVrQWoyQlJqckhhbmoyN2t5ZlBPR09VbWNxc3laa3JiaUZSV0Rhb3l5RW5G?=
 =?utf-8?B?Y2tGeWZudVhRVm00UnFFT0V3Qy9TRkJib0dWZlNOdTJ3T0VpWkoxL2ZDVVVs?=
 =?utf-8?B?SHdBeVcwVDdpWnF4RXd1b2I0dnlpdEZhcHZRaWJrMG0yOHFHOXZJYW9iYy9J?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc17ebb6-1e09-47ff-121a-08db0b8ee5f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:47:37.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBIncm7mljhqp1cZqt6iJJIh6+RqX+PMo90VrexOohRT/VIcqM16GzllzNRKifjkHCS2GXZ0VFaDTDt6H1TH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3796

Hi all,

just a quick note that I back-ported a number of patches from current
master to stable/3.2.x that should resolve compatibility issues with
kernel up to 5.15. The background is that a 3.3 release may take longer,
and people start to ask for a fresher kernel. This support should become
officially available via 3.2.3 which I plan to release "soon".

Before you ask: Going up to 6.1 would take more than I think is good for
the stable branch.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
