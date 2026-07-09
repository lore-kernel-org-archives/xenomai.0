Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9640337BA6
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607734; cv=fail; b=n67er4HbNFhBj+MzM0DTlYv7R6orI2KZgyzB7kaIdNdEXmftjSe8PCYMKCLHhbzWXiWXaRO3idb+f75zKnqoHqvxV1sBiQ21Jwsf+76zOEkrSgqGeSpm5SKrgx6EWvT4Du2Cm2pnvHSgBf84vrHm6ka7qmIDn7JCx/Scgu4Bt9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607734; c=relaxed/simple;
	bh=WUoHrtDUfCouAqyto7q+1ylbSuxd0gM7VUt4h/hbA+k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XlfGCpDLzrHhZtkkdTL0eFQnVBx/dcDRhfy+dw4v6Hub7IBP61FzR6s5ri/2DCfMBDAedG/9rPxkhMUMGq470vg9qcsQeHx+8fn4EnAHhCMRXgrZOhG540ib+wYNq2gOexfEofD+AHVrtQCY4zbarzeFEn5idbOWL6aafGCaZc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=j2hu5Xki; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j2hu5Xki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO3k9z20jbRCBf1agr2/xg9NgR4jGbTEqCtH97pK2nq7WthyfzWNfQs4hjOyJCZqQwi9GQ3d1/nPWSpnQCrL5e+5Yrd3YUHs0NgtzwknINYLa+alkxmH9EywBagwIleNaX5zmi8ChSSZLs+1vWUsBbujsgXOMTdA29GtQC5nX0JS+u60YGBIQtN8ztPJVz02CVz24uWmrdMLIIcnLzA+m/D8+r+WOLWMNTzfP0CuCEYKmXPoF+ClGkf9GuNHaEN1bNvIP4xmqHbxGNUVOKM/dbTOdxY9eHQYlHYHEeZIOIKU2WmjXh1HQBBexF8lq4K5Rdxw0TIRdxS3K/M9CyL4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCwOqoVm6AGGNDiygxOo8zFVPcmqYbFchtKE+K5cwEA=;
 b=RVz0qCda1Wud0RTGlcHUlAreazTVQtS60zWIfVO1lbg0d1p3ZKP1hM+awP11MH2yhQx4yCgjFrgHk98vZ2CVZw1HezPkcux+lwXwbgs8WrZFsbUcuNdlcWc4to7Pw29SPWIM2U/GL9DLcYy5HKPyJFm6oSyAFrgsvrWmJgpUn/H0oHdDYGl8NK6tRBIH75eSnikZS9Zx9qUZEiZDHw6Y8OvJj8+3c5jrQU7vq4PkZxOWKG2CaMFHkbxw/95Nvceq6apAU1A+x2FO1IHq5rkFbTxxHw4VUvwFyKQGN6ZzklA9haQs0X0ZpVDwtull6zpH7RE1J9eZINYzr1snJahftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCwOqoVm6AGGNDiygxOo8zFVPcmqYbFchtKE+K5cwEA=;
 b=j2hu5XkiQ2H0/OkojBSrwyXUCu2wmtf01kjE/RRuzIluz382sDkWPMy6TJhIOMBlmFAtdo5QrNMOnfL3unC3Pa7/EfsVyOMDfVYT+rjV3I95BhqA0d7xqdv0WudAm1YZW6ByOi3WLTxVojctF9bAXWMo/18AyLGPWND8/7voZizWEHpGYt9HgMO/vBk53ctNQu3THv/7cJK6zv2pYgt55PW+qjcvGRAqZ/bigpXsqOVroZvS5x4WbuecvL3H7KUwhjHGfDDSCMgcImBVevlSc/xY5Z2vTIrK5nfuchMSLTOkubyjRdWq3I0Alf1MwNzl2OmV3mZkLEgdLSZnUtCabA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB8222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:35:24 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:35:24 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v2 0/4] evl-test: stress load and latmus integration
