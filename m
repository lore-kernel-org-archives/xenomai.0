Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8E1C692
	for <xenomai@lists.linux.dev>; Wed,  3 Jan 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ICEW9BVw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj1+ruvZKEw4V+dtEaPrk+lVTSFk9FFP4sgfECMkKGUjS4KL/FA6A5grLcajIPM5xuMxnmnXJA6QCILlFg1r6AmSIrhait2ExCJClJP260vfksKuAvUxg6y0mu4ht1SIpWWLtEUAJhwRCDB6zSWJEaBtBBSWHIfU8KJPdYGjSa9iLfv7JyMBG4PW50rF4F0GquLt1qm4Uyn30najMD1c5h/G1nYDy3eb6w1MOQvGJUpVwEuNAqKGk8kEnXL1uJ5oA5wS6AvENJUzQyjFCok5LD9+IWVv5ljxEZaZh2XEp19NMvSFR+abyPOZ0SsKB7Od0dSCDgMDifPntrC+i/Uy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHGikrcqKFK5k+annOos7V4m3QUt8UN+zvnkeBXUemM=;
 b=J3hk1Bry/I8g0BmPQgZ16drON7wvCtJJF+Y7Akvzqi+Ib1haX8j6zBbOCiHpfzArNXcWMPoSDAeJz/afnEsBWOyddh7yuWDJMK2ysyk/+ScFTr6LLR51wKJH1kK7nC7PSbRmZ8pao6zI3Y5MtkpJHh4okuwXheU1wN8lJflVOG2TKIU8h/XbNzJEsQRve9f3B5YgAeOwiDWhvmIFiv4jmhkpDcMMeZg3Zu/eP+KUs95dfSzqHD/w9gwY+oz6hjQeatm7SzW300jzigpvisB2FQdw/y9rUK1OpzWYnIgVP16YcoPkwKHfVIpCOUK02See8twKFfdhsfJUiuL2lnjTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHGikrcqKFK5k+annOos7V4m3QUt8UN+zvnkeBXUemM=;
 b=ICEW9BVwKFYqP9PW7fe5XLUqJa3CcH1lRbLzhWne/AvpHDJ53geLXH4AmVEibaaKAytQfkA8eY/TIq7jVEBsV1WoC9SykSxzn9kUtJ6NNDyMFPNwRPpy3GbjAL/I/Ab1JQlNNvcLUwDD17kx2MzNZi5uM++FjDPbN6gNEkdPNUqhobDxnDrRL9Zr16x01yT483umTamrR2QnMo+qktatyI5e+EABNJphTyFpm+frau8/OqXafZuw5LvMTzStHwiH2YRN+JAaV41XdaBAtbzWb52Xb30X5L9Jad3HI0Jx4RDt6Vpk5z9Y8ppDP3GmVmi9imHpaXQaMVVEQsKPbJiFQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB3360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 18:28:43 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::55c1:2302:1bd8:d9db]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::55c1:2302:1bd8:d9db%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 18:28:43 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH] customizations: Enable systemd-networkd on installation
