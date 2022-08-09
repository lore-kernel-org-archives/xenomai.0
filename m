Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7944429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/JnnK/yi0xzbFPZIQWJS5Mgfzs7dilNmKZ/4vZ+I2LIRrREfNyKBqmrNpFXSUHyFIjqrGEilV/XXg7KR3vmN73CNMUJKjNYRYfU3H61mtZQ3rz5F77S/H4PLi+UOatw4rVns8Y1yFpiF7onpdrMJ6xM5J1aJLn92UhQqbAY73gDH7V2ZDh65udMAHvJMaWuMo0dFj7i2sv3l654mVkNjCfzmvYkM3MfhP1UTF29pVsN043NeIIoPV4RvCAVB+72PNJBX2Uu7/+RLuDMHCKH4uv40UdLhQADScRJ6HqiZqKmUo69QY7aA4Slz8UlLonMD73vXEkg/hYGWwrc4g18yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ykk68VjuN8/Ny3SQZfrxq3ZWuOnSNaK4W6WpirKOA+I=;
 b=lffSH2HYNTr7eJC6INmzVODL5P72LBn/QtCctUuz4R3iHiC+Emfjfe/XW1mDSxyB1PDaDhxylgLk+IZnIG5tns3w6wyhQzxAxoMlJqrBKt9QWIRckNuUxj5Swqua2aVM0VfJ9tZ2I7AWbBCysJSGCrJKIRzTdMyXghFfOEeLkXm4MNOvCY5yMfQVJAwBtSVYUSKNdkk+DaXHazmhHLYaV/mf1WCeSJvPhKTFpDevWNLuikZ7bbrEyWsB/qbHs+G5TV1WJS1N1JHc3IC5MiSJXdl379zW8NlIMTEhGCWzwdJVv+An5MwvzDJq6v6hQ1+QIb2OPB/RKYF7eZMIGgRSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykk68VjuN8/Ny3SQZfrxq3ZWuOnSNaK4W6WpirKOA+I=;
 b=tDcgK9hcs91h2h5q6mrHUQgxFZ6qE5t4I2PO0gio3fKpseGf+G3wRr2eQI6gQPx0xz647r4SuVvcAODweIJFamQaPoLVqGTT4BVGFK/VVodnnbTa0DEjS9MevOEBdB84IsU3ewC5KJMHKNF54t3USl0p1BP8WYLuxCfPBWc1mtW2sNWwM/sDrLSWVuW0FtrxNYfBOIB8fgpQkuzbBIJzGj7n3W99uCGyLtZPbYs6LPyQ0KONt00fXd7EZB5hVEKr7/5eipqQ8g0A2qw3H5vC0psJ79pf44Na4xHfBxRO+nxr8HBqhMkj3VjIPI/IrJqcSniQx0nqZuVF0yWCXSnmHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:55 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:55 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH v1 41/42] drivers/net/stack/ipv4/udp/udp.c: Add compat support
