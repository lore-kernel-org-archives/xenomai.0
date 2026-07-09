Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A061349CE6
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607736; cv=fail; b=T3Nl7dghbpv97KM1IzRkwLgFOAOTgKmWyBC9i6HX5MRR6VExWWOAeaOmyOOM4uI1DDSfBF8lCuQFEXi74uWmJltWXcNkmbtLaWSexbknNGbAxLDFvCoM91zXcnxxtf3+ekEbZ8NfxWLvdgOOV+7YztfM8d7MF8HYUjLgmRWj6xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607736; c=relaxed/simple;
	bh=LpyGGyWoDfrus3glATc/eVQ/VUA3NziPclJlp2pp3o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=metOK0kn5PadGuLZcISYDm3zcwKxRlRArMevVzPW4nHB6NdfWwnvDAXm8Nsz654dJClraiPK6Dzx4e1vWxy2JiwqK930G1dmdAh7+r9KSKlbRptV7JCQmSHkoQUAQ7T1RgaiFyrvVvI+VPCKxJZ8FSezsi9wwK+VGsaoYLf4INs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VBy4UJHs; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VBy4UJHs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5QSuPVc0ECwyUmWYjWO41BIZ/6L9OIqbmZxGvwwmwOLOzMm002AgTU+sNWxQ+jDQqKsmkjn+B9aGoWjS4cC7Q6nh4yQFVfWLZKJURy7/pXfGN9GcTfW+0DZ729XYsZdeUZ2G4SNefXewN67YwKnvvAmm81nruf5bFHM0A1a+DzRw8E9EjOvAGCivMHC8V1PXAkmF+8ywjy6SXhP0y5e0n1xvin1mmd623BKs9p5CztJ5HyQHMLbs/h5AIfXiQqfoejaO4LNgas4Gu5k+wlg+xiubzPIl8KjNPMYzPejU+PmcLjnTDOVlIXajm/Ivd7D15V/d+iIxvYzHDrRZqWoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCozJmZ6hwlZT2s3IOa5xGwC3bBFRYf9oZiE7TzXdaI=;
 b=GSDe2t7bhQrzaflmzzyFqNR/UGuziB/lE7e3M4lDvzyWtKMkugw8vsTMZYCYak3LNup0kWNHyY5/jvjy7EjTrL2d776hkLro/N4tsqRuoNR8og5iP+P2H4LJsDSoJaIDrUKRVo9LQTFOdODOzEIuOOPY+RBDurn6ZwasyRpGi+X1QJ/ZaCvRluf5XvRM/rSAOSZpzjphebt27seDu2g4LrYZA8zzuXRK504u6kEcLfNfOfGlIuL/zieJRh5cqYTVUCr9okbALnUMAwyrstZAfKN7qaWc6rtb5Cmwii1FtvCUHFgVszgnSNEgF5L5wjQwtqt6p60ZcAHd+rSDqGiJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCozJmZ6hwlZT2s3IOa5xGwC3bBFRYf9oZiE7TzXdaI=;
 b=VBy4UJHs6N4ILRawM+u778qYQ3NZU2RsRfpEmc/SM1XIALrHVXRe0WO+fUgCbgt1OjgfCKnbTlgRHvFCnID5eERzQ7nc5Pkp4T+j+qBugTwVC+ofB2SBmfgPfqpM0a+/7NQ7RRiUGEssSsj5Ll6tVgR1elDIvTM3gtGE4J4EhNixqnsSJv+kp1seupo1Khcq9CnPjX5LRfGjjyqTtpCKcZh94xa5F3l1tIpRx9Z5yet5BHsnRQGWLBPnoXovuPdMOQX2kxsWu47Bbrwcnh3fzCj+OAtMevEoLIj0U8j1nCWXHAQc0hXfF+h9YMTDoDdoG14APxMXVvl+0JBfGU5Sig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB8222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:35:27 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:35:27 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v2 4/4] tests: Add latmus wrapper script for evl-test integration
