Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E338E122
	for <xenomai@lists.linux.dev>; Mon, 16 Mar 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691906; cv=fail; b=irlbYfMi+rSwCPq7ksM9igR7nedWSrMDslLRxd+lagOiRX3rKyvT6uQGZDCXle9A9ee0L1GvSsokD5nhca+/6PKhKNhwaXco81YASYJ++6DaT+3JyH/yhZD0RNfhzYsArTbG3UG32PQLCkJnTo+Y5Gp6PC0hYPl0TWA7K/eoN8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691906; c=relaxed/simple;
	bh=5PO1g2drCwD10SgAbmbUDjudN/G3W1PgiIikfI/2b6c=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=nc3s2s362g6nWxhO95elPesc5Hh62Owm40pJmH4fcenoFsKyMm+rreO+XJjvFTy9drhH+oCF1uSiM7w+IJ05wRUDXxaAVssODhN03+dv7eExjtbtENomc6g53KuOMEKit1Eql8bwel529++Hy0hH8l05hojUm/XeNRgmunaGTR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rsFfuFur; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rsFfuFur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIsebMcP06wo1UonZov5EygDjm1+0x4s6eOQzRu2M5H9yM4qzlTqYaTsIId9NEIDhnwqiemvHZcDPt2a7qdGZ2iBhbJq0Z7qqAVK+qZXmgoBVSzO8HFZSuf32Rvm13RkG+cs56G+y0o0AoanyYJuH/gKSccJyZFaHWv/EGXPx6mRV9JSo2m/qyg9Clg99eHcF+gTkM9WkwLsn38tR3mVrChA+us2nAYpgbEuag/zsRtni0X0N3w8CfjRQGN+P2zbSVbD5u4ZORDJ9jfAG2JRIO5yloCUsb2t9GiWfZpdwRJNvLBH4TndK487z/xdiB68KK5Pb5g7CU9mDrLBtge12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ljAjMu6vsPJ/XbqaNG7FlBgi62ZrRgunF2yZanmM24=;
 b=vHMJjlNmHa8nbtKpjfRaTtsiCgO6f6NLwwPUbVjtGH0Ov8mTmSq1o6XtpnbD2eIsQANhQc0Jxc3iokrOjQEpYFgwXlmJwt3p6K+21n7gNCUNU3BkVss2ngF0hDn2SlcIXEiyhR5bklIKjEKCU6ZYsuPEkLvIBpAYNnVSFig6g4COom3/ZRsg0uoPNzjymC+0yPl5gx5aI11X+jFrci/QNvDOOBtVIJUhCzdBuYTEI/OtFQrXrvRKXnZUORWmAlyjIGBxmQ9Cn1eAJOHi/YWK/kHvNOHdwGopxg5aYrj8dYJoTY7wULmyKQ+79lcepHKOcZzC5vF+V41Yc+2hayLobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ljAjMu6vsPJ/XbqaNG7FlBgi62ZrRgunF2yZanmM24=;
 b=rsFfuFurmdDBVsxQ45EDjjKSz+T+L4IxmgAo5mxwJubVz0qME2VNmtGthyT84W5+EEhSIUu8RzFQpSEsmBZNOBEOjVrkVuDedMe7kSZveGTuajASMRa6qQk5t0LdDVgmuzigrNgH5VAh1tol5ZcAerGhXzM/CaaxBt4dRmsEmcqyW1jg4pEAcxBeR48GcJtGESXtbgFrtZwEpXF8l77ktofFjNV6MbW0zt0Jw2vC3+DBrifLgw68W7KuWwigXZM4xSrDyZTRHTJ1z0dYDltR5zvBh3+s9YcrITUroLER0C+iiR4LKGYgLzsHpX6fuw23CQmAqZDnc/TFtYET6VvB+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 20:11:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 20:11:41 +0000
