Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895E1A2FCE
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154822; cv=fail; b=FIc4fC0pqQlOnanGejwCiw2lzseKJevv7E+Bo2F2UMcrg1g6wmXU8rty2jdwqgRB7LOwoZfXdhlcNvYjCMrkVo46XVCdR02mYokae+zfFBMRXqbUm4HR3zlCF1g7N4du0btm/qFuyfPJ4/K1PiBeFpyI1B29yeJCyGpOWp3vwhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154822; c=relaxed/simple;
	bh=3Edugijl5Xgq5wfW4LktTCOpILBx390ZXk+hJ3ZhEQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X7eOwZPBr7/s6SnFCViNRxFKo3R/sxUwi93celGvjoBeH5naXTe4WLNTkebjIJBJraMgO1qy+Pb+13bQnQVi/YiBK/Mz1YMGTnh0NziI5wjhI6XuZHE0EsWXFz6yCQSTvLQ+9C7wzgCAYanoVcqCNTjKypOaJGTu4pLMZIbt2qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gLhA9v3W; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gLhA9v3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldQLsRDHZertvFvwl87qV4/3FXPHAXRfc0xeFiALG9do2fbrf3H/6X3oZAJvv+JsMgtR+fi4TOe7a/uZ6+7qIDwaZ4rm2q4K7lnXqsM986LE/P53W4JjyG1QUh76rnfrQ9y6ccGI6D6Gk+be67R+4cNClwHETDd5OL5qTN1UTR1RMnaQ7xOYIwpG25ccmYfWOV0nqzVp46tOof5XqIi2Kgp1rzAiwFV2Fp+Xc1kJ8LctWiMI/JcrHXBuxmVVtkhEvdG+ZTHNVH4fFrLop72pqLgzMZvh+5PADdisgeqLQVu60Vg0TXd/w16ri+gkpl6XJIKjY8aByhy/xGxMwx9hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjKYczmBK9xOjbEgJVres//ouZ30IA5cZHDaeBBCKu4=;
 b=x4QXT3ia5AFsdPK4MzFVE2pV2+1kx1JRvSCCbmcav6B/XKhU2l8hKL9XPPgzcb9PQYY3g+o76JFTi5P+kcW8I5waXfQLvJ13e8Vqgtc25WSm8QT3/8NNjDaWYlEsOhuWbcqcj653ueBxhjw2hiq+DR7hcepyHzR3I+TvmY9kDH1XsNE69+WJF9JwCvB443nu+/5u9BUnUlp4ZRLpMJbN180qAFdJ1gbzzYOhYrjlTA4rsDAv1Us9y0VCGPrQESUydJogUd0oejNk0rbp/ZSt6759H1xDEDIpat6Sll+h9L/SGqMSLSmqha2FBpX7g7h43jM5JMBcQNwfoZzKlE+1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjKYczmBK9xOjbEgJVres//ouZ30IA5cZHDaeBBCKu4=;
 b=gLhA9v3WJmkbP0QXxtt0t8dLeMAMqt4Mjipho8piswDYdiq+zIqoZ9STKteyf/ik8wa+UrZrvxlo8tNVNiQUR70WYSbmvVIqXC/rvDhCICQ6ZDT8rVFMQxj6eRBUFWyTsWlbvgAfMwcjb6eBlyXGYY2fzdGMgtL3Tak4xMeWC3fh3CZBt4ap8nai91frAouvDIoVMagdib2iR+gvhPKbKGNk9bWkwmdzOEtv6wB40jFHl1kdWgXuqfzKNJfEkNcNVG2ky3aj2vNYFlNVq6qeDrJ9mXgNFIzF6RaY0DGKtW9Sa680dztcXhhSBKAKQKjdRlqykeF5xjZEHmMzcdafEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by VI1PR10MB7829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 16 Jul
 2024 18:33:32 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:33:32 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 2/5] ci: Add a long term latency test