Date: Thu,  9 Jul 2026 16:35:16 +0200
Message-ID: <20260709143516.395611-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709143516.395611-1-tobias.schaffner@siemens.com>
References: <20260709143516.395611-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e92a21-58ab-477b-26f5-08deddc75197
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|6133799003|22082099003|18002099003|55112099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	8nQRLuwZCeaznz5qMXvfJd1tqJQ2iXvSZLZsZX3kPZfm/iosPiM23P3qH3QTH60J4cQXl2vgNcrjbC2rF7P7l5VchygA0iIi4rlZ+p0Qd/yN/o64WGXzrk/gkfgm37Lhmb+MpiciCP0s46nFVZ9O743+GP2Htnmd7gJY3HoIw7lmlL2bgzrbl2+vTX6XRW4gNcRzQi6MaNXDF+aZUgWLv80/Q61YuAUvn8UHUnkIewlFUk5Ib+S0vO4V/86717yh2x4aT6yDKCe8EWt6x3D2Lb52adTgZyMygYfUNRy4dEnPmJzqh/PYDRI4BuO/s69ddCBLdoFEQ9TQ/Imq/yt45+Sj+ezvoSaTuCK657uwzO7A9a7jGYavc1ngzF09u0OBYfV+DdVTGKyFv/PyYI53pgSAmykddwoyoXG8sAGJ1+KwtFkzNWGEh01pW9V5k/wYV93IUFc7BR0sayIFh/WsIqd2T2dsDnUAJn7sp+lHvfhGP7nFCj1uG786LPVsxNFoQPzim+4zIOSEVn4BoF/p+bniliL5A/W6WyimNkKqKqgEv9E7fo0t1KPCfwoPiDIKPgWRBcES8QHX6E25jNznzc8UCHNeIva4zyI9Zr+EhMxPvZaIAs0+2cMYbhjmVQMPZcpytrN+BzkKyuvRvx9WX7IuAsEqicEnHcGKsBY2WME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(55112099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbuRasYZwJxUa9wzcjeKcpWluQGlM98xeLljvzboqXnwN+ZwVozDnMzYOIva?=
 =?us-ascii?Q?lAe/ezHDPlEH2X/Q+ycIviVJfGEHh++flVQWi+jbVNDXfSn3a2+GF7GvjmXr?=
 =?us-ascii?Q?WS1vCMVxDAUaB5c/q6wJOL7mNgbdsi5boNtmL40jTGm2jVBXR6e8qRmF0QFH?=
 =?us-ascii?Q?vJ2MJToWLLyMAmpJ0NmkUXUjDVKtCtRHdi/yjQA69iAjfBd3KLznWAkUIMdw?=
 =?us-ascii?Q?jjOCjYy8NAqYfYD8NyKuOGUTu2PGzZsDKMa5L/ZLEYvUHqvKWAxNZIqSXUPo?=
 =?us-ascii?Q?eO8HMwk8kNLrlxwURqEAp71Ax1lQan6LMu9pNKy1ijnR+M/uyDFdgck/9R5M?=
 =?us-ascii?Q?FncBT/ne3j55V6J6EWlnd/PGy+PsVVDNTi70qbkTRy6To1K4DnT24KWNEeVp?=
 =?us-ascii?Q?HQYoRpL10+nx1o3Z79c3sOO3BmnktKacyo2lu8KZnJleRecdEhNCidNw5Hb1?=
 =?us-ascii?Q?kEyt+JNzwsfuEBW9h6v9e/nOe+72jpQFC0oRC15Fmr+lfFFa+Rn/IMWxbFzB?=
 =?us-ascii?Q?nTFMZtidx22JHx9Dqs3Dm0h+i0AlVxmDveJ7hTTpHzSk6VGK4floIZKNHAgB?=
 =?us-ascii?Q?Xk1cI6Yt9AysLA/iEiGyrexjoeq6uDKV4G9YUUbqZp+z6/GghbBgzN61OXGI?=
 =?us-ascii?Q?ynzp8qqTV6BCFU9LcbTNaqAto+oSDrzK/zmynftMd1ORtEpfcjIMtLjgz9KL?=
 =?us-ascii?Q?LWH0VdKalUHCWjcZV93kON3A+dUvxcNZsYHvTaCCe12NDrbxOf27JSWc0/8r?=
 =?us-ascii?Q?vvi6LoMglqhsw4fmPkWOy4laSKMPb54kzGE3SZe/+BaD2oM6wB+td7BMS3SG?=
 =?us-ascii?Q?0+0nwbMJuojLYNl0p4Ax+S5IIBlzyQsiXXc09aUy/H8CVafbyq1KD4Dy6PJr?=
 =?us-ascii?Q?58xu6avcTkK88jHVoAQrYToU/meYLKt9c4qkhmEVbqvki4wDIHp0WRzhbOOP?=
 =?us-ascii?Q?7drwB97Vr97mnZYQQiSbj7qqHiLCYfSxck1bOVi3eFyYJw15JXCkiwdtCo+U?=
 =?us-ascii?Q?LtAPpeJzkQ3gDSkicZQ99GLUm3dLAkjFcHT8FH2tpgv8JzY7AvMJUSXiG3hq?=
 =?us-ascii?Q?TY5O4uB1FrykVCUwV1ciSsGkz//zpbqrM/vanW6/+q6sJi830lUgVupRZ1QK?=
 =?us-ascii?Q?dQm0yUM0AGzNTv+TILqN+UPCcNpvBY14uugzzPc8EWz8/wCsew2tbW560UDB?=
 =?us-ascii?Q?a3Ne/OZxB44bNPLw5O/k9GDuJ+mU9CpZCvrtKy+PQo5gvEBBnTgGG2QUM7jR?=
 =?us-ascii?Q?YA3BiSwjP2dwRudnwyZqujEyQCoA0J6f+hdeqP2ns85GdDf3U7uceNTVmYEh?=
 =?us-ascii?Q?JhDCVVnygm/poMUD7+hEVGzkuCSSimVS822G+tQbNhLrI+mS+/I0zKw9fYke?=
 =?us-ascii?Q?yGqCOzwhy+d+pkFiDwcMDZeU35PDf3u07Jc7qA0LCPm04l1QWiDqpgd6aArk?=
 =?us-ascii?Q?ZoK/yBZ/K39mYizlbYAgpWDtb3xdP8BxUINF3LWOypWKyz67pTyfkm2456j5?=
 =?us-ascii?Q?BM2qoHwxMb0+5wrwNZWJAvH81YiAA2cFEET7iZtTbax0Lk0BJiDyI4HkAnb5?=
 =?us-ascii?Q?u+Nzbpd2cKimEQxzC7dXK8/N0Gdbpoyl1kiZ3EQUed0xNss7e1mPXHxF5124?=
 =?us-ascii?Q?FhIdwBdtMR7bbuIIKrIxbbxDuEudqrRGZ1iOUpTAs2Mq0RSzKD2PhD6gnxtF?=
 =?us-ascii?Q?vISiAyqVGCOGMvCTNBWhNpgkvbAy/xU1KKKqB0ffuiyTWCd2ETrWNrSFlQkP?=
 =?us-ascii?Q?EG1tdyBQBaNtOAjxiV22kVpV9PFtZMI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e92a21-58ab-477b-26f5-08deddc75197
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:35:27.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRvgV+GRHUBKb9MXzT4Jy83zTcsOynPvkQ3x6YRqgHnHjxjofgtff984km5CFGWmhE9Q/xZlEhH0ymQ0EY1hWAUXlkYtFXk/EBdbIUmWRhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8222

Introduce a shell script wrapper that allows to invoke latmus as a
test binary like any other test:

The wrapper defaults to a 10-second timeout and no stdout if called
without arguments. If called with arguments latmus behaves like
directly called.

  evl test latmus            # runs with -T 10
  evl test latmus -- -A 150  # passes custom latmus arguments

This also allows to run latmus with the --stress-cmd option provided
by evl test:

  evl test --stress-cmd "stress-ng --cpu 1" latmus -- -T 60 -A 150

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/latmus      | 16 ++++++++++++++++
 tests/meson.build | 11 +++++++++++
 2 files changed, 27 insertions(+)
 create mode 100755 tests/latmus

diff --git a/tests/latmus b/tests/latmus
new file mode 100755
index 0000000..c9cf135
--- /dev/null
+++ b/tests/latmus
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+#
+# Wrapper for latmus test integration with evl-test.
+# Allows invoking latmus through the test suite with:
+#   evl test latmus -- -A 150
+#   evl test latmus -- -T 60
+#   evl test latmus
+#
+# Defaults to a 10-second dropping stdout if run if no arguments are provided.
+
+if [ $# -eq 0 ]; then
+    exec latmus -T 10 >/dev/null
+else
+    exec latmus "$@"
+fi
diff --git a/tests/meson.build b/tests/meson.build
index da2cfe9..d90cbdd 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -119,4 +119,15 @@ foreach t : test_programs_with_atomic
 )
 endforeach
 
+test_scripts = [
+    'latmus',
+]
+
+foreach t : test_scripts
+    install_data(t,
+        install_dir : libexec_evl + '/tests',
+        install_mode : 'rwxr-xr-x'
+    )
+endforeach
+
 subdir('compile-tests')
-- 
2.43.0