Message-ID: <7dacbe26-51f4-4c44-bde7-540b3a57e786@siemens.com>
Date: Mon, 16 Mar 2026 21:11:41 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v4] lib/cobalt: Avoid making mmap offset argument
 unconditionally 64-bit
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 785eac9a-f754-461a-6402-08de83983d08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	vP3kzIjmVy3iBM4hm3zADouUymwNEHGRBN61YoDXMrwQMlCKWbsS24tgxxLJyV9VKmtb2egYqAshAKgl9CltNNgR5WuW7NZuFcSVxvY1a4YMuqqBC9Seg1276sPm3I/QLLmd3zHhZ6uShUbRrfN5ENnp+FYwUNg9PxQfPlNTYZqJ0Hxjufd1JQXIGTG2VIRkvr696thCBOe4o8bnLFli1rKDoJ8sw0KwyH7DQrw2NFX0wgMKrndWQlp0LwWtcHs94YbUfjnAevYCyMRIUmbMMsVU4LVVGN7ay9gjwhUmFM44dem2ws+ZctMbDi5KKStQ/QZe0MKY4p+A5dh44l81goXgxEicL6A0S9SGok0OBpbVb+Et5U7NjlInmE//s4qHAu+gRI2fG1Liuhql8IcyhQxN1bC6daiwmqRM4ocVViktPQsjw7ng0a55OCKI0CLAqHmBxxWxYVBanzhGFLIQWwt3SNUlidxuKU56ikD33lyrfkUOWlqskuXnvYPJXYQF7kGlSDv+71etV7FsL/G6uI+z1ZzaOY+16opNtmOnKrt7TXS6132TiMC8pgBSSvnDPFJOwb1f+wmFCTUQ8ovqfzgTAlCPcm3dnyp82FjL8WGWYVdqS87SnProylCAMwxkfnUx3KAMjZLCySbL3fAjOdkf51y4qwd+hmkwYfaL9a7XlKKTn266gvuvNPZPTJfiCjYxB2B8bgln4z+qylOEryFD/xCAETKFDa3zW9y0eE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEJERndTdFVvQnZ0OVlTOXJxMzFxZGdmR3RwTGsweEd2eC9SL3FFZWJuNk5W?=
 =?utf-8?B?YXFUNkxSMUcvSzFkcHhSenI4K1M0OC9uUk05bmJtS3RqdTRTMUR2Znk4cTk5?=
 =?utf-8?B?OHROYmw4VUlhWm1qQUpOeWkzZk9IWEcrbkIwZHhOSVNPenkvdmZWVW9MZEdo?=
 =?utf-8?B?dHl6amZYVHhiOHY3OW11ZXF3WkU1QThnYWxkNmRabm5ZZ1N3Mml6QytyblhG?=
 =?utf-8?B?NlJnTDhicm5EVktubktIUlhDeWwxc3lWaCtxWjZHUjI1QlpSaVNhK2luSUxQ?=
 =?utf-8?B?enBGUGFxMVE1YnowQjBqU0swc3k1N0N5bUVsWXJvc01tenNjTG5ZbnhPQVRX?=
 =?utf-8?B?cjl5ekFmZS9nL1dadGVZNDFBU1JrK3N4bEVZWnB2WHhsVlRkSEVtU1VZaldx?=
 =?utf-8?B?Y2xVdWJRR0E3R0pyYVpKa1R0MHdmOXh5THJHcThScDh0RjQraUFjTTFvVGVx?=
 =?utf-8?B?VEpYRktjTjIvQVRKMjBoTEVxNVNUNXBFOUw4cThROFkvbnh1dFJaRE9Vb280?=
 =?utf-8?B?aWR2em9PK2E3S0tKazB3QjlHZzZldENLT0JuSE91bGRsRFRIR1UxWHhpYjVj?=
 =?utf-8?B?Q1lWUGtVZnRvallJTVRmZ0dTTWx4b0crWXlUVUJjdmtsV2dtNjYrVGsvb3RF?=
 =?utf-8?B?S2VNQ0VEd1BvWDFudWhVcVpZdlZFVXk4eGxFclUvUkpQY0ZHZ2k0Ry95dG1p?=
 =?utf-8?B?a1puN0pYVG5kUXdyZXByMHFIZWNZWHVYdFdkRW5JdkFlYjZRS3kzWkx6OWFq?=
 =?utf-8?B?SUJyNXIvQlo3T1g0dmdGLzROV1ZKUXNSRUMxNVdVUzNJY2dhUGJvOUozNHIx?=
 =?utf-8?B?cXo4SVFIT05MbnRsek5GM01SN3F6d05LNytIbml0WmF4MlNjVUZNL1dZYkhW?=
 =?utf-8?B?WUJnempmY0tsL0pVWEtRaEpralhCWmlPTUNETG9EQkZYb0dvY3d1VXZxNHhl?=
 =?utf-8?B?RDBiZ2x0dy9EZWVWeGdFWXRzY1FHRkgza3MzeXJ0MjdPWlRuUG1UNy9McHNM?=
 =?utf-8?B?ZmptaVdRRGY2b01XeFdSTXlCUGMyRiswM2kwU21jSWtPWStRMlIwOERHVkR2?=
 =?utf-8?B?WVFEUFgvOGRxK3ArRFhqY09rc1JKYVVBYnpSVUV0ZEFWSGJ1VGtpbkFpcWla?=
 =?utf-8?B?MnE0V0htNzBCWGhIRGdiYnZhM0I4blE0Yi9MdDc5UmdqOXZ6Um1pSmUwOFVV?=
 =?utf-8?B?T1RQcXBIRDlPK2ZCUm9vQzF1b2MyM1MvMkdUMG4zeXVTajgvNVpBYnlOVG84?=
 =?utf-8?B?a0hTQ0o0b3AzVmFGTUs5YkRQQTBQZDVzNlVHUG84NEFnQ0lMdVpzQVRkWm1R?=
 =?utf-8?B?WU5UbytkVWpiNWd0MWdiaEppOUN3T3F4djN6V0NPQytaNEpiZW5FdC9hSUp2?=
 =?utf-8?B?dHY0Z3pTMWpmb01HdWY0THQwZlN1U21IdHpQSVZyYnd2MzdXd2Z5VGxoMzZ4?=
 =?utf-8?B?Mm5qNC9kZUwrbXVueWdnVUszZUFVaXplUzlNOFgxUGRDV3dOZlN0bS9JZVdD?=
 =?utf-8?B?eit6NVZ4Wnhsb0VmVzZlckZmK1p4aFFLVkhYazN4WG5Ua0U2L2x6Nmo2aGJR?=
 =?utf-8?B?NXBlTjhLdHMzczdCYW51Qk0rWGlZUEI0WE9xQjBwZVRJQXZKVmlwbjQzWGVN?=
 =?utf-8?B?elJmZVgvRHR2Y0cvK2xHNHRJTGFwVnlyODc2UExjQjJtRDRTNVhVL09lbWc3?=
 =?utf-8?B?MnEzT2I0a2tONHN1WEM2TDg1VStMeTA1Q3VmQ0R2YS9yeVNoQW9OclF1UDRF?=
 =?utf-8?B?TG1Yc0RmbU4xem5tdVNPNWVTclMrUkgwQ0FWMWh0dFpyUTU3d3lCbndoM2lT?=
 =?utf-8?B?VTZJd2l6Tmt0Wi9YVTROYjc1cFIyZk5JN3VUR05RSlFPR0JLVmU1cHYxQUlX?=
 =?utf-8?B?dFNDMWVtVk5XWFNsV2NmQXJxNDE4RWpJVXZZSCtaTEVrTHRvbWgxaENtS1JT?=
 =?utf-8?B?TFEvWUp3bWFhdVBuQ1A5N1F2aXJHRkRQeUJCdkFqZVVtVmI3bndLMTh5SUhE?=
 =?utf-8?B?dTJwODdCb01JNDRmbVVlcEZINnV5dnRmU25pSXVLd3JuN2MyQTZUSjJyZytm?=
 =?utf-8?B?L1QvL2RiOVhiWkJEQlJHREJXMXFrYS9vSDBYdERtUGN4a0Jya2ZCUUFselF3?=
 =?utf-8?B?dEw5bmJsdW1saHZYMm5aaEE4NjF6NzZJVDcrQVlBSGhQSVBvTy8vY053UHN6?=
 =?utf-8?B?eVVRcHhWTEFwRFV2cU51MU5pQjdaWTVoTzhXZGxBYjhqZE5xMlp1UnF6cnRu?=
 =?utf-8?B?bHhldWRMcHZPcEROUi9BKzk3MFFHYWw4eW1JQWk3UW53TUhiRlFlZEo3V1Bl?=
 =?utf-8?B?S2dsa3N0RFJRNzRTQ1Boc3RDbENhUXRKQ3hSdkZKT3Q4SkhSMnJDdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785eac9a-f754-461a-6402-08de83983d08
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:11:41.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j05ONH1mL7q/x3EUftYqBYWwMXvMWSaUPgn4z3SmFpbNSz5DJ+0moccaXezUe6ldrKBi6azStj40CG7IU48c2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7989

