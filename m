Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538C3D544
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056933; cv=fail; b=nLg5fNK2FN2nE0fdA7N/Rr/OFt+uXM672FkGhWWKqJIHSSN40smiubeoFe1lKak1k8UZfv1X+SacGFK85n6nIiNu3kyPhRj4H2CigyhKv3MGiPrwK9AWOGZ/PIGxz28B0pHpG7e9Uhi8ETOhwpRjcTMURcTfipjc2lEUZCXK/kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056933; c=relaxed/simple;
	bh=3UGXyGckfhafNbDUZrxY0GKGhYGvIUk4J06quXX+t2I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pMp4lkYM4LEDjQzt76uliKEzi93WQSt+iYgeGTEXhA7aQO8x0N04glZjOlLGtvLwh1CzUKHneasvGsZN69eTv6V41mbsk26oO36nknh+2YEyODRgSvER3Ze39sD6FTL6JwQ/LZsfjZenkygyb7SquMfbgHK0x7YJRipKIWOdC7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Fl5M7FBI; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Fl5M7FBI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQlRlXLOQfAHRD/iUA/MJ9fpsGycmzN/HAia5POHoh28RRnVlxC2XTRkK4xdlI/EuejD5hcyqj0WklraZBSvvZjgKhT5czJPeQw1NUMsYquofIxopHoYwTbl4n6vf97qndOQBr8QZoRCzTr8Vkbys0fFMjoPNO5acXBqbtr/GYfYXd+4zDf3tREMGB0oZ9waAurjo6+HZxLJiSuiQH25zGjMe4Hbn3UG1wSUj9lBt5VfqABqITthkMvIaX0aY0/CmfNcrMdjFXi4Gu62IhbtSca0mbOudI6cPgqeEacdXZjBjI7lfES3053t3V1rsXADwamqyh61hvb7ZeaTkxtM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3BpADGy1B5eHRNrVjgOPFa71KkLR1nlBDI6v/dEx88=;
 b=xsk7r83Qq0LJHdMCvrBHkfjR/v4QJoXufNR8OrnRjK5TKAmv5QaS9ha0DklCgqfhv2K5F5K1oRQYlfGoqz9KqhXUwWoVOHTUeJm495ph3HLGhkH3GbVhQv9WbOmZBD45ALIUxFiAF/FWpEhmKBYs4Yjnrik0GByRwfU6K3n6MbUtyEo2A/ZFGSletVrJNNKFexS0sI+kdBSn1/LCWn4PbiHP202iTXo+cO9YXppHXugFmJ9LRZJLKJ6+AwighIrT422nz8xSM1TJiCnCjkLbTet28hUIOgFLPLxPjFYoVsOkFyo4MrAAEmoPaqBU7nJvn4XYF+YoM6mCcs2lLWf5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3BpADGy1B5eHRNrVjgOPFa71KkLR1nlBDI6v/dEx88=;
 b=Fl5M7FBIIavJL/w5L1J6zP7dqkRJtrpmeueCRovSnM91BVxKZ+7XyoLAr8HQ4Qx6YiRbmqUBBXx1LuTXNVdqJRehDhYd6y6zKX9d4Zy8E8AJ2fHtiablgMvveiXkvTTX1uqRBf13YkbRvMqK1gxn1SnbEZlPVF4vNlgGVtqdetOqCV0+DBz76/bQfyoT3ctMqCeNZWrSrOJu7XD8pSTuEHZaiY0+h/vznGtFOVk4aON1tK3GC7zrwmdbRE9MFWyr99TmfjM38i5qqFynSfIvDy4V2tlL4NOIbzm1WF8WQs0LZB7GRtpa9QvsGX2noZFUbisG+69D3dIQTDIDyZSb1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM9PR10MB4070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:42:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 08:42:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v4 0/3] test riscv in xenomai-images CI
