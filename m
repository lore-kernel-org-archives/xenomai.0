Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B923C8
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZhQZYZbnrYIMfv+TrXz3s9CQHQxFmxLSF15akkj34a9QSwPIN90Zp+zSEQ/OoSxFc7tiHH/4qY0RSLFmh1pRYI9zkN/gRnsYdcDdJ9+fNY8gdGxU4PxqhlJns/bdAj5izxWjE8JjCEWS39wWDl5rL4oMeqN8B9mYlQRXXQGhUrG+SbLQGt9ykzKW0vy0sNoHzSUoIaHGYE8/lxiBjI19JJODtfayvmMumysIqrR3BBoDGBMtrkuPGC2krAJpO3ZyNqm/nEMfT6No8+4Wm/vFcVMt0VZLL3qwiUMs4owCCM/ypXKgTy0123C29amAl+wk0uk1wZN0ztDf1XjE08AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTZuFFui5lwTKBIlmSWdXZsChARKqwSzz6LDBfMhomY=;
 b=R84rjxelwPzkDeJ3ua0xVyWIdzGoc1lwpxDFd0FXeDSkXI6xupkU3Qy1D7VilvVsGKPPzy7upddnceJR/PoRfJVPo70V8opc9XJAymzYthAcqrHVqkTNm1MG7OMzU3eJOJHRf2mtBTJZ3cF5+Lpqm8CWhFwstsVKtcUKmn3h9HHMWIS5EsO7GCMO4D6+CsMulGdTqs2WrUER9t7bFq3BPySp9NW5aQqU3+U0Mb+5QWvmATHIPzuyyKQxf7HmCvhYoo97odJq2v/Qm9B91K1Q3WN+D+jZ4nZVKeiFEC5It+QeZzOZb9/x83tqAyuuaLQ31i4pDsx6LHCZubzjLGceAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTZuFFui5lwTKBIlmSWdXZsChARKqwSzz6LDBfMhomY=;
 b=qv7y2SuNM5Ti64bAxHAehMm012pjwUDaoJFwMW0N3aAhfU4NKLS/o7gsE5pprPHzMG5npnq3N2JA3xCMgAH0NKfN3SyJHCWBCTzU6zh6a8bdPxexQOZ7GnNcURyPphO9BX52bcYrMY2AFGvDKRRCY9G0rjKZb4XVBuo5PxBXMja7gc418Yv+PwncIAyLBS9u9KsHv7AWwO3DAN4nvt5pSCqkxlKCQN6ZhfPYZ2pHKVfcmBQ9yWF6qre6/DWeey7ZGO7tsSWjcxF3BaZYMYsDdxsYy5E6AklN3KDsemATAwzjdgZpDTprcktm67rHdGB75aGj5sgdBYdgN0geosigxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU2PR10MB5126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 07:14:54 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:14:54 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] Enablement of compat tests in CI 
