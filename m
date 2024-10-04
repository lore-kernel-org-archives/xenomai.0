Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777B1DD899
	for <xenomai@lists.linux.dev>; Fri,  4 Oct 2024 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068801; cv=fail; b=YUVtH+mgbdEOMnKT7+623+gCpCLbCbcXPU+ozulD3qwhZYn+a0qYm4PrbFL43s3qbFdUxvfpoFrGXo03+5jdIWm9oApDLRY5e2T5bd8WOJnU0K8GOQJW1AT7t/43l2CvhhKP+ACoLPMAdc3eWRKqB+94lN93axyi7EinrMsp6m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068801; c=relaxed/simple;
	bh=OLGVr34GS43VHks+PZpieIWx4B07L3iCaHRNT790u0o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mWuDEbE8vrurjG/hs5zXvSRBUTaZVd1U1+PaNOjGeBZV6QvWqFbxV3pProLh1B43nc5RHiEhywMsuTTWJBUmbOuOyfZA3q+Ef/yksvmQT2nbMEIe8RhJ+XtKQO6JtQcQTFu9/skLpGARsSYXJfD/PFFnjSqpwPt81r+33Nlv78I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xx73yNds; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xx73yNds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApFWW4DyntyVLsrgXEIaEMTcU0tfY9VmU9vZX8wD+CDeZCWbhKTL4CZvdJn2pu0QAc62drVtx47Z4/WUKTehrGVDg2vY82WJbGJ+bsHHH3Xl7VfXpT1hCKbFpNWtlYFDEznoXDFg7p0r19PUBgVDB+AHKtbGywCdgUJWqNVnIkRFk5Gajv+HX/6aM2VfNaqhLtduTLGEU56cT4ry69pm/S3fNu9z02kpZ2FR6b9dZ5WI5M2NbLKpGuGPR1owqrSX7VyEa7LX5GKHu1QnqgAYv1pUPVSAYIeo0fWWeVyZ4auafo4C4W0V1QlmHYyxiIG2dZWnZu1eybLEsSHySMsBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QOtpT8Oiks1bVkymqVUJZ3WP3v6Gh2vuTWm0c+y6Qg=;
 b=FJysxDamAmffLzVPLtE2cu21JUOPOXf79tI8h+rP+WGm+lRH4OlFXKcrLM7E23jtaPar+DVOLAX9z2AglNGvdKL21F86wQmrno1I+4CS7IiB9OYC13v5HDIQPl4kxGNtgmJnEnRrkeac6kK0VNQ1EzOtiLU3sIYa9lO/ZWPTpACKwv9+UAR7xrNhL6CUrMN43LPRUT0hYmhjUP3BD5A+bBZmjJR7SbfSdu2zWS2MnD41T6WsQdT/tM8n0iV+5iDstrrMGOAxez0NPyxmVpA9ikvduCH2tvI96WPRWKpPikljrNoyN6O4dVFrI6sOOLdoOMDVICZWYr07GsLF/Fsf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QOtpT8Oiks1bVkymqVUJZ3WP3v6Gh2vuTWm0c+y6Qg=;
 b=xx73yNdsaGghl+UR2D8t6ihvaPq+Ao3rVcA2ZLPfiPgTiLr8TJ5ZQketbuwERuCRxyorCMoVyECT38/KKJWrNaDmZ8Bqwzpn3O/8AXr7QsF7p1Bx9XZtQ6m4EnAufMCZ50WDR8m5CZ6t37WvyEHUvrojCnG3jPow7uEwyOSvUC2Sfrpk9pmuhmq5jeQQkF97lyavg7oMRAfu9XHQDtr2BsZMBOUtZDYcnycnc8juTkNaG1vI6IMO77WbuR1rkqMdJo6fPl4jF7gQAIPZt2GYpmfZC7kOefJ+asv9/LGa5yFblrbhmVfu/U4tVd2NpwqVK9Y8c+L5RPLRDasGtwx/og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GVXPR10MB8343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 19:06:36 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 19:06:36 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 6.11 v2 0/3] RISC-V: IRQ pipelining core
