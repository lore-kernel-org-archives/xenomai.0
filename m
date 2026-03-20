Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE62309AA
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042921; cv=fail; b=uJK0l4AS8xHHcaK6ePlI55Hoj8V9mhcaQO4qtx7niRQa2Ha9b8H9IZoNaV/u4XTd276KB2I9mhIb0jk6NOLE1nfYNZCJL/cUbdj+qX7GKbNpPnumly4bznQCvB/2o8qbsiRYzDd5fqAJymsHpOsGb0YOvo0dG1g7eHLktbySIdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042921; c=relaxed/simple;
	bh=kGjNdM98U+C5v9ei4JHv1L5I5u06pik4CAKA7rgEwKk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BaOTq9YOwAuTi5pCyCMkDd1Qqc8HNzTClA8V1COFt1BoPi3KHLx9EiQqL6EHck2+pHkQpIVpLiofYT1+DWY3B9IEJlmB33U6fhxzu4af1HfOYdIXrMU+hN2J0JsRMD5gcNT7gDbJIG5/onBFbHCyCfrsRFjOGCWOf/gzzhiDUOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tfCpbSR8; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tfCpbSR8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxFyvcdGdcwHyyEZjss4HB7ey/sxDex0IFVJf/LeZKHKvlDdidzaYXowKs1w6Z+IeBAQXBRhwVlpW9Bv1VhhjKCNK6kiGjyUDE7idnPdefh9I9jrjc9dTreO+d2NV91q7C12rJocqiLq9iGCMmnFbPyRc48KvQqb8kNrc+b1onO2B1C4HOWRVif2s5tBn3aH0TH5GNhtPNmjLjoRw0v1+jGHCn6qjqn4o9KG1waLjvzcjmcVv3hVx/ZM3XHeRgocaPiso6VPwhRUGDhGRzbnkvrbWEfd6sjWb6eM73YVUE2CVEtM1amn3HDUkS9QgB4OYyA8Ul8NFrMxvL46GEXvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KDT7Vb8IfgSjJGnkWLaW0YAJag/XX9ghL/vJ6Ay5OU=;
 b=xjfnJ+ppIP45XJ2IFmvrwyjaCqKgj2NLja+um0Q6jaaO8M88RCyN5sxnZBBiY0Z2LrkVP50O4E9/t46lyJMGNftg5mkfVssZY8v0JorMIvkj7u3gC7bkcxejQlIt1el26eXtz4E720Jbg3TyWIER+a22DfcRX4EljKUSCtVlxL2Sp26ziJz1cV0ptA8mM2wNfeQXepZY/hDmYM4SYIbsstADM2nGDOUxlV2eOc0hM1UUmEc04vEbwlsV41pVmEm53uu9ca12a3pCLHUGR7j44MdbIMaFqsT+ryVfGIGzEyJUGUNKmGIn7AW3/dQq9DM1loAH9RFUiWLH+VwLaqV0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KDT7Vb8IfgSjJGnkWLaW0YAJag/XX9ghL/vJ6Ay5OU=;
 b=tfCpbSR8LdwaRsykOr35wcE23HjGP+NmqsZfWwXeRjiel6gt79ecD+GBE7Bi6QwrVIzWbGHIfk3pJJqCdnQxBh5MhnJ5nM/Lkln8EbK8I8XRDRHoGylSdEF9RtTp7HaLGtb80cmt7GT+/WEz2rkHOUzJ1ftGGhXSI5tIAuzpu+C3SCkOEpQ6V/xq3n6CUQNFTMtVBLV5ABFfvV3qjjd9RNmJGoYB1I/cNBthde2blX/o8lpPbXw27Rlvi3aHV62VcfQBWpPxWqYxem157o+mhoL/sYpCiOQ+hIATuMiOB7fnMSWvWylZKaQDJ6l66zzQ+D5fYBJThupA2gSj4Y2jYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:41:56 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:41:56 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v2 0/2] Add RISC-V support to EVL
