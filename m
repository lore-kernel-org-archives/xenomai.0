Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE953033E3
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459447; cv=fail; b=U32Q1sgQx6mUrTbnraKEI5M4qhb7vCKGFflavfGGA46ZQKX/PwmjcHle7MCk+uc7WPxWgCLzZVUj22+RV7JlzjNbOVYJti8wib8p8ItjfZczPEb1a8EqXHWmaTJ5ALYMDE14JHaBFHMaUJTeegGhta+xd/HQopkjhZ3cuv5v2NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459447; c=relaxed/simple;
	bh=tD0jebtqLJXLoBlTIgrvH4B0kRIr97G9DJMV1Uu+vBo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TeDPHxmCK1OH5yqevIXXXM6W1JR9AhBtz0MCRHo3Fqz0zmETAC0gknscZz6RJZv23zOkK5wBTrm2qksD8YKTNHCyDayuivfjMqMZ9Ut9OBjxlUy0CTMV23jDIgYZyFfxa9S/pprOeRcYbnyn1tyb+DifjW/MOXpZLDB1MP2WFdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cAov2h1Q; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cAov2h1Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alXXtjY7Jgt+v0loLJN2p0/yEX0IOFVWGAtz8cQ82Gf6uHwx794wGFCIWIFfBNqpWE5yPTZC1MF8+oPMJ3OzCUBSaMcFktVUgahhNrMyjgU05qTqUeRv7q8Sza3TS+6dYR+kF0VYZKyISAIdvy6+HLf3/OW08Ye7vSR71cloSjRy/w9ZM92TsFlYGrlXmVLCipHqc0oK3+IZVU+L2YbV6dPDWaEBgjmXKBdNR9n+vuVQOnrPoMyr5Ykpnm9feLLWPQ0m8kYJoAymp1uWU5fR0jva7HFMVG1aS+Ajl5ZKWFO8vS7hgT2+E3P5IXL1j5+XpqSmFGIaiSkWrjdOj8gqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm0FoyjnOl1RoFbQEJO4X8sbLsEkcuZB/ISjPGP19l0=;
 b=VmLk+qgCVcFlIYP9C21wNaJaT38BUiYdciQ37d5HWBLI/hgvMrWhKv9VqVIM8U6D299/3LK62ucfIbLpnIoArhkBuCY20xpsvvZpt6vW1BL43zEkOlyyVQ8EFV0vADOYVoW97HyYiwKMXntVZXbz/8lz5UTpLOTkNANrfoH2B/IRpmsmtSM4Uq1FkGkTWDeFHOy9k6bjeg3KsgBK9L4+VHLHKvxv6VZJqLY4rH7jsqMJ0kRquvHDfuc4GVNanQhHm21DoRXzh2wq03/b4BTYDW/f0m4qIxsO8GLueDfr3An2stR6IQa2bKoUYib+zlYzghwpy1+qn3SlG+NSTTENvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm0FoyjnOl1RoFbQEJO4X8sbLsEkcuZB/ISjPGP19l0=;
 b=cAov2h1QJ13oL2/TvkxqTvlMeRxmWcqYWl5k7jFfUK8SkcUsTx2CHIil8J/SnO9coe9hc/yfVZ+ZmlSef6WsrLbK8XuJ8aOrn0UhTEvKG7lFk+6jV5bIgrxPqMb4eJoSeaqZgE4AMt3A1YtnAXkaXGUgDiG5Zgg5zDvYXaFc9BR7pe7fF3En3GQ8+snJYmAs4k4MMJcVsOyQsrgbY+eVGhFX2LWkFoFktIbaH21PEVZqdLXWIJF89b72S1NZPu1t2KxE6uRZc8+aTI6/t9XSzAA2c8QTs/6bbrdnue1aQOcqaf4WfwzRlcbmEvwguOT7Kbx5OgXZRkmC7fw+Ba4W5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:57:23 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:57:23 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images 0/5] Test riscv in xenomai-images CI
