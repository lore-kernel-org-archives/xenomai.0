Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8311153509
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514142; cv=fail; b=bJLzVtdFOdCSUqxExWb7cxjdsoB4gQICTIF3VzmTSSVjxRvYcC6pR6MwBGUn0ooU6vT7MPe2yQy2hfsR1L0HkqOSmVypi8/oB6Fzge4miOc/F27qUsgBTaUMfv/yKfyxml1oGJLap85sAktUR0XBCLpf1BnEHCPdAW497M6YBO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514142; c=relaxed/simple;
	bh=dqu7AV99vGphY6x3y1prcedpLgpDkslyBmakR75/TxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0u+74zmPV62RorPlgT2ymByiLl+JUt2sNKkSnlP2iQ/0Ooa2nAKEGywKsHGiH1qZr5kRdZRXdqX8GoY20U0VjzhAFO2O3CFjR/miVdTjux54/xzO1eZlX4T7vuZtIjGy7zbzu71ShRn/Y7PQFr4RjHIzuQCt82Rt2hB63ZmXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kfMPCd5L; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kfMPCd5L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndrP8GcjgV2AJmNTIS3vVW9Wd1fXoNKRI3lk1nOPkBxeFeFWOqIgVWP6k9hppIACsDzB9q0KrGFtcq6zLNpDpL+0en6W8MXBClvP4LgNLrVQUmjqqOs1USIdbBrQ6V+quuY4Fz9e6wR/LS16xgoxrYUjCah3GH3mLimlKOMe5YDVD2cclURv6zRK99N4N6MnuQGuc4Jf9EHGsmZ+u3cA6O2sZoBnwKvEBK0BBI1RsybzRAX5CkeT4cUg5bjRM8wUpRV5sBefIfNVw0w88fCquISpDaBVQHKQT9aLVCoPOWTc/Cx+khMzUW6XhJZAOAzjOZJyXNcVLal1LyOo2rfrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMm09sde3hSkHx3MWrFUanti1yWMjGSczCFU1f753UU=;
 b=JRulhzFiTmKPji6Ac25hKFKrYjuvusZZ5/ZpHO+0vNlCSGd6E9xluUilW+ZnDKgJzJtYAWtpvKGgMXlQCXmoHENB5OQQ9xOw+dmwkU998QkUqHy6ofs6bGGku3PMXj4YRBrHuXIem47tzfDtOHDU/YSOQ0Z9eBvJTNWNZjGHXQ+C6pINl2bsQJDLKXSo8J9IyVoJqtMCzBBWzpcvukxH97uXm80CqN6Kwh4bOjbUe0IS5Oknl4j/vjG2nGIHpg9cSLbY+davGZeJD0EGjz5aPkG6Eo9rgd3Ct4DDzjcsFM/C33YkgTe+P85DYErxe7Ie+PbWU9hAJ7sG5EcUwdn+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMm09sde3hSkHx3MWrFUanti1yWMjGSczCFU1f753UU=;
 b=kfMPCd5LpCw6hLj7xyrOGmMN3LBmusw5ParIoiNdZDlrkNUoVWRw8/YQm376xJhuxDnjNQBD1rNUCIacqfgEHSQm3MWbefIMug7E5YtIJXyaXM86XIZ3I7mdAnEOZVWtjR95g3YFtS+XLD0EMaXzcmsKw4sx5r4knkKCeBux7T3VVApP8L4pgyXU52XHElT2IVL/VZepetVbsoO2F+vYQqhmxKVuzdcXdJIZrMVIEMQMq9IVXH9cw3btpGDxxcNfaNn8/UDgwG7puoEoMHcRux82CqAN7A8YJFP/qyKt1KVw2+0L5cLoZ4Hy76aY4gFp//QQcvEVB+zjTYWyt/y5pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:35:32 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:35:32 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 1/5] ci: only use opt-debug.yml if explicitly needed
