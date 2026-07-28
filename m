Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46524483A5
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249587; cv=fail; b=RZP6yHsJKUWTGqmNSBws0D36nCLB1adBGKUhL3qEakNH5/HRq7r4aJ7wRs3Ozy+nV75dQcPSun9dAescNMMmQ7hKNKivg7K0r61LrkzU7BlFi9idSWI8k6iLlcWqm5fbXB9kojnp2ZFin/SYQg1S1TRae4O/NAVv4H1C5t1ItVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249587; c=relaxed/simple;
	bh=EX3Hm53JSvBHBkZ1pua3+NwLOr/MkForJnJliDkuTH0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J76KFbcWJYRqOwsldGehVatskMaSB92pqi+d4J4rTuY/ZKWnXkaRkvNyLtid/rQgsshCJWymnY9gcCWpeBK0/CktQTvjqLtw8HnR1O8NkjYFV2K1b9uHNgGygUF6ICa49o78G9YdHJLcHCQTE0e0l1PFSjnn06SdFwVw+Vtuxbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TVClfjjI; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TVClfjjI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm20jp7AGITZrhu8HppADhisoQij+v6CFulYCeJL69H8eKWmuMYJ39F5Atv5JlZuvvxHrlaOyr3j0jpFFJ2rb4c3v3si1I1Wupvfp/N5R2cQsVVERp9PmOciursM+VtQpUsgIhkInXaLuqKEW2pC3RvpouiztCRFibMiFd1wEX1qDX0iYsvWIApK7u7vNfZhQBRfKH8i8sXMVsm1USl+rUnLNw2T2ETD0KNy1sWlFipG7Er+UWOYZmyGyn+bhkmHdcmR7hcPBXTMvYS74zLfmXdCdOngyEwlgs3OyF7XrbvNwZUtUOEguWXpvsdh6C9m70Bwejyh+v43eDdvjwWYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZexcEbZ6T1j0Z6varsjEGI/z2N6lnWJFeAh7dQEi5bo=;
 b=H0ps6VnTBGzjFEsJ72tqXRd35puf31Cd8sz5tw8nScUsAFTKFv/1RtXYodSql/mfD073QOQwuYKd9yq/54C3RbPprypk6twmCZWkijwhV602CWNcPXQZTe5cGHwmBlxCYn0w6kOocXn2PZ2ydOU14Yn0tiJZcNknOhF2wF8RnsRHNvpGOMQ8SgBWWDoNa+4nmgvS5h2jOoLhnC61rfY+mhhMuJCFqpGbIY8yY1aGQsNtFxWs4rwX9hAe14ttVjf+gJ2S+wEVirbaXI1rwSI8Arou+8ezXkgsDZL8ypE+hnX5XeZF+3jWHe25sW3R3mSnLo/EorqAnuZ26LAiGSbu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZexcEbZ6T1j0Z6varsjEGI/z2N6lnWJFeAh7dQEi5bo=;
 b=TVClfjjI2p6ynm29WHhCpcSYmjY0GaTmwrcoJqueKx99FxTwdDkFN6jPHoqK0AH38tmm36dwPeP4jQ4MQNCsrVweFUWIEX+d7U1qWbMLXsNpsSVXnNMCrEUvg9qeVoXK7VNtNzWlBodrzJSW7FNMwxNXVxu5Xnwe/0iNkmXaQeW8Y9p1nC6Cqvb4PMW/e2xtVsmrrzmhHeUJ9nZxfRfcVAKz6raU/Q5L4aKf7Q9QQhnsSev7niFdJ3c54+L9Y0lKPe3GoG/j3ahnzkgErzyYZKIGfM+ZuHQCxvt+Qkye2la5nBuKlWT4TC/0A6hgRtj+Tra9gxv1r+vfW+OPE0/V0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB5939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 14:39:40 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:39:40 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 0/3] longterm EVL testing under load