Date: Fri, 17 Apr 2026 22:57:00 +0200
Message-ID: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf00d83-40f2-47b2-65f8-08de9cc3ec60
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	euF2fA4FCy/sEaBLjsgDQbBzbxki2efgiJmz2jYYo4oFEP2+3jZMadv8NX3slhI9oEI64e8wnkWatHI4psH/s5tQjxbI8tzvkp2rfUv+WHO0iJCtqqgIHtDs0Jfd7r11W29gRHk8Tsgyff+YuWUyyfN4P0OpdP4wyR2HdA9QptJ9l/ycSTiFOxc39+di3+5OqiCdn5LrReiIBY+v5vU++oktI6b1GvwgQTjbHoQWuPG+KUE+ZdkpwzD51ZyrIFOhB5sStZlllLSDgFLK5rgZswm3hKSmJwx0XnL+E/ImvaTEiZNejhiSSzzXg/q2OJPiW8Qy5kSvKa7nk76kHum1lRgbwXKAnYK8z1mtbruQ+2K3g9QwXy4z4HT/K+xTQPHskX1CGX5phfAbRyR9nDPz8XqaewQeXMf/Im8RX8NuDnNaWQfu/EhPDbLuMKa46NjxNvk6qrtaOOK0984qlpflSS5MZOQBM7ikAcMeXWL4husH9t1z7wNeCYLRobOO7OptZumDSjuze9R+FLlaCQwjY2ddDB62YVZ5Z0zpMSLPKewMxKhSxLIovopAb86xn2DpAHLzgwfKxFItMUeAQoWyGvEu5mnLBUw0so4s0lU19gxEi30uXrjZToH5GNEEZZ8Foo/DnD5s1+1pWoMOVFC/G33LRgQvSw3q5Z/Vxdi8vfGxhjia1AUvxNnf8Nrlhf/u+CsUhbPAaSUlDGh5Nt9y13vtBW7zYlqOc55C0ObrVQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0dhMUE0eTZxb2dkYlZseHVFNnluekZrRGlNY0ZpMDdwWkV0QTJ2RFlZcjJL?=
 =?utf-8?B?YnhGYkhvd1RkWGxlcGQ1K1k0VzVaWFFKVFcwL3VGdnRFSm5McTNZaXZQVFdH?=
 =?utf-8?B?VnJIRnJDQ2ErellMaHhDY1drczZ4QVNhZG96S1ZjWW1vem03WHlFRy9OMW5Q?=
 =?utf-8?B?djY1K0V3eGpxa0xCWmNCdEc0T0U4TW1KTTBld1lZZ0l2NWZiRGV3Tnk4L2hK?=
 =?utf-8?B?empvc0F6dlY4UTVaNExjOGZyRTRTVHAzY2ZvUzdLb054R2dySWFHS0RjMmdw?=
 =?utf-8?B?ODhnakdMT2tEM0pnUExuRmwycWNBbGs1TWJubFE5Z2ViSFhIUTA2THJQVVh5?=
 =?utf-8?B?L1FkaU5ydTFWUDdaT3hnMjRlais3b2NhN2JaN1Z4MEd4ZlI3ZHhBMkk5b3R1?=
 =?utf-8?B?Nm5jRS81TzlpTVFUb3h0V3dRN3RhUjFQUkE2Ly81d1NWU0V0cDdRQVZoSmhD?=
 =?utf-8?B?czZPNms0SFN1d1FoWG9OUE9qWUVzaThVSXdld3VwUTFjazd5eTFkNzBqdXhO?=
 =?utf-8?B?MDNQRE5UNzZmZ09MU0ZyaldwY1UrL09VUEVrUHdoWGhPRjZ0V1lMMmJuTU9q?=
 =?utf-8?B?dno0VFdCbmUwd0dRTkZpSW1NbUNyT3BTY0JsMnlmMi9Rbm1Bdzl2eG9KM0hx?=
 =?utf-8?B?dXorRTFqKzNtdm9pa1VuMGR3SW95NnZtd3kwSGdsYllPWVpXNFNrSGpkVjhL?=
 =?utf-8?B?bzh6RFNYbW9Idk9JSVVFUXhsZHFEMk55V3FUV3ZPT29mQnFTMW9ONlM2VHVs?=
 =?utf-8?B?dSs5c2V3VXBZWnlsbUZTb1lmWWZFV0ZVUUpraXZCSFZEMlhtdmZlOFpIOVo3?=
 =?utf-8?B?YUZOTTFkRHJQcFh3U200ZHJ3TnlZYURDOUQ4ZDdCTU9lR0FTbC9zKzdxWXpq?=
 =?utf-8?B?aHEyVGdaSENSaDlmbHdmM1BrRVNISVBnajdPZXBwU1dPRk16b1hrOTFYRThJ?=
 =?utf-8?B?a2dWQWx5bEV3aDdyTnpHck9BalBLVytDN3IzdDBza2s5R0dzb2RnOGYvTjBh?=
 =?utf-8?B?amRIeGV6aXBMYS9MOEwrcGVJKzRNTjdwcnZ1a0ViQjcvcUY5Z3lUWXdjQW5C?=
 =?utf-8?B?NnRQa1VYOUlwcjR3eXlUNld3ckFBaHdrTjN2dGJBMEFBL1JoY21ic3EvRFhI?=
 =?utf-8?B?dWlJbjNVaE9qK3lrU2wzVnIrNTZtdi9FQUFhTWRYTzMxS29NMkx2Z0xWMnJT?=
 =?utf-8?B?cC9wZWc1czV3QWdISDh5RUN3NjdEVG0yeWhsTFA2cGhmWTFRSS8zbjlEUnlo?=
 =?utf-8?B?cDd4V0Uyb2Z5Vk45cHE5T1E3VHBndjV0WUxmdGhoMVpJd3JsSlhNdXRCN1RO?=
 =?utf-8?B?OTVEQUg1UW5aY29qNStBT2Nob2NVbmZMcHFKdzJTQm9UczlmUG5JSmI3cUhK?=
 =?utf-8?B?VXBGZjhVcUhMS1ZaTVdYbzRkZ3M1MHZCbHpNS2tMWWZ3WFV0RjZzMTBDNUVu?=
 =?utf-8?B?cG8zdGtRY1VMZkpJcEt1MGY1R0k0Q2RJeW1yNm93VzhsaE43eGlpYTY5ck10?=
 =?utf-8?B?TzJ5SEtYd1ZlcEZLd1JxaWVYZFZRM0FDM0YxcVVqd2FXOGwrcE12ZTczUW0y?=
 =?utf-8?B?aVh0VFNxczkyYmdscXR5MEFsZkJRdGNDTnJIOHE2VlNJQmhSUHlFdjlIeTY1?=
 =?utf-8?B?OFIzNWpvZ0JsTmN0enRXTWRqYk5SeERqSkxxakFNWUJzUE41dktuQWZ0VS9w?=
 =?utf-8?B?YnBtWWR1SU5YdzBNUUFPWmNHTmxyK00zaVI5T2NpK1l3dmkrL2xKZ2N4S2VU?=
 =?utf-8?B?MEFYVEU5ZFZQVWNKTUQrREdadXE4MkJzTHhjK25Dc3Z6cStIK0NBY2xmeDZN?=
 =?utf-8?B?RWExSTZGQlFHd3VOd01RVEZ4TkNzQ0p4MWxmN3VKQzEyYjNVQzVIdjhJVWVG?=
 =?utf-8?B?Wmt2Z1VWZFVhRjhmZ0pPSzQzVEZXbnpwakpDTEIraTQ5cEpDTTFUN24wMkVP?=
 =?utf-8?B?WHBqb2FiOFdoRGZFTU91RWlvYkQybmJaZzVaV3N3dDZEL0wrMXMzYllxaldK?=
 =?utf-8?B?UEoxVW04bGhUeWVXMTJhWUxvSldMUUtlZnB3U1Azek9ZMFF1alZITHYwUHBG?=
 =?utf-8?B?N2hISDRGMGlZOXZMeEhsVWtjRmJxUVlSc2pkbVpQN3F4UXFyenQ5ZlB2ZmRG?=
 =?utf-8?B?VDg5WlphK1BXcGJpc2s5MWNVYk5MS3VMR2JxeWF4eHdHak9CSUdtT1FRa1E1?=
 =?utf-8?B?OUZtRWZDVEtkU0hUVHplUWRSNTE4WVQ0bGxNN0Nsb0YvTDJMVmlzczlXU2Ur?=
 =?utf-8?B?ZjVxL1BWc1ViNnU2MGlHT1hTR0pDK2d0REs2N3dpV3dSTlJoUjJXL1J1Mzd1?=
 =?utf-8?B?dDVIVENuWjNqcFVFUlhVZUxFSWVMZjRtUExnWS9XVVJPSEFVZngzcHBEQ0dt?=
 =?utf-8?Q?IjU+tv9WxCBj6Np0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf00d83-40f2-47b2-65f8-08de9cc3ec60
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:57:23.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmQ2stqlL8/oqKuNwIldnxjRdD/od37KxWn+j/ME+9+sVMdyU/7fE1UPKweADUq2pWfxlJDktkQlY0Vy0kufuF+16S/g2ERth4RgqHWZjok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