Date: Wed,  6 May 2026 10:41:39 +0200
Message-ID: <20260506084142.190854-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM9PR10MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2058998f-1402-46c6-c946-08deab4b5b8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zwUSGgAfW6yRTV20PTfy23EJt2pNzlFhEhv4ddammI0ZLJFqJoiSYNnkZnZiQPQUwngrylDdKFAv4BGzjm7i/ktyyzIN0lT0hUBSILZhS/J5vf1+O3dykgJvT6FOhELvI3Qz8lj14+FTmNet9uT2Ng5rBj/DrbA768UqlIQrVuhFGggfV/0nlZ4WY/OXqSWC2o6Oe6T0uZicT3Cu4FD7Mp6dZ9r7Oz8zxERGdmGk2/e4IJ683QtZ6mMGyweFmlPdJkoOJecaaQOqFx0NtwESfZnZaW6jBzTazi5Zx3NhZ3W64mZDfYCZm6z/OxuuyVfFoW+mk6v42fQasujOSsZk8RaE29Hr3xCysAFAkNl9+cFqeMUBMQpKOO2HknvxPZXPhsHUbDQ2vETQainojYmrV4Gzbwx445Y/j0EYXMxpdbhKy+jnpFdq0Im048Ei+St6rS5FKphf5UYqlSn58PCpPEPchKrOA0Q+1CMv++K1q7fuHNUOJDCFvqTpZpKUj1wL3/Ay7yz1D4uBzAkUeoYx3OFF7ONVNu5yLCRc52VZ+uaDFM62SuQyIBskcK1mbZD+YLGPN3RNYE5epsmViRt12pESp8RUwpp6vnYv3Mqpbh9bvWUkZt3iJWA7MJW5IWB4mvSiViiQxeq7D2HYKlSH0aw92ZPePkZai7di19abmcyZEhNCssXOpH0gLY5ZbU3VSQmzM4yU002H815kAP5s9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9Z1xOCy5++dTn3GYediuo6OGw+dXn9zAjAQupQ7DadDBqLba7O+u+6tbvJG?=
 =?us-ascii?Q?MR+MFXOKPJj1P6GCwCPybvpstMgY7MBBq5LYfo5uM4GhnWDdRTkVtm1g0dYU?=
 =?us-ascii?Q?k9u0gUSdjTCWjYBQY4MnAolEaCCzHtRh32SjUbPdAuJJFKcDnWB+lpUCa8tY?=
 =?us-ascii?Q?9qIw4uHK/GG38GETeCLlfrbJSsXE5LvI5DEb+B4IQjxxgcrjiinyZMqwUN51?=
 =?us-ascii?Q?Pue4NJ7dpSclO4On5qjkGzrwAZdas8psHYkk5Urzvj7H8tIe/barLUkkLZAJ?=
 =?us-ascii?Q?hcIkhcKR8yvQtYN0g1kzZtgPygFPAK1QJMM7wbztURzQ6qXxqU8Be7OUC2Pj?=
 =?us-ascii?Q?m/uuuycpb42twXGW6w2CO28GSIOV6n6vSlagWmXbtExXQBT8ox4l/gEkEzr2?=
 =?us-ascii?Q?iwnKU7czE2OU0t/tAqTwepOuvfDkQfkkyBkut8lRVjpZiJeqpdFSvmGO2vcX?=
 =?us-ascii?Q?0EJrxGuRmIRKa1iJpgvhe1PSAzcZAeB7JY5lbVL+sCDX1quGKCs+yxZwT+1q?=
 =?us-ascii?Q?/j74Ow4vw0e3R1mUNHva0XDbx34jEqelCtL1RzDYoWWOmXUJTlPif9NDLZNH?=
 =?us-ascii?Q?fuKsPhcjn6vr1pR5RZFX3lqOimsI0TBZroS7xXn8E1HmFtn3X50M9lnKnDz1?=
 =?us-ascii?Q?lebk9Tl/Z8xPbgzq6y0AGRUZX14U5yT6FQ15gK8jJNTWXK0F4gQmACoZlySe?=
 =?us-ascii?Q?WnTojXdDuyIJD+I4+faHC6/s/wXEI+6hYyyPNYIo8EurnEUNdinoKunBB9Pk?=
 =?us-ascii?Q?5ehw6A2LkqgdWn9fvh6k4pGboDT9KZ3dXkB9/MTvT6AprYz5qzAWv5H33KpZ?=
 =?us-ascii?Q?5b3u1jJRRQd3WvXRYTchUXZ40jiTHRE1AdVBevpPzDorE6hoMSTKJxBbpIru?=
 =?us-ascii?Q?ak5LEzFVWX9BpboKx2qn2ETOFqRillRPy4NZWkpkRwNdzlAEQANA6oqizmqd?=
 =?us-ascii?Q?zGWj9HJlNmJo4bgvTTcUGIaTDZ7j4zpuBmFaMMZLF9gcd8SxsZvHK4Ep19f5?=
 =?us-ascii?Q?C5S47ENZhFfXN/AEk1oSl9XBXNjQAPsckfecT+ptF63ahlQbyKCgLVQ4iHNu?=
 =?us-ascii?Q?h0Hp8iM7pv2w2Nper8KTW/73DK78Yqv+/zzwCuWsx3I36+Iapzn4QhG15eqR?=
 =?us-ascii?Q?D3S0yDU9UzofszMsYaUa4ghzX1JYLxKDWuci+EHZ6o6dxbs748uKhakmidD+?=
 =?us-ascii?Q?E2RWWYm/Bb6obdMq7U3fHONPuOEWkKHfVGnk80vGnbJ6aGny7gGw0RP2N3df?=
 =?us-ascii?Q?3TcAkmkvLI7s1tkjrirMJPhDmeD2Rkk8FJyBa9XLB6p98etzt4sMXK8MofVz?=
 =?us-ascii?Q?on7yIeb3aKx0CTXRyn5pvZmmIcubPyC16hlqJEHsRMvNaRk1yhCs2+LySlRk?=
 =?us-ascii?Q?7BgdBZKOji+9RTeksGOEi7swF8QoZOEWbGGb79lfdlZLIBSLfNODU2GE6amj?=
 =?us-ascii?Q?BlkEVnsuobDEGvlUKM7rL7k4uyv4j5nTE78+vwz1MSbfFaI5FyCNkK2uN3am?=
 =?us-ascii?Q?5KpCyMGDwWLT82mlPr0PQj8HLA556dgjpP64e9w+tcfZkPt/Q7b/9tOI3kR3?=
 =?us-ascii?Q?/rF24SGk8syVOYUUIySe7QDruUoU8qjnS39K7QikLUTXDn6DF8NuFfEsFP/I?=
 =?us-ascii?Q?XdXTaIyZ163CdDxmtmMgL6lgsxJMJqQbnWb2Ky/tFcqz3yodNiTpKccsu/0B?=
 =?us-ascii?Q?Cq6q9MVAfVkGZMEjd9f0FYtmbLdA2eFlblrkQJh5Mp/jP4HisG9UOT2ukBhd?=
 =?us-ascii?Q?TEQzJftFuPO5T7v6PCdlrVjP0faEmsQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2058998f-1402-46c6-c946-08deab4b5b8b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:42:08.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plIAJtAoFDuDjH0COBREIJTWvMWFZjSdCrfILzOW9lWPb4UbaEbXtym5t5kroD+ZFCLBSTd2Ize2JZcGDuVmnAPtbHACRUd9yMjCdGRFTN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4070

