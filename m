Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334124;
	b=SP/G5EDG+hgdsdGot8m8V0dyrL65ZHkYOMmZQbEFP906dfPsMaq7ukwwonmQnqdIJEgS
	 XQfVz0aEnUdiL5y8KNrgKsTHLDEtsCxTpvI4o6E8IpIJGgj2HvVojxhvayeKQWJ56C5x3
	 gJRRrYcopdiKNmLKWTxCv/+VrzzLElf2MsQFItTa4hJrcjU8H0UViWVpsp0WIjeq6w+mb
	 jJ1yJrfPkxaRgYmffQUM6xK5Ng5pJqnpoBNhhrXt8qTSb5wvj/mafORTg6QVovB+TqD6O
	 LDWlvAPG1R7odlMjjKQb67v8+VMipocqVLgVBDIkyJ/Bx/re3yeysXv8JGDSzzp05/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334124;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6jl/QOH6O8oMDdfEKwgof7vo8VIxMWwViSmA+7vP4bs=;
	b=5HdDKjhEsFrnj5JQLGqMpvxiYX88m5sjJ6kIAx1pbxkdDdNen4+agffqVu2MxUhPw3vx
	 CG2eTUsdu8/VqZfT9pVR4Fs6PSOz4GP+tklOD9INiKpFPsL1rb3T/RuaXn93Xx+fVPVxC
	 aoE5rD9AQn6bB9kTiFq5wxciFcPBK8NZaSYN/Q1ymTql0gst4wtcCN8gGqZX7vWMX1OoG
	 q8BxU7k3eUNB9CyPLcVHGvQC2mJLJQSy84C1K+ahI/CI1x+aDQ1nH3e/Li90gO/5/ix8J
	 apbJvC8z3jwrEvDPmgwcEKEoXNsMRYV/SsfYN/poVRlknkHXu6og3qCjQSFa5byqk4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=YTFQtuhW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C50606A327
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 18:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C50606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=YTFQtuhW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6qJy8es9Iv2bIiy8CBWqvZRAdwbDDwf5qTVwyv/eGpxFkZ8IvWWXaoNDMkqW4YdlW8JOXaPZhCwuPBax4QvA5XmcuydnN+dVGtywNlksMStUTn5g/GcTe1coS7opcsFtoNjUeu1MwPmc6bNPHbz0vIBZ9iQN/Xw0SiZOkoxCQKqtncTId0tQQqn/8XI3Q8aMN00OdBAIew2RMBom/3d8R2nVcFNkdYkaa+C/+98MYW6/xggxhHfNSJpQS0PSelvxEGx5ewEIiOL94IyBaIv8lfk1hebz6McOBYmi44K98avzqAymuLhhF/BGkZ9KFSN9z1vNMVCXCloTQScawB/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jl/QOH6O8oMDdfEKwgof7vo8VIxMWwViSmA+7vP4bs=;
 b=iviphFPe3S05m1SG5lIFAIW1q0c8i8JKkLKfFbfpjC9FlolUu/GX2qNT1/yMdY/4pp+MewDCQ2tWd8wvxHKYoTzAe1KkcbI5Y8OfWE36dwOyvVj+g+L8OhZqtlPtGhQ0O8MdX882oqHZcPOIowOOjNefo0bFHsH2y1gfD+XOD4E+u8chhvo9GoLltgBjNnOLLcBqRCdhW+3tw7i/iKcC98ldjYX6Tr7qT7/3d25WihqAX2kG0q5aPWSaJRv4hOGnjocjAR1/dAL1xGyWrsQz7FcvwE5VBK8cb3sRahGWWN7WJa2LKEwu6QGNlYfNxbHgf29r3OJw/GvA5tY3IfsO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jl/QOH6O8oMDdfEKwgof7vo8VIxMWwViSmA+7vP4bs=;
 b=YTFQtuhWQxCvr4FQ0S0to4O00Rsk6DYMGPtehOhXlGrL030jPddbaeq5MtO91i1gmqxeE8UwijrFu7TC4U3wJzxoaz5IROAyWyRZgsNkTis3o+pe/GEp61Qisq8eaOY6427j68mIdkXwnplQ1Pf4qoJrtVwG63RLaJ5bhfLDfLu6dlFc2UzF2P0AFa7acXlHqhiTE8tCDN7XPaZTpuYDfANWx4cZr3BZdRxaUMGPZbI+ItRZehVmeWtZF5ung0jbR9y888p61y17QldnynbFtAMmU/kl9lrfd2J8ABjABRAVaKQ07foYeKd63eBfdWRUeMDP2kNgPb2fVuSnhX0cJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AMCPR10MB992240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:781::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:08:40 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:08:40 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail 3/7] rv: add dovetail container and offstage monitor
