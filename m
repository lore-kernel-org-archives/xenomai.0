Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012035.outbound.protection.outlook.com [52.101.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4E2D3A6A
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085422; cv=fail; b=QzprcmQmVxY/BjVqYgMKYc6/68CUn0lJBTetdEa5TKuKO+GL5k+xInZSKridubOuWIJRCZIDSlnxuxisBgbijGZ6iTdHMyeQoIRcoKv1dkoUww9Pq2/woH0rd3hUtemGJLuqAowgMLbM9AHyYmND9q+ytECNFmz3k4v8zV3hRDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085422; c=relaxed/simple;
	bh=weqrRN42vDlxAzt0KhZiwADqYOxTL6FIepoQT2sqbzY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t/9pkOa656IVyRXB+OBhC1fqCGH2ECVMx1jJM19eX/KbxpgoiHIOObx90tYUe9W7CmgMGT4ATtWYivCe/FHFnvjDW8rb7wuwIeHORE8lDX3ZVSzGXcMJMECG6DLXUqUj4B2Pa+qtZvzcElXT77UE/D+5WpuDmMVnKjgiWdlQMPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CvVbzFB+; arc=fail smtp.client-ip=52.101.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CvVbzFB+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7q0wqbx6z/EWh6UoFehdajXzqnxeX9AvhFS7IZ38uRGM59Mjqu6uBIGAbZPqhlfyvd77UFGQZT/+K8ZMx3kYXj7Oq9PPBIirXsi0PAj41S1Q99u+LqrXoFcJ1daodGGQ2Uy9/AFN8gyscFd1eRnDycUU332OzgJzPVsHaFB8WL4A2wh6ppBC80nXF3MiLdtKvCOTSScQAG6j/NqXgFq6hMFM5hs2p7g8w83oS+mTQSi6Hc1LE/pQkVV5MlhJkv0xcg9Yxv9ttbHDmm5BY0fofj2fI4bS0aQoKVBiB4fKC70spTovUqrFglW7cSovS5YdGZTyjYUli8Mwe8K2v8qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=170XBoD7UNReMt0r6nJ5S+kvCiyAPf0tNickngOLjBs=;
 b=zKsXW4VmySAjyx0oFXnkfbITNdCvB58emWij4BeTu4eOm/ZxoLpy9zVe9FfiPTee+cEwOoLZbING8IWSJZJYbguBLPplkhbiMOssm7idDaE3KsLQ+DvtNdHkkQGYL5qjefOZEZKXuHHyn2DD9hNTS4m3sY3TIPkBOENr74pVTMqumTUHOZPYYUMnMtDdStFarfFXY/04VUUy8zR+3222DD93/dyybjTllAifsu2vhwVrLeFGhSzjiCPx2A8isVoolL+V6Hu3W2QaNHoNxvOT9Vn/BQWq3/KbepDsmTManNZ6HSNIMKBCHyCDAZFWFjIeCo9AB0lpJWKRqWRF0ZtBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=170XBoD7UNReMt0r6nJ5S+kvCiyAPf0tNickngOLjBs=;
 b=CvVbzFB+TwcJyTOqNXme9f4jw4sIwLjIHOYXTRXTiQU0DAPYxcCq3Q9eOCcpbg9hf1keU896PNg858eTL7Kjxilvx0/CJNWVNSaa2TFz5XIcGKd/l2KIRWtHiNo+wDzvLDhGq5NC1+bWlERdXQtICnhqevsm6+CFyOCKpjGb9oY3obQlL8RtVBH2QCIuiIUrsaa8wueYd0h6JSBq2B0T9x3+utgxRWNdKXFwKfcMWKpZTwxaidM+Ioxbrdkb9fczLLBwVvk/PvOLuCQDWBrXEyIooo8O7EG88A9s+eBUlYD3t75AN5nF0ISXkdl4bcsvENxyT9mELdFGBbwsdsanLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6375.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:556::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:36:56 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:36:56 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v4 0/2] Add RISC-V Architecture Support for EVL
