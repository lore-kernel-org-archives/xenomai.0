Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E381C14
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 13:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXar0f/W17V+mQHvjHQ7kOPcW834UFKCQVaoUoqCBrG2q+mogPYlxhWWoX0ZteTL9ED+AJKmYdcDSL+TG/NhZzXgOejSkQE6YzwriKJ6upGXt16geYVj4ghPikfeXO0ZOtikNMOSN1q9yd5j51CHc3K15wP2Yj5uzHyThSNjEaQVlUVGLGmx4cH8Pc84cEwySO0ebyrV7SD7Q48GJWwVJFOcmjukmaNtmED0E171sbISgGBgFAb2Us2eaHFmbUQigRQcHvxxhNEj0NJr9WDBhdW7UwpakkuOmKIFjIlhsxBRN2Raw0W71T6gRMaN4yxjlkQRM60GaSiu9rL9VLjw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8Iurmgf4HRGx0zOYt2DCJnjLMZBVEE8Tmp2nJA8fIQ=;
 b=lnl8h+3d98OFQu4lOZnFSLDv7hEmcqxXYQRsr1kjjEVrheYHikuwJS1AM6th6LSVP/XNo6WTlWThLxB64fcaZcvKUKkAcd1UmZ4J/P5xnC9PzSPlKOc3Qe6dLgnAVHG7bSWFebbTcKBztfs9adpZ2VgwZSt6J9Ui2+DupAVw71rvnNJBEDwdaj3lDUGzFaPj3JTyTlxvgw37fPJc5PpQQBz3QHJBTk+4xmC5a58+UrLPrpxQIOFmfLjXpCHmpEIYDM/RuBoyi7slNpIY4WJdoUiGySoX1hTWbnyqQVg1vW8ThlpmxJsZCUcp8v0zQB0/5dVh8vadzKGhnod3G7cOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8Iurmgf4HRGx0zOYt2DCJnjLMZBVEE8Tmp2nJA8fIQ=;
 b=F7l52uhJfoWdwZQs9CY3rRyb272HHrRulsmBlnH248pms/HSXKTFixnIORijbTxX1vO9Bi9W3uhrzmcAUHU3q7wTj67aFcEmR4/VYz3P75IXS0mxcPIHZZK14YFJed8sK6hQY8saLdsV3FyRaY3cJg2uOxN5Zai4nsJA3UdqK1B4UOg18bmgxbBf0CTsEUrZxlgtHGPImT4vtiH5MUVL1ExtrV3L81Po5yuMdfinkztBgJD/B/k08N0FRpM8p1phoFurHZsis2rIPLd43wIbdRq2weZmkdyVZR1s+rBQSUe1ht1GTx94idGrLHMPOW48mn9tUcHPRvTdfqVAyzuXLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by GV1PR10MB6217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 13:15:00 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 13:15:00 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH v2 2/4] kas: Add option file for enabling compat builds
