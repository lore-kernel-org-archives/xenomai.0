Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4C241CB7
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938897; cv=fail; b=J4Ay3zFuPujqtMeWW7WD80995PjjgUTlQrroh++FMlnssJio06tSIByWMJmY3tNSvXfo20izCD5GzZroB+6qv9Uv98lCqosorGxA8X8Qmmhsa7T0WzvJpUwnJJqrDxDw98krr++ShQHLxhxXvmOB2LywdmV509veiXFykOw93v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938897; c=relaxed/simple;
	bh=BOIQslANjHco4XjdEDMk5cEG8ZHziHrnVTjXglDVezU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ueAgmfKFkJ4IEbmMd4MAtJpo37iD+4kxAmb7Y4h8VpoVCOJzzP7YWXEqsoxL/5yb9hdjDK0qPZs7MgrUeaJmLE+W4Ip7RgzmfPBqgEdHbR3F8Zl4NU9NphebiJez32IVXqi/eXJJTXYNyymw7kvOmN/bGpzCVoyDxwXwvno8kEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TpFteWiZ; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TpFteWiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybsrcitiy+g2KyktzVq61CzXjISfztS6JhuJLsjN9FmjMy154CD1OW7ayWDPdmerjRlxDz+H5NpIKqqnSGxVsQHl56fs+Pv4EWDr3leuXr6C1+lgY8fDaWUuzULBIPowIemNF2Me3UWB4tcxOyxidHLvmRG0qfWIJ5zYulpjjIl0P+M24xqqOTnZnnsK2d/xIGKg87bVhYopfGwXGoRtP6qapW5Vx5bNrkBqoHVK4hPgpudQdAZYzP40gfBcFJmInCgxO0xrQgwg9cEZY6TmY2j+v8fxfrTlSBrTVei0FilfmUKddCNYOh/8bME7uwM/Zt3CNk3WjuPz15dmKxy1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfsxGFfkhi42taHWvqk9NqQBXr7UJUyqiaeaDQhxjYw=;
 b=L7+hy1tufze9Ae9m732npRMYY/w5/vprJ3A6QnmIPJQAFdPMQOOAhOvz1D+HvzzxbtchVqS9DJ4lYORjiTsNfPVuMx1MxuUEWJRMzNJjo4oi9yyScWMsdP1y4b8NWoGCqXjN2hYnRqxZAZb/1k+gBZv2e8UCBlysgWuJE9Exss8ZmSsVfVVf1ZkPidB8jBjqgnuLlq2J0PfsxpNyKnFIaML4zqTH+TN5IbHgmUGS/OGJck+vA7QFbRkSsBuzU7v/tUyqeS1q2fEWQeQVIIsDX+JY/+zgY7Sc6bmdFAXOM+TO6d4KR9Z4EBj5Sv6ypoYezW36a91w79jqHqi+opg9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfsxGFfkhi42taHWvqk9NqQBXr7UJUyqiaeaDQhxjYw=;
 b=TpFteWiZkLN3vkEAsYQnvHTNKnznBu51I45RQmClphghmF2FFPTyo8kmlnlnOo5uvgTqfFarZBVAubwN+7xLRFFcLsXL60OSauukpyExi141eCwmWD/tbPVRBPBNkyhT6lOzuwvWh52iyKZ7e7U6eXO9c+ztON8+LT2yQsEwtfmRxXFRjaof8/WOOGKMYYEWlr1Zd5c/yapqO7SIjJtqox/xu/DUEpt5NY4iWiCcYdeBgO+FZUWHdx41SRAJBTzw8baDLOuYnGa6eliBkkIGT65DKuzlPkBzZgs3GvHsL1LKPXWj28DBnLCA/3RBdHzSdgiJ/VYTLV+TaXpdctkhlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA2PR10MB8787.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:34:52 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:34:52 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v3] build: add initial RISC-V support