Date: Fri, 20 Mar 2026 22:41:46 +0100
Message-ID: <20260320214149.2211433-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef48af0-87c0-49c2-0906-08de86c98247
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	EYmhEfwFECjUdTccnNkFSPZxq5fj9RQQMx5lMQCxqT112Fu8Y6jN1DDD188VeLR12o1Jk3iDc4lAY/r4idNuzWYof6mez5nPVyAc0cO9DM6KZ2aAyarFn2o9AlsBlUAKzSBuc76d5uL6OlhGhXUG4+BOAynJkY8czpTCbh2tuIrU4houdK6bcAmjvgqfcVgM0cwliDsqzB5Wmy62oAJF4tlbTl+5KjuTZ9oUVJ4cDYAdbeqrxazCpXnPVDUnbxKlBss78o9fsvu+bdGdeaM87eXfGGa9xSDL3XPENXmWxus+mfRZk8vYkoV2rsVKtBXY4jm78tAIZi+hZYb1knw4kfTIUbMvehSD6hjBoJj/xR9jenYa6EgfvBIjBHL2/n0IwwUE9ZmUi63TRnpswZSN7axjTSq5UEoyhnOxDGqorUug50OUc/n0qZjexOYbQft+gRD3M2jB6VL4ptqBZlNNKY8Ioy4FtuG+yhTARDTaLxgFjR39ZXVBdNxmWZBrc7tmJKSm7Hn/tMU3gWHmdsRnpFONfZEJE/ebc72ljnX5b0UapeQZnYGw+2Pvd4v/NZUKAY3ortHuhCpaBwKcPn1RkFNfUxEMXlyZM0yoNytMRA9lMzqpioVMa426wvZ+/Cx0EMBiARr455JJpAY5b8AXcD4OXoK50bsl2Pf45w8gqafopckTnADSRAOsvVQ7kfT+jbv5EoBEGWUKG/smHYhHOKRPjnj8JmX6Xy//uc2kOmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXpUMVlITGhPYnNNbVp6S0MwRmowR2RKNnp5VWhnY0VBQjVIMjNDODRoQ2kz?=
 =?utf-8?B?Z290V3Vobzl0byttcVlyNmU4eFk4dnhMeXlpdng5U1d5dEMwazk0U3ZoclZJ?=
 =?utf-8?B?RVd1WXRsQW02QzJyYi9sNGdpMis3SkZiakJzZm5HRVpjdE5nVnp4dVhEbHVz?=
 =?utf-8?B?YXRKeUNuUE1KN20zWW81K003ei9LY2hGY1dMV3R1MExWOWZMQStjYXErdHJO?=
 =?utf-8?B?YmxzWHdKOHFCQzZkUEN4R1ViMmwzcXZ5elRGOVRTai8vQkNSOERiRDluaHFE?=
 =?utf-8?B?N0xNTndHdUtXbW5qaTVPRDZ0dXRqa0twTVYzMjdiZFVURDExVU1lcUd3TElj?=
 =?utf-8?B?MzlCM25pV0tMNzRPOVlFNGZrc0s5c1NMcTRjdUY2MnVjUVgreDNqUEUwRTdK?=
 =?utf-8?B?S0FGbDVVM3FRc0RIUDFQTHdvODF5eTZlc1ZITXZMaDRDYXZXUDBJalNoSVdS?=
 =?utf-8?B?bUViWjNlNnEyM0t3VDMveHR4M2FXbExPRERDTTRPdHNmT3FpYVZhZFFDdEJo?=
 =?utf-8?B?dlgramN2TmdJQnh5akdtZ3JCYnlTUzZla2x6Qmc1ZC9Jeml4OHNJT2lCR2Ny?=
 =?utf-8?B?ZTRrVEJZdDNuZEFlcEpHNjVJVTluZSs2RjNaTTg3ckJRK1lCZmVub3FIZ2xO?=
 =?utf-8?B?RitxcC9QdmIrbmhxV0x5Uzl2Sjd5YVRwQVNDWmhxcGV5Q0NMTmg3U0FGL3hz?=
 =?utf-8?B?ZG5iUU5yNkJpZzhaeHd5OEtDWkdDUHF6ZU5aRWZkcy96emE3SEdLT0w3N3R5?=
 =?utf-8?B?TkpZUFFQYXB6ZnVlYU5PQnBrUjZJTEpXZzlGb0NQMHNVdVBBVGpuR0xkanh6?=
 =?utf-8?B?VmNzSEYvamxxTVBtWUU4N013VGo0K3NKS2ZIWG1OUW10VG5FL0FlNU5YRFdM?=
 =?utf-8?B?NW9xRDl5SlRsMFgxZTNIaGJwbHBnZ1poQUlRV3p2cGZWaHNmQTVvcGxrTU02?=
 =?utf-8?B?Q1dQLzBTZWZIZlBpekdjckJMOG9lc0hUbDBGSG5nR2pVU2xxbTJYeHYxM3Jy?=
 =?utf-8?B?OU1kUjlZbEZKV0pabW5UQ3UzblBXQ3VoTGRYcERWWFE0NExEUmV1UzhDTnNO?=
 =?utf-8?B?Q3h2cGliSS9hb3gyZ1UwaGExbVQwRjF6VWtzM1QvcEpXS3VEL0QvTE9wVHNV?=
 =?utf-8?B?amVrVE5JZ1UySnA0MGFVUmVXTmJDWnR1aGN3SG5PQ0swZVNaSmdlSzlyaVJX?=
 =?utf-8?B?eUZoeGRvVi9jTTB2NnVtVURGaWlqL2RzVGFCL0lOZGY0ZnZ2b3ZEdzQ5TjhY?=
 =?utf-8?B?d3hPTzAzQWVFemhxMHk1OCtrNDA2U0l4eUZqWk5lVUhEZ3VEeFFMcUxMRkdT?=
 =?utf-8?B?ZlBkYU95MStSNnBwYTFUTVNJeElMY3JSUmFQT254cXR5bnNkM1FRQzNNN25D?=
 =?utf-8?B?aVFPTGFGaERmN1huSHJ5N21VZlZFYkpxUmRrRkw2NGNEYURPUlIvc3B0cFJk?=
 =?utf-8?B?aVAvK1hXdXVlemRDSUlTKzh6aHV6SGw2T3NQTzdQTjdUTzgydXBTMmtBYzdq?=
 =?utf-8?B?YllaSWlVN2RtMytheFFHSi93QVNwWHZJSTRhQTZBcmYzTzNJTDlaZ09WK05a?=
 =?utf-8?B?SVVRT3BhenN3SjQ1RG5abEpaKzZscU5yWFUvaUsvZ0FUV0w0UDRDZ0RUMDkz?=
 =?utf-8?B?M2VnS0dWZUlCaEZ1bHJMejZJSTlsVzRteEIwdVpYUlpoNUN6aDh6OFY3YU5m?=
 =?utf-8?B?M2I5WStaU1VVZFNnZytGNzc5Q2YrNU9Sa21CUThKN0g2MStldWVZVHo4M2J2?=
 =?utf-8?B?K093WUgra2JmcVlDb1dQekNuWng4K29MYzhvQ3AyZWNHWHdxa3N3MGhDWERj?=
 =?utf-8?B?UEtBVmtaaG5PVGs5Y1lPM3NxSEFNWlJPcFgrakRrbDZvNXZUNmZyd0pMekl6?=
 =?utf-8?B?ZkJoLzB6RlM3THY5UUJ0aWhINXZnZkZUcjBweTdhSkhKRGQvUlpPazlPZzE5?=
 =?utf-8?B?cnhxQzZyekNqMExxK1Nod1pKaUtQai9YbnVyNEtIaWhINURLZFhxMVV3WEpH?=
 =?utf-8?B?TFpET2hZQmdVdmNrekR6d2VDL3p1YlUzb09jdVpkRTdHbWVnaFZiYW1IaldU?=
 =?utf-8?B?VWdPNWlwdTNPN1dCL3NYeEdqeW83aUU5bExlaWZvL1VsalZDNVRIMFNHdjB6?=
 =?utf-8?B?TGt3UjFnYk4wYXp3QUZPVFMvUk5ZbGJvWUJBYVRuYmZ5clA4Yk1td3hXVzl5?=
 =?utf-8?B?SXh4L3FiZFpGbnYxd1MyaU9VTUgyalB3Y1hSZHRlMzdSdERXQ3FsWisvL2g0?=
 =?utf-8?B?bXpPWVdmNGR0a3l5dm1uRngycXlNa2tiSFpXMXVCcGFZdVRzb0g4Qy9YSzNP?=
 =?utf-8?B?Z05ZSFVtYmdTeWlpTHphek10dmxmeFZ5QUh6QXZkaWZrQ3VKZU55T2JKUjd4?=
 =?utf-8?Q?ig0U/5M36kccMTbQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef48af0-87c0-49c2-0906-08de86c98247
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:41:56.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLXcHOgAf2RTEqwt0atWNrxq9OjeJWwxaFNfLyoY+dhUihXq7//l7fgEVqbnBL74mjo964jM1SBP77bp60MSzhIFS9cWlm8Lp9wO3Em9lug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