Date: Tue,  9 Jul 2024 10:35:20 +0200
Message-Id: <20240709083524.739194-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240709083524.739194-1-tobias.schaffner@siemens.com>
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b909a8-7df5-45bb-5e1f-08dc9ff21840
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QZmcCvP8XUB1N2QEZA5WLUyMGnXmSRkrpDi7tNn5iIcM8t4W/t41yynaaFX?=
 =?us-ascii?Q?our7emRSru1TMUVb3sYT9+b3ZfO+UDQLpKiiymWqNB34+jdkV8oE+7g21k3+?=
 =?us-ascii?Q?4rnFxZvNtJY2xQckXsX3sapRz1BRnJbE7fkURZjUDCd7BC/ASIFO3UeVkyBi?=
 =?us-ascii?Q?EjrvTbCmF+9NUHNFeMMwgGscyqEFG1EhDRJCnkolhvPX/27CpOJ3zVkgf7wk?=
 =?us-ascii?Q?jQwc3OiDeQlDjm4R7G2hDzAHai2r1PF+2vjxXe6xnSEJXP/iHuGwHFdUtlkZ?=
 =?us-ascii?Q?wyZCiF2ezRlkDRAaUn36HIYV4An9g0WId4qXzDzZHCBEfZ1n+OTcJCpnmaou?=
 =?us-ascii?Q?dDl5e1Hti/6Hy1PVbvIeABbarNBqvH4Mu+EX7GO8Rn8rD+5SlooG/ur58XzN?=
 =?us-ascii?Q?IFGEAVdaS95osDVn4nJBxTLRf7Z4BBdY36dlIIUF/EKzkTRuh4FA5EGlOolb?=
 =?us-ascii?Q?1D5SYgLJvzehiTB1RfjeYjXoWG4/NfFA4W9PEop4a+bDwyRyX13aY5GtHfiY?=
 =?us-ascii?Q?zSIJDj6owD01xRjHqgwnMAOhSSsbnv94pJM8h5ZTI/zmYoTvC1IDiTiPI/3F?=
 =?us-ascii?Q?822wykJRGW2eZawVvcvkrjzE1tXIVlaZGARcMT/jHZyl34bjQgUHFaUlxsVU?=
 =?us-ascii?Q?koOf3gl1JPC8Ezhi5JsqIgEDJWxAo/wE5KrTTMefEmnAReN9WU4zT7o6krBQ?=
 =?us-ascii?Q?SoQ6euxRUTzlODWz7BGTStPzvP1mcJgjMeVtJJ4MDWIwGn911fup5MaaoBOG?=
 =?us-ascii?Q?9xJHOVXkJW/bb0syCV9J+kxNZdIn5JdEeU2lE7b0XIYgI0nY/xHXOKIjmEtA?=
 =?us-ascii?Q?OIgqSyL03jlimqN/n2zMG8LQb9oV1Qr3vJV1MYF+IAsnxPOuxbOI93URzJRD?=
 =?us-ascii?Q?+9zWu1//fUC6it8zXW97cpFA5tEhjucaK/Ux/lX5uys3rvJIbgm0Kh9e9xjJ?=
 =?us-ascii?Q?zQ30ZdacXU22vKiLxuGAjq1M0P6e1vm4Ep/2uXruN47JkczwazOP3OZYO/VJ?=
 =?us-ascii?Q?H9hzevv1DyLbXWz3lmL5e37qQalaxkWWzSFwwjurxsjOijM/a6irPiGUfVJv?=
 =?us-ascii?Q?DsHCm9e8M9tVUdOfd3GMyFE9p3KjdSrtKiXknarA7Xg4+z7FypNH8EWqkhkt?=
 =?us-ascii?Q?eNxCkappZWMcV5frMx+j9BBnpr++vDnLCRl3XGGeZD4NWkXS+51cTersaY/1?=
 =?us-ascii?Q?hSpvUrjmRWE3YPXF2OW8Q9ReFqq0hjEfrl9L6a8nh+JXK7Krp2NAjwJmRpxf?=
 =?us-ascii?Q?sXv9zCuPPWCXCPlc5G284ZZKBnYUz/ji0zrwZY/z4dhWE5CDIItnjt0wFhKb?=
 =?us-ascii?Q?F3xtBC8W2Dql7IUJUKL4gNHBym78Q+vagdj2GEjpYtg5tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nyht9IvFyWKvoMuvNBIhKGjvShWSRS3tkaHlHo2chwwMUTopoIAp7c6RU8Jh?=
 =?us-ascii?Q?y0aRqMtCE/DTczTHoQCjY4pNUNm7x/YlB+oLmc6LK0gVq6K6cwLmAo7dRFUV?=
 =?us-ascii?Q?yA436rQ4SBRWqkKBsWyTosAM/wxB+dNI3k6VtnZTJTQNq4FBMKvvfoZGOicm?=
 =?us-ascii?Q?Cot6fZR0JIK5RXvMyWM97jbNMoaH3DEE3xpUxKi2DpDp5dGRyoJMteF5po+P?=
 =?us-ascii?Q?Wc0PppzeydxwfXcCe02BjhO90R6cKP604P7Y5nVwqnM0ywVZXXhb5abbCPQ4?=
 =?us-ascii?Q?QrU43WrgIWijTZj8+cI7qmK0c2tm8+Zh9B0qQMwXNz3d6s2tZY9uI978b9y2?=
 =?us-ascii?Q?lQv7DSum8fPhRm0nUz8ZCAVDUtbUZ4t6+9vLutesJKyVkSLDIrkBp4Th7/7u?=
 =?us-ascii?Q?TGmCSirAgPCw/XfO2owzmyOAhJKvDYArnIwIata1UBqk37ZXdE1AjNB5Tc+m?=
 =?us-ascii?Q?NZJHgUYZ6xzAOyYdqzHMEp8Gq/I07bH57CzoAY9kP6Y1DtV7lo8XZDoT+GtG?=
 =?us-ascii?Q?i3l/EDp+elhzu0iZX8Ad1OlSpgnyISqpjfGfkiqt5IfHOvxU8XCsfEkRXXuj?=
 =?us-ascii?Q?PXkc48CKPu3dBBun1QHt69YswOpSZ4gED0cf6fdA1RlIueSvIQtcN6bm1awy?=
 =?us-ascii?Q?YOz98yQLL5cmnPzLWO6TMB1v4F9i6qDqbqtDfe+zVcAudKgvRZzIkA/W4aBZ?=
 =?us-ascii?Q?taInzLat31pjACS3fgPBT/Xs+CPVM43UTeKj3JPJKpF295bXBusF3R0S4nb7?=
 =?us-ascii?Q?yg7U8KnFABMRBlYFvHAjYief8fnZrBcPUaPicDFnGxloWr7XGSjxRexWAi+e?=
 =?us-ascii?Q?Pe/4p84jfKi3f+hO7PhUUmaFuIfHfa5L4mKJFj03BCGswa3Z6l5raWJXSJ+e?=
 =?us-ascii?Q?Zm2qa4iRJCnsV/fTnzk4Wx4oaYy81AlVw0w2U6g+5nbwjHdnrPZg+/AeIIL4?=
 =?us-ascii?Q?b11jdgla2ybe2sIzeapNNPqC00CpJnETu47EGKCviotPamkOSdXrh85eafo6?=
 =?us-ascii?Q?p/5CevqKx+jbzGo9napvbhom+uFoNPh7kkuJ4/FpvNF8U6RLw6pvLlUIyvmb?=
 =?us-ascii?Q?o6R5lyJgHZHSlfGaU1kxIxIgLaUQWyE1yPDrTv8vZAemFGJZMRIPkuO21QI9?=
 =?us-ascii?Q?XD3HpdOgk2Rd94UpjkXrdbpkLtVu39JPSvJuZRhCrbdWITmbDlgBcVqfdzb1?=
 =?us-ascii?Q?obgJ9I+dEeKVX/pHjBKOfTNfGiOJr5XPoUtkjbfV2lPBzpMueMbszgLI4Z3y?=
 =?us-ascii?Q?9ezzu8IxikpBFtOCBl+ze1YEXSyqH1YHBkOqOgNsA59Itn8E12KDY+N5L9HP?=
 =?us-ascii?Q?nXZKrPG6I4hMa7EAuerQeVXLvJpPcXuXIuauExmsuKCa0Mw8uBQ+/ic4ahLb?=
 =?us-ascii?Q?+WbbvscWemNg3Zt8rbosR8E6+mHa0Ecq3QF0Nio6RMAKQkFk93YH87CciAsy?=
 =?us-ascii?Q?GKCWDwEeik8GehFMyZSR+S4WlmYxd6wH6YqocvDf4a8MJzQCif8nbLH0OqKA?=
 =?us-ascii?Q?xdPMmAMN+G+RI2RVA2cyKr0SZUQ2jRA2RqKW8pPRgzwMrKtZO6taN2MEis7r?=
 =?us-ascii?Q?PX9+FaijiOIYKzbRiBugdNSMH+2sGLJPYLS4S1DhNUYs4rAYT5iYCzJRrbEI?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b909a8-7df5-45bb-5e1f-08dc9ff21840
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:35:31.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSLxNGFC5koCpJd7o3oVpdiz6Ly9ETC1VHzPzKz2KjFNNsscrXZ7HsZFytwS9Fhbh4X1SWjkdlqWrvi+UQstxKsX3uZhzzK+/tPPWUrSzG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6436