Date: Mon, 13 Jul 2026 12:34:45 +0200
Message-ID: <20260713103445.34208-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA2PR10MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8eef1c-b9ad-4465-fbd4-08dee0ca5fa7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wrjc1+TO9oDKXn68jeuJaybuz++j/SHX0qQF+Cq7r8kWw19kA90ipm4iCueclX/Pz+Vb9eEGAOVEfLaVB/fCw+VEfQ1xIcbMi3HDgrxcpoxfzpRfmqmJlzVlwCMA4cHrIR9ita7nLCLIuuwQIT5Oi2cLt9oU8mZYCYm3IAUtXaW/ldzhsHiE45DAPAOtdNTd8Hjv2kqLbh6o4GUzrMqI5j/tiQqzUaNeuYHah4ggoKXGDjaVb6xJSzJUA6KteLClO/yFfm97/eTZkYdj2g8URYoIMS6RXfU3eRQLJlpRJ+1d6H0chB7X56BOixDiGX1Wl8XThaQI0834ZzUhxyTRQebjpNEGS9y2z9T3oyzNziCADvsEOSyhibcYLpvZ22sMucQBrxt9ccu0hBSZBv16o+N5tntbDHvZeCUUOSbHrlRScOrYqzOQK9vcuGKepVs2zIs2rZYC/4LXUkpF/sfrjtreR+Oa6KwPShtEhd5cjX8QyTXK5yUZNVFUdh2fFR2zTnOzEGZRQ8Ekuk4KsC5o2+fTcVMxdu076tvIuxqbyJCSxlGKCnpepCJIehP/4007VYXK+kLYKEZbnQ0qnQPrd2IIlQ+fOm9FRUCiu/skLDyGn02nfCZ9/wnVCxUUKIY2V9g4cDmo3ldH2quHeOvYQqWV/q/psm2e02ExGpPMgWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iodrh7mdcpWLBBHM+YiCyvCDNujWgEZqgs/gevpI2OCQ7sfaT4hrEaysddTV?=
 =?us-ascii?Q?kl2WYmk07NVor/SGpC95ERaFzoWoBp0PauNezc9LSBZa0ts3Iegs898hlNWV?=
 =?us-ascii?Q?ibQOQDbarDvrPlunLxTu3eMAwLCM6R5LZ9TpWQhtfuj45docMesA2ArqHXKY?=
 =?us-ascii?Q?PYPSo4/Q3QvpgIbkwEdivXv9EoM446wMWiIJmPzx5h1IfAHP92lAN+0pHaNY?=
 =?us-ascii?Q?lsFeHb0yjBn+Uavk1JcnhFibuKSMz14PEl3pz8BUDosuzUw3apsbPLAvwBCd?=
 =?us-ascii?Q?sq+qjBF+wOMsa21qyiS8HiT+ymaEm9WZbn+xGU+/tJhAqeMBEd90i6uc7Mpt?=
 =?us-ascii?Q?3T/GhoH5RvoXl+tFDQmnNgdt3Z6p+Jn3a7LoVCtCQS9KJTViydTmqSAbVTD0?=
 =?us-ascii?Q?thblHhlw+ZxF4nbFnprMTXHL/Tv61yTqS27r6qz6Luhb++ZmeR+p8+YTMgai?=
 =?us-ascii?Q?uHTEwEhwCNCkDerMKJcbHPgJt51YZ9QDmaFm6ZiTYc2/c1gLe7CqjASE9lES?=
 =?us-ascii?Q?0iboQBQrsiAnb76/LE1yCTj1jyUuugaMAxtEmxEmf0z6/o4t6OXw6j0Vw2eU?=
 =?us-ascii?Q?Kp+mOVxiTAAyhWX19V1K4zs6BYeuGgTF0SdavC18f01doahrlEBopL7/2atC?=
 =?us-ascii?Q?cY4zIdwnd2cYOFLpq2RjlF02hovVSaw5jwQXE9PZF+9tGizeQ4ENnFO83ozq?=
 =?us-ascii?Q?+4oKVy48nCFNRLY/FeBAgB6mn0ia8/74SKgGlDOnk2oPfkJ/n5WwfBRWH6aN?=
 =?us-ascii?Q?5CqXXwZ+g2p+dx9sQrkHEFwfzC1J2199sKzEjOqeDoL3ykivh1oXehf55EeP?=
 =?us-ascii?Q?9vrpykKtT0pEzQigaus/vrbxeXAuHBmxljWDKYgc7FzdoXXKIjX25ny1NtMu?=
 =?us-ascii?Q?mrjbQqrNlMPUQ4QId5Ggmr8y7cNwydtG56ZsGoV+75XZ+X2jMzvdroXGTkMh?=
 =?us-ascii?Q?kk9lCGwVyHxwyMriXfmzptF/X0VLU3ajBzjFsZbDn/D+bXU7/snspC6vqba8?=
 =?us-ascii?Q?xR02nkDunfDWrrJs4kwIINEMe/ZGbFc082u7LkFob3mCgd/pt2NUMrzEi/h0?=
 =?us-ascii?Q?3wFxa7AhIQXoD5U7hk1EpoZlY+uVI+Hv75+92fhXex8xpcwSb6M/lG03YGl0?=
 =?us-ascii?Q?A8whSjXSnp6JNCeuE1UfkH18o9eZDTCL7WiWS9a4jKBXIG4Zh4DjPWkg4UD8?=
 =?us-ascii?Q?TH5E6yaioaDNO8+aOCDgttJSNpEegU3EgVnRCehK8cSu/wi7TAqjD2vcKFna?=
 =?us-ascii?Q?pp31jtkAeSHmI105oWWYrzPIpcCs96Nr9iwXUb5uGvHLu6ig8wKykE5sm2UT?=
 =?us-ascii?Q?QW1IiIY3gVuTBN55DrHxxZh2/hIWbfR+zjgf2KA+0fFuVQZwYwa75LMqCjm5?=
 =?us-ascii?Q?J2VzsDfu9apox2pC/EdbqUME/m04AtBB68gYLZ4eWEf49Df5kdAydOe1QXf5?=
 =?us-ascii?Q?5Y/bbHkvptiihz08s0yjujEV/PkyNvMFZGIZu8ME+Gi9GgolhmgXOGR1vxPK?=
 =?us-ascii?Q?dBHC6mdN7AtWQz4w/I/Q3B9gCKFTOvjAeNdPk/ilcJa/F3w6U0o/WRg6fLg/?=
 =?us-ascii?Q?YNDvD2R084T/FEriw/+rbAHKQ/y770ZbILjBfU80lESHAS7nLtOirJ8Tlwn/?=
 =?us-ascii?Q?v/1zac2yIQld988jtfWh4bEAwwso5A03oH8Jg+NIW5xR37FZDcfDaA2T138F?=
 =?us-ascii?Q?Z1B1N9jNus7+dIuTnUhJPs1dgio+TPlkeayG+B7tBp0s9Z9TtgFhLNtFDTlD?=
 =?us-ascii?Q?l6qHoRUr0CNnS7Pttq1o85TnNgizIto=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8eef1c-b9ad-4465-fbd4-08dee0ca5fa7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:34:52.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpLVAeNmDCcSYK5IiJdDQUHLEaViOZVOMelVSilkhGZL42Ox+HLTbvsNgjgF4NBLjX/wua2QE6tqkpeysSreNcQ8WaDyEUvrH6dbHsqPDsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8787