Hi all,

This is the current state of RISC-V testing in the Xenomai Images CI.

It runs the EVL test suite on both qemu-riscv64 as well as the StarFive
VisionFive2.

See the last successful run here:
https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2460891121

Open points for discussion I would like to gather your input:

1. While I have already proposed a patch for `evl test` that integrates
   an interface for running a stressor in the background during test
   execution, we do not have such a mechanism for latmus.
   Is there a plan to merge latmus into the evl command, as was
   recently done for hectic, or will it remain standalone?
   If it stays standalone: do we want to integrate stress command
   handling, or should we create some kind of wrapper?

2. I do not want to add a fully featured kernel config but would prefer
   either to provide only a defconfig or even set `KERNEL_DEFCONFIG` to
   "" to force a fallback to the kernel version’s defconfig, adding
   snippets for the features we want to enable, as I did for `nfs.cfg`.
   This is related to the "Rework linux-xenomai debug configuration"
   RFC I posted a while ago, where I analyzed how to factor out all debug
   options into a separate snippet to fix the inverted debug enablement
   logic without changing the resulting kernel config. However, I no
   longer think this is the right approach, as I do not want to pull in a
   large number of debug config switches that are unnecessary and only
   present in other architectures for historical reasons.
   I see that altering defconfigs carries the risk of breaking
   downstream setups, but at least for the debug part, I believe we
   should be able to arrange with a snippet smaller than 100 lines.