Date: Thu, 22 Jan 2026 13:36:44 +0100
Message-ID: <20260122123646.445823-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc62c6b-bd6a-4860-9e6c-08de59b2eddf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Da5+UTnDlWtwco/eMkD2HeJytv7DmkpJY8E9a+weLn58BIoNKw+hZzHQuARZ?=
 =?us-ascii?Q?PsNUnX4n+H2HWOtnePhLkXyU2dzSoOrUqlfPV948o+ZOCHwhxWjGMzhAKj9x?=
 =?us-ascii?Q?+TL3NB08FMQzS/73ZT/F2kWTuyqL1uXPGjWb0MkWD0uGWAiflo3HlC5IuPCZ?=
 =?us-ascii?Q?cWzdvpxvEsKvnh+Ur4dh8b9NcOHbj0A6NeIHolDcdq61vTu6JQZsBvUYSXH0?=
 =?us-ascii?Q?Ul2lQ3kfeC73q+1MgVIrJ2kxzO4R03RYws3IyllfjTMPFgS6HIdwRbVPF3Vg?=
 =?us-ascii?Q?rZN55/yPwFtqBMm1I5qVxdO+txv1P83u+PiQnmXZf2UXA6xmZkEz1ARcYxZI?=
 =?us-ascii?Q?PaUN1kfQWtaY0tIwG+S5uhUTCRmYBrS/x7oeYS4heU+r5JHJyyUc44S2XcFC?=
 =?us-ascii?Q?UNNIh+knOtpGhWHYd9KJISSU1iRJeBX88QWG9JvLLKWjDxj3pE4uWsO57hFS?=
 =?us-ascii?Q?g67i2gei/vJ2GRdTj99D2knL8xzpgW8SaQEKw4vAdLdYQdKR5Y8WkM8QUBxU?=
 =?us-ascii?Q?O+21PofFw+ZgRAJynizdy1dN/Woey+1vEn2TyN0GHkGgmaZwakIAVWTx6AZx?=
 =?us-ascii?Q?5yVTjK04Bo/+6e9TsNzeP9J4Vms6yfH/KogdyPQPYL8QGS5Tzdruch49FaeO?=
 =?us-ascii?Q?ImlzkAtWyG5QTy4hdc2+CQsn+0n6nwqT/kYIWuidt1rZ/XOtbx0Q0dEyJaaH?=
 =?us-ascii?Q?g21e7QL2+CwQf/SKfRqluk6De8G6a5eeyitp6Xq284B/d0vrtE1wlk9/hOb1?=
 =?us-ascii?Q?H1g0p/H9DU2GoNPSZa/i4BPNdRk7FM9NZ8YlUpCz2Za/RC/r+ncQHygybRi1?=
 =?us-ascii?Q?u7SqH7U6Ic/7T7hAGz1bBaB3QVxe2Jw1id57KncNpkf1IhIOyrc6yi0GUc7X?=
 =?us-ascii?Q?ajn8aMKUIMa9t/ebvaU7W6LB0Qq2RTdaJkhW/HbA6kXgPHXz25GyF9LtRe/q?=
 =?us-ascii?Q?FGp9tyeJFA681TmozsT71zf09MKkGPuYn3fevZ3fw44GdZbJpa0HLrVRsvuw?=
 =?us-ascii?Q?uj1m+xzE8eSH2ZuJ+mXq59QJHbSHDclxnshfvCJETGJjpDZ/5e/2QCEWR7+N?=
 =?us-ascii?Q?38b3zdDM9bWV/Kgxm2Rb/4rMy/d5crSabLpzO2sPl1DIm0I4VMdMEfm120Zk?=
 =?us-ascii?Q?UkfKtKRMRczxu9KBsIL01SPWkTTdR3S7kaJ25mcPhl95WMslICPCtDSFNW6c?=
 =?us-ascii?Q?s30/wv0Kspu7L2Vr5wIvawvNpCaCxnU61NM6FUDMZNG8Oth5yzppLMVDE84s?=
 =?us-ascii?Q?rmPwtgmnrVFCa58ORQfyuzih/+3nOV9BKkP7jCQmEV8w247qKT0HqQSq90Ud?=
 =?us-ascii?Q?Y3Z3PZZQ4YmkIeScBDAk4k++MBJmdWJdLS2lsQs128LX3bQcoaniguhAVvfm?=
 =?us-ascii?Q?7ahOL8S+asrsuvFr4TBm1keyP/tbphBGvN4NU9eSfWczNmepKI0p7KWJT6V9?=
 =?us-ascii?Q?8FubzONUVUMiRvMVsWSKC4ytIBMQMnfTWOjdNPeDZy61jrOca2JqxTaIS7am?=
 =?us-ascii?Q?eTWff5e4/Ovb/FkTZ9WrlLnPLUtQhme6vM1Rq5VLesUcFjzf4kOg1u3nLV9J?=
 =?us-ascii?Q?+Yo7/3/xd0xSyq7n/qU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6g3R0ggQEJEQD83KlOGIZvHPTh+dAYFzTK1kKLXJQx+8GUSRDvv5M9eRLHu?=
 =?us-ascii?Q?NtA2cC+k4N2GLKDPEYNeprc3LvmCJPvqiS7AUC0cXixyx+6A3plIdpRnShmT?=
 =?us-ascii?Q?O0r1HU6nPyG/WjdsB9j7iuZGBi/9uxaj96IVV7hFGe8/q8TqepqNM7jU7C3p?=
 =?us-ascii?Q?Zem0lYSpNfCeX8mZCGFmWSKWuL91q8Ut/RlsqLDSWShd+T/N/ACrr+Sa3c18?=
 =?us-ascii?Q?Dmkqx/bU34dDzi7CXwtSdIPz12hEjUoFhYhZYbRrI0JxKlZh7rmvc6ejEs7m?=
 =?us-ascii?Q?ujYMbVcSYtIXl7BByhBrDI5H75qDqvVpvZA28CqSZwvvcpPiSJxm/0hsFl3T?=
 =?us-ascii?Q?0EBXL7tES/TCXlYnP6Gv9t0smY2oa9BJqkvsWxhr+HRJLXUDFHtxIfwVSjEc?=
 =?us-ascii?Q?AZRyL1EZry7OssgYt7H9UAcqyAncVTdrSofbCSEmKLLfMToCgG+g6ZJyopDy?=
 =?us-ascii?Q?fKOPS7ckS/4WFI857faU+iGr/oumLmOewf6fzM0RjJQTmsvM52RwZj27i2u/?=
 =?us-ascii?Q?GUifrTl08N8VhcAgfiUbz4SD6laBhN575DgFBr4hiz+Sc0puu3QAxrFg/Jou?=
 =?us-ascii?Q?+q+vFnKLaYQ79oV9s0GcQaK4TOww2UfaLStAE2XOqKkF3XDrAuZVirdeXPA3?=
 =?us-ascii?Q?5QFZuM6sibBvtTGCG5haOydY215QMYXAQz3jtRWKhpUlVBibgTkrNDZH86Yt?=
 =?us-ascii?Q?r3x7UhebnoIaAPn5USaYxAa2I3mvZOyAvRyOHmfExy5VQpt3NWErbVNSQh9R?=
 =?us-ascii?Q?AtRk9k25nWATlm667FqanhfuxVJzX2ur3rDwsdEfZyvn7uKjN2VQq0i/nVrG?=
 =?us-ascii?Q?vqU8W3NKzTGI7Y4tgHSnBDlFSBSuLxtY3XovuG3rpGAqkibKDXOYHBe0aZKU?=
 =?us-ascii?Q?wltfm2uOa6yT2qWfjDMnfozy2Q/NEkFHxig7G8u7VsAs/9/4jGjGrjMw0TXo?=
 =?us-ascii?Q?I1+IJKC3hnMUIaT1xATZLrpj1pu+xw4Lgae4q/lOiJzmvo+wnMOPnDc5JAzI?=
 =?us-ascii?Q?+zdZPSComSUj7XoI7DF06x3hxlYNLE6VhTs+aGd3JqGK5O0VNwM1or8x76NW?=
 =?us-ascii?Q?T6GskQH9SY2d2MbaP7pQ1EP8KO90x7huvD1xJpkB4/riAEtE4Mo3HTFj+BOj?=
 =?us-ascii?Q?eFYVxsiyoxyAL+nfOoPy7Uwn2IvMBD65pNMbzmX4YSGy2uzuChI1Ll7MviiA?=
 =?us-ascii?Q?wAXweGFdyI4mAo2bkzKWWoWurG+uAQeCipIJCqB4y6JXYpjGiQoi3qQtIjed?=
 =?us-ascii?Q?xyd3rc9YZFGtrB0k8mFF5ieqTMSKyadS9c6qEDBc5QZ8rxH5p/0kQAhxzkCI?=
 =?us-ascii?Q?gHzSo87nbQZns1dDrLRAuio5Zud7ceSIGvlMhDOfcwN1q98vZGyqtHnzBqj8?=
 =?us-ascii?Q?a2VYhHx586QyQ1R0o+IbrjOIOI0A33ozBqjr0n+GzjrdrgsjQ4gxYVgoSOkd?=
 =?us-ascii?Q?mApGvFHOy4nbs1kwiVuItErmxspQTcUPujfjYT8gFLAD5CEGicz8dxXJ5FNq?=
 =?us-ascii?Q?cMHmRf4G/mdKIyyEDbWSeAsyQClclzk6hyqoGMVn++60LQVh5c/UIphPv7TE?=
 =?us-ascii?Q?LWgx7U7vUnzxiRekACPg2VH3CBcMW21kHbdNhbKcJW8wS2OAkOQQhu1szADW?=
 =?us-ascii?Q?uba132F8uYgdu4dzxXfaai2j2gEiR7ZvOXT+0AbbRAT7ZxTA5t8CFm10dt4q?=
 =?us-ascii?Q?aF9ZE0lUSm2E6IJtjU7sY2plI8I89riCpVHsWv2zxd+KFtJydbgjU0gjIaw7?=
 =?us-ascii?Q?5OReiRNEnIQnYnAR4PVOmWRK04m6Jxk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc62c6b-bd6a-4860-9e6c-08de59b2eddf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:36:56.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tmRrcA7VCMaF27f7rMM4dlF3Ub+oiERAq6FTZqw0MOx3RvCZ1a2M9LxdsG12XPsXA2HKOk0aEySQBlP0wrzvVJF5+cSSI6myUEU8ZH+2LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6375