Date: Tue, 10 Nov 2026 19:08:43 +0100
Message-ID: <20261110180847.633167-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180847.633167-1-tobias.schaffner@siemens.com>
References: <20261110180847.633167-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AMCPR10MB992240:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5e71ba-8add-4b84-2574-08df3f55a5e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261009223027099003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261009221227099003|261022075727099003|261021123027099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GNVu8vP+R4QBvO8cBz+rxQHANwrJ3TjbM487aJ0YCAFAxZTat+UwyCcqNhNH2PTPYp0C9hjUzacaHkNoFODVffv224hW42WFKxeqDT1WQq6BkjGxQnfj0j3fbGuWoLeayQu9uiRW90hNHuXS0sKpCdc6wqfWha6+OlsymPlQU22SznploOfosQGfIoD9FEhqaeWf8pmVV40fxX4HU9e+04n5NUKrasIT1kPC3LqlxFbVh2YYnkEnNBZYuRr7rbos92piOhQp9rhoOqSZfQiyCk2avPHEixub31/y/i0w1xVfthoiLwO1N9lhy2lsQQAIr37AO/dHbvaLnUmOFVzqyG2KRy4D+8C3pha8YNIfq+9RLm9GuUPstcD8CkvWWdoY0b2bJXV2K2a8RCLCv+G09pJgSpU/tknbHxwIlKK8GJWOt63dhLpgqIMj3/qFB/U3sKWzozTtx253qr4WYHmv7WAL7toPhDvb477ziNucFVV5MLXF0skYiEqoHnFFO48HLOwecEdhF44CkR9SOc3uGWvhGiX5tik8Vu7LJXcU1XWvpQBzuAFz1a3CJBcjE66A3dbzitzo70PhyphX/0E4EcsbWvl0BJGNRXq9D2q50qN84zszHe4d5X9ue9FfhBOqN6sxtNOLdceWwbh5aBf3zI4jP93iwtLKVsy9z1ejqJI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009221227099003)(261022075727099003)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlHOWlTFlPh21lAWIrnQl8U6OmFmgwhGu1ZKpR+3Lq4lARRolXgES2kxsVBi?=
 =?us-ascii?Q?s5H1nj1+dQxX8P1PnBUCvN2YGVpVNGU+tyQtymgHQY6RCRdSkBpZ99R9n3KA?=
 =?us-ascii?Q?pv7HvwNj4jjKdSTISv6TckvUne3Nmvo+PLLNdcsJf7ko4s1kHoErP9sQE6wR?=
 =?us-ascii?Q?voIAVvsRjsWEPhpRj0iKoHnmLmGa+dtlQjDqGeFNSDRfGPObYEb+Qhrpd3r9?=
 =?us-ascii?Q?bNnhANEat7uGseQvKvFA0onhS4jQR/yTxj2c7rXuYOu4mEpHWkCD2/o3k4kB?=
 =?us-ascii?Q?AwZUoadsNJbal6MUueKR13F8pua1LV+nIaSd/wPvwaB8cwnQtKRsHtza8fLU?=
 =?us-ascii?Q?4VZU28Rf2IVW9EyBdCxURdkTpt7axkXAYqYCIiAghxWucL35B43bOTJiyRUF?=
 =?us-ascii?Q?/qXmZBoAgh91iz0U1e50dhdgzFxpDHbzMzAXSjSfvpTfbVn1GUC5z98H4/ar?=
 =?us-ascii?Q?GOtqgoTYHuq2mGqMtdqbG3tkmye7R8ti+xDb9yWXlQva2q6v7qF7xwG39O0s?=
 =?us-ascii?Q?L2eoBGVlmJYGWZtDS/oUM4ePoSVlnn6oSCVTyVvwf3lu1stF3e8IedLawI6w?=
 =?us-ascii?Q?Ost3dhl8xc99iz+sUP+uT4KeM0qWpDwI/PlUXWSIPKTikhvKDV+wmd/IovBQ?=
 =?us-ascii?Q?2Mu0rvqe4igGSXW38iF92R4AaX8giOrTZrVESvo5GaPH7MtEONyzFdnNPet9?=
 =?us-ascii?Q?F42f3tNMsaJf0yN/7teOtEEqFmcqlFA5MUPsUAKWdD3ClmVvuImCmogUUK0N?=
 =?us-ascii?Q?1uF1nqfKgoIfZpEDw5LaR6B6MVdcZ8Tu6yJW26X7N2KKKqDR1EqbEW1/koog?=
 =?us-ascii?Q?pO+muXJPczkCi4R5CCCnE9X3u1CH03wDjkKE0Cgcd/Wk6OCvI9TbAZ4L222O?=
 =?us-ascii?Q?AUcrRS4baRxbMDk6MZ3MufOPmyF9+wqaF25XCcjTe5lRYyOrAmfF4HbBwVdj?=
 =?us-ascii?Q?+SfMpgC/Rk417AfLbhJTx99v6fCTSkdGxc6dCea9cPRR+2nOg+MxfkiKJVxI?=
 =?us-ascii?Q?WpgnHhz7To4efDqgGqBACE86kK6yLsoLQhVCMcJjbwIZBKKLsoubK6Tty2qY?=
 =?us-ascii?Q?bFFTGti0f5piwCJhbfrq79O161YReQURlbrNskTr6rwkDbkjNs3hNu1bYoJt?=
 =?us-ascii?Q?8epQ19oW+SKiyfEdhZSHsAyScZXblegRBRSnw2XIJw1UBh0kzJX1Sk67elsE?=
 =?us-ascii?Q?yMYLf+/9bX5rRaC1eqclSg0ho5RyCn5R/8trVi5TTo+kOXZzZ6D3tQs4fZyc?=
 =?us-ascii?Q?hQ6RrXf9no6AXk8I975CUaOZxMMlCD5ZgzRvC5TwPBDzwN/rWZ2ugCHg0KSi?=
 =?us-ascii?Q?MIRLoA0AY/U5h44BMZ4WyMMPxXibavSg2rtxeMGYN8eYAk/al+YBTEZardLw?=
 =?us-ascii?Q?0HxuEAHDUVIXhBOYKaWI5gulcxA3xuSA78PbC066f3TzAisqW8s39FTQMHmg?=
 =?us-ascii?Q?WU3I8gb+nQFiUHTRk/KMbgQ75wOrqlbFAerTxAVTZOUslaE6FLA5B1hDeEfS?=
 =?us-ascii?Q?pxIEzXyiBGey/gsLAk1d+OmlhKquIHe/wcJ6R6hRRjbCJ4PWOVoFWF9RnjKg?=
 =?us-ascii?Q?6S9F+4iQQ6Jp/+0pY1pizSJgQidBWQTRKckyTkWlzHSQjpwIPyvyLSDgM0si?=
 =?us-ascii?Q?FJgvZst+x02nmrIA3Oud6hFOSiQc8L3s21DwpQFd4m1MzJ3wVBDxUt9pIF6P?=
 =?us-ascii?Q?mlD3RoxJG1pHai/MmcoG0QdkQ7Qu32va7R9i747oV17lAlnR3rrnhxpRMDmc?=
 =?us-ascii?Q?a/98xKGyUPMSk3Sy1Mu4qBSifHGM2rA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5e71ba-8add-4b84-2574-08df3f55a5e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:08:40.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EbfKF8aaF0VZ+vv217oRD8piVD8Z14U5VzpsPzvzvVHd42mVij+MU3eGknQe/KjIeHXj5bPE4uyB4IuoAD+tUxIwauq3dSeuy/GtR4nkqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR10MB992240

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