Date: Wed,  3 Jan 2024 19:28:39 +0100
Message-ID: <20240103182839.2512889-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|VI1PR10MB3360:EE_
X-MS-Office365-Filtering-Correlation-Id: 48922b1b-cfb3-45ac-9673-08dc0c89d11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmVzVC0IdZluIG84w0/ZFtCV1Nx8KMt1Mf39XoPHghKJ0bdWGLSNwdyLS4Khe0VxFnBCL1nCfYNwrhf67i8Kf/71Jb7nrxrnVoXqmN2p83zNkplSTsjx0UQytkx2cRCBsVp5tLkOvjN3vfgIbCu8HXBv6ttW5bj7E41VfVWejJxyLvFdtFE8dYzoQ7IeM/W5uAjp+8lxJQig6pHKg6rptgHWyLkOW7TBdThTsKPW+owQ+3lfRYdKlaBuAVd6QYnMZGPtIrMfy4WiTxuJcvwkXr6ZNTStWbUlnWzlB8z+W8m7ocZD+YLK0WMxMiv70QSHmejd6DkR8YJ6eqB/FC23zzQmu5yP67ekQU0CwxyX3LGDVOFXaQOHS/rHhjk9fmDnUoNbrTKoUv06EfSwI8jpmjA/8GOGCp7zv9L8syd1QawdzC36tQIlMoO1FDTU/aVIROC7mPQGpVhb8+oVNudZXLmkHFkLir5M59jTUgEJ1hzqklqDka4EjUpRBWIgCobLjosIUfNMnlRKl/dQxs+zC1iluXEEAYy3rLrFVKrt10cBnAlE7Ns8rKCn9xXNcP1B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(6916009)(66556008)(66946007)(6506007)(6512007)(6486002)(66476007)(86362001)(107886003)(82960400001)(38100700002)(83380400001)(2616005)(1076003)(2906002)(5660300002)(6666004)(478600001)(44832011)(41300700001)(8676002)(4326008)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ABbgTAYO0JiqPaVPytm1KpO1BD1wMSPZdB4luR+fjIadKGy8qw50v4fxMAp?=
 =?us-ascii?Q?rlLN5iJqIKAZkHZ+kc9cgbJyOcejgZ2+MEI3OjK01KdFWgK1a2mrrK8x1BY7?=
 =?us-ascii?Q?kkWhAUbD9JC1mCIODqA7vP7kpjS1ghAYdX31evN0uUeNjU2M/y6L2m4LCE1L?=
 =?us-ascii?Q?YIewd1Y49ECjYeXg+YB5VbCtNMdKPLYiUr8e9S91s7jHRezvEi6fLnrNV8PC?=
 =?us-ascii?Q?OqmsPiNkK/M4I/bXnRFFpsQitnDiulyIFUq5NZ2LKUnv2FdHMn/ZT19F07Qw?=
 =?us-ascii?Q?eu9PD6s5FhLM8Ome5b0+WHQiMX5+VYrR4xMthxGfpfkV6cegHHAvpoKEnpjI?=
 =?us-ascii?Q?wmfoulao7TUXOiTPZEP6OGfJrxsbUlAXeHav6kUgKNQbOjZSTYvCxhJVtRzR?=
 =?us-ascii?Q?wYJs2fec9a4DvabeoSACMvWE3MXbZnSw+rommbJL9xE0GuEpOtEZgkM3Bw0s?=
 =?us-ascii?Q?uki0dVc7jBt99RVDqVHISR9GeJPVCZiMV+xFJ6XhoqQWP9C/c5TWFqu96Vp+?=
 =?us-ascii?Q?pdUkSvMR/RdzSPiaWRUIGLHpRhOTrnMPqMd1XMdFrmBPMQXi2EbvcVn2fdZc?=
 =?us-ascii?Q?np/hDvGt9ZmZzf3QPWsLMeBTowWGb6xB+MM7uI7VQhl2YdbKf+wHs6PfZ/F/?=
 =?us-ascii?Q?KCOpC8OW1lmgkbjWoh8v0/1xyjA8o7WMFkWLt6eW5wLwzvMTlJXD9ZnSGxGD?=
 =?us-ascii?Q?kPWpkd1jZxY9dSNYevk2LUTtU6bHUgSVQ4bZ2dBm0zMPjqSulvloKCkbiY2s?=
 =?us-ascii?Q?bpVSBm3g28OaNVmkKodaRMiE5MlFmbCveNW0qfXLvI4tEAEb1Glp7AND2lBC?=
 =?us-ascii?Q?aqnlOMRtkickJ7cH14dHzRD11DJKRjZkywRYLoGcIUHeZ+hngdDO7G/uovC3?=
 =?us-ascii?Q?x0kIKixMJHRszQHLyS7O7DJYXiWwXGr3QVcVcsO30p4Wc+x3o5zZ/HsJVq1T?=
 =?us-ascii?Q?UIX360A8cVITqO/iGUY+u6m8jDp5XnUkcsFo/4x1E/SF9Qs1fvIVphi5xWHl?=
 =?us-ascii?Q?UPxDupP+ik/UG/h4+T3SoAjMCDLFE4GyGyq94mmqm/c1U+w+jg5IznEfT25W?=
 =?us-ascii?Q?9PMzWRKlfKngfBc7U4i2ewcUOVp3ldDmZnWyZmFHk1+fc46vud1YrfWwGfUH?=
 =?us-ascii?Q?gB/VWavByZZMujgcfqP+EmAvdhoV0j76zK8/NuZO9651jWBdlxKwySRxHgnh?=
 =?us-ascii?Q?lkj+0Mnrs4FM5SA2wus+SLe0ew47XuOlFBdpPUCTBa78hkUtgM7wucJBvuVd?=
 =?us-ascii?Q?/VG9sW1RzghSoUAyWgLlH7sK6im4iJK0zztSyfA5SmG3AGvoTYVACPA+Wnvm?=
 =?us-ascii?Q?oe3YlSJnn6uMPUsFQIkxqU8KSV7xMJ4eQAO8AWEMtOndKv3r7eEQ+ZDl+Xuj?=
 =?us-ascii?Q?m9EO7irl17IWRCw+t8fRJ9xEFSLx040+eS3Ii74lnJnmXmU7gEKmF/rYeLRD?=
 =?us-ascii?Q?iG0z8fp1x8Mg0il2NDcxDq3lEGtMpZYiXbEujxs+xNyC+/pdrJPevahA8wZa?=
 =?us-ascii?Q?keoiD8Yc8FlFryboAaeflDBkqjxtR1G8IaH1nbcPvWYASkCnOnuEjtIQGRsg?=
 =?us-ascii?Q?niAT2q/eJi8IzQY/Oj9Q3pw1l2qdG7Yz3GZG73NF0n3qVm82GVLmdt/lD82V?=
 =?us-ascii?Q?N/s+iUM1xBlhr9Ei+DIdHioxvl8OhWhCC6Xh7WX5j5hebfcG1HzwF2jj6BT4?=
 =?us-ascii?Q?o+cfFA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48922b1b-cfb3-45ac-9673-08dc0c89d11a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 18:28:43.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM1HUFk6ZPA6/y2GQuDcyY2HG6wXP8yAK0Tb2Rejk4VkpAUT1lSpmNv2wH8jXA1POcwWhZEVlmHltXJwkhBKk7O3NB/hEYcdi72FdAoRC0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3360

The network configuration for systemd-networkd was inplace but the
service itself was never enabled so the (default) interface stayed
unconfigured after booting up.

This is a left-over from the Debian 11 => 12 transition. The service was
previously enabled by default.

CI does not detect that as the ip=dhcp kernel cmdline argument is being
used and triggers a kernel based network configuration.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-core/customizations/files/postinst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
index d8d141c..c7c688f 100644
--- a/recipes-core/customizations/files/postinst
+++ b/recipes-core/customizations/files/postinst
@@ -2,7 +2,7 @@
 #
 # Jailhouse, a Linux-based partitioning hypervisor
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -16,4 +16,5 @@ echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
 
 echo "demo" > /etc/hostname
 
+/usr/bin/systemctl enable systemd-networkd
 /usr/bin/systemctl mask systemd-network-generator
-- 
2.43.0