Hi all,

this enables RISC-V testing in the Xenomai Images CI.

It runs the EVL test suite on both qemu-riscv64 as well as the StarFive
VisionFive2.

See the last successful run here:
https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2500187079

Changes since v1 (the RFC):
 * Do not depend on meta-isar but add the visionfive2 BSP to xenomai-images
 * Use the latest openSBI version but stick to u-boot 2025.07 which is
   unfortunately the last version that supports booting from SD-Card.
 * Use the risc-v defconfig of linux kernel 7.0 and add the needed debug and
   nfs switches in additional sections in the end. Factoring out the snippets
   for all architectures can be discussed in later patch sets.
 * Only run the tests on the qemu05 runner (tag: SIEMENS_ERL_QEMU) as long
   as qemu01 runs on the outdated qemu 7.2.2 which hangs up with riscv
   workloads from time to time.

Changes since v2:
 * Add information about the used board version in the xeno-lab to test file
   and commit message
 * Add information about the used u-boot version to the commit message

Changes since v3:
 * qemu-riscv64 testing patch already merged
 * Cleaned up the mixed up commit message (sorry for the mess)
 * Added StarFive VisionFive2 kconfig entry

Tobias Schaffner (3):
  ci: Fix deploy script to handle multiple DTB files
  riscv: Add StarFive VisionFive2 board support
  ci: run ci tests on StarFive VisionFive2 1.2a

 Kconfig                                       |  5 ++
 ci/lib/gitlab-ci-base.yml                     | 21 ++++++
 ci/lib/kernel/head.yml                        | 13 ++++
 conf/machine/starfive-visionfive2.conf        | 21 ++++++
 kas/board/starfive-visionfive2.yaml           | 15 ++++
 .../opensbi-starfive-visionfive2_1.8.1.bb     | 19 +++++
 .../u-boot-starfive-visionfive2_2025.07.bb    | 31 ++++++++
 scripts/deploy_to_aws.sh                      |  9 +--
 tests/jobs/xenomai-starfive-visionfive2.yml   | 71 +++++++++++++++++++
 wic/starfive-visionfive2.wks                  | 23 ++++++
 10 files changed, 224 insertions(+), 4 deletions(-)
 create mode 100644 conf/machine/starfive-visionfive2.conf
 create mode 100644 kas/board/starfive-visionfive2.yaml
 create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
 create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml
 create mode 100644 wic/starfive-visionfive2.wks

-- 
2.43.0

