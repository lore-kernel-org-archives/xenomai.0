Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF4442C
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBAmW9auqyGlO8QqLS03XAACt5jypoguVKNBTht53/9Uq9+IZaFk0nQH8NGywK4hXn+McTR/QclAKstKH0Tk9Rv21x1KneH38jNkADkTbmx8g0RXt0TikxWze2IOhLJ/XIRldaYpvhqHtZ1ZJMlD/B4XWAxwNjcs8XCkztiSa0c2VF+yXmldGQbD/x3onTwAhul/aXRbu3FCia39ks2xN93hVLBRmNDMw+lCTxyoThDZa6yQ4QNpA3PyRSTSlGISDNLmrHUopNxlS9FuhCXXML3hzaoNTjB/M1F38tcZG9Vkwq9oBSIf2hZ0v6F8KzJEMl+eovhxXKDNBak5rSrCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+gysYJEemvif/WOtCKyteYWjJ/uPwmszSeKU5bJckM=;
 b=cNEhtmAloYYKNvQ/2sxAd2ySVnD20PRAmfnRg5mkeEB/uTsgr6HkHw4sQIV5M+QQ7EZ/fhlWxtoKg2tGALuJpjN+27BEYg707pGv1DlsjjXH+61N05ZKNY+1gaJLGHRhTYDwCdSWwqkqwoNqxDOIaO0GxfrmYPZT+dHiyST+7mHE8YxKsxs9Y2OiehY54pTP5fwURUfMFeGLuCYGali4urWjKu4uzX81nyoovI8uzJhdxufye+7SqRM9ovJHNkFshHlA/giNAFwzJAK+HG8j5rcLDkk296wSiVZyXswSik6bmrWWt2PEQvtSU6+PkJmWVhnr2mnjeNTAXLTBr+OWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+gysYJEemvif/WOtCKyteYWjJ/uPwmszSeKU5bJckM=;
 b=dZpfDcJ8h9BhcfuM+CZLsi/eTJlHvFDoNKC9jINDtizJ14xp/SBVCUZuvudQTSKrgbu9YkuLSmt5bRZsfJQoCnYsjhV8WJ5QVpgeAYh17okV43VjPXVT0wHgligqg+l1T4LKbJJGsDoaveePQ14Gqz1XQ4lUib2Pim9idTnkmXRvqqlUetfL9OIGoAaZXjnn+1qTbCL8d7cOUVChTo0ZxVuz4PSdvdcI2J43O5hzKlyUW9nO+2iC7lFu3LxcaEymyOI2tMDm5b9BJxslid2gUsTgcpuyT3hxAXSZXXGd6rLO+N41Hq6sXBMocVOSE84+CsZAg9G2PEL2x9TP/E1uxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 13:44:08 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:08 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 20/42] y2038: build: Introduce new build parameter --enable-y2038
