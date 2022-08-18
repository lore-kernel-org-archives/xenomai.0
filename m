Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9C23C8
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBAeDunhMg/T7lD2x6MWCSVcuYSsb+PJzH2hrYxfaHILH4Gk8C7A5JMYRrEsqCQW/bjGluxwXsGYBwczfUk9gbKkDg1X5+Ovbg6W4lr1LKE/unh1h3WjYxHryhGZiKvRPzaH66ZhTnJXsXKLhAJcZhl0fuANZPywGn5WIeTatONHBwcYn41bhGEPdWXyjObSOPUUMOm+RQXL5WGfeIKkL/BneDKNABt/AxpAfYsHHYYy9NrP7Csmz9gSyEd316y2sWNf6h2mQ0jlueVXtt1suZMDhRlIuZ53YX7z3Jrb80kOW5flSRR6OCrtiYg8HW/lg7VxxFGImHNgFUHXkwseQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fiAbPMb4JFW1NssmHly+nIqiuUMqCyeDmsApRbiXIg=;
 b=P1m1YCalvScfNt/OgT8pwgS3NcYOY1XajsMuSZeJ9efaOl8e5OoLvPVax7BSbRCh1Y88K97jkOaS0AAZCZThu/bBRn6P0VG6q2zbdog9VLMLag864jjmGdC7Muoj45trmLHoAoOJK4hkFTGAdea3a+6koKGsDTtknkTdH1lUmR2tmlVG1pT09PMRLg/97q+UeFZjgzfyooicz6e6Jggq0vf3p4d+uf8IkVcNGSD33J+HQ3iKyTMrhNKWH0W2mJ0AFKM+38RjC0b46hkR0rLUckdoDs+DogsQAeE28uXYCCBF1n+KK+EvGr5l0yW7+nY4u57w4QL+wVqmC92mPJlX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fiAbPMb4JFW1NssmHly+nIqiuUMqCyeDmsApRbiXIg=;
 b=tD1okffAjpXyvI7XozBsPLfr25TSgyn5rPX6sh1ACw7tgdNk6hz6kl0gOQQknmLikUxWtLeXsxm2UG0A4GDUWRQ6Kpyh5MocAKr26YJaTIZKhe5l9PLT515Ny+y1nJz0gvxUlWk9VxqowSQNVE8iXLofgcaQbt8al5X/B1plw7ySGANsLWqHeRlRmsY9O+9VQDvehfJYVS+TOFG0mY5Q5cEs+nMQvCjGe4YUs8vGqnFY8otD+j2zs0UY3r6kFJPBsqDGSylOxmKnjeHu+3M4vJEI5f5DQYUU+XTIA7F2SgQ33TS8I+iB3XpPxxXLeBrhfIymfNGt9uJQ5X5DvZXtUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB3486.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 18 Aug
 2022 07:31:20 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:31:20 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH 3/3] ci: Add compat enabled build and testing for x86
