Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50702E7F3A
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294269; cv=fail; b=GAVCJfhiLOw4znLjqsDSh4Qk7LtmqVOWscfasTdYxQizacZTIK+2gmtOKnDPWKTR+B+6PIbryEmWwGZ0iXxJzRGHdGu+2Eu3fdPHy2LcGNASKRy7D/iHI6xlC/Cn9ptKPLKug7/9KtXLu7SZt6R/Bd1t7JZeav9b3yT2iU9mgHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294269; c=relaxed/simple;
	bh=D2uqWNIrD75++wB0O3osm6ZXzxgV5ThXdowZblnFOlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WmTXvFexWPqH66d/5dLKbLA+5hUA3jhY010tBKMoyK4N8YdL78ByaTVmnQmTkUy55z+ib1aDi+9WzC3YLJXBYRM2aFZ/GIxKZh1pt5lzwnHoh7ziFE1DZic8f5R6iBeTQkcROnKTskxW/GOlTdbLw/iaa88RbMFmCVBDaNHAZbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pYIXouJY; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pYIXouJY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQIZdRWPBkN+eEucJVyfvJGH2ZWgQkIzM3LKc8+PuMP2YI9DN0fG8Cpd6RtEr1Bq+hIrgYcWl7b5A0XLBxKfdHVIXdBYyuO3M9FlW7IN1S9F22TI2I3RDl6kzi/NrS2zDho70mHk2tl63Vll2DrCHHG8FXnV42jZCXiRAIL5R5oxzciY4GEzY04fHnVhwkL48lJvS8rzamR+omBeEgbBvHDES4bTnqETAmFfmdgz3waOt07FwkkPRJyfm00oKSLIl+dwgqbaDmuR41R8cGxiz/18/dghIXEJd70a01JWHL3ml540vn47ST6oHirozKh4aqIhF8/riZ8EwhPetVCMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOlyXVBNdinyCCTDL7w+44bGGbKS293gxSK27sqzlZo=;
 b=Gcj7kMqNWmlGilg7jciKkWVSEWpNTkB2niogGBKMfMjjXqR38wsX6spUpsz1QEoWCFRkFChH5MOP/VqX8+NrZLC+iP6mhKNZ3OhVXb2ex/8ECVpeWlAUBnZFn8zYvVXNE9drExIrrjp/Klf5CJ6soOv2ny5JVxj46/2AfrL4DlMsjd6Zq5AceeDOy0s313J+wPB6FrU9e8CujmPHkJtEMW5FiDNYxCYtaB/njlqsKb2RGtrl9sL/dWp7iyosUeqbX7MFafwx2Q7VCSk19/WZIsPu8vHJbz18rF4Knt7bQ0ktspx69KmsEuD292ROyyyr/WJCpfsqb/FN2ONJxv8LGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOlyXVBNdinyCCTDL7w+44bGGbKS293gxSK27sqzlZo=;
 b=pYIXouJYoTbawuO6XXuAhtBiL46Myz8kpY0lsnfnfy748RLZQunmwNd6TewhNU6Liz6kaeF9ORAqG/RbmyQzYHzASfQuUVNbwh5/IoQZxmT6dvxkGC+FNw+zzVca63zu4Bccydkg23xHm7c/+1r1wLNE3mT/2FGai5PrAnOHFWeZdvDT6MCwQ3SL6pRgx3GZNcsLpm90dAb0tq5Mu+cS/P9/P/0c4skmlCr404iAuZKCkD13zchroN9PuXUJ7a0a29zoGqYAsjwaOpML13+9u6h+5Ad3V1gqUNZAN5UFRflDo4D8qDoLBQsBe8W5nCvGhY2wvuW2hCnbAiMypHbceg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by MRWPR10MB9601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:501:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:51:02 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:51:02 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 2/2] start-qemu: add support for riscv64 target