Date: Tue,  9 Aug 2022 15:43:04 +0200
Message-Id: <20220809134326.23688-21-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0257.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::11) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8383799f-74f9-4285-f44f-08da7a0d3bf2
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zXlF6584LZMnhF1jG716EeFaX1UFD61RL8kuJr0B99qaimapDhP8O0/l52/EriaNFB8NStDEStMcwaLDn7K0DLhcSCKVEOf/0koqVzsUWSQngpaw+EIxkcM4RoF0QDHFb1lZFDYGQ62svmyp68u30T+F1unkxavb6j4qCre4Ca5bcUN+bBmGNVHsJKaFdyu4AOPrprb5NUems5uruuFY/tpvN8+XvuSN+GpFgsKKkqkz/BDhXEUsfVCCP51Tu3q+Dfr7QhcsAHrX4gmhiIc8jbhsxywW6n0QqkvAcnU4pstabxcKT6nxK5otUgnrD7E82DQRIb+bfn/+HLcldE1JkGYH0TPXpLL12ZQ2ui0U+JNxmFjlmCDd+5SPF/a7nRJdfrwexc3EDYJ1Fzrr4SvTKH8eOb9XdI0yMkXYTECVLA6a4CVqJk2ypK8mxDbIIMW+EsM6g+xYz6WIi0Ey5mgyiRHDoEhB8siqYUehECEgweQGIAlBZuB5vBs2qevXkNe36dZbKh9Jg8BbbA/kX1Nr02p3IQJOuL8ya0/Z1/1zEUKShNiyCkhKoi6AYCudRSbXur+IkhMqtj1eZyudu4i/wuvnDVAPD4uGBubPHPZ2M0+kJ6XbzWyKPXc5whOaPKHi+HPj6F1fCcwx2H2dKl0WGn0/y0uWZgysJEux83Y2K+7PeAtDXmhaEwY6x2gxnfq35c++Zq5/+9c1/unyTHMg09dpOsMviSSt5ywVNV8GkY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(44832011)(66476007)(66946007)(2906002)(8676002)(4326008)(316002)(478600001)(66556008)(36756003)(6916009)(6486002)(38100700002)(82960400001)(41300700001)(26005)(6506007)(6666004)(6512007)(86362001)(8936002)(5660300002)(1076003)(107886003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2E98YGiQgrIEeOacNDTGYz3CflCzPF2mtnq8nW/I7pZFMSRyLynolAsQ0Iey?=
 =?us-ascii?Q?BsW+cnrtaC4t6mXmnCwaVxmGV2XRORNxoeJQhNmJWK1KiVSx0NoCCqVhG3N2?=
 =?us-ascii?Q?QK4CXyW7CAzUMRIDRNWLgG6qDGN+F4Fpv3c76kKmYB0uShXDyRWwYevF8fXR?=
 =?us-ascii?Q?1L9of5TOFLfYpheA5SMdBLDZ4BBLuA2xzYhuUyRCv0ypdN0zshwaOqadikR1?=
 =?us-ascii?Q?SHpgZ/QwOyLl0VWmNifgGdWX3IZgcB70885NdO7XFhrSP4AluRbIID4eCRGm?=
 =?us-ascii?Q?cYbIQGV3g5gnb6aHaBr3P/No4YKtSQ/ZTaBfmhBbaFFR/giQm3rNaVoKG4Rc?=
 =?us-ascii?Q?j8RpXpsKy+CAv6MaQlzhviT30rM8tZDQeFZgoOiS+mHFIm/qewJrU7XCyesT?=
 =?us-ascii?Q?izz/uzJc7Rb4uzG+Xk1tOyK/XJPOQnVumPx9U9O4qgPD8LboX2zzZPJ0zH/9?=
 =?us-ascii?Q?3wRD0GaTT1dijFZiQg0cn3L2nvDNrmrjIEQH8vI2bVIa7eQWynfG89iUR/vt?=
 =?us-ascii?Q?umVnrlcQqab5VOZCEL2tZ7TIZfHJPake9slgyz9McCG+HLumv6Q162Nl7vmC?=
 =?us-ascii?Q?uVzhxAIvHDfmwifaNS6NOwci1aBA+CINOt/5xH3RUY3frL0mVfLHY66ldj/T?=
 =?us-ascii?Q?nT2kOUNHD6TnZTfdGDpgQdLLEJY6sxEL0XNIzzkWFXQ+DMXTaY+q6UlyeuvJ?=
 =?us-ascii?Q?R/BsG2+zEo1J5zLRAB/FbMBxu3KWaN3l0wevqaOJu5cYy9PBj/fGHj9KBPKf?=
 =?us-ascii?Q?NxzKLqa6LhPAse3wA38DdcsWbx2PZJJrc8CVt//TMirmF+gUyrsoKtpjN4hW?=
 =?us-ascii?Q?LcWc8JoU1G5kj4XRSxHRajs/fvVli0T9zMSJf5kgs8D/VFlnZB8p/GCvD0uX?=
 =?us-ascii?Q?vVYbyJxyx5g5s9L+qnEGlqPu3CaBxBkKttbVQdvtoFokOT6JeeK2o1ZX/rZz?=
 =?us-ascii?Q?pbbSr+KBstdL/6KagaMzguKA8Dsyxo1j24VAi63C+iYOrt8WyghPPHAllC9c?=
 =?us-ascii?Q?NkzYGg8uOX/0vC9WC3Sl8HLQa9MqzTXXmrDVBh48KjzPrLMVicc2CGRlZ/mf?=
 =?us-ascii?Q?pjwoytmFgteXuaGOPpCEAoIVCueNFZSczEGl4CkxouHKCW8EuC3+2xVGecEO?=
 =?us-ascii?Q?LDGTU+jF9h33AgXGHhjCSF7gjs0yCijKVL1Wc6fkb067hAttXliKzJgJRKaj?=
 =?us-ascii?Q?dT8KzzLYbD5uq/cjlZbNzePV/jTUx99ljEV2btroK+jbFxg8Ow7W1e2ToLzT?=
 =?us-ascii?Q?1BHZnuSYCRGEE4QdoRqG4eAQtCp4fvx1jvGWGhk+eh6KwyHA0mKCXs5BWSsB?=
 =?us-ascii?Q?NovQrvvkP3AA7bYuLInAeaUr9wVGybetvcvewR1j4gH1n82lR+bD9RR+L7Bu?=
 =?us-ascii?Q?RxwlVImKZmVpyhHu/o2A8psYs0dxH3abQE4dNtjS6Ws/Xwd+OwBzYHATOUdx?=
 =?us-ascii?Q?mYt93HkgXr2pKo3fjbFJlwKCu+LqMo/p7q7fnLYffHc6Y1Vv8yIE0w8vaTlP?=
 =?us-ascii?Q?2lUupGnBzvmgwSu5cFOYWcqCCjNq+OBNe9a9zJweKdzHBUcJ+/ezIxX/YI74?=
 =?us-ascii?Q?3aiMyjm/hURufMc2XXNupQgR1cUwh/NpbvgMNVP7zTbDnoYAv+4lXONOYQtf?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8383799f-74f9-4285-f44f-08da7a0d3bf2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:08.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlxUxeY1QSF7vD6MlaFXkcoqheAGH7monmiac+1BGHNNgtoAuV7ttAsKuXKNxXswQvHB7BdR3Sem4zYvMbloPGH95Nm0fErVW2z33I4iM+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674

The new --enable-y2038 build parameter will be used to enable
additional function wrapping when the architecture we build for is
affected by the y2038 problem.

The default value (for now) is "no".

If --enable-y2038 is given for an architecture that is not affected it
will be ignored. That allows us to flip the default value later
unconditionally.

CONFIG_XENO_LIBS_Y2038 will be set to 1 if the following conditions
are met:
  - y2038 support was requested (--enable-y2038 given)
  - the target platform is affected by the y2038 problem
  - glibc is used as libc
  - glibc has y2038 support (glibc >= 2.34)

CONFIG_XENO_LIBS_Y2038 will be used later to add necessary glibc
wrappers.

If y2038 support was requested and is available in glibc the CFALAGS
-D_TIME_BITS=64 and -D_FILE_OFFSET_BITS=64 will be added to
affect all compile units.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 configure.ac | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3ce34048e..ce708a00b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -138,19 +138,23 @@ case "$build_for" in
 	use_tls=yes
 	target_cpu_arch=x86
 	CONFIG_XENO_DEFAULT_PERIOD=100000
+	y2038_affected=yes
 	;;
  arm*-*)
 	target_cpu_arch=arm
 	CONFIG_XENO_DEFAULT_PERIOD=1000000