Date: Tue, 20 Sep 2022 15:14:52 +0200
Message-Id: <20220920131454.121225-3-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920131454.121225-1-florian.bezdeka@siemens.com>
References: <20220920131454.121225-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::27) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|GV1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 076a8d47-4f2c-4653-f967-08da9b0a1f3d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ysv+B0C0o8v4DBpRX/ijsAJIq/XBeSX+Yo8hqfd7LsgzdveQrZMT9Ypl72xbkyQQjeKUg0MCPaJZ7VeSzgOyua0BfYFTOPmJqaNtlSk+r1nSwMuFH5LdMQo9GyAo380GOTfXXUu8CYz7UGbysEOlPzgx+NP1CCbD9Aj+nwuSQhqV1XxTf1cXQzww/+T9NXGXfEE4DNN9OLfRsCjVXH7/W4X+02G4BWIz28cOmA7M1MeIHTALbnwf5h2PHic1Cqrp+PbZQDn3ETsXakgxDboHu+yGF8JkQ1N0h7KgeGuMrtH88wTA9dDvr/2sTffKCO2ePQSbiSgj1hunHcdJEGwvZcWTyo+RdEm2UwFNbPDlrF3K0tsqtSgplOz/9mU2BEI20YQZJH3oOmsPZvFLECkwYaWHJSfzKWbRhutbHaz1sLkSJgIDxisgpt5pRBl8f2rgtjtsdur064C+BB9BnTYeu9WJIUnsCvFoEMszwnHjzR8uSqZhoV8FwXjotUErclZht4WPttEiZStlqDUqIhl6R4UWQC6bNqZ5GDPTuRu49nv1x2s7+tSu1e9id8ntVc6K136ZaTXbIdp7DCPde6ftrqGGD7uAPYiIFSnCI7ybVK5JAag9P76TMieR1TfUHdHV4P7L3qL+tLTn9qze0inVbDwvPGOEqRZMpYslTSfeNZMxERR3a4ug7+Ls+Fbm/GDjNCVcqylvJMHLlDfMblmDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66476007)(66946007)(5660300002)(66556008)(8676002)(4326008)(86362001)(6916009)(316002)(82960400001)(38100700002)(8936002)(107886003)(41300700001)(6486002)(6506007)(478600001)(2616005)(186003)(1076003)(6512007)(6666004)(36756003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?or11ZN2ro3cmeZvW4G2GIVckLnTUr4tWN/1oyGCi2wLYZ5Jgc964bZ00WN9P?=
 =?us-ascii?Q?t9jdEn9q0GcG4mG8wJDqRMBjXH6vCEuKkw9M+cjqmaGtFs4TUrtz4HT+2QAE?=
 =?us-ascii?Q?kiToE3QJYYsoHeYFmVZb1tgpx55oy4TU7LrMYrL05ldjThRxzZW0l2nk4ujz?=
 =?us-ascii?Q?nL8PF11PWuWBv3y0wgvqpk+eLkl5i6gCI4hv6/Ztmb8RlKlewhgfzNJ8B7xu?=
 =?us-ascii?Q?OB8H6C8PMXF1divx4DSyeILpJSpfhHW/9bAjp0sKm9c0KK3sJLb1V5SLQdnW?=
 =?us-ascii?Q?dqNxDJzuHpkuwuEVFQi6kos0+9cjdBfe1YlNAK1xX5MDxcWhYr6vfoBG+wT8?=
 =?us-ascii?Q?NiN5yVHjJqdsiALGxnKdsY9E9LsWhPKgW9amtESsm4efNfzXZ9kSMAQxDtn+?=
 =?us-ascii?Q?GJo3ZMcWJG3Db2bBzIsZtvJRnYPv89f4Tn8vqHPlynxG7lIH27mwhOhqUuDG?=
 =?us-ascii?Q?mRoJuZa4v+MAgPxu14CICFQxwwHiMSvB8FHsp5jquXeLGlb+uqHpo8ukNlij?=
 =?us-ascii?Q?fIOgGD5F4uJbmmFwGi873p7bX8wdotVVKiFpOEZh8N9F5Fn2S0odXwbXTebw?=
 =?us-ascii?Q?gKDCBGHgzyf5359UbuipLNz/3wY5Zd0fKk7jjhpJ2zs+YXjHlEuYL5Q9euvL?=
 =?us-ascii?Q?swfap69Q7XU2Qmmdtc1tc9N5avUMX4ZS2q45+nsjZP9z7LKdIc339HBI5Ea2?=
 =?us-ascii?Q?kSREChzin323sXefNR/fsBqyH8arvaFLXj2H9bV/h7ZOKKbDFpvVPQWOUVNE?=
 =?us-ascii?Q?hszYLbK6aI5o1NAqSbsu7iMnlJQb9CSuoDUU+FpmV+j3tKzaEsIAanInXrGx?=
 =?us-ascii?Q?+k7wH0uxCznMKy4l6BJKcZ4dWksCNdE3ReiX0pdcE2VBmAXBRyU+WsrmWMXE?=
 =?us-ascii?Q?TONJWqLxAKRqTF8bcTQDSiQwoo6c0NjbX6wFlF/Zzj3aEmXRu7jfnCgtFMyd?=
 =?us-ascii?Q?yw06hHCeG37gWpIqZBfkw7kc9g+rbmOPQif295ZFGxloEcHntM88PuLNY6Kr?=
 =?us-ascii?Q?0PcNey5nWvAGvWABdPxlyRe9x9idJRaI4liXMmxJRdwCKYj0OeETnEHrEKFZ?=
 =?us-ascii?Q?QZBgyC3pzEHTwQmbiyLSr+a168Kd4ykMc0rNFLGxc8b9vz4ggLCPHf+UDfc7?=
 =?us-ascii?Q?9gDFSkVOCA5SddV4zyDEOTnjD2b1z9iST39BCVrxxszhjfZou1eXzAFItgwH?=
 =?us-ascii?Q?R2kKIUFDKwAe0YSRpQ44BapdC55ZYuEEe7OJUivxmFIo+pM0PR1ZDtulelTc?=
 =?us-ascii?Q?q+hzHFYGCOWkZTnFjRBh3wAVi/44zHqsBgYpvAHS4FTKOwQB+/62ZGlHWCus?=
 =?us-ascii?Q?SHXftTnCH/1XxT1k8hp+34iRZ4NKL3OXm9yfEYkppj7XldjrUFEgt03G33xY?=
 =?us-ascii?Q?dSOUjEdbq+yZ+cjT/VK1K7uzVRhL932WYxmT5oXo+0SzKCaJGTllQSloJJCF?=
 =?us-ascii?Q?Jb9wvdlos0AlifmvEPghR4gXWOrKL102uyCpjcI958FSj49YhlSZucJ2NwOT?=
 =?us-ascii?Q?w8QLiTvn/b+5M4eh8ZGDlTSUKZRMxBuCklieSR/sGgEjgE0ATFQcx05soMiB?=
 =?us-ascii?Q?Ak7SYgW/0IHabUkXxwkuirrGf80dwtW71ttRrfs8xV/WNnWI1umZhb1csroK?=
 =?us-ascii?Q?uPCkHgxAiMJKWrYrRcKAupz96TuWDh1p53biWPGpyZNTC7BV6Fza7PpLzZ/d?=
 =?us-ascii?Q?hu/44A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076a8d47-4f2c-4653-f967-08da9b0a1f3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:15:00.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE1PhMt2WnyAIU/Ppqwfe4B4Yhu5Q3WSWmoWIJdgzRmSkfJZ69lK6X/HsBF7m+4Q0E6s4m3TsC/qPQ9Sg8p7dTWypiqsJs2mqXNYQ7jFLHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6217

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
2.37.3

