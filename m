Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77A3E1213
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972003; cv=fail; b=H4KwYx17C4UtfJVndzP4srOs2IJQsz3zrjTivvPg6Xnb1KQpzVOfxxUPCumRo5F0VRKvPSJssuW/X6Qhc8SG7zeRIZZvgTb4Wk+nfpC07kvNSD0tveUEQmevKYD+lsOYKEyy0ruEYsqEbqo2v31szN5Sm+0VHJpdJb7Qj/BDx3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972003; c=relaxed/simple;
	bh=8xUXX3kt3JfBmavEJULjl4IANrjnoAv+mkzF2A497Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fk6lZZU8SefWJDuTj4yjpIoZpPebHleoNKOlnEiKyxTeYvOC9r4zLteEvw8aePiFgBG3xaFAiU/UcWYhlt+8gwyDpegzl/FIj9p49sLPOTkBCzsRweUB8I2s2SZe3CnfLmn+QjvkPJ0kzJKX1ZPlSa7lxN45FBtlH4KkzQTu9Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rIKPKEot; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rIKPKEot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knYbpwbV9/Xjp024BBUI3/mXYTwQnRtk9//RTLzo4lw0Z4F4fJlEqlgIOo6ClY77XJlylROdrsTR8v3xH70/hNkfcDYAfDB1+YmnCxnGrAWBFN3Ue3oxVVFLhh/Lpt15zl56W26wvdDZZ1cqgynbuuZOfLicH60h0EbvKyozK6V25LPVvdZHQaz4X03nXeASFk9crlBuIkDsZzLa3w17oeSfweV1oBtVLxkrxFRLC473tNxIiGDQoKbk2a0WbmwX+5GLINvDGT9cpkO040rx+5JSn/CWzZGNzkRMloiklCzWqdUTvRhhce6NLz/zlCcLQ5Vd8aTdOVvD0IKSrFbl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0llLxUmXyDhjckM9af1kK0Py6piCYRhATH8auiDTrE=;
 b=xYGNzopRUe6p6wyDLD3ATbywLODPcl9Ao1sYVCt4p9mqXOSciNfH/Eb7BmWNf/gwiTn0abzAJApFLae84RAtFXZQSn5VbqQbTs6m5NzwTKs9J5PbnTvC8SjO6xBTcF3ytHpnUQ3Axr6xpsESVz0JAOzRhf8y13EPq6+2181PvLEvxdtc1uDELgQ1rvv0jjMj+aJ0Gh/TWbfOlZpMFhheW3iugDw1xkuiIvO3JuWCY6JT3Lv+WFh5PlYmh7eMtSZbreKLn5jfawoaOiB4INf0t0hQ/0o/Em7D603qo2hqhC8cideV2nxwriq/WgsZNH6GjsIVYSW/ez7F6RWr2pNoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0llLxUmXyDhjckM9af1kK0Py6piCYRhATH8auiDTrE=;
 b=rIKPKEotqzWnhLdYebMF8AqEjnlrlZON6I5Rbnx6VXN+64Tj5RiuPAfpsDMszeslJryR0G7b2Z/fgdQQYl3VlBnP87VEPkn1nEGSpYZJQzmrrtSBoHe2EUIXMq9YnhkeOdND2KPhokgYe1r0jn8BAsmOBaFNugfE94drE12qTPfx4HxFlvBA4au293tAqfBoPFNkhzAmxEC7Ylq32inFaBv6ggfzQNxvP6SGAqkYNZiBdnXQu8WcCdsIjnoeo2oF83TfS0SIxssu2dlKRAaSqDQf3zlK4ynNJroQ2fydGEhCDwF0Tlkeg/8p9FXRlLfvI0LLvuobYG1cjSzEo973Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB8PR10MB3942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:06:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:06:38 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 0/4] test riscv in xenomai-images CI