Hi all,

this series introduces an initial EVL port for RISC-V.

While some tests are still failing, I’d like to share this early
version with the community to gather feedback, reviews, and hopefully
some assistance in refining the port.

The patches have been tested in combination with the Dovetail RISC-V
port on top of v7.0-evl-rebase.

Looking forward to your feedback and suggestions.

Changes since v1:
 * rebase to v7.0-evl-rebase
 * add missing guards for building without evl

Best,
Tobias

Tobias Schaffner (1):
  riscv: Add EVL core

shannmu (1):
  riscv: Add FPU register test support

 arch/riscv/Kconfig                        |   2 +
 arch/riscv/include/asm/evl/calibration.h  |  12 ++
 arch/riscv/include/asm/evl/fptest.h       |  31 +++++
 arch/riscv/include/asm/evl/syscall.h      |  25 ++++
 arch/riscv/include/asm/evl/thread.h       |  12 ++
 arch/riscv/include/dovetail/irq.h         |  11 ++
 arch/riscv/include/dovetail/mm_info.h     |  11 ++
 arch/riscv/include/dovetail/net.h         |  11 ++
 arch/riscv/include/dovetail/netdevice.h   |  11 ++
 arch/riscv/include/dovetail/poll.h        |  11 ++
 arch/riscv/include/dovetail/skbuff.h      |  11 ++
 arch/riscv/include/dovetail/thread_info.h |  11 ++
 arch/riscv/include/uapi/asm/evl/fptest.h  | 138 ++++++++++++++++++++++
 13 files changed, 297 insertions(+)
 create mode 100644 arch/riscv/include/asm/evl/calibration.h
 create mode 100644 arch/riscv/include/asm/evl/fptest.h
 create mode 100644 arch/riscv/include/asm/evl/syscall.h
 create mode 100644 arch/riscv/include/asm/evl/thread.h
 create mode 100644 arch/riscv/include/dovetail/irq.h
 create mode 100644 arch/riscv/include/dovetail/mm_info.h
 create mode 100644 arch/riscv/include/dovetail/net.h
 create mode 100644 arch/riscv/include/dovetail/netdevice.h
 create mode 100644 arch/riscv/include/dovetail/poll.h
 create mode 100644 arch/riscv/include/dovetail/skbuff.h
 create mode 100644 arch/riscv/include/dovetail/thread_info.h
 create mode 100644 arch/riscv/include/uapi/asm/evl/fptest.h

-- 
2.43.0

