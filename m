Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241426A0F8
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091449; cv=fail; b=j38vJb9TYAY1UQVXiHFYhIurc9VWlCca7RciuF+67wG75cIWsD3Ewahc/DgN7mcVDhwwKd5Ow7b7Bk2JsHQvGyNfoEk+4Eztf3CquLV4O0q5+JcSDRmQKhWLDJVx5JaTd/d9koDD/Pn7qeotCXB8CfbpJAnF1VCZUI6dtwyMviY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091449; c=relaxed/simple;
	bh=e9GTjExwGg7eQhf0a7oh23T8HBghco/OcI1mI6wlbcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJcrvuBIlxG/BkzftRI0Ukd5h6hryuAC6b07m01cSRnu804uAaZ7OTpWo1qlRvDAwu3nOVNym+Jb5V//rdyzhV74dc7DKsn5tlAvmQP2EcrRcgHEgXQX8ltKX54r4HCXuOCp8hE40EWotpJrtgsUUvghuKbodsuiw7pih9dcjS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uptaGZsK; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uptaGZsK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGNKen7NP1dj8eG97+m4NM152CnIDD0AUVmg1D3O983RB5MOOG3wsF8j0nCB203LF0UAqS3cdG/qPH/HpOfrK/2SJvDW+h4N0GNxbaSsd4mLQ1YJFxLMtHjds4MYYULBkz9jA0Cky8wacT6ATqklOdUtn+ciKIfAR4jfrHGEtDjdbzrxweTIquU5yltvkQpjns8nwPxf3n4LQAyNIzZWDc4iZgsbk9tzRvDLbMwYXCR2jnn5lEfObPlFNAB0R/o4MU7rSthhC7DYFSQpphT6+KnzfUBMAW04ngi81wOv6FjX6l9Bb4BcyNhGgHE3JMb69gAbGl9G+uRQ8VvDgXzqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjnUdmqBeCLpFws0JxTT0UqNzN5RkU5QXtSuWm7VRmk=;
 b=D9Sx1WF3qBjKkBtDSeJy2kP2lPOj31Kyzn5JA8Cz/+V7NdokxUfaOgiXuPMzW+Mp+MqKk2CpcDo6S7wPV+8IWHelH4AcrS3u91uZ67QWkJ4sOLX4qtRRZM7fSvJRaRPn+QgxQIbMIhCiTKhlHHYslVu8qnSlqVAFsblkVYsVhbHm+tgAoSq2dZx1lusB/FqzrRha0Up1gi3GRyya+GXjSCGEazIJgf8rJqz8MkKGWG99gvB2cKF/3dllaWZH1ND+/66jNCMj9LcjzLVq3v7u8oXlgiPYtt4YOVi6mcCQyNCoIQ84iaMxP6Qmmi6fda77sB+zjivbjo5D94kP3aZhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjnUdmqBeCLpFws0JxTT0UqNzN5RkU5QXtSuWm7VRmk=;
 b=uptaGZsK3vfBgKcW7UA19zJvdbEqlphjIiV8vnz0xl3Xt91tOKjSBMizz+7Zz6YfoScOh0ElSBmePcmPsiNTxeHfBwqLI1T1Cps4AFE5iZX6D4qu+yDtOTYCgEd273+osLXhWYVJKcsnKpB602tF3kS8rLjZNAXWZExEovdZq36xmYipY3NWb2T6Vv/YRVi8iVcXzLg30rNgpIeFJDZFbl2EECheCVRoBvVJfVcGkBysuMM0ilv2Pz0kMvdDUmWjYJgc3pLlXmhKUME4ozBMTRGGummRSzTh7CW8P28e7c6ykS81jblLBKfLk2brGI+H1NzHAytjagPPKwylvWG1vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM7PR10MB3560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:138::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 10:17:24 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 10:17:24 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 2/2] start-qemu: add support for riscv64 target
