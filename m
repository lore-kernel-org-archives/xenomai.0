Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471E1C14
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 13:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGDqnI9gs9pGwZWWPD7NuixLou4GLyAE0Y0M0zOaJZjyWcC7j3acp1gV/gZhuVncgPr/I1A9gaJ+TUM13atsm7BADqBSjAGrZGRU+nicWAPsDp3hWVHTG/hUzNNAapB3yoyMsZKuoS7zqhVUdmJN29dn1lr32s2bfB+hEFN3On+iAUZDmP3vSL1C7bfdHv0GepW9qB7ff+RuvmLbrPeM8H5uSkT2fL2ZfvYL+t6uMEQMHnsr3N1E62ad5JrFT1qVRlzE0Oi84BEBbbsBsERxczxVNWgjHQzFzdopmLFyNc8iHsFXZa3+tznje9YYjXwfqVWL8YO1US+FqeOAAOL6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq5R0fKVoAzoytlNT/8pJ7ldBODz4iUrC2bpd3VDbbY=;
 b=gVhtVmeGrd0MP7X8Ue1k9on6cEzchC82btNDfWoBzrveAMxh6fK5wIlFFCiPrAuhEbciacKxY7NFLjZwHXT/du89CNRDlsptyr+uZjLoe7J06w2JVZKtIqizq5cnn9paMmwgbAWJ8jCpoYfe9VtEbdkKrqWdVdDJVIdcIMPW1q/RT+pzf1jGbfG6U4Wup+rWEcQ8Hc7W2ZQ2PM0/fwotgnCpNhMSJwL9/63Ef9OqxMJAgZX3DYFzZsrhvHbO5YwTVIJocMx4Yd0QaQ5gTq0tm2KPb2ThBEyl4fKCYFt2aH828Ckml70SKUMhc/nDYpWt/BhQuIx3z6zhqArqzeqagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq5R0fKVoAzoytlNT/8pJ7ldBODz4iUrC2bpd3VDbbY=;
 b=VzvVB6/fF7lx5dQRaEkbukmiNveFdWK8iSNochHvTXrGGWeZyt8SUF95AXCYAxZzim2aO/ZdaJgIrv8gwjawdyLFf+KCSbis8friECawKkcVU9h0twsdbJhEad/KuaZU8qm7qbiqgN2/alHrVM45sxVVUy99zrtt26hkeBCd+q2HbeQgZ2dvwc/vyST5MhT3WB009KIgngFy+T/V6V0o0YnfFiYTaKCONvRK5gO7d95YOE6N+EAwMzUbRdzD7xh8IkFZmzHcvo1qsD7yofWc1nEYJmdOAdpl+ukIihgAXP4fMz3UQqzjgfu8YMyDGX0hnQA4Xo8tfnBOHgwKKJehgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by GV1PR10MB6217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 13:15:01 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 13:15:01 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH v2 3/4] ci: Add compat enabled build and testing for x86