Date: Tue,  5 May 2026 11:06:23 +0200
Message-ID: <20260505090627.65515-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB8PR10MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: 542435c5-0fb6-4fce-2451-08deaa859d6e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/EZf4cuzEHMuv0tr7nw3sVHAy3hsOAFzY3naxiSg8GT/xqmZL5TK7tyKMPhZ2mbdOHwYiY0OJrdIOpgDYgWesgKWSevV+7e4yo3sJiLLKQvmb6C46JW26EXWpwFS6O919HYqJhR3MvfYV2eqzzBUhJn35d5wIiFDaXeAUrbVuhcVjnmi4R57Ukqjd2h31r13tI9wO/OH0SHeI7PQ4WRyztDtclVgLvOnZ5dxcjkokCHAWLEhg7KsetFNi4gHAHagvhgJXfDC6tGqyRtbrerWHzu/VYNs3iZAZwc/ElLglqqCaQxjVfU0w4v05c03dzKizTpAa9g9PgD2UdUd2kocQTPKBy0y1vXwoJMk1AjYwi0W+JAjYkaGaYmvYgA6iHNN0dNBfcfIFwMfv3ymM3OC5xggW6iPxb9dFRaI8v4p+ZyH7x6yvhQCdrhGZFgAcy1D8eKRSxUhmMXuHAZpb5wrdAmTauuqJ6aTOl5nqsh46D0xM55quU3vWeEJSCTCTE5UMlx7ZR84Fct8dP39zH6fdofYuKgFbFEE7SbpnQOfM5aLTWD72NOgo5DlQHJANczkeIq4/FrdpxVNY7+G1bjT8XMks+D0IOhEyirasRzGOOt9xBu3AZ7gejaWTwkvZ6O0iqQs+r22aZBA3upN2cbUlFjg4gdZXcCRb7CwbHkugIe3FAB958RhQLGCX7OGDuA0qgLNm/5U/KPe9/QBBIarwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uDdZTCHOLsuR78joCAM4v0Mq3ItrgxeO7IiqG+f3tKqJXKMJUV51uztXEDP7?=
 =?us-ascii?Q?vW1UFumXAFH2RbjfjwVM9lsFjrTe71RghcvJiSNzOBNDH4GYSrYYIZIwRb/P?=
 =?us-ascii?Q?rkc03A+2WaLt/iIfFzd6qKhsj5Y2INOSQVH8GZ4Yi1WhosExgBIAheS2pOCv?=
 =?us-ascii?Q?qcUF4z4atvc6J/6PTb7yOZwd2J5df/DcazkPsHRnba40BXVkUzWnGl9QbKGP?=
 =?us-ascii?Q?N03ZVdYBeYPfb1IyIW1SJKiYqv2nHc8QJP5QuPNrQM+82MM1PWq7KlfcsWgV?=
 =?us-ascii?Q?7jXvDT0ptu3AeyV73yz1m3jFSzSlJ60QC8NIOpIKnAQuCQcebZo1TAug5zXA?=
 =?us-ascii?Q?ormexE8KImxI0OO0cfxD1zmYCNmVIUo7zoG+7ehVhuKRdiVXi87pn0oAZRbf?=
 =?us-ascii?Q?9dPNGRe0c7pqQ1Fmp0B1ZNGcINUQIhaqZvmvkVTGQSFlXrl3zLf88iKaU6mz?=
 =?us-ascii?Q?Mptx3ZPijeezqq8ehK/s8I9EokhvFadPMEJU0lZhSojiytRXo2WRiBUZ4Ipo?=
 =?us-ascii?Q?SakSFDO09ozojii5FKeytkmTaMdxNPNpYfNM1QugSB5MiPCwkYT2VIalZyc0?=
 =?us-ascii?Q?95xiWCJ8w7yErwktapjZL35OtYCd/+Kp8j6QxCCFk7MgomhrJqMXVSiTeCFj?=
 =?us-ascii?Q?o/j7qRZoNwgV2TElsFKV+vVZ5zIWSWNXsKlXx8YACyrUfJhp1H1ngLB5gpOM?=
 =?us-ascii?Q?Hrtx9Hh0nN7GSwpcHvY7/1XLBtPOL6Bi2eEwEhcgmOx7SdM8wTdFImCE2XB5?=
 =?us-ascii?Q?RD0CIki3oxxuX3YM0sF7iY5S6igW1K79aapfNQKRUXRETeK/aeTV4QakxMs3?=
 =?us-ascii?Q?uF9sheDr4w6Ozb2ztgsKNn/XRbEGJ+kUTvuAAdqFchQu71wNhUuEBnhU/sq6?=
 =?us-ascii?Q?S+N0JOpjUbMOdonYx6KsTLMPT6Mcin0dA05lsP/b44fyakEBGsaAaL6sJTKM?=
 =?us-ascii?Q?x4y7qvAKvUAp2YKaDDCjb6Nu3X/ECXOhURIK+gIWNe/ck16LGjpccWBEzdFB?=
 =?us-ascii?Q?AoZgboT7rvs4cDcOPaH8d3/2nMehDFC1+zsIAVAvmdu1ZkdgMqee3dgto3Q5?=
 =?us-ascii?Q?WAda/Crl1rUvYfpXAasC4D90A2WkfMQ3f0yN/cHJwxZhCXzECWwhxJVg3Hiy?=
 =?us-ascii?Q?H6ZOyKXEDjXAg21pas08pJUY9Fm8ksBm2r9yZDcT9n9ICH8b0fQWouP0vyP0?=
 =?us-ascii?Q?QPBW1miFdrZk9Z/sPXlxDlWsE53lAzztU5SZ79KjuVDhk+R4gkrBC27XC0p9?=
 =?us-ascii?Q?WvvuTCdQhr+KQELippT2h0Dnm8k8G8+mSK8XRSEEIfZgUsMJt51LXiPIZpvJ?=
 =?us-ascii?Q?32upQLB/uu4kgGnHEfkD3CX0qM4zBVn2/0QBRAJ0rSkwTauJKoPzOJ289HKQ?=
 =?us-ascii?Q?x/Bv3DoYP5y0fS1gYrIFWQKEU3gqkY7qUd5yirhdynptfcuBq91iSzoLoFWv?=
 =?us-ascii?Q?3+hFkVwPeYhWcAa1g16JBUtWv6kGWQjpSFCD14MyKqRpMOty2qyyW0wxXIjO?=
 =?us-ascii?Q?xSF0P6ja74tbz5SBgtpl7qPwjvfR7jdbByoNpXjyKHKeZ69dqTzmMeTNoRQj?=
 =?us-ascii?Q?V0eksix9YRVRD8dWIkuhFAvO4pn6W0gJUOop+Shs2Q23xToLSJIu9nlh0DKp?=
 =?us-ascii?Q?BuXrmYauZfqYpeCQjOP7kXnAQo7xGkfXh+gUwrKAgfWYw9jrTaM/q+1y5fNS?=
 =?us-ascii?Q?fX97BJuw6x061kwyU4yOCeePMJFb3xc1iMcH91QxYiN/rLkk4HKtLK7Slzn0?=
 =?us-ascii?Q?1d8DXEx8Z7PE75/ZjaTr94iHeBzPsS4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542435c5-0fb6-4fce-2451-08deaa859d6e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:06:38.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO1ME6n6AWb7kQQ9Vr17YmubtFEsPH0HdDU4amAn98VceXf/aqVPBEJOApO/TvV9suxkH8+W6B3M/vrp2GrpB9bIdDIJ8v+HY2bFHDUbobI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3942

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

