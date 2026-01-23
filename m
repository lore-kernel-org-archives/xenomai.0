Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972524466B
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177718; cv=fail; b=IXwVhkN3cTTpzB3WDKOp0GABR8qYuytRtbrDRSAP6fj/kztx+B02I3RXjIBzhC2SnXw8pUnKxOuriIrXGDWTO8+RPqI0v7RnAtYSt3XjOO5H/uLi1NX2e+EFF/fT5KjH4hCeyomBgQ9m5kRXVkHGESScuW31TYygW46y/ZlmeNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177718; c=relaxed/simple;
	bh=ikL4K7LlGvlh87XMIHnAyey/JvBIMRHinVlQ4oqARYU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YoFKDImYrxEjG7QonKJJHTc2B4wX9AfD0e0CC+Fk6IOM+Jejdbe3j14YKaEv1QTpbCPzoWebbcfLIdFZ9mdkKPTyOnnBy48844vjql5g5s+cdhehsqE1+4KUIzt+MQ8e0RY6q63wARpzXtR+1V7NAt+Yvs6YAfj2EsvY43YDyZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ACnxggO8; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ACnxggO8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOb42V2K+O1jhzDJIODgWjokAzwukOpoDJDz+RIoLhm2ZSLaRYCQ9WtQP0jMdxhjprUwKhCk0CyMCPyCX6ORu7aDsF3JdTUZpKfl5HA8gMMvvOJLFIwbxJ7LLbkRM+fs25+ZfO1cCD9RmgycD41yRE5qC1cx3lawwDi4UCQD0aIvDT3GzxRBJ/ObOs08hjUUhn26dz4WVHZsbYqm9ZDXieRrlbukLK2Sp1FeFst0u2xmRGr9sXxjOa/4zqMVbyr2ZJ663qZBbTmJyx5289yaEt7xfIsVrz/N4qslSIG4nqeQBDqYEMhVuR6yU9hipp3kIXBVlcl0OFueLEygVfgjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1BweY2PD1j7rP8ATeVvoDCTW5hmTlVp4H5mJNjJRLY=;
 b=UdC9OFQSYCx/DKrj3FJkyt29v8AmqXtVzKjVP3qILtPmbNEcUdJxBGBZcZWnCRSJG9u+1zTYQJd9bGdKtYBUFcvja2wSmWUDNlghY9M8LZy0qnUXZzsNAwu/OoEaGwVN8+nVNx4ZvXbTto2vHydLheXcVADe0YDwne9dj1vamjy2grzFMnZnG1U9vGthyQFEn6cd3i7qhOl2/FMnPl89BDUwvh/mkimcyWA1QUmOog5D8vgN/K7N4QVw7uA/yqANbIKP6rtmRpBN8UUvnLpea886Bb9Ne31zraKbt95lTge/u41V2RBgpV2lurYT1RmvYoKb/rysB6XsgjZBOyi98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1BweY2PD1j7rP8ATeVvoDCTW5hmTlVp4H5mJNjJRLY=;
 b=ACnxggO8xEmsCVzCHbeGUWsF42wmWcusrrjbA3KunoWtubVyltOgMdkqOELriGALrxMleyEIjO70RL0+6GD8U2VFy81ZA7d+k0j6HlnbbE+hZxbi+v1Wv+R+z1+0dvxQWLiKFxiV5OTZnEyNzRJ8uBwDDL+d7hCV5t3zMnzeP31B/0oaxTVLH4PCjYE/Z1iJogNEnFQKKajk0PndibMIT+IOq+lMxgVvjdzMn1eAifvlrAWpnuziH+QMg4xl8tZUkrTH3j3a+kUIRVwfscH5aCS36M+RyN8pkoIk7jfJX9RWyWOPYMWmlKgLl83yQFaJTtF0nUMfjWpEaKmWk3hNRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 14:15:10 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 14:15:10 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] libevl: split libevl into libevl and libevl-test