From: Jan Kiszka <jan.kiszka@siemens.com>

When _FILE_OFFSET_BITS is 64, mmap is handled by the mmap64 symbol of
glibc. The original mmap continues to expect native off_t size, i.e.
32 bits on 32-bit archs.

While we require applications to be rebuilt with the same settings
Xenomai was built with as well (either both _TIME_BITS and
_FILE_OFFSET_BITS set to 64 or both left unset) which practically
shadows this issue, it remains wrong to change the wrapped mmap function
in a way that is incompatible with glibc.

To avoid running into conflicts between enabling and disabling
_TIME_BITS=64 and, thus, also _FILE_OFFSET_BITS=64, factor out the
affected mmap wrappers as well as their __real stubs into a separate
code module.

There is one catch: The cobalt-call to mmap in umm.c needs to be forced
to mmap64 to become agnostic to _FILE_OFFSET_BITS used by the cobalt
core internally.

Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disable-y2038")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v4:
 - renamed to libcobaltnativeoff in Makefile to align with nativetime
   patches

 lib/cobalt/Makefile.am | 15 ++++++++
 lib/cobalt/mmap.c      | 79 ++++++++++++++++++++++++++++++++++++++++++
 lib/cobalt/rtdm.c      | 38 --------------------
 lib/cobalt/umm.c       |  4 +--
 lib/cobalt/wrappers.c  | 17 ---------
 5 files changed, 96 insertions(+), 57 deletions(-)
 create mode 100644 lib/cobalt/mmap.c

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 4318adf185..b5b184b555 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -7,9 +7,12 @@ noinst_HEADERS =	\
 
 lib_LTLIBRARIES = libcobalt.la libmodechk.la
 