Until now all CI runs were run with debug builds. Select this explicitly
to allow running tests with release build in the future.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/xenomai_3_0_x.yml         | 2 +-
 ci/xenomai_3_1_x.yml         | 2 +-
 ci/xenomai_3_2_x.yml         | 2 +-
 ci/xenomai_3_2_x_compat.yml  | 2 +-
 ci/xenomai_3_next.yml        | 2 +-
 ci/xenomai_3_next_compat.yml | 2 +-
 ci/xenomai_4_next.yml        | 2 +-
 opt-ci.yml                   | 2 --
 8 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/ci/xenomai_3_0_x.yml b/ci/xenomai_3_0_x.yml
index 0212414..0b0c837 100644
--- a/ci/xenomai_3_0_x.yml
+++ b/ci/xenomai_3_0_x.yml
@@ -13,7 +13,7 @@ include:
   - local: '/ci/gitlab-ci-base.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml:opt-debug.yml"
   LINUX_BUILD_OPTION: ":opt-linux-latest-4.4.yml"
   XENOMAI_VERSION: "3.0.x"
   KERNEL_VERSION: "4.4"
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index b6f0010..64bae5b 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -14,5 +14,5 @@ include:
   - local: '/ci/kernel_4_19.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml:opt-debug.yml"
   XENOMAI_VERSION: "3.1.x"
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index a0e777c..cb08948 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -19,6 +19,6 @@ include:
   - local: '/ci/xenomai_3_2_x_compat.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-debug.yml"
   XENOMAI_VERSION: "3.2.x"
   LATEST_KERNEL_VERSION: "6.1"
diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
index 11eed85..053468a 100644
--- a/ci/xenomai_3_2_x_compat.yml
+++ b/ci/xenomai_3_2_x_compat.yml
@@ -11,7 +11,7 @@
 
 .compat-vars:
   variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-compat.yml"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-debug.yml:opt-compat.yml"
     XENOMAI_VERSION: "3_2_x-compat"
 
 include:
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index afd45cb..1a49f6e 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -18,6 +18,6 @@ include:
   - local: '/ci/xenomai_3_next_compat.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-debug.yml"
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.6"
diff --git a/ci/xenomai_3_next_compat.yml b/ci/xenomai_3_next_compat.yml
index 5ccc832..d40fbfc 100644
--- a/ci/xenomai_3_next_compat.yml
+++ b/ci/xenomai_3_next_compat.yml
@@ -11,7 +11,7 @@
 
 .compat-vars:
   variables:
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-debug.yml:opt-compat.yml"
     XENOMAI_VERSION: "next-compat"
 
 include:
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 4df6699..64657ff 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -15,7 +15,7 @@ include:
   - local: '/ci/kernel_6_6.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-libevl-next.yml"
+  XENOMAI_BUILD_OPTION: ":opt-libevl-next.yml:opt-debug.yml"
   XENOMAI_VERSION: "next"
   LATEST_KERNEL_VERSION: "6.6"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
diff --git a/opt-ci.yml b/opt-ci.yml
index 3581315..01d5c07 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -11,8 +11,6 @@
 
 header:
   version: 14
-  includes:
-    - opt-debug.yml
 
 # LAVA uses nfs to deploy the image to real boards. For this we need a tarball
 # instead of full disk/wic image
-- 
2.40.1

