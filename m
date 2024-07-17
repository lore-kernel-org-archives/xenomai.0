Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72514B07B
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212697; cv=fail; b=XK3zQSAdBGC+/F8dUWvs8tFoO8NTC+Tnr43bmt8NZ6MPPW5R9YI7OqtzB/guFLvvTenhpasaw7IZzhzHzLGIZ+c+d9e45wlkSq75cVobLvfpFj0FbH09q52lRVYvTy9Jq/4DltSGXLKS6XhhAMVe35Qkt4xhNO48F5H1Eqgt0w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212697; c=relaxed/simple;
	bh=Mdsi2lWt2ztC3p8l3eFXDnW1Qx63xQ7cbMaBvuHwdtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fuV691aonhFq21zetuvSkiS3i8x5hSCI94H65RqRrOdRQILyoVXKAgm5k1g17XQxttExx6YR/UTAy9w5r7YCCJxnt2c0M3A4Q9UJjXYQjP+OLXdXMgfumyeHY/8QAPrK19Kp6h7AaPJB7WHTVCUx9X3bulq2SFmp09em/qbK5Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ytsPxgkW; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ytsPxgkW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgrYSzdeEi2u/AFZVeYhAlwuYmPPKAMryohrc2L1azP4CQbZGjgbUjx+mklCGy/BlqdqUx4pfZvFjDl+3bhVYCu9F6WQtyviP2DltUSAosdeoL0VDeZzTVo8J/NBsha3S7mA487YgsTaAD4I3Y1C7+sdLRQyOCt5TzyZS1AZ+VYwfrnLEU41DurQMufBT8ZgzUdPbWF4F0lPVhVV9/QAGnukpfO/q8IO1p44LbDh3wreqmikiaABDDeJeWYH0FjFulm2nMaPD4/zxvgD8qm5rnFVq9kh/blo7IZgPkFe5Np+o/ukO6Co2nilmoR3fBU/8eww4TYibIwz0spkvJzWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylG7YpO1FfiPkN/vGrfBh4tfPIw7sQMr4m4inJ1EcWc=;
 b=B8Gaxxjm1c06uF7+rwcItMgkIBSIAzBFnfJGPrt7GetB2TFyLRuH9LmVryFsP5HBDSo58iGfuFMHA33hwEvpnMx9deX2wDKp/5+8bwXKgVSyKYKhVo3eCOTZIoRxSEpBDWwQhMqD1j/U36kAvTdhYTEeqCAf8Q8VPxAEFMt1Fgkwxg/vCT3MnmKgp9aPLow7bE9+jkZqaphS8OzGmLYQLWKj+w+U6BOCM8TG4MbPCwReRMkO1YGvgWLB8PzBJLy2QabXkuo+1F37XIvbVt5lppg8Uh/1Xpw+E5elaraB7u5vCoQGJlfn0IMLa1Xjo5BUrlvt6YcM5eGcK/UJaWABhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylG7YpO1FfiPkN/vGrfBh4tfPIw7sQMr4m4inJ1EcWc=;
 b=ytsPxgkWnFbgnlQzYcck2V9FHohX5TQtQ+s7D7iUWWAcyiRxygRmawh1gXmxIajx8oTPx1D2shlZt+GmVUeHwlZurvkicFrMjmbEeRRA5a8SJ9HldDP1ZADBSCePTg3gNAUeBHVel5v81yTr0b7gQRB4/lt+diLCNoi0ebPh6meinbHrdn+eRAjvz62dH+7B4nEywowCXHoNvFgcLDLvlljzpy4fFWt4wcw7vANEg5ovlgdpiw8OFV/M33RV3CxERf5UJoepIxxQ1VwpJxtyDTZ4rPZrdrLzxLVe8VlPdjGGpwAQvD62eGLlgX8VM4XH048doLuPwYqdGwB4xk943Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:38:08 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:38:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v3 5/5] ci: Add latency threshold to longterm tests
