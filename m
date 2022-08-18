Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7A23C8
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWhf64a2bL2DnJ7lzKbPmgyBRpVGOCbpjoWD5XBmxAscVDQBRBvrho4RXMvOpgcszGakCsUKLGyHICG8IUCf5VbVrzWQi4p7A8Jd6kJaytet6JzH8H+4OQ6FVk3auLB57LDr3yTEY5iXImZ2+0o3Arup+CNrram/7ruoqwAsToBMw0H/DYlWs8vBaD/DFhscDvs6I4KxK0th+/A3vAwP7v8YJI+zX2mBR4kXhOkQaPxMrhDaA3xN/pY98ZtDrLucTtiemY5TPR/Pvd8Nx1bERFA82vMKyRAMicjqdTu/y5a2AZpTj+jm+SUbXv9V/v2ottJll/EmOa7q0VpD7DjE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7Jtz15ldxJHRBBVUlqZOVuFNoymaxUV668qaUniBdk=;
 b=m5elPxYMW16uYNi6BVKZr8iq1HcgaKh25ynjgs0KjMvSJHANMriDWaWoJNDFYvJTMIjYfl3giAnzvPMuDj4tFJ8lpjSbUMnbumhxPg2AebCccZB5tCGuSyGOA1oEqndDJ3wGkwLcbhk7Y57v4ZAcpcdVimPxowCB0E54LjygLdtVX9jK0WzHgJVD0RC5rBlmwvjoAr5NrXtEUs8nb5bvlD6h4kB3jgYu6bF3KYaNW6eRL0OJUYCgrLn1xVUB17YuDOBa09P2Kwy2IxKhRPWzcPZlosMzt3UJW/DjE8xeOqTNy/mbp8+oHhSky796waK2PRBySY1eiktP0Np2EabAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7Jtz15ldxJHRBBVUlqZOVuFNoymaxUV668qaUniBdk=;
 b=zFqVbpE+yR75dKkCqZbk0mxAygKoALZcSwcBg+Zc0tmh3GD4fF5MSA6qh764/8QjcqRlJOK6DsBhmdReCTF/F9tksAdCkb+9YdQf3VQNwXA9BkHcQXX+HYkRtzCg0HubJ1J8JnpcTi5e8S/37etqKFoszI3LpGkVh7ow5/mjcfdzKO2cb/dgvQ9dSsw0F7ese7J472IJakXJ8BWbMqC6LUc5Fg7UOMdr2g0dP7YVgLdMpZ8TcDGeQ4c1RROeq+WcO5u0KX+FyhfWzC8SxdtFPUwkd699V/e0pHUrqpuL/98FdJTnq0/oomxIksCY2tJMWD9sj9kTHsdoh9NQPuUZOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB3486.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 18 Aug
 2022 07:31:19 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:31:19 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH 2/3] kas: Add option file for enabling compat builds