Date: Fri,  4 Oct 2024 21:06:30 +0200
Message-ID: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GVXPR10MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: f853d302-ee26-4920-efa3-08dce4a7ab4c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMaqFgYYRdcunQ3NmbUNE8jqkZfDvGpBkgLT6dbdOTtLpHAunNIn3hQdKe/5?=
 =?us-ascii?Q?lFZeti7NqwB7dg37naa+cdrvnEioxpsDIE1qeYLXf+N8x+J7pxCbEBgdPOuz?=
 =?us-ascii?Q?PgUoIVUJGfv+SFtsjz616+7m6LSxLdHuoeeJAKXmreIXKGILrXTkiFJUPBAR?=
 =?us-ascii?Q?0swFyc1MyHAMwEZVBx19rw1mbKlKx+Y6Qtiq2BSGRnmB+lJa3bPLoZielkZB?=
 =?us-ascii?Q?M52DAk0a7nfYKPitADKXEdMFUAtjoyy0b41XQrBtCKWescnj3Z24L3Li32CR?=
 =?us-ascii?Q?I0ntbYrM0t57KzxDIJg2JA17h+dYhEABy74EIr59k06I2CK9S0DFOGtE0t1s?=
 =?us-ascii?Q?T5D4+Z9+qovRpX/d4ItlKGxQYH4YlA+E0meZ1oj1TfEbHv4aqd04icsLF0cj?=
 =?us-ascii?Q?+FOpwIcSg6FWOJNWaYZDf3glYTDAiovLEEqYBmVH6Q2rMR+dP8XNR9cZ6e5Y?=
 =?us-ascii?Q?PstM55vg946IKcPqzxTz+7zClUmVUwbqaCoBqGx9XO1NXJv67qw7FoqiWaWS?=
 =?us-ascii?Q?3HMVeE338Ga3VXkTJpF/Agn7LU9XThFFKnWr/jA3MVqUYWRdKSTWBxdN6Ih4?=
 =?us-ascii?Q?ABjXMU2xN3tynglgTcsDSpGUrgkY4usLrwNKUAaHZkNaZ9q8OsDzcdayDIJb?=
 =?us-ascii?Q?MT+FvZA40Ya+v6QAK1PgKBYQRCgE2v9LajFK16tTMVv/Rb34tZKIPNV7pCdN?=
 =?us-ascii?Q?IxnRp0hVkfypbAfRrDrieXXD2xufM1yzxgdP/y1Cf+KZ1ki2EOjvlhit0EDE?=
 =?us-ascii?Q?GXuub0GiBZP4hEE+SMwSjZpfTXL5jOypGm0p0P1pic1OxGWsQkbGIHl2vOse?=
 =?us-ascii?Q?T1jz5fKvtq/v4pyhid0EBbRFzW5ZM7+zxMMBAVX9RDuE9YKRq5QgdjXPyPxv?=
 =?us-ascii?Q?HN4Vg7J+8m6uUhKrHAz7EEevtiPuEHjNLVHvh6SSXjJwdTcdl1KimY/D59mq?=
 =?us-ascii?Q?qj+AoH/xylpFodFi6A8tGqTV5pBmP5/VLYjpo51Fx0Q0l1WPc2uoFrRHbABq?=
 =?us-ascii?Q?HVFEGD8AaH0Y3+0XKFAA0wceaDLjZhRE4gbmKyqO79y770VHcWQZJ4dWsAkA?=
 =?us-ascii?Q?uoiktoL0xrYRcv7+QzAPbvZO2xCM9zti8EF3L3Wp9SpIEITYIV3Z4lvaRShS?=
 =?us-ascii?Q?Zmw5ABlQd9yegfLNGssqv5d67Y9bPctG0hU2HYooGhM7RspTgqRIJS6Ydtb9?=
 =?us-ascii?Q?kuXZEyZ/4zxGD/uUQD8lNcLJ42uGVpzxXuDKfCtwvsr0TAy/+JxoJJNebLCc?=
 =?us-ascii?Q?2FR8a6CT9vgOvw/t5yG8HEUhmu06biFhuLO3QHNAKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+NGKK9arfD5H8asqJsxTIvlwEIUUmTnvIVJYKkt2rKRpxC8KrXRuQbRZn1i?=
 =?us-ascii?Q?A8ayG8Lo5QhpxYklV6vZYy1JcdKZabo5UaRvn+Bg3qZtIS7WQRqytHKDn3Sa?=
 =?us-ascii?Q?5d84hTjtAE8vJywHR9ON67+eGMnPKY09Xw/m+KedtFr13yrBukejaPe/mcBX?=
 =?us-ascii?Q?GBmat/pd/szOdGU94TozX4FBY8GhQtigRroXSSjoxJ46fZkblhyA4AmZNJfI?=
 =?us-ascii?Q?ajseIOtJBuKKKPR/DbvQsmzXb6CjpbndGMC41n4VCc4Sdk3SDZx1D6XPaKjw?=
 =?us-ascii?Q?nHKSDpjd1CzBeXwm4Pp3dqf9WlO8rNdjCsrFXjJ4iD+iy300xKLwYwqaH9Ac?=
 =?us-ascii?Q?LwyfUM2w0lwtqol5QSCHBiVWX718ZtJWFMHEWVpayiSuvBnmNaFIdoJhIMoj?=
 =?us-ascii?Q?9WQWMcUKFD745RZrpPqEXwH13J2Bb8ogBmk9LJtqn5PszLaUekudhmyozFFy?=
 =?us-ascii?Q?1tq0tval5eSMYI3mx9CHjSKsAd3Upwyx6RIe06d6IrgGFR4RRjq0r1wvaCJ8?=
 =?us-ascii?Q?zRmtdSo4OMgwbAj358Y3POU4ERPQmvfeItCsTjx3EB7Z5/8qzunC15KXq/eL?=
 =?us-ascii?Q?Gy37mnr47MgxYu8W1HKzWz+J26SgcfedrvNasqam12CmZOhGbNnTjFcS5IkS?=
 =?us-ascii?Q?FKAcVvre4yO1bVUpMTTkw42oAPjzMIyMUsCP0PIRyENDAd+uDeGK6VU0pO05?=
 =?us-ascii?Q?DbljuptLdn3lgCc8dE9xft6sziYEBenAJIDJvSWrYGkaTtlSL+GDfofqkeuT?=
 =?us-ascii?Q?fJ7vU5WGN5a5qmHO1whal8KFhL6JmsIN644BFB/nQizArG4WyGF9NcmwRkrb?=
 =?us-ascii?Q?uamtx/HJs/MRA1T/4JW39ej+mpjDc18kmXJEbA4c3bPPGWHiCTKmujgWDoj7?=
 =?us-ascii?Q?IIIsfbnuQJg20NbYPdROzkMktqoFd78a555741vGZ3/tbk9jUuYLwS9g16pZ?=
 =?us-ascii?Q?/F0FaNSadlWcp0E9OIH8vWZzanDjDVh32TfsxKcJ/j9UZMHA0ZOm8GRS2TIs?=
 =?us-ascii?Q?KbU8Sne+ds6dWeNaN2Ic458qkoei4gsULXVpUtOGl9cBd+jv5aonkD1+FM+7?=
 =?us-ascii?Q?aNN2DZJWFHq427N1F/hRRNTlImgQqLMV7qypg+UaljSMzCF8nVEgO2tObMGE?=
 =?us-ascii?Q?hK2IcXegF73PW3UCfD31I1gz59dR0PiTHSQrJR0R6owaochDZqtAZ2uiZg+W?=
 =?us-ascii?Q?4JMqbe6xkgT+pb8g5kQ+sJ2LVUgov4x4PlqgAUOisQ4sQO9VDpaGQ/D1/Blz?=
 =?us-ascii?Q?9WLQGYctgTnjHyB2pqMUh69Tv3qA1N70jTA64ESH8VeddJ+CY66W0XQvyXQa?=
 =?us-ascii?Q?7r4YpwWNUWjak5l/llM8xRaqvyejbmaPXLfEwKniyCYHuzKSQ5e5raGvEa/u?=
 =?us-ascii?Q?vQJzkcR0p2tux2op+U11igsUWCnn3xs2jckIQO4BGHA3EPZOSEyRkkdKlkQj?=
 =?us-ascii?Q?bLBrAiRIHYIpCNerpqW4XsO37PStigN5YzmVfeyQ5kYXzbCMqRqFF1t5+Iqg?=
 =?us-ascii?Q?VvRLE2iNbp0o933g7KEhWBeqlwVrpdHryHc4HisdARO9PUcXvHWIk116Ky4P?=
 =?us-ascii?Q?d+zY4BS41v/y7pVA+/gUw+wzXG8wzVW8+iYngYu2zCSfm7t/2oLMdq0QsN1F?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f853d302-ee26-4920-efa3-08dce4a7ab4c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:06:36.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F7U6fMNmQMuFAO/foDJT0FbFwkBWqjlS8jdX4kUR3p0bpM5/R/gGO/jpWVT17KRoJ8rIe7oGK/dAh4kqIBAh/DF3HWYFj7RqyXL/EbDHBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8343