Date: Fri, 23 Jan 2026 15:15:01 +0100
Message-ID: <20260123141501.1871775-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0381.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::9) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c5437e-c8d6-48c5-fcf0-08de5a89d160
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pM7UZs6obYpIaPjNq0U3kVAZVtY6hgt1ADC/JzSYP3Z4xJBKoBWlcynkSzXw?=
 =?us-ascii?Q?sr7f15e59RP9cQLCfqdaZIKTbi137k2RK6BL0numo4yr3dEvWhTjH+jSuKhZ?=
 =?us-ascii?Q?pyxkCvYHLa4pHASi2q+5Z6AqpdKGODN3+tEt7TImZv869YHoeltd8mpu+z3+?=
 =?us-ascii?Q?ZfoGtbbbvYtdspJzc1Z61GGP47VQnoDkTYkG7R78rwWpoDFj+FRXfaOmKXX3?=
 =?us-ascii?Q?4eJLiOGbVRPF9EmZ+Zl/wA855zwyiFXIhSqmDh6l+t49cKNokqAq7Y7IFcQl?=
 =?us-ascii?Q?3pebGGwkk0IWPOPs5PrFAh3TbwxzJlx2RoJK7n9MnoIViFwf5cNyLKOiKrCP?=
 =?us-ascii?Q?d40pMt3KSgYWrhwfjpLx58POy7912k/a5Amge4+kgtDAGezl9mRO0t0U1J86?=
 =?us-ascii?Q?BE0E9zC5GwDxMMHoX6uc8ic+x4fPNTLO+taEBmadGSOXxW7q7SiqqA13HTem?=
 =?us-ascii?Q?ZEN1ZN7UaicvslmWmRvq6/oy2oTfvgpw6/7pxTk9IdT+sDL2Denn+KMlbukD?=
 =?us-ascii?Q?7EWWGzO6mw6SEvI5AIr9MtYP17zY/0bJ12Difw7wjzG1gmyHwymu6v4/O0C8?=
 =?us-ascii?Q?LtVfoK7vjXtgBupLSm6Tuu3oYBRUqEbjPd5NdCCYA1KBdG+tt0BvJtWQSqBZ?=
 =?us-ascii?Q?F1Q+Buekg+4iPSvMgB+m5pU7Mtg5TiEtMLF+p60bMv96lNIJvpKdBX4XNvK8?=
 =?us-ascii?Q?flxzXN0FniHUJSDO0M+s351qLjRsoDYY2UX9zluHpA1wHWM1+SLCxlAnZIma?=
 =?us-ascii?Q?3km8jvxaNLXB08V8m+qT1AOron7X3ZbRWsoJxNUw9ic5dj+AcBg44+798LOl?=
 =?us-ascii?Q?g3bfsjblqGTkC963dMM9N9/1sUBbu3valuY6UdGuKQXCtfgbVdemlAYknEbD?=
 =?us-ascii?Q?la9P1JWBIIZJ89PaOxRSsdiMUNjmZ25V77HREeVtujYj7sdaulHTvnVQxu2Y?=
 =?us-ascii?Q?rL+7GDJcB7dv7pSyCCQF2XBAHAuijWT+JDtMeCVV9mTcJuRSoMKeiwu3+daM?=
 =?us-ascii?Q?s3j3eyDBcNC1ZL3sJpAUZliYg8eO9nIfTBdMi7oP3VrX0yhmb5sWowo0cXmX?=
 =?us-ascii?Q?Nc4gw5qHow+9lVK+/0SpW0O93xnKhdKN5hAT3d+H2ycBOezBYPfZnfSU0TVf?=
 =?us-ascii?Q?rz8iUcaxv4cDJQ+UTLJKXsB9dgw7lS89gzqh/qRi7/vhXKsB00hp+Li0OQkB?=
 =?us-ascii?Q?qbhXofx/DreVDpeASOlW3Z2KuYbma53Ckek1IdehFRxtafNVgAs3EwdYjb2A?=
 =?us-ascii?Q?zlwpIGuVs+uQTatSvc48C93rqEljMq8J03bLeiSkI4F6WO07ZKCE+K21DdMy?=
 =?us-ascii?Q?c/uxViyMJBkPt6DqqP25XGw3H7fgboEvU0sowHp0W/KCqvULlzseDOSCzb6n?=
 =?us-ascii?Q?XrPgA3gTRY2QbaRo73MB/rdpCMSg+SN9klDOMjU7IQSqeRd303yDA6At/z8q?=
 =?us-ascii?Q?ZW8EeknZdLuq2zrqIl9rwRdyaG71OUbYEQFZB/+H8Ev/sNaM3nuMKn802AnW?=
 =?us-ascii?Q?8Eh9SRonGw5IWR6HkHaJv5/jrjWIrG0bSSjVMBF8lqZN+Z9yqcNatyhnW0cy?=
 =?us-ascii?Q?resTudxuv1iOjFlWILw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5BIWSClJlB2AFD1Qhx/Zc5nLVfIM0VJ4Y/W9jv2mz8VRykk6a1uooofPdrjr?=
 =?us-ascii?Q?YKnd6ogJhhaj10qZzd3t/s78IalsDvkipZfg5WTePJzDcyd9eDEeESavABJU?=
 =?us-ascii?Q?qWXSacyXY6+h6RLZ/J7Kj35SsfvjFKkD6WG5uLWqltl0HK54qARkH6dMBPtE?=
 =?us-ascii?Q?X3mUj89H2ohGNw3cMdTMePICFlkClG+pjzWnQBKX3V7vtS1B+iaJUUsCHc2V?=
 =?us-ascii?Q?Db3FsO49/urd1bHhOxE06Zx+payUWtma+SPoI5MP3AglnQ5+CpARzrgiBBqQ?=
 =?us-ascii?Q?S+0MQvrqCzhz0T0DNKmuZPVIv5Tjn7WTo5cUugHSc7ud6FSPQo0Zow/wY17w?=
 =?us-ascii?Q?7/9RTSyRs659xAAKMwDPJqDG3WzzSFZYNkJdc5gSr9nmY0eV5tuUiRr308pb?=
 =?us-ascii?Q?iQWZGp2HokxeujT93S6xjN5o889cqPLcplnvNMc5kNGeEVNa6tteEHAOGwrR?=
 =?us-ascii?Q?GNproRu2esbsJQPfphxDFFtWk3lBLLfdy7sPKLGi9ZIhXlCrmFxFi+aQPuIJ?=
 =?us-ascii?Q?QzDp91EPHXpmS0dLjEO9aWz+MbAHcsKLZ+9hbQoNHQDf1uvMQl0NHyRFUPr2?=
 =?us-ascii?Q?Nv8UL3zsG+6jkmgJ4sJrklpLNvB5exRbXO3SABF7NoRjyrz4LHrMUZr1m4Sa?=
 =?us-ascii?Q?lJkmk2OyEFK3V5R6P87bAox0K/e+rsOXYXouhtfbV04/RExgx8XHcySvRaVb?=
 =?us-ascii?Q?T2DfexZxd3TpubSKembSnKLRPcPY53UzsG92438Dc3exn4wGCOLE3bTc06Po?=
 =?us-ascii?Q?vlBSG0w0gLeWPNiqy7C3npu4uHQL/NM+G12Dy3C+7+uFkQTv5yE2T9AKaovz?=
 =?us-ascii?Q?ife6udgKEqHpWMJiLxxad6nAVMI2pvv6yE0vJiwnCTLFYyqq2I24qGI4fXOP?=
 =?us-ascii?Q?5E5dcNjaUfXgaIUp4lDb3xJHm4LnrK+roanBtcjc02dLjqfcDoVXQmkj8ekz?=
 =?us-ascii?Q?lQumMu0ebyxejlqCzDGP57VZG6jBB/YCMAi6EJK/qTSZS19UzZa1TTIgC753?=
 =?us-ascii?Q?3psHqGq2gQtdt5hh3i3vk8oCQsVq4SBYWjmYuen/zqOwPb7vQWFv0S4iEJsp?=
 =?us-ascii?Q?NKoggH1awdsptnYNS7RIE5gPdcdOou/S0y+lDRcl7ZZSR5N9hAlWJ1Rq6pVT?=
 =?us-ascii?Q?dclGeo80xjuezTPNdEd9Lnr1GBNFQCND23c5MR3Rjo6fJsFk3UPiqU5y081t?=
 =?us-ascii?Q?hHUOAFLl9n1IbOna9+OxmuViZFTNwKEuNYePX/y3lomC8n6ExYAQp+eAh5bX?=
 =?us-ascii?Q?/TVOM6ABWhESCjXnJMSUNcoV8WnKzPMPmiLioXV39n9aTXUWIaLzp2YzSJkW?=
 =?us-ascii?Q?f3oAKZ0mDrqG5wlspyQR2/cjj8+6fHcPBTI34d2bV+eESksRisYmb/0KMmye?=
 =?us-ascii?Q?7fVGl42SjxjBQTR38QmCLA39g/0Ga3EMAjck4zJhiVFEbplQcNhlTGzSi6Eh?=
 =?us-ascii?Q?t9IjNfTs/zLx+nsa+NLjoEKQbpqSXQNti4vZ6lYhSLSau86aahjhNuXOQVjE?=
 =?us-ascii?Q?215MlIy/EjuJTNiWJa4IXkT0pbfbfvSW/x9GFIpv0FbM88ZBrjJcL5MzDd9B?=
 =?us-ascii?Q?1DBa0rMUeye8q/1e+7abTRYMkSkdifdBQd1praaXK57JkW1QsM4j0r0RonbH?=
 =?us-ascii?Q?MateCHA2ZGKn/SXas2+C2RmbDUfKpmTivbNviGW4AQW8irPFCtNa2iTK+XRN?=
 =?us-ascii?Q?Iv2y2CDcpFrdhKFehLrVFik4ki/v1CQYaXFnSP8qhcAXxGly+JWZDmffFYHo?=
 =?us-ascii?Q?bUdgghbnF2Un/2B6CEx1icCgcwQ5NgU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c5437e-c8d6-48c5-fcf0-08de5a89d160
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:15:10.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ1fNOQjNS4CA0jPKeMw4ZrkuKG2G2e+SEorujGR2wh45pSd0s0r1Fr3Gdt75zDdA/oZMmf/zKiVhgcMK62SEP4iQNreyMgvsum1kyENHXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7745