Date: Tue, 28 Jul 2026 16:39:29 +0200
Message-ID: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: cf305c8d-024e-49e0-7535-08deecb60e69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	kUC2Rcatrtw0HibcbBY66hkkqarA8JdlRGARWYksOmUv1wp8Fe1JAtyTz5JfOEMYPTOalzUGJxRt/WsJYg+MxDVoSJlh49wcLx8CpXM3MuzDquTLeqwyI+Xb28dBOPMGTB6LwJXsCFuKdKz1X9w6H2Ze38/R+O4xCFd9ZzTdAbI+4cUvm3SQdGXbhf6Sh4bIchdt8GahIVATEMkChHooP6ljyDwhYke9xpJuMZ36qRWObZEIjBJEvsk99/oJWgAIGxtL/STVhNMXPEYDR7xpv9UHcaTLs/bdEwCK0NUCDzJxNb+/elV+Qr7s8rZuYY+ddl8AFGkfctERAAuVU059mEXDT1BmI5pxwlK+NBxgqn5ZgOBrceMznz3wGorGKH3uz3Xsm0zqQny7URTrWu4oJhOC2fpf55o8ExJJ6kXEk6h9J0uE3mc2RH2gx36lPCo0X1nlCclWb/m6o8DlV3MpJH1Ec1L1FNAY3Jof8Ey4Hai5LewfCIzwk852sxttCz8CD4GnftBBC/OIJUQPOIy3v8qp31p5weiXd2tCCQm8BGxx4o6ipGYUAphRn0mff4iN/fu/vTBMXhk2tThrEvqkO6ctIBsa71dt8n+xsuYmPqYpb8vSa8EFMyQ/hnxf1eXBbTI9O2Sfu7xCBI6EqGtXFLCed3W0Yy0CAbAl4C5HCTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zc5lLz3vouZAMQznOhWT0Qnj+H/WMJshIvAYMJPO73g5iccAWp9ct4aXi1cV?=
 =?us-ascii?Q?hfe75T5TIAfawfD+AN5OLJzJ9eHgTce5XvMAJUZhvi5pQ+usFyVDwu3Fog3i?=
 =?us-ascii?Q?RxLlALSznAoXiUoH1Y387MoVr/DnfO9bMKfASev5MHItEBgYq9Inls4fsJh6?=
 =?us-ascii?Q?q+ZUibSAjbM8o+6EOkR9ccdpr/ao4ajOBnHbgAUPhw/LIRAGH6m7X8KYN2aN?=
 =?us-ascii?Q?iaAZyhdHGSkwssLwmNwjuYJcYtUe8ApVZhdv9Csq2jyBVUgmV+0JKouUXElg?=
 =?us-ascii?Q?ZG44HaBSLWGG4BDofsXITmoNIZdfXKxGi/BwyKqf68YJLjFyAVHs2pCTmNuQ?=
 =?us-ascii?Q?peL4Ao91Fom4svdSdmoVw1zyqoCB6pa4kGBPbn3H/o2rzVr3pvCODQLj5bX9?=
 =?us-ascii?Q?8t+r4Tv9HGsDLAjBWXjLlECUExOs/nc0caEpCl3hGeEl2MnXuxpU8t+Oo4wo?=
 =?us-ascii?Q?ITgz1MJVb990WPIFxNhkYoLfNgs8p3ruLu7RXqRCKSu1dJvPYmD6s++gC3TM?=
 =?us-ascii?Q?OvSuSi6TRdDOzAkTPYAQNIaXJprXg6AZAoy+fDkc/iHbu/Tmd/lE511JwdGQ?=
 =?us-ascii?Q?0G73KDElExWQmVdlB9iSQSmNwazAbzQwhsPM1z/o/XpROqdAhNiPOfkHnX4I?=
 =?us-ascii?Q?5Khdcomin7mR+pcrcCFCrNFAyRXMvGhFFKzdX22ZxTnDlGMkPu6FEWnD+XlM?=
 =?us-ascii?Q?Y9II1UXHYwBcqH/FbbgdfH1R1HOn3+TVVyH6vWygy5SGV/5QB+AoDkEkWEH6?=
 =?us-ascii?Q?rb1oA38FuReK4ufXFzaoS6arG4M+SpaberbJs1mrPbLDZpA6PMDZ/j6YaRhe?=
 =?us-ascii?Q?R1B/IhaiugSSb9gNCJ4cOzOwfdgNnMyGkfGtrt1V+g/D8Tj4enfJ7NxR5d65?=
 =?us-ascii?Q?g2XKPujafEfXj/VQEvaSdDAxhnVXtM8v+V3ZF2EpdoXh+fPRUTjrbIXgkS39?=
 =?us-ascii?Q?IQ/Yx7SPO+J0NHXl5tShkDpih5EP4FPUupSWj+xEbdRhTLvTDUSq0qvV4kKv?=
 =?us-ascii?Q?pCzDITvmpHqlOyqrg+3gzLi4rCJwGtXgAco0VSQ/crM/frIJ8x1uo78M7lTo?=
 =?us-ascii?Q?d3VAVukf6bIFPKv77iVQWb4AJksTtnHEe6YUes0Tt+qeuxit+IaPJJ1WP0RA?=
 =?us-ascii?Q?OziCfdM1EdNwoIRju5UIOoaPNqElIhknVBj+mft88bp+gqvxjfPvuqQJTOuq?=
 =?us-ascii?Q?XyfOkCODt1TBwg/OVDPwn9wkumMdUWnDhs/gUUZXtjGSzBVyYu2Hi5i1GWN8?=
 =?us-ascii?Q?2z0g2Vff0xkuSu1/lbh/c9uirmj3msJFRYxGZwlACgx8neVZgtGd7xMQwk9E?=
 =?us-ascii?Q?K4eUKg/MAvQp/I+QYzyKgFynAabKFX50FMhtBTL0uDv8E3J0TudelwG491Ui?=
 =?us-ascii?Q?zJLsgm8WbTsYJeaGqIg2LjHokCPMNBJu848sc70gvXFxnOJBRBEIgBhSRKLn?=
 =?us-ascii?Q?XoITJbcDaexhdniaOM/4kJRhuPtsuRsdRRzpYJwvcjxcxR3iqhzkxVZ0+mGf?=
 =?us-ascii?Q?RYk7kvI5VmEeyN1vsIVLr2P+zM7y9PBDss6FIPdLWdAOe/dzfwZhOtEGX3ad?=
 =?us-ascii?Q?6iS1TowCMO29RiLHdmYWLLSYbHrRafqBSnq/lfGmU5lYWtN7gEb9KCq5mDro?=
 =?us-ascii?Q?5O0Srt64YiBLqvDe7b2fMkKR0FezJ6JB88vlzge0iO1oJjurrQcAcsG76goY?=
 =?us-ascii?Q?E66NcG6qBioc2jhUkfEO0IBpLVwZWnneiyx3QMBhyWGpbwR8Y8WlPYDBbz82?=
 =?us-ascii?Q?j6elk3qaEMPp9XPpFooNED2ZlH5xPsU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf305c8d-024e-49e0-7535-08deecb60e69
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:39:40.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8LWoNZzLVo+JFe1bMUselPEhFbAWU8dSJ7KsI5JArXYy5GY1dOgW/dathl/niKHgWPASCta8zJWT6GakTx+dLOCyPMQFnP+9lTSeR51IqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5939

