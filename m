Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787234;
	b=u8fpjrIPUU5fCN/bL6RA4SKeXnUbZDTzGsdjkE9z5oA7TimlCTv7UTesON8Xv/7j/neE
	 EfQlHa5zL43ekhwU0+BTMaO0b8TWE3+1LtBNFJsJvgB4wu0qVDQabYUSLnH19VeubCKMB
	 KprVGZClrRCHz3VognB0oBLhShBoMMvnvp7nZNQjBY70LKVTvefC//4v7tmJDcizuq6mm
	 4hQgjCKW2NSh7VDGIdSRrnHqiAPs9IDnv3jHwa2QpBWz/y54Jb1RVlbMpukz8OhuNzJgH
	 HvrWNE3uhEXJI9vw4/VbX6SJhQWVlUV/1Vi/zZR6MXonYBn6F5XrPHYTXDHPuGm9ebg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787234;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6jl/QOH6O8oMDdfEKwgof7vo8VIxMWwViSmA+7vP4bs=;
	b=DoEY+3PWD8HBk6eCoB1e3urklIOvfzY9dakWFA17sTjqXiGD7pCgM/7jmf39k2yvrsYo
	 Hfns2ssbbRCV2q4j4jvquQ9MkIFdK+LL1k/ZB29F5nOU82HkvFQrS59XcCcWral9U83+2
	 omnsQ/jYYVYxeG2VDuzr5gkQHbcD/JrafPqpyqXkzbFFhHk2oCz0L986wx0Auyhp1PrDm
	 yahs5RG2GsRlClcqYx7rX872sq6BFJcdCvrOx/j83lgNQyxWKo+a3zwBb7d1z48HCsNOm
	 JYK9lkVJDzENiOXo+1E9EhPOvFra9cFBqShlrG+TgQITINpSA5BMitTQ6wJ1ZUY6PpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=GzM9suFu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99D606A31C
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C99D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=GzM9suFu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmQ6G8O3E5jwDAol1F6DdsHOQQe6QQGQz38vT7UFlSZfi9fcIFQhR6xn13BzEUU/glRA5/vKsQGMtXzIB8Enpoz5SiHRrMrJMf9LvpKov39/pkfaE3EMEulXR4+MMvV/g8Jn8MkNNLKA5xQQitIViVOEleNjj1GJTt35Q0MrOsjchrKC2sbbnrfU+HJ5u2/+BFUTSsiqklNIoaL9imcYvgLY1tiFR9rJVBtte2NsIgw2AgVM3RUo6tT7ip1xlihLY09iAVa/9hKpDF1ZUDaPY3SzbxQeaMwym/+NejVBuNX3NKgwCufJyoNMUcwK/IB+GS2fqMn3S39xY52IvsHzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jl/QOH6O8oMDdfEKwgof7vo8VIxMWwViSmA+7vP4bs=;
 b=DJb9oJT1K2ZX5Qovk1V55nVSHFHMg+NNliRTMGnOd4j8jqbzic7tb4XrWJKvXxtxj2xOJYEyQlghf9mTjk6S8oIaOtZwmUm1gNMxgE+Qy48e/pLmfeIVfnzc1aGDqvew+HbqwhEVcuo0wsvBp7JcZqhIgBStXO4puLk+EsLnFRVa7vAfMTjjwS0Q93vgamPOf3X/3T4Fwfaf5bNBwduC+6YXa9jbeiOCbsKI2ot9rhzLbDQnXA83M5A2z0Kl1BRoaiSIBSolV0RezaXen//vIQpfJUtTGVZjFoU4EjInhFfW97vsZqaQl+4n9j+nlmu6AAymJs6E7rzkZpvFLbHlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jl/QOH6O8oMDdfEKwgof7vo8VIxMWwViSmA+7vP4bs=;
 b=GzM9suFuG2WvcYcjRk9sAFRAVuflqFptYWk2aDldgQgvYaZuvzFau92ERSMuvLhLSTF3G32nSg6GjCG7rvQVxRlOt6HDPaNGFeLEOCJcozPlubJiaBxsoeqSO3vD2LgmiieB58oaNSLtwckOk6c4lyldg40OkVJURtfLhZGLdMk9P5TiBfICvELbAjv1OGaqWfJpHreWzhndM2DZVRIv5zsLChkj5FIvfxa/fyQPQIz+BCpXs70ZCYYv2SKsdQCG/99wfP2i8FtmRALf4yJA7p2sa9xryyRrOAx/nfcAbJGGFoppxFgIqgKfPvPICeFf+FaWX8Q2bBqTS+7wVOTolQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA3PR10MB9260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 27 Nov
 2026 13:47:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 13:47:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail v2 3/7] rv: add dovetail container and offstage monitor