Date: Wed, 17 Jul 2024 12:37:48 +0200
Message-Id: <20240717103748.161788-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240717103748.161788-1-tobias.schaffner@siemens.com>
References: <20240717103748.161788-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 85811126-3e22-40ad-6896-08dca64c8c27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JimC6quyn98/UIU8Qa63u2AJj2AsG9wgtqwbCBAoPC1+IDtVwxCMflZyzWRx?=
 =?us-ascii?Q?nm58To7H+6Vh61zbkFveufDmIOTVrqcGxrTOWlSXGwjT0iTXnp6rn/ltqijF?=
 =?us-ascii?Q?10ud+GPJ4eIaKfkmMeIA3xXcEJNU63IFGXVyeFkeX8Od95e3jx7ND7zYghEK?=
 =?us-ascii?Q?Ofe+tIusvlw0BL1Tz5jJc5BIBwjaaQeZ1if+Aczlf5UYIdGC89ccYhpQKxYV?=
 =?us-ascii?Q?ADlGrbdAXWeg6TWvsnXTqXZuu4aRV7ZcC0PFXzWYHvMQ956iXdkI1H6ZqcUy?=
 =?us-ascii?Q?Dhu+rjmuNXWwZ/ehm8n7Sph2GFS0+meW1YUapPm94YOSpTYcFsR7TAHH3MDD?=
 =?us-ascii?Q?jACoXDo/KxqBlUprVcmGHv/9A04HFV4g3HhEVLGb/htR4BMBOIM0WRl5KBYj?=
 =?us-ascii?Q?kLB/H44Dh8YE1BY3PtYkpjsSXKQCVDiYJS4aP2OCTIZ9CK8Q+XMNovDoIRIp?=
 =?us-ascii?Q?Y25+aQNr6Kjf6XRwiafs5dItw7LZItWz6JTLQ3yG/77EzakihSjNRJwWuvQ9?=
 =?us-ascii?Q?spuZBnVO7nom3//GQzlScpap5EGVAwqXHSuYZktFK/cM0eKq2aniyL3T0KjO?=
 =?us-ascii?Q?mh2djBXHfDeq/3p0ajpUVTJgmpaOaQdAhSHYn3J77YRS9gQ3Q5GywltNS9ow?=
 =?us-ascii?Q?2cddHrO6WqAuNsTCWMTc4Jeg8rvUDkuov1rg+JP1A0DuKcyYHuaDdTU0Z3B4?=
 =?us-ascii?Q?Si5e42HY4r47RA73RYrqRG8JLvUdBmIa5Gd7lb5K2t4RFGo8WevDB7LnBJxV?=
 =?us-ascii?Q?8tBwjfhmSaeO4tes42SA6rqqKcS8+9b2i8BLwLrmGA/t+SaZbAr+inuspLBW?=
 =?us-ascii?Q?sEY7ao8Har0/5jLOILXwurNhDkoULOCgCQd1nq2hdOmktQ/k2nVDLIg+a6X9?=
 =?us-ascii?Q?wOlzplv6gGuFzgTplCjW3sAizeRSufwt5VcnplDJTg3uEllxImvVG9qLiVV3?=
 =?us-ascii?Q?Ffsalm//t2ALZyUDdvFYSRMMLXUNH+H2c+H+8vhpq/yqTq1llI1lvrqzPqaX?=
 =?us-ascii?Q?h/DraFAV0KI6aVC6C9UoL7m8pen/rQ1XzT6Om5u9CvzbBXQQmSIJ9mNo3Kwz?=
 =?us-ascii?Q?MMllAQx47SJLDjPGL/18lFQN72vHETsEkE8rImmSzPtVip/zuXTOsXUrmDDw?=
 =?us-ascii?Q?J3vJKnrRuxJgs2BJk/GxFT8K1QjG5plMkHeCCizHafjKRS69ugH7sXsga3f/?=
 =?us-ascii?Q?doR94kym8FugFZl9s/+cyQvmZFTg0L2KKKBVnubr/W/IHCIJdXZ74Vp95r8L?=
 =?us-ascii?Q?teuI5Dq3CMk0DeiS6PFdkw+V0UwPEPWUnnQ+QExdbMbAyc88AWkH0pSjuGm9?=
 =?us-ascii?Q?Piv9htll8esD9p4qmvZEg/t7li5KmjQnnvQeJPyvE1Z3uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9itI5R2YccvlKlTmYI8erXqz+Bw4RMTBVxH3rIMGI0H7rvNgQOZyNc9bCkNi?=
 =?us-ascii?Q?ZLhkWf8+WL01tYBRTnfM7lj5L/aCVAXLE646McaQ7VeLM0VkA0kSV9oVWCFZ?=
 =?us-ascii?Q?J+0gWXzANzr0/N5Vd/9eZXGT7LPkH1p/DK2PJJw6J8YXoszc+nENc64DmEyr?=
 =?us-ascii?Q?9F1XNmcMUYyrUhUJE0oPSZsx2WWYqpHbaDS8YLIysUhEjcL/J8vVh2ZR3MBa?=
 =?us-ascii?Q?6j9k2s2a+Yg+Gk/47varzGy2ZWTD1mlJ+2Hzm8UiEgDFJNBba7FX91YmDr9O?=
 =?us-ascii?Q?Nwegrz+uFaifpf/cZe4/GU4N75WGrDUq4B5Ta73UhXpJ2Uh1RjQEWMt+vkwo?=
 =?us-ascii?Q?EYwyn2P6ZFmI2C/CfXmAZ1vux9NvSK9f6d4VckC6kCspzyqrS7SXR87FuQzz?=
 =?us-ascii?Q?186Z8/lI2g5SfQOUGqhGQX94Kwmb+Mu3SiwvVOtAQKd8dl86syZy+4FGVenD?=
 =?us-ascii?Q?f4JozgzViTj6v+nkODLYu9UdbJ+LpRmuauwMUV8x64Yet9suSzxUMT3Z3OsQ?=
 =?us-ascii?Q?iLhga3LYZJZTBwnXuVDGPBvYYjzYiAlhfs3VjnG2cxanURKQMTyBtUV4/U5f?=
 =?us-ascii?Q?ziBnAI8utYi/Lxc5Qcvdyb5XbH1nZwgxUGVCeps3Cc4Hv7ZZ2oB23XnKJb9+?=
 =?us-ascii?Q?P9XvEMHdIwIhoyANdB1ovBWB/c4iyDtPR/DYivwZ/vTOqKhlpe2L30io0O60?=
 =?us-ascii?Q?S3vCCz6WPrQr/WuBsEHSXbzVPC92iQVB8lG6e6UzpZimKIHUXc1U+oKeSHNK?=
 =?us-ascii?Q?xoFarm0b2Q1wvJooUvq6qRvx6S4t9n+Rj5t1XaguxC5MTiE9RSNgK6vCPVSs?=
 =?us-ascii?Q?TDlmMhtJauRfQNVQlf89KmVcxoEHT7MY9DRrmES1KEdZWsnU4tEyr4folMXe?=
 =?us-ascii?Q?cBkv1mipbWULzc3vGty/iWz8eoZsvG6lWTz/ZUBXvyQi5doocTRXDsnOj5DP?=
 =?us-ascii?Q?3RAOBy49mSRu8HYqDo+Vnulntjg9k7eeGq1Bg5m/tU66MONsdfrBLgprMU3V?=
 =?us-ascii?Q?HxiBZTF9WXSfGHct8MsADLKWLs7b+Qo/iGOJHLvWLotl/6JjB4y1mmS6PLGh?=
 =?us-ascii?Q?//gvoo5Bdr7cmSvFoGMHgvrOpzBTmIXz7V2AbQPkIIYtjKV+Ck3hayKo3YBQ?=
 =?us-ascii?Q?jCj5MtOq41nmapX4FUm6RQ+zuIKnokgGowOaalpgsjOcv5jlgQ8alc2HOMjw?=
 =?us-ascii?Q?jbpaZJOqCyh49KxTWgOvhl6rWqvrVV4cQ3J4i+CXUe0TXMTsEZJprqK+Idd1?=
 =?us-ascii?Q?HsvLl00+OLv52Ls3VsBhzFfrNBZzniEiZV1iVsZ9rmkZhNxFm+10uEZtTF87?=
 =?us-ascii?Q?yQAV7sJ1UTHZ4/1bO9RngG7yvTgwRF1N2/OgZN6Xab+SkYtSgMCMqN2pRVev?=
 =?us-ascii?Q?3rdpASyC7TTdTp5qOsOHRbs9VtRgmBdUs1NWxIT2YW5b78xHx+r4PInXySdx?=
 =?us-ascii?Q?urm+ckqUEYREGFqcLicfcPrp5EJM87xY4GtJJd3n/EZazOI3L/vwn9hGARNk?=
 =?us-ascii?Q?HstBQDQ0EWBeD2n0XAxGT/rxZbtfNp5Lm60Kz5hVlPpcYBoyg8YqroWPaloZ?=
 =?us-ascii?Q?OJDXjliw62PxjrJgOhZQQqw0lwMFF4GuWoABQM7N/YqFcEvhvycjUc/GyYBp?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85811126-3e22-40ad-6896-08dca64c8c27
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:38:07.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lntex5TqbfItxUHD0/z0+FIA/qhTcJ6FNijY8we+Xhqir9vguHK319yVTsHs1uW9f6WZD6jI9yrUBXREgkoTJf6u5mB39wrJrN9OoEmYEc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

