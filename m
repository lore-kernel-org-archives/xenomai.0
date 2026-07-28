Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD044C50D
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249589; cv=fail; b=fnb67fCc2+mM2pptqjOW/uUvDPZphVieD67xJWjIQWPOwxgy/QR72Hhg3ase77j23TxXr3YhLG4LBe6DYtNkS8Z4ARnSMjLwo1ahMqsVDVGyqCY8R/giX5insQsNYDJ7jAWVBX5cUcLiitmWrep8gVi98KS/xibtjOZ++8DQfFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249589; c=relaxed/simple;
	bh=otv58j15F8tDBJMd2WdhelQWGt7yhwxPrRa1JemAlsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H09SdcD9voqflPG5XFsi6Y7MzE8ZaNa/aBTf3FU5pIuj3LWRYBy/jGKhP0GmStreGrpmwj7FYPqaPzaXjK4g9mNAQV3zRXN0XEEcRiQQq4a//uLix3L5z0E9x1iZrxyrFr5y1woLD+mn9lp1sJ4t5XO8Ee9sq6B1GjWyO52lxAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=azkRBdiM; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="azkRBdiM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuk6BazWYY8+PeE5iqK3mL0/JHJurUwiW0uXH9VvmT9M/iD18z+WHeyQ3uhgDGJGC9HUF9AsDxvKLzqff5v/y4pGetOUCRr/QjmemjhKrNh+UhfQTMELC1nYc0BlJzlVTC3SITG18Qvb5W1I24riKPJdgOL54hCD0w22RN2jhW9QQIJwOi/WbRg0hEoSMPIJ96tMNw2TCl6P76WhSdCHSxYPHqdiEboEg/eoBsO7YiyXNMT3jmmxz98OXraBjDNC1NsSFWjY/G0Tb8ypR+WubvMij+kcL+jk+kSUY6h3AQrM6dAUyaFLXkPusKoc2XeeuTdVZkJQ1A7H0TSsemPWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyKXE7ZbNF4k2Vs0vzSU7p7dqyxuuWRBtWz52A8qQZA=;
 b=cdP0Qq4Sv8mJiUkcP7L2NT6d25X3TGLz8k2XPynCjgKKK4ygcr5N6fDuk2spgSy/REkBpmW1WE/fTa88xnI1F+GJ5dhYIQHm2VTPdOSV/z3VpEVlrTxQ+GI+Wc0IPkgJP/R+nlo8fcZWf5QYbk6hK9qSuYG0THZTgfZMkOlhar/5sg3UojV8jGplKo2ciRMnqIySZxszgbR3PjQmA0f9HNy5o3i7RoDMNYqAgzmZeJgYeMVeyx1XC1bV+clvg02oLZu9Q4lSNHKKy5VNT6TKgkrmJqSKaw/N8bRO+JTs70f+PSnp9JlAKIpu6Xmaq+jnLZoH+yI/JEGdyeMuHGlPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyKXE7ZbNF4k2Vs0vzSU7p7dqyxuuWRBtWz52A8qQZA=;
 b=azkRBdiMfMXC9KPTywW/6C8cAjC0Z+riMCBsaz/Op/Rz9LThxwdrq+CGDGILrAN5UK8EeYkAaMxRi+HK/Z0HLZtgjoTozSEcpL/POTrfS19rmcc39eD9728wgLdEbskTN/94ufL+4lkzT69QsHEFtktpmT7XdP14/tN1ymOt/8EHloXj4hcaPHpngObmhKwN4Cg/2rOGvPBNEEMowCQ6b+NjM5TYAARAw4kWRN2sS+NLybt620e9KQp+Bn25cXgY1bb1kZNtovdJIlEQI2nXf3Jy+YvRKRH1QSHiL1B8YY1/XAwQWduQ7EknYhEndByIYl6Ex1UOIeIHbp/D0FULAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB5939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 14:39:41 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:39:41 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 1/3] ci: use stress-ng to stress EVL tests