Date: Fri, 10 Oct 2025 12:17:17 +0200
Message-ID: <20251010101717.3759565-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010101717.3759565-1-tobias.schaffner@siemens.com>
References: <20251010101717.3759565-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AM7PR10MB3560:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc96fb1-826b-47b6-29d6-08de07e63494
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jv1XqFOL5KewzkgAj0PXtpPvn6k/CXqWCK7M8FLIIE49CDWxi+mCWAPBPwSB?=
 =?us-ascii?Q?KuTNbm90hfHpajpVRHSI/PEFDqRHI5eQ/F2bx6XbQRMYfcjB9lS1E3N9O5Ho?=
 =?us-ascii?Q?KZFmGCNv+VxlBJob66rCXle9JhTBO6u0sgJh7Dzh6/MiRRqjDeG84xHE3zRQ?=
 =?us-ascii?Q?I7Hg6QYz6r85FgwGYb072ZQHs8X1nsCak444oapyWB6pR2SLmreRTK8sp2Xf?=
 =?us-ascii?Q?hXxxaEXXuN42+8QWPoLR6PJN/1jqvb3dycv/n6f1Q1jOKfE874V7K8lcKJi7?=
 =?us-ascii?Q?qJ1GikR92Wc1ATbdYmXS/iJC4WrBpht8mJJULZ3xNbHywh5bkB6czGxmtPZD?=
 =?us-ascii?Q?nUFPOTleV9lEkDrg1eei/TahPnolMfvoGhjoL9gnMUS9knJDOxRZXuHLXLNk?=
 =?us-ascii?Q?+kQWmVhnW7jvW1cZVkCZz3jBCsPL6/NT1O931LYe9rQghT3YF8i8Rv9y5xMD?=
 =?us-ascii?Q?zBCdpltfUN5/kf4wFAZDSxLiBjLgY/jg8z4dxMCRr5C14Z2QO8l5FZJebIXF?=
 =?us-ascii?Q?oKpW8op3A66mBpxm+YqvdLcd86sEL2n10m0p861pyYZLR44ggmklRfhHCMys?=
 =?us-ascii?Q?KcYkoFJDj3Wmm8jG1hq5NEks2MrLxNQrWi4ijg2Pyna31QPKELpDk6b4QUES?=
 =?us-ascii?Q?/GFDzn4tKyYAb5RNEwlhL+XY5AmBDqjqMLY+lx2v/s4eBOQd+I3XhTRUvkyt?=
 =?us-ascii?Q?Me6KZYQgSrmpGWCjbIWpBlnQ3b6lpCYbUm4ysX/xqtYTxhpEotM3+5jPeEC/?=
 =?us-ascii?Q?hr2ZvdNOIosrn52TnHDMaxSk1uxn/sILfe2cDTQnd6W9n+919GOf5LtBIJX8?=
 =?us-ascii?Q?jwCxYwQ3YBWu/NEf3eMbwI1Gyi8kRgtb1m9se3kAghE91CFmVZHoT3SdiBdX?=
 =?us-ascii?Q?58bTB0PR116UJnJl/H79Upw2kkrlWqL6/AinHn9u0pl4WAKOVqbAbH4m2KQI?=
 =?us-ascii?Q?i/CAytMgGxr6DGiWGIFHCR4pZOEdUrmJaXcrAvXzMv3LTbmOJTI4TBkALikl?=
 =?us-ascii?Q?gpnzyhWO/EdnaO/zEtt88uD7mPYG/WeKRnuGeEaBibI13EwYeNFda8UEEQyY?=
 =?us-ascii?Q?rnf8XQv0nVKC43rAEF2ap2/iVsJAYi5SXz8hs07eM8hRvEBekIdYiJgEJ5t6?=
 =?us-ascii?Q?RHil239dVKYS66O0wsm31T5WQGMBhGoJa6kRh5l6Is+2aOcAC47T0NT0qoaD?=
 =?us-ascii?Q?1pdUJqQbYLUW6AIUvxr0LSahQ5uHVsp4zhkSDEIKRIoEg5sBj4su7Tqq/4VP?=
 =?us-ascii?Q?qNUl62+55M0KYMzVK5Gwi1a/7HYnvN0GesjRC2elGMmp0b9O2Aet7Ny3fnQV?=
 =?us-ascii?Q?RlF+xFZSxtYdhLkBxEYnTSoOMH0tPY2NfqreXNctSIoTFK4Hto3t/rD9MNMO?=
 =?us-ascii?Q?0M/sE9evQvx5xPJwTlnn4sCAnHVPdm+EDuxoxvQ7oJyWYLqeNKfamqGDK26m?=
 =?us-ascii?Q?Lk3ll9rvsC8FFiLEuVbMViH7i8lVZEZT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HWgmR96qK2k1cszPtOqS+6HZIqmehI5GPbTqsQyR+C/DaNgF2QKwcxnHMsx2?=
 =?us-ascii?Q?leY/KCTSstAmfJnuAihBbUjfBwoimM0Xswh7pGRwB6edqqp0UZqYQzNyRKH1?=
 =?us-ascii?Q?mcWW9PJju74XQXMGEcJ5i1/UZCLonT9lqd1KXyYQNgfgbki2PhwYYTKEo34l?=
 =?us-ascii?Q?cPeakrjds/kcZ8kfHCqVIxS3Mz7594YrX9+77drQX2ME4Wczt6XpCy0ndOTp?=
 =?us-ascii?Q?7OSpDjYyaK7wIUCOSAZtMCIgtyYD51e5vsK2yQBSHokdM/GAVLr+HdYxi/ga?=
 =?us-ascii?Q?A5gWWRfXsgD5Vq35SKvvukVWaKsg4dMgMjGogwK+Uy0DC4973rHbtALBZyAO?=
 =?us-ascii?Q?KCaewm9vAfEppkR6hgZ3eReYhsK6s3zm8Cq3aX/5BrKt3ImvMGiDt/tZQqX/?=
 =?us-ascii?Q?OhIEtT5VSAdJgHh2QtkIyBkr3cQj30Svqj8t0TOCbkgQBQGdjHHh7rqasmj7?=
 =?us-ascii?Q?RbyK6eHNqhI91WQHyUqGCdDmtO8j9tukxuRp+N0ozvALwtvxCdbgNrNf+z+z?=
 =?us-ascii?Q?Lbf25Auezl8jZifNrCgqxP90bPsr8dWBwlfbtl5/mhiB7IzE5P0C5IvG7V5p?=
 =?us-ascii?Q?/2xdLgMIS/yJuQNOq4AK/ApFUlFgDThqBx8JOWulQ7bjMvm+Wnre8P0YwePN?=
 =?us-ascii?Q?7i2KfaWSxY2phIkXj3AVYG1j/QdaiYLp1Q8Vwi1FwO0iTMCru0grmktf5w+4?=
 =?us-ascii?Q?vnVlEsWbfBGGYLO+ynvhWeej6XW0Y04LGk5J+OCV5w6dFZ7dPQiKY/YynivR?=
 =?us-ascii?Q?MWAFdzWpxBZPi/ulKqOQWUYJOcT+rgQpe+gOq/bxX9b95p6yPCBNF03u+dJC?=
 =?us-ascii?Q?eQC8s+4BYUfQ257O1ugzLGiV1Nb9OMLIR9eNhxKtx2D188fcqqDA7daj0ETb?=
 =?us-ascii?Q?fHhN01kq9p8oYnN2szGq849Ca6DOWdOvGd9QuCJzfk0sQ9pGIIBM1ar6Xl1O?=
 =?us-ascii?Q?Sb9moqWquqDc69fS5mvfQDSlcC6ddiaDfnzVNb2hgDKY0n1Pn/ZoZOP62TsL?=
 =?us-ascii?Q?z7+o0Bj2wnIjW/Y5dtygZaZ1DWMKyGWG9EdNiAHrA604eFDPuTYwSP4DvTeK?=
 =?us-ascii?Q?yEDtTr5KQDgheiTGKXvjSUtBiSYupr2QhMBV0bK9Wo69JtnDigJmaSNzvhZw?=
 =?us-ascii?Q?mbs8pzf4WrKXXA+XFTFtj5lh92t+qYiflqRQj4wFsu2iQ7Q1O1tY1x9Sy5ze?=
 =?us-ascii?Q?22QoBsisNsp3mOoBY6YRTbzeR1MCORO8SDEODEDbsg/uZTZP706x8udBVHtN?=
 =?us-ascii?Q?PoAXwlvTeAs1vD4NuVIZ3cipCMmn/y91NI6yPISsUCd+PxRnHdzpdguO9nBF?=
 =?us-ascii?Q?+0E2SDgEIm0o76Y1P/Koz4+KW/MTVEyR4wPaGBDbeWKqiGMuQQiDS6BU3nvG?=
 =?us-ascii?Q?y1TPSI7t9QGA5Rd92psogAyo9Pq8wdphWjBNjF2GWA0/d3kIYAtMfsNeAJtt?=
 =?us-ascii?Q?Yn/b3TkYl70QI0gxh8nm36bMoEnOYCPikm9rsrD9K0/Jiq+gtlWiaAz3nkk1?=
 =?us-ascii?Q?UO8BGcjR9T8l38j/0zL4J59yDYluJY6LubcF2qP4yLvhDNdrIJwfM7sZnVQS?=
 =?us-ascii?Q?ayhcWGizIgA3agIGIoI1LLJW+N95TZ0VQqjq1T50ys9WP1HUaL34ngiueIJR?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc96fb1-826b-47b6-29d6-08de07e63494
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 10:17:24.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehJwjExMYX5nkRhr3A/fIswV7n6HJfnVeZG5tdLnD4ZHyKAEdxFFwlKHkKnlHs9ecjEOt0wmpH5An2zdATckeeB1pDgFMA7Zb8Fhf2hti2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3560

Extend the start-qemu.sh script to handle RISC-V guests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 start-qemu.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 7c3b842..96a4cce 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -32,6 +32,8 @@ else
 		arch=arm64
 	elif grep -s -q "TARGET_QEMU_ARM: true" .config.yaml; then
 		arch=arm
+	elif grep -s -q "TARGET_QEMU_RISCV64: true" .config.yaml; then
+		arch=riscv64
 	fi
 fi
 
@@ -78,6 +80,19 @@ case "$arch" in
 		KERNEL_CMDLINE=" \
 			root=/dev/vda rw"
 		;;
+	riscv64)
+		DISTRO_ARCH=riscv64
+		QEMU=qemu-system-riscv64
+		QEMU_EXTRA_ARGS=" \
+			-cpu rv64 \
+			-smp 4 \
+			-machine virt \
+			-device virtio-blk-device,drive=disk \
+			-device virtio-net-device,netdev=net"
+		KERNEL_SUFFIX="vmlinux"
+		KERNEL_CMDLINE=" \
+			root=/dev/vda rw"
+		;;
 	""|--help)
 		usage
 		;;
-- 
2.43.0