Split libevl in a pure lib and a testing package to make dependency
handling easier and to allow soly installing the libs.

The ptrace-sync test uses gdb to resolve and set breakpoints at some
named symbols. Add gdb and the libevl-test-dbgsym as dependency of
libevl-test.

This is a substitute for "libevl: allow gdb usage for ptrace-sync test"

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-core/images/demo-image.bb                       | 2 +-
 recipes-xenomai/libevl/files/debian/changelog           | 0
 recipes-xenomai/libevl/files/debian/control.tmpl        | 5 +++++
 recipes-xenomai/libevl/files/debian/libevl-test.install | 3 +++
 recipes-xenomai/libevl/files/debian/libevl.install      | 9 +++++++++
 recipes-xenomai/libevl/libevl.inc                       | 2 ++
 6 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 recipes-xenomai/libevl/files/debian/changelog
 create mode 100644 recipes-xenomai/libevl/files/debian/libevl-test.install
 create mode 100644 recipes-xenomai/libevl/files/debian/libevl.install

diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index d0a1f42..7ea4dbe 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -48,7 +48,7 @@ IMAGE_PREINSTALL += " \
     lsb-release auditd"
 
 IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
-IMAGE_INSTALL:append:xenomai4 = " libevl"
+IMAGE_INSTALL:append:xenomai4 = " libevl-test"
 
 IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
 