Date: Tue, 13 Jan 2026 09:50:48 +0100
Message-ID: <20260113085048.1380995-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113085048.1380995-1-tobias.schaffner@siemens.com>
References: <20260113085048.1380995-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|MRWPR10MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: c44bad14-8106-4966-8119-08de5280e16c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a/navpUsms4FK5a8Wu74bhB5a2zMafXK3LPqSTNc8xUm+zreyLutHV+xaD/J?=
 =?us-ascii?Q?4B+yAWh7gwCoP+7D5EIMPnR9ny6G68nXHGEC12b6WJA5HU1yG0TTmgm4+Vas?=
 =?us-ascii?Q?LDAZzi32qz2nVTbOQ7hKkzCtj9H18+YFkMiFiL80/ziPTVmVy8kwgWtVWuKi?=
 =?us-ascii?Q?kMzI4IKyuwpQxHNjtsRMIa+0vtxbITyxhQgIlnPIEo/gN1nVJipz56WGM8yd?=
 =?us-ascii?Q?jzEXOcs6WYzRWzjw8SXX27pzMBJu3ieChbIG9K08d1Cdb245sjN+/pUPf/aK?=
 =?us-ascii?Q?mOEfJ5GyC/p+PJHhn7b+pNt0dn3ammUvzXy5+6AiffCbfjhwxNjSTGr1Trls?=
 =?us-ascii?Q?LtUQ2lP8Y9DekXmSQ6e/f8fZaj6JVGnYger4DeC13aKMRhuMBNVDoXfxaJyJ?=
 =?us-ascii?Q?LmI1HnWQOpDZ6/7s0GsuSDF9dvMtu+xjUyPrAw6EUCkkzyKz8PwKhiulVhf0?=
 =?us-ascii?Q?TEU2gQMPPVivhVqfF9j0PLxmX/yDWKyrV+Npqukza5vAZ1oN2AIDlv7jVrHC?=
 =?us-ascii?Q?p1+LC3C+nchgTTv0cqkUI+lb4LWl+vLj9cYI4Pu7iO3ZUPQvoHMfhAyDyRkZ?=
 =?us-ascii?Q?P7ClAJcIff87yUtek9t/Y8pear7pa7S6Ns0h14MRrgUn308IJk6QaNyfAixz?=
 =?us-ascii?Q?1hT8wAmt/e4ouSjBqIZVwlWVH0rVBBPdwUWwuhrqU06OpaqP97kU4/+xGB+M?=
 =?us-ascii?Q?FpqY0RRCdX/+P1jKz9OfcUe8v88LYNopOdmzwRk7ZkUKr/DSAE50RBaB1D1Q?=
 =?us-ascii?Q?KHVZK13vVqJhCFdPr9YFEG17Qt1D3TmpwydWkuz1//MgTOOtECN9tWW4kics?=
 =?us-ascii?Q?bv3TUx071RLm3HTD9u51663XQDHmwosCYhDzGfl7VVWqWhHoailNvJIgSW/Y?=
 =?us-ascii?Q?ManjJ1ujLs2/PzvHEYjtI2thzUth2Cr/Fy38irtpY++g2rVWAsFPmluUk5BJ?=
 =?us-ascii?Q?PDgtClWQRe/edgafMhFngO5m2cBU60OcD9g4Ga/TBR5zmt676s+7/Z3YewpR?=
 =?us-ascii?Q?bN12Hc79SO6zgtmMqChWFjoaiqHlMRxvRsKHn31G9+pTHgk1fgKwpjik9341?=
 =?us-ascii?Q?p6FbFTtUR570cgG0d49jnZ1pxheGjTbMUfoza7Cc9dbOwjoQAOew5YcMA75m?=
 =?us-ascii?Q?ICuoq4QLk1a66MHQKNQMxifdGqKnOiNdja3f5655w/6ZCeImaOFJrdnWdHvj?=
 =?us-ascii?Q?wKtiXK7TcRg2QJU9xtBzJ+/zVeho6Um3dfgDuv8sd3xR9OqcfyMg2WYEW6/u?=
 =?us-ascii?Q?mtLnMuf65EAYWll5rpsxKMiBYSfumNPHE7BdbcxV/Mm66qrqF861wgXVv4Bo?=
 =?us-ascii?Q?ddTkRU6lnaMMkz5El5YgpxPWcBmUu+lDDn1ABH8MrFCs6LcAJy7h15TKSrUi?=
 =?us-ascii?Q?SQ1r2Demt9cZLiezsIML5XHydAevBPjDRuZL0zZJaSOPx2OC+5Xamk/cFLT8?=
 =?us-ascii?Q?c47adbhA8hvzNjwgypBmeGwhxpfT0j3Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7QQhnTf5nXrFEV7Hcv2vvoWXmgUxRuvjknbRY0tztLXhVSRVhuFO57DK0t4?=
 =?us-ascii?Q?H2GlDo1izPV+BUUe++F6CEiP4RMBu13EJg3N0o1ODWK2ceCZ84nrcSl2Zc/J?=
 =?us-ascii?Q?XbNwfftBG65u4FNOux4rOpOf1AmklQYq5jbAnOcVVQpaKoWnJqOVr/CIgbIY?=
 =?us-ascii?Q?EgL2DRir8tQAlZNBH9pc99OOo4yftnjag7hm8NzMPl8NWhmjA2YCLsvlBN20?=
 =?us-ascii?Q?GUBsoWLZOW3671lWSpit6DfSmvUhFndMN0Op6vcJl4XZYX32XxhrtemaJAJh?=
 =?us-ascii?Q?ssOZHGjiqLLmFLo4sjMM76KkIhGFu5BnQkD353vwHjPnzTIMed2O+2unDn6X?=
 =?us-ascii?Q?BjXVmGjnAHCQki1msu5Tdd39RHKlQ9FMELN8vsMGpPxL6DAfwYJQzPcSfq6x?=
 =?us-ascii?Q?llzN9uq+3HRWpAYw3hJ72kU3NLDm1ITijLDWwNGp4cq+0+ZW+xsdvfk/aBca?=
 =?us-ascii?Q?jwPUqlGtUIRZhouRkbNpBzc7TzmWmi6sLFKxEnB1ydcfNEvemmRfiwT0/H1F?=
 =?us-ascii?Q?DQAbLE9MuV2fxRoQeRKZw6pDVQogAFRSCwOjw+cYFB2QeFRpitEZ30m8hX2C?=
 =?us-ascii?Q?LfAH275JzOizQ4Nnuo+bRPpDVSzQfa/LXD2zpLZa/oUuJb1q2JQFsgFtaCj+?=
 =?us-ascii?Q?acOCya8mNKidUkYPEwQk5VbVLg3WzWvWfOzgAkVc67gn8fdd4mnwzghZhVlQ?=
 =?us-ascii?Q?5vdKbkiCCdbluDU4H0waW4e5mXyMTBY5zrLgX566NZMr79+9EhzFcPpjUx+H?=
 =?us-ascii?Q?tDgbO89lbAezC/otVLNtCMuW0Ikyh3h2MkMArYr2DOUqJNcL1R+pEC5X7g83?=
 =?us-ascii?Q?DQGVHkqoOvP+VApdyMNsjQFGYpmcZPRs3gK2xKmm+xmZHb4JIPGNzefTeuZ3?=
 =?us-ascii?Q?8m0uVxGKI6ciRiQd6VBSLRc4tzXccE9qNLZ1B3yZI0LrLeIb3S3mvcY+1vy3?=
 =?us-ascii?Q?E55qcRVUdz0R0FzHP48gO+7oAs9O46pNc8/cFMYmXQxyq58ZyAuKFqZYy5s0?=
 =?us-ascii?Q?dcprwaA1/pZt4CwiwJ4asOq61nsPOs8/M/bPzfAVzLJOP9P/856FS7x3elps?=
 =?us-ascii?Q?QukKzBLb1/aXSg22zBCEEqJgMO35gf1Si6U3a1cibtg1QLCphNHp0nfv/uln?=
 =?us-ascii?Q?AJ/MSokVmJon+yqeivHSb2ZnpMmS0MBAZlKPuURvi0iXPR8z1aDEP0Y32ULH?=
 =?us-ascii?Q?avVQ+4lvkF2tMG5ZeS2BiF3FBMZsn4lD+GDtLqt9SBrtlMB6rLdm5VUkaJxW?=
 =?us-ascii?Q?G2JWD5HyW7ydDTmUbBEVvhEstqgdwPywrbpI6KBaZtJwVP0IYWx3oT8OR+BI?=
 =?us-ascii?Q?TTCD89I+Y5zeV/YPkQPHQ3+rp6VWTnPG0cb3mJsoteZovdVJCd9MQFT/4pZD?=
 =?us-ascii?Q?5eWO7MvWBzc4UnrBLTkJS6Cfer6YPCnixgOPwvJX5iAZpNYt5e594Q+3uWIK?=
 =?us-ascii?Q?8yTtDGUkQ5vj8Hrfk88anHdNzY6MPq47oGvQndyNrVjGHqp3tHhW7Yr+hg44?=
 =?us-ascii?Q?YsiLJ8oS+2EpHofcUGJRg/VztzHzRdNqHutr3F1bFoJEeJbTq6Z8GtHPUFQa?=
 =?us-ascii?Q?aJSJn+Ixdim6o9mX+2Z4H01Q43ihT+8G2Ra/g06le+8A0XodN/oiGT+tED8f?=
 =?us-ascii?Q?ENtXPfHNFSWhBY7UlOxVCvAyK1n3D7t7gkapCC7tmR7XcyJooreDEZy+bG3b?=
 =?us-ascii?Q?ThYmOSRWzsjmcVK8XkNWxsqqwiFgb4VcTlg/cl1BBz26Uq912350AWhIFwA0?=
 =?us-ascii?Q?+DvB7UXWcbzyeTaev5vD0cIKXDJVULQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44bad14-8106-4966-8119-08de5280e16c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:51:02.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +r96eex+3vIggpoQxgq5lv8NPfK25LdI39yfh1VsIqkTIQaYJZOodQWSxbSQLwhCTxlU6LPuyJTDmKjgZKD8Ug91wvItCI/QynNpQVNMKl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR10MB9601

Extend the start-qemu.sh script to handle RISC-V guests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 start-qemu.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 7b9fdb1..9e9bac8 100755
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
 
@@ -78,6 +80,21 @@ case "$arch" in
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
+			-device virtio-serial-device \
+			-device virtconsole,chardev=con -chardev vc,id=con \
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