Date: Tue, 28 Jul 2026 16:39:30 +0200
Message-ID: <20260728143932.2747505-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
References: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: e2038a21-d1f0-494e-71cd-08deecb60ec3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	xdZtAGNzUmJv0REuBR2GSUF36HONoQswmQUVd9JNMrPz60lhGqLV96prHADwyF/f5VERCVRoa/bxLY1rxqD3AkM2/JSSrRZ/RiYq3F0DgID7gh8oZn+5dxw8kl1lOYF5KSo4a+jRaMuSu8gV9I6dMb2Oeo0ewBOkE3hRkt8196gEzkqAdrwwEjtvo0kpY050VrzNazIbVNHIDKr23QI+Cmp4oVkirOqP32eeL7+N8/ge73qYDrSRMRY568Pb+5Rp3YZf2IjWcfLOKjLXBKw299K6/wBDC9wuwa7VizEjUVd9f9so2hInSGx6A74XmpuRurCulSnRro0VuYC6jp2yuSHe8IemMmLx9neB3jrv/USNBDr1k2z45PrDehFoDmLFzxsqpYV73v+BzPYcDjOo1N9L8F3fiLkyCMgfsrZh14GieJVLUeGAJvAlo3DnJppHs1yT/PIzwZQB/AzIKWHC8mrR7oVTmfM1GWwF3fBw0eTs+fO1UuZ2oUPlYhleNUepbU/EutDMPLHLJ9tpww+F8TbZAWPzOg/lghRqqV+5DUmEzTedZ25EO57ZdWi0s5k0WZaij4xiyjhB9l9rTVOUSGiWGgRAfMMi4EDSB/GzPtmIKGSP4EgEjOThxb8LWt0HThJBSKFAxhTNXWIfq8LB7Ad9UGFYUVb/K2JjBYVYh58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNlfaLUqwnkPlTrqp6UcQNbup6q93xjVc6GWL0+7Ge7i6KhDtsteknHuDPU7?=
 =?us-ascii?Q?lc7xXLmSqBdAzCYtkFBEHqaNh/wKBXsdPCKJSj1WjusARXYN3BhaD6ffs4bP?=
 =?us-ascii?Q?Qr0/PF3oCmXVXHPSjjR4Gq0OWsLJ9KkkXMozOdfVweMQ6xBnPi1gTPiPSJXP?=
 =?us-ascii?Q?87if9rkXFArM6Azg2kee5jyLP3u92oqPbfNkxwGRmNkk1aIMnGSlQQctmMP2?=
 =?us-ascii?Q?unXa7bR0x1QgoLzw3kdjJD2OTnSjlnfcawpn7vVlBI1bKsgG4+ROgJBJXw3b?=
 =?us-ascii?Q?0+FnZkH2ot1IdP7FYMFmfV1Bo8W5ATmIRhequJNPapshTfQjUTfZFZHkb6u7?=
 =?us-ascii?Q?qkhiZDIAEeiace/SSuF1nevcDUr8G5WMg7eBddRxJgflkLT4YzMNV/JSK07E?=
 =?us-ascii?Q?PVluWq/Nvqn/RnZRAdMerZykQO74RNZaUHK+fW7fPPWSuNVD9q5Q+e5PUeZ0?=
 =?us-ascii?Q?aGej4xJwgiQLcPxqXQWARYH1sEsdoEqpkdCRmY5QZZMRwLsjIPdALCSX3mQL?=
 =?us-ascii?Q?iJViCYwwlJPz2lpcr6H3oqODmjQ/8RrtrZas7DQ5T1dPCLz9BSBIWkyIEr7v?=
 =?us-ascii?Q?2+LB8hYgXk8nsj8CPXG3pKFN/vHKceCWPki9ynWtbmIiRJRg3EqIxW3mlk9W?=
 =?us-ascii?Q?JzkYXKhyiFNbbFnqls4tAeCHQ6KCstDv/8eAFF3m5U3XFqmdxGTcwm+r60O3?=
 =?us-ascii?Q?PZ7f/ymdmQBKW1zLSmbtaMNy+CnWqdbtBhSQMlEsITQUquIfPn1aI7lHBoAp?=
 =?us-ascii?Q?YV2ngQQp9yymZZvJCumJRn8triD69qJ/0/+GwgvjdIyvOwh2/BOBCoRqK/08?=
 =?us-ascii?Q?TKyMjwSytmOr1UUhdWDZHsS+Vxunatgla/91lACl++fun6mOIhSviL3wdNq/?=
 =?us-ascii?Q?ej9hy7SfpXk0SeBus3dJW2l1NCQRtlnua44nT7PFNgpdbK+UGCE3CzCnyKDc?=
 =?us-ascii?Q?4RJEYMFNb+ofSRmh7RcMCt1Zard9tSrZaEzCLgn9zLacuk85RK9SsQmfitUU?=
 =?us-ascii?Q?tVSBWCZN55eEOD61eB8Zl/VnCTQTU+0Sv99NvASR1Hlbt1V0VAqB8js+X/uE?=
 =?us-ascii?Q?hcP4+seJRYuCe/NirqWZgrxsZ+BD1crHvTDZ8zSMzzHNV+FidCMWK55hHL5K?=
 =?us-ascii?Q?LKexfMkGOj/Z6d254D4fWPhJjsk4yMrI5s0D0lOmarYWl3e5TEZofazH5At4?=
 =?us-ascii?Q?AR96G82ZDHMtd3BZUSfJG3kQ9SMxY3tWcK2BhLnuvi2iXsQGwuDMnhb/REkB?=
 =?us-ascii?Q?UqUZN38C1+NHTOUu3tTqLi5Tuz7DwUSCuSpAObSYhXiUsDuYG3IHoDv6LGJx?=
 =?us-ascii?Q?sZwCI1qPp+90+K1grXHV6ksixZ8KdBTp1+pNYzUxUAarmzFnuozLtNmx1W7F?=
 =?us-ascii?Q?Q/lEByAWnckLSOlV8fiVMxr115eL6CsgJ9JbNEuvfiYWxrgbA/J+g1spqR2P?=
 =?us-ascii?Q?7sKfWXmriveP0K6j9yKY734VNI+JeTWi6u52EEnl+aJuqjUh0hFT0+JwjXWk?=
 =?us-ascii?Q?nCJIY/Juxh7GSgBZxhbaI1FrxyG4NUOr0Z56a88FuBRV+0kCmtkwfD44pYYY?=
 =?us-ascii?Q?0QfIVFOMaej/lxr+s+xKtX/p3jvAv9RuJ9AVwbuTu3WjM8HCH2pOz1oUV0eY?=
 =?us-ascii?Q?CIiyNd3Wia7rXoHTuUr4v/QNpWFx1gYZHg/+PrTqfMfGYN6xXClen+SxD5MT?=
 =?us-ascii?Q?KCIrrxNxjAsbOhVCTqFBq6+GZ5wRlCqaQ+TdAOOJgQOWnXSJnIUu7VJSxZBw?=
 =?us-ascii?Q?nGDbCKKMbADEGvlouc4DzW8HoBW/5rA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2038a21-d1f0-494e-71cd-08deecb60ec3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:39:41.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqVEblelxU3Q/v4KQ1FmVF1evHtBzWCs6kimfJKH/mZ8cBSrA+kIw1v4BJxuXGd2b0Tce0YNIsxA31Jic6HKHfMGawCN8B13DPUb9brJg9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5939