Date: Tue, 20 Sep 2022 15:14:53 +0200
Message-Id: <20220920131454.121225-4-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920131454.121225-1-florian.bezdeka@siemens.com>
References: <20220920131454.121225-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0043.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::18) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|GV1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a434dfe-3ea9-43a1-3471-08da9b0a1ff3
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8AOM74nr3whK3Qn9AZGDd370Sn9zqywMlBiipMPxoYny3Lxg3oGuBB/Pq/Uvr0f56zRsW1Gc8kuTIzGyVcvCdx6EGFcThobIJ+Zma6GaGWWAcQPjQW9XZbZj+wfX4cmt1MlwMqr2T7yN0AzzWrxWFz2FA7IY4X3LwF5+FzP1v9QcZoDA/2ntp1RsiKHNozReHbNA+g/FPq/SchV04xbZpno55AUqCXzfEeNAPcSXciiNh7Lf8/FcUMcDOmQ5DoA4sK4w3MeXC/fdO0CZ0mwtYNX2ESk5z+8CwD29dNRTFzmyRURiaLHYdrqlIexJXOmF5TI2MYXtxEX05YDnEdq+1VnXN7YeeyYlSAuY9RNsspEnIe/hYv9w0uyO66gBszdKPcpo91tqFPuIdRGexB8e/QwELJYgYSe1+YZoClaB2Hmdxvmaj9VFh5p2NNSDZ6SmNbl5Mgt+M+VuUkjx9H6REnm9fBkrQ3w07x6G/xOrA456b1u8sYGubCESF1OGwP3Thd0/GQzNIyrthswc4tj1QU0BY2zdDfeSNNi2nZcCJ/gFWDlb+I9ndodp4WqahyICXD2SVAx5tbohuGJTRlY+7WbdqHvn+1ZwY4ZXIGZjm7pYa8rprxFiGT+PPUrlubedpVTda6wGB6aqs3LcbesmGWgJr5WziBMk3PZYwFK5KFGqGSKoAzwtWfb+MSlLw+KfMFFGoYmLLG/OkAfAYIz7Lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66476007)(66946007)(5660300002)(66556008)(8676002)(4326008)(86362001)(6916009)(316002)(82960400001)(38100700002)(8936002)(107886003)(41300700001)(6486002)(6506007)(478600001)(2616005)(186003)(1076003)(6512007)(6666004)(36756003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X9jxi/NNWRtonzEJYoV4mAF9B2IvC0egU13+2KHYuCBEajmtPfVnq3ohvKIc?=
 =?us-ascii?Q?b906+/QwYCcxmNWhaVVnati9ZxMkD4gXbshX9mhd5ddsHtKH43ASMD/DuSEW?=
 =?us-ascii?Q?FMob6MJdZlbAveM8mrX609IrO8YBkrRROnH07RLg0lQOoc3K488fQGJtxvkQ?=
 =?us-ascii?Q?gU7BRxV5UWRryg9XZzJseV5gi/wkAEcMcuWEySKps0nA4+V548rxmV6jOnHb?=
 =?us-ascii?Q?0dMrqIEJUlk4LeJPVONQ6dbZFmERS3uctZZ32JxbmZHL7YU45kgi6NPlWX19?=
 =?us-ascii?Q?lA26bUykj6wX3aeqkUNUqf6vLED8tS8EpaS6n2uq7oT1QJvO+R09s+VGHK0u?=
 =?us-ascii?Q?oF80YahoB4pDPA5jCeOzoPLZy4bhfZiAZ4lAL/AhYzEG81/6ZXt2Ntvc1H3+?=
 =?us-ascii?Q?00PDuFZU3jahNphnrA2Fzvc9h0We6+GlvixIfrt9xBItOLLSZ1hw3hy103ul?=
 =?us-ascii?Q?eQW8eWUGkryncDllYHIufkP32UMw7ooFGtVdNXDJeMlV47bmOVpHwnlMQOvZ?=
 =?us-ascii?Q?bEiXLB+ZKzqA9iFBPAnU4KG9m0E3TJEm/ufeKC+1OaAlT49oTRzxnHhgHZkn?=
 =?us-ascii?Q?ClweE1lBvt0HvYcT6+uugS6ZtovBXHUfQ/b1HClOwKbFT8MlWeVEigHCHrYH?=
 =?us-ascii?Q?gcUvooIp+DP5UDmkL6lRuOHk6CKlvkJlGjnZN+ybPyyWp0uwjxHquCfyld0L?=
 =?us-ascii?Q?DjGJR/ygVZfFubWC5qfYvliuZpbLJXf/MPcoegfxPRZwGBHlJaj4wKDGqtXU?=
 =?us-ascii?Q?TwTXTrDno4Ubc5UJjlNLEkdqTxzvsy9/uhd8qeC8cGcdmy0kRfvAHeFwAsrW?=
 =?us-ascii?Q?Z40rKy07oumny9o0fWLsFv9VRlo4SGHgf4avKPBnw4P7aVaul9s3Mv5vy3aI?=
 =?us-ascii?Q?62sxoxdwn3a1v5Qcc6P5qIYBjysK/zo0Q8r6MHGtVx4Z8GfA+JxxY10RYqF9?=
 =?us-ascii?Q?SbQfukw2tyrBJG7y9a3IsF7y4TNWz222wlp5jG1X5r77yymfCIGj/aTh1TmG?=
 =?us-ascii?Q?jA9sOCqg+6iouQkMfHLGA8LXLcY+TUynbS3tg0COIcrDtlGHl99j2WQchwkv?=
 =?us-ascii?Q?MonhPkXow0EwOgyDgpH3quJcuJKVuKW5qupMVu96AAiOXsP+27/iBaoFzy3N?=
 =?us-ascii?Q?+OBKJWaoVxPzodjt6URfYFnZKpFAM5wHvw9j5O3kVnp4W0iHFQ/FrSqsicDD?=
 =?us-ascii?Q?ek1/ZQ1rs/eNaiRQzC8wyZDR/2pl8Ft9OCQC27wc+yZQX+gSUE6nfdGFADC3?=
 =?us-ascii?Q?V4LvLpYVw4qbxVcrNVF5FRA8uDQZwZtT5uXzHFDuYfWiK8FoTRO20Xsi5qnv?=
 =?us-ascii?Q?IgiHyYs+as8oUZ6/O0RQ9fjK3cAFOMhifq5RdxUoJb6tkL1AASrPwg3xpGE0?=
 =?us-ascii?Q?BueULs3ABeodccT4zV7og6d/WOUEJ0oVYC815mtUHGzcm/gDDzBKs8yLzXiY?=
 =?us-ascii?Q?qHrf8II7EcBfoQ3SoLxetyGGC7lLiA7cmZZUrU7S4KuMspHRVSItsGJkAoVf?=
 =?us-ascii?Q?9KvKIZz9Ruca2YJkOXPlcbqml8huehk4NsafMXbhu+ZBEvi/dfJi35miy51h?=
 =?us-ascii?Q?ixdUtTxdJoww/x8VFmXNgrJ4RC1tFsSldFaqR/4H5UyGyzELqaQyXWkIcYMR?=
 =?us-ascii?Q?oWhtWgdlYpiHroLI7bHFhUb4EPoPoQRTKjVz67cZebRhTfBAIH4r7r+hHfCE?=
 =?us-ascii?Q?SG2stQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a434dfe-3ea9-43a1-3471-08da9b0a1ff3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:15:01.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sbz06OP7B8lpnHkCHbCwtOrdoPa2nwq9V2XPmFmfW0vpR9mtGb0IAgdiQa+Dfyn0Nf2UPJL1Vun5QVUEaOUS9YXldpmDbwp5s4yyjo2COk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6217

Adding compat enabled build and tests for the x86 architecture to the
CI infrastructure.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/xenomai_next.yml        |  1 +
 ci/xenomai_next_compat.yml | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 ci/xenomai_next_compat.yml

diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index 52ac6dd..b9e9a57 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -13,6 +13,7 @@ include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_5_10.yml'
   - local: '/ci/kernel_5_15.yml'
+  - local: '/ci/xenomai_next_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_next_compat.yml
new file mode 100644
index 0000000..92571ef
--- /dev/null
+++ b/ci/xenomai_next_compat.yml
@@ -0,0 +1,47 @@
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
+.compat-vars:
+  variables:
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
+    XENOMAI_VERSION: "next-compat"
+
+build-5.15-compat:qemu-amd64:
+  extends:
+    - .build:qemu-amd64
+    - .compat-vars
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15-compat:qemu-amd64:
+  needs: [ "build-5.15-compat:qemu-amd64" ]
+  extends:
+    - .lava-test:qemu-amd64
+    - .compat-vars
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15-compat:x86-64-efi:
+  extends:
+    - .build:x86-64-efi
+    - .compat-vars
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15-compat:x86-64-efi:
+  needs: [ "build-5.15-compat:x86-64-efi" ]
+  extends:
+    - .lava-test:x86-64-efi
+    - .compat-vars
+  variables:
+    KERNEL_VERSION: "5.15"
-- 
2.37.3