Tobias Schaffner (4):
  ci: Build and test the evl risc-v port on qemu
  ci: Fix deploy script to handle multiple DTB files
  riscv: Add StarFive VisionFive2 board support
  ci: run ci tests on StarFive VisionFive2

 ci/lib/gitlab-ci-base.yml                     |  59 ++-
 ci/lib/kernel/head.yml                        |  26 ++
 conf/machine/qemu-riscv64.conf                |   1 -
 conf/machine/starfive-visionfive2.conf        |  21 ++
 kas/board/starfive-visionfive2.yaml           |  15 +
 .../opensbi-starfive-visionfive2_1.8.1.bb     |  18 +
 .../u-boot-starfive-visionfive2_2025.07.bb    |  30 ++
 recipes-kernel/linux/files/common_nodbg.cfg   |   2 +
 recipes-kernel/linux/files/riscv64_defconfig  | 335 ++++++++++++++++++
 scripts/deploy_to_aws.sh                      |   9 +-
 tests/jobs/xenomai-qemu-riscv64.yml           |  95 +++++
 tests/jobs/xenomai-starfive-visionfive2.yml   |  69 ++++
 wic/starfive-visionfive2.wks                  |  23 ++
 13 files changed, 692 insertions(+), 11 deletions(-)
 create mode 100644 conf/machine/starfive-visionfive2.conf
 create mode 100644 kas/board/starfive-visionfive2.yaml
 create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
 create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
 create mode 100644 tests/jobs/xenomai-qemu-riscv64.yml
 create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml
 create mode 100644 wic/starfive-visionfive2.wks

-- 
2.43.0