Provide the basic build infrastructure required to build libevl on RISC-V.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 meson.build             |  4 ++++
 meson/riscv64-linux-gnu | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 meson/riscv64-linux-gnu

diff --git a/meson.build b/meson.build
index 674c661..4acbc40 100644
--- a/meson.build
+++ b/meson.build
@@ -63,6 +63,10 @@ if libevl_arch == 'aarch64'
     libevl_arch = 'arm64'
 endif
 
+if libevl_arch == 'riscv64'
+    libevl_arch = 'riscv'
+endif
+
 post_install = find_program('post-install.sh',
     dirs : libevl_scripts,
     required : true
diff --git a/meson/riscv64-linux-gnu b/meson/riscv64-linux-gnu
new file mode 100644
index 0000000..33c47e4
--- /dev/null
+++ b/meson/riscv64-linux-gnu
@@ -0,0 +1,17 @@
+[binaries]
+c = 'riscv64-linux-gnu-gcc'
+cpp = 'riscv64-linux-gnu-g++'
+ar = 'riscv64-linux-gnu-ar'
+strip = 'riscv64-linux-gnu-strip'
+pkg-config = 'riscv64-linux-gnu-pkg-config'
+pcap-config = ''
+
+[host_machine]
+system = 'linux'
+cpu_family = 'riscv64'
+cpu = 'riscv64'
+endian = 'little'
+
+[properties]
+platform = 'generic_riscv64'
+needs_exe_wrapper = false
-- 
2.43.0