+	y2038_affected=yes
 	;;
  aarch64-*)
 	target_cpu_arch=arm64
 	CONFIG_XENO_DEFAULT_PERIOD=1000000
+	y2038_affected=no
 	;;
  x86_64-*|amd64-*)
 	use_tls=yes
 	target_cpu_arch=x86
 	CONFIG_XENO_DEFAULT_PERIOD=100000
+	y2038_affected=no
 	;;
  *)
 	if test $rtcore_type = cobalt; then
@@ -781,6 +785,50 @@ AC_ARG_ENABLE([tls],
 	    [use_tls=$enableval])
 AC_MSG_RESULT($use_tls)
 
+AC_MSG_CHECKING(whether glibc has y2038 support)
+AC_TRY_COMPILE([#include <features.h>],
+	[
+		#if !(__GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 34))
+			#error "No y2038 support"
+		#endif
+	],
+	glibc_has_y2038_support=yes,
+	glibc_has_y2038_support=no)
+AC_MSG_RESULT($glibc_has_y2038_support)
+
+AC_MSG_CHECKING(whether to enable y2038 support in Xenomai libraries)
+AC_ARG_ENABLE(y2038,
+	AC_HELP_STRING([--enable-y2038], [Enable y2038 support]),
+	[case "$enableval" in
+	y | yes)
+		if test "$y2038_affected" = "yes"; then
+			CONFIG_XENO_LIBS_Y2038="$glibc_has_y2038_support"
+		else
+			CONFIG_XENO_LIBS_Y2038=no
+		fi
+		;;
+	*)
+		CONFIG_XENO_LIBS_Y2038=no
+		;;
+	esac])
+AC_MSG_RESULT(${CONFIG_XENO_LIBS_Y2038:-no})
+if test "$CONFIG_XENO_LIBS_Y2038" = "yes"; then
+	AC_DEFINE(CONFIG_XENO_LIBS_Y2038,1,[config])
+	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64"
+	AC_SUBST(CONFIG_XENO_LIBS_Y2038)
+else
+	if test "$y2038_affected" = "yes"; then
+		AC_MSG_WARN([You're affected by the time_t overflow in 2038])
+		if test "$glibc_has_y2038_support" = "yes"; then
+			AC_MSG_WARN([You should consider adding --enable-y2038])
+		else
+			AC_MSG_WARN([glibc has no y2038 support (--enable-y2038 ignored)])
+		fi
+	fi
+fi
+AM_CONDITIONAL(CONFIG_XENO_LIBS_Y2038,[test "$CONFIG_XENO_LIBS_Y2038" = "yes"])
+
+
 dnl Check whether the compiler supports the __thread keyword.
 if test "x$use_tls" != xno; then
 	AC_CACHE_CHECK([for __thread keyword], libc_cv_gcc_tls,
-- 
2.37.1