Hi all,

This series introduces EVL test runs with additional stress applied via
stress-ng, as well as long-term testing. Along the way, I also updated the
long-term kernel under test from 6.12 to 6.18.

Please note:
 * The clock-timer-periodic test currently fails as soon as stress is
   applied. I proposed "tests: skip clock-timer-periodic on virtual targets"
   to address this.
 * On the Raspberry Pi 4, even the 3-minute test exceeds the latency
   threshold with debugging disabled:
   latency threshold is exceeded (150000 >= 163.951), aborting.
   https://gitlab.com/Xenomai/xenomai-images/-/jobs/15353275174

Best,
Tobias

Changes since v1:
 * Make stress-ng a dependency of the libevl-test debian package

Tobias Schaffner (3):
  ci: use stress-ng to stress EVL tests
  ci: Update for longterm test runs from 6.12 to 6.18
  ci: add long-term EVL CI test pipeline

 .gitlab-ci.yml                                |  8 +++
 ci/lib/gitlab-ci-base.yml                     |  2 +
 ci/lib/kernel/6_12.yml                        | 45 ++++++++++++++--
 ci/lib/kernel/6_12_physical.yml               | 52 -------------------
 ci/lib/kernel/6_18.yml                        | 42 ++-------------
 ci/lib/kernel/6_18_physical.yml               | 52 +++++++++++++++++++
 ci/xenomai_3_next_long_term.yml               |  4 +-
 ci/xenomai_4_evl.yml                          |  2 +-
 ci/xenomai_4_next.yml                         |  2 +-
 ci/xenomai_4_next_long_term.yml               | 24 +++++++++
 .../libevl/files/debian/control.tmpl          |  2 +-
 11 files changed, 136 insertions(+), 99 deletions(-)
 delete mode 100644 ci/lib/kernel/6_12_physical.yml
 create mode 100644 ci/lib/kernel/6_18_physical.yml
 create mode 100644 ci/xenomai_4_next_long_term.yml

-- 
2.43.0