Date: Fri, 27 Nov 2026 14:47:21 +0100
Message-ID: <cf0b29f72d0a880a8aef58072d2747e8e0ad1cbd.1795786695.git.tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795786695.git.tobias.schaffner@siemens.com>
References: <cover.1795786695.git.tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA3PR10MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f8f278-c093-409f-58a2-08df4c8cedee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|366016|22082099003|6133799003|55112099003|18002099003|261021123027099003|56012099006|261021121427099003|261022105027099003|11063799006|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261009223027099003|261009221227099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	cUsNbGgv68k8cc35uVdG0lnMx4pbfSmPm9xmQPs4pyeNs9AfkitQigCUVHLAFQCaVz1I7QP/ujsiwuQ5mirOce6NRtPLAeRmiwupfcaQsARUQpwethK2U8i16WrNeORbP0D92QIxO5ix1nypZ9CfchRWuRjl4FAf6gV7qfnulp4UMeRI03Si1QZbXt8a8FQlemfD1R/vtleoSO6b/SgGbjfDDYZ3jHKZegD9Ya5Y8SQhcZYQx/fcxt1Ypa/WqtbcJtnYH+fASUqSNY/yL6ar53WjbJoeRzT49amX6DF/YfT/Cf2x53f9G5Pfv7YoGMf9pjhfHM8Y29alSPTj6q2mwpIPzkm+Ww6MBFnXh+fp6EKZWoJJOpnp5yrSWpzgI64HfybZ+QapSpsQAyYFjYLfpQAowVNhUHGpBjL71huAp5SIsOcKxRANyHsD1yfdishlln2csA5YIzlOssb3+VpoR4+508y83/2WZhaNy1zGL8cw3gUuiT0zbv4dTX6tJRH0+ckIW6gsa+edW84BxGaDIXZ/vR397y8qN9xMbhIF4d0QLZJTuz+DSFC+WvsFoJfOY1mMNRk1MtXR0hgJDuW9b6JCnM7YWqGiSs/vd3xbNiNMUjOjWLQyrXzR9C1IVfP+hi6QtCbfGdUzGAvQVXYkfnBbby3mfB2f8U19aq2T02A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(22082099003)(6133799003)(55112099003)(18002099003)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261009223027099003)(261009221227099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4duYKtWWSF55khgDIbps+hr/moWYGXkV7ivwsFrkNlJKeOMe46V6T4sczcN?=
 =?us-ascii?Q?0pmPyh56uQV5u4Bz3WttCQhZO2ajjCzG0RoJjnGK2T7WXs1PvK3qOiLudKJs?=
 =?us-ascii?Q?LV66REMAXPAd4sYixQHcgkfeXnkyOJ/24ip3duXh/XpfkoQRcKvmkLgVdVb5?=
 =?us-ascii?Q?BchSnymXBSS9oCcXJEGP0lkUkjEB0jMet5iRW1pOKY9rPOMkZzTExyR5pVp7?=
 =?us-ascii?Q?1paqauhTdJwzFV6Ng7oiW+bTvSyLLQCbdk8KeoWhIVrcma6a8lu6WNM0rz2c?=
 =?us-ascii?Q?15H9Sghbl3KYETKlcUkVNySUowsBOYBm30fo/erpjisIUQ2NTZZQVcqW+nf+?=
 =?us-ascii?Q?Ico6nYQX4kwUdQcvUviA/S+jkg3tsKVL1QuimFAkSXB1wfv3GGaOofODV63S?=
 =?us-ascii?Q?tdaGZPhLRpA8RB8n55T+FROMQ+hXrW/BIHAbKHP7sXttczfJJM1iBZipNg28?=
 =?us-ascii?Q?3mwwHb82svqzBWQBEHEXYOqbjPewcN4Ka2q7A6P3FDeDR+miYMRmjcy5ZZv6?=
 =?us-ascii?Q?dvlHgGbD32+kvn4UXKdNMrd+5rpTCXq8i3koC7RQ379e/PKs1ci9BZqkOA93?=
 =?us-ascii?Q?KEleDQvcmB3QgzexYNBEac1rQt6O32vDQec4fEGq64csvWqi9JsHUl2J2qFH?=
 =?us-ascii?Q?R+UXN9EeG1nK8VvVyuOLrEU3l/n7ec7XJqJ6mnvX7YSRDsZg84rcXdYYI32u?=
 =?us-ascii?Q?G+vnbrLS2T4lKSVjX+g4yo3ktM9lDY0513CR1VNkkA41fA/cDq+I+VG8mD5S?=
 =?us-ascii?Q?5uwmRTDYuitW8Ienfhxf22Q2x7V0cTWaRvHVbzTsBM2611GEeP6NeLg7YpWz?=
 =?us-ascii?Q?cgjlpy9yKK0YxFB+TM/FxIwJMMv1SZGWxQxMxlwxcVev6hdMf8ACHvMTxf8c?=
 =?us-ascii?Q?JI7ml4aGazlXKcl7I5zEj9rhxYZznQ0+4LMHxWjWmbcfIoN5oHJUQSEthsYW?=
 =?us-ascii?Q?Orn+t4ff5e1hDg6KLY2qRywvhL4ZldJ792D2kMnOGwB0JGdzor/FG3tpsb86?=
 =?us-ascii?Q?LnZq3X8LmPhzSdaC+1GssqM3ICf7F0O71GxKeOvl3k4bHCFSTV++ZKbhHucX?=
 =?us-ascii?Q?X43hsvO4LSzG4Q+yDiR7nqhfOSGEFNR2V7+OQvENRxCuMl6JgWU7iImDWmrw?=
 =?us-ascii?Q?FR/SVIx9//0BILuBlF0blWFS9/Fepr17cMsyxkXeKjLIOJX755VYcdzDdkfM?=
 =?us-ascii?Q?e2t8MmuFZwz0c4nauur20j9/BLN5VthZDmhz0OMyTqD9TmAFPszX4seVGVK8?=
 =?us-ascii?Q?9gZqGdwaxqkSLmoQY93u/QNNiGCXZTC3oyWiPxx4CvRaUEjfwND1n3hgxlnR?=
 =?us-ascii?Q?JSxdh9g7k+Sfi+AZN1t4jV2Ntnr+mZ9PF5nXKzF4nW029fy3apnhUHDrxPcO?=
 =?us-ascii?Q?nd+0PK2QKWfqBUAbEWxM5XZP8DcD8y2Y6Y0k1vL6GLZwxSqXZysn4kK3ndsv?=
 =?us-ascii?Q?0sGEKH5Kfjpvze+UWGUYFDRhn0swD6GYEWHfTtw49FBtP8N8zb8LJE/y0xa/?=
 =?us-ascii?Q?tDu1bJbYSZxrAuNkIStEgD7rhbDqTUEUkf99r7fUK5W59SU+vwym2R//fGFe?=
 =?us-ascii?Q?+Izo8yBakmiO6hvzoxCkevJUHNNxfQXI/0RqElD4KjILh9W+W6mUkcNWwX6o?=
 =?us-ascii?Q?2U7rPNBQZ9NsL0NLBbllwj+ypWCop0Xu+cRpATuD1V81CNfyJlwAPFJ9dcob?=
 =?us-ascii?Q?/yqU1x9wHaZwtr6ly1mFNJ96Cwo4vdkMQwyczWn+pdRiwECslW4V8A2rmi8o?=
 =?us-ascii?Q?GJFsCpXKbXXKN6BdFssIOo64DO5vEm35I5IA7BMYwRNW553QA/kKyaEcHnyA?=
X-MS-Exchange-AntiSpam-MessageData-1: CKx9BX+D8+k75TtsLmRr24h8vYfLvjD21Fk=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f8f278-c093-409f-58a2-08df4c8cedee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:08.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65Q6lrst/L0SUPdkY+XhYMR5pw5ypHIgQ8RjUftsdlr5g7SxmQJu38hZSnxWRUP+JRG8rZJ1ZrQnvS9iFzUiSRci0NypERerWV0w2PsKk8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

Add a container for monitors verifying the interaction between Dovetail
and the companion core, and CONFIG_RV_DOVETAIL to enable it with RV.

Add the offstage monitor checking that Linux neither schedules a task
nor lets it signal itself while it runs out-of-band.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_dovetail.rst   |  64 ++++++++++
 kernel/Kconfig.dovetail                       |  14 +++
 kernel/trace/rv/Kconfig                       |   3 +
 kernel/trace/rv/Makefile                      |   2 +
 kernel/trace/rv/monitors/dovetail/Kconfig     |  13 ++
 kernel/trace/rv/monitors/dovetail/dovetail.c  |  41 +++++++
 kernel/trace/rv/monitors/dovetail/dovetail.h  |   3 +
 kernel/trace/rv/monitors/offstage/Kconfig     |  15 +++
 kernel/trace/rv/monitors/offstage/offstage.c  | 114 ++++++++++++++++++
 kernel/trace/rv/monitors/offstage/offstage.h  |  61 ++++++++++
 .../rv/monitors/offstage/offstage_trace.h     |  15 +++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/offstage.dot        |  14 +++
 14 files changed, 361 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_dovetail.rst
 create mode 100644 kernel/trace/rv/monitors/dovetail/Kconfig
 create mode 100644 kernel/trace/rv/monitors/dovetail/dovetail.c
 create mode 100644 kernel/trace/rv/monitors/dovetail/dovetail.h
 create mode 100644 kernel/trace/rv/monitors/offstage/Kconfig
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage.c
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage.h
 create mode 100644 kernel/trace/rv/monitors/offstage/offstage_trace.h
 create mode 100644 tools/verification/models/offstage.dot

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 29769f06bb0f..8e2b4a270670 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -14,6 +14,7 @@ Runtime Verification
    da_monitor_instrumentation.rst
    monitor_wip.rst
    monitor_wwnr.rst
+   monitor_dovetail.rst
    monitor_sched.rst
    monitor_rtapp.rst
    monitor_stall.rst
diff --git a/Documentation/trace/rv/monitor_dovetail.rst b/Documentation/trace/rv/monitor_dovetail.rst
new file mode 100644
index 000000000000..e46cd0ab0b8d
--- /dev/null
+++ b/Documentation/trace/rv/monitor_dovetail.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Dovetail monitors
+=================
+
+- Name: dovetail
+- Type: container for multiple monitors
+- Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+
+Description
+-----------
+
+Dovetail runs a task either on the in-band stage, scheduled by Linux, or on
+the out-of-band stage, scheduled by a companion core. The monitors in this
+container check the contract between Dovetail and the companion core. They
+are per-task monitors fed by Dovetail and generic tracepoints only, meant for
+validation: while enabled, they add work to out-of-band hot paths.
+``CONFIG_RV_DOVETAIL`` enables them with RV and the printk reactor.
+
+The Dovetail tracepoints fire in the context given here, so their probes must
+be safe there:
+
+==========================  ======  ============================================
+Tracepoint                  Stage   Context
+==========================  ======  ============================================
+dovetail_leave_inband_tp    oob     after a successful switch; oob stage
+                                    stalled, hard IRQs off, the core may hold
+                                    its runqueue lock
+dovetail_leave_oob_tp       oob     before the switch to in-band, in the core
+==========================  ======  ============================================
+
+Monitor offstage
+++++++++++++++++
+
+Linux leaves a task alone while it runs out-of-band: it neither schedules
+it nor runs signal code for it, as a trap handler raising a signal before
+the companion core demoted the task would::
+
+                 sched_in
+                 signal_self    leave_inband
+                  +--+  ----------------> +-----+
+                  |  v                    |     |
+                 +--------+               | oob |
+                 | inband |               |     |
+                 +--------+ <------------ +-----+
+                              leave_oob
+
+``sched_in`` is a ``sched_switch`` to the task, ``signal_self`` a
+``signal_generate`` by the task for itself.
+
+Usage
+-----
+
+::
+
+  # cd /sys/kernel/tracing/rv
+  # echo printk > monitors/dovetail/reactors
+  # echo 1 > monitors/dovetail/enable
+  # cat enabled_monitors
+  dovetail
+  dovetail:offstage
+
+Violations are reported by the selected reactor and as ``error_*`` events in
+``events/rv``. The models are in ``tools/verification/models/``.
diff --git a/kernel/Kconfig.dovetail b/kernel/Kconfig.dovetail
index 29c46e06e435..26478d9112d9 100644
--- a/kernel/Kconfig.dovetail
+++ b/kernel/Kconfig.dovetail
@@ -18,6 +18,20 @@ config DOVETAIL
 	  running a high-priority software core on the out-of-band
 	  pipeline stage (aka "dual kernel" configuration).
 
+config RV_DOVETAIL
+	bool "Runtime verification of the Dovetail interface"
+	depends on DOVETAIL
+	select RV
+	select RV_REACTORS
+	select RV_REACT_PRINTK
+	select RV_MON_DOVETAIL
+	help
+	  Enable the runtime verification monitors checking the contract
+	  between Dovetail and the companion core, with the printk reactor.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_dovetail.rst
+
 config DOVETAIL_LEGACY_SYSCALL_RANGE
        depends on DOVETAIL
        def_bool y
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..3f43cdfcbb32 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -54,6 +54,7 @@ config RV_PER_TASK_MONITORS
 	int "Maximum number of per-task monitor"
 	depends on RV
 	range 1 8
+	default 3 if RV_DOVETAIL
 	default 2
 	help
 	  This option configures the maximum number of per-task RV monitors that can run
@@ -83,6 +84,8 @@ source "kernel/trace/rv/monitors/deadline/Kconfig"
 source "kernel/trace/rv/monitors/nomiss/Kconfig"
 # Add new deadline monitors here
 
+source "kernel/trace/rv/monitors/dovetail/Kconfig"
+source "kernel/trace/rv/monitors/offstage/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 94498da35b37..a684b0c9af2f 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
+obj-$(CONFIG_RV_MON_DOVETAIL) += monitors/dovetail/dovetail.o
+obj-$(CONFIG_RV_MON_OFFSTAGE) += monitors/offstage/offstage.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/dovetail/Kconfig b/kernel/trace/rv/monitors/dovetail/Kconfig
new file mode 100644
index 000000000000..59faf165d0ec
--- /dev/null
+++ b/kernel/trace/rv/monitors/dovetail/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_DOVETAIL
+	depends on RV
+	depends on DOVETAIL
+	bool "dovetail monitor"
+	help
+	  Collection of per-task monitors checking that Dovetail and its
+	  companion core keep their contract: stage switches, out-of-band
+	  traps and signals. Enable this to enable all of them.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_dovetail.rst
diff --git a/kernel/trace/rv/monitors/dovetail/dovetail.c b/kernel/trace/rv/monitors/dovetail/dovetail.c
new file mode 100644
index 000000000000..c14e37d0ff17
--- /dev/null
+++ b/kernel/trace/rv/monitors/dovetail/dovetail.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dovetail: container for the Dovetail monitors.
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "dovetail"
+
+#include "dovetail.h"
+
+struct rv_monitor rv_dovetail = {
+	.name = "dovetail",
+	.description = "container for the Dovetail monitors",
+	.enable = NULL,
+	.disable = NULL,
+	.reset = NULL,
+	.enabled = 0,
+};
+
+static int __init register_dovetail(void)
+{
+	return rv_register_monitor(&rv_dovetail, NULL);
+}
+
+static void __exit unregister_dovetail(void)
+{
+	rv_unregister_monitor(&rv_dovetail);
+}
+
+module_init(register_dovetail);
+module_exit(unregister_dovetail);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Schaffner <tobias.schaffner@siemens.com>");
+MODULE_DESCRIPTION("dovetail: container for the Dovetail monitors");
diff --git a/kernel/trace/rv/monitors/dovetail/dovetail.h b/kernel/trace/rv/monitors/dovetail/dovetail.h
new file mode 100644
index 000000000000..279806cd8e00
--- /dev/null
+++ b/kernel/trace/rv/monitors/dovetail/dovetail.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_dovetail;
diff --git a/kernel/trace/rv/monitors/offstage/Kconfig b/kernel/trace/rv/monitors/offstage/Kconfig
new file mode 100644
index 000000000000..2b9c6869b315
--- /dev/null
+++ b/kernel/trace/rv/monitors/offstage/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_OFFSTAGE
+	depends on RV
+	depends on RV_MON_DOVETAIL
+	default y
+	select DA_MON_EVENTS_ID
+	bool "offstage monitor"
+	help
+	  Per-task monitor following which stage a dovetailed task runs on,
+	  in-band or out-of-band. It reports a task that Linux schedules, or
+	  that raises a signal on itself, while Dovetail has it out-of-band.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_dovetail.rst
diff --git a/kernel/trace/rv/monitors/offstage/offstage.c b/kernel/trace/rv/monitors/offstage/offstage.c
new file mode 100644
index 000000000000..940c5175e46d
--- /dev/null
+++ b/kernel/trace/rv/monitors/offstage/offstage.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * offstage: Linux leaves a task alone while it is out-of-band.
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+ */
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <linux/dovetail.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "offstage"
+
+#include <trace/events/dovetail.h>
+#include <trace/events/sched.h>
+#include <trace/events/signal.h>
+#include <rv_trace.h>
+#include <monitors/dovetail/dovetail.h>
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#include "offstage.h"
+#include <rv/da_monitor.h>
+
+static bool offstage_monitors_task(struct task_struct *p)
+{
+	return test_ti_local_flags(task_thread_info(p), _TLF_DOVETAIL);
+}
+
+static void handle_leave_inband(void *data, struct task_struct *p)
+{
+	da_handle_start_run_event(p, leave_inband_offstage);
+}
+
+static void handle_leave_oob(void *data, struct task_struct *p)
+{
+	da_handle_event(p, leave_oob_offstage);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	if (offstage_monitors_task(next))
+		da_handle_event(next, sched_in_offstage);
+}
+
+static void handle_signal_generate(void *data, int sig,
+				   struct kernel_siginfo *info,
+				   struct task_struct *task, int group,
+				   int result)
+{
+	if (task == current && offstage_monitors_task(task))
+		da_handle_event(task, signal_self_offstage);
+}
+
+static int enable_offstage(void)
+{
+	int retval;
+
+	retval = da_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("offstage", dovetail_leave_inband_tp, handle_leave_inband);
+	rv_attach_trace_probe("offstage", dovetail_leave_oob_tp, handle_leave_oob);
+	rv_attach_trace_probe("offstage", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("offstage", signal_generate, handle_signal_generate);
+
+	return 0;
+}
+
+static void disable_offstage(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("offstage", dovetail_leave_inband_tp, handle_leave_inband);
+	rv_detach_trace_probe("offstage", dovetail_leave_oob_tp, handle_leave_oob);
+	rv_detach_trace_probe("offstage", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("offstage", signal_generate, handle_signal_generate);
+
+	da_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "offstage",
+	.description = "Linux leaves a task alone while it is out-of-band",
+	.enable = enable_offstage,
+	.disable = disable_offstage,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_offstage(void)
+{
+	return rv_register_monitor(&rv_this, &rv_dovetail);
+}
+
+static void __exit unregister_offstage(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_offstage);
+module_exit(unregister_offstage);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Schaffner <tobias.schaffner@siemens.com>");
+MODULE_DESCRIPTION("offstage: Linux leaves a task alone while it is out-of-band");
diff --git a/kernel/trace/rv/monitors/offstage/offstage.h b/kernel/trace/rv/monitors/offstage/offstage.h
new file mode 100644
index 000000000000..2b8070ae6d5c
--- /dev/null
+++ b/kernel/trace/rv/monitors/offstage/offstage.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of offstage automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME offstage
+
+enum states_offstage {
+	inband_offstage,
+	oob_offstage,
+	state_max_offstage,
+};
+
+#define INVALID_STATE state_max_offstage
+
+enum events_offstage {
+	leave_inband_offstage,
+	leave_oob_offstage,
+	sched_in_offstage,
+	signal_self_offstage,
+	event_max_offstage,
+};
+
+struct automaton_offstage {
+	char *state_names[state_max_offstage];
+	char *event_names[event_max_offstage];
+	unsigned char function[state_max_offstage][event_max_offstage];
+	unsigned char initial_state;
+	bool final_states[state_max_offstage];
+};
+
+static const struct automaton_offstage automaton_offstage = {
+	.state_names = {
+		"inband",
+		"oob",
+	},
+	.event_names = {
+		"leave_inband",
+		"leave_oob",
+		"sched_in",
+		"signal_self",
+	},
+	.function = {
+		{
+			oob_offstage,
+			INVALID_STATE,
+			inband_offstage,
+			inband_offstage,
+		},
+		{
+			INVALID_STATE,
+			inband_offstage,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+	},
+	.initial_state = inband_offstage,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/offstage/offstage_trace.h b/kernel/trace/rv/monitors/offstage/offstage_trace.h
new file mode 100644
index 000000000000..275ba7c78914
--- /dev/null
+++ b/kernel/trace/rv/monitors/offstage/offstage_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_OFFSTAGE
+DEFINE_EVENT(event_da_monitor_id, event_offstage,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_offstage,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_OFFSTAGE */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 9622c269789c..9bda8ef3b96f 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -156,6 +156,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #include <monitors/snroc/snroc_trace.h>
 #include <monitors/nrp/nrp_trace.h>
 #include <monitors/sssw/sssw_trace.h>
+#include <monitors/offstage/offstage_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #ifdef CONFIG_HA_MON_EVENTS_ID
diff --git a/tools/verification/models/offstage.dot b/tools/verification/models/offstage.dot
new file mode 100644
index 000000000000..79f36efd430f
--- /dev/null
+++ b/tools/verification/models/offstage.dot
@@ -0,0 +1,14 @@
+digraph state_automaton {
+	{node [shape = plaintext, style=invis, label=""] "__init_inband"};
+	{node [shape = ellipse] "inband"};
+	{node [shape = plaintext] "oob"};
+	"__init_inband" -> "inband";
+	"inband" [label = "inband", color = green3];
+	"inband" -> "inband" [ label = "sched_in\nsignal_self" ];
+	"inband" -> "oob" [ label = "leave_inband" ];
+	"oob" -> "inband" [ label = "leave_oob" ];
+	{ rank = min ;
+		"__init_inband";
+		"inband";
+	}
+}
-- 
2.53.0