Date: Thu,  9 Jul 2026 16:35:12 +0200
Message-ID: <20260709143516.395611-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: f9302e39-c1e3-4dd9-ad54-08deddc75013
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	5aH4v1BKCAjs8BQM3U0Zee7D8PqZ7eyuxLPUR9wid6GdjEqQ2krwl+2KpxJI2oJWJBOS5LczZEt68ry4ZAinYPE9iea21Xp64SLTc31uUtuuASJky9Rw+H5POOYvs9+Z7AxAfG2wG3maotc1GcGkgm8NoBmgo/BnIlJ8+zjeStXriC92QZdyk+V+piKq4wcgBTR7djCcjSCyoGByaGMXJVBqSuHfBe/j0eVTXP7Ox+9GAIDdFNb/RpkzN1+ok/joQWkL15lB2242Mh80ALpJ1vCgSuGqy+z9B5NNhJAFFFCktOdkCUgk1uVUnGrbmkc8T2uevYd3SbXDsGdeu2IH8jn76tgo5Vhai9Qp02cXIOR1E+a7eqmXNttM9NHZnX+5mfzr0BFeh/yvr/sGt1zmJ7/2BGC6oQEwf5C+NpJs7FAlmRtvpqQ3tpUP+tXXhIsSmXUsTvupMQTAjBYpA5lGyHV10xZBNmt3W/dMS9lwP3MfncdvL+x4tyyY3xGrUWmgJUgAzSKnMX9ZJQ4ZfJkA6+8iXaU8aoOJxvUGDR78vxREgiJBrJKLhlVJmc7g+91rzmy5ztC78A3T6Zxzr2eeEnrzXcviUMc/sIFOzxu8+pqpbMehxLsf08ALXPZ/SOGsguFYfKBW3j9oJnI3otDwm1zrf1cXTxU71qoyZDwDnhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/Q9dxv6iZ0XflEvfUJ6RPxVhbJS7gd0IBokvwDSpTuFLM1xnsRC170/13jU?=
 =?us-ascii?Q?c8MTfArF+I4cH84ztuXlixGdOW4zErYqEj4SzgA4eQfzuix+34hwYo+zjY68?=
 =?us-ascii?Q?KYV0nABmH4CRGgCoa0IHuSfOr6rjc5vhIN4h9iR2Q+xU5RwSomr1MIRh/qgt?=
 =?us-ascii?Q?oi6nZUm3mbCEvauNDekVUlxPYQgvjvtZrjYxTMLx9PWZP6sVCYgdNbMsm/+4?=
 =?us-ascii?Q?rmxLQbQ34awYHn9Ci1Qvrvu5QZg5AmNkMclxq/6x071VBnPOnX8DJ/BXQ0Xi?=
 =?us-ascii?Q?wA2j3hl1+nsnMlgKih8uYJ6qg0HKnAxbGFnZINPu/D/jCm9j9AW53YreGPX4?=
 =?us-ascii?Q?h7UG0lSpNOqUZePFP4Xn9yuMdUl329kXyQu1oxjgE+rs7YGPgegEQ1RPU/Sg?=
 =?us-ascii?Q?jn0aBBbEx5Py9yuDoWGd2IHW43SVMUN7mgcRp+4u8YOUU9XjuTQh32Sf7wWn?=
 =?us-ascii?Q?SuJORaMs6hbgJBAFnCwqNUxdcdFfZNHAkI4p4cyVoxLj0cZhtixJAdUSl8Rh?=
 =?us-ascii?Q?D4OXJsukt7qeHqtmYTo+ssd9KROQVKlU501+f7A7T3yV1MBH3AQ1z7SlhYTU?=
 =?us-ascii?Q?HSVzhqEet4H+XeOFvM46VCe2B2Tt2CAItvPKYqPd3cbyxP9RtW/IM/oEl+9N?=
 =?us-ascii?Q?zYBYQfui52i+abDLjRCl5X5ZlXZirwdhr4aLks7UjPGSkbW1LHLCau9aOBTK?=
 =?us-ascii?Q?ooLIXYKy7Oi/eBAGjZC9aVWxD0Hpsl22rCYWKndCi+D/yT4725lwaaJN592L?=
 =?us-ascii?Q?E+g9QSPg4OQPY0zZ/8cjeRUirradsusH2vNIzyVJ0QPLtLRlIecFUOjTFDy0?=
 =?us-ascii?Q?AGFvpgwMlPyn7zzBOeAxFZ1aFnPoM0rV8oHWWLwWIuvgeLv5zCctbSlAuL/E?=
 =?us-ascii?Q?GSLeIFQR+oIoSiIaqvIhuSEWyg/0XTGyQjbvA2b6BgEuHqY5goj19HS6zM3Q?=
 =?us-ascii?Q?QAhbmvDixfl7eGp6I7+h+dl++CBVQZZ7o1wda03avHiOnh7il1OBs+CGa0pN?=
 =?us-ascii?Q?VGWW75Tsj7rPUO2PJg/O1qdZvwNj9+PVZvYTFbimZu1oAiadhNDF9SVucCOE?=
 =?us-ascii?Q?5ajQXx3ypvp9f/rO1q/IP+Omv3REP1B/eKw0YK51mOf67NwWkbaahdWOLnun?=
 =?us-ascii?Q?rdJeArQAeK0BX1izJyVKbW+IIHtbGAHhHtiokV27Lj0e0zwFp462EunsCFKe?=
 =?us-ascii?Q?lRjOohHphC6JL8ygu2B+stJgPCn6Tcdp2vOrowOVOb1ULJ46TFl17Id+qUsW?=
 =?us-ascii?Q?1T2Qc3HxZ7f6IoIeM7GlE92h7xuk3/nlmGuU9LvGYSAyUyC10tUiTnFkO22K?=
 =?us-ascii?Q?khi8aRcNsDsUUt7Q6PseH+JxpYdZ01deqCtECp9BssQo/rbJ9PlkQEC3HeS1?=
 =?us-ascii?Q?8pecNTulJSrtxYHwKSLbmQQYJFY193MUOt0L5UVMdVXH9up+7gPlFWxY5m0B?=
 =?us-ascii?Q?hx5uU5udtfvuLgRMdLemV3aeDJM5+rAIiDej0QvDCwwiQ03lJc7NINFijOvk?=
 =?us-ascii?Q?MOIKxPyhN0/PSn1elLvbim2iP2P4ax3IYCQjS07Xex92cKtsQ7HVWwVafOXw?=
 =?us-ascii?Q?WCvtGZSdul3ZOnPaABNdDnGdr5CRP/2dzYIMV5jjce20fRQTay01d1VY41Jw?=
 =?us-ascii?Q?EwZ/JryvTU7nqnfA2gzyMNjJI7dIvzcnvZatR8Kqb7WOoALjudRHgUaPIaRH?=
 =?us-ascii?Q?L6KocdQEBVkf2EwRg8GUzNfCgkzwp+QJPnWimeH2hwkToA4umr4g7nkIfVN1?=
 =?us-ascii?Q?YCr6uKUZjybDu2YtiF7j/2Da8GobOxE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9302e39-c1e3-4dd9-ad54-08deddc75013
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:35:24.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4Oa7zBPRBkUxlfVpbjl2dw3nJ39c86RFTVoYbnwJEGty6tFGS8/N8eatf9hwtMPSldVdSbOlEqbw3hKLOUPq89GbDAFJtloEeZIT+XPOS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8222

Extend evl-test to exercise the system while the tests run and to
measure latency at the end of a session.

The motivation is to allow running the suite under stress in CI to
surface bugs that only show up under load.
latmus run under that same load and with a latency threshold will allow
the pipeline to spot latency regressions.

Example:

  # run latmus under CPU/memory stress, fail above 200us,
  # keep the latmus report
  evl test --stress-cmd "stress-ng --cpu 4 --vm 2 --vm-bytes 1G" \
           latmus -- -T 60 -A 200

Changes since v1:
 * Introduce a small shell script wrapper in the test dir to add latmus
   to the testsuite instead of calling it in the end after the other tests.

Tobias Schaffner (4):
  evl-test: add stress command support for background load testing
  evl-test: improve help message with detailed usage information
  latmus: send setup messages to stdout instead of stderr
  tests: Add latmus wrapper script for evl-test integration

 latmus/latmus.c   |  4 ++--
 tests/latmus      | 16 +++++++++++++
 tests/meson.build | 11 +++++++++
 utils/evl-test    | 57 ++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 3 deletions(-)
 create mode 100755 tests/latmus

-- 
2.43.0

