Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669C3D1CA0
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081786; cv=fail; b=fPzrmtRo13YnqPaoLeRV3xR0d1EaKPe8sZDvBl5UdF6XoXuMZe/lURgiLhRflvFa6OiYgbJYF42IAWDV13bcFWDNNUEpdFdVVWBxsXIpVS80/P/6s+/JlnUSojfL6EPSOeXsswuAJNkp4w3plivQHiyY6iV7MDsPEgCJmBlIo0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081786; c=relaxed/simple;
	bh=8r3gC8DWCivjOwihUrcWSiNX++d4//uUpUlBxMi/O7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hafXXE7ARzQLVC875CCOo4V6nS8n1N3otdt4IhRnPBnlwRFTJKayfIOFK6dsbWwQpDF90EjFkfYoeB3Vh2r5+/T3jbxerp6w9Ibwl4D0kXOlnY61+kmCwl58VUAWVW2W1EGt/pYE4ZwO0uKcZr8+cm0GnxkkUWB/l3KaE2H1YpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=q0L96PGI; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="q0L96PGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ksxaw4WFj5XhfssC7U6j05hX9n3mLUp9FfBKcpNCjSlerXc/rms/x5C5LUDeui1qGHAnm/x+vRVifQikWcuY3HbaBAr0E1LYoKTGgmgGP4yWRsGNAYF0A45djRl+olZXue+oPnsZQkZypkNeNqFYwRgg1T09+vneKfEp+LTEY/peKKyWuGciO98Yj7HI3fcGy18onuGJ/nQGJ2qm23bz3BwbqXOtflKOS/biT56sCbIOcVFJJL6kCyfXfDNDeT4/i4PEM8MWBNpNp6NdElyWZtzFn1PUtu/Xf8vpBYmPG3DsN/lTlr/HJKvtngrf01BuJbkq1cSMD5bF55fe8md5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IviPY2679t1/EObwHf83AykQR0/7OVlr+6WHKrj68U=;
 b=GKqAC0X4XhT6S6HVXMlnTCu17dAs3G7rxaXcFFTO6EG3GbaB+YrK8yMKCVIlYNB/bLhuFJ1IqIyqHg0AJeU5b7KJSC+n7oY/4hia6mqSxefROB2oNYMWGHT9GrcGUMt39rD/Wv88y6VlPeqPRMuVX0ZsDBiOwrY3NSLvW3/6tsCiFq9YuAZ22C5c/JfdHwlt3fdkmx6PaCJGDNt2z+HEOdmHGNX6I8hcvETsMxwA0uTetZHWBj4VkA+kQtuYCJn2gdl3jzfe0Q/Qr1hO/UkwDT5zzLBwgv6iJKQ+5ezH66pPlcdtxAx+pPBeu9UCsA1qtj3W/c3bSxAvMhxdlc+xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IviPY2679t1/EObwHf83AykQR0/7OVlr+6WHKrj68U=;
 b=q0L96PGIINwbaCY1oldr2yymXt+Tb9pc49dTnGZctlDvpjGxTqPOSpb6wcrcdlcdPbd3wy178dfr4lLCN+kU/uybWD6il83gfxpaKxczVJFwFNgBefTwcKB0ZXt99ILxO1p/dqN76kQM3ndzA/0Mgia/2IKSeK/gBZoIDJdUMzX5qQLo/h9RBseU1PM5odhokg2XELPNcGkK6Z2h9ttykatJKKMiQSsGLhVgh6WoOKAch4VY5B2byqKyXI/wsuNRqg25cQHXWEbYckUELcoQbiGwRz4tFgT2xk0EImFQVRtzVfWYeqIgFK4HmQvaVs8c7UBqWAXwRuWTj0Pdl4DYLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PR3PR10MB4093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:29:35 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:29:35 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl 3/4] evl-test: improve help message with detailed usage information