These patches add the necessary changes to build EVL for the RISC-V
architecture and to boot the image in QEMU.

The patch set is intended for developers who want to experiment with
the current state of the RISC-V port.

Until the RISC-V port of EVL is fully integrated, custom branches with
the EVL and libevl RISC-V ports need to be used.

Changes since v1:
- Do not provide a custom config and let isar fall back to the riscv defconfig
  with the xenomai-images debug and evl config snippets applied.
- Use depends on in Kconfig to filter allowed configurations.

Changes since v2:
- Use a head based EVL kernel branch.
- Adjust the kernel branch in the existing recipes instead of creating
  custom recipes.

Changes since v3:
- Overwrite GIT_BRANCH variable instead of adding it to existing if cascade.

Tobias Schaffner (2):
  riscv64: Add support for RISC-V architecture
  start-qemu: add support for riscv64 target

 Kconfig                                         | 14 ++++++++++++++
 conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
 conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
 kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
 recipes-kernel/linux/linux-xenomai-4_latest.bb  |  1 +
 recipes-xenomai/libevl/libevl_master.bb         |  5 ++++-
 start-qemu.sh                                   | 17 +++++++++++++++++
 7 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 conf/machine/qemu-riscv64.conf
 create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
 create mode 100644 kas/board/qemu-riscv64.yaml

-- 
2.43.0