Add a latency threshold option in longterm tests to guarantee a
worst case latency of 150us. Fail if this latency is exceeded.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml           | 1 +
 ci/kernel_6_6_physical.yml      | 2 ++
 ci/xenomai_3_next_long_term.yml | 1 +
 3 files changed, 4 insertions(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 29960b3..bc9d525 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -22,6 +22,7 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   TEST_RUNTIME_SECONDS: 300
+  TEST_MAXIMUM_LATENCY: 0
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
 
 default:
diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
index 95fc4f2..e57eea0 100644
--- a/ci/kernel_6_6_physical.yml
+++ b/ci/kernel_6_6_physical.yml
@@ -21,6 +21,7 @@ lava-test-6.6:rpi4:
   extends: .lava-test:rpi4
   variables:
     KERNEL_VERSION: "6.6"
+    TEST_MAXIMUM_LATENCY: 150
 
 build-6.6:beagle-bone-black:
   extends: .build:beagle-bone-black
@@ -34,3 +35,4 @@ lava-test-6.6:beagle-bone-black:
   extends: .lava-test:beagle-bone-black
   variables:
     KERNEL_VERSION: "6.6"
+    TEST_MAXIMUM_LATENCY: 150
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index 5fb0de7..e3740f5 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -18,3 +18,4 @@ variables:
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.6"
   TEST_RUNTIME_SECONDS: 3600
+  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"
-- 
2.40.1