diff --git a/recipes-xenomai/libevl/files/debian/changelog b/recipes-xenomai/libevl/files/debian/changelog
new file mode 100644
index 0000000..e69de29
diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
index 36eb68c..89c871a 100644
--- a/recipes-xenomai/libevl/files/debian/control.tmpl
+++ b/recipes-xenomai/libevl/files/debian/control.tmpl
@@ -9,3 +9,8 @@ Package: libevl
 Architecture: ${DISTRO_ARCH}
 Description: ${DESCRIPTION}
 Depends: ${shlibs:Depends}
+
+Package: libevl-test
+Architecture: ${DISTRO_ARCH}
+Description: ${DESCRIPTION} - test suite
+Depends: libevl, libevl-test-dbgsym, gdb, ${shlibs:Depends}
diff --git a/recipes-xenomai/libevl/files/debian/libevl-test.install b/recipes-xenomai/libevl/files/debian/libevl-test.install
new file mode 100644
index 0000000..e4118fd
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/libevl-test.install
@@ -0,0 +1,3 @@
+usr/bin/latmus
+usr/lib/*/evl/evl-test
+usr/lib/*/evl/tests/*
diff --git a/recipes-xenomai/libevl/files/debian/libevl.install b/recipes-xenomai/libevl/files/debian/libevl.install
new file mode 100644
index 0000000..7efc9b7
--- /dev/null
+++ b/recipes-xenomai/libevl/files/debian/libevl.install
@@ -0,0 +1,9 @@
+usr/bin/evl
+usr/bin/oob-*
+usr/include/*
+usr/lib/*/pkgconfig/evl.pc
+usr/lib/*/libevl.a
+usr/lib/*/libevl.so*
+usr/lib/*/evl/evl-[!t]*
+usr/lib/*/evl/*trace*
+usr/lib/*/evl/kconf-checklist.evl
\ No newline at end of file
diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
index 1783042..4c048e5 100644
--- a/recipes-xenomai/libevl/libevl.inc
+++ b/recipes-xenomai/libevl/libevl.inc
@@ -14,6 +14,8 @@ inherit print-revision
 
 DESCRIPTION ?= "libevl libraries and tools"
 
+PROVIDES += "libevl-test"
+
 SRC_URI += "file://debian"
 
 DEPENDS = "linux-xenomai-4"
-- 
2.43.0