Date: Fri,  3 Jul 2026 14:29:23 +0200
Message-ID: <20260703122924.30212-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703122924.30212-1-tobias.schaffner@siemens.com>
References: <20260703122924.30212-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PR3PR10MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8586652f-b2df-497c-cf0e-08ded8febe06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|11063799006|56012099006|3023799007|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cn1GjivBp/IPRGGXQc3p35XX0qOx9N1k33T7Cer9/k6VOWTh9qUOVxADgNLqiKGXCcukujd5FeC5M0lwbS4uAs/PdmqdE9Q86lRC3FSa7RGNJqf1FeMuaLZElbYQSwLNzy7ld4EtRAJIHQVEpVh8AkAPh1HbBmc4gNM1zZCSgprDZ2YWqhZYIHMc2z55IAQdBQWn/zpL/cc0DXVtWgH7LDg5qNNk1+LsxONslmGiNMlFfHxKKEBYaa2ciXWxK1F98crFzYbG+5SB7FS0HsFaZ5Hoyront9fHAFKYpBDc2JVEuRV1cbSZAegPMzollxttM1KKHK81j1+D6YHcLQ88vZkT4qYgXQQTclbiZiGtA3pNpuARL/FaWq/2yO855WlBMi1kOXVDa0oThNGoPnGe+HYdGPE2cfmI0qtkssNm600L5O4mzvOxUdBre5dvF9StkiA2tM1864/m7ePU7yVUZu2VQdkFYhZzfgDAKjEl/ZzyXM80o3qz2+IuUCqogBxYvEZwvlPuL/yPREhwkKEPN6S98ywBxQP3auLRNyAqDy3kq9z/WXhs2oCGuqjJ3/cGvBLORcv0IN74WX7xLHbpWXhl4rRwmYJ2AKrVv2VXYiRjzpgj2LxfOIdtfY7j5FGnyj7PCxcKFGDeQgpdyWltLbNphH7mexPRdKmZIIh/VnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(11063799006)(56012099006)(3023799007)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QzoxkD2b3ytqGPjFpb/QNwaxLNYYJo3ZhcJieymEBcNLRRRCUrxZIksVTZJT?=
 =?us-ascii?Q?1TcIscl4dkyRHm9hPS01CyZpOI5qLyIiDDuWviYQpEf5w5vdYPRiVA63TRsO?=
 =?us-ascii?Q?PkBv/wuEiDHn55m9ib8M7YacsWk5KMIhS2XdwAGqPcCv56Qd/KQ0Bj2FAR8g?=
 =?us-ascii?Q?JWpy4R7g3GZOWUsLNi+sMbPbPf5zaJtJtaVraFgCai+Fz/x1LDmaulBD3jkn?=
 =?us-ascii?Q?uutskTmJQZW/uu7dsZGAOYCbAV1R2DVIHV7eXW7KMb8iPb3Xcs0kgbV4hAl1?=
 =?us-ascii?Q?rWQgTgzpy2WMr5ugNrM3dXlmqE8XL6GycStEDwPo0vsZe10/cNw5n9FbnpF0?=
 =?us-ascii?Q?MNqlHCgzlAL5Ufi8bbqyZV1uRiB5lXw/TkcicWQYqctXWQacUxfOLbTpOIml?=
 =?us-ascii?Q?RaoD0gQpCeJvazjzaaFD7R4d1AOColFSeMBGJhYvxelK0voqHn5sBlSyxbC5?=
 =?us-ascii?Q?yLu6CAmnt+lNVrZg8DD4ektGWMxFpRfpY1XWnGlLgB9MBUrrq7OasNd7BvpJ?=
 =?us-ascii?Q?bWy2ZL7iVC8AsIbARBYmlyuhAs2jb7TnAeGryVa457dpxP1lpZh9VrZi7IYk?=
 =?us-ascii?Q?hSqKW0EuY29o/avON2/xLHSLK+99hmJt/huw0AK8M3FRhEhYmBtGA37JTWDc?=
 =?us-ascii?Q?5y/OVWC6oCHe4bAxv564N/fxw6Hzgi9Ppxdv2wcOiNYFOJMahQuimphp9W0n?=
 =?us-ascii?Q?HYNxQ37NTl3JaBHAF/fxZ4nNco+PoX0Ug7koZuajIk3kMCZ9mC7PtwWVlQYB?=
 =?us-ascii?Q?WwtvT9YVvDo3pdiKSld6Vk7HVFB9G6lSNzMWuMul+KNdHf2R1H+58EZwGPef?=
 =?us-ascii?Q?YRosf+FhRzMusWmQo9iDwdqVBG1LWdQzGPCpKo5IAPz7vis/zZuuASl1Ys4X?=
 =?us-ascii?Q?OOH3pxcNvtSJwPPh/WFdtFlgf2Df5pl5RKzYxnokNTIgFmmJgVdi7UPRl546?=
 =?us-ascii?Q?jD7O1yUXsyqJFE6NNWMK8B26pYXfA3lToP/b4IlfJrTb2C4D8NWBy1/VZ5kB?=
 =?us-ascii?Q?Qw8yiFYziB53MAz6S1ZJexHIiMP0p+66xTejk2EtLC2qcNrgc1IcSjd5gmat?=
 =?us-ascii?Q?58FAnv/ghPe/LjIWTnlTD3sKU//fCt5P/8tMhN5wprtlGKh+0Vzq9FJmjOzW?=
 =?us-ascii?Q?Rb5vYl/HtLJv7Ruc3Pzm9dlzi/mm66jLKR4MImYhjQzsJS22wwxGohAR2+EZ?=
 =?us-ascii?Q?La7L+HxyJyGNk9nj+K+0nzWqkeuNsRRtCG9ydQ7TbbMcWF6Xfw8EYWrhYQQT?=
 =?us-ascii?Q?Np1EC0ejIu5AMFl4in94Qvbv4JaEqwMUJ0o6NFzIP6L4TLljWh/4jgy9VnDv?=
 =?us-ascii?Q?rYG1tcZcKXrkTael1QEKGgG7uBWAERZR9QN/tLBjQt3d/UihHLpBfMr85g9Z?=
 =?us-ascii?Q?dyqeSocT3san6y5x6u9nJxET5e7LV0noeMyk4jz+NFV2fpkBacgF4OjeJ9nn?=
 =?us-ascii?Q?Bo4VFwbH7gV73MRZVYbF/pGAKI3xL36NRi7HpK2qs2kaeEs8EKOoObeY9pzi?=
 =?us-ascii?Q?RZUhUmfea5bQ1ukaUXCrZEDo86gYu95uwsrQ1DrMoHZcdspsEGTywednw07u?=
 =?us-ascii?Q?TY82SgE1kAbrh/jTI2At5dfE639/chu8u/Fw/tx6SKCCNUfb8ChWrdSgaxfF?=
 =?us-ascii?Q?vGe0yV8V0gLvhkMs0tJbVU2EQ0m9joOY4Rh007UwtfHiYEbGFN+4moGTloyc?=
 =?us-ascii?Q?RxZf5Yc1r9Vfv4vDu+SS6l/KmeJSS+KCCkcwksbfkuGRaOksJTn2vRC2wGXo?=
 =?us-ascii?Q?IWbdFvojUT/6CxZzzh+4Gspit8Y1hcuSilHPqcYYnKrALrhV7uO7xy6Ou8U8?=