Use stress-ng to apply CPU, virtual memory, FPU register, and procfs load
during EVL tests, mimicking the stressors used in Xenomai 3.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml                        | 2 ++
 ci/xenomai_4_evl.yml                             | 2 +-
 ci/xenomai_4_next.yml                            | 2 +-
 recipes-xenomai/libevl/files/debian/control.tmpl | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index 0540628..a3359bb 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -25,6 +25,8 @@ variables:
   ADDITIONAL_TEST_TIMEOUT_MINUTES: 10
   TEST_MAXIMUM_LATENCY: 0
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
+  EVL_STRESS_COMMAND: stress-ng --cpu 1 --vm 1 --vm-bytes 64M --fp 1 --procfs 1
+  EVL_TEST_COMMAND: evl test --stress-cmd "${EVL_STRESS_COMMAND}" -k $(evl test -l | grep -Ev "${EVL_TESTS_SKIP_PATTERN}")
   SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
   SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
   SSTATE_MAX_AGE: 14d
diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
index 283a1fd..c6a92b8 100644
--- a/ci/xenomai_4_evl.yml
+++ b/ci/xenomai_4_evl.yml
@@ -29,4 +29,4 @@ variables:
   XENOMAI_VERSION: "4-next"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
-  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
+  TEST_COMMAND: "${EVL_TEST_COMMAND}"
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 6ef4b6a..7ecfbb5 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -21,4 +21,4 @@ variables:
   KERNEL_VERSION_WITH_QEMU: "head"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
-  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
+  TEST_COMMAND: "${EVL_TEST_COMMAND}"
diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
index 93caffe..2c90442 100644
--- a/recipes-xenomai/libevl/files/debian/control.tmpl
+++ b/recipes-xenomai/libevl/files/debian/control.tmpl
@@ -13,4 +13,4 @@ Depends: ${shlibs:Depends}
 Package: libevl-test
 Architecture: ${DISTRO_ARCH}
 Description: ${DESCRIPTION} - test suite
-Depends: libevl, gdb, ${shlibs:Depends}
+Depends: libevl, gdb, stress-ng, ${shlibs:Depends}
-- 
2.43.0