Date: Thu, 18 Aug 2022 09:31:13 +0200
Message-Id: <20220818073113.19382-4-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818073113.19382-1-florian.bezdeka@siemens.com>
References: <20220818073113.19382-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92b02e0e-5a51-485f-0ff3-08da80eba4f8
X-MS-TrafficTypeDiagnostic: VI1PR10MB3486:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M3X87KIRMWdLpCmYqfJhhk/1tKW4zhDN1G+OgWEWGu2ysCEv1fVByKSm9MkroHnTlC9cAYDgl7CEseAOe3FGeNKr3ULW8IHbQR1Ck84xsZCmJuOWLsvwNna4UUELEO4wdEu/8l2ZiZ0gMXPs5b/GsCjM/bc+B/fk7sna7e//aV4KP9luqjdF2oRIFgg4GzwCAt9rZx2TwSOd7JAhQlq9h9/qBSrgbu3ccoVj3XIBL9WvBeQcFRcv+1u2BvSNRefIqeOROsvxVVxV90n7EukUq1Q8VTToD3FmJk+1VopE4ftj+mT242Fo3cngLnmFoafWYxClgQ63N3k2kWupqOja76zbPsEGy2Rgz2rZr9p7IYEXfPRWzhIJG+v1rpUcSZyikCJLZf9Mr6PlJr3XJJAGN8XSS6rIQkmcTBXTcCgbH1UZk2eURBS4LR49ButFUmmxs59Bo7lv7Io6EiydWeg4eoaUdgt2PmR5RXl1+V0NGU1cbwnNYJXGQ0FaGsHelgri/EGNluVuV+wLXm+xILLbDSVm5Nam1prcyWUMrvsyOX3buqT9/Ov79Hl5qxhINX9nyKNrAan4VO97ClFNsUBvqfUakjyx7tai70omi/ikDDetWeA2TsQm9LjB1jOXAXB+O0OVozt0NMJXbODN1UMzkQ5zT6HweHrSYSJVUvr+JJXYUq3685nKke84sro7NQHzJ/TnesJKjbGxFsHnNy+sHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(82960400001)(86362001)(44832011)(38100700002)(66946007)(6916009)(8676002)(66476007)(2906002)(5660300002)(8936002)(66556008)(316002)(6506007)(2616005)(4326008)(6512007)(107886003)(1076003)(41300700001)(186003)(478600001)(6666004)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LoH0bQkwtkE4yPtRnBOEeyHz8o/B2nzKy1EKTLBRc6MNvgfwVW+9W5xdXzo2?=
 =?us-ascii?Q?vKt+LZlQDIlsYntlc5+U2zbmOBYL/sIY/9qmDBeFcLYpQLEgrLqSa2mHdM9e?=
 =?us-ascii?Q?gQddRUqyXcVwepdlCNysPO4y9wHojoR6JXp81LE/td6GSO2+WCJ+laTF3rzo?=
 =?us-ascii?Q?/y4mHoBIn2tA2Iv8/i8+YU61l44ti+HZzgfE+RObMEg1LV4FHWrn5kK+vGS+?=
 =?us-ascii?Q?1vcOVZp+IrgAdolJQsCO66Kl/1PVaGdYmcgJaqcA+WPpBDkwnkwDKvy/EDn6?=
 =?us-ascii?Q?9OWXyIe101onUVeb9UuTSgBedqS65AGac7cRAlbTPww50GCI7lFcyriGoEXI?=
 =?us-ascii?Q?ktHoEPvuu4/5+Lz1u6iysyNivggeLamhbDGs7qeHVLD1XwH0R2SRM1Yvt7CG?=
 =?us-ascii?Q?BtxLfV8FS7uxFKt46YrIylEqNboU6qvdgA7GY6zgPCweGGB3ql12LZhOtba/?=
 =?us-ascii?Q?2EBS6m9ZmSLlPoaXZlxNRc9v4yddJBdCfwrA+9eyODrqWI21dRDwUBWLvom+?=
 =?us-ascii?Q?CNHoPxHcA8p6eED9pwgyKt/mpMoeqTQFNnDcIJBnSTvplKYbtS2bW6cJ6ie4?=
 =?us-ascii?Q?I16l2B243yMXsMlJXNelSJvhOx91cTcAXxeDskl3fp0AqLFHQuq/u1iK5NM9?=
 =?us-ascii?Q?kXt1YWjWiTLJ2n34XEKpi8dSoq+ZYBFulWuYH51WFUnCTidd1dqWP7ZZRDkf?=
 =?us-ascii?Q?5RVRYSHVX64Qzq+s8GhpmBtfdPm/WBrXfBT0HKE6eORIeYj7MI1w3gmvM3Uv?=
 =?us-ascii?Q?+ph7mYWoS+cgL10k/tzq8EWMK2BJIZKM50PePsGRHSGaaRAOHL9mggX5vP6K?=
 =?us-ascii?Q?OVPuBsB1wNaN8dUuxaYcQ0wxNhuqANXg3K7EeGjIU8AjlOKrWnuHNqVp1oyk?=
 =?us-ascii?Q?ILYv8FwNoSpBO7fEy7y8I1fEjGMSuq2cqnjwzP0KW7ieqn0Q27nXN9iYAG13?=
 =?us-ascii?Q?VlFmNm9xVUwjOoDH1tN6t5vGF+hqDVifQno5S4BQzYc9PjBstmrU5kYNBkMe?=
 =?us-ascii?Q?PGxi9kVpdValDqwjrlHFMEQ9T8KjtcYmE8/Qg07U+dob2Y/rqEYat3hlS3SS?=
 =?us-ascii?Q?toQz7hkwv/tvUECj4ZVpiarnGgEXYWUfirsaTsekXwIyD4ruNmLA2TFDFR+B?=
 =?us-ascii?Q?cr2EeYhcI80lMuheOuoclkCAmqyFDOSA0P23HTVNb0NSuw4liofda7g63gcs?=
 =?us-ascii?Q?Gq97bh/GdEU/NZNNPUxFW4baqTRWk3vE8m4fH3ILRUF2RLtNMyg7JlHRaH5K?=
 =?us-ascii?Q?OoGR2tGyyPbX81pOB+uR6H9N+T+tKP2xlgta3XmOrulhJGQ4R6Q5R/YSwku5?=
 =?us-ascii?Q?9ViZ7jdnfJQkg638Fo4akxovjt58AcoQTLIQFUgvzzkTBi2mMVVnhEud16S8?=
 =?us-ascii?Q?NN1csEaiTZ8SSxGyK82P8VS7QkTPIMQ1n7GAl+pGpdjhBdfCPhnt2x5n5B8b?=
 =?us-ascii?Q?PAKf9lSssODH+dZjYma9A0h/AyQzljmV4LIZqumHLl+hn10vojUKHtcxGn8S?=
 =?us-ascii?Q?nL8ZbWlLTYQTZwEZrDnElg36xw2ysINIA8M/z4aCqbOjoFAhO23fH//oTl9t?=
 =?us-ascii?Q?lheLodR2rtW7girI7Ekqg5ZqmgPux/GHueQn9ew3mbblKNmmsF5h3ofbAmVN?=
 =?us-ascii?Q?EFQv/YXVAoWxGHzyj8m/8KKxRh+26gH9rWCSMyrnQg00rod05uEniHmQdPxA?=
 =?us-ascii?Q?3qr//w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b02e0e-5a51-485f-0ff3-08da80eba4f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:31:20.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxoT6J0l0P5zUTwV/VW8NNAojmKvsFzrycEbx7HUZ32Fo6DE+ReAypcHWdIsHsAz3dh/AGboOUK7zyh19XtkIUAl9uHo7cQYi9r7Hon8Ypo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3486

Adding compat enabled build and tests for the x86 architecture to the
CI infrastructure.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .gitlab-ci.yml             |  6 ++++++
 ci/xenomai_next_compat.yml | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 ci/xenomai_next_compat.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 58398fc..b972063 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,3 +43,9 @@ next:
   trigger:
     include:
       - local: '/ci/xenomai_next.yml'
+
+next-compat:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_next_compat.yml'
\ No newline at end of file
diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_next_compat.yml
new file mode 100644
index 0000000..6ff155f
--- /dev/null
+++ b/ci/xenomai_next_compat.yml
@@ -0,0 +1,41 @@
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
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
+  XENOMAI_VERSION: "next-compat"
+
+build-5.15-compat:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15-compat:qemu-amd64:
+  needs: [ "build-5.15-compat:qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15-compat:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15-compat:x86-64-efi:
+  needs: [ "build-5.15-compat:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "5.15"
-- 
2.37.2