Date: Thu, 18 Aug 2022 09:31:12 +0200
Message-Id: <20220818073113.19382-3-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818073113.19382-1-florian.bezdeka@siemens.com>
References: <20220818073113.19382-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a08c506-b911-46d7-aab4-08da80eba447
X-MS-TrafficTypeDiagnostic: VI1PR10MB3486:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OYY9RAtLns/iT6yUd1ItzASIz1yvDVZFhmfNyMIuKJ1p+sIw2Ca0Wua2+PofxZnOIIWP4fez/tQMZy+QQQioFvqpvrlyE6YUIsQRfqoOTfxOcZNKAWb7Jl181/lORXodSNFWrnoBtXI4WX4S2TzaNcx5mCKuO+HwQM7OxYE2aejSgTj82e+AvYsNvCePtCzq3wavQHrV1CFnWlSBBG8JZ5J4gDt+2Z/bafUp345RqDhSDudajUQQ6HIlQv3qP3MPV2bOiAZtsKFHJ+1D5xECwnW5+aaJxl/sP8FArW7W7COldvHdIrK0t2J1BQa+9BmjTleI2G1bym/oAo+yk5JWqJzBIm3p3MqmAHj8KX4n87T35tzzQ1jemWaMaI6msGNjrBSxoTCM9zsDkG56S9VRJ0m38qApVS8s8Gij9dLFlMsCMH+kexgxdnpctYdRAVcXjCs0+fMZ9QKS2qCGxGFcdYLusg+XzZQ2R/kPT2UI9eO8giwRA5Y9G2F2sAghTSLoCX/Qe+C8ksmmLXR0jr0CCJDpA1itFPJZ23NhfjLjZZNTnXtlu3AjaYVVa4VaQw7vfruzVe4/HaFJ6nF1o3IA4dtfOkDYHNGvCI3cByYH/h5zyG2ltgrw34r7+fBR8ufexCQKehKWFv3AEQhxDOeSx/SueFe4702dkq9DAvPgzUHyNhCBJoo+p39hQw8zs6UgdIOycpXMnuJ1JasVw/3s2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(82960400001)(86362001)(44832011)(38100700002)(66946007)(6916009)(8676002)(66476007)(2906002)(5660300002)(8936002)(66556008)(316002)(6506007)(2616005)(4326008)(6512007)(107886003)(1076003)(41300700001)(186003)(478600001)(6666004)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWa7A6BbHS+v46nrqM4gHGKBJbKSTn+rRuy9hDiUd5lLIgTSTglnwjSB/ksC?=
 =?us-ascii?Q?W+P/1unUPl5TbbB8l/O2RtwsI+xZ2+ErpgQH9Vvjsp3eqma/MMRTKRNajhUp?=
 =?us-ascii?Q?YKV4qDuD1uxmkgqim3X1N+GfXe6dDcaB5Dqa+D2sJP9xdza4BEP+XdJT005B?=
 =?us-ascii?Q?YDeQBjix/IOvoN3PCeiNKg/gL/zWoB50p59nFFZgC1XwBp1jVkBE32P9YMG8?=
 =?us-ascii?Q?XJMkFx2RYPZ24izhppuirL7IOWlHss/S5qY+TOcwSlIXBuF1g+q+HIfnow/W?=
 =?us-ascii?Q?0ctU/OsOU5/DJZfJ2kY7E2o5Ug67BmNutHXJKlJaD8IlJBZUHgBkETuVglM7?=
 =?us-ascii?Q?tygt4yjKmbHqTvnwjAGNeUgMaQOfMECtTdVuE8+6pl3KgkUwnNysrdE5/3/t?=
 =?us-ascii?Q?rOHg0qhCAysqpDvzUZkrJ59+KiCubJQf++NdFu5k+rk9fHufZAgkk2A1IkhK?=
 =?us-ascii?Q?d17rZyV6fWol/8p6tkR4IBGD58HCpfdserfItodga0CA5nvMBCtIQu/ynINE?=
 =?us-ascii?Q?kZNO3euNRvC0tCbF4q7H5oNRPDmzFmFXklq5xSykvZcvFbdfubFyre4CsOcs?=
 =?us-ascii?Q?6Dwb0TvVQuWRzQsqG9fQhc/+nDuhOcpoO9A73cUDnE81I01ifcROpxlZnYuJ?=
 =?us-ascii?Q?FyRLf1LttU3jyqymifWu7pjgMo4I6+8o+yxiHy3f8yTAmlqtXBn6Q+BpRlc7?=
 =?us-ascii?Q?2ngcGH1v+Q1jFSM7iQCJw+Hayc4fQt4sd1FTE50nSXgcwgeBAi4abbmtuscA?=
 =?us-ascii?Q?bX0CSRQ0jiPXRRDLXtWyUcm0S7jPkB01Zxl4AUS6jk0/GY0v7Gb9obby5dvl?=
 =?us-ascii?Q?Pyn6LPm/6S/c6mS7duaxcvc1xB6L7UkQGIFVaTyFJrMU0Ewduf5dvKgYK8yg?=
 =?us-ascii?Q?bkxVjRNnbpuAG8pDyLtSiV7fEiSuwyRpBTqRPJTGHlXOZ+MVFwA52aCjzGiU?=
 =?us-ascii?Q?SgB1NHVg8tQAb+F+eL0hPIKlw/HWd2lusexGoCJPXX0Yym2llWzf0HV9oV/I?=
 =?us-ascii?Q?hNI+qr3keTlf7oieavKrOlz2JrT+oKHso0Xw934y9gmbb4xDs3qozCSl6B2i?=
 =?us-ascii?Q?kgyTxygq1jei8nEcCcDqJHLNCBlPSvbwuoe+Os138GsldyMabdpHqrvAZXZG?=
 =?us-ascii?Q?pO9EFIKAjrPbHAql+NDNAJ2C1j7OZlOhYquYJbieN1NVLzErm8LndQkhLVZh?=
 =?us-ascii?Q?vOs8JBvrLLMR5rUyAeMnXHGCIJUm53tcgl+avXJzZI9vIvR9s75Hc0vyQAvP?=
 =?us-ascii?Q?/0eWQfl91hgSu2Tk/DFhGAd81z4j608XUupgw9nkxOr/usS6b4ZE4P4oFmdh?=
 =?us-ascii?Q?CQxKhnoWeQccifnl2LHZIApBYdRzJ8otkheCCb0ij5gzmLqA03QJ0ogLeHU1?=
 =?us-ascii?Q?NaaT2LyM9Gc4zcULvaMRHNtLONTCOpDGbbAekAZOuqpWGWMgnomWm8T7MeYZ?=
 =?us-ascii?Q?P4E1xu9h5P7WT/0L+umUd96M0dclzj9DCAM0JupLCS2jxAyTADpV0M5MT0ZM?=
 =?us-ascii?Q?OcJ1jujtefXwQGpsxwYBumK3eLjxh2l+WRcHWhqlyFQmE+7YUh2BHrRMrM2r?=
 =?us-ascii?Q?1IhueXZSQuaxdc5yhQgoUNSJuwbykaSZilFtxuOAAW13ueI07YXPJ3k9o2dw?=
 =?us-ascii?Q?M9yjpYrUWktgaK0sPmO82CT7bISU/27Tl2drQlZ2ikcoLGUC7fCpvRhh4ULI?=
 =?us-ascii?Q?2wx8wQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a08c506-b911-46d7-aab4-08da80eba447
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:31:18.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTHTtEkxjH3dR555DDU/eWJGDrd6TnOY2IGoeuejpnxv0cxmClmss++V/Jj73fKGNVUqoVGUjOZ+AwAUba1ok6BN83sA5Klxf5RVLLEOLWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3486

Some architectures support running 32-bit legacy applications on 64-bit
kernels. Xenomai supports the amd64 architectures so far.

When this kas option file is selected the userspace components will be
build for the compat architecture instead of the distro architecture.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 opt-compat.yml                      | 17 +++++++++++++++++
 recipes-xenomai/xenomai/xenomai.inc |  2 ++
 2 files changed, 19 insertions(+)
 create mode 100644 opt-compat.yml

diff --git a/opt-compat.yml b/opt-compat.yml
new file mode 100644
index 0000000..ac120fa
--- /dev/null
+++ b/opt-compat.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  compat: |
+    ISAR_ENABLE_COMPAT_ARCH = "1"
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index fe84883..b874a4a 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -13,6 +13,8 @@ inherit dpkg
 
 PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1 libxenomai-dev libxenomai1-dbgsym"
 
+PACKAGE_ARCH_compat-arch = "${COMPAT_DISTRO_ARCH}"
+
 # use bitbake get_srcrev to get the current commit id
 def get_commit(d):
     try:
-- 
2.37.2