Date: Tue, 16 Jul 2024 20:33:23 +0200
Message-Id: <20240716183326.1432379-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VI1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6bee21-95df-4756-0eab-08dca5c5cba3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?voHQ9SwUVvPX/Q9wbjTBN7v+YkLx+bSRCMwgbyQoj3oenSERD0RYuXjmolyB?=
 =?us-ascii?Q?y3c98rdEEXK3ZRzkQa4Gk1caMbgZZNDqLMelJ5WCiYbGsABLDw0/LZe1t+f6?=
 =?us-ascii?Q?8CdrJRjnWRCxWCSP/laXUDKcGNDnty4tscBNuW8JTLu57/VLIMqxKDatJAEe?=
 =?us-ascii?Q?FCwnowm8oHOsQc3+hq6i98Z02YtmRaX2IYE5b38de0nLTv4l1Iu9Yh4pdFDa?=
 =?us-ascii?Q?lncmWfq0WocG6/NXjOVCstAfctDLyMEUisgOgLO0BZ0WAUT2TsHtibZuU8Nm?=
 =?us-ascii?Q?AkuEd1Iq9lnB92oIuGJvyij8YpaHiX2Vh4eG5s1lyGxUbjAIVbtnwMyVp0KV?=
 =?us-ascii?Q?fmsE3Dh8oZyeBoEcZqYh7pm01EoGIeBs4KJwOI9FAfnWz+Ya4zZGpWqwS74o?=
 =?us-ascii?Q?GddQwheMiip+kNeeJtPNABsHD/1JYINir2ap0tPVlOWqZM+aFUiqNSbx5vCN?=
 =?us-ascii?Q?nQUkLDkdUsJOX/+VbmnSdPM+VLPMgHWNKumjPa02+LgjwJNmg2PX6J9Kij0f?=
 =?us-ascii?Q?+Wae1M/9HI7R+0FRVJjEyJpUNOWeiG0JAVXSo6i8+nqc+cjN5O5NHJCpTZ5h?=
 =?us-ascii?Q?unq14SMYw/yTZ7+XY9FAD0W3njPG5CqEz/gywG3VH4U+M2owAmizohkfN0fA?=
 =?us-ascii?Q?+3XvnUhGdm2ALJ8AIRfl4Z5jFUy0PwvNrwbtXJNzL95XYM/cPWKYvgmFQzMq?=
 =?us-ascii?Q?HWJ97bPqTkpq4595eMd8vix9/2kh3oa5UaSjawZIgbUr42GHQJ7o4EtWwDSa?=
 =?us-ascii?Q?6Q55KtxOg9WEoJtYPJagzG2+896+weMG+FMkBIJ89cAmrKlLraIy6oapGlJz?=
 =?us-ascii?Q?tKDy20MuH/r7vwXPdO5IJCtMrKeVRPJ38XFgK3Xl8mDl5jk6eRPoimzTkmfV?=
 =?us-ascii?Q?1UD4cToxJaDQv5fKiVVMoa38qORhulAI9L5FtA88UZQdrtbZHYPhQW3sRP1q?=
 =?us-ascii?Q?BtI94b2p9oaNlCr/94NFfWjYDrGqr+ZL8FGWh0gh15VJnGdDyMjpfKqNQn65?=
 =?us-ascii?Q?HObqMRkAhg08JkoFJLEfy0CchKY+Cw1ZnBngeu47x97c2AGOHOjJvWvN6lI8?=
 =?us-ascii?Q?44lWhrrQCcAhTyBl2H1gSKxKgTGATPigF2l6kliAcb31FEtLxAvB73PBW+NS?=
 =?us-ascii?Q?PakntXBkHG7i9+9VhAI3MkXku0P9E58EtLqPsa+k4IC/KU62E6ZMbmcTVFwG?=
 =?us-ascii?Q?IMfd8cCM+iGQRjb7sEgIXb7tGiYYB1r6qBjcci+nZEGVaXUkF1RNzwpBBvXc?=
 =?us-ascii?Q?TFyPA/I+zTT+Rr/naloMvlRz5i4u/gf8s7AIkTrt1JWL5FxTWMVvblG9jYJB?=
 =?us-ascii?Q?YW6h6CgKfczSnBa1kq/zjBb91H33yDepimAnqzTofiBJOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MhEddiF2XVyp+sXIVjkbjoMoh9o0o/37l8tmYXadtQTgHnb4UYQbFqqZWqRL?=
 =?us-ascii?Q?tSryLfEJBlpPCcFhOgEE+DhSRuIdjR3swa+JsPtb+QulI3XyZeoTqlTNHUqf?=
 =?us-ascii?Q?zoL6O5hJ/Mj41FBvlS1HFzp9+b87AlSwZaxBMjqJSOcnajEBtiZwrJav2S25?=
 =?us-ascii?Q?6OID4CLL4zZNwo43YbGzRchgRyILBTjU31NY5K9UctAXMeF5t+d4GBlF9dHV?=
 =?us-ascii?Q?8op+sXkGS8Hgvv5sPh7CD2jLXMMRo7Wdvrc8+SGSMUh6Ofox96iy/sG/tP14?=
 =?us-ascii?Q?wq+mAIYSstcElWJEQVJuOKPM7eHBAU98aysr6Qg8FJrYAy083wSmMhSyqNpC?=
 =?us-ascii?Q?CF7Ay6vCT00OVMZ1P8z0WvRk1ta7EvS2/9ptP4i02ggls9FpqLMt+RWBEAHG?=
 =?us-ascii?Q?O5iOftVIPtmS3MV6HtKcsm3argeRsvf18VwhyJeGKOcr8NbzUGqNgx3nv2O3?=
 =?us-ascii?Q?l4VU/q+X0rukrkXSS/9uqnTNdxFePwVc+8UHTWG+2opmLv8+LX9LXdbWN6eG?=
 =?us-ascii?Q?dgL+cxAxY+cfqE5oKKk1x99fCxJg8X4i62LlFb5SCWzvrlh/2OiwtOyvVKlu?=
 =?us-ascii?Q?mLuGBUztoySZ6SvZ7690zSHgMuZE9opWxMvUSQVE6V3ohpbHv8txCpeBqWCe?=
 =?us-ascii?Q?fo7F9s7oah4bZ0sb0EAB+EZW+B4mUku6vFIjSu55jzyZNCzX0Ivw1wpO3U5C?=
 =?us-ascii?Q?GWCa6j2hXvHIjUPmrV9ZLAVB28DukkbLdfXaDoMS0DHL3usrzZ2WZTGXg3VJ?=
 =?us-ascii?Q?7JaeaP1dc9Ey6RG46tAeE2WynOhIVWeGhpauqrm7qAE2JFcAyQ8gTfhmC1zO?=
 =?us-ascii?Q?m8H+OzGjZeNgPM7s7nTIgjwaKLw2ixagd89q401mjmh6Py017rS+87zabQ6n?=
 =?us-ascii?Q?DPQKQD4OVNw9qMyRuzzszyEaNxSAQJWbsq4ioysXaW7ba4uWdTGy1YhT333x?=
 =?us-ascii?Q?DLMkYf6+xKKQkwsN1QRT9C/Cy++5RlR8dBW19wi85k1VYs45AskVJdcXk8c8?=
 =?us-ascii?Q?Q1/C99MAw4OgeXxU1bdFOPrQVvsTj+hDY3uHa31CYjztTAaG5v0Zd3956Jqi?=
 =?us-ascii?Q?yEM6bDPCpOYn2vVvIlgaH7HKHUjceuvsTImk2cs3GxCodUZf6U0XHfE1K/N8?=
 =?us-ascii?Q?hyIRFF93jAsDln1vBoCFOJ0bCQGC/LNF9trESEquTWiOTU0inKVBIkwzbSfk?=
 =?us-ascii?Q?VpJKw3iq8Zj43CMA0IQdscYxxJROLyOcH+hBjQ8os+mgqTWcChspHlDLa/KZ?=
 =?us-ascii?Q?0ux0sbXAIdnC13Y2u1KfsCkeSN7WrHeeXv3LbV2XulAujGTIs2ZiT+Gtcjsb?=
 =?us-ascii?Q?X+vlusT9wg4iyoHkjeXg2zcgeBbzmwM0BIrtrOb9XJ0GKR6ePy64sP0gre1A?=
 =?us-ascii?Q?2PlqdyVUOsQ7bUGq05XyiB3CmwmI4ECA0ZD/sBlxW05xMIaIY4HubzF0sH94?=
 =?us-ascii?Q?yiWrHw3Y5dmzFvXZDyrmnd9YmRWAABbVU5GPMFqKNfVZFe7YIoyR6iFZI4xF?=
 =?us-ascii?Q?G/S+0vuTuZnTFPQGbaBUcF3N9uDyGXRg1NXQ1YfNLBb4/noBfWSflNn5a8nU?=
 =?us-ascii?Q?YJLDDu9vrMt1GLnxpWxxAD3naCy0laLmIh2SciBr4uObs5AEtuY7NyC+nMkm?=
 =?us-ascii?Q?/kfnpXli9spaFpxw1R5mYZ4V2Z8/uJHuVG3w5BBuYLtTn+CcEISmq3bDXTc8?=
 =?us-ascii?Q?cWHglg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6bee21-95df-4756-0eab-08dca5c5cba3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:33:32.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAIEEt3D3gEq35fuk2ZgGbvPCxBlmpz3CS8eIEOVtqGUw44eix99ml1qg8Gef6xpPmArx1F0UF/eRNoSSCAeQufG1QY6sS4+3MK0KHQI6V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7829

Add a long term latency test that is only running on physical targets.
The duration is set to 60 minutes for testing purposes.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .gitlab-ci.yml                  | 10 +++++++++-
 ci/xenomai_3_next_long_term.yml | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 ci/xenomai_3_next_long_term.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9edf635..803feaf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -23,7 +23,7 @@ stages:
     forward:
       pipeline_variables: true
   rules:
-    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}"'
+    - if: '$CI_PIPELINE_SOURCE == "push" && ($ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}")'
 
 
 stable/v3.0.x:
@@ -49,3 +49,11 @@ xenomai-3/next:
   trigger:
     include:
       - local: '/ci/xenomai_3_next.yml'
+
+xenomai-3/next-long-term:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_next_long_term.yml'
+  rules:
+  - if: $CI_PIPELINE_SOURCE == "schedule"
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
new file mode 100644
index 0000000..5fb0de7
--- /dev/null
+++ b/ci/xenomai_3_next_long_term.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Tobias Schaffner <tobias.schaffner@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_6_6_physical.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  XENOMAI_VERSION: "next"
+  LATEST_KERNEL_VERSION: "6.6"
+  TEST_RUNTIME_SECONDS: 3600
-- 
2.40.1