Hi all,

This introduces IRQ pipelining for RISC-V into Dovetail. The patches
are on top of v6.11-dovetail-rebase. Feel free to ask for other targets
if needed.

I thought about splitting the patch up into smaller parts, but decided
to stick to the structure of the analogous patches of the other
architectures. Maybe this will make the rebasing process easier.

Testing was done in QEMU with IRQ pipeline torture tests, both with and
without SMP enabled.

Changes since v1:
* Removed some dovetail specific changes. These will be readded in a
  later dovetail patch series. Thanks for the kind review @rpm!
* Added a patch that guards _TIF_RETUSER with an CONFIG_DOVETAIL ifdef
  to allow building with IRQ pipelining but without dovetail being
  implemented.
* Fix unneeded reordering in riscv irqflags.h to make the diff nicer.

Tobias Schaffner (3):
  dovetail: Guard _TIF_RETUSER with CONFIG_DOVETAIL
  clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
  RISC-V: irq_pipeline: add IRQ pipelining core

 arch/riscv/Kconfig                         |   1 +
 arch/riscv/include/asm/irq_pipeline.h      | 143 +++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h          |  25 ++--
 arch/riscv/include/asm/thread_info.h       |   8 ++
 arch/riscv/kernel/Makefile                 |   1 +
 arch/riscv/kernel/irq_pipeline.c           |  26 ++++
 arch/riscv/kernel/smp.c                    |  93 +++++++++++++-
 arch/riscv/kernel/smpboot.c                |   2 +-
 arch/riscv/kernel/traps.c                  |  51 +++++++-
 arch/riscv/mm/fault.c                      |  83 ++++++++++--
 drivers/clocksource/timer-riscv.c          |  11 +-
 drivers/irqchip/irq-riscv-aplic-direct.c   |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c      |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |   3 +-
 drivers/irqchip/irq-riscv-intc.c           |   2 +
 drivers/irqchip/irq-sifive-plic.c          |   3 +-
 include/linux/entry-common.h               |   4 +-
 17 files changed, 420 insertions(+), 42 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

-- 
2.43.0