+noinst_LTLIBRARIES = libcobaltnativeoff.la
+
 libcobalt_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 2:0:0 -lpthread -lrt
 
 libcobalt_la_LIBADD = \
+	libcobaltnativeoff.la			\
 	arch/@XENO_TARGET_ARCH@/libarch.la	\
 	../boilerplate/libboilerplate.la
 
@@ -43,6 +46,18 @@ libcobalt_la_CPPFLAGS =			\
 	-I$(top_srcdir)/include/cobalt	\
 	-I$(top_srcdir)/include
 
+# source files that require native off_t size
+libcobaltnativeoff_la_SOURCES =	\
+	mmap.c
+
+libcobaltnativeoff_la_LDFLAGS = @XENO_LIB_LDFLAGS@
+
+libcobaltnativeoff_la_CPPFLAGS =	\
+	@XENO_COBALT_CFLAGS@		\
+	-I$(top_srcdir)/include/cobalt	\
+	-I$(top_srcdir)/include		\
+	-U_TIME_BITS -U_FILE_OFFSET_BITS
+
 libmodechk_la_LIBADD = libcobalt.la
 
 libmodechk_la_SOURCES =	\
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
new file mode 100644
index 0000000000..069163a855
--- /dev/null
+++ b/lib/cobalt/mmap.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka@web.de>.
+ * Copyright (C) 2005 Heikki Lindholm <holindho@cs.helsinki.fi>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+  USA.
+ */
+
+#include <sys/mman.h>
+#include <rtdm/rtdm.h>
+#include <cobalt/uapi/syscall.h>
+#include <asm/xenomai/syscall.h>
+
+COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
+			     int fd, off64_t offset))
+{
+	struct _rtdm_mmap_request rma;
+	int ret;
+
+	if (fd < 0) /* We don't do anonymous mappings. */
+		goto regular;
+
+	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
+	rma.length = length;
+	rma.offset = offset;
+	rma.prot = prot;
+	rma.flags = flags;
+
+	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
+	if (ret != -EADV && ret != -ENOSYS) {
+		if (ret) {
+			errno = -ret;
+			return MAP_FAILED;
+		}
+
+		return addr;
+	}
+
+regular:
+#if mmap64 == mmap
+	return __STD(mmap(addr, length, prot, flags, fd, offset));
+#else
+	return __STD(mmap64(addr, length, prot, flags, fd, offset));
+#endif
+}
+
+COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
+			   int fd, off_t offset))
+{
+	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
+}
+
+__weak
+void *__real_mmap(void *addr, size_t length, int prot, int flags,
+		  int fd, off_t offset)
+{
+	return mmap(addr, length, prot, flags, fd, offset);
+}
+
+#if mmap64 != mmap
+__weak
+void *__real_mmap64(void *addr, size_t length, int prot, int flags,
+		  int fd, off64_t offset)
+{
+	return mmap64(addr, length, prot, flags, fd, offset);
+}
+#endif
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 00c1aaf4b2..119ba3f83d 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -541,41 +541,3 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
 
 	return __STD(shutdown(fd, how));
 }
