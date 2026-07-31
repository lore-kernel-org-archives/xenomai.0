Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D523B2D00
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519780; cv=fail; b=pzZuhIR1dDfzws9j6B9+EoIBZrCEvecQ35LXe8Sr2gRJTz20j4JD3MCnKGwbSSRN+msgTB84ikq8OxQa22sLPW+M/OgruY4a4f5oFwjDWwW6FYWodEAn5GnYvTnp6/og07QFFIjV+ocwtJ+PBS8OhQypAl4BhTJb/WsbfX/5PQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519780; c=relaxed/simple;
	bh=FyAmChK7iBMjnfVEK+cxIkmIdU2srlF1GQO/leZFT9U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kWQBmpePPa7gI47HBSlOQv+4HQSu5GIOqNF/mzJ3QINcCpHY6d7+0kBTAUAUEIH2NUW/L34zdkWGgoH+W/UZ2R0VFVh27/RG76LYTuTZkXZWZufEGHbqe+rat5PuJhO8NGd2HSdz6anMHOxszxMB16gzbfg6RsMiLz7RVT3f4b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LKqTkcPM; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LKqTkcPM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6K90h3EnqcrEhJshuNumYuoRwJkjw7h4QqBaDrGXUnUm1ir67AfVtUAqsJM6rdrcQxfa0UP0wvF8vNvsexUvmXZZEgFUCIxjNtAipr5QrwwDv0rXKHYYkiR2QHcI7OAoEr8LBcNGu+cupYkgUvK9o0ksKvXN1m9QoMbM1YSNwoi5rrjBylkpBrzCkmr9lVa4RO7yYWc33E0HwtkEBVYWvtRaVA5X8sCdsa073K88WLKXL7u0OjOskcHIP4yG6BItK/k0CKzddFUYHazGWLAQ5XcHQBRqcBQRlLz9L57CcZ5mD/6rDLOqksjIwM2cIXWjQnQ38z2f2BGvsxQOJ3KjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJwnKl6WeDS1DaMEBsU5b7k/7FXoFtCxNiUDWLs3seM=;
 b=HIR6ZMIKOOPsnPHMAkUZsGChoCvV+uy9GVaQTLebGQTmvk4rEbj6x6QpSTNyah0Kk5KTq+j/YBbtSI7FDvBlodyo0t3X3JcntUYPF+2LIPQz4RQ2nYq5gbnt1WewW7jP+oIQMuCb3RAdxAsj5yrqvAkW3RbyWBzv++sllrNpGGJSwnwhJKwfqcbINJ0Y95VbccrwCf4I+HkE1QVaWT4L0yPyKIaI6TLMKIgd+Zw2wXHfDvQ4e4EuyxCHF+DHh9n4G0qGLcLIYHFE7ckwHoxPePddE/ttF4xDNVronPYW1sEyY0dnqyEpRvH5AZkStmS7JOA0cDRy7Mj1caeWRdGkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJwnKl6WeDS1DaMEBsU5b7k/7FXoFtCxNiUDWLs3seM=;
 b=LKqTkcPMV2bRT1Z9WCaulY69TvErut0GWk8a7459KAWv5OepbitnzJT2bsocanlo5VO6a+BtRH4BuS7pk1QB7QtLItZ0FKFYMwnRp39a/nUS/VdOvUvPq994+OmvYaufc5SxRi7P5P2YBH2qWMOG8P6POL66+WLHGGUYUPfd/95f0wZ9aXC/EAsSHJCIAyg7LY+1EI/4DHfWsgHpnbvWuYcCvovmpwN6cpymzRuxzxF0qi8IE5oH3tviYZJnfUyvQMwcgwWZlx+nUgxjKZ8c1O38XTHMRqRj8JCsBWiqqtT3jo4QZMzbWMBQMDWBZvCqL6HLhu7zCPV1xBG1QP1Chw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB9059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 17:42:54 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 17:42:54 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl v4 0/2] Add RISC-V support to EVL