X-MS-Exchange-AntiSpam-MessageData-1: vEUk79WtbY0LR89tU5MZ04qnd9IgAqK3r+0=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8586652f-b2df-497c-cf0e-08ded8febe06
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:29:35.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1UtN7yqcU8AxfSiwX0e7H9YVfZEZ2vWg2L9EQrEgkJmn8udLUBXPpy89JUtQjlaFTKiJDNBWXwfpS6Nr1hREv2A+eGQniAiDNJppSU1A38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4093

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 utils/evl-test | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/utils/evl-test b/utils/evl-test
index 86a3d0d..98a48e1 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -7,7 +7,40 @@ if test \! -d $EVL_TESTDIR; then
 fi
 
 usage() {
-   echo >&2 "usage: $(basename $1) [-l][-L][-k][-r][-h][--stress-cmd cmd][--stress-out file][--latmus-args args][--latmus-out file] [test-list]"
+   cat >&2 <<EOF
+usage: $(basename $1) [options] [test-list]
+
+Run EVL test suite or specific tests from the test directory.
+
+Options:
+  -l                    list available tests
+  -L                    list available tests with full paths
+  -k                    keep going after test failures
+  -r                    repeat tests continuously until interrupted
+  --stress-cmd <cmd>    run stress command during the test session (quote if multiple arguments)
+  --stress-out <file>   redirect stress command output (default: /dev/null)
+  --latmus-args <args>  extra arguments passed to the final latmus run (e.g. "-A 150", "-T 60")
+  --latmus-out <file>   redirect latmus output (default: /dev/null)
+  -h                    display this help message
+  --                    pass remaining arguments to test programs
+
+Arguments:
+  test-list             one or more test names to run (default: all tests)
+
+Latency check:
+  After the functional tests, latmus runs quietly for 10 seconds under the active stress load
+  (if any) before teardown. The runtime defaults to 10s unless overridden with -T via
+  --latmus-args.
+
+Environment Variables:
+  EVL_TESTDIR           directory containing test binaries
+
+Examples:
+  $(basename $1)                                   # run all tests
+  $(basename $1) --stress-cmd "stress-ng --cpu 4"  # run tests under stress-ng CPU stress
+  $(basename $1) --latmus-args "-T 60 -A 200"      # run latmus for 60s and fail above 200us
+  $(basename $1) -- --verbose                      # pass --verbose to all tests
+EOF
 }
 
 help=false
-- 
2.43.0