-
-COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
-			     int fd, off64_t offset))
-{
-	struct _rtdm_mmap_request rma;
-	int ret;
-
-	if (fd < 0) /* We don't do anonymous mappings. */
-		goto regular;
-
-	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
-	rma.length = length;
-	rma.offset = offset;
-	rma.prot = prot;
-	rma.flags = flags;
-
-	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
-	if (ret != -EADV && ret != -ENOSYS) {
-		ret = set_errno(ret);
-		if (ret)
-			return MAP_FAILED;
-
-		return addr;
-	}
-
-regular:
-#if mmap64 == mmap
-	return __STD(mmap(addr, length, prot, flags, fd, offset));
-#else
-	return __STD(mmap64(addr, length, prot, flags, fd, offset));
-#endif
-}
-
-COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
-			   int fd, off_t offset))
-{
-	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
-}
diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index c0d4489d34..6b4303b727 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -58,8 +58,8 @@ static void *__map_umm(const char *name, uint32_t *size_r)
 		return MAP_FAILED;
 	}
 
-	addr = __RT(mmap(NULL, statbuf.size, PROT_READ|PROT_WRITE,
-			 MAP_SHARED, fd, 0));
+	addr = __RT(mmap64(NULL, statbuf.size, PROT_READ|PROT_WRITE,
+			   MAP_SHARED, fd, 0));
 	__RT(close(fd));
 
 	*size_r = statbuf.size;
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 18c237734f..3a0063f051 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -28,7 +28,6 @@
 #include <sys/select.h>
 #include <sys/socket.h>
 #include <sys/time.h>
-#include <sys/mman.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -384,22 +383,6 @@ int __real_select (int __nfds, fd_set *__restrict __readfds,
 	return select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
 }
 
-__weak
-void *__real_mmap(void *addr, size_t length, int prot, int flags,
-		  int fd, off_t offset)
-{
-	return mmap(addr, length, prot, flags, fd, offset);
-}
-
-#if mmap64 != mmap
-__weak
-void *__real_mmap64(void *addr, size_t length, int prot, int flags,
-		  int fd, off64_t offset)
-{
-	return mmap64(addr, length, prot, flags, fd, offset);
-}
-#endif
-
 __weak
 int __real_vfprintf(FILE *stream, const char *fmt, va_list args)
 {
-- 
2.47.3