Date: Fri, 31 Jul 2026 19:42:43 +0200
Message-ID: <20260731174246.3431398-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb96ffc-4d96-4a2e-5d49-08deef2b2652
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|23010399003|56012099006|18002099003|11063799006|10067099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	jEgI47gxe2+bh4sTxlTk+CekXRdP8QqlL5WSZHLZ/TTtzrQ9Z9HPpmftN9qYOpLbiJdG5xdj4F+TexCULOiMcgBCGElLgct7R8Q1y8By+uUNcC8XO0NVwZ8+tQFL19Nq8F/5aWVo1Gmpv2BNZPPpWEYPbmbP1pGoo3ykWlE4XSrvE2XjIvox4yv1IpkH5q1+EZPiWyblDFWDv9o5+E2CUHHG5Gwm1BNuNQ0BFuvOBAv1qaP2CaHaFlmXYetTmqIWDuUrlnseUwiX7lIuhtdxQd6SIjcsmjdVZb3L6gORNzvabb91TL/mbREnSH99gfmSZdN/mTgF0pqvmBp8jXX9nqg6J4x47Ch0Wt/QFNxol284LiQhHY7BBalMJgYrZmt2jd79skA0NT2abm6SnwCcZEPG85CpLgxDm0c38IPapbneOy+gI5Ws07/Q4ZDAlqH+l3KcwxDWT1DA+gnxzC1ZBhzL9mcgIl+y7O0ez7x0u6bgWr8RF4Kw/HJg9Td0nrLfePx1VtU87JEySyVPDAR6Aefy+RDjg/rEI1qLyyIckbLxyhfVIBBjopBEQPLmQYa27O9BbSi+HVILG13SZPE+I6vA2MzlrJwWWft1dXKJfQROSziM+3vvw2BiaSR1FblK7HAi9Ke3QuKEcIMJRwrO5fwZqg9AEsT9a5MJ1IBdGV8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(11063799006)(10067099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU80bkRRNlgyMlcwWUZ6bkJ1eGg3Wjh5U2JTSmFFNzlwQmhXTmJ2cCtURmli?=
 =?utf-8?B?V2JtMGx4QlU2YXBzcUpRdUZLTG1Jc1JiLzNjRGVwQUJnUnZvMzF4VDhnUXFk?=
 =?utf-8?B?dE54cnVXejhON1ZiYUtNZFo4OThIOWRHckFzRUtDVis4U2gxcDhtUUM5NlBZ?=
 =?utf-8?B?TXE1ZGNGckxUZk0rNUlMMWwvaWFkaHkrdnZYS3dFcm80WnoxYTBrWGJDYk10?=
 =?utf-8?B?cHQ3SzVGeUdQVUZzcS9SQ3JRc1BmeFQxeVhmMm5GRkxwZHBPWU1pZTlVa2dH?=
 =?utf-8?B?NEhDZEk1RHVFWGZwTTBWcG5iVHVjdVVZY2M0eWZXc0lYSjJZNDFDSWtYNVZM?=
 =?utf-8?B?VjkzVzYvWWhyeHhJZ1RIYm5xdU85TERvZHV6M094MmVRb0pwNGVWWlEzN0Zj?=
 =?utf-8?B?aTFmU1d6eG9hdG5CU2MrQnJSVlJScWhpcS9JeS9GNVRlOFR4TVpIMXdlaEJW?=
 =?utf-8?B?WjJVR1ZUSkdSY3VGVmcyS09Oa0NXTTNCYzFhM2h5OTR6RjgyUE1vSGI5V2tV?=
 =?utf-8?B?SitMdkpNZkZMU2VKd3M2TE9Udi9lRFc5WVRzZ09sQVVoNlE0UFIrWjE0aWN1?=
 =?utf-8?B?TFB2K3QvTGdHQUVUZzVIVDhCeEJtaGMvY2V3NHB3cDV6eGNmQ1BpK2RLaDJS?=
 =?utf-8?B?TTFaSjA5M29ZeW5BTndqVUV1cHorT09wSjU0OEYwYUtNWEp6cG1IYitYakJu?=
 =?utf-8?B?MVlnMmhza1o1eC9IL0lYS2hsVTE2Q0pvUzdQcDNudnBCalIrNUdNK1ZBaWVu?=
 =?utf-8?B?dU5CdkJ0UUhOZVcxNXhYWDJUclIrV0pZeloxdndVZ3FxUC81WGhJZzdmUWd0?=
 =?utf-8?B?NllsdVgra0o4VUZJbDBVQVViYzhDYk1QSHRqWi9EWFpmSTFmenBzbWZvUmZL?=
 =?utf-8?B?YXkrRFhDLzVxWUFFOU02RENJVjEzcTRNeCsvZXZsNmhMaDJ6Sk5KQngvc2Jr?=
 =?utf-8?B?QjV5Qnh2NEFIZnd3cE1vOU5wN0hTdnpBSVRqWHZMd3NLcW4vVGRwMjU3M0xP?=
 =?utf-8?B?RzJubjFiM3VBeCtxOE9KaWpHM1NNL3NSTWxkVTJjM0tlS2JFVkdPZHEwelpw?=
 =?utf-8?B?bjRuelFNc0NkQ1dHVHJYTllRczU5bnpPNm82WmVka3FzcnFMODhBanh1RDlH?=
 =?utf-8?B?WUJoc3pmRENZakxKS0lxN2l3RTBsTFRvM01QQzBhRWlNbjUwOWI3N3o5MTkv?=
 =?utf-8?B?cjdFalVXRzlqZTRaRmY3a2w3WDl5VVlYZVBNVXBtWGFsb2R6dnhaMmRIbytJ?=
 =?utf-8?B?RjViSGlPaG81TkN3MExpUk14VDdOcUhZQk1FcHpIQkJSMGQ2anIvZlZDYVlm?=
 =?utf-8?B?OFM5a25GSFdKZUhGdjVhV0tiMWVyMm9YTk1LVElDZXlya0FTRm16RmxrNXpL?=
 =?utf-8?B?eWZYUmxEV0FXODk1YXVHQ3lQWFdNc0g4TFg1RW5wcis3cnFwRVcwem50ak8x?=
 =?utf-8?B?RlhEazVCbko2Mk8wK0NDVHh1R1NzMXRRaDl4MHMreWJPdU1DZ0R4cTU1Nlcx?=
 =?utf-8?B?a091aFVzVndpVFpqNEZkdkhQRzd3cExmbndna2R3Y0V2UWEwMmM1RVhRU0g4?=
 =?utf-8?B?SVpEUGhIelVvR1VLdDBNVUdENWthRFgxRHc2UzJSaHdJZjdkZWduck4vczg3?=
 =?utf-8?B?L2syOVh0R2Q1NjZQK1g4cGdURituOVVGTVkycUZCVnM5SVRpNlBYZG5wZHFQ?=
 =?utf-8?B?QXZmTlRxa1ZSck9VZFhXLzl0dTlRRXN6VnFDQm5jZTNmL25oNU5mVzE0bDlj?=
 =?utf-8?B?NDNzWDF4QzdudlNWMlBwaGxpaFZGMXlPMC9PZFN3aUdCM1BlUTh4dzFMaHAy?=
 =?utf-8?B?UndLd01NSEF4bHhTYXpIT3piU3pUeG5jNWlSYUVndTQ4M2tmSDFCQW5WcjF2?=
 =?utf-8?B?dGdXWlBqNENrVEU2aTBCMTVFTmxKcXF3VithKzBVWDJ1V2VJdHhhNTR3b1RO?=
 =?utf-8?B?YTJYaUdGTUgwZjdtNTFSVDNxQk5DNFpkRERKYk1qa0ZjQUhsSEF4cWtxUERS?=
 =?utf-8?B?UzVrK0lqTWJOekNwSzZXRFpIVkF3WnVJdXhMbEY3d0RYUlZaSG95b3pSdnND?=
 =?utf-8?B?akpPMkxjRGZtU0tHMmYzSmJQMDRramc2elBLd2VBOWZDbVJFMjViT3J0TUVq?=
 =?utf-8?B?M2ZsbDdLQm9NNmtDbzczYXhob3d5bHNEWllQQmd4VTd6RTZGNGxOL2lTL0lz?=
 =?utf-8?B?WUk0b1lhd2tXaHdCTE1mamRUa3VFSzZSRkVPR0lLbzJVelhLa29ITmtUWnNK?=
 =?utf-8?B?aDg4ZXYwUHVVakl0QTBQLzRmYkhLNnhPQ0dHaHRNajZWNmVmTE55bVFqSFNy?=
 =?utf-8?B?TmYwNkh3TEsvL2ltaURlREUwenVteWQvYVZtMHB4d0JSU2RMeUYrM1Q0NERF?=
 =?utf-8?Q?55blzQk/zGZ3fpenL1zRJYrn40D3PdESbymP+qrUjWRrf?=
X-MS-Exchange-AntiSpam-MessageData-1: DnLz4xg7XUZiE6NpQdMGOMZ/yoS982vMRfY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb96ffc-4d96-4a2e-5d49-08deef2b2652
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 17:42:53.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Clh3vLTmahhx6VR8MsaEgvCFyTT4V6FmoWnc9ceIj0b30WD7GL7F6hPZY6qe/fxjy4CoBffFOTRNpzWpQ0qhZV3rvWVAIJGToOuHSoDd3J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9059

Hi all,

this series introduces an initial EVL port for RISC-V.

While some tests are still failing, I’d like to share this early
version with the community to gather feedback, reviews, and hopefully
some assistance in refining the port.

The patches have been tested in combination with the Dovetail RISC-V
port on top of v7.0-evl-rebase.

Looking forward to your feedback and suggestions.

Changes since v3:
 * Fix copyright of fptest.h

Changes since v2:
 * Remove shanmu as patch author
 * Cleanup license header in fpu.h
 * remove spaces before newlines in inline asm

Changes since v1:
 * rebase to v7.0-evl-rebase
 * add missing guards for building without evl

Best,
Tobias

Tobias Schaffner (2):
  riscv: Add EVL core
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
 arch/riscv/include/uapi/asm/evl/fptest.h  | 137 ++++++++++++++++++++++
 13 files changed, 296 insertions(+)
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