3. I had to pull in meta-isar to enable the use of the VisionFive2 BSP
   implementation, as I wanted to avoid duplicating it. The implementation
   in meta-isar is outdated and needs updates. While doing so, I will
   also add the second DTB.
   But is pulling in meta-isar an acceptable option at all?

Looking forward to your feedback!

Tobias

Tobias Schaffner (5):
  ci: Build and test the evl risc-v port on qemu
  ci: Fix deploy script to handle multiple DTB files
  ci: Add the starfive visionfive2 board
  recipes-kernel: Move nfs boot configs to own snippet
  recipes-kernel: add debug additions to riscv64_defconfig

 ci/lib/gitlab-ci-base.yml                    |  59 +++-
 ci/lib/kernel/head.yml                       |  26 ++
 conf/machine/qemu-riscv64.conf               |   1 -
 conf/machine/visionfive2.conf                |  18 +
 kas.yaml                                     |   1 +
 kas/board/starfive-visionfive2.yaml          |  15 +
 recipes-kernel/linux/files/amd64_defconfig   |   6 -
 recipes-kernel/linux/files/arm64_defconfig   |   6 -
 recipes-kernel/linux/files/armhf_defconfig   |   6 -
 recipes-kernel/linux/files/common_nodbg.cfg  |   2 +
 recipes-kernel/linux/files/nfs.cfg           |   6 +
 recipes-kernel/linux/files/riscv64_defconfig | 328 +++++++++++++++++++
 recipes-kernel/linux/linux-xenomai.inc       |   1 +
 scripts/deploy_to_aws.sh                     |   9 +-
 tests/jobs/xenomai-qemu-riscv64.yml          |  93 ++++++
 tests/jobs/xenomai-starfive-visionfive2.yml  |  69 ++++
 16 files changed, 617 insertions(+), 29 deletions(-)
 create mode 100644 conf/machine/visionfive2.conf
 create mode 100644 kas/board/starfive-visionfive2.yaml
 create mode 100644 recipes-kernel/linux/files/nfs.cfg
 create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
 create mode 100644 tests/jobs/xenomai-qemu-riscv64.yml
 create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml

-- 
2.43.0