Date: Tue,  9 Aug 2022 15:43:25 +0200
Message-Id: <20220809134326.23688-42-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0195.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::20) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba81366c-d7a4-4fea-fe18-08da7a0d4910
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qC5TwqvhiAiURcXamdpgMyUgke2a2n69mxAcxLxMUFN4N0GwZPxYyr77xUEGa8QxODmlhBZLdPSXhR/dwBSyY2c0xZK2UpyrPhkoewNhVlWE84E6ELH1i04GDjIlR7J3hYR4192XTXsHiCoIs7dTM6C7r3N2S3RPfx7+FLUwnI8Js8bkXgBA+x1y9sBxO3lJxXi0iJJPco/55rIp/GMM3QHa5BOlLj1IbdDIIwNFtAS+8jpqR8qp6aKwJGb7V/zC1AxIVVLnkukecUop823oPwqPBIxR9S90FblG1iVf/G/kvYLyJIBiHDuBPBx/jCxloOzknuoDuj069pWKGV2IgQVoJyNhb7Rc3rlU61vSItWxVyQNVm+5wtNFC4t523b3NuOpLTyytyjemfmLyhhIpE1VAaCP11AXkEgDNK0U0SF7rTzOb1O0S7nJRtmxBy6xWbDINwS3vg8JKMI1/09YZ/i5DMaHHRsYl4EO6FzaT2sQHrFZFrh2tT+2/uiSzhtKhNxnvL4pmOvZV54XKPLIHbeicZla69NyAK2uc/uOCqHxcc3n9maTt/Rx+Qu9+JAZbYbi12XDSY3ms9wgewpBJtejb85rQj13h7Wvt5hISOFUus0zItmRPr4pPg46u/XMrzQmBsVZ0rzKyggLrUI9ryEXucItMF+RLvC3X6xD+0oteK8THAG058PC1fQCCLB0Vg47OwAlD2qLu6FtQdmO4ZwSrrjDkeg7v4BtMZqyr3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(8936002)(82960400001)(1076003)(55236004)(2616005)(186003)(36756003)(38100700002)(44832011)(6666004)(86362001)(54906003)(6916009)(4326008)(66476007)(8676002)(66946007)(6486002)(66556008)(478600001)(6512007)(26005)(41300700001)(2906002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6W+bUgWlwFwkuVSbGjALGPUnvya6ukK+q2uc/Se9jM73ch4QKWqge2ijg32x?=
 =?us-ascii?Q?abLkzfxiStrxSxIrkY14kI5rqsD4hCmObZHjG+hJhzrG0wY76ZJBr7rshfQY?=
 =?us-ascii?Q?LWTzB6OUSV/GkN6E+78/0jiZo0G5PBPD7JU17aV7aBelJGRAlgOkQyD+Ft9V?=
 =?us-ascii?Q?xhmZTx+rckiUVcPx+yRopMMXcgNt5jJWP+MoQO3JBKTi1YItVbw24oz8phlv?=
 =?us-ascii?Q?t9wVUuJ9DSNVQB9iY+/cs2rF8P69QHUTnpdPYtPidFH6/Tf3Flo4Iz6DXlRe?=
 =?us-ascii?Q?J1xL2y+amlGIo8irmw+YI466uQ+s50jkUtE7z1qqfEUNUsDSE7idItEIyzAV?=
 =?us-ascii?Q?PEfCfVy+snXwKmUSFb8u9W7lNwtH1CXCk28qhbzQDyHlchO6KnoZyT2NlXV5?=
 =?us-ascii?Q?lu5BJi+T/xNTO89b9uG8gxJsPm+kx/2eCSGOgtHblfBSd0w9/MWpyDAsamFe?=
 =?us-ascii?Q?ERzYwHwchTh3Lc5I7KDfaDqp3vWb57LhGMlpY8iW9qIpMw5MnJD8mV75u6f3?=
 =?us-ascii?Q?3DNGcfN0RlMYnVjb2nuK7v8uVPcq+ebIiuT9/dmc5Ar/7DHVtPuwG6FJW2ea?=
 =?us-ascii?Q?zYNYL/powHQ88zstaomtCxVhKYfHJcsSGSkr6p+/kpsC+EhXl77shQGhFJkZ?=
 =?us-ascii?Q?VThAPquSxeMi9fKdNpKZu7KKrt/2VkvmwxHYZkh2Quj6ZZdD3u2fXRWpqadH?=
 =?us-ascii?Q?aBjzQX8QL40vwlyGyHQMz+1T+46MKNXDLRtzQ8vOSXI0x/4mFIXLLvX4tdvq?=
 =?us-ascii?Q?X/RKxWQjExJy9wuQRXnmIpyuGkmvn+24iK4jT7RDTlU9J893duSfvq0Kxmqf?=
 =?us-ascii?Q?kq98MeREUXHsuCHUDmujS7hYczfrhlvQF8wAcoZ2TPAGvcCMYFL6tMIIy4Ao?=
 =?us-ascii?Q?dHAnDr/DujLLkGOGjTDHVXy5MV1oWrvM8Uxk8JH44JDUtzpeHYahnrqgjWtw?=
 =?us-ascii?Q?kf0i6sViPa7VTq0X89g0tQW/t5hHYweg77o0tkFuyipEE3aYfeCcv5co6v0a?=
 =?us-ascii?Q?1Fn7aB9WqQSQWGynKQcAWL6N/U/aurF7OkO5FPoitv4R0ft0IdiHKmqMOweu?=
 =?us-ascii?Q?pSIrO4/9DbAfFdtpusNZf6GyH5meRDOSs3JVlB2v3DbnSuE5Mnn0bBzxXCqC?=
 =?us-ascii?Q?CT8Inspu714mSSrxuG1Qd2pg6PKrmAbLbnSPZPdGiOsx4I/fQH9qavP44Wyo?=
 =?us-ascii?Q?dNSWhQmTzvFelLEbRCgKxtxY5+hvnTNfXBKnt3qHI7JbOH3gGCAx/OWbahM6?=
 =?us-ascii?Q?Z7N/P9QvfPqq66SnYbAwLvIIVmCikcvCF9xmi6TQSVZmL4YniZ3JgWIv5sQV?=
 =?us-ascii?Q?DCYETNLePjbAco23vqn0HKmYsURTgI3wZ5Uiw5HDViMdnty/R/p9zVQucbRh?=
 =?us-ascii?Q?kPuvqW4jJha1QuTzK8gJ8J0qbAY4uNop5Lhse4Rwh1eVNJvgeBf5RE0EXz4Q?=
 =?us-ascii?Q?+3sXHa7mm4US+25GuJttcJ8mu1jSJorBIxG7fGU4TRhuZl1t0r0wkOO/QpBR?=
 =?us-ascii?Q?HhujD1DDUi9etSYDsgkBBn48ySxrkVHh9hFPYY6FwJ3SyZK4kixpk/6F9g1H?=
 =?us-ascii?Q?aGnCMGGKlJDLUsdjojOoKTlkgn2+4SyCtNZCzAfjPxG6cKhjhKXASR0o8l+x?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba81366c-d7a4-4fea-fe18-08da7a0d4910
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:30.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owvocbpsFdrr9LpOTZ45JylD9sKtT6wiUwGUege97ZI8sJr6xBiUoz2A83/cEakP+NMj5aOnAFA5MPm5xUemXO5znRsdzb2Mzg5aaYqLZjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116

The rtnet interface was lacking compat support for the following ioctl
commands:
  - _RTIOC_BIND
  - _RTIOC_CONNECT

This patch is heavily inspired by Konstantin's proposal but migrated
to some rtnet APIs that allow us to stay away from
  #ifdef CONFIG_XENO_ARCH_SYS3264
sections.

Reported-by: Konstantin Smola <ksmola51@gmail.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/udp/udp.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 5977a3bc2..777c8a27a 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -31,6 +31,7 @@
 #include <linux/tcp.h>
 #include <linux/list.h>
 
+#include <rtdm/compat.h>
 #include <rtskb.h>
 #include <rtnet_internal.h>
 #include <rtnet_checksum.h>
@@ -355,25 +356,27 @@ void rt_udp_close(struct rtdm_fd *fd)
 int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
-	const struct _rtdm_setsockaddr_args *setaddr;
-	struct _rtdm_setsockaddr_args _setaddr;
+	struct _rtdm_setsockaddr_args args;
+	bool do_bind = false;
+	int ret;
 
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
 		return rt_socket_common_ioctl(fd, request, arg);
 
 	switch (request) {
-	case _RTIOC_BIND:
-	case _RTIOC_CONNECT:
-		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
-		if (IS_ERR(setaddr))
-			return PTR_ERR(setaddr);
-		if (request == _RTIOC_BIND)
-			return rt_udp_bind(fd, sock, setaddr->addr,
-					   setaddr->addrlen);
-
-		return rt_udp_connect(fd, sock, setaddr->addr,
-				      setaddr->addrlen);
+	COMPAT_CASE(_RTIOC_BIND):
+		do_bind = true;
+		fallthrough;
+	COMPAT_CASE(_RTIOC_CONNECT):
+		ret = rtdm_fd_get_setsockaddr_args(fd, &args, arg);
+		if (ret)
+			return ret;
+
+		if (do_bind)
+			return rt_udp_bind(fd, sock, args.addr, args.addrlen);
+
+		return rt_udp_connect(fd, sock, args.addr, args.addrlen);
 
 	default:
 		return rt_ip_ioctl(fd, request, arg);
-- 
2.37.1