Date: Thu, 18 Aug 2022 09:14:39 +0200
Message-Id: <20220818071442.16567-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30df6d37-0eec-445f-de12-08da80e959ac
X-MS-TrafficTypeDiagnostic: DU2PR10MB5126:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lXeH4gy0eTy/D+j/4xQF2wBz5ziUp+cqu/xNTHNjSNvG1IMHyDUkQD/MBLPfUzNDmUf1GhrPUjDkSKT2kwZLwVNY6S3VH0Paex8Z3BHk2H0OXpudJ87XkyLv67po5Nnoator5EL3M2caDxHsZ8/B/Skz/2yYSWSWLOMuEpARL/urgm84+xTZCe5O+ycZ1dTOzVCH/XjmUbf/g5doFNpPjGEvyziUQJPAiKKu5WJyzjYaQJUs6pEbs4UZCpRZE6PgdwOkiDyzaPGsW7VmWBF06Hurdq9wLysHbJoAxNcEfi1OiX5fF7cR0tMQwryNMQXiWnGLYi9PDM7kOAsmjhlIM8ar9lZT6HcY8pUf7Na4cIskLBe+fHEbPFN6b98gjgHqg3RKcsjtO934VUW1EyPVTSESce2QvggvbT5DXB+6ePa6f0dfAgg2/c62MdqutW8M0slH+wX2AYNUNbOoT7m0kiL7G1vcLH+BZPwO99kDbnA/7+i2dH/uh4iMin8g2UZ/Og0McLq0NBzVKOIF8BVLunhLKS3+aDEVOUePyvgxrLRIskmKdqRmbh86zuXHY79aYi5H7Q+OV5xAF7ETFY0E3jt+K6zISLjrcLGcBsUuUSD6AsYnmd+kQcicOTiD/f6bcN22SHhXvOGtEfqF/itUHmQF4wbz+MIGgeLkjDAIV+wlrNItehBtOUSrcpkKuwugv2/iLLTLMSz3g3ppC398PooKXYt7HIHApU+a1Ooanyw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6916009)(966005)(41300700001)(4744005)(316002)(478600001)(4326008)(38100700002)(6486002)(5660300002)(8676002)(66946007)(66476007)(8936002)(66556008)(44832011)(2906002)(107886003)(36756003)(4743002)(186003)(86362001)(6506007)(1076003)(82960400001)(6666004)(2616005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XK1vHGrhgK7afrJR7pL0RTN+Iaqa5TlNkjtp1xvzv8OgMzcLCq1dY7fA4Uj9?=
 =?us-ascii?Q?zs9IZMf58HC1Z0IF//Yn08pKIEa9cE8nF5/r9m6O4vrT/PgfpLBoAW8C7UvT?=
 =?us-ascii?Q?PgHvRbRDR2Vlut5TD/Eafqbf5aA+ykRrNIaPlhBD+5PQmGJczps7hXatk2YL?=
 =?us-ascii?Q?s56qyrZMut7Tj53IMSXqQJtx6frLRZLvkXXqmEKd6spxXTWd7Ja3Ce5kMJ3K?=
 =?us-ascii?Q?PJKm1xbvodFx9teuSXUKiaJmmCMFSG/zxDquV5hNqhhaI64CAb1hSfTC3N0P?=
 =?us-ascii?Q?wtEsf/vZSF+ePRyNTscsG26a2XzrnE+H4j4H4mW6FPl7Y+MmKnsQzEfCl0l4?=
 =?us-ascii?Q?srkABuhVYFcth9UkK1gVrN/kJnkJEPJiESID68DOzPaas4GLgYvDjeanUeNs?=
 =?us-ascii?Q?pwzQ0T7MDmS0PEGy8YdjJLZatyq+Dq6DQ/SwMYzGUIydPONI9ioYWGjCzx7Q?=
 =?us-ascii?Q?Fml34yYRaCfm/DA53d/U93LoFunZnKRJ3mvfhTNLyihVBaMEYf/mn/Wlo0iL?=
 =?us-ascii?Q?rmHijDHqMbmqv3oDNwqE+Umic63oXecbDOo37w3i0uaX1sKjp6PTb2fUJUKr?=
 =?us-ascii?Q?ce4wia1bLiT25MK42pBReWjm2Aia5T7X4sO4Tmrhof+cLWqO9+NwhPccF7JX?=
 =?us-ascii?Q?JGjvkkyB06Z359tXS5iwdpF7dD6UQ9ArkRflKGYZBh2VxKXAey9M+XsQ8zYu?=
 =?us-ascii?Q?aybk7nWdOWOl47Bhx57Aw7zgOnHaKTphID5IXho7W23UOOPK7tRj7vvwr0iP?=
 =?us-ascii?Q?wub5EMiWWEbf2YK1J9XM0uGrfSqHJ4uXH/UbzRERLFNGbBOz38n+44XQcZcE?=
 =?us-ascii?Q?emC2af/B5JYtCTrqTYwB5lA8m3belnBJ5t044Om/Z5sI0/gt52Y2+663026j?=
 =?us-ascii?Q?QUZn/hrJdWKa1HhH6+g11N+1bMw4QzuZlDyrFqo3PkJ76K+Cc/D1HKPvi1/Z?=
 =?us-ascii?Q?AfoXiRhXObpDu5H3WtQRgSaGyuxx2hUWmzE6+lAEm2ibwwWKaC+BQHO+imAN?=
 =?us-ascii?Q?+jMV0vnLFh1uF2GFXjtdx1dFBZi6sevBtSMKJEN1mYuzvtXN+rstlAP0o6OH?=
 =?us-ascii?Q?5G+anGPyEUyLMQK42J3r8YnqNSUEWEqBKGTPbBKFzXhOwtM0X4xisQRi4M5R?=
 =?us-ascii?Q?TdD1qCMtALU6s23zgtIT+uH6rTX5576yLUCRv94viajfkFR/9lgQCZkm1EJb?=
 =?us-ascii?Q?HzqB5uHNvNomsEucC+Ck+8tDtBTbwrlDRpEpZjgsc4hKdY6GWY/wGvq9WbiP?=
 =?us-ascii?Q?grmQyWg511O+ywKVsyj19U7r0IdP+HSyTYLkQYA3Am7OBgF0XhDSruRA/QfD?=
 =?us-ascii?Q?26oHiRiHfkAzQGARnjzi4VhOjniNOTGLhqKj6Vjno4YJnZYR+Is3O3+otZIw?=
 =?us-ascii?Q?K9dygvVACiyw44dFo2p9ap9/REnh4XYbFZ2dGx7rYkogJ6dZX8LMkrfEy2QP?=
 =?us-ascii?Q?iq/EnfgD0mbDmE6JQAN+UemkMeVmjQ5KnumKjrdOr+4fV1LOiuO5kGrC5Cdo?=
 =?us-ascii?Q?0AmzECe8PfYGAHwdCq/LcXG8dbLN8osdB5FzG2ruwEafb/4EnEOrUGSZDaGf?=
 =?us-ascii?Q?A70kbiDNrWJ+2cHwmFwvoWB2Gxxuw2/huO3H/LmgBf0bGcr6mznTuq349u0V?=
 =?us-ascii?Q?+uhwI+/iXm3DN8/gSEhW2grA+5KnaEzu0hYZLF/FensmTvfAPpxR0DaLTXhh?=
 =?us-ascii?Q?1CPHiw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df6d37-0eec-445f-de12-08da80e959ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:14:54.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ac/vzKvKUqIWRjXs6pPUCRcWY2f/IHdFsttLXa66ywhaptRCZnbtZHong9GcPs/WvSzpDG4tHuNyYwCnCJf/xYv5I8oqZPBraplIBZl21Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB5126

Hi all,

this is a spin-off out of my y2038 queue. This helps to shorten the
y2038 stuff. The following 3 patches are necessary for getting the smokey 
testsuite sucessfully running in compat mode.

The necessary adjustments to the CI infrastructure (part of the
xenomai-images project) will follow soon.

At the end the following issue will be resolved: 
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21

Best regards,
Florian

Florian Bezdeka (3):
  rtnet: Enable compat ioctl interface
  drivers/rtcan: Implement compat support for the rtcan driver
  drivers/net/stack/ipv4/udp/udp.c: Add compat support

 include/cobalt/kernel/rtdm/fd.h         |  16 ++++
 kernel/cobalt/rtdm/drvlib.c             |  17 +---
 kernel/cobalt/rtdm/fd.c                 | 122 ++++++++++++++++++++++++
 kernel/drivers/can/rtcan_raw.c          |  42 ++++----
 kernel/drivers/net/stack/ipv4/udp/udp.c |  29 +++---
 kernel/drivers/net/stack/rtnet_chrdev.c |   1 +
 6 files changed, 174 insertions(+), 53 deletions(-)

-- 
2.37.2

